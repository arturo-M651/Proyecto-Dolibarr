<?php
/**
 * PROCESAR_PEDIDO.PHP
 * Controlador API para Dolibarr.
 * Función: Crea Terceros, Pedidos/Cotizaciones, agrega líneas y valida el documento.
 * Retorno: JSON con el estado y la referencia creada.
 */

header('Content-Type: application/json');

// --- 1. CONFIGURACIÓN ---
$api_url = "http://localhost/dolibarr/htdocs/api/index.php"; 
$api_key = "55W05PsnTJuJRFg8lckZZ7hx10lM0Rz9"; 

// --- 2. HELPER PARA LLAMADAS CURL ---
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
        CURLOPT_SSL_VERIFYPEER => false // Solo para entorno local
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

// --- 3. RECEPCIÓN DE DATOS ---
$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    echo json_encode(['success' => false, 'message' => 'No se recibieron datos JSON.']);
    exit;
}

$tipo_accion = isset($input['tipo']) ? $input['tipo'] : 'cotizacion'; // 'pedido' o 'cotizacion'

// --- 4. GESTIÓN DEL CLIENTE (TERCERO) ---
// Preparamos los datos extendidos
$datos_cliente = [
    'name'        => $input['cliente'], 
    'client'      => 1, 
    'code_client' => -1,
    'email'       => $input['email'],           // <--- NUEVO
    'phone'       => $input['telefono'],
    'address'     => $input['direccion'],       // <--- NUEVO
    'zip'         => $input['cp'],              // <--- NUEVO
    'town'        => $input['ciudad'],          // <--- NUEVO
    'idprof1'     => $input['rfc'],             // <--- NUEVO (RFC)
    'country_id'  => 154                        // ID 154 es México en Dolibarr (Ajustar si es otro país)
];

$socid = callAPI('POST', $api_url . "/thirdparties", $datos_cliente);

// --- 5. CREACIÓN DEL DOCUMENTO (CABECERA) ---
$fecha_entrega = strtotime($input['fecha']);
$endpoint_creacion = ($tipo_accion === 'pedido') ? "/orders" : "/proposals";
$datos_doc = [
    'socid' => $socid, 
    'date' => time(), 
    'date_livraison' => $fecha_entrega
];

if ($tipo_accion === 'pedido') {
    $datos_doc['type'] = 0; 
    $datos_doc['note_public'] = "Pedido generado desde Web";
    $datos_doc['status'] = 0; // Borrador
} else {
    $datos_doc['action'] = 'create';
}

$res_doc = callAPI('POST', $api_url . $endpoint_creacion, $datos_doc);

if (isset($res_doc['error'])) {
    echo json_encode(['success' => false, 'message' => 'Error al crear Documento: ' . $res_doc['error']['message']]);
    exit;
}

$id_documento = $res_doc; // El ID numérico del documento creado

// --- 6. AGREGADO DE LÍNEAS (PRODUCTOS) ---
$endpoint_lineas = ($tipo_accion === 'pedido') ? "/orders/$id_documento/lines" : "/proposals/$id_documento/lines";

foreach ($input['items'] as $item) {
    $linea = [
        'fk_product' => (int)$item['id'], 
        'qty' => (double)$item['cant'],
        'subprice' => (double)$item['precio'], 
        'desc' => (string)$item['nombre'],
        'tva_tx' => 16.0, // IVA Hardcoded (ajustar si es dinámico)
        'product_type' => 0
    ];
    // La API de Pedidos pide objeto único, Cotizaciones pide Array. Ajuste técnico:
    $payload = ($tipo_accion === 'pedido') ? $linea : [$linea];
    callAPI('POST', $api_url . $endpoint_lineas, $payload);
}

// --- 7. VALIDACIÓN DEL DOCUMENTO ---
$endpoint_val = ($tipo_accion === 'pedido') ? "/orders/$id_documento/validate" : "/proposals/$id_documento/validate";
$params_val = [];

// Para pedidos, es obligatorio definir un almacén de salida
if ($tipo_accion === 'pedido') {
    $almacenes = callAPI('GET', $api_url . "/warehouses?limit=1");
    $id_alm = (is_array($almacenes) && !isset($almacenes['error']) && count($almacenes) > 0) ? $almacenes[0]['id'] : 0;
    $params_val = ["idwarehouse" => $id_alm];
}

$res_val = callAPI('POST', $api_url . $endpoint_val, $params_val);

if (isset($res_val['error'])) {
    echo json_encode(['success' => false, 'message' => 'Error al Validar: ' . $res_val['error']['message']]);
    exit;
}

// --- 8. OBTENCIÓN DE REFERENCIA FINAL ---
$endpoint_get = ($tipo_accion === 'pedido') ? "/orders/$id_documento" : "/proposals/$id_documento";
$doc_final = callAPI('GET', $api_url . $endpoint_get);

echo json_encode([
    'success' => true, 
    'ref' => $doc_final['ref'],
    'message' => 'Documento creado y validado correctamente.'
]);
?>