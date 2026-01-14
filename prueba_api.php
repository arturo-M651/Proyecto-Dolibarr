<?php
/**
 * ==============================================================================
 * PRUEBA_API.PHP - V20 (FINAL: SOLO PEDIDOS + SIMULADOR COMPLETO)
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

$lista_categorias = callAPI($api_url . "/categories?type=product&sortfield=label&sortorder=ASC", $api_key);
$cat_id = isset($_GET['cat']) ? $_GET['cat'] : '';

$titulo_pagina = "Nuestra Colección";
if ($cat_id && is_array($lista_categorias)) {
    foreach($lista_categorias as $c) {
        if($c['id'] == $cat_id) { $titulo_pagina = $c['label']; break; }
    }
}

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
        /* CSS ESPECIAL PARA MÓVIL */
        .carousel-item-responsive { height: 450px; transition: height 0.3s ease; }
        @media (max-width: 768px) {
            .carousel-item-responsive { height: 280px !important; }
            .display-5 { font-size: 1.8rem; }
            .navbar-brand img { width: 40px; height: 40px; }
            .navbar-brand span { font-size: 1.2rem !important; }
        }

        /* Filtros con scroll horizontal */
        .filters-scroll-mobile {
            display: flex;
            overflow-x: auto;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
            padding-bottom: 5px;
            gap: 0.5rem;
        }
        .filters-scroll-mobile::-webkit-scrollbar { display: none; } 

        /* Simulador 3D */
        #contenedorCanvas {
            position: relative;
            width: 100%;
            height: 60vh; 
            min-height: 400px;
            background-color: #ffffff;
            background-image: linear-gradient(#f5f5f5 1px, transparent 1px), linear-gradient(90deg, #f5f5f5 1px, transparent 1px);
            background-size: 20px 20px;
            overflow: hidden;
            touch-action: none; 
        }
        
        canvas#canvasPlano {
            position: absolute; top: 0; left: 0;
            width: 100%; height: 100%;
            cursor: grab; touch-action: none; 
        }
        canvas#canvasPlano:active { cursor: grabbing; }

        .canvas-controls {
            position: absolute; bottom: 20px; right: 20px;
            display: flex; flex-direction: column; gap: 8px; z-index: 10;
        }
        .btn-control {
            width: 40px; height: 40px; border-radius: 50%;
            background: white; border: 1px solid #dee2e6;
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            color: #333; transition: all 0.2s; font-size: 1.2rem;
        }
        .btn-control:hover { background: #f8f9fa; transform: translateY(-2px); }

        .view-switch {
            position: absolute; top: 20px; left: 50%; transform: translateX(-50%);
            background: white; padding: 4px; border-radius: 30px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1); display: flex; gap: 5px; z-index: 10;
        }
        .view-btn {
            border: none; background: transparent; padding: 6px 15px;
            border-radius: 20px; font-size: 0.85rem; font-weight: bold; color: #666; transition: all 0.2s;
        }
        .view-btn.active {
            background: #0e4c81; color: white; box-shadow: 0 2px 5px rgba(14, 76, 129, 0.3);
        }

        /* LEYENDAS INFORMATIVAS */
        .info-legend {
            position: absolute;
            top: 20px; 
            left: 20px;
            max-width: 200px;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(2px);
            padding: 8px 12px;
            border-radius: 12px;
            border: 1px solid #e0e0e0;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            font-size: 0.75rem;
            color: #555;
            z-index: 10;
            pointer-events: none; 
            display: flex;
            align-items: start;
            gap: 8px;
            line-height: 1.3;
        }
        .info-legend i {
            font-size: 1rem;
            color: #0e4c81; 
            margin-top: 1px;
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
                <div class="filters-scroll-mobile">
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
                <button type="button" data-bs-target="#carruselHome" data-bs-slide-to="2"></button>
                <button type="button" data-bs-target="#carruselHome" data-bs-slide-to="3"></button>
                <button type="button" data-bs-target="#carruselHome" data-bs-slide-to="4"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active carousel-item-responsive">
                    <img src="carrusel/15x30.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Evento" onerror="this.src='https://placehold.co/800x600/0e4c81/ffffff?text=Evento'">
                    <div class="carousel-caption d-none d-md-block p-4 rounded-3" style="background: rgba(0, 0, 0, 0.7); backdrop-filter: blur(4px);">
                        <h2 class="display-5 fw-bold text-warning">Eventos Inolvidables</h2>
                    </div>
                </div>
                <div class="carousel-item carousel-item-responsive"><img src="carrusel/Carpa_Luces.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Luces"></div>
                <div class="carousel-item carousel-item-responsive"><img src="carrusel/carpa-hule.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Carpa"></div>
                <div class="carousel-item carousel-item-responsive"><img src="carrusel/arcoiris.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Decoración"></div>
                <div class="carousel-item carousel-item-responsive"><img src="carrusel/carpa.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Calidad"></div>
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
                <div class="col-6 col-md-4" data-aos="fade-up">
                    <a href="?cat=<?php echo $cat['id']; ?>" class="cat-card text-decoration-none">
                        <img src="<?php echo $img_cat; ?>" alt="<?php echo $cat['label']; ?>" class="transition-hover"
                             onerror="this.onerror=null; this.src='https://placehold.co/600x400/0e4c81/ffffff?text=<?php echo urlencode($cat['label']); ?>';">
                        <div class="cat-overlay position-absolute bottom-0 start-0 w-100">
                            <h3 class="mb-1 text-white fw-bold display-6"><?php echo $cat['label']; ?></h3>
                            <div class="d-flex align-items-center text-warning fw-bold small mt-2">
                                <span>Explorar</span> <i class="bi bi-arrow-right ms-2 animate-arrow"></i>
                            </div>
                        </div>
                    </a>
                </div>
            <?php } } ?>
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
                    $id = $producto['id'];
                    $ref = $producto['ref'];
                    $label = addslashes($producto['label']); 
                    $price = (float)$producto['price']; 
                    $desc = isset($producto['description']) ? addslashes(str_replace(["\r", "\n"], " ", $producto['description'])) : '';
                    $img_name = isset($producto['last_main_doc']) ? $producto['last_main_doc'] : $ref . ".jpg";
                    $img_src = "imagen.php?ref=" . $ref . "&file=" . $img_name;

                    // --- DETECCIÓN INTELIGENTE: ¿ES CARPA? ---
                    $es_modular = false;
                    $keywords = ['carpa', 'toldo', 'ancho', 'estructura'];
                    foreach ($keywords as $kw) {
                        if (stripos($label, $kw) !== false) {
                            $es_modular = true;
                            break;
                        }
                    }
            ?>
                <div class="col-6 col-md-4 col-lg-3 item-producto" data-nombre="<?php echo strtolower($label); ?>" data-aos="zoom-in">
                    <div class="product-card shadow-sm bg-white rounded-4 border-0 h-100 d-flex flex-column">
                        <div class="product-img-wrapper position-relative cursor-pointer" style="height: 220px; overflow: hidden;"
                             onclick="verDetalles('<?php echo $ref; ?>', '<?php echo $label; ?>', '<?php echo $desc; ?>', <?php echo $price; ?>, '<?php echo $img_src; ?>', <?php echo $id; ?>)">
                            <img src="<?php echo $img_src; ?>" class="w-100 h-100 object-fit-cover" onerror="this.src='https://placehold.co/300x300/f8fafc/0e4c81?text=Sin+Foto'">
                            <span class="position-absolute bottom-0 end-0 m-2 badge bg-white text-dark shadow fw-bold border border-warning price-badge">$<?php echo number_format($price, 2); ?> m²</span>
                        </div>
                        <div class="p-3 d-flex flex-column flex-grow-1">
                            <h6 class="fw-bold text-dark mb-1 text-truncate"><?php echo $label; ?></h6>
                            <small class="text-muted mb-3 small product-desc-clamp"><?php echo strip_tags($desc); ?></small>
                            <div class="mt-auto d-flex justify-content-between align-items-center gap-2">
                                <button class="btn btn-light text-primary fw-bold btn-sm flex-grow-1" 
                                    onclick="verDetalles('<?php echo $ref; ?>', '<?php echo $label; ?>', '<?php echo $desc; ?>', <?php echo $price; ?>, '<?php echo $img_src; ?>', <?php echo $id; ?>)">
                                    <i class="bi bi-eye"></i> <?php echo $es_modular ? 'Ver Detalles' : 'Ver'; ?>
                                </button>
                                
                                <?php if (!$es_modular): ?>
                                <button class="btn btn-gold btn-sm rounded-circle shadow-sm" onclick="prepararAgregar(<?php echo $id; ?>, '<?php echo $label; ?>', <?php echo $price; ?>)">
                                    <i class="bi bi-plus-lg"></i>
                                </button>
                                <?php endif; ?>
                            </div>
                        </div>
                    </div>
                </div>
            <?php } } ?>
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
            © 2026 Carpas Montes. Todos los derechos reservados.
        </div>
    </div>
