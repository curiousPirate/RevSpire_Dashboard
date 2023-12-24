CREATE DATABASE  IF NOT EXISTS `revspire_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `revspire_db`;
-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: localhost    Database: revspire_db
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `audit_log_ibfk_1` (`user`),
  CONSTRAINT `audit_log_ibfk_1` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES ('BNL096725983635','IGH141585754362','login-success','2023-11-24 10:07:18','::1'),('BNL118306871613','IGH141585754362','login-success','2023-11-20 12:38:32','::1'),('BNL139041912871','IGH846177043249','password-reset-requested','2023-11-24 10:13:49','::1'),('BNL152502549954','IGH141585754362','login-success','2023-11-20 12:39:10','::1'),('BNL188750228088','IGH141585754362','login-success','2023-11-24 10:07:03','::1'),('BNL230685075959','IGH141585754362','password-reset-requested','2023-12-16 16:02:51','::1'),('BNL637677695264','IGH846177043249','password-reset-requested','2023-11-24 10:14:55','::1'),('BNL685843966608','IGH141585754362','password-changed','2023-11-24 10:12:48','::1'),('BNL701484626811','IGH141585754362','login-failed','2023-11-20 12:38:49','::1'),('BNL932595327432','IGH141585754362','login-failed','2023-11-24 10:07:12','::1');
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `audit_log_before_insert` BEFORE INSERT ON `audit_log` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'audit_log' LIMIT 1;
    
    -- Generate a 12-character unique string. This example uses a simple random number for demonstration.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `thumbnail` mediumblob,
  `source` enum('One Drive','Google Drive','Local Drive') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mimetype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `folder` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_content_created_by` (`created_by`),
  KEY `fk_content_updated_by` (`updated_by`),
  KEY `fk_content_folder_idx` (`folder`),
  CONSTRAINT `fk_content_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_content_folder` FOREIGN KEY (`folder`) REFERENCES `folder` (`id`),
  CONSTRAINT `fk_content_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES ('KBD042516231576','Presentation.pptx','https://storage.googleapis.com/revspire_test/Presentation.pptx',NULL,'Local Drive','2023-12-16 15:03:11','2023-12-16 15:03:11','IGH141585754362','IGH141585754362','application/vnd.openxmlformats-officedocument.presentationml.presentation','xlsx','WRS695055681927'),('KBD176752893418','19+Nov+Client+enriched+vs+SFDC_matched_account_20231119_120425.csv','1c5msOC6qHjrw_u1OM-hsY5ZotYnUTGST',NULL,'Local Drive','2023-12-16 14:16:58','2023-12-16 14:16:58','IGH141585754362','IGH141585754362','text/csv','Image test','WRS695055681927'),('KBD185702286833','Content 1','sdqsq',NULL,'Google Drive','2023-12-12 16:08:38','2023-12-12 16:08:38','IGH141585754362','IGH141585754362','pdf','C Demo','WRS765168112483'),('KBD245341655095','8. Tag Manager add tag + Add condition screen.png','1eebC9lEP7azboaSgT3xl4qmG2u3B9yJE',_binary '‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0€\0\0\0€\0\0\0\Ã>a\Ë\0\0\0	pHYs\0\0\0\0\0šœ\0\0 \0IDATxœ\\½÷›Õ‘5\Ú3\ã6 L°›Œq$&H\"+‘•„A€°H’@B$$PN­\Î\Ý\'\çœsÎ¡³Z\íù\î½ÇºÏª}N\Ã\Ìû99\îz«V­ZUo\ÇÂ¿ÜŠ»;·Ì»\n\×]ñ3\Ìýyfÿ¼s~þo¸ú—?\Ã5ÿ\ç?põ¿Àu¿þ®¾új|ü\ÞZ8†@sr7†cy4ˆ‡¬(¤}¨–¢8¦†±ñ\n¦NWq\ál\rgOW16ZE£Y\Æ\Èhg&*¸pº†s§k+bl¤€©ñNO”11Z\Äh=‹ñ\Ñ*\Õ\Ê\å,\Ê\Õ4*\Õ4š,Fš9T«IT«	TkIT+IŒ7ó®\çP*\ÇQ«\'Q­¥P«§Q,&Ñ¨¥1\Ú\È\É\Z©g1\\\Ï`¸‘A³žF£–D½’@¹G¡A6D¹AµG¥CµC©B1@)D)§V.\ãG>@1B!D&\íC6\ËûüÈµ.³YRi\"abQ\'ò9?\Ê\Å ª¥0*Åˆ¬b>„l.ˆ\"oWb\È\ç\Ãh4\Ôw\Êg\Ã((¢(ó»T“¨T(•b¨Õ²h\Ôn–0\Ò,bl¬Š‰\É&&&Gp\æ\ì8Îœ›À\ÔT\ç\Æ\Ó¯E1\\Ž V¢R£^Œ¢YŠ¢YI YI¢\ÙH£cÇº¥øøÕ§ð\î²\Çñ\Ê_\ïÁÃ¿û-\î½\å:\Ü~\ÍL\Ìû\ÅbÆ¿u`\Æ/þs¯ž‹¹ó®Æ–÷\×\ÃÖ¿}G>‡¡{lƒ\á2ž‚\Ï6€dÄ³§++cjªŠóg\ê83Y\Åðp	f\Í\á2FG‹˜/ar´„z]m\ÐD³ ›\Ûhð\Çe1\ÚÌ£XL¡XÌ ZK£^K\É}#õŒúC*IÙ¸¢ü!)òqd2Q”Š1”Kqy¼OˆŒ\ÐpZ«½ñZ\n\åJ\n¹|T6 \\ŽŠQññf=\Õ2Ž*¥0ª\å°l\\UþH\ZH\ÕrT§Á\ÓŠ4BX6µ!—\"\Zõ p v\"ó!ó#\r \Z	ÀòÁð ô\"ô!ò#	\"\r £XH Ÿ¡\Ä\ßRM\ÈÿT­\ÄQ«&\Ñh\ä0\Ü,\Ê\Ê5:V\ÅøD\ãÃ˜<=Œ³\ç&pñ\âÎŒe0Ñˆc¤A½B¥ 8Ÿñ!=m´!t¼¿\ì1¼»\äl^ñ¶½ö>y\åilyõy|üÚ³X÷\Ü\ãXò\Ð}˜ÿ‡;ñ»;n\Åõ7þ[6ÿ\rÖ¾o\Ðt;t_ÁÐ¹Æ®¯a\êý\Ýq³ŒU05YÁ¹351€ñ‰\Æ\'+­`l¼ŒÉ‰2\ÆÇŠ¨5\Ò\Îcr¤€\æpVŽôz=f#‡B1…Z-‡qzˆ\á<F›91n0ÿ˜R!\"+_Œ!“\å\Ä#%\ÑòI”+	73\ÓK6¶žB½’D½C±E2B*B&B:D*@2\îC*\æG2\âF$\â€?`…\ßo\×g‚\×c\Ûm\Ín‚\Ùb‚N¯GO\ï\0:»ûq²«WÖ©\î^tõô¡§§]=ý\è\î@ß ýC\Zô\ri0¨\×Cc0À`6Ád1\Âd1Cg4À\æ°\â\ëƒý\è\Ð ™ô#s#÷\"™ð!÷!ó “	¡PL ZÉ VÏ¡\ÖÈ¡9R\ÄøD§§”8{~\çÎ\âôx£\Í$†KA¤\"v\Ä\Â6\ÄB6$\"$\âN$nd’tüm\á}x÷…Gð\áË‹°i\é\ãx÷¹¿\ÊúûŠ\Å\Øü\â\Ó\ØúúRl_÷\Zvn|[\ßz{6¿…ƒ\Û\ÞÁ\Ñ\í›\ÐûõV\Ø\Ãñ¯`\ê\ÜS÷^\Øõ\ÇPÊ†1\ÞÈ£!›¡«‹  ‘#“#—‹\ÈJ$ýò\ã\Ò	?	?b1?bñ\0R‰\0¢QR© \ÌV;ú5fX\ív˜­6\è\ÍhF¬V\è,Vô\ë\è\ê×£«W‡\Î\rºt\Ð\Z\Ñ;¤Ç\ÖÖˆÁ\Ö\ZÒ˜ 5XÑ§1`@gB\ï§ú5\è\ìÓ¡³×€\ÝC\è\Ð@£\ÓÁjµÀ\î´À\é´\Â\ãµÁ\ãµ\Â\ïsÀ\ïs\Â\í±\Ã\á²\Â\î0\Ã\ê0\Â\á¶À\ã1\Ã° °\"\à· \ÈË€\áˆñ¤‰¤©„G75™ô\"™ö •ò#™ò‹÷0Xœ°:\ìHgƒˆ\Å}H$H&‚ˆ\ÇýH§\"È¤#H&ƒH\ÄýH&CˆÅƒHòþlùB\nõF	Sg\Çq\á\â8NO0ô%0Z QŒ VŠ¢QdHˆc¸œÀp! ¥\à\íg\æ\ã½Á;\Ï<ŒwŸ^€wžZ€·Ÿzo.Z€·žz›–?-«_Áö\rk°y\Ås\Øð\ÄØ¸ø!üý\ÙÇ°}\Åb\ì]³\'>Z‡Á½Al\ìº\ãk\ä1>’G©\ÄxC£–A½’\Â­¶®\\{¹œ@¾C¡À#˜?\"Ž|!\\>‰l>b9“ÍƒA“\ÙlD\"•Ž\"‘Š ™Ž\"ž‰ ‘V+š!##žŒ!\ZÈŠ%bH¤H¦cH$BH§#\Èfyô‡‘HQ)DQ-\Å\Ä8“©\0Ê•(ªºû(\Ê\Å\Ðôj‡^ªû‚²\n9?²i²)2)\ÒI7\Ò)\Þö\"ŸöKH`ˆ(B‚)¸\ÊÅ°\ÜV\ï\ÉP\ÅX#	w0(„\áfZ¼=^¥œ@›\ÕÌ¢\Ù\Ìa„\Þp¤€‘‘\"†G‰£\ê¨7Ê¨7+(Uò\È3˜¯\á\ÜTc\ÍF«Q4JT\n\ÔQ4\Êø¹\Õjo/~\0=€÷žz\ï.|\Î\Çú\Ç\ïÇ†\'\îÃ›O<ˆ\r=ˆµÜ\Ï>w_X„u\Í\Ç\Û\Ï<‰o¬Å®77\à\Ëõkð\å\ëË°{\åó8´a9º6¿Žž-\ë\á\í?„\Ñ\á\"\ê5¯4¦\Æ\Ëmd15V\Âiº­\á¼\Ä\åa\ZF-b‰\ÆÀ¸œTñ¿œB£‘\'D,F³É”8=\\O£R‰£PˆH¼n6þ”11N§Q«\Å0*ƒ\0’±?z…\0¯I Q\É&\×	\Â\n!¤’~¤R>òr	g…l`\Z\à\É\Êp\ÃýÈ¤¼H\'=H\Æ\\ˆ…\íˆEr™9ˆ¹\ÄÅ¦“^¤S>d1†t\Ê+¯\ç{g\Ó^y_\ZH>|avx\àP*…ä·•h„\å¨\0À6$¾\áÿUo\äXT16\Þ\ÄÔ™1\0	\Ï\ã¬@Ry€v\áo.\Å\Ñ\äbˆ¬¦\ÐñþsðÎ¢±é©‡±i\á|1‚õÝ‹·>€¿=ñ \Ö=z\ÞXp/\Ö?6kÜ‹7Ÿ|»\Þ\\‹“ŸŽ\î/¾BÿW{ ß·Ú¯¾‚~\×NXö\ì„n\çf|¼\Z\Þ\Î=¨\ãhð[`n¬™“ET^§;¢\'(Å‘\Í%P,e$öK)qk\ÍZ\'cÁ]\åjP«T‰’cr]n—\ÈTò9\ÅbµJBVµG]À_eñe\ZJ\\7]#Á\\2\åE&\ãoÝŽ¨#´F¹uòA\äi­Kn^*¡pB8lC¹‘K\ÓH´H\ÓX\Ò~!\É”Q‹\È\ï\Â\ïJ£4\ÙÜˆ%‚¨\×\ãb\ÐufMnvZ\äöj\çX\Óš\ÃUŒŒ\Öpzj\çÎŸÆ¥\ï&qf²€q1€(\ê\ÕJù\0òi/rŠ\ÜbÀ¹t-{›\Ï\ÇG\Ïÿ\ï\Ñ\Ó\æc\Ó\â‡ñ\Öbý£÷a\Ý\Ã÷b\Ã_ÄºG\îÇ¦a\çú\Õøb\íJ\ì^³ûÖ¬\ÄÁ5+±ÿÕ—pôÕ—\Ðÿö\Ðo{ƒŸ¬\ÂÐ‡/\Âwò+\ÔK)\ÔK	4k)I\Û&F\n#š­¦1\ÒÌ¢\\J¢PH\É\æŠiu\éL\åJ\Z:“i‚ŸBµ*74†z5ŽŠ¤iaµ\ÉU†‘0\Ò)¢qZ{\Å<±FEº>f¥*\ÅòÙ \Ä\Ûb‘©Vù|P6>q#\ZuBN1>3n\Çy4;:‰\Ø[\Û\n\Ù$¾{=8œz8]¸œ:¸Ý¼®ƒ\Ûe€Ã®ƒ‹÷»p{ŒðxMðy,úÍ²\Â!›`„@ÐŽDÒƒ^^¿©4ñÉ´Y¦¢Ef1”+qT™\É4³\â\èú&&‡% 0¸pqS“L4’­ÄŽ»ŒØ‘ˆ:’0\åE&@\ÇgËŸÄ‡\Ï>‚O–<†\ÍO?Œž}›ŸZ€\ÍO?Šw>„7½_`Ý‚\Ä\Þ{nv­[ƒ=\ë\×b\Ï\êUøúµW°÷\ÅØ·\ì~yz6¼\íG«¡ùø˜¶­†}û„\Ìýˆ\Ò5†HÇ¼HÀñ \Î#†_.\ê”ù\n1=r#t!ô »_‹`›\ãB<\áA,\î’‰¸\n9Žðº¡ >¯Á \á(\ï·\Ëý\ÌÅ£a—ln$\êD0d•Å†­ò\ç{½8rþ€E–\Ïo\ßgD\Ðo‚? V \ÈÇ¹¬ðù˜%3p¹Lp¹ùz#¼^“\Ü\ït\àö˜\ár›\át›\àñY\áY\á•\×:\àó\ÙeC.„\".t\r\áñ\Ùt‚ü®.x}6Cv„\éi\"N„cnùŸ\â‰ ÉˆxG†\Íj­ ˜\à\ìù	\\º4…³§‹˜¤T•»o”b\Ê—c©$0Â”²–@\Çö±u\éølùBl[ò8¶/_„mËž\Ä\Ç\Ï?†ž}Ÿxoþõ~¬›\Þ\\p6.z»Ö®\Æ\×\ë\ÞÀ×«V\áÛ•«pðµU8¶\ê5ô¼½¦­aÞ¾Æ^ƒkûz8·®…¿s/rqrqª\Ù *YÆ½r™\0J¹Jù0JE\æ¿a9B3®\Â\ÑL«©‘°n;aX\âc¾w_¯%P*¦p¨Ó„T6‚F3)\Ó\í‹\ëg\Ø\ÊP\Ñ\n-ðU-GÅ“\Ð\0S\É\0J\Å6X#ÀS€—ù<ÉŸ\0J\Ä\Ä)/Q\ÒqR1·„€d\Ü%\0PA^z‘eÞñ!“õ#“ó#“ M,‘\'	D •P@Cg¶¡^M´¸‰x‹ü‰95\Ò\È°n6\èúófhdQ¯Q«—/g‘)$‘/e0>\ÙÄ¹©&$\Ä1\Ì0L¼TŒ\Èe\á±“Ü±c\Å\"p\í|\é)l_¾_¼òv¼´Ÿ­X„O—-\ÂG\Ï=Ž¿?ý(\Þzô~ümÁýxû±ñ\á\Òg°{\Í\Z\ì]½V­Á‘\ÕkÑµ~\rŸ¼\rÛŽ·aÜº\îO\×\"¸\ãMx?Yƒ\Ð\á]¨dÃ¨\åB«&0Ê!ÁQ!H¡\ÉÜ½C­—8M—W,\ÆŽF\àñz\ä±80ZB\Þ\Ð\Å­Ka!uNæ µxð÷/Q©\Ý\ÆP aS£Vcˆ .`øˆK,gü%W\â&0¤½\ÊC„]Š\åcœ\'Q’ñ#—ò	`\ãF2~\æ^\ÙüTÜƒ8S¼°‰ˆQ\æ\Ø1§\ÄW•î¹‘N(#H§[+\éQB–¹ò\n¤R\èL64JQ9 ø›\éö+Uþ\'üR‚—†›9\áIFGò\'ƒ:5‚É©1Lž`rjc\ã\rÁ\04€‘J\Í\"\ÑMzz„ªJ;>]¾Ÿ,{[–/Ä§+žÄŽ—Ÿ\Æ\ç¯>ƒ\Ï_~;_~Ÿ¿ú,¶-_„MÁ\Æ\Ç\æã½…a\Ëó\Ïb\ÇË°\ï\ÅWqøµ\Õ\è}k=ôŸ¼\ã–Up}¾‘]o#¶\ã-D·½‰Àˆûm(Å½\êK£’–p\Õ\Êq4\Ê$v\çC²IYò¹œ^\Ü.\'¦F3ý°\Úl83Á?€Y€¢I\é&F3Ø¹_‹\ãý6D\">Á\ÕZ\Í&\r‹›Ÿ\Ì\n9u·\é\ØR^\é¹\\\0‘¨\á¨W0A™G?öôO\Ñ?Á\'×¹¹Iz€˜[€@:\ác‘£?\é™~>©\ádÊ\ã.©b\Z½Kž/$€\Ô\Ë\ßgwŠG\"v!5LŠº \à—\äsBRAýccŒ•1>Þ˜\Æ\04‚³&qñòYœ;S\Æd3Ž\Ñ*ô\Ê\Ù \n¤±3~d„\rô\"—ò£\ã£%O\â\ï\Ï?Ž\ÍKÇ§+Š\ìZõ<¾xýy|þ\Ò3\Øõ\Úó\Øù\êóøl\Ù3\Øú\Ü\"l{nv®x{^Y‚/\è	–<‹Ëž\Åñ×Ÿ\Ã\à\Æpm]‡\è\î\ÍH}ù2_|€\Äöw:µ™¥„£\å(†KaÔŠa4\ËqŒ\ÔR²\ÊD\ÞEE³f²a\á\0ŒV\Æð\0Æ›)hLðùÜ°˜¬BŽDc~„\ÂAŒ\r§9\ï6\áD·\Ûöôa\Ç\ÞAtYñ\í1œ7\Z¥rÙlpY9ºxn¬±81I\Z2)7’J1n°‰„±¨Ñˆ\rÑˆ]À[ÀkFÀkB\Ðk†\ßm„\ßcD\ÐgFÀo†\ßg‚Ÿ€`˜\Âo†\×g†\ßo‡\ßï€——‡\ÄyÀ…d*Œ!½\r6‡K”\äP*”ƒ —#›#W$PN R\É\nC:<\\À\ØhccuŒOc”pfg/L\àü¥\Ó87UÁd3ñzB\Ð?\Ó\Ôd\Ì)^*w\Êo\"\Ð\íx÷\éG±é™¿bós\ã“eñ\éKOcû\ËOc\ÇK\Ï\àóŸÁ¯/\Å\î\Õ/b÷\Ê\Øýò2\ì}e9ö¯|	\ÇÖ­Â©u«Ñ³a´ï­\îÝ•plÝ€\èî‘Þ·\r\Ù=[ûò#„v¼×±¯°ö#\à\Ò#´ Œ\íÊ…\Ä	\Þðûmð,ù]ˆD½\è\ì‚\Çk?hÅ‰\ÞA„{uaP«\Ã\ç{»Ñ¯\Ñ!w¢³{F³V«=ƒ:t\êa÷Xq¼g§úú°9œZA\ì>¯ImžÏ„€O¡nv\ì<^¼\\n=|.¼®¨s\ê\Õñ;vNv—V§A–\Ãm†ƒ\Ï÷X„9ôú¸ùx\ÜfùŒ`P\0\rÁ\ç%$[\è@<\êEÏ€6›\á˜ž€]–/ÀÁ¯Ï@È`Èƒ`È‹`Äh\"Œx*‚T&\\!Rµˆ\æø0NŸ›À¥\Ë\çpvª¢²\0\Ö8JqÉ„ó¹\Zd	\ë)t¼2ÿOXóÈ½\ØH\ä¿ô	|´|!¶¼ø¶¿ô,¾xõy\ìY½{×¾Œ}k_\ÃÁµ+qt\Í\ë8¶\æut®[…þõka|÷o\îÚ†ä¯9ü5²Gö!½r»?Ef\×|»\rŽž\Û5yLH†7‚\ÎQ7\âDµQ— \\AöaZ\']T½\Z“\Äe\É’t¥aYt\'z\Íb$ˆ\ÉtP¹Öœ_a‰\Z\Ó&‚Á*d\ï$×¦[U…\Zº~\æòY‚»BPrõxŒÀ\Í\'\î™q;“b:\È\îSy. ¯\Í\åýH§=Š\ÊeNb®@:E:[ÝŸcª\ÉjaV1€ª@°\Éø®0‹L\ä*\âh4\â°Ø¼(\æ£R	ˆ	üHúT\È]T2Â‘°BZ©dP*§P®f‘)¦\åÊ§È¦‘\Èg-d1>9*•XzÎ‘Z\ÃDý%ò1*nHQ-ŽŽgþ|\'žÿ\Ë]Xz\ï\ïð\Ú\ÃÁ†Ecó\Ò\Åø\ì\å°\ëõ\åØ³\æe\ì{\ã5|³öu\\»J\àèš•8¹v%\Ä\0Þ‚{\ÛfwŠ\ä·_ s\à+¤¾Ý…Ìž­ˆ\ìÿ¡\Þýˆ›ºPŽ9PNù0R\"	\É2ZMb„\"zÒª\Å\n¥\Zt[¹0tf;Šò\Ýdè˜³‡\àpx\Í\Æ0 \'g®6°X\n\É%7”\è:“\rHn\ÏX\Ê\ë4Œ\'gŒNy‘Ly\Êx¡ssú\nù\ç²ñŒ\å\n¶–‰¤J]\ãq7¢· z¾¯X\Ò>y€\Èq\Ô^\í÷n¯b.ˆr9,UM\Þ.G»-‹@’Z¥8\n%–»\Ó\n°2:R\Ä\Øx\r\ã“5ŒN\Ô\Ðkb\â\Ì\ÆO`t¬©`„¬iRJ¿£e–€	¼\nV\â\Ä;ÿþ<u\×mXü»›±èŽ›ñÔ·\áù?Þ—\îû\Ö>ú \ÞYô8¶¾ð,¾|y9ö½ö2¬z\'×­B\Ï«1°a\r\ï½	\ç\'\ï\ÂÿùfD¾üñ\Ý\Ûÿö3~Pÿ‡Ž\"l\êF>lG!\éFÀKj\ë!\ÉKIM²®NòƒG&A\áp5!`Ž³B!€pØ‰\\Ž\Å\"\ì—PÃƒ›y\Ü`¦ƒùBHm~†›@– §\È\Z®\Ä\Z<Ù¸6›\×Z¥+\'À¯µ1Œ\É‚\'\0lo7Œ\ßC€ñ”F\Ì-ß\ä‘,¾.\áE!­\0?O²Ÿl<\rD²\0¦±•(\Ò\é0\Ì\'š‚UXfn-jX \ÙU\'½\ÍjiF\ÕFò-al\\•ƒ\Ç&š8}f.Å¥\Ë\çq\áL\rMf	qù\Õ\\y\Ò…\ÍE<\Ôñ\Ô\×c\á\í\×cñ\ïn\Ä\Â\ÛnÀ7Ýˆ\ÇoºO\Þrž¾ófÌ¿\éz\\{\åøÍ¬xô\æ±\êÁ?\ãý\'\Æ\ÞW–¡û½u\Ðmy\Ö\ÏÿÇ— xh\'b=û\ìýa\ÍqDt\'\àÓ@\ØÖbÌ‰RÒ«\nôU¦#\äô™0õ¡{\'*NÀ\åó\Â\é³\Ë\Î#\0Ž¹rg¿\rýb	Ö³\Û\ÇÍ§\È\åy„†„,\ä£(Wb(±Ž/¹¶x°x\Ã\r¡\ÛO&UŽÙˆ<–oS¼\ä>d“\ÊýË¦µ\Ã@–¯£«÷ˆ\Ë\çû°†À•Hx‰\\y…þ¥A\äD<\Ò6.\å	ò­K†„f#o\Ð¯\×+‘`XB\Ý5c6K\Ø,e7yô“\æ\æSR\Ä\Äd“ƒL¨,`\êì„”ƒ/~wv\Ú\0F\ZI	Gq1X\ÅU$Ú´5A\à\ËÜ…—\î¿/=ð{,½ûv¼ð\çÛ°\ä·b\é7c\Ù\ïnÂ’\ßÝŠ\'ný-\î»þ:<xÃµx\æ÷·`\É\Ýw\à\çG÷W[\à\î=Ç©ý0\Ü	g\×7ˆ™º\à<\nÓ©0u„±÷¬šS9»­ÿI ü%\".\ÄC\Ä\"DÄŠ‹D=\è\Z\ÔÁh\Ö#\à·Á\íµ\n\ÃGÀr°\ÙnD$j>f\êG\ÖÏ‰pØPÈŽPÀ	§Ë‚ Ù¾ ÁA‘8<\\.3\Ü.gk>ü^µ|dõœ:x]zø<xŸW·‡t¯‡^XC2€6›V™D»ed\r€\Æö¥×­ƒ\ÏÃ¥À¥Ë¥Ö\ïÁŒ¢O£‡Þ G(h°H0\Ì\ß-¬fÄ‹hÌ‹xÂT:ŒT&Œt&Š\\žø†³¢\Ô¸h\0¾S\à<CÀp\n\Ãuz\0–€\ã-×ŸLÀú\ÉH3ƒŽ•ÿ«Ü•ÿ¯>ð¼>ÿOxýþ?bå½¿Ç«¹/ý\á6¼þ§;±ö/wâ»\ï\Ä÷Ý·ú=6-º{7­„»ÿ\ì=‡a8ü\ì\Ý2v\Ã\Þ\ÚS¡\ë>\nm\ï1hûN \à¶ r!#\âB<ª®“P\áJ\'H®x‘\äõ”=ƒ8\Ì\nœ’\Ãnˆ\ä±SIq¯q´j\æ\×\É$k\ìO¸`uÚ±ÿØx†‰l†\î>‚‹4Yý\êþœ€4uôÿ´\àC	—:ò[2/‚CJ½R\êÈ§÷ †@”\Ä\ëqþ†4¯{”²À\Ä%ag:ø‘Ï“	 \ÇZF-›‹\ïF.OòGUÿxY\"_R$yEJt1dó1\ä‹)\äi\ä‹¤sI\Ä3,wÇ¥\\k”qöü.^hb‚ ¡0\05\0¹™´È±ŽuÝƒµÞƒ\Õÿ«úV\Ïÿ3V\ÝÿG¬z\àXý\à\ÝX÷\è|¼ù\×ùØ¸`\Þÿ\ë#\ØüøCø\è±ùø\ä‰{ñ\éS\à\Ä\ë`;õ-4ûw\Â\Ùs~ClC\Ç\á2÷Ág„\×\ÜŸC‹D\Ô#\n\Ý\ã¿h\ÔH×’š·G\éRrLbòÑŠp\Ä#Âh< B\Ò\Ä\íœ^\è\\\"þj.”ˆ¢h6\"\è\ÕZ¡3:0\Ú$Á¤7ß“T¬r±ÙŒŠpª6ÿ?\r «Y\É\ã*\"ˆ˜€Æg%0\êB0DnÞ£€AªwXT¢¸\ä¾öûµ\Ë\Ì\í\ë\Ä$\ÕJZ£]¸\0½(=SÙÚ¤¦h•4l˜\î´ qt¬&\Ð\èx\Ãc\ra\ÉŒŒq\àÂ¹&NS—T)_™u€„2„V\nHÖµc\Ý\ã÷a\Ýc÷bÍ‚»±öá»±fþŸ±\æ?a\í\Ã÷\â\Ãe/\à“—\ã\Ó\Ëð\Å+¯\à\ÛU«ph\Õ*x\åU|û\â2x\éY\ì{ñIœü`-ú¿\Þ\ng\Ï!ø\é´p™z\á\á\æ\Ût›\ä\è\Ï$½²ù©…\åõÁI\Æ/¥\×Jžj?úu6Ä“^\Äœ\Z$‘\âÁxƒ\Ü}D6ƒ«þ,<Dù!A\Ô—[v÷‹|Š)d³J¤qdr\nñ³ž/|‹÷\êWm¼p÷9U¿\'²—\ÍOó~„›pH…\Zr K\ä[ôZ|>½\0G¦¶\Ê(ýŸ\Ð\ÉYzž€ú\r‚¥8´V©~¦3ª&\"õ\Ñ\0*\Z[ F&0‹r™r°‚\ÒW\Ñ® 9R\Ã‰ ©1\\¸t—¸ŒKFqzŒ 6š\Æ.‡8¦%l\å\êxó\Éûñ\æ÷`Ý£÷\âùwcÍƒô\0À\ÆE\Åg+_Ã–\ËñÙ²%Ø±ô\ìZº{–-Á7+–\ãðK/\á\è\ë+\Ðõ·Wp|ý\è\Üú\\}\á5ôÀ¡=¥‡!¯Ñ M\n&yn<yn„˜À¥É‰³VÎ£Gc‘h\Z½U\\¸\Ñ\î„\É\á„\'\à‚\ÑlE0\â…\Ëë’´0\Í<@0\èG8LyU\'z,8x\\/’ªX\Ô¯\Ï·[e\ÅrH\\w(\èD½\Êò0óm\å\Új\\F\åÿ12L\ëZ\Þ ›÷!w‹$+óI	™@\\Šõò„#\Ìx[…¦ˆ\ä;$£((5°d0™R\Ù(ôV¤\Ò4€˜\Ð\àtÿµ:i_%ŠiRPÏ¢\\É¡RÍ£Z/J)¸Ñ¤Î²Š\ÆH\r\á\Æ\ÆY˜À\å¾\Ãw\Ç%Œ6S’QªŽ\ÇH:9~\Ý\èx{Ñƒxk\Ñ}x\ã‘{°î¡»±ú¾?b\å\ÝwI\Õo\ë\Ë/bË²¥øl\é\ìx\á|¹d	ö._Š\ËW\à\ÈË¯\àøªW0ð\Þjô¿÷*º?xöžð\è»`Õž‚U\×»±K?<N-3¢!2) PtI&0\"#è’£Š%`Ò±§Cô{¤cÀ\ßô`\Ãßb\ë—]Øµ·;÷u\áÀ‰^8Ò‹½°ñ“c\Øs ‡\r\â³\Ý=XûÎ·0X\Ì\Ò°\êÝƒØµ·{2`\0\0 \0IDATD$\æò,kûÑ°b$#’A\Â‚~«\0B–x½^›0€\ëødóLr\Ý\ÍÒ¯‹e^#\ì\Åò¹d\ZMf2Ž|Ž	6+A ™C¥P4±Yôm¶\Ðb·\âd¯V±ƒd	N,N%’J^ž\Î0M#“\Ëbü/•³b\0,ü\Õ\Ñm`üô8¦\ÎM\áò?.\ãò¥	LŽ0H© \Å E\01PU%²ð‹\Ä\Æ\Å÷\ã÷H\Ý\Õ}À\ê{þ€¿=:[–.Å§Ë–aû’%\Ø%›¿û_\\£/¿‚“+_G\ï†\Õ|-ÿ¾\Zýo€õ\Ô7ðºa\Ñv\Â0\Ô	£®&}\ì–!¸D\Ó6ùGlR¿\ç\nYW\ê„\×G\Ô\ë\ÞhÄ€F\×‹¢O\rú4ðzHóµ6¸&„\ä½\ì°ZM8\Þ=€ÞX\ì:9\0OÀ\"\n\\Ò«ñ„Cz=\\n<‹\0³hˆ´¬U2r\åQ\êø…‘¤Ê‡\ßÉ\0\éXÒ²>+¼\Ô®\Ø\à.M-·MD¢v‡	^Ÿ]2\"ùhT…¹Œ‘\âf6\ãR8!\åƒ\Ý\íÄ\É*!B¼«Œ\È&|’\ê\ÆE(Ë°\Ýb<A/FA\íÿ\\©l¹rÍ‘:.\\º€Ë—&1E@.€^Œ)9X1&´°d\Ä\0\ï.z\ï-~¨üy\è¼ñ\à\ÝX{ÿŸ±þ\áðÁ\â§ñùò\Øõ\âK\Øûò\Ë8ø\Ú\ë8¾j5N½±\Z}o¯\Å\Ð{k¡ûpŒn€f\ë[°œ\Ü§\î†xmCðºtJQ„›\ÌÚ¹…LÅ¬’[1ÿ&\n§6€î¿£^M\Âl³\Ã\î¶²¦›—Ÿ ‹(>\çG½\ÆpK\ãVcI¸B7Nž@°L«BŠµZ P$\á£µ…b¥2ùƒ ]\È’IT\"OF\äT‰8aŸy¾GžGr¨\r\0\å2\î•0\ÃðC\Ï\Åô5q·À«Ge\0Å `\0† iA©pAŸzü~\Ø\\‘Q\Èl¥\Ò\ê¨7(}\ãe\Í\á’ôU4\Z\Ô~\\£u\Ô\Z\n0TjeTUœ?7ŒsT·€ P	B#8\Ü*\Âu¼·h6-~Ÿõó\ï‘õÆƒ÷b\ÃC÷b\ã#ãƒ…‹±c\Ùr|û\Ú\ë8²f\r:×¯Eÿ»\ë¡Ý¼–­oÃ¹\ã}X·n„\æ³w`\ïú.C7\ì\Æx\í\ZU!c¾\ë2JA#ó Ÿò#—¦\à’†@DPF@Fc`Zo4\Ã\í³‰ûcj\Ç#\'‘òL±C­µˆÚ¢\rþÑ©4 ¾F‰0\È2\åJ¥r4)`¦xüp\Ø-KFu\0Š8U¼\çw\"k\æJX€À7–G°»us1…S›M\ãSÈ”°]þ%np\Ê\ç(6Q}W\ZD¹†\Ý\ã†\Ýa—\Z\0¿#\r€:–±+µ„h#)«\Õò¨\Õó¨T¨‰D-‚À‘Vpöüi)_úþ.]\ÃY\é\rPz¦”\Ë	\í-Yˆªt°Î¿i\á1\0n:\r`\ÃC÷c\ã#óññSO\âã§žÀ‡O<ŠÏŸ]ˆo_Z‚£k_B×†\×aü\è]x÷lƒ\ÏG0mûúw½g\ß!øŒ=ðXòšò™\å\Ò/•0²	\n,ü\nø±¨CõOs\È²ˆÓ¯\ÕÁ\î°\"\ZWn“›%uzt²ŠZ­\æC²Ú™\ïcN oŸÎ°\ËÆ‡Y8z‡,¯„m”#° \êªÀ£Ä›d\î¦\Ó5IÓ‚­\ë\ê2¥‹<@\0qº\ê–\Ð\áS5Äe½@cP\Ò7‚J¯|8I…pF}›\Ç·\ß#ªhÊ»Jlü![\ÜR¨\Ö2¢–\Î\æ¨r\"lÁZA€ ¡µzÃ£\rLœÇ¹§q\éû¸tyg&2i$ð&\âiSk‡7þ¯Q‚ÀM\Åû‹ÿŠM‹Å»O<ŒMO.À»?‚=Ž/–¾€ý«_\ÅÁ•¯`ßŠgp\èõ¥\è}{5t›ÿû\ç\ÂûõVX¿|\Ý\Û6``\ï6¸´\Ç\á³Àm€Ï¥‡\ßmKz\0¿ÏŽxØ…©R’@­j\Z=lšÈˆõ‡\Å-÷|±ê’£4•\à\ã\êhl\ç\çr\ÔsQ]CÑ†€%Ÿ|rY¯¼g8\êAF\Ä%ô\0^)\ÚH:\Æ\ÂMÊ‹\0\Ë\ÎŸl¦ ûV\ã†P¥\Ì÷y´K\'ºŽ‘$[gƒ\ßgE(lG H¨Uþ\\\Ö¨E¤† \Î\ëµ\næ ®÷‹Db.a;©\Ð[`0[E\ß‰ª††)\n@\Å\0\êy”\Ê9”+¼T›\Ï, 9B.@\Õ\0š\ÃLG%8sv—¸„K—OK\Z8\Ü`\ÞOj™òpò,Q!Ÿ\Zô$:\Þ_ü(>xv!>zn>~n1¶<÷4¶=ÿ>{\î\ìxþY\ì}iŽ¬^‰“\ë×¢ï¿Áð\Ñû0my¦\Ï6A¿ó=|õz¾ú\0CGv\Âg\î…\ß1³¾c/¬\æ>X\Í©’U\"J<nÒª¬»SD©j\å>¯Mþ(—Ç‚\Ã\Çûa1Àé¤–>¨\×\âÀ‰>\ï„\É\Ì×š\àtEq+ª[R»\îö}\ê:™n—ª¹“þ%\r\Ì\Ï!õJ\È/·‡Pn ¢Œ}~+<nv™…\Ú%’w:r?kûTýò70“\àm~wf¼$8\åû·¿›\Í\Îú>i_³€YOûwŠFÀ*\ï\Í×œ\ì\×AG\Z8Da¨þ¡°[˜O\Öÿý^’[ `\Ö€i&CL©¬\Ò\Ð;Jy4G\Z¾ÿ\Ç%\\þ\á,N2\rL¢YS„uƒ\ä\èe¤\Z¸q\Ñ¼ÿÌ“ø\àY\êÿa\ËOcû\Ò°sùR|¾\ì|±ôy|ý\âR\ì\í%Xý\n­\Ç\Þ]…SŸ½\í0Ýþo>…¾{‚öA\\:9\ê#A«\è\ä¢Ló˜{22&&©©ã‘¨¨Xwd\ËZµz\Ööû†ô\nx%¼\"–Ø¾·v‡v§\å¢b\å¤·EÛ¶\Ù6\Õ\Í\Ër.K½~T*~D\ã^T*a„£~ø.\×\âò<ò	d©\ág\å‘n›%^iß’^aÁ$z\è)ZÒ®v\ØMK\Ëd\r¥\Ð\ä/Ÿ+\Ïi­R[ŽVŽ\Ê\ë\Ê\Õ†L6¡’\Ù\"\ät,Ç%@fl…M2\Ô¤Q­)/@. R+¡P\Ì\"Mô_\È\È\íR¥ˆ\"\é\à\á\n\Î^\Ç\Ôx£8†\ë\Ê\0\Úi •X\\b\0÷\ßò+,¸ó&<z\×-xò®[ñ\ä\ïoÁã¿¿\ßu\æ\ßv~ýu¸\ëú_\á[‹OV/Ç¶7V\à«÷\ÖH_ \á\ÄN\îÁ\à¡0\rBÐ­A—± ± M\åülFl	&	´\èÊ‰Š™ 4QÐ½+Wdš€V¯G:º„½ƒ8\Ô9$®\Ñ`V’dÄ¥\ÔÅ™\0*ªŒƒ‰¸ªŒ\×-„\Ï\r\ïÓ™1 ³\n×¾\ç€vóm¢†\ëq¸ýnœ<Ù‡\ÑzTð3\0\á\ì[FC“¬€Ò°V˜\ßM….Ÿz,\î”Ç‰h,\Ä\Ó\í\â\Ô&´„ \n\ìr)Ö¯g\È \0T‘RŠþ-”•°\ÞÌ TI£TJJ¸\Ñ(Èª³!d¸†z“L 3a)Ÿ»8…ó—\Î`ò\ì\Î] \Èb¸A³FšuVb[—­\ë\×Ï¸\×\Ïù%®›ù_¸æŠŸ\ËL€yWü\'®¹\â\ß1óÿüÿöo\è\è\èÀµs\ç`×¦\rør\Óz\ì\ßú.úí‚±û[\è»öað\è°jŽ!\ä\Ò#À*šS‹(\ã\"€T”ùµ\ê•\çŸ\Ç2kV<\Úd¢}6’R¹C·g4™\ÏúP\ÈzÑ¯\Ñ\ãÀ‘>\ï¢W`:\Å?Ü‡û\êòA\Ô\nATXBf§\ržP\Í~D#.¤“A<Á0CöÐƒ\'µ\è´ˆö·\ÓI¿¸\ÈO¿<…ž^­°€,‘²Dœÿ_%`~&”`\ÉT\Z\È\\ž›\ÎÍ§\×j\r\Å&ƒ|,Óº.Ø¥e•bH¸ÿ~E\Z4hR¨*ô\Ïù\Ô\0”\ÊI\Ôj‘µ\×\Ø\Ô(¢\\Í‰¼\Ñ$\0¬ Z¯ 1R—L\àü…)|ÿ\ÃE|ÿ\Ïó83ž\ÃX\Ë¤NDBvQbIÏ„\ì‰7Í™‰\ßÎ»¿½úJ\Ü0ûJüz\æ/qÃ¬«p\ã¬+põ•¿À¿ÿû¿‹\Üq\Óo°w\ë&\ìþø-\ÚùúŽï†©ÿL\Ý0t\â+Ø]¹:	þô³C\ÖG²ÆŠpÐŠpÈ®sÌ…|‚k…¤¥w>\ÉTK©d]n7lv»ô±„}{¤³›?\ï\Ã\ÑSFSúýnQñˆn·\"Q\Ñ\Ã\\»]‹÷½8\Öc\Î\ä\Ä\î\Z\ì;¬ƒ\Ã\å†\Ý\å†\ß\ïE<ÀH3ŽoõK·-)b‚E¢•*)\×M =\ÌÀ•›Î®ff\ÌJn„û§AÐˆ\Ø@\ÐVeHU+ñ)f\ÒÀ4z–v{5Vi‘.\'©ÿ«º?\ç\0TkY©ü±\Ðh\ä1<\Â^€Š%\ê\È\Ô\ÅH3þO\Ò\0\ÎH9øò?\Î\ã\ìD^šCFj˜ð€	£\Æ4³D56½M\Z7Í‰\ßÌ\ßÌ›f_…\ëg^‰\ëg]‰fýó®ø9~öŸ?\Ãü\Ç\Ïð§\ßÝ†\Ã;?\Ä7Ÿ¾‡\Ã_}Œ\Îo`:\nsÿ!ž\Ü\r§¹Òœv\rtC\'¡×ž‚A\Û“¡S/,\æ©•³fN\Ï\é0ÁngZSA¿\r}ý\Zhu\ZŒ\Z\ìùö†0¨\Õ`Ï¡^|¶»{¾\éÂŽ/N`\Ï7§°u\çal\Ùqv\á\ëƒ}øh\ÇqX,Zi\Û\"?zjz“½Z=9„ƒ\Ç±\ë›>|ú\Õ)|º»Ÿ}\Ý­~½½}ð\n«C0D@G\àg”6o®vi]i÷’\ç’\Z6;\È\Ûv™FR¼ü]:[¢P‚?§\Ë;A¥›ÀQA¿ß…c]T.›E0J\ìÁ\Z\r+\Â*h,€H,ˆHT±,¥R\áV%§§¨ >\\GslcS\ã\"ù\á\ß\á‡]˜¨S\0Ê* Dœ½¬¼\ÒÛˆ\Ü8Gm¾¬9W‰ \Ìý\å\áŠ+®À/y¼÷O8¹g+\ìü;N\î\ßc\ß\Øõ\'%ökO}-B\"^3\ÜN\rö!ø<F„øúLð¸\rðûl\"ø ¼‹‹.š.(wQÂ¼4rC«\Ó\ÃaW-U_\ï\ïú\×\æ0#±ª\"\rµ|k’ð‰»¤\"G…m.ï‘¾\"vz>\Çæ´‹J8À\ê\\\Ü—ËŽ£:tõj‰{¥•\Ì\å±\"\Ãv³0Û¯\ìˆ\Æj\Åø½\\­¾@Nú`o ]ÝŽª<Zˆ (e\Ö-l %b\Ö4H/«\çñ9\n3!tHªIq«†¬Wðw“_`ˆ£\è5—‹Šèƒ‹5\0\ÎL \r<MûrN@*‚D*Šd2†T&‰D.‰l)‡\nGñL\ã\â\å38\×n©\\²\ì®\Ú\Û\Ù&Nm \èh\0¿m\×o\æ\Î\Ä\r³g\à†9¿Äœ+ÿ3g\ÎÄ•W^…¿>|ºö†_|€\î#_\Â:x\Ã)˜ŽB\×s\0\Ç\Â,–8µð¹õˆ¬ˆX`Q\éK¨\Ñ\Ö6­Kk‰2¹Ê¥\0,B~5Å‚bP\\¾\Ê\Åù§)@¥H—B\Þ\'$ÿ\Üx\Ì=+ˆ…\ÃX\\ X¢T		Mk0Ù¡5\ØQ.\Ð(„T›ÁXFq\n$j\È’õ#Ÿ@Ž‚üC@»\ÕKð@«\\,¥e–‰þ):m\É\Åh|ªô\ëG¡\Õd¢$`j&\0	-\æ\æ,{›­V\ÔÊªA…\åm\æ\ç\ìn´\ä_•Z\Õj##¯S9\Ç\ì°)dd´Ž\ÆpU4\ÔLL`\ìô†\'†q\æü8\ÎOeHD³\Æe\áô\ê\ègg\Û\í\Ü\È\rÿÉºq\à˜}\Åa\Î\ì9¸\êªx\ê‰\è9¼‡¾ü}\Ç÷À:tBÀ<xÆ£:µ\Óô\ZX÷[ú}œ aR3B\ØG\ß\Ê\n(R\äL ˜÷\Ã`¤\ç\à§d\\,±‘3™TG5 ®Y\çƒ\ÐŒ0\Z-0[\Í\ÈfX‚U¢M\Æb!ò>)!Œä’¬\Ã¥S¦\Ä×·VŠ\r§r\Ä*\Ã\ã‘K7muûðq\Õö¥ú\0ù\ÙR:NSh—˜OöA\Ò]~\Ïðk§¨2‚\Ú\Ç\\P6#òÁd±¡Z¦V1 \È\\†_‰\04ƒz#ƒr•\Ã42JÂ™\n2 ‚—J\n\Ö\î>}fg.Œ\ã\Òw\çð^\Æ?þû’ÀH#Žf=†|Æ‹h\Ä*\Í-R“\ß\êA\Ço¹é³®Â¯g^!!@<Á\ìøõ\Ì_`Î•¿À¼yWc\ÆÌ™Xò\ìBôÙƒC_nAÿ\Éo`Õž€\Ó\Ô\Ë\Ðq˜‡N \ä4ô85ùM\Ø%c„\ßÏŽ‹l&=\0\r ý\Ó5\Ò]3_}\ÚAõ¨\ãc™–óm\èŽ\Ù\ÑÂ¼<\É\Ù6Q\Ür€C¥‚\ÎhGO¯^À™¼/ŸC£’fLU\à‘XeªEÁu¢\Ô\rÊ‘I¤gj»g–dIÀð{ñ3\Ä\0¤ Dö\Ò-¢N¡’…nö ™ñpoÁ\Î#*Œ(W…‘2R¦yme€B_\È‹\r¡J–\Æ\Ç\Ù\Ë\Èy\0LûjÓ‹ó²nf¥-Œý##A/0yz“gG1u~.^À?þyg§\nB7\ëQI)¾‘¡TeK\ZG\ÇÍ­@\×ÿ\Ûy3ñ†ñ\0W`î•¿˜9k^Yþú}C_mÁP\×~\Ø\r§\à¶ôÂ¢9³\æ‚n£x\0›u\0Fc?Œ\Æ>\Íd\î`³Á\î\Ð\ÂCÐ¥‡Ó¡z\çÉŽ‘ù#+¦6NvõÁ\á2Àl„\Å2›]»C#\í\×.—n\'\ÙD²hz¤cUy˜3yx›mXr¡°E†ø<’-N»[-^Á Kx$8\åõ\Äd\é¥<+\Ü¾u¬Û›\ä»\Òs	\Èö.\é\\;\\nR½\nw(¹	 Š.\ïU\é—ŒdBµcÑ‹1d•ò>\Ø].Xlf\ä\Ò\äF<rIoÑ¦¥\"\ØÌ Á	jl\ni‰UpE6_\r†Á™ó8ÿ\Ýi…~wùþùÏ‹8{¦8m\0JT\ä\á\Ò$\Ó¬‘F\Çm\×\ÌÀ-ófËºy^\Ë\Ä®\Â\Ü+¯ÀÜ¹ó0{öl¬yuúŽ}…\Ã{¶B\ÓsPÀe\é†Uw&\íIø]z\Ýz¡5\ÚS\Ðjº \Õö@§\ë•K½¾6û ¶!\Ø-ƒB;©¦•–-SX´8r¼F“Cš^hu\Ð\éa0\rˆQË¥P¸nR¿NRÁ]h`µi`³\ëawr\ê©dm‹rfž¨\Ü*\èœ\Ï÷³¯\ÏO\ï¤\Ð:‘:Q½Rû\Z\Éó=,6\ìv\nTr?A©¢t­B_“6¦™\Æ\Ã\ÏhS¾\ÌH	\Û\åû\ÕgÐ°˜x-ˆF2aH«MƒP\Ö\ÄIª¢Y\á|\0‚a†\"%Œ%]\ÌtR	QB§³	”Y\Zf6P‘\ÚÀ…‹gñ\Ï^Æ¹3\Õ 4Ž*CLk>´\ÍW“\è¸õš™¸õê™¸y\Þ\'@L `ð*Ì¹\ê\nÌ™;s\æ\ÎÅ›k_F×¡\Ïqd\ï§\Ðõ’ø/@{ý	‘;³÷Y€\Û\Ëa	-Œ\ß\"G/ÿ\0‰\Ò8\áAŽn\\A\å6KYŸˆ/T¨C„n§sQú\ÝbS­LŒ­B\Ðp)=!%WŒiñ¸¯•s+\Ã\0kòªg  \\¹L!T\ì£\Ì&˜£\È¶§ñ\ÎdU	c:µÿB\á\Ù\ÛO/›TIô¨÷P´/G¹±\Ô\Z”E\nšS\Â(K¥9\ÔÁc›qXnxiÏ³[™-lù0ªU\ÎCb%P\é29¶\Ã\æQ¯‘ $L\ÉÂªõ\Ê\\\Õ\"ª-™Xµ^\Æø\ä\Î\Ó\0š	4«Šþmü„®×•*¨\ãö\ëf\â¶kgà¦¹W\à\æ94„Ù¸±\ÅÌ™y%fÏ›‡9ó\æb\Ó\Ûk\ÐsdŽ\í\Û}ÿa8]p™ŽÀb8¿\Ç\0¿S—cHR?]$‚ˆ\Ü6e\Z¤>À9uÉ¨©¸[‹#LhT\Ôôi5rT:\\”X™E^Å£T2›\Zd¾M‘Ë”N–\\c<28%DM\á\ä-\Ì\Ú\Z	m\ì!\r\Ä	­:\Âô\0(\Õú\Í÷TSH¸q\ê9ü¬h„D[=?§\Ê\Ã\Ì.X\Éü©\â—l%©a\nCH9ûù˜öÆ©ô¡\\<€z5*J oP…\Z+\Å%d+¬\ßd`\Z¹\"µŠl6J‘!‘JB855*¨ÿ\Ü%\ê\Î\á»\ï/\àû]þ\Ñ\0jqÁ=2ÐŠJ(\é¡P²³ŽÛ®™ƒÛ®™‰[®¾\n7Í»B<ñ\0\r`ö\Ì+\ÅÌ½\æjl\Ýü&úŽ\íÂ‰ý; <›©.s7LC‡a5ž„ß£‡\Û>—mai&\Ë8o€Û«‡\ÏgD4d•5\Ü\ÌlÌ,ian~Üƒb\Ê«\Í³M/#Z\èv\í\ÎÖ±¶²\Î\ëi\×Z8$v*©v{XS;\Õ\äb³©*\âx„Š\æ-=)Ÿ7sˆZj]¢úV\ï¿böÜˆÅ•):\×7]0•þ€$sy>¯U<¢†ô¶l¨‹„‚Š†Â¬%\Ðm‰xQ,E0 3@q)K\ÓÁ\0qŠ\Ùg\ÄZ+‰|t°b)m6KhS@#P£b\'%`k¸bø\ï\ïq\îl£˜PÁ\Ò\rEþ!\Å\ßGƒ§—Š ã¶«\çJ¸õ\êb\0¤…3o~K˜u%fÏ‡y\×\\ƒ\Ï?\Ù(@H?t6s·`\0\Z€\ÅpRº_\\Œñ\Ø`µõ\Ã\áÔ¨vkA\0+„2NM&k8\"i#Àƒ™‚I5ƒ\Ç\Õ:ú]\ìž	\Ûª\ÔQz\Ü\ã?N\â¯ mZJK\ä\ÎM\à%ÿ\Üv\nÖ–c\Ó\ÍS\Å‰‘ò¥\ZXµ£µ{D–ò\É\\\"v$·D\äñ\á²\Ì.R~\é\ÜI0Œñ–\á,Bý¸jøy\É4y%yg“Sƒ:³‹¤Ø¨ž\Ë!‘\Å2\Ç\æ¥Q(±ÀbPJD\Ð#Pcw+j:\Ø§„Žbò\Ì\Î]Tmaô\04€ó\çjk\ÆÑ¨r˜VT\ÉÁ„fj˜’ñ}b\0·_7·_;·]=7\Ë\æ3+¸\n³g\ÍÀ\ì¹sqÍµ\×b÷ö\Í\è9º¶C?xvK\ì–.4ô\0]\ÒF\å´B§91½ôÚ“0\ê»`2vÁ¨\ïI\ß‹±V\Ó\0,\æ~X-¤‡Z—ƒ8~ütš^\è\r}\Ðhz \ÕöB§\í…\É\È\ç	•lµô‹a\ÙmZµ\Öll\Ç\Z’V,¹m\×Ád‚\Å2ØºO\Í \å\Ì\0V\ïWµ}I¹ô\è\àr\ëEýK-€\Ùbhi\Ô\ã¢f\í\ßó£€t°ƒ OTÄ–\0\äc\Ì\Z\Ô%5¢,öY§³¯ôþ\Û\ÑÙ¯‘\ç1E¦€”‚Szz	z†\ZL\"\É\Ú‹Gj*(‡Bqš\Z…\"I\"ˆ$\ÐÙ‹\"	»ü\ÃEüóÿù\'.œo`lXƒd$`kŠš\ê;H¶\à\Úy¸ýšy¸ýZzƒ¹¸\é\êY¸‘0{&fÏ#“\Â÷\íüH0@÷\á/` ``\æ†\Ñ\0ºE`·õ\ÃeB\ØmD\Èm@\Ðe@PÐ¶Y\ØANÍˆlHlˆ-H„¬Hrt\ç\ìE\ÐP	Ly5¥\Ö-ô\Ì?‘\Êa¡V…^µ#\Z³‹;¦+\æ%‰\"[˜Ã«!\ÍJ\á\Ã\â\ëø|LbrJ#õX–q¼¥\ã#N\àóDÃŸ\äg{d­\ÒüKP†?y‘e\î\Ï\Ï\æ‡Ø–\Æð ”°R\0K\à\í¨¢‰‰A\'\Ó\ÒRN \á%üHD)¤]\Ì\Ï\"`$\ìo·€\ÓR\ÙC@‰xŠ½ù¤´‰\åKY\Ë9a§ÎŸ\ÆùóM1\0¦¢7(s\àTkHV»=\\m>½À<\Üþ«\Ù\nÌ£ü³g\ÏÀ¬9sp\Ãon\ÄÁ¯?E÷\á\Ï\Ñ\Í2°\æ¨x\0‹±z\r\ÃA(€\éþ\Ý\r\ÂnB.\Â.ƒ… 6M—¿	É \í\Ç²KHG\\H†]\Ð\éR=t:up¶\Ò=c\â”SqE\àŸ¯\\?ªÁK\Ä\Ä2NŽa \Ý\ÐA×œeLwH±%!n[	G‹T·›—\ê\âûH\'q¡ý>\äúôkTi·}½-LQB•v˜z>\Õ\Æ,“ˆª•9\Î\ÖÑ‚J©E·>‡\ÛÀ\Z6¬(a@l	+a|¬†ññ:\Æ\'8&^M	§ 8s~R\Ê\Â\ç.Ã…#\nRR‰\n%B[v1Qa	¡\ã\Î_]-û¯f\ãI	g\âúÙ¿Ä¬\Ù31kö,\Ü|\ë\Í8ö\ÍvtÚÞ£_Â iy\0S\'tC‡z\ì\Z8,}‚¤ƒ:1z\ç\çM{\0+\â~+’«\0#i\Ù>+†!D\Ã\Ôî«¬!´L+‹¤¡Dj\Ø4–‚•1´9z5‹BL7RjÛŠ!UivKžMm>K\ÑY\áñðk·€ó:|\â‡\ìôl\0\Õ\Þ\Ý\Æÿ\ãò§º–ðƒŸC#ú\ß!\ÚS\ÉXG}\Ð[\Í\"i§µò~d2õ\\(\ázüÉ¨x\ZDª€F099¢FÄ¶@\àwßŸÇ¿þ\ß\áÒ…K\Ñ\r¹·,Ä©\æ\Ú\0:\Ô\æs\Í\Åm\×Ì“póÕ³qý\ì«dógÎž;\ï¼\r\ÇlÇ©ƒŸ£ÿ\ä\×0hÁn\î†\Ùp\ÚÁCB	û\í\Z\Ø\Í}ð84\"¡. HO@Î˜\Ù2\0Q	­ˆs¬\Z\Å\"œ®uJ½Àd\Ò!µ#¢\Ä6\re³IÕ¶o\Ë\\>V…«W\é Á`œ¡€CR\î\é\"L»µK¥h\Ìñ)\Ze=ž¨\\Mô\à\ÚÇ£#ñ¨>~92\ÛGy\ëúO†>«¹­\Æ\Ò\Öh¹ög)ð©ŒH\Í&P4,¥i\Þ\0«•V”*\"\á$\Îf|nŸü‚t°Bÿ9\Ñ\Ð\0x¢vI`J\0õ€\ç/žÁ\å\ï/\àŸÿ÷¸tqc\Ã©†_«A1\ÏG6\ç_\è¸ó\×sÀE ¨2µ˜	œ1\ë*üñw\áÔ¡²h\0F\íQñ\0&ý	hÀn\ê\×1(XÀ0x¦¡“0h:¡Ó©e0tÁ ;³±6K\ìV‚8\rœv\r\\N–Ž77÷\0\0 \0IDATu04\è\ïïƒ—”¯C\ß\nCp¹4ð¸)\ÕI¾Ç£ƒ×£‡ŸuN\ïl­`€ŒkùJ\èI@\ÅFNNõR5O€\nG\ãƒa\Î\'R\Ó@X\ì!e+ù{XQ½B\á¶&j1óˆ\Ç\ì\ë¥,Ýšù\ÇL„\ÞG2‘–zXúî¦ŸÇ¬¤¦˜¶²)´„\Õ\é‚\Ë\ëþ€DV»¾@’ˆg‘ a€\ç;\Èc¤™Ÿ7<\Â\É 5uôŸn\'\à\Ü$\Î_œ\àò^º4Š±fB\ÊÁ2ˆ PZ\Î#\ÒpÊ’pÇ¿ž‹ßµ\r\à\Zz¹‚	nœ;s\æ\Ì\ÆU3¯\Â\Ýwÿ=G¿D\ç¡\Ï\Ñ\ßI8«\éŒºc\ê? À\å\è‡Ù z­ú.\èõ\Ð\ê;¡7œ‚N\ß	ƒþL†\î–R¸vó l\æ~\Ø\Ì}p\Û1\Ôßƒ®ž“‚\ÐM\æ~˜\Ì}0šºe™-}0[zý[¬ý°\Øú\äº\Õ6\0‡K§[+3z-V=,\"x=,VE;\ìFØ¬Š\"¦ ƒi\Ü`€† T\Ã\ì\rø\Ùzf\Óm\n—´,\rJ¦‰ùIû*\ê—\Æ \èƒ\èß£¿ôý¹ù\ÙLi™\Æ\Z\ád†Dºº5;˜X¨«G­AQ\Õ\ÌLÚ‘A\å$3\nZÈ€’Ë h4#.¡öŠ`ö4p|f3=,¢1REƒƒ\"ZM\"\ßÿ\ë{\\ún\ã\ÃIŒÖ“\á¬\æÖ”0QIwP\Zw\\7w0þ œ‹;®‹\ë\ç\Ì\Ä,\ZÀŒ«ðÀ÷ ÷\ØW8q`»€Asf#S¼c\Ð\à\ä\Æ»\à¶\r\nd%pj\àriU\Ú\æ\ÅM8`UŒ`\Ð&‹8 s\Ân·ÀhÑŠö\Þ\'sy-p¸¨¬1¶úöÔŒ>\Ê\Ä$$DT8`‡«f*}!,3\Ç\çœ]\æ\ì\Ì\ÈúIm¿À<œŠ]¯:@‘\ãi•K\',\ÝÁY\0Ù¥Ã–ê¶‹—Q±\0C-\î@)š\Ûn^È¢öDQ9o’ª‰cjO[\Å\Ìó\0\Ò±‡A^ÛšrF\ÊZGˆ4p+ÿ¯g¥$\\­r\Ü-O­SD£Q’DpF0UÂ¬T\Ø5<R—Uk\âü\ÅQ¢É&\r\ÌV<j/…÷ ¥]Jªp›lü<\Ù|ñ\0W\Ï\Å\rsgb\Ö\Ü9¸r\æ,Xð\0úO\ìÁñýŸ¡¿s/\Ú#0NH04p\06S\æ>˜õ§\àd^o\ê\É\Ô§m@RC“¥6;:C°]\ÌkõP\ÄcB\ÔgA*dƒÞ Ã®N—F*6»f\ë \Ð\È,-‡f!’Ú 0A!ññ@¼\ÙÛŸ\å°Hu\é\ärªE‹·ù›>©(\ÊÈ¸6Àk©€eº7\âGÍ\Üÿd\ßn\ï’2~ªú{ð’B—@\ÍÃ„A \Þd“tp\ZHŠ\Ä\\\ÕX Xƒ\Ä5<aõ\0¢	\à¤õÑŠd*QS\Â[³\Î_¾€‹lù\ï\ï¥;h|8-±žG>±izVL\é\Å\È9t\Ü~\Ý,\Üzõ‰û\ÓÀ0o6f\ÎU\à‰\Ç\Â@\çW8þ\í§\ê\Ú\'O÷¯8(\Ëf\îf\Ðb\è‚\Ë2\0»¸ø>8IÚ°^`\î\Ã> A€¡›\Â&ˆQ¯Ñ€Y´Z}¿\Ä}»]«†\r|~BÁ\r€™ANgL%\ÛÃ™\Ó,1\ïf\àû	Ç¯ºŒÃœ\èAAŽ3\Ú#a\Ûƒƒh¿–q\Ð\Ú\ãb\ÛiŸ’{³Iqü\\‰ó-1ˆ¢«[ø¶:¨5iŒŸ£1Z…I¤ú™†$Þ„ ’ó[\'†`IX@`\æ\'cbyž VþGdD\ìe\áNKúwñû‹ø\áÿû¾ÿ\á&G\Ó©ñ\ÜA-÷/³‡Õ¹xÂŽŽÛ®›\Õ\"€\æLÀ\×\ÍÃ\×\ÌÁ¬y³E\r´x\á#\Ó0pj¯¤~\ÝQe\0ƒ?\Z€Q\×	 †n\r\nl?‡m\0HP§o@/ñ›\Ð7Ð!m¯”u.-,VjŒj\Ó9«Ÿi!I¡Uúû\åLa›\Ô~š\r°Y“U¸6;=þ…GlVµ¢©?<ø?\æI? Lñn_Wñ\Óñ.\êt1aµ¡pL%i,\ÓF¦júj\"H\ë;´Þ›¢”J‰C(‚\Ðl2+húq†9CHL\äñœp\Î\É`\Â´N\Óh\0\ÇÄŒ•Zi ³€±\é,@\àe\0—8ƒq\Î¨%TG§\ÊI1˜\r$\ÐqÛµ\Ê\0¸ñm#¸\ãWópÃ¼¹\Â^9cž\æ	v~…c\ß~Šþ®}\Ð\r‚A{Cb\0‡`5uÁj\î\Â\Ð\àôô@w÷~tw\íGW÷AôöR«\ï0zC;@Ã¡÷8\n\Ý\àq†NÂ¤\ï\Ä\á£Gp\â\Ô\ržB_\'úúN¢¯¯\Z\rW7N?\"´²^KCS´2\Û\Î,†Ah‡ºa2õ\Ãf£øD£I³…µ	\Üµ\\j8á‹º‚.ªx[\n_\Å(\n|8võöcH§…W*™œ\áO·©\Î! Z\Ì8\Ý\Ë!L\Ýý\Z){·Àj¥—\"k\ã\à‰–\à„³\ÜNviDp\âe\É<HwL\ÐÇ¬u¨	¤œ ’\ÍP\Ì\Ñøœ~š”i¡”†Œ–…kieNðù3\Ó!@<À?\Îbr$ƒ±JZ€\ZH\ÑüdM\Ç]\×+\×OpÛµ4€y¸\ãº9¸a\Þ\Ñ\\5s&–½°ƒ\'•ž\Ü\ãÀ!˜‡Ž@Ó·\Úþƒ°˜ˆðOÂ¢ë„ƒ@\×)›j2‚…Œ¡¥O\ÓD¯}H–\ß>$\\IB^=úúû0¨\é¬`±\Âj%—?¿_/§_\ë\í\éE˜\'l`\èð\Ó\Ø\Ð\ßÛ‡_v\âÀÁSŠJ\r«)#\Ô\èIkwk\ä«Ð¹ÿk¥S?ž„\î›\Ôr\ÏÀ pöÓ¿1g««\Ö.\'˜P=‡¬X°mWzú\Õüa\Ù|“Š\æ™AÔ¥œdñ¤T*Yaµ[\Ð\Õ; ª%*Œ¨F\n¶K\ÙAŽÑ¥¶-\ÎH$oÁ3…‘\Zæˆ\â<ÁU:Ú¢S\Ò\Z–\Éñ|Ki\ä\ËT‡«>3—\'ŽrÜ¼\è\Ô9~:ƒ¨\ãw4€i2h6ˆ	n¿f~5w¦”‚©\n~õ\Åg1pòKû\æSòôp‡¤\n¨\í\Ù]\Ë\0Œú°hN\Â\Éù\0úS2#€À\Ðn\éƒ\Í\Ò+aÀj\íS‚\ç‚œ\ä\Ô[õ\Ñ\×\×¾\ç *!óô+N\Î\nÔ¢§¯ñ¨M\éfhüV\ì\Þ\Û	«Ù‚:C-\Ä\0ˆ´;s¦Ë½\Ó\í^?i\Ï+\n–®\Ùh4\n]\\«P ò#«\Ø:?\ÂQ7BQ·t\ï\î;¡Ç“Cª[©%\"‘X\ÞV-·pE;q	\ÉS	ÁòÀ\ár\Êu·\â¤ÓŸž$B ’1Ÿƒ!8ª‚‘JÀª\á‰9\ë\ÓK\è`V§F1Å“F]<ƒ\Ó\ç\Ï`ò\ây|÷ýYŒK‡0gF¥f\"ZKVeI™\Çü-E\Ð5³p+‚¿š\rÞ¦L\ìWófböÿ\Ï\×{\Ùy]W‚¢$’\ÅLÊ–\äq[m»\Û=\Ý^c×ŒW{º{\ÚAmË’,\ËbID®ü^\Õ\Ë9\çœß«œ\n@¡\n@T\nU(„B,\äFQ²Wÿ{\Ö>÷U‘²Iÿp\×÷P\ä\Â=ß½\ç\ì³÷>/¾$|À7^ù1Šq«œ\0\Ìº\Ëat•\Ãh\Ëú$\0zº)‰¢«5\Þ\Îú:\Ó\ì\Écˆu>O„\îœ\n€^\Öüi¶\nd?\Ã}(\äs\è\í©`„uýK\Ç2†\ÊH¦³\Òõ;xPñ	ŽŒ«|`\æ(}„ÚL\"eŒ\Ö\ì\Âs†\Ï b\É\r6¡šÌ©\Ò\í€|&Ã‡šþ>¡Pó^\\ ¥œª6\Ã&8¼qv\åö8‚\Ñ\Zpg³d2ø9\ÊûFo@*‚cû\Å\Él`ˆv8#˜_`\éW5­–ÒŒv¶…*_`–++œ\r´€Óœºz\î$ÎžU¢¸ùH\àù‹gqñò9¬_»„«7¯\âÆ½›¸óþÜ¹w\ç\Ï2\0h	sD&´(\r–\å\ïa\æ\0\Ï\áw\ãEYüüo\ãüþwŸ\Ãw_&ôž\ál}\ë\ç($,\ê\n\Èx\ÐY¡ƒ÷Ö‹¶B\0=],	™Æ¥<\ä‰\Ð\Ïvqw}\ÝYôUO€þž¼°†„Œ\É!*\ÙþN‹Y´µ\ç\ä\éfðµ\"_, X¦E|\n¡x\Z.w\Ù|A¸yý½mpû2hmm•¯GB)Á¦\Å\ï_\rl\Ø`o0ˆ6Ê²\r~ÿœ\Ð\ÑU§¯½«_NBk^Û™7HB\ê\0öŒbßD\Ò=\è”¯Q\ÎI¶‹Â™ö0\Ü\Ø\Í2°ZE(Zø¯—’–€4À\âU\Å$t\Ã4‚“Ly\np‚˜T\Õ2ð”dÿ*\0dQ$\ßþ‘±¬.¯_PM ;7póÁÜ¹{]’À\Ó+\0vnýRúýï¾„÷½o\ã÷¾ó2¾OR\è\Ë\Ï\â÷~ó9ü\æK\ÏJ\0¼ð\âØ½}\nq^	€ŽR\Å`õ §3ŽöJ¥|…\\\0¥B\Å|Å¼z¶–ch«\Äeu·ALÉ³§3#k°¯ˆh$„r1\áAöþ\ÝWF*“…\Í…\ÉÁ\Z@“1«\'ŽH<ÎŽ\"z{\Û\áÄ‘/\Ð\ÕQ‘»w³u,¬ e‰F–.Ax²\á\è­Êµý˜Ÿ#SgR\Ù.tv÷\Âo‡\ÉßŽx¦d¹nd‹½°ú+\è\éÀ±)5™,Y\èDW_¯¨vˆ/Ð£˜s¾\Ír\"ˆe*\ïÄ–…ôs–‹cHd;\Ä[p\é„\n\0–\ê\nP\ão\ÕT0\êf°zzA>šCž©n<\ß|µù«›% ¡`RÂ¯Ýº†k·o\à\æý;¸sÿ.œ›“*@¼‡i%¤P%B\åš¯ü\Î\Ë\Ï+m\àKJD}À÷H	AÀ‹/¾ˆÆ½\ÛPˆZó\ZQJ{\ÐY\nJ\0´\æ\Ô\Ð-F&\íC*\áF.\áA!\íGNªò\Ù\0ò\Ù r\Ù\0\Êù°¬Ÿ…J\Å\Ê\Å\nù$¼\Þ\0<^?| ¼þ\\ž |þÜ¾œ\Þ0¼þ0‚\á¼Á0ü¡B‘$\"±\Ñ8B±\"‰b\É<\â©\"™<\â\é¢)®,¢™\â™\"ñ<\"‰\"‰,B±„üœ;ÀS&B™\n\â\":º\Ú\Ð;Ð…N¢\è\ï!\Ìô÷q`„Œ‹\í\ÒHo_W\Õ%Œ.BÁ\Ê˜OGSkHðEUýüý\á^q@c…!„z“6>²™ü‘2-’\ìýO\â\Ø\r!¦\Å#`ñ¥\ã³U¯ \ãbË©a®\\\ÄúÍ«¸ó\è\î>¼%À$ð\ä\â\é¬|Ž ¤\ÐŸù&žyükx\ê\ë\á›O|\ß|ü1<÷Ô“xñyÀ‹x\é\å ­yÀP ½D9\í‘+€ P[9\"]\Â\nE¤\n Y$Ž®®Œ\\}=¼\ã\éT\ÂH_\ÃýE\é!\ì\Íc¨ŸZ‚Ê­E”J9”Ë¤——D$JlŸŽ}dóPS@A©ò\â\Û`\ë2f&>!\Ös$0\Éa6MT¸\0ÁŸ!\ì\Âð\è\Ü\çG\è¾1Œ\Ñý\îCG7\ßö6\ä*\í\è\æl\âö>”+(UX¥´‰È´\ÒÚJ¥\å\Ö”\Ú:Pl\íB¾Ô…\Ö“\î‹»Ž®nù}ºõ£»ýC#’ø\rŽŒ`t?0ƒ2ç˜´1¼«7Cs‰q™˜F§3\Z_*M ­s\ÔS\æ/³ \\A\ÎYd (óH2„—O¯`\é\Ô2N\Ò.\î\æe\\d\0T:qDy*W\Î\ÕñCøÊ†ü{s=ö¾þõ¯Kö\Ï\0øö·_†A»Y2‚\0\Ä$\0ü¨¤\Ý\0…*\Öøª\Î\ïlK¢½G¹FkkLšD<\ê;;RduÐ¥òƒÁ\î‚ ‡4•\Z\ás€\ÞBeiÅ\á2Œ´\â\Ð~²Š\è6F\àH¹ys\ÔY\Ç\ì\ã\r%\ÑB²\Ø%TÇ¿Zd\ãù\ã[\ÆÁ\ÏL\Ü\Èî™šR¬\"Š9\é÷3vHù\Ñ8‚òtAYB\Êo5	ŒW\n\r\'™E\Ó?pü¬û\\YI\ß\0þ¤§³%)T\æ\ê;E©\ã‡F\Ôñ/F¼÷«ð\ïŠ2‡Rdyœ!\àÃ¹\0¼Î“þµ$C\"8#@ÿ\çdX$\ÇÆŠ*\è\æ:®\ßX\Ç\íwp\ï\á-™¨Fzö¨\Ä\Ú®R— UÀ¯mþ\çÖ·ž%!ôE|\ç;ß…Y·™°I•\0~´\å<(§]*\0Ú¢(Bh\ÏG\ÐYŒ¡‹PŽ¡\\£µBÝ€º\ë;Û“Ÿ\0Ÿ\Ý1z”±ƒ	\"Q\Ãî®´ªdvO‡²p\'gODE2\åb­MžÁ0&Š÷\'\Ý=a+§ý\ä\Ü\Ñ\Û÷\ÐFG‡0F\ÙÄ“l\á*\")?“Žuð¢pm$rs\0\Ùo˜˜\è“\Î\àþ*X(\Ø`\ÙHØ˜®G\ÅkX©|‰$\ÜL]`•\Â\É$³ddœ\ä2´:\"Že i[UZ8ŸÓ«\'ªÍŸEœ^e0\0bN°\"P°A.Ÿ4UÀõŠx÷ýû¸ÿ\èŽLY;Gy@N¯ÿ›WÀÀc_‘\0»\ßû­ÿ\rvc-RAƒBS.´\å}h\Ë{ \Ä\æ\ßöŽb\å8º\ÚX0é‹¡£5†¾Î”4Š\Ú\Û\Â\à\æô0\ØS¬€=\ÒÉ˜²\ÔÞ‘AWWû†\Û>çµ¯|÷GGÚ„ À\à ýœ-\Õ!’?y÷vo\"n\\|\Ã\ÕÛ®6œtp^Ò›ŸQ*bB\Ã\Ì\Ê)õ\"_o²\"vT§{\Ðbž€Q\Õ˜<=º\ÑÙ‹\\½\ã\'\'«&¡\ÝM‰\àj@;pL\n7Ë°ª\àDu\åŽ O1†þ,\0V«¶0ª :˜ð’œ\0\Çf@ \àõ¸q“f\Ñ7q\ç\á=\Ü{x[€C´eN2s\0™\Ì\Æ< \Úþ\â\0x\Ï<û¬B~ûw¾—µQ\ØÀ\0i\'Zs´f=(%\ê:h 	 q ¶#³#²\"\Z±#q!s!“ô\"›ò\"›ö!ò\"\àw\"—ñÉŸ3i?2™\0’©\0\É\0R©J\Å:\ÛRRA”\Ëq”K¼R\â(£òµ\Ör\\V›0	³$Ì¢½½€\î\î‚h‰\Èp‡‘nI\Øú\ÉP}w&e8ÎÃ†8ø<>\Ñ&	¤^PØº’¸‘¿O´Ž~‡\nÒ¥l‹º@Z¾\ËHZ5˜‚ª[²…%WúB¥I\äR>BBb^žš\È\0\ç8¡X@\Òü\áTPN—i¡€Eœ¦\"˜A % ª#HM§G…¡·\ï\ÞÂƒG÷ñ\èý{\Ê(Š\'O–\Íj8©b\Çð¾\í_t<ûœ\n€\ßý½ßƒ\ßÞ„¤O\'Í rÊ‰¶œ\åŒÅ¤­Å€\Ð\ÂJ¹ d÷û%ž!\ä3A\ìª5£½E6\ÙL2I\n©dZù,yi”J1”\ÊITJ	T\È(\ê\É#W\ÈAcð!ŒJO€meÁ6E}%R‡@è¸»€®.ŠI[\å\íŸ0…h\0Ýl®\éBÃ£\Ý1§\Z\ávP¨\Ø$ô	¥›\Öq}\Ì\Ì9ÒÃ¡\ÙJ7N¹(tQ\Öv¤‚÷ôògyjŠ®9FºÔŠL‘­o\ÂÁ½›Ã£\ÙkeÂº¡i¦q}$û§0\ä\à53™mZ\æ—;N\Ã#„‚\á\èÑªO0!¦iqÇ˜.60%a§NójP®\áô\nºt~^\ÊÀ•%\ÚÄ¨\Ù\n¢‡¨zª\0x\ì\àù\ç$\0þýü;„\ÝZ$\0\Þ±ƒa\0T2n“”~\é2\0¸ù†örDZ\Æ6§5\Z‹€Cz‹:‹¡`>Ÿ¹\\~\0½YT\ÊQI\Zû»3\è\î\Îƒ¨­µ\0»+„á¾’òjú¥gÃƒ­\Õ\ë¡C\Ø\ÈCƒ­\ÂR.=8È·\î\È \æg÷¡»§•ŽNq!1„wüd•šu¬:D\îz¶‘\'H+WhßœM(B¨\Zò¤jö\rÿÿ#\âøA	ºúG¥Ä»gh½ƒ}r%ˆQlj• D\È\Õn$[\ÈÊ¥”\ÚDÂ¿#\áfdŸ$²\ÌYÁ<xˆ\"ˆ@]\ÂU\'ð\Ü\Úi\Ñž¿´†KW.\âòú%\\¾z	¯_ÁÍ»7p\éÂ¢B)\ãÿÁ®ª‚š\Òû‘/¹¾úž{\á9<÷\Âøƒÿðˆzšeó~2‚›	`>¡ \\ô£\r ”\ç\Ñ@WkÉ¸³·m•0\ZtNxB!¸=¼\n¢H&¢H$B\"*\él\'„œfQk%Žöör™‚Á\0\ÆG\Úp`¸\rCE\ì,c€q_\Ãd\r1\Ôüö¨f\ÈN\Ý\Ô\Ñ9\Ös¹Ve\ártH Û¡‘~)\éõwTÊ”¡A§`€~Å»šN\"JƒH+Øª%œø+u2¶\"C\è€\ÌH\å;6\ï~š]p‘öM?D\"€´h‘ñ1‹ŽöI\0\êw’®¿\rM Ÿr¬ª\ãŸA È \ìœ\Ø<þ…Àv°\0A\êþ\'!ô\Þñ\à\Ãû¸tqAr\0\è\ÚBQ%…Rô…ð\Øc\á¹I}ÿ\éÿ£ýQV(a¥jPJý³\0\Èø	¬ƒ¨‚Ð´X°£\Î½É†B6Šww\ë‘N‡PSo€\Ý\éE4@wG]\n>&ÅŒ}„J9.|§Û\\>Á¾¬vF‡\Ê\è\ê\Ì#O\Èñ\Ïd‘J¤}\ì@2\Ð&Ql\ï²S8¶\0‰L	\ã\ã}›$M5†]yc¸Pµ“a\â\Æ#¸³“÷ý 2\Ú\'\Úý\Å9Ò»«tnª‚a|œšC\âúòõ•*¾\ß\ÝÓ‡\å\ãcO\ZúU\ï\à4›8{`°W\ÜI\Æ\ÆT™\Èù\Ç\ì_RÁ?\0$‚ðþ\çtpBÀg\Ø8»$‹„P\Î¤œM \0¸z}7n]— ¸ûð>~x—.-`p2LŒ(iD­À /M\0¬\0\èò\ÇôGHˆ¸4B	+%\í¨¤](¦œ\È\'\ìª\Z\Èû$ÁË¤ü’\ìŒ8\\I\îqRq/\"a/Z\Ëø¼Iö:;c\è\êˆ\nÁ´§#†¾Žú»\ØHÊ ·#«Ó‹‘Á\n\Ìö þ\ê\':”\Êi\è\ÌAhu^\á‘…\ÜW\æPgg	\Ýô³\ì–ia\ÞP\n…rYTD‘hF[\Zý\Ã0:s09³2}\Ì\é+``¨±X	fw\r-q´¶vc{}oìŒ \ÙZD¹«o\í\"žiG4UBo?+e/\î¢ó\ã8³2_´\í]}2“(”l\ÃÂ‰#\Ø\Þ\\@“¹ŒÞ}x·6ž¾ø\Ý0{Zat\Ã\âo“d?eÿ¹E,€UÀ*•À,ÿ\Ø\rTA\Õ	dHƒ\è\Ï(\á\ë×®\à\ÆM•\Þ}t>¸Ë—–°vê˜¼ñ„™9‹ð\ä¦>ð\Ë\àk_Å‹/½(ð\'ò\"± \â\ÒJ ”\0Irq«Jó^$\"v½V}V˜­:„ü6\Äv„V„‚6DC6üÄ£.D\Ãø}fø½ø\Ý6ø\\ø=vx\Ýv8\íV8˜¬Vx½4µ\Øñ\Æ6\Ìvš4&\Ô4X°c¯A®·\Ç¯\×7_ „@(/Š@8Ž=n\Ôi\Ühhñ\ã\ïß´\à½Zôö(¶\îõBcˆ`G]\0õS#\ê´!¼·Ç‹&CvWpõš\Þ\Ù\íƒÝ›•	%;\ê¨\Ñú\Ðh!“-I²\\iG©\Ò&ƒ-8Œ\"œjE¡XÁ\ØÁaø£y{÷Æžzûaõ\Ñh\Î\Ê¤\×ö¦\áŽu\Ãl‡\Ù]B(Öñqvm:„q±SGÈ‰$„²¤ ôøf\0œ[£ dƒ\rt^ô\0\×o^S%\à½Û¸÷þ}¼ÿ\Ñ#\\¹|Rp\0\0\Ä\0”-\r\"þ\Õ\0x\á\Åñ\ì³\Ï\áOÿ”`F\ØÙ¤€\'@Ê‰RÂŽ\\Ì†¶¼Å¬¹´¹”[‚¡ó\Ã\å²\Ã\ëqÀ\é°Á\åR\Ë\é´Á\ësÁð\È\n…<HF}HD}H\'|È¥CÈ¥#(\æ\ã¨“(—R\è û§;‡®Ž,ú\n\â9\Ø^QŸû{U5Àœ€Ÿ)\"\íè¤ˆ”ü\0Nö\èBww‡´Œ‡\Åg@¹d²\î\Ä\Ë(”[e<=mj˜‰®‚rû\é\ÒÁD‰Ž\àd\ëT-\ßøwÐŠ†¬\åc$y¨\nbT0}:‰tb°\Ç\nÊ•2º:\ÚQik89›¯Hp*\ÌUX0!¹¸ †¼:H\ç	C$Qž\ìŒ\áðQ\nF\Ç%û§UŸ3\Ç8BfRH!JHfð–W\É>k7¯\ã\Úú\n\Öx\Ê,\Ónþ° ”4¾ A\'\'“|a\0|õ\ë_“. ±€ÿòg*ª\àP5\0ò1\ÊI\'\n1+²Q+Z7À‹|ÚbÎ‹bÖ‹BÖ‹bž›ª¾V*ø¥\æo%rHNa+’K\Ã\èîˆ¡³CW+)b1t·\'¤:\ì\Íaˆ}‚Þ‚\È\Î\Ø%$x4L=@u1`uÀ„dRú1d.@”ŽX“G”IfQ$\"|{5¸špð4%el#O)\×21®8\Ê62[¼½®NE*}}E\å&ª·AöPm_ºŒ\n*¸\ÈÙ€\êð„Dµ‘\Zm+Þ\Óûå¨—ñ°4„&fO@œB)gæ¿ˆ\Óg\Ø>Q\É\ãµ\Ê`¨¸\0œx\åú:\Ö\ï\\\Ç\r¶‚™|ðW¯¬\à&\'\0’\ìrrË±IŽ»\Ý€2°úü\ê×¾†\ç_|\ßzöüÿög(\Æl9‘\n\Z‘‹X\Å+(³ µ\ÈýŸ\ËxM¹Ë¸P`\0p\Ãó\ê™I\ÚQ\Èz$2I|Ÿ‰#“E’J\Ë\Õ6.\äÔ“ðqG{RÈ¤\\\Ô\Zôv’_¯¾õ\Ä\n\ì/bh „Vƒ*8x°µj\ë\Î\ê SÑŸ7\è\ä\ãŸ\ÓòM> \Ì\'De,o¾²£š‡›-T²ª!Å±\ÏL68bs·9Y¤ª¨’AþùÏ‰zˆSÇ«ƒ\'¹¤:\àd¥£\Õ\ã^M§§ƒü»\é²qô\0‰;™@\Â¼„\Ë7¯\â\Ú]¶‚o\ã\îð\è£÷±~y\ç8=”‰%\ç/•„\\€µÕ¹\Ï\á\0Ÿ\Ãx¨\0xõÿU\Þö ƒ`…@N€˜U\Þ\ì\\Ò¬´€\Ý(\å¸\Ù\\u”\n>”+o£\0\0 \0IDATŠ~\äi, ­J\'/È¥ƒ\Èg\É£\ã3„J9&m\âR1&\àÀŽ¶\ÚÛ³h§o@k­\íYt\Ðs ³€ñ  \ÄUFOZ½}\Äº„(B7š‚\Ò\É!q&™±$\Â„H\ÂRoŽkf\æ\É\îù±„KùmQig_•ˆmjÄ¼A\çi0WE¿1±|c\æ0;s\Ä89\\•³\nX:&n ›°ú\ë°F\"\èF\\<#‹U\0kÿ\Ë7\×U\0<¸{<À¿ø\0\×\ÖO\á<\Ù\Å\Ë3j¡\ÈÃ©šR|€-\0(\nù\ëÿù\ß\Å\Äok@*d”cŸÀk9\0 “t\"v\"r\"¶#µ#±\"´!À\Ä\Ð\ï€\ß\ï€\Ëe\×mƒ\×c‡\Çk\Ûm…\Ë\í„\ß\ï\Ï\çA8\âC$\êC<Œ •Š¨•ŒÀ\íÀ\å\çI‘D6t°X\Ì —\'‹8‹B)‡\\1‹\\1‡B©,	Z±Ò|±\rE¶q\Û:\Ñ\ÚÞ…ö\În´wu£³›ýü>™\×30Ô‡}\Âü9xpŸ4y\Æc|Œ\í\äA1€œ¤½\Û\Ù?\Ê\0RX@\è(?B\á²ùC\Z?³\ä©f!\È\ØZqHW.&´‰\á<€“K³\0Ë›PLúª\0\à¹€j>0³ÿ\Ï\ÓÁD²qÜ¼Š«d?¼‡>Ä‡\0\Ì(.aM\n\Ì$p•C£\nþú·\04ˆ~aƒü£¿B>jA\ÐÑ„t\Ø,@™\Û\Ã<*E?\âq;L&-ô:L&\\v|<¬flœ=\ÜN#|^ü~µ~+~ü^õŒ0¢.¤¤“^¤^!–8\\vØn\ä2\ä²!˜mNA\Zsù(òù\n¹°K\Ú*I•Ë•\ÊeµJ¥,J¥<Z+Šc\Ð\ÚVA©•B”\n\Ú:\Ú$`ò…\"ò…<\Ò\Ù\Ò\Ù<Rù’\Ù\nR\Ù’\é\"\âÉ¼G\Òd(\ç‹(–Kh\íhE7¹\nƒÝ›}„N\ê\è,BÛ¸\ånN\Ý\áXUK\ÈqyUƒ&ª”9MHÎŒcffB\æ\Ï\ÍÅ¼,e\n-ý~1†>ŽS$~\ÐV‹6±gq\á\Ê\\¼vYÁME\r¿÷\è>®_=ó§fdJE!d/.©¢Ž_\0O|]œÁžy\îyü\Ã\ßÿ¹¨!—™0\ï}«\\	›¨ƒ>\ìV*9?*œ©¸•¢ÅŒ­y\ÊY/ò	\'\n„%Oð ˜c\å\àE.\åG6©V!D{1ŠŽR]\å(º*qôu%ŠF\Ñ×•F<…\Ù€\Ã\íG[{½T\"õ\æ\Ð\ÓE¶OB¸…´¬\æ¼\"\âð\Ã4«\î\ÛZ‚Dta{··¿\Ýý]‚\Z2`kW¹\íÃ¡ƒ\êZ –~blPŒ+\è\ï\'\â¨6˜s\ÈF\Zæ˜™ôôu¢£«C#EGÚºPn\ã©Ó‹¶\Î^™ˆ\Êg[m\ìû\Ñ\Õ7„žÁQô\í\ÃÐ¾Q\ì;€±‰C˜8Bcè£˜œ<\"†\ÐGŽª595‰\é\é)L\ÍLÊ´™Y\Ò\Â\ç±xò8N\ÒBž£\ä/­\á;ƒwn\áúÕ³8¿B} !\æ#\âžF°‹ˆ\ç\Øø\è?«6\àq¼ø\í—ð\Ìó\Ï\áõWÿV\ÞöS£\ÞúˆUOƒLŒ\àG\Ðg‡\ÝnF[É‹P\Ø»ÃŠ,7;\éF:b—¦W†W1„Œ¥4—Å¬Åœ¥l¹´\Å\\…(ºJ±j¥CO \ÉTÃƒY´\Ü0YýR.²\"¡2¹»€X4‰J+eheUI [\Å\Ü|’E&\Æz15A&o?*Ýˆ¥\ÛQ\é\ìÆ±\éŒ\ì†\ÓW\ÂÔ‘Q\Ä\Ó(\Ú0?=ŠEŠK\Ç¤¹s\ä;„\êœC\Ñü\É\Ìa\å¸56~@˜Åƒƒ\Z&\ì<‚‘ýû±|¡T?¢\é^Ž »o½ƒ£\èC÷\Ðz¡c\à :\Ç\Ñ1pý\ã\è<Œ®¡	tÁð\Ø,&¦\çpxfSs‹˜ZX\Äô\Âq\Ì?‰…¥ÌŸ\\\ÅÒ™ó8s\é2\Î]¹µ«·pùú-|ø\Ë_\à€W€°Œ•;¨^š\ê\àñ\'ŸÀK\ßþ¶œ\0ooù{y\Ûy\È	±\n0D©x&®N\0¿\×§ÃŒl\Ò—\Ã*PpV€\"»@Æ•¬GšHÙ¸‰˜]:‰\\¥”[N€LÊ‹T\Ô)h\" 5F»4–\"\ÒI\ä	\àõy‘\ÉD\ÐÝ‘Á\Û\ï‘\É\ÆQ*$\ÐÙ‘•vq(\ZC6›\ÆðpI@šK‘P²_H#\Â\â\ZP¤r\íHdyBôŠÀ\ì±}H—º\à‹qô\ë\0Bñ69\Â\Ùôag®¾™l\äŠ\Ø\Ì\ï£Á“ò!:/\Â\Èþ\Â¦ùóA’N\Æ\Ôð\Èi\ZP,Ž\Ã\äiC\×\0©\à\ã21œ\Ç1±ø³´€Y\ÃÚ¹y\Ì-Î¢s\àD³\ËG¡\Çôü\"B…˜ž;V\í(R¨$ÏŠK8ma.]»Œù•³X½Àk\à®Ý¾‡ˆ\Û\×\×pÃ‚6N\n\È$P±f¾8	|ò\É\'ñ\í\ßø6ž~\îy¼÷\ÎÏ‘´7ª z$™\Æ\írx=|6¸œV$’Aú¶n«G,\â‚\É`–Ü€oþö]°\ZMzm\Ø]Ûˆ|Ö­Ûš \Õ\ZPHû`±™RzFk‘]\Å(:\ÊQô·\'¥ƒX\ÈG…P\Ûh‡\Î\è\Æ\Î\Zv\Õ\Ûñ³-D1$siØ½1l\Û\íA:G>Ÿ•\î\Ð`Fif=\Ú+˜@8\Ù&0A\îà¸šŸ\ç\n·a·&››8B¿\Ô\ÈWWl\ëÄ»5~;´¯}ƒT÷0T6p\ì+›=„\ÖNN.Ù¯´œ8BÁ\É\â„X\ÂuŒ\Â\ì\ëD£¹€P¢™\Êr­\è\éDg/\ËC:w. ”E¦u?._&\ä\ËI¡‹8þ$zFbvaV4æ´‡c •À\åó\èZ@\×ð\æ—\Îcbö®ß¹~ù‹\Í\0…07ýs„ò¾4\0^þö\Ër\ì\Ùþ:rR˜\ä\í\çI@P(+\Í l=\Ì&Œfv\ïnÀž\Ú&l\ßÕ€ºF\r\Þ\ØZ‡-\ï\ÖBg\Ô\ã?\Ù¯ÛŒ·ß­Á~²\rn·uu\Z4·\è%ñû\ë¿Û‰šz\r’	¢\'’1/\ÒI¿4•Ba’\É Ò™(^}G‡=¿„\É\ê†\É\á\Ç\î~ú†¯osÁ``¯&\0½%­Ñ®ž’hI\Ú\È\çKð‡óÐš\"h¶gP\Ó‡\ÑYD­>+Á‘+u\Â\ê)\"”n‡ÆœF$Q÷±¡}D\r‡eŒýøöKciv™§ap\×\Ä0\ææ•„«£gù¶\è\\X½\íH\áw£\ÔÑÃ“c\è\Ù7Ž|e†öcf~\íý\ã\è\ê?€ñ#†\æpñ\âitpŽ\Ðqœ¿ð\ë\0G\Ä\\»q	+\ç0¹x÷>¸‹û\Þ\Ç\Å·°|þ~ù¿~…[7\Ï\ã\âi²‚\ZH\"ˆX\ÑV»ÿj\0<û\Â¨Ù½E<‚}\Ö:‚˜2\09öŠ^\r\ìÚ£Nß‚\ÆF\rLF=#ú\Ø\í\Í\Ðh\ëa\Òka26\Ãfm\É\Ü£A«U‡\Ã\0—\Ã§U­V#ƒ\Ãf\ßwº\Ìð¸-ðzl\ØS«ƒ\ÛiE<\âA,\âA*\É\êÃ‹d\ÂÀ…\Æ#\ÞÚ¡\Ã;;t0Z\Ü\ØYk‡\É\Z@½Æf³\áX\nþX\É\\&{þH\nÍ–¬\î$\\Â±<\Üþô¶(B‰<Z\Û\Ëp¸\âHg\èVB”‘\Â\Ótwòe\æObD†\Ñ\ÞÓ‹Xª„b¥‚!5±·¯\í]h\ë\èB…\É`k;r…Vd‹\Ì=:\Ð\Ý×Á‘}\è¢}\ÝAŒOŒaø\àZ{ö¡­gT®\Ññ#È”F°°Àdo\ZóóU\r\à\Â1,œP£cL\Ì\ã\è\Ü.ˆQ\Ôe,=Ù¥5\Üyø\07o_ÀE:Œó8yTüŠ9†\æð‘C2úKà¥—©\nzµ[‘\ä\à¦só\é\Ä\Î \ïybÿ6«É¨¥Œ\åœ[²~„².¡‘“:VH;‘N\Ø$9,	›\È%Ia*nG:\î@>\éF!\åF>\íA)\ëÀˆ@¯‚\Öb«•|\Ýz‘w˜DW\'ý‡’\è\éNcx0‡“O0‚Á¢†t*-	<\Ü\ÓÓŠrk­eq!‘r­³\è\î\éL ­›%CÊ zˆe\Ý@zzz\Ð\Ý\Ó#\ß\ë\è!ý»m\í=\è\î@Ð½‡\Ð/ý„aŒ\î§/0±}ºŒ\Ðo˜RtbùôVÃ¥¹ˆù\ZWƒ \Ç&b\ìðö\Äð¾\è\ZE\ç\Ð~I\n\Ë]û\Ð\Ú\Ã\Ó\æ¨l¾\Úø\Ì/rP\äN,\Çò\ê–O¢g\ä(Ž\Î.c\á\Ô9^<ƒ+7o\â\áGT\0\ÐX‚³\å)Á\"¨<–53ö\Åðo|/½ô’\Ì\n\Ð6lBhÀ® 1\"÷$\0ò\'ôz=\â\Òq+2	ri’\ÜX6Œ\âd¢6¤cv\Ä\ÃdXF\Ælò\Ìòs ´\Ë\ß\Å+%›\â\ß\éRð±”‹\ì5ø`4YQÎ†\Ñ^ˆ¢“e\"ù€mq´“\ÜJ®`þPX<‰H(\í¡\ÇPW9tu\Ós¨\"Œ¡\r\å.=†«ž\Ì\ì÷1¹;P¤A[–Šô%”E’À\'?(ó\è\×3Nm Í¦ª&¨9Æ¾ýû0¼oC#\Ã2£™ÿðQ80†ƒcc80>†C‡\á\è4)]´…]¡\Ë+\'±\Ê	`§—\Å–SÁÎœ]øÙµ\Ó8»vF)_gÎÃ™µ5œ½p\ç¯\\\Â\ê\ÚEL?‡g/\ã\î#r\àƒO?Â­\Ûp\é\ì¼$L<\Å!ŒU€\Ø\Î~Yð§ðÒ‹/\ã;\ßùôšB\Û€É€Ql\ãò\0.	€dÄ‰lÂŽDÈXÈŽlÌBÂ|\Ü.\×F:fC<lC’W%fA&nA›³\Éu’ap‘kÀ \Èx$òitF*ô\ØXB\nó˜$ÑŽö„Rtt\Ò+€úB\Û$ˆ\ÒXŠdºŽ”E±Cl@\r\èV®b2Ê•Oòü9[o\à3Y­hªC£ø5\ZC‹9tÕœrf\Ó¦jCø¸*e¢(\æ\Ñ\Ód\ï\ÇDu\n\Ø8\à£\ì\ê•ºþ\È\ä$ONa\â\è\ÆOaü\È4&Ž\Î\àð\Ô4&&gpdz“\Ç\æp”e\à\ì<f—0wü$O®\à\ä©\ÓX];µK—±~õ*\Öo\Þ\Ä-j\Ý\Ã¿ü·\ï\\Á…³¤”©\0ix•º²üeðMº„¾Œ\ïý\Ö÷`jÞ…¸·YºL%\0‚\0½Bòiô\Ò1RQ,#b!U\â\È\ZJ:¥ZÈ°ŒØ‘Œ:‘‰»‹9K¸$al\Ö\ê‘K9‘Ž“A¬‚€€QÌ£¬’™-´Rh’¥þ€\æQ)\Û**\È&›ˆ–t=´¥g±zy\Ðc¸¯\"°\Ñ,Rj¢niã²¥K@‡§Á\Æd0ñ\Zœ\Æ\í\å©2\"L*™\Ø\ÒV:Uª¹ò ›x\Õk`†Ã£xt³L¤a”\â\Î\ÎN`~þ0iö0)ü?\ZA*ðN­2óW?òþH\0þß¹“X£-\Ü\Ú2Î¯­\à\"I l\Ñh ŠB.\á&-\â\î\ÝR¢Gwñ\á/?Á»\ëX«ž\0\ÔHH:\ÚÄœú’\0ø\ÆSO\á¹^\Äo}\ï·amÙ˜§y³´q\Æ:ŸG¶¶E¿\ÛFŸÏŒ4û\0>#\"~#\âA3A#‚^#¼\î„ýf„½fD|&\Ø-:ü\ä\Õ=\Ð47#2 \ä7\"\ä3!\Z0!\Æ<#bE\"¢\È$šf=2q·Z.\éC>\åG:\íG:@6B.F¾A¥5‰Žö4:Äª.ƒ\Î\Î<:9¾¦»€\ZT÷1Ø§†@!…\â\î!vp¤~lj\n\ØûW^¿\ä\Ò^	H¸¹JLÂ\ç<5^>W‡C\ÎÍcnK9|\Ì/*ú÷ñ\Ô÷\Í\à¤H¿«¼¿\ÓÇ±zfis \ä\é\Ó<þO\áÜ¹\Ó\nò%œ\ÆP\çWqñ\âY\\¾L5Ð…\Íq±7n­\ãÆ½¸õŠ {¸÷\è>üE5\0\Îl\0µ“/žPÿ_\0O=ý-<ûüø7¿ý}8Mµ\Â$¼qpó%\0xg\'h\ÑiÐ¬\×\nñ`\Ði\àw\ár\èð\î{»ñîŽ½°˜4°[5hiª…\ËÚŒ€O‡š†Z¼ñ\æ´47B«\ÕBÓ¤\É\Ð»M·\ËŸÛŒHÀ\n¯Û„ú†FÄƒl0Y	Z‘¸ˆzx“m\ìF(\äF\"\îGJ´¤Sad\Ó¤“A¤’!’r9\nQ\ÙLJ XH¢TL£R\ÎH‡‘‹#n¨<\î\ê(¢[:‹­è­®¾¾6Yý²\ÚeÉ”ñ¡®Í§\èE³¨¨ã¤˜3©<À\\\á\ÐÆ¢š\Î\Ñ/\\GŽ~Fö˜œR”\ï™Ù£˜™#\ì{33“86;…Ù¹\Ñ.VGÊŸ\\>•Ó§d~ð©µ³X=¿†•³gq\ê\Ìi\\ºvw\î^\Ù\0¾õ$\Ä\Ò“h\æ¸@ÁÿJ\0|ÿwþ-¼¶&D\ÜZ„«À%4 ŸPw·Á`@m±ˆS\êÿÿù£\íøùkµpØxg{-þŸ¿Ø·\ÞiÀ_ÿh\'\Þ|{\â«(Œ\ê›4ø‡7v\ão~ú^y«{jµxeK\r~öz\rLF#¢!‡N’a¬V#Ê„Œs¬‚R)$c>ø¼n8\ìND\Â~\nq“T\Ú\×EO‚\"\Ú\Û\n(²BI•BÎ·D9\Ê\ÛgC²¡“If´”•c¿\Ú\Â%AD\Þö\Õ\ã^-a“MD˜Y\Æ\Ó\Ó\ë‡N%s~\Ôô\Ò\ÈW\'\Ò\ìqrZm:Ý¿…\ã?K†Ï”¬9±|™\Æü\â\æ«\Ù?7ž›\Î\æ\Ð\Òò–W¹ùjtì¹‹kX»rWn\\\Ç\Í{wq\ï\á|ø\é\'bu^®\0NŸTtŸc a\0|ë™§ñ\Ìó\Ï\ãû\ßÿ]Í²ù\á*\'@–0)\â\Ì²qŒF=Œz=t-M0\ê›a³¨Ž`*jƒÏ¡G]]š5ZØŒFØ­z\äb\Ä¬°šô\Ð\ë4hl\Ð`\ç\ÎF455¢¦¶;v\Öã½\Z˜\ÌF$#„ý6\Ømf”2~3~\é¸=v\ÔkLø<h-Æ‘\ÏÇ‘NG\ÐZ$\É4%®¤û†\n\Ð\Û\"0Ùƒ¦°D\Ù\Ð\rs¸\Å\Ðgòme/K±HUYL	\"÷{u£e\Þouqø\ÌV!1†P\È A .öx\ç\ÏÍ³GF\ç\0òÍÅ’ôü9	\\\Ýû²\ä\î\ç\Ñÿ\ÒG\î?—R\0ø—ýÿó\Ùæ”°u\á^¿uMœAnÝ¿ƒ\Û\î\áþ£‡øð—Ÿ\âÎ½uœ;3W…‚i<q´\ZŠ}ô%ðžyþYü\î\ïÿ>B\Îf\áF\Ü\Íò\æ3>½@.®\Ê8½®EjzfôE®”…¤M¾\Ï )$Yò?`/ÁŽLØ†4›JQ\Ò‚#<N#\âa\Þûvm&\ÒQ¼nv›\Úü¤ùt\0­ù ô3Ò©\Â!¶\ÙN µHur]]itve¡·\á÷³‰T¿\"€\Ø\ËµU-]«FNòö÷6\äšw|\Õv^\æ	0\Ûß˜R\Ýh\ÉòE+PE\ÉÚ„‡i§¬_Tòw‹l\ïò\Í>*\ë[²\ä¬\Ì+¿LW£`V«f\Ôüo’A\Î+2\È9E¡\ëŠº~ýŠhnÜ»…›\0wñ\àƒ÷\n¾wÿ\ZÎŸ]Pe L%\'-\\¹‘ù	ð\ì\Ó\Âüƒ?ø÷9µ9\Zõ´|\0~\0\ä²Û§knF2h~\0Ë½Lu1I\ä3± 2#\ä\Ï°I+9\Ã\ÏaRaB“\ä\rò3a;\n	\'òq\'*i/\ì6€	ù”a\åi0˜\áõùðö»M\Èe\ãðø¼h£I™\Ä\"\Ñ(Œü¾†ŠB(k`C]\ÔQMY	Ðº•*b5\ÒM\æ\0nœ\0›N\0\å³@PÁÁ9AŸüq	ù\Ów~þˆôúU\0Áü‚\n\0Y¿À\Åi`L¹ùŠ¸\á	\Ä\0`ÿŸL ³¸H\ä\ï\êE\\¹vE47\ï\ÝÂ­wq\çÁ]<üð|ü«_\â.\à\ÜÎ¬’p¢¨6$\èt!ùò+\à™gñÿ÷ÿ€°»[=\"up” jE\"lESC‚.=¢\Â\\þ__AŸ>wün\"^=\"B\Â=\ÂnBn=œ-l6\r<.=ü\\n=nVh›50›G\àŸ“an+\Z5z¼¶¥o¼Ý€f£\r¯¼­E<\ê“\"YEuZ¶\î´@\Ób\Ã@OnÓ¬z°¿Œ!bƒô2\æU@€¨\ê\àAe1\çÐ¸:‘DPps…Í£r\Ïoú\æUAú—l<}„Çª›\Ï\Í\Þ\Èü§\å­\ßxó\Éýc\é\ÇQo\nø!\0D\Ãgu\rð:\Ø`\0‰ŒWAõ\n1\Èe\ÊÁÎ‹? õ\0W\ï\\€³nß¿‡»\âÎƒ«¸pnA„ \ì\0òJ\â(\ZŽ¤™šÿ\â\0xú\é§ñ­§ž\Æþ\áBÔ«ƒ\ßV/|\0yû~$†Dôb!v\ì®\ßekË¦ƒ\Ã\Ò›I[]Í°5\Ð77 ESCs-ÌºzX\ròsùf¸¬MpZµ²\Ü6-<öfx\ì-ˆz\r\Ð77Á¨kDÀmœ\"\ä2Á\ë4\Âj1`\×^võ0[\ÌØ¶³z^\È(³\r^¯\á\ÙTP„+ùL…lDV)C‰ôR\n­ª‹Y	¨*€Žeô)\0i°K\ÇÝ“rÎ¹D\âEÀ\Ñ6¤r\"j\Õ\"F\ÜK\Ô!*‡G÷\Êx6ˆ(=\ß\ÈþUBÈ\Ø\Èþ\à\è\Ô\Ì0\ã?ÆŒŸ„>§…øA\ÄpnaV<„>¯f®œÀ\ÉSK\"\n]9s\n§\×\Î\â\ì…5œ»p\ë7o\à\Îýk¸¸¶€3§\ç\ä …39ºŽS\È?c.\0žy\æ<ý­gð\Çô \î\Õ\Ão­“2P\0 ?Oöî©…Ù¨—Ð¶õ0\ZŒ°™õp\ÚM¸\ÍzLˆ°\Þ÷[&\Ìm\Óf„\Ïi€Ç®—\æq\0‹©E;ŠB3·Àa\Ó\ÃÉ†Õˆ­;÷°„4\ß0s#ó ”ö¡ò!ô	“(\á3ˆR)Œl6Œ\"\áâ¶¤¸’ôtÊ‰M\r•\ÅCý´ªk\Å\ÇÙŠj·c4±¦icU9L@F\ÇÙ¨ÿ•\Ç0\Í(\Ù\ç\ç\×ù}zŠ7ñDu\Ú\ç\Í#\Ä~†24\áö\Ý(õ`²:ˆþ?Š\ÛD6\\J¾Y\æ\ÓB\ã&/Ÿ\Ã\Ü\Â\æ\Ïcñ\Ä\"N,\ÑüVV—±z†¹ÀY…^¼|Aš@\×n_\ÇÍ»\âÑ‡\âƒ_|‚ûnI\0œÝ¸Vªcc\Å~öøÀc_Á\Ó\Ï=ƒo>õ4þ¯?ùc$\éR!,€_˜Oš½\r\ØU£\Å[[\ë`6µÀd\Ôa×žzuDUÒ—‹Ú…F\Î;?²!\Z°\"\ì1!\á\'šhA\"dE$`A\Ðk‚\ßc‚\×mD\ÈkA\ÄkB\ÔoF\Ðk†Ù¤\Å\Öm\rÐµ´ ¦Vƒd\È*L£°×ššf8\\6\á\Ô5Z`¶‚\î Tˆ\ÃbóŠ-mgte\ÑK\Ë:¡¤,\áH»ªo1ÍŸ\èûÏŠ€\Þ\0tU³ÿ”c}}]Á2²ùV\ÑnŒ©\ã÷Õ°)•(§0ª‚Ç±°È‰ Ge\î¨\0&ø³Yœ\ÚHúxüŸTwþ\Z\ß\âœ>§’=\éðø¿Àö¯:þ/^Q \Â×¯+g0q\'\nxÿn?`/\à	€\î\à\â\Ú\"Î¬\ÎI3ˆ	 ]H¤\\^øœ?@uóû\êcR|ã©§ñgÿùÿ–\0\àÀ$0%0°Q¯W‹\àþµ\r\Zl\ÙZ¦n»BºL\î˜á‡¬H…,HElx\ç\ÝZ\Ô\Ô4 ¶¦N¾—$\Ò$9„\ÈO£\ÜûQ\"‰\ì-\Òy,&\ì°u\"9\ÓjZPH\Ø\rØ±m{|‹(’\Â¶\×\èð»E¡L\È8Y¤«3!>\Æ]¢-øÌµT`¸ƒ\Â\Z\êÀ\áqúua‚\n!\Î5\ZS=€@`G\ï­=Q´wvŠrH»?¨\ÊÅ‘\ÔobbQH¤\ã2’ƒY\Çóíž©AœE¬PÓ¿º„ZÁ0û?»ŒS4ƒ\äÝ¿¶Š\ÓRªÏ’l2…¸r]ù_£ D`\àû¸ÿþ#<xŸUÀ§xôÁ}\\\à@\ë9º…I „¨++óÿ’ú\ØW¿Š\çž{\ßø\ÆSøoö§Húõr\Ð„\'\0\"\ê\Ó#\ä7À\ã2\Ãf5\n£\ç?\Þ.\ä—] _ÿ©°ù¸C²û\×\ÞRW†A§…V£A§C}}Ì¦f\Ô\×5ÀbnFK³F:†f¯O¬H­0\èZ`µ\Z ×· ”òÀm3\Ãb2¡œ\r¥\Ìdµ¡Ak@*€\Ç\åyº\Ù\ê‚\É\ìF8†\Å\áE[[J|\ÛZU ö\åeói!\ÇÕ‘h=Õ‰#M\'röúI]\\¤®~Vo^06H)/T\Úeúab‚F\n‰ûONõ˜À\ì,ƒ`R]½>\Ûü…\Í\ìŸY?OYg—°zNMþ\à\æ¯2\\[\Ý‚\n@yž\Ç\åkUA\Í!\ï\Ý\ÆÝ‡¤\äúø—¿\Ä#D\ä`¿aF„(RŽJBz\ì\Ë\ày<ù\ä7ñ\çÿýÿkž\04ˆ’\0\Z$ƒ†\ÌðºH÷jÉ \Åöm{QS_ÿò\ç[°}g=v\í\Ù72`Dm]vî¨‡\ÉÐˆ-[w\ã\Ïÿ\æü\íO·\ãG?Ý¿þ»wð_ÿ\êMl\ß]‡{\ëñÞŽ=Ø¶s74š¼¹e§T„ˆ›µ-0´‚Hò\î¶\Z\ì\ÝÛˆ\×\ß\Ö\à\ÍmÍˆ„<xeK^\ßÚŒwwð\æ{:l\Ýc\Å\Ï\Þ2\âõmFl\ßkÅ›\Û(QHN\ÐÛ“E[¹ˆCü=~\ï?kñ\Ã-.\ìnŒ¢Ùš‚\Ù[D!‹T¡\ržp\áT\ZŒihMQŒ\î\ß“§„zC\\\\¿9T•Œ4 \ÕÛ˜l> V\0\ê\ÍW/%\Þ*“¶%\Ùp\åú¹‚\ÓgUø´Ð½N}®Ìšÿ¬\\/—\ãŸ\0\Ð\åõ‹R^½¹.¾€by\ï6\î<¸/\ëú\í[¸~÷.\î=ºƒK\ç\ã¡\à•i©.Q˜v\0\0 \0IDATP”y	ûÿ¥6PdaÏ½ˆ\'Ÿ|\n?ø\ËÿQ\r€:Aÿ6 `¯½‘€	n»z\Þ\Í{k¡mª…¾¥	[¶n—M|oG¶mßƒ¨ßˆúúZ\ètpÚµ\Âú\Ñ\ë›`37\ÂeoA}]-\ê\ëð\Ú[;P[W‹þ\Ý\Ûx\í\Ímø\áO\ß\Â\Î]»QS_ƒ7\ßÝƒ]{÷ ES·]ƒ–\æ\Ô\×Õ£¾ž«	;v\Õa\×\î:üôg\ÛQ\×Ð„-\ï\Ö\á\'¯\îÅ«\ï\Ô@Û¢C,\ê†\ÕbÆŽ½Z8<6¤¨7Hú`0;±§Ñ5&øBADcQ8<AÄ“)\íax‚	x	K”\Ë%˜m!\ãYx#Yv¢««½ý\Êh` ýý\Ý\"Q’©£\Ý\Ø/º\0š4+\Èø\ÄAL®.}Ž\ã\È\ÔaLÀaRÁ§\'…ò=9}\ÓR\r\Ìõ{vž\Ù?a\àEY‹K‹XX>Ž\ã+\'p‚Ã«‚\Ð3\Öp\æü\Z.]½‚›÷\ï\áþ÷6¯\0–2’n©J[þV0€WÀO>…¿ý\á_\ÊÀ \î\Ó+>@\ØU‹°\ß·Ó„ÚšzXMÄƒÄ‚f‘Œ³ÿñY\às)\nY4\ÈúÝ„T˜\ß3\ËÑž™ò\nX¤¶g9\èq\é°˜µxû=°[›\å”Ù³§	š&-‚œ]³Á\ë4	\Ð`Ð¡òHe9PJù\ÐU!\àuA\Ól?\ã\ÎRDVo[\\Vw[\nNwùRƒ[\Ä\èP	ûGŠ*‹\ïÀ\èpö´\ã\à(WTVtÊ­¼O-\Î«÷\å)t€\É%n\ZP²\é#\Ù?qÿ©‰M¼Ÿª^fü,ñˆûK¹77Yaû¨\ì_=\Õg…ýsD<A—°Âµ\Ê\Ó\â4\Î]¦Cø\\¿}7\ï¼/\Çÿû}ˆÿñWxø\Ñ	€Ó«\ä¨)+(øŸŸ\0_ý\Zž}\î|ý‰o\à\ï~ò$:\É\â~`\0”‡ù\í\Z$\ÃF\éño\ÝV+°-Q=&‰Lür\"µ#¶!0\"\è1Àm\×\Ã\ç2Á\ç6À\ëd™§ƒÙ¨AKK#šµMh\Ñj kÖ¢E\Û]3?7Á k|¡¶®\r\r\Z„\Ü$¡Ø±m[p˜G$cN¡”g\"N¤\Ã.”~\è\r644\é\ÑA;Ú´ò/$‡ ‡Žc\Ùjˆ§\Â(•£\âbJúXo—n\0D,e\05úp˜¥!:/\0Nó\Z©RÀŽV‡0R\á377B[¿8zòžÝ¼óW°,Y¿:ú\ÕRWÁ\n¯ƒjÀìŸ‹\×À™s«8Kø÷Ÿ@”‚‰+\Ø\Õ\ËX¿}\rWo_\Ç\Õ[7¤d€e\àƒ÷\á\ÃO?\ÅÃ\â\ÂÚ¢”++<”¡$ƒ\Ës_\0r<ñM¼ò÷ƒÀ\Â\0\Ðo¢€1Ÿ.›	nA z¼õn½ÀÁ\rM\ÐjHý&\Ô‡I«@!«K3ŒF­´Žuº&\èd\ãùY#Q\ë«n‡^‡Q–lcc3¶n«Á\Öµð\Ù\r\Ð6kñ\Ú\Û{¡Ñ´ v\nž\àw\Z:\ÎD]¨d¼h\Ð\ê\ár\ÚPI$\0*™0\Úòôµ%`¶x`±{\Ä\Ü:›\n¡«#…x<‚p˜ý‚\Âf…ÀÊ€o½PSO06€ù™ad+]\ÐØ²˜8:\0ƒ»ˆ\ÞZ\Ã)¼€ðp\ï\à~üxk\ÑL‡ŒW@J»¿\ÄpA&|‰­+\'­žÀò\êq	‚•³\'¥\nX=Çœ@\å\\À\\€M ó\×piý¢h®Ü¸Šu6‚\î\Þ\ÚDÿXðùþ/>\Ù<Î²\\Qú@\Ò\ÂO®|\Ñ ºÀ\Ç%	ü\Ú×ž\Ä\ë¯ü\ÉÀgU€‚‚‰\Ä\é\Ð\Ü\Ü³É€&oo#!ÄŒ°\Ï—M·.y›À¶©Cr\ë|Ÿ	‘€a?~«\\Ñ\áE0^|òûaþ¬ßŒ\æ†&*L$MZ\r\Þ~¯‹Á€‡V«	6»V»	‰¨[JŠI?J©\0Z³aTòaì¨±\àõwMðýˆÆ‚\âItp¸(vtO\0\Ãœn\Îˆ%Q\Z\rôÓ\\\Ù\Ð\Òh¢­³»[bh\ïiF¯ÍŸ\Ç\Ì$¥\á¤¤P¹kŽH«Lù ßŸ³}F\'Ž¡÷À¬­-aIÐ»E)ùdÈ’\Ö\î	¬ž;‰3kUXJ?e	\Ï$ðü\Õ<w\å<Î‹\Øe\\æŒ »7qó\Þ\\»Eƒ\Èû¸÷þC<úøC|ò¿þ	\ïÿ\â}\\ºp\çN\Ósð˜RNMqÔ½\âü\Ë\0øú\ãxú\égñõ¯\ï¼ñS$ý\ê\Ø\0>™ˆYT\Ö-÷±®\Å\0§Y‡¹vS¼B^\"‚Yg<\Îfø\Üzù\ì²+¨\×+Ÿ5p;š\áq´\ì\"lo–Ÿq\Ù\rkP³g/‚nb~¬&\r\ê\Z4Ø¾Gƒ÷v6¡¶¶[¶6I°»¾;k´¨m\ÐKŸ \Ïü \î“Î¡\Ó\éÄ»»Mx{‡M-Nl\Ùn„V\ï‚\Õ\îÁŽZ;/úI \Íad¸Œd*…®\Î2u£­³V_?|+\0O°$Rq½£„L¹\åž~¸#p†\Û1|\à ü‰ôŒJbw\ìø<f/!ÕºŽp7¦g	\Þj•=|.\Õõ;\Í7Ÿ\Ï5A+X»\Èð™ª\èš\Ôþ,ÿ.V±ÿ\ÕÍ¿týªôÿ\×o^\Ç\Õ7ú½r\ë\Öo\Ýn\à\Õ;wñ\à\Ã¸|q	gO\ÓutV€\î j$\ÍØ—\0“Àm\ïüƒ\ä\0\Þ\ê	À\ãc‘\çG±§Õ¨…\ÉÀúÝŒ°Ç€°G¯Scc“	)|Ÿ\Ëin”\å°6Áai‚\Ý\Ü›±^=Mõò\Ùai„\Ó\Ò$?g75`\çŽ\í°™\Z`77`\ï\î0´\Ô\Â\ã\à\ïh¤\Ô\Ô5\×\Ãll‚•ýgj\ê \Õ6\Â\ãn\ÛM\Ì\Â£\Ñ$\Ä«\Õ,ü\Â7\ß\Ó\à-¨o2!ð \às! —SrôpÈ|¦–Qøa8üI¼¹;\0£#W x\Ï½#‹=-q4š\ãH\Û`ñ`\àŒµb‡6k ô\0ºF0z\à\0†F©¢À“\r™	:Œ£\ìLÁ³þ™I\Éü§\ç¦qlq\ZSs\Ç0yŒøÿ<\æ^À\â\Òq_>ŽÅ“\'°¸¼„\ã+\Ë8¾¼Œ\åÓ§°|\áz\Çò¹+¸q\ï\î¼ÿ!\Þÿ\ä}\\¾xR€\Ã\'T0U5¥ú‚+\àñÇŸÀSO=#°ó\ÝW\è\à!P\Ýx\é\Þd»8F\ä\Ó\ì\Û%¡‹,%‚D­ˆûÍˆúLˆù,Hò{!\â4Œ\nXð0I4\Ê\Ó\ëf@Þ ñ€Y`_²‡\Z\ê\ë\ZŽ\È/\ä\ï[‘[„;\Û\åªøŒˆE\íp:L\Ðtð¹8\çXõ\n’q·€F”‘§0;\ì°Ùœ\èíŒ £Ì¦r&Q\ìb¾ùqS†\ÛOS¨8úò\Èó\Ø\Ó\èGÿ`\nI’\Ø?\Ú\'#j\ÅïŸª\áý}80Ö\áÃ˜˜T¥\Ý\ì<5~\Ó\"ò86\Ç\ì_yú(üŸ¯iµªÃŸŽ/-:x\ìøq´ö\Æ\Ñc³±\ÙÃ¬õ\âYœ¹¼†‹\ë\Õpý\ZnÞ¹‰So\â\Ìúmœ]¿‹¹\Õkø\Å?}Šÿ\éŸð\á§\ã\Ò%ò	ˆA0\0&7g}a\È\0ø\æ7¿…§¾õjvmAÌ«ýµ@ *\n\É%ù©ƒ\Ón@2lƒ\Å\Ò³\Ù\0ƒAy	pã¹‘Q¯Qð}þ\ÙimNÛ„°\Ç³®Ir\Õ0V\Ë@^¼jLò»±€\r\rõ{	A³\ÅN \rõ°›õ°Z´x‚>˜ŒL:=6”\Ó~¸œ47\ëQL„V\î÷¹\Ñb²Àã¶£”¢RŠˆ\Å}{k$’tRdRB&—E,“yû†*pxch6†¤m\ìŽ\Ñ^N\Í¦6`œj\á	Hˆ\î\Ç\â‰\ÌŸ\ÂÂ‰,­ñ;®’¾•%œ:uR®€\ÓlûrÌ«\\l\îü¡>*|‘0zZ²}6{.^QI\ß\ÅWp\é†ò\0¸\"ðMÜº{k\×naÿ\Ô%¬ß¹‡c+\ë¢	ø\àW¿\ÄGŸ~¬œ\Â\Öh:Áñ³´¢\Ù\Ð\ÎQ\0<.Ê §¾õ4\êönAÌ£\ÏZ³ù\æ“ó\ëD\0’M\Ø`¶¶H­\îq \Ñj¥\ã\Ç&»dÐŒ˜ŸA6x\ØG°b\ë{µxýZ\Ô\Ö7a×®Z„|•¸t\Â\Zöó\Z!3˜}&ˆ3š5\Z\á\rD<*\Ø&n\ÑkðÎ¶\Z\ì\Ù[‹PÀ?1¿Z\ètZ¤£.d.´\èŒ\Ð\ë\r\È\Æ\ÝbhN\nzº‘Š¹\Å×˜¶4¥B\åR%\Î5¬d\áö†\ÐÙ™–Wô#Š§2\Ès^\Ñ\É#0û\ÊH¤‹“!Òƒ\âòuhœ¢q©Û\ÍO\Êó\Ä\ÒB5\é;!µ¼øùžZ\Â\âÉ“˜š§õ\ëÉª\Ç/‡?¯\à\Â\å³82·„ñ™\\»¾†ó\Ï\ã\Âeº€_Á\å—qõöU\\¿y\ë\×Ö¥¼FÈ½;¸yÿ.¦O^Ã…\ëwp|\í:>üô#<ú\Å\Çxÿ“p\å\n	%ó›½€%6‚N1À6ºŸ[O<ù„(ƒh§­ßŠˆ»	^k-b\Þ	€¨»Y0J\Ã%\0,\Í\ÒÁ\ãÛ¿sO<n\ZQ_W‹I§ƒ!Íˆø\Ì¹M\Ø[\Ó\0\ÇF‡E‡ˆ\Ï\0»¥YPB²†­\Ô\Zšá°¶À\ï\Ð\Ë\Ï\Ô\Õ\Õ#\ê3 \â\Ö#\â6\È\ì¢T„w:I$-ñðŒ²Á\Ê\ÊÀkA*J\Çr\ÞÛ£…\Ëm»xØDŒFUJzV\È‘%½<Aj\0¡€[&‘X@=ô!J‰	\Å`_}½ô%\îB[w;ö\ê\Óhm\ïTs«\íbRÁ—W\æóŸ%\îr\'fql~\'VXþ-biù._<…l\ç¥ƒ¸rù”dþ„€\Ï_<…\ëk\è›\Å\ä,ƒ\àx\Õð\"\Í,c\é\ÌŒ;ƒò\Ð<nß¾†³—® k\ßI,¹Œ›÷\à\È\â%œ¿q§.\Ý\Å\'ÿø)>üÕ¯ð\Ñ/yV6\'l \Î%’Ùƒ“œBrø‹\ËÀ\'žx/¾ð\"šíˆ¸\Z\á±\ì\Ý\0\áR#\ÌƒQƒ°\Ï­¦N;‰¡\Z¼ö\Æ.¼ñ\Ö.t¶\ïªÁ+¯\ï’;\Þd\ÔJŽX¡ijÀ\Ï^ÝŽw\ßÛƒþ\ä]l\ÝYƒW¶\ìÁ_üø=¼ùN\r^Û²MM\rx}\Ën¼õ\ÖN	”\0!h·.«‡N \àw·\ïáõ‚LRœBeR:\æ€\ÅlAM½6§o¼×‚-\ï5cG³;Lˆ\Æ<\Èg\Ø:Ž Xˆ!õ£»-)sŠ\nù„ „\ÑxgƒJ\\22\Üo¤=ƒLŽ\ãm\Ñ\Þ=Œ©™1Œ8„Di\Ã\éý3¥•y\Ì/Ÿ€?w\0³‹‹rôŸ=»‚…¥e¸4\Æôüq„‹c˜œ;Žþ\Ç`‰Žap|½ûQ\ìŸ±Ç™U8’“_…\Æ{C\'p\ïÁm¬]½Šƒ+_ÁÒ¹u,¬^ÁÙ«w°|\î&\Öo\ÝÀ¥·D¸¾~J\0›A\'\'1sŒ\ÔóC˜šÿ‚+\à‰\'ðø\ã\ßÀ\Ë\ßþ\rXu»t4Ài\Ü#À–0\Â\ä2\0\âAö\Ö\ì†\ÕØˆ\æ\Æ\Zuu¨Û»\Ú\Æ\ìÙ½;vl\Ç\ßýl^y}+Lú\Zh550¶¨ŒÛ¶mø›mÁ;[w\á\Õ\×w\àõ·v\àoü.~úómøûW·\áÿûóW±{\ÏüÍ\ß\Æ[ooƒ\ÛV‹®}š›ö\àõ×·\àç¯½‹\×\Þ|Zm~ô\Ê{Ðµ\ÔÁan€\Í\Ò\0«E#(\åÎ\r\"ýü­Zü\åOv\â•7jð³Wkð³7÷\n-\Ý\ï¶\"sË•d±\ZŒû\Ð\ÔlF<\æC±B£\Î	½É‰\Öö4Z\Û\Òpú\â\ØQ\çÃŽ\Æ0\Ü\áöjSØ­\Ã/Á\ï„Á¥d\å\ÄýON š\Ûoª\ÓsS8J)\Ø\Ì2m£0ú:\Ìv£\Òú@bùArƒx½6‹þ}“Hµ¢kx+\'j›@¹÷&fcô\È,Ž\Ì\ÇñS§q\â\Ì*N;ƒ‰\é“\è;¸€Ó—/apbIœBn°3øþ#u\\a\0	T9\0³ú®®žø\â€ \Ðoü\æw\à4\íE\Ø\Õ¯¥ös •Å©¨:}“€5\é(u„~Iô`¶nB\Ðe€\×\Å;\Ý(¹@,he¿\ïsŸ± 	\Ñ CzI\îö¼\Ô\Ô\Ô\n>À~\0aaŸ“A‚d(yttn[‹`	&C½tI-ó‘O\è\Ñ	ÿ\Ð\ç!MM—\Ë£Ù€\Ú\Z-|N“$¬4¬\n¬rü§\ân\Ñ4¤\âÊª\Æ`¤´Ü†J%oÐp$€öŽ42…$b\éºz+\Ç\Ó\ÈËˆ¥h(Ñ‹‘0²Ý½\Ý8pˆF9Yd\éòZœE´õ1?8Š£3“§\ï\Ï\ìf\æ&1ul\n\Ç¦0»@À9Œ™A45‚\ÃÓ³XZ9‰\åS\Ôÿ-ceu«gWqš\Â°v\é.\\¡9\ä5¬ž¿„›÷\î\áò{X8}Q\ÞúGŸ|ŒOþ\éWø\ä+ë«Ÿ€S+[ºå“’<ökðµ\Ç\Çc_{\ßý\î÷\à37 \ìh‚e 8†·¨+ h@2J\Ä\Íƒ^#$ŽD€¥K>«\06\ì2“W‰—Iža¢n•(’6ð¨\nÀ\ï6\Èòºô0dÀ„\Ìhl¨Ç«¯½+9Eƒ¦nk3B.½I	Ik\ZIF©M\åfDƒ>=\Â~¢‘ô1\âU`ƒ\êf\Î9 ¾ €b6 •iG&Q¥‘¡ÖœJbs¸`¥Y&¬¦žöpN!\Í(\Õ\Ì\"R\È÷\ät2úŽcaa\nS\Ó˜™%d\n‹S\Ò¦\äkrfG¦hþ\Ì*€ÍœU(˜Mö–«Ÿ	Â¾ƒ\ä\Ç\Z\Å\ÎJø]À¸\áW\×qõú5Ü¸yWo\\\Ãú\ëbu\ë\îm\éþ\Ý~\È\à#a}ø«Oññ¯>ÁµõU\ÑJ na„)Yø\â\0ø\ÊW\Çoÿö¿AÀ\Ò(š@Ÿe :”i´	‰ˆÑE„ ñj}cm\ï\çt1“\ÔýQf\æ.½\0D\ÌÞ¹Xþqªkc\ã‰ò)op2f>ñ\Æ;»$w0\è\Z„:\Þ\ÐP‹G«©m´M\r¨­¯‡^\×“Eõ\â´Z+hÑ· ¦N‹Ù€,«ƒˆ™˜G¸„¹-l\È\çx\ïW]Ò­´\Â@ˆ6Àj€\ÐpO¯ò\Z\è\íi“ö\ï¾\ÑAa\Ö.?&o;;Tùf• 8~L\Õö\Òb%p|sIE@}ÿò	,¯p±1¤ú\0\ç/û?‹3\çN\ãüùÿ¿®+û‰ó¾¢nœ´ÿGÔ‡ªJ¥¨R_Ú´U£6\Ú(I:&²ÁØ†Ù˜f\ßW˜a·\0\ã\ÄÆ±±cvƒMlö\Ã\â%6\ÇK¬ªI^Ou\î7\àDM~\ZYú\îw÷ž{Î¹S\ì‹¬ü\Ó\ËH¯®`e}M \ß\å\Ì\×kwoH\Î\é`±õõ|õ\ì1\Ò7\Ç3 E\rÞ E‡T×¶\àù\Ùý\âÏ±\ëg/\á—/¿ŒR¿ñ 	1¿ñy\ÙQ\á\î—E\06T\Ë/öH&(t\ÉIðM*\Ô\ïD˜À-±ôýa\nA”\Î	añŽ‰¸†½t\r…þñv6\Â!«\Ü÷>w!´:ü^³N/AÁk \à-‚\ÅbÂ¾ýyˆE©/t 8\ê‚\ÍiC9£„O\ÔF5e\ÔDEhJ›ºš*Å—P\Ùvªœmùy=\Zk\Ð\ÐX‡¦\æe\Þ\ßv±U$^\Ûd\Ë\í\Ð\ÕMüŸ{ýº2².@ŸŒu9bÀY@Š£\Ý\ç_³\r\ä\âGfñ\É1LLN`rjS‚ý\Ï`fnsóX¸¹¸“$\ÖV‘\æYWAw\îo\àË­-\Ü{øP&ž<\Æ\æ³G\âH} 3\09\\JIvò\åö‹?\0/ý»v½ˆ_Q*DqÀ(@z8\Ó2lGUÜ‹\ê2¿¤p\Ê\Â\È\Ö\å\0\'™\é÷ù üº$LxØ¹“ú·\ß|¢òðC¶/oˆŸ\É\0EŽ\ä\ë°?;{\Þ\ËAI±Ef£\0C„€½n+Tš@Q|z\àV\Ú\Â\ìCZFG\ì\ìB\'(Ž¹„²V÷\Ëä°º,$X\0\ÝM¸ØŠ;Ž>:™|ŽœH\n6ÀZ ‘®\å-8\Õ\Ò \Ö0¤u3\åó-\âÿ¼ý¼²é³¯Cfþlv\ï5eú7z)ü(8€2N\í\0CQ\n6;¥°}ù\Ö/\Ìa~‘+`¥\ï§û·<ôUž\åsmUÁý\×Ö^¿…¥õ[2XZ[\Ç\Â\ê\n\îlm`5=% \Ó@\â\0²Žf@²Ïg€]»ñ\Ê+¿Fi„½¸’¶\ïŠ:\ØoW$üðº-0™t\Â\Òñ{,ŸŸA	—Qþ\íqÀ\ã\Ô\Ã\ç\Ô\Ã\ë4À\ë\Ô\Ãm/€\×N}€Nù¹£\0n».›V>ùs~\ÏQ¨Çž÷s¡Õª`³ha1k¡Ö¨¯\Ö \ë@.þöV\ÞÞ“‹={sð\Þ\Þ¼õ.;ƒ¨5Zd\íËÏ¡G‘Õ€\ßþQù½C‡´\Ò6’s\Úa6\n\ÚQs\ËuAúzE2€$\ín\ËBH$Â¨¨\äú\ÛŽ¯Àñ:\Ú\Òr§\ÝFhO¾Z[Ï ¥¥§i1\ÓJ=\0\ÝF\è\Zr—._DGW»ˆº{þÏ•\î\Î\0\Èú¸N*8g@1€¼1„ÁT\nƒ©!¤FX+ŒB˜\ZCj|\Ã“™š\Ä\Ôü,\Æfg0}s7×¨¼‹Gðø¿ÿAzyR®\0	\0\ÙÐ›	€\ë?\0»_’Z\à\ÕWƒDÌ¶\0‰¨U¨\á	‘ˆù$ðmr;\å¾guNŸ>r¬\èe\Â\ç\ÏT\æaG†¢LC>3¢~«üO4`E,P„\â UÉ§yj-rr\Õ\Ðh5\Ð\ëtò·\É\Zb}\àqšP¶\Â\ã¶Àm\×#\ä\'\É\Ô·\Ãµ*^y\nF\è\n(€TvŽJ®þ\Ü›dBÉ¼v\Ø$©>*õ‹\Û)\r©*+bbHUS£¸“Õ<ªd‚\Óôû§#X«¸„~òi“˜Iž\ã&0yø\n#¨½“j`@®\\\éBO_z…öÕ‹+}Wp¥Ÿ”¯>ô_»Šk\×\ÉÿWh_ƒ©A¤†S\"ý\Ã\Ø­a¦1\Ë\ë`qK\ËXXN‹\Ü\Ì\Ò\Z®\ÜÄ›¸»ñ\0\Ò<\Ã\æÓ¯%\0VW¦1=õFG\èI¬\ØÒ‹2)õ\ÅOe€dQD’Œ`?À€DÌŠ²À†ª¸µ¥>~\"~‡À¾\á ]8z\å\Ü\Â\Ô/÷¼C \ÝøŠ>¥ðcPÄ‚V”rMð÷J‚”\ír\Í$(‹\Ú`³ˆ\"›ˆ\Ò4·r\Íðº‰{äšˆymP—À¾_—Ãˆbª™x(;\ã¢˜Ý%q§x\'8Œ*õ#r \"”ô_gŠ\Â9\Ä\0\ê\ëx”£¾¾BÁ¦\æh=w\Z\Íg)mBw;]ÀÛ…\Ä\Õq‚°`a\Ø\×ß¹S\Üº†‰©a(pð¶\éó\è\èˆxO(~“ôþ ý£\ä‹w?\ïþ\å•t\æ\Î_•#\à¯î£¦e†h\Òw\î\áË­\r¬llb`f«÷\â\Ùw\ß`ee\n“$„(\Ã ¡„+ûˆ28À÷@\É\0¯ý\áw2ü‰ù\Í(˜•°\0%~)üxóTI¥mÁ\Þ}G„\ç\ÇB¬L\n0¥È“¶/S°c EŒ™€}}iÈx(SüetJ›§hMÁ\Ì&#²só`0\ê\árpˆ\ä¼ ¶Á\ë6c¶\n.›zƒA¾G\Ú³Oq\Ô.“s	\Î˜\îË“\ÊUVžðË›_]É½1\Ô¥I‰\ÈÈ¸åœ’ó¸	µñ˜,™Œ$\Z/o@g;Á\Î\Ëaú3dG7\Õ?—3µ@®\Þ\èG\âø“-¸1ü…X½žk\ï\Ç\ØÔ¨pûRCø°¹#£Š\â‡Ô¯¾t_Á\â\Í\Ì\Î\Íaþ\æ——¤XX^\Âüò²ˆ>ú‡\Ó\Èóuã³®)Áý¿|ô\0ó··l\Æ\ÖÓ§xú\í·H§g01‘	€‰¦\í\è\ê¢[X\×ÿÀ»_”\0øËŸ¯ˆBü9\Û@QHe	5^\áô’\å`2“©k‚\Ãn‚*ºyªh\Ô:$H+Áecj\Ö!DœŸÀb/ø<\0$+„\ì(	\ÙP´Ê§µ\Ð‹Y\Ãù\ZQ\r\Ûa-4ˆî–2,ô¬6“t$¢&\Ä#\ÌLV\Ä\Éˆ¹\Ø&3UH\ìD\Ü\Â(£\Û7œ–yQžð¡¦\"‚Êª|!¿(?ªK\âD-­khh¬TL§N·@STƒÆ¦f1\Ø6_¦þû„\0J\0pöOW\îSg»`\r\"£Ý™™a„k/Á:ƒã§»p¶c\0\Ñ\ã\í8\ÖÜ£´\ã£XJ\Ï!VÛ…³m×±²²ˆ™yRÀ•€A°°¼Œ\Õ\Û\ë˜\\\\G¾§‘šq»»¹)’ðù[÷Q\ß6‡{Ÿ\á\é7\Ì\0s˜œ\à4PaS¬\Ò\ÕÝ\Þ\ÞmF\Ð÷da»w\ï–\0xó¯’¹}\ÌgF\Äk”z`;\0(gð¸‰º¹ð\áý¬|d\Ô\áð\rT\Z£ðø\ÞÙ«’rðp´Zµ¼¹\ïþ+¾D•v‘dO;%\ì¤ed× €F&ƒjµÑ\rjµ•\å\Ì<$”rL5²6»Ú‚h5:aLF¨´t)B¡Ù‚€·N›~/!@\\Rø•\ÑrFÀ\'Y€{¼þ\0LE>#!ƒNÖ•£‘[M\ëk\ÑðñI„JŽ\Ã\á¯\Çñª££ù“Ó²F–\ÛGù\ÉmáwXÀ\\\0YU¡ªsH=‡öžk&Ï£­³\å\'.\à\ä§}P{Zqò\ÔeqúXXœd\ÏSÑº¦^,,\Îan~^\Þü¥\Ì°¼v›_=@ü\ÃA¨½\ç16·€\å\Û\ëX¹s·7 tƒSiÌ¥oc\ã\É¬®\Ïc2m+‚³ù\É\0x\ë\Í\×%\0øð£^¥\r”\0z¸Bó&¹“c\\N\r—\Ó£Q‡ÜƒùØ—•\'­Ûœ#ð¸L8œ›/3\0¯Mg¡¿E>>·Q:·C\Ã\'+‡~2„z„\\F\ä\Ê\ÃÁœ|¼&X-:8lh5*x]fx\\\Ôi\r\0\0\0ÿIDATz|¤…\éñÎž¼ù\Ï,M\Z¼þ÷¤x\ã\Ãx¿\nª|Z\Óhñ\Ú‡{D‡` \ÑLA\Z\ãu\Äú$\êB8\ìÂž,#²\à\ß,(0ºa*òBeö\áƒ\Ã^X\Â\È3\Ç)«Eyu\r,¾*”UÃ™3Mh>\ÅÁ\ÐÇ²›˜\×UEŠ::\ÛP\\Ó‚\Ê­h9s	•õŸ¡\êD+z¯ö¡\âD+j›/#XyŸw/¸Ž\áhü¬Š‹ˆT·\á\Æ\èRƒIap|Ã“c›ž\Æø\Ì,’õ\Ýh½tóóž\Å\ì\Ò–w\ï\àÖƒ{‚|ý\íwH¯\Îab’»ˆ3Œ .¨R\ÚÀÿ]\ãø›¢úc\0\0\0\0IEND®B`‚','Local Drive','2023-12-16 07:54:07','2023-12-16 07:54:07','IGH141585754362','IGH141585754362','image/png','Ani Demo','WRS695055681927'),('KBD265067218118','1437px-Logo_Grenoble_Ecole_de_Management.svg.png','https://storage.googleapis.com/revspire_test/1437px-Logo_Grenoble_Ecole_de_Management.svg.png',_binary '‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0€\0\0\0€\0\0\0\Ã>a\Ë\0\0\0	pHYs\0\0\0\0\0šœ\0\0µIDATxœ\í]	´\\E­™\ÉO Ë‡²‘(\à‚\0IÁQ\ÄP@%*(.€	;ˆˆƒ  ¸\r¨\ÙQQY4,!A‘$d\ß \äÿ?\ã\ésnq.uú½yóÿô›7ÿ¿:§\ÏûÿM¿^ªª«««ª»E\ê<\ç‰HED\Úñ•\ÊT\ÇoEd{\Ô_‘ž9¤Š\ìq\"\ÒA\nEü”\ïžgö\"F\Ì!Ep#\ÎÁ\Õ P[`\â»\çF9\nõ:\Â\ç#¾A #n°ˆ,1D\n!ö•ø‡ñs\ÈÀ\è?.ð\Ü_¦y\êÌ‰ŸP\Ñû«À åžŽúZ¤gBA2Ø˜\á\"òj@\åO‰›‘:=Š\ès\æú­\rúPÀ¹_\ê\"2\nõuw…¯\0\ÜúV5™Rx•¾Pük™§t\ãy¿c¿(€ñ‘\ëD\ä	\Z™™þ\ZHhy‘-²\Ö\é:\Ü\'\ÖŠ\ÈD™-\"`\Õ\ÃøP%¸¡S‚rª³À­4ÿ\ë\è?uen¬“X\ï-\"{ˆ\ÈEd®ˆ¼1^\Çß³²€­|b\àÑ¿#¢\ÙFƒ¤W¡T¬\Ï‘\"²\Ù\Óÿ6‚²ó¨Ž†vê‹\æµ&^a\êk†Q^ò§ƒ\å<ˆõ\reW	5˜ôýBZ7Œ	T»\Ê¬žF÷÷\ä3@!†\à}DdŒˆ|6ŸXo\ÞÔ·‘/\î¹VDvD=\r[h\Ås1@H\Û:C\â¿@bÝ‡ø\í\áŸpbýX/\×Hð(¼¸´o#Fž˜´¬»L}€bŒ¶\Þ_D&ˆ\ÈwD\ä~ŒL&”š®y¯n¦7rY¬\é\'\"/˜ù©I¥É¥\r\èd!F¬»y÷]\"òyùEŒX¯7\Ñ}¸ù\\pó&(b2§mü)Fˆu\×Ï‘\"r¤ˆ\\#\"Oy$+o!c ,|3SÀP\Òf\ë\Ùù#\æBu²\èy7@D‘³E\ä^Y\ã\é_[\çòz0Àq“q#HÑ©\'\"´¬‰)t²±~\ÄúËž¾´§<\Ê\ãR{–\Ç\Ê\0#©A!`| NðtK´\çE\ä\r\n9×ƒ®„›š`;B^˜¨“%<\Ï5\"=\Î“5øn \ÜÔ¬¬À\0¡%<Ç“\Ñ)k#=\Ó:€2€³\Ñ/\rÀ\0\Ê\ån¹bP uüK†éš…¾‘\è+\"\Ï@ vò²€\ËÀ\"ž·˜:³ž´\'\ÄMU`\É\Ãf\Ô\ÖSü\ÞS_½ žŸ\ÐþI\Ûy„\éG\êP2Á !|Kº‚‹x\îh)\"qû>`\è:(\ç]ˆ´³‡^\nö‘Ç›DPœ8\ã\Ôö*A>kDS½R[\n\ë\ÝžW\êC½“2\èó4\0\æ(S\ä\í\ãOõ\ì¬\ÓÒ·	\Ô\ÙžÓº(|\Ñ;!’2\è\Ü@ø¨	´òa–‚\Üa\'eBH\"™´W$\ì\ïPj3®\ß\n87b\0•Š\Îýœ‰ie‚{\rÁ\ê-žÄ’“\ë¬7ü)¦Lp\ß\ï\Îp»ˆ|\n{$BYGµ¼©Y‰’\Òœˆ¸Lg·Áõ%<¿i\ê‹ó8\ë\ç}\"r<‡­\ÄH\×Â…¶a5vbe\"JJ‘w‡KC,	G\Ð|Kx\îGb\Ö\êo \Ä\ëj„|ˆ(ãˆ€xP†úcVˆÏ\ØJD±¢ó¿À\02¿H}ø/l\'#¸\ÓnF\Õ)ôýh\ç¡qðµ¬\Ìÿbˆñ\ã@¢/\n-˜\à\Ûð²§`Ô¸P1\ruðó€ý/“t\Ú\Ý\à½\á \â\ïp\âþK!«®ü¤*VŠ@¶2„ƒSbþûLý™\0\r\áò„\×D\äƒ˜ H;y\â\Ì\Ä?+0ñ}\ÞÑ†kÿ´Aç‘¨\n…e.·O\îc\r\Ø2]\"\æ\à\ÕO(–»8™\Zý\nŠü]Ddix(&Ð©\ælc\×…œ\"I§ô\ÞJÌž†õ\Ï\íÀ\Ê\ä\è·LpC\n\"QL\ëøƒˆ\ì\èœÀ’õhªK£*\í\Æ\Z<g´a\ï#Sh9E&p»r\Î\Ä\è¬v\èB\Ò\í_\"üh0wGŠŽ#­ã¦¬¿QR€\ÅÎ£3\ÈX\ÃS‚¶—\'E1\Êˆßµfú©¤8ú\ßcð›Y\Ð¾Ã³O.tR\Ó-›L]œÿ1˜’\ê-·n\Ûû=Fš¥&®ƒ\çjƒ\Û\ÌCš+‚8F\àwn\Ùø47§¹IDŽ‘O\Â\Óx:[\æ\Â\ZÈ»z\Ó&¼5oŸU\Í?‰yø\"JšL HŒò\ÞU~\Û#\Öý±6‘LP\r\Úh\Ão\'\ïf³1¤‘±\ìôi\Z±Ÿ$ÜªYÂ®+\rfT÷\\…ýŠ\Ò\ÌLP Ý¶3Ü\'\éö§¢½…{÷x”\\wImxºsºñ\Ô|úQt°\Ñsl–‰o7;óMPn>ƒ:œ3¼E\ì?‹\íöM=\ï\'a\ÝHbO\Ð\ê\É\Ä_‹#\ã©\ÛG\Ï\\cD_O&þrÙ»»\ß\Ç|¿PG%þRÙ«§\ß\Çö@&h£3\Çf-À3-\àª™dk\ï\Îv‚\Ò{þJ›;{\ÌÈ—ˆ°jSò\Ô]W\í\Ä\Ü?Aüd&>ƒ2ÁNˆzµk\æ\ÔA\"\ßy$OE_‹\Ýu©\×Y(‘/þlòÁ7«nP6mw\ç¼}\Ìo7\0\r\ß \ëABf3\ßVñH¯\rSS\ë^.òkP{Á)òŸ&`„²ñˆFÚ…Ÿ‹ü\Z€\çÈ\Ø|±\Ì\ã\Ûo¤²Xö´\Ã=\çc\Ç03t·²\ë§	%s7ñ\×q]Š\"›En9e¢w˜\ÝÃ¿áµ½¹¢W\'°£¨öÎƒfm™¡ž‘=eŠ1ô²\'v¾3B—\É!€Ý€\Å\éN0$\ÝMQÈ–€\íL\nž\ÛþC9”N-\É	\ß\0‰`•ª\íp¿ÀÅ°\'¼\\g\ÓZ¶ÞŠ0ñ=q\ÇC®\à5x…\ØK?Ä»HDn‘;py\Å)mwbÿ\ÕP8?CFG\Øé£®”É¡À8\ÝøYªc¹9¤\È6ißŸ%°Í—C9\äC9\äC9\äC9\äC9\äC9\äC=4ª\Ú)Û…©³\ßñ·\ÕNùNR_\É²OI V¤q\Ä\îl°D=‚,\â–4$½–ßªA·)R\ç\\@\ä‡E3‘\Îêµ„hÅµ*ƒ#Ò–\ÈW0 Cc¾Ñ´-¾\éG\åø|ùƒˆ‰\ç\ãË®ŠÈ±>CQAEO\ÔQTŸ†\à\Z\Z‹‹þømˆ\çVô«‚7\ÆA*+Šù\nž\äs\íg‘Bú)Ý¸µÑ¤\r8¡ó\" E\ë8ß¬C°M’½\Ø2¢˜\àiÚµó¼\ëE§™ƒ\Ó:¸?\Ø\Ú5\Ê\Ôru÷\ÒFO»^\ÇþÿKADe€«¨\\–¦`¥„\âmvl6§Šd\ÑFžmÂ¦YŠ\à§\é‚Á½z\ZY\ëÀTFºŸFŸ¶­p’\â\Ýøÿ\Ï`F¤Ð¥Nº{Hp°ô£Ô¾rDÿ.1e>f\Ú\î‹H® Q\áZ\Êó°·b\ê¸(!V‡¾O¸d®[\×S7•;—šN?L7F¦~\ç‹\×\ï M¡gš\ÎoŽø\Æ2Àªÿ\ïtÍœ¶ý9lI_n¢»‰–Q¨¹ž&\êþ>úôh•>)3½F?þˆ~¨¨†ƒ  ÛŽ®‰\Õ[¬OÁ5‘´O‰\È#4´	PÁÔ±/\Î8wññ\èt(°p\é\ß\"2	6LDrŒ¤wðhYlŽZ\ç:¾÷3‰øÊ¸û@\n\r\ÆaÒ«\è;‡\è·\ã[½u¼Ñ¾«ˆŒ\Ãi\é3t\Ð\íb\×uRT¢\ÎýgL¢©¯\î ó\ä©Á\Ó=š\î s\Ùs\Ñ\Ã\0w\Ðw\Ú\Ñ\ï\ZbóüW²U\É\ë%®Ÿ¹/hOs\ÅZ\ÄS\Ñmeù*\Þ\é)¦:mm\íiûTS¦»e\ÔÁô\í\å˜J\Æ`.\Ö[\Õ]z•Ž€›\Óxý\ï\ëÁAPPDü\Ì\Óø\"Fù\Î\àü‘v\ÅH\Ù\ÅÜ«W\Òó‡‹Ÿf\Z\É\âD²\ÕÚ \ìiZ\n\ëŽ}°hv£ûhX›	b\ëö²\n\à\Ð\Û\Ü\"P\Ø4\ß\ïŒˆºo¸l.¿\îŠ\Ð\îÁÁ2L\r\î\Ø{Iƒ\æS\ãõ\Z\Âõ4\ßu\Ð\êõ¹qS²X`„]£\0\é;w³§X”Ñ¶7¨Ž/€i™aöÌ¡%\Ï\Èu\Ê_5`\åñb:# ³ \'„f\0m\ÜT¹\ÛM£0„¶o\Ûe\ázü~‹YºÓ–U¸ž:rA‚\Î;\Ä\Ç\0›ø•&;ö¡\æÀJ·ö··’\êß¿¦|n•Á\Ð\æZ¦_O7ˆk}\î”\Ô(@¥\r[õz\ÕÀ\0\'†f\0-xuø5-@\ä“Ø÷œYþÃ¬\Ê@Ò¿ Æ¸#\îhy}¸´@D‘\É©“qyä¨˜)\à]P\èô jf´\Ó<zÁžM%‚©m\r\å»Ì£?œ9y$”\Ç]\é.b&vWt€Qÿ‡EÜ\ìF0¾I\Ã!\àm”§«#À\Ù\ìr[»\à¥\ã°”•<ð¼ž[\â\ïAtºe\0=óýt¹õ&³\n¸Ì´÷{dÁS\â?f–unµc@ûÙŠv\r¦\ë\å\\ú§9%U•ºþ0BµÒ³•”Q«nAŠ \ã`hhK 2Á\r\"\×`j¸R@Å¯jó‚›¿µ#\în…ŸD03@;\Ê\\nÒ«\"‹ ‡\ìnD¤cX…!*F$\ÂMcÜ†ÿB\Z\Üq\ÎýuýTP\Æ(/A\n¾DS–\éVA<¨\Ýc‘I/¢þ@•Á›f[ö\Ý$ºyN\çÑ¼œŽAµ«\0\'\rvò\Ô\êÆ·e(lŠÑ´­!ˆ§Ÿ÷šy|[jûiÔ†H\Ä[ƒ‹j\ß¬Ô¾!°W(‘­5\Û\ÑFv€9	û´£ü\\\ÊeqL\Å(\ÆIs™\ç„MóAX\Ön÷H\0\Ýk?ËŒ–»:i\n¶\àý„\"\Õù{lg\æØ,‚v%\áúy…q\î$1«4™A8œ“°O\Ê\0\ç%Ì¿&\r°’¡…_…Ž	¥«\èñ‚9b|\ëÿ=MC·\ÆSš¦qœ\"u$1ü»\Í{\ÇVóžo\åúZ‰A¹?%\Ì\ïg¡??@ÿøZZV´\\\Þ# ŒN5\épX\é\Ø;ªŒ6£JŸŽ€\Â[B;“\à\àP\ãQ\r\n\Õü\ãµ”¦¿œ	^K›C\Ät›h ›ª\å-&\Ø\Ëõ>*)Tk‡–[ˆø-\ê<ZúÏ©Ð‰o¸ýµ\æ\Ï!‡ô i¬Z\Ôh\ãËœ“œ\ÈQKþ,\Ä\Ý:YN&c\0\ë	qó­°µ\æo(6ûEyœnXL\Z\ábXgÀ›5ù5Ÿ\Õ\Ü5ÿ‘ð\"N% -··i—=\Ú\ÍBK‚~h_8–0I™6\r£û|\Êe_\Ä]K\Øg‘\Zhc[\à^m#ÏŸM\ZQs¾QB|\0™\Íf-»\Ë/%¬Ž·lü\Ù	\Ø\Ñt#­!û \Ï:\Ø¢.e*\â9\Æ8s|iñ>F^ŽM\ØQ\æô\çh:\æN\Û~2­\ë£Ú²\ÞMvi¨#%\ê\ïv\0\â\à$z\ßa¼‡ú÷22\ãOŒ\Â.VÎ¿F\n\ãM»C\Ä1À-Nm&f Š´ŽqU\Ê\Ô÷w\ÂBYŒº‰ûö}f€ˆ\ÐQ1q@1ƒ£D\Ýr\\\Ýbx¸&P`…\æ\ß\0\ëšJ}¾L¡Zû›ú«1ÀXƒÕ‹¢\ÊTrÒ°¯a€¨ÀL1\0»R¯\í}\"\ìÞš¦Àú\Õ1m\Ì0WÀI3û\î‚#e´	¹R7\î,8<¶†•ðf\ÃÎ±$¨·	0\Ö öø1&˜¾F¡\×qvŸ8\"{ˆù\çL\ÛO\Çw_&œ¾üí‡½\n\àû‰p«_¢\ÐH\ÞVp³º+u¤L\'Î® \ß*A­4ŸO1ù\Õ}Ë‚s|µ\r\ëÀ{w‘&\à}Š»\Ó…j\Å\0\êS|EŒƒ¶\Ý\éS‚cmõ\Ý\"\ä\ëcb\0¢ü\Å1€†>¯‚Wj•\Å°Á¾ýe¤ñ«¤\Ë9EÐ·(ÿD	Y\×Z<¢¶‚‘2¶‹°žú²\â_cJd€q„7e¦ÏšÈ¨mÝ£SN”Á\ÕH\ËñÛ·w©C%]”\Z­rýþh„\Øb\Â^Iù7uó\ß#(â§‚mj\ï\î\"T<zÌ½	\ç\Ûj€\íL;\Ýtø™%P\ß9q\Ó0€J€+\è÷…4)2l.‡„?O®X­ŸÃµX	‚e·k_#m\n\ÆI“„\î3\í­•ö¦6\èrøh\Ó\Î\á\ÐšŽ*\Øñ2nÌƒ\îu i·Ÿ6s:‡2—¨L§:ø¨\éôQ&¿~sž££\àz\îŠ8Š—n¸8\ÔDuUô£‡Nù( <õMƒ¤˜Œ¶LÁELÉ’¸M\Ãé©‘\Ã*>BD\èƒø·g ´b¹\Çzƒ\ë¼\"OC\é(½\'\Âp0g \ÅÜµ\ÒÖµ\Ý#”À¤|µ\ÂB×·“0eŒ\0C\Î7¡f\ß÷¬} µ-Ï–,)¡¤Ø¯c¹&¸ôI¥€®Ÿ\Ä‹¨\ã ôhò·#s\â\rUB\èµmn„ø–¯ \ÖNc\î^Ä´²#l´!\Ö\ZO_–‚X\ÕB°£`Fô\nj—!-/gšp»•¦+¸œ.Ÿn˜\àù›#9¬D›#9\ÖN\ÕFkc7}¢rª\å·Dö3št%¦m\Ç\0ùú.\ÊpS«!H—¢¾û‡ØŠ¹˜by\è‹3Ì¬!¨\Z’\ç\Ò7Epùòˆø»!’™§˜{ùù,B²´|\ßPvˆQC˜‚u÷ñ•´\î\í‘\0•,2\03\Â$\Äùi\\šM‡\Ã{·—\Çk\ç\ì\ßÇžûka:\ÐD\Âý¿\råŸƒU\ÂTš“Ù 4†§¨vM£¶„B6=&/ç¯¦€\éûˆ\íó•³Ÿ\ÇCª\ßí„¥l\\Û§¡l.£© \Öx\Âj\á]\Í\ZUj\ÒX†7!i¬š¯“Qñ~QPKþZb	5ö¥–£Î”Ó™¶\çC\ç 31nq¿U‹U«\Ç÷µ\Ä\Ä\éh\â8Â¤eª\Ä\âuwõ®Ë—?qLaRQRMl\Åý\ß\Õ\ØúZ\ê\Ð\ß\âˆ]’ú@\Òþt¥\ß\\F\ÝaZ\ÎT›O\Ö(\Þ9«\Ðk\é‘H¾¼U\Îð3\î(\äµ\Ð+\ÚÈ˜<\Ú^-¿/–„\Çb¹7Ž\ÚV4q‡\ÃQ\îÈ˜´=™ª5Š\'Ž\Ùø·V\êÿu\"\è@\ã\Ç`\èMßŒ\0-F$-{66m*2­\Â\Æÿ\ï\r/\Þ8\Ï-Ù—µ«Œ\å’ý~<öj@$\×SÀ>»7\Ì\ÆMVô†EPlšQN¦Ó¯Ð®\ß2¥\ä‡(‚ þµˆ+°I\ëuKVA\ëZr\íZ	\É}Ÿ¦F,\ÝC®^_]«\ÑV)¤\ÔóM=\ì\ÇXK\ìJx_Áÿk\á\Ú\æ´\Zu\Ï\çM™Ï‘1E=r%\ZE³Éª¦\Æý}\0Y7›Ý¿\Ì$\ê y€¶Œ«ô)P´0ü\ÈÔ±Œ\Î!\ä‘ÑŠÍŸjbcÿ3Ëjõ;D\Ô0£Gã¸“L\ÜÿÎ”­;y·Nw6~—Ï…²i¤“\î*Ž:.G\ß\ë1r\î@+÷¿žS\È^SgE\ÔüŽ]Ì¥ni³\Îþ\åÿY¶T26€\0\0\0\0IEND®B`‚','Local Drive','2023-12-16 14:58:09','2023-12-16 14:58:09','IGH141585754362','IGH141585754362','image/png','Grenoble','WRS695055681927'),('KBD312682510644','9. Pitch Manager overview.png','1Oa5MY9OrTPDBjv4cMBAKhbMbFcqzmiHP',_binary '‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0€\0\0\0€\0\0\0\Ã>a\Ë\0\0\0	pHYs\0\0\0\0\0šœ\0\0 \0IDATxœœ½‡“\Ý\éu%`2Iq%o\ÉRy\å]­-¯\×^y\ËV\ÉÚ•K*\íZVI–HQ”\È%\Å$‰\Ãp8\Ã	œ±\Ñ\èœ\Ã\ë—s\Î9\ç\Ô9\çF7\Zy†þ/Ž\ë\Ü\ï½&‘\\M\ÕW¯û¡Ý˜{¿{\Ï=÷\Üû;—Nº‘Jxˆy\àóš \×\rctô\ZÆ†®`f²F\Ý Œú>X\r}˜x\ï¾ò7°\Î\Ü@>n\ÃB;ƒõ&vwqr²‰Gð\Þ{wð\à\á1\îœ\î\áøx‡›8:\Ú\Æ\Ñ\ÑNNwp\ç\î.nm\ãö\ímŸ\ì\àö±úø\èhûk\Ø\ß_\ÃñÁ:\ÞÊµn®`gg[[‹\Ø\Þ^\ÆúúVWš„’°¹#¨V‹X]n M!žH`lÆ†\\>…¥¥\"J¥$\ì®¡ò…$\Ú\í4b©¦u¤31\Ô\ë9”+	T*1$\Ò1c!\Ô\ëIT*q”\Ëüó\Z4j5¾—@½‘D2\ÃÀ¨.¯\Ñd…\\ù|s&œn\'2?b1bq/¢1¢Q\'\"Q¾\ï\Ã\è”7µ¨U¨W\ã(•còóù÷\Ç18}AhN„\â	„b!”K)8¼>\Ô\ê)”J)	”+ix\\&ü\Î\ïþ.žy\î\\x\æ9œ?ÿ\ì\Ù9wþ\ÂG>ú<û\Üó8w\îl6;øß¹dÜ…TÂDÌ‰€\Ï‡m\Zf\Ã\æf1:|c\ÃW¡\ÓôÀj\ì\Åx\ïË¸ò£¯À>w¥”\rKóiln4q°¿Œ;w6qr‡\Æ\Þ\Äññ\î\Ý;Ä£G\'xï½»xø\è\î\áÞ½œœ\ì\á\èpG·ùµ[gg\Æ_ÁÁÁ:–W`òUH\Õ\å½ýý%\ì\ì,‹¬o4±µ\ÝB0–BÏ\r¥RKuD“d\ny8}qxC	,Ì—‘/¤`s†ŒDPkd\Ñl¥Q¯g\É\ÅP«gP­fQ­fP®¤LG…Q,%\åv.£ó”\Ë\ÊX\ÕZ\ÅR¾`\0\Ù|•2\r\Â÷\Èø5I4›ü)T«IŠQ\äòa$~d²AX¬vi\ÍúOxKx‰¹‘Hx\àö:au¹\Ñ3 Áôœ¡xÁX\ÞPµ*ÿ¾Œü^|\rømø?\ï÷pþ\Ù\ç;ð\ÌŒ\ÍÏ»Žp®óñ\':\0#\0€\à÷a³LÂ¤Q;“ns\Ó}˜™¼›ñF®ý#®½öU8·P\Î8±¼\ÅúZkkulm-\àöñŽ\Üþ÷ß¿+†\ç\ëÃ‡Ç¸ÿ\à÷\ï\ß§89\Þ\Ã!£Á\ÉNNvq[a‡\ë88X\Å\Þ\Î\nZ‹\Ë88XÁ\Ò\Ê<ò\å2v¶\ÚXZ®ca±Š……\æŠ¨5r˜5xIDQ*g\à\n„Q©¤Ð¨&\Åð…b±x³za?\n¥(r¹J…\ê5\Z5‰Z-ƒJ%B!X\"\n0‚B1‰|>Žb‘Æ\Ë\í\ãQQ!Žr5ŽVK½—N‡/„%ZT«*’T«qù\ÚR)†b1ŠR1Šb)ŽB)@Ðp$€J5‰z#J5!¿W¡F$€\Ñ\îÄ›W§ð\Î\Õ1¤³A£>­\Äb~Š1”\Ëüž¢7~ÿ÷ÿ¯3øð­W¡œ\âü\Ïs€pÐ‚XÄDÜ€\ß»u\nfý(Œš\è\ça\Ò\Âl\è‡\ÍÐ‹¡\Ëÿ€k¯^óJ7j•(šõ,66\Z¸sg\ßÁ\ã÷NñðÑ\Î9Á\ãGwð\Þ\ãS<xxw\ï\î‹\Ñ6°°Š\Ý\Ýll,`m­\Õ\ÕVVšð„2°ú3D\Ópø“°û\ãh,”\Ñj—\ÑhÑ¨P)gGQ®d°²TF±˜F ƒ\ÛÀð˜.—\Õr\nÁp\0\ã³fø~\ärAxýNO\Z06­…\ÙjA \èB$\êE,\â\Ã\å€\ÕÁÿ\Ù>D£$“>¤R>\äó\Ê\È\Åb…|…b.O\0\éŒ2.\ÓDµ–D©BGIID\ám¥“\åóaq§×‹\Þ!\Þn+\êÍ¤D	FZ-B9	£Ãƒ‘)üÁ\ZõJ•8þ0Â±\n:`\Z•J±¨ø‡ˆ’ºÿxø¹À\å\Ô\Ãf™\Å<£q:\Ý0Œº5£\Ði`˜»³®v\ÃMô]ü&nþ\ä\ëð\ÛFPH;Q­D±±\Ñ\Â\áÁ\nN\îl\ã\Þý#eô÷\îÊ¡C\Üxˆ“;»\Ø?X\Çösø\"\Ö\Ö°¹¹ˆõõyq€­\í%\ì\í.bem‰B\í¥E,¯.a¯Ë‹X\ÛXÀ\Î\î¢D™­­6Z\Í\n&t>„y„\ÂI$2y¤²y,.\ÖŒ0”±²TE\"†\Ö\ìCµ–A«™C!ŸD2G<ƒ\Ù\á\Ç[=:˜\ín´\Z)DAÉ»¼µ™L\Éd\0É”É„‰D\0\áˆ¡ »\ã³zM\ÎÉ«\ÙfA<\îG2l‘\Ë%\Í\ÅQ,\Ó!h\ä$\ì^7\ÆL˜\ÕÛ\ÉF$M<b˜B¬nÞº6ÑŽf=F#O ‚t6‰F#\ßq€,\â‰\0þ\è?ÿ\'\\x†\ài\Ãô|’\Ø\íˆ\Ç=……\ìp:u\ÐÌ`d\ä*\ÆGn@;\Û‹®6}/\ìú\èyû«¸õ\Î7tŒ¡Vðai)/°··ˆ;§*ð\ÐŽ\å¦o\á\àpG\Ç;rN\ï\í\Ê\ë\áÑ¶D‚;wö\Î\ÒÀ\íÛ«\Ø\Ú^\Ã\îþ:ŽŽ\Öq°·Š½½\ì\î¬`ks››M¬¯7°¶V\Ã\ÊJ&{\0km\Ô\Ûeh­˜!¤\Ó	üø\ÒL6\Z\Íü¡(ö€Ü°f#	o0Œ›#Fxý^8=AŒkœh\Ô\Óh·\ÒH¤\"rVrC+Ì¿µ´(W\Ëk(\èG<D6\ÅÈ¬£\ÓFd³!Dc^Cn‚n„\Â^qšDÂx\ÒoÐƒ›CZ\Ø]N”; ³\\\æ\ÏH ^K	\àóƒð…b˜3:U:k\ä\àò„LEÑ¨g\Åª•’©þ\ï?ùcœ\æƒ\à\ã\Ï\'D€®D¢{.D#Nýf830\è‡15q£C\ïbr\ì*Lú>\Øô=¸þ\æW\Ð\éqO¡^\n`q± 7ò\èh\Ç\'[8º½ƒ#\"ú\Û\Û8½{ \Îð\Þ\ã»xüøT\0!A\àñÉ¶Bþ¬7qp°Cž£M©\07°¿¿®Œ¿»(\Æöv››-q€\Í&VV*\è±a`Âƒ\Åù\n\æ\ç\ëð…\ÓX^®!™N!_Ja~>›\Ã‡\'ˆzƒFL@k²\âûoMÁb÷#\âÖ¸\r3›D€X<‚xB…\á¶T\"ÀSùœF*\ã\Èf#¨”¸5ªÅ·_‚\Ë\ãƒ\Ùî“Ÿ£~Fò¬•x«ó¬\Â\0“\é0Þ¸2³ÅŠLÖ‡X\Ô%i7Î“ô \ZóAgq`l\Æ»\Û+?Ÿ\àF‘\Î&Ä¡K\åjµ2\éþô\Ïþ\ç.<÷3\"€JŒ\0\ê\ã§\0[\Çb\Ð	B+<.m2\rÁ \Äô\ä5\è5=°\è®\ã\ê\ë_\Æ\Ð\Õ\ï\"\êA«\Z\ÆòJY²±\Þ\Âö\Î\îœ\îK\î\ïý»x,@PžùÿþýCÁ\0,\rY%ð¨pKŽT‡8<d\à+aY*€\í\íNXm`k½L&…½­ÁøŒub‚jñTK‹5Ì·s\Òh\Èƒ‘H­¦r€d*ÁŽf3‹\Å\Å<š’é¸€²d2ŽT*!7‘yV2&‡‘€·¯XH\"\r\ãb7‡(”’Gb›¶\n`¤)3\äW\Ór\Ã…ˆ*ó\Zi¤2QLj\ÍÐ™-RM”J¬(¢\â \Ù$ƒÅ+}\Z\\¼1ŽxÜ‹L:³Í‰@Èl6Œr‰À5|6‚?ÿó?S\à\ÂÏ»ùŸ„:O\Ò]ˆ„¬ðzt°˜\Æa\ÐB¯„A7\0«~\06\Ã-˜4—põ•/aøú÷\rÌ¢R¢Rca©ˆý%\ÜpˆGOžÇŠ <\ì8Á\é\é>N…#Ø‘¿³¿ˆ]–y\Û+X_oce¥Ž¥¥:\ÊX\\\à\í.¡\ÙÌ‰\Ñ\ëµ\ìN¾ô\í>Lj\Ì\Z©8\Üþ \Ô\Éü•\Ï\àð\Ø1¥µÁ\ëu ž\àmóÀ\é±ãµ‹°\Ú\ÌRŠ¥S>\ärd³A„\"D#AdRQ	\í<©Tù< ‰b1)‘!_ˆbZ\ëB\ï¨	õZ\æ\ì÷¢A«•¸Qƒ‡\È=“e•’@:†\Ý\å\Âø¬\é\\Pr¿”–\Õ$jõ„|8•jfL\ãŒP¯§\áòO\Ðø\Ä\nŒ\0Yùþ\â/?‡s~–|4ÿ\0tÀlž\Õ2‡c6ólt\0\ÝŒ\Ú!´ý0\énÁª¿\ã\ÌE\\üÁ_aô\æ\ËH„´¨\äXZ,bo\Ç\'k¸÷\à@n?\r/@€\à<ztÔ¹ù;88\ÜÀ\Úú<VWy\ÚX[mceµ•\Õ:VW\ëX[ma}m›‹\ØX_ÀúZm¬­5±ºV\Ç\ÒrU$™Ë g\Ä_8†\í\Z\Í*\â\é,—*hµòXX\ÈÁ\ì !•ŽH½^­$\nûp\í–Á°\Åb\Ù\\©t\0\é”¯Kò7\Ñ$\âA8\ìF8\ì‚/\à€\Çg‡\×c“\r»0<¡Á´\Ö(`1—!—%JgE \0o?/œ\Í\Å\Äx¹|¾WœD§jLœ€_›\ÉE\Ä\à#36\Ôj)\á-‚\Ñ0\Ò\é(Ú­¼ðt\0–¨_øò_«ð3\à	1\ÔMSüù|\Ð\æ4Ã˜\í\087Ñ¯J@=A\à-&\ßÆ¥Wþ\nS¯!\Òc¾\Ç\æZ{‹¸}{‰\áy\î?¸“;û‚ö7\Òøû¶$\çü1%0ô\ß>ZÁm‚¿ƒuÁ\0»»Ë’û·$ü«ü¿ºR\Ã\Æzp“N¤òYy¿\Þ,#‘\Î`e¥„\å\Å²ù¬.?Ò¹8R\é\Zµ”\äy‡Ç‡\×/\Î\"\ZIø¯×’h\ÖR˜odK\ÆP*\Æ1\ß)\é—br\ãót–lXŽ?\è\Âõþ	ŒM\Ì!‘H‰¸¥tT¯^\Äb^Ä¢$x|‡½\âv;Þ¹1…žA-Œf›”¦ù\\\\\ÍÛž-&\à\rø„Hò(\äit:@‰t\ÍFN8:\0#ÁùÛ¯tRÀ\Ó5ÿ\'a\'\ÎðÜ‡ –`-\ì@8dÇ­…\Ñ0†™\ÉŒ^87{S@;ö&.þð¯ ù	\ÒQ\ë	l¬7°°„\ã;8½»/D\r||¼+Ÿ?xx‚‡O;¥\á	=:Ä½»;89%\\\Ç\á\á*Ž\Öp°¿Šý½e\ì¯H9\Ø=[;\Ø\Þjck£…µ6V\Ø\ÙhÀŒ\àÚ In<K¿\Å\Å*Ü˜€¥z=/·¿ZO!W`IE»‘\Ä|‹µ¸\ßym\ZnŸZµrrõJ±X¥|jµ2\Ã~U\æÿR\\À\à“|ÃÞž\Æ\Åks\âD¼ñˆ}\Â–\Ô\É\ç#\Èd‚ˆ\ÅýˆEý7à»¯õajV/`´oL‡\É9RI¯ð\rñT®€\Å|µJz\n\í6ùŽˆ\à”V‹¬¥b\É/|õ\ë_Ã¹\çžÅ…g>L}|*ø0´w€Æ„\í,p:fa6ŽÁ –4 ™\î\Å\Ô\Ø)5#¯\ã~ºñ‹\È\Ä\ÌXi)\Zxs«‰­–\Ü\î»÷ñd\Ðû§xÿ§÷ðþO\Éœ\àô\ÞŽŽ÷°s´…m,®­`i}‹\ë+XZ]\Æò\ê\n—x–±°°€v»\Öü<šr\ÐhµP®\ÕQ©\ÕQª\Ô`÷Dqs\Ä£-ˆl¹€T&ƒ`29Œ\ÑY/Þ°€.»\Ç+\ÆN¥‰\ÂŸ6\ã\Òu=R™0Zõ\Z),4\Óh\×HÄ£¨Ô©\Å\Ñ “\×añ\ÊE†i\æó(\nù‚!?Þ¸2«\Ã\Ý}\ÊA\Î*†š*\íXF2´“\Ì!(œ0\ã[?š„\Ù\éL\àùOñwó!öIú1[­\ÐŒxó\Ò-x}Vd³~x|n)[‹\ÅðYEB øÍ¿û&\Î=ó,.\\øE\à\Â\'§€HÄp\Ø¿\ß‡}&\Ãtša\è5¬a&`¸…™ÁWqñ_€q\ê2r	*\å°ð\êk\ëuo\â\Ñ\ã»bôŸþ÷%ÿŸ\Þ;ÁÁ\íC\ì\îa{oûG{8¼³ý\Û{\Ø\Ù]\Ç>SK¿–|k\Ø\Ú\"×¿$dƒM,.Ô°0_A³Q@¹\Â2(‹R%d.Ž@4ˆH,ŠL–y^\åz\"ñh‚\Ü\0Þ€:“\r&‹^?™>\'.÷L\ã\å·&1<a\Ó\í†\Ë\ë†\Û\ãB0\è‡\Õ\éC&E)—HP)Õ«<]«\ÆP)\ÇÐ¨\Ç\n‘\Ñ3À\îô¢Q\'*\ï4žr…Tß€4/ß·»\ÝR•\í.\Ôj1\Ôjñ3G¡#\å²1a+\Ü~72© `‰H<¯?€¢P\ÎLI4Y|\ç;\ßÁ…g_ÀùŸ“ˆTxö\ã«\0‡ƒÔ©.—»VÓ˜ô\è\0ú¹~˜´·\Ä&û^°\Ì^C.iG½’\ÄúzSœ»÷vðøñ	<8Á\É\Ý\á\è\ä6N\ïž\à\Þ\Ã\Ü{°#¢\ÛÇ›\Ø\Û[pu¥¡ÿrC\Âø\ÂBUŒ\Ýj1\ß.c¾]B»]\Ä\ÒR+\Ë5\é´ø^«ˆ%©Ê˜Ÿ/\ÃG$\Þlf$Ÿ\Ö\ê\Ì\á•Q\ÄA$\âA”Š!Øvü\ã«CøÑ›£°;l’›½7\ì.,\'ô˜Ó›1;g–\êbJCR\Ì\Î\Ö­\Þ$_÷ú\å1ü\å7nB§·!™$û\0H\ÃSX\"À#²¯7T4`87Zm\Z3\Â\åaO\\Ö‘‡ß›\ÍE\áPo\Ä%÷“^n6“\È\æ“„\Ãh·	\0\ép	©Š^þ\á\Ëx\æ\Ù\Åºþù\çc0€Ý®‡Á0\r­v“\ã˜\Z¿‰\é\É^hga\Ô\rH°û0vó{¸ôò_Á¦\ëAA\ZAy\ìl·px´Œ\Û\Ç[8 \è;½»\î\àþ£cÜ»(\íÞ½ƒ5¹\å;;+\Ø\Ù]\Å\î\Þ\ZööÖ±»¿‚\í\Ýe\ì\ì©.\à	 \ÝU9\Û\ÛKþH4mn²¨cy¥†eV\ËUy]\\*aa±¨^\ç‹h\Ï\ç\Ñj)‡hµ\Ò\ÈH\'#h\Ö\ãÒ•³8<ðƒÐ›\Ø\É\Ì	0¬\×Y!Ä…¹«\×\â¨U’þ²™R\É\0¢1?aü/\\Gg\Ð38†·¯cZ£\Ç\ä¬“\Z=¦\ært&¬|>\'B7\"1/<>\'Þ¾6WÞšB0\ì“\ÛÏˆÂŸ\Ë\ÆT£™D±\ZG0\ZÆ’Ž¬\ÊÃ¤\Ð\Ê.Ÿ‡,\éP­f¯¾ö*žy\îÅŸ\0?Šž{\î…:\0û\ÕÁ .—F\Ãff04|\rý}—19vF\Ý-\Ø\r½¹þ\\yõo\à2ö£”õcy>•Ub€ell\ã\è\Î!\î\Ü\Ý\ë°|û8>9À\é\Ý#Ü½w„û\èG§\Ø\ÅÉŸcUñ\Û\ß\'\í»*´\ï\Îö267—°±Á>Aó\ì\Ðhxž\ÅE‚¿\nU˜o\ç\åt_\ï\Ü\Â\\!‰x4„z)†Z9Ï‡I­CBj³c„\ZK±b‘00	\é\ÕW+1it\Ñ!Ø·\ç!0\ä\ç³f¼um\Z:“C¾Ž%&C=K\ÊD*ˆX\"Œ@(\0§\Û‹\Ó“\Ã&ý‚«}S¸\Ú7ƒ‰Y-Œ#lNœ.œn;\Ü>\'\Ü~/tf§°$±˜\ç\ÛM¦¼4|Á\æó6s\ív¯¿õc<û\â§:)\à\Ù_ø<÷Ü‹\ê†mp»õ°ZUCˆ)@;ÓñÑ«˜™º!0xù\ïq\íµ/\ÃcD)B¦=_\Ã\ÚF»«Rù+.\à>\Þ{_a‡O¤,¼{÷@‰DN\ØPL5\0»\ÏC\ãSô¡ðÀ¢ô˜f\ÖXl4°ºZ\Ã\ÒrEnÿò#@Y\"\0¿@G`h\ÓRv‰|^7Z‚øc\Ðmx·GÙ¥ŒZQP\È\Ç„\0òVvÛº\åb%öý14\Êq¹\Í\Z+Fgl¸tÓ€D<„F•U\0;“\ê{ˆ\Ô\Ùff¸f\î\ç\çù<C}L˜\ÄD:\"%bdpI´0Z\Í9\ÇõÐ˜L˜\Ñ\éa°X\áæŸ»œ\Ð\Zl\âl\n\0&\Å\é\ßz\çM<ûÒ§~.ðajø#)€Tp0d…Ë£ƒ\Ý6\r“~º\Ù!æ†„0\êûa\Õ\ßDÿ\Åo\áú_\Ï6‚|Ú‡J9.DÐŽPÀ\äý\ï\n\0$$ôˆŽ@&ðÀ#Ü¿w(z€\ÓS\ê\06p|L\ÊwU\ÕýL\âK\Âÿoo«®S\0	 \å\åŠ\Ü|\Z~¡$š\0¾\×\ê\Üz9Í¬tÏšu\Öö	´\ZIQ\éðöóö\ær1x}^\í4\äkRh\Õ\ÉÆˆG\Ð\"‚§°$\è*†Qe¨–Æ\"m\Ø\Î\å#0\Ù]\Â2ºts¹*	£g\'›	*:¸œr”¿O©\È\ÒTE\Zµ^¡\ÑP:ƒþQ“\0R@ùR\ÉlÞ°Z‹©”,,–p\é\Ê;xñS¿ô‘Zÿ\çG€¥€PÄ†`\Ð¯W›u\n&Ã¨\0@fú¹>i\Ñzòuô¼õ·9\ÇQ-†±¼XÀþþŽ\ïlIxg\Í/T0\Ë@6:T0!(60yÿ½=¢ýy¹\Ù\Ë]8_`Ç¶\ç\Òb	õA9yòúª9\ÃNœÐ½¹(<~/\nùˆ°p\é;!¤R¤’~¤\â>$\ã¤^øŒO\ÎÀ\ëu\"p\"—ñ)ž=\åA<\æB&\í…\×G2Ì…\\Ê‡BŽˆ;„|.ˆB.(\åW&B&*˜ŽlŽ=þ˜DŠ®èƒ¿#=K<u\ãI\'ó\ïÁ\áö ò¡TRÀaž<ÿœ\"þ<’L#³v\è­©0\\>/,R1¤\à	…\èb€\Å\Å2®õ\\Á§\éŸ=\Õðù\':€ÕªA?	ý\Ü(ô\Úah5\ÐÏÀ e\Ø³QE€ko|½o\Ï$j)\ìl´p\Ð!\â»ðOzO ¼õl÷²\ÛG9—\n\íK\"üX]Q”¯|¼Jºw++-„\âY˜œ	˜œalï´±¶\Þm×±¾Æª¡†µ\Õ*Œ¦tu\íù2–˜\nŠh³\ÔÌ¢]Ï QK£Á[VŠ\n•:0®\Ç\Ëo\r¢§þ€™”_nx±„\Ãe…Ç£º¢=}#ðlÒ­ùU—4r!p\"pÀ\ç³#°#Jþ$\Â\Ò!\Ú?jy’”¥C\Èd\â<þH#\Ó$’¡NsˆQ‚‘ )\nŠ_ 3O\ël˜´\âr¯þp3Z;f´\Ø\Ü>4šU]Ô’rAnõ÷\à3Ÿý•\'Ý¾_0|„\nl¢°Yg ™À\Ø\È5a§\Æn@§\é…\ÅpV\í5\\ûñ—\Ðÿ\î·ó\Ïa¾‘\ÂöFGG\Ë8½»‡Ž¥¬4\0[\Ò\êe‡yÿô\Î\îœ\ìJ#\è\ä„\ÝÀ5¡\Ù&d: ñ£ÉœtûgXX®ckS?\æ~AÿKe,/1­óJKx\Î\ìƒ\Þ\î\Ãú\Z#GF•NŒ\äüfU2}‹$F¦M†C¸zk\ïÞ˜…\Ý\å…\Í\áD.F\"F6–\\{}@‹QR\Ó\ÓA¥¬ny.D)F<ÀÌ¬Ñ\Ùe^„#N„#.D\ØC:ð\ÓQlpzYþMÁf3‹ „Ú€([À	4£2i?òYFœ(&uü\è\íI8\\^„CÁ3\áXX„®yù720ôõá³¿ü\Ïq\îIžÿtX\àó›\àòhõ£\ÐLõcj¬\ã#W`\ÐÞ„EsW^ýk\é&BzQS§···€½ý%)õhtAFR¿\ï¿Oµ‚Pz(\Ñ\à\Î%þ ˆ”ÈŸ’0\æüý\ÝE4\Ú\r¸	dŠ\â9}\Ðø\"\0!ø#\ê_(cy©‚B9«3\0›+Œ|1Å…Â“ò8€†¯$EX+\Å%·[œøý>$“1Œ\ÏZ\Ñj&\áø0£³ oT@Ø‹‘I3vV‹\èÕŠ\n¨\ÕH¬”¢(—\"hTcˆG\è˜\ÃÈ„£s(¢R\×\ÓYq¤%\ä\È”Šd\'MøûW‡18¡5E¢‘0#‹\r~¿¿~ŸC\ãz\\\ê™\ÆÄ¬\áˆF‹c³&ŒN™¤B©vx\0F»¡\ÑAüòó«›ÿ	)\à\Â/|>³T\06û,L†1Iº\ÙaI1@/L³—ñ\î+_\Äx\ï+HEŒ¨Wch7\Ù|©ˆxS¥€»gi\àý÷:b\Ðû‡hŸž²ñ\Ó}Dþ\Êvvpp°Œ\Ý\íÔš\ì¶±³\ÓV%\àº\"Œ–; pi©\"NA Øž/ˆ(ea±€¥\Å\çóXhg\Ñn¤¶xjIAü\Ì\Ù«S³vI	v\Í\ZÁŸWûõ¨•“0\Û\\0[mŸ¶Ihf)X\î¿˜‹ Ucf\Î­ÁŽPÀ\ë:\É\ë\Ì\ã†õrLz\íù[É”‡É…ðý·\'põ–WúM›µ‹ª‡ \ßK°Hp¥_‹wo\Î\ÂI<’J³)öÀl\ã\ïL\Â)\"˜`q¡ˆÉ©ü\ê¯ýú¸ð1F¿ð³\"€£\Û\r´	`³\ÏH@§‚vf:!‚\0oÁ8u	—~øL¼ŽlÜ‚F%†Õ•\nŽŽVp\ïÞ®ôû¥ñ#\È_U\0gBQ\Ó„1¹\×þ†ªùwõK\ÔO\Ä/¢µº€œùù²´v\Éz±&&d“EHš\\IÉ³Dé¼lù²žWe[1¯\0œœ<õõaTJl²\ÄP%\ÅK#\åÃ¨•#p¹=š\Ðc±–‘/\Ì(\'\"\'\Ðd_žM!:[¾ùŒ7Æ¦LˆDC’˜¿¥w ¿ƒRùŠ\äø»„Šz\Ñ3b„\Î`G*Ÿ\í_<A\0\È# „\\&\"Tñ»½³(b\"li¶R¨Ô’\"v~£3£@ \ÑN\ã\×þ\Åo<¥ø\é¼{>L	w\æž{^E\0{\×L¦YX­s0›\'%üt]\ZX@›¾†‰·q\é\å\ÏC;ú6\nI+\Ör\Ø\Ùn\ãðhw\ïíž…}V]QˆŠ\0Dÿ8>\Þ\Â™½\íe¹\Ý\Ë\Ëu,.T1O9W›Š\ßZ­‚P¿|m4º‡ÿh\æ=Õž¥÷G\Ì\ê]\"ö¼:l†\Ý\éF‰F ˜*D\Ä\è¹L@*g$^ØVŽ0§7!²#v \ZqÈ«\Ïe\ÛiF2\æA:\áA>\ãG:\îF4\ìD4\ì@\"\ê’?Ë¦È¥•Cr\É\ÛEV	¹0\Êt€‚ª¤baU \å!#\"J¤þ1;úÇŒ\ÈSò1¤\Ót\0Uƒ\çpÀ²\0\0 \0IDATOš¡³¸`wqNÀ#%g¹š„\Ë\ë—ü\Ï*€rôÅ…F~ý7þ{\å\0$ƒž6þ‡\áÂ³BS>ö\Üó/~\Ð\ì6-ôº	\ÌN\rb|\ì&F†¯cj\ì¦DRÁœÒ¾…K\ßÿ<ô—PH¸°\Ü\Îa‹ ðp÷\ï\ï‰ñ»d™>2|\ný¯‰\ÒgŸŸSÿ·)\á_\ÚÀ$ƒ:\Ô/ƒ½ÿ]*„Yÿ“ýkœi\0¨õc\nX[­¡\Þ\Ì\Ã\îÀ\ì\n£\\-b\Î\äAµ–\ÈB;‡b\0\æJ’&,™\æ\ÓH%#˜3Ø 5{D•›\ÎQ#\ÑSŠ¢RŒ \\ˆ Ÿ	\Ãlu@k°Àa·¢D™VÜ‡tÂDÔƒhÔ…pˆN\ãD2\æ–\Þ hC `E$B\é™\á°‚ò\Zv!\Z£¼\Ü\r§Ç¯½<ŽžnŽ\è1¥µ#‰HiI 3$’Aü\ä†Wû4ˆ\ÅCˆ&\Â\Ò\ÉLfbð‡#rû\é\Ä\0ó\í,6~\ã_þ¦8À…O0ú\ÏŽ\'\ÝÀ€\ß,z@³aš\É[ºŠ\áþw15~U@3ø:.~\ïó0\Î\\A)\å\Å\êB	»\Ûm\É\ÛG·•ÐƒcŠAO÷q÷\î!\î\Ý?‘\ÈÃ‡\nty\0VŠ\0R8@•‡$”ðƒyŸ\ìB,û˜ó\Ù’´°P\Äò*Á`CS.\Ì\é=\È\å’Bœð°\Å\Û\â\ÐE%!DOTúð&x¼^\á\à¯÷„nu{]¨Â¢ó\'À«–\"‚f§hó¯\r\áô¸ÔŸå£’6Ê¼¹•8\Â!ffM°\Ø\ØEub‹8M$ŸgX(‰x\"(\ÕB\"\îƒ\Éj\Å[W§05gF*\éƒ?Hµ‘[\ÊJUZZ\n8 7\Û\Ð;<‹\á”Ja\Ä‚>ø\Ãd\Z9u¤\Æv+‡Ó‚õ¯KUŸ>†\r\ìF€3 {<\ì\ÎÀÒ¡\r\ÚQaµš›°ú0\Ûÿ*.¾üX4=(g|h7\Ò\Âr.7™yžaŸ“@\Ìÿ’tH \Û\Â*\ãS´\Ñ\Ë\"\'\')\Ô5þ™ò§Söñö\Óð{\ËKe¹ýF{\0¾@ñx‹+\Ë4Ûª¤2W:rœ\ã£(#†\×\ç\Þ\ê\ÂÄ¬Mò°\ÅaGƒ\0mÞŠ\Â‹Z½V‡7‡µ2P2<iC:B…µ;C¼œ0R	¿¨‚(\ï\Ö\âJ\ß~ti‰4u~1aô”.‘\ZJ\ÉIE0mpÀ\ì¤ú—DS¥BL*\rV\nq‰˜m6ôLczN\'’òx\Â-b£\Å!\Í*j)Vm·\np{løÿ§ÿ\ç\ä¶Œü¢ \àv“˜’ü¯´\0¤‚9\Ô\'c`S½?Ä¥W¾§®\Õl\0­Z\nÛ›-œžn\âñ\ãC~dýhüŽ\ÅðÝý»‡»w÷p\ï\Þn\ß^\Ã\áÁ:ŽW±¿¯T@,·©þ\ÙV\r Á\Õ\åóŠ\çg¹7¿XB$‘À\è¬—ûMpzü¢Ý§zfi1‡ùfm6ƒjœÊ‰Á\åq1£³x`µs\ÔÊ…	£”V\áˆW\0^>M©—\ã³vüý¦ðÆµ\Ø\\.´«	”ó*\ÇWò”sa\á\ê•1?\Æ\æl˜\Ò\Ù\ä{©\äQ½\æ~v#BSŒB= \Þ\âÄ«—gD\ÉônŸIþ~ò\n\Ô#¦‰/rQ»ŽL›12e\é·\ZN\ÍÀŠ “%\ÍQ¶”\è}\'~\ë\ßþ/8w\îg\äÿ‰q\06‚\\t\0\Ç4ôú\æF:À¡[\â\0c7~€w_ùk¸ŒhB\Ø\\©\ápIB<<<3¸’+GPý\05p\ç\ÎŽ\Éÿ“øY\Æ\æÆ¼‚‹U,-VEý\Ûj•D@§öòl¢a$‚%À\rƒ\ÅƒÙ†\á°“s&Œ\Ð72+­\ÙDÌ‡L\"€T\Ü/·\Õhµ\â\æ\à,^ù\É®öO#ô ðAg´\Â\åvIh\ç\íN&\è6ˆnºCSfLÏ™D4\Ê\n ’\"G\ìÀq-¯Wn~$\Z”\é(V”ø±gÀ2\âL\0\ÓD#†½2Dh2C!\'ür\ÃS)¿€@³Õ…W.Ncp\Ò&mbVŒjþPH¾ž­k¦€V+#Rñ\ßú\í\ßÆ¹Jôñ_\ë\0g \Ðb™…^?!,\àô\Ô-h¦û¡Ÿ€in@À©¿…¡+\ßÆ»¯|	>\Ë(š¥6Vª\Ø\ß]À\é\é><\èðÿùj\0”-aAvú¶·–;\n_*€\ÛX\\d]O\n¸\å¥–—š8 ˆV“¤«\"Z\í\"šÍ¼¼\×nSÿŸA¸3\Ðñ\ã+z\Ì^øüA\Ø]~Xœ\Ø\á\íú3©\0ò™\0\ætz\ÌBÿZv\\¿5…‹7fq}`\Zñ¨GX;¿\Ï‡Ý„K7¦ðú»\Ð\éô\Ð\êõ˜š5À\ã¶\"\àµÀ\ï±\"\è·Cg4¢gp\n\ã3zŒ\Í``dN—Eú¤—©¤31¤S‰44¦Á”V“\Í‹\Ý!\Ø\Âð žJ\nH§‚\â\0\ä).\Þ\Òb–Ý¿*9\Õaô…‚Hf8\n¯G­fFt\n¿ý¿ÿŸ\ì\0O—…\ç†¨‘0­”€‚^\Æp\ßŒ^^sN}/ú/~W^ý*BŽi´+Q¬¯V%\Ð\î\Ü\Ù>›\æ\Ùß£šwU\ÔÀ„|wN¶p÷.i\à]i\Ó1\Ø\"\rü¤¬¡.`“ˆ8`e…\ÂEþ0\r,/Q,\'0¦±#c}Fÿ¸7‡-›q¡\\Mc¹&T®j\ÕÆ¤\ëGm_\"é—® \Ãr4\În_T:…\ìü\Õ+Q\Í\Éx¶\Í\áÆ¬\ÎƒÙdŠ`NU¤}õ¾óú\æV\ä²øƒ•vDevÐp\È\r\Ç\"š>ö4zf#tF´FftFŒ\Í\â\æ\àFÇ§°‚ ð\ËL ?\èEª\ÓEdTi2„C¢qTckt€¬ü~\çwOU¬ñ\Ûÿ±@1©`\'™@ŠAµC\Ði8~M/\ìº^\Üü\É\×p\ã\Ío\"\àœFµ’‚ò\ë­\Í\ì\í­\ãô\Î>\îß»ý$ü?¨Aö¨ü\é†¨\Ö\ï“\n +þ\è:\0)`E)\ÑG±¨d_¹4\'v£X]!_Až\ã\Üå„´‚UŸ?.$ó7BÜ¼90-¥Q­ª>R½$kx\â1ŸD›u¶€£2JN*—„NžF\Æ/Œ¡i#±€I\Â–\Ùò\å+S@\\¾ž$L\Â\Â˜¬v8]vTËŠ¨bµJ\Å~V6\Ì\Ì\é\áñ\Ø\ÛE¤!‘p\ÂhµÀ\ãq‰x”«\ÉI£~\ç?üÇŽ0ôŸ’ž\êHÀ>€vHt€l´0kû`»!3½?ù;„½\ä¾C’‡Ø¨aoÿ\Ñ\ãc¼÷A(\Ãòg*\è@<,\r\é\0l\í\ì®Hù·s\Æ\ÎcCŒ¯nþ\Ó\ÊvùTÿŸ>\Å\n2\'..\äawRr\å¥uÿmª|9LÁ* +ö AhÄŽcaŸ¤2‡b´R\×Bò\ïJ\'ý˜\Ñ„\à{4~™À.EA;\Z=ŠqU4~õ*‰\'vùwª¿Wô~¤€\É\æÙ¢¦\ê7€‹7ux·W‡½N\ç\È\çˆq‚\Ò9,Bpz¼\"]\ÆihF¬€h\Ü~\"1þýJ?\Èr0“\ã?üÁ\à\Ü3ùÀO\nÿ?\nöúŒj3ˆŽ\à€D\0½\æ¬º[°\Ì]Ç•	—\Ø	4¢]Kcs½½ƒ%œ\Þ}‚ºe\ßÃ‡\ný³üSb\Ã3\'¸}²#ú@jÿvvT€¯Dÿ\"\0\á\í_eË·\ãK\Å(û\êôÄ‰ø\ÉH$bÈ¯©\Å­®ˆ´KI¹DISf³†7?ŒZG&R¡./&NP+¸$\ïÓ\èJB\n‰‘ýc 1:\áóyP/\Ó¸t‚Ž¢¾¾TŽ X\æJ\Zöø™\ãý(–Â°ûÜ˜\Ò\Û`óxD\"þ\Î\rLVv#‰¼òµtŒ¾‘\Ìh\Í0\Ù\\B\å²Q„¢œ\r\à°h²3MœøƒÿôŸ?\Þ~\Æ9\ã\ì`þ÷z°[g$p0”#a:\Í-Xô·`™½ŠË¯|\ÃW¿‡xÐŒJÁW«R\Â1¯3\Ì+ˆ\Ú\n\Â9€û\äœR#xDˆ\Êõ$|¸\é£+÷n·8÷W@£N½GŸ8h‘’5-R+³Ž\Î)ª”!?“T“\Õ\"}ý™9ƒÈ›“I/8\æ\Îz:u[s\ÞÑpÐŽp\Ø“Éˆ±I\rnôMcrZ‹\\\Ú\'»‘¸\'÷ óÁj·\"›ö¡T ›a›6 \Ô2_ó)?ŠY…¾ö½>x=^4\ÊQ\ä\Ó‰\Ð\èht(¦:BQ¥‚r™@¼x\íò†¦\Í\Ð[\ípx=\"cç¿‡U\0<yV\r¯±TsF7¼¾€¬°©\Öd\Î\ä\"ø£?ù:)\à¹º\Ø\ìs°Z4\ÐLbt\è*&Fn`z\â&\æfnÁb\è…yú.ÿ¿ñ#¤BV¡Z9žÅ¶®H½:’/\îþ9<\ÜÚ·«\íã‘®Ÿ¬v(ø\ì\æü\Îñg÷t\æ\0;Dg\Ù\æm\'\Ä°¸˜“-\Z\áhP@‘\ÇG´\î$#A#]d\îDhÁ<†\ÉbY8óp\ï€³ZL²œÈ‰º‘Œz-!v\Ì\Î\é:\'p è³©*ÀkB\Èo†N7‹¯¿C#\Z\ÄHû˜¯\édO\è\àPH‰E˜\×	²s9Ÿ\ìø\ÖF‰`÷y1k´\Ë@*‡S™&\è\0./§´‚¸\Ú?\'=ŽÅ…l\î†&¬\Èp©5\n¶…\È\æcø“¿øq\î\Ù\Î|\à\Ó\çg€Â8@,\ê”Æˆ\Ë1\'‹¡¦\Ç{1>|]¶„Yô}0N]\Ä\Å\ïÿ%¦{ŒLÌ†…V\Z«+U	\Û\ì\ç²»\×ùf/\àÁý\ÛO\ÒÀSX@f)\ß_\Æ\Þ\î\ÒY\è\ç!÷\Ï\Ö/S\0\ç\0º€\á_”¿œh\å°0Ÿ2\'—\r‹´{y>ƒH\\­‡!ò§¬š40Åž¢î­²\å\Ä\è%\ÛN\Ø>L\ë‰\îCB\ãÊ­eË—š»|Pz\Ôü»N!ˆHþÒ¡N¨‰\Íbµ)Ìö#Aÿ\Æ\\ò1©_u(\êp+H„\á\\‡W~2‚PÐŽxŒ€ý<^3\Ü“Lf\éX\í6\Üœ‘ž\Ç\Æ\âI?*·½(\n\Æ\àP	\'•ø\Ü_Q\í	úc\\up\Ö\ê:@4bG8h•±0\ÒÀf\í˜\0@Ai¿…·¿÷yh\ßB1\í\ä\Ëõ%lÚ°\ÌS)€@P!ÿGŽ;€\ê² \Zˆ›@87(p°$40ó?5ÿ¢û_\ç\âuóEó¿H\ã—ùS\êE\Èò‡\Ú8Š*\Ùn\åXóõ|3%\ë]˜Û•°“ù=þ\àUg.\'ú—\î\";zAyÆ¥¼v|\ã{q½oWú´p»]¨\æC\È&}(dg`‘Ñ¢ ¥\Z‰ž•R\r¨™B\ZJt~™ 2Ù€üŽ\Ô\Z\Ì\ê­h·S\Ð$Óªk\É4\Æ=Ez³¯]\Z‡\Ñ\Ì[\Ï\Ñ1/|AN»ôXù\Ð¨‘ü\âùrgO\Ð/–øuq€x”2&\\d\ç;•@ôs·`3öC7ö&\Þù\î\ç¡y¥ŒK­´´‚\ïœn\âþƒ=ÿ\æ\"¨\'40u\0\êö@	\Ä:€½e)ˆ(€\çÅ™¸hb}½C¯*\È\âb©\Õ\í\ç¡6®\Ý\Êb‘NÁ¹>púW\Ýüzgo¶\0³\"E\Ê\Ð]dOm\0K¼™÷E;ÀUn‹P´”ˆ32ð}\â¥-Px \Ä\ï\ËÏ¾WÀ^â–±ˆ9²š—\íhJ‹ËŽ¯ÿ\à&2l#S3\ÐŽ¤³\ÜE\ä“\nƒc\ëS:\'ô·\Ì*p\Ñ#Z:C(’µ[P\íü\Ê\×þ\çþ+€\çù^ú Èš’¨\×ŒTiû\Ï€AÚ‘\×ñöw\Ù\n¾ŒjžÀœ¨uNDª€F\ïö>:–\Ã÷<8À½{ªHG F\ë\à¥\È.`[öþ±\Þg®Ÿ§ I@\ØUs-\Z§a‰\Ô\ÕJ\r\çö\äÍ‹Ácªs\'\Ãª\ÈWF\áx\ã:(\ÆW!_•€Œ\åN¹\'¢ü\ä\Ï\Õ÷ª?+R\àADOg\á>€Š5¾\ê(\ÊÏ :ˆJ`v\Zar\\6¥ò{*À\ä¬^b–Št\0\ZŸ\0–ú@®£Ö¡oÜŒ	­6§¢ª¹p\Ê\ä²+5¥¬v¦ðõ¿û\Îu÷}(\ìó•K¤>Œ>\â\0n‡.™À¡¥\ì8€ƒÀ\×ðö÷?\'3õ¢O`www\ïmI#\è½÷hp\å\0Jp(›?IôH½¿½,ª_\Î’òmS\0\Ò,¡^#ú/\È\Î®}SK\Õ\"$µqƒ•€j\èP5“K‡M‘Iú‘Nø„•£ ’7Œ`,\Ê^}ÄhØ†HØŠp\Ð,©€.´!0#°©ª À´g\ïˆ>lˆ†ìˆ‡Ýˆ„øž]r6+	^ŒD\ç&£\Úô‰|<÷\"›öwª„NdÈ‡\ÅHw\ë{F\ÅùEø\ÉÓ†4Ž(1Ï²\nP€€\Õ\é\Æ\à”7‡Œ˜\Ð806mG<…?¤@zLqõ4¾ý½À¹g?\Î\ày\\xV9À…§\Î\èA~¯Y€ZÀ‰‘÷_ÁP\ß%h¦¯\Ãi¼…\É\Þ\à­üº^4\ËAl,W$„3¨%[2é»³CJwMDJ¬?\Þ>\Þº˜zÀ““u%\"\í€¨Š -m\àõ\Õ:¶Öš\ØX­\Ë\Ç€ª¹¿‚hýZòIÄ“DÂŠ(Ylv„ ’(\ÍR\roCw©’AVŽ\ä\rUC\Ù4g¸%Õ…x„`­\ãDT\r\Ñ\è‘N9dE`SŽ#\Î\Ãi*‡°x~?\ç\0-ðy\Ìx,ðû­ò9¥\ã>9»>­V3ú†Æˆ+ðg0\å}–ª¿¡ Uf4z+\Æ\r\Ð\è\ì0\Û\Ü\Çü\Èf\ãðøý‰\ã(Jt€Z\n\ß}ùqþù>ž ñ©óü‹Ÿú $¹\Æ,\ê€\Ç\ÙIšAh¦nA;\Û§\éFo|?ù\î\ç\á5\r¢]	\Ë\ì<1··¹dKžû\Ü\Ä\ÐÿðqE\ì!¿w$»ƒ\Ü\ß\ÅÝ»;\Ò¼}L5\Ð\Ä	\Å	$ÿ3\rý/V°\Æ\áB	‹ðG\ÐÇ‰[\Éó\\\Ï~;÷ôøY\ìA49…\Ë\áN@RÄ•Ú§\Èü5.G®›œ\Ø%hc\È/ª\é¢{†x¹\Í\ÕD\â\çr„\0R2³\î-¯\Ã\n˜#µ\ê0\Í0EI\n(tª¦ŠBS\Z#¾õò-\Ìj-ð\\\Ðrˆ\ÔfF2\éQ\Ê\"¿¯\r³F¼qu³Z=fµô\Í`dRƒ\É,3\n\éŒ_$p$ƒ^~õe\\x\áÅw€\ÎÑ8ÀKŸú\àš¸xÌ‰…¡6A\ÃÐ“\"\Ì`\ì\ÅÈµo\ãò+ƒ€mUÞ¶¬D€8Hþÿ\ä)\n˜g_úþ÷\ï\ï\Ê+[\Æ\Ç2\nF\ÕÐŠl\é:ÀNwýKwø³«\0Z,c©\Ýú$ò¯\'\å\æSˆÂ™|J¾mN¯ô\Ù\×³¢¹£–ž4­šðe\î\ï\êù#h\Ôb˜˜1blÂ€l:(\ÓCb˜2h\ä p\é$µ>s$€T„\à\É$½\È\É\Ç>a\í¬VLfb_‡6VÔ§«†~võ¨G øB³+€\Ó\ëÂ¬Á£Å‰Z{\r˜\Î\ØAô\Â\ë÷\ÉvSv‰o¢q\îd\ÓI}.\ÂSþ;\ëi¼öÆ«x\î¥O‹œ»›ž2ú3L_\èF\0\ÇY\Èõ0V\å\0sÃð\Ú[ú\ßý.¿úe„\\SX¬Å•\àpEB¨ù?SþÜ¿\Ý!…pÝ¿;[ò5róo¯«EÒ·9*¾,\ßß­\0\Ô –\ÝEQt„\nVŠXd\èoe1\ßJc¾•‘ý=\í¦’|\Ï\×3\Ð\èž´H¯<ž\ä­d#§þ0¤Q\êÕ¨H«G¦L\"¸˜\ÒXdek6Kp\ã\Ò\È$…\ÒI¯È´\ä\ÆgüògŒ¹Œr€\é9\ê¸\ÎM‡þQƒl¡±\ÏJMF–Ž™\04F;fV˜-v>±9ÒƒP\ÕEHö³j\àFR–x\ìp‚™º\ÅX\Â\'\Î\Ë•/D\àöûQ«²\nˆŸ9Àï¼‰>ó\Ù:À\Ï9\Ýp\Â!›r\0+{£j=¼ŽÍ ^‰\0}¿&ûc\ÞY,q/\ÐjGÇ”ƒ\ï	ú\ï.†¦„œÀƒ38C?§€6pt\ÄM\à\Ëg„{È„¯\Zö \Z¸\ÙRLŸlÆ®p C-i\âÿPE\É2,¤\Ë\Ï9Y{½Ÿƒ:\\\î™\Ã\å›\Z$·üŸ\ï?3op¹„\Û\å\ÄÀˆNfý?\ìn—¨xˆü»·›³‚&“£“&Ø)Ÿ¦ƒ\Éðö\ßœ|Ñ®\'\å–\Ï\í‚\î\Ù[ò¬\Ù“m%“³6y§g	:Vs1>›H\\%¯€`PD*‹MþµZT¢U¹>\Éý\ì0²Ü¤Lþ\Ëñ\âgY$a\Ï|Œ±Ÿ¾ùO\"À§?\ÈZ\Í\Ó0\ZÆ…þ¹†‰Ñ«˜\Z¿.\à4ô¢÷Í¯\â\æ[_G2 \År3%‹\Z\ï\ÜY?k‘\ì\áR(‚?vùÔª—%Yõ²¾\Î9@\Î6E\0B\ÐY\É\'u=\çùhøô™ñ«\å¤,gR·‰­X\æ\ï€H³S	†h?nôkðý7\ÇQ­†…1\ã\ê.}NÄˆi\Ü\à(\ë\î\"{ÓŒw®ßŸd\Ú\Úò[ôÀ\áqð\èa1jq\é\Ú®÷#¶!2\nX$Uz=¼ñ\î†G§¤J=¸\Ò;\rÑ„lšý§l^\'¶J&<È¤}È¥†(^ñ¨\ÅÓ™B\Ís¸•›F¼\Â2RÀõ5=ýZ\Ì­\Ð\ZmH¥Â²¢žS\Æ]¢‰e\àõ—ñ\Ù_Q\ÓA¿\È\íW@9€\Ã\áê¨‚CTºeA¤fº#We=¬^{}n¼öeÜºøw\ÈFŒXj$e6o{«…­m\"ø%‚Ü¾½#}\0RÁw\ï‘öeÝ¯Â¿œ@F‚u®\â@¡FÀyv6\Û\Ø^kª³\Ú\Äú\n»,/•°´À‰Ÿœt\É÷sO¥\Þ·c3f,v&Z°þWU@÷ð6„C>\Z¤\×_)©p]\È¤1J0ÿû‘Oy\áp[ñ\ç\ß\èÃ/MB«³B£1\É-\Î¤\âN\\\é\Âõþ9¸=hFŽ\ÏaV£—J‚ŽE@9\Ä9\èx,Ac!\Æ\'§\Ñ\Ó;Š€\ß—Ó„ñ\ÉI8œ\r#\ìr\Z\ZM\Ì&hzL\étøþ›£xûúb1:T@R\0·Þºu¿ò«¿.·ÿ™Ÿq\ë¹K\è™\Îy\á#¶!\È5ñ‘ð\ß/dA\Û‹þ\Z.ÿ\è¯\Ñù;(\Æ-Xl¦¤$#€;½»#¹_=\à\ÞSŠ`@{2tz‡O\Ù8;œ \È\ï\ßÜš\Ç\ÖfK=n­7±±\\\ÃúRUª€‚l«5.|Uù{ÿb²ZuhdNòm \à–.\\·½+­\ß\n‰\"\Z[Ñ¾D\çüºxÌ‹k·fUPPáŸA‚¿B\ÆoÀ‰\Þ\Ôò\éöû\Ý\â üºR>\0«Ã‰7ÞF2‡«”¸<J•Ÿ]\Ü\Ñ\Å\Ä\ÒCÈ‡¤?{\ä}ö1|n.’ö¡À@6\ÜF\Ú\'M+\ê\Z*…|~\'|NB\ÛgÛ˜¬f)*\"CÃ·ð\Ï\í×•\áŸSNð\ì‡\àY¾>ÿ)œ\çy\á\Óxñ¥\Ïv@ ó) À2	£–Z€^\èf{a\âP¨ö\n.½ü—ºþe\"(‹Ý­yAö\Ìñ\nvµ\0ló\áª¸»#@\Õÿ\ä\È° vò\æoo6±#7¿õ•\ZÖ—kX[¬`e±,s~¼õjÆ% \ëüÎº6zø*=\È\ésyB§ùC\0\Øq\Å\æu<H\é¦ø—\ÛyFÿ\æ\Ä\Ìg¼p{\Ø1œF)Gƒ…û\'P\ëe_¿2+F©–;\Z\0–}* û±*%ƒ(“ƒ\È‡P!P,”\ï%~5òó¹ŽM¥ ´ž‹œDÊÏˆÁ\ãg \Ókà¿¥–\Ä\Ø\è\0þ\Ûñ8\á9õø˜\çhl\Þô—ð\ì³/\á™\ç^Â…\ç_\êÿS¸ðÂ§ñÂ§þ™\Â\0\ÝÀ* \ÂfmJ@\ê\0\è\0f™\n¾Œw¿ÿ9Œ\ß|•Œ\í,v7\Û2\Î-ðP\ÉÀTH\à$°¬ÿIsrˆ<\0«\0\Þ~uV°G1\ÈVS\"€,\\«´!rpF€‚ðý]ˆõ¿@\"øHŠcøir%·q©@õ¬,‚\ì8„€3©ý½\ËH¢>C\n\áò\á.ƒrJK˜†\ï\é!(\r©þ\Ü/»¨¦x„\ÑE\è\äŽto>Á\"icöYœN.\áp‰ö\Õ¿¯X\äò‰€8%¿\'%¬¢_8‚HÔbŠ)\É/À—¯\Ç\Ã!”r§\0õ)LOŽ\â\×þ\åo\Ê\ÆP†w!…^`ø4.<ÿiœ\ê\\xñ\Ó\â\0\Ïú—?\è\0n§V\é¹„% –j \Þþ˜¦/\á\â÷>‡\éÁ7PÍ¹±¾PÀ\ÞV[Â¿\êúv6p.%\à¾\Z•M 48÷\0-\ÉP\æ|öú)û’z‘‚‚zpSYm©”’(sHNI­\Ô\ä,Ás´WE™¸Ü¦\í•ž\Ïú\Ï\Ñ?;o,·€d3\ê{ecH¼ûxõœ¤T\çQ9|\0\ß#\Í\ËÊ(œ\é‚?+\Z¿Z\nbNk\Ç[\×g…òUºA>¼ý\êµ{û=\Ø.\æJ:¯\×¯\Ï/\é\Ãbw\ÂdsÀ\êt\Èòý2\ç²k¦\î)öžE€R–Q$\"«mH#\Ëü#û•8\æ4\ãø\ïþ\Õo)e0UA\Ï?ó/\Ð^Ä¹3ã«›ÿ\ÄT°wÀfž†\Ù8Ž©‰›¢è»ˆ\éñË°hoÀ8ù6\Þù\î\ç07ú6\êyÖ—Š\ØÛž\Ç\á÷û¨µï¤‚»\ÈsƒS¾\Ø\ÜR\0‘y¦G¼W¢\0\âö\ïy®t	8e\ßEQ±\Ä\Í\ß\ÍZjZ*Ù Á\êñ:\0Ášz\Ê7€+\Ð“Cß®>ù\Ûµ«Ï‰ú©²\"F\î?\ÌQ,\"{³¤?b ¿\×\0·sNŽ×¥ƒÇ©…Ï­—\ãu\àv\èò159‹\ï¾\Úƒ\É\Ðù~‹T\Òw\Ù\ä\ç\È!q\ÈZ\Z¡6­w\0\0 \0IDATþž&‹Q‘—O\á‚J³E\æ#Q;’	<^|^§¤ :y:é“¦·…r\Zº»Y„\Â½n\n¿ñ?ü›\'K£Ÿ{\ç_|¡\ãO\Ýþ>-ùŸNðüg:\à\ì8@\"\ÎU(fXM²ŠJ \Ý\Ôu˜µ7 ÿ‰tu—\Ñ,\Ð\æPB#ƒMyJÈŠ\Ür¶z\ï\ß\ã^`\æ~²€»g§þ‰îœ’\"X–!\Ðn˜­e:	\å\ß<\ë¢,I\n\àš´z5)‚O†zj\åkg€3\ì\'1\ßVý\ÑvÁ\n”uÁ \ÂÝŽ¡ú\\…k¡€³*\Äwñ@7*Hä‘¨\Ãü\ï]a\ï€#“ùX±…Œ6^ù>~½”¢q>2Ž¸ˆ\Þ]\Ð\é\Âÿg\Ón¤©R¬\âœt\Â\ë5#4\Ãn·Àl3aF«…Þ¤E0 z\rs-œ.£T$\Ý\ç™3ø\Íó¿ªŽà³=L/¾ø\Óq€:p–\è¥|\\œ\Í4\Ã—CõÁ0\Ó«\î&4C?\Æ\ëÿg0N_X[*Šš\çþý¼÷\Þ~ú\Ó;ø\éO©&P=\0V\0]ˆs,ÿDi˜‚žIÀ9HB¨³óO¶\0Rð\É]?\ÕšŠ\äÀgwš·\Ã\î\Õd S){	\n=:\â\Ï\Î\×HN&‹&ü}PøÒ¾’§;F/tž.”M) \Æ\Ïiü.Ì´Ò­<^;^w\\Â¸ô:š‚\'m\áNo:„Ž0´VÈª\Ø¼5ƒ\Ù—‹»…¨ÿWO£\Ô\\0@ž\ÛC8µdÁÔœM~†?\è‘\Íe.Ÿûl©#Rq¨\ç·þÝ¿\Ã9Aüj(q€D€\ê—óü\ÇE\0wrO ¿\ë\0C\Ð\ÍõB?sV}/¦û_Á\ßþX\æn Uacµ‚\Û\Ëxpr&j \Ûxô\ÕÀ¡\ê\Ü\ß\ä\Ïúÿ\äd«3º.0\é_V\0œ œ\Ú?Yø\Øyœ\Ì\0RÿÇÿõ,ZÕ”\Zô”]=¼Íº¾A4L\Ê\Ö+hºo\Ô(C ­¦Róv½KQ2\Êò ^\é¼\ßv\Ù\È\é8@òtŸ§\Èt\Ó}Ÿƒeš\Ç\ïB½¦–LtÁ_·x\".yŠJ\Î\á\r:¥\Ë71c’5\Ã3vN\ê…bþ§ò\'—ó\Ë3Á,\ÏªT£0Ù¸\Ð*\0_Ð‹xJ\r ª•t1\Øm\Zü\Ûÿ\ï\Åžyö91\ìyŠD	;9Ÿ¯büOJ±8Ÿd0\éF¥ÀÀ\r\áS½/\ã\'\ßûœ\Æ~\ÌW£\Ø\\­\áö\Ñ*\î? \ZXiÞ£ŒNð˜OQ€a¿{ˆþù@‰Ãƒ°·x6*Ø€¤\ìV\n ò-¢ÿ¦šõoS\î\Í]?]4\Ï\æN5­É‰/}{D–+ŽÏº03GÀ|‹¡Ÿ\á^Fö\â\Ù’ÅŒ6Š7©üe}NU\âùŸ\Üto\'ôwÀæ‡¢\0;añ”ÑŸvI)…NtyZQ\Ü\é%Œ\Ì\Z1>MvÏ‚9£IN°»\È(‘\à\ÏK{‰Rœ\ê‚\ÅfPhó8dS\'–\ãIn;Qs¤™ùÄ·ÿ\íw\çž}Q8\0\å\0\Ïà¼”~Oò¿8Ã‹Ÿ\à\0\ÊÁ\r\ã\ÐLõazü–<.V?}C9~\í»xû{Ÿƒ\×:‚\Åj;›-œœn\à\Ñ\ã¼ÿ\Þ1Þ§ö\ï@’ù\ë\Üöc.ƒ\àm_z*\Ü7°´\\;[\0Í‡!ôU\ÊIYœHd«Ö¥(\ä\Ì\æˆBü\n½s†}ùXÄ…hˆ\ÝK§L\ÐO\Ì	¡1­1atÆˆK7f00<¿\Ç&¹•Ñ\0‘ù6÷\Ê\ìÇ¿ôz\Ò	ŠH\Ø\ÛW‚²v|¥8\Z²* b¿žÀ‘[E2\ÕrU‰(n@\"]	yþI\ÛX9€b+\å8\ß7_E8\Â9À\èü¸”‚\Ó\ÇLM2 š\æ\0w 7ZÅ™øp­\Ñ	ˆŽQ@E»‚\\ðý;¿ÿû8÷\ìKgZ¿ó\Î\ã\Üó/~¬ñ?\Öü\Ìÿ–)\ìŒ\r_v¦G\Ö\Ã_ù.¾üE„\ì“\Ò	\\Z(\Êöj(ù\îŠ@8âµ»·¢\Þ\ç€\ÇzÛ›m\ì\î,È‘pµ…5’=\"ö¨I#ˆª_þ-’>yµá«³\æ•\Ë¤\Ì\ê\Ü2¶p\Ù-£¦ŽÜº\ÛcÁ•›“\ÒÞ­•\Õ\rÌ¤ƒ°9\ìðy¾=\â\ã¬Xò\Í\Ì\éð—p±‡«\ØÌˆ†lˆ¹¥\ËŸÛˆ Çˆ™\éI©c·‘ò\Õ\Ã\í6ÁKº\Öe„\ÏmB8`A\ÈgF$Hôo‘fZ$@õG\íMð¸ðzŒ\"%÷{\Ìðz¹^^‡7¯\Ãd\Ó\"4\n\à\ã‚.>¯\Ù\ç3Ê¢.~\ÝAÉºZ½N=È‰h³	·^ŸS¤e+£ü\Ì\ã1\â?þ\Ñ\á\ÜóŸ\Âó/¨.ß¹ó\çp^8\ZÿÂ‹Ÿù¨\Ðó½®98L“°\èG`\âh˜8ÀM^ü:\ÞýÑ—ö\Îb±É§nd±µÕ’a\Ï{÷÷%\r<$ø{\ÌU±x\ïþ¾œ\Ç\ìž\î\àÁ\É6N\ï(%\ÐþÎ¢”‘$¶Wrº §€\Èûs\ÔK±€Jý\ÓwPuKz–¡—;zÞ¾6ƒ\áI#Jy5.\Õˆ-2Œ(ÜªEÚ”ZÀlµbý#ü\à\íº5bÀ\à¨\Ãc\äñ\æ½H§”6¢·Fô²]”}y¸y„›\rY®\ëˆDHó’4¡h.$“Á”„“\Ä\á†1\ë‡\Ï\ï\Æ_\ï“\æPš\Üf\ç\ß\ï.ƒ`\î\ç½\É(ûY2jõyX%—BðQ4\Ê¢ðzMø\Ã?þcœc}ÿüKg@^\à“\à…\Ïüò \à3\nd\ÖS\ÎÑ°^g{d/ÀÀ[_Çµÿ-\â-–ZI\ìo/\àž,†\Ü\Ç\ã\ÇGxôøH^\ÙdøøÁ>\ß\ßÇƒ»;¸wwO6q\çh]C\î\î\Ícw{{[ó\Òô\Ù\êÐ¿\Ëu¬,”…û_\ì8\0{\0t6RÀJ\ãG¥Gžk[9G—\áò\ÍYôhriƒ,q\è”{J­\ËI\"\n\Ô\âe(\æÊž \Éi\Ö\ã~\Ô9-ö\Â\çqJ\É\Æg(³“Os˜Ÿÿj‡§\áñY¥\ß_j\×™\Ï0	ÁD»{\ÔüuKJD¤u»4³ô²\Ñ2rY$ó}.@:\ËG\Ïú\Ï\ÚÀ²¤\äF12\ÜÀõµ\ÜM\èô8\áp“O=Â–\Ä#\Ìÿ\éŸ\â\ÜóŸ9\Ûþu\îüyœ»pHývŒ\Þu€g^úžÿ¥_Q\Í W§\n À™\0‹aL!ƒ˜4*ô¾þ\Ü|ó›H‡\rXn\'±»\Õ\Ä]Y\n±¯\ÔÀÒ‡Nððþ\ß\ß\Ãý\Ó-ùºÓ“\rœ­\áø\âP\Öüóˆ%\è\0\\ýºD	¡š?”z\Óð¢þ\éjü¸À¹Ê¾8‡1\ØO\É‡‰YJ¸¹a‹h^‰0Ed™öuûºe\Z9x\Z|r\Æ,»ÿ~\'J.©ºŸOñŽ‘®uahL‡\ÓƒÑ„Ë½\Z¼ò\Îzþÿ¶\Þû»®\ëL&A°\0 z!©\æ2\ã¶fÇ™$\ë\Ë$kù\Ë\'™\ØcY·‰5¶duQ;A½·\Û{=\çö†‹‹^\ØIb\ï¢DIT³$\Ëþþ‹\'\ëy÷9’\Î\n¤ˆ½\Ï\Þ\ïû¼Oq\á\Äb\Þ`Xlß~\r\Ö\0Žô:%€\'™ñŸP‚PÆ½¬o19g`€\äT‘€ŸœA\É\ËÇ™™´\à…\"Í¨\ÒbK\ß9\èøX‹\ÑÛ€õA!²˜\Øá”¤}ÿ‡ü16ðh\ßfž\0\åÁHy› j;¶\Ö~\å ZFJx,l‡´\Ê{\Ùô g\Ï/1tøX™Ž\âú›óxû\ÞE|ò\ám|ú\é\à\ï\Z§€yü¿‹/>\ã	pŸ~rŸ|t}x<¼…ß§/\àe\Ù\04–xûþ%\Ü\ç(ø&\Ã \Ï\ã\æu‚?\'Eÿ/›@&€²\0‘\ëO&¬RÞ²²/Á‰£{\È/\ÇaiFÁ²\nNU“?Ú·)Ñ¦¢{¦e}´Û	GO¿8ˆö.»\ä\çñ¤XœÍ¨\0\íb£V|¡Ž¯r\Î!Ÿ#U‹fÓ¤i0j\ã¯Z\Ñ\ÞÂ„=\"\í©b÷’\r\Ì\r:‰%R\ÊHJ1€%&‰\rŒû…õK\Â\Çd‘F\Õ4“Rd¢¬[\nb3›‚¦\'ñ\Â^zGƒ8\Ò\çƒ‰©¥b+R	QÈŸþüIl ÀcŒy\Õ`°i\ÝÛ¿›ªjÿ\ï8@(h\ÛN9S\Â:\à±u!Js(:_û9FŽ½€\ãs1Ü¼²Œ÷ß¾ŠO9\è\Ôo\Íú…T¯ò\Ø÷ý\ÛxO²\0¨d\"¸böž:µ$\é’ª}r\'Wfq|‰Š\\’!\ÐL§ŠR%2¦tu1a\Ë\ÒÅŒ\nf>™LHŽ>»Ógv\ãH÷v\ï…\Ã\íG$rqB6ŒB–£\ÈSz•£³—†#=\ÐmpÔ‹±ÈŽ&\ZG\çt_À¡qBZ¡°+i\ÌÍ’	¬ \ä¡q\ä\Óú\Ïô£wÐŽ…•3\Èÿwv\É.žfË™À\Â|ZÚº7Ž\ÙKò\Z(! Å\É\'\å4 ¡…\ß\ÃZ£8•–£¿/\àµCN\Äi$2Y\èqŽ\'7ò%I{ý\å?ÿ\nUµ\ØVµ}­\à\Ãv°|\Ô\Ê#5\0\r¦\×\Ï2©\0\äø\Ç\áu\r\Â\ç\è–\róv£\ãÕ§0\Þõ\nN.\Äq\í\â<._\\Á\Ý[o\Z¢O\Ã\îõm’;\Ö><oH\åÞ·n¯\ÊGs\êw\ë\ÚyÜºr\×/Á\ÕKgpù\â	\\¢9¤‘ôÁ€Gªk‰¤©Ñ§*x8\0\á\Ã\ï_J¨™Í¦p¨ÓŽ7:\Ð7\äC!—;¿\ÜðÍžV´oV\Õ{‹ƒ\Ç\âB\\ šd¥BH$ˆ\'übœ\í¸°·}:\Æñ¿<Š£\Ýc°9\Ðb>\Ñò½²v—G\"‡¾@@6l.«@Qd2\Ü\\ü¨:ƒ½8\Úc•ˆ¾d2\nM‹\"“ ‘\"ž\"\nCÓ‚}B9\Ð1-\Z€À\î ™Œ Pˆ\Z~jüó\ï~‹\Ê\ê:\Ôovy0Ml\Ë6\ã¨Å¦\ê:£hü\n8©#›ôA\Û\rŽ#B‡p_?t/¹\0OÁÒ·§¸uy\î_Á\Ç\Ý\ÅçŸ¾ƒ?ÿ\é!þò\ÅCü\å\Ï$…TuÀ§Ÿ\Ý\Ç\Ç¼\'5À\Ço\âƒ÷o\à\áƒ\ëx÷þU<xëŠŒ“…ûý¼\Üÿ$\Ü ÿß¨þU¸d€óJ\éc`üŠ`1‰3§&…\Õ::–<À‹d\ÑÖ˜Ï‹’glËœÐ99‰£\Ý\Ä\â:²irü\Éû+x?I¡dõ¤\Í\Çq¤\×%a^.vWPøü\'\çp¸ÏƒöM\È\ïó˜ç°ªL_\'# ´\ÂnŽ®\à995´TL\î²{¨\â›/AÒ¬f3¢AH0¥´\Æ+ûl\ÊS°˜…?œÀ\Ül¡\\\çpLtü\î\Ù\ßasM=¶\×7a£qü›×€ð¾r\n”7€Y’Ix	ûGñô\Ë@sÃ¡~\Ç\Ðœ]N\áÎµxø\Þ\r|ö\Çûø\âó÷ðg‘„½#ôpbÿü˜3\0I!ø=C^Å»o_1ZÀË’3p\çÆª,>Ÿk†€U?\r„úE\Ûw.¼™\×c\ÌAtRljØŽ=û\ê02©¸ züº<˜xÿzÍŸ‚\\ ¼º{ò\Èf\ãb»bœ‹Lú¤\Zˆ\Òð\ézFœH$¢8s‚N_\ä89%Ãœa«ý#™\r°ˆ<Ã¿‹\ÃJ^ªyUüñ\ïa§*ü‚\Öº]B)\ã\ßM\Ûø\Ú\ÔÒŽVTN)\È\ê	A\Ó\ãb&\å\'\Äxª\\\ç	 \áùŸ•Ê¾¦¾\Ù‡T€›A`aƒj\Ë`km\Óÿ¹\Òqµ\"1D\Èô!\êl\ÇÁ\ç\×ø~œ_I\ã.7À»\×ñ\é\'÷ð\'vŸª\Å7u\0|L0§~¬\Þ36À{\ï^Ãƒûjñùð\à&¸uõœQý¥õ3]I¼\×@\nP\Ì\ß\ÒtZ\\¿2É¤HÃ„dñ•\Å_ÿk\Ó<š!YWhY¤q\æ(	+&Eöu¤snKLV-’¦•\Â\'\ÛD\Â\Ê»\Ü\è\r`\ßQ^90,‹x‚/o{¾,£Ž€ø>¯®\ÎA7&œa\ì=\âÀ{\'\Î\Ærž›J\É÷´¢/ñ‡\ÒTV:‡\'‚\ÅyjuÌ’6¶\î\à8ú•Wž\Ç\Öú&T×™@-¾Ib«sl­û\Ê\à\Ü;u@£C¨waO´@/B†,<`?Š\ÕYÜ»q\n<¼)“À\Ï>½oD²xŸ•\'€ŽRS@>SðÁ-ù¾÷I{ëªœ÷\Ù\nÞº€»¼Œñ/‰ŸdÿPÀ¨WÅ³c,1}b\ßJ\Å#Ó¶“”y©88¡e‘º%ù>\Æf¡»§!þ\äkjÊ‚PQ‘nµ®U#×€\'Á<»(\Ç\Ö†.\â²(œptN‡:n)\ÈHy\ï„\Ä\Ôð\Ï\å­˜­šZ\Ò7€i\å\\ü$ÿ\ÜÅ‚d\Î0\ÚFþ>^Aô7Ì¢\È ›?Ã®!?ffr*ö>\Ç2)y¥\Ñ{0\Æë¯½Œ\ê\Æ6T\Õ7\Zñ1jñ\Í\äð›·`£qlªªÃ¶ú¦/\×\0A¿\r\ç\Ö^ñq\Z@À²‡^ú)\"ž.\\<•\Ç\Æ\Äß»$t.&~=`¥Ï¬_ƒ\ícNø\ÈúYó÷gÀ\'qqõ8.œ_Á¹3${,ˆüù\ÄÊ´\à\áŠH+f<,\Ú\Ä\Ñ\Û`\Õód.G\×=Ê±#—\á£ W‡„W\ËD<¿FJ·&@!\Ç\î!(½3»ƒ|6Œ|†\ÐnP@¤>$c^$\â~\ÉQ\æË‘I$Y=÷\n`–I\Ñ\ÙgG×€3%]ˆ(´Ÿ\áÿ#ÿØ±ˆÖ$ù»)ùŠŠ©ô¨Å…p4ˆ™išL\ÓJ.\"\ÅbŽß—Sÿ.B\Üñx-ŠWÙ‘\Ëj\Û\Ü!\É!d—$\'Àñ\n\Ùö\îÝ\íM;±µ®^…Hn\ØX\Î\n–k€\"[kŒ\"°VN‹/m\0þ’	7´ˆ1	ôôIR¨wü\r™RzùLQÂ©ß»/i\á\ì\ï\ï\Z>€L\ã½O\ÂSÀ•8Ž€){\çmòÿ.\â#\à®ö=£\æþ—xüŸX›°\è\ã€÷½¼\éj¤KJ–)ô©¥T&-\ÌÊ¨Œz£\å­^\çñ#\ßk|‡@<ò\åØŸS÷:^*€e\èSRƒn>\ÎdPTŒ»hª•+bOû8FXšW~D2=œ\á\ç‰rûÇ‡ö0´a‡@Ÿ¢«¿z¦o\èG$\Ê&Š\\F“v‰dD\ØFž@\0ûYgšKJ‡\Å@6Ç¤£\ã’\Ì/|\rµ-;¥¿—˜\Ø\r\ËZA3K€¬\àMÕµ\ØTSW\Þ\0	s\ä3!$\ãn\èa+\"„½½2\nv¼&\'@VÅ•³E<¸»*<€/þÌ˜ø‡ø³A1Á ‚C¦PH\Þ\\\àýX\\\Ãû\ï\\Ã»¼n¿‰·n±<\Âý?i¤}¨\Z\à’ Š\0R®„Õ»v¬›pï©“¬hßª¨\ß\ëþ5\ë—/“6ec°26ÉŠ\Ö(Î¡b\0)*	!”Šq ¤˜;¼øõtŠdJm8ƒ3H\ßñu²p\âû\Ê+€\ÇuK+yB\Ø]!ô\r9‘JÆ¤ò_˜IKÍ±4›‘‡E*“Jº\ÛO\ÅpJR\Ê\èdN3	\åA8)FR\éd\0‡\íAC\Û#¨\ä›œ€\n\ÃB^N\naKPµ\î0k€B&ŒT\Ü#N\á\Ô„½=H„\àðKO¢\Ç\Õó%¼skŸ|tŸ~þ¶,ú\"eX»\0\ZA“\Zv_|\Ì\rÀBÑ²\ï½}UŸ³€÷¨¸a€\Èÿ7(\à~(\æ¯rú0m^Hð(›0… \ïp\êÛ¨ž\Ñ\ã	iµX¬\Ýók³ó{L-™²d,¾AúøòÉ.þ¡<\Ê3@È¦\ÆÈš\ßgJ”‚I©|ˆfr	Œ¹\Å\Í,¨…Et2]\"—1…e©þSX¡ •4²RZ:Ž¾9\Ê\ç’\Ò\nŒú\Ñ1D H@\Éu	!G\ìCÓŽG±¹ª•Fý›\×N€\Í\Û\ÊX@ùHgŒ+ AJw#²!\ê–\"0¦AôKh\åIL§m¸º:w\ï^x÷\Ó\Ï9 ôkd \Ù	¨@i¤x÷\ÚZ+\Èaþ\å	@hyñùö¯²P}™¿·\Î\ÐQ\áû\Ì\Ìe0nca‘³õ¬\ä—¦³B\Ø0;\0Uš]€Rñ\Äq†q¥,\Ò\ã\×XHS!L6<¢öI©\ë\Þô06p¿²q¤Ž!£h^u\Äô‰4†Baƒš\ØÓÛ¼™ðÊ¼a\Âîf4*\'Œ\\#3\Ê+hª˜Ä¸#\0o =™;“\rÀ?—\Ê\æ\å•\"bºÇŽ@Ó®\Ç\äØ¼Uqø\Ð:NB\ÓÈŠª\ê/_i\ãH\Æ<Ð‚6D¼ºH\ë’`¼\ë9\Ýý\ær.\\½0ƒ÷\î_\Æg\Â| \à	!&H:Ï”¼\É\"è‡·ñ\áÃ›‚<|`\Ð™\n –ðªH¼zù¸<\Ôð\n ø#\ÎØ†\ã§2{\äI`°p$©(\äñ_½¤N\nk´¯õ60Š\'¨¨`S…”:L\"\è\"[+k\æŽô\ï\ê\í6©\â\\œùò\Ç–—øuL¹ööRN\r)\èX(\È\Èø\ÌñN‘\ï7ŸE&‡#›¥)D\ÉD\\Ä¦i1€\Ê`…\'Á\\N]…4\"zB®9¾\íþ¨Š¸\ã\çœ†Í ¯Ž£\Ðò\è¨$\Èc„\ä0‚$LŸ\à­[¿¼\Ì+Àï€\Ã: ²\Ç;ñô \êÃ¨!ŸŸô\áÚ›s¸q\å”@º\ï¼u\roó1 `‰xa\'.\äù)ÿ5ƒûõ’b_]Á\ê\Ù%œ;½€3\'\çpr…ö\ëü\Ç…ó6?Ã‰\\s\Ódò(\ç2>¬¬Yù\ÛgµOX•\äv\0œé´ «\Û»Ûƒ¨\ÆdŽ\ìZ~nT\æ\n\ç\'1ƒoOÿ8ú\ÆQÊ‡O+‚G!cP\Â>¤\â^y17\âºqÍƒ¸\æE4\êALg7€\ÛcGŒ°0\ë§»õ¤~ù\ÈÎ©\äqÍT<€	«\Ú1:nÁÁ\Î!x=.L¦\ÂH\'ùw‡Œ©ÿ.• ;ˆ¯ _þ=ñdT4ˆ„“Yr\Ú\É\rÀ¬\ç\Î\Îý\Øõµo¢²z\ÝH\Ø$†6®\r[¶ü\ß7\0[‰TÜ8‹@\ïÂžn\ÄB½jÿt\ïû,•Â¸þ\æ\î\Ý:/oò\'¾…\r\Ë>ò\ÆYÀf0õÿ4 —\Ð\ÛS.0\çT\áG\îŸØ¾±ú\ç\ØwAÙ·\Z\ÅiS\ä±,=c$kd\äM‘‚Œ\Ô\ë\ã\Ü}ð\"³vx\Ë%¤(\ãqlÒµx<s&°²˜A0\Æk‡,\è\èw¡ÄžA¼\Þ\0\ægYñSK h`È„1T¤tŽ­m_4¹¿\Û{­\Ø}pÉ´&’òé©” ‡\â%DÀÈ°—™J^\Ï\ï„¼°X]˜pø\Äj>\n	9•£\Ä$R“–6•b\Â\áG(%tq*‡7Ši\Ö¼*x\êŸ‚¦¹\Ð\Óu\0}ó[\Ø\\\ÝP6(Ÿ\Ò	›Àh·™|\0³È¥Hh‡XòÒƒX¸‹¾C\Ï\àø¬†›W–\äÿ\Ógo\ã\Ïz€/Hùœòpƒ\r,¨ ªh\Ç\çcÿÜ’\ï{ï«2G\àf¸\Ë\áB\0º¼†ÿ\ÓüÁ$€ˆ¾O\â\Ý\Ö\n6Å´U\Ç4‘¼T:!¤\Õ3E\ÑÝ©\Ö\Ñ\0}ŒºAŽ{\Ã`e9‹d*)\î\Ù|\ZÁH\'€’\Ì\ãŸ\Ç>7\Ýd!!\Ù<ó\Ä%Œ\Z€‹»q{XBµx\ËK\êºP~FM@!\çlV6—§½K‡»\Ç\Ñ\Þ5!<F«#]Ë±/( <¼f2\È\äÓ°û4$’	a2QX\ê\r\Æ\Ës\0\nÖ£ôuÀ\×þ\ê\Û\ØRÝ„\êš\í\ØXÁû#*7›&\ÑkÑ²•U\ÛQUÏ´\Ñ\ro/ ›ò#¡9¡qxñö\"\îG\ß\Þ\ß`\è\Èó89¯\áÖ•YH\Ö\0Ÿ\äA™\Â\"p½€\æQ¼ûIù\Ò\â¿uIŸ, Aÿ„¬Ÿ Jò\æðGùó­¯\àMf­@·ò¦rv‘¸ŽžaÜ»|\ÛùûJªõÒ´.\ÅÐ„vw@42bAŠ7ÿür\È,\à…4¼\Æl>¤Sš|Na4’\âP\è™7¬\Ø\×\á³(.On\âù,IB\å \'G\à©Àþ>Œ\ç^†‹\"\n \"ð—\Ý\Ç\ÌNƒ.¢Ü¤.¿†D\"Ž3+t\ãH(~A\Ù]¼]ó ¿û\0þ\ê;\ßE\Å.\îvTnÙ€\êšJ\ìz¤\Õ5,\n¿œ+XiP\Ç)c\ÒA$u\ÆÆ#\ä\éW Ø‡®\×þ	£\Ç^\Â\é%·®®«‡ƒ ?‘úõ\Ù\Ñð\ÍW\n \Õˆ\ä\ã;²	\ZÀ»\ï0\Z–ð¯R›o¿\É\0’Œ\Ù\0‹eƒG³ò7±ó0+w¥\äÍ‹ñ§j„‚\0ôå\Ù.²h\ä\ï\ÔJN*\î®>;–\æ©÷O+±ˆñö$\âõ\"GøL6G\0a-Ÿ?ˆY²’‹´ŒK ›\á7/Ž	sweÁX@NgSò\æó!¿q<$}\æóQˆ\Þhw¢oØ…Å™¤´\ÒiˆW±¡YœU“A\ZEû‚Q\Äô(Îž˜”ô3—_WšG¯‚/L#¦y\Ñ\ß}\ßù›¿‘‰\àÖºZTTl@]ýV<ñõf\ÔÕ“#` ‚›°yk%¶×ª\r@“m¥\rŒ0\'À¯k\0WŸl€x°G^ù&º^\Å\Ù\å8\î\\?‰\Þ\ÆŸ¿¿|ñ.þª‚Œ°:	\Ô 6\Ã[øð£\Ûø\à\Ã[xøÁ\r¼û¾ª8ºï¢œ\Ä\0®Ç¿\Z¯UÿeÃ¦\Ý\\P¡Y\Øb^“Et$:¦g‰ô$\nn=XT\É8˜¼½F-\ØŒŠe«XPò1²‰DDJð\ÇpŸK÷\ÊA«œ\Z4PŽ\ä~\Î\âh¿I’F\éº”\Ã\ÉeS]¤@%n\0q\'¡Ak\É8öG!—”Á\Ã(U«©\\MÌº†¤O\Î\Â\ZS‡q\îDQò†f:\Ü\0\0 \0IDAT˜‹d\ÚÏ›\'\0•AC½\íøÞ¿þ×¨¨ª\Ã\æ\ê\ZlÜ°UU›\Ñ\ÒZ‹\íµ¬	T°41Æ¦:|ûÛ¡ºfƒø(]@\ØŸcöñø\í\Ý\Ð|}ˆù{pô\å§\àÚ‹Õ“)9ßŠ¡\Ã]\Ó\ãŸø?­`(½²\æô\Í7\\\"_\ÌÔ3’t\É\ÌZÁ¬ž_Â¹38{š®\Þ3\Â\ê¥\0”½-\ç\0¼\å!Ž8Š9]<úXÑ“\ÝSfød#\Ðu?ž{£xµ‹³\Ä\Ø\É\ê\É\Ø:¡S\ÎHÓ–J=€p\Ð-U·\Ï\íZ¶GN\Æe.I²’\"™`5@ \àÂ¯ÿÐƒ—ö\àH\ç0œn\'tR\ÅS¬\ê\Ø\×>ŠöŽ¼v \á°Wh\ä|qE.\Ñ4/\"a\Â!\Ì\Z\ÆÆ­\ÝH$Bˆ\ë¤bAUù\ËB:NRH>¿þ #cN™\'¤“\Zú‡H³k\ÉEk :ˆWÀ\ÈÀ|ÿ\ïþ*ªk±¥º\Z›xÿW`\Ó\æJT\n2h•hnmÂ·¿ó\ÚÚ¶bj*oP\ÂBN\ÄBVD\Ù8û$P÷t\â\è‹O\Â3v«§2¸{ý´À¹‘\äñ¹~¦\ì‹øÿC\n~o\Ñú\Í0€¼}GUþ7\éøe\àþ\âtnIBOŸ¤Ð´HÁ\éC\Ë\Ô9Qý’ÁC\×NJ\Öt”ò1Lå©º]søTŸ³B\×ELü\Ü\áôR\ï´p0§Œ\í˜–ûšp®:jg$¯S¾Œñ‰˜†¼\ë­\'€|Ÿ\×\ïC0Ä¶L\Ãôd¯\îBg\ï(¬v7~÷ò\0vXMGP,\ê\âû\Çÿ÷Û¶t£§<ô\ÌgÕ‰Àk†sþ\Ü\èü÷²\àh;ª\Å0[\Ê!\â\är““iX\Ýô RüA	¡\àÐ½b\êù\ïS]‡m5\ÛelÚ²	U\Ûk0d¢•hlª\Çc· ¥¥R˜\Ç*:V÷#˜@\Ô;Œ°«Qoø´¿ðø­Gð\æ\éI¼uó<>ùø®t\0ùü]ü\åO$„(*)„÷?^4’úð2‚®\ã}\Ñ\r¬j\0ñÿ¹v\nWR. L\Ã0\ÃHÿ’;@‹	µª\n[]JûÏ¢‹¿Ç¶ˆž\èòE¨\ÚH¥\ÍS¢O¥\íSz@oJgPP&N†tK?ª\Z\çm³»`³¹qb9§†F\Ü`\âðx½\"§­\ÛK5”\Z‚\Ç9¹\Æi®‡?Â‹{\Æ`u\àòý#®¡†\Z)¢Œ$˜¯\Ì\çE>ž\Ê&…\ÎN«{\Ö8\"Žft	1Íƒñ‘Nüýú\Ï\"\á¢WnÞ€mÕ•¨«¯EuMµÁ¨@E\å&\Ô5Ô£mG6mÞ€b\Ñ\Ø\0t\Æ\ÒI	÷#\ä\î•\rv\Ò\àÇˆ¸;\Åô­›\çþ\Ó\ç\ï\àaÿ>\ç\Óõ\Å\ßGwUñ\Ç\Ö\ï¢\×%YŒ0©\à\ê4P10\Ä\ÔÂ«™¿¢è•„Bù­,B˜ø¼\Ì\ë\Õ\ç\"Ù–Á)\éfŸoL® Œôx=¥V¢ 2&‰\Ëü>Q«	¢2Pc<:{&$N.“!\ZqËˆ·Q\ã\ä«pþff\èÿ¯´ýl\Íg\Ú8©&º˜FñHŸ˜°ce.#l$ˆêŸ\Ì\È7\à&0ƒªp±@`ŒBÑˆ.QRÙ¹ð¦˜D\ÚÀˆ[B>~øÿþ‚T\ÕT\Ë¨\ÚV‰\Ú\íÕ¨­c[¨\èa›·nA]cš[ZP±i¦J\Æ\ÈeH\È\r\à\ì\æ\íAÀ¾‡_ü	\âþ>\\>7ûw.¨\r@€\à\Ó\"\0‘!Ð§j\0$\ÞÁ\ä\0>$„ýÿ\r\Ù\0ªÿ§!!Œ	 ¥\à2\0\"œ5RýR\î\ÄB‡`f6…\Ùù´ˆ&IšP@U\Ë&qC<J«Ç\å7N\r\ÓUDN	s4Lb©1>þŸ9\àuÁ«€ˆ\ãT^‡õ\"pcV$`J\Ö=0\ÎA;ºÝ°º¼…ÃŠ\Ç0­’\Éy¬óx\ç˜¡%Ý¤O\Ð/w9¾ùRB®,Ú¿\n\'°¤ˆ«<A\Ètb\'A8ùÄŠš/\Ð B¬\ëWŠ\åaõÀ6ÖƒýÀƒ¶UaÛ¶M¨©ÝŒºú*4·\Ô\Ë`ˆ\Ç}CZZ›\ÐÜ¢À|>k@ÁžQ\ØÇº\á¶t#\ìR\'€ß²‡^ø1R\áa\\YÁ½\ÛDoŠ\Ú\ç‹\Ï\ÈÀBý\\™B}ü\É=y>b@\"¨`\0œ*\0HZÀ[Jpó\Ú\é2ˆ\àôþ´@5N\0Æ£q\æM‘\è\ì\\\ns‹kJ]‘o\Ê]u´«\æ\×Ä˜i!\Ó\Ü¼xì›¤R÷ü\ÚÃ‰S©ˆgÊ§€ˆFI\è \ÍB1§a¶ƒ\ÕÀð„S eÀ‡½\í\â;HS\èTR1*IøF„MX:•?G‹1fqa\Â\êÂ¨Õƒq«G8‡üoi>-›ŽŽ\ç\Ó„¢Q©˜Z\Î\é`¡DŒ¢E™Wô\Ü\0n8,½øñ“?\ÅFÒ¾iU±›·pT¡¹µ¨¬Ü„]»\Zñ\È#MxüñVlªØ€l\ÆÀ(	ó01\ÔÞ‹0O\0/|c¯\ãÐ‹?AN›Àõóbq\ã\Ú9Ü»\ÍA\ïòË¸w\ÛtýTÕ¾ªúU@»\×\Û7Ï–ü+ož\Ä%¦’tnIÒ½\Ï\Z. ¦V_Æ¨rüòmY#R\äœ‰\Ó×¥\0+¬\"Eôk\é4y\ÌN\Õ?g\0œ°(H\×|Œ_.ƒ\Å%ÿ{mqÐŠHÈ†pÀŽ\ß²¦¢!;†‡&\Ð\Þ=Š‘\ì98€\×ö\"›&\Þ\ï&Q\\÷È½¬Gød\ãB”(kÄHÔ…=‡\áó»0™	\"®û‰¸zx‰x¡i>hšV»Kz|R\Åù\ïŠ\Å#FC(°°,P ¢ü‚ˆ:lýx\ê?\Ã\Æmu2÷7i\á<ú·nÛ†\n\rW ¹¹=Ö‚¯=±U[+Pœ,˜&Qn\è¢4ˆ\æðõ\Â=ô\nŽ¼ô$&“v\Ñ>¸	Ÿ}r_€ \nCH\r7§|\ï÷\Û0¾{	·\Ø2ñ“÷ü%.ü\nÎŸ¥\ÚwA N,+«v\Þ\Ñ\"\Ç2‹ù˜´n¤h¥SAÑ¾gRŒn\åG\åÓ“u®9À\áñL…®.\Ç,7[EÞ»|¤\ê/R\Z\Î\ëW…\Z4±\Ë ÿŽ\ÅÖ‚ w,YXNÊ‘Œ+Ÿ s8D\Â,?f~)J‘zÀ/ºA‹\Ã-\âªƒEfÎ»œ¬ Vö\ÆC&PQ˜Bq8}a\Ñ4&b´–\ç­:SC†0O=Ú·,1©T„£y‰”!7€²0\Ê\Ë8¢žP‹x\à¶õ\ã7¿ý5*k\ZQI;¸\ëgAt\ÃFlÙ²\Ûk¶á±Í¨\ÞRB>§6@Bw \Z\ZUp\È\Ù\Ý\ß\çÀK8úò“(eÝ¸viÞ¾,5\0¡`U¾#õ€¨„>¾\'DB¿jS\\\Þÿ¼ˆ¾U€\Ø\Ð\æ¤ùbxû0\ç‡bR·Ëž;F•oj‹\ë<xTõŸ	µ?–{”\ÍõE\àZÆ\Z\ró˜§˜“±¢‚i©\Ì:\æ\ÕÀ	\ÇH¶ó¨œRMñ\Z \Ï/«>\ÜY˜Q¾\æ‡÷·°Š™f´“%¹F\Ô0ˆA…q Ó†þ1¯„]ó”S\ê!:5=“\Ä\Ì<Í£\èLš‘:€l\â©R™¥d¥\'”˜¹¢\0A\Û\0~÷û§±µ¶›el,o€mÛ¶a\Ó&ò7 ¦¦õÛ«ñhK=¶²\È\ZW\0ý£\á„ýkÀ\Ñ÷‚ˆB\æò^\\»¼(p\î?º§flûþøþø	ž\Ì\ßÛ‚’ùûðý\ë‚< /ÀÝ‹¢ÿc\Ìü\í›þ\Ï\ë@\"`Yù/(Õ¯X­óy\Þýb\å\Æ7U‘.DÊ¯%±¼™uÀœ\Òñ…#”€1\ïo­#0[>S ¢¢]JH¥\è(\Õ4u>K\Í\á‰)ù;\é–Ë„„@Z\Ì+°i’W\åfüœ\äS\Þ\ë\á“\'GÖ¬ø¹ðŠ?˜@‰ÀIª\ÆG(˜ø€\Ë\ëC\"E \'Ò´š)ðQR2µ¦g“ˆRÀ(;žs\Ü\0\Ì¤tL\éøð\ßÀ«†²¾\çž{\Û\ê[±…\ì_«M°•\0c\ÐH²ªª_kkEm\ÅLš pA3.~Agb>X»ŸÃ±\×\Åb\×./É¢\n\ì“{òü‘×€€Bj\èó!µ¢P\Øÿƒ·¯\È\â\ß\á\ä\ïM Ï­\Õ—\èþµ¤\Þz£ú—‰\ß:z}Ö˜¼%QØ.ø|Yl=‘Edå¼¸@±&q\0\Õ\ës˜–.R\Õ\Óhñx«$”œš–Q±?Ã£cª”3òƒ\Õ\Û\Ïô4n€\É7TH=.|© \Ú>u\Z\èb.*fd\0³ÀÈ·h^=Š\É,›@’@\Ô$°H·°õI\Ìð)·ŒtK©®‡\áó\èqJÁ™$F\Ð\'\'I\áôC¢?‚¹	\Ø\n\Êp\á•W_DUCªj\êQ¹©²|ð\Ø77£b\ê\ë\ZñXkª**P\ÈW€\Ï5\n‡¥W¿\Ô\01/ÆŽýG^ÿ\r–KÜ¼|\\¤\Ý¼[x\0\Ü\ì>ý\ä-c3(%0A9ú\ß\æ\ÑUŽ~Vþ&ö«L£\ß~\ÃÛ—ñi\Ê-œÁ\Ä)Ó²\æ”vŸo\Âd>dJ‘\'{h0,\Ãò\çøûœ+[yeŽ\èðx#H$\Ùkg\äMó\Â,.œ›‹¹sFD,\ïZ\æ\å3ADBnYl·Ç‹¡a+´p\Ðp1\îù¢.ý÷>@]†ˆ•oº\â\Ä\Ô[?©Áð£³v—6§v§Ÿz,(Z¿8\ëœLX\Ì2YŠ_\ÃðxYF.«œF\Ä:NcÄŒr\á\ÉÀ\Z õ\Â\ã\ZjxMóNl©®+o\0.ü\æÍŠ$j^õ\r\ØÕ¶[7nD>k´Ñ \r~7¡\Ôˆú0tøit\îý-N\Î\Æp\ë\Ú	s\Å\É\ãú*\îÞ¢¶ÿ¢8zß¼~^>2Nžo9Q>qÿ¸M›\Åû\ã}¯riü¬Æ¾Œ[¡’Ä°Ir&œƒ£¦@\ÈŠ$ŸK2š\Ä\ät ƒ\ìZ0‹\Ó\'0©´.3$-óh/ ›KC\Óð¢pø(Õ¥\0[^`û˜–·˜ PÀŽž\Þ!\í\ì\Ç\Ø\Ä8F\Æ\Ð\Ñ3Ÿ\Û.¿8	;	¹02n\ÅÁŽ!8\í‰\ÝeE\ær+ü?¬~\íñ9`³[\áö’b‡\Íi‡\Õa‡\Ó\ãÂ¸ÅŽ	«CÄ¡))xCBg\\\çt\çÕ‘JÇ„Ä‰\"k	¶ƒDK1?<\Î!<ø†l€mµõ¨6haªÿ¯(o€¦†\ìhiÁ£;v|ùÈ¦\Ü\Ð\Â\ãˆ0%\Ä\Ù-`ððo1pø8³˜Ä­\ë§ðÁû·Œ7ÿ>zxß½‰w™ÿ÷G½W\Åó÷Æµ\Óe¯ŸK«\Çqž‘o}81-w°9\Ë\ç¯(_d\Ú\ÐQ½Q\Üñ©dñ¸	TtõÄŒ¸%\r‹\n7\Æ-\ã\ã\Õ\åF$\äA6B4€\×\ë‘A\Ó\ã“ \'9¢\é*>\ä\Þ\ë\Ðô,v¿\È\Ã-v\ìv>\Z‡6~i¯‚~7lvú‡\'02fƒ\×\ë–£é‚†qž~¹_„\Å)e\æ\È\0)\n@\n\ìLø\ïcw0\Å8ø$’©˜h	òyjý\ÒRøq!¹\ÉôQŸ³\È!cq\È\Î@¿”ŒŠi¥Ž.\ÏJòs¢¹\×\áö}¨m}[·oG\Í:^\à\ZAtZ›°«µ\ïÜªM›\Ö6@*\îD44Š°oAGbnô\íÿ5F:^\ÂÙ¥\î\Ü<-\Öp¼ó\Í\ãþ“\ï\àaý°\0$øc>l\r	\ß\ëMÜ»{AB&„tT°e©¼\Ëd\ÃL\Ñ4jT•¾Bý\Ô|\\…/ˆ=\ìlFLx\ÔB\åñ\êô†\ÄV\í\ì\Éi¹\ëi©\Â^=ü\È)#\ïy:‹Ó˜a\Â\Â\ìŒJó\\˜\Ë#Ž\Ã\îò\Â\ëöH\á\Ç6¯\r\" ®¥˜\Óc!Xnô;×‚XšI gÐ…_þ¾±„\Z\0	ñC^]|øk\ÙTe£s\ËI\ÅS‡\Ð/k³\ä†\à\Û\Íbö±²AXü\Îg\Ï\'+$d\rÀñq\ÉX\0^\ç0:;\ÛÑ°\ãqñÞºžh<[·lÁ®–6<\ÒÜŒ\Çw\íTÀ¼’1¶£B:»ów£\ë‚¥÷5¬\Ï\â\Î\Í3xøþ\rYpž\0¼÷Mûv\0\nò½\"\Ô\ï÷\rˆ\ØÀˆ\è¼<¬n\\=-E\à\Å‹\å0\'6—9\ßVY|&|+\0\ß£\Å\â±\Ï\â\É\íõÁ\ë§N^“ªûôJ«§§°\Ê9ÂŠJ\â0m\Û\Å:þôòùl\î°Ø¬‹9”Š„…•¹óÊ¢’¡•˜\nR\àp&(’²©\\~¿G»G\Ð;0*DÔ¹i\â\rš¢ ¤žúý\ß<\×_0(=\'€J	\n˜©\âQO±x¯¶a\È\âƒ\Õ\íG8\Z]·øfW@\Ê\Zùk ›£\ålZ8S\Ûpr\Z©xP²{û:Ð¼\ë	l«¡<l\í\ØPh\Ã\ÔmßŽG[\ÛðHKß¹[7V¬m€„nG44Ž §G\â¾.t\ìþƒ{°z2;7\Ï\Ê.\'€\ÑöÉ›ÿð–ñö+Ø—o=71.¾pÿˆ\nô«Š@h÷nB²\Âñ£GS;È§\'ô+Jœt™‚%¡Ž\Ò*\Âe<¡!!\É2\n‡;„P$ŽB‘=\Õ×¯žU]\Åz!	‹\Â\é™I\É\nbVN$J½žQ—Xc°²Iôº‹ú1•\ç¢kÈ¦\"*NF´†ªµ\ã“JEp¬\Ï&\è\"8-$ou\Ë\ä7‚:\r¸ò…¨8Œ8ýA\îqÀˆ\âh¿[¼†\è¦|Œk`6=\Æ{žó\ÎB\ÒB<¡\\\\Æˆ“\ê\àD, 5À\Ð`v<öul«R\Øÿú·Ó¦\Ø\ÕÒˆ\Ç\ÚZðxk¾±k\'j*6®m\0·cû tg7bžy\åIxF\â\Â\én_?ûw.\Ê\"S\é\ËêŸˆ ý¸ø5öÿ&\0ô½€õ‹Bˆ<þ\é	\Ì€U·Y‡~¾ô\Óa„*MšŒ=r‘(Ú¤^¦h‰:w%‹T&£}v\è	\æ\ï\Å\à‹¦`ók\É\Î\É\Û\'\Ò\É\Ä`v¼v¨´¥¡\Ô\Ü\\^t÷»\ãVN—A\'³a‰r\é±`\Ôb“ù©¨a¾¤avšªžJ\ìýó$Š’\êÆ¾ö1::‹Œd¶}FÀk€U{N]¬^\Ý?‚G\Æd˜Ä‚11ñ8[N\nPy²‘H„e\ÔLR\n‹Cv\äDb§@?AË˜@Ô’`|´~ý¯±­¦A \ßõ ¡¶\ß\ÜÑŠo´µ\à›m-øö#;Ñ¸y#¦\Ìa±‰;XÀ\Ñ¿£Qr^ú)B¶¼y¶ˆ;7\ã¢Æ·\\È›\×H\í¦\á#û{¶yy¬\n\é“…O0\Æ\Ëñ\îg„t7\ÔP1.†™3\å[ü\Ü†\âøS Ñ²{†¢H	\rK\è\Ö)_,À\â\â\ÕŒ;#(•\n2[XY™÷\Í@”o JxdgX3!\Åž~yG‡¼pº#˜›\á\ÄOG4\ä‡\ÓeG,\êAš˜~\Üº§º½[\Ñ\Ù7&Å¦\ÃI\í¤1W¦]°ýg^\ê@O\ß\Ú;†ñòý°Zˆ\é\Ä÷9p\"\âã†nb^<óJ\'ºúy¥\Ð’•?5š*‚\Ù\nf\ÂHg£‚pòô O [¾t–¦\ìšï€Œƒ§Jr\Â:1„\'¾õ]l\Û\Þð¥ÊŸ ýo¶¶\â›m;ð×»v\â;=Š¦-•˜2¡\àtÂhpgŸ\ØÄ‡\í8üòO¡¹ûp\é\\	÷n­\âƒ\×ñ\Ñû7ð\áû7Œ\ÐGÂ»oÊ¢’\Üq\åM‚;+¸xžÏ¢;2ÃZlFµ¥m#\æ\Ï\'_\Úÿ+•J…\Óý\Ðu¢ºW>òaõÏ\ì¢Z£«\Ï&ô1\"\ì½\Ù&±\â—B\Ìñ#;\0Ž`{,860§Çƒ¤î“¶/°ˆGrÀkE\ÈgE0`C<\î\Ä\á\îQ\é™@8JkY\ìz,ðû=ÒŸ3ü\é`\ç8\\nVOfpbAs\ÉõŸ\åT¯˜¿—sŠ©R™ŒŽþQ/ô9Dþ \ÐLZ `ú6—¦S\âv*¡Þ¤§/f%C`zš@\Ú\0\Ê%¬(\"\Ö\0v\Ûþú»#q0ò\'\àO\Õ6\Ô\Ö×¡­©_km\Ã\×\Û\Úð\íGw¢¹rJfN\Ð$r>{¯ A\ÛA‘…\Ç|ƒ¸|~F\Þ\æ÷.‹º—!<\ê\Éò1G¾ò¼{M€L1\Í iu\Å\ß±¡÷Yªmjò„ƒ¯\Ø4’\âÁ‚Ø·GW@^üA\Ò{Ÿ¸8õ\Üd\Z:³$L\Ü@);I\ãF*g\Õ\ì\ß$”š†\ÎvoýcAU\æf\èlø\äB\Èf\Èf‚2ð‡\\x\áõA¼~p}£N‘m/Î“\ØC&­p‰¹;\n7vE\ï]C4Ÿy8g$\ÈU É†L¥5Ž¹\ä#;\épŒaµ+ˆõƒãµ—\Â4YH<\âB\r\ç \0Äjøe¸œ\ãø\î¿ú>¶moÄ¦Jm¯®F[s3\ê\ê\ê\Ð\ÐXÖ¦&<\ÖÚŠo?²-›+Q2O\0;Ÿ½AW7\Ö}8ôò?\"\Ã\åó\Ê!ü¦„Ü¿\"\Ô.z>¸R†|ÍBýÚ—ºÌ‡fP”‚RN\ë\Ý<×¬[\Zh5f³\ÊÕ‹qmV˜\Ë\ÂÇ…¾xaC\ì>hGºX@i&/Qr¼ZDCHl\ßôHò¦õ’E\\,f0l	 ª05IH9„L\Ê/#]>¹LP:YH\"\åýÍ£Y¢õ8\Ð18ˆ§(Ñ²\Úi\ãÁˆ\Õ-\n¥\ß\î’ò\ÔP\Æ\Ì\ì\n\Ç`sûñÆ‘q\ìï´ gÄ89†Î€\á\à\ÉõƒJ:>M¶ðO\0~žÁ\Ò2¯¶‚X\ÍR\"žˆy\áqÀ\ã\Ç\ßþÛ¿\Ã^•›±u\ËfY\ì¯\íØ‰G[›±«¹mM¨¯¯E[k3¶Ul@1·n\Zö\Âg\ïF\Ð\Õß„Š‹\Ï\éV\\>7#nžoß½,_d÷°\Êg\Ï\ÏYð©\Ï/+\é7\ß|³0 øý<	Hýb!& cQÄ¦\Å\è\Ö8yŠ\'/\îtú¦”z!+DŸV\çQ\Èg\Å\àÀ oŽŠo3_’\ÃM²Œ\Ü O£\èŒh™\"X-º¹ðkƒ˜.jµ8\Ð\Õ?Ž,Á¤¢&§‘€WTùL©ÁÎ££X˜#NA²)Iž\\H\"–¤ƒÇ…	Ä¿k’C³)Œ\Ù=\Z÷\"žNÀ\åcÁGD2-×€9\È’I@ûZ^\Ä>()’² F\Ç\ì–dH8¿ÏŠü‡ÿ p€ªj\Ô\ÖÖ¢¥¡;šñD[¾Å»\×.|£µ;w´\È	Á\Ø:\Ù\0N[|.U\0²p¾.²ðÉ¤W\Ï/HˆóË§E\ß\ÇE—ãž˜¿Aõ\âõ o?\'bü°Š»4€ºf\ÄÀ\Ñ\r\ì\ÚY‘~›’¯õœ}\å\Ñc5(ÇŽ9\áä­…9ñ¿\åðÈ´Že‚X2“B*“•(¹3F,Œ)(1G\Ë9¾¢\ZÊ‰»§‘…y|ûýÈ™›!\ÐT._À‡Á1‡P¿fg	Os\Þ\Ï7Z\ÃÌ¤Ž¸Aÿˆzœ\Ó=2yøû\Ü(\ê\á\Ý_$:\È\"/ET \Ô\n§S¹\çsa¤\Òôô#g\ã´3ñ\Â\ëó •T_O¥üð\ØÐ¼š‚Ø°lº¢\nv9\Úð\ïÿþ?\ÉhnjAS]\ê\ë\ê\ÑP_‡¦úz´46bgs3¾¶£\ß{üQ4oÝŒ¢y00*\è‚\ßÙ‹°«®\á\Ýh\ßýs“.\\9?«—NHb»K«Ë‚\ç“\äÁ)Ÿ<7\Ï\Ë\âSù\Ã€÷o_À}B\Þ`7 x€\Ü\0\âù\'\âµ	LÁ†)öA…LS\å\"ˆw>UCœ!œgd\Ü\ê¼Ø£t\rz\Ð5\à[F©’MLC©5a¯\Õ!Ì·\Ð\êò¡oÔtB\Íû³\é\0’	Uù§^0A\ä†CuõY°§}T eM#\Ö\ï’9@”8\Ð%œüCGGðúÁ>\ìk@{÷0l6¢a\"«±“	\ä’\ï%}[\×ü\Øwl\Ã¤¥	üM\Þa6«øþ¼2¹8â”¢Í©\"‘Sdó„\ãß˜²\ËI\èJ·ñ÷?ü¡F>\Ò\Ú&\í\Þ\ãm­x¤¥Y\nÀ¦ºz\ÔV× zûv475aË†\r˜\Ì¤\Ðd\Ì%£`Ÿ£G6€½ÿ%|ùg˜\ÉùpùÜœ$zòXga\Çc]\\=.\Äùsw\Ì\â¼Tüdü,Šôû4£\ßN\ÎIc\àÎžY’<\àõ=%\0!÷Ÿ\Ä	£\Ø+¨¾9›ŽŠ8‚Œ †$M\âJ:NG-¶‰|J\ÊZ¥P £~P|\Øks¡¢ <œ»ŸÈ»GÇ¬x\éµNŒ\"\Ì!˜\ÇŸg>7³’,\ØXÓ\è\ÃKoôbt|\\d\Ù\"Þˆùþ\Ü/\0‡;I³a\Ä\âDßˆ^_°<–r%\Ä\å!\Ô7\ê³é•¥,¦\È”\ÂOÿ\Ä?\Ø\îfó	\ÄÓºLAI™cœm&Žb)©¸’†\ï \É!¤ ¹\ìƒ\Â\rü/ÿ\íGb\Ñ\Â7½­\ß\ÜÙ†¿jkÅ·¤ÿo\Ã7\Ú\ÚðhSZ[)4m\ZDÄ£\ä½\r\Ãc\ëD\È\Ùk\ï8ø\ê\Ï\Å\"ž€U<e\Ýl™È»žõ€\éü\É_—Éž\×\Ï\È•ñpWpau\ç\Ï,‰\0„#W\n!I·–H7R†Ë—zB\Èr*ü¾¨ü\ÐùV­\ã\0D\rArB•ù\07…\Ì+Æ¿‹&OÁ§æ¥¼»\ì1`2\Ç\Â\Ï\'o~Šo}ŠW\01ª„TZ\ÛPMI\Å\Î\âOŽS6.ô/ŠEcþŒ;¼8:‹\åy\"‹$xª\rÀ\rHF±Br:¦§\ãðø£\èóH\"X \à‘¬ \é¦‰þ%‘\ÉÅ \'550\âI8ŸE<•À$½Er¦\Ä,L¡\ãþtÍøñÿ”\rPS[‡††´67bW[3oiÁ\×\ÛZñõ­ø\ëlÁöŠ\Èg\Ì\r 9dxm]rLt=‡Î½ÿ‹Sa\\>3ƒ\ë—OI”›Œzo­\Ê\Ï\Ó\à»\Ê\ï‡¡_	‚¸C\ïUüñþ\çÑ¯­¶\Ò\0\0mIDATx\0§\Åÿo-Ù‹P°\nU\âH–\ÜÀEÚ®Î©™À	†-,*!$\Ã \Îñ´9;/IYt\r0‰SÃ„\ÔAÿ|•§Gÿ~\Ò\Ë\å\è_Ê•=X˜\çW>\Ê\"Ž\Í\'\ÄRn’÷wT¸‡\Ãcv\êW\ÂN\ã\ëü}.þ¤l–(2©(z°¸8­‹­‹Œ°z™¨6€bY}pz8\ÒeÃ³¯\rCO¨PˆI\Ã]\Ì\Ü\0‰tLX\Ñ3\ä-.(\ä“(&g\0\ê\n\à”À) ¦¹ð\ã\'‚\Í5u¨®¯C\Ö\rhijÁ®–<\ÒÚ‚¯\ïhÁ·Û…\Æ-_Aƒ\ÞAøl]\ÒŽû=z=ƒ•i\r—O—p\ã\ÊIÜ¼zF\Þp\Îü\Ù\ßsð¹O\Ç/\Þõ\ÂüQQ0tÿd\á§ N9” )`&ýJ„†À\ÃdÿˆIM\æI“þ»f6CO\Ó0\êÌ¬LÁ\Ø\Î\Ìå±°8‰³\ç¦\ÄX\ÚRJ¨ô/Ò´I\Ø`0†¹ø9>Ÿ\nˆ|‹žbÙ‘D‘?8ð™¦,MŠ:\å.\"¿/\î#\ÌLiðøüxv÷ u\Ùð\Ë\ß÷ˆi4!k„\Ê \Ë ¦\Î2¬*Šýv\èñ(V–s°8È¤t!‹Jh\à\0L!\ë‰08\ÛPb	<54\'¼2#À\Ö=\â\Ä\Ï~õ”l€\Ú\ÆF´67£¥±	Í\Ü\0ü¼»ZZ±«µ\ïÚ\êÊ(\äŒ.Àm\ïG\È;¯¥!Wúý\íÀñY]TA\çN\ÍH†ô6c^n^À[·\Õ) |\ÔK½?‡=TýÞ\r ÈŸ„)§ú‡ÅŸi\ÕfŠ:”B–‹Om}\Ç)†8AÈ¤¤drÁÍ…\'üI\çð\Òl6oþHAM—·ž)\Üò‘þò¤¢W}ZÀ¯½ýQ\äRe™b:h@¾NÌ¿¼\Ð™“_\'ºXö4\ÝC¦(	\"\Z	\âøJ\ZV f\Çü!K™f\Ú\Ä0\Ü)pKQ<N´3\0‹Ý‚H\ä‡z\"N\ÄtüA7¼>·J+M¤Šˆ>1ž©Á1\Ò\á’õ\ä°õA‹8ð¿žþgT\ÖÔ£±¡Y0€G\Ú\Ô[Ï·\'O\æV´6µ¢¾^9„¤“Fz¸¶\"\ä16€³\Ýû~…‘Î—pb.†‹g¦DrM÷*FžœZ™\Æ\ê\é\\{S\n\ì÷\Ùúñû—\ëg\Öjk§\Ë	 \ÐüÁœ¨\Õó/\ZM–W\æs8Í :ƒº\Ç\r 2TX„:\êK\Ó„ôÎ­\Î!\Ï#O\à£\Ü8ÿ§\Ðtž<:2mùf‘¦­—G¿>\rŽ_.«ú~\Öª1ž£bƒª\è#!%\æú+û«ü0y”.!ŽP;\áõQ;\à’A8\Â.Cª\Ã\È&ƒ\È2£9Éiùû¥£(5Q³\â=B2ä§#Á F\É%’\ä	\Ð&\Í˜ó\0«tx\ål\â\Ù\çŸÁ\æ\í\r¨©kpgkv\Ê\Ñ\ß*Á­-x¬¹m_öˆ†\Çt\È;;\Ñõ\Æ/`\éÝ“ó	\\<9‰ë«‹¸\Æ,?š80\×÷Ì‚²G_šÄ©•’ø\áò\×J`IfrýØ¶QõC\ZØ²´j¼÷\ÙóË±\Ï!\é\Ó\Ì\×%HBƒ\É^s*!{Itð|x()ùð¦.Nò\Ì\Î\äZñâ˜™%DJ´/-I\Ý,®ry™tDŒž\"A;üž	\Ð+\è³J\ÕðZ\áóYð\Ó#Q	A\ÊO\Ð&oX\"æ‘©›ùÐœ‘­b.\Íñ±²ˆÔ1s\Ül2PŸK…Oµq\ÇÉƒÁ:\nùz>\0^±„ŽL>a˜WódL\Ë×¦ŠJ\n\'\Å-õ‹“H\êN\Ñhš/½ú¢\ÄÁl¯W÷~KKššš¤ ¬¯Ux@[C=Z¶«d‘”¹´\Ð\î~x,9Ž¡c÷S°õ¿.\àÂ‰IA/_X’£œo7>ó~õŒ`4z¢±£º\ãM­?7T\Ø3]?yªuøvÑ\Ô/\ÎX¦\ë[@DK¬Œ\rò5u\ÅuJ!¡Xó÷\"Fx\é\à\\~²9þÀS²\ØtòŠF\Ý\Ð5trõ\Âv\èô¨	Í=c\êI3(šðožœ.œC‘k“FfÿRù«\âOñ\r®bA\ÇtA\Ç\Ü4Û½µ‡z†R/þ[\ni\Âõ\Û^!Žrwþ9\Ì\'\ç‘h“†Y¤E²¾4K\Ëþ-$³\å( ¡»dD5v¿±[ ª\ë\Z\ÐP\ß$‹\ßÔ¨ž†ºzl¯ª\Æ\Ö\ÊMØº¹ò+W€~{/Ü–cÚ\â\Ø\î§\à\Z\Þ\'`u%‹gKxó¼J¡š—÷»òú§\îÿ”AõR~r\ç\ËsB\Õ\0\âN e$õÒ¤‘ \á\Ó‰K¸a\ËzA¿óŽ\è®rƒ\è¢2„g`÷\Æ1h\×1l\×1\î\Ò\á\n° \"¥Œ|zzü;H«\\¿Ir\É\ïjhXr!„\ÌP>T‘8¹¾ð32\Êg\Ø\Ï\åu\äs\Z\"\äŠ*\ÈtùR…¡`¶±Í ˆ9ln°f\Ù.\Z¿¶\â²J“)\å\"Âˆ8úf8e4¢\í\ç\ØÙ°\rT5€\Ó\Ö]sb\ï=\ØZÛˆ*\"€\rMhllDcCšš\ÐP[-••¨Ü¸5[S¸\Ì\nö\Ùz\à±t\Êð\Û\Úqô•Ÿ‰1\Äñ¹8VW\n¸tv\Ï\ÍÉ˜WŠÁ\Ë\'\Äð\í!Ozýˆ\Í\Ëee÷JÔŽ\âûk8€\Å\ã\é °,\'†³¦Ð·N•d‘¹ð¦B\Èôú»#\rÜ„y\É(ž™+`O§\ÇW¦¥»H¦\Ó³³R&h¤úq˜\\Tµ\Ð\Ê!$\ÇHx~”#<(ü?B¿ü}\å6n\Ô\n‚(·q\Ö\n”\ÌÅ—)e.Š\ÅF\Ðù\Ð5\äT\Ìeƒµ¬5`qÖ£ð}‚\ã\Ë)Á«€r8cÈ‡…#	¥is\Æ@¤R…N±\Ô	G-œ\æÒ©0ŠÅ„*£.8-½²ŽvDMC+ª\ëšP\ßÀ I:€\æ¦TWm¢…£uõò1—36À\ÄÀ¸ÆÁ5~^\Ë™x\'Ú±2«\ã\ìbg–ò\âp\å\Íey“¯\\\\‘š\à\êÅµ\Å·/\Ã\ï—¿©ûgˆ\é\Æ\Å\å0mUyð\í\çMš˜t	Æ¬@\ÝXxó\×j\ÊWÂ¹\Ó\Ó\â&r¸×‹`4…\Óg\è\"–ÅŠ¸w\ZceJgRå–ÅŸõ	³wf2ŒiVýl§\nQ”(1ZDI\å\ÔO®\0u°\Ý#X!{|(\×d\ÌÔ±@(Œ\å\åô!G¬\ß#¢odA\é\rz0jµÀô\Â\ç§”\ÜŸÿ.v\n$¥ÅŒ&–ê´¡	\nkˆ:\0M#\Z\rKÄ´—ü7\Ð\Üp\Ép ·\ï(\ZZE•l€4\Õ7JX»½\n\ÕU\ÛDX_Wƒ¶5J™F‘\í/\Ã2xŽ±v¸\Ç÷KV°\ßr‹3\ZN/f1mÈ›X©Ÿ?;Ko—\à&O\éñWŒ\Ç4|V¸½xÿš§À\êbY~­üu³ò–sñùÈÇˆŠ\å5ašC«·^=,\"M²\ç\Ü|CQ\Ì.RKH‡Q\ÕJš\Ö0 ±ú\ç’\Ë\Ç7‹>2nÇ##ðûüðú|p»=ðùü\Â©‰œ:I4Õ»\ÝI\×Pzø(º8\ë‹p\Ø%ö1/\ïÀKotË‡¬\"-ì„®9fÍ¡{d\ã\rz14:!ôò®¾qôZ…\Þ5\È\Ô2·´—¢(2­>X™#q\Õ\ZgQœL!•J`y.\Å\Õ>\n\æ,€@:08Ô–$†\0j@sc3jªª\Êb\Ñ\íÛ¶Jk\ØÚ º€©Ò”\Ú\0Gwÿ†º^‡}\ä0#{„°\Å|1Œ3‹L\Ød\ëfü )\×2þò\åer\î8j\å\ÐeZ¸¦\Ãtº~ñ\Í\àâ²¼\ÍÊ°¹ {¦\Ð|˜°:ó<xð­7žò	`\Ð\Èø÷\Í\Ì™\Ìb÷/:‡ƒ‚”‰VP\Ð1\å07\Ë\Ä\r²hÃªL˜\Ø÷wŽ\àù\Ý\Ý8xt{Û‡°\ï\è0ö\Z€\Ëm“\0\íPÐŽPP}nsL\à\à\Ñ~>6\Ç&\íÇ¯l\ã Áò\à\Ñ1L\Ø]›ðb_‡û;\ìðü2\Éd\áJdOO\Ð\á#Š\Ò¿\Æn\Zÿ¸=œ®@y|<™@0\ÄS\'¡¬\çJ)I6+\ätez\n\Ê\Z\È	\à‚\Ë\Ò=j\Ç\ÈH7v=ñW\Â\njjjFC]6ô°ª­[\Ð\ÚÔˆ\æ\ÚZ|÷[\ßÀ‹/<‹>x_m€C/üý\í/\Ã:t\ÖÁ\×p\è…\'\áŸ8‚RÆ‡“sœfH3y\Ï\Í\ã2\ïvúù™\ÇYŠ>N\Í	FOÀe–X6\r™d”\Ë6)2|(\Ë\"s—iA\äXqst:\ÇTIñþ~\ê\Ü\É(ò\å‡{*\ÝC–3ŒX#cÇ1»Gzm\èœö,\ÆÌƒ˜±˜[8}\Zµ÷!§´w~¶z+Úõbd|Tðº~$b>\Ù\â –¨¢Ð¸ûgŠ\Z‘ ^=h\Í\í\Ã2)_\Ó\ë \ÅFÇò6\ÏÍª\ë\Z~’7ùó>\ç¿OOF\ÒBHeâ°¹<ò\ï6\ÛErÿ”¤]Á\Æt&%%\\L¤ˆ\rL%±À\Z¡—ˆ9%”Ucòå…‚8¼º¬]ˆ\êvŒMJ\Ç\Ð:\Ôo¯Ã¦Mb·u\Ó&\Ô\ÕTcÇŽüô_Ð|©ˆO>ý£\Ú\0{þðKô\Ê5°=/\ãÀó\Ü\0\í\È\ÅXœN\á\äbA‚‘\å\Í>;\'\àÊ…eIa\áGž?e\Þ|\ãM\ÓG\Þ\é¦\ç9¼\ÌÞ\nz }+ƒŒ¨µöðü}\ê\áUÄš¸bòk‹Yõ\ÎðZ¤—°a\Ø<DcaAë¤N \Ù;jv\ÏûŸ³÷\ÙRý\Ã6\é:û)v\\p3^F\n@Uðñ\ç\ç\Ï\ï\Ç‡­8\Ö?h4$”5¶€\Ü 1=‚÷Ža\Â\áB<–\ÍÁÀL\n\áÿO‚ÀPµ÷\Ø1n÷\"M’\Ét\á(Å¨\n6ž/»Hˆ19ƒbIOl„\æÙ¥t¾A\ÊRžW\Ý\â‚\ÑZ»¡E\íp8Fðµo}[Á\ÐHJ\ÃxôoÝŒü\à{8\ÒÑŽ\ìd\ÓK\Ë˜°\ãÊµkj¼þ\ì?¡\ç\ÈK°\ì\ÅX\çó8ø\âS²’‹ü1›iÂ¹?7‡7\Ï/\à\Ò\ê._0*üóó\Ê\æU\Õð\á¯Ë… +Eù~3€m\ïž.f\"7\Ù\È}oý\ëm\ßù‘\n5BMAO\ÆÑ˜¬¥LŸ$ÿWŸ9CTöubª†\ÍfG  \ä_|\ÛF‡`>„‰\ÍvP¯7\àCg¯\r©„&lžP8 ­\ÝE(!\Ã\èp·P}Œ9\Ü¶OS\Õ\×3(\Z‹\"‘\Òð»Ý£\ØwÌ‰7:\ìx½\Ý«Ý‹<i\ã©02\é\04=\0§Ga#Bù¥ ¤“›\Í\éúx2\á“Bs5@\Ì­[ `žr\ßø\Þ\ßbsµ’ˆó\èokiÀ¯~õ<>òEZ\ë&q\àð1<ñø7‘\Ë]Àž?ü}¯b¼†>‹#¯ük\â¡\ä±1;}|Jõ\à\ç\æ$Íƒk.´\nz`Ò‡zó\Õ\×T?Ï…fr‡?V\í¢\îu\Ö\0\ëÍ M÷®rÀS·„Ï¿\Æ\ê1?—þ~.#ô)‚Ft\ÒfK%,þŒá¹\Ø\çsH»\Ç\Ó ¾\áy†HI¨º…2@\ÖO1\n-\êGw¿]\æ÷Œ†¥\ÆÏœ\ïó\ÏžðÀ\å`n.ŽùYÆ½11TÂ‡¤\Æü†\Ü\Â(Ž\'|xyÿ D0\â\Æ\à(Å§ðúHSó \çóÁ\îpÊµ$s€Œ2½\äõŠD„\ëÀ€~1dÌ­N\0RûC|\ëo¾\Í55\Âþ\îw¾…÷Š]<I)\Û ~ô£ÿ\Çwî’«¡lq\à\å\Æ`÷\ë˜\èßƒ¡Ã¿\Ç\ÑW‰­±À0a+ô°Laÿ\Î\Å\ã\â^º°`û*\âE½ñ*õ[™>3öE\rL›ß¯€ƒjøõ­Q\ÄT¤‹°„W¯õ€\äˆ+!Q.6ñþi\â\æj¨\ÄcÓ”j›S;.¬\èþy¿gHúz2pòü¨\é?¾ù¾ˆ¿o6‚T\"‚q1\"QAO÷ ñÈ¯G\',xqo/ž\ÝÝ—÷öÀ\ç§\Û:²€|ˆ\é^DuŸˆM2™ ú\Æ°¹|\Â1$…ŒN\äôÿ‘¹E).j%J\ßi]#Zbo•\"J\ÓÉŽV\Ê`n\â\0û\à «K‹ºð·ÿö\ßaCe~ðw\ßG_ŸH\èÇ­üú\é\ßc×£KWðX[+ª\×k;ö?‡\á\Þ=²úþ:^û5\"v\Ú\Å\r\"w©0“¹\×8®=s‚•ÿ¬,6­\Þ/_\\V\í `\0\Ü\æñ¯ž§†y-°\åSÞ¿Ê¦Í´r1-bLkøõ\Æ\Ï|L›\Ó<r-æ…§E$\ê©9£\à \èBT;G‘FLc‘\èPFP;‚!‚AA;d¬…\ìB\ë\â\ïqQ\ã\Ød7À+$ÁÀ¨ûÁ\åñJ~€\Ã\Ã\"/&÷½_5\ä\'\ãð…;«@Â¿4Œ\à5GDxÊ«‚_ç† \æLh—/€\Ñ	h¸¢1\ê”^q\0a	\ÛEòƒÿø±¡b~öóŸ\Â\îv\ãµ}ûñýów2¨\Û^‹Úº:455bÓ†\rÈš\'@ÿ‘W0Ú»\ãýo ÷À\Ó\è\Ùó4\"\ÎD\ÜýH„-R,É”î¸Šj‘\"l.\'x·x\Û—*w—Xµ¢n)\Z—r¹\à0‡R-³§ç¼€÷8r>òFs^ v\éF\à‚p\ç•%Õ´¢\ä1€\Z±Vd\ìŠ2ˆ\"ZF7­$	–téŠºeb\n\Ø\n0ÏŽ Ï®º?\Åiõbš‰¸G\îUªlH\n-\äCe€ò&PTpi×ŒŽ…\\š¢\â—\0Rñ\Ð0’/•\Â\Ò\Õpv_ˆ\Ê@Š†©L\Ç\è\èµ@‹\å8§\ÎQ\ãM!y\0¬¢\ÐQX\ìn\ÄR1X½~\ÌN§‹ó\ÏNŠ‘YA2\r@>€Cþÿ\Ïˆ\r›«ðÿý·ÿŠý÷Ÿ ¡¾µÛªdLZ87Ac£¢„™@\Ðÿ\Â@ …‡D\ä\0\0\0\0IEND®B`‚','Local Drive','2023-12-16 14:17:15','2023-12-16 14:17:15','IGH141585754362','IGH141585754362','image/png','Image test','WRS695055681927'),('KBD449513637878','4a047a48a19c6608bf0bcdda5efb1d787e23ef3f.pdf','1BH1UcKUGTergI_rw-uNEBOj0yO9YwW10',_binary 'ÿ\Øÿ\à\0JFIF\0\0\0H\0H\0\0ÿ\á\Ühttp://ns.adobe.com/xap/1.0/\0<?xpacket begin=\"ï»¿\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?> <x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"XMP Core 5.4.0\"> <rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"> <rdf:Description rdf:about=\"\" xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\" xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\" xmlns:stRef=\"http://ns.adobe.com/xap/1.0/sType/ResourceRef#\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmp:CreatorTool=\"Adobe Illustrator 24.0 (Macintosh)\" xmpMM:DocumentID=\"xmp.did:98735475FA8511EA89BFE7B9788F45DF\" xmpMM:InstanceID=\"xmp.iid:98735474FA8511EA89BFE7B9788F45DF\" xmpMM:OriginalDocumentID=\"uuid:5D20892493BFDB11914A8590D31508C8\"> <xmpMM:DerivedFrom stRef:instanceID=\"uuid:0d9d49de-7883-1443-9854-bec3d57dcceb\" stRef:documentID=\"xmp.did:33a4b93c-befb-4864-832f-88d69dbdfee1\"/> <dc:title> <rdf:Alt> <rdf:li xml:lang=\"x-default\">picto services aÌ€ bord</rdf:li> </rdf:Alt> </dc:title> </rdf:Description> </rdf:RDF> </x:xmpmeta>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 <?xpacket end=\"w\"?>ÿ\Û\0C\0	\n\n			\n\n		\r\r\nÿ\Û\0C	ÿÀ\0\0€\0Z\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0Q\0	\0\0\0\0\0!1A	\"Qa#2Xq–\Ó3RUWv”%89BVr‘¡¢¥´µÁ\Ñ\Ô5ST’“±²\Òðÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0=\0\0\0\0\0\0!1Q\"Aaq‘¡\Ñ2S’±RrÁ\Òð#34BC\áTÿ\Ú\0\0\0?\0\Ç\ä­Ñ½!\Ô>ó\rk?\éVO\Ì\Õ3œ¸­K¬P\â\Íyˆ0”J\ÝB”µmu(øœ(HQ&\æH\àyœ\å^\ÈhÆ›\n\îXˆ\Ô\ê¬aY)ŽË©J›ø\Ñ³Z”›!\n+7\×\Â\è“U©V\Ó~\àJ”\Ð\ÝTXà¨¸\æMl”€\r÷E)Ò»s\ç´\Úö8‚\ß(\ÎLõ\0¡q¯<\Ð#´­*U\éRO™£\ÚV¹®„8\Ëpr\n^J\Û[…° ®\éeY`…\É·XLo\äÁ\æjFg#Ÿ\à§ôNøJÌ°…K.h–‘\Õ\"\î\Ø^‡–©%*°V\Å¶v¨$”›qq†hª8ž\âS,ð\á5Û…üŸ£t\ÈôŒ\Ñn\îõ2[t\è\Ô\îý— °½‘ŽR«-*t\ÙI\ÜVz¨¤¥…\Ô¸R\áe¦\\tpÍ¥k(IPHÉ´\ë›Ÿq\Â\'4f !\ÛC´»FuS\Ô\Îo\á;Lh°\×I}\æb“(Q\ê«se;‚	?$¶ñ\Æg\Åoo¯kQ¹¢X\Ö{&\Î\×~¢;—¢\í&†\áx^k\Z‚¡\0ºZLA\Ô@˜ž²ª\Ï+¶ˆh¾šðÛ–\ëºs¤9+*ÔŸ\Ï\â;2‰@‰÷T	\êSJq–Ò¢‚¤!E$\Ú\èIð\Ó/9@‡šQ“5f\\ª\ÍUq\ç=¼½Tvi³´­*\0sY7\ë‹Ô¨\Óu³ª8k+a³ø]•\í±}\Ëd\æÀt£™øj\à²^†\êMB‡\ÃuF—2¶L«U˜“4O¨3öb¸[³Þ»=©u![T…$„žJ\0\ãÛjrPe\ÆÉ»¡é­ª\ÞL\ÌH-$\ÄÀd\Ç_	…ÊœYXô°!uƒmV¥T87‘§´©y–ew,\Ä}\å\Óe\Çeº~\Çj:W\rm€óªBõ…«’¹·–-\Êm{/fJ»ŽP\ëIM-M7¨Á\\À\ÝK³%-­Il„4\ã}›€…žAi±µr‚\êÔ·¦U©\"ˆ\Ú	Žô]p¡\Ö_nTt]	ZÃŠm\Ïp‚N\âA›Ç¦XÈ™[Y©\ìdJ<ªZ\'\ÐZŸUˆüPÀj¢\ä©]²Qd#z\Ô\0¿ZöùF\Ø†ü]h¨yK5Ö¥øeLˆ–\ä6¦Ô¤@˜\åyGž=s\ì÷\ß\Þ\ßÒ¼»\í¶!÷\Ü\ïÔ©œ\é\å\×\r/¨Rjt±’2]u\ÒÜ¸2\Ô\ØSjB†Ð‰)û\ã~~Î˜\È\íVmò>Ž\çù§1v]\Ð¨Ù¬n¾1\Êò\íhË– ™\ß$ðT\çP½h\â\Ï Sô\çQ²\ÆJ§SiÕ†«m;D…-—\Ôûl¼\ÊR¥=%Ô”m²@H7	\ç\ÔŠÔªw*f Sœ«A®¢²%!MÑ‹\ÈsrSe¥Jl\Ü„\Ú\ÆØ™µª1†›N…t\ì1›\Ü0eµ~]gp:üA\à§n\â\Ó%\å<Ù—)²+´\êk¤¿K\Ì\r¹–˜(~\n\ÚZJœ\\rZ°T‚’/{‹Š¬¢\Ên/hÔ«¶\Ñ\âx\ãNþ®pÉŽkDNÿ\0dEbE\ÄKX86\Êp2\ç¹K9\"‘U•74y\Å=±®­ÈŒ¦=JJU\Äöl5´…/b‰YH$c\îy\Ó\Ú\n¥/2i­+L\Ë}ØµX\ì7òWÚ©mº´&\Î%%%$\0’z\àBe¢\Ös^Y\Û\"NBZ\"FxÉªL˜Ë¨Ž\ÛA½ª`)µúÛ‹j¸)Y¤” B¼¢4\ÔSu¶‘\ÙIžóR²\ÌyM÷¹‚F\Ä*\\½©lö\ï6\0\ä‚PG;¡7\æ!¸»\åV\áƒF\é\î-ªnHŠPˆr{\Ãm\Óu\\v\É\'ž5ôv·y\ç\Õ\Óð·ô•…­°x\ÔR$õ\Ô\ê\Äh-¨±ª\Z9“km¥\å¬&³Š“PT•¬ ‘\É<‰#qB¾*C¯\\Z4\Ò\0ž \Ññø.®ƒ\Ù\àMspúA™Œ»RIÚ—¦±ñOð¸p\á†ki_£Î—¶µj\Ê\ÔÒ¯\æl\ã†úe†¯½•Â¾‚É^FŸÆˆ©J#Â”üX\í€[i¥¥H\0\0”€Ÿv\Zœ«n\"¸eÑš€j]z••žbe7\'V¥\Ç_œd¨%\Ö\á:¤(…8A±—L!J\rð\Ô\ä°!u„\íO¡#„\Ý?\Ê4<ª¿„tÕŸzj˜hµ ¹:R›*U÷ú›\Ð9ojðý”­h\ËÁU­˜gBG\ä°x¾\Þ\Ûa8…L8\ÐsœÈ’Z\ÓÚ¬]@\Õ¹¢´Á\É.S^zR^/@&3n![v\ÍÀ’\êñJ\0…\0/\r†®\î\Ï\ÊwñBÕºú-O×˜õ;+\Õòz²\ë\æE\Ì²qùk–\Û**§hRÁ\ë£iEŠma‰—÷~ù½\ÅAü\Ú\Ãÿ\0ù\ß\Þ\ß4ññZ\Ë\Ý[ K\Ê\Ñg2\Ú2¤F¥™ŒFi\Çe	2Š\×ñ	JT\r\Ó\ë¸ó¿†3\ÖW¸õ\\H;H\é\ì[›\Ú*;Mh\ëº-Å°bd\0z;PÕŽB\Ð/\Ð¤»\ZF¦9Ka\Èk›!¨Œˆ\ê\ÍR!:\éSH„H<ˆ¹U\ï\ã5€sl\Ã\ÌÀ“<˜ jzNÿ\0\Ég¯Hu\ÞAcL\ä\Ü\å4\Ëzg@¦÷zœ¨3Q85µl;Y“5–?’\\ *\ß}´s.1\Zµ%#/¡§\Ã\Ít(XR§ \ÏÄ%%B¤Cq·b\Ó\Úim\\¡I\Åúâ›«Tx‡i´˜\Ó -üF¤U—µ£Vÿ\0!k\ß\Ý\ïa\nP¿<˜jrXºÁ’PõcK)4úÖ \Ï\Ê\ÊeôÆˆc°^2Þ‘.`\0-\ÛØ‚zü±\Ò\Øõ<#©…\à–õ)\Ó\Ï\"¡<\è\05\Û÷+Æ±¼2–/´4\êTcu6‰§\Î.¦\Ò$\æ \"®µ\Ãc™[)\Çe:jnªl¼œÔ·y(t8¾\Ø:\ë‰IZËŠp,‚—JT•f\Ò:\í\ÎiC´2j:\è1§6`e:‚5*}¥µ®«‚9\Ã+h0¿3A ’A\Ë\0d@‰Çžz_š¿F\ÉúeDH¥Ur\ÌZÛ\×·žm÷dImImHRl%”Z\àÛ½kX=mµ\Ä\í]É‘M\Ýpxõ9w(ðK\Öò­uV›À%„ôñAN¢\ê-oSklW«\Ñ`±!ˆ©†”\ÃBÐ‚„­j…)F÷Yñör\Æc\Å\ë\ãU\Å\ÅÀ\0\ZLD“\ÒO¸\ÙížµÙ»WZZ9Å¥\Å\Ü\â	’\0\èMB‹c”»ªnl\ÕT\Ö\Ìj\Î\ÓÜ¬5!\ÓRwc“;\Â—‹\ê\Â\àP\n\ÞUº\â÷¿<w©\í6)J€¶mN`c+ˆˆ2\Ýt\ß;úWø\rƒ\ë\Z\å‡93!\Ï\Z\ÌÎŽ\Ó\àžâ—‰—\Þ[\ë\âR‚œQY\ÍSI¿$¥\Ð\0÷aŽ#\Þj8¼\ï:\è\0\04ƒE\Öc\Z\Z:8\ê{Î§´\ê¾}(8—ù\Äjo\ÖÚ‡\Ú\á‰\ÉzPq/óˆ\Ôß­µµÀ…«T\â3ˆJ\å2]µ®ú‡P§\Ôr,¸’³D\çYË‰)[n!N”­\nI ¤‚$U\æ%\Å\Ñ:…6‰e¡=Ä„©Sb‚®²^ð\0û1¾8e\Ö-³ö”­˜µ\Ï$H\Îwš\Û\Ý\ÒÂ¶²þ\â\ì–1\í¦‚A†¶F€«z.a\Í\Ôø\ékõV \Â.Ñ˜˜\âYg~\íå´¥[F\í\ë¹w·\ÆnŽ‹4R£PL«‡LŽ€w\ëqZkŒ{g\ê\Ú\×\ïs±¤ôi\Ö4Alj¬Œòý{Sª\Õzš%¿*5EJ©\ßT˜-<T†[ºÖ¦\ÛHx£\Õy°ëˆ±L&ûsMó`ºcPf7\î\'ŠŸ\Çð¼m¯cóDó\\Ø™hwUc”»©`BX–%	`BX–%\n\Í\È|Bg­=\ËM\å:TzTº{\Êf2\â‹JsnðŽ$s)\ä\á{\0›Ú»\ì&\Ü[RkKDÄƒ\"u\Òd\ëÇ‚\Ä\ã»…\íé¿¸s\ÛP€Ó”´H-\'I\ãRI2KHü	–¿F\í±\Ñû{‰}\Æw;õ.?ò£÷µ~f~…Ô½\\Ìš§\æß„0©±ü\×\Ûv=Í·»´Ù»võªÿ\0sµ¼q\Ä\Æqûœs\'¤5£$\ÆPFø\ß$ðZ}œ\Ù;-˜\å}\r\Îw)–s}™ˆ†Ž&w¨F8kN–. úð\×\á¦\âþú\ÅC\íñ&P›()\Õ\Î5k*gZ¿Áý+­¿—\åU&ù›Í­ª£hitö[û%8¶þ-H·ke}HU˜AK*”\Â%]Bô1\á«ñoýq?\íñ&P›(W\ãcD4\ëG\æ\åZ{I~˜\Õi©­ÊŒe¸û{˜,”­%Ò¥…ù\Ö\Ûd&À\ÅMp„¡¸jUb\ê÷ZÁ þiýUò‡˜üù\Û÷\Ù²{nÇ³\í~\à\âöÛµo\åZû¹^\Æ\Âu	`BX–%¡Ÿ®¢\ßÁŒ\íúOõ8~`›Jµ\å\Ó);—rFhPN\ÞÅ‰¢<VW\ë\rÛCŽ©6MÈ²r\0\å{ƒ0D NK‹Ot÷8j®p§\ä,…Hó¥v©\Ú÷H\á¦;NÍ¥º¿]\Õ%\Èmgš…\íaÌ\n\èýon/ÿ\0_\×ô¿õ8XI+¢žOdž0ô©8\ËSQ*\ÔL\ß6—O•\\\Ë\Ð1#w(.\ÛHd%7R\É$«Õ¹!)²%D4nøg¬Å”¼µ z=9\è®)…\Û,S”†\ÝOT/kW{:\áÀ\0yÛ“3f!h\È\á?H\"ªW\rº\Z\Ój6yn $û\Ä{14P\è.\î\n2\ê£|w•š?\ÚJ©LwŽôKº¨ür\Û\Ë1\n\Âmû\ÐX±?I\ÂC)‚g\à”\Z²$ø§ü)ð\Å\"k\Ôö4I]“\Z\Å\æQ•\é¥mƒ\ÓrCW÷\â2‘£úPŸ)Ö®\éúô¿)|¦eXR!Q|\Ë¸FuQi\nS\Ç\ÙÙ¡Dº\é%)\î/\ï\êÝ¸µ€´ô­\ÍÑ¥^\íÍª\Ð\á”\ï\Ò8¢	\íá™”©+\Ò=9K\ÍÜ¸Ú²\Ôk\Þ\ç³÷{1Pr\ÄH\'\Ål}\Ì8ƒI‘\Ø<–h—\rH_f­\Ó`»·\à\ìó‡.\Ï\Ù\Ï\è\Â_~¾)þ…a\î\Ùò%¶ž¸ZBÓ¡\Ú|R¡pFY…\Ì\Ó\Ã9Zƒýzw«¬ý\Ó~Q\ä½ôx\Ð\ÄnŸ}Y…öxNV§\Þ=\èõuŸºo\Ê<“–^\Ñ\Í\"\Ê5ˆù‡*i^O¢\Õbo\îó©\Ô8±¤5¹%\n\Ø\ãh\nMÒ¥$\Øó\n#¡Á\Ê\ÔûÇ½­³?òo\Ê<”\ã\Î3?\ßD–%ôª\Ü~Š—\Ùü7\Ýø»\ÍQ\ÞF™Ç„\Ì\Ù °§Sú MJ‚M¬\r:\Ïv·1…\æŽ9D£M\\‰I•:•n\Ë\ï³^’	°e\n$\ì<\Í\ìA\å× \Âú+¨‚\ç:{“v¼\Ã[	\Ó:I¢\ÉyˆUh=ä²µ)	C‰Y¯RŽ½ˆÄ”˜\â34ÂŠ\àS©Ì¨$\'ªUQ•\Ð\Ì\Æ#lf3VCiu+;Rž@\í\èm\á\á†9„;)S5\Ã,Ž…Wd\\§ùsS+:—Gf¨š\ÎnR\Z\Û\Ò\Â\ÚN\â7\"\×\ê\ï{xX)´\ä\ÉwJcn B\n\Õû­Z\Ùùû%û\Ï\íŽÕ¬\ÙoóøOÕª\í©e\Û&¬jl\×(¨§¹!+,*\nò‘pH*½Â¬-{t¶\ZËŠ-¥¦c|þK^\êu_WB#ðþiµü™œ\Üukj·BlLNõ#m‚I·A\Ëórð¾Û»p5k»Ò›j\Ä\èGrqb¨l\Ëd¯9Br+n¥N!P¹m\ÜnEÅ¬m{+\è\åËœF­¡iþ™žÞ• §p\çˆ\ìRhMJf+mM’$<‘e¸¸\ß\Ø:b›\ËK‰h€¬4!\ÇUŸ\rNK\r\äm®·†œ\ÏM\ÒÛ«\Ï3ž\ØYR®Ÿ7\Ó\Å\îG‡N¸\Ð\ne\Ã0ú…\ãª\Ö;)ž\âV\ëñR[‹\ÜFX¿ôyžXû!7–g_qòM\È\Ïr_–Z¬eô„-Až\Ú¨!\"ö\n*#w\ïz{·”\äQhxLkª<˜Žâœ©#7·Ú¦­W¢:“`Øˆ\Ñn\Þ\ÝÛ”o\áˆj\Zg\Ø\â¥`xö\ã\àœ\ZÔ¨kR9\Ù;Iù1©!s¦‡Xr‰\ås\Ö\éF9ŠVJ‚\ÙD–÷ ^-\Üo/\ç8¯rüŒ˜•\ÛÀmE\ÝË˜\\[\Í&Z`\ï§—šW-õ¾h\Ð\ZÞ›l¡\Þ\0<¿\Ô\È\Þ\å®õ+}õO™cEmqB\æø\ë(PU\ÜEVsöŽ\Ì=˜±^±¢@-i‘\ÐK;^5\Î*ˆ1©_¯)ó|e\Úþª\îR~‘\ãˆvHŒ\îWžYÿ\02\Ñn\"\Ýar€’Aó\ä/ÿ\0\ÞüB\Ê%\ìs\çr½Z\ìQ®\Ê¤—tôÕƒ+i`Bü2¤³,F£6\Î3—\Þ“\Ü`\r·\Ü9øôüø\Ñ0\ßdŸ\ßbñJ®!\Ú<£õÞ¦Ä¶Š\n‘a\ãPƒ\ë(ŽD¹Ë¯_,öO\ï\à9\Ò& \îÿ\0\Ô\æ\ÌH*	f<‹º®”\Ê+ \Þ\äò<ý\Üñk†¤)…F\0…²)®G”$F£\Æ$ŽjT¥õ\éòv‘\Ó\rONŒ´„\0²\Ãm¸G­°…ð!s!_ºÕ­Ÿ‘\Ð?²QqRóûcµiv[ü\Ç~õj»\ëTj\Â\ç•\Óûe2µ‚$(m> ‚z{±*\Ì\r‡o\ì[J”\Þ]\Í\ÝÚ´\×C\Ì	*(jA+f*\Âþ?+\éú<1 ¯K¦;¿ñFiTý•)ƒØ”\ÔDL…¥\í ©Â²\í•\âA]\É¥Q\á\ï\Í\Zw}¦0µ°´NZ\Ü\ã«UZa›P·\ÑÏ—\æÄž‘\0sBg#=)\ÊG¡³\Ø9-O¥6Ü›a=O\Òq\ÜdR5¥¢%l\á‰\èhòFªs\\8fg—\à#;J¹R\\\ï¡…\0\È\íÙ·\Ý{û±\ß\Ãq^2\æ5Çœ%†§“±\r( [£d•IðÎ¸\\\Î=)20nh\îY¡U#‰­¨mÛ•õ\ëü—¿³KŽ„¥\r`2‘7S§)\Ô\Èb]B\É$„¥\ä©7\ë\ï\ÂBt­ös#\rn\ß\Þ]\Ün7\r¿E­‚+›qe\"o•‹Zd¶•%+\É\Ðl×”Z0ÿ\0S½öj\Ól¯ùŽü\'\ê\ÔH\Ôktúb\nŸp¬¥A*CvR’O´_\Å*t]P\è·O¨\Ö\rVg*$¹‰Œ\Äw\Ùj¢|\É \\žƒ¥ñj\â†`À\rÒ¨\Ù\Ñmg—I\Ð\Ä@\à·šC(~“Ð¿l—l=¦\Ý¿H¸H\ÇEf½\Ýf‡Up\0¯Meø^TŒ«XFýª\à+\â\Ò>Q\ëË¨Å€\Êt\é¸<·¶w.UlBƒ«2«k€\ÖÌ5ñZ+¬\Ô$˜­@œ\Ùq[¬m@­ýöúqRi¸s*5\Ý@‚WB\ßµ»\'E\àž¢ž^C×‘ù)_Ù™+HP9\êg\".?\Ùð1\ßÆŠ8û´k[»5o\â*E\ïvÿ\0\×üƒ\Ò†\Æ\ÖÐ”bE°!}`B\ç®^i\×|ª\ÚÊ–›Z\È\ÉÐ’’M»µ¯A,\Åi¶YÁ·n.1\Í?PŠITMZW*–\ëŠH°%\nö\Åº£4j\Ý9Ô¼Žõ9N\ZF\ÑErÛŠ¾Bú\áÜ­T\ß\èq\ë%H\Õiðœ0e;A;”I\r¤ u¾\îV6\ZÀ²¼L¨\î(P»d<\Æ\n;]\Ïo²Zr£¼\ë6C­+µ\È#‘.X´úV\Ï¯h\ì+žp\Ëb#’io\Ð)U(rŸ•Pr\ÊZciI\í.j _Àb‡£ZQv{z`¼¯bµi†\Û\ÚT5)\ÓkN\é\0ù…]$=ù?kFfüº›ý\ßð¼h£Ÿ\n‘,KÀ„\0\äª\ÝRƒ\å]\Öy”™E‡—’á´¥ƒt˜ôSnc\Ú*]=\Ô\Û-\â»û=iFò\å\Ô\ë¶FR|B,\'\çŒ\ã*SwiÙ©tºòR€\0\\6ó¿<s^¡<V\æ–aM‡P\Ø\Ü5\×\Å|§5\æÀ¶\Øó{\Éj\ÊP^\Ä\Ø„²üÀú}\Ø9Zœp\Û.\Ì\'\ã\æ¢úº­T\ÏY2}#8\Ëù°-@fK((Rn”¨\ë (zÃ•ñrÆ­\'\\°\ÝYÕ¿·\á½U¹·§aiQö\Ð\ÒbI\Ýù¨$lôþŠd\ê=;ˆJ„JY\æ–#\Æ\Ñ-<\Ëm4\0N\ä§\ß×–&u\Æ%]î³¢\àÀzL÷“\ÅNoðûJ,i¹mGF°©3Ž0´¹\Ùü-‘\ÖÛ¼\Üþ\ßüqo\ì¶)\Éø5_\×\Ö\íø›\Ò\ã@†\çô	úa¿f1Ow\â<Ó½{a÷ü\n\äfO\ÖM^\Ó\Êc´\\ª¹\Ã,\Ó\ß}R‰G®J„\Ê\Þ)JKŠCKJJ\ÊP€TEì”†¯3O¾”Kü\â57\ëmC\íp!/J%þq\Z›õ¶¡ö¸—¥ÿ\08Mú\ÛPû\\KÒƒ‰œF¦ým¨}®#\ÉÛ•«€\çN-µT%\Ôe6Ô¼·S]m\Õ:\çb\ËPd™Ny\Òv¡´mRl”¢û¬6\â½\Í7T§\Í\è]½Ÿ»¥gy5Œ\' n:÷G\Ç]b8ˆ\Ð\Ó\\ôÿ\0\ë4/´\Ç;’©÷Or\Ýú\Æ\ÏÞ·\æj°\×~42Ÿ\Ñ!;\Î9K3\Õ**q\ÈÕ¸ò\Z„®\â[Y$›ò±\çŽ\Î\r…Ñ½¨}.¦FŽ:\Ù+™‰\ã”mX=µ\Î< v\Â\"qeœÕŸ©™ò¿¨\r\ÕM|º \Èj2¤”-°\ÚHH*P½¯\Ï\Æ[a4(:»˜\ÒFùüL\Ê\Ç\Ü_Õ»t\Ü<‘À~CrŒgMcƒ)Y^2·ò­-T\È\é\\\ä/v\ç\Üyn^ýIr\Çø£h\\ZQs\Üj³œgB8\ÅU&Ÿú\Ï\\Ç‚Šü\"\Ëÿ\0‡iÿ\0¥#üñg\Öžõ¿0óM—\Â,¿øvŸúR?\Ï¬-=\ë~a\æ‰ÿ\Ù','Local Drive','2023-12-16 14:15:36','2023-12-16 14:15:36','IGH141585754362','IGH141585754362','application/pdf','Ani Demo','WRS695055681927'),('KBD491651982526','aiplugin_fd5bd84c-dd79-4c1c-a290-7ba566521861.png','1AjmiBvCNldlCCP-nvpn8KZFvXGJoDbi8',_binary '‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0€\0\0\0€\0\0\0\Ã>a\Ë\0\0\0	pHYs\0\0\0\0\0šœ\0\0;IDATxœ\í]	XU×µ>¨Ü³÷> MµM\ÛtH\Û4¯iš\æ5MRMš\Ö\äµiš´\æ%/m\æDÅ¨D&•Q@q\Æ1Žˆ\â<+\Îƒ€\â\ã„N(\È\èz\ßZ÷œ›\ã\r8ñ^`ÿß·\åœ}¦½÷\Zö:û×¯(÷.½{÷n\ï\å>÷[B¢-#4´þùCWž\êùÒ«>/öú{ßž~\ÍË‘\Å\ÑCÒ¦\à\éù©+þý\Ýó½‚3·\í†\ÂÂ£5\Ù9y“›\ï°\â\è1iSðôô$ð|æ… ’²‹\0\0U\0P\ï\È\â\è1i£\nð§\à\â’2T€š\Ú\Ú:¨¯¯wXqô˜´Y(±z€šúúp§¸q\ã\Üù\ÙwGI›‚\çm\0|¿\á\è1iSð¼ K¾x\é2TUU\Û¢þ\Æ\rÀi‘{ 6lÊ´kÛ¹ú¾Y‘p¿¼ü*””–Á\Õk\×L\×Z\Ïwô˜´)x6¨\0V\Ö\Õ\ÕÁøI©04$Â£â ¸¤\Ô&X<†X¶r-L˜2\Ý&\Ä[¡N?¾j\íø¸Ÿ7†ôŒ•¶{J\à$\nP§7/ÿ ô\èG\ÛEE\ç\áúõ\ë°g_„ˆƒ±\ã\'Sýú[`\êŒ9´“›a‘±0{\îB\Úß¹{„F\ÆÀôYs¡ªºš<\"-}9Ì™—føW§NÃ´s 1y¤LJ•@Q—oY\Ú\ÝEÁ%\×ö=ô\Ã>ùûC\ì=\0\n|x\Ô(ˆŠK€£\ÇNPÝ…‹— \ì\ÂE[·ï‚{öÁ´_\Ð1Ÿ!!pô\Øqˆ3–d¬„A¾°{\ï~8{\îTUU\Ù cùj\è;À&N™§Nc\ÇOÀ{Ÿ|g\ÏAXdL‹Q€[\r~{»\ÒÁ®¸š¶\Û\ë\×\à=œ.¸^U«\×m„¾ý`V.\ìØµ\"c\ÆÀ>ò‚\Ìm;a×ž}0}ö<()-…·\ß\ëñI)0$86gn‡õ›2Á?p8¬]·\É6¥ P9Â£\ãaV”_½\n…‡BÜ˜d:–<aj£\np·Zß¾‘bžù^\Î\0]1\Ð2\Ý<<<:¹»»w\Õ4­\çüªªþ¸cÇŽ[,–G4Mûµâ·œó§cÏªªú¢ªª½8\ç¯Z,–7cÿ\Ëû·ªª!>\åœ\Æ9ÿ\\\á\'„\"„\Ô4mx‡vÊŸ=ò›-%eô©\Ú\ê**+\áò\å+´=g~\Z„G‚\Ïýƒ\à\ê\Õk2y:¬Y¿	v\î\Þ3\çÌ‡k\×* ¿w\0TTT’ «kj\èº\ê\êj\è\ï=„<ô¥+aÞ‚t\Û~þÁB9*‘¶“\'“˜­¥½ƒ…c(\n¶Å¢(\nW¥“¦i\ßeŒýPUÕŸY,–GuAü·››\Ûóš¦½$„ø+\çüu\Æ\Ø[BˆwUUý„sÞŸ16˜16„1,„aŒ…r\Î\ÃTU\rãœ‡«ª\Z\Î9\àœ\ÐK4\ç|$\ç<‹ªª\Ñz=ž3¯Gajš6Hñ	c\ì=M\Óþ­i\Ú[œóaP!„ÿ#„ø‹¡$‹\å5WW\×7…»ûŠ¢¼ý‹GŸX®{€:\ÃROœ<	a#bat\Òðƒ\ÃGŽAÂ¸‰Ÿ8‚†G\ÃÜ…‹¡\à`!¹þk05u\rŽ€±)Sh^Ÿ’:\âS`D\Ì(:_üµd¬„½¼!iüdX»a3\È?‘#GÓ±Ñ‰)·ô\0(\07EQ:›,\â§\î\î\î¿Ô­\á	c\ì9M\Ó^B5p\Î\Ñ\Z\ÞdŒ½\Íû\âˆªªýTU€BBø!†1\ÆBPœó(\Îy¬b4c,I1ž16™16Q1Ž16ZJ$\n­‰1\æ\Æ9À9\ï+„øˆ1ö.c\ìÿ,\n\ãïªª¢z2Æž\áœ?¥i\ÚoÐšUUý	öGÓ´nx\à7½¿\r)¿‹\î!<P=<<~‚÷aŒýAUÕ—,\Ë\ß\ÑúUU}Ÿs\î%„ðB£2	!Æ Ba?±^Ó´Š¢¼þ\Ë\Ç<\n`Ž\æKJJ!7/Ÿ\æ}Dee%*„ŠŠ\n¸R~•\"ÿSg\ÎB\åõë´\îü\Ô\é3tnY\Ùºö\â\Å\Ë7Eú\è-ð¼\ìœpò«SôŠyA¿ÿ¥K—A\Ñ4-†1– |‚>Ø£P º5 p\"uk	\Ó;(„ª[—c\Ì\×b± 0\ééƒ‚\×4\í\Îyo†\âeTTt£®®®»¹¹=ªª\êÃŒ±)Š\Ò]Q”.Š¢hú¼}¯A‚\ìÜ¹3\n²>Wñ$*¶•½*&*c,Rô\è9„ABˆ\0Td\Îy?ô\0œó\×4M{A\ái±X~¡(\Ê÷Ewó\Zh¿t»\Â\Æhµð.”‹\Åòsœ\ë8\ç\n!º£–w\ìØ±Î‡]»vu\ïÖ­\nDÕ…B?g:8MuF¥quuý5Z·\î}z!>\Ô4Í›1†\Z¦[b˜\î9P™\ãt/“€®]€V«ÿ5UU\r!þ\Ç\Ã\Í\Í\íT}*ú6O\Ü;=üð\Ã\ê7\ßL+ú\âŒÁ‹;†P\Íû\æûs\í¢¡E#\ã\ï\Ýv\ä^\0\ï\Ã1\Ø\Ây\Ýb±ü§=°z	§t©\èA0bŒù \ÇA¯„Sƒ¦i“tF¡€\Ñû¨ª\ê….¯Ck\Ö4\í\Ïè¢…£¥\ë\Ùñ[\n\Ñ†@\íc§\ÛºMý- 9 4!ðÃŽó.]ºtDarÎ¿\Â\ìÐ¡\ÃÓªªþ	c}^¨ƒª8\Ýq~Â J¬pc777›E\ZnUw×†[mª\"š…×¾7–f{S1)@\Ðùbú5°º¦¦\îF]]½ÃŠ¹}\èæ¾‹‘¶««ë“º½¢i\Ú\ÛBˆ\Ñ\Ê8\ç\è^ýtb‚ŒgŒÅ¢»Õ¡!\Þ\ãœÿSUU´\Æg\Ð]£ 1øB×ª˜M\ëoµ.\àt¯Ÿž\Î\ècÉŒ±=bÖ­r8ªª~,„0\\\ë«h‘M[,–_¡ûÆ¹X·¤¦\ÂEšý¢y\á\ÆY\Öš¬\0O?÷Ò°Ô™ó`\Ùò\ÕÓ–\Ö,Zœá°‚\íéª»VK\æÈ†ƒ\Z³@§°FÁÿyöÙ¿ýè§¿x\âO\ßûá¯žÿÁû£#Ë¸\Ö\ÆÛ–)!\Ñ$¸„††¶s†Ò´nHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH´~¸8i‘„m ÿg\Ð}€•–\ÅÕ‰‹Ds¢\×ko÷ö\r\Ú=$(bc@`øfg+\Í\Úy	E\é;\Ð?ý\êµJ\Ì\ÅPWWg$ivž\"e\Ô\Ìø\Ì{È‚k¤\0˜¼\Î\ÙJs÷¿\Í\Ãkÿ\"\Ì\Õg\ä4güºŸR6ôü6/ û¢\0VPgŸ\Ç…bd\nm·K\ß\äAŽQ€Æ’;bŽ@s>?¬µ?v«û\Ô\Ö\ÕQ&Qc\ßP0L&md!7ß¿™»/\áe§\0†ð²só`aZdn\Û5z²gsGº ®N|yjjj¿!h{B---ƒ˜QI”y\Ü\\¿|\ÕZ8Xxø\n\'%\ä ‡”É©0%u6%xF \"*<B	£ûð¥\Ôñˆ\Óg\Îmf7Ä˜\Ûg‹Š +\'\"£ã¡²ò:\\¿^E\Ì#˜L\ZDjkk¡´¬Ì–]5wÿ\Û<¼\Z™b\ã\ÇBÁ!«Eú\r#Á!A2~DD\ÇÃšuaS\ævxõŸÿ¦ñ(\èô¥+(;x\ì\è±6¯aÛŽ\Ý\à34”$ú£º\ÑI)08 ˜\Ò\Ì\'O˜\Ûw\î\Äq“ˆ|\Û28 D*€£ *&²sóiS¹¯\\½ž¶Ÿ8	S¦Ï†À°(\ÚGkÆ¬Þˆó\Å%°u\Ç.xÿ\Ópþ|	\ì\ÏÎ…%\ËWAqq)„D\Ä@Vv.\\º|™\Ò\È#Ð³,_¹–¶ÇŒ@\Þcó\Ö\í0k\î\È+8\ãR\Z\'Œhf—yù‡h;bd<± +\n	\"\Ð Õ‡„¤tñ\ç\Ïƒ\ï°0˜»0úð#eØ¸e+L›ù9vœ\ÎCž\0œ¢b\È\ÂÇŽŸb›>#h÷\Þ,rû\èERgÍ…\Ì\í;¥8J‚\ÃGÂ®\Ýû\0¹ƒ‘ý\çg´Ø•k\Ö\ÃÞ¬r\ã¨\08=\à¾qóV\n‡š\Ú\Z\âü9vüKºA)—iK–CV\Î\è\Óß‡\êb\â“`Ç®=´7zœr.$<¼ù\Ç@³@[‡W#A\à\äi³I 8gc°‡@¡¢%OŸ5Bd\Å\êu\ÄðQTTLžE¾˜Ÿ¹yºX\ßÎž+\"\Æ¤•Ki%–šŸ¶\Ôù/\\œAÊXº|M;ò-ÀI\ÖŒW³û\É\è$+õ™\ÃM7“;˜—o\í[C:3¹\Ä\ÍD\Ös\î\çX´IxÝ¡p=>­^NòcPc\Å\Ñ\ã\Ó\êñ\Ù\ÝÿŒ¾\ÙøHþ\Ü*>©\Ð?1\æý\Ûãƒ\Í_=>­¯\Ü\â“0ÿaÃ·ø\Ë2b]DtBZ`h\ÔZ\ïÁC³?ü¤ÿ\Å÷>\ìS\é²£¹?%sôø´ÅBU½(&²EySQ”0EQ\Æ)Šò/EQ¾o¢\ë“…¶d\0À7XUºw\ïþ@§Nzh\îZ¤»»\å\æ\æöq\çÎ\ÝÐ¹-.öÿñI8U!þÂ¬„–H¡\×©ö\ì>\Ï6hznÅµt/‹D3	\Ý\\®óú\"µž««\ë»H”išB—hap1Y«WM\Ó\ÓYM‘sI³Ÿµ°A]/­°…\Â\ÅÄ™HBDf¤°7\Ñ\Í÷\Ð	2\Í0³®I´@´7É¥u\Îc´tdRý«Ns«40¯K´P¸˜,— 3®\Ò\ïm±X±»F\Î\é­(¨s\Ñ÷]\ÑÚ‘\ìZ\'\ÃþK×®]\Ý\í®¹IQ$ZA`\ç\á\á\Ñ\Ùb±¼ÁKÄ€<»ó¥µ·\"´3Y¼c\ì|gGuN\rL	2˜k%hg¸n´ªª©ª\Z«ªj/;7/]|+ƒ‹i\ÎV9\çÿ\àœ\Çr\Î\ßP…™Î‘Q|+„‹\á\Âc\Ïhš§i\Zþ(cÑK7ßŠ\Ñÿ\éÒ¥KG\Îy?Æ˜?\çü\rx‰\Ö*|‹\Åò®\Ú1Æž\Ó\ë\å‚M[>®\Í3\Æ|5M\ë¦\×Ëˆ¾\r€\æ{\ÎùSœó¾¦ Oxm\04§w\è\Ð\á)‹\Å\âc\èI´\ËPh¾‹c›%q¿@VŽ?\Þ0Æž\×\ë\Ú\Ë\áo[\Â\ZÀ\\\'\Ñ6@\ÂfŒùq\Îo®“h#À_ócƒ\í¿\à‘hý A»¹¹=*„\Ð\ë%h W¯ª\ê\Ëøs®^\'ƒ¿6„ªª&¨ªš\Å\ËUUu¤^/§€oƒ\Ð\Ð\Ðv-¥ô\èÑƒ\\=\ç<\Þ\Í\Í\r°¨*ux\Ì\Ñ\í½‹ò­„%a‹ô¿Ã¹z’3vDQó=wƒÞ½{·\Ìóù\'ü\Ù\ã=¿÷“Çž\ïþ\ã\Çþ\è\ì¥\ÛCÿ\Õó¡‡ŸzÂ½\Ów\Öu\ì\Ôu\ÅC?ÿ\Ýo±\Î\Ñ\í\ê~\Ç\Çúñ\ßõø­£½€a-Ú‡}\îZ–‹Ò—U-\\œQ\ÓÊ¢ôe\ÕÓ–\Ö`¡\í–\Ó\î*\Ìòõþ\Ç¶\Ú}™\ä0pŠß¯g®0ò\ZI4ô\\B”%$,\"v\'†2Î \0ZXD\ì^kúr¨«­­¿QW\çl¥N/\ß8z\îožwûû\Õ\ÖR>)L(Aa\Ñ;œ\Æ„E\Æ\îÓ•´\Þ3^¡[rD»\êo‘Ã¿© hx´\Óx€FÀ\Ìjq¯\ã^ÁQ\íª7=÷NŸ\ß\â ±Nù\ìÍ¼5\Æ~C”)X‡©O\0Ãš\ã\ÞÈ‡oe\ÃÀ}ûg£‹G*<J9õx\ã\\CA\Í\Ïþú¾7£\Î\îF;œ¼F\îmß³/‹5\Ó1Ùƒ9-’>DÅŽ¢¢ót¯·µ\ïF=\Ô\Ô\ÖZ}~KS€\ë×¯\éÁ…‹i\ÚÌ¹”\Ü\ØÔ‘f‡!\È\É\ÓfÁ\Òe«l0€Ê±b5\\º|åž¶«^nD\ÌhØ—•sS\Ñ\ës­\é\Þ\Ï·\åù¿Z”`zòa!‘”y\Ú\ÈD}\ä\èqJKž<a*‘ ö#SÅ¦-\Û(\Ýù¡\ÃGˆ¼`\Þ\ÂtX¼t…­\ãX7f\ÜD8|Ôš<yS\æ63n\È/€\ê\êj˜=oLN%¥¥7\rö¾¬\\H9—²m\ã3°.M™Lƒ¿m\Ç.xåµ· eR*Y³\ã\ÇÃŽ]{\ÍN,Ø¦¤\äIð\åW§¨\ÉV¬ZS¦Ï±1u`Fo$cØ»\ß*t¼WNn>lÝ¶JõqÀ\ì\Þx\Þ\ß\Þx\ÆOœF\Þ\ïu¥¼œŽc\è\ä‰\ÓH)0¡s|\Òx\"}0õ«e(\0ù\r\rƒ‹3`\Ã\æL0x(|yò\\¼t‰²`#C¦1\Çl\×ÿxó?$d$/zçƒ¾°e\ëI\ÌÈ—@­1\Íy\æ¶]ð¹0d\ç€#GÁ\Ä)3!!y\ä\ä\æ\Ñý\r`–\ì>C)-ºO@¬Û°…zð\ÐabØˆ3\Î—\ÂgŸÀ¶\Ö\Ô\é‡…œù\à3$\Ô\æº˜—•s\ÍúM”\ÎñiÿÁ0\ÑH\Z?…\íÝ»?>&‹F2\ì+f\àÞœ¹”\â«\Ógh<¶\í\Ümc\èÀqA\Å‹¦{\ìÜµù«G¶žÍ»\ÅM((´\ÌE\éði8ù\Õ)¢?™:}ô\äG\Å\Å%¤³`\à$	†\ÛÞ¹{¬Z»\Þÿ\ä3˜8u:\r\ZHØˆ8˜6c=­¶qS\æMÉŽ\×n\ØñI)´=cö<¢ZAÌ™ŸFB\ÄA\'7=2\Þ&l¤bAa½õÞ§\ÔV(\ÌEK–Szö¾|©nxTõŸ?^÷ «\×m\"¡¿õ\î\'¤4\èµP©÷\ìÍ‚\Ùó\ÒýÑ“ ð^H\î@÷\Z—¯”C\\B²\ÍûTW\×@T\\:ñK‹ò\0˜7<*.\\°\Æ\0#\ã\áø‰/!42–0–,[	“¦\Í$Š“\è\Ø:}\Ä\ÈÑ´\Çpþ\\±z=DJ¤ù\Z-\Èð²•kHð8ŸVUU\Ñ`MIc\ZºZôt¯©3Éb>ý	“§\Ã\á#G)\'?¶•\áò\å+\äM ·ý†…Á±\ãV*5\nmTB2	\Â\Û?ˆ\Ú5\n\Ê.\\¤¾Ìž»òô\îD\×#©Ã•+\å$<$z*//§©!1y\"\ä\å¤{†FÄB„E\ÆByùU=vl\Î\Üv\Ó4†\n\ÊfŠZ†\\½v¬\ì|±Õºü‡S0n\"L›ñ¡.<|C£l¼8C‚¬¼6IÉ“aÃ¦­Ä‹ƒ®…€\Þ\àØ‰/a\Æ\ìù0g^\Z\ÄÄ%·ŒSI|\Âxr\Ép\Î\ä;—§¡\ï@_Š-\ï\Õg€TTV\Òô‚\Þ§œ*ð~öDS’¼.$b$)\íGý¼\Ér‡G\Ò3P\ÑR&M§¶{û\Òõ\ï~\äE\íDÏ€1	yD)A\Û3&N™A÷À>\ã_¤qA‚\'\ì\Ï\æ\Ì\Ô\Îù‹–’W1 ZŒ`ƒq>E\ëD … W@\ËH\ÏXI–qò«\ÓPRZùm^\ã@ž\ÕB\Ðub „@\ÅY¸x)>zœ‚¾\r›·Bz\Æ\nòD.^ºœ\æO#\Â7^¹Ž;A\äHù‡(øÄ¶­B\ê•ý\Ù$°ŠŠJRPd\Ê@<V­\Ù@SÑ™3\çl\n€Ö¸~\ãr\Ï\è¥\Ðòó\n©ox_lb÷žýtõ«¤Œ\Å\àP91(4p®¨–­XC\ÓHÁÁ\Ã\ÔwÄž}Ù¤hx-zÀiKloO-j\nhÍ°2ö­÷\ïÅ±[c\Ô<„ƒ3\ç¬Ju+†\Ï\ë‰\'´…\r­\Z0C\ì™,\Ì\ç\Ù3Y\ÐBé˜±xƒhŒk\×ü,ó¹\æ`\Ñ8Ç¼U\ßÀ\ê\à\××™Y:¾f\ä0·Ã¾_§ÏœƒS§­œyõ\Ïü\\\ãq\æ¾\Ù÷³\Å)€\Ä\Íh\ê\Ø8­„F\Ä\Ø\0—_\í9n\Úz©3y†¦\Þ\Çq‚Â¢œG\"¢GY_^jM\Ì²@³Œ½»\ÝY~v\è˜}  ró\Ö\ç(\0Y\nšeR\Ç87\ïðº[Q\áH xzzº>÷\â_{÷\ìõúÀ^~£_Ï—_÷’\åõf\Z\ã^¯üC\ÏWþ‰\ßc:Lð6\à×©¨²ô¾oc\à\è/‚%$$Z3þp\É3\Ê\æ0k\0\0\0\0IEND®B`‚','Local Drive','2023-12-16 07:43:03','2023-12-16 07:43:03','IGH141585754362','IGH141585754362','image/png',NULL,'WRS765168112483'),('KBD679125371089','5. Content portal info popup.png','1OKsYrWma0g_bQuoZ8sLI9m9yLVCbHSLA',_binary '‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0€\0\0\0€\0\0\0\Ã>a\Ë\0\0\0	pHYs\0\0\0\0\0šœ\0\0 \0IDATxœl½g“¥Wr&V?Fß¤P„´ŒPHÁ\íFhEr7\È%—ÁYr\Èñƒ03\0˜0p\r¾ÑF\Û\êò¾®÷\Þ{\ï}™nrE®~Â£x2Ï¹÷b¤\'\Þkªn\Ýz3Oš\'ŸÌ³1V1™tpq1À\å\åW—#\\_Oqu=\Æ\Õ\Õ—C\\,X˜uy©\Ïùžý{½¾ž\ÈZ¾f\Öõ“)ž>\ãòrŒÉ´‹Ù¼ù¼‹\Ë!‹f³¦Ó¦\\\çó6\Óf“:\æÓ†<žŒ*Oj˜Lk\r\Ë\rÊ˜Œª˜MjËºet\Û%L\ÆeL\'5Ì¦\æ3fM¹\Î\Æ5\\N\ê¸\×q=i\àz\Ú\ÄÕ¸Å°*\ï\Í\'u\Ìúe\Ì{%\Ì{eÌ¸º%¹N:EL\Ú¹òµa§ˆQ·„q·„A§ˆF#n+‡a¿„i¯„‹AU>k2(c:¨`\Ú-a\Î\ç½†Ý¢üþ [À [D¿[D§•E½žDµ–@µšÀ _’ÿk\Ø+b2®`<ª\È}\à\ç{%Ì†\\Nx2k\ázÖ’\ëþ?³ó:.üŸk˜\ÏjrŸ¦\ã\Z³®.:²®/»xr\Õ\Ã\Æx\ÜÀl\ÖaP¨\"xóø\âb¸&ü®®Æ¢\0T« W\æw)\ì\'Of\æ\çø\Ü*\ÅT®—WC\Ì}L©³žü.>™\Ôÿ?\np17B›\ÖE˜£q\ãIUnoÌ¨_’%7©_B¿S@·U\åJª\0²\êFê˜«\"\ì\ËQ\r£š^‡5ym:¬¨°ú*t´Q\n‹\n0n\å1\æ\ß\é1h0h\ç\Ñm\çPo¤Dˆ\n¬S\Ä%•ª_Æ˜‹\ë•qÑ¯b6¨`\Ò\çßª`\Ä÷øw‡UQ†n\'F3V;‹\é¸*‹BŸõ\Öÿµˆv3ƒN;‹A¿ˆ~;‡^+‹n3ƒF9ŽF%F-…Z9r1Šr1‚B6Œl*ˆ\\*„b.‚\\&ˆ|6‚r>N¨c1\ï\àò²\'\ëb\Ñ].¾>Ÿ\Ó:ðuU\0¹Šb––A¬GvüD«Vd²´¢H\ÜñC\Ìf}±ü\ìÙ¬ƒÉ„J\Ð\ÄdÒ5›60«À\ç\Üùu>wÃ¤Š\á ,»G„\ß-¢Ý¢ òrCy£xó\ìM³\å¦+˜Ë˜Ë²‹(>÷uGr÷.øZ‡V ŠE¿&×‹a\n°[Á¼_ÅœJ3¨\ÈuH\åkf1h\å1\é—1j0\ïU0l\å\ÑkdÑ«¥Ñ«¦\Ñ)\'\Ñ(\ÆQ+DQÉ‡‘N{‘Lº‘Œ{‹¸	\Ã\ë;‚\Ï‚Pð\á¡Àü\\þSƒ\çðG=†ˆD\Ü‡ÜˆD|‡½ˆF}H\ÄýH&CH¥B\Èf\Ã(’(•2(—S¨W3Ø˜\Ï[¸¾\ê\ãÉ“Y}<}2Àõu\×|þt€k¾ö\åTv?…}}5Áõ\ÕX\Ü{}=E¸¸\áÉ“©¼÷ô\éOž\Î\Äüs÷‹‚\Ìxz5–ŸO»Žk‹ð»˜LZ˜ˆÀ\ëz5‹Âž\Îø¸Ž19®¨+ 9\ì\ÑôWA7\Ö\íQ\Êb\æ¸\Û\íõSøœ\Ê0[S\î\ÔQæµ€a;‹^3N-…v5…&wV)†Z1ŠBÚ\\Ò‹t BAQ0¾cø=GùO\à÷\Â\ç;…\Çsü­EAz½§ø\Ï¤\ç†œˆ„\ÝH\'‚È¦\ÃH$¼H§ƒ(–\â¨\Ö\Òh4\é\Z²h4s\èvK\è÷+\èõ¹\Z\èt+\èökŒ\ZZš›;\è\ršh´*\èôø\Z\ïq³y‹³ñ\æM\\^u±‘Í…P(\ÆP(F\åV\ÊIT«iT*)\Ôj4\Z94\êY´\Û%´[e´šE´\ÛEôzUôûuôºu¹†5ŒG\rL§L¦,\æ}±—#,}YOžô\àdpû¡óEƒaE>k0¤Ð›Žj\"\Ìá¨‚þ „MÞ¨„n/v\'‹V+ƒN\'\'›\Í4\ê5jq¥Rù|…|\åRùl•R…|ùl¹L\0™”\é¤‰˜Gv\\<\æF$\ä@8p†ÿ\n\Æ{&W¯\ç~\ï	ÜŽCø\Ý\'œˆ(pb\âQ/\â1/	\Ò4­¹\n…*\ÜUõ,Z,:X;­C;/VŠ\ÖJW}ú\Æ\ã\ZFƒ’(!\Í;]\0|4\Òxg:ªJ|B\×8UÔ·OkŠ\èsŒê˜Ž\é\â\êbA£\Zúƒ*:Ýº(A³QÄ¸_w8¥K+[\Ç|^\ÇF©šE¹–C½YDµR@¥œC©”E±”A¡A>—B>—D.›@6G:C6E6E†+E*F:A*F*A\"F:G&Ÿ@:G2E6G(\Z\Â/^{Œ\ï<û\0· ‘\n r‰9G|ˆFr¥\Ù‡q…h\Ú\\òœ\æ/v#\Zõ\"r!ñ,\Í^8\äA\Ì%÷!• “¥DÏ„Q\ÌGQ,P)¢¨VR¨V\Òr­×²¨U3h6rh6òh5ó\è´\âRW\Ð*i$ £\Õ)J\ìAAJb\\\ã\0ƒô\ëOˆÿ\ç\ï•0’\ß)`2\ä•`a¹&ý†ü{u*@#-\Ê@k5¡•\ZU$N¹ \à$øÕ¸H\âœY½^\Ýnt\çcZ\Ð	­e\Ý^\ÍVF\Ýª!¿•i\Ö\ÄõeWW}\\^öñ\äzˆ§O&øò\Ë)ž<\à\ê\ÉOž2z§\ég7\Ä¾öD£ük	ò†¸z:À\åõ\0\×W\ÌL2\êŸ\ãú\ÉWS,.\'X\\Lð\åW3\ìeñ\Åf\ál¯¾ï–€p8\ìc0\ì ?h‰©\Z»\êkŽ\ëQ³gmY|k<­c8ªJŒ0\ZÖ–fq2¬\á‚Qý˜Ae]\\\Ç|Ö”˜B¢üaóQ\rW\Ì\nF5Ì¹³FU–\ÄŒ\èJ:yŒl„\Þ)`\Ì\Å\0“\çE‰øûí‚¼\Ï\Õa`\Æ8€Á\"\ã\rf*H™ð³\'Œ\âUD©˜Uˆ²ð{—%£\à\ß\ã\îo¶2’\íH\ÜBA+´^\ÌZXPx&C¢r\ÌM\Ì\æmt\Úet;5ú´ôûe´\ÚU4[U´ZUt\Úut;u\É.F¼Ó†*Àb\Þ\Ã…w1Ó½\Ê(Ô¾,ù9¹ò¹>f\0\'\é£Qù¬‡ùE™úñ½ù¼‡«\ë).ŸŽð\áJ\îf°sžÆ—O»\Ñ7-Ú˜ÎºŒšO:PÀcš¹QE9\ç{u‰ðgcö™\î\rúôû‰œû=\ÝQ²Ke÷T\ä&Gš&róf.5,\äjr\ã\'Œö)\î\Ún	£NƒN^„\Äe3\0F÷\ÓNQ”¡\'Ñ¿.U\Íú\Ìe	$™\Ìú%\Ìz•\Çü]\Í,\æ\ÝÙše0­,¢VO£\Õ\ÌI0+)3qL]§-Mc\'\rQf9Œg¸›G“Ú\n\êõz*z\Ý\ZÚ\ZZ\\ŒD	ª\è÷jö¹q˜b·°±ž\ÒITO\ßmÒ¸Ëµ|žþ\\\"~úu‰ú)ð¾üŸ^ÀÌ€\ïIJ8ÕˆÁ@rˆ\\µn±uÁ££\Æ}L\çMŒ¨É³\Æ\Ó†£¦4\ãF“&ú’Ò©™S%¨¡œK¢\Ù,\àz\Þ% \îõ‹hµs\â7y³x\ãd\Ç3õ£Id\êhv#wq€+š\ÓAEL/wª¤e\Zs\Ü^)À¤S’¬`\Ò.b\Ô\ÊcHÿÞ¢W?/)(\Ó1y¬\npA\áR	º%,úú˜\Ø¯\ë‹\nÁ\×\ç*^õ\ÝQF]\Ì`¥\0Z..Q„\æ\Ò\n\\\Ì[²&’U\Ä\nô{MŒ\ÜDmtzut:Œc\ÕEø£Q\ÓQ]@ƒ4¦u\nòP¸V)ù[ GS@}\Ï\âü\Ý\Ë?À\n,&À\Ï\Ïøú›!¶NsøûÎ‘È´pu\Íl£‹\ÙESjï´\ÅE\×O»²ó;½\ZzÈ¸,Y\0#\ØË«²™\"~úò9þ\æ\Ù=Dc	LizH\Õ\è®W¬@|\'SÈ‰F\Üù¢\0ý2.Fu1©s\nH–1\×=\ë³K\"L.Z“i_œ	*E;/9›ùw;‡Ž(¾ ‚[Œ,\Ö@+S‘\ç\Ä(l«²ú\Å\ZhzeQ¼z=fSÿ±\0\0¢\ï§Û¢ò\Ò\ÌMÀÝ¯˜Gxµ\Ð\íVEzý&Úº¸Gi\0NMº=nb>iX ©¶\æ]…©\Â]Gü\Æò3‚\à-\ß\×\èÞº±òó}4E\\\\ñ\Í73¼öa\0‡®þõ_‚+¤³\ÌG¸¸\è\âjQ…\ÏÁG706$]\éôJMð‹33¨\â¹WOð\Òn|\ïE\'\î=vb1a\0V2™A^n\Z\Ó;‰ªÇŠŠU \Æ+% \Ø\Ýw9¬\Êc*\0/^O}¯\Ã(žñ€*\Æ@L}QC ™Y\î|5ÿtM%6\Õq!VˆA\\Iwaþÿ\îÌ¸ù\Ûý²X\Zf~«•“x@,ÀˆÿSm©\ÐT¦¹\Ü]|Ý¾§ÀY÷\Úþš\Ì\Zhµk’iI1mI\ÆÀÇ—‹6–°¬X\0\n–8Àÿü\Í\ß|=‘\0ùýb1.;\Þ\Æ‚ª‚p\×[e°\Ï/,>!ü\ÛÁ3/{‘«5ñ\Í7#<<ˆ\ã\ß~g\ß{\î\0‹E•Jÿþo\á\ãûT\ê¸ý¼\Û‡;Ù¤…ñ´„|¾„¿ÿ\å\ÒÙ¬€CóEM\"n\îš.…\Õ+F &ŸÁ\Íÿ”qMÌ¿x%4wÿ‚YO:A\ìL`Æˆ\ÐSpÉšt\ÝJ \Ö. \ÛÈ¬ µR\0.±\0F)l\nkZ\Ål¤;ŸA-€.\îú¹ù\Û\ÌD\Õ\ë)Q\0*\Ó<Z\0úyj1˜3\Úgl$ŠÁ4Rß£Û£€¹»ýº\Ä\0^ƒASüþÅ´…«‹.\çm\\.Ú¸˜·±1›–\íª\Ùg\0w\ÙE&—Á\í\Çl\îûÄ§ùu_ÿ\Í{—ó../ü=´P±±t]\\^vU˜\àŸ¾ž\"ž«â§¿qãŸ¾žÁH\ã\Ï¼‡H¾†\ßs£T\Ì\á\Ñ^\ß}þÿ\í_Fðø“ø\Î\Ï6ñ‹ß»±u¬`6¯Àqž\Å\ï\Þw\âòB-#Y\î‰\ÔÛºódG0;X\ÛÌ¡¹\Ã(x\î`‚\ÜA|>d@\'A#s\æÊºû¹\ë­o§@\í\ßa\Æ\0p\Ð\Ê-À®f#v##ßƒ\è •L\\¿?­‘DûEÌ†ZgÀ°W”Àp*®‰\nX@»‘E·•ehzT\ÂbFðªŒù¤‚«E—\Äú\ç5Y‹9•¬ŒÅ´†7†Üƒº½\Zš:*\å\ZÊ•Š•&ò¥\ZR…Rù:¹B‰\Z6P\è4\Å_3Ã›\Ä_þðno\åq\èH\Ã.\á{¿\Ú\ÂÃ0\Æ\Ó6®.iöÛª\0W£¥û°A ±|*€(\Ë\å\0ÿüOc<\ÚK\á\Æ\í\0ž>\à\Ù\×\Ï/¶ðÿü\ë/½\ã@£]\Å\ï\ßs\ãµ÷Nð\ÕW-´º%¼ø–Ÿ\ÝõJ\Z\Ø2-\à\Ó1ì¤qqUÅ€\ÂH@w_Vv9}¥fŠ£K\Z%9¹ñ\íÆ”[?dA\Æ\ìpûš|^+‡v+³4\é\ê4ò§õZy´\ZYT”f=…z%!© \05\ã\n®\æ\Ì\Ù\é»+¸^4q5\'\êH\å«`1-\ãbZÅœ£A\r£Nƒv­zù|\ÅR\åJ•j\Åb¹\\µz\r\é|\éBñL¡h\Ñd\áh_n\n\çn^cDS8v\'°wžÀ¾#Ž#W®@\î@¡h\Z\ÉlùB\år·f0Ÿw±w\â\Ç7\ßLñ\à …¿{Á‹\Ë\ëÂ±þ\ìû¸q;W\Þ\r\ã\åw=ºª0¢4ƒe1ˆ1‚*CWWL)\ÛR\éû\æ\ë>\Þþ4Ž#O\Ãq?z\é\áTŸ|\î\ÅÝ­¾þ§>¾\Øô\á\ÔÁå¥¦yý!SÀ*f3\æü„‹«%³¨V‹‚Ž1\Úe>\Ë\0¦º\Ñ`\n\ÈÔ¯$Š@¡I\äO…óª¾]j\Æ\rˆ\Ù\í¥:7%\ê\Ø\ËkaE‚¹,:D¹\éº´ú\Ùü»½.ƒC*FÃž¦Œ\ÍZJ\Ð\Ón¯„V»„z³€Z­€b!‹\\&‰l.D\"‚@0Œs—_\Ö\î±[\ç\Ø9ta{ß{Npó‹\ÜypŠO°¹s†û›G¸ûð\0›»ç¸»yŒ{[\'¸ûˆ¯\á\Þ\æ6wOðh\çû\Ç.\ì»pz\î†\Û\ë‚\Ó\ë„\×\ëA0\àE0\èF(\â‘z@!E6DF\Ì(6~öFÏ¿\éÁ\ÖIÿò/S8Šø³ž\ãÅ·½xöU7þ\Ó3N4Z}ü·]\à7\ï†\àô\çðÕ—Š\'\Óô3h”\0\ÒX‚Ù´…‹…ºZŠ«‹.~õº\áTÿüõû\În\ÜôŠ+˜/Zq²\Ä<v0,I\Þ/\ÅÂ R\0b%‘0Ÿ2ºâ ‚ž”Si®‹h\ÔóHÊ¨ój\ï¯,\×x¨©•QRý«h¥­_eÒŠ\\½\ÑÀš\Íšõ$\ê•8ªE¢Ša\Ä\âACnœ¹N±wp€\í\Ý<\Ü\ÜÂûðñG¸õ`_<\Ø¡=x|ˆ›xøø\0[\Ûû8<8\Åþñ1vöq\â8Å¹óN·>Ÿ¡ >Ÿþ€‰¤\ÉT\0B\Ìùª\Å$\Z•Œ¬N=v3‡]–qI¿ŠÑˆ¥òŠB\é\Ã\Z\Þ;úÿªdýa}¦€\ã–\à,‹«±}l5|ò(†\é\å\0ÿõ¿\á	ðö\Ç\\>y‚¯¾Z`\ßQÂ_>Ã›!\Ü=Hc4%bHp‡‹9??„˜22k\è\á\é—Z@’\ê\âEgþ\"†“Ž\Ô¾ü²‡§_õñ\å\ÓFó\n¦Â’\ÌfZ\è™N5u“€nFDOÿ±Á°ˆN7\'ð-#e}ô½µZ\ÅR\Ò\ä\Ï)4jITK\Ä\åc(—b(fÈ¥\ÜÈ¥=È¤]H\ÆÏ‘Nxˆ:r>E4r†p\Ð·\ë‡\';\Ø\Ú\Û\Ã÷·qûþn\Þ\ÙÆ½Û¸ÿpÛ»û8<:€\Ó\í„\Ç\ë†\Û\ãD \èF0\ìA$JøÙr1v»€N›Ö‰ÖƒÖ‡(]AS;Uý¢\Öö‡eD\æ¨\âÿUm\ä\Ða…“.Ë¤³Œ!\ë7¸†S0\Ô,€€d@L)G¬(ú\Éô‘›GŠl\"eQ’Ù¬‰‹\Ë66*•0Š¥0Rš„ Nn\Üø`•jJŠD\Åb\'®\0ö\Ï\È\à\Ï\ç‹q\ä‹1Y\Þ\äR\\\n2•J\åJ¥ª^\Ëe}¹m¹œ@®F*@&@6B2\åC2Å’¨ñ„Ñˆ±˜\Ñ(q~\Ö\ÎŽ°ôy&u\0\Ö¼žS¸<\'8=?Áññ1\\žS¸Y\Ä	\Ã8‡\Ï\çP“ö –ð!™ô ™p#“ö ›ò\" À\ïó\Â\íõ\ã\Ø\á\ÃþQ\0\Ûû~øqx\êÅ™;8‰x2|9Z#‡aßž)\âHå±ˆ\Í?‘HZŒV\Z\ÍZf\ÚŠB\ÒDWu\Åa+-N\ãAQ\êúNµz•ZÍŽ\É(˜\×0\r“\Ú\Ú%™€Iÿ$4\Ê!dšI“&.\ÆM,¦M\Ä³–\ÔXJ¸\èb£\ÛkJ\ÕHR†ñ\â\Zš‚5´Ð¤\Ï+£\×)¡V¥Î£V/\È\ë•Z¥2wa•JNWUŽAF¡JY¡ŸS\È\Ç\Ík	Q®‚,>æŠ¡\Ìj$	\rµ””CkŒ”B[­<šêµœ¸ŠÛÂ¸¿\å\Ã|\ÚF¿O\Î@\Õ\Üµ’\ê2\n\Åb±$üŽq;¢²Ž¸ýID¤²i”JŒ\ì\Õ\rÀˆ}\Ð\Ót¬\ÕÎ \ÕN	£\Åh¿©\"3®U ˜Á-…&E\"~ø˜ö1C¨,¡\á9\ÝS=º5Z\rù\ì\ìZ\nZ\Ïe2\ä+`.«\0¬®”@Á¡\ËyK@m\æD$\Ò\ç„\ÔGt\Ó&6\æc\Ì	þøöúz†¹\0@s	Y\ÜY\\MÞµ\0Ò¿´®/ÀE\è—€YÀ\ÓDK.4k˜±?­É’/\Êú´jµóŸ\Ñ\è}FôOHJ\î\à\ÕÒ¡¸û\è.>~\Çgƒ8ñ$ñ\è0Ž­ƒ(\î\îøpgË‡\Û!l\í±u\àÇ©#_Pw3«›õot\Ãn^nþ¬W5g\ÚÅ´U½f\ÃVA\à`\ÆDúk|ù\Ë-S	\Ö€¦\é\'q\0\âLûúf\äÏ s6d\æQ`”ŠÁx†~] hó\\\è`\âT	ñ[ñl±\è[\n ü‡&ó¦dP\ÊL5‰}LøzK,Á„–`X!!„4­¦3²uÆ¸¸œ`6\ç\ã‘\\gs¾7 3‚A&ÿŸ„Oh)^|_©]J\ï’jý•aû0¨\ã\"$©_˜8=±{[+\×¨P¾Œ¯”Ü–`izyÃ¦5|x/„‡‡1ìž§°u’€;˜E(‘A¦”—\Z8#Q\Æe\\1G\ænav`¢ÿ¡\Éÿ‡œ\àû£VA°~bþú</¯d‹÷+\àc@U€\ìR{ð1ñ{©\á›Z€®2\æ,ú6P\ÂlRÀt¬B&\r–¦A bl \ßqu?–H 1õ\Â\r0ˆ\à’û8o-©pR \ZU1`½C°\ãf¬´±0T¼\r\n\n@a\ÏcQ‚Ë«©¬É”\ÄÍ±(\0-?|´D\0‰EuM©]“†`üT.y.¼?–v\ÕY\à—¥°ö\ä?j9¦ªg‹\"Š\Ð1\ê/\È\ï|ðE\çž(\æ#­\Í3à¹š³\Ü\ËÜšÈŸ\ÍóWP®Eôd\Ø\é\Û7Â¶„O©úñ}ú}#tU[\\	\ß>&&@.•EXK¦ ô2\n^vzY)hòýŠòÝ©ŒD\"©`,\Ë\ï2¨\Æ\0ZðR‹X6dYµõ\ä=“\ÂÐŒf_\Ý@\à\ÞY[¯L\Ïgm\ÙýŒ	¨\0L\Ù7t—\ë¢\"P®®g¢\0|M˜»C\Ù\å\ë\ì`U„®¤zü \îx.Ò¸,Á\Ó*À˜˜8ñw1øÅ¹ó\×#W#|«–9³T–sÍ`Nz\ç¦.O\ív­«hB\ã®òòfrsóº\Ëmoð|Â¹D\Ýú$}P°4ñ\Ä\ßY\ï7\n@\ÄO\n@\Äè—¥\Þ $\ÄL³û	d·‘F®„‘73¬\àŠ;–i&ùRV—À¸@\ê\0¦\Ü\Ì\Ïn‘TJl\ÂT/\Å\"\Ò0V\è2&/@7\Ð\íä½”²°ºký\Ò\ì_Qø\Ë\ÕÁ%É·F>\ãIoi\Ôô«°\n!l\á«\ÑZ\È‹+,L%X§v\ÛE+ •\'B¡5MgŒ‰¸Ö uV\ÖÙ¾\ëJ°,ˆ\áÍ˜5ðÎ§>8\\at»y)•&2iüúõc4ª\Çe\Ü\Ûr!	\nÌªžÁùÛº\ë\äy§€°WD§¡þwl„\ÏxÀ*‚\ÔŒ¿·\ìÿZ¨—¨\rle—h¤Rª‚6\Òg\Ûò/•”t.~¾±.¤¼\Ù\"¢š\Æ*JÐ¨J#\Ô0±¢\ê\ìF²\0­ƒfT€¦\âÿ\"ôöò17\"-€dV\ÐV	(||¹óy¯W\Ícõù*|kN–V€µö5E\Ð/È‚©\Ðú\ÏY¤n\Ý\ç\ËsÃƒó\'~»Œ	}¡)\Ù\n’7©\á\Æ\Ç!øQ!J^_\Öp\îM\ãþ|\édóyÏ½z€H,§³\Zz\í®x£\Æ4Á¼h~+\è4rðº}H&B\è¶\ÓWºwƒ­œChl\à§u-ÿŠ\ïo¤5\0¬&…‡\È@V`‰<šÿ\×R\Éèž¬°,cU\È°¿c6X\0V.YÅ“`\ÎP\Ý\'4ûÍ¥\ëTkÀz\0-A‹qC\ÒÀ\Ëi—,©Oš¸&Ë›¬)\Æ—=l¬\ï~úú\Ë+R¸t\ç«ù\'\Éc´ôùô÷©\0$jH]À4w¬v¾.¦´\nR†\äs#h©\Ù[\ßÆbk\ß\Ö\r˜€O\êûôÆ‡eGh\êó\æ?ú\áF\Ñ\ã\rWðÆ§üõ\Ï\Ïñ»wN±wÆ›ºq\ï¡7\Ïq=+\á\à\äùL\Þ>\ÅÝ‡\çt³øõ\ëð«WwñÑ­©\'Ð„“›\ß\á\çŽ7‚\ÖZ¿\nžB\×r°>f\äN\ß\ÏZ@µ—EX\ØZ1~g¤ñ\é\nM5ú·ñFM-9\á\n¸C+\É{$U¾Šy\Ø\Èòd\ÒÀS6\É}\É\"­m±¨dL\Í/ZB»Ztdi\Äß”²/¯Ü„$\Ðj3@g<&\n@Ás1”´\Ï\ì|^¥®/<š¨è²¬\ßK\çw9©\Þù+ÇŸHÿ8ý¾\î|kþå†¬û{£\Ö\\À\Ðú\ìnQŠ)‚tM\êx\í\Ýðc÷ú%üè·§F3ø\èž\ßyvX\Zñ“Cüò¯¼\ëÀ÷ÇŸ\ã\'/l\áÇ¿9“BS4\Å_|oNGXòñ~7‹F#)f˜Â§?\æ\ê\'€¨£*‘=\Ö¸\Ë;K%\ÉI@Eh»¨&\Éh¶,È¦\Ô-\Ìÿ&qƒ½v#~n=£¥Z”¬Z5ŽR1*«ZŠ£VŒ¡š Zˆ T Á5Š›<\ÒAiúH&ƒH$ƒ‚÷§S!$A\Ä³üˆÄ½ˆÄ¸ˆ\ÄüˆÆ¹¼\ê¬ð)p»d×›Z¿¼fMÿT?\Ù\é\ãó§šr0\åcnÉ«,\Ûñ3Y\å¬jòW=\ß\nüL\ÙUn–![ö\Ì\ÕnôÝ„6_y÷\Þ@\ÓY\é\\?x\áõj‹)«qU¸½A|ÿW‡x\á=Þ¿\ÂO~s \Êø\Åf@±p\Zÿñ\ïwñŸ~¸[wx\êv³\Æ\ÜÓ¯Ó¿§\Ðir1\ÈS˜¹RŠH·M¾A&D:\íG*\á•þ\0Ÿ\ç\ß1|\Þ#\'‚d†\Â\çˆÆ”\Ñ\ìõHs{\Ø\n8ðŸÁ\ë9\Ëy\çÁˆ!² #n„B.D\Ãn\Ä#>$¢¤´û‘N†I‡QMg‚\È\ä\ÂR3\È\çH\éÏ * »,jj\Í\"š\í:=Ã´\ê“l\ÓDoÀ\Ú\0Adú,”»· p³fú\ÉÚ½¸¤u`?;…z˜Ï˜ö­\"|»\ëYÄ¡ðù˜\Ê ôd±\Z”,}¾õÿCú9ú.\â\à\ßN\Å\nøCW¡\ÏY¸!©ƒù5ù\ï¯Hºx³yh/½sŠ~\'‹N#‹\é°¯Çx\Ü\'}l¸H%‚\è4’89\ãM÷ ñ\ã×¯\Ü\Ã\ßý\äü\Ã\Ï?ÄƒÍ‡HDœxŽ\áv\îÀ\åØ…\×}{<\Ú7\à÷œÀ\í<„\Çu¯÷\à9‚l\îð³·\à\ß)¢!—P\ÒóùJ…„\Ð\Ï0\æf{\0\0 \0IDATu\n%)JÖ¨¥\Ñd³I\n¦e³•G¹’–L¦\Ï@µ_Ø™9üXH%\êh5³ºfR²4›Rz8Sìº€n¶\ßR2ƒ…‚?W6`gð·\àcfulLè›§möl\ÑAO\Ù9\Â]N\ßq\ÙÅ„_x\Ü\í\Ú\È!f\Þ\\iŠ¥°a®ð±4K3È€‹%S¡;©\ßl“\ÉFH\ÖŠ4wl\êÈ…Kú‘\'¯?\áG\"\ê–fŽX\Ø%MÁ ¶Hý\ä7w°µw ;\î\àøw\áv\í\ãülnÏ‰t\áPX.÷1ÜžSøü\ì\Ô9‘z?/ð!#ýqŸ\ÓXRŒ£ZbDO8:v‹\æ?+ßµ#)\'›dròÿ\È\ã¦b­zõZR\Ë\Ú-	\É&B?\'M\Â\\ö\n}l°f \Â\ëI¹/\Ö\r²\Î i\í¤*Tw¦€BeVe‚=\É2\È;0,aK4\Ð<¾\\´–ñ™@O®ÔŠK@_Žø\n{\å\Z‰¤\Âú1{\Ëâ‰€¬0›1b^\éG]¦C2hª\Ø\ê\Ä\å÷ŸÁ\ç\å\r?3&\ïLv	Íž›;\Êwbv+i\Ú\Ó”\ÏdñÇp˜5l6€8‹º»‘ˆz‘IIJù¥A\å\Ù\ß\íÁ\å\ÈÎª–\Ò!Ô¨i«q\ÜUf=¡Œ\åe÷±bÈ’2ÝŠ ‹=cdú\ä1\ê\éb¿\Ç\Õf\ÃeZ \ã~Wó~fl\Â$fÀ^ÀN=-½\06¬•\ã’\nVkIa1›`\ÐGkfƒ?\Û+°w\r\n\Ø&±u™ö*\á•|G\îðK\Ëf&@)µX\ã^M\nÈ¬@—²…¯.;\"t\ì–\àQ•@8CAüFc¢x\Éˆ\rp±Ic<\å\ë\ì\ãk ?\"CG©\ÅRƒ²Ó¤.mHi\éb\í¹,)\ÝúXËl\Þ‘\èÁŸ#<\ÉX@\\!wHÀ\ÜY_c\ÅJ `‰m7…F–N\r¯\Üp\"‘ˆcNÄ¹7Ñ¼®Â¶B\èh\'\Ñ\ë¤\Ð\ï¤\Ñk\'\Ñm¥%ÈªV\Ê\ãcl\Ñf®ñQ¿1\Û\Ô\Ø\ÜAŠ¹ ƒù¼™Saò\çY\'\\!\'Å›®±f´dT\0¦d5qt	³\0$… ¦ ŠH—ÿ\ßNN”®g€¥\í]°Š \Ð0\ç\Ñ\Ê\nX>K½T\n\áHZ\á\Û\È\ß\Ð\Å)üu%\á‹5\èb<–,@3€u4pu5øÀ¢‹Ù‚\r\n\î¨+¨)\Ük7\'ôYA\ÅˆK²¿¯„\á\Ü}–N	m*\ÃF´\\X!\rKQ0¾G@¦¿\Ö|aqx\î@i©\ê•ñ\Ò[$’qH\å\nWO>\'-\Â\é·Óº:º:\Í$Z\rr¢’³KN\ß\ÊP¨ \n\Ä:\0Û¿µ& ó\0¤.\Ð\Ôztµ\nò÷øw v\r\nP5\n@^B»[\Ò\Ê\ìl€…™@aJ‡²)\ÌbK]Œ\Ä:Œ£¬+ \"&^À\ÙH…/Š JAÿ¯PšòµEø4û\Ö<¹\î-€s®\Ä%t0·¨\0+€»\ÞV©a_˜%„xh¯.‰ü%ú\ç§ð\Ë& u‹\\>\îd*\0­À\n\ÚLž&Q\Ò/õu«›Â’KÁXŠ¶*INLv§UÀo#›MaN\ë\Ñ\ÎI±e1$+Ww¼<•`\Ðañ&‰n‡)V\\\0Fõ]\é\ç\Ó^´X‚\nœ»]jŠr\çËHE9‰¤\Å\n0kh\ÔÓ‚Khˆ?Kù˜±\0M=È‚þ±™µû¸_–O\àa K\ÏÀ\×R\Þlƒ(-\0™Át! ›\Â\ë\Êôm‰¢È®7~ÿúª+‹ŠÀ\Å\×\èó.6¬ ÿ°& ø\0»wZ˜\Ò\à@Q>›æ‘†E`G¡‹´«%¨C&®þ\ëX¿\å\æQ!,\ÑR	ž†xiŠ>\â«Mj(\èM}¯„f£„_½uŽR1%D²k»õ\înº±}\àÃu|1ý)Y\Í>\Ý@\ÒXV­F¥(H½@k+3OHX‡/Pð%\Z\Ù4l,€Z­\Ð÷3Ðº@m¦\ä6³\Êÿ7\ÝA¼Òº\rdÝ›Ae\Ã*\0i\ã&û†²P\à”G@(˜\r\'\ì’žƒAY:œ´¤®\âRiŒ\È\Î\ç4U€§Oú¢W\Â\Ö\ê`ƒ\å\ß\Õn_\ßý¼öÁ,J°^Ø‘5\Ñz²;”\ÚT’/kñlo\ÚZu\èžð\ï\Ìn—]hš0e\çKS¦}]›3\ÄJ%\à\rk\Ô\nx\ámJ\Å4£2Ú•<>¿\çÀü\Ø:tc0\È\Ê\Î\ç•Ô°™D—«E\á\'”\Ê\Ý 	$*\Âc´n;\nW-\0ÿ>\ÝRV\â*…¼\ÞÌ£/\ÔmöÀ¡Q(c\ät\r„ŸI¨—…q†  *\0Àv\'\'\\HZMZR‚9:†=Šƒ’\n\\ºšj\"d)\Ó*\Æò/«¡“ºŒ‹aÑ‡¤\\\nýb¡q\0¯;_­©{—V¬\Ðm@(;Ö“)\ë2\Õ3$\Ç7¹¾MûXÿS/\ìZÝ½\Ò\Ø ~Ì–s)d…Cùže¼\ØR«Uy)–™¹#7Iµ uJhÖ²xù\Æ9Ê¥$.&E\Ü\Ûô\Â\éö\ãjF«’Æ —ÁMúyÌ‡)Lz)Qˆñ ƒ¡Tþ2h¶\Ò2N¥V‰£UOûõý~›¥Yµ ø5s\è\×3\Ë\Þ@	ô\ê´™ú-?K\ÂV¥\Âhú¤õŒ<SŠ–3,\×\ÓÚdˆ­\Âf6P9]ˆ”ˆMÿ€Ll§dŠ«\ÐjpN³úw	þ.V.\á	©úË€°%»_,Àz@OEP\0h­¬+\n`>*€ƒ±[‡\ís—†Õ²Ž\ì­UXQ@¤ÿ\ÄKÆ°V\ÂZv=÷\ê\ê5\n5n:‘JE1\ê\Ñ\çf1“C*‚\×\ïE.Â°•BÀ\Â\ë\ï\ìb÷\àý^N0{š\íJ1†‘@’M\Û\ÜøwH\Z\àð\'£\"üFƒzV,Â FH(8‰FU]ŒP\Ç\Èh©U‘\Î\"[0§´ƒ2<‚e\nhH¢T‹„\ÊkF7QÿrF€yL…/\æþÖ—OøòI_\ÏÙ£Á\É0\ËÀ®ñde¨\0Œô™/.$jT³\Ï4N,À°Œ.Qð\Üýôé’†\ZES\Î\Ü\ÜLë…•u†\Í:\Ùbù¶\ë–nJ\Ò\Ï#_\Êã—¿?C«‘\ÃbTÀ›\ïÀ\íq`>d\Í ‹­­cD‚a\Ü~\ä\Âþñ&m;P®\äñ§ß¹¿{þ1¶¼t3¬Ñ„s÷j`¨i]¯•F_L<\Ó\Èú\Ì\é\ë\Ùõ\Ä\í;Dñ¸kù¼‘U\È4‡\Ð\Ðô\ËÿdÜ—ôHÿ¡\Öù\ád`\'”t\n9÷-ú:=§DI	™3p–4¸€þ €\á¨(ñ–Z‰’ü\r‚Eœ¢\Ò\í\Ð!fÁ\0•¯1\í®,­T/£MMh»™Á\ÆDò|õ÷c\Î\ê‘\ç¤viŸ¾²{”\äA ­Ø®n¯ ­\Ù\\}Ž+°7]Mµ\îh\Ý\Í\ë‚þÿ£S©©_V¤È²F¶°?KÔ­\×\É SH\á7o;„\0r9M\ã\ác/n\Þ>Á\Å(‹v-ƒg^\ØD>Ÿô\íwö1Ž§¤)\å\ÍO\Ý8v81\ê1}cº\ÆÝ§‡y<-o6Iº¦i!±0‚ùe¥ \Óf\'oJP¼r9†R>*…šJ).º8ª&“&p\å—\Ç\é$©\ãd+;q\Ô¢‘sü¤¦»ø\nøœ`Ú±\\ùž\ß\Ç\Ç: Š(¨€kfr\n\çq’\n\çqB\n\'¦ðu>Ž\Æ<H¤µ@”JpP\'¸p8\'»p\ÒK\\-\0\Ó?ö’sIoþX…?ó¹v\èZ&©>\Ñ\ë1z\Í™H‡4ñ5›\×D\ÊÀ\Êúq¶[5ÉS\æ«þŒñ•Í¬e\â\ëmßt\æ(Ê¦Ÿ¥Ÿ1\ègQ¬\äñò\ÛN\é\rðBø\Î\Ïvñ\'\ß,ù}¹”\Âo\Þ\Ü\ÂWO:\Ø>p\áõwOqwóÿð‹M\Üøô}z‚nnIu­VN RŽ Z&\Í!M~¤HSOyH¸ˆœ#9G„´tß±,Ÿ\ë>\×!ÜŽ}¸œû8?\ß\Ã\é\é.\ÎNw\á<Ýƒ\ãl®³=©}gR?\à5\Zr#\ál!\âq’\Òü”•Î†Q*qÖ‘ö8Tªi©\rTkTªTkY\Ôy4\Zyt;\ì1\à½\Ö\Þ½j·\å£\Ô;­\Â*7“\ÝÖ„ú™\â“\ÏÁ\è_\Ûö—}\å*ú§»ŸÂ§ùŸ\Ír„G­\ï_5°\È#\è}Öˆ\Ý:¹%cgdùò‚\Ø)‚§ù¬º›÷¯?¦«\ÐV¬´3\Ø4\ë\n\ï\n´J¢E)‚Z‰¥\ÐÂ±^zs‰„ñˆŸ\ã\ã\Ïwž\á\ä\ä\0·ï±°\ãÁwŸ½…?û\îgøõ«_\à\à•7\î\àù\×\î\àW/\ß\Ä\ã­ûpœ\í\àü|.\×>Ž]©%¸\\‡pºe§E‚N\Ä#$\â^\Ä\ã^¡3\é \Ö\r\nJag£\\Ñžˆ‹<FÁ—DLG´OY\Í%mc#0¨ \Ý)¡M€Éº.\Ã|¢‹¥ue†@7«Á«ùRD3\àš\ÔH~+5L\ë\Ê\Ô!‰Z«EDðº‹f»\"sd\ZÍ²ô° \Õf?\0\ç\ÕÐ oc\Þ\Ì\\—\Ì\×\n=R(±!¤A©•k!D.\íC&\åAZfß±Ç…»p\ÌD®XÄ‰pðL\n8¬ q\Ì\Z\çß±f\àrÀ\åa!\ç\0n\×\\\Î8{8wì‰œŽ]y\îr\â\äü\Ïþ\æ>Žò >A4z†pÀXÄM\â)›–\Ê!¡v\Ó\×3?´StiúY¸I¡]OÉ \Å>—aü\ÐG²°#>œŠL¸V2ƒ¬þ¬\\3\è°‰­cM^u8£˜h\ÙH\Õ+Á!$¹xB\Ô\ê9\Ô\Zt;š%,1“q\ÃqE\Ü\ìR–sW\Í\"dSr—š)ü\Ø\èß¢ƒ|M·ð\äR;»ˆlp‚W<‘ž7‚\â	ö¿…\ä1_‹\ÇüR ‰\Å|ˆ°P\ÃB\'s…2©Kj\Ö<Fùº\Ñ»|X\Äq#ó •ð!÷!`=[W6@.B>\ÏZvX‰D dU’¨\×¬de$œ­&–kyü\î†\Å<\'s²¥š9?A\ãn\Z&{!%0ì‘¬I %óÿº\Íú„ŒÛ¬õ\'\Ðk¦-\ìµX\Äa—/3VI\ÐP\Õ].þ\\Ff\ÌBp\Ý(€ºuotkB\í¬\Ò]\ÝË€K¦Š¶\ì-s4Àc\äOkA¶ð²…\ÌTþ$\à\î¶cp\rÑ–;]ò3i•WöPg­2\ØY¢ƒ—Wl¯e\06-Ô P\æþqh*\Ñôˆh\Èl:Ö«\é¤†Mf«˜ur\Ü	ö¬Lÿò*9¾	\Í\îJ)\Õ\Æ|\Ê2<;*hQB\çð¥«$ñ\Ûw\Ïd4»s[\æ÷F}­\æ\Õ\ÍgQi¡“}CdÐ¢L\í\ÚME-Z¸B\rc\è45Ÿ¯”\ÐE\åû\é®\Ö@Tø¶\"hÈ¡–&h\àZ\0Û¢\Âq×³\ã\Ç6´®\Ñ\Ìøs–·\ì0ü>ÁzE´Ø…lÀ4\Ë\0¶\ãa(PË®–R°~lsˆ\Ýý×¦¨“A¨\ä´\É\n\æ\ØÖ	ü\è÷‡MtH\Óx\ÂÁM:–Uª{ph\Ä\ß3¥J¦ùK>¬\Ø8\Ó#¦ozt7,wA˜zj)dk.%‡6B\æZÿû³\\¤[•«i¼ñ\Ñ)¢\á&y“™ø}D\"\Ùñ4\Íüyl”\îú5% 0\Ôm0b™7e^\ç5Žv“Kÿf©1½ÿ*TL9”žóš|\ïjRþ\ÖZ¦C\ëdA!	p\í`)ƒvòfú,;\Þð(,—‚d\nž\ão´¶š} –\êŸ\Öý¥ÁP\Ã\×\ËÀR2X\0….( \Ô\Ô\nlp>Ÿ–~­pv_ƒ‡\r*\ÕKY*L´=[\æ™&ú\ç•\ÂúvË”½ajþ,¥\Ê*\Åj‡0W…X>¯™i_3\ÊÀ*[µ“ºÿ{7\Ýc˜È´\ÌJù~ò\ËGøÙ¯vq\æð¡IAÒ‹\æ\î\Î`\Øc¶Aa\ê\î\ï4¹bþ©\âŒ2´\Z¬\æ%%³ 0mû\'¼\ÜL*\È¬ƒ\"ôû‰¨²\Z¨ lƒ	|‹Ul	¥-™\Î\È._v­÷Dðñ€µ\Î?P`)\ç¶O\Ð*]-ƒ |3¬Y\0©šI\áV8\'°?h\ÊDI\Ô8Òƒ¡Îœ\å\ÐÁ\Ùù,Jð±¤}L\Í`&.ú°o\í“¾Y­—],»\ÚÞ¬5X\Û\évñ}Q˜¥¥0\n`Û¯\ÚE¼\Ë¯/,Ú°Ÿ\Ç\Ñi\0·\î£R\Ï\á¹Wö¤	µK‚¥¸šzv$0BtU\è\Íz\ì[î€¯\Éj«S‰£˜£Ve\ë·*\0\Ñ@\î~\í\n2\ÔðŠ\Æ\0+kgmš>%\Ý]Z‡¼ ™\\t—R;1\Ôñ¥2D:(¾¢\ÕTð¶™Fiô\Ëi\èvÄ¾<CGÃ“%¬\ÖÀV\Å\nP8JŒ½t\\\Ý^ý\é],ÀÀ,ó*\Ô+Ìš\î*÷—Žó\Ïw­À\Í?¸\\†7¿tk\ï©rz\Ø\Úû1s÷¡‹|»«XHH\Úô\É]/\Î\\~Œ†9ŒG\Üy\àÀýnln;°s\âP³\\%9#i<A;	\Í\Út71\ìï¡ZŽkÀ¦ŽUŒ°|þ¿\Î\á	”ŠIMEðVÙ— •Z.\ëª\ÖG\Ö\ç	-A±6[þYAö¤„nˆ²\ÚG €q>±vú\É\Z\Å\Þ\Â\ÂD\íù\Ê	P!¯›}«\0V6Cl¢Z#{´&Ó§\Éð\áDIZ\01ÿœ\È\Ñ#\ì¨}\ì4]Œ\Èe¶=ý8w¶	\Ô\ìn\ÇF \Ö\ç\ËcZ‚µ(y]1\Ä÷AKPe}ªùÝ†\Ý\égqg3Œýc·\Ü4ò\0^{÷\ßù\Ñœj•ˆðùúƒ²™0?ö\áÖTJa¼\É@\æ\Ó\"~ý\Ê.¢Áú]\Ýñ=²€©†O` \Çø¦Á\Ù\Â:ƒŸ\ßi•Ò©©\ç÷g\æ\"±€¹ð^%^µ“s\ÂòGÑªD	–E4\Ó+.€=ƒb\é+Ê¤‚¢8jÉ¦‡Œ	4>°}v*Xs)|\á,\Új¸ó‰/\' 4¯~M&‚\Ó÷Sø\Üñ\Üy-š.F\í²¨\0Êˆ¡¶šo¹¥\ÐY(©ª?3)\ïk\áD~‡¿o.¾”\Úr\Â…+\àï’¸\Ù\íeð`;ˆ[LFtOü\à;\Ø?õc6­\àoø@!\Z\â\Ïo\á\ïŸ\Û\Æñ™•B\Ïþ\îo¾{ )\Þk\ïû\à÷1\è%\Ðn\Ð\r$\Ðm&LŠ\È4O•›þ¾K‹DÞŸUÁüUð\ZŸ¨‚Ö«dÅ—›ÀC\ê\Æ‰”®¡™C­šF«¥#\î(hò\ÍTSC\á\ï2&°mól„™\Öp}Ñ’‰a<„T/.š¸¼d\Ó\Çÿs\×wp}\Í¯¿õbYøš)¢2ˆ¤\Z\Ø\ës\ÆlM†Dtº5„:]òýš2^”\Â_š|¡0¸\Ð9öi\Úd9TþAó›\Ó*˜\Öi\ÛôJ	\äu£|_\èS²(†*‡”U\å÷u÷+¸¢i‹qôºY\ìðù}\'¦#‚UyüôWû¨VSpº\Âø\ßþ\ì6w½¨¢¸qÓ>;\Äå¢ˆ\ï\á/~¶ƒ\Û÷œH§¢x\ãýsD\Âô:…\"J©\'\Ô\ÇðaðUÏ \ÏL‚#\à%u\Í*\ä\Ì\ï\Õ\äŒ­j\ê\î\Ö,‡EõõZ»`­Á\Æòÿ\n€D>BB&±Ô˜¶62\ÂD&öQ\áÿY\ÐZ‚LR\Éd‚­Y†‡?FN(¬h™‡CpŠ:§ª—\ás}-<l†x\rI¼\ì3`\Ý ô ôªp1e\è\r¤\ÏW@¿/$°v-ÿ„\nž9¶°0bŒ\éVv…kóyk\ÌÎ—\Ýo8t\î¥p\ëk¿\Ï\ç\\\Òc\Èüy6d°s\âŽ\á\æ\çŒY\ärIüü\å]„\âaüÅ\ãþò~ðüŒû|rÇ…G[|uUÆ‰#Œo¹ð¯_\Õ\Ñmñ\Ö‡\è\Ò÷™£k˜P´pýˆ.-“*&12\á\è|D\Î\à\rg±\'w#\åw!D\ê:›?<Gð¸ö\áó\Â\ëÞ‡\Çy\ç\Ù>NOvpz¾‡³³]œž\î\Ã\í>\Ëu§\ëD\è\ë\ç)œn¢£œCdf\ÉH}7\Â\Ö)´(ž\àI Ad\Òa”Š	\éC\È\çˆ\ÎrŒOµ\Z-LÆŒ\Â\ç\æeÍ†\Ð2\ã<\rü9@r£\Û\å4i\æš\ä\îWÑ‘\é\Òe9(‚;^ƒ=3CŸ›\Ú\ÅHB\áÎ•š:gQ€\Æ\Ìó=\Þ<k\ì®\'o^\â\0±D\Þ\à#\äJSJe=@ðº“Ä­TN\ÈM_(…On»1sV^¯½·[Žð\êC|p\ç¶\ÎP/Gñöq|rŒN=‚\Û÷÷ñ\É\Ç[(\ç¼8;=Á\Ã;ˆñH9,\ân\ç.\\Ž=8\Ï÷\á<ÛƒCŠ;»p°\Ð\Ã\ëÙ®œ\Î¸\ÜGp8\àp\Â\ë!õ•9b•\Ï)\è(SGóP‰¼Lüb\ïû(¤*¤±sbI[h*EJ»òjtõ#£š€Y\ÓB™ò€%\Þ\n\æ?[©#=‚\Ëv<\å\n0+dŠ•$\Ú\å™Aœ\Ê\ÍcFZJýæˆ±!\Ðr¯TþÖªNŠú‘˜I\ÃL\É4f\ÜFð,«\Ò\Çj·¬\ÖÚ¹{˜J8µ‹Ç®pPF%}HÇ½H\Äxf\Î)\"!bû§e\Ø\ä\á=\ÃÉ‚\r«oð{pÿ\Ñ^zõ>|®\ì\ï\à\áƒ-œžn\Ã\ç\ÞCÀ¹÷\éŽn\ïpgg;ð8\àt\Â\ã¶Ç´œi\"J¨Út‚Á¡šY\Î2*ã¨°I„–©¢=\Ò\Õ\Ã|^Æ¹¨%´³Œ˜“SH63óv\éO ³‰§›w\Ðp\Z|n m˜&½³B±t\ÊdqpÄ½-?¢‰¤\Ô#h•S\ÉÚ”‘\Æ\Òn\'#õu¦\"\Ú°„Q™l€t0¢ƒ\ê+xZ‡¡SnN \à„\ßwnÎº9‘>6N\çòyY§f/\Û1<.¶HÀ\Éj\Z‹5\ç\Ûpž\í\à\ìxK\×\É6\ÎOøš\î\"þœ\ãl®óœŸn\Ã%-V‡ð8÷\àu\Èr;÷\á÷²PtªÅ¢q\ÖX\×Nx\Í\n RŽ\ã\Ü\Ä;œ¨²\ÉH8=\êFòþZRR§F5k,\ÓJ›š¦Å¥©\ì\Ó\ä3\Â†¯Fô,ôÄ¤l|}•\×k™\ÚF÷š\Þ\åP,jxo?„—\Þ:F™M*,10¦…#å›¸9J†4‹iüý%\î/Á]©bwû‘*Upó^±T\Ã!\ÑW³^0c‰ž`Ž€\Ù\Ð\ÈVo}«S\ÈBÄ–..M\"Dó…$²\Ù²YA.¿\Â\Çô)iö\Õ%ŒðØ—(rù˜0\ä.É‘Á8^µk•“Â½¯\ÑwµK,‡-Š»¨2÷\å\Îa ijLZ× Y&Žl\0H¨–”\Ò+S¢h<…÷>=\ÃP hN\ß ‘A*…\Ó\ãG,D‹f)\ÌR-Z)¶x	óGû;DôØ¡KÃ¾n\Þc@\ê–\ä\íÜ­¨lJb%\Ì\æ•<|‘˜Œ¾}\å}N\ÏB\èv\é\Þlþoy\r–“F±C»›\Ã@&ŸšA\Ðó¶ƒp…\Ø:#H\Êld\Â\î´Æ«\0U,¦U|y\É>A\ÎUP<@Ž¶‘²°R\ÄWõü²\Ä\Þ\0\ã6Hø`m_ˆž2a’9?\Í?k*‰¹\ã\áQ•J\Ò\ìYò\ã\n\ëW!K \È S|y•®™*«|Qs«\Õ\êõU\0(\äž\Ìe3€õ€\Ð\Î”\ßKJœÎ¦ðþ\ÍsÙ©\ÕJ[û^|pûo}x„w?r\à\æ­}z»ªŠE\ZW·š\Ò#Üˆ¾1\Âo)\Õ|\Ù\êEÐ§ù\í\çÚ ¢ý–Î¶NQ\ãw™rø\å\çø\ì\ç\Þ\înº\Ð\í­R@µ&f%ñ„jJ\ç\"¤Î²¯€@dþ^\Ôq\ëQ|î“™¾‹1-ƒ2­Xƒ‘¹\nþ¢Žb©Šž\é\Äa\ÒJõAÔ¸‹\nJ)˜\'®0\Â\Ã2–\Í#mlH—T\Ô\ÏK´\Ïü–³\ï\è\ç¸Zœ˜tEL+I”\0mòXR$£v\ît+T\n\Ò^5\Õ\ÓÁ\âŠ\r\èR«Xº\ìZ±\Éo)\0ž\ÄjõÁ\'Nù§>þü7>q ›e}À>ˆV\éÒ²›Uø™•4•÷O\ß-)s{I÷Œ¹¦\Û0»Ÿ©Ü’¯Hª¶4¨p~\0›B2ø\îó»ð†b8pDqw+ˆÉ´ˆ.I£½œ¤uü\ß$¯\ï\å\Ä\n1ýcQ¬jvT\Ífi\ã~\æ5\'<®.\êK¦°X.\à\ÏH\'†t7…·\ï\ÄñÞ8¢\É$¾~\Ê:ÿª<LŸOS¯Ã£ð\Ü\0Rùj¸ž·eqjØ†¥‰tu\Ç\ÓGR\è\Ì\è¯õcûSEó_\á±Ó·®Uõ¨\ÝvLŠ\Í$‡7»\Ø\n\Ú\în¦t\ë\n\Â¤Mžª\0¼\ÚiüýñøRD)Üµl¥¾yÇr1‰A/‹Z%‡\ï>»+D\Îú£\ÏoTHøP7BK 8¦Ð­¤0äŽM5÷\ì7¤5`:(`Bf3ƒ1›E9\ÅS€r•¹¼\"µ\æ„?Ž¤ñ\ÌÛ¨\Ö\Ó\Ø9\ã£[N„\"„B¼ø\æ^xm6O±w\êÁ\ï\Þ\Ü\Å\íû;¨\Ó2ý#›g\\A»[Á\Ã\Ç¼ò‘p3sf9ff\àê¢‰l67>õ\É\Æ÷¾ˆ`ÿ,\r·?Ž;\ÜÈ§£¸¼Ð¾\ÛN67$­\ç!R£AC¦…±³˜4²\r\n\Ü\n]½²\ÅYÀ„,‰ü‘ŒaL²Í‘—\n`€\Z*€®ºµ‚ð\Çfü\Ùe\êhÍ¿µFqX„¡¢\ß¦ŽT\Ò2øðö¹œ„\ÉRi¹’þ[»¥a£šA»DKe\âˆJZ8ü\Ýjt¬¦0h±O d<‰v=‹\\:Ž\Ý}\'\"¡üŽ\Ç\íE4\ì®\Ã\Ëoc\×4\È@\Ç.+YŒGy<\Ø	\â­¨7sø\ì¾\ß{þ\0/¿¾d.…ÿðû†x¸À³¯œ\àó.<\Ús AÐˆÍ¬ý¦“\nn?ð\Â\ëOÀ-\àÆ‡§rŠ\n‹D:QD\Ù\Ö\Ø\×Oê¸¿ŸÆ«\ïù°½Ç£ƒ¦“^L7p\0\0 \0IDATýØÿ\åO •Œc>\Õr²\ä\ÙJœ\Ë!\ÒM±ò\ä\r\Òð,†\r‹\ï\Ë\î7>Þš\îxú+Q†©\Ï:þ„‚n7a\ÃS\Íj°yd^ÎªaRQ>5ÿ\ê\àg™\ßULÁ¸„5·!\nPUP\å#\Ã\'wož\É(”\Ñ x\"‰w?8\Õ~=’C:<\Ê5#.€¦½U¢š\n‹‡\í\àl\0©x´\ã\Âw~ü\0±x\n?{\å\ßi[û~üòµ=üúw»\Ø?9\Ç\Ã-\ÞüØ‡w>õJ(K\ÂZ\Ö\Í\ËQpo~zŽwœ\Ø\Ú	\à\íO½ø\ïÿ\Ï\Çø\Õk;ˆÅ“øþs\Û\èµ\nx\é]øó>ÀÉ¹\r\Ó`\r ˆñ¸„T.÷>=\Å\ÕEó‹^yßý\Ó\0ž\\p¨³\Öw\Ð/\á\Ë\ëÞ¼•\ÄÿþwN|z\×#\\ÿÿû›¾ØŽ\á\ã[>|y\ÅC¡´b(GðNZ\Ê\çp\éi\Ãp95§\"ˆ \Èc-\0\á\Í\æ\ÚÎ§ß—\Þz\n‡“º\Ù\nMáŠ¯_A¶Ö3\ßgÕŒK5+S!¬5°&\ÞZ‹u\ëaw¿m·®Q\éJ±\0zHs\Ür\"a<\ÌÁ\é\n\á\ÃÏŽ1\ì³\n˜\Æ\ç_\Ãq\æ—ŸI7‡û›gø\î\î\É@ˆ\ÓS/²\É8>»\ç\Æý\É#|ñ\È%\ÄÊ—\ß:?“ù\Äÿ\Ç_\íKšÙ¨ñ\Â+{hT‹ø\ä®§\ã©\\l\í.“÷û¿>\ÅÛŸzpÏƒxnÿÓŸ\Þ\Ã;ŸbóÐg^\Ü\â\Ì/~w„û{aB~TJ,)Ÿb1¯\àÀ\Çk\ï{$ÿ÷ú\"¸À3¯9ð\î\Ç.„£QÁ\èŽi\rü‘4þ\áE7ž{=ˆ\×\ßwã«§\r\n<ó\ËÇ‚þ1\à£`Iâµ Gò:´»\Ë\ëdjH ˆ‘=1[¬_w»*\0w»¥j‰\Ð\Ìµ…œR1¼,\àPX\ÓÀb>$‘¾@\Z\Ù[¥YƒT\0ó¾µ,²,!`óyö=—\"¦\àÄ†‡,>úœü\Ä8f\ã<vö=ø\â\á9¦£\Î\0þ\í_\ß\Çyvw¾8\ÇÑ‰ÿ\ë_>\Äÿ\Í.~ú\ë}<û\Ê^~m/\ßp\ão±+;{\Í~ýÚ®\ß~\ê\à·\ï9q\î\ä`Œ~ûö¾y\ÒÀ\Éy·oa<4Êƒ\"‰^x\ãD,\çG7÷qpÀ£Ç§¨’púüx¼\ëA(‘\ÆüþC¼wÓœ\áÖó\å(9}ªõ>\ß\n\áÁ–^?»Š\Ù,R\Ç\ã#Ž\Â‹0;œ(:«\áÁ~?\Çù$\Ñ\í·ñõ\ÓŽŽ\ÎBxú¥²ƒ¦sNpQ„p2\á\Ø\îúŠ€Nœ<“£f$\ÚX/ôH\Ð\'].:\æD¢~©\â©°;Sü¶LŠ‰P\Ö\é\Û\Ä\Ê\íN^¬Põóh\â\Õh`?eÖƒI[3 UY*:Œ¿†d&Ð½‡.xðÍ“\Z\î\Þ÷\à÷v‘+¤p\êô\âþŽÿ\æ\ßo\â\ÙW\Ïð—?\Þ\Ç\Íû\çxÿ³|÷\Ù}¼ðú!.fE¤R)¼úö®\Ìü\ì®\ßöv÷8òDdÀ”\×\ÂG·ð\ãR`PÆ£_\âñ86w<4-dÅŽ;•E ¬`Ÿ7Å‹¿?Áöa\Î`™BR\án“Eµ\ë´j¯bh62	¬’ SS‚,‡Q%F\åA6OX9„b^Éµ±ˆÉ˜\é„1Ÿñ\"õ	y—\Ó\\B,þD¼9Å…÷‹“_ˆ‘\0\r¨\Øh\é\çÍ¸vZ\0ó.-€},B\']J!^+\ìR!¼4ýüòöuû\Ø\n\Õ\Î\Õ\Ó\n¡ŒK0¢U¸uH\Ù2mhn\ÞsË”«y	|v†[w½p9ýü(\È\Ì\âê²„@0…¿ú\ÞC”kü\êõ}¼õœ\nV\Ä\ÖO&`2,È„±L:Ž\é„\'”ñœ\ãJ\Õ\îm»ð\Û÷\Îð\Ém¼þ Ü\"	¡ò#W\Ú{4\Ì18\Ç\Ò\í\ãó‘Ú¾¯K‘M—c_£`‡›\è§\ç^\ï\\N¶´±qŸ\ë7\Ç\ê8dÅŽ#s8&\'\îC$\æA”JJgO2B^Š@<~/…J‹™ZU¡š\çP­sp6«¹\æ\Ôñ\ØeGcN³/À;ì®—7ú|\ãÿ-K\×ú\ãõ²­\ÌÄ“ùvT=±›yZ‡Tþ\ìôLS²$f\ÒOG3¯Ke‘Ù†€Â•J¢\É6\ëv9¯¿—\ÅÍ»>¼uó7>=\Ä_ÿh\ß~7\Þ\ßF0\à”NyQ\Ì{\àr9ñ\Ö;_ ?“£Ý™*\Ê)\âQöÀ\ç>E\È{ˆ÷\0\'·+½ ×±kA\ß|N}ð©\Ð(° ŸC\ìwp\Â\Ï\ÇQ¢§ô@Ÿ¥ L}C©ˆ¦\åA—Bs—\ÓEÈŒ&Þ“\0‘\é¡v[›Á\Z\ìÁd\ÐIœ†¤«cOUe\ã.Y\Ú:~GiN\É\Þf#©ž&Î©jvn‡B,8ñE¦½ñÀ9x‘ ftú\Å\0Y\æNz\ì	Ê·2ß¶È“I{‘Jº‘\ç\É#™€)ö¨\ÙJ\'½\"9ª%\ÆC|\ß)»†óõ¸\ÂA‚\Î\à÷JeŽmX|\Ì\Ù{n\Ç¬\Â9\Ø²+\ÏCÁCüî‡ø\ásŸ\á\Ã\Ï`ss[\ZJ‚3x\ÜÔ®\Ð\ãÔ’l4À¢k\ãg\Ò\é#½tqN£R\â\ÅRBNB!žO\Åe}A¨[R\Ã_\ã=²ŽÀ4N†H\é\á\Ü8¤Á±\Þ`!pŠh5@cF\Åj \ÑLBAüE20™Wd;‰¨:‡\Ç\Â(7“Dõ}Ÿd¨aB\ÑaQö\0IVÅ…\é8˜B\å´QRý8ÒJ\Óò\ïW¡\É	\\ðû9Á‹\æ\éHÇªy\àuÁ\í8€Ë”H\ç{p;X\Û\æ•œi±rœ\îHñ\ç\ì\ä±}<N-þ8\Ïwdîž—U:+yúd…ƒ\'NTøÁ3\Ä\Â\çˆGH\ÆÜ¢<¹H\Ô×¥RA\ÙAt9l\Â\äM½¿\í†\ÇÀpÈ®%bfŸt\ìj×®\åñ+§_­Œm\Ø\èÈ°(\í¢µ\Ô.>¶\Í*L\Ã\î5Í©ë¶ö1†£RŒ.\ç\Û\à\Ø.~?[®ECŸLÏ„E\íP\r{Zj{	d^9wˆ£\ã,-Œ-a:,z58ZGò¢\èòu=f¾\×#ÿƒ\'\ÅÔ°‘\ÏG‘\ã\È\Ñ|ù<MUHú\éI….²ÀcŠ<\â\ësa”E\0,øh¹”½õ¶#–eSšüb!,)Ÿ›j1\Þ(©\ï³\ÅZØ²†Gh€$q	1\Û\×\è\"tða`b<Q\Ç~/ƒ‡;n¸%/—s‰ª1)\ZqBÛ¿Hû¶5\ÛwÀ4Rifj\ÝV„M\Åù‰ö)hs\åD0+h)¤Â°mðz„¼C÷gÿ–\ÎPb¨”\ÉŠ¢Ö…­UÄ‰ekŒ\"1ó0‹Õ¸\\Uûþrz¸™fw½\å\éùÁ\Â\à\Ô0BÁf~\Ðz«Ø‚\'¶O\Ûr.£\"=ÿ\Z¿$Ýº\n¢4YL1þ\Üfl`ƒ½B>¨¾ß¤|Œò\ÙÀò¹ýyq!†\æ%L.ó\Ø‰«Ì\ï¯AE²q*l\ÕR2\nY<[û>\ìz…¼\ÉZ}Eú‰¤\å,>¯\ß/£aˆ\í‹`\Ø\ìÁ¾?ÙZ ¡‰\æ\",ÌP:¡L—!¿<S€\'ƒ\Ê¡ü²`ÄƒŸ¤M\Ü‰&”™n²<U\Ôp%©\ÄTPºW\Þw	Þ¨l³7–@I¬€\ÝT\Ì8tN¡‚Al\nÕ£u\Ì\É\èbV‡I\Ù#\åm]ÀŽ³‡JH\ãÈ‚£;Ø°8ÿ2õ“HX—y:¡\Û\Ze…y-f¿„v\rx£Àf\Ö0\àU\n?&÷·\í]ªHš\Þ-£}«&c`JiÁ ‚@…bXn V3ô2\Ø>ôc{\Ï-,^~¯V3‰t&ŠOn\àý\Ï]ø\è\æ±TY|\á\Ò\Î%-=«p\ÒhSA³]Lúr\ß:DBpÿ¦i\íb§™b;ƒ˜\îµD-‹ù\ÛM.b\éL¡ŒJ\\\'?€n\ÃLN¥”	M³Á\à\ÏL±C³µ—PO2&%\ß\ášÿ·M\"ò˜\àOC*}–b­u\ÃQ]º¾xlŒ(\0S@º>+WôQ\ãbš¯—z ‚\\×°ýµü\ÞÂº6$>P6]\ÃV\È\n\"i\Î\Ï\Ï_Y}®ŸElÁ¤‘&M\ä\ã|!(\Ä\ë:†ƒO‚\Ø\ÜvJWšø$n2]ó‘é›‘öm\Í@h\ÉT	\ØË·\Î\ÑoEhµtX;‰¥D¼¦\ÚšÓŠ¢)\"ñu-+eœ\ÖG§„)¯@²\'3DRÍ¢\01\éÃ®\År0~\È+TztŽ\í˜.¢§ƒ¤´ød\Î°\ía\ÛcB\Ó ¦~urˆµ\Ù\ßnW%\èuI3«¯,€\Åýeôª0S9¢\\\Í4ƒ›**U	\Ö³4\Ûb\ÂUp+8˜V@Ý |<ó~w…ö­\êü}û\\k<Z.Œ\n]€¡³\Í\ëô,ŒG\Û.\Ù\ÍÁ\áÈ´°AO\ÓSK×¶\Õ\Ê?4\ÉmÊŽ5E™®\äž>€Q-¯8bG’VJ\ZQT\Ñ\ÏsÚ¤¸\ÒÀ|=®c[L°i™\Ã\ìxf\ÂÏ\É\è¦+H:„¨}vk\Ði\Ï°­avô¾µ\0öH9®?\æ\Ð\èÑˆ]_TŽ6&\Äù\Ð\ÇXCS–\Ým|3…¾z®B³»t¹ó\ç\ë\\\êBŠðq.h@¢4l?C1†•K!Žð­øAÄ—¥bbþgŽ0n9¥ú\Çö°=88rIyXO.5ù\â÷\r\ÛHf\É¿”\\\0&Ó‰\Ìb\Òl¨@“\Ì\rd™¼‘•\rÀ\Ör~†\í\n–ùEF‰l°+‚m€Y\ëidü\"-^’e¬f!\éHœ¼X\É\Ì\ìB1õ2l[\é^¬~J\'1\ãsÎ‚5ý6´_\nÝž&f9‚29„\Ã!º¸¼\â	p}lˆ°\ÉG\ç\ç®f\Ð\âˆs¦+\ä­APŸ_>k»xý5k\ÆJQˆÐ¦d!S\'°us\ÂZ­Àº•uc,\Í\Ñ±šðø£\Ø\ÜvKf\Ð\î¦eP\äÎ¾Súl\ÝA³’C”\ØÉ€­\ÛQ\Ë0\ê\æp|\î\Çú9\n¹Æ£,ò\Ù\Þ|\ç1¢A?&ŒÀ{yü\æ\ÍSü_u‡‡,6\éX7kA´’\à*õ¾„¸%™p†\ãZ™ò-X=f–DºX¥B\î¢\Æö¤*—ôš¦Q¡\'¯X[…\Ð¤\èû5&`\á‡\Ã ôüFN\âÉ—< lˆ\r¡(‘\èA\Ó.µøše\rü\è\ïmÕi\Þrpƒ¸5\×v\×jp¥|.õB\Å	hx³õs4ð³\Å¬8ªLI\Ó¿™·¯ñI¿›†\Û ‘|\'…\Ý\Ã n~q.þŸ¬rr(d\Ô\ÊpT\ìþ\Ñ??æ“²\å\Å×ñ·\Ï\ì\"ð£\ÉÁ¿\ßÁ\ï\ßÝ‡\Ç\ÂÕ´‡;„ÿùOöð\ç?\â\Ø¯ð\0Ö»ž¬[±\Å/	…\æÎ†­¢@(–£\Ú\âeZ›	b24\Ób@\ÍÁ\Ñu=’F\ÏSTF\ã{VðrLŒ9EN]ž¿d\Æ\Ì02\ãyk,\Ç\ÍPÙ˜Vv+\Ò¸!\Ý=UúL[‚ývp÷­\ê\Ü2USk°\î\ïW`e)\Ø\na™VÀ‰y\Í–J`þŽý=\ëR\ìküü|>¤J¦y‘ô‘’C£m;—\çö\Æ\ÓIü\îÆ¾ü§€0ª\'P\ÄC!\î\Ü;:øs/\âƒO\ápp\â\â¿<\Ä[ž¡ZJ\âö]~ñ\ÛCüóSú^žòUÀ¯Œóðóß°®¯\Ô0*¦q#w\n\é\Ð\å\Ìœ¡\ÉÀZ\Ä%˜q\0\Ç\Ó2`,\Z•÷‚ø\n\ÔLÊ‡TŠ#ú9†ß§E¸\\21L\Çó»dœ>\ÏQ\æ’Ibsø}g±ø\Ã\"“\Æ\î‘\å\Í\ÏRf\È¿\Å!\'\ÖÒ†\äùe\Ï~{÷­D…!¾\ÝD÷öJþu\0c²)X\ë\ëÿp\Ù\Èßº	›!¬³‚lõo‰+p\0Wb²ƒ\ì}\áÅ„:\ZtšLKx¸À;\ï\ïK\Å.ŸM\â\ïž\ÝÆŸÿ\à¿ýý®¤_/¼v„Ï¶Bxõ\í¼u+€ÿ\á\ß\Ý\Å\Ë\à§Sgý\ã‡xóÆ¦Ó’\Ê\ÄðŸ´‹\ç_;Àƒ3\äs$c.9uœ0¶œ>.ÅŸ8\ìò9„›³ŽYŸ\ï\âüt§g\ìWÐ†\Î:bo\ÏK\à\â\É#vŠaj!Cj¾´w‘ª\áXlE6¾c±@‘S\Äè¶³\ÒÔ¨¥É”\ç\'JÁ§\Ç&\Æ\rô{\ìðf\ÇwƒAý§½t0ö\Ð\î4±A\Î\\\Ã\'mYV®Ëº½6<*¦>*.=¤CL9²¬ …\ÊÏ™\è\Øv-\ÉRÿg·LHñ3o_\Æ\ÓÇBÁ¿\Ôx-B\È\Èk”ŠAœœyðÙC”\ndR\é…Æ½x\æ\Å/ð\Æ{ðûw\áµ÷vñ\Û77ñ\Ú÷:ñ‹¿ÀOþ)m\á\Ç\Ï\Þ\Ä3/<\Äû\Ü\Å\ãG‘Žœ\ã\à`Ÿ|ú\0^\ç)6wð\Çqú_n\â\'\ÏŠ­„§²£a§\Ì@\âP*ý\Æ\â‹?~\ï²\é\nY\Î<\"µ>\",`i\Ób\Ü`f!\Ò\ç\ÛÑ¸\Äh®\í©erX•\Ìf¡ŽRty¿/µ\0N\rSXX{ôŒ™.\"SÚµƒ˜nc>!I¤«5€Y\ãIýaVj¢Î¥)¢Y²…vðp\êW2\áŒž®h\è±°\í<1¸þ¡\\Cþc|,\à°\Ê\Zúž,fdñ±{O\Þg\Å\Í\é\ØÂ¹\ã1NN\âü\ì1\\Žmùy\Ö\ìò¹÷\ár\ØZ\Â|¾#øGˆ\Å\Ïþß¶¾³9²ó\Ì?\È?ÀU®r­?\í\ÛU.{ƒ¶\Ö.\ïrW¢v¹–•¸,Q$5\ÃI9§F\èntB\çœ\Z83˜¤¡¨`­÷7\×yÂ½¤>¼\Õ8Ä›žpW·polML™þ÷ûñ?Þ\Ä;ßš\Ä\ßþ\Ó4~ú\É¾÷\Ó%ü\Ãw\çqgtYD®Xª\Ö+¨T\n8V±¾‘À^¿&‘¿H\ÂóX\ïYª\Õ\ÇþAó\Ë9¤wë˜žÛ•k„M sªŒ9wÁ\Ð\ÑNe\ç]ˆD±0h \ÃÞ…\é(¨–r¨‘\è\×Fv\í —Ÿ\á•\Çfc4Ž¶I×‚J\Ê3[p\ç—‘q/!©<§ƒ\è./!\Ú=b€”)¶8…Ù“XŒüñ—t¢Òœ\È²)Òµ¶Ko\ÊÑ•§%Œ0y6Q,l¢R¢ \"=q9µó—òd«‘A§\Å\âÊ™y¹x·3\Â\ïR¨±“«\äZ\Õ\Ñj^–\â\nwÎ“>²…\ZfS²‹Hÿ.U(WÚ¨Ö«89\ï¢\Ûka7_ÄqÃ‘6jHeú\Ç\çGV@rÖ®\ÓÜ¥@±è‹®\Ö\Ýi6yI_\Ýn]\Ú\É\ìUÈ¤_\ÃK˜T¬-\îjº”tº\å@\ZÎµ’%…”\É\×Â\ë¨L>D\í9\ÈIa\\\Æ­ú*«jˆ—…ÿ  \0t,¢”§Ú«³ÁŸP„\Ý@Fú¢ƒCd¥2×Žq\Ö\×\åJP@\Õþz\Ík_\Ô\ëP¯\n^\rþû†\ï!\ï÷²¥•–ó“ð!ô.\Çh!ˆ±¯þ\\}\Ã\é\å”o\Éç«˜œk`f\î O½\è\Z†Ñ‚Aa&kª–¥M”‚\î!V·W\\‚>U¼’\Äó$\ìi÷§wpó~\\j\r®(œ[QÁ¾O3,\Æ²S\Ù×·I–\ã^\èi*\ã)Ÿ7žDqE(ª¨QùŒ^‚dX\É\"\ØS\Ë\ê\Ù\Ã£MA\Ü\r¤Z˜	I‘F³(=	Ž|\èn“?´E\ãa>\Ïg‹\ÞMÿ\Ö@©ù[0(Ù€\Õÿy¯sHI˜¿‹ýõ\0(\Z>ó{þû}¦PÉ²M¾!†%ì… ‹³&Š\Å\Z¦RWy¶®|Ÿu€G‡ž´q°\×D½J|B\é\Z²IºŽ\'Zô¶0w¾ú	\é\ÎÓ‰\r-x<ÿÓ\ã¸?•\ÂS’>M\ë\È°xz‡\ÑË¿ŒþY”	¶º¾wý\\›ª¡ž\Z]G·\Ò1&V\Ù/`À\ÅÀEA+.€¨¯;‰s\Â]„B’\î!¤\0C9	F¤\à\Ã]i“\èpî°¶¯5€hº\ç\ß÷	dº\çµ_<\Þ=\Êªƒü\Ü~¸Xüg¥\Æ`é¢§–\Ô\îe%‘\åQV*½©Z*\èX®\Ô0³”\è—T\á\Ø~=©£\\+†Ÿ}Oo­\ã\ÎýU¬¬ÅŒ²¦UNÝ½©!»X\Ç\Ú\ß}IýbGŽv\ï•j\rý\Þ66\â%)?‡-n}\æÿ“ƒ\ÄD‚L^i&\ï’ù\ê\ärù‘v³¼ú\'¨\ß1\Å\"i\Ä\Å«.5“ðja\È´ ‰E9)Tµ\Õ\èSÄ¿/‡v°iÀx.\î»Tv?\'\Û>\ã\'„Ÿú9}?8$º\×R°ù‘Êž/&)ó¤°‰\×\ß\ã\'ŠJ\Ñö¹`‚L\Â)\èjU,V0½\Ö`é¸‰rµ„_\Þ\Þ\Ä\Ïnn\à{?\Þ@lƒ`’Šºh2\Õ5V’KºžY FBl(aÇ«$ô4¹w\é\Ñ\ïan¥,ð\î\\¾ m`ª|„\Êg9\éƒx¨š	\Ô3 \ì\ÎŸF=\ÐSŠ\ärÒ°0$xsK\Ïž{8\ØkI§P´˜+YTÈµt\Z¹R`Hx„÷ \'\èÞ\Æt\Ñ©\ï{Y6R\áó\\œ¶*¶\0D!Ãš<:±ú5\':¸|Rew‡õ\É\åƒûÞŠ;†µ;IH³60\é`=\Ã˜\Ã\îZ–sI½ššKJÀFN¥ZD&—\Çá°_\Ü\\G¹\\”\ãûˆ\íl2•¹$6\Ð\Ø\åñy¹\Ý\îÞ‹E$\ê\ØðÝªð\ï«Ç‡\è÷{›\Ï\á“\Û,®\ä\Õ\Üâ¬—Ü½ô`G17ñ¿\Å+€-lQeÀÉ¦\0UUI*a5®…N‡\Å1¦\Ú-<\Ö\Ã\ëç‡\è6ý˜–7\ÓøðN\Z7\îfE•º‚n\Ö!:M¬z\0hþQ#I>;\Ø¡®0J¡‘p\Ò\Ãz¾\ïV™\Ôý’´1u!\Øµ .zÈ¤\Û\ä+E\Ü{\0\è\ä†?\Ókk6,®`p„M\'¾Ç“€A¡‰s\\´P*W01KI¸\Ð\Û÷\ì\\il?ÿe¥BQ®\n*cs:\äñ\Ï+ƒ¾‚m\Ü‹c-–•g\â48Ó£—A\à‹gûX\Û(ci­ˆ[Ÿ¥P­UÅ‘$‘\Ê\ãÃVÐ¨±¾™\Ç7¿?B©ŒOo­au3‹\í:ž?;Àò\n‹GE¼~9À\æF\n{\Ý&’\é,\Þû\á:\Þý~7\î¬\ã\Î\è6¾û\ã¾÷£9tš5¼}}Œ¥­>ø8†“Ç§øû÷·Q¯5º.A%\ábð2÷Roþ\å\åbƒ‰ ´ž¤‡\Ò\Ô	ô6nð\Çö@\Ï\îqb\Ô^Ó\îRûLx\rhð\Ç	uhx8±\á\é\à×ŠüŒ-˜h‡\Ðc†(\àDN#…t\Ù`bt\ÞD©TÁ\ÔüN°\0Xf¥0C¿_\Ç/>Ý–ur\Ò\Â\Ú\Ê6zm\ê\n4P\ï4ññ\Ív‹YIù\î\Ý\ßR\í¿3ƒoE°rS\åã¢‡o%\Ð\îvpû^\nû=4\ê5ü\Å;,4\ÅP*•ð\Í÷·ð7\ß]Æ‡)|\ã1ÜŸM\ãç¤ªI<±ü\îú\Ý6\Êõ&þä¿Œ£P, R«ã‡¿La|&ƒ7/(wúø³¿_Ã§ct\ÛUü\î\×\'øþ‡I\ÜK\áó7gø\æ›h5¸º\Ô\Ð\í\åYð\Þ\åe	\nU\ÉX•‚“`\Ð\"\Ä>†\Ö1&;\"\Ë:½M¾L\0\'¦S&\ÎQ¯¬ƒß§Ä‹g>\á\á\î\ÖÀN‚¿È½\î×„\ï|Ÿ|_Q\à‡£Œ5E¼ÞðtR\ã‚*Ž‡5\ì\Ê\ÒdûU\ËÈ¬ÿ·Qk\Öð‹[Bxi4[øO>Š|.‹ýA·\ïo!³K£e\Ó{`yiKNœ¨ˆ\ÈÞ¶qù´ƒd¡Šoýp™b?ù8.“³¸^ÀŸý\í2º\Ø\èµñ—\ï®\à\Îx?þd\ï\Ã\Í\Ñ$bÉŠ°‹·35ü\à£8ŽÎ»ø\Ï\ï,\ã\ßþ·´{\r|ñ›s|ðq\nùbø\Í)b\É*þ\äkhô2\å\ß\Çû?\ßA³\Ó\Åb¬‚›s\Ò\r—C‰H7¯«\Çœˆ–\ë\Ôy¸8\ß\Ö¢NNûb:qv¶““>NOúu0\â­Z\é\ÖyJf“}\Èm7\\‚\ìp\î\\Nt\Ø\Ðžõr	\Â#=œô`!\ØI\ã¯ž \Òf±‘æ™M\rª\Ò˜˜OI/_Ó»\Z..\Ú\Ø\ÉTpóî¶¨gÌ¯eñþ|Åšv§—Hg²b(õ\êj÷\'\ÒøÑ‡\ëzX•›!v.ºr‡~:‘\Å?üs|š\ÂÿüöÒ™¾ý“-|\í\Ý>¹Ã§cÛ¸;¶\×oNq\ëA\ng3øú?o\â[?]Ã\Ñ-|ý{+¸1šo£?ý«%ü\é_M`us\Íf\ßùÑ¼@†‡U|4šÄ¿ù3ø\ëoN\àƒŸLbtr\r\ßøÁ,\î=\\\ÃŸ\Ì#±›F!¿…¥zrqd³q\ì\æ“\Èd·N\'\Û\Í ·K¤tJ^+¥<ò¹4òù,\nEúBQ©–P«—\ÑlTeŒ\ìw‹2\Ù‘&Žœ6¢ŒC²a¢ ¯½}\Íñm’\í\à\éf\ád\ì3È˜BFq’ˆ²Ž\ÃgW—\Ï0w\ç=}\ÑA¡\\\Ã\ÄQÁ\ê\Ü)©\à£&V7Š˜ZL\nóö½6ñ\ïþbÿøƒ5¼ÿ“e«U|\íi¬\Ävžõ\Îwp{4†ƒ½]\ÔkjtÁ²w³Nob’=2øö¦‘\ÝMb{{:ƒr5?™À\ì\â\Ê\Å>{0……E\ì\în`ô\á<\Ö6bø\è\În\ß_D*Â»ølb7nŒcc;ŽÑ‡K(3H¦¶±¶½‰j5…J-\ïýp[hv\Ø;\è`f9¯}}\ZóË›88h¢×¯‰D\Õ\Æ\ØQ$–v24 \Íw;Å½N\Ï÷1\ä.?¥úˆ¢€.ŸRü[_‰	¸z~*c\äˆ=lAä¨œ‹\"‰d\Ô\\\Ã	E\Z\ä¦EJ\Ésxt\ÏIŽvi\ë4t:\Z\èum°\Ü&Q¤Au.%Š\È  –’rrYxJ\â\È6öj\0\0\ÊIDATi¿‰bžD‘u\ävcH³×[\Åô\Â2>º9‹L†º{$†¬!_\Ø\Â\Ç7¦0>³€™ùü\Ý{cø\Æw\æðw\ï=Àÿ\Æ}üô£)¼ó\îŒÏ­\ào\Þ{€ÿ_Gñ>z€ji\å›<	T\Ë	\Ô+)tºY\Ì.\Æ19Ÿ\ÄÁ>MŸŠ\èø\Ò+ \Õ*¢\ËSY\Ó/bÛ—X\0ª¶‚µ†³}ÁûqœlCA*B¼HÁg\î/\Ê\ë{\";2\ê§4l©\\±­]´Z<¹¤Ž€¢·Å˜‹.&—‡R¤W³g\â\á\È21\ÕF\Éx4\ÑO\æûžºzkŠŒTø\Ç\Î\Ófm%6s21¹\Ô\Z\Ò\Ée¤“Jò`Ÿ€#ŸG21\ÄR;K\Ò\Ð\áûñ­9lo\Îakc›±i\Ä7g‘Øž“\Ï%¶\ç‘\ä\Ï\ÅßžG*±$\rž´5„\Ø\ÚÍ¬c—ô«ŒG8\á\Å\â6\n%]l\ÃrÔ¹C\ëit;Y¬mdð`2&€Q*g¶\Ûy\ìÔ‘Í§\ÐÛ«`%¶b± 2|f\æ\ãø\ÙG[ØŽ§„J½™,\"ž%d­)\Ðq\Õ=\ÒR\î\ãG·±°ž\Å\Þ!\á_¤sñ~e/¢`˜†1VP;6\Ú\ë4pxÔ8…-[ªˆ­\Ì:…\ã™]¨\Ò£w\r6UwH}\ÏOzâ¨3\Ú\é\ê$K7\ÐÌ¹©/$bÞœø+5ô 8\è<?Á=Dxšrò*#&Ô¬\Ò7]¹\Ýôš\Ñ\ØË¬KWŒBžž\r\Ñ\Ôcç»“»µQO¡\Ý\ÌJ»–»Z·¤É““@E«Xä¯µ~m\Úp\í`\'Rx/\Çüé‘–v]C@[\ÒÚ¦–š>Åž\ÎÚˆ§Ê˜[HJs‡\ï16 ò†»Pªsn8A3g)Ñº¥«\êú^\Ð8‚ù»\ë8s™Õ¼:vQ˜RÁ¢œ°\ê\ç\ê\å.’\å×”K\à3\è¸)™\n\ãuG1\Ë;·\Ð3IY)üXƒ\è		œT£n \Ó9\îl©j\çO›?\n	“®_ -\è Ñ°/\àøÀ—\ä^Š”œ\ÈýÓšžÙH\Å\ÓV–¼\09òUP‰\Ç>¡\Ó\Ê\èaƒÇ¢rN 4q®s<ôTÍ³‚ NÀÀ\Ð\Ò\Æ\0*nµ\Í\Z<­T\àhX\nA¦“\Û\È¨\ÈH¢sl;‡¹yú\ê{¢%\Ä‡\Å®^`ö‰Ï³‰ïƒºýœU£ª\æ\'¶\ã-=T\Ó\'ŸR½Á^®Ô²ðkU4­JSmo»\×ô„	8e!\È@\î¬\ê\åb‡r…qýŒ …\rú\å¨\á\ÐHjB\ÃøŠ\Ä\ÐK]WO©B\è8\ËÁj;rÄ†«€;v¿G¨’§t¼\Ë%\ê—\à¯L\ZAŸ<¼2\è=\0_\0šZZ\í\ß\ë\Þ°@‘  ;øGt¼þ `RQi°\Õ\Í],/§q\Æ`\"žQ\äQˆE©]¿ø8¢\ï\ïF—y—… Gûu3‹(´\Ü?\'@\Ä\ëP®†HZ)Q¶|\×{o\à\â\ËõŽš“º9¯úBaûW\Ì%Ì­Uú\0¢\0r B²óŸð’\ÌaE\è.\ÎJ\à\Õ	Þ’\rô‚þ\Ä\á%O€£nQR<‰ô\Û1\ê\çb ^\Í&ž\ëe[þ½°\Ö\"¿H\È3\0=I¬\È©÷kCHGuü\Õ\â~\ÞD´m\'5l}-­._šYXD\Òÿ¾Š=+*)\Ð ´qj\Þ@\Âˆò\×g-_\Õø\Ø\×D<üû\ÞY”Ÿ‰¸¢ð®÷	v¢§\ÐÀ¢D\ï|\'ŠF„\\v\È1\ÇVqc`rs”} \'\ÊV£oóz\ä\Â`#\è\Õž¿x$†`Ÿž`dh¹>\'Ÿc@(SC\í\ÕG»{<\rüŽ\É6¬\0\äï‡µ}\ï3x\rÀ@¤ò\í2Fµƒ¢\ê\â\Þv]Z+`;žÁÉ½ýo„R6vôG„\'üžw‰›cO9m8\Ú\×ý\r\Ü\ÍD\'Ö‘>öž-–¨=Žw£\Òq4¿ \0B°!±kP0?\ÄuL`c\îP¦(\áÀw€‚tjË›ƒH_6†ø\Ìt’2Ç§t;	:fD?¾˜b8A§twqÄ’o\'A§ ‹Á®ñÎ“£]\'=:‚B\ífoõzG\Ï…,ak©\ÙwºTû\Çb‹/UU‘\\\\±‰\ì\æ\Õ0»ÁN*\ã#G\Â\ß\èF$gxò\ß\á\äV\r\æšÁ\ïtOwÿ’na\Ðc½\0õ}#›š\ÃI€	\àuq®ýz>\ÓP’‚<SGQxª½ ”4\ß0\nÁ¼:H€\Ñ4’ \Òõ-o\áP}¯\ìVƒ\Ïö:}‡pPL‚•ÁG8\'0ô‰¢ø\ÊA©x\ÑÀûµ\Ã\Ý_´`\Å!\ß\åV\ç=6Á‘\à.h\í\à° ô\Ç\ZM\Ñ\Å‘•qñ¨(;H\íX\Ô\íSúù\Ã:&g)\ÛBx–*‘D¡\êQts Dj’ö®UtbnŸ~ð\Äsðª«Ÿûi\à…«@\ßN\áŠ\Ç`M\'40ÐœP‚DŽ\ê2ñIo÷…À¯E2–ÿ6™t5uiÁkš[*zˆz\â\ÕtÁ‰îŠ¶ g\Ïh\éGgqJ\ÎQMdO.÷ðì¹D\ÍOø\å»€l\Ë3B^¼8\ã\Èá¨——! \Ã`PkýnœóŽôñ\ÉÚ½\×;yøûüasÈ¹ “®‹C\'ð:0€’\í×®\í\Òá°†‰©”`Ü\ÌP\ìw|\é\ÔÐ£?\"TL¦’9	6!\ãHZÏ²8õš	\àcÆ•\äPt\Ðúyi>™v\"[\æœ`~N&ž\ÏGõk\'€L\îó|.µ\å%\\]¨ù¤64Ò“K˜w¾d\rT/u_fC#\è\êW/8†6˜¨ù¯ðöõ9¾xûŸ¿zŒ\Ï\ß^\â‹/žcd\Ð\Éá°“\Åa7+`Ð¦\0R>„t\ÉDi\Ï_ˆý\ëp°/kú½¢ªhpÈŸ2‰B~ ³ƒôð\Æ\0a,Àž;gtlõF! ¢yO\á(\Â6r\î¡\ÆºX¾v&\ÒÁµ¡DTI#\à\Ñú5Î¤g¥\Ï\Ï	\×j\'T\Ô\ÏTª\Ç;¡[Ü­UóG›8dù¸:\ë#\îj\î^jÿ¨ÿ¢#†\Ä@Ú£‰\nf3–¥¦\ÐS%”3º‹«n1\Û\áò\ï%š˜\' £Ž(Q\ÏÔ—”tb‰4ncä •\ÂA;ƒ\ÃNÆ®‹þ%ûø\Ì\ç£>¿\ç\Í]¾`œ\èxÁŠ¥“J\å\ç‚Vq&*öO4	\"ºÁJ\à\ÇB‘\å\ï&\Õ\î6ð\àa\\\åceA@\ÚË¸¾¡‹AV²¡{„?<\ÒÁ»\Ö\ïcbQST\ÊD¤’•=côN¢‚N7/\å`úút:Šlf5R-\è\é6žC½F\Î\0õˆ\ÒRó\ç \Ïr¾ÀFÎ¦”¹ùJ\Ó\ì5‘(\ÏC*‘ê‰‰•\Å\èÑNoˆ»y&½,Ÿ“\ë\Èe·±›¥B›A	ª\â+%\á\Ê\Õ<*Uz@¥DQ\Íf«Šv§Žn§~·‰‘½\æú\Í$ø:`&\Ð\Ñûÿ\Ðø|²»I\áÂªx’o{\Û\Öþðþ%ƒødø«‘?\Ñ\Â\ì\â±À¤\"”ü§f4Q\"„JÄšlôú\Ä\0å•£O\îB¿„Bµ„{÷ch6S¨\×\Ó\Â\r¨”Ucˆƒ\Ðt:Š›\Ø-l\è\È\ëˆrrò\0i³Œ9	Y:˜¯\"•^FbgÉ%$H¦–É®a\'µ„dr\éÌŠp\Z\â,‘Ó¡$½†ln]Gv»,«\ç·\Å½@!¬J¥2?\\9T+º@d4¸h¼¿PA¯_µWB\Ê\Ø[`a‰%fV\'\Ûý÷dœ_\àôŒ\Òþ‡¢ÿÃ¯E\ê©z@©,m€\Ïqyy†\çW$‰>\Å\ë\×Oñ\æõ%Fö\Z;\Øk¥\Ðo$±_Ï¢\ßÌ¡\ÛÌ¡×¤@SN8mD²Bi6H!†MªliGš8üƒsU\ç”(²›]\Ó?tŽ\î T÷\âXor\ØK ƒˆÒ¨°ŸG<¾ˆd’\Öñ´‹_F\"¹ˆx‚\è\ì¤I!µj\r+±u|rs\Z9N\n_fEzüo³l7²\n;t…¢ö*\Õ$ªU.¤ü4\ë´ôd÷eøBó¾PQŸ‚£0°\Óû[£v¾OK˜SöÝ‹z|s[“¯õx—c_^ù¾\Zp\ïQ\ÆR>\áa…¨+L\Ía\ãZ(\n\Ì%\àCªòÌž\0@D\Ñ`šð0b\Ïð\ê\Õ9Þ¼y„‘­¥ql-csi1¾®Maseñõi$b3\Ò\àa3‡\ÍNT’\Ä\ÉH\Òöe	D4\æ¥\Ù\ØS°\Ý\åJ`\\¾HjT¶$Y¤IS¥iÁr´H\é–\Ð\áDp§³\\Ì“\ã°\Z”U%È’ü¼ƒT¶„©Ù„„„_`Ç¿ö”Ã ü‹\Ø\Ã*\Ë÷Í¼\ê\ÄÞ“þiñV6¸‘¬aø¥þ…j\Ô\Õ\Æt\0\\\ÊÖ‹F\Ô\àpe±@$¢F\Æ	õbRˆG´j¡	D©x”…¢b¥b/	_¹V\0©`—C¼¸<\Â\Õ\Ó^=\')D½(Ï’0¿&?€:#|B\ÍRM¶d¹;ª;\èrg°¹c\Í¥?û×Ž÷\ÃWPA¤J\âuo‹\ê=\âö÷\åJ ¨ƒd‚\Ô\æc_\r(\é\ä*px¤Í ‹“\ÏÀ‹ƒxü­D\ã\ÓÛ’\îõY—0,B$6‘\0“\Ê$¥ôts(²µª…\äB¡‡A\í+…¤k6xVJv\ß\ä/û\"‡>Á\á\ä\ë$\ë\×\çna©ˆ¹t€C´?\à\r¡p\×+70†õ°¡T¹\È\nò‰÷\Å \ãõ¹ö:\å$zõ4zµ4:ŒL|»‘F‡„\ÌfV\êÿýÿÀ\Ìÿ‰\0b…\ÐI\Z\0zÏ -y! \ë°pNö~d\ìñûÒ“¨²4NX\ÑE`¯\Ò\ì!Î¯dº„\ã›8>\nk¬RŠ\Ów$Œf\Ò\é5‚¦N,$\ZL>šDÅ±B%S%©DóJ–\é(\Ã(ü:˜\ä€\Z~_A¨&Á°—¯ñ	œf6²\ÖT½\0õf“\ÎÁ^€6ƒNŒ\"v†_½$4\\O‘N)^=…nu­ZJA§ž–\Ñ\æ\Âh1&\È\n‚7,ü„9¿\Ô\Èñ°G6¨ƒL@tò\Ã\Ü?Zû¦|z\n„ºAñ„PË¨\Ö\Æn¹±ñ¸\èú\Ãwi k\àþŽ<²~€#ˆe\âU\r…4yQ1sK_,.j¥Á¬.*WMõÀ-\ï½dp#þ\Â!\ÒX\'_ò|\Öú%\ÅM¨üsŽ`M l\n\é\à÷ü\ZP¸y°#È®~\Z´„ý=ý\Õ\Ës9Fúµúõ”,‚¶-\0ž|¥µ?K°DŠ6{&õ\"»=€ˆi¡(ZŽ¢‚£Õ½h\ÇOÿ¨š£»\"‰\ë¹W@TEL‹0\r\ÑõŸJb¿«\Ë`qF*¢ý\×!Š6‚†ªˆ\âRx¾\è´Sh%aœ†2¹.v¥?\ï43k#G\\\Ó9q\Þ\rŒZ\Æ_Wõc\Þ-hŒb\Ç>¿\'º\ÈòµwC\Ï\"—‘s\Ù¹\È¶@5‚u÷kW\Ãa\âtß«§\á\Ã\'š\'A\ÓO_\0v\Zô\Û:\áAw\Ðx\0a\Èw|t×‡Pð/wü|\×r°•ËŠ\Z¯@“®‘\ÐÀ±24~˜_\ÝÅ§Ÿ%\Ñl\íÊµmP]›ü¨¤Y\Öxqh\íF’\î|*W\Å\"Œ_Á +ª†@\ëþ\"Hi=\0’6X\é‹\Þ\ï\ÑEFú!eœ_\ë©q=6ˆ^!.-\ã‚Q$œ\\>:À³Ç‡xF÷°§´ˆ9\Äó+ªƒ“9\ì*b¤Ž‘&\Æ8\à	FzÕ\ë òÚ¶ Û \ÃFF¯†$t©CúÿtùŽÿª2H\È!T\n™\ß\É^*>ò‰2‰ruÂ¬;ð %\×ÁQ›;%ü¯°ˆRÀ\Ñ!–µ\Ð\ä\ÂTød\0D\Õn¤cB5”Zx\Z„YŸ7‰¨>Ê²-3\r£RÇ·Ÿ±Hj\ØÀ\ÐÊ¿Ò3e0]\0¡.±sEPŠü+X)[Y¯ž\Þp\n¤ò:\æ\'\ÙB¤±?»\ØÇ³\Çû¸\"üKtð\â\åP\îzr_ô\æ1^¾ôq‰‘^e\\\Ý\Êº²\ë\Ó¶ˆ­0.H\Ë\ÄûUÀ\çN3ƒ.cƒ¶f	Q€ƒ?B†±ñ\n#¼\0¹¯_!-ÿú`FÀÁò+U58ù\"`)@U¯µ7\Ñ\Ýo\â½\'„\Î\Î @xý\\¯\Ë\ÐZ@i\Ù\È@\n\\v\r™°dh•£9]\0š‰H\ßÀA€\'P\Öø=\Ñ\n\âp²Š\\ž\Zz\Z¨øQj™\ÛôQµUõh\"Aœ \n;¹ž°>“o :\Ã¾ \È@œFŽ÷q2<\Ä\áa­N\ÝþZ{Ø­v‘\Èv‘-\r\Ê\ï#¾;Àfv \'@·¶#A`¿šB§–D«¾#© ,€\è‰\àñeš-dB‚ˆB\ã…xE\É!Q;7Ž\ÐÀ’«šCqòe˜Š&–Z\Z\Ö@`\æ\Íñ>¾³Á’T\\•\Ì\é\îú{C\ÉY9¤–¯\Ú\Ãû‚t&ŽP\ëÁu\Ãÿÿ],þs`\ÂN>Á|eY˜§\'Ð›?\Ò+8ds\Éþ\í\\´\Ò²\Ö0\á\ë§m\Ït\Î}À6\ïi{Ãž¸Œ\Õ\ÚMT[\r´:m4š\rÔš-*:rå¦ŒT¡‰\Ý&¶3u$s-dKd+\ØÎµ±‘j!‘\ÛCª8@®r„jw€ý\á)†\'8>»ÀÅ“<º|Œ«W/põòeôH¢[e \ÈI\ß	â€¯\ÄVôS z\Èk¯ 8À\Å\î\í¹‘S>[\Æ>R,Ù¡Ö\á ²\êv\Ü[3†\ï{C‡\èG\'m\Ì\ÇJb·v<0š™\à½3\èñ†7ƒ\ÔcXv¼\ÔX\åcÂ”\È\ÙwBgÇœRM0“\'\Òyø«0”\Û\ÇñY_:NN\é\ÞF\ÏÑ°ýÁZý.\Z\Ý.Š\Õ\Êõ.Ò…:R\Å6²•¶³M¬\ïTK\Õdò\Ö\â5,\æ¶U@,QD2SC<]A,Y\ÂfªŒD¦„D¶,òx;™’¤Â™|\r…j\ÕFf\Ív\r\ÍV\Ív]œ\Ë	co6óRf¦\ÃZµº+2¥R\Z\ÅbJ\ë\0mV\è\ä\ÈO¡^I¯þ\Ì\ÝÞ¬§\Ð\â\çy•ë‚\âýY2\î\ìJS„xù=\îLh\ÜýV\Ä\án\ã.sÕ‘£û\ç\ÜE<2\Ûr¿±\Ö}\Ü\r^	x\ç(ô•p¨2mc²21?p\ç\rZñ\Ãþ^\ínE¬U:\â\ØÁ¦M\í¶\n7\Õja‹‡N•Äª5\ZEeP©fU–MþPi‘_£ôZŽ²l\År…mÄ“›ØŽoas+†\Õ\Õ%\Ä6V±¼²€ñ‰)Üº7‰Ÿ2ŽŸ}¬¯\ß\Ç\Ý\Ñ)|66!clr\Z\Ó3“˜œšÀôôC\ÌÎŽa~~Ó³˜›\Â\ÌÜ„Œ¹\Å	\Ì.<\Ä\Â\Ò$\æt,.LayqZ_Wf±²2‡¥\åY,.\Î\ÈXZ\â{óX\ßXAlk\r›\Û1\Ä›\ØNl ž\Ü\ÂN:Žl.%c¤QN¡SÏ¡]\Ëw~§‘•~€‰ü™þ‘\ØÁr­>÷\äY_¹\Êh\æ \à’\rí’µh/ß£«Wa;TY”\Êi”+)©Õ³qB—r:–§R›H&c\Ø\Þ\"\ác[›+\Ø\ÜXF,¶ˆµµy¬®\Ì\Êó\Ä\Ì¾ÿÁ(¦0;ós³1;3†™©Q³307ó\0‹s\ãX˜{ˆ……q\Ì\ÍqL`~v³³“˜™\Ä\Ä\ä\Æ\Ü\ÇøøŒ>Ã»÷q\ç\î(n\Ý“ñ\Ë[cøÅûøð\Æ(>¼1†Ÿ}ò\0?ùp?ýh7oOctlsKØŠ³A\Ãö\æ*\ÉM\ìPG©˜À.K\áer\Zèª²”¾›\"\Z\í‚hµ;ú÷\ëuˆ¿¤‰7}xE5\Å\Ïa²\ãž0xmœž\ì\á\ädO@„}\âÑ“cœ?:Ø£\ÇGxú\ìD\Æ\åóS…º$2ø\å…<?q.\Ï#ñ\Íy\Ä7\æ±›\Å\æú46V§°¾<Žõå‡ˆ­L`uaK³cXž\Ç\â\Üf`\Ø\éQ\ÌL†©\É{˜¿‹ñ·ñpô6&\î\ß\Â\ä\èmŒ~Šñ·01vocjü.¦\'\î`z’\ã.f¦\ïanö>\æ8\îaž¯‹±´4Žõ\Õi\ÄÖ¦±µ:ƒ­õ9l\Ä\æ±M\'’›D\ì\Ö\ÅD‘Bˆ?¿1\Õ\Í8*\rš,e\çN-\î\È\ê\Î\ä²\Èdr\â\0º\ØAl;µœð\í9V\ÓX\\\Í\è\Ø\Ø\Å\ÒVk\É\Öl¤«X\Û)b#SA’Ç®µMT;m\Ô{]´ö:\Øö1¤†Ð£¾8{\ßÿT\È \Ä\èP_K>\'\Þ‚ kOˆBú€Žj¡~¸>QWž=“`“H€£&%|œ\Ò2\ì(B˜!©²!D’­\å\ÅüPRB:>FŠmå†¸zyŒ‘±\Ï>\ÆÄƒ˜»‰\éñ[˜ž¸\Ù\É;X˜¹‡\Å\ÙÏ°<7†\Õ\Åq\ÄV§°±6\Ø\ê4¶6\æßš—®]rg©\Ô*r\éuñú)\î\Ò†Ÿ¤XšÕ«I\Ú9»\Z4ŒV\Ú\Ü0Š\ryµ\í¶È¬Š¹µM/öµCúž6„ì°™¬\ãg7³b\Ùzw,Žû\ã	Œ\Ï\î`b&)ŽŸ‹\ëi¬neKÈ•.Q¨VPm\Õ\Ð\êU\Ñ\í\×\Ðgzy\Ð®\ßõº)}K\Í\ÎY\Ü	\ÕÅ™\æñ³\âPbŠ ÿr\×5ñ`°š€{(Pu\Ø\ä¢8ÿ\nØµ„\å\Ù\n%\ãE:VÀ\"¡^°h ñpajq°/ÀÁZÁsv/T/\à\ê#†µÙ³!ø{\ìù@¼\ê\è\íbO^\Ù\Ð+ \Û%;hû=\ï°§\Ír}Nº”‡™*h\",dœ’…\Ì„Mñ¼0\Ø#P\Ôô	(‘W\ÅH´nC¼wZ\Ø\ÉV±[¨¢T­ Ù©£Õ­£\ÛÓ˜C°}&\ß\ÊøB:t\á{\Öýcš\ÉlCR»\Û\ÇE\'Á(3J\Â\"ˆ \ÕÁU‹XhaŒ\ì¹(\Ï\Ç$œd¢¾\ÃM\áÃ¤^ø,\ì\ëò\ÉBð*Ÿ!‡)O. —|•d\ÚÀa(—†óžÀ¯\Øù“\îß©F¿z6\Ä*”<\à;…´Œi13‰\Z¥O9Ê‰ dg;˜Á\é`2\è³\àO@OIcm€‹ˆ/“=K´X=\ì‘}¬õ€°\ØÀpŸC£þ¾¥„Z° Š›œ,bô4§\Z8[±\"(E\ï—h„b•?m%ó3:\ÑJØ¬\Å‘`3)¶£cXN¢ú\'Ô¯™j¸fŸWûó§°c;¥D”öñV\ãJ¼rtkõN+yºƒ\ÃÊžRÁ|g_+óÚŽW¯€P4ZœC\Ä*\Ö,a\Ø4\ÅðW/µKH¡ˆ_¿%ð1~õúBNŽ‘F™\í\ßT°\0ø,ƒ º£i`#-€\Ã\'Ÿi v_\Ü\éœlô\ë\Ï\Åh\nð”`×®£\"\É\"B!µ;dhEÐ‹BZ€\çê’·\Ë\×nÉ¦©¤ ‹$+¨\ËtP„š\ÓÇ¼ý+“>\Ô]\Ï|]\'U4u\Â\Õ:\Î@¶…:ÆŒÄŒ!\ä\ÄÐŸ!ŠW˜Á\Â²:\è\Ø6\Ü\ÕVÆ•]n5}1‰g\în£~±\í\ËEQõ\ã^\ÚÀ&UšX ¦’qoE\ä)~ÿ\Ûø\â\í\éŒ´­\Ø\Ã\è¿ZŒ_›|f¼&œK\Õ\Ï6-L™)\È÷´(¤\×G\ÞN]\Ú3Ð/‹\Ïmj\r¥¯À÷x\ä‹\Î\0‹7×º†[:¡L\ï¼@=¼Z\È+A¬Ù¤¾À2oˆ\è\r¾ou™Ü.G\ìúq\î\ÃM¦\ÄQ…\åb;øóŠ\ä\ÕÏ¹\Çbø;t8s˜\ßw\à‡’?\ãG4\å]øþµ\æŽj\0ù‚\à\ä¤P„öE×°7\Ö\ìá„«;˜ª‚=·…ó\Ò£dûøÍ¯/ñ‡ß¿\Â\çd·m\Ây\äóh¡Ã¼¿ž–j –‚shTx%ðs,i€\ï‡)£jûn÷I\×6²aX®\í\è\äs±pðY:zr\Z0>mgoÀ‰gý \Ú+°&‘{\È›Ë¹\ï¶\0\ÔzÞ‚2»\Ã\Õ[P\r²Ž¥\ìÛ\êœ7p\ïòIb\â\Ð,vE¼\Ù&]vþ©,\ë\Z;G­x¢ „v‰¼Mr\Ð\ëw—°G{\ê\è»\Þ\'\ÞO[8¼\Ã_\Ú\"n_\Ä\"†;_®\n¢ƒžy\èo\ß\\\È\äñù%~ÿ»ø\â‹g\áDS˜A\ï|=ò¹\Ãùª»?+_7M=Cú^¶\É\ç\îÉ¶y–]oƒ\n#œhžþy=	\n\Ø# •qø²‚Èš~%\0ŠF¯)ø\ìG Ú¶Ë¥‹\Ç\Â\ä\à\ØLÒž§¦ˆN&´\Ü\å¤¬[¥Xe\Â\Å\ëGw¯\ãö\å\ê\à\ï1‚†S³üs\Þ	\äÎ\Zq+\Ö_q‚\nL¼®=‚»>*þd‹\ÂM¡8ùœp6|\Øü\á\äú«\Ú\Â\r\åd\à\Ä\ËûOx-­až\0\'øü\í#üúó\'ø\Í\Ïð‡ß¼À¿üö¥.\0½ôî—¶/w6\ê\Ü\éú\ìw?÷N‹\à\Ðt°óe4²&,U@©_	¾ãƒ‰þÊ³_:Vò^1\0V#w»—‹Õˆ1xõ\é\ë¬\Ãú“m\ÃgñFF‚6¹·u·úû’\Â\ÙI¡§ˆ\áþ\Ù\ÔIZ=\æùªÏš¦’ªEž\0‡.Švò)TO\0gý:\Â\çZo\ß`^Žø	Ÿûx\É4NR9\âýtr9ø\Ì÷8ˆ”ðø\0ož\á\É\Âñ\n\àø\í\Ïñ/¿{…ý¿otxÛ—@\Ý\á9=\âƒc^{\0r·wTBžB°­¼LœO6€\îr¾Ÿ—g=\æíˆ—\ï‡G¾Ÿ@Q§”ƒI¦ž‚Î­ŠÚ†ÿ\Üý¾t„_{F®/7›|‹|\'\ZðE}}!\Ø.–^¿M¼/±ª‘z„·õ`A˜·­®\ì\Ê\äPf+ô8<’\Ûs\ç»8„cþ\Ü:N\Ð?Oö•\îý”)!u²uòeÂ¹ó•\n~,Ÿ\ág\ß<J@M@jò\n\àøý\ï_\âÿý\ë[üú\ÔW\ê\â1\é¶\0\0\0\0IEND®B`‚','Local Drive','2023-12-16 07:38:02','2023-12-16 07:38:02','IGH141585754362','IGH141585754362','image/png',NULL,'WRS765168112483'),('KBD798184891042','Acc porfolio.xlsx','https://storage.googleapis.com/revspire_test/Acc porfolio.xlsx',NULL,'Local Drive','2023-12-16 15:02:51','2023-12-16 15:02:51','IGH141585754362','IGH141585754362','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','xlsx','WRS695055681927'),('KBD813530717801','3. Content Portal overview.png','1aIBPtdhuugZSBA_51dOyAoY76_lwU1qB',_binary '‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0€\0\0\0€\0\0\0\Ã>a\Ë\0\0\0	pHYs\0\0\0\0\0šœ\0\0 \0IDATxœl½÷“¤Wv%Œ!‡K.©¥ C« ¤\r\ÅJ\\i%*Œ\ÐrI\Ñ,\íp84<\ÚVWu—\íò\ÞdVšJ\ïÍ—\Þ{\ï3Ëµo˜F˜0žC\ÌWÿ\ÆQœûe¡g7ôÃ‹ô¦òw\ï¹\çšz\á…^À?ÿ\Õ_\Æ\æ\ë°.\â\Î\ä%¬Ï½‡qOžŒ\Ðm\çP+\ÅðÎ“>Þ¯\ã\Ñý\ßo\á\á\Ý>¨\ãñ£&=P\×\Ãû\rÜ»[Ã»[ˆ$\Èd3¸V\Åq·€³n§\ÝN:\Åÿlsu‹8\é–p\Ú+\É\í‹\ÇF†\í‚<>\ì\Ð\ï\ä\Ðo\çÑ—\ëYôZit\ÛIt[)œ\rŠðù}\Ø\Ü6\"¨(\è·S\èµR\èw\Òô2\ÊÊ¢\ßN£\ß\É\È:\î\å1hg\Ñi§\Ñj$\Ñi§I±¯1b_kBµA:\åC:\éE.@!”\ËT\Ú\'—µbõzk»˜­N4ªqô:)Dc~LT«q´\Ú9Ô›i4\ê)4yXn¤Rqüû¿=Àß½½‹:Ÿ\ÓL\á\ì¸\no ˆV5\Ón\Ãf\Ç\íz\Í4\Ý\"tF?V¶\í(r\èõ\ë(–J¨TkøÎ·Ÿ\à{\ß}\ï<l!\ÙC*´‹c\Æ\íIhV\'°u\ç\n6\ï\\\Æö\Êv\×nbý&ô;\Ó8Ø™Ãµk7ñ\Â\06\î\\‡Ã°Š;S—°:÷&,‡+xôh€N+‹J1‚\'»¸¯Ž~/z5Z5Žf#…V3N;‹n\'‡^;/€¹{Z\0\Äq\Ü;-\Ëž÷*€/VO„¬Žz\É?øÿov€<zÜ¼ñöd\ã\Õ\Õk§0ì¥‘ˆ+X\ÛØ‡¢x0\è¦\Ði&\ä1®Áx\Óy]@\Ñ\Íà¤›\Å)\× “AwO\Ëðy\\\Ðh\Ìðy½8;. \ßÍ \ßÍ¢\ß\Ëa\ØÎ \×L¢\ÛL¢\ÝH\Êw‰FýX\\Ùƒ\Ý\åF,\æE©@–\0\É/„P(†‘\Í\Ï)(¢0\Z\í¨—\ãø\Ë7´xcB‹V3†j9!¿[@	£]\Ë\àÞ¿M\çý\nZ\Í,j,võ\nV÷<8²‡pï¬‰f»ŽX²ŒŸ\ÞÅ~ðOŸt‘«\0»W\á\Ð\ÍÂ¢‡U7“f\ÆýY\í\Ï\Ât0»~»«ó¸yuJÀ¯þ\Ê/a}þœ\ÆuÜ™zkso\á\è`\r\Ðj¤‘Mûñ\äqw\ï\Öp\ïnw\Ïk¸w¯Žó³\ZŽG%t»9A1O@¥\ZG£‘€?À‘ÙJ)„|6ˆbVA9B9FµAµ\Ë\Ò(\ÇÑ®¥Ð©¥\Ðod0lñ”\ç\ä\ái\Òô\nõ³\èuS\è÷¸‚$úº\í„z\ÙLb\ØK!“Rû\Ä2\0´½ñ†_€…\08\æ¦w³²‚\"ŠùV\×M0[\Ý\È$œtsªµèª¯?\îdp\Ò\Ë\Êkûyœ\n4Ó¨\æ#¸;Roó5\'ƒFƒFƒ<½\ìø;\Ð¤`·{Ð¬&psÉŒ¿y}©„OÀQ,*°¹H\Æüh”²š•j\å82¹v\r>|óª	/\Þk\á\Ñ\Ã\n\å:ž½?ú\áxÿqùð’\Ê.Â®\rmkp—`\Ó.Àt0\ãþ{3°.`qf/½ô\Zþòo_Sð+¿üU\ÌN¼‡q‹·^\Å\Úü[0\ì.\à\á\Ã>º­,Jù\Þy\ÒÅ½»UÜ¿WÃƒûu<|\ÐÀ1ùUœŸ”q÷¬‚»gUœžVq\ï^\rùB\nNw\Ç\Ã\":\Íºõ4:õ4Z\Õ$\êÅ˜X•r1‚b!$?\0Mj>« ŸQIú‘IùMùPÌ…\äós/\Ò/²Y?r\Ù \nù J…\Z(.O{+‰\ã~\Z§þ\è\ê\ét\Òv¹2ò8oºiŒú9ŒzY¹\Ð\Éb\Ô.¢\ß\Î\âÖ²ÿ\î\àr9q2\Ì}ºA;Q7+\×ùú“^gýÎ‡yŒøFmõ³†|ÿ~N€\ÃçŸŽòô‹)!œ\rK˜\Ýð\âO_1 •\n\ã|”\Ãùq	‘XT@\Ø\íf\Ðh¤\Ðh$Ñ¨%P)\'°§s\á›×XX³`4(\áxTE\"\Ç{O\Îñ\ã?\Ã\Ó\'=\ä\ÂûH	\06á·¬\Âe\\„]w\íŽf\äô[u¸5y\r;›øúß¿Š^xñE|\í—~	·¯_‚óˆ\0x›‹W`ØÇƒ]t›y”²\nžŒp÷¼\"‹@\à:=)\É:;-\ãô¤ŒÑ°„³“*Ê•,l.N†ôc·ò8np\Ò.ªf| }\á\Ût\nèµ²\è42²º\Úõ´¬R!‚tÚL6ˆt:€L& \0I\ÆÝˆEœH%\\p¹\Ì\Ø\ÚÚÞ ÁþÑ°ÙŒ¹´ù—¥|Püz½\ZC£G§EË‘B¯‘~\Ñj\æqd\âÀ\àF2Æ°›Ã —€º9\ÙHuóy[Å‚dT\Äñ  nª;v;®†\Ï?Ðšd+h63xuÊ„W§ÌˆEC8 $q\ÔkIœŸ•p2*\àŒ¿\í¨„\ãAó\ëv\ÌnxP«ð\Î\ã>=\è!™,`0¨\ã½÷Oñ\à^¹\È>\Ò\ÊÂ®-¬kð-Ã¡»#›¸uú½Lß¼†ù\é\ë0j°²<^|ñEüòW¿‚\Ù\É\×\à³m	\Ü^¼&\0¸w·‹v+‹r.ˆÇ:8?«\ÈF\0rò\Ï*c\0q<*`4,`\Ð+\âdTF¹œ…\Õ\éÃ°Ÿ—\r\í7³Ò¤s5sŒ×°•W\ß\î7²\êc\rõ¾n-F%!V¤UO¢RŠ Z‰\É}­z\n\Õrz¥R\áˆÞ€k[‡H\Ä<¨–”K!T\Ê”Š´4\ä2*‘+\äT·T\ÈQÈ†PÌª–\È\ãó “ò£VM)¨c¨•\â¨Wh\Ôbh7\éZ\È/Rr\Ê;­<BŠ‚f%…\Ó!¢’\Ê9ƒp8\ÝvJHk 3y±¸nE£šÄ¨ŸÁ\Ùq\ÑxZZÍ°—S\Ý\ÔP\ÖÜ¦—&\ípúBxr¿…žž\"­\â\Ãgð\Ùg\ï9\ÏG\n\î\"\ä\\‡ýpG»·¡Û¹\r\í\Æö\×\'¡ÝšÁ\Ú\âM\ì®\Í`}y\Z+K3*\0~\é«_Á­\ë—\à³\í`aòv–¯Ã¸?»\ç´[T²<~\Ø\ÂùYg§\êé§™\'\0x\ßñ°Œ‘ø½\"½†ƒ\êµ,v¯¨\Í“¬=\'‹€\è52\Ô3²\É\Ãñf_¬~=#‹.ƒ<¡UK\É{\Ô*qr\Ê\Øu„Q«&\äz¥•Çšµ:­˜\ÄV-Šv#.~_8‚øž\È,F½<NúEŒúy1ûü.½Z\n\áp6‡©¸‚v3V-ŽJ>,À\É\ç}\È\ç\Èeý*h2\nr\é r)?\â1<7tFvµF.ùž¥bX€\Ç\ïF2]¯g\àôøp2H\Ã\îðc{\ß!–¯\ß\"\0\nˆÄ£h\Õ\Òb\r\Ä\Å8•\0zkW,\ïx\ÑkWð\Þ{\'ˆ¥\Ëø\ä“\Çøñ\èú\ÈF\n\04ÿó°\ÎÂ¬…E3\ÃÁ,fn\ß\Ä\Ü4\×$\î\ÌNamiNÀW¾úeÜ¼òM{˜Ÿx»+0\ì\Í\ã\ì´%ì¾ôJ\ØwvR–Ð¨\ÇQ¯\ÇÑ¨óT$P«%\Ñl¦\Ñjg$\"ò¨\×s8²\ÚÅŸ‘Hö\Úd\Ñ$uyO<žò~‹À Î¡O€4³²ñ\\õñ7\É*	”\na9½\\\Å|HN?/—¢_\\¯óz)„f5ŠV=&Dð‹\Õ\")ŒKˆ(f½“Ã°K¨< •Jbc×†\Í}L6|þ êµ„„Œ\"¸†Œh\æ[¼C1\ÇÆ¶Ÿ\Ëz¼ü\Ö\"Q?Ji>„r\0\n£XŠ •\ã\ÈbG©¨À\êp`yc‰˜\ÙL•rn¿ù<­/ò~¿‚N¯’ÄezG\n\Ï\Þ?\ÆÓ§\Ç\È\Êø\ä;ñ£<\Ãû\ïô\r«\0»\Öà·¬Àm¼‡nV\ÍŽöf°·1ƒ\íi\í/À¢%?X\à+_\Âõ·¾€kwn^\Âþ\ÚŒû\0nh&\êÀýóš òxXB¯—C³\ÉM‰£ZŠ¢P¡(\áNižŽ¢‚ \âÁ\Êúžø\íTŠaQ¥|E2\ÞBXü:‰ Wµ‘ÐˆKp%z™¡&7=„:7·À×†|=7»Z‰\Ëmn>\Ã\Ò*£ŠbMZƒj\ÍzT6ž–@µ´üq3\ê\ÉosóòC7jI\äs\Ùðz#C½—§´)~Œúô\éŒ<\Ò_øuFdû½N·\æq\í\Ö\Ì6¦\æu+>±0¢i0¼¥[\Ä÷G\"	9-miŒðøÜ¨Tb(W¢px|\Èf#ò7raòd3´ Q˜~\Ìo;‘\ÊðøQO/\Öð\Ù\'ñ£~($ \ØAÈµŸy.\Ã\Ø	€Y˜÷g`\Ö\ÌÂ¡[€M·‹öLš%\0_ýò—på¯#\è\Ò\à\ÎÍ—¡\ÙPQ\Â\Ín\×S\ÈÄ¸·.H¤O:?-‹é§©:\Åôúü!\Étsó0¹°½w„v;j).!\r7¸R ?Ž¡˜K¬Ì˜9›ò\"ô w!s\"w\"u s!q v!¬\ØR¬ˆðvÜ…dÂx”Ð£†™V.€r!ˆj)ŒZ%‚z…&5†v=&QO.\É&\Ñ!…&†™m\Õ*iŒnL\Ì°«q\â\ÍZú\í\Ä8¢x€wBrG ­\íX±¼nÀ°“F!ŸD$Ä°•\ÒKŽ\Ã\Ï8–\Ñl\äTB¸;(\ál˜G¯—\Å\ÉiýA\Ív\áx½nAt”\ÓA\'ƒ\nŽû%´ZYñý;†\0–¶]8\Õ\ÐÖ „xüpˆoòXu\á=@ØµŽ e\ã\"ºyØ´s°P¸\Ù[\×1{û¦o\ÝÀ­›7U\0|ùK/\à\ÍWþ\nA‹“/C·\Í\'\ßÁ —\0$£v\Ü[€‹5&¬šDŠ4#ªWb¶T 7Ú¡=4cHˆ>ž§\ä®\ÅpŠ\'(N+)¾¶\ÝJ \ÅS\Ê\ë\ÍšuŠ#4ñ\n*eZŒ\0\Òi/¢1\âq·„ƒ™´\é$\ãu\Ò;bQ+\â1	‡€)#›wI”Iy\ä5ù,AF­\ÃU%0\Ë1¬\í¹ðW—°¸\å\Äú¾\r:\ÒIE\Â:\nB¼\É\éO\Ë\ßO\0œ—1¿z„ý#Š¨ì•‹!\á#$·º:*} w ˆó\ã*\"‘&;üJµj\n½^J$„a//‡\ê¸W\ÂY¿‚{\'5´[%\\w`j%\0·?‰>8Áû\ï\ßE:SÀG\Ï\î\â\é\çx\ç>•À}$\Û\Âhþy\ê\r\ÛS\ÐmLB·y7¯¾…—_~\Ë7±¹<…ƒy¼ð¥/½ˆ_|¯]úz5Xºù\nô;s\0úmŠ;Éˆ÷Îª²ñ£_ˆo)ðT	\ÒyŠ(Í¶R¸{ZÄ‘Ù…\Õ5X†f5%\äFB¼±?¦InÖ¢hT#\â«y‹\×\Õ(ê•°øq>^«‘L)B¬¸j|¬®’<.>§Qã‰¨\ï×¤JC³IVM0©/©î£’S\Äe¥2~‘v“i?n/\èñ/oÀb³Á\é2#\Z%x¼È§ý(yšãš¸¬(ºÍ´¸ªý=‚!úŒji”\ËQTj	´\Å\Í\ä0\0Ð¨\ç\àô„$YÝ¸1½k·´X\Ù0\Â\íÀ\âô\ÉkN†y	ýŽ‰2ú\Ý<¦V<xcÖP4ƒ““.?9F¾PÁ¿ÿ.~ò\âƒ\Ç\ä\0ûbÇŠ˜~ó>\×4L»·`Ú»©›\Ø]Ÿ†ýp\æº‚Z€/Q\r\Â+\ßøs(\ÞC,M\0°j—Ñ¦Q‰#²\n¼\Ø|†\'\"ŒñT´ò4U©–§úl”ƒ\×\ïÅ¡\Î*B	…šUNNyƒ!o¼\n€†\0‚›ÿ|3¹Jù€0oº^\Ò: |.\çõ‹%\0h\ÄH\í¦\nN#Ž^=-\á%I&5\É1ôJõJrB[\Öwl¸z[‡h\Ø+V¢^M\n%\'©óAB!¯ —7§ñ··°±½#nŒ.)\ÉË´rž<ùF¹œ€\Ë\ëG½Ç¶ÖŒ\é­D‘Xz/\Ö÷\ì\èuó\"\ÑJœ\r«h2,\ä\à‹¤ñ­[>\\YTP«Wððñ™l	\ßÿ\îüøG\à\Ù;dC{H·E	¼‚T8\Û\á6W¦ Ýœ5P»5\Ý\Î^xñK*\0^þúŸ!\ä=\Ä\â\ä%\è·\à0lŠ«•¢ˆ)fQû¸ñ\Ü<9õ˜\ä\Èð‹hÓ 6Oµ,@Ð½}3Jyª~I\Ô\Ê	Ô¹ÑÚ´H·½&ý2Õ¹$\í$z­¸¬n3†V›F¥Àx~.ñz¥\\@¾-A½z\"\Õj\ÈÆ þLþ(33´$Xišu´\ÇBÓ CµœÄ«·,ø»\Ë:,oš\àt¹T3\ÎA\Ô<uñ\0HT\ÐM‹ø³}`\Ã\Íy=\ÌvZc`W+Q!yL‘\àKQ5R©¦a´¸\Å\Ú,,kðúµ%x½X\ì,N˜Q=©[\Ôjq!µz\n½~\Él\n¶`\nFw\î·ð\à\á¥r?þ\áûª 	 \äX\ÈiXxNf±¶0	ý\îm¬-M\áoÿ\îU\\}û\ês\0|\ë¯þŠW‹¥\ÉK8Ú‡Û²ƒV5%?x\ÈgÀ\ÙqEü“\Ä\â”m3	_\ÒIÿõ^ñÏ±˜\é”†#Þº²\í¡‡zƒ,\Î\0­\Þ£É‚#³\r«—[~l§\Ë	§\Ë×…`>Ý‡D\Ì+jO^­F§Esl‚[\âh†y\Ê\îÑ¢\Ä\äô\Ó\n \Ò1\0D_hd\Ñk\æP-%\Æ\î(#®Dn_\ïÂµY+®\Î\è¡7;……‰\×\Ê€\ÊüÇ’0sNY,mê±²z„jQ}O\Æô( ©q|\ç\'%1\ãZN¯\Íz\ZŠÀ\êŽÁ §\Ç%T*)±ŒBJ•(ªõ„¸‘\Z­P=oÐD*ŒÁ°€.\Éö°Žx*‡?z€Ÿüøc<}\ÜE6´D`!\çó(€‚];\Ã\Þ4V\çoÂ¢Á\Ì\í«x\ëµ\Ëp\è\Ö\ÉT\0|\ã?þ\Ñ\Ø¼\ã\Î<|\r\ê¥8\Ò	\'£Š\Ä\î#ñ÷y!sücy\â;\Ì\nÖ“(Wböe³\n*¥0Lf3\n4\ß9¦R©÷‘I$9\Ø\àv[\àtša³›`³›a²˜ 3\ê±sp€­½=l\í\íck{‡Zô°Zõpº-P\"a\'	¯È½¥BõJH€\Èú¹ñM²ÿ¸lO>\Í>ÿ†R1ŽZ%…v#ƒb1ŽF-…}o\Ü<ÀÖ!\Å\'>ž²l»žÀ¨“\Æ\ÉXÓ¿\0\0¥\ÝN#7®narz±ˆ_~þmr@Q½óc†€Yø|8\\.!\ÉZ£k\ëFƒ>I«\×j9qw\ÏJ\nyYÁhX–\ÃO%P(eq~V\ÇùyMdð\ä\É\Ï>¸‡w¶‘\ï\n	T\ì\Ô\0a\Õ\ÎÁ´?\ãöVf¯av\êmh¶ncþöU\Üxû26—¦ž\àoÿürk±8u	\Ú\Í9(^ª…¨À€\ë@BBž”A>”f_õ\ë<‰ô»zL4ö|\ä-‰v5‹ÝŽr%„*\Í4¥[¦\Å\ßGÐ¬\ÓtG\ä·\ëQ´\ZQ4Œ\Ãi\ê™\èñ¡\\ Td\â‡\â©-Œn¯«	F\ÓŒf3tG&hô\ê¡=4\Âh$˜,p¹-6zM2   :BH|r’¹£›n\Ü\\t\à\ÕI&æ°¶gƒ¢„P.%$\ÏDÏ±dUþ#<¨—Ã¨\ÅôC|\ã\Õ½.©{è¶©|2ºI‰‚w‘8\Ztó\Ð\é\í0[œ8•°¯sbjFƒL&$¤9N\áðÈƒGwK8\å}h5z\Ý\ÎOK(–3hu*xü°ƒ÷\ß\àÙ³s\ä+uü\àû\ï\á‡?ú\ï=\î\"G\ØAÐ¾,&_¿=…\Ã\í›8Øœ\ÂË—^Çk—1?=;37±4?ƒ*\0ø\ë?û¿e£i4³ˆ,¢•Çƒfûò\Ç\Ðo÷›ô\ß<ññ\ç¾v¼jUf³Q\ãZµ\ìv\'Šù\0*å„]rõJ5†xcŸ.«¤ Z	¡R¢\å\ß.P)òdûQ+*h\n1¼ |¡±PAÈ˜Ÿ²k&\ãG<@8\ì‘\Å\éñÀ\îôÀdµ\ÃduÀhu\Â\êðÀ\éöÀ\êpbaÃ†¼<qˆÅ#Ü˜\×\ãú]•.CK·ˆX$s\ÕrXˆ*#F%* §psybšC3Žûj]-5ÿó“\"î•ð\ä~&3‹A\èR\n\Ø\Ú6 ö£V‹ t\äanÍŠ³c¦“ó²ù³Šy\Ü?« XÉ \Þ,IMSó|pŠd¶ˆ\ï~òŸþ‰(™\Ð.~r\0º€U8ô\ä\038Ü™Æ¹Iwoakó3SXš›\Ã\êð\å/\0þ\âÿ\0^\Ç–&_†vk!¿¹t\0aA»\n\0aÔ­‹“¯nº\Z~‘ŒqQ«J¦Y‹\Ãl¶!—õ	\0˜\æ¢r(\0àªŒ7œ›_Œ/)\ìø„\0òº\0£¨²^—K\Þ.)-ðýøù\Í*£\0ÁÈ˜P2M\à¶jIñ÷¡bñ0ŽŽœðúƒX\Ý÷\â\åü\é%\rþð\ïwñòµ\ì\ì[°£±C£wÁj÷BgtÀdu\Ãdõ@w\ä€Vo\Ö`Å\Î\n£ÕŽ­ƒ#,.\ëp¨5I.`Ok„\Þd‡\Å\æ„\Ùjƒ\Ùf“0q~EÃ‘\áˆ;Fh´G\Èd£\ètòðG\âÐš\\(–cHfb\È’\'c\èt²xú¤ƒZ½„N¯†÷\Þi\ãƒ÷ûøÎ·\ÏŒ$ð\ÝO\ágŸª@\ÙC’\0°¯\Ãkb&pv\í´›·qgf–ƒi,\Ï\Ý\ÄÌ­\ëX_™\ÇÕ«\Ï-ÀŸýñ\ï\Ãm\ÛÁò\Ô%\è6g\rXOø ¸tð[wÄŒ©±;\ã\î(ª,œ—\å1\0jQ\äsA”Ja±\0n·{·s\Ó\éwU\é¸\\dx4Ž\ë\Éò>!›Tòx½ó¢˜÷¨€ õ(‡P–\rWÁ\Â\Í/ÆU\"–QR¦h\Ð\É)}&v\Æ\Ñs\0\ç£,Gv\ìh\É5\Ì\â²\"± \"1\Ú#7®\Þ:€\Ý\åA§•F0D(\Ì\ï•“^\È\ÇP,\ÄP*\ÄP\È\ÇQ.\ÅP*G‘\ÎD‹HK(ˆÅƒ\È\åH$˜¥ \ÂbwazaoM¬\â/^^Á\×_\Ý\Ã+—÷p\í¶ÿö&n\ÍÀlw`WoÅ‘\Ý\r\Í	£Õ† Äš7B“iõ\ÓÚƒ\Ö÷¬ø\Þw\ßÁúùwñô\Ý>\Ò\á=±\0\ä\0\0ýœº9l©\0 \Ð\ïRžƒù`	Ó¿\0€ÿ\ç\ßÿ\Ü\Öm¬L½‚ÃD}f\ä\ã^€Ïº‹Q\0H õ#A™6\ê@2\æD2\êD\"\âB<bG,B¹ÖŽPÈŽDÔCJÀ.’n<Fy×©J»\Ç2.k\î\Ô\â\æøÕˆ\"•p#“öJì­‚,‚Z‰±HN8Q+)b}!d\Ç\êž$ƒX•$A\r\r	\Õ]QqLJ‘\ÇÁ¡\r‰¤ŸÏ‡\Å\r\Ú\"T“‚QX\Ìx.’Š¦HTA4JIX\Í*Ž\Æ\ÕH4÷ù\\\\X<_\Ó\ïR\ÉT£.\Ö¤\ÓQ1\ã\'£†}šó\"ŽûE‰õ‹…8bñ\Â\áJ\0.?#³Q\Ç#ª9´\Û\Ñú\Ý¢‰8‚‘8\Â\Éœ\áölqL/›ñÞ»\'ø\îg\ï‰H\0¾m(ŽU‰Tx\Z[«7±0}\ÚÍ›8Ø¸‰µ¥›x\é[o\à\ÒË¯>ÀÿÁ\ïÁy´†å©—q°zŸÙ˜Aû!6$?T•Ž?2\Í\îxcÊŒ\ÕÃ¨Ub•Mó\íù ŒbQ²	’QbFØD„ q v\È}QÅŽHH]¡ ¡ Aÿ¿	Å†\â€dÀŠhÄ†XÄ†d”2¯±¸‰¤q\ÊÁ	·\ä	1—d\â˜T¹HsQ\Ék5“H$\Â\Ð\ê,h4²¸ôöq¿ˆEjÈ˜”ðNQü’\ç?±¸j¿KU1Yz–F&\Æ\ê¦ \ÓóûˆE|h5b¨Uh\ØÚ³Àd÷CD99 šÄ¢yˆiýœ\ä\â‰–\Öô(´8A¤S´¤QÔªiIµß¿[ƒ\Õ@:›ö\ßö\Ðôˆ•ñÙ§\ï\à\Óï¾‡wŸt‘!	ô\ï `]‡yoº­[8Üš\Ä\Ò\ìU\Ì\Ýz\Ú\Í	¬\Í_Á\Ò\ì$\æn\ÓüBð‡¿ÿ\ï\à0®`e\êöW¦õ[‰º°k\à·\îI,­š{\Õ$\á\Ç.€—0\î1[Gµ\Ëj·ŠfÀ\ZÀR:€\Z\ã\ê|õ|D½,FQ¥._\ä	£Zd\Õ6¿¸‚tÊ‹lF-´\Ì\ç|(\æý(\ä|\Èg™Bõ\"•t#™r‹ò–Lx‘L0W\àD2î”¤­L\\€G\å’\ëñ­K\0ú#L&«øo%hC!\ëC9OµQ‘:€b.†#œ2Ø“\ÐÐƒ!\ë\n\Z)œô3È¤£\ØÓ˜ðôIFò3Fý4šu\Êf±¾y$¹üD&­\îHj+\åvu¼vm3ûðx½Rš\Î\Æq · \ÝÈ¡PL!J\Ö\ÐÁp\äAIxAvO\ÝAK\Ø¹\ÕD©\Ù\Å÷¿ÿ?ûùgxúN_H 9@Ð¾.\Z\0KÁ¸Ö—&±z\ç¦\Ôn¯N\âò\å+X_š\Åþ\æ/Dðþ.lúe±\0{Ë“ˆxMH‡ð\Û\à5oú/H˜³\"\ãî°˜fšj\Þ\Ï$c}†Yµrv‡]L|6\ãG9« Dý=\ã—2\ëB6 Œ²l+\ã@‰Ÿƒ€«TP\ÏúQ)“\0*_\0Oz½\Ñ`\É2«„V\ÆÇ¹€±´L\Ó^M¢Sc]\"Q²¨•™T`µ:\áõ9H\ÌJò»ˆÀ•\ä¥z£	;zG\â\Â\Äe%}\âžql\ì\àõÚ¥\îÁlµ˜¹(ž»š#$c!¤\Ò1\ì\èq\ÒO!™Š`Skþauy±±o…\Ë\íE½\Î\ê)\nia¤“<¾\×Àù°‚§U(‘b±¨\ßf\n%¸ƒ¸£h\\)«-|úñ;øü\'ß–00#.`\Û¼¦%X\ça=œ“¿²pC\Ä \Ý\ÎÖ—nA¿Kµwõ9\0þ¯ÿý\ßÀ¦_¸»4‰\ç	ÅŽ€ƒ\0\ØE›§„iÏ™97A%dA5f§NÎfŽ¾¥<F7\0\0 \0IDAT…Ë­&SðþT\Ò+Ša2\á\âV-F\á)\ÏTW2–\n†\0\Ê%¦‹™ˆ	¢V\áç…ŸG|NA•„¹\É4÷”Qe\Ãqñ\Ë\ÂDcˆKV“‚køFmV÷\æp<Ê©ùÿJB´\rµ„œ	.5ûG\Î@5°Yg¸KM€5{jX­DË…°«\Õ\Ãê°ªy)j\r \"ñ\Âdv\à\à\Ð\Ð*à¶»\Ø1sg—GV+\"T;“A\è&\Ñö4h5z´Y\Ü?® M \r ^\Ïcn\Õ½9†v¯‹P®Ž\r}ô?ÿ\é§€t\è9\0(1\rl\Ó\Îbke\n\Ëó0\ìÞ†fk\n&\í·a:Xz€ÿ\ã\ßþ/\0’@Z\0\Åm@R±!`ß‡Ë¸%\æ¾86\ÃL\Îð\âÁÈ…•\Õ@\0Ôª1Éª\ÅcnQi¸™\\$}\Ìß³D<“ô\É}4ó¿h]ª,ÁR?‹\0`@\0’^€€œ„›¬V	š(\åù¬”ª%‰\Ô\Ù?A½’‚\Û\åG8\Â8œõI[\Ìk¨D$Œô\å\'ÃŒT»$€j™9	\"ßƒ<\áü${g$l\ì`Ù›ÚŒ\Â,!«¥X14bai\'%µ\0ñXÓ‹Zll\é\Ä\Õ\ä²\n¢ñ t&‡\äH^/®Om\ã@k–(*ó\Ã\áv£X\Ì\ã[oë±¶\ï‚W‰¡\\¯bÏ–\Ãñ\Ù?ÿü¼û¸#õ€q!+ð˜XñCx;kSRz¸5\í\Ö$\Öo\ãò\Û×°½:ó\0¿û¿þ+\éZ™z;‹7\Ç\0°Špm\Ê\ÓO’¼)>\"A¢Š\rŠ\ïA\ß\Â~3BŠ~’·€‰ˆ\Z­~¯Y\"…hh\\\Üq ²ÉŠ†9¨}6\Ín1\çG•.$FY\\€\Zþ5\è¾\ÈŽ\ÓÄŒj\áò<Vü\Ö¦…%\ï\Ï\\?u÷JQMÆ°ÔŠ\ì\Úf÷azV\Ù;ZQ\æü~ñ¨\ZR2§\Ðj¤0q[‹Å•x½nD\ÂT\"#F’µZiø‚AÍ”²]‡¼ò\Ô,§šƒ`¦P­A¤\\ž’\ÏeEpÀÀ­9-œ.7ŽYD\Ó) \Õ\È\ÃI\ÆuvÕ„¥\rlNf–L˜]5#Ž£3¨\áú¬\áXgw»&K\Ø2g\Ðtð\é·\â­1	Ü‚ßº\ËÁôÛ· Ý˜\Â\Ê\ÜUL\\{{«×±zg\ßzù-l­Mcg\ãð¯ÿG˜ö\ç±<õ\n¶\î\\GÐ¥G\Ôw$\0pm¢”\ç\æø¤=ŠU´,±.\å‚È§hò(¤¢É³R‡\'<—öB§7\Â\ïµ ¶#°\"´¨²#¬\0D+”€	\ïÂ¬ø	Z\ÕÇƒV(~‚>\ÂbŠ]\\‚+\êFŠ\ì?\ê’÷\à\í„¸\Ça¤ê«¥0Sü²ZHÊ¤\nINÇ‚‘„hn¯&»“sF!’<\í¬\Zº1sˆ\éy=Ž,N„B~˜,.x=^\Ü=\É!\Z\rc}×„x2Œ\ÝVwL°˜­\"i8™™¬Æ¿H\"±Lœ\0ˆD!T%1†°\é…ùþ‚‘H\Äf‡‚›È¿÷N«(•2ˆ\Æ\Ó7±s\è\Å\âª÷\Ïø\Þ\'p~6\ÂG>\Â?ýü3¼ÿ¨‹´B@°\"\æß´7\ã\Þv\×nczŠ­³¸=9\Ëoß“n\í9\0þ\Íÿü;8ÚÅ’\0\à*‚.\0 \à<„Ã¸…«i22mX\ì86\×ù0j¹ª¼&=EŸ­Ö±Ù¬¤b>T\"ŠªG\ÓM·¡†¬\ÒW¸Jc÷BwP(PðŒË¼\Ôr¯Â¸¾?—õH£\ÃÀW\Â3fø.\Ä\Â	i]¢!\'Z©U€—Š{…\'\ì\í`6™`84a{ß€m\Ë\ëzX-&ù^$‰³KZ\èôV\äó\nlvL\'V\Ö1\è$¤g€*Þ£ó\"*\å¤\0eoÏ‚¶d#Õ²q\ê\0¬:f2Apï´ˆXDA*¦ ¦x`µ\ØÐ¨¤¤øc4\Ì#\á|XB6\Ãü‚>ŸùL\íV¹B­V	\áDN\Ýn\ßû\ä!NŽø\à\éü\Óú.\Þ}§7\0£€\rxŽH\Ù2ý)\é`=À7_z\r›\ØY_\Â×¿qù9\0þõÿô/aÜ°½pU ó\0N-l†Md’.\ä\Òn\Ùúo\ÙP!b!5¼Ë…™4C8ú\ë,6+\â!T\ß…Ž7X6\Ú?\æ\êu\á?Šy¯ø|~N6\í‘H\áyØ©J¾\Ô!\Zuº\0V5zIFE¿—kR%C¹A™E£Œ\ê	\Ñ\Ö\rGV˜L6h´ll\Z°¹gÀ•˜Œ	[­ll1q{³‹»X\Ù\ÒaOg\Ã\Û7Ö‘‰»x0wgG@\ëp\Ùñ7/-Iv2÷H\Z/©rª¨CD¤·P	z‘ˆ\ÍE±£1Jµ0K\Ì\ØO¡Dc\"”‚\Ízùl\nN6W\0wOùR\Ù\"sŒNúxöô!~ö³\ÏT%0t€\Õ\ç\ÙÀƒhv¦p{ò\Z–\æ\'ðõ¯¿Ž\éÛ“øú7/\ã\Ïÿú\Ês\0ü«\ßù-wf°6ý:¶\æ¯@q\ê0D\0l “¤öH1\Ý\0/yZ*¬\Úe\\\Ï\ÒgI÷ª¦—qý‘•¢ŽS\0ÀJú÷\ç\']Mô\\H’\Ë\È\çÑ…H>\à\" \ìÿŒ2\Ô|CHjµ*)”_XÁX˜‘œ:S´)9‰:½kk<ñ6\ì\ï[°¯³`uÝˆ€\ß%$Ž\'V§·\áö\Ü>4F›$zA»ûvI>U\Ë)±\"§ƒbq¯¾½Žt‚ß•½¨{”(•¢\È\ä$RA$\Ó\n‰\0\â	¿TNg\Ó!¤XK‘ˆnrdu!Á\éõ\â\å·\Ö\à÷¹p\ÒÏ¡\\LJ(\èDð\æ¤I\ÜÁ»\ïôQ­7Pm´ñ\ío?\ÆÿûO\ß\Ã\ï\ÆQ\0°i	6Ý¼ti¦1E\0\ÌMÀ¤™\Å\á\Þ<,ú¸Œ\â^\0üÿò·¥mx}ú5l\Î]\â\Ò#´ \è8€Ó¸l\Ê) S#\×\×\nq*Dy>,ÀÈ¦\Ò*:€“iU\'JYõù\"´P3(ª›­ºúg\Æþ,¹b„\àFö\ÓDyq\\di\r„\0VYfÅ‚UŠUE)õ~¦”i%\ÞQ,)õ\Ò4\'q:\Ê\Âxd\Ç\î¾É¤ª,,i%¹\ãõ8Å³\nXo´bþÎX²×¯\í\á\æ\Ì>ôz‹$˜Rnl’üz±´nÀ_}sEþ^²ÿ^=‚\Ì\ä±r¨€\Ó\ã°¡fP’\ê\é“~	ƒ~I\n=X`\Ã\Ú\0¶\Â!”JI˜\í.h\r\ìi\í09\ÜHeÇ£(r¸³n\Çò¶\r•j¥j.o\\:¸?û\äµ\"(¼¸—J\à\Zl\Ú;0\îN\ë\ß_›\î\ï\×\ßx\r¯¼ò\Zn]¿Œ…©˜™ú…\\Àÿ\Ûÿ-·oasöul\Î]\0\Ðømûp\ZÖ‘M©. B·\à1J¶D‘@8`AŒ’mÐ‚€\Ï$¤Uº\Æ#=\\’;‹Hº\ÌHþ \æBj\\­ËŠ\Þt‚e\á\êb\ç\r\Ý\Ã8Z~®Z\Æ\r\æÆ’_¨f>›¥»`h\È5„1X{\'\Ý81\Ù|\n<L\å24$Kg\Ûx*Æ‘É¥-®\ß>\Ä3xv\á,\íZDüü\Ö\Þ~\ï?,\à·\×qh°\Â\áòH\ßg6´•„\ÖhÁÖž7g1³j\ÎC•°_cq~f“J8€h$†v-+i_ \Ý.@£3KS³¬œ¡IÄ¤\àlTÀ\ãûU)\r\ïõ\Ëè´‹¨\×\Ë8>nCgI\Úøä´‡\Þ?C½\ÑÂ§\ßyŒ|ÿ)žJQ\è\"\îmø,+B\0)Sû\ß]½! \Ðn\ß\Â¯¿o~\ë5\\¹|×¯]\Ç_zQµ\0ÿ\Ýoý\æ\0XŸy[8\0th\0\é¤yþ˜I?²qVá¨…šyš3²þ”_4øh\Ä)þ%\ÛZ½N‡Y@¢¦d%A£²|2~‚&\è7É¥ \Ëx~_.\Èk’°2\ZVAÅž®0U‚„\Ã\êû†BY,an \'\ÄAI,QMd²Ye¨š$`*•8”ˆþ€Z†°6t1©ø9\Ð[±¸ªGXñK\Ë+x\Ü^ŸtÓ•PPÛ¾3Ò \ÂÆ”‡9H{;7²ˆF#‡}ƒS‹FTŠ	œö\ÕV¯Ñ¨„#‹GZ\ÒiÞ­\Ã\åö‰•\â\ëFý\"\ÎFe<¼[C»›GµZÁð¸	³#Ž\Í=\ê)<z8Do\Ð\Ã¾÷>~þ\Ó\ï\â£÷†€˜wS„ \ÏÑ¢\Ô\Z÷©þ\ÝH»ÉšÀ[\"YuË°–Ÿ\à·ÿ›\Í\Æ$6\ç\ÞÀ\Úô›\âû	€\ëP\ædR@)@1@%’¾x\éõ\ÏGPÎ†©˜%Ê¼Ef\Ó,¢ˆ¥N1\Õ9ö\ØQõc[WVA=F9§›—>:€òô‹²H~ n\"-7‘be\ØtŠÚ¿[E\nM	¹t!²\"L!\ì”K‚,¤e\âu\'Qò“0´Z._‡A³xŒ\Z-\ÃL‡j…R\ì\Ñ‰5h”I\â\ØÄ¢J\ÙQ*¥  xdB£:nc \Û\à[¬œ. “‹C{\äE(\ZF¿\Ç {ýŠ¨V2ˆ\'Â°:˜\"\àdT”‰+Á \"M¤\ï<¨\ãÁY÷Ï›x\çAWH`µJ«Q\ÇÌ¢\rG\î÷ñôý3tû}üðûOñùO>ÁG\ïÿ\ç\0p2 aú÷·UH³\É	!“\Ðl\Í@¿7\Ãþ\Âs\0ü\Öoþ†Œ\Ù^x[\0t\"¡Xr\ë\à2n Ÿq!—ô¢”*µ¬\Êþ%L‘M’åº„I3>˜-v$\"ª&À¸Ÿ1Ÿ š	\É\ë+i\ål\0¶x§.\Òô\É •Á|P\Z2Z8”_Ur§ò\0Q\'YqD¥Qøy\Ë\ÈU=¾RVK²\é\n\Ò™J4š,,\îJ1«\Ñl—BUF”¬ù9\Ò=œ\r\Â\çs \ZV5\r\æ-\è¦ø†œ,|\Õ\Ì\Ø?<‚?\àü¢\ÛXdmr Rw6X\Û\Ñ!\ZsK\Þ \Çj_\Ô\ØÑ˜ð77°²iw\Â\â\ÑC½\r×¦`8rJ\ÓH.ŸF¯SF.ŸA¹L±¨—?\r/Š§\ïñôý»\è‡øü\'KA\È\Ç\Ë|€˜\è\0‹p\éY\Ú?;¶\0ÀMh·&pÀ1\Û\Ó0i\î\àH³ø\0¿ù_ýs\ì,\ßÀö\Âe¬\Üz>\ë’!+BžC¸M›È¥U\0T\ÒA\Ùl\07\0Þ¦¬\Ë\Ó, \Ù\0,6R\Ñ\0j…œV¦j&\ÒZTsŠt\Ò~	›¢QþP\ì¨U£‚²D\nj>sü\áÉ°¥à¤¨\æ\0H\ne\0W	d‹7­-\ný2¿û\Ó|^.(õÿ.‡E{>E8B}ƒ ŠŠz\×l$„±²n„\Ý\á…\Å\æ\Ï\ãK½µ¤\r\Ý,R‰\0ô«dõ(÷[y!‚\Ý.;™È¦¢\Ð\è­884¡\ÊÀ‡–tC¥°ºm†?\è‘ü¿g<^\Â\ê\ß@D\Ó\í‡\Ë\ÄÆ¾^¿‚T6‰b9‹|1‹6»°u4Z\r|\ç\Ûñƒ=\Ã\Ç\ÏN‘‹ \æS-€Ë°\0\Óþm\Ùøýõ\Ø[»Ž\Ý\Õk\Ø^ºÝµIl\Ü\ÆÁ\Æôs\0ü×¿ñk\ØX¸\"\0XžzM\ê\0’4£^=<G›bò,\Ò\à\É¯F>:N\íF’\é£ÎŸ\'«J½{*@u™\0\"”|“ðÀ\çdh\ÆÇ¹ûDÂ‡\Í|Ž\'0 ‰#¶}‰È²Ò†;º „}‹¸\é<½<¹t’6\Î\å„f\Ç\Ò0\çóð\äs±ˆ$‘u•«{˜TN\ì\æe\çµ7“É“A:ƒ‹ky/™pRO\Ëóx›½·g5ò\ÜW\ÞZ\Ë\é>ä±²kƒ\Ý\Äé ŒT†Ÿ—s“TNJxx·\"\å\â¬d¯%\ïoV\Ùq\\\Ä\ÙY\ï7ð\ì½.\î7¤ _(¢\Ó*\ãƒ\'}<¹\ßÅ \ßE½\Ù\Â\Ç\ß\Çw>}>=F>r€¸>Ë¢\Ôÿl\ÜÀ\î\êU\ì¬\\\ÅöòUl/]\Å\Ö\â\r\ì­\Ó\"Ü–ZA\é\r$\0~\ã\×ÿ™\ì-]\Åò\äkðZö\ÅDGp›(zpR–Ñ \rA\ïBF•\àù\ÍB\èH\Üü>üŒ\n\"n\ìiŒp9\Í\â[”vC6„\Â(Š\ë‹\Ò2x¤ï™Bªu<ÁñÓ£\é5`\éw2Å¬™)ši‰\n”L³c`\äòŠ<\0\àc8N¡Š\È\ÜBS£ò^|o>—Ški-\n¥ˆˆElo³»]\Ò7Hò\Ø-!+a%û|>—Lc¸\ëó{£\Å*E$ô\Ó[|X\Ù>B¯\nbVµZ9\äóqø”0N\Ü=Qg	³ô»Œb>½\Å+‘‰?F$\Æ\éq\Ï\Þ\ëÀ\ë‹\Âdö\ãdT“\Ì\ßñ¨‹³»\çø\é?~„Ÿÿô3|üÁ	ò‘}€ßº‡þLû\Ó\ÂHIð\É4›“\ÐmOÃ°7\ãÁüs\0üú¯ý\nV\ç¯\à`\å:–o¾\n¯uIÅ‚XÀÀ\0|žÔ˜™øó•fuN\Ôõ\Å\Èútž\ÊC\Ã<.“H²‘ˆ[z” Á KÇ˜r!tHÙ˜TýŒ;€¹XZð[\àó[\áX\áó©+V«‰\â§\0„\äMF\Çd\ÔFRZ¶gq\Ñ\n¹‚\"õŠ—W„—£FRÄ’©^†t²Yµ¬Í‘5)`%cl\ÚJ1¬$¯It;)T9Ë§\ZG¾‘/)æ°¡\ßO\è8?¡Z\Ï\Ã\êR°cp\ã\êœ	‰$¥\Þ½\Ýg(˜„\ÑB(\Zƒ7…\Î@E1„§\ïv±\ç\"O ‰;›$2E<xx†Ÿüø|þ“\ï\à#\Î\ï#:&jAÈ¬\0@»5%\á\àL\n™\0°6P¿7û\0¿ö«_\Ã\ê\ÜehVo`\ãb¬H…\íH\ÍRB½ŸþŸ$—\ä\0*`…\\ ™˜&•Z¸\ÃI\àÁˆb2’/\Ï¥\å¬5®V\ç\Ä\ÇY;>\â\rÉœ\Ú[\ÇS\ÍSœa\ê4\êE,\æB6\Íj!Ÿh	\\¬b\î@m1g8\ê@4¦†‹\\$c©´.¯;\Z3œ^7\ÖwuRDþaQÒƒ(ò\Ã\êtaKkK\ÆI%òf(Y\ÐLJÈ®Á‰}]:¤h•4ˆssù6÷,¨\Ö\Ù&–P\Ð\Ì\ÂŒÀ\î\r`s\ß(Œ>‡hurxt¿ŽL>\é%ªµ:z\Ý\"\ÜU\ç¦²y4[5„\â%\ì\ZRxüø>>ÿ‡ñ\ÓüD:†Y\Zõn¨\0Ð³ôö8\n ÏŸ—@>p¸É‚\Ùð‚\0\àŸ}\íkXš~š•\ëX|^óžp€TÈ‚ mOÒ³\Üx	“~\á\0$€¡!µšr\êð6;C+¼–@†S\ä2\".‘²°:[µó4\n¹\Þ«¦T¹¤»Wb\í„\Ä÷\ÜHUñ£\ßfš8$5\Ìð>F\0Œx¢ùú²\ä\n³g‘ˆEG 1XD\Ü\Ñœ‡\Ý\âÓ‹2¹Œn †C+,v\'¶v\r(\ç\ÕBF¬\ï£\Ù\Ø\ÓauK‡7\'÷ð;b²lf	Áxd”f\ç±½O±º×ƒ½\r“ó{2Óˆ\r¤liÖ³\È\å“\ØÖ˜P)\Ç\ÅÊl\Ýn¡Hók\Ô|\ç£S¤òm<~t?ùñ3)ù\è™\n\0’@¿X€ù/\0@À“¿·FNpû\ëS\Ò!\ÄõÂ‹/¨\0ø\Ú/}óS¯C»6•‰W\á2lKWP2l…ßº+§ü\âôs]l>7¯žÊ†Vs!\0¥]›Ã‰xØ‹&7”Q..¨	#™ðQ\äf\ÏAÀ\Ïi\Øÿ7.\ä_Š¤[P7‰?(e\à‹ž‚‹òô\êx„\Zª¥jY:\n2J(„\Ùe+®LÀ\ã÷\Â\çq‹üÛ–\î\å4\êµftzþú•‰DX\Â\n!\n?}g´yq{U\ë³,\æô \ÛNK\æŽSAýn\Ü\Ò\ÂjqH¹ZUt‚4*µ4\\(Ü¾®M\ë\áô¤õ‹¥\Þ\nG±½gA¥’@¹œD­–Aý†½<ÌŽ0¾õ\æJy\Î&¨ \\)a0j\âñ\ã!>úöc<}:B&\Â0p^ó™p°v\ÛKW°¹x\ëoaiúU\ÌO¾„Í¥\ë\ØYå°¨\É_ÀW0\ã´«À+pw\Ä$#,\nÙ“M¡žÏ„/e³xz9Ä‰›(Ó´bRÇ‘n<f»Ñ°O\êõ/L:\Ù6\Ù8 ªN\Ï11\Ññ¨˜ñ†o3† 0›7.IÙ—‚\ãÿ_,R½¨VV7Ÿ]È¬ªU\å`¾7¢#-[I$“aÉ¦94#–\Â\íqJ‡2[×¥é¥‘\Â\êŽ&‹/]\× ™Š„\ÌA4\ïl\æ4¹ýø\ßþdoL\î\Ã\ëua\Ð\á”T¦v\è´ó˜˜\Ñbv~-ª†\Ôÿ9l£[@@‰ab\Ñ\Ñ\'\é\â!Ji\ækˆ%³X\Ùñ\à\ä˜8«¸w·w;x÷Q¡D›>Ü»\×\Å{ïž¡;\è\ã\é\Ó{ø\áŸ\âGÿð±\Ì\rÊ†5\"ù,w$h\Ü·†m¨¡\à\ÚÌ«X›}\rš±\Ð\í\Î=À/õË˜½òM\Ò\Ü|.\ÃŠÉ¨MZ\Ãh–+\Ù\"Š]\n5Xˆ;e¥\Â.¤X”u#S\Õ9šy­\Ñ¿\ß5\æ·X\âfN\æ.}ö¼@¨e\å\ÒZ\Í%\\@-\é\æ,\"¶•±¹D½_­ÿc2IÀ>Ã˜lP“\Í+,_—¥N\0a\èG\0pFÀV ”€\Ù\á•\Í\åDµ\Ê6r®ñƒF\Z·—Mx\éò¶ö-*xÆ³„\Ù0\Â\Í\å\r#þþ\í=,l¥Ó—\0\èq\æ\0Ç½´r0›\ÒRÏšþ\ãag\'ŒŽ+8²°²mƒ\Ö\äG¡\Ç™µXÆ£UdYX]a™\ÂzrRÅ£û]<ºß’r¯|©’\Äù\Ý.>úð½^={ˆø\Ñ3üôgŸ\áÃ§\'È„T\0Xa?dc\èô»w\ZÀ•\ë\Ø]º\Í1-j L\n\åú\ê—_\Äô\åo@·qK×¿»nÉ°©¨>ûž„=f2	\Òq/\Ò,Ä ò—ð\"v#rª²l„ó|Xþ\åÂ®\Æ›\Í\"%_Ró\Ïv H…1l6‘\Â\r;\"|]˜\Ñ\ËÆœ’<¢œ\Ë\Âªˆ|\ï‹¡£ß¶	Ñ£\Ö\ÏJ¤‹.#¦RW\àm††—\Ô,\Å\Ñm$Q(\Æ$\È)$„ÁM–9NMca\Ýo@‘‘.,\Ð\ä`	˜®ß“2t&?n-\Zav† ;ò\á\ì¸$„m\È2¯a…GÚ–\äôs²\'+|\Øñ«3ó¹uD\â…r¸·*\0xp¯ŠN¯‹CÁ½³†„{÷\ï5ñøAO´Q«—¡³„°¸\å‡?šF½Ñ”,\àðÿø9I\à\és\0˜W¥-Ü´?	\Ã\Î7nB+b\ÐUH\0h·þ\0|\åK/b\êÍ¯C¿1¥‰—\à4lŒ0¶\0$ebú\é£Y\Ä=\Õ45!\Ä\éu†R2\'9³Ý‡€ŸjWµ\Z}!g	³?œ9y\ê\è>o¨÷\Ó\ZÈ°ei\ÊT7“\ÂóT\éBb	²zv1P»‹0\çðÅ¤)£\Ø\ÄEa\É\'y{–\ÉÜ „‰q·Ÿ›Ž«“E\éþ\ä\ï×¥xsWg–\É-s”ƒ+\Õ0<~/¢©(\Ö÷\Í\Ò}\Ä\ï/ƒ\Zª¥\à€Ž|%· r\ÈI¤‘h{\Z;\Ò\é$ª\Õ\î\Ý\å°Í²\Ìatù\"0\Û2ùûô˜#y[xü¨\'Z¨7*¨·\ZDh¨wºø\Þ÷Þ“\é ?ýùgø\0 ,.`Ný,·aÜ™€~s\Úõ\ë\Ø[½†\Ý`¬\ì\Ï=À—_|So|†I¬\Ü|N½\n€L\ÜÅ¶‡V1.\É†ƒ*\é‹\æ\æp<¹€\Ê\ä\Ù!¬úz£Ù… ¢Lò9\Â\ìK\ê<?n&¥[Š2\Âðÿ‹%À¸¸Í„‹<|€¯‰Hœ1›\É\ÖÝ‘\Èý\âL@ö°\ÝK¢‚2ËµÆ2º]\áN\Ï	ž|¬\ÎaM¬ôN¯\ê‘\ËÅ±o0I\É9¿\Ý]?—Mœº#¶lpý¨V£\" ™<¥QUóÅŒ€\ã\ì„\n\Ç\ÍÔ“\ØØ±`OgG$\Z\å‘mõ,2¹5{ˆ©;Ã¬´\âýI\Â\Í$S,‘€É®`a\Ý·?X²€÷\Þ;\Å\Ï\î\á{?xŠgOG\ÈRò’.À°7\Í\æ\rì®¾õ;oaý\Îe¬Ì½)$psù†´Œ}\0r\ë¯þ\n€\ÉKªÙ;´\ï¡I¢wÁ\Ô\ÇY@jþd\ë\Â\ä\Ùù;&…$qo,v·4MRu“~l\ç)§,Ë†\ÙTV\í¨-S»¤/¦w=Œ“óU \Ä\ÔÐŠ\Ò.o\ËL@µD\æp5Ô²1ö²<Œ›\Ç\Í\æ\ÈN\ê\è÷.\æf‘Jó9,ùÎ¡\×É¡ZIKŒ\î†\àðú\Ñ\ç´\Ññ(üV3ƒF3\á°,\æ=_\ä\àˆŽ‡!ndõ\'£ª\Ü\îv™\ÎÊhÙºw^ÁhÀU\Æýóª\Ø\æ<`ºóÓšô	V*9Y\ÃAƒ§³·pï¼Ž\\!ƒ\åM\Ìö(b\É\"œþ8ž}p†Ÿ\ÝÇ§Ÿ½+ ¥\ì!\êY‡\Ç<\Ã\î$4\ëöQ\n\ÞZ¾‚ù\é+¸1q“W±³:‰\Ã\Ý\Ù\0¼ˆ/½ð._úKÀ\êM\0©ˆù„AÛ¾øN€«UIJ3&‹;9ú¼\Í\Ñ\æ\ìþe·,ó\ìR†\Í\î–—½pL\äP0\áôL†±¼_&ohX\ÌÁ\\\É\ã\Å}€òxø£\0H\É\ç2\Þfg/ßƒS¹\nfÿÄªŒS¸b1XDRc‰VDú]/ôF\'r\ìô-&`¶:LFe D\"B·\Ã¾,-lºe–/Ó¿l\Ó\î´U@Ðµ9Î¾[m\È)`CuÓ¹¹#ñûœÿWD‹œ¢Ç½“*\îžTD\Ú%ø˜\Z¾wZÁ]Ž\Þ=¯Ip2\à}I`ƒ!\Ð\Ä\ãG-”*y8üœ\ÂR\Ä;OFŒFøñ\Þ\Ç?üø#|þ³O%\nH+ûˆ¸\Ö\Ä8t\Ó\ã>\0\Æü7qk\â-\\»ü¦´†-/L\á\æµ+\Øøð§\æ\0\0 \0IDATg2HT5ð\í—þúX¹y	.ý\ÒrI7üŽ½/\ZA\Ù6•æ¤Ž¨ii\ä?G`û\×\Ø\'\ãj\çgök$w\Ì!0I\ÄÁ\r^Q\Úhúø_5¢qlµù\Ö/²,7!E½¡\Ä¤L‘5¶\n4÷Œ h–UH. \Çrkr–…\Õ\\¨‡l¨ô#\Ã	#yEÄ•K°Cq,o\Ùpý–.§[jþ92†ÿ±ƒ‰›f“R.7\ÉeLX{4–‚Rn¢_o6óØ³\Ïa\Ù<\Éu\é2”q\Ú\'!\ä4\Õúƒ<:+\Â9\Ëe<xPƒ/D™À½³šj‰Š8=©Šð\Ó\é\æq|R\ÃpTÁ£m™ž/\æˆ¤\Ñ\îVqr:@­\ÙÁw?},!?ù\Ç\ï\àƒ÷F2*>\â^‡\Ç4§a\×\ß\Â\ê\Üh·§ð\ÒË—0wû2´\ëÀþÃŸ^\Â\ä\Õ+ª|!¿þ?n\í–n¼\Ï\Ñ62Q§\0@q\È\Ä-z\æ9ËŸ›ó\Ê=&l\Â!‡°xþÇŒPØ…@ˆ\É§\ÌÛ±;Y\äD0\ä‚Â¹@A\'üA¼>;‚\n\Ù<‡B\Ù0:p\Â\àýj„@–‹:Ž:¦´\Ë\è \êT#~†ß¦F\ãj JºœA”`t’ô‰dyŠ¸`Š¸‹Cƒž€z‡T³\ä›)\ÝT&_A‰\Ä\Í4M~xü\nM\Ì*&\Ðl¥ŽÇ¡·*Hd˜¢Í Veü_Áñ±j\Î\èN*h6\Ù\âE.\à.³zu<zÐ€?G)ŸÁ	E vm†t\r£::½\"£\nN\Î\Z‚\Ç\Ûxò°‹l¾(ÿ-„ý¬b1È§Ÿ<\Ä÷	€Ï¿# \Ü\à6\Í\ÃmœÁòü\rÜ¹õ66—n\àò›¯akù*fo_Áo½‰\×_³œð\åqM ×¥¿þ#h–™z\ã²Q\'òI7\ÂN\rº\ì¡/F\ÅÜ·\Çóó„½\Ó\ï\ÓDW“\â«)ð˜\å\nQhŒü\'”b\ã\ÈfÃ’\çe.G!\Æ/§–¾™d‰¯¡\ÊG\ÉTÒ·\ã‰\àj>`<#Xþq\ÄEZP\êX\r\Ä\Z2|”¦S\Ã\âS“Ddö\é X”d‚™?f#\Ð\Ù0sG­ÎŒ\\’\ÅÄ’>hYÁ\äÿ\â5\Ì=h.\è\Ín\ì\êl¸uÇ€@\Ð+<\Ì\Î Vù¿…,„\"ð8\á+Ž2g×’¨7R¢\è\Õj)4\åÿ©£\å©ø\Ù~Ä“Q”HvÇ³‰\ëõ\"¼\0²y*†y©WÅªœµŒd\áU\Ò\Ø\Ø÷\Â\áM\à\ÑÃ»øþ÷\ß\Ã÷¾ÿ>>ÿ\é\'xú\Þ\ÉÀ®\0Àe\äh¸\ÛX»s7\Þf·÷5Ü¸ú¦&^\Ã\â\ì[X_¼†ƒ\ÍI\\½r/üñ\ïþ~ý×¾¦Šú“\ß\Ç\Æô«X¾q	\Ã.ò17\Ê\".-úõ$Z¥˜\n\0N\Øb\Çm5%«]M‰¯¦ÿ\ç fŠ9\Ù|š#\Ö\ã©\âÎ…Ï¦¹W\'h‡\ä‡\ÈAL<\çò“\ÆEô¹˜\î\ÉA\ÂA$o–\ÅVBq\\*seF UÀ¤l†ü_£1\ëg \ãù\Ñq‘xo^\Ó`{\Ï¯?€@0·›]MQi\ä`\êödXA«UÀ¦†\ÓBø?‘òHgRr\Ú\ë­4GQ\Ü^´ÁhóÀ\î\n\Ãhña8ÌŠòGeÏ§\ïç€‡6\'©±g°\ÆÿG\Ö{6\Çu¦Y‚Œ˜ˆ‰ý°±;=½³;½\Ý\Û=S]U2¥®®*©\ä=E\ÊÐ‚„÷\0‚pIx€ð†0™\ÈLd&2‘\é=\Ò!HxG/J¢DI”)u\Íì—‰\Øp6\Îs\êŽ\Ø7.\0¡Šº\ï}\ß\ç9\Ï1F“—Z‡Q\Ó\Ð#\Ðvl\Ù.W|Ù‰E‹#Œ\æEŒ?± >Áþ :\Ã\Ö\Ò\Äbhõ\\`A\ìî­ˆa¤x¤\Ä€€þ€ƒ\íU\èh)Ã™\ÓgPSv5\åP[Y€\ê\Ê|\ÔT¢\îR	\ê\ë*p¬\ì\åg‘÷\Ç_\âþú/ðö‹ÿˆº‹o\âJ\Ñ	Lõµ\Éð940\È°a™ñ,^b>bòð-ˆúh¥f\Ëù\ï\ZeAp¶n³\ë\Ñ90³VxðV\á\ÅSZ­°o\Ø&²@”\ÞÙ·?Í¤eQ\Î_p…¥£ø\n\É| \'@‘¹KT!9õ¹¶s^,eõ®²€¸¨\Ø\êI\í@41`A<\î†Jc@\Ëuš`™\ÄÞ•‹ \Ù9\ìø\0YÉ¯­\Ñ\Ð<\n·‹F\r\n\ÈC‚\ÆV6‚¡	š:f°µÁ¢Î‹XØ…­,‹</\\»\Ô;›Q,Ç¼X°\Ød\ëg\Õ\ÏÌ¥ü\êAôôO\à`;(\ì_\ÛA\Ü>X\Æ\Ã{ICnŒj\Åðp/Š­\Í8ü/\î\î§qÿn+«)¬®gðô\Û;ø\ê«\Ûq\à0Lsh\ÆD\ßeŒôÔ¢\à\Â\\©-Fó\åb´Ô— µ¡\×\É\nº\Êq-Žýá¿¢\ì\å_¢\ìõgPø\Ö/Q~ò7¨=û\n†\Új`›Ÿ„Ûª’# I\ÂcÀ‚D\Ð*‹! [˜\â˜\Û¼[U¯Y ]ŸÇŒ›#$s°ª\çÜ‹‚›N\æ\æ\Ü\æ9\âý¹\Ì)x0\0>À£NÀ\Ç9»¤P+ hþ„\"hŸB$\ÙvnrÈ‡Í·Ÿ=4Ÿ‹ ¸ˆDÂ\áQX²Y\ç%ôIØ½´c	³M´È¹½•\r`aq\r-cbôœŠ»\å|Ï®†°š£{@‹\ÎÆ§¸-a=\í—\Ü>ø\ÎþYND\à	PøiÀÖ¦\é´\éŒ¾\0S\ÈH§\Éö\ä:?\"\Ì 	4\à\ÆØ¤Z\"øöwCX]\"òŠ\ì\Ý\Û+\Èd’XÍ¦ð\Í7ÿº\0XX´\Ý0L·cf¸}5\é®EY\ÑEÜ¸R„è•–°=­\è¿QþŽK8Vú\Ò/Pþ\Ç_¢\â\Õ_£\ê­gPù\Î3¨<ñZŠO@7\ÞmNv€>ž¸Œ2ô\Ú–,aöŠö_y\ÃyNs{ž¤+Ù¼z\Ø)õ\â\ï‘9ÌŽÁF…Ìœ¼\åœÿDB\âôr‡P$\å”~Q~\Æÿ@¢IôðûF-\ä‚h½¼Á‚ÿó—M\å]€\çlÈ†µ¬½#\ZŒßš\é¶8˜³\ê&„_B$\ÂNÁ…­ zT¨k¿ÿlÊ¯\ì\n™ \Ö\Ö¸\ÖCÎ€\æ\ÅE\ÌhÍ˜˜5cršþÁvø\Ã^ŒL\Ì\Ã\ãµÁ`&€£\Åz\Ö#Q;L\\I¯(‘;\Ô®¦\\#sh\ëœF{[T›@Í½*qKg\"ˆDƒ¸»ŸÄ\Û+X]]Á\ÆVFAsE\àý»i‚e5b´·\Z\ã=5¨*/DCU†n0GÀP©¨„\Ùt]Â±Ê—\ÊW\ê7ŸC\Í\ÛÏ¡\ægPûþs¨û\èw\è®9ƒU/Œ³H…,X‰\Ø \æNfÄ¥\Ô9/†¼H’\Ô\çªz¶|„QU\ê[\Ò-°\Ú\ç¥\×Sm«Tÿr7²‚Wð~2¨ž×cnns¤˜QœB}BóÊ¥\×Sq4…9\r Ç¥S  \"ò\Ífv(3b3\Ãö5_0h\Â0­\ß\Æ&etL¼‚./1ƒ€}“žP!¾\ìB `“ƒrð\Û3EQf&8\Ñ=¢ES\Ç4F§tX\\´B£5brzm¸|uj-Á¨%q£{Jfú§cSZ¨5i›¥F 6À¸Ý­ &T4w©‘]÷\"÷\Â\æ\\\ÂþN+\ébñ(\Ü\É\à\Þý,\Ö72\n\è»ûxòõ]Á\î\ßV€~\êº\Â\ê«\ÅXo\r\êk\ÊQQœ‡\ë%h¬+¯ †\Úb4].Ec}9ŽU½új\ß|õ\ïþ\ê\Þ}u\ï=‹K\ïü\Z—?‡\æO~®ê jC:l\Ã\niQa‹\ä\ç%Ie\â÷¢T\Â0ó‡?v…\ßOÕ¯c·X…+o¦hôr[<\Í†B¡– (7\nˆ\Ä>\Ñú¯CC2s`\è©]¹‡I\n²\Î\Üü%=\Ü\Â&\ç€o§\â>\Ân‚u	qöðd\ä\Ð$2\à7\n]\ÛI E>3´z=z‡\ÕhnŸÀ•k\ã¸\Ñ7)ÿ–3úù°Nq¹\Ì8SÜ‡:€ŒLI±KÿÁ9\Ý<F&g09£†Ñ¬œ\àw2¥4Š.«ï—¤³E‡¡ñ±“\ãŽE¯\à\ëÝ“2?\á.D¨š[Kû\Ò2«A¬o,#!º\Æ\í\Ûk8<\Ì\â‹/\åh°\Î÷@?}C\Ýõ(,\ÈGUy>\Ê\nóññÇ§QQ–‡Š’ó¨,=Kyh®+\ÂÕ†«~\ãY\\~ï·²\0x5ÿ\r.¿ÿ4¼÷šOþ\×Î¼„\ÞKguj‘¡CVÈ‚t\Ä&÷]0\Â$\é\ÃGp„¡Œpþ[³<guJ \äQ®DÌ¦­I¨\\\Z”%P’\Ì!×‚€Bœø\É\È1	üû¯8¾uTó\æx?Ÿû´²Ø¥Å¢\ÏuVò¤„§3^Üš\Õ\â\ÖÔœü¼²B\àeI;¢\ÌJº‰812®CIõ\æM&ˆ\Ç3ƒ_Ê‡\äŠƒ·ô2¹\Ëd\\X%¢—\r@o±¢gxNðrˆ²\È\Ëf|R<\Î/˜qK=ò\Ë\Ã…-py¬Xr˜•\0®õªG¡\Ö±¿E&D:CW\Ð¡ ‚7¶7¢F£H¥xð`÷lã«¯\ï\Ê\Ñ`\å0{\r½u¨­.ÁPwBÏŸ9‡žke\èj-GGS1ºe D¥P5ŽÕ¼ù<\ê\Þ~õï¼€\Ú7ŸE\Ãû/ \é\Ä?\ãò{¿AË‰ß¢ý\ÌK\èºø*&¯—b%°€ÕˆU@&\Ê\Ä/%­²ä¼“T™d•?>5+–­G&\rD\Ê·^½l\×lX\ÌM\ï\È+$w€®_„„÷ñX)#œ´+,òüˆppÁ(´+¦{)aR\\Rüex\Ã\Ï|{9¡SkÕ¸\Ü2Œ\Ó»\Ð\Ø6‡K±wG\ì\"\Åb­ÀÅ 7\ÎK¬\Å$†¸e“À\éõ\Û\Ð{s\nÃ£SR8F(e¤.\ÕA\ËN\ä—\ßª™\Ùj†\Å\Êi KB5MJ\Ñ¸\Ñ;%n\â\\xœ-0g‘\ÙÁ\r­c¸\Ö1Ž½õ¶7˜\Ô\ZÁ\í\Ã¢±VR4„\Ú\Ä\Ý;¤2\ì\ïm\â\ë\'‡2\æpx˜„E\×-q1\Ý7\êqµ©T8\0e¥‘!]-…\èj.Ek}L©\"SøXõ\ëÏ¡\æ\çPóú³¨y\í9Ô¾ñ<.ó(xû94ø-®ü{ôž\Å\ï@?Ð€Õ¨\rÙ¸\Ùø’Ä®¦si™\éez\ï[\Ì_Œô$ò§V\\@Y\Ú5r<ðk¾ùôõ\ãN x>\ÛH§A1{\à\Ù-E¥BW\ê…\äi¢6ß§Y%	 9@N¬\Ç\Åü\Ï\Ã$Ò¼ùp9\ícw\à\â@+hA,Á`K­XÁpðgoø ¹\0\ØÇ§’ex\Ä$”¸KT½y<VqûP`a»\ì6!\ËK°ØŒ8~þ\ZZo\Ê\ß\â²°h“\Â\Ò`\â(\Ü&\á”þ€]ù\ßEó6WXMyaµ\Ò\Í4€\Í,‡@Q\Ü9\Ì`9E0D,\Æ\Ý{«ˆ§V”ð\å¡ÿðwS°\èzd\Üh¹„Ž\Öj\\ª*”·¾¦º\çNŸCu\Å\ÔU\àüù‹¸TYŒŽ–*+{\å”¿ö\Ê^ú*þðT¾ôKT¿ü+Ô¾ò+\\~\ãY4¿ûtú#‹\Þ\ÆH\Åq\Øfº£û¦[‡0¥X¬\Â\Ýtü\ÒcÉ¦$m³ #I²h33t\Ò4AE	{\â,@t¤’s¶“•)²«Y¡•ógGÆ„sù™‚\Ó\Ìd\î%˜C% ™B*‰–H\Ü$º8/ƒlyð!ó³òV\ÛE\Ã‹;–\\?›À·Lü\æÀ\ï…\Â\ÊÏˆ\Ï3×‡žxÂ…81cd\é:]v\É\ÛÌ©_$´„%÷\"L‹FDY­¸‘Y²\×Þ«Buó8´#RIþ;\å\ï¦\Ó\ìl‡+8\Ü_\Æ\îv\\’AyQ‹/C¥³+8žŠ!žJ\âÎMA¿þ\æ~ø\ás\à0}\r-Wj\Ñ\ÕZ…Ê²4\Õ\á½\ã\çð\Ò+¢ªø<ª+Špò\ã<œ?Gd°\Ç\nÿK¿ô+þî¿¢\àù¿E\Ñ‡ò?üU/ýµ¯ü—^ý%š\ß{½\ç^Áp\Ñ[˜¨þKúq,À\áLŸž¿,\ÊHºÿ%ù‹ƒ\"š&ONŽ\nÃ‡U»N7	­v:-…´s†J=\n­f\ê\Ùa¨gG Vbfz3SC˜\ÄôÔ€\\3Ó¼(7\ç\0gPþ\í\Ì\Ì0fgG”¿¡¥ž\à–˜>Š]-¿¦)g4©â¢¢ŸP\î\Ø\à\å`¡k^”GÜ…8©dW SFeNŽX¬G\Üòõ\Ò\Î\ÊÏ–\æ¥ÈµZõb\ç`ÁJ‰:ù\0”¥Æ¦\Éc†\Ïg:XCû$J\ë‡0­ž‡\ÙnB$\ÊøW\Î|\Èd\Æ\ÆúÚ²„vò\ëÝœn7ô\æ%lm\Ä\á	„\àö‡qx¸Ž‡·ñÅ—·ñô\é#Ü»“Á¢®K@c}%Z\ZŠQWSŒ·\ß?ß¼x\ï¿ÿ!.•_@Y‹À|Aòóp\ìÔ¯þ3\Î?ÿ÷¸ð\Â/p\îÙ¿Eþoþ¥¿ÿ5ªþð¸ô\ê?¢\îµD\ã;¿F÷\é1\\ð\Æ\Ë\ÞÁ\âP=¶’K\È&l\ØXY’\í?\ä§{¸E˜1„e™\Ûwkzóz\"$„\ä¸þ\n»—™xz\Ùþyv“.\ÎK|öDv®\Í\Ý\é	D)ú,œvR¿f\à²\ÑC@S\âÍšGÿÿ>»\r)Yhò(\Ê\Íƒj&™\Ó=Ä”#h˜\å\Î6Ä£Ï²k,õ\Â@	þœ;GPðvyó%\Ò%@ÿ_?‡\Ê\ïqû\çNCˆ\âb\ÆÈ¸•}¸rµ}Ó¸\Ö=‰‰\éY\Éþ\r\Ú::„\r¬´ x¡š7	Wº@«\Ã\Þ%»»i®\ãó/o\ã\îU˜u0L]CS}%:ZK@[9Úš\Êq\î\ÌY´\Ô¢±¶\0-uÅ¸\ÑLN@9Ž½õ\×ÿNþ\Ã_\áô¯þy/üå¯¼€’\ßý\n5/=‹\Ú×žA\ÝÏ \á\íg\Ñyö%¿ƒ\é\ê múQ\ë-lR\ÖDe\Ú\ÈzŒX–‰¡Q\Îü ×¨\Ô\0š\Ñ²ºg‹G¶/¾Xp.@¯_©rŸð.4N^V\ZD¨\á°0ö%3²\è$N¿!©(Q`º8« ˆ¾Ey\È$¡$bo\ÏYBP\ÈÈ‘\äRn\çq|°\äFw\çUŠ½¸‰¤!Z\Â\Ñ\ã—ÁÒ¼G\ì\â$\Z\Ñ\í#\í“c\\¿l\Æ/\Ú†=­¯…±º\ZD’úÿ¯L™ªnX´\áTQ¯„j§\Ó\ÊñŽº…ºžÈ¬w;!\çù\ÖV\Ùl»{)˜l˜¬K¸s7ƒP˜V±I|öù¾ü\ê\0\ß~{?þ\éKÜ½™¡‘·\Úp¥Žô/\ÊÀ*ùko)E\Þùóh©+À\Æbt¶–£\ï:‰¢U8ö\âüwxù/ÿ\'|ðwÿ;\ÎþúÿF\Þóÿ\Åÿü¨ú\ãs¨{÷%T¾ñ<*_M\'~‡Á¢÷0Ssº\æ\á¿Œ\ì²«‘EÁ\"~\âAf\í\ÎËƒf \Zt\äò\Í/\0½Œ\è\ì%Á‹,\æ(:Í™M\ä\094”¶Kd›±\áÃ§T[/\Ï{òÿl\ä°.˜–]@À–\ìl+ü€ª#¾•ñ²8d7 \ÃN\ç¢)ò\Ø)°€£Ž_ZÆ˜S\ê\0~Ÿž;V\ìl\í\Ä º”cý¸L9%ûw5\í\ÂIŸ$u’$²š\"–/\Ú\ì¸\Ü:\0–\Å<RiBa)?6·\â\è\Ô\â\Ö\ìœ/vv\ãXßˆ\Ê˜_p\n+˜\Û|(…\Í\ÅÃ‡»øò\Ë<ùú~üñ1\î\ÞN\Ã4\Ç\à:š8ªP(aWI­@Á…<\ÔW^@{E¢Tq\Ô\àX\Þoÿ¯ÿõÿŒÿ\â\ßá½¿ùœý\Õß¢ð÷¿F\íûÄ•\ÞBý»/\âò{@\ÝÛ¿GÛ‡/c¸\ä}\èš\Îb¡ý,’ö1\ìð`*gX\Ù	B91†ß©Ã­)jg$;‡‚·	;S¹9ycÁ\ÇÂŽFJ¸`$ON©\îYå“ŒI3Š%+‰\'ªœ½‰”a%F–V1\n¨\ä¦÷°KaK’¨“B¤t[\áõ([y8‡	pú:¤ºm\ç!n\ÛV\Ù˜ñ\Ã\nŸ?\ç‚`‘G€´/\îÒ¤üHð{I\Ö3\Þ\Ã\Ç/©Û›Q\ÉöI&ù\ï]\×\áÊY\Ü\ãÈ—\Ã/f-/\É\âH¯…°˜”m\Þö`Z·ˆ‘[\ì\ïÅ±µ•„a\Ño0€\Ã\Ã,\Ç°¹\ãxð`[À\×\ß\Ü\Å?|!Ý‚IÓ…ù\É6Y\0\Ýmló*DBjXUyÊ‹Î£»¹ThbJx	\Ç\ê\ßzÕ¯?ƒ\Ó\Ïüx\å?ý{¼ÿýG¾ô\ê>|Í§\ÞC\Û\'\ï\â\Ú\'\ï¡\í\ä›hzóŸ\Ñü\Ú3\Í\róM\'˜iBŠR,g.Ö…\ç,\Û1‹\Zn\ë¦§¦¡ž·ö\È&–™];’>\æõ‹NB£—‹P\ïüK\ï?²\çn÷”ˆÏŠc)Y¼$$\âü\Ú?v	t\Ý­E,9)š Žœ<\æt<\ï	\ZE]rþº=x|69\É\ã\ãùË®€J?I¤4}¦E,\'+wë—€p÷¼^;T\Z=,¶E„\"^#<|ðx—$—\èbõ0&U\Z96B!\'b‰\0‚\Ñ \Ö6–q½_‹ž›j\ì\ï\Æaqº±µµŒµ\ì2,KAøC!\Ò&‹sŸ¾‡\'On\ãÛ§ðÃq{?³¦[ò\ëª\Ëpñ\ây”ŸGE\É9¹ò/\\À\Ç?B%;ò|\ÔW“#XŽcu¯?‹\Ëo<¦~‹\Ê7ÿ\'þ\Ë_\à\ã_ý\rj\ÞmgO ýÂ‡h?s]Ÿ¼ž\ßA\×;¿C÷ñg¡ªz\rÎ¡RÄœjÈ»wR1Ä‡?\r«I…%³JL—¦&\Ç`1‘14ƒ`þ\"-\'Þ¯™ƒZ5fsjºŠŽ@;7\Õ\ì Ô³C˜S\r+’s5\ï\Ì…^K/¡1ñgQ½¢$\Öh(?§GJpv\Ä\ÈF¢2Yd\èl\'\éú\Í`\n\Ò\Èm\\(\nA…„#lVl6‚Qüªù™;Í¢${3`\Ú\é2axdZ?\r\ìHw7\ÃG›yE,`F#.·M¢\ã\æ¤À\Ä>Z½c*tôO\Ê\"ôùHñòÀb·\ã–J\'´ðŠºa¸\\v¬®Yv\Ã\é^‚VoÇŒÆˆdÂ@0ˆ™y\'67R\Ø\ÛMcw7ƒÇ\â\ÎA&u\æF\ÛPS\É\\\à\\m,È·­±-\r¥8sú,\ê«\n\ÐX[(Í—\Ëp¬ñ\Ðð\æóhþ\àw¸vúE4žüg\\üý?\àü\ï~\Ë\'\ßÄ¼\Ñ{ñ#\Ü\Ìûƒg>Àð\Çocô\Ìë˜©xž\Þ\"l´\È.ÛeŽ\Þ23¢>“@\Ãzó\ÚY¡’±8$_€/·vAYZÕŠ•¼\Ø\Í*üB\'yø$\ã\Ï\éÄ‘”…d®“_`j\ØQPGÀÚƒdÍˆý\çø:H%Öž\È)\á\Ü\æ\Éa h\Ã3<\ÆxVb*DNŽ|\ã¹-_Ž‚Cõ.·q‰¬\È) ¿‘þ}*­ôþk«™n¬…ñ\àn³óB\Ù\ØôJ\ÑHŒ@­3`pBÁñ‘—¹\\.øü\äú°¾C\ï\Z—¯Ž¡\ë¦£’¶c\ÉÀ„\Ú\nƒÉ\ÄJºE?\Ü\ß\Æ\ÃO·ð\Ùgûøö\é\ç8\ØMÂ¬\ê€jô*ª*\Ê$$úJ]¡l÷]m\n*XXp—\n\Ð\ÛF]`µB\n½z\âE´½ÿ{\Ü8ñ\"n|ô\"\ÚOÿ­§þ€ò\×~…¢?>‹¦\ßA\áG)9‹±‹§1þ\É{¸uúh.}wW1Öj¤C‹X£“v€úA\ÜV\r\Â^#ôóZ\è´SŠ8ùñ¹VOñòU‹Œ[‚!\É²\ë\á\\\ÔH4SEX\0²0dQ(¢úË¶þ¯m8€\êh\ÈA\Ì\Ì°\Ê8™ý:‡ODý¢,ü\n7€“»ÒŒv\çCMù°šô\Éˆ;\0™0·/\é•B/!4p/’Tû¬xeVO	¡Lø&œ»™\r!öÀ0¿\Í<§€·\àr:…\åKñ\Ç-Õ¼D\Ä\Ú\ìD—=ºe€j~	\êy‹\ØÀM\Î.\Ê÷³k	h\ç‘^	#‘ZF0…Z\çB×	*£7\'œ’ò˜H\à\×wñýŸc7³ª3£\×$®¬¤\0mWJp\íJ)n´”¢ójò/\\D~\Þ4\Ô¢—\na.€\ë¾Î“¯¡û\ãW\Ð{\êUô~\\ý5o=‡ª×ŸCÇ¹÷1\\r“¥y¸uú¦O\0Ss!ü\åX·ªò/bý1«|§\âµ\Ë\"P­šjzRü…=K\Z\á¸þ\Í82wv‹¹¤2øa‡@2($‹I+\Ü\ê\ÙA\r~Ž8‚\Ü¼^²‹´ò\æ–=\ê\Ù%¨Š?hSXL!\î\0¤†‘†\åD’1ò9ž>\Ïw~„“).\n\êú\Èò(;A\Ú‹\Å\"–1\Ó\Z\è\Ì\Â\Õ‡8va{# Ž\Ý&³uÍ“˜š\ÖaZm÷o¿ßŠ\íõfTóh½>©Y\Â\È$VÂ˜P\Ñ\Ö=Õœ}cFøƒ\î\'±³\Ç\Þn\n‘X\áh·\æœ\èŸX@0–A÷\r_<\Ú> ‘À\ï~øL\ê´++)FyI>\ÊK/\àô™38ù\ÑY¼÷þ\Ç8sö,þø\ÊI¼ó\Î\Ç8{.\'>>cýy\'\Ðw\æ=tz=g\ßDÏ™\×\Ñs\æ\\ûøE´|ø4¼÷\ê\ßz=\çOb¼\èn:	]\ÉyØ¯–!\Öß‚U\Ç<’>3\Ö\È\"“\Çc\ÖNÈ£‡N§‘6}¾\ÕÆ¹<=zyð<(\ÑØ˜ôr»\"\ï\â\Ï\Øð(ø·&\"=§$-§`•/\Ò1}ˆÎ‘\nn¸—Ñ«‚\è\Ê;\éå¤°13X‰t±\ÃbµHpt\æ\çmó‚1.©\ìC‘%Ø­f\É\ì\á‚`/¿¾DJ¸‚Nx}\Ø\\6¨õ\Ð\Ùb.	[ˆ®\Ó%\ÃhïŸ–]‚;L,ú(\á\Ø\× 8€\å˜_üÿB¡\0\Ü>\æM.Øœln¥°¶—s>Š\×;c\0\0 \0IDAT!žŒÁh¡{Ð€½ƒ\rh\ÌQ<y| l ¯¿¹\ï~øR´fMº\Zp\á\"\"KQTP€sgÏ ¸\è\"*KóQ]Z„—_û\ç\Ï\å\á\ä\Çùøð“s8\Ö_ðzò>@Ï¹\ã\è;ÿ:O½‚®S¯¢\ëô«\èøøe\\ûø%4ÿ-®¼ñO\è9ù6fó`½^`w3Â£=ð.\Ì\ÂoQ#\Ì7QLÔ²}\"V\Í\ÎbvfRL%i¬pd\å.9&š.O@KsH‡†i1“\ä\ÏXõ\Ó<\ÊaV	\r]tˆ¬\n÷Ÿžú›•z­\âõC\ìÀ¢%…V+];\ÈCT\Ã)¡Š\Ù\Í\Ë\êôFD#¡÷’°w\É\âU\æv\Ì\é\È`—@~¿rq\â\Çú@\nQ@\Â0G;¼~­VXf˜­¸|SO3V’N…qJ\ë(mgl	 \ë\Î\ZüˆDH$»Œt:\Û\Òfµ\Ü]ˆ°`\'X„\Æ\èB\ã5+i\Ì\è¸w÷l\áÑ£|ó\íW8\Ø\Ë`q®\Ý7\ê\ä\á\×\×¢²4%\çPZx¥…¼_À›\ïœÂ™3§Q!;\ÄE»q\êm\\ûø-ôœÿ\0Ý§\ßE\×\é\×\Ñw\î-ôœyCvƒ®3¯¢\ã\Ì+h9ñ;4½óÏ˜(Ëƒ§\ç‚ƒ½Xš~ú&¬\ê1¸Ó°)&‚\Õ8\r›qc£c¸9xÚ¹1\Ì\Ï\ÑDjº¹Q1•¢Ý¬Z5\Õ\ì0\æÔ£¹¯¥\Ðð\ÊOÈ•s¥—+~²‡´lÿŸ’b\âþ\\DR\í/P úÙµTp“b@Eb*)\â\ã“3Rù¢•\Ê\ÞI\Zz\Î%Ä³€±I©„¬„J®,œEñú#L«›ŸC_ÿ04ZUŽÎˆ;¬KT^™\Ä\å¶qL©iVE\Å\rx±[X„\Ý\Î\Åe‚?@€\É\rŸ\ß\ã\"ùŠ.¡‚«\æõ™\ÐB=§‡Ö°§\Ç‡Ó‡¡[&˜~L¨m‚lî¤°wÅ“o¾Àþ\î\nÌªvt´]Fÿr‘†õ´•¢³µ\âV„Î«%(Ì¿ˆ\Úr\ê+p­¥\ZÇ®}ô&ºÎ¼ÿó\Õ}þ]ô{=g\ÞD\ïÙ·\Ñ{öMôž{yo\àú\ÙW\Ð}ú5ôzCypi\Ç\à]˜FA>3V‹\Â\ZŠ˜\Ïc“P­Ž\Ó:¡q‹Á¥‰\ÔQý\ã˜Wv+k=<b>ÁbQ9\ïy\Æó¼?š!Mœ\Ý#jE™¬F*“?\Åp‚¬^¾™tú «F\È!,\0ƒ69xþ\ÃVhˆÑ’\Üû\Ü1Àóž¿·`ZD,\ê‘\Ðl\ê\0Yr‹__\rcs=‚Ý­e\ìñ­]Q!\ÙeÜ»“„?\à\Ç\Õ\ÎY˜mVt\Þ\ÔA¿`\Ý\ßú\ZuþqØKP©u\ÈR\n¶\ZDv=ŒÕµ¦µTO ú\nUHv$W¢ð‡\â\Ã\ÈdW`uE`¶°¾½‰¹…\0¾yrOž\Ü\Ã7\ß<À?=Á\Þv¦\Ù\Üh­C{9oT\nñ£]BŠq½©]m%¨­.@UùE\Ð8’E`\ç¹÷\Ñq\æ]tž}§\ßEÏ¹÷\Ðušÿ]\Ùx\ï;÷.ºÎ¿®óo ¿\è´Ÿy\'~‡‘+\Åp\ÌOÁošAŒg-c\Þ\Ù~9õˆ\ÌX4j1;3!\î\ß\Ü\Â\é¶I\'ñf›Ç­[’?¦¥s ÷Ð‘\r\r‹>q%g±—úð¡-ž\íT\êJQ\è5	µ‹ +|Qú’\"$Es \ß\ÏùüQ# \ÕQ5\ì3^4~1&|“Ÿ¯øùšù7œH\'=Rp\ë_Mû…ò=5£ƒN· ñnœ\ë¯d|\ØÞ¦“—\rsz;\êZ¦õ;±»\É\é\å^N9ÿ³kh&L©4ò9•	\Ê,€˜8DM‹\nŸ\ä\âF÷\Êf0¥u !‘ŒÁ\á\r\"™Š\á\àp*c_=>À\çœp\Zø\Ãc\ì\í$`˜i\Çõ\æZwU\áf{¥\ÈÁ\é\ØÞ¤\Ø\Ät·–¢\éR1Šó\Å1´»­\Çúò•\Z \ëüqô\æŸD7\ëó \ë\Üqôœ?¾s \ç\Ìû\è\ÏÿCE\'1Xpceb¸\è}ô_|šž&D:DHÍ¶ª\â\Ûk\Ã2\Ý/õs˜º5&†lùhM->sÿ\Ä!Ô¨=\ÐlB±Ž\ÕÁ›s û\Ù%¥u<j\åk7\ÙÀ\nÁ\äh1°ý¡)‡P$‚\ä\Ä%²k\ä\ÔÄŒˆ\çŽ ñZ\rÁ«˜7°½#¶\ï,\"w‹›‡\Õ\æ\â›EÈ¹}Ê§Ø·¤p{l0š\Íô \Ö-À\ísBc \íŒ\Z¥u£¨k¹…¡Q½ €„|ye³\ÌVÌ¨tˆÅ½H¥ƒH¤\È2Ž!™^Fiƒ\n¥µ\ì\ZÂ˜™[\ÂÔœ/%b	A\0oN˜a°-\Ã\êNã›¯\î\àñ\Ê.ð\ãO_\Ë˜Ÿ¾\ë-µaHôµ2t´–ü\ìt\íJ¡E\Þhª@AA>º\Û*\Å3ø\Ø@\Éô\\ü}ù£¿ðnŸ\ÆÍ¢S\è-ø}O¢\ï\ÌqôŸ>Ž‘‚S˜(=‹™\êh¯\Ã\ØRˆ¹†3˜¨>ÿü\ân=\Â\îy,ûM.\éó™°`PcbrB aVü\\4` ›Á!€\äD¦ü,ß§Ù„ƒ³%P2D‘(½\Ø	\äF\ÊGŽŸ\Ê0±TQ\n+a\rœ\É3l‘³}ašr v\ìr\×\èx¤\ØÅˆae\Å/* V÷	ªzT\Ù\átÛ„C(<À8ûóVWC\ØÛ‹¢\é\Ú$º©A´\n!dÉ½„x\Â#ÿžqôŒy\éšÃ­\Ùy™-\Ðò…\Ð.§zô\nŒÇƒRü%RQlm§±¸†7O\ÝDQ\í\æ6X—¼˜\Ò81­q\"»žÁŒ\Î	•n	WfG_~±O?\Ý\Ç\çŸ\ÝÆŸ~ú‡{i¨o]Gû\ÕZvV¡­cß‹h¬½€Æš<4\Õä¡¥6­u\Å8\îZ/£½¥\ÇF+/\àf\á)Ÿ\ÅHUFª‹1T‘¡²\è\Ï?\ÞS\Ç\Ñ\ê=³\r,<…™\ê|,v5\ÂGë¸™vØ»+\à\î¯CÀ8	@\Ã$¬†)8ŒS˜™bBvŸX¾\ÏÍŽbN\Å8\Øqh©\ÃI ªa)(0\Íù\ÄN~Rü‡$H²€”€(\Îñ\Zs]ƒü®@¾„U˜Ÿg\Ê\á`5Â¿\Ô	j\ä{Võ„J\ÈI¥\Ñ@\ËY“{v±\æ]r˜02¦–XXA\í8\í,i$\ÉÑ²Eø{\ÕWú0­š…›õ\r;\îzVú‡g¡\ÓÑ¬\Ò ú?—‹B‹p;zU8_\Ú!\ÇG$\âE4\Ê#B†¾õ\Éu\\\ïžB&‚\Ã\í‚\Å\æ‚\É\ì€7\à\Ç\Íq‚G!d\Ö2˜3x±¿›Áöö*6ð\íwOp\ç`\Ócm\èº^‡ñ^ú•£»µ]\Í\ÅB\å1ÀI`wk9\Ê\Ë\Ê\Ð\È,a\Ú\Ä\r—ž\ÃXùyŒT\\\Ä\ä\å*L\ÖWc²¾\n—ª0\\Z„sŸ`\ä\Ü	\å\ÄT\åELW\çC{¥\æõ\ÞjGRÓƒð\Í:§n \å3 \ê\ÒÀ\ïTÃ¿¤\ï†3±¥[4ª”\Ì`\Ã,Œr%nO+Zúþ\Ì\ßÊ…POÉ–ó6{r!“\ÄòI\é&HDj™É¬–E BNJsr\È]Àmø\Ù=„,7-iHƒ	’3L˜Q“^nTŠ\ÅÁC¦s\Ëˆ¸„»\ïu\Ó3\È)Q°ü9\ß\äXÌƒl6ˆ¡ñ9\\¹6!2ñˆ¡\ÃZ\Ú³Ã‰ò\ávÛLz±sKe\ÏQs2BÃµ)\\i im-„Í­(67b\âýwµk7º§qûpq¬¬\Äˆ,#±Cx9Ž{÷²H¯­\Ã\î‰	ø\å—wñ\í·Ÿ\âÇŸ¾\Ã\í½$\Æ›\Ñ}½NŽ\0)ü\è\n\Ò@‰x\Ú.\âjC¡…õµU2\Z\î©Ç±¡’³\à\"*»ˆñK²\0n]®‡¾£\ÆöL`ª\ì<\æ›+`\ïi†­£š\êbL_üº’\á¼^‚\Äp#Rc\r\Ø\ÌccÙŠdpñ€Qú„hõN(\×mŸ—žžnbü\Ú\É\é Ó¼8È—¦“JC©\Éðá¸—E¥_\n¹T\Ñð(8\Ú\êe¸B²v‚T)\Þ|œùsòGö.\Û4>p¢3*&Z\ÄÓ¤\r5¼³($¹C²ú\"ùz¥ˆ3\íƒ\ì\Ý\Õ v6Âˆ}(©\ÆÌœIBÉ¤po/cJkB\Ù\åI\éö÷b\ØÙŽ‰\Ë;…Í¢1/üÁ%1H­±’	\É\ï¤\Óq˜¬>\é\Ñ\Ñ7‹xœG\Æ*‚\Ñ8–\ËXŽ§ðÕ—{H­®Á\îID©\î\ãû¿Á\á^\n£ý-\è»v	Cµ2ì©¯.À¥\Ê<\ÔV\ä\áR\åE\ÔWŠG@uu%.^(\Æ\Õ\Æ*\ã g \èK.b¨²uU˜ij†¹Ža,\\m­¯\r\Õ8BCðõvÀ\Þ\Ô\0CY!J\Ï\Âzù\"½•ÈŒ5\"m@:´€eŸQŸA\È\ã\ãcbAA\áøÛ´\âFž ?œ2Ú¿r1C@¿:ûYN\í\Øß³ÀcGÀŽ‚Ÿt2ñÁû-Ò¿QÂ‰øiev@ùlÇ­Ylk\î¡+pð\Ñ}uÅy.€(‡AY\0l\É`Í°‘\r\ãF§\n\ã“s’\n9„\0²µ\×\ïC\ç€\Zz3ûw·Ð¹·7bòð\"Q?w\ãXIG\Å\è1›\âö\í4ô7ú\Çq°·Šº–Y´Ü¸%\Õ0œ@2³‚p<%:€X*«+\'O\î\â\Ñ#Ž„\ï\âû¿\ÆÁ\Þ\n\Æú¯¢\ïz-\Æ{«\Ñ\Û}\é¿q\n/Fg‹b\Õ\ßÑ„ÊŠJôÞ¨Å±g\ÞCw\ÞIôœ\Å`yF«\Ê1\ÓÔ„Ù–V\èZ®\Â=:Œm\×}~¬\Î\ë\êïƒ¯\í*\Üu—\à¹T‰`÷%ø:°2r	k\Ö[H2¯×¥C\ÄÍ·]ƒ‰\Éq8hûN-a\Ûg;¨ÕŒ	5Œh M§…&P¥ ® K©ú©ò!Ù’|?\Ép“Œ©…\Ù2\'Ö­\Ô\È!9“¬ \Åú-÷ð9ý#\ëW„\"&Aõ\ÔóÈ”\Î-\0>hNó8ñ\ãÖ­š3b™Ea‚\Äj\Ù\røY\r`w7‚y£\rW;g°`µ %B\èAz-€•Œ×¹8¦4\Ð\èY\ç\Â\Ö\Æ2vwb˜·x0¥²@¥[\Ä\Êjûûilo\'ñ\èaNo\Ó\Ú%ddûO$\Â\Âþeõ¿½»	_8‰O?½xz\Ó:?ž|y_<¾‡oŸ~†ú»	Œôµb ý†:*pµþ\"Z.]@smšªÏ£±úZjù=&ˆÖ¢¼”J\á*k8þ:\Ú\Ï~€î‹§\Ð[xCeE*/\Æ@q¦\ëkÔ¨°\ã\âód÷}A¬k4wu!\ÚÚ†xk\Òc\íHL^\Æúôl.©šc-\à\ã°F‹\é™I\Ùê¹³º÷rðc\ÓÂ¼0=#\Ý\åŒW$^${2\ä‰\ç>#\ÕhAJm\å\È\Ì%´K¬\ß*G€&\ã\Ø\È\Î5Áj\ÓcÑª8\Ö\á¤\ÚX±}e:(=w¹BA›øù|v¨õf)\Ê\ØöÉƒO\Ð\Ü) 0/+ùñiº†Ó´Ù@\È	\ÝA@@×…õe\Éóõú)&\å¶ÎQn\ï<>‡\ÈÀ\ÙN²m\\Iú‘Lx1­³\Ã\åö ²ñ.–¢c@…h<$|ÀT2£…\Â‚C1\ì\ífY\æ\ÙCfu\Þpû›ðE2˜°\âþm\ì\ìn\à\àp\ß}ÿ\0S\Ý\Í\ì`\rP%9¬\ä\ì¯gõW\ë\ÐZ_„\Þ\ëu¨«­B]u1Ž½û÷‹\êw^EË©“h\Ï;-‹ 7ÿz/ž…¦µ®‰	Dff‘\Õ/\à\Ó@_\Ç\Öp\ß\ê\Æ\Ú\à²ý\Ý\Ø7ŒcSßC\Âú	,™fá¢š‡<~\Ã†‡0\Ç|\n;™A$÷	¨T$ƒLbff*­\á\'¡\Ñ0¸i\Z-\í_H%§¿\0+{~f\ÕN‘\Z\Z\Íf¦\Ç1;\Ë3ý¼Zª\Ý<•\Zóz~=-–5VŽ˜\Í\Z\É²\ærûO\ÜÒˆ9\ÉBôÈ¹—9™\ÍÁ¼È–’Uü\â\Ï‘zŽñ®·$\â…\ê »\Ý,sŸŸ3”\n»\×\ç·	P±¸ô@ovˆÉ„ÁhÆœÖˆ³\ËqeNG\ÉD°’Ëµ¶\ZÅ’\Ïˆ62A\Ø]^l\ïfM&\àðFñù\ç·ñ\è\Ó\Ûxüø>¾ÿ\áklo†\Ñ\Ç ®zY\0}mE\èm+˜òp†0–÷›—\Ñu£U•e8ö\ÏÿÛ¿\Çþò?\à\ã_ÿ\n—¿‹¾’|t_8ƒ®‹g¡ni†\éú\r8»»\á\ïBfÆ€\'\É]ü{\ß\à§ô:û—ðYÔŽÝ…nÜ¶bÕ«E\È9Ÿ#^…\Õ;<4*3€E&~§r•¾b+Ë‹x=q~	‰ #…\"d\ìH„\Ü|Žï§¼ýDÿE‚¦$˜rDL9­hLð\Ë›¢\Úù7gLô6$b,Z,B\ßÊ¬\äú|¾ù9\í)\\¬xpW ÷8\0\ïœ\ío’õK·Že—øÿ†£.¬f£Ò¾m‹ #!¿Û›1\ìnÅ±¿›Â½\Û	z4[]0,8±\èð!»ž\ÂÝ»k¸sw÷f\Åö\íÞ,\î\ÞY\ÃgŸn!œLbg;‹Ã½md2kxüxÛ»\Û\Å2\Âü\âó;ø\æ›Gø\á\Ço°½A_÷\É\íª’‡~©ü\"\Z/\å‹?\à&%9¤½¹}\íõ\ëoAYiŽ]|þÿ\Äÿ—x\å¯þW¼ýŸÿ\Ê^}%…\è+½€ñúj\Ì]nÀ\Â\Õ68»{\ZÇ–fß®¬\ã<~‚ÿ÷\é<\Ý\áŽm\0wƒ*lD\ÌHMHMˆ‰-\ë¦¦¦¤}c$\á]\"|Rñ/)g¹8ˆ1ŒJü€h÷\Âs^Áõ\Å(‚v1ý®¤rq[?ª\ä€\ârTô÷WX¿|ðvx‰òñ\"(-_“.Á\ê½‡BÖ 3WòÁò¡ŒA	\é@ð\'‘R¼\0IùÎ®†‘¥\ëª\â\äE3§\Í(¶w\â\ØÚŽÿlò|´öv’\ØÛ‰\Ã\nC­µb`Ìˆ\Ë\í:…\î\ß_\Ã\Þ\Þ\nv÷\Èñ\Ï\ï\ïÁ½u|ñhþ‚ulld\á\r\Æðù‡\Èn\îÀH\á\ëo\î\à‹/\î\à›¯?ÃŸ~zŠ­\Íú¹\0:•\Ð\ÛVŠ\æúBT•]DyIž\àÿ\ì\Zj(\r¯DÏF”••\áX\ÍŠÿŠ~ûw8õË¿\Æû÷W(ú\Ão\ÑS–\ÑKe,<M]\r\Ü=½HL\Í`\Çb\ÆÃ€O62øó§wð\Í\ê\î9G°]D\Ô9°Kåœƒ8µ\Ó\ÓsfgVöv\Æ\È\ÎG€C RºY\ÍùúŠ1Tn\"\'C œ•\ì¦/~\Ò÷Š6\Ä\nF©üùsþ\ìˆú}ô\à¹x\çg’8\Í––ˆú¤—¯\ÜH&|¢\ë\'Y„Ÿ\ÙÂ± `m5¤\\™ œ\ï™U.„ 67–±Isg¾ñ{	\î+ü~J¶öwR²3,yü\Â\ãK®,#c}#†\Ý$2š^‚\Ñ\â\Ã\í\Ã5—H¯¦\à	\Äp\ç\î\Ò\Ù5\è¼ø\âñmd6ö\àð¥ðô\é]|ù\Õ]<ý\îü\é_¾\Ç\æF}]\r\è¬\Ã\Í\ëJ\ØZ—‡Öºh­\ÏGs]>®\Ô\àJ\r[ÁR´6Õ \éJ=Ž5¾ý4¼ñ\ê_Õ¯ü\Z/þù\Ïÿ=J_ú\rº\n\Ïa¼¶–\ÎV[.a©£	‰\É>¬iF±eÁ\á\Â \î.Ž\â `D‚óv&‹\Û\ç\Ä\Ê%B_ŸQv€\Æ\Ç\ÒüQ\ÒÆ”v, £@­\Å\n\ÃGñüùÿMs¦Q\á\Ü@‡˜[q_\îÿ\ÑÅ‡,[>¹þ¹€€>q\ïNx`_²ci\É*Y=œøÉ›\Ïœ •ò\Ãlq`-‹\"\ÒÀ\äMßˆ`s=Œõ,%\\!™\æ­e©\ëS\Þô\íhKñ\Æ¾\ÉÁ³;&p¯\Ý\Í2·ÏƒÕµ\Ò\Âý¿{?\Ñ+ñ);¬Ax\Â1L\ë}\âš\ÝØ€aÁ\Ï>\ß\Çrzvo_|q€»÷vp\ïþ\0Ad$³¸\Ù^‡¡Ž*\Üh\Ì\Ç\Õ\ËJ\'\ÐTs^ \àf‚p•T1\æÜ¨Ç±\'~\'ÿ€k\Ç\æwþ	W\ÞzW\Þz—^yN4‚-\'ß€¶\í2¦K?‚º\è8—\Î!\ÑUƒ­\évZÆ±0c“ªZ·8øðµb##¡\Ò\ÞL\Ë˜‘˜8?=l\á¨û·\ÓXRaQ `‘>ñLW§\Å\í“ú~Ú­ñ\â.\à[TÆ»r8¤K\ÒA\Ì\Ç\é½€\è¯KÅ®C¤VŒ^a\ÏkÚ´±·\ç\ÂXr\Ù\Ä—\Û<\åWô\ç\á\ÏÄ•+`“`\'\ÖüoðNªx\èH8J÷¯I\"DI\ìXB2N•ñ„.SÆ¾=cV´ö¨H\ÈÝ‚&³\Óó™…\ÉbB<ÀJ:$˜ýGn1!\ÜÈ…Á	3ab‰eL«\Í\Ø\Ú^\Í…Ã“À\íÛ›88\ÜÂƒ‡\\\0O±µ\Ä\Í\î\Ë\èi«ÁHW5º®	ü\Ë¸ö\ÆB\\o\äg\â\0…\Ð.þ\n†{[p¬\ë\ãW\ÑG*\Ø\é\×\Ðù\á\Ññ\áK¸vò¸ñ\áË¸~òeÔ¿ú+Tÿöo\Ññ\Þï¡ºø1—Jè¸‚ðô\0úi¸*¸³°\Îß‚™9\ÚIuS’\ÌD±¾Þ›b‡V=®\\¬ô\Õc\ÐÌŽB5;‚\é\éa\éts\Ì\æ}\Z\Õ4s\ãbCo$\Å[\ÇùÀ”òsM#Y4\Î	L,T´¬_P‰%ñ]H)£mŒ.Gõ\Ö\ÊEX\Ùd\ÖcJE\çj\0­R\áSHrµ|£“$s,À\í¥¿\0E%Vø}\Ô\í±À¤’xIYA¥ò\'f_V \âõõôñd÷2Žõ‚?\äÁ¤z)¶š©0’+¸}T‡±±•†jÁ‹	µ·\æ\ìpû}\Çc˜ž÷\àÎ,ö·\á\r‡ñ\é§;,¯#‘\ÙÁ·O?Å“¯\à»¾ÀOþ\Û\Ù†ú\Ze\Ä+ µH™4\âú\å\ê\à,\à*\Ã#«q³±²\Í8\Öù\Ék\è?ÿŽ@xõž}Kùú\ì;¸y\æ=ôžz\í\'^F\Û\Ûÿ„\Î7ÿ	7\ßùúO¾\n\çx/VÜ‹X¶\ëw™!w\ïÎµ\æ%¬«@Áj\Õ\\¶9q%]ŒS@Nið\ÈI [6­nJŠ\Â#	•»z#‚B=\nvdô«Í¦¸~ˆd+\êø\ÙUœR.!†\nò\ÇÙ¾\â\éC0¯£z€_8\ì†aG\0‹>\ßÏ´pÞ³kA\ÌÑ‹/\âAf•´-bq:vDd\Ë\Þ\Ø\\–{v\ÇATŠÄ\í8w\Ó8\Ü\ÍÀjóÀhq£gˆVò:v\á\0&g°»\Ç\Ñ.ÿN\nû‡i¬o¦px°\n•1€\ê66²+\Ø\ÞL\"Á\æ\ã³G\Ûò¦;<Q¤76á¬!½¾‹\'_\ß\Ç\ã/\à\éwñ\çÿþv\ÖC\îmBgk•4‡\ìj.\Ê\í\0|û•–¹A½\×U\Ðpo#Žõœ}\ç\ßÁÍ¼w1÷>†.žÀPþû\È;Žó\â\æ™\ãr‚\ÙÊ³0T_À|\á‡0\\º€U\ç<²~+\Öü‹HPvE«8¦s\Ð\ÞmÉˆ0ýv§§07;-\é¡‚Xˆ\ã½ÿyH¶Ÿz§jÿ\Êø\å1À7\×d\ÖHˆÒ¿%w\ØF\á\í+:}·\Â\Í#€\Î`\\r<(èŸœÿ¹w‘w%}†œ˜7X¤\âf\Î\à\0)\ÞrºÜœ()Þ±8\Ç\Æ!o¬e#X]ÿ,\ç\æ\\Ÿn»[	ld\ãX0\ÓS˜D\Ò\0¬Kl/ý\Èd£\Ò\ßsñ¬¤#H¥–±°Š\í¶vV¡2y\áp{e1<x°Ž\ÝUx<z´\Ûw6\àð%`÷§‘^\ÛA\"M‡ð\Ûxòõ§ø\áÇ¯ð\çÿþ\'l®0\ÒwW«qózZ/q\ä›\'÷«.\ç\Ë.@Šu?/€\Þ\ÇÑ—wƒN`\è\âIŒ~$_\æˆÞ³\Ç\Ñõ\á[\èý\ä]ž¡õ\\\Ý-\\\ÅRk!<=uX,b•†4Š°’Ñ£A\íœ}^\nAµzª\Ù)©	¸3\í£¤Ž+E Ÿ8\ØY0©a4ªk8	P¬\åŒT‰\Å;\0e¸ñx,\Â×Æ˜ª\å”€\ÆT\"\è”VQp\Í¸(‹AyË‰\î\ÍÍ›±B¢§˜CXJû\ÒeÒ‡\Í\é†y\Ñ*!+ýd\"(`\Í\ÖfL\Ø?››Q$\âd2Q$RaD\ãA¬­\Ç[‰¡¤Q‹þQ=\îÜ¥\Ê7ŠuŽ›QlnÅ°±µŒR+DöÖ°\Å\á\ÝmÜœòÀQ’@\ï?\Ø¸P$Ž\Ï\í\â\î=~o\â\à\î¤\×\É~ˆ\Ï?€\'_Žùo?b=\ã\Ç\è\Íql¯D[C>šjÏ£±\ê<®TžÃ•*\ÂÁyh¹”/ù\×\Ë\ÑNN\àPñž\ïC…§0\\x\ZƒÊ½ÿ\Ü	tô6zO¿‡¢\Ó\Ð]©‚¦\ì\"­Õˆµ#\ÐYƒŒa\äÙ‘\n\ÆBÏ¢–;%¸\0tº9L\ÏN#\ÈÀö4/t\ìZq÷\ïBÃ‹\ZD\ß4\â9(þtú²\Ði”#\Þ\Ù\Ãe†];j\ï\"\è…‰¼\ÙÅŸØŸ;\ZŽ,\ÝX\Ä1ŒdŠ²o:s{\á1„Ñ€4-\Ý\Ã\\D\Ìô‰\"²\ìG,„\ÙÁ\ÈW\Z@-K¡&h]&†­$B\Ñ0\â	\î\0Qa\îÆ“\ìÄ‘\Ìp|›@y“Z“WúûôjkkdV•\"µ\âG2A,A2E*Cfm#³K¼e“\ÅA(8‰À¶\äGv#ŽôZ©\Ì2Ò™$–“	¸ƒ1…÷vðé£»ø\ÓO\ßK\Üüø@®7\×`¸ƒù@¬Šp½±PA¼sD\ÌÈ˜®Vº„^\Â\Í\Î«)À`\é9–œ\ÙAüz¤\än\æF\Ï\'\'\Ðñ\ÑÛ¸Yð4W*¡./ÀL\Þ)h?‚­©þ¶2¤\Æo`¯\äðI\Ò\Ãt²\Ì\Ï\Ïatb\\8€Nñ\ä@H\'X?‹6Â²,\ÔL|ð6½<p£‘Q\Ô\×\é0¯\×À\æ0a\Ée†Õ¶ ¢KNñœL\Õö/Á\í!¾\î€\ÝÁ40“˜S“´\árš\ÅÞ±Ä£„ò1ú1½\ÛŸ\×\n³ÍŒ±\éyQ\é:=Œ{À\ãq\Â\åQ\äZó&;t3!þ7\È*\"´\ëE ¸„«³˜›\×#ñ\Â\ë\çLÀ—m.\0\0 \0IDAT‰PÄE\Ë®v\ÍbJe’®€Pº9\\Ü\\23øyA­Æ‘Y‹#“‰cÁ\â–:cs+\ì\Æ2|¡0\Üþ \î\ÜY;˜{÷wpÿÁvw‘^\ß\Â\Óo\á›o>\Ã÷?~)8\0³\Èhkª\Æ`G:›\r¼\ÑHO€Bt6£«…¾21\ìo¯\Ãƒ#§\È(&\Ðper¯(Fo\Þtž:\ÂO k­\ÄBK\æ«\Ê0_’sE!|\íð6œEl 	þ…X\ç\'aš‡^=zT¹T\ÃB{wT³cPÍŒHu?§\Z•H\Ù\é\é1\Ì\Ì\ÐGhjv;	Žše& ›Æ¼‘\ÕýŒ\Ô	ô\Õc¦€\Íf”\Ën\'m›\Ý$V-‹fVù\Ì6Àf5\ÂJ¶ƒ¤+¼^úPñKo ¦8ñ‹Q¤\áIVt\Ùý3-Œ	^„ƒ‰\é\Ç\âdû‘J…\äa­f¹+DP}\ÓsNll&Ä¼ag‡#\Û,nŽ-¢\â\Êf\ç—`súd`µ¿¹•Avc\ë\Û)¬o¯`ÿpSF¼{´¦\0|‘$²i<|¸ƒ•µ4™|ñù>}¸ƒ‡H;\Äþ\á>6¶öñô\ÛOñÕ“Gxúýcü\é\ÏO‘I,ab¸­Wª0\ØQ!C úV—GM\ÙY\\*?‡+œ6”\àZ3½\êp£õ2Ž©›\ê jª\Çl\ÓeL\ÔVb¨²\å,)\Â@\Ñ98†:\íƒ\íz3,W.ÁP^ky¢}W°<Pƒµ©v\ì\Ò.\ÎO#i“ðøH\ë\æ,Ÿg=ùóS3\ÂØ¡œ›ýý‘¾t+I\á\ÑÀ\ì!²v\Ü9Ø§:‰\n’±\ÃL¿T\êq\æð¹\å’ù}šszjõ\Ýb\ß\"\æa%©ƒn¯U\é4™µ~Ä“~„¢Q—dNOª7)\ß\ÙLk\ìl.#–ð\Ãl\å\â`D\ëR\í‡Å§/šÃ¼\äFs­s\è\\À\â’‡‡i<z´ƒ\Ùµ\Þ\í‚\r.¯\éLXÀ\êZ\ë›LûH •Nbÿp·o¯K\Ñ7kbx\Ö•Þ‹±œþ0V7Vñð\á–x<x¸‡ö±·¿‡­†E=ÀWO>\Í-€ï‰;0=\Ò$a„¯]¾(u\0ù€—«òlª/Áµ†2\\k®BYiªËªplúò%Y\0ª–Ë˜¬«ÁHUt7º0XQŠ\ÅÁ>|™]Ç¾s	\É\Éqø®_…»¡ÞšJ¤Û°6ÙŒ\ã 6BfD=Š™³\Â\ä¥<L¿\Û\0õœ\nƒ\ÃS\"\åDŽ\ÚÀŸ“À8÷w1vóò°…\æ}”\Z\êå¶¯qEV»Q@zõµtG|~.²p(Ðˆ\ä\\KyúùZÅ¼Y*ú8“:=py}BüH7—ñÃ™\0ûö\ÔJF+\í\ÝüˆFI\ß\nce…¨`k1\Ø\\~´viD\Ý\ÃI\Þ\ä’T¯x:³‹¿·,c`\æþ±¸\äy¿’Y\Æ\Î[¿lmg¥\0¼};‹G·1<\ë\ê÷½{ñnJ-±±¹&>\0$~\Ü¸‹G\î\à\àö6wñýw¤øö\éø\á\ÏOÅ±U=ÒŒ–†\nô\\§`\Z«\ÏJH.@Sõ9\\m¸€\æú\"”ç£®²\07‰N\×Wa®ù²PÁ†«\Ë1y¹3\Í-P_kÁnx_m\à»\Í=|I\à@«\Çz/¶\Çqß¡Á–ú\Zv–¦U0\r>Í¢©4-\è04:%‹Ána\ÇXÚ¹’ ©ýY\à)À•}Š¯B÷&c6+,_§\Û$;A,® yLøN,“ÓŸkñVÈ¸Q\Ì—\é\ÓOƒ¿^¯Mfûñ„_Æ²|8\\,XÈ¦©\Ü\rŠpƒƒ\åRÆ³ZÓ¢Ø·D(Y…k9\îG8„7A\Ñ%5\æŒ\Ü9L\à³\Ï\ÖaX`¶Ÿ½‹B\áŽ-G…CH’ú\ÃZ6‰\í\Ý4vö2\Ø\ÞYUÏ§¶\á‹.£\æšÛ»\ë¸÷`w\ïn\ÂI\"½šÆ{›\Ø\Ýc»¸†Ý½,2\ÙuD\ãÜ¿·‡ýƒ-<üô¶,€d\Ä\ÕHš¨ú-û9-Œ»\0y\×‹Q_•¢\Â|±Ž\ï¾V‰ö\ÖJ›¨.\ÄhU‘Œ{K1TU¡š*ø4\Zl:}Ø¶yð\Ð\Ã\ã@!|ôá›¤B&ì™‡°4!B_š),\Ò\ßG£xþ,)\Ã›Õ€¡Qš6+Û¼È´\æ2	\\qû¢0Ÿo.Òº)!ùƒr,’><\ÞEQôŠkGN·Œs9k\ç›O,Ÿd\rQñ,»dG`\'ÀHªxƒ!T÷¡ˆ\Â\Âõ\ÂB¿N\ÄH\Ú\àp\',\0ƒ„\âA¨õŒˆa}”‹:¾\åx©\Õ\ÆTV\\\ëšEŠca©Hg¸“ý£:ôk\Ñ\Ú9‹®!=TúE!z,/‡\å\ï,Ç‚\ÒE\Ädù.K\ËY\ß6\ÎÁ9X\ì.¤2!m<~ˆ¤°±¥\ì\Ü2\ÙM$\Ò\ëxò„5À\çxú\ÝWø\é¿ÿ€xhª\á´\\©‘#€£_Ž\Ûe ¢ø*K.¢ƒÉ¡‚\È\ê­Ç±Q¡€\ç£;ÿ,º.žG_qf[›`\íé‡·\É)\rvV\Üw,\áq,ˆ§\ë	<IyqoI…u›\Zq\Ú\Â\ÐóÇ¤ }’.\ÌZa-\Öy\èôZtõ‘2‹“Á²\Ê7-\ê$<ŠfIV›AÄœ¤o›\ÌóR\è¹8\Ü\Üöõ0™hg‚\Óe…\Ín–d\r§Ë‚E«Qœ9]n\Åmƒp.	Ž¥˜…üa€Þ¨…\ÑÌ”±E!m\Ø4{¶Ádµað-hùûf\É\\r\ÐW`Q>\ÛVŽ«\àr[en@E\Ç\Ëy\0	\Z\ÄR!,Zi-Cˆ\ÑX\0‰T\0\ÃZh\rz,¹ðüˆ\ÄXF±º–À\ÖV\Z[[tû\Î`c;ƒ\Ûw¶±¹½†½ƒ¼þl®<\Ø@0’\Ä\ÞÁ&>ýbŸ~¶‡oòwx\ï!vö\ï\à‡¾M\à÷\ß…ùóbÕ«mB[S\r:›K\ÐEUPs	\ê«òP\\p\nõU4ˆ*–Y€\â Vƒ\îz©\È\Çpy†\Ê\n\Ð_t#•Å˜©­\ÂBC#<}\r\raM«\Æ—BV|\ê™\Ç\î9d¬³X\ÔL`Q3	\Ã\Ü$\Ú	¨ôƒF\ÚÃ±š\'\ßo\Z\Ý}#\â4;;!ZAµš!M•œÅ¼n\Z\ro\nó:*…\È\0šÁH÷/Š<‰\r°òŸ‡Ã™«ô¹‹8\è\ç·(\ÃbòôÚ£ôš-\Ï}¶´k	ø,ð\ãw\ÙdQÑ“\ê–fË¢œñ|³“Épó\Ói\Þ\Ã\Òw«\ç‘L\×\ç8&g8§zÊ¬­\'‘LÇ°±™b\Çö\Î\n\î\ß[ƒ7GE‹\é5@w \ÑÓª¼Á\Ü\Æo\ßÞ’‹oóþ\án\ßÙ”‰ß½»bü\È€¡\Ð\Þ`‡;¸÷p÷ù½{ûø\â‹{\Ø9¸#\à»\ï\ã\Ë\'Ÿ\á\é\Ó/ñÓ¿ü€xÀŒ¹\Ñ&)ðô´7¡º\ì,ÊŠ\Î\Ê@:¸\è¤\r¤n ƒL\í\Í;¡\â˜¬*¦±\æ\ëÍ°^k‚»£\á\Þkˆô¶\">ØŠ\Õ[\íØ\Ä\Ý%\r6\\:\Ä\\œýóš%?H\É:\"r\äØ¹´hõ/\ný\ÊELŸ,_\Ï\"¾&¸œ\ì\Z$©Tû¿Urú‚‡B\0‘°Æ’©\Ã(6’<\Ö\Í%xd’þŸñ|R»9©[n_@ˆœ«	Ÿt|Sùö2yc}#o  I\\ì½©\ÕO­\ÐÛ]@TQ\0e\ÃÐ›9P¢\Úb±0²Iù\Úb±c|r«\Ù²\ë	lo§p\çv\Z\Î@\çjf°³›\Æ\ÖN\Z››d³\Ê¾¾ÁÅ“Á\Þ~{û\Ø\Ý[Ç»›X[\ÏbwwKÃ»\ÛØ¿Í‘ow\î\ì\ãþ\Ã}<xp ;À“¯b{ÿ.\î>À?>Á·\ß}…~ø\Zÿò\çE‘¥k\Æõ–*\Ô\×¡¶ü4ªK>AC\å4TœFC\åY\á^k  Ä™@%yõ½\ã¸ñþqôúÓ¬ü¯6#66‚\rõ’\Ã\íH^Gz°k3ýØ°\Î!\å¤øc7ÙµBü`\Ë\'™}¹\ÖOb\à\Å,B\É› £×¼Ÿóúñ8Í°Y	û’D6/‡{4\Ü	Q\Ô\Éx\Zžó\Ën)\ìbD\í¢N$–\ÝHÅ½X¡\Æ.\×\Ò\ä/¶{¬â¥‡—AŽ[\0¾\é<ƒ	Â¸|A8œL\ç¢÷>‹;’;\Â\ØX`=\Ã?Õ¸l+½XYQ\Þ\æhŒ\à\r[¸8Ö²	\ìï¥±¶¾,¸ÀöNR®ƒ\Û\ë˜\Ô806m†\ÛA:“Á\Ú\Æ\n²\ë+²\Õol­b“;\Â\Îvö}¿Ý—„J–6o}kCL |\Ñ\î\Þ;Àýûr\Ý{p€O?»•õ\ì\ì\à\Ñgwq÷\Þ!?~„ÿöÿü$@=Òˆž\ëÕ¨­\ÌG\'5—ó\Ñr‰ðošy¯½ ‹ MA¹b\ÝùþIt¾õú\Þý\0\Ã}‚Ù‚Xjk\àºR\ï\Õ\Z„û¯À7Ö”M‡´ÏŽe§Q÷\Â|\ÛmZ¡}‘\Î\Íd/>p~\ÍøW~Í·›`db\Z;9tUd\âN;	˜Löd6\ÏÞ£œP\è]6i\çø\Ð\ã§,€\åòu‚»Q7R1eŠGgoñü»‘f—\nò\Æú€g6\r©\Ã\çÍž\Ü\æòÁ\á¢ùS\0‘\å\0\"± RiÅ¡{=•\éž\Ó\ë\Ãr\Ô/N\\›Ò¿óH\"“M!½ª\ì©tL½m:v¥±·¿†xr\Zƒ7GM˜\\@$Axw+™„¯\ÄH¤\â\Ø\ØYC8‘ÄÁÝ²``\Ò&\ìa½\Å+¿O\ì »Î…¶‚½\ÃM„’k\Ø=\ÜÇ£G‡xHF\Ö7eˆxP\r7b ³5\å\Ñ\Í\â¯^!…ð\"\Ì#\à\çaP{’>ð\áiÿU]\çs\Ü\×u…#‰¦\ã‘cg&“L>$™Iœ\Ìd\Æv;E¢\ãx¢‰IV!%R\ì\"H‚D#\Ä°H$Á*’\0\0‚X`{\ï\Û‹-Àt€\r`ÿ‘“9÷-(\åÃ›].°ÐŒ\Þý½w\ï¹\çžóÁtoÝŽ;»v\ã\Þ\Þ}\Ð¨‡yÿ~8‚ÿ\Ú	Øº\Ï!¤g\0\è¶j0\î\Ô\"`ƒËª¬cT¥˜mDü}iAû8.\Î\çSlÁjÔˆw0\í_}ŒeÁs(\'Yµ\Üx*Ž*O\Â`\í\ÉûÌˆq”:hC„=wn|­î»‹\Ë\ï¢y^ŸMŽs>\Ñ|².‹«\0·\Ç.†L0\Í\Ì\"\ã\îöXöø(\0é–„Ž™?§w5cz\è\ì-X¶»\å:\áö2h¼ò=·\ß\r§—#`\ä\rúŒ„pWKÂˆÉ´_\Ñ\ã³Kñwx\n\Åad²	¤\Ò<\Ò(U²\Ð\èøºO+ý“3„®»n,,ManO{‹Q‹NLcñÁ¢´×ž>”+€Ã¡^û\î\\m\Ã\×špø\àn)ý:\Úv\âD\ËöWpºm¯$†\çN6 ót‹\n€\ë›?C÷§;0¸·\Ú\Æ&˜[Z\áh=\nû)„/œF û<L]\à\×\"\â\Ö+­ÁxP\Ö\í®Ø®I´š…žú…’=¦€Iw.u\á\Þ=VC½‹±¶0<Lûö~ŒŒ\àþ¿_*UE\Ð\ìqX\ÊHŽ\ï\ïÂ ¿-IúucGóòwŒ:h`¨U¬¸˜,2\Ãgòg¶0÷\ÐÁ\å6£wp÷GI1Àa7ŠÙ“\ÛE\ãf\Ê\ÇÚ¤+8ª3Áh¡jDn™\èM²žO…‘JE\ÇOI˜”»¼T\Îbiq\Z=\Ã´_1\á\êmüÁ€{H×¯<!‰»¤r•+,¯\Ì`b’\Ý@+z\Íð£08\ÆqG\ã\Â\Â\â4\æKXXª`v®„ÇJæ°¸¼€Õµ	€g\Ï\ã\åË§ðÙ‡\Ðw\å®_l\Æ\áƒ;q´\é3œj\ã\\\àvÁ\Ø\n&-œ\'ÀºB˜À­­;1t°	\æ§\á8y\ZîŽ³]¸Š\Äõk]>oÿ5hoœ‡O7(–qVJ¬S\ã÷64\Ä\æ)?J÷Nt{? ¶²\Ú\Ú\âßµ\ë”o!û—!Š­\ÃÁ6\Øý\ã\ZU:B\\F5ÿ\ÙÈ¡Üºj\Þ\Ð\Û÷[A’?‰\éS\âU1sH\Ë\â0\à½M2§ifõQz\0ª®\\,\îÁ\ÄDcz»<Á\Ñ(k\í@½<úù3Žk‘\ß\çòø\áñ»cŸ\"ŠT:Œ\É|\Ó\Ó”JY™Ì¥VÏ˜%ˆ•rV¦\Ðu\×)9†/„\Û\ï“\\azšuü$*•*5.³ü\Å\Å2B±Žœ\Æô¡\á	L\är°8ü¨\Îä°°X\ÆòJUŽû\'—Nä°¸²€µµ2Àõ\ì\Å¸\Í\è¹ÜŠhl`Í¿­7£¹~\Ú~‚ãŸÉ€È©¶=R	\\þ²\×:¢®g\Ç^ô\ïo€¹\ã+D»\ï 7¤ÁDo¢W\Ï\ãþ—Ga\ì\Æ\ÝKg\à\ëG˜:»\Î1D<D\Ùô’ñk\ä$\å\ÎV‹ÿ&W®™”E³\Z•\å¬×¡ƒ‡\æKt\'¥››j\çS«˜¿bKK\Î!]Ê»Q¢•»A›\Üù\ã+¢¼û\Ã\á\"™\Ã!S7l\Ö\ê¥\å:\Ë9&q’\Ô%üH\Æ\è\ÆM\'…˜8±\ãFË£Ÿ¤\r\å\Ô\ÍÏ¹$Hø‘ŸŒ\Â\áò\n\'or2\"O|2Å’Ž\î\n…¤¬\é<\â\èp`p\Ä›/ŒŽ\ËZ¤S4uH Z%\ä»~0\ÓÏ£:SD¹š—f\Ð\Òr\ÙB\×z°ºbRVg‹pù#r\Ï/?˜Á\Ê\Ã9–W\æN\æ±ü`	‹K³˜_¨\nÀ¹\0—ñz/A\×ùFœ<²G\ÜBO¶P`¾8ü)Ž4|¢ˆ¡MjB¨ƒ\×Á‰¨\ë\Þú!ú¶o\Æ\à¾]°uE\â\ë‹]ù>ÿ\ÛöÁ4Ô¾\Î¸ƒ1+·±\é\Ã\rSV±\ÜT§VÙ»R…\ÓC\ëƒl°\Ë:† G[·‡`2(p–€n\æ¶QY\ë\ï9ã²©À°ó\ïÕ’@NÕ°)	 I%€´Y	Ðž\Õ*ªt` Ø£†[—ø´§“~$\ã^\Ä\×qü¸\É(?u\È\áS¤L¢ˆ\0\áü\'ü\ÈMFawº\áp;^\0þ\\Ž‰^Å¢ZdõÐ¼aff±T¾@CcDc!\Ì\ÍLˆ«+6~T\Å\"\á]eÿ\ÆoDÄ©KFô\r{pñ†z‹&›Kª‡\ÉBù©&rI¤&°¸\ÆQ˜. \\e ‚\'ke.Àe\êÇ­K-¸þ\åa´±\rŸŠSm\Ûÿ@©ø\ãûk9@dj\ÙCónØŽ7Àx¬	\ç¶oÁ\ÑO\ÞÁ¾\ßÿ.9 \î¡=—:\à\Ð\rŠU,A™\ä1\0˜Í¯oþz\É\Æ\'—§‚Ð·cù8‰;½V)[ò\ä\ÓÏ‡ö®\ÚZ\æ\Ï>½bü2I\\ÿo\Ü\\ß©*	”D0hC8d{¥\è¡\\7xOSÙ“\î$lpcÙ…\ãØ•GÞ§IFõ\è$ßŸÂ²/øj\Òe‹\×\êpÉ´/¿O\ØIgÆ…\Ó\ÇW\âû¬¸™òy*Œ$YB\ã>D£\Ä\ã\äøGg\'p\"*tp\Â\Â\Ä˜¤5\Ã\ê$$Žp4»/—7„üs†<ª³,+˜™Ÿ\Åxz\nkÏž¨ûÿ\Å*^¼|&¬`§\á6º/6\ãÚ—\r’\èøüS5\Ð\Â P”°o€¤\Ðf\\;×†º‘\Æzô\ìÙŒ†\ßþþò\'ŠmÜˆƒ\ïmB\ãûo¡³­†û=\è\î<	§~H\äVY\ÞÑŒ™\â‹~\n0ò\n\àQ\Í\î\\MlI(V5a&ªq\Ê(¶nŸº»©\×+w8M§kª\Ü$]xø7\\ü™>:qxI\Ë\æt®E¬\Öy\×\ÓÇ‡÷¿0tkŽ\ì*—\r\ê\nn ˆ9¿O¯\Ëe„\ËEÚ·	}ý#\Ðùª¹>B¾6ò\ìØ¬œó3‰þÏ˜ž<C£Ø½:œTg\ÃIU‚\ç‡\Éò#‘ŠJY\Èò0™V›+$‹\Ça°y¡1ù¡1û\áôE0=•0(_\Ì`v¶€xz·‡=0\Ú\"ˆ¦ˆe\'Ifñ\è\áœû+æ±´<ƒbµŠpª€\ç\ÏË“Oe\ÎPÀ®\ë“\àÚ—…üq`\r\"¶\ãD\ëwO\0C\ëq¾–qM¸ú\ËÀ~sï¿ƒmÿôS¼ö½:¼ùƒhü\à\×hü\Ã[\è<r†\á[*\0,#r„3ûem\Ãz\íjL\ÛXS\Ø\Öhú1|›·1<L\r ~\\¼Ò…Þ¾[\âJx˜„p\ÒK€\ï‡\îõap¨\Ã\ë\Ò.\Ãwä»¬h>=Z[cºa!ƒp\nXk $;ýY%ð•Ã£¯\"v1’@”<¥Y©úEIfõƒ#£J\Þc…\×\Ë\é^\ês\Ü-f\ÐD\ÍV§Lüdø\Ë\'n/O&\á\Ü\n\Å	§X\ä%«/•ò’\ìÇŸŸŸ‚;…\ÉDq:‡t6‹—´\Çó¦1™OI¢\×3\âÆ€ÖƒË½\\¸¦ƒ\Ù=Žp\"‹¥¥\n–Vf%ªeLN\Ï ‘-Ë½¿´²ˆGOVð\ì\Å\Zž¿Xƒ\ÃÐ‹\î\Î&	\0Ò¿vnû‡ö~„\ÖŸ \í\ÐVk\ÜVK\0÷£óô!I¿¾pu][?Àõm¢\ã½Mø«ÿ16¾þÿ\ám4~ð6.k„q„¸]\Ì\Z8a\Ò\Ý\Å(7FC>\Ë6*~S£Ÿ\ì\æ\Ñ\Z^1t(ŽHa\Å\î^\ZA\Ö,Z\å\È\×\Â!€ø™…­`ù}m*±}Ÿ>zð˜ÄŸ<@¾\'\Ý*q\"H”\Ïm‚\×o•\Î\\¤–¤R$pp\Óƒ—J\\<\êÉ H±\ë\Ømc0ð(v\×`bjþñº pC›6\'\çþxÄ³A.O7‹<\ï\æBF`ý3DqjRþÍ€ ‹\Ç\î‹\Â\æ£W\ã‡o<‰®û~\èm\äò„Š‰\ä\Ñ3\èÄ½1<\á‚\Ññ\â™),/\Ï\ã\Ñ\ã<|¼Œ•G‹È—‘)\Î\â\Ñ\ê)—V\æ±úô‘€“p±WE\îs\Ü÷	ŽÜ†¶†O\Ð\\¿Y \à¶\Â´·\ì\Å\é/\êq\î\Ô!\Ôõ\ïú\Ý;7\ã\Ê\Öwñ\ïó\ç\ØðG¯\á\àÃ·q\åd3Œš\Û\è\ê<%:½Â²á¢Z@™)r\ê†w4™8¢\ÂÁ#x\ÝlÁE/3ú4\Ð\ê(\Ò\Ìc\Ý w»$\Îu\Ü_+\îZ\Üx%ñB_\ÙÇ§´ú;\Äùýµ‰NüpšWd^=f8œ„u\âÀÁŸ©2¬]\ï«\Å*O6K¾»£”~%SÇ¯6\ß\ç€\ÝIA&ƒ,C°9œ0\ÛU\ï C²\æÄ¸`ùùBú\Õ\æó4\à†3Á\ã¦OM1\Ôû\Å\åœ¡(LŽ(v5\à\Â-\'zF|\Ö1¯ DòG\Ól•sðGˆ¥\ÒOM\"Oav¾ŠrµŒ\ât3³%„\ã“r2”g¦Qœ. :[’«\à\Å7O\á\Ð÷ «³	—O7\à\Üqö>\Å’@D€œ\0‡¨\é N\Ñ:^B4\r{q§~;n\íÝ‚þ·øÁk¯aÿû›\Ðøñ&\\io\É×›\í\ë2	R\Õk¨–\ã\Ø^\Ùp5’\å–fŽ\Ú8n \ï\ßÛƒ\0¨vp|‹\Ù=+\0I)ýB²¦S\'\ß\á\ß\â{\Þ\çñ–¿%\îôó³I. ü½\0\ÅU6OaB¾aVTë¨•uLþd%}ˆ\'UB˜Jp_GJ¹š\ÒñT;—!ý;A»—°†,&2q±l\'¢\ÈN¦å˜—\ÍfF?•\Å\ÄdJ‚`2—AR’Á$&²Áô-Þ4ˆŸ\ÑBov‰\ï_\ï\"ˆ\ZrF ,¹e\áý¡ 2\Ù4\Þ(Â±(*\Õ)†,UŠRö%&J¨\Î(\àñ\êC<±Šo^>“\0°\ën\É	À\0ø\ê\Øn4 G\Ð6)ÿoÝ­’Àc‚\ã\ÒY^\ÇPg=Þ‚±\Ö8´»\ßú9\Þ|ý5\ì{mÙ„+-0ð¸x\n>‡a¿‚fy_\æôT&b\Ë.&Lœ\ËW,UO€»\Z\ÍZDi•\Êù|¿!)\ëX1(.§ƒß£\"Çº$\ß[eq^?c?ž*\Ýn¯M\àZ\×&l\\*v\ØÆ ú6	›½Z\0R¹¼¢Ç“H’‚MÞ¡Q&ƒ„Ž]°8\Ì0šyõ\ÐþÕ®\È#!\Æ\èMNøƒ>\Ø\ÝvX6ø‚>t¿%ˆ\Ø\áG,Áx4,Ad<ˆñƒ%`,Š!½\'.i\Ðvv¾MŸ|H¤\Æ%	,•˜™+¡\\.\"_$\Ê7‡T¶„\Ê ñð©_\Ë\ÒöM\çæ°¸²„µµ‡x²J hU6ÿÅ‹§°\éº%\08\Ì\0h=´\Íû\Ù\n&°µ\0 @\à\à8\ê¼gOÀ\ÖÑ†‘¶ý\Øÿ›_\â‡o¼Ž=ï½…\Æ-¿\Æ\åöf~\î¹t~§N˜6Ò–\å\ÈU\Ð,Vl²Y²x<3K\ç\Ói\r¿[\rVö\ÜÇ˜Ž\Ý=Nó²ô\Ó\ÃA©›^ZÂ´\\\Ñ\ë©ö©\æðH\èþ¿‰	z5šF¡\Ók 7ð•’0£\ÐFÅ¡SgP\ÚýF³ZþÌ¨…Ñ¢s&B¿ü]“™3€*€8“w\ç=‚,°;­°2\0L\ä\n\Ð+\È\"k<\â‡\Ñl‡\Ã\ãC*AŠ\Ø}&.\Ø=[»¼*åœœ\ÓeEÙž_œ\Õ gŽ\"Ž\Ë3˜*—`urdƒ£\ì8¦au‡¥#X©\â%*X©Qb÷oiV?\æª’ù³ óg\å\á\âU<x¸ŒµUž\0¤|þò)ž}ó\ÝM¹(\ÝÞº\rõ»>Â¾\0P{«\Âˆ²¸òU®wžD]\à\ÜixÏµ\Ãp²	»7ý7ª\08¼™\Ð\"’\í·	³¦÷›%i³¦5RŠ2\í¸$³‡†P’2{¡ö\Ï\0t†!\\\ë\îr¨°~„©\Ãq0®!‘vg\àþ}\Â\Â÷„D&ƒ€/lrü…à¡„\Z-:y\ÐÖ†4	ó0Sõƒ,`¯H³±d#1“™|2…ÁB\×öñ\ã\Èd\â2ª\ÅÓs|ü¬R\Î Q]»™J¥\é<òy‚99\Ì\ÎN¡\\†\Û7ŽŠ zœ\Þ\á†W\àðÄ ³ø¥C§2[„\ÑFz\"#=V6OP:|3³S²ñ¬øJ~\ß\â\Ê\"I\Îþ-‰\Ð\ÃGKxüdEŽütnd\0\0½IDATŸ<À\ê\êŠ|¶FŽ«xú\Í\Z,\Ú\è\êlD\ç\éz™h:°\r{v|ˆ\Öý›Ñ´\ïc´\ìßŒ¶b\ì\n\Ò9Œ´°#¨‹]¿o\çihOµ\à¿~öS¼ñú\Øû\î&ú\è?q\éD«(zu]>-=|\"q\Ò\Æ5\Ò*•œ|zõ(\Æ.“5©Á9©C\Ånñ~‹L\äŽ\âma™Áó)\åŽiQ4™Ž\Û\ÂóU.e¬@p\ç»KÉµ\ÚMüž\Ý?µ„¯/°‚x\ì\'	\0%ˆýGH\Ø	\É+\×d6†d*\n£\Õ.\âL™L\é´Bùø{¬D¸!†7\à—;›u{!Ÿoª”“¾}ÿ=.\Þ\Ô!\åi0!0;[\Â\Ò\ât¶Œ¶°pø\ç\æ+˜\È\ç`÷F µatE\Ñ?\âF®0!>>ý<ˆõ/-\Ïb\åÁ\"Bñ¼¼®¬,\Ê¿´8RµO0ƒ\ÊL¥JA®D*	\\ƒy\ìkÜ¼À\ä\î\0\ÎÛ…/oCýž-8\Ùú™\à<\Ø!<ý¤÷\ã«\ã\r\è\ìhF]\ê\Ö\rø¯\Ã\å†øñ›?À†76`\Ç\ï\ÞÂ6¡óD3Œ\Út_=#rm\Ü8\n/®sò\×Õµ¹‘°T×ƒš\Æü>`C2\æ\Ä\Ð}“ô\í¿\Õ\ë!²gE€f´Me–\ÏaN^3!:\Ù\ØQ*\Û\ëA@\Ì_!}*p\Ö¦JB:{°À\0aö¯J?–u\ÜX–„\Ü\è\ÉlT@³\ÉŸø2™0²Y\Îñ\ÅkB¡0.IZ49Žr™2.Iø*•‚9´/\Üþ(<ògIÚ˜\Úvu¾Šs]\Ü\Ñøq}À–s\ëý˜›\ÉK??>™€/\äC.\Ç2rRt€e^`‚\ì¡&sy˜aLMñ¿“C®0‰J™9Ah^ð&„<ž=g#ˆyÀ\ZÌš\ë¸y¡Q\ìb\ÏÝ…£ŸI\0N$P%\Ä\ÊT\ÐÕ¯\Úp“W@¼\çFÎ¶\ág÷×¨««\Ã\Æ\ï›\ßùW\ìû\Ã\Ûøò\è!q\ì\è½q^ˆ\Z\ëÓ¶\ëºú>¯±Ö£ÿvWM\á\ÚT P?\êª€\ã4`¬ý\rV$uDüVy%Ë‡\r\ë¥`_–vjsUÙ§6›‹ÿ~µñòôsrGfþ\äò§RAyº3„i3\ãB\îGas¸„Æ•\Ë%\ë\Ï\çc(Rµ ˆ¢XL!#Q\r ^\\\ÙlRX=ñtSR\îed¾?M PLÁd÷\à\ä¹A\\\ï\ÕÀ\éó\âz¿7\ï\èp½ß„»Z;\îhÌˆÄƒ˜œL\Ë)“R’Õ„jO—+¢øduOVW°ZKøx\"0 L\à)[ÁD_¬\Â8ò5nžÿ6\0ø\Ô\×\ï\Þò\n\n– I õ\ãò\Ù#*\0z\Âöÿþþ\ä‡QW÷=l\Øð>ü\í¯ðùûo\ãL\ÛA\Ñóé¹©\à»\ÃùúL’®¾>‚MWMR²¹Iô×½;LŠ˜	ªp‰O\âò‘\Ð\r;	\Ú\r\Úñ\ïò$!\ËÇ‰ñ]ºx;… ¦·ƒ€N^<MB$Z°RP°/\ïž\Z$†Ð‰#\ä÷\ÜÝ’Õ³\Ü#ù\Ól³A§\'µœ_E\0\á87\Ë@š=²²ðÐ›m0Y\Ùtr#\à\ç\ß »W\ri&\Ó1X]>ŒYýˆ\Ä\Ó\È‹OO¢T-\"	£ýü \èû\ÚŒYpøcˆ$\ÓÐ˜\ãHfó\Â˜[(cv¾„¹…Š<\ÕOV—P[D&W‘\0`ò\ÇõøñŠ\0?\ÉlOž¬¨\Ïj\'À7/Ÿ\ndª@g\Ç\ç8\Þø)š\ê?Æ®\Ï>{HF\Ðùö\\>\Ë>À\èºØŽºÿý\å?\âw¿üü\ÙOÞ”\àû6\à¿ù\ìy÷-œj\Ù/dÎž›„Ü©È˜\0»Œb‘†E-\ÝDœ“5q\ÕT\'*\ß(¡F\Ë\ÕþÁaõ£¢ªmc2\'Ó½ôöc\Ï_#*\ÝT\ë&GPG˜WW£Š\î\Ë{-=€ùrùª\à`}rr˜\ß\ç\0	\Õ=8j•dQW+\Íp88\Øi‘8a0Ù„\'tM\Z2}Iýb\ïŸ#`?\Õ:)ú”F±E©\ÄYý‚$oa‚\Ñ$®öy1f\áu‘\Ä\×\\\í³c\Ì\Â\æO\nK\ËU˜½1Œ\Ù\"¸§ \Äc<‘‡?’’Qo‚;33%\É¸>ZÀTe…’\"|0|ðpQÊ¾…\åE¤sU<{þHN\Îðxñr\rÏ¿Yƒñþ5t]hBgû^œ\æHX\ãVl\ßú\Z?ÿ\Íõ1”ª¡m{p–³§šT\0¼ó‹¿ƒ\à/~ò#	€7^ß€ÿ\Ùô\Ï\Øõ\î[ho\Þ/”\ê\Û7;¥\ÛÇ§\ÚAˆ— ¬þÖ¿r\ÕdFO&–œBô¸+£]×»ú\n¦’7y€,ñ˜DZÅ§gT|}\Ýl\0SðUTHßº\ÆõEœžV/ü\\r\0B\åJªDy0 ¥Å«\î~\æ\0–r©0òù8\\¾‚¡ ò\ä\ègS\È\ç8©CN_JV±F!»–\èxSSDý²¯\à^–y“yªv\Æq\ßDž_\Õ\ê´4p®öXpµ\Ç\0«\Ó/y+œF01ó]f\é\Ã\è	ÁJ`~¡$@Jþ\ØðYÀ³gQ(Ï£X^\Ä\ê\ÓXy¨\Ê?þlva\Ñdsó³(UJ¨\ÎV1;?ƒ\ç\Ä^>…\áþ5\Ü\à\Ð^SœlÝ}»>Á\ÑÆ­’¨	!R\Å86~@\äb©ú—øÝ¬Eš3\0\0\0\0IEND®B`‚','Local Drive','2023-12-16 07:22:25','2023-12-16 07:22:25','IGH141585754362','IGH141585754362','image/png',NULL,'WRS765168112483'),('KBD857193409331','Login credentials, or not communicating with the server.mov','1Q9kRBsEDSvzVDma75Z5fX9z_yfCtzcc5',_binary 'ÿ\Øÿ\Û\0C\0\n\n\n		\n\Z%\Z# , #&\')*)-0-(0%()(ÿ\Û\0C\n\n\n\n(\Z\Z((((((((((((((((((((((((((((((((((((((((((((((((((ÿÀ\0\0€\0€\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0	ÿ\Ä\0J\0\0\0\0\0\0!1A\"23QRaq#V‘’”¡\Ò5BSr$D±Á\Ñð%&UCETb•²\áÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0!1AQÿ\Ú\0\0\0?\0\ÞNh³\î\ëÍŸBw[D9K*,rr¯y1­?Ä\0’µZq0¥2²…¶¶R\r\r(|\Þb»þqñ¾T\Ó\åW\'C%®Èƒ\ÃU¿a\äFƒ\Âgq—f\ßN\êš\×:P„…\Í\r®‘SY§ô­ú;J›ÿ\0X+ˆµ.†Zc:\î>o1\Ù\Ó]\ÒWÜ\ÂtµN¼\Ëk™Y(u¢­J»6Ç–Þ‘\Ó[R—L\ï^*\ÆÀ7\ìí‚´Fo\Ñ}#™\Ä\'dva•´\ãk«Jª€¢Á¡¡d:q\í–p®mô\ÏÞX\0JÐ®þ\Ø#À\ÓŒ\×\Î<þ\ß\ëŠa\ì5-âŒ²\ÓiB\çW[@ û¼¦ñ/E\ä¾5D <\r1ø\Í|\áx\ZcñšùÇŸü¦ñ/E\ä¾5D/)¼K\Ñy/_\Ñ\èL~3_8—^üf½†<û\å7‰z/%ñ«ú!yM\â^‹\É|jþˆŠß“š:\ì\ÃIo…\ê­ZWV\êƒN\ãJ\Ñ=¢:«¼ ¡ûRf·\Ó!K?,h\ï)¼K\Ñy/_\Ñ\Êoô^K\ãWô@nöô=\Ô8Ëž{\Í\Í.j•4U\É\"\Ãÿ\0nu§L/£N3,–x]\ÉJ*kSS´öÆ‡ò›Ä½’ø\Õý3ú\Êc:\ÖYoD%\ã®%¤<¡U+’+fúÀ“¾›\å½q¼Ý’Fu\Ü?œP\æŽ=\ÆqS\ËU¥Å„Š\Æ§p\Ý\ZÊ‹\ã+\Ä\Ù~(¸þ\Ür[^GNPl\×\ë#\ËH\áóSz(‰lAn6\Òøy5±A*¨³*•/¯U\åv\ÙB¸\Ü%V\Þ5{÷¶AÅ¥EBl3D*—T\ì\ÌN“\ê|\â\íh\îŠOK\'E0iCm¡m%Kp”„¦\â(*T`¡9ùy=!ÀæµJh.2\Ëe\æ\Ê8;\r,¸Ý‰\ã\nRŽ\0U²¹\ì¼0»=\ã¹ÏxJk•\áAÑõþ!¸s\ën\å\âºõHQ\È\0k³f\ïTtBGF4bw\r—›N\à\Ã\\\Ò]4ipœžØ£\ÅýOZ9†§*ý”‚=¡;wR0Ûž¼%gYv \Ï&œBn©¡/\\AS+\r¨ð\ÖJ©ZXs\ìGD\å´cF&T\â[À0ž%+~„\í\èªs‚|L\Ñ\ßö,ÿ\0\×ô€\ç2ŸR\\¢q	uv\ê\Í6\Î\Úz¡	•\ëž\Å-Q­†•Í¦:1\âfŽÿ\0°\à\ß\0\×ô†ñ7Güƒø¿¤?N^9\Ñ\Âÿ\0_/\î\éLËŠj\åN2•\\¡Kw\03\Èo¯\Ê:=\â~Œú;ƒ|_L/ôg\Ñ\Ü\àZúa\Î&\\CJRg%\×\Økó\Ü-\Ý]\Ü-»º–\ZŸ`ŽøŸ£>Ž\à\ß\×\Ó\r\â~Œú;ƒ|_LA\ÎY\ç—.\ã\éo–˜\r,¡*Bœ\0Ò¢£aÛœ\æ#4\áM]PRTÈ‚6g(ñ?F}Á¾¯¦\"­Ñ ƒþžÁvo’jŸúÀžœÛ”m/!\Ò\äòYR[RÀUx\ÄB{\ÍO².na\ç&Ë³\Å\æeÜ«M¨¨„Ü U@FU9\ÇAð\ÜG]¿‡\è\æK¤P¶†\\\n9\åKE6A³š/£I’u\Öt{\É5J\Ó$\ÞyTiœ:}Y>0)·ç™ŸD‚\Þy¤\ËM!ÅŠ”)$„¨v€O«²(sEôju‹Uƒa\Ï0¡fH$\n\å—yþ\Ädq)<*^\çñ\å®ZA[­ƒr€4©;\éQ\Ý\Ê\á\Ì\Ê2–ei–F\Ä6€”Ž\áeg\ÄñˆI¥©IF¥e™CR\ì¡-¶\Ú2	@\0t\02‹oü\Þú¡8‹l\r<‰‡enQô\ËÌ¨y·\n\ÂOMØŠ&ÿ\0\Í\ïªÿ\0›\ßTc0\Öq&w\ÂSró\ržl6\ÉAOMMsèŒ„\ïü\Þú¡_ý\Þb /\áª!pƒ\ÕD(øA\êˆ\\ õDQ\nýyêˆŠŸ6ñ’‹{vEQ[\×j•j­Vt6\Þ¡¡#~qd\íL¼Š“jd¥\nz5bž\ÈX›\Ö\á¯%)HHM\0¢L]Å¹aj¦d4[¶nø£û=\î\èY\ËÄ—¬”ô\ÛR¥OÚ¥+\Ìô€\"™<RZmÄ¡i&¼¦”®ñ\\6Te¶%B\Ìs$\Òì³°\æ©\Å—\Ñ\Ìs‘ù\Ô÷À‡\Ë\Í2—8\\\ê¦\êx…MZ3\Ë-½ýT\\\'e„\ß\áð›n\Õ^.§M6\Ò$„ð¹W*›iO”Y~…*¥&\ÓCÓ¶*—\å/\Õ\r\n\rp(Ž*©ŸErˆKs~¸aA/×®G-\çº¥£ˆ‹“¬¶¶\×:t\Ò\0XPD\È=n.YSùÁøû=\î\ãÁ¥Wm2¥Yv\Æ;û=\î\ã\0\\\Æ#6\ëúö’µ,¤¸/;@ T–DÅ’8t¬Š”e²ý¼r¯\âb·ð™W\Þu\×\å\Î)+U®\æ@\Ø{vA2R¨“—KM©\Å%5\ÍÅ•«\Ú`#1\ÎD\çS\ß˜\ç\"\ró©\ï€ù[E\'\'ô\å¬PºÀ“F­\Ê\Ù\ç“N(\ì4­{c\íxõ@\î#\áUm\Ùa-—M’¾\ÜÁ¤ûÇª:g·,\ä™~8jÑ†«•\Çöôžô¾¯ü\ÂeÔ£\î¹i»¼Ò°órMO*\×T±«U\â\ÃL\È#>œŒZ\ÚgxI\Ö.\\\Ë\ç@”¾\Ì\ëHN6\ãºÔ²\éeUt€O°\Æ.w\ë¿·0Ó‰Rf\'8¤\Zk\Í	­sé‰»‡1=kk.@ X\áH\Ï}\Û³)8…¡Nbp$\æ5IŒ¶DfeQ3)v¥8Š–Â”R+\Þ!-ž\âY/\Ó3†7*š¶\ë\ë <\ã…Í¢›LbñM\ØÜŽ1/2\ì¼\ë–BÁ\âXjhS¿:oŒŽ\"‰v\Ö\ê¥\Z—{1F\Ü+4\ßA\Ä\ÛZum™ç¸´\"]\à€6R ‘ZôöCq·)ú—”\åY!$ô„†ªfq\Ù\Å\\Nµ\îU\ãýˆ±¼1¦\Ö\â’\ìÀ\Ö8§ T\íõERM-©e\\™¡R2˜t8rA\ÅX–]S­\áò\ï^‘WñA®\ÊP€\"4=m\êP”Üµ\í\Íd¨\î\ßü[\ì÷»Œ\Z†ƒ2\Ì6”\í€J€\é\0\ï\ÎÅ¾\Ï{¸Àg!B…\0,\Ç9ò¢\éŽr*\n	RT¬’œ\É\èDõOu—\ï\ÃX»©r\î\ï\Î(N=„­IJ1)#u)GÓk\Ï=›\"\Öf¥Czö\æZ2¡\ëu€¢€š›«Jø	\êž\ë/ß†JnµK\Ënqbr°™\Æk Jƒ T“ABIé¦¤Òµ¼«S¬Cc½Dó\"½\âvs©jž\ë/ß†Jy*_¨Á¶¿¿¿r©iÿ\0\È	xŒœŠR™Ù–e\ê\n†±a5\0€N}ª\×V©§)K÷\á%·%K÷\àV±Œ*uÔ¢[—y\ê\Z!Ôœªr< \Ã6\Ë.\Ê0\â­qûµc¦\ÑSòŠ\"¤-<¥/\Ökª{¬¿~\'2\Ê\ÏvóOdat¯J¥4irbq™—xQPN¥!VÒ•\'1A˜Œ\Û$\ío^¬¶\å\ã„\íeT…§”¥+¼\ÖÅ¾\Ï{¸\ÆE\ä¤s\ãT\æIþ;#‹}ž÷q0\ÎB…\n cœŠÒ¥Z¬Ò¬ˆ\é,˜\ç\"¶ù\Ô÷\Å\å5£²Ï¥¥1\"Ó­€P;Àe·\ç\Ía’S2n\á®\Ë7Àh¶¶B@AI\Ú)¸\Ó\Æm.¢uHdR¬Ø’¯h‰¹j\ÜRk\Å)\" \ÓoAé„¼½‰\ÉX\æôgiJp\Ùn  Q@*¢»b\ÜW8“Jk^¹{Uu\È\0\î m\í5\ï$a&\ß\Û\'i®s*5Î´=‘k\ì·3zqh\ãV\Ü(;÷ˆ¾W½<g8¡\ÂÚœ\áh’k„_¬\Öm7tÁm2\Êü\ãˆB•˜@M´¬TŒ=„8Ëšù‹›\Ùt\Â\È=\â¹\Ä\Õ.\ÄÌ¶ªa)ZkZ¿¦2«–\ËHmE- e¸;)®\Õ:’”:„•\êÂ”šŒ\èwC1%)$Ó¼´¢ý¹“_l\'å›™\Õ)O¼Ú?\áºQ^ð6À:\Zy©[f_×¹w.ÐŒº(#\ç´\ëD”¹ D\âe„ª”MZ¸rŠl¡C(—gV—]vª¯œp¬÷Tî‡›•neIRŸyón”W¾‘2“)\Ê\ë§vz3›5\ÞU“%>¸\Ôÿ\0¦\ÌoÂ—…¢B}\éF\ÜC«p6R/  \0n\Ú8\Ç!Yúy»U_ŸD|þ”`øn+%v%#-6¦A-›\n(&•¥vl§O\äÝŽ³<\çgø\É\ÏMj\æÔŸ\n\ËK¤R­- )\ÒOh1|²fV\êV™ö_—\n5±]™\nƒ\ÓM\Ñ5!\Õ\Îñ¥¥—.¡\ÎW³x§ó‚\Ûm\r¦\ÖÒ”÷\nDy”Ls‘L]1\Î@\ï\"öÔ›”š\ïDPö#ªŸd+GU0rKC©W›U¦´%49\ì9l\ÝÅ²O‰\rb:©öB´uS\n\"š\ÄuS\ì…jU÷S\n¬Tû!X:¢Z”ý\ÔÂ±Tû!\á@2R”òSb\ßg½\Ü`\ÈM\Ø{\Ý\Æÿ\Ù','Local Drive','2023-12-16 14:21:32','2023-12-16 14:21:32','IGH141585754362','IGH141585754362','video/quicktime','Image test','WRS695055681927');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_content` BEFORE INSERT ON `content` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'content' LIMIT 1;
    
    -- Generate a 12-character unique string. This example uses a simple random number for demonstration.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_content` AFTER INSERT ON `content` FOR EACH ROW BEGIN
    DECLARE insertTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Insert' from the salesforce_sync_change_type table
    SELECT id INTO insertTypeId FROM salesforce_sync_change_type WHERE name = 'Insert';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (NEW.id, insertTypeId, pendingStatusId, NEW.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_content` AFTER UPDATE ON `content` FOR EACH ROW BEGIN
    DECLARE updateTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Update' from the salesforce_sync_change_type table
    SELECT id INTO updateTypeId FROM salesforce_sync_change_type WHERE name = 'Update';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (NEW.id, updateTypeId, pendingStatusId, NEW.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_delete_content` BEFORE DELETE ON `content` FOR EACH ROW BEGIN
    DECLARE deleteTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Delete' from the salesforce_sync_change_type table (using 'name' field)
    SELECT id INTO deleteTypeId FROM salesforce_sync_change_type WHERE name = 'Delete';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table (using 'name' field)
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (OLD.id, deleteTypeId, pendingStatusId, OLD.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `crm_connection`
--

DROP TABLE IF EXISTS `crm_connection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crm_connection` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `owner` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `crm` enum('Salesforce','Dynamics 365') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `crm_org` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `crm_username` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `external_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fy_created_by_idx` (`created_by`),
  KEY `fk_updated_by_idx` (`updated_by`),
  KEY `fk_outbound_connectoin_owner_idx` (`owner`),
  CONSTRAINT `fk_outbound_connectoin_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_outbound_connectoin_owner` FOREIGN KEY (`owner`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_outbound_connectoin_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_connection`
--

LOCK TABLES `crm_connection` WRITE;
/*!40000 ALTER TABLE `crm_connection` DISABLE KEYS */;
INSERT INTO `crm_connection` VALUES ('YSV652915311653','IGH141585754362','Salesforce',1,'00D06000001aZwJ!AQMAQC2CPcFkJr38clFY6ibhXrCoKebvYxd.J941ctUWNPIbM_sU7S7gWc9l32VnCZIMhgXwzP4keKG_C7KJdyRhiXlgMSMH','5Aep861ZYmyocmHHpujS4EK88sVuo9fO.J2t93_KKO3Us1sUWLBvT.AVrDAsaJCRr3Pd.xDdxZgQQjR9x9jHZhk','IGH141585754362','IGH141585754362','2023-11-02 11:46:42','2023-12-12 10:21:05','00D06000001aZwJEAU','anirudh.krishnan@revspire.com.staging','https://resvspire-dev-ed.develop.my.salesforce.com');
/*!40000 ALTER TABLE `crm_connection` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `crm_connection_before_insert` BEFORE INSERT ON `crm_connection` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'crm_connection' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;

--
-- Table structure for table `fieldidentifier`
--

DROP TABLE IF EXISTS `fieldidentifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fieldidentifier` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salesforce_pull` tinyint(1) NOT NULL DEFAULT '0',
  `salesforce_push` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `table` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `salesforce_api_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `demo_idx` (`table`),
  CONSTRAINT `fk_fieldidentifier_table` FOREIGN KEY (`table`) REFERENCES `tableidentifier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldidentifier`
--

LOCK TABLES `fieldidentifier` WRITE;
/*!40000 ALTER TABLE `fieldidentifier` DISABLE KEYS */;
INSERT INTO `fieldidentifier` VALUES ('DMA011249651211',0,0,'salesforce_api_name','IIT','2023-12-11 14:04:19',NULL),('DMA058285695554',0,0,'organisation','IGH','2023-12-16 14:28:59',NULL),('DMA071147044255',0,0,'id','HVH','2023-12-04 17:08:59',NULL),('DMA216975030691',0,0,'salesforce_api_name','DMA','2023-12-11 14:04:59',NULL),('DMA272869433530',0,0,'created_at','DMA','2023-12-04 17:06:39',NULL),('DMA299176104645',0,0,'id','DMA','2023-12-04 17:06:39',NULL),('DMA310047793490',0,0,'google_storage_bucket','PDX','2023-12-16 14:25:29',NULL),('DMA412348188843',0,0,'salesforce_push','DMA','2023-12-04 17:06:39',NULL),('DMA434659355724',0,0,'permission','HVH','2023-12-04 17:08:59',NULL),('DMA488832983643',0,0,'salesforce_pull','DMA','2023-12-04 17:06:39',NULL),('DMA509186838295',0,0,'id','LER','2023-12-04 17:07:59',NULL),('DMA519506872183',1,1,'description','DYJ','2023-12-04 19:28:29','revspiredemoani__Description__c'),('DMA595242024021',0,0,'table','DMA','2023-12-04 17:06:39',NULL),('DMA677272253368',0,0,'name','DMA','2023-12-04 17:06:39',NULL),('DMA764842532355',0,0,'salesforce_id','WRS','2023-12-12 14:35:49',NULL),('DMA803384710850',0,0,'name','LER','2023-12-04 17:07:59',NULL),('DMA944233216292',0,0,'created_by','MAS','2023-12-12 10:43:14',NULL),('DMA959855676590',0,0,'profile','HVH','2023-12-04 17:08:59',NULL),('DMA961831794083',0,0,'name','YKE','2023-12-04 18:23:29','Name'),('FMU002688761803',0,0,'name','ZPB','2023-12-04 16:47:29',NULL),('FMU005838015122',0,0,'Super_priv','IGH','2023-12-04 13:57:03',NULL),('FMU005959653301',0,0,'Create_user_priv','IGH','2023-12-04 13:57:03',NULL),('FMU008873848252',0,0,'timestamp','BNL','2023-12-04 13:57:03',NULL),('FMU014868945828',0,0,'updated_by','ZEZ','2023-12-04 13:57:03',NULL),('FMU018025048093',0,0,'content','HXP','2023-12-04 16:56:59',NULL),('FMU018660793098',0,0,'Execute_priv','IGH','2023-12-04 13:57:03',NULL),('FMU018693155626',0,0,'id','PDX','2023-12-04 13:57:03',NULL),('FMU019031281600',0,0,'last_name','IGH','2023-12-04 13:57:03',NULL),('FMU020815897752',0,0,'Create_routine_priv','IGH','2023-12-04 13:57:03',NULL),('FMU023698248922',0,0,'id','HIV','2023-12-04 16:39:29',NULL),('FMU025080006592',0,0,'owner','YSV','2023-12-04 13:57:03',NULL),('FMU031901953771',0,0,'updated_by','PDX','2023-12-04 13:57:03',NULL),('FMU037504426238',0,0,'x509_issuer','IGH','2023-12-04 13:57:03',NULL),('FMU045157626313',1,1,'thumbnail','HXP','2023-12-04 16:56:59','revspiredemoani__Thumbnail__c'),('FMU045642692638',0,0,'Create_view_priv','IGH','2023-12-04 13:57:03',NULL),('FMU052242896568',0,1,'content','KBD','2023-12-04 13:57:03','revspiredemoani__Content__c'),('FMU060435184333',0,0,'created_at','UPR','2023-12-04 13:57:03',NULL),('FMU060889910963',0,0,'Shutdown_priv','IGH','2023-12-04 13:57:03',NULL),('FMU063351323887',0,0,'account_locked','IGH','2023-12-04 13:57:03',NULL),('FMU076978345473',0,0,'Lock_tables_priv','IGH','2023-12-04 13:57:03',NULL),('FMU078757111056',0,0,'created_at','NSY','2023-12-04 13:57:03',NULL),('FMU082892943250',0,0,'reset_token','IGH','2023-12-04 13:57:03',NULL),('FMU084291732017',0,0,'max_connections','IGH','2023-12-04 13:57:03',NULL),('FMU086146839974',0,0,'updated_at','IGH','2023-12-04 13:57:03',NULL),('FMU088677856222',0,0,'id','PEA','2023-12-04 13:57:03',NULL),('FMU095995237208',0,0,'id','OFL','2023-12-04 16:51:59',NULL),('FMU104257341571',0,0,'email','IGH','2023-12-04 13:57:03',NULL),('FMU124628157470',0,1,'id','KBD','2023-12-04 13:57:03','revspiredemoani__external_id__c'),('FMU129082158327',0,1,'description','KBD','2023-12-04 13:57:03','revspiredemoani__Description__c'),('FMU131546236697',0,0,'updated_at','KBD','2023-12-04 13:57:03',NULL),('FMU139942640568',0,1,'name','WRS','2023-12-04 13:57:03','Name'),('FMU145381874540',0,0,'id','ZPB','2023-12-04 16:47:29',NULL),('FMU148999907214',0,0,'tablename','IIT','2023-12-04 13:57:03',NULL),('FMU154418385731',1,1,'name','HXP','2023-12-04 16:56:59','Name'),('FMU171084797168',0,0,'Show_db_priv','IGH','2023-12-04 13:57:03',NULL),('FMU177753875197',0,0,'Trigger_priv','IGH','2023-12-04 13:57:03',NULL),('FMU185212360867',0,0,'File_priv','IGH','2023-12-04 13:57:03',NULL),('FMU189722109762',0,0,'Password_reuse_history','IGH','2023-12-04 13:57:03',NULL),('FMU190523654399',0,0,'max_questions','IGH','2023-12-04 13:57:03',NULL),('FMU206195843597',0,1,'name','KBD','2023-12-04 13:57:03','Name'),('FMU210334534021',0,0,'Delete_priv','IGH','2023-12-04 13:57:03',NULL),('FMU217101353422',0,0,'external_url','YSV','2023-12-04 13:57:03',NULL),('FMU217738864214',0,0,'name','PEA','2023-12-04 13:57:03',NULL),('FMU233316220560',0,0,'crm_org','YSV','2023-12-04 13:57:03',NULL),('FMU234597427988',0,0,'active','YSV','2023-12-04 13:57:03',NULL),('FMU236984803561',0,0,'dynamics_query','UPR','2023-12-04 13:57:03',NULL),('FMU246641250556',0,0,'authentication_string','IGH','2023-12-04 13:57:03',NULL),('FMU254710491983',0,0,'updated_by','NSY','2023-12-04 13:57:03',NULL),('FMU266965127798',0,0,'reset_token_expires','IGH','2023-12-04 13:57:03',NULL),('FMU269527551037',0,0,'updated_by','KBD','2023-12-04 13:57:03',NULL),('FMU276535484265',0,0,'password_hash','IGH','2023-12-04 13:57:03',NULL),('FMU277600145225',0,0,'user','BNL','2023-12-04 13:57:03',NULL),('FMU279191290288',0,0,'name','ZEZ','2023-12-04 13:57:03',NULL),('FMU282931077557',0,1,'source','KBD','2023-12-04 13:57:03','revspiredemoani__Source__c'),('FMU294027242151',0,0,'name','PGK','2023-12-04 13:57:03',NULL),('FMU305447467886',0,0,'active','IGH','2023-12-04 13:57:03',NULL),('FMU312783317931',0,1,'id','WRS','2023-12-04 13:57:03','revspiredemoani__External_id__c'),('FMU314828854347',0,0,'Show_view_priv','IGH','2023-12-04 13:57:03',NULL),('FMU319569642021',0,0,'refresh_token','YSV','2023-12-04 13:57:03',NULL),('FMU323334164286',0,0,'created_at','YSV','2023-12-04 13:57:03',NULL),('FMU324705108370',0,0,'created_by','UPR','2023-12-04 13:57:03',NULL),('FMU327035906097',0,1,'salesforce_primary_object','UPR','2023-12-04 13:57:03','revspiredemoani__Salesforce_primary_object__c'),('FMU327132314747',0,0,'Alter_priv','IGH','2023-12-04 13:57:03',NULL),('FMU328051868200',0,0,'Create_tmp_table_priv','IGH','2023-12-04 13:57:03',NULL),('FMU342925075760',0,0,'error_description','OFL','2023-12-04 16:51:59',NULL),('FMU346179250949',0,0,'name','NSY','2023-12-04 13:57:03',NULL),('FMU353502226390',0,0,'created_at','WRS','2023-12-04 13:57:03',NULL),('FMU359963022507',0,0,'ssl_cipher','IGH','2023-12-04 13:57:03',NULL),('FMU361379212104',1,1,'active','DYJ','2023-12-04 13:57:03','revspiredemoani__Active__c'),('FMU363562798465',0,0,'Index_priv','IGH','2023-12-04 13:57:03',NULL),('FMU382499873062',0,0,'profile','IGH','2023-12-04 13:57:03',NULL),('FMU383409996873',0,0,'crm_username','YSV','2023-12-04 13:57:03',NULL),('FMU383623182199',0,0,'id','NSY','2023-12-04 13:57:03',NULL),('FMU384418683484',0,0,'external_sfdc_id','ZEZ','2023-12-04 13:57:03',NULL),('FMU386988507943',0,0,'updated_at','WRS','2023-12-04 13:57:03',NULL),('FMU388251361798',1,1,'id','HXP','2023-12-04 16:56:59','revspiredemoani__External_id__c'),('FMU391954310603',0,0,'updated_by','HXP','2023-12-04 16:56:59',NULL),('FMU408550149209',0,0,'created_by','PEA','2023-12-04 13:57:03',NULL),('FMU412051462951',1,1,'id','DYJ','2023-12-04 13:57:03','revspiredemoani__External_id__c'),('FMU431911711982',1,1,'owner','DYJ','2023-12-04 13:57:03','revspiredemoani__External_Owner_id__c'),('FMU432160072430',0,1,'operator','YKE','2023-12-04 16:56:29','revspiredemoani__Operator__c'),('FMU433533342027',0,0,'Insert_priv','IGH','2023-12-04 13:57:03',NULL),('FMU442220019588',0,0,'dynamics_primary_object','UPR','2023-12-04 13:57:03',NULL),('FMU445607632813',0,0,'Alter_routine_priv','IGH','2023-12-04 13:57:03',NULL),('FMU450870654965',0,0,'updated_by','PGK','2023-12-04 13:57:03',NULL),('FMU451200989494',0,0,'salesforce_sync_operation','OFL','2023-12-04 16:51:59',NULL),('FMU457883880899',0,0,'tag','YKE','2023-12-04 16:56:29',NULL),('FMU460087353791',0,0,'type','PEA','2023-12-04 13:57:03',NULL),('FMU465962330312',0,0,'created_at','IGH','2023-12-04 13:57:03',NULL),('FMU474657993273',0,0,'created_by','WRS','2023-12-04 13:57:03',NULL),('FMU476143526356',0,0,'last_login_date','IGH','2023-12-04 13:57:03',NULL),('FMU484492203671',0,0,'updated_at','PGK','2023-12-04 13:57:03',NULL),('FMU489306584455',0,0,'updated_at','UPR','2023-12-04 13:57:03',NULL),('FMU491426933082',0,0,'name','HIV','2023-12-04 16:39:29',NULL),('FMU501310006250',0,0,'User_attributes','IGH','2023-12-04 13:57:03',NULL),('FMU505485431761',0,0,'updated_at','HXP','2023-12-04 16:56:59',NULL),('FMU508250624414',1,1,'title','DYJ','2023-12-04 13:57:03','revspiredemoani__Title__c'),('FMU517843070921',0,0,'created_by','YKE','2023-12-04 16:56:29',NULL),('FMU522608221063',0,0,'updated_at','YSV','2023-12-04 13:57:03',NULL),('FMU523978896926',0,0,'created_by','NSY','2023-12-04 13:57:03',NULL),('FMU529058028504',0,0,'licenses_in_use','PDX','2023-12-04 13:57:03',NULL),('FMU529937586308',0,0,'created_at','HXP','2023-12-04 16:56:59',NULL),('FMU534136020144',0,0,'id','BNL','2023-12-04 13:57:03',NULL),('FMU536234689443',0,0,'created_at','PDX','2023-12-04 13:57:03',NULL),('FMU536493715397',0,0,'password_expired','IGH','2023-12-04 13:57:03',NULL),('FMU543484180739',0,0,'plugin','IGH','2023-12-04 13:57:03',NULL),('FMU544011704198',0,0,'Reload_priv','IGH','2023-12-04 13:57:03',NULL),('FMU556185488175',0,0,'created_at','ZEZ','2023-12-04 13:57:03',NULL),('FMU564252223413',0,0,'id','IIT','2023-12-04 13:57:03',NULL),('FMU567899675636',0,0,'updated_at','NSY','2023-12-04 13:57:03',NULL),('FMU568084689385',0,0,'sync_change_type','MAS','2023-12-04 13:57:03',NULL),('FMU573434243512',1,1,'section','HXP','2023-12-04 16:56:59','revspiredemoani__Section__c'),('FMU580026738885',0,0,'salesforce_object','NSY','2023-12-04 13:57:03',NULL),('FMU580365568939',0,1,'name','UPR','2023-12-04 13:57:03','Name'),('FMU591044477736',0,0,'updated_by','YKE','2023-12-04 16:56:29',NULL),('FMU594390378886',0,0,'crm','YSV','2023-12-04 13:57:03',NULL),('FMU595612817998',0,0,'created_by','HXP','2023-12-04 16:56:59',NULL),('FMU607337873994',0,0,'pitch','HXP','2023-12-04 16:56:59',NULL),('FMU617145410381',0,0,'ssl_type','IGH','2023-12-04 13:57:03',NULL),('FMU618700722808',0,0,'References_priv','IGH','2023-12-04 13:57:03',NULL),('FMU622530095858',0,0,'Password_reuse_time','IGH','2023-12-04 13:57:03',NULL),('FMU629838847209',0,0,'updated_by','IGH','2023-12-04 13:57:03',NULL),('FMU650852731103',0,0,'updated_by','WRS','2023-12-04 13:57:03',NULL),('FMU651357640186',0,0,'created_at','PEA','2023-12-04 13:57:03',NULL),('FMU653194408540',0,0,'created_by','PGK','2023-12-04 13:57:03',NULL),('FMU654332209987',0,0,'updated_by','YSV','2023-12-04 13:57:03',NULL),('FMU658861715028',0,0,'updated_at','DYJ','2023-12-04 13:57:03',NULL),('FMU666725859666',0,0,'last_password_change_reset','IGH','2023-12-04 13:57:03',NULL),('FMU669418219168',0,0,'created_by','ZEZ','2023-12-04 13:57:03',NULL),('FMU678534662050',0,0,'crm_connection','ZEZ','2023-12-04 13:57:03',NULL),('FMU683592143173',0,0,'x509_subject','IGH','2023-12-04 13:57:03',NULL),('FMU687746834649',0,0,'Repl_slave_priv','IGH','2023-12-04 13:57:03',NULL),('FMU688060141808',1,1,'headline','DYJ','2023-12-04 13:57:03','revspiredemoani__Headline__c'),('FMU690900270538',0,1,'field','YKE','2023-12-04 16:56:29','revspiredemoani__Field__c'),('FMU699743106680',0,0,'max_updates','IGH','2023-12-04 13:57:03',NULL),('FMU703836417480',0,0,'api_name','ZEZ','2023-12-04 13:57:03',NULL),('FMU725479438644',0,0,'created_by','PDX','2023-12-04 13:57:03',NULL),('FMU732920481573',1,1,'opportunity_id','DYJ','2023-12-04 13:57:03','revspiredemoani__Opportunity__c'),('FMU736488096169',0,0,'relevant','ZEZ','2023-12-04 13:57:03',NULL),('FMU736699035145',0,0,'updated_at','PDX','2023-12-04 13:57:03',NULL),('FMU741993204449',0,0,'Create_role_priv','IGH','2023-12-04 13:57:03',NULL),('FMU744230242207',1,1,'name','DYJ','2023-12-04 13:57:03','Name'),('FMU746094695986',0,0,'record_id','MAS','2023-12-04 13:57:03',NULL),('FMU761363279782',0,0,'parent_folder','WRS','2023-12-04 13:57:03','revspiredemoani__External_Parent_Folder_id__c'),('FMU764284389804',0,0,'updated_by','UPR','2023-12-04 13:57:03',NULL),('FMU769556732632',0,0,'updated_by','DYJ','2023-12-04 13:57:03',NULL),('FMU775360161228',0,0,'Password_require_current','IGH','2023-12-04 13:57:03',NULL),('FMU776110878004',0,0,'id','PGK','2023-12-04 13:57:03',NULL),('FMU782010220718',0,0,'updated_by','PEA','2023-12-04 13:57:03',NULL),('FMU786340672323',0,0,'created_by','DYJ','2023-12-04 13:57:03',NULL),('FMU787228793638',0,0,'id','IGH','2023-12-04 13:57:03',NULL),('FMU794760227011',0,0,'Host','IGH','2023-12-04 13:57:03',NULL),('FMU796067887726',0,1,'thumbnail','KBD','2023-12-04 13:57:03','revspiredemoani__Thumbnail__c'),('FMU814214791928',0,0,'created_at','KBD','2023-12-04 13:57:03',NULL),('FMU820000157523',0,0,'first_name','IGH','2023-12-04 13:57:03',NULL),('FMU822660783139',0,0,'salesforce_field','PEA','2023-12-04 13:57:03',NULL),('FMU823015211915',0,0,'User','IGH','2023-12-04 13:57:03',NULL),('FMU832454450271',0,0,'updated_at','PEA','2023-12-04 13:57:03',NULL),('FMU844866640720',0,0,'updated_at','ZEZ','2023-12-04 13:57:03',NULL),('FMU846865054076',0,0,'Select_priv','IGH','2023-12-04 13:57:03',NULL),('FMU849830646858',0,0,'Process_priv','IGH','2023-12-04 13:57:03',NULL),('FMU853395894963',1,1,'arrangement','HXP','2023-12-04 16:56:59','revspiredemoani__Arrangement__c'),('FMU858263989777',0,1,'id','UPR','2023-12-04 13:57:03','revspiredemoani__External_id__c'),('FMU861595972311',0,0,'type','NSY','2023-12-04 13:57:03',NULL),('FMU863956383301',0,0,'Repl_client_priv','IGH','2023-12-04 13:57:03',NULL),('FMU870079455775',0,0,'Grant_priv','IGH','2023-12-04 13:57:03',NULL),('FMU871255361354',0,0,'Update_priv','IGH','2023-12-04 13:57:03',NULL),('FMU878099906143',0,0,'Create_tablespace_priv','IGH','2023-12-04 13:57:03',NULL),('FMU883864417563',0,0,'number_of_licenses','PDX','2023-12-04 13:57:03',NULL),('FMU886489462000',0,0,'id','ZEZ','2023-12-04 13:57:03',NULL),('FMU890753746861',0,0,'username','IGH','2023-12-04 13:57:03',NULL),('FMU894082854402',0,0,'salesforce_query','UPR','2023-12-04 13:57:03',NULL),('FMU894207694468',0,0,'name','PDX','2023-12-04 13:57:03',NULL),('FMU895553551516',0,0,'created_at','PGK','2023-12-04 13:57:03',NULL),('FMU895692909038',0,0,'password_lifetime','IGH','2023-12-04 13:57:03',NULL),('FMU896383385076',0,0,'Create_priv','IGH','2023-12-04 13:57:03',NULL),('FMU900428860354',0,0,'created_by','IGH','2023-12-04 13:57:03',NULL),('FMU900972170662',0,1,'id','YKE','2023-12-04 16:56:29','revspiredemoani__External_id__c'),('FMU901034804899',0,0,'password_last_changed','IGH','2023-12-04 13:57:03',NULL),('FMU902374920343',0,1,'folder','KBD','2023-12-04 13:57:03',NULL),('FMU912878568202',0,0,'created_by','YSV','2023-12-04 13:57:03',NULL),('FMU914345300675',0,0,'created_by','KBD','2023-12-04 13:57:03',NULL),('FMU914744622925',0,0,'Drop_priv','IGH','2023-12-04 13:57:03',NULL),('FMU916016057054',0,1,'mimetype','KBD','2023-12-04 13:57:03','revspiredemoani__Mimetype__c'),('FMU916141251954',0,0,'action','BNL','2023-12-04 13:57:03',NULL),('FMU917027492929',0,0,'licenses_connected_to_crm','PDX','2023-12-04 13:57:03',NULL),('FMU922256375589',0,0,'ip_address','BNL','2023-12-04 13:57:03',NULL),('FMU923066587114',0,0,'id','MAS','2023-12-04 13:57:03',NULL),('FMU927144600941',0,0,'max_user_connections','IGH','2023-12-04 13:57:03',NULL),('FMU935276807224',0,0,'id','YSV','2023-12-04 13:57:03',NULL),('FMU942719543298',0,0,'Drop_role_priv','IGH','2023-12-04 13:57:03',NULL),('FMU949412694152',0,0,'api_name','PEA','2023-12-04 13:57:03',NULL),('FMU949884335462',0,0,'access_token','YSV','2023-12-04 13:57:03',NULL),('FMU952999075829',0,0,'created_at','MAS','2023-12-04 13:57:03',NULL),('FMU956602229695',0,0,'api_name','NSY','2023-12-04 13:57:03',NULL),('FMU960797145925',1,1,'signature','DYJ','2023-12-04 13:57:03','revspiredemoani__Signature__c'),('FMU961273749321',0,0,'status','MAS','2023-12-04 13:57:03',NULL),('FMU966105038267',0,0,'created_at','YKE','2023-12-04 16:56:29',NULL),('FMU969363878451',0,0,'Event_priv','IGH','2023-12-04 13:57:03',NULL),('FMU974095655580',0,0,'created_at','DYJ','2023-12-04 13:57:03',NULL),('FMU976404765597',0,1,'value','YKE','2023-12-04 16:56:29','revspiredemoani__Value__c'),('FMU992939217939',0,0,'updated_at','YKE','2023-12-04 16:56:29',NULL),('FMU996076920065',1,1,'main_logo','DYJ','2023-12-04 13:57:03','revspiredemoani__Main_logo__c');
/*!40000 ALTER TABLE `fieldidentifier` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `fieldidentifier_before_insert` BEFORE INSERT ON `fieldidentifier` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'fieldidentifier' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `folder`
--

DROP TABLE IF EXISTS `folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `folder` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `parent_folder` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salesforce_id` varchar(18) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_folder_created_by` (`created_by`),
  KEY `fk_folder_updated_by` (`updated_by`),
  CONSTRAINT `fk_folder_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_folder_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folder`
--

LOCK TABLES `folder` WRITE;
/*!40000 ALTER TABLE `folder` DISABLE KEYS */;
INSERT INTO `folder` VALUES ('WRS089300794610','Ani 7','WRS871042950889','2023-12-12 15:50:51','2023-12-12 15:51:04','IGH141585754362','IGH141585754362','a050600001EXHN4AAP'),('WRS141213575509','Ani 3','WRS765168112483','2023-12-12 15:17:39','2023-12-12 15:17:48','IGH141585754362','IGH141585754362','a050600001EXHMkAAP'),('WRS222406632473','Ani 6','WRS765168112483','2023-12-12 15:38:51','2023-12-12 15:39:03','IGH141585754362','IGH141585754362','a050600001EXHMzAAP'),('WRS389169692423','Ani 10','WRS979112806709','2023-12-12 16:02:52','2023-12-12 16:03:01','IGH141585754362','IGH141585754362','a050600001EXHNTAA5'),('WRS402351081745','Ani 9','WRS979112806709','2023-12-12 15:58:30','2023-12-12 15:58:40','IGH141585754362','IGH141585754362','a050600001EXHNEAA5'),('WRS459602833221','Ani 5','WRS871042950889','2023-12-12 15:32:20','2023-12-12 15:32:32','IGH141585754362','IGH141585754362','a050600001EXHMuAAP'),('WRS695055681927','Ani 8.1','WRS765168112483','2023-12-12 15:55:48','2023-12-12 16:04:55','IGH141585754362','IGH141585754362','a050600001EXHN9AAP'),('WRS765168112483','root','000000000000000','2023-12-11 09:51:57','2023-12-12 15:32:01','IGH141585754362','IGH141585754362','a050600001EXHHQAAP'),('WRS871042950889','Ani 4.23','WRS765168112483','2023-12-12 15:18:43','2023-12-12 16:03:41','IGH141585754362','IGH141585754362','a050600001EXHMpAAP'),('WRS940214447620','Ani 1','WRS765168112483','2023-12-12 14:51:59','2023-12-12 15:32:01','IGH141585754362','IGH141585754362','a050600001EXHMLAAP'),('WRS979112806709','Ani 2','WRS765168112483','2023-12-12 15:16:17','2023-12-12 15:16:31','IGH141585754362','IGH141585754362','a050600001EXHMaAAP');
/*!40000 ALTER TABLE `folder` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_folder` BEFORE INSERT ON `folder` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'folder' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_folder` AFTER INSERT ON `folder` FOR EACH ROW BEGIN
    DECLARE insertTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Insert' from the salesforce_sync_change_type table
    SELECT id INTO insertTypeId FROM salesforce_sync_change_type WHERE name = 'Insert';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (NEW.id, insertTypeId, pendingStatusId, NEW.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_folder` AFTER UPDATE ON `folder` FOR EACH ROW BEGIN
    DECLARE updateTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Update' from the salesforce_sync_change_type table
    SELECT id INTO updateTypeId FROM salesforce_sync_change_type WHERE name = 'Update';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (NEW.id, updateTypeId, pendingStatusId, NEW.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_delete_folder` BEFORE DELETE ON `folder` FOR EACH ROW BEGIN
    DECLARE deleteTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Delete' from the salesforce_sync_change_type table (using 'name' field)
    SELECT id INTO deleteTypeId FROM salesforce_sync_change_type WHERE name = 'Delete';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table (using 'name' field)
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (OLD.id, deleteTypeId, pendingStatusId, OLD.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `organisation`
--

DROP TABLE IF EXISTS `organisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organisation` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `number_of_licenses` int NOT NULL,
  `licenses_in_use` int NOT NULL DEFAULT '0',
  `licenses_connected_to_crm` int DEFAULT NULL,
  `google_storage_bucket` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_organisation_created_by` (`created_by`),
  KEY `fk_organisation_updated_by` (`updated_by`),
  CONSTRAINT `fk_organisation_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_organisation_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisation`
--

LOCK TABLES `organisation` WRITE;
/*!40000 ALTER TABLE `organisation` DISABLE KEYS */;
INSERT INTO `organisation` VALUES ('PDX436422222699','RevSpire','2023-10-26 13:00:47','2023-12-16 14:57:47','IGH141585754362','IGH141585754362',10,2,1,'revspire_test');
/*!40000 ALTER TABLE `organisation` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `organisation_before_insert` BEFORE INSERT ON `organisation` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'organisation' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `permission_before_insert` BEFORE INSERT ON `permission` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'permission' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pitch`
--

DROP TABLE IF EXISTS `pitch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pitch` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opportunity_id` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `signature` blob,
  `main_logo` mediumblob,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `owner` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `headline` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pitch_created_by_idx` (`created_by`),
  KEY `fk_pitch_updated_by_idx` (`updated_by`),
  KEY `fk_pitch_owner_idx` (`owner`),
  CONSTRAINT `fk_pitch_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_pitch_owner` FOREIGN KEY (`owner`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_pitch_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pitch`
--

LOCK TABLES `pitch` WRITE;
/*!40000 ALTER TABLE `pitch` DISABLE KEYS */;
INSERT INTO `pitch` VALUES ('DYJ084701251317','dsds','dsd',NULL,NULL,'2023-12-04 19:30:44','2023-12-04 19:30:44','IGH601244209893','IGH601244209893',1,'IGH601244209893','ds','ds','ds');
/*!40000 ALTER TABLE `pitch` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pitch_before_insert` BEFORE INSERT ON `pitch` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'pitch' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_pitch` AFTER INSERT ON `pitch` FOR EACH ROW BEGIN
    DECLARE insertTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Insert' from the salesforce_sync_change_type table
    SELECT id INTO insertTypeId FROM salesforce_sync_change_type WHERE name = 'Insert';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (NEW.id, insertTypeId, pendingStatusId, NEW.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_pitch` AFTER UPDATE ON `pitch` FOR EACH ROW BEGIN
    DECLARE updateTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Update' from the salesforce_sync_change_type table
    SELECT id INTO updateTypeId FROM salesforce_sync_change_type WHERE name = 'Update';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (NEW.id, updateTypeId, pendingStatusId, NEW.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_delete_pitch` BEFORE DELETE ON `pitch` FOR EACH ROW BEGIN
    DECLARE deleteTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Delete' from the salesforce_sync_change_type table (using 'name' field)
    SELECT id INTO deleteTypeId FROM salesforce_sync_change_type WHERE name = 'Delete';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table (using 'name' field)
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (OLD.id, deleteTypeId, pendingStatusId, OLD.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pitch_content`
--

DROP TABLE IF EXISTS `pitch_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pitch_content` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `thumbnail` mediumblob NOT NULL,
  `section` int NOT NULL,
  `arrangement` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pitch` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pitchcontent_created_by` (`created_by`),
  KEY `fk_pitchcontent_updated_by` (`updated_by`),
  KEY `fk_pitchcontent_content_idx` (`content`),
  KEY `fk_pitchcontent_pitch_idx` (`pitch`),
  CONSTRAINT `fk_pitchcontent_content` FOREIGN KEY (`content`) REFERENCES `content` (`id`),
  CONSTRAINT `fk_pitchcontent_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_pitchcontent_pitch` FOREIGN KEY (`pitch`) REFERENCES `pitch` (`id`),
  CONSTRAINT `fk_pitchcontent_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pitch_content`
--

LOCK TABLES `pitch_content` WRITE;
/*!40000 ALTER TABLE `pitch_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `pitch_content` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pitchcontent_before_insert` BEFORE INSERT ON `pitch_content` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'pitchcontent' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_pitch_content` AFTER INSERT ON `pitch_content` FOR EACH ROW BEGIN
    DECLARE insertTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Insert' from the salesforce_sync_change_type table
    SELECT id INTO insertTypeId FROM salesforce_sync_change_type WHERE name = 'Insert';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (NEW.id, insertTypeId, pendingStatusId, NEW.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_pitch_content` AFTER UPDATE ON `pitch_content` FOR EACH ROW BEGIN
    DECLARE updateTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Update' from the salesforce_sync_change_type table
    SELECT id INTO updateTypeId FROM salesforce_sync_change_type WHERE name = 'Update';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (NEW.id, updateTypeId, pendingStatusId, NEW.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_delete_pitch_content` BEFORE DELETE ON `pitch_content` FOR EACH ROW BEGIN
    DECLARE deleteTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Delete' from the salesforce_sync_change_type table (using 'name' field)
    SELECT id INTO deleteTypeId FROM salesforce_sync_change_type WHERE name = 'Delete';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table (using 'name' field)
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (OLD.id, deleteTypeId, pendingStatusId, OLD.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_profile_created_by` (`created_by`),
  KEY `fk_profile_updated_by` (`updated_by`),
  CONSTRAINT `fk_profile_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_profile_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES ('PGK068294406932','2023-10-26 13:02:29','2023-10-31 10:28:48','IGH141585754362','IGH846177043249','Sample Profile 1'),('PGK662740392295','2023-10-27 12:24:44','2023-10-31 09:48:47','IGH141585754362','IGH846177043249','1'),('PGK709386366148','2023-10-30 13:54:29','2023-10-30 13:54:29','IGH141585754362','IGH141585754362','Sample2 234 Profile'),('PGK710714933192','2023-10-26 13:03:07','2023-10-31 08:15:34','IGH141585754362','IGH141585754362','Marketing'),('PGK803996314111','2023-10-26 13:02:29','2023-10-28 14:15:22','IGH141585754362','IGH141585754362','Admin'),('PGK999658128245','2023-10-30 13:41:30','2023-10-30 14:01:49','IGH141585754362','IGH141585754362','Sample22 234 Profile');
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `profile_before_insert` BEFORE INSERT ON `profile` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'profile' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;

--
-- Table structure for table `profile_permission`
--

DROP TABLE IF EXISTS `profile_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile_permission` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `profile` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `permission` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_profile_permission_profile_idx` (`profile`),
  KEY `fk_profile_permission_permission_idx` (`permission`),
  CONSTRAINT `fk_profile_permission_permission` FOREIGN KEY (`permission`) REFERENCES `permission` (`id`),
  CONSTRAINT `fk_profile_permission_profile` FOREIGN KEY (`profile`) REFERENCES `profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_permission`
--

LOCK TABLES `profile_permission` WRITE;
/*!40000 ALTER TABLE `profile_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_permission` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `profile_permission_before_insert` BEFORE INSERT ON `profile_permission` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'profile_permission' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reference_field_level_one`
--

DROP TABLE IF EXISTS `reference_field_level_one`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reference_field_level_one` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salesforce_field` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `api_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_reference_field_level_one_created_by` (`created_by`),
  KEY `fk_reference_field_level_one_updated_by` (`updated_by`),
  CONSTRAINT `fk_reference_field_level_one_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_reference_field_level_one_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reference_field_level_one`
--

LOCK TABLES `reference_field_level_one` WRITE;
/*!40000 ALTER TABLE `reference_field_level_one` DISABLE KEYS */;
/*!40000 ALTER TABLE `reference_field_level_one` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `reference_field_level_one_before_insert` BEFORE INSERT ON `reference_field_level_one` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'reference_field_level_one' LIMIT 1;
    
    -- Generate a 12-character unique string. This example uses a simple random number for demonstration.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `salesforce_field`
--

DROP TABLE IF EXISTS `salesforce_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesforce_field` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salesforce_object` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `api_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_salesforce_field_salesforce_object_idx` (`salesforce_object`),
  KEY `fk_salesforce_field_created_by_idx` (`created_by`),
  KEY `fk_salesforce_field_updated_by_idx` (`updated_by`),
  CONSTRAINT `fk_salesforce_field_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_salesforce_field_salesforce_object` FOREIGN KEY (`salesforce_object`) REFERENCES `salesforce_object` (`id`),
  CONSTRAINT `fk_salesforce_field_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesforce_field`
--

LOCK TABLES `salesforce_field` WRITE;
/*!40000 ALTER TABLE `salesforce_field` DISABLE KEYS */;
INSERT INTO `salesforce_field` VALUES ('NSY003102306279','ZEZ581847169046','Billing Street','BillingStreet','textarea','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY005548615013','ZEZ074345068143','EnableAutoSubForFeeds','UserPreferencesEnableAutoSubForFeeds','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY006422730168','ZEZ199261266923','Tracking Number','revspiredemoani__TrackingNumber__c','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY009066080682','ZEZ074345068143','ShowEmailToExternalUsers','UserPreferencesShowEmailToExternalUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY013589194988','ZEZ074345068143','Data.com User','UserPermissionsJigsawProspectingUser','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY013793143456','ZEZ199261266923','Has Line Item','HasOpportunityLineItem','boolean','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY017060890809','ZEZ581847169046','Photo URL','PhotoUrl','url','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY024972263746','ZEZ074345068143','Url for medium profile photo','MediumPhotoUrl','url','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY027885724816','ZEZ074345068143','Photo','SmallPhotoUrl','url','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY031330364785','ZEZ581847169046','Website','Website','url','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY046530321283','ZEZ581847169046','Account Number','AccountNumber','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY048754157543','ZEZ581847169046','Employees','NumberOfEmployees','int','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY050513062673','ZEZ074345068143','Email Encoding','EmailEncodingKey','picklist','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY055833303421','ZEZ074345068143','Apex Mobile User','UserPermissionsMobileUser','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY056025530263','ZEZ199261266923','Created By ID','CreatedById','reference','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY057716428355','ZEZ199261266923','Won','IsWon','boolean','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY061703066398','ZEZ199261266923','Campaign ID','CampaignId','reference','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY064343940526','ZEZ199261266923','Has Open Activity','HasOpenActivity','boolean','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY065391724058','ZEZ581847169046','NAICS Description','NaicsDesc','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY065404908792','ZEZ074345068143','Company Name','CompanyName','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY073342210681','ZEZ074345068143','Created Date','CreatedDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY080642174073','ZEZ074345068143','ShowFaxToGuestUsers','UserPreferencesShowFaxToGuestUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY082188769320','ZEZ074345068143','ReminderSoundOff','UserPreferencesReminderSoundOff','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY088183062233','ZEZ581847169046','Billing City','BillingCity','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY099520281981','ZEZ199261266923','Last Activity','LastActivityDate','date','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY100498810503','ZEZ074345068143','Active','IsActive','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY105942479433','ZEZ074345068143','Division','Division','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY107770274493','ZEZ074345068143','User Photo badge text overlay','BadgeText','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY107985224675','ZEZ074345068143','ShowWorkPhoneToExternalUsers','UserPreferencesShowWorkPhoneToExternalUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY109348574754','ZEZ074345068143','Phone','Phone','phone','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY115717077735','ZEZ074345068143','Latitude','Latitude','double','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY117178672102','ZEZ074345068143','Salesforce CRM Content User','UserPermissionsSFContentUser','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY119065995438','ZEZ074345068143','Chatter Email Highlights Frequency','DigestFrequency','picklist','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY133762371850','ZEZ074345068143','DisableLaterCommentEmail','UserPreferencesDisableLaterCommentEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY133809821804','ZEZ074345068143','DisableEndorsementEmail','UserPreferencesDisableEndorsementEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY134872660166','ZEZ581847169046','Account Description','Description','textarea','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY135415794453','ZEZ074345068143','Account ID','AccountId','reference','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY151719601966','ZEZ074345068143','DisableBookmarkEmail','UserPreferencesDisableBookmarkEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY153502127298','ZEZ074345068143','RecordHomeSectionCollapseWTShown','UserPreferencesRecordHomeSectionCollapseWTShown','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY153724159257','ZEZ581847169046','Operating Hour ID','OperatingHoursId','reference','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY154699536184','ZEZ074345068143','Fax','Fax','phone','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY154779239701','ZEZ074345068143','SuppressEventSFXReminders','UserPreferencesSuppressEventSFXReminders','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY167113483107','ZEZ074345068143','Email Sender Address','SenderEmail','email','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY169629462221','ZEZ074345068143','Allow Forecasting','ForecastEnabled','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY172639558252','ZEZ581847169046','Billing Country','BillingCountry','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY173612693486','ZEZ199261266923','Stage','StageName','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY177976773286','ZEZ074345068143','Employee Number','EmployeeNumber','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY179183259773','ZEZ074345068143','Time Zone','TimeZoneSidKey','picklist','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY181230489333','ZEZ074345068143','ContentNoEmail','UserPreferencesContentNoEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY182718943974','ZEZ581847169046','Billing Latitude','BillingLatitude','double','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY193765588284','ZEZ581847169046','Shipping State/Province','ShippingState','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY196054535169','ZEZ581847169046','Active','revspiredemoani__Active__c','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY201872669348','ZEZ074345068143','Country','Country','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY206957064761','ZEZ074345068143','State/Province','State','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY207446165575','ZEZ581847169046','Account Phone','Phone','phone','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY225995548279','ZEZ581847169046','Year Started','YearStarted','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY229110749651','ZEZ581847169046','System Modstamp','SystemModstamp','datetime','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY233656946787','ZEZ199261266923','Closed','IsClosed','boolean','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY234612396205','ZEZ581847169046','Last Modified Date','LastModifiedDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY234902695039','ZEZ074345068143','Email Signature','Signature','textarea','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY237947106582','ZEZ199261266923','Created Date','CreatedDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY239518227278','ZEZ074345068143','ApexPagesDeveloperMode','UserPreferencesApexPagesDeveloperMode','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY239683917015','ZEZ074345068143','ShowFaxToExternalUsers','UserPreferencesShowFaxToExternalUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY241592954137','ZEZ581847169046','Last Viewed Date','LastViewedDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY244868127856','ZEZ074345068143','Data.com Monthly Addition Limit','JigsawImportLimitOverride','int','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY250609698007','ZEZ581847169046','Last Referenced Date','LastReferencedDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY256515603751','ZEZ581847169046','Tradestyle','Tradestyle','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY283381128947','ZEZ074345068143','RecordHomeReservedWTShown','UserPreferencesRecordHomeReservedWTShown','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY291926185872','ZEZ581847169046','Account Type','Type','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY292435466583','ZEZ074345068143','Manager ID','ManagerId','reference','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY293254717525','ZEZ074345068143','HideBiggerPhotoCallout','UserPreferencesHideBiggerPhotoCallout','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY296106274515','ZEZ074345068143','StayInTouchReminder','EmailPreferencesStayInTouchReminder','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY296281087487','ZEZ074345068143','Last Modified Date','LastModifiedDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY297050492183','ZEZ074345068143','HideEndUserOnboardingAssistantModal','UserPreferencesHideEndUserOnboardingAssistantModal','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY299141567478','ZEZ581847169046','Account Site','Site','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY305939953127','ZEZ199261266923','Account ID','AccountId','reference','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY306144940951','ZEZ581847169046','Deleted','IsDeleted','boolean','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY308203582007','ZEZ074345068143','Language','LanguageLocaleKey','picklist','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY316503514830','ZEZ074345068143','DisProfPostCommentEmail','UserPreferencesDisProfPostCommentEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY320007858164','ZEZ074345068143','HideCSNDesktopTask','UserPreferencesHideCSNDesktopTask','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY321177242622','ZEZ074345068143','Profile ID','ProfileId','reference','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY327665368399','ZEZ074345068143','HideCSNGetChatterMobileTask','UserPreferencesHideCSNGetChatterMobileTask','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY330653701285','ZEZ199261266923','Opportunity Type','Type','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY332767637756','ZEZ074345068143','Stay-in-Touch Email Subject','StayInTouchSubject','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY333497701523','ZEZ074345068143','Department','Department','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY335265118009','ZEZ074345068143','Out of office message','OutOfOfficeMessage','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY339701756219','ZEZ074345068143','ShowWorkPhoneToGuestUsers','UserPreferencesShowWorkPhoneToGuestUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY340751903448','ZEZ581847169046','Account Rating','Rating','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY349661100049','ZEZ074345068143','Title','Title','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY351318671694','ZEZ074345068143','DisableFileShareNotificationsForApi','UserPreferencesDisableFileShareNotificationsForApi','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY356310740444','ZEZ074345068143','GlobalNavBarWTShown','UserPreferencesGlobalNavBarWTShown','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY361726962366','ZEZ074345068143','DisableLikeEmail','UserPreferencesDisableLikeEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY366987700915','ZEZ581847169046','NAICS Code','NaicsCode','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY369987625972','ZEZ074345068143','HideSfxWelcomeMat','UserPreferencesHideSfxWelcomeMat','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY370189445437','ZEZ199261266923','Lead Source','LeadSource','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY377903344461','ZEZ199261266923','Owner ID','OwnerId','reference','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY386589581506','ZEZ581847169046','Last Modified By ID','LastModifiedById','reference','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY389489045728','ZEZ074345068143','Info Emails','ReceivesInfoEmails','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY395676075848','ZEZ581847169046','Billing Longitude','BillingLongitude','double','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY403693102675','ZEZ074345068143','PreviewCustomTheme','UserPreferencesPreviewCustomTheme','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY407027365087','ZEZ074345068143','Full Name','Name','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY407530136785','ZEZ074345068143','ShowCityToGuestUsers','UserPreferencesShowCityToGuestUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY407799166075','ZEZ199261266923','Has Overdue Task','HasOverdueTask','boolean','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY418393480980','ZEZ074345068143','Knowledge User','UserPermissionsKnowledgeUser','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY420904502664','ZEZ074345068143','Url for Android banner photo','MediumBannerPhotoUrl','url','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY429925475669','ZEZ199261266923','Opportunity ID','Id','id','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY430223578056','ZEZ581847169046','Billing Geocode Accuracy','BillingGeocodeAccuracy','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY430664997948','ZEZ581847169046','Number of Locations','revspiredemoani__NumberofLocations__c','double','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY431608423060','ZEZ581847169046','Billing State/Province','BillingState','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY434485700385','ZEZ581847169046','Shipping Address','ShippingAddress','address','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY434549741851','ZEZ074345068143','Locale','LocaleSidKey','picklist','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY435305010001','ZEZ074345068143','ShowTitleToGuestUsers','UserPreferencesShowTitleToGuestUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY436088043670','ZEZ074345068143','ShowPostalCodeToGuestUsers','UserPreferencesShowPostalCodeToGuestUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY437805973400','ZEZ074345068143','AutoBccStayInTouch','EmailPreferencesAutoBccStayInTouch','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY440015711299','ZEZ074345068143','CreateLEXAppsWTShown','UserPreferencesCreateLEXAppsWTShown','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY445451987390','ZEZ074345068143','Mobile','MobilePhone','phone','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY446976684449','ZEZ074345068143','Service Cloud User','UserPermissionsSupportUser','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY450769458385','ZEZ074345068143','DisableChangeCommentEmail','UserPreferencesDisableChangeCommentEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY451839655126','ZEZ199261266923','Current Generator(s)','revspiredemoani__CurrentGenerators__c','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY454347055828','ZEZ074345068143','User Type','UserType','picklist','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY465541711510','ZEZ199261266923','Amount','Amount','currency','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY469836117205','ZEZ581847169046','Created Date','CreatedDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY470826937323','ZEZ581847169046','Shipping Latitude','ShippingLatitude','double','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY473452157781','ZEZ581847169046','Owner ID','OwnerId','reference','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY474885778012','ZEZ074345068143','LightningExperiencePreferred','UserPreferencesLightningExperiencePreferred','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY476607709635','ZEZ074345068143','ActivityRemindersPopup','UserPreferencesActivityRemindersPopup','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY479450864232','ZEZ074345068143','Nickname','CommunityNickname','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY494221562979','ZEZ199261266923','Order Number','revspiredemoani__OrderNumber__c','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY494709846092','ZEZ074345068143','FavoritesWTShown','UserPreferencesFavoritesWTShown','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY503261537759','ZEZ074345068143','Created By ID','CreatedById','reference','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY512727912061','ZEZ074345068143','ShowMobilePhoneToExternalUsers','UserPreferencesShowMobilePhoneToExternalUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY514175303758','ZEZ074345068143','Last Name','LastName','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY515826617847','ZEZ074345068143','Offline User','UserPermissionsOfflineUser','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY516535902876','ZEZ581847169046','SLA','revspiredemoani__SLA__c','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY517685854357','ZEZ074345068143','Geocode Accuracy','GeocodeAccuracy','picklist','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY519143269880','ZEZ199261266923','Deleted','IsDeleted','boolean','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY520413216687','ZEZ074345068143','Default Notification Frequency when Joining Groups','DefaultGroupNotificationFrequency','picklist','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY527149152501','ZEZ581847169046','Account ID','Id','id','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY528269658356','ZEZ581847169046','Data.com Key','Jigsaw','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY529777763904','ZEZ581847169046','Shipping Street','ShippingStreet','textarea','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY533812111740','ZEZ581847169046','SLA Serial Number','revspiredemoani__SLASerialNumber__c','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY544341559096','ZEZ074345068143','PreviewLightning','UserPreferencesPreviewLightning','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY547638929027','ZEZ074345068143','SortFeedByComment','UserPreferencesSortFeedByComment','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY552981411621','ZEZ581847169046','Annual Revenue','AnnualRevenue','currency','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY554127825008','ZEZ074345068143','HasCelebrationBadge','UserPreferencesHasCelebrationBadge','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY559559847748','ZEZ074345068143','Contact ID','ContactId','reference','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY565161414970','ZEZ581847169046','Upsell Opportunity','revspiredemoani__UpsellOpportunity__c','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY566286362303','ZEZ199261266923','Last Modified Date','LastModifiedDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY566357910228','ZEZ074345068143','Last Login','LastLoginDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY580900746938','ZEZ074345068143','Last Referenced Date','LastReferencedDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY582127677818','ZEZ074345068143','ShowCityToExternalUsers','UserPreferencesShowCityToExternalUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY584826583586','ZEZ581847169046','Ownership','Ownership','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY585749946148','ZEZ074345068143','Extension','Extension','phone','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY587611332151','ZEZ199261266923','Forecast Category','ForecastCategory','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY588160288136','ZEZ074345068143','DisableAllFeedsEmail','UserPreferencesDisableAllFeedsEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY594312207394','ZEZ074345068143','Site.com Publisher User','UserPermissionsSiteforcePublisherUser','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY594419898086','ZEZ074345068143','Role ID','UserRoleId','reference','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY597396789674','ZEZ199261266923','Last Viewed Date','LastViewedDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY604618590887','ZEZ074345068143','Has Profile Photo','IsProfilePhotoActive','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY613494980719','ZEZ581847169046','Shipping Longitude','ShippingLongitude','double','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY615864880024','ZEZ074345068143','DisMentionsCommentEmail','UserPreferencesDisMentionsCommentEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY617901875280','ZEZ074345068143','HideS1BrowserUI','UserPreferencesHideS1BrowserUI','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY617917201125','ZEZ199261266923','System Modstamp','SystemModstamp','datetime','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY622152187508','ZEZ074345068143','JigsawListUser','UserPreferencesJigsawListUser','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY626186443144','ZEZ074345068143','ShowManagerToGuestUsers','UserPreferencesShowManagerToGuestUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY637727435340','ZEZ199261266923','Expected Amount','ExpectedRevenue','currency','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY638530116190','ZEZ581847169046','D-U-N-S Number','DunsNumber','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY643796033824','ZEZ074345068143','Admin Info Emails','ReceivesAdminInfoEmails','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY643849837261','ZEZ199261266923','Fiscal Quarter','FiscalQuarter','int','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY645378335979','ZEZ581847169046','Account Source','AccountSource','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY645781736490','ZEZ074345068143','ShowManagerToExternalUsers','UserPreferencesShowManagerToExternalUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY653013788771','ZEZ074345068143','DisableMessageEmail','UserPreferencesDisableMessageEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY654994122362','ZEZ581847169046','Shipping Geocode Accuracy','ShippingGeocodeAccuracy','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY660235879625','ZEZ074345068143','ShowStreetAddressToExternalUsers','UserPreferencesShowStreetAddressToExternalUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY663101019954','ZEZ074345068143','Last Viewed Date','LastViewedDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY663355251460','ZEZ199261266923','Last Modified By ID','LastModifiedById','reference','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY669527068425','ZEZ074345068143','Address','Address','address','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY671892374447','ZEZ199261266923','Fiscal Period','Fiscal','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY675288134882','ZEZ074345068143','CacheDiagnostics','UserPreferencesCacheDiagnostics','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY690078862653','ZEZ074345068143','City','City','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY694235163455','ZEZ074345068143','DisableFollowersEmail','UserPreferencesDisableFollowersEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY698968662599','ZEZ581847169046','Shipping Zip/Postal Code','ShippingPostalCode','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY706694983603','ZEZ074345068143','DisableProfilePostEmail','UserPreferencesDisableProfilePostEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY720662625245','ZEZ074345068143','Auto-login To Call Center','UserPermissionsCallCenterAutoLogin','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY726562197996','ZEZ074345068143','ShowCountryToExternalUsers','UserPreferencesShowCountryToExternalUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY727015952324','ZEZ074345068143','Site.com Contributor User','UserPermissionsSiteforceContributorUser','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY731735684658','ZEZ074345068143','ShowStateToGuestUsers','UserPreferencesShowStateToGuestUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY733773757454','ZEZ581847169046','Account Fax','Fax','phone','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY739947544167','ZEZ074345068143','ShowTitleToExternalUsers','UserPreferencesShowTitleToExternalUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY740431419331','ZEZ074345068143','Flow User','UserPermissionsInteractionUser','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY747812426413','ZEZ074345068143','Street','Street','textarea','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY749430301365','ZEZ074345068143','Sales Anywhere Trial Expiration Date','OfflinePdaTrialExpirationDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY751881400822','ZEZ074345068143','Url for full-sized Photo','FullPhotoUrl','url','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY752444681480','ZEZ074345068143','HideChatterOnboardingSplash','UserPreferencesHideChatterOnboardingSplash','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY753665304512','ZEZ074345068143','DisCommentAfterLikeEmail','UserPreferencesDisCommentAfterLikeEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY756619769852','ZEZ581847169046','Shipping City','ShippingCity','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY760379477180','ZEZ074345068143','Individual ID','IndividualId','reference','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY763161359133','ZEZ074345068143','Alias','Alias','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY764907406423','ZEZ199261266923','Forecast Category','ForecastCategoryName','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY768025683953','ZEZ199261266923','Quantity','TotalOpportunityQuantity','double','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY776533617429','ZEZ199261266923','Main Competitor(s)','revspiredemoani__MainCompetitors__c','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY777870476038','ZEZ581847169046','Ticker Symbol','TickerSymbol','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY790067708854','ZEZ074345068143','SuppressTaskSFXReminders','UserPreferencesSuppressTaskSFXReminders','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY790513210734','ZEZ074345068143','WDC User','UserPermissionsWorkDotComUserFeature','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY794577809789','ZEZ074345068143','Email','Email','email','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY795541669982','ZEZ581847169046','Customer Priority','revspiredemoani__CustomerPriority__c','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY797347789440','ZEZ074345068143','Stay-in-Touch Email Note','StayInTouchNote','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY800840595550','ZEZ199261266923','Description','Description','textarea','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY802199863643','ZEZ074345068143','HideSecondChatterOnboardingSplash','UserPreferencesHideSecondChatterOnboardingSplash','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY806870507827','ZEZ199261266923','Probability (%)','Probability','percent','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY815343513912','ZEZ074345068143','PathAssistantCollapsed','UserPreferencesPathAssistantCollapsed','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY819949482399','ZEZ074345068143','ShowMobilePhoneToGuestUsers','UserPreferencesShowMobilePhoneToGuestUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY827951597820','ZEZ581847169046','Account Name','Name','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY833301317721','ZEZ074345068143','Url for IOS banner photo','SmallBannerPhotoUrl','url','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY845964039531','ZEZ199261266923','Delivery/Installation Status','revspiredemoani__DeliveryInstallationStatus__c','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY852227814357','ZEZ074345068143','HideLightningMigrationModal','UserPreferencesHideLightningMigrationModal','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY860321966800','ZEZ074345068143','Username','Username','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY862787198146','ZEZ581847169046','Clean Status','CleanStatus','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY872430103711','ZEZ199261266923','Next Step','NextStep','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY874150192246','ZEZ074345068143','EventRemindersCheckboxDefault','UserPreferencesEventRemindersCheckboxDefault','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY883784452344','ZEZ074345068143','Show external indicator','IsExtIndicatorVisible','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY883856548818','ZEZ199261266923','Price Book ID','Pricebook2Id','reference','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY889519228496','ZEZ581847169046','Jigsaw Company ID','JigsawCompanyId','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY892141478034','ZEZ074345068143','DisableSharePostEmail','UserPreferencesDisableSharePostEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY893492959339','ZEZ581847169046','Billing Zip/Postal Code','BillingPostalCode','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY901789580379','ZEZ074345068143','GlobalNavGridMenuWTShown','UserPreferencesGlobalNavGridMenuWTShown','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY903270902021','ZEZ074345068143','ShowPostalCodeToExternalUsers','UserPreferencesShowPostalCodeToExternalUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY905384310432','ZEZ581847169046','Industry','Industry','picklist','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY910507103343','ZEZ074345068143','About Me','AboutMe','textarea','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY913546578877','ZEZ581847169046','Shipping Country','ShippingCountry','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY915200705560','ZEZ074345068143','Url for banner photo','BannerPhotoUrl','url','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY919772190897','ZEZ074345068143','DisableMentionsPostEmail','UserPreferencesDisableMentionsPostEmail','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY920688371099','ZEZ199261266923','Fiscal Year','FiscalYear','int','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY922998314650','ZEZ074345068143','ShowProfilePicToGuestUsers','UserPreferencesShowProfilePicToGuestUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY926946144482','ZEZ199261266923','Close Date','CloseDate','date','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY928824143417','ZEZ581847169046','Created By ID','CreatedById','reference','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY929144853659','ZEZ074345068143','User ID','Id','id','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY929930780948','ZEZ074345068143','ShowStateToExternalUsers','UserPreferencesShowStateToExternalUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY930410163411','ZEZ074345068143','ShowEmailToGuestUsers','UserPreferencesShowEmailToGuestUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY931442679772','ZEZ074345068143','Offline Edition Trial Expiration Date','OfflineTrialExpirationDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY931853111768','ZEZ074345068143','ExcludeMailAppAttachments','UserPreferencesExcludeMailAppAttachments','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY933551382210','ZEZ074345068143','SAML Federation ID','FederationIdentifier','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY933802599956','ZEZ581847169046','SIC Description','SicDesc','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY940927863065','ZEZ074345068143','TaskRemindersCheckboxDefault','UserPreferencesTaskRemindersCheckboxDefault','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY943362453898','ZEZ074345068143','ShowStreetAddressToGuestUsers','UserPreferencesShowStreetAddressToGuestUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY943530105000','ZEZ199261266923','Name','Name','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY947248622725','ZEZ074345068143','Email Sender Name','SenderName','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY949277277987','ZEZ581847169046','Master Record ID','MasterRecordId','reference','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY952823498241','ZEZ074345068143','Marketing User','UserPermissionsMarketingUser','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY954483182126','ZEZ074345068143','Last Password Change or Reset','LastPasswordChangeDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY956399293574','ZEZ074345068143','FavoritesShowTopFavorites','UserPreferencesFavoritesShowTopFavorites','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY956641932908','ZEZ074345068143','ContentEmailAsAndWhen','UserPreferencesContentEmailAsAndWhen','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY959130134394','ZEZ074345068143','Stay-in-Touch Email Signature','StayInTouchSignature','textarea','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY964089693467','ZEZ581847169046','Billing Address','BillingAddress','address','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY964307874406','ZEZ074345068143','AutoBcc','EmailPreferencesAutoBcc','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY964548766579','ZEZ074345068143','Zip/Postal Code','PostalCode','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY965273151140','ZEZ074345068143','Delegated Approver ID','DelegatedApproverId','reference','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY969261042744','ZEZ074345068143','System Modstamp','SystemModstamp','datetime','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY971306855762','ZEZ199261266923','Last Referenced Date','LastReferencedDate','datetime','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY971620854894','ZEZ074345068143','Last Modified By ID','LastModifiedById','reference','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY972269986729','ZEZ199261266923','Private','IsPrivate','boolean','IGH601244209893','IGH601244209893','2023-12-02 10:46:29','2023-12-02 10:46:29'),('NSY972967411365','ZEZ074345068143','Longitude','Longitude','double','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY973576344524','ZEZ581847169046','SLA Expiration Date','revspiredemoani__SLAExpirationDate__c','date','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY975776166631','ZEZ581847169046','Parent Account ID','ParentId','reference','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY985233195111','ZEZ074345068143','ShowCountryToGuestUsers','UserPreferencesShowCountryToGuestUsers','boolean','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY985785034470','ZEZ581847169046','Last Activity','LastActivityDate','date','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY989910649125','ZEZ074345068143','First Name','FirstName','string','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17'),('NSY991026385677','ZEZ581847169046','D&B Company ID','DandbCompanyId','reference','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY991313390424','ZEZ581847169046','SIC Code','Sic','string','IGH601244209893','IGH601244209893','2023-12-02 10:46:32','2023-12-02 10:46:32'),('NSY998399459754','ZEZ074345068143','Call Center ID','CallCenterId','reference','IGH601244209893','IGH601244209893','2023-12-02 14:49:17','2023-12-02 14:49:17');
/*!40000 ALTER TABLE `salesforce_field` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesforce_field_before_insert` BEFORE INSERT ON `salesforce_field` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'salesforce_field' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;

--
-- Table structure for table `salesforce_object`
--

DROP TABLE IF EXISTS `salesforce_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesforce_object` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `crm_connection` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `relevant` tinyint(1) DEFAULT NULL,
  `api_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `external_sfdc_id` char(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_outbound_connection_idx` (`crm_connection`),
  KEY `fk_created_by_idx` (`created_by`),
  KEY `fk_updated_by_idx` (`updated_by`),
  CONSTRAINT `fk_salesforce_objects_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_salesforce_objects_crm_connection` FOREIGN KEY (`crm_connection`) REFERENCES `crm_connection` (`id`),
  CONSTRAINT `fk_salesforce_objects_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesforce_object`
--

LOCK TABLES `salesforce_object` WRITE;
/*!40000 ALTER TABLE `salesforce_object` DISABLE KEYS */;
INSERT INTO `salesforce_object` VALUES ('ZEZ000355036929','Platform Cache Partition','YSV652915311653',0,'PlatformCachePartition','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ000910962932','Group Member','YSV652915311653',0,'GroupMember','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ001948399471','User Preference','YSV652915311653',0,'UserPreference','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ002268906684','Work Order Share','YSV652915311653',0,'WorkOrderShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ004691561688','Opportunity Stage','YSV652915311653',0,'OpportunityStage','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ009673387752','Return Order Feed','YSV652915311653',0,'ReturnOrderFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ013371692982','Operating Hours','YSV652915311653',0,'OperatingHours','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ014090298688','Scheduled Jobs','YSV652915311653',0,'CronTrigger','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ015830276548','Apex Debug Log','YSV652915311653',0,'ApexLog','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ018435619788','Entity Definition','YSV652915311653',0,'EntityDefinition','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ019159920531','Dashboard Feed','YSV652915311653',0,'DashboardFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ020067831520','User Provisioning Request Share','YSV652915311653',0,'UserProvisioningRequestShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ020771601256','Skill','YSV652915311653',0,'Skill','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ021318634060','Entity Particle','YSV652915311653',0,'EntityParticle','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ025866461941','Report Feed','YSV652915311653',0,'ReportFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ025939472043','Resource Preference Feed','YSV652915311653',0,'ResourcePreferenceFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ029509022859','Location Share','YSV652915311653',0,'LocationShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ030467619216','Data Assessment Metric','YSV652915311653',0,'DataAssessmentMetric','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ031853751309','Apex Job','YSV652915311653',0,'AsyncApexJob','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ031891235180','Package License','YSV652915311653',0,'PackageLicense','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ034640801171','Additional Directory Number','YSV652915311653',0,'AdditionalNumber','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ035427631843','Share: Pitch','YSV652915311653',0,'revspiredemoani__Pitch__Share','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ036258328739','Contract Line Item','YSV652915311653',0,'ContractLineItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ039884670674','Email Status','YSV652915311653',0,'EmailStatus','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ040990310759','User Owned File','YSV652915311653',0,'OwnedContentDocument','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ041324501895','Email Template','YSV652915311653',0,'EmailTemplate','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ042520938480','External Event','YSV652915311653',0,'ExternalEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ042727435047','User Provisioning Log','YSV652915311653',0,'UserProvisioningLog','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ043893860693','Category Data','YSV652915311653',0,'CategoryData','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ045419853222','Matching Information','YSV652915311653',0,'MatchingInformation','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ052605235998','Connected App','YSV652915311653',0,'ConnectedApplication','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ052680576269','Opportunity Change Event','YSV652915311653',0,'OpportunityChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ059009357410','Revspire Table Identifier','YSV652915311653',0,'revspiredemoani__Revspire_Table_Identifier__c','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ061009463910','Lead Share','YSV652915311653',0,'LeadShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ064983667866','Process Instance Node','YSV652915311653',0,'ProcessInstanceNode','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ071777213431','Lead Status Value','YSV652915311653',0,'LeadStatus','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ072265358708','Content Body','YSV652915311653',0,'ContentBody','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ073334423893','Object Milestone History','YSV652915311653',0,'EntityMilestoneHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ073506873169','Return Order Line Item Feed','YSV652915311653',0,'ReturnOrderLineItemFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ073927917586','Order Product History','YSV652915311653',0,'OrderItemHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ074345068143','User','YSV652915311653',0,'User','2023-12-02 10:46:29','IGH601244209893','2023-12-02 15:21:50','IGH601244209893',NULL),('ZEZ077756712285','Lead History','YSV652915311653',0,'LeadHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ080436251201','Solution Status Value','YSV652915311653',0,'SolutionStatus','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ081136915908','Macro','YSV652915311653',0,'Macro','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ082178748289','Org Delete Request Share','YSV652915311653',0,'OrgDeleteRequestShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ086968528187','Embedded Service','YSV652915311653',0,'EmbeddedServiceDetail','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ087796329602','Named Credential','YSV652915311653',0,'NamedCredential','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ087901081971','Messaging Session History','YSV652915311653',0,'MessagingSessionHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ095082458197','Change Event: Pitch','YSV652915311653',0,'revspiredemoani__Pitch__ChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ098352741541','Call Center','YSV652915311653',0,'CallCenter','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ100654395390','Content Folder','YSV652915311653',0,'ContentFolder','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ105700267577','Work Order Feed','YSV652915311653',0,'WorkOrderFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ115117838713','Object Milestone Feed','YSV652915311653',0,'EntityMilestoneFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ119250234327','Setting Granted By License','YSV652915311653',0,'GrantedByLicense','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ119312054588','Contact History','YSV652915311653',0,'ContactHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ120047658793','Service Resource Share','YSV652915311653',0,'ServiceResourceShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ122963819767','Macro Instruction','YSV652915311653',0,'MacroInstruction','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ124311465885','Milestone','YSV652915311653',0,'MilestoneType','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ124389128875','Apex Class','YSV652915311653',0,'ApexClass','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ126732209815','History: Tag','YSV652915311653',0,'revspiredemoani__Tag__History','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ127217890813','Work Type Share','YSV652915311653',0,'WorkTypeShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ127413428507','Task Priority Value','YSV652915311653',0,'TaskPriority','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ129793825680','SAML Single Sign-On Setting','YSV652915311653',0,'SamlSsoConfig','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ130086865397','User Login','YSV652915311653',0,'UserLogin','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ130088454233','Contact Share','YSV652915311653',0,'ContactShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ131172519299','Extension','YSV652915311653',0,'ChatterExtension','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ132403468836','UserAppMenuCustomization','YSV652915311653',0,'UserAppMenuCustomization','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ133867938196','Feed Attachment','YSV652915311653',0,'FeedAttachment','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ138336124958','Campaign Share','YSV652915311653',0,'CampaignShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ138823830651','Visualforce Access Metric','YSV652915311653',0,'VisualforceAccessMetrics','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ139661077539','Open Activity','YSV652915311653',0,'OpenActivity','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ140567437876','Wave Compatibility Check Item','YSV652915311653',0,'WaveCompatibilityCheckItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ144569251820','User Permission Access','YSV652915311653',0,'UserPermissionAccess','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ145353395627','Queue sObject','YSV652915311653',0,'QueueSobject','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ146952008965','Auth Session','YSV652915311653',0,'AuthSession','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ148847505588','Custom Brand','YSV652915311653',0,'CustomBrand','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ149173724603','Return Order','YSV652915311653',0,'ReturnOrder','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ149297391203','Resource Absence History','YSV652915311653',0,'ResourceAbsenceHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ151676733187','Service Territory Member','YSV652915311653',0,'ServiceTerritoryMember','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ151855846076','Group Member Request','YSV652915311653',0,'CollaborationGroupMemberRequest','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ152102198593','Predefined Case Team Record','YSV652915311653',0,'CaseTeamTemplateRecord','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ152105978831','Individual History','YSV652915311653',0,'IndividualHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ153481301994','Work Order Status Value','YSV652915311653',0,'WorkOrderStatus','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ155490616481','Contact Feed','YSV652915311653',0,'ContactFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ156786643114','Authentication Configuration','YSV652915311653',0,'AuthConfig','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ158265642037','Service Contract Share','YSV652915311653',0,'ServiceContractShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ161791548283','Duplicate Record Set','YSV652915311653',0,'DuplicateRecordSet','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ164008645493','Attachment','YSV652915311653',0,'Attachment','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ169418313698','Background Operation','YSV652915311653',0,'BackgroundOperation','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ170053858468','Opportunity Contact Role','YSV652915311653',0,'OpportunityContactRole','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ171218184913','Case Milestone','YSV652915311653',0,'CaseMilestone','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ171758616502','Campaign Change Event','YSV652915311653',0,'CampaignChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ175857706159','Lightning Experience Theme','YSV652915311653',0,'LightningExperienceTheme','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ177098299541','List View Chart Instance','YSV652915311653',0,'ListViewChartInstance','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ178703027012','Campaign Feed','YSV652915311653',0,'CampaignFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ179968372154','Record Type','YSV652915311653',0,'RecordType','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ185089756906','Skill Requirement History','YSV652915311653',0,'SkillRequirementHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ185199119322','Platform Event Subscription','YSV652915311653',0,'EventBusSubscriber','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ185487997890','Period','YSV652915311653',0,'Period','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ186549376869','Service Resource Feed','YSV652915311653',0,'ServiceResourceFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ187901185068','Streaming Channel','YSV652915311653',0,'StreamingChannel','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ188447253953','Auth. Provider','YSV652915311653',0,'AuthProvider','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ192286123700','ContentDocument Feed','YSV652915311653',0,'ContentDocumentFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ193869728775','Voice Call Recording Share','YSV652915311653',0,'VoiceCallRecordingShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ194533424632','Account History','YSV652915311653',0,'AccountHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ195104027348','Event Relation Change Event','YSV652915311653',0,'EventRelationChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ196075367923','Order Product Feed','YSV652915311653',0,'OrderItemFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ199261266923','Opportunity','YSV652915311653',1,'Opportunity','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ202246003972','Content Delivery View','YSV652915311653',0,'ContentDistributionView','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ203759108859','Content','YSV652915311653',0,'revspiredemoani__Content__c','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ205963524250','Apex Test Run Result','YSV652915311653',0,'ApexTestRunResult','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ207168414450','Flow Interview Share','YSV652915311653',0,'FlowInterviewShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ207799509360','Account Partner','YSV652915311653',0,'AccountPartner','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ209450325192','Fiscal Year Settings','YSV652915311653',0,'FiscalYearSettings','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ211431589174','Share: Revspire Table Identifier','YSV652915311653',0,'revspiredemoani__Revspire_Table_Identifier__Share','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ212549131561','Service Appointment Status Value','YSV652915311653',0,'ServiceAppointmentStatus','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ216377175614','Permission Set','YSV652915311653',0,'PermissionSet','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ219380352850','Contact Clean Info','YSV652915311653',0,'ContactCleanInfo','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ222616006827','Solution','YSV652915311653',0,'Solution','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ224256068676','Opportunity History','YSV652915311653',0,'OpportunityHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ225867325650','External Data Source','YSV652915311653',0,'ExternalDataSource','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ227657214018','Contact','YSV652915311653',0,'Contact','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ228311241816','Object Permissions','YSV652915311653',0,'ObjectPermissions','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ229566536126','Custom Brand Asset','YSV652915311653',0,'CustomBrandAsset','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ230072019835','Permission Set License Assignment','YSV652915311653',0,'PermissionSetLicenseAssign','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ235347978989','Product Feed','YSV652915311653',0,'Product2Feed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ237020948190','Partner Role Value','YSV652915311653',0,'PartnerRole','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ238855139574','Work Order Line Item','YSV652915311653',0,'WorkOrderLineItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ240328024365','Event Log File','YSV652915311653',0,'EventLogFile','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ245398422000','Resource Preference History','YSV652915311653',0,'ResourcePreferenceHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ246348916782','Solution Feed','YSV652915311653',0,'SolutionFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ247792506821','Picklist Value Info','YSV652915311653',0,'PicklistValueInfo','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ248970893443','Account Contact Role','YSV652915311653',0,'AccountContactRole','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ249085696645','Service Contract Change Event','YSV652915311653',0,'ServiceContractChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ253967501459','Messaging Session Feed','YSV652915311653',0,'MessagingSessionFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ255577014996','EmailCapture','YSV652915311653',0,'EmailCapture','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ258843526484','Knowledgeable User','YSV652915311653',0,'KnowledgeableUser','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ260448937546','Assigned Resource Feed','YSV652915311653',0,'AssignedResourceFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ265750441016','Library Member','YSV652915311653',0,'ContentWorkspaceMember','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ273317192004','Goal','YSV652915311653',0,'TodayGoal','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ274856909433','Time Slot','YSV652915311653',0,'TimeSlot','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ278050771241','Messaging User History','YSV652915311653',0,'MessagingEndUserHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ279335054828','Visualforce Page','YSV652915311653',0,'ApexPage','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ280045693069','Content Version','YSV652915311653',0,'ContentVersion','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ282016186305','Content Document History','YSV652915311653',0,'ContentDocumentHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ283808547336','Contract Line Item Change Event','YSV652915311653',0,'ContractLineItemChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ284057271931','AuraDefinition Info','YSV652915311653',0,'AuraDefinitionInfo','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ285683151600','Data.com Owned Entity','YSV652915311653',0,'DatacloudOwnedEntity','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ286540318547','User Entity Access','YSV652915311653',0,'UserEntityAccess','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ288587413996','Flex Queue Item','YSV652915311653',0,'FlexQueueItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ292506138134','Asset File','YSV652915311653',0,'ContentAsset','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ293440276098','Entitlement Change Event','YSV652915311653',0,'EntitlementChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ294766322983','Resource Preference','YSV652915311653',0,'ResourcePreference','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ295272455825','Feed Revision','YSV652915311653',0,'FeedRevision','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ296760054581','Email Services Address','YSV652915311653',0,'EmailServicesAddress','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ297135870248','Relationship','YSV652915311653',0,'RelationshipInfo','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ299161042365','Contract History','YSV652915311653',0,'ContractHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ305213882871','Outgoing Email','YSV652915311653',0,'OutgoingEmail','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ307216956565','Process Instance','YSV652915311653',0,'ProcessInstance','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ308478337068','Case Feed','YSV652915311653',0,'CaseFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ308668903362','Group','YSV652915311653',0,'CollaborationGroup','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ310267781196','Contract Line Item History','YSV652915311653',0,'ContractLineItemHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ310869165985','Entitlement','YSV652915311653',0,'Entitlement','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ311148798382','Stamp Assignment','YSV652915311653',0,'StampAssignment','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ311241024463','Login Geo Data','YSV652915311653',0,'LoginGeo','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ312919304065','Process Definition','YSV652915311653',0,'ProcessDefinition','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ313388677605','Service Contract Feed','YSV652915311653',0,'ServiceContractFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ313566722267','Messaging Channel','YSV652915311653',0,'MessagingChannel','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ313624683128','Permission Set Group Component','YSV652915311653',0,'PermissionSetGroupComponent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ315628854851','Content User Subscription','YSV652915311653',0,'ContentUserSubscription','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ318712171463','Feed Item','YSV652915311653',0,'FeedItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ320064427628','Content Document Subscription','YSV652915311653',0,'ContentDocumentSubscription','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ323290588634','Skill Requirement Feed','YSV652915311653',0,'SkillRequirementFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ330103047499','Asset Relationship','YSV652915311653',0,'AssetRelationship','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ332269254449','Service Resource','YSV652915311653',0,'ServiceResource','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ332716206398','History: Revspire Table Identifier','YSV652915311653',0,'revspiredemoani__Revspire_Table_Identifier__History','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ334143149977','History: Content','YSV652915311653',0,'revspiredemoani__Content__History','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ338913425187','Flow Interview Stage Relation','YSV652915311653',0,'FlowStageRelation','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ340157048161','Product','YSV652915311653',0,'Product2','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ342555228008','Work Type Feed','YSV652915311653',0,'WorkTypeFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ343159358336','Change Event: Content','YSV652915311653',0,'revspiredemoani__Content__ChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ344063191063','Feed Comment','YSV652915311653',0,'FeedComment','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ344486859016','Asset Relationship Feed','YSV652915311653',0,'AssetRelationshipFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ345122998901','Conference Number','YSV652915311653',0,'ConferenceNumber','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ346918164143','Recently Viewed','YSV652915311653',0,'RecentlyViewed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ348333423349','User License','YSV652915311653',0,'UserLicense','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ349032913659','Opportunity Share','YSV652915311653',0,'OpportunityShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ349184475232','Apex Page Info','YSV652915311653',0,'ApexPageInfo','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ350986664509','Site Detail','YSV652915311653',0,'SiteDetail','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ355042214835','Org Lifecycle Notification','YSV652915311653',0,'OrgLifecycleNotification','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ355087531129','Campaign Member','YSV652915311653',0,'CampaignMember','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ355535699385','Platform Cache Partition Type','YSV652915311653',0,'PlatformCachePartitionType','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ356837982643','Service Territory','YSV652915311653',0,'ServiceTerritory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ359462134874','Entitlement History','YSV652915311653',0,'EntitlementHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ361554345452','Asset','YSV652915311653',0,'Asset','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ361799692140','Service Appointment Share','YSV652915311653',0,'ServiceAppointmentShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ362269330175','Service Territory History','YSV652915311653',0,'ServiceTerritoryHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ367408191195','Relationship Domain','YSV652915311653',0,'RelationshipDomain','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ368993775331','Event','YSV652915311653',0,'Event','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ369393575348','Note and Attachment','YSV652915311653',0,'NoteAndAttachment','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ378239316286','Campaign Field History','YSV652915311653',0,'CampaignHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ383454808390','Report','YSV652915311653',0,'Report','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ386032960736','Email Service','YSV652915311653',0,'EmailServicesFunction','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ386828855971','Location','YSV652915311653',0,'Location','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ389357864287','Holiday','YSV652915311653',0,'Holiday','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ389906644252','Case Status Value','YSV652915311653',0,'CaseStatus','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ393430266895','Contract','YSV652915311653',0,'Contract','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ394341076159','Accepted Event Relation','YSV652915311653',0,'AcceptedEventRelation','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ395908070165','Branding Set Property','YSV652915311653',0,'BrandingSetProperty','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ399839626997','Email Message','YSV652915311653',0,'EmailMessage','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ401230574958','Dashboard','YSV652915311653',0,'Dashboard','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ406235572328','Letterhead','YSV652915311653',0,'BrandTemplate','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ406445756932','Data Statistics','YSV652915311653',0,'DataStatistics','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ408857469827','Matching Rule','YSV652915311653',0,'MatchingRule','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ408918477043','Test Suite Membership','YSV652915311653',0,'TestSuiteMembership','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ409526919395','Order Feed','YSV652915311653',0,'OrderFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ410198443950','Product Entitlement Template','YSV652915311653',0,'ProductEntitlementTemplate','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ410771527709','Business Hours','YSV652915311653',0,'BusinessHours','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ413430468563','Content Folder Link','YSV652915311653',0,'ContentFolderLink','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ418827802332','Custom Button or Link','YSV652915311653',0,'WebLink','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ419364398735','Entitlement Template','YSV652915311653',0,'EntitlementTemplate','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ421646682006','Voice Call','YSV652915311653',0,'VoiceCall','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ424269509896','Static Resource','YSV652915311653',0,'StaticResource','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ425335012772','Case Team Member Role','YSV652915311653',0,'CaseTeamRole','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ426572609158','Content Version History','YSV652915311653',0,'ContentVersionHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ429650021185','User Provisioning Request','YSV652915311653',0,'UserProvisioningRequest','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ430976708820','Work Type History','YSV652915311653',0,'WorkTypeHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ432598870650','Case Change Event','YSV652915311653',0,'CaseChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ432699537307','Content Tag Subscription','YSV652915311653',0,'ContentTagSubscription','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ433314128250','Email Domain Key','YSV652915311653',0,'EmailDomainKey','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ433513596125','Group Member','YSV652915311653',0,'CollaborationGroupMember','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ437916199152','Content Folder Member','YSV652915311653',0,'ContentFolderMember','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ438938309846','List Email','YSV652915311653',0,'ListEmail','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ440746462382','Data.com Company','YSV652915311653',0,'DatacloudCompany','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ441907858887','Return Order Line Item History','YSV652915311653',0,'ReturnOrderLineItemHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ444472117763','Order History','YSV652915311653',0,'OrderHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ446598635470','Setup Audit Trail Entry','YSV652915311653',0,'SetupAuditTrail','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ448261085383','Data.com Address','YSV652915311653',0,'DatacloudAddress','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ451163818548','Product Change Event','YSV652915311653',0,'Product2ChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ451913973736','Attached Content Document','YSV652915311653',0,'AttachedContentDocument','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ451995462599','Promoted Search Term','YSV652915311653',0,'SearchPromotionRule','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ452516121279','Topic Feed','YSV652915311653',0,'TopicFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ453341931526','Content Version Comment','YSV652915311653',0,'ContentVersionComment','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ455397303639','Account Share','YSV652915311653',0,'AccountShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ458738472739','Group Record','YSV652915311653',0,'CollaborationGroupRecord','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ460864429790','Messaging Link','YSV652915311653',0,'MessagingLink','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ462774481123','Field Permissions','YSV652915311653',0,'FieldPermissions','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ464301336988','Lightning Component Definition','YSV652915311653',0,'AuraDefinition','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ464772562928','Field Definition','YSV652915311653',0,'FieldDefinition','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ469299771328','Lightning Usage By Page Metrics','YSV652915311653',0,'LightningUsageByPageMetrics','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ469737356965','Approval Request','YSV652915311653',0,'ProcessInstanceWorkitem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ470181158249','Service Appointment','YSV652915311653',0,'ServiceAppointment','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ471177963046','D&B Company','YSV652915311653',0,'DandBCompany','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ476840756345','Case Solution','YSV652915311653',0,'CaseSolution','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ477121072333','Skill Requirement','YSV652915311653',0,'SkillRequirement','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ483808409872','Content Delivery','YSV652915311653',0,'ContentDistribution','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ485011883531','Apex Trigger','YSV652915311653',0,'ApexTrigger','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ490959762121','Logout Event Stream','YSV652915311653',0,'LogoutEventStream','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ492032817091','Apex Test Result','YSV652915311653',0,'ApexTestResult','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ493468100664','Associated Location','YSV652915311653',0,'AssociatedLocation','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ499514721798','Service Territory Share','YSV652915311653',0,'ServiceTerritoryShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ504425888419','Asset Feed','YSV652915311653',0,'AssetFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ510803234307','Lookups from Activity','YSV652915311653',0,'LookedUpFromActivity','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ510897560520','Data.com Usage','YSV652915311653',0,'DatacloudPurchaseUsage','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ511191182314','Work Order History','YSV652915311653',0,'WorkOrderHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ517258486260','Library Permission','YSV652915311653',0,'ContentWorkspacePermission','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ519010982959','Case Team Member','YSV652915311653',0,'CaseTeamMember','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ522922951283','Branding Set','YSV652915311653',0,'BrandingSet','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ525421915133','Permission Set Assignment','YSV652915311653',0,'PermissionSetAssignment','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ528674860045','Organization-wide From Email Address','YSV652915311653',0,'OrgWideEmailAddress','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ529272771001','Aggregate Result','YSV652915311653',0,'AggregateResult','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ530144145274','Installed Mobile App','YSV652915311653',0,'InstalledMobileApp','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ532937665965','Process Instance Step','YSV652915311653',0,'ProcessInstanceStep','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ534593913270','Entitlement Contact','YSV652915311653',0,'EntitlementContact','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ537407827132','Domain','YSV652915311653',0,'Domain','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ539474179538','Event Feed','YSV652915311653',0,'EventFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ542015262452','Goal Share','YSV652915311653',0,'TodayGoalShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ542441482229','Announcement','YSV652915311653',0,'Announcement','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ543078724800','Content Folder Item','YSV652915311653',0,'ContentFolderItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ544024576939','External Data User Authentication','YSV652915311653',0,'ExternalDataUserAuth','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ547977088529','Activity History','YSV652915311653',0,'ActivityHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ548746505331','Platform Action','YSV652915311653',0,'PlatformAction','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ549543456685','User Share','YSV652915311653',0,'UserShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ552208754747','Idea Comment','YSV652915311653',0,'IdeaComment','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ557669929747','Zone','YSV652915311653',0,'Community','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ559804820976','Content Document','YSV652915311653',0,'ContentDocument','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ561371314861','Feed Like','YSV652915311653',0,'FeedLike','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ563896594162','Solution History','YSV652915311653',0,'SolutionHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ564914613556','Search Layout','YSV652915311653',0,'SearchLayout','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ565233503062','Security Custom Baseline','YSV652915311653',0,'SecurityCustomBaseline','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ566879214314','Undecided Event Relation','YSV652915311653',0,'UndecidedEventRelation','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ568763160675','CORS Allowed Origin List','YSV652915311653',0,'CorsWhitelistEntry','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ569486539409','Feed Poll Vote','YSV652915311653',0,'FeedPollVote','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ569642145716','Predefined Case Team','YSV652915311653',0,'CaseTeamTemplate','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ570808390686','Name','YSV652915311653',0,'Name','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ572205721001','Predefined Case Team Member','YSV652915311653',0,'CaseTeamTemplateMember','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ574839625111','Foldered Content Document','YSV652915311653',0,'FolderedContentDocument','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ576034272625','User Provisioning Account','YSV652915311653',0,'UserProvAccount','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ578247686454','Organization','YSV652915311653',0,'Organization','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ580157679114','Opportunity Partner','YSV652915311653',0,'OpportunityPartner','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ580530992317','External Event Mapping','YSV652915311653',0,'ExternalEventMapping','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ581156131420','User List View Criteria','YSV652915311653',0,'UserListViewCriterion','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ581246840376','Profile','YSV652915311653',0,'Profile','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ581847169046','Account','YSV652915311653',0,'Account','2023-12-02 10:46:29','IGH601244209893','2023-12-02 15:21:50','IGH601244209893',NULL),('ZEZ583217613941','Event Relation','YSV652915311653',0,'EventRelation','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ583270076273','Location Feed','YSV652915311653',0,'LocationFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ584468612991','Library','YSV652915311653',0,'ContentWorkspace','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ584733204528','Pitch','YSV652915311653',0,'revspiredemoani__Pitch__c','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ586683678055','Transaction Security Policy','YSV652915311653',0,'TransactionSecurityPolicy','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ586945520328','Work Order Line Item History','YSV652915311653',0,'WorkOrderLineItemHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ588289214845','Account Feed','YSV652915311653',0,'AccountFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ588748551521','Mobile Application Detail','YSV652915311653',0,'MobileApplicationDetail','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ592083727560','Flow Record Relation','YSV652915311653',0,'FlowRecordRelation','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ592619016386','Dashboard Component','YSV652915311653',0,'DashboardComponent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ594662394927','User Provisioning Config','YSV652915311653',0,'UserProvisioningConfig','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ597326901365','Process Instance History','YSV652915311653',0,'ProcessInstanceHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ599938786215','Apex Email Notification','YSV652915311653',0,'ApexEmailNotification','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ600027948244','Contract Contact Role','YSV652915311653',0,'ContractContactRole','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ600622288510','Lead Clean Info','YSV652915311653',0,'LeadCleanInfo','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ600845795683','Return Order History','YSV652915311653',0,'ReturnOrderHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ601961401851','Service Resource Skill Feed','YSV652915311653',0,'ServiceResourceSkillFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ603466204928','Chatter Extension Configuration','YSV652915311653',0,'ChatterExtensionConfig','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ603831249850','Library Document','YSV652915311653',0,'ContentWorkspaceDoc','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ605478624445','User Field Access','YSV652915311653',0,'UserFieldAccess','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ606080609006','Mail Merge Template','YSV652915311653',0,'MailmergeTemplate','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ617146431111','List Email Recipient Source','YSV652915311653',0,'ListEmailRecipientSource','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ619330633076','Case History','YSV652915311653',0,'CaseHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ619369982386','Service Provider SAML Attribute','YSV652915311653',0,'SPSamlAttributes','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ620255815442','Duplicate Record Item','YSV652915311653',0,'DuplicateRecordItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ623813497482','Client Browser','YSV652915311653',0,'ClientBrowser','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ627165370272','Asset Share','YSV652915311653',0,'AssetShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ630148761560','Quote Template Rich Text Data','YSV652915311653',0,'QuoteTemplateRichTextData','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ632544431492','Service Resource Skill History','YSV652915311653',0,'ServiceResourceSkillHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ634189207696','Permission Set License','YSV652915311653',0,'PermissionSetLicense','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ634454013438','Push Topic','YSV652915311653',0,'PushTopic','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ635482984254','Order Product Change Event','YSV652915311653',0,'OrderItemChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ640719737522','Campaign Member Status','YSV652915311653',0,'CampaignMemberStatus','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ641237705611','Share: Content','YSV652915311653',0,'revspiredemoani__Content__Share','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ643528190108','User Provisioning Mock Target','YSV652915311653',0,'UserProvMockTarget','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ646495853220','Custom URL','YSV652915311653',0,'DomainSite','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ647875263027','Operating Hours Feed','YSV652915311653',0,'OperatingHoursFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ647998535677','Login IP','YSV652915311653',0,'LoginIp','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ648754189394','UserAppMenuCustomization Share','YSV652915311653',0,'UserAppMenuCustomizationShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ651404929022','Share: Tag','YSV652915311653',0,'revspiredemoani__Tag__Share','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ653588020850','Action Link Group Template','YSV652915311653',0,'ActionLinkGroupTemplate','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ655205312794','Service Appointment Feed','YSV652915311653',0,'ServiceAppointmentFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ660702181663','Work Order Line Item Feed','YSV652915311653',0,'WorkOrderLineItemFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ660752050261','Change Event: Tag','YSV652915311653',0,'revspiredemoani__Tag__ChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ663956921234','Lightning Toggle Metrics','YSV652915311653',0,'LightningToggleMetrics','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ665619111307','Opportunity: Competitor','YSV652915311653',0,'OpportunityCompetitor','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ666538924598','Partner','YSV652915311653',0,'Partner','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ666697426388','Streaming Channel Share','YSV652915311653',0,'StreamingChannelShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ667298387425','Oauth Token','YSV652915311653',0,'OauthToken','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ671087728506','Last Used App','YSV652915311653',0,'UserAppInfo','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ671575706145','Service Territory Member Feed','YSV652915311653',0,'ServiceTerritoryMemberFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ671904055095','Group Feed','YSV652915311653',0,'CollaborationGroupFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ672436728767','Work Order','YSV652915311653',0,'WorkOrder','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ675638900766','Publisher','YSV652915311653',0,'Publisher','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ677602936212','Messaging Session Share','YSV652915311653',0,'MessagingSessionShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ680181104391','Document Entity Map','YSV652915311653',0,'DocumentAttachmentMap','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ680964686610','Quick Text History','YSV652915311653',0,'QuickTextHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ684132140766','Chatter Activity','YSV652915311653',0,'ChatterActivity','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ685283852447','Org Delete Request','YSV652915311653',0,'OrgDeleteRequest','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ691761948811','VoiceCallRecording','YSV652915311653',0,'VoiceCallRecording','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ697438378535','Declined Event Relation','YSV652915311653',0,'DeclinedEventRelation','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ699255780967','Email Message Relation','YSV652915311653',0,'EmailMessageRelation','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ699569716769','Data Assessment Field Value Metric','YSV652915311653',0,'DataAssessmentValueMetric','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ699913294705','Contract Status Value','YSV652915311653',0,'ContractStatus','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ700322461966','Third Party Account Link','YSV652915311653',0,'ThirdPartyAccountLink','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ700622261222','List View Chart','YSV652915311653',0,'ListViewChart','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ701290194597','Custom Object Usage By User License Metric','YSV652915311653',0,'CustomObjectUserLicenseMetrics','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ703785227335','Lead','YSV652915311653',0,'Lead','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ710491504249','Stamp','YSV652915311653',0,'Stamp','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ725355388340','List Email Share','YSV652915311653',0,'ListEmailShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ726212647487','Account Change Event','YSV652915311653',0,'AccountChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ726556506683','Note','YSV652915311653',0,'Note','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ727312152019','Messaging Session','YSV652915311653',0,'MessagingSession','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ732125183317','Asset Relationship History','YSV652915311653',0,'AssetRelationshipHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ736412388957','Apex Test Result Limit','YSV652915311653',0,'ApexTestResultLimits','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ742395587956','Lead Change Event','YSV652915311653',0,'LeadChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ744075949996','Cron Job','YSV652915311653',0,'CronJobDetail','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ749873817664','Process Node','YSV652915311653',0,'ProcessNode','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ752459864832','Price Book Entry','YSV652915311653',0,'PricebookEntry','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ754499915757','AuraDefinitionBundle Info','YSV652915311653',0,'AuraDefinitionBundleInfo','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ755863844188','Location History','YSV652915311653',0,'LocationHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ756898401077','Opportunity Field History','YSV652915311653',0,'OpportunityFieldHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ757490833994','Identity Verification History','YSV652915311653',0,'VerificationHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ759403387791','Dashboard Component Feed','YSV652915311653',0,'DashboardComponentFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ760599820650','Work Type','YSV652915311653',0,'WorkType','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ761336472593','Vote','YSV652915311653',0,'Vote','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ763162738422','Category Node','YSV652915311653',0,'CategoryNode','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ767902691631','Feed Signal','YSV652915311653',0,'FeedSignal','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ768676136404','Asset History','YSV652915311653',0,'AssetHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ769521442957','Case','YSV652915311653',0,'Case','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ769783607468','Task','YSV652915311653',0,'Task','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ772837281946','Content Version Rating','YSV652915311653',0,'ContentVersionRating','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ775092176882','External Event Mapping Share','YSV652915311653',0,'ExternalEventMappingShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ775337679101','List View','YSV652915311653',0,'ListView','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ775924709416','Lead Feed','YSV652915311653',0,'LeadFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ776613416872','Price Book','YSV652915311653',0,'Pricebook2','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ781413514894','Order Share','YSV652915311653',0,'OrderShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ781423317995','Tenant Usage Entitlement','YSV652915311653',0,'TenantUsageEntitlement','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ783624744771','Sensitive Data Rule','YSV652915311653',0,'LiveChatSensitiveDataRule','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ785707790204','Site','YSV652915311653',0,'SiteFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ786792265983','List Email Change Event','YSV652915311653',0,'ListEmailChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ788846402231','Topic User Event','YSV652915311653',0,'TopicUserEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ789028554026','Session Permission Set Activation','YSV652915311653',0,'SessionPermSetActivation','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ789041138988','Content Workspace Subscription','YSV652915311653',0,'ContentWorkspaceSubscription','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ790859211971','Custom S-Control','YSV652915311653',0,'Scontrol','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ791326385727','Outgoing Email Relation','YSV652915311653',0,'OutgoingEmailRelation','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ792211518428','Lightning Usage By App Type Metrics','YSV652915311653',0,'LightningUsageByAppTypeMetrics','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ792420869499','Service Resource Skill','YSV652915311653',0,'ServiceResourceSkill','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ792648768789','Entitlement Feed','YSV652915311653',0,'EntitlementFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ797292410206','Individual Share','YSV652915311653',0,'IndividualShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ811389124775','User Record Access','YSV652915311653',0,'UserRecordAccess','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ814408893523','Note, Attachment, Google Doc And File','YSV652915311653',0,'CombinedAttachment','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ814586125140','Flow Interview','YSV652915311653',0,'FlowInterview','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ815760580650','Assigned Resource','YSV652915311653',0,'AssignedResource','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ816460016943','Price Book History','YSV652915311653',0,'Pricebook2History','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ817240221254','Resource Absence Feed','YSV652915311653',0,'ResourceAbsenceFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ817383157849','Change Event: Revspire Table Identifier','YSV652915311653',0,'revspiredemoani__Revspire_Table_Identifier__ChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ817589470014','Data Assessment Field Metric','YSV652915311653',0,'DataAssessmentFieldMetric','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ817751395345','Custom Permission','YSV652915311653',0,'CustomPermission','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ819014301354','Event Change Event','YSV652915311653',0,'EventChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ819686328823','Service Contract History','YSV652915311653',0,'ServiceContractHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ819848971272','Contract Feed','YSV652915311653',0,'ContractFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ820580485108','Apex Test Suite','YSV652915311653',0,'ApexTestSuite','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ823248470036','Product History','YSV652915311653',0,'Product2History','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ823404968550','Quick Text','YSV652915311653',0,'QuickText','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ824578078299','Topic Assignment','YSV652915311653',0,'TopicAssignment','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ829480779197','Aura Component Bundle','YSV652915311653',0,'AuraDefinitionBundle','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ830972427344','Change Owner Option Info','YSV652915311653',0,'OwnerChangeOptionInfo','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ832732714556','Task Status Value','YSV652915311653',0,'TaskStatus','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ833222591162','Content Document Link','YSV652915311653',0,'ContentDocumentLink','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ834084933468','Object Milestone','YSV652915311653',0,'EntityMilestone','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ838124856201','Chatter Invitation','YSV652915311653',0,'CollaborationInvitation','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ838223674183','Trusted URL','YSV652915311653',0,'CspTrustedSite','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ843750181461','Messaging User','YSV652915311653',0,'MessagingEndUser','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ844144566769','RecordAction','YSV652915311653',0,'RecordAction','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ846560571198','Application','YSV652915311653',0,'UserAppMenuItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ848825788915','Task Change Event','YSV652915311653',0,'TaskChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ850585170881','Opportunity Product','YSV652915311653',0,'OpportunityLineItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ850720090651','Feed Poll Choice','YSV652915311653',0,'FeedPollChoice','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ853411989149','Opportunity Feed','YSV652915311653',0,'OpportunityFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ854430055109','Case Comment','YSV652915311653',0,'CaseComment','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ854962976513','Assignment Rule','YSV652915311653',0,'AssignmentRule','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ858949086496','Data.com Contact','YSV652915311653',0,'DatacloudContact','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ859003342555','Messaging User Share','YSV652915311653',0,'MessagingEndUserShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ864134995139','History: Pitch','YSV652915311653',0,'revspiredemoani__Pitch__History','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ865483119957','Service Appointment History','YSV652915311653',0,'ServiceAppointmentHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ865907546007','Setup Entity Access','YSV652915311653',0,'SetupEntityAccess','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ866133458786','Business Process','YSV652915311653',0,'BusinessProcess','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ867720836649','Order Change Event','YSV652915311653',0,'OrderChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ871732327035','Group','YSV652915311653',0,'Group','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ873274907350','Macro History','YSV652915311653',0,'MacroHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ874326195449','User Provisioning Account Staging','YSV652915311653',0,'UserProvAccountStaging','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ875578988226','Site History','YSV652915311653',0,'SiteHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ876828046399','Tag','YSV652915311653',0,'revspiredemoani__Tag__c','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ879953612460','Login Event','YSV652915311653',0,'LoginEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ885521761034','Account Clean Info','YSV652915311653',0,'AccountCleanInfo','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ886556649474','Service Territory Feed','YSV652915311653',0,'ServiceTerritoryFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ886589929354','Entity Subscription','YSV652915311653',0,'EntitySubscription','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ888704985275','Voice Vendor Info','YSV652915311653',0,'VoiceVendorInfo','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ890124766984','Topic','YSV652915311653',0,'Topic','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ893019909869','User Feed','YSV652915311653',0,'UserFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ893363362078','Campaign','YSV652915311653',0,'Campaign','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ894062828173','Voice Call Share','YSV652915311653',0,'VoiceCallShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ901748224069','Action Link Template','YSV652915311653',0,'ActionLinkTemplate','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ902451604512','Associated Location History','YSV652915311653',0,'AssociatedLocationHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ902848361899','Service Territory Member History','YSV652915311653',0,'ServiceTerritoryMemberHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ906965963454','User Package License','YSV652915311653',0,'UserPackageLicense','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ907917242410','Apex Test Queue Item','YSV652915311653',0,'ApexTestQueueItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ908027820202','Matching Rule Item','YSV652915311653',0,'MatchingRuleItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ916344315666','Login History','YSV652915311653',0,'LoginHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ917817778807','Asset Change Event','YSV652915311653',0,'AssetChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ918315973987','Folder','YSV652915311653',0,'Folder','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ919554747565','FileSearchActivity','YSV652915311653',0,'FileSearchActivity','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ925231274146','User List View','YSV652915311653',0,'UserListView','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ928874414346','Identity Provider Event Log','YSV652915311653',0,'IdpEventLog','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ931761430511','Authentication Configuration Auth. Provider','YSV652915311653',0,'AuthConfigProviders','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ933519665088','Data Type','YSV652915311653',0,'DataType','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ934608558131','Quick Text Share','YSV652915311653',0,'QuickTextShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ934778152903','Task Feed','YSV652915311653',0,'TaskFeed','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ935939151733','Service Resource History','YSV652915311653',0,'ServiceResourceHistory','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ939451332146','Asset Token Event','YSV652915311653',0,'AssetTokenEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ944056463374','Idea','YSV652915311653',0,'Idea','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ948190325821','Duplicate Rule','YSV652915311653',0,'DuplicateRule','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ949289620805','Content Notification','YSV652915311653',0,'ContentNotification','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ952621087386','Work Order Line Item Status Value','YSV652915311653',0,'WorkOrderLineItemStatus','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ953696121417','Feed Tracked Change','YSV652915311653',0,'FeedTrackedChange','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ954499241852','Document','YSV652915311653',0,'Document','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ955577049362','Entitlement Process','YSV652915311653',0,'SlaProcess','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ963317993061','AppMenuItem','YSV652915311653',0,'AppMenuItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ969186859175','Lightning Usage By Browser Metrics','YSV652915311653',0,'LightningUsageByBrowserMetrics','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ972506076070','D&B Company','YSV652915311653',0,'DatacloudDandBCompany','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ974353694332','Case Contact Role','YSV652915311653',0,'CaseContactRole','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ975208845896','Return Order Line Item','YSV652915311653',0,'ReturnOrderLineItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ976359098195','Order','YSV652915311653',0,'Order','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ977346612118','Service Contract','YSV652915311653',0,'ServiceContract','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ977978079558','Permission Set Group','YSV652915311653',0,'PermissionSetGroup','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ978967915268','Resource Absence','YSV652915311653',0,'ResourceAbsence','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ980470392833','Contact Change Event','YSV652915311653',0,'ContactChangeEvent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ984886423669','Custom Permission Dependency','YSV652915311653',0,'CustomPermissionDependency','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ987745838227','Individual','YSV652915311653',0,'Individual','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ989018705662','Return Order Share','YSV652915311653',0,'ReturnOrderShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ989741854359','Site','YSV652915311653',0,'Site','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ993779861361','Order Product','YSV652915311653',0,'OrderItem','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ994621228420','Visualforce Component','YSV652915311653',0,'ApexComponent','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ994994407514','Macro Share','YSV652915311653',0,'MacroShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ996742160055','Role','YSV652915311653',0,'UserRole','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL),('ZEZ998099056069','Case Share','YSV652915311653',0,'CaseShare','2023-12-02 10:46:29','IGH601244209893','2023-12-02 10:46:29','IGH601244209893',NULL);
/*!40000 ALTER TABLE `salesforce_object` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesforce_object_before_insert` BEFORE INSERT ON `salesforce_object` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'salesforce_object' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;

--
-- Table structure for table `salesforce_sync_change_type`
--

DROP TABLE IF EXISTS `salesforce_sync_change_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesforce_sync_change_type` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesforce_sync_change_type`
--

LOCK TABLES `salesforce_sync_change_type` WRITE;
/*!40000 ALTER TABLE `salesforce_sync_change_type` DISABLE KEYS */;
INSERT INTO `salesforce_sync_change_type` VALUES ('ZPB187362527649','Update'),('ZPB650722971791','Insert'),('ZPB984643753602','Delete');
/*!40000 ALTER TABLE `salesforce_sync_change_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesforce_sync_change_type_before_insert` BEFORE INSERT ON `salesforce_sync_change_type` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'salesforce_sync_change_type' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `salesforce_sync_error`
--

DROP TABLE IF EXISTS `salesforce_sync_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesforce_sync_error` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salesforce_sync_operation` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `error_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ salesforce_sync_error_salesforce_sync_operation_idx` (`salesforce_sync_operation`),
  CONSTRAINT `fk_ salesforce_sync_error_salesforce_sync_operation` FOREIGN KEY (`salesforce_sync_operation`) REFERENCES `salesforce_sync_operation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesforce_sync_error`
--

LOCK TABLES `salesforce_sync_error` WRITE;
/*!40000 ALTER TABLE `salesforce_sync_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `salesforce_sync_error` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesforce_sync_error_before_insert` BEFORE INSERT ON `salesforce_sync_error` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'salesforce_sync_error' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `salesforce_sync_operation`
--

DROP TABLE IF EXISTS `salesforce_sync_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesforce_sync_operation` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `record_id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sync_change_type` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_salesforce_sync_operation_status_idx` (`status`),
  KEY `fk_salesforce_sync_operation_change_type_idx` (`sync_change_type`),
  KEY `fk_salesforce_sync_operation_created_by_idx` (`created_by`),
  CONSTRAINT `fk_salesforce_sync_operation_change_type` FOREIGN KEY (`sync_change_type`) REFERENCES `salesforce_sync_change_type` (`id`),
  CONSTRAINT `fk_salesforce_sync_operation_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_salesforce_sync_operation_status` FOREIGN KEY (`status`) REFERENCES `salesforce_sync_operation_status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesforce_sync_operation`
--

LOCK TABLES `salesforce_sync_operation` WRITE;
/*!40000 ALTER TABLE `salesforce_sync_operation` DISABLE KEYS */;
INSERT INTO `salesforce_sync_operation` VALUES ('MAS015710392981','WRS979112806709','ZPB650722971791','HIV851724848943','2023-12-12 15:16:17','IGH141585754362'),('MAS032783380740','KBD679125371089','ZPB650722971791','HIV361131215804','2023-12-16 07:38:02','IGH141585754362'),('MAS037698430044','KBD857193409331','ZPB650722971791','HIV361131215804','2023-12-16 14:21:32','IGH141585754362'),('MAS097503619359','WRS695055681927','ZPB650722971791','HIV851724848943','2023-12-12 15:55:48','IGH141585754362'),('MAS104004525676','KBD813530717801','ZPB650722971791','HIV361131215804','2023-12-16 07:22:25','IGH141585754362'),('MAS259257058854','WRS940214447620','ZPB187362527649','HIV851724848943','2023-12-12 15:32:01','IGH141585754362'),('MAS274293008515','WRS871042950889','ZPB187362527649','HIV851724848943','2023-12-12 15:18:52','IGH141585754362'),('MAS278894163927','WRS765168112483','ZPB187362527649','HIV851724848943','2023-12-12 15:32:01','IGH141585754362'),('MAS287414174794','KBD798184891042','ZPB650722971791','HIV361131215804','2023-12-16 15:02:51','IGH141585754362'),('MAS297359221891','WRS695055681927','ZPB187362527649','HIV851724848943','2023-12-12 15:55:59','IGH141585754362'),('MAS305058755264','KBD449513637878','ZPB650722971791','HIV361131215804','2023-12-16 14:15:36','IGH141585754362'),('MAS350338664231','KBD042516231576','ZPB650722971791','HIV361131215804','2023-12-16 15:03:11','IGH141585754362'),('MAS378404597172','WRS871042950889','ZPB650722971791','HIV851724848943','2023-12-12 15:18:43','IGH141585754362'),('MAS395056566591','WRS402351081745','ZPB187362527649','HIV851724848943','2023-12-12 15:58:40','IGH141585754362'),('MAS425573656731','KBD185702286833','ZPB650722971791','HIV361131215804','2023-12-12 16:08:38','IGH141585754362'),('MAS445335583244','WRS141213575509','ZPB187362527649','HIV851724848943','2023-12-12 15:17:48','IGH141585754362'),('MAS463335289119','KBD491651982526','ZPB650722971791','HIV361131215804','2023-12-16 07:43:03','IGH141585754362'),('MAS489858634294','WRS222406632473','ZPB187362527649','HIV851724848943','2023-12-12 15:39:03','IGH141585754362'),('MAS500979269389','WRS695055681927','ZPB187362527649','HIV851724848943','2023-12-12 16:04:55','IGH141585754362'),('MAS520243020280','WRS459602833221','ZPB650722971791','HIV851724848943','2023-12-12 15:32:20','IGH141585754362'),('MAS527149523167','KBD265067218118','ZPB650722971791','HIV361131215804','2023-12-16 14:58:09','IGH141585754362'),('MAS551304132259','WRS222406632473','ZPB650722971791','HIV851724848943','2023-12-12 15:38:51','IGH141585754362'),('MAS634392639280','WRS475624162214','ZPB650722971791','HIV851724848943','2023-12-12 14:08:12','IGH141585754362'),('MAS654252942328','WRS459602833221','ZPB187362527649','HIV851724848943','2023-12-12 15:32:32','IGH141585754362'),('MAS657647887856','KBD312682510644','ZPB650722971791','HIV361131215804','2023-12-16 14:17:15','IGH141585754362'),('MAS658936729336','WRS141213575509','ZPB650722971791','HIV851724848943','2023-12-12 15:17:39','IGH141585754362'),('MAS666517276936','KBD245341655095','ZPB650722971791','HIV361131215804','2023-12-16 07:54:07','IGH141585754362'),('MAS719244581385','WRS402351081745','ZPB650722971791','HIV851724848943','2023-12-12 15:58:30','IGH141585754362'),('MAS745090740494','WRS475624162214','ZPB187362527649','HIV851724848943','2023-12-12 14:09:32','IGH141585754362'),('MAS773064696949','WRS871042950889','ZPB187362527649','HIV851724848943','2023-12-12 16:03:41','IGH141585754362'),('MAS788114748697','WRS389169692423','ZPB650722971791','HIV851724848943','2023-12-12 16:02:52','IGH141585754362'),('MAS792591607004','WRS089300794610','ZPB650722971791','HIV851724848943','2023-12-12 15:50:51','IGH141585754362'),('MAS822275815365','WRS475624162214','ZPB984643753602','HIV851724848943','2023-12-12 14:10:02','IGH141585754362'),('MAS914715506056','WRS089300794610','ZPB187362527649','HIV851724848943','2023-12-12 15:51:04','IGH141585754362'),('MAS968588232032','KBD176752893418','ZPB650722971791','HIV361131215804','2023-12-16 14:16:58','IGH141585754362'),('MAS973274183433','WRS389169692423','ZPB187362527649','HIV851724848943','2023-12-12 16:03:01','IGH141585754362');
/*!40000 ALTER TABLE `salesforce_sync_operation` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesforce_sync_operation_before_insert` BEFORE INSERT ON `salesforce_sync_operation` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'salesforce_sync_operation' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `salesforce_sync_operation_status`
--

DROP TABLE IF EXISTS `salesforce_sync_operation_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesforce_sync_operation_status` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesforce_sync_operation_status`
--

LOCK TABLES `salesforce_sync_operation_status` WRITE;
/*!40000 ALTER TABLE `salesforce_sync_operation_status` DISABLE KEYS */;
INSERT INTO `salesforce_sync_operation_status` VALUES ('HIV175230628042','Failure'),('HIV361131215804','Pending'),('HIV851724848943','Success');
/*!40000 ALTER TABLE `salesforce_sync_operation_status` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salesforce_sync_operation_status_before_insert` BEFORE INSERT ON `salesforce_sync_operation_status` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'salesforce_sync_operation_status' LIMIT 1;
    
    -- Generate a 12-character unique string. This example uses a simple random number for demonstration.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tableidentifier`
--

DROP TABLE IF EXISTS `tableidentifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tableidentifier` (
  `id` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tablename` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salesforce_api_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tableidentifier`
--

LOCK TABLES `tableidentifier` WRITE;
/*!40000 ALTER TABLE `tableidentifier` DISABLE KEYS */;
INSERT INTO `tableidentifier` VALUES ('BNL','audit_log',NULL),('DMA','fieldidentifier',NULL),('DYJ','pitch','revspiredemoani__RevSpire_Pitch__c'),('HIV','salesforce_sync_operation_status',NULL),('HVH','profile_permission',NULL),('HXP','pitch_content','revspiredemoani__RevSpire_Pitch_Content__c'),('IGH','user',NULL),('IIT','tableidentifier',NULL),('KBD','content','revspiredemoani__RevSpire_Content__c'),('LER','permission',NULL),('MAS','salesforce_sync_operation',NULL),('NSY','salesforce_field',NULL),('OFL','salesforce_sync_error',NULL),('PDX','organisation',NULL),('PEA','reference_field_level_one',NULL),('PGK','profile',NULL),('UPR','tag','revspiredemoani__RevSpire_Tag__c'),('WRS','folder','revspiredemoani__RevSpire_Folder__c'),('YKE','tag_condition','revspiredemoani__RevSpire_Tag_Condition__c'),('YSV','crm_connection',NULL),('ZEZ','salesforce_object',NULL),('ZPB','salesforce_sync_change_type',NULL);
/*!40000 ALTER TABLE `tableidentifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `salesforce_query` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dynamics_query` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `salesforce_primary_object` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dynamics_primary_object` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tag_created_by_idx` (`created_by`),
  KEY `fk_tag_updated_by` (`updated_by`),
  CONSTRAINT `fk_tag_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_tag_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES ('UPR171817066307','2023-10-28 18:15:46','2023-10-28 18:15:46','IGH141585754362','IGH141585754362','NewTag1',NULL,NULL,NULL,NULL),('UPR340023408960','2023-10-28 18:14:55','2023-10-28 18:14:55','IGH141585754362','IGH141585754362','NewTag',NULL,NULL,'Opportunity',NULL),('UPR677382590879','2023-10-28 16:11:33','2023-10-28 17:35:55','IGH141585754362','IGH141585754362','UpdatedTagName',NULL,NULL,'Opportunity',NULL);
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tag_before_insert` BEFORE INSERT ON `tag` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'tag' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_tag` AFTER INSERT ON `tag` FOR EACH ROW BEGIN
    DECLARE insertTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Insert' from the salesforce_sync_change_type table
    SELECT id INTO insertTypeId FROM salesforce_sync_change_type WHERE name = 'Insert';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (NEW.id, insertTypeId, pendingStatusId, NEW.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_tag` AFTER UPDATE ON `tag` FOR EACH ROW BEGIN
    DECLARE updateTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Update' from the salesforce_sync_change_type table
    SELECT id INTO updateTypeId FROM salesforce_sync_change_type WHERE name = 'Update';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (NEW.id, updateTypeId, pendingStatusId, NEW.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_delete_tag` BEFORE DELETE ON `tag` FOR EACH ROW BEGIN
    DECLARE deleteTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Delete' from the salesforce_sync_change_type table (using 'name' field)
    SELECT id INTO deleteTypeId FROM salesforce_sync_change_type WHERE name = 'Delete';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table (using 'name' field)
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (OLD.id, deleteTypeId, pendingStatusId, OLD.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tag_condition`
--

DROP TABLE IF EXISTS `tag_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag_condition` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `operator` enum('Equals','Not Equals','Greater Than or Equals','Lesser Than or Equals','Greater Than','Lesser Than','Between','Null','Not Null','True','False') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tag` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `field` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tagconditions_created_by` (`created_by`),
  KEY `fk_tagconditions_updated_by` (`updated_by`),
  KEY `fk_tagconditions_tag_idx` (`tag`),
  CONSTRAINT `fk_tagconditions_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_tagconditions_tag` FOREIGN KEY (`tag`) REFERENCES `tag` (`id`),
  CONSTRAINT `fk_tagconditions_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_condition`
--

LOCK TABLES `tag_condition` WRITE;
/*!40000 ALTER TABLE `tag_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_condition` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tagconditions_before_insert` BEFORE INSERT ON `tag_condition` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'tagconditions' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_tag_condition` AFTER INSERT ON `tag_condition` FOR EACH ROW BEGIN
    DECLARE insertTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Insert' from the salesforce_sync_change_type table
    SELECT id INTO insertTypeId FROM salesforce_sync_change_type WHERE name = 'Insert';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (NEW.id, insertTypeId, pendingStatusId, NEW.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_tag_condition` AFTER UPDATE ON `tag_condition` FOR EACH ROW BEGIN
    DECLARE updateTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Update' from the salesforce_sync_change_type table
    SELECT id INTO updateTypeId FROM salesforce_sync_change_type WHERE name = 'Update';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (NEW.id, updateTypeId, pendingStatusId, NEW.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_delete_tag_condition` BEFORE DELETE ON `tag_condition` FOR EACH ROW BEGIN
    DECLARE deleteTypeId VARCHAR(255);
    DECLARE pendingStatusId VARCHAR(255);

    -- Fetch the ID for 'Delete' from the salesforce_sync_change_type table (using 'name' field)
    SELECT id INTO deleteTypeId FROM salesforce_sync_change_type WHERE name = 'Delete';

    -- Fetch the ID for 'Pending' from the salesforce_sync_operation_status table (using 'name' field)
    SELECT id INTO pendingStatusId FROM salesforce_sync_operation_status WHERE name = 'Pending';

    -- Insert a new record into the salesforce_sync_operation table
    INSERT INTO salesforce_sync_operation (record_id, sync_change_type, status, created_by)
    VALUES (OLD.id, deleteTypeId, pendingStatusId, OLD.created_by);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated_by` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_login_date` datetime DEFAULT NULL,
  `organisation` char(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_password_change_reset` datetime DEFAULT NULL,
  `profile` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `reset_token` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reset_token_expires` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `created_by_userID_idx` (`created_by`),
  KEY `fk_user_profile` (`profile`),
  KEY `fk_user_company` (`organisation`),
  KEY `fk_user_updated_by` (`updated_by`),
  CONSTRAINT `fk_user_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_user_organisation` FOREIGN KEY (`organisation`) REFERENCES `organisation` (`id`),
  CONSTRAINT `fk_user_profile` FOREIGN KEY (`profile`) REFERENCES `profile` (`id`),
  CONSTRAINT `fk_user_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('IGH024724845797','2023-11-13 14:03:17','2023-11-20 17:21:05','IGH024724845797','IGH024724845797','System','Global',1,'$2b$10$mv8GbIcwCTA7t95rLhoGm.FRlZH7jinaREltesRwceyRMJqMb6HWC',NULL,'PDX436422222699','2023-11-13 22:33:40','PGK803996314111','system.global@revspire.net','anirudh.krishnan@revspire.net',NULL,NULL),('IGH141585754362','2023-10-26 13:06:01','2023-12-16 17:02:51','IGH141585754362','IGH141585754362','Anirudh','Krishnan',1,'$2b$10$AvnM4k8/2cDBEHvHynAiquhczGwjRfaJrqr/mhk23PjniPauY2bG.',NULL,'PDX436422222699',NULL,'PGK803996314111','a.b@c.com','anirudhkrishnan59@gmail.com','9f6e50a81310fa9b457d39ab26a70ba6973034ec','2023-12-16 18:02:51'),('IGH316945961040','2023-10-26 15:00:54','2023-11-13 22:13:19','IGH141585754362','IGH141585754362','John1','Updated1',0,'new123SecurePassword123',NULL,'PDX436422222699',NULL,'PGK710714933192','a.g@c.com','system.global@revspire.net',NULL,NULL),('IGH601244209893','2023-10-26 15:10:05','2023-11-13 22:13:19','IGH141585754362','IGH141585754362','Teja','Sai1',0,'securassword123',NULL,'PDX436422222699',NULL,'PGK710714933192','a.b@m.com','system.global@revspire.net',NULL,NULL),('IGH648649336442','2023-11-16 17:17:35','2023-11-16 17:19:42','IGH141585754362','IGH141585754362','new','User',1,'$2b$10$v4vM009TWv/GWheNwuflY.7U4kb9DnD9z5cPlP433R6ikN.oRjXCy',NULL,'PDX436422222699','2023-11-16 17:19:42','PGK803996314111','a.m@c.com','a.m@c.com',NULL,NULL),('IGH687267747415','2023-10-30 10:45:33','2023-11-13 22:13:19','IGH141585754362','IGH141585754362','Hello','Reddy',1,'password123',NULL,'PDX436422222699',NULL,'PGK068294406932','anirudh.k@g.com','system.global@revspire.net',NULL,NULL),('IGH846177043249','2023-10-27 12:05:54','2023-11-24 15:44:55','IGH141585754362','IGH141585754362','Jane','Doe',1,'SecurePassword123',NULL,'PDX436422222699',NULL,'PGK068294406932','a.j@kl.com','sreddygouni@gmail.com','4e61974b2cdc873431c732438ca4e9ec0844db43','2023-11-24 16:44:55');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `user_before_insert` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
    DECLARE tableID CHAR(3);
    DECLARE uniqueID CHAR(12);
    
    -- Fetch the table's 3-character identifier
    SELECT id INTO tableID FROM tableidentifier WHERE tablename = 'user' LIMIT 1;
    
    -- Generate a 12-character unique string.
    SET uniqueID = LPAD(FLOOR(RAND() * 999999999999), 12, '0');
    
    -- Set the new row's id field to the 15-character identifier
    SET NEW.id = CONCAT(tableID, uniqueID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;

--
-- Dumping events for database 'revspire_db'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `SyncTableIdentifierEvent` */;
DELIMITER ;;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `SyncTableIdentifierEvent` ON SCHEDULE EVERY 30 SECOND STARTS '2023-10-26 10:38:55' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    CALL SyncTableIdentifier();
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
ALTER DATABASE `revspire_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci ;;
/*!50106 DROP EVENT IF EXISTS `UpdateFieldAttributesEvent` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `UpdateFieldAttributesEvent` ON SCHEDULE EVERY 5 SECOND STARTS '2023-12-04 13:26:49' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    CALL UpdateFieldAttributes();
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `updateSalesforceLookupFieldMapEvent` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `updateSalesforceLookupFieldMapEvent` ON SCHEDULE EVERY 30 SECOND STARTS '2023-12-13 11:27:01' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    CALL UpdateSalesforceLookupFieldMap();
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'revspire_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `SyncTableIdentifier` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SyncTableIdentifier`()
BEGIN
    DECLARE newID CHAR(3);
    DECLARE done INT DEFAULT 0;
    DECLARE curTableName VARCHAR(255);
    DECLARE cur CURSOR FOR 
    SELECT table_name 
    FROM information_schema.tables 
    WHERE table_schema = 'revspire_db' AND BINARY table_name NOT IN (
        SELECT BINARY tablename FROM tableidentifier
    );

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Drop the temporary table if it exists
    DROP TEMPORARY TABLE IF EXISTS Temp1lete;

    -- Create a temporary table to store IDs for deletion
    CREATE TEMPORARY TABLE Temp1lete (id CHAR(3) PRIMARY KEY);

    -- Populate temporary table with IDs of tables to delete
    INSERT INTO Temp1lete (id)
    SELECT ti.id FROM tableidentifier ti 
    WHERE BINARY ti.tablename NOT IN (
        SELECT BINARY table_name FROM information_schema.tables 
        WHERE table_schema = 'revspire_db'
    );

    -- Delete entries from tableidentifier that no longer exist in the database
    -- The JOIN uses a key column to comply with safe update mode
    DELETE ti FROM tableidentifier ti 
    JOIN Temp1lete tmp ON BINARY ti.id = BINARY tmp.id
    WHERE ti.id = tmp.id;

    -- Open cursor to add new tables to tableidentifier
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO curTableName;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Generate a new random ID
        SET newID = CONCAT(CHAR(FLOOR(65 + RAND() * 26)), CHAR(FLOOR(65 + RAND() * 26)), CHAR(FLOOR(65 + RAND() * 26)));
        -- Ensure the new ID is unique
        WHILE EXISTS(
            SELECT id FROM tableidentifier WHERE BINARY id = BINARY newID
        ) DO
            SET newID = CONCAT(CHAR(FLOOR(65 + RAND() * 26)), CHAR(FLOOR(65 + RAND() * 26)), CHAR(FLOOR(65 + RAND() * 26)));
        END WHILE;

        -- Insert new table identifier into tableidentifier
        INSERT INTO tableidentifier (id, tablename) VALUES (newID, curTableName);
    END LOOP;
    CLOSE cur;

    -- Drop the temporary table
    DROP TEMPORARY TABLE Temp1lete;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateFieldAttributes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateFieldAttributes`()
BEGIN
    -- Temporary table to store current database structure
    CREATE TEMPORARY TABLE IF NOT EXISTS CurrentDBStructure (
        TableName CHAR(255),
        ColumnName CHAR(255),
        TableID CHAR(255)
    );

    -- Clear the temporary table
    TRUNCATE TABLE CurrentDBStructure;

    -- Populate temporary table with current database structure
    INSERT INTO CurrentDBStructure (TableName, ColumnName, TableID)
    SELECT t.table_name, c.column_name, ti.id
    FROM information_schema.tables AS t
    JOIN information_schema.columns AS c ON t.table_name = c.table_name
    JOIN revspire_db.tableidentifier AS ti ON t.table_name = ti.tablename
    WHERE t.table_schema = 'revspire_db';

    -- Insert new columns into field_attribute
    INSERT INTO revspire_db.fieldidentifier (name, `table`)
    SELECT cs.ColumnName, cs.TableID
    FROM CurrentDBStructure AS cs
    LEFT JOIN revspire_db.fieldidentifier AS fa ON cs.ColumnName = fa.name AND cs.TableID = fa.`table`
    WHERE fa.name IS NULL;

    -- Prepare a list of IDs to delete
    CREATE TEMPORARY TABLE IF NOT EXISTS IDsToDelete (
        id CHAR(255)
    );

    -- Populate IDsToDelete
    INSERT INTO IDsToDelete (id)
    SELECT fa.id
    FROM revspire_db.fieldidentifier fa
    LEFT JOIN CurrentDBStructure cs ON fa.name = cs.ColumnName AND fa.`table` = cs.TableID
    WHERE cs.ColumnName IS NULL AND cs.TableID IS NULL;

    -- Delete removed columns from field_attribute using a key column in WHERE clause
    DELETE FROM revspire_db.fieldidentifier
    WHERE id IN (SELECT id FROM IDsToDelete);

    -- Cleanup temporary tables
    DROP TABLE CurrentDBStructure;
    DROP TABLE IDsToDelete;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-20 12:08:07
