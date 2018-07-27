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
* Class de sortie d'informations sur les correspondances entre codes et libelles
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/


class msCcamCorrespondances
{

  /**
   * Obtenir les informations de correspondance, méthode générique
   * @param  array $tab paramètres
   * @return array      tableau code=>libellé
   */
  public function getCorrespGenerique($tab) {
    $champCode = $tab[0];
    $table = $tab[2];
    if(is_array($tab[1])) {
      $champLibelle1 = 'CONCAT('.implode(',',$tab[1]).') as libelle';
      $champLibelle2 = 'libelle';
    } else {
      $champLibelle1 = $champLibelle2 = $tab[1];
    }
    if($d = msSQL::sql2tabKey("select ".$champCode.", ".$champLibelle1." from ".$table." order by ".$champCode." asc", $champCode, $champLibelle2)) {
      return $d;
    } else {
      return [];
    }
  }
}
