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
* Controler : informations sur un modificateur
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/

if(isset($match['params']['modificateur']) and is_string($match['params']['modificateur']) and strlen($match['params']['modificateur']) === 1) {

  $modificateur = new msCcamModificateurs;
  $modificateur->setModificateur($match['params']['modificateur']);
  $json['data']=$modificateur->getModificateurDataParConvention();

} else {
  $error[]="erreur";
}
