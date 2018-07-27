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

ini_set('display_errors', 1);
setlocale(LC_ALL, "fr_FR.UTF-8");

// Composer class auto-upload
require '../vendor/autoload.php';

// Class MedShake CCAM NGAP API auto-upload
spl_autoload_register(function ($class) {
    if (is_file('../class/' . $class . '.php')) {
        include '../class/' . $class . '.php';
    }
});

// chargment des paramètres de configuration
$p['config']=Spyc::YAMLLoad('../config/config.yml');

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
if ($match and is_file('../controlers/'.$match['target'].'.php')) {

  $p['config']['aPropos']['ccam']['ccamVersion']= (int) msTools::getCcamVersion();
  $p['config']['aPropos']['ngap']['ngapVersion']= (string) msTools::getNgapVersion();
  $json['aPropos']=$p['config']['aPropos'];

  include '../controlers/'.$match['target'].'.php';

  if(!isset($template)) {

    //gestion erreurs
    if(!empty($error)) {
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
