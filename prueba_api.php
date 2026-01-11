<?php
/**
 * ==============================================================================
 * PRUEBA_API.PHP - CATÁLOGO PRINCIPAL (VERSIÓN OPTIMIZADA)
 * ==============================================================================
 * Descripción: Conecta con la API de Dolibarr, lista categorías y productos,
 * y gestiona el carrito de compras mediante JavaScript.
 */

require_once 'config.php'; 

// --- CONFIGURACIÓN API ---
$api_url = DOL_BASE_URL; 
$api_key = DOL_API_KEY;

/**
 * Función genérica para llamar a la API
 * @param string $url Endpoint completo
 * @param string $api_key Clave de seguridad
 * @return array Datos en formato Array o Array vacío si falla
 */
function callAPI($url, $api_key) {
    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => array("DOLAPIKEY: " . $api_key, "Accept: application/json"),
        CURLOPT_TIMEOUT => 10 // Timeout para evitar que la página se cuelgue
    ));
    $response = curl_exec($curl);
    
    if(curl_errno($curl)) {
        // En producción, aquí podrías guardar el error en un log
        curl_close($curl);
        return []; 
    }
    
    curl_close($curl);
    return json_decode($response, true);
}

// 1. OBTENER CATEGORÍAS (Para el menú de filtros)
$lista_categorias = callAPI($api_url . "/categories?type=product&sortfield=label&sortorder=ASC", $api_key);

// 2. DETECTAR FILTRO ACTIVO
$cat_id = isset($_GET['cat']) ? $_GET['cat'] : '';

// 3. DEFINIR TÍTULO DINÁMICO
$titulo_pagina = "Nuestra Colección";
if ($cat_id && is_array($lista_categorias)) {
    foreach($lista_categorias as $c) {
        if($c['id'] == $cat_id) {
            $titulo_pagina = $c['label'];
            break; 
        }
    }
}

