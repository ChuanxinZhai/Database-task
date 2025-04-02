SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for dim_department
-- ----------------------------
DROP TABLE IF EXISTS `dim_department`;
CREATE TABLE `dim_department` (
  `department_id` int(11) NOT NULL,
  `department_name` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of dim_department
-- ----------------------------
INSERT INTO `dim_department` VALUES ('1', 'head office', 'head office at headquarter');
INSERT INTO `dim_department` VALUES ('2', 'Factory_A', 'manualfactory');
INSERT INTO `dim_department` VALUES ('3', 'Factory_B', 'manualfactory');
INSERT INTO `dim_department` VALUES ('4', 'Retail Store Management Dept', 'manage retail store ');
INSERT INTO `dim_department` VALUES ('5', 'HR', 'human resource');
INSERT INTO `dim_department` VALUES ('6', 'Finance', 'Finance');

-- ----------------------------
-- Table structure for dim_occupation_status
-- ----------------------------
DROP TABLE IF EXISTS `dim_occupation_status`;
CREATE TABLE `dim_occupation_status` (
  `occupation_status_id` int(11) unsigned DEFAULT NULL,
  `occupation_status` varchar(100) DEFAULT NULL COMMENT 'is_work or not,  working:1,not working 0',
  KEY `occupation_status_id` (`occupation_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of dim_occupation_status
-- ----------------------------
INSERT INTO `dim_occupation_status` VALUES ('0', 'working');
INSERT INTO `dim_occupation_status` VALUES ('1', 'Inactive');

-- ----------------------------
-- Table structure for dim_role_map
-- ----------------------------
DROP TABLE IF EXISTS `dim_role_map`;
CREATE TABLE `dim_role_map` (
  `role_id` int(11) DEFAULT NULL,
  `role_name` varchar(50) DEFAULT NULL,
  `role_description` varchar(100) DEFAULT NULL,
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of dim_role_map
-- ----------------------------
INSERT INTO `dim_role_map` VALUES ('1', 'CEO', 'CEO');
INSERT INTO `dim_role_map` VALUES ('2', 'CFO', 'CFO');
INSERT INTO `dim_role_map` VALUES ('3', 'Directory', 'Directory');
INSERT INTO `dim_role_map` VALUES ('4', 'General Employee', 'General Employee');

-- ----------------------------
-- Table structure for dim_work_place
-- ----------------------------
DROP TABLE IF EXISTS `dim_work_place`;
CREATE TABLE `dim_work_place` (
  `work_place_id` int(11) NOT NULL,
  `work_place_type_id` int(11) DEFAULT NULL,
  `work_place_name` varchar(100) DEFAULT NULL,
  `postcode` varchar(100) DEFAULT NULL COMMENT 'All postcodes in the south region start with “LS”.',
  PRIMARY KEY (`work_place_id`),
  UNIQUE KEY `work_place_name` (`work_place_name`) USING BTREE COMMENT 'work_place_name'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of dim_work_place
-- ----------------------------
INSERT INTO `dim_work_place` VALUES ('1', '1', 'headquarter_london', 'NN10000');
INSERT INTO `dim_work_place` VALUES ('2', '2', 'factory_001', 'LS10000');
INSERT INTO `dim_work_place` VALUES ('3', '3', 'retail_store_001', 'LS10001');
INSERT INTO `dim_work_place` VALUES ('4', '3', 'retail_store_002', 'LS10002');
INSERT INTO `dim_work_place` VALUES ('5', '3', 'retail_store_003', 'LA10003');
INSERT INTO `dim_work_place` VALUES ('6', '2', 'factory_002', 'NN10000');

-- ----------------------------
-- Table structure for dim_work_place_type
-- ----------------------------
DROP TABLE IF EXISTS `dim_work_place_type`;
CREATE TABLE `dim_work_place_type` (
  `work_place_type_id` int(11) NOT NULL,
  `work_place_type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`work_place_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of dim_work_place_type
-- ----------------------------
INSERT INTO `dim_work_place_type` VALUES ('1', 'headquarter');
INSERT INTO `dim_work_place_type` VALUES ('2', 'factory');
INSERT INTO `dim_work_place_type` VALUES ('3', 'retail store');

-- ----------------------------
-- Table structure for fact_employee_list
-- ----------------------------
DROP TABLE IF EXISTS `fact_employee_list`;
CREATE TABLE `fact_employee_list` (
  `employee_id` int(11) unsigned NOT NULL COMMENT 'employee_id,unique',
  `name` varchar(30) NOT NULL,
  `address` varchar(200) NOT NULL,
  `occupation_status_id` int(11) unsigned NOT NULL COMMENT 'occupation_status',
  `phone_number` varchar(30) NOT NULL,
  `department_id` int(11) NOT NULL,
  `office_id` int(11) unsigned NOT NULL,
  `computer_account` varchar(15) NOT NULL,
  `password` varchar(16) NOT NULL,
  `password_update_time` datetime NOT NULL,
  `working_contract_signed_date` date NOT NULL,
  `salary_baseline` double unsigned DEFAULT '0',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'columns update_time',
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `phone_number_idx` (`phone_number`) USING BTREE,
  UNIQUE KEY `computer_account` (`computer_account`) USING BTREE,
  KEY `occupation_status_id` (`occupation_status_id`),
  KEY `department_id` (`department_id`),
  KEY `office_id` (`office_id`),
  CONSTRAINT `fact_employee_list_ibfk_1` FOREIGN KEY (`occupation_status_id`) REFERENCES `dim_occupation_status` (`occupation_status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fact_employee_list_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `dim_department` (`department_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fact_employee_list_ibfk_3` FOREIGN KEY (`office_id`) REFERENCES `fact_offices` (`office_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fact_employee_list
-- ----------------------------
INSERT INTO `fact_employee_list` VALUES ('1', 'Tarzan', 'Buckingham Palace', '1', '13838380247', '1', '1', 'tarzan', 'tarzanloveyou', '2020-12-02 21:21:43', '2019-12-01', '20000', '2020-12-02 21:21:43');
INSERT INTO `fact_employee_list` VALUES ('2', 'Jane', 'Buckingham Palace', '1', '12888888888', '1', '1', 'jane', 'tarzanlovejane', '2019-01-02 21:21:47', '2019-12-01', '15000', '2020-12-02 23:07:48');
INSERT INTO `fact_employee_list` VALUES ('3', 'Andrew', 'Liverpool', '1', '11111111111', '5', '1', 'Liverpool_first', '12344531143', '2020-12-02 21:21:52', '2020-12-02', '10000', '2020-12-02 21:21:52');
INSERT INTO `fact_employee_list` VALUES ('4', 'Herman', 'Sheffield', '1', '11111111112', '5', '1', 'Hermanlovejane', '12344531143', '2020-12-02 21:21:54', '2020-12-02', '10000', '2020-12-02 21:21:54');
INSERT INTO `fact_employee_list` VALUES ('5', 'Clark', 'London', '1', '11111111113', '6', '1', 'Clarklovejane', '12344531143', '2019-11-29 21:21:56', '2020-12-02', '10000', '2020-12-02 23:07:59');
INSERT INTO `fact_employee_list` VALUES ('6', 'Amanda', 'Lichfield', '1', '11111111114', '6', '1', 'AmandaloveClark', '12344531143', '2020-12-02 21:21:57', '2020-12-02', '10000', '2020-12-02 21:21:57');
INSERT INTO `fact_employee_list` VALUES ('7', 'Jessica', 'Sheffield', '1', '11111111115', '2', '1', 'Jessicalovedog', '12344531143', '2020-12-02 21:21:58', '2020-12-02', '10000', '2020-12-02 21:21:58');
INSERT INTO `fact_employee_list` VALUES ('8', 'Marry', 'Sheffield', '1', '11111111116', '2', '1', 'TarzanloveMarry', '12344531143', '2020-12-02 21:21:59', '2020-12-02', '10000', '2020-12-02 21:21:59');
INSERT INTO `fact_employee_list` VALUES ('9', 'Megan', 'Sheffield', '1', '11111111117', '2', '1', 'MeganloveMarry', '12344531143', '2020-12-02 21:22:00', '2020-12-02', '10000', '2020-12-02 21:22:00');
INSERT INTO `fact_employee_list` VALUES ('10', 'Nicole', 'Sheffield', '1', '11111111118', '2', '1', 'MeganloveNicole', '12344531143', '2020-12-02 21:22:04', '2020-12-02', '5000', '2020-12-02 21:22:04');
INSERT INTO `fact_employee_list` VALUES ('11', 'Katherine', 'Cambridge', '1', '11111111119', '3', '1', 'nooneloveme', '12344531143', '2020-12-02 21:22:06', '2020-12-02', '5000', '2020-12-02 21:22:06');
INSERT INTO `fact_employee_list` VALUES ('12', 'Stephanie', 'Oxford', '1', '11111111120', '3', '1', 'nooneloveher', '12344531143', '2020-12-02 21:22:07', '2020-12-02', '5000', '2020-12-02 21:22:07');
INSERT INTO `fact_employee_list` VALUES ('13', 'Huo', 'Sheffield', '1', '11111111121', '3', '1', 'Jessicalovedog1', '12344531143', '2020-12-02 21:22:08', '2020-12-02', '5000', '2020-12-02 21:22:08');
INSERT INTO `fact_employee_list` VALUES ('14', 'Lambda', 'Sheffield', '1', '11111111122', '4', '1', 'Jessicalovedog2', '12344531143', '2020-12-02 21:22:09', '2020-12-02', '5000', '2020-12-02 21:22:09');
INSERT INTO `fact_employee_list` VALUES ('15', 'Apple', 'Sheffield', '1', '11111111123', '4', '1', 'Jessicalovedog3', '12344531143', '2020-12-02 21:22:13', '2020-12-02', '4000', '2020-12-02 21:22:13');
INSERT INTO `fact_employee_list` VALUES ('16', 'Trump', 'Sheffield', '1', '11111111124', '4', '1', 'Jessicalovedog4', '12344531143', '2020-12-02 21:22:14', '2020-12-02', '4000', '2020-12-02 21:22:14');
INSERT INTO `fact_employee_list` VALUES ('17', 'Baideng', 'Cambridge', '1', '11111111125', '4', '1', 'Jessicalovedog5', '12344531143', '2020-12-02 21:22:14', '2020-12-02', '4000', '2020-12-02 21:22:14');
INSERT INTO `fact_employee_list` VALUES ('18', 'Obama', 'Oxford', '1', '11111111126', '4', '1', 'Jessicalovedog6', '12344531143', '2020-12-02 21:22:15', '2020-12-02', '4000', '2020-12-02 21:22:15');

-- ----------------------------
-- Table structure for fact_offices
-- ----------------------------
DROP TABLE IF EXISTS `fact_offices`;
CREATE TABLE `fact_offices` (
  `office_id` int(11) unsigned NOT NULL,
  `office_name` varchar(100) NOT NULL,
  `work_place_id` int(11) NOT NULL,
  PRIMARY KEY (`office_id`),
  KEY `work_place_id` (`work_place_id`),
  CONSTRAINT `fact_offices_ibfk_1` FOREIGN KEY (`work_place_id`) REFERENCES `dim_work_place` (`work_place_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of fact_offices
-- ----------------------------
INSERT INTO `fact_offices` VALUES ('1', 'headquarter001', '1');
INSERT INTO `fact_offices` VALUES ('2', 'headquarter002', '1');
INSERT INTO `fact_offices` VALUES ('3', 'factory001', '2');
INSERT INTO `fact_offices` VALUES ('4', 'factory002', '2');
INSERT INTO `fact_offices` VALUES ('5', 'retailstore001', '3');
INSERT INTO `fact_offices` VALUES ('6', 'retailstore002', '3');
INSERT INTO `fact_offices` VALUES ('7', 'retailstore003', '3');
INSERT INTO `fact_offices` VALUES ('8', 'retailstore004', '3');

-- ----------------------------
-- Table structure for log_attendance_record_month
-- ----------------------------
DROP TABLE IF EXISTS `log_attendance_record_month`;
CREATE TABLE `log_attendance_record_month` (
  `year` int(11) unsigned NOT NULL,
  `month` int(11) unsigned NOT NULL,
  `employee_id` int(11) unsigned NOT NULL,
  `performance` int(11) NOT NULL,
  `base_attendance_day` int(11) NOT NULL,
  `leave_day` int(11) NOT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`employee_id`,`month`,`year`),
  UNIQUE KEY `idx` (`year`,`month`,`employee_id`) USING BTREE,
  CONSTRAINT `log_attendance_record_month_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `fact_employee_list` (`employee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of log_attendance_record_month
-- ----------------------------
INSERT INTO `log_attendance_record_month` VALUES ('2020', '1', '1', '100', '31', '0', '2020-12-02 21:28:00');
INSERT INTO `log_attendance_record_month` VALUES ('2020', '2', '1', '100', '29', '1', '2020-12-02 21:27:45');
INSERT INTO `log_attendance_record_month` VALUES ('2020', '3', '1', '100', '31', '0', '2020-12-02 21:27:59');
INSERT INTO `log_attendance_record_month` VALUES ('2020', '4', '1', '100', '30', '0', '2020-12-02 21:28:00');
INSERT INTO `log_attendance_record_month` VALUES ('2020', '5', '1', '100', '31', '1', '2020-12-02 22:07:55');
INSERT INTO `log_attendance_record_month` VALUES ('2020', '6', '1', '100', '30', '0', '2020-12-02 21:28:00');
INSERT INTO `log_attendance_record_month` VALUES ('2020', '11', '1', '100', '30', '0', '2020-12-02 21:28:00');
INSERT INTO `log_attendance_record_month` VALUES ('2020', '11', '2', '100', '30', '1', '2020-12-02 23:19:46');
INSERT INTO `log_attendance_record_month` VALUES ('2020', '11', '3', '100', '30', '1', '2020-12-02 23:19:45');

-- ----------------------------
-- Table structure for log_computers_manufactured
-- ----------------------------
DROP TABLE IF EXISTS `log_computers_manufactured`;
CREATE TABLE `log_computers_manufactured` (
  `unique_serial_number` varchar(100) NOT NULL,
  `model_number` varchar(100) NOT NULL,
  `checked_employee_id` int(11) unsigned NOT NULL,
  `CPU_unique_serial_number` varchar(200) NOT NULL,
  `motherboard_unique_serial_number` varchar(200) NOT NULL,
  `graphics_card_unique_serial_number` varchar(200) NOT NULL,
  `screen_unique_serial_number` varchar(200) NOT NULL,
  `power_supply_unique_serial_number` varchar(200) NOT NULL,
  `manufacture_time` datetime NOT NULL,
  `sell_store_id` int(11) NOT NULL,
  `sell_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  KEY `checked_employee_id` (`checked_employee_id`),
  KEY `sell_store_id` (`sell_store_id`),
  CONSTRAINT `log_computers_manufactured_ibfk_1` FOREIGN KEY (`checked_employee_id`) REFERENCES `fact_employee_list` (`employee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `log_computers_manufactured_ibfk_2` FOREIGN KEY (`sell_store_id`) REFERENCES `dim_work_place` (`work_place_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of log_computers_manufactured
-- ----------------------------
INSERT INTO `log_computers_manufactured` VALUES ('AAA00001', ' DT4271', '8', 'L070Q210', '1', '1', '1', '1', '2020-12-02 22:44:45', '1', '2020-12-02 23:42:20');
INSERT INTO `log_computers_manufactured` VALUES ('AAA00002', ' DT4271', '8', 'L070Q211', '1', '1', '1', '1', '2020-12-02 22:44:45', '1', '2020-12-02 23:42:20');
INSERT INTO `log_computers_manufactured` VALUES ('AAA00003', ' DT4271', '8', 'L070Q212', '1', '1', '1', '1', '2020-12-02 22:44:45', '1', '2020-12-02 23:42:20');
INSERT INTO `log_computers_manufactured` VALUES ('AAA00004', ' DT4271', '8', 'L070Q213', '1', '1', '1', '1', '2020-12-02 22:44:45', '1', '2020-12-02 23:42:20');
INSERT INTO `log_computers_manufactured` VALUES ('AAA00005', ' DT4271', '8', 'L070Q214', '1', '1', '1', '1', '2020-12-02 22:44:45', '1', '2020-12-02 23:42:20');
INSERT INTO `log_computers_manufactured` VALUES ('AAA00006', ' DT4271', '8', 'L070Q215', '1', '1', '1', '1', '2020-12-02 22:44:45', '1', '2020-12-02 23:42:20');
INSERT INTO `log_computers_manufactured` VALUES ('AAA00007', ' DT4271', '8', 'L070Q216', '1', '1', '1', '1', '2020-12-02 22:44:45', '1', '2020-12-02 23:42:21');
INSERT INTO `log_computers_manufactured` VALUES ('AAA00008', ' DT4271', '8', 'L070Q217', '1', '1', '1', '1', '2020-12-02 22:44:45', '1', '2020-12-02 23:42:21');
INSERT INTO `log_computers_manufactured` VALUES ('AAA00009', ' DT4271', '8', 'L070Q218', '1', '1', '1', '1', '2020-12-02 22:44:45', '1', '2020-12-02 23:42:21');
INSERT INTO `log_computers_manufactured` VALUES ('AAA00010', ' DT4271', '8', 'L070Q219', '1', '1', '1', '1', '2020-12-02 22:44:45', '1', '2020-12-02 23:42:21');
INSERT INTO `log_computers_manufactured` VALUES ('AAA00011', ' DT4271', '8', 'L070Q228', '1', '1', '1', '1', '2020-12-02 22:44:45', '1', '2020-12-02 23:42:21');
INSERT INTO `log_computers_manufactured` VALUES ('AAA00012', ' DT4271', '8', 'L070Q229', '1', '1', '1', '1', '2020-12-02 22:44:45', '1', '2020-12-02 23:42:21');

-- ----------------------------
-- Table structure for log_cumputer_part
-- ----------------------------
DROP TABLE IF EXISTS `log_cumputer_part`;
CREATE TABLE `log_cumputer_part` (
  `unique_serial_number` varchar(100) NOT NULL,
  `cumputer_part_id` int(11) NOT NULL,
  `part_type` varchar(100) NOT NULL,
  `part_model` varchar(100) NOT NULL,
  `Manufacturer` varchar(100) NOT NULL,
  `part_create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`unique_serial_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of log_cumputer_part
-- ----------------------------
INSERT INTO `log_cumputer_part` VALUES ('L070Q210', '1', 'CPU', 'i5-4430', 'Intel', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('L070Q211', '1', 'CPU', 'i5-4430', 'Intel', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('L070Q212', '1', 'CPU', 'i5-4430', 'Intel', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('L070Q213', '1', 'CPU', 'i5-4430', 'Intel', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('L070Q214', '1', 'CPU', 'i5-4430', 'Intel', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('L070Q215', '1', 'CPU', 'i5-4430', 'Intel', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('L070Q216', '1', 'CPU', 'i5-4430', 'Intel', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('L070Q217', '1', 'CPU', 'i5-4430', 'Intel', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('L070Q218', '1', 'CPU', 'i5-4430', 'Intel', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('L070Q219', '1', 'CPU', 'i5-4430', 'Intel', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('L070Q228', '1', 'CPU', 'i5-4430', 'Intel', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('L070Q229', '1', 'CPU', 'i5-4430', 'Intel', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('MB0000A00C210', '1', 'motherboard', 'mo-009', 'AMD', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('MB0000A00C211', '1', 'motherboard', 'mo-009', 'AMD', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('MB0000A00C212', '1', 'motherboard', 'mo-009', 'AMD', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('MB0000A00C213', '1', 'motherboard', 'mo-009', 'AMD', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('MB0000A00C214', '1', 'motherboard', 'mo-009', 'AMD', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('MB0000A00C215', '1', 'motherboard', 'mo-009', 'AMD', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('MB0000A00C216', '1', 'motherboard', 'mo-009', 'AMD', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('MB0000A00C217', '1', 'motherboard', 'mo-009', 'AMD', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('MB0000A00C218', '1', 'motherboard', 'mo-009', 'AMD', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('MB0000A00C219', '1', 'motherboard', 'mo-009', 'AMD', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('MB0000A00C228', '1', 'motherboard', 'mo-009', 'AMD', '2020-12-02 19:17:57', '2020-12-02 19:18:00');
INSERT INTO `log_cumputer_part` VALUES ('MB0000A00C229', '1', 'motherboard', 'mo-009', 'AMD', '2020-12-02 19:17:57', '2020-12-02 19:18:00');

-- ----------------------------
-- Table structure for log_payment_records
-- ----------------------------
DROP TABLE IF EXISTS `log_payment_records`;
CREATE TABLE `log_payment_records` (
  `year` int(11) unsigned NOT NULL,
  `month` int(11) unsigned NOT NULL,
  `employee_id` int(11) unsigned NOT NULL,
  `payment` double NOT NULL DEFAULT '0',
  `bonus` double NOT NULL DEFAULT '0',
  `reason_reason` varchar(200) NOT NULL DEFAULT '',
  `high_temperature_subsidy` double DEFAULT '0',
  `deduction` double NOT NULL DEFAULT '0',
  `deduction_reason` varchar(200) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`employee_id`,`month`,`year`),
  CONSTRAINT `log_payment_records_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `fact_employee_list` (`employee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of log_payment_records
-- ----------------------------
INSERT INTO `log_payment_records` VALUES ('2020', '1', '1', '20000', '0', '', '0', '0', null, null);
INSERT INTO `log_payment_records` VALUES ('2020', '2', '1', '20000', '0', '', '0', '0', null, null);
INSERT INTO `log_payment_records` VALUES ('2020', '3', '1', '20000', '0', '', '0', '0', null, null);
INSERT INTO `log_payment_records` VALUES ('2020', '4', '1', '20000', '0', '', '0', '0', null, null);
INSERT INTO `log_payment_records` VALUES ('2020', '5', '1', '20000', '0', '', '0', '0', null, null);
INSERT INTO `log_payment_records` VALUES ('2020', '6', '1', '20000', '0', '', '0', '0', null, null);

-- ----------------------------
-- Table structure for relation_departent_email_id
-- ----------------------------
DROP TABLE IF EXISTS `relation_departent_email_id`;
CREATE TABLE `relation_departent_email_id` (
  `departent_id` int(11) NOT NULL,
  `email_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`departent_id`,`email_id`,`role_id`),
  KEY `email_id` (`email_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `relation_departent_email_id_ibfk_1` FOREIGN KEY (`departent_id`) REFERENCES `dim_department` (`department_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `relation_departent_email_id_ibfk_2` FOREIGN KEY (`email_id`) REFERENCES `relation_email_address` (`email_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `relation_departent_email_id_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `relation_employee_id_and_role_id` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of relation_departent_email_id
-- ----------------------------
INSERT INTO `relation_departent_email_id` VALUES ('5', '19', '4');
INSERT INTO `relation_departent_email_id` VALUES ('6', '20', '4');

-- ----------------------------
-- Table structure for relation_email_address
-- ----------------------------
DROP TABLE IF EXISTS `relation_email_address`;
CREATE TABLE `relation_email_address` (
  `email_id` int(11) NOT NULL,
  `email_address` varchar(100) NOT NULL,
  PRIMARY KEY (`email_id`),
  UNIQUE KEY `unique_idx` (`email_id`,`email_address`) USING BTREE COMMENT 'relation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of relation_email_address
-- ----------------------------
INSERT INTO `relation_email_address` VALUES ('1', 'Tarzan@durian.pc');
INSERT INTO `relation_email_address` VALUES ('2', 'Jane@durian.pc');
INSERT INTO `relation_email_address` VALUES ('3', 'Andrew@durian.pc');
INSERT INTO `relation_email_address` VALUES ('4', 'Herman@durian.pc');
INSERT INTO `relation_email_address` VALUES ('5', 'Clark@durian.pc');
INSERT INTO `relation_email_address` VALUES ('6', 'Amanda@durian.pc');
INSERT INTO `relation_email_address` VALUES ('7', 'Jessica@durian.pc');
INSERT INTO `relation_email_address` VALUES ('8', 'Marry@durian.pc');
INSERT INTO `relation_email_address` VALUES ('9', 'Megan@durian.pc');
INSERT INTO `relation_email_address` VALUES ('10', 'Nicole@durian.pc');
INSERT INTO `relation_email_address` VALUES ('11', 'Katherine@durian.pc');
INSERT INTO `relation_email_address` VALUES ('12', 'Stephanie@durian.pc');
INSERT INTO `relation_email_address` VALUES ('13', 'Huo@durian.pc');
INSERT INTO `relation_email_address` VALUES ('14', 'Lambda@durian.pc');
INSERT INTO `relation_email_address` VALUES ('15', 'Apple@durian.pc');
INSERT INTO `relation_email_address` VALUES ('16', 'Trump@durian.pc');
INSERT INTO `relation_email_address` VALUES ('17', 'Baideng@durian.pc');
INSERT INTO `relation_email_address` VALUES ('18', 'Obama@durian.pc');
INSERT INTO `relation_email_address` VALUES ('19', 'HR@abc.pc');
INSERT INTO `relation_email_address` VALUES ('20', 'finance@durian.pc');

-- ----------------------------
-- Table structure for relation_email_id_emplyee_id
-- ----------------------------
DROP TABLE IF EXISTS `relation_email_id_emplyee_id`;
CREATE TABLE `relation_email_id_emplyee_id` (
  `employee_id` int(11) unsigned DEFAULT NULL,
  `email_id` int(11) DEFAULT NULL,
  KEY `employee_id` (`employee_id`),
  KEY `email_id` (`email_id`),
  CONSTRAINT `relation_email_id_emplyee_id_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `fact_employee_list` (`employee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `relation_email_id_emplyee_id_ibfk_2` FOREIGN KEY (`email_id`) REFERENCES `relation_email_address` (`email_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of relation_email_id_emplyee_id
-- ----------------------------
INSERT INTO `relation_email_id_emplyee_id` VALUES ('1', '1');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('2', '2');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('3', '3');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('4', '4');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('5', '5');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('6', '6');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('7', '7');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('8', '8');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('9', '9');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('10', '10');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('11', '11');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('12', '12');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('13', '13');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('14', '14');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('15', '15');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('16', '16');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('17', '17');
INSERT INTO `relation_email_id_emplyee_id` VALUES ('18', '18');

-- ----------------------------
-- Table structure for relation_employee_id_and_role_id
-- ----------------------------
DROP TABLE IF EXISTS `relation_employee_id_and_role_id`;
CREATE TABLE `relation_employee_id_and_role_id` (
  `employee_id` int(11) unsigned NOT NULL,
  `role_id` int(11) NOT NULL,
  KEY `role_id` (`role_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `relation_employee_id_and_role_id_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `fact_employee_list` (`employee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `relation_employee_id_and_role_id_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `dim_role_map` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of relation_employee_id_and_role_id
-- ----------------------------
INSERT INTO `relation_employee_id_and_role_id` VALUES ('1', '1');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('2', '2');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('4', '3');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('5', '3');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('6', '3');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('7', '3');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('8', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('9', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('10', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('11', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('12', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('13', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('14', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('15', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('1', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('2', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('3', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('4', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('5', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('6', '4');
INSERT INTO `relation_employee_id_and_role_id` VALUES ('7', '4');
