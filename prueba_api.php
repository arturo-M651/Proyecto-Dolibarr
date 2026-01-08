<?php
/**
 * PRUEBA_API.PHP - VERSIÓN CON CARRUSEL DE CABECERA
 */

$api_key = "55W05PsnTJuJRFg8lckZZ7hx10lM0Rz9"; 
$url_base = "http://localhost/dolibarr/htdocs/api/index.php"; 

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

// 1. OBTENER CATEGORÍAS
$lista_categorias = callAPI($url_base . "/categories?type=product&sortfield=label&sortorder=ASC", $api_key);

// 2. LÓGICA DE VISTA
$cat_id = isset($_GET['cat']) ? $_GET['cat'] : '';
$titulo_pagina = "Categorías Principales";
$productos = [];

if ($cat_id) {
    foreach($lista_categorias as $c) {
        if($c['id'] == $cat_id) $titulo_pagina = $c['label'];
    }
    $endpoint = "/products?sortfield=t.ref&sortorder=ASC&category=" . $cat_id;
    $productos = callAPI($url_base . $endpoint, $api_key);
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo | <?php echo $titulo_pagina; ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        .btn-flotante { position: fixed; bottom: 20px; right: 20px; z-index: 1000; padding: 15px 25px; border-radius: 50px; box-shadow: 0 4px 15px rgba(0,0,0,0.3); font-weight: bold; }
        .card-img-top { height: 200px; object-fit: cover; }
        .card { transition: transform 0.2s; border: none; }
        .card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        
        /* Estilos Categorías */
        .cat-card { height: 250px; position: relative; overflow: hidden; border-radius: 15px; cursor: pointer; text-decoration: none; color: white; }
        .cat-card img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
        .cat-card:hover img { transform: scale(1.1); }
        .cat-overlay { position: absolute; bottom: 0; left: 0; right: 0; background: linear-gradient(to top, rgba(0,0,0,0.8), transparent); padding: 20px; }
        
        /* Estilos Carrusel */
        .carousel-item { height: 400px; } /* Altura del banner */
        .carousel-item img { height: 100%; object-fit: cover; filter: brightness(0.7); }
        .carousel-caption { bottom: 20%; text-shadow: 2px 2px 4px rgba(0,0,0,0.7); }
        
        .galeria-img { width: 100%; height: 150px; object-fit: cover; border-radius: 8px; cursor: pointer; transition: opacity 0.3s; }
        .galeria-img:hover { opacity: 0.8; }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.php">🎪 Carpas Montes</a>
        <div class="ms-auto">
            <a href="index.php" class="btn btn-sm btn-outline-secondary me-2"><i class="bi bi-house"></i> Inicio</a>
            <?php if($cat_id): ?>
                <a href="prueba_api.php" class="btn btn-sm btn-outline-primary"><i class="bi bi-grid-fill"></i> Ver Categorías</a>
            <?php endif; ?>
        </div>
    </div>
</nav>

<?php if (!$cat_id): ?>

    <div id="carruselPrincipal" class="carousel slide mb-5" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#carruselPrincipal" data-bs-slide-to="0" class="active"></button>
            <button type="button" data-bs-target="#carruselPrincipal" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#carruselPrincipal" data-bs-slide-to="2"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://images.unsplash.com/photo-1511578314322-379afb476865?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80" class="d-block w-100" alt="Eventos">
                <div class="carousel-caption d-none d-md-block">
                    <h1 class="display-4 fw-bold">Grandes Eventos</h1>
                    <p class="fs-4">Todo lo necesario para tu boda o celebración.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="carrusel/15x30.jpeg" class="d-block w-100" alt="Carpas">
                <div class="carousel-caption d-none d-md-block">
                    <h1 class="display-4 fw-bold">Carpas Elegantes</h1>
                    <p class="fs-4">Protege a tus invitados con estilo y confort.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="carrusel/Carpa_luces.jpeg" class="d-block w-100" alt="Mobiliario">
                <div class="carousel-caption d-none d-md-block">
                    <h1 class="display-4 fw-bold">Mobiliario Premium</h1>
                    <p class="fs-4">Sillas y mesas para cualquier tipo de ocasión.</p>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carruselPrincipal" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carruselPrincipal" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>

    <div class="container pb-5">
        <h2 class="text-center mb-4 fw-bold text-secondary">Nuestras Categorías</h2>
        <div class="row g-4">
            <?php
            if (is_array($lista_categorias) && !isset($lista_categorias['error'])) {
                foreach ($lista_categorias as $cat) {
                    $img_cat = "img_categorias/" . $cat['id'] . ".jpg";
                    if (!file_exists($img_cat)) {
                        $img_cat = "https://source.unsplash.com/random/400x300/?party," . urlencode($cat['label']);
                    }
            ?>
                <div class="col-md-6 col-lg-4">
                    <a href="?cat=<?php echo $cat['id']; ?>" class="cat-card d-block shadow animate__animated animate__fadeInUp">
                        <img src="<?php echo $img_cat; ?>" alt="<?php echo $cat['label']; ?>">
                        <div class="cat-overlay">
                            <h3 class="mb-0"><?php echo $cat['label']; ?></h3>
                            <small class="text-white-50">Explorar <i class="bi bi-arrow-right"></i></small>
                        </div>
                    </a>
                </div>
            <?php
                }
            } else {
                echo "<p class='text-center'>Cargando categorías...</p>";
            }
            ?>
        </div>
    </div>

<?php else: ?>

    <div class="container py-5">
        <h2 class="text-center mb-5 fw-bold text-uppercase"><?php echo $titulo_pagina; ?></h2>
        <div class="row">
            <?php
            if (isset($productos['error']) || empty($productos)) {
                echo "<div class='alert alert-warning col-12 text-center'>No hay productos aquí.</div>";
                echo "<div class='text-center'><a href='prueba_api.php' class='btn btn-primary'>Volver</a></div>";
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
                <div class="col-md-4 mb-4">
                    <div class="card h-100 shadow-sm">
                        <img src="<?php echo $img_src; ?>" class="card-img-top">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title"><?php echo $label; ?></h5>
                            <h3 class="text-primary mb-3">$<?php echo number_format($price, 2); ?></h3>
                            
                            <div class="mt-auto d-flex gap-2">
                                <button class="btn btn-outline-info w-50" 
                                        onclick="verDetalles('<?php echo $ref; ?>', '<?php echo $label; ?>', '<?php echo $desc; ?>', <?php echo $price; ?>)">
                                    <i class="bi bi-eye"></i> Detalles
                                </button>
                                <button class="btn btn-outline-primary w-50" 
                                        onclick="prepararAgregar(<?php echo $id; ?>, '<?php echo $label; ?>', <?php echo $price; ?>)">
                                    <i class="bi bi-cart-plus"></i>
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
    </div>

<?php endif; ?>

<button class="btn btn-primary btn-flotante" data-bs-toggle="modal" data-bs-target="#modalCarrito">
    <i class="bi bi-cart-fill"></i> Mi Lista (<span id="contador">0</span>)
</button>

<div class="modal fade" id="modalCantidad" tabindex="-1">
    <div class="modal-dialog modal-sm modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h6 class="modal-title" id="lblProductoSeleccionado">Producto</h6>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center">
                <p class="mb-2">Ingrese la cantidad:</p>
                <input type="number" id="inputCantidadModal" class="form-control form-control-lg text-center mb-3" value="1" min="1">
                <button class="btn btn-success w-100" onclick="confirmarAgregar()">Confirmar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalDetalles" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold" id="detalleTitulo"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12 mb-4">
                        <h3 class="text-primary" id="detallePrecio"></h3>
                        <p class="text-muted" id="detalleDesc"></p>
                    </div>
                    <div class="col-md-12">
                        <h6 class="border-bottom pb-2">📸 Galería</h6>
                        <div id="galeriaContenedor" class="row g-2 mt-2"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalCarrito" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Cotización</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3 bg-light p-3 rounded">
                    <input type="text" id="cliente" class="form-control mb-2" placeholder="Nombre Cliente">
                    <input type="text" id="telefono" class="form-control mb-2" placeholder="Teléfono">
                    <input type="date" id="fecha" class="form-control">
                </div>
                <ul id="lista-carrito" class="list-group mb-3"></ul>
                <h4 class="text-end">Total: <span id="total-precio">$0.00</span></h4>
            </div>
           <div class="modal-footer">
                <button class="btn btn-secondary" onclick="borrarTodo()">Limpiar</button>
                <button class="btn btn-warning" onclick="enviarPedido('cotizacion')">Solo Cotizar</button>
                <button class="btn btn-success" onclick="enviarPedido('pedido')">Confirmar Pedido</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let carrito = JSON.parse(localStorage.getItem('carrito_v2')) || [];
    let tempProducto = null; 
    const modalCantidadBootstrap = new bootstrap.Modal(document.getElementById('modalCantidad'));
    const modalDetallesBootstrap = new bootstrap.Modal(document.getElementById('modalDetalles'));

    renderizar();

    async function verDetalles(ref, nombre, desc, precio) {
        document.getElementById('detalleTitulo').innerText = nombre;
        document.getElementById('detallePrecio').innerText = "$" + precio.toFixed(2);
        document.getElementById('detalleDesc').innerHTML = desc; 
        
        const contenedor = document.getElementById('galeriaContenedor');
        contenedor.innerHTML = '<div class="text-center w-100 py-3"><div class="spinner-border text-primary"></div></div>';

        modalDetallesBootstrap.show();

        try {
            const response = await fetch(`obtener_fotos.php?ref=${ref}&t=${new Date().getTime()}`);
            const fotos = await response.json();
            contenedor.innerHTML = ''; 
            if (fotos.length > 0) {
                fotos.forEach(fotoUrl => {
                    const div = document.createElement('div');
                    div.className = 'col-6 col-md-4 col-lg-3';
                    div.innerHTML = `<img src="${encodeURI(fotoUrl)}" class="galeria-img shadow-sm border" onclick="window.open('${encodeURI(fotoUrl)}', '_blank')">`;
                    contenedor.appendChild(div);
                });
            } else {
                contenedor.innerHTML = `<div class="text-center text-muted small w-100">Sin fotos extra</div>`;
            }
        } catch (error) { contenedor.innerHTML = 'Error cargando fotos'; }
    }

    function prepararAgregar(id, nombre, precio) {
        tempProducto = { id, nombre, precio };
        document.getElementById('lblProductoSeleccionado').innerText = nombre;
        document.getElementById('inputCantidadModal').value = 1;
        modalCantidadBootstrap.show();
        setTimeout(() => document.getElementById('inputCantidadModal').focus(), 500);
    }

    function confirmarAgregar() {
        let cant = parseInt(document.getElementById('inputCantidadModal').value);
        if (isNaN(cant) || cant < 1) return;

        let exist = carrito.find(i => i.id == tempProducto.id);
        if (exist) exist.cant += cant;
        else carrito.push({ ...tempProducto, cant: cant });
        
        guardar();
        modalCantidadBootstrap.hide();
    }

    function guardar() { localStorage.setItem('carrito_v2', JSON.stringify(carrito)); renderizar(); }
    
    function renderizar() {
        const lista = document.getElementById('lista-carrito');
        lista.innerHTML = '';
        let total = 0;
        if (carrito.length === 0) lista.innerHTML = '<li class="list-group-item text-center">Vacío</li>';
        
        carrito.forEach((item, index) => {
            total += item.precio * item.cant;
            lista.innerHTML += `
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <div>${item.nombre} <br><small>$${item.precio} x ${item.cant}</small></div>
                    <button class="btn btn-sm btn-danger" onclick="eliminar(${index})">X</button>
                </li>`;
        });
        document.getElementById('contador').innerText = carrito.length;
        document.getElementById('total-precio').innerText = '$' + total.toFixed(2);
    }

    function eliminar(i) { carrito.splice(i, 1); guardar(); }
    function borrarTodo() { carrito = []; guardar(); }

    async function enviarPedido(tipo) {
        const c = document.getElementById('cliente').value;
        const t = document.getElementById('telefono').value;
        const f = document.getElementById('fecha').value;
        if (!c || !f || carrito.length === 0) return alert("Faltan datos");

        if(!confirm("¿Confirmar acción?")) return;
        
        try {
            const res = await fetch('procesar_pedido.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ cliente: c, telefono: t, fecha: f, items: carrito, tipo: tipo })
            });
            const json = await res.json();
            
            if (json.success) {
                borrarTodo();
                bootstrap.Modal.getInstance(document.getElementById('modalCarrito')).hide();
                let div = document.createElement('div');
                div.innerHTML = `<div style="position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.8);z-index:9999;display:flex;align-items:center;justify-content:center;">
                    <div class="bg-white p-5 rounded text-center shadow">
                        <h2 class="text-success">¡Éxito!</h2>
                        <p class="text-muted">${json.ref}</p>
                        <a href="descargar_pdf.php?ref=${json.ref}&tipo=${tipo}" class="btn btn-primary btn-lg w-100 mb-3">Descargar PDF</a>
                        <button onclick="this.parentElement.parentElement.remove()" class="btn btn-secondary w-100">Cerrar</button>
                    </div></div>`;
                document.body.appendChild(div);
            } else { alert("Error: " + json.message); }
        } catch (e) { alert("Error de conexión"); }
    }
</script>
</body>
</html>