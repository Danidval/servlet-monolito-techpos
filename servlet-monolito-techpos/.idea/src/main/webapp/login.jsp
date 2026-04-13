<%--
  login.jsp — Página de inicio de sesión de TechPOS
  Muestra el formulario de login y, si el LoginServlet detectó
  credenciales incorrectas, muestra el mensaje de error correspondiente.
--%>

<%-- Directiva page: define el lenguaje, el tipo de contenido y la codificación
     UTF-8 permite mostrar caracteres especiales como tildes y ñ correctamente --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <%-- viewport hace que el diseño sea responsive en dispositivos móviles --%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechPOS - Sistema de Reparaciones Técnicas</title>
    <style>
        /* Reset básico: elimina márgenes y paddings por defecto del navegador
           box-sizing: border-box incluye padding y border dentro del ancho total */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Centra el formulario vertical y horizontalmente en toda la pantalla
           El degradado morado-violeta sirve como fondo de la página */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        /* Contenedor principal del formulario con ancho máximo y esquinas redondeadas
           La animación fadeIn lo hace aparecer suavemente al cargar la página */
        .login-container {
            max-width: 450px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeIn 0.5s ease-out;
        }

        /* Animación de entrada: el formulario sube desde abajo con opacidad creciente */
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

        /* Encabezado azul oscuro con el nombre del sistema */
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

        /* Área del formulario con padding generoso para legibilidad */
        .login-body {
            padding: 40px 30px;
        }

        /* Agrupa cada label con su input para mantener el espaciado uniforme */
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

        /* Inputs con borde suave; al hacer foco cambian a azul para indicar actividad */
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

        /* Botón de envío que ocupa todo el ancho del formulario
           Al pasar el cursor sube ligeramente (hover) para dar sensación de profundidad */
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

        /* Estilo base para alertas; se extiende con clases modificadoras como alert-danger */
        .alert {
            padding: 12px 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Alerta roja para credenciales incorrectas, con borde izquierdo como acento */
        .alert-danger {
            background: #fee2e2;
            color: #c0392b;
            border-left: 4px solid #c0392b;
        }

        /* Sección inferior con las credenciales de prueba para facilitar las demos */
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

        /* Grid de dos columnas para mostrar las credenciales lado a lado */
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

        /* En pantallas menores a 480px el grid pasa a una sola columna
           y el padding se reduce para aprovechar mejor el espacio */
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

    <%-- Encabezado visual con el nombre e ícono del sistema --%>
    <div class="login-header">
        <div class="logo-icon">🔧</div>
        <h1>TechPOS</h1>
        <p>Sistema de Gestión de Reparaciones Técnicas</p>
    </div>

    <div class="login-body">

        <%-- Bloque JSP: scriptlet que evalúa si el LoginServlet dejó un mensaje de error.
             request.getAttribute("error") devuelve el valor solo si el servlet lo asignó
             con request.setAttribute("error", "...") antes de hacer el forward a esta página.
             Si es null significa que el usuario llegó directamente, sin intento fallido. --%>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            <%-- Expresión JSP: imprime el valor del atributo "error" directamente en el HTML --%>
            ❌ <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <%-- Formulario que envía las credenciales al LoginServlet mediante POST.
             POST oculta los datos en el cuerpo de la petición (no en la URL),
             lo que es más seguro para enviar contraseñas que GET. --%>
        <form action="LoginServlet" method="POST">

            <%-- Campo de texto para el nombre de usuario.
                 name="usuario" debe coincidir con request.getParameter("usuario") en el servlet.
                 autofocus coloca el cursor aquí automáticamente al cargar la página. --%>
            <div class="form-group">
                <label for="usuario">Usuario</label>
                <input type="text" id="usuario" name="usuario"
                       placeholder="Ingrese su usuario" required autofocus>
            </div>

            <%-- Campo de contraseña: type="password" enmascara los caracteres al escribir.
                 name="contrasena" debe coincidir con request.getParameter("contrasena") en el servlet.
                 required impide enviar el formulario si el campo está vacío. --%>
            <div class="form-group">
                <label for="contrasena">Contraseña</label>
                <input type="password" id="contrasena" name="contrasena"
                       placeholder="Ingrese su contraseña" required>
            </div>

            <%-- Botón de envío: dispara el POST al LoginServlet con los datos del formulario --%>
            <button type="submit" class="btn-login">🔐 Iniciar Sesión</button>
        </form>

        <%-- Sección de credenciales de prueba — solo para entorno de desarrollo/demostración.
             Debe eliminarse antes de un despliegue en producción. --%>
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