-- KPRM2 Database Backup
-- Generated: 2026-10-13 13:52:19
-- Database: kprm2_db

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

-- --------------------------------------------------------
-- Structure for table `case_data`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `case_data`;
CREATE TABLE `case_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `case_id` int NOT NULL,
  `column_id` int NOT NULL,
  `data_value` text,
  PRIMARY KEY (`id`),
  KEY `case_id` (`case_id`),
  KEY `column_id` (`column_id`),
  CONSTRAINT `case_data_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  CONSTRAINT `case_data_ibfk_2` FOREIGN KEY (`column_id`) REFERENCES `structure_columns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `case_data`
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('210', '25', '69', '1');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('211', '25', '70', 'January');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('212', '25', '71', 'Bihar');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('213', '25', '72', 'Bihar');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('214', '25', '73', 'Branch');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('215', '25', '74', 'HL');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('216', '25', '75', '123456575');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('217', '25', '76', '3465657');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('218', '25', '77', '3456465');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('219', '25', '78', 'KUMAR SAURABH');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('220', '25', '79', '324');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('221', '25', '80', 'Umanagar');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('222', '25', '81', '09431426600');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('223', '25', '82', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('224', '25', '83', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('225', '25', '84', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('226', '25', '85', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('227', '25', '86', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('228', '25', '87', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('229', '25', '88', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('230', '25', '89', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('231', '25', '90', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('232', '25', '91', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('233', '25', '92', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('234', '25', '93', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('235', '25', '94', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('236', '25', '95', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('237', '25', '96', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('238', '25', '97', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('239', '25', '98', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('240', '25', '99', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('241', '25', '100', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('242', '25', '101', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('243', '25', '102', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('244', '25', '103', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('245', '25', '104', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('246', '25', '105', '23');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('247', '25', '106', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('248', '25', '107', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('249', '25', '108', 'asdd');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('250', '25', '109', 'sdad');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('251', '25', '110', '2345f');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('252', '25', '111', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('253', '25', '112', 'adswe');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('254', '25', '113', 'eewr');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('255', '25', '114', 'Test ');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('256', '30', '70', 'Aug 2026');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('257', '30', '71', 'NORTH');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('258', '30', '72', 'DELHI');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('259', '30', '73', 'LAJPAT NAGAR');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('260', '30', '74', 'HL');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('261', '30', '75', 'asdfdsgf');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('262', '30', '76', '3465657');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('263', '30', '77', 'Test Helo');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('264', '30', '78', 'KUMAR SAURABH');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('265', '30', '79', '324');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('266', '30', '80', 'Umanagar');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('267', '30', '81', '09431426600');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('268', '30', '82', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('269', '30', '83', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('270', '30', '84', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('271', '30', '85', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('272', '30', '86', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('273', '30', '87', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('274', '30', '88', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('275', '30', '89', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('276', '30', '91', '2026-08-31');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('277', '30', '108', 'RMOCS');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('278', '30', '109', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('279', '30', '110', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('280', '30', '114', 'RMOCS');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('281', '30', '93', '0');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('282', '32', '70', 'Aug 2026');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('283', '32', '71', 'NORTH');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('284', '32', '72', 'DELHI');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('285', '32', '73', 'LAJPAT NAGAR');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('286', '32', '74', 'HL');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('287', '32', '75', '343243535');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('288', '32', '76', '3465657');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('289', '32', '77', 'Test Helo');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('290', '32', '78', 'KUMAR SAURABH');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('291', '32', '79', '324');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('292', '32', '80', 'Umanagar');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('293', '32', '81', '09431426600');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('294', '32', '82', 'sdsadds');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('295', '32', '83', 'dsadf');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('296', '32', '84', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('297', '32', '85', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('298', '32', '86', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('299', '32', '87', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('300', '32', '88', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('301', '32', '89', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('302', '32', '91', '2026-08-31');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('303', '32', '108', 'RMOCS');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('304', '32', '109', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('305', '32', '110', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('306', '32', '114', 'RMOCS');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('307', '32', '93', '0');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('308', '34', '160', 'Sep 2026');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('309', '34', '161', 'sasdfdsgf');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('310', '34', '162', 'Salaried');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('311', '34', '163', 'HL');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('312', '34', '164', 'q321345');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('313', '34', '165', '324546');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('314', '34', '166', '3234546');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('315', '34', '167', 'MANDATORY');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('316', '34', '170', '2026-09-02');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('317', '34', '172', '0');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('318', '34', '173', 'RM OUTSOURCING');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('319', '35', '160', 'Sep 2026');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('320', '35', '161', 'Delhi');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('321', '35', '162', 'Salaried');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('322', '35', '163', 'HL');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('323', '35', '164', 'abcd1234');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('324', '35', '165', 'Shyam');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('325', '35', '166', 'Krishna');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('326', '35', '167', 'MANDATORY');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('327', '35', '170', '2026-09-02');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('328', '35', '172', '0');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('329', '35', '173', 'RM OUTSOURCING');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('330', '42', '182', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('331', '42', '183', 'Ghaziabad 1');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('332', '42', '184', 'Salaried');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('333', '42', '185', 'HL');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('334', '42', '186', 'LOS2026080003710');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('335', '42', '187', 'Mohd Imran Khan');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('336', '42', '188', 'Mandatory');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('337', '42', '190', 'No Tasks');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('338', '42', '191', 'No tasks found.');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('339', '42', '192', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('340', '42', '193', '');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('341', '42', '194', '0');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('342', '42', '196', 'No Tasks');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('343', '42', '197', '0');
INSERT INTO `case_data` (`id`, `case_id`, `column_id`, `data_value`) VALUES ('344', '42', '198', 'Unassigned');

-- --------------------------------------------------------
-- Structure for table `case_task_data`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `case_task_data`;
CREATE TABLE `case_task_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `case_task_id` int NOT NULL,
  `task_meta_id` int NOT NULL,
  `data_value` text,
  PRIMARY KEY (`id`),
  KEY `case_task_id` (`case_task_id`),
  KEY `task_meta_id` (`task_meta_id`),
  CONSTRAINT `case_task_data_ibfk_1` FOREIGN KEY (`case_task_id`) REFERENCES `case_tasks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `case_task_data_ibfk_2` FOREIGN KEY (`task_meta_id`) REFERENCES `task_meta` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `case_task_data`
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('37', '13', '7', 'Saurabh');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('38', '13', '8', 'AFGWDDG7237A');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('39', '13', '9', '2026-27');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('40', '13', '10', 'AFGWDDG7237A');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('41', '13', '11', '2026-08-31');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('42', '13', '12', '127237273');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('49', '15', '7', 'Saurabh');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('50', '15', '8', 'ASDFAGGD');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('51', '15', '9', '2022-23');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('52', '15', '10', 'DSFDSFGD');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('53', '15', '11', '2026-08-31');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('54', '15', '12', '1244567');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('55', '16', '7', 'Saurabh');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('56', '16', '8', 'AFGWDDG7237A');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('57', '16', '9', '2026-27');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('58', '16', '10', 'DSFDSFGD');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('59', '16', '11', '2026-08-31');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('60', '16', '12', '2314546');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('61', '17', '7', 'ASDFGDG');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('62', '17', '8', 'AFGWDDG7237A');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('63', '17', '9', '2026-27');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('64', '17', '10', 'AFGWDDG7237A');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('65', '17', '11', '2026-09-24');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('66', '17', '12', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('67', '18', '7', 'Shyam');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('68', '18', '8', 'AHTPVD3245F');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('69', '18', '9', '25-26');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('70', '18', '10', '12345600015072026');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('71', '18', '11', '2026-09-02');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('72', '18', '12', '250000');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('73', '19', '20', 'KUMAR SAURABH');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('74', '19', '21', 'DTIPS6206J');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('75', '19', '22', '2027-28');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('76', '19', '23', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('77', '19', '24', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('78', '19', '25', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('80', '24', '20', 'Abhishek');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('81', '24', '21', 'AHTKV4395K');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('82', '24', '22', '2025-2026');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('83', '24', '23', '1213214325312102025');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('84', '24', '24', '12-10-2015');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('85', '24', '25', '5698087');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('86', '25', '1', 'Ajay Sigh');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('87', '25', '2', 'A-77 Vishali sector1, Ghaziabad, UP 201010');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('88', '25', '242', '28.632664, 77.337718');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('89', '25', '243', 'Cannot upload in read-only mode');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('90', '25', '3', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('91', '25', '4', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('92', '25', '5', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('93', '25', '7', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('94', '25', '8', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('95', '25', '9', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('118', '28', '1', 'Ajay Sigh');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('119', '28', '2', '1/236 Vishali sector1, Ghaziabad, UP 201010');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('120', '28', '242', '28.632664,77.337718');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('121', '28', '243', 'Cannot upload in read-only mode');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('133', '28', '3', '1234324');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('134', '28', '4', '10:20');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('135', '28', '5', '132435`');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('136', '28', '7', 'Saurabh');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('137', '28', '8', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('138', '28', '9', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('139', '28', '6', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('140', '25', '6', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('158', '33', '222', 'OfferPlant');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('159', '33', '223', '2026-27');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('160', '33', '224', 'DIOSUus3664A');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('161', '33', '225', '');
INSERT INTO `case_task_data` (`id`, `case_task_id`, `task_meta_id`, `data_value`) VALUES ('162', '33', '245', '[{\"section\":\"P & L Statement\",\"particular\":\"Sales/Turnover\",\"provided_copy\":\"466646\",\"ito_record\":\"466646\",\"remark\":\"Matching\",\"difference\":\"0\"},{\"section\":\"P & L Statement\",\"particular\":\"Purchase\",\"provided_copy\":\"34646\",\"ito_record\":\"34646\",\"remark\":\"Matching\",\"difference\":\"0\"},{\"section\":\"P & L Statement\",\"particular\":\"Depreciation\",\"provided_copy\":\"23253\",\"ito_record\":\"23253\",\"remark\":\"Matching\",\"difference\":\"0\"},{\"section\":\"P & L Statement\",\"particular\":\"Partner/Director Remuneration\",\"provided_copy\":\"256353\",\"ito_record\":\"256353\",\"remark\":\"Matching\",\"difference\":\"0\"},{\"section\":\"P & L Statement\",\"particular\":\"PBT\",\"provided_copy\":\"2535234\",\"ito_record\":\"2535234\",\"remark\":\"Matching\",\"difference\":\"0\"},{\"section\":\"Balance Sheet Statement\",\"particular\":\"Share Capital\",\"provided_copy\":\"12563523\",\"ito_record\":\"12563523\",\"remark\":\"Matching\",\"difference\":\"0\"},{\"section\":\"Balance Sheet Statement\",\"particular\":\"Fixed Assets\",\"provided_copy\":\"2354523\",\"ito_record\":\"2354523\",\"remark\":\"Matching\",\"difference\":\"0\"},{\"section\":\"Balance Sheet Statement\",\"particular\":\"Sundry Creditor\",\"provided_copy\":\"3545\",\"ito_record\":\"3545\",\"remark\":\"Matching\",\"difference\":\"0\"},{\"section\":\"Balance Sheet Statement\",\"particular\":\"Sundry debtor\",\"provided_copy\":\"123\",\"ito_record\":\"123\",\"remark\":\"Matching\",\"difference\":\"0\"},{\"section\":\"Balance Sheet Statement\",\"particular\":\"Cash in hand & BANK\",\"provided_copy\":\"\",\"ito_record\":\"\",\"remark\":\"\",\"difference\":\"\"},{\"section\":\"Balance Sheet Statement\",\"particular\":\"Cash in Bank\",\"provided_copy\":\"\",\"ito_record\":\"\",\"remark\":\"\",\"difference\":\"\"}]');

-- --------------------------------------------------------
-- Structure for table `case_task_history`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `case_task_history`;
CREATE TABLE `case_task_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `case_task_id` int NOT NULL,
  `status` varchar(50) NOT NULL,
  `remark` text,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `case_task_id` (`case_task_id`),
  CONSTRAINT `case_task_history_ibfk_1` FOREIGN KEY (`case_task_id`) REFERENCES `case_tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Structure for table `case_tasks`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `case_tasks`;
CREATE TABLE `case_tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `case_id` int NOT NULL,
  `task_id` int NOT NULL,
  `assigned_to` int DEFAULT NULL,
  `status` enum('Pending','Assigned','Verified','Completed','Cancelled') NOT NULL DEFAULT 'Pending',
  `outcome` enum('Positive','Negative','CNV') DEFAULT NULL,
  `final_remark` text,
  `other_requirement` text,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `remarks` text,
  `attachments` text,
  `verified_at` datetime DEFAULT NULL,
  `api_dispatch_status` varchar(50) DEFAULT NULL,
  `api_dispatched_at` datetime DEFAULT NULL,
  `api_last_response` text,
  `external_status` varchar(50) DEFAULT NULL,
  `api_last_payload` text,
  PRIMARY KEY (`id`),
  KEY `case_id` (`case_id`),
  KEY `task_id` (`task_id`),
  KEY `created_by` (`created_by`),
  KEY `assigned_to` (`assigned_to`),
  CONSTRAINT `case_tasks_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`id`) ON DELETE CASCADE,
  CONSTRAINT `case_tasks_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `case_tasks_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `case_tasks_ibfk_4` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `case_tasks`
