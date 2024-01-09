


/*
  06升级到08
*/


-- ----------------------------
-- 变更的表结构
-- ----------------------------
alter table mh_user_hour add column  review_status int null;

-- ----------------------------
-- 修改原项目统计位置
-- ----------------------------
UPDATE `wuyu_cost`.`sys_menu` SET `menu_name` = '项目统计', `parent_id` = 0, `order_num` = 2, `path` = 'pm', `component` = NULL, `is_frame` = 1, `is_cache` = 0, `menu_type` = 'M', `visible` = '0', `status` = '0', `perms` = '', `icon` = 'component', `create_by` = 'admin', `create_time` = '2023-03-25 23:10:19', `update_by` = 'admin', `update_time` = '2023-09-25 23:17:31', `remark` = '' WHERE `menu_id` = 2072;
UPDATE `wuyu_cost`.`sys_menu` SET `menu_name` = '项目管理', `parent_id` = 2072, `order_num` = 9, `path` = 'project', `component` = 'system/project', `is_frame` = 1, `is_cache` = 0, `menu_type` = 'C', `visible` = '0', `status` = '0', `perms` = 'system:project:list', `icon` = 'example', `create_by` = 'admin', `create_time` = '2021-08-30 06:40:28', `update_by` = 'admin', `update_time` = '2023-09-25 23:21:03', `remark` = '' WHERE `menu_id` = 2001;


-- ----------------------------
-- 增加新的功能菜单
-- ----------------------------

INSERT INTO `sys_menu` VALUES (2080, '官方网站', 0, 99, 'site', NULL, 1, 0, 'M', '0', '0', NULL, 'education', 'admin', '2023-09-25 23:13:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2081, '官网网站', 2080, 1, 'https://www.wuyusoft.com/', NULL, 0, 0, 'M', '0', '0', NULL, 'international', 'admin', '2023-09-25 23:14:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2082, '帮助文档', 2080, 2, 'https://doc.wuyusoft.com/cost/', NULL, 1, 0, 'M', '0', '0', NULL, 'documentation', 'admin', '2023-09-25 23:14:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2083, '我的统计', 2002, 3, 'myRecord', 'workingHours/myRecord', 1, 0, 'C', '0', '0', NULL, 'date-range', 'admin', '2023-09-25 23:23:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2084, '我的项目', 2002, 9, 'myProject', 'workingHours/myProject', 1, 0, 'C', '0', '0', '', 'rate', 'admin', '2023-09-25 23:23:51', 'admin', '2023-09-25 23:24:37', '');
INSERT INTO `sys_menu` VALUES (2085, '填报率统计', 2073, 1, 'rate', 'dataStat/rate', 1, 0, 'C', '0', '0', NULL, 'chart', 'admin', '2023-09-25 23:26:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2086, '工时审核', 2073, 3, 'review', 'dataStat/review', 1, 0, 'C', '0', '0', 'mh:review', 'validCode', 'admin', '2023-10-29 21:38:16', 'admin', '2023-10-31 10:44:02', '');
INSERT INTO `sys_menu` VALUES (2087, '审核', 2086, 1, 'mh:review:set', NULL, 1, 0, 'F', '0', '0', 'mh:review:set', '#', 'test1', '2023-11-01 21:42:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2088, '编辑', 2060, 1, '', NULL, 1, 0, 'F', '0', '0', 'system:app:set:edit', '#', 'test1', '2023-11-01 21:43:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2089, '编辑', 2061, 1, '', NULL, 1, 0, 'F', '0', '0', 'system:info:config:editor', '#', 'test1', '2023-11-01 21:43:47', '', NULL, '');
