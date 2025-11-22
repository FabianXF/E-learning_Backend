-- Script de actualización de base de datos para agregar campos faltantes
-- Ejecutar este script si hay problemas con la inscripción

USE elearning_db;

-- Agregar campo avatar a Usuario si no existe
ALTER TABLE Usuario 
ADD COLUMN IF NOT EXISTS avatar VARCHAR(255) NULL;

-- Agregar campo progresoPorcentaje a Inscripcion si no existe
ALTER TABLE Inscripcion 
ADD COLUMN IF NOT EXISTS progresoPorcentaje INT DEFAULT 0;

-- Agregar campo imagenUrl a Curso si no existe
ALTER TABLE Curso 
ADD COLUMN IF NOT EXISTS imagenUrl VARCHAR(255) NULL;

-- Verificar estructura de las tablas
DESCRIBE Usuario;
DESCRIBE Inscripcion;
DESCRIBE Curso;

-- Mostrar usuarios existentes
SELECT idUsuario, nombre, correo, rol FROM Usuario;

-- Mostrar cursos existentes
SELECT idCurso, titulo, idDocente FROM Curso;

-- Mostrar inscripciones existentes
SELECT * FROM Inscripcion;
