<?php
if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
    $ip_request = $_SERVER['HTTP_CLIENT_IP'];
} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
    $ip_request = $_SERVER['HTTP_X_FORWARDED_FOR'];
} else {
    $ip_request = $_SERVER['REMOTE_ADDR'];
}

$ip_lock="119.81.104.87";
//$ip_lock="103.249.162.207";
if ($ip_lock != $ip_request){
	//exit("Access restricted !!");
}

include("../config.php");
session_start();
$dataPOST = trim(file_get_contents('php://input'));
$xmlData = json_decode(json_encode(simplexml_load_string($dataPOST)), true);
$authcode=$xmlData["authcode"];
$userid=$xmlData["userid"];

// $authcode='c0ba8cfa407a06da5697477d2';
// $userid='KEHUIYUN';


if($subwebid=='9002') {$web_code='RP'; $namegame = 'Remipoker';}
if($subwebid=='9001') {$web_code='KP'; $namegame = 'Kartupoker';}
if($subwebid=='172') {$web_code='DA'; $namegame = 'Domino88';}
if($subwebid=='42') {$web_code='PKR'; $namegame = 'Pokerkeren';}

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

$Result = array(
    "Game" => $namegame,
);

$reqAPIAuthcode = array(
    "auth"    => $authapi,
    "webid"   => $subwebid,
    "loginid" => $xmlData["userid"],
    "authcode"=> $xmlData["authcode"],
    "type"    => 5,
);

$respAPIAuthcode = sendAPI($url_Api . "/val-authcode", $reqAPIAuthcode, 'JSON', '02e97eddc9524a1e');

// obj to array
$res2 = json_decode(json_encode($respAPIAuthcode), true);
unset($res2['status']);
echo json_encode(array_merge($Result, $res2));
?>