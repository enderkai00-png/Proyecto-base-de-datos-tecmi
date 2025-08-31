CREATE DATABASE  IF NOT EXISTS `app_medica` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `app_medica`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: app_medica
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `citas`
--

DROP TABLE IF EXISTS `citas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citas` (
  `id_cita` int NOT NULL AUTO_INCREMENT,
  `id_paciente` int NOT NULL,
  `id_medico` int NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado` enum('Pendiente','Confirmada','Cancelada') DEFAULT 'Pendiente',
  PRIMARY KEY (`id_cita`),
  KEY `id_paciente` (`id_paciente`),
  KEY `id_medico` (`id_medico`),
  CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`),
  CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`id_medico`) REFERENCES `medicos` (`id_medico`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citas`
--

LOCK TABLES `citas` WRITE;
/*!40000 ALTER TABLE `citas` DISABLE KEYS */;
INSERT INTO `citas` VALUES (1,1,1,'2025-08-30','09:00:00','Confirmada'),(2,2,2,'2025-08-30','10:30:00','Pendiente'),(3,3,3,'2025-08-31','11:00:00','Confirmada'),(4,4,4,'2025-09-01','12:00:00','Cancelada'),(5,5,5,'2025-09-01','14:30:00','Pendiente'),(6,6,6,'2025-09-02','09:15:00','Pendiente'),(7,7,7,'2025-09-02','10:45:00','Confirmada'),(8,8,8,'2025-09-03','11:30:00','Pendiente'),(9,9,9,'2025-09-03','12:45:00','Confirmada'),(10,10,10,'2025-09-04','15:00:00','Pendiente');
/*!40000 ALTER TABLE `citas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especialidades`
--

DROP TABLE IF EXISTS `especialidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especialidades` (
  `id_especialidad` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_especialidad`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especialidades`
--

LOCK TABLES `especialidades` WRITE;
/*!40000 ALTER TABLE `especialidades` DISABLE KEYS */;
INSERT INTO `especialidades` VALUES (1,'Cardiología','Especialidad del corazón'),(2,'Pediatría','Atención médica de niños'),(3,'Dermatología','Tratamiento de la piel'),(4,'Neurología','Enfermedades del sistema nervioso'),(5,'Ginecología','Salud reproductiva femenina'),(6,'Oftalmología','Tratamiento de enfermedades oculares'),(7,'Ortopedia','Tratamiento de huesos y articulaciones'),(8,'Psiquiatría','Atención de trastornos mentales'),(9,'Endocrinología','Trastornos hormonales y metabólicos'),(10,'Oncología','Diagnóstico y tratamiento del cáncer');
/*!40000 ALTER TABLE `especialidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicos`
--

DROP TABLE IF EXISTS `medicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicos` (
  `id_medico` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `ap_paterno` varchar(50) NOT NULL,
  `ap_materno` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `id_especialidad` int NOT NULL,
  PRIMARY KEY (`id_medico`),
  UNIQUE KEY `email` (`email`),
  KEY `id_especialidad` (`id_especialidad`),
  CONSTRAINT `medicos_ibfk_1` FOREIGN KEY (`id_especialidad`) REFERENCES `especialidades` (`id_especialidad`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicos`
--

LOCK TABLES `medicos` WRITE;
/*!40000 ALTER TABLE `medicos` DISABLE KEYS */;
INSERT INTO `medicos` VALUES (1,'Carlos','Ruiz','Fernández','555111111','carlos.ruiz@medico.com',1),(2,'Laura','Mendoza','Ortega','555222222','laura.mendoza@medico.com',2),(3,'José','Morales','Castro','555333333','jose.morales@medico.com',3),(4,'Elena','Soto','Ramirez','555444444','elena.soto@medico.com',4),(5,'Ricardo','Vega','Campos','555555555','ricardo.vega@medico.com',5),(6,'Patricia','Reyes','Moreno','555666111','patricia.reyes@medico.com',6),(7,'Andrés','Domínguez','Flores','555777222','andres.dominguez@medico.com',7),(8,'Claudia','Núñez','García','555888333','claudia.nunez@medico.com',8),(9,'Héctor','Rojas','Martínez','555999444','hector.rojas@medico.com',9),(10,'Gabriela','Cruz','Fernández','555000555','gabriela.cruz@medico.com',10);
/*!40000 ALTER TABLE `medicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pacientes`
--

DROP TABLE IF EXISTS `pacientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pacientes` (
  `id_paciente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `ap_paterno` varchar(50) NOT NULL,
  `ap_materno` varchar(50) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `genero` enum('M','F') DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_paciente`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pacientes`
--

LOCK TABLES `pacientes` WRITE;
/*!40000 ALTER TABLE `pacientes` DISABLE KEYS */;
INSERT INTO `pacientes` VALUES (1,'Juan','Pérez','Lopez','1990-05-10','M','555123456','juanperez@email.com'),(2,'María','García','Martínez','1985-02-20','F','555987654','maria.garcia@email.com'),(3,'Luis','Hernández','Torres','2000-07-12','M','555654321','luisht@email.com'),(4,'Ana','Ramírez','Díaz','1995-09-25','F','555321987','ana.rdz@email.com'),(5,'Pedro','Sánchez','Flores','1988-11-30','M','555111222','pedrosf@email.com'),(6,'Sofía','López','Ramírez','1993-03-15','F','555666777','sofia.lopez@email.com'),(7,'Miguel','Torres','Hernández','1980-06-10','M','555777888','miguel.torres@email.com'),(8,'Camila','Gómez','Ruiz','2002-01-05','F','555888999','camila.gomez@email.com'),(9,'Javier','Martínez','Castillo','1998-12-20','M','555999000','javier.mtz@email.com'),(10,'Fernanda','Vargas','Santos','1991-04-18','F','555000111','fernanda.vs@email.com');
/*!40000 ALTER TABLE `pacientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) NOT NULL,
  `contrasena` varchar(100) NOT NULL,
  `tipo_usuario` enum('paciente','medico','admin') NOT NULL,
  `id_paciente` int DEFAULT NULL,
  `id_medico` int DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `usuario` (`usuario`),
  KEY `id_paciente` (`id_paciente`),
  KEY `id_medico` (`id_medico`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`),
  CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`id_medico`) REFERENCES `medicos` (`id_medico`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'juanp','12345','paciente',1,NULL),(2,'maria_g','12345','paciente',2,NULL),(3,'carlosr','12345','medico',NULL,1),(4,'lauram','12345','medico',NULL,2),(5,'admin','admin123','admin',NULL,NULL),(6,'sofia_l','clave123','paciente',6,NULL),(7,'miguel_t','clave123','paciente',7,NULL),(8,'camila_g','clave123','paciente',8,NULL),(9,'javier_m','clave123','paciente',9,NULL),(10,'fernanda_v','clave123','paciente',10,NULL),(11,'patricia_r','clave123','medico',NULL,6),(12,'andres_d','clave123','medico',NULL,7),(13,'claudia_n','clave123','medico',NULL,8),(14,'hector_r','clave123','medico',NULL,9),(15,'gabriela_c','clave123','medico',NULL,10);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-29 14:21:27
