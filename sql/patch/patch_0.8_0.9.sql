/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50726 (5.7.26)
 Source Host           : localhost:3306
 Source Schema         : wuyu_cost

 Target Server Type    : MySQL
 Target Server Version : 50726 (5.7.26)
 File Encoding         : 65001

 Date: 02/11/2023 23:41:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mh_config
-- ----------------------------
DROP TABLE IF EXISTS `mh_config`;
CREATE TABLE `mh_config`  (
  `Id` int(1) NOT NULL AUTO_INCREMENT,
  `config_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `config_value` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mh_config
-- ----------------------------
INSERT INTO `mh_config` VALUES (1, 'overtime_allow', 'false', NULL, '2023-11-02 23:27:38');
INSERT INTO `mh_config` VALUES (2, 'work_time', '8', NULL, '2023-11-02 23:27:38');
INSERT INTO `mh_config` VALUES (3, 'work_day', '20', NULL, '2023-11-02 23:27:38');
INSERT INTO `mh_config` VALUES (4, 'work_review', 'true', NULL, '2023-11-02 23:27:38');
INSERT INTO `mh_config` VALUES (5, 'hour_zero', 'true', NULL, '2023-11-02 23:27:38');


SET FOREIGN_KEY_CHECKS = 1;
