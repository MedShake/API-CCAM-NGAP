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
* Class de sortie d'informations sur acte NGAP isolé
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/

class msNgapActe
{
/**
 * Code de l'acte NGAP
 * @var string
 */
  private $_acte;
/**
 * Code profession
 * @var string
 */
  private $_codeProf;

/**
 * Codes professions pour sélection en base
 * @var array
 */
  private $_codeProf_params;

/**
 * Code prestation
 * @var string
 */
  private $_code_prestation;
/**
 * Code du type d'acte
 * @var string
 */
  private $_type_acte;
/**
 * Base SQL
 * @var string
 */
  private $_base_ngap;


/**
 * Fixer la base SQL NGAP
 */
  function __construct() {
    global $p;
    $this->_base_ngap = '`'.$p['config']['sqlBaseNgap'].'`';
  }

/**
 * Définir le code acte
 * @param string $acte code acte NGAP
 */
  public function setActe($acte) {
    if(msSQL::sqlUniqueChamp("select code from ".$this->_base_ngap.".ngap where code='".msSQL::cleanVar(strip_tags($acte))."' limit 1")) {
      return $this->_acte = msSQL::cleanVar(strip_tags($acte));
    } else {
      return false;
    }
  }

/**
 * Définir la profession concernée
 * @param string $prof code profession
 */
  public function setCodeProf($prof) {
    if(msSQL::sqlUniqueChamp("select codeProf from ".$this->_base_ngap.".ngap where codeProf='".msSQL::cleanVar(strip_tags($prof))."' limit 1")) {
      $this->_codeProf = $prof;
      $this->_setCodeProfParams();
      return $this->_codeProf;
    } else {
      $this->_codeProf = 'mspe';
      $this->_setCodeProfParams();
      return $this->_codeProf;
    }
  }

/**
 * Définir le code prestation
 * @param string $acte code acte NGAP
 */
  public function setCodePrestation($code_prestation) {
    if(msSQL::sqlUniqueChamp("select code from ".$this->_base_ngap.".ngap where codePrestation='".msSQL::cleanVar(strip_tags($code_prestation))."' limit 1")) {
      return $this->_code_prestation = msSQL::cleanVar(strip_tags($code_prestation));
    } else {
      return false;
    }
  }

/**
 * Définir le type d'acte
 * @param string $type_acte type d'acte
 */
  public function setTypeActe($type_acte) {
    if(in_array($type_acte, ['consultation', 'majoration', 'indemnite', 'forfait', 'autre'])) {
      if($type_acte == 'indemnite') $type_acte='indemnité';
      return $this->_type_acte = $type_acte;
    } else {
      return false;
    }
  }

/**
 * Définir les catégorie de recherche en fonction du contexte prof
 * @return array codes contextes prof pour sql
 */
  private function _setCodeProfParams() {
   $d=msSQL::sqlUniqueChamp("select base
   from ".$this->_base_ngap.".ngap_codesProf
   where code='".$this->_codeProf."' limit 1");
   return $this->_codeProf_params = array_filter([$this->_codeProf, $d]);
  }

/**
 * Obtenir les informations de base sur un acte NGAP
 * @return array informations générales
 */
  public function getActeInfoBase() {
    $d=[];
    if($d=msSQL::sql2tabKey("select code, codeProf, label, type, partieNgap, articleNgap, dtDecisionUncam, codePrestation, tarifMetro, tarif971, tarif972, tarif973, tarif974, tarif976, dtActualisation
    from ".$this->_base_ngap.".ngap
    where code = '".$this->_acte."'
    order by codeProf desc",'codeProf')) {
      foreach($d as $codeProf=>$v) {
        $this->setCodeProf($codeProf);
        $d[$codeProf]['cumul']=$this->getActesCumulables();
        msTools::convertToFloat($d[$codeProf], ['partieNgap', 'tarifMetro', 'tarif971', 'tarif972', 'tarif973', 'tarif974', 'tarif976']);
      }
      $this->setCodeProf(NULL);
    }
    return $d;
  }

/**
 * Obtenir les informations générales sur un acte NGAP
 * @return array informations générales
 */
  public function getActeInfoGenerales() {
    $d=[];
    if($d=msSQL::sqlUnique("select code, label, type, partieNgap, articleNgap, dtDecisionUncam, codePrestation, tarifMetro, tarif971, tarif972, tarif973, tarif974, tarif976, dtActualisation
    from ".$this->_base_ngap.".ngap
    where code = '".$this->_acte."' and codeProf in ('".implode("', '", $this->_codeProf_params)."')
    order by codeProf='".$this->_codeProf_params[0]."' desc
    limit 1")) {
      $d['cumul']=$this->getActesCumulables();
      msTools::convertToFloat($d, ['partieNgap', 'tarifMetro', 'tarif971', 'tarif972', 'tarif973', 'tarif974', 'tarif976']);
    }
    return $d;
  }

/**
 * Obtenir une liste d'actes via le code prestation agrégé
 * @return array codes actes
 */
  public function getListeActesViaCodePrestation() {
    if($d=msSQL::sql2tabSimple("select code
    from ".$this->_base_ngap.".ngap
    where codePrestation = '".$this->_code_prestation."'
    group by code ")) {
      return $d;
    } else {
      return [];
    }
  }

/**
 * Obtenir la liste des actes référencés par type
 * @return array taleau avec code et label
 */
  public function getListeActesViaType() {
    $tab=[];
    if(isset($this->_codeProf_params[1])) {
      $d1=msSQL::sql2tabKey("select code,label
      from ".$this->_base_ngap.".ngap
      where type = '".$this->_type_acte."'
      and codeProf = '".$this->_codeProf_params[1]."'
      ", "code", "label");
    } else {
      $d1=[];
    }

    if($d0=msSQL::sql2tabKey("select code,label
    from ".$this->_base_ngap.".ngap
    where type = '".$this->_type_acte."'
    and codeProf = '".$this->_codeProf_params[0]."'
    ", "code", "label")) {
    } else {
      $d0=[];
    }

    $d=array_merge($d1, $d0);
    ksort($d);

    foreach($d as $k=>$v) {
      $tab[]=array(
        'code'=>$k,
        'label'=>$v
      );
    }
    return $tab;
  }

/**
 * Obtenir les actes cumulables avec l'acte
 * @return array tableau des codes acte
 */
  public function getActesCumulables() {
    if($d=msSQL::sql2tab("SELECT code1, code2 FROM ".$this->_base_ngap.".ngap_cumul where (code1='".$this->_acte."' or code2='".$this->_acte."') and codeProf in ('".implode("', '", $this->_codeProf_params)."')")) {
      $d = array_unique(array_merge(array_column($d,'code1'), array_column($d,'code2')));
      if (($key = array_search($this->_acte, $d)) !== false) {
          unset($d[$key]);
      }
      sort($d);
      return $d;
    } else {
      return [];
    }
  }

  /**
   * Obtenir la liste des grilles tarifaires
   * @return array code grille tarifaire => data
   */
    public function getCodesProfession() {
      $d = msSQL::sql2tabKey("select code, label FROM ".$this->_base_ngap.".ngap_codesProf order by label", 'code');
      return $d;
    }

}
