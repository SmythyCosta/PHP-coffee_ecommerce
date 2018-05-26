--
-- Database: `ecommerce2`
--

-- Do not run this page in batch mode!
-- There are a couple of stored procedures that get redefined.
-- Either edit this SQL file accordingly, then run it in batch mode, or copy and paste commands as needed.

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--
USE ecommerce2;

CREATE TABLE `carts` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_session_id` CHAR(32) NOT NULL,
  `product_type` enum('coffee','goodies') NOT NULL,
  `product_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `quantity` TINYINT(3) UNSIGNED NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `product_type` (`product_type`,`product_id`),
  KEY `user_session_id` (`user_session_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(80) NOT NULL,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(40) NOT NULL,
  `address1` VARCHAR(80) NOT NULL,
  `address2` VARCHAR(80) DEFAULT NULL,
  `city` VARCHAR(60) NOT NULL,
  `state` char(2) NOT NULL,
  `zip` MEDIUMINT(5) UNSIGNED ZEROFILL NOT NULL,
  `phone` CHAR(10) NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `general_coffees`
--

CREATE TABLE `general_coffees` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(40) NOT NULL,
  `description` TINYTEXT,
  `image` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`category`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `general_coffees`
--

INSERT INTO `general_coffees` VALUES(1, 'Original Blend', 'Our original blend, featuring a quality mixture of bean and a medium roast for a rich color and smooth flavor.', 'original_coffee.jpg');
INSERT INTO `general_coffees` VALUES(2, 'Dark Roast', 'Our darkest, non-espresso roast, with a full flavor and a slightly bitter aftertaste.', 'dark_roast.jpg');
INSERT INTO `general_coffees` VALUES(3, 'Kona', 'A real treat! Kona coffee, fresh from the lush mountains of Hawaii. Smooth in flavor and perfectly roasted!', 'kona.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `non_coffee_categories`
--

CREATE TABLE `non_coffee_categories` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(40) NOT NULL,
  `description` TINYTEXT NOT NULL,
  `image` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category` (`category`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `non_coffee_categories`
--

INSERT INTO `non_coffee_categories` VALUES(1, 'Edibles', 'A wonderful assortment of goodies to eat. Includes biscotti, baklava, lemon bars, and more!', 'goodies.jpg');
INSERT INTO `non_coffee_categories` VALUES(2, 'Gift Baskets', 'Gift baskets for any occasion! Including our many coffees and other goodies.', 'gift_basket.jpg');
INSERT INTO `non_coffee_categories` VALUES(3, 'Mugs', 'A selection of lovely mugs for enjoying your coffee, tea, hot cocoa or other hot beverages.', '781426_32573620.jpg');
INSERT INTO `non_coffee_categories` VALUES(4, 'Books', 'Our recommended books about coffee, goodies, plus anything written by Larry Ullman!', 'books.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `non_coffee_products`
--

CREATE TABLE `non_coffee_products` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `non_coffee_category_id` TINYINT(3) UNSIGNED NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `description` TINYTEXT,
  `image` VARCHAR(45) NOT NULL,
  `price` INT(10) UNSIGNED NOT NULL,
  `stock` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `non_coffee_category_id` (`non_coffee_category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `non_coffee_products`
--

INSERT INTO `non_coffee_products` (`non_coffee_category_id`, `name`, `description`, `image`, `price`, `stock`, `date_created`) VALUES
(3, 'Pretty Flower Coffee Mug', 'A pretty coffee mug with a flower design on a white background.', 'd9996aee5639209b3fb618b07e10a34b27baad12.jpg', 650, 100, NOW()),
(3, 'Red Dragon Mug', 'An elaborate, painted gold dragon on a red background. With partially detached, fancy handle.', '847a1a3bef0fb5c2f2299b06dd63669000f5c6c4.jpg', 795, 4, NOW());

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` INT(10) UNSIGNED NOT NULL,
  `total` INT(10) UNSIGNED DEFAULT NULL,
  `shipping` INT(10) UNSIGNED NOT NULL DEFAULT 0,
  `credit_card_number` MEDIUMINT(4) ZEROFILL UNSIGNED NOT NULL,
  `order_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_date` (`order_date`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_contents`
--

CREATE TABLE `order_contents` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` INT(10) UNSIGNED NOT NULL,
  `product_type` enum('coffee','goodies') DEFAULT NULL,
  `product_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `quantity` TINYINT(3) UNSIGNED NOT NULL,
  `price_per` INT(10) UNSIGNED NOT NULL,
  `ship_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ship_date` (`ship_date`),
  KEY `product_type` (`product_type`,`product_id`),
  KEY (`order_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_type` enum('coffee','goodies') DEFAULT NULL,
  `product_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `price` INT(10) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `start_date` (`start_date`),
  KEY `product_type` (`product_type`,`product_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`product_type`, `product_id`, `price`, `start_date`, `end_date`) VALUES
('goodies', 1, 500, '2013-08-16', '2013-10-31'),
('coffee', 7, 700, '2013-08-19', NULL),
('coffee', 9, 1300, '2013-08-19', '2013-08-26'),
('goodies', 2, 700, '2013-08-22', NULL),
('coffee', 8, 1300, '2013-08-22', '2013-10-31'),
('coffee', 10, 3000, '2013-08-22', '2013-11-30');

-- --------------------------------------------------------

--
-- Table structure for table `sizes`
--

CREATE TABLE `sizes` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `size` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `size` (`size`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sizes`
--

INSERT INTO `sizes` VALUES(1, '2 oz. Sample');
INSERT INTO `sizes` VALUES(2, 'Half Pound');
INSERT INTO `sizes` VALUES(3, '1 lb.');
INSERT INTO `sizes` VALUES(4, '2 lbs.');
INSERT INTO `sizes` VALUES(5, '5 lbs.');

-- --------------------------------------------------------

--
-- Table structure for table `specific_coffees`
--

CREATE TABLE `specific_coffees` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `general_coffee_id` TINYINT(3) UNSIGNED NOT NULL,
  `size_id` TINYINT(3) UNSIGNED NOT NULL,
  `caf_decaf` enum('caf','decaf') DEFAULT NULL,
  `ground_whole` enum('ground','whole') DEFAULT NULL,
  `price` INT(10) UNSIGNED NOT NULL,
  `stock` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `general_coffee_id` (`general_coffee_id`),
  KEY `size` (`size_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `specific_coffees`
--

INSERT INTO `specific_coffees` (`general_coffee_id`, `size_id`, `caf_decaf`, `ground_whole`, `price`, `stock`, `date_created`) VALUES
(3, 1, 'caf', 'ground', 200, 20, NOW()),
(3, 2, 'caf', 'ground', 450, 30, NOW()),
(3, 2, 'decaf', 'ground', 500, 20, NOW()),
(3, 3, 'caf', 'ground', 800, 50, NOW()),
(3, 3, 'decaf', 'ground', 850, 20, NOW()),
(3, 3, 'caf', 'whole', 750, 50, NOW()),
(3, 3, 'decaf', 'whole', 800, 20, NOW()),
(3, 4, 'caf', 'whole', 1500, 30, NOW()),
(3, 4, 'decaf', 'whole', 1550, 15, NOW()),
(3, 5, 'caf', 'whole', 3250, 5, NOW());

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` INT(10) UNSIGNED NOT NULL,
  `type` VARCHAR(18) NOT NULL,
  `amount` INT(10) UNSIGNED NOT NULL,
  `response_code` TINYINT(1) UNSIGNED NOT NULL,
  `response_reason` TINYTEXT,
  `transaction_id` BIGINT(20) UNSIGNED NOT NULL,
  `response` TEXT NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `wish_lists`
--

CREATE TABLE `wish_lists` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_session_id` char(32) NOT NULL,
  `product_type` enum('coffee','goodies') DEFAULT NULL,
  `product_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `quantity` TINYINT(3) UNSIGNED NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `product_type` (`product_type`,`product_id`),
  KEY `user_session_id` (`user_session_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;




-- -----------------------------
-- Chapter 13 --
-- -----------------------------

CREATE TABLE `reviews` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_type` enum('coffee','goodies') NOT NULL,
  `product_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `email` VARCHAR(80) NOT NULL,
  `review` TEXT NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_type` (`product_type`,`product_id`),
  UNIQUE (`email`, `product_type`, `product_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;




-- -----------------------------
-- Chapter 13 --
-- -----------------------------

CREATE TABLE `charges` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `charge_id` VARCHAR(60) NOT NULL,
  `order_id` INT(10) UNSIGNED NOT NULL,
  `type` VARCHAR(18) NOT NULL,
  `amount` INT(10) UNSIGNED NOT NULL,
  `charge` TEXT NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `charge_id` (`charge_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

