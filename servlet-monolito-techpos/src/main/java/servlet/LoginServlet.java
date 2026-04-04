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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🔐 Procesando intento de login...");

        // 1. Recibir datos del formulario
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        // 2. Validar que no estén vacíos
        if (usuario == null || usuario.trim().isEmpty() ||
                contrasena == null || contrasena.trim().isEmpty()) {

            System.out.println("❌ Error: Usuario o contraseña vacíos");
            request.setAttribute("error", "⚠️ Por favor ingrese usuario y contraseña");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // 3. Validar contra la base de datos techposv1
        Usuario user = validarLogin(usuario.trim(), contrasena.trim());

        if (user != null) {
            // 4. Login exitoso - crear sesión
            System.out.println("✅ Login exitoso: " + user.getUsuario() + " - Rol: " + user.getRol());

            HttpSession session = request.getSession();
            session.setAttribute("usuario", user);
            session.setAttribute("idUsuario", user.getIdUsuario());
            session.setAttribute("nombreUsuario", user.getNombre());
            session.setAttribute("usuarioLogin", user.getUsuario());
            session.setAttribute("rol", user.getRol());
            session.setMaxInactiveInterval(30 * 60); // 30 minutos

            // 5. Redirigir al dashboard
            response.sendRedirect("index.jsp");

        } else {
            // 6. Login fallido
            System.out.println("❌ Login fallido para usuario: " + usuario);
            request.setAttribute("error", "❌ Usuario o contraseña incorrectos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    /**
     * Valida las credenciales del usuario contra la base de datos techposv1
     */
    private Usuario validarLogin(String usuario, String contrasena) {
        String sql = "SELECT idUsuario, nombre, rol, usuario, activo FROM Usuario WHERE usuario = ? AND contrasena = ? AND activo = 1";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, usuario);
            pstmt.setString(2, contrasena);

            System.out.println("📡 Ejecutando consulta: " + sql);
            System.out.println("🔍 Usuario: " + usuario + ", Contraseña: " + contrasena);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("idUsuario"));
                u.setNombre(rs.getString("nombre"));
                u.setRol(rs.getString("rol"));
                u.setUsuario(rs.getString("usuario"));
                u.setActivo(rs.getBoolean("activo"));
                return u;
            }

        } catch (SQLException e) {
            System.err.println("❌ Error en validarLogin: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Si alguien intenta acceder por GET, redirigir al login
        response.sendRedirect("login.jsp");
    }
}