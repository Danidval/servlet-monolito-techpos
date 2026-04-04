-- Crear la base de datos (si no existe)
CREATE DATABASE IF NOT EXISTS techposv1
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE techposv1;

-- Crear solo la tabla Usuario (la que realmente necesitas ahora)
CREATE TABLE IF NOT EXISTS Usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    rol ENUM('administrador', 'tecnico', 'recepcionista', 'inventario') NOT NULL,
    usuario VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    fechaCreacion DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Insertar usuario de prueba con contraseña "123" en texto plano
INSERT INTO Usuario (nombre, rol, usuario, contrasena, activo) 
VALUES 
('Admin General', 'administrador', 'admin', '123', TRUE)
ON DUPLICATE KEY UPDATE contrasena = '123';

-- Opcional: Insertar otro usuario de prueba (recepcionista)
INSERT INTO Usuario (nombre, rol, usuario, contrasena, activo) 
VALUES 
('Laura Recepcionista', 'recepcionista', 'laura', '123', TRUE)
ON DUPLICATE KEY UPDATE contrasena = '123';