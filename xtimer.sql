-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-03-2025 a las 20:01:36
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
-- Base de datos: `xtimer`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aprobaciones`
--

CREATE TABLE `aprobaciones` (
  `id` int(11) NOT NULL,
  `id_horas_extra` int(11) NOT NULL,
  `id_aprobador` int(11) NOT NULL,
  `estado` enum('aprobado','rechazado') NOT NULL,
  `comentarios` text DEFAULT NULL,
  `fecha_aprobacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `contacto`, `email`, `telefono`) VALUES
(1, 'Empresa ABC', 'Carlos López', 'carlos.abc@example.com', '555-1234'),
(2, 'Empresa XYZ', 'Ana Torres', 'ana.xyz@example.com', '555-5678');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion_tarifas`
--

CREATE TABLE `configuracion_tarifas` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `tipo_hora` enum('normal','nocturna','festivo') NOT NULL,
  `tarifa` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuracion_tarifas`
--

INSERT INTO `configuracion_tarifas` (`id`, `id_usuario`, `tipo_hora`, `tarifa`) VALUES
(1, 2, 'normal', 25.00),
(2, 2, 'nocturna', 30.00),
(3, 2, 'festivo', 40.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horas_extra`
--

CREATE TABLE `horas_extra` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `total_horas` date NOT NULL,
  `descripcion` text DEFAULT NULL,
  `estado` enum('pendiente','aprobado','rechazado') NOT NULL DEFAULT 'pendiente',
  `id_aprobador` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `horas_extra`
--

INSERT INTO `horas_extra` (`id`, `id_usuario`, `id_proyecto`, `fecha`, `hora_inicio`, `hora_fin`, `total_horas`, `descripcion`, `estado`, `id_aprobador`) VALUES
(1, 3, 1, '2025-03-03', '12:39:00', '15:40:00', '1899-11-30', 'test', 'aprobado', NULL),
(2, 3, 1, '2025-03-15', '15:50:00', '16:50:00', '1899-11-30', 'test', 'aprobado', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos`
--

CREATE TABLE `proyectos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `estado` enum('activo','finalizado') NOT NULL DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proyectos`
--

INSERT INTO `proyectos` (`id`, `nombre`, `id_cliente`, `descripcion`, `estado`) VALUES
(1, 'Implementación ERP', 1, 'Proyecto de implementación de un ERP para la empresa ABC', 'activo'),
(2, 'Optimización Financiera', 2, 'Asesoría financiera para la empresa XYZ', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('admin','consultor') NOT NULL DEFAULT 'consultor',
  `area` varchar(100) NOT NULL,
  `estado` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `email`, `password`, `rol`, `area`, `estado`) VALUES
(1, 'Juan', 'Pérez', 'juan.perez@example.com', '$2b$10$.hT8BlCPOFHsFkgX.y.wm.3VvwyTjz/PulCtxI7QdzmPGGP/3n8CG', 'admin', 'TI', 1),
(2, 'María', 'González', 'maria.gonzalez@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'consultor', 'Finanzas', 1),
(3, 'Mao', 'Feit', 'mao@test.cl', '$2b$10$neRjaVvtp/2IdmjDnzx9dOUmoA3as4CplTJ1geaV.Bm7u60.ukhLG', 'admin', 'TI', 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_horas_aprobadas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_horas_aprobadas` (
`id` int(11)
,`consultor` varchar(100)
,`apellido` varchar(100)
,`proyecto` varchar(150)
,`fecha` date
,`hora_inicio` time
,`hora_fin` time
,`total_horas` date
,`descripcion` text
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_horas_aprobadas`
--
DROP TABLE IF EXISTS `vista_horas_aprobadas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_horas_aprobadas`  AS SELECT `he`.`id` AS `id`, `u`.`nombre` AS `consultor`, `u`.`apellido` AS `apellido`, `p`.`nombre` AS `proyecto`, `he`.`fecha` AS `fecha`, `he`.`hora_inicio` AS `hora_inicio`, `he`.`hora_fin` AS `hora_fin`, `he`.`total_horas` AS `total_horas`, `he`.`descripcion` AS `descripcion` FROM ((`horas_extra` `he` join `usuarios` `u` on(`he`.`id_usuario` = `u`.`id`)) join `proyectos` `p` on(`he`.`id_proyecto` = `p`.`id`)) WHERE `he`.`estado` = 'aprobado' ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aprobaciones`
--
ALTER TABLE `aprobaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_horas_extra` (`id_horas_extra`),
  ADD KEY `id_aprobador` (`id_aprobador`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_clientes_nombre` (`nombre`);

--
-- Indices de la tabla `configuracion_tarifas`
--
ALTER TABLE `configuracion_tarifas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `horas_extra`
--
ALTER TABLE `horas_extra`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_aprobador` (`id_aprobador`),
  ADD KEY `idx_horas_extra_usuario` (`id_usuario`),
  ADD KEY `idx_horas_extra_proyecto` (`id_proyecto`),
  ADD KEY `idx_horas_extra_estado` (`estado`);

--
-- Indices de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_proyectos_cliente` (`id_cliente`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_usuarios_email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aprobaciones`
--
ALTER TABLE `aprobaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `configuracion_tarifas`
--
ALTER TABLE `configuracion_tarifas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `horas_extra`
--
ALTER TABLE `horas_extra`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `aprobaciones`
--
ALTER TABLE `aprobaciones`
  ADD CONSTRAINT `aprobaciones_ibfk_1` FOREIGN KEY (`id_horas_extra`) REFERENCES `horas_extra` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `aprobaciones_ibfk_2` FOREIGN KEY (`id_aprobador`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `configuracion_tarifas`
--
ALTER TABLE `configuracion_tarifas`
  ADD CONSTRAINT `configuracion_tarifas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `horas_extra`
--
ALTER TABLE `horas_extra`
  ADD CONSTRAINT `horas_extra_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `horas_extra_ibfk_2` FOREIGN KEY (`id_proyecto`) REFERENCES `proyectos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `horas_extra_ibfk_3` FOREIGN KEY (`id_aprobador`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD CONSTRAINT `proyectos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
