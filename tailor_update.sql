/*
 Navicat Premium Data Transfer

 Source Server         : MariaDB
 Source Server Type    : MariaDB
 Source Server Version : 110702
 Source Host           : localhost:3306
 Source Schema         : tailor

 Target Server Type    : MariaDB
 Target Server Version : 110702
 File Encoding         : 65001

 Date: 22/04/2025 08:26:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for calendar
-- ----------------------------
DROP TABLE IF EXISTS `calendar`;
CREATE TABLE `calendar`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order` int(8) NOT NULL DEFAULT 0,
  `title` varchar(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `allDay` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `color` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `repeat_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL,
  `repeat_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_uca1400_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of calendar
-- ----------------------------
INSERT INTO `calendar` VALUES (1, 4, 'ໂພສີກະ ສິດທິສານ: ທົດສອບ', 'ທົດສອບ', '2025-04-20 00:00:00', '2025-04-27 00:00:00', 'true', '#a00000', '../orderedit.php?id=4', 'Orders', '', 1, 0);
INSERT INTO `calendar` VALUES (2, 0, 'ທ.ນົກ: ທົດສອບ', 'ທົດສອບ', '2025-04-21 00:00:00', '2025-04-28 00:00:00', 'true', '#a00000', '../orderedit.php?id=5', 'Orders', '', 1, 0);

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phonenumber` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sex` tinyint(2) NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (7, 'ທ.ໂພສີກະ ສິດທິສານ', '02055916959', 'ບ້ານໜອງພະຍາ ເມືອງ ໄຊທານີ', 0, 'phosika@gmail.com', '					', 'ນະຄອນຫຼວງວຽງຈັນ');

-- ----------------------------
-- Table structure for documents
-- ----------------------------
DROP TABLE IF EXISTS `documents`;
CREATE TABLE `documents`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of documents
-- ----------------------------

-- ----------------------------
-- Table structure for email
-- ----------------------------
DROP TABLE IF EXISTS `email`;
CREATE TABLE `email`  (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `customer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of email
-- ----------------------------

-- ----------------------------
-- Table structure for expcat
-- ----------------------------
DROP TABLE IF EXISTS `expcat`;
CREATE TABLE `expcat`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 12 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of expcat
-- ----------------------------
INSERT INTO `expcat` VALUES (1, 'Material Purchase');
INSERT INTO `expcat` VALUES (2, 'Staff Salary');
INSERT INTO `expcat` VALUES (3, 'Rent');
INSERT INTO `expcat` VALUES (4, 'Staff Incentive');
INSERT INTO `expcat` VALUES (5, 'Machine Purchase');
INSERT INTO `expcat` VALUES (6, 'Machine Maintenance and Repair');
INSERT INTO `expcat` VALUES (7, 'Electricity');
INSERT INTO `expcat` VALUES (8, 'Generator Fuel');
INSERT INTO `expcat` VALUES (9, 'Generator Maintenance');
INSERT INTO `expcat` VALUES (10, 'Tax, Dues, Security, Waste');
INSERT INTO `expcat` VALUES (11, 'Needle, Tread, Accessory Purchase');

-- ----------------------------
-- Table structure for expense
-- ----------------------------
DROP TABLE IF EXISTS `expense`;
CREATE TABLE `expense`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expcat` int(8) NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `amount` int(8) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of expense
-- ----------------------------
INSERT INTO `expense` VALUES (1, 7, 'ຄ່າໄຟຟ້າເດືອນ 3', '2025-04-21', 200000);

-- ----------------------------
-- Table structure for general_setting
-- ----------------------------
DROP TABLE IF EXISTS `general_setting`;
CREATE TABLE `general_setting`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sitename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `currency` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sms` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of general_setting
-- ----------------------------
INSERT INTO `general_setting` VALUES (1, 'SARU TECH', 'agbonayeosaru@gmail.com', '07068242918', '$', ' http://sms.marketnaija.com//API/?action=compose&username=mamama&api_key=aaaaaa999999ddddd&sender=sarutech&to=[TO]&message=[MESSAGE] Just Fill Up the full text from your sms api service with replace message with[MESSAGE] and To-Phonenumber with [TO]');

-- ----------------------------
-- Table structure for inccat
-- ----------------------------
DROP TABLE IF EXISTS `inccat`;
CREATE TABLE `inccat`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inccat
-- ----------------------------
INSERT INTO `inccat` VALUES (1, 'Sew  New Cloth');
INSERT INTO `inccat` VALUES (2, 'Repair Cloth');
INSERT INTO `inccat` VALUES (4, 'Training and Tutor');
INSERT INTO `inccat` VALUES (5, 'Machine Repair');
INSERT INTO `inccat` VALUES (6, 'Mass Production');

-- ----------------------------
-- Table structure for income
-- ----------------------------
DROP TABLE IF EXISTS `income`;
CREATE TABLE `income`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inccat` int(8) NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `amount` int(8) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of income
-- ----------------------------
INSERT INTO `income` VALUES (1, 1, 'Payment for Order: 5', '2025-04-21', 300000);

-- ----------------------------
-- Table structure for measurement
-- ----------------------------
DROP TABLE IF EXISTS `measurement`;
CREATE TABLE `measurement`  (
  `measurement_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `part_id` int(8) NOT NULL,
  `measurement` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`measurement_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of measurement
-- ----------------------------
INSERT INTO `measurement` VALUES (1, 3, 14, '');
INSERT INTO `measurement` VALUES (2, 3, 15, '');
INSERT INTO `measurement` VALUES (3, 3, 16, '');
INSERT INTO `measurement` VALUES (4, 3, 17, '');
INSERT INTO `measurement` VALUES (5, 3, 18, '');
INSERT INTO `measurement` VALUES (6, 3, 19, '');
INSERT INTO `measurement` VALUES (7, 3, 20, '');
INSERT INTO `measurement` VALUES (8, 3, 21, '');
INSERT INTO `measurement` VALUES (9, 3, 38, '');
INSERT INTO `measurement` VALUES (10, 3, 39, '');
INSERT INTO `measurement` VALUES (11, 3, 40, '');
INSERT INTO `measurement` VALUES (12, 3, 41, '');
INSERT INTO `measurement` VALUES (13, 3, 42, '');
INSERT INTO `measurement` VALUES (14, 3, 43, '');
INSERT INTO `measurement` VALUES (15, 3, 44, '');
INSERT INTO `measurement` VALUES (16, 3, 45, '');
INSERT INTO `measurement` VALUES (17, 3, 47, '');
INSERT INTO `measurement` VALUES (18, 3, 48, '');
INSERT INTO `measurement` VALUES (19, 3, 49, '');
INSERT INTO `measurement` VALUES (20, 3, 50, '');
INSERT INTO `measurement` VALUES (21, 3, 51, '');
INSERT INTO `measurement` VALUES (22, 3, 52, '');
INSERT INTO `measurement` VALUES (23, 3, 53, '');
INSERT INTO `measurement` VALUES (24, 3, 54, '');
INSERT INTO `measurement` VALUES (25, 5, 14, '32');
INSERT INTO `measurement` VALUES (26, 5, 15, '23');
INSERT INTO `measurement` VALUES (27, 5, 16, '23');
INSERT INTO `measurement` VALUES (28, 5, 17, '23');
INSERT INTO `measurement` VALUES (29, 5, 18, '23');
INSERT INTO `measurement` VALUES (30, 5, 19, '23');
INSERT INTO `measurement` VALUES (31, 5, 20, '23');
INSERT INTO `measurement` VALUES (32, 5, 21, '23');
INSERT INTO `measurement` VALUES (33, 5, 38, '23');
INSERT INTO `measurement` VALUES (34, 5, 39, '23');
INSERT INTO `measurement` VALUES (35, 5, 40, '23');
INSERT INTO `measurement` VALUES (36, 5, 41, '23');
INSERT INTO `measurement` VALUES (37, 5, 42, '23');
INSERT INTO `measurement` VALUES (38, 5, 43, '23');
INSERT INTO `measurement` VALUES (39, 5, 44, '23');
INSERT INTO `measurement` VALUES (40, 5, 45, '23');
INSERT INTO `measurement` VALUES (41, 5, 47, '23');
INSERT INTO `measurement` VALUES (42, 5, 48, '23');
INSERT INTO `measurement` VALUES (43, 5, 49, '23');
INSERT INTO `measurement` VALUES (44, 5, 50, '23');
INSERT INTO `measurement` VALUES (45, 5, 51, '23');
INSERT INTO `measurement` VALUES (46, 5, 52, '23');
INSERT INTO `measurement` VALUES (47, 5, 53, '23');
INSERT INTO `measurement` VALUES (48, 5, 54, '23');
INSERT INTO `measurement` VALUES (49, 7, 14, '2');
INSERT INTO `measurement` VALUES (50, 7, 15, '2');
INSERT INTO `measurement` VALUES (51, 7, 16, '2');
INSERT INTO `measurement` VALUES (52, 7, 17, '2');
INSERT INTO `measurement` VALUES (53, 7, 18, '2');
INSERT INTO `measurement` VALUES (54, 7, 19, '2');
INSERT INTO `measurement` VALUES (55, 7, 20, '2');
INSERT INTO `measurement` VALUES (56, 7, 21, '2');
INSERT INTO `measurement` VALUES (57, 7, 38, '2');
INSERT INTO `measurement` VALUES (58, 7, 39, '2');
INSERT INTO `measurement` VALUES (59, 7, 40, '2');
INSERT INTO `measurement` VALUES (60, 7, 41, '2');
INSERT INTO `measurement` VALUES (61, 7, 42, '2');
INSERT INTO `measurement` VALUES (62, 7, 43, '2');
INSERT INTO `measurement` VALUES (63, 7, 44, '2');
INSERT INTO `measurement` VALUES (64, 7, 45, '2');
INSERT INTO `measurement` VALUES (65, 7, 47, '2');
INSERT INTO `measurement` VALUES (66, 7, 48, '2');
INSERT INTO `measurement` VALUES (67, 7, 49, '2');
INSERT INTO `measurement` VALUES (68, 7, 50, '2');
INSERT INTO `measurement` VALUES (69, 7, 51, '2');
INSERT INTO `measurement` VALUES (70, 7, 52, '2');
INSERT INTO `measurement` VALUES (71, 7, 53, '2');
INSERT INTO `measurement` VALUES (72, 7, 54, '2');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `customer` int(8) NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `amount` decimal(11, 2) NOT NULL,
  `paid` decimal(11, 2) NOT NULL,
  `balance` decimal(11, 2) NOT NULL DEFAULT 0.00,
  `received_by` int(11) NOT NULL,
  `date_received` date NOT NULL,
  `completed` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'No',
  `date_collected` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `date_received`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf16 COLLATE = utf16_uca1400_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (5, 7, 'ທົດສອບ', 500000.00, 500000.00, 0.00, 1, '2025-04-21', 'No', '2025-04-28');

-- ----------------------------
-- Table structure for part
-- ----------------------------
DROP TABLE IF EXISTS `part`;
CREATE TABLE `part`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `image` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of part
-- ----------------------------
INSERT INTO `part` VALUES (3, 'NECK', 7, '  Place two fingers between the tape measure and the neck as the pictures show, and make sure you can move the tape easily. Do not tighten the tape measure. Make sure that the tape is at the base of the neck where the neck and shoulders meet or at the height where the collar would be if you were wearing a shirt.', 'neck.jpg');
INSERT INTO `part` VALUES (4, 'CHEST', 1, ' Stand up straight, relax and take deep breath with hands down at your side. The chest measurement should be taken around the chest under the armpits. Make sure the tape is parallel and you can move the tape easily. Do not tighten the tape measure. Avoid having thick clothes on when measuring.', 'chest.jpg');
INSERT INTO `part` VALUES (5, 'WAIST', 1, ' Stand up in a relaxed posture, do not hold your breath or hold your stomach in. If you do not have beer belly, the waist measurement should be taken around the waist at the narrowest point. If you have beer belly, you should measure the widest point. Make sure you can move the tape easily. Do not tighten the tape measure.', 'waist.jpg');
INSERT INTO `part` VALUES (6, 'HIPS', 1, ' Take out all of the stuff in the front and back pockets your trouser. The hip measurement should be taken around the hips at the widest point. Stand up in a relaxed posture, and keep the tape parallel. Do not tighten the tape measure. Make sure you can move the tape easily. ', 'hips.jpg');
INSERT INTO `part` VALUES (7, 'SHOULDER', 1, ' Stand up in a relaxed posture. Measure across the top of the shoulder from one edge to the other. Ensure you take the curved contour over the top of the shoulders as shown. If you are wearing your best fitted shirt measure up to the shoulder seams', 'shoulder.jpg');
INSERT INTO `part` VALUES (8, 'SLEEVE LENGTH', 1, ' The sleeve measurement should be taken from exactly the same point you used earlier for the \"Shoulder\" measurement. Measure from tip of shoulder to a point at the wrist where you want the sleeve to end. Do not bend your arms. If you want to match your dress shirt with a suit, you should measure the suit sleeve length you want, and then add one (1) centimeter .That will be the shirt\'s sleeve length.\n', 'sleeve-length.jpg');
INSERT INTO `part` VALUES (9, 'SHORT SLEEVE LENGTH ', 1, ' Measure with arm at your side, from the tip of the shoulder to a point on the outside of the arm where you want the sleeve to end. ', 'short-sleeve-length.jpg');
INSERT INTO `part` VALUES (10, 'WRIST/CUFF ', 1, ' Measure the actual wrist size around your wrist bone. You may also consider adding Â¼\" to Â½\" to your size if you wear medium to heavier watches. ', 'wrist-cuff.jpg');
INSERT INTO `part` VALUES (11, 'BICEP ', 1, ' widest point. This is normally taken about 15cm to 18 cm from the tip of the shoulder seam. This is the sleeve width of the largest part of your arm. **Do not flex your bicep.** ', 'biceps.jpg');
INSERT INTO `part` VALUES (12, 'SHIRT LENGTH ', 1, ' Stand up in a relaxed posture. Measure from the topmost point of the shoulder at a point near the nape at the collar seam, along the front of your body, to a point where you want the shirt to end. ', 'shirt-length.jpg');
INSERT INTO `part` VALUES (13, ' ARMHOLE ', 1, ' Place the tape measure under your armpit and around the top of your arm. To ensure a comfortable fit, take the armhole measurement with one finger inside the tape measure. ', 'arm-hole.jpg');
INSERT INTO `part` VALUES (14, 'WAIST', 3, ' Wearing trousers and a shirt put the measuring tape around your waist at the height were you would wear your pants and adjust to your designed snugness with room for a finger. Make sure the tape is snug and does not ride over the waistband but you should be able to put your index finger inside the tape.  ', 'touser-waist.jpg');
INSERT INTO `part` VALUES (15, 'HIPS ', 3, ' Wearing trousers, measure around the fullest part of your hips, placing a finger between your body and the tape. Make sure the tape is straight at all times. Make sure your pockets are empty and the tape is not restrictive. As a guide, you should not make the tape too snug. You only just need to be able to feel the tape when measuring.', 'touser-hip.jpg');
INSERT INTO `part` VALUES (16, 'CROTCH', 3, ' Measure from the top middle of the back pants waist (see point A) all along the crotch seam through your legs until the top of front waist (see point B)', 'touser-crotch.jpg');
INSERT INTO `part` VALUES (17, 'THIGH WIDTH ', 3, ' Wearing trousers, empty your pockets then, start at the top of your inseam, measure around your thigh with room for a finger.', 'touser-thigh-width..jpg');
INSERT INTO `part` VALUES (18, 'TROUSER LENGTH', 3, ' Measure from the top of pants waist all along the side pant seam until the bottom of your pants or roughly 1 inch from the ground', 'touser-length.jpg');
INSERT INTO `part` VALUES (19, ' INSEAM ', 3, ' Measure from the lowest part of your crotch area to the floor.  Make sure the tape is tight along the inside of your leg, that you are standing straight, and then measure.  No shoes please! ', 'touser-inseam.jpg');
INSERT INTO `part` VALUES (20, ' KNEE ', 3, ' Measure around your knee at its widest point.  You need only measure one knee', 'touser-knee.jpg');
INSERT INTO `part` VALUES (21, 'HALF HEM ', 3, ' Measure the width you want for the bottom of your trousers. ', 'touser-crotch-half-hem.jpg');
INSERT INTO `part` VALUES (22, 'SHIRT LENGTH ', 2, ' Take the measure from the highest part of your shoulder (next to the collar) to the longest part of the shirt. See image on the left. ', 'shirt-length.jpg');
INSERT INTO `part` VALUES (23, 'SHOULDER WIDTH ', 2, ' Measure the distance from one shoulder to the other, the measuring tape has to start and finish one centimeter before the end of your shoulder. See picture on the left. ', 'shoulder-width.jpg');
INSERT INTO `part` VALUES (24, 'NECK', 2, ' Measure around your neck. Adjust the measuring tape to your preferred looseness. It is very important to introduce a finger between your body and the tape. ', 'neck.jpg');
INSERT INTO `part` VALUES (25, 'CHEST', 2, ' Measure around the widest part of your chest (put the measuring tape on both nipples). Let loose so that you can put a finger between your body and the tape. Make sure that the tape is at an even height all the way around. ', 'chest.jpg');
INSERT INTO `part` VALUES (26, ' BICEP ', 2, ' Measure around the widest part of your bicep. Let loose so that you can put a finger between your body and the tape. ', 'bicep.jpg');
INSERT INTO `part` VALUES (27, 'WRIST', 2, ' Measure around the wrist leaving one finger of space to take the measurement. ', 'wrist.jpg');
INSERT INTO `part` VALUES (28, 'SLEEVE', 2, ' ', 'sleeve.jpg');
INSERT INTO `part` VALUES (29, 'SHORT SLEEVE ', 2, ' ', 'short-sleeve.jpg');
INSERT INTO `part` VALUES (30, 'Â¾ SLEEVE ', 2, ' ', '3-4-sleeve.jpg');
INSERT INTO `part` VALUES (31, 'WAIST', 2, ' ', 'waist.jpg');
INSERT INTO `part` VALUES (32, 'STOMACH ', 2, ' ', 'stomach.jpg');
INSERT INTO `part` VALUES (33, ' HIPS ', 2, ' ', 'hips.jpg');
INSERT INTO `part` VALUES (34, ' BREAST POINT ', 2, ' Measure from the highest point of your shoulder, to the breast point (the most outstanding part of your breast). ', 'breast.jpg');
INSERT INTO `part` VALUES (35, 'WAIST POINT ', 2, ' ', 'waist-point.jpg');
INSERT INTO `part` VALUES (36, 'SLEEVE HOLE ', 2, ' ', 'sleeve-hole.jpg');
INSERT INTO `part` VALUES (37, 'BUST', 2, ' ', 'bust.jpg');
INSERT INTO `part` VALUES (38, 'NECK', 6, ' ', 'neck.jpg');
INSERT INTO `part` VALUES (39, 'CHEST', 6, ' ', 'chest.jpg');
INSERT INTO `part` VALUES (40, 'STOMACH ', 6, ' ', 'stomach.jpg');
INSERT INTO `part` VALUES (41, 'WAIST', 6, ' ', 'waist.jpg');
INSERT INTO `part` VALUES (42, 'HIPS', 6, ' ', 'hips.jpg');
INSERT INTO `part` VALUES (43, 'SHOULDER', 6, ' ', 'shoulder.jpg');
INSERT INTO `part` VALUES (44, 'JACKET LENGTH', 6, ' ', 'jacket-lenght.jpg');
INSERT INTO `part` VALUES (45, 'SLEEVE LENGTH', 6, ' ', 'sleeve-length.jpg');
INSERT INTO `part` VALUES (46, 'BICEP ', 2, ' ', 'biceps.jpg');
INSERT INTO `part` VALUES (47, 'WRIST', 6, ' ', 'wrist.jpg');
INSERT INTO `part` VALUES (48, ' VEST LENGTH ', 6, ' ', 'vest-lenght.jpg');
INSERT INTO `part` VALUES (49, 'CROTCH', 6, ' ', 'crotch.jpg');
INSERT INTO `part` VALUES (50, 'THIGH WIDTH ', 6, ' ', 'thigh-width.jpg');
INSERT INTO `part` VALUES (51, 'TROUSER LENGTH', 6, ' ', 'pant-length.jpg');
INSERT INTO `part` VALUES (52, 'INSEAM', 6, ' ', 'inseam.jpg');
INSERT INTO `part` VALUES (53, 'KNEE', 6, ' ', 'knee.jpg');
INSERT INTO `part` VALUES (54, 'HALF HEM ', 6, ' ', 'half-hem.jpg');
INSERT INTO `part` VALUES (55, 'WAIST', 4, '  ', 'skirtwaist.png');
INSERT INTO `part` VALUES (56, 'WAIST TO HIP HEIGHT', 4, '   ', 'skirthip1.png');
INSERT INTO `part` VALUES (57, 'LENGHT', 4, 'Women  Skirt Lenght', 'skirtlenght.png');
INSERT INTO `part` VALUES (58, 'HALLOW TO HEM', 5, 'HALLOW TO HEM', 'gown.jpg');
INSERT INTO `part` VALUES (59, 'HIP WIDTH', 4, '  ', 'skirthip2.png');
INSERT INTO `part` VALUES (60, 'BURST', 5, ' ', 'gown.jpg');
INSERT INTO `part` VALUES (61, 'WAIST', 5, ' ', 'gown.jpg');
INSERT INTO `part` VALUES (62, 'HIP', 5, ' ', 'gown.jpg');
INSERT INTO `part` VALUES (63, 'Hcig', 14, ' ', '');
INSERT INTO `part` VALUES (64, '', 1, ' ', '');
INSERT INTO `part` VALUES (65, 'Water', 1, ' jk.;l', '');

-- ----------------------------
-- Table structure for sms
-- ----------------------------
DROP TABLE IF EXISTS `sms`;
CREATE TABLE `sms`  (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `customer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `message` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms
-- ----------------------------

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff`  (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `stafftype` int(8) NOT NULL,
  `fullname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phonenumber` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salary` int(8) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES (1, 1, 'ນ.ກ', 'ທົດສອບ', '02055916959', 3000000);

-- ----------------------------
-- Table structure for stafftype
-- ----------------------------
DROP TABLE IF EXISTS `stafftype`;
CREATE TABLE `stafftype`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stafftype
-- ----------------------------
INSERT INTO `stafftype` VALUES (1, 'Tailor');
INSERT INTO `stafftype` VALUES (2, 'Counter');
INSERT INTO `stafftype` VALUES (3, 'Security');
INSERT INTO `stafftype` VALUES (4, 'Manager');

-- ----------------------------
-- Table structure for template
-- ----------------------------
DROP TABLE IF EXISTS `template`;
CREATE TABLE `template`  (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of template
-- ----------------------------
INSERT INTO `template` VALUES (1, 'Collect Your Clothes', 'Your Clothes are ready for collection. Thanks for your patronage');

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sex` tinyint(2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES (1, 'SHIRT', 1);
INSERT INTO `type` VALUES (2, 'BLOUSE', 1);
INSERT INTO `type` VALUES (3, 'TROUSER', 0);
INSERT INTO `type` VALUES (4, 'SKIRT', 1);
INSERT INTO `type` VALUES (5, 'GOWN', 1);
INSERT INTO `type` VALUES (6, 'SUIT', 0);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_uca1400_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '21232f297a57a5a743894a0e4a801fc3');
INSERT INTO `users` VALUES (2, 'testuser', '8cb2237d0679ca88db6464eac60da96345513964');

SET FOREIGN_KEY_CHECKS = 1;
