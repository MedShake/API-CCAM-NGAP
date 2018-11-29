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
* Class de sortie d'informations sur les modificateurs CCAM
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/

class msCcamModificateurs extends msCcamActe
{

  private $_modificateur;

  public function setModificateur($modificateur) {
    return $this->_modificateur=$modificateur;
  }

/**
 * Obtenir les modificateurs actifs par convention
 * @return array modificateurs actis
 */
  public function getModificateurActifsCodesPourConvention() {
    if($d = msSQL::sql2tabSimple("SELECT cod_modifi FROM R_TB11 WHERE `GRILLE_COD` = '".$this->getConvention()."' AND DT_DEBUT < NOW() and (DT_FIN > NOW() or DT_FIN is NULL) ORDER BY `R_TB11`.`COD_MODIFI` ASC")) {
      return $d;
    } else {
      return [];
    }
  }

/**
 * Obtenir les modificaturs actifs pour toutes les conventions
 * @return array code convention => modificateurs
 */
  public function getModificateurActifsCodesToutesConventions() {
    $modiflist=[];
    for($i=3;$i<17;$i++) {
      $this->setConvention($i);
      $modiflist[$i] = $this->getModificateurActifsCodesPourConvention();
    }
    return $modiflist;
  }

/**
 * Obtenir la liste des modificateurs pour une convention avec les détails
 * @return array code => détails
 */
  public function getModificateurActifsListePourConvention() {
    $d = msSQL::sql2tabKey("SELECT cod_modifi, dt_debut, dt_fin, libelle, coef, forfait FROM `R_TB11` WHERE DT_DEBUT < NOW() and (DT_FIN > NOW() or DT_FIN is null)  and GRILLE_COD = '".$this->getConvention()."' ORDER BY `R_TB11`.`COD_MODIFI` ASC", 'cod_modifi');
    if(!empty($d)) {
      foreach($d as $k=>$v) {
        msTools::convertToFloat($d[$k], ['coef', 'forfait']);
      }
      return $d;
    } else {
      return [];
    }

  }

/**
 * Obtenir les informations par convention PS pour un modificateur
 * @return array  codePs => détails
 */
  public function getModificateurDataParConvention() {
      $d = msSQL::sql2tabKey("SELECT dt_debut, dt_fin, libelle, coef, forfait, grille_cod FROM `R_TB11` WHERE DT_DEBUT < NOW() and (DT_FIN > NOW() or DT_FIN is null)  and COD_MODIFI = '".$this->_modificateur."' ORDER BY `R_TB11`.`GRILLE_COD` ASC", 'grille_cod');

      if(!empty($d)) {
        foreach($d as $k=>$v) {
          msTools::convertToFloat($d[$k], ['coef', 'forfait']);
        }
        return $d;
      } else {
        return [];
      }
  }

}
