-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- 主机： mysql:3306
-- 生成日期： 2020-12-20 04:39:20
-- 服务器版本： 8.0.13
-- PHP 版本： 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `im`
--

-- --------------------------------------------------------

--
-- 表的结构 `api_user`
--

CREATE TABLE `api_user` (
  `id` int(11) NOT NULL,
  `nickname` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `pwd` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `avatar` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '头像'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `api_user`
--

INSERT INTO `api_user` (`id`, `nickname`, `pwd`, `avatar`) VALUES
(1, '1112', 'd3a646db212e078f8f5a47d231e4d967', 'https://cdfy120.cdu.edu.cn/dfiles/10172/images/qyy.jpg'),
(2, '1113', 'd3a646db212e078f8f5a47d231e4d967', 'https://cdfy120.cdu.edu.cn/dfiles/10172/images/qyy.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `conv_detail`
--

CREATE TABLE `conv_detail` (
  `id` int(11) NOT NULL,
  `msg_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户id',
  `conv_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '会话id',
  `type` int(2) NOT NULL DEFAULT '-1' COMMENT '消息类型-1文本-2图片-3语音-4视频-5位置-6文件',
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文本描述',
  `attr` json DEFAULT NULL COMMENT '自定义描述',
  `url` json DEFAULT NULL COMMENT '资源地址 数组形式存储',
  `ctime` bigint(13) NOT NULL COMMENT '创建时间',
  `msg_status` int(2) NOT NULL DEFAULT '1' COMMENT '1 正常 2 删除 3 撤回',
  `no_sync` int(1) NOT NULL DEFAULT '0' COMMENT '是否同步到本账号其他在线设备 0 不同步 1 同步',
  `mention_all` int(1) NOT NULL DEFAULT '0' COMMENT '@全体 0@ 1不@',
  `mention_client_ids` json DEFAULT NULL COMMENT '@成员 最多20',
  `transient` int(1) NOT NULL DEFAULT '0' COMMENT '是否暂态消息 0 不是 1 是',
  `mtime` bigint(13) DEFAULT NULL COMMENT '删除/撤回 时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息详情表';

--
-- 转存表中的数据 `conv_detail`
--

INSERT INTO `conv_detail` (`id`, `msg_id`, `user_id`, `conv_id`, `type`, `text`, `attr`, `url`, `ctime`, `msg_status`, `no_sync`, `mention_all`, `mention_client_ids`, `transient`, `mtime`) VALUES
(7, '3341269c8609e9c986be0bcf9dfd446a', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1607927823834, 1, 0, 0, 'null', 0, NULL),
(8, 'aa68d98c6208dce0eaf1aef86f0f8132', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1607928132618, 1, 0, 0, 'null', 0, NULL),
(9, 'b6387b6872904c9133472fca086c0a70', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1607928159629, 1, 0, 0, 'null', 0, NULL),
(10, '660179aacb8989ed1abc4b3d2db2cf78', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1607933965682, 1, 0, 0, 'null', 0, NULL),
(11, '2187763815e64c819bef66d319157034', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1607934094307, 1, 0, 0, 'null', 0, NULL),
(12, '58b36d7b41993ba4f34d3da2905a79f6', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1607934253362, 1, 0, 0, 'null', 0, NULL),
(13, '5d583f3837ed5e1dca7b6277c59b8d0e', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1607936144305, 1, 0, 0, 'null', 0, NULL),
(14, '71e7e87cebccd42ad86d20662049ab2f', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1607936419391, 1, 0, 0, 'null', 0, NULL),
(15, '8ae0e1a8693bf0cf69c309a56b49af30', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1607936708827, 1, 0, 0, 'null', 0, NULL),
(16, 'ab3d731ff913d60ff14c9af95bf48edb', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1607936747659, 1, 0, 0, 'null', 0, NULL),
(17, 'c56d6d129f63b12957affbeb71317f7c', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1607937171558, 1, 0, 0, 'null', 0, NULL),
(18, 'fb3184e2cf0ab86019671146cb019235', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1607938073386, 1, 0, 0, 'null', 0, NULL),
(19, '45ad1d23f7e08f6b3a02643096bb7dfd', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1608022404390, 1, 0, 0, 'null', 0, NULL),
(20, '507bc83426342d483617f32e4610994f', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1608087489250, 1, 0, 0, 'null', 0, NULL),
(21, '6bc989c43ed202012fed3a86ff16cade', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1608102027509, 1, 0, 0, 'null', 0, NULL),
(22, 'ffb3c4595d47e83e4e68d201b1552529', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1608102136339, 1, 0, 0, 'null', 0, NULL),
(23, 'ca6dff9f01981b5dc12ffd14e59d24b3', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1608125557497, 1, 0, 0, 'null', 0, NULL),
(24, '28bd7be51865b87205a109bb4f7cdde8', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1608126082100, 1, 0, 0, 'null', 0, NULL),
(25, '1228a6554433f500a034b3f8d0b93571', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1608126111618, 1, 0, 0, 'null', 0, NULL),
(26, '95689c2f88eefbd42a69c598418839ae', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1608127111740, 1, 0, 0, 'null', 0, NULL),
(27, '98a8acda0ec849beb548c9aab6bdba69', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1608128910368, 1, 0, 0, 'null', 0, NULL),
(28, 'febcf65c85c43c26fbb4f43f7b4e8c16', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1608129119936, 1, 0, 0, 'null', 0, NULL),
(29, '4d0f7f361c69b757cd1538dbea279fd8', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO !', 'null', 'null', 1608129240225, 1, 0, 0, 'null', 0, NULL),
(30, '1618954549cba63fde40ef1b49f1c355', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO word!', 'null', 'null', 1608129595438, 1, 0, 0, 'null', 0, NULL),
(31, '811661cae11ee1f88b28f8640faab595', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO word 1111 !', 'null', 'null', 1608129617708, 1, 0, 0, 'null', 0, NULL),
(32, '413f1f5d8217cfeab0518d42ccad106a', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO word !', 'null', 'null', 1608129627748, 1, 0, 0, 'null', 0, NULL),
(33, '78945251e4246113a052bba11379ed1b', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO word !', 'null', 'null', 1608168434061, 1, 0, 0, 'null', 0, NULL),
(34, 'ab03be8293db780427dcad63c30fc90e', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO word !', 'null', 'null', 1608210146325, 1, 0, 0, 'null', 0, NULL),
(35, 'dad0d1c3dbd0712ba826f568c72baa0b', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO word !', 'null', 'null', 1608210554224, 1, 0, 0, 'null', 0, NULL),
(36, 'c9f4f4ea2dd30d913962e473cb5b1d22', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO word !', 'null', 'null', 1608210638695, 1, 0, 0, 'null', 0, NULL),
(37, 'b948cbfd2699d3b0968ac392485cab7d', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'HELLO word !', 'null', 'null', 1608214790078, 1, 0, 0, 'null', 0, NULL),
(38, '802d3431bd9f0fe8a85271cdba43e3fd', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '21', 'null', 'null', 1608215586092, 1, 0, 0, 'null', 0, NULL),
(39, 'd08193f01b18bec8767a0115d830f83e', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '213', 'null', 'null', 1608215625335, 1, 0, 0, 'null', 0, NULL),
(40, 'ab0bacfe08cd890e13081adc9ea708b8', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2131232131', 'null', 'null', 1608215634136, 1, 0, 0, 'null', 0, NULL),
(41, 'c09b637bf68fee87bc8ac8064ddb0ee4', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '你好', 'null', 'null', 1608215643386, 1, 0, 0, 'null', 0, NULL),
(42, '728861f2d7aa6a0ca22b32623e2580f8', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '你好', 'null', 'null', 1608215645561, 1, 0, 0, 'null', 0, NULL),
(43, 'af159e23f0bf68a1847b1f554c3a34cc', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '你好', 'null', 'null', 1608215645717, 1, 0, 0, 'null', 0, NULL),
(44, 'edb5ef0a3b6d178a64765bf6d6b3ad22', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '你好', 'null', 'null', 1608215645862, 1, 0, 0, 'null', 0, NULL),
(45, 'ee12100f5db637a0f4a9c1cd9dcfad86', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '你好', 'null', 'null', 1608215645978, 1, 0, 0, 'null', 0, NULL),
(46, '39b90e71a3bc6f2a147d98635027bfb7', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '你好', 'null', 'null', 1608215646113, 1, 0, 0, 'null', 0, NULL),
(47, 'ca518b77fcb1831dec93d6b59a61c7d4', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '你好', 'null', 'null', 1608215646246, 1, 0, 0, 'null', 0, NULL),
(48, 'db43e1aebc0550ed6c4c3affbe98a253', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '你好', 'null', 'null', 1608215646370, 1, 0, 0, 'null', 0, NULL),
(49, 'f33dabab07027615c5fac8a32cc75378', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '你好', 'null', 'null', 1608215646517, 1, 0, 0, 'null', 0, NULL),
(50, '44aa11619fc43b54f7ff80f386bcb7f7', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '你好', 'null', 'null', 1608215653952, 1, 0, 0, 'null', 0, NULL),
(51, '42057a0ff484c89ae46967de74fd4eb7', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'yes', 'null', 'null', 1608215659596, 1, 0, 0, 'null', 0, NULL),
(52, 'e92ab92927cd194600536475acc4e21d', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '21', 'null', 'null', 1608250885574, 1, 0, 0, 'null', 0, NULL),
(53, '2f7969d92e129a805fcb2fbd46c66a12', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '21w\'q', 'null', 'null', 1608250912286, 1, 0, 0, 'null', 0, NULL),
(54, '6b94675f401709ee52be829ff8a6d980', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '21w\'q', 'null', 'null', 1608250912466, 1, 0, 0, 'null', 0, NULL),
(55, '7df24441e2623b3e9a832d0c4380ebb4', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '21w\'q32', 'null', 'null', 1608250920715, 1, 0, 0, 'null', 0, NULL),
(56, 'e42150c369baa95d87e20ce1100361a0', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'w\'q', 'null', 'null', 1608251053460, 1, 0, 0, 'null', 0, NULL),
(57, '86a8ea7acb3a26337fe8c12d1d5af181', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'w\'q', 'null', 'null', 1608251053777, 1, 0, 0, 'null', 0, NULL),
(58, '82b85d8d9869347708dce049864d61ae', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'w\'q', 'null', 'null', 1608251053943, 1, 0, 0, 'null', 0, NULL),
(59, '1f7bd195f2779a55f0408eabb20eedbb', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'w\'q', 'null', 'null', 1608251058252, 1, 0, 0, 'null', 0, NULL),
(60, '2b58a19b4953c46667f57eb6214759f3', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'w\'qfff', 'null', 'null', 1608251063054, 1, 0, 0, 'null', 0, NULL),
(61, 'd4d9f8f8bdb8fbce2927b8277579e895', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'wq', 'null', 'null', 1608251125730, 1, 0, 0, 'null', 0, NULL),
(62, '2c963bf078690f600561934709c5f5f0', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'wq', 'null', 'null', 1608251174521, 1, 0, 0, 'null', 0, NULL),
(63, 'e465c2fc973e9f62f64ae8cefc0e2c6c', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'wq', 'null', 'null', 1608251211295, 1, 0, 0, 'null', 0, NULL),
(64, '3f0edd9746a2db96efa6d30ce45bc946', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'wq', 'null', 'null', 1608251305052, 1, 0, 0, 'null', 0, NULL),
(65, 'c5992ba0a432174f1a651074d281d357', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608251727965, 1, 0, 0, 'null', 0, NULL),
(66, 'c76e0fadd8e6563f3ffc5b82398ed176', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608251728299, 1, 0, 0, 'null', 0, NULL),
(67, '9f7d2d10e3c317c48d315a9c3ce17e3c', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608251728536, 1, 0, 0, 'null', 0, NULL),
(68, '9772e2adc7ec6e13e13b49f2d96723ee', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608251731887, 1, 0, 0, 'null', 0, NULL),
(69, 'b3764a20471d1a5ae8284b94f8111bfe', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608251736964, 1, 0, 0, 'null', 0, NULL),
(70, '3c8938445a7426f109906f0e882c3452', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608251739184, 1, 0, 0, 'null', 0, NULL),
(71, 'a9603d94e04a44d7e1581e078be51e59', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'e', 'null', 'null', 1608251742000, 1, 0, 0, 'null', 0, NULL),
(72, 'cce066fd2004af2cf2d1220ae1b237f0', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'e', 'null', 'null', 1608251743372, 1, 0, 0, 'null', 0, NULL),
(73, 'aa959e3f06f3881a163c1a28aeabf704', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'e', 'null', 'null', 1608251746228, 1, 0, 0, 'null', 0, NULL),
(74, '34d2f453dfac6b3c80e7d18e7033e83e', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'e', 'null', 'null', 1608251748761, 1, 0, 0, 'null', 0, NULL),
(75, '3c51185e64298d4008c06b16dd31b920', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'e\'q', 'null', 'null', 1608251752054, 1, 0, 0, 'null', 0, NULL),
(76, 'b169d4ab64dd2e488f7216f36346a2d5', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'e', 'null', 'null', 1608251752270, 1, 0, 0, 'null', 0, NULL),
(77, '30cef3ad92df621526e7ebffb247097d', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'q', 'null', 'null', 1608251763115, 1, 0, 0, 'null', 0, NULL),
(78, 'a6cb7f23470dace7f104a012895f9d1d', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '去', 'null', 'null', 1608251763854, 1, 0, 0, 'null', 0, NULL),
(79, 'e04adcef425224c2c31ed061e4933453', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'w', 'null', 'null', 1608251837122, 1, 0, 0, 'null', 0, NULL),
(80, 'c6488768dc740a3e7d0806269bbffb42', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'w\'q', 'null', 'null', 1608251837399, 1, 0, 0, 'null', 0, NULL),
(81, '1b054585902948e2d7235d61f38f5d56', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'w', 'null', 'null', 1608251837530, 1, 0, 0, 'null', 0, NULL),
(82, '00533fe5c149a9881e03a2c1bd674191', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608251837927, 1, 0, 0, 'null', 0, NULL),
(83, '5ee81fb0d5b9650c624bc20b90cb656d', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '11', 'null', 'null', 1608251838096, 1, 0, 0, 'null', 0, NULL),
(84, '7c222ea604751afd53cdec6de7fc4eb7', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '111', 'null', 'null', 1608251840543, 1, 0, 0, 'null', 0, NULL),
(85, 'c14c4e8b59400484ebd3e780f36603e1', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1111', 'null', 'null', 1608251840745, 1, 0, 0, 'null', 0, NULL),
(86, '07d442be2053aff0da43ddd4b598b417', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '11111', 'null', 'null', 1608251840909, 1, 0, 0, 'null', 0, NULL),
(87, 'bbf5d640d24632449cd8c60208359d6c', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '111111', 'null', 'null', 1608251841031, 1, 0, 0, 'null', 0, NULL),
(88, '8bfe6ab5000dbf35d185c51c188154ae', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1111111', 'null', 'null', 1608251842771, 1, 0, 0, 'null', 0, NULL),
(89, '114815ea9de3c3c86283218ac4b81ec1', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '11111111', 'null', 'null', 1608251844292, 1, 0, 0, 'null', 0, NULL),
(90, '5499ed7ff1e0502fe426eacb925a0d54', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '111111111', 'null', 'null', 1608251987797, 1, 0, 0, 'null', 0, NULL),
(91, 'cb6e04f950b0d8dd6852a34e9df39916', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '111111111', 'null', 'null', 1608251988136, 1, 0, 0, 'null', 0, NULL),
(92, '941ba182aac781d67ed73a8354cc9e17', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '111111111', 'null', 'null', 1608251988315, 1, 0, 0, 'null', 0, NULL),
(93, 'c62c42becb940431c7f4ce4b79101558', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '111111111', 'null', 'null', 1608251988661, 1, 0, 0, 'null', 0, NULL),
(94, '840c94f6fe354abb2a72c47b4b3598e1', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '111111111', 'null', 'null', 1608251988828, 1, 0, 0, 'null', 0, NULL),
(95, '81e8420510a3e205595e9bca010880bb', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '111111111', 'null', 'null', 1608251988987, 1, 0, 0, 'null', 0, NULL),
(96, 'de1f23ee583139425475b469c2c33207', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'wq', 'null', 'null', 1608251997527, 1, 0, 0, 'null', 0, NULL),
(97, 'f0af29a34bd93df7e86495ad52dac880', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'wq', 'null', 'null', 1608251997785, 1, 0, 0, 'null', 0, NULL),
(98, 'ad1e39bea267084a3de5daad4ed898b5', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'wq', 'null', 'null', 1608252001004, 1, 0, 0, 'null', 0, NULL),
(99, 'dd3c2e27331fa2d58053fd82d4576e58', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'wq', 'null', 'null', 1608252001491, 1, 0, 0, 'null', 0, NULL),
(100, 'd50a76aa8a85c098885a58291cb0685c', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'wq', 'null', 'null', 1608252008225, 1, 0, 0, 'null', 0, NULL),
(101, 'f3f86f93e774197dfdf4edfbf2daaff3', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'ew', 'null', 'null', 1608252027087, 1, 0, 0, 'null', 0, NULL),
(102, '12b0a21df2749b048f7aadc66d3c8c4b', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'ew', 'null', 'null', 1608252031809, 1, 0, 0, 'null', 0, NULL),
(103, 'ddf516b148ea5e29f9aa64a826236f85', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '二位', 'null', 'null', 1608252036066, 1, 0, 0, 'null', 0, NULL),
(104, '5cea67ad677932d32c03cfcabc547c07', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '你好', 'null', 'null', 1608252040538, 1, 0, 0, 'null', 0, NULL),
(105, 'aa6455fc3ced727a09f94f942ae52e14', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'nihao', 'null', 'null', 1608252059452, 1, 0, 0, 'null', 0, NULL),
(106, 'dcaaebe7ca08e3291e96239dabf90022', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608252068383, 1, 0, 0, 'null', 0, NULL),
(107, '2a4b6f6e12d121305ccd4d8906bbeb84', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608252069199, 1, 0, 0, 'null', 0, NULL),
(108, '38a210420ee9a04efaa8be44637dac88', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608252069782, 1, 0, 0, 'null', 0, NULL),
(109, '7267e6aab26dd249deb56ff5335655f5', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608252071065, 1, 0, 0, 'null', 0, NULL),
(110, '27cc0fc821e1d410102d1199268aa8bb', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608252071296, 1, 0, 0, 'null', 0, NULL),
(111, '4a4cf1f56a182d58b8118b2f0bb14d70', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608252071834, 1, 0, 0, 'null', 0, NULL),
(112, '2d0b503e05cdd915fb5f542d003a3ea3', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608252072374, 1, 0, 0, 'null', 0, NULL),
(113, '6e53454b7187fc9706c905a66a11261e', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '45', 'null', 'null', 1608252074208, 1, 0, 0, 'null', 0, NULL),
(114, '150dfeae8d7831b286be9450a3c63ffa', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608252074396, 1, 0, 0, 'null', 0, NULL),
(115, '0433cec9d740ae097f6e408f8f7965bb', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '23', 'null', 'null', 1608252075061, 1, 0, 0, 'null', 0, NULL),
(116, '7b71982a39bd660f8fc6239ee76e9673', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '41', 'null', 'null', 1608252075981, 1, 0, 0, 'null', 0, NULL),
(117, '8c0a65cb3692c5ea6bac6ddd7362e8e4', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608252077508, 1, 0, 0, 'null', 0, NULL),
(118, '60ab5d2afe4e7cab4264a8bea3b7853a', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608252077849, 1, 0, 0, 'null', 0, NULL),
(119, '105e854a31f6d8b39c927b883964ca0b', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608252078397, 1, 0, 0, 'null', 0, NULL),
(120, '736c34e0fa6562c1107347617aa63c25', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'w', 'null', 'null', 1608252293123, 1, 0, 0, 'null', 0, NULL),
(121, '8962e5040f3f96b3cf1b09a6e306670d', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'wq', 'null', 'null', 1608252296032, 1, 0, 0, 'null', 0, NULL),
(122, 'da132c6df13d6816b1e6ad18a8f2ed52', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'wq', 'null', 'null', 1608252297390, 1, 0, 0, 'null', 0, NULL),
(123, '26e61505964cd10423dc718b08f9e632', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'wq', 'null', 'null', 1608252299000, 1, 0, 0, 'null', 0, NULL),
(124, 'c231bb9b99905bf5801db5c01fede422', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608252299999, 1, 0, 0, 'null', 0, NULL),
(125, '8db35c8c014c390b635b6eb1734f17cb', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608252300706, 1, 0, 0, 'null', 0, NULL),
(126, '0396c1f8201d7da235197c9de509f1d0', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608252301597, 1, 0, 0, 'null', 0, NULL),
(127, 'ca621c313d48818f4504fef5eb54fd4a', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '41', 'null', 'null', 1608252302399, 1, 0, 0, 'null', 0, NULL),
(128, '49ca072edb9195af3a90f1f98c9a1b22', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608252303003, 1, 0, 0, 'null', 0, NULL),
(129, '40b789f7e4ebbcd85091ab792e808b7c', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608252303392, 1, 0, 0, 'null', 0, NULL),
(130, 'ce3e839d7027e147d571c749c16c5a00', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '45', 'null', 'null', 1608252304884, 1, 0, 0, 'null', 0, NULL),
(131, '5b103762baa61fb28f3a01e5c59fbee2', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608252305142, 1, 0, 0, 'null', 0, NULL),
(132, 'de7ababbc04d9b398949887eb9469c97', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '233', 'null', 'null', 1608252305492, 1, 0, 0, 'null', 0, NULL),
(133, 'ada26488d66e2c1240164a416f3aa63f', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608252307030, 1, 0, 0, 'null', 0, NULL),
(134, '394459f4a80b735f26a5efcfc84800fc', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608252308666, 1, 0, 0, 'null', 0, NULL),
(135, '5f4459c0f33317639ca4613630d59c26', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '6', 'null', 'null', 1608252309959, 1, 0, 0, 'null', 0, NULL),
(136, '6cc185dcab902164a74973488ed401f9', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608252310832, 1, 0, 0, 'null', 0, NULL),
(137, '57580b3cb4a63f8ea1e868af86dea630', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608252312158, 1, 0, 0, 'null', 0, NULL),
(138, '209a23c2d8856392ed89a3525213cae3', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608252313044, 1, 0, 0, 'null', 0, NULL),
(139, '2cf769afc6f6696e65044183b7fa6d9f', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608252313800, 1, 0, 0, 'null', 0, NULL),
(140, '341405ab3f532aab93e84677b8ec7cdf', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608252314905, 1, 0, 0, 'null', 0, NULL),
(141, '5be4d290618008863eab12524722d44c', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608252315206, 1, 0, 0, 'null', 0, NULL),
(142, '8fd7197b2e62880f9aa1857a18c64def', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608252316316, 1, 0, 0, 'null', 0, NULL),
(143, '1153ff7970f09c1c647e98f1faf7316a', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '21', 'null', 'null', 1608252436064, 1, 0, 0, 'null', 0, NULL),
(144, '8b721dfc63929a091611246fc5c988e4', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608252630603, 1, 0, 0, 'null', 0, NULL),
(145, '8258dc0ad7e30a595b13fd0389491384', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '21', 'null', 'null', 1608252656814, 1, 0, 0, 'null', 0, NULL),
(146, '04b2b1ab673c8f7516dfeb071812a8a0', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '231', 'null', 'null', 1608252686119, 1, 0, 0, 'null', 0, NULL),
(147, '98bc14cf27451222bd4a93654ff93018', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'weq', 'null', 'null', 1608253020097, 1, 0, 0, 'null', 0, NULL),
(148, '238600ce0ec05b84fec14afdbee7f60a', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '呜呜呜呜呜呜呜呜无无无无无无无', 'null', 'null', 1608253027852, 1, 0, 0, 'null', 0, NULL),
(149, 'ac3e28fb2526dc9aab52b8d94ff6bda0', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '123', 'null', 'null', 1608253050382, 1, 0, 0, 'null', 0, NULL),
(150, '3307d9032005b8d013c39b955fa4c65e', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '312', 'null', 'null', 1608253063709, 1, 0, 0, 'null', 0, NULL),
(151, '224b4be1959e0257b0a4423b42d68fea', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '332', 'null', 'null', 1608253083929, 1, 0, 0, 'null', 0, NULL),
(152, 'e4bec497c59d4d739b328db2d5ee8d76', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '231', 'null', 'null', 1608253233223, 1, 0, 0, 'null', 0, NULL),
(153, 'f05adc1a94cd94e2fd7712ec5b38a9bf', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '21', 'null', 'null', 1608253273172, 1, 0, 0, 'null', 0, NULL),
(154, 'eca2b6d471b4cdd5b6ec2e02f90e7fc5', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'q', 'null', 'null', 1608261562304, 1, 0, 0, 'null', 0, NULL),
(155, '9bc1c907e89902a11c72cbdc71469d8f', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608261570325, 1, 0, 0, 'null', 0, NULL),
(156, '73c050d3c1b8d896ff97e4fb1f09e173', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261571370, 1, 0, 0, 'null', 0, NULL),
(157, 'de69b52eb9747050c5ff459a0eb5ccc0', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608261573262, 1, 0, 0, 'null', 0, NULL),
(158, 'a094dbc3dcb0640e2a7cb22e5cd4c691', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608261574066, 1, 0, 0, 'null', 0, NULL),
(159, 'fd5c3c14897ad00c1a6ad38d91cb9c6f', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261574958, 1, 0, 0, 'null', 0, NULL),
(160, '176a4460b2e9e11b5482d59edbd75455', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608261576256, 1, 0, 0, 'null', 0, NULL),
(161, '48d5e9977b43a540d00d88145ae76347', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261576575, 1, 0, 0, 'null', 0, NULL),
(162, 'ad3176c0e4466d89980f0cf2db295805', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608261577773, 1, 0, 0, 'null', 0, NULL),
(163, '6fab82b8e9adfe830f76572d2b09d28d', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261578820, 1, 0, 0, 'null', 0, NULL),
(164, 'a7de6a30b51714ba32863686bccff5df', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608261579141, 1, 0, 0, 'null', 0, NULL),
(165, '744928d6454ca7d4a10ed4e4dd1bb0b6', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608261580558, 1, 0, 0, 'null', 0, NULL),
(166, '1a36420f8dcfcab7ae547dcf81a9ded4', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261581944, 1, 0, 0, 'null', 0, NULL),
(167, '8c2e39055ba5fc6b041d59c8b64e1e58', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608261582545, 1, 0, 0, 'null', 0, NULL),
(168, 'b7abdf670f763ea5af3a0ca282d3af0e', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608261583416, 1, 0, 0, 'null', 0, NULL),
(169, '9220daf69ddd7ce7e1357ff2eb438d14', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608261585193, 1, 0, 0, 'null', 0, NULL),
(170, '26d72b2618740e7ec21061f9cacce69d', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608261585600, 1, 0, 0, 'null', 0, NULL),
(171, '3cd2352c552316d04db10e7b09c7b098', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261586702, 1, 0, 0, 'null', 0, NULL),
(172, 'd3c4bfe1be4870fce93aebe0e90522b7', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608261588384, 1, 0, 0, 'null', 0, NULL),
(173, 'e768cde51a1686ef1d77314d3643fa14', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608261589486, 1, 0, 0, 'null', 0, NULL),
(174, '5970bf709d9be74da85a6b9cbd02c6bc', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261589957, 1, 0, 0, 'null', 0, NULL),
(175, 'df11dd9e34bd5b3989ef465134c7995c', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608261591394, 1, 0, 0, 'null', 0, NULL),
(176, 'bfc0dfd2eaca4ee97ec5485a4d9205e8', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608261591964, 1, 0, 0, 'null', 0, NULL),
(177, '87128cfaabc0d6bef0abfca521356e1e', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '5', 'null', 'null', 1608261592765, 1, 0, 0, 'null', 0, NULL),
(178, '2372db6f1f4ec6debc4a6159092885f2', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'f', 'null', 'null', 1608261594087, 1, 0, 0, 'null', 0, NULL),
(179, 'df62d8aa88605d1a9d11a146e56d5c53', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'r', 'null', 'null', 1608261594853, 1, 0, 0, 'null', 0, NULL),
(180, 'dc65d6e9cca097cd381d0fe6bd5ea60f', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'r', 'null', 'null', 1608261595634, 1, 0, 0, 'null', 0, NULL),
(181, 'ee6e5a675e6faa2da1ed6494310f40da', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 's', 'null', 'null', 1608261596870, 1, 0, 0, 'null', 0, NULL),
(182, '806590cf957494000c55e9e5e7e99b00', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'r', 'null', 'null', 1608261597496, 1, 0, 0, 'null', 0, NULL),
(183, '452958c1c54269cd75bbcadddf7c87ad', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'f', 'null', 'null', 1608261598524, 1, 0, 0, 'null', 0, NULL),
(184, 'c3bcb594d9899f20122c1457ec3a3e3d', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'v', 'null', 'null', 1608261599607, 1, 0, 0, 'null', 0, NULL),
(185, 'ffc3be89bec890035b7a5232d95eedca', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608261603624, 1, 0, 0, 'null', 0, NULL),
(186, '21fe8a8a4ce8e6787319380d34913a27', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261604314, 1, 0, 0, 'null', 0, NULL),
(187, '190eb895a8e77daec2fedc576ba2e6aa', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608261605919, 1, 0, 0, 'null', 0, NULL),
(188, '33e7ab750df6548ba221c45efbf24ef2', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608261606371, 1, 0, 0, 'null', 0, NULL),
(189, '0f371e90e9791304e636a860e3f7eafc', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '5', 'null', 'null', 1608261607279, 1, 0, 0, 'null', 0, NULL),
(190, '9477050ab50cd20d37deb3cb01069530', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608261608934, 1, 0, 0, 'null', 0, NULL),
(191, '806aae90be3699408c875051419b0a81', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261609774, 1, 0, 0, 'null', 0, NULL),
(192, 'b692c75283c12336f5ffeca3c378fa09', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '5', 'null', 'null', 1608261610658, 1, 0, 0, 'null', 0, NULL),
(193, '28d52e7cd3b9a9a27f32bdaa8a6bfb88', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '5', 'null', 'null', 1608261612093, 1, 0, 0, 'null', 0, NULL),
(194, 'd5ed1e1d5d730276776775045f97a8bc', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608261613055, 1, 0, 0, 'null', 0, NULL),
(195, '789f8cdf1e3780ddc13eff80d2b18aa0', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608261613804, 1, 0, 0, 'null', 0, NULL),
(196, 'df1b98bb6bf2c16976b81c849874edcd', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261615793, 1, 0, 0, 'null', 0, NULL),
(197, 'ebddb6bbcc7a58775470384f81bd7934', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608261616314, 1, 0, 0, 'null', 0, NULL),
(198, '7fdcc59225e1a5257d8f2eba3e94e0c3', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261619963, 1, 0, 0, 'null', 0, NULL),
(199, 'f46ecbb2050f425a5d0990c616c47f98', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608261620569, 1, 0, 0, 'null', 0, NULL),
(200, '373d661488b3568c71f89a19bb21fa41', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608261621388, 1, 0, 0, 'null', 0, NULL),
(201, 'c16824091431eb3c55fb583fec553bd2', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '5', 'null', 'null', 1608261622605, 1, 0, 0, 'null', 0, NULL),
(202, '0d0ab3d015b78dd196e2f2c30d15a969', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608261624028, 1, 0, 0, 'null', 0, NULL),
(203, '3a2bd10be51d53aa296626397d6d8dd6', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608261624797, 1, 0, 0, 'null', 0, NULL),
(204, '7e742d6acba39e0aeee0f32cfd3ff4dc', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261626040, 1, 0, 0, 'null', 0, NULL),
(205, '5f61b1e208f24a6d824c0e4cb7d93527', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608261626837, 1, 0, 0, 'null', 0, NULL),
(206, '775797c3fb69df9634866bfcd8adcc02', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261636881, 1, 0, 0, 'null', 0, NULL),
(207, '625ed7446698448d3ff2d9836ad1690c', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608261637389, 1, 0, 0, 'null', 0, NULL),
(208, 'c3436270aef0ed13d7a88339f6850823', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608261637947, 1, 0, 0, 'null', 0, NULL),
(209, '0ef031a834fad50e8b95793bf0045b45', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '5', 'null', 'null', 1608261638349, 1, 0, 0, 'null', 0, NULL),
(210, '738896249f1271cef5756065b58421ff', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '6', 'null', 'null', 1608261638829, 1, 0, 0, 'null', 0, NULL),
(211, '0293c70243bcc4c54fb304667356f961', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '5', 'null', 'null', 1608261639868, 1, 0, 0, 'null', 0, NULL),
(212, '516044e5fc7544921ec2d92e2f1b67fe', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '4', 'null', 'null', 1608261640049, 1, 0, 0, 'null', 0, NULL),
(213, 'cf730e85067be12cf6696e1373434c9c', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608261762621, 1, 0, 0, 'null', 0, NULL),
(214, 'ff60998d1217f4425ef54aca837b50af', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608261765899, 1, 0, 0, 'null', 0, NULL),
(215, '2879c2449b1897ae8f502a413e318e9e', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608261767565, 1, 0, 0, 'null', 0, NULL),
(216, '14af51ae57c77b6b7b283a0dda6e7ad4', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608262297132, 1, 0, 0, 'null', 0, NULL),
(217, 'c3d25207808bca223c16314dc47a7fec', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '2', 'null', 'null', 1608262301680, 1, 0, 0, 'null', 0, NULL),
(218, 'e0df333a3a40ac7d97674e8fbb956c5f', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '3', 'null', 'null', 1608262304213, 1, 0, 0, 'null', 0, NULL),
(219, '7d578e816d99da86ae24e6edb92e1a8d', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'wq', 'null', 'null', 1608263708775, 1, 0, 0, 'null', 0, NULL),
(220, 'f5e877a9753b764450a8d4fcdf806ced', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1', 'null', 'null', 1608297531323, 1, 0, 0, 'null', 0, NULL),
(221, '920b7cebe2362ac155171081fd992e95', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '12', 'null', 'null', 1608297704578, 1, 0, 0, 'null', 0, NULL),
(222, '7f2d0f78f024eb59f97dbbd385761d5b', '14', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '12', 'null', 'null', 1608297711983, 1, 0, 0, 'null', 0, NULL),
(223, '55b3780ad4eb8c165f52f5e97c2dec74', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '21', 'null', 'null', 1608297744693, 1, 0, 0, 'null', 0, NULL),
(224, '611c6e982131adf711463ca75b9a8e0f', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '21', 'null', 'null', 1608297878698, 1, 0, 0, 'null', 0, NULL),
(225, '823228871ffed305058bb88f8717b13a', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '321', 'null', 'null', 1608297884316, 1, 0, 0, 'null', 0, NULL),
(226, '12e4664bb17681d88f8e133d798a0bcc', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'ooo', 'null', 'null', 1608298179670, 1, 0, 0, 'null', 0, NULL),
(227, '54c97d845397d1a993024670d51e26c7', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'oiioioi', 'null', 'null', 1608298183267, 1, 0, 0, 'null', 0, NULL),
(228, '5f21ddd65402199694954dfb7e2480da', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '1233333', 'null', 'null', 1608298187632, 1, 0, 0, 'null', 0, NULL),
(229, 'b950c3f969c3298d8fcdd0ce2154669f', '14', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'nhgnhgn', 'null', 'null', 1608298197057, 1, 0, 0, 'null', 0, NULL),
(230, '6d484b2fe13e561c20160e58d1fd4ce5', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'ppp', 'null', 'null', 1608298210009, 1, 0, 0, 'null', 0, NULL),
(231, 'fe502347181e6eb60763f4315a6c8b33', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, 'ppppp', 'null', 'null', 1608298216122, 1, 0, 0, 'null', 0, NULL),
(232, '035967b4901de575526893f9eb091a94', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '21', 'null', 'null', 1608298288565, 1, 0, 0, 'null', 0, NULL),
(233, 'e20f5e0c75f72f63dda39383723629dc', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '21', 'null', 'null', 1608298293925, 1, 0, 0, 'null', 0, NULL),
(234, 'd610f5731fe8b0ff3e674d4b0b47367b', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '21', 'null', 'null', 1608298296963, 1, 0, 0, 'null', 0, NULL),
(235, 'b9d572dfb3cb19ac693aa90cba5bc4da', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '12', 'null', 'null', 1608298299529, 1, 0, 0, 'null', 0, NULL),
(236, '21208c7134a5bc57cb8f1a5dfaacfa48', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '12333333', 'null', 'null', 1608298309034, 1, 0, 0, 'null', 0, NULL),
(237, '738c752581bc36fb2122ecb2db1fe276', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '123123122222', 'null', 'null', 1608298313736, 1, 0, 0, 'null', 0, NULL),
(238, 'ae8c6a1146432fcc88d69ad735e2d56f', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '12333333333', 'null', 'null', 1608298317004, 1, 0, 0, 'null', 0, NULL),
(239, '84a2ab146df74c4d1306d13d000d2ff7', '15', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '123323333211112321', 'null', 'null', 1608298323027, 1, 0, 0, 'null', 0, NULL),
(240, '67b618f4fe3f9396e28272a752aa522f', '14', 'cd7fc5304f56f52488d5246b0ebbdbfb', -1, '00', 'null', 'null', 1608436274797, 1, 0, 0, 'null', 0, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `conv_info`
--

CREATE TABLE `conv_info` (
  `id` int(11) NOT NULL,
  `conv_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '会话ID',
  `conv_type` int(2) NOT NULL COMMENT ' 1 私聊 2 多人会话 3 群聊',
  `client_num` int(6) NOT NULL DEFAULT '0' COMMENT '用户数量',
  `app_id` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户id',
  `conv_extend` json DEFAULT NULL COMMENT '会话扩展',
  `conv_creater_id` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建者用户ID',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '1 正常 2 删除',
  `ctime` bigint(13) NOT NULL COMMENT '创建时间',
  `mtime` bigint(13) DEFAULT NULL COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `conv_info`
--

INSERT INTO `conv_info` (`id`, `conv_id`, `conv_type`, `client_num`, `app_id`, `conv_extend`, `conv_creater_id`, `status`, `ctime`, `mtime`) VALUES
(74, 'cd7fc5304f56f52488d5246b0ebbdbfb', 1, 0, '666666', '{\"conv_name\": {\"1112\": \"1113\", \"1113\": \"1112\"}, \"conv_avatar\": {\"1112\": \"http://127.0.0.1/img/img2.jpg\", \"1113\": \"http://127.0.0.1/img/timg.jpeg\"}}', '15', 1, 1607776551526, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `conv_relation`
--

CREATE TABLE `conv_relation` (
  `id` int(11) NOT NULL COMMENT '自增主键',
  `app_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conv_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '回话ID',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户id',
  `role` int(1) NOT NULL COMMENT '1创建者',
  `conv_type` int(2) DEFAULT NULL COMMENT '会话类型  1 私聊 2 多人会话 3 群聊',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '1 正常 2 删除 3 清除历史',
  `ctime` bigint(13) NOT NULL COMMENT '创建时间',
  `mtime` bigint(13) DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `conv_relation`
--

INSERT INTO `conv_relation` (`id`, `app_id`, `conv_id`, `user_id`, `role`, `conv_type`, `status`, `ctime`, `mtime`) VALUES
(84, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '14', 0, 1, 1, 1607776551572, 1608436274883),
(85, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '15', 1, 1, 1, 1607776551586, 1608436274883);

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `app_id` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户id',
  `client_id` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户id(展示用)',
  `extend` json DEFAULT NULL COMMENT '扩展属性 商户自定义',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '0 正常 1 封禁',
  `ctime` bigint(13) NOT NULL COMMENT '生成时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `app_id`, `client_id`, `extend`, `status`, `ctime`) VALUES
(1, '666666', '1597500303', '{\"nickname\": \"json\"}', 0, 1597500303),
(2, '666666', '1597500304', '{\"nickname\": \"lili\"}', 0, 1597500303),
(3, '666666', '6666', '{\"nickname\": \"IRon\"}', 0, 1597500303),
(4, '666666', '6667', '{\"nickname\": \"mike\"}', 0, 1597500303),
(5, '123456', '1598537053', '{\"x\": \"123\"}', 1, 1),
(6, '123456', '1598537167', '{\"x\": \"123\"}', 1, 1),
(7, '123456', '1598537335', '{\"x\": \"123\"}', 1, 1598537335819),
(8, '123456', '1598537390', '{\"x\": \"123\"}', 1, 1598537390735),
(9, '123456', '1598537450', '{\"x\": \"123\"}', 1, 1598537450866),
(11, '666666', '1111', '{\"nickname\": \"liliSara\"}', 0, 1599926610013),
(12, '666666', '11112', '{\"nickname\": \"liliSara\"}', 0, 1599927081906),
(13, '666666', '1113', '{\"nickname\": \"liliSara\"}', 0, 1601365792586),
(14, '666666', '1', '{\"nickname\": \"liliSara\"}', 0, 1601368005142),
(15, '666666', '2', '{\"nickname\": \"nina\"}', 0, 1601368012644);

--
-- 转储表的索引
--

--
-- 表的索引 `api_user`
--
ALTER TABLE `api_user`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `conv_detail`
--
ALTER TABLE `conv_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`user_id`),
  ADD KEY `conv_id` (`conv_id`),
  ADD KEY `msg_id` (`msg_id`);

--
-- 表的索引 `conv_info`
--
ALTER TABLE `conv_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `conv_id` (`conv_id`);

--
-- 表的索引 `conv_relation`
--
ALTER TABLE `conv_relation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conv_id` (`conv_id`),
  ADD KEY `client_id` (`user_id`);

--
-- 表的索引 `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`client_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `api_user`
--
ALTER TABLE `api_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `conv_detail`
--
ALTER TABLE `conv_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=241;

--
-- 使用表AUTO_INCREMENT `conv_info`
--
ALTER TABLE `conv_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- 使用表AUTO_INCREMENT `conv_relation`
--
ALTER TABLE `conv_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键', AUTO_INCREMENT=86;

--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
