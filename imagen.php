<?php
/**
 * IMAGEN.PHP - V2 (CORRECCIÓN DE URL + MODO DEBUG)
 */
require_once 'config.php';

// Validamos parámetros
$ref = isset($_GET['ref']) ? $_GET['ref'] : '';
$file = isset($_GET['file']) ? $_GET['file'] : '';
$debug = isset($_GET['debug']) ? true : false; // Nuevo parámetro para ver errores

if (!$ref || !$file) {
    if ($debug) die("Faltan parámetros REF o FILE.");
    redirigirPlaceholder();
}

// CORRECCIÓN CLAVE: No codificar la barra inclinada '/'
// Dolibarr necesita "REF/Archivo.jpg", no "REF%2FArchivo.jpg"
$file_path_encoded = urlencode($ref) . "/" . urlencode($file);

// Construimos la URL
$api_url = DOL_BASE_URL . "/documents/download?modulepart=product&original_file=" . $file_path_encoded;

$curl = curl_init();
curl_setopt_array($curl, [
    CURLOPT_URL => $api_url,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_HTTPHEADER => [
        "DOLAPIKEY: " . DOL_API_KEY,
        "Accept: application/json"
    ],
    CURLOPT_SSL_VERIFYPEER => false,
    CURLOPT_TIMEOUT => 10
]);

$response = curl_exec($curl);
$http_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
$curl_error = curl_error($curl);
curl_close($curl);

// MODO DEBUG: Si activas &debug=1, verás el error en texto en lugar de la imagen gris
if ($debug) {
    echo "<h1>Diagnóstico de Imagen</h1>";
    echo "<b>URL API Solicitada:</b> $api_url<br>";
    echo "<b>Código HTTP:</b> $http_code<br>";
    echo "<b>Error CURL:</b> $curl_error<br>";
    echo "<b>Respuesta Raw:</b> <pre>" . htmlspecialchars(substr($response, 0, 500)) . "...</pre>"; // Solo primeros 500 chars
    exit;
}

// Si Dolibarr nos da la imagen (Código 200)
if ($http_code == 200 && $response) {
    $json = json_decode($response, true);
    
    if (isset($json['content'])) {
        $img_data = base64_decode($json['content']);
        $mime_type = isset($json['content-type']) ? $json['content-type'] : 'image/jpeg';
        
        header("Content-Type: " . $mime_type);
        echo $img_data;
        exit;
    }
}

// Si falló y no estamos en debug, mostrar placeholder
redirigirPlaceholder();

function redirigirPlaceholder() {
    header("Location: https://placehold.co/300x300/f8fafc/0e4c81?text=Sin+Foto");
    exit;
}
?>