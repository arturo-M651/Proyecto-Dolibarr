<?php
// descargar_pdf.php - VERSIÓN FINAL DIRECTA
// Genera nativamente y sirve el archivo directo del disco duro.

// 1. CONFIGURACIÓN
$url_base = "http://localhost/dolibarr/htdocs/api/index.php"; 
$api_key = "55W05PsnTJuJRFg8lckZZ7hx10lM0Rz9"; 
// Ajusta esto si es necesario:
$path_dolibarr = "C:/xampp/htdocs/dolibarr/htdocs"; 

$ref = isset($_GET['ref']) ? $_GET['ref'] : '';
$tipo = isset($_GET['tipo']) ? $_GET['tipo'] : ''; 

if (!$ref || !$tipo) die("Faltan datos.");

// Limpiamos cualquier salida previa (espacios, warnings)
ob_start();

// --- INTENTO DE GENERACIÓN NATIVA ---
if (!file_exists($path_dolibarr . "/main.inc.php")) {
    ob_end_clean();
    die("Error crítico: No encuentro Dolibarr en $path_dolibarr");
}

// Configuración Silenciosa
if (!defined('NOTOKENRENEWAL')) define('NOTOKENRENEWAL', 1);
if (!defined('NOCSRFCHECK')) define('NOCSRFCHECK', 1);
if (!defined('NOREQUIREMENU')) define('NOREQUIREMENU', 1);
if (!defined('NOREQUIREHTML')) define('NOREQUIREHTML', 1);
if (!defined('NOREQUIREAJAX')) define('NOREQUIREAJAX', 1);
if (!defined('NOLOGIN')) define('NOLOGIN', 1); 

require_once $path_dolibarr . "/main.inc.php";

global $db, $conf, $langs, $user;
$langs->load("main");
$langs->load("bills");
$langs->load("orders");
$langs->load("propal");

// Forzar Admin
if (empty($user->id)) {
    $user->fetch(1); 
    $user->getrights();
}

// Variables para la ruta final
$dir_output = "";
$file_name = $ref . ".pdf";

if ($tipo === 'pedido') {
    require_once $path_dolibarr . "/commande/class/commande.class.php";
    // Ruta correcta para v21
    require_once $path_dolibarr . "/core/modules/commande/doc/pdf_eratosthene.modules.php";
    
    $object = new Commande($db);
    if ($object->fetch('', $ref) > 0) {
        $modelo = new pdf_eratosthene($db); 
        $modelo->write_file($object, $langs);
        // Ruta de salida estándar de Dolibarr
        $dir_output = $conf->commande->dir_output . "/" . $ref;
    }
} else {
    require_once $path_dolibarr . "/comm/propal/class/propal.class.php";
    require_once $path_dolibarr . "/core/modules/propale/doc/pdf_azur.modules.php";
    
    $object = new Propal($db);
    if ($object->fetch('', $ref) > 0) {
        $modelo = new pdf_azur($db);
        $modelo->write_file($object, $langs);
        // Ruta de salida estándar de Dolibarr
        $dir_output = $conf->propal->dir_output . "/" . $ref;
    }
}

// Ruta completa del archivo físico
$file_path = $dir_output . "/" . $file_name;

// Limpiamos el buffer (borramos cualquier warning que haya salido durante la generación)
ob_end_clean();

// --- ENTREGAR ARCHIVO ---
if (file_exists($file_path)) {
    header('Content-Description: File Transfer');
    header('Content-Type: application/pdf');
    header('Content-Disposition: attachment; filename="'.$file_name.'"');
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Content-Length: ' . filesize($file_path));
    readfile($file_path); // Leemos el archivo directo del disco
    exit;
} else {
    // Si falla, mostramos error visible
    echo "<h1>Error: Archivo no encontrado</h1>";
    echo "El sistema intentó generar el PDF pero no apareció en la carpeta esperada.<br>";
    echo "Ruta buscada: <strong>$file_path</strong>";
}
?>