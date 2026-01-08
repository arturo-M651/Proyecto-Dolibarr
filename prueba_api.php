<?php
/**
 * PRUEBA_API.PHP - CATÁLOGO FINAL
 * Características:
 * - Conexión API Dolibarr v21
 * - Carrito de compras con LocalStorage
 * - Modal de Cantidad (UX)
 * - Modal de Detalles con Galería Externa (File System)
 */

$api_key = "55W05PsnTJuJRFg8lckZZ7hx10lM0Rz9"; 
$url_base = "http://localhost/dolibarr/htdocs/api/index.php"; 

// --- HELPER API ---
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

// --- LOGICA DE FILTRADO ---
$cat_id = isset($_GET['cat']) ? $_GET['cat'] : '';
$lista_categorias = callAPI($url_base . "/categories?type=product&sortfield=label&sortorder=ASC", $api_key);

if ($cat_id) {
    $endpoint = "/products?sortfield=t.ref&sortorder=ASC&category=" . $cat_id;
} else {
    $endpoint = "/products?sortfield=t.ref&sortorder=ASC&limit=50&sqlfilters=(t.tosell:=:1)"; 
}
$productos = callAPI($url_base . $endpoint, $api_key);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carpas Montes | Catálogo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        .btn-flotante { position: fixed; bottom: 20px; right: 20px; z-index: 1000; padding: 15px 25px; border-radius: 50px; box-shadow: 0 4px 15px rgba(0,0,0,0.3); font-weight: bold; }
        .card-img-top { height: 200px; object-fit: cover; }
        .card { transition: transform 0.2s; }
        .card:hover { transform: translateY(-5px); }
        .galeria-img { width: 100%; height: 150px; object-fit: cover; border-radius: 8px; cursor: pointer; transition: opacity 0.3s; }
        .galeria-img:hover { opacity: 0.8; }
    </style>
</head>
<body class="bg-light">

