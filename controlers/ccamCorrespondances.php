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
* Controler : sortir les correspondances
*
* @author Bertrand Boutillier <b.boutillier@gmail.com>
*
*/


// $corres = array(
//   'conventions'=>['cod_grille', 'libelle','R_TB23'],
//   'fraisDeplacement'=>['cod_fraidp', 'libelle', 'R_FRAIS_DEP'],
//   'regroupements'=>['cod_regrou', 'libelle','R_REGROUPEMENT'],
//   'remboursements'=>['cod_rembou', 'libelle', 'R_REMBOURSEMENT'],
//   'typesActes'=>['cod_type', 'libelle', 'R_TYPE'],
//   'categoriesMedicales'=>['cod_catmed', 'libelle', 'R_CATEGORIE_MEDIC'],
//   'categoriesSpecialites'=>['cod_catspe', 'libelle', 'R_CATE_SPEC'],
//   'classeDmt'=>['cod_cldmt', 'libelle', 'R_CLASSE_DMT'],
//   'conditionsGenerales'=>['cod_condge',
//     ['libelle', 'libelle0', 'libelle1', 'libelle2', 'libelle3', 'libelle4', 'libelle5', 'libelle6', 'libelle7', 'libelle8', 'libelle9', 'libellea', 'libelleb', 'libellec', 'libelled', 'libellee', ], 'R_COND_GEN'],
//   'contextesBeneficiaires'=>['cod_contxt', 'libelle', 'R_CONTEXT_BN'],
//   'contextesProfessionnelSante'=>['cod_contxt', 'libelle', 'R_CONTEXT_PS'],
//   'dents'=>['numero_den', 'libelle', 'R_DENT'],
//   'dom'=>['cod_dom', 'libelle', 'R_DOM'],
//   'exonerationsTicketModerateur'=>['cod_exotm', 'libelle', 'R_EXO_TM'],
//   'extensionsDocumentaires'=>['cod_extens', 'libelle', 'R_EXTENSION'],
//   'forfaits'=>['cod_forfai', 'libelle', 'R_FORFAIT'],
//   'naturesAssurances'=>['cod_natass', 'libelle', 'R_NAT_ASS'],
//   'paiements'=>['cod_paiemt', 'libelle', 'R_PAIEMENT'],
//   'phases'=>['cod_phase', 'libelle', 'R_PHASE'],
//   'typesNotes'=>['cod_typnot', 'libelle', 'R_TYPE_NOTE'],
// );

$corres=Spyc::YAMLLoad('../config/correspondances.yml');

if(in_array($match['params']['correspondance'], array_keys($corres))) {
  $correspondance = new msCcamCorrespondances;
  $json['data']=$correspondance->getCorrespGenerique($corres[$match['params']['correspondance']]);
}
elseif($match['params']['correspondance'] == 'sexes') {
  $json['data']=array(
    0 => 'Sans objet',
    1 => 'Homme',
    2 => 'Femme'
  );
} else {
  $error[]="Ce jeu de correspondance n'existe pas";
}
