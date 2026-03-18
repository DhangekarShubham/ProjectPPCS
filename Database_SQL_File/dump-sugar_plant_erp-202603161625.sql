-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: sugar_plant_erp
-- ------------------------------------------------------
-- Server version	8.0.44

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
INSERT INTO `daily_crushing_log` VALUES ('2024-10-24','2025-2026',NULL,0.000,0.000,0.000,0.000,0.000,0.000,0.000,0.00,0.00,0,0.000,0,0.000,0,0.000,0.000,0.000,0.000,0.00,0.00,NULL,0.000),('2025-10-15','2025-2026',NULL,2850.500,650.000,0.000,0.000,0.000,0.000,102.300,32.50,48.20,0,0.000,0,0.000,0,0.000,0.020,0.010,0.120,0.00,0.00,NULL,0.000),('2025-10-16','2025-2026',NULL,2900.000,700.000,0.000,0.000,0.000,0.000,110.450,31.80,47.90,0,0.000,0,0.000,0,0.000,0.021,0.011,0.115,0.00,0.00,NULL,0.000),('2025-10-17','2025-2026',NULL,3100.250,450.000,0.000,0.000,0.000,0.000,115.000,33.10,49.50,0,0.000,0,0.000,0,0.000,0.019,0.010,0.130,0.00,0.00,NULL,0.000),('2025-10-18','2025-2026',NULL,3050.000,550.000,0.000,0.000,0.000,0.000,108.300,32.70,48.80,0,0.000,0,0.000,0,0.000,0.022,0.012,0.125,0.00,0.00,NULL,0.000),('2025-10-19','2025-2026',NULL,2750.000,850.000,0.000,0.000,0.000,0.000,98.600,31.50,46.50,0,0.000,0,0.000,0,0.000,0.020,0.010,0.110,0.00,0.00,NULL,0.000),('2025-10-20','2025-2026',NULL,3200.000,350.000,0.000,0.000,0.000,0.000,120.100,34.20,51.00,0,0.000,0,0.000,0,0.000,0.025,0.015,0.140,0.00,0.00,NULL,0.000),('2025-10-21','2025-2026',NULL,3150.000,480.000,0.000,0.000,0.000,0.000,112.000,32.00,47.50,0,0.000,0,0.000,0,0.000,0.020,0.010,0.122,0.00,0.00,NULL,0.000),('2025-10-22','2025-2026',NULL,3000.500,520.000,0.000,0.000,0.000,0.000,107.500,31.00,46.20,0,0.000,0,0.000,0,0.000,0.021,0.011,0.118,0.00,0.00,NULL,0.000),('2025-10-23','2025-2026',NULL,2920.000,610.000,0.000,0.000,0.000,0.000,104.200,32.50,48.00,0,0.000,0,0.000,0,0.000,0.023,0.013,0.128,0.00,0.00,NULL,0.000),('2025-10-24','2025-2026',NULL,3350.000,250.000,0.000,0.000,0.000,0.000,125.400,33.50,50.10,0,0.000,0,0.000,0,0.000,0.020,0.010,0.135,0.00,0.00,NULL,0.000),('2026-03-17','2025-2026',NULL,NULL,NULL,0.000,0.000,0.000,0.000,NULL,NULL,NULL,0,0.000,0,0.000,0,0.000,NULL,NULL,NULL,0.00,0.00,NULL,0.000),('2026-03-18','2025-2026',22,0.000,0.000,0.000,1232.000,121.000,21.000,0.000,0.00,0.00,0,0.000,0,0.000,0,0.000,0.000,0.000,0.000,2.00,11.00,'12',222.000);
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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_lab_analysis_details`
--

LOCK TABLES `daily_lab_analysis_details` WRITE;
/*!40000 ALTER TABLE `daily_lab_analysis_details` DISABLE KEYS */;
INSERT INTO `daily_lab_analysis_details` VALUES (11,'2025-10-15',1,18.500,15.200,82.160,NULL),(12,'2025-10-15',2,15.100,12.400,82.110,NULL),(13,'2025-10-15',10,NULL,2.100,NULL,48.500),(14,'2025-10-16',1,18.800,15.500,82.440,NULL),(15,'2025-10-16',2,15.400,12.700,82.460,NULL),(16,'2025-10-16',10,NULL,2.050,NULL,48.200),(17,'2025-10-17',1,19.100,15.900,83.250,NULL),(18,'2025-10-18',1,18.900,15.700,83.070,NULL),(19,'2025-10-19',1,18.400,15.100,82.070,NULL),(20,'2025-10-20',1,19.500,16.300,83.590,NULL),(21,'2025-10-21',1,19.200,16.000,83.330,NULL),(22,'2025-10-22',1,18.700,15.400,82.350,NULL),(23,'2025-10-23',1,18.500,15.100,81.620,NULL),(24,'2025-10-24',1,19.600,16.500,84.180,NULL),(25,'2024-10-24',1,NULL,NULL,NULL,NULL),(26,'2024-10-24',2,NULL,NULL,NULL,NULL),(27,'2024-10-24',4,NULL,NULL,NULL,NULL),(28,'2024-10-24',9,NULL,NULL,NULL,NULL),(29,'2024-10-24',10,NULL,NULL,NULL,NULL),(30,'2026-03-17',1,5.000,5.000,100.000,NULL),(31,'2026-03-17',2,5.000,5.000,100.000,NULL),(32,'2026-03-17',4,5.000,5.000,100.000,NULL),(33,'2026-03-17',9,5.000,5.000,100.000,NULL),(34,'2026-03-17',10,NULL,5.000,NULL,5.000);
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
INSERT INTO `factory_season_master` VALUES ('2025-2026','2025-10-15',NULL,'Shri.Chhatrapati S.S.K.Ltd, Bhavaninagar',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3500.00,NULL,NULL,NULL,NULL);
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
  `category` enum('CHEMICAL','IN_PROCESS','SUGAR_GRADE','BY_PRODUCT','FUEL') NOT NULL,
  `unit_of_measure` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_master`
