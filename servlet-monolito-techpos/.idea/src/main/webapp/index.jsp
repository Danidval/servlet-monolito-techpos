<%--
  index.jsp — Dashboard principal de TechPOS
  Esta página está protegida: solo usuarios con sesión activa pueden verla.
  Si no hay sesión, redirige automáticamente al login.
--%>

<%-- Directiva page: define lenguaje, codificación y tipo de contenido --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- Importa la clase Usuario del paquete dominio para poder usarla en los scriptlets --%>
<%@ page import="dominio.Usuario" %>

<%--
  PROTECCIÓN DE RUTA — Scriptlet de seguridad
  Se ejecuta ANTES de enviar cualquier HTML al navegador.
  Intenta obtener el objeto Usuario almacenado en la sesión por el LoginServlet.
  Si es null significa que no hay sesión activa (usuario no autenticado),
  por lo que se redirige al login y se detiene el procesamiento de la página con return.
--%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <%-- viewport garantiza que el layout responsive funcione en dispositivos móviles --%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - TechPOS Sistema de Reparaciones</title>
    <style>
        /* Reset básico para eliminar estilos por defecto del navegador */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Fondo gris claro para el área de contenido principal */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f6fa;
            color: #333;
            overflow-x: hidden; /* Evita scroll horizontal no deseado */
        }

        /* ========== SIDEBAR ========== */

        /* Panel lateral fijo de 280px que permanece visible al hacer scroll */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, #1a2a3a 0%, #0f1a24 100%);
            color: white;
            height: 100vh;      /* Ocupa toda la altura de la ventana */
            position: fixed;    /* No se mueve al hacer scroll */
            left: 0;
            top: 0;
            overflow-y: auto;   /* Scroll interno si el menú es muy largo */
            transition: all 0.3s ease;
            z-index: 100;       /* Por encima del contenido principal */
        }

        /* Personalización del scrollbar del sidebar para que sea discreto */
        .sidebar::-webkit-scrollbar { width: 5px; }
        .sidebar::-webkit-scrollbar-track { background: #2c3e50; }
        .sidebar::-webkit-scrollbar-thumb { background: #3498db; border-radius: 5px; }

        /* Sección del logo en la parte superior del sidebar */
        .logo {
            padding: 25px 20px;
            text-align: center;
            border-bottom: 1px solid #2c3e50;
            margin-bottom: 20px;
        }

        .logo h2 { color: #3498db; font-size: 28px; margin-bottom: 5px; }
        .logo p  { color: #95a5a6; font-size: 12px; }

        /* Menú de navegación lateral */
        .menu { padding: 0 15px; }
        .menu ul { list-style: none; }
        .menu li { margin-bottom: 5px; }

        /* Cada enlace del menú con ícono y texto alineados */
        .menu a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 15px;
            color: #ecf0f1;
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s ease;
            font-size: 14px;
        }

        /* Al pasar el cursor el enlace se desplaza levemente a la derecha */
        .menu a:hover {
            background: #2c3e50;
            color: #3498db;
            transform: translateX(5px);
        }

        /* Clase active para marcar la página actual en el menú */
        .menu a.active { background: #3498db; color: white; }

        /* Separadores de sección dentro del menú (ej: GESTIÓN PRINCIPAL) */
        .menu .menu-section {
            font-size: 11px;
            text-transform: uppercase;
            color: #7f8c8d;
            padding: 15px 15px 8px 15px;
            letter-spacing: 1px;
        }

        /* ========== CONTENIDO PRINCIPAL ========== */

        /* Desplaza el contenido hacia la derecha para no quedar debajo del sidebar */
        .main-content {
            margin-left: 280px;
            min-height: 100vh;
        }

        /* Barra superior fija con el título de página y la info del usuario */
        .top-bar {
            background: white;
            padding: 15px 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;  /* Se mantiene visible al hacer scroll */
            top: 0;
            z-index: 99;
        }

        .page-title { font-size: 20px; font-weight: 600; color: #2c3e50; }

        /* Sección derecha de la barra: avatar, nombre, rol y botón de salida */
        .user-info  { display: flex; align-items: center; gap: 20px; }
        .user-name  { display: flex; align-items: center; gap: 10px; }

        /* Avatar circular con la inicial del nombre del usuario */
        .user-name .avatar {
            width: 40px;
            height: 40px;
            background: #3498db;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        /* Etiqueta de rol con fondo azul claro */
        .role-badge {
            background: #e8f4fd;
            color: #3498db;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        /* Enlace de cierre de sesión que apunta al LogoutServlet */
        .logout-btn {
            color: #e74c3c;
            text-decoration: none;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* Padding general del área de contenido */
        .content-wrapper { padding: 30px; }

        /* ========== TARJETAS KPI ========== */

        /* Grid responsivo: columnas de mínimo 250px que se ajustan al ancho disponible */
        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        /* Cada tarjeta sube al pasar el cursor para dar efecto de profundidad */
        .kpi-card {
            background: white;
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }

        .kpi-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .kpi-card .kpi-icon  { font-size: 40px; margin-bottom: 15px; }
        .kpi-card h3         { color: #7f8d8d; font-size: 14px; font-weight: 500; margin-bottom: 10px; }
        .kpi-card .kpi-value { font-size: 32px; font-weight: bold; color: #2c3e50; margin-bottom: 15px; }

        /* ========== TABLA DE REPARACIONES ========== */

        .section-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .section-title h2 { font-size: 18px; color: #2c3e50; }

        .btn-sm {
            padding: 8px 15px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 13px;
            transition: background 0.3s;
        }

        .btn-sm:hover { background: #2980b9; }

        /* Contenedor de la tabla con esquinas redondeadas y sombra suave */
        .data-table {
            width: 100%;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }

        .data-table table   { width: 100%; border-collapse: collapse; }
        .data-table th      { background: #f8f9fa; padding: 15px; text-align: left; font-weight: 600; color: #2c3e50; border-bottom: 2px solid #ecf0f1; }
        .data-table td      { padding: 12px 15px; border-bottom: 1px solid #ecf0f1; }
        .data-table tr:hover { background: #f8f9fa; }

        /* Etiqueta de estado con fondo de color según el estado de la reparación */
        .status-badge      { padding: 4px 10px; border-radius: 20px; font-size: 12px; font-weight: 600; display: inline-block; }
        .status-pendiente  { background: #fff3cd; color: #856404; }

        .btn-view       { padding: 5px 12px; background: #3498db; color: white; text-decoration: none; border-radius: 5px; font-size: 12px; }
        .btn-view:hover { background: #2980b9; }

        /* ========== PANEL DE INFO DE BASE DE DATOS ========== */

        /* Sección oscura al final que muestra el estado de la conexión y la sesión */
        .bd-info          { margin-top: 40px; background: #1e2a36; border-radius: 15px; padding: 20px; color: #ecf0f1; }
        .bd-info h3       { color: #3498db; margin-bottom: 15px; }

        /* ========== RESPONSIVE — pantallas menores a 768px ========== */
        @media (max-width: 768px) {
            /* El sidebar se colapsa a solo 80px mostrando únicamente íconos */
            .sidebar { width: 80px; }
            .sidebar .logo h2, .sidebar .logo p, .sidebar .menu span { display: none; }
            .sidebar .menu a { justify-content: center; padding: 12px; }
            /* El contenido principal se ajusta al nuevo ancho del sidebar */
            .main-content { margin-left: 80px; }
            .kpi-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<%-- ========== SIDEBAR ========== --%>
<div class="sidebar">
    <div class="logo">
        <h2>🔧 TechPOS</h2>
        <p>Sistema de Reparaciones</p>
    </div>
    <nav class="menu">
        <ul>
            <%-- Enlace activo: resalta el dashboard como página actual --%>
            <li><a href="index.jsp" class="active">📊 Dashboard</a></li>

            <li class="menu-section">📋 GESTIÓN PRINCIPAL</li>
            <%-- Los enlaces con href="#" son placeholders para futuras funcionalidades --%>
            <li><a href="#">🔧 Reparaciones</a></li>
            <li><a href="#">💰 Presupuestos</a></li>
            <li><a href="#">👥 Clientes</a></li>
            <li><a href="#">📱 Dispositivos</a></li>
            <li><a href="#">📄 Facturas</a></li>
            <li><a href="#">💵 Pagos</a></li>

            <li class="menu-section">📦 INVENTARIO & PROVEEDORES</li>
            <li><a href="#">📦 Inventario</a></li>
            <li><a href="#">🏢 Proveedores</a></li>

            <li class="menu-section">📈 ADMINISTRACIÓN</li>
            <li><a href="#">📊 Reportes</a></li>
            <li><a href="#">👤 Usuarios</a></li>
            <li><a href="#">⚙️ Configuración</a></li>
        </ul>
    </nav>
</div>

<%-- ========== CONTENIDO PRINCIPAL ========== --%>
<div class="main-content">

    <%-- Barra superior con título y datos del usuario autenticado --%>
    <div class="top-bar">
        <div class="page-title">Dashboard Principal</div>
        <div class="user-info">
            <div class="user-name">
                <%--
                  Expresión JSP: obtiene el objeto Usuario de la sesión,
                  llama getNombre() y toma solo el primer carácter (charAt(0))
                  para mostrarlo como inicial en el avatar circular.
                --%>
                <div class="avatar">
                    <%= ((Usuario) session.getAttribute("usuario")).getNombre().charAt(0) %>
                </div>
                <%-- Muestra el nombre completo del usuario guardado en la sesión --%>
                <span><strong><%= session.getAttribute("nombreUsuario") %></strong></span>
            </div>
            <%-- Muestra el rol del usuario (administrador, recepcionista, etc.) --%>
            <span class="role-badge"><%= session.getAttribute("rol") %></span>

            <%--
              Enlace de cierre de sesión: apunta al LogoutServlet mediante GET.
              El servlet invalida la sesión y redirige de vuelta a login.jsp.
            --%>
            <a href="LogoutServlet" class="logout-btn">🚪 Salir</a>
        </div>
    </div>

    <div class="content-wrapper">

        <%-- ========== TARJETAS KPI ==========
             Muestran métricas clave del negocio. Los valores son estáticos por ahora;
             en una versión completa se calcularían desde la base de datos. --%>
        <div class="kpi-grid">
            <div class="kpi-card">
                <div class="kpi-icon">🔧</div>
                <h3>REPARACIONES ACTIVAS</h3>
                <div class="kpi-value">12</div>
            </div>
            <div class="kpi-card">
                <div class="kpi-icon">⚠️</div>
                <h3>ALERTA STOCK BAJO</h3>
                <div class="kpi-value">3</div>
            </div>
            <div class="kpi-card">
                <div class="kpi-icon">📅</div>
                <h3>GARANTÍAS POR EXPIRAR</h3>
                <div class="kpi-value">5</div>
            </div>
            <div class="kpi-card">
                <div class="kpi-icon">📱</div>
                <h3>DISPOSITIVOS REGISTRADOS</h3>
                <div class="kpi-value">47</div>
            </div>
        </div>

        <%-- ========== TABLA DE ÚLTIMAS REPARACIONES ==========
             Datos de ejemplo estáticos. En producción se consultarían
             desde la BD con un PreparedStatement en un servlet o DAO. --%>
        <div class="section-title">
            <h2>📋 Últimas Reparaciones Abiertas</h2>
            <a href="#" class="btn-sm">Ver todas →</a>
        </div>

        <div class="data-table">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Cliente</th>
                    <th>Dispositivo</th>
                    <th>Estado</th>
                    <th>Fecha Inicio</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>#REP-001</td>
                    <td>Juan Pérez</td>
                    <td>Laptop Dell Inspiron</td>
                    <%-- status-pendiente aplica fondo amarillo a la etiqueta de estado --%>
                    <td><span class="status-badge status-pendiente">Pendiente</span></td>
                    <td>20/03/2026</td>
                    <td><a href="#" class="btn-view">Ver</a></td>
                </tr>
                <tr>
                    <td>#REP-002</td>
                    <td>María García</td>
                    <td>Smartphone Samsung S21</td>
                    <td><span class="status-badge status-pendiente">Pendiente</span></td>
                    <td>19/03/2026</td>
                    <td><a href="#" class="btn-view">Ver</a></td>
                </tr>
                <tr>
                    <td>#REP-003</td>
                    <td>Carlos López</td>
                    <td>Tablet iPad Air</td>
                    <td><span class="status-badge status-pendiente">Pendiente</span></td>
                    <td>18/03/2026</td>
                    <td><a href="#" class="btn-view">Ver</a></td>
                </tr>
                </tbody>
            </table>
        </div>

        <%-- ========== PANEL DE ESTADO DE SESIÓN ==========
             Muestra información de la sesión activa usando expresiones JSP.
             Útil para verificar que los atributos de sesión se guardaron correctamente. --%>
        <div class="bd-info">
            <h3>✅ Conexión a Base de Datos: Activa</h3>
            <p><strong>Base de datos:</strong> techposv1</p>
            <%-- Expresiones JSP que leen directamente los atributos almacenados en sesión --%>
            <p><strong>Usuario logueado:</strong> <%= session.getAttribute("nombreUsuario") %></p>
            <p><strong>Rol:</strong> <%= session.getAttribute("rol") %></p>
            <p><strong>Estado:</strong> Sesión activa ✅</p>
        </div>

    </div>
</div>
</body>
</html>