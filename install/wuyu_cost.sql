/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50737
 Source Host           : localhost:3306
 Source Schema         : wuyu_cost

 Target Server Type    : MySQL
 Target Server Version : 50737
 File Encoding         : 65001

 Date: 26/12/2023 15:59:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'stu', '', NULL, NULL, 'Stu', 'crud', 'com.ruoyi.system', 'system', 'stu', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2021-08-22 09:07:52', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (2, 'sys_project', '项目表', NULL, NULL, 'SysProject', 'crud', 'com.oaker.system', 'system', 'project', '项目', '\" é¡»å°½æ¬¢ _____', '0', '/', NULL, 'admin', '2021-09-03 10:10:06', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, '1', 'id', NULL, 'int', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-08-22 09:07:52', '', NULL);
INSERT INTO `gen_table_column` VALUES (2, '1', 'stu_name', NULL, 'varchar(32)', 'String', 'stuName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-08-22 09:07:52', '', NULL);
INSERT INTO `gen_table_column` VALUES (3, '1', 'class_num', NULL, 'int', 'Long', 'classNum', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-08-22 09:07:52', '', NULL);
INSERT INTO `gen_table_column` VALUES (4, '2', 'project_id', '项目id', 'bigint', 'Long', 'projectId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-03 10:10:07', '', NULL);
INSERT INTO `gen_table_column` VALUES (5, '2', 'project_name', '项目名称', 'varchar(255)', 'String', 'projectName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-09-03 10:10:07', '', NULL);
INSERT INTO `gen_table_column` VALUES (6, '2', 'duration', '预计投入工时', 'double(20,2)', 'BigDecimal', 'duration', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-09-03 10:10:07', '', NULL);
INSERT INTO `gen_table_column` VALUES (7, '2', 'project_manager', '项目经理id', 'bigint', 'Long', 'projectManager', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2021-09-03 10:10:07', '', NULL);
INSERT INTO `gen_table_column` VALUES (8, '2', 'project_status', '项目状态：a 进行中，b运维，c 归档', 'char(10)', 'String', 'projectStatus', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 5, 'admin', '2021-09-03 10:10:07', '', NULL);
INSERT INTO `gen_table_column` VALUES (9, '2', 'remark', '项目简介', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 6, 'admin', '2021-09-03 10:10:07', '', NULL);
INSERT INTO `gen_table_column` VALUES (10, '2', 'create_by', '创建人', 'varchar(64)', 'String', 'createBy', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2021-09-03 10:10:07', '', NULL);
INSERT INTO `gen_table_column` VALUES (11, '2', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2021-09-03 10:10:07', '', NULL);
INSERT INTO `gen_table_column` VALUES (12, '2', 'update_by', '更新人', 'varchar(54)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2021-09-03 10:10:07', '', NULL);
INSERT INTO `gen_table_column` VALUES (13, '2', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2021-09-03 10:10:07', '', NULL);

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
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_config
-- ----------------------------
INSERT INTO `mh_config` VALUES (1, 'overtime_allow', 'false', NULL, '2023-11-02 23:27:38');
INSERT INTO `mh_config` VALUES (2, 'work_time', '8', NULL, '2023-11-02 23:27:38');
INSERT INTO `mh_config` VALUES (3, 'work_day', '20', NULL, '2023-11-02 23:27:38');
INSERT INTO `mh_config` VALUES (4, 'work_review', 'true', NULL, '2023-11-02 23:27:38');
INSERT INTO `mh_config` VALUES (5, 'hour_zero', 'true', NULL, '2023-11-02 23:27:38');

-- ----------------------------
-- Table structure for mh_cost
-- ----------------------------
DROP TABLE IF EXISTS `mh_cost`;
CREATE TABLE `mh_cost`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_id` bigint(20) NOT NULL COMMENT '项目id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `use_hour` double(10, 2) NOT NULL DEFAULT 0.00 COMMENT '所用工时',
  `post_cost` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '岗位成本',
  `user_cost` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '人员成本',
  `cost_date` date NULL DEFAULT NULL COMMENT '日期',
  `project_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'a' COMMENT '项目状态：a 进行中，b运维，c 结束',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_id_index`(`project_id`) USING BTREE COMMENT '项目id索引',
  INDEX `user_id_index`(`user_id`) USING BTREE COMMENT '用户id索引'
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '成本记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_cost
-- ----------------------------
INSERT INTO `mh_cost` VALUES (1, 37, 127, 2.00, 0.00, 0.00, '2023-03-25', 'a', '2023-03-26 11:17:00');

-- ----------------------------
-- Table structure for mh_hour_detail
-- ----------------------------
DROP TABLE IF EXISTS `mh_hour_detail`;
CREATE TABLE `mh_hour_detail`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `hour_id` bigint(20) NOT NULL COMMENT '工时填报表id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `project_id` bigint(20) NOT NULL COMMENT '项目id',
  `use_hour` double(20, 2) NOT NULL DEFAULT 0.00 COMMENT '工时',
  `fill_date` date NOT NULL COMMENT '填报日期',
  `project_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'a' COMMENT '项目状态：a 进行中，b运维，c 结束',
  `everyday` tinyint(4) NOT NULL DEFAULT 1 COMMENT '是否为每日上报工时记录 0 否  1 是',
  `daily` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日报内容',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_hour_id`(`hour_id`) USING BTREE COMMENT '工时填报表id索引',
  INDEX `fill_data_index`(`fill_date`) USING BTREE COMMENT '填报日期索引'
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工时填报详情表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_hour_detail
-- ----------------------------
INSERT INTO `mh_hour_detail` VALUES (17, 14, 127, 37, 2.00, '2023-03-25', 'a', 1, '1111', NULL, '2023-03-25 17:52:07');
INSERT INTO `mh_hour_detail` VALUES (18, 15, 127, 37, 2.00, '2023-12-26', 'a', 1, NULL, NULL, '2023-12-26 15:52:14');

-- ----------------------------
-- Table structure for mh_hour_detail_sub
-- ----------------------------
DROP TABLE IF EXISTS `mh_hour_detail_sub`;
CREATE TABLE `mh_hour_detail_sub`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `detail_id` bigint(20) NULL DEFAULT NULL COMMENT '详情Id',
  `work_type_id` bigint(20) NULL DEFAULT NULL COMMENT '工作类型Id',
  `use_hour` double(20, 2) NULL DEFAULT 0.00 COMMENT '工时',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工时填报详情表字表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_hour_detail_sub
-- ----------------------------
INSERT INTO `mh_hour_detail_sub` VALUES (1, 18, 2, 2.00, '2023-12-26 15:52:14');

-- ----------------------------
-- Table structure for mh_post_cost
-- ----------------------------
DROP TABLE IF EXISTS `mh_post_cost`;
CREATE TABLE `mh_post_cost`  (
  `post_id` bigint(20) NOT NULL COMMENT '岗位id',
  `cost` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '岗位成本',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  UNIQUE INDEX `post_id_index`(`post_id`) USING BTREE COMMENT '岗位id索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位成本表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_post_cost
-- ----------------------------

-- ----------------------------
-- Table structure for mh_project_hour
-- ----------------------------
DROP TABLE IF EXISTS `mh_project_hour`;
CREATE TABLE `mh_project_hour`  (
  `project_id` bigint(20) NOT NULL COMMENT '项目id',
  `man_hour` double(20, 2) NOT NULL COMMENT '预估投入工期',
  `use_hour` double(20, 2) NULL DEFAULT 0.00 COMMENT '已用工时',
  PRIMARY KEY (`project_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目工时表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_project_hour
-- ----------------------------
INSERT INTO `mh_project_hour` VALUES (37, 88888.00, 4.00);

-- ----------------------------
-- Table structure for mh_project_statistics
-- ----------------------------
DROP TABLE IF EXISTS `mh_project_statistics`;
CREATE TABLE `mh_project_statistics`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_id` bigint(20) NOT NULL COMMENT '项目id',
  `man_total` int(11) NOT NULL COMMENT '参与人数',
  `fill_total` int(11) NOT NULL COMMENT '工时填报人数',
  `fill_hour` double(20, 2) NOT NULL DEFAULT 0.00 COMMENT '上报工时',
  `hour_total` double(20, 2) NOT NULL COMMENT '累计投入工时',
  `create_date` date NOT NULL COMMENT '统计日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_project_id`(`project_id`) USING BTREE COMMENT '项目id索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目进度统计表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_project_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for mh_user_cost
-- ----------------------------
DROP TABLE IF EXISTS `mh_user_cost`;
CREATE TABLE `mh_user_cost`  (
  `user_id` bigint(20) NOT NULL COMMENT '人员id',
  `cost` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '人员成本',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '人员成本表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_user_cost
-- ----------------------------

-- ----------------------------
-- Table structure for mh_user_hour
-- ----------------------------
DROP TABLE IF EXISTS `mh_user_hour`;
CREATE TABLE `mh_user_hour`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `fill_date` date NOT NULL COMMENT '填报日期',
  `total_hour` double(20, 2) NULL DEFAULT NULL COMMENT '总工时',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `review_status` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id索引'
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工时填报表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_user_hour
-- ----------------------------
INSERT INTO `mh_user_hour` VALUES (15, 127, '2023-12-26', 2.00, '2023-12-26 15:52:14', 1);

-- ----------------------------
-- Table structure for mh_user_hour_miss
-- ----------------------------
DROP TABLE IF EXISTS `mh_user_hour_miss`;
CREATE TABLE `mh_user_hour_miss`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `miss_date` date NOT NULL COMMENT '缺报日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_user_id`(`user_id`) USING BTREE COMMENT '用户id索引'
) ENGINE = InnoDB AUTO_INCREMENT = 505 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户缺报记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_user_hour_miss
-- ----------------------------

-- ----------------------------
-- Table structure for mh_user_hour_miss_detail
-- ----------------------------
DROP TABLE IF EXISTS `mh_user_hour_miss_detail`;
CREATE TABLE `mh_user_hour_miss_detail`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `miss_id` bigint(20) NOT NULL COMMENT '缺报记录表id',
  `project_id` bigint(20) NOT NULL COMMENT '项目id',
  `project_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'a' COMMENT '项目状态：a 进行中，b运维，c 结束',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `miss_date` date NOT NULL COMMENT '缺报日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_id_index`(`project_id`) USING BTREE COMMENT '项目id索引',
  INDEX `user_id_index`(`user_id`) USING BTREE COMMENT '用户id索引'
) ENGINE = InnoDB AUTO_INCREMENT = 826 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户缺报详情表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_user_hour_miss_detail
-- ----------------------------

-- ----------------------------
-- Table structure for mh_user_leave
-- ----------------------------
DROP TABLE IF EXISTS `mh_user_leave`;
CREATE TABLE `mh_user_leave`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `leave_date` date NOT NULL COMMENT '请假日期',
  `leave_type` int(11) NOT NULL DEFAULT 1 COMMENT '类型：1请假  2倒休',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `leave_date_index`(`leave_date`) USING BTREE COMMENT '请假日期索引',
  INDEX `user_id_index`(`user_id`) USING BTREE COMMENT '用户id索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户请假记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_user_leave
-- ----------------------------

-- ----------------------------
-- Table structure for mh_user_leave_detail
-- ----------------------------
DROP TABLE IF EXISTS `mh_user_leave_detail`;
CREATE TABLE `mh_user_leave_detail`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `leave_id` bigint(20) NOT NULL COMMENT '缺报记录表id',
  `project_id` bigint(20) NOT NULL COMMENT '项目id',
  `project_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'a' COMMENT '项目状态：a 进行中，b运维，c 结束',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `leave_date` date NOT NULL COMMENT '缺报日期',
  `leave_type` int(11) NOT NULL DEFAULT 1 COMMENT '类型：1请假  2倒休',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_id_index`(`project_id`) USING BTREE COMMENT '项目id索引',
  INDEX `user_id_index`(`user_id`) USING BTREE COMMENT '用户id索引',
  INDEX `leave_id_index`(`leave_id`) USING BTREE COMMENT '请假记录id索引'
) ENGINE = InnoDB AUTO_INCREMENT = 2128 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户请假详情表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_user_leave_detail
-- ----------------------------

-- ----------------------------
-- Table structure for mh_work_type
-- ----------------------------
DROP TABLE IF EXISTS `mh_work_type`;
CREATE TABLE `mh_work_type`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '业务类型',
  `deleted` tinyint(4) NULL DEFAULT NULL COMMENT '删除标识0:未删除,1:已删除',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工作类型' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mh_work_type
-- ----------------------------
INSERT INTO `mh_work_type` VALUES (1, '开发', 0, 1, '2023-07-29 18:02:06');
INSERT INTO `mh_work_type` VALUES (2, '设计', 0, 1, '2023-07-29 18:02:12');
INSERT INTO `mh_work_type` VALUES (3, '测试', 0, 1, '2023-07-29 18:02:12');

-- ----------------------------
-- Table structure for pr_doc
-- ----------------------------
DROP TABLE IF EXISTS `pr_doc`;
CREATE TABLE `pr_doc`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `doc_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文档名称',
  `prototype_id` bigint(20) NOT NULL COMMENT '原型记录id',
  `doc_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文档地址',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件存放路径',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `prototype_id_index`(`prototype_id`) USING BTREE COMMENT '原型id索引'
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '原型文档' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pr_doc
-- ----------------------------

-- ----------------------------
-- Table structure for pr_prototype
-- ----------------------------
DROP TABLE IF EXISTS `pr_prototype`;
CREATE TABLE `pr_prototype`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `project_id` bigint(20) NULL DEFAULT NULL COMMENT '项目id',
  `record_id` bigint(20) NULL DEFAULT NULL COMMENT '原型地址记录id',
  `sketch_id` bigint(20) NULL DEFAULT NULL COMMENT '效果图id',
  `pub_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '原型公开id',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注说明',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除：0未删除， 1已删除',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `pub_id_index`(`pub_id`) USING BTREE COMMENT '原型公开id',
  INDEX `project_id_index`(`project_id`) USING BTREE COMMENT '项目id索引'
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '原型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pr_prototype
-- ----------------------------

-- ----------------------------
-- Table structure for pr_prototype_record
-- ----------------------------
DROP TABLE IF EXISTS `pr_prototype_record`;
CREATE TABLE `pr_prototype_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `file_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件名称',
  `prototype_id` bigint(20) NOT NULL COMMENT '原型id',
  `prototype_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '原型地址',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件存放路径',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `prototype_id_index`(`prototype_id`) USING BTREE COMMENT '原型id索引'
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '原型记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pr_prototype_record
-- ----------------------------

-- ----------------------------
-- Table structure for pr_sketch
-- ----------------------------
DROP TABLE IF EXISTS `pr_sketch`;
CREATE TABLE `pr_sketch`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件名称',
  `prototype_id` bigint(20) NOT NULL COMMENT '原型id',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件存放路径',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `prototype_id_index`(`prototype_id`) USING BTREE COMMENT '原型id索引'
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '效果图记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pr_sketch
-- ----------------------------

-- ----------------------------
-- Table structure for pr_sketch_file
-- ----------------------------
DROP TABLE IF EXISTS `pr_sketch_file`;
CREATE TABLE `pr_sketch_file`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sketch_id` bigint(20) NOT NULL COMMENT '效果图记录id',
  `file_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文档名称',
  `prototype_id` bigint(20) NOT NULL COMMENT '原型记录id',
  `file_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文档地址',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件存放路径',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sketch_id_index`(`sketch_id`) USING BTREE COMMENT '效果图记录id索引',
  INDEX `prototype_id_index`(`prototype_id`) USING BTREE COMMENT '原型id索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '效果图文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pr_sketch_file
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `blob_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('OakerScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('OakerScheduler', 'TASK_CLASS_NAME100', 'DEFAULT', '0 0 1 * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('OakerScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('OakerScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fired_time` bigint(20) NOT NULL,
  `sched_time` bigint(20) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('OakerScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.oaker.scheduled.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720021636F6D2E6F616B65722E7363686564756C65642E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E6F616B65722E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017B6B4A13B078707400007070707400013174000E302F3130202A202A202A202A203F74001172795461736B2E72794E6F506172616D7374000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000001740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000131740001317800);
INSERT INTO `qrtz_job_details` VALUES ('OakerScheduler', 'TASK_CLASS_NAME100', 'DEFAULT', NULL, 'com.oaker.scheduled.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720021636F6D2E6F616B65722E7363686564756C65642E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E6F616B65722E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017BE720BE8078707400007070707400013174000B3020302031202A202A203F74001D75736572486F75724D6973732E75736572486F75724D6973735461736B74000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000064740018E7BCBAE68AA5E5B7A5E697B6E5AE9AE697B6E4BBBBE58AA174000131740001307800);
INSERT INTO `qrtz_job_details` VALUES ('OakerScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 'com.oaker.scheduled.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720021636F6D2E6F616B65722E7363686564756C65642E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E6F616B65722E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017B6B4A13B078707400007070707400013174000E302F3135202A202A202A202A203F74001572795461736B2E7279506172616D7328277279272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000002740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('OakerScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 'com.oaker.scheduled.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720021636F6D2E6F616B65722E7363686564756C65642E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E6F616B65722E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017B6B4A13B078707400007070707400013174000E302F3230202A202A202A202A203F74003872795461736B2E72794D756C7469706C65506172616D7328277279272C20747275652C20323030304C2C203331362E3530442C203130302974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000003740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017B6B4A13B078707400007070707400013174000E302F3130202A202A202A202A203F74001172795461736B2E72794E6F506172616D7374000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000001740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017B6B4A13B078707400007070707400013174000E302F3135202A202A202A202A203F74001572795461736B2E7279506172616D7328277279272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000002740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000133740001317800);
INSERT INTO `qrtz_job_details` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017B6B4A13B078707400007070707400013174000E302F3230202A202A202A202A203F74003872795461736B2E72794D756C7469706C65506172616D7328277279272C20747275652C20323030304C2C203331362E3530442C203130302974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000003740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000133740001317800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('OakerScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('OakerScheduler', 'TRIGGER_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_checkin_time` bigint(20) NOT NULL,
  `checkin_interval` bigint(20) NOT NULL,
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('OakerScheduler', 'LAPTOP-DGEKSQO71703577087495', 1703577534652, 15000);
INSERT INTO `qrtz_scheduler_state` VALUES ('RuoyiScheduler', 'DESKTOP-DURH9O91631240178673', 1631240258246, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `repeat_count` bigint(20) NOT NULL,
  `repeat_interval` bigint(20) NOT NULL,
  `times_triggered` bigint(20) NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `int_prop_1` int(11) NULL DEFAULT NULL,
  `int_prop_2` int(11) NULL DEFAULT NULL,
  `long_prop_1` bigint(20) NULL DEFAULT NULL,
  `long_prop_2` bigint(20) NULL DEFAULT NULL,
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL,
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL,
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `next_fire_time` bigint(20) NULL DEFAULT NULL,
  `prev_fire_time` bigint(20) NULL DEFAULT NULL,
  `priority` int(11) NULL DEFAULT NULL,
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `start_time` bigint(20) NOT NULL,
  `end_time` bigint(20) NULL DEFAULT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `misfire_instr` smallint(6) NULL DEFAULT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('OakerScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1703577090000, -1, 5, 'PAUSED', 'CRON', 1703577087000, 0, NULL, -1, '');
INSERT INTO `qrtz_triggers` VALUES ('OakerScheduler', 'TASK_CLASS_NAME100', 'DEFAULT', 'TASK_CLASS_NAME100', 'DEFAULT', NULL, 1703610000000, -1, 5, 'WAITING', 'CRON', 1703577087000, 0, NULL, -1, '');
INSERT INTO `qrtz_triggers` VALUES ('OakerScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1703577090000, -1, 5, 'PAUSED', 'CRON', 1703577087000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('OakerScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 1703577100000, -1, 5, 'PAUSED', 'CRON', 1703577087000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1631240180000, -1, 5, 'PAUSED', 'CRON', 1631240178000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1631240190000, -1, 5, 'PAUSED', 'CRON', 1631240179000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 1631240180000, -1, 5, 'PAUSED', 'CRON', 1631240179000, 0, NULL, 2, '');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2021-08-22 08:37:02', 'admin', '2021-09-01 02:00:54', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2021-08-22 08:37:02', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2021-08-22 08:37:02', 'admin', '2021-09-01 02:04:21', '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaOnOff', 'true', 'N', 'admin', '2021-08-22 08:37:02', 'admin', '2023-03-26 11:14:19', '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2021-08-22 08:37:02', '', NULL, '是否开启注册用户功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 207 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '无鱼软件', 0, '小鱼', '15888888888', 'dmk@qq.com', '0', '0', 'admin', '2021-08-22 08:37:02', 'admin', '2022-11-09 08:28:16');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '北京总公司', 1, '陈', '15888888888', 'chen@qq.com', '0', '2', 'admin', '2021-08-22 08:37:02', 'admin', '2021-08-31 06:55:43');
INSERT INTO `sys_dept` VALUES (202, 100, '0,100', '开发部', 1, NULL, NULL, NULL, '0', '0', 'admin', '2022-11-09 08:28:28', '', NULL);
INSERT INTO `sys_dept` VALUES (203, 100, '0,100', '项目部', 2, NULL, NULL, NULL, '0', '0', 'admin', '2022-11-09 08:28:35', '', NULL);
INSERT INTO `sys_dept` VALUES (204, 100, '0,100', '运维部', 3, NULL, NULL, NULL, '0', '0', 'admin', '2022-11-09 08:28:43', '', NULL);
INSERT INTO `sys_dept` VALUES (205, 100, '0,100', '客服部', 4, NULL, NULL, NULL, '0', '0', 'admin', '2022-11-09 08:28:57', '', NULL);
INSERT INTO `sys_dept` VALUES (206, 100, '0,100', '市场部', 4, NULL, NULL, NULL, '0', '0', 'admin', '2022-11-09 08:29:25', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(11) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 0, '进行中', 'a', 'mh_project_status', NULL, 'default', 'N', '0', 'admin', '2021-09-08 03:39:30', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (101, 1, '运维', 'b', 'mh_project_status', NULL, 'default', 'N', '0', 'admin', '2021-09-08 03:39:46', 'admin', '2021-09-08 03:40:16', NULL);
INSERT INTO `sys_dict_data` VALUES (102, 2, '归档', 'c', 'mh_project_status', NULL, 'default', 'N', '0', 'admin', '2021-09-08 03:40:02', 'admin', '2021-09-08 03:40:26', NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '项目状态', 'mh_project_status', '0', 'admin', '2021-09-08 03:38:10', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (103, '', '', '0', 'admin', '2021-09-10 02:43:20', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_holiday
-- ----------------------------
DROP TABLE IF EXISTS `sys_holiday`;
CREATE TABLE `sys_holiday`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `year` int(11) NULL DEFAULT NULL COMMENT '年份',
  `month` int(11) NULL DEFAULT NULL COMMENT '月份',
  `day` int(11) NULL DEFAULT NULL COMMENT '日',
  `date` date NULL DEFAULT NULL COMMENT '日期',
  `holiday` tinyint(4) NULL DEFAULT NULL COMMENT '是否法定节日期标识,1:是,0:否',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sys_holiday_index_date`(`date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '节假日信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_holiday
-- ----------------------------

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '1', '1', '1', 'admin', '2021-08-22 08:37:02', 'admin', '2021-09-15 10:06:42', '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_job` VALUES (100, '缺报工时定时任务', 'DEFAULT', 'userHourMiss.userHourMissTask', '0 0 1 * * ?', '1', '1', '0', 'admin', '2021-09-15 09:44:48', 'admin', '2021-09-15 10:30:41', '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 656 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `is_frame` int(11) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(11) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2095 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 9, 'system', NULL, 1, 0, 'M', '0', '0', '', 'system', 'admin', '2021-08-22 08:37:02', 'admin', '2021-10-22 15:15:41', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 1, 5, 'monitor', NULL, 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2021-08-22 08:37:02', 'admin', '2023-03-25 23:17:21', '系统监控目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 2071, 1, 'user', 'system/user/index', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2021-08-22 08:37:02', 'admin', '2023-03-25 23:30:51', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 2071, 4, 'role', 'system/role/index', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2021-08-22 08:37:02', 'admin', '2023-03-25 23:31:16', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 2075, 3, 'menu', 'system/menu/index', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2021-08-22 08:37:02', 'admin', '2023-03-25 23:23:54', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 2071, 2, 'dept', 'system/dept/index', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2021-08-22 08:37:02', 'admin', '2023-03-25 23:30:58', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '职位管理', 2071, 3, 'post', 'system/post/index', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2021-08-22 08:37:02', 'admin', '2023-03-25 23:31:08', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 2075, 6, 'dict', 'system/dict/index', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2021-08-22 08:37:02', 'admin', '2023-03-25 23:24:03', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '系统参数', 2075, 7, 'config', 'system/config/index', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2021-08-22 08:37:02', 'admin', '2023-03-25 23:25:21', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2021-08-22 08:37:02', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2021-08-22 08:37:02', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2021-08-22 08:37:02', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2021-08-22 08:37:02', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2021-08-22 08:37:02', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 2, 3, 'swagger', 'tool/swagger/index', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2021-08-22 08:37:02', 'admin', '2022-11-09 08:41:41', '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2021-08-22 08:37:02', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2021-08-22 08:37:02', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 7, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '应用设置', 0, 8, 'manage', NULL, 1, 0, 'M', '0', '0', '', 'logininfor', 'admin', '2021-08-30 06:38:25', 'admin', '2023-09-22 15:49:26', '');
INSERT INTO `sys_menu` VALUES (2001, '项目管理', 2072, 1, 'project', 'system/project', 1, 0, 'C', '0', '0', 'system:project:list', 'example', 'admin', '2021-08-30 06:40:28', 'admin', '2023-03-25 23:10:57', '');
INSERT INTO `sys_menu` VALUES (2002, '我的工时', 0, 1, 'workingHours', NULL, 1, 0, 'M', '0', '0', '', 'time', 'admin', '2021-09-01 02:12:05', 'admin', '2023-03-25 23:15:33', '');
INSERT INTO `sys_menu` VALUES (2003, '我的工时', 2002, 1, 'myWorkingHours', 'workingHours/myWorkingHours/index', 1, 0, 'C', '0', '0', 'mh:hour:list', 'time-range', 'admin', '2021-09-01 02:18:07', 'admin', '2021-10-27 17:27:36', '');
INSERT INTO `sys_menu` VALUES (2004, '填报记录', 2002, 2, 'fillInWorkingHours', 'workingHours/fillInWorkingHours', 1, 0, 'C', '0', '0', 'mh:hour:stat', 'server', 'admin', '2021-09-01 02:22:00', 'admin', '2023-03-29 17:32:10', '');
INSERT INTO `sys_menu` VALUES (2005, '项目明细', 2084, 8, 'projectManagement', 'workingHours/projectManagement/index', 1, 0, 'C', '0', '0', 'system:project:stat:query', 'cascader', 'admin', '2021-09-01 02:24:49', 'admin', '2023-11-01 10:49:36', '');
INSERT INTO `sys_menu` VALUES (2010, '项目设置', 2000, 5, 'projectSettings', 'system/projectSettings/index', 1, 0, 'C', '1', '1', '', 'system', 'admin', '2021-09-10 09:16:33', 'admin', '2023-03-25 23:29:22', '');
INSERT INTO `sys_menu` VALUES (2020, '我参加的项目', 2003, 1, '', NULL, 1, 0, 'F', '0', '0', 'mh:project:user:all', '#', 'admin', '2021-10-27 16:43:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '提交工时', 2003, 1, '', NULL, 1, 0, 'F', '0', '0', 'mh:hour:add', '#', 'admin', '2021-10-27 16:43:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '查看详情', 2003, 2, '', NULL, 1, 0, 'F', '0', '0', 'mh:hour:detail', '#', 'admin', '2021-10-27 16:44:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '详细模式', 2004, 2, '', NULL, 1, 0, 'F', '0', '0', 'mh:hour:stat:detail', '#', 'admin', '2021-10-27 16:45:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '上报记录', 2005, 1, '', NULL, 1, 0, 'F', '0', '0', 'system:project:stat:fill:detail', '#', 'admin', '2021-10-27 16:46:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '工时明细', 2005, 2, '', NULL, 1, 0, 'F', '0', '0', 'system:project:stat:query', '#', 'admin', '2021-10-27 16:47:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, '项目详情', 2005, 3, '', NULL, 1, 0, 'F', '0', '0', 'system:project:query', '#', 'admin', '2021-10-27 16:48:33', 'admin', '2021-10-27 16:49:02', '');
INSERT INTO `sys_menu` VALUES (2028, '项目概要', 2027, 1, '', NULL, 1, 0, 'F', '0', '0', 'system:project:query', '#', 'admin', '2021-10-27 16:49:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, '人员管理', 2027, 2, '', NULL, 1, 0, 'F', '0', '0', 'mh:project:user:list', '#', 'admin', '2021-10-27 16:50:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '工时设置', 2027, 3, '', NULL, 1, 0, 'F', '0', '0', 'system:project:hour:edit', '#', 'admin', '2021-10-27 16:50:47', 'admin', '2021-10-28 11:59:49', '');
INSERT INTO `sys_menu` VALUES (2031, '项目管理', 2027, 4, '', NULL, 1, 0, 'F', '0', '0', 'system:project:status:edit', '#', 'admin', '2021-10-27 16:51:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2032, '编辑', 2028, 1, '', NULL, 1, 0, 'F', '0', '0', 'system:project:edit', '#', 'admin', '2021-10-27 16:52:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '添加项目成员', 2029, 1, '', NULL, 1, 0, 'F', '0', '0', 'mh:project:user:add', '#', 'admin', '2021-10-27 16:52:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '移除项目人员', 2029, 2, '', NULL, 1, 0, 'F', '0', '0', 'mh:project:user:remove', '#', 'admin', '2021-10-27 16:53:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '创建项目', 2001, 0, '', NULL, 1, 0, 'F', '0', '0', 'system:project:add', '#', 'admin', '2021-10-27 16:55:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2037, '项目设置', 2001, 1, '', NULL, 1, 0, 'F', '0', '0', 'system:project:query', '#', 'admin', '2021-10-27 17:02:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2038, '归档', 2001, 2, '', NULL, 1, 0, 'F', '0', '0', 'system:project:status:edit', '#', 'admin', '2021-10-27 17:03:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2039, '删除', 2001, 3, '', NULL, 1, 0, 'F', '0', '0', 'system:project:remove', '#', 'admin', '2021-10-27 17:03:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2040, '项目概要', 2037, 1, '', NULL, 1, 0, 'F', '0', '0', 'system:project:query', '#', 'admin', '2021-10-27 17:04:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2041, '人员管理', 2037, 2, '', NULL, 1, 0, 'F', '0', '0', 'mh:project:user:list', '#', 'admin', '2021-10-27 17:04:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2042, '工时设置', 2037, 3, '', NULL, 1, 0, 'F', '0', '0', 'system:project:hour:edit', '#', 'admin', '2021-10-27 17:05:15', 'admin', '2021-10-28 12:00:21', '');
INSERT INTO `sys_menu` VALUES (2043, '项目管理', 2037, 4, '', NULL, 1, 0, 'F', '0', '0', 'system:project:status:edit', '#', 'admin', '2021-10-27 17:05:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2044, '编辑', 2040, 1, '', NULL, 1, 0, 'F', '0', '0', 'system:project:edit', '#', 'admin', '2021-10-27 17:06:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2045, '添加项目成员', 2041, 1, '', NULL, 1, 0, 'F', '0', '0', 'mh:project:user:add', '#', 'admin', '2021-10-27 17:06:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2046, '移除项目成员', 2041, 2, '', NULL, 1, 0, 'F', '0', '0', 'mh:project:user:remove', '#', 'admin', '2021-10-27 17:07:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2057, '首页', 0, 0, 'index', NULL, 1, 0, 'M', '0', '0', '', 'dashboard', 'admin', '2021-11-04 14:43:55', 'admin', '2021-11-04 15:06:45', '');
INSERT INTO `sys_menu` VALUES (2058, '首页', 2057, 0, '/', 'index', 1, 0, 'C', '0', '0', '', 'dashboard', 'admin', '2021-11-04 14:44:54', 'admin', '2021-11-04 15:07:02', '');
INSERT INTO `sys_menu` VALUES (2059, '工时记录', 2073, 4, 'overallStatistics', 'workingHours/overallStatistics', 1, 0, 'C', '0', '0', 'system:project:overall:detail', 'server', 'admin', '2021-11-10 11:44:27', 'admin', '2023-09-22 19:27:23', '');
INSERT INTO `sys_menu` VALUES (2060, '工时设置', 2078, 6, 'appsSett', 'manage/appsSett', 1, 0, 'C', '0', '0', 'system:app:config:edit', 'online', 'admin', '2021-11-03 11:54:49', 'admin', '2023-11-01 11:19:37', '');
INSERT INTO `sys_menu` VALUES (2061, '系统名称', 2000, 7, 'setEditor', 'manage/setEditor', 1, 0, 'C', '0', '0', 'system:info:config:edit', 'system', 'admin', '2021-11-03 11:55:46', 'admin', '2023-03-25 23:28:44', '');
INSERT INTO `sys_menu` VALUES (2062, '成本设置', 2078, 5, 'costOf', 'manage/costOf', 1, 0, 'C', '0', '0', 'mh:cost:set', 'form', 'admin', '2021-11-04 13:43:30', 'admin', '2023-03-29 17:28:05', '');
INSERT INTO `sys_menu` VALUES (2063, '成本统计', 2005, 3, '', NULL, 1, 0, 'F', '0', '0', 'mh:cost:query', '#', 'admin', '2021-11-11 11:49:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2064, '填报记录', 2003, 3, '', NULL, 1, 0, 'F', '0', '0', 'mh:hour:stat', '#', 'admin', '2022-11-09 08:00:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2069, '项目日历', 2084, 5, 'projectDai', 'workingHours/projectDai', 1, 0, 'C', '0', '0', 'system:project:daily', 'date', 'LSM-admin', '2021-12-14 14:38:36', 'admin', '2023-09-22 15:50:57', '');
INSERT INTO `sys_menu` VALUES (2071, '人员管理', 2000, 1, 'org', NULL, 1, 0, 'M', '0', '0', '', 'peoples', 'admin', '2023-03-25 23:07:42', 'admin', '2023-03-29 17:27:49', '');
INSERT INTO `sys_menu` VALUES (2072, '项目管理', 2084, 9, 'pm', NULL, 1, 0, 'M', '0', '0', '', 'component', 'admin', '2023-03-25 23:10:19', 'admin', '2023-11-01 10:49:42', '');
INSERT INTO `sys_menu` VALUES (2073, '工时统计', 0, 6, 'stat', NULL, 1, 0, 'M', '0', '0', '', 'druid', 'admin', '2023-03-25 23:15:17', 'admin', '2023-09-22 15:50:20', '');
INSERT INTO `sys_menu` VALUES (2075, '系统参数', 1, 8, 'sys-param', NULL, 1, 0, 'M', '0', '0', NULL, 'validCode', 'admin', '2023-03-25 23:23:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2077, '工作类型', 2078, 8, 'worktype', 'manage/worktype', 1, 0, 'C', '0', '0', '', 'redis', 'admin', '2023-03-26 17:42:26', 'test1', '2023-09-21 22:09:12', '');
INSERT INTO `sys_menu` VALUES (2078, '业务设置', 2000, 2, 'biz', NULL, 1, 0, 'M', '0', '0', '', 'select', 'admin', '2023-03-29 17:27:42', 'admin', '2023-03-29 17:28:49', '');
INSERT INTO `sys_menu` VALUES (2079, '节假日', 2078, 9, 'holiday', 'manage/holiday', 1, 1, 'C', '0', '0', '', 'date', 'admin', '2023-07-29 18:04:16', 'admin', '2023-07-30 16:39:24', '');
INSERT INTO `sys_menu` VALUES (2080, '项目月报', 2084, 2, 'projectMon', 'workingHours/projectMon', 1, 0, 'C', '0', '0', '', 'tab', 'test1', '2023-08-29 13:18:41', 'admin', '2023-09-22 15:50:52', '');
INSERT INTO `sys_menu` VALUES (2081, '我的项目', 2002, 3, 'myProject', 'workingHours/myProject', 1, 0, 'C', '0', '0', NULL, 'table', 'test1', '2023-09-01 15:52:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2082, '项目日报', 2084, 1, 'projectDay', 'workingHours/projectDay', 1, 0, 'C', '0', '0', '', 'documentation', 'test1', '2023-09-01 18:11:12', 'admin', '2023-09-22 15:50:46', '');
INSERT INTO `sys_menu` VALUES (2083, '我的统计', 2002, 4, 'myRecord', 'workingHours/myRecord', 1, 0, 'C', '0', '0', '', 'date-range', 'test1', '2023-09-20 11:32:25', 'admin', '2023-09-20 11:35:47', '');
INSERT INTO `sys_menu` VALUES (2084, '项目管理', 0, 5, 'projectStat', NULL, 1, 0, 'M', '0', '0', '', 'build', 'test1', '2023-09-22 15:45:24', 'admin', '2023-11-01 10:49:02', '');
INSERT INTO `sys_menu` VALUES (2085, '填报率统计', 2073, 1, 'rate', 'dataStat/rate', 1, 0, 'C', '0', '0', NULL, 'skill', 'admin', '2023-09-23 23:23:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2086, '工时审核', 2073, 3, 'review', 'dataStat/review', 1, 0, 'C', '0', '0', 'mh:review', 'validCode', 'admin', '2023-10-29 21:38:16', 'admin', '2023-10-31 10:44:02', '');
INSERT INTO `sys_menu` VALUES (2087, '审核', 2086, 1, 'mh:review:set', NULL, 1, 0, 'F', '0', '0', 'mh:review:set', '#', 'test1', '2023-11-01 21:42:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2088, '编辑', 2060, 1, '', NULL, 1, 0, 'F', '0', '0', 'system:app:set:edit', '#', 'test1', '2023-11-01 21:43:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2089, '编辑', 2061, 1, '', NULL, 1, 0, 'F', '0', '0', 'system:info:config:editor', '#', 'test1', '2023-11-01 21:43:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2090, '官方网站', 0, 9, 'website', NULL, 1, 0, 'M', '0', '0', '', 'international', 'test1', '2023-11-01 22:40:10', 'admin', '2023-11-01 22:46:05', '');
INSERT INTO `sys_menu` VALUES (2091, '更新', 2090, 3, 'https://doc.wuyusoft.com/cost/release.html', NULL, 1, 0, 'C', '0', '0', '', 'component', 'admin', '2023-11-01 22:44:52', 'admin', '2023-11-01 22:49:05', '');
INSERT INTO `sys_menu` VALUES (2092, '官网', 2090, 1, 'https://www.wuyusoft.com/', NULL, 0, 0, 'M', '0', '0', '', 'international', 'admin', '2023-11-01 22:46:26', 'admin', '2023-11-01 22:48:16', '');
INSERT INTO `sys_menu` VALUES (2093, '文档', 2090, 2, 'https://doc.wuyusoft.com/cost/', NULL, 1, 0, 'M', '0', '0', '', 'documentation', 'admin', '2023-11-01 22:46:54', 'admin', '2023-11-01 22:49:09', '');
INSERT INTO `sys_menu` VALUES (2094, '捐赠', 2090, 4, 'https://doc.wuyusoft.com/cost/donate.html', NULL, 1, 0, 'M', '0', '0', NULL, 'people', 'admin', '2023-11-01 22:47:45', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(11) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(11) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(11) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1, '操作日志', 9, 'com.oaker.web.controller.monitor.SysOperlogController.clean()', 'DELETE', 1, 'admin', NULL, '/monitor/operlog/clean', '172.23.0.5', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-09-25 23:43:42');
INSERT INTO `sys_oper_log` VALUES (2, '登录日志', 9, 'com.oaker.web.controller.monitor.SysLogininforController.clean()', 'DELETE', 1, 'admin', NULL, '/monitor/logininfor/clean', '172.23.0.5', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-09-25 23:43:45');
INSERT INTO `sys_oper_log` VALUES (3, '用户工时', 1, 'com.oaker.web.controller.mhour.MhUserHourController.create()', 'POST', 1, 'zhangsan', NULL, '/mh/hour/create', '127.0.0.1', '内网IP', '{\"date\":\"2023-12-26\",\"projectHours\":[{\"hour\":2,\"workTypeHourList\":[{\"workTypeId\":2,\"hour\":2}],\"projectId\":37}]}', '{\"msg\":\"填报成功\",\"code\":200,\"data\":15}', 0, NULL, '2023-12-26 15:52:13');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(11) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'system', '系统管理员', 1, '0', 'admin', '2021-08-22 08:37:02', '', NULL, '');
INSERT INTO `sys_post` VALUES (13, 'p1', '初级工程师', 0, '0', 'admin', '2022-11-09 08:31:28', 'admin', '2022-11-09 08:33:02', NULL);
INSERT INTO `sys_post` VALUES (14, 'p2', '中级工程师', 0, '0', 'admin', '2022-11-09 08:32:32', 'admin', '2022-11-09 08:33:14', NULL);
INSERT INTO `sys_post` VALUES (15, 'p3', '高级工程师', 0, '0', 'admin', '2022-11-09 08:32:38', 'admin', '2022-11-09 08:33:21', NULL);
INSERT INTO `sys_post` VALUES (16, 'm1', '中级管理', 0, '0', 'admin', '2022-11-09 08:33:39', '', NULL, NULL);
INSERT INTO `sys_post` VALUES (17, 'm2', '高级管理', 0, '0', 'admin', '2022-11-09 08:33:47', '', NULL, NULL);
INSERT INTO `sys_post` VALUES (18, 'm3', '公司高层', 0, '0', 'admin', '2022-11-09 08:33:56', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_project
-- ----------------------------
DROP TABLE IF EXISTS `sys_project`;
CREATE TABLE `sys_project`  (
  `project_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '项目id',
  `project_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目名称',
  `project_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '项目编码',
  `project_manager` bigint(20) NOT NULL COMMENT '项目经理id',
  `enable` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 启用  0 暂停',
  `project_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'a' COMMENT '项目状态：a 进行中，b运维，c 归档',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除：0未删除  1 已删除',
  `start_date` date NOT NULL COMMENT '开始日期',
  `end_date` date NULL DEFAULT NULL COMMENT '结束日期',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目简介',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(54) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_project
-- ----------------------------
INSERT INTO `sys_project` VALUES (37, '测试项目', 'shenhai1', 127, 1, 'a', 0, '2023-03-25', NULL, '', 'admin', '2023-03-25 17:32:31', NULL, NULL);

-- ----------------------------
-- Table structure for sys_project_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_project_user`;
CREATE TABLE `sys_project_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_id` bigint(20) NOT NULL COMMENT '项目id',
  `user_id` bigint(20) NOT NULL COMMENT '人员id',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态：1 正常  0 移除',
  `remove_time` datetime NULL DEFAULT NULL COMMENT '移除日期',
  `everyday` tinyint(4) NOT NULL DEFAULT 1 COMMENT '是否需要每日上报工时 0 不需要  1 需要',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `join_with_project` tinyint(4) NULL DEFAULT NULL COMMENT '加入时间同项目开始时间，1:是,0:否',
  `join_time` datetime NULL DEFAULT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `pri_pro_user`(`project_id`, `user_id`) USING BTREE COMMENT '项目id和用户id索引'
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目用户关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_project_user
-- ----------------------------
INSERT INTO `sys_project_user` VALUES (50, 37, 127, 1, NULL, 1, 1, '2023-03-25 17:32:58', NULL, NULL, 0, '2023-03-25 17:32:58');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(11) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 112 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2021-08-22 08:37:02', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (108, '项目经理', 'pm', 0, '1', 1, 1, '0', '0', 'admin', '2022-11-09 08:30:18', 'admin', '2023-09-25 23:38:13', NULL);
INSERT INTO `sys_role` VALUES (109, '产品经理', 'pmd', 0, '1', 1, 1, '0', '0', 'admin', '2022-11-09 08:30:37', 'admin', '2023-09-25 23:37:33', NULL);
INSERT INTO `sys_role` VALUES (110, '开发工程师', 'de', 0, '1', 1, 1, '0', '0', 'admin', '2022-11-09 08:31:08', 'admin', '2023-09-25 23:38:02', NULL);
INSERT INTO `sys_role` VALUES (111, '项目总监', 'pd', 0, '1', 1, 1, '0', '0', 'admin', '2022-11-09 08:32:16', 'admin', '2023-09-25 23:37:50', NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (108, 2002);
INSERT INTO `sys_role_menu` VALUES (108, 2003);
INSERT INTO `sys_role_menu` VALUES (108, 2004);
INSERT INTO `sys_role_menu` VALUES (108, 2005);
INSERT INTO `sys_role_menu` VALUES (108, 2020);
INSERT INTO `sys_role_menu` VALUES (108, 2021);
INSERT INTO `sys_role_menu` VALUES (108, 2022);
INSERT INTO `sys_role_menu` VALUES (108, 2024);
INSERT INTO `sys_role_menu` VALUES (108, 2025);
INSERT INTO `sys_role_menu` VALUES (108, 2026);
INSERT INTO `sys_role_menu` VALUES (108, 2027);
INSERT INTO `sys_role_menu` VALUES (108, 2028);
INSERT INTO `sys_role_menu` VALUES (108, 2029);
INSERT INTO `sys_role_menu` VALUES (108, 2030);
INSERT INTO `sys_role_menu` VALUES (108, 2031);
INSERT INTO `sys_role_menu` VALUES (108, 2032);
INSERT INTO `sys_role_menu` VALUES (108, 2033);
INSERT INTO `sys_role_menu` VALUES (108, 2034);
INSERT INTO `sys_role_menu` VALUES (108, 2057);
INSERT INTO `sys_role_menu` VALUES (108, 2058);
INSERT INTO `sys_role_menu` VALUES (108, 2059);
INSERT INTO `sys_role_menu` VALUES (108, 2063);
INSERT INTO `sys_role_menu` VALUES (108, 2064);
INSERT INTO `sys_role_menu` VALUES (108, 2069);
INSERT INTO `sys_role_menu` VALUES (108, 2073);
INSERT INTO `sys_role_menu` VALUES (108, 2080);
INSERT INTO `sys_role_menu` VALUES (108, 2081);
INSERT INTO `sys_role_menu` VALUES (108, 2082);
INSERT INTO `sys_role_menu` VALUES (108, 2084);
INSERT INTO `sys_role_menu` VALUES (108, 2085);
INSERT INTO `sys_role_menu` VALUES (108, 2090);
INSERT INTO `sys_role_menu` VALUES (108, 2091);
INSERT INTO `sys_role_menu` VALUES (108, 2092);
INSERT INTO `sys_role_menu` VALUES (108, 2093);
INSERT INTO `sys_role_menu` VALUES (108, 2094);
INSERT INTO `sys_role_menu` VALUES (109, 2002);
INSERT INTO `sys_role_menu` VALUES (109, 2003);
INSERT INTO `sys_role_menu` VALUES (109, 2004);
INSERT INTO `sys_role_menu` VALUES (109, 2005);
INSERT INTO `sys_role_menu` VALUES (109, 2020);
INSERT INTO `sys_role_menu` VALUES (109, 2021);
INSERT INTO `sys_role_menu` VALUES (109, 2022);
INSERT INTO `sys_role_menu` VALUES (109, 2024);
INSERT INTO `sys_role_menu` VALUES (109, 2025);
INSERT INTO `sys_role_menu` VALUES (109, 2026);
INSERT INTO `sys_role_menu` VALUES (109, 2027);
INSERT INTO `sys_role_menu` VALUES (109, 2028);
INSERT INTO `sys_role_menu` VALUES (109, 2029);
INSERT INTO `sys_role_menu` VALUES (109, 2030);
INSERT INTO `sys_role_menu` VALUES (109, 2031);
INSERT INTO `sys_role_menu` VALUES (109, 2032);
INSERT INTO `sys_role_menu` VALUES (109, 2033);
INSERT INTO `sys_role_menu` VALUES (109, 2034);
INSERT INTO `sys_role_menu` VALUES (109, 2057);
INSERT INTO `sys_role_menu` VALUES (109, 2058);
INSERT INTO `sys_role_menu` VALUES (109, 2059);
INSERT INTO `sys_role_menu` VALUES (109, 2063);
INSERT INTO `sys_role_menu` VALUES (109, 2064);
INSERT INTO `sys_role_menu` VALUES (109, 2069);
INSERT INTO `sys_role_menu` VALUES (109, 2073);
INSERT INTO `sys_role_menu` VALUES (109, 2080);
INSERT INTO `sys_role_menu` VALUES (109, 2081);
INSERT INTO `sys_role_menu` VALUES (109, 2082);
INSERT INTO `sys_role_menu` VALUES (109, 2083);
INSERT INTO `sys_role_menu` VALUES (109, 2084);
INSERT INTO `sys_role_menu` VALUES (109, 2085);
INSERT INTO `sys_role_menu` VALUES (109, 2086);
INSERT INTO `sys_role_menu` VALUES (109, 2090);
INSERT INTO `sys_role_menu` VALUES (109, 2091);
INSERT INTO `sys_role_menu` VALUES (109, 2092);
INSERT INTO `sys_role_menu` VALUES (109, 2093);
INSERT INTO `sys_role_menu` VALUES (109, 2094);
INSERT INTO `sys_role_menu` VALUES (110, 2002);
INSERT INTO `sys_role_menu` VALUES (110, 2003);
INSERT INTO `sys_role_menu` VALUES (110, 2004);
INSERT INTO `sys_role_menu` VALUES (110, 2005);
INSERT INTO `sys_role_menu` VALUES (110, 2020);
INSERT INTO `sys_role_menu` VALUES (110, 2021);
INSERT INTO `sys_role_menu` VALUES (110, 2022);
INSERT INTO `sys_role_menu` VALUES (110, 2024);
INSERT INTO `sys_role_menu` VALUES (110, 2025);
INSERT INTO `sys_role_menu` VALUES (110, 2026);
INSERT INTO `sys_role_menu` VALUES (110, 2027);
INSERT INTO `sys_role_menu` VALUES (110, 2028);
INSERT INTO `sys_role_menu` VALUES (110, 2029);
INSERT INTO `sys_role_menu` VALUES (110, 2030);
INSERT INTO `sys_role_menu` VALUES (110, 2031);
INSERT INTO `sys_role_menu` VALUES (110, 2032);
INSERT INTO `sys_role_menu` VALUES (110, 2033);
INSERT INTO `sys_role_menu` VALUES (110, 2034);
INSERT INTO `sys_role_menu` VALUES (110, 2057);
INSERT INTO `sys_role_menu` VALUES (110, 2058);
INSERT INTO `sys_role_menu` VALUES (110, 2059);
INSERT INTO `sys_role_menu` VALUES (110, 2063);
INSERT INTO `sys_role_menu` VALUES (110, 2064);
INSERT INTO `sys_role_menu` VALUES (110, 2069);
INSERT INTO `sys_role_menu` VALUES (110, 2073);
INSERT INTO `sys_role_menu` VALUES (110, 2080);
INSERT INTO `sys_role_menu` VALUES (110, 2081);
INSERT INTO `sys_role_menu` VALUES (110, 2082);
INSERT INTO `sys_role_menu` VALUES (110, 2083);
INSERT INTO `sys_role_menu` VALUES (110, 2084);
INSERT INTO `sys_role_menu` VALUES (110, 2085);
INSERT INTO `sys_role_menu` VALUES (110, 2090);
INSERT INTO `sys_role_menu` VALUES (110, 2091);
INSERT INTO `sys_role_menu` VALUES (110, 2092);
INSERT INTO `sys_role_menu` VALUES (110, 2093);
INSERT INTO `sys_role_menu` VALUES (110, 2094);
INSERT INTO `sys_role_menu` VALUES (111, 1);
INSERT INTO `sys_role_menu` VALUES (111, 100);
INSERT INTO `sys_role_menu` VALUES (111, 101);
INSERT INTO `sys_role_menu` VALUES (111, 103);
INSERT INTO `sys_role_menu` VALUES (111, 104);
INSERT INTO `sys_role_menu` VALUES (111, 1001);
INSERT INTO `sys_role_menu` VALUES (111, 1002);
INSERT INTO `sys_role_menu` VALUES (111, 1003);
INSERT INTO `sys_role_menu` VALUES (111, 1004);
INSERT INTO `sys_role_menu` VALUES (111, 1005);
INSERT INTO `sys_role_menu` VALUES (111, 1006);
INSERT INTO `sys_role_menu` VALUES (111, 1007);
INSERT INTO `sys_role_menu` VALUES (111, 1008);
INSERT INTO `sys_role_menu` VALUES (111, 1009);
INSERT INTO `sys_role_menu` VALUES (111, 1010);
INSERT INTO `sys_role_menu` VALUES (111, 1011);
INSERT INTO `sys_role_menu` VALUES (111, 1012);
INSERT INTO `sys_role_menu` VALUES (111, 1017);
INSERT INTO `sys_role_menu` VALUES (111, 1018);
INSERT INTO `sys_role_menu` VALUES (111, 1019);
INSERT INTO `sys_role_menu` VALUES (111, 1020);
INSERT INTO `sys_role_menu` VALUES (111, 1021);
INSERT INTO `sys_role_menu` VALUES (111, 1022);
INSERT INTO `sys_role_menu` VALUES (111, 1023);
INSERT INTO `sys_role_menu` VALUES (111, 1024);
INSERT INTO `sys_role_menu` VALUES (111, 1025);
INSERT INTO `sys_role_menu` VALUES (111, 2000);
INSERT INTO `sys_role_menu` VALUES (111, 2001);
INSERT INTO `sys_role_menu` VALUES (111, 2002);
INSERT INTO `sys_role_menu` VALUES (111, 2003);
INSERT INTO `sys_role_menu` VALUES (111, 2004);
INSERT INTO `sys_role_menu` VALUES (111, 2005);
INSERT INTO `sys_role_menu` VALUES (111, 2010);
INSERT INTO `sys_role_menu` VALUES (111, 2020);
INSERT INTO `sys_role_menu` VALUES (111, 2021);
INSERT INTO `sys_role_menu` VALUES (111, 2022);
INSERT INTO `sys_role_menu` VALUES (111, 2024);
INSERT INTO `sys_role_menu` VALUES (111, 2025);
INSERT INTO `sys_role_menu` VALUES (111, 2026);
INSERT INTO `sys_role_menu` VALUES (111, 2027);
INSERT INTO `sys_role_menu` VALUES (111, 2028);
INSERT INTO `sys_role_menu` VALUES (111, 2029);
INSERT INTO `sys_role_menu` VALUES (111, 2030);
INSERT INTO `sys_role_menu` VALUES (111, 2031);
INSERT INTO `sys_role_menu` VALUES (111, 2032);
INSERT INTO `sys_role_menu` VALUES (111, 2033);
INSERT INTO `sys_role_menu` VALUES (111, 2034);
INSERT INTO `sys_role_menu` VALUES (111, 2036);
INSERT INTO `sys_role_menu` VALUES (111, 2037);
INSERT INTO `sys_role_menu` VALUES (111, 2038);
INSERT INTO `sys_role_menu` VALUES (111, 2039);
INSERT INTO `sys_role_menu` VALUES (111, 2040);
INSERT INTO `sys_role_menu` VALUES (111, 2041);
INSERT INTO `sys_role_menu` VALUES (111, 2042);
INSERT INTO `sys_role_menu` VALUES (111, 2043);
INSERT INTO `sys_role_menu` VALUES (111, 2044);
INSERT INTO `sys_role_menu` VALUES (111, 2045);
INSERT INTO `sys_role_menu` VALUES (111, 2046);
INSERT INTO `sys_role_menu` VALUES (111, 2057);
INSERT INTO `sys_role_menu` VALUES (111, 2058);
INSERT INTO `sys_role_menu` VALUES (111, 2059);
INSERT INTO `sys_role_menu` VALUES (111, 2060);
INSERT INTO `sys_role_menu` VALUES (111, 2061);
INSERT INTO `sys_role_menu` VALUES (111, 2062);
INSERT INTO `sys_role_menu` VALUES (111, 2063);
INSERT INTO `sys_role_menu` VALUES (111, 2064);
INSERT INTO `sys_role_menu` VALUES (111, 2069);
INSERT INTO `sys_role_menu` VALUES (111, 2071);
INSERT INTO `sys_role_menu` VALUES (111, 2072);
INSERT INTO `sys_role_menu` VALUES (111, 2073);
INSERT INTO `sys_role_menu` VALUES (111, 2074);
INSERT INTO `sys_role_menu` VALUES (111, 2078);
INSERT INTO `sys_role_menu` VALUES (111, 2080);
INSERT INTO `sys_role_menu` VALUES (112, 1);
INSERT INTO `sys_role_menu` VALUES (112, 2);
INSERT INTO `sys_role_menu` VALUES (112, 100);
INSERT INTO `sys_role_menu` VALUES (112, 101);
INSERT INTO `sys_role_menu` VALUES (112, 102);
INSERT INTO `sys_role_menu` VALUES (112, 103);
INSERT INTO `sys_role_menu` VALUES (112, 104);
INSERT INTO `sys_role_menu` VALUES (112, 105);
INSERT INTO `sys_role_menu` VALUES (112, 106);
INSERT INTO `sys_role_menu` VALUES (112, 108);
INSERT INTO `sys_role_menu` VALUES (112, 109);
INSERT INTO `sys_role_menu` VALUES (112, 110);
INSERT INTO `sys_role_menu` VALUES (112, 112);
INSERT INTO `sys_role_menu` VALUES (112, 113);
INSERT INTO `sys_role_menu` VALUES (112, 116);
INSERT INTO `sys_role_menu` VALUES (112, 500);
INSERT INTO `sys_role_menu` VALUES (112, 501);
INSERT INTO `sys_role_menu` VALUES (112, 1001);
INSERT INTO `sys_role_menu` VALUES (112, 1002);
INSERT INTO `sys_role_menu` VALUES (112, 1003);
INSERT INTO `sys_role_menu` VALUES (112, 1004);
INSERT INTO `sys_role_menu` VALUES (112, 1005);
INSERT INTO `sys_role_menu` VALUES (112, 1006);
INSERT INTO `sys_role_menu` VALUES (112, 1007);
INSERT INTO `sys_role_menu` VALUES (112, 1008);
INSERT INTO `sys_role_menu` VALUES (112, 1009);
INSERT INTO `sys_role_menu` VALUES (112, 1010);
INSERT INTO `sys_role_menu` VALUES (112, 1011);
INSERT INTO `sys_role_menu` VALUES (112, 1012);
INSERT INTO `sys_role_menu` VALUES (112, 1013);
INSERT INTO `sys_role_menu` VALUES (112, 1014);
INSERT INTO `sys_role_menu` VALUES (112, 1015);
INSERT INTO `sys_role_menu` VALUES (112, 1016);
INSERT INTO `sys_role_menu` VALUES (112, 1017);
INSERT INTO `sys_role_menu` VALUES (112, 1018);
INSERT INTO `sys_role_menu` VALUES (112, 1019);
INSERT INTO `sys_role_menu` VALUES (112, 1020);
INSERT INTO `sys_role_menu` VALUES (112, 1021);
INSERT INTO `sys_role_menu` VALUES (112, 1022);
INSERT INTO `sys_role_menu` VALUES (112, 1023);
INSERT INTO `sys_role_menu` VALUES (112, 1024);
INSERT INTO `sys_role_menu` VALUES (112, 1025);
INSERT INTO `sys_role_menu` VALUES (112, 1026);
INSERT INTO `sys_role_menu` VALUES (112, 1027);
INSERT INTO `sys_role_menu` VALUES (112, 1028);
INSERT INTO `sys_role_menu` VALUES (112, 1029);
INSERT INTO `sys_role_menu` VALUES (112, 1030);
INSERT INTO `sys_role_menu` VALUES (112, 1031);
INSERT INTO `sys_role_menu` VALUES (112, 1032);
INSERT INTO `sys_role_menu` VALUES (112, 1033);
INSERT INTO `sys_role_menu` VALUES (112, 1034);
INSERT INTO `sys_role_menu` VALUES (112, 1035);
INSERT INTO `sys_role_menu` VALUES (112, 1040);
INSERT INTO `sys_role_menu` VALUES (112, 1041);
INSERT INTO `sys_role_menu` VALUES (112, 1042);
INSERT INTO `sys_role_menu` VALUES (112, 1043);
INSERT INTO `sys_role_menu` VALUES (112, 1044);
INSERT INTO `sys_role_menu` VALUES (112, 1045);
INSERT INTO `sys_role_menu` VALUES (112, 1046);
INSERT INTO `sys_role_menu` VALUES (112, 1047);
INSERT INTO `sys_role_menu` VALUES (112, 1048);
INSERT INTO `sys_role_menu` VALUES (112, 1049);
INSERT INTO `sys_role_menu` VALUES (112, 1050);
INSERT INTO `sys_role_menu` VALUES (112, 1051);
INSERT INTO `sys_role_menu` VALUES (112, 1052);
INSERT INTO `sys_role_menu` VALUES (112, 1053);
INSERT INTO `sys_role_menu` VALUES (112, 1054);
INSERT INTO `sys_role_menu` VALUES (112, 2000);
INSERT INTO `sys_role_menu` VALUES (112, 2001);
INSERT INTO `sys_role_menu` VALUES (112, 2002);
INSERT INTO `sys_role_menu` VALUES (112, 2003);
INSERT INTO `sys_role_menu` VALUES (112, 2004);
INSERT INTO `sys_role_menu` VALUES (112, 2005);
INSERT INTO `sys_role_menu` VALUES (112, 2010);
INSERT INTO `sys_role_menu` VALUES (112, 2020);
INSERT INTO `sys_role_menu` VALUES (112, 2021);
INSERT INTO `sys_role_menu` VALUES (112, 2022);
INSERT INTO `sys_role_menu` VALUES (112, 2024);
INSERT INTO `sys_role_menu` VALUES (112, 2025);
INSERT INTO `sys_role_menu` VALUES (112, 2026);
INSERT INTO `sys_role_menu` VALUES (112, 2027);
INSERT INTO `sys_role_menu` VALUES (112, 2028);
INSERT INTO `sys_role_menu` VALUES (112, 2029);
INSERT INTO `sys_role_menu` VALUES (112, 2030);
INSERT INTO `sys_role_menu` VALUES (112, 2031);
INSERT INTO `sys_role_menu` VALUES (112, 2032);
INSERT INTO `sys_role_menu` VALUES (112, 2033);
INSERT INTO `sys_role_menu` VALUES (112, 2034);
INSERT INTO `sys_role_menu` VALUES (112, 2036);
INSERT INTO `sys_role_menu` VALUES (112, 2037);
INSERT INTO `sys_role_menu` VALUES (112, 2038);
INSERT INTO `sys_role_menu` VALUES (112, 2039);
INSERT INTO `sys_role_menu` VALUES (112, 2040);
INSERT INTO `sys_role_menu` VALUES (112, 2041);
INSERT INTO `sys_role_menu` VALUES (112, 2042);
INSERT INTO `sys_role_menu` VALUES (112, 2043);
INSERT INTO `sys_role_menu` VALUES (112, 2044);
INSERT INTO `sys_role_menu` VALUES (112, 2045);
INSERT INTO `sys_role_menu` VALUES (112, 2046);
INSERT INTO `sys_role_menu` VALUES (112, 2057);
INSERT INTO `sys_role_menu` VALUES (112, 2058);
INSERT INTO `sys_role_menu` VALUES (112, 2059);
INSERT INTO `sys_role_menu` VALUES (112, 2060);
INSERT INTO `sys_role_menu` VALUES (112, 2061);
INSERT INTO `sys_role_menu` VALUES (112, 2062);
INSERT INTO `sys_role_menu` VALUES (112, 2063);
INSERT INTO `sys_role_menu` VALUES (112, 2064);
INSERT INTO `sys_role_menu` VALUES (112, 2069);
INSERT INTO `sys_role_menu` VALUES (112, 2071);
INSERT INTO `sys_role_menu` VALUES (112, 2072);
INSERT INTO `sys_role_menu` VALUES (112, 2073);
INSERT INTO `sys_role_menu` VALUES (112, 2074);
INSERT INTO `sys_role_menu` VALUES (112, 2075);
INSERT INTO `sys_role_menu` VALUES (112, 2077);
INSERT INTO `sys_role_menu` VALUES (112, 2078);
INSERT INTO `sys_role_menu` VALUES (112, 2079);
INSERT INTO `sys_role_menu` VALUES (112, 2080);
INSERT INTO `sys_role_menu` VALUES (112, 2081);
INSERT INTO `sys_role_menu` VALUES (112, 2082);
INSERT INTO `sys_role_menu` VALUES (112, 2083);
INSERT INTO `sys_role_menu` VALUES (112, 2084);
INSERT INTO `sys_role_menu` VALUES (112, 2085);
INSERT INTO `sys_role_menu` VALUES (113, 1);
INSERT INTO `sys_role_menu` VALUES (113, 2);
INSERT INTO `sys_role_menu` VALUES (113, 100);
INSERT INTO `sys_role_menu` VALUES (113, 101);
INSERT INTO `sys_role_menu` VALUES (113, 102);
INSERT INTO `sys_role_menu` VALUES (113, 103);
INSERT INTO `sys_role_menu` VALUES (113, 104);
INSERT INTO `sys_role_menu` VALUES (113, 105);
INSERT INTO `sys_role_menu` VALUES (113, 106);
INSERT INTO `sys_role_menu` VALUES (113, 108);
INSERT INTO `sys_role_menu` VALUES (113, 109);
INSERT INTO `sys_role_menu` VALUES (113, 110);
INSERT INTO `sys_role_menu` VALUES (113, 112);
INSERT INTO `sys_role_menu` VALUES (113, 113);
INSERT INTO `sys_role_menu` VALUES (113, 116);
INSERT INTO `sys_role_menu` VALUES (113, 500);
INSERT INTO `sys_role_menu` VALUES (113, 501);
INSERT INTO `sys_role_menu` VALUES (113, 1001);
INSERT INTO `sys_role_menu` VALUES (113, 1002);
INSERT INTO `sys_role_menu` VALUES (113, 1003);
INSERT INTO `sys_role_menu` VALUES (113, 1004);
INSERT INTO `sys_role_menu` VALUES (113, 1005);
INSERT INTO `sys_role_menu` VALUES (113, 1006);
INSERT INTO `sys_role_menu` VALUES (113, 1007);
INSERT INTO `sys_role_menu` VALUES (113, 1008);
INSERT INTO `sys_role_menu` VALUES (113, 1009);
INSERT INTO `sys_role_menu` VALUES (113, 1010);
INSERT INTO `sys_role_menu` VALUES (113, 1011);
INSERT INTO `sys_role_menu` VALUES (113, 1012);
INSERT INTO `sys_role_menu` VALUES (113, 1013);
INSERT INTO `sys_role_menu` VALUES (113, 1014);
INSERT INTO `sys_role_menu` VALUES (113, 1015);
INSERT INTO `sys_role_menu` VALUES (113, 1016);
INSERT INTO `sys_role_menu` VALUES (113, 1017);
INSERT INTO `sys_role_menu` VALUES (113, 1018);
INSERT INTO `sys_role_menu` VALUES (113, 1019);
INSERT INTO `sys_role_menu` VALUES (113, 1020);
INSERT INTO `sys_role_menu` VALUES (113, 1021);
INSERT INTO `sys_role_menu` VALUES (113, 1022);
INSERT INTO `sys_role_menu` VALUES (113, 1023);
INSERT INTO `sys_role_menu` VALUES (113, 1024);
INSERT INTO `sys_role_menu` VALUES (113, 1025);
INSERT INTO `sys_role_menu` VALUES (113, 1026);
INSERT INTO `sys_role_menu` VALUES (113, 1027);
INSERT INTO `sys_role_menu` VALUES (113, 1028);
INSERT INTO `sys_role_menu` VALUES (113, 1029);
INSERT INTO `sys_role_menu` VALUES (113, 1030);
INSERT INTO `sys_role_menu` VALUES (113, 1031);
INSERT INTO `sys_role_menu` VALUES (113, 1032);
INSERT INTO `sys_role_menu` VALUES (113, 1033);
INSERT INTO `sys_role_menu` VALUES (113, 1034);
INSERT INTO `sys_role_menu` VALUES (113, 1035);
INSERT INTO `sys_role_menu` VALUES (113, 1040);
INSERT INTO `sys_role_menu` VALUES (113, 1041);
INSERT INTO `sys_role_menu` VALUES (113, 1042);
INSERT INTO `sys_role_menu` VALUES (113, 1043);
INSERT INTO `sys_role_menu` VALUES (113, 1044);
INSERT INTO `sys_role_menu` VALUES (113, 1045);
INSERT INTO `sys_role_menu` VALUES (113, 1046);
INSERT INTO `sys_role_menu` VALUES (113, 1047);
INSERT INTO `sys_role_menu` VALUES (113, 1048);
INSERT INTO `sys_role_menu` VALUES (113, 1049);
INSERT INTO `sys_role_menu` VALUES (113, 1050);
INSERT INTO `sys_role_menu` VALUES (113, 1051);
INSERT INTO `sys_role_menu` VALUES (113, 1052);
INSERT INTO `sys_role_menu` VALUES (113, 1053);
INSERT INTO `sys_role_menu` VALUES (113, 1054);
INSERT INTO `sys_role_menu` VALUES (113, 2000);
INSERT INTO `sys_role_menu` VALUES (113, 2001);
INSERT INTO `sys_role_menu` VALUES (113, 2002);
INSERT INTO `sys_role_menu` VALUES (113, 2003);
INSERT INTO `sys_role_menu` VALUES (113, 2004);
INSERT INTO `sys_role_menu` VALUES (113, 2005);
INSERT INTO `sys_role_menu` VALUES (113, 2010);
INSERT INTO `sys_role_menu` VALUES (113, 2020);
INSERT INTO `sys_role_menu` VALUES (113, 2021);
INSERT INTO `sys_role_menu` VALUES (113, 2022);
INSERT INTO `sys_role_menu` VALUES (113, 2024);
INSERT INTO `sys_role_menu` VALUES (113, 2025);
INSERT INTO `sys_role_menu` VALUES (113, 2026);
INSERT INTO `sys_role_menu` VALUES (113, 2027);
INSERT INTO `sys_role_menu` VALUES (113, 2028);
INSERT INTO `sys_role_menu` VALUES (113, 2029);
INSERT INTO `sys_role_menu` VALUES (113, 2030);
INSERT INTO `sys_role_menu` VALUES (113, 2031);
INSERT INTO `sys_role_menu` VALUES (113, 2032);
INSERT INTO `sys_role_menu` VALUES (113, 2033);
INSERT INTO `sys_role_menu` VALUES (113, 2034);
INSERT INTO `sys_role_menu` VALUES (113, 2036);
INSERT INTO `sys_role_menu` VALUES (113, 2037);
INSERT INTO `sys_role_menu` VALUES (113, 2038);
INSERT INTO `sys_role_menu` VALUES (113, 2039);
INSERT INTO `sys_role_menu` VALUES (113, 2040);
INSERT INTO `sys_role_menu` VALUES (113, 2041);
INSERT INTO `sys_role_menu` VALUES (113, 2042);
INSERT INTO `sys_role_menu` VALUES (113, 2043);
INSERT INTO `sys_role_menu` VALUES (113, 2044);
INSERT INTO `sys_role_menu` VALUES (113, 2045);
INSERT INTO `sys_role_menu` VALUES (113, 2046);
INSERT INTO `sys_role_menu` VALUES (113, 2057);
INSERT INTO `sys_role_menu` VALUES (113, 2058);
INSERT INTO `sys_role_menu` VALUES (113, 2059);
INSERT INTO `sys_role_menu` VALUES (113, 2060);
INSERT INTO `sys_role_menu` VALUES (113, 2061);
INSERT INTO `sys_role_menu` VALUES (113, 2062);
INSERT INTO `sys_role_menu` VALUES (113, 2063);
INSERT INTO `sys_role_menu` VALUES (113, 2064);
INSERT INTO `sys_role_menu` VALUES (113, 2069);
INSERT INTO `sys_role_menu` VALUES (113, 2071);
INSERT INTO `sys_role_menu` VALUES (113, 2072);
INSERT INTO `sys_role_menu` VALUES (113, 2073);
INSERT INTO `sys_role_menu` VALUES (113, 2074);
INSERT INTO `sys_role_menu` VALUES (113, 2075);
INSERT INTO `sys_role_menu` VALUES (113, 2077);
INSERT INTO `sys_role_menu` VALUES (113, 2078);
INSERT INTO `sys_role_menu` VALUES (113, 2079);
INSERT INTO `sys_role_menu` VALUES (113, 2080);
INSERT INTO `sys_role_menu` VALUES (113, 2081);
INSERT INTO `sys_role_menu` VALUES (113, 2082);
INSERT INTO `sys_role_menu` VALUES (113, 2083);
INSERT INTO `sys_role_menu` VALUES (113, 2084);
INSERT INTO `sys_role_menu` VALUES (113, 2085);
INSERT INTO `sys_role_menu` VALUES (113, 2086);
INSERT INTO `sys_role_menu` VALUES (114, 1);
INSERT INTO `sys_role_menu` VALUES (114, 2);
INSERT INTO `sys_role_menu` VALUES (114, 100);
INSERT INTO `sys_role_menu` VALUES (114, 101);
INSERT INTO `sys_role_menu` VALUES (114, 102);
INSERT INTO `sys_role_menu` VALUES (114, 103);
INSERT INTO `sys_role_menu` VALUES (114, 104);
INSERT INTO `sys_role_menu` VALUES (114, 105);
INSERT INTO `sys_role_menu` VALUES (114, 106);
INSERT INTO `sys_role_menu` VALUES (114, 108);
INSERT INTO `sys_role_menu` VALUES (114, 109);
INSERT INTO `sys_role_menu` VALUES (114, 110);
INSERT INTO `sys_role_menu` VALUES (114, 112);
INSERT INTO `sys_role_menu` VALUES (114, 113);
INSERT INTO `sys_role_menu` VALUES (114, 116);
INSERT INTO `sys_role_menu` VALUES (114, 500);
INSERT INTO `sys_role_menu` VALUES (114, 501);
INSERT INTO `sys_role_menu` VALUES (114, 1001);
INSERT INTO `sys_role_menu` VALUES (114, 1002);
INSERT INTO `sys_role_menu` VALUES (114, 1003);
INSERT INTO `sys_role_menu` VALUES (114, 1004);
INSERT INTO `sys_role_menu` VALUES (114, 1005);
INSERT INTO `sys_role_menu` VALUES (114, 1006);
INSERT INTO `sys_role_menu` VALUES (114, 1007);
INSERT INTO `sys_role_menu` VALUES (114, 1008);
INSERT INTO `sys_role_menu` VALUES (114, 1009);
INSERT INTO `sys_role_menu` VALUES (114, 1010);
INSERT INTO `sys_role_menu` VALUES (114, 1011);
INSERT INTO `sys_role_menu` VALUES (114, 1012);
INSERT INTO `sys_role_menu` VALUES (114, 1013);
INSERT INTO `sys_role_menu` VALUES (114, 1014);
INSERT INTO `sys_role_menu` VALUES (114, 1015);
INSERT INTO `sys_role_menu` VALUES (114, 1016);
INSERT INTO `sys_role_menu` VALUES (114, 1017);
INSERT INTO `sys_role_menu` VALUES (114, 1018);
INSERT INTO `sys_role_menu` VALUES (114, 1019);
INSERT INTO `sys_role_menu` VALUES (114, 1020);
INSERT INTO `sys_role_menu` VALUES (114, 1021);
INSERT INTO `sys_role_menu` VALUES (114, 1022);
INSERT INTO `sys_role_menu` VALUES (114, 1023);
INSERT INTO `sys_role_menu` VALUES (114, 1024);
INSERT INTO `sys_role_menu` VALUES (114, 1025);
INSERT INTO `sys_role_menu` VALUES (114, 1026);
INSERT INTO `sys_role_menu` VALUES (114, 1027);
INSERT INTO `sys_role_menu` VALUES (114, 1028);
INSERT INTO `sys_role_menu` VALUES (114, 1029);
INSERT INTO `sys_role_menu` VALUES (114, 1030);
INSERT INTO `sys_role_menu` VALUES (114, 1031);
INSERT INTO `sys_role_menu` VALUES (114, 1032);
INSERT INTO `sys_role_menu` VALUES (114, 1033);
INSERT INTO `sys_role_menu` VALUES (114, 1034);
INSERT INTO `sys_role_menu` VALUES (114, 1035);
INSERT INTO `sys_role_menu` VALUES (114, 1040);
INSERT INTO `sys_role_menu` VALUES (114, 1041);
INSERT INTO `sys_role_menu` VALUES (114, 1042);
INSERT INTO `sys_role_menu` VALUES (114, 1043);
INSERT INTO `sys_role_menu` VALUES (114, 1044);
INSERT INTO `sys_role_menu` VALUES (114, 1045);
INSERT INTO `sys_role_menu` VALUES (114, 1046);
INSERT INTO `sys_role_menu` VALUES (114, 1047);
INSERT INTO `sys_role_menu` VALUES (114, 1048);
INSERT INTO `sys_role_menu` VALUES (114, 1049);
INSERT INTO `sys_role_menu` VALUES (114, 1050);
INSERT INTO `sys_role_menu` VALUES (114, 1051);
INSERT INTO `sys_role_menu` VALUES (114, 1052);
INSERT INTO `sys_role_menu` VALUES (114, 1053);
INSERT INTO `sys_role_menu` VALUES (114, 1054);
INSERT INTO `sys_role_menu` VALUES (114, 2000);
INSERT INTO `sys_role_menu` VALUES (114, 2001);
INSERT INTO `sys_role_menu` VALUES (114, 2002);
INSERT INTO `sys_role_menu` VALUES (114, 2003);
INSERT INTO `sys_role_menu` VALUES (114, 2004);
INSERT INTO `sys_role_menu` VALUES (114, 2005);
INSERT INTO `sys_role_menu` VALUES (114, 2010);
INSERT INTO `sys_role_menu` VALUES (114, 2020);
INSERT INTO `sys_role_menu` VALUES (114, 2021);
INSERT INTO `sys_role_menu` VALUES (114, 2022);
INSERT INTO `sys_role_menu` VALUES (114, 2024);
INSERT INTO `sys_role_menu` VALUES (114, 2025);
INSERT INTO `sys_role_menu` VALUES (114, 2026);
INSERT INTO `sys_role_menu` VALUES (114, 2027);
INSERT INTO `sys_role_menu` VALUES (114, 2028);
INSERT INTO `sys_role_menu` VALUES (114, 2029);
INSERT INTO `sys_role_menu` VALUES (114, 2030);
INSERT INTO `sys_role_menu` VALUES (114, 2031);
INSERT INTO `sys_role_menu` VALUES (114, 2032);
INSERT INTO `sys_role_menu` VALUES (114, 2033);
INSERT INTO `sys_role_menu` VALUES (114, 2034);
INSERT INTO `sys_role_menu` VALUES (114, 2036);
INSERT INTO `sys_role_menu` VALUES (114, 2037);
INSERT INTO `sys_role_menu` VALUES (114, 2038);
INSERT INTO `sys_role_menu` VALUES (114, 2039);
INSERT INTO `sys_role_menu` VALUES (114, 2040);
INSERT INTO `sys_role_menu` VALUES (114, 2041);
INSERT INTO `sys_role_menu` VALUES (114, 2042);
INSERT INTO `sys_role_menu` VALUES (114, 2043);
INSERT INTO `sys_role_menu` VALUES (114, 2044);
INSERT INTO `sys_role_menu` VALUES (114, 2045);
INSERT INTO `sys_role_menu` VALUES (114, 2046);
INSERT INTO `sys_role_menu` VALUES (114, 2057);
INSERT INTO `sys_role_menu` VALUES (114, 2058);
INSERT INTO `sys_role_menu` VALUES (114, 2059);
INSERT INTO `sys_role_menu` VALUES (114, 2060);
INSERT INTO `sys_role_menu` VALUES (114, 2061);
INSERT INTO `sys_role_menu` VALUES (114, 2062);
INSERT INTO `sys_role_menu` VALUES (114, 2063);
INSERT INTO `sys_role_menu` VALUES (114, 2064);
INSERT INTO `sys_role_menu` VALUES (114, 2069);
INSERT INTO `sys_role_menu` VALUES (114, 2071);
INSERT INTO `sys_role_menu` VALUES (114, 2072);
INSERT INTO `sys_role_menu` VALUES (114, 2073);
INSERT INTO `sys_role_menu` VALUES (114, 2074);
INSERT INTO `sys_role_menu` VALUES (114, 2075);
INSERT INTO `sys_role_menu` VALUES (114, 2077);
INSERT INTO `sys_role_menu` VALUES (114, 2078);
INSERT INTO `sys_role_menu` VALUES (114, 2079);
INSERT INTO `sys_role_menu` VALUES (114, 2080);
INSERT INTO `sys_role_menu` VALUES (114, 2081);
INSERT INTO `sys_role_menu` VALUES (114, 2082);
INSERT INTO `sys_role_menu` VALUES (114, 2083);
INSERT INTO `sys_role_menu` VALUES (114, 2084);
INSERT INTO `sys_role_menu` VALUES (114, 2085);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称/姓名',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '系统管理员', '01', '123456@123.com', '18888888888', '1', '', '$2a$10$G7MIGBZKPDSD.zGpDPRiJeV3HuOXxk4qEVdQAaZ8pmHHaVRoiDIom', '0', '0', '172.23.0.5', '2023-09-25 23:43:15', 'admin', '2021-08-22 08:37:02', '', '2023-09-25 23:43:15', '管理员');
INSERT INTO `sys_user` VALUES (127, 202, 'test1', '测试员工', '00', '', '', '1', '', '$2a$10$FUxvUdMd8bD.WP1rmJvg4.I4DKaJjheNucCGWW.cC.Ax5MBtDx8Zi', '0', '0', '192.168.44.1', '2023-03-26 11:17:19', 'admin', '2023-03-25 17:32:13', '', '2023-03-26 11:17:19', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (127, 13);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (127, 108);

SET FOREIGN_KEY_CHECKS = 1;