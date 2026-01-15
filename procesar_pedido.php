<?php
/**
 * PROCESAR_PEDIDO.PHP - VERSIÓN "SOLO REFERENCIA"
 * 1. Crea la cotización en Dolibarr.
 * 2. La valida para obtener el folio oficial.
 * 3. Manda correo con el folio (SIN PDF).
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
        CURLOPT_TIMEOUT => 30
    ];
    if ($method != "GET") {
        $opts[CURLOPT_CUSTOMREQUEST] = $method; 
        if ($data) $opts[CURLOPT_POSTFIELDS] = json_encode($data);
    }
    curl_setopt_array($curl, $opts);
    $result = curl_exec($curl);
    $http_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    curl_close($curl);
    
    // Si devuelve 404
    if ($http_code == 404) return null;
    return json_decode($result, true);
}

$input = json_decode(file_get_contents('php://input'), true);
if (!$input) { ob_end_clean(); echo json_encode(['success' => false, 'message' => 'Sin datos.']); exit; }

$tipo_accion = 'cotizacion'; 

// --- 1. GESTIÓN CLIENTE ---
$email_cliente = $input['email'];
$filtro_email = urlencode("t.email:like:'" . $email_cliente . "'");
$busqueda = callAPI('GET', $api_url . "/thirdparties?sqlfilters=($filtro_email)");

$direccion_extendida  = $input['direccion'] . "\nTel: " . $input['telefono'];

$datos_cliente = [
    'name'        => $input['cliente'], 
    'client'      => 2, // Prospecto
    'code_client' => -1,
    'email'       => $input['email'],
    'phone'       => $input['telefono'],
    'address'     => $direccion_extendida,
    'zip'         => $input['cp'],
    'town'        => $input['ciudad'],
    'idprof1'     => $input['rfc'],
    'country_id'  => defined('ID_PAIS_MEXICO') ? ID_PAIS_MEXICO : 154
];

$socid = 0;
if (is_array($busqueda) && count($busqueda) > 0) {
    $socid = $busqueda[0]['id'];
    callAPI('PUT', $api_url . "/thirdparties/" . $socid, $datos_cliente);
} else {
    $res_cliente = callAPI('POST', $api_url . "/thirdparties", $datos_cliente);
    $socid = (isset($res_cliente['id'])) ? $res_cliente['id'] : 0;
}

if ($socid <= 0) { ob_end_clean(); echo json_encode(['success' => false, 'message' => 'Error cliente.']); exit; }

// --- 2. CREAR DOCUMENTO ---
$fecha_entrega = strtotime($input['fecha']);
$endpoint_creacion = "/proposals";
$datos_doc = [
    'socid' => $socid, 
    'date' => time(), 
    'date_livraison' => $fecha_entrega,
    'note_public' => "Fecha del Evento: " . $input['fecha'],
    'action' => 'create'
];

$res_doc = callAPI('POST', $api_url . $endpoint_creacion, $datos_doc);
if (!isset($res_doc) || isset($res_doc['error'])) { ob_end_clean(); echo json_encode(['success' => false, 'message' => 'Error creando cotización.']); exit; }
$id_documento = is_numeric($res_doc) ? $res_doc : $res_doc['id'];

// --- 3. LÍNEAS (SIMPLE) ---
$endpoint_lineas = "/proposals/$id_documento/lines";
foreach ($input['items'] as $item) {
    $desc = (string)$item['nombre'];
    if (isset($item['esModular']) && $item['esModular']) $desc .= "\n(Medida: " . $item['cant'] . " m²)";
    
    // Enviamos como array (truco V2.8 que funciona)
    $payload = [[
        'fk_product' => (int)$item['id'], 
        'qty' => (double)$item['cant'],
        'subprice' => (double)$item['precio'], 
        'desc' => $desc,
        'tva_tx' => defined('IVA_TASA') ? IVA_TASA : 16,
        'product_type' => 0
    ]];
    callAPI('POST', $api_url . $endpoint_lineas, $payload);
}

// --- 4. VALIDAR (CRÍTICO PARA OBTENER FOLIO) ---
callAPI('POST', $api_url . "/proposals/$id_documento/validate", ["notrigger" => 0]);

// --- 5. OBTENER FOLIO FINAL ---
$doc_final = callAPI('GET', $api_url . "/proposals/$id_documento");
$ref_doc = $doc_final['ref'];

// --- (ZONA PDF ELIMINADA POR COMPLETO) ---

// --- 6. ENVÍO DE CORREO (SOLO TEXTO) ---
$mail = new PHPMailer(true);
$mail_enviado = false;
try {
    if (defined('SMTP_HOST')) {
        $mail->isSMTP(); $mail->Host = SMTP_HOST; $mail->SMTPAuth = true; $mail->Username = SMTP_USER; $mail->Password = SMTP_PASS;
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS; $mail->Port = SMTP_PORT;
        $mail->SMTPOptions = ['ssl' => ['verify_peer' => false, 'verify_peer_name' => false, 'allow_self_signed' => true]];
        
        $mail->setFrom(SMTP_USER, 'Carpas Montes');
        $mail->addAddress($input['email'], $input['cliente']); 
        
        // Mensaje Claro y Directo
        $cuerpo = "
        <div style='font-family: sans-serif; padding: 20px; border: 1px solid #ddd; border-radius: 8px; max-width: 600px;'>
            <h2 style='color: #0e4c81; margin-top:0;'>Solicitud Recibida</h2>
            <p>Hola <strong>{$input['cliente']}</strong>,</p>
            <p>Hemos registrado tu solicitud correctamente con el folio:</p>
            <div style='background: #f8f9fa; padding: 15px; text-align: center; margin: 20px 0; border: 1px dashed #0e4c81;'>
                <h1 style='margin:0; color: #333;'>{$ref_doc}</h1>
            </div>
            
            <div style='background: #fff3cd; color: #856404; padding: 15px; border-radius: 5px; font-size: 0.9em;'>
                <strong>⚠️ IMPORTANTE:</strong><br>
                Esta cotización <u>NO garantiza la disponibilidad ni la entrega</u>.
                <br><br>
                Un asesor se pondrá en contacto contigo para confirmar detalles y agendar una visita técnica si es necesario.
            </div>
            <hr>
            <small>Atte: Equipo Carpas Montes</small>
        </div>";

        $mail->isHTML(true);
        $mail->CharSet = 'UTF-8';
        $mail->Subject = 'Solicitud de Cotización - ' . $ref_doc;
        $mail->Body = $cuerpo;
        $mail->send();
        $mail_enviado = true;
    }
} catch (Exception $e) { }

ob_end_clean();
echo json_encode([
    'success' => true, 
    'ref' => $ref_doc, 
    'email_sent' => $mail_enviado,
    'pdf_url' => false // Confirmamos que NO hay PDF
]);
?>