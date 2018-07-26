--
--  This file is part of MedShake CCAM NGAP API.
--
--  Copyright (c) 2018
--  Bertrand Boutillier <b.boutillier@gmail.com>
--  http://www.medshake.net
--
--  MedShake CCAM NGAP API is free software: you can redistribute it and/or modify
--  it under the terms of the GNU Affero General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  any later version.
--
--  MedShake CCAM NGAP API is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU Affero General Public License for more details.
--
--  You should have received a copy of the GNU Affero General Public License
--  along with MedShake CCAM NGAP API. If not, see <http://www.gnu.org/licenses/>.
--

--
--  Dump SQL
--
--  @author Bertrand Boutillier <b.boutillier@gmail.com>
--


--
-- Base de données
--

-- --------------------------------------------------------


CREATE TABLE `ngap` (
  `code` varchar(5) NOT NULL,
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
  `dtActualisation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `params` (
  `param` varchar(255) NOT NULL,
  `val` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `params` (`param`, `val`) VALUES
('ccamVersion', ''),
('ngapVersion', '');

CREATE TABLE `R_AAP_PMSI` (
  `AAP_COD` varchar(16) DEFAULT NULL,
  `ICR` smallint(4) DEFAULT NULL,
  `CLASSANT` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTE` (
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
  `SUIVANT` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTE_CLASSE_DMT` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `CLDMT_COD` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTE_CMUC` (
  `CLE_FORFAI` smallint(4) DEFAULT NULL,
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `MODIF_DT` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTE_COND_GEN` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `CONDGE_COD` smallint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTE_EXO_TM` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `ACDT_MODIF` date DEFAULT NULL,
  `EXOTM_COD` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTE_FORFAIT` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `ACDT_MODIF` date DEFAULT NULL,
  `FORFAI_COD` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTE_IVITE` (
  `COD_AA` varchar(14) DEFAULT NULL,
  `DT_MODIF` date DEFAULT NULL,
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `ACDT_MODIF` date DEFAULT NULL,
  `ACTIV_COD` varchar(1) DEFAULT NULL,
  `REGROU_COD` varchar(3) DEFAULT NULL,
  `CATMED_COD` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTE_IVITE_PHASE` (
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
  `ICR` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTE_NAT_ASS` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `NATASS_COD` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTE_PRESCRIPTEUR` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `ACDT_MODIF` date DEFAULT NULL,
  `CATSPE_COD` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTIVITE` (
  `COD_ACTIV` varchar(1) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTIVITE_AGRE_RADIO` (
  `AA_CODE` varchar(14) DEFAULT NULL,
  `AGRAD_COD` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTIVITE_EXECUTANT` (
  `AA_COD` varchar(14) DEFAULT NULL,
  `AADT_MODIF` date DEFAULT NULL,
  `CATSPE_COD` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTIVITE_EXTENSION` (
  `AA_COD` varchar(14) DEFAULT NULL,
  `EXTENS_COD` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTIVITE_MODIFICATEUR` (
  `AA_CODE` varchar(14) DEFAULT NULL,
  `AADT_MODIF` date DEFAULT NULL,
  `MODIFI_COD` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTIVITE_PHASE_DENT` (
  `AAP_COD` varchar(16) DEFAULT NULL,
  `DEN_NUMERO` tinyint(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTIVITE_PHASE_DOM` (
  `AAP_COD` varchar(16) DEFAULT NULL,
  `APDT_MODIF` date DEFAULT NULL,
  `DOM_COD` smallint(3) DEFAULT NULL,
  `MAJORATION` decimal(4,3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ACTIVITE_RMO` (
  `AA_COD` varchar(14) DEFAULT NULL,
  `AADT_MODIF` date DEFAULT NULL,
  `INTERN_COD` smallint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_AGRE_RADIO` (
  `COD_AGRAD` varchar(2) DEFAULT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_ASSOCIATIONS` (
  `AA_CODE1` varchar(14) DEFAULT NULL,
  `DT_MODIF1` date DEFAULT NULL,
  `AA_CODE2` varchar(14) DEFAULT NULL,
  `DT_MODIF2` date DEFAULT NULL,
  `REGLE_COD` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_CATEGORIE_MEDIC` (
  `COD_CATMED` varchar(2) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_CATE_SPEC` (
  `COD_CATSPE` varchar(2) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_CLASSE_DMT` (
  `COD_CLDMT` varchar(2) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_COMPAT_EXO_TM` (
  `EXOTM_COD1` tinyint(1) DEFAULT NULL,
  `EXOTM_COD2` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_COND_GEN` (
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
  `LIBELLEE` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_CONTEXT_BN` (
  `COD_CONTXT` smallint(4) NOT NULL,
  `LIBELLE` varchar(117) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_CONTEXT_PS` (
  `COD_CONTXT` smallint(4) NOT NULL,
  `LIBELLE` varchar(117) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_DENT` (
  `NUMERO_DEN` tinyint(2) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_DOM` (
  `COD_DOM` smallint(3) NOT NULL,
  `LIBELLE` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_EXO_TM` (
  `COD_EXOTM` tinyint(1) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_EXTENSION` (
  `COD_EXTENS` varchar(1) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_FORFAIT` (
  `COD_FORFAI` varchar(1) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_FRAIS_DEP` (
  `COD_FRAIDP` varchar(1) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_GLOSSAIRE` (
  `LIBELLE` varchar(50) DEFAULT NULL,
  `DEFINITION` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_INCOMPATIBILITES` (
  `ACTE_COD1` varchar(13) DEFAULT NULL,
  `DT_MODIF1` date DEFAULT NULL,
  `ACTE_COD2` varchar(13) DEFAULT NULL,
  `DT_MODIF2` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_MENU` (
  `COD_MENU` mediumint(6) NOT NULL,
  `RANG` mediumint(6) DEFAULT NULL,
  `LIBELLE` varchar(255) DEFAULT NULL,
  `COD_PERE` mediumint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_NAT_ASS` (
  `COD_NATASS` varchar(2) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_NOTE_ACTE` (
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
  `RENVOI_COD` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_NOTE_MENU` (
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
  `RENVOI_COD` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_PAIEMENT` (
  `COD_PAIEMT` varchar(1) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_PHASE` (
  `COD_PHASE` smallint(2) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_PROCEDURE` (
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `ACDT_MODIF` date DEFAULT NULL,
  `PROC_COD` varchar(13) DEFAULT NULL,
  `PRDT_MODIF` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_PU_BASE` (
  `AAP_COD` varchar(16) DEFAULT NULL,
  `GRILLE_COD` smallint(3) DEFAULT NULL,
  `PU_BASE` decimal(6,2) DEFAULT NULL,
  `APDT_MODIF` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_REGROUPEMENT` (
  `COD_REGROU` varchar(3) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_REMBOURSEMENT` (
  `COD_REMBOU` tinyint(1) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_RMO` (
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
  `REF_RMO` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB01` (
  `MODE_TRAIT` varchar(2) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB02` (
  `COD_ASSONP` varchar(2) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `COEF` decimal(4,3) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `GRILLE_COD` smallint(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB03` (
  `COD_REGLE` varchar(1) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `LIBELLE` varchar(255) DEFAULT NULL,
  `LIBELLE0` varchar(255) DEFAULT NULL,
  `COEF` decimal(4,3) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `GRILLE_COD` smallint(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB04` (
  `COD_SPECIA` varchar(3) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `CATSPE_COD` varchar(2) DEFAULT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB05` (
  `FORFAI_COD` varchar(1) DEFAULT NULL,
  `COD_NATURE` varchar(3) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB06` (
  `MODIFI_COD` varchar(1) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `UNI_AGEMIN` varchar(1) DEFAULT NULL,
  `AGE_MIN` tinyint(3) UNSIGNED DEFAULT NULL,
  `UNI_AGEMAX` varchar(1) DEFAULT NULL,
  `AGE_MAX` tinyint(3) UNSIGNED DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB07` (
  `DT_DEBUT` date DEFAULT NULL,
  `METROPOLE` decimal(7,2) DEFAULT NULL,
  `ANTILLES` decimal(7,2) DEFAULT NULL,
  `REUNION` decimal(7,2) DEFAULT NULL,
  `GUYANE` decimal(7,2) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB08` (
  `COD_CAISSE` smallint(3) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `JOUR_FERIE` int(8) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `TYPE_JOUR` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB09` (
  `MODIF_COD1` varchar(1) DEFAULT NULL,
  `MODIF_COD2` varchar(1) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB10` (
  `MODIFI_COD` varchar(1) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `TOP_CTRLE` varchar(1) DEFAULT NULL,
  `TOP_MULTIP` varchar(1) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB11` (
  `COD_MODIFI` varchar(1) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `COEF` decimal(4,3) DEFAULT NULL,
  `FORFAIT` decimal(7,2) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `GRILLE_COD` smallint(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB12` (
  `DT_DEBUT` date DEFAULT NULL,
  `FORFAIT_RN` decimal(7,2) DEFAULT NULL,
  `COEF_RNC` decimal(4,3) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB13` (
  `COD_NATURE` varchar(3) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `TOP_LC` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB14` (
  `COD_DMT` smallint(3) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `CLDMT_COD` varchar(2) DEFAULT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB15` (
  `MODIFI_COD` varchar(1) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `COD_MODOC` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB17` (
  `COD_NATURE` varchar(3) DEFAULT NULL,
  `SPECIA_COD` varchar(3) DEFAULT NULL,
  `DT_OBLIGAT` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB18` (
  `LOC_DENT` varchar(2) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB19` (
  `DT_DEBUT` date DEFAULT NULL,
  `NB_MODIFIC` tinyint(1) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB20` (
  `CONCEPT` varchar(5) DEFAULT NULL,
  `CODE` varchar(10) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB21` (
  `CLE_FORFAI` smallint(4) DEFAULT NULL,
  `COD_CMUC` varchar(3) DEFAULT NULL,
  `DT_D` date DEFAULT NULL,
  `DT_F` date DEFAULT NULL,
  `INDICE_TAR` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB22` (
  `COD_CONTXT` smallint(4) DEFAULT NULL,
  `COD_CONTX0` smallint(4) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `GRILLE_COD` smallint(3) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TB23` (
  `COD_GRILLE` smallint(3) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `DEFINITION` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TYPE` (
  `COD_TYPE` tinyint(1) NOT NULL,
  `LIBELLE` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_TYPE_NOTE` (
  `COD_TYPNOT` tinyint(2) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `R_UNITE_OEUVRE` (
  `COD_UOEUVR` varchar(3) DEFAULT NULL,
  `DT_EFFET` date DEFAULT NULL,
  `VALEUR` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `ngap`
  ADD PRIMARY KEY (`code`),
  ADD KEY `codePrestation` (`codePrestation`);

ALTER TABLE `R_AAP_PMSI`
  ADD KEY `AAP_COD` (`AAP_COD`);

ALTER TABLE `R_ACTE`
  ADD KEY `COD_ACTE` (`COD_ACTE`);

ALTER TABLE `R_ACTE_CLASSE_DMT`
  ADD KEY `ACTE_COD` (`ACTE_COD`);

ALTER TABLE `R_ACTE_CMUC`
  ADD KEY `ACTE_COD` (`ACTE_COD`);

ALTER TABLE `R_ACTE_COND_GEN`
  ADD KEY `ACTE_COD` (`ACTE_COD`);

ALTER TABLE `R_ACTE_EXO_TM`
  ADD KEY `ACTE_COD` (`ACTE_COD`,`ACDT_MODIF`);

ALTER TABLE `R_ACTE_FORFAIT`
  ADD KEY `ACTE_COD` (`ACTE_COD`,`ACDT_MODIF`);

ALTER TABLE `R_ACTE_IVITE`
  ADD KEY `ACTE_COD` (`ACTE_COD`),
  ADD KEY `COD_AA` (`COD_AA`);

ALTER TABLE `R_ACTE_IVITE_PHASE`
  ADD KEY `COD_AAP` (`COD_AAP`),
  ADD KEY `AA_COD` (`AA_COD`);

ALTER TABLE `R_ACTE_NAT_ASS`
  ADD KEY `ACTE_COD` (`ACTE_COD`);

ALTER TABLE `R_ACTE_PRESCRIPTEUR`
  ADD KEY `ACTE_COD` (`ACTE_COD`,`ACDT_MODIF`);

ALTER TABLE `R_ACTIVITE`
  ADD PRIMARY KEY (`COD_ACTIV`);

ALTER TABLE `R_ACTIVITE_AGRE_RADIO`
  ADD KEY `AA_CODE` (`AA_CODE`);

ALTER TABLE `R_ACTIVITE_EXECUTANT`
  ADD KEY `AA_COD` (`AA_COD`,`AADT_MODIF`);

ALTER TABLE `R_ACTIVITE_EXTENSION`
  ADD KEY `AA_COD` (`AA_COD`);

ALTER TABLE `R_ACTIVITE_MODIFICATEUR`
  ADD KEY `AA_CODE` (`AA_CODE`,`AADT_MODIF`);

ALTER TABLE `R_ACTIVITE_PHASE_DENT`
  ADD KEY `AAP_COD` (`AAP_COD`);

ALTER TABLE `R_ACTIVITE_PHASE_DOM`
  ADD KEY `AAP_COD` (`AAP_COD`,`APDT_MODIF`);

ALTER TABLE `R_ACTIVITE_RMO`
  ADD KEY `AA_COD` (`AA_COD`,`AADT_MODIF`);

ALTER TABLE `R_AGRE_RADIO`
  ADD KEY `COD_AGRAD` (`COD_AGRAD`);

ALTER TABLE `R_ASSOCIATIONS`
  ADD KEY `AA_CODE1` (`AA_CODE1`,`DT_MODIF1`);

ALTER TABLE `R_CATEGORIE_MEDIC`
  ADD PRIMARY KEY (`COD_CATMED`);

ALTER TABLE `R_CATE_SPEC`
  ADD PRIMARY KEY (`COD_CATSPE`);

ALTER TABLE `R_CLASSE_DMT`
  ADD PRIMARY KEY (`COD_CLDMT`);

ALTER TABLE `R_COND_GEN`
  ADD PRIMARY KEY (`COD_CONDGE`);

ALTER TABLE `R_CONTEXT_BN`
  ADD PRIMARY KEY (`COD_CONTXT`);

ALTER TABLE `R_CONTEXT_PS`
  ADD PRIMARY KEY (`COD_CONTXT`);

ALTER TABLE `R_DENT`
  ADD PRIMARY KEY (`NUMERO_DEN`);

ALTER TABLE `R_DOM`
  ADD PRIMARY KEY (`COD_DOM`);

ALTER TABLE `R_EXO_TM`
  ADD PRIMARY KEY (`COD_EXOTM`);

ALTER TABLE `R_EXTENSION`
  ADD PRIMARY KEY (`COD_EXTENS`);

ALTER TABLE `R_FORFAIT`
  ADD PRIMARY KEY (`COD_FORFAI`);

ALTER TABLE `R_FRAIS_DEP`
  ADD PRIMARY KEY (`COD_FRAIDP`);

ALTER TABLE `R_GLOSSAIRE`
  ADD KEY `LIBELLE` (`LIBELLE`);

ALTER TABLE `R_INCOMPATIBILITES`
  ADD KEY `ACTE_COD1` (`ACTE_COD1`,`DT_MODIF1`);

ALTER TABLE `R_MENU`
  ADD PRIMARY KEY (`COD_MENU`),
  ADD KEY `COD_PERE` (`COD_PERE`);

ALTER TABLE `R_NAT_ASS`
  ADD PRIMARY KEY (`COD_NATASS`);

ALTER TABLE `R_NOTE_ACTE`
  ADD KEY `ACTE_COD` (`ACTE_COD`,`ACDT_MODIF`);

ALTER TABLE `R_NOTE_MENU`
  ADD KEY `MENU_COD` (`MENU_COD`);

ALTER TABLE `R_PAIEMENT`
  ADD PRIMARY KEY (`COD_PAIEMT`);

ALTER TABLE `R_PHASE`
  ADD PRIMARY KEY (`COD_PHASE`);

ALTER TABLE `R_PROCEDURE`
  ADD KEY `ACTE_COD` (`ACTE_COD`,`ACDT_MODIF`);

ALTER TABLE `R_PU_BASE`
  ADD KEY `AAP_COD` (`AAP_COD`);

ALTER TABLE `R_REGROUPEMENT`
  ADD PRIMARY KEY (`COD_REGROU`);

ALTER TABLE `R_REMBOURSEMENT`
  ADD PRIMARY KEY (`COD_REMBOU`);

ALTER TABLE `R_RMO`
  ADD KEY `COD_INTERN` (`COD_INTERN`);

ALTER TABLE `R_TB01`
  ADD KEY `MODE_TRAIT` (`MODE_TRAIT`);

ALTER TABLE `R_TB11`
  ADD KEY `COD_MODIFI` (`COD_MODIFI`,`DT_DEBUT`,`GRILLE_COD`);

ALTER TABLE `R_TB13`
  ADD KEY `COD_NATURE` (`COD_NATURE`);

ALTER TABLE `R_TB14`
  ADD KEY `COD_DMT` (`COD_DMT`);

ALTER TABLE `R_TB23`
  ADD PRIMARY KEY (`COD_GRILLE`);

ALTER TABLE `R_TYPE`
  ADD PRIMARY KEY (`COD_TYPE`);

ALTER TABLE `R_TYPE_NOTE`
  ADD PRIMARY KEY (`COD_TYPNOT`);
