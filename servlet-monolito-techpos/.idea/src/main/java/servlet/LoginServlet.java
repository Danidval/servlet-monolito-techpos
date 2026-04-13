package servlet;

import dominio.Usuario;
import datos.Conexion;
import java.sql.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Mapea este servlet a la URL /LoginServlet
// Tomcat lo ejecuta cuando el formulario de login envía sus datos
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    // Identificador de versión requerido por la interfaz Serializable
    private static final long serialVersionUID = 1L;

    /**
     * Maneja las solicitudes POST al servlet.
     * Se activa cuando el usuario envía el formulario de login
     * con method="POST" desde login.jsp.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Leer los datos enviados desde el formulario HTML
        //    request.getParameter() obtiene el valor de cada campo por su atributo name
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        // 2. Validar que los campos no lleguen vacíos o nulos
        //    trim() elimina espacios en blanco al inicio y al final
        if (usuario == null || usuario.trim().isEmpty() ||
                contrasena == null || contrasena.trim().isEmpty()) {

            // Si están vacíos, se agrega un mensaje de error como atributo
            // y se reenvía al mismo login.jsp sin hacer redirect
            request.setAttribute("error", "Por favor ingrese usuario y contrasena");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return; // Detiene la ejecución del método aquí
        }

        // 3. Consultar la base de datos con las credenciales recibidas
        //    trim() asegura que no se envíen espacios accidentales
        Usuario user = validarLogin(usuario.trim(), contrasena.trim());

        if (user != null) {
            // 4. Credenciales correctas — se crea la sesión del usuario

            // getSession() crea una nueva sesión HTTP si no existe,
            // o devuelve la sesión activa si ya hay una
            HttpSession session = request.getSession();

            // Se almacenan los datos del usuario en la sesión
            // para que estén disponibles en todas las páginas protegidas
            session.setAttribute("usuario", user);           // Objeto Usuario completo
            session.setAttribute("idUsuario", user.getIdUsuario());     // ID numérico
            session.setAttribute("nombreUsuario", user.getNombre());    // Nombre completo
            session.setAttribute("usuarioLogin", user.getUsuario());    // Username
            session.setAttribute("rol", user.getRol());                 // Rol (administrador, recepcionista, etc.)

            // Define que la sesión expira tras 30 minutos de inactividad
            session.setMaxInactiveInterval(30 * 60);

            // 5. Redirige al dashboard principal tras el login exitoso
            //    sendRedirect hace que el navegador haga una nueva petición GET a index.jsp
            response.sendRedirect("index.jsp");

        } else {
            // 6. Credenciales incorrectas — se informa al usuario
            //    Se reenvía a login.jsp con el mensaje de error visible
            request.setAttribute("error", "Usuario o contrasena incorrectos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    /**
     * Consulta la base de datos techposv1 para verificar si el usuario
     * y contraseña existen y si la cuenta está activa.
     * Devuelve un objeto Usuario si las credenciales son válidas, o null si no.
     */
    private Usuario validarLogin(String usuario, String contrasena) {

        // Consulta parametrizada con PreparedStatement para evitar SQL Injection
        // Solo retorna el usuario si está activo (activo = 1)
        String sql = "SELECT idUsuario, nombre, rol, usuario, activo " +
                "FROM Usuario WHERE usuario = ? AND contrasena = ? AND activo = 1";

        // try-with-resources cierra automáticamente Connection y PreparedStatement
        // al terminar el bloque, evitando fugas de recursos
        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Se asignan los parámetros en orden (? reemplazados por valores reales)
            pstmt.setString(1, usuario);
            pstmt.setString(2, contrasena);

            ResultSet rs = pstmt.executeQuery();

            // Si hay al menos una fila en el resultado, las credenciales son válidas
            if (rs.next()) {
                // Se construye el objeto Usuario con los datos traídos de la BD
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("idUsuario"));
                u.setNombre(rs.getString("nombre"));
                u.setRol(rs.getString("rol"));
                u.setUsuario(rs.getString("usuario"));
                u.setActivo(rs.getBoolean("activo"));
                return u; // Retorna el usuario autenticado
            }

        } catch (SQLException e) {
            // Captura errores de conexión o de consulta SQL
            System.err.println("Error en validarLogin: " + e.getMessage());
            e.printStackTrace();
        }

        // Si no encontró resultados o hubo error, retorna null
        // El llamador interpreta null como login fallido
        return null;
    }

    /**
     * Maneja las solicitudes GET al servlet.
     * Si alguien intenta acceder directamente a la URL /LoginServlet
     * por el navegador, se le redirige al formulario de login.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}