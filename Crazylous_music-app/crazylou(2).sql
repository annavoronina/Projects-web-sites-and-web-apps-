-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2016 at 12:18 AM
-- Server version: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `crazylou`
--
CREATE DATABASE IF NOT EXISTS `crazylouv` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `crazylouv`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addresses_inactive`(IN `cust_id` INT)
    MODIFIES SQL DATA
UPDATE addresses
	set active = 0
where userid=cust_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addresses_Insert`(IN `srt` VARCHAR(60), IN `suit` VARCHAR(6), IN `cty` VARCHAR(35), IN `prov` VARCHAR(2), IN `pcode` VARCHAR(8), IN `country` VARCHAR(2), IN `custid` INT)
    MODIFIES SQL DATA
INSERT INTO addresses(
    street,
    suite, 
    city,
    province, 
    postalcode,
    country,
    customerid,
    status)

VALUES (srt,
       suit,
       cty,
       prov,
       pcode,
       country,
       custid,
       1)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_Insert`(IN `fname` VARCHAR(40), IN `lname` VARCHAR(40), IN `uemail` VARCHAR(125), IN `thepassword` VARCHAR(56), IN `username` VARCHAR(40))
    MODIFIES SQL DATA
INSERT INTO customer(
    firstname, 
    lastname, 
    email, 
    pswd, 
    uname, 
    status)
VALUES (fname,
       lname,
       uemail,
       thepassword,
       username,
       1)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_last_inserted`(IN `uemail` VARCHAR(125))
    READS SQL DATA
Select Max(customerid)
from customer
where email = uemail$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_verify_login`(IN `theuname` VARCHAR(35), IN `thepassword` VARCHAR(56))
    READS SQL DATA
SELECT customerid
from customer
where uname = theuname and customer.pswd = thepassword$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `invoice_insert`(IN `cust_id` INT, IN `baddress` INT, IN `ordernum` INT, IN `invDate` DATE, IN `payment` INT, IN `taxerate` INT)
    MODIFIES SQL DATA
INSERT INTO invoices(  
    customerid,
    billingaddress,
    ordernumber, 
    invoicedate, 
    paymentmethod, 
    taxrate) 
VALUES (cust_id,
        billingaddress,
        ordernumber,
        CURRENT_DATE(),
       paymentmethod,
       taxrate)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `invoice_load_by_id`(IN `invoice` INT)
    READS SQL DATA
SELECT invoicenumber,customerid, billingaddress, ordernumber, invoicedate, paymentmethod,taxrate 

FROM `invoices` 

WHERE invoicenumber =invoice$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `orderdetails_delete`(IN `orderid` INT)
    NO SQL
DELETE
from orderdetails
where orderdetails.orderid = orderid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `orderdetails_insert`(IN `orderid` INT, IN `flower` INT, IN `qty` INT, IN `price` DECIMAL)
    MODIFIES SQL DATA
INSERT INTO orderdetails(    
    orderid,
    item,
    quantity,
    unitprice)
VALUES (
	orderid,
    flower,
    qty,
	price)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `orderdetials_load_by_order_id`(IN `orderid` INT)
    READS SQL DATA
Select orderdetails.orderid, orderdetails.item,orderdetails.quantity, orderdetails.unitprice,orderaddresses.cpfirstname,orderaddresses.cplastname,
flowercreations.name

from orderdetails,orderaddresses,flowercreations

where orderdetails.orderid = orderid and orderdetails.orderdetailsid = orderaddresses.orderdetailsnum and orderdetails.item = flowercreations.creationid

order by orderdetails.orderdetailsid$$$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `order_insert`(IN `cust_id` INT)
    NO SQL
INSERT INTO orders(    
    customerid,
    orderdate,
    active)
VALUES (cust_id,
       CURRENT_DATE(),
       1)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sessions_logged_out`(IN `sessval` VARCHAR(255))
    NO SQL
UPDATE sessions 
	SET loggedoutdate=CURRENT_DATE(),
        loggedouttime=CURRENT_TIME(),
        isloggedin=0 
WHERE sessions.sessionvalue = sessval$$$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `session_insert`(IN `cust_id` INT, IN `sessval` VARCHAR(255))
    MODIFIES SQL DATA
INSERT INTO sessions(    
    userid,
    sessionvalue,
    loggedindate,
    loggedintime,    
    isloggedin)
VALUES (
	cust_id,

	sessval,
	CURRENT_DATE(),
	CURRENT_TIME(),
	1)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `session_verify_logged_in`(IN `sessval` VARCHAR(255))
    READS SQL DATA
Select userid
from sessions
where sessionvalue = sessval and isloggedin = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `taxrate_by_ID`(IN `taxid` INT)
    READS SQL DATA
SELECT taxrateid, taxrate, active 
FROM taxrate 
where taxrate = taxid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `taxrate_load_active`()
    READS SQL DATA
