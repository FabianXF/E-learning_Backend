-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-11-2025 a las 23:45:02
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `elearning_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificado`
--

CREATE TABLE `certificado` (
  `idCertificado` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `idCurso` int(11) NOT NULL,
  `fechaEmision` datetime DEFAULT NULL,
  `codigoVerificacion` varchar(50) DEFAULT NULL,
  `urlPDF` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `certificado`
--

INSERT INTO `certificado` (`idCertificado`, `idUsuario`, `idCurso`, `fechaEmision`, `codigoVerificacion`, `urlPDF`) VALUES
(1, 4, 4, '2025-11-22 20:51:48', '6AA58087-6', 'C:\\Users\\yefa1\\Documents\\copia_nube\\7_Semestre\\Tecnologia Web\\backend-elearning-main\\certificates\\Fabian_Jaimes-cisco.pdf'),
(2, 4, 4, '2025-11-22 20:52:12', '8C6CC853-7', 'C:\\Users\\yefa1\\Documents\\copia_nube\\7_Semestre\\Tecnologia Web\\backend-elearning-main\\certificates\\Fabian_Jaimes-cisco.pdf'),
(3, 4, 4, '2025-11-22 20:56:51', '8A517D60-5', 'C:\\Users\\yefa1\\Documents\\copia_nube\\7_Semestre\\Tecnologia Web\\backend-elearning-main\\certificates\\Fabian_Jaimes-cisco.pdf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `idCurso` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `descripcion` text NOT NULL,
  `categoria` varchar(80) NOT NULL,
  `idDocente` int(11) NOT NULL,
  `imagenUrl` varchar(255) DEFAULT NULL,
  `fechaCreacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`idCurso`, `titulo`, `descripcion`, `categoria`, `idDocente`, `imagenUrl`, `fechaCreacion`) VALUES
(4, 'cisco', 'prueba', 'Diseño', 7, '', '2025-11-20'),
(5, 'Curso del admin', 'Master cheft', 'Desarrollo Personal', 8, '', '2025-11-22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion`
--

CREATE TABLE `evaluacion` (
  `idEvaluacion` int(11) NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaFin` date NOT NULL,
  `idCurso` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `evaluacion`
--

INSERT INTO `evaluacion` (`idEvaluacion`, `fechaInicio`, `fechaFin`, `idCurso`, `titulo`, `descripcion`) VALUES
(9, '2025-11-22', '2025-11-28', 5, 'Nuevo Curso de Testing', 'Prueba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `foro`
--

CREATE TABLE `foro` (
  `idForo` int(11) NOT NULL,
  `tema` varchar(200) NOT NULL,
  `idCurso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `foro`
--

INSERT INTO `foro` (`idForo`, `tema`, `idCurso`) VALUES
(4, 'prueba', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripcion`
--

CREATE TABLE `inscripcion` (
  `idUsuario` int(11) NOT NULL,
  `idCurso` int(11) NOT NULL,
  `fechaInscripcion` date NOT NULL,
  `progresoPorcentaje` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inscripcion`
--

INSERT INTO `inscripcion` (`idUsuario`, `idCurso`, `fechaInscripcion`, `progresoPorcentaje`) VALUES
(4, 4, '2025-11-22', 100),
(4, 5, '2025-11-22', 0),
(8, 4, '2025-11-22', 100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `material`
--

CREATE TABLE `material` (
  `idMaterial` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `url` varchar(255) NOT NULL,
  `duracionMinutos` int(11) DEFAULT NULL,
  `idModulo` int(11) NOT NULL,
  `idCurso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `material`
--

INSERT INTO `material` (`idMaterial`, `titulo`, `tipo`, `url`, `duracionMinutos`, `idModulo`, `idCurso`) VALUES
(2, 'prueba m', 'pdf', '/uploads/1763839669750.pdf', NULL, 5, NULL),
(3, 'pp', 'pdf', '/uploads/1763839897673.pdf', NULL, 5, NULL),
(4, 'ppi', 'pdf', '/uploads/1763839943480.pdf', NULL, 5, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensaje`
--

CREATE TABLE `mensaje` (
  `idMensaje` int(11) NOT NULL,
  `contenido` text NOT NULL,
  `fecha` datetime NOT NULL,
  `idForo` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mensaje`
--

INSERT INTO `mensaje` (`idMensaje`, `contenido`, `fecha`, `idForo`, `idUsuario`) VALUES
(26, 'Hola Profe', '2025-11-22 22:01:03', 4, 4),
(28, 'Eliminado', '2025-11-22 22:07:07', 4, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulo`
--

CREATE TABLE `modulo` (
  `idModulo` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `orden` int(11) NOT NULL,
  `idCurso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `modulo`
--

INSERT INTO `modulo` (`idModulo`, `titulo`, `descripcion`, `orden`, `idCurso`) VALUES
(5, 'prueba', '', 1, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opcion`
--

CREATE TABLE `opcion` (
  `idOpcion` int(11) NOT NULL,
  `idPregunta` int(11) NOT NULL,
  `texto` varchar(255) NOT NULL,
  `esCorrecta` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `opcion`
--

INSERT INTO `opcion` (`idOpcion`, `idPregunta`, `texto`, `esCorrecta`) VALUES
(1, 1, 'Mundo', 1),
(2, 1, 'a', 0),
(3, 1, 's', 0),
(4, 1, 'a', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregunta`
--

CREATE TABLE `pregunta` (
  `idPregunta` int(11) NOT NULL,
  `idEvaluacion` int(11) NOT NULL,
  `textoPregunta` text NOT NULL,
  `tipo` enum('opcion_multiple','verdadero_falso','abierta') NOT NULL,
  `puntos` int(11) DEFAULT 10
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pregunta`
--

INSERT INTO `pregunta` (`idPregunta`, `idEvaluacion`, `textoPregunta`, `tipo`, `puntos`) VALUES
(1, 9, 'Hola', 'opcion_multiple', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `progresomaterial`
--

CREATE TABLE `progresomaterial` (
  `idUsuario` int(11) NOT NULL,
  `idMaterial` int(11) NOT NULL,
  `completado` tinyint(1) DEFAULT 0,
  `fechaCompletado` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `progresomaterial`
--

INSERT INTO `progresomaterial` (`idUsuario`, `idMaterial`, `completado`, `fechaCompletado`) VALUES
(4, 2, 1, '2025-11-22 20:03:46'),
(4, 3, 1, '2025-11-22 20:03:47'),
(4, 4, 1, '2025-11-22 20:51:40'),
(8, 2, 1, '2025-11-22 20:21:08'),
(8, 3, 1, '2025-11-22 20:51:00'),
(8, 4, 1, '2025-11-22 22:07:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestaestudiante`
--

CREATE TABLE `respuestaestudiante` (
  `idRespuesta` int(11) NOT NULL,
  `idPregunta` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `respuestaTexto` text DEFAULT NULL,
  `idOpcionSeleccionada` int(11) DEFAULT NULL,
  `correcta` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `respuestaestudiante`
--

INSERT INTO `respuestaestudiante` (`idRespuesta`, `idPregunta`, `idUsuario`, `respuestaTexto`, `idOpcionSeleccionada`, `correcta`) VALUES
(4, 1, 4, NULL, 1, 1),
(5, 1, 4, NULL, 1, 1),
(6, 1, 4, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol` varchar(20) NOT NULL DEFAULT 'estudiante',
  `avatar` varchar(255) DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `nombre`, `correo`, `contrasena`, `rol`, `avatar`) VALUES
(4, 'Fabian Jaimes', 'yefa1203jaimes@gmail.com', '$2b$10$WEhZ1V2pnmfGO81L5qMYaetEkbNOSlTV5U3l/9d2fipBJbU2QPama', 'estudiante', NULL),
(7, 'docente prueba', 'docente@gmail.com', '$2b$10$EOYWl3N/1MHTB9tIwGC6UubE2oA8CXU171WqL36jPhKZa8Clkxbfi', 'docente', NULL),
(8, 'Manuel Administrador', 'admin@test.com', '$2b$10$iu3fo4KQHWQuAGX2oq/BY.Umqk/zTsA/tilxMVRlCipJuXkLNeGdm', 'admin', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `certificado`
--
ALTER TABLE `certificado`
  ADD PRIMARY KEY (`idCertificado`),
  ADD UNIQUE KEY `codigoVerificacion` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_2` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_3` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_4` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_5` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_6` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_7` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_8` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_9` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_10` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_11` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_12` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_13` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_14` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_15` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_16` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_17` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_18` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_19` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_20` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_21` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_22` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_23` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_24` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_25` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_26` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_27` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_28` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_29` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_30` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_31` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_32` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_33` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_34` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_35` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_36` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_37` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_38` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_39` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_40` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_41` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_42` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_43` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_44` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_45` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_46` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_47` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_48` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_49` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_50` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_51` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_52` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_53` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_54` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_55` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_56` (`codigoVerificacion`),
  ADD UNIQUE KEY `codigoVerificacion_57` (`codigoVerificacion`),
  ADD KEY `idUsuario` (`idUsuario`),
  ADD KEY `idCurso` (`idCurso`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`idCurso`),
  ADD KEY `idDocente` (`idDocente`);

--
-- Indices de la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  ADD PRIMARY KEY (`idEvaluacion`),
  ADD KEY `idCurso` (`idCurso`);

--
-- Indices de la tabla `foro`
--
ALTER TABLE `foro`
  ADD PRIMARY KEY (`idForo`),
  ADD KEY `idCurso` (`idCurso`);

--
-- Indices de la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD PRIMARY KEY (`idUsuario`,`idCurso`),
  ADD KEY `idCurso` (`idCurso`);

--
-- Indices de la tabla `material`
--
ALTER TABLE `material`
  ADD PRIMARY KEY (`idMaterial`),
  ADD KEY `idModulo` (`idModulo`),
  ADD KEY `idCurso` (`idCurso`);

--
-- Indices de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  ADD PRIMARY KEY (`idMensaje`),
  ADD KEY `idForo` (`idForo`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `modulo`
--
ALTER TABLE `modulo`
  ADD PRIMARY KEY (`idModulo`),
  ADD KEY `idCurso` (`idCurso`);

--
-- Indices de la tabla `opcion`
--
ALTER TABLE `opcion`
  ADD PRIMARY KEY (`idOpcion`),
  ADD KEY `idPregunta` (`idPregunta`);

--
-- Indices de la tabla `pregunta`
--
ALTER TABLE `pregunta`
  ADD PRIMARY KEY (`idPregunta`),
  ADD KEY `idEvaluacion` (`idEvaluacion`);

--
-- Indices de la tabla `progresomaterial`
--
ALTER TABLE `progresomaterial`
  ADD PRIMARY KEY (`idUsuario`,`idMaterial`),
  ADD KEY `idMaterial` (`idMaterial`);

--
-- Indices de la tabla `respuestaestudiante`
--
ALTER TABLE `respuestaestudiante`
  ADD PRIMARY KEY (`idRespuesta`),
  ADD KEY `idPregunta` (`idPregunta`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD UNIQUE KEY `correo_2` (`correo`),
  ADD UNIQUE KEY `correo_3` (`correo`),
  ADD UNIQUE KEY `correo_4` (`correo`),
  ADD UNIQUE KEY `correo_5` (`correo`),
  ADD UNIQUE KEY `correo_6` (`correo`),
  ADD UNIQUE KEY `correo_7` (`correo`),
  ADD UNIQUE KEY `correo_8` (`correo`),
  ADD UNIQUE KEY `correo_9` (`correo`),
  ADD UNIQUE KEY `correo_10` (`correo`),
  ADD UNIQUE KEY `correo_11` (`correo`),
  ADD UNIQUE KEY `correo_12` (`correo`),
  ADD UNIQUE KEY `correo_13` (`correo`),
  ADD UNIQUE KEY `correo_14` (`correo`),
  ADD UNIQUE KEY `correo_15` (`correo`),
  ADD UNIQUE KEY `correo_16` (`correo`),
  ADD UNIQUE KEY `correo_17` (`correo`),
  ADD UNIQUE KEY `correo_18` (`correo`),
  ADD UNIQUE KEY `correo_19` (`correo`),
  ADD UNIQUE KEY `correo_20` (`correo`),
  ADD UNIQUE KEY `correo_21` (`correo`),
  ADD UNIQUE KEY `correo_22` (`correo`),
  ADD UNIQUE KEY `correo_23` (`correo`),
  ADD UNIQUE KEY `correo_24` (`correo`),
  ADD UNIQUE KEY `correo_25` (`correo`),
  ADD UNIQUE KEY `correo_26` (`correo`),
  ADD UNIQUE KEY `correo_27` (`correo`),
  ADD UNIQUE KEY `correo_28` (`correo`),
  ADD UNIQUE KEY `correo_29` (`correo`),
  ADD UNIQUE KEY `correo_30` (`correo`),
  ADD UNIQUE KEY `correo_31` (`correo`),
  ADD UNIQUE KEY `correo_32` (`correo`),
  ADD UNIQUE KEY `correo_33` (`correo`),
  ADD UNIQUE KEY `correo_34` (`correo`),
  ADD UNIQUE KEY `correo_35` (`correo`),
  ADD UNIQUE KEY `correo_36` (`correo`),
  ADD UNIQUE KEY `correo_37` (`correo`),
  ADD UNIQUE KEY `correo_38` (`correo`),
  ADD UNIQUE KEY `correo_39` (`correo`),
  ADD UNIQUE KEY `correo_40` (`correo`),
  ADD UNIQUE KEY `correo_41` (`correo`),
  ADD UNIQUE KEY `correo_42` (`correo`),
  ADD UNIQUE KEY `correo_43` (`correo`),
  ADD UNIQUE KEY `correo_44` (`correo`),
  ADD UNIQUE KEY `correo_45` (`correo`),
  ADD UNIQUE KEY `correo_46` (`correo`),
  ADD UNIQUE KEY `correo_47` (`correo`),
  ADD UNIQUE KEY `correo_48` (`correo`),
  ADD UNIQUE KEY `correo_49` (`correo`),
  ADD UNIQUE KEY `correo_50` (`correo`),
  ADD UNIQUE KEY `correo_51` (`correo`),
  ADD UNIQUE KEY `correo_52` (`correo`),
  ADD UNIQUE KEY `correo_53` (`correo`),
  ADD UNIQUE KEY `correo_54` (`correo`),
  ADD UNIQUE KEY `correo_55` (`correo`),
  ADD UNIQUE KEY `correo_56` (`correo`),
  ADD UNIQUE KEY `correo_57` (`correo`),
  ADD UNIQUE KEY `correo_58` (`correo`),
  ADD UNIQUE KEY `correo_59` (`correo`),
  ADD UNIQUE KEY `correo_60` (`correo`),
  ADD UNIQUE KEY `correo_61` (`correo`),
  ADD UNIQUE KEY `correo_62` (`correo`),
  ADD UNIQUE KEY `correo_63` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `certificado`
--
ALTER TABLE `certificado`
  MODIFY `idCertificado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `idCurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  MODIFY `idEvaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `foro`
--
ALTER TABLE `foro`
  MODIFY `idForo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `material`
--
ALTER TABLE `material`
  MODIFY `idMaterial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  MODIFY `idMensaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `modulo`
--
ALTER TABLE `modulo`
  MODIFY `idModulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `opcion`
--
ALTER TABLE `opcion`
  MODIFY `idOpcion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `pregunta`
--
ALTER TABLE `pregunta`
  MODIFY `idPregunta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `respuestaestudiante`
--
ALTER TABLE `respuestaestudiante`
  MODIFY `idRespuesta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `certificado`
--
ALTER TABLE `certificado`
  ADD CONSTRAINT `certificado_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`),
  ADD CONSTRAINT `certificado_ibfk_10` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_100` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_101` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_102` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_103` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_104` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_105` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_106` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_107` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_108` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_109` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_11` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_110` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_111` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_112` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_113` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_114` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_12` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_13` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_14` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_15` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_16` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_17` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_18` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_19` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_2` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`),
  ADD CONSTRAINT `certificado_ibfk_20` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_21` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_22` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_23` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_24` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_25` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_26` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_27` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_28` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_29` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_3` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_30` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_31` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_32` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_33` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_34` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_35` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_36` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_37` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_38` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_39` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_4` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_40` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_41` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_42` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_43` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_44` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_45` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_46` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_47` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_48` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_49` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_5` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_50` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_51` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_52` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_53` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_54` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_55` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_56` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_57` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_58` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_59` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_6` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_60` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_61` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_62` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_63` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_64` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_65` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_66` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_67` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_68` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_69` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_7` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_70` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_71` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_72` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_73` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_74` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_75` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_76` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_77` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_78` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_79` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_8` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_80` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_81` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_82` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_83` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_84` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_85` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_86` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_87` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_88` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_89` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_9` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_90` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_91` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_92` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_93` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_94` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_95` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_96` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_97` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_98` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `certificado_ibfk_99` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `curso_ibfk_1` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `curso_ibfk_10` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_11` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_12` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_13` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_14` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_15` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_16` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_17` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_18` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_19` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_2` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_20` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_21` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_22` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_23` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_24` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_25` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_26` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_27` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_28` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_29` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_3` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_30` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_31` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_32` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_33` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_34` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_35` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_36` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_37` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_38` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_39` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_4` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_40` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_41` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_42` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_43` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_44` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_45` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_46` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_47` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_48` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_49` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_5` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_50` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_51` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_52` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_53` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_54` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_55` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_56` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_57` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_58` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_59` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_6` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_60` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_61` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_62` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_63` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_7` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_8` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_9` FOREIGN KEY (`idDocente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  ADD CONSTRAINT `evaluacion_ibfk_1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_10` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_11` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_12` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_13` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_14` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_15` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_16` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_17` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_18` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_19` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_2` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_20` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_21` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_22` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_23` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_24` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_25` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_26` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_27` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_28` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_29` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_3` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_30` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_31` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_32` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_33` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_34` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_35` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_36` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_37` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_38` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_39` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_4` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_40` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_41` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_42` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_43` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_44` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_45` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_46` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_47` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_48` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_49` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_5` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_50` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_51` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_52` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_53` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_54` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_55` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_56` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_57` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_58` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_59` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_6` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_60` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_61` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_62` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_7` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_8` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluacion_ibfk_9` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `foro`
--
ALTER TABLE `foro`
  ADD CONSTRAINT `foro_ibfk_1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE,
  ADD CONSTRAINT `foro_ibfk_10` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_11` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_12` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_13` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_14` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_15` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_16` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_17` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_18` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_19` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_2` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_20` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_21` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_22` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_23` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_24` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_25` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_26` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_27` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_28` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_29` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_3` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_30` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_31` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_32` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_33` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_34` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_35` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_36` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_37` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_38` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_39` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_4` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_40` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_41` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_42` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_43` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_44` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_45` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_46` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_47` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_48` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_49` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_5` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_50` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_51` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_52` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_53` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_54` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_55` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_56` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_57` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_58` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_59` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_6` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_60` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_61` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_7` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_8` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `foro_ibfk_9` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD CONSTRAINT `inscripcion_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `inscripcion_ibfk_2` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE;

--
-- Filtros para la tabla `material`
--
ALTER TABLE `material`
  ADD CONSTRAINT `Material_idCurso_foreign_idx` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_1` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE,
  ADD CONSTRAINT `material_ibfk_10` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_100` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_101` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_102` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_103` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_104` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_105` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_106` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_107` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_108` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_109` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_11` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_110` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_111` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_112` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_113` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_114` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_115` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_116` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_117` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_118` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_119` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_12` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_120` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_121` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_122` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_13` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_14` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_15` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_16` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_17` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_18` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_19` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_2` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_20` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_21` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_22` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_23` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_24` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_25` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_26` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_27` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_28` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_29` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_3` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_30` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_31` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_32` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_33` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_34` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_35` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_36` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_37` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_38` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_39` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_4` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_40` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_41` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_42` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_43` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_44` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_45` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_46` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_47` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_48` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_49` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_5` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_50` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_51` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_52` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_53` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_54` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_55` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_56` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_57` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_58` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_59` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_6` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_60` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_61` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_62` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_63` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_64` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_65` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_66` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_67` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_68` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_69` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_7` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_70` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_71` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_72` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_73` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_74` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_75` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_76` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_77` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_78` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_79` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_8` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_80` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_81` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_82` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_83` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_84` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_85` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_86` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_87` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_88` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_89` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_9` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_90` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_91` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_92` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_93` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_94` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_95` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_96` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_97` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_98` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `material_ibfk_99` FOREIGN KEY (`idModulo`) REFERENCES `modulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `mensaje`
--
ALTER TABLE `mensaje`
  ADD CONSTRAINT `mensaje_ibfk_1` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_10` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_100` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_101` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_102` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_103` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_104` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_105` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_106` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_107` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_108` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_109` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_11` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_110` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_111` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_112` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_113` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_114` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_115` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_116` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_117` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_118` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_119` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_12` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_120` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_13` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_14` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_15` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_16` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_17` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_18` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_19` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_20` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_21` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_22` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_23` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_24` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_25` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_26` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_27` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_28` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_29` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_3` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_30` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_31` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_32` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_33` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_34` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_35` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_36` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_37` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_38` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_39` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_4` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_40` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_41` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_42` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_43` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_44` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_45` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_46` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_47` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_48` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_49` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_5` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_50` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_51` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_52` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_53` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_54` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_55` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_56` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_57` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_58` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_59` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_6` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_60` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_61` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_62` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_63` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_64` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_65` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_66` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_67` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_68` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_69` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_7` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_70` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_71` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_72` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_73` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_74` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_75` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_76` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_77` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_78` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_79` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_8` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_80` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_81` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_82` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_83` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_84` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_85` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_86` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_87` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_88` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_89` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_9` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_90` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_91` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_92` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_93` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_94` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_95` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_96` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_97` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_98` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mensaje_ibfk_99` FOREIGN KEY (`idForo`) REFERENCES `foro` (`idForo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `modulo`
--
ALTER TABLE `modulo`
  ADD CONSTRAINT `modulo_ibfk_1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_10` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_11` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_12` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_13` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_14` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_15` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_16` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_17` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_18` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_19` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_2` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_20` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_21` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_22` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_23` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_24` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_25` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_26` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_27` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_28` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_29` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_3` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_30` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_31` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_32` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_33` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_34` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_35` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_36` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_37` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_38` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_39` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_4` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_40` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_41` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_42` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_43` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_44` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_45` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_46` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_47` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_48` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_49` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_5` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_50` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_51` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_52` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_53` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_54` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_55` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_56` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_57` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_58` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_59` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_6` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_60` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_61` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_62` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_63` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_7` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_8` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `modulo_ibfk_9` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `opcion`
--
ALTER TABLE `opcion`
  ADD CONSTRAINT `opcion_ibfk_1` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_10` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_11` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_12` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_13` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_14` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_15` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_16` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_17` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_18` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_19` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_2` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_20` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_21` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_22` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_23` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_24` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_25` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_26` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_27` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_28` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_29` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_3` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_30` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_31` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_32` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_33` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_34` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_35` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_36` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_37` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_38` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_39` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_4` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_40` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_41` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_42` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_43` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_44` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_45` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_46` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_47` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_48` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_49` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_5` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_50` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_51` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_52` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_53` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_54` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_55` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_56` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_57` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_58` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_59` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_6` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_7` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_8` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `opcion_ibfk_9` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pregunta`
--
ALTER TABLE `pregunta`
  ADD CONSTRAINT `pregunta_ibfk_1` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_10` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_11` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_12` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_13` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_14` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_15` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_16` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_17` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_18` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_19` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_2` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_20` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_21` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_22` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_23` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_24` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_25` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_26` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_27` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_28` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_29` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_3` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_30` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_31` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_32` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_33` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_34` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_35` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_36` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_37` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_38` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_39` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_4` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_40` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_41` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_42` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_43` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_44` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_45` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_46` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_47` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_48` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_49` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_5` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_50` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_51` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_52` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_53` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_54` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_55` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_56` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_57` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_58` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_59` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_6` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_60` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_7` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_8` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pregunta_ibfk_9` FOREIGN KEY (`idEvaluacion`) REFERENCES `evaluacion` (`idEvaluacion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `progresomaterial`
--
ALTER TABLE `progresomaterial`
  ADD CONSTRAINT `progresomaterial_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `progresomaterial_ibfk_2` FOREIGN KEY (`idMaterial`) REFERENCES `material` (`idMaterial`) ON DELETE CASCADE;

--
-- Filtros para la tabla `respuestaestudiante`
--
ALTER TABLE `respuestaestudiante`
  ADD CONSTRAINT `respuestaestudiante_ibfk_1` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_10` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_100` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_101` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_102` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_103` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_104` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_105` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_106` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_107` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_108` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_109` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_11` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_110` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_111` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_112` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_113` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_114` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_115` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_116` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_12` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_13` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_14` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_15` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_16` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_17` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_18` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_19` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_20` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_21` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_22` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_23` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_24` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_25` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_26` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_27` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_28` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_29` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_3` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_30` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_31` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_32` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_33` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_34` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_35` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_36` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_37` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_38` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_39` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_4` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_40` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_41` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_42` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_43` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_44` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_45` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_46` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_47` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_48` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_49` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_5` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_50` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_51` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_52` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_53` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_54` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_55` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_56` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_57` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_58` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_59` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_6` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_60` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_61` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_62` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_63` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_64` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_65` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_66` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_67` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_68` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_69` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_7` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_70` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_71` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_72` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_73` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_74` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_75` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_76` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_77` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_78` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_79` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_8` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_80` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_81` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_82` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_83` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_84` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_85` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_86` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_87` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_88` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_89` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_9` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_90` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_91` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_92` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_93` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_94` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_95` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_96` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_97` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_98` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `respuestaestudiante_ibfk_99` FOREIGN KEY (`idPregunta`) REFERENCES `pregunta` (`idPregunta`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
