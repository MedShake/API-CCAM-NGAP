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
* Controler : arborescence CCAM, chapitre
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/

$arbo = new msCcamArborescence;

if(isset($match['params']['chapitre'])) {
  if(msTools::validateChapitreString($match['params']['chapitre'])) {
    if($arbo->setChapitre($match['params']['chapitre']) == false) {
      $error[]="Ce chapitre CCAM n'existe pas ou n'est pas dans un format correct";
    }
  } else {
    $error[]="Le chapitre CCAM n'est pas exprimé dans un format correct";
  }
} elseif(isset($match['params']['code'])) {
  if($arbo->setChapitreParCode($match['params']['code']) == false ) {
    $error[]="Ce chapitre CCAM n'existe pas";
  }
}

if(empty($error)) {
  $json['data'] = $arbo->getArboChapitreData();
  $json['data']['notes'] = $arbo->getArboChapitreNotes();
  $json['data']['actes'] = $arbo->getArboChapitreActes();
  $json['data']['parents'] = $arbo->getArboChapitreParents();
  $json['data']['enfants'] = $arbo->getArboChapitreEnfants();
}
