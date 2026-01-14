<?php
/**
 * PROCESAR_PEDIDO.PHP - V20 (CON REINTENTOS AUTOMÁTICOS PARA PDF)
 * Soluciona el error 202/404 esperando a que Dolibarr termine de crear el archivo.
 */

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

// 1. CARGAMOS CONFIGURACIÓN
require_once 'config.php';

// 2. MAPEO DE VARIABLES
$api_url = DOL_BASE_URL; 
$api_key = DOL_API_KEY;

// PREVENIR BASURA EN EL JSON
ob_start();
header('Content-Type: application/json');

// --- 3. HELPER API ---
function callAPI($method, $url, $data = false) {
    global $api_key; 
    $curl = curl_init();
    $opts = [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => [
            "DOLAPIKEY: $api_key", 
            "Content-Type: application/json", 
            "Accept: application/json"
        ],
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_TIMEOUT => 30 // Aumentamos timeout por seguridad
    ];
    
    if ($method != "GET") {
        $opts[CURLOPT_CUSTOMREQUEST] = $method; 
        if ($data) $opts[CURLOPT_POSTFIELDS] = json_encode($data);
    }
    
    curl_setopt_array($curl, $opts);
    $result = curl_exec($curl);
    $http_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    curl_close($curl);
    
    // Devolvemos tanto el código como la respuesta para manejar el 202
    return ['code' => $http_code, 'response' => json_decode($result, true)];
}

// --- 4. INPUT ---
$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    ob_end_clean();
    echo json_encode(['success' => false, 'message' => 'Sin datos recibidos.']);
    exit;
}

$tipo_accion = isset($input['tipo']) ? $input['tipo'] : 'cotizacion';

// --- 5. GESTIÓN CLIENTE ---
$socid = 0;
$email_cliente = $input['email'];
$filtro_email = urlencode("t.email:like:'" . $email_cliente . "'");
$call_busqueda = callAPI('GET', $api_url . "/thirdparties?sqlfilters=($filtro_email)");
$busqueda = $call_busqueda['response'];

// Dirección extendida para el PDF
$direccion_extendida  = $input['direccion'];
$direccion_extendida .= "\nTel: " . $input['telefono'];
$direccion_extendida .= "\nEmail: " . $input['email'];

$datos_cliente_form = [
    'name'        => $input['cliente'], 
    'email'       => $input['email'],
    'phone'       => $input['telefono'],
    'address'     => $direccion_extendida, 
    'zip'         => $input['cp'],
    'town'        => $input['ciudad'],
    'idprof1'     => $input['rfc'],
    'country_id'  => defined('ID_PAIS_MEXICO') ? ID_PAIS_MEXICO : 154
];

if (is_array($busqueda) && count($busqueda) > 0) {
    $socid = $busqueda[0]['id'];
    callAPI('PUT', $api_url . "/thirdparties/" . $socid, $datos_cliente_form);
} else {
    $datos_cliente_form['client'] = 1; 
    $datos_cliente_form['code_client'] = -1;
    $call_nuevo = callAPI('POST', $api_url . "/thirdparties", $datos_cliente_form);
    $nuevo_cliente = $call_nuevo['response'];
    if(isset($nuevo_cliente['id'])) {
        $socid = $nuevo_cliente['id'];
    } else {
        $socid = (isset($nuevo_cliente) && is_numeric($nuevo_cliente)) ? $nuevo_cliente : 0;
    }
}

if ($socid <= 0) { ob_end_clean(); echo json_encode(['success' => false, 'message' => 'Error cliente.']); exit; }

// --- 6. CABECERA ---
$fecha_entrega = strtotime($input['fecha']);
$endpoint_creacion = ($tipo_accion === 'pedido') ? "/orders" : "/proposals";
$datos_doc = [
    'socid' => $socid, 
    'date' => time(), 
    'date_livraison' => $fecha_entrega,
    'note_public' => "📅 Fecha del Evento: " . $input['fecha']
];

if ($tipo_accion === 'pedido') {
    $datos_doc['type'] = 0; 
    $datos_doc['status'] = 0; 
} else {
    $datos_doc['action'] = 'create';
}

$call_doc = callAPI('POST', $api_url . $endpoint_creacion, $datos_doc);
$res_doc = $call_doc['response'];

if (!isset($res_doc) || isset($res_doc['error'])) { ob_end_clean(); echo json_encode(['success' => false, 'message' => 'Error creando Doc.']); exit; }
$id_documento = is_numeric($res_doc) ? $res_doc : $res_doc['id'];

// --- 7. LÍNEAS ---
$endpoint_lineas = ($tipo_accion === 'pedido') ? "/orders/$id_documento/lines" : "/proposals/$id_documento/lines";

