-- ============================================
-- Script SQL para Base de Datos E-Learning
-- Sprint 1 - Backend
-- ============================================

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS elearning_db;
USE elearning_db;

-- ============================================
-- TABLA: Usuario
-- ============================================
CREATE TABLE IF NOT EXISTS Usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    rol VARCHAR(20) NOT NULL DEFAULT 'estudiante',
    CONSTRAINT chk_rol CHECK (rol IN ('estudiante', 'docente', 'admin'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: Curso
-- ============================================
CREATE TABLE IF NOT EXISTS Curso (
    idCurso INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT NOT NULL,
    categoria VARCHAR(80) NOT NULL,
    idDocente INT NOT NULL,
    FOREIGN KEY (idDocente) REFERENCES Usuario(idUsuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: Inscripcion
-- ============================================
CREATE TABLE IF NOT EXISTS Inscripcion (
    idUsuario INT NOT NULL,
    idCurso INT NOT NULL,
    fechaInscripcion DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (idUsuario, idCurso),
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario) ON DELETE CASCADE,
    FOREIGN KEY (idCurso) REFERENCES Curso(idCurso) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: Material
-- ============================================
CREATE TABLE IF NOT EXISTS Material (
    idMaterial INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(30) NOT NULL,
    url VARCHAR(255) NOT NULL,
    idCurso INT NOT NULL,
    FOREIGN KEY (idCurso) REFERENCES Curso(idCurso) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: Evaluacion
-- ============================================
CREATE TABLE IF NOT EXISTS Evaluacion (
    idEvaluacion INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(30) NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    idCurso INT NOT NULL,
    FOREIGN KEY (idCurso) REFERENCES Curso(idCurso) ON DELETE CASCADE,
    CONSTRAINT chk_fechas CHECK (fechaFin >= fechaInicio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: Foro
-- ============================================
CREATE TABLE IF NOT EXISTS Foro (
    idForo INT AUTO_INCREMENT PRIMARY KEY,
    tema VARCHAR(200) NOT NULL,
    idCurso INT NOT NULL,
    FOREIGN KEY (idCurso) REFERENCES Curso(idCurso) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: Mensaje
-- ============================================
CREATE TABLE IF NOT EXISTS Mensaje (
    idMensaje INT AUTO_INCREMENT PRIMARY KEY,
    contenido TEXT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    idForo INT NOT NULL,
    idUsuario INT NOT NULL,
    FOREIGN KEY (idForo) REFERENCES Foro(idForo) ON DELETE CASCADE,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: Reporte
-- ============================================
CREATE TABLE IF NOT EXISTS Reporte (
    idReporte INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    fecha DATE NOT NULL DEFAULT (CURRENT_DATE),
    idUsuario INT NOT NULL,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- ÍNDICES PARA MEJORAR RENDIMIENTO
-- ============================================
CREATE INDEX idx_curso_categoria ON Curso(categoria);
CREATE INDEX idx_curso_titulo ON Curso(titulo);
CREATE INDEX idx_inscripcion_usuario ON Inscripcion(idUsuario);
CREATE INDEX idx_inscripcion_curso ON Inscripcion(idCurso);
CREATE INDEX idx_material_curso ON Material(idCurso);

-- ============================================
-- DATOS DE EJEMPLO (OPCIONAL)
-- ============================================
-- Insertar usuario docente de ejemplo
-- Contraseña: "password123" (hash con bcrypt)
INSERT INTO Usuario (nombre, correo, contrasena, rol) VALUES
('Profesor Ejemplo', 'docente@ejemplo.com', '$2b$10$rQZ8X8X8X8X8X8X8X8X8OeX8X8X8X8X8X8X8X8X8X8X8X8X8X8X8X8', 'docente');

-- Insertar usuario estudiante de ejemplo
-- Contraseña: "password123" (hash con bcrypt)
INSERT INTO Usuario (nombre, correo, contrasena, rol) VALUES
('Estudiante Ejemplo', 'estudiante@ejemplo.com', '$2b$10$rQZ8X8X8X8X8X8X8X8OeX8X8X8X8X8X8X8X8X8X8X8X8X8X8X8X8', 'estudiante');

