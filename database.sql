-- Creación de la Tabla de Usuarios (Clientes y Administrador)
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) NOT NULL UNIQUE,
  `telefono` VARCHAR(15) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL, -- Longitud de 255 para evitar truncar el hash de BCRYPT
  `rol` ENUM('cliente', 'barbero') NOT NULL DEFAULT 'cliente',
  `creado_en` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Creación de la Tabla de Servicios (Basada en los mockups de Barber Knight)
CREATE TABLE IF NOT EXISTS `servicios` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre_servicio` VARCHAR(100) NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `duracion_minutos` INT NOT NULL,
  `creado_en` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar servicios base observados en los mockups para pruebas
INSERT INTO `servicios` (`nombre_servicio`, `precio`, `duracion_minutos`) VALUES
('Cortes de cabello', 30000.00, 45),
('Barba', 20000.00, 30),
('Cuidado facial', 25000.00, 35),
('Combos', 50000.00, 60);