<?php
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); // always modified
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0"); // HTTP/1.1
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache"); // HTTP/1.0

$path = isset($frontSec) ? $frontSec : '';
include_once($path."config.inc.php");
include_once("function/pubfunction.php");
include_once("myaes.php");

// check Mobile device
require_once 'mobile_detect.php';
$detect = new Mobile_Detect;
$check_mobile = $detect->isMobile();
$check_tablet = $detect->isTablet();
$currURL = $_SERVER['REQUEST_URI'];
$currPage = basename($_SERVER['PHP_SELF']);
$currentDevice = strpos($currURL, '/m/') !== FALSE;
$device = $currentDevice ? 1 : 2;
$globalPage = ['logout.php', 'fast_checking.php'];

if(! in_array($currPage, $globalPage)) {
    if (($detect->isMobile() || $detect->isTablet()) && $device == 2) {
        header('location:m/');
        exit();
    }

    if ((!$detect->isMobile() && !$detect->isTablet()) && $device == 1) {
        header('location:../');
        exit();
    }
}

$data = array(
    "secret_key" => '88888111118888811111',
    "id" 		 => 1,
    "wid" 		 => $nonWWW
);

$infoweb = sendAPI($url_info,$data,'XML','2fb4f029ebf33b9a');
// print_r($infoweb);exit();
$infoweb = variableMasterProc($infoweb);


//smartfox
include_once("lang_id.php");
$sfip = "103.249.162.229";
$sfip2 = "103.249.162.241";
$sfip3 = "103.249.162.194";
$sfip4 = "103.249.162.192";
$sfport = "9339";
$sfport2 = "9339";
$sfport3 = "9339";
$sfport4 = "9339";
$sfzone = "naga_poker";
$sfzone2 = "naga_poker";
$sfzone3 = "naga_poker";
$sfzone4 = "naga_poker";
$sfserver = "1";
$sfserver2 = "2";
$sfserver3 = "3";
$sfserver4 = "4";

$_POST = sanitize($_POST);
$_GET = sanitize($_GET);

date_default_timezone_set('Asia/Jakarta');

if($infoweb['status'] == 1) {
    $ver = explode (",",$infoweb["flashVer"]);
    $fls_version   = $infoweb["flashVer"];
    $subwebid      = $infoweb['webinfo']["subwebid"];
    $masterwlable  = $infoweb['webinfo']["master"];
    $agentwlable   = $infoweb['webinfo']["agent"];
    $pokerwlable   = "txhpoker" . $infoweb['webinfo']["style"];
    $pokertable    = "tablepoker" . $infoweb['webinfo']["style"];
    $link_img      = strtolower($infoweb['webinfo']["style"]);
    $register      = $infoweb['webinfo']["status_register"];
    $curr          = $infoweb['webinfo']["curr"];
    $currrate      = $infoweb['webinfo']["currrate"];
    $q_maintenance = $infoweb["maint"];
    if ($register == 2) $agentwlable = $infoweb['webinfo']["master"];
}else{
    $q_maintenance = 1;
}

if($infoweb['maint'] == 1){
    $q_maintenance = 1;
}

// default authapi
$authapi = base64_encode(
    json_encode(array(
        "webid"  => $subwebid,
        "agent"  => $agentwlable,
        "userid" => '',
        "sessid" => ''
    ))
);

$link = $device == 1 ? 'm/' : '';
if (isset($DalamGame))$cfgProgDir = $DalamGame . $link. "secure/";
else $cfgProgDir = "secure/";


if(isset($frontSec)) $cfgSecDir = $frontSec . "secure/";
else $cfgSecDir = "secure/";
$cfgFuncDir = "function/";

// if(getUserIP2() == '43.226.4.194'){
	// $q_maintenance = 0;
// }

if ($q_maintenance == 1){

	exit("
	<script type=text/javascript>
	var __lc = {};
	__lc.license = 4522711;

	(function() {
	var lc = document.createElement('script'); lc.type = 'text/javascript'; lc.async = true;
	lc.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'cdn.livechatinc.com/tracking.js';
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(lc, s);
	})();
	</script>
	<style>
	#grad1 {
		height: 5px;
		background: transparent linear-gradient(to right, #9002B8, #0098C9) repeat scroll 0% 0%;
	}
	</style>
	<body style='margin:0px;' bgcolor=#231f20>
		<div id='grad1'></div>
		<center>
			<img src='assets/images/under-maintenance.jpg' style='margin-top:20px;'>
		</center>
	</body>");
}

?>