<?php
// imagen.php - Puente para leer imágenes de Dolibarr

// CONFIGURACIÓN (Debe ser idéntica al otro archivo)
$api_key = "55W05PsnTJuJRFg8lckZZ7hx10lM0Rz9"; 
$url_base = "http://localhost/dolibarr/htdocs/api/index.php"; 

// Obtenemos parámetros
$ref = isset($_GET['ref']) ? $_GET['ref'] : '';
$file = isset($_GET['file']) ? $_GET['file'] : '';

// Función auxiliar para crear imagen gris de error (Por si falla Dolibarr)
function mostrarImagenError($texto) {
    header("Content-Type: image/png");
    $im = @imagecreate(300, 200) or die("Error GD");
    $bg = imagecolorallocate($im, 240, 240, 240); // Gris claro
    $text_color = imagecolorallocate($im, 100, 100, 100);
    imagestring($im, 5, 80, 90,  $texto, $text_color);
    imagepng($im);
    imagedestroy($im);
    exit;
}

if ($ref && $file) {
    // Construimos la ruta interna que usa Dolibarr: product/REFERENCIA/ARCHIVO
    $filepath = "product/" . $ref . "/" . $file;
    
    // Llamada al endpoint de descarga
    $curl = curl_init();
    $url = $url_base . "/document.php?hashp=pEZzxCvo1IoxHo8T7R7XS7xq5FH551g8" . urlencode($filepath);

    curl_setopt_array($curl, array(
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => array("DOLAPIKEY: " . $api_key),
    ));

    $result = curl_exec($curl);
    $http_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    curl_close($curl);

    if ($http_code == 200) {
        $data = json_decode($result, true);
        
        // Dolibarr suele devolver JSON con el contenido en base64
        if (isset($data['content'])) {
            header("Content-Type: " . $data['content-type']);
            echo base64_decode($data['content']);
        } 
        // A veces (dependiendo de la config) devuelve el binario directo
        elseif (isset($data['filename'])) { 
             // Si llegara aquí, es un caso raro, pero manejable
             mostrarImagenError("Formato no soportado");
        }
        else {
             // Si devuelve binario puro sin JSON (raro en la API nueva, pero posible)
             header("Content-Type: image/jpeg"); 
             echo $result;
        }
    } else {
        // Si Dolibarr dice 404 o Error
        mostrarImagenError("Sin Foto");
    }
} else {
    mostrarImagenError("Faltan Datos");
}
?>