<?php
//include ("config_data.php");
$_SERVER["HTTP_X_FORWARDED_FOR"];

header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); // always modified
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0"); // HTTP/1.1
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache"); // HTTP/1.0

$Server = "103.249.162.235";
$DbUserName = "dewa_naga";
$DbPassword = "adm!@#123";
$DbName = "cas_db";

//smartfox
$sfip = "103.249.162.237";
$sfport = "9339";
$sfzone = "naga_poker";
$sfserver = "1";

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
	// $data = str_replace("+", "", $data );
	return $data;
}

$_POST = sanitize($_POST);
$_GET = sanitize($_GET);

date_default_timezone_set('Asia/Jakarta');
$sqlconn = sqlsrv_connect( $Server, $connectionInfo);
if( $sqlconn === false ){
     die("<center><table border=1 bgcolor=#FFFF00><tr><td><CENTER><B>Information</B></CENTER></td></tr><tr><td>Error Connected to server...<br><br>(<I>Sorry for inconvinience caused</I>)<br>Press Ctrl+F5 to retry</td></tr></table></center>");
}
echo "aaA";
$db = sqlsrv_query( $sqlconn, "select dbase2 from a83adm_config2");
$row = sqlsrv_fetch_array( $db, SQLSRV_FETCH_ASSOC);
$db2 = $row["dbase2"];
sqlsrv_free_stmt( $db );

$db = sqlsrv_query($sqlconn,"select flash_version from a83adm_config");
$row = sqlsrv_fetch_array($db, SQLSRV_FETCH_ASSOC);
$ver = explode(",",$row["flash_version"]);
$fls_version = $row["flash_version"];
sqlsrv_free_stmt( $db );
$params = Array();

$options = array( "Scrollable" => SQLSRV_CURSOR_KEYSET );
if ($DalamGame)
	$cfgProgDir = $DalamGame."secure/";
else 
	$cfgProgDir = "/secure/";

$cfgFuncDir = "function/";

$q_maintenance=sqlsrv_num_rows(sqlsrv_query($sqlconn,"select maint from a83adm_config where maint='1'",$params,$options));
if ($q_maintenance > 0){
	exit("
	<style>
		body{
		margin:0px;
		padding:0px;
		}
	</style>
	<center><img src='../np/img/maintenance.jpg' width=100%></center>");
	/*$q = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "SELECT text from g846runningtext where game = 'maint'"), SQLSRV_FETCH_ASSOC);
	$runtxt = $q["text"];*/
}

?>