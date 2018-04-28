<?php
function ipx($a){
	$d = 0.0;
	$b = explode(".", $a,4);
	for ($i = 0; $i < 4; $i++) {
		$d *= 256.0;
		$d += $b[$i];
	};
	return $d;
}


header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); // always modified
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0"); // HTTP/1.1
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache"); // HTTP/1.0


if($entered_login){
    $entered_login = $entered_login;
    if (isset($_COOKIE["livecasinouser"])) $cooks = $_COOKIE["livecasinouser"];
    else $cooks="";
}else{
    $entered_login = "";
}
if($sessid) $sessid = $sessid; else $sessid = "";

$authapi = base64_encode(
    json_encode(array(
        "webid"  => $subwebid,
        "agent"  => $agentwlable,
        "userid" => $login,
        "sessid" => $sessid
    ))
);

$reqAPIActive = array(
    "auth"      => $authapi,
    "webid"     => $subwebid,
    "domain"	=> $nonWWW,
    "userid"	=> $login,
    "sessid"	=> $sessid,
    "ip"		=> getUserIP2(),
    "www"		=> 1,
    "device"    => $device,
);

$responsewebx = sendAPI($url_Api."/checkplayer",$reqAPIActive,'JSON','02e97eddc9524a1e');

//if($login=='QQJADWAL1') {
//    showDebug($responsewebx);
//}


// print_r($responsewebx);exit();
if($responsewebx->status == 200 && $responsewebx->resp->status == 00) {
    $flag 			= $responsewebx->resp->flag;
    $userpass		= $responsewebx->resp->userpass;
    $coin 			= $responsewebx->resp->coin;
    $poin 			= $responsewebx->resp->poin;
    $tcoin 			= $responsewebx->resp->tcoin;
    $authcode 		= $responsewebx->resp->authcode;
    $pin 			= $responsewebx->resp->pin;
    $hispoin 		= $responsewebx->resp->history_poin;
    $vip 			= $responsewebx->resp->vip;
    $status_block 	= $responsewebx->resp->status_block;
    $status_bank 	= $responsewebx->resp->status_bank;
    $bankaccname 	= $responsewebx->resp->bankaccname;
    $bankaccno 		= $responsewebx->resp->bankaccno;
    $bankaccnodis   = $responsewebx->resp->bankaccnodis;
    $bankname 		= $responsewebx->resp->bankname;
    $countnotif 	= $responsewebx->resp->countnotif;
    $xdeposit 		= $responsewebx->resp->xdeposit;
    $bankgroup 		= $responsewebx->resp->bankgroup;
    $saham_share	= $responsewebx->resp->saham_share;
    $voucher_count	= $responsewebx->resp->voucher_count;
}else{
    if(isset($responsewebx->resp)){
        $message = $responsewebx->resp->msg;
    }else{
        $message = $responsewebx->msg;
    }

    session_unset();
    session_destroy();
    echo "<script>  window.location='".$DalamGame.$loginurl."' </script>";
}


//CHANGE NICKNAME
if ($flag == 0){
	include($cfgProgDir . "/change_nickname.php");
	
	exit();
}
//PIN CHECK
if (!isset($_SESSION["pin"]) || isset($_SESSION["pin"])==""){
	include($cfgProgDir . "/validation.php");
	
	exit();
}

?>