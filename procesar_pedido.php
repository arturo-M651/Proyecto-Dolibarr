<?php
/**
 * PROCESAR_PEDIDO.PHP - VERSIÓN FINAL SEGURA (CONFIG EXTERNO)
 */

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

// 1. CARGAMOS CONFIGURACIÓN
require_once 'config.php';

// 2. MAPEO DE VARIABLES (¡ESTO ES LO QUE FALTABA!)
// Convertimos las constantes de config.php a variables locales
$api_url = DOL_BASE_URL; 
$api_key = DOL_API_KEY;

// PREVENIR BASURA EN EL JSON
ob_start();

header('Content-Type: application/json');

// --- 3. HELPER API ---
function callAPI($method, $url, $data = false) {
    global $api_key; // Ahora sí funcionará porque definimos $api_key arriba
    $curl = curl_init();
    $opts = [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => [
            "DOLAPIKEY: $api_key", 
            "Content-Type: application/json", 
            "Accept: application/json"
        ],
        CURLOPT_SSL_VERIFYPEER => false
    ];
    
    if ($method != "GET") {
        $opts[CURLOPT_CUSTOMREQUEST] = $method; 
        if ($data) $opts[CURLOPT_POSTFIELDS] = json_encode($data);
    }
    
    curl_setopt_array($curl, $opts);
    $result = curl_exec($curl);
    curl_close($curl);
    return json_decode($result, true);
}

// --- 4. INPUT ---
$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    ob_end_clean();
    echo json_encode(['success' => false, 'message' => 'Sin datos.']);
    exit;
}

$tipo_accion = isset($input['tipo']) ? $input['tipo'] : 'cotizacion';

// --- 5. TERCERO ---
$datos_cliente = [
    'name'        => $input['cliente'], 
    'client'      => 1, 
    'code_client' => -1,
    'email'       => $input['email'],
    'phone'       => $input['telefono'],
    'address'     => $input['direccion'],
    'zip'         => $input['cp'],
    'town'        => $input['ciudad'],
    'idprof1'     => $input['rfc'],
    'country_id'  => ID_PAIS_MEXICO // Usando la constante de config.php
];
$socid = callAPI('POST', $api_url . "/thirdparties", $datos_cliente);

// --- 6. CABECERA DOCUMENTO ---
$fecha_entrega = strtotime($input['fecha']);
$endpoint_creacion = ($tipo_accion === 'pedido') ? "/orders" : "/proposals";
$datos_doc = [
    'socid' => $socid, 
    'date' => time(), 
    'date_livraison' => $fecha_entrega
];

if ($tipo_accion === 'pedido') {
    $datos_doc['type'] = 0; 
    $datos_doc['note_public'] = "Pedido Web";
    $datos_doc['status'] = 0; 
} else {
    $datos_doc['action'] = 'create';
}

$res_doc = callAPI('POST', $api_url . $endpoint_creacion, $datos_doc);
if (isset($res_doc['error'])) {
    ob_end_clean();
    echo json_encode(['success' => false, 'message' => 'Error creando Doc.']);
    exit;
}
$id_documento = $res_doc; 

// --- 7. LÍNEAS ---
$endpoint_lineas = ($tipo_accion === 'pedido') ? "/orders/$id_documento/lines" : "/proposals/$id_documento/lines";
foreach ($input['items'] as $item) {
    $linea = [
        'fk_product' => (int)$item['id'], 
        'qty' => (double)$item['cant'],
        'subprice' => (double)$item['precio'], 
        'desc' => (string)$item['nombre'],
        'tva_tx' => IVA_TASA, // Usando constante de config.php
        'product_type' => 0
    ];
    $payload = ($tipo_accion === 'pedido') ? $linea : [$linea];
    callAPI('POST', $api_url . $endpoint_lineas, $payload);
}

// --- 8. VALIDAR ---
$endpoint_val = ($tipo_accion === 'pedido') ? "/orders/$id_documento/validate" : "/proposals/$id_documento/validate";
$params_val = [];
if ($tipo_accion === 'pedido') {
    $almacenes = callAPI('GET', $api_url . "/warehouses?limit=1");
    $id_alm = (is_array($almacenes) && count($almacenes) > 0) ? $almacenes[0]['id'] : 0;
    $params_val = ["idwarehouse" => $id_alm];
}
callAPI('POST', $api_url . $endpoint_val, $params_val);

// --- 9. GET REF ---
$endpoint_get = ($tipo_accion === 'pedido') ? "/orders/$id_documento" : "/proposals/$id_documento";
$doc_final = callAPI('GET', $api_url . $endpoint_get);

// --- 10. GENERAR PDF (BUILDDOC) ---
$modulo_part = ($tipo_accion === 'pedido') ? "order" : "proposal";
$modelo_pdf  = ($tipo_accion === 'pedido') ? "einstein" : "azur";
$file_path   = $doc_final['ref'] . "/" . $doc_final['ref'] . ".pdf";

$build_data = [
    "modulepart" => $modulo_part,
    "original_file" => $file_path,
    "doctemplate" => $modelo_pdf,
    "langcode" => "es_MX"
];
callAPI('PUT', $api_url . "/documents/builddoc", $build_data);
sleep(1); 

// --- 11. ENVÍO DE CORREO (USANDO CONFIG.PHP) ---
$mail = new PHPMailer(true);
try {
    $mail->isSMTP();
    // AQUI USAMOS LAS CONSTANTES SEGURAS
    $mail->Host       = SMTP_HOST;
    $mail->SMTPAuth   = true;
    $mail->Username   = SMTP_USER; 
    $mail->Password   = SMTP_PASS; 
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
    $mail->Port       = SMTP_PORT;
    $mail->SMTPOptions = ['ssl' => ['verify_peer' => false, 'verify_peer_name' => false, 'allow_self_signed' => true]];

    $mail->setFrom(SMTP_USER, 'Carpas Montes');
    $mail->addAddress($input['email'], $input['cliente']); 

    // Descarga y adjunto
    $url_descarga = $api_url . "/documents/download?modulepart=" . $modulo_part . "&original_file=" . urlencode($file_path);
    $res_descarga = callAPI('GET', $url_descarga);

    if (isset($res_descarga['content'])) {
        $pdf_content = base64_decode($res_descarga['content']);
        $mail->addStringAttachment($pdf_content, $doc_final['ref'] . ".pdf");
    }

    $mail->isHTML(true);
    $mail->CharSet = 'UTF-8';
    $mail->Subject = 'Confirmación ' . ucfirst($tipo_accion) . ' - ' . $doc_final['ref'];
    $mail->Body    = "
        <div style='font-family: sans-serif; padding: 20px; border: 1px solid #ddd; border-radius: 10px;'>
            <h2 style='color: #0d6efd;'>¡Gracias por tu compra!</h2>
            <p>Hola <strong>{$input['cliente']}</strong>,</p>
            <p>Adjunto encontrarás tu documento <strong>{$doc_final['ref']}</strong>.</p>
            <hr>
            <small>Atte: Carpas Montes</small>
        </div>
    ";

    $mail->send();

} catch (Exception $e) { }

ob_end_clean();

echo json_encode([
    'success' => true, 
    'ref' => $doc_final['ref'],
    'message' => 'Proceso completado.'
]);
?>