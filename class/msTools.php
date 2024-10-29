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
* Class d'outils divers
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/

class msTools
{

/**
 * Obtenir la version de la CCAM
 * @return int n° de version de la ccam
 */
  public static function getCcamVersion() {
    global $p;
    return msSQL::sqlUniqueChamp("select val from `".$p['config']['sqlBaseCcam']."`.params where param = 'ccamVersion'");
  }

/**
 * Obtenir la version de la NGAP
 * @return int n° de version de la ccam
 */
  public static function getNgapVersion() {
    global $p;
    return msSQL::sqlUniqueChamp("select val from `".$p['config']['sqlBaseNgap']."`.params where param = 'ngapVersion'");
  }

/**
 * Caster comme int les clefs spécifique d'un array
 * @param  array $array    tableau à caster
 * @param  array $arrayKey tablea des clefs à traiter
 * @return void
 */
  public static function convertToInt(&$array, $arrayKey) {
    if(is_array($array) and is_array($arrayKey)) {
      foreach($arrayKey as $v) {
        if(isset($array[$v])) settype($array[$v], 'int');
      }
    }
  }

/**
 * Caster comme float les clefs spécifique d'un array
 * @param  array $array    tableau à caster
 * @param  array $arrayKey tablea des clefs à traiter
 * @return void
 */
  public static function convertToFloat(&$array, $arrayKey) {
    if(is_array($array) and is_array($arrayKey)) {
      foreach($arrayKey as $v) {
        if(isset($array[$v])) settype($array[$v], 'float');
      }
    }
  }

/**
 * Valider le format d'un code CCAM
 * @param  string $code code à évaluer
 * @return boolean       true / false
 */
  public static function validateCcamCode($code) {
    if(preg_match('#^[A-Z]{4}[0-9]{3}$#', $code)) {
      if(msSQL::sqlUniqueChamp("select cod_acte from R_ACTE where cod_acte='".$code."' limit 1")) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

/**
 * Valider le paramètre chapitre CCAM
 * @param  string $code chapitre sous la forme x.x.x
 * @return boolean    true / false
 */
  public static function validateChapitreString($code) {
    $codeRe = str_replace('.','', $code);
    if(preg_match('#^[0-9]+$#', $codeRe) and is_numeric($codeRe[0])) return true;
    return false;
  }

/**
 * Valider une date du calendrier
 * @param  string $date   la date
 * @param  string $format son format
 * @return bool         true or false
 */
  public static function validateDate($date, $format = 'd/m/Y H:i:s')
  {
      $d = DateTime::createFromFormat($format, $date);
      return $d && $d->format($format) == $date;
  }

}
