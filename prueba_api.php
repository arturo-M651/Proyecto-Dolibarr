<?php
/**
 * ==============================================================================
 * PRUEBA_API.PHP - V6 MOBILE OPTIMIZED (RESPONSIVE + TOUCH FRIENDLY)
 * ==============================================================================
 */

require_once 'config.php'; 

// --- CONFIGURACIÓN API ---
$api_url = DOL_BASE_URL; 
$api_key = DOL_API_KEY;

function callAPI($url, $api_key) {
    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => array("DOLAPIKEY: " . $api_key, "Accept: application/json"),
        CURLOPT_TIMEOUT => 10
    ));
    $response = curl_exec($curl);
    if(curl_errno($curl)) { curl_close($curl); return []; }
    curl_close($curl);
    return json_decode($response, true);
}

// 1. OBTENER CATEGORÍAS
$lista_categorias = callAPI($api_url . "/categories?type=product&sortfield=label&sortorder=ASC", $api_key);
$cat_id = isset($_GET['cat']) ? $_GET['cat'] : '';

// 2. TÍTULO DINÁMICO
$titulo_pagina = "Nuestra Colección";
if ($cat_id && is_array($lista_categorias)) {
    foreach($lista_categorias as $c) {
        if($c['id'] == $cat_id) { $titulo_pagina = $c['label']; break; }
    }
}

// 3. OBTENER PRODUCTOS
$productos = [];
if ($cat_id) {
    $endpoint = "/products?sortfield=t.ref&sortorder=ASC&category=" . $cat_id;
    $productos = callAPI($api_url . $endpoint, $api_key);
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Catálogo | Carpas Montes</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Lato:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos.css">
    
    <style>
        /* Ajuste de altura del carrusel en móvil */
        .carousel-item { height: 480px; transition: height 0.3s ease; }
        
        @media (max-width: 768px) {
            .carousel-item { height: 280px !important; } /* Más bajo en cel */
            .display-5 { font-size: 1.8rem; } /* Texto más chico */
            .navbar-brand img { width: 40px; height: 40px; }
            .navbar-brand span { font-size: 1.2rem !important; }
            
            /* Ajustes del modal en móvil */
            .modal-gallery-area { height: auto !important; min-height: 300px; }
            .main-image-container { height: 250px !important; }
            
            /* Filtros pegajosos más compactos */
            .sticky-filters { top: 60px; padding-top: 10px; padding-bottom: 10px; }
            .cat-pill { padding: 6px 12px; font-size: 0.85rem; }
        }
        
        /* Canvas Responsive */
        canvas#canvasPlano {
            width: 100% !important;
            height: auto !important;
            max-height: 400px;
        }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="index.php">
             <div class="d-flex align-items-center">
               <img src="img/logo.png" width="50" height="50" alt="Logo" onerror="this.style.display='none'">
                <span class="fw-bold fs-3 ms-2" style="color: var(--montes-cyan, #00b4db);">CARPAS</span>
                <span class="fw-bold fs-3 ms-1" style="color: var(--montes-dark, #0e4c81);">MONTES</span>
            </div>
        </a>

        <div class="d-flex align-items-center gap-3">
            <a href="index.php" class="text-decoration-none fw-bold text-dark small d-none d-lg-block">
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
            <div class="col-12 col-md-8">
                <div class="d-flex align-items-center gap-2 overflow-auto no-scrollbar" style="white-space: nowrap; padding-bottom: 5px;">
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
            <div class="col-12 col-md-4">
                <?php if ($cat_id): ?>
                <div class="search-container d-flex align-items-center bg-white px-3 py-1 rounded-pill border shadow-sm">
                    <i class="bi bi-search text-muted small"></i>
                    <input type="text" id="buscadorJS" class="search-input bg-transparent border-0 ms-2 w-100" placeholder="Buscar..." style="font-size: 0.9rem; outline:none;">
                </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>

