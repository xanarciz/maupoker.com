<?php
//include ("config_data.php");
$_SERVER["HTTP_X_FORWARDED_FOR"];

header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); // always modified
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0"); // HTTP/1.1
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache"); // HTTP/1.0

include_once("config.inc.php");
$Server = "103.249.162.14, 3433";
$DbUserName = "www_rabbit00";
$DbPassword = "(Sn1p3r@US-)";
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
function sanitize($data, $values2 = null) {
	if ( !isset($data) or empty($data)) return $data;
	if ( is_numeric($data) ) return $data;
	$data = str_replace("'", "''", $data);
	$operators = [
        ' like ', 'like binary', 'not like', ' between ', ' ilike ',
        '&', '|', '^', '<<', '>>','<','>',
        ' rlike ', ' regexp ', ' not regexp ',
        '~', '~*', '!~', '!~*', ' similar to ',
        'not similar to', 'not ilike', '~~*', '!~~*',';',
        'select ','update ','delete ','insert ',' alter ','create ',
        ' join ',' where ',' union ',' order ',' having ', ' exec ',' declare ',
        ' char ', '(',')'
    ];
    $regexIlegalChar = [
        '/%0[0-8bcef]/',            // url encoded 00-08, 11, 12, 14, 15
        '/%1[0-9a-f]/',             // url encoded 16-31
        '/[\x00-\x08]/',            // hexa 00-08
        '/\x0b/',                   // hexa 11
        '/\x0c/',                   // hexa 12
        '/[\x0e-\x1f]/',             // hexa 14-31
		'/%3[A-CEF]/',
		'/%2[0-9A]/',
		'/[<>":;?()]/'
    ];
	if(is_array($data)){
		$res = array();
		foreach ($data as $key => $value){
			$res[$key] = str_ireplace($operators, '', $value);
			$res[$key] = preg_replace($regexIlegalChar, '', $res[$key]);
		}
	}else{
		$res = str_ireplace($operators,'',$data);
		$res = preg_replace($regexIlegalChar,'',$res);
	}

	$result = $res;

	if(! is_null($values2)){
		$values2 = $checkValue($values2);

		$result = array($data, $values2);
	}
	return $result;
}
function getUserIP2($type = null){
	if($type == null) {
		$client = @$_SERVER['HTTP_CLIENT_IP'];
		$forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
		$remote = $_SERVER['REMOTE_ADDR'];
		$forward = isset(explode(',', $forward)[1]) ? explode(',', $forward)[1] : explode(',', $forward)[0];

		if (filter_var($client, FILTER_VALIDATE_IP)) $ip = $client;
		elseif (filter_var($forward, FILTER_VALIDATE_IP)) $ip = $forward;
		else $ip = $remote;
	}else{
		$ipType = @$_SERVER[$type];
		$ip = isset(explode(',', $ipType)[1]) ? explode(',', $ipType)[1] : explode(',', $ipType)[0];

		if (!filter_var($ip, FILTER_VALIDATE_IP)) $ip = null;
	}
	return $ip;
}





$_POST = sanitize($_POST);
$_GET = sanitize($_GET);

date_default_timezone_set('Asia/Jakarta');
$sqlconn = sqlsrv_connect( $Server, $connectionInfo);
if( $sqlconn === false ){
	//die("<center><table border=1 bgcolor=#FFFF00><tr><td><CENTER><B>Information</B></CENTER></td></tr><tr><td>Error Connected to server...<br><br>(<I>Sorry for inconvinience caused</I>)<br>Press Ctrl+F5 to retry</td></tr></table></center>");
	exit("
		<body style='margin:0px;' bgcolor=#101118>
			<center>
				<img src='universal/under-maintenance.png' style='width:100%'>
			</center>
		</body>
	");
}



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

$q=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select * from a83adm_subweb where domainname like '%,".$nonWWW."%'"),SQLSRV_FETCH_ASSOC);
$subwebid = $q["id"];
$masterwlable = $q["master"];
$agentwlable = $q["agent"];
$pokerwlable = "txhpoker".$q["name"];
$pokertable = "tablepoker".$q["name"];
$register = $q["status_register"];
if ($register==2)$agentwlable = $q["master"];
//kode game, di set sesuai kode game.
//$link_img = "bo";
//$link_img = "ig";
//$link_img = "sb";

$link_img = $q["name"];

unset($q);

if ($DalamGame)	
	$cfgProgDir = $DalamGame."secure/";
else 
	$cfgProgDir = "/secure/";

$cfgFuncDir = "function/";

$q_maintenance=sqlsrv_num_rows(sqlsrv_query($sqlconn,"select maint from a83adm_config where maint='1'",$params,$options));
if ($q_maintenance > 0){

	exit("
		<body style='margin:0px;' bgcolor=#101118>
			<center>
				<img src='universal/under-maintenance.png' style='width:100%'>
			</center>
		</body>
	");
	
}

?>