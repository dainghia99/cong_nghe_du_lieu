-- Adminer 4.8.1 MySQL 8.0.39 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP VIEW IF EXISTS `DepartmentSummary`;
CREATE TABLE `DepartmentSummary` (`department_name` varchar(100), `total_employees` bigint);


SET NAMES utf8mb4;

DROP TABLE IF EXISTS `Departments`;
CREATE TABLE `Departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) DEFAULT NULL,
  `manager_id` int DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Departments` (`department_id`, `department_name`, `manager_id`) VALUES
(1,	'Sales',	1),
(2,	'Marketing',	2),
(3,	'HR',	3),
(4,	'IT',	4);

DROP VIEW IF EXISTS `EmployeeExpenditures`;
CREATE TABLE `EmployeeExpenditures` (`first_name` varchar(100), `last_name` varchar(100), `total_expenditures` decimal(32,2));


DROP TABLE IF EXISTS `Employees`;
CREATE TABLE `Employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varbinary(255) DEFAULT NULL,
  `phone` varbinary(255) DEFAULT NULL,
  `address` varbinary(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `idx_employee_id` (`employee_id`),
  KEY `idx_department_id` (`department_id`),
  CONSTRAINT `Employees_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `Departments` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone`, `address`, `date_of_birth`, `hire_date`, `salary`, `department_id`, `position`) VALUES
(1,	'John',	'Doe',	UNHEX('6A6F686E2E646F65406578616D706C652E636F6D'),	UNHEX('3132332D3435362D37383930'),	UNHEX('313233204D61696E205374'),	'1980-01-01',	'2020-01-01',	50000.00,	1,	'Manager'),
(2,	'Jane',	'Smith',	UNHEX('6A616E652E736D697468406578616D706C652E636F6D'),	UNHEX('3938372D3635342D33323130'),	UNHEX('34353620456C6D205374'),	'1990-05-15',	'2021-06-01',	45000.00,	2,	'HR Specialist'),
(3,	'Michael',	'Johnson',	UNHEX('6D69636861656C2E6A6F686E736F6E406578616D706C652E636F6D'),	UNHEX('3535352D3535352D35353535'),	UNHEX('373839204F616B205374'),	'1985-10-20',	'2018-07-15',	55000.00,	3,	'Software Engineer'),
(4,	'Emily',	'Davis',	UNHEX('656D696C792E6461766973406578616D706C652E636F6D'),	UNHEX('3333332D3333332D33333333'),	UNHEX('3130312050696E65205374'),	'1992-02-28',	'2022-03-10',	48000.00,	4,	'IT Support'),
(5,	'John',	'Doe',	UNHEX('EC83B103F5473B7644F48E3ACCE540CC2D619F3EDA7B156DA466B15F50415F31'),	UNHEX('F9339EA7966FA47C7584CDF4B33AF8E8'),	UNHEX('B59BCA41C0005423B95076F60BE3041C'),	'1980-01-01',	'2020-01-01',	50000.00,	1,	'Manager'),
(6,	'Jane',	'Smith',	UNHEX('1625FC47D3A0B477C031A58798CB1134945F5EBF64AAB71380F3E9210D1834E3'),	UNHEX('C6DE9E533C11BBF7FE78C4A2168C9EC5'),	UNHEX('7DEBE74B9F4A7F1FC9F685ADA854EE3D'),	'1990-05-15',	'2021-06-01',	45000.00,	2,	'HR Specialist'),
(7,	'Michael',	'Johnson',	UNHEX('649357106FF39A4F42E0382804BDE5D72063E59A9140416457EA3B6CBB3D39D6'),	UNHEX('5E70CBA687515700F2F74A05EF55A586'),	UNHEX('7685A9D1AD7069BECFE98D01BF4C4BEB'),	'1985-10-20',	'2018-07-15',	55000.00,	3,	'Software Engineer'),
(8,	'Emily',	'Davis',	UNHEX('BA9E836F757ADBF81FE8E379C1499F4D2554DD757DDEDD57EF5094E9AC728F4A'),	UNHEX('AFCF40258CFFD9696781DE569BC616DA'),	UNHEX('0451AD0E5A435A80EAA1F7B1261FA236'),	'1992-02-28',	'2022-03-10',	48000.00,	4,	'IT Support');

DROP TABLE IF EXISTS `Expenditures`;
CREATE TABLE `Expenditures` (
  `expenditure_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `expenditure_date` date DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`expenditure_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `Expenditures_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `Employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Expenditures` (`expenditure_id`, `employee_id`, `expenditure_date`, `amount`, `category`) VALUES
(1,	1,	'2023-11-10',	200.00,	'Travel'),
(2,	2,	'2023-11-12',	150.00,	'Training'),
(3,	3,	'2023-11-13',	100.00,	'Office Supplies'),
(4,	4,	'2023-11-15',	250.00,	'Software');

DROP TABLE IF EXISTS `Performance`;
CREATE TABLE `Performance` (
  `performance_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `evaluation_date` date DEFAULT NULL,
  `performance_score` int DEFAULT NULL,
  `feedback` text,
  PRIMARY KEY (`performance_id`),
  KEY `idx_employee_performance` (`employee_id`,`performance_score`),
  CONSTRAINT `Performance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `Employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Performance` (`performance_id`, `employee_id`, `evaluation_date`, `performance_score`, `feedback`) VALUES
(1,	1,	'2023-12-15',	85,	'Excellent work on the project.'),
(2,	2,	'2023-12-15',	75,	'Good communication, needs improvement in efficiency.'),
(3,	3,	'2023-12-15',	90,	'Outstanding performance and technical skills.'),
(4,	4,	'2023-12-15',	70,	'Needs to improve technical knowledge.');

DROP TABLE IF EXISTS `Training`;
CREATE TABLE `Training` (
  `training_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `training_name` varchar(100) DEFAULT NULL,
  `training_date` date DEFAULT NULL,
  `trainer_name` varchar(100) DEFAULT NULL,
  `training_outcome` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`training_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `Training_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `Employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Training` (`training_id`, `employee_id`, `training_name`, `training_date`, `trainer_name`, `training_outcome`) VALUES
(1,	1,	'Leadership Development',	'2023-10-05',	'John Williams',	'Passed'),
(2,	2,	'HR Best Practices',	'2023-09-15',	'Sarah Miller',	'Passed'),
(3,	3,	'Advanced Java Programming',	'2023-08-25',	'David Brown',	'Completed'),
(4,	4,	'Customer Service Excellence',	'2023-07-10',	'Lisa Green',	'Passed');

DROP TABLE IF EXISTS `DepartmentSummary`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `DepartmentSummary` AS select `d`.`department_name` AS `department_name`,count(`e`.`employee_id`) AS `total_employees` from (`Departments` `d` left join `Employees` `e` on((`d`.`department_id` = `e`.`department_id`))) group by `d`.`department_name`;

DROP TABLE IF EXISTS `EmployeeExpenditures`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `EmployeeExpenditures` AS select `e`.`first_name` AS `first_name`,`e`.`last_name` AS `last_name`,sum(`ex`.`amount`) AS `total_expenditures` from (`Employees` `e` join `Expenditures` `ex` on((`e`.`employee_id` = `ex`.`employee_id`))) group by `e`.`employee_id`;

-- 2024-11-17 10:44:51
