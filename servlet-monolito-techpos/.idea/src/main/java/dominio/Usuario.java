package dominio;

import java.io.Serializable;
import java.sql.Timestamp;

// Clase de dominio que representa un usuario del sistema TechPOS
// Implementa Serializable para poder almacenarse en la sesión HTTP (HttpSession)
// sin que Tomcat lance errores al serializar los atributos de sesión
public class Usuario implements Serializable {

    // Identificador de versión requerido por Serializable
    // Si la clase cambia y este número no coincide, Java lanza InvalidClassException
    private static final long serialVersionUID = 1L;

    // ========== ATRIBUTOS ==========
    // Cada campo corresponde a una columna de la tabla Usuario en la BD techposv1

    private int idUsuario;          // Clave primaria autoincremental
    private String nombre;          // Nombre completo del usuario
    private String rol;             // Valores posibles: administrador, tecnico, recepcionista, inventario
    private String usuario;         // Nombre de usuario para iniciar sesión (único en BD)
    private String contrasena;      // Contraseña en texto plano (solo fines educativos)
    private boolean activo;         // true = cuenta habilitada, false = cuenta desactivada
    private Timestamp fechaCreacion;// Fecha y hora en que se creó el registro en BD

    // ========== CONSTRUCTORES ==========

    // Constructor vacío requerido cuando se crea un objeto
    // y luego se asignan sus valores con setters (como en LoginServlet)
    public Usuario() {}

    // Constructor reducido usado durante el login:
    // Solo trae los campos necesarios para la sesión, omite contraseña y fecha
    public Usuario(int idUsuario, String nombre, String rol, String usuario, boolean activo) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.rol = rol;
        this.usuario = usuario;
        this.activo = activo;
    }

    // Constructor completo usado cuando se necesitan todos los datos del usuario,
    // por ejemplo en operaciones administrativas o reportes
    public Usuario(int idUsuario, String nombre, String rol, String usuario,
                   String contrasena, boolean activo, Timestamp fechaCreacion) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.rol = rol;
        this.usuario = usuario;
        this.contrasena = contrasena;
        this.activo = activo;
        this.fechaCreacion = fechaCreacion;
    }

    // ========== GETTERS Y SETTERS ==========
    // Permiten acceder y modificar los atributos privados desde otras clases
    // siguiendo el principio de encapsulamiento

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    // ========== MÉTODOS UTILITARIOS ==========

    // Representación en texto del objeto, útil para logs y depuración
    // Omite la contraseña intencionalmente por seguridad
    @Override
    public String toString() {
        return "Usuario{" +
                "idUsuario=" + idUsuario +
                ", nombre='" + nombre + '\'' +
                ", rol='" + rol + '\'' +
                ", usuario='" + usuario + '\'' +
                ", activo=" + activo +
                '}';
    }

    // Métodos de verificación de rol:
    // Usan equalsIgnoreCase para que "Administrador" y "administrador" sean equivalentes
    // Se usan en JSP o en servlets para mostrar/ocultar secciones según el rol

    // Retorna true si el usuario tiene rol de administrador
    public boolean esAdministrador() {
        return "administrador".equalsIgnoreCase(rol);
    }

    // Retorna true si el usuario tiene rol de técnico
    public boolean esTecnico() {
        return "tecnico".equalsIgnoreCase(rol);
    }

    // Retorna true si el usuario tiene rol de recepcionista
    public boolean esRecepcionista() {
        return "recepcionista".equalsIgnoreCase(rol);
    }

    // Retorna true si el usuario tiene rol de inventario
    public boolean esInventario() {
        return "inventario".equalsIgnoreCase(rol);
    }
}