<div class="container py-4" style="min-height: 80vh;">

    <?php if (!$cat_id): ?>
        
        <div id="carruselHome" class="carousel slide mb-4 rounded-4 overflow-hidden shadow-lg" data-bs-ride="carousel" data-bs-interval="4000">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carruselHome" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#carruselHome" data-bs-slide-to="1"></button>
                <button type="button" data-bs-target="#carruselHome" data-bs-slide-to="2"></button>
                <button type="button" data-bs-target="#carruselHome" data-bs-slide-to="3"></button>
                <button type="button" data-bs-target="#carruselHome" data-bs-slide-to="4"></button>
            </div>

            <div class="carousel-inner">
                <div class="carousel-item active"> 
                    <img src="carrusel/15x30.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Evento" onerror="this.src='https://placehold.co/800x600/0e4c81/ffffff?text=Evento'">
                    <div class="carousel-caption p-3 rounded-3 mb-4 mb-md-0" style="background: rgba(0, 0, 0, 0.5); backdrop-filter: blur(2px);">
                        <h2 class="display-5 fw-bold text-warning mb-0">Eventos Inolvidables</h2>
                        <p class="fs-6 text-white d-none d-md-block">Todo lo necesario para tu celebración.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="carrusel/Carpa_Luces.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Luces">
                    <div class="carousel-caption p-3 rounded-3 mb-4 mb-md-0" style="background: rgba(0, 0, 0, 0.5); backdrop-filter: blur(2px);">
                        <h2 class="display-5 fw-bold text-warning mb-0">Ambiente Mágico</h2>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="carrusel/carpa-hule.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Carpa">
                     <div class="carousel-caption p-3 rounded-3 mb-4 mb-md-0" style="background: rgba(0, 0, 0, 0.5); backdrop-filter: blur(2px);">
                        <h2 class="display-5 fw-bold text-warning mb-0">Material de Calidad</h2>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="carrusel/arcoiris.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Decoración">
                     <div class="carousel-caption p-3 rounded-3 mb-4 mb-md-0" style="background: rgba(0, 0, 0, 0.5); backdrop-filter: blur(2px);">
                        <h2 class="display-5 fw-bold text-warning mb-0">Para todo tipo de Entorno</h2>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="carrusel/carpa.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Calidad">
                     <div class="carousel-caption p-3 rounded-3 mb-4 mb-md-0" style="background: rgba(0, 0, 0, 0.5); backdrop-filter: blur(2px);">
                        <h2 class="display-5 fw-bold text-warning mb-0">Elegancia hacia sus Invitados</h2>
                    </div>
                </div>
            </div>
            
            <button class="carousel-control-prev" type="button" data-bs-target="#carruselHome" data-bs-slide="prev"><span class="carousel-control-prev-icon"></span></button>
            <button class="carousel-control-next" type="button" data-bs-target="#carruselHome" data-bs-slide="next"><span class="carousel-control-next-icon"></span></button>
        </div>

       <div class="benefits-section mb-5" data-aos="fade-up">
            <div class="row g-3 g-md-4">
                <div class="col-12 col-md-4">
                    <div class="benefit-card d-flex align-items-center p-3 h-100">
                        <div class="benefit-icon-wrapper me-3"><i class="bi bi-stopwatch fs-4"></i></div>
                        <div>
                            <h5 class="fw-bold mb-1">Puntualidad</h5>
                            <p class="text-muted small mb-0">Montaje listo a tiempo.</p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-4">
                    <div class="benefit-card d-flex align-items-center p-3 h-100">
                        <div class="benefit-icon-wrapper me-3"><i class="bi bi-stars fs-4"></i></div>
                        <div>
                            <h5 class="fw-bold mb-1">Limpieza Total</h5>
                            <p class="text-muted small mb-0">Mobiliario impecable.</p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-4">
                    <div class="benefit-card d-flex align-items-center p-3 h-100">
                        <div class="benefit-icon-wrapper me-3"><i class="bi bi-shield-check fs-4"></i></div>
                        <div>
                            <h5 class="fw-bold mb-1">Seguridad</h5>
                            <p class="text-muted small mb-0">Instalación profesional.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mb-4">
            <h2 class="fw-bold text-dark h3">Explora por Categorías</h2>
            <div style="width: 50px; height: 3px; background: var(--gold); margin: 8px auto;"></div>
        </div>

        <div class="row g-3">
            <?php
            if (is_array($lista_categorias) && !isset($lista_categorias['error'])) {
                foreach ($lista_categorias as $cat) {
                    $img_cat = "img_categorias/" . $cat['id'] . ".jpg";
            ?>
                <div class="col-6 col-md-4" data-aos="fade-up">
                    <a href="?cat=<?php echo $cat['id']; ?>" class="cat-card text-decoration-none">
                        <img src="<?php echo $img_cat; ?>" alt="<?php echo $cat['label']; ?>" class="transition-hover"
                             onerror="this.src='https://placehold.co/600x400/0e4c81/ffffff?text=<?php echo urlencode($cat['label']); ?>';">
                        <div class="cat-overlay position-absolute bottom-0 start-0 w-100 p-2 text-center text-md-start">
                            <h3 class="mb-0 text-white fw-bold d-none d-md-block"><?php echo $cat['label']; ?></h3>
                            <h6 class="mb-0 text-white fw-bold d-block d-md-none small"><?php echo $cat['label']; ?></h6> </div>
                    </a>
                </div>
            <?php } } ?>
        </div>
    
    <?php else: ?>
        <div class="d-flex align-items-center justify-content-between mb-3">
            <h2 class="fw-bold text-dark mb-0 h4 text-truncate"><?php echo $titulo_pagina; ?></h2>
            <a href="prueba_api.php" class="btn btn-outline-secondary btn-sm rounded-pill px-3"><i class="bi bi-arrow-left"></i> <span class="d-none d-md-inline">Volver</span></a>
        </div>
        
        <div class="row g-3" id="contenedorProductos">
            <?php
            if (isset($productos['error']) || empty($productos)) {
                echo "<div class='col-12 text-center py-5'><i class='bi bi-box-seam display-1 text-muted'></i><p class='mt-3 lead'>No hay productos.</p></div>";
            } else {
                foreach ($productos as $producto) {
                    $id = $producto['id'];
                    $ref = $producto['ref'];
                    $label = addslashes($producto['label']); 
                    $price = (float)$producto['price']; 
                    $desc = isset($producto['description']) ? addslashes(str_replace(["\r", "\n"], " ", $producto['description'])) : '';
                    $img_name = isset($producto['last_main_doc']) ? $producto['last_main_doc'] : $ref . ".jpg";
                    $img_src = "imagen.php?ref=" . $ref . "&file=" . $img_name;
            ?>
                <div class="col-6 col-md-4 col-lg-3 item-producto" data-nombre="<?php echo strtolower($label); ?>" data-aos="fade-in">
                    <div class="product-card shadow-sm bg-white rounded-3 border-0 h-100 d-flex flex-column">
                        <div class="product-img-wrapper position-relative cursor-pointer" style="height: 160px; md-height: 220px; overflow: hidden;"
                             onclick="verDetalles('<?php echo $ref; ?>', '<?php echo $label; ?>', '<?php echo $desc; ?>', <?php echo $price; ?>)">
                            <img src="<?php echo $img_src; ?>" class="w-100 h-100 object-fit-cover" 
                                 onerror="this.src='https://placehold.co/300x300/f8fafc/0e4c81?text=Sin+Foto'">
                            <span class="position-absolute bottom-0 end-0 m-1 m-md-2 badge bg-white text-dark shadow fw-bold border border-warning price-badge" style="font-size: 0.8rem;">
                                $<?php echo number_format($price, 2); ?>
                            </span>
                        </div>
                        <div class="p-2 p-md-3 d-flex flex-column flex-grow-1">
                            <h6 class="fw-bold text-dark mb-1 text-truncate small-md-normal"><?php echo $label; ?></h6>
                            
                            <div class="mt-auto d-flex gap-2">
                                <button class="btn btn-light text-primary fw-bold btn-sm flex-grow-1" 
                                    onclick="verDetalles('<?php echo $ref; ?>', '<?php echo $label; ?>', '<?php echo $desc; ?>', <?php echo $price; ?>, '<?php echo $img_src; ?>', <?php echo $id; ?>)">
                                    Ver
                                </button>
                                <button class="btn btn-gold btn-sm rounded-circle shadow-sm d-flex align-items-center justify-content-center" style="width:30px; height:30px;"
                                        onclick="prepararAgregar(<?php echo $id; ?>, '<?php echo $label; ?>', <?php echo $price; ?>)">
                                    <i class="bi bi-plus-lg"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            <?php } } ?>
        </div>
    <?php endif; ?>
