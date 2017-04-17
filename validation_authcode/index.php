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
$dataPOST = trim(file_get_contents('php://input'));
$xmlData = json_decode(json_encode(simplexml_load_string($dataPOST)), true);
$authcode=$xmlData["authcode"];
$userid=$xmlData["userid"];
$minimum_grab=$xmlData["minimum_grab"];
if($subwebid=='9002') {$web_code='RP'; $namegame = 'Remipoker';}
if($subwebid=='9001') {$web_code='KP'; $namegame = 'Kartupoker';}
if($subwebid=='172') {$web_code='DA'; $namegame = 'Domino88';}
if($subwebid=='42') {$web_code='PKR'; $namegame = 'Pokerkeren';}
$q=sqlsrv_query($sqlconn,"select id,authcode,userid from u6048user_id where loginid='".$userid."' and subwebid = '".$subwebid."' ");
$r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);

// For Get Authcode by POST loginid
if($xmlData["get_authcode"]==TRUE)
{
	$generate_code = $r["authcode"];
	header("Access-Control-Allow-Origin: *");
	header("Content-Type: application/json; charset=UTF-8");
	if ($r["userid"] && $generate_code){
		$outp .= '{"Game":"'.$namegame.'",';
		$outp .= '"UserId":"'.$userid.'",';
		$outp .= '"Authcode":"'.$generate_code.'",';
		$outp .= '"Message":"Authcode accepted"}'; 
	}else{
		$outp .= '{"Game":"'.$namegame.'",';
		$outp .= '"Message":"Invalid UserID or Authcode not generated"}'; 
	}
	echo($outp);
	exit;
}
//end of get authcode

if ($r["id"]){
	$v_userid = $r["userid"];
	$generate_code = $r["authcode"];
	if ($generate_code == $authcode){
		$success = "Valid";
		$q_poin = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select poin from u6048user_coin where userid = '".$v_userid."'"),SQLSRV_FETCH_ASSOC);
		$poin = $q_poin["poin"];
		if ($minimum_grab > 0){
			if($poin >= $minimum_grab){
				sqlsrv_query($sqlconn,"insert into j2365join_poinhistory (tdate,userid,amount,ket,subwebid) values (GETDATE(),'".$userid."','".$poin."','k88 $generate_code','".$subwebid."')");
				sqlsrv_query($sqlconn,"update u6048user_coin set poin=0 where userid='".$v_userid."'");
			}else{
				$success = "";
				$error = "Poin not enough minimum poin is $minimum_grab";
			}
		}else{
			if ($poin > 0){
				sqlsrv_query($sqlconn,"insert into j2365join_poinhistory (tdate,userid,amount,ket,subwebid) values (GETDATE(),'".$userid."','".$poin."','k88 $generate_code','".$subwebid."')");
				sqlsrv_query($sqlconn,"update u6048user_coin set poin=0 where userid='".$v_userid."'");
			}else $error = "Authcode rejected";
		}
	}else $error = "Authcode rejected";
}else{
	$error = "Authcode rejected";
}

//grab point

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
if ($success){
	$outp .= '{"Game":"'.$namegame.'",';
	$outp .= '"UserId":"'.$userid.'",';
	$outp .= '"Authcode":"'.$generate_code.'",';
	$outp .= '"Point":"'.$poin.'",';
	$outp .= '"Message":"Authcode accepted"}'; 
}else{
	$outp .= '{"Game":"'.$namegame.'",';
	$outp .= '"UserId":"'.$userid.'",';
	$outp .= '"Authcode":"'.$authcode.'",';
	$outp .= '"Message":"'.$error.'"}'; 
}
echo($outp);
?>