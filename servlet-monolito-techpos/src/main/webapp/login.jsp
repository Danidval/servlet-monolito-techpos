<%--
  Created by IntelliJ IDEA.
  User: neo
  Date: 04-abr-26
  Time: 11:52 a.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechPOS - Sistema de Reparaciones Técnicas</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            max-width: 450px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-header {
            background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
            padding: 40px 30px;
            text-align: center;
            color: white;
        }

        .login-header h1 {
            font-size: 32px;
            margin-bottom: 8px;
            letter-spacing: 1px;
        }

        .login-header p {
            font-size: 14px;
            opacity: 0.9;
        }

        .login-body {
            padding: 40px 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .form-group input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .alert {
            padding: 12px 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-danger {
            background: #fee2e2;
            color: #c0392b;
            border-left: 4px solid #c0392b;
        }

        .credentials-box {
            margin-top: 30px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 12px;
            border: 1px solid #e0e0e0;
        }

        .credentials-box h4 {
            color: #2c3e50;
            margin-bottom: 12px;
            font-size: 14px;
            text-align: center;
        }

        .credentials-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            font-size: 12px;
        }

        .credential-item {
            background: white;
            padding: 8px 12px;
            border-radius: 8px;
            text-align: center;
            border: 1px solid #e0e0e0;
        }

        .credential-item strong {
            color: #3498db;
            display: block;
            margin-bottom: 4px;
        }

        .logo-icon {
            font-size: 48px;
            margin-bottom: 10px;
        }

        @media (max-width: 480px) {
            .login-header {
                padding: 30px 20px;
            }
            .login-body {
                padding: 30px 20px;
            }
            .credentials-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-header">
        <div class="logo-icon">🔧</div>
        <h1>TechPOS</h1>
        <p>Sistema de Gestión de Reparaciones Técnicas</p>
    </div>

    <div class="login-body">
        <!-- Mostrar mensaje de error si existe -->
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            ❌ <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="LoginServlet" method="POST">
            <div class="form-group">
                <label for="usuario">Usuario</label>
                <input type="text" id="usuario" name="usuario" placeholder="Ingrese su usuario" required autofocus>
            </div>

            <div class="form-group">
                <label for="contrasena">Contraseña</label>
                <input type="password" id="contrasena" name="contrasena" placeholder="Ingrese su contraseña" required>
            </div>

            <button type="submit" class="btn-login">🔐 Iniciar Sesión</button>
        </form>

        <!-- Credenciales de prueba -->
        <div class="credentials-box">
            <h4>📋 Credenciales de prueba</h4>
            <div class="credentials-grid">
                <div class="credential-item">
                    <strong>👑 Administrador</strong>
                    admin / 123
                </div>
                <div class="credential-item">
                    <strong>📞 Recepcionista</strong>
                    laura / 123
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>