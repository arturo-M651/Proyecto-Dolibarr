<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carpas Montes | Eventos Exclusivos</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <link rel="stylesheet" href="estilos.css">
</head>
<body>

    <nav class="navbar navbar-expand-lg fixed-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold fs-3" href="#">
                </i> Carpas Montes
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link mx-2" href="#">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link mx-2" href="#servicios">Experiencia</a></li>
                    <li class="nav-item"><a class="nav-link mx-2" href="#galeria">Galería</a></li>
                    <li class="nav-item ms-lg-3">
                        <a class="btn btn-gold" href="prueba_api.php">Ver Catálogo</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="hero-section">
        <div class="container" data-aos="zoom-in" data-aos-duration="1000">
            <h1 class="hero-title display-1 fw-bold">Creamos Momentos <br> <span style="color:var(--gold);">Inolvidables</span></h1>
            <p class="lead mb-5 fs-4 text-light opacity-75">La mejor infraestructura para eventos en el Estado de México.</p>
            <div class="d-flex gap-3 justify-content-center flex-wrap">
                <a href="prueba_api.php" class="btn btn-gold btn-lg shadow-lg">
                    <i class="bi bi-calendar-check"></i> Cotizar Mi Evento
                </a>
                <a href="https://wa.me/525512345678" target="_blank" class="btn btn-outline-light btn-lg px-5 rounded-pill fw-bold">
                    <i class="bi bi-whatsapp"></i> Contactar
                </a>
            </div>
        </div>
    </header>

    <section class="py-5 bg-dark text-white">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-4 mb-3" data-aos="fade-up" data-aos-delay="100">
                    <h2 class="display-4 fw-bold text-warning">25+</h2>
                    <p class="text-uppercase ls-2">Años de Experiencia</p>
                </div>
                <div class="col-md-4 mb-3" data-aos="fade-up" data-aos-delay="200">
                    <h2 class="display-4 fw-bold text-warning">5000+</h2>
                    <p class="text-uppercase ls-2">Eventos Exitosos</p>
                </div>
                <div class="col-md-4 mb-3" data-aos="fade-up" data-aos-delay="300">
                    <h2 class="display-4 fw-bold text-warning">100%</h2>
                    <p class="text-uppercase ls-2">Clientes Satisfechos</p>
                </div>
            </div>
        </div>
    </section>

    <section id="servicios" class="py-5">
        <div class="container py-5">
            <div class="text-center mb-5" data-aos="fade-down">
                <h5 class="text-warning text-uppercase fw-bold">¿Por qué elegirnos?</h5>
                <h2 class="fw-bold display-5 text-dark">Excelencia en cada detalle</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-4" data-aos="flip-left">
                    <div class="service-card shadow-sm text-center">
                        <i class="bi bi-gem feature-icon"></i>
                        <h4 class="mb-3">Calidad Premium</h4>
                        <p class="text-muted">Mobiliario de alta gama, limpio y en perfectas condiciones estéticas para tu celebración.</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="flip-left" data-aos-delay="200">
                    <div class="service-card shadow-sm text-center">
                        <i class="bi bi-alarm feature-icon"></i>
                        <h4 class="mb-3">Puntualidad Absoluta</h4>
                        <p class="text-muted">Entendemos la importancia del tiempo. Tu montaje estará listo mucho antes de que llegue el primer invitado.</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="flip-left" data-aos-delay="400">
                    <div class="service-card shadow-sm text-center">
                        <i class="bi bi-truck feature-icon"></i>
                        <h4 class="mb-3">Logística Integral</h4>
                        <p class="text-muted">Nos encargamos del transporte, montaje y desmontaje. Tú solo preocúpate por disfrutar.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 bg-white">
        <div class="container py-4">
            <div class="text-center mb-5" data-aos="fade-up">
                <h5 class="text-warning text-uppercase fw-bold">Proceso Simple</h5>
                <h2 class="display-5 fw-bold">Tu evento en 4 pasos</h2>
            </div>
            
            <div class="row text-center g-4">
                <div class="col-md-3" data-aos="fade-right" data-aos-delay="100">
                    <div class="position-relative p-4">
                        <div class="display-4 text-warning mb-3"><i class="bi bi-laptop"></i></div>
                        <h4 class="fw-bold">1. Cotiza</h4>
                        <p class="text-muted">Explora nuestro catálogo en línea y agrega lo que necesitas al carrito.</p>
                    </div>
                </div>
                <div class="col-md-3" data-aos="fade-right" data-aos-delay="200">
                    <div class="position-relative p-4">
                        <div class="display-4 text-warning mb-3"><i class="bi bi-file-earmark-text"></i></div>
                        <h4 class="fw-bold">2. Confirma</h4>
                        <p class="text-muted">Llena tus datos. Recibirás un PDF y un correo, Espera la confirmación por llamada.</p>
                    </div>
                </div>
                <div class="col-md-3" data-aos="fade-right" data-aos-delay="300">
                    <div class="position-relative p-4">
                        <div class="display-4 text-warning mb-3"><i class="bi bi-calendar-check"></i></div>
                        <h4 class="fw-bold">3. Recibe</h4>
                        <p class="text-muted">Nuestro equipo entrega y monta todo en tu domicilio puntualmemte.</p>
                    </div>
                </div>
                <div class="col-md-3" data-aos="fade-right" data-aos-delay="400">
                    <div class="position-relative p-4">
                        <div class="display-4 text-warning mb-3"><i class="bi bi-emoji-laughing"></i></div>
                        <h4 class="fw-bold">4. Disfruta</h4>
                        <p class="text-muted">Celebra sin preocupaciones. Nosotros pasamos a recoger todo al final.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 bg-dark text-white position-relative">
    <div style="position: absolute; top:0; left:0; width:100%; height:100%; background: url('https://www.transparenttextures.com/patterns/cubes.png'); opacity: 0.1;"></div>

    <div class="container position-relative z-1 py-4">
        <div class="text-center mb-5" data-aos="zoom-in">
            <h5 class="text-warning text-uppercase fw-bold">Nuestros Clientes</h5>
            <h2 class="display-5 fw-bold">Lo que dicen de nosotros</h2>
        </div>

        <div class="row g-4">
            <div class="col-md-4" data-aos="flip-up" data-aos-delay="100">
                <div class="card bg-secondary bg-opacity-25 border-0 h-100 text-white p-4">
                    <div class="card-body">
                        <div class="mb-3 text-warning">
                            <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                        </div>
                        <p class="fst-italic">"El servicio fue impecable. Las carpas estaban limpias y llegaron 2 horas antes de lo acordado. ¡Salvaron mi boda de la lluvia!"</p>
                        <div class="d-flex align-items-center mt-4">
                            <img src="https://randomuser.me/api/portraits/women/44.jpg" class="rounded-circle me-3" width="50">
                            <div>
                                <h6 class="mb-0 fw-bold">Mariana López</h6>
                                <small class="text-white-50">Boda en Jardín</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4" data-aos="flip-up" data-aos-delay="200">
                <div class="card bg-secondary bg-opacity-25 border-0 h-100 text-white p-4">
                    <div class="card-body">
                        <div class="mb-3 text-warning">
                            <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                        </div>
                        <p class="fst-italic">"Excelente atención. El sistema de cotización en la web es súper rápido y fácil de usar. Muy recomendados para eventos corporativos."</p>
                        <div class="d-flex align-items-center mt-4">
                            <img src="https://randomuser.me/api/portraits/men/32.jpg" class="rounded-circle me-3" width="50">
                            <div>
                                <h6 class="mb-0 fw-bold">Ing. Carlos Ruíz</h6>
                                <small class="text-white-50">Evento Empresarial</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4" data-aos="flip-up" data-aos-delay="300">
                <div class="card bg-secondary bg-opacity-25 border-0 h-100 text-white p-4">
                    <div class="card-body">
                        <div class="mb-3 text-warning">
                            <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i>
                        </div>
                        <p class="fst-italic">"Tienen sillas y mesas muy bonitas, nada que ver con las de plástico de siempre. Le dieron mucha elegancia a la graduación."</p>
                        <div class="d-flex align-items-center mt-4">
                            <img src="https://randomuser.me/api/portraits/women/68.jpg" class="rounded-circle me-3" width="50">
                            <div>
                                <h6 class="mb-0 fw-bold">Fernanda G.</h6>
                                <small class="text-white-50">Graduación Escolar</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="confecciones-section">
        <div class="container confecciones-content" data-aos="zoom-in">
            <i class="bi bi-rulers fs-1 text-white mb-3"></i>
            <h2>Fabricación y Confección</h2>
            <p>
                No solo rentamos, también creamos. Diseñamos lonas, carpas industriales, 
                malla sombra y cubiertas a la medida exacta de tus necesidades. 
                Calidad industrial para tu negocio o jardín.
            </p>
            <div class="d-flex justify-content-center gap-3">
                <a href="confecciones.php" class="btn btn-gold shadow-lg">
                    <i class="bi bi-scissors me-2"></i> Ver Soluciones
                </a>
                <a href="https://wa.me/525512345678?text=Hola,%20me%20interesa%20una%20cotización%20de%20confección" class="btn btn-outline-gold">
                    Cotizar Proyecto
                </a>
            </div>
        </div>
    </section>
    <section class="py-5 bg-light">
        <div class="container py-4">
            <div class="row align-items-center">
                
                <div class="col-lg-6 mb-4" data-aos="fade-right">
                    <h5 class="text-warning text-uppercase fw-bold">Dudas Comunes</h5>
                    <h2 class="fw-bold mb-4">Preguntas Frecuentes</h2>
                    
                    <div class="accordion shadow-sm" id="accordionFAQ">
                        <div class="accordion-item border-0 mb-2 rounded">
                            <h2 class="accordion-header">
                                <button class="accordion-button fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                                    ¿Con cuánto tiempo debo reservar?
                                </button>
                            </h2>
                            <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#accordionFAQ">
                                <div class="accordion-body text-muted">
                                    Recomendamos reservar al menos con 2 semanas de anticipación, especialmente para fechas de temporada alta (Diciembre, Mayo).
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item border-0 mb-2 rounded">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                                    ¿Cuáles son las formas de pago?
                                </button>
                            </h2>
                            <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#accordionFAQ">
                                <div class="accordion-body text-muted">
                                    Aceptamos transferencia bancaria, y efectivo contra entrega. Requerimos un 50% de anticipo.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item border-0 rounded">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">
                                    ¿Cubren zonas fuera de Amecameca?
                                </button>
                            </h2>
                            <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#accordionFAQ">
                                <div class="accordion-body text-muted">
                                    Sí, cubrimos Chalco y zonas aledañas. Puede aplicar un costo extra de flete dependiendo la distancia.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                 <div class="col-lg-6 h-100" data-aos="fade-left">
                    <div class="card border-0 shadow overflow-hidden h-100" style="border-radius: 20px; min-height: 400px;">
                        <iframe 
                            width="100%" 
                            height="100%" 
                            style="border:0; min-height: 400px;" 
                            loading="lazy" 
                            allowfullscreen
                            referrerpolicy="no-referrer-when-downgrade"
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3768.163353597087!2d-98.7724278247941!3d19.131284082086396!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x85ce3c8d342344a7%3A0x6c5a374cc3492cd7!2sLONAS%20Y%20CARPAS%20MONTES!5e0!3m2!1ses-419!2smx!4v1704845000000!5m2!1ses-419!2smx">
                        </iframe>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="bg-dark text-white pt-5 pb-3">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h4 class="text-warning mb-3">Carpas Montes</h4>
                    <p class="text-white-50">Con mas de 25 años de Experiencia en Montajes. Transformamos espacios vacíos en escenarios de ensueño para bodas, graduaciones y eventos corporativos.</p>
                </div>
                <div class="col-md-4 mb-4">
                    <h5 class="mb-3">Contacto Rápido</h5>
                    <ul class="list-unstyled text-white-50">
                        <li class="mb-2"><i class="bi bi-geo-alt me-2"></i> C. 20 de Noviembre #14, Amecameca</li>
                        <li class="mb-2"><i class="bi bi-envelope me-2"></i> contacto@carpasmontes.com</li>
                        <li class="mb-2"><i class="bi bi-telephone me-2"></i> 55 1234 5678</li>
                    </ul>
                </div>
                <div class="col-md-4 mb-4 text-center">
                    <a href="prueba_api.php" class="btn btn-gold w-100 py-3">IR AL CATÁLOGO</a>
                </div>
            </div>
            <hr class="border-secondary">
            <div class="text-center text-secondary small">
                &copy; 2026 Carpas Montes Todos los Derechos Reservados. Desarrollado Por Arturo M.
            </div>
        </div>
    </footer>

    <a href="https://wa.me/525512345678" target="_blank" class="btn-whatsapp">
        <i class="bi bi-whatsapp"></i>
    </a>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        // Inicializar animaciones
        AOS.init({
            once: true, // Animación solo una vez al bajar
            offset: 100 // Empieza antes de llegar al elemento
        });

        // Navbar cambia de color al bajar
        window.addEventListener('scroll', function() {
            if (window.scrollY > 50) {
                document.querySelector('.navbar').classList.add('shadow');
            } else {
                document.querySelector('.navbar').classList.remove('shadow');
            }
        });
    </script>
</body>
</html>