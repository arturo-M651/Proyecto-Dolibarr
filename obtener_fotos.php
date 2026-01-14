<?php
/**
 * OBTENER_FOTOS.PHP - Busca todas las imágenes de un producto para la galería
 */
require_once 'config.php';

header('Content-Type: application/json');

$ref = isset($_GET['ref']) ? $_GET['ref'] : '';

if (!$ref) {
    echo json_encode([]);
    exit;
}

// Pedimos a la API la lista de documentos de este producto
$api_url = DOL_BASE_URL . "/documents?modulepart=product&sortfield=date_creation&sortorder=DESC&ref=" . urlencode($ref);

$curl = curl_init();
curl_setopt_array($curl, [
    CURLOPT_URL => $api_url,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_HTTPHEADER => [
        "DOLAPIKEY: " . DOL_API_KEY,
        "Accept: application/json"
    ],
    CURLOPT_SSL_VERIFYPEER => false
]);

$response = curl_exec($curl);
$http_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);

$imagenes = [];

if ($http_code == 200) {
    $docs = json_decode($response, true);
    if (is_array($docs)) {
        foreach ($docs as $doc) {
            // Filtramos solo imágenes (jpg, png, webp, etc.)
            if (preg_match('/\.(jpg|jpeg|png|gif|webp)$/i', $doc['name'])) {
                // Generamos la URL segura usando nuestro proxy imagen.php
                // nivel=0 significa archivo principal, nivel=1 subcarpetas. Dolibarr normal usa nivel 0 para productos.
                $imagenes[] = "imagen.php?ref=" . urlencode($ref) . "&file=" . urlencode($doc['name']);
            }
        }
    }
}

// Devolvemos la lista de URLs al Frontend
echo json_encode($imagenes);
?>