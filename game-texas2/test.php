<?php
$DalamGame = "../";
include("../config.php");
$requiredUserLevel = array('U');
include($cfgProgDir."secure.php");

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
</style>

</HEAD>
<BODY topmargin=0 leftmargin=0 style="background:#141414;"  onload="RightClick.init();">
<CENTER>
<?php
$version = "0.2.0";
$sqlx = sqlsrv_query($sqlconn, "select * from j2365join_playeronly where Game = 'TXH'", $params, $options);
if(sqlsrv_num_rows($sqlx) > 0){
	while ($datax = sqlsrv_fetch_array($sqlx, SQLSRV_FETCH_ASSOC)){
		$a = substr($login,0,(strlen($datax["UserId"])));
		if(strtoupper($a) == strtoupper($datax["UserId"])){
			$masuk = 1;
			break;
		}
	}
	if($masuk != 1) die("<center><div style='color:red;font-family:Arial;font-size:14px;font-weight:bold'>Game not available.</div></center>");
}

$sql3 = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select TXH from u6048user_coin where userid='".$login."'"),SQLSRV_FETCH_ASSOC);

$sql2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select coin_lobby from t6413txh_config"),SQLSRV_FETCH_ASSOC);
if ($sql2["coin_lobby"] > $sql3["TXH"]){


	echo"<center><div><br><br><br><br><img src='../np/img/logo.png'></div></center><br><br>";
	echo"<center><div style='color:white;font-family:Arial;font-size:30px;font-weight:bold'>Anda tidak dapat masuk ke dalam game, <BR> Minimum Coin adalah ".$sql2["coin_lobby"]."</div></center><br><br>";
	echo"<center><div style='color:blue;font-family:Arial;font-size:20px;font-weight:bold'><a href='../np/index.php' style='color:yellow'>Kembali ke halaman utama</a></div></center>";
	die();

}
$loadTablex = "";
//$tempx = "";

$sql4 = sqlsrv_query($sqlconn,"select Name, Pic from t6413txh_roomtemplate", $params, $options);
for ($b=0; $b<sqlsrv_num_rows($sql4); $b++) {

	$data4=sqlsrv_fetch_array($sql4);

	$tempx[$data4["Pic"]] = $b;
	
	$loadTablex .= $data4["Pic"].",";

}

$arrTablex = "";
$picx = "";



$sql = sqlsrv_query($sqlconn, "select Template,RoomId from t6413txh_room order by RoomId asc", $params, $options);
for ($a=0; $a<sqlsrv_num_rows($sql); $a++) {
	$data=sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
	$picname =  $data["Template"];
	$data2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select Pic from t6413txh_roomtemplate where Name='".$picname."' "), SQLSRV_FETCH_ASSOC);
	$pic[$data["RoomId"]] =$tempx[$data2["Pic"]];
	$picx = $data2["Pic"];
}

for ($c=0; $c<count($pic); $c++){
	if ($pic[$c] == ""){	
		$pic[$c] = 0;
	}
	$arrTablex .= $pic[$c].",";
	
}


$arrTable = substr($arrTablex, 0, -1);

$loadTable = substr($loadTablex, 0, -1);
$bahasa = "IND";
$smart = "$sfip,$sfport,$sfzone,$sfserver,$bahasa";


$sql2 = sqlsrv_query($sqlconn,"select top 1 Id,Periode,TDate,TableNo,UserId,Status,Bet from t6413txh_transaction where UserId='".$login."' and Status = 'Fold' and TDate < dateadd(minute, -7, GETDATE())");
while($data2 = sqlsrv_fetch_array($sql2,SQLSRV_FETCH_ASSOC)){
	
		$sql3 = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select Id from t6413txh_transaction where Status='Win' and Periode='".$data2["Periode"]."' and TableNo='".$data["TableNo"]."'",$params,$options));
		if ($sql3 <= 0){
			sqlsrv_query($sqlconn,"update u6048user_id set deposit_pending='1' where userid = '".$login."'");
			sqlsrv_query($sqlconn,"insert into u6048user_transfer (receiver,mes,date) values ('".$login."','11, ,".$data2["Bet"].",".$data2["Periode"].",".$data2["TableNo"]."',GETDATE())");
			
			sqlsrv_query($sqlconn,"delete from t6413txh_transaction where Id ='".$data2["Id"]."'");
									
		}

}

?>


<script type="text/javascript" src="../rightClick.js"></script>
<script type="text/javascript" src="../swfobject.js"></script>
<div id="flashcontent">Flash Player 9 required</div>
<script type="text/javascript">
	var so = new SWFObject("txh.swf?ver=<?php echo"".$version."";?>&arrTable=<?php echo $arrTable;?>&loadTable=<?php echo $loadTable;?>&sfsdata=<?php echo $smart;?>&paths=<?php echo $path;?>&user=<?php echo $login;?>&key=<?php echo $password;?>", "customRightClick", "100%", "100%", "9", "#000000");
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