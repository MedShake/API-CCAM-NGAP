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

class msActeNgap
{
/**
 * Code de l'acte NGAP
 * @var string
 */
  private $_acte;

/**
 * Définir le code acte
 * @param string $acte code acte CCAM
 */
  public function setActe($acte) {
    return $this->_acte = msSQL::cleanVar(strip_tags($acte));
  }

/**
 * Obtenir les informations générales sur un acte CCAM
 * @return array informations générales
 */
  public function getActeInfoGenerales() {
    $d=msSQL::sqlUnique("select code, label, codeFse, tarifMetro, tarif971, tarif972, tarif973, tarif974, tarif976 from ngap where code = '".$this->_acte."' limit 1");
    msTools::convertToFloat($d, ['tarifMetro', 'tarif971', 'tarif972', 'tarif973', 'tarif974', 'tarif976']);
    return $d;
  }


}
