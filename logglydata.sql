-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: djangodb
-- ------------------------------------------------------
-- Server version	5.5.43-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alert_alert`
--

DROP TABLE IF EXISTS `alert_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alert_alert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `interval` int(10) unsigned NOT NULL,
  `interval_scale` varchar(40) NOT NULL,
  `enable_alert` tinyint(1) NOT NULL,
  `enable_email` tinyint(1) NOT NULL,
  `enable_endpoint` tinyint(1) NOT NULL,
  `savedsearch_id` int(11),
  `last_triggered` datetime,
  `event_display` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alert_alert_customer_id_239d93895701ba2_uniq` (`customer_id`,`name`),
  KEY `alert_alert_edc991fc` (`customer_id`),
  KEY `alert_alert_5d52dd10` (`owner_id`),
  KEY `alert_alert_273ca50a` (`savedsearch_id`),
  CONSTRAINT `customer_id_refs_id_4f1dbb0964dd3653` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`id`),
  CONSTRAINT `owner_id_refs_id_1daf6313d7eec1a1` FOREIGN KEY (`owner_id`) REFERENCES `profile_profile` (`id`),
  CONSTRAINT `savedsearch_id_refs_id_74c70ba35e03153d` FOREIGN KEY (`savedsearch_id`) REFERENCES `savedsearch_savedsearch` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_alert`
--

