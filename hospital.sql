-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hospital_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `hn_id` int NOT NULL,
  `schedule_id` int NOT NULL,
  `bed_id` int DEFAULT NULL,
  `staff_id` int NOT NULL,
  `appointment_datetime` datetime NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `hn_id` (`hn_id`),
  KEY `schedule_id` (`schedule_id`),
  KEY `bed_id` (`bed_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`hn_id`) REFERENCES `patients` (`hn_id`),
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`schedule_id`) REFERENCES `doctor_schedules` (`schedule_id`),
  CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`bed_id`) REFERENCES `beds_rooms` (`bed_id`),
  CONSTRAINT `appointments_ibfk_4` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beds_rooms`
--

DROP TABLE IF EXISTS `beds_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beds_rooms` (
  `bed_id` int NOT NULL AUTO_INCREMENT,
  `ward_id` int NOT NULL,
  `room_type_id` int NOT NULL,
  `bed_number` varchar(50) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`bed_id`),
  KEY `ward_id` (`ward_id`),
  KEY `room_type_id` (`room_type_id`),
  CONSTRAINT `beds_rooms_ibfk_1` FOREIGN KEY (`ward_id`) REFERENCES `wards` (`ward_id`),
  CONSTRAINT `beds_rooms_ibfk_2` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beds_rooms`
--

LOCK TABLES `beds_rooms` WRITE;
/*!40000 ALTER TABLE `beds_rooms` DISABLE KEYS */;
INSERT INTO `beds_rooms` VALUES (1,1,1,'A001','Available'),(2,1,1,'A002','Occupied'),(3,1,2,'A003','Available'),(4,2,3,'B001','Available');
/*!40000 ALTER TABLE `beds_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buildings`
--

DROP TABLE IF EXISTS `buildings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buildings` (
  `building_id` int NOT NULL AUTO_INCREMENT,
  `building_name` varchar(100) NOT NULL,
  `location_zone` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`building_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buildings`
--

LOCK TABLES `buildings` WRITE;
/*!40000 ALTER TABLE `buildings` DISABLE KEYS */;
INSERT INTO `buildings` VALUES (1,'Main Building','Zone A'),(2,'Emergency Building','Zone B');
/*!40000 ALTER TABLE `buildings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `building_id` int NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `phone_extension` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`building_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,1,'Cardiology','1001'),(2,1,'Neurology','1002');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_schedules`
--

DROP TABLE IF EXISTS `doctor_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_schedules` (
  `schedule_id` int NOT NULL AUTO_INCREMENT,
  `staff_id` int NOT NULL,
  `department_id` int NOT NULL,
  `shift_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`schedule_id`),
  KEY `staff_id` (`staff_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `doctor_schedules_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`staff_id`),
  CONSTRAINT `doctor_schedules_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_schedules`
--

LOCK TABLES `doctor_schedules` WRITE;
/*!40000 ALTER TABLE `doctor_schedules` DISABLE KEYS */;
INSERT INTO `doctor_schedules` VALUES (1,1,1,'2026-10-05','09:00:00','12:00:00'),(2,1,2,'2026-10-06','13:00:00','16:00:00');
/*!40000 ALTER TABLE `doctor_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `hn_id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(30) DEFAULT NULL,
  `personal_id` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  PRIMARY KEY (`hn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,'John','Smith','john@gmail.com','1234','0812345678','1100100012345','2000-05-10'),(2,'Jane','Doe','jane@gmail.com','1234','0898765432','1100100012346','1999-08-20');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `appointment_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_datetime` datetime DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `billing_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `appointment_id` (`appointment_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_type`
--

DROP TABLE IF EXISTS `room_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_type` (
  `room_type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(100) NOT NULL,
  `daily_rate` decimal(10,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`room_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_type`
--

LOCK TABLES `room_type` WRITE;
/*!40000 ALTER TABLE `room_type` DISABLE KEYS */;
INSERT INTO `room_type` VALUES (1,'General Ward',1000.00,'Standard room'),(2,'Private Room',3000.00,'Private patient room'),(3,'VIP Room',5000.00,'VIP patient room');
/*!40000 ALTER TABLE `room_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staffs`
--

DROP TABLE IF EXISTS `staffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staffs` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `staff_username` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(30) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `medical_license_no` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `staff_username` (`staff_username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staffs`
--

LOCK TABLES `staffs` WRITE;
/*!40000 ALTER TABLE `staffs` DISABLE KEYS */;
INSERT INTO `staffs` VALUES (1,'Robert','Wilson','dr_robert','1234','0811111111','Doctor','MED001'),(2,'Sarah','Lee','nurse_sarah','1234','0822222222','Nurse',NULL);
/*!40000 ALTER TABLE `staffs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wards`
--

DROP TABLE IF EXISTS `wards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wards` (
  `ward_id` int NOT NULL AUTO_INCREMENT,
  `building_id` int NOT NULL,
  `ward_name` varchar(100) NOT NULL,
  `floor_number` int DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  PRIMARY KEY (`ward_id`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `wards_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`building_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wards`
--

LOCK TABLES `wards` WRITE;
/*!40000 ALTER TABLE `wards` DISABLE KEYS */;
INSERT INTO `wards` VALUES (1,1,'General Ward A',2,30),(2,1,'General Ward B',3,20);
/*!40000 ALTER TABLE `wards` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-11 13:24:11
