package datos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// Clase utilitaria que centraliza la configuración y apertura
// de conexiones a la base de datos MySQL techposv1.
// Al tenerla en un solo lugar, cualquier cambio de credenciales
// o URL solo requiere modificar esta clase.
public class Conexion {

    // ========== CONFIGURACIÓN DE CONEXIÓN ==========

    // URL de conexión JDBC con los siguientes parámetros:
    // - localhost:3306   → servidor MySQL corriendo en la misma máquina, puerto estándar
    // - techposv1        → nombre de la base de datos a usar
    // - useSSL=false     → desactiva SSL (no necesario en entorno local)
    // - serverTimezone   → evita error de zona horaria con MySQL 8+
    // - allowPublicKeyRetrieval=true → necesario para autenticación con MySQL 8+ en local
    private static final String URL =
            "jdbc:mysql://localhost:3306/techposv1?useSSL=false&serverTimezone=America/Bogota&allowPublicKeyRetrieval=true";

    // Usuario con el que se conecta a MySQL
    // En producción nunca se debe usar root; se crea un usuario con permisos limitados
    private static final String USUARIO = "root";

    // Contraseña del usuario MySQL
    // En producción debe ir en variables de entorno o un archivo de configuración externo,
    // nunca hardcodeada en el código fuente
    private static final String CONTRASENA = "3333";

    // ========== MÉTODO PRINCIPAL DE CONEXIÓN ==========

    /**
     * Crea y retorna una nueva conexión a la base de datos techposv1.
     * Cada llamada abre una conexión nueva — es responsabilidad del llamador
     * cerrarla (preferiblemente con try-with-resources).
     *
     * @return objeto Connection listo para ejecutar consultas
     * @throws SQLException si el driver no se encuentra o la conexión falla
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Carga dinámicamente el driver JDBC de MySQL en tiempo de ejecución
            // Necesario en algunos entornos donde el driver no se registra automáticamente
            // En Jakarta EE moderno con Tomcat 10+ generalmente no es obligatorio,
            // pero se mantiene por compatibilidad y claridad
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Abre la conexión con la URL y las credenciales definidas arriba
            // DriverManager selecciona el driver adecuado según el prefijo "jdbc:mysql://"
            return DriverManager.getConnection(URL, USUARIO, CONTRASENA);

        } catch (ClassNotFoundException e) {
            // Si el JAR del driver MySQL no está en el classpath (falta en pom.xml o en /lib),
            // se convierte la excepción a SQLException para que el llamador la maneje uniformemente
            throw new SQLException("Driver MySQL no encontrado: " + e.getMessage(), e);
        }
    }

    // ========== MÉTODO DE PRUEBA ==========

    /**
     * Método de diagnóstico para verificar que la conexión funciona correctamente.
     * Se ejecuta directamente desde el IDE para comprobar la configuración
     * antes de desplegar la aplicación en Tomcat.
     * No forma parte del flujo web — no es invocado por ningún servlet.
     */
    public static void main(String[] args) {
        try {
            // Intenta abrir una conexión usando el método de arriba
            Connection conn = getConnection();

            System.out.println("Conexion exitosa a la base de datos techposv1");
            System.out.println("URL: " + URL);
            System.out.println("Usuario: " + USUARIO);

            // Cierra la conexión explícitamente al terminar la prueba
            // para liberar el recurso del servidor MySQL
            conn.close();

        } catch (SQLException e) {
            // Muestra el mensaje de error si algo falla:
            // credenciales incorrectas, MySQL apagado, driver ausente, etc.
            System.err.println("Error de conexion: " + e.getMessage());
            e.printStackTrace();
        }
    }
}