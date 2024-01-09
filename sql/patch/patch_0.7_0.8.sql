


/*
  07升级到08
*/



-- ----------------------------
-- 变更的表结构
-- ----------------------------
alter table mh_user_hour add column  review_status int null;



-- ----------------------------
-- 增加新的功能菜单
-- ----------------------------

INSERT INTO `sys_menu` VALUES (2086, '工时审核', 2073, 3, 'review', 'dataStat/review', 1, 0, 'C', '0', '0', 'mh:review', 'validCode', 'admin', '2023-10-29 21:38:16', 'admin', '2023-10-31 10:44:02', '');
INSERT INTO `sys_menu` VALUES (2087, '审核', 2086, 1, 'mh:review:set', NULL, 1, 0, 'F', '0', '0', 'mh:review:set', '#', 'test1', '2023-11-01 21:42:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2088, '编辑', 2060, 1, '', NULL, 1, 0, 'F', '0', '0', 'system:app:set:edit', '#', 'test1', '2023-11-01 21:43:24', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2089, '编辑', 2061, 1, '', NULL, 1, 0, 'F', '0', '0', 'system:info:config:editor', '#', 'test1', '2023-11-01 21:43:47', '', NULL, '');
