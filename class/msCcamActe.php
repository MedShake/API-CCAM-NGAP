<?php
/*
* This file is part of MedShake CCAM NGAP API.
*
* Copyright (c) 2018
* Bertrand Boutillier <b.boutillier@gmail.com>
* http://www.medshake.net
*
* MedShake CCAM NGAP API is free software: you can redistribute it and/or modify
* it under the terms of the GNU Affero General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* any later version.
*
* MedShake CCAM NGAP API is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Affero General Public License for more details.
*
* You should have received a copy of the GNU Affero General Public License
* along with MedShake CCAM NGAP API. If not, see <http://www.gnu.org/licenses/>.
*/

/**
* Class de sortie d'informations sur acte CCAM isolé
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/

class msCcamActe
{
/**
 * Code de l'acte CCAM
 * @var string
 */
  private $_acte;
/**
 * Code de l'activité
 * @var int
 */
  private $_activite;
/**
 * Code de la phase
 * @var int
 */
  private $_phase;
/**
 * Code convention PS
 * @var int
 */
  private $_convention;
/**
 * Date de modification de l'acte
 * @var string
 */
  private $_dt_modif;
/**
 * Date de modification acte + activité
 * @var string
 */
  private $_aadt_modif;
/**
 * Menu code de l'acte
 * @var int
 */
  private $_menu_cod;

/**
 * Définir le code acte
 * @param string $acte code acte CCAM
 */
  public function setActe($acte) {
    return $this->_acte = $acte;
  }
/**
 * Définir le code activité
 * @param int $activite code activité
 */
  public function setActivite($activite) {
    return $this->_activite = $activite;
  }
/**
 * Définir le code phase
 * @param int $phase code phase
 */
  public function setPhase($phase) {
    return $this->_phase = $phase;
  }
/**
 * Définir le code convention PS
 * @param int $convention code convention ps
 */
  public function setConvention($convention) {
    return $this->_convention = $convention;
  }
/**
 * Obtenir le code activité
 * @return int code activité
 */
  public function getActivite() {
    return $this->_activite;
  }
/**
 * Obtenir le code phase
 * @return int code phase
 */
  public function getPhase() {
    return $this->_phase;
  }
/**
 * Obtenir le code convention
 * @return int code convention
 */
  public function getConvention() {
    return $this->_convention;
  }

/**
 * Obtenir les informations générales sur un acte CCAM
 * @return array informations générales
 */
  public function getActeInfoGenerales() {
    $d=msSQL::sqlUnique("select cod_acte, dt_modif, menu_cod, fraidp_cod, rembou_cod, type_cod, cod_struct, nom_court, concat(nom_long, nom_long0, nom_long1, nom_long2, nom_long3, nom_long4, nom_long5, nom_long6, nom_long7, nom_long8, nom_long9, nom_longa, nom_longb, nom_longc, nom_longd, nom_longe) as nom_long, sexe, dt_creatio, dt_fin, entente, dt_effet, dt_arrete, dt_jo, mfic_place, precedent, suivant from R_ACTE where cod_acte = '".$this->_acte."' order by dt_modif desc limit 1");
    msTools::convertToInt($d, ['menu_cod', 'type_cod', 'sexe', 'mfic_place', 'rembou_cod']);
    $this->_dt_modif = $d['dt_modif'];
    return $d;
  }

/**
 * Obtenir les informations sur l'acte quand il est associé à activité et phase
 * @return array tableau data
 */
  public function getActeActivitePhaseComplement() {
    $activite = msSQL::sqlUnique("select cod_aa, activ_cod, regrou_cod, catmed_cod, dt_modif as aadt_modif from R_ACTE_IVITE where COD_AA='".$this->_acte.$this->_activite."' and ACDT_MODIF ='".$this->_dt_modif."' ");

    $phase = msSQL::sqlUnique("select cod_aap, dt_modif as aapdt_modif, uoeuvr_cod, uoedt_effe, paiem_cod, nb_seances, coefficien, supplement, nb_dents, age_min, age_max, score, pratique, icr from R_ACTE_IVITE_PHASE where COD_AAP='".$this->_acte.$this->_activite.$this->_phase."' and AADT_MODIF ='".$activite['aadt_modif']."' ");

    $d= array_merge($activite, $phase);
    msTools::convertToInt($d, ['nb_seances', 'age_min', 'age_max']);
    msTools::convertToFloat($d, ['coefficien', 'supplement', 'score', 'pratique', 'icr']);
    return $d;
  }

/**
 * Vérifier si le activité existe pour l'acte
 * @return bool true / false
 */
  public function verifierActeActivite() {
    if(msSQL::sqlUnique("select COD_AA from R_ACTE_IVITE where COD_AA='".$this->_acte.$this->_activite."' limit 1")) {
      return true;
    } else {
      return false;
    }
  }

