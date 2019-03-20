--
-- Database: `api_ccam`
--

-- --------------------------------------------------------

--
-- Table structure for table `params`
--

CREATE TABLE IF NOT EXISTS `params` (
  `param` varchar(255) NOT NULL,
  `val` varchar(255) NOT NULL,
  UNIQUE KEY `param` (`param`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_AAP_PMSI`
--

CREATE TABLE IF NOT EXISTS `R_AAP_PMSI` (
  `AAP_COD` varchar(16) DEFAULT NULL,
  `ICR` smallint(4) DEFAULT NULL,
  `CLASSANT` varchar(1) DEFAULT NULL,
  KEY `AAP_COD` (`AAP_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTE`
--

CREATE TABLE IF NOT EXISTS `R_ACTE` (
  `COD_ACTE` varchar(13) DEFAULT NULL,
  `DT_MODIF` date DEFAULT NULL,
  `MENU_COD` mediumint(6) DEFAULT NULL,
  `FRAIDP_COD` varchar(1) DEFAULT NULL,
  `REMBOU_COD` tinyint(1) DEFAULT NULL,
  `TYPE_COD` tinyint(1) DEFAULT NULL,
  `COD_STRUCT` varchar(13) DEFAULT NULL,
  `NOM_COURT` varchar(70) DEFAULT NULL,
  `NOM_LONG` varchar(255) DEFAULT NULL,
  `NOM_LONG0` varchar(255) DEFAULT NULL,
  `NOM_LONG1` varchar(255) DEFAULT NULL,
  `NOM_LONG2` varchar(255) DEFAULT NULL,
  `NOM_LONG3` varchar(255) DEFAULT NULL,
  `NOM_LONG4` varchar(255) DEFAULT NULL,
  `NOM_LONG5` varchar(255) DEFAULT NULL,
  `NOM_LONG6` varchar(255) DEFAULT NULL,
  `NOM_LONG7` varchar(255) DEFAULT NULL,
  `NOM_LONG8` varchar(255) DEFAULT NULL,
  `NOM_LONG9` varchar(255) DEFAULT NULL,
  `NOM_LONGA` varchar(255) DEFAULT NULL,
  `NOM_LONGB` varchar(255) DEFAULT NULL,
  `NOM_LONGC` varchar(255) DEFAULT NULL,
  `NOM_LONGD` varchar(255) DEFAULT NULL,
  `NOM_LONGE` varchar(255) DEFAULT NULL,
  `SEXE` tinyint(1) DEFAULT NULL,
  `DT_CREATIO` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `ENTENTE` varchar(1) DEFAULT NULL,
  `DT_EFFET` date DEFAULT NULL,
  `DT_ARRETE` date DEFAULT NULL,
  `DT_JO` date DEFAULT NULL,
  `MFIC_PLACE` decimal(12,6) DEFAULT NULL,
  `PRECEDENT` varchar(13) DEFAULT NULL,
  `SUIVANT` varchar(13) DEFAULT NULL,
  KEY `COD_ACTE` (`COD_ACTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTE_CLASSE_DMT`
--

CREATE TABLE IF NOT EXISTS `R_ACTE_CLASSE_DMT` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `CLDMT_COD` varchar(2) DEFAULT NULL,
  KEY `ACTE_COD` (`ACTE_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTE_CMUC`
--

CREATE TABLE IF NOT EXISTS `R_ACTE_CMUC` (
  `CLE_FORFAI` smallint(4) DEFAULT NULL,
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `MODIF_DT` date DEFAULT NULL,
  KEY `ACTE_COD` (`ACTE_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTE_COND_GEN`
--

CREATE TABLE IF NOT EXISTS `R_ACTE_COND_GEN` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `CONDGE_COD` smallint(4) DEFAULT NULL,
  KEY `ACTE_COD` (`ACTE_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTE_EXO_TM`
--

CREATE TABLE IF NOT EXISTS `R_ACTE_EXO_TM` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `ACDT_MODIF` date DEFAULT NULL,
  `EXOTM_COD` tinyint(1) DEFAULT NULL,
  KEY `ACTE_COD` (`ACTE_COD`,`ACDT_MODIF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTE_FORFAIT`
--

CREATE TABLE IF NOT EXISTS `R_ACTE_FORFAIT` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `ACDT_MODIF` date DEFAULT NULL,
  `FORFAI_COD` varchar(1) DEFAULT NULL,
  KEY `ACTE_COD` (`ACTE_COD`,`ACDT_MODIF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTE_IVITE`
--

CREATE TABLE IF NOT EXISTS `R_ACTE_IVITE` (
  `COD_AA` varchar(14) DEFAULT NULL,
  `DT_MODIF` date DEFAULT NULL,
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `ACDT_MODIF` date DEFAULT NULL,
  `ACTIV_COD` varchar(1) DEFAULT NULL,
  `REGROU_COD` varchar(3) DEFAULT NULL,
  `CATMED_COD` varchar(2) DEFAULT NULL,
  KEY `ACTE_COD` (`ACTE_COD`),
  KEY `COD_AA` (`COD_AA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTE_IVITE_PHASE`
--

CREATE TABLE IF NOT EXISTS `R_ACTE_IVITE_PHASE` (
  `COD_AAP` varchar(16) DEFAULT NULL,
  `DT_MODIF` date DEFAULT NULL,
  `AA_COD` varchar(14) DEFAULT NULL,
  `AADT_MODIF` date DEFAULT NULL,
  `UOEUVR_COD` varchar(3) DEFAULT NULL,
  `UOEDT_EFFE` date DEFAULT NULL,
  `PAIEM_COD` varchar(1) DEFAULT NULL,
  `PHASE_COD` tinyint(2) DEFAULT NULL,
  `NB_SEANCES` tinyint(2) DEFAULT NULL,
  `COEFFICIEN` decimal(6,2) DEFAULT NULL,
  `PU_BASE` decimal(6,2) DEFAULT NULL,
  `SUPPLEMENT` decimal(6,2) DEFAULT NULL,
  `NB_DENTS` varchar(2) DEFAULT NULL,
  `AGE_MIN` tinyint(3) DEFAULT NULL,
  `AGE_MAX` tinyint(3) DEFAULT NULL,
  `SCORE` decimal(6,2) DEFAULT NULL,
  `PRATIQUE` decimal(6,2) DEFAULT NULL,
  `ICR` double DEFAULT NULL,
  KEY `COD_AAP` (`COD_AAP`),
  KEY `AA_COD` (`AA_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTE_NAT_ASS`
--

CREATE TABLE IF NOT EXISTS `R_ACTE_NAT_ASS` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `NATASS_COD` varchar(2) DEFAULT NULL,
  KEY `ACTE_COD` (`ACTE_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTE_PRESCRIPTEUR`
--

CREATE TABLE IF NOT EXISTS `R_ACTE_PRESCRIPTEUR` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `ACDT_MODIF` date DEFAULT NULL,
  `CATSPE_COD` varchar(2) DEFAULT NULL,
  KEY `ACTE_COD` (`ACTE_COD`,`ACDT_MODIF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTIVITE`
--

CREATE TABLE IF NOT EXISTS `R_ACTIVITE` (
  `COD_ACTIV` varchar(1) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`COD_ACTIV`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTIVITE_AGRE_RADIO`
--

CREATE TABLE IF NOT EXISTS `R_ACTIVITE_AGRE_RADIO` (
  `AA_CODE` varchar(14) DEFAULT NULL,
  `AGRAD_COD` varchar(2) DEFAULT NULL,
  KEY `AA_CODE` (`AA_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTIVITE_EXECUTANT`
--

CREATE TABLE IF NOT EXISTS `R_ACTIVITE_EXECUTANT` (
  `AA_COD` varchar(14) DEFAULT NULL,
  `AADT_MODIF` date DEFAULT NULL,
  `CATSPE_COD` varchar(2) DEFAULT NULL,
  KEY `AA_COD` (`AA_COD`,`AADT_MODIF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTIVITE_EXTENSION`
--

CREATE TABLE IF NOT EXISTS `R_ACTIVITE_EXTENSION` (
  `AA_COD` varchar(14) DEFAULT NULL,
  `EXTENS_COD` varchar(1) DEFAULT NULL,
  KEY `AA_COD` (`AA_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTIVITE_MODIFICATEUR`
--

CREATE TABLE IF NOT EXISTS `R_ACTIVITE_MODIFICATEUR` (
  `AA_CODE` varchar(14) DEFAULT NULL,
  `AADT_MODIF` date DEFAULT NULL,
  `MODIFI_COD` varchar(1) DEFAULT NULL,
  KEY `AA_CODE` (`AA_CODE`,`AADT_MODIF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTIVITE_PHASE_DENT`
--

CREATE TABLE IF NOT EXISTS `R_ACTIVITE_PHASE_DENT` (
  `AAP_COD` varchar(16) DEFAULT NULL,
  `DEN_NUMERO` tinyint(2) DEFAULT NULL,
  KEY `AAP_COD` (`AAP_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTIVITE_PHASE_DOM`
--

CREATE TABLE IF NOT EXISTS `R_ACTIVITE_PHASE_DOM` (
  `AAP_COD` varchar(16) DEFAULT NULL,
  `APDT_MODIF` date DEFAULT NULL,
  `DOM_COD` smallint(3) DEFAULT NULL,
  `MAJORATION` decimal(4,3) DEFAULT NULL,
  KEY `AAP_COD` (`AAP_COD`,`APDT_MODIF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ACTIVITE_RMO`
--

CREATE TABLE IF NOT EXISTS `R_ACTIVITE_RMO` (
  `AA_COD` varchar(14) DEFAULT NULL,
  `AADT_MODIF` date DEFAULT NULL,
  `INTERN_COD` smallint(4) DEFAULT NULL,
  KEY `AA_COD` (`AA_COD`,`AADT_MODIF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_AGRE_RADIO`
--

CREATE TABLE IF NOT EXISTS `R_AGRE_RADIO` (
  `COD_AGRAD` varchar(2) DEFAULT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  KEY `COD_AGRAD` (`COD_AGRAD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_ASSOCIATIONS`
--

CREATE TABLE IF NOT EXISTS `R_ASSOCIATIONS` (
  `AA_CODE1` varchar(14) DEFAULT NULL,
  `DT_MODIF1` date DEFAULT NULL,
  `AA_CODE2` varchar(14) DEFAULT NULL,
  `DT_MODIF2` date DEFAULT NULL,
  `REGLE_COD` varchar(1) DEFAULT NULL,
  KEY `AA_CODE1` (`AA_CODE1`,`DT_MODIF1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_CATEGORIE_MEDIC`
--

CREATE TABLE IF NOT EXISTS `R_CATEGORIE_MEDIC` (
  `COD_CATMED` varchar(2) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`COD_CATMED`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_CATE_SPEC`
--

CREATE TABLE IF NOT EXISTS `R_CATE_SPEC` (
  `COD_CATSPE` varchar(2) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`COD_CATSPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_CLASSE_DMT`
--

CREATE TABLE IF NOT EXISTS `R_CLASSE_DMT` (
  `COD_CLDMT` varchar(2) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`COD_CLDMT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_COMPAT_EXO_TM`
--

CREATE TABLE IF NOT EXISTS `R_COMPAT_EXO_TM` (
  `EXOTM_COD1` tinyint(1) DEFAULT NULL,
  `EXOTM_COD2` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_COND_GEN`
--

CREATE TABLE IF NOT EXISTS `R_COND_GEN` (
  `COD_CONDGE` smallint(4) NOT NULL,
  `LIBELLE` varchar(255) DEFAULT NULL,
  `LIBELLE0` varchar(255) DEFAULT NULL,
  `LIBELLE1` varchar(255) DEFAULT NULL,
  `LIBELLE2` varchar(255) DEFAULT NULL,
  `LIBELLE3` varchar(255) DEFAULT NULL,
  `LIBELLE4` varchar(255) DEFAULT NULL,
  `LIBELLE5` varchar(255) DEFAULT NULL,
  `LIBELLE6` varchar(255) DEFAULT NULL,
  `LIBELLE7` varchar(255) DEFAULT NULL,
  `LIBELLE8` varchar(255) DEFAULT NULL,
  `LIBELLE9` varchar(255) DEFAULT NULL,
  `LIBELLEA` varchar(255) DEFAULT NULL,
  `LIBELLEB` varchar(255) DEFAULT NULL,
  `LIBELLEC` varchar(255) DEFAULT NULL,
  `LIBELLED` varchar(255) DEFAULT NULL,
  `LIBELLEE` varchar(255) DEFAULT NULL,
  `EXOTM_COD1` double DEFAULT NULL,
  `EXOTM_COD2` double DEFAULT NULL,
  PRIMARY KEY (`COD_CONDGE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_CONTEXT_BN`
--

CREATE TABLE IF NOT EXISTS `R_CONTEXT_BN` (
  `COD_CONTXT` smallint(4) NOT NULL,
  `LIBELLE` varchar(117) DEFAULT NULL,
  PRIMARY KEY (`COD_CONTXT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_CONTEXT_PS`
--

CREATE TABLE IF NOT EXISTS `R_CONTEXT_PS` (
  `COD_CONTXT` smallint(4) NOT NULL,
  `LIBELLE` varchar(117) DEFAULT NULL,
  PRIMARY KEY (`COD_CONTXT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_DENT`
--

CREATE TABLE IF NOT EXISTS `R_DENT` (
  `NUMERO_DEN` tinyint(2) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`NUMERO_DEN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_DOM`
--

CREATE TABLE IF NOT EXISTS `R_DOM` (
  `COD_DOM` smallint(3) NOT NULL,
  `LIBELLE` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`COD_DOM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_EXO_TM`
--

CREATE TABLE IF NOT EXISTS `R_EXO_TM` (
  `COD_EXOTM` tinyint(1) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`COD_EXOTM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_EXTENSION`
--

CREATE TABLE IF NOT EXISTS `R_EXTENSION` (
  `COD_EXTENS` varchar(1) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`COD_EXTENS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_FORFAIT`
--

CREATE TABLE IF NOT EXISTS `R_FORFAIT` (
  `COD_FORFAI` varchar(1) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`COD_FORFAI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_FRAIS_DEP`
--

CREATE TABLE IF NOT EXISTS `R_FRAIS_DEP` (
  `COD_FRAIDP` varchar(1) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`COD_FRAIDP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_GLOSSAIRE`
--

CREATE TABLE IF NOT EXISTS `R_GLOSSAIRE` (
  `LIBELLE` varchar(50) DEFAULT NULL,
  `DEFINITION` text,
  KEY `LIBELLE` (`LIBELLE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_INCOMPATIBILITES`
--

CREATE TABLE IF NOT EXISTS `R_INCOMPATIBILITES` (
  `ACTE_COD1` varchar(13) DEFAULT NULL,
  `DT_MODIF1` date DEFAULT NULL,
  `ACTE_COD2` varchar(13) DEFAULT NULL,
  `DT_MODIF2` date DEFAULT NULL,
  KEY `ACTE_COD1` (`ACTE_COD1`,`DT_MODIF1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_MENU`
--

CREATE TABLE IF NOT EXISTS `R_MENU` (
  `COD_MENU` mediumint(6) NOT NULL,
  `RANG` mediumint(6) DEFAULT NULL,
  `LIBELLE` varchar(255) DEFAULT NULL,
  `COD_PERE` mediumint(6) DEFAULT NULL,
  PRIMARY KEY (`COD_MENU`),
  KEY `COD_PERE` (`COD_PERE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_NAT_ASS`
--

CREATE TABLE IF NOT EXISTS `R_NAT_ASS` (
  `COD_NATASS` varchar(2) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`COD_NATASS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_NOTE_ACTE`
--

CREATE TABLE IF NOT EXISTS `R_NOTE_ACTE` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `ACDT_MODIF` date DEFAULT NULL,
  `ORDRE_NOTE` smallint(4) DEFAULT NULL,
  `TYPNOT_COD` tinyint(2) DEFAULT NULL,
  `TEXTE_NOTE` varchar(255) DEFAULT NULL,
  `TEXTE_NOT0` varchar(255) DEFAULT NULL,
  `TEXTE_NOT1` varchar(255) DEFAULT NULL,
  `TEXTE_NOT2` varchar(255) DEFAULT NULL,
  `TEXTE_NOT3` varchar(255) DEFAULT NULL,
  `TEXTE_NOT4` varchar(255) DEFAULT NULL,
  `TEXTE_NOT5` varchar(255) DEFAULT NULL,
  `TEXTE_NOT6` varchar(255) DEFAULT NULL,
  `TEXTE_NOT7` varchar(255) DEFAULT NULL,
  `TEXTE_NOT8` varchar(255) DEFAULT NULL,
  `TEXTE_NOT9` varchar(255) DEFAULT NULL,
  `TEXTE_NOTA` varchar(255) DEFAULT NULL,
  `TEXTE_NOTB` varchar(255) DEFAULT NULL,
  `TEXTE_NOTC` varchar(255) DEFAULT NULL,
  `TEXTE_NOTD` varchar(255) DEFAULT NULL,
  `TEXTE_NOTF` varchar(255) DEFAULT NULL,
  `RENVOI_COD` varchar(13) DEFAULT NULL,
  KEY `ACTE_COD` (`ACTE_COD`,`ACDT_MODIF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_NOTE_MENU`
--

CREATE TABLE IF NOT EXISTS `R_NOTE_MENU` (
  `MENU_COD` mediumint(6) DEFAULT NULL,
  `ORDRE_NOTE` smallint(4) DEFAULT NULL,
  `TYPNOT_COD` tinyint(2) DEFAULT NULL,
  `TEXTE_NOTE` varchar(255) DEFAULT NULL,
  `TEXTE_NOT0` varchar(255) DEFAULT NULL,
  `TEXTE_NOT1` varchar(255) DEFAULT NULL,
  `TEXTE_NOT2` varchar(255) DEFAULT NULL,
  `TEXTE_NOT3` varchar(255) DEFAULT NULL,
  `TEXTE_NOT4` varchar(255) DEFAULT NULL,
  `TEXTE_NOT5` varchar(255) DEFAULT NULL,
  `TEXTE_NOT6` varchar(255) DEFAULT NULL,
  `TEXTE_NOT7` varchar(255) DEFAULT NULL,
  `TEXTE_NOT8` varchar(255) DEFAULT NULL,
  `TEXTE_NOT9` varchar(255) DEFAULT NULL,
  `TEXTE_NOTA` varchar(255) DEFAULT NULL,
  `TEXTE_NOTB` varchar(255) DEFAULT NULL,
  `TEXTE_NOTC` varchar(255) DEFAULT NULL,
  `TEXTE_NOTD` varchar(255) DEFAULT NULL,
  `TEXTE_NOTF` varchar(255) DEFAULT NULL,
  `RENVOI_COD` varchar(13) DEFAULT NULL,
  KEY `MENU_COD` (`MENU_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_PAIEMENT`
--

CREATE TABLE IF NOT EXISTS `R_PAIEMENT` (
  `COD_PAIEMT` varchar(1) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`COD_PAIEMT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_PHASE`
--

CREATE TABLE IF NOT EXISTS `R_PHASE` (
  `COD_PHASE` smallint(2) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`COD_PHASE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_PROCEDURE`
--

CREATE TABLE IF NOT EXISTS `R_PROCEDURE` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `ACDT_MODIF` date DEFAULT NULL,
  `PROC_COD` varchar(13) DEFAULT NULL,
  `PRDT_MODIF` date DEFAULT NULL,
  KEY `ACTE_COD` (`ACTE_COD`,`ACDT_MODIF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_PU_BASE`
--

CREATE TABLE IF NOT EXISTS `R_PU_BASE` (
  `AAP_COD` varchar(16) DEFAULT NULL,
  `GRILLE_COD` smallint(3) DEFAULT NULL,
  `PU_BASE` decimal(6,2) DEFAULT NULL,
  `APDT_MODIF` date DEFAULT NULL,
  KEY `AAP_COD` (`AAP_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_REGROUPEMENT`
--

CREATE TABLE IF NOT EXISTS `R_REGROUPEMENT` (
  `COD_REGROU` varchar(3) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`COD_REGROU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_REMBOURSEMENT`
--

CREATE TABLE IF NOT EXISTS `R_REMBOURSEMENT` (
  `COD_REMBOU` tinyint(1) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`COD_REMBOU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_RMO`
--

CREATE TABLE IF NOT EXISTS `R_RMO` (
  `COD_INTERN` smallint(4) DEFAULT NULL,
  `TITRE` varchar(80) DEFAULT NULL,
  `TEXTE` varchar(255) DEFAULT NULL,
  `TEXTE0` varchar(255) DEFAULT NULL,
  `TEXTE1` varchar(255) DEFAULT NULL,
  `TEXTE2` varchar(255) DEFAULT NULL,
  `TEXTE3` varchar(255) DEFAULT NULL,
  `TEXTE4` varchar(255) DEFAULT NULL,
  `TEXTE5` varchar(255) DEFAULT NULL,
  `TEXTE6` varchar(255) DEFAULT NULL,
  `TEXTE7` varchar(255) DEFAULT NULL,
  `TEXTE8` varchar(255) DEFAULT NULL,
  `TEXTE9` varchar(255) DEFAULT NULL,
  `TEXTEA` varchar(255) DEFAULT NULL,
  `TEXTEB` varchar(255) DEFAULT NULL,
  `TEXTEC` varchar(255) DEFAULT NULL,
  `TEXTED` varchar(255) DEFAULT NULL,
  `TEXTEE` varchar(255) DEFAULT NULL,
  `REF_RMO` varchar(5) DEFAULT NULL,
  KEY `COD_INTERN` (`COD_INTERN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB01`
--

CREATE TABLE IF NOT EXISTS `R_TB01` (
  `MODE_TRAIT` varchar(2) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  KEY `MODE_TRAIT` (`MODE_TRAIT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB02`
--

CREATE TABLE IF NOT EXISTS `R_TB02` (
  `COD_ASSONP` varchar(2) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `COEF` decimal(4,3) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `GRILLE_COD` smallint(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB03`
--

CREATE TABLE IF NOT EXISTS `R_TB03` (
  `COD_REGLE` varchar(1) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `LIBELLE` varchar(255) DEFAULT NULL,
  `LIBELLE0` varchar(255) DEFAULT NULL,
  `COEF` decimal(4,3) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `GRILLE_COD` smallint(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB04`
--

CREATE TABLE IF NOT EXISTS `R_TB04` (
  `COD_SPECIA` varchar(3) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `CATSPE_COD` varchar(2) DEFAULT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB05`
--

CREATE TABLE IF NOT EXISTS `R_TB05` (
  `FORFAI_COD` varchar(1) DEFAULT NULL,
  `COD_NATURE` varchar(3) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB06`
--

CREATE TABLE IF NOT EXISTS `R_TB06` (
  `MODIFI_COD` varchar(1) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `UNI_AGEMIN` varchar(1) DEFAULT NULL,
  `AGE_MIN` tinyint(3) UNSIGNED DEFAULT NULL,
  `UNI_AGEMAX` varchar(1) DEFAULT NULL,
  `AGE_MAX` tinyint(3) UNSIGNED DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB07`
--

CREATE TABLE IF NOT EXISTS `R_TB07` (
  `DT_DEBUT` date DEFAULT NULL,
  `METROPOLE` decimal(7,2) DEFAULT NULL,
  `ANTILLES` decimal(7,2) DEFAULT NULL,
  `REUNION` decimal(7,2) DEFAULT NULL,
  `GUYANE` decimal(7,2) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB08`
--

CREATE TABLE IF NOT EXISTS `R_TB08` (
  `COD_CAISSE` smallint(3) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `JOUR_FERIE` int(8) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `TYPE_JOUR` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB09`
--

CREATE TABLE IF NOT EXISTS `R_TB09` (
  `MODIF_COD1` varchar(1) DEFAULT NULL,
  `MODIF_COD2` varchar(1) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB10`
--

CREATE TABLE IF NOT EXISTS `R_TB10` (
  `MODIFI_COD` varchar(1) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `TOP_CTRLE` varchar(1) DEFAULT NULL,
  `TOP_MULTIP` varchar(1) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB11`
--

CREATE TABLE IF NOT EXISTS `R_TB11` (
  `COD_MODIFI` varchar(1) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `COEF` decimal(4,3) DEFAULT NULL,
  `FORFAIT` decimal(7,2) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `GRILLE_COD` smallint(3) DEFAULT NULL,
  KEY `COD_MODIFI` (`COD_MODIFI`,`DT_DEBUT`,`GRILLE_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB12`
--

CREATE TABLE IF NOT EXISTS `R_TB12` (
  `DT_DEBUT` date DEFAULT NULL,
  `FORFAIT_RN` decimal(7,2) DEFAULT NULL,
  `COEF_RNC` decimal(4,3) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB13`
--

CREATE TABLE IF NOT EXISTS `R_TB13` (
  `COD_NATURE` varchar(3) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `TOP_LC` varchar(1) DEFAULT NULL,
  KEY `COD_NATURE` (`COD_NATURE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB14`
--

CREATE TABLE IF NOT EXISTS `R_TB14` (
  `COD_DMT` smallint(3) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `CLDMT_COD` varchar(2) DEFAULT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  KEY `COD_DMT` (`COD_DMT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB15`
--

CREATE TABLE IF NOT EXISTS `R_TB15` (
  `MODIFI_COD` varchar(1) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `COD_MODOC` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB17`
--

CREATE TABLE IF NOT EXISTS `R_TB17` (
  `COD_NATURE` varchar(3) DEFAULT NULL,
  `SPECIA_COD` varchar(3) DEFAULT NULL,
  `DT_OBLIGAT` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB18`
--

CREATE TABLE IF NOT EXISTS `R_TB18` (
  `LOC_DENT` varchar(2) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB19`
--

CREATE TABLE IF NOT EXISTS `R_TB19` (
  `DT_DEBUT` date DEFAULT NULL,
  `NB_MODIFIC` tinyint(1) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB20`
--

CREATE TABLE IF NOT EXISTS `R_TB20` (
  `CONCEPT` varchar(5) DEFAULT NULL,
  `CODE` varchar(10) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB21`
--

CREATE TABLE IF NOT EXISTS `R_TB21` (
  `CLE_FORFAI` smallint(4) DEFAULT NULL,
  `COD_CMUC` varchar(3) DEFAULT NULL,
  `DT_D` date DEFAULT NULL,
  `DT_F` date DEFAULT NULL,
  `INDICE_TAR` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB22`
--

CREATE TABLE IF NOT EXISTS `R_TB22` (
  `COD_CONTXT` smallint(4) DEFAULT NULL,
  `COD_CONTX0` smallint(4) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `GRILLE_COD` smallint(3) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TB23`
--

CREATE TABLE IF NOT EXISTS `R_TB23` (
  `COD_GRILLE` smallint(3) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `DEFINITION` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`COD_GRILLE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TYPE`
--

CREATE TABLE IF NOT EXISTS `R_TYPE` (
  `COD_TYPE` tinyint(1) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`COD_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_TYPE_NOTE`
--

CREATE TABLE IF NOT EXISTS `R_TYPE_NOTE` (
  `COD_TYPNOT` tinyint(2) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`COD_TYPNOT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `R_UNITE_OEUVRE`
--

CREATE TABLE IF NOT EXISTS `R_UNITE_OEUVRE` (
  `COD_UOEUVR` varchar(3) DEFAULT NULL,
  `DT_EFFET` date DEFAULT NULL,
  `VALEUR` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
