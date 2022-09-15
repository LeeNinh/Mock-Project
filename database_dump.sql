-- MySQL dump 10.13  Distrib 8.0.30, for macos12 (x86_64)
--
-- Host: 127.0.0.1    Database: duonglien
-- ------------------------------------------------------
-- Server version	5.7.39

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
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `bill_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `user_note` longtext COLLATE utf8_unicode_ci,
  `admin_note` longtext COLLATE utf8_unicode_ci,
  `total_quantity` int(11) DEFAULT NULL COMMENT 'tổng số lượng sản phẩm trong đơn',
  `total_price` decimal(12,0) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT 'Trạng thái đơn hàng: 1:  Chờ đặt, 2:  Đã đặt, 3:  Về kho vn, 4:  Đã xuất hóa đơn cho khách, 5: Đã hủy, 6: Chưa về đủ',
  `discount` decimal(12,0) DEFAULT NULL COMMENT 'Giảm giá',
  PRIMARY KEY (`bill_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1614872872096 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (1614872872095,1610880442341,1614872436661,'2021-03-04 15:47:52','User note','đây là note của admin nha',50,0,2,NULL);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill_detail`
--

DROP TABLE IF EXISTS `bill_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_detail` (
  `bill_detail_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bill_id` bigint(20) DEFAULT NULL,
  `corlor_id` bigint(20) DEFAULT NULL,
  `size_id` bigint(20) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL COMMENT 'Số lượng hàng khách đặt',
  `product_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`bill_detail_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_detail`
--

