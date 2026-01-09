<?php
/**
 * PROCESAR_PEDIDO.PHP - VERSIÓN FINAL (ADJUNTO VÍA API)
 */

// Carga de librerías de correo
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

// PREVENIR BASURA EN EL JSON
ob_start();

header('Content-Type: application/json');

// --- 1. CONFIGURACIÓN ---
$api_url = "http://localhost/dolibarr/htdocs/api/index.php"; 
$api_key = "55W05PsnTJuJRFg8lckZZ7hx10lM0Rz9"; 

// --- 2. HELPER API ---
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

// --- 3. INPUT ---
$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    ob_end_clean();
    echo json_encode(['success' => false, 'message' => 'Sin datos.']);
    exit;
}

$tipo_accion = isset($input['tipo']) ? $input['tipo'] : 'cotizacion';

// --- 4. TERCERO ---
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
    'country_id'  => 154 
];
$socid = callAPI('POST', $api_url . "/thirdparties", $datos_cliente);

// --- 5. CABECERA DOCUMENTO ---
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

// --- 6. LÍNEAS ---
$endpoint_lineas = ($tipo_accion === 'pedido') ? "/orders/$id_documento/lines" : "/proposals/$id_documento/lines";
foreach ($input['items'] as $item) {
    $linea = [
        'fk_product' => (int)$item['id'], 
        'qty' => (double)$item['cant'],
        'subprice' => (double)$item['precio'], 
        'desc' => (string)$item['nombre'],
        'tva_tx' => 16.0, 
        'product_type' => 0
    ];
    $payload = ($tipo_accion === 'pedido') ? $linea : [$linea];
    callAPI('POST', $api_url . $endpoint_lineas, $payload);
}

// --- 7. VALIDAR ---
$endpoint_val = ($tipo_accion === 'pedido') ? "/orders/$id_documento/validate" : "/proposals/$id_documento/validate";
$params_val = [];
if ($tipo_accion === 'pedido') {
    $almacenes = callAPI('GET', $api_url . "/warehouses?limit=1");
    $id_alm = (is_array($almacenes) && count($almacenes) > 0) ? $almacenes[0]['id'] : 0;
    $params_val = ["idwarehouse" => $id_alm];
}
callAPI('POST', $api_url . $endpoint_val, $params_val);

// --- 8. GET REF ---
$endpoint_get = ($tipo_accion === 'pedido') ? "/orders/$id_documento" : "/proposals/$id_documento";
$doc_final = callAPI('GET', $api_url . $endpoint_get);

// --- 9. GENERAR PDF (BUILDDOC) ---
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
sleep(1); // Breve espera técnica

// --- 10. ENVÍO DE CORREO (CON ADJUNTO VÍA API) ---
$mail = new PHPMailer(true);
try {
    // Configuración SMTP
    $mail->isSMTP();
    $mail->Host       = 'smtp.gmail.com';
    $mail->SMTPAuth   = true;
    $mail->Username   = 'arturomontes49@gmail.com'; // <--- TU EMAIL
    $mail->Password   = 'eosb nwqd wcja edbq';      // <--- TU APP PASSWORD
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
    $mail->Port       = 465;
    $mail->SMTPOptions = ['ssl' => ['verify_peer' => false, 'verify_peer_name' => false, 'allow_self_signed' => true]];

    $mail->setFrom('arturomontes49@gmail.com', 'Carpas Montes');
    $mail->addAddress($input['email'], $input['cliente']); 

    // --- MAGIA AQUÍ: DESCARGAMOS EL PDF DE LA API Y LO ADJUNTAMOS EN MEMORIA ---
    // Endpoint para descargar documentos
    $url_descarga = $api_url . "/documents/download?modulepart=" . $modulo_part . "&original_file=" . urlencode($file_path);
    
    // Obtenemos el JSON con el base64
    $res_descarga = callAPI('GET', $url_descarga);

    if (isset($res_descarga['content'])) {
        // Decodificamos el contenido
        $pdf_content = base64_decode($res_descarga['content']);
        // Lo adjuntamos como cadena binaria (sin ruta fisica)
        $mail->addStringAttachment($pdf_content, $doc_final['ref'] . ".pdf");
    }

    // Contenido del correo
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

} catch (Exception $e) {
    // Ignoramos errores de correo para no bloquear la respuesta web
}

ob_end_clean();

echo json_encode([
    'success' => true, 
    'ref' => $doc_final['ref'],
    'message' => 'Proceso completado.'
]);
?>