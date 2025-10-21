-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: sibers_test
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` enum('male','female','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthdate` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `isAdmin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (11,'user112','$2b$10$MKl2Fm8rmuJ1Pp8iX.OD0ea.f/5fabymh1xUAvqM1ABaRaDyLXiOq','user23','user233','female','2025-10-21','2025-10-21 09:12:20',0),(14,'user2','$2b$10$v3UHyRRWq8OMa1DCCCo4f.jPZMILvSQm9PgXRVmh4h8QTey8dsSkK','Имя2','Фамилия2','female','1992-03-12','2025-10-21 09:31:00',0),(15,'user3','$2b$10$H01t/0JoKllKew6ZD/Fd/uDzADS7g0IxsbFCEbIHQMSkp/rry6q92','Имя3','Фамилия3','other','1993-04-13','2025-10-21 09:31:00',0),(16,'user4','$2b$10$hoEGVw0RhCtw9N61EI3VRuTo.SA4CHPw7b.m1qsAxxsxShx/Qmp3u','Имя4','Фамилия4','female','1994-05-14','2025-10-21 09:31:00',0),(17,'user5','$2b$10$4CH3db83zAOmnhzP.Zmqvuyo3j8PGGEMGn5azD4vIRSPCtWrPtZA2','Имя5','Фамилия5','male','1995-06-15','2025-10-21 09:31:00',0),(18,'user6','$2b$10$1WjT/wP4Rp/cIdkIWDQaoeY/VmKXoceDTtMuiY.nodNMZVQ/i3FgK','Имя6','Фамилия6','other','1996-07-16','2025-10-21 09:31:00',0),(19,'user7','$2b$10$BEg41nAKeU8zeeXQFA.oAOoux3LW7TJkarDogyLO8d/l2A4H3srNy','Имя7','Фамилия7','male','1997-08-17','2025-10-21 09:31:00',0),(20,'user8','$2b$10$lXXHv4V6fWRiWsLOuB8eiew.yml71hEVk08d4Nx0d.mW2zNWOdqX2','Имя8','Фамилия8','female','1998-09-18','2025-10-21 09:31:00',0),(21,'user9','$2b$10$v6zXWxEDw0x1bJCoj8ycweTMMitTWkC./rnszA00y/GyXAQgdyNgK','Имя9','Фамилия9','other','1999-01-10','2025-10-21 09:31:00',0),(23,'user11','$2b$10$134n1P/BV4fWXIfCpPs19eovEvoh0Uo/uW.gyiUJjCefAfOPd7ZvO','Имя11','Фамилия11','male','1991-03-12','2025-10-21 09:31:00',0),(24,'user12','$2b$10$6gLJ0mCjUp3IbCpSgyDCle4nE6ES83ss9i2LPiiLBgCZLPUnCYKc6','Имя12','Фамилия12','other','1992-04-13','2025-10-21 09:31:00',0),(25,'user13','$2b$10$andiLYOfvXhcJN9yGWlDcuY1wKripP/uqSJ8.KKKFVRR/33NAPSNO','Имя13','Фамилия13','male','1993-05-14','2025-10-21 09:31:00',0),(26,'user14','$2b$10$MCVI70MHRo03s6VqKXC04OIhKK6.MbPw13yEBe7oQP.ionM.xnKOK','Имя14','Фамилия14','female','1994-06-15','2025-10-21 09:31:00',0),(27,'user15','$2b$10$7Abtvmw8cZ/jWozFuipPfeLv837Yc4n1EHq48r.W2RZKmYTsrJnDC','Имя15','Фамилия15','other','1995-07-16','2025-10-21 09:31:00',0),(28,'user16','$2b$10$Uy3XX.zk8vZj9rcyBU4zgOd1ot6GOyYGsmQRNuszVF4ElZOEWL.Fa','Имя16','Фамилия16','female','1996-08-17','2025-10-21 09:31:00',0),(29,'user17','$2b$10$m3w8Qy46uOxe4QEHPx46eODelZDS4SSCgCFOk780.1jPqSZT7X6Ea','Имя17','Фамилия17','male','1997-09-18','2025-10-21 09:31:00',0),(30,'user18','$2b$10$aGGemey.QXQxAxS6fmGYN.FVEFoiA8eGrON.g05euM3/1icmg60ba','Имя18','Фамилия18','other','1998-01-10','2025-10-21 09:31:01',0),(31,'user19','$2b$10$JO.orPoowScX9jow7g.e1el5MPxl/Z2LVL6FNF14LBG3tx7ilyjK2','Имя19','Фамилия19','male','1999-02-11','2025-10-21 09:31:01',0),(32,'user20','$2b$10$EkMnxhMdS5OVAjisTgv5MOjcBqB7dNjcfvP1/MzyOLZMRYbboKJ1e','Имя20','Фамилия20','female','1990-03-12','2025-10-21 09:31:01',0),(33,'user21','$2b$10$G1NDbnpnHYv9c5Cza4ZAUOzkp6R7/Hty2laVsmzhScqUvckUYYive','Имя21','Фамилия21','other','1991-04-13','2025-10-21 09:31:01',0),(34,'user22','$2b$10$dqjFsSPo4.fmVjKy.glh4u6bHjXJu54cbGSSEFaHMOeNfR476tYCi','Имя22','Фамилия22','female','1992-05-14','2025-10-21 09:31:01',0),(35,'user23','$2b$10$InENGHG6Z8NmLlYcnYyM4u87ZnE.zUnu5DPWcew/.YfrbZvdOILs6','Имя23','Фамилия23','male','1993-06-15','2025-10-21 09:31:01',0),(36,'user24','$2b$10$fD5uuKbWs26tw3eFUxp1xuO5LJXOgbMYp/fI8nRMcMqED/6xJw9wa','Имя24','Фамилия24','other','1994-07-16','2025-10-21 09:31:01',0),(37,'user25','$2b$10$y2yr8VPLZYGieFAUpVp8i.lKMEHn.60Mpkb4vmPkc07BMvU4Yg76u','Имя25','Фамилия25','male','1995-08-17','2025-10-21 09:31:01',0),(38,'user26','$2b$10$RtL5D6tUiJCfX.iiZEEAD.hLMzDUAm7BLt0M7ZCr4Z9HUTXYzKBLC','Имя26','Фамилия26','female','1996-09-18','2025-10-21 09:31:01',0),(39,'user27','$2b$10$D/rCUGF17bedTcBWpON9iuaFD91.LVmpWkQr3a4ov0H2BrNlBz9sO','Имя27','Фамилия27','other','1997-01-10','2025-10-21 09:31:01',0),(40,'user28','$2b$10$6ErX23eCcDLBfuQKoFfqhuhThmpQyrijNDtKeMWG3ufl3d.G7ZrWC','Имя28','Фамилия28','female','1998-02-11','2025-10-21 09:31:01',0),(41,'user29','$2b$10$oILy.Dq00w320omjda7PkOE3mXjxVOj9VKnX2Cmekek/MGLMBwp6e','Имя29','Фамилия29','male','1999-03-12','2025-10-21 09:31:01',0),(42,'user30','$2b$10$0fIit3XFdreH4HlCAUQnPeuUOOdezK8BdInV/bbw7IPWsSRKrwZ6y','Имя30','Фамилия30','other','1990-04-13','2025-10-21 09:31:01',0),(43,'user31','$2b$10$fZbg0k3sjgDoD1f67PHTjeyrudRYUMs/Mk6..LB1y6n159IrcOvnq','Имя31','Фамилия31','male','1991-05-14','2025-10-21 09:31:01',0),(44,'user32','$2b$10$wKZAy0NrjGkqRp6S4hiMj.i.D712qIkYXageWXJmPi.1/Do82vOGa','Имя32','Фамилия32','female','1992-06-15','2025-10-21 09:31:01',0),(45,'user33','$2b$10$.QkgS3fXW.lb821jONoFRuTP0D2fSoZv/frvQEbk.Mmj9bwY0Dmi6','Имя33','Фамилия33','other','1993-07-16','2025-10-21 09:31:01',0),(46,'user34','$2b$10$HUWNw6NK9LYMRKT5twHFhunjZS6icf3fTJdliiWD4Q20bRJsX9tqK','Имя34','Фамилия34','female','1994-08-17','2025-10-21 09:31:01',0),(47,'user35','$2b$10$ST091fo2GvkHr9D9J.XejO1h9nX56UQgY3URbBMtM6J56Fmt4dbwe','Имя35','Фамилия35','male','1995-09-18','2025-10-21 09:31:01',0),(48,'user36','$2b$10$axH.gT4.LHSgA224yH5XeuEzA6f/rKS3zaj6L44fRnKmn1T1vOCza','Имя36','Фамилия36','other','1996-01-10','2025-10-21 09:31:01',0),(49,'user37','$2b$10$Yu2UrP.c/5pS1tBPDXPlquuprm3/5UAphs4c/9JlOjYfO3SJX4Ryu','Имя37','Фамилия37','male','1997-02-11','2025-10-21 09:31:02',0),(50,'user38','$2b$10$Ot0qQfD2DHQyYyU6MVndeuzY06W.UyYFAg0EfJAHUbez40UPNayO2','Имя38','Фамилия38','female','1998-03-12','2025-10-21 09:31:02',0),(51,'user39','$2b$10$Dr6Z4vdtHLVw2fJeFq6uAOYe/fnRDFcL070SZ75yFjBOvSXxTFbly','Имя39','Фамилия39','other','1999-04-13','2025-10-21 09:31:02',0),(52,'user40','$2b$10$3/kgIq5SvP2gT5kL4BoEMOMo3yZL/qLf7FNAndOQolRsbkpfzShv6','Имя40','Фамилия40','female','1990-05-14','2025-10-21 09:31:02',0),(53,'user41','$2b$10$xbVtgE4wPR83fTKgfbNvEesL/YlGYCpkH0IsEnbZUCROMGnJOZfKq','Имя41','Фамилия41','male','1991-06-15','2025-10-21 09:31:02',0),(54,'user42','$2b$10$VTKg3c0p34EEsoNWXHDmD.9Wm46gpjJmWWE.SUwkCB9OmhIUC8ygm','Имя42','Фамилия42','other','1992-07-16','2025-10-21 09:31:02',0),(55,'user43','$2b$10$0BUoO32JslMLsD.nkwpyoeFZjaBUsnieDTxuAZ2/sIlhWhPRhpaqq','Имя43','Фамилия43','male','1993-08-17','2025-10-21 09:31:02',0),(56,'user44','$2b$10$3vurl.i2jFw5njXJwHcun.3.9j1/NfcNDPSnDN04oR/SrfQgrnx4K','Имя44','Фамилия44','female','1994-09-18','2025-10-21 09:31:02',0),(57,'user45','$2b$10$LGGlW4pVcacBSdEJ4uutuOwrAO7EagRqOMRRhdCgJqNNg2ULa4PeC','Имя45','Фамилия45','other','1995-01-10','2025-10-21 09:31:02',0),(58,'user46','$2b$10$2LjA75/DsD8XN1gQkJBFhO5Co2p/oQ06AeZ.5p5IazFmV5CdS8fJe','Имя46','Фамилия46','female','1996-02-11','2025-10-21 09:31:02',0),(59,'user47','$2b$10$ADygwdDmVVWiXQoYQOKXuOlSNqWvZHcIq0S.IjqhVDb/sTVSgN2.i','Имя47','Фамилия47','male','1997-03-12','2025-10-21 09:31:02',0),(60,'user48','$2b$10$80WtTHPqXJXBVTMMgd6al.kAiEyODhssWfmEFbCSz/Wqz3Mv30if2','Имя48','Фамилия48','other','1998-04-13','2025-10-21 09:31:02',0),(61,'user49','$2b$10$MYH7ecTEy2bWT0LDQQ7TnupW5bjVL1wY5xgU8q5ZGJ5H8DyO03rBC','Имя49','Фамилия49','male','1999-05-14','2025-10-21 09:31:02',0),(62,'user50','$2b$10$lxbb325IwSjGCemQhKS5.Oa68N4tXqVlYnUk.dMBqRJPRmlpZ2Xl6','Имя50','Фамилия50','female','1990-06-15','2025-10-21 09:31:02',0),(65,'admin','$2b$10$oMBvT9.8vjBMFDF8JjWH6eXsNeQ.jI4uiq7ZpWUKX/c3CBxED9fjS','admin','admin','other','2025-10-17','2025-10-21 10:30:50',1),(66,'user','$2b$10$TQUqOS3wy66TqXlbb1yg/esWIZ/0fHk5FIKDx9PBmRTyVAU8NNoZu','user','user','other','2025-10-22','2025-10-21 10:31:01',0);
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

-- Dump completed on 2025-10-21 18:22:22
