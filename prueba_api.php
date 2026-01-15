<?php
/**
 * PRUEBA_API.PHP - V45 (HTML ESTRUCTURAL LIMPIO)
 */
require_once 'config.php'; 
$api_url = DOL_BASE_URL; $api_key = DOL_API_KEY;

function callAPI($url, $api_key) {
    $curl = curl_init();
    curl_setopt_array($curl, array(CURLOPT_URL => $url, CURLOPT_RETURNTRANSFER => true, CURLOPT_HTTPHEADER => array("DOLAPIKEY: " . $api_key, "Accept: application/json"), CURLOPT_TIMEOUT => 10));
    $response = curl_exec($curl);
    if(curl_errno($curl)) { curl_close($curl); return []; }
    curl_close($curl);
    return json_decode($response, true);
}

$lista_categorias = callAPI($api_url . "/categories?type=product&sortfield=label&sortorder=ASC", $api_key);
$cat_id = isset($_GET['cat']) ? $_GET['cat'] : '';
$titulo_pagina = "Nuestra Colección";
if ($cat_id && is_array($lista_categorias)) { foreach($lista_categorias as $c) { if($c['id'] == $cat_id) { $titulo_pagina = $c['label']; break; } } }
$es_mobiliario = (stripos($titulo_pagina, 'Mobiliario') !== false);
$productos = [];
if ($cat_id) { $endpoint = "/products?sortfield=t.ref&sortorder=ASC&category=" . $cat_id; $productos = callAPI($api_url . $endpoint, $api_key); }
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Cotizador | Carpas Montes</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Lato:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos.css">
    <style>
        .carousel-item-responsive { height: 450px; transition: height 0.3s ease; }
        @media (max-width: 768px) { .carousel-item-responsive { height: 280px !important; } .display-5 { font-size: 1.8rem; } .navbar-brand img { width: 40px; height: 40px; } .navbar-brand span { font-size: 1.2rem !important; } }
        .filters-scroll-mobile { display: flex; overflow-x: auto; white-space: nowrap; -webkit-overflow-scrolling: touch; padding-bottom: 5px; gap: 0.5rem; }
        .filters-scroll-mobile::-webkit-scrollbar { display: none; } 
        .mode-switch-container { display: flex; justify-content: center; margin-bottom: 20px; }
        .mode-switch { background: #e0e0e0; border-radius: 25px; padding: 4px; display: flex; position: relative; box-shadow: inset 0 2px 4px rgba(0,0,0,0.1); }
        .mode-btn { border: none; background: transparent; padding: 8px 20px; border-radius: 20px; font-size: 0.9rem; font-weight: bold; color: #666; cursor: pointer; transition: color 0.3s; z-index: 2; min-width: 110px; }
        .mode-btn.active { color: #fff; }
        .mode-slider { position: absolute; top: 4px; left: 4px; bottom: 4px; width: calc(50% - 4px); background: #0e4c81; border-radius: 20px; transition: transform 0.3s cubic-bezier(0.4, 0.0, 0.2, 1); z-index: 1; box-shadow: 0 2px 5px rgba(14, 76, 129, 0.3); }
        .color-swatch { width: 30px; height: 30px; border-radius: 50%; cursor: pointer; border: 2px solid #fff; box-shadow: 0 2px 4px rgba(0,0,0,0.2); transition: all 0.2s; position: relative; }
        .color-swatch:hover { transform: scale(1.1); }
        .color-swatch.active { border: 2px solid #0e4c81; transform: scale(1.2); box-shadow: 0 0 0 2px #fff, 0 4px 8px rgba(0,0,0,0.3); }
        .color-swatch.white-color { border: 1px solid #ddd; } 
        #contenedorCanvas { position: relative; width: 100%; height: 60vh; min-height: 400px; background-color: #ffffff; background-image: linear-gradient(#f5f5f5 1px, transparent 1px), linear-gradient(90deg, #f5f5f5 1px, transparent 1px); background-size: 20px 20px; overflow: hidden; touch-action: none; }
        canvas#canvasPlano { position: absolute; top: 0; left: 0; width: 100%; height: 100%; cursor: grab; touch-action: none; }
        canvas#canvasPlano:active { cursor: grabbing; }
        .canvas-controls { position: absolute; bottom: 20px; right: 20px; display: flex; flex-direction: column; gap: 8px; z-index: 10; }
        .btn-control { width: 40px; height: 40px; border-radius: 50%; background: white; border: 1px solid #dee2e6; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1); color: #333; transition: all 0.2s; font-size: 1.2rem; }
        .view-switch { position: absolute; top: 20px; left: 50%; transform: translateX(-50%); background: white; padding: 4px; border-radius: 30px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); display: flex; gap: 5px; z-index: 10; }
        .view-btn { border: none; background: transparent; padding: 6px 15px; border-radius: 20px; font-size: 0.85rem; font-weight: bold; color: #666; transition: all 0.2s; }
        .view-btn.active { background: #0e4c81; color: white; box-shadow: 0 2px 5px rgba(14, 76, 129, 0.3); }
        .info-legend { position: absolute; bottom: 20px; left: 50%; transform: translateX(-50%); max-width: 250px; width: max-content; background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(2px); padding: 8px 9px; border-radius: 12px; border: 1px solid #e0e0e0; box-shadow: 0 4px 10px rgba(0,0,0,0.05); font-size: 0.55rem; color: #555; z-index: 10; pointer-events: none; display: flex; align-items: center; gap: 8px; line-height: 1.2; text-align: center; }
        .info-legend i { font-size: 1.1rem; color: #0e4c81; }
        .thumb-img { width:60px; height:60px; object-fit:cover; border-radius:8px; cursor:pointer; }
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
            <a href="index.php" class="text-decoration-none fw-bold text-dark small d-none d-lg-block"><i class="bi bi-house-door"></i> INICIO</a>
            <button class="btn btn-gold rounded-circle d-flex align-items-center justify-content-center shadow-sm position-relative" style="width:45px; height:45px;" data-bs-toggle="modal" data-bs-target="#modalCarrito">
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
                    <a href="prueba_api.php" class="cat-pill <?php echo ($cat_id == '') ? 'active' : ''; ?>"><i class="bi bi-grid-fill me-1"></i> Todo</a>
                    <?php if (!isset($lista_categorias['error']) && is_array($lista_categorias)) { foreach ($lista_categorias as $cat) { $active = ($cat_id == $cat['id']) ? 'active' : ''; echo '<a href="?cat=' . $cat['id'] . '" class="cat-pill ' . $active . '">' . $cat['label'] . '</a>'; } } ?>
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
                <div class="col-12 col-md-4"><div class="benefit-card d-flex align-items-center p-3 h-100"><div class="benefit-icon-wrapper me-3"><i class="bi bi-stopwatch fs-4"></i></div><div><h5 class="fw-bold mb-1">Cotización Rápida</h5><p class="text-muted small mb-0">Recibe tu PDF al instante.</p></div></div></div>
                <div class="col-12 col-md-4"><div class="benefit-card d-flex align-items-center p-3 h-100"><div class="benefit-icon-wrapper me-3"><i class="bi bi-stars fs-4"></i></div><div><h5 class="fw-bold mb-1">Mobiliario Impecable</h5><p class="text-muted small mb-0">Calidad garantizada.</p></div></div></div>
                <div class="col-12 col-md-4"><div class="benefit-card d-flex align-items-center p-3 h-100"><div class="benefit-icon-wrapper me-3"><i class="bi bi-shield-check fs-4"></i></div><div><h5 class="fw-bold mb-1">Confirmación Personal</h5><p class="text-muted small mb-0">Agendamos tu evento.</p></div></div></div>
            </div>
        </div>

        <div class="text-center mb-4" data-aos="fade-up"><h2 class="fw-bold text-dark">Explora por Categorías</h2><div style="width: 60px; height: 3px; background: var(--gold); margin: 10px auto;"></div></div>

        <div class="row g-4">
            <?php if (is_array($lista_categorias) && !isset($lista_categorias['error'])) { foreach ($lista_categorias as $cat) { $img_cat = "img_categorias/" . $cat['id'] . ".jpg"; ?>
                <div class="col-6 col-md-4" data-aos="fade-up">
                    <a href="?cat=<?php echo $cat['id']; ?>" class="cat-card text-decoration-none">
                        <img src="<?php echo $img_cat; ?>" alt="<?php echo $cat['label']; ?>" class="transition-hover" onerror="this.onerror=null; this.src='https://placehold.co/600x400/0e4c81/ffffff?text=<?php echo urlencode($cat['label']); ?>';">
                        <div class="cat-overlay position-absolute bottom-0 start-0 w-100"><h3 class="mb-1 text-white fw-bold display-6"><?php echo $cat['label']; ?></h3><div class="d-flex align-items-center text-warning fw-bold small mt-2"><span>Explorar</span> <i class="bi bi-arrow-right ms-2 animate-arrow"></i></div></div>
                    </a>
                </div>
            <?php } } ?>
        </div>
    
    <?php else: ?>
        <div class="d-flex align-items-center justify-content-between mb-4">
            <h2 class="fw-bold text-dark mb-0"><?php echo $titulo_pagina; ?></h2>
            <a href="prueba_api.php" class="btn btn-outline-secondary btn-sm rounded-pill"><i class="bi bi-arrow-left"></i> Volver</a>
        </div>
        
        <?php if ($es_mobiliario): ?>
        <div class="mode-switch-container" data-aos="fade-down"><div class="mode-switch"><div class="mode-slider" id="modeSlider"></div><button class="mode-btn active" onclick="filtrarMobiliario('unidad')">Por Unidad</button><button class="mode-btn" onclick="filtrarMobiliario('paquete')">Por Paquete</button></div></div>
        <?php endif; ?>

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

                    $es_modular = false;
                    $keywords_modular = ['carpa', 'toldo', 'ancho', 'estructura'];
                    foreach ($keywords_modular as $kw) { if (stripos($label, $kw) !== false) { $es_modular = true; break; } }

                    $es_paquete = false;
                    $keywords_paquete = ['sencilla', 'vestida', 'paquete', 'juego', 'tablon con', 'mesa con'];
                    foreach ($keywords_paquete as $kw) { if (stripos($label, $kw) !== false) { $es_paquete = true; break; } }
            ?>
                <div class="col-6 col-md-4 col-lg-3 item-producto" data-nombre="<?php echo strtolower($label); ?>" data-tipo="<?php echo $es_paquete ? 'paquete' : 'unidad'; ?>" data-aos="zoom-in">
                    <div class="product-card shadow-sm bg-white rounded-4 border-0 h-100 d-flex flex-column">
                        <div class="product-img-wrapper position-relative cursor-pointer" style="height: 220px; overflow: hidden;"
                             onclick="verDetalles('<?php echo $ref; ?>', '<?php echo $label; ?>', '<?php echo $desc; ?>', <?php echo $price; ?>, '<?php echo $img_src; ?>', <?php echo $id; ?>)">
                            <img src="<?php echo $img_src; ?>" class="w-100 h-100 object-fit-cover" onerror="this.src='https://placehold.co/300x300/f8fafc/0e4c81?text=Sin+Foto'">
                            <span class="position-absolute bottom-0 end-0 m-2 badge bg-white text-dark shadow fw-bold border border-warning price-badge" style="font-size: 0.8rem;">
                                $<?php echo number_format($price, 2); ?>
                                <?php if ($es_modular): ?> <span class="text-muted ms-1" style="font-size: 0.75em; font-weight: normal;">/ m²</span> <?php endif; ?>
                            </span>
                        </div>
                        <div class="p-3 d-flex flex-column flex-grow-1">
                            <h6 class="fw-bold text-dark mb-1 text-truncate"><?php echo $label; ?></h6>
                            <small class="text-muted mb-3 small product-desc-clamp"><?php echo strip_tags($desc); ?></small>
                            <div class="mt-auto d-flex justify-content-between align-items-center gap-2">
                                <button class="btn btn-light text-primary fw-bold btn-sm flex-grow-1" 
                                    onclick="verDetalles('<?php echo $ref; ?>', '<?php echo $label; ?>', '<?php echo $desc; ?>', <?php echo $price; ?>, '<?php echo $img_src; ?>', <?php echo $id; ?>)">
                                    <i class="bi bi-eye"></i> <?php echo $es_modular ? 'Configurar' : 'Ver'; ?>
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

<div class="modal fade" id="modalCantidad" tabindex="-1">
    <div class="modal-dialog modal-sm modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4">
            <div class="modal-header bg-primary text-white border-0 py-2"><h6 class="modal-title small">Cantidad</h6><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
            <div class="modal-body text-center p-3"><h6 class="fw-bold mb-3 small" id="lblProductoSeleccionado"></h6><input type="number" id="inputCantidadModal" class="form-control text-center mb-3" value="1" min="1"><button class="btn btn-gold w-100 btn-sm rounded-pill" onclick="confirmarAgregar()">Agregar</button></div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalCarrito" tabindex="-1">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header bg-primary text-white"><h5 class="modal-title"><i class="bi bi-cart3"></i> Tu Cotización</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
            <div class="modal-body">
                <div class="bg-light p-3 rounded mb-3 border">
                    <input type="text" id="cliente" class="form-control form-control-sm mb-2" placeholder="Nombre Completo *">
                    <input type="email" id="email" class="form-control form-control-sm mb-2" placeholder="Email *">
                    <input type="date" id="fecha" class="form-control form-control-sm mb-2">
                    <a class="text-decoration-none small fw-bold" data-bs-toggle="collapse" href="#extraFields">+ Dirección / RFC</a>
                    <div class="collapse mt-2" id="extraFields">
                        <input type="tel" id="telefono" class="form-control form-control-sm mb-2" placeholder="Teléfono">
                        <input type="text" id="direccion" class="form-control form-control-sm mb-2" placeholder="Dirección">
                        <div class="row g-2 mb-2"><div class="col-4"><input type="text" id="cp" class="form-control form-control-sm" placeholder="CP"></div><div class="col-8"><input type="text" id="ciudad" class="form-control form-control-sm" placeholder="Ciudad"></div></div>
                        <input type="text" id="rfc" class="form-control form-control-sm" placeholder="RFC">
                    </div>
                </div>
                <ul id="lista-carrito" class="list-group list-group-flush mb-3"></ul>
                <div class="d-flex justify-content-between h5 fw-bold"><span>Estimado:</span><span class="text-primary" id="total-precio">$0.00</span></div>
            </div>
            <div class="modal-footer flex-column border-0 pt-0">
                <div class="row w-100 g-2">
                    <div class="col-12"><button class="btn btn-gold w-100 rounded-pill fw-bold shadow-sm" onclick="enviarPedido('cotizacion')"><i class="bi bi-file-earmark-text me-2"></i> Solicitar Cotización</button></div>
                    <div class="col-12 text-center mt-2"><button class="btn btn-link text-muted btn-sm text-decoration-none" onclick="borrarTodo()">Vaciar Carrito</button></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalDetalles" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 rounded-4 shadow-lg overflow-hidden">
            <div class="modal-header border-0 p-2 position-absolute end-0 top-0 z-3"><button type="button" class="btn-close bg-white rounded-circle p-2 shadow-sm opacity-100" data-bs-dismiss="modal"></button></div>
            <div class="modal-body p-0">
                <div class="row g-0">
                    <div class="col-lg-8 bg-light position-relative">
                          <div class="modal-gallery-area p-3 h-100 d-flex flex-column"> 
                                <ul class="nav nav-pills mb-2 justify-content-center gap-2" id="pills-tab" role="tablist">
                                    <li class="nav-item"><button class="nav-link active rounded-pill py-1 px-3 small fw-bold" id="pills-foto-tab" data-bs-toggle="pill" data-bs-target="#pills-foto" type="button"><i class="bi bi-images me-1"></i> Fotos</button></li>
                                    <li class="nav-item"><button class="nav-link rounded-pill py-1 px-3 small fw-bold" id="pills-plano-tab" data-bs-toggle="pill" data-bs-target="#pills-plano" type="button"><i class="bi bi-box-seam me-1"></i> Simulador</button></li>
                                </ul>
                                <div class="tab-content flex-grow-1 position-relative">
                                    <div class="tab-pane fade show active" id="pills-foto">
                                        <div class="main-image-container mb-2 d-flex align-items-center justify-content-center bg-white rounded-3 h-100"><img id="imgPrincipal" src="" class="mw-100 mh-100 object-fit-contain"></div>
                                        <div class="thumbnails-row d-flex gap-2 overflow-auto" id="galeriaContenedor"></div>
                                    </div>
                                    <div class="tab-pane fade h-100" id="pills-plano">
                                        <div class="card border-0 shadow-sm h-100" id="contenedorCanvas">
                                            <div id="info2D" class="info-legend"><i class="bi bi-grid-3x3"></i><span>Cuadrícula:<br>1 cuadro = 1 metro</span></div>
                                            <div id="info3D" class="info-legend" style="display:none;"><i class="bi bi-info-circle"></i><span>Render referencial.<br>La estructura varía.</span></div>
                                            <div class="view-switch"><button class="view-btn active" id="btn2D" onclick="setMode('2d')">2D Plano</button><button class="view-btn" id="btn3D" onclick="setMode('3d')">3D Estructura</button></div>
                                            <canvas id="canvasPlano"></canvas>
                                            <div class="canvas-controls">
                                                <button class="btn-control" onclick="ajustarZoom(1.1)" title="Acercar"><i class="bi bi-plus-lg"></i></button>
                                                <button class="btn-control" onclick="ajustarZoom(0.9)" title="Alejar"><i class="bi bi-dash-lg"></i></button>
                                                <button class="btn-control" onclick="resetView()" title="Centrar"><i class="bi bi-arrows-move"></i></button>
                                            </div>
                                            <div class="position-absolute bottom-0 start-0 m-3 badge bg-primary shadow-sm opacity-90"><i class="bi bi-arrows-fullscreen"></i> <span id="lblAreaTotal">0</span> m²</div>
                                        </div>
                                    </div>    
                              </div>
                           </div>
                        </div>
                    <div class="col-lg-4">
                        <div class="modal-info-area d-flex flex-column h-100 p-4">
                            <h4 class="fw-bold mb-1" id="detalleTitulo" style="font-family: 'Playfair Display', serif;"></h4>
                            <h3 class="text-gold fw-bold mb-3" id="detallePrecio"></h3>
                            <div class="mb-4 flex-grow-1"><h6 class="fw-bold small text-dark mb-1">Descripción:</h6><p class="text-muted small lh-sm" id="detalleDesc" style="max-height: 200px; overflow-y: auto;"></p></div>
                            <div class="mt-auto pt-3 border-top">
                                <div id="panelMedidas" class="mb-3 p-3 bg-light rounded-3 border" style="display:none;">
                                    <div class="row g-2 align-items-center">
                                        <div class="col-5"><label class="small text-muted d-block">Ancho (m)</label><input type="number" class="form-control form-control-sm fw-bold bg-white" id="inputAncho" readonly></div>
                                        <div class="col-2 text-center pt-3 text-muted">x</div>
                                        <div class="col-5"><label class="small text-muted d-block">Largo (m)</label><input type="number" class="form-control form-control-sm fw-bold border-warning" id="inputLargo" value="5" min="3" oninput="actualizarCalculosRender()"></div>
                                    </div>
                                    <div class="mt-2 text-center"><span class="badge bg-warning text-dark"><i class="bi bi-people"></i> ~<span id="lblCapacidad">0</span> personas</span></div>
                                </div>
                                <div class="d-flex gap-2 align-items-end">
                                    <div id="divCantidadNormal" class="w-25"><label class="small fw-bold mb-1">Cant:</label><input type="number" id="inputCantidadDetalle" class="form-control text-center fw-bold" value="1" min="1"></div>
                                    <button class="btn btn-gold flex-grow-1 rounded-pill shadow-sm" onclick="agregarDesdeDetalle()"><i class="bi bi-cart-plus me-1"></i> Agregar <span id="lblPrecioTotal" class="small d-block d-md-inline ms-md-1 opacity-75"></span></button>
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
<script src="app.js"></script>
</body>
</html>