foreach ($input['items'] as $item) {
    $es_modular = (isset($item['esModular']) && $item['esModular'] == true);
    if (!$es_modular) {
        $keywords = ['carpa', 'toldo', 'lona', 'ancho', 'estructura'];
        foreach ($keywords as $kw) {
            if (stripos($item['nombre'], $kw) !== false) { $es_modular = true; break; }
        }
    }

    $descripcion_extra = "";
    if ($es_modular) {
        $descripcion_extra = "\n\n--- DETALLE TÉCNICO ---\nProducto Modular/Estructural.\nPrecio calculado por Metros Cuadrados (m²).\nÁrea Total: " . $item['cant'] . " m².";
    }

    $linea = [
        'fk_product' => (int)$item['id'], 
        'qty' => (double)$item['cant'],
        'subprice' => (double)$item['precio'], 
        'desc' => (string)$item['nombre'] . $descripcion_extra,
        'tva_tx' => defined('IVA_TASA') ? IVA_TASA : 16,
        'product_type' => 0
    ];
    $payload = ($tipo_accion === 'pedido') ? $linea : [$linea];
    callAPI('POST', $api_url . $endpoint_lineas, $payload);
}

// --- 8. VALIDAR ---
$endpoint_val = ($tipo_accion === 'pedido') ? "/orders/$id_documento/validate" : "/proposals/$id_documento/validate";
$params_val = ["notrigger" => 0];
if ($tipo_accion === 'pedido') {
    $call_alm = callAPI('GET', $api_url . "/warehouses?limit=1");
    $almacenes = $call_alm['response'];
    $id_alm = (is_array($almacenes) && count($almacenes) > 0) ? $almacenes[0]['id'] : 0;
    $params_val["idwarehouse"] = $id_alm;
}
callAPI('POST', $api_url . $endpoint_val, $params_val);

// --- 9. OBTENER REFERENCIA ---
$endpoint_get = ($tipo_accion === 'pedido') ? "/orders/$id_documento" : "/proposals/$id_documento";
$call_final = callAPI('GET', $api_url . $endpoint_get);
$doc_final = $call_final['response'];
$ref_doc = $doc_final['ref'];

// --- 10. GENERAR PDF (BUILDDOC) ---
$modulo_part = ($tipo_accion === 'pedido') ? "order" : "proposal";
$modelo_pdf  = ($tipo_accion === 'pedido') ? "eratosthene" : "azur";
$file_path   = $ref_doc . "/" . $ref_doc . ".pdf";

$build_data = ["modulepart" => $modulo_part, "original_file" => $file_path, "doctemplate" => $modelo_pdf, "langcode" => "es_MX"];
callAPI('PUT', $api_url . "/documents/builddoc", $build_data);

// --- 11. DESCARGA CON REINTENTOS (LA SOLUCIÓN AL ERROR 202) ---
$pdf_content = null;
$intentos = 0;
$max_intentos = 3; // Intentaremos 3 veces
$url_descarga_api = $api_url . "/documents/download?modulepart=" . $modulo_part . "&original_file=" . urlencode($file_path);

while ($intentos < $max_intentos) {
    sleep(2); // Esperamos 2 segundos antes de cada intento
    
    $call_descarga = callAPI('GET', $url_descarga_api);
    $res_descarga = $call_descarga['response'];
    $http_code = $call_descarga['code'];

    // Si es exitoso (200) y tiene contenido, salimos del bucle
    if ($http_code == 200 && isset($res_descarga['content'])) {
        $pdf_content = base64_decode($res_descarga['content']);
        break; 
    }
    // Si no, seguimos intentando...
    $intentos++;
}

// --- 12. ENVIAR EMAIL ---
$mail = new PHPMailer(true);
$mail_enviado = false;

try {
    if (defined('SMTP_HOST')) {
        $mail->isSMTP();
        $mail->Host = SMTP_HOST; $mail->SMTPAuth = true; $mail->Username = SMTP_USER; $mail->Password = SMTP_PASS;
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS; $mail->Port = SMTP_PORT;
        $mail->SMTPOptions = ['ssl' => ['verify_peer' => false, 'verify_peer_name' => false, 'allow_self_signed' => true]];

        $mail->setFrom(SMTP_USER, 'Carpas Montes');
        $mail->addAddress($input['email'], $input['cliente']); 

        // Solo adjuntamos si logramos descargar el PDF
        if ($pdf_content) {
            $mail->addStringAttachment($pdf_content, $ref_doc . ".pdf");
        }

        $mail->isHTML(true);
        $mail->CharSet = 'UTF-8';
        $mail->Subject = 'Carpas Montes: Documento ' . $ref_doc;
        
        $mensaje_html = "<div style='font-family: Arial; padding: 20px;'><h2 style='color: #0e4c81;'>Gracias por tu preferencia</h2><p>Hola {$input['cliente']}, adjunto encontrarás tu documento <strong>$ref_doc</strong>.</p>";
        
        if (!$pdf_content) {
            $mensaje_html .= "<p style='color: orange;'>Nota: El PDF se está generando y no pudo adjuntarse. Por favor descárgalo desde el enlace en la web.</p>";
        }
        
        $mensaje_html .= "</div>";
        $mail->Body = $mensaje_html;
        
        $mail->send();
        $mail_enviado = true;
    }
} catch (Exception $e) { }

ob_end_clean();

// Respondemos al frontend (que abrirá ver_pdf.php)
// Como ya esperamos aquí, es muy probable que ver_pdf.php también funcione a la primera.
echo json_encode([
    'success' => true, 
    'ref' => $ref_doc,
    'email_sent' => $mail_enviado,
    'pdf_url' => "ver_pdf.php?ref=" . $ref_doc . "&tipo=" . $tipo_accion
]);
?>