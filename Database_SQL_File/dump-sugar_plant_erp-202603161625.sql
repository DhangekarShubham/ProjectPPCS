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
  `sample_date` date NOT NULL,
  `season_year` varchar(15) NOT NULL,
  `crop_day` int DEFAULT NULL,
  `member_cane_crushed_mt` decimal(12,3) DEFAULT '0.000',
  `non_member_cane_crushed_mt` decimal(12,3) DEFAULT '0.000',
  `other_cane_crushed_mt` decimal(12,3) DEFAULT '0.000',
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
  `cogen_12mw_export_kwh` decimal(15,2) DEFAULT '0.00',
  PRIMARY KEY (`sample_date`),
  KEY `season_year` (`season_year`),
  CONSTRAINT `fk_crushing_season` FOREIGN KEY (`season_year`) REFERENCES `factory_season_master` (`season_year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_crushing_log`
--

LOCK TABLES `daily_crushing_log` WRITE;
/*!40000 ALTER TABLE `daily_crushing_log` DISABLE KEYS */;
INSERT INTO `daily_crushing_log` VALUES ('2025-10-15','2025-2026',1,0.000,0.000,0.000,0.000,0.00,0.00,0,0.000,0,0.000,0,0.000,0.000,0.000,0.000,0.00);
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
  `sample_date` date NOT NULL,
  `material_id` int NOT NULL,
  `brix_pct` decimal(8,3) DEFAULT NULL,
  `pol_pct` decimal(8,3) DEFAULT NULL,
  `purity_pct` decimal(8,3) DEFAULT NULL,
  `moisture_pct` decimal(8,3) DEFAULT NULL,
  PRIMARY KEY (`analysis_id`),
  UNIQUE KEY `unique_daily_material` (`sample_date`,`material_id`),
  KEY `fk_lab_material` (`material_id`),
  CONSTRAINT `fk_lab_date` FOREIGN KEY (`sample_date`) REFERENCES `daily_crushing_log` (`sample_date`) ON DELETE CASCADE,
  CONSTRAINT `fk_lab_material` FOREIGN KEY (`material_id`) REFERENCES `material_master` (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_lab_analysis_details`
--

LOCK TABLES `daily_lab_analysis_details` WRITE;
/*!40000 ALTER TABLE `daily_lab_analysis_details` DISABLE KEYS */;
INSERT INTO `daily_lab_analysis_details` VALUES (1,'2025-10-15',1,18.500,15.200,82.160,NULL),(2,'2025-10-15',2,15.100,12.400,82.110,NULL),(3,'2025-10-15',3,2.500,1.800,72.000,NULL),(4,'2025-10-15',4,14.800,12.200,82.430,NULL),(5,'2025-10-15',5,65.200,54.100,82.970,NULL),(6,'2025-10-15',6,92.500,78.400,84.750,NULL),(7,'2025-10-15',7,94.200,68.100,72.290,NULL),(8,'2025-10-15',8,96.100,56.500,58.790,NULL),(9,'2025-10-15',9,88.500,32.100,36.270,NULL),(10,'2025-10-15',10,NULL,2.100,NULL,48.500);
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
  `reason_code` varchar(20) NOT NULL,
  `total_hours` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`stoppage_id`),
  KEY `reason_code` (`reason_code`),
  CONSTRAINT `daily_stoppage_log_ibfk_1` FOREIGN KEY (`reason_code`) REFERENCES `stoppage_reason_master` (`reason_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_stoppage_log`
--

LOCK TABLES `daily_stoppage_log` WRITE;
/*!40000 ALTER TABLE `daily_stoppage_log` DISABLE KEYS */;
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
  `sample_date` date NOT NULL,
  `material_id` int NOT NULL,
  `no_of_bags` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`production_id`),
  KEY `fk_prod_date` (`sample_date`),
  KEY `fk_prod_material` (`material_id`),
  CONSTRAINT `fk_prod_date` FOREIGN KEY (`sample_date`) REFERENCES `daily_crushing_log` (`sample_date`) ON DELETE CASCADE,
  CONSTRAINT `fk_prod_material` FOREIGN KEY (`material_id`) REFERENCES `material_master` (`material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_sugar_production`
--

LOCK TABLES `daily_sugar_production` WRITE;
/*!40000 ALTER TABLE `daily_sugar_production` DISABLE KEYS */;
/*!40000 ALTER TABLE `daily_sugar_production` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_time_account`
--

DROP TABLE IF EXISTS `daily_time_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_time_account` (
  `sample_date` date NOT NULL,
  `working_hours` decimal(5,2) DEFAULT '0.00',
  `hours_lost_rain` decimal(5,2) DEFAULT '0.00',
  `hours_lost_mechanical` decimal(5,2) DEFAULT '0.00',
  `hours_lost_electrical` decimal(5,2) DEFAULT '0.00',
  `hours_lost_cane_shortage` decimal(5,2) DEFAULT '0.00',
  `hours_lost_cleaning` decimal(5,2) DEFAULT '0.00',
  `hours_lost_process` decimal(5,2) DEFAULT '0.00',
  `hours_lost_misc` decimal(5,2) DEFAULT '0.00',
  PRIMARY KEY (`sample_date`),
  CONSTRAINT `fk_time_date` FOREIGN KEY (`sample_date`) REFERENCES `daily_crushing_log` (`sample_date`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_time_account`
--

LOCK TABLES `daily_time_account` WRITE;
/*!40000 ALTER TABLE `daily_time_account` DISABLE KEYS */;
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
INSERT INTO `factory_master` VALUES ('2011-2012',NULL,NULL,'yuwteuyt','jhsdgfjhasg','gsdhfgakhdg','jhsgdhcgs','gsgdcgg','6465465','1234567890','464565465','hgJHDFFjsd@gmail.com',NULL,'gsajdhgAJHSGDGJHg','5454','4545445','545454',466.00,'5445','454',446.00,'jhssdggf','kjccgSJDGGDJagds','DJKCKSDFF','GCJgg'),('2013-2014','2016-11-01','09:00:00','Sardar Patel Sugars','GIDC Estate','Bardoli','Surat','Gujarat','394601','220044','02622','info@sardarsugar.com','www.sardarsugar.com','Defecation','REG1010','24JJJJ8901J8Z0','10024022000777',4.90,'Surat','South-Guj',4000.00,'G.B. Patel','M.K. Shah','N.D. Desai','R.J. Mehta'),('2016-2017','2016-11-01','09:00:00','Sardar Patel Sugars','GIDC Estate','Bardoli','Surat','Gujarat','394601','220044','02622','info@sardarsugar.com','www.sardarsugar.com','Defecation','REG1010','24JJJJ8901J8Z0','10024022000777',4.90,'Surat','South-Guj',4000.00,'G.B. Patel','M.K. Shah','N.D. Desai','R.J. Mehta'),('2018-2019','2018-11-02','10:00:00','Malwa Sugar Corp','Industrial Area Ph 2','Indore','Indore','Madhya Pradesh','452001','243344','0731','malwa@sugarcorp.in','www.sugarcorp.in','Double Sulphitation','REG1008','23HHHH6789H6Z8','10022022000555',5.10,'Indore','West',5500.00,'H.L. Mittal','C.P. Gupta','J.K. Jain','B.R. Chouhan'),('2019-2020','2019-10-28','09:30:00','Southern Gold Sugars','Main Road, Kovilpatti','Tuticorin','Thoothukudi','Tamil Nadu','628501','230111','04632','help@southerngold.tn','www.southerngold.tn','Defecation','REG1007','33GGGG5678G5Z7','10021022000444',4.80,'Madurai','South',4800.00,'T.R. Mani','K.S. Rajan','G.V. Iyer','M.P. Kumar'),('2020-2021','2020-11-10','08:45:00','Northern Crystal Ind.','GT Road, Sec 12','Karnal','Karnal','Haryana','132001','225588','0184','hr@northcrystal.com','www.northcrystal.com','Double Sulphitation','REG1006','06FFFF4567F4Z6','10020022000333',5.25,'Rohtak','North-A',6200.00,'V.K. Singh','A.P. Sharma','R.S. Yadav','S.S. Verma'),('2021-2022','2021-10-25','11:00:00','Coastal Sweetners','Verna Industrial Estate','Salcete','South Goa','Goa','403722','272200','0832','ops@coastalsweet.com','www.coastalsweet.com','Phospho-Defecation','REG1005','30EEEE3456E3Z5','10019022000222',4.50,'Panaji','Coastal',2800.00,'M.N. Fernandes','J.P. D-Souza','R.L. Prabhu','K.K. Naik'),('2022-2023','2022-11-05','09:15:00','Royal Cane Processors','Survey No 88/1','Baramati','Pune','Maharashtra','413102','222333','02112','sales@royalcane.com','www.royalcane.com','Double Sulphitation','REG1004','27DDDD2345D2Z4','10018022000111',5.00,'Pune','Central',4200.00,'P.R. Pawar','S.T. More','A.B. Gadre','W.N. Kadam'),('2023-2024','2023-10-20','08:00:00','Heritage Sugars Ltd','NH-4, Milestone 12','Belagavi','Belagavi','Karnataka','590001','240500','0831','admin@heritagesugar.com','www.heritagesugar.com','Defeco-Remelt','REG1003','29CCCC1234C1Z3','10017022000789',6.00,'Belgaum','North',7500.00,'S.R. Hegde','K.L. Rao','V.M. Bhat','D.R. Nayak'),('2024-2025','2024-11-01','10:30:00','Green Valley Co-op','Sugar Lane, Ward 4','Sangli','Sangli','Maharashtra','416416','233100','0233','info@greenvalley.in','www.greenvalley.in','Defeco-Melt','REG1002','27BBBCB2345B2Z2','10016022000456',4.75,'Kolhapur','East',3500.00,'B.L. Jadhav','N.M. Shinde','G.H. Thorat','P.S. Mane'),('2025-2026','2025-10-15','09:00:00','Apex Sugar Mills','Plot 45, Industrial Area','Karad','Satara','Maharashtra','415110','224455','02164','contact@apexsugar.com','www.apexsugar.com','Double Sulphitation','REG1001','27AAACA1234A1Z1','10015022000123',5.50,'Pune','South',5000.00,'A.S. Deshmukh','R.P. Patil','S.K. Kulkarni','M.V. Joshi');
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
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_master`
--

LOCK TABLES `material_master` WRITE;
/*!40000 ALTER TABLE `material_master` DISABLE KEYS */;
INSERT INTO `material_master` VALUES (1,'Primary Juice','IN_PROCESS','HL'),(2,'Mixed Juice','IN_PROCESS','HL'),(3,'Last Expressed Juice','IN_PROCESS','HL'),(4,'Clear Juice','IN_PROCESS','HL'),(5,'Unsulphured Syrup','IN_PROCESS','HL'),(6,'A-Massecuite','IN_PROCESS','HL'),(7,'B-Massecuite','IN_PROCESS','HL'),(8,'C-Massecuite','IN_PROCESS','HL'),(9,'Final Molasses','BY_PRODUCT','MT'),(10,'Bagasse','BY_PRODUCT','MT'),(11,'Filter Cake','BY_PRODUCT','MT'),(50,'L-30 (50 Kg)','SUGAR_GRADE','Bags'),(51,'M-30 (50 Kg)','SUGAR_GRADE','Bags'),(52,'S1-30 (50 Kg)','SUGAR_GRADE','Bags'),(53,'Raw Sugar (50 Kg)','SUGAR_GRADE','Bags'),(100,'Lime Process','CHEMICAL','Kg'),(101,'Phosphoric Acid','CHEMICAL','Litre'),(102,'Caustic Soda','CHEMICAL','Kg'),(103,'Sulphur','CHEMICAL','Kg');
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
  `material_id` int NOT NULL,
  `quantity_qtls` decimal(12,3) DEFAULT '0.000',
  `volume_hl` decimal(12,3) DEFAULT '0.000',
  PRIMARY KEY (`stock_id`),
  KEY `fk_stock_date` (`sample_date`),
  KEY `fk_stock_material` (`material_id`),
  CONSTRAINT `fk_stock_date` FOREIGN KEY (`sample_date`) REFERENCES `daily_crushing_log` (`sample_date`) ON DELETE CASCADE,
  CONSTRAINT `fk_stock_material` FOREIGN KEY (`material_id`) REFERENCES `material_master` (`material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_stock_log`
--

LOCK TABLES `material_stock_log` WRITE;
/*!40000 ALTER TABLE `material_stock_log` DISABLE KEYS */;
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
INSERT INTO `stoppage_reason_master` VALUES ('E01','ELECTRICAL','Power Failure (Grid)','??? ?????? ?????'),('M01','MECHANICAL','Donally Chute Jam','?????? ????? ???'),('P01','PROCESS','Evaporator Cleaning','??????????? ????????');
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

-- Dump completed on 2026-03-17 13:48:23