</div>

<footer class="bg-dark text-white pt-4 pb-3 mt-5">
    <div class="container text-center text-md-start">
        <div class="row">
            <div class="col-md-4 mb-3">
                <h5 class="text-warning fw-bold h6">Carpas Montes</h5>
                <p class="text-white-50 small mb-0">Calidad y servicio en Amecameca y alrededores.</p>
            </div>
            <div class="col-md-4 mb-3">
                <h5 class="fw-bold h6">Contacto</h5>
                <ul class="list-unstyled text-white-50 small mb-0">
                    <li><i class="bi bi-whatsapp me-1"></i> 55 1234 5678</li>
                    <li><i class="bi bi-geo-alt me-1"></i> Amecameca, Edo. Méx</li>
                </ul>
            </div>
        </div>
        <hr class="border-secondary my-3">
        <div class="text-center text-secondary small">
            &copy; 2026 Carpas Montes.
        </div>
    </div>
</footer>

<a href="https://wa.me/525512345678" target="_blank" class="btn-whatsapp-float shadow-lg">
    <i class="bi bi-whatsapp"></i>
</a>

<div class="modal fade" id="modalCantidad" tabindex="-1">
    <div class="modal-dialog modal-sm modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4">
            <div class="modal-body text-center p-3">
                <h6 class="fw-bold mb-3 small" id="lblProductoSeleccionado"></h6>
                <div class="input-group mb-3 justify-content-center">
                     <input type="number" id="inputCantidadModal" class="form-control text-center" value="1" min="1" style="max-width: 80px;">
                </div>
                <button class="btn btn-gold w-100 btn-sm rounded-pill" onclick="confirmarAgregar()">Agregar al Carrito</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalDetalles" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable"> <div class="modal-content border-0 rounded-4 shadow-lg overflow-hidden">
            <div class="modal-header border-0 p-2 position-absolute end-0 top-0 z-3">
                 <button type="button" class="btn-close bg-white rounded-circle p-2 shadow-sm opacity-100" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-0">
                <div class="row g-0">
                    <div class="col-lg-7 bg-light position-relative">
                          <div class="modal-gallery-area p-3 h-100 d-flex flex-column"> 
                                <ul class="nav nav-pills mb-2 justify-content-center gap-2" id="pills-tab" role="tablist">
                                    <li class="nav-item">
                                        <button class="nav-link active rounded-pill py-1 px-3 small fw-bold" id="pills-foto-tab" data-bs-toggle="pill" data-bs-target="#pills-foto" type="button"><i class="bi bi-images me-1"></i> Fotos</button>
                                    </li>
                                    <li class="nav-item">
                                        <button class="nav-link rounded-pill py-1 px-3 small fw-bold" id="pills-plano-tab" data-bs-toggle="pill" data-bs-target="#pills-plano" type="button" onclick="iniciarRender()"><i class="bi bi-grid-3x3 me-1"></i> Simulador</button>
                                    </li>
                                </ul>
                                <div class="tab-content flex-grow-1">
                                    <div class="tab-pane fade show active" id="pills-foto">
                                        <div class="main-image-container mb-2 d-flex align-items-center justify-content-center bg-white rounded-3" style="height: 300px;"> 
                                            <img id="imgPrincipal" src="" class="mw-100 mh-100 object-fit-contain">
                                        </div>
                                        <div class="thumbnails-row d-flex gap-2 overflow-auto" id="galeriaContenedor"></div>
                                    </div>
                                    <div class="tab-pane fade h-100" id="pills-plano">
                                        <div class="card border-0 shadow-sm h-100" id="contenedorCanvas">
                                            <div class="card-body p-1 bg-white rounded-3 d-flex align-items-center justify-content-center overflow-hidden position-relative" style="min-height: 300px;">
                                                <canvas id="canvasPlano"></canvas>
                                                <div class="position-absolute bottom-0 end-0 m-2 badge bg-dark shadow-sm opacity-75">
                                                    <i class="bi bi-arrows-fullscreen"></i> <span id="lblAreaTotal">0</span> m²
                                                </div>
                                            </div>
                                      </div>
                                    </div>    
                              </div>
                           </div>
                        </div>
                    
                    <div class="col-lg-5">
                        <div class="modal-info-area d-flex flex-column h-100 p-4">
                            <h4 class="fw-bold mb-1" id="detalleTitulo" style="font-family: 'Playfair Display', serif;"></h4>
                            <h3 class="text-gold fw-bold mb-3" id="detallePrecio"></h3>
                            
                            <div class="mb-4 flex-grow-1">
                                <h6 class="fw-bold small text-dark mb-1">Descripción:</h6>
                                <p class="text-muted small lh-sm" id="detalleDesc" style="max-height: 100px; overflow-y: auto;"></p>
                            </div>

                            <div class="mt-auto pt-3 border-top">
                                <div id="panelMedidas" class="mb-3 p-3 bg-light rounded-3 border" style="display:none;">
                                    <div class="row g-2 align-items-center">
                                        <div class="col-5">
                                            <label class="small text-muted d-block">Ancho (m)</label>
                                            <input type="number" class="form-control form-control-sm fw-bold bg-white" id="inputAncho" readonly>
                                        </div>
                                        <div class="col-2 text-center pt-3 text-muted">x</div>
                                        <div class="col-5">
                                            <label class="small text-muted d-block">Largo (m)</label>
                                            <input type="number" class="form-control form-control-sm fw-bold border-warning" id="inputLargo" value="5" min="3" oninput="actualizarCalculosRender()">
                                        </div>
                                    </div>
                                    <div class="mt-2 text-center">
                                        <span class="badge bg-warning text-dark"><i class="bi bi-people"></i> ~<span id="lblCapacidad">0</span> personas</span>
                                    </div>
                                </div>
                                <div class="d-flex gap-2 align-items-end">
                                    <div id="divCantidadNormal" class="w-25">
                                        <label class="small fw-bold mb-1">Cant:</label>
                                        <input type="number" id="inputCantidadDetalle" class="form-control text-center fw-bold" value="1" min="1">
                                    </div>
                                    <button class="btn btn-gold flex-grow-1 rounded-pill shadow-sm" onclick="agregarDesdeDetalle()">
                                        <i class="bi bi-cart-plus me-1"></i> Agregar <span id="lblPrecioTotal" class="small d-block d-md-inline ms-md-1 opacity-75"></span>
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
    <div class="modal-dialog modal-dialog-scrollable modal-fullscreen-sm-down"> <div class="modal-content rounded-0 rounded-md-4 border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title"><i class="bi bi-cart3"></i> Tu Pedido</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="bg-light p-3 rounded mb-3 border small">
                    <input type="text" id="cliente" class="form-control form-control-sm mb-2" placeholder="Nombre Completo *">
                    <input type="email" id="email" class="form-control form-control-sm mb-2" placeholder="Email *">
                    <input type="date" id="fecha" class="form-control form-control-sm mb-2">
                    <a class="text-decoration-none fw-bold" data-bs-toggle="collapse" href="#extraFields">+ Dirección / RFC</a>
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
                <div class="d-flex justify-content-between h5 fw-bold px-2">
                    <span>Total:</span>
                    <span class="text-primary" id="total-precio">$0.00</span>
                </div>
            </div>
            <div class="modal-footer border-0 pt-0">
                <div class="row w-100 g-2">
                    <div class="col-6">
                        <button class="btn btn-outline-warning w-100 rounded-pill fw-bold small" onclick="enviarPedido('cotizacion')">Solo Cotizar</button>
                    </div>
                    <div class="col-6">
                        <button class="btn btn-gold w-100 rounded-pill fw-bold small" onclick="enviarPedido('pedido')">Pedir Ahora</button>
                    </div>
                    <div class="col-12 text-center mt-2">
                         <button class="btn btn-link text-muted btn-sm text-decoration-none" onclick="borrarTodo()">Vaciar Carrito</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({ once: true, disable: 'mobile' }); // Desactivar animaciones pesadas en movil
    
    let carrito = JSON.parse(localStorage.getItem('carrito_v2')) || [];
    let tempProducto = null; 
    let currentProductoId = null;
    let currentProductoNombre = "";
    let currentProductoPrecio = 0;
    
    // Variables Modulares
    let esCarpaModular = false;
    let anchoFijo = 0;
    
    const modalCantidadBootstrap = new bootstrap.Modal(document.getElementById('modalCantidad'));
    const modalDetallesBootstrap = new bootstrap.Modal(document.getElementById('modalDetalles'));
    const modalCarritoBootstrap = new bootstrap.Modal(document.getElementById('modalCarrito'));

    renderizar();

    const buscador = document.getElementById('buscadorJS');
    if(buscador){
        buscador.addEventListener('keyup', function(e) {
            const texto = e.target.value.toLowerCase();
            document.querySelectorAll('.item-producto').forEach(item => {
                const nombre = item.getAttribute('data-nombre');
                item.style.display = nombre.includes(texto) ? 'block' : 'none';
            });
        });
    }

    async function verDetalles(ref, nombre, desc, precio, imgMain, id) {
        currentProductoId = id;
        currentProductoNombre = nombre;
        currentProductoPrecio = precio;

        document.getElementById('detalleTitulo').innerText = nombre;
        document.getElementById('detalleDesc').innerHTML = desc || '<em class="text-muted">Sin descripción.</em>';
        document.getElementById('imgPrincipal').src = imgMain;
        document.getElementById('inputCantidadDetalle').value = 1;

        if (nombre.toLowerCase().includes("ancho") || nombre.toLowerCase().includes("carpa") || nombre.toLowerCase().includes("toldo")) {
            esCarpaModular = true;
            const match = nombre.match(/(\d+)/);
            anchoFijo = match ? parseInt(match[0]) : 10; 
            
            document.getElementById('panelMedidas').style.display = 'block';
            document.getElementById('divCantidadNormal').style.display = 'none'; 
            document.getElementById('pills-plano-tab').style.display = 'block'; 
            
            document.getElementById('inputAncho').value = anchoFijo;
            document.getElementById('inputLargo').value = 5; 
            document.getElementById('detallePrecio').innerText = "$" + precio.toFixed(2) + " / m²";
            document.getElementById('lblPrecioTotal').innerText = ""; 

            actualizarCalculosRender(); 

        } else {
            esCarpaModular = false;
            document.getElementById('panelMedidas').style.display = 'none';
            document.getElementById('divCantidadNormal').style.display = 'block';
            document.getElementById('pills-plano-tab').style.display = 'none'; 
            
            document.getElementById('detallePrecio').innerText = "$" + precio.toFixed(2);
            document.getElementById('lblPrecioTotal').innerText = "";
            
            const tabBtn = document.querySelector('#pills-foto-tab');
            const tab = new bootstrap.Tab(tabBtn);
            tab.show();
        }

        modalDetallesBootstrap.show();

        const contenedor = document.getElementById('galeriaContenedor');
        contenedor.innerHTML = '<div class="spinner-border spinner-border-sm text-warning mx-auto"></div>';

        try {
            const res = await fetch(`obtener_fotos.php?ref=${ref}&t=${Date.now()}`);
            const fotos = await res.json();
            contenedor.innerHTML = ''; 
            
            let htmlFotos = `<img src="${imgMain}" class="thumb-img border active" style="width:60px; height:60px; object-fit:cover; border-radius:8px; cursor:pointer;" onclick="cambiarImagen(this.src, this)">`;
            if (fotos.length) {
                fotos.forEach(url => {
                    if(url !== imgMain) {
                        htmlFotos += `<img src="${encodeURI(url)}" class="thumb-img border" style="width:60px; height:60px; object-fit:cover; border-radius:8px; cursor:pointer;" onclick="cambiarImagen(this.src, this)">`;
                    }
                });
            }
            contenedor.innerHTML = htmlFotos;
        } catch (e) { 
            contenedor.innerHTML = ''; 
        }
    }

    // --- RENDERIZADO FLUIDO (Responsive) ---
    function iniciarRender() {
        requestAnimationFrame(dibujarPlano);
    }

    function actualizarCalculosRender() {
        if(!esCarpaModular) return;
        const largo = parseInt(document.getElementById('inputLargo').value) || 0;
        const ancho = anchoFijo;
        const area = largo * ancho;
        const precioM2 = currentProductoPrecio;
        const total = precioM2 * area;
        
        document.getElementById('lblPrecioTotal').innerText = `($${total.toLocaleString('es-MX')})`; // Mostramos el total al lado del boton
        document.getElementById('lblCapacidad').innerText = Math.floor(area/1.5);
        document.getElementById('lblAreaTotal').innerText = area;

        dibujarPlano();
    }

    function dibujarPlano() {
        const canvas = document.getElementById('canvasPlano');
        if (!canvas) return;
        
        // --- TRUCO RESPONSIVE: Ajustar resolución al tamaño real ---
        const contenedor = document.getElementById('contenedorCanvas');
        const widthReal = contenedor.clientWidth; // Ancho del div padre
        const heightReal = Math.min(400, widthReal * 0.8); // Alto proporcional
        
        canvas.width = widthReal;
        canvas.height = heightReal;
        // ------------------------------------------------------------
        
        const ctx = canvas.getContext('2d');
        const largo = parseInt(document.getElementById('inputLargo').value) || 5;
        const ancho = anchoFijo;

        // Escala dinámica basada en el nuevo tamaño
        const padding = 20; // Menos padding en movil
        const maxW = canvas.width - (padding * 2);
        const maxH = canvas.height - (padding * 2);
        const scaleX = maxW / ancho; 
        const scaleY = maxH / largo;
        const escala = Math.min(scaleX, scaleY, 40); // Max 40px por metro

        const cx = canvas.width / 2;
        const cy = canvas.height / 2;
        const rectW = ancho * escala;
        const rectH = largo * escala;
        const startX = cx - (rectW / 2);
        const startY = cy - (rectH / 2);

        // Limpiar
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        // Grid (Más sutil)
        ctx.beginPath();
        ctx.strokeStyle = "#e9ecef"; // Gris muy claro
        ctx.lineWidth = 1;
        for (let i = 0; i <= ancho; i++) ctx.strokeRect(startX + (i * escala), startY, 0, rectH); 
        for (let i = 0; i <= largo; i++) ctx.strokeRect(startX, startY + (i * escala), rectW, 0); 
        
        // Carpa
        ctx.fillStyle = "rgba(14, 76, 129, 0.1)"; // Azul muy suave
        ctx.fillRect(startX, startY, rectW, rectH);
        ctx.strokeStyle = "#0e4c81"; // Azul fuerte
        ctx.lineWidth = 2;
        ctx.strokeRect(startX, startY, rectW, rectH);

        // Cotas
        ctx.fillStyle = "#000";
        ctx.font = "bold 12px Arial";
        ctx.textAlign = "center";
        ctx.fillText(`${ancho}m`, cx, startY - 5);
        
        ctx.save();
        ctx.translate(startX - 10, cy);
        ctx.rotate(-Math.PI / 2);
        ctx.fillText(`${largo}m`, 0, 0);
        ctx.restore();
    }

    function cambiarImagen(src, elemento) {
        document.getElementById('imgPrincipal').src = src;
        document.querySelectorAll('.thumb-img').forEach(img => img.classList.remove('border-primary'));
        elemento.classList.add('border-primary'); // Highlight con borde azul
    }

    // --- CARRITO ---
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

    function agregarDesdeDetalle() {
        let itemParaCarrito = {};
        if (esCarpaModular) {
            const largo = parseInt(document.getElementById('inputLargo').value);
            const ancho = anchoFijo;
            const area = largo * ancho;
            itemParaCarrito = {
                id: currentProductoId,
                nombre: `${currentProductoNombre} (${ancho}x${largo}m)`, // Nombre más corto para móvil
                precio: currentProductoPrecio, 
                cant: area, 
                esModular: true
            };
        } else {
            const cant = parseInt(document.getElementById('inputCantidadDetalle').value);
            itemParaCarrito = {
                id: currentProductoId,
                nombre: currentProductoNombre,
                precio: currentProductoPrecio,
                cant: cant
            };
        }
        
        let exist = carrito.find(i => i.nombre === itemParaCarrito.nombre);
        if (exist) exist.cant += itemParaCarrito.cant;
        else carrito.push(itemParaCarrito);
        
        guardar();
        modalDetallesBootstrap.hide();
        // Feedback visual en vez de alert intrusivo
        const btnCart = document.querySelector('button[data-bs-target="#modalCarrito"]');
        btnCart.classList.add('btn-success');
        setTimeout(() => btnCart.classList.remove('btn-success'), 500);
    }

    function agregarAlCarrito(producto, cantidad) {
        let exist = carrito.find(i => i.id == producto.id);
        if (exist) exist.cant += cantidad; 
        else carrito.push({ ...producto, cant: cantidad });
        guardar();
    }

    function eliminar(i) { carrito.splice(i, 1); guardar(); }
    function borrarTodo() { carrito = []; guardar(); }
    
    function guardar() {
        localStorage.setItem('carrito_v2', JSON.stringify(carrito));
        renderizar();
    }

    function renderizar() {
        const lista = document.getElementById('lista-carrito');
        lista.innerHTML = '';
        let total = 0;
        
        if(carrito.length === 0) lista.innerHTML = '<div class="text-center text-muted small py-3">Carrito vacío</div>';
        
        carrito.forEach((item, index) => {
            total += item.precio * item.cant;
            let unidad = item.esModular ? "m²" : "";
            lista.innerHTML += `
                <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-2">
                    <div class="lh-1">
                        <span class="fw-bold text-dark small">${item.nombre}</span><br>
                        <span class="text-muted" style="font-size:0.8rem">$${item.precio.toFixed(2)} x ${item.cant} ${unidad}</span>
                    </div>
                    <button class="btn btn-sm text-danger" onclick="eliminar(${index})"><i class="bi bi-trash"></i></button>
                </li>`;
        });
        
        document.getElementById('contador').innerText = carrito.length;
        document.getElementById('total-precio').innerText = '$' + total.toFixed(2);
    }

    async function enviarPedido(tipo) {
        const c = document.getElementById('cliente').value;
        const e = document.getElementById('email').value;
        const f = document.getElementById('fecha').value;
        
        if (!c || !e || !f || carrito.length === 0) {
            alert("Completa: Nombre, Email y Fecha."); // Mensaje corto
            return;
        }

        if(!confirm(`¿Generar ${tipo}?`)) return;

        const btn = event.target;
        btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span>';
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
                alert(`¡Listo! Referencia: ${json.ref}`);
            } else { 
                alert("Error: " + json.message); 
            }
        } catch (err) { alert("Error de conexión"); } 
        finally { 
            btn.innerHTML = (tipo==='pedido') ? 'Pedir Ahora' : 'Solo Cotizar';
            btn.disabled = false; 
        }
    }
</script>
</body>
</html>