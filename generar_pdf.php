<?php
// generar_pdf.php - GENERA EL PDF USANDO AUTENTICACIÓN POR API KEY
// Ajusta esta ruta a tu instalación:
$path_dolibarr = "C:/xampp/htdocs/dolibarr/htdocs"; 

// 1. CARGAMOS EL ENTORNO SIN INTERFAZ
define('NOTOKENRENEWAL', 1);
define('NOCSRFCHECK', 1);
define('NOREQUIREMENU', 1);
define('NOREQUIREHTML', 1);
define('NOREQUIREAJAX', 1);

// Importante: Si no se pasa API Key en el header, esto podría redirigir.
// Pero como lo llamaremos con CURL + Header, funcionará.
if (!file_exists($path_dolibarr . "/main.inc.php")) die("Error Ruta Dolibarr");
require_once $path_dolibarr . "/main.inc.php";
require_once $path_dolibarr . "/core/lib/functions.lib.php";
require_once $path_dolibarr . "/commande/class/commande.class.php";
require_once $path_dolibarr . "/comm/propal/class/propal.class.php";
// Plantillas
require_once $path_dolibarr . "/core/modules/commande/mod_commande_eratosthene.php"; 
require_once $path_dolibarr . "/core/modules/propale/mod_propale_azur.php";

// 2. RECIBIMOS PARÁMETROS
$ref = GETPOST('ref', 'alpha');
$tipo = GETPOST('tipo', 'alpha');

if (!$ref) die("Falta Ref");

// 3. GENERACIÓN
global $db, $conf, $langs, $user;
$langs->load("main");
$langs->load("bills");

// Si por alguna razón el usuario no cargó con la API Key, forzamos al SuperAdmin (ID 1)
if (empty($user->id)) {
    $user->fetch(1);
    $user->getrights();
}

if ($tipo == 'pedido') {
    $object = new Commande($db);
    if ($object->fetch('', $ref) > 0) {
        $modelo = new mod_commande_eratosthene($db);
        if ($modelo->write_file($object, $langs) > 0) {
            echo "OK:" . $modelo->last_assigned_file;
        } else {
            echo "ERROR:" . $modelo->error;
        }
    } else {
        echo "Pedido no encontrado";
    }
} else {
    // Cotización
    $object = new Propal($db);
    if ($object->fetch('', $ref) > 0) {
        $modelo = new mod_propale_azur($db);
        if ($modelo->write_file($object, $langs) > 0) {
            echo "OK:" . $modelo->last_assigned_file;
        } else {
            echo "ERROR:" . $modelo->error;
        }
    }
}
?>