<div class="container py-5">
    <h1 class="text-center mb-4">🎪 Catálogo de Eventos</h1>

    <div class="d-flex justify-content-center mb-5 flex-wrap gap-2">
        <a href="prueba_api.php" class="btn <?php echo ($cat_id == '') ? 'btn-primary' : 'btn-outline-primary'; ?>">Todo</a>
        <?php
        if (!isset($lista_categorias['error']) && is_array($lista_categorias)) {
            foreach ($lista_categorias as $cat) {
                $clase = ($cat_id == $cat['id']) ? 'btn-primary' : 'btn-outline-primary';
                echo '<a href="?cat=' . $cat['id'] . '" class="btn ' . $clase . '">' . $cat['label'] . '</a>';
            }
        }
        ?>
    </div>

    <div class="row">
        <?php
        if (isset($productos['error']) || empty($productos)) {
            echo "<div class='alert alert-warning col-12 text-center'>No hay productos disponibles.</div>";
        } else {
            foreach ($productos as $producto) {
                $id = $producto['id'];
                $ref = $producto['ref']; // IMPORTANTE: Usado para la carpeta de fotos
                $label = addslashes($producto['label']); 
                $price = (float)$producto['price']; 
                // Limpieza de descripción para evitar errores de JS
                $desc = isset($producto['description']) ? addslashes(str_replace(["\r", "\n"], " ", $producto['description'])) : 'Sin descripción';
                
                $img_name = isset($producto['last_main_doc']) ? $producto['last_main_doc'] : $ref . ".jpg";
                $img_src = "imagen.php?ref=" . $ref . "&file=" . $img_name;
        ?>
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm border-0">
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
                                <i class="bi bi-cart-plus"></i> Agregar
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
                <p class="mb-2">Ingrese la cantidad deseada:</p>
                <input type="number" id="inputCantidadModal" class="form-control form-control-lg text-center mb-3" value="1" min="1">
                <button class="btn btn-success w-100" onclick="confirmarAgregar()">
                    <i class="bi bi-check-circle"></i> Confirmar
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalDetalles" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold" id="detalleTitulo">Detalles del Producto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12 mb-4">
                        <h3 class="text-primary" id="detallePrecio"></h3>
                        <p class="text-muted" id="detalleDesc"></p>
                    </div>
                    <div class="col-md-12">
                        <h6 class="border-bottom pb-2">📸 Galería de Fotos</h6>
                        <div id="galeriaContenedor" class="row g-2 mt-2">
                            </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalCarrito" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Tu Cotización</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3 bg-light p-3 rounded">
                    <input type="text" id="cliente" class="form-control mb-2" placeholder="Nombre Cliente">
                    <input type="text" id="telefono" class="form-control mb-2" placeholder="Teléfono">
                    <div class="row">
                        <div class="col"><input type="date" id="fecha" class="form-control"></div>
                    </div>
                </div>
                <ul id="lista-carrito" class="list-group mb-3"></ul>
                <h4 class="text-end">Total: <span id="total-precio">$0.00</span></h4>
            </div>
           <div class="modal-footer">
                <button class="btn btn-secondary" onclick="borrarTodo()">Limpiar</button>
                <button class="btn btn-warning" onclick="enviarPedido('cotizacion')"><i class="bi bi-file-earmark-text"></i> Solo Cotizar</button>
                <button class="btn btn-success" onclick="enviarPedido('pedido')"><i class="bi bi-bag-check-fill"></i> Confirmar Pedido</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // --- ESTADO GLOBAL ---
    let carrito = JSON.parse(localStorage.getItem('carrito_v2')) || [];
    let tempProducto = null; 
    
    // Instancias Bootstrap
    const modalCantidadBootstrap = new bootstrap.Modal(document.getElementById('modalCantidad'));
    const modalDetallesBootstrap = new bootstrap.Modal(document.getElementById('modalDetalles'));

    // Inicializar
    renderizar();

    // --- LÓGICA DE GALERÍA Y DETALLES ---
    async function verDetalles(ref, nombre, desc, precio) {
        document.getElementById('detalleTitulo').innerText = nombre;
        document.getElementById('detallePrecio').innerText = "$" + precio.toFixed(2);
        document.getElementById('detalleDesc').innerHTML = desc; 
        
        const contenedor = document.getElementById('galeriaContenedor');
        contenedor.innerHTML = '<div class="text-center w-100 py-3"><div class="spinner-border text-primary"></div><p>Buscando fotos...</p></div>';

        modalDetallesBootstrap.show();

        try {
            // Timestamp para evitar caché del navegador
            const response = await fetch(`obtener_fotos.php?ref=${ref}&t=${new Date().getTime()}`);
            const fotos = await response.json();

            contenedor.innerHTML = ''; 

            if (fotos.length > 0) {
                fotos.forEach(fotoUrl => {
                    const div = document.createElement('div');
                    div.className = 'col-6 col-md-4 col-lg-3';
                    const rutaSegura = encodeURI(fotoUrl);
                    
                    div.innerHTML = `
                        <div class="card h-100 border-0">
                            <img src="${rutaSegura}" 
                                 class="galeria-img shadow-sm border" 
                                 onclick="window.open('${rutaSegura}', '_blank')"
                                 onerror="this.parentElement.innerHTML='<small class=\'text-danger\'>Error img</small>'">
                        </div>
                    `;
                    contenedor.appendChild(div);
                });
            } else {
                contenedor.innerHTML = `<div class="alert alert-secondary w-100 text-center"><small>No hay fotos extra para: ${ref}</small></div>`;
            }

        } catch (error) {
            contenedor.innerHTML = '<div class="alert alert-danger w-100">Error cargando galería.</div>';
        }
    }

    // --- LÓGICA DE AGREGAR PRODUCTO (MODAL) ---
    function prepararAgregar(id, nombre, precio) {
        tempProducto = { id, nombre, precio };
        document.getElementById('lblProductoSeleccionado').innerText = nombre;
        document.getElementById('inputCantidadModal').value = 1;
        modalCantidadBootstrap.show();
        
        setTimeout(() => {
            const input = document.getElementById('inputCantidadModal');
            input.focus();
            input.select();
        }, 500);
    }

    function confirmarAgregar() {
        const input = document.getElementById('inputCantidadModal');
        let cantidad = parseInt(input.value);

        if (isNaN(cantidad) || cantidad < 1) {
            alert("Cantidad inválida");
            return;
        }

        let existente = carrito.find(i => i.id == tempProducto.id);
        if (existente) {
            existente.cant += cantidad;
        } else {
            carrito.push({ ...tempProducto, cant: cantidad });
        }
        
        guardar();
        modalCantidadBootstrap.hide();
    }

    // --- GESTIÓN DEL CARRITO ---
    function guardar() {
        localStorage.setItem('carrito_v2', JSON.stringify(carrito));
        renderizar();
    }

    function renderizar() {
        const lista = document.getElementById('lista-carrito');
        const contador = document.getElementById('contador');
        const totalHtml = document.getElementById('total-precio');
        
        lista.innerHTML = '';
        let total = 0;

        if (carrito.length === 0) {
            lista.innerHTML = '<li class="list-group-item text-center">Vacío</li>';
        }

        carrito.forEach((item, index) => {
            total += item.precio * item.cant;
            lista.innerHTML += `
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <div>${item.nombre} <br><small>$${item.precio} x ${item.cant}</small></div>
                    <button class="btn btn-sm btn-danger" onclick="eliminar(${index})"><i class="bi bi-trash"></i></button>
                </li>
            `;
        });

        contador.innerText = carrito.length; // Contador por items únicos
        totalHtml.innerText = '$' + total.toFixed(2);
    }

    function eliminar(index) {
        carrito.splice(index, 1);
        guardar();
    }

    function borrarTodo() {
        carrito = [];
        guardar();
    }

    // --- PROCESAR PEDIDO ---
    async function enviarPedido(tipo_accion) {
        const cliente = document.getElementById('cliente').value;
        const telefono = document.getElementById('telefono').value;
        const fecha = document.getElementById('fecha').value;

        if (!cliente || !fecha || carrito.length === 0) {
            alert("Completa los datos del cliente y agrega productos.");
            return;
        }

        if(!confirm("¿Estás seguro de procesar este documento?")) return;

        const btnOriginal = event.target;
        const textoOriginal = btnOriginal.innerHTML;
        btnOriginal.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Procesando...';
        btnOriginal.disabled = true;

        try {
            const respuesta = await fetch('procesar_pedido.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ cliente, telefono, fecha, items: carrito, tipo: tipo_accion })
            });

            const json = await respuesta.json();

            if (json.success) {
                let ref = json.ref;
                let etiqueta = (tipo_accion === 'pedido') ? "Pedido" : "Cotización";
                
                borrarTodo(); 
                bootstrap.Modal.getInstance(document.getElementById('modalCarrito')).hide();

                // Interfaz Temporal de Éxito
                let div = document.createElement('div');
                div.innerHTML = `
                    <div style="position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); z-index:9999; display:flex; align-items:center; justify-content:center;">
                        <div class="bg-white p-5 rounded text-center shadow animate__animated animate__fadeIn">
                            <h2 class="text-success"><i class="bi bi-check-circle-fill"></i> ¡${etiqueta} Creado!</h2>
                            <p class="fs-4 fw-bold text-muted">${ref}</p>
                            <hr>
                            <a href="descargar_pdf.php?ref=${ref}&tipo=${tipo_accion}" target="_blank" class="btn btn-primary btn-lg w-100 mb-3">
                                <i class="bi bi-file-earmark-pdf-fill"></i> Descargar PDF
                            </a>
                            <button onclick="this.parentElement.parentElement.remove()" class="btn btn-outline-secondary w-100">Cerrar</button>
                        </div>
                    </div>
                `;
                document.body.appendChild(div);

            } else {
                alert("Error del servidor: " + json.message);
            }

        } catch (e) {
            console.error(e);
            alert("Error de conexión. Revisa la consola.");
        } finally {
            btnOriginal.innerHTML = textoOriginal;
            btnOriginal.disabled = false;
        }
    }
</script>
</body>
</html>