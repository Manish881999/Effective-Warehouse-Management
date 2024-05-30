#create database warehouse;

use warehouse; 

# TABLE STRUCTURE FOR: Warehouse

DROP TABLE IF EXISTS `Warehouse`;

CREATE TABLE `Warehouse` (
  `warehouse_name` varchar(30) NOT NULL,
  `warehouse_phonenumber` int(10) NOT NULL,
  `warehouse_state` char(10) NOT NULL,
  `warehouse_city` char(10) NOT NULL,
  `warehouse_pincode` int(5) NOT NULL,
  PRIMARY KEY `warehouse_name` (`warehouse_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Distribution_center
#

DROP TABLE IF EXISTS `Distribution_center`;

CREATE TABLE `Distribution_center`(
  `center_name` varchar(30) NOT NULL,
  `center_phonenumber` int(10) NOT NULL,
  `center_address` varchar(100) NOT NULL,
  `warehouse_name` varchar(30) NOT NULL,
  PRIMARY KEY (`center_name`),
  FOREIGN KEY (`warehouse_name`) REFERENCES `Warehouse` (`warehouse_name`)
  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Store
#

DROP TABLE IF EXISTS `Store`;

CREATE TABLE `Store` (
  `store_ID` int(9) NOT NULL,
  `store_name` varchar(20) NOT NULL,
  `store_location` varchar(100) NOT NULL,
  PRIMARY KEY (`store_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Customer
#

DROP TABLE IF EXISTS `Customer`;

CREATE TABLE `Customer` (
  `customer_ID` int(9) NOT NULL,
  `customer_name` varchar(20) NOT NULL,
  `customer_address` varchar(100) NOT NULL,
  `customer_number` int(10) NOT NULL,
  PRIMARY KEY (`customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Online_order
#

DROP TABLE IF EXISTS `Online_order`;

CREATE TABLE `Online_order` (
  `order_ID` int(9) NOT NULL,
  `ordered_date` date NOT NULL,
  `delivery_date` date NOT NULL,
  `order_qty` int(2) NOT NULL,
  `customer_ID` int(9) NOT NULL,
  PRIMARY KEY (`order_ID`),
  FOREIGN KEY (`customer_ID`) REFERENCES `Customer` (`customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


#
# TABLE STRUCTURE FOR: Goods
#

DROP TABLE IF EXISTS `Goods`;

CREATE TABLE `Goods` (
  `product_code` int(10) NOT NULL,
  `product_name` varchar(20) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(10) NOT NULL,
  `manufactured_date` date NOT NULL,
  `manufacturer_name` varchar(30) NOT NULL,
  PRIMARY KEY (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Food
#

DROP TABLE IF EXISTS `Food`;

CREATE TABLE `Food` (
  `product_code` int(10) NOT NULL,
  `weight` float NOT NULL,
  `expiry_date` date NOT NULL,
  `category` set('vegetarian','non-vegetarian','vegan') NOT NULL,
  `nutrition_facts` varchar(255) NOT NULL,
  `ingredients` varchar(255) NOT NULL,
  PRIMARY KEY (`product_code`),
  FOREIGN KEY (`product_code`) REFERENCES `Goods` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Clothing
#

DROP TABLE IF EXISTS `Clothing`;

CREATE TABLE `Clothing` (
  `product_code` int(10) NOT NULL,
  `colour` varchar(20) NOT NULL,
  `size` int(2) NOT NULL,
  `fitting` set('slim','tight') NOT NULL,
  `material_type` set('cotton','Silk','Woolen') NOT NULL,
  PRIMARY KEY (`product_code`),
  FOREIGN KEY (`product_code`) REFERENCES `Goods` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Electronics
#

DROP TABLE IF EXISTS `Electronics`;

CREATE TABLE `Electronics` (
  `product_code` int(10) NOT NULL,
  `specifications` varchar(255) NOT NULL,
  `model_number` char(20) NOT NULL,
  `weight` int(4) NOT NULL,
  PRIMARY KEY (`product_code`),
  FOREIGN KEY (`product_code`) REFERENCES `Goods` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Employee
#

DROP TABLE IF EXISTS `Employee`;

CREATE TABLE `Employee` (
  `SSN` int(9) NOT NULL,
  `manager_ID` int(9) NOT NULL,
  `emp_name` varchar(20) NOT NULL,
  `emp_address` varchar(100) NOT NULL,
  `emp_phonenumber` int(10) NOT NULL,
  PRIMARY KEY (`SSN`,`manager_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Employee_Email
#

DROP TABLE IF EXISTS `Employee_Email`;

CREATE TABLE `Employee_Email` (
  `SSN` int(9) NOT NULL,
  `emp_email` varchar(20) NOT NULL,
  PRIMARY KEY (`SSN`,`emp_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Supplies_To
#

DROP TABLE IF EXISTS `Supplies_To`;

CREATE TABLE `Supplies_To` (
  `center_name` varchar(30) NOT NULL,
  `store_ID` int(9) NOT NULL,
  PRIMARY KEY (`center_name`,`store_ID`),
  FOREIGN KEY (`store_ID`) REFERENCES `Store` (`store_ID`),
  FOREIGN KEY (`center_name`) REFERENCES `Distribution_center` (`center_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Sells
#

DROP TABLE IF EXISTS `Sells`;

CREATE TABLE `Sells` (
  `store_ID` int(9) NOT NULL,
  `product_code` int(10) NOT NULL,
  PRIMARY KEY (`store_ID`,`product_code`),
  FOREIGN KEY (`store_ID`) REFERENCES `Store` (`store_ID`),
  FOREIGN KEY (`product_code`) REFERENCES `Goods` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Payment
#

DROP TABLE IF EXISTS `Payment`;

CREATE TABLE `Payment` (
  `payment_ID` int(9) NOT NULL,
  `payment_method` set('credit','debit') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`payment_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Receives
#

DROP TABLE IF EXISTS `Receives`;

CREATE TABLE `Receives` (
  `order_ID` int(9) NOT NULL,
  `payment_ID` int(9) NOT NULL,
  `store_ID` int(9) NOT NULL,
  `amount` int(9) NOT NULL,
  PRIMARY KEY `order_ID` (`order_ID`,`payment_ID`,`store_ID`),
  FOREIGN KEY (`order_ID`) REFERENCES `Online_order` (`order_ID`),
  FOREIGN KEY (`store_ID`) REFERENCES `Store` (`store_ID`),
  FOREIGN KEY (`payment_ID`) REFERENCES `Payment` (`payment_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# TABLE STRUCTURE FOR: Works_At
#

DROP TABLE IF EXISTS `Works_At`;

CREATE TABLE `Works_At` (
  `SSN` int(9) NOT NULL,
  `warehouse_name` varchar(30) NOT NULL,
  `center_name` varchar(30) NOT NULL,
  `store_ID` int(9) NOT NULL,
  PRIMARY KEY (`SSN`,`warehouse_name`,`center_name`,`store_ID`),
  FOREIGN KEY (`SSN`) REFERENCES `Employee` (`SSN`),
  FOREIGN KEY (`warehouse_name`) REFERENCES `Warehouse` (`warehouse_name`),
  FOREIGN KEY (`center_name`) REFERENCES `Distribution_center` (`center_name`),
  FOREIGN KEY (`store_ID`) REFERENCES `Store` (`store_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- -- create database warehouse;

-- use warehouse; 

-- -- #
-- -- # TABLE STRUCTURE FOR: Warehouse
-- -- #

-- -- SET FOREIGN_KEY_CHECKS=0;

-- DROP TABLE IF EXISTS `Warehouse`;

-- -- CREATE TABLE Warehouse (
-- --   warehouse_name varchar(100) NOT NULL,
-- --   warehouse_phonenumber int(100),
-- --   warehouse_state char(100),
-- --   warehouse_city char(100),
-- --   warehouse_pincode int(100),
-- --   PRIMARY KEY (warehouse_name)
-- -- );

-- CREATE TABLE Warehouse (
--   warehouse_name varchar(30) NOT NULL,
--   warehouse_phonenumber varchar(15) NOT NULL,
--   warehouse_state char(30) NOT NULL,
--   warehouse_city char(30) NOT NULL,
--   warehouse_pincode int(5) NOT NULL,
--   PRIMARY KEY (warehouse_name)
-- );

-- DROP TABLE IF EXISTS `Distribution_center`;

-- CREATE TABLE Distribution_center(
--   center_name varchar(30) NOT NULL,
--   center_phonenumber int(10) NOT NULL,
--   center_state char(30) NOT NULL,
--   center_city char(30) NOT NULL,
--   center_pincode int(5) NOT NULL,
--   center_address varchar(100) NOT NULL,
--   warehouse_name varchar(30) NOT NULL,
--   PRIMARY KEY (center_name),
--   FOREIGN KEY (warehouse_name) REFERENCES Warehouse (warehouse_name)
--   ON DELETE CASCADE ON UPDATE CASCADE
-- );

-- DROP TABLE IF EXISTS `Store`;

-- CREATE TABLE Store (
--   store_ID int(10) NOT NULL,
--   store_name varchar(30) NOT NULL,
--   store_state char(30) NOT NULL,
--   store_city char(30) NOT NULL,
--   store_pincode int(5) NOT NULL,
--   store_location varchar(100) NOT NULL,
--   PRIMARY KEY (store_ID)
-- );


-- DROP TABLE IF EXISTS `Customer`;

-- CREATE TABLE `Customer` (
--   `customer_ID` int(10) NOT NULL,
--   `customer_name` varchar(30) NOT NULL,
--   `customer_state` char(30) NOT NULL,
--   `customer_city` char(30) NOT NULL,
--   `customer_pincode` int(5) NOT NULL,
--   `customer_address` varchar(100) NOT NULL,
--   `customer_number` int(10) NOT NULL,
--   PRIMARY KEY (`customer_ID`)
-- );

-- DROP TABLE IF EXISTS `Online_order`;

-- CREATE TABLE `Online_order` (
--   `order_ID` int(10) NOT NULL,
--   `ordered_date` date NOT NULL,
--   `delivery_date` date NOT NULL,
--   `order_qty` int(5) NOT NULL,
--   `customer_ID` int(10) NOT NULL,
--   PRIMARY KEY (`order_ID`),
--   FOREIGN KEY (`customer_ID`) REFERENCES `Customer` (`customer_ID`)
--   ON DELETE CASCADE ON UPDATE CASCADE
-- );


-- #
-- # TABLE STRUCTURE FOR: Goods
-- #

-- DROP TABLE IF EXISTS `Goods`;

-- CREATE TABLE `Goods` (
--   `product_code` int(20) NOT NULL,
--   `product_name` varchar(30) NOT NULL,
--   `price` decimal(5,2) NOT NULL,
--   `stock` int(5) NOT NULL,
--   `manufactured_date` date NOT NULL,
--   `manufacturer_name` varchar(30) NOT NULL,
--   PRIMARY KEY (`product_code`)
-- );

-- #
-- # TABLE STRUCTURE FOR: Food
-- #

-- DROP TABLE IF EXISTS `Food`;

-- CREATE TABLE `Food` (
--   `food_product_code` int(20) NOT NULL,
--   `weight` decimal(10,2),
--   `expiry_date` date NOT NULL,
--   `category` set('vegetarian','non-vegetarian','vegan') not null,
--   `nutrition_facts` varchar(255),
--   `ingredients` varchar(255),
--   PRIMARY KEY (`food_product_code`),
--   FOREIGN KEY (`food_product_code`) REFERENCES `Goods` (`product_code`)
--   ON DELETE CASCADE ON UPDATE CASCADE
-- );

-- #
-- # TABLE STRUCTURE FOR: Clothing
-- #

-- DROP TABLE IF EXISTS `Clothing`;

-- CREATE TABLE `Clothing` (
--   `clothing_product_code` int(20) NOT NULL,
--   `colour` varchar(10),
--   `size` varchar(2),
--   `fitting` set('slim','tight'),
--   `material_type` set('cotton','Silk','Woolen'),
--   PRIMARY KEY (`clothing_product_code`),
--   FOREIGN KEY (`clothing_product_code`) REFERENCES `Goods` (`product_code`)
--   ON DELETE CASCADE ON UPDATE CASCADE
-- );

-- #
-- # TABLE STRUCTURE FOR: Electronics
-- #

-- DROP TABLE IF EXISTS `Electronics`;

-- CREATE TABLE `Electronics` (
--   `electronics_product_code` int(20) NOT NULL,
--   `specifications` varchar(255),
--   `model_number` char(20),
--   `weight` decimal(10,2),
--   PRIMARY KEY (`electronics_product_code`),
--   FOREIGN KEY (`electronics_product_code`) REFERENCES `Goods` (`product_code`)
--   ON DELETE CASCADE ON UPDATE CASCADE
-- );

-- #
-- # TABLE STRUCTURE FOR: Employee
-- #

-- DROP TABLE IF EXISTS `Employee`;

-- CREATE TABLE `Employee` (
--   `SSN` int(9) NOT NULL,
--   `manager_ID` int(10) NOT NULL,
--   `emp_name` varchar(20) NOT NULL,
--   `emp_state` char(30) NOT NULL,
--   `emp_city` char(30) NOT NULL,
--   `emp_pincode` int(5) NOT NULL,
--   `emp_address` varchar(100) NOT NULL,
--   `emp_phonenumber` int(10) NOT NULL,
--   PRIMARY KEY (`SSN`,`manager_ID`)
-- );

-- #
-- # TABLE STRUCTURE FOR: Employee_Email
-- #

-- DROP TABLE IF EXISTS `Employee_Email`;

-- CREATE TABLE `Employee_Email` (
--   `SSN` int(9) NOT NULL,
--   `emp_email` varchar(20) NOT NULL,
--   PRIMARY KEY (`SSN`,`emp_email`)
-- );

-- #
-- # TABLE STRUCTURE FOR: Supplies_To
-- #

-- DROP TABLE IF EXISTS `Supplies_To`;

-- CREATE TABLE `Supplies_To` (
--   `supplies_to_center_name` varchar(30) NOT NULL,
--   `supplies_to_store_ID` int(10) NOT NULL,
--   PRIMARY KEY (`supplies_to_center_name`,`supplies_to_store_ID`),
--   FOREIGN KEY (`supplies_to_store_ID`) REFERENCES `Store` (`store_ID`) 
--   ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY (`supplies_to_center_name`) REFERENCES `Distribution_center` (`center_name`)
--   ON DELETE CASCADE ON UPDATE CASCADE
-- );

-- ####################################


-- #
-- # TABLE STRUCTURE FOR: Sells
-- #

-- DROP TABLE IF EXISTS `Sells`;

-- CREATE TABLE `Sells` (
--   `sells_store_ID` int(10) NOT NULL,
--   `sells_product_code` int(20) NOT NULL,
--   PRIMARY KEY (`sells_store_ID`,`sells_product_code`),
--   FOREIGN KEY (`sells_store_ID`) REFERENCES `Store` (`store_ID`)
--   ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY (`sells_product_code`) REFERENCES `Goods` (`product_code`)
--   ON DELETE CASCADE ON UPDATE CASCADE
-- );

-- #
-- # TABLE STRUCTURE FOR: Payment
-- #

-- DROP TABLE IF EXISTS `Payment`;

-- CREATE TABLE `Payment` (
--   `payment_ID` int(10) NOT NULL,
--   `payment_method` set('credit','debit') NOT NULL,
--   `amount` decimal(10,2) NOT NULL,
--   PRIMARY KEY (`payment_ID`)
-- );

-- #
-- # TABLE STRUCTURE FOR: Receives
-- #

-- DROP TABLE IF EXISTS `Receives`;

-- CREATE TABLE `Receives` (
--   `receives_order_ID` int(10) NOT NULL,
--   `receives_payment_ID` int(10) NOT NULL,
--   `receives_store_ID` int(10) NOT NULL,
--   `amount` decimal(10,2) NOT NULL,
--   PRIMARY KEY (`receives_order_ID`,`receives_payment_ID`,`receives_store_ID`),
--   FOREIGN KEY (`receives_order_ID`) REFERENCES `Online_order` (`order_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY (`receives_store_ID`) REFERENCES `Store` (`store_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY (`receives_payment_ID`) REFERENCES `Payment` (`payment_ID`) ON DELETE CASCADE ON UPDATE CASCADE
-- );

-- #
-- # TABLE STRUCTURE FOR: Works_At
-- #

-- DROP TABLE IF EXISTS `Works_At`;

-- CREATE TABLE `Works_At` (
--   `works_at_SSN` int(9) NOT NULL,
--   `works_at_warehouse_name` varchar(30) NOT NULL,
--   `works_at_center_name` varchar(30) NOT NULL,
--   `works_at_store_ID` int(10) NOT NULL,
--   PRIMARY KEY (`works_at_SSN`,`works_at_warehouse_name`,`works_at_center_name`,`works_at_store_ID`),
--   FOREIGN KEY (`works_at_SSN`) REFERENCES `Employee` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY (`works_at_warehouse_name`) REFERENCES `Warehouse` (`warehouse_name`) ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY (`works_at_center_name`) REFERENCES `Distribution_center` (`center_name`) ON DELETE CASCADE ON UPDATE CASCADE,
--   FOREIGN KEY (`works_at_store_ID`) REFERENCES `Store` (`store_ID`) ON DELETE CASCADE ON UPDATE CASCADE
-- );