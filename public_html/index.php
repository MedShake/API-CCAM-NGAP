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
$p['config']=Spyc::YAMLLoad('../config/config.yml');

// rotation des bases à dates prévues
if(isset($p['config']['sqlBaseRotation']) and is_array($p['config']['sqlBaseRotation'])) {
  ksort($p['config']['sqlBaseRotation']);
  $nowDate=date('Y-m-d');
  foreach($p['config']['sqlBaseRotation'] as $dateApplication=>$baseVersion) {
    if($nowDate >= $dateApplication) {$p['config']['sqlBase']=$baseVersion;}
  }
}

// SQL connexion
$mysqli=msSQL::sqlConnect();


// Router
$router = new AltoRouter();
$routes=Spyc::YAMLLoad('../config/routes.yml');
$router->addRoutes($routes);
//$router->setBasePath($p['config']['urlHostSuffixe']);
$match = $router->match();

// controler
$json=[];
$error=[];

// vérification autorisation clef
$unauthorized=false;
$forbidden=false;
if(!isset($_GET['key']) and !isset($_POST['key'])) {
  $unauthorized = true;
} else {
  if(isset($_GET['key'])) {
    $clef=$_GET['key'];
  } elseif (isset($_POST['key'])) {
    $clef=$_POST['key'];
  }

  if(msSQL::sqlUniqueChamp("select clef from apiKeys where clef='".msSQL::cleanVar($clef)."' and (start <= NOW() or start is NULL) and (end>= NOW() or end is NULL) limit 1")) {
    $forbidden = false;
  } else {
    $forbidden = true;
  }
}


if ($match and is_file('../controlers/'.$match['target'].'.php')) {

  $p['config']['aPropos']['ccam']['ccamVersion']= (float) msTools::getCcamVersion();
  $p['config']['aPropos']['ngap']['ngapVersion']= (string) msTools::getNgapVersion();
  $json['aPropos']=$p['config']['aPropos'];

  include '../controlers/'.$match['target'].'.php';

  if(!isset($template)) {

    //gestion erreurs
    if($unauthorized == true) {
      header($_SERVER["SERVER_PROTOCOL"]." 401 Unauthorized");
      unset($json['data']);
      $json['erreurs']=["ERREUR : vous devez présenter une clef d'authentification (key) pour utiliser cette api !"];
    } elseif($forbidden == true) {
      header($_SERVER["SERVER_PROTOCOL"]." 404 Forbidden");
      unset($json['data']);
      $json['erreurs']=["ERREUR : vous devez présenter une clef d'authentification valide (key) pour utiliser cette api !"];
    } elseif(!empty($error)) {
      header($_SERVER["SERVER_PROTOCOL"]." 404 Not Found");
      unset($json['data']);
      $json['erreurs']=$error;
    } else {
      header($_SERVER["SERVER_PROTOCOL"]." 200 OK");
    }
    header('Content-Type: application/json');
    echo json_encode($json);

  } else {

    $twigEnvironment['cache']=false;
    $twigEnvironment['autoescape']=false;
    $loader = new Twig_Loader_Filesystem('../templates/');
    $twig = new Twig_Environment($loader, $twigEnvironment);
    $twig->getExtension('Twig_Extension_Core')->setDateFormat('d/m/Y', '%d days');
    $twig->getExtension('Twig_Extension_Core')->setTimezone('Europe/Paris');
    echo $twig->render($template.'.html.twig', $p);

  }

} else {
  header($_SERVER["SERVER_PROTOCOL"]." 404 Not Found");
}