</footer>

<a href="https://wa.me/525512345678" target="_blank" class="btn-whatsapp-float shadow-lg"><i class="bi bi-whatsapp"></i></a>

<div class="modal fade" id="modalCantidad" tabindex="-1">
    <div class="modal-dialog modal-sm modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4">
            <div class="modal-header bg-primary text-white border-0 py-2">
                <h6 class="modal-title small">Cantidad</h6>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center p-3">
                <h6 class="fw-bold mb-3 small" id="lblProductoSeleccionado"></h6>
                <input type="number" id="inputCantidadModal" class="form-control text-center mb-3" value="1" min="1">
                <button class="btn btn-gold w-100 btn-sm rounded-pill" onclick="confirmarAgregar()">Agregar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalCarrito" tabindex="-1">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title"><i class="bi bi-cart3"></i> Tu Pedido</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="bg-light p-3 rounded mb-3 border">
                    <input type="text" id="cliente" class="form-control form-control-sm mb-2" placeholder="Nombre Completo *">
                    <input type="email" id="email" class="form-control form-control-sm mb-2" placeholder="Email *">
                    <input type="date" id="fecha" class="form-control form-control-sm mb-2">
                    <a class="text-decoration-none small fw-bold" data-bs-toggle="collapse" href="#extraFields">+ Dirección / RFC</a>
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
                <div class="row w-100 g-2">
                    <div class="col-12">
                        <button class="btn btn-gold w-100 rounded-pill fw-bold shadow-sm" onclick="enviarPedido('pedido')">
                            <i class="bi bi-check-circle-fill me-2"></i> Confirmar Pedido
                        </button>
                    </div>
                    <div class="col-12 text-center mt-2">
                         <button class="btn btn-link text-muted btn-sm text-decoration-none" onclick="borrarTodo()">Vaciar Carrito</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalDetalles" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 rounded-4 shadow-lg overflow-hidden">
            <div class="modal-header border-0 p-2 position-absolute end-0 top-0 z-3">
                <button type="button" class="btn-close bg-white rounded-circle p-2 shadow-sm opacity-100" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-0">
                <div class="row g-0">
                    <div class="col-lg-8 bg-light position-relative">
                          <div class="modal-gallery-area p-3 h-100 d-flex flex-column"> 
                                <ul class="nav nav-pills mb-2 justify-content-center gap-2" id="pills-tab" role="tablist">
                                    <li class="nav-item">
                                        <button class="nav-link active rounded-pill py-1 px-3 small fw-bold" id="pills-foto-tab" data-bs-toggle="pill" data-bs-target="#pills-foto" type="button"><i class="bi bi-images me-1"></i> Fotos</button>
                                    </li>
                                    <li class="nav-item">
                                        <button class="nav-link rounded-pill py-1 px-3 small fw-bold" id="pills-plano-tab" data-bs-toggle="pill" data-bs-target="#pills-plano" type="button" onclick="init3DView()"><i class="bi bi-box-seam me-1"></i> Simulador</button>
                                    </li>
                                </ul>
                                <div class="tab-content flex-grow-1 position-relative">
                                    <div class="tab-pane fade show active" id="pills-foto">
                                        <div class="main-image-container mb-2 d-flex align-items-center justify-content-center bg-white rounded-3 h-100"> 
                                            <img id="imgPrincipal" src="" class="mw-100 mh-100 object-fit-contain">
                                        </div>
                                        <div class="thumbnails-row d-flex gap-2 overflow-auto" id="galeriaContenedor"></div>
                                    </div>
                                    <div class="tab-pane fade h-100" id="pills-plano">
                                        <div class="card border-0 shadow-sm h-100" id="contenedorCanvas">
                                            
                                            <div id="info2D" class="info-legend">
                                                <i class="bi bi-grid-3x3"></i>
                                                <span>Cuadrícula:<br>1 cuadro = 1 metro</span>
                                            </div>
                                            <div id="info3D" class="info-legend" style="display:none;">
                                                <i class="bi bi-info-circle"></i>
                                                <span>Render referencial.<br>La estructura varía según medidas.</span>
                                            </div>

                                            <div class="view-switch">
                                                <button class="view-btn active" id="btn2D" onclick="setMode('2d')">2D Plano</button>
                                                <button class="view-btn" id="btn3D" onclick="setMode('3d')">3D Estructura</button>
                                            </div>
                                            <canvas id="canvasPlano"></canvas>
                                            <div class="canvas-controls">
                                                <button class="btn-control" onclick="ajustarZoom(1.1)" title="Acercar"><i class="bi bi-plus-lg"></i></button>
                                                <button class="btn-control" onclick="ajustarZoom(0.9)" title="Alejar"><i class="bi bi-dash-lg"></i></button>
                                                <button class="btn-control" onclick="resetView()" title="Centrar"><i class="bi bi-arrows-move"></i></button>
                                            </div>
                                            <div class="position-absolute bottom-0 start-0 m-3 badge bg-primary shadow-sm opacity-90">
                                                <i class="bi bi-arrows-fullscreen"></i> <span id="lblAreaTotal">0</span> m²
                                            </div>
                                        </div>
                                    </div>    
                              </div>
                           </div>
                        </div>
                    
                    <div class="col-lg-4">
                        <div class="modal-info-area d-flex flex-column h-100 p-4">
                            <h4 class="fw-bold mb-1" id="detalleTitulo" style="font-family: 'Playfair Display', serif;"></h4>
                            <h3 class="text-gold fw-bold mb-3" id="detallePrecio"></h3>
                            <div class="mb-4 flex-grow-1">
                                <h6 class="fw-bold small text-dark mb-1">Descripción:</h6>
                                <p class="text-muted small lh-sm" id="detalleDesc" style="max-height: 150px; overflow-y: auto;"></p>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({ once: true, disable: 'mobile' });
    
    let carrito = JSON.parse(localStorage.getItem('carrito_v2')) || [];
    let tempProducto = null; 
    let currentProductoId = null;
    let currentProductoNombre = "";
    let currentProductoPrecio = 0;
    
    let esCarpaModular = false;
    let anchoFijo = 0;
    
    let viewState = {
        mode: '2d', // '2d' o '3d'
        scale: 20, 
        offsetX: 0, offsetY: 0, 
        isDragging: false, lastX: 0, lastY: 0,
        lastPinchDist: 0 
    };

    const modalCantidadBootstrap = new bootstrap.Modal(document.getElementById('modalCantidad'));
    const modalDetallesBootstrap = new bootstrap.Modal(document.getElementById('modalDetalles'));
    const modalCarritoBootstrap = new bootstrap.Modal(document.getElementById('modalCarrito'));

    renderizar();

    const canvas = document.getElementById('canvasPlano');
    const container = document.getElementById('contenedorCanvas');

    // --- EVENTOS MOUSE ---
    canvas.addEventListener('mousedown', (e) => { 
        viewState.isDragging = true; 
        viewState.lastX = e.clientX; 
        viewState.lastY = e.clientY; 
    });
    window.addEventListener('mousemove', (e) => {
        if (!viewState.isDragging) return;
        viewState.offsetX += e.clientX - viewState.lastX;
        viewState.offsetY += e.clientY - viewState.lastY;
        viewState.lastX = e.clientX; 
        viewState.lastY = e.clientY;
        requestAnimationFrame(dibujarPlano);
    });
    window.addEventListener('mouseup', () => viewState.isDragging = false);
    
    canvas.addEventListener('wheel', (e) => { 
        e.preventDefault(); 
        viewState.scale *= (e.deltaY > 0 ? 0.9 : 1.1); 
        requestAnimationFrame(dibujarPlano); 
    });
    
    // --- EVENTOS TÁCTILES ---
    canvas.addEventListener('touchstart', (e) => {
        if (e.touches.length === 1) {
            viewState.isDragging = true;
            viewState.lastX = e.touches[0].clientX;
            viewState.lastY = e.touches[0].clientY;
        } else if (e.touches.length === 2) {
            viewState.isDragging = false; 
            const dx = e.touches[0].clientX - e.touches[1].clientX;
            const dy = e.touches[0].clientY - e.touches[1].clientY;
            viewState.lastPinchDist = Math.hypot(dx, dy);
        }
    });

    canvas.addEventListener('touchmove', (e) => {
        e.preventDefault(); 

        if (e.touches.length === 1 && viewState.isDragging) {
            viewState.offsetX += e.touches[0].clientX - viewState.lastX;
            viewState.offsetY += e.touches[0].clientY - viewState.lastY;
            viewState.lastX = e.touches[0].clientX;
            viewState.lastY = e.touches[0].clientY;
            requestAnimationFrame(dibujarPlano);

        } else if (e.touches.length === 2) {
            const dx = e.touches[0].clientX - e.touches[1].clientX;
            const dy = e.touches[0].clientY - e.touches[1].clientY;
            const currentDist = Math.hypot(dx, dy);

            if (viewState.lastPinchDist > 0) {
                const zoomFactor = currentDist / viewState.lastPinchDist;
                viewState.scale *= zoomFactor;
                if(viewState.scale < 5) viewState.scale = 5;
                if(viewState.scale > 100) viewState.scale = 100;
            }
            viewState.lastPinchDist = currentDist;
            requestAnimationFrame(dibujarPlano);
        }
    });

    canvas.addEventListener('touchend', () => {
        viewState.isDragging = false;
        viewState.lastPinchDist = 0;
    });

    // --- REDIMENSIONADO ---
    const resizeObserver = new ResizeObserver(entries => {
        for (let entry of entries) {
            const { width, height } = entry.contentRect;
            canvas.width = width;
            canvas.height = height;
            requestAnimationFrame(dibujarPlano);
        }
    });
    resizeObserver.observe(container);

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
            
            setMode('2d'); 

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
        cargarGaleria(ref, imgMain);
    }

    function init3DView() { setTimeout(() => { autoFit(); actualizarCalculosRender(); }, 100); }

    async function cargarGaleria(ref, imgMain) {
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
        } catch (e) { contenedor.innerHTML = ''; }
    }

    function setMode(mode) {
        viewState.mode = mode;
        document.getElementById('btn2D').classList.toggle('active', mode === '2d');
        document.getElementById('btn3D').classList.toggle('active', mode === '3d');
        
        // MOSTRAR/OCULTAR LEYENDAS
        document.getElementById('info2D').style.display = (mode === '2d') ? 'flex' : 'none';
        document.getElementById('info3D').style.display = (mode === '3d') ? 'flex' : 'none';
        
        autoFit(); 
    }

    function iniciarRender() { requestAnimationFrame(dibujarPlano); }
    function resetView() { autoFit(); }
    function ajustarZoom(factor) { viewState.scale *= factor; requestAnimationFrame(dibujarPlano); }

    function autoFit() {
        const largo = parseInt(document.getElementById('inputLargo').value) || 5;
        const ancho = anchoFijo;
        const factorZoom = Math.min(canvas.width / (ancho + largo), canvas.height / (ancho + largo)) * (viewState.mode === '3d' ? 18 : 35);
        viewState.scale = Math.min(factorZoom, 50);
        viewState.offsetX = 0;
        viewState.offsetY = 0;
        requestAnimationFrame(dibujarPlano);
    }

    function actualizarCalculosRender() {
        if(!esCarpaModular) return;
        const largo = parseInt(document.getElementById('inputLargo').value) || 0;
        const ancho = anchoFijo;
        const area = largo * ancho;
        const total = currentProductoPrecio * area;
        document.getElementById('lblPrecioTotal').innerText = `($${total.toLocaleString('es-MX')})`; 
        document.getElementById('lblCapacidad').innerText = Math.floor(area/1.5);
        document.getElementById('lblAreaTotal').innerText = area;
        dibujarPlano();
    }

    function dibujarPlano() { if (viewState.mode === '2d') { dibujar2D(); } else { dibujar3D(); } }

    function dibujar2D() {
        if (!canvas) return;
        const ctx = canvas.getContext('2d');
        const largo = parseInt(document.getElementById('inputLargo').value) || 5;
        const ancho = anchoFijo;
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        const cx = (canvas.width / 2) + viewState.offsetX;
        const cy = (canvas.height / 2) + viewState.offsetY;
        const scale = viewState.scale;
        const rectW = ancho * scale; const rectH = largo * scale;
        const startX = cx - (rectW / 2); const startY = cy - (rectH / 2);
        
        ctx.beginPath(); ctx.strokeStyle = "#e0e0e0"; ctx.lineWidth = 1;
        for (let i = 0; i <= ancho; i++) ctx.strokeRect(startX + (i * scale), startY, 0, rectH); 
        for (let i = 0; i <= largo; i++) ctx.strokeRect(startX, startY + (i * scale), rectW, 0);
        
        ctx.strokeStyle = "#0e4c81"; ctx.lineWidth = 2; ctx.fillStyle = "rgba(14, 76, 129, 0.1)";
        ctx.fillRect(startX, startY, rectW, rectH); ctx.strokeRect(startX, startY, rectW, rectH);
        
        ctx.fillStyle = "#000"; ctx.font = "bold 12px Arial"; ctx.textAlign = "center";
        ctx.fillText(`${ancho}m`, cx, startY - 10);
        ctx.save(); ctx.translate(startX - 15, cy); ctx.rotate(-Math.PI / 2);
        ctx.fillText(`${largo}m`, 0, 0); ctx.restore();
    }

    function dibujar3D() {
        if (!canvas) return;
        const ctx = canvas.getContext('2d');
        const largo = parseInt(document.getElementById('inputLargo').value) || 5;
        const ancho = anchoFijo;
        const alturaPoste = 3.5;
        const alturaCumbrera = 1.5;
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        const cx = (canvas.width / 2) + viewState.offsetX;
        const cy = (canvas.height * 0.6) + viewState.offsetY;
        const scale = viewState.scale;
        function toIso(x, y, z) { return { x: cx + (x - y) * scale, y: cy + (x + y) * scale * 0.5 - (z * scale) }; }
        
        let numSecciones = Math.max(1, Math.round(largo / 5)); if (largo <= 5) numSecciones = 1; let paso = largo / numSecciones;
        ctx.lineJoin = 'round'; ctx.lineCap = 'round';
        ctx.beginPath(); ctx.strokeStyle = '#e0e0e0'; ctx.lineWidth = 1;
        let p0 = toIso(0,0,0); let p1 = toIso(ancho,0,0); let p2 = toIso(ancho,largo,0); let p3 = toIso(0,largo,0);
        ctx.moveTo(p0.x, p0.y); ctx.lineTo(p1.x, p1.y); ctx.lineTo(p2.x, p2.y); ctx.lineTo(p3.x, p3.y); ctx.closePath(); ctx.stroke();

        for (let i = 0; i <= numSecciones; i++) {
            let yActual = i * paso;
            let baseIzq = toIso(0, yActual, 0); let topIzq = toIso(0, yActual, alturaPoste);
            let baseDer = toIso(ancho, yActual, 0); let topDer = toIso(ancho, yActual, alturaPoste);
            let cumbrera = toIso(ancho/2, yActual, alturaPoste + alturaCumbrera);
            ctx.strokeStyle = '#333'; ctx.lineWidth = 2; ctx.beginPath();
            ctx.moveTo(baseIzq.x, baseIzq.y); ctx.lineTo(topIzq.x, topIzq.y);
            ctx.moveTo(baseDer.x, baseDer.y); ctx.lineTo(topDer.x, topDer.y);
            ctx.moveTo(topIzq.x, topIzq.y); ctx.lineTo(cumbrera.x, cumbrera.y); ctx.lineTo(topDer.x, topDer.y);
            ctx.moveTo(topIzq.x, topIzq.y); ctx.lineTo(topDer.x, topDer.y); ctx.stroke();
            ctx.strokeStyle = '#999'; ctx.lineWidth = 1; ctx.beginPath();
            let centroViga = toIso(ancho/2, yActual, alturaPoste);
            ctx.moveTo(centroViga.x, centroViga.y); ctx.lineTo(cumbrera.x, cumbrera.y); ctx.stroke();
        }

        ctx.strokeStyle = '#555'; ctx.lineWidth = 1.5; ctx.beginPath();
        let cumbInicio = toIso(ancho/2, 0, alturaPoste + alturaCumbrera);
        let cumbFin = toIso(ancho/2, largo, alturaPoste + alturaCumbrera);
        ctx.moveTo(cumbInicio.x, cumbInicio.y); ctx.lineTo(cumbFin.x, cumbFin.y);
        let aleroIzqIni = toIso(0, 0, alturaPoste); let aleroIzqFin = toIso(0, largo, alturaPoste);
        ctx.moveTo(aleroIzqIni.x, aleroIzqIni.y); ctx.lineTo(aleroIzqFin.x, aleroIzqFin.y);
        let aleroDerIni = toIso(ancho, 0, alturaPoste); let aleroDerFin = toIso(ancho, largo, alturaPoste);
        ctx.moveTo(aleroDerIni.x, aleroDerIni.y); ctx.lineTo(aleroDerFin.x, aleroDerFin.y); ctx.stroke();

        ctx.fillStyle = "rgba(220, 230, 240, 0.4)"; ctx.beginPath();
        ctx.moveTo(aleroIzqIni.x, aleroIzqIni.y); ctx.lineTo(cumbInicio.x, cumbInicio.y); ctx.lineTo(cumbFin.x, cumbFin.y); ctx.lineTo(aleroIzqFin.x, aleroIzqFin.y); ctx.fill();
        ctx.beginPath();
        ctx.moveTo(aleroDerIni.x, aleroDerIni.y); ctx.lineTo(cumbInicio.x, cumbInicio.y); ctx.lineTo(cumbFin.x, cumbFin.y); ctx.lineTo(aleroDerFin.x, aleroDerFin.y); ctx.fill();

        ctx.strokeStyle = '#000'; ctx.fillStyle = '#000'; ctx.font = 'bold 12px Arial'; ctx.lineWidth = 1;
        let ac1 = toIso(ancho, -1, 0); let ac2 = toIso(0, -1, 0);
        ctx.beginPath(); ctx.moveTo(ac1.x, ac1.y); ctx.lineTo(ac2.x, ac2.y); ctx.stroke();
        ctx.fillText(`${ancho}m`, (ac1.x+ac2.x)/2 - 10, (ac1.y+ac2.y)/2); 
        let lc1 = toIso(-1, 0, 0); let lc2 = toIso(-1, largo, 0);
        ctx.beginPath(); ctx.moveTo(lc1.x, lc1.y); ctx.lineTo(lc2.x, lc2.y); ctx.stroke();
        ctx.fillText(`${largo}m`, (lc1.x+lc2.x)/2 - 10, (lc1.y+lc2.y)/2);
    }

    function cambiarImagen(src, elemento) {
        document.getElementById('imgPrincipal').src = src;
        document.querySelectorAll('.thumb-img').forEach(img => img.classList.remove('border-primary'));
        elemento.classList.add('border-primary');
    }

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
                nombre: `${currentProductoNombre} (${ancho}x${largo}m)`,
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
            alert("Completa: Nombre, Email y Fecha.");
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
                if(json.pdf_url) {
                    // Abrir en nueva pestaña
                    window.open(json.pdf_url, '_blank');
                } else {
                    alert(`¡Éxito! Tu referencia es: ${json.ref}.`);
                }
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