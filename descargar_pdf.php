<?php
/**
 * DESCARGAR_PDF.PHP
 * Generador de PDF Nativo y Servidor de Archivos.
 * Función: Carga el núcleo de Dolibarr, fuerza la generación del PDF usando las plantillas
 * (Eratosthene/Azur) y entrega el archivo binario al navegador.
 */

// --- 1. CONFIGURACIÓN DEL SISTEMA ---
// Ruta ABSOLUTA a la carpeta 'htdocs' dentro de tu instalación Dolibarr
$path_dolibarr = "C:/xampp/htdocs/dolibarr/htdocs"; 

// --- 2. VALIDACIÓN DE ENTRADA ---
$ref  = isset($_GET['ref']) ? $_GET['ref'] : '';
$tipo = isset($_GET['tipo']) ? $_GET['tipo'] : ''; 

if (!$ref || !$tipo) die("Error: Faltan datos (referencia o tipo).");

// Iniciamos buffer para capturar cualquier warning/error sucio de PHP
ob_start();

// --- 3. CARGA DEL NÚCLEO DE DOLIBARR ---
if (!file_exists($path_dolibarr . "/main.inc.php")) {
    ob_end_clean();
    die("Error Crítico: No se encuentra Dolibarr en la ruta: $path_dolibarr");
}

// Definimos constantes para evitar interfaz gráfica y redirecciones
if (!defined('NOTOKENRENEWAL')) define('NOTOKENRENEWAL', 1);
if (!defined('NOCSRFCHECK'))   define('NOCSRFCHECK', 1);
if (!defined('NOREQUIREMENU')) define('NOREQUIREMENU', 1);
if (!defined('NOREQUIREHTML')) define('NOREQUIREHTML', 1);
if (!defined('NOREQUIREAJAX')) define('NOREQUIREAJAX', 1);
if (!defined('NOLOGIN'))       define('NOLOGIN', 1); 

require_once $path_dolibarr . "/main.inc.php";

// Cargamos traducciones y configuración global
global $db, $conf, $langs, $user;
$langs->load("main");
$langs->load("bills");
$langs->load("orders");
$langs->load("propal");

// --- 4. AUTENTICACIÓN PROGRAMÁTICA (USER IMPERSONATION) ---
// Si no hay sesión, actuamos como el SuperAdmin (ID 1)
if (empty($user->id)) {
    $user->fetch(1); 
    $user->getrights();
}

// --- 5. GENERACIÓN DEL PDF ---
// Variables para ubicar el archivo final
$dir_output = "";
$file_name  = $ref . ".pdf";

if ($tipo === 'pedido') {
    // Clases para Pedidos
    require_once $path_dolibarr . "/commande/class/commande.class.php";
    require_once $path_dolibarr . "/core/modules/commande/doc/pdf_eratosthene.modules.php";
    
    $object = new Commande($db);
    if ($object->fetch('', $ref) > 0) {
        $modelo = new pdf_eratosthene($db); 
        $modelo->write_file($object, $langs); // Genera el PDF físico
        $dir_output = $conf->commande->dir_output . "/" . $ref;
    }
} else {
    // Clases para Cotizaciones
    require_once $path_dolibarr . "/comm/propal/class/propal.class.php";
    require_once $path_dolibarr . "/core/modules/propale/doc/pdf_azur.modules.php";
    
    $object = new Propal($db);
    if ($object->fetch('', $ref) > 0) {
        $modelo = new pdf_azur($db);
        $modelo->write_file($object, $langs); // Genera el PDF físico
        $dir_output = $conf->propal->dir_output . "/" . $ref;
    }
}

// Ruta completa donde Dolibarr guardó el archivo
$file_path = $dir_output . "/" . $file_name;

// --- 6. LIMPIEZA Y ENTREGA ---
// Borramos cualquier texto/error que PHP haya generado durante el proceso
ob_end_clean();

// Servimos el archivo
if (file_exists($file_path)) {
    header('Content-Description: File Transfer');
    header('Content-Type: application/pdf');
    header('Content-Disposition: attachment; filename="'.$file_name.'"');
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Content-Length: ' . filesize($file_path));
    readfile($file_path);
    exit;
} else {
    // Solo mostramos error si el archivo físico no se creó
    echo "<h1>Error: Archivo no generado</h1>";
    echo "<p>El sistema intentó generar el PDF para <strong>$ref</strong> pero falló.</p>";
    echo "<p>Ruta esperada: $file_path</p>";
}
?>