<?php
session_start();
include("config.php");
$myaes = new Myaes();

$reqFastCheck = array(
		"auth"   => $authapi,
		"agent"  => $agentwlable,	
		"id_div" => 'user_name',
		"id_val" => 'cintadp',
		"id_val2"=> ''
	);
$respon = json_encode($reqFastCheck);
$myaes->setPrivate('02e97eddc9524a1e');
$response = $myaes->getEnc($respon);
echo $response ;

?>