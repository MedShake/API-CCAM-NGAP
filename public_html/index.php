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
 * Index
 *
 * @author Bertrand Boutillier <b.boutillier@gmail.com>
 *
 */

ini_set('display_errors', 0);
setlocale(LC_ALL, "fr_FR.UTF-8");

// Composer class auto-upload
require '../vendor/autoload.php';

// Class MedShake CCAM NGAP API auto-upload
spl_autoload_register(function ($class) {
  if (is_file('../class/' . $class . '.php')) {
    include '../class/' . $class . '.php';
  }
});

// chargement des paramètres de configuration
$p['config'] = yaml_parse_file('../config/config.yml');

// rotation des bases CCAM à dates prévues
if (isset($p['config']['sqlBaseCcamRotation']) and is_array($p['config']['sqlBaseCcamRotation'])) {
  ksort($p['config']['sqlBaseCcamRotation']);
  $nowDate = date('Y-m-d');
  foreach ($p['config']['sqlBaseCcamRotation'] as $dateApplication => $baseVersion) {
    if ($nowDate >= $dateApplication) {
      $p['config']['sqlBaseCcam'] = $baseVersion;
    }
  }
}

// rotation des bases NGAP à dates prévues
if (isset($p['config']['sqlBaseNgapRotation']) and is_array($p['config']['sqlBaseNgapRotation'])) {
  ksort($p['config']['sqlBaseNgapRotation']);
  $nowDate = date('Y-m-d');
  foreach ($p['config']['sqlBaseNgapRotation'] as $dateApplication => $baseVersion) {
    if ($nowDate >= $dateApplication) {
      $p['config']['sqlBaseNgap'] = $baseVersion;
    }
  }
}

// SQL connexion
$mysqli = msSQL::sqlConnect();


// Router
$router = new AltoRouter();
$routes = yaml_parse_file('../config/routes.yml');
$router->addRoutes($routes);
//$router->setBasePath($p['config']['urlHostSuffixe']);
$match = $router->match();

// controler
$json = [];
$error = [];

// vérification autorisation clef
$unauthorized = false;
$forbidden = false;
if (!isset($_GET['key']) and !isset($_POST['key'])) {
  $unauthorized = true;
} else {
  if (isset($_GET['key'])) {
    $clef = $_GET['key'];
  } elseif (isset($_POST['key'])) {
    $clef = $_POST['key'];
  }

  if (msSQL::sqlUniqueChamp("select clef from `" . $p['config']['sqlBaseConfig'] . "`.apiKeys where clef='" . msSQL::cleanVar($clef) . "' and (start <= NOW() or start is NULL) and (end>= NOW() or end is NULL) limit 1")) {
    $forbidden = false;
  } else {
    $forbidden = true;
  }
}


if ($match and is_file('../controlers/' . $match['target'] . '.php')) {

  $p['config']['aPropos']['ccam']['ccamVersion'] = (float) msTools::getCcamVersion();
  $p['config']['aPropos']['ngap']['ngapVersion'] = (string) msTools::getNgapVersion();
  $json['aPropos'] = $p['config']['aPropos'];

  include '../controlers/' . $match['target'] . '.php';

  if (!isset($template)) {

    //gestion erreurs
    if ($unauthorized == true) {
      header($_SERVER["SERVER_PROTOCOL"] . " 401 Unauthorized");
      unset($json['data']);
      $json['erreurs'] = ["ERREUR : vous devez présenter une clef d'authentification (key) pour utiliser cette api !"];
    } elseif ($forbidden == true) {
      header($_SERVER["SERVER_PROTOCOL"] . " 404 Forbidden");
      unset($json['data']);
      $json['erreurs'] = ["ERREUR : vous devez présenter une clef d'authentification valide (key) pour utiliser cette api !"];
    } elseif (!empty($error)) {
      header($_SERVER["SERVER_PROTOCOL"] . " 404 Not Found");
      unset($json['data']);
      $json['erreurs'] = $error;
    } else {
      header($_SERVER["SERVER_PROTOCOL"] . " 200 OK");
    }
    header('Content-Type: application/json');
    echo json_encode($json);
  } else {

    echo "
    <!doctype html>
    <html lang=\"fr\">
      <head>
        <!-- Required meta tags -->
        <meta charset=\"utf-8\">
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\">

        <title>MedShake CCAM NGAP API</title>
        <meta name=\"Description\" content=\"API sous licence AGPL* pour un accès facile aux données CCAM et NGAP et le calcul des honoraires médicaux\"/>
      </head>
      <body>
        <h1>MedShake CCAM NGAP API</h1>
        <br>
        <ul>
        <li>Auteur : Bertrand Boutillier <b.boutillier@gmail.com></li>
        <li>Licence : GNU Affero General Public License</li>
        <li>Sources : <a href=\"https://github.com/MedShake/API-CCAM-NGAP\">https://github.com/MedShake/API-CCAM-NGAP</a></li>
        <li>Démo et documentation : <a href=\"https://api-ccam-ngap.medshake.net/\">https://api-ccam-ngap.medshake.net/</a></li>
        <li><a href=\"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=7ZP9L2BG2JHMY\">Faire un don à l'auteur de l'API</a>.</li>
        <li style=\"color: red;\">Le paramètre key doit être passé en GET ou en POST pour obtenir une réponse de l'API. <strong>La clef par défaut est initialisée en base à 1234</strong>.</li>
        <li style=\"color: red;\">Les données CCAM présentes dans le repository peuvent ne pas être celles de la dernière version de la CCAM. Les données NGAP ne sont PAS présentes.</li>
        <li>Test local : <a href=\"/ccam/actes/BACA008/?key=1234\">/ccam/actes/BACA008/?key=1234</a></li>
        </ul>
      </body>
    </html>";
  }
} else {
  header($_SERVER["SERVER_PROTOCOL"] . " 404 Not Found");
}
