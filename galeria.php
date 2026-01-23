<?php
/**
 * GALERIA.PHP - V1
 * Página de exhibición de eventos realizados
 */
require_once 'config.php'; 
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Galería | Carpas Montes</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Lato:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos.css">
    <style>
        /* Estilos específicos para la galería */
        .gallery-item { cursor: pointer; transition: transform 0.3s ease, box-shadow 0.3s ease; border-radius: 15px; overflow: hidden; position: relative; }
        .gallery-item:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.15); }
        .gallery-item img { width: 100%; height: 300px; object-fit: cover; transition: transform 0.5s ease; }
        .gallery-item:hover img { transform: scale(1.05); }
        .gallery-overlay { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(14, 76, 129, 0.4); opacity: 0; transition: opacity 0.3s ease; display: flex; align-items: center; justify-content: center; }
        .gallery-item:hover .gallery-overlay { opacity: 1; }
        .nav-pills .nav-link.active { background-color: var(--montes-gold, #c5a059) !important; color: white !important; }
        .nav-pills .nav-link { color: #555; font-weight: bold; }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg fixed-top bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="index.php">
             <div class="d-flex align-items-center">
               <img src="img/logo.png" width="40" height="40" alt="Logo" onerror="this.style.display='none'">
                <span class="fw-bold fs-4 ms-2" style="color: #00b4db;">CARPAS</span>
                <span class="fw-bold fs-4 ms-1" style="color: #0e4c81;">MONTES</span>
            </div>
        </a>
        <div class="d-flex align-items-center gap-3">
            <a href="prueba_api.php" class="text-decoration-none fw-bold text-muted small"><i class="bi bi-arrow-left"></i> VOLVER AL COTIZADOR</a>
        </div>
    </div>
</nav>

<div class="position-relative py-5 bg-dark text-white mt-5" style="background: linear-gradient(rgba(14, 76, 129, 0.8), rgba(14, 76, 129, 0.9)), url('carrusel/15x30.jpeg') center/cover;">
    <div class="container text-center py-5" data-aos="fade-up">
        <h1 class="display-4 fw-bold" style="font-family: 'Playfair Display', serif;">Nuestra Galería</h1>
        <p class="lead text-warning mb-0">Inspiración para tu próximo gran evento</p>
    </div>
</div>

<div class="container py-5">
    
    <div class="d-flex justify-content-center mb-5" data-aos="fade-up">
        <ul class="nav nav-pills bg-white p-1 rounded-pill shadow-sm">
            <li class="nav-item"><button class="nav-link active rounded-pill px-4" onclick="filtrarGaleria('todo')">Todo</button></li>
            <li class="nav-item"><button class="nav-link rounded-pill px-4" onclick="filtrarGaleria('bodas')">Bodas</button></li>
            <li class="nav-item"><button class="nav-link rounded-pill px-4" onclick="filtrarGaleria('empresarial')">Empresarial</button></li>
        </ul>
    </div>

    <div class="row g-4" id="galeriaGrid">
        
        <div class="col-12 col-md-6 col-lg-4 item-galeria" data-categoria="bodas" data-aos="zoom-in">
            <div class="gallery-item" onclick="verFotoFull(this)">
                <img src="carrusel/15x30.jpeg" alt="Montaje Elegante">
                <div class="gallery-overlay"><i class="bi bi-zoom-in text-white fs-1"></i></div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-lg-4 item-galeria" data-categoria="empresarial" data-aos="zoom-in" data-aos-delay="100">
            <div class="gallery-item" onclick="verFotoFull(this)">
                <img src="carrusel/Carpa_Luces.jpeg" alt="Iluminación Nocturna">
                <div class="gallery-overlay"><i class="bi bi-zoom-in text-white fs-1"></i></div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-lg-4 item-galeria" data-categoria="bodas" data-aos="zoom-in" data-aos-delay="200">
            <div class="gallery-item" onclick="verFotoFull(this)">
                <img src="carrusel/carpa-hule.jpeg" alt="Carpa Transparente">
                <div class="gallery-overlay"><i class="bi bi-zoom-in text-white fs-1"></i></div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-lg-4 item-galeria" data-categoria="empresarial" data-aos="zoom-in">
            <div class="gallery-item" onclick="verFotoFull(this)">
                <img src="carrusel/arcoiris.jpeg" alt="Evento Masivo">
                <div class="gallery-overlay"><i class="bi bi-zoom-in text-white fs-1"></i></div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-lg-4 item-galeria" data-categoria="bodas" data-aos="zoom-in" data-aos-delay="100">
            <div class="gallery-item" onclick="verFotoFull(this)">
                <img src="carrusel/carpa.jpeg" alt="Detalle Montaje">
                <div class="gallery-overlay"><i class="bi bi-zoom-in text-white fs-1"></i></div>
            </div>
        </div>
        
        </div>
</div>

<div class="modal fade" id="modalVisor" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content bg-transparent border-0">
            <div class="modal-body p-0 position-relative text-center">
                <button type="button" class="btn-close btn-close-white position-absolute top-0 end-0 m-3 z-3 bg-dark rounded-circle p-2" data-bs-dismiss="modal"></button>
                <img id="imgFull" src="" class="img-fluid rounded shadow-lg" style="max-height: 90vh;">
                <h5 id="tituloFull" class="text-white mt-3 text-shadow"></h5>
            </div>
        </div>
    </div>
</div>

<footer class="bg-dark text-white pt-5 pb-3">
    <div class="container text-center">
        <p class="text-white-50 small">Carpas Montes &copy; <?php echo date('Y'); ?></p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init();

    // Función de filtrado simple
    function filtrarGaleria(cat) {
        document.querySelectorAll('.nav-link').forEach(btn => btn.classList.remove('active'));
        event.target.classList.add('active');

        const items = document.querySelectorAll('.item-galeria');
        items.forEach(item => {
            if (cat === 'todo' || item.getAttribute('data-categoria') === cat) {
                item.style.display = 'block';
                // Reiniciar animación
                item.classList.remove('aos-animate');
                setTimeout(() => item.classList.add('aos-animate'), 50);
            } else {
                item.style.display = 'none';
            }
        });
    }

    // Función visor
    const modalVisor = new bootstrap.Modal(document.getElementById('modalVisor'));
    function verFotoFull(elemento) {
        const src = elemento.querySelector('img').src;
        const alt = elemento.querySelector('img').alt;
        document.getElementById('imgFull').src = src;
        document.getElementById('tituloFull').innerText = alt;
        modalVisor.show();
    }
</script>

</body>
</html>