SELECT taxrateid,taxrate, active 
FROM `taxrate` WHERE active = 1$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE IF NOT EXISTS `addresses` (
  `addressid` int(11) NOT NULL,
  `street` varchar(125) NOT NULL,
  `suite` varchar(12) DEFAULT NULL,
  `city` varchar(35) NOT NULL,
  `province` varchar(2) NOT NULL,
  `postalcode` varchar(8) NOT NULL,
  `country` varchar(2) NOT NULL,
  `customerid` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`addressid`, `street`, `suite`, `city`, `province`, `postalcode`, `country`, `customerid`, `status`) VALUES
(1, '7770 Misty Pointe', NULL, 'Ohogamiut', 'BC', 'V3L-9K8', 'CA', 2, 1),
(2, '3495 Umber Hickory Inlet', '235', 'Deadwood', 'BC', 'V7I-1O8', 'CA', 3, 1),
(3, '1544 Golden Oak Thicket', '789', 'Flea Valley', 'AB', 'T5U-2I8', 'CA', 4, 1),
(4, '8680 Old Island', NULL, 'Hershey', 'PE', 'C9K-0H7', 'CA', 5, 1),
(5, '4485 Easy Vista', NULL, 'Ragtown', 'NL', 'A5U-6T4', 'CA', 6, 1),
(6, '3568 Green Woods', NULL, 'Tollhouse', 'NW', 'X0S-7O8', 'CA', 7, 1),
(7, '5785 Stony Brook Landing', '3223', 'Black Forest', 'BC', 'V5R-1I2', 'CA', 8, 1),
(8, '2764 Velvet Dell', '743', 'Searchlight', 'SK', 'S1Z-0V1', 'CA', 9, 1),
(9, '4431 Blue Nectar Acres', NULL, 'Caviness', 'NL', 'A5V-7V8', 'CA', 10, 1),
(10, '6082 Harvest Key', NULL, 'Progress', 'NL', 'A0A-3N9', 'CA', 11, 1),
(11, '6268 Heather Anchor Arbor', '409', 'Umpqua', 'SK', 'S2A-8K9', 'CA', 12, 1),
(12, '5621 Iron Beacon Stead', NULL, 'Steilacoom', 'NB', 'E3F-1R8', 'CA', 1, 1),
(13, '8332 Shady Close', NULL, 'Christmas', 'PE', 'C1A-9F2', 'CA', 13, 1),
(14, '5242 Dusty Branch Centre', NULL, 'Rocky Boy', 'AB', 'T1R-0D9', 'CA', 14, 1),
(15, '877 Crystal Falls', NULL, 'Helper', 'NL', 'A3E-4C2', 'CA', 15, 1),
(16, '7999 Shady Pioneer Bank', NULL, 'Pickering', 'ON', 'N2F-4L4', 'CA', 16, 1),
(17, '731 Dusty Butterfly Lane', '4563', 'Chippawa', 'ON', 'L2E-2T4', 'CA', 17, 1),
(18, '9037 Fallen Gate Cove', NULL, 'Echo Bay', 'ON', 'M8E-5F5', 'CA', 18, 1),
(19, '6341 Misty Prairie Byway', NULL, 'Massey', 'ON', 'M7E-2J2', 'CA', 19, 1),
(20, '220 Little Crest', NULL, 'South Augusta', 'ON', 'L8W-1G4', 'CA', 20, 1),
(21, '1970 Sleepy Moor', '5623', 'Barkerville', 'ON', 'L5X-2D5', 'CA', 21, 1),
(22, '207 Silver Crescent', '', 'Hensall', 'ON', 'K7P-8V5', 'CA', 22, 1),
(23, '4706 Umber Boulevard', NULL, 'Fraserdale', 'ON', 'M9B-9H1', 'CA', 23, 1),
(24, '4055 Broad Spring Bay', NULL, 'Denbigh', 'ON', 'L5Z-6U6', 'CA', 24, 1),
(25, '9244 Clear Wagon Swale', NULL, 'Lobo Township', 'ON', 'K3U-9L3', 'CA', 25, 1),
(26, '1793 Sleepy Wood', NULL, 'Mackenzie', 'ON', 'L6F-4W9', 'CA', 26, 1),
(27, '3273 Noble Mews', '324', 'Fenelon Falls', 'ON', 'M7Z-3O6', 'CA', 27, 1),
(28, '7286 Cotton Bear Villas', NULL, 'Rathburn', 'ON', 'M6T-8W5', 'CA', 28, 1),
(29, '8709 Merry Mountain Bend', NULL, 'Hallebourg', 'ON', 'N2J-5U7', 'CA', 29, 1),
(30, '2132 Silent Hickory Hollow', NULL, 'Mcintosh', 'ON', 'K9S-3A7', 'CA', 30, 1),
(31, '9067 Colonial Hollow', NULL, 'Kingsport', 'NS', 'B9M-2F7', 'CA', 31, 1),
(32, '7794 Misty Valley', NULL, 'Five Islands', 'NS', 'B4A-8E6', 'CA', 32, 1),
(33, '3199 Silver Dell', NULL, 'Boisdale', 'NS', 'B5S-4K4', 'CA', 33, 1),
(34, '5228 Middle Branch Park', NULL, 'Colpton', 'NS', 'B3E-4H1', 'CA', 34, 1),
(35, '2352 Fallen Way', NULL, 'Yarmouth', 'NS', 'B7Y-9Z8', 'CA', 35, 1),
(36, '6113 Shady Treasure Wood', NULL, 'Saint-gabriel', 'QC', 'J8I-6C5', 'CA', 36, 1),
(37, '2068 Noble Row', NULL, 'Nichikun', 'QC', 'H2U-1I1', 'CA', 37, 1),
(38, '4224 Dewy Brook Jetty', NULL, 'Monet', 'QC', 'G3N-3M6', 'CA', 38, 1),
(39, 'fg', 'fg', 'fgf', 'fg', 'fgff', 'fg', 3, 1),
(40, 'ty', 'ty', 'ty', 'ON', 'ty', 'CA', 42, 1),
(41, '345 Some Street', '', 'Some City', 'ON', '5h5h5', 'CA', 43, 1),
(42, 'sd', 'sd', 'sd', 'ON', 'sd', 'CA', 44, 1);

