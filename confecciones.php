<?php
/**
 * CONFECCIONES.PHP - Página de Fabricación y Venta
 */
require_once 'config.php'; 
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confección y Venta | Carpas Montes</title>
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
                <span class="fw-bold fs-3" style="color: var(--montes-cyan);">CARPAS</span>
                <span class="fw-bold fs-3 ms-1" style="color: var(--montes-dark);">MONTES</span>
            </div>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto gap-3">
                <li class="nav-item"><a class="nav-link" href="index.php">Inicio</a></li>
                <li class="nav-item"><a class="nav-link" href="prueba_api.php">Renta de Mobiliario</a></li>
                <li class="nav-item"><a class="nav-link text-warning fw-bold" href="confecciones.php">Confección</a></li>
            </ul>
        </div>
    </div>
</nav>

<header class="hero-confecciones">
    <div class="container" data-aos="fade-up">
        <h1 class="display-3 fw-bold mb-3" style="font-family: 'Playfair Display', serif;">Fabricación a la Medida</h1>
        <p class="fs-4 mb-4 text-light opacity-75">Diseñamos y confeccionamos soluciones textiles de alta resistencia para la industria, el comercio y el hogar.</p>
        <a href="#cotizar" class="btn btn-gold shadow-lg">Solicitar Presupuesto</a>
    </div>
</header>