// 4. OBTENER PRODUCTOS (Solo si hay categoría seleccionada)
$productos = [];
if ($cat_id) {
    // Nota: 't.ref' ordena por referencia. Cambiar a 'label' si prefieres alfabético.
    $endpoint = "/products?sortfield=t.ref&sortorder=ASC&category=" . $cat_id;
    $productos = callAPI($api_url . $endpoint, $api_key);
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo | Carpas Montes</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Lato:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.php">
             <div class="d-flex align-items-center">
                <span class="fw-bold fs-3" style="color: var(--montes-cyan, #00b4db);">CARPAS</span>
                <span class="fw-bold fs-3 ms-1" style="color: var(--montes-dark, #0e4c81);">MONTES</span>
            </div>
        </a>

        <div class="ms-auto d-flex align-items-center gap-3">
            <a href="index.php" class="text-decoration-none fw-bold text-dark small d-none d-md-block">
                <i class="bi bi-house-door"></i> INICIO
            </a>
            <button class="btn btn-gold rounded-circle d-flex align-items-center justify-content-center shadow-sm position-relative" 
                    style="width:45px; height:45px;" data-bs-toggle="modal" data-bs-target="#modalCarrito">
                <i class="bi bi-cart2 fs-5"></i>
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="contador">0</span>
            </button>
        </div>
    </div>
</nav>

<div class="sticky-filters shadow-sm">
    <div class="container">
        <div class="row align-items-center g-2">
            <div class="col-md-8">
                <div class="d-flex align-items-center gap-2 overflow-auto" style="white-space: nowrap; padding-bottom: 10px;">
                    <a href="prueba_api.php" class="cat-pill <?php echo ($cat_id == '') ? 'active' : ''; ?>">
                        <i class="bi bi-grid-fill me-1"></i> Todo
                    </a>
                    <?php
                    if (!isset($lista_categorias['error']) && is_array($lista_categorias)) {
                        foreach ($lista_categorias as $cat) {
                            $active = ($cat_id == $cat['id']) ? 'active' : '';
                            echo '<a href="?cat=' . $cat['id'] . '" class="cat-pill ' . $active . '">' . $cat['label'] . '</a>';
                        }
                    }
                    ?>
                </div>
            </div>
            <div class="col-md-4">
                <?php if ($cat_id): ?>
                <div class="search-container d-flex align-items-center bg-white px-3 py-1 rounded-pill border shadow-sm">
                    <i class="bi bi-search text-muted small"></i>
                    <input type="text" id="buscadorJS" class="search-input bg-transparent border-0 ms-2 w-100" placeholder="Buscar producto..." style="font-size: 0.9rem; outline:none;">
                </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<div class="container py-4" style="min-height: 80vh;">

    <?php if (!$cat_id): ?>
        
        <div id="carruselHome" class="carousel slide mb-4 rounded-4 overflow-hidden shadow-lg" data-bs-ride="carousel" data-bs-interval="4000" data-aos="zoom-in">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carruselHome" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#carruselHome" data-bs-slide-to="1"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active" style="height: 400px;">
                    <img src="carrusel/15x30.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Banner 1"
                         onerror="this.src='https://placehold.co/1920x600/0e4c81/ffffff?text=Eventos'">
                    <div class="carousel-caption d-none d-md-block p-4 rounded-3" style="background: rgba(0,0,0,0.6); backdrop-filter: blur(2px);">
                        <h2 class="display-5 fw-bold text-warning">Eventos Inolvidables</h2>
                        <p class="fs-5 text-light">Todo lo necesario para tu celebración.</p>
                    </div>
                </div>
                <div class="carousel-item" style="height: 400px;">
                    <img src="carrusel/Carpa_Luces.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Banner 2"
                         onerror="this.src='https://placehold.co/1920x600/0e4c81/ffffff?text=Mobiliario'">
                    <div class="carousel-caption d-none d-md-block p-4 rounded-3" style="background: rgba(0,0,0,0.6); backdrop-filter: blur(2px);">
                        <h2 class="display-5 fw-bold text-warning">Mobiliario Premium</h2>
                        <p class="fs-5 text-light">Elegancia y confort para tus invitados.</p>
                    </div>
                </div>
                <div class="carousel-item" style="height: 400px;">
                    <img src="carrusel/carpa-hule.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Banner 2"
                         onerror="this.src='https://placehold.co/1920x600/0e4c81/ffffff?text=Mobiliario'">
                    <div class="carousel-caption d-none d-md-block p-4 rounded-3" style="background: rgba(0,0,0,0.6); backdrop-filter: blur(2px);">
                        <h2 class="display-5 fw-bold text-warning">Calidad en Montaje</h2>
                        <p class="fs-5 text-light">Comodidad para tus invitados.</p>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carruselHome" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carruselHome" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>

       <div class="container benefits-section mb-5" data-aos="fade-up">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="benefit-card">
                        <div class="benefit-icon-wrapper"><i class="bi bi-stopwatch"></i></div>
                        <h4 class="fw-bold mb-2">Puntualidad Garantizada</h4>
                        <p class="text-muted small">Tu montaje estará listo exactamente cuando lo necesitas.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="benefit-card">
                        <div class="benefit-icon-wrapper"><i class="bi bi-stars"></i></div>
                        <h4 class="fw-bold mb-2">Impecable y Limpio</h4>
                        <p class="text-muted small">Mobiliario mantenido y limpio antes de cada evento.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="benefit-card">
                        <div class="benefit-icon-wrapper"><i class="bi bi-shield-check"></i></div>
                        <h4 class="fw-bold mb-2">Seguridad y Confianza</h4>
                        <p class="text-muted small">Instalación profesional por expertos.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mb-4" data-aos="fade-up">
            <h2 class="fw-bold text-dark">Explora por Categorías</h2>
            <div style="width: 60px; height: 3px; background: var(--gold); margin: 10px auto;"></div>
        </div>

        <div class="row g-4">
            <?php
            if (is_array($lista_categorias) && !isset($lista_categorias['error'])) {
                foreach ($lista_categorias as $cat) {
                    $img_cat = "img_categorias/" . $cat['id'] . ".jpg";
            ?>
                <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-duration="800">
                    <a href="?cat=<?php echo $cat['id']; ?>" class="cat-card text-decoration-none">
                        <img src="<?php echo $img_cat; ?>" alt="<?php echo $cat['label']; ?>" class="transition-hover"
                             onerror="this.onerror=null; this.src='https://placehold.co/600x400/0e4c81/ffffff?text=<?php echo urlencode($cat['label']); ?>';">
                        <div class="cat-overlay position-absolute bottom-0 start-0 w-100">
                            <h3 class="mb-1 text-white fw-bold display-6" style="font-size: 1.8rem; font-family: 'Playfair Display', serif;">
                                <?php echo $cat['label']; ?>
                            </h3>
                            <div class="d-flex align-items-center text-warning fw-bold text-uppercase small ls-1 mt-2">
                                <span>Explorar</span> <i class="bi bi-arrow-right ms-2 animate-arrow"></i>
                            </div>
                        </div>
                    </a>
                </div>
            <?php
                }
            }
            ?>
        </div>
    
    <?php else: ?>
        <div class="d-flex align-items-center justify-content-between mb-4">
            <h2 class="fw-bold text-dark mb-0"><?php echo $titulo_pagina; ?></h2>
            <a href="prueba_api.php" class="btn btn-outline-secondary btn-sm rounded-pill"><i class="bi bi-arrow-left"></i> Volver</a>
        </div>
        
        <div class="row g-4" id="contenedorProductos">
            <?php
            if (isset($productos['error']) || empty($productos)) {
                echo "<div class='col-12 text-center py-5'><i class='bi bi-box-seam display-1 text-muted'></i><p class='mt-3 lead'>No hay productos disponibles.</p></div>";
            } else {
                foreach ($productos as $producto) {
                    // Mapeo de datos seguro
                    $id = $producto['id'];
                    $ref = $producto['ref'];
                    $label = addslashes($producto['label']); 
                    $price = (float)$producto['price']; 
                    $desc = isset($producto['description']) ? addslashes(str_replace(["\r", "\n"], " ", $producto['description'])) : '';
                    
                    // Lógica de Imagen
                    $img_name = isset($producto['last_main_doc']) ? $producto['last_main_doc'] : $ref . ".jpg";
                    $img_src = "imagen.php?ref=" . $ref . "&file=" . $img_name;
            ?>
                <div class="col-6 col-md-4 col-lg-3 item-producto" data-nombre="<?php echo strtolower($label); ?>" data-aos="zoom-in">
                    <div class="product-card shadow-sm bg-white rounded-4 border-0 h-100 d-flex flex-column">
                        
                        <div class="product-img-wrapper position-relative cursor-pointer" style="height: 220px; overflow: hidden;"
                             onclick="verDetalles('<?php echo $ref; ?>', '<?php echo $label; ?>', '<?php echo $desc; ?>', <?php echo $price; ?>)">
                            <img src="<?php echo $img_src; ?>" class="w-100 h-100 object-fit-cover" 
                                 onerror="this.src='https://placehold.co/300x300/f8fafc/0e4c81?text=Sin+Foto'">
                            <span class="position-absolute bottom-0 end-0 m-2 badge bg-white text-dark shadow fw-bold border border-warning price-badge">
                                $<?php echo number_format($price, 2); ?>
                            </span>
                        </div>

                        <div class="p-3 d-flex flex-column flex-grow-1">
                            <h6 class="fw-bold text-dark mb-1 text-truncate" style="font-family: 'Lato', sans-serif;"><?php echo $label; ?></h6>
                            <small class="text-muted mb-3 small product-desc-clamp"><?php echo strip_tags($desc); ?></small>
                            
                            <div class="mt-auto d-flex justify-content-between align-items-center gap-2">
                                <button class="btn btn-light text-primary fw-bold btn-sm flex-grow-1" 
                                    onclick="verDetalles('<?php echo $ref; ?>', '<?php echo $label; ?>', '<?php echo $desc; ?>', <?php echo $price; ?>, '<?php echo $img_src; ?>', <?php echo $id; ?>)">
                                    <i class="bi bi-eye"></i> Ver
                                </button>
                                <button class="btn btn-gold btn-sm rounded-circle shadow-sm d-flex align-items-center justify-content-center" style="width:35px; height:35px;"
                                        onclick="prepararAgregar(<?php echo $id; ?>, '<?php echo $label; ?>', <?php echo $price; ?>)">
                                    <i class="bi bi-plus-lg"></i>
                                </button>
                            </div>
                        </div>

                    </div>
                </div>
            <?php 
                } 
            } 
            ?>
        </div>
    <?php endif; ?>
</div>

<footer class="bg-dark text-white pt-5 pb-3 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4">
                <h4 class="text-warning mb-3 fw-bold">Carpas Montes</h4>
                <p class="text-white-50 small">Expertos en infraestructura para eventos. Calidad y servicio en Amecameca y alrededores.</p>
            </div>
            <div class="col-md-4 mb-4">
                <h5 class="mb-3 fw-bold">Contacto</h5>
                <ul class="list-unstyled text-white-50 small">
                    <li class="mb-2"><i class="bi bi-geo-alt me-2"></i> C. 20 de Noviembre #14, Amecameca</li>
                    <li class="mb-2"><i class="bi bi-whatsapp me-2"></i> 55 1234 5678</li>
                    <li class="mb-2"><i class="bi bi-envelope me-2"></i> contacto@carpasmontes.com</li>
                </ul>
            </div>
            <div class="col-md-4 mb-4 text-center">
                <h5 class="mb-3 fw-bold">Redes Sociales</h5>
                <div class="d-flex justify-content-center gap-3">
                    <a href="#" class="text-white fs-4"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-white fs-4"><i class="bi bi-instagram"></i></a>
                </div>
            </div>
        </div>
        <hr class="border-secondary">
        <div class="text-center text-secondary small">
            &copy; 2026 Carpas Montes. Todos los derechos reservados.
        </div>
    </div>
</footer>

<a href="https://wa.me/525512345678" target="_blank" class="btn-whatsapp-float shadow-lg">
    <i class="bi bi-whatsapp"></i>
</a>

<div class="modal fade" id="modalCantidad" tabindex="-1">
    <div class="modal-dialog modal-sm modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4">
            <div class="modal-header bg-primary text-white border-0 py-2">
                <h6 class="modal-title small">Cantidad</h6>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center">
                <h6 class="fw-bold mb-3" id="lblProductoSeleccionado"></h6>
                <input type="number" id="inputCantidadModal" class="form-control text-center mb-3" value="1" min="1">
                <button class="btn btn-gold w-100 btn-sm rounded-pill" onclick="confirmarAgregar()">Agregar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalDetalles" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow-lg overflow-hidden">
            <div class="modal-header border-0 absolute-top-right" style="position: absolute; right: 0; z-index: 10;">
                <button type="button" class="btn-close m-2 bg-white p-2 rounded-circle shadow-sm opacity-100" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-0">
                <div class="row g-0">
                    <div class="col-lg-7">
                        <div class="modal-gallery-area">
                            <div class="main-image-container">
                                <img id="imgPrincipal" src="" alt="Producto">
                            </div>
                            <div class="thumbnails-row" id="galeriaContenedor"></div>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="modal-info-area d-flex flex-column h-100 p-4">
                            <small class="text-uppercase text-muted fw-bold ls-1 mb-2" style="font-size: 0.75rem;">Detalles del Producto</small>
                            <h3 class="fw-bold mb-2" id="detalleTitulo" style="font-family: 'Playfair Display', serif;"></h3>
                            <h2 class="text-gold fw-bold mb-4" id="detallePrecio"></h2>
                            <div class="mb-4">
                                <h6 class="fw-bold small text-dark">Descripción:</h6>
                                <p class="text-muted small lh-lg" id="detalleDesc"></p>
                            </div>
                            <div class="mt-auto pt-3 border-top">
                                <label class="small fw-bold mb-2">Cantidad:</label>
                                <div class="d-flex gap-2">
                                    <input type="number" id="inputCantidadDetalle" class="form-control text-center fw-bold" value="1" min="1" style="width: 70px;">
                                    <button class="btn btn-gold w-100 rounded-pill shadow-sm" onclick="agregarDesdeDetalle()">
                                        <i class="bi bi-cart-plus me-1"></i> Agregar al Carrito
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalCarrito" tabindex="-1">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title"><i class="bi bi-cart3"></i> Resumen</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="bg-light p-3 rounded mb-3 border">
                    <input type="text" id="cliente" class="form-control form-control-sm mb-2" placeholder="Nombre Completo *">
                    <input type="email" id="email" class="form-control form-control-sm mb-2" placeholder="Email *">
                    <input type="date" id="fecha" class="form-control form-control-sm mb-2">
                    
                    <a class="text-decoration-none small fw-bold" data-bs-toggle="collapse" href="#extraFields">+ Datos Entrega/RFC</a>
                    <div class="collapse mt-2" id="extraFields">
                        <input type="tel" id="telefono" class="form-control form-control-sm mb-2" placeholder="Teléfono">
                        <input type="text" id="direccion" class="form-control form-control-sm mb-2" placeholder="Dirección">
                        <div class="row g-2 mb-2">
                            <div class="col-4"><input type="text" id="cp" class="form-control form-control-sm" placeholder="CP"></div>
                            <div class="col-8"><input type="text" id="ciudad" class="form-control form-control-sm" placeholder="Ciudad"></div>
                        </div>
                        <input type="text" id="rfc" class="form-control form-control-sm" placeholder="RFC">
                    </div>
                </div>
                <ul id="lista-carrito" class="list-group list-group-flush mb-3"></ul>
                <div class="d-flex justify-content-between h5 fw-bold">
                    <span>Total:</span>
                    <span class="text-primary" id="total-precio">$0.00</span>
                </div>
            </div>
            <div class="modal-footer flex-column border-0 pt-0">
                <div class="d-flex w-100 gap-2 mb-2">
                    <button class="btn btn-outline-warning w-50 rounded-pill fw-bold" onclick="enviarPedido('cotizacion')">Solo Cotizar</button>
                    <button class="btn btn-gold w-50 rounded-pill fw-bold" onclick="enviarPedido('pedido')">Hacer Pedido</button>
                </div>
                <button class="btn btn-link text-muted btn-sm text-decoration-none" onclick="borrarTodo()">Vaciar</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    // --- INICIALIZACIÓN ---
    AOS.init();
    
    // Variables Globales del Estado
    let carrito = JSON.parse(localStorage.getItem('carrito_v2')) || [];
    let tempProducto = null; // Para guardar temporalmente al dar clic en '+'
    let currentProductoData = {}; // Para el modal de detalles
    
    // Instancias de Modales Bootstrap
    const modalCantidadBootstrap = new bootstrap.Modal(document.getElementById('modalCantidad'));
    const modalDetallesBootstrap = new bootstrap.Modal(document.getElementById('modalDetalles'));
    const modalCarritoBootstrap = new bootstrap.Modal(document.getElementById('modalCarrito'));

    // Render inicial
    renderizar();

    // --- LÓGICA DE BÚSQUEDA ---
    const buscador = document.getElementById('buscadorJS');
    if(buscador){
        buscador.addEventListener('keyup', function(e) {
            const texto = e.target.value.toLowerCase();
            document.querySelectorAll('.item-producto').forEach(item => {
                const nombre = item.getAttribute('data-nombre');
                // Operador ternario: Si coincide muestra, si no oculta
                item.style.display = nombre.includes(texto) ? 'block' : 'none';
            });
        });
    }

    // --- LÓGICA DE DETALLES DEL PRODUCTO ---
    async function verDetalles(ref, nombre, desc, precio, imgMain, id) {
        // Guardar estado actual
        currentProductoData = { id, nombre, precio };

        // Llenar UI del Modal
        document.getElementById('detalleTitulo').innerText = nombre;
        document.getElementById('detallePrecio').innerText = "$" + precio.toFixed(2);
        document.getElementById('detalleDesc').innerHTML = desc || '<em class="text-muted">Sin descripción.</em>';
        document.getElementById('inputCantidadDetalle').value = 1;

        // Configurar imagen principal
        const imgPrincipal = document.getElementById('imgPrincipal');
        imgPrincipal.src = imgMain;
        
        // Loader para galería
        const contenedor = document.getElementById('galeriaContenedor');
        contenedor.innerHTML = '<div class="spinner-border spinner-border-sm text-warning mx-auto"></div>';
        
        modalDetallesBootstrap.show();

        // Cargar imágenes adicionales via AJAX
        try {
            const res = await fetch(`obtener_fotos.php?ref=${ref}&t=${Date.now()}`);
            const fotos = await res.json();
            contenedor.innerHTML = ''; 

            // Insertar miniaturas
            let htmlFotos = `<img src="${imgMain}" class="thumb-img active" onclick="cambiarImagen(this.src, this)">`;
            if (fotos.length) {
                fotos.forEach(url => {
                    if(url !== imgMain) {
                        htmlFotos += `<img src="${encodeURI(url)}" class="thumb-img" onclick="cambiarImagen(this.src, this)">`;
                    }
                });
            }
            contenedor.innerHTML = htmlFotos;
        } catch (e) { 
            contenedor.innerHTML = '<small class="text-muted">Error cargando galería.</small>'; 
        }
    }

    // Intercambiar foto principal
    function cambiarImagen(src, elemento) {
        const main = document.getElementById('imgPrincipal');
        main.style.opacity = 0; 
        setTimeout(() => {
            main.src = src;
            main.style.opacity = 1;
        }, 200);
        
        document.querySelectorAll('.thumb-img').forEach(img => img.classList.remove('active'));
        elemento.classList.add('active');
    }

    // --- LÓGICA DEL CARRITO ---
    
    // Opción 1: Agregar desde lista rápida (+)
    function prepararAgregar(id, nombre, precio) {
        tempProducto = { id, nombre, precio };
        document.getElementById('lblProductoSeleccionado').innerText = nombre;
        document.getElementById('inputCantidadModal').value = 1;
        modalCantidadBootstrap.show();
    }

    function confirmarAgregar() {
        let cant = parseInt(document.getElementById('inputCantidadModal').value);
        if (cant < 1) return;
        agregarAlCarrito(tempProducto, cant);
        modalCantidadBootstrap.hide();
    }

    // Opción 2: Agregar desde Modal Detalles
    function agregarDesdeDetalle() {
        let cant = parseInt(document.getElementById('inputCantidadDetalle').value);
        if (cant < 1) return;
        agregarAlCarrito(currentProductoData, cant);
        modalDetallesBootstrap.hide();
    }

    // Función centralizada para modificar el array carrito
    function agregarAlCarrito(producto, cantidad) {
        let exist = carrito.find(i => i.id == producto.id);
        if (exist) {
            exist.cant += cantidad; 
        } else {
            carrito.push({ ...producto, cant: cantidad });
        }
        guardar();
        // Feedback visual (Toast o Alert)
        // alert("Agregado al carrito"); 
    }

    function eliminar(i) {
        carrito.splice(i, 1);
        guardar();
    }

    function borrarTodo() {
        carrito = [];
        guardar();
    }

    function guardar() {
        localStorage.setItem('carrito_v2', JSON.stringify(carrito));
        renderizar();
    }

    function renderizar() {
        const lista = document.getElementById('lista-carrito');
        lista.innerHTML = '';
        let total = 0;
        
        if(carrito.length === 0) {
            lista.innerHTML = '<div class="text-center text-muted small py-2">Tu carrito está vacío.</div>';
        }
        
        carrito.forEach((item, index) => {
            total += item.precio * item.cant;
            lista.innerHTML += `
                <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                    <div class="small lh-1">
                        <span class="fw-bold text-dark">${item.nombre}</span><br>
                        <span class="text-muted" style="font-size:0.85rem">$${item.precio.toFixed(2)} x ${item.cant}</span>
                    </div>
                    <i class="bi bi-x-circle text-danger cursor-pointer" onclick="eliminar(${index})" title="Eliminar"></i>
                </li>`;
        });
        
        document.getElementById('contador').innerText = carrito.length;
        document.getElementById('total-precio').innerText = '$' + total.toFixed(2);
    }

    // --- PROCESAR PEDIDO ---
    async function enviarPedido(tipo) {
        const c = document.getElementById('cliente').value;
        const e = document.getElementById('email').value;
        const f = document.getElementById('fecha').value;
        
        if (!c || !e || !f || carrito.length === 0) {
            alert("Por favor completa Nombre, Email, Fecha y agrega productos.");
            return;
        }

        if(!confirm(`¿Estás seguro de generar esta ${tipo}?`)) return;

        // Feedback de carga en el botón
        const btn = event.target;
        const txtOriginal = btn.innerHTML;
        btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Enviando...';
        btn.disabled = true;

        try {
            const res = await fetch('procesar_pedido.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    cliente: c, email: e, fecha: f,
                    telefono: document.getElementById('telefono').value,
                    direccion: document.getElementById('direccion').value,
                    cp: document.getElementById('cp').value,
                    ciudad: document.getElementById('ciudad').value,
                    rfc: document.getElementById('rfc').value,
                    items: carrito, tipo: tipo
                })
            });
            const json = await res.json();
            
            if (json.success) {
                borrarTodo();
                modalCarritoBootstrap.hide();
                alert(`¡Éxito! Tu referencia es: ${json.ref}. Revisa tu correo electrónico.`);
            } else { 
                alert("Error del servidor: " + json.message); 
            }
        } catch (err) { 
            alert("Error de conexión. Intenta nuevamente."); 
        } finally { 
            btn.innerHTML = txtOriginal; 
            btn.disabled = false; 
        }
    }
</script>
</body>
</html>