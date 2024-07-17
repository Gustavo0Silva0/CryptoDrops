-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 17-Jul-2024 às 10:35
-- Versão do servidor: 5.5.62-log
-- versão do PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `barrycoin`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `games`
--

CREATE TABLE `games` (
  `game_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `power_ghs` decimal(20,8) NOT NULL,
  `duration_hours` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `mining_machines`
--

CREATE TABLE `mining_machines` (
  `machine_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `power_gps` decimal(10,2) NOT NULL,
  `image_path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `mining_rewards`
--

CREATE TABLE `mining_rewards` (
  `user_id` int(11) NOT NULL,
  `reward` decimal(10,8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `network_power`
--

CREATE TABLE `network_power` (
  `user_id` int(11) NOT NULL,
  `power_ghs` decimal(20,8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `offerwall`
--

CREATE TABLE `offerwall` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `api` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `shop_miners`
--

CREATE TABLE `shop_miners` (
  `id` int(11) NOT NULL,
  `miner_name` varchar(50) NOT NULL,
  `mining_power` decimal(10,2) NOT NULL,
  `daily_reward` decimal(16,8) NOT NULL,
  `cost` decimal(16,8) NOT NULL,
  `image_path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `shop_miners`
--

INSERT INTO `shop_miners` (`id`, `miner_name`, `mining_power`, `daily_reward`, `cost`, `image_path`) VALUES
(1, 'Miner 1', '0.50', '0.00002800', '0.00500000', '/www/wwwroot/mining.cryptodrops.click/mining.gif'),
(2, 'Miner 2', '1.00', '0.00005600', '0.00950000', '/www/wwwroot/mining.cryptodrops.click/mining.gif'),
(3, 'Miner 3', '5.00', '0.00027500', '0.04750000', '/www/wwwroot/mining.cryptodrops.click/mining.png');

-- --------------------------------------------------------

--
-- Estrutura da tabela `shortlinks`
--

CREATE TABLE `shortlinks` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `reward` decimal(10,8) NOT NULL,
  `daily_limit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `shortlinks`
--

INSERT INTO `shortlinks` (`id`, `name`, `reward`, `daily_limit`) VALUES
(1, 'BarryShort', '0.00010000', 10);

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `inviter_reference` varchar(50) DEFAULT NULL,
  `deposit_balance` decimal(16,8) DEFAULT '0.00000000',
  `withdrawal_balance` decimal(16,8) DEFAULT '0.00000000',
  `faucetpay_email` varchar(255) DEFAULT NULL,
  `active_miners_count` int(11) DEFAULT '0',
  `total_miner_earnings` decimal(16,8) DEFAULT '0.00000000',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `inviter_reference`, `deposit_balance`, `withdrawal_balance`, `faucetpay_email`, `active_miners_count`, `total_miner_earnings`, `created_at`) VALUES
(1, 'ElonMuskBR', 'conta.de.app01@gmail.com', '$2y$10$XW.re6vSgCVAAmDpXiwV/.ZALrEaMf6QdPPTGKUd3BTruSCdj8vbm', NULL, '0.06210000', '0.00058800', 'conta.de.app01@gmail.com', -2, '0.00058800', '2024-07-08 18:42:41'),
(2, 'ZOROSCRIPTS', 'craftff947@gmail.com', '$2y$10$IxBI4Y8UZE7530rULHWjxus0HN55BOLgxcL5qzNo3N0uam.nBTebC', NULL, '0.00000000', '0.00000000', NULL, 0, '0.00000000', '2024-07-09 17:56:02'),
(3, 'WhiteLittle', 'whitelittle321@gmail.com', '$2y$10$OMXJfGjKFoMvh2FijRaDk.ev953wvx5SwEsFY3wkeNLAODkD.bsJi', NULL, '0.00000000', '0.00000000', NULL, 0, '0.00000000', '2024-07-11 22:03:35'),
(6, 'ElonMuskBR2', 'conta.de.app02@gmail.com', '$2y$10$vH.J65SXQZXG58feV93bWORDVVZZzJlqr/9umpTkD26yYdyZLv7LG', NULL, '0.00000000', '0.00000000', NULL, 0, '0.00000000', '2024-07-13 18:05:25'),
(7, 'MitoBR', 'rogerio.imai@hotmail.com', '$2y$10$txGgIEAgQOXmF/cjpdw4W.sHlUD0N8AKotmioPLJwKnOldBLaX0u2', NULL, '0.00050000', '0.00000000', NULL, 1, '0.00000000', '2024-07-14 03:59:52'),
(8, 'Samba', 'firsttestec@gmail.com', '$2y$10$dSIJF9LInTRG45XansUv9OKHy2hZVopSlqPoZdxk0N3At3DT8GZDC', NULL, '0.00000000', '0.00000000', NULL, 0, '0.00000000', '2024-07-14 07:07:19'),
(9, 'joaosousa', 'oficialkikolms123@gmail.com', '$2y$10$axlFzrAuiNCMefa6ZvVGvOvww8iC6tKhyVLZXTYsIXaYACkwPnfPG', NULL, '0.00000000', '0.00000000', NULL, 0, '0.00000000', '2024-07-14 17:10:14'),
(10, 'Lima3225', '1mauro3225@gmail.com', '$2y$10$g.qQgll84ZSH/nPhsMOuSe1D1jbHZ8GEudGqRYYkfky6kUjSQxhe2', NULL, '0.03050000', '0.00033600', NULL, 3, '0.00033600', '2024-07-14 17:40:08'),
(11, 'Davi', 'qdavi400@gmail.com', '$2y$10$gbAyAegjRyvtC.aWe52ovu8FOchkkRIQKoG4XOzjOv17BoE4o26J.', NULL, '0.00662000', '0.00005600', 'qdavi400@gmail.com', 1, '0.00008400', '2024-07-14 18:14:38'),
(12, 'Revil', 'leorionsnak@gmail.com', '$2y$10$aoHKtQsGvoV7n3p61TL6X.AMpTeL5esDq6kGnHS5YKL1N3rX6f.5K', NULL, '0.04110000', '0.00000000', NULL, 0, '0.00000000', '2024-07-14 18:16:16'),
(13, 'deerb767', 'matheusmillian22@gmail.com', '$2y$10$nBt0L96lu4XcFim/ZYxaRuggV/BXVS7Mu7ok0.4EuogGmQGIsrVb2', NULL, '0.00000000', '0.00000000', NULL, 0, '0.00000000', '2024-07-14 18:22:26'),
(14, '1234', '1234@gmail.com', '$2y$10$vTJH7uwcgPZL8Jy09AUciuVBRjScHOXuq8/jGFhVNPHGEjCGjdLye', NULL, '0.00010000', '0.00000000', NULL, 0, '0.00000000', '2024-07-14 18:24:55'),
(15, 'Jessyecarol', 'mmaricardi3025@gmail.com', '$2y$10$9OOJDvjMaN96wKcL8T/6oOIMC7d2Iq.i7vcU1/.J4wsyBVvh2lKGe', NULL, '0.00060000', '0.00025200', 'alntxu144@gmail.com', 2, '0.00025200', '2024-07-14 18:31:43'),
(16, 'naty1001', 'natielyoliveira88@gmail.com', '$2y$10$igUx7n3ldP6YTENGuSPD7eZ60uIt8KATLfEZWtzfiSDgB9cDgEtxa', NULL, '0.00100000', '0.00000000', NULL, 0, '0.00000000', '2024-07-14 19:42:28'),
(17, 'Cydal', 'ggfjfj@gmail.com', '$2y$10$xP/B/vn2CwJD1ChizBAgned.C5mrG1FHFFOGgqvtiey/kZGJbW.hm', NULL, '0.00000000', '0.00000000', NULL, 0, '0.00000000', '2024-07-14 20:23:15'),
(18, 'breaking49', 'ednasouzar@gmail.com', '$2y$10$kLgAA/2qIwqwoAE8WxJhleLoQisVPqWLGdaVC7I9SDAk2jVELqQnu', NULL, '0.00110000', '0.00000000', NULL, 0, '0.00000000', '2024-07-14 21:41:42'),
(19, 'cybermetroid', 'williamribeirobarbosa@gmail.com', '$2y$10$/6/2k4XMl3gBdo59/evWfeNdqJBy7uJRcTrnEJG8CLTbPVU9HjOSe', NULL, '0.00010000', '0.00000000', NULL, 0, '0.00000000', '2024-07-14 21:45:48'),
(20, 'SoftPog', 'contato@softpog.com.br', '$2y$10$x2tORSAKcYXrDH.WffnCieyV8WS/7dMGqPo4MKddl8VE5LOtrn3XG', NULL, '0.00060000', '0.00000000', 'doughann@gmail.com', 0, '0.00000000', '2024-07-14 22:48:23'),
(21, 'stonkz', 'lkauet35@gmail.com', '$2y$10$TxJgrotSCN4.m/NyEk/ARe26yOtwxxduPszisree6/HMj8NV0UXv.', NULL, '0.00010000', '0.00000000', NULL, 0, '0.00000000', '2024-07-14 23:27:36'),
(22, 'Onton', '0nb4k1@gmail.com', '$2y$10$Xy.7QzOAnkmuHuoQp9xs8OgY6r1zUsLN2O20ROhnakSAyS14IoUG.', NULL, '0.00020000', '0.00000000', NULL, 0, '0.00000000', '2024-07-14 23:48:29'),
(23, 'luan8628', 'lrluanzin5@gmail.com', '$2y$10$mcmxyxuyhGiHX/HbH4863eUcE5wEwDM9sijB2twtFI0w66c7jDUQW', NULL, '0.00480000', '0.00000000', 'lrluanzin5@gmail.com', 0, '0.00000000', '2024-07-15 01:04:55'),
(24, 'Savinho7', 'saviorodrigues640@gmail.com', '$2y$10$yY0x03iwItSv9vwuk.ics..Kw1tveDt50XwPAJvkItbuZsCjEq0IO', NULL, '0.00060000', '0.00000000', NULL, 0, '0.00000000', '2024-07-15 03:59:49'),
(25, 'leozin14', 'alvesleonardo573@hotmail.com', '$2y$10$Grwg2cyd7Pg6E.dezX0gqOccPraIBbJmp.JFdyFjC8rYYFVAqT/fC', NULL, '0.00000000', '0.00000000', NULL, 0, '0.00000000', '2024-07-15 05:15:56'),
(26, 'leodutram', 'leonardo.dmartins1@gmail.com', '$2y$10$AEwU9yCcElv9bVWXHUzZneNqqfAnBCxP2g6KZryxRAJ1IrOIJ4/h2', NULL, '0.00040000', '0.00000000', NULL, 0, '0.00000000', '2024-07-15 10:48:45'),
(27, 'Thiangcbh', 'trivagho456@gmail.com', '$2y$10$58/ImtAFh/k9D3J9zRGhDORQL.J/7n3hQPfgCO.Y57nKb46dkUGay', NULL, '0.00050000', '0.00000000', NULL, 0, '0.00000000', '2024-07-15 19:14:50'),
(28, 'Dudufelix', 'luizeduardo8892@gmail.com', '$2y$10$wKPwKW4CD6AsOf3mSLuP2OzdCTxQbq2jPbK4GwQC9b7ahgpZIm7we', NULL, '0.00230000', '0.00000000', 'luizeduardo8892@gmail.com', 0, '0.00000000', '2024-07-16 06:08:12'),
(29, 'onthe', 'basilio28g@gmail.com', '$2y$10$4WMGviVjbIgII3ljYXWoF.6UYju4jM3Oh6.AHaADiZJle1nOhvQEK', NULL, '0.00030000', '0.00000000', NULL, 0, '0.00000000', '2024-07-16 15:35:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_faucet`
--

CREATE TABLE `user_faucet` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `claimed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `user_faucet`
--

INSERT INTO `user_faucet` (`id`, `user_id`, `claimed_at`) VALUES
(1, 1, '2024-07-13 03:03:30'),
(2, 1, '2024-07-13 14:31:11'),
(3, 1, '2024-07-14 00:42:10'),
(4, 1, '2024-07-14 20:01:24'),
(5, 1, '2024-07-14 20:01:28'),
(6, 1, '2024-07-14 20:01:33'),
(7, 1, '2024-07-14 20:01:41'),
(8, 1, '2024-07-14 20:01:50'),
(9, 1, '2024-07-14 20:02:02'),
(10, 1, '2024-07-14 20:02:12'),
(11, 1, '2024-07-14 20:02:15'),
(12, 1, '2024-07-14 20:02:16'),
(13, 1, '2024-07-14 20:02:17'),
(14, 1, '2024-07-14 20:02:18'),
(15, 1, '2024-07-14 20:02:18'),
(16, 1, '2024-07-14 20:02:19'),
(17, 1, '2024-07-14 20:02:20'),
(18, 1, '2024-07-14 20:02:30'),
(19, 1, '2024-07-14 20:02:31'),
(20, 1, '2024-07-14 20:03:02'),
(21, 1, '2024-07-14 20:03:04'),
(22, 1, '2024-07-14 20:03:04'),
(23, 1, '2024-07-14 20:03:05'),
(24, 1, '2024-07-14 20:03:06'),
(25, 1, '2024-07-14 20:03:07'),
(26, 1, '2024-07-14 20:03:08'),
(27, 1, '2024-07-14 20:03:09'),
(28, 1, '2024-07-14 20:03:10'),
(29, 1, '2024-07-14 20:03:10'),
(30, 1, '2024-07-14 20:03:12'),
(31, 1, '2024-07-14 20:03:13'),
(32, 1, '2024-07-14 20:03:14'),
(33, 1, '2024-07-14 20:03:15'),
(34, 1, '2024-07-14 20:03:16'),
(35, 1, '2024-07-14 20:03:17'),
(36, 1, '2024-07-14 20:03:19'),
(37, 1, '2024-07-14 20:03:20'),
(38, 1, '2024-07-14 20:03:20'),
(39, 1, '2024-07-14 20:03:21'),
(40, 1, '2024-07-14 20:03:25'),
(41, 1, '2024-07-14 20:03:26'),
(42, 1, '2024-07-14 20:03:27'),
(43, 1, '2024-07-14 20:03:28'),
(44, 1, '2024-07-14 20:03:29'),
(45, 1, '2024-07-14 20:03:30'),
(46, 1, '2024-07-14 20:03:32'),
(47, 1, '2024-07-14 20:03:32'),
(48, 1, '2024-07-14 20:03:34'),
(49, 1, '2024-07-14 20:03:34'),
(50, 1, '2024-07-14 20:13:57'),
(51, 1, '2024-07-14 20:14:01'),
(52, 1, '2024-07-14 20:14:02'),
(53, 1, '2024-07-14 20:14:03'),
(54, 1, '2024-07-14 20:14:04'),
(55, 1, '2024-07-14 20:14:05'),
(56, 1, '2024-07-14 20:14:06'),
(57, 1, '2024-07-14 20:14:07'),
(58, 1, '2024-07-14 20:14:08'),
(59, 1, '2024-07-14 20:14:09'),
(60, 1, '2024-07-14 20:14:11'),
(61, 1, '2024-07-14 20:14:11'),
(62, 1, '2024-07-14 20:14:12'),
(63, 1, '2024-07-14 20:14:13'),
(64, 1, '2024-07-14 20:14:14'),
(65, 1, '2024-07-14 20:14:14'),
(66, 1, '2024-07-14 20:14:15'),
(67, 1, '2024-07-14 20:14:15'),
(68, 1, '2024-07-14 20:14:16'),
(69, 1, '2024-07-14 20:14:17'),
(70, 1, '2024-07-14 20:14:23'),
(71, 1, '2024-07-14 20:14:24'),
(72, 1, '2024-07-14 20:14:24'),
(73, 1, '2024-07-14 20:14:25'),
(74, 1, '2024-07-14 20:14:25'),
(75, 1, '2024-07-14 20:14:26'),
(76, 1, '2024-07-14 20:14:27'),
(77, 1, '2024-07-14 20:14:27'),
(78, 1, '2024-07-14 20:14:28'),
(79, 1, '2024-07-14 20:14:29'),
(80, 1, '2024-07-14 20:19:40'),
(81, 1, '2024-07-14 20:19:40'),
(82, 1, '2024-07-14 20:19:41'),
(83, 1, '2024-07-14 20:19:42'),
(84, 1, '2024-07-14 20:19:42'),
(85, 1, '2024-07-14 20:19:43'),
(86, 1, '2024-07-14 20:19:44'),
(87, 1, '2024-07-14 20:19:44'),
(88, 1, '2024-07-14 20:19:45'),
(89, 1, '2024-07-14 20:19:45'),
(90, 1, '2024-07-14 20:21:19'),
(91, 1, '2024-07-14 20:21:20'),
(92, 1, '2024-07-14 20:21:20'),
(93, 1, '2024-07-14 20:21:22'),
(94, 1, '2024-07-14 20:21:23'),
(95, 11, '2024-07-14 20:21:23'),
(96, 1, '2024-07-14 20:21:23'),
(97, 11, '2024-07-14 20:21:24'),
(98, 1, '2024-07-14 20:21:24'),
(99, 11, '2024-07-14 20:21:24'),
(100, 1, '2024-07-14 20:21:25'),
(101, 11, '2024-07-14 20:21:25'),
(102, 11, '2024-07-14 20:21:25'),
(103, 1, '2024-07-14 20:21:25'),
(104, 11, '2024-07-14 20:21:26'),
(105, 1, '2024-07-14 20:21:26'),
(106, 11, '2024-07-14 20:21:27'),
(107, 11, '2024-07-14 20:21:28'),
(108, 11, '2024-07-14 20:21:29'),
(109, 11, '2024-07-14 20:21:29'),
(110, 11, '2024-07-14 20:21:31'),
(111, 11, '2024-07-14 20:21:32'),
(112, 11, '2024-07-14 20:21:32'),
(113, 11, '2024-07-14 20:21:34'),
(114, 11, '2024-07-14 20:21:34'),
(115, 11, '2024-07-14 20:21:41'),
(116, 11, '2024-07-14 20:21:42'),
(117, 11, '2024-07-14 20:21:42'),
(118, 11, '2024-07-14 20:21:43'),
(119, 11, '2024-07-14 20:21:43'),
(120, 11, '2024-07-14 20:21:44'),
(121, 11, '2024-07-14 20:21:45'),
(122, 11, '2024-07-14 20:21:45'),
(123, 11, '2024-07-14 20:21:46'),
(124, 11, '2024-07-14 20:21:47'),
(125, 11, '2024-07-14 20:21:49'),
(126, 11, '2024-07-14 20:21:50'),
(127, 1, '2024-07-14 20:21:53'),
(128, 1, '2024-07-14 20:21:54'),
(129, 1, '2024-07-14 20:21:54'),
(130, 1, '2024-07-14 20:21:55'),
(131, 1, '2024-07-14 20:21:56'),
(132, 1, '2024-07-14 20:21:57'),
(133, 1, '2024-07-14 20:21:57'),
(134, 1, '2024-07-14 20:21:58'),
(135, 1, '2024-07-14 20:21:59'),
(136, 1, '2024-07-14 20:21:59'),
(137, 1, '2024-07-14 20:22:02'),
(138, 1, '2024-07-14 20:22:03'),
(139, 1, '2024-07-14 20:22:03'),
(140, 1, '2024-07-14 20:22:04'),
(141, 1, '2024-07-14 20:22:05'),
(142, 1, '2024-07-14 20:22:05'),
(143, 1, '2024-07-14 20:22:06'),
(144, 1, '2024-07-14 20:22:07'),
(145, 1, '2024-07-14 20:32:59'),
(146, 18, '2024-07-14 21:45:36'),
(147, 15, '2024-07-14 21:46:29'),
(148, 19, '2024-07-14 21:47:06'),
(149, 12, '2024-07-14 22:37:45'),
(150, 20, '2024-07-14 22:51:34'),
(151, 21, '2024-07-14 23:28:07'),
(152, 11, '2024-07-14 23:50:33'),
(153, 22, '2024-07-14 23:54:09'),
(154, 11, '2024-07-15 00:17:49'),
(155, 23, '2024-07-15 01:05:12'),
(156, 23, '2024-07-15 01:17:13'),
(157, 24, '2024-07-15 04:00:28'),
(158, 22, '2024-07-15 05:33:33'),
(159, 7, '2024-07-15 07:49:38'),
(160, 26, '2024-07-15 10:49:23'),
(161, 20, '2024-07-15 13:10:14'),
(162, 11, '2024-07-15 13:45:31'),
(163, 7, '2024-07-15 16:45:44'),
(164, 7, '2024-07-15 17:03:00'),
(165, 26, '2024-07-15 17:22:28'),
(166, 27, '2024-07-15 19:15:11'),
(167, 11, '2024-07-15 20:05:26'),
(168, 11, '2024-07-15 20:37:14'),
(169, 7, '2024-07-15 20:51:41'),
(170, 23, '2024-07-15 21:11:51'),
(171, 23, '2024-07-15 21:42:13'),
(172, 23, '2024-07-15 22:06:49'),
(173, 23, '2024-07-15 22:18:37'),
(174, 7, '2024-07-15 23:04:13'),
(175, 11, '2024-07-15 23:10:22'),
(176, 7, '2024-07-15 23:19:42'),
(177, 7, '2024-07-15 23:52:23'),
(178, 7, '2024-07-16 00:17:08'),
(179, 23, '2024-07-16 00:38:07'),
(180, 7, '2024-07-16 00:38:30'),
(181, 7, '2024-07-16 00:49:45'),
(182, 23, '2024-07-16 01:00:22'),
(183, 7, '2024-07-16 01:05:23'),
(184, 7, '2024-07-16 01:18:33'),
(185, 23, '2024-07-16 01:21:52'),
(186, 23, '2024-07-16 01:34:54'),
(187, 7, '2024-07-16 01:58:39'),
(188, 7, '2024-07-16 02:17:32'),
(189, 7, '2024-07-16 02:27:46'),
(190, 7, '2024-07-16 02:48:19'),
(191, 7, '2024-07-16 02:59:21'),
(192, 7, '2024-07-16 03:31:01'),
(193, 7, '2024-07-16 04:12:27'),
(194, 20, '2024-07-16 06:05:34'),
(195, 28, '2024-07-16 06:17:35'),
(196, 7, '2024-07-16 11:24:47'),
(197, 27, '2024-07-16 11:38:58'),
(198, 7, '2024-07-16 13:02:36'),
(199, 7, '2024-07-16 13:18:18'),
(200, 7, '2024-07-16 13:35:46'),
(201, 29, '2024-07-16 15:35:24'),
(202, 11, '2024-07-16 16:56:46'),
(203, 7, '2024-07-16 17:20:40'),
(204, 7, '2024-07-16 18:33:13'),
(205, 7, '2024-07-16 19:00:09'),
(206, 7, '2024-07-16 19:20:52'),
(207, 7, '2024-07-16 19:49:43'),
(208, 7, '2024-07-16 20:35:36'),
(209, 7, '2024-07-16 21:31:46'),
(210, 7, '2024-07-16 22:25:38'),
(211, 11, '2024-07-16 22:28:47'),
(212, 7, '2024-07-16 23:05:33'),
(213, 28, '2024-07-17 00:34:17'),
(214, 28, '2024-07-17 00:45:38'),
(215, 7, '2024-07-17 00:55:25'),
(216, 23, '2024-07-17 00:58:33'),
(217, 23, '2024-07-17 01:13:30'),
(218, 23, '2024-07-17 01:25:57'),
(219, 23, '2024-07-17 01:36:26'),
(220, 23, '2024-07-17 01:47:47'),
(221, 7, '2024-07-17 01:51:38'),
(222, 23, '2024-07-17 02:01:06'),
(223, 23, '2024-07-17 02:12:10'),
(224, 7, '2024-07-17 02:14:39'),
(225, 23, '2024-07-17 02:22:17');

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_games`
--

CREATE TABLE `user_games` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_miners`
--

CREATE TABLE `user_miners` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `miner_id` int(11) NOT NULL,
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `user_miners`
--

INSERT INTO `user_miners` (`id`, `user_id`, `miner_id`, `start_date`, `active`) VALUES
(1, 1, 3, '2024-07-10 21:00:00', 0),
(2, 1, 2, '2024-07-10 21:00:00', 1),
(3, 1, 1, '2024-07-14 21:00:00', 1),
(4, 11, 3, '2024-07-14 21:00:00', 0),
(5, 11, 3, '2024-07-14 21:00:00', 0),
(6, 11, 1, '2024-07-14 21:00:00', 1),
(7, 1, 3, '2024-07-14 21:00:00', 0),
(8, 1, 2, '2024-07-14 21:00:00', 1),
(9, 1, 3, '2024-07-14 21:00:00', 0),
(10, 1, 2, '2024-07-14 21:00:00', 1),
(11, 15, 3, '2024-07-14 21:00:00', 0),
(12, 15, 3, '2024-07-14 21:00:00', 0),
(13, 10, 1, '2024-07-14 21:00:00', 1),
(14, 15, 2, '2024-07-14 21:00:00', 1),
(15, 10, 1, '2024-07-14 21:00:00', 1),
(16, 10, 2, '2024-07-14 21:00:00', 1),
(17, 15, 1, '2024-07-14 21:00:00', 1),
(18, 7, 1, '2024-07-16 21:00:00', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_shortlinks`
--

CREATE TABLE `user_shortlinks` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `shortlink_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `user_shortlinks`
--

INSERT INTO `user_shortlinks` (`id`, `user_id`, `shortlink_id`, `timestamp`) VALUES
(1, 1, 1, '2024-07-14 19:07:48'),
(2, 1, 1, '2024-07-14 19:23:59'),
(3, 1, 1, '2024-07-14 19:32:36'),
(4, 11, 1, '2024-07-14 19:39:50'),
(5, 11, 1, '2024-07-14 19:40:47'),
(6, 11, 1, '2024-07-14 19:41:09'),
(7, 11, 1, '2024-07-14 19:41:30'),
(8, 11, 1, '2024-07-14 19:41:51'),
(9, 11, 1, '2024-07-14 19:42:14'),
(10, 11, 1, '2024-07-14 19:42:37'),
(11, 11, 1, '2024-07-14 19:42:58'),
(12, 11, 1, '2024-07-14 19:43:21'),
(13, 11, 1, '2024-07-14 19:43:41'),
(14, 16, 1, '2024-07-14 19:45:24'),
(15, 16, 1, '2024-07-14 19:46:23'),
(16, 16, 1, '2024-07-14 19:47:01'),
(17, 16, 1, '2024-07-14 19:47:34'),
(18, 16, 1, '2024-07-14 19:48:14'),
(19, 16, 1, '2024-07-14 19:48:42'),
(20, 16, 1, '2024-07-14 19:49:10'),
(21, 16, 1, '2024-07-14 19:49:39'),
(22, 16, 1, '2024-07-14 19:50:05'),
(23, 16, 1, '2024-07-14 19:50:32'),
(24, 18, 1, '2024-07-14 21:42:51'),
(25, 18, 1, '2024-07-14 21:43:22'),
(26, 18, 1, '2024-07-14 21:44:01'),
(27, 18, 1, '2024-07-14 21:44:23'),
(28, 18, 1, '2024-07-14 21:44:52'),
(29, 18, 1, '2024-07-14 21:44:57'),
(30, 18, 1, '2024-07-14 21:45:01'),
(31, 18, 1, '2024-07-14 21:45:04'),
(32, 18, 1, '2024-07-14 21:45:07'),
(33, 18, 1, '2024-07-14 21:45:28'),
(34, 12, 1, '2024-07-14 22:32:24'),
(35, 12, 1, '2024-07-14 22:32:50'),
(36, 12, 1, '2024-07-14 22:33:21'),
(37, 12, 1, '2024-07-14 22:34:15'),
(38, 12, 1, '2024-07-14 22:34:38'),
(39, 12, 1, '2024-07-14 22:35:18'),
(40, 12, 1, '2024-07-14 22:35:41'),
(41, 12, 1, '2024-07-14 22:36:04'),
(42, 12, 1, '2024-07-14 22:36:26'),
(43, 12, 1, '2024-07-14 22:36:51'),
(44, 11, 1, '2024-07-14 23:47:10'),
(45, 11, 1, '2024-07-14 23:47:31'),
(46, 11, 1, '2024-07-14 23:47:53'),
(47, 11, 1, '2024-07-14 23:48:14'),
(48, 11, 1, '2024-07-14 23:48:35'),
(49, 11, 1, '2024-07-14 23:48:58'),
(50, 11, 1, '2024-07-14 23:49:19'),
(51, 11, 1, '2024-07-14 23:49:40'),
(52, 11, 1, '2024-07-14 23:50:02'),
(53, 11, 1, '2024-07-14 23:50:23'),
(54, 23, 1, '2024-07-15 01:06:51'),
(55, 23, 1, '2024-07-15 01:07:36'),
(56, 23, 1, '2024-07-15 01:07:38'),
(57, 23, 1, '2024-07-15 01:08:09'),
(58, 23, 1, '2024-07-15 01:08:18'),
(59, 23, 1, '2024-07-15 01:08:50'),
(60, 23, 1, '2024-07-15 01:09:30'),
(61, 23, 1, '2024-07-15 01:10:10'),
(62, 23, 1, '2024-07-15 01:11:51'),
(63, 23, 1, '2024-07-15 01:12:42'),
(64, 24, 1, '2024-07-15 04:01:46'),
(65, 24, 1, '2024-07-15 04:02:55'),
(66, 24, 1, '2024-07-15 04:04:16'),
(67, 24, 1, '2024-07-15 04:04:42'),
(68, 24, 1, '2024-07-15 04:07:30'),
(69, 7, 1, '2024-07-15 07:51:24'),
(70, 7, 1, '2024-07-15 07:51:51'),
(71, 7, 1, '2024-07-15 07:52:16'),
(72, 7, 1, '2024-07-15 07:52:39'),
(73, 7, 1, '2024-07-15 07:53:00'),
(74, 7, 1, '2024-07-15 07:53:22'),
(75, 7, 1, '2024-07-15 07:53:43'),
(76, 7, 1, '2024-07-15 07:54:06'),
(77, 7, 1, '2024-07-15 07:55:03'),
(78, 7, 1, '2024-07-15 07:55:28'),
(79, 20, 1, '2024-07-15 13:12:03'),
(80, 20, 1, '2024-07-15 13:12:59'),
(81, 20, 1, '2024-07-15 13:13:05'),
(82, 26, 1, '2024-07-15 17:23:41'),
(83, 26, 1, '2024-07-15 17:24:22'),
(84, 27, 1, '2024-07-15 19:16:31'),
(85, 27, 1, '2024-07-15 19:17:07'),
(86, 27, 1, '2024-07-15 19:17:33'),
(87, 23, 1, '2024-07-15 21:12:45'),
(88, 23, 1, '2024-07-15 21:14:08'),
(89, 23, 1, '2024-07-15 21:20:31'),
(90, 23, 1, '2024-07-15 21:21:47'),
(91, 23, 1, '2024-07-15 21:23:01'),
(92, 23, 1, '2024-07-15 21:23:29'),
(93, 23, 1, '2024-07-15 21:24:02'),
(94, 23, 1, '2024-07-15 21:26:41'),
(95, 23, 1, '2024-07-15 21:27:42'),
(96, 23, 1, '2024-07-15 21:28:12'),
(97, 7, 1, '2024-07-15 23:20:19'),
(98, 7, 1, '2024-07-15 23:20:44'),
(99, 7, 1, '2024-07-15 23:21:29'),
(100, 7, 1, '2024-07-15 23:21:50'),
(101, 7, 1, '2024-07-15 23:22:11'),
(102, 7, 1, '2024-07-15 23:22:32'),
(103, 7, 1, '2024-07-15 23:22:53'),
(104, 7, 1, '2024-07-15 23:23:13'),
(105, 7, 1, '2024-07-15 23:23:36'),
(106, 7, 1, '2024-07-15 23:23:57'),
(107, 28, 1, '2024-07-16 06:10:35'),
(108, 28, 1, '2024-07-16 06:11:10'),
(109, 28, 1, '2024-07-16 06:12:19'),
(110, 28, 1, '2024-07-16 06:12:50'),
(111, 28, 1, '2024-07-16 06:13:34'),
(112, 28, 1, '2024-07-16 06:13:59'),
(113, 28, 1, '2024-07-16 06:14:26'),
(114, 28, 1, '2024-07-16 06:14:41'),
(115, 28, 1, '2024-07-16 06:15:06'),
(116, 28, 1, '2024-07-16 06:15:36'),
(117, 29, 1, '2024-07-16 15:36:36'),
(118, 29, 1, '2024-07-16 15:43:50'),
(119, 11, 1, '2024-07-16 16:57:27'),
(120, 11, 1, '2024-07-16 16:57:57'),
(121, 11, 1, '2024-07-16 16:59:15'),
(122, 11, 1, '2024-07-16 17:04:36'),
(123, 11, 1, '2024-07-16 17:05:49'),
(124, 11, 1, '2024-07-16 17:07:17'),
(125, 11, 1, '2024-07-16 17:08:27'),
(126, 11, 1, '2024-07-16 17:10:22'),
(127, 11, 1, '2024-07-16 17:11:17'),
(128, 11, 1, '2024-07-16 17:12:02'),
(129, 14, 1, '2024-07-16 18:12:38'),
(130, 11, 1, '2024-07-16 22:28:41'),
(131, 28, 1, '2024-07-17 00:36:33'),
(132, 28, 1, '2024-07-17 00:37:14'),
(133, 28, 1, '2024-07-17 00:40:19'),
(134, 28, 1, '2024-07-17 00:40:43'),
(135, 28, 1, '2024-07-17 00:41:30'),
(136, 28, 1, '2024-07-17 00:41:58'),
(137, 28, 1, '2024-07-17 00:42:36'),
(138, 28, 1, '2024-07-17 00:43:07'),
(139, 28, 1, '2024-07-17 00:43:15'),
(140, 28, 1, '2024-07-17 00:44:44'),
(141, 23, 1, '2024-07-17 00:59:20'),
(142, 23, 1, '2024-07-17 00:59:55'),
(143, 23, 1, '2024-07-17 01:00:36'),
(144, 23, 1, '2024-07-17 01:01:50'),
(145, 23, 1, '2024-07-17 01:02:40'),
(146, 23, 1, '2024-07-17 01:08:58'),
(147, 23, 1, '2024-07-17 01:10:26'),
(148, 23, 1, '2024-07-17 01:11:33'),
(149, 23, 1, '2024-07-17 01:12:46'),
(150, 23, 1, '2024-07-17 01:13:19');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`game_id`);

--
-- Índices para tabela `mining_machines`
--
ALTER TABLE `mining_machines`
  ADD PRIMARY KEY (`machine_id`);

--
-- Índices para tabela `mining_rewards`
--
ALTER TABLE `mining_rewards`
  ADD PRIMARY KEY (`user_id`);

--
-- Índices para tabela `network_power`
--
ALTER TABLE `network_power`
  ADD PRIMARY KEY (`user_id`);

--
-- Índices para tabela `offerwall`
--
ALTER TABLE `offerwall`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `shop_miners`
--
ALTER TABLE `shop_miners`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `shortlinks`
--
ALTER TABLE `shortlinks`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices para tabela `user_faucet`
--
ALTER TABLE `user_faucet`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `user_games`
--
ALTER TABLE `user_games`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `game_id` (`game_id`);

--
-- Índices para tabela `user_miners`
--
ALTER TABLE `user_miners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `miner_id` (`miner_id`);

--
-- Índices para tabela `user_shortlinks`
--
ALTER TABLE `user_shortlinks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `shortlink_id` (`shortlink_id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `games`
--
ALTER TABLE `games`
  MODIFY `game_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `mining_machines`
--
ALTER TABLE `mining_machines`
  MODIFY `machine_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `offerwall`
--
ALTER TABLE `offerwall`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `shop_miners`
--
ALTER TABLE `shop_miners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `shortlinks`
--
ALTER TABLE `shortlinks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de tabela `user_faucet`
--
ALTER TABLE `user_faucet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=226;

--
-- AUTO_INCREMENT de tabela `user_games`
--
ALTER TABLE `user_games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `user_miners`
--
ALTER TABLE `user_miners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `user_shortlinks`
--
ALTER TABLE `user_shortlinks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `user_games`
--
ALTER TABLE `user_games`
  ADD CONSTRAINT `user_games_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_games_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`);

--
-- Limitadores para a tabela `user_miners`
--
ALTER TABLE `user_miners`
  ADD CONSTRAINT `user_miners_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_miners_ibfk_2` FOREIGN KEY (`miner_id`) REFERENCES `shop_miners` (`id`);

--
-- Limitadores para a tabela `user_shortlinks`
--
ALTER TABLE `user_shortlinks`
  ADD CONSTRAINT `user_shortlinks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_shortlinks_ibfk_2` FOREIGN KEY (`shortlink_id`) REFERENCES `shortlinks` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
