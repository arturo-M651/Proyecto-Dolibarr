<?php
// obtener_fotos.php - VERSIÓN DE DIAGNÓSTICO WINDOWS
header('Content-Type: application/json');

$ref = isset($_GET['ref']) ? $_GET['ref'] : '';

if (!$ref) {
    echo json_encode(["error" => "No se recibió ninguna referencia."]);
    exit;
}

// 1. Definimos la ruta
$folder = "fotos_extra/" . $ref;

// 2. DIAGNÓSTICO: ¿Existe la carpeta física?
if (!is_dir($folder)) {
    // Si falla, devolvemos un error visible en la consola
    echo json_encode([
        "error" => "Carpeta no encontrada",
        "ruta_buscada" => $folder,
        "ruta_absoluta_intentada" => realpath('.') . DIRECTORY_SEPARATOR . "fotos_extra" . DIRECTORY_SEPARATOR . $ref
    ]);
    exit;
}

// 3. Buscamos archivos
$files = glob($folder . "/*.{jpg,jpeg,png,gif,JPG,JPEG,PNG,webp}", GLOB_BRACE);

$resultado = [];

if ($files) {
    foreach ($files as $file) {
        // --- CORRECCIÓN VITAL PARA WINDOWS ---
        // Cambiamos las barras invertidas (\) por normales (/) para que el navegador las entienda
        $ruta_web = str_replace('\\', '/', $file);
        $resultado[] = $ruta_web;
    }
}

echo json_encode($resultado);
?>