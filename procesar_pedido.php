<?php
/**
 * PROCESAR_PEDIDO.PHP - V65 (CON VALIDACIÓN DE FECHA SERVIDOR)
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
    
    if ($http_code == 404) return null;
    return json_decode($result, true);
}

$input = json_decode(file_get_contents('php://input'), true);
if (!$input) { ob_end_clean(); echo json_encode(['success' => false, 'message' => 'Sin datos.']); exit; }

$tipo_accion = 'cotizacion'; 

// --- 0. VALIDACIÓN DE FECHAS (SEGURIDAD) ---
$fecha_solicitada = strtotime($input['fecha']);
// Mínimo 3 días de colchón desde HOY
$fecha_minima = strtotime('+3 days 00:00:00'); 

if ($fecha_solicitada < $fecha_minima) {
    ob_end_clean();
    echo json_encode([
        'success' => false, 
        'message' => 'Error: La fecha del evento es demasiado próxima. Requerimos mínimo 3 días de anticipación.'
    ]);
    exit;
}

// --- 1. GESTIÓN CLIENTE ---
$email_cliente = $input['email'];
$filtro_email = urlencode("t.email:like:'" . $email_cliente . "'");
$busqueda = callAPI('GET', $api_url . "/thirdparties?sqlfilters=($filtro_email)");

$typent_id  = isset($input['typent_id']) ? (int)$input['typent_id'] : 8; 
$tipo_label = isset($input['tipo_label']) ? $input['tipo_label'] : '';

$direccion_extendida  = $input['direccion'] . "\nTel: " . $input['telefono'];
$direccion_extendida .= "\n[Cliente: " . $tipo_label . "]";

$datos_cliente = [
    'name'         => $input['cliente'], 
    'client'       => 2, 
    'code_client'  => -1,
    'email'        => $input['email'],
    'phone'        => $input['telefono'],
    'address'      => $direccion_extendida,
    'zip'          => $input['cp'],
    'town'         => $input['ciudad'],
    'idprof1'      => $input['rfc'],
    'typent_id'    => $typent_id,
    'note_private' => "Registro Web.\nTipo Cliente: " . $tipo_label,
    'country_id'   => defined('ID_PAIS_MEXICO') ? ID_PAIS_MEXICO : 154
];

$socid = 0;

if (is_array($busqueda) && count($busqueda) > 0) {
    $socid = $busqueda[0]['id'];
    callAPI('PUT', $api_url . "/thirdparties/" . $socid, $datos_cliente);
} else {
    $res_cliente = callAPI('POST', $api_url . "/thirdparties", $datos_cliente);
    if (is_numeric($res_cliente)) {
        $socid = $res_cliente;
    } elseif (is_array($res_cliente) && isset($res_cliente['id'])) {
        $socid = $res_cliente['id'];
    } else {
        $socid = 0;
    }
}

if ($socid <= 0) { 
    ob_end_clean(); 
    echo json_encode(['success' => false, 'message' => 'Error cliente.']); 
    exit; 
}

// --- 2. CREAR DOCUMENTO ---
$endpoint_creacion = "/proposals";
$datos_doc = [
    'socid' => $socid, 
    'date' => time(), 
    'date_livraison' => $fecha_solicitada,
    'note_public' => "Fecha del Evento: " . $input['fecha'],
    'action' => 'create'
];

$res_doc = callAPI('POST', $api_url . $endpoint_creacion, $datos_doc);
if (!isset($res_doc) || isset($res_doc['error'])) { ob_end_clean(); echo json_encode(['success' => false, 'message' => 'Error creando cotización.']); exit; }

$id_documento = 0;
if (is_numeric($res_doc)) {
    $id_documento = $res_doc;
} elseif (is_array($res_doc) && isset($res_doc['id'])) {
    $id_documento = $res_doc['id'];
}

if ($id_documento <= 0) { ob_end_clean(); echo json_encode(['success' => false, 'message' => 'Error ID documento.']); exit; }

// --- 3. LÍNEAS ---
$endpoint_lineas = "/proposals/$id_documento/lines";
foreach ($input['items'] as $item) {
    $desc = (string)$item['nombre'];
    if (isset($item['esModular']) && $item['esModular']) $desc .= "\n(Medida: " . $item['cant'] . " m²)";
    
    // Lógica para Notas Especiales (ID 0)
    $fk_product = (int)$item['id'];
    $tipo_producto = 0; 

    if ($fk_product === 0) {
        $fk_product = null;
        $tipo_producto = 1; 
    }

    $payload = [[
        'fk_product' => $fk_product, 
        'qty' => (double)$item['cant'],
        'subprice' => (double)$item['precio'], 
        'desc' => $desc,
        'tva_tx' => defined('IVA_TASA') ? IVA_TASA : 16,
        'product_type' => $tipo_producto
    ]];
    callAPI('POST', $api_url . $endpoint_lineas, $payload);
}

// --- 4. VALIDAR ---
callAPI('POST', $api_url . "/proposals/$id_documento/validate", ["notrigger" => 0]);

// --- 5. FOLIO ---
$doc_final = callAPI('GET', $api_url . "/proposals/$id_documento");
$ref_doc = (isset($doc_final['ref'])) ? $doc_final['ref'] : "FOLIO-PENDIENTE";

// --- 6. ENVÍO DE CORREO ---
$mail = new PHPMailer(true);
$mail_enviado = false;
try {
    if (defined('SMTP_HOST')) {
        $mail->isSMTP(); $mail->Host = SMTP_HOST; $mail->SMTPAuth = true; $mail->Username = SMTP_USER; $mail->Password = SMTP_PASS;
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS; $mail->Port = SMTP_PORT;
        $mail->SMTPOptions = ['ssl' => ['verify_peer' => false, 'verify_peer_name' => false, 'allow_self_signed' => true]];
        
        $mail->setFrom(SMTP_USER, 'Carpas Montes');
        $mail->addAddress($input['email'], $input['cliente']); 
        
        $cuerpo = "
        <div style='font-family: sans-serif; padding: 20px; border: 1px solid #ddd; border-radius: 8px; max-width: 600px;'>
            <h2 style='color: #0e4c81; margin-top:0;'>Solicitud Recibida</h2>
            <p>Hola <strong>{$input['cliente']}</strong>,</p>
            <p>Hemos registrado tu solicitud correctamente, es importante que presentes este numero de folio cuando se te confirme tu cotizacion.</p>
            <p>Tu Folio es:</p>
            <div style='background: #f8f9fa; padding: 15px; text-align: center; margin: 20px 0; border: 1px dashed #0e4c81;'>
                <h1 style='margin:0; color: #333;'>{$ref_doc}</h1>
            </div>
            
            <div style='background: #fff3cd; color: #856404; padding: 15px; border-radius: 5px; font-size: 0.9em;'>
                <strong>⚠️ IMPORTANTE:</strong><br>
                Esta cotización <u>NO garantiza la disponibilidad ni la entrega</u>.
                <br><br>
                Un asesor se pondrá en contacto contigo para confirmar detalles, citas y agendar una visita técnica si es necesario.
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
    'pdf_url' => false 
]);
?>