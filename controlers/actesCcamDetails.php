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
* Controler : acte CCAM, détails 
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/

$acte = new msActeCcam;

if(msTools::validateCcamCode($match['params']['code'])) {
  $acte->setActe($match['params']['code']);

  if(is_numeric($match['params']['activite'])) {
    $acte->setActivite((int)$match['params']['activite']);
  } else {
    $error[]="Le code activité n'est pas correct pour cet acte";
  }
  if(is_numeric($match['params']['phase'])) {
    $acte->setPhase((int)$match['params']['phase']);
  } else {
    $error[]="Le code phase n'est pas correct pour cet acte";
  }

  if(!empty($error) or !$acte->verifierActeActivitePhase()) {
    $error[]="L'association code activité / code phase n'est pas correct pour cet acte";
  }

} else {
  $error[]="Le code CCAM n'est pas correct";
}



if(empty($error)) {

  $json['data']['activite']=$acte->getActivite();
  $json['data']['phase']=$acte->getPhase();

  $json['data'] = array_merge($json['data'], $acte->getActeInfoGenerales());
  $json['data']['tarifParConventionPs']=$acte->getActeTarifsParConventionPs();
  $json['data']['modificateursApplicables']=$acte->getActeModificateursToutesConventions();
  $json['data']['majorationsDom']=$acte->getActeMajorationsDom();
}