<div class="container py-5">
    
    <div class="text-center mb-5" data-aos="fade-up">
        <h2 class="fw-bold text-dark">Nuestras Especialidades</h2>
        <div style="width: 60px; height: 3px; background: var(--gold); margin: 10px auto;"></div>
        <p class="text-muted">Trabajos garantizados con materiales de primera calidad.</p>
    </div>

    <div class="row g-4 mb-5">
        <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
            <div class="solution-card bg-white">
                <img src="/img/confeccion/lonas.jpg" class="solution-img" alt="Lonas">
                <div class="p-4">
                    <h4 class="fw-bold mb-2">Lonas Industriales</h4>
                    <p class="text-muted small">Cubiertas para transporte (camioneras), fundas para maquinaria y separaciones industriales.</p>
                    <ul class="list-unstyled small text-muted">
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i>Impermeables</li>
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i>Ojillos reforzados</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
            <div class="solution-card bg-white">
                <img src="/img/confeccion/malla_sombra.jpg" class="solution-img" alt="Velarias">
                <div class="p-4">
                    <h4 class="fw-bold mb-2">Malla Sombra y Velarias</h4>
                    <p class="text-muted small">Protección UV estética para jardines, escuelas y estacionamientos. Diseño arquitectónico.</p>
                    <ul class="list-unstyled small text-muted">
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i>90% a 95% Sombra</li>
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i>Durabilidad 5+ años</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
            <div class="solution-card bg-white">
                <img src="/img/confeccion/lonas-rollo.jpg" class="solution-img" alt="Carpas">
                <div class="p-4">
                    <h4 class="fw-bold mb-2">Lonas a Medida</h4>
                    <p class="text-muted small">Vulcanizado y/o costura de  lonas para carpas de todos los tamaños. Ideal para negocios.</p>
                    <ul class="list-unstyled small text-muted">
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i>Variedad de Colores</li>
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i>Duracion garantizada</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4 mb-5">
        
        <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="100">
            <div class="solution-card bg-white h-100">
                <img src="img/confeccion/toldos.jpg" class="solution-img" alt="Toldos Enrollables"
                     onerror="this.src='https://placehold.co/600x400/0e4c81/ffffff?text=Toldos+Enrollables'">
                <div class="p-4">
                    <h5 class="fw-bold mb-2">Toldos Enrollables</h5>
                    <p class="text-muted small">Sistemas retráctiles manuales o motorizados. Ideales para locales comerciales, terrazas y balcones.</p>
                    <ul class="list-unstyled small text-muted">
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i>Protección Solar UV</li>
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i>Mecanismo Duradero</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="200">
            <div class="solution-card bg-white h-100">
                <img src="img/confeccion/cortinas.jpg" class="solution-img" alt="Cortinas"
                     onerror="this.src='https://placehold.co/600x400/0e4c81/ffffff?text=Cortinas+a+Medida'">
                <div class="p-4">
                    <h5 class="fw-bold mb-2">Cortinas a Medida</h5>
                    <p class="text-muted small">Fabricación de paredes laterales para carpas (lisas o con ventana panorámica) y cortinas industriales.</p>
                    <ul class="list-unstyled small text-muted">
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i>Transparentes / Blancas</li>
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i>Fácil instalación</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="300">
            <div class="solution-card bg-white h-100">
                <img src="img/confeccion/camionera.jpg" class="solution-img" alt="Lonas Camioneras"
                     onerror="this.src='https://placehold.co/600x400/0e4c81/ffffff?text=Lonas+Camioneras'">
                <div class="p-4">
                    <h5 class="fw-bold mb-2">Lonas Camioneras</h5>
                    <p class="text-muted small">Cubiertas de uso rudo para transporte de carga. Material certificado de alta resistencia al rasgado.</p>
                    <ul class="list-unstyled small text-muted">
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i>100% Impermeable</li>
                        <li><i class="bi bi-check-circle-fill text-warning me-2"></i>Ojillos de Acero</li>
                    </ul>
                </div>
            </div>
        </div>

    </div>

    <div class="row align-items-center py-5">
        <div class="col-lg-6 mb-4" data-aos="fade-right">
            <h2 class="fw-bold mb-4">Calidad que Resiste</h2>
            <p class="text-muted mb-4">No usamos materiales genéricos. Seleccionamos textiles técnicos diseñados para soportar el sol, la lluvia y el uso rudo.</p>
            
            <div class="material-badge">
                <h6 class="fw-bold mb-1">Lona Oplex / Fortoflex</h6>
                <small class="text-muted">610g o 800g. Ideal para uso rudo, 100% impermeable y con protección antifungo.</small>
            </div>
            
            <div class="material-badge">
                <h6 class="fw-bold mb-1">Malla Sombra Monofilamento</h6>
                <small class="text-muted">Tejido de alta densidad que reduce la temperatura hasta 5 grados. No se deshilacha.</small>
            </div>
        </div>
        <div class="col-lg-6" data-aos="fade-left">
            <img src="/img/confeccion/FORTOFLEX.jpg" class="img-fluid rounded-4 shadow-lg" alt="Materiales">
        </div>
    </div>

    <div id="cotizar" class="py-5">
        <div class="quote-form-container">
            <div class="row">
                <div class="col-lg-5 mb-4">
                    <h3 class="fw-bold mb-3">Cotiza tu Proyecto</h3>
                    <p class="text-muted">Cuéntanos qué necesitas. Si tienes las medidas aproximadas, inclúyelas para darte un precio más rápido.</p>
                    <div class="d-flex align-items-center gap-3 mt-4">
                        <div class="bg-light rounded-circle p-3 text-warning"><i class="bi bi-whatsapp fs-4"></i></div>
                        <div>
                            <small class="text-muted d-block">Atención directa</small>
                            <span class="fw-bold">55 1706 2971 <br> 55 4069 4603</span>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-7">
                    <form onsubmit="enviarWhatsapp(event)">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-bold">Nombre</label>
                                <input type="text" id="nombre" class="form-control bg-light border-0" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold">Teléfono</label>
                                <input type="tel" id="tel" class="form-control bg-light border-0" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label small fw-bold">Tipo de Trabajo</label>
                                <select id="tipo" class="form-select bg-light border-0">
                                    <option>Lona a la medida</option>
                                    <option>Malla Sombra</option>
                                    <option>Reparación / Vulcanizado</option>
                                    <option>Carpa Completa</option>
                                    <option>Otro</option>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label small fw-bold">Medidas Aprox / Detalles</label>
                                <textarea id="detalles" class="form-control bg-light border-0" rows="3" placeholder="Ej: 5x10 metros, color blanco..."></textarea>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-gold w-100 py-3 rounded-pill fw-bold shadow">
                                    <i class="bi bi-send me-2"></i> Enviar Cotización por WhatsApp
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>

<footer class="bg-dark text-white pt-5 pb-3">
    <div class="container text-center">
        <p class="text-white-50 small">&copy; 2026 Carpas Montes. División Manufactura.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init();

    function enviarWhatsapp(e) {
        e.preventDefault();
        const nombre = document.getElementById('nombre').value;
        const tipo = document.getElementById('tipo').value;
        const detalles = document.getElementById('detalles').value;
        
        const mensaje = `Hola, soy ${nombre}. Me interesa cotizar: *${tipo}*. Detalles: ${detalles}`;
        const url = `https://wa.me/525517062971?text=${encodeURIComponent(mensaje)}`;
        
        window.open(url, '_blank');
    }
</script>

</body>
</html>