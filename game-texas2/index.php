<?php
$DalamGame = "../";
$game="TXH";
$roomid= $_GET["roomid"];
$serversfs= $_GET["server"];
$cookie_name = "language";
include("../config.php");

$requiredUserLevel = array('U');

function decryption($string, $key) {
	$result = '';
	$string = base64_decode($string);
	for($ix=0; $ix<strlen($string); $ix++) {
		$char = substr($string, $ix, 1);
		$keychar = substr($key, ($ix % strlen($key))-1, 1);
		$char = chr(ord($char)-ord($keychar));
		$result.=$char;
	}
	return $result;
}

$url = explode( ",",decryption($_GET["id"],"5792") );

$login=$url[0];
$key=$url[1];
$tablename=$url[2];
$serversfs=$url[3];
$roomid=$url[4];
$lang=$url[5];
$ip=$_SERVER['REMOTE_ADDR'];
$link_img="kh";
//exit($login.",".$key.",".$tablename.",".$server.",".$roomid.",".$lang);

$q_check_user_active = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select top 1 userid from u6048user_active where userid = '".$login."' and sessid='".$key."' and ip='".$ip."'",$params,$options));
if(!$q_check_user_active){
	exit("Please login first!");
}

$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select status,userpass from u6048user_id where userid = '".$login."'"),SQLSRV_FETCH_ASSOC);
$status = $sqlu["status"];
if ($status == 1) {
	exit("This user has been locked");
}
$password = $sqlu["userpass"];
if($lang == "en"){
	$bahasa ="ENG";
}else if($lang == "cn"){
	$bahasa ="CHT";
}else if($lang == "cs"){
	$bahasa ="CHS";
}else if($lang == "th"){
	$bahasa ="THD";
}else if($lang == "id"){
	$bahasa ="IND";
}
?>

<HTML>
<HEAD>
<title>Texas Poker</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
html, body {
    height: 100%;
	width: 100%;
    margin: 0;
    padding: 0;
	
}

body{

overflow:hidden;
}
 
#txh {
    width: 100%;
    height: 100%;
}

#play_button{
    position:absolute;
    top:150px;
    right:5px;
    z-index:100;
    width:98px;
    height:120px;
}
</style>

</HEAD>
<BODY topmargin=0 leftmargin=0 style="background:#141414;"  onload="RightClick.init();">
<CENTER>
<?php

$version = "0.2.1";

$sql3 = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select TXH from u6048user_coin where userid='".$login."'"),SQLSRV_FETCH_ASSOC);
$sql2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select coin_lobby from t6413txh_config"),SQLSRV_FETCH_ASSOC);
if ($sql2["coin_lobby"] > $sql3["TXH"]){
	echo"<center><div><br><br><br><br><img src='../np/img/logo.png'></div></center><br><br>";
	echo"<center><div style='color:white;font-family:Arial;font-size:30px;font-weight:bold'>Anda tidak dapat masuk ke dalam game, <BR> Minimum Coin adalah ".$sql2["coin_lobby"]."</div></center><br><br>";
	echo"<center><div style='color:blue;font-family:Arial;font-size:20px;font-weight:bold'><a href='../np/index.php' style='color:yellow'>Kembali ke halaman utama</a></div></center>";
	die();
}

$loadTablex = "";
$sql4 = sqlsrv_query($sqlconn,"select Name, Pic from t6413txh_roomtemplate", $params, $options);
for ($b=0; $b<sqlsrv_num_rows($sql4); $b++) {
	$data4=sqlsrv_fetch_array($sql4);
	$tempx[$data4["Pic"]] = $b;
	$loadTablex .= "table_".$link_img.",";
}

$arrTablex = "";
$sql = sqlsrv_query($sqlconn, "select Template,RoomId from t6413txh_room order by RoomId asc", $params, $options);
for ($a=0; $a<sqlsrv_num_rows($sql); $a++) {
	$data=sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
	$picname = $data["Template"];
	$data2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select Pic from t6413txh_roomtemplate where Name='".$picname."' "), SQLSRV_FETCH_ASSOC);
	$pic[$data["RoomId"]] = $tempx[$data2["Pic"]];
}

for ($c=0; $c<count($pic); $c++){
	if ($pic[$c] == ""){	
		$pic[$c] = 0;
	}
	$arrTablex .= $pic[$c].",";
	
}


$arrTable = substr($arrTablex, 0, -1);
$loadTable = substr($loadTablex, 0, -1);

$sqlip = sqlsrv_query($sqlconn,"select ip from a83adm_server where id='".$serversfs."' and gametype='TXH'",$params,$options);
$sqlipx = sqlsrv_fetch_array($sqlip,SQLSRV_FETCH_ASSOC);

$ipx = explode(":",$sqlipx["ip"]);
$sfip=$ipx[0];
$sfport=$ipx[1];

$sfserver=$serversfs;
$smart = "$sfip,$sfport,$sfzone,$sfserver,$bahasa";
?>


<script type="text/javascript" src="../assets/js/rightClick.js"></script>
<script type="text/javascript" src="../assets/js/swfobject.js"></script>
<div id="flashcontent">Flash Player 9 required</div>
<script type="text/javascript">
	var so = new SWFObject("txh.swf?ver=<?php echo"".$version."";?>&arrTable=<?php echo $arrTable;?>&loadTable=<?php echo $loadTable;?>&sfsdata=<?php echo $smart;?>&paths=<?php echo $path;?>&user=<?php echo $login;?>&key=<?php echo $password;?>&roomid=<?php echo $roomid;?>", "customRightClick", "100%", "100%", "9", "#000000");
	so.addParam("quality", "high");
	so.addParam("name", "Naga Poker");
	so.addParam("id", "Naga Poker");
	so.addParam("AllowScriptAccess", "always");
	so.addParam("wmode", "transparent");
	so.addParam("menu", "false");
	so.addVariable("variable1", "value1");
	so.write("flashcontent");
</script>


	
</CENTER>
</BODY>

</HTML>