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
* Controler : acte CCAM, associations
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/

$acte = new msCcamActe;

if(msTools::validateCcamCode($match['params']['code'])) {
  $acte->setActe($match['params']['code']);

  if(is_numeric($match['params']['activite'])) {
    $acte->setActivite((int)$match['params']['activite']);
  } else {
    $error[]="Le code activité n'est pas correct pour cet acte";
  }

  if(!$acte->verifierActeActivite()) {
    $error[]="L'activité n'existe pas pour cet acte";
  }

} else {
  $error[]="Le code CCAM n'est pas correct";
}



if(empty($error)) {
  $json['data'] = $acte->getActeAssociations();
}