--

LOCK TABLES `material_master` WRITE;
/*!40000 ALTER TABLE `material_master` DISABLE KEYS */;
INSERT INTO `material_master` VALUES (1,'Primary Juice','IN_PROCESS','HL'),(2,'Mixed Juice','IN_PROCESS','HL'),(3,'Last Expressed Juice','IN_PROCESS','HL'),(4,'Clear Juice','IN_PROCESS','HL'),(5,'Unsulphured Syrup','IN_PROCESS','HL'),(6,'A-Massecuite','IN_PROCESS','HL'),(7,'B-Massecuite','IN_PROCESS','HL'),(8,'C-Massecuite','IN_PROCESS','HL'),(9,'Final Molasses','BY_PRODUCT','MT'),(10,'Bagasse','BY_PRODUCT','MT'),(11,'Filter Cake','BY_PRODUCT','MT'),(50,'L-30 (50 Kg)','SUGAR_GRADE','Bags'),(51,'M-30 (50 Kg)','SUGAR_GRADE','Bags'),(52,'S1-30 (50 Kg)','SUGAR_GRADE','Bags'),(53,'Raw Sugar (50 Kg)','SUGAR_GRADE','Bags'),(100,'Lime Process','CHEMICAL','Kg'),(101,'Phosphoric Acid','CHEMICAL','Litre'),(102,'Caustic Soda','CHEMICAL','Kg'),(103,'Sulphur','CHEMICAL','Kg'),(104,'Lime Powder','CHEMICAL','Kg'),(105,'Sulphur','CHEMICAL','Kg'),(106,'Phosphoric Acid','CHEMICAL','Litre'),(107,'Caustic Soda','CHEMICAL','Kg'),(108,'Flocculant','CHEMICAL','Kg'),(109,'Antiscalant','CHEMICAL','Kg'),(110,'L-30 Sugar (50kg)','SUGAR_GRADE','Bags'),(111,'M-30 Sugar (50kg)','SUGAR_GRADE','Bags'),(112,'S-30 Sugar (50kg)','SUGAR_GRADE','Bags'),(113,'Raw Sugar','SUGAR_GRADE','Bags'),(114,'A-Massecuite','IN_PROCESS','HL'),(115,'B-Massecuite','IN_PROCESS','HL'),(116,'C-Massecuite','IN_PROCESS','HL'),(117,'Final Molasses Stock','IN_PROCESS','MT'),(118,'Clear Juice Stock','IN_PROCESS','HL'),(119,'Syrup Stock','IN_PROCESS','HL');
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
  `crush_date` date NOT NULL,
  `material_id` int NOT NULL,
  `quantity_qtls` decimal(12,3) DEFAULT '0.000',
  `volume_hl` decimal(12,3) DEFAULT '0.000',
  PRIMARY KEY (`stock_id`),
  UNIQUE KEY `uk_crush_material` (`crush_date`,`material_id`),
  KEY `fk_stock_date` (`crush_date`),
  KEY `fk_stock_material` (`material_id`),
  CONSTRAINT `fk_stock_date` FOREIGN KEY (`crush_date`) REFERENCES `daily_crushing_log` (`crush_date`) ON DELETE CASCADE,
  CONSTRAINT `fk_stock_material` FOREIGN KEY (`material_id`) REFERENCES `material_master` (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_stock_log`
--

LOCK TABLES `material_stock_log` WRITE;
/*!40000 ALTER TABLE `material_stock_log` DISABLE KEYS */;
INSERT INTO `material_stock_log` VALUES (1,'2026-03-17',1,11.000,1111.000),(2,'2026-03-17',2,11.000,11.000),(3,'2026-03-17',3,11.000,11.000),(4,'2026-03-17',4,0.010,11.000),(5,'2026-03-17',5,11.000,1.000),(6,'2026-03-17',6,1.000,1.000),(7,'2026-03-17',7,1.000,1.000),(8,'2026-03-17',8,1.000,1.000),(9,'2026-03-17',50,1.000,1.000),(10,'2026-03-17',51,1.000,1.000),(11,'2026-03-17',52,1.000,1.000),(12,'2026-03-17',53,1.000,1.000),(13,'2026-03-17',110,1.000,1.000),(14,'2026-03-17',111,1.000,1.000),(15,'2026-03-17',112,1.000,1.000),(16,'2026-03-17',113,1.000,1.000),(17,'2026-03-17',114,1.000,1.000),(18,'2026-03-17',115,1.000,1.000),(19,'2026-03-17',116,1.000,1.000),(20,'2026-03-17',117,1.000,1.000),(21,'2026-03-17',118,1.000,1.000),(22,'2026-03-17',119,1.000,1.000);
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
/*!40000 ALTER TABLE `rt8c_technical_performance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stoppage_reason_master`
--

DROP TABLE IF EXISTS `stoppage_reason_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stoppage_reason_master` (
  `reason_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_eng` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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

-- Dump completed on 2026-03-18 17:17:04
