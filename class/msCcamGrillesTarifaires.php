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
* Class de sortie d'informations sur les grilles tarifaires et leur détermination
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/

class msCcamGrillesTarifaires
{
  private $_codePS;
  private $_codeBenef;
  private $_dateSoins;

  public function setCodePS($codePS) {
    return $this->_codePS=$codePS;
  }

  public function setCodeBenef($codeBenef) {
    return $this->_codeBenef=$codeBenef;
  }

  public function setDateSoins($dateSoins) {
    if(msTools::validateDate($dateSoins, 'Y-m-d')) {
      return $this->_dateSoins=$dateSoins;
    } else {
      return $this->_dateSoins=date('Y-m-d');
    }

  }

/**
 * Obtenir la liste des grilles tarifaires
 * @return array code grille tarifaire => data
 */
  public function getGrillesTarifaires() {
    $d = msSQL::sql2tabKey("select cod_grille, libelle, definition from R_TB23 order by cod_grille", 'cod_grille');
    foreach($d as $k=>$v) {
      settype($d[$k]['cod_grille'], 'int');

    }
    return $d;
  }

  public function getGrilleTarifaireCode() {
    $d = msSQL::sqlUniqueChamp("select grille_cod from R_TB22 where cod_contxt='".$this->_codePS."' and cod_contx0='".$this->_codeBenef."' and dt_debut <= '".$this->_dateSoins."' and (dt_fin >= '".$this->_dateSoins."' or dt_fin is null)");
    return array(
      'codeGrilleTarifaire'=>$d,
      'dateSoins'=>$this->_dateSoins
    );
  }


}