-- --------------------------------------------------------

--
-- Table structure for table `album`
--

CREATE TABLE IF NOT EXISTS `album` (
  `albumid` int(11) NOT NULL,
  `name` varchar(125) NOT NULL,
  `group` int(11) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `publisherid` int(11) NOT NULL,
  `datereleased` year(4) NOT NULL,
  `Status` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `album`
--

INSERT INTO `album` (`albumid`, `name`, `group`, `price`, `publisherid`, `datereleased`, `Status`) VALUES
(1, 'Abbey Road', 1, '19.99', 1, 1969, 1),
(2, 'Let It Be', 1, '12.99', 1, 1970, 1),
(3, 'Revolver', 1, '11.99', 1, 1966, 1),
(4, 'A Hard Days Night', 1, '12.95', 2, 1964, 2),
(5, 'Tommy', 2, '13.99', 3, 1969, 1),
(6, 'Who''s Next', 2, '21.99', 3, 1971, 1),
(7, 'Face Dances', 2, '6.99', 3, 1981, 1),
(8, 'My Generation', 2, '13.89', 3, 1965, 1),
(9, 'Quadrophenia', 2, '22.99', 3, 1973, 1),
(10, 'A Quick One', 2, '11.99', 3, 1966, 1),
(11, 'Tumbleweed Connection', 3, '9.99', 4, 1970, 1),
(12, 'Good Bye Yellow Brick Road', 3, '22.99', 4, 1973, 0),
(13, 'Captain Fantastic and the Brown Dirty Cowboy', 3, '11.99', 4, 1975, 1),
(14, 'Honky Chateau', 3, '19.99', 4, 1972, 1),
(15, 'Blue Moves', 3, '7.99', 4, 1976, 1),
(16, 'A Single Man', 3, '10.99', 4, 1978, 1),
(17, 'Arrival', 4, '11.99', 5, 1976, 1),
(18, 'The Visitors', 4, '11.89', 5, 1981, 1),
(19, 'Abba', 4, '12.22', 5, 1975, 1),
(20, 'Super Trouper', 4, '10.23', 5, 1980, 1),
(21, 'Ring Ring', 4, '11.98', 5, 1973, 1),
(22, 'Waterloo', 4, '14.95', 5, 1974, 1);

-- --------------------------------------------------------

--
-- Table structure for table `albumcategory`
--

CREATE TABLE IF NOT EXISTS `albumcategory` (
  `albumcategoryid` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL,
  `albumid` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `artist`
--

CREATE TABLE IF NOT EXISTS `artist` (
  `artistid` int(11) NOT NULL,
  `firstname` varchar(40) NOT NULL,
  `lastname` varchar(40) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `artist`
--

INSERT INTO `artist` (`artistid`, `firstname`, `lastname`) VALUES
(1, 'John', 'Lennon'),
(2, 'Paul', 'Mc Cartney'),
(3, 'Ringo', 'Star'),
(4, 'George', 'Harrison'),
(5, 'Roger', 'Daltry'),
(6, 'Pete', 'Townshend'),
(7, 'Keith', 'Moon'),
(8, 'John', 'Entwistle'),
(9, 'Kenny', 'Jones'),
(10, 'John', 'Bundrick'),
(11, 'Doug', 'Sandom'),
(12, 'Elton ', 'John'),
(13, 'Elton', 'John'),
(14, 'Agnetha', 'Faitskog'),
(15, 'Anni-Frid', 'Lyngstad'),
(16, 'Bjorn', 'Ulvaeus'),
(17, 'Benny', 'Anderson'),
(18, 'Michael', 'Jackson'),
(19, 'Mick', 'Jagger'),
(20, 'Keith', 'Richards'),
(21, 'Ronnie', 'Wood'),
(22, 'Charlie', 'Watts'),
(23, 'Bill', 'Wyman'),
(24, 'Randy', 'Owen'),
(25, 'Jeff', 'Cook'),
(26, 'Teddy', 'Genrty'),
(27, 'Mark', 'Herndon'),
(28, 'Jackie', 'Owen'),
(29, 'Natalie', 'Maines'),
(30, 'Emily', 'Robinson'),
(31, 'Martie', 'Maguire'),
(32, 'Laura', 'Lynch'),
(33, 'Robin Lynn', 'Macy'),
(34, 'Ronnie', 'Dunn'),
(35, 'Kix', 'Brooks'),
(36, 'Jennifer', 'Nettles'),
(37, 'Kristian', 'Bush'),
(38, 'Kristen', 'Hall'),
(42, 'Steve', 'Rucker'),
(43, 'Barry', 'Gibb'),
(44, 'Robin', 'Gibb'),
(45, 'Maurice', 'Gibb'),
(46, 'Blue', 'Weaver'),
(47, 'Dennis', 'Bryon'),
(48, 'Beyonce', ''),
(49, 'Kelly', 'Rowland'),
(50, 'Michelle', 'Williams'),
(51, 'LeToya', 'Luckett'),
(52, 'Farrah', 'Franklin'),
(53, 'Nikki', 'Taylor'),
(54, 'Debbie', 'Harry'),
(55, 'Chris', 'Stein'),
(56, 'Clem', 'Burke'),
(57, 'Tommy', 'Kessler'),
(58, 'Leigh', 'Foxx'),
(59, 'Matt', 'Katz-Bohen'),
(60, 'Jimmy', 'Destri'),
(61, 'Nigel', 'Harrison'),
(62, 'Frank', 'Infante'),
(63, 'Paul', 'Carbonara'),
(64, 'David', 'Byne'),
(65, 'Tina', 'Weymouth'),
(66, 'Chris', 'Frantz'),
(67, 'Jerry', 'Harrison'),
(68, 'Fergie', ''),
(69, 'will.i.am', ''),
(70, 'Taboo', ''),
(71, 'Sierra', 'Swan'),
(72, 'Kim', 'Hill'),
(73, 'Willie', 'D'),
(74, 'Scarface', ''),
(75, 'Bill', 'Bushwick'),
(76, 'Mike', 'Big'),
(77, 'Johnny', 'Prince'),
(78, 'Raheem', '');

-- --------------------------------------------------------

--
-- Table structure for table `artistgroup`
--

CREATE TABLE IF NOT EXISTS `artistgroup` (
  `artistgroupid` int(11) NOT NULL,
  `groupid` int(11) NOT NULL,
  `artistid` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `artistgroup`
--

INSERT INTO `artistgroup` (`artistgroupid`, `groupid`, `artistid`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 2, 5),
(6, 2, 6),
(7, 2, 7),
(8, 2, 8),
(9, 2, 9),
(10, 2, 10),
(11, 2, 11),
(12, 3, 13),
(13, 4, 14),
(14, 4, 15),
(15, 4, 16),
(16, 4, 17),
(17, 5, 18),
(18, 6, 19),
(19, 6, 20),
(20, 6, 21),
(21, 6, 22),
(22, 6, 23),
(23, 7, 24),
(24, 7, 25),
(25, 7, 26),
(26, 7, 27),
(27, 7, 28),
(28, 8, 29),
(29, 8, 30),
(30, 8, 31),
(31, 8, 32),
(32, 8, 33),
(33, 9, 34),
(34, 9, 35),
(35, 10, 36),
(36, 10, 37),
(37, 10, 38),
(38, 11, 42),
(39, 11, 43),
(40, 11, 44),
(41, 11, 45),
(42, 11, 46),
(43, 11, 47),
(46, 12, 48),
(47, 12, 49),
(48, 12, 50),
(49, 12, 51),
(50, 12, 52),
(51, 12, 53),
(52, 13, 54),
(53, 13, 55),
(54, 13, 56),
(55, 13, 57),
(56, 13, 58),
(57, 13, 59),
(58, 13, 60),
(59, 13, 61),
(60, 13, 62),
(61, 13, 63),
(62, 14, 64),
(63, 14, 65),
(64, 14, 66),
(65, 14, 67),
(66, 15, 68),
(67, 15, 69),
(68, 15, 70),
(69, 15, 71),
(70, 15, 72),
(71, 16, 73),
(72, 16, 74),
(73, 16, 75),
(74, 16, 76),
(75, 16, 77),
(76, 16, 78);

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE IF NOT EXISTS `cards` (
  `ccardid` int(11) NOT NULL,
  `displayvalue` varchar(255) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`ccardid`, `displayvalue`, `status`) VALUES
(1, 'Mastercard', 1),
(2, 'Visa', 1);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `categoryid` int(11) NOT NULL,
  `displayvalue` varchar(25) NOT NULL,
  `statis` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryid`, `displayvalue`, `statis`) VALUES
(1, 'Rock', 1),
(2, 'Pop', 1),
(3, 'Country', 1),
(4, 'Hip Hop', 0);

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE IF NOT EXISTS `country` (
  `countryid` int(11) NOT NULL,
  `displayvalue` varchar(35) NOT NULL,
  `shortvalue` varchar(2) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `customerid` int(11) NOT NULL,
  `firstname` varchar(40) NOT NULL,
  `lastname` varchar(40) NOT NULL,
  `email` varchar(255) NOT NULL,
  `pswd` varchar(56) NOT NULL,
  `uname` varchar(30) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerid`, `firstname`, `lastname`, `email`, `pswd`, `uname`, `status`) VALUES
(1, 'Dana', 'Morgan', 'dmorgan@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'dmorgan', 1),
(2, 'Natalie', 'Nunez', 'nnunez@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'nnunez', 1),
(3, 'Troy', 'Ball', 'tball@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'tball', 1),
(4, 'Wilfred', 'Hale', 'whale@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'whale', 1),
(5, 'Van', 'Evans', 'vevans@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'vevans', 1),
(6, 'Miranda', 'Ellis', 'mellis@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'mellis', 1),
(7, 'Erin', 'Morrison', 'emorrison@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'emorrison', 1),
(8, 'Brenda', 'Roberston', 'broberston@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'broberson', 1),
(9, 'Lotoya', 'Kennedy', 'lkennedy@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'lkennedy', 1),
(10, 'Emmett', 'Fitzgerald', 'efitzgerald', 'e10adc3949ba59abbe56e057f20f883e', 'efirtzgerald', 1),
(11, 'Melanie', 'Romero', 'mromero@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'mromero', 1),
(12, 'Jessie', 'Peters', 'jpeters@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'jpeters', 1),
(13, 'Herbert', 'Schneider', 'hschneider@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'hschneider', 1),
(14, 'Dominic', 'Tran', 'dtran@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'dtran', 1),
(15, 'Shelly', 'Adams', 'sadams@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'sadams', 1),
(16, 'Margarita', 'Ortiz', 'mortiz@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'mortiz', 1),
(17, 'Debbie', 'Moore', 'dmoore@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'dmoore', 1),
(18, 'Levi', 'Wells', 'lwells@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'lwells', 1),
(19, 'Angel', 'Chavez', 'achavez', 'e10adc3949ba59abbe56e057f20f883e', 'achavez', 1),
(20, 'Joel', 'Howell', 'jhowell@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'jhowell', 1),
(21, 'Erick', 'Sanders', 'esanders@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'esanders', 1),
(22, 'Betty', 'Carson', 'bcarson@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'bcarson', 1),
(23, 'Jerald', 'Morris', 'jmorris@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'jmorris', 1),
(24, 'Josh', 'Cohen', 'jcohen@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'jchoen', 1),
(25, 'John ', 'Smith', 'jsmith@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'jsmith', 1),
(26, 'Tommie', 'Boyd', 'tboyd@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'tboyd', 1),
(27, 'Tom', 'Smith', 'tsmith@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'tsmith', 1),
(28, 'Sarah', 'Hicks', 'shicks@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'shicks', 1),
(29, 'Jamie', 'Hubbard', 'jhubbard@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'jhubbard', 1),
(30, 'Lisa', 'Smith', 'lsmith@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'lsmith', 1),
(31, 'Matt ', 'Solo', 'msolo@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'msolo', 1),
(32, 'Mike', 'Smith', 'msmith@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'msmith', 1),
(33, 'Dean ', 'Lucas', 'dlucas@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'dlucas', 1),
(34, 'Fred', 'Smith', 'fsmith@hotmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'fsmith', 1),
(35, 'Dan', 'Resse', 'dresse@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'dresse', 1),
(36, 'Berry', 'Walsh', 'bwalsh@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'bwalsh', 1),
(37, 'Minne', 'Wallace', 'mmwallace@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'mmwallace', 1),
(38, 'Leo', 'Barrett', 'lbarrett@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'lbarrett', 1),
(39, 'james', 'brouwer', 'jbrouwer@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'jbrouwer', 1),
(40, 'qw', 'qwq', 'qwqw', 'e10adc3949ba59abbe56e057f20f883e', 'qwq', 1),
(41, 'qw', 'qwq', 'qwqw', 'e10adc3949ba59abbe56e057f20f883e', 'qwq', 1),
(42, 'qw', 'qwq', 'qwqw', 'e10adc3949ba59abbe56e057f20f883e', 'qwq', 1),
(44, 'Ralph', 'Jones', 'rjones@mail.com', 'e10adc3949ba59abbe56e057f20f883e', 'rjones', 1);

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

CREATE TABLE IF NOT EXISTS `group` (
  `groupid` int(11) NOT NULL,
  `name` varchar(125) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `group`
--

INSERT INTO `group` (`groupid`, `name`) VALUES
(1, 'Beatles'),
(2, 'Who'),
(3, 'Elton John'),
(4, 'ABBA'),
(5, 'Micheal Jackson'),
(6, 'Rolling Stones'),
(7, 'Alabama'),
(8, 'Dixie Chicks'),
(9, 'Brooks & Dunn'),
(10, 'Sugarland'),
(11, 'Bee Gees'),
(12, 'Desitiny''s Child'),
(13, 'Blondie'),
(14, 'Talking Heads'),
(15, 'The Black Eyed Peas'),
(16, 'Geto Boys');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE IF NOT EXISTS `invoices` (
  `invoicenumber` int(11) NOT NULL,
  `customerid` int(11) NOT NULL,
  `billingaddress` int(11) NOT NULL,
  `ordernumber` int(11) NOT NULL,
  `invoicedate` date NOT NULL,
  `paymentmethod` varchar(20) NOT NULL,
  `taxrate` decimal(2,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE IF NOT EXISTS `orderdetails` (
  `orderdetailsid` int(11) NOT NULL,
  `orderid` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unitprice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `orderid` int(11) NOT NULL,
  `customerid` int(11) NOT NULL,
  `orderdate` date NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE IF NOT EXISTS `payments` (
  `paymentid` int(11) NOT NULL,
  `customerid` int(11) NOT NULL,
  `paymentmethod` int(11) NOT NULL,
  `amountpaid` decimal(10,0) NOT NULL,
  `paymentDate` date NOT NULL,
  `orderid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phonenumbers`
--

CREATE TABLE IF NOT EXISTS `phonenumbers` (
  `phonenumberid` int(11) NOT NULL,
  `phone` varchar(14) NOT NULL,
  `ext` varchar(6) NOT NULL,
  `phonetype` varchar(1) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phonenumbers`
--

INSERT INTO `phonenumbers` (`phonenumberid`, `phone`, `ext`, `phonetype`, `CustomerID`, `status`) VALUES
(1, '416 958-1110', '', 'H', 1, 1),
(2, '416 474-8620', '3456', 'W', 1, 1),
(3, '647 431-7138', '', 'C', 1, 1),
(4, '905 542-0527', '2345', 'W', 2, 1),
(5, '416 279-5375', '', 'C', 2, 1),
(6, '416 181-6801', '2345', 'W', 3, 1),
(7, '416 772-7057', '', 'C', 3, 1),
(8, '416 890-9771', '', 'H', 3, 1),
(9, '416 202-4172', '4456', 'W', 4, 1),
(10, '416 383-8639', '', 'H', 4, 1),
(11, '647 999-2634', '', 'C', 4, 1),
(12, '416 418-6866', '2398', 'W', 5, 1),
(13, '416 486-6357', '', 'H', 5, 1),
(14, '416 787-4497', '4358', 'W', 6, 1),
(15, '905 933-5779', '', 'H', 6, 1),
(16, '647 894-1050', '', 'C', 6, 1),
(17, '905 756-2182', '8635', 'W', 7, 1),
(18, '905 181-0742', '', 'H', 7, 1),
(19, '416 448-7770', '', 'C', 7, 1),
(20, '416 737-6171', '8866', 'W', 8, 1),
(21, '416 525-7648', '', 'H', 8, 1),
(22, '416 536-6808', '7673', 'W', 9, 1),
(23, '416 618-7545', '', 'H', 9, 1),
(24, '647 748-0595', '', 'C', 9, 1),
(25, '(588) 375-6139', '3458', 'W', 10, 1),
(26, '416 541-7729', '', 'H', 10, 1),
(27, '647 660-4732', '', 'C', 10, 1),
(28, '416 544-5327', '', 'W', 11, 1),
(29, '416 721-7978', '', 'H', 11, 1),
(30, '647 165-4928', '', 'C', 11, 1),
(31, '416 809-5063', '3476', 'W', 12, 1),
(32, '905 351-2818', '', 'H', 12, 1),
(33, '647 166-0634', '', 'C', 12, 1),
(34, '416 130-5422', '3423', 'W', 13, 1),
(35, '416 927-2740', '', 'H', 13, 1),
(36, '416 831-0509', '', 'C', 13, 1),
(37, '416 659-5792', '2377', 'W', 14, 1),
(38, '647 308-3341', '', 'C', 14, 1),
(39, '416 802-8994', '', 'W', 15, 1),
(40, '416 669-8684', '', 'H', 15, 1),
(41, '647 426-9241', '', 'C', 15, 1),
(42, '416 375-0207', '', 'H', 16, 1),
(43, '416 709-1417', '', 'C', 16, 1),
(44, '416 737-1557', '5467', 'W', 17, 1),
(45, '416 233-1752', '', 'H', 17, 1),
(46, '647 121-2030', '', 'C', 17, 1),
(47, '416 370-4091', '6657', 'W', 18, 1),
(48, '416 428-8026', '', 'H', 18, 1),
(49, '416 766-5793', '', 'C', 18, 1),
(50, '416 969-5319', '4545', 'W', 19, 1),
(51, '416 512-1462', '', 'H', 19, 1),
(52, '416 910-0135', '', 'C', 19, 1),
(53, '416 624-4682', '3990', 'W', 20, 1),
(54, '647 367-2579', '', 'C', 20, 1),
(55, '613 581-3575', '3476', 'W', 21, 1),
(56, '613 248-6719', '', 'H', 21, 1),
(57, '647 752-7721', '', 'C', 21, 1),
(58, '416 385-8244', '3009', 'W', 22, 1),
(59, '416 652-9526', '', 'H', 22, 1),
(60, '416 379-2604', '', 'C', 22, 1),
(61, '416 124-7608', '', 'H', 23, 1),
(62, '905 863-9893', '', 'C', 23, 1),
(63, '416 140-1445', '3994', 'W', 24, 1),
(64, '905 198-0583', '', 'H', 24, 1),
(65, '416 339-6563', '3382', 'W', 25, 1),
(66, '905 284-0439', '', 'H', 25, 1),
(67, '419 830-1846', '', 'C', 25, 1),
(68, '419 997-8282', '', 'W', 26, 1),
(69, '647 769-3908', '', 'C', 26, 1),
(70, '905 932-7765', '', 'C', 27, 1),
(71, '702 750-0439', '4481', 'W', 28, 1),
(72, '702 656-3355', '', 'C', 28, 1),
(73, '702 981-1481', '', 'C', 29, 0),
(74, '702 170-4704', '', 'H', 30, 1),
(75, '413 667-6245', '2377', 'W', 31, 1),
(76, '413 629-4370', '', 'H', 31, 1),
(77, '613 227-7092', '', 'W', 32, 1),
(78, '613 235-1618', '', 'C', 32, 1),
(79, '905 587-4531', '3420', 'W', 33, 1),
(80, '905 764-9021', '', 'H', 33, 1),
(81, '613 689-5318', '', 'C', 34, 1),
(82, '613 948-4350', '', 'C', 35, 1),
(83, '613 616-5686', '2212', 'W', 36, 1),
(84, '613 704-2750', '', 'H', 36, 1),
(85, '945 842-7405', '', 'H', 37, 1),
(86, '945 179-0769', '', 'C', 37, 1),
(87, '521 204-7602', '', 'H', 38, 1),
(88, '409 215-6897', '', 'C', 38, 1);

-- --------------------------------------------------------

--
-- Table structure for table `provinces`
--

CREATE TABLE IF NOT EXISTS `provinces` (
  `provinceid` int(11) NOT NULL,
  `display` varchar(35) NOT NULL,
  `shortvalue` varchar(2) NOT NULL,
  `status` int(11) NOT NULL,
  `sortorder` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `provinces`
--

INSERT INTO `provinces` (`provinceid`, `display`, `shortvalue`, `status`, `sortorder`) VALUES
(1, 'Alberta', 'AB', 1, 2),
(2, 'British Columbia', 'BC', 1, 3),
(3, 'Manitoba', 'MB', 1, 4),
(4, 'New Brunswick', 'NB', 1, 5),
(5, 'Newfoundland and Labrador', 'NL', 1, 6),
(6, 'Nova Scotia', 'NS', 1, 7),
(7, 'Ontario', 'ON', 1, 8),
(8, 'Prince Edward Island', 'PE', 1, 9),
(9, 'Quebec', 'QC', 1, 10),
(10, 'Saskatchen', 'SK', 1, 11);

-- --------------------------------------------------------

--
-- Table structure for table `publishers`
--

CREATE TABLE IF NOT EXISTS `publishers` (
  `publisherid` int(11) NOT NULL,
  `name` varchar(125) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `publishers`
--

INSERT INTO `publishers` (`publisherid`, `name`) VALUES
(1, 'Apple Records'),
(2, 'EMI Records'),
(3, 'MCA Records'),
(4, 'Mercury Records'),
(5, 'Polar Music International');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `sessionid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `sessionvalue` varchar(255) NOT NULL,
  `loggedindate` date NOT NULL,
  `loggedintime` time NOT NULL,
  `loggedoutdate` date NOT NULL,
  `loggedouttime` time NOT NULL,
  `isloggedin` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`sessionid`, `userid`, `sessionvalue`, `loggedindate`, `loggedintime`, `loggedoutdate`, `loggedouttime`, `isloggedin`) VALUES
(1, 0, '', '2016-05-31', '17:25:38', '0000-00-00', '00:00:00', 1),
(2, 0, '', '2016-05-31', '17:26:26', '0000-00-00', '00:00:00', 1),
(3, 5000000, '', '2016-05-31', '17:26:56', '0000-00-00', '00:00:00', 1),
(4, 5000000, '', '2016-05-31', '17:27:18', '0000-00-00', '00:00:00', 1),
(5, 5000000, '', '2016-05-31', '17:27:32', '0000-00-00', '00:00:00', 1),
(6, 5000000, '', '2016-05-31', '17:27:58', '0000-00-00', '00:00:00', 1),
(7, 5000000, '', '2016-05-31', '17:28:15', '0000-00-00', '00:00:00', 1),
(8, 5000000, '', '2016-05-31', '17:28:50', '0000-00-00', '00:00:00', 1),
(9, 5000000, '', '2016-05-31', '17:29:21', '0000-00-00', '00:00:00', 1),
(10, 5000000, '', '2016-05-31', '17:30:46', '0000-00-00', '00:00:00', 1),
(11, 5000000, '', '2016-05-31', '17:31:22', '0000-00-00', '00:00:00', 1),
(12, 5000000, '', '2016-05-31', '17:32:06', '0000-00-00', '00:00:00', 1),
(13, 5000000, '', '2016-05-31', '17:32:49', '0000-00-00', '00:00:00', 1),
(14, 5000000, '', '2016-05-31', '17:33:12', '0000-00-00', '00:00:00', 1),
(15, 5000000, '', '2016-05-31', '17:33:28', '0000-00-00', '00:00:00', 1),
(16, 5000000, '', '2016-05-31', '17:34:06', '0000-00-00', '00:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `taxrate`
--

CREATE TABLE IF NOT EXISTS `taxrate` (
  `taxrateid` int(11) NOT NULL,
  `taxrate` decimal(2,2) NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`addressid`);

--
-- Indexes for table `album`
--
ALTER TABLE `album`
  ADD PRIMARY KEY (`albumid`);

--
-- Indexes for table `albumcategory`
--
ALTER TABLE `albumcategory`
  ADD PRIMARY KEY (`albumcategoryid`);

--
-- Indexes for table `artist`
--
ALTER TABLE `artist`
  ADD PRIMARY KEY (`artistid`);

--
-- Indexes for table `artistgroup`
--
ALTER TABLE `artistgroup`
  ADD PRIMARY KEY (`artistgroupid`);

--
-- Indexes for table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`ccardid`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryid`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`countryid`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customerid`);

--
-- Indexes for table `group`
--
ALTER TABLE `group`
  ADD PRIMARY KEY (`groupid`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoicenumber`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderid`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`paymentid`);

--
-- Indexes for table `phonenumbers`
--
ALTER TABLE `phonenumbers`
  ADD PRIMARY KEY (`phonenumberid`);

--
-- Indexes for table `provinces`
--
ALTER TABLE `provinces`
  ADD PRIMARY KEY (`provinceid`);

--
-- Indexes for table `publishers`
--
ALTER TABLE `publishers`
  ADD PRIMARY KEY (`publisherid`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`sessionid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `addressid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT for table `album`
--
ALTER TABLE `album`
  MODIFY `albumid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `albumcategory`
--
ALTER TABLE `albumcategory`
  MODIFY `albumcategoryid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `artist`
--
ALTER TABLE `artist`
  MODIFY `artistid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=79;
--
-- AUTO_INCREMENT for table `artistgroup`
--
ALTER TABLE `artistgroup`
  MODIFY `artistgroupid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=77;
--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `ccardid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `categoryid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `countryid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customerid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=45;
--
-- AUTO_INCREMENT for table `group`
--
ALTER TABLE `group`
  MODIFY `groupid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoicenumber` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orderid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `paymentid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `phonenumbers`
--
ALTER TABLE `phonenumbers`
  MODIFY `phonenumberid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=89;
--
-- AUTO_INCREMENT for table `provinces`
--
ALTER TABLE `provinces`
  MODIFY `provinceid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `publishers`
--
ALTER TABLE `publishers`
  MODIFY `publisherid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `sessionid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
