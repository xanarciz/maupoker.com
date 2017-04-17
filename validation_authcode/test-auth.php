<?php
if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
    $ip_request = $_SERVER['HTTP_CLIENT_IP'];
} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
    $ip_request = $_SERVER['HTTP_X_FORWARDED_FOR'];
} else {
    $ip_request = $_SERVER['REMOTE_ADDR'];
}

/*$ip_lock="119.81.104.92";
//$ip_lock="103.249.162.207";
if ($ip_lock != $ip_request){
	exit("Access restricted !!");
}*/

include("../config.php");
$dataPOST = trim(file_get_contents('php://input'));
$xmlData = json_decode(json_encode(simplexml_load_string($dataPOST)), true);
$authcode=$xmlData["authcode"];
$userid=$xmlData["userid"];
$minimum_grab=$xmlData["minimum_grab"];

$q=mssql_query("select id from u6048user_id where userid='".$userid."'");
$r=mssql_fetch_array($q);
if ($r["id"]){
	$generate_code = substr(md5( $r["id"].",".strtoupper($userid).$web_code ),0,25 );
	if ($generate_code == $authcode){
		$success = "Valid";
		$q_poin = mssql_fetch_array(mssql_query("select poin from u6048user_coin where userid = '".$userid."'"));
		$poin = $q_poin["poin"];
		if ($minimum_grab > 0){
			if($poin >= $minimum_grab){
				mssql_query("insert into j2365join_poinhistory (tdate,userid,amount,ket) values (GETDATE(),'".$userid."','".$poin."','Transfer to koin303.org')");
				mssql_query("update u6048user_coin set poin=0 where userid='".$userid."'");
			}else{
				$success = "";
				$error = "Poin not enough minimum poin is $minimum_grab";
			}
		}else{
			mssql_query("insert into j2365join_poinhistory (tdate,userid,amount,ket) values (GETDATE(),'".$userid."','".$poin."','Transfer to koin303.org')");
			mssql_query("update u6048user_coin set poin=0 where userid='".$userid."'");
		}
		
	}else $error = "Authcode rejected";
}else{
	$error = "Authcode rejected";
}

//grab point

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
if ($success){
	$outp .= '{"Game":"DewaPoker",';
	$outp .= '"UserId":"'.$userid.'",';
	$outp .= '"Authcode":"'.$generate_code.'",';
	$outp .= '"Point":"'.$poin.'",';
	$outp .= '"Message":"Authcode accepted"}'; 
}else{
	$outp .= '{"Game":"DewaPoker",';
	$outp .= '"UserId":"'.$userid.'",';
	$outp .= '"Authcode":"'.$authcode.'",';
	$outp .= '"Message":"'.$error.'"}'; 
}
echo($outp);
?>