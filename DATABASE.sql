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
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(100) NOT NULL,
  `message` varchar(100) NOT NULL,
  `mesdatetime` datetime NOT NULL,
  `fid` int(11) NOT NULL,
  `GearId` int(11) NOT NULL,
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
  `uid` int(11) NOT NULL,
  `fid` int(11) NOT NULL,
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
  `GearId` int(11) NOT NULL AUTO_INCREMENT,
  `GearType` varchar(11) NOT NULL,
  `GearPrice` int(100) NOT NULL,
  `fid` int(11) NOT NULL,
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
  `uid` int(11) NOT NULL,
  `GearId` int(11) NOT NULL,
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
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `paytype` varchar(100) NOT NULL,
  `paydate` datetime NOT NULL,
  `paystatus` varchar(100) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`pid`),
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
  `fid` int(11) NOT NULL,
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
  `TagId` int(11) NOT NULL AUTO_INCREMENT,
  `Tagname` varchar(100) NOT NULL,
  `fid` int(11) NOT NULL,
  `GearId` int(11) NOT NULL,
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
  `bid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
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
  `fid` int(11) NOT NULL,
  `Area` varchar(100) NOT NULL,
  `District` varchar(100) NOT NULL,
  `SubDistrict` varchar(100) NOT NULL,
  `AddressDetails` varchar(100) NOT NULL,
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
-- Table structure for table `governmentfac`
--

DROP TABLE IF EXISTS `governmentfac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `governmentfac` (
  `govid` int(11) NOT NULL AUTO_INCREMENT,
  `District` varchar(17) NOT NULL,
  `Category` varchar(37) NOT NULL,
  `Venue_Name` varchar(54) NOT NULL,
  `Address` varchar(101) NOT NULL,
  `Tel_No` varchar(21) NOT NULL,
  `Latitude` decimal(9,6) NOT NULL,
  `Longitude` decimal(10,6) NOT NULL,
  PRIMARY KEY (`govid`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `governmentfac`
--

LOCK TABLES `governmentfac` WRITE;
/*!40000 ALTER TABLE `governmentfac` DISABLE KEYS */;
INSERT INTO `governmentfac` VALUES (1,'Eastern','Sports Centre','Java Road Sports Centre','3/F, Java Road Municipal Services Building, 99 Jave Road, North Point, Hong Kong','2516 9415',22.292250,114.199400),(2,'Eastern','Sports Centre','Chai Wan Sports Centre','G/F, 6 Yee Shun Street, Chai Wan, Hong Kong','2897 9144',22.264850,114.239910),(3,'Eastern','Sports Centre','Island East Sports Centre','G/F, 52 Lei King Road, Sai Wan Ho, Hong Kong','2151 4070',22.284720,114.222290),(4,'Eastern','Sports Centre','Quarry Bay Sports Centre','6-7/F ,Quarry Bay Municipal Services Building, 38 Quarry Bay Street, Quarry Bay, Hong Kong','2562 0374',22.283690,114.211790),(5,'Eastern','Sports Centre','Sai Wan Ho Sports Centre','2/F, 111 Shaukiwan Road, Sai Wan Ho, Hong Kong','2569 7330',22.282230,114.222900),(6,'Eastern','Sports Centre','Siu Sai Wan Sports Centre','2/F., Siu Sai Wan Complex, 15 Siu Sai Wan Road, Siu Sai Wan, Hong Kong','3427 3121',22.263570,114.249490),(7,'Wan Chai','Sports Centre','Wong Nai Chung Sports Centre','4/F,Wong Nai Chung Municipal Services Building, 2 Yuk Sau Street, Happy Valley, Hong Kong','2891 8438',22.268950,114.185690),(8,'Wan Chai','Sports Centre','Harbour Road Sports Centre','27 Harbour Road, Wan Chai, Hong Kong','2827 9684',22.281350,114.176290),(9,'Wan Chai','Sports Centre','Lockhart Road Sports Centre','10/F, Lockhart Road Municipal Services Building, 225 Hennessy Road, Wan Chai, Hong Kong','2879 5521',22.278080,114.175420),(10,'Wan Chai','Sports Centre','Queen Elizabeth Stadium','18, Oi Kwan Road, Wan Chai, Hong Kong','2591 1331',22.275180,114.178900),(11,'Central & Western','Sports Centre','Smithfield Sports Centre','4/F, Smithfield Municipal Services Building, 12K Smithfield Road, Kennedy Town, Hong Kong','2855 7321',22.281940,114.128640),(12,'Central & Western','Sports Centre','Sheung Wan Sports Centre','11/F, Sheung Wan Municipal Services Building, 345 Queen\'s Road, Central, Hong Kong','2853 2574',22.286000,114.149630),(13,'Central & Western','Sports Centre','Shek Tong Tsui Sports Centre','5/F, Shek Tong Tsui Municipal Services Building, 470 Queen\'s Road West, Hong Kong','2858 0541',22.285720,114.136050),(14,'Central & Western','Sports Centre','Sun Yat Sen Memorial Park Sports Centre','18 Eastern Street North, Sai Ying Pun, Hong Kong','2858 2493',22.290170,114.143490),(15,'Central & Western','Sports Centre','Hong Kong Park Sports Centre','29 Cotton Tree Drive, Queensway, Hong Kong','2521 5072',22.277340,114.159290),(16,'Southern','Sports Centre','Aberdeen Sports Centre','6/F, Aberdeen Municipal Services Building, 203 Aberdeen Main Road, Hong Kong','2555 8909',22.249560,114.154360),(17,'Southern','Sports Centre','Ap Lei Chau Sports Centre','1/F to 4/F, Ap Lei Chau Municipal Services Building, No. 8 Hung Shing Street, Ap Lei Chau, Hong Kong','2554 0832',22.244480,114.155420),(18,'Southern','Sports Centre','Wong Chuk Hang Sports Centre','168 Wong Chuk Hang Road, Aberdeen, Hong Kong','2553 6663',22.249670,114.173290),(19,'Southern','Sports Centre','Yue Kwong Road Sports Centre','43, Yue Kwong Road, Aberdeen, Hong Kong','2554 9132',22.250500,114.156900),(20,'Southern','Tennis / Squash / Table-tennis Centre','Aberdeen Tennis and Squash Centre','1 Aberdeen Praya Road, Aberdeen, Hong Kong','2553 1190',22.247550,114.159790),(21,'Southern','Sports Centre','Stanley Sports Centre','UG/F, Stanley Municipal Services Building, No. 6 Stanley Market Road, Hong Kong','2813 5106',22.219160,114.212200),(22,'Yau Tsim Mong','Sports Centre','Kowloon Park Sports Centre','22 Austin Road, Tsim Sha Tsui, Kowloon','2724 3120',22.301860,114.169960),(23,'Yau Tsim Mong','Sports Centre','Kwun Chung Sports Centre','5-6/F, Kwun Chung Municipal Services Building, 17 Bowring Street, Jordon, Kowloon','2302 1275',22.304440,114.168260),(24,'Yau Tsim Mong','Sports Centre','Fa Yuen Street Sports Centre','10-13/F Fa Yuen Street Municipal Services Building, 123A Fa Yuen Street, Mong Kok, Kowloon','2395 1501',22.320780,114.170700),(25,'Yau Tsim Mong','Sports Centre','Boundary Street Sports Centre','G/F, 200 Sai Yee Street, Mong Kok, Kowloon','2380 9751',22.325680,114.170590),(26,'Yau Tsim Mong','Sports Centre','Tai Kok Tsui Sports Centre','5-7/F, Tai Kok Tsui Municipal Services Building, 63 Fuk Tsun Street, Tai Kok Tsui, Kowloon','2393 1084',22.321880,114.162790),(27,'Kowloon City','Sports Centre','Hung Hom Municipal Services Building Sports Centre','3-5/F, Hung Hom Municipal Services Building, 11 Ma Tau Wai Road, Hung Hom, Kowloon','2765 0586',22.307270,114.187300),(28,'Kowloon City','Sports Centre','Fat Kwong Street Sports Centre','9/F, 18 Shepherd Street, Ho Man Tin, Kowloon','2712 2652',22.314830,114.181110),(29,'Kowloon City','Sports Centre','Kowloon City Sports Centre','3/F, Kowloon City Municipal Services Building, 100 Nga Tsin Wai Road, Kowloon City, Kowloon','2716 1007',22.329640,114.188890),(30,'Kowloon City','Sports Centre','To Kwa Wan Sports Centre','66 Ha Heung Road, To Kwa Wan, Kowloon','2364 9285',22.318850,114.190120),(31,'Kowloon City','Sports Centre','Ho Man Tin Sports Centre','1 Chung Yee Street, Ho Man Tin, Kowloon','2762 7837',22.311970,114.181240),(32,'Kwun Tong','Sports Centre','Shun Lee Tsuen Sports Centre','33 Shun Lee Tsuen Road, Kwun Tong, Kowloon','2951 4136',22.329690,114.225440),(33,'Kwun Tong','Sports Centre','Chun Wah Road Sports Centre','Top Floor, Lok Nga Court Carpark, No. 50, Chun Wah Road, Ngau Tau Kok, Kowloon','2318 1767',22.322470,114.220510),(34,'Kwun Tong','Sports Centre','Hiu Kwong Street Sports Centre','2 Hiu Kwong Street, Kwun Tong, Kowloon','2347 0384',22.319800,114.227690),(35,'Kwun Tong','Sports Centre','Ngau Tau Kok Road Sports Centre','3/F-4/F, Ngau Tau Kok Municipal Services Building, 183 Ngau Tau Kok Road, Kowloon','2756 3466',22.321480,114.216380),(36,'Kwun Tong','Sports Centre','Shui Wo Street Sports Centre','8/F-9/F, Shui Wo Street Municipal Services Building, 9 Shui Wo Street, Kwun Tong, Kowloon','2797 3350',22.315660,114.224280),(37,'Kwun Tong','Sports Centre','Lam Tin South Sports Centre','170 Pik Wan Road, Lam Tin, Kowloon','2379 9254',22.303860,114.238840),(38,'Kwun Tong','Sports Centre','Kowloon Bay Sports Centre','15 Kai Lok Street, Kowloon Bay, Kowloon','2750 9539',22.326860,114.211200),(39,'Kwun Tong','Sports Centre','Lei Yue Mun Sports Centre','2/F-5/F, Lei Yue Mun Municipal Services Building, 6, Lei Yue Mun Path, Yau Tong, Kowloon','2349 3954',22.292060,114.238680),(40,'Wong Tai Sin','Sports Centre','Po Kong Village Road Sports Centre','120 Po Kong Village Road, Wong Tai Sin, Kowloon','2325 3585',22.345460,114.201590),(41,'Wong Tai Sin','Sports Centre','Kai Tak East Sports Centre','30 Luk Hop Street, San Po Kong, Kowloon','2326 9940',22.335950,114.200560),(42,'Wong Tai Sin','Sports Centre','Choi Hung Road Sports Centre','150 Choi Hung Road, Wong Tai Sin, Kowloon','2326 2714',22.337130,114.196450),(43,'Wong Tai Sin','Sports Centre','Ngau Chi Wan Sports Centre','1/F, Nagu Chi Wan Market, 11 Clear Water Bay Road, Wong Tai Sin, Kowloon','2327 4915',22.334550,114.209640),(44,'Wong Tai Sin','Sports Centre','Morse Park Sports Centre','40 Fung Mo Street, Wong Tai Sin, Kowloon','2326 2207',22.338310,114.190100),(45,'Wong Tai Sin','Sports Centre','Chuk Yuen Sports Centre','Chuk Yuen North Estate, Chuk Yuen Road, Wong Tai Sin, Kowloon','2324 3960',22.345520,114.193510),(46,'Sham Shui Po','Sports Centre','Pei Ho Street Sports Centre','5/F-U6/F, Pei Ho Street Municipal Services Building, 333 Ki Lung Street, Sham Shui Po, Kowloon','2729 1010',22.329450,114.160900),(47,'Sham Shui Po','Sports Centre','Po On Road Sports Centre','1/F & 2/F, Po On Road Municipal Services Building, 325-329 Po On Road, Sham Shui Po, Kowloon','2729 4237',22.338620,114.157390),(48,'Sham Shui Po','Sports Centre','Cheung Sha Wan Sports Centre','J/O Cheung Sha Wan Road and Hing Wah Street, Kowloon','2741 7287',22.337970,114.153500),(49,'Sham Shui Po','Sports Centre','Shek Kip Mei Park Sports Centre','No. 290, Nam Cheong Street, Shek Kip Mei, Sham Shui Po, Kowloon','2784 7424',22.337290,114.169960),(50,'Sham Shui Po','Sports Centre','Lai Chi Kok Park Sports Centre','No.1 Lai Wan Road, Lai Chi Kok, Kowloon','2745 2796',22.340700,114.138200),(51,'Sham Shui Po','Tennis / Squash / Table-tennis Centre','Cornwall Street Squash and Table Tennis Centre','17 Cornwall Street, Kowloon Tong, Kowloon','2337 4392',22.339190,114.172700),(52,'Sham Shui Po','Tennis Court / Park','Tung Chau Street Park','Tung Chau Street, Sham Shui Po, Kowloon','2728 4888',22.326610,114.159000),(53,'Islands','Sports Centre','Cheung Chau Sports Centre','3 Hospital Road, Cheung Chau, N.T.','2981 6285',22.207510,114.031180),(54,'Islands','Sports Centre','Praya Street Sports Centre','1/F, Cheung Chau Municipal Services Building, 2 Tai Hing Tai Road, Cheung Chau, N.T.','2981 5409',22.206820,114.028350),(55,'Islands','Sports Centre','Mui Wo Sports Centre','1/F, Mui Wo Municipal Services Building, No. 9, Ngan Shek Street, Lantau Island, N.T.','2984 2334',22.266990,113.996480),(56,'Islands','Sports Centre','Peng Chau Sports Centre','Peng Chau Municipal Services Building, No. 6, Po Peng Street, Peng Chau, N.T.','2983 1271',22.284890,114.038050),(57,'Islands','Sports Centre','Tung Chung Man Tung Road Sports Centre','G/F to 2/F., Tung Chung Municipal Services Building, No. 39 Man Tung Road, Tung Chung, N.T.','2109 2421',22.290590,113.943830),(58,'Tuen Mun','Sports Centre','Leung Tin Sports Centre','4/F, Carpark Building, Tin King Estate, Tuen Mun, N.T.','2467 1594',22.406600,113.965080),(59,'Tuen Mun','Sports Centre','The Jockey Club Tuen Mun Butterfly Beach Sports Centre','11 Wu Shan Road, Tuen Mun, N.T.','2465 7610',22.378690,113.964700),(60,'Tuen Mun','Sports Centre','Yau Oi Sports Centre','3 Hing On Lane, Tuen Mun, N.T.','2450 8508',22.385460,113.971800),(61,'Tuen Mun','Sports Centre','Tai Hing Sports Centre','38 Tsing Chung Koon Road, Tuen Mun, N.T.','2463 1248',22.403380,113.973070),(62,'Tuen Mun','Sports Centre','Siu Lun Sports Centre','2/F-5/F, 19 Siu Lun Street, Tuen Mun Siu Lun Government Complex, Tuen Mun, N.T.','2659 2311',22.383500,113.978405),(63,'Yuen Long','Sports Centre','Fung Kam Street Sports Centre','20 Fung Yau Street North, Yuen Long, N.T.','2475 2334',22.443060,114.033030),(64,'Yuen Long','Sports Centre','Tin Shui Wai Sports Centre','No.1, Tin Pak Road, Tin Shui Wai, Yuen Long, N.T.','2446 4778',22.455010,114.006540),(65,'Yuen Long','Sports Centre','Long Ping Sports Centre','Unit 202, 2/F, Long Ping Commercial Centre, Long Ping Estate, Yuen Long, N.T.','2475 1444',22.450300,114.023190),(66,'Yuen Long','Tennis / Squash / Table-tennis Centre','Sir Denys Roberts Squash Courts, Yuen Long','1 Ping Fai Path, Ping Wui Street, Yuen Long, N.T.','2479 2950',22.446890,114.022630),(67,'Yuen Long','Sports Centre','Tin Fai Road Sports Centre','63 Tin Shui Road, Tin Shui Wai, N.T.','2473 0229',22.464800,113.997020),(68,'Yuen Long','Sports Centre','Tin Shui Sports Centre','No.7 Tin Shui Road, Tin Shui Wai, Yuen Long, N.T.','2446 6609',22.454770,113.997980),(69,'Yuen Long','Sports Centre','Ping Shan Tin Shui Wai Sports Centre','No.1, Tsui Sing Road, Tin Shui Wai, Yuen Long, N.T.','2350 9455',22.447340,114.004800),(70,'Yuen Long','Sports Centre','Yuen Long Sports Centre','3/F, Yuen Long Leisure and Cultural Building, 52 Ma Tin Road, Yuen Long','2891 9207',22.441470,114.023860),(71,'Kwai Tsing','Sports Centre','Tsing Yi Southwest Sports Centre','70 Chung Mei Road, Tsing Yi, N.T.','2341 0102',22.351420,114.101900),(72,'Kwai Tsing','Sports Centre','Osman Ramju Sadick Memorial Sports Centre','176 Hing Fong Road, Kwai Chung, N.T.','2422 5610',22.361120,114.129520),(73,'Kwai Tsing','Sports Centre','Tsing Yi Sports Centre','2/F, Tsing Yi Municipal Services Building, 38 Tsing Luk Street, Tsing Yi, N.T.','2495 4631',22.354210,114.106510),(74,'Kwai Tsing','Sports Centre','Cheung Fat Sports Centre','4/F, Cheung Fat Shopping Centre, Cheung Fat Estate, Tsing Yi, N.T.','2433 5886',22.362470,114.102700),(75,'Kwai Tsing','Sports Centre','Fung Shue Wo Sports Centre','10 Fung Shue Wo Road, Phase II, Tsing Yi Estate, Tsing Yi, N.T.','2433 6523',22.355480,114.102690),(76,'Kwai Tsing','Sports Centre','Lai King Sports Centre','60 Lai Cho Road, Lai King, Kwai Chung, N.T.','2744 5678',22.349860,114.127670),(77,'Kwai Tsing','Sports Centre','Tai Wo Hau Sports Centre','39 Tai Ha Street, Tai Wo Hau Estate, Kwai Chung, N.T.','2920 2011',22.370200,114.124950),(78,'Kwai Tsing','Sports Centre','North Kwai Chung Tang Shiu Kin Sports Centre','292 Wo Yi Hop Road, Kwai Chung, N.T.','2426 3269',22.373870,114.137560),(79,'North','Sports Centre','Lung Sum Avenue Sports Centre','155 Jockey Club Road, Sheung Shui, N.T.','2673 4433',22.504980,114.130450),(80,'North','Sports Centre','Wo Hing Sports Centre','8 Wo Ming Lane, Fanling, N.T.','2669 7057',22.484750,114.143140),(81,'North','Sports Centre','Tin Ping Sports Centre','3/F, Tin Ping Shopping Centre, Tin Ping Estate, Sheung Shui, N.T.','2673 3699',22.503320,114.133650),(82,'North','Sports Centre','Luen Wo Hui Sports Centre','3/F, 9 Wo Mun Street, Luen Wo Market Hui, Fanling, N.T.','2677 5149',22.500280,114.145020),(83,'North','Sports Centre','Po Wing Road Sports Centre','19 Pak Wo Road, Sheung Shui, New Territories','2639 2979',22.496980,114.128340),(84,'Sai Kung','Sports Centre','Hong Kong Velodrome','105 - 107 Po Hong Road, Tseung Kwan O, N.T.','2878 8622',22.313060,114.262500),(85,'Sai Kung','Sports Centre','Tseung Kwan O Sports Centre','9 Wan Lung Road, Tseung Kwan O, N.T.','2701 2317',22.317100,114.259630),(86,'Sai Kung','Sports Centre','Tsui Lam Sports Centre','Tsui Lam Estate, Tseung Kwan O, N.T.','2703 1137',22.322230,114.249530),(87,'Sai Kung','Sports Centre','Po Lam Sports Centre','Po Lam Estate, Tseung Kwan O, N.T.','2701 5918',22.325860,114.255110),(88,'Sai Kung','Sports Centre','Hang Hau Sports Centre','1-3/F, Sai Kung Tseung Kwan O Government Complex, 38 Pui Shing Road, Tseung Kwan O, N.T.','2623 5928',22.317170,114.268240),(89,'Sai Kung','Sports Centre','Tiu Keng Leng Sports Centre','2 Chui Ling Road, Tseung Kwan O, N.T.','2481 5033',22.306390,114.255290),(90,'Sha Tin','Sports Centre','Yuen Chau Kok Sports Centre','35 Ngan Shing Street, Sha Tin, N.T.','2509 9108',22.379900,114.204500),(91,'Sha Tin','Sports Centre','Yuen Wo Road Sports Centre','No.8 Yuen Wo Road, Sha Tin, N.T.','2604 5987',22.382940,114.192600),(92,'Sha Tin','Sports Centre','Ma On Shan Sports Centre','14 On Chun Street, Ma On Shan, Sha Tin, N.T.','2631 1597',22.426020,114.229560),(93,'Sha Tin','Sports Centre','Heng On Sports Centre','4/F, Heng On Commercial Centre, Heng On Estate, Sha Tin, N.T.','2642 0203',22.416690,114.227870),(94,'Sha Tin','Sports Centre','Hin Keng Sports Centre','2/F, Wing B, Hin Keng Commercial Centre, Hin Keng Estate, Sha Tin, N.T.','2605 8407',22.382940,114.192570),(95,'Sha Tin','Sports Centre','Mei Lam Sports Centre','Mei Lam Estate Phase III, Tai Wai, Sha Tin, N.T.','2695 9318',22.379080,114.175500),(96,'Sha Tin','Sports Centre','Che Kung Temple Sports Centre','No.10 Sha Tin Tau Road, Sha Tin, N.T.','2790 0221',22.372325,114.185958),(97,'Sha Tin','Tennis / Squash / Table-tennis Centre','Sha Tin Jockey Club Public Squash Courts','12 Yuen Wo Road, Sha Tin, N.T.','2604 7647',22.384720,114.193920),(98,'Tai Po','Sports Centre','Tai Po Sports Centre','13 Ting Tai Road, Tai Po, N.T.','2664 7222',22.455340,114.164900),(99,'Tai Po','Sports Centre','Tai Po Hui Sports Centre','6/F, Tai Po Complex, No. 8, Heung Sze Wui Street, Tai Po, N.T.','3183 9011',22.446120,114.166580),(100,'Tai Po','Sports Centre','Tai Wo Sports Centre','Podium Level, Tai Wo Shopping Centre, Tai Wo Estate, Tai Po, N.T.','2656 3398',22.451000,114.160580),(101,'Tai Po','Sports Centre','Fu Shin Sports Centre','6/F, Multi-Car Park, Fu Shin Estate, Tai Po, N.T.','2661 4144',22.453880,114.174120),(102,'Tai Po','Sports Centre','Fu Heng Sports Centre','1/F, Fu Heng Shopping Centre, Fu Heng Estate, Tai Po, N.T.','2665 2753',22.458290,114.171360),(103,'Tsuen Wan','Sports Centre','Wai Tsuen Sports Centre','6 Miu Kong Street, Tsuen Wan, N.T.','2415 2621',22.372320,114.122490),(104,'Tsuen Wan','Sports Centre','Yeung Uk Road Sports Centre','4/F, Yeung Uk Road Municipal Services Building, 45 Yeung Uk Road, Tsuen Wan, N.T.','2415 4445',22.368990,114.114520),(105,'Tsuen Wan','Sports Centre','Tsuen Wan Sports Centre','53 Wing Shun Street, Tsuen Wan, New Territories','2392 9570',22.365960,114.112640),(106,'Tsuen Wan','Sports Centre','Tsuen Wan West Sports Centre','68 Hoi On Road, Tsuen Wan, N.T.','2412 0904',22.370480,114.100510),(107,'Tsuen Wan','Sports Centre','Tsuen King Circuit Sports Centre','38 Mei Wan Street, Tsuen Wan, N.T.','2405 6960',22.377780,114.111400),(108,'Sai Kung','Water Sports Centre','Chong Hing Water Sports Centre','West Sea Cofferdam, High Island Reservoir, Sai Kung, N.T.','2792 6810',22.376540,114.336100),(109,'Southern','Water Sports Centre','Stanley Main Beach Water Sports Centre','Stanley Link Road, Stanley, Hong Kong','2813 9117',22.220330,114.214100),(110,'Southern','Water Sports Centre','St. Stephen\'s Beach Water Sports Centre','Wong Ma Kok Path, Stanley, Hong Kong','2813 5407',22.211660,114.214630),(111,'Tai Po','Water Sports Centre','Tai Mei Tuk Water Sports Centre','Main Dam, Plover Cove Reservoir, Tai Mei Tuk, Tai Po, N.T.','2665 3591',22.468020,114.233410),(112,'Sai Kung','Water Sports Centre','The Jockey Club Wong Shek Water Sports Centre','Wong Shek Pier, Sai Kung, N.T.','2328 2311',22.433980,114.336940),(113,'Tuen Mun','Recreation and Sports Centre','Tuen Mun Recreation & Sports Centre','54 Lung Mun Road, Tuen Mun, N.T.','2466 2600',22.381790,113.962790),(114,'Tsuen Wan','Camp','Tso Kung Tam Outdoor Recreation Centre','105 Route Twisk, Tsuen Wan, N.T.','2417 1107 / 2415 6812',22.386010,114.106000),(115,'Sai Kung','Camp','Lady Maclehose Holiday Village','Pak Tam, Sai Kung, N.T.','2792 6430 / 2792 6417',22.408010,114.321800),(116,'Sai Kung','Camp','Sai Kung Outdoor Recreation Centre','21 Hong Kin Road,Tui Min Hoi Area, Sai Kung, N.T.','2792 3828 / 2792 0046',22.376390,114.269200),(117,'Eastern','Camp','Lei Yue Mun Park','75 Chai Wan Road, Hong Kong','2568 7455 / 2568 7858',22.278280,114.233900),(118,'Eastern','DLSO','Eastern District Leisure Services Office','3/F, Quarry Bay Municipal Services Building, 38 Quarry Bay Street, Hong Kong','2564 2264',22.283690,114.211800),(119,'Wan Chai','DLSO','Wanchai District Leisure Services Office','9/F, Lockhart Road Municipal Services Building, 225 Hennessy Road, Wan Chai, Hong Kong','2879 5622',22.278110,114.175410),(120,'Central & Western','DLSO','Central & Western District Leisure Services Office','Room 1001, Sheung Wan Municipal Services Building, 345 Queen\'s Road, Central, Hong Kong','2853 2566',22.286200,114.149630),(121,'Southern','DLSO','Southern District Leisure Services Office','4/F, Aberdeen Municipal Services Building, 203 Aberdeen Main Road, Hong Kong','2555 1268',22.249300,114.154360),(122,'Kowloon City','DLSO','Kowloon City District Leisure Services Office','10/F, To Kwa Wan Government Offices, 165 Ma Tau Wai Road, Kowloon','2711 0541',22.317160,114.188100),(123,'Kwun Tong','DLSO','Kwun Tong District Leisure Services Office','No. 2, Tsui Ping Road, Kwun Tong, Kowloon','2343 6123',22.310710,114.230210),(124,'Wong Tai Sin','DLSO','Wong Tai Sin District Leisure Services Office','4/F, Ngau Chi Wan Municipal Services Building, 11 Clear Water Bay Road, Wong Tai Sin, Kowloon','2328 9262',22.334522,114.208861),(125,'Sham Shui Po','DLSO','Sham Shui Po District Leisure Services Office','7/F, Un Chau Street Municipal Services Building, 59-63 Un Chau Street, Sham Shui Po, Kowloon','2386 0945',22.332036,114.163321),(126,'Yau Tsim Mong','DLSO','Yau Tsim Mong District Leisure Services Office','G/F., Kowloon Park Management Office, 22 Austin Road, Tsim Sha Tsui, Kowloon','2302 1762',22.301800,114.170700),(127,'Islands','DLSO','Islands District Leisure Services Office','6/F, Harbour Building, 38 Pier Road, Central, Hong Kong','2852 3220',22.286660,114.154990),(128,'Tuen Mun','DLSO','Tuen Mun District Leisure Services Office','3/F, Tuen Mun Government Offices Building, 1 Tuen Hi Road, Tuen Mun, N.T.','2451 0304',22.390430,113.976370),(129,'Yuen Long','DLSO','Yuen Long Leisure Services District Office','2/F, Yuen Long Government Offices, 2 Kiu Lok Square, Yuen Long, N.T.','2478 4342',22.445374,114.027211),(130,'Kwai Tsing','DLSO','Kwai Tsing District Leisure Services Office','Room 805, 8/F, Kwai Hing Government Offices Building, 166-174 Hing Fong Road, Kwai Chung, N.T.','2424 7201',22.363200,114.131500),(131,'Tsuen Wan','DLSO','Tsuen Wan District Leisure Services Office','3/F, Yeung Uk Road Municipal Services Building, 45 Yeung Uk Road, Tsuen Wan, N.T.','2212 9702',22.369010,114.114510),(132,'Sha Tin','DLSO','Sha Tin District Leisure Services Office','Unit 1207-1212, 12/F, Tower 1, Grand Central Plaza, 138 Sha Tin Rural Committee Road, Sha Tin, N.T.','2634 0111',22.385663,114.187767),(133,'Tai Po','DLSO','Tai Po District Leisure Services Office','3/F, Tai Po Complex, No. 8, Heung Sze Wui Street, Tai Po, N.T.','3183 9020',22.446110,114.166610),(134,'North','DLSO','North District Leisure Services Office','4/F, Shek Wu Hui Municipal Services Building, 13 Chi Cheong Road, Sheung Shui, N.T.','2679 2819',22.502150,114.130690),(135,'Sai Kung','DLSO','Sai Kung District Leisure Services Office','9/F, Sai Kung Tseung Kwan O Government Complex, 38 Pui Shing Road, Tseung Kwan O, N.T.','2791 3100',22.317410,114.268110),(136,'Eastern','Tennis Court / Park','Quarry Bay Park','Tai Koo Shing, Quarry Bay, Hong Kong','2513 8523',22.288400,114.215520),(137,'Wan Chai','Tennis Court / Park','Victoria Park Tennis Court','1 Hing Fat Street, Causeway Bay, Hong Kong','2570 6186',22.282800,114.189650),(138,'Wan Chai','Tennis Court / Park','Bowen Road Tennis Court','2B Bowen Drive, Wan Chai, Hong Kong','2528 2983',22.274520,114.166790),(139,'Wan Chai','Tennis Court / Park','Causeway Bay Sports Ground','Causeway Road, Causeway Bay, Hong Kong','2890 5127',22.280490,114.190630),(140,'Wan Chai','Tennis Court / Park','Hong Kong Tennis Centre','133 Wong Nai Chung Gap Road, Wan Chai, Hong Kong','2574 9122',22.260180,114.192570),(141,'Kowloon City','Tennis Court / Park','Junction Road Park Tennis Court','195 Junction Road, Kowloon City, Kowloon','2336 4638',22.338350,114.183930),(142,'Kowloon City','Tennis Court / Park','Tin Kwong Road Tennis Court','15 Tin Kwong Road, Kowloon City, Kowloon','2711 1532',22.322520,114.186050),(143,'Wong Tai Sin','Tennis Court / Park','Ma Chai Hang Recreation Ground','30 Ma Chai Hang Road, Wong Tai Sin, Kowloon','2321 0110',22.344310,114.188330),(144,'Wong Tai Sin','Tennis Court / Park','Morse Park Tennis Court','No. 30 Heng Lam Street, Wong Tai Sin, Kowloon','2338 3047',22.335430,114.190860),(145,'Wong Tai Sin','Tennis Court / Park','Shek Ku Lung Road Playground','18 Lok Sin Road, Wong Tai Sin, Kowloon','2383 9024',22.331150,114.193470),(146,'Yau Tsim Mong','Tennis Court / Park','Cherry Street Park','9 Hoi Ting Road, Mong Kok West, Kowloon','2625 4584',22.316180,114.165940),(147,'Yau Tsim Mong','Tennis Court / Park','King\'s Park Tennis Court','King\'s Park Recreation Ground, 23 King\'s Park Rise, Yau Ma Tei, Kowloon','2385 8985',22.310390,114.173400),(148,'Tuen Mun','Tennis Court / Park','Tsing Sin Playground Tennis Court','37B Area ,Tsing Sin Street, Tuen Mun, N.T.','2451 1319',22.384640,113.980200),(149,'Tuen Mun','Tennis Court / Park','Tang Shiu Kin Sports Ground Tennis Court','Tsun Wen Road, Tuen Mun, N.T.','2454 5049',22.404440,113.973230),(150,'Yuen Long','Tennis Court / Park','Sai Ching Street Tennis Court','6, Sai Ching Street, Yuen Long, N.T.','2478 3345',22.441590,114.027220),(151,'Kwai Tsing','Tennis Court / Park','Kwai Shing Playground','Kwai Shing Circuit, Kwai Chung, N.T.','2489 8489',22.361600,114.125500),(152,'Kwai Tsing','Tennis Court / Park','Tsing Yi Park','Tsing Luk Street, Tsing Yi, N.T.','2435 0533',22.356160,114.105870),(153,'Tsuen Wan','Tennis Court / Park','Tsuen Wan Riviera Park','No.2A, Yi Hong Street, Tsuen Wan, N.T.','2406 9145',22.363370,114.112150),(154,'Tsuen Wan','Tennis Court / Park','Tsuen King Circuit Playground','Tsuen King Circuit, Tsuen Wan, N.T.','2416 1969',22.379380,114.106310),(155,'Tsuen Wan','Tennis Court / Park','Shing Mun Valley Park Tennis Court','21 Shing Mun Road, Tsuen Wan, N.T.','2415 4925',22.374750,114.125070),(156,'North','Tennis Court / Park','North District Sports Ground','26 Tin Ping Road, Sheung Shui, N.T.','2679 4913',22.506270,114.130610),(157,'Tai Po','Tennis Court / Park','Tai Po Sports Ground','21 Tai Po Tau Road, Tai Po, N.T.','2666 0344',22.455780,114.161230),(158,'Tai Po','Tennis Court / Park','Wan Tau Kok Playground','Wan Tau Kok Lane, Tai Po, N.T.','2650 1000',22.445700,114.169280),(159,'Tai Po','Tennis Court / Park','Tai Po Waterfront Park (Bowling Green)','Dai Fat Street, Tai Po, N.T.','2667 5489',22.452580,114.178060),(160,'Sha Tin','Tennis Court / Park','Siu Lek Yuen Road Playground','1 Siu Lek Yuen Road, Sha Tin, N.T.','2637 2743',22.388060,114.204810),(161,'Sha Tin','Tennis Court / Park','Tsang Tai Uk Recreation Ground','Sha Kok Street, Sha Tin, N.T.','2698 2648',22.374300,114.189720),(162,'Sha Tin','Tennis Court / Park','Yuen Wo Playground','16 Yuen Wo Road, Sha Tin, N.T.','2605 3622',22.385580,114.195420),(163,'Sai Kung','Tennis Court / Park','Po Tsui Park','Yuk Nga Lane, Tseung Kwan O, N.T.','2703 7231',22.325020,114.252990),(164,'Sai Kung','Tennis Court / Park','Sai Kung Tennis Court','Wai Man Road, Sai Kung, N.T.','2792 6459',22.382980,114.275240);
/*!40000 ALTER TABLE `governmentfac` ENABLE KEYS */;
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
  `bid` int(11) NOT NULL,
  `start` int(30) NOT NULL,
  `end` int(30) NOT NULL,
  `requirement` varchar(50) NOT NULL,
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `password_hash` varchar(128) DEFAULT NULL,
  `about_me` varchar(140) DEFAULT NULL,
  `last_seen` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_user_email` (`email`),
  UNIQUE KEY `ix_user_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (0,'Test','Test@mysql.com','pbkdf2:sha256:260000$Uw02Mf7JRkPTXr91$52ec5a46b8963064151e369228c27e1c15cab1a67f08b4b400745a03150d0ffa',NULL,'2022-03-01 01:44:50'),(1,'Test1','Test1@gmail.com','pbkdf2:sha256:260000$XqtIZvpNbidnxmZt$69b721995a35790a186359f00cfca6890dec4df62c4c271ee4ac0bf3474408c6',NULL,'2022-03-01 15:12:25'),(2,'Test2','Test2@gmail.com','pbkdf2:sha256:260000$GWvfRjpkvk3hf6tE$d30232a673234002b05759653a45904ebd3d7fd2d5d85ca2b8874b2ac0d54c42',NULL,'2022-03-01 08:47:56');
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

-- Dump completed on 2022-03-01 15:30:08
