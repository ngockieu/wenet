/*
SQLyog Ultimate v8.71 
MySQL - 5.6.17 : Database - wenet_crm
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`wenet_crm` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `wenet_crm`;

/*Table structure for table `tbl_announcement_users` */

DROP TABLE IF EXISTS `tbl_announcement_users`;

CREATE TABLE `tbl_announcement_users` (
  `announcement_id` int(11) NOT NULL AUTO_INCREMENT,
  `announcement_user_id` int(11) DEFAULT NULL,
  `announcement_user_created` datetime DEFAULT NULL,
  `announcement_user_created_by` int(11) DEFAULT NULL,
  `announcement_user_modified` datetime DEFAULT NULL,
  `announcement_user_modified_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`announcement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_announcement_users` */

/*Table structure for table `tbl_announcements` */

DROP TABLE IF EXISTS `tbl_announcements`;

CREATE TABLE `tbl_announcements` (
  `announcement_id` int(11) NOT NULL AUTO_INCREMENT,
  `announcement_description` text COMMENT 'Content of the announcement',
  `announcement_attachment` varchar(255) DEFAULT NULL COMMENT 'Attachment of the file',
  `announcement_department_id` int(11) DEFAULT NULL,
  `announcement_created` datetime DEFAULT NULL,
  `announcement_created_by` int(11) DEFAULT NULL,
  `announcement_modified` datetime DEFAULT NULL,
  `announcement_modified_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`announcement_id`),
  KEY `idx_announcement_Attachment` (`announcement_attachment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_announcements` */

/*Table structure for table `tbl_debug_querylogs` */

DROP TABLE IF EXISTS `tbl_debug_querylogs`;

CREATE TABLE `tbl_debug_querylogs` (
  `debug_querylog_id` int(11) NOT NULL AUTO_INCREMENT,
  `debug_querylog_query` tinytext,
  `debug_querylog_queryhash` varchar(255) DEFAULT NULL,
  `debug_querylog_querylocation` varchar(255) DEFAULT NULL,
  `debug_querylog_benchmark` float DEFAULT NULL,
  `debug_querylog_backtrace` varchar(255) DEFAULT NULL,
  `debug_querylog_result` tinyint(1) DEFAULT NULL,
  `debug_querylog_count` int(11) DEFAULT NULL,
  `debug_querylog_error` tinytext,
  `debug_querylog_time` float DEFAULT NULL,
  PRIMARY KEY (`debug_querylog_id`),
  UNIQUE KEY `query_string_location` (`debug_querylog_queryhash`,`debug_querylog_querylocation`),
  KEY `idx_debug_querylog_Id` (`debug_querylog_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `tbl_debug_querylogs` */

/*Table structure for table `tbl_debug_querystats` */

DROP TABLE IF EXISTS `tbl_debug_querystats`;

CREATE TABLE `tbl_debug_querystats` (
  `debug_querystats_id` int(11) NOT NULL AUTO_INCREMENT,
  `debug_querystats_query` tinytext,
  `debug_querystats_query_hash` varchar(255) DEFAULT NULL,
  `debug_querystats_query_location` varchar(255) DEFAULT NULL,
  `debug_querystats_count` int(11) DEFAULT NULL,
  `debug_querystats_count_failed` tinyint(1) DEFAULT NULL,
  `debug_querystats_count_slow` tinyint(1) DEFAULT NULL,
  `debug_querystats_time_total` float DEFAULT NULL,
  `debug_querystats_time_avg` float DEFAULT NULL,
  PRIMARY KEY (`debug_querystats_id`),
  UNIQUE KEY `query_string_location_stats` (`debug_querystats_query_hash`,`debug_querystats_query_location`),
  KEY `idx_debug_querystats_Id` (`debug_querystats_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `tbl_debug_querystats` */

/*Table structure for table `tbl_events` */

DROP TABLE IF EXISTS `tbl_events`;

CREATE TABLE `tbl_events` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(255) DEFAULT NULL,
  `event_start_date` datetime DEFAULT NULL,
  `event_end_date` datetime DEFAULT NULL,
  `event_address` varchar(500) DEFAULT NULL,
  `event_description` text,
  `event_created` datetime DEFAULT NULL,
  `event_created_by` int(11) DEFAULT NULL,
  `event_modified` datetime DEFAULT NULL,
  `event_modified_by` int(11) DEFAULT NULL,
  `event_ordering` int(11) DEFAULT NULL,
  `event_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `idx_event_Name` (`event_name`),
  KEY `idx_event_Address` (`event_address`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_events` */

/*Table structure for table `tbl_files` */

DROP TABLE IF EXISTS `tbl_files`;

CREATE TABLE `tbl_files` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) DEFAULT NULL COMMENT 'Name of the file',
  `file_department` int(11) DEFAULT NULL COMMENT 'Department use this file',
  `file_description` text COMMENT 'Describe about file',
  `file_path` varchar(500) DEFAULT NULL COMMENT 'Path of the file',
  `file_created` datetime DEFAULT NULL,
  `file_created_by` int(11) DEFAULT NULL,
  `file_modified` datetime DEFAULT NULL,
  `file_modified_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`file_id`),
  KEY `idx_file_Name` (`file_name`),
  KEY `idx_file_Description` (`file_path`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_files` */

/*Table structure for table `tbl_incomes` */

DROP TABLE IF EXISTS `tbl_incomes`;

CREATE TABLE `tbl_incomes` (
  `income_id` int(11) NOT NULL AUTO_INCREMENT,
  `income_user_id` int(11) DEFAULT NULL,
  `income_task_id` int(11) DEFAULT NULL,
  `income_money` float DEFAULT NULL,
  `income_created` datetime DEFAULT NULL,
  `income_created_by` int(11) DEFAULT NULL,
  `income_modified` datetime DEFAULT NULL,
  `income_modified_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`income_id`),
  KEY `idx_income_money` (`income_money`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_incomes` */

/*Table structure for table `tbl_logs` */

DROP TABLE IF EXISTS `tbl_logs`;

CREATE TABLE `tbl_logs` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `log_user_id` int(11) NOT NULL,
  `log_type` tinyint(4) DEFAULT NULL,
  `log_name` varchar(255) DEFAULT NULL,
  `log_variables` varchar(255) DEFAULT NULL,
  `log_link` varchar(255) DEFAULT NULL,
  `log_referer` varchar(255) DEFAULT NULL,
  `log_hostname` varchar(255) DEFAULT NULL,
  `log_timestamp` int(11) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `idx_log_Id` (`log_id`),
  KEY `idx_log_UserId` (`log_user_id`),
  KEY `idx_log_Type` (`log_type`),
  KEY `idx_log_Hostname` (`log_hostname`),
  KEY `idx_log_Collection` (`log_id`,`log_user_id`,`log_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `tbl_logs` */

/*Table structure for table `tbl_projects` */

DROP TABLE IF EXISTS `tbl_projects`;

CREATE TABLE `tbl_projects` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(255) DEFAULT NULL,
  `project_description` text,
  `project_start_date` datetime DEFAULT NULL,
  `project_end_date` datetime DEFAULT NULL,
  `project_status` int(11) DEFAULT NULL COMMENT 'Open, In Progress, Completed',
  `project_priority` int(11) DEFAULT NULL COMMENT 'Low, Medium, High, Critical',
  `project_attachment` text,
  `project_progress` float DEFAULT NULL,
  `project_comment` text,
  `project_comment_file` varchar(255) DEFAULT NULL,
  `project_published` tinyint(4) DEFAULT NULL,
  `project_created` datetime DEFAULT NULL,
  `project_created_by` int(11) DEFAULT NULL,
  `project_modified` datetime DEFAULT NULL,
  `project_modified_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `tbl_projects` */

insert  into `tbl_projects`(`project_id`,`project_name`,`project_description`,`project_start_date`,`project_end_date`,`project_status`,`project_priority`,`project_attachment`,`project_progress`,`project_comment`,`project_comment_file`,`project_published`,`project_created`,`project_created_by`,`project_modified`,`project_modified_by`) values (1,'Project 1','Description 1',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'Project 2','Description 2	',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `tbl_purchases` */

DROP TABLE IF EXISTS `tbl_purchases`;

CREATE TABLE `tbl_purchases` (
  `purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_title` varchar(255) DEFAULT NULL,
  `purchase_content` text COMMENT 'Content of the purchase',
  `purchase_username` varchar(255) DEFAULT NULL,
  `purchase_email` varchar(255) DEFAULT NULL,
  `purchase_city` varchar(255) DEFAULT NULL,
  `purchase_district` varchar(255) DEFAULT NULL,
  `purchase_address` varchar(255) DEFAULT NULL,
  `purchase_delivery_username` varchar(255) DEFAULT NULL,
  `purchase_delivery_email` varchar(255) DEFAULT NULL,
  `purchase_delivery_city` varchar(255) DEFAULT NULL,
  `purchase_delivery_district` varchar(255) DEFAULT NULL,
  `purchase_delivery_address` varchar(255) DEFAULT NULL,
  `purchase_approved` tinyint(4) DEFAULT NULL,
  `purchase_status` tinyint(4) DEFAULT NULL COMMENT 'Delivered, Not Delivered',
  `purchase_created` datetime DEFAULT NULL,
  `purchase_created_by` int(11) DEFAULT NULL,
  `purchase_modified` datetime DEFAULT NULL,
  `purchase_modified_by` int(11) DEFAULT NULL,
  `purchase_rating` int(11) DEFAULT NULL,
  `purchase_rating_content` text,
  PRIMARY KEY (`purchase_id`),
  KEY `idx_purchase_Title` (`purchase_title`),
  KEY `idx_purchase_Username` (`purchase_username`),
  KEY `idx_purchase_Email` (`purchase_email`),
  KEY `idx_purchase_City` (`purchase_city`),
  KEY `idx_purchase_District` (`purchase_district`),
  KEY `idx_purchase_Address` (`purchase_address`),
  KEY `idx_purchase_DeliveryUsername` (`purchase_delivery_username`),
  KEY `idx_purchase_DeliveryEmail` (`purchase_delivery_email`),
  KEY `idx_purchase_DeliveryCity` (`purchase_delivery_city`),
  KEY `idx_purchase_DeliveryDistrict` (`purchase_delivery_district`),
  KEY `idx_purchase_DeliveryAddress` (`purchase_delivery_address`),
  KEY `idx_purchase_Rating` (`purchase_rating`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_purchases` */

/*Table structure for table `tbl_reports` */

DROP TABLE IF EXISTS `tbl_reports`;

CREATE TABLE `tbl_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_reports` */

/*Table structure for table `tbl_rewards` */

DROP TABLE IF EXISTS `tbl_rewards`;

CREATE TABLE `tbl_rewards` (
  `reward_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`reward_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_rewards` */

/*Table structure for table `tbl_sales` */

DROP TABLE IF EXISTS `tbl_sales`;

CREATE TABLE `tbl_sales` (
  `sale_id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_title` varchar(255) DEFAULT NULL,
  `sale_description` text,
  `sale_items` text,
  `sale_created` datetime DEFAULT NULL,
  `sale_created_by` int(11) DEFAULT NULL,
  `sale_modified` datetime DEFAULT NULL,
  `sale_modified_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `idx_sale_Title` (`sale_title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_sales` */

/*Table structure for table `tbl_sessions` */

DROP TABLE IF EXISTS `tbl_sessions`;

CREATE TABLE `tbl_sessions` (
  `session_id` varchar(200) NOT NULL DEFAULT '',
  `session_guest` tinyint(4) unsigned DEFAULT '1',
  `session_time` varchar(14) DEFAULT '',
  `session_user_id` int(11) DEFAULT '0',
  `session_username` varchar(150) DEFAULT '',
  `session_user_type` varchar(50) DEFAULT '',
  PRIMARY KEY (`session_id`),
  KEY `idx_session_Id` (`session_id`),
  KEY `idx_session_UserType` (`session_user_type`),
  KEY `idx_session_Time` (`session_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `tbl_sessions` */

/*Table structure for table `tbl_settings` */

DROP TABLE IF EXISTS `tbl_settings`;

CREATE TABLE `tbl_settings` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `setting_email` varchar(50) NOT NULL,
  `setting_support_name` varchar(255) DEFAULT NULL,
  `setting_support_skype` varchar(50) NOT NULL,
  `setting_support_yahoo` varchar(50) NOT NULL,
  `setting_support_phone` varchar(20) NOT NULL,
  `setting_support_email` varchar(50) DEFAULT NULL,
  `setting_support_name2` varchar(255) DEFAULT NULL,
  `setting_support_skype2` varchar(50) DEFAULT NULL,
  `setting_support_yahoo2` varchar(50) DEFAULT NULL,
  `setting_support_phone2` varchar(20) DEFAULT NULL,
  `setting_support_email2` varchar(50) DEFAULT NULL,
  `setting_support_name3` varchar(255) DEFAULT NULL,
  `setting_support_skype3` varchar(50) DEFAULT NULL,
  `setting_support_yahoo3` varchar(50) DEFAULT NULL,
  `setting_support_phone3` varchar(20) DEFAULT NULL,
  `setting_support_email3` varchar(50) DEFAULT NULL,
  `setting_support_name4` varchar(255) DEFAULT NULL,
  `setting_support_skype4` varchar(50) DEFAULT NULL,
  `setting_support_yahoo4` varchar(50) DEFAULT NULL,
  `setting_support_phone4` varchar(20) DEFAULT NULL,
  `setting_support_email4` varchar(50) DEFAULT NULL,
  `setting_support_name5` varchar(255) DEFAULT NULL,
  `setting_support_skype5` varchar(50) DEFAULT NULL,
  `setting_support_yahoo5` varchar(50) DEFAULT NULL,
  `setting_support_phone5` varchar(20) DEFAULT NULL,
  `setting_support_email5` varchar(50) DEFAULT NULL,
  `setting_hotline` varchar(20) NOT NULL,
  `setting_domain` varchar(100) NOT NULL,
  `setting_author` varchar(50) NOT NULL,
  `setting_tag_limit` int(11) NOT NULL,
  `setting_box_limit` int(11) NOT NULL,
  `setting_list_limit` int(11) NOT NULL,
  `setting_ga_id` varchar(100) DEFAULT NULL,
  `setting_google_tag_manager` varchar(100) DEFAULT NULL,
  `setting_map_api` varchar(255) DEFAULT NULL,
  `setting_map_lat` varchar(255) DEFAULT NULL,
  `setting_map_long` varchar(255) DEFAULT NULL,
  `setting_showroom_partner_basic` tinyint(1) DEFAULT '1',
  `setting_multi_country` tinyint(1) DEFAULT '0',
  `setting_show_facebook` tinyint(1) DEFAULT '0',
  `setting_facebook` tinytext NOT NULL,
  `setting_twitter` tinytext NOT NULL,
  `setting_youtube` tinytext NOT NULL,
  `setting_google_plus` tinytext NOT NULL,
  `setting_face_app_id` varchar(255) NOT NULL,
  `facebook_likebox_width` int(11) NOT NULL,
  `facebook_likebox_height` int(11) NOT NULL,
  `facebook_comment_width` int(11) NOT NULL,
  `facebook_comment_numberrow` int(11) NOT NULL,
  `setting_title_web` varchar(255) NOT NULL,
  `setting_keyword_web` varchar(255) NOT NULL,
  `setting_description_web` tinytext NOT NULL,
  `setting_company` varchar(255) NOT NULL,
  `setting_company_address` varchar(255) DEFAULT NULL,
  `setting_product_color` tinyint(1) DEFAULT '0',
  `setting_product_size` tinyint(1) DEFAULT '0',
  `setting_product_size_number` tinyint(1) unsigned zerofill DEFAULT '0',
  `setting_image_in_content` int(4) DEFAULT NULL,
  `resize_image_tiny` int(3) DEFAULT NULL,
  `resize_image_tiny_height` int(3) DEFAULT NULL,
  `resize_image_min` int(3) NOT NULL,
  `resize_image_min_height` int(3) NOT NULL,
  `resize_image_normal` int(3) NOT NULL,
  `resize_image_normal_height` int(3) NOT NULL,
  `resize_image_max` int(4) NOT NULL,
  `resize_image_max_height` int(4) NOT NULL,
  `resize_news_image_tiny` int(3) DEFAULT NULL,
  `resize_news_image_tiny_height` int(3) DEFAULT NULL,
  `resize_news_image_thumbnail` int(3) NOT NULL,
  `resize_news_image_thumbnail_height` int(3) NOT NULL,
  `resize_news_image_normal` int(3) NOT NULL,
  `resize_news_image_normal_height` int(3) NOT NULL,
  `resize_news_image_large` int(3) NOT NULL,
  `resize_news_image_large_height` int(3) NOT NULL,
  `resize_mobile_image_width` int(3) DEFAULT NULL,
  `resize_mobile_image_height` int(3) DEFAULT NULL,
  `resize_mobile_news_image_width` int(3) DEFAULT NULL,
  `resize_mobile_news_image_height` int(3) DEFAULT NULL,
  `setting_signature_on` tinyint(1) DEFAULT '0',
  `setting_signature_text` text,
  `mail_type` varchar(20) NOT NULL,
  `mail_smtpport` double NOT NULL,
  `mail_smtpuser` varchar(255) NOT NULL,
  `mail_smtppass` varchar(255) NOT NULL,
  `mail_smtphost` varchar(255) NOT NULL,
  `url_logo` varchar(255) NOT NULL,
  `url_favicon` varchar(255) DEFAULT NULL,
  `slogan` varchar(255) DEFAULT NULL,
  `cache_on` tinyint(4) DEFAULT NULL,
  `cache_time` int(11) DEFAULT NULL,
  `install_module` tinytext,
  PRIMARY KEY (`setting_id`),
  KEY `idx_setting_Id` (`setting_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `tbl_settings` */

insert  into `tbl_settings`(`setting_id`,`site_id`,`setting_email`,`setting_support_name`,`setting_support_skype`,`setting_support_yahoo`,`setting_support_phone`,`setting_support_email`,`setting_support_name2`,`setting_support_skype2`,`setting_support_yahoo2`,`setting_support_phone2`,`setting_support_email2`,`setting_support_name3`,`setting_support_skype3`,`setting_support_yahoo3`,`setting_support_phone3`,`setting_support_email3`,`setting_support_name4`,`setting_support_skype4`,`setting_support_yahoo4`,`setting_support_phone4`,`setting_support_email4`,`setting_support_name5`,`setting_support_skype5`,`setting_support_yahoo5`,`setting_support_phone5`,`setting_support_email5`,`setting_hotline`,`setting_domain`,`setting_author`,`setting_tag_limit`,`setting_box_limit`,`setting_list_limit`,`setting_ga_id`,`setting_google_tag_manager`,`setting_map_api`,`setting_map_lat`,`setting_map_long`,`setting_showroom_partner_basic`,`setting_multi_country`,`setting_show_facebook`,`setting_facebook`,`setting_twitter`,`setting_youtube`,`setting_google_plus`,`setting_face_app_id`,`facebook_likebox_width`,`facebook_likebox_height`,`facebook_comment_width`,`facebook_comment_numberrow`,`setting_title_web`,`setting_keyword_web`,`setting_description_web`,`setting_company`,`setting_company_address`,`setting_product_color`,`setting_product_size`,`setting_product_size_number`,`setting_image_in_content`,`resize_image_tiny`,`resize_image_tiny_height`,`resize_image_min`,`resize_image_min_height`,`resize_image_normal`,`resize_image_normal_height`,`resize_image_max`,`resize_image_max_height`,`resize_news_image_tiny`,`resize_news_image_tiny_height`,`resize_news_image_thumbnail`,`resize_news_image_thumbnail_height`,`resize_news_image_normal`,`resize_news_image_normal_height`,`resize_news_image_large`,`resize_news_image_large_height`,`resize_mobile_image_width`,`resize_mobile_image_height`,`resize_mobile_news_image_width`,`resize_mobile_news_image_height`,`setting_signature_on`,`setting_signature_text`,`mail_type`,`mail_smtpport`,`mail_smtpuser`,`mail_smtppass`,`mail_smtphost`,`url_logo`,`url_favicon`,`slogan`,`cache_on`,`cache_time`,`install_module`) values (1,0,'',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','','',0,0,0,NULL,NULL,NULL,NULL,NULL,1,0,0,'','','','','',0,0,0,0,'','','','',NULL,0,0,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'',0,'','','','',NULL,NULL,NULL,NULL,NULL),(2,1,'minhtuyendang2011@gmail.com','Đặng Minh Tuyến','minhtuyendang2011','minhtuyendang2011','0915154292','minhtuyendang2011@gmail.com','','','','','','','','','','','','','','','','','','','','','0915154292','xuatkhaulaodongceo.vn','Đặng Minh Tuyến',10,7,20,'UA-93478211-1',NULL,'','','',1,0,1,'https://www.facebook.com/xuatkhaulaodongceo.vn/','','','','113621375835334',700,380,700,10,'Xuất khẩu lao động, du học Nhật Bản','lao dong nhat ban, lao động nhật bản, xuat khau lao dong nhat ban, xuất khẩu lao động nhật bản, xuat khau lao dong, xuất khẩu lao động, xuatkhaulaodong, du hoc nhat ban, du học nhật bản','Công ty xuất khẩu lao động CEO chuyên hỗ trợ khách hàng có nhu cầu du học và xuất khẩu lao động sang Nhật Bản, Hàn Quốc, Đài Loan đảm bảo uy tín, chất lượng.','Xuất Khẩu Lao Động - Ceo Groups','',0,0,0,0,0,0,0,0,0,0,0,0,53,53,135,77,225,160,500,310,0,0,0,0,1,'<p style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: Helvetica, Arial, sans-serif; text-align: center; line-height: 21px;\" align=\"center\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 13pt; vertical-align: baseline; background: transparent; line-height: 150%;\"><span style=\"box-sizing: border-box; font-weight: bold; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-family: Times New Roman; color: #fb0007;\"><img src=\"http://xuatkhaulaodongceo.vn/include/elfinder/../../images/files/xuatkhaulaodongceo.vn/logo-headcty.png\" alt=\"\" width=\"223\" height=\"100\" /></span></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 13px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: Helvetica, Arial, sans-serif; text-align: center; line-height: 21px;\" align=\"center\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 13pt; vertical-align: baseline; background: transparent; line-height: 150%;\"><span style=\"box-sizing: border-box; font-weight: bold; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-family: Times New Roman; color: #fb0007;\">Tư vấn thắc mắc về chi ph&iacute; cũng như đơn h&agrave;ng</span></span><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-family: Times New Roman;\">&nbsp;&nbsp;</span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: Helvetica, Arial, sans-serif;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 13pt; vertical-align: baseline; background: transparent; line-height: 150%; color: #008000;\"><a style=\"box-sizing: border-box; background: transparent; color: #428bca; text-decoration: none; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline;\" href=\"http://xuatkhaulaodongceo.vn/\"><span style=\"box-sizing: border-box; font-weight: bold; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; color: #008000;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-family: Times New Roman; color: #1d1d1d;\">C&Ocirc;NG TY CỔ PHẦN PH&Aacute;T TRIỂN DỊCH VỤ C.E.O</span></span></a></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: Helvetica, Arial, sans-serif;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 13pt; vertical-align: baseline; background: transparent; font-family: Times New Roman; color: #1d1d1d; line-height: 150%;\">-&nbsp;<span style=\"box-sizing: border-box; font-weight: bold; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\">&nbsp;Trụ sở ch&iacute;nh:</span>T&ograve;a Th&aacute;p CEO, Phạm H&ugrave;ng, Mỹ Đ&igrave;nh, H&agrave; Nội.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: Helvetica, Arial, sans-serif;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 13pt; vertical-align: baseline; background: transparent; line-height: 150%;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-family: Times New Roman; color: #1d1d1d;\">- &nbsp;</span><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-family: Times New Roman; color: #1a1a1a;\">VP: Trường CĐ Đại Việt, L&ocirc; 2B - X3, Nguyễn Cơ Thạch, KĐT Mỹ Đ&igrave;nh 1, Từ Li&ecirc;m, H&agrave; Nội</span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: Helvetica, Arial, sans-serif;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 13pt; vertical-align: baseline; background: transparent; font-family: Times New Roman; color: #0e0f14; line-height: 150%;\">- &nbsp;Đặng Minh Tuyến&nbsp;- Ph&ograve;ng&nbsp;tuyển dụng&nbsp;Nhật Bản</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: Helvetica, Arial, sans-serif;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 13pt; vertical-align: baseline; background: transparent; line-height: 150%;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-family: Times New Roman; color: #0e0f14;\">- &nbsp;Điện thoại/ Zalo/Line:&nbsp;</span><span style=\"box-sizing: border-box; font-weight: bold; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-family: Times New Roman; color: #fb0007;\">0915.154.292</span></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: Helvetica, Arial, sans-serif;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 13pt; vertical-align: baseline; background: transparent; line-height: 150%;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-family: Times New Roman; color: #0e0f14;\">- &nbsp;Website:&nbsp;</span><a style=\"box-sizing: border-box; background: transparent; color: #428bca; text-decoration: none; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline;\" href=\"http://xuatkhaulaodongceo.vn/\">http://xuatkhaulaodongceo.vn</a></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: Helvetica, Arial, sans-serif;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 13pt; vertical-align: baseline; background: transparent; line-height: 150%;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-family: Times New Roman; color: #0e0f14;\">- &nbsp;</span><a style=\"box-sizing: border-box; background: transparent; color: #428bca; text-decoration: none; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline;\" href=\"https://www.facebook.com/xuatkhaulaodongceo.vn/\">https://www.facebook.com/xuatkhaulaodongceo.vn</a></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: Helvetica, Arial, sans-serif;\">&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; font-size: 14px; vertical-align: baseline; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: Helvetica, Arial, sans-serif; text-align: center; line-height: 21px;\" align=\"center\"><span style=\"box-sizing: border-box; font-weight: bold; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; font-size: 13pt;\"><span style=\"box-sizing: border-box; margin: 0px; padding: 0px; border: 0px; outline: 0px; vertical-align: baseline; background: transparent; line-height: 32px; font-family: Times New Roman; color: #f60074;\">KH&Ocirc;NG THẾ CHẤP T&Agrave;I SẢN - KH&Ocirc;NG TIỀN K&Yacute; QUỸ - KH&Ocirc;NG C&Ograve; MỒI M&Ocirc;I GIỚI</span></span></p>','smtp',25,'info@xuatkhaulaodongceo.vn','123xkldceo!@#','mail.xuatkhaulaodongceo.vn','logo-site-1-1489055475.jpg','favicon-site-1-1509439640.png','',1,600,NULL),(3,2,'vietthuyit@gmail.com','hotline','vietthuyph','vietthuyph','0912352668','vietthuyit@gmail.com','','','','','','','','','','','','','','','','','','','','','0912352668','hoanghungci.com.vn','Bùi Việt Thùy',10,7,15,'UA-93541567-1',NULL,NULL,NULL,NULL,1,0,0,'','','','','',0,0,0,0,'HOANG HUNG CI., JSC','hoàng hưng, hoang hung, cong ty cp hoang hung','Công ty cổ phần đầu tư thương mai và xuất nhập khẩu hoàng hưng','Công Ty Cổ Phần Đầu Tư Thương Mai Và Xuất Nhập Khẩu Hoàng Hưng',NULL,0,0,NULL,NULL,0,0,0,0,0,0,0,0,53,53,135,77,225,160,500,310,NULL,NULL,NULL,NULL,0,'','',0,'','','','logo-site-2-1489266566.jpg',NULL,NULL,1,600,NULL),(4,3,'congtyvmax@gmail.com','','','','','','','','','','','','','','','','','','','','','','','','','','0936444988','truyenthongvmax.com','Nguyễn Hùng',4,4,10,'',NULL,NULL,NULL,NULL,1,0,1,'https://www.facebook.com/xuatkhaulaodongceo.vn/','','','','113621375835334',300,280,700,10,'Truyền thông VMax','Thiết kế website, thiết kế website chuyên nghiệp, thiết kế web, thiết kế web chuyên nghiệp, thiet ke website, thiet ke web, tim viec, tuyen dung, bds, bat dong san, thuong mai dien tu, san pham, mua ban, công ty thiết kế web','Thiết kế website chuyên nghiệp với nhiều năm kinh nghiệm trong lĩnh vực phát triển các dự án website lớn nhỏ theo các yêu cầu đặc thù riêng của mỗi khách hàng','Công ty TNHH Truyền Thông Xuất Nhập Khẩu Việt Nam',NULL,0,0,NULL,NULL,0,0,0,0,0,0,0,0,65,55,147,79,276,91,400,600,NULL,NULL,NULL,NULL,0,'','',0,'','','','logo-site-3-1489506908.png',NULL,NULL,1,600,NULL),(5,4,'anhtuantravel1984sjc@gmail.com','','','','','','','','','','','','','','','','','','','','','','','','','','0973848788','anhtuantravel.com','Bùi Văn Tuấn',4,4,10,'',NULL,NULL,NULL,NULL,1,0,1,'https://www.facebook.com/xuatkhaulaodongceo.vn/','','','','113621375835334',300,280,700,10,'Anh Tuấn Travel  SJC','anh tuan travel, anh tuấn travel, travel, thuê xe cưới, thuê xe du lịch, thuê xe, dịch vụ du lịch, dich vu thue xe du lich, cho thue xe','Anh Tuấn Travel SJC chuyên cung cấp dịch vụ thuê xe cho đám cưới hay thuê xe du lịch khắp các miền','TNHH TM & DV Du Lịch Anh Tuấn',NULL,0,0,NULL,NULL,0,0,0,0,0,0,0,0,65,55,147,79,276,188,400,400,NULL,NULL,NULL,NULL,0,'','',0,'','','','logo-site-4-1489553670.png',NULL,NULL,1,600,NULL),(6,5,'',NULL,'','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','','',0,0,0,NULL,NULL,NULL,NULL,NULL,1,0,0,'','','','','',0,0,0,0,'','','','',NULL,0,0,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'',0,'','','','',NULL,NULL,NULL,NULL,NULL),(7,6,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','',0,0,0,'',NULL,'','','',1,0,0,'','','','','',0,0,0,0,'Chất lượng - Đúng giá','','','','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',0,'','','','logo-site-6-1496901253.png',NULL,'',1,600,NULL),(8,8,'contact@hn-pdp.info','THPT Phan Đình Phùng','thptphandinhphung','thptphandinhphung','0438452811','contact@hn-pdp.info','','','','','','','','','','','','','','','','','','','','','0438452811','thptphandinhphunghn.edu.vn','THPT Phan Đình Phùng',10,7,15,'',NULL,NULL,NULL,NULL,1,0,0,'','','','','',0,0,0,0,'THPT Phan Đình Phùng','THPT Phan Đình Phùng, phan dinh phung, thph phan dinh phung ha noi, thpt phan dinh phung, truong cap 3 phan dinh phung, phan dinh phung ha noi','THPT Phan Đình Phùng Hà Nội','THPT Phan Đình Phùng',NULL,0,0,NULL,NULL,0,0,0,0,0,0,0,0,53,53,135,77,225,160,500,310,NULL,NULL,NULL,NULL,0,'','',0,'','','','logo-site-8-1492424889.png',NULL,NULL,1,60,NULL),(9,11,'namphuongoffice@gmail.com','Nam Phương','npmayvanphong','npmayvanphong','0943.75.79.68','namphuongoffice@gmail.com','Mr Cường','npmayvanphong','npmayvanphong','0943.75.79.68','namphuongoffice@gmail.com','','','','','','','','','','','','','','','','0943.75.79.68','namphuong.net','Thái Mạnh Cường',5,10,50,'UA-101505555-11','GTM-T4QJM7J','','','',1,0,1,'https://www.facebook.com/Thiết-bị-văn-phòng-namphuongnet-370936706690954','','','','563588220657238',0,0,0,0,'Công ty TNHH & Dịch Vụ Nam Phương','namphuong, cong ty nam phuong, muc in nam phuong, dich vu may tinh, dich vu do muc, dich vu thay trong, các dịch vụ máy in, các dịch vụ máy tinh, muc in chat luong, may in chat luong, cho thuê máy photo, văn phòng phẩm tổng hợp','Công ty TNHH phát triển thương mại và dịch vụ Nam Phương chuyên cung cấp thiết bị máy văn phòng, cung cấp văn phòng phẩm tổng hợp, cho thuê máy photo và các dịch vụ về đổ mực, sửa chữa máy in, máy ph','CÔNG TY TNHH PHÁT TRIỂN THƯƠNG MẠI VÀ DỊCH VỤ NAM PHƯƠNG','',0,0,0,0,80,80,100,100,150,150,300,300,40,35,55,40,85,70,200,155,0,0,0,0,0,'','',0,'','','','logo-site-11-1491279668.jpg',NULL,'',1,300,NULL),(10,9,'domuchanoi2@gmail.com','Mr Hòa','domuchanoi1','domuchanoi1','09866.02.866','domuchanoi2@gmail.com','Mr Công','domuchanoi1','domuchanoi1','0986.714.363','domuchanoi2@gmail.com','','','','','','','','','','','','','','','','09866.02.866','domuchanoi.vn','Nguyễn Duy Hòa',5,10,50,'1531106740548685',NULL,NULL,NULL,NULL,1,0,1,'https://www.facebook.com/khoinguyenprinter/','','','','',0,0,0,0,'Mực In Khôi Nguyên','domuchanoi.vn, do muc ha noi, muc do ha noi, do muc tan noi, thay phu kien may in, phu kien may in, may photo','Công ty mực in Khôi Nguyên chuyên thay thế phụ kiện máy in, máy tính, máy photo, cung cấp các sản phẩm mực in màu, mực in đen trắng cho các loại máy','Công Ty Khôi Nguyên','',0,0,0,0,90,90,100,100,150,150,300,300,40,35,55,40,85,70,200,155,NULL,NULL,NULL,NULL,0,'','',0,'','','','logo-site-9-1491321748.jpg',NULL,'',0,60,NULL),(11,12,'banhtebacninh@gmail.com','','','','','','','','','','','','','','','','','','','','','','','','','','0948.32.37.37','banhtebacninh.vn','Nguyễn Duy Hòa',0,0,0,'',NULL,NULL,NULL,NULL,1,0,0,'','','','','',0,0,0,0,'Đặc Sản Bánh Tẻ Bắc Ninh','Bánh tẻ Làng Chờ, Ba làng Mịn, chín làng Chờ, Một làng Ô Cách chơ vơ giữa đồng, Đặc sản Bắc Ninh, bánh tẻ ngon','Bánh tẻ Phú Nhi Sơn Tây đậm đà chất quê xứ đoài','Bánh Tẻ Bắc Ninh',NULL,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,0,'','',0,'','','','logo-site-12-1491889783.png',NULL,NULL,1,600,NULL),(12,13,'minhtamdnv2626@gmail.com','Tạp Chí Doanh Nhân','tapchidoanhnhanviet','tapchidoanhnhanviet','090.325.5114','minhtamdnv2626@gmail.com','','','','','','','','','','','','','','','','','','','','','090.325.5114','tapchidoanhnhanviet.vn','Nguyễn Minh Tâm',10,7,15,'',NULL,NULL,NULL,NULL,1,0,0,'','','','','',0,0,0,0,'Tạp chí doanh nhân Việt','tapchidoanhnhanviet, tap chi doanh nhan viet, tạp chí doanh nhân, doanh nhân Việt, doanh nhân thành đạt, doanh nhan thanh dat, cau chuyen thanh cong','Tạp chí doanh nhân Việt là nơi quy tụ và vinh danh các doanh nhân thành đạt, nổi tiếng của đất nước Việt Nam','Tạp chí doanh Nhân Việt Nam','',0,0,0,0,0,0,0,0,0,0,0,0,53,53,135,77,225,160,500,310,NULL,NULL,NULL,NULL,0,'','',0,'','','','logo-site-13-1492568950.png',NULL,'',0,60,NULL),(13,7,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','',0,0,0,'',NULL,NULL,NULL,NULL,1,0,0,'','','','','',0,0,0,0,'','','','',NULL,0,0,NULL,NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,0,'','',0,'','','','',NULL,NULL,1,600,NULL),(14,14,'sypb.it84@gmail.com','','','','0962214234','phamdu2708@gmail.com','','','','0962214234','phamdu2708@gmail.com','','','','0962214234','phamdu2708@gmail.com','','','','0962214234','phamdu2708@gmail.com','','','','0962214234','phamdu2708@gmail.com','0962214234','thainguyentech.com','Phạm Văn Dự',10,10,20,'',NULL,NULL,NULL,NULL,1,0,0,'','','','','',0,0,0,0,'Thái Nguyên Technology','nha-thong-minh, dien-thong-minh, tuoi-cay-tu-dong, smarthome, thai-nguyen, dien-thong-minh-thai-nguyen, tuoi-cay-tu-dong-thai-nguyen','','Công ty cổ phần Thái Nguyên Technology','Tân thịnh - Thành phố Thái Nguyên',0,0,0,0,165,165,190,190,230,230,380,380,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,0,'','',0,'','','','logo-site-14-1500556412.png',NULL,'Nhà của bạn, tâm huyết của chúng tôi',0,60,NULL),(15,10,'info.zamashop@gmail.com','','','','','','','','','','','','','','','','','','','','','','','','','','0978686055','zama.vn','Kiều Văn Ngọc',10,10,20,'UA-101720280-1',NULL,'',NULL,NULL,1,0,1,'https://www.facebook.com/Shop-th%E1%BB%9Di-trang-Zama-652196234976070/','','','','115518772393285',340,280,0,0,'Zama','','','Công ty TNHH Zama','Số nhà 10, Phương Canh , Từ Liêm, Hà Nội',1,1,1,700,165,165,190,190,250,250,550,550,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,0,'','',0,'','','','logo-site-10-1496901506.png',NULL,'',0,60,NULL),(16,15,'thoitrangagin@gmail.com','','','','','','','','','','','','','','','','','','','','','','','','','','0941436333','agin.vn','Nguyễn Văn Quân',8,16,16,'1852669051720186',NULL,'AIzaSyAvTQSdB1QZs2VZmlKR-aiZABFDF-6lNSw','21.032395','105.798920',1,0,1,'https://www.facebook.com/agin.vn/','','','','166735043924224',268,200,268,200,'AGIN','agin, agin.vn, thời trang, thoi trang, vay dam, vest cong so, so mi, quan, juyp, măng tô','Thời trang Agin cung cấp các mẫu mã thiết kế hiện đại, trẻ trung','AGIN','Số 155 Cầu Giấy, Quận Cầu Giấy, Hà Nội',1,1,0,0,60,105,186,192,373,570,1000,1512,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',0,'','','','logo-site-15-1495445785.png',NULL,'',0,60,NULL),(17,16,'','','','','','','','','','','','','','','','','','','','','','','','','','','','dacsan4phuong.vn','',20,20,20,'',NULL,'','','',1,0,0,'','','','','',0,0,0,0,'Đặc sản 4 phương','','','','',0,0,0,0,130,135,186,192,373,570,1000,1512,150,150,250,250,500,250,600,450,NULL,NULL,NULL,NULL,1,'<p><em><span style=\"font-size: 12pt; font-family: arial, helvetica, sans-serif;\">Giao h&agrave;ng miễn ph&iacute; trong b&aacute;n k&iacute;nh 3km với đơn h&agrave;ng từ 200.000 </span></em></p>\r\n<p><em><span style=\"font-size: 12pt; font-family: arial, helvetica, sans-serif;\">Nếu qu&aacute; số km sẽ t&iacute;nh l&agrave; 2000 đ/km</span></em></p>','',0,'','','','','favicon-site-16-1509010938.png','',0,60,NULL),(18,17,'ngoinhachungttt@gmail.com','','','','','','','','','','','','','','','','','','','','','','','','','','0982261369','adeal24h.com','',4,9,20,'','','','','',1,0,0,'','','','','',0,0,0,0,'Bất Động Sản Adeal24','','','Ngôi Nhà Chung','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,247,214,247,214,600,600,0,0,0,0,0,'','',0,'','','','logo-site-17-1508255214.png','favicon-site-17-1509101193.png','Tìm không gian sống, thêm lựa chọn tương lai...',0,60,NULL),(19,18,'thicongnha.vn@gmail.com','','','','0988888358','','','','','','','','','','','','','','','','','','','','','','0988888358','nhas.com.vn','',10,20,20,'UA-109282681-1',NULL,'',NULL,NULL,1,0,1,'https://www.facebook.com/kientrucnhas/','','','','',300,150,0,0,'Nhà S','','','Ngôi Nhà Chung','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,400,400,0,0,0,0,NULL,NULL,NULL,NULL,0,'','',0,'','','','','favicon-site-18-1509868146.png','Tìm không gian sống, thêm lựa chọn tương lai...',0,60,NULL),(20,19,'longtran250874@gmail.com','','kieu.van.ngoc','','','','','','','','','','','','','','','','','','','','','','','','0982356688','visanet.top','Trần Ngọc Long',10,5,20,'UA-109259170-1','','AIzaSyDljE53nEDDduQbQpWpz4JWyS7LfDJhSOg','21.034381','105.765443',1,1,1,'https://www.facebook.com/WeNet-952562084894533/','','','','135331443751259',0,0,850,20,'VISANET','visanet, dinh cu, du hoc, dinh cu Uc, du hoc Uc, dich vu dinh cu, dich vu du hoc','Visanet hỗ trợ định cư và du học tại Úc, chúng tôi cung cấp các dịch vụ hỗ trợ khách hàng trong việc định cư và du học','Reallink','',0,0,0,0,0,0,0,0,0,0,0,0,65,55,250,250,400,250,750,450,0,0,300,280,0,'','',0,'','','','logo-site-19-1508571767.png','favicon-site-19-1508768087.png','',0,600,NULL),(21,20,'','','','','','','','','','','','','','','','','','','','','','','','','','','','buynet.click','',10,20,50,'',NULL,'',NULL,NULL,1,0,0,'','','','','',0,0,0,0,'Hệ thống bán hàng Buynet','','','','',0,0,0,0,0,0,350,350,0,0,0,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,0,'','',0,'','','','logo-site-20-1508742667.png','favicon-site-20-1508742667.png','',0,60,NULL),(22,21,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','',0,0,0,'',NULL,NULL,NULL,NULL,1,0,0,'','','','','',0,0,0,0,'','','','','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,0,'','',0,'','','','',NULL,'',0,60,NULL),(23,22,'nhansuvip365@gmail.com','','','','','','','','','','','','','','','','','','','','','','','','','','0869119611','bimatphongthe.vn','Đào Xuân Trường',0,0,0,'UA-109881309-1',NULL,'','','',1,0,1,'https://business.facebook.com/Shoptitangel-243283046113161/','','','','',0,0,0,0,'Sex Expert','Sex expert, bi mat phong the, tang kich thuoc duong vat, ho tro sinh ly, yeu lau hon, chuyen gia tinh duc','Sex Expert là các sản phẩm hỗ trợ quan hệ tình dục, được sản xuất và phân phối tại Nga','','',0,0,0,0,80,82,350,360,424,482,479,440,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',0,'','','','logo-site-22-1510900728.png','favicon-site-22-1510891270.png','Giảm giá 60%!',0,60,NULL);

/*Table structure for table `tbl_system_emails` */

DROP TABLE IF EXISTS `tbl_system_emails`;

CREATE TABLE `tbl_system_emails` (
  `system_email_id` int(11) NOT NULL AUTO_INCREMENT,
  `system_email_name` varchar(255) NOT NULL,
  `system_email_title` varchar(255) DEFAULT NULL,
  `system_email_description` text,
  `system_email_subject` varchar(255) NOT NULL,
  `system_email_body` text,
  `system_email_vars` varchar(200) DEFAULT NULL,
  `system_email_lang` varchar(2) DEFAULT 'vi',
  PRIMARY KEY (`system_email_id`),
  KEY `idx_system_email_Id` (`system_email_id`),
  KEY `idx_system_email_Name` (`system_email_name`),
  KEY `idx_system_email_Title` (`system_email_title`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tbl_system_emails` */

insert  into `tbl_system_emails`(`system_email_id`,`system_email_name`,`system_email_title`,`system_email_description`,`system_email_subject`,`system_email_body`,`system_email_vars`,`system_email_lang`) values (1,'ForgotPass','Quên mật khẩu','link kích hoạt tạo mật khẩu mới','Email tạo mật khẩu mới','<p>Xin chào <strong>[user_name]</strong>,</p>\r\n<p>Chúng tôi nhận được yêu cầu tạo lại mật khẩu đăng nhập tài khoản. Hệ thống sẽ tự động tạo lại mật khẩu mới và gửi tới email <a href=\"%5Buser_email%5D\">[user_email]</a> nếu bạn click vào link sau:<br /><br /><a href=\"%5Buser_link%5D\">[user_link]</a></p>\r\n<p>Nếu quý khách không thể nhấp chuột vào đường dẫn, quý khách hãy sao chép và dán địa chỉ trang web vào trình duyệt<br /><br />..............................................................................................................................</p>\r\n<p>Đây là email tự động. Việc hồi âm cho địa chỉ email này sẽ không được ghi nhận.<br /><br /><strong>LƯU Ý</strong><br /><br /><em>Thông  tin trong thư điện tử này là riêng tư và được bảo mật, và chỉ dành  riêng cho người nhận. Nếu bạn không phải là người được nhận, xin thông  báo với bạn là mọi sự tiết lộ, sao chép, phát tán hoặc sử dụng các  thông tin này đều bị nghiêm cấm. Nếu bạn nhận được bức thư này vì  nhầm lẫn, vui lòng xóa bỏ bức thư này mà không được phép sao chép  hay tiết lộ thông tin trong thư.</em></p>','undefined','vi'),(2,'Register','Xác thực Email','Gửi cho khách đăng ký để xác thực Email','Đăng ký tài khoản - Xác nhận địa chỉ Email','<p>Xin chào [fullname],<br /><br />Cảm ơn quý khách đã đăng ký tài khoản.<br /><br /><strong>Hãy nhấp chuột vào đường dẫn bên dưới để xác nhận địa chỉ email của quý khách </strong><br /><br /><a href=\"[link]\" target=\"_blank\">[link]</a><br /><br />Quý khách sẽ bị quay trả lại trang web chủ để hoàn tất việc đăng ký<br /><br />Nếu quý khách không thể nhấp chuột vào đường dẫn, quý khách hãy sao chép và dán địa chỉ trang web vào trình duyệt<br /><br />..............................................................................................................................</p>\r\n<p>Đây là email tự động. Việc hồi âm cho địa chỉ email này sẽ không được ghi nhận.<br /><br /><strong>LƯU Ý</strong><br /><br /><em>Thông tin trong thư điện tử này là riêng tư và được bảo mật, và chỉ dành riêng cho người nhận. Nếu bạn không phải là người được nhận, xin thông báo với bạn là mọi sự tiết lộ, sao chép, phát tán hoặc sử dụng các thông tin này đều bị nghiêm cấm. Nếu bạn nhận được bức thư này vì nhầm lẫn, vui lòng xóa bỏ bức thư này mà không được phép sao chép hay tiết lộ thông tin trong thư.</em></p>','undefined','vi'),(3,'ChangePass','Thay đổi mật khẩu','Thay đổi mật khẩu user','Thay đổi mật khẩu','<p>Xin chào <strong>[user_name]</strong>,</p>\r\n<p>Hệ thống đã tạo lại mật khẩu cho tài khoản của bạn. Mật khẩu mới để truy cập là:</p>\r\n<p>[user_password] <br /><br />..............................................................................................................................</p>\r\n<p>Đây là email tự động. Việc hồi âm cho địa chỉ email này sẽ không được ghi nhận.<br /><br /><strong>LƯU Ý</strong><br /><br /><em>Thông  tin trong thư điện tử này là riêng tư và được bảo mật, và chỉ dành  riêng cho người nhận. Nếu bạn không phải là người được nhận, xin thông  báo với bạn là mọi sự tiết lộ, sao chép, phát tán hoặc sử dụng các  thông tin này đều bị nghiêm cấm. Nếu bạn nhận được bức thư này vì  nhầm lẫn, vui lòng xóa bỏ bức thư này mà không được phép sao chép  hay tiết lộ thông tin trong thư.</em></p>','undefined','vi');

/*Table structure for table `tbl_task_users` */

DROP TABLE IF EXISTS `tbl_task_users`;

CREATE TABLE `tbl_task_users` (
  `task_id` int(11) NOT NULL,
  `task_user_id` int(11) NOT NULL,
  `task_user_created` datetime NOT NULL,
  `task_user_created_by` int(11) NOT NULL,
  `task_user_modified` datetime DEFAULT NULL,
  `task_user_modified_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`task_id`,`task_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_task_users` */

/*Table structure for table `tbl_tasks` */

DROP TABLE IF EXISTS `tbl_tasks`;

CREATE TABLE `tbl_tasks` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of task',
  `task_project_id` int(11) NOT NULL COMMENT 'Project ID',
  `task_parent_id` int(11) DEFAULT NULL COMMENT 'Parent id task',
  `task_start_time` datetime NOT NULL COMMENT 'Start time of task',
  `task_end_time` datetime NOT NULL COMMENT 'End time of task',
  `task_price` int(11) DEFAULT NULL COMMENT 'Price',
  `task_content` text,
  `task_progress` int(11) NOT NULL DEFAULT '0' COMMENT 'Progress of task',
  `task_created` datetime NOT NULL COMMENT 'Created time',
  `task_created_by` int(11) NOT NULL COMMENT 'Created user',
  `task_modified` datetime NOT NULL COMMENT 'Modified time',
  `task_modified_by` int(11) NOT NULL COMMENT 'Modified user',
  `task_status` int(11) NOT NULL DEFAULT '0' COMMENT 'Status of task: New, Processing, Finished',
  `task_published` datetime NOT NULL COMMENT 'Published, Unpublished',
  `task_attachment` varchar(255) NOT NULL DEFAULT '' COMMENT 'Attachment file',
  PRIMARY KEY (`task_id`),
  KEY `idx_task_name` (`task_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `tbl_tasks` */

/*Table structure for table `tbl_templates` */

DROP TABLE IF EXISTS `tbl_templates`;

CREATE TABLE `tbl_templates` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `template_name` varchar(255) NOT NULL,
  `template_department` int(11) NOT NULL,
  `template_project_id` int(11) NOT NULL,
  `template_due_date` date DEFAULT NULL,
  `template_content` text,
  `template_price` int(11) DEFAULT NULL,
  `template_created` datetime DEFAULT NULL,
  `template_created_by` int(11) DEFAULT NULL,
  `template_modified` datetime DEFAULT NULL,
  `template_modified_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`template_id`),
  KEY `idx_template_Name` (`template_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `tbl_templates` */

insert  into `tbl_templates`(`template_id`,`template_name`,`template_department`,`template_project_id`,`template_due_date`,`template_content`,`template_price`,`template_created`,`template_created_by`,`template_modified`,`template_modified_by`) values (1,'Templates 1',3,2,'2017-12-20','332323\r\n111',1202000,'2017-12-13 23:30:42',38,'2017-12-13 23:31:45',38);

/*Table structure for table `tbl_users` */

DROP TABLE IF EXISTS `tbl_users`;

CREATE TABLE `tbl_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL DEFAULT '',
  `user_email` varchar(50) NOT NULL DEFAULT '',
  `user_username` varchar(50) NOT NULL DEFAULT '',
  `user_password` varchar(50) NOT NULL DEFAULT '',
  `user_password_method` tinyint(1) NOT NULL DEFAULT '1',
  `user_code` varchar(16) NOT NULL DEFAULT '',
  `user_group` tinyint(3) NOT NULL DEFAULT '2' COMMENT '1 : administrator, 2 : manager site, 3 : user site, 4 : all site, 5 : sale manager, 6 : sale, 7 : reconciliation, 8 : Support, 9 : translator',
  `user_access` longtext,
  `user_created` int(11) NOT NULL DEFAULT '1',
  `user_registerDate` datetime DEFAULT NULL,
  `user_lastvisitDate` datetime DEFAULT NULL,
  `user_enabled` tinyint(4) NOT NULL DEFAULT '1',
  `user_avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `idx_admin_Id` (`user_id`),
  KEY `idx_admin_Group` (`user_group`),
  KEY `idx_admin_Create` (`user_created`),
  KEY `idx_admin_Name` (`user_name`),
  KEY `idx_admin_Email` (`user_email`),
  KEY `idx_admin_Username` (`user_username`),
  KEY `idx_admin_Enabled` (`user_enabled`),
  KEY `idx_admin_condition` (`user_id`,`user_group`,`user_name`,`user_created`,`user_enabled`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

/*Data for the table `tbl_users` */

insert  into `tbl_users`(`user_id`,`user_name`,`user_email`,`user_username`,`user_password`,`user_password_method`,`user_code`,`user_group`,`user_access`,`user_created`,`user_registerDate`,`user_lastvisitDate`,`user_enabled`,`user_avatar`) values (1,'Kiều Văn Ngọc','ngockv@gmail.com','kieuvanngoc','11a96bf17f3fd8093dd7c443ce9628b8',1,'A2OLyR4BizBmAhLT',1,NULL,1,'2017-04-05 03:49:59','2017-12-14 11:50:09',1,NULL),(38,'Quản trị viên','tester@email.com','admin','d4fd232c7dce166b12230400dca68a25',1,'A2OLyR4BizBmAhLT',1,NULL,1,'2017-04-05 03:49:59','2017-12-13 21:02:38',1,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
