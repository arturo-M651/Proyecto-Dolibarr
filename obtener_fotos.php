<?php
/**
 * OBTENER_FOTOS.PHP - V3 (MODO LOCAL: CARPETA FOTOS_EXTRA)
 * Escanea la carpeta 'fotos_extra/REFERENCIA' en tu servidor.
 */

// Configuración básica
header('Content-Type: application/json');
$ref = isset($_GET['ref']) ? $_GET['ref'] : '';

// Si no hay referencia, devolvemos vacío
if (!$ref) {
    echo json_encode([]);
    exit;
}

// Limpiamos la referencia para evitar caracteres raros en la ruta
$ref_limpia = preg_replace('/[^a-zA-Z0-9_-]/', '', $ref);

// Definimos la ruta donde buscar
// Estructura: fotos_extra / C15X15-4A / foto1.jpg
$ruta_carpeta = "fotos_extra/" . $ref;

$imagenes = [];

// Verificamos si la carpeta existe
if (is_dir($ruta_carpeta)) {
    // Escaneamos los archivos
    $archivos = scandir($ruta_carpeta);
    
    foreach ($archivos as $archivo) {
        // Ignoramos los puntos de sistema (. y ..)
        if ($archivo !== '.' && $archivo !== '..') {
            // Verificamos que sea una imagen real
            if (preg_match('/\.(jpg|jpeg|png|gif|webp)$/i', $archivo)) {
                // Agregamos la ruta pública al array
                // Nota: rawurlencode permite nombres con espacios
                $imagenes[] = "fotos_extra/" . $ref . "/" . rawurlencode($archivo);
            }
        }
    }
}

// Devolvemos la lista al frontend
echo json_encode($imagenes);
?>