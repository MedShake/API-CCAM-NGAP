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

class msActeCcam
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
 * Obtenir les différents codes activités possiblesp our un acte
 * @return array codes activités possibles
 */
  public function getActeActivites() {
    $d=msSQL::sql2tabSimple("select DISTINCT(ACTIV_COD) from R_ACTE_IVITE where ACTE_COD = '".$this->_acte."' ");
    return array_map('intval', $d);
  }

/**
 * Obtenir les tarifs par code convention pour un acte
 * @return array convention=>tarif
 */
  public function getActeTarifsParConventionPs() {
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
      return $d=[];
    }
  }

/**
 * Obtenir les modificateurs possibles d'un acte par convention
 * @return array convention => modificateurs
 */
  public function getActeModificateursToutesConventions() {
    $d=[];
    $modificateurs = new msModificateurs;
    $modificateurs = $modificateurs->getModificateurActifsCodesToutesConventions();
    foreach($modificateurs as $k=>$v) {
      $q = msSQL::sql2tab("SELECT max(AADT_MODIF) as maxdate, modifi_cod FROM R_ACTIVITE_MODIFICATEUR where AA_CODE='".$this->_acte.$this->_activite."' and modifi_cod in ('".implode("', '",$v)."') and AADT_MODIF='".$this->_dt_modif."' group by AA_CODE,MODIFI_COD");
      if(!empty($q)) {
        $d[$k] = array_column($q, 'modifi_cod');
      }
    }
    return $d;
  }

/**
 * Obtneir le coefficien de majoration du tarif d'un acte par DOM
 * @return array code DOM => coefficien 
 */
  public function getActeMajorationsDom() {
    $dt_modif_phase = msSQL::sqlUniqueChamp("select dt_modif from R_ACTE_IVITE_PHASE where COD_AAP='".$this->_acte.$this->_activite.$this->_phase."' and AADT_MODIF = '".$this->_dt_modif."' limit 1");

    $d =  msSQL::sql2tabKey("select dom_cod, majoration from R_ACTIVITE_PHASE_DOM where AAP_COD='".$this->_acte.$this->_activite.$this->_phase."' and APDT_MODIF = '".$dt_modif_phase."'", 'dom_cod', 'majoration');

    if(!empty($d)) {
      return array_map('floatval', $d);
    } else {
      return $d=[];
    }
  }
}
