-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-05-2021 a las 21:37:16
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `speedmaxdb`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDataFromClient` (IN `id` INT)  BEGIN
	IF id > 0 THEN
    	SELECT datos_cliente.Id,`fullname`,`phone`,`email`,`adress`,locations.Location,paymentmethods.payment,package.packageName FROM 
datos_cliente INNER JOIN paymentmethods ON paymentmethods.Id = datos_cliente.paymentMethodId
INNER JOIN package ON datos_cliente.packageId = package.Id INNER JOIN locations ON datos_cliente.location = locations.Id WHERE datos_cliente.id = id;
    ELSE
    	SELECT datos_cliente.Id,`fullname`,`phone`,`email`,`adress`,locations.Location,paymentmethods.payment,package.packageName FROM 
datos_cliente INNER JOIN paymentmethods ON paymentmethods.Id = datos_cliente.paymentMethodId
INNER JOIN package ON datos_cliente.packageId = package.Id INNER JOIN locations ON datos_cliente.location = locations.Id;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getIdFromClient` (IN `Adress` VARCHAR(255))  SELECT datos_cliente.Id FROM datos_cliente WHERE datos_cliente.adress = Adress$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getLocations` ()  SELECT * FROM locations$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPackages` ()  SELECT * FROM package$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPaymentMethods` ()  SELECT * FROM paymentmethods$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPersonalData` (IN `id` INT)  NO SQL
SELECT * FROM datos_cliente WHERE datos_cliente.Id = id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datos_cliente`
--

CREATE TABLE `datos_cliente` (
  `Id` int(11) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `adress` varchar(255) NOT NULL,
  `location` int(255) NOT NULL,
  `packageId` int(11) NOT NULL,
  `paymentMethodId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `datos_cliente`
--

INSERT INTO `datos_cliente` (`Id`, `fullname`, `phone`, `email`, `adress`, `location`, `packageId`, `paymentMethodId`) VALUES
(127, 'Damian Debortoli', '1123999987', 'damiandebortolilb@gmail.com', 'Av. Pedro de mendoza 1727', 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invoicestatus`
--

CREATE TABLE `invoicestatus` (
  `ID` int(11) NOT NULL,
  `creationDate` date NOT NULL,
  `latePayment` int(11) NOT NULL,
  `lastPayment` date NOT NULL,
  `isOnline` tinyint(1) NOT NULL,
  `dischargeDate` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `invoicestatus`
--

INSERT INTO `invoicestatus` (`ID`, `creationDate`, `latePayment`, `lastPayment`, `isOnline`, `dischargeDate`) VALUES
(1, '2021-05-22', 0, '2021-05-22', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `locations`
--

CREATE TABLE `locations` (
  `Id` int(11) NOT NULL,
  `Location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `locations`
--

INSERT INTO `locations` (`Id`, `Location`) VALUES
(1, 'CABA'),
(2, 'GBA'),
(3, 'LA PLATA'),
(4, 'MDQ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `package`
--

CREATE TABLE `package` (
  `Id` int(11) NOT NULL,
  `packageName` varchar(255) NOT NULL,
  `cost` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `package`
--

INSERT INTO `package` (`Id`, `packageName`, `cost`) VALUES
(1, 'WIFI 50MB', 1500),
(2, 'WIFI 100MB', 2000),
(3, 'WIFI 500MB', 2500),
(4, 'WIFI 1000MB', 3000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paymentmethods`
--

CREATE TABLE `paymentmethods` (
  `Id` int(11) NOT NULL,
  `payment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `paymentmethods`
--

INSERT INTO `paymentmethods` (`Id`, `payment`) VALUES
(1, 'EFECTIVO'),
(2, 'TARJETA DE CREDITO'),
(3, 'TARJETA DE DEBITO'),
(4, 'DEBITO AUTOMATICO');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `datos_cliente`
--
ALTER TABLE `datos_cliente`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `invoicestatus`
--
ALTER TABLE `invoicestatus`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `package`
--
ALTER TABLE `package`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `paymentmethods`
--
ALTER TABLE `paymentmethods`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `datos_cliente`
--
ALTER TABLE `datos_cliente`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
