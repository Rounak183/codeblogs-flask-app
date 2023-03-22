-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 22, 2023 at 08:08 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codeblogs`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone_num` varchar(15) NOT NULL,
  `msg` varchar(50) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `phone_num`, `msg`, `date`, `email`) VALUES
(4, 'Test', '123', 'Hi', '2023-03-21 12:36:15', 'ts@123.com'),
(5, 'ROUNAK SARAF', '9354570424', 'HI', '2023-03-21 12:46:37', 'rounaksaraf.official@gmail.com'),
(6, 'Testing aga', '12341', 'Dekho mera message', '2023-03-21 12:48:14', 'ts@2.com'),
(7, 'ROUNAK SARAF', '9354570424', 'This should go in mail.', '2023-03-21 13:26:55', 'rounaksaraf.official@gmail.com'),
(8, 'ROUNAK SARAF', '9354570424', 'This should go in mail.', '2023-03-21 13:30:32', 'rounak18183@iiitd.ac.in'),
(9, 'ROUNAK SARAF', '9354570424', 'This should go in mail.', '2023-03-21 13:31:08', 'rounak18183@iiitd.ac.in'),
(10, 'ROUNAK SARAF', '9354570424', 'This should go in mail.', '2023-03-21 13:31:20', 'rounak18183@iiitd.ac.in'),
(11, 'ROUNAK SARAF', '9354570424', 'This should go in mail.', '2023-03-21 13:33:30', 'rounak@iiitd.ac.in'),
(12, 'ROUNAK SARAF', '9354570424', 'This should go in mail.', '2023-03-21 13:34:12', 'rounak@iiitd.ac.in'),
(13, 'ROUNAK SARAF', '9354570424', 'This should go in mail.', '2023-03-21 13:34:30', 'rounak@iiitd.ac.in'),
(14, 'ROUNAK SARAF', '9354570424', 'This should go in mail.', '2023-03-21 13:38:13', 'rounakcodeforces@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `tagline` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `content` varchar(5000) NOT NULL,
  `img_filename` varchar(50) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `img_filename`, `date`) VALUES
(1, 'A Brief About Stocks ', 'What are stocks? A deep dive', 'first-post', 'A stock represents fractional ownership of equity in an organization. It is different from a bond, which operates like a loan made by creditors to the company in return for periodic payments. A company issues stock to raise capital from investors for new projects or to expand its business operations.', 'first-post.jpg', '2023-03-22 19:28:37'),
(3, 'Features of ChatGPT', 'All about the powerful features of ChatGPT', 'second-post', 'Features of ChatGPT\r\nWhat makes ChatGPT stand out from other AIs?\r\n\r\n1. Human-like Text- With its Natural Language Processing program, ChatGPT can be used to produce text that appears human. When a user interacts with this AI, they wouldn’t know whether a human is behind that or an AI.\r\n\r\n2. Interactive Responses- Because it works on Reinforcement Learning with the Human Feedback model, it can generate responses interactively. This feature makes it inherently unique as it will constantly evolve and adapt as per the feedback provided and make it an application that will create long-lasting users.\r\n\r\n3. Translation of Texts- There are over 7000 languages in the world, and though English is the most widely used, this application can be used for translating texts. With the technology constantly evolving, ChatGPT can be used to translate text from one language to another, making it easier for its users.\r\n\r\n4. Summarisation- People are really busy these days and don’t have time to read 10 pages long reports; thus, it can be used for summarising long texts. This would simplify a person’s work and save time.\r\n\r\n5. Personalized Content- With its advancement in machine learning algorithms, it can provide accurate and customized answers for a user leading to increased user engagement and conversions for businesses.', 'second-post.jpg', '2023-03-22 19:33:13'),
(6, 'Insight by GPT-4 on the Job Market', 'Impact of GPT-4 on the Indian job market', 'third-post', 'Now, let’s read the insights shared by ChatGPT.\n\nTalking about potential job loss, the AI bot said that “ChatGPT and similar Al technologies have the potential to automate certain tasks that previously required human intervention, particularly in customer service, content creation, and data analysis. This could potentially lead to job displacement in these sectors\".', 'third-post.jpg', '2023-03-22 15:24:54'),
(8, 'Bootstrap Alpha Release', 'Features of the new Bootstrap alpha release', 'fourth-post', 'It’s a Christmas miracle—Bootstrap v5.3.0-alpha1 has arrived just in time for the holiday break! This release brings new color mode support, an expanded color palette with variables and utilities, and more.\r\n\r\nWe’re keeping things short and simple in this blog post with deeper dives into the new color modes and more coming in future posts. For now, we want you to enjoy the holiday break and come back next year feeling refreshed and rejuvenated. Keep reading for what’s new and we’ll see you next year!', 'fourth-post.jpg', '2023-03-22 20:58:49');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
