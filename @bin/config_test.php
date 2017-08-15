<?php
//include ("config_data.php");
$time_start = microtime(true);
$_SERVER["HTTP_X_FORWARDED_FOR"];

header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); // always modified
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0"); // HTTP/1.1
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache"); // HTTP/1.0

include_once("config.inc.php");
$Server = "43.246.216.26";
$DbUserName = "test_server_dw";
$DbPassword = "qwe@123";
$DbName = "cas_db";
include_once("lang_id.php");
//smartfox
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

$connectionInfo = array( "UID"=>$DbUserName ,
                         "PWD"=>$DbPassword,
                         "Database"=>$DbName);
						 
function sanitize($data) {
	if ( !isset($data) or empty($data)) return $data;
	if ( is_numeric($data) ) return $data;

	$non_displayables = array(
		'/%0[0-8bcef]/',            // url encoded 00-08, 11, 12, 14, 15
		'/%1[0-9a-f]/',             // url encoded 16-31
		'/[\x00-\x08]/',            // 00-08
		'/\x0b/',                   // 11
		'/\x0c/',                   // 12
		'/[\x0e-\x1f]/'             // 14-31
	);
	foreach ( $non_displayables as $regex )
		$data = preg_replace( $regex, '', $data );

	$data = str_replace("'", "''", $data );
	$data = str_replace("char(", "", $data );
	return $data;
}

$_POST = sanitize($_POST);
$_GET = sanitize($_GET);

date_default_timezone_set('Asia/Jakarta');
$sqlconn = sqlsrv_connect( $Server, $connectionInfo);
if( $sqlconn === false ){
	die("<center><table border=1 bgcolor=#FFFF00><tr><td><CENTER><B>Information</B></CENTER></td></tr><tr><td>Error Connected to server...<br><br>(<I>Sorry for inconvinience caused</I>)<br>Press Ctrl+F5 to retry</td></tr></table></center>");
}

    $time_end = microtime(true);
    $time = $time_end - $time_start;
    echo "Process Time: {$time}";
?>