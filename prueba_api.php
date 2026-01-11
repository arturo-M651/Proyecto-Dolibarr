<?php
/**
 * PRUEBA_API.PHP - V4 (ESTÉTICA FINAL)
 */
require_once 'config.php'; 

$api_url = DOL_BASE_URL; 
$api_key = DOL_API_KEY;

function callAPI($url, $api_key) {
    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => array("DOLAPIKEY: " . $api_key, "Accept: application/json"),
    ));
    $response = curl_exec($curl);
    if(curl_errno($curl)) return []; 
    curl_close($curl);
    return json_decode($response, true);
}

$lista_categorias = callAPI($api_url . "/categories?type=product&sortfield=label&sortorder=ASC", $api_key);
$cat_id = isset($_GET['cat']) ? $_GET['cat'] : '';

$titulo_pagina = "Nuestra Colección";
if ($cat_id && is_array($lista_categorias)) {
    foreach($lista_categorias as $c) {
        if($c['id'] == $cat_id) $titulo_pagina = $c['label'];
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
        <a class="navbar-brand fw-bold fs-4" href="index.php">
            <i class="bi bi-balloon-heart-fill text-warning"></i> Carpas Montes
        </a>
        <div class="ms-auto d-flex align-items-center gap-3">
            <a href="index.php" class="text-decoration-none fw-bold text-dark small d-none d-md-block">
                <i class="bi bi-house-door"></i> INICIO
            </a>
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
                         onerror="this.src='https://images.unsplash.com/photo-1519167758481-83f550bb49b3?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'">
                    <div class="carousel-caption d-none d-md-block p-4 rounded-3" style="background: rgba(0,0,0,0.6); backdrop-filter: blur(2px);">
                        <h2 class="display-5 fw-bold text-warning">Eventos Inolvidables</h2>
                        <p class="fs-5 text-light">Todo lo necesario para tu celebración.</p>
                    </div>
                </div>
                <div class="carousel-item" style="height: 400px;">
                    <img src="carrusel/Carpa_Luces.jpeg" class="d-block w-100 h-100 object-fit-cover" alt="Banner 2"
                         onerror="this.src='https://images.unsplash.com/photo-1469334031218-e382a71b716b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'">
                    <div class="carousel-caption d-none d-md-block p-4 rounded-3" style="background: rgba(0,0,0,0.6); backdrop-filter: blur(2px);">
                        <h2 class="display-5 fw-bold text-warning">Mobiliario Premium</h2>
                        <p class="fs-5 text-light">Elegancia y confort para tus invitados.</p>
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
                        <div class="benefit-icon-wrapper">
                            <i class="bi bi-stopwatch"></i>
                        </div>
                        <h4 class="fw-bold mb-2">Puntualidad Garantizada</h4>
                        <p class="text-muted small">Sabemos que el tiempo es oro. Tu montaje estará listo exactamente cuando lo necesitas, sin estrés.</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="benefit-card">
                        <div class="benefit-icon-wrapper">
                            <i class="bi bi-stars"></i>
                        </div>
                        <h4 class="fw-bold mb-2">Impecable y Limpio</h4>
                        <p class="text-muted small">Nuestro mobiliario pasa por un estricto proceso de limpieza y mantenimiento antes de cada evento.</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="benefit-card">
                        <div class="benefit-icon-wrapper">
                            <i class="bi bi-shield-check"></i>
                        </div>
                        <h4 class="fw-bold mb-2">Seguridad y Confianza</h4>
                        <p class="text-muted small">Instalación profesional por expertos. Estructuras sólidas y seguras para tu tranquilidad.</p>
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
                    // Ruta de imagen local
                    $img_cat = "img_categorias/" . $cat['id'] . ".jpg";
            ?>
                <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-duration="800">
                    <a href="?cat=<?php echo $cat['id']; ?>" class="cat-card text-decoration-none">
                        
                        <img src="<?php echo $img_cat; ?>" 
                             alt="<?php echo $cat['label']; ?>" 
                             class="transition-hover"
                             onerror="this.onerror=null; this.src='https://source.unsplash.com/random/600x800/?event,party,<?php echo urlencode($cat['label']); ?>';">
                        
                        <div class="cat-overlay position-absolute bottom-0 start-0 w-100">
                            <h3 class="mb-1 text-white fw-bold display-6" style="font-size: 1.8rem; font-family: 'Playfair Display', serif;">
                                <?php echo $cat['label']; ?>
                            </h3>
                            <div class="d-flex align-items-center text-warning fw-bold text-uppercase small ls-1 mt-2">
                                <span>Explorar</span> 
                                <i class="bi bi-arrow-right ms-2 animate-arrow"></i>
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
                echo "<div class='col-12 text-center py-5'><i class='bi bi-box-seam display-1 text-muted'></i><p class='mt-3 lead'>No hay productos aquí.</p></div>";
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
                <div class="col-6 col-md-4 col-lg-3 item-producto" data-nombre="<?php echo strtolower($label); ?>" data-aos="zoom-in">
                    <div class="product-card shadow-sm bg-white rounded-4 border-0 h-100 d-flex flex-column">
                        
                        <div class="product-img-wrapper position-relative cursor-pointer" style="height: 220px; overflow: hidden;"
                             onclick="verDetalles('<?php echo $ref; ?>', '<?php echo $label; ?>', '<?php echo $desc; ?>', <?php echo $price; ?>)">
                            <img src="<?php echo $img_src; ?>" class="w-100 h-100 object-fit-cover" 
                                 onerror="this.src='https://via.placeholder.com/300x300?text=Sin+Foto'">
                            <span class="position-absolute bottom-0 end-0 m-2 badge bg-white text-dark shadow fw-bold border border-warning price-badge">
                                $<?php echo number_format($price, 2); ?>
                            </span>
                        </div>

                        <div class="p-3 d-flex flex-column flex-grow-1">
                            <h6 class="fw-bold text-dark mb-1 text-truncate" style="font-family: 'Lato', sans-serif;"><?php echo $label; ?></h6>
                            <small class="text-muted mb-3 small product-desc-clamp"><?php echo strip_tags($desc); ?></small>
                            
                            <div class="mt-auto d-flex justify-content-between align-items-center gap-2">
                                <button class="btn btn-light text-primary fw-bold btn-sm flex-grow-1" 
                                        onclick="verDetalles('<?php echo $ref; ?>', '<?php echo $label; ?>', '<?php echo $desc; ?>', <?php echo $price; ?>)">
                                    Ver
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

<div class="modal fade" id="modalDetalles" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 rounded-4">
            <div class="modal-header border-0">
                <h5 class="modal-title fw-bold" id="detalleTitulo"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <h2 class="text-gold fw-bold mb-3" id="detallePrecio"></h2>
                <div class="bg-light p-3 rounded text-secondary mb-3 small" id="detalleDesc"></div>
                <div id="galeriaContenedor" class="row g-2"></div>
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
    AOS.init();
    let carrito = JSON.parse(localStorage.getItem('carrito_v2')) || [];
    let tempProducto = null; 
    const modalCantidadBootstrap = new bootstrap.Modal(document.getElementById('modalCantidad'));
    const modalDetallesBootstrap = new bootstrap.Modal(document.getElementById('modalDetalles'));

    renderizar();

    // BUSCADOR JS
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

    // DETALLES
    async function verDetalles(ref, nombre, desc, precio) {
        document.getElementById('detalleTitulo').innerText = nombre;
        document.getElementById('detallePrecio').innerText = "$" + precio.toFixed(2);
        document.getElementById('detalleDesc').innerHTML = desc || 'Sin descripción.';
        const contenedor = document.getElementById('galeriaContenedor');
        contenedor.innerHTML = '<div class="spinner-border text-warning"></div>';
        modalDetallesBootstrap.show();

        try {
            const res = await fetch(`obtener_fotos.php?ref=${ref}&t=${Date.now()}`);
            const fotos = await res.json();
            contenedor.innerHTML = ''; 
            if (fotos.length) {
                fotos.forEach(url => {
                    contenedor.innerHTML += `<div class="col-4"><img src="${encodeURI(url)}" class="img-fluid rounded shadow-sm" onclick="window.open('${encodeURI(url)}')"></div>`;
                });
            } else { contenedor.innerHTML = '<small class="text-muted col-12">No hay imágenes adicionales.</small>'; }
        } catch (e) { contenedor.innerHTML = 'Error.'; }
    }

    // CARRITO
    function prepararAgregar(id, nombre, precio) {
        tempProducto = { id, nombre, precio };
        document.getElementById('lblProductoSeleccionado').innerText = nombre;
        document.getElementById('inputCantidadModal').value = 1;
        modalCantidadBootstrap.show();
    }

    function confirmarAgregar() {
        let cant = parseInt(document.getElementById('inputCantidadModal').value);
        if (cant < 1) return;
        let exist = carrito.find(i => i.id == tempProducto.id);
        if (exist) exist.cant += cant; else carrito.push({ ...tempProducto, cant });
        guardar();
        modalCantidadBootstrap.hide();
    }

    function guardar() { localStorage.setItem('carrito_v2', JSON.stringify(carrito)); renderizar(); }

    function renderizar() {
        const lista = document.getElementById('lista-carrito');
        lista.innerHTML = '';
        let total = 0;
        if(carrito.length === 0) lista.innerHTML = '<div class="text-center text-muted small py-2">Vacío</div>';
        
        carrito.forEach((item, index) => {
            total += item.precio * item.cant;
            lista.innerHTML += `
                <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                    <div class="small lh-1">
                        <span class="fw-bold">${item.nombre}</span><br>
                        <span class="text-muted">$${item.precio} x ${item.cant}</span>
                    </div>
                    <i class="bi bi-x-circle text-danger cursor-pointer" onclick="eliminar(${index})"></i>
                </li>`;
        });
        document.getElementById('contador').innerText = carrito.length;
        document.getElementById('total-precio').innerText = '$' + total.toFixed(2);
    }

    function eliminar(i) { carrito.splice(i, 1); guardar(); }
    function borrarTodo() { carrito = []; guardar(); }

    async function enviarPedido(tipo) {
        const c = document.getElementById('cliente').value;
        const e = document.getElementById('email').value;
        const f = document.getElementById('fecha').value;
        
        if (!c || !e || !f || carrito.length === 0) {
            alert("Completa Nombre, Email y Fecha.");
            return;
        }

        if(!confirm(`¿Generar ${tipo}?`)) return;

        const btn = event.target;
        const txt = btn.innerHTML;
        btn.innerHTML = '...';
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
                bootstrap.Modal.getInstance(document.getElementById('modalCarrito')).hide();
                alert(`¡Listo! Referencia: ${json.ref}. Revisa tu correo.`);
            } else { alert("Error: " + json.message); }
        } catch (err) { alert("Error de conexión"); }
        finally { btn.innerHTML = txt; btn.disabled = false; }
    }
</script>
</body>
</html>