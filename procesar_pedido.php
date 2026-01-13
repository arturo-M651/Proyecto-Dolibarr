<?php
/**
 * PROCESAR_PEDIDO.PHP - V2.8 (FIX: DETECTA CARPAS POR NOMBRE)
 */

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

require_once 'config.php';

$api_url = DOL_BASE_URL; 
$api_key = DOL_API_KEY;

ob_start();
header('Content-Type: application/json');

function callAPI($method, $url, $data = false) {
    global $api_key; 
    $curl = curl_init();
    $opts = [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => ["DOLAPIKEY: $api_key", "Content-Type: application/json", "Accept: application/json"],
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_TIMEOUT => 15
    ];
    if ($method != "GET") {
        $opts[CURLOPT_CUSTOMREQUEST] = $method; 
        if ($data) $opts[CURLOPT_POSTFIELDS] = json_encode($data);
    }
    curl_setopt_array($curl, $opts);
    $result = curl_exec($curl);
    $http_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    curl_close($curl);
    if ($http_code == 404) return null;
    return json_decode($result, true);
}

$input = json_decode(file_get_contents('php://input'), true);
if (!$input) { ob_end_clean(); echo json_encode(['success' => false, 'message' => 'Sin datos.']); exit; }

$tipo_accion = isset($input['tipo']) ? $input['tipo'] : 'cotizacion';

// --- GESTIÓN CLIENTE ---
$socid = 0;
$email_cliente = $input['email'];
$filtro_email = urlencode("t.email:like:'" . $email_cliente . "'");
$busqueda = callAPI('GET', $api_url . "/thirdparties?sqlfilters=($filtro_email)");

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
    $nuevo_cliente = callAPI('POST', $api_url . "/thirdparties", $datos_cliente_form);
    if(isset($nuevo_cliente['id'])) {
        $socid = $nuevo_cliente['id'];
    } else {
        $socid = (isset($nuevo_cliente) && is_numeric($nuevo_cliente)) ? $nuevo_cliente : 0;
    }
}

if ($socid <= 0) { ob_end_clean(); echo json_encode(['success' => false, 'message' => 'Error cliente.']); exit; }

// --- CABECERA ---
$fecha_entrega = strtotime($input['fecha']);
$endpoint_creacion = ($tipo_accion === 'pedido') ? "/orders" : "/proposals";

$nota_publica = "Fecha del Evento: " . $input['fecha']; 

$datos_doc = [
    'socid' => $socid, 
    'date' => time(), 
    'date_livraison' => $fecha_entrega,
    'note_public' => $nota_publica
];

if ($tipo_accion === 'pedido') {
    $datos_doc['type'] = 0; 
    $datos_doc['status'] = 0; 
} else {
    $datos_doc['action'] = 'create';
}

$res_doc = callAPI('POST', $api_url . $endpoint_creacion, $datos_doc);
if (!isset($res_doc) || isset($res_doc['error'])) { ob_end_clean(); echo json_encode(['success' => false, 'message' => 'Error doc.']); exit; }
$id_documento = is_numeric($res_doc) ? $res_doc : $res_doc['id'];

// --- LÍNEAS (LÓGICA MEJORADA) ---
$endpoint_lineas = ($tipo_accion === 'pedido') ? "/orders/$id_documento/lines" : "/proposals/$id_documento/lines";

foreach ($input['items'] as $item) {
    
    // DETECCIÓN INTELIGENTE: Si tiene bandera o si el nombre suena a Carpa/Toldo
    $es_modular = (isset($item['esModular']) && $item['esModular'] == true);
    
    if (!$es_modular) {
        // Buscamos palabras clave en el nombre por si fue "Agregado Rápido"
        $keywords = ['Carpa', 'Toldo', 'Lona', 'Ancho', 'Estructura'];
        foreach ($keywords as $kw) {
            if (stripos($item['nombre'], $kw) !== false) {
                $es_modular = true;
                break;
            }
        }
    }

    $descripcion_extra = "";
    if ($es_modular) {
        $descripcion_extra = "\n\n--- DETALLE TÉCNICO ---\n";
        $descripcion_extra .= "Producto Estructural / Modular.\n";
        $descripcion_extra .= "Precio calculado por Metros Cuadrados (m²).\n";
        $descripcion_extra .= "Área Total: " . $item['cant'] . " m².";
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

// --- VALIDAR ---
$endpoint_val = ($tipo_accion === 'pedido') ? "/orders/$id_documento/validate" : "/proposals/$id_documento/validate";
$params_val = ["notrigger" => 0];
if ($tipo_accion === 'pedido') {
    $almacenes = callAPI('GET', $api_url . "/warehouses?limit=1");
    $id_alm = (is_array($almacenes) && count($almacenes) > 0) ? $almacenes[0]['id'] : 0;
    $params_val["idwarehouse"] = $id_alm;
}
callAPI('POST', $api_url . $endpoint_val, $params_val);

// --- PDF ---
$endpoint_get = ($tipo_accion === 'pedido') ? "/orders/$id_documento" : "/proposals/$id_documento";
$doc_final = callAPI('GET', $api_url . $endpoint_get);
$ref_doc = $doc_final['ref'];

$modulo_part = ($tipo_accion === 'pedido') ? "order" : "proposal";
$modelo_pdf  = ($tipo_accion === 'pedido') ? "eratosthene" : "azur";
$file_path   = $ref_doc . "/" . $ref_doc . ".pdf";

$build_data = ["modulepart" => $modulo_part, "original_file" => $file_path, "doctemplate" => $modelo_pdf, "langcode" => "es_MX"];
callAPI('PUT', $api_url . "/documents/builddoc", $build_data);
sleep(1);

// --- EMAIL ---
$mail = new PHPMailer(true);
$mail_enviado = false;
try {
    if (defined('SMTP_HOST')) {
        $mail->isSMTP(); $mail->Host = SMTP_HOST; $mail->SMTPAuth = true; $mail->Username = SMTP_USER; $mail->Password = SMTP_PASS;
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS; $mail->Port = SMTP_PORT;
        $mail->SMTPOptions = ['ssl' => ['verify_peer' => false, 'verify_peer_name' => false, 'allow_self_signed' => true]];
        $mail->setFrom(SMTP_USER, 'Carpas Montes'); $mail->addAddress($input['email'], $input['cliente']); 
        $url_descarga_api = $api_url . "/documents/download?modulepart=" . $modulo_part . "&original_file=" . urlencode($file_path);
        $res_descarga = callAPI('GET', $url_descarga_api);
        if (isset($res_descarga['content'])) { $pdf_content = base64_decode($res_descarga['content']); $mail->addStringAttachment($pdf_content, $ref_doc . ".pdf"); }
        $mail->isHTML(true); $mail->CharSet = 'UTF-8'; $mail->Subject = 'Pedido ' . $ref_doc; $mail->Body = "<p>Hola {$input['cliente']}, adjunto tu documento.</p>";
        $mail->send(); $mail_enviado = true;
    }
} catch (Exception $e) { }

ob_end_clean();
echo json_encode(['success' => true, 'ref' => $ref_doc, 'email_sent' => $mail_enviado, 'pdf_url' => "ver_pdf.php?ref=" . $ref_doc . "&tipo=" . $tipo_accion]);
?>