INSERT INTO `case_tasks` (`id`, `case_id`, `task_id`, `assigned_to`, `status`, `outcome`, `final_remark`, `other_requirement`, `created_by`, `created_at`, `remarks`, `attachments`, `verified_at`, `api_dispatch_status`, `api_dispatched_at`, `api_last_response`, `external_status`, `api_last_payload`) VALUES ('13', '25', '2', '4', 'Completed', 'Positive', 'ITR - We have verified an ITR of Saurabh, Pan no. AFGWDDG7237A, for AY-2026-27 and found that an ITR return has been filed with ACK No. AFGWDDG7237A, dated on 2026-08-31. Total income amount is Rs. 127237273/- Status - Positive.', NULL, '1', '2026-08-31 14:13:56', NULL, '[\"uploads/tasks/test_image.jpg\",\"uploads/tasks/gen_att_6a95e183aa21b.pptx\"]', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `case_tasks` (`id`, `case_id`, `task_id`, `assigned_to`, `status`, `outcome`, `final_remark`, `other_requirement`, `created_by`, `created_at`, `remarks`, `attachments`, `verified_at`, `api_dispatch_status`, `api_dispatched_at`, `api_last_response`, `external_status`, `api_last_payload`) VALUES ('15', '25', '2', '4', 'Completed', 'Positive', 'ITR - We have verified an ITR of Saurabh, Pan no. ASDFAGGD, for AY-2022-23 and found that an ITR return has been filed with ACK No. DSFDSFGD, dated on 2026-08-31. Total income amount is Rs. 1244567/- Status - Positive.', NULL, '1', '2026-08-31 16:37:53', 'Check All Files', '[\"uploads/tasks/test_image.jpg\",\"uploads/tasks/gen_att_6a95e183aa21b.pptx\"]', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `case_tasks` (`id`, `case_id`, `task_id`, `assigned_to`, `status`, `outcome`, `final_remark`, `other_requirement`, `created_by`, `created_at`, `remarks`, `attachments`, `verified_at`, `api_dispatch_status`, `api_dispatched_at`, `api_last_response`, `external_status`, `api_last_payload`) VALUES ('16', '25', '2', '4', 'Completed', 'Positive', 'ITR - We have verified an ITR of Saurabh, Pan no. AFGWDDG7237A, for AY-2026-27 and found that an ITR return has been filed with ACK No. DSFDSFGD, dated on 2026-08-31. Total income amount is Rs. 2314546/- Status - Positive.', NULL, '1', '2026-08-31 17:00:33', 'asdfdfhg', '[\"uploads/tasks/test_image.jpg\",\"uploads/tasks/gen_att_6a95e183aa21b.pptx\"]', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `case_tasks` (`id`, `case_id`, `task_id`, `assigned_to`, `status`, `outcome`, `final_remark`, `other_requirement`, `created_by`, `created_at`, `remarks`, `attachments`, `verified_at`, `api_dispatch_status`, `api_dispatched_at`, `api_last_response`, `external_status`, `api_last_payload`) VALUES ('17', '32', '2', '4', 'Completed', 'Positive', 'ITR - We have verified an ITR of ASDFGDG, Pan no. AFGWDDG7237A, for AY-2026-27 and found that an ITR return has been filed with ACK No. AFGWDDG7237A, dated on 2026-09-24. Total income amount is Rs. /- Status - Positive.', NULL, '1', '2026-09-01 02:10:45', 'asdsg Details here', '[\"uploads\\/tasks\\/gen_att_6a95e71004a1f.png\",\"uploads\\/tasks\\/gen_att_6a95e71004c0b.png\"]', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `case_tasks` (`id`, `case_id`, `task_id`, `assigned_to`, `status`, `outcome`, `final_remark`, `other_requirement`, `created_by`, `created_at`, `remarks`, `attachments`, `verified_at`, `api_dispatch_status`, `api_dispatched_at`, `api_last_response`, `external_status`, `api_last_payload`) VALUES ('18', '35', '2', '4', 'Completed', 'Positive', 'ITR - We have verified an ITR of Shyam, Pan no. AHTPVD3245F, for AY-25-26 and found that an ITR return has been filed with ACK No. 12345600015072026, dated on 2026-09-02. Total income amount is Rs. 250000/- Status - Positive.', NULL, '1', '2026-09-02 14:47:49', '', '[\"uploads\\/tasks\\/gen_att_6a97ea486439d.pdf\"]', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `case_tasks` (`id`, `case_id`, `task_id`, `assigned_to`, `status`, `outcome`, `final_remark`, `other_requirement`, `created_by`, `created_at`, `remarks`, `attachments`, `verified_at`, `api_dispatch_status`, `api_dispatched_at`, `api_last_response`, `external_status`, `api_last_payload`) VALUES ('19', '35', '3', '4', 'Completed', 'Positive', 'ITR - We have verified an ITR of #applicant_name#, Pan no. #document_no#, for AY-#financial_year# and found that an ITR return has been filed with ACK No. #ack_no#, dated on #dorf#. Total income amount is Rs. #total_income#/- Status - Positive.', NULL, '1', '2026-09-03 01:27:20', '', '[\"uploads\\/tasks\\/gen_att_6ab3ba94662ce.zip\"]', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `case_tasks` (`id`, `case_id`, `task_id`, `assigned_to`, `status`, `outcome`, `final_remark`, `other_requirement`, `created_by`, `created_at`, `remarks`, `attachments`, `verified_at`, `api_dispatch_status`, `api_dispatched_at`, `api_last_response`, `external_status`, `api_last_payload`) VALUES ('20', '38', '3', NULL, 'Pending', NULL, NULL, NULL, '5', '2026-09-19 12:05:46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `case_tasks` (`id`, `case_id`, `task_id`, `assigned_to`, `status`, `outcome`, `final_remark`, `other_requirement`, `created_by`, `created_at`, `remarks`, `attachments`, `verified_at`, `api_dispatch_status`, `api_dispatched_at`, `api_last_response`, `external_status`, `api_last_payload`) VALUES ('24', '42', '3', '4', 'Completed', 'Positive', 'ITR - We have verified an ITR of Abhishek, Pan no. AHTKV4395K, for AY-2025-2026 and found that an ITR return has been filed with ACK No. 1213214325312102025, dated on 12-10-2015. Total income amount is Rs. 5698087/- Status - Positive.', NULL, '5', '2026-09-21 17:33:37', '', '[\"uploads\\/tasks\\/gen_att_6ab3ba835dde8.pdf\"]', NULL, 'Dispatched', '2026-10-07 20:57:59', '{\"id\":1125404,\"status\":\"success\",\"msg\":\" Data Added Successfully\"}', NULL, '{\"ref_id\":24,\"ref_site\":\"https:\\/\\/kprm.co.in\\/public\\/api_task_update.php\",\"name_of_document\":\"ITR\",\"pan\":\"AHTKV4395K\",\"ay\":\"2025-2026\",\"requirement\":\"\"}');
INSERT INTO `case_tasks` (`id`, `case_id`, `task_id`, `assigned_to`, `status`, `outcome`, `final_remark`, `other_requirement`, `created_by`, `created_at`, `remarks`, `attachments`, `verified_at`, `api_dispatch_status`, `api_dispatched_at`, `api_last_response`, `external_status`, `api_last_payload`) VALUES ('25', '42', '1', '6', 'Completed', 'Positive', 'Residence - Applicant Name – Ajay Sigh- Visit done by field executive at the given address – A-77 Vishali sector1, Ghaziabad, UP 201010. Address is exit at the given locality. Met with   at the given address and he/she has confirm that, he/she is staying at the address for the last  at  premises. Total family members are . The area of premises is . The given address is in  and address is traceable. TPC confirmation was taken from   and they have confirmed the applicant’s stability at the address.', 'kon mila hai uska naam or designation\r\nApplicant kab se kam karta hai or designation kya hai\r\noffice me kya kaam hota hai\r\nOther staff se confirm kar lena ki applicant ki designation kya hai or kab se kaam kar raha hai', '5', '2026-09-21 18:14:57', 'MET person self.\r\nSince 40 by \r\nFamily 5\r\nWorking 1\r\nAREA 450 yrad \r\nTotal floor 1 \r\nIndependent house \r\nTpc confirm right side House female \r\nTPC confirm right side House female', '[\"uploads\\/tasks\\/gen_att_6ab3b99c548f8.jpeg\",\"uploads\\/tasks\\/gen_att_6ab3b99c54b7d.jpeg\",\"uploads\\/tasks\\/gen_att_6ab3b99c54d1a.jpeg\"]', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `case_tasks` (`id`, `case_id`, `task_id`, `assigned_to`, `status`, `outcome`, `final_remark`, `other_requirement`, `created_by`, `created_at`, `remarks`, `attachments`, `verified_at`, `api_dispatch_status`, `api_dispatched_at`, `api_last_response`, `external_status`, `api_last_payload`) VALUES ('28', '42', '1', '4', 'Completed', 'Positive', 'Residence - Applicant Name – Ajay Sigh- Visit done by field executive at the given address – 1/236 Vishali sector1, Ghaziabad, UP 201010. Address is exit at the given locality. Met with  1234324 at the given address and he/she has confirm that, he/she is staying at the address for the last 10:20 at 132435` premises. Total family members are . The area of premises is Saurabh. The given address is in  and address is traceable. TPC confirmation was taken from   and they have confirmed the applicant’s stability at the address.', NULL, '5', '2026-09-23 17:16:31', 'sdfdgfgdrg', '[\"uploads\\/tasks\\/gen_att_6ab3c85b82267.docx\"]', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `case_tasks` (`id`, `case_id`, `task_id`, `assigned_to`, `status`, `outcome`, `final_remark`, `other_requirement`, `created_by`, `created_at`, `remarks`, `attachments`, `verified_at`, `api_dispatch_status`, `api_dispatched_at`, `api_last_response`, `external_status`, `api_last_payload`) VALUES ('33', '42', '46', '4', 'Completed', 'Positive', 'Given financial statements of OfferPlant for the Financial year 2026-27 with Pan No. DIOSUus3664A  has been verified from the concern department and found  below observations: Status-', 'oK na', '1', '2026-10-07 21:26:47', '', '[]', '2026-10-07 22:00:27', 'Dispatched', '2026-10-07 21:26:48', '{\"id\":1125406,\"status\":\"success\",\"msg\":\" Data Added Successfully\"}', NULL, '{\"ref_id\":33,\"ref_site\":\"https:\\/\\/kprm.co.in\\/public\\/api_task_update.php\",\"name_of_document\":\"FINANCIAL\",\"pan\":\"DIOSUus3664A\",\"ay\":\"2026-27\",\"requirement\":\"oK na\"}');

-- --------------------------------------------------------
-- Structure for table `cases`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `cases`;
CREATE TABLE `cases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structure_id` int NOT NULL,
  `created_by` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(50) DEFAULT 'Pending',
  `final_remark` text,
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `closed_at` datetime DEFAULT NULL,
  `closed_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `structure_id` (`structure_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `cases_ibfk_1` FOREIGN KEY (`structure_id`) REFERENCES `client_structures` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cases_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `cases`
INSERT INTO `cases` (`id`, `structure_id`, `created_by`, `created_at`, `status`, `final_remark`) VALUES ('25', '3', '1', '2026-08-31 14:13:30', 'Positive', 'ITR - We have verified an ITR of Saurabh, Pan no. AFGWDDG7237A, for AY-2026-27 and found that an ITR return has been filed with ACK No. AFGWDDG7237A, dated on 2026-08-31. Total income amount is Rs. 127237273/- Status - Positive. | ITR - We have verified an ITR of Saurabh, Pan no. ASDFAGGD, for AY-2022-23 and found that an ITR return has been filed with ACK No. DSFDSFGD, dated on 2026-08-31. Total income amount is Rs. 1244567/- Status - Positive. | ITR - We have verified an ITR of Saurabh, Pan no. AFGWDDG7237A, for AY-2026-27 and found that an ITR return has been filed with ACK No. DSFDSFGD, dated on 2026-08-31. Total income amount is Rs. 2314546/- Status - Positive.');
INSERT INTO `cases` (`id`, `structure_id`, `created_by`, `created_at`, `status`, `final_remark`) VALUES ('30', '3', '1', '2026-09-01 00:00:35', 'Pending', NULL);
INSERT INTO `cases` (`id`, `structure_id`, `created_by`, `created_at`, `status`, `final_remark`) VALUES ('32', '3', '1', '2026-09-01 02:10:01', 'Positive', 'ITR - We have verified an ITR of ASDFGDG, Pan no. AFGWDDG7237A, for AY-2026-27 and found that an ITR return has been filed with ACK No. AFGWDDG7237A, dated on 2026-09-24. Total income amount is Rs. /- Status - Positive.');
INSERT INTO `cases` (`id`, `structure_id`, `created_by`, `created_at`, `status`, `final_remark`) VALUES ('34', '6', '1', '2026-09-02 14:40:13', 'Pending', NULL);
INSERT INTO `cases` (`id`, `structure_id`, `created_by`, `created_at`, `status`, `final_remark`) VALUES ('35', '6', '1', '2026-09-02 14:45:05', 'Pending', NULL);
INSERT INTO `cases` (`id`, `structure_id`, `created_by`, `created_at`, `status`, `final_remark`) VALUES ('38', '6', '5', '2026-09-19 12:05:10', 'Pending', NULL);
INSERT INTO `cases` (`id`, `structure_id`, `created_by`, `created_at`, `status`, `final_remark`) VALUES ('39', '3', '1', '2026-09-21 16:10:10', 'Pending', NULL);
INSERT INTO `cases` (`id`, `structure_id`, `created_by`, `created_at`, `status`, `final_remark`) VALUES ('42', '7', '1', '2026-09-21 16:34:31', 'Positive', 'ITR - We have verified an ITR of Abhishek, Pan no. AHTKV4395K, for AY-2025-2026 and found that an ITR return has been filed with ACK No. 1213214325312102025, dated on 12-10-2015. Total income amount is Rs. 5698087/- Status - Positive. | Residence - Applicant Name – Ajay Sigh- Visit done by field executive at the given address – A-77 Vishali sector1, Ghaziabad, UP 201010. Address is exit at the given locality. Met with   at the given address and he/she has confirm that, he/she is staying at the address for the last  at  premises. Total family members are . The area of premises is . The given address is in  and address is traceable. TPC confirmation was taken from   and they have confirmed the applicant’s stability at the address. | Residence - Applicant Name – Ajay Sigh- Visit done by field executive at the given address – 1/236 Vishali sector1, Ghaziabad, UP 201010. Address is exit at the given locality. Met with  1234324 at the given address and he/she has confirm that, he/she is staying at the address for the last 10:20 at 132435` premises. Total family members are . The area of premises is Saurabh. The given address is in  and address is traceable. TPC confirmation was taken from   and they have confirmed the applicant’s stability at the address. | Given financial statements of OfferPlant for the Financial year 2026-27 with Pan No. DIOSUus3664A  has been verified from the concern department and found  below observations: Status-');

-- --------------------------------------------------------
-- Structure for table `client_structures`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `client_structures`;
CREATE TABLE `client_structures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `sheet_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `client_structures_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `client_structures`
INSERT INTO `client_structures` (`id`, `client_id`, `sheet_name`, `created_at`) VALUES ('3', '3', 'SAMPLED', '2026-08-31 13:39:01');
INSERT INTO `client_structures` (`id`, `client_id`, `sheet_name`, `created_at`) VALUES ('6', '4', 'Mis Tracker', '2026-09-02 13:43:17');
INSERT INTO `client_structures` (`id`, `client_id`, `sheet_name`, `created_at`) VALUES ('7', '5', 'Mis Tracker', '2026-09-21 15:24:35');

-- --------------------------------------------------------
-- Structure for table `clients`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `email_reports_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `keyword_positive` varchar(50) DEFAULT NULL,
  `keyword_negative` varchar(50) DEFAULT NULL,
  `keyword_cnv` varchar(50) DEFAULT NULL,
  `agency_name` varchar(255) DEFAULT NULL,
  `agency_stamp` varchar(255) DEFAULT NULL,
  `smtp_account_id` int DEFAULT NULL,
  `whatsapp_account_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `clients`
INSERT INTO `clients` (`id`, `name`, `email`, `email_reports_enabled`, `created_at`, `keyword_positive`, `keyword_negative`, `keyword_cnv`, `agency_name`, `agency_stamp`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('3', 'Sarswat', NULL, '1', '2026-08-31 13:38:28', 'Success', 'Fail', 'Not Decided', 'KPRM', 'uploads/stamps/1788209552_Screenshot 2026-01-31 081625.png', NULL, '-1');
INSERT INTO `clients` (`id`, `name`, `email`, `email_reports_enabled`, `created_at`, `keyword_positive`, `keyword_negative`, `keyword_cnv`, `agency_name`, `agency_stamp`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('4', 'Indusind Bank Ltd', NULL, '1', '2026-09-01 13:08:36', 'Positive', 'Negative', 'CNV', 'RM Outsourcing and Consultancy Services', 'uploads/stamps/1788365402_ll.jpeg', NULL, '-1');
INSERT INTO `clients` (`id`, `name`, `email`, `email_reports_enabled`, `created_at`, `keyword_positive`, `keyword_negative`, `keyword_cnv`, `agency_name`, `agency_stamp`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('5', 'DMI Housing Finance', '', '1', '2026-09-21 15:17:01', 'Positive', 'Negative', 'CNV', 'R M Outsourcing and Consultancy Services', 'uploads/stamps/1789984021_sign.jpg', '-1', '4');

-- --------------------------------------------------------
-- Structure for table `column_rbac`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `column_rbac`;
CREATE TABLE `column_rbac` (
  `id` int NOT NULL AUTO_INCREMENT,
  `column_id` int NOT NULL,
  `role_id` int NOT NULL,
  `access_level` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `column_id` (`column_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `column_rbac_ibfk_1` FOREIGN KEY (`column_id`) REFERENCES `structure_columns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `column_rbac_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=479 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `column_rbac`
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('249', '69', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('250', '69', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('251', '69', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('252', '69', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('253', '69', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('254', '70', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('255', '70', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('256', '70', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('257', '70', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('258', '70', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('259', '71', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('260', '71', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('261', '71', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('262', '71', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('263', '71', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('264', '72', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('265', '72', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('266', '72', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('267', '72', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('268', '72', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('269', '73', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('270', '73', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('271', '73', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('272', '73', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('273', '73', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('274', '74', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('275', '74', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('276', '74', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('277', '74', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('278', '74', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('279', '75', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('280', '75', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('281', '75', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('282', '75', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('283', '75', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('284', '76', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('285', '76', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('286', '76', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('287', '76', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('288', '76', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('289', '77', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('290', '77', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('291', '77', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('292', '77', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('293', '77', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('294', '78', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('295', '78', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('296', '78', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('297', '78', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('298', '78', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('299', '79', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('300', '79', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('301', '79', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('302', '79', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('303', '79', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('304', '80', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('305', '80', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('306', '80', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('307', '80', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('308', '80', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('309', '81', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('310', '81', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('311', '81', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('312', '81', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('313', '81', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('314', '82', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('315', '82', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('316', '82', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('317', '82', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('318', '82', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('319', '83', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('320', '83', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('321', '83', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('322', '83', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('323', '83', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('324', '84', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('325', '84', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('326', '84', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('327', '84', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('328', '84', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('329', '85', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('330', '85', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('331', '85', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('332', '85', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('333', '85', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('334', '86', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('335', '86', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('336', '86', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('337', '86', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('338', '86', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('339', '87', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('340', '87', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('341', '87', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('342', '87', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('343', '87', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('344', '88', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('345', '88', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('346', '88', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('347', '88', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('348', '88', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('349', '89', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('350', '89', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('351', '89', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('352', '89', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('353', '89', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('354', '90', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('355', '90', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('356', '90', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('357', '90', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('358', '90', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('359', '91', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('360', '91', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('361', '91', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('362', '91', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('363', '91', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('364', '92', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('365', '92', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('366', '92', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('367', '92', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('368', '92', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('369', '93', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('370', '93', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('371', '93', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('372', '93', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('373', '93', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('374', '94', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('375', '94', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('376', '94', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('377', '94', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('378', '94', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('379', '95', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('380', '95', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('381', '95', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('382', '95', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('383', '95', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('384', '96', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('385', '96', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('386', '96', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('387', '96', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('388', '96', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('389', '97', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('390', '97', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('391', '97', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('392', '97', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('393', '97', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('394', '98', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('395', '98', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('396', '98', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('397', '98', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('398', '98', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('399', '99', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('400', '99', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('401', '99', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('402', '99', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('403', '99', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('404', '100', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('405', '100', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('406', '100', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('407', '100', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('408', '100', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('409', '101', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('410', '101', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('411', '101', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('412', '101', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('413', '101', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('414', '102', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('415', '102', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('416', '102', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('417', '102', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('418', '102', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('419', '103', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('420', '103', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('421', '103', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('422', '103', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('423', '103', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('424', '104', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('425', '104', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('426', '104', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('427', '104', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('428', '104', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('429', '105', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('430', '105', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('431', '105', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('432', '105', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('433', '105', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('434', '106', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('435', '106', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('436', '106', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('437', '106', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('438', '106', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('439', '107', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('440', '107', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('441', '107', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('442', '107', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('443', '107', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('444', '108', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('445', '108', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('446', '108', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('447', '108', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('448', '108', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('449', '109', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('450', '109', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('451', '109', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('452', '109', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('453', '109', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('454', '110', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('455', '110', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('456', '110', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('457', '110', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('458', '110', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('459', '111', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('460', '111', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('461', '111', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('462', '111', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('463', '111', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('464', '112', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('465', '112', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('466', '112', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('467', '112', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('468', '112', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('469', '113', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('470', '113', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('471', '113', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('472', '113', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('473', '113', '5', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('474', '114', '1', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('475', '114', '2', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('476', '114', '3', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('477', '114', '4', 'Edit');
INSERT INTO `column_rbac` (`id`, `column_id`, `role_id`, `access_level`) VALUES ('478', '114', '5', 'Edit');

-- --------------------------------------------------------
-- Structure for table `communication_accounts`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `communication_accounts`;
CREATE TABLE `communication_accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_type` enum('smtp','whatsapp') COLLATE utf8mb4_general_ci NOT NULL,
  `task_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'ALL',
  `title` varchar(120) COLLATE utf8mb4_general_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'active',
  `config_json` text COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `communication_accounts`
INSERT INTO `communication_accounts` (`id`, `account_type`, `task_type`, `title`, `is_default`, `status`, `config_json`, `created_at`, `updated_at`) VALUES ('1', 'whatsapp', 'ALL', 'ITR', '1', 'active', '{\"green_api_instance\":\"710722705616\",\"green_api_token\":\"5e2ee6862ae642bab89ab0ae6654599d57886d9c133246f3b6\",\"green_api_url\":\"https:\\/\\/7107.api.greenapi.com\"}', '2026-09-03 01:13:40', '2026-09-03 01:13:40');
INSERT INTO `communication_accounts` (`id`, `account_type`, `task_type`, `title`, `is_default`, `status`, `config_json`, `created_at`, `updated_at`) VALUES ('2', 'smtp', 'ALL', 'itrrmcs Gmail', '1', 'active', '{\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":465,\"smtp_username\":\"itrrmcs@gmail.com\",\"smtp_password\":\"jbxvzkkrqounrebt\",\"smtp_encryption\":\"ssl\",\"smtp_from_email\":\"itrrmcs@gmail.com\",\"smtp_from_name\":\"KPRM2 System\"}', '2026-09-03 01:16:36', '2026-09-03 01:18:19');
INSERT INTO `communication_accounts` (`id`, `account_type`, `task_type`, `title`, `is_default`, `status`, `config_json`, `created_at`, `updated_at`) VALUES ('3', 'whatsapp', 'ALL', 'Banking', '0', 'active', '{\"green_api_instance\":\"710722686724\",\"green_api_token\":\"d37d0c80c0844a86b149a3c60f20fcbe4cf8dbe64bca4a9ca1\",\"green_api_url\":\"https:\\/\\/7107.api.greenapi.com\"}', '2026-09-03 01:42:36', '2026-09-03 01:42:36');
INSERT INTO `communication_accounts` (`id`, `account_type`, `task_type`, `title`, `is_default`, `status`, `config_json`, `created_at`, `updated_at`) VALUES ('4', 'whatsapp', 'PHYSICAL', 'Physical', '0', 'active', '{\"green_api_instance\":\"7107641404\",\"green_api_token\":\"f248907c7309474f973edb767c265abc921f819605b14530a5\",\"green_api_url\":\"https:\\/\\/7107.api.greenapi.com\"}', '2026-09-03 01:43:04', '2026-10-07 17:39:33');

-- --------------------------------------------------------
-- Structure for table `communication_templates`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `communication_templates`;
CREATE TABLE `communication_templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `channel` enum('email','whatsapp') COLLATE utf8mb4_general_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_general_ci NOT NULL,
  `account_id` int DEFAULT NULL,
  `event_trigger` varchar(50) COLLATE utf8mb4_general_ci DEFAULT 'manual',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `communication_templates`
INSERT INTO `communication_templates` (`id`, `name`, `channel`, `subject`, `body`, `account_id`, `event_trigger`, `created_at`, `updated_at`) VALUES ('1', 'Send task to Verifier', 'whatsapp', '', '#client_name#\r\n\r\n#task_name#\r\n\r\n#Task_Fields#', '1', 'when_assigned', '2026-09-03 01:29:32', '2026-09-21 19:05:24');

-- --------------------------------------------------------
-- Structure for table `report_mappings`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `report_mappings`;
CREATE TABLE `report_mappings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `report_template_id` int NOT NULL,
  `target_cell` varchar(10) NOT NULL,
  `mapping_type` enum('Fixed','Address','Function') NOT NULL,
  `mapping_value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `report_template_id` (`report_template_id`),
  CONSTRAINT `report_mappings_ibfk_1` FOREIGN KEY (`report_template_id`) REFERENCES `report_templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3016 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `report_mappings`
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1558', '8', 'A1', 'Fixed', 'RCU Verification Report - Saraswat Co-Operative Bank Ltd');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1559', '8', 'E1', 'Fixed', 'Sr. No');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1560', '8', 'A2', 'Fixed', 'REGION');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1561', '8', 'B2', 'Address', 'C1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1562', '8', 'E2', 'Fixed', '17');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1563', '8', 'A3', 'Fixed', 'STATE');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1564', '8', 'B3', 'Address', 'D1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1565', '8', 'A4', 'Fixed', 'BRANCH');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1566', '8', 'B4', 'Address', 'E1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1567', '8', 'A5', 'Fixed', 'APPLICANT NAME/FIRM NAME');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1568', '8', 'A6', 'Fixed', 'PRODUCT');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1569', '8', 'B6', 'Address', 'F1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1570', '8', 'A7', 'Fixed', 'LOAN APPLICATION NO');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1571', '8', 'B7', 'Address', 'H1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1572', '8', 'A8', 'Fixed', 'Visit Address');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1573', '8', 'B8', 'Address', 'L1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1574', '8', 'A9', 'Fixed', 'LOAN AMOUNT');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1575', '8', 'B9', 'Address', 'H1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1576', '8', 'A10', 'Fixed', 'DATE SAMPLED');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1577', '8', 'B10', 'Address', 'W1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1578', '8', 'A11', 'Fixed', 'DATE REPORTED');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1579', '8', 'B11', 'Address', 'X1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1580', '8', 'A12', 'Fixed', 'DOCUMENT PICKED');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1581', '8', 'B12', 'Fixed', 'Local OGL');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1582', '8', 'C12', 'Fixed', 'STATUS (RECOMMENDED/REFER TO CREDIT/RDD/RPD)');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1583', '8', 'A13', 'Fixed', 'ITR');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1584', '8', 'B13', 'Fixed', '2025-26');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1585', '8', 'C13', 'Fixed', 'Recommended');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1586', '8', 'C15', 'Fixed', 'Recommended');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1587', '8', 'C16', 'Fixed', 'Recommended');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1588', '8', 'A18', 'Fixed', 'Final RCU Status');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1589', '8', 'B18', 'Function', 'case_final_remarks({case_id})');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1590', '8', 'A19', 'Fixed', 'OVERALL FEEDBACK');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1591', '8', 'A20', 'Fixed', '#N/A');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1592', '8', 'A22', 'Fixed', 'RCU FINAL STATUS: -');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1593', '8', 'B22', 'Address', 'AM1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1594', '8', 'A23', 'Fixed', 'RCU AGENCY NAME ');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1595', '8', 'B5', 'Address', 'I1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1596', '8', 'B23', 'Fixed', 'KPRM Management & Investigation Services PVT Ltd');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1597', '8', 'B19', 'Address', 'AL1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1598', '8', 'C23', 'Function', 'get_agency_stamp({case_id})');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1599', '8', 'A14', 'Function', 'all_task_remarks({case_id})');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('1600', '8', 'A21', 'Function', 'case_all_attachments({case_id})');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2793', '11', 'A1', 'Fixed', 'Document Verification Remark');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2794', '11', 'A2', 'Fixed', 'Agency Name  -  ( R M Outsourcing and Consultancy services )');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2795', '11', 'A3', 'Fixed', 'App ID');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2796', '11', 'B3', 'Address', 'F1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2797', '11', 'C3', 'Fixed', 'Month');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2798', '11', 'D3', 'Address', 'B1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2799', '11', 'A4', 'Fixed', 'Branch Name');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2800', '11', 'B4', 'Address', 'C1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2801', '11', 'C4', 'Fixed', 'Product');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2802', '11', 'D4', 'Address', 'E1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2803', '11', 'A5', 'Fixed', 'Name of Customer/Applicant/Coapplicant/');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2804', '11', 'B5', 'Address', 'G1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2805', '11', 'C5', 'Fixed', 'Pick Up criteria');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2806', '11', 'D5', 'Address', 'L1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2807', '11', 'A6', 'Fixed', 'Name of Company');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2808', '11', 'B6', 'Fixed', '#N/A');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2809', '11', 'C6', 'Fixed', 'Field Executive  Name');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2810', '11', 'D6', 'Address', 'U1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2811', '11', 'A7', 'Fixed', 'Salaried/Self Employed');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2812', '11', 'B7', 'Address', 'D1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2813', '11', 'C7', 'Fixed', 'Date of pick Up');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2814', '11', 'D7', 'Address', 'L1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2815', '11', 'A8', 'Fixed', 'Overall Status');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2816', '11', 'B8', 'Address', 'J1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2817', '11', 'C8', 'Fixed', 'Date of Reverted');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2818', '11', 'D8', 'Function', 'current_date()');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2819', '11', 'A9', 'Fixed', 'Document Verification Remarks');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2820', '11', 'A10', 'Fixed', 'Verification Remarks');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2821', '11', 'B10', 'Address', 'K1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2822', '11', 'A11', 'Fixed', 'Overall Status');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2823', '11', 'B11', 'Address', 'J1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2824', '11', 'A12', 'Fixed', 'Agency Name  -  ( R M Outsourcing and Consultancy services )');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2825', '11', 'A13', 'Fixed', 'Verifier Signature and Stamp of Agency');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2826', '11', 'B13', 'Function', 'attachments({case_id})');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2985', '13', 'A1', 'Fixed', 'DMI - FCU VERIFICATION REPORT');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2986', '13', 'A2', 'Fixed', 'Agency Name  -  ( R M Outsourcing and Consultancy Services )');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2987', '13', 'A3', 'Fixed', 'APP ID');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2988', '13', 'C3', 'Fixed', 'Month');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2989', '13', 'A4', 'Fixed', 'Branch Name');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2990', '13', 'C4', 'Fixed', 'Product');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2991', '13', 'A5', 'Fixed', 'Name of Customer/Applicant/Coapplicant/ Company');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2992', '13', 'C5', 'Fixed', 'Pick Up criteria');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2993', '13', 'A6', 'Fixed', 'Salaried/Self Employed');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2994', '13', 'C6', 'Fixed', 'Date of Pick up');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2995', '13', 'A7', 'Fixed', 'Overall Status');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2996', '13', 'C7', 'Fixed', 'Date of Reverted');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2997', '13', 'A8', 'Fixed', 'Document Verification Remarks');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2998', '13', 'A9', 'Fixed', 'Verification Remarks');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('2999', '13', 'A10', 'Fixed', 'Overall Status');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3000', '13', 'A11', 'Fixed', 'Agency Name  -  ( R M Outsourcing and Consultancy Services )');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3001', '13', 'A12', 'Fixed', 'Verifier Signature and Stamp of Agency');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3002', '13', 'B3', 'Address', 'F1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3003', '13', 'D3', 'Address', 'B1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3004', '13', 'B4', 'Address', 'C1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3005', '13', 'D4', 'Address', 'E1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3006', '13', 'B5', 'Address', 'G1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3007', '13', 'D5', 'Fixed', 'Mandatory');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3008', '13', 'B6', 'Address', 'D1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3009', '13', 'D6', 'Address', 'L1');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3010', '13', 'B7', 'Function', 'overall_status({case_id})');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3011', '13', 'D7', 'Function', 'current_date()');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3012', '13', 'B9', 'Function', 'overall_remarks({case_id}, {show_task_name}, {show_task_status})');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3013', '13', 'B10', 'Function', 'overall_status({case_id})');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3014', '13', 'C12', 'Function', 'stamp({case_id})');
INSERT INTO `report_mappings` (`id`, `report_template_id`, `target_cell`, `mapping_type`, `mapping_value`) VALUES ('3015', '13', 'A13', 'Function', 'attachments({case_id})');

-- --------------------------------------------------------
-- Structure for table `report_templates`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `report_templates`;
CREATE TABLE `report_templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sheet_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_row` int NOT NULL DEFAULT '0',
  `max_col` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'A',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `layout_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `report_templates_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `report_templates`
INSERT INTO `report_templates` (`id`, `client_id`, `name`, `sheet_name`, `max_row`, `max_col`, `created_at`, `layout_config`) VALUES ('8', '3', 'Sarswat', 'Reporting', '23', 'E', '2026-08-31 08:11:14', '{\"merges\": [{\"hidden\": [\"B1\", \"C1\"], \"master\": \"A1\", \"colspan\": 3, \"rowspan\": 1}, {\"hidden\": [\"C2\"], \"master\": \"B2\", \"colspan\": 2, \"rowspan\": 1}, {\"hidden\": [\"C3\"], \"master\": \"B3\", \"colspan\": 2, \"rowspan\": 1}, {\"hidden\": [\"C4\"], \"master\": \"B4\", \"colspan\": 2, \"rowspan\": 1}, {\"hidden\": [\"C10\"], \"master\": \"B10\", \"colspan\": 2, \"rowspan\": 1}, {\"hidden\": [\"C5\"], \"master\": \"B5\", \"colspan\": 2, \"rowspan\": 1}, {\"hidden\": [\"C6\"], \"master\": \"B6\", \"colspan\": 2, \"rowspan\": 1}, {\"hidden\": [\"C7\"], \"master\": \"B7\", \"colspan\": 2, \"rowspan\": 1}, {\"hidden\": [\"C8\"], \"master\": \"B8\", \"colspan\": 2, \"rowspan\": 1}, {\"hidden\": [\"C9\"], \"master\": \"B9\", \"colspan\": 2, \"rowspan\": 1}, {\"hidden\": [\"C11\"], \"master\": \"B11\", \"colspan\": 2, \"rowspan\": 1}, {\"hidden\": [\"B14\", \"C14\"], \"master\": \"A14\", \"colspan\": 3, \"rowspan\": 1}, {\"hidden\": [\"B21\", \"C21\"], \"master\": \"A21\", \"colspan\": 3, \"rowspan\": 1}], \"styles\": {\"A1\": {\"bg\": \"#f4ef48\", \"bold\": true, \"align\": \"center\"}, \"A2\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}, \"A3\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}, \"A4\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}, \"A5\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}, \"A6\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}, \"A7\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}, \"A8\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}, \"A9\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}, \"A10\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}, \"A11\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}, \"A12\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}, \"A13\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}, \"A22\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}, \"A23\": {\"bg\": null, \"bold\": true, \"align\": \"left\"}}, \"cellData\": {\"A1\": \"RCU Verification Report - Saraswat Co-Operative Bank Ltd\", \"A2\": \"REGION\", \"A3\": \"STATE\", \"A4\": \"BRANCH\", \"A5\": \"APPLICANT NAME/FIRM NAME\", \"A6\": \"PRODUCT\", \"A7\": \"LOAN APPLICATION NO\", \"A8\": \"Visit Address\", \"A9\": \"LOAN AMOUNT\", \"B2\": \"#N/A\", \"B3\": \"#N/A\", \"B4\": \"#N/A\", \"B5\": \"#N/A\", \"B6\": \"#N/A\", \"B7\": \"#N/A\", \"B8\": \"NA\", \"B9\": \"#N/A\", \"E1\": \"Sr. No\", \"E2\": 17, \"A10\": \"DATE SAMPLED\", \"A11\": \"DATE REPORTED\", \"A12\": \"DOCUMENT PICKED\", \"A13\": \"ITR\", \"A18\": \"Final RCU Status\", \"A19\": \"OVERALL FEEDBACK \", \"A20\": \"#N/A\", \"A22\": \"RCU FINAL STATUS: - \", \"A23\": \"RCU AGENCY NAME -  KPRM Management & Investigation Services PVT Ltd\", \"B10\": \"#N/A\", \"B11\": \"#N/A\", \"B12\": \"Local OGL\", \"B13\": \"2025-26\", \"B18\": \"#N/A\", \"B22\": \"#N/A\", \"C12\": \"STATUS (RECOMMENDED/REFER TO CREDIT/RDD/RPD)\", \"C13\": \"Recommended\", \"C15\": \"Recommended\", \"C16\": \"Recommended\"}, \"colWidths\": {\"1\": \"100px\"}, \"hiddenCols\": [\"E\", \"D\"], \"hiddenRows\": [15, 16, 13, 17, 20], \"rowHeights\": {\"1\": \"30px\", \"2\": \"30px\", \"3\": \"30px\", \"4\": \"30px\", \"5\": \"30px\", \"6\": \"30px\", \"7\": \"30px\", \"8\": \"30px\", \"9\": \"30px\", \"10\": \"30px\", \"11\": \"30px\", \"12\": \"30px\", \"13\": \"30px\", \"14\": \"242px\", \"22\": \"30px\", \"23\": \"30px\"}}');
INSERT INTO `report_templates` (`id`, `client_id`, `name`, `sheet_name`, `max_row`, `max_col`, `created_at`, `layout_config`) VALUES ('11', '4', 'MAin Mis Reporting', 'Sheet1', '13', 'D', '2026-09-02 08:49:00', '{\"cellData\":{\"A1\":\"Document Verification Remarks\",\"A2\":\"Agency Name  -  ( R M Outsourcing and Consultancy services )\",\"A3\":\"App ID\",\"B3\":\"#N/A\",\"C3\":\"Month\",\"D3\":\"#N/A\",\"A4\":\"Branch Name\",\"B4\":\"#N/A\",\"C4\":\"Product\",\"D4\":\"#N/A\",\"A5\":\"Name of Customer/Applicant/Coapplicant/\",\"B5\":\"#N/A\",\"C5\":\"Pick Up criteria\",\"D5\":\"#N/A\",\"A6\":\"Name of Company \",\"B6\":\"#N/A\",\"C6\":\"Field Executive  Name\",\"D6\":\"#N/A\",\"A7\":\"Salaried/Self Employed\",\"B7\":\"#N/A\",\"C7\":\"Date of pick Up\",\"D7\":\"#N/A\",\"A8\":\"Overall Status\",\"B8\":\"#N/A\",\"C8\":\"Date of Reverted\",\"D8\":\"#N/A\",\"A9\":\"Document Verification Remarks\",\"A10\":\"Verification Remarks\",\"B10\":\"#N/A\",\"A11\":\"Overall Status\",\"B11\":\"#N/A\",\"A12\":\"Agency Name  -  ( R M Outsourcing and Consultancy services )\",\"A13\":\"Verifier Signature and Stamp of Agency\"},\"styles\":{\"A1\":{\"bg\":\"#d0d6b8\",\"bold\":true,\"align\":\"center\",\"fontSize\":\"20\"},\"A2\":{\"bg\":\"#83897f\",\"bold\":false,\"align\":\"center\",\"fontSize\":\"12\"},\"A3\":{\"bg\":null,\"bold\":true,\"align\":null,\"fontSize\":null},\"A9\":{\"bg\":\"#d0d6b8\",\"bold\":false,\"align\":null,\"fontSize\":null},\"A12\":{\"bg\":\"#d0d6b8\",\"bold\":false,\"align\":null,\"fontSize\":null},\"A4\":{\"bg\":null,\"bold\":true,\"align\":null,\"fontSize\":null},\"A5\":{\"bg\":null,\"bold\":true,\"align\":null,\"fontSize\":null},\"A6\":{\"bg\":null,\"bold\":true,\"align\":null,\"fontSize\":null},\"A7\":{\"bg\":null,\"bold\":true,\"align\":null,\"fontSize\":null},\"A8\":{\"bg\":null,\"bold\":true,\"align\":null,\"fontSize\":null},\"C3\":{\"bg\":null,\"bold\":true,\"align\":\"center\",\"fontSize\":null},\"C4\":{\"bg\":null,\"bold\":true,\"align\":\"center\",\"fontSize\":null},\"C5\":{\"bg\":null,\"bold\":true,\"align\":\"center\",\"fontSize\":null},\"C6\":{\"bg\":null,\"bold\":true,\"align\":\"center\",\"fontSize\":null},\"C7\":{\"bg\":null,\"bold\":true,\"align\":\"center\",\"fontSize\":null},\"C8\":{\"bg\":null,\"bold\":true,\"align\":\"center\",\"fontSize\":null}},\"merges\":[{\"master\":\"A1\",\"colspan\":4,\"rowspan\":1,\"hidden\":[\"B1\",\"C1\",\"D1\"]},{\"master\":\"B10\",\"colspan\":3,\"rowspan\":1,\"hidden\":[\"C10\",\"D10\"]},{\"master\":\"B11\",\"colspan\":3,\"rowspan\":1,\"hidden\":[\"C11\",\"D11\"]},{\"master\":\"A12\",\"colspan\":4,\"rowspan\":1,\"hidden\":[\"B12\",\"C12\",\"D12\"]},{\"master\":\"B13\",\"colspan\":3,\"rowspan\":1,\"hidden\":[\"C13\",\"D13\"]},{\"master\":\"A9\",\"colspan\":3,\"rowspan\":1,\"hidden\":[\"B9\",\"C9\"]},{\"master\":\"A9\",\"colspan\":4,\"rowspan\":1,\"hidden\":[\"D9\"]},{\"master\":\"A2\",\"colspan\":4,\"rowspan\":1,\"hidden\":[\"B2\",\"C2\",\"D2\"]}],\"colWidths\":{\"1\":\"100px\"},\"rowHeights\":{\"1\":\"30px\",\"2\":\"30px\",\"3\":\"30px\",\"4\":\"30px\",\"5\":\"30px\",\"6\":\"30px\",\"7\":\"30px\",\"8\":\"34px\",\"9\":\"30px\",\"10\":\"151px\",\"11\":\"35px\",\"12\":\"5px\",\"13\":\"115px\"},\"hiddenRows\":[],\"hiddenCols\":[]}');
INSERT INTO `report_templates` (`id`, `client_id`, `name`, `sheet_name`, `max_row`, `max_col`, `created_at`, `layout_config`) VALUES ('13', '5', 'PDF Report', 'Sheet1', '13', 'D', '2026-09-21 10:17:33', '{\"cellData\":{\"A1\":\"DMI - FCU VERIFICATION REPORT\",\"A2\":\"Agency Name  -  ( R M Outsourcing and Consultancy Services )\",\"A3\":\"APP ID \",\"C3\":\"Month\",\"A4\":\"Branch Name\",\"C4\":\"Product\",\"A5\":\"Name of Customer/Applicant/Coapplicant/ Company \",\"C5\":\"Pick Up criteria\",\"A6\":\"Salaried/Self Employed\",\"C6\":\"Date of Pick up \",\"A7\":\"Overall Status\",\"C7\":\"Date of Reverted\",\"A8\":\"Document Verification Remarks\",\"A9\":\"Verification Remarks\",\"A10\":\"Overall Status\",\"A11\":\"Agency Name  -  ( R M Outsourcing and Consultancy Services )\",\"A12\":\"Verifier Signature and Stamp of Agency\"},\"styles\":{\"A1\":{\"bg\":\"#bdd6ee\",\"bold\":true,\"align\":\"center\",\"fontSize\":null},\"A2\":{\"bg\":\"#bdd6ee\",\"bold\":true,\"align\":\"center\",\"fontSize\":null},\"A8\":{\"bg\":\"#bdd6ee\",\"bold\":true,\"align\":null,\"fontSize\":null},\"A11\":{\"bg\":\"#bdd6ee\",\"bold\":true,\"align\":null,\"fontSize\":null},\"B9\":{\"bg\":null,\"bold\":false,\"align\":\"justify\",\"fontSize\":null}},\"merges\":[{\"master\":\"A1\",\"colspan\":4,\"rowspan\":1,\"hidden\":[\"B1\",\"C1\",\"D1\"]},{\"master\":\"A2\",\"colspan\":4,\"rowspan\":1,\"hidden\":[\"B2\",\"C2\",\"D2\"]},{\"master\":\"A8\",\"colspan\":4,\"rowspan\":1,\"hidden\":[\"B8\",\"C8\",\"D8\"]},{\"master\":\"B9\",\"colspan\":3,\"rowspan\":1,\"hidden\":[\"C9\",\"D9\"]},{\"master\":\"B10\",\"colspan\":3,\"rowspan\":1,\"hidden\":[\"C10\",\"D10\"]},{\"master\":\"A11\",\"colspan\":2,\"rowspan\":1,\"hidden\":[\"B11\"]},{\"master\":\"A11\",\"colspan\":3,\"rowspan\":1,\"hidden\":[\"C11\"]},{\"master\":\"A11\",\"colspan\":4,\"rowspan\":1,\"hidden\":[\"D11\"]},{\"master\":\"A12\",\"colspan\":2,\"rowspan\":1,\"hidden\":[\"B12\"]},{\"master\":\"C12\",\"colspan\":2,\"rowspan\":1,\"hidden\":[\"D12\"]},{\"master\":\"A13\",\"colspan\":4,\"rowspan\":1,\"hidden\":[\"B13\",\"C13\",\"D13\"]}],\"colWidths\":{\"1\":\"100px\",\"2\":\"100px\"},\"rowHeights\":{\"1\":\"30px\",\"2\":\"30px\",\"8\":\"30px\",\"9\":\"30px\",\"11\":\"30px\"},\"hiddenRows\":[],\"hiddenCols\":[]}');

-- --------------------------------------------------------
-- Structure for table `structure_columns`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `structure_columns`;
CREATE TABLE `structure_columns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structure_id` int NOT NULL,
  `cell_address` varchar(20) NOT NULL,
  `excel_column_name` varchar(255) NOT NULL,
  `data_type` varchar(50) NOT NULL,
  `nature` varchar(50) NOT NULL,
  `default_value` varchar(255) DEFAULT NULL,
  `show_in_form` enum('Hidden','Readonly','Edit') NOT NULL DEFAULT 'Edit',
  `show_in_table` enum('Hidden','Readonly','Edit') NOT NULL DEFAULT 'Edit',
  PRIMARY KEY (`id`),
  KEY `structure_id` (`structure_id`),
  CONSTRAINT `structure_columns_ibfk_1` FOREIGN KEY (`structure_id`) REFERENCES `client_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `structure_columns`
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('69', '3', 'A1', 'Sr. No.', 'Text', 'Optional', '', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('70', '3', 'B1', 'Month', 'Calculated', 'Optional', 'current_month()', 'Readonly', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('71', '3', 'C1', 'Region', 'Text', 'Optional', 'NORTH', 'Readonly', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('72', '3', 'D1', 'State', 'Text', 'Optional', 'DELHI', 'Readonly', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('73', '3', 'E1', 'Branch', 'Text', 'Optional', 'LAJPAT NAGAR', 'Readonly', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('74', '3', 'F1', 'Products', 'Text', 'Mandatory', 'HL', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('75', '3', 'G1', 'RLOS No', 'Text', 'Mandatory', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('76', '3', 'H1', ' Loan Amount', 'Text', 'Mandatory', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('77', '3', 'I1', 'Applicant Name', 'Text', 'Mandatory', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('78', '3', 'J1', 'Name of Co-applicant // Guarnator', 'Text', 'Optional', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('79', '3', 'K1', 'App Pan Number ', 'Text', 'Mandatory', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('80', '3', 'L1', 'Residence address', 'Text', 'Optional', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('81', '3', 'M1', 'Mobile No', 'Text', 'Mandatory', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('82', '3', 'N1', 'Offce / Business Name', 'Text', 'Optional', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('83', '3', 'O1', 'Offce // Business Name Address', 'Text', 'Optional', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('84', '3', 'P1', 'Property/ Colletral Address ', 'Text', 'Optional', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('85', '3', 'Q1', 'Model', 'Text', 'Optional', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('86', '3', 'R1', ' DSA / DEALER', 'Text', 'Optional', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('87', '3', 'S1', 'RM/SM', 'Text', 'Optional', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('88', '3', 'T1', 'Document type (Sampled / Refer)', 'List', 'Optional', 'Sampled,Refer', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('89', '3', 'U1', 'Local / OGL', 'List', 'Optional', 'Local,OGL', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('90', '3', 'V1', 'Pickup Document', 'Text', 'Optional', '', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('91', '3', 'W1', 'Sampling Date', 'Calculated', 'Optional', 'current_date()', 'Readonly', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('92', '3', 'X1', 'Reporting Date', 'Date', 'Optional', '', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('93', '3', 'Y1', 'TAT', 'Calculated', 'Optional', 'tat({w1},{X1})', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('94', '3', 'Z1', 'TAT Status', 'Calculated', 'Optional', 'tat_status()', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('95', '3', 'AA1', 'ITR', 'Text', 'Optional', '', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('96', '3', 'AB1', 'FIN', 'Text', 'Optional', '', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('97', '3', 'AC1', 'BS', 'Text', 'Optional', '', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('98', '3', 'AD1', 'Sal Slip / Cert', 'Text', 'Optional', '', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('99', '3', 'AE1', 'KYC Documents', 'Text', 'Optional', '', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('100', '3', 'AF1', 'Profile / Property verfication', 'Text', 'Optional', '', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('101', '3', 'AG1', 'Patta Verification ', 'Text', 'Optional', '', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('102', '3', 'AH1', 'Sale Deed / Conveyance Deed', 'Text', 'Optional', '', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('103', '3', 'AI1', 'PTM / NOC  from Authorities', 'Text', 'Optional', '', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('104', '3', 'AJ1', 'Other Documents (with name)', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('105', '3', 'AK1', 'Total Documents', 'Calculated', 'Optional', 'total_docs({case_id})', 'Hidden', 'Readonly');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('106', '3', 'AL1', 'Overall Status', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('107', '3', 'AM1', 'Final Remarks', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('108', '3', 'AN1', 'RCU Agency Name', 'Text', 'Optional', 'RMOCS', 'Readonly', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('109', '3', 'AO1', 'Sampler Name', 'Text', 'Optional', '', 'Edit', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('110', '3', 'AP1', 'RCU Manager Name', 'Text', 'Optional', '', 'Edit', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('111', '3', 'AQ1', 'Refer status Documents ', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('112', '3', 'AR1', 'RDD /RPD Document Name ', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('113', '3', 'AS1', 'RCU Agency Invoice No', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('114', '3', 'AT1', 'Verifier Name', 'Text', 'Optional', 'RMOCS', 'Readonly', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('159', '6', 'A1', 'Sr.No', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('160', '6', 'B1', 'Month', 'Calculated', 'Optional', 'current_month()', 'Edit', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('161', '6', 'C1', 'Branch Name', 'Text', 'Optional', '', 'Edit', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('162', '6', 'D1', 'Salaried/Self Employed', 'List', 'Optional', 'Salaried,Self Employed', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('163', '6', 'E1', 'Product', 'List', 'Optional', 'HL,LAP,HFC,BBG,BL', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('164', '6', 'F1', 'Application ID', 'Text', 'Optional', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('165', '6', 'G1', 'Name of Customer/Applicant/Coapplicant/ Company ', 'Text', 'Optional', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('166', '6', 'H1', 'Co-Applicant', 'Text', 'Optional', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('167', '6', 'I1', 'Sampled', 'Text', 'Optional', 'MANDATORY', 'Readonly', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('168', '6', 'J1', 'Status', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('169', '6', 'K1', 'Remarks', 'Text', 'Optional', '', 'Hidden', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('170', '6', 'L1', 'Date of Pick-up', 'Calculated', 'Optional', 'current_date()', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('171', '6', 'M1', 'Date of Reverted', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('172', '6', 'N1', 'TAT Days', 'Calculated', 'Optional', 'tat({l1},{m1})', 'Edit', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('173', '6', 'O1', 'Verifier Agency Name', 'Text', 'Optional', 'RM OUTSOURCING', 'Readonly', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('174', '6', 'P1', 'Doument 1 ', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('175', '6', 'Q1', 'Document 2', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('176', '6', 'R1', 'Document 3', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('177', '6', 'S1', 'Document 4', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('178', '6', 'T1', 'Total Documents', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('179', '6', 'U1', 'FE Name', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('180', '6', 'V1', 'WIP Document', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('181', '7', 'A1', 'Sr.No', 'Text', 'Optional', '', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('182', '7', 'B1', 'Month', 'Calculated', 'Optional', 'current_date()', 'Readonly', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('183', '7', 'C1', 'Branch Name', 'Text', 'Optional', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('184', '7', 'D1', 'Salaried/Self Employed', 'List', 'Optional', 'Salaried,Self Employed', 'Edit', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('185', '7', 'E1', 'Product', 'Text', 'Optional', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('186', '7', 'F1', 'LOS ID', 'Text', 'Mandatory', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('187', '7', 'G1', 'Name of Applicant and Co-applicant', 'Text', 'Mandatory', '', 'Edit', 'Edit');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('188', '7', 'H1', 'Sampling Type', 'Text', 'Optional', 'Mandatory', 'Edit', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('189', '7', 'I1', 'Status', 'Text', 'Optional', 'NA', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('190', '7', 'J1', 'Overall Status', 'Calculated', 'Optional', 'overall_status({case_id})', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('191', '7', 'K1', 'Verification Remarks', 'Calculated', 'Mandatory', 'overall_remarks({case_id}, {show_task_name}, {show_task_status})', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('192', '7', 'L1', 'Date of pick Up', 'Calculated', 'Optional', 'current_date()', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('193', '7', 'M1', 'Date of Reverted', 'Calculated', 'Optional', 'current_date()', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('194', '7', 'N1', 'TAT Days', 'Calculated', 'Optional', 'tat({Start Date}, {End Date})', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('195', '7', 'O1', 'Verifier Agency Name', 'Text', 'Optional', 'R M Outsourcing', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('196', '7', 'P1', 'Doument Name ', 'Calculated', 'Optional', 'type_of_document({case_id})', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('197', '7', 'Q1', 'Total Documents', 'Calculated', 'Optional', 'task_count({case_id})', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('198', '7', 'R1', 'FE Name', 'Calculated', 'Optional', 'fe_name({case_id})', 'Hidden', 'Hidden');
INSERT INTO `structure_columns` (`id`, `structure_id`, `cell_address`, `excel_column_name`, `data_type`, `nature`, `default_value`, `show_in_form`, `show_in_table`) VALUES ('199', '7', 'S1', 'WIP Document', 'Text', 'Optional', '', 'Hidden', 'Hidden');

-- --------------------------------------------------------
-- Structure for table `system_settings`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `system_settings`;
CREATE TABLE `system_settings` (
  `setting_key` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `setting_value` mediumtext COLLATE utf8mb4_general_ci,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `system_settings`
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('app_name', 'KPRM Rapid ™️', '2026-09-03 01:54:53');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('company_name', 'KPRM Solutions', '2026-09-02 22:34:17');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('contact_email', '', '2026-09-02 22:34:17');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('contact_phone', '', '2026-09-02 22:34:17');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('currency_symbol', '₹', '2026-09-02 22:34:17');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('developer_credit', 'Planted By OfferPlant', '2026-09-03 01:20:45');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('developer_url', 'https://offerplant.com', '2026-09-03 01:20:45');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('ext_api_auto_dispatch', '1', '2026-09-30 13:39:34');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('ext_api_banking_url', 'https://rmoutsourcingandconsulting.com/system/api.php?task=update_banking', '2026-09-30 13:39:34');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('ext_api_callback_url', '', '2026-09-30 13:39:34');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('ext_api_enabled', '1', '2026-09-30 13:39:34');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('ext_api_itr_url', 'https://rmoutsourcingandconsulting.com/system/api.php?task=update_itr', '2026-09-30 13:39:34');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('ext_api_recent_webhooks', '[{\"time\":\"2026-09-30 14:14:21\",\"ip\":\"127.0.0.1\",\"task_id\":30,\"status\":\"Positive\",\"remarks\":\"Test log entry - simulated callback\",\"attachment\":\"\",\"http_code\":200,\"response\":\"Task #30 updated to Verified successfully.\"}]', '2026-09-30 14:14:21');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('footer_text', '© 2026 KPRM2. All rights reserved.', '2026-09-02 22:34:17');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('last_backup_file', 'kprm2_db_backup_2026-09-02_16-45-27.sql', '2026-09-02 22:15:27');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('last_backup_run', '2026-09-02 16:45:27', '2026-09-02 22:15:27');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('last_cron_run', '2026-10-07 22:39:20', '2026-10-07 22:39:20');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('office_address', '', '2026-09-02 22:34:17');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('system_timezone', 'Asia/Kolkata', '2026-09-02 22:34:17');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('tagline', 'Verification & Case Reporting Platform', '2026-09-02 22:34:17');
INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES ('test_key', 'test_val', '2026-09-02 22:17:31');

-- --------------------------------------------------------
-- Structure for table `task_meta`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `task_meta`;
CREATE TABLE `task_meta` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `variable_tag` varchar(100) DEFAULT NULL,
  `field_name` varchar(255) NOT NULL,
  `data_type` varchar(50) NOT NULL,
  `is_mandatory` tinyint(1) DEFAULT '0',
  `show_in_details` tinyint(1) DEFAULT '0',
  `list_options` text,
  `send_in_message` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `task_meta_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `task_meta`
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('1', '1', '', 'applicant_name', 'Text', '1', '1', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('2', '1', '', 'address', 'Text', '1', '1', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('3', '1', '', 'met_with', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('4', '1', '', 'time_period', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('5', '1', '', 'ownership', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('6', '1', NULL, 'family', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('7', '1', '', 'area', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('8', '1', '', 'locality', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('9', '1', '', 'tpc', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('10', '2', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('11', '2', NULL, 'business_name_office_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('12', '2', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('13', '2', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('14', '2', NULL, 'business_period', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('15', '2', NULL, 'type_of_firm', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('16', '2', NULL, 'owner_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('17', '2', NULL, 'nob', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('18', '2', NULL, 'area', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('19', '2', NULL, 'tpc', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('20', '3', '', 'applicant_name', 'Text', '0', '1', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('21', '3', '', 'document_no', 'Text', '1', '1', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('22', '3', '', 'financial_year', 'Text', '1', '1', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('23', '3', '', 'ack_no', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('24', '3', '', 'dorf', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('25', '3', '', 'total_income', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('26', '4', '', 'applicant_name', 'Text', '1', '1', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('27', '4', '', 'business_name_office_name', 'Text', '1', '1', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('28', '4', '', 'address', 'Text', '1', '1', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('29', '4', '', 'met_with', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('30', '4', '', 'time_period', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('31', '4', '', 'nob', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('32', '4', '', 'area', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('33', '4', '', 'locality', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('34', '4', '', 'tpc', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('35', '5', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('36', '5', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('37', '5', NULL, 'Financial_year', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('38', '5', NULL, 'employer_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('39', '5', NULL, 'total_income', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('40', '5', NULL, 'tax_amount', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('41', '6', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('42', '6', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('43', '6', NULL, 'father_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('44', '6', NULL, 'date_of_birth', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('45', '6', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('46', '7', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('47', '7', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('48', '7', NULL, 'member_id', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('49', '7', NULL, 'employer_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('50', '7', NULL, 'date_of_joining', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('51', '8', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('52', '8', NULL, 'trade_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('53', '8', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('54', '8', NULL, 'date_of_registration', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('55', '9', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('56', '9', NULL, 'trade_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('57', '9', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('58', '9', NULL, 'date_of_registration', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('59', '9', NULL, 'proprietor_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('60', '10', NULL, 'bank_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('61', '10', NULL, 'account_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('62', '10', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('63', '10', NULL, 'transction', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('64', '11', NULL, 'bank_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('65', '11', NULL, 'account_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('66', '11', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('67', '11', NULL, 'pan_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('68', '11', NULL, 'aod', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('69', '12', NULL, 'account_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('70', '12', NULL, 'bank_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('71', '12', NULL, 'closing_date', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('72', '12', NULL, 'outstanding', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('73', '13', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('74', '13', NULL, 'business_name_office_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('75', '13', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('76', '13', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('77', '13', NULL, 'business_period', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('78', '13', NULL, 'ownership', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('79', '13', NULL, 'owner_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('80', '13', NULL, 'area', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('81', '13', NULL, 'tpc', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('82', '14', NULL, 'applicant_name', 'Text', '0', '1', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('83', '14', NULL, 'business_name_office_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('84', '14', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('85', '14', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('86', '14', NULL, 'business_period', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('87', '14', NULL, 'ownership', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('88', '14', NULL, 'area', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('89', '14', NULL, 'locality', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('90', '14', NULL, 'tpc', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('91', '15', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('92', '15', NULL, 'business_name_office_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('93', '15', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('94', '15', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('95', '15', NULL, 'time_period', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('96', '15', NULL, 'designation', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('97', '15', NULL, 'nob', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('98', '15', NULL, 'area', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('99', '15', NULL, 'locality', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('100', '15', NULL, 'tpc', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('101', '16', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('102', '16', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('103', '16', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('104', '16', NULL, 'area', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('105', '16', NULL, 'market_rate', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('106', '16', NULL, 'locality', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('107', '16', NULL, 'tpc', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('108', '17', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('109', '17', NULL, 'dealer_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('110', '17', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('111', '17', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('112', '17', NULL, 'time_period', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('113', '17', NULL, 'ownership', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('114', '17', NULL, 'type_of_firm', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('115', '17', NULL, 'owner_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('116', '17', NULL, 'nob', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('117', '17', NULL, 'full_amount', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('118', '17', NULL, 'down_payment', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('119', '17', NULL, 'area', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('120', '17', NULL, 'locality', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('121', '17', NULL, 'tpc', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('122', '18', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('123', '18', NULL, 'business_name_office_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('124', '18', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('125', '18', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('126', '18', NULL, 'time_period', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('127', '18', NULL, 'owner_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('128', '18', NULL, 'nob', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('129', '18', NULL, 'area', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('130', '18', NULL, 'school_classes', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('131', '18', NULL, 'students', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('132', '18', NULL, 'teacher', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('133', '18', NULL, 'all_staff', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('134', '18', NULL, 'school_fee', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('135', '18', NULL, 'locality', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('136', '18', NULL, 'tpc', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('137', '19', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('138', '19', NULL, 'seller_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('139', '19', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('140', '19', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('141', '19', NULL, 'time_period', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('142', '19', NULL, 'ownership', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('143', '19', NULL, 'sale_amount', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('144', '19', NULL, 'advance_amount', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('145', '19', NULL, 'area', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('146', '19', NULL, 'locality', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('147', '19', NULL, 'tpc', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('148', '20', NULL, 'tenant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('149', '20', NULL, 'owner_name_landlord_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('150', '20', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('151', '20', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('152', '20', NULL, 'time_period', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('153', '20', NULL, 'rent', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('154', '21', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('155', '21', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('156', '21', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('157', '22', NULL, 'business_name_office_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('158', '22', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('159', '22', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('160', '23', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('161', '23', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('162', '23', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('163', '23', NULL, 'patwari_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('164', '24', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('165', '24', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('166', '24', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('167', '24', NULL, 'patwari_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('168', '25', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('169', '25', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('170', '25', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('171', '25', NULL, 'bank_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('172', '26', NULL, 'tenant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('173', '26', NULL, 'owner_name_landlord_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('174', '26', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('175', '26', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('176', '26', NULL, 'time_period', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('177', '26', NULL, 'rent', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('178', '27', NULL, 'owner_name_landlord_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('179', '27', NULL, 'tenant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('180', '27', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('181', '27', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('182', '27', NULL, 'time_period', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('183', '27', NULL, 'rent', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('184', '28', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('185', '28', NULL, 'business_name_office_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('186', '28', NULL, 'address', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('187', '28', NULL, 'met_with', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('188', '28', NULL, 'time_period', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('189', '28', NULL, 'ownership', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('190', '28', NULL, 'business_period', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('191', '28', NULL, 'type_of_firm', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('192', '28', NULL, 'owner_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('193', '28', NULL, 'nob', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('194', '28', NULL, 'area', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('195', '28', NULL, 'locality', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('196', '28', NULL, 'tpc', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('197', '31', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('198', '31', NULL, 'ay', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('199', '31', NULL, 'requirement', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('200', '31', NULL, 'trade_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('201', '31', NULL, 'total_turnover', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('202', '31', NULL, 'igst', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('203', '31', NULL, 'cgst', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('204', '31', NULL, 'sgst', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('205', '32', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('206', '33', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('207', '34', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('208', '35', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('209', '36', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('210', '37', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('211', '38', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('212', '39', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('213', '40', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('214', '41', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('215', '42', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('216', '43', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('217', '44', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('218', '45', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('219', '45', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('220', '45', NULL, 'date_of_birth', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('221', '45', NULL, 'status', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('222', '46', NULL, 'company_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('223', '46', NULL, 'financial_year', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('224', '46', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('225', '46', '', 'status', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('226', '47', NULL, 'applicant_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('227', '47', NULL, 'bank_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('228', '47', NULL, 'account_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('229', '47', NULL, 'transction', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('230', '47', NULL, 'pan_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('231', '47', NULL, 'mobile_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('232', '47', NULL, 'status', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('233', '48', '', 'applicant_name', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('234', '48', '', 'document_no', 'Text', '0', '1', '', '0');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('235', '48', '', 'assesment_no', 'Text', '0', '1', '', '0');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('236', '48', NULL, 'employer_name', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('237', '48', '', 'total_income', 'Number', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('238', '48', NULL, 'tax_amount', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('239', '49', '', 'applicant_name', 'Text', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('240', '49', NULL, 'document_no', 'Text', '0', '0', NULL, '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('241', '49', '', 'dob', 'Date', '0', '0', '', '0');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('242', '1', '', 'Geo Tag', 'Geo', '0', '1', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('243', '1', '', 'Attachement', 'Document', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('244', '4', '', 'Geo Tag', 'Geo', '0', '0', '', '1');
INSERT INTO `task_meta` (`id`, `task_id`, `variable_tag`, `field_name`, `data_type`, `is_mandatory`, `show_in_details`, `list_options`, `send_in_message`) VALUES ('245', '46', '#financial_comparison#', 'Financial Statements Comparison', 'Financial_Table', '0', '1', '', '0');

-- --------------------------------------------------------
-- Structure for table `task_meta_rbac`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `task_meta_rbac`;
CREATE TABLE `task_meta_rbac` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_meta_id` int NOT NULL,
  `role_id` int NOT NULL,
  `access_level` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `task_meta_id` (`task_meta_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `task_meta_rbac_ibfk_1` FOREIGN KEY (`task_meta_id`) REFERENCES `task_meta` (`id`) ON DELETE CASCADE,
  CONSTRAINT `task_meta_rbac_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `task_meta_rbac`
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('1', '241', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('2', '241', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('3', '241', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('4', '241', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('5', '241', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('6', '239', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('7', '239', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('8', '239', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('9', '239', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('10', '239', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('11', '237', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('12', '237', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('13', '237', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('14', '237', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('15', '237', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('16', '20', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('17', '20', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('18', '20', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('19', '20', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('20', '20', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('21', '21', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('22', '21', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('23', '21', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('24', '21', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('25', '21', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('26', '22', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('27', '22', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('28', '22', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('29', '22', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('30', '22', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('31', '23', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('32', '23', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('33', '23', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('34', '23', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('35', '23', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('36', '24', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('37', '24', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('38', '24', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('39', '24', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('40', '24', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('41', '25', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('42', '25', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('43', '25', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('44', '25', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('45', '25', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('46', '3', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('47', '3', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('48', '3', '3', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('49', '3', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('50', '3', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('51', '4', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('52', '4', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('53', '4', '3', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('54', '4', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('55', '4', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('56', '5', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('57', '5', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('58', '5', '3', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('59', '5', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('60', '5', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('61', '7', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('62', '7', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('63', '7', '3', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('64', '7', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('65', '7', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('66', '9', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('67', '9', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('68', '9', '3', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('69', '9', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('70', '9', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('71', '8', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('72', '8', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('73', '8', '3', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('74', '8', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('75', '8', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('76', '1', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('77', '1', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('78', '1', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('79', '1', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('80', '1', '5', 'Read-Only');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('81', '2', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('82', '2', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('83', '2', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('84', '2', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('85', '2', '5', 'Read-Only');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('86', '242', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('87', '242', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('88', '242', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('89', '242', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('90', '242', '5', 'Read-Only');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('91', '243', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('92', '243', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('93', '243', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('94', '243', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('95', '243', '5', 'Read-Only');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('96', '233', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('97', '233', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('98', '233', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('99', '233', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('100', '233', '5', 'Read-Only');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('101', '234', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('102', '234', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('103', '234', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('104', '234', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('105', '234', '5', 'Read-Only');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('106', '235', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('107', '235', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('108', '235', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('109', '235', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('110', '235', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('111', '26', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('112', '26', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('113', '26', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('114', '26', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('115', '26', '5', 'Read-Only');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('116', '27', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('117', '27', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('118', '27', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('119', '27', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('120', '27', '5', 'Read-Only');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('121', '28', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('122', '28', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('123', '28', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('124', '28', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('125', '28', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('126', '244', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('127', '244', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('128', '244', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('129', '244', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('130', '244', '5', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('131', '29', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('132', '29', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('133', '29', '3', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('134', '29', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('135', '29', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('136', '30', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('137', '30', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('138', '30', '3', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('139', '30', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('140', '30', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('141', '31', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('142', '31', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('143', '31', '3', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('144', '31', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('145', '31', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('146', '32', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('147', '32', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('148', '32', '3', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('149', '32', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('150', '32', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('151', '33', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('152', '33', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('153', '33', '3', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('154', '33', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('155', '33', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('156', '34', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('157', '34', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('158', '34', '3', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('159', '34', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('160', '34', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('161', '245', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('162', '245', '3', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('163', '245', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('164', '245', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('165', '245', '5', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('166', '225', '1', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('167', '225', '2', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('168', '225', '3', 'Hidden');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('169', '225', '4', 'Write');
INSERT INTO `task_meta_rbac` (`id`, `task_meta_id`, `role_id`, `access_level`) VALUES ('170', '225', '5', 'Write');

-- --------------------------------------------------------
-- Structure for table `task_remarks`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `task_remarks`;
CREATE TABLE `task_remarks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `remark_type` enum('Positive','Negative','CNV') NOT NULL,
  `remark_text` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `task_remarks_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `task_remarks`
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('1', '1', 'Positive', 'Residence - Applicant Name – #applicant_name#- Visit done by field executive at the given address – #address#. Address is exit at the given locality. Met with  #met_with# at the given address and he/she has confirm that, he/she is staying at the address for the last #time_period# at #ownership# premises. Total family members are #family#. The area of premises is #area#. The given address is in #locality# and address is traceable. TPC confirmation was taken from  #tpc# and they have confirmed the applicant’s stability at the address. ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('2', '1', 'Negative', 'Residence - Applicant Name – #applicant_name#- Visit done by field executive at the given address – #address#. ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('3', '1', 'CNV', 'Residence - Applicant Name – #applicant_name#- Visit done by field executive at the given address – #address#. ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('4', '2', 'Positive', 'Business Verification - Applicant Name – #applicant_name# - Business Name - #business_name_office_name# -  Visit done by field executive at the given address – #address# - Met with #met_with# and he/she has confirmed the business has been running at this address for the last #business_period# at rented premises. It is a #type_of_firm# and the business belongs to #owner_name#. Nature of business is a #nob#.  Area of the premises is approx. #area#. Business activity was seen and stock was also medium at the time of visit. Name board of the company is available outside of the office premises. The given address is in the #area# and the address is traceable. TPC confirmation was taken by #tpc# and they confirmed the business of the applicant. Status – Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('5', '2', 'Negative', 'Business Verification - Applicant Name – #applicant_name# - Business Name - #business_name_office_name# -  Visit done by field executive at the given address – #address# ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('6', '2', 'CNV', 'Business Verification - Applicant Name – #applicant_name# - Business Name - #business_name_office_name# -  Visit done by field executive at the given address – #address# ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('7', '3', 'Positive', 'ITR - We have verified an ITR of #applicant_name#, Pan no. #document_no#, for AY-#financial_year# and found that an ITR return has been filed with ACK No. #ack_no#, dated on #dorf#. Total income amount is Rs. #total_income#/- Status - Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('8', '3', 'Negative', 'ITR -  We have verified the given ITR of #applicant_name# Pan no. #document_no# for #financial_year# and found that the details mentioned on the provided copy of ITR is not matching with the authority record. As per provided Copy- ACK No. #ack_no#, dated on #dorf#. Total income amount is Rs. #total_income# /-. As per authority record:  ACK No. \"------------\", dated on \"---------------\". Total income amount is Rs. \"------------------\"');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('9', '3', 'CNV', 'ITR - The given ITR of #applicant_name#, Pan no. #document_no# for #financial_year#. Could not verified due to ......................');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('10', '4', 'Positive', 'Salary Slip / Salary Certificate - Applicant Name - #applicant_name#- Office Name – #business_name_office_name#, Visit done by field executive at the given address - #address# Met with #met_with# and he/she was confirmed applicant working for last #time_period#  as a Marketing Executive and he has also confirm the given salary slip is correct and issued from here. Nature of business of this office is #nob#. Office activity and setup was seen at the time of visit. The sign board of the company is available outside of the office premises. The area of premises is #area#. The given address is in #locality#and address is traceable. TPC conformation has been taken from #tpc# and they have confirmed employment of the applicant. Status – Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('11', '4', 'Negative', 'Salary Slip / Salary Certificate - Applicant Name - #applicant_name#- Office Name – #business_name_office_name#, Visit done by field executive at the given address - #address# ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('12', '4', 'CNV', 'Salary Slip / Salary Certificate - Applicant Name - #applicant_name#- Office Name – #business_name_office_name#, Visit done by field executive at the given address - #address# ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('13', '5', 'Positive', '26AS : Positive –(#applicant_name#) - We have checked the 26AS record of #applicant_name#  with PAN no. #document_no# for the Assessment Year #Financial_year#  at concerned department and found that employer name / Tax Deductor name - #employer_name#. Total income –  #total_income#/- and  Tax amount is  #tax_amount#/-');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('14', '5', 'Negative', '26AS : Negative–(#applicant_name#) - We have checked the 26AS record of #applicant_name#  with PAN no. #document_no# for the Assessment Year #Financial_year#  at concerned department and found that . he details mentioned on the provided copy of 26AS is not matching with the authority record. As per provided Copy employer name / Tax Deductor name - #employer_name#. Total income –  #total_income#/- and  Tax amount is  #tax_amount#/-. As per authority record:  employer name \"..............\", Total income – \" ...........\", tax amount is #tax_amount#. Which is not match with provided copy.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('15', '5', 'CNV', '26AS: Refert To Credit – (#applicant_name#) - The given 26AS details of #applicant_name# with PAN no. #document_no# for #Financial_year# could not got checked from concerned department due to ...........');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('16', '6', 'Positive', 'AADHAR - The given Aadhar #document_no# got checked from concern department and found that Name -#applicant_name# W/O & S/O #father_name#, DOB -#date_of_birth#, Address- #address#. Above mentioned details are matching with the provided copy of the Aadhar card and Photo is also matching. Status - Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('17', '6', 'Negative', 'AADHAR - The given Aadhar #document_no# got checked from concern department and found that found that the details mentioned on the provided copy of AADHAR is not matching with the authority record. As per provided Copy:- Name -#applicant_name# W/O & S/O #father_name#, DOB -#date_of_birth#, Address- #address#As per authority record: - Name - \"...........\", W/O & S/O  \" ...........\" DOB - \" ...............\", Address- \" ............\", Which is not match with provided copy,Hence, we mark Status - Negative.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('18', '6', 'CNV', 'AADHAR - The given Aadhar #document_no# could not got checked from concern department due to. ..... ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('19', '7', 'Positive', 'UAN - The given UAN of  #applicant_name#- with UAN no #document_no# -  got checked from authority and found below details are updated in authority record - Employee name is #applicant_name#, MEMBER ID - #member_id#, Company name - ( #employer_name# ), Date of joining is #date_of_joining#, and Employee is still working in this company. ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('20', '7', 'Negative', 'UAN - The given UAN of  #applicant_name#- with UAN no #document_no# -  got checked from authority and and found that the details mentioned on the provided copy of salary slip is not matching with the authority record. \r\n\r\nAs per provided Copy- Employee name is #applicant_name#, MEMBER ID - #member_id#, Company name - ( #employer_name# ), Date of joining is #date_of_joining#, and Employee is still working in this company. \r\n\r\nAs per authority record: - Employee name is \"...........\", MEMBER ID - \".................\", Company name - :.................\", Date of joining is \"............\" and Employee is still working / not working in this company. Which is not match with provided copy,');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('21', '7', 'CNV', 'UAN - The given UAN of  #applicant_name#- with UAN no #document_no# - could not got checked from authority due to');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('22', '8', 'Positive', 'UDYAM Certificate - The given UDYAM registration no.  #document_no# – got checked from concern department and found that Name of Enterprise - #trade_name#, Address - #address#, Udyam registration date - #date_of_registration#, Above mentioned details are matching with the provided copy of the Udyam Registration Certificate.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('23', '8', 'Negative', 'UDYAM Certificate  - The given UDYAM registration no.  #document_no# – got checked from concern department and found that and found that the details mentioned on the provided copy of UDYAM is not matching with the authority record. \r\n\r\nAs per provided Copy: - Name of Enterprise - #trade_name#, Address - #address#, Udyam registration date - #date_of_registration#,\r\n\r\nAs per authority record: - Name of Enterprise - \"............\", Address - \"...............\", Udyam registration date -  \" ........... \" Which is not match with provided copy,\r\n\r\nHence, we mark status - Negative.\r\n\r\n\r\n\r\n');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('24', '8', 'CNV', 'UDYAM Certificate - The given UDYAM registration no.  #document_no# – could not got checked from concern department due to .............');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('25', '9', 'Positive', 'GST Certificate - The given GST Registration certificate with GST registration number- #document_no#, Got checked from concern department and found that of trade name - #trade_name#, address -#address#, date of registration - #date_of_registration# proprietor/ partner and Director name - #proprietor_name#. and above-mentioned details are matching with the provided copy, Status - Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('26', '9', 'Negative', 'GST Certificate - The given GST Registration certificate with GST registration number- #document_no#, Got checked from concern department and found that the details mentioned on the provided copy of GST is not matching with the authority record. As per provided Copy: - Trade name - #trade_name#, address -#address#, date of registration - #date_of_registration# proprietor/ partner and Director name - #proprietor_name#., As per authority record: - Trade name - \" .........\", address - \" ........... \", date of registration - \" ......... \", proprietor/ partner and Director name - \" .............\", Which is not match with provided copy,Hence, we mark status - Negative.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('27', '9', 'CNV', 'GST Certificate - The given GST registration certificate with GST registration number- #document_no# could not checked due to');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('28', '10', 'Positive', 'BANKING - The given bank statement of #bank_name# - A/C No.  #account_no# - has been verified from the concerned bank and found that an account holder name is #applicant_name#, and the given transactions got verified dated on #transction#, which are matching with the bank record and provided copy. Status - Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('29', '10', 'Negative', 'BANKING - The given bank statement of #bank_name# - A/C No.  #account_no# - has been verified from the concerned bank and found that the details mentioned on the provided copy of Bank statement is not matching with the Bank record. As per provided Copy: - #applicant_name#, and Transaction - #transction#,As per Bank record: -   #applicant_name#, and Transaction - #transction#, Which is not match with provided copy,Hence, we mark status - Negative.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('30', '10', 'CNV', 'BANKING - The given bank statement of #bank_name# - A/C No.  #account_no# - has not been verified from the concerned bank due to .......');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('31', '11', 'Positive', 'BANKING - The given bank statement of #bank_name# - with A/C No. #account_no#- has been verified from the concerned bank and found that an account holder name is #applicant_name# and Pan - #pan_no#, AOD - #aod#, which are matching with provided copy details. Status: - Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('32', '11', 'Negative', 'BANKING - The given bank statement of #bank_name# - with A/C No. #account_no#- has been verified from the concerned bank and found that an account holder name is #applicant_name# and Pan - #pan_no#, AOD - #aod#, as per the bank record but below details are provided by applicant:PAN-Address-Mobile-AOD-which are not matching with authority record. ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('33', '11', 'CNV', 'BANKING - The given bank statement of #bank_name# - with A/C No. #account_no#- has not been verified from the concerned bank due to .................');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('34', '12', 'Positive', 'Loan Closure - The given loan A/c No.  #account_no# has been verified from the concerned department of #bank_name# and we have found that loan account holder Name is DEV INTERIOR AND DECORATORS and the given Loan A/c has been closed on #closing_date# and outstanding amount is #outstanding#-. ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('35', '12', 'Negative', 'Loan Closure - The given loan A/c No.  #account_no# has been verified from the concerned department of #bank_name# and we have found that loan account holder Name is DEV INTERIOR AND DECORATORS and the given Loan A/c is still active and outstanding amount is .............., ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('36', '12', 'CNV', 'Loan Closure - The given loan A/c No.  #account_no# has not been verified from the concerned department of #bank_name#  due to ................... ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('37', '13', 'Positive', 'Rental Income Verification - Applicant Name - #applicant_name# - Office Name – #business_name_office_name#, Visit done by field executive at the given address - #address# - Met with #met_with# and he/she has confirmed the business at this address for the last #business_period# at #ownership# premises. Ownership of the business belongs to the #owner_name#. NOB is a Rental Income. Area of the premises is approx. #area#. Total Floors \" ...... \" and there are \" ...... \" rooms in each floor and per room rent is \"...... \". Total rental income of the applicant approx. \"...... \" per month. Name board of the company is not available outside of the office premises. The given address is in the LMC area and the address is traceable. TPC confirmation was taken by #tpc# and  they confirmed the applicant’s stability and they also confirm that applicant’s rental business. Status – Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('38', '13', 'Negative', 'Rental Income Verification - Applicant Name - #applicant_name# - Office Name – #business_name_office_name#, Visit done by field executive at the given address - #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('39', '13', 'CNV', 'Rental Income Verification - Applicant Name - #applicant_name# - Office Name – #business_name_office_name#, Visit done by field executive at the given address - #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('40', '14', 'Positive', 'Dairy Business Verification - Applicant Name – #applicant_name# - Business Name - #business_name_office_name# - Visit done by field executive at the given address – #address# - Met with #met_with# and he/she has confirmed the business running at this address for the last #business_period# at #ownership# premises. It is a family business and it is also resi cum business. NOB is a dairy farm. Area of the premises is approx. #area#. Business activity seen and stock was also seen at the time of visit. Applicant has \"..... \" Buffalo and \"..... \"Cow, which is seen at the time of visit. The sign board of the company is not available outside of the office premises. The given address is in #locality# and the address is traceable. TPC confirmation was taken by #tpc# and they confirmed the family business. Status – Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('41', '14', 'Negative', 'Dairy Business Verification - Applicant Name – #applicant_name# - Business Name  - #business_name_office_name# - Visit done by field executive at the given address – #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('42', '14', 'CNV', 'Dairy Business Verification - Applicant Name – #applicant_name# - Business Name  - #business_name_office_name# - Visit done by field executive at the given address – #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('43', '15', 'Positive', 'Office Verification - Applicant Name – #applicant_name# - Office Name - #business_name_office_name# - Visit done by field executive at the given address – #address# - Met with #met_with# and he/she was confirmed applicant working for last #time_period# as a #designation#. Nature of business of this office is #nob#. Office activity and setup was seen at the time of visit. The sign board of the company is available outside of the office premises. The area of premises is #area#. The given address is in #locality# and address is traceable. TPC conformation has been taken from #tpc# and they have confirmed employment of the applicant. Status – Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('44', '15', 'Negative', 'Office Verification - Applicant Name – #applicant_name# - Office Name - #business_name_office_name# - Visit done by field executive at the given address – #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('45', '15', 'CNV', 'Office Verification - Applicant Name – #applicant_name# - Office Name - #business_name_office_name# - Visit done by field executive at the given address – #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('46', '16', 'Positive', 'Property Verification - Applicant Name - #applicant_name# – Address - #address# - Met with #met_with#, and he/she has confirmed the applicant’s property. The area of the property is approximately #area#. The current market rate of properties in this area is approx. to be between #market_rate# per square yard. The address is situated in a local #locality# and address is traceable. TPC confirmation was taken from the #tpc# and they confirm the applicant’s property. The Neighbours were not aware of any disputes related to the property. Status: Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('47', '16', 'Negative', 'Property Verification - Applicant Name - #applicant_name# – Address - #address# - ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('48', '16', 'CNV', 'Property Verification - Applicant Name - #applicant_name# – Address - #address# - ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('49', '17', 'Positive', 'Dealer and invoice verification - Applicant Name - #applicant_name#  - Dealer Name - #dealer_name# - ADDRESS - #address# - Met with #met_with# and he has confirmed the business at this address for Last #time_period# at #ownership# premises and also confirmed that, the given Invoice is correct and issued by there. It is a #type_of_firm#, and the business belongs to #owner_name#. They are proprietor/partners/Director in this business.  NOB is #nob#. The advance or booking amount of the machine is 50% and the per machine amount is #full_amount#, as per dealer the applicant has to give a down payment of #down_payment#. Area of the premises is approx. #area#.  Business activity seen. Stock seen. Name board of the company is available outside of the office premises. The given address is in an #locality#, and the address is traceable. TPC confirmation has been taken from #tpc# and they confirmed the business. Status – Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('50', '17', 'Negative', 'Dealer and invoice verification - Applicant Name - #applicant_name#  - Dealer Name - #dealer_name# - ADDRESS - #address# - ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('51', '17', 'CNV', 'Dealer and invoice verification - Applicant Name - #applicant_name#  - Dealer Name - #dealer_name# - ADDRESS - #address# - ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('52', '18', 'Positive', 'School Verification - Applicant Name - #applicant_name# - School Name: - #business_name_office_name# – Visit done by field executive at the given address - #address# - Met with #met_with# and he have confirmed the school at this address from the last #time_period# at the premises. Ownership of the business belongs to the #owner_name#. The NOB is a #nob#. Area of the premises is approx. #area#. Total class #school_classes#, Total students approx. #students#. Total teacher #teacher# and overall, #all_staff#. School buses \" ... \". The board of education is CBSE. Per student minimum fee #school_fee# per month. Name board of the school is available outside of the school premises. The given address is in the #locality#, and the address is traceable. TPC confirmation was taken by #tpc# and they confirmed the school, but they did not confirm the owner of this school. The Neighbours were not aware of any disputes related to the school. Status – Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('53', '18', 'Negative', 'School Verification - Applicant Name - #applicant_name# - School Name: - #business_name_office_name# – Visit done by field executive at the given address - #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('54', '18', 'CNV', 'School Verification - Applicant Name - #applicant_name# - School Name: - #business_name_office_name# – Visit done by field executive at the given address - #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('55', '19', 'Positive', 'Seller Verification - Applicant Name - #applicant_name# - Seller Name - #seller_name# - Visit done by field executive at the given address – #address# - Met with #met_with# and he has confirmed that he is staying at the address for the last #time_period# at #ownership# premises. Total Family member \" ... \" Earning \" ... \". He also confirms that, he sold the given property to #applicant_name#. The seller is selling the property to the applicant for Rs #sale_amount# and the seller has just received advance payment of #advance_amount#. Standard of living is not seen. Area of Premises is approx. #area#. The given address is in the #locality#, and the address is traceable. TPC confirmation was taken from the #tpc#, and they confirm the seller stability at the address. Status – Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('56', '19', 'Negative', 'Seller Verification - Applicant Name - #applicant_name# - Seller Name - #seller_name# - Visit done by field executive at the given address – #address# - Met with #met_with#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('57', '19', 'CNV', 'Seller Verification - Applicant Name - #applicant_name# - Seller Name - #seller_name# - Visit done by field executive at the given address – #address# - Met with #met_with#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('58', '20', 'Positive', 'Tenant NOC Verification - Tenant Name – #tenant_name# - Landlord Name - #owner_name_landlord_name# - Visit done by field executive at the given address – #address# - Met with the #met_with# and he/she has confirmed the given tenant NOC and signature. He also confirmed that, he has taken the premises on rent and stayed at this premises for the last #time_period#. He pays #rent# per month and confirms the tenant NOC and sign by tenant. Status – Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('59', '20', 'Negative', 'Tenant NOC Verification - Tenant Name – #tenant_name# - Landlord Name - #owner_name_landlord_name# - Visit done by field executive at the given address – #address# ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('60', '20', 'CNV', 'Tenant NOC Verification - Tenant Name – #tenant_name# - Landlord Name - #owner_name_landlord_name# - Visit done by field executive at the given address – #address# ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('61', '21', 'Positive', 'Legal Hair Noc Verification - Applicant Name - #applicant_name# - Visit done by field executive at the given address - #address# -   Met with Met with #met_with# and he has confirmed that the given Legal heir NOC is correct and signed by herself/himself. As per him/her, no objection for mortgage of this property. Status – Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('62', '21', 'Negative', 'Legal Hair Noc Verification - Applicant Name - #applicant_name# - Visit done by field executive at the given address - #address#  - ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('63', '21', 'CNV', 'Legal Hair Noc Verification - Applicant Name - #applicant_name# - Visit done by field executive at the given address - #address#  - ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('64', '22', 'Positive', 'PTM Letter Verification - OFFICE NAME  - #business_name_office_name# -  Visit done by field executive at the given address - #address#. Met with #met_with# and he has confirmed that the given PTM letter is correct, Status - Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('65', '22', 'Negative', 'PTM Letter Verification - OFFICE NAME  - #business_name_office_name# -  Visit done by field executive at the given address - #address#.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('66', '22', 'CNV', 'PTM Letter Verification - OFFICE NAME  - #business_name_office_name# -  Visit done by field executive at the given address - #address#.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('67', '23', 'Positive', 'Patwari Letter Verification - Applicant Name – #applicant_name# - Visit done by field executive at the given address - #address# -   During the visit met with #met_with# and he/she has confirmed the given Patwari letter is correct and signed by #patwari_name# Confirmed. Status – Positive.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('68', '23', 'Negative', 'Patwari Letter Verification - Applicant Name – #applicant_name# - Visit done by field executive at the given address - #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('69', '23', 'CNV', 'Patwari Letter Verification - Applicant Name – #applicant_name# - Visit done by field executive at the given address - #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('70', '24', 'Positive', 'Lien Marking Letter Verification - Applicant Name – #applicant_name# - Visit done by field executive at the given address - #address# - During the visit met with #met_with# and he/she has confirmed the given lien marking letter is correct and signed by #patwari_name# Confirmed. Status – Positive (with records photo)');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('71', '24', 'Negative', 'Lien Marking Letter Verification - Applicant Name – #applicant_name# - Visit done by field executive at the given address - #address# ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('72', '24', 'CNV', 'Lien Marking Letter Verification - Applicant Name – #applicant_name# - Visit done by field executive at the given address - #address# ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('73', '25', 'Positive', 'LOD and FC letter Verification - Applicant Name – #applicant_name# - Visit done by field executive at the given address - #address# - During the visit met with #met_with# and he/she has confirmed the given both LOD & FC letters are correct. Status – Positive');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('74', '25', 'Negative', 'LOD and FC letter Verification - Applicant Name – #applicant_name# - Visit done by field executive at the given address - #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('75', '25', 'CNV', 'LOD and FC letter Verification - Applicant Name – #applicant_name# - Visit done by field executive at the given address - #address# - The give LOD Letter of #bank_name# could no be verified due to ..........');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('76', '26', 'Positive', 'Rent Agreement Verification – Tenant Name – #tenant_name# - Landlord Name - #owner_name_landlord_name# - Visit done by field executive at the given address – #address# - Met with #met_with# and he/she has confirmed the given rent agreement and signature. He also confirmed that, he has taken the premises on rent and stayed at this premises for the last #time_period#F. He pays #rent# per month and confirms the rent agreement and sign by tenant. Status – Positive');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('77', '26', 'Negative', 'Rent Agreement Verification – Tenant Name – #tenant_name# - Landlord Name - #owner_name_landlord_name# - Visit done by field executive at the given address – #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('78', '26', 'CNV', 'Rent Agreement Verification – Tenant Name – #tenant_name# - Landlord Name - #owner_name_landlord_name# - Visit done by field executive at the given address – #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('79', '27', 'Positive', 'Rent Agreement Verification – Landlord Name - #owner_name_landlord_name# - Tenant Name – #tenant_name# - Visit done by field executive at the given address – #address# - Met with the #met_with# and he confirmed the given rent agreement and signature. He also confirmed that, Tenant has taken the premises on rent and stayed at this premises for the last #time_period#. He pays #rent# per month and confirms the rent agreement and sign by landlord. Status – Positive');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('80', '27', 'Negative', 'Rent Agreement Verification – Landlord Name - #owner_name_landlord_name# - Tenant Name – #tenant_name# - Visit done by field executive at the given address – #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('81', '27', 'CNV', 'Rent Agreement Verification – Landlord Name - #owner_name_landlord_name# - Tenant Name – #tenant_name# - Visit done by field executive at the given address – #address#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('82', '28', 'Positive', 'Residence cum Business Verification – Applicant Name – #applicant_name# - Business Name - #business_name_office_name# - Visit done by field executive at the given address – #address#. Met with #met_with# at the given address and he/she has confirmed that, he/she is staying at the address for the #time_period# at #ownership# premises. Family members are \".......\" and earning person \" ......\". He also confirms his business has been running at the address for the last #business_period# at #ownership# premises. It is a Resi cum business address and it is a #type_of_firm#, and the business belongs to #owner_name#. Nature of business is a #nob#.  Area of the premises is approx. 100 sq. yard. Business activity was seen, and stock was also medium at the time of visit. Name board of the company is available outside of the office premises. The area of premises is #area#. The given address is in #locality# and address is traceable. TPC confirmation was taken from the Neighbours #tpc# and they have confirmed the applicant’s stability at the address, and they also confirm the applicant\'s business. Status - Positive');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('83', '28', 'Negative', 'Residence cum Business Verification – Applicant Name – #applicant_name# - Business Name - #business_name_office_name# - Visit done by field executive at the given address – #address#.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('84', '28', 'CNV', 'Residence cum Business Verification – Applicant Name – #applicant_name# - Business Name - #business_name_office_name# - Visit done by field executive at the given address – #address#.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('85', '31', 'Positive', 'The given GSTR 3B -of GST number- #document_no# for Financial Year- #ay# Month -#requirement# got checked from concern department and found that firm name - #trade_name#, total turnover - #total_turnover#, IGST- #igst#, CGST- #cgst#- and SGST - #sgst#/-. which are matching with the provided copy and department record. ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('86', '31', 'Negative', 'The given GSTR 3B -of GST number- #document_no# for Financial Year- #ay# Month -#requirement# got checked from concern department and found that firm name - #trade_name#, total turnover - #total_turnover#, IGST- #igst#, CGST- #cgst#- and SGST - #sgst#/-. which are not matching with the provided copy and department record. Below details are not matching:firm name - total turnover -IGST- CGST- SGST - ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('87', '31', 'CNV', 'The given GSTR 3B -of GST number- #document_no# for Financial Year- #ay# Month -#requirement# could not got checked from concern department due to ............');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('88', '32', 'Positive', 'Snap Attached');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('89', '32', 'Negative', 'Snap Attached');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('90', '32', 'CNV', 'The given GSTR1 with GST Number- #document_no# could not got checked from concerned authority due to ....');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('91', '33', 'Positive', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('92', '33', 'Negative', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('93', '33', 'CNV', 'The given Mobile to PAN with mobile number #document_no# could not got checked from concerned department due to..........');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('94', '34', 'Positive', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('95', '34', 'Negative', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('96', '34', 'CNV', 'The given Pan to Bank with PAN number #document_no# could not got checked from concerned department due to..........');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('97', '35', 'Positive', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('98', '35', 'Negative', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('99', '35', 'CNV', 'The given Aadhar to Pan with Aadhar number #document_no# could not got checked from concerned department due to..........');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('100', '36', 'Positive', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('101', '36', 'Negative', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('102', '36', 'CNV', 'The given Aadhar to PAN with Aadhar number #document_no# could not got checked from concerned department due to..........');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('103', '37', 'Positive', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('104', '37', 'Negative', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('105', '37', 'CNV', 'The given PAN to Aadhar with PAN number #document_no# could not got checked from concerned department due to..........');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('106', '38', 'Positive', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('107', '38', 'Negative', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('108', '38', 'CNV', 'We have attempted the get the Pan to TAN through the provided PAN no- #document_no# but same could not got checked due to ..........');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('109', '39', 'Positive', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('110', '39', 'Negative', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('111', '39', 'CNV', 'We have attempted the get the PAN search of #applicant_name# from provided details but same could not got checked due to ................ ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('112', '40', 'Positive', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('113', '40', 'Negative', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('114', '40', 'CNV', 'We have attempted the get the dual PAN status of #applicant_name# from provided details but same could not got checked due to ................ ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('115', '41', 'Positive', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('116', '41', 'Negative', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('117', '41', 'CNV', 'We have tried to get the partnership details from the given PAN number / GST no #document_no# but same could not got checked from department due to..........');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('118', '42', 'Positive', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('119', '42', 'Negative', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('120', '42', 'CNV', 'We are unable to get the Aadhar history of the given Aadhar no- #document_no#  due to..........');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('121', '43', 'Positive', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('122', '43', 'Negative', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('123', '43', 'CNV', 'The given Mobile to Bank from Mobile number #document_no# could not got checked from concerned department due to..........');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('124', '44', 'Positive', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('125', '44', 'Negative', 'Snap Attach.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('126', '44', 'CNV', 'The given AIS with PAN number #document_no# could not got checked from concerned department due to..........');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('127', '45', 'Positive', 'PAN WITH PHOTO - The Given PAN #document_no# got checked and found that PAN holder Name -#applicant_name# , and DOB - #date_of_birth# are correct as per the department record. Signature and Photo are also matching. Status : #status# ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('128', '45', 'Negative', 'PAN WITH PHOTO - The Given PAN #document_no# got checked from the concern department and found that the details mentioned on the provided copy of Pan is not matching with the authority record. As per provided Copy: - PAN holder Name -#applicant_name# , and DOB - #date_of_birth#. As per authority record: - PAN holder Name - \" ........\", and DOB \" ...... \". also, Signature and Photo not matching. with provided copy. Status - #status#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('129', '45', 'CNV', 'PAN WITH PHOTO -  The Given PAN #document_no# could not got checked from concerned authority due to ...... Status : #status#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('130', '46', 'Positive', ' Given financial statements of #company_name# for the Financial year #financial_year# with Pan No. #document_no#  has been verified from the concern department and found  below observations: Status- #status#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('131', '46', 'Negative', ' Given financial statements of #company_name# for the Financial year #financial_year# with Pan No. #document_no#  has been verified from the concern department and found  below observations: Status-#status#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('132', '46', 'CNV', ' Given financial statements of #company_name# for the Financial year #financial_year# with Pan No. #document_no#  has not been verified from the concern department and found  below observations: Status-#status#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('133', '47', 'Positive', 'BANKING- #applicant_name# - The given Bank Statement of #bank_name#- Account number  -#account_no# got check from the concerned bank and found that the Account Holder Name is #applicant_name#. Transactions are also verified dated on #transction# , Which are matching with the provided copy. PAN as provided- #pan_no#-  & as per bank record - .................Mobile no as provided -#mobile_no#-- & as per bank record--------------.Status:- #status#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('134', '47', 'Negative', 'BANKING- #applicant_name# - The given Bank Statement of #bank_name#- Account number  -#account_no# got check from the concerned bank and found that the Account Holder Name is #applicant_name#. Transactions are also checked dated on #transction# , Which are not matching with the provided copy.  As per provided copy details are: ................................PAN as provided- #pan_no#-  & as per bank record - .................Mobile no as provided -#mobile_no#-- & as per bank record--------------.Status:- #status#');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('135', '47', 'CNV', 'BANKING- #applicant_name# - The given Bank Statement of #bank_name#- Account number  -#account_no# could not check from the concerned bank due to resource not available. ');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('136', '48', 'Positive', 'We have checked the FORM 16details of #applicant_name# with PAN no. #document_no# for #assesment_no# at concerned department and found that employer name #employer_name# Total income – #total_income#  tax amount is #tax_amount#. Provided details are matching with the shared details.');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('137', '48', 'Negative', 'We have verified the given FORM 16 of #applicant_name# Pan no. #document_no# for #assesment_no# and found that the details mentioned on the provided copy of 26AS is not matching with the authority record. As per provided Copy- employer name #employer_name#, Total income – #total_income#  tax amount is #tax_amount#. As per authority record:  employer name \"..............\", Total income – \" ...........\", tax amount is #tax_amount#. Which is not match with provided copy');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('138', '48', 'CNV', 'FORM 16- The given FORM 16 details of #applicant_name# with PAN no. #document_no# for #assesment_no# could  not got checked from concerned department due to ...........');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('139', '49', 'Positive', 'PAN - Positive – #applicant_name# - The Given PAN  #document_no# got checked and found that PAN holder Name - #applicant_name#, and DOB - #dob#, and Address - XXXXXXXXXXXXXXXXXXXXXXXXXX are found as per the department record');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('140', '49', 'Negative', 'PAN - Positive – #applicant_name# - The Given PAN  #document_no# got checked and found that PAN holder Name - #applicant_name#, and DOB - #dob#, and Address - XXXXXXXXXXXXXXXXXXXXXXXXXX are found as per the department record');
INSERT INTO `task_remarks` (`id`, `task_id`, `remark_type`, `remark_text`) VALUES ('141', '49', 'CNV', 'PAN - Positive – #applicant_name# - The Given PAN  #document_no# got checked and found that PAN holder Name - #applicant_name#, and DOB - #dob#, and Address - XXXXXXXXXXXXXXXXXXXXXXXXXX are found as per the department record');

-- --------------------------------------------------------
-- Structure for table `task_type_communication`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `task_type_communication`;
CREATE TABLE `task_type_communication` (
  `task_type` enum('ITO','PHYSICAL','BANKING') COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('enabled','disabled') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'enabled',
  `smtp_account_id` int DEFAULT NULL,
  `whatsapp_account_id` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`task_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `task_type_communication`
INSERT INTO `task_type_communication` (`task_type`, `status`, `smtp_account_id`, `whatsapp_account_id`, `updated_at`) VALUES ('ITO', 'enabled', NULL, NULL, '2026-09-02 22:57:53');
INSERT INTO `task_type_communication` (`task_type`, `status`, `smtp_account_id`, `whatsapp_account_id`, `updated_at`) VALUES ('PHYSICAL', 'enabled', NULL, NULL, '2026-09-02 22:57:53');
INSERT INTO `task_type_communication` (`task_type`, `status`, `smtp_account_id`, `whatsapp_account_id`, `updated_at`) VALUES ('BANKING', 'enabled', NULL, NULL, '2026-09-02 22:57:53');

-- --------------------------------------------------------
-- Structure for table `tasks`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_type` enum('ITO','PHYSICAL','BANKING') NOT NULL,
  `task_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `smtp_account_id` int DEFAULT NULL,
  `whatsapp_account_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_name` (`task_name`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `tasks`
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('1', 'PHYSICAL', 'Residence', '2025-05-28 00:19:05', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('2', 'PHYSICAL', 'Business', '2025-05-28 00:19:46', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('3', 'ITO', 'ITR', '2025-05-28 00:20:19', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('4', 'PHYSICAL', 'Salary slip and Employment', '2025-05-31 00:04:10', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('5', 'ITO', '26AS ', '2025-05-31 00:21:30', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('6', 'ITO', 'Aadhar', '2025-05-31 19:30:27', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('7', 'ITO', 'UAN', '2025-05-31 19:31:11', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('8', 'ITO', 'UDYAM', '2025-05-31 19:31:34', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('9', 'ITO', 'GST Certificate', '2025-05-31 19:31:56', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('10', 'BANKING', 'Banking', '2025-05-31 19:32:36', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('11', 'BANKING', 'Banking (KYC)', '2025-05-31 19:33:01', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('12', 'BANKING', 'Loan Closure ', '2025-05-31 19:33:29', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('13', 'PHYSICAL', 'Rental Income', '2025-05-31 19:33:55', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('14', 'PHYSICAL', 'Dairy Business', '2025-05-31 19:37:38', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('15', 'PHYSICAL', 'Office', '2025-05-31 19:38:02', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('16', 'PHYSICAL', 'Property', '2025-05-31 19:40:19', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('17', 'PHYSICAL', 'Dealer and invoice', '2025-05-31 19:40:35', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('18', 'PHYSICAL', 'School ', '2025-05-31 19:41:14', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('19', 'PHYSICAL', 'Seller ', '2025-05-31 19:41:35', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('20', 'PHYSICAL', 'Tenant NOC ', '2025-05-31 19:41:51', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('21', 'PHYSICAL', 'LEGAL HIER NOC', '2025-05-31 19:42:20', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('22', 'PHYSICAL', 'PTM Letter', '2025-05-31 19:42:32', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('23', 'PHYSICAL', 'Patwari Letter', '2025-05-31 19:42:51', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('24', 'PHYSICAL', 'Lien Marking Letter ', '2025-05-31 19:43:16', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('25', 'PHYSICAL', 'LOD and FC letter', '2025-05-31 19:43:30', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('26', 'PHYSICAL', 'Rent Agreement from Tenant', '2025-06-07 18:54:46', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('27', 'PHYSICAL', 'Rent Agreement from Landlord', '2025-06-07 19:34:48', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('28', 'PHYSICAL', 'Resi cum Business', '2025-06-07 19:35:50', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('29', 'PHYSICAL', 'Other Verification', '2025-06-07 21:13:11', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('30', 'PHYSICAL', 'ASSEST VERIFICATION', '2025-06-07 21:18:39', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('31', 'ITO', 'GST3B', '2025-06-07 21:24:27', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('32', 'ITO', 'GSTR1', '2025-06-07 21:34:53', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('33', 'ITO', 'MOBILE TO PAN', '2025-06-07 21:38:31', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('34', 'ITO', 'PAN TO BANK', '2025-06-07 21:44:11', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('35', 'ITO', 'AADHAR TO PAN', '2025-06-07 21:44:57', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('36', 'ITO', 'AADHAR TO PAN WITH PHOTO', '2025-06-07 21:46:11', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('37', 'ITO', 'PAN TO AADHAR', '2025-06-07 21:46:53', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('38', 'ITO', 'PAN TO TAN', '2025-06-07 21:48:30', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('39', 'ITO', 'PAN SEARCH', '2025-06-07 21:49:32', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('40', 'ITO', 'DUAL PAN', '2025-06-07 21:50:44', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('41', 'ITO', 'PARTNER DETAILS', '2025-06-07 21:51:41', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('42', 'ITO', 'AADHAR HISTORY', '2025-06-07 21:52:01', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('43', 'ITO', 'MOBILE TO BANK', '2025-06-07 21:53:22', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('44', 'ITO', 'AIS', '2025-06-07 21:54:33', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('45', 'ITO', 'PAN WITH PHOTO', '2025-06-07 21:54:58', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('46', 'ITO', 'FINANCIAL', '2025-07-03 19:44:30', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('47', 'BANKING', 'Bank_incread', '2025-09-18 19:25:50', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('48', 'ITO', 'FORM 16', '2025-12-29 18:57:17', NULL, NULL);
INSERT INTO `tasks` (`id`, `task_type`, `task_name`, `created_at`, `smtp_account_id`, `whatsapp_account_id`) VALUES ('49', 'ITO', 'PAN', '2026-07-07 22:03:27', NULL, NULL);

-- --------------------------------------------------------
-- Structure for table `user_roles`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `user_roles`
INSERT INTO `user_roles` (`id`, `role_name`) VALUES ('1', 'Admin');
INSERT INTO `user_roles` (`id`, `role_name`) VALUES ('3', 'BEO');
INSERT INTO `user_roles` (`id`, `role_name`) VALUES ('7', 'DEV');
INSERT INTO `user_roles` (`id`, `role_name`) VALUES ('2', 'Manager');
INSERT INTO `user_roles` (`id`, `role_name`) VALUES ('4', 'Reviewer');
INSERT INTO `user_roles` (`id`, `role_name`) VALUES ('5', 'Verifier');

-- --------------------------------------------------------
-- Structure for table `users`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `email` varchar(150) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `allowed_task_types` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `users`
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('1', 'admin', '$2y$12$wHnZJPs2Tal2E2jgs9JMeur.CsDDR8MceNqwAs.pUrKje4hyp9FEC', '1', '2026-08-29 17:56:51', NULL, NULL);
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('2', 'offerplant', '$2y$12$xSyMOQj9lDp6R4b6mvfyVud/kbQ5kzkmAl0NxdG4ycAAvb4rzZg9S', '7', '2026-08-29 21:04:11', 'myofferplant@gmail.com', '');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('3', 'Reviewer', '$2y$12$PI9hQE6vjLaqJvHLrdvCGuo.bEgiHLDbe6NfENn8SPrbUHu4F9lMu', '4', '2026-08-29 22:37:03', NULL, NULL);
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('4', 'Verifier', '$2y$12$XeSrH1151kk/vhnUt.hEI.kDAP7KmMRkVtpYIcKxS7.1TqKi3xjzS', '5', '2026-08-29 22:37:19', '', '9431426600');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('5', 'beo', '$2y$12$87HtZNqnVJa65bO1yU50WeJERDtL6A5glKsErhU.7r878DIROW6/W', '3', '2026-08-31 15:21:32', '', '');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('6', 'Abhishek Verma', '$2y$10$okNXM7Y/LEpzjsURGVb2HuoqEXxdDxD7jjRIGQU47svhzb7d7z7N2', '5', '2026-09-21 18:59:16', '', '9015373082');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('7', 'Mamta Singh', '$2y$10$JVMM5fsOkLc99DwytAS6BOx52Nw9BoTMm2DLodeyqCeqVDmnkK1YG', '4', '2026-09-21 19:00:32', '', '');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('8', 'Sonam', '$2y$10$QPRLDXk1u0FWzHHEeyQjdump2oOiHyNg2u7Fe5qxkQAhhIhgHOl1G', '3', '2026-09-21 19:01:29', '', '');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('9', 'Mahto field alocation', '123', '5', '2026-10-07 10:29:54', '', '120363026302172262');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('10', 'Sameer vaishali Vasundhara indrapuram', '123', '5', '2026-10-07 10:29:54', '', '120363396076129816');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('11', 'UP Location (Meerut, Bhagpat, Mawana, Modinagar, D', '123', '5', '2026-10-07 10:29:54', '', '120363250193387772');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('12', 'Ghaziabad Allocation Group', '123', '5', '2026-10-07 10:29:54', '', '120363046812717592');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('13', 'Greater Noida case- Sachin Group', '123', '5', '2026-10-07 10:29:54', '', '120363165816670112');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('14', 'Prabhat ji gzb only report', '123', '5', '2026-10-07 10:29:54', '', '120363361813345061');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('15', 'Faridabad cases', '123', '5', '2026-10-07 10:29:54', '', '120363027729067946');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('16', 'Mahto field feedback grou', '123', '5', '2026-10-07 10:29:54', '', '120363045985494298');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('17', 'Kprm Nishant Noida 1 to 49', '123', '5', '2026-10-07 10:29:54', '', '120363394772820432');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('18', 'KPRM mukesh Sahibabad', '123', '5', '2026-10-07 10:29:54', '', '120363420493546325');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('19', 'KPRM GGN reporting group Rs Negi', '123', '5', '2026-10-07 10:29:54', '', '120363404206609609');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('20', 'Palwal Haryana Location', '123', '5', '2026-10-07 10:29:54', '', '120363150936639140');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('21', 'Aman Greater Noida dhankaur', '123', '5', '2026-10-07 10:29:54', '', '120363408160881003');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('22', 'UP WEST-DEEPAK (MEERUT, BAGPAT, BULAND, SAMLI, SAH', '123', '5', '2026-10-07 10:29:54', '', '120363393585155679');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('23', '@Noida sec 51 to 79, 121 (Except 63A) khora', '123', '5', '2026-10-07 10:29:54', '', '120363314204152892');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('24', 'KPRM GGN allocation RS Negi Group', '123', '5', '2026-10-07 10:29:54', '', '120363422086618984');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('25', 'Rohit -hapur,pilkulva,masoori, garhmukteshwar,dhol', '123', '5', '2026-10-07 10:29:54', '', '120363369205248212');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('26', 'Haryana location-Arif', '123', '5', '2026-10-07 10:29:54', '', '120363161696982634');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('27', 'East Delhi 32,51,53,93,94, Loni', '123', '5', '2026-10-07 10:29:54', '', '120363062812213762');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('28', 'Pramod g haryana location', '123', '5', '2026-10-07 10:29:54', '', '120363247878692989');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('29', 'Deepak sector 125 to144+168', '123', '5', '2026-10-07 10:29:54', '', '120363293404141902');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('30', 'Up Muradabad location 2 vipin', '123', '5', '2026-10-07 10:29:54', '', '120363424619076062');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('31', 'KPRM All Up and HR Location (KPRM), Punjab', '123', '5', '2026-10-07 10:29:54', '', '120363410331169599');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('32', 'KPRM..... J..J..P..S😎', '123', '5', '2026-10-07 10:29:54', '', '918882099373@c.us');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('33', 'Kprm Gurgaon + Haryana allocation group', '123', '5', '2026-10-07 10:29:54', '', '120363320353870042');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('34', 'NEW ALL FARIDABAD', '123', '5', '2026-10-07 10:29:54', '', '120363427098313154');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('35', 'Shashi KPRM sector 80-110+ph2', '123', '5', '2026-10-07 10:29:54', '', '120363293775005071');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('36', 'Sachin noida highway 125 to 150', '123', '5', '2026-10-07 10:29:54', '', '120363410662737612');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('37', 'RMOCS- Daily Reporting', '123', '5', '2026-10-07 10:29:54', '', '120363153326065656');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('38', 'Abhishek Noida sector 51-78 112-122', '123', '5', '2026-10-07 10:29:54', '', '120363404357622311');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('39', 'PTM LETTER VERIFICATION', '123', '5', '2026-10-07 10:29:54', '', '120363283908152272');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('40', 'KPRM Vaishali Pending cases', '123', '5', '2026-10-07 10:29:54', '', '120363428553109532');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('41', 'Rohit only reporting group', '123', '5', '2026-10-07 10:29:54', '', '120363368664499230');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('42', 'Manish delhi 55, 05, 08', '123', '5', '2026-10-07 10:29:54', '', '120363320877987866');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('43', 'Jatin east delhi 91 and 92', '123', '5', '2026-10-07 10:29:54', '', '120363318802345234');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('44', 'Tejpal 55 to 70 noida Chotpur bahlolpur', '123', '5', '2026-10-07 10:29:54', '', '120363308294617951');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('45', '@Noida sector 1 to 53', '123', '5', '2026-10-07 10:29:54', '', '120363296282948233');
INSERT INTO `users` (`id`, `username`, `password_hash`, `role_id`, `created_at`, `email`, `mobile`) VALUES ('46', 'Kprm Gurgaon + Haryana reporting group', '123', '5', '2026-10-07 10:29:54', '', '120363320560852904');

-- --------------------------------------------------------
-- Structure for table `task_report_formats`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_report_formats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `slug` varchar(150) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `columns_json` text NOT NULL,
  `options_json` text,
  `extra_message` text,
  `is_system` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `task_report_formats` (`id`, `name`, `slug`, `description`, `columns_json`, `options_json`, `extra_message`, `is_system`) VALUES
(1, 'Standard 3-Column', 'standard_3_column', 'Clean 3-column table: Task Name, Status, Remarks', '[\"task_name\",\"status\",\"remarks\"]', '{\"hide_header\":false}', '', 1),
(5, 'Audit Trail (with Verifier & Date)', 'audit_trail_(with_verifier_&_date)', 'Full compliance audit: Sr No, Task, Verifier, Verified Date, Status, Remarks', '[\"sr_no.\",\"task_name\",\"verifier\",\"verified_at\",\"status\",\"remarks\"]', '{\"hide_header\":false}', '', 1),
(6, 'Custom Activity Prefix (Activity #01)', 'custom_activity_prefix_(activity_#01)', 'Formatted serials like Activity #01 with padded zeros', '[\"sr_no\",\"task_name\",\"status\",\"remarks\"]', '{\"sr_prefix\":\"Activity #\",\"sr_suffix\":\":\",\"sr_pad\":2,\"hide_header\":false}', '', 1)
ON DUPLICATE KEY UPDATE `name` = VALUES(`name`);

SET FOREIGN_KEY_CHECKS=1;
