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
$nonWWW = $dmn[0].".".$dmn[2];
$url_lobby = "https://www.lobbyplay.com";
$url_Api = "http://core-api.devsuperteam.com/api/web";
$url_info = 'http://infoweb.devsuperteam.com/';
$ToMenu = 0;
$server = 1;
$www = 1;
$wl = 1;
$network =1;
$loginurl = "index.php";
// 0 = ke game,  1 = ke menu
define(DOMAIN_NAME,$DomainName."");
define(CURRENT_DOMAIN,$_SERVER['SERVER_NAME']);
$cfgDbPasswordfield = 'userpass';
define(PASS_FIELD,$cfgDbPasswordfield);
$cfgDbSessfield = 'sessid';
define(SESS_FIELD,$cfgDbSessfield);
$cfgDbTableUsers = 'u6048user_id';         // MySQL table name containing phpSecurePages user fields
$cfgDbLoginfield = 'userid';                // MySQL field name containing login word
$cfgDbUserLevelfield = 'usertype';       // MySQL field name containing user level
?>
