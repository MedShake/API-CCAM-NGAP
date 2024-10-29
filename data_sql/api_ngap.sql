CREATE DATABASE IF NOT EXISTS NGAP;
USE NGAP;

-- --------------------------------------------------------

--
-- Table structure for table `ngap`
--

CREATE TABLE IF NOT EXISTS `ngap` (
  `code` varchar(5) NOT NULL,
  `codeProf` varchar(10) NOT NULL DEFAULT '',
  `type` enum('consultation','majoration','indemnité','forfait','autre') DEFAULT NULL,
  `label` text NOT NULL,
  `partieNgap` tinyint(1) DEFAULT NULL,
  `articleNgap` varchar(10) DEFAULT NULL,
  `dtDecisionUncam` date DEFAULT NULL,
  `codePrestation` varchar(5) DEFAULT NULL,
  `reserveConven` enum('n','o') NOT NULL DEFAULT 'n',
  `tarifMetro` decimal(6,2) DEFAULT NULL,
  `tarif971` decimal(6,2) DEFAULT NULL,
  `tarif972` decimal(6,2) DEFAULT NULL,
  `tarif973` decimal(6,2) DEFAULT NULL,
  `tarif974` decimal(6,2) DEFAULT NULL,
  `tarif976` decimal(6,2) DEFAULT NULL,
  `dtActualisation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`code`,`codeProf`) USING BTREE,
  KEY `codePrestation` (`codePrestation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ngap_codesProf`
--

CREATE TABLE IF NOT EXISTS `ngap_codesProf` (
  `code` varchar(10) NOT NULL,
  `label` varchar(50) NOT NULL,
  `base` varchar(10) NOT NULL DEFAULT 'mspe',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ngap_cumul`
--

CREATE TABLE IF NOT EXISTS `ngap_cumul` (
  `code1` varchar(10) NOT NULL,
  `code2` varchar(10) NOT NULL,
  `codeProf` varchar(10) NOT NULL,
  PRIMARY KEY (`code1`,`code2`,`codeProf`),
  KEY `code1` (`code1`,`codeProf`),
  KEY `code2` (`code2`,`codeProf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `params`
--

CREATE TABLE IF NOT EXISTS `params` (
  `param` varchar(255) NOT NULL,
  `val` varchar(255) NOT NULL,
  UNIQUE KEY `param` (`param`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
