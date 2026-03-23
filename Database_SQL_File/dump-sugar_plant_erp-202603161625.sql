-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
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
  `volume_consumed` decimal(12,3) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`consumption_id`),
  UNIQUE KEY `uk_date_material` (`sample_date`,`material_id`),
  KEY `fk_chem_material_id` (`material_id`),
  CONSTRAINT `fk_chem_material_id` FOREIGN KEY (`material_id`) REFERENCES `material_master` (`material_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chemical_consumption_log`
--

LOCK TABLES `chemical_consumption_log` WRITE;
/*!40000 ALTER TABLE `chemical_consumption_log` DISABLE KEYS */;
INSERT INTO `chemical_consumption_log` VALUES (1,'2026-03-17',109,11.000),(2,'2026-03-17',102,11.000),(3,'2026-03-17',107,11.000),(4,'2026-03-17',108,11.000),(5,'2026-03-17',104,11.000),(6,'2026-03-17',100,11.000),(7,'2026-03-17',101,11.000),(8,'2026-03-17',106,11.000),(9,'2026-03-17',103,11.000),(10,'2026-03-17',105,11.000);
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
  `season_year` varchar(15) NOT NULL,
  `crop_day` int DEFAULT NULL,
  `member_cane_crushed_mt` decimal(12,3) DEFAULT '0.000',
  `non_member_cane_crushed_mt` decimal(12,3) DEFAULT '0.000',
  `other_cane_crushed_mt` decimal(12,3) DEFAULT '0.000',
  `cane_crushed_today` decimal(12,3) DEFAULT '0.000',
  `sugar_produced_today` decimal(12,3) DEFAULT '0.000',
  `recovery_percent_today` decimal(6,3) DEFAULT '0.000',
  `filter_cake_weight_mt` decimal(12,3) DEFAULT '0.000',
  `condenser_inlet_temp` decimal(5,2) DEFAULT '0.00',
  `condenser_outlet_temp` decimal(5,2) DEFAULT '0.00',
  `mixed_juice_tanks` int DEFAULT '0',
  `mixed_juice_weight` decimal(12,3) DEFAULT '0.000',
  `added_water_tanks` int DEFAULT '0',
  `added_water_weight` decimal(12,3) DEFAULT '0.000',
  `final_molasses_tanks` int DEFAULT '0',
  `final_molasses_weight` decimal(12,3) DEFAULT '0.000',
  `dirt_correction_pct` decimal(6,3) DEFAULT '0.000',
  `recovery_correction_pct` decimal(6,3) DEFAULT '0.000',
  `undetermined_losses_pct` decimal(6,3) DEFAULT '0.000',
  `mill_ext_today` decimal(10,2) DEFAULT '0.00',
  `reduced_ext_today` decimal(10,2) DEFAULT '0.00',
  `mill_start_today` varchar(50) DEFAULT NULL,
  `cogen_export_today` decimal(15,3) DEFAULT '0.000',
  PRIMARY KEY (`crush_date`),
  KEY `season_year` (`season_year`),
  CONSTRAINT `fk_crushing_season` FOREIGN KEY (`season_year`) REFERENCES `factory_season_master` (`season_year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_crushing_log`
--

LOCK TABLES `daily_crushing_log` WRITE;
/*!40000 ALTER TABLE `daily_crushing_log` DISABLE KEYS */;
INSERT INTO `daily_crushing_log` VALUES ('2024-10-24','2025-2026',NULL,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.00,0.00,0,0.000,0,0.000,0,0.000,0.000,0.000,0.000,0.00,0.00,NULL,0.000),('2025-10-15','2025-2026',NULL,2850.500,650.000,0.000,0.000,0.000,0.000,102.300,32.50,48.20,0,0.000,0,0.000,0,0.000,0.020,0.010,0.120,0.00,0.00,NULL,0.000),('2025-10-16','2025-2026',NULL,2900.000,700.000,0.000,0.000,0.000,0.000,110.450,31.80,47.90,0,0.000,0,0.000,0,0.000,0.021,0.011,0.115,0.00,0.00,NULL,0.000),('2025-10-17','2025-2026',NULL,3100.250,450.000,0.000,0.000,0.000,0.000,115.000,33.10,49.50,0,0.000,0,0.000,0,0.000,0.019,0.010,0.130,0.00,0.00,NULL,0.000),('2025-10-18','2025-2026',NULL,3050.000,550.000,0.000,0.000,0.000,0.000,108.300,32.70,48.80,0,0.000,0,0.000,0,0.000,0.022,0.012,0.125,0.00,0.00,NULL,0.000),('2025-10-19','2025-2026',NULL,2750.000,850.000,0.000,0.000,0.000,0.000,98.600,31.50,46.50,0,0.000,0,0.000,0,0.000,0.020,0.010,0.110,0.00,0.00,NULL,0.000),('2025-10-20','2025-2026',NULL,3200.000,350.000,0.000,0.000,0.000,0.000,120.100,34.20,51.00,0,0.000,0,0.000,0,0.000,0.025,0.015,0.140,0.00,0.00,NULL,0.000),('2025-10-21','2025-2026',NULL,3150.000,480.000,0.000,0.000,0.000,0.000,112.000,32.00,47.50,0,0.000,0,0.000,0,0.000,0.020,0.010,0.122,0.00,0.00,NULL,0.000),('2025-10-22','2025-2026',NULL,3000.500,520.000,0.000,0.000,0.000,0.000,107.500,31.00,46.20,0,0.000,0,0.000,0,0.000,0.021,0.011,0.118,0.00,0.00,NULL,0.000),('2025-10-23','2025-2026',NULL,2920.000,610.000,0.000,0.000,0.000,0.000,104.200,32.50,48.00,0,0.000,0,0.000,0,0.000,0.023,0.013,0.128,0.00,0.00,NULL,0.000),('2025-10-24','2025-2026',NULL,3350.000,250.000,0.000,0.000,0.000,0.000,125.400,33.50,50.10,0,0.000,0,0.000,0,0.000,0.020,0.010,0.135,0.00,0.00,NULL,0.000),('2026-03-17','2025-2026',NULL,NULL,NULL,0.000,0.000,0.000,0.000,NULL,NULL,NULL,0,0.000,0,0.000,0,0.000,NULL,NULL,NULL,0.00,0.00,NULL,0.000),('2026-03-18','2025-2026',22,0.000,0.000,0.000,1232.000,121.000,21.000,0.000,0.00,0.00,0,0.000,0,0.000,0,0.000,0.000,0.000,0.000,2.00,11.00,'12',222.000),('2026-03-20','2025-2026',NULL,0.000,0.000,0.000,0.000,0.000,0.000,74.320,38.00,41.00,5,0.000,2,0.000,6,0.000,0.420,0.000,0.000,0.00,0.00,NULL,0.000);
/*!40000 ALTER TABLE `daily_crushing_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_lab_analysis_details`
--

DROP TABLE IF EXISTS `daily_lab_analysis_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_lab_analysis_details` (
  `analysis_id` int NOT NULL AUTO_INCREMENT,
  `crush_date` date NOT NULL,
  `material_id` int NOT NULL,
  `brix_pct` decimal(8,3) DEFAULT NULL,
  `pol_pct` decimal(8,3) DEFAULT NULL,
  `purity_pct` decimal(8,3) DEFAULT NULL,
  `moisture_pct` decimal(8,3) DEFAULT NULL,
  PRIMARY KEY (`analysis_id`),
  UNIQUE KEY `unique_daily_material` (`crush_date`,`material_id`),
  KEY `fk_lab_material` (`material_id`),
  CONSTRAINT `fk_lab_date` FOREIGN KEY (`crush_date`) REFERENCES `daily_crushing_log` (`crush_date`) ON DELETE CASCADE,
  CONSTRAINT `fk_lab_material` FOREIGN KEY (`material_id`) REFERENCES `material_master` (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_lab_analysis_details`
--

LOCK TABLES `daily_lab_analysis_details` WRITE;
/*!40000 ALTER TABLE `daily_lab_analysis_details` DISABLE KEYS */;
INSERT INTO `daily_lab_analysis_details` VALUES (11,'2025-10-15',1,18.500,15.200,82.160,NULL),(12,'2025-10-15',2,15.100,12.400,82.110,NULL),(13,'2025-10-15',10,NULL,2.100,NULL,48.500),(14,'2025-10-16',1,18.800,15.500,82.440,NULL),(15,'2025-10-16',2,15.400,12.700,82.460,NULL),(16,'2025-10-16',10,NULL,2.050,NULL,48.200),(17,'2025-10-17',1,19.100,15.900,83.250,NULL),(18,'2025-10-18',1,18.900,15.700,83.070,NULL),(19,'2025-10-19',1,18.400,15.100,82.070,NULL),(20,'2025-10-20',1,19.500,16.300,83.590,NULL),(21,'2025-10-21',1,19.200,16.000,83.330,NULL),(22,'2025-10-22',1,18.700,15.400,82.350,NULL),(23,'2025-10-23',1,18.500,15.100,81.620,NULL),(24,'2025-10-24',1,19.600,16.500,84.180,NULL),(25,'2024-10-24',1,NULL,NULL,NULL,NULL),(26,'2024-10-24',2,NULL,NULL,NULL,NULL),(27,'2024-10-24',4,NULL,NULL,NULL,NULL),(28,'2024-10-24',9,NULL,NULL,NULL,NULL),(29,'2024-10-24',10,NULL,NULL,NULL,NULL),(30,'2026-03-17',1,5.000,5.000,100.000,NULL),(31,'2026-03-17',2,5.000,5.000,100.000,NULL),(32,'2026-03-17',4,5.000,5.000,100.000,NULL),(33,'2026-03-17',9,5.000,5.000,100.000,NULL),(34,'2026-03-17',10,NULL,5.000,NULL,5.000),(45,'2026-03-20',1,17.760,14.870,83.730,0.000),(46,'2026-03-20',2,11.640,9.510,81.700,0.000),(47,'2026-03-20',4,9.750,11.890,82.000,0.000),(48,'2026-03-20',121,53.490,43.990,82.230,0.000),(49,'2026-03-20',123,89.170,73.300,82.200,0.000),(50,'2026-03-20',9,85.000,27.200,32.000,0.000),(51,'2026-03-20',10,0.000,0.030,0.000,48.330),(52,'2026-03-20',11,0.000,3.920,0.000,0.000),(53,'2026-03-20',50,0.000,99.800,0.000,0.040);
/*!40000 ALTER TABLE `daily_lab_analysis_details` ENABLE KEYS */;
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
  `reason_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_hours` decimal(10,2) DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`stoppage_id`),
  KEY `fk_stoppage_reason` (`reason_code`),
  CONSTRAINT `fk_stoppage_reason` FOREIGN KEY (`reason_code`) REFERENCES `stoppage_reason_master` (`reason_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_stoppage_log`
--

LOCK TABLES `daily_stoppage_log` WRITE;
/*!40000 ALTER TABLE `daily_stoppage_log` DISABLE KEYS */;
INSERT INTO `daily_stoppage_log` VALUES (1,'2026-03-18','DEBUG_101',1.50,'2026-03-18 11:33:26'),(2,'2026-03-18','TEST_123',1.50,'2026-03-18 11:43:50');
/*!40000 ALTER TABLE `daily_stoppage_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_sugar_production`
--

DROP TABLE IF EXISTS `daily_sugar_production`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_sugar_production` (
  `production_id` int NOT NULL AUTO_INCREMENT,
  `crush_date` date NOT NULL,
  `material_id` int NOT NULL,
  `no_of_bags` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`production_id`),
  KEY `fk_prod_date` (`crush_date`),
  KEY `fk_prod_material` (`material_id`),
  CONSTRAINT `fk_prod_date` FOREIGN KEY (`crush_date`) REFERENCES `daily_crushing_log` (`crush_date`) ON DELETE CASCADE,
  CONSTRAINT `fk_prod_material` FOREIGN KEY (`material_id`) REFERENCES `material_master` (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_sugar_production`
--

LOCK TABLES `daily_sugar_production` WRITE;
/*!40000 ALTER TABLE `daily_sugar_production` DISABLE KEYS */;
INSERT INTO `daily_sugar_production` VALUES (1,'2025-10-15',50,1200),(2,'2025-10-15',51,800),(3,'2025-10-16',50,1250),(4,'2025-10-16',51,850),(5,'2025-10-17',50,1300),(6,'2025-10-17',51,900),(7,'2025-10-18',50,1280),(8,'2025-10-18',51,880),(9,'2025-10-19',50,1150),(10,'2025-10-19',51,750),(11,'2025-10-20',50,1400),(12,'2025-10-20',51,950),(13,'2025-10-21',50,1350),(14,'2025-10-21',51,920),(15,'2025-10-22',50,1280),(16,'2025-10-22',51,860),(17,'2025-10-23',50,1200),(18,'2025-10-23',51,800),(19,'2025-10-24',50,1450),(20,'2025-10-24',51,1000),(21,'2026-03-17',50,555),(22,'2026-03-17',51,55),(23,'2026-03-17',52,55),(24,'2026-03-17',53,55),(25,'2026-03-17',50,5),(26,'2026-03-17',51,5),(27,'2026-03-17',52,5),(28,'2026-03-17',53,5);
/*!40000 ALTER TABLE `daily_sugar_production` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_time_account`
--

DROP TABLE IF EXISTS `daily_time_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_time_account` (
  `crush_date` date NOT NULL,
  `working_hours` decimal(5,2) DEFAULT '0.00',
  `hours_lost_rain` decimal(5,2) DEFAULT '0.00',
  `hours_lost_mechanical` decimal(5,2) DEFAULT '0.00',
  `hours_lost_electrical` decimal(5,2) DEFAULT '0.00',
  `hours_lost_cane_shortage` decimal(5,2) DEFAULT '0.00',
  `hours_lost_cleaning` decimal(5,2) DEFAULT '0.00',
  `hours_lost_process` decimal(5,2) DEFAULT '0.00',
  `hours_lost_misc` decimal(5,2) DEFAULT '0.00',
  PRIMARY KEY (`crush_date`),
  CONSTRAINT `fk_time_date` FOREIGN KEY (`crush_date`) REFERENCES `daily_crushing_log` (`crush_date`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_time_account`
--

LOCK TABLES `daily_time_account` WRITE;
/*!40000 ALTER TABLE `daily_time_account` DISABLE KEYS */;
INSERT INTO `daily_time_account` VALUES ('2024-10-24',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00),('2025-10-15',22.50,0.00,1.00,0.50,0.00,0.00,0.00,0.00),('2025-10-16',24.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00),('2025-10-17',20.00,0.00,3.50,0.50,0.00,0.00,0.00,0.00),('2025-10-18',23.20,0.00,0.80,0.00,0.00,0.00,0.00,0.00),('2025-10-19',21.50,0.00,2.00,0.50,0.00,0.00,0.00,0.00),('2025-10-20',24.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00),('2025-10-21',23.00,0.00,1.00,0.00,0.00,0.00,0.00,0.00),('2025-10-22',24.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00),('2025-10-23',22.00,0.00,1.50,0.50,0.00,0.00,0.00,0.00),('2025-10-24',24.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00),('2026-03-17',NULL,0.00,NULL,NULL,0.00,0.00,0.00,0.00);
/*!40000 ALTER TABLE `daily_time_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factory_master`
--

DROP TABLE IF EXISTS `factory_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factory_master` (
  `season_year` varchar(15) NOT NULL,
  `start_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `factory_name` varchar(150) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `taluka` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `pin_code` varchar(10) DEFAULT NULL,
  `phone_no` varchar(20) DEFAULT NULL,
  `std_code` varchar(10) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `website` varchar(150) DEFAULT NULL,
  `clarification_process` varchar(100) DEFAULT NULL,
  `registration_no` varchar(50) DEFAULT NULL,
  `gst_no` varchar(50) DEFAULT NULL,
  `fssai_no` varchar(50) DEFAULT NULL,
  `commission_rate` decimal(10,2) DEFAULT NULL,
  `division` varchar(100) DEFAULT NULL,
  `range` varchar(100) DEFAULT NULL,
  `installed_capacity` decimal(10,2) DEFAULT NULL,
  `managing_director` varchar(100) DEFAULT NULL,
  `works_manager` varchar(100) DEFAULT NULL,
  `chief_chemist` varchar(100) DEFAULT NULL,
  `lab_incharge` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`season_year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factory_master`
--

LOCK TABLES `factory_master` WRITE;
/*!40000 ALTER TABLE `factory_master` DISABLE KEYS */;
INSERT INTO `factory_master` VALUES ('2025-2026','2025-10-15','09:00:00','Apex Sugar Mills','Plot 45, Industrial Area','Karad','Satara','Maharashtra','415110','224455','02164','contact@apexsugar.com','www.apexsugar.com','Double Sulphitation','REG1001','27AAACA1234A1Z1','10015022000123',5.50,'Pune','South',5000.00,'A.S. Deshmukh','R.P. Patil','S.K. Kulkarni','M.V. Joshi');
/*!40000 ALTER TABLE `factory_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factory_season_master`
--

DROP TABLE IF EXISTS `factory_season_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factory_season_master` (
  `season_year` varchar(15) NOT NULL,
  `start_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `factory_name` varchar(150) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `taluka` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `pin_code` varchar(20) DEFAULT NULL,
  `phone_no` varchar(50) DEFAULT NULL,
  `std_code` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(150) DEFAULT NULL,
  `clarification_process` varchar(100) DEFAULT NULL,
  `registration_no` varchar(100) DEFAULT NULL,
  `gst_no` varchar(50) DEFAULT NULL,
  `fssai_no` varchar(100) DEFAULT NULL,
  `commission_rate` decimal(8,2) DEFAULT NULL,
  `division` varchar(100) DEFAULT NULL,
  `range_area` varchar(100) DEFAULT NULL,
  `installed_capacity_tcd` decimal(10,2) DEFAULT NULL,
  `managing_director` varchar(100) DEFAULT NULL,
  `chief_chemist` varchar(100) DEFAULT NULL,
  `works_manager` varchar(100) DEFAULT NULL,
  `lab_incharge` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`season_year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factory_season_master`
--

LOCK TABLES `factory_season_master` WRITE;
/*!40000 ALTER TABLE `factory_season_master` DISABLE KEYS */;
INSERT INTO `factory_season_master` VALUES ('2021-2022',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3500.00,NULL,NULL,NULL,NULL),('2022-2023',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3500.00,NULL,NULL,NULL,NULL),('2023-2024',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3500.00,NULL,NULL,NULL,NULL),('2024-2025',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3500.00,NULL,NULL,NULL,NULL),('2025-2026','2025-10-15',NULL,'Shri.Chhatrapati S.S.K.Ltd, Bhavaninagar',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3500.00,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `factory_season_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_master`
--

DROP TABLE IF EXISTS `material_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_master` (
  `material_id` int NOT NULL AUTO_INCREMENT,
  `material_name` varchar(100) NOT NULL,
  `category` enum('CHEMICAL','IN_PROCESS','SUGAR_GRADE','BY_PRODUCT','FUEL','OLD_STOCK','RT7C_PARAM') NOT NULL,
  `unit_of_measure` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_master`
--

LOCK TABLES `material_master` WRITE;
/*!40000 ALTER TABLE `material_master` DISABLE KEYS */;
INSERT INTO `material_master` VALUES (1,'Primary Juice','IN_PROCESS','HL'),(2,'Mixed Juice','IN_PROCESS','HL'),(3,'Last Expressed Juice','IN_PROCESS','HL'),(4,'Clear Juice','IN_PROCESS','HL'),(5,'Unsulphured Syrup','IN_PROCESS','HL'),(6,'A-Massecuite','IN_PROCESS','HL'),(7,'B-Massecuite','IN_PROCESS','HL'),(8,'C-Massecuite','IN_PROCESS','HL'),(9,'Final Molasses','BY_PRODUCT','MT'),(10,'Bagasse','BY_PRODUCT','MT'),(11,'Filter Cake','BY_PRODUCT','MT'),(50,'L-30 (50 Kg)','SUGAR_GRADE','Bags'),(51,'M-30 (50 Kg)','SUGAR_GRADE','Bags'),(52,'S1-30 (50 Kg)','SUGAR_GRADE','Bags'),(53,'Raw Sugar (50 Kg)','SUGAR_GRADE','Bags'),(100,'Lime Process','CHEMICAL','Kg'),(101,'Phosphoric Acid','CHEMICAL','Litre'),(102,'Caustic Soda','CHEMICAL','Kg'),(103,'Sulphur','CHEMICAL','Kg'),(104,'Lime Powder','CHEMICAL','Kg'),(105,'Sulphur','CHEMICAL','Kg'),(106,'Phosphoric Acid','CHEMICAL','Litre'),(107,'Caustic Soda','CHEMICAL','Kg'),(108,'Flocculant','CHEMICAL','Kg'),(109,'Antiscalant','CHEMICAL','Kg'),(110,'L-30 Sugar (50kg)','SUGAR_GRADE','Bags'),(111,'M-30 Sugar (50kg)','SUGAR_GRADE','Bags'),(112,'S-30 Sugar (50kg)','SUGAR_GRADE','Bags'),(113,'Raw Sugar','SUGAR_GRADE','Bags'),(114,'A-Massecuite','IN_PROCESS','HL'),(115,'B-Massecuite','IN_PROCESS','HL'),(116,'C-Massecuite','IN_PROCESS','HL'),(117,'Final Molasses Stock','IN_PROCESS','MT'),(118,'Clear Juice Stock','IN_PROCESS','HL'),(119,'Syrup Stock','IN_PROCESS','HL'),(120,'Clear Juice','IN_PROCESS','HL'),(121,'Syrup','IN_PROCESS','HL'),(122,'Unsulphited Syrup','IN_PROCESS','HL'),(123,'A - Massecuite','IN_PROCESS','HL'),(124,'B - Massecuite','IN_PROCESS','HL'),(125,'C - Massecuite','IN_PROCESS','HL'),(126,'Other - Massecuite','IN_PROCESS','HL'),(127,'A - Light - Molasses','IN_PROCESS','HL'),(128,'B - Light - Molasses','IN_PROCESS','HL'),(129,'C - Light - Molasses','IN_PROCESS','HL'),(130,'Other - Light - Molasses','IN_PROCESS','HL'),(131,'A - Heavy - Molasses','IN_PROCESS','HL'),(132,'B - Heavy - Molasses','IN_PROCESS','HL'),(133,'Other - Heavy - Molasses','IN_PROCESS','HL'),(134,'C - seed','IN_PROCESS','HL'),(135,'B - seed','IN_PROCESS','HL'),(136,'Dry seed','IN_PROCESS','HL'),(137,'C - Grain','IN_PROCESS','HL'),(138,'B - Grain','IN_PROCESS','HL'),(139,'Other - Molasses','IN_PROCESS','HL'),(140,'B - After - Worker','IN_PROCESS','HL'),(141,'C - Fore - Worker','IN_PROCESS','HL'),(142,'Final - Molasses','IN_PROCESS','HL'),(143,'C - After - Worker','IN_PROCESS','HL'),(144,'Unbagged - Sugar','IN_PROCESS','Qtls'),(145,'Prev - Season - Material - Quantity','OLD_STOCK','Qtls'),(146,'Prev - Season - Material - Brix','OLD_STOCK','%'),(147,'Prev - Season - Material - Pol','OLD_STOCK','%'),(148,'Prev - Season - Mat - FM - Brix','OLD_STOCK','%'),(149,'Prev - Season - Mat - FM - Pol','OLD_STOCK','%'),(150,'Prev - Season - Sugar - Quantity','OLD_STOCK','Qtls'),(151,'Prev - Season - Sugar - Brix','OLD_STOCK','%'),(152,'Prev - Season - Sugar - Pol','OLD_STOCK','%'),(153,'Prev - Season - Sugar - FM - Brix','OLD_STOCK','%'),(154,'Prev - Season - Sugar - FM - Pol','OLD_STOCK','%'),(155,'Rs - Prc of - Material','RT7C_PARAM','%'),(156,'Ash - Prc of - Material','RT7C_PARAM','%'),(157,'Rs - Prc of - Sugar','RT7C_PARAM','%'),(158,'Ash - Prc of - Sugar','RT7C_PARAM','%'),(159,'Rori - Sugar - Quantity','IN_PROCESS','Qtls'),(160,'Rori - Sugar - Pol','IN_PROCESS','%'),(161,'Bagasse - Saved','BY_PRODUCT','MT'),(162,'Lime - Kiln - Gas - CO2 %','RT7C_PARAM','%'),(163,'Feed - Water - Temp','RT7C_PARAM','C'),(164,'Feed - Water - PH','RT7C_PARAM','pH'),(165,'Clear - Juice - Temp','RT7C_PARAM','C'),(166,'Clear - Juice - PH','RT7C_PARAM','pH'),(167,'Rs - Prc of - Raw - Sugar','RT7C_PARAM','%'),(168,'Ash - Prc of - Raw - Sugar','RT7C_PARAM','%'),(169,'Reducement - Sugar','RT7C_PARAM','%'),(170,'Reducement - Material','RT7C_PARAM','%'),(171,'Tons of - Pol in - Rori Sugar','RT7C_PARAM','MT'),(172,'Prev - Brown - Sugar - Quantity','OLD_STOCK','Qtls'),(173,'Prev - BISS - Sugar - Quantity','OLD_STOCK','Qtls'),(174,'PSeason - Sugar - Quantity (4)','OLD_STOCK','Qtls'),(175,'PSeason - Sugar - Quantity (5)','OLD_STOCK','Qtls'),(176,'Prev - Season - FM of - Brow','OLD_STOCK','%'),(177,'Prev - Season - FM of - BISS','OLD_STOCK','%'),(178,'Prev - Season - FM of - (4)','OLD_STOCK','%'),(179,'Prev - Season - FM of - (5)','OLD_STOCK','%'),(180,'PAN - A','IN_PROCESS','HL'),(181,'PAN - B','IN_PROCESS','HL'),(182,'PAN - C','IN_PROCESS','HL'),(183,'PAN - D','IN_PROCESS','HL');
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
  `report_type` varchar(20) DEFAULT 'DAILY',
  `material_id` int NOT NULL,
  `quantity_qtls` decimal(12,3) DEFAULT '0.000',
  `volume_hl` decimal(12,3) DEFAULT '0.000',
  `specific_gravity` decimal(10,3) DEFAULT '0.000',
  `brix_percent` decimal(8,3) DEFAULT '0.000',
  `pol_percent` decimal(8,3) DEFAULT '0.000',
  `purity_percent` decimal(8,3) DEFAULT '0.000',
  `rt7c_number` varchar(50) DEFAULT NULL,
  `season_year` varchar(15) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `actual_date` date DEFAULT NULL,
  PRIMARY KEY (`stock_id`),
  UNIQUE KEY `uk_sample_material_type` (`sample_date`,`material_id`,`report_type`),
  KEY `fk_stock_date` (`sample_date`),
  KEY `fk_stock_material` (`material_id`),
  CONSTRAINT `fk_stock_material` FOREIGN KEY (`material_id`) REFERENCES `material_master` (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_stock_log`
--

LOCK TABLES `material_stock_log` WRITE;
/*!40000 ALTER TABLE `material_stock_log` DISABLE KEYS */;
INSERT INTO `material_stock_log` VALUES (1,'2026-03-17','DAILY',1,11.000,1111.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(2,'2026-03-17','DAILY',2,11.000,11.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(3,'2026-03-17','DAILY',3,11.000,11.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(4,'2026-03-17','DAILY',4,0.010,11.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(5,'2026-03-17','DAILY',5,11.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(6,'2026-03-17','DAILY',6,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(7,'2026-03-17','DAILY',7,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(8,'2026-03-17','DAILY',8,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(9,'2026-03-17','DAILY',50,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(10,'2026-03-17','DAILY',51,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(11,'2026-03-17','DAILY',52,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(12,'2026-03-17','DAILY',53,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(13,'2026-03-17','DAILY',110,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(14,'2026-03-17','DAILY',111,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(15,'2026-03-17','DAILY',112,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(16,'2026-03-17','DAILY',113,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(17,'2026-03-17','DAILY',114,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(18,'2026-03-17','DAILY',115,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(19,'2026-03-17','DAILY',116,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(20,'2026-03-17','DAILY',117,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(21,'2026-03-17','DAILY',118,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(22,'2026-03-17','DAILY',119,1.000,1.000,0.000,0.000,0.000,0.000,NULL,NULL,NULL,NULL,NULL),(23,'2026-03-01','RT7C',4,0.000,1500.500,1.050,15.500,12.400,80.000,'10','2025-2026','2026-02-01','2026-02-28','2026-03-01'),(24,'2026-03-01','RT7C',121,0.000,850.250,1.250,60.500,50.000,82.644,'10','2025-2026','2026-02-01','2026-02-28','2026-03-01'),(25,'2026-03-01','RT7C',131,0.000,450.000,1.350,75.000,45.000,60.000,'10','2025-2026','2026-02-01','2026-02-28','2026-03-01'),(26,'2026-03-01','RT7C',161,0.000,5000.000,0.000,0.000,0.000,0.000,'10','2025-2026','2026-02-01','2026-02-28','2026-03-01'),(27,'2026-03-01','RT7C',180,0.000,120.000,1.450,90.000,75.000,83.333,'10','2025-2026','2026-02-01','2026-02-28','2026-03-01');
/*!40000 ALTER TABLE `material_stock_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rt8c_technical_performance`
--

DROP TABLE IF EXISTS `rt8c_technical_performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rt8c_technical_performance` (
  `season_year` varchar(15) NOT NULL,
  `season_start_date` date DEFAULT NULL,
  `crushing_end_date` date DEFAULT NULL,
  `crushing_end_time` time DEFAULT NULL,
  `process_end_date` date DEFAULT NULL,
  `process_end_time` time DEFAULT NULL,
  `own_estate_cane` decimal(12,3) DEFAULT NULL,
  `gate_cane` decimal(12,3) DEFAULT NULL,
  `out_station_cane` decimal(12,3) DEFAULT NULL,
  `area_harvested` decimal(12,3) DEFAULT NULL,
  `other_than_rail_cane` decimal(12,3) DEFAULT NULL,
  `cane_members` decimal(12,3) DEFAULT NULL,
  `cane_non_members` decimal(12,3) DEFAULT NULL,
  `area_under_farm` decimal(12,3) DEFAULT NULL,
  `area_under_cane` decimal(12,3) DEFAULT NULL,
  `rori_sugar_bags` decimal(12,3) DEFAULT NULL,
  `extra_fuel_std_bag_pct` decimal(12,3) DEFAULT NULL,
  `process_steam_pct` decimal(12,3) DEFAULT NULL,
  `avg_yield_per_hectare` decimal(12,3) DEFAULT NULL,
  `avg_yield_adsali` decimal(12,3) DEFAULT NULL,
  `avg_yield_plant` decimal(12,3) DEFAULT NULL,
  `avg_yield_ratoon` decimal(12,3) DEFAULT NULL,
  `avg_prep_index` decimal(12,3) DEFAULT NULL,
  `avg_temp_added_water` decimal(12,3) DEFAULT NULL,
  `bagasse_used_fuel` decimal(12,3) DEFAULT NULL,
  `bagasse_used_sugar_plant` decimal(12,3) DEFAULT NULL,
  `bagasse_used_by_products` decimal(12,3) DEFAULT NULL,
  `bagasse_used_cogen` decimal(12,3) DEFAULT NULL,
  `bagasse_used_oliver` decimal(12,3) DEFAULT NULL,
  `bagasse_sold` decimal(12,3) DEFAULT NULL,
  PRIMARY KEY (`season_year`),
  CONSTRAINT `fk_rt8c_season` FOREIGN KEY (`season_year`) REFERENCES `factory_season_master` (`season_year`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rt8c_technical_performance`
--

LOCK TABLES `rt8c_technical_performance` WRITE;
/*!40000 ALTER TABLE `rt8c_technical_performance` DISABLE KEYS */;
INSERT INTO `rt8c_technical_performance` VALUES ('2021-2022','2021-10-15','2022-03-25','14:30:00','2022-03-30','10:00:00',15000.500,45000.000,5000.000,1200.500,50000.500,40000.000,10000.000,500.000,2500.000,150.000,2.500,42.500,85.500,95.000,80.000,75.000,88.500,65.000,25000.000,20000.000,1500.000,3000.000,500.000,1000.000),('2022-2023','2022-10-20','2023-04-05','16:45:00','2023-04-10','11:30:00',16500.000,48000.500,6000.000,1350.000,54000.000,42000.500,12000.000,550.000,2700.000,165.000,2.400,41.800,86.200,96.500,81.000,76.500,89.000,66.500,26500.000,21000.000,1600.000,3200.000,550.000,1200.000),('2023-2024','2023-10-18','2024-03-28','08:15:00','2024-04-02','18:00:00',14800.250,42500.000,4500.000,1150.750,47000.000,38000.000,9000.000,480.000,2400.000,140.000,2.600,43.100,84.000,94.000,79.500,74.000,87.800,64.000,24000.000,19500.000,1400.000,2800.000,450.000,800.000),('2024-2025','2024-10-22','2025-04-12','22:00:00','2025-04-18','09:45:00',17200.000,51000.000,6500.000,1420.000,57500.000,45000.000,12500.000,600.000,2850.000,180.000,2.350,41.200,87.500,98.000,82.500,78.000,89.500,67.000,28000.000,22500.000,1800.000,3500.000,600.000,1500.000),('2025-2026','2025-10-15','2026-04-01','12:30:00','2026-04-06','15:15:00',15500.000,46000.000,5500.000,1280.000,51500.000,41000.000,10500.000,520.000,2600.000,155.000,2.450,42.000,85.800,95.500,80.500,75.500,88.200,65.500,25500.000,20500.000,1550.000,3100.000,520.000,1100.000);
/*!40000 ALTER TABLE `rt8c_technical_performance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `run_stock_log`
--

DROP TABLE IF EXISTS `run_stock_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `run_stock_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `season_year` varchar(15) NOT NULL,
  `run_number` varchar(50) NOT NULL,
  `material_id` int NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `stock_date` date NOT NULL,
  `actual_date` date DEFAULT NULL,
  `volume_hl` decimal(12,3) DEFAULT '0.000',
  `brix_percent` decimal(8,3) DEFAULT '0.000',
  `pol_percent` decimal(8,3) DEFAULT '0.000',
  `purity_percent` decimal(8,3) DEFAULT '0.000',
  PRIMARY KEY (`log_id`),
  UNIQUE KEY `uk_run_material` (`season_year`,`run_number`,`material_id`),
  KEY `fk_run_material_idx` (`material_id`),
  KEY `fk_run_season_idx` (`season_year`),
  CONSTRAINT `fk_run_material` FOREIGN KEY (`material_id`) REFERENCES `material_master` (`material_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_run_season` FOREIGN KEY (`season_year`) REFERENCES `factory_season_master` (`season_year`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `run_stock_log`
--

LOCK TABLES `run_stock_log` WRITE;
/*!40000 ALTER TABLE `run_stock_log` DISABLE KEYS */;
INSERT INTO `run_stock_log` VALUES (1,'2025-2026','RUN-001',4,'2025-10-15','2025-10-31','2025-10-31','2025-11-01',1200.500,14.800,12.100,81.750),(2,'2025-2026','RUN-001',121,'2025-10-15','2025-10-31','2025-10-31','2025-11-01',400.000,58.500,48.000,82.050),(3,'2025-2026','RUN-001',123,'2025-10-15','2025-10-31','2025-10-31','2025-11-01',280.000,89.000,76.000,85.390),(4,'2025-2026','RUN-002',4,'2025-11-01','2025-11-15','2025-11-15','2025-11-16',1450.000,15.200,12.500,82.230),(5,'2025-2026','RUN-002',121,'2025-11-01','2025-11-15','2025-11-15','2025-11-16',420.500,60.000,49.500,82.500),(6,'2025-2026','RUN-002',123,'2025-11-01','2025-11-15','2025-11-15','2025-11-16',310.000,90.200,77.800,86.250),(7,'2025-2026','RUN-002',124,'2025-11-01','2025-11-15','2025-11-15','2025-11-16',150.000,91.500,64.000,69.940),(8,'2025-2026','RUN-003',4,'2025-11-16','2025-11-30','2025-11-30','2025-12-01',1600.000,15.800,13.200,83.540),(9,'2025-2026','RUN-003',121,'2025-11-16','2025-11-30','2025-11-30','2025-12-01',480.000,61.500,51.200,83.250),(10,'2025-2026','RUN-003',125,'2025-11-16','2025-11-30','2025-11-30','2025-12-01',220.000,96.000,56.500,58.850),(11,'2024-2025','RUN-999',4,'2024-12-01','2024-12-15','2024-12-15','2024-12-16',1100.000,14.500,11.800,81.370),(12,'2024-2025','RUN-999',121,'2024-12-01','2024-12-15','2024-12-15','2024-12-16',380.000,59.000,47.500,80.500),(13,'2025-2026','RUN-FULL-DB',4,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',1500.000,15.000,12.500,83.330),(14,'2025-2026','RUN-FULL-DB',121,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',450.000,60.000,50.000,83.330),(15,'2025-2026','RUN-FULL-DB',122,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',420.000,58.000,48.000,82.750),(16,'2025-2026','RUN-FULL-DB',123,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',300.000,90.000,78.000,86.660),(17,'2025-2026','RUN-FULL-DB',124,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',200.000,92.000,68.000,73.910),(18,'2025-2026','RUN-FULL-DB',125,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',250.000,95.000,55.000,57.890),(19,'2025-2026','RUN-FULL-DB',126,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',50.000,90.000,60.000,66.660),(20,'2025-2026','RUN-FULL-DB',127,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',150.000,70.000,50.000,71.420),(21,'2025-2026','RUN-FULL-DB',128,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',100.000,75.000,45.000,60.000),(22,'2025-2026','RUN-FULL-DB',129,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',120.000,80.000,35.000,43.750),(23,'2025-2026','RUN-FULL-DB',130,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',40.000,75.000,40.000,53.330),(24,'2025-2026','SUN-DB-UT',4,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',1500.000,15.000,12.500,83.330),(25,'2025-2026','SUN-DB-UT',121,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',450.000,60.000,50.000,83.330),(26,'2025-2026','SUN-DB-UT',122,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',420.000,58.000,48.000,82.750),(27,'2025-2026','SUN-DB-UT',123,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',300.000,90.000,78.000,86.660),(28,'2025-2026','SUN-DB-UT',124,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',200.000,92.000,68.000,73.910),(29,'2025-2026','SUN-DB-UT',125,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',250.000,95.000,55.000,57.890),(30,'2025-2026','SUN-DB-UT',126,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',50.000,90.000,60.000,66.660),(31,'2025-2026','SUN-DB-UT',127,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',150.000,70.000,50.000,71.420),(32,'2025-2026','SUN-DB-UT',128,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',100.000,75.000,45.000,60.000),(33,'2025-2026','SUN-DB-UT',129,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',120.000,80.000,35.000,43.750),(34,'2025-2026','SUN-DB-UT',130,'2026-03-01','2026-03-15','2026-03-15','2026-03-16',40.000,75.000,40.000,53.330);
/*!40000 ALTER TABLE `run_stock_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stoppage_reason_master`
--

DROP TABLE IF EXISTS `stoppage_reason_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stoppage_reason_master` (
  `reason_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_eng` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_mar` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`reason_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stoppage_reason_master`
--

LOCK TABLES `stoppage_reason_master` WRITE;
/*!40000 ALTER TABLE `stoppage_reason_master` DISABLE KEYS */;
INSERT INTO `stoppage_reason_master` VALUES ('DEBUG_101','MECHANICAL','Testing Save','टेस्टिंग सेव्ह'),('E01','ELECTRICAL','Power Failure (Grid)','??? ?????? ?????'),('M01','MECHANICAL','Donally Chute Jam','?????? ????? ???'),('P01','PROCESS','Evaporator Cleaning','??????????? ????????'),('TEST_123','MECHANICAL','Test Save','चाचणी जतन करा');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','admin123','ADMIN','2026-03-16 06:11:22');
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

-- Dump completed on 2026-03-19 21:15:05