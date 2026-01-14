<?php
/**
 * PROCESAR_PEDIDO.PHP - V25 (EXPLOSIÓN DE PAQUETES/KITS + PDF REINTENTOS)
 * Incluye: Desglose de insumos (sillas, moños, etc.) y selectores de color.
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
        CURLOPT_TIMEOUT => 30 // Timeout amplio por seguridad
    ];
    
    if ($method != "GET") {
        $opts[CURLOPT_CUSTOMREQUEST] = $method; 
        if ($data) $opts[CURLOPT_POSTFIELDS] = json_encode($data);
    }
    
    curl_setopt_array($curl, $opts);
    $result = curl_exec($curl);
    $http_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    curl_close($curl);
    
    return ['code' => $http_code, 'response' => json_decode($result, true)];
}

// --- DEFINICIÓN DE RECETAS (KITS VIRTUALES) ---
// Define aquí qué incluye cada paquete para el desglose automático
$recetas = [
    'vestida' => [ // Si el nombre del producto incluye "vestida"
        ['desc' => 'Mesa (Base)', 'qty' => 1],
        ['desc' => 'Sillas', 'qty' => 10],
        ['desc' => 'Mantel Blanco', 'qty' => 1],
        ['desc' => 'Cubre Mantel', 'qty' => 1, 'usa_color' => 'cubre'], // Usa el color seleccionado en frontend
        ['desc' => 'Moños', 'qty' => 10, 'usa_color' => 'mono']       // Usa el color seleccionado en frontend
    ],
    'sencilla' => [ // Si el nombre incluye "sencilla"
        ['desc' => 'Mesa (Base)', 'qty' => 1],
        ['desc' => 'Sillas Plástico', 'qty' => 10],
        ['desc' => 'Mantel Blanco', 'qty' => 1]
    ]
];

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

// Dirección extendida
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
    'note_public' => "Fecha del Evento: " . $input['fecha']
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

// --- 7. LÍNEAS (LÓGICA MEJORADA CON PAQUETES) ---
$endpoint_lineas = ($tipo_accion === 'pedido') ? "/orders/$id_documento/lines" : "/proposals/$id_documento/lines";

foreach ($input['items'] as $item) {
    
    // A. PREPARAR LÍNEA PRINCIPAL (LA QUE SE COBRA)
    $descripcion_extra = "";
    
    // Lógica Carpas (m2)
    $es_modular = (isset($item['esModular']) && $item['esModular'] == true);
    if (!$es_modular) {
        $keywords = ['carpa', 'toldo', 'lona', 'ancho', 'estructura'];
        foreach ($keywords as $kw) {
            if (stripos($item['nombre'], $kw) !== false) { $es_modular = true; break; }
        }
    }
    if ($es_modular) {
        $descripcion_extra .= "\n\n--- DETALLE TÉCNICO ---\nProducto Modular.\nPrecio calculado por Metros Cuadrados (m²).\nÁrea Total: " . $item['cant'] . " m².";
    }

    // Lógica Color Simple (Mantelería suelta)
    if (isset($item['color']) && !empty($item['color'])) {
        $descripcion_extra .= "\nColor seleccionado: " . $item['color'];
    }

    // Lógica Paquete (Informativo en la línea principal)
    if (isset($item['detallesPaquete'])) {
        $descripcion_extra .= "\nConfiguración: " . $item['detallesPaquete']['cubre'] . " (Cubre) / " . $item['detallesPaquete']['mono'] . " (Moño)";
    }

    // Enviar Línea Principal
    $linea_principal = [
        'fk_product' => (int)$item['id'], 
        'qty' => (double)$item['cant'],
        'subprice' => (double)$item['precio'], 
        'desc' => (string)$item['nombre'] . $descripcion_extra,
        'tva_tx' => defined('IVA_TASA') ? IVA_TASA : 16,
        'product_type' => 0
    ];
    callAPI('POST', $api_url . $endpoint_lineas, $linea_principal);

    // B. EXPLOSIÓN DE INSUMOS (ITEMS INCLUIDOS PRECIO $0)
    $nombre_lower = strtolower($item['nombre']);
    
    foreach ($recetas as $clave => $ingredientes) {
        if (strpos($nombre_lower, $clave) !== false) {
            
            // ¡Receta encontrada! Agregamos los componentes
            foreach ($ingredientes as $ingrediente) {
                
                $descripcion_insumo = "Incluye: " . $ingrediente['desc'];
                
                // Inyectar color específico del componente si la receta lo pide
                if (isset($ingrediente['usa_color']) && isset($item['detallesPaquete'])) {
                    $tipo_color = $ingrediente['usa_color']; // 'cubre' o 'mono'
                    if (isset($item['detallesPaquete'][$tipo_color])) {
                        $descripcion_insumo .= " (" . $item['detallesPaquete'][$tipo_color] . ")";
                    }
                }

                // Cantidad total = Cantidad de paquetes * Cantidad por paquete
                $cantidad_total = $item['cant'] * $ingrediente['qty'];

                $linea_insumo = [
                    'fk_product' => 0, // 0 = Producto libre (sin ID vinculado, o pon el ID real si lo tienes)
                    'qty' => (double)$cantidad_total,
                    'subprice' => 0, // PRECIO CERO (Incluido)
                    'desc' => $descripcion_insumo,
                    'tva_tx' => 0,
                    'product_type' => 0
                ];
                
                callAPI('POST', $api_url . $endpoint_lineas, $linea_insumo);
            }
            break; // Solo aplicamos una receta por producto
        }
    }
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

// --- 11. DESCARGA CON REINTENTOS (FIX 202/404) ---
$pdf_content = null;
$intentos = 0;
$max_intentos = 3; 
$url_descarga_api = $api_url . "/documents/download?modulepart=" . $modulo_part . "&original_file=" . urlencode($file_path);

while ($intentos < $max_intentos) {
    sleep(2); // Esperamos 2 segundos
    
    $call_descarga = callAPI('GET', $url_descarga_api);
    $res_descarga = $call_descarga['response'];
    $http_code = $call_descarga['code'];

    if ($http_code == 200 && isset($res_descarga['content'])) {
        $pdf_content = base64_decode($res_descarga['content']);
        break; 
    }
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

        if ($pdf_content) {
            $mail->addStringAttachment($pdf_content, $ref_doc . ".pdf");
        }

        $mail->isHTML(true);
        $mail->CharSet = 'UTF-8';
        $mail->Subject = 'Pedido ' . $ref_doc;
        
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

echo json_encode([
    'success' => true, 
    'ref' => $ref_doc,
    'email_sent' => $mail_enviado,
    'pdf_url' => "ver_pdf.php?ref=" . $ref_doc . "&tipo=" . $tipo_accion
]);
?>