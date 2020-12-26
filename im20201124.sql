-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- 主机： mysql:3306
-- 生成日期： 2020-11-24 02:28:03
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
(1, '', '3', '', -1, 'hello', '{\"a\": \"b\"}', 'null', 1598352292604, 1, 1, 0, 'null', 0, NULL),
(2, '', '3', '62e1b0cdff80198eab2e2a4a17521528', -1, 'hello', '{\"a\": \"b\"}', 'null', 1598352343670, 1, 1, 0, 'null', 0, NULL),
(3, '', '3', '62e1b0cdff80198eab2e2a4a17521528', -1, 'hello', '{\"a\": \"b\"}', 'null', 1598352835885, 1, 1, 0, 'null', 0, NULL),
(4, '', '3', '62e1b0cdff80198eab2e2a4a17521528', -1, 'hello', '{\"a\": \"b\"}', 'null', 1598361552743, 1, 1, 0, 'null', 0, NULL),
(5, '6bf30abba0a53ea9290747444d891271', '3', '62e1b0cdff80198eab2e2a4a17521528', -1, 'hello', '{\"a\": \"b\"}', 'null', 1598362194273, 1, 1, 0, 'null', 0, NULL),
(6, 'aae5ff1b67af6563f9ba3bab7d4ff1c9', '3', '62e1b0cdff80198eab2e2a4a17521528', -1, 'hello', '{\"a\": \"b\"}', 'null', 1598362378965, 1, 1, 0, 'null', 0, NULL);

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
(41, '05df798f554739291589f521d0f0f5a1', 2, 0, '666666', NULL, '1597500303', 1, 1597994197957, NULL),
(42, '581d849f088217f07139181c5ea8d05f', 1, 0, '666666', NULL, '1597500303', 1, 1597994197957, NULL),
(43, 'b964907266616318d05949af95a930f5', 1, 0, '666666', NULL, '1597500303', 1, 1597994197957, NULL),
(44, '689d38c75e06e5a5d75a149a0f6ac0da', 2, 0, '666666', NULL, '1597500303', 1, 1597994197957, NULL),
(45, '64b0f196a88f9fa9457047d843f2908a', 2, 0, '666666', '{\"conv_name\": \"aaa\"}', '1597500303', 1, 1597994197957, NULL),
(46, '6f5405fb9a4297892f7cf2b61a770d17', 2, 0, '666666', '{\"conv_name\": \"aaa\"}', '1597500303', 1, 1597994197957, NULL),
(47, '455f656a59392c18f34fb5db5d05aed7', 2, 0, '666666', '{\"conv_name\": \"aaa\"}', '1597500303', 1, 1597994197957, NULL),
(48, 'e7c42cf35bd47c216f4b8e205e1fc0ca', 2, 0, '666666', '{\"conv_name\": \"aaa\"}', '1597500303', 1, 1597994197957, NULL),
(49, '6bf0f3782e196f0dcd39518b482cf5e4', 2, 0, '666666', '{\"conv_name\": \"aaa\"}', '1597500303', 1, 1597994197957, NULL),
(50, '0e7ae8d24e2658e7fb4ecdfbb409249d', 2, 0, '666666', '{\"conv_name\": \"aaa\"}', '1597500303', 1, 1597994197957, NULL),
(51, 'd9fe267037264e38c43ed2bfd9cdec30', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '1597500303', 1, 1597994197957, NULL),
(52, '3d40e4082573af1d5be29d5621bfe090', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '1597500303', 1, 1597994197957, NULL),
(53, 'bf049516fffbd825baa9b1b5eed11821', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '1597500303', 1, 1597994197957, NULL),
(54, '9227783f54f7f11f667c4d84453101a5', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '1597500303', 1, 1597994197957, NULL),
(55, 'd41ae836c6c53cf948f7fa8b690a724d', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '1597500303', 1, 1597994197957, NULL),
(56, '8b6f4317792723e5f318e45187b7469f', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '1597500303', 1, 1597994197957, NULL),
(57, '52f0d7483c61ec7debd7c5de7f05224c', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '1597500303', 1, 1597994197957, NULL),
(58, '7bfea8d794746968309748554abd351b', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '1597500303', 1, 1597994197957, NULL),
(59, '1ae5fc42d9e92e0be579b9e842badefb', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '1597500303', 1, 1597994197957, NULL),
(60, 'b0e5ec174bd477df4b43e664927f6e3a', 2, 0, '666666', '{\"conv_name\": \"test2\"}', '1597500303', 2, 1597995227121, 1598184671373),
(61, 'd866b96bf841ead9c52c5df7e6da1b21', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '3', 1, 1598235421295, NULL),
(62, 'd3e0d0756a78ab0e7e6bab97917765e1', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '3', 1, 1598235438521, NULL),
(63, 'd8ef52443a1a959d8424952c82e3302c', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '3', 1, 1598235462405, NULL),
(64, 'ab29058ead3d092cb84466277ecfe814', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '3', 1, 1598235518896, NULL),
(65, '62e1b0cdff80198eab2e2a4a17521528', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '3', 1, 1598235540398, NULL),
(66, 'fb1ba3fa0dbf66ae629f3a221d958046', 2, 0, '666666', '{\"conv_name\": \"just test\"}', '1', 1, 1598235716060, NULL),
(67, 'f79408e5ca998cd53faf44af31e6eb45', 1, 0, '666666', '{\"conv_name\": \"just test\"}', '1', 1, 1599803283296, NULL),
(73, 'cd7fc5304f56f52488d5246b0ebbdbfb', 1, 0, '666666', '{\"conv_name\": {\"1112\": \"1113\", \"1113\": \"1112\"}}', '15', 1, 1602678134744, NULL);

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
(13, '666666', '05df798f554739291589f521d0f0f5a1', '1597500303', 1, 2, 1, 2147483647, NULL),
(14, '666666', '05df798f554739291589f521d0f0f5a1', '1597500304', 0, 2, 1, 2147483647, NULL),
(15, '666666', '581d849f088217f07139181c5ea8d05f', '1597500303', 1, 1, 1, 2147483647, NULL),
(16, '666666', '581d849f088217f07139181c5ea8d05f', '1597500304', 0, 1, 1, 2147483647, NULL),
(17, '666666', 'b964907266616318d05949af95a930f5', '1597500303', 1, 1, 1, 2147483647, NULL),
(18, '666666', 'b964907266616318d05949af95a930f5', '1597500304', 0, 1, 1, 2147483647, NULL),
(19, '666666', '689d38c75e06e5a5d75a149a0f6ac0da', '1597500303', 1, 2, 1, 2147483647, NULL),
(20, '666666', '689d38c75e06e5a5d75a149a0f6ac0da', '1597500304', 0, 2, 1, 2147483647, NULL),
(21, '666666', '64b0f196a88f9fa9457047d843f2908a', '1597500303', 1, 2, 1, 2147483647, NULL),
(22, '666666', '64b0f196a88f9fa9457047d843f2908a', '1597500304', 0, 2, 1, 2147483647, NULL),
(23, '666666', '6f5405fb9a4297892f7cf2b61a770d17', '1597500303', 1, 2, 1, 2147483647, NULL),
(24, '666666', '6f5405fb9a4297892f7cf2b61a770d17', '1597500304', 0, 2, 1, 2147483647, NULL),
(25, '666666', '455f656a59392c18f34fb5db5d05aed7', '1597500303', 1, 2, 1, 2147483647, NULL),
(26, '666666', '455f656a59392c18f34fb5db5d05aed7', '1597500304', 0, 2, 1, 2147483647, NULL),
(27, '666666', 'e7c42cf35bd47c216f4b8e205e1fc0ca', '1597500303', 1, 2, 1, 2147483647, NULL),
(28, '666666', 'e7c42cf35bd47c216f4b8e205e1fc0ca', '1597500304', 0, 2, 1, 2147483647, NULL),
(29, '666666', '6bf0f3782e196f0dcd39518b482cf5e4', '1597500303', 1, 2, 1, 2147483647, NULL),
(30, '666666', '6bf0f3782e196f0dcd39518b482cf5e4', '1597500304', 0, 2, 1, 2147483647, NULL),
(31, '666666', '0e7ae8d24e2658e7fb4ecdfbb409249d', '1597500303', 1, 2, 1, 2147483647, NULL),
(32, '666666', '0e7ae8d24e2658e7fb4ecdfbb409249d', '1597500304', 0, 2, 1, 2147483647, NULL),
(33, '666666', 'd9fe267037264e38c43ed2bfd9cdec30', '1597500303', 1, 2, 1, 2147483647, NULL),
(34, '666666', 'd9fe267037264e38c43ed2bfd9cdec30', '1597500304', 0, 2, 1, 2147483647, NULL),
(35, '666666', '3d40e4082573af1d5be29d5621bfe090', '1597500303', 1, 2, 1, 2147483647, NULL),
(36, '666666', '3d40e4082573af1d5be29d5621bfe090', '1597500304', 0, 2, 1, 2147483647, NULL),
(37, '666666', 'bf049516fffbd825baa9b1b5eed11821', '1597500303', 1, 2, 1, 2147483647, NULL),
(38, '666666', 'bf049516fffbd825baa9b1b5eed11821', '1597500304', 0, 2, 1, 2147483647, NULL),
(39, '666666', '9227783f54f7f11f667c4d84453101a5', '1597500303', 1, 2, 1, 2147483647, NULL),
(40, '666666', '9227783f54f7f11f667c4d84453101a5', '1597500304', 0, 2, 1, 2147483647, NULL),
(41, '666666', 'd41ae836c6c53cf948f7fa8b690a724d', '1597500303', 1, 2, 1, 2147483647, NULL),
(42, '666666', 'd41ae836c6c53cf948f7fa8b690a724d', '1597500304', 0, 2, 1, 2147483647, NULL),
(43, '666666', '8b6f4317792723e5f318e45187b7469f', '1597500303', 1, 2, 1, 2147483647, NULL),
(44, '666666', '8b6f4317792723e5f318e45187b7469f', '1597500304', 0, 2, 1, 2147483647, NULL),
(45, '666666', '52f0d7483c61ec7debd7c5de7f05224c', '1597500303', 1, 2, 1, 2147483647, NULL),
(46, '666666', '52f0d7483c61ec7debd7c5de7f05224c', '1597500304', 0, 2, 1, 2147483647, NULL),
(47, '666666', '7bfea8d794746968309748554abd351b', '1597500303', 1, 2, 1, 2147483647, NULL),
(48, '666666', '7bfea8d794746968309748554abd351b', '1597500304', 0, 2, 1, 2147483647, NULL),
(49, '666666', '1ae5fc42d9e92e0be579b9e842badefb', '1597500303', 1, 2, 1, 2147483647, NULL),
(50, '666666', '1ae5fc42d9e92e0be579b9e842badefb', '1597500304', 0, 2, 1, 2147483647, NULL),
(51, '666666', 'b0e5ec174bd477df4b43e664927f6e3a', '1597500303', 1, 2, 1, 1597995227248, NULL),
(52, '666666', 'b0e5ec174bd477df4b43e664927f6e3a', '1597500304', 0, 2, 1, 1597995227255, NULL),
(53, '666666', 'b0e5ec174bd477df4b43e664927f6e3a', '6666', 0, 2, 1, 1598182879760, NULL),
(54, '666666', 'b0e5ec174bd477df4b43e664927f6e3a', '6667', 0, 2, 1, 1598182879839, NULL),
(59, '666666', 'd8ef52443a1a959d8424952c82e3302c', '3', 1, 2, 1, 1598235462470, NULL),
(60, '666666', 'd8ef52443a1a959d8424952c82e3302c', '4', 0, 2, 1, 1598235462479, NULL),
(61, '666666', 'ab29058ead3d092cb84466277ecfe814', '3', 1, 2, 1, 1598235518928, NULL),
(62, '666666', 'ab29058ead3d092cb84466277ecfe814', '4', 0, 2, 1, 1598235518937, NULL),
(63, '666666', '62e1b0cdff80198eab2e2a4a17521528', '3', 1, 2, 2, 1598235540423, 1598362379002),
(64, '666666', '62e1b0cdff80198eab2e2a4a17521528', '4', 0, 2, 1, 1598235540427, 1598362379002),
(65, '666666', 'fb1ba3fa0dbf66ae629f3a221d958046', '1', 1, 2, 1, 1598235716082, NULL),
(69, '666666', '62e1b0cdff80198eab2e2a4a17521528', '2', 0, 2, 1, 1598236483174, 1598362379002),
(70, '666666', 'f79408e5ca998cd53faf44af31e6eb45', '1', 1, 1, 1, 1599803283359, NULL),
(71, '666666', 'f79408e5ca998cd53faf44af31e6eb45', '2', 0, 1, 1, 1599803283390, NULL),
(72, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '14', 0, 1, 1, 1602590466077, NULL),
(73, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '15', 1, 1, 1, 1602590466112, NULL),
(74, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '14', 0, 1, 1, 1602591268540, NULL),
(75, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '15', 1, 1, 1, 1602591268545, NULL),
(76, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '14', 0, 1, 1, 1602591495437, NULL),
(77, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '15', 1, 1, 1, 1602591495441, NULL),
(78, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '14', 0, 1, 1, 1602593637435, NULL),
(79, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '15', 1, 1, 1, 1602593637445, NULL),
(80, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '14', 0, 1, 1, 1602593709706, NULL),
(81, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '15', 1, 1, 1, 1602593709709, NULL),
(82, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '14', 0, 1, 1, 1602678134853, NULL),
(83, '666666', 'cd7fc5304f56f52488d5246b0ebbdbfb', '15', 1, 1, 1, 1602678134865, NULL);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `conv_info`
--
ALTER TABLE `conv_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- 使用表AUTO_INCREMENT `conv_relation`
--
ALTER TABLE `conv_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键', AUTO_INCREMENT=84;

--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
