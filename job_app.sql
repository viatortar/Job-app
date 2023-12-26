-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 26, 2023 at 09:09 AM
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
-- Database: `job_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `lowongan`
--

CREATE TABLE `lowongan` (
  `id` int(11) NOT NULL,
  `posisi` varchar(255) NOT NULL,
  `skill` varchar(255) NOT NULL,
  `jobdesc` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lowongan`
--

INSERT INTO `lowongan` (`id`, `posisi`, `skill`, `jobdesc`) VALUES
(2, 'Cyber Security', 'Linux', 'Security Test'),
(4, 'tetetet', 'bdbdbd', 'dbbdbd'),
(6, 'hjkj', 'jljbl', 'jhjkln'),
(7, 'nkskcn', 'cnsjkscnsj', 'c jsks'),
(8, 'can ccz', 'cnsjcnzkcn', 'cnsjcz'),
(9, 'dvnjkvs', 'vdjsnks', 'nvjdkn'),
(10, 'so support', 'makanm', 'makan makan');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`id`, `nama`, `email`, `password`) VALUES
(1, 'tito', 'tito@gmail.com', '1234567'),
(2, 'toti', '123@gmail.com', '$2y$12$SPyXbdE2Rs37siAa2b7ub.I.Yha0e2vydDASpc.jOwI1SZbOvstAq'),
(3, 'viator', 'viator@look.out.id', '$2y$12$4xH9BpJSl3RToFIMM8e7D.M6n0yVWp6I9jPrUlMHegyOeFOQ4e7V2'),
(4, 'titoo', 'titoo@gmail.com', '$2y$12$qTufq3V29uaP9fZorPZ1hes1TV0Co09BKkdasFEGgZVqgw61VX6qG');

-- --------------------------------------------------------

--
-- Table structure for table `member_token`
--

CREATE TABLE `member_token` (
  `id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `auth_key` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_token`
--

INSERT INTO `member_token` (`id`, `member_id`, `auth_key`) VALUES
(1, 2, 'HFAXoiEy4cxUgf5soL1C1WiJnQrPB0wNE83LmotB9DIhKOrkAlUcZlYN8RPp7wI1nqHxlZW7zvz3ip3KmPSG5eLnDvtkwHVyp6Mi'),
(2, 2, 'cyJUBcPGaNeJEvGxDR1UFmp25n7F0xAybjtNi0HsZJSIjNcaP1Sjpy8fExkknkTeatiXoGCXYiEeLCBtP5qnJ0lPsTRNnRl9tIN9'),
(3, 3, 'Sh6B5yk14byAb0RuwATLYZWlDNdzbttAoIYcms2giWW9WGQb2uMKnArYI95G4U4z23QjagXRILdz0Zx29ffF1fH6NjrMNDnKxims'),
(4, 3, 'vKIBPFaqArvelNmbr6DOtbOLTjhUeLNL2HGghHjgevLLcACehgpUCkMuWsaS4qilkfalbzsWMUIf1Tu7LlININGRC6dybhk5YKIf'),
(5, 4, 'uSgNVtSOSDmY99ms9DG4kc28LlBSfGweb153QYPl09E0c6XQhksHiZhZl8HmA6MrQH11XWcWPZHd6rE4a7myl6nZfDHGqEOIdKEv'),
(6, 4, 'TapoNmH57lcafWFdwflMs5o4Qfk7lFOuMXi7rpjpi3tXiK6JmrhuD2V5D9kbaLhaHQRBU3BP0xLspYhRMwymewgvHKrAcrDYWo1q');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `lowongan`
--
ALTER TABLE `lowongan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_token`
--
ALTER TABLE `member_token`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `lowongan`
--
ALTER TABLE `lowongan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `member_token`
--
ALTER TABLE `member_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `member_token`
--
ALTER TABLE `member_token`
  ADD CONSTRAINT `member_token_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
