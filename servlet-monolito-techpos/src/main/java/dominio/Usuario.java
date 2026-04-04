package dominio;

import java.io.Serializable;
import java.sql.Timestamp;

public class Usuario implements Serializable {

    private static final long serialVersionUID = 1L;

    // Campos que coinciden con tu tabla Usuario en techposv1
    private int idUsuario;
    private String nombre;
    private String rol;          // administrador, tecnico, recepcionista, inventario
    private String usuario;
    private String contrasena;
    private boolean activo;
    private Timestamp fechaCreacion;

    // Constructor vacío
    public Usuario() {}

    // Constructor para login (sin contraseña y sin fecha)
    public Usuario(int idUsuario, String nombre, String rol, String usuario, boolean activo) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.rol = rol;
        this.usuario = usuario;
        this.activo = activo;
    }

    // Constructor completo
    public Usuario(int idUsuario, String nombre, String rol, String usuario, String contrasena, boolean activo, Timestamp fechaCreacion) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.rol = rol;
        this.usuario = usuario;
        this.contrasena = contrasena;
        this.activo = activo;
        this.fechaCreacion = fechaCreacion;
    }

    // ========== GETTERS Y SETTERS ==========

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

    public boolean esAdministrador() {
        return "administrador".equalsIgnoreCase(rol);
    }

    public boolean esTecnico() {
        return "tecnico".equalsIgnoreCase(rol);
    }

    public boolean esRecepcionista() {
        return "recepcionista".equalsIgnoreCase(rol);
    }

    public boolean esInventario() {
        return "inventario".equalsIgnoreCase(rol);
    }
}