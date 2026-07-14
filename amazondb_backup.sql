-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: amazondb
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `adminid` int NOT NULL,
  `adminName` varchar(255) DEFAULT NULL,
  `adminNumber` decimal(10,0) DEFAULT NULL,
  `adminEmail` varchar(255) DEFAULT NULL,
  `adminPwd` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`adminid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (2,'Sellers');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (15,2,108),(16,2,116),(17,2,120),(18,2,121),(19,2,122),(20,2,123),(21,2,124),(22,2,125),(24,2,127),(2,2,128),(3,2,133),(4,2,134),(5,2,135),(6,2,136),(7,2,141),(8,2,142),(9,2,143),(10,2,144),(11,2,149),(12,2,150),(13,2,151),(14,2,152);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (77,'Can add log entry',23,'add_logentry'),(78,'Can change log entry',23,'change_logentry'),(79,'Can delete log entry',23,'delete_logentry'),(80,'Can view log entry',23,'view_logentry'),(81,'Can add permission',25,'add_permission'),(82,'Can change permission',25,'change_permission'),(83,'Can delete permission',25,'delete_permission'),(84,'Can view permission',25,'view_permission'),(85,'Can add group',24,'add_group'),(86,'Can change group',24,'change_group'),(87,'Can delete group',24,'delete_group'),(88,'Can view group',24,'view_group'),(89,'Can add user',26,'add_user'),(90,'Can change user',26,'change_user'),(91,'Can delete user',26,'delete_user'),(92,'Can view user',26,'view_user'),(93,'Can add content type',27,'add_contenttype'),(94,'Can change content type',27,'change_contenttype'),(95,'Can delete content type',27,'delete_contenttype'),(96,'Can view content type',27,'view_contenttype'),(97,'Can add session',28,'add_session'),(98,'Can change session',28,'change_session'),(99,'Can delete session',28,'delete_session'),(100,'Can view session',28,'view_session'),(101,'Can add admin',29,'add_admin'),(102,'Can change admin',29,'change_admin'),(103,'Can delete admin',29,'delete_admin'),(104,'Can view admin',29,'view_admin'),(105,'Can add categories',21,'add_categories'),(106,'Can change categories',21,'change_categories'),(107,'Can delete categories',21,'delete_categories'),(108,'Can view categories',21,'view_categories'),(109,'Can add customer',30,'add_customer'),(110,'Can change customer',30,'change_customer'),(111,'Can delete customer',30,'delete_customer'),(112,'Can view customer',30,'view_customer'),(113,'Can add orders',31,'add_orders'),(114,'Can change orders',31,'change_orders'),(115,'Can delete orders',31,'delete_orders'),(116,'Can view orders',31,'view_orders'),(117,'Can add payments',32,'add_payments'),(118,'Can change payments',32,'change_payments'),(119,'Can delete payments',32,'delete_payments'),(120,'Can view payments',32,'view_payments'),(121,'Can add products',20,'add_products'),(122,'Can change products',20,'change_products'),(123,'Can delete products',20,'delete_products'),(124,'Can view products',20,'view_products'),(125,'Can add refund',34,'add_refund'),(126,'Can change refund',34,'change_refund'),(127,'Can delete refund',34,'delete_refund'),(128,'Can view refund',34,'view_refund'),(129,'Can add reviews',35,'add_reviews'),(130,'Can change reviews',35,'change_reviews'),(131,'Can delete reviews',35,'delete_reviews'),(132,'Can view reviews',35,'view_reviews'),(133,'Can add sale',36,'add_sale'),(134,'Can change sale',36,'change_sale'),(135,'Can delete sale',36,'delete_sale'),(136,'Can view sale',36,'view_sale'),(137,'Can add seller',22,'add_seller'),(138,'Can change seller',22,'change_seller'),(139,'Can delete seller',22,'delete_seller'),(140,'Can view seller',22,'view_seller'),(141,'Can add shipment',37,'add_shipment'),(142,'Can change shipment',37,'change_shipment'),(143,'Can delete shipment',37,'delete_shipment'),(144,'Can view shipment',37,'view_shipment'),(145,'Can add wishlist',38,'add_wishlist'),(146,'Can change wishlist',38,'change_wishlist'),(147,'Can delete wishlist',38,'delete_wishlist'),(148,'Can view wishlist',38,'view_wishlist'),(149,'Can add product variant',33,'add_productvariant'),(150,'Can change product variant',33,'change_productvariant'),(151,'Can delete product variant',33,'delete_productvariant'),(152,'Can view product variant',33,'view_productvariant'),(153,'Can add cart item',39,'add_cartitem'),(154,'Can change cart item',39,'change_cartitem'),(155,'Can delete cart item',39,'delete_cartitem'),(156,'Can view cart item',39,'view_cartitem');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (4,'pbkdf2_sha256$1200000$CDCSGWeQc1GiQ8VUPjSbwM$zTbRIrwfU9at53MPCBoj50Bh+LdkRi4hF0dTTqQE+c4=','2026-07-13 09:25:58.185244',1,'priyanka','','','230101005012@gandhinagaruni.ac.in',1,1,'2026-07-07 12:16:02.361668'),(5,'pbkdf2_sha256$1200000$V9eDpD5hz0YYYEebdGfDg2$Wd9dspFofOhy4MZw1rfRJFZdyHduxfLtWAbJCXGZEPs=','2026-07-11 09:35:02.497057',0,'Corona_Remedies','OM','GHAG','',1,1,'2026-07-08 12:09:15.000000'),(7,'pbkdf2_sha256$1200000$7AMtWVFn1J9hWtLjP8dqlq$2fByTRvjK1UaoBjIag/+16Ga+HuzbNBmCkO6vRVGpFU=','2026-07-11 05:31:58.042142',0,'Torrent_Pharma','Rajnish Lalji bhai','Mehta','',1,1,'2026-07-09 11:56:12.000000'),(8,'pbkdf2_sha256$1200000$bHvCRIPMX6wMkadtdIqfCa$hnqKQNVhIKvy6WC9DlF3mcUshgB+F3lKKGLglpbrFKk=','2026-07-10 05:43:19.279501',0,'ManKind_Pharma','Ashwin Haribhai','Nair','',1,1,'2026-07-10 05:40:38.000000'),(9,'pbkdf2_sha256$1200000$tnsIJCMC73HMzzJ3uoSpTb$QlcTempZw7mIpptk3/meI0oU4wjC7jwTeoNr2qf86ZM=',NULL,0,'Johnson_and_Johnson','','','',0,1,'2026-07-13 10:31:28.000000'),(10,'pbkdf2_sha256$1200000$yUbGsQ5VeWsEd6xDws17NS$JykN38kAfYKssP/+I20l8yfj5RyNupSoUv6I+S0Nmk0=',NULL,0,'Ciplaltd.','','','',0,1,'2026-07-13 10:52:56.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (2,7,2),(3,8,2),(4,9,2);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` VALUES (11,5,108),(14,5,116),(15,5,117),(18,5,120),(19,5,121),(20,5,122),(21,5,123),(22,5,124),(10,5,125),(9,5,128),(12,5,141),(13,5,144),(16,5,149),(17,5,150),(24,5,151),(23,5,152);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `customer_id` int NOT NULL,
  `product_id` int NOT NULL,
  `variant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cart_items_customer_id_product_id_variant_id_045e129e_uniq` (`customer_id`,`product_id`,`variant_id`),
  KEY `cart_items_product_id_9398bb89_fk_products_productid` (`product_id`),
  KEY `cart_items_variant_id_6e25bb33_fk_product_variants_id` (`variant_id`),
  CONSTRAINT `cart_items_customer_id_1a62dcab_fk_customer_customerId` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customerId`),
  CONSTRAINT `cart_items_variant_id_6e25bb33_fk_product_variants_id` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`),
  CONSTRAINT `cart_items_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES (9,1,'2026-07-11 13:29:05.939292','2026-07-11 13:29:05.939579',19,9,29),(10,3,'2026-07-12 15:43:00.791934','2026-07-12 15:43:00.792565',19,8,27);
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `catergoryid` int NOT NULL DEFAULT '0',
  `Catergorytype` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`catergoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'TABLETS & PILLS','2026-07-09 10:14:29','2026-07-10 05:38:56'),(2,'SYRUPS AND OINTMENTS','2026-07-09 10:14:44','2026-07-10 05:38:52');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CustomerName` varchar(255) DEFAULT NULL,
  `customerId` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `otp_code` varchar(6) DEFAULT NULL,
  `otp_expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`customerId`),
  UNIQUE KEY `uq_customer_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('OM GHAG',19,'ghagom05@gmail.com',NULL,NULL,'2026-07-10 08:42:23','2026-07-10 08:42:59','pbkdf2_sha256$1200000$HFUjhyEX8ri9UmEn9TJxyt$O/tLe3hOVTZ4PFQpLTJqBjQ+JCpK+zmw5NsyVdO06Ow=',1,NULL,NULL),('Priyanka Ghag',20,'prighag555@gmail.com',NULL,NULL,'2026-07-12 15:47:50','2026-07-12 15:48:31','pbkdf2_sha256$1200000$LlDLfewjWMSjK2tMhEtJDu$cVllinbtyGh9XjvEb2CdtqFbp3lbFBZu5eP8+xIukA8=',1,NULL,NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (64,'2026-07-07 12:22:53.535965','1','Categories object (1)',1,'[{\"added\": {}}]',21,4),(65,'2026-07-07 12:23:19.234359','1','Seller object (1)',1,'[{\"added\": {}}]',22,4),(66,'2026-07-07 12:24:41.647655','1','Products object (1)',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Iphone 17 space grey - space grey - 256gb - 8GB RAM\"}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Iphone 17 space grey - space grey - 512GB - 8GB RAM\"}}]',20,4),(67,'2026-07-07 13:02:50.423409','2','Categories object (2)',1,'[{\"added\": {}}]',21,4),(68,'2026-07-07 13:04:02.322669','2','Products object (2)',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Men\'s Short Kurta - S\"}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Men\'s Short Kurta - M\"}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Men\'s Short Kurta - L\"}}]',20,4),(69,'2026-07-07 13:04:10.089289','2','Products object (2)',2,'[]',20,4),(70,'2026-07-07 13:04:42.192894','3','Categories object (3)',1,'[{\"added\": {}}]',21,4),(71,'2026-07-07 13:05:27.832794','3','Categories object (3)',2,'[{\"changed\": {\"fields\": [\"Catergorytype\"]}}]',21,4),(72,'2026-07-07 13:06:32.276935','3','Products object (3)',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Sanjeev Kapoor Classic Kitchen Essentials - 2L\"}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Sanjeev Kapoor Classic Kitchen Essentials - 4L\"}}]',20,4),(73,'2026-07-08 09:27:30.022547','15','OM GHAG',3,'',30,4),(74,'2026-07-08 09:27:35.022525','13','OM GHAG',3,'',30,4),(75,'2026-07-08 12:09:15.745776','5','New_clothes_Enterprise',1,'[{\"added\": {}}]',26,4),(76,'2026-07-08 12:11:20.262744','5','New_clothes_Enterprise',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Staff status\", \"User permissions\"]}}]',26,4),(77,'2026-07-09 09:58:13.997481','5','New_clothes_Enterprise',2,'[{\"changed\": {\"fields\": [\"User permissions\"]}}]',26,4),(78,'2026-07-09 10:00:45.801930','2','Sellers',1,'[{\"added\": {}}]',24,4),(79,'2026-07-09 10:01:01.062577','5','New_clothes_Enterprise',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',26,4),(80,'2026-07-09 10:01:23.536069','5','New_clothes_Enterprise',2,'[]',26,4),(81,'2026-07-09 10:07:50.849720','2','Sellers',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',24,4),(82,'2026-07-09 10:09:13.482301','5','Corona_Remedies',2,'[{\"changed\": {\"fields\": [\"Username\"]}}]',26,4),(83,'2026-07-09 10:11:24.456241','5','Corona_Remedies',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',26,4),(84,'2026-07-09 10:13:57.783001','3','Categories object (3)',3,'',21,4),(85,'2026-07-09 10:14:02.261844','2','Categories object (2)',3,'',21,4),(86,'2026-07-09 10:14:05.929175','1','Categories object (1)',3,'',21,4),(87,'2026-07-09 10:14:28.508245','1','Categories object (1)',1,'[{\"added\": {}}]',21,4),(88,'2026-07-09 10:14:43.590771','2','Categories object (2)',1,'[{\"added\": {}}]',21,4),(89,'2026-07-09 10:25:59.667013','4','Products object (4)',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Crocin - pain relief paracetamol - Variant #17\"}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Crocin - pain relief paracetamol - Variant #18\"}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Crocin - pain relief paracetamol - Variant #19\"}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Crocin - pain relief paracetamol - Variant #20\"}}]',20,5),(90,'2026-07-09 10:30:37.194385','5','Corona_Remedies',2,'[{\"changed\": {\"fields\": [\"Groups\", \"User permissions\"]}}]',26,4),(91,'2026-07-09 10:42:04.971576','4','Products object (4)',2,'[{\"changed\": {\"fields\": [\"Price\", \"Discounted prices\"]}}]',20,5),(92,'2026-07-09 10:44:04.972946','6','Torrent_Pharma',1,'[{\"added\": {}}]',26,4),(93,'2026-07-09 10:47:49.815325','6','Torrent_Pharma',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email address\", \"Staff status\", \"User permissions\"]}}]',26,4),(95,'2026-07-09 11:27:34.176355','1','Seller object (1)',3,'',22,4),(96,'2026-07-09 11:28:26.193093','2','Seller object (2)',2,'[]',22,4),(97,'2026-07-09 11:28:36.754783','5','Products object (5)',3,'',20,4),(99,'2026-07-09 11:31:55.197845','6','Torrent_Pharma',2,'[{\"changed\": {\"fields\": [\"User permissions\"]}}]',26,4),(100,'2026-07-09 11:55:34.085707','6','Products object (6)',3,'',20,4),(101,'2026-07-09 11:55:54.861535','6','Torrent_Pharma',3,'',26,4),(102,'2026-07-09 11:56:13.275021','7','Torrent_Pharma',1,'[{\"added\": {}}]',26,4),(103,'2026-07-09 11:56:51.834412','7','Torrent_Pharma',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Staff status\", \"Groups\"]}}]',26,4),(104,'2026-07-09 11:58:01.334562','7','Products object (7)',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Xtpara paracetamol - Variant #25\"}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Xtpara paracetamol - Variant #26\"}}]',20,7),(105,'2026-07-09 12:05:47.108536','7','Products object (7)',3,'',20,4),(106,'2026-07-10 04:55:25.718934','3','Seller object (3)',1,'[{\"added\": {}}]',22,4),(107,'2026-07-10 04:56:56.547373','4','Products object (4)',2,'[]',20,4),(108,'2026-07-10 04:59:02.692056','8','Products object (8)',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Xtpara paracetamol - Variant #27\"}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Xtpara paracetamol - Variant #28\"}}]',20,7),(109,'2026-07-10 05:22:12.417359','9','Products object (9)',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Toldin-ER Pain Killer - Variant #29\"}}]',20,7),(110,'2026-07-10 05:22:57.665983','9','Products object (9)',2,'[{\"added\": {\"name\": \"product variant\", \"object\": \"Toldin-ER Pain Killer - Variant #30\"}}]',20,7),(111,'2026-07-10 05:38:52.006789','2','Categories object (2)',2,'[{\"changed\": {\"fields\": [\"Catergorytype\"]}}]',21,4),(112,'2026-07-10 05:38:55.881140','1','Categories object (1)',2,'[]',21,4),(113,'2026-07-10 05:40:39.206711','8','ManKind_Pharma',1,'[{\"added\": {}}]',26,4),(114,'2026-07-10 05:41:31.483324','8','ManKind_Pharma',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Staff status\", \"Groups\"]}}]',26,4),(115,'2026-07-10 05:43:01.069820','4','Seller object (4)',1,'[{\"added\": {}}]',22,4),(116,'2026-07-10 05:47:32.557713','10','Products object (10)',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Mupiways - Mupirocin Ointment IP 20GM - Variant #31\"}}, {\"added\": {\"name\": \"product variant\", \"object\": \"Mupiways - Mupirocin Ointment IP 20GM - Variant #32\"}}]',20,8),(117,'2026-07-10 08:39:29.066348','18','OM GHAG',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',30,4),(118,'2026-07-10 08:39:34.402020','18','OM GHAG',2,'[]',30,4),(119,'2026-07-10 08:40:25.681576','18','OM GHAG',3,'',30,4),(120,'2026-07-10 08:40:33.577393','17','khushi rai',3,'',30,4),(121,'2026-07-10 08:40:38.993079','16','Joshi Aarsh',3,'',30,4),(122,'2026-07-10 10:22:08.509896','9','Products object (9)',2,'[{\"changed\": {\"name\": \"product variant\", \"object\": \"Toldin-ER Pain Killer - Variant #30\", \"fields\": [\"Stock\"]}}]',20,4),(123,'2026-07-11 09:34:25.584203','9','Products object (9)',2,'[{\"changed\": {\"fields\": [\"Generic name\"]}}]',20,7),(124,'2026-07-11 09:34:44.772458','8','Products object (8)',2,'[{\"changed\": {\"fields\": [\"Productname\", \"Generic name\"]}}]',20,7),(125,'2026-07-11 09:35:17.148492','4','Products object (4)',2,'[{\"changed\": {\"fields\": [\"Productname\", \"Generic name\"]}}]',20,5),(126,'2026-07-13 09:50:18.095538','1','Headache',1,'[{\"added\": {}}]',40,4),(127,'2026-07-13 09:50:47.260656','2','Migraine-Headache',1,'[{\"added\": {}}]',40,4),(128,'2026-07-13 09:50:53.081831','3','Cold',1,'[{\"added\": {}}]',40,4),(129,'2026-07-13 09:50:56.934244','4','Cough',1,'[{\"added\": {}}]',40,4),(130,'2026-07-13 09:51:03.342827','5','Throat Ache',1,'[{\"added\": {}}]',40,4),(131,'2026-07-13 09:51:11.309792','6','Body Ache',1,'[{\"added\": {}}]',40,4),(132,'2026-07-13 10:01:51.778153','4','Products object (4)',2,'[{\"changed\": {\"fields\": [\"Contraindications\"]}}]',20,4),(133,'2026-07-13 10:02:04.101635','2','Migraine',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',40,4),(134,'2026-07-13 10:02:11.071530','2','Migraine',2,'[{\"changed\": {\"fields\": [\"Slug\"]}}]',40,4),(135,'2026-07-13 10:02:13.981159','2','Migraine',2,'[]',40,4),(136,'2026-07-13 10:13:42.432029','9','Products object (9)',2,'[{\"changed\": {\"fields\": [\"Contraindications\"]}}]',20,4),(137,'2026-07-13 10:13:52.315509','7','Inflammation',1,'[{\"added\": {}}]',40,4),(138,'2026-07-13 10:14:05.721640','9','Products object (9)',2,'[{\"added\": {\"name\": \"product symptom\", \"object\": \"ProductSymptom object (1)\"}}, {\"added\": {\"name\": \"product symptom\", \"object\": \"ProductSymptom object (2)\"}}]',20,4),(139,'2026-07-13 10:31:29.423955','9','Johnson_and_Johnson',1,'[{\"added\": {}}]',26,4),(140,'2026-07-13 10:31:33.441403','5','Seller object (5)',1,'[{\"added\": {}}]',22,4),(141,'2026-07-13 10:44:57.145234','11','Products object (11)',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product symptom\", \"object\": \"ProductSymptom object (3)\"}}, {\"added\": {\"name\": \"product symptom\", \"object\": \"ProductSymptom object (4)\"}}, {\"added\": {\"name\": \"product symptom\", \"object\": \"ProductSymptom object (5)\"}}]',20,4),(142,'2026-07-13 10:52:12.723557','12','Products object (12)',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product symptom\", \"object\": \"ProductSymptom object (6)\"}}]',20,4),(143,'2026-07-13 10:52:28.832517','9','Johnson_and_Johnson',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',26,4),(144,'2026-07-13 10:52:56.533154','10','Ciplaltd.',1,'[{\"added\": {}}]',26,4),(145,'2026-07-13 10:53:01.460191','10','Ciplaltd.',2,'[]',26,4),(146,'2026-07-13 10:53:49.854236','6','Seller object (6)',1,'[{\"added\": {}}]',22,4),(147,'2026-07-13 10:54:08.767164','13','Products object (13)',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product symptom\", \"object\": \"ProductSymptom object (7)\"}}]',20,4),(148,'2026-07-13 11:02:17.326518','14','Products object (14)',1,'[{\"added\": {}}, {\"added\": {\"name\": \"product symptom\", \"object\": \"ProductSymptom object (8)\"}}, {\"added\": {\"name\": \"product symptom\", \"object\": \"ProductSymptom object (9)\"}}]',20,4),(149,'2026-07-13 11:04:41.334175','8','Products object (8)',2,'[{\"changed\": {\"fields\": [\"Composition\", \"Contraindications\"]}}, {\"added\": {\"name\": \"product symptom\", \"object\": \"ProductSymptom object (10)\"}}, {\"added\": {\"name\": \"product symptom\", \"object\": \"ProductSymptom object (11)\"}}]',20,4),(150,'2026-07-13 11:05:02.540564','4','Products object (4)',2,'[{\"changed\": {\"fields\": [\"Composition\"]}}, {\"added\": {\"name\": \"product symptom\", \"object\": \"ProductSymptom object (12)\"}}, {\"added\": {\"name\": \"product symptom\", \"object\": \"ProductSymptom object (13)\"}}]',20,4);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (23,'admin','logentry'),(24,'auth','group'),(25,'auth','permission'),(26,'auth','user'),(27,'contenttypes','contenttype'),(28,'sessions','session'),(29,'store','admin'),(39,'store','cartitem'),(21,'store','categories'),(30,'store','customer'),(31,'store','orders'),(32,'store','payments'),(20,'store','products'),(33,'store','productvariant'),(34,'store','refund'),(35,'store','reviews'),(36,'store','sale'),(22,'store','seller'),(37,'store','shipment'),(40,'store','symptom'),(38,'store','wishlist');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (20,'contenttypes','0001_initial','2026-07-07 12:04:36.066747'),(21,'auth','0001_initial','2026-07-07 12:04:36.074447'),(22,'admin','0001_initial','2026-07-07 12:04:36.080743'),(23,'admin','0002_logentry_remove_auto_add','2026-07-07 12:04:36.085439'),(24,'admin','0003_logentry_add_action_flag_choices','2026-07-07 12:04:36.091909'),(25,'contenttypes','0002_remove_content_type_name','2026-07-07 12:04:36.097351'),(26,'auth','0002_alter_permission_name_max_length','2026-07-07 12:04:36.103857'),(27,'auth','0003_alter_user_email_max_length','2026-07-07 12:04:36.109897'),(28,'auth','0004_alter_user_username_opts','2026-07-07 12:04:36.116503'),(29,'auth','0005_alter_user_last_login_null','2026-07-07 12:04:36.123688'),(30,'auth','0006_require_contenttypes_0002','2026-07-07 12:04:36.129918'),(31,'auth','0007_alter_validators_add_error_messages','2026-07-07 12:04:36.135183'),(32,'auth','0008_alter_user_username_max_length','2026-07-07 12:04:36.141154'),(33,'auth','0009_alter_user_last_name_max_length','2026-07-07 12:04:36.150042'),(34,'auth','0010_alter_group_name_max_length','2026-07-07 12:04:36.158059'),(35,'auth','0011_update_proxy_permissions','2026-07-07 12:04:36.165202'),(36,'auth','0012_alter_user_first_name_max_length','2026-07-07 12:04:36.170737'),(37,'sessions','0001_initial','2026-07-07 12:04:36.178165'),(38,'store','0001_initial','2026-07-07 12:04:36.185897'),(40,'store','0002_alter_productvariant_unique_together_and_more','2026-07-08 06:48:19.300396');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `variant_id` bigint DEFAULT NULL,
  `seller_id` int DEFAULT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '1',
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orderitems_order` (`order_id`),
  KEY `fk_orderitems_product` (`product_id`),
  KEY `fk_orderitems_variant` (`variant_id`),
  KEY `fk_orderitems_seller` (`seller_id`),
  CONSTRAINT `fk_orderitems_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`orderid`) ON DELETE CASCADE,
  CONSTRAINT `fk_orderitems_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`productId`),
  CONSTRAINT `fk_orderitems_seller` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`sellerid`),
  CONSTRAINT `fk_orderitems_variant` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,8,28,3,10,48.00),(2,2,9,29,3,4,57.50),(3,3,8,27,3,6,25.00),(4,4,4,17,2,1,15.00);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `orderid` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `status` varchar(20) DEFAULT 'placed',
  `total_amount` decimal(10,2) NOT NULL,
  `delivery_address` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`orderid`),
  KEY `fk_orders_customer` (`customer_id`),
  CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customerId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,19,'placed',480.00,'Ramdevnagar','2026-07-11 12:05:45.959123','2026-07-11 12:05:45.959232'),(2,19,'placed',230.00,'Rudraprayag appartment, ramadevanagar, satellite Road Ahmedabad','2026-07-11 12:09:15.874489','2026-07-11 12:09:15.874519'),(3,19,'placed',150.00,'Ramdevnagar','2026-07-11 12:53:03.443590','2026-07-11 12:53:03.443715'),(4,20,'placed',15.00,'rudraprayag','2026-07-12 15:48:58.299027','2026-07-12 15:48:58.299078');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `paymentId` int DEFAULT NULL,
  `PaymentType` varchar(255) DEFAULT NULL,
  `TransactionId` int NOT NULL,
  `OrderId` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`TransactionId`),
  UNIQUE KEY `paymentId` (`paymentId`)
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
-- Table structure for table `product_symptoms`
--

