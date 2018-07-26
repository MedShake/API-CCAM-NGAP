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
* Class de sortie d'informations sur les conventions ps
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/

class msCcamConventions
{

/**
 * Obtenir la liste des conventions ps reconnues
 * @return array code convention => data
 */
  public function getConventionsListe() {
    $d = msSQL::sql2tabKey("select cod_grille, libelle, definition from R_TB23 order by cod_grille", 'cod_grille');
    foreach($d as $k=>$v) {
      settype($d[$k]['cod_grille'], 'int');

    }
    return $d;
  }


}
