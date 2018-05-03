<?php
session_start();
$val = $_POST["id_val"];
include("config.php");
if($_POST["id_div"] == "user_nameid" or $_POST["id_div"] == "user_name"){
	$_POST["id_val"] = $val;
}

if($_POST["id_div"] != "the_cap"){
	$reqFastCheck = array(
		"auth"   => $authapi,
		"agent"  => $agentwlable,	
		"id_div" => $_POST["id_div"],
		"id_val" => $_POST["id_val"],
		"id_val2"=> $_POST["id_val2"]
	);
	$response = sendAPI($url_Api."/fastchecking",$reqFastCheck,'JSON','02e97eddc9524a1e');

	if ($response->status == 200){
		echo "1;Valid";
	}else{
		echo "0;".$response->msg . ';';
	}
}else{
	
	if($_POST["id_val"] == $_SESSION['CAPTCHAString']){
		echo "1;Valid";
	}else{
		echo "0;Captcha tidak sama";
	}
}
?>