LOCK TABLES `bill_detail` WRITE;
/*!40000 ALTER TABLE `bill_detail` DISABLE KEYS */;
INSERT INTO `bill_detail` VALUES (1,1614872872095,12,21,20,1614872436661),(2,1614872872095,13,25,30,1614872436661);
/*!40000 ALTER TABLE `bill_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1614265147882 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1612853982682,'Áo người lớn Nam','/image?fileName=quanAoNam.jpg'),(1613740192333,'Áo trẻ em','/image?fileName=abc.jpg');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `contact_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contact_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_message` longtext COLLATE utf8_unicode_ci,
  `contact_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1612576417938 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (1612576417937,'duyhung','web site đẹp',' abc','2021-02-06 01:53:38'),(1612576274724,'duyhung','web site đẹp',' abc','2021-02-06 01:51:15');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_url`
--

DROP TABLE IF EXISTS `image_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image_url` (
  `image_url_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `image_name` varchar(128) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`image_url_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_url`
--

LOCK TABLES `image_url` WRITE;
/*!40000 ALTER TABLE `image_url` DISABLE KEYS */;
INSERT INTO `image_url` VALUES (27,'abc.jpg','/image?fileName=abc.jpg'),(28,'cacSanPhanTienIchKhac.jpg','/image?fileName=cacSanPhanTienIchKhac.jpg'),(29,'giayDepBoMe.jpg','/image?fileName=giayDepBoMe.jpg'),(30,'giayDepChoBe.jpg','/image?fileName=giayDepChoBe.jpg'),(31,'phuKienBoMe.jpg','/image?fileName=phuKienBoMe.jpg'),(32,'phuKienChoBe.jpg','/image?fileName=phuKienChoBe.jpg'),(33,'quanAoBeGai.jpg','/image?fileName=quanAoBeGai.jpg'),(34,'quanAoNam.jpg','/image?fileName=quanAoNam.jpg'),(35,'quanAoNguoiLon.jpg','/image?fileName=quanAoNguoiLon.jpg'),(36,'quanAoNu.jpg','/image?fileName=quanAoNu.jpg'),(38,'5.png','/image?fileName=5.png'),(39,'17.png','/image?fileName=17.png'),(40,'acoustic1.jpg','/image?fileName=acoustic1.jpg');
/*!40000 ALTER TABLE `image_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `introduce`
--

DROP TABLE IF EXISTS `introduce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `introduce` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `news_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_intro_news_id` (`news_id`),
  CONSTRAINT `fk_intro_news_id` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `introduce`
--

LOCK TABLES `introduce` WRITE;
/*!40000 ALTER TABLE `introduce` DISABLE KEYS */;
INSERT INTO `introduce` VALUES (1,22);
/*!40000 ALTER TABLE `introduce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `title` text,
  `content` longtext,
  `created_at` timestamp NULL DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `thumbnail` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (4,1,'Why do we use it?','<p><strong>It is a long </strong>established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using &#39;Content here, content here&#39;, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for &#39;lorem ipsum&#39; will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>\r\n','2021-02-19 17:12:08','2021-02-19 17:12:09',NULL),(5,1,'Where does it come from?','<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of &quot;de Finibus Bonorum et Malorum&quot; (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, &quot;Lorem ipsum dolor sit amet..&quot;, comes from a line in section 1.10.32.</p>\r\n\r\n<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from &quot;de Finibus Bonorum et Malorum&quot; by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>\r\n','2021-02-19 15:37:23',NULL,NULL),(6,1,'Where can I get some?','<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don&#39;t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn&#39;t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>\r\n','2021-02-19 15:41:55',NULL,NULL),(7,1,'From its medieval origins to the digital era, learn everything there is to know about the ubiquitous lorem ipsum passage.','<h3>HISTORY, PURPOSE AND USAGE</h3>\r\n\r\n<p><em>Lorem ipsum</em>, or&nbsp;<em>lipsum</em>&nbsp;as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero&#39;s&nbsp;<em>De Finibus Bonorum et Malorum</em>&nbsp;for use in a type specimen book. It usually begins with:</p>\r\n\r\n<blockquote>&ldquo;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.&rdquo;</blockquote>\r\n\r\n<p>The purpose of&nbsp;<em>lorem ipsum</em>&nbsp;is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn&#39;t distract from the layout. A practice not without&nbsp;<a href=\"https://loremipsum.io/#controversy\">controversy</a>, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content.</p>\r\n\r\n<p>The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it&#39;s seen all around the web; on templates, websites, and stock designs. Use our&nbsp;<a href=\"https://loremipsum.io/#generator\">generator</a>&nbsp;to get your own, or read on for the authoritative history of&nbsp;<em>lorem ipsum</em>.</p>\r\n','2021-02-19 18:09:45',NULL,NULL),(8,1,'From its medieval origins to the digital era, learn everything there is to know about the ubiquitous lorem ipsum passage.','<h3>HISTORY, PURPOSE AND USAGE</h3>\r\n\r\n<p><em>Lorem ipsum</em>, or&nbsp;<em>lipsum</em>&nbsp;as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero&#39;s&nbsp;<em>De Finibus Bonorum et Malorum</em>&nbsp;for use in a type specimen book. It usually begins with:</p>\r\n\r\n<blockquote>&ldquo;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.&rdquo;</blockquote>\r\n\r\n<p>The purpose of&nbsp;<em>lorem ipsum</em>&nbsp;is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn&#39;t distract from the layout. A practice not without&nbsp;<a href=\"https://loremipsum.io/#controversy\">controversy</a>, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content.</p>\r\n\r\n<p>The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it&#39;s seen all around the web; on templates, websites, and stock designs. Use our&nbsp;<a href=\"https://loremipsum.io/#generator\">generator</a>&nbsp;to get your own, or read on for the authoritative history of&nbsp;<em>lorem ipsum</em>.</p>\r\n','2021-02-19 18:09:54',NULL,NULL),(9,1,'From its medieval origins to the digital era, learn everything there is to know about the ubiquitous lorem ipsum passage.','<h3>HISTORY, PURPOSE AND USAGE</h3>\r\n\r\n<p><em>Lorem ipsum</em>, or&nbsp;<em>lipsum</em>&nbsp;as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero&#39;s&nbsp;<em>De Finibus Bonorum et Malorum</em>&nbsp;for use in a type specimen book. It usually begins with:</p>\r\n\r\n<blockquote>&ldquo;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.&rdquo;</blockquote>\r\n\r\n<p>The purpose of&nbsp;<em>lorem ipsum</em>&nbsp;is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn&#39;t distract from the layout. A practice not without&nbsp;<a href=\"https://loremipsum.io/#controversy\">controversy</a>, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content.</p>\r\n\r\n<p>The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it&#39;s seen all around the web; on templates, websites, and stock designs. Use our&nbsp;<a href=\"https://loremipsum.io/#generator\">generator</a>&nbsp;to get your own, or read on for the authoritative history of&nbsp;<em>lorem ipsum</em>.</p>\r\n','2021-02-19 18:10:00',NULL,NULL),(10,1,'From its medieval origins to the digital era, learn everything there is to know about the ubiquitous lorem ipsum passage.','<h3>HISTORY, PURPOSE AND USAGE</h3>\r\n\r\n<p><em>Lorem ipsum</em>, or&nbsp;<em>lipsum</em>&nbsp;as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero&#39;s&nbsp;<em>De Finibus Bonorum et Malorum</em>&nbsp;for use in a type specimen book. It usually begins with:</p>\r\n\r\n<blockquote>&ldquo;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.&rdquo;</blockquote>\r\n\r\n<p>The purpose of&nbsp;<em>lorem ipsum</em>&nbsp;is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn&#39;t distract from the layout. A practice not without&nbsp;<a href=\"https://loremipsum.io/#controversy\">controversy</a>, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content.</p>\r\n\r\n<p>The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it&#39;s seen all around the web; on templates, websites, and stock designs. Use our&nbsp;<a href=\"https://loremipsum.io/#generator\">generator</a>&nbsp;to get your own, or read on for the authoritative history of&nbsp;<em>lorem ipsum</em>.</p>\r\n','2021-02-19 18:10:06',NULL,NULL),(11,1,'From its medieval origins to the digital era, learn everything there is to know about the ubiquitous lorem ipsum passage.','<h3>HISTORY, PURPOSE AND USAGE</h3>\r\n\r\n<p><em>Lorem ipsum</em>, or&nbsp;<em>lipsum</em>&nbsp;as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero&#39;s&nbsp;<em>De Finibus Bonorum et Malorum</em>&nbsp;for use in a type specimen book. It usually begins with:</p>\r\n\r\n<blockquote>&ldquo;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.&rdquo;</blockquote>\r\n\r\n<p>The purpose of&nbsp;<em>lorem ipsum</em>&nbsp;is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn&#39;t distract from the layout. A practice not without&nbsp;<a href=\"https://loremipsum.io/#controversy\">controversy</a>, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content.</p>\r\n\r\n<p>The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it&#39;s seen all around the web; on templates, websites, and stock designs. Use our&nbsp;<a href=\"https://loremipsum.io/#generator\">generator</a>&nbsp;to get your own, or read on for the authoritative history of&nbsp;<em>lorem ipsum</em>.</p>\r\n','2021-02-19 18:10:11',NULL,NULL),(12,1,'From its medieval origins to the digital era, learn everything there is to know about the ubiquitous lorem ipsum passage.','<h3>HISTORY, PURPOSE AND USAGE</h3>\r\n\r\n<p><em>Lorem ipsum</em>, or&nbsp;<em>lipsum</em>&nbsp;as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero&#39;s&nbsp;<em>De Finibus Bonorum et Malorum</em>&nbsp;for use in a type specimen book. It usually begins with:</p>\r\n\r\n<blockquote>&ldquo;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.&rdquo;</blockquote>\r\n\r\n<p>The purpose of&nbsp;<em>lorem ipsum</em>&nbsp;is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn&#39;t distract from the layout. A practice not without&nbsp;<a href=\"https://loremipsum.io/#controversy\">controversy</a>, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content.</p>\r\n\r\n<p>The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it&#39;s seen all around the web; on templates, websites, and stock designs. Use our&nbsp;<a href=\"https://loremipsum.io/#generator\">generator</a>&nbsp;to get your own, or read on for the authoritative history of&nbsp;<em>lorem ipsum</em>.</p>\r\n','2021-02-19 18:10:16',NULL,NULL),(13,1,'From its medieval origins to the digital era, learn everything there is to know about the ubiquitous lorem ipsum passage.','<h3>HISTORY, PURPOSE AND USAGE</h3>\r\n\r\n<p><em>Lorem ipsum</em>, or&nbsp;<em>lipsum</em>&nbsp;as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero&#39;s&nbsp;<em>De Finibus Bonorum et Malorum</em>&nbsp;for use in a type specimen book. It usually begins with:</p>\r\n\r\n<blockquote>&ldquo;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.&rdquo;</blockquote>\r\n\r\n<p>The purpose of&nbsp;<em>lorem ipsum</em>&nbsp;is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn&#39;t distract from the layout. A practice not without&nbsp;<a href=\"https://loremipsum.io/#controversy\">controversy</a>, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content.</p>\r\n\r\n<p>The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it&#39;s seen all around the web; on templates, websites, and stock designs. Use our&nbsp;<a href=\"https://loremipsum.io/#generator\">generator</a>&nbsp;to get your own, or read on for the authoritative history of&nbsp;<em>lorem ipsum</em>.</p>\r\n','2021-02-19 18:10:20',NULL,NULL),(14,1,'From its medieval origins to the digital era, learn everything there is to know about the ubiquitous lorem ipsum passage.','<h3>HISTORY, PURPOSE AND USAGE</h3>\r\n\r\n<p><em>Lorem ipsum</em>, or&nbsp;<em>lipsum</em>&nbsp;as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero&#39;s&nbsp;<em>De Finibus Bonorum et Malorum</em>&nbsp;for use in a type specimen book. It usually begins with:</p>\r\n\r\n<blockquote>&ldquo;Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.&rdquo;</blockquote>\r\n\r\n<p>The purpose of&nbsp;<em>lorem ipsum</em>&nbsp;is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn&#39;t distract from the layout. A practice not without&nbsp;<a href=\"https://loremipsum.io/#controversy\">controversy</a>, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content.</p>\r\n\r\n<p>The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it&#39;s seen all around the web; on templates, websites, and stock designs. Use our&nbsp;<a href=\"https://loremipsum.io/#generator\">generator</a>&nbsp;to get your own, or read on for the authoritative history of&nbsp;<em>lorem ipsum</em>.</p>\r\n','2021-02-19 18:10:25',NULL,NULL),(15,1,'TEST 1111111','<p>heheheheheheheheh</p>\r\n','2021-02-20 04:37:49',NULL,NULL),(16,0,'TEST 11111111','<p>ahihihihi</p>\r\n','2021-02-20 04:40:50',NULL,NULL),(17,0,'TEST 222222222','<p>dfdfdfdfdfd</p>\r\n','2021-02-20 04:42:11',NULL,NULL),(18,0,'TEST 3333333','<p>dfdfdf</p>\r\n','2021-02-20 04:42:33',NULL,NULL),(19,0,'TEST 4444444','<p>ffff</p>\r\n','2021-02-20 04:43:35',NULL,NULL),(20,0,'TEST 55555556666','<p>The val() method returns or sets the value attribute of the selected elements. 12121212</p>\r\n','2021-02-20 08:09:50','2021-02-20 08:25:44','data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMSEhUSExMVFhUXFRYXFhgYFxUYGBgbFxgWGR4ZGhgYHSggGBolIBcYITEhJSktLi4uFyAzODMtNygtLisBCgoKDg0OGhAQGi0fHR0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0rNy0tLS0tLS0tLS0tLTcrKystNysrK//AABEIAOkA2QMBIgACEQEDEQH/xAAbAAABBQEBAAAAAAAAAAAAAAAFAAECBAYDB//EAEIQAAECAwUGBAQEBAUDBQEAAAECEQADIQQFEjFBIlFhcYGRBhOhsTLB0fAUI0JiUoLh8QcVM5KiU3KTQ3OjwtMW/8QAFwEBAQEBAAAAAAAAAAAAAAAAAAECA//EAB8RAQEBAQADAQEBAQEAAAAAAAABESECMUFREnFhIv/aAAwDAQACEQMRAD8A9uhQoUQPDwwhQDwoUKAUKFCgEIeGhQDwxhQoBQzwiYrT7alJw1Ktwz66CAsQoF2a2KKwlYYqKmGgYffvrBSClChQhEDw8MIeKhCHhhDxQoaHhoB4UMIeAaHhQzwEWhQoUZChCFCMUPCeGeE8A8KGeGKoCTwnij/mKSdnabMvQfXpFFV/JBYg86cfpFk0HHiJWIzNqvUH9RO8PSoH31ivInHCCSS76kDI6PkIs8eamu3inxWJI8qQ0y0LOFIFQkks6m9ouJT+HlDGQqaWKlcaOeUZ9FxSkTjOQhlfpFSA7VqaqPYR2vGyTltiVk5I1PB2+WnfN43459EL5vAIlpm7piCH3KUkVG5iY0cpYIBGRD94838Q3gvyDL8tRdJZajsgscmBJ0z1MaC478XMCQwCUgAlizCmeQyNA+VWgeXtq4lFWxWtM1ONNUkljvALPyMWRBDw8RiUEKHhoeKFChQoBoeFCgFChoeAhChzCaIFEVGJQxEAKl3qpRITJUogsWUn5tFC3eJFyX82zTUJ0XRaRzw5dYtzJvl2nCxZSQXfM1Ddh6Ryva8ly2KACHYhjvH38oNTxY2b/iVNSvD5KSMgyVOT0UWfrB+Xei56XUVIAw7AKSXIdiQBHOfIExYm+SEHCACGoTqXEDrTZTKIWklRelQHDip9acYsys3YJC2GWWU4SaPmmn36RSvdJ/1E7qt78+PKO8uzzpqR+WDLU7gmr6Hi2bxbFiZAQWcD7f0jU8sus5wIkupCSD+pAp/KPlBObZVqThBCcKWJoWZ/XKHsliwJGu1lyDe/vF78OVnDoc+Iz+kS+SzxB5NmUlkic7HUseZfMt8oM2ZBKTVyrXcP6xfVZJEtO2EAfub3MVF22RKdQSQKlwCQWO+M61gVeFoVLLT5Ty3ZM1Cnwg0daCA2ejwr2u7CGABBSoagFxkW01ggu2y7QVSSAp0H2++0D7lvElKrPOqpLiWSDtZsxatGiq7eHrWZavLUoGgDMRVqsMgO9ABpGrCxpWPPrN5iVhdQcZSM/npnG4u+aCgHIaCGM6uARKIPCw7zEEsQh4YBoeKHhQ0PAKFChQDQ8NDwDQoUKIFChQoARf8AIVg8xFVIBo2adeLhnjNTb1MxI8shT789BhruOvrGmvi2FKC1CaDeXplpAe6ZYFMI7Bv7VEStRys5HwspmDkV2jnnu3xYl3aH8xZDAVcZtxOtY63FOTOxLCWRiUE/uCSRi6sTyIguqXKDKUE0yJb0fnFS+weVZpysjgRkMJem+o9jDm78CkqUo5Mo/wAT5PuzipbvF7rMqySFWhSf9RQIRLRwKzmrgInc/itM2YJM6WZMw5OQpCuShrw4QBVVgKmIOX1f6R0s8vykqJySCT0EX5OUcrfLxS1ocDEkjuGgPHb9n+bZJl4T1le0TLkhZAbEdpVXOzUDKkDFIJs3nSpkxAVgCRjUUHEoBwkkhNNR9YL3ZZ5CkKkz1pQqWVylJWcwXKSOQUB04wrquYzxJsdnC1WaUpJmziCkKKTRIpXQ7yQKNDmK2Xga6zJlY1klSsnLu4BJf06GBVsngKVMFQqdhSaM7YHHHEe6YL3xeWAiySCEkI/MXn5aKsB+4t95gbcFjE6YlYwiTZ3AD0VN4fxBFa/xco1PSCl4MmYnJk93OZYcfeO1w3mDOMoB2Tm+7XdAO87OpWKYxGRbefpr1iV0S1S58qheYtqctdwCQoniBDJIzd16CATq3L+sdEpaIgHfE4yp4UNDvAKFDExyn2hKBiUoJAzJIA7mA6vCeANo8U2dJIxEtmaBP+5RD9IlI8RS1cjkXB67L0gDsKK8i1JVkfv5x2xQEoUKFAKGJh4YwGR8YT1JKC2ZIBJAGmmf947XJMSTm5A4gDvHDxFZDOmjFjCEhtA5JyFPWO1zSAlQpowfXiY1kwmuPhBYwLlJyQuYgH+IJUU4vT0jM+KLztEpKpcwHUJU+QINQ2dAaZwe/FixWlQUPyZhxJI0JdxxDgd4OWhNntCNooUDUVEZsV5va5k4WPy7MdmbKDkM6lKckg79OkdfD0hU2yiaTthAWCaYVozd9HcdYMp8Lz5KlfhpqTKUSrAsYgl6lg4aur9IuXd4bOJK7VOCsJcS5YwoJFXVvMa2YndFbp8RomykLDg4RiBBSUlhQvEbz8QyUIUpShlxOZAoBU5iLtpMsJIwgpIYg0DF94ryjLW+RJlrSqXIxTcaVYRtKVhcEkE6DUxzdvDxnutFdNglJSFGXhVM2lA1DmlS2eUK9LyTLllqUISAGrkwGbxUn22Zsgow4yyalWQJchFW+sAVTXUp1KmzgvClIpRJ00QDWubGNSVnJOq8yRNRLwg/nzppBIJdyAOoSCR0jc2Cwy7NIShIACQBlmeO94G3JdJSr8TaFDHXCnJCBU7O81ziV734MJIBCXYEuCrSgzL7otvxm9VLwvVACqFhuFCW0bm3SOHhe1ebOJr8+fD+ggQu1ggBamUXZITVt+bA1zUQ246l/Ck1MomWlAcl8WMOob3avT2i8xn/AFuRCjkhbxLFGRMGGUqGeAN+3ngOAcue/oBFghet/hKilNVAdA4oeZ04VrGDva0zZpKpxUz5HEK8KOcqZDhBtU8bUwpagJJzDs2evzirads8TmdABx3AesPXtPfoHlWmSkOtyWpQZ7j/AGjtItyCCUoCN7lSSeAwvAW1pUlZJASBmSXpzPDh9YZN4SCC62IFCylEtuCRQcYvlJ7hPytHdPiCdZ5gxFRklTn/ANQAEiow1BrqMo9G/wA5l/xy/wDyCPC7CFz5yQErdRGQxKbfhIq3PXv6/wDhlf8AQm95f0jK41MKFETAOVNESvcPlDOBlU+sMQdSw3D6wAS//McfDgzLfGM8noRGasl5zSWwVrmamraU1MbqbJSR8IA3tXprGWtNnEmYpwyTqasNKvxfpGpYgja7tlT5QRMFHcYaMeBIeM/bPD0+UDgAmpyDPLmMMmUCA/aC93XklR+JyMnDb/kDBOTeAWWDZA/05xPTWsPKvKXLG0qZKW+U0rFDmHcjkSd3Un/mJGIonpWkB0l0KJBzcgg0P9o006xypvxpSeYD7opo8PWQ1EmSdxwI+kOLGZtt7ggA2oOTtYBp+0kvrEbvtExKibNJWcQAUqZUsHrjUN+mQ3RtJF1y05JA6CLiZKRpDV4yFk8PT5gaZMwIdwmW4IFdnGTiw6NxjRXZdEmQnZSA2ZPzJi6u1JSKmkZbxB4jVtS5ScSjQMCQHpU733Zdolpqxf16kJJTMSED9WSR81cg0YC2W6c5UFLRifCtaXWeMsD4QaUZ95zg7armmDApU5ZWxLMMOeTF23U3GJrsssDVSy2ZJO6LlZ0DsmNKaipILHaWr/uUTk/6YvSLWpEwAg4hicgiuFnAOT67qNvi9KsyaB2D4ieIDCuuXpFG13VhKZstlMtWwaukkvnnnTrviSJr0a6LQFy0qCgoEOFCjj6xcJjC+E70ShWF2lzFU/arIA7iWZ/sbiAkpUYy9LN5ijMKi2IhIFaYiT1ctGlvqZhkzFbkxg5N5hKAHxM7HTaJ9nizficLxfZymWkJVQMSBvpWmbOIC2C2rmgy0h3wgDk7cTnlFrxDbvMC1CqQg4fkeufUCNv4OuRMmUC21rzOYeLuzKSMcrwDapu2soU/whRNOYFAct8HLi8AKln86Ykp1QkFSdKbbt0jegQhGVVbuuuTIDSpSJY/alKX5tnF1oaFAImIlzwHrEoaAjlQffOFg1zPpEgIeAiEampihfd3Iny8K8QaoKFFKgeBBEECYzt+2ycDgQQHdiMxxP8AcRRkp1jnyiUpBCHYOUqWsszliyRnmYKXcJ6Q3lKzTUMa7wHypmzd4eVacRTKlkEuxmOGB1Z/iI++HGZPnoWDhISCwc/ESpIf1/5PxD6ehaVa1EOUEVyIIPGmvSkd5ayKaOCGrpFq77fKnJB+KpFd6WBp1EEZaZeYAB5dYL/SjInKKsNTXNstczHWbiYsKuPcP6RZtNrSgOchAi0XhOUnGlGx65EuBmdIYapXulZOHGEfE4cuxpplz4xVsclEsJOaq1J3l6cKCvCKhmrK3UFEsXKgwPIZnfEEEzCok0oFH1Yc8osZtEzhIxqq9Amm0a6bhHKbZU4QkAYlV5DU/TnFZaHmVoEgFtzh2PHLtDJtykLrUltxOtC+QHtDL+psc5kpKQBVgBRiVKBPufkYq2VRUShTuCf+QYAb2Z+kXbba32hXEpJOeVOzDf8AxQDvqf5Tzpbj8458Qk9GCmibvFz8UbDaDJnBBIwqcB8nS5Dg6Ev3j1e5rT5klC6uQxfNxSseP3hMBUgkULq+dOoj0zwTafMsqODp/wBpYwqiN/B7NO/9tTdo85/AFUtOGmwz7gSSK72j1VSAQQcjnHnFpmGUpdmGaZmBzol3HQpPpCb8S4D2W71kolswmT5Yd6gYgp6cj3j2CyywlIAyApHmJtyZapb5pUgdWApHo112rzEBXEjsSPlC1cXoUMIeIJCHiIh4BoUKGeAcGE8M0IwFO9LcJKCohyxwpGZMYiYJs4qMws5L5UG5L8ad41l8rSkYjm1HO5+w9TGEtl4LmES0HZVmdcLswbJ69434s13myUyvKmuwxAJqTR8zvD4e3GNFcd8JnJQVMSADxGJjkeBEYa8ZCguXiVsFyA2amIc7kh6ccO4xqrgs6UpSpAJdAfmKU7RJVrSWO55SHKHDknPJ824ZdhF1NlA1JilZ7Sch/cM/1i9OUptn+sQPNloA2gCK51z5wCvy3MgsWzFNdze3XXKCE2QpdVqYetdIz14spaUAhk1IBDljqdKtQaAvujUiKa57UVmdkCtKkmup3/ZjiLZUYfhSXdqEj+p9ISbGStzVkn1JzMR/BqJIJFKNoOP3viWQlqzJnoKlKVuJA/iOpb7zEKTZQseYvUlZ5MKe3cwPl2coSsqzYgOa5+ggpLtKfw9C5Iz35a9olmLOgVrWUuVD4lJz3Av3DRxvwpWhSaNtqAGuAJ+h9YtX7NxMNminGf6WB5xnpt6OlR3pmgnTawh+gL9oXs1ZxSM+ixUlIBHI696R6F/hPacVkKFHaRMUk9WU/rHl91TULWpiSShXIhNWfX9Mb7/DWf5c+ZKOS04gNXSc24hT9IfFr0xoyF/WCX+LClhsaAQcvh4/eZjYJgB4xsZXJC0/FLOIcsj6REYrxJdKMayP0oDVzq4fiKnpG58JTgqTyXMH/wAiowFqtKlIepdGetSXHYvzeND4DtZTMmSFH4kpmI402vkesWym63YiQjmDExEEoeGhPAKGh4UQKGMPCMUYvxoorUmUnM1PIEZ79S3CAKbP5amNC5AFCwpQnkfeND4tQUHGAa0pnmCT2gFZJOIeYupNSK5kgnnWLCoXskqlu20hmaopUfKLPha0nywE5gMRvCXy4v7xDGkshyMi1QXNO1PSOFx2dcudgScQDLScmCjUHVwa8n3Uk9o3VgmlWYbT0giFBIqYD2KUpJPBTpPAvTp9IIzEYjUs2gjWIq3hPDZ1eg48d8ZeXaEgrUVBmOEb2ev3vMFb+UlA3qJ2U6l/YNrxgKLOSHU1QfpluFRx6xeCcm8QQoAEKJbtCmKNAk1JJ5sXziKbuIcChLk8hU9HgckrE5SQ7Fg5zOp9PeJZPhL+rN7WsTEKlgYScIL0ZOpJ3mpiuLwQEpBoimHOuEt70/lMQtS/OLNVbKbIq+EsTuNIGypTz1JOcshIBDBLVoMtW774maq3eoxlZQKMlKRk2I98go9YwIRMnqZIIRjUE1LKbaUvjVgOUbgylz3kyQXIViLsQGqeYcJHFfCO1yXVgSEhFEIKQ/HP0HtEaBrgutCAg1xMUuf3BI1yyi8uQuz2pE9LllVbLUGv8yu8XlITK5Asn+XIv0HaOFvmlQTUhycW4Fgx5O7xvx6xXqdgtaZiEqSXBAIiytIIY1Eeb+Gb5mSZ3lrcy1gYAP0qGYG/kdwj0WTMCgCNYzZjUuvNbxsPkTFySNQpCt6FfMVHQxesisE5M0UIQkDgKgv0LwY8c2DHK81I2pdTxQTtjoNroYyUqWsJAcuEhu7Dm4b0hmj06yTsSQreP7xYEZnwneRWFS1BlJr9TyevUxpUxB0EPEREoBQodoUAwhGHaEYDI+MwQyidkNvapD9aRlbZaWVhTQk4R3CR9Y13juWpUnCgElwzb3HyxHpGMumzEr81dAgeqQ5bqBzixKJXfYgtgoPsseJc09IuyJQlz5a64QCgHitiH5YcPaB6pqlFk/qU6q5BwXHqO8W7UgeUZYxuGUGIHD+vMCLpjZ2ZaVCITrSA/CAvhe8DMQpC28yWwVxBdidDkaxVve8lTUqlywya4laqbMDcDkTxMXidDL0vArnKOtByfQcWPrF6xTsKcJqwc0yesDkGgJYFJL0+mf8ASLEm80KfF9ltYz/UME7MAoVNST709Ir3pLTshwDx1KuWbs/SOU5JR+YCwb05RnjbF2ibjaiXYCoKgwz4PTrFzOm7wSTPTJmK8sYpmHAls6Cqia4RQkfOkVLJYZk5WLEEhai62AyoSQa4qFn3JpqbNmwyxqpSgXSMiQwcnMpr1ixOs0xbSvgGr5hxUgaFmHBxurLtpMhrP5MhZwliU4U5khCQyQTzJUeJisu1zFbIBDuToyXAYcwR2juqyy0KOoASAM2CXYc8zz5RdkgODQZegJfjkO8MyL7DLZYXS9A1TuDAb+0V/KSiUz7WKj8EcOXvBW0/6eEEZOo+rAajN+kDkWZBBdTkHXiE1PB9BE1VezWhPlnCKAsQdHLhQ3Md0bjwxeHmShUlSdlT5uKdeeUYhCZaFsSHBo+ShmX7vB64LxlomhIVSakFsw7M+4Fh6cY1bLEm62VoRiSR6fKMMpaUS1yCWKFMDqyVjCS+uGvQxtsUYG/7Kpc5as3SCANWdh/xiTN6t/4s2K0JlWiSoFwUzEk7xhKhXX4PWN1Zl4khQyIBjyS2JmS1IUabQPD4fbSPUrlmYpKDwDctIeXKRfBiTwwEPEVOEBChiWgh4aHhjAcbRICwQRmCO4Yx594hsolzPLBbE5PIkOfbvGzvW+JcmhVtEUADnsMzwjEW2ZNnTEzCglgvZyLEJOtNBTjvEaiVCzLIlywzLVTs9OcPeWOWrzAtJBSErRkXBd0nIcRwjO/5j+SsqlzsUpZOFnmJJUSOzdQ+cFJd1LtXlK/EUcYcCQUnU4sWeQiWrODnhcTkypy5qPzK4SCk40gKKRTJVajKsBLFNmrShMxRSUMFpTQFQDsS+QfLrG5u+xgAB8RGZ3lzoN8ZjxFccw2xa0hSUGzhin4StyCTxAb03RNErRIRNAWgsxZX7jQns/dogmxIIU70Y0z313P8xAOzXhaEFNlTKH5cvEVFQYuSARuy1EOrxHMkrEnysa5m2SC4AwsKlqB0xGne/LYRL8lAUVTQyeT/AEL9oJXFd4QlLhsQZtdkbReBV1STMnlS3KyxBdwkGrD0GUaW1TgigBLDC9GqePONd8mORely5QJWEhwAeg1/pEF3kgusJxrZgG9zujN2y85qtmXsAMVKfnQ060IOUWbPbhgCUJLHNZ+JWVd41rnFynHK1qbZBxTDVWHTgG0GT6x0moICXoqpIFTpnppQaReRPTJSlKAMSk1J0DPThl3iEkhS8TbwpRo1MucNFFNmxS6nZTU1NX0ppWOHlEqExmSEuW/lHqzdYMTNtGFFE0FNXIfk7HtEpADKOgL6Ns7uvtGf66uAVvsZRKRMSBiWCSdSx70y5M2cDfwZGWLVBKSWoXcbixBeNJedo2UHDVApu2iBU9oqWi3pAyz5akDu0blTGpuO3KmWNKpn+oE4VfuOWIf9wY9Yzk21fnqq+0B2CgB6E/3hXb4hxoTJZlOeGJiSGpuaM5aLQqWtRNS5VUEB9zaAD24xJC34KXnLxlEtjkl2/cSfc++6PR7jSRJQ+eEdmjzy4PzpgxEqwspStzDX16c49Lsw2U6UFIy0tCHaIJMO8B0hQoUVDQxMPHG1KIQojMJLdogx163qFzCE1SlRS9CVKHSiQz9IFKtr1QaBkl8yTUjc2XNoldslLGtVLWpy4LGjNuZo6W+TKwBKQAkMD1Dd+caz8Tf09nsapgBzIAff8IA++MdZTiYEsUnDhGgAdyerCON023Ri7h+ASoAg9401ms6VjEWzJ6EN84fBGx3kE0UwYYieYcDoPeCcy0ukkBy3D5wPNhSTWgOId0t7RdslhIzU4whPZ2PrGWmfX4c2zNUkFwWILMD+kjVOVOEC7VdIVMKghlICklWZZQqN2grHoWAM2kc0yEJcgBya8YZErL3VcRSHVsuqgZyQBrFC22da1KSFYUpLUzUSczuHLSNXedvCUKw5tnGGttrKZxBLlwV6BwBs00Aag3mNzfTPPaM+7lBgGYmlKBI3vmSx7Rbk2MCgNQBzJI+ydzCOMm9ApJJSa5dfYRck2pIBURX4Xfe330hf6XjtIsqVI2iVKcJGg+6GB972YghCTm1OZYE9z2iwu8aSwgFwCo6cB8/SLkqWCWLkqFX0AGfCrd4x2L7DlzwhGEEskkJYaACvcv2jhZrQS6dKOd1KJiwpIJUczXu+ftFdFmCEow/Eoux5GvaLLPqYafbNDRISCNdXbs/YwGv+UkjFiYOBupmW4wQvyUQQ1Q3DNyAG4Rj78tX5eAfFicnmw7594uT4sWrErBaisUS+JnfCzF00qCCC3ExevGaJmIJLYtdzlwAN560z42Lg8LTZ6RMILH4TRyGG/Ibnjc3L4WlSiFKS6hk5dt55mJpIo+C7gWhIWsYEfpT+pZJfEvcNye+6NuBEUiJRFOIdoQEPFEoYw0KIhREw8NAea2izq/FTUpoElbJyyUtXZmpFo2YMqoLsoPXX1g9et2BExdo3gDc1GJ9B6xlgMcxQC8qEPqkAtwOnR41vMZxOzzk+eVD4QnCfQl+TekGbPaSnEj9SSCOIJr6Rm7RILvLL40qYjfUN7Rau+3gLKZigSEpIOpBcMd2Q7iGq0s61LSCGqFej59jF2VbyniKBhvJI+kA59tZw7uGB5j60iyqesgKw/CSQNas1Bo4PeM3/ABRi2W0pIpTFhPBx9aRwTaFFOMj4l4WJrUt238orzJXmLAxMClJf9ySD8vWLKpYwJxZpW7cQTFlpgdfc5SJSlpqUs253pzGJoya7GvDiZ3Q+Kjkkvic5xsb7AEhadSlWEBjUAkHPfGFtFumHAogpGEJA3ABGuuvrGpazcFk3YEiXU1ApyGfExbRd4IABJzI04dSa1MUE21TBdSyQGA12te0WLvvQ4gVAABIYd6Pyif8ApeLHkiWqZhrs4Ek6YThfl11isoKAXMBoBWugKs+NBHc2pqEO4qOZBFdTn2iEu2IKFJ5nKtCaB+MTsvV+AyrasCuZ/Tk5z+/6RJN4kzEpUXABJOQATU1HpygjYkIJcgZKNewgPNsBdQSzBJLkPUiv3wjXKzJZVa2XmlagS4BoNzlq9HgVZFC0T8LMhSxQ5sV7tfhJjreMggEuwJKU9Ke5BeCVwSZUppwqsAMncqgI60EZs7xp6hctlCJSUgMAMtx1HJ3gikjLdGRkeJ0YXHxEsBmA9X7NFuzX8kEOclEE1yAfR9RA1pokIBSfECFFgQ5c8B9a06HdS/JteRJZ8uPFoYL7wK//AKCX/Cvsn6wRM1IzPCPOPOXugPTDDRxmIVmk9IYGqeIqPX75wxHYmIGYPVoqTZyg5AcsA29ir6iAlpnzlKcPUsQM2IDHmkww0dtC0TEqSapUk9d/UUjyq/LOiXOJkzCoAJTMAYBTOFN+5iC+QIg1bkWnGDtBJKnA0K0mvcA9TGKvKwzkUmJISdFOxKQKHeKE/wAsLMWddh4hEkEY8jUMQWNQpOh0y3GIIviSZoWlTb8wAMVC+51HuIzt4BSilIcS0viNK8AdMu0XLPZMSQEy1KDuAHO8n6d4y1j0yyTEEqZWyt1I3g1JSeD/ACOsXLFbJaljBNGJLFqPoPn3jFXdc1p8shKFAFIAAUzMQ/EEBxBK7/Bk3F5hmKScnq4d3GW9v9salrNxtpk0KY4xkddHzryaJizLBdJDkFt448Yzci6JwEsYnCHGHZANWFRpTWDiLHP/AI3PKjk0bIjvpGuxniP4dSifMIGGhzOjV3VasZfxHIErCksVbQzcspRII4MRByZdlrC1FM5wUgEEB6uDUMMiKtprGY8YoXLCDMBWScMsKwhiAz0FRUhjvMLbhI5WC8yMQUNkq8s8xTfSvzg7Z7wRhNBQDcag7jxLRiBaFKW2AklAC9ACQ6VqbIjNhUvXOnG12woLVUr4VFIoxDtufI8KRi2N5W2lWvCHYkkFNKkM5oN76cYrTky1nEFAUKQM2rVxv5+kZI3rORUqAIFAA5rvcsDF2w39NKi8nGSCk0KQQQXehb3iSqsyrxUnEpLlORLO9DkNGPtHNHicFBlZLWzqOSSaNi6GvCL0rwtaZygcIly1UKcRJOyWKgzaCv7o0tyeC0S9vCHKsQB4Jw+7ntG4xWPklc0JQp1YaA1zoXApVgIKSrmmlaQlJCakngzAc3rG9stwoSolgSeGpzPoO0FZVmSBQQw1g7J4cWw0NTTefm7dhBVPhxk4QHriVu1p29o1iZQGkTCYamM7ZfDKBtFzsslOQTRn51P+4wUl2AhRU4rwyEEGhNE1pWTZm1r90B+cCv8AIR9qVBe0yllsCwnN9kKfdrHDyp//AFJX/iV/+kNTF2E0KFEVBUuOJkEKcNnXlV/cRah4ulismz0yrT0Mc51ilrCcSQoBRLEP8Tj/AOxHUxdEMPnDUwCleG7OB5XlJKAoFiHoEkVJ6dovWW55SAyZaE0IYJAzggIeCqosSdPvL6R1/Dhm5ejR1hGGo4izjdWvrExKG7V4nCMNVxmSQ7sMiO8Z6/LgFoKHHwe1X6ktGmMRMNHlVo8EWhDgEFKlEkjPaL1+oijK8DWkEDZ+IvU8Tu5x69O+ExXHxn/u+S4SFtYizf4cg7Uxe0+ScqPqQ7Rpbu8LyJQZKMyFFySXzzg6IkIg5IswAbnXnHTyxExCihsMOBDwoBmhQjCiBQoUKA5TlKHwpB5lvkYoeRav+pK/2q+sFIaA/9k='),(21,0,'TEST 7777777','<p>gfgfgf 777777</p>\r\n','2021-02-20 06:35:47','2021-02-20 08:26:19','https://martialartsplusinc.com/wp-content/uploads/2017/04/default-image.jpg'),(22,0,'From its medieval origins to the digital era, learn everything there is to know about the ubiquitous lorem ipsum passage.','<p><strong>Nguyen the tai 123</strong></p>\r\n','2021-02-20 08:24:40','2021-02-20 08:24:03','');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletter`
--

DROP TABLE IF EXISTS `newsletter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `newsletter` (
  `newsletter_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `newsletter_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`newsletter_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1490505766761 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletter`
--

LOCK TABLES `newsletter` WRITE;
/*!40000 ALTER TABLE `newsletter` DISABLE KEYS */;
INSERT INTO `newsletter` VALUES (1490505766760,'dangquangkdc@gmail.com','2017-03-26 05:22:46');
/*!40000 ALTER TABLE `newsletter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_code` varchar(255) DEFAULT NULL,
  `product_price` decimal(10,0) DEFAULT NULL,
  `product_description` longtext,
  `number_purchases` int(11) DEFAULT NULL,
  `isActive` tinyint(4) DEFAULT NULL COMMENT 'quyết định có cho khách mua sản phẩm này hay không: 0: chỉ xem; 1: xem và mua',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1614872436662 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1614872436661,0,'áo phông','H2812.8',0,'asdsad',50,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_color`
--

DROP TABLE IF EXISTS `product_color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_color` (
  `product_color_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`product_color_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='1 màu có nhiều size';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_color`
--

LOCK TABLES `product_color` WRITE;
/*!40000 ALTER TABLE `product_color` DISABLE KEYS */;
INSERT INTO `product_color` VALUES (12,1614872436661),(13,1614872436661),(14,1614872436661);
/*!40000 ALTER TABLE `product_color` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_image`
--

DROP TABLE IF EXISTS `product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_image` (
  `product_image_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `product_color_id` bigint(20) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT=' 1 sp có nhiều ảnh - 1 màu có nhiều ảnh';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_image`
--

LOCK TABLES `product_image` WRITE;
/*!40000 ALTER TABLE `product_image` DISABLE KEYS */;
INSERT INTO `product_image` VALUES (18,1614872436661,NULL,'/image?fileName=quanAoNguoiLon.jpg'),(19,1614872436661,NULL,'/image?fileName=quanAoNu.jpg'),(20,NULL,12,'/image?fileName=quanAoBeGai.jpg'),(21,NULL,13,'/image?fileName=quanAoNu.jpg'),(22,NULL,14,'/image?fileName=quanAoNam.jpg');
/*!40000 ALTER TABLE `product_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_size`
--

DROP TABLE IF EXISTS `product_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_size` (
  `product_size_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_color_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `inventory` int(11) DEFAULT NULL,
  `price` decimal(12,0) DEFAULT NULL,
  PRIMARY KEY (`product_size_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_size`
--

LOCK TABLES `product_size` WRITE;
/*!40000 ALTER TABLE `product_size` DISABLE KEYS */;
INSERT INTO `product_size` VALUES (21,12,'S\n                        ',480,1000000),(22,12,'M\n                        ',500,1000000),(23,12,'L',500,1000000),(24,13,'S\n                        ',500,1000000),(25,13,'M\n                        ',470,1000000),(26,13,'L',500,1000000),(27,14,'S\n                        ',500,1000000),(28,14,'M\n                        ',500,1000000),(29,14,'L',500,1000000);
/*!40000 ALTER TABLE `product_size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `review_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `review_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `review_star` int(11) DEFAULT NULL,
  `review_message` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`review_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1490661562335 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1490201148301,1,'Quang','dangquangkdc@gmail.com',5,'The GD100RSCE is a full size acoustic electric guitar specifically engineered for the serious player. Carefully selected tone woods of mahogany and spruce create a sound that is well balanced and articulate, especially for finger pickers. It features a gloss finish and upgraded features traditionally found on guitars costing much more.'),(1490201320318,1,'Quang siêu cute','dangquangkdc@gmail.com',2,' Sản phẩm cũng được, khá đẹp ^^'),(1490442620582,2,'Quang đẹp trai','quangcute@protonmail.com',4,' Cây đàn này được rất nhiều chọn để quánh cafe :3'),(1490444655206,2,'Quang cute','dangquangkdc@gmail.com',3,' Mình test thử thôi chứ ko đánh giá đâu :)))'),(1490445109940,2,'Quang cute','dangquangkdc@gmail.com',3,' Mình test thử thôi chứ ko đánh giá đâu :)))'),(1490202226404,1,'Quang','dangquangkdc@gmail.com',1,'The GD100RSCE is a full size acoustic electric guitar specifically engineered for the serious player. '),(1490445318522,3,'Vô danh','mail@mail.com',5,' Sản phẩm cũng được :3'),(1490455827023,4,'Quang quyền quý','dangquangkdc@gmail.com',4,' Đàn bao ngon :)))'),(1490509844040,24,'Quang review','dangquangkdc@gmail.com',5,' Quá sắc sảo :3'),(1490661562334,21,'test','dangquangkdc@gmail.com',2,' cũng được');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'tên đăng nhập',
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'password\\n',
  `role` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `biirthday` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zalo_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'tên zalo',
  `zalo_phone_number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'số điện thoại zalo',
  `full_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Họ và tên',
  `phone_number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Số điện thoại',
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Địa chỉ nhận hàng',
  `is_active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1613703839939 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1610880442341,'duyhung','$2a$10$w0n8LQv7BdTho6SrakQ8k.ugkS/E4eH1JriJg.ZthS7EytbOP0oiG','ROLE_USER','23/02/1997','Nguyễn Duy','01234567','Vũ Thị Hoa','0978144872','Số nhà 18/5 Ngô Sĩ Liên phường Tân Sơn TP. Thanh Hóa tỉnh Thanh Hóa',1),(1610880348831,'test2','$2a$10$w0n8LQv7BdTho6SrakQ8k.ugkS/E4eH1JriJg.ZthS7EytbOP0oiG','ROLE_USER','23/02/97','hung zalo','phone zalo','adidas','23/02/95','hanoi',0),(1610880196014,'test1','$2a$10$w0n8LQv7BdTho6SrakQ8k.ugkS/E4eH1JriJg.ZthS7EytbOP0oiG','ROLE_USER','23/02/97','hung zalo','phone zalo','adidas','23/02/95','hanoi',1),(1610880196011,'admin','$2a$10$w0n8LQv7BdTho6SrakQ8k.ugkS/E4eH1JriJg.ZthS7EytbOP0oiG','ROLE_ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,1),(1613703839938,'test3','$2a$10$w0n8LQv7BdTho6SrakQ8k.ugkS/E4eH1JriJg.ZthS7EytbOP0oiG','ROLE_USER','23/02/971','hung zalo1','phone zalo1','adidas1','23/02/951','hanoi1',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utility`
--

DROP TABLE IF EXISTS `utility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utility` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(45) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utility`
--

LOCK TABLES `utility` WRITE;
/*!40000 ALTER TABLE `utility` DISABLE KEYS */;
INSERT INTO `utility` VALUES (1,'UPLOAD_DIRECTORY','D:/upload/');
/*!40000 ALTER TABLE `utility` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-06 23:43:28
