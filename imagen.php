<?php
/**
 * IMAGEN.PHP - Versión Lectura Directa (Disco Local)
 * Lee los archivos directamente de la carpeta de documentos de Dolibarr
 * para evitar bloqueos de HTTP/API.
 */

// ==========================================
// 1. CONFIGURACIÓN DE LA CARPETA
// ==========================================
// Ruta exacta de tus documentos en XAMPP
$ruta_base = "C:/xampp/htdocs/dolibarr/documents"; 

// ==========================================

// Limpiamos cualquier basura de salida anterior para evitar errores de imagen rota
if (ob_get_level()) ob_end_clean();

$ref = isset($_GET['ref']) ? $_GET['ref'] : '';
$file = isset($_GET['file']) ? $_GET['file'] : '';

function servirImagenError($texto) {
    // Crea una imagen gris con texto si falla la carga
    header("Content-Type: image/png");
    $im = @imagecreate(300, 200);
    $bg = imagecolorallocate($im, 240, 240, 240); // Fondo gris
    $text_color = imagecolorallocate($im, 14, 76, 129); // Azul Montes
    imagestring($im, 5, 80, 90, $texto, $text_color);
    imagepng($im);
    imagedestroy($im);
    exit;
}

if ($ref && $file) {
    // Seguridad básica: Evita que alguien intente leer archivos fuera de la carpeta
    $ref = basename($ref); 
    $file = basename($file);

    // Construimos la ruta completa donde Dolibarr guarda las fotos
    // Estructura: documents/product/REFERENCIA/ARCHIVO
    $ruta_archivo = $ruta_base . "/product/" . $ref . "/" . $file;

    // Verificamos si el archivo realmente existe en el disco
    if (file_exists($ruta_archivo)) {
        
        // Detectamos si es JPG, PNG, GIF, etc.
        $mime = mime_content_type($ruta_archivo);
        
        // Le decimos al navegador qué tipo de archivo es
        header("Content-Type: " . $mime);
        header("Content-Length: " . filesize($ruta_archivo));
        
        // Enviamos la imagen directamente
        readfile($ruta_archivo);
        exit;
        
    } else {
        // El archivo no está en la carpeta (quizás no has subido foto a ese producto)
        servirImagenError("Archivo no encontrado");
    }
} else {
    servirImagenError("Datos incompletos");
}
?>