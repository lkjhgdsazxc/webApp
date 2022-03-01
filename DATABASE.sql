-- MySQL dump 10.19  Distrib 10.2.38-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: DATABASE
-- ------------------------------------------------------
-- Server version	10.2.38-MariaDB

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
-- Table structure for table `Community`
--

DROP TABLE IF EXISTS `Community`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Community` (
  `uid` int(255) NOT NULL,
  `uname` varchar(100) NOT NULL,
  `message` varchar(255) NOT NULL,
  `mesdatetime` datetime NOT NULL,
  `fid` int(255) NOT NULL,
  `GearId` int(25) NOT NULL,
  KEY `uid` (`uid`),
  KEY `fid` (`fid`),
  KEY `Community_ibfk_3` (`GearId`),
  CONSTRAINT `Community_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`),
  CONSTRAINT `Community_ibfk_2` FOREIGN KEY (`fid`) REFERENCES `facility` (`fid`),
  CONSTRAINT `Community_ibfk_3` FOREIGN KEY (`GearId`) REFERENCES `GearRent` (`GearId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Community`
--

LOCK TABLES `Community` WRITE;
/*!40000 ALTER TABLE `Community` DISABLE KEYS */;
/*!40000 ALTER TABLE `Community` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FacScore`
--

DROP TABLE IF EXISTS `FacScore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FacScore` (
  `uid` int(255) NOT NULL,
  `fid` int(255) NOT NULL,
  `FacScores` int(10) NOT NULL,
  `uname` varchar(100) NOT NULL,
  KEY `fid` (`fid`),
  KEY `uid` (`uid`),
  CONSTRAINT `FacScore_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `facility` (`fid`),
  CONSTRAINT `FacScore_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FacScore`
--

LOCK TABLES `FacScore` WRITE;
/*!40000 ALTER TABLE `FacScore` DISABLE KEYS */;
/*!40000 ALTER TABLE `FacScore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GearRent`
--

DROP TABLE IF EXISTS `GearRent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GearRent` (
  `GearId` int(255) NOT NULL,
  `GearType` varchar(100) NOT NULL,
  `GearPrice` int(100) NOT NULL,
  `fid` int(255) NOT NULL,
  PRIMARY KEY (`GearId`),
  KEY `fid` (`fid`),
  CONSTRAINT `GearRent_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `facility` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GearRent`
--

LOCK TABLES `GearRent` WRITE;
/*!40000 ALTER TABLE `GearRent` DISABLE KEYS */;
/*!40000 ALTER TABLE `GearRent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GearScore`
--

DROP TABLE IF EXISTS `GearScore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GearScore` (
  `uid` int(255) NOT NULL,
  `GearId` int(255) NOT NULL,
  `uname` varchar(100) NOT NULL,
  `GearScores` int(10) NOT NULL,
  KEY `GearId` (`GearId`),
  KEY `uid` (`uid`),
  CONSTRAINT `GearScore_ibfk_1` FOREIGN KEY (`GearId`) REFERENCES `GearRent` (`GearId`),
  CONSTRAINT `GearScore_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GearScore`
--

LOCK TABLES `GearScore` WRITE;
/*!40000 ALTER TABLE `GearScore` DISABLE KEYS */;
/*!40000 ALTER TABLE `GearScore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payments`
--

DROP TABLE IF EXISTS `Payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Payments` (
  `pid` int(255) NOT NULL,
  `paytype` varchar(100) NOT NULL,
  `paydate` datetime NOT NULL,
  `paystatus` varchar(100) NOT NULL,
  `uid` int(255) NOT NULL,
  KEY `uid` (`uid`),
  CONSTRAINT `Payments_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payments`
--

LOCK TABLES `Payments` WRITE;
/*!40000 ALTER TABLE `Payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `Payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProviderContact`
--

DROP TABLE IF EXISTS `ProviderContact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProviderContact` (
  `fid` int(255) NOT NULL,
  `fcposition` varchar(50) NOT NULL,
  `fcname` varchar(100) NOT NULL,
  `fcphone` int(8) NOT NULL,
  KEY `fid` (`fid`),
  CONSTRAINT `ProviderContact_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `facility` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProviderContact`
--

LOCK TABLES `ProviderContact` WRITE;
/*!40000 ALTER TABLE `ProviderContact` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProviderContact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SportTag`
--

DROP TABLE IF EXISTS `SportTag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SportTag` (
  `TagId` int(255) NOT NULL,
  `Tagname` varchar(100) NOT NULL,
  `fid` int(255) NOT NULL,
  `GearId` int(255) NOT NULL,
  PRIMARY KEY (`TagId`),
  KEY `fid` (`fid`),
  KEY `GearId` (`GearId`),
  CONSTRAINT `SportTag_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `facility` (`fid`),
  CONSTRAINT `SportTag_ibfk_2` FOREIGN KEY (`GearId`) REFERENCES `GearRent` (`GearId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SportTag`
--

LOCK TABLES `SportTag` WRITE;
/*!40000 ALTER TABLE `SportTag` DISABLE KEYS */;
/*!40000 ALTER TABLE `SportTag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking` (
  `bid` int(255) NOT NULL,
  `uid` int(255) NOT NULL,
  `status` varchar(100) NOT NULL,
  PRIMARY KEY (`bid`),
  KEY `uid` (`uid`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facility`
--

DROP TABLE IF EXISTS `facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facility` (
  `fid` int(10) NOT NULL,
  `fname` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `company` varchar(100) NOT NULL,
  `price` varchar(100) NOT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facility`
--

LOCK TABLES `facility` WRITE;
/*!40000 ALTER TABLE `facility` DISABLE KEYS */;
/*!40000 ALTER TABLE `facility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facilitylocaltion`
--

DROP TABLE IF EXISTS `facilitylocaltion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facilitylocaltion` (
  `fid` int(255) NOT NULL,
  `Area` varchar(100) NOT NULL,
  `District` varchar(100) NOT NULL,
  `SubDistrict` varchar(100) NOT NULL,
  `AddressDetails` varchar(255) NOT NULL,
  KEY `fid` (`fid`),
  CONSTRAINT `facilitylocaltion_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `facility` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facilitylocaltion`
--

LOCK TABLES `facilitylocaltion` WRITE;
/*!40000 ALTER TABLE `facilitylocaltion` DISABLE KEYS */;
/*!40000 ALTER TABLE `facilitylocaltion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `followers`
--

DROP TABLE IF EXISTS `followers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `followers` (
  `follower_id` int(11) DEFAULT 0,
  `followed_id` int(11) DEFAULT 0,
  KEY `follower_id_user_id` (`follower_id`),
  KEY `followed_id_user_id` (`followed_id`),
  CONSTRAINT `followed_id_user_id` FOREIGN KEY (`followed_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `follower_id_user_id` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `followers`
--

LOCK TABLES `followers` WRITE;
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` int(11) NOT NULL DEFAULT 0,
  `body` varchar(140) DEFAULT NULL,
  `timestamp` datetime DEFAULT '0000-00-00 00:00:00',
  `user_id` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_post_timestamp` (`timestamp`),
  KEY `user_id_user_id` (`user_id`),
  CONSTRAINT `user_id_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (0,'Hi :)','2022-03-01 01:37:36',0);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `bid` int(255) NOT NULL,
  `start` int(30) NOT NULL,
  `end` int(30) NOT NULL,
  `requirement` varchar(255) NOT NULL,
  `request` int(100) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hash` varchar(100) NOT NULL,
  KEY `bid` (`bid`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`bid`) REFERENCES `booking` (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `staffid` int(10) NOT NULL,
  `stname` varchar(100) NOT NULL,
  `ststatus` varchar(50) NOT NULL,
  `stposition` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL DEFAULT 0,
  `username` varchar(64) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `password_hash` varchar(128) DEFAULT NULL,
  `about_me` varchar(140) DEFAULT NULL,
  `last_seen` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_user_email` (`email`),
  UNIQUE KEY `ix_user_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (0,'Test','Test@mysql.com','pbkdf2:sha256:260000$Uw02Mf7JRkPTXr91$52ec5a46b8963064151e369228c27e1c15cab1a67f08b4b400745a03150d0ffa',NULL,'2022-03-01 01:44:50');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-01  1:54:26
