-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 17, 2026 at 04:55 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbwildstar`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblarearestrictions`
--

CREATE TABLE `tblarearestrictions` (
  `restrictionID` int(11) NOT NULL,
  `areaID` int(11) DEFAULT NULL,
  `departmentID` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblarearestrictions`
--

INSERT INTO `tblarearestrictions` (`restrictionID`, `areaID`, `departmentID`) VALUES
(1, 3, 'CASE'),
(2, 3, 'CCJ'),
(3, 3, 'CCS'),
(4, 3, 'CEA'),
(5, 3, 'CMBA'),
(6, 3, 'CNAHS'),
(7, 4, 'CASE'),
(8, 4, 'CCJ'),
(9, 4, 'CCS'),
(10, 4, 'CEA'),
(11, 4, 'CMBA'),
(12, 4, 'CNAHS'),
(13, 5, 'CASE'),
(14, 5, 'CCJ'),
(15, 5, 'CCS'),
(16, 5, 'CEA'),
(17, 5, 'CMBA'),
(18, 5, 'CNAHS'),
(19, 6, 'JHS'),
(20, 7, 'SHS'),
(21, 8, 'CASE'),
(22, 8, 'CCJ'),
(23, 8, 'CCS'),
(24, 8, 'CEA'),
(25, 8, 'CMBA'),
(26, 8, 'CNAHS'),
(27, 9, 'CCS'),
(29, 10, 'CASE'),
(28, 10, 'SHS');

-- --------------------------------------------------------

--
-- Table structure for table `tbldepartment`
--

CREATE TABLE `tbldepartment` (
  `departmentID` varchar(5) NOT NULL,
  `departmentName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbldepartment`
--

INSERT INTO `tbldepartment` (`departmentID`, `departmentName`) VALUES
('CASE', 'College of Arts, Sciences and Education'),
('CCJ', 'College of Criminal Justice'),
('CCS', 'College of Computer Studies'),
('CEA', 'College of Engineering and Architecture'),
('CMBA', 'College of Management Business and Accountancy'),
('CNAHS', 'College of Nursing and Allied Sciences'),
('JHS', 'Junior High School Department'),
('SHS', 'Senior High School Department');

-- --------------------------------------------------------

--
-- Table structure for table `tblreservation`
--

CREATE TABLE `tblreservation` (
  `reservationID` int(11) NOT NULL,
  `userID` int(11) DEFAULT NULL,
  `resourceID` int(11) DEFAULT NULL,
  `purpose` varchar(100) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `num_participants` int(11) DEFAULT 1,
  `status_type` enum('Pending','Active','NoShow','Completed') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblreservationparticipant`
--

CREATE TABLE `tblreservationparticipant` (
  `participantID` int(11) NOT NULL,
  `userID` int(11) DEFAULT NULL,
  `reservationID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblresource`
--

CREATE TABLE `tblresource` (
  `resourceID` int(11) NOT NULL,
  `areaID` int(11) DEFAULT NULL,
  `resourceName` varchar(50) DEFAULT NULL,
  `minCapacity` int(11) DEFAULT 1,
  `maxCapacity` int(11) DEFAULT NULL,
  `resource_type` enum('Station','Table','Room') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblresource`
--

INSERT INTO `tblresource` (`resourceID`, `areaID`, `resourceName`, `minCapacity`, `maxCapacity`, `resource_type`) VALUES
(1, 1, 'Large Table 1', 4, 10, 'Table'),
(2, 1, 'Large Table 2', 4, 10, 'Table'),
(3, 1, 'Large Table 3', 4, 10, 'Table'),
(4, 1, 'Large Table 4', 4, 10, 'Table'),
(5, 1, 'Large Table 5', 4, 10, 'Table'),
(6, 1, 'Large Table 6', 4, 10, 'Table'),
(7, 1, 'Large Table 7', 4, 10, 'Table'),
(8, 1, 'Large Table 8', 4, 10, 'Table'),
(9, 1, 'Large Table 9', 4, 10, 'Table'),
(10, 1, 'Large Table 10', 4, 10, 'Table'),
(11, 1, 'Large Table 11', 4, 10, 'Table'),
(12, 1, 'Large Table 12', 4, 10, 'Table'),
(13, 1, 'Large Table 13', 4, 10, 'Table'),
(14, 1, 'Large Table 14', 4, 10, 'Table'),
(15, 1, 'Large Table 15', 4, 10, 'Table'),
(16, 1, 'Large Table 16', 4, 10, 'Table'),
(17, 1, 'Large Table 17', 4, 10, 'Table'),
(18, 1, 'Large Table 18', 4, 10, 'Table'),
(19, 1, 'Large Table 19', 4, 10, 'Table'),
(20, 1, 'Large Table 20', 4, 10, 'Table'),
(21, 1, 'Large Table 21', 4, 10, 'Table'),
(22, 1, 'Large Table 22', 4, 10, 'Table'),
(23, 1, 'Large Table 23', 4, 10, 'Table'),
(24, 1, 'Large Table 24', 4, 10, 'Table'),
(25, 1, 'Large Table 25', 4, 10, 'Table'),
(26, 1, 'Large Table 26', 4, 10, 'Table'),
(27, 1, 'Large Table 27', 4, 10, 'Table'),
(28, 1, 'Large Table 28', 4, 10, 'Table'),
(29, 1, 'Large Table 29', 4, 10, 'Table'),
(30, 1, 'Large Table 30', 4, 10, 'Table'),
(31, 1, 'Large Table 31', 4, 10, 'Table'),
(32, 1, 'Large Table 32', 4, 10, 'Table'),
(33, 1, 'Large Table 33', 4, 10, 'Table'),
(34, 1, 'Large Table 34', 4, 10, 'Table'),
(35, 1, 'Large Table 35', 4, 10, 'Table'),
(36, 2, 'Small Table 1', 1, 2, 'Table'),
(37, 2, 'Small Table 2', 1, 2, 'Table'),
(38, 2, 'Small Table 3', 1, 2, 'Table'),
(39, 2, 'Small Table 4', 1, 2, 'Table'),
(40, 2, 'Small Table 5', 1, 2, 'Table'),
(41, 2, 'Small Table 6', 1, 2, 'Table'),
(42, 2, 'Small Table 7', 1, 2, 'Table'),
(43, 2, 'Small Table 8', 1, 2, 'Table'),
(44, 2, 'Small Table 9', 1, 2, 'Table'),
(45, 2, 'Small Table 10', 1, 2, 'Table'),
(46, 2, 'Medium Table 1', 3, 6, 'Table'),
(47, 2, 'Medium Table 2', 3, 6, 'Table'),
(48, 2, 'Medium Table 3', 3, 6, 'Table'),
(49, 2, 'Medium Table 4', 3, 6, 'Table'),
(50, 2, 'Medium Table 5', 3, 6, 'Table'),
(51, 2, 'Medium Table 6', 3, 6, 'Table'),
(52, 2, 'Medium Table 7', 3, 6, 'Table'),
(53, 2, 'Medium Table 8', 3, 6, 'Table'),
(54, 2, 'Medium Table 9', 3, 6, 'Table'),
(55, 2, 'Medium Table 10', 3, 6, 'Table'),
(56, 2, 'Large Table 1', 4, 10, 'Table'),
(57, 2, 'Large Table 2', 4, 10, 'Table'),
(58, 2, 'Large Table 3', 4, 10, 'Table'),
(59, 3, 'Medium Room 1', 3, 6, 'Room'),
(60, 3, 'Medium Room 2', 3, 6, 'Room'),
(61, 3, 'Medium Room 3', 3, 6, 'Room'),
(62, 4, 'Station 1', 1, 1, 'Station'),
(63, 4, 'Station 2', 1, 1, 'Station'),
(64, 4, 'Station 3', 1, 1, 'Station'),
(65, 4, 'Station 4', 1, 1, 'Station'),
(66, 4, 'Station 5', 1, 1, 'Station'),
(67, 4, 'Station 6', 1, 1, 'Station'),
(68, 4, 'Station 7', 1, 1, 'Station'),
(69, 4, 'Station 8', 1, 1, 'Station'),
(70, 4, 'Station 9', 1, 1, 'Station'),
(71, 4, 'Station 10', 1, 1, 'Station'),
(72, 4, 'Station 11', 1, 1, 'Station'),
(73, 4, 'Station 12', 1, 1, 'Station'),
(74, 4, 'Station 13', 1, 1, 'Station'),
(75, 4, 'Station 14', 1, 1, 'Station'),
(76, 4, 'Station 15', 1, 1, 'Station'),
(77, 5, 'Small Room 1', 2, 4, 'Room'),
(78, 5, 'Small Room 2', 2, 4, 'Room'),
(79, 6, 'Large Table 1', 4, 10, 'Table'),
(80, 6, 'Large Table 2', 4, 10, 'Table'),
(81, 6, 'Large Table 3', 4, 10, 'Table'),
(82, 6, 'Large Table 4', 4, 10, 'Table'),
(83, 6, 'Large Table 5', 4, 10, 'Table'),
(84, 6, 'Large Table 6', 4, 10, 'Table'),
(85, 6, 'Large Table 7', 4, 10, 'Table'),
(86, 6, 'Large Table 8', 4, 10, 'Table'),
(87, 7, 'Small Table 1', 1, 2, 'Table'),
(88, 7, 'Small Table 2', 1, 2, 'Table'),
(89, 7, 'Small Table 3', 1, 2, 'Table'),
(90, 7, 'Small Table 4', 1, 2, 'Table'),
(91, 7, 'Small Table 5', 1, 2, 'Table'),
(92, 7, 'Small Table 6', 1, 2, 'Table'),
(93, 7, 'Small Table 7', 1, 2, 'Table'),
(94, 7, 'Small Table 8', 1, 2, 'Table'),
(95, 7, 'Small Table 9', 1, 2, 'Table'),
(96, 7, 'Small Table 10', 1, 2, 'Table'),
(97, 7, 'Large Table 1', 4, 8, 'Table'),
(98, 7, 'Large Table 2', 4, 8, 'Table'),
(99, 7, 'Large Table 3', 4, 8, 'Table'),
(100, 7, 'Large Table 4', 4, 8, 'Table'),
(101, 7, 'Large Table 5', 4, 8, 'Table'),
(102, 7, 'Medium Room 1', 3, 6, 'Room'),
(103, 7, 'Medium Room 2', 3, 6, 'Room'),
(104, 7, 'Medium Room 3', 3, 6, 'Room'),
(105, 7, 'Medium Room 4', 3, 6, 'Room'),
(106, 7, 'Medium Room 5', 3, 6, 'Room'),
(107, 7, 'Station 1', 1, 1, 'Station'),
(108, 7, 'Station 2', 1, 1, 'Station'),
(109, 7, 'Station 3', 1, 1, 'Station'),
(110, 7, 'Station 4', 1, 1, 'Station'),
(111, 7, 'Station 5', 1, 1, 'Station'),
(112, 7, 'Station 6', 1, 1, 'Station'),
(113, 7, ' Station 7', 1, 1, 'Station'),
(114, 7, 'Station 8', 1, 1, 'Station'),
(115, 7, 'Station 9', 1, 1, 'Station'),
(116, 7, 'Station 10', 1, 1, 'Station'),
(117, 8, 'Station 1', 1, 1, 'Station'),
(118, 8, 'Station 2', 1, 1, 'Station'),
(119, 8, 'Station 3', 1, 1, 'Station'),
(120, 8, 'Station 4', 1, 1, 'Station'),
(121, 8, 'Station 5', 1, 1, 'Station'),
(122, 8, 'Station 6', 1, 1, 'Station'),
(123, 8, 'Station 7', 1, 1, 'Station'),
(124, 8, 'Station 8', 1, 1, 'Station'),
(125, 8, 'Station 9', 1, 1, 'Station'),
(126, 8, 'Station 10', 1, 1, 'Station'),
(127, 9, 'Small Table 1', 2, 4, 'Table'),
(128, 9, 'Small Table 2', 2, 4, 'Table'),
(129, 9, 'Small Table 3', 2, 4, 'Table'),
(130, 9, 'Small Table 4', 2, 4, 'Table'),
(131, 9, 'Small Table 5', 2, 4, 'Table'),
(132, 10, 'Small Room 1', 2, 5, 'Room'),
(133, 10, 'Small Room 2', 2, 5, 'Room');

-- --------------------------------------------------------

--
-- Table structure for table `tblstudyarea`
--

CREATE TABLE `tblstudyarea` (
  `areaID` int(11) NOT NULL,
  `areaName` varchar(50) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblstudyarea`
--

INSERT INTO `tblstudyarea` (`areaID`, `areaName`, `location`) VALUES
(1, 'Espacio', 'Near GLE study area, right of the College Library and clinic'),
(2, 'Learning Patio', 'Near the College Library, extending the RTL study area'),
(3, 'College Library Discussion Room', 'College Library, near the entrance'),
(4, 'College Library LIC', 'College Library, computer lab near the exit'),
(5, 'College Library Collaborative Hub', 'College Library, rooms after LIC'),
(6, 'JHS Library', 'ALLIED Building, 2nd Floor'),
(7, 'SHS Library', 'Beside the Learning Patio'),
(8, 'Wildcats Playlab', 'NGE Building, 1st Floor'),
(9, 'Wildcats Innovation Lab', 'NGE Building, 2nd Floor'),
(10, 'Masscom Lab', 'RTL Building, 4th Floor');

-- --------------------------------------------------------

--
-- Table structure for table `tbluser`
--

CREATE TABLE `tbluser` (
  `userID` int(11) NOT NULL,
  `departmentID` varchar(5) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `blocked_until` datetime DEFAULT NULL,
  `user_type` enum('Patron','Admin') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbluser`
--

INSERT INTO `tbluser` (`userID`, `departmentID`, `firstName`, `lastName`, `email`, `password`, `blocked_until`, `user_type`) VALUES
(112222333, 'CMBA', 'John Francis', 'Rebusit', 'johnfrancis.rebusit@cit.edu', '$2y$10$IxfwqBDZb5S1PzOWSU.f6ei7MVV2r715s2jJmkqxJ8ABwxImhUfpi', NULL, 'Patron'),
(112222444, 'CASE', 'Wild Kitty', 'Pryde', 'wildkittty.pryde@cit.edu', '$2y$10$4la/PEvfSfX1llhjW8Z.0./q0qFJQBPV1wHVdhdLqB43.RMwl1Jd6', NULL, 'Patron'),
(220374211, 'CCS', 'John Lawrence', 'Rebusit', 'juanlorenzo.rebusit@gmail.com', '$2y$10$NJhxq4Ugm11eXyqLJIqzee4w9zEpKHCWOgVJwUx4wUrDFC/w7lc9m', NULL, 'Admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tblarearestrictions`
--
ALTER TABLE `tblarearestrictions`
  ADD PRIMARY KEY (`restrictionID`),
  ADD UNIQUE KEY `areaID` (`areaID`,`departmentID`),
  ADD KEY `departmentID` (`departmentID`);

--
-- Indexes for table `tbldepartment`
--
ALTER TABLE `tbldepartment`
  ADD PRIMARY KEY (`departmentID`);

--
-- Indexes for table `tblreservation`
--
ALTER TABLE `tblreservation`
  ADD PRIMARY KEY (`reservationID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `resourceID` (`resourceID`);

--
-- Indexes for table `tblreservationparticipant`
--
ALTER TABLE `tblreservationparticipant`
  ADD PRIMARY KEY (`participantID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `reservationID` (`reservationID`);

--
-- Indexes for table `tblresource`
--
ALTER TABLE `tblresource`
  ADD PRIMARY KEY (`resourceID`),
  ADD KEY `areaID` (`areaID`);

--
-- Indexes for table `tblstudyarea`
--
ALTER TABLE `tblstudyarea`
  ADD PRIMARY KEY (`areaID`);

--
-- Indexes for table `tbluser`
--
ALTER TABLE `tbluser`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `departmentID` (`departmentID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tblarearestrictions`
--
ALTER TABLE `tblarearestrictions`
  MODIFY `restrictionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `tblreservation`
--
ALTER TABLE `tblreservation`
  MODIFY `reservationID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblreservationparticipant`
--
ALTER TABLE `tblreservationparticipant`
  MODIFY `participantID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblresource`
--
ALTER TABLE `tblresource`
  MODIFY `resourceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- AUTO_INCREMENT for table `tblstudyarea`
--
ALTER TABLE `tblstudyarea`
  MODIFY `areaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblarearestrictions`
--
ALTER TABLE `tblarearestrictions`
  ADD CONSTRAINT `tblarearestrictions_ibfk_1` FOREIGN KEY (`areaID`) REFERENCES `tblstudyarea` (`areaID`),
  ADD CONSTRAINT `tblarearestrictions_ibfk_2` FOREIGN KEY (`departmentID`) REFERENCES `tbldepartment` (`departmentID`);

--
-- Constraints for table `tblreservation`
--
ALTER TABLE `tblreservation`
  ADD CONSTRAINT `tblreservation_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `tbluser` (`userID`),
  ADD CONSTRAINT `tblreservation_ibfk_2` FOREIGN KEY (`resourceID`) REFERENCES `tblresource` (`resourceID`);

--
-- Constraints for table `tblreservationparticipant`
--
ALTER TABLE `tblreservationparticipant`
  ADD CONSTRAINT `tblreservationparticipant_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `tbluser` (`userID`),
  ADD CONSTRAINT `tblreservationparticipant_ibfk_2` FOREIGN KEY (`reservationID`) REFERENCES `tblreservation` (`reservationID`) ON DELETE CASCADE;

--
-- Constraints for table `tblresource`
--
ALTER TABLE `tblresource`
  ADD CONSTRAINT `tblresource_ibfk_1` FOREIGN KEY (`areaID`) REFERENCES `tblstudyarea` (`areaID`);

--
-- Constraints for table `tbluser`
--
ALTER TABLE `tbluser`
  ADD CONSTRAINT `tbluser_ibfk_1` FOREIGN KEY (`departmentID`) REFERENCES `tbldepartment` (`departmentID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
