<?php
// prueba_api.php - VERSIÓN CORREGIDA FINAL
$api_key = "55W05PsnTJuJRFg8lckZZ7hx10lM0Rz9"; 
$url_base = "http://localhost/dolibarr/htdocs/api/index.php"; 

// Función segura para llamar a la API
function callAPI($url, $api_key) {
    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => array("DOLAPIKEY: " . $api_key, "Accept: application/json"),
    ));
    $response = curl_exec($curl);
    if(curl_errno($curl)) return []; // Si falla, devuelve array vacío
    curl_close($curl);
    return json_decode($response, true);
}

// Obtener datos
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
    <title>Carpas Montes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        .btn-flotante { position: fixed; bottom: 20px; right: 20px; z-index: 1000; padding: 15px 25px; border-radius: 50px; box-shadow: 0 4px 15px rgba(0,0,0,0.3); font-weight: bold; }
        .card-img-top { height: 200px; object-fit: cover; }
    </style>
</head>
<body class="bg-light">

<div class="container py-5">
    <h1 class="text-center mb-4">🎪 Catalogo y Cotizadon de Eventos</h1>

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
                // Saneamiento de variables para evitar errores de JS
                $id = $producto['id'];
                $ref = $producto['ref'];
                $label = addslashes($producto['label']); // Escapar comillas para JS
                $price = (float)$producto['price']; // Forzar número
                
                // Imagen
                $img_name = isset($producto['last_main_doc']) ? $producto['last_main_doc'] : $ref . ".jpg";
                $img_src = "imagen.php?ref=" . $ref . "&file=" . $img_name;
        ?>
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm border-0">
                    <img src="<?php echo $img_src; ?>" class="card-img-top">
                    <div class="card-body">
                        <h5 class="card-title"><?php echo $label; ?></h5>
                        <h3 class="text-primary">$<?php echo number_format($price, 2); ?></h3>
                        <button class="btn btn-outline-success w-100 mt-2" 
                                onclick="agregarItem(<?php echo $id; ?>, '<?php echo $label; ?>', <?php echo $price; ?>)">
                            <i class="bi bi-cart-plus"></i> Agregar
                        </button>
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
                
                <button class="btn btn-warning" onclick="enviarPedido('cotizacion')">
                    <i class="bi bi-file-earmark-text"></i> Solo Cotizar
                </button>
                
                <button class="btn btn-success" onclick="enviarPedido('pedido')">
                    <i class="bi bi-bag-check-fill"></i> Confirmar Pedido
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Variables globales
    let carrito = JSON.parse(localStorage.getItem('carrito_v2')) || [];
    renderizar();

    // Agregar item
    function agregarItem(id, nombre, precio) {
        let existente = carrito.find(i => i.id == id);
        if (existente) {
            existente.cant++;
        } else {
            carrito.push({ id: id, nombre: nombre, precio: precio, cant: 1 });
        }
        guardar();
    }

    // Guardar y Renderizar
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
        let items = 0;

        if (carrito.length === 0) {
            lista.innerHTML = '<li class="list-group-item text-center">Vacío</li>';
        }

        carrito.forEach((item, index) => {
            total += item.precio * item.cant;
            items += item.cant;
            lista.innerHTML += `
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <div>${item.nombre} <br><small>$${item.precio} x ${item.cant}</small></div>
                    <div>
                        <button class="btn btn-sm btn-danger" onclick="eliminar(${index})">X</button>
                    </div>
                </li>
            `;
        });

        contador.innerText = items;
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

    // ENVIAR A PHP
   // FUNCIÓN ACTUALIZADA CON DESCARGA DE PDF
    async function enviarPedido(tipo_accion) {
        
        const cliente = document.getElementById('cliente').value;
        const telefono = document.getElementById('telefono').value;
        const fecha = document.getElementById('fecha').value;

        if (!cliente || !fecha || carrito.length === 0) {
            alert("Faltan datos o el carrito está vacío");
            return;
        }

        let mensaje = (tipo_accion === 'pedido') ? "¿Confirmar compra?" : "¿Generar cotización?";
        if(!confirm(mensaje)) return;

        // Feedback visual de carga
        const btnOriginal = event.target;
        const textoOriginal = btnOriginal.innerHTML;
        btnOriginal.innerHTML = "Procesando...";
        btnOriginal.disabled = true;

        try {
            const respuesta = await fetch('procesar_pedido.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ 
                    cliente, 
                    telefono, 
                    fecha, 
                    items: carrito,
                    tipo: tipo_accion 
                })
            });

            const json = await respuesta.json();

            if (json.success) {
                // ÉXITO: Mostramos un modal o alerta especial con el botón de descarga
                let ref = json.ref;
                let etiqueta = (tipo_accion === 'pedido') ? "Pedido" : "Cotización";
                
                // Limpiamos carrito primero
                borrarTodo(); 
                bootstrap.Modal.getInstance(document.getElementById('modalCarrito')).hide();

                // TRUCO DE INGENIERÍA:
                // Creamos una interfaz temporal para ofrecer la descarga
                let div = document.createElement('div');
                div.innerHTML = `
                    <div style="position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); z-index:9999; display:flex; align-items:center; justify-content:center;">
                        <div class="bg-white p-5 rounded text-center shadow">
                            <h2 class="text-success">¡${etiqueta} Creado!</h2>
                            <p class="fs-4 fw-bold text-muted">${ref}</p>
                            <hr>
                            <p>Tu documento ha sido generado correctamente.</p>
                            
                            <a href="descargar_pdf.php?ref=${ref}&tipo=${tipo_accion}" target="_blank" class="btn btn-primary btn-lg w-100 mb-3">
                                <i class="bi bi-file-earmark-pdf-fill"></i> Descargar PDF Oficial
                            </a>
                            
                            <button onclick="this.parentElement.parentElement.remove()" class="btn btn-outline-secondary w-100">Cerrar</button>
                        </div>
                    </div>
                `;
                document.body.appendChild(div);

            } else {
                alert("Error: " + json.message);
            }

        } catch (e) {
            console.error(e);
            alert("Error técnico de conexión.");
        } finally {
            // Restaurar botón
            btnOriginal.innerHTML = textoOriginal;
            btnOriginal.disabled = false;
        }
    }
</script>
</body>
</html>