LOCK TABLES `alert_alert` WRITE;
/*!40000 ALTER TABLE `alert_alert` DISABLE KEYS */;
INSERT INTO `alert_alert` VALUES (1,'slackAlert',101,7,'slackAlert',5,'minutes',1,1,1,1,NULL,10),(2,'slackAlertNew',101,7,'slackAlertNew',5,'minutes',1,1,1,4,NULL,10),(3,'TestAlert',101,7,'test',5,'minutes',1,1,0,4,NULL,10);
/*!40000 ALTER TABLE `alert_alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_alert_alert_endpoints`
--

DROP TABLE IF EXISTS `alert_alert_alert_endpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alert_alert_alert_endpoints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alert_id` int(11) NOT NULL,
  `alertendpoint_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alert_alert_alert_endpoints_alert_id_76763dfc7a7e676b_uniq` (`alert_id`,`alertendpoint_id`),
  KEY `alert_alert_alert_endpoints_296fd947` (`alert_id`),
  KEY `alert_alert_alert_endpoints_856f70c4` (`alertendpoint_id`),
  CONSTRAINT `alertendpoint_id_refs_id_4650c335d9ccda1a` FOREIGN KEY (`alertendpoint_id`) REFERENCES `alert_alertendpoint` (`id`),
  CONSTRAINT `alert_id_refs_id_4e7637f03aa7397` FOREIGN KEY (`alert_id`) REFERENCES `alert_alert` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_alert_alert_endpoints`
--

LOCK TABLES `alert_alert_alert_endpoints` WRITE;
/*!40000 ALTER TABLE `alert_alert_alert_endpoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert_alert_alert_endpoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_alertemailprofile`
--

DROP TABLE IF EXISTS `alert_alertemailprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alert_alertemailprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alert_id` int(11) NOT NULL,
  `profile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alert_alertemailprofile_296fd947` (`alert_id`),
  KEY `alert_alertemailprofile_141c6eec` (`profile_id`),
  CONSTRAINT `alert_id_refs_id_6894360519819290` FOREIGN KEY (`alert_id`) REFERENCES `alert_alert` (`id`),
  CONSTRAINT `profile_id_refs_id_1c5877f81a22a3f8` FOREIGN KEY (`profile_id`) REFERENCES `profile_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_alertemailprofile`
--

LOCK TABLES `alert_alertemailprofile` WRITE;
/*!40000 ALTER TABLE `alert_alertemailprofile` DISABLE KEYS */;
INSERT INTO `alert_alertemailprofile` VALUES (1,1,7),(2,2,7),(3,3,7);
/*!40000 ALTER TABLE `alert_alertemailprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_alertendpoint`
--

DROP TABLE IF EXISTS `alert_alertendpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alert_alertendpoint` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `endpoint_type` varchar(50) NOT NULL,
  `address` longtext NOT NULL,
  `http_method` varchar(50) NOT NULL,
  `hipchat_room_id` varchar(50),
  `hipchat_auth_token` varchar(50),
  `slack_auth_token` varchar(50),
  `slack_channel` varchar(50),
  `victorops_api_key` varchar(50),
  `victorops_routing_key` varchar(50),
  PRIMARY KEY (`id`),
  UNIQUE KEY `alert_alertendpoint_customer_id_11d530b77245ff8d_uniq` (`customer_id`,`name`),
  KEY `alert_alertendpoint_edc991fc` (`customer_id`),
  CONSTRAINT `customer_id_refs_id_3307a42390ed64dc` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_alertendpoint`
--

LOCK TABLES `alert_alertendpoint` WRITE;
/*!40000 ALTER TABLE `alert_alertendpoint` DISABLE KEYS */;
INSERT INTO `alert_alertendpoint` VALUES (91,'slack_integration',101,'Slack Integration','slack','https://slack.com/api/chat.postMessage?token=xoxp-4934576751-4934576753-5024257725-9ce520&channel=C04TGGYNH','POST',NULL,NULL,'xoxp-4934576751-4934576753-5024257725-9ce520','general',NULL,NULL),(93,'victorops_integration',101,'VictorOps Integration','victorops','https://alert.victorops.com/integrations/generic/20131114/alert/3a2ad6ae-8178-44c4-8d97-f4387bce7bf6/test_ops','POST',NULL,NULL,NULL,NULL,'3a2ad6ae-8178-44c4-8d97-f4387bce7bf6','test_ops');
/*!40000 ALTER TABLE `alert_alertendpoint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_alerttriggercondition`
--

DROP TABLE IF EXISTS `alert_alerttriggercondition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alert_alerttriggercondition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `window` int(10) unsigned NOT NULL,
  `value` double NOT NULL,
  `trigger_type` varchar(50) NOT NULL,
  `check` varchar(50) NOT NULL,
  `alert_id` int(11) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `window_interval` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alert_alerttriggercondition_uuid_29461d65e0a08cb_uniq` (`uuid`),
  KEY `alert_alerttriggercondition_296fd947` (`alert_id`),
  CONSTRAINT `alert_id_refs_id_4698cb32b6ef2058` FOREIGN KEY (`alert_id`) REFERENCES `alert_alert` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_alerttriggercondition`
--

LOCK TABLES `alert_alerttriggercondition` WRITE;
/*!40000 ALTER TABLE `alert_alerttriggercondition` DISABLE KEYS */;
INSERT INTO `alert_alerttriggercondition` VALUES (1,5,10,'count','gt',1,'a74f7ac2-2148-4611-b25c-b54f36ca9da9','minutes'),(2,5,10,'count','gt',2,'83eccd7f-137c-4115-96ca-a8c841975662','minutes'),(3,5,1,'count','gt',3,'04dec3d5-e025-43d8-8473-43247168c72b','minutes');
/*!40000 ALTER TABLE `alert_alerttriggercondition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `archive_s3archive`
--

DROP TABLE IF EXISTS `archive_s3archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archive_s3archive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `bucket_name` varchar(255) NOT NULL,
  `log_format` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bucket_name` (`bucket_name`),
  KEY `archive_s3archive_edc991fc` (`customer_id`),
  CONSTRAINT `customer_id_refs_id_4a3df2afc96c9fc1` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archive_s3archive`
--

LOCK TABLES `archive_s3archive` WRITE;
/*!40000 ALTER TABLE `archive_s3archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `archive_s3archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'Admin'),(5,'Heroku'),(4,'Loggly'),(2,'Owner');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_bda51c3c` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_a7792de1` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (178,1,5),(179,1,7),(180,1,8),(181,1,9),(182,1,77),(183,1,78),(186,2,79),(184,2,81),(185,2,82),(187,4,69),(189,5,67),(188,5,81);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_message`
--

DROP TABLE IF EXISTS `auth_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_message_fbfc09f1` (`user_id`),
  CONSTRAINT `user_id_refs_id_9af0b65a` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_message`
--

LOCK TABLES `auth_message` WRITE;
/*!40000 ALTER TABLE `auth_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_e4470c6e` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add message',4,'add_message'),(11,'Can change message',4,'change_message'),(12,'Can delete message',4,'delete_message'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add log entry',8,'add_logentry'),(23,'Can change log entry',8,'change_logentry'),(24,'Can delete log entry',8,'delete_logentry'),(25,'Can add migration history',9,'add_migrationhistory'),(26,'Can change migration history',9,'change_migrationhistory'),(27,'Can delete migration history',9,'delete_migrationhistory'),(28,'Can add Deployment',10,'add__deployment'),(29,'Can change Deployment',10,'change__deployment'),(30,'Can delete Deployment',10,'delete__deployment'),(31,'Can add _ master schema version',11,'add__masterschemaversion'),(32,'Can change _ master schema version',11,'change__masterschemaversion'),(33,'Can delete _ master schema version',11,'delete__masterschemaversion'),(34,'Can add Customer',12,'add__customer'),(35,'Can change Customer',12,'change__customer'),(36,'Can delete Customer',12,'delete__customer'),(37,'Can add provisioner setting',13,'add_provisionersetting'),(38,'Can change provisioner setting',13,'change_provisionersetting'),(39,'Can delete provisioner setting',13,'delete_provisionersetting'),(40,'Can add provisioner',14,'add_provisioner'),(41,'Can change provisioner',14,'change_provisioner'),(42,'Can delete provisioner',14,'delete_provisioner'),(43,'Can add customer',15,'add_customer'),(44,'Can change customer',15,'change_customer'),(45,'Can delete customer',15,'delete_customer'),(46,'Can add alert',16,'add_alert'),(47,'Can change alert',16,'change_alert'),(48,'Can delete alert',16,'delete_alert'),(49,'Can add alert endpoint',17,'add_alertendpoint'),(50,'Can change alert endpoint',17,'change_alertendpoint'),(51,'Can delete alert endpoint',17,'delete_alertendpoint'),(52,'Can add alert trigger condition',18,'add_alerttriggercondition'),(53,'Can change alert trigger condition',18,'change_alerttriggercondition'),(54,'Can delete alert trigger condition',18,'delete_alerttriggercondition'),(55,'Can add alert email profile',19,'add_alertemailprofile'),(56,'Can change alert email profile',19,'change_alertemailprofile'),(57,'Can delete alert email profile',19,'delete_alertemailprofile'),(58,'Can add aws ingestion',20,'add_awsingestion'),(59,'Can change aws ingestion',20,'change_awsingestion'),(60,'Can delete aws ingestion',20,'delete_awsingestion'),(61,'Can add feature',21,'add_feature'),(62,'Can change feature',21,'change_feature'),(63,'Can delete feature',21,'delete_feature'),(64,'Can add subscription',22,'add_subscription'),(65,'Can change subscription',22,'change_subscription'),(66,'Can delete subscription',22,'delete_subscription'),(67,'Manage external storage of logs',23,'archive'),(68,'Use an account with more than one input',23,'multi_input'),(69,'manage your own profile',23,'profile_manage'),(70,'',24,'add_device'),(71,'',24,'change_device'),(72,'',24,'delete_device'),(73,'',26,'add_claim'),(74,'',23,'input_device'),(75,'',23,'input_discover'),(76,'',23,'input_manage'),(77,'',23,'user_make_admin'),(78,'',23,'user_manage'),(79,'',23,'billing'),(80,'',23,'api'),(81,'',23,'customer_manage'),(82,'',23,'upgrade_account'),(83,'Can add aws ingestion',27,'add_aws_ingestion'),(84,'Can change aws ingestion',27,'change_aws_ingestion'),(85,'Can delete aws ingestion',27,'delete_aws_ingestion'),(86,'Can add notification',28,'add_notification'),(87,'Can change notification',28,'change_notification'),(88,'Can delete notification',28,'delete_notification'),(89,'Can add profile',29,'add_profile'),(90,'Can change profile',29,'change_profile'),(91,'Can delete profile',29,'delete_profile'),(92,'Can add receiver',30,'add_receiver'),(93,'Can change receiver',30,'change_receiver'),(94,'Can delete receiver',30,'delete_receiver'),(95,'Can add search context',31,'add_searchcontext'),(96,'Can change search context',31,'change_searchcontext'),(97,'Can delete search context',31,'delete_searchcontext'),(98,'Can add saved search',32,'add_savedsearch'),(99,'Can change saved search',32,'change_savedsearch'),(100,'Can delete saved search',32,'delete_savedsearch'),(101,'Can add trend data',33,'add_trenddata'),(102,'Can change trend data',33,'change_trenddata'),(103,'Can delete trend data',33,'delete_trenddata'),(104,'Can add saved trend',34,'add_savedtrend'),(105,'Can change saved trend',34,'change_savedtrend'),(106,'Can delete saved trend',34,'delete_savedtrend'),(107,'Can add loggly',23,'add_loggly'),(108,'Can change loggly',23,'change_loggly'),(109,'Can delete loggly',23,'delete_loggly'),(110,'Can add runtime flag',35,'add_runtimeflag'),(111,'Can change runtime flag',35,'change_runtimeflag'),(112,'Can delete runtime flag',35,'delete_runtimeflag'),(113,'Can add tab',36,'add_tab'),(114,'Can change tab',36,'change_tab'),(115,'Can delete tab',36,'delete_tab'),(116,'Can add dashboard ui state',37,'add_dashboarduistate'),(117,'Can change dashboard ui state',37,'change_dashboarduistate'),(118,'Can delete dashboard ui state',37,'delete_dashboarduistate'),(119,'Can add search ui state',38,'add_searchuistate'),(120,'Can change search ui state',38,'change_searchuistate'),(121,'Can delete search ui state',38,'delete_searchuistate'),(122,'Can add grid column',39,'add_gridcolumn'),(123,'Can change grid column',39,'change_gridcolumn'),(124,'Can delete grid column',39,'delete_gridcolumn'),(125,'Can add notification dismissal',40,'add_notificationdismissal'),(126,'Can change notification dismissal',40,'change_notificationdismissal'),(127,'Can delete notification dismissal',40,'delete_notificationdismissal'),(128,'Can add source group',41,'add_sourcegroup'),(129,'Can change source group',41,'change_sourcegroup'),(130,'Can delete source group',41,'delete_sourcegroup'),(131,'Can add access rule',42,'add_accessrule'),(132,'Can change access rule',42,'change_accessrule'),(133,'Can delete access rule',42,'delete_accessrule'),(134,'Can add field filter group',43,'add_fieldfiltergroup'),(135,'Can change field filter group',43,'change_fieldfiltergroup'),(136,'Can delete field filter group',43,'delete_fieldfiltergroup'),(137,'Can add field filter',44,'add_fieldfilter'),(138,'Can change field filter',44,'change_fieldfilter'),(139,'Can delete field filter',44,'delete_fieldfilter'),(140,'Can add field filter value',45,'add_fieldfiltervalue'),(141,'Can change field filter value',45,'change_fieldfiltervalue'),(142,'Can delete field filter value',45,'delete_fieldfiltervalue'),(143,'Can add numeric filter value',46,'add_numericfiltervalue'),(144,'Can change numeric filter value',46,'change_numericfiltervalue'),(145,'Can delete numeric filter value',46,'delete_numericfiltervalue'),(146,'Can add s3 archive',47,'add_s3archive'),(147,'Can change s3 archive',47,'change_s3archive'),(148,'Can delete s3 archive',47,'delete_s3archive'),(149,'Can add custom rule metadata',48,'add_customrulemetadata'),(150,'Can change custom rule metadata',48,'change_customrulemetadata'),(151,'Can delete custom rule metadata',48,'delete_customrulemetadata');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (6,'api_api','','','support@loggly.com','sha1$3ba1e$6da1ec27656373b1f6048edb50abb249dc2cbeb6',0,1,0,'2010-05-06 15:04:39','2010-05-06 15:04:39'),(7,'internalapi_internalapi','','','support@loggly.com','sha1$9ea3d$8436dbac157f05e06ea7f8f80aa3a299ad6ba794',1,1,0,'2010-05-06 15:04:39','2010-05-06 15:04:39'),(8,'musikaarapi_musikaarapi','','','niyati@loggly.com','sha1$7e6ae$ab790c03169b4fcda8bb08c8708d178aec604423',1,1,0,'2010-05-06 15:04:39','2010-05-06 15:04:39'),(9,'psqprageet_prageet','prageet','surothiya','prageet@psquickit.com','sha1$fc2f0$a8c4894d38790ae73e3883c7c876d843a166bec4',0,1,0,'2015-07-13 09:01:56','2015-05-15 18:47:10');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_fbfc09f1` (`user_id`),
  KEY `auth_user_groups_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_f0ee9890` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_831107f1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (43,6,4),(44,7,1),(45,8,1),(7,9,1),(8,9,2),(9,9,4);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_fbfc09f1` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_f2045483` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` VALUES (14,6,80);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auto_login_hash`
--

DROP TABLE IF EXISTS `auto_login_hash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auto_login_hash` (
  `cache_key` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  `expires` datetime NOT NULL,
  PRIMARY KEY (`cache_key`),
  KEY `auto_login_hash_expires` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auto_login_hash`
--

LOCK TABLES `auto_login_hash` WRITE;
/*!40000 ALTER TABLE `auto_login_hash` DISABLE KEYS */;
INSERT INTO `auto_login_hash` VALUES (':1:a262d7a5aebd5c15133bbf73f9204c2af27ca0cc','gAKKAQku','2015-05-15 18:54:21');
/*!40000 ALTER TABLE `auto_login_hash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aws_awsingestion`
--

DROP TABLE IF EXISTS `aws_awsingestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aws_awsingestion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `ingestion_location` varchar(255) NOT NULL,
  `ingestion_type` varchar(5) NOT NULL,
  `ingestion_prefix` varchar(1024) NOT NULL,
  `access_key_id` varchar(32) NOT NULL,
  `secret_access_key` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ingestion_location` (`ingestion_location`),
  KEY `aws_awsingestion_edc991fc` (`customer_id`),
  CONSTRAINT `customer_id_refs_id_58dec54b8e29b614` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aws_awsingestion`
--

LOCK TABLES `aws_awsingestion` WRITE;
/*!40000 ALTER TABLE `aws_awsingestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `aws_awsingestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing_feature`
--

DROP TABLE IF EXISTS `billing_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_feature` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subscription_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` int(11) DEFAULT NULL,
  `comment` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `billing_feature_subscription_id_345b9a3b3d145158_uniq` (`subscription_id`,`name`),
  KEY `billing_feature_104f5ac1` (`subscription_id`),
  CONSTRAINT `subscription_id_refs_id_279d55d1936e35cd` FOREIGN KEY (`subscription_id`) REFERENCES `billing_subscription` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_feature`
--

LOCK TABLES `billing_feature` WRITE;
/*!40000 ALTER TABLE `billing_feature` DISABLE KEYS */;
INSERT INTO `billing_feature` VALUES (1,2,'2015-05-15 18:47:10','sourcelocking',1,NULL),(2,2,'2015-05-15 18:47:10','savedsearch',1,NULL),(3,2,'2015-05-15 18:47:10','alerts',1,NULL),(4,2,'2015-05-15 18:47:10','archive',1,NULL),(5,2,'2015-05-15 18:47:10','dashboards',1,NULL);
/*!40000 ALTER TABLE `billing_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing_subscription`
--

DROP TABLE IF EXISTS `billing_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_subscription` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subscription_rate` decimal(9,2) NOT NULL,
  `created` datetime DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `trial_expiration` datetime DEFAULT NULL,
  `retention_days` int(11) NOT NULL,
  `comment` longtext,
  `pricing_schedule` varchar(200) NOT NULL,
  `billing_period` varchar(50) NOT NULL,
  `tier_name` varchar(200) NOT NULL,
  `volume_bytes` bigint(20) NOT NULL,
  `billing_provider` varchar(200) NOT NULL,
  `canceled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_subscription_edc991fc` (`customer_id`),
  CONSTRAINT `customer_id_refs_id_2e3e15d04ae757c8` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_subscription`
--

LOCK TABLES `billing_subscription` WRITE;
/*!40000 ALTER TABLE `billing_subscription` DISABLE KEYS */;
INSERT INTO `billing_subscription` VALUES (1,0.00,NULL,1,NULL,30,NULL,'','','',4096,'',0),(2,0.00,'2015-05-15 18:47:10',101,'2015-06-14 18:47:10',15,'Initial subscription','limit_sgu','monthly','Trial',-1,'noop',0);
/*!40000 ALTER TABLE `billing_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_customer`
--

DROP TABLE IF EXISTS `customer_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subdomain` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created` datetime DEFAULT NULL,
  `provisioner_id` int(11),
  `affiliate_code` varchar(30),
  `sent_data` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subdomain` (`subdomain`),
  KEY `customer_customer_a912d4c7` (`provisioner_id`),
  CONSTRAINT `provisioner_id_refs_id_78fff5a2a498723a` FOREIGN KEY (`provisioner_id`) REFERENCES `customer_provisioner` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_customer`
--

LOCK TABLES `customer_customer` WRITE;
/*!40000 ALTER TABLE `customer_customer` DISABLE KEYS */;
INSERT INTO `customer_customer` VALUES (1,'loggly','Community',NULL,4,NULL,0),(100,'fetests','FrontendTester',NULL,4,NULL,0),(101,'psqprageet','psq','2015-05-15 18:47:10',1,'',1);
/*!40000 ALTER TABLE `customer_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_provisioner`
--

DROP TABLE IF EXISTS `customer_provisioner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_provisioner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` longtext,
  `affiliate_code` varchar(30),
  `inputs` longtext NOT NULL,
  `ip_whitelist` longtext NOT NULL,
  `external_billing` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `affiliate_code` (`affiliate_code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_provisioner`
--

LOCK TABLES `customer_provisioner` WRITE;
/*!40000 ALTER TABLE `customer_provisioner` DISABLE KEYS */;
INSERT INTO `customer_provisioner` VALUES (1,'2011-01-01 00:00:00',1,'Loggly','Provisioned by Loggly, Inc.','loggly','[[\"default\", \"HTTP\", \"Default input.\"]]','{}',0),(2,'2011-01-01 00:00:00',1,'Heroku','Provisioned by Heroku, Inc.','heroku','[[\"default\", \"syslogtcp\", \"\"]]','{}',1),(3,'2011-01-01 00:00:00',1,'Engine Yard','Provisioned by Engine Yard, Inc.','EngineYard','{}','{}',1),(4,'2011-01-01 00:00:00',1,'Loggly Manual Create','Provisioned by Loggly\'s Manual Create Dept.','loggly_manual_create','[[\"tcptest\", \"syslogtcp\", \"\"], [\"udptest\", \"syslogudp\", \"\"], [\"httptest\", \"HTTP\", \"\"]]','{}',1),(5,'2011-11-04 00:00:00',1,'CumuLogic','Signups via CumuLogic.','cumulogic','[[\"default\", \"HTTP\", \"Default input.\"]]','{}',0),(6,'2012-08-16 00:00:00',1,'Loggly Enterprise','Loggly Enterprise','logglyenterprise','[[\"default\", \"HTTP\", \"Default input.\"]]','{}',0);
/*!40000 ALTER TABLE `customer_provisioner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_provisioner_groups`
--

DROP TABLE IF EXISTS `customer_provisioner_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_provisioner_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provisioner_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_provisioner_group_provisioner_id_1129f4bf422ed464_uniq` (`provisioner_id`,`group_id`),
  KEY `customer_provisioner_groups_a912d4c7` (`provisioner_id`),
  KEY `customer_provisioner_groups_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_2a0f74a0706e4f44` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `provisioner_id_refs_id_ebf1ef42246cddd` FOREIGN KEY (`provisioner_id`) REFERENCES `customer_provisioner` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_provisioner_groups`
--

LOCK TABLES `customer_provisioner_groups` WRITE;
/*!40000 ALTER TABLE `customer_provisioner_groups` DISABLE KEYS */;
INSERT INTO `customer_provisioner_groups` VALUES (241,1,1),(242,1,2),(243,1,4),(244,2,5),(245,3,1),(246,3,2),(247,3,4),(248,4,1),(249,4,2),(250,4,4),(251,5,1),(252,5,2),(253,5,4),(254,6,1),(255,6,2),(256,6,4);
/*!40000 ALTER TABLE `customer_provisioner_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_provisionersetting`
--

DROP TABLE IF EXISTS `customer_provisionersetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_provisionersetting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provisioner_id` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `value` longtext,
  `description` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_provisionersettin_provisioner_id_44008d0f37f2af51_uniq` (`provisioner_id`,`name`),
  KEY `customer_provisionersetting_a912d4c7` (`provisioner_id`),
  CONSTRAINT `provisioner_id_refs_id_5896e99e7ef19304` FOREIGN KEY (`provisioner_id`) REFERENCES `customer_provisioner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_provisionersetting`
--

LOCK TABLES `customer_provisionersetting` WRITE;
/*!40000 ALTER TABLE `customer_provisionersetting` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_provisionersetting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_fbfc09f1` (`user_id`),
  KEY `django_admin_log_e4470c6e` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_288599e6` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c8665aa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'message','auth','message'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'log entry','admin','logentry'),(9,'migration history','south','migrationhistory'),(10,'Deployment','masterdb','_deployment'),(11,'_ master schema version','masterdb','_masterschemaversion'),(12,'Customer','masterdb','_customer'),(13,'provisioner setting','customer','provisionersetting'),(14,'provisioner','customer','provisioner'),(15,'customer','customer','customer'),(16,'alert','alert','alert'),(17,'alert endpoint','alert','alertendpoint'),(18,'alert trigger condition','alert','alerttriggercondition'),(19,'alert email profile','alert','alertemailprofile'),(20,'aws ingestion','aws','awsingestion'),(21,'feature','billing','feature'),(22,'subscription','billing','subscription'),(23,'','loggly','loggly'),(24,'','device','device'),(25,'','input','input'),(26,'','device','claim'),(27,'','aws','aws ingestion'),(28,'','notifications','notification'),(29,'','profile','profile'),(30,'','receiver','receiver'),(31,'search context','savedsearch','searchcontext'),(32,'saved search','savedsearch','savedsearch'),(33,'trend data','savedsearch','trenddata'),(34,'saved trend','savedsearch','savedtrend'),(35,'runtime flag','loggly','runtimeflag'),(36,'tab','tabmanager','tab'),(37,'dashboard ui state','tabmanager','dashboarduistate'),(38,'search ui state','tabmanager','searchuistate'),(39,'grid column','tabmanager','gridcolumn'),(40,'notification dismissal','notifications','notificationdismissal'),(41,'source group','source','sourcegroup'),(42,'access rule','receiver','accessrule'),(43,'field filter group','fieldfilter','fieldfiltergroup'),(44,'field filter','fieldfilter','fieldfilter'),(45,'field filter value','fieldfilter','fieldfiltervalue'),(46,'numeric filter value','fieldfilter','numericfiltervalue'),(47,'s3 archive','archive','s3archive'),(48,'custom rule metadata','parser','customrulemetadata');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_c25c2c28` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('016788f3e28daa103cd69c8b5ef6de1c','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:05:53'),('021f1873eeac32595a495525b85216f0','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-06-17 19:07:09'),('2676ef89d1e21e72214ab8c07093998b','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 10:40:55'),('2c9e4d96a906aa97f301735605a37e5e','NWJjNDYzOWMwZTk3YTliMjQxMmYwMmUwMDIwMzMwNDRhNDM1NzU4MzqAAn1xAShVCnRlc3Rjb29r\naWVVBndvcmtlZFUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tl\nbmRzLk1vZGVsQmFja2VuZFUNX2F1dGhfdXNlcl9pZIoBCXUu\n','2015-06-24 06:04:13'),('2dd51672e7de5600831cea70b4eea6b1','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-20 08:48:27'),('322a9f5181b29198d04a0ba3e0fbbf49','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-20 08:48:27'),('360677017b142f6a2b61206a4f2bb850','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-15 12:30:18'),('3b1e45d333fe8956fd8889599a25be1b','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:17:54'),('3c0b3d709d13cb13d9db0e76dcbd4751','NTJiYjJiOTZkNDRhNmE5ZjhjZjFmMWJjYjlmNTRjMWFiNmQwNTI4YzqAAn1xAShVCnRlc3Rjb29r\naWVVBndvcmtlZFUTc2hvd19sb2dpbl90cmFja2Vyc4hVDV9hdXRoX3VzZXJfaWSKAQlVEl9hdXRo\nX3VzZXJfYmFja2VuZFUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmRV\nFHNlZW5fc3VnZ2VzdF9wYXltZW50Y2RhdGV0aW1lCmRhdGV0aW1lCnECVQoH3wYIAyElAPEchVJx\nA3Uu\n','2015-06-15 03:34:47'),('3e2f534d57b726dd630b1f34fc115342','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:02:44'),('3f66e485dc1e250e9d2f2349acc49b92','YmEzYmVhMTNhNGZjYjFjZDU1NzlmNzVhMTBiZTM0YmMxZWJiYzY0MzqAAn1xAShVCnRlc3Rjb29r\naWVVBndvcmtlZFUNX2F1dGhfdXNlcl9pZIoBCVUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28u\nY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZFUUc2Vlbl9zdWdnZXN0X3BheW1lbnRj\nZGF0ZXRpbWUKZGF0ZXRpbWUKcQJVCgffBgwFHBAJKjqFUnEDdS4=\n','2015-06-19 05:51:47'),('416f50d3992efcbab4351efad0b4311a','NDZhZTE0OGM0NTRiNTBkMWEyY2RjZTAyM2FlMWJmNTFhZDUzMjA1OTqAAn1xAShVCnRlc3Rjb29r\naWVVBndvcmtlZFUTc2hvd19sb2dpbl90cmFja2Vyc4hVDV9hdXRoX3VzZXJfaWSKAQlVEl9hdXRo\nX3VzZXJfYmFja2VuZFUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmRV\nFHNlZW5fc3VnZ2VzdF9wYXltZW50Y2RhdGV0aW1lCmRhdGV0aW1lCnECVQoH3wYFBBIaBKpxhVJx\nA3Uu\n','2015-06-12 04:18:48'),('4363646584d3283b28e7cb9ad35e5d6c','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:05:11'),('4383ec79599d8282238fc6bea790caf5','MDI4MzA3NTExODA1MjRiN2ZhY2RmY2VhZDIxYTBiNDA4ODQ3MGNmMjqAAn1xAShVCnRlc3Rjb29r\naWVVBndvcmtlZFUNX2F1dGhfdXNlcl9pZIoBCVUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28u\nY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHUu\n','2015-05-28 17:32:23'),('43b4272467ffb2565cf10fe4a6a65ed9','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-20 08:48:27'),('47b605b998e688e127f2d3796a57a1c8','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:04:40'),('52aa446eed01f51276a694c997ea85c5','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:05:26'),('5c059f4db26ea7d76217621555a8d767','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-20 09:01:56'),('688292a716fb84189796eccb25fb5e22','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:05:04'),('68b6afabacdac9f1ce5ac5e8b8f6d516','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:17:54'),('6bd210b0fc64fa11407c38265d427b96','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-20 08:48:27'),('6c1442b5a257e9a4bbf09fd42b0e7f41','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-14 08:11:28'),('6cf9bfebc96385889ae835ab9ff308d9','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:04:23'),('6d4776abf3a5028f64ca523cca333001','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 10:38:27'),('7280d79b7f85cec68c918e6791f06a55','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 10:39:30'),('7a6b929268605bdc42d4997fd2e49a17','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 10:40:12'),('7c996f4c7f07d2aeb2febdfa2f7c806d','ZjM5OTU3N2I1MTljZmYwZjczMDgyZjU4NjIwYjQ5Y2MxZDQ2MzA3ZDqAAn1xAShVCnRlc3Rjb29r\naWVVBndvcmtlZFUTc2hvd19sb2dpbl90cmFja2Vyc4hVDV9hdXRoX3VzZXJfaWSKAQlVEl9hdXRo\nX3VzZXJfYmFja2VuZFUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmRV\nFHNlZW5fc3VnZ2VzdF9wYXltZW50Y2RhdGV0aW1lCmRhdGV0aW1lCnECVQoH3wYKFBcaCHpWhVJx\nA3Uu\n','2015-06-17 20:33:14'),('8434731106ce574e8f8ef92ea4001966','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:04:29'),('84e2cf22a406ceb78fdbf5ddf56b3815','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 10:43:01'),('8832774402c8e4620c799863dfbfa0e8','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:05:43'),('920ab797ff3746570e5bf3a077de77ff','ZmQ3Y2YwMTBkYmQ3MDU3NDIxZWQ0Nzk4YzcyNjkzZDhjNjkwNjc4YTqAAn1xAVUKdGVzdGNvb2tp\nZVUGd29ya2Vkcy4=\n','2015-07-06 13:27:40'),('a060df1d8d82fea8e1f044d95e8546d5','ZmQ3Y2YwMTBkYmQ3MDU3NDIxZWQ0Nzk4YzcyNjkzZDhjNjkwNjc4YTqAAn1xAVUKdGVzdGNvb2tp\nZVUGd29ya2Vkcy4=\n','2015-06-26 05:25:51'),('adbf8239ee4d8d6b530c27c8665d7c3e','NWJjNDYzOWMwZTk3YTliMjQxMmYwMmUwMDIwMzMwNDRhNDM1NzU4MzqAAn1xAShVCnRlc3Rjb29r\naWVVBndvcmtlZFUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tl\nbmRzLk1vZGVsQmFja2VuZFUNX2F1dGhfdXNlcl9pZIoBCXUu\n','2015-07-20 09:11:49'),('b8ec0873a25bc6202c44b7ddde860441','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 10:40:13'),('bce697622ac4c78647e8ce6628d8b9ac','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:17:54'),('be5aa807f1370777ed2bf0f02dd80be9','NWJjNDYzOWMwZTk3YTliMjQxMmYwMmUwMDIwMzMwNDRhNDM1NzU4MzqAAn1xAShVCnRlc3Rjb29r\naWVVBndvcmtlZFUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tl\nbmRzLk1vZGVsQmFja2VuZFUNX2F1dGhfdXNlcl9pZIoBCXUu\n','2015-07-23 15:31:25'),('c2ae58752bf0da91922c53bb2ecb0e8a','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 10:40:12'),('c55ec2add94c61fdec5f014bcbcf1837','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 10:39:10'),('cf40ac49bfa9e9d22c36db1ecf5e6b22','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-06-17 19:06:45'),('d56f46c30b8f00c63a760ba461a554f2','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-05-22 19:01:00'),('dfa660100198217e3df93580a3be6628','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:05:20'),('e184724d879f9953d945575890ea2dc0','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:06:02'),('ea39e595abd8e19d2b0cc304ae77120b','N2I0MTM2MmJjMTIwMGVkNGFkODI0OWIxNzY4YWI5OTc3NmQ3NmJhMDqAAn1xAShVCnRlc3Rjb29r\naWVVBndvcmtlZFUTc2hvd19sb2dpbl90cmFja2Vyc4hVDV9hdXRoX3VzZXJfaWSKAQlVEl9hdXRo\nX3VzZXJfYmFja2VuZFUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmR1\nLg==\n','2015-07-16 11:46:52'),('eb59bf8d2c79d341de37e7381766e1c3','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:04:14'),('ef5b974af67f8f58dace2f1c8af79411','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-06-27 09:36:32'),('efe833f7df06fd1fac25e8f83234522c','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 10:39:09'),('f5be773db834ff5e483e21baec18d38e','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-16 11:17:54'),('f68a227bdff8476cd420f898ad9449d7','OWVlMTE5ODU0MWE5ZTQ0NTU2MjM3MDk0MjQ2YmE2OThlMzc2ZWRhMTqAAn1xAS4=\n','2015-07-20 09:01:56'),('f78956e3ec0de1e95cb3e070530c5a11','MDI4MzA3NTExODA1MjRiN2ZhY2RmY2VhZDIxYTBiNDA4ODQ3MGNmMjqAAn1xAShVCnRlc3Rjb29r\naWVVBndvcmtlZFUNX2F1dGhfdXNlcl9pZIoBCVUSX2F1dGhfdXNlcl9iYWNrZW5kVSlkamFuZ28u\nY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHUu\n','2015-07-23 11:00:26');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldfilter_fieldfilter`
--

DROP TABLE IF EXISTS `fieldfilter_fieldfilter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldfilter_fieldfilter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field` varchar(1000) NOT NULL,
  `operator` varchar(50) NOT NULL,
  `field_filter_group_id` int(11) NOT NULL,
  `field_type` varchar(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fieldfilter_fieldfilter_7ee1101` (`field_filter_group_id`),
  CONSTRAINT `field_filter_group_id_refs_id_a6c4626d5d856db` FOREIGN KEY (`field_filter_group_id`) REFERENCES `fieldfilter_fieldfiltergroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldfilter_fieldfilter`
--

LOCK TABLES `fieldfilter_fieldfilter` WRITE;
/*!40000 ALTER TABLE `fieldfilter_fieldfilter` DISABLE KEYS */;
/*!40000 ALTER TABLE `fieldfilter_fieldfilter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldfilter_fieldfiltergroup`
--

DROP TABLE IF EXISTS `fieldfilter_fieldfiltergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldfilter_fieldfiltergroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldfilter_fieldfiltergroup`
--

LOCK TABLES `fieldfilter_fieldfiltergroup` WRITE;
/*!40000 ALTER TABLE `fieldfilter_fieldfiltergroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `fieldfilter_fieldfiltergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldfilter_fieldfiltervalue`
--

DROP TABLE IF EXISTS `fieldfilter_fieldfiltervalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldfilter_fieldfiltervalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_filter_id` int(11) NOT NULL,
  `value` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fieldfilter_fieldfiltervalue_1170bf81` (`field_filter_id`),
  CONSTRAINT `field_filter_id_refs_id_57439c79d9d15783` FOREIGN KEY (`field_filter_id`) REFERENCES `fieldfilter_fieldfilter` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldfilter_fieldfiltervalue`
--

LOCK TABLES `fieldfilter_fieldfiltervalue` WRITE;
/*!40000 ALTER TABLE `fieldfilter_fieldfiltervalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `fieldfilter_fieldfiltervalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldfilter_numericfiltervalue`
--

DROP TABLE IF EXISTS `fieldfilter_numericfiltervalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldfilter_numericfiltervalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_filter_id` int(11) NOT NULL,
  `value` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fieldfilter_numericfiltervalue_1170bf81` (`field_filter_id`),
  CONSTRAINT `field_filter_id_refs_id_1298e96ca89a804c` FOREIGN KEY (`field_filter_id`) REFERENCES `fieldfilter_fieldfilter` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldfilter_numericfiltervalue`
--

LOCK TABLES `fieldfilter_numericfiltervalue` WRITE;
/*!40000 ALTER TABLE `fieldfilter_numericfiltervalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `fieldfilter_numericfiltervalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loggly_loggly`
--

DROP TABLE IF EXISTS `loggly_loggly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loggly_loggly` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loggly_loggly`
--

LOCK TABLES `loggly_loggly` WRITE;
/*!40000 ALTER TABLE `loggly_loggly` DISABLE KEYS */;
/*!40000 ALTER TABLE `loggly_loggly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loggly_runtimeflag`
--

DROP TABLE IF EXISTS `loggly_runtimeflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loggly_runtimeflag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loggly_runtimeflag`
--

LOCK TABLES `loggly_runtimeflag` WRITE;
/*!40000 ALTER TABLE `loggly_runtimeflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `loggly_runtimeflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications_notification`
--

DROP TABLE IF EXISTS `notifications_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` varchar(200) NOT NULL,
  `text` varchar(2048) NOT NULL,
  `expires` datetime NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `msg_key` varchar(256) NOT NULL,
  `msg_type` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notifications_notification_customer_id_49ddba085da924dd_uniq` (`customer_id`,`msg_key`),
  KEY `notifications_notification_edc991fc` (`customer_id`),
  CONSTRAINT `customer_id_refs_id_23c8676e22652029` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications_notification`
--

LOCK TABLES `notifications_notification` WRITE;
/*!40000 ALTER TABLE `notifications_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications_notification_dismissals`
--

DROP TABLE IF EXISTS `notifications_notification_dismissals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications_notification_dismissals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) NOT NULL,
  `notificationdismissal_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notifications_notificatio_notification_id_4c797bbb38ce9a8a_uniq` (`notification_id`,`notificationdismissal_id`),
  KEY `notifications_notification_dismissals_ca24cde3` (`notification_id`),
  KEY `notifications_notification_dismissals_5a9585eb` (`notificationdismissal_id`),
  CONSTRAINT `notificationdismissal_id_refs_id_1d53d7b814179225` FOREIGN KEY (`notificationdismissal_id`) REFERENCES `notifications_notificationdismissal` (`id`),
  CONSTRAINT `notification_id_refs_id_6464d7bc8d622949` FOREIGN KEY (`notification_id`) REFERENCES `notifications_notification` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications_notification_dismissals`
--

LOCK TABLES `notifications_notification_dismissals` WRITE;
/*!40000 ALTER TABLE `notifications_notification_dismissals` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications_notification_dismissals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications_notificationdismissal`
--

DROP TABLE IF EXISTS `notifications_notificationdismissal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications_notificationdismissal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `expires` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notificationdismissal_b5de30be` (`created_by_id`),
  CONSTRAINT `created_by_id_refs_id_65f17cbd4b273cb6` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications_notificationdismissal`
--

LOCK TABLES `notifications_notificationdismissal` WRITE;
/*!40000 ALTER TABLE `notifications_notificationdismissal` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications_notificationdismissal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parser_customrulemetadata`
--

DROP TABLE IF EXISTS `parser_customrulemetadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parser_customrulemetadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `last_modified_by_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parser_customrulemetadata_customer_id_19faaa1199c1e681_uniq` (`customer_id`,`name`),
  KEY `parser_customrulemetadata_edc991fc` (`customer_id`),
  KEY `parser_customrulemetadata_b5de30be` (`created_by_id`),
  KEY `parser_customrulemetadata_bcd6c6d2` (`last_modified_by_id`),
  CONSTRAINT `created_by_id_refs_id_4193d3c02606983c` FOREIGN KEY (`created_by_id`) REFERENCES `profile_profile` (`id`),
  CONSTRAINT `customer_id_refs_id_364d5f0540e8c030` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`id`),
  CONSTRAINT `last_modified_by_id_refs_id_4193d3c02606983c` FOREIGN KEY (`last_modified_by_id`) REFERENCES `profile_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parser_customrulemetadata`
--

LOCK TABLES `parser_customrulemetadata` WRITE;
/*!40000 ALTER TABLE `parser_customrulemetadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `parser_customrulemetadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_profile`
--

DROP TABLE IF EXISTS `profile_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `context` longtext NOT NULL,
  `first_name` varchar(30),
  `last_name` varchar(30),
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `profile_profile_customer_id_13c00188f1860c3d_uniq` (`customer_id`,`username`),
  KEY `profile_profile_edc991fc` (`customer_id`),
  CONSTRAINT `customer_id_refs_id_5336994803b549b` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`id`),
  CONSTRAINT `user_id_refs_id_43a642227ec54afa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_profile`
--

LOCK TABLES `profile_profile` WRITE;
/*!40000 ALTER TABLE `profile_profile` DISABLE KEYS */;
INSERT INTO `profile_profile` VALUES (6,6,1,'api','',NULL,NULL),(7,9,101,'prageet','{}',NULL,NULL);
/*!40000 ALTER TABLE `profile_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_profile_allowed_source_groups`
--

DROP TABLE IF EXISTS `profile_profile_allowed_source_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_profile_allowed_source_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `sourcegroup_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_profile_allowed_source_profile_id_39199cb2e877742d_uniq` (`profile_id`,`sourcegroup_id`),
  KEY `profile_profile_allowed_source_groups_141c6eec` (`profile_id`),
  KEY `profile_profile_allowed_source_groups_3ba73b51` (`sourcegroup_id`),
  CONSTRAINT `profile_id_refs_id_323a7fb77727a979` FOREIGN KEY (`profile_id`) REFERENCES `profile_profile` (`id`),
  CONSTRAINT `sourcegroup_id_refs_id_558f53b3ce38f8c1` FOREIGN KEY (`sourcegroup_id`) REFERENCES `source_sourcegroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_profile_allowed_source_groups`
--

LOCK TABLES `profile_profile_allowed_source_groups` WRITE;
/*!40000 ALTER TABLE `profile_profile_allowed_source_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_profile_allowed_source_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rate_limit`
--

DROP TABLE IF EXISTS `rate_limit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rate_limit` (
  `cache_key` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  `expires` datetime NOT NULL,
  PRIMARY KEY (`cache_key`),
  KEY `rate_limit_expires` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rate_limit`
--

LOCK TABLES `rate_limit` WRITE;
/*!40000 ALTER TABLE `rate_limit` DISABLE KEYS */;
/*!40000 ALTER TABLE `rate_limit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receiver_accessrule`
--

DROP TABLE IF EXISTS `receiver_accessrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receiver_accessrule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `ipcidr` varchar(100) NOT NULL,
  `allow` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `receiver_accessrule_receiver_id_34cffa6d5d9f058a_uniq` (`receiver_id`,`ipcidr`),
  KEY `receiver_accessrule_6828e8a9` (`receiver_id`),
  CONSTRAINT `receiver_id_refs_id_547f171ba5340382` FOREIGN KEY (`receiver_id`) REFERENCES `receiver_receiver` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receiver_accessrule`
--

LOCK TABLES `receiver_accessrule` WRITE;
/*!40000 ALTER TABLE `receiver_accessrule` DISABLE KEYS */;
/*!40000 ALTER TABLE `receiver_accessrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receiver_receiver`
--

DROP TABLE IF EXISTS `receiver_receiver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receiver_receiver` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `port` int(11) DEFAULT NULL,
  `protocol` varchar(50),
  `secure` tinyint(1),
  `visibility` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier` (`identifier`),
  UNIQUE KEY `port` (`port`),
  KEY `receiver_receiver_edc991fc` (`customer_id`),
  KEY `receiver_receiver_5d52dd10` (`owner_id`),
  CONSTRAINT `customer_id_refs_id_4c60b1a784390ded` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`id`),
  CONSTRAINT `owner_id_refs_id_b145d6d1ec3ddf9` FOREIGN KEY (`owner_id`) REFERENCES `profile_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receiver_receiver`
--

LOCK TABLES `receiver_receiver` WRITE;
/*!40000 ALTER TABLE `receiver_receiver` DISABLE KEYS */;
INSERT INTO `receiver_receiver` VALUES (1,101,7,'2015-05-15 18:48:58',1,'','Internal token for psqprageet','5fed7929-1ab6-496d-b77c-0b5c00f4c297',NULL,NULL,NULL,'internal'),(2,101,7,'2015-05-15 18:49:17',1,'','','f505a7a4-d91b-40cb-bdf0-ce1962c3ea25',NULL,NULL,NULL,'customer');
/*!40000 ALTER TABLE `receiver_receiver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savedsearch_savedsearch`
--

DROP TABLE IF EXISTS `savedsearch_savedsearch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `savedsearch_savedsearch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` datetime NOT NULL,
  `last_run` datetime DEFAULT NULL,
  `description` longtext,
  `quick_pick` longtext NOT NULL,
  `is_pinned` tinyint(1) NOT NULL,
  `context_id` int(11) DEFAULT NULL,
  `source_group_id` int(11),
  `is_customer_visible` tinyint(1) NOT NULL,
  `tab_id` int(11),
  PRIMARY KEY (`id`),
  UNIQUE KEY `savedsearch_savedsearch_customer_id_fbf83f0ee7043ea_uniq` (`customer_id`,`name`),
  UNIQUE KEY `tab_id` (`tab_id`),
  KEY `savedsearch_savedsearch_edc991fc` (`customer_id`),
  KEY `savedsearch_savedsearch_b5de30be` (`created_by_id`),
  KEY `savedsearch_savedsearch_252b1998` (`context_id`),
  KEY `savedsearch_savedsearch_26bc7919` (`source_group_id`),
  CONSTRAINT `context_id_refs_id_28bf0601562ff24f` FOREIGN KEY (`context_id`) REFERENCES `savedsearch_searchcontext` (`id`),
  CONSTRAINT `created_by_id_refs_id_6b169f9c2f0d4a15` FOREIGN KEY (`created_by_id`) REFERENCES `profile_profile` (`id`),
  CONSTRAINT `customer_id_refs_id_13edcadd4fe6b539` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`id`),
  CONSTRAINT `source_group_id_refs_id_3d5a10c452514c25` FOREIGN KEY (`source_group_id`) REFERENCES `source_sourcegroup` (`id`),
  CONSTRAINT `tab_id_refs_id_156d5729a9a8da7` FOREIGN KEY (`tab_id`) REFERENCES `tabmanager_tab` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savedsearch_savedsearch`
--

LOCK TABLES `savedsearch_savedsearch` WRITE;
/*!40000 ALTER TABLE `savedsearch_savedsearch` DISABLE KEYS */;
INSERT INTO `savedsearch_savedsearch` VALUES (1,101,7,'Syslog Errors','2015-05-15 18:49:17',NULL,'Default Saved Search','',0,1,NULL,1,NULL),(2,101,7,'Web Server Client Errors','2015-05-15 18:49:17',NULL,'Default Saved Search','',0,2,NULL,1,NULL),(3,101,7,'Web Server Internal Errors','2015-05-15 18:49:17',NULL,'Default Saved Search','',0,3,NULL,1,NULL),(4,101,7,'hostSearch','2015-05-22 04:15:21',NULL,NULL,'',0,34,NULL,1,3),(5,101,7,'10 mins','2015-07-13 17:42:40',NULL,NULL,'',0,317,NULL,1,6),(6,101,7,'yesterday','2015-07-13 17:44:49',NULL,NULL,'Last day',0,324,NULL,1,8);
/*!40000 ALTER TABLE `savedsearch_savedsearch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savedsearch_savedtrend`
--

DROP TABLE IF EXISTS `savedsearch_savedtrend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `savedsearch_savedtrend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext,
  `context_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `graph_type` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `savedsearch_savedtrend_customer_id_537b9aaccdd35f30_uniq` (`customer_id`,`name`),
  KEY `savedsearch_savedtrend_252b1998` (`context_id`),
  KEY `savedsearch_savedtrend_edc991fc` (`customer_id`),
  CONSTRAINT `context_id_refs_id_4eb9af809c135f17` FOREIGN KEY (`context_id`) REFERENCES `savedsearch_searchcontext` (`id`),
  CONSTRAINT `customer_id_refs_id_2b3fd67e65e9e75f` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savedsearch_savedtrend`
--

LOCK TABLES `savedsearch_savedtrend` WRITE;
/*!40000 ALTER TABLE `savedsearch_savedtrend` DISABLE KEYS */;
/*!40000 ALTER TABLE `savedsearch_savedtrend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savedsearch_savedtrend_trends`
--

DROP TABLE IF EXISTS `savedsearch_savedtrend_trends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `savedsearch_savedtrend_trends` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `savedtrend_id` int(11) NOT NULL,
  `trenddata_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `savedsearch_savedtrend_tren_savedtrend_id_1ed080aaf6382bce_uniq` (`savedtrend_id`,`trenddata_id`),
  KEY `savedsearch_savedtrend_trends_69f4576c` (`savedtrend_id`),
  KEY `savedsearch_savedtrend_trends_cd1c390c` (`trenddata_id`),
  CONSTRAINT `savedtrend_id_refs_id_3b09c7a18b6edbc3` FOREIGN KEY (`savedtrend_id`) REFERENCES `savedsearch_savedtrend` (`id`),
  CONSTRAINT `trenddata_id_refs_id_236150421ca316ed` FOREIGN KEY (`trenddata_id`) REFERENCES `savedsearch_trenddata` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savedsearch_savedtrend_trends`
--

LOCK TABLES `savedsearch_savedtrend_trends` WRITE;
/*!40000 ALTER TABLE `savedsearch_savedtrend_trends` DISABLE KEYS */;
/*!40000 ALTER TABLE `savedsearch_savedtrend_trends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savedsearch_searchcontext`
--

DROP TABLE IF EXISTS `savedsearch_searchcontext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `savedsearch_searchcontext` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_date` longtext NOT NULL,
  `until_date` longtext NOT NULL,
  `rows` int(10) unsigned NOT NULL,
  `order` longtext NOT NULL,
  `terms` longtext NOT NULL,
  `start` longtext NOT NULL,
  `hi` longtext NOT NULL,
  `field_filter_group_id` int(11),
  `source_group_id` int(11),
  `numeric_filter_group_id` int(11),
  PRIMARY KEY (`id`),
  KEY `savedsearch_searchcontext_7ee1101` (`field_filter_group_id`),
  KEY `savedsearch_searchcontext_26bc7919` (`source_group_id`),
  KEY `savedsearch_searchcontext_79d86daa` (`numeric_filter_group_id`),
  CONSTRAINT `field_filter_group_id_refs_id_753f4a5dde6cc4e7` FOREIGN KEY (`field_filter_group_id`) REFERENCES `fieldfilter_fieldfiltergroup` (`id`),
  CONSTRAINT `numeric_filter_group_id_refs_id_753f4a5dde6cc4e7` FOREIGN KEY (`numeric_filter_group_id`) REFERENCES `fieldfilter_fieldfiltergroup` (`id`),
  CONSTRAINT `source_group_id_refs_id_64c4356568b1d11f` FOREIGN KEY (`source_group_id`) REFERENCES `source_sourcegroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=441 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savedsearch_searchcontext`
--

LOCK TABLES `savedsearch_searchcontext` WRITE;
/*!40000 ALTER TABLE `savedsearch_searchcontext` DISABLE KEYS */;
INSERT INTO `savedsearch_searchcontext` VALUES (1,'-1d','',20,'desc','syslog.severity:Error','','',NULL,NULL,NULL),(2,'-1d','',20,'desc','apache.status:[400 TO 499] OR nginx.status:[400 TO 499]','','',NULL,NULL,NULL),(3,'-1d','',20,'desc','apache.status:>=500 OR nginx.status:>=500','','',NULL,NULL,NULL),(34,'2015-05-22t03:04:58.177z','now',20,'desc','host','0','false',NULL,NULL,NULL),(35,'2015-05-22t03:04:58.177z','now',20,'desc','host','','',NULL,NULL,NULL),(36,'-1h','now',20,'desc','','0','',NULL,NULL,NULL),(67,'2015-06-04t18:00:00.000z','2015-07-03t18:00:00.000z',20,'desc','','','',NULL,NULL,NULL),(68,'2015-05-22t03:04:58.177z','now',20,'desc','host','0','',NULL,NULL,NULL),(153,'2015-07-06t05:35:22.031z','2015-07-10t05:35:22.031z',20,'desc','','','',NULL,NULL,NULL),(154,'-1h','now',20,'desc','','0','',NULL,NULL,NULL),(317,'-10m','now',20,'desc','','0','false',NULL,NULL,NULL),(318,'-10m','now',20,'desc','','','',NULL,NULL,NULL),(319,'-1h','now',20,'desc','','0','',NULL,NULL,NULL),(320,'-10m','now',20,'desc','','','',NULL,NULL,NULL),(321,'-10m','now',20,'desc','','','',NULL,NULL,NULL),(322,'-10m','now',20,'desc','','','',NULL,NULL,NULL),(323,'-10m','now',20,'desc','','0','false',NULL,NULL,NULL),(324,'-1d','now',20,'desc','','0','false',NULL,NULL,NULL),(325,'-10m','now',20,'desc','','','',NULL,NULL,NULL),(326,'-10m','now',20,'desc','','0','false',NULL,NULL,NULL),(327,'-1d','now',20,'desc','','','',NULL,NULL,NULL),(328,'-1d','now',20,'desc','','','',NULL,NULL,NULL),(329,'-10m','now',20,'desc','','','',NULL,NULL,NULL),(330,'-1d','now',20,'desc','','','',NULL,NULL,NULL),(331,'-10m','now',20,'desc','','','',NULL,NULL,NULL),(332,'-10m','now',20,'desc','','0','false',NULL,NULL,NULL),(333,'-1d','now',20,'desc','','','',NULL,NULL,NULL),(334,'-1d','now',20,'desc','','0','false',NULL,NULL,NULL),(335,'-1d','now',20,'desc','','','',NULL,NULL,NULL),(336,'-1d','now',20,'desc','','0','false',NULL,NULL,NULL),(337,'-10m','now',20,'desc','','','',NULL,NULL,NULL),(338,'-10m','now',20,'desc','','0','false',NULL,NULL,NULL),(339,'-1d','now',20,'desc','','','',NULL,NULL,NULL),(340,'-1d','now',20,'desc','','0','false',NULL,NULL,NULL),(341,'-1d','now',20,'desc','test','','',NULL,NULL,NULL),(342,'-1d','now',20,'desc','','0','false',NULL,NULL,NULL),(343,'-1d','now',20,'desc','test1','','',NULL,NULL,NULL),(344,'-1d','now',20,'desc','','0','false',NULL,NULL,NULL),(345,'-1d','now',20,'desc','test2','','',NULL,NULL,NULL),(346,'-1d','now',20,'desc','','0','false',NULL,NULL,NULL),(347,'-1d','now',20,'desc','test3','','',NULL,NULL,NULL),(348,'-1d','now',20,'desc','','0','false',NULL,NULL,NULL),(349,'-2d','now',20,'desc','test3','','',NULL,NULL,NULL),(350,'-1d','now',20,'desc','','0','false',NULL,NULL,NULL),(351,'-3d','now',20,'desc','test3','','',NULL,NULL,NULL),(352,'-1d','now',20,'desc','','0','false',NULL,NULL,NULL),(353,'-5d','now',20,'desc','test3','','',NULL,NULL,NULL),(354,'-1d','now',20,'desc','','0','false',NULL,NULL,NULL),(355,'-5d','now',20,'desc','test3','','',NULL,NULL,NULL),(356,'-1d','now',20,'desc','','0','false',NULL,NULL,NULL),(439,'2015-07-14t12:50:52.959z','2015-07-14t13:00:52.959z',20,'desc','','','',NULL,NULL,NULL),(440,'-1d','now',20,'desc','','0','false',NULL,NULL,NULL);
/*!40000 ALTER TABLE `savedsearch_searchcontext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savedsearch_trenddata`
--

DROP TABLE IF EXISTS `savedsearch_trenddata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `savedsearch_trenddata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charttype` longtext NOT NULL,
  `statistic` longtext NOT NULL,
  `groupby` longtext NOT NULL,
  `name` longtext NOT NULL,
  `data_type` longtext NOT NULL,
  `numeric` longtext NOT NULL,
  `bucketby` longtext NOT NULL,
  `baseColor` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savedsearch_trenddata`
--

LOCK TABLES `savedsearch_trenddata` WRITE;
/*!40000 ALTER TABLE `savedsearch_trenddata` DISABLE KEYS */;
/*!40000 ALTER TABLE `savedsearch_trenddata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `source_setupflow`
--

DROP TABLE IF EXISTS `source_setupflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `source_setupflow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flow_type` varchar(200) DEFAULT NULL,
  `step` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `source_setupflow_fbfc09f1` (`user_id`),
  CONSTRAINT `user_id_refs_id_1c8ff3da43509747` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source_setupflow`
--

LOCK TABLES `source_setupflow` WRITE;
/*!40000 ALTER TABLE `source_setupflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `source_setupflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `source_sourcegroup`
--

DROP TABLE IF EXISTS `source_sourcegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `source_sourcegroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `field_filter_group_id` int(11) NOT NULL,
  `created` datetime,
  PRIMARY KEY (`id`),
  UNIQUE KEY `source_sourcegroup_customer_id_6d1bb2c45bef93d0_uniq` (`customer_id`,`name`),
  KEY `source_sourcegroup_edc991fc` (`customer_id`),
  KEY `source_sourcegroup_5d52dd10` (`owner_id`),
  KEY `source_sourcegroup_7ee1101` (`field_filter_group_id`),
  CONSTRAINT `customer_id_refs_id_5974afd5bf6f2281` FOREIGN KEY (`customer_id`) REFERENCES `customer_customer` (`id`),
  CONSTRAINT `field_filter_group_id_refs_id_7ff7a0233dd6531b` FOREIGN KEY (`field_filter_group_id`) REFERENCES `fieldfilter_fieldfiltergroup` (`id`),
  CONSTRAINT `owner_id_refs_id_5f4a9d83c510f5b` FOREIGN KEY (`owner_id`) REFERENCES `profile_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source_sourcegroup`
--

LOCK TABLES `source_sourcegroup` WRITE;
/*!40000 ALTER TABLE `source_sourcegroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `source_sourcegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `south_migrationhistory`
--

DROP TABLE IF EXISTS `south_migrationhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `south_migrationhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) NOT NULL,
  `migration` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `south_migrationhistory`
--

LOCK TABLES `south_migrationhistory` WRITE;
/*!40000 ALTER TABLE `south_migrationhistory` DISABLE KEYS */;
INSERT INTO `south_migrationhistory` VALUES (1,'customer','0001_initial','2015-05-15 18:32:23'),(2,'customer','0002_auto__add_field_subscription_comment__add_field_customer__subscription','2015-05-15 18:32:23'),(3,'customer','0003_set_subscription','2015-05-15 18:32:23'),(4,'customer','0004_auto__del_field_subscription_archive_retention_days_max__del_field_sub','2015-05-15 18:32:23'),(5,'customer','0005_auto__del_field_customer__subscription__add_field_customer_subscriptio','2015-05-15 18:32:23'),(6,'customer','0006_auto__add_field_customer_audit_input','2015-05-15 18:32:23'),(7,'customer','0007_auto__del_field_customer_fetal','2015-05-15 18:32:24'),(8,'customer','0008_auto__add_field_customer_sent_data','2015-05-15 18:32:24'),(9,'customer','0009_auto__add_field_customer_affiliate_code','2015-05-15 18:32:24'),(10,'customer','0010_auto__chg_field_customer_subscription','2015-05-15 18:32:24'),(11,'customer','0011_auto__add_field_customer_bucket_format','2015-05-15 18:32:24'),(12,'customer','0012_auto__add_provisioner','2015-05-15 18:32:24'),(13,'customer','0013_auto__add_field_provisioner_affiliate_code','2015-05-15 18:32:24'),(14,'customer','0014_auto__add_field_customer_provisioner','2015-05-15 18:32:24'),(15,'customer','0015_auto__del_field_customer_affiliate_code','2015-05-15 18:32:24'),(16,'customer','0016_auto__add_field_provisioner_does_billing','2015-05-15 18:32:24'),(17,'customer','0017_auto__add_field_provisioner_inputs','2015-05-15 18:32:24'),(18,'customer','0018_auto__add_field_provisioner_ip_whitelist','2015-05-15 18:32:24'),(19,'customer','0019_auto__del_field_customer_affiliate_code','2015-05-15 18:32:25'),(20,'customer','0020_auto__add_provisioner__add_field_customer_provisioner','2015-05-15 18:32:25'),(21,'customer','0021_everyone_provisioned_by_loggly','2015-05-15 18:32:25'),(22,'customer','0022_auto__del_field_provisioner_does_billing__add_field_provisioner_extern','2015-05-15 18:32:25'),(23,'customer','0023_auto__chg_field_subscription_volume_mb__chg_field_subscription_retenti','2015-05-15 18:32:25'),(24,'customer','0024_auto__del_subscription__chg_field_customer_subscription','2015-05-15 18:32:25'),(25,'customer','0025_auto__del_customertier','2015-05-15 18:32:25'),(26,'customer','0026_auto__del_field_customer_beta_key','2015-05-15 18:32:25'),(27,'customer','0027_auto__add_provisionersetting__add_unique_provisionersetting_provisione','2015-05-15 18:32:25'),(28,'customer','0028_auto__add_field_customer_affiliate_code','2015-05-15 18:32:25'),(29,'customer','0029_auto__del_field_customer_audit_input','2015-05-15 18:32:25'),(30,'customer','0030_auto__del_field_customer_bucket_name__del_field_customer_bucket_format','2015-05-15 18:32:26'),(31,'customer','0031_auto__del_provisionersetting__del_unique_provisionersetting_provisione','2015-05-15 18:32:26'),(32,'customer','0032_auto__del_field_customer_subscription','2015-05-15 18:32:27'),(33,'customer','0033_auto__add_provisionersetting__add_unique_provisionersetting_provisione','2015-05-15 18:32:27'),(34,'alert','0001_initial','2015-05-15 18:32:31'),(35,'alert','0002_auto__add_field_alerttriggercondition_uuid','2015-05-15 18:32:31'),(36,'alert','0003_auto__add_unique_alerttriggercondition_uuid','2015-05-15 18:32:31'),(37,'alert','0004_auto__chg_field_alert_savedsearch','2015-05-15 18:32:32'),(38,'alert','0005_auto__add_field_alert_last_success__add_field_alert_last_fail__add_fie','2015-05-15 18:32:32'),(39,'alert','0006_auto__chg_field_alert_savedsearch__add_field_alerttriggercondition_win','2015-05-15 18:32:32'),(40,'alert','0007_auto__chg_field_alertendpoint_address','2015-05-15 18:32:33'),(41,'alert','0008_auto__add_field_alert_event_display','2015-05-15 18:32:33'),(42,'aws','0001_initial','2015-05-15 18:32:33'),(43,'aws','0002_auto__add_field_awsingestion_ingestion_prefix','2015-05-15 18:32:33'),(44,'aws','0003_auto__add_field_awsingestion_access_key_id__add_field_awsingestion_sec','2015-05-15 18:32:33'),(45,'billing','0001_initial','2015-05-15 18:32:33'),(46,'billing','0002_auto__add_braintreetransaction','2015-05-15 18:32:34'),(47,'billing','0003_auto__add_field_braintreetransaction_customer_first_name__add_field_br','2015-05-15 18:32:34'),(48,'billing','0004_auto__add_tier__add_tierflag__add_field_subscription_tier','2015-05-15 18:32:34'),(49,'billing','0005_auto__del_field_tierflag_tier','2015-05-15 18:32:34'),(50,'billing','0006_auto__add_field_subscription_pricing_schedule__add_field_subscription_','2015-05-15 18:32:34'),(51,'billing','0007_add_chopper_fields','2015-05-15 18:32:34'),(52,'billing','0008_auto__add_feature__add_unique_feature_subscription_name','2015-05-15 18:32:34'),(53,'billing','0009_auto__del_field_subscription_tier','2015-05-15 18:32:35'),(54,'billing','0010_auto__del_tier__del_tierflag__del_braintreetransaction','2015-05-15 18:32:35'),(55,'profile','0001_initial','2015-05-15 18:32:35'),(56,'profile','0002_everybody_to_loggly','2015-05-15 18:32:35'),(57,'profile','0003_archive_perm','2015-05-15 18:32:35'),(58,'profile','0004_multi_input_perm','2015-05-15 18:32:36'),(59,'profile','0005_profile_manage_perm','2015-05-15 18:32:36'),(60,'profile','0006_ensure_cts_and_perms','2015-05-15 18:32:37'),(61,'profile','0007_auto__del_field_profile_invites','2015-05-15 18:32:37'),(62,'profile','0008_auto__chg_field_profile_context','2015-05-15 18:32:38'),(63,'profile','0009_split_userpref_history','2015-05-15 18:32:38'),(64,'profile','0010_auto__add_field_profile_first_name__add_field_profile_last_name','2015-05-15 18:32:38'),(65,'profile','0011_auto__chg_field_profile_first_name__chg_field_profile_last_name','2015-05-15 18:32:38'),(66,'profile','0012_tab_grid_columns_list_of_strings_to_list_of_objects','2015-05-15 18:32:39'),(67,'profile','0013_auto__add_field_profile_allowed_source_groups','2015-05-15 18:32:39'),(68,'profile','0014_auto__del_field_profile_allowed_source_groups','2015-05-15 18:32:39'),(69,'profile','0015_add_logglystaff_group','2015-05-15 18:32:41'),(70,'savedsearch','0001_initial','2015-05-15 18:32:42'),(71,'savedsearch','0002_auto__del_unique_savedsearch_customer_name_created_by__add_unique_save','2015-05-15 18:32:43'),(72,'savedsearch','0003_auto__add_field_savedsearch_description','2015-05-15 18:32:43'),(73,'savedsearch','0004_auto__add_field_savedsearch_terms__add_field_savedsearch_inputs__add_f','2015-05-15 18:32:44'),(74,'savedsearch','0005_auto__add_field_savedsearch_migrated','2015-05-15 18:32:44'),(75,'savedsearch','0006_auto__chg_field_savedsearch_inputs__chg_field_savedsearch_devices','2015-05-15 18:32:45'),(76,'savedsearch','0007_auto__chg_field_savedsearch_context','2015-05-15 18:32:45'),(77,'savedsearch','0008_nomorejson','2015-05-15 18:32:45'),(78,'savedsearch','0009_auto__add_field_savedsearch_filters','2015-05-15 18:32:45'),(79,'savedsearch','0010_auto__add_field_savedsearch_senders__add_field_savedsearch_receivers','2015-05-15 18:32:45'),(80,'savedsearch','0011_auto__del_field_savedsearch_receivers__del_field_savedsearch_senders','2015-05-15 18:32:45'),(81,'savedsearch','0012_auto__add_field_savedsearch_senders__add_field_savedsearch_receivers','2015-05-15 18:32:45'),(82,'savedsearch','0013_auto__del_field_savedsearch_receivers__del_field_savedsearch_senders','2015-05-15 18:32:45'),(83,'savedsearch','0014_auto__add_field_savedsearch_senders__add_field_savedsearch_receivers','2015-05-15 18:32:45'),(84,'savedsearch','0015_auto__add_field_savedsearch_quick_pick','2015-05-15 18:32:45'),(85,'savedsearch','0016_auto__add_field_savedsearch_is_pinned','2015-05-15 18:32:45'),(86,'savedsearch','0017_auto__add_trenddata__add_searchcontext__add_savedtrend__add_unique_sav','2015-05-15 18:32:46'),(87,'savedsearch','0018_auto__add_field_trenddata_data_type','2015-05-15 18:32:46'),(88,'savedsearch','0019_auto__chg_field_savedtrend__context__del_field_savedsearch_migrated__d','2015-05-15 18:32:46'),(89,'savedsearch','0020_auto__add_field_trenddata_numeric__add_field_trenddata_bucketby','2015-05-15 18:32:46'),(90,'savedsearch','0021_auto__del_field_trenddata_fields','2015-05-15 18:32:46'),(91,'savedsearch','0022_auto__add_field_savedtrend_graph_type','2015-05-15 18:32:46'),(92,'savedsearch','0023_auto__del_field_savedsearch_filters__add_field_savedsearch_source_grou','2015-05-15 18:32:46'),(93,'savedsearch','0024_auto__chg_field_savedsearch_source_group','2015-05-15 18:32:46'),(94,'savedsearch','0025_auto__del_field_savedsearch_rows__del_field_savedsearch_order__del_fie','2015-05-15 18:32:47'),(95,'savedsearch','0026_auto__add_field_searchcontext_field_filter_group','2015-05-15 18:32:47'),(96,'savedsearch','0027_auto__del_field_savedsearch__context__add_field_savedsearch_context__d','2015-05-15 18:33:16'),(97,'savedsearch','0028_update_defaults','2015-05-15 18:33:16'),(98,'savedsearch','0029_auto__add_field_savedtrend_created_at','2015-05-15 18:33:16'),(99,'savedsearch','0030_auto__add_field_trenddata_baseColor','2015-05-15 18:33:16'),(100,'savedsearch','0031_gaugevu2gauge','2015-05-15 18:33:16'),(101,'savedsearch','0032_timeseriessplit','2015-05-15 18:33:16'),(102,'savedsearch','0033_auto__add_field_savedsearch_is_customer_visible','2015-05-15 18:33:16'),(103,'savedsearch','0034_auto__add_field_searchcontext_source_group','2015-05-15 18:33:17'),(104,'savedsearch','0035_auto__add_field_savedsearch_tab','2015-05-15 18:33:17'),(105,'savedsearch','0036_auto__chg_field_savedsearch_tab','2015-05-15 18:33:18'),(106,'savedsearch','0037_auto__add_field_searchcontext_numeric_filter_group','2015-05-15 18:33:18'),(107,'loggly','0001_initial','2015-05-15 18:33:19'),(108,'loggly','0002_auto__add_runtimeflag','2015-05-15 18:33:19'),(109,'loggly','0003_auto__add_field_server_colo','2015-05-15 18:33:19'),(110,'loggly','0004_auto__del_betakey','2015-05-15 18:33:19'),(111,'loggly','0005_auto__del_field_server_colo','2015-05-15 18:33:19'),(112,'loggly','0006_auto__del_server','2015-05-15 18:33:19'),(113,'events','0001_initial','2015-05-15 18:33:20'),(114,'events','0002_auto__del_handsaw__del_handsawjob','2015-05-15 18:33:20'),(115,'tabmanager','0001_initial','2015-05-15 18:33:22'),(116,'tabmanager','0002_auto__add_field_gridcolumn_sort__add_field_gridcolumn_width','2015-05-15 18:33:22'),(117,'tabmanager','0003_auto__add_unique_tab_profile_uid','2015-05-15 18:33:22'),(118,'tabmanager','0004_auto__chg_field_tab_uid','2015-05-15 18:33:23'),(119,'tabmanager','0005_auto__add_unique_searchuistate_search_context_comparable__add_unique_s','2015-05-15 18:33:23'),(120,'tabmanager','0006_auto__add_field_searchuistate_surround_id__add_field_searchuistate_sur','2015-05-15 18:33:23'),(121,'tabmanager','0007_auto__chg_field_searchuistate_tab','2015-05-15 18:33:24'),(122,'tabmanager','0008_auto__add_field_searchuistate_saved_search_id','2015-05-15 18:33:25'),(123,'tabmanager','0009_auto__add_field_searchuistate_expanded_fields__add_field_searchuistate','2015-05-15 18:33:25'),(124,'tabmanager','0010_upgrade_new_grid','2015-05-15 18:33:26'),(125,'notifications','0001_initial','2015-05-15 18:33:27'),(126,'notifications','0002_auto__add_field_usernotification_expires__add_field_customernotificati','2015-05-15 18:33:27'),(127,'notifications','0003_auto__add_unique_customernotification_customer_msg_key','2015-05-15 18:33:27'),(128,'notifications','0004_auto__add_notificationdismissal','2015-05-15 18:33:28'),(129,'notifications','0005_auto__chg_field_notification_text','2015-05-15 18:33:28'),(130,'source','0001_initial','2015-05-15 18:33:28'),(131,'source','0002_auto__del_sourcehost__del_sourcelogtype__del_field_setupflow_receiver_','2015-05-15 18:33:28'),(132,'source','0003_created_now_if_exists','2015-05-15 18:33:28'),(133,'receiver','0001_initial','2015-05-15 18:33:28'),(134,'receiver','0002_auto__add_field_receiver_protocol__add_field_receiver_secure','2015-05-15 18:33:29'),(135,'receiver','0003_auto__add_field_receiver_visibility','2015-05-15 18:33:29'),(136,'fieldfilter','0001_initial','2015-05-15 18:33:29'),(137,'fieldfilter','0002_auto__add_fieldfiltervalue','2015-05-15 18:33:29'),(138,'fieldfilter','0003_auto__del_field_fieldfilter_value','2015-05-15 18:33:29'),(139,'fieldfilter','0004_syslog_field_renaming','2015-05-15 18:33:29'),(140,'fieldfilter','0005_auto__add_numericfiltervalue__add_field_fieldfilter_field_type','2015-05-15 18:33:29'),(141,'archive','0001_initial','2015-05-15 18:33:29'),(142,'parser','0001_initial','2015-05-15 18:33:30'),(143,'alert','0009_auto__add_field_alertendpoint_hipchat_room_id__add_field_alertendpoint','2015-05-21 18:15:41'),(144,'alert','0010_auto__chg_field_alertendpoint_hipchat_auth_token__chg_field_alertendpo','2015-05-21 18:15:41'),(145,'alert','0011_auto__add_field_alertendpoint_slack_channel_add_field_alertendpoint','2015-05-21 18:54:43'),(146,'alert','0012_auto__chg_field_alertendpoint_slack_auth_token__chg_field_alertendpoint','2015-05-21 18:54:43'),(147,'alert','0013_auto__add_field_alertendpoint_victorops_add_field_alertendpoint','2015-07-01 11:53:04'),(148,'alert','0014_auto__chg_field_alertendpoint_victorops__chg_field_alertendpoint','2015-07-01 11:53:04');
/*!40000 ALTER TABLE `south_migrationhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tabmanager_dashboarduistate`
--

DROP TABLE IF EXISTS `tabmanager_dashboarduistate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabmanager_dashboarduistate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tab_id` int(11) NOT NULL,
  `widgets` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tabmanager_dashboarduistate_b3fbb07e` (`tab_id`),
  CONSTRAINT `tab_id_refs_id_5a2bd28c1e74d52c` FOREIGN KEY (`tab_id`) REFERENCES `tabmanager_tab` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabmanager_dashboarduistate`
--

LOCK TABLES `tabmanager_dashboarduistate` WRITE;
/*!40000 ALTER TABLE `tabmanager_dashboarduistate` DISABLE KEYS */;
INSERT INTO `tabmanager_dashboarduistate` VALUES (1,1,'[{\"endpoint\": \"/ts/facet/\", \"uid\": \"5274ce5963a6d221af25ad7ec6791d1b\", \"viewName\": \"/search/\", \"gridster\": {\"col\": 1, \"size_x\": 2, \"size_y\": 1, \"row\": 1}, \"signal\": \"loadAllEvents\", \"description\": \"Overview of all events\", \"ctx\": {}, \"charts\": {}, \"module\": \"standard\", \"tabId\": \"c1fa4a3dd383eaebbebf2c4275a862a5\", \"controls\": [{\"active\": true, \"text\": \"Last hour\", \"classes\": \"checked\", \"domId\": \"last-hour\"}, {\"text\": \"Last 24 hours\", \"domId\": \"last-24-hour\"}], \"imgsrc\": \"/media/images/dashboard_widget_thumbnails/all_events.png\", \"type\": \"all-events\", \"name\": \"All Events\"}, {\"endpoint\": \"/widgets/savedsearch/\", \"name\": \"Saved Searches\", \"viewName\": \"/search/\", \"gridster\": {\"row\": \"2\", \"size_x\": \"1\", \"col\": \"1\", \"size_y\": \"1\"}, \"charts\": {}, \"module\": \"overview\", \"tabId\": \"c1fa4a3dd383eaebbebf2c4275a862a5\", \"controls\": [], \"imgsrc\": \"/media/images/dashboard_widget_thumbnails/saved_searches.png\", \"uid\": \"883e41e22bd6c76c7a9f523ffa16a29c\", \"type\": \"saved-search\", \"description\": \"All saved searches\"}, {\"endpoint\": \"/widgets/alerts/\", \"uid\": \"0e4e1e039532654b521feda428082dc0\", \"viewName\": \"/alerts/\", \"description\": \"All alerts\", \"gridster\": {\"col\": 2, \"size_x\": 1, \"size_y\": 1, \"row\": 2}, \"charts\": {}, \"module\": \"overview\", \"tabId\": \"c1fa4a3dd383eaebbebf2c4275a862a5\", \"controls\": [{\"active\": true, \"text\": \"Last 24 hours\"}], \"imgsrc\": \"/media/images/dashboard_widget_thumbnails/alerts.png\", \"type\": \"alerts\", \"name\": \"Alerts\"}, {\"endpoint\": \"/ts/facet/\", \"uid\": \"83d28bfbec896d30c7e29d6175791ef4\", \"viewName\": \"/search/\", \"ctx\": {\"fields\": \"_fnames.facet\", \"facetSize\": 300}, \"signal\": \"FieldValueWidgetSignal\", \"description\": \"Counts by Field\", \"gridster\": {\"col\": 1, \"size_x\": 2, \"size_y\": 1, \"row\": 3}, \"charts\": {}, \"module\": \"standard\", \"tabId\": \"c1fa4a3dd383eaebbebf2c4275a862a5\", \"controls\": [{\"active\": true, \"text\": \"Last hour\", \"classes\": \"checked\", \"domId\": \"last-hour\"}, {\"text\": \"Last 24 hours\", \"domId\": \"last-24-hour\"}], \"imgsrc\": \"/media/images/dashboard_widget_thumbnails/field_value_count.png\", \"type\": \"field-value\", \"name\": \"Top Values\"}]');
/*!40000 ALTER TABLE `tabmanager_dashboarduistate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tabmanager_gridcolumn`
--

DROP TABLE IF EXISTS `tabmanager_gridcolumn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabmanager_gridcolumn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(4096) NOT NULL,
  `search_ui_state_id` int(11) NOT NULL,
  `sort` varchar(8),
  `width` int(11),
  PRIMARY KEY (`id`),
  KEY `tabmanager_gridcolumn_6b702bfc` (`search_ui_state_id`),
  CONSTRAINT `search_ui_state_id_refs_id_6797356a6441d463` FOREIGN KEY (`search_ui_state_id`) REFERENCES `tabmanager_searchuistate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabmanager_gridcolumn`
--

LOCK TABLES `tabmanager_gridcolumn` WRITE;
/*!40000 ALTER TABLE `tabmanager_gridcolumn` DISABLE KEYS */;
/*!40000 ALTER TABLE `tabmanager_gridcolumn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tabmanager_searchuistate`
--

DROP TABLE IF EXISTS `tabmanager_searchuistate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabmanager_searchuistate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active_subtab` varchar(32) NOT NULL,
  `events_mode` varchar(32) NOT NULL,
  `events_tag` varchar(64) NOT NULL,
  `events_wrap` tinyint(1) NOT NULL,
  `facets_is_pinned` tinyint(1) NOT NULL,
  `is_dirty` tinyint(1) NOT NULL,
  `search_chart_height_current` int(11) NOT NULL,
  `search_chart_height_previous` int(11) NOT NULL,
  `tab_id` int(11) NOT NULL,
  `timestamp_column` tinyint(1) NOT NULL,
  `trends_mode` varchar(32) NOT NULL,
  `search_context_id` int(11) DEFAULT NULL,
  `search_context_comparable_id` int(11) DEFAULT NULL,
  `surround_id` varchar(200),
  `surround_interval` int(11),
  `surround_timestamp` bigint(20),
  `saved_search_id` varchar(200),
  `expanded_fields` longtext NOT NULL,
  `selected_field` varchar(4096) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tabmanager_searchuistate_tab_id_2ba7dbbfb2b96e26_uniq` (`tab_id`),
  UNIQUE KEY `tabmanager_s_search_context_comparable_id_515f4f4169637b7e_uniq` (`search_context_comparable_id`),
  UNIQUE KEY `tabmanager_searchuistat_search_context_id_146ac804bbeab07a_uniq` (`search_context_id`),
  KEY `tabmanager_searchuistate_b3fbb07e` (`tab_id`),
  KEY `tabmanager_searchuistate_4907df1e` (`search_context_id`),
  KEY `tabmanager_searchuistate_32983986` (`search_context_comparable_id`),
  CONSTRAINT `search_context_comparable_id_refs_id_1d25ecb966a89405` FOREIGN KEY (`search_context_comparable_id`) REFERENCES `savedsearch_searchcontext` (`id`),
  CONSTRAINT `search_context_id_refs_id_1d25ecb966a89405` FOREIGN KEY (`search_context_id`) REFERENCES `savedsearch_searchcontext` (`id`),
  CONSTRAINT `tab_id_refs_id_4f42ea52ded86023` FOREIGN KEY (`tab_id`) REFERENCES `tabmanager_tab` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabmanager_searchuistate`
--

LOCK TABLES `tabmanager_searchuistate` WRITE;
/*!40000 ALTER TABLE `tabmanager_searchuistate` DISABLE KEYS */;
INSERT INTO `tabmanager_searchuistate` VALUES (2,'events','collapse-all','',1,1,1,150,150,3,1,'pie',35,36,NULL,NULL,NULL,NULL,'{}','json.status'),(5,'events','collapse-all','',1,1,1,150,150,6,1,'pie',318,319,NULL,NULL,NULL,NULL,'{}',''),(7,'events','collapse-all','',1,1,1,150,150,8,1,'pie',325,326,NULL,NULL,NULL,'5','{}',''),(23,'events','collapse-all','',1,1,1,150,150,24,1,'pie',439,440,NULL,NULL,NULL,'6','{}','');
/*!40000 ALTER TABLE `tabmanager_searchuistate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tabmanager_tab`
--

DROP TABLE IF EXISTS `tabmanager_tab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabmanager_tab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL,
  `name` varchar(256) NOT NULL,
  `profile_id` int(11) NOT NULL,
  `tab_type` varchar(32) NOT NULL,
  `uid` varchar(64),
  PRIMARY KEY (`id`),
  UNIQUE KEY `tabmanager_tab_profile_id_3a2f7230a18ac540_uniq` (`profile_id`,`uid`),
  KEY `tabmanager_tab_141c6eec` (`profile_id`),
  CONSTRAINT `profile_id_refs_id_1a78524a2cb6f83f` FOREIGN KEY (`profile_id`) REFERENCES `profile_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabmanager_tab`
--

LOCK TABLES `tabmanager_tab` WRITE;
/*!40000 ALTER TABLE `tabmanager_tab` DISABLE KEYS */;
INSERT INTO `tabmanager_tab` VALUES (1,1,'Summary',7,'default','c1fa4a3dd383eaebbebf2c4275a862a5'),(3,0,'Default',7,'search',NULL),(6,0,'Default',7,'search',NULL),(8,0,'10 mins',7,'search',NULL),(24,1,'yesterday',7,'search','a79add01126ed441b97cbacbac7fc77a');
/*!40000 ALTER TABLE `tabmanager_tab` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-07-16 17:10:22
