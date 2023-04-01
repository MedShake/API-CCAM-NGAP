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
* Class de recherche des actes
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/

class msCcamRechercher
{
  private $_texte;
  private $_debut=0;
  private $_nombre=0;

  public function setTexte($texte) {
    return $this->_texte = $texte;
  }

  public function setDebut($debut) {
    if(!isset($debut) or !is_numeric($debut) or $debut < 0) $debut = 0;
    return $this->_debut = $debut;
  }

  public function setNombre($nombre) {
    if(!isset($nombre) or !is_numeric($nombre)) $nombre = 10;
    if($nombre > 100 or $nombre < 0) $nombre = 10;
    return $this->_nombre = $nombre;
  }

  /**
   * Obtenir liste actes par recherche texte
   * @return array informations générales
   */
      public function getRechercherActes() {
        $d=msSQL::sql2tabKey("select cod_acte, concat(nom_long, nom_long0, nom_long1, nom_long2, nom_long3, nom_long4, nom_long5, nom_long6, nom_long7, nom_long8, nom_long9, nom_longa, nom_longb, nom_longc, nom_longd, nom_longe) as nom_lg from R_ACTE where concat(nom_long, nom_long0, nom_long1, nom_long2, nom_long3, nom_long4, nom_long5, nom_long6, nom_long7, nom_long8, nom_long9, nom_longa, nom_longb, nom_longc, nom_longd, nom_longe) like '".msSQL::cleanVar($this->_texte)."' or cod_acte like '".msSQL::cleanVar($this->_texte)."' group by cod_acte, nom_lg limit ".$this->_debut.",".$this->_nombre, 'cod_acte', 'nom_lg');
        return $d;
      }

}
