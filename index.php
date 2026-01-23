<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Carpas Montes | Eventos Exclusivos</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Lato:wght@300;400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos.css">

    <style>
        /* En pantallas pequeñas, reducimos el tamaño de las fuentes gigantes */
        @media (max-width: 768px) {
            .display-1 { font-size: 2.5rem !important; }
            .display-4 { font-size: 2rem !important; }
            .display-5 { font-size: 1.8rem !important; }
            .lead { font-size: 1rem !important; }
            /* Separación entre botones en el hero */
            .hero-section .d-flex { gap: 10px !important; flex-direction: column; width: 100%; }
            .hero-section .btn { width: 100%; }
        }
        /* Evitar desbordamiento horizontal */
        body { overflow-x: hidden; }
        img { max-width: 100%; height: auto; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand" href="index.php">
                <div class="d-flex align-items-center">
                    <img src="/img/logo.png" width="50" height="50" alt="Logo">
                    <span class="fw-bold fs-3" style="color: var(--montes-cyan, #00b4db);">CARPAS</span>
                    <span class="fw-bold fs-3 ms-1" style="color: var(--montes-dark, #0e4c81);">MONTES</span>
                </div>
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center gap-2 bg-white bg-lg-transparent p-3 p-lg-0 rounded mt-2 mt-lg-0 shadow-sm shadow-lg-none">
                    <li class="nav-item w-100 text-center text-lg-start"><a class="nav-link active" href="index.php">Inicio</a></li>
                    <li class="nav-item w-100 text-center text-lg-start"><a class="nav-link" href="#servicios">Experiencia</a></li>
                    <li class="nav-item w-100 text-center text-lg-start"><a class="nav-link" href="galeria.php">Galería</a></li>
                    <li class="nav-item w-100 text-center text-lg-start"><a class="nav-link" href="confecciones.php">Confección</a></li>
                    <li class="nav-item ms-lg-2 w-100">
                        <a class="btn btn-gold shadow-sm w-100" href="prueba_api.php">Ver Catálogo</a>
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
                <a href="prueba_api.php" class="btn btn-gold btn-lg shadow-lg rounded-pill px-5">
                    <i class="bi bi-calendar-check me-2"></i> Cotizar Mi Evento
                </a>
                <a href="https://wa.me/5517062971" target="_blank" class="btn btn-outline-light btn-lg px-5 rounded-pill fw-bold">
                    <i class="bi bi-whatsapp me-2"></i> Contactar
                </a>
            </div>
        </div>
    </header>

    <section class="py-5 text-white" style="background-color: var(--navy-dark, #000000);">
        <div class="container">
            <div class="row text-center g-4">
                <div class="col-12 col-md-4" data-aos="fade-up" data-aos-delay="100">
                    <h2 class="display-4 fw-bold" style="color: var(--gold);">30+</h2>
                    <p class="text-uppercase ls-2">Años de Experiencia</p>
                </div>
                <div class="col-12 col-md-4" data-aos="fade-up" data-aos-delay="200">
                    <h2 class="display-4 fw-bold" style="color: var(--gold);">5000+</h2>
                    <p class="text-uppercase ls-2">Eventos Exitosos</p>
                </div>
                <div class="col-12 col-md-4" data-aos="fade-up" data-aos-delay="300">
                    <h2 class="display-4 fw-bold" style="color: var(--gold);">100%</h2>
                    <p class="text-uppercase ls-2">Clientes Satisfechos</p>
                </div>
            </div>
        </div>
    </section>

    <section id="servicios" class="py-5 bg-light">
        <div class="container py-5">
            <div class="text-center mb-5" data-aos="fade-down">
                <h5 class="text-warning text-uppercase fw-bold">¿Por qué elegirnos?</h5>
                <h2 class="fw-bold display-5" style="color: var(--navy-dark);">Excelencia en cada detalle</h2>
                <div style="width: 60px; height: 3px; background: var(--gold); margin: 15px auto;"></div>
            </div>
            
            <div class="row g-4">
                <div class="col-12 col-md-4" data-aos="flip-left">
                    <div class="service-card shadow-sm text-center bg-white h-100 p-4 rounded-4">
                        <div class="fs-1 text-warning mb-3"><i class="bi bi-gem"></i></div>
                        <h4 class="mb-3 fw-bold">Calidad Premium</h4>
                        <p class="text-muted">Mobiliario de alta gama, limpio y en perfectas condiciones estéticas para tu celebración.</p>
                    </div>
                </div>
                <div class="col-12 col-md-4" data-aos="flip-left" data-aos-delay="200">
                    <div class="service-card shadow-sm text-center bg-white h-100 p-4 rounded-4">
                        <div class="fs-1 text-warning mb-3"><i class="bi bi-alarm"></i></div>
                        <h4 class="mb-3 fw-bold">Puntualidad Absoluta</h4>
                        <p class="text-muted">Entendemos la importancia del tiempo. Tu montaje estará listo mucho antes de que llegue el primer invitado.</p>
                    </div>
                </div>
                <div class="col-12 col-md-4" data-aos="flip-left" data-aos-delay="400">
                    <div class="service-card shadow-sm text-center bg-white h-100 p-4 rounded-4">
                        <div class="fs-1 text-warning mb-3"><i class="bi bi-truck"></i></div>
                        <h4 class="mb-3 fw-bold">Logística Integral</h4>
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
                <h2 class="display-5 fw-bold" style="color: var(--navy-dark);">Tu evento en 4 pasos</h2>
            </div>
            
            <div class="row text-center g-4">
                <div class="col-6 col-md-3" data-aos="fade-right" data-aos-delay="100">
                    <div class="position-relative p-2 p-md-4">
                        <div class="display-4 text-warning mb-3"><i class="bi bi-laptop"></i></div>
                        <h4 class="fw-bold h5">1. Cotiza</h4>
                        <p class="text-muted small">Explora nuestro catálogo en línea.</p>
                    </div>
                </div>
                <div class="col-6 col-md-3" data-aos="fade-right" data-aos-delay="200">
                    <div class="position-relative p-2 p-md-4">
                        <div class="display-4 text-warning mb-3"><i class="bi bi-file-earmark-text"></i></div>
                        <h4 class="fw-bold h5">2. Confirma</h4>
                        <p class="text-muted small">Llena tus datos. Recibirás un correo con tu folio.</p>
                    </div>
                </div>
                <div class="col-6 col-md-3" data-aos="fade-right" data-aos-delay="300">
                    <div class="position-relative p-2 p-md-4">
                        <div class="display-4 text-warning mb-3"><i class="bi bi-calendar-check"></i></div>
                        <h4 class="fw-bold h5">3. Recibe</h4>
                        <p class="text-muted small">Entrega y montaje puntual.</p>
                    </div>
                </div>
                <div class="col-6 col-md-3" data-aos="fade-right" data-aos-delay="400">
                    <div class="position-relative p-2 p-md-4">
                        <div class="display-4 text-warning mb-3"><i class="bi bi-emoji-laughing"></i></div>
                        <h4 class="fw-bold h5">4. Disfruta</h4>
                        <p class="text-muted small">Celebra sin preocupaciones.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 text-white position-relative" style="background-color: #1a1a1a;">
        <div style="position: absolute; top:0; left:0; width:100%; height:100%; background: url('https://www.transparenttextures.com/patterns/cubes.png'); opacity: 0.05;"></div>

        <div class="container position-relative z-1 py-4">
            <div class="text-center mb-5" data-aos="zoom-in">
                <h5 class="text-warning text-uppercase fw-bold">Nuestros Clientes</h5>
                <h2 class="display-5 fw-bold">Lo que dicen de nosotros</h2>
            </div>

            <div class="row g-4">
                <div class="col-12 col-md-4" data-aos="flip-up" data-aos-delay="100">
                    <div class="card bg-secondary bg-opacity-25 border-0 h-100 text-white p-4 rounded-4">
                        <div class="card-body">
                            <div class="mb-3 text-warning small">
                                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                            </div>
                            <p class="fst-italic">"El servicio fue impecable. Las carpas estaban limpias y llegaron 2 horas antes de lo acordado. ¡Salvaron mi boda de la lluvia!"</p>
                            <div class="d-flex align-items-center mt-4">
                                <div class="bg-light rounded-circle d-flex align-items-center justify-content-center text-dark fw-bold me-3" style="width:50px; height:50px;">ML</div>
                                <div>
                                    <h6 class="mb-0 fw-bold">Mariana López</h6>
                                    <small class="text-white-50">Boda en Jardín</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-4" data-aos="flip-up" data-aos-delay="200">
                    <div class="card bg-secondary bg-opacity-25 border-0 h-100 text-white p-4 rounded-4">
                        <div class="card-body">
                            <div class="mb-3 text-warning small">
                                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                            </div>
                            <p class="fst-italic">"Excelente atención. El sistema de cotización en la web es súper rápido y fácil de usar. Muy recomendados para eventos corporativos."</p>
                            <div class="d-flex align-items-center mt-4">
                                <div class="bg-light rounded-circle d-flex align-items-center justify-content-center text-dark fw-bold me-3" style="width:50px; height:50px;">CR</div>
                                <div>
                                    <h6 class="mb-0 fw-bold">Ing. Carlos Ruíz</h6>
                                    <small class="text-white-50">Evento Empresarial</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-4" data-aos="flip-up" data-aos-delay="300">
                    <div class="card bg-secondary bg-opacity-25 border-0 h-100 text-white p-4 rounded-4">
                        <div class="card-body">
                            <div class="mb-3 text-warning small">
                                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i>
                            </div>
                            <p class="fst-italic">"Tienen sillas y mesas muy bonitas, nada que ver con las de plástico de siempre. Le dieron mucha elegancia a la graduación."</p>
                            <div class="d-flex align-items-center mt-4">
                                <div class="bg-light rounded-circle d-flex align-items-center justify-content-center text-dark fw-bold me-3" style="width:50px; height:50px;">FG</div>
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
            </p>
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="confecciones.php" class="btn btn-gold shadow-lg rounded-pill px-4 mb-2 mb-md-0">
                    <i class="bi bi-scissors me-2"></i> Ver Soluciones
                </a>
                <a href="https://wa.me/525500000000?text=Hola,%20me%20interesa%20una%20cotización%20de%20confección" class="btn btn-outline-light rounded-pill px-4">
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
                    <h2 class="fw-bold mb-4" style="color: var(--navy-dark);">Preguntas Frecuentes</h2>
                    
                    <div class="accordion shadow-sm" id="accordionFAQ">
                        <div class="accordion-item border-0 mb-2 rounded">
                            <h2 class="accordion-header">
                                <button class="accordion-button fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                                    ¿Con cuánto tiempo debo reservar?
                                </button>
                            </h2>
                            <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#accordionFAQ">
                                <div class="accordion-body text-muted">
                                    Recomendamos reservar al menos con 2 semanas de anticipación, especialmente para fechas de temporada alta.
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
                                    Se da un anticipo al confirmar y efectivo contra entrega. El anticipo lo asigna el vendedor cuando se le confirma el pedido para agendar fecha.
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
                                    Sí, cubrimos los alrrededoes de Amecameca, zona Volcanes, Talamanalco,  Morelos, Ixtapaluca, Chalco. estos ultimos solo en pedidos grandes y puede aplicar un costo extra de flete dependiendo la distancia.
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
            src="https://maps.google.com/maps?q=C.+20+de+Noviembre+14,+56903+Amecameca+de+Juárez,+Méx.&t=&z=17&ie=UTF8&iwloc=&output=embed">
        </iframe>
    </div>
</div>
            </div>
        </div>
    </section>

    <footer class="bg-dark text-white pt-5 pb-3">
        <div class="container">
            <div class="row">
                <div class="col-12 col-md-4 mb-4 text-center text-md-start">
                    <h4 class="text-warning mb-3 fw-bold" style="font-family: 'Playfair Display', serif;">Lonas y Carpas Montes</h4>
                    <p class="text-white-50 small">
                        Con más de 30 años de experiencia. Transformamos espacios vacíos en escenarios de ensueño para bodas, graduaciones y eventos corporativos.
                    </p>
                </div>
                <div class="col-12 col-md-4 mb-4 text-center text-md-start">
                    <h5 class="mb-3 fw-bold">Contacto Rápido</h5>
                    <ul class="list-unstyled text-white-50 small">
                        <li class="mb-2"><i class="bi bi-geo-alt me-2"></i> Av. 20 de Noviembre #14, Amecameca</li>
                        <li class="mb-2"><i class="bi bi-envelope me-2"></i> carpasameca.1996@gmail.com</li>
                        <li class="mb-2"><i class="bi bi-telephone me-2"></i> 597-978-0293</li>
                        <!--li class="mb-2"><i class="bi bi-telephone me-2"></i> 55-1706-2971</li>
                        <li class="mb-2"><i class="bi bi-telephone me-2"></i> 55-4069-4603</li-->
                    </ul>
                </div>
                <div class="col-12 col-md-4 mb-4 text-center">
                    <a href="prueba_api.php" class="btn btn-gold w-100 py-3 rounded-pill fw-bold">IR AL CATÁLOGO</a>
                    <br><br><br>
                    <h5>Desarrollado por Arturo</h5>
                </div>
            </div>
            <hr class="border-secondary">
            <div class="text-center text-secondary small">
                © 2026 Carpas Montes. Todos los Derechos Reservados.
            </div>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ once: true, offset: 80, duration: 800 });
        window.addEventListener('scroll', function() {
            if (window.scrollY > 50) {
                document.querySelector('.navbar').classList.add('shadow-sm');
            } else {
                document.querySelector('.navbar').classList.remove('shadow-sm');
            }
        });
    </script>
</body>
</html>