/**
 * Vérifier si le activité et phase existent conjointement pour l'acte
 * @return bool true / false
 */
  public function verifierActeActivitePhase() {
    if(msSQL::sqlUnique("select COD_AAP from R_ACTE_IVITE_PHASE where COD_AAP='".$this->_acte.$this->_activite.$this->_phase."' limit 1")) {
      return true;
    } else {
      return false;
    }
  }

/**
 * Obtenir les différents codes activités possibles pour un acte
 * @return array codes activités possibles
 */
  public function getActeActivites() {
    if($d=msSQL::sql2tabKey("select DISTINCT(ACTIV_COD) as code from R_ACTE_IVITE where ACTE_COD = '".$this->_acte."' order by code",'code')) {
      foreach($d as $k=>$v) {
        $tab[$k]=msSQL::sql2tabSimple("select DISTINCT(phase_cod) as phase from R_ACTE_IVITE_PHASE where AA_COD='".$this->_acte.$k."' order by phase");
        $tab[$k] = array_map('intval', $tab[$k]);
      }
    }
    if(!empty($tab)) {
      return $tab;
    } else {
      return [];
    }
  }

/**
 * Obtenir les tarifs par code convention pour un acte
 * @return array convention=>tarif
 */
  public function getActeTarifsParGrilleTarifaire() {
    $d =  msSQL::sql2tabKey("select t1.grille_cod as convention, t1.pu_base as pu
    from R_PU_BASE as t1
    inner join
    ( select grille_cod , max(apdt_modif) as max_date
    from R_PU_BASE where aap_cod = '".$this->_acte.$this->_activite.$this->_phase."' group by aap_cod, grille_cod ) as t2
    on t1.grille_cod = t2.grille_cod and
    t1.apdt_modif = t2.max_date
    where t1.aap_cod = '".$this->_acte.$this->_activite.$this->_phase."'
    ",'convention', 'pu');
    if(!empty($d)) {
      return array_map('floatval', $d);
    } else {
      return [];
    }
  }

/**
 * Obtenir le forfait prévu pour un acte
 * @return string code forfait
 */
  public function getActeForfait() {
    if(!isset($this->_dt_modif)) $this->_getActeDerniereDtModif();
    return msSQL::sqlUniqueChamp("select forfai_cod from R_ACTE_FORFAIT where ACTE_COD='".$this->_acte."' and ACDT_MODIF = '".$this->_dt_modif."' limit 1");
  }

/**
 * Obtenir les modificateurs possibles d'un acte par convention
 * @return array convention => modificateurs
 */
  public function getActeModificateursToutesConventions() {
    $d=[];
    $modificateurs = new msCcamModificateurs;
    if($modificateurs = $modificateurs->getModificateurActifsCodesToutesConventions()) {
      foreach($modificateurs as $k=>$v) {
        $q = msSQL::sql2tab("SELECT max(AADT_MODIF) as maxdate, modifi_cod FROM R_ACTIVITE_MODIFICATEUR where AA_CODE='".$this->_acte.$this->_activite."' and modifi_cod in ('".implode("', '",$v)."') and AADT_MODIF='".$this->_dt_modif."' group by AA_CODE,MODIFI_COD");
        if(!empty($q)) {
          $d[$k] = array_column($q, 'modifi_cod');
        }
      }
    }
    return $d;
  }

/**
 * Obtenir le coefficien de majoration du tarif d'un acte par DOM
 * @return array code DOM => coefficien
 */
  public function getActeMajorationsDom() {
    $dt_modif_phase = msSQL::sqlUniqueChamp("select dt_modif from R_ACTE_IVITE_PHASE where COD_AAP='".$this->_acte.$this->_activite.$this->_phase."' and AADT_MODIF = '".$this->_dt_modif."' limit 1");

    $d =  msSQL::sql2tabKey("select dom_cod, majoration from R_ACTIVITE_PHASE_DOM where AAP_COD='".$this->_acte.$this->_activite.$this->_phase."' and APDT_MODIF = '".$dt_modif_phase."'", 'dom_cod', 'majoration');

    if(!empty($d)) {
      return array_map('floatval', $d);
    } else {
      return [];
    }
  }

/**
 * Obtenir les données du positionnement de l'acte dans l'arborescence CCAM
 * @return array tableau ascendant
 */
  public function getActePosition() {
    if(!isset($this->_menu_cod)) $this->_getActeMenuCod();
    $tabMenu=[];
    $currentMenuCod=$this->_menu_cod;
    while($currentMenuCod>1) {
      $currentRow=$this->_getLigneRMenu($currentMenuCod);
      msTools::convertToInt($currentRow, ['cod_menu', 'rang', 'cod_pere']);
      $tabMenu[]=$currentRow;
      $currentMenuCod=$currentRow['cod_pere'];
    }
    return array_reverse($tabMenu);
  }

/**
 * Obtenir les notes de l'acte
 * @return array tableau des notes
 */
  public function getActeNotes() {
    if(!isset($this->_dt_modif)) $this->_getActeDerniereDtModif();
    $d = msSQL::sql2tab("select t1.ordre_note, t1.typnot_cod, t2.libelle as typnot_libelle, concat(TEXTE_NOTE, TEXTE_NOT0, TEXTE_NOT1, TEXTE_NOT2, TEXTE_NOT3, TEXTE_NOT4, TEXTE_NOT5, TEXTE_NOT6, TEXTE_NOT7, TEXTE_NOT8, TEXTE_NOT9, TEXTE_NOTA, TEXTE_NOTB, TEXTE_NOTC, TEXTE_NOTD, TEXTE_NOTF) as texte_note from R_NOTE_ACTE as t1 left join R_TYPE_NOTE as t2 on t1.typnot_cod = t2.cod_typnot where t1.ACTE_COD='".$this->_acte."' and t1.ACDT_MODIF='".$this->_dt_modif."' order by t1.ordre_note asc");

    if(!empty($d)) {
      foreach($d as $k=>$v) {
        msTools::convertToInt($d[$k], ['ordre_note', 'typnot_cod']);
      }
      return $d;
    } else {
      return [];
    }
  }

/**
 * Obtenir la liste des actes associables avec l'acte
 * @return array tableau des codes acte
 */
  public function getActeAssociations() {
    if(!isset($this->_dt_modif)) $this->_getActeDerniereDtModif();
    $d = msSQL::sql2tab("select aa_code2 from R_ASSOCIATIONS where AA_CODE1 = '".$this->_acte.$this->_activite."' and DT_MODIF1 = '".$this->_dt_modif."' ");
    if(!empty($d)) {
      $d = array_column($d, 'aa_code2');
      function fcn(&$item) {
         $item = substr($item, 0,7);
      }
      array_walk($d, "fcn");
      return $d;
    } else {
      return [];
    }
  }

/**
 * Obtenir la liste des actes incompatibles avec l'acte
 * @return array tableau des codes acte
 */
  public function getActeIncompatibilites() {
    if(!isset($this->_dt_modif)) $this->_getActeDerniereDtModif();
    $d = msSQL::sql2tab("select acte_cod2 from R_INCOMPATIBILITES where ACTE_COD1 = '".$this->_acte."' and DT_MODIF1 = '".$this->_dt_modif."' ");
    if(!empty($d)) {
      $d = array_column($d, 'acte_cod2');
      return $d;
    } else {
      return [];
    }
  }

/**
 * Obtenir les prescripteurs possible d'un acte
 * @return array tableau code=>libelle
 */
  public function getActePrescripteursPossibles() {
    if(!isset($this->_dt_modif)) $this->_getActeDerniereDtModif();
    $d = msSQL::sql2tabKey("select t1.CATSPE_COD as code, t2.libelle
    from R_ACTE_PRESCRIPTEUR as t1
    left join R_CATE_SPEC as t2 on t2.COD_CATSPE = t1.CATSPE_COD
    where t1.ACTE_COD='".$this->_acte."' and t1.ACDT_MODIF = '".$this->_dt_modif."' order by code", 'code', 'libelle');
    if(empty($d)) return [];
    return $d;
  }

/**
 * Obtenir les executants possibles par code activité
 * @return [type] [description]
 */
  public function getActeExecutantsPossiblesParActivite() {
    $d=[];
    if($activitesPossibles = array_keys($this->getActeActivites())) {
      foreach($activitesPossibles as $acti) {
        $this->setActivite($acti);
        $this->_getActeActiviteDerniereDtModif();
        $d[$acti] = msSQL::sql2tabKey("select t1.CATSPE_COD as code, t2.libelle
          from R_ACTIVITE_EXECUTANT as t1
          left join R_CATE_SPEC as t2 on t2.COD_CATSPE = t1.CATSPE_COD
          where t1.AA_COD='".$this->_acte.$this->_activite."' and t1.AADT_MODIF = '".$this->_aadt_modif."' order by code", 'code', 'libelle');
      }
    }
    return $d;
  }

/**
 * Obtenir les informations de prise en charge d'un acte
 * @return array tableau
 */
  public function getActePriseEnCharge() {
    $d=[];
    $acte = $this->getActeInfoGenerales();

    $corres = new msCcamCorrespondances;
    $corres = $corres->getCorrespGenerique(['cod_rembou', 'libelle', 'R_REMBOURSEMENT']);
    $d['admissionRemboursement'][$acte['rembou_cod']]=$corres[$acte['rembou_cod']];
    $d['conditionsGenerales'] = $this->_getActeConditionsGen();
    $d['ententePrealable'] =  $acte['entente'];
    $d['ticketModerateur'] = $this->_getActeExonTicketModerateur();
    $d['natureAssurancesPermises'] = $this->_getActeNatureAssurancesPermises();
    return $d;
  }

/**
 * Obtenir les informations des conditions générales de prise en charge d'un acte
 * @return array tableau code=>libelle
 */
  private function _getActeConditionsGen() {
    $d = msSQL::sql2tabKey("select t1.condge_cod as code, concat(t2.libelle, t2.libelle0, t2.libelle1, t2.libelle2, t2.libelle3, t2.libelle4, t2.libelle5, t2.libelle6, t2.libelle7, t2.libelle8, t2.libelle9, t2.libellea, t2.libelleb, t2.libellec, t2.libelled, t2.libellee) as libelle
    from R_ACTE_COND_GEN as t1
    left join R_COND_GEN as t2 on t2.COD_CONDGE = t1.condge_cod
    where t1.ACTE_COD = '".$this->_acte."' ", 'code', 'libelle');
    if(empty($d)) return [];
    return $d;
  }

/**
 * Obtenir les informations de prise en charge du ticket modérateur d'un acte
 * @return array tableau code=>libelle
 */
  private function _getActeExonTicketModerateur() {
    if(!isset($this->_dt_modif)) $this->_getActeDerniereDtModif();
    $d = msSQL::sql2tabKey("select t1.exotm_cod as code, t2.libelle
    from R_ACTE_EXO_TM as t1
    left join R_EXO_TM as t2 on t2.cod_exotm = t1.exotm_cod
    where t1.ACTE_COD='".$this->_acte."' and t1.ACDT_MODIF = '".$this->_dt_modif."'", 'code', 'libelle');
    if(empty($d)) return [];
    return $d;
  }

/**
 * Obtenir les informations sur la nature des assurances possibles pour un acte
 * @return array tableau code=>libelle
 */
  private function _getActeNatureAssurancesPermises() {
    $d = msSQL::sql2tabKey("select t1.NATASS_COD as code, t2.libelle
    from R_ACTE_NAT_ASS as t1
    left join R_NAT_ASS as t2 on t2.COD_NATASS = t1.NATASS_COD
    where t1.ACTE_COD='".$this->_acte."' ", 'code', 'libelle');
    if(empty($d)) return [];
    return $d;
  }

/**
 * Obtenir les actes voisins dans l'arborescence CCAM
 * @return array tableau des actes, sans filtres particulier
 */
  public function getActesVoisins() {
    if(!isset($this->_menu_cod)) $this->_getActeMenuCod();
    $d = msSQL::sql2tabSimple("SELECT distinct(COD_ACTE)  FROM `R_ACTE` WHERE `MENU_COD` = '".$this->_menu_cod."' order by COD_ACTE asc");
    if(empty($d)) return [];
    return $d;
  }

/**
 * Obtenir le menu_cod d'un acte
 * @return int menu_cod de l'acte
 */
  private function _getActeMenuCod() {
    return $this->_menu_cod = msSQL::sqlUniqueChamp("select menu_cod from R_ACTE where COD_ACTE='".$this->_acte."' order by DT_MODIF desc limit 1");
  }

/**
 * Obtenir la dernière dt_modif d'un acte
 * @return string dt_modif de l'acte
 */
  private function _getActeDerniereDtModif() {
    return $this->_dt_modif = msSQL::sqlUniqueChamp("select dt_modif from R_ACTE where COD_ACTE='".$this->_acte."' order by DT_MODIF desc limit 1");
  }

/**
 * Obtenir la dernière dt_modif acte + activité
 * @return string dt_modif de l'acte
 */
  private function _getActeActiviteDerniereDtModif() {
    return $this->_aadt_modif = msSQL::sqlUniqueChamp("select dt_modif from R_ACTE_IVITE where COD_AA='".$this->_acte.$this->_activite."' order by DT_MODIF desc limit 1");
  }

/**
 * Obtenir une ligne de R_MENU
 * @param  int $cod_menu cod_menu
 * @return array           ligne de R_MENU
 */
  private function _getLigneRMenu($cod_menu) {
    if($d = msSQL::sqlUnique("select cod_menu, rang, libelle, cod_pere from R_MENU where cod_menu='".$cod_menu."' limit 1 ")) {
      return $d;
    } else {
      return [];
    }
  }
}
