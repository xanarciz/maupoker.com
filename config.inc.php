<?php
$shortname = "";
$MaxUser = "1000";
$loginbased ="";  // ''=semua level, PT=khusus member PT, 'userid'=proteksi khusus id tsb

$dmn = explode(".",$_SERVER['SERVER_NAME']);
if (substr($dmn[0],0,3) != "www"){
    $dmn[2]=$dmn[1];
    $dmn[1]=$dmn[0];
}

$path	="https://avatar.96nmdqufhz.com";
$reflink = "www.".$dmn[1].".".$dmn[2]."/referral_daftar.php";
$agentlink = "www.".$dmn[1].".".$dmn[2]."/agent_daftar.php";
$DomainName = "www.".$dmn[1].".".$dmn[2];
$nonWWW = "domino88.asia";

//READ HTTPS OR HTTP URL
$protocol = "";
if(!empty($_SERVER['HTTP_X_FORWARDED_PROTO'])){
	//READ CLOUDFARE'S PROTOCOL
	$protocol .= $_SERVER['HTTP_X_FORWARDED_PROTO'].'://';
}
else{
	//READ SERVER PROTOCOLS
	$protocol .= (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS']=="on") ? "https://" : "http://";
}
$lobby_dom = ($protocol=="http://")? "lobby5.lobbyplay.com" : "lobby6.lobbyplay.com";
$url_lobby = $protocol.$lobby_dom;
$url_Api = "http://coredev.devsuperteam.com/api/web";
// $url_info = 'https://www.cemedomino88.net/memcacheAPI/';
$url_info = 'https://www.cemedomino88.net/memcacheAPI/';
$ToMenu = 0;
$server = 1;
$www = 1;
$wl = 1;
$network =1;
$loginurl = "index.php";
// 0 = ke game,  1 = ke menu
define('DOMAIN_NAME',$DomainName , true);
define('CURRENT_DOMAIN',$_SERVER['SERVER_NAME'], true);
$cfgDbPasswordfield = 'userpass';
define('PASS_FIELD',$cfgDbPasswordfield, true);
$cfgDbSessfield = 'sessid';
define('SESS_FIELD',$cfgDbSessfield, true);
$cfgDbTableUsers = 'u6048user_id';         // MySQL table name containing phpSecurePages user fields
$cfgDbLoginfield = 'userid';                // MySQL field name containing login word
$cfgDbUserLevelfield = 'usertype';       // MySQL field name containing user level
?>
