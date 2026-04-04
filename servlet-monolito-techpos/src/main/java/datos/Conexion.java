package datos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    // Configuración de tu base de datos techposv1
    private static final String URL = "jdbc:mysql://localhost:3306/techposv1?useSSL=false&serverTimezone=America/Bogota&allowPublicKeyRetrieval=true";
    private static final String USUARIO = "root";
    private static final String CONTRASENA = "3333";

    /**
     * Obtiene una conexión a la base de datos techposv1
     * @return Connection object
     * @throws SQLException si hay error de conexión
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USUARIO, CONTRASENA);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MySQL no encontrado: " + e.getMessage(), e);
        }
    }

    /**
     * Método main para probar la conexión
     */
    public static void main(String[] args) {
        try {
            Connection conn = getConnection();
            System.out.println("✅ Conexión exitosa a la base de datos techposv1");
            System.out.println("📍 URL: " + URL);
            System.out.println("👤 Usuario: " + USUARIO);
            conn.close();
        } catch (SQLException e) {
            System.err.println("❌ Error de conexión: " + e.getMessage());
            e.printStackTrace();
        }
    }
}