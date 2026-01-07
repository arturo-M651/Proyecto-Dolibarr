<?php
// procesar_pedido.php - VERSIÓN FINAL CON LLAMADA ASÍNCRONA
header('Content-Type: application/json');

// --- CONFIGURACIÓN ---
$url_base = "http://localhost/dolibarr/htdocs/api/index.php"; 
$api_key = "55W05PsnTJuJRFg8lckZZ7hx10lM0Rz9"; 

// Autodetectar URL del generador
$protocolo = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http");
$url_generador = "$protocolo://$_SERVER[HTTP_HOST]" . dirname($_SERVER['PHP_SELF']) . "/generar_pdf.php";

// --- API HELPER ---
function callAPI($method, $url, $data = false) {
    global $api_key;
    $curl = curl_init();
    $opts = [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => ["DOLAPIKEY: $api_key", "Content-Type: application/json", "Accept: application/json"],
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

// 1. PROCESAR DATOS
$input = json_decode(file_get_contents('php://input'), true);
if (!$input) die(json_encode(['success'=>false, 'message'=>'Sin datos']));
$tipo = isset($input['tipo']) ? $input['tipo'] : 'cotizacion';

// 2. CREAR CLIENTE Y PEDIDO (API)
$socid = callAPI('POST', $url_base . "/thirdparties", ['name' => $input['cliente'], 'client' => 1, 'code_client' => -1, 'phone' => $input['telefono']]);
if (isset($socid['error'])) die(json_encode(['success'=>false, 'message'=>'Error Cliente']));

$fecha = strtotime($input['fecha']);
if ($tipo === 'pedido') {
    $res = callAPI('POST', $url_base . "/orders", ['socid' => $socid, 'date' => time(), 'date_livraison' => $fecha, 'type' => 0, 'note_public' => "Pedido Web", 'status' => 0]);
    if (isset($res['error'])) die(json_encode(['success'=>false, 'message'=>'Error Pedido']));
    $id = $res;
    $ep_lines = "/orders/$id/lines";
    $ep_val = "/orders/$id/validate";
} else {
    $res = callAPI('POST', $url_base . "/proposals", ['socid' => $socid, 'date' => time(), 'date_livraison' => $fecha, 'action' => 'create']);
    if (isset($res['error'])) die(json_encode(['success'=>false, 'message'=>'Error Cotización']));
    $id = $res;
    $ep_lines = "/proposals/$id/lines";
    $ep_val = "/proposals/$id/validate";
}

// 3. ITEMS
foreach ($input['items'] as $item) {
    $payload = ['fk_product' => (int)$item['id'], 'qty' => (double)$item['cant'], 'subprice' => (double)$item['precio'], 'desc' => (string)$item['nombre'], 'tva_tx' => 16.0, 'product_type' => 0];
    callAPI('POST', $url_base . $ep_lines, ($tipo === 'pedido' ? $payload : [$payload]));
}

// 4. VALIDAR
$params_val = [];
if ($tipo === 'pedido') {
    $alms = callAPI('GET', $url_base . "/warehouses?limit=1");
    $id_alm = (is_array($alms) && !isset($alms['error'])) ? $alms[0]['id'] : 0;
    $params_val = ["idwarehouse" => $id_alm];
}
callAPI('POST', $url_base . $ep_val, $params_val);

// 5. OBTENER REF
$doc = callAPI('GET', $url_base . ($tipo === 'pedido' ? "/orders/" : "/proposals/") . $id);
$ref = $doc['ref'];

// --- 6. DISPARAR GENERADOR PDF (El truco anti-redirect) ---
// Llamamos a generar_pdf.php pasando la API KEY en el header.
// Esto hace que Dolibarr piense que somos un usuario autenticado y NO redirige al login.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url_generador . "?ref=" . $ref . "&tipo=" . $tipo);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, ["DOLAPIKEY: $api_key"]); // <--- CLAVE
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_TIMEOUT, 5); // Esperamos max 5 segs
curl_exec($ch);
curl_close($ch);

echo json_encode(['success' => true, 'ref' => $ref]);
?>