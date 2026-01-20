/**
 * APP.JS - LÓGICA V58 (ENVÍO DINÁMICO TIPO DE TERCERO)
 */

AOS.init({ once: true, disable: 'mobile' });

// VARIABLES
let carrito = JSON.parse(localStorage.getItem('carrito_v2')) || [];
let tempProducto = null; 
let currentProductoId = null; 
let currentProductoNombre = ""; 
let currentProductoPrecio = 0;
let esCarpaModular = false; 
let anchoFijo = 0;

// Variables simulador (Se mantienen para que no de error si el canvas existe)
let viewState = { mode: '2d', scale: 20, offsetX: 0, offsetY: 0, isDragging: false, lastX: 0, lastY: 0, lastPinchDist: 0 };

const modalCantidadBootstrap = new bootstrap.Modal(document.getElementById('modalCantidad'));
const modalDetallesBootstrap = new bootstrap.Modal(document.getElementById('modalDetalles'));
const modalCarritoBootstrap = new bootstrap.Modal(document.getElementById('modalCarrito'));

document.addEventListener('DOMContentLoaded', () => {
    if(document.querySelector('.mode-switch')) {
        filtrarMobiliario('unidad'); 
        const btn = document.querySelector('.mode-btn');
        if(btn) btn.classList.add('active');
    }
    renderizar();
});

// FILTRADO
function filtrarMobiliario(modo) {
    const btns = document.querySelectorAll('.mode-btn');
    btns.forEach(b => b.classList.remove('active'));
    if(event && event.target) event.target.classList.add('active');
    
    const slider = document.getElementById('modeSlider');
    if(slider) slider.style.transform = (modo === 'paquete') ? 'translateX(100%)' : 'translateX(0)';
    
    document.querySelectorAll('.item-producto').forEach(prod => {
        const tipo = prod.getAttribute('data-tipo');
        if (tipo === modo) {
            prod.style.display = 'block';
            prod.classList.remove('aos-animate');
            setTimeout(() => prod.classList.add('aos-animate'), 50);
        } else {
            prod.style.display = 'none';
        }
    });
}

// BUSCADOR
const buscador = document.getElementById('buscadorJS');
if(buscador){
    buscador.addEventListener('keyup', function(e) {
        const texto = e.target.value.toLowerCase();
        document.querySelectorAll('.item-producto').forEach(item => {
            if(item.style.display !== 'none'){
                const nombre = item.getAttribute('data-nombre');
                item.style.display = nombre.includes(texto) ? 'block' : 'none';
            }
        });
    });
}

// DETALLES
async function verDetalles(ref, nombre, desc, precio, imgMain, id) {
    currentProductoId = id;
    currentProductoNombre = nombre;
    currentProductoPrecio = precio;

    document.getElementById('detalleTitulo').innerText = nombre;
    document.getElementById('detalleDesc').innerHTML = desc || '<em class="text-muted">Sin descripción.</em>';
    document.getElementById('imgPrincipal').src = imgMain;
    document.getElementById('inputCantidadDetalle').value = 1;

    // Resetear paneles
    const panelMedidas = document.getElementById('panelMedidas');
    const divCant = document.getElementById('divCantidadNormal');
    
    esCarpaModular = false;

    // Lógica Carpas
    if (nombre.toLowerCase().includes("ancho") || nombre.toLowerCase().includes("carpa") || nombre.toLowerCase().includes("toldo")) {
        esCarpaModular = true;
        const match = nombre.match(/(\d+)/);
        anchoFijo = match ? parseInt(match[0]) : 10; 
        
        panelMedidas.style.display = 'block';
        divCant.style.display = 'none'; 
        
        document.getElementById('pills-plano-tab').style.display = 'block'; 
        document.getElementById('inputAncho').value = anchoFijo;
        document.getElementById('inputLargo').value = 5; 
        document.getElementById('detallePrecio').innerText = "$" + precio.toFixed(2) + " / m²";
        document.getElementById('lblPrecioTotal').innerText = ""; 
        
        // Simulador activo (se deja tal cual funcionaba)
        setMode('2d'); 

    } else {
        esCarpaModular = false;
        panelMedidas.style.display = 'none';
        divCant.style.display = 'block';
        document.getElementById('pills-plano-tab').style.display = 'none'; 
        document.getElementById('detallePrecio').innerText = "$" + precio.toFixed(2);
        document.getElementById('lblPrecioTotal').innerText = "";
        
        const tabBtn = document.querySelector('#pills-foto-tab');
        new bootstrap.Tab(tabBtn).show();
    }

    modalDetallesBootstrap.show();
    cargarGaleria(ref, imgMain);
}

// GALERIA
async function cargarGaleria(ref, imgMain) {
    const contenedor = document.getElementById('galeriaContenedor');
    contenedor.innerHTML = '<div class="spinner-border spinner-border-sm text-warning mx-auto"></div>';
    try {
        const res = await fetch(`obtener_fotos.php?ref=${ref}&t=${Date.now()}`);
        const fotos = await res.json();
        contenedor.innerHTML = ''; 
        let htmlFotos = `<img src="${imgMain}" class="thumb-img border active" onclick="cambiarImagen(this.src, this)">`;
        if (fotos.length) {
            fotos.forEach(url => {
                if(url !== imgMain) {
                    htmlFotos += `<img src="${encodeURI(url)}" class="thumb-img border" onclick="cambiarImagen(this.src, this)">`;
                }
            });
        }
        contenedor.innerHTML = htmlFotos;
    } catch (e) { contenedor.innerHTML = ''; }
}

