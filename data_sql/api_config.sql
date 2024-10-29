CREATE DATABASE IF NOT EXISTS config;
USE config;

-- --------------------------------------------------------

--
-- Table structure for table `apiKeys`
--

CREATE TABLE IF NOT EXISTS `apiKeys` (
  `clef` varchar(32) NOT NULL,
  `user` varchar(50) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  PRIMARY KEY (`clef`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

