-- File name: C:\Users\NineHo\Desktop\db.sql
-- Created by 簐礇 


--
-- Table structure for table `alembic_version`
--

CREATE TABLE `alembic_version` (
  `version_num` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`version_num` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` INT NOT NULL DEFAULT 0,
  `username` VARCHAR(64) NULL DEFAULT NULL,
  `email` VARCHAR(120) NULL DEFAULT NULL,
  `password_hash` VARCHAR(128) NULL DEFAULT NULL,
  `about_me` VARCHAR(140) NULL DEFAULT NULL,
  `last_seen` DATETIME NULL DEFAULT '00-00-00 00:00:00',
  PRIMARY KEY (`id` ASC),
  UNIQUE KEY `ix_user_email` (`email` ASC),
  UNIQUE KEY `ix_user_username` (`username` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `followers`
--

CREATE TABLE `followers` (
  `follower_id` INT NULL DEFAULT 0,
  `followed_id` INT NULL DEFAULT 0,
  CONSTRAINT `follower_id_user_id` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `followed_id_user_id` FOREIGN KEY (`followed_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `userID` INT NOT NULL DEFAULT 0,
  `userName` VARCHAR(50) NULL DEFAULT NULL,
  `permissionLevel` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`userID` ASC),
  CONSTRAINT `userName_user_username` FOREIGN KEY (`userName`) REFERENCES `user` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `Street` VARCHAR(100) NOT NULL,
  `support` BOOL NULL DEFAULT 0,
  PRIMARY KEY (`Street` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `plan`
--

CREATE TABLE `plan` (
  `id` INT NOT NULL DEFAULT 0,
  `Pname` VARCHAR(20) NULL DEFAULT NULL,
  `Price` INT NULL DEFAULT 0,
  `Speed` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `mob_plan`
--

CREATE TABLE `mob_plan` (
  `id` INT NOT NULL DEFAULT 0,
  `Pname` VARCHAR(20) NULL DEFAULT NULL,
  `Price` INT NULL DEFAULT 0,
  `Data` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `pay`
--

CREATE TABLE `pay` (
  `id` INT NOT NULL DEFAULT 0,
  `planid` VARCHAR(0) NULL DEFAULT NULL,
  `Paydate` DATETIME NULL DEFAULT '00-00-00 00:00:00',
  PRIMARY KEY (`id` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `e_service`
--

CREATE TABLE `e_service` (
  `ServiceID` INT NOT NULL DEFAULT 0,
  `ServiceName` INT NULL DEFAULT 0,
  PRIMARY KEY (`ServiceID` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `support_tel`
--

CREATE TABLE `support_tel` (
  `Telno` INT NOT NULL DEFAULT 0,
  `Service` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`Telno` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `global_talk`
--

CREATE TABLE `global_talk` (
  `Function` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Function` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `referral_rewards`
--

CREATE TABLE `referral_rewards` (
  `id` INT NOT NULL DEFAULT 0,
  `DesignatedService` VARCHAR(100) NULL DEFAULT NULL,
  `Referrers` INT NULL DEFAULT 0,
  PRIMARY KEY (`id` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `my_tv_super`
--

CREATE TABLE `my_tv_super` (
  `PlanID` INT NOT NULL DEFAULT 0,
  `PlanLevel` VARCHAR(20) NULL DEFAULT NULL,
  `channel` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`PlanID` ASC)
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `id` INT NOT NULL DEFAULT 0,
  `body` VARCHAR(140) NULL DEFAULT NULL,
  `timestamp` DATETIME NULL DEFAULT '00-00-00 00:00:00',
  `user_id` INT NULL DEFAULT 0,
  PRIMARY KEY (`id` ASC),
  KEY `ix_post_timestamp` (`timestamp` ASC),
  CONSTRAINT `user_id_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) DEFAULT CHARSET=utf8 ENGINE=InnoDB;

--
-- Dumping data for table `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES ('4831e933d59a');

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`,`username`,`email`,`password_hash`,`about_me`,`last_seen`) VALUES (1,'john','john@example.com',NULL,NULL,NULL),(2,'susan','susan@example.com',NULL,NULL,NULL),(3,'Test','123@Test.com','pbkdf2:sha256:150000$Nm66jAsz$f83a33e8313fd1e286a087239a76ed7bffd67708c4da4dcfc6b3b4b13713da21','Test Edit Profile','2022-02-28 15:28:51.216107'),(4,'Admin','Admin@email.com','pbkdf2:sha256:150000$Wxv15cDc$e6aef2febd52da48d4b6de44a3f425fdac92f4151e9c52a01b8285b565b8ffc4',NULL,'2020-05-03 12:40:08.716761');

--
-- Dumping data for table `followers`
--

INSERT INTO `followers` (`follower_id`,`followed_id`) VALUES (4,3),(3,4);

--
-- Dumping data for table `permission`
--

INSERT INTO `permission` (`userID`,`userName`,`permissionLevel`) VALUES (1,'john','Admin'),(2,'susan','Admin'),(3,'Test','Staff'),(4,'Admin','Admin');

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`Street`,`support`) VALUES ('Lam Tin',1),('Kwun Tong',0),('Ngau Tau Kok',0),('Kowloon Bay',0);

--
-- Dumping data for table `plan`
--

-- INSERT INTO `plan` (`id`,`Pname`,`Price`,`Speed`) VALUES (1,'Normal Speed',50,'100Mbps'),(2,'Faster',150,'1000Mbps'),(3,'Ultimate Speed',250,'2000Mbps');

--
-- Dumping data for table `mob_plan`
--

INSERT INTO `mob_plan` (`id`,`Pname`,`Price`,`Data`) VALUES (11,'3G',30,'10GB'),(12,'4G',90,'20GB'),(13,'4.5G',150,'20GB'),(14,'5G',300,'30GB');

--
-- Dumping data for table `pay`
--

INSERT INTO `pay` (`id`,`planid`,`Paydate`) VALUES (3,'3','2020-05-03 10:01:39.155541'),(4,'5G','2020-05-03 04:17:02.498034');

--
-- Dumping data for table `e_service`
--

INSERT INTO `e_service` (`ServiceID`,`ServiceName`) VALUES (1,光纖寬頻),(2,流動通訊及裝置),(3,娛樂),(4,家居電話及IDD),(5,其他服務、資訊及下載),(6,賬戶及月結單);

--
-- Dumping data for table `support_tel`
--

INSERT INTO `support_tel` (`Telno`,`Service`) VALUES (11112222,'Tech-Support'),(22223333,'aftersell'),(33334444,'other-problem');

--
-- Dumping data for table `global_talk`
--

INSERT INTO `global_talk` (`Function`) VALUES ('Call Hong Kong number is free!'),('Save the global call fee'),('High security');

--
-- Dumping data for table `referral_rewards`
--

INSERT INTO `referral_rewards` (`id`,`DesignatedService`,`Referrers`) VALUES (1,'Broadband Services',500),(2,'Mobile Services\r\n',200);

--
-- Dumping data for table `my_tv_super`
--

INSERT INTO `my_tv_super` (`PlanID`,`PlanLevel`,`channel`) VALUES (1,'myTV Silver','Discovery、BBC、Ani-One'),(2,'myTV Gold','beIN SPORTS, Discovery, Disney, Blue Ant');

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`id`,`body`,`timestamp`,`user_id`) VALUES (1,'my first post!','2020-03-08 08:58:52.298315',1),(2,'Testing123\r\n','2020-03-26 06:29:31.886450',3),(3,'Test321','2020-03-26 06:29:45.682782',3),(4,'123','2020-03-26 06:30:04.958390',3),(5,'Test','2020-04-08 11:48:21.384074',4),(6,'Hi','2020-04-08 11:49:15.259103',3);