function cambiarImagen(src, elem) {
    document.getElementById('imgPrincipal').src = src;
    document.querySelectorAll('.thumb-img').forEach(img => img.classList.remove('border-primary'));
    elem.classList.add('border-primary');
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
function guardar() { localStorage.setItem('carrito_v2', JSON.stringify(carrito)); renderizar(); }

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

// ENVÍO (MODO SOLO REFERENCIA + TIPO TERCERO DINÁMICO)
async function enviarPedido(tipo) {
    tipo = 'cotizacion'; 
    
    // 1. CAPTURAR DATOS
    const selectTercero = document.getElementById('tipo_tercero');
    const typentId = selectTercero.value; // ID real de Dolibarr (e.g., 2, 8)
    const typentLabel = selectTercero.options[selectTercero.selectedIndex]?.text; // Nombre visible (e.g., Particular)

    const c = document.getElementById('cliente').value;
    const e = document.getElementById('email').value;
    const f = document.getElementById('fecha').value;
    
    // 2. VALIDACIONES
    if (!typentId || typentId === "") { 
        alert("⚠️ Por favor selecciona qué tipo de cliente eres (Particular, Empresa, etc)."); 
        selectTercero.focus();
        return; 
    }

    if (!c || !e || !f || carrito.length === 0) { 
        alert("Completa: Nombre, Email y Fecha."); 
        return; 
    }

    if(!confirm(`¿Enviar solicitud de cotización?`)) return;

    const btn = event.target;
    btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Enviando...';
    btn.disabled = true;

    try {
        const res = await fetch('procesar_pedido.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                typent_id: typentId, // ID numérico para Dolibarr
                tipo_label: typentLabel, // Nombre para nota
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
            
            // MENSAJE CLARO AL USUARIO
            alert(`✅ ¡Solicitud Enviada!\n\nTu folio es: ${json.ref}\n\nRevisa tu correo en la seccion de Spam. Un asesor te contactará para confirmar disponibilidad.`);
            
        } else { 
            alert("Error: " + json.message); 
        }
    } catch (err) { 
        console.error(err);
        alert("Error de conexión"); 
    } finally { 
        btn.innerHTML = '<i class="bi bi-file-earmark-text me-2"></i> Solicitar Cotización';
        btn.disabled = false; 
    }
}

// --- CÓDIGO SIMULADOR INTACTO (PARA NO ROMPER NADA) ---
const canvas = document.getElementById('canvasPlano');
const container = document.getElementById('contenedorCanvas');

if(canvas && container) {
    canvas.addEventListener('mousedown', (e) => { viewState.isDragging = true; viewState.lastX = e.clientX; viewState.lastY = e.clientY; });
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
    // Táctil
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
    canvas.addEventListener('touchend', () => { viewState.isDragging = false; viewState.lastPinchDist = 0; });
    
    // Observer
    new ResizeObserver(entries => {
        for (let entry of entries) {
            const { width, height } = entry.contentRect;
            canvas.width = width;
            canvas.height = height;
            requestAnimationFrame(dibujarPlano);
        }
    }).observe(container);
}

function init3DView() { setTimeout(() => { autoFit(); actualizarCalculosRender(); }, 100); }

function setMode(mode) {
    viewState.mode = mode;
    document.getElementById('btn2D').classList.toggle('active', mode === '2d');
    document.getElementById('btn3D').classList.toggle('active', mode === '3d');
    
    const info2D = document.getElementById('info2D');
    const info3D = document.getElementById('info3D');
    if(info2D) info2D.style.display = (mode === '2d') ? 'flex' : 'none';
    if(info3D) info3D.style.display = (mode === '3d') ? 'flex' : 'none';
    
    autoFit(); 
}

function resetView() { autoFit(); }
function ajustarZoom(factor) { viewState.scale *= factor; requestAnimationFrame(dibujarPlano); }

function autoFit() {
    if(!canvas) return;
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
    const alturaPoste = 3.5; const alturaCumbrera = 1.5;
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

    ctx.fillStyle = "rgba(220, 230, 240, 0.4)"; 
    ctx.beginPath(); ctx.moveTo(aleroIzqIni.x, aleroIzqIni.y); ctx.lineTo(cumbInicio.x, cumbInicio.y); ctx.lineTo(cumbFin.x, cumbFin.y); ctx.lineTo(aleroIzqFin.x, aleroIzqFin.y); ctx.fill();
    ctx.beginPath();
    ctx.moveTo(aleroDerIni.x, aleroDerIni.y); ctx.lineTo(cumbInicio.x, cumbInicio.y); ctx.lineTo(cumbFin.x, cumbFin.y); ctx.lineTo(aleroDerFin.x, aleroDerFin.y); ctx.fill();
    
    ctx.strokeStyle = '#000'; ctx.fillStyle = '#000'; ctx.font = 'bold 12px Arial'; ctx.lineWidth = 1;
    let ac1 = toIso(ancho, -1, 0); let ac2 = toIso(0, -1, 0); ctx.beginPath(); ctx.moveTo(ac1.x, ac1.y); ctx.lineTo(ac2.x, ac2.y); ctx.stroke();
    ctx.fillText(`${ancho}m`, (ac1.x+ac2.x)/2 - 10, (ac1.y+ac2.y)/2); 
    let lc1 = toIso(-1, 0, 0); let lc2 = toIso(-1, largo, 0);
    ctx.beginPath(); ctx.moveTo(lc1.x, lc1.y); ctx.lineTo(lc2.x, lc2.y); ctx.stroke();
    ctx.fillText(`${largo}m`, (lc1.x+lc2.x)/2 - 10, (lc1.y+lc2.y)/2);
}