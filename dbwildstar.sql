-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 10, 2026 at 01:35 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

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
(112222333, 'CCS', 'Test', 'Admin', 'admin@gmail.com', '123', '0000-00-00 00:00:00', 'Admin'),
(445555666, 'CEA', 'Test', 'Patron', 'patron@gmail.com', '456', '0000-00-00 00:00:00', 'Patron');

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
  MODIFY `restrictionID` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `resourceID` int(11) NOT NULL AUTO_INCREMENT;

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
