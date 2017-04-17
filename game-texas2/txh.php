<?php
$DalamGame = "../";
$game="TXH";
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

#play_button{
    position:absolute;
    top:150px;
    right:-25px;
    z-index:100;
    width:98px;
    height:120px;
}
</style>

</HEAD>
<BODY topmargin=0 leftmargin=0 style="background:#141414;"  onload="RightClick.init();">



<CENTER>
<?php
//END TXHLASTORDER
sqlsrv_query($sqlconn, "if exists (select userid from t6413txh_lastorder where userid = '".$login."')
			begin
				select '1' as hasil
			end
			else
			begin
				INSERT INTO t6413txh_lastorder (userid, bdate, info, status, amount, total) SELECT userid, GETDATE(), 'new-add','new-add', TXH, TXH FROM u6048user_coin WHERE (userid = '".$login."')
			end",$params,$options);
//END TXHLASTORDER
$userid_gamex = sqlsrv_query($sqlconn, "if exists (select userid from g846game_id where userid = '".$login."')
			begin
				select '1' as hasil
			end
		else
			begin
				INSERT INTO g846game_id SELECT * FROM u6048user_id where userid='".$login."'
				INSERT INTO g846game_data SELECT * FROM u6048user_data where userid='".$login."'
			end",$params,$options);

	$userid_gamex2 = sqlsrv_query($sqlconn, "SELECT playerpt,userprefix from g846game_id where userid='".$login."'",$params,$options);
	$userid_game2 =  sqlsrv_fetch_array($userid_gamex2,SQLSRV_FETCH_ASSOC);
	if($userid_game2["playerpt"] == 1){
		sqlsrv_query($sqlconn, "if exists (select userid from g846game_id where userid='".$userid_game2["userprefix"]."')
			begin
				select '1' as hasil
			end
		else
			begin
				INSERT INTO g846game_id SELECT * FROM u6048user_id where userid='".$userid_game2["userprefix"]."'
				INSERT INTO g846game_data SELECT * FROM u6048user_data where userid='".$userid_game2["userprefix"]."'
			end",$params,$options);
	}
	if($userid_game2["playerpt"] == 0){

			sqlsrv_query($sqlconn, "if exists (select userid from g846game_id where userid='".$userid_game2["userprefix"]."')
			begin
				select '1' as hasil
			end
		else
			begin
				INSERT INTO g846game_id SELECT * FROM u6048user_id where userid='".$userid_game2["userprefix"]."'
				INSERT INTO g846game_data SELECT * FROM u6048user_data where userid='".$userid_game2["userprefix"]."'
			end",$params,$options);
			
			sqlsrv_query($sqlconn, "if exists (select userid from g846game_id where userid='".substr($userid_game2["userprefix"],0,3)."')
			begin
				select '1' as hasil
			end
		else
			begin
				INSERT INTO g846game_id SELECT * FROM u6048user_id where userid='".substr($userid_game2["userprefix"],0,3)."'
				INSERT INTO g846game_data SELECT * FROM u6048user_data where userid='".substr($userid_game2["userprefix"],0,3)."'
			end",$params,$options);
			
			sqlsrv_query($sqlconn, "if exists (select userid from g846game_id where userid='".substr($userid_game2["userprefix"],0,1)."')
			begin
				select '1' as hasil
			end
		else
			begin
				INSERT INTO g846game_id SELECT * FROM u6048user_id where userid='".substr($userid_game2["userprefix"],0,1)."'
				INSERT INTO g846game_data SELECT * FROM u6048user_data where userid='".substr($userid_game2["userprefix"],0,1)."'
			end",$params,$options);
		
	}
	
	
/*
$sql3 = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select TXH from u6048user_coin where userid='".$login."'"),SQLSRV_FETCH_ASSOC);

$sql2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select coin_lobby from t6413txh_config"),SQLSRV_FETCH_ASSOC);
if ($sql2["coin_lobby"] > $sql3["TXH"]){


	echo"<center><div><br><br><br><br><img src='../np/img/logo.png'></div></center><br><br>";
	echo"<center><div style='color:white;font-family:Arial;font-size:30px;font-weight:bold'>Anda tidak dapat masuk ke dalam game, <BR> Minimum Coin adalah ".$sql2["coin_lobby"]."</div></center><br><br>";
	echo"<center><div style='color:blue;font-family:Arial;font-size:20px;font-weight:bold'><a href='../np/index.php' style='color:yellow'>Kembali ke halaman utama</a></div></center>";
	die();

}*/
$loadTablex = "";
//$tempx = "";
/*
$sql4 = sqlsrv_query($sqlconn,"select Name, Pic from t6413txh_roomtemplate", $params, $options);
for ($b=0; $b<sqlsrv_num_rows($sql4); $b++) {

	$data4=sqlsrv_fetch_array($sql4);

	$tempx[$data4["Pic"]] = $b;
	
	$loadTablex .= $data4["Pic"].",";

}*/

$arrTablex = "";
$picx = "";


/*
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
	
}*/

$arrTablex = "0,1,2,3,";
$r_userdata = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select curr,userprefix from g846game_data where userid = '".$login."'"),SQLSRV_FETCH_ASSOC);
$currz = $r_userdata["curr"];
if($curr_game =="RMB"){
	$loadTablex = "table-chn9,table-chn6,table-chn4,table-chn2,";
}else if($curr_game =="THB"){
	$loadTablex = "table-thb9,table-thb6,table-thb4,table-thb2,";
}else{
	$loadTablex = "table-idn9,table-idn6,table-idn4,table-idn2,";
}

$arrTable = substr($arrTablex, 0, -1);

$loadTable = substr($loadTablex, 0, -1);
$bahasa = "IND";
$sqlcoin = sqlsrv_query($sqlconn,"select TXH as coin from u6048user_coin where userid='".$login."'",$params,$options);
$sqlcoinx = sqlsrv_fetch_array($sqlcoin,SQLSRV_FETCH_ASSOC);
if($sqlcoinx["coin"] >= "200000"){
	$sql2 = sqlsrv_query($sqlconn,"select ip,id from a83adm_server where gametype='TXH'  and network='".$network."'");
	$data2 = sqlsrv_fetch_array($sql2,SQLSRV_FETCH_ASSOC);
	$datasmart = explode(":", $data2["ip"]);
	$sfip = $datasmart[0];
	$sfport = $datasmart[1];
	$sfserver = $data2["id"];
	//$smart = "$sfip,$sfport,$sfzone,$sfserver";
	
	$smart = "$sfip,$sfport,$sfzone,$sfserver,$bahasa";
		
}
else{
	
	$sql2 = sqlsrv_query($sqlconn,"select ip,id from a83adm_server where gametype='TXH' and name not like '%vip%' and network='".$network."'");
	while($data2 = sqlsrv_fetch_array($sql2,SQLSRV_FETCH_ASSOC)){
		$usersit = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select count(id) as total from t6413txh_usersit  where server='".$data2["id"]."'"),SQLSRV_FETCH_ASSOC);
		if($usersit["total"] < 400 ){
			$datasmart = explode(":", $data2["ip"]);
			$sfip = $datasmart[0];
			$sfport = $datasmart[1];
			$sfserver = $data2["id"];
			$smart = "$sfip,$sfport,$sfzone,$sfserver,$bahasa";
			break;
		}
	}
}



	
?>


<script type="text/javascript" src="../rightClick.js"></script>
<script type="text/javascript" src="../swfobject.js"></script>

<div id="flashcontent" style="width:100%;height:100%;color:white;align:center;"><a href="https://get.adobe.com/flashplayer/" target="_blank"><img src="get_adobe_flash_player.png"></a></div>
<script type="text/javascript">
	var so = new SWFObject("txh.swf?ver=<?php echo"".$version."";?>&arrTable=<?php echo $arrTable;?>&loadTable=<?php echo $loadTable;?>&sfsdata=<?php echo $smart;?>&paths=<?php echo $path;?>&user=<?php echo strtoupper($login);?>&key=<?php echo $password;?>", "customRightClick", "100%", "100%", "9", "#000000");
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