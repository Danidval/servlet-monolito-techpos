package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Mapea este servlet a la URL /LogoutServlet
// Cuando el usuario accede a esa ruta, Tomcat ejecuta esta clase
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    // Identificador de versión requerido por la interfaz Serializable
    private static final long serialVersionUID = 1L;

    /**
     * Maneja las solicitudes GET al servlet.
     * Se activa cuando el usuario hace clic en "Cerrar sesión"
     * mediante un enlace <a href="LogoutServlet">.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtiene la sesión actual SIN crear una nueva si no existe
        // getSession(false) devuelve null si no hay sesión activa
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Recupera el nombre del usuario antes de destruir la sesión
            // para poder registrarlo en el log del servidor
            String usuario = (String) session.getAttribute("usuarioLogin");
            System.out.println("Usuario " + usuario + " ha cerrado sesion");

            // Destruye la sesión completamente:
            // elimina todos los atributos almacenados (usuario, rol, etc.)
            // y libera los recursos del servidor asociados a ella
            session.invalidate();
        }

        // Redirige al navegador hacia la página de login
        // request.getContextPath() obtiene la raíz del contexto dinámicamente
        // por ejemplo: /servlet_monolito_techpos_war_exploded
        // Así el redirect funciona sin importar cómo se desplegó la app
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    /**
     * Maneja las solicitudes POST al servlet.
     * Por ejemplo, si el cierre de sesión se hace desde un formulario
     * con method="POST" en lugar de un enlace GET.
     * Delega directamente a doGet() porque la lógica es la misma.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}