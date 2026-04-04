<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dominio.Usuario" %>
<%
    // Verificar sesión - Protección básica
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - TechPOS Sistema de Reparaciones</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f6fa;
            color: #333;
            overflow-x: hidden;
        }

        /* ========== SIDEBAR ========== */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, #1a2a3a 0%, #0f1a24 100%);
            color: white;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            overflow-y: auto;
            transition: all 0.3s ease;
            z-index: 100;
        }

        .sidebar::-webkit-scrollbar {
            width: 5px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: #2c3e50;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: #3498db;
            border-radius: 5px;
        }

        .logo {
            padding: 25px 20px;
            text-align: center;
            border-bottom: 1px solid #2c3e50;
            margin-bottom: 20px;
        }

        .logo h2 {
            color: #3498db;
            font-size: 28px;
            margin-bottom: 5px;
        }

        .logo p {
            color: #95a5a6;
            font-size: 12px;
        }

        .menu {
            padding: 0 15px;
        }

        .menu ul {
            list-style: none;
        }

        .menu li {
            margin-bottom: 5px;
        }

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

        .menu a:hover {
            background: #2c3e50;
            color: #3498db;
            transform: translateX(5px);
        }

        .menu a.active {
            background: #3498db;
            color: white;
        }

        .menu .menu-section {
            font-size: 11px;
            text-transform: uppercase;
            color: #7f8c8d;
            padding: 15px 15px 8px 15px;
            letter-spacing: 1px;
        }

        /* ========== MAIN CONTENT ========== */
        .main-content {
            margin-left: 280px;
            min-height: 100vh;
        }

        /* Top Bar */
        .top-bar {
            background: white;
            padding: 15px 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 99;
        }

        .page-title {
            font-size: 20px;
            font-weight: 600;
            color: #2c3e50;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-name {
            display: flex;
            align-items: center;
            gap: 10px;
        }

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

        .role-badge {
            background: #e8f4fd;
            color: #3498db;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .logout-btn {
            color: #e74c3c;
            text-decoration: none;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* Content Wrapper */
        .content-wrapper {
            padding: 30px;
        }

        /* ========== KPI CARDS ========== */
        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

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

        .kpi-card .kpi-icon {
            font-size: 40px;
            margin-bottom: 15px;
        }

        .kpi-card h3 {
            color: #7f8d8d;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .kpi-card .kpi-value {
            font-size: 32px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        /* ========== TABLES ========== */
        .section-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .section-title h2 {
            font-size: 18px;
            color: #2c3e50;
        }

        .btn-sm {
            padding: 8px 15px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 13px;
            transition: background 0.3s;
        }

        .btn-sm:hover {
            background: #2980b9;
        }

        .data-table {
            width: 100%;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }

        .data-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th {
            background: #f8f9fa;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #2c3e50;
            border-bottom: 2px solid #ecf0f1;
        }

        .data-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #ecf0f1;
        }

        .data-table tr:hover {
            background: #f8f9fa;
        }

        .status-badge {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .status-pendiente {
            background: #fff3cd;
            color: #856404;
        }

        .btn-view {
            padding: 5px 12px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 12px;
        }

        .btn-view:hover {
            background: #2980b9;
        }

        /* ========== INFO BD ========== */
        .bd-info {
            margin-top: 40px;
            background: #1e2a36;
            border-radius: 15px;
            padding: 20px;
            color: #ecf0f1;
        }

        .bd-info h3 {
            color: #3498db;
            margin-bottom: 15px;
        }

        /* ========== RESPONSIVE ========== */
        @media (max-width: 768px) {
            .sidebar {
                width: 80px;
            }
            .sidebar .logo h2, .sidebar .logo p, .sidebar .menu span {
                display: none;
            }
            .sidebar .menu a {
                justify-content: center;
                padding: 12px;
            }
            .main-content {
                margin-left: 80px;
            }
            .kpi-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<!-- SIDEBAR -->
<div class="sidebar">
    <div class="logo">
        <h2>🔧 TechPOS</h2>
        <p>Sistema de Reparaciones</p>
    </div>
    <nav class="menu">
        <ul>
            <li><a href="index.jsp" class="active">📊 Dashboard</a></li>

            <li class="menu-section">📋 GESTIÓN PRINCIPAL</li>
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

<!-- MAIN CONTENT -->
<div class="main-content">
    <div class="top-bar">
        <div class="page-title">Dashboard Principal</div>
        <div class="user-info">
            <div class="user-name">
                <div class="avatar"><%= ((Usuario)session.getAttribute("usuario")).getNombre().charAt(0) %></div>
                <span><strong><%= session.getAttribute("nombreUsuario") %></strong></span>
            </div>
            <span class="role-badge"><%= session.getAttribute("rol") %></span>
            <a href="LogoutServlet" class="logout-btn">🚪 Salir</a>
        </div>
    </div>

    <div class="content-wrapper">
        <!-- KPI CARDS -->
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

        <!-- ÚLTIMAS REPARACIONES -->
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

        <!-- INFORMACIÓN DE BASE DE DATOS -->
        <div class="bd-info">
            <h3>✅ Conexión a Base de Datos: Activa</h3>
            <p><strong>Base de datos:</strong> techposv1</p>
            <p><strong>Usuario logueado:</strong> <%= session.getAttribute("nombreUsuario") %></p>
            <p><strong>Rol:</strong> <%= session.getAttribute("rol") %></p>
            <p><strong>Estado:</strong> Sesión activa ✅</p>
        </div>
    </div>
</div>
</body>
</html>