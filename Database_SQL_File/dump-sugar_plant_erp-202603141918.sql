-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: sugar_plant_erp
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `chemical_consumption_log`
--

DROP TABLE IF EXISTS `chemical_consumption_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chemical_consumption_log` (
  `consumption_id` int NOT NULL AUTO_INCREMENT,
  `sample_date` date NOT NULL,
  `material_id` int NOT NULL,
  `volume_consumed` decimal(10,3) DEFAULT NULL,
  PRIMARY KEY (`consumption_id`),
  KEY `material_id` (`material_id`),
  CONSTRAINT `chemical_consumption_log_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `material_master` (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chemical_consumption_log`
--

LOCK TABLES `chemical_consumption_log` WRITE;
/*!40000 ALTER TABLE `chemical_consumption_log` DISABLE KEYS */;
INSERT INTO `chemical_consumption_log` VALUES (1,'2025-11-01',1,450.500),(2,'2025-11-01',2,12.300),(3,'2025-11-02',1,460.000),(4,'2025-11-02',4,85.200),(5,'2025-11-03',3,30.000),(6,'2025-11-03',1,440.000),(7,'2025-11-04',2,15.000),(8,'2025-11-04',4,90.000),(9,'2025-11-05',1,480.000),(10,'2025-11-05',3,35.500),(11,'2025-11-01',1,450.500),(12,'2025-11-01',2,12.300),(13,'2025-11-02',1,460.000),(14,'2025-11-02',4,85.200),(15,'2025-11-03',3,30.000),(16,'2025-11-03',1,440.000),(17,'2025-11-04',2,15.000),(18,'2025-11-04',4,90.000),(19,'2025-11-05',1,480.000),(20,'2025-11-05',3,35.500);
/*!40000 ALTER TABLE `chemical_consumption_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_analysis_log`
--

DROP TABLE IF EXISTS `daily_analysis_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_analysis_log` (
  `analysis_date` date NOT NULL,
  `working_hours` decimal(5,2) DEFAULT NULL,
  `hours_lost_mechanical` decimal(5,2) DEFAULT NULL,
  `filter_cake_weight_mt` decimal(10,3) DEFAULT NULL,
  `condenser_inlet_temp` decimal(5,2) DEFAULT NULL,
  `condenser_outlet_temp` decimal(5,2) DEFAULT NULL,
  `undetermined_losses_pct` decimal(5,2) DEFAULT NULL,
  `bagasse_pol_pct` decimal(5,2) DEFAULT NULL,
  `bagasse_moisture_pct` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`analysis_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_analysis_log`
--

LOCK TABLES `daily_analysis_log` WRITE;
/*!40000 ALTER TABLE `daily_analysis_log` DISABLE KEYS */;
INSERT INTO `daily_analysis_log` VALUES ('2025-11-01',22.50,1.00,120.500,32.50,45.00,0.12,2.15,49.50),('2025-11-02',23.00,0.50,125.000,33.00,46.00,0.10,2.10,49.00),('2025-11-03',21.00,2.00,115.400,31.00,44.50,0.15,2.20,50.00),('2025-11-04',24.00,0.00,130.200,34.00,47.00,0.09,2.05,48.50),('2025-11-05',23.50,0.00,128.000,33.50,46.50,0.11,2.08,48.80),('2025-11-06',20.00,3.50,110.000,30.50,43.00,0.18,2.25,51.00),('2025-11-07',24.00,0.00,135.000,34.50,48.00,0.08,1.95,47.50),('2025-11-08',22.00,1.50,122.000,32.00,45.50,0.13,2.12,49.20),('2025-11-09',21.50,2.00,118.000,31.50,44.80,0.14,2.18,49.80),('2025-11-10',23.80,0.00,132.000,33.80,47.20,0.10,2.02,48.20);
/*!40000 ALTER TABLE `daily_analysis_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_crushing_log`
--

DROP TABLE IF EXISTS `daily_crushing_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_crushing_log` (
  `crush_date` date NOT NULL,
  `season_year` varchar(10) NOT NULL,
  `crop_day` int DEFAULT NULL,
  `cane_crushed_today` decimal(12,3) DEFAULT NULL,
  `sugar_produced_today` decimal(12,3) DEFAULT NULL,
  `recovery_percent_today` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`crush_date`),
  KEY `season_year` (`season_year`),
  CONSTRAINT `daily_crushing_log_ibfk_1` FOREIGN KEY (`season_year`) REFERENCES `factory_season_master` (`season_year`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_crushing_log`
--

LOCK TABLES `daily_crushing_log` WRITE;
/*!40000 ALTER TABLE `daily_crushing_log` DISABLE KEYS */;
INSERT INTO `daily_crushing_log` VALUES ('2025-11-01','2025-2026',1,3200.500,310.200,9.69),('2025-11-02','2025-2026',2,3350.750,325.400,9.71),('2025-11-03','2025-2026',3,3100.000,305.150,9.84),('2025-11-04','2025-2026',4,3400.250,342.800,10.08),('2025-11-05','2025-2026',5,3500.000,360.500,10.30),('2025-11-06','2025-2026',6,2900.400,295.200,10.18),('2025-11-07','2025-2026',7,3450.600,362.100,10.50),('2025-11-08','2025-2026',8,3300.000,350.000,10.61),('2025-11-09','2025-2026',9,3150.800,335.250,10.64),('2025-11-10','2025-2026',10,3400.000,370.400,10.89),('2026-03-13','2025-2026',1,0.000,0.000,0.00),('2026-03-14','2025-2026',1,100.000,50.000,50.00);
/*!40000 ALTER TABLE `daily_crushing_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_stoppage_log`
--

DROP TABLE IF EXISTS `daily_stoppage_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_stoppage_log` (
  `stoppage_id` int NOT NULL AUTO_INCREMENT,
  `stoppage_date` date NOT NULL,
  `reason_code` varchar(20) NOT NULL,
  `total_hours` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`stoppage_id`),
  KEY `reason_code` (`reason_code`),
  CONSTRAINT `daily_stoppage_log_ibfk_1` FOREIGN KEY (`reason_code`) REFERENCES `stoppage_reason_master` (`reason_code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_stoppage_log`
--

LOCK TABLES `daily_stoppage_log` WRITE;
/*!40000 ALTER TABLE `daily_stoppage_log` DISABLE KEYS */;
INSERT INTO `daily_stoppage_log` VALUES (1,'2025-11-01','M01',1.00),(2,'2025-11-02','E01',0.50),(3,'2025-11-03','M01',2.00),(4,'2025-11-06','P01',3.50),(5,'2025-11-08','M01',1.50),(6,'2025-11-09','E01',2.00),(7,'2025-11-11','P01',0.75),(8,'2025-11-12','M01',1.25),(9,'2025-11-13','E01',0.45),(10,'2025-11-15','M01',3.00);
/*!40000 ALTER TABLE `daily_stoppage_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factory_season_master`
--

DROP TABLE IF EXISTS `factory_season_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factory_season_master` (
  `season_year` varchar(10) NOT NULL,
  `start_date` date DEFAULT NULL,
  `factory_name` varchar(150) DEFAULT NULL,
  `installed_capacity_tcd` decimal(10,2) DEFAULT NULL,
  `gst_no` varchar(50) DEFAULT NULL,
  `managing_director` varchar(100) DEFAULT NULL,
  `chief_chemist` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`season_year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factory_season_master`
--

LOCK TABLES `factory_season_master` WRITE;
/*!40000 ALTER TABLE `factory_season_master` DISABLE KEYS */;
INSERT INTO `factory_season_master` VALUES ('2020-2021','2020-11-01','Shri Chhatrapati S.S.K. Ltd',3500.00,NULL,NULL,NULL),('2021-2022','2021-10-25','Shri Chhatrapati S.S.K. Ltd',3500.00,NULL,NULL,NULL),('2022-2023','2022-10-20','Shri Chhatrapati S.S.K. Ltd',3500.00,NULL,NULL,NULL),('2023-2024','2023-11-05','Shri Chhatrapati S.S.K. Ltd',3500.00,NULL,NULL,NULL),('2024-2025','2024-10-30','Shri Chhatrapati S.S.K. Ltd',3500.00,NULL,NULL,NULL),('2025-2026','2025-10-15','Shri Chhatrapati S.S.K. Ltd',3500.00,NULL,NULL,NULL);
/*!40000 ALTER TABLE `factory_season_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_master`
--

DROP TABLE IF EXISTS `material_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_master` (
  `material_id` int NOT NULL,
  `material_name` varchar(100) NOT NULL,
  `category` varchar(50) NOT NULL,
  `unit_of_measure` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_master`
--

LOCK TABLES `material_master` WRITE;
/*!40000 ALTER TABLE `material_master` DISABLE KEYS */;
INSERT INTO `material_master` VALUES (1,'Lime Process','CHEMICAL','Kg'),(2,'Phosphoric Acid','CHEMICAL','Litre'),(3,'Caustic Soda','CHEMICAL','Kg'),(4,'Sulphur','CHEMICAL','Kg'),(101,'Clear Juice','IN_PROCESS','HL'),(102,'Unsulphited Syrup','IN_PROCESS','HL'),(103,'A-Massecuite','IN_PROCESS','HL'),(104,'B-Massecuite','IN_PROCESS','HL'),(201,'L-30 Sugar','SUGAR','Qtls'),(202,'M-30 Sugar','SUGAR','Qtls'),(203,'Final Molasses','BY_PRODUCT','MT'),(204,'Bagasse','BY_PRODUCT','MT');
/*!40000 ALTER TABLE `material_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_stock_log`
--

DROP TABLE IF EXISTS `material_stock_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_stock_log` (
  `stock_id` int NOT NULL AUTO_INCREMENT,
  `sample_date` date NOT NULL,
  `report_type` varchar(20) NOT NULL,
  `material_id` int NOT NULL,
  `quantity_qtls` decimal(12,3) DEFAULT '0.000',
  `volume_hl` decimal(12,3) DEFAULT '0.000',
  `specific_gravity` decimal(6,3) DEFAULT '1.000',
  `brix_percent` decimal(6,2) DEFAULT NULL,
  `pol_percent` decimal(6,2) DEFAULT NULL,
  `purity_percent` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`stock_id`),
  KEY `material_id` (`material_id`),
  CONSTRAINT `material_stock_log_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `material_master` (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_stock_log`
--

LOCK TABLES `material_stock_log` WRITE;
/*!40000 ALTER TABLE `material_stock_log` DISABLE KEYS */;
INSERT INTO `material_stock_log` VALUES (1,'2025-11-01','DAILY',101,0.000,450.000,1.065,15.50,13.20,85.16),(2,'2025-11-01','DAILY',201,1200.000,0.000,1.000,0.00,0.00,0.00),(3,'2025-11-02','DAILY',102,0.000,320.000,1.285,58.40,48.50,83.05),(4,'2025-11-02','DAILY',202,2500.000,0.000,1.000,0.00,0.00,0.00),(5,'2025-11-03','RUN',103,0.000,150.000,1.480,92.50,78.20,84.54),(6,'2025-11-04','RUN',104,0.000,180.000,1.495,95.00,60.50,63.68),(7,'2025-11-05','RT7C',203,850.450,0.000,1.450,86.20,32.10,37.24),(8,'2025-11-06','DAILY',204,4500.000,0.000,1.000,0.00,0.00,0.00),(9,'2025-11-07','DAILY',101,0.000,480.000,1.068,16.20,14.10,87.04),(10,'2025-11-08','RUN',102,0.000,350.000,1.290,60.10,50.20,83.53);
/*!40000 ALTER TABLE `material_stock_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rt8c_technical_performance`
--

DROP TABLE IF EXISTS `rt8c_technical_performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rt8c_technical_performance` (
  `report_date` date NOT NULL,
  `season_year` varchar(10) NOT NULL,
  `yield_adsali` decimal(8,2) DEFAULT NULL,
  `yield_plant` decimal(8,2) DEFAULT NULL,
  `yield_ratoon` decimal(8,2) DEFAULT NULL,
  `prep_index` decimal(5,2) DEFAULT NULL,
  `bagasse_pct_cane` decimal(5,2) DEFAULT NULL,
  `bagasse_opening_bal` decimal(12,3) DEFAULT NULL,
  `bagasse_production` decimal(12,3) DEFAULT NULL,
  `bagasse_used_boiler` decimal(12,3) DEFAULT NULL,
  `bagasse_used_cogen` decimal(12,3) DEFAULT NULL,
  `electricity_generated_kwh` int DEFAULT NULL,
  PRIMARY KEY (`report_date`),
  KEY `season_year` (`season_year`),
  CONSTRAINT `rt8c_technical_performance_ibfk_1` FOREIGN KEY (`season_year`) REFERENCES `factory_season_master` (`season_year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rt8c_technical_performance`
--

LOCK TABLES `rt8c_technical_performance` WRITE;
/*!40000 ALTER TABLE `rt8c_technical_performance` DISABLE KEYS */;
INSERT INTO `rt8c_technical_performance` VALUES ('2020-11-30','2020-2021',90.00,83.50,70.50,78.90,30.50,350.000,21500.000,20000.000,1500.000,110000),('2021-11-30','2021-2022',93.20,87.10,73.50,81.80,28.50,380.000,24800.000,21800.000,2900.000,123000),('2022-11-30','2022-2023',91.50,84.00,71.00,79.50,30.10,420.000,22800.000,20500.000,2300.000,115000),('2023-11-30','2023-2024',94.00,86.50,74.00,81.20,28.80,400.000,24200.000,21500.000,2800.000,122000),('2024-11-30','2024-2025',92.10,85.00,72.00,80.00,29.50,450.000,23500.000,21000.000,2500.000,118000),('2025-11-30','2025-2026',95.50,88.20,75.40,82.50,28.10,500.000,25000.000,22000.000,3000.000,125000);
/*!40000 ALTER TABLE `rt8c_technical_performance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stoppage_reason_master`
--

DROP TABLE IF EXISTS `stoppage_reason_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stoppage_reason_master` (
  `reason_code` varchar(20) NOT NULL,
  `category_code` varchar(50) DEFAULT NULL,
  `description_eng` varchar(150) DEFAULT NULL,
  `description_mar` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`reason_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stoppage_reason_master`
--

LOCK TABLES `stoppage_reason_master` WRITE;
/*!40000 ALTER TABLE `stoppage_reason_master` DISABLE KEYS */;
INSERT INTO `stoppage_reason_master` VALUES ('E01','ELECTRICAL','Power Failure (Grid)','वीज पुरवठा खंडित'),('M01','MECHANICAL','Donally Chute Jam','डोनोली च्युट जाम'),('P01','PROCESS','Evaporator Cleaning','इव्हॅपोरेटर स्वच्छता');
/*!40000 ALTER TABLE `stoppage_reason_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'CHEMIST',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','admin123','ADMIN','2026-03-13 10:24:58'),(2,'rohit','rohit','ADMIN','2026-03-14 13:40:45'),(3,'shubham','shubham','CHEMIST','2026-03-14 13:40:45'),(4,'chemist_2','chem99','CHEMIST','2026-03-14 13:40:45'),(5,'lab_incharge','lab_secure','ADMIN','2026-03-14 13:40:45'),(6,'md_office','md_top','ADMIN','2026-03-14 13:40:45'),(7,'engineer_1','eng1','CHEMIST','2026-03-14 13:40:45'),(8,'store_1','store123','CHEMIST','2026-03-14 13:40:45'),(9,'guest_user','guest','CHEMIST','2026-03-14 13:40:45'),(10,'root_admin','root','ADMIN','2026-03-14 13:40:45'),(11,'test_user','test','CHEMIST','2026-03-14 13:40:45');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'sugar_plant_erp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-14 19:18:03