DROP TABLE IF EXISTS `product_symptoms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_symptoms` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `symptom_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_product_symptom` (`product_id`,`symptom_id`),
  KEY `fk_ps_symptom` (`symptom_id`),
  CONSTRAINT `fk_ps_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `fk_ps_symptom` FOREIGN KEY (`symptom_id`) REFERENCES `symptoms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_symptoms`
--

LOCK TABLES `product_symptoms` WRITE;
/*!40000 ALTER TABLE `product_symptoms` DISABLE KEYS */;
INSERT INTO `product_symptoms` VALUES (12,4,1),(13,4,3),(10,8,1),(11,8,3),(2,9,6),(1,9,7),(3,11,3),(4,11,4),(5,11,5),(6,12,5),(7,13,5),(9,14,1),(8,14,2);
/*!40000 ALTER TABLE `product_symptoms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_variants`
--

DROP TABLE IF EXISTS `product_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_variants` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL,
  `discounted_price` decimal(10,2) DEFAULT NULL,
  `stock` int unsigned NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `product_id` int NOT NULL,
  `Dosage_size` int DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `product_variants_product_id_019d9f04` (`product_id`),
  CONSTRAINT `product_variants_chk_1` CHECK ((`stock` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variants`
--

LOCK TABLES `product_variants` WRITE;
/*!40000 ALTER TABLE `product_variants` DISABLE KEYS */;
INSERT INTO `product_variants` VALUES (17,20.00,15.00,14,'','2026-07-09 10:25:59.655902','2026-07-09 10:25:59.655925',4,250,28),(18,33.00,30.00,13,'','2026-07-09 10:25:59.662718','2026-07-09 10:25:59.662738',4,500,28),(19,40.00,35.00,10,'','2026-07-09 10:25:59.663439','2026-07-09 10:25:59.663453',4,250,56),(20,70.00,60.00,11,'','2026-07-09 10:25:59.664053','2026-07-09 10:25:59.664065',4,500,56),(27,35.00,25.00,10,'','2026-07-10 04:59:02.680693','2026-07-10 04:59:02.680755',8,1000,12),(28,70.00,48.00,12,'','2026-07-10 04:59:02.687598','2026-07-10 04:59:02.687704',8,1000,24),(29,85.50,57.50,6,'','2026-07-10 05:22:12.409866','2026-07-10 05:22:12.409885',9,600,10),(30,171.00,110.00,0,'','2026-07-10 05:22:57.664881','2026-07-10 10:22:08.505593',9,600,20),(31,180.00,160.00,17,'','2026-07-10 05:47:32.553700','2026-07-10 05:47:32.553719',10,NULL,1),(32,360.00,320.00,10,'','2026-07-10 05:47:32.556943','2026-07-10 05:47:32.556961',10,NULL,2);
/*!40000 ALTER TABLE `product_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `productId` int NOT NULL AUTO_INCREMENT,
  `productname` varchar(255) NOT NULL,
  `catergoryid` int DEFAULT NULL,
  `sellerid` int NOT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `photo_path` varchar(255) DEFAULT NULL,
  `discounted_prices` int DEFAULT NULL,
  `generic_name` varchar(255) DEFAULT NULL,
  `composition` varchar(255) DEFAULT NULL,
  `contraindications` text,
  PRIMARY KEY (`productId`),
  KEY `catergoryId` (`catergoryid`),
  KEY `sellerid` (`sellerid`),
  KEY `idx_generic_name` (`generic_name`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`catergoryid`) REFERENCES `categories` (`catergoryid`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`sellerid`) REFERENCES `seller` (`sellerid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (4,'Crocin - pain relief tablet',1,2,20,'2026-07-09 10:26:00','2026-07-13 11:05:03','products/CROCIN.jpg',15,'Paracetamol','Acetomenophine','Known allergy (hypersensitivity) to paracetamol, Severe liver disease or active liver failure, Heavy or chronic alcohol consumption, Taking other medicines containing paracetamol.'),(8,'Xtpara',1,3,35,'2026-07-10 04:59:03','2026-07-13 11:04:41','products/xtpara_SHF5DbQ.jpg',25,'Paracetamol','Acetaminophen','severe active liver disease, a history of hypersensitivity to paracetamol, or if you consume alcohol heavily'),(9,'Toldin-ER Pain Killer',1,3,86,'2026-07-10 05:22:12','2026-07-13 10:14:06','products/toldin-er-tablets.jpeg',58,'Etodolac',NULL,'❌ Stomach ulcers or gastrointestinal bleeding\r\n❌ Allergy to etodolac, aspirin, or other NSAIDs\r\n❌ Severe kidney or liver disease\r\n❌ Severe heart failure or after recent heart bypass surgery\r\n❌ During the third trimester of pregnancy\r\n⚠️ Use cautiously in people with high blood pressure, heart disease, asthma triggered by NSAIDs, or those taking blood thinners.'),(10,'Mupiways - Mupirocin Ointment IP 20GM',2,4,180,'2026-07-10 05:47:33','2026-07-10 05:47:33','products/Mupiways_-_Mupirocin_Ointment_IP.png',160,NULL,NULL,NULL),(11,'Benadryl syrup 100ML',2,5,170,'2026-07-13 10:44:57','2026-07-13 10:44:57','products/benadryl.jpg',147,'diphenhydramine','Diphenhydramine (14.08mg/5ml) + Ammonium Chloride (138mg/5ml) + Sodium Citrate (57.03mg/5ml)','>Known allergy (hypersensitivity) to any of the ingredients in the syrup.\r\n>Children below the age specified on the product label (age restrictions vary by formulation and country).\r\n>Severe liver disease (use only if advised by a doctor).\r\n>Severe breathing problems, such as an acute asthma attack, if the formulation contains an antihistamine like diphenhydramine.\r\n>Use with monoamine oxidase inhibitors (MAOIs) or within 14 days of stopping them, if the formulation contains ingredients that interact with MAOIs.\r\n>Pregnancy and breastfeeding: Use only if recommended by a healthcare professional, as safety depends on the formulation.'),(12,'Thorthrocin-500',1,3,150,'2026-07-13 10:52:13','2026-07-13 10:52:13','products/THORTHROCIN-500.jpg',130,'azithromycin tablets ip 500mg','500 mg of anhydrous azithromycin','Azithromycin tablets IP 500mg are absolutely contraindicated in patients with a known history of severe allergic reactions (hypersensitivity) to azithromycin, erythromycin, or any other macrolide or ketolide antibiotic. Additionally, it is strictly avoided in those with prior histories of cholestatic jaundice or hepatic dysfunction associated with previous azithromycin use.'),(13,'Azicip-500',1,6,145,'2026-07-13 10:54:09','2026-07-13 10:54:09','products/AZICIP-500.jpg',135,'azithromycin tablets ip 500mg','500 mg of anhydrous azithromycin','Azithromycin tablets IP 500mg are absolutely contraindicated in patients with a known history of severe allergic reactions (hypersensitivity) to azithromycin, erythromycin, or any other macrolide or ketolide antibiotic. Additionally, it is strictly avoided in those with prior histories of cholestatic jaundice or hepatic dysfunction associated with previous azithromycin use.'),(14,'Migarid-5',1,6,250,'2026-07-13 11:02:17','2026-07-13 11:02:17','products/Migarid-5_Cipla_migraine.jpg',210,'Flunarizine','Flunarizine Dihydrochloride, 5 mg','if you have a known allergy to flunarizine, a history of depression, or Parkinson\'s disease.');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refund`
--

DROP TABLE IF EXISTS `refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refund` (
  `refundid` int NOT NULL,
  `transactionid` int NOT NULL,
  `amount` int NOT NULL,
  `productid` int NOT NULL,
  `refundtype` varchar(255) NOT NULL,
  `refundReason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`refundid`),
  KEY `transactionid` (`transactionid`),
  KEY `productid` (`productid`),
  CONSTRAINT `refund_ibfk_1` FOREIGN KEY (`transactionid`) REFERENCES `payments` (`TransactionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refund`
--

LOCK TABLES `refund` WRITE;
/*!40000 ALTER TABLE `refund` DISABLE KEYS */;
/*!40000 ALTER TABLE `refund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `reviewid` bigint NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `rating` tinyint unsigned NOT NULL,
  `review` text,
  `photo_path` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`reviewid`),
  UNIQUE KEY `uniq_review_per_customer` (`product_id`,`customer_id`),
  KEY `fk_reviews_customer` (`customer_id`),
  CONSTRAINT `fk_reviews_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customerId`) ON DELETE CASCADE,
  CONSTRAINT `fk_reviews_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  CONSTRAINT `chk_rating_range` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,8,19,5,'Nice Medicine, Very effective and also works pretty fast, i was feeling okay the next morning when i consumed this paracetamol.',NULL,'2026-07-13 06:31:36.415406','2026-07-13 06:31:36.415436'),(2,4,20,4,'Saari che pan 2-3 vaar levi padi, pachi e kaam kari che',NULL,'2026-07-13 11:21:33.694732','2026-07-13 11:21:33.695764'),(3,13,20,5,'Best for Throat pain, only 1 Tablet a day feels enough',NULL,'2026-07-13 11:23:10.670727','2026-07-13 11:23:10.670749'),(4,12,20,4,'you Might require 3-4 days for proper recovery from throat pain but this medicine works indeed.',NULL,'2026-07-13 11:24:53.257581','2026-07-13 11:24:53.257599');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale`
--

DROP TABLE IF EXISTS `sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale` (
  `saleid` int NOT NULL,
  `saleName` varchar(255) DEFAULT NULL,
  `saleduration` int DEFAULT NULL,
  `salestart_date` datetime DEFAULT NULL,
  `saleend_date` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `productId` int DEFAULT NULL,
  PRIMARY KEY (`saleid`),
  KEY `productId` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale`
--

LOCK TABLES `sale` WRITE;
/*!40000 ALTER TABLE `sale` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `sellerid` int NOT NULL AUTO_INCREMENT,
  `sellerName` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`sellerid`),
  KEY `fk_seller_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES (2,'Corona Remedies',NULL,'2026-07-09 10:40:40','2026-07-09 11:28:26',5),(3,'Torrent Pharma','Shilaj','2026-07-10 04:55:26','2026-07-10 04:55:26',7),(4,'ManKind Pharma','Ranip','2026-07-10 05:43:01','2026-07-10 05:43:01',8),(5,'Johnson & Johnson','Nikol','2026-07-13 10:31:33','2026-07-13 10:31:33',9),(6,'Cipla Ltd.','Naroda','2026-07-13 10:53:50','2026-07-13 10:53:50',10);
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipment`
--

DROP TABLE IF EXISTS `shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipment` (
  `shipmentId` int NOT NULL,
  `shipmentCompany` varchar(255) DEFAULT NULL,
  `trackingId` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`shipmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment`
--

LOCK TABLES `shipment` WRITE;
/*!40000 ALTER TABLE `shipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `symptoms`
--

DROP TABLE IF EXISTS `symptoms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `symptoms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `symptoms`
--

LOCK TABLES `symptoms` WRITE;
/*!40000 ALTER TABLE `symptoms` DISABLE KEYS */;
INSERT INTO `symptoms` VALUES (1,'Headache','headache'),(2,'Migraine','migraine'),(3,'Cold','cold'),(4,'Cough','cough'),(5,'Throat Ache','throat-ache'),(6,'Body Ache','body-ache'),(7,'Inflammation','inflammation');
/*!40000 ALTER TABLE `symptoms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `wishlistid` int DEFAULT '1',
  `wishlistItemQuantity` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `session_key` varchar(40) DEFAULT NULL,
  `productId` int NOT NULL,
  `itemNames` varchar(255) DEFAULT NULL,
  `customerId` int DEFAULT NULL,
  `variantId` bigint DEFAULT NULL,
  KEY `fk_wishlist_product` (`productId`),
  KEY `fk_wishlist_customer` (`customerId`),
  KEY `fk_wishlist_variant` (`variantId`),
  CONSTRAINT `fk_wishlist_customer` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customerId`),
  CONSTRAINT `fk_wishlist_variant` FOREIGN KEY (`variantId`) REFERENCES `product_variants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-14  4:43:36
