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


-- --------------------------------------------------------

--
-- Structure de la table `ccam`
--

CREATE TABLE `ccam` (
  `param` varchar(255) NOT NULL,
  `val` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `ccam`
--

INSERT INTO `ccam` (`param`, `val`) VALUES
('ccamVersion', '');

-- --------------------------------------------------------

--
-- Structure de la table `R_ACTE`
--

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

-- --------------------------------------------------------

--
-- Structure de la table `R_ACTE_IVITE`
--

CREATE TABLE `R_ACTE_IVITE` (
  `COD_AA` varchar(14) DEFAULT NULL,
  `DT_MODIF` date DEFAULT NULL,
  `ACTE_COD` varchar(13) DEFAULT NULL,
  `ACDT_MODIF` date DEFAULT NULL,
  `ACTIV_COD` varchar(1) DEFAULT NULL,
  `REGROU_COD` varchar(3) DEFAULT NULL,
  `CATMED_COD` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `R_ACTE_IVITE_PHASE`
--

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

-- --------------------------------------------------------

--
-- Structure de la table `R_ACTIVITE_MODIFICATEUR`
--

CREATE TABLE `R_ACTIVITE_MODIFICATEUR` (
  `AA_CODE` varchar(14) DEFAULT NULL,
  `AADT_MODIF` date DEFAULT NULL,
  `MODIFI_COD` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `R_ACTIVITE_PHASE_DOM`
--

CREATE TABLE `R_ACTIVITE_PHASE_DOM` (
  `AAP_COD` varchar(16) DEFAULT NULL,
  `APDT_MODIF` date DEFAULT NULL,
  `DOM_COD` smallint(3) DEFAULT NULL,
  `MAJORATION` decimal(4,3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `R_PU_BASE`
--

CREATE TABLE `R_PU_BASE` (
  `AAP_COD` varchar(16) DEFAULT NULL,
  `GRILLE_COD` smallint(3) DEFAULT NULL,
  `PU_BASE` decimal(6,2) DEFAULT NULL,
  `APDT_MODIF` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `R_TB11`
--

CREATE TABLE `R_TB11` (
  `COD_MODIFI` varchar(1) DEFAULT NULL,
  `DT_DEBUT` date DEFAULT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `COEF` decimal(4,3) DEFAULT NULL,
  `FORFAIT` decimal(7,2) DEFAULT NULL,
  `DT_FIN` date DEFAULT NULL,
  `GRILLE_COD` smallint(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `R_TB23`
--

CREATE TABLE `R_TB23` (
  `COD_GRILLE` smallint(3) NOT NULL,
  `LIBELLE` varchar(100) DEFAULT NULL,
  `DEFINITION` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `R_ACTE`
--
ALTER TABLE `R_ACTE`
  ADD KEY `COD_ACTE` (`COD_ACTE`);

--
-- Index pour la table `R_ACTE_IVITE`
--
ALTER TABLE `R_ACTE_IVITE`
  ADD KEY `ACTE_COD` (`ACTE_COD`);

--
-- Index pour la table `R_ACTE_IVITE_PHASE`
--
ALTER TABLE `R_ACTE_IVITE_PHASE`
  ADD KEY `COD_AAP` (`COD_AAP`),
  ADD KEY `AA_COD` (`AA_COD`);

--
-- Index pour la table `R_ACTIVITE_MODIFICATEUR`
--
ALTER TABLE `R_ACTIVITE_MODIFICATEUR`
  ADD KEY `AA_CODE` (`AA_CODE`);

--
-- Index pour la table `R_ACTIVITE_PHASE_DOM`
--
ALTER TABLE `R_ACTIVITE_PHASE_DOM`
  ADD KEY `AAP_COD` (`AAP_COD`);

--
-- Index pour la table `R_TB23`
--
ALTER TABLE `R_TB23`
  ADD PRIMARY KEY (`COD_GRILLE`);
