<?php
/**
 * VER_PDF.PHP - Proxy seguro para visualizar documentos sin exponer la API Key
 */
require_once 'config.php';

// Validar parámetros
if (!isset($_GET['ref']) || !isset($_GET['tipo'])) {
    die("Faltan parámetros.");
}

$ref = $_GET['ref'];   // Ej: CO2601-0001
$tipo = $_GET['tipo']; // 'pedido' o 'cotizacion'

// Determinar módulo de Dolibarr
$modulepart = ($tipo === 'pedido') ? 'order' : 'proposal';
$file_path = $ref . "/" . $ref . ".pdf";

// Construir URL de la API
$api_url = DOL_BASE_URL . "/documents/download?modulepart=" . $modulepart . "&original_file=" . urlencode($file_path);

// Llamar a la API (Aquí es donde se usa la llave secreta)
$curl = curl_init();
curl_setopt_array($curl, [
    CURLOPT_URL => $api_url,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_HTTPHEADER => [
        "DOLAPIKEY: " . DOL_API_KEY, // ¡La llave maestra!
        "Accept: application/json"
    ],
    CURLOPT_SSL_VERIFYPEER => false
]);

$response = curl_exec($curl);
$http_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);

// Procesar respuesta
$json = json_decode($response, true);

if ($http_code == 200 && isset($json['content'])) {
    // Si todo salió bien, decodificamos el PDF y lo mostramos
    $pdf_content = base64_decode($json['content']);
    
    header("Content-type: application/pdf");
    header("Content-Disposition: inline; filename=" . $ref . ".pdf");
    echo $pdf_content;
} else {
    // Si falló, mostramos error
    echo "Error al obtener el documento. (Código $http_code)";
    // Opcional: ver qué respondió la API
    // var_dump($json); 
}
?>