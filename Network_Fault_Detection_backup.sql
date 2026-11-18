-- MySQL dump 10.13  Distrib 8.4.11, for Win64 (x86_64)
--
-- Host: localhost    Database: Network_Fault_Detection
-- ------------------------------------------------------
-- Server version	8.4.11

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `Network_Fault_Detection`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `Network_Fault_Detection` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `Network_Fault_Detection`;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `alert_id` int NOT NULL AUTO_INCREMENT,
  `device_id` int DEFAULT NULL,
  `alert_time` datetime NOT NULL,
  `condition_name` varchar(150) NOT NULL,
  `severity` varchar(20) NOT NULL,
  `possible_affected_area` varchar(150) DEFAULT NULL,
  `explanation` text,
  `recommended_investigation` text,
  `alert_status` varchar(30) DEFAULT 'Active',
  PRIMARY KEY (`alert_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
INSERT INTO `alerts` VALUES (1,1,'2026-09-23 09:25:00','High latency','Medium','Possible affected network area','A possible abnormal network condition was detected. Latency: 220.0 ms — elevated. Further investigation is recommended.','Investigate the affected device and related network path.','Active'),(2,2,'2026-09-23 09:45:00','Unusual traffic','Medium','Possible affected network area','A possible abnormal network condition was detected. Total traffic: 67000.0 — unusually high. Further investigation is recommended.','Investigate the affected device and related network path.','Active'),(3,2,'2026-09-23 09:55:00','Multiple abnormal indicators','High','Possible affected network area','Multiple abnormal network indicators were detected. Latency: 230.0 ms — elevated; Packet loss: 14.0% — elevated; Total traffic: 78000.0 — unusually high. Further investigation is recommended.','Investigate the affected device and related network path.','Active');
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devices` (
  `device_id` int NOT NULL AUTO_INCREMENT,
  `device_name` varchar(100) DEFAULT NULL,
  `device_type` varchar(50) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES (1,'AP-01','Access Point','University Network','Normal','2026-10-04 16:13:34'),(2,'AP-02','Access Point','University Network','Normal','2026-10-04 16:39:43');
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `explanations`
--

DROP TABLE IF EXISTS `explanations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explanations` (
  `explanation_id` int NOT NULL AUTO_INCREMENT,
  `alert_id` int NOT NULL,
  `supporting_indicators` text,
  `explanation_text` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`explanation_id`),
  KEY `alert_id` (`alert_id`),
  CONSTRAINT `explanations_ibfk_1` FOREIGN KEY (`alert_id`) REFERENCES `alerts` (`alert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `explanations`
--

LOCK TABLES `explanations` WRITE;
/*!40000 ALTER TABLE `explanations` DISABLE KEYS */;
INSERT INTO `explanations` VALUES (1,1,'A possible abnormal network condition was detected. Latency: 220.0 ms — elevated. Further investigation is recommended.','A possible abnormal network condition was detected. Latency: 220.0 ms — elevated. Further investigation is recommended.','2026-10-04 20:59:00'),(2,2,'A possible abnormal network condition was detected. Total traffic: 67000.0 — unusually high. Further investigation is recommended.','A possible abnormal network condition was detected. Total traffic: 67000.0 — unusually high. Further investigation is recommended.','2026-10-04 20:59:00'),(3,3,'Multiple abnormal network indicators were detected. Latency: 230.0 ms — elevated; Packet loss: 14.0% — elevated; Total traffic: 78000.0 — unusually high. Further investigation is recommended.','Multiple abnormal network indicators were detected. Latency: 230.0 ms — elevated; Packet loss: 14.0% — elevated; Total traffic: 78000.0 — unusually high. Further investigation is recommended.','2026-10-04 20:59:00');
/*!40000 ALTER TABLE `explanations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `alert_id` int DEFAULT NULL,
  `event_type` varchar(100) DEFAULT NULL,
  `event_description` text,
  `event_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`history_id`),
  KEY `alert_id` (`alert_id`),
  CONSTRAINT `history_ibfk_1` FOREIGN KEY (`alert_id`) REFERENCES `alerts` (`alert_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
INSERT INTO `history` VALUES (1,1,'Alert Created','Medium severity alert created for High latency.','2026-10-04 21:08:08'),(2,2,'Alert Created','Medium severity alert created for Unusual traffic.','2026-10-04 21:08:08'),(3,3,'Alert Created','High severity alert created for High latency.','2026-10-04 21:08:08');
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networkdata`
--

DROP TABLE IF EXISTS `networkdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `networkdata` (
  `data_id` int NOT NULL AUTO_INCREMENT,
  `device_id` int DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `latency` float DEFAULT NULL,
  `packet_loss` float DEFAULT NULL,
  `data_sent` float DEFAULT NULL,
  `data_received` float DEFAULT NULL,
  `total_traffic` float DEFAULT NULL,
  `network_log` text,
  PRIMARY KEY (`data_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `networkdata_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networkdata`
--

LOCK TABLES `networkdata` WRITE;
/*!40000 ALTER TABLE `networkdata` DISABLE KEYS */;
INSERT INTO `networkdata` VALUES (1,1,'2026-09-23 09:00:00',25,0.2,1200,2500,3700,'Normal activity'),(2,1,'2026-09-23 09:05:00',28,0.3,1250,2600,3850,'Normal activity'),(3,1,'2026-09-23 09:10:00',30,0.4,1300,2700,4000,'Normal activity'),(4,1,'2026-09-23 09:25:00',220,0.5,1400,2900,4300,'Response time increased'),(5,1,'2026-09-23 09:35:00',35,12,1350,2700,4050,'Packet transmission loss increased'),(6,2,'2026-09-23 09:45:00',30,0.4,25000,42000,67000,'Unusual traffic volume'),(7,2,'2026-09-23 09:55:00',230,14,30000,48000,78000,'Multiple abnormal indicators observed');
/*!40000 ALTER TABLE `networkdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$argon2id$v=19$m=65536,t=3,p=4$gaWuw+De104KXdT8ZdXtLA$2yikkad507WyfVFVSJweQf5c50cnwQrRgHZMqASHVWM','IT Administrator','2026-10-07 10:51:49');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-09 22:23:03
