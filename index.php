<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carpas Montes | Inicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        /* Estilos personalizados para la Portada */
        .hero-section {
            /* Fondo con imagen de evento (puedes cambiar la URL por una foto tuya local) */
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1519167758481-83f550bb49b3?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            height: 100vh; /* Pantalla completa */
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
        }
        
        .feature-icon {
            font-size: 3rem;
            color: #0d6efd; /* Azul Bootstrap */
            margin-bottom: 1rem;
        }

        .navbar-brand { font-weight: bold; letter-spacing: 1px; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top shadow">
        <div class="container">
            <a class="navbar-brand" href="#">🎪 Carpas Montes</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="index.php">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="#servicios">Servicios</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contacto">Contacto</a></li>
                    <li class="nav-item ms-lg-3">
                        <a class="btn btn-primary rounded-pill px-4" href="prueba_api.php">Ver Catálogo</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="hero-section">
        <div class="container animate__animated animate__fadeIn">
            <h1 class="display-1 fw-bold mb-3">Haz de tu evento algo inolvidable</h1>
            <p class="lead mb-4 fs-3">Renta de carpas, sillas, mesas y todo lo que necesitas para tu fiesta.</p>
            <div class="d-flex gap-3 justify-content-center">
                <a href="prueba_api.php" class="btn btn-primary btn-lg px-5 py-3 rounded-pill fw-bold">
                    <i class="bi bi-cart4"></i> Cotizar Ahora
                </a>
                <a href="#contacto" class="btn btn-outline-light btn-lg px-5 py-3 rounded-pill">
                    Contáctanos
                </a>
            </div>
        </div>
    </header>

    <section id="servicios" class="py-5 bg-light">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h2 class="fw-bold">¿Por qué elegirnos?</h2>
                <p class="text-muted">Calidad y compromiso en cada montaje</p>
            </div>
            <div class="row text-center">
                <div class="col-md-4 mb-4">
                    <div class="p-4 bg-white shadow-sm rounded h-100">
                        <i class="bi bi-star-fill feature-icon"></i>
                        <h4>Calidad Premium</h4>
                        <p class="text-muted">Mobiliario en excelentes condiciones, limpio y listo para usarse.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="p-4 bg-white shadow-sm rounded h-100">
                        <i class="bi bi-clock-fill feature-icon"></i>
                        <h4>Puntualidad</h4>
                        <p class="text-muted">Entregas a tiempo para que tu evento comience sin preocupaciones.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="p-4 bg-white shadow-sm rounded h-100">
                        <i class="bi bi-truck feature-icon"></i>
                        <h4>Cobertura Total</h4>
                        <p class="text-muted">Llegamos a donde sea tu evento. Montaje y desmontaje incluido.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer id="contacto" class="bg-dark text-white py-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-3">
                    <h5>Carpas Montes</h5>
                    <p class="small text-secondary">Expertos en logística de eventos desde hace más de 10 años.</p>
                </div>
                <div class="col-md-4 mb-3">
                    <h5>Contacto</h5>
                    <ul class="list-unstyled text-secondary">
                        <li><i class="bi bi-geo-alt"></i> Calle Falsa 123, Ciudad</li>
                        <li><i class="bi bi-telephone"></i> +52 55 1234 5678</li>
                        <li><i class="bi bi-envelope"></i> contacto@carpasmontes.com</li>
                    </ul>
                </div>
                <div class="col-md-4 mb-3 text-md-end">
                    <a href="prueba_api.php" class="btn btn-outline-light">Ir al Catálogo</a>
                </div>
            </div>
            <hr class="border-secondary">
            <div class="text-center small text-secondary">
                &copy; 2026 Carpas Montes. Todos los derechos reservados.
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>