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
* Class de sortie d'informations sur l'arborescence CCAM '
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/

class msCcamArborescence
{
  /**
   * Chapitre de la CCAM, de la forme x.x.x
   * @var string
   */
  private $_chapitre;
  /**
   * Code du chapitre (cod_menu)
   * @var int
   */
  private $_chapitreCodMenu;
  /**
   * Rang du chapitre dans son parent
   * @var int
   */
  private $_chapitreRang;
  /**
   * Libellé du chapitre
   * @var string
   */
  private $_chapitreLibelle;
  /**
   * Code père du chapitre
   * @var int
   */
  private $_chapitreCodPere;
  /**
   * Arborescence jusqu'à la racine à partir du chapitre courant
   * @var array
   */
  private $_chapitreArboParents=[];

/**
 * Définir le chapitre
 * @param string $chapitre cahpitre de la forme x.x.x
 */
  public function setChapitre($chapitre) {
    $this->_chapitre=$chapitre;
    return $this->_getArboChapitreEtParents();
  }

/**
 * Définir le chapitre par son code (cod_menu)
 * @param int $chapitreCodMenu code numérique du menu
 */
  public function setChapitreParCode($chapitreCodMenu) {
    $this->_chapitreCodMenu=$chapitreCodMenu;
    return $this->_getArboChapitreEtParentsParCode();
  }

/**
 * Obtenir l'arborescence des parents jusqu'à la racine
 * @return array tableau d'arborescence
 */
  public function getArboChapitreParents() {
    return $this->_chapitreArboParents;
  }

/**
 * Obtenir les chapitres du 1er niveau de l'arborescence
 * @return array tableau des chapitres du 1er niveau
 */
  public function getArboRacine() {
    $d = msSQL::sql2tab("select cod_menu, rang, libelle from R_MENU where cod_pere = 1 order by rang");
    foreach($d as $k=>$v) {
      settype($d[$k]['cod_menu'], 'int');
      settype($d[$k]['rang'], 'int');
    }
    return $d;
  }

/**
 * Obtenir les data basiques sur le chapitre courant
 * @return array tableau des data de base sur le chapitre courant
 */
  public function getArboChapitreData() {
    return array(
      'cod_menu'=>(int) $this->_chapitreCodMenu,
      'rang'=>(int) $this->_chapitreRang,
      'libelle'=>$this->_chapitreLibelle,
      'cod_pere'=>(int) $this->_chapitreCodPere
    );
  }

/**
 * Obtenir les notes attachées au chapitre courant
 * @return array notes attachées au chapitre courant
 */
  public function getArboChapitreNotes() {
    $d = msSQL::sql2tab("select t1.ordre_note, t1.typnot_cod, t2.libelle as typnot_libelle, concat(TEXTE_NOTE, TEXTE_NOT0, TEXTE_NOT1, TEXTE_NOT2, TEXTE_NOT3, TEXTE_NOT4, TEXTE_NOT5, TEXTE_NOT6, TEXTE_NOT7, TEXTE_NOT8, TEXTE_NOT9, TEXTE_NOTA, TEXTE_NOTB, TEXTE_NOTC, TEXTE_NOTD, TEXTE_NOTF) as texte_note, renvoi_cod from R_NOTE_MENU as t1 left join R_TYPE_NOTE as t2 on t1.typnot_cod = t2.cod_typnot where t1.MENU_COD='".$this->_chapitreCodMenu."' order by t1.ordre_note asc");

    if(!empty($d)) {
      foreach($d as $k=>$v) {
        msTools::convertToInt($d[$k], ['ordre_note', 'typnot_cod']);
      }
      return $d;
    } else {
      return $d=[];
    }
  }

/**
 * Obtenir les actes inclus dans le chapitre courant
 * @return array actes du chapitre courant
 */
  public function getArboChapitreActes() {
    if($d = msSQL::sql2tabSimple("select distinct(cod_acte) from R_ACTE where menu_cod='".$this->_chapitreCodMenu."' ")) {
      return $d;
    } else {
      return [];
    }
  }

/**
 * Obtenir les chapitres enfants du chapitre courant
 * @return array chapitres enfants du chapitre courant
 */
  public function getArboChapitreEnfants() {
    if($d = msSQL::sql2tab("select cod_menu, rang, libelle, cod_pere from R_MENU where cod_pere = '".$this->_chapitreCodMenu."' order by rang")) {
      return $d;
    } else {
      return [];
    }
  }

/**
 * Obtenir les informations sur le chapitre courant et ses parents via chapitre
 * @return int code_menu ou false si non trouvé
 */
  private function _getArboChapitreEtParents() {
    if(is_int($this->_chapitre)) {
      $menu=$this->_getLigneRMenuParPereRang(1, $this->_chapitre);
      if(empty($menu)) {
        return false;
      } else {
        $this->_chapitreCodMenu=$menu['cod_menu'];
        $this->_chapitreRang=$menu['rang'];
        $this->_chapitreLibelle=$menu['libelle'];
        $this->_chapitreCodPere=$menu['cod_pere'];
      }
    } else {
      $arbo=explode('.', $this->_chapitre);
      $pere=1;
      foreach($arbo as $k=>$rang) {
        if(is_numeric($rang)) {
          $this->_chapitreArboParents[$k]=$this->_getLigneRMenuParPereRang($pere, $rang);
          if(empty($this->_chapitreArboParents[$k])) {
            return false;
          } else {
            settype($this->_chapitreArboParents[$k]['cod_menu'], 'int');
            settype($this->_chapitreArboParents[$k]['rang'], 'int');
            settype($this->_chapitreArboParents[$k]['cod_pere'], 'int');
            $pere=$this->_chapitreArboParents[$k]['cod_menu'];
          }
        }
      }
      $this->_chapitreCodMenu=$this->_chapitreArboParents[$k]['cod_menu'];
      $this->_chapitreRang=$this->_chapitreArboParents[$k]['rang'];
      $this->_chapitreLibelle=$this->_chapitreArboParents[$k]['libelle'];
      $this->_chapitreCodPere=$this->_chapitreArboParents[$k]['cod_pere'];
      unset($this->_chapitreArboParents[count($this->_chapitreArboParents) - 1]);

    }

    if(is_int($this->_chapitreCodMenu)) {
      return $this->_chapitreCodMenu;
    } else {
      return false;
    }
  }

/**
 * Obtenir les informations sur le chapitre courant et ses parents via code menu
 * @return [type] [description]
 */
  private function _getArboChapitreEtParentsParCode() {
    $tabMenu=[];
    $currentMenuCod=$this->_chapitreCodMenu;
    while($currentMenuCod>1) {
      $currentRow=$this->_getLigneRMenu($currentMenuCod);
      if(empty($currentRow)) return false;
      msTools::convertToInt($currentRow, ['cod_menu', 'rang', 'cod_pere']);
      $tabMenu[]=$currentRow;
      $currentMenuCod=$currentRow['cod_pere'];
    }
    if(isset($tabMenu[0])){
      $this->_chapitreCodMenu=$tabMenu[0]['cod_menu'];
      $this->_chapitreRang=$tabMenu[0]['rang'];
      $this->_chapitreLibelle=$tabMenu[0]['libelle'];
      $this->_chapitreCodPere=$tabMenu[0]['cod_pere'];
    }
    if(!empty($tabMenu)) {
      unset($tabMenu[0]);
      $this->_chapitreArboParents = array_reverse($tabMenu);
      return true;
    } else {
      return false;
    }
  }

/**
* Obtenir une ligne de R_MENU par code pere et rang
* @param  int $cod_menu cod_menu
* @return array           ligne de R_MENU
*/
  private function _getLigneRMenuParPereRang($cod_pere, $rang) {
    if($d = msSQL::sqlUnique("select cod_menu, rang, libelle, cod_pere from R_MENU where cod_pere = '".$cod_pere."' and rang='".$rang."' limit 1")) {
      return $d;
    } else {
      return [];
    }
  }

/**
 * Obtenir une ligne de R_MENU par son code
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
