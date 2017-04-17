<?php
$_SESSION['login'] = "";
if($_GET["action"]=="logout"){
	session_start();
	$_SESSION = array();
	if(isset($_COOKIE[session_name()])) {
		setcookie(session_name(), '', time()-(60*60*24*30), '/');
	}
	session_destroy();
}

function curr($val) {
	if($val < 1){
		return $val;
	}
   if (!strpos($val,".")) return number_format($val, 0,'.', '.');
   else return number_format($val, 2,'.', '.');
}

$DalamGame = "";
session_start();
$login = $_SESSION["login"];
include_once("config.php");
if (!$login && !$_POST["entered_login"]){
	if (!$freePage){include_once($cfgProgDir."secure.php");}
}else{
	include_once($cfgProgDir."secure.php");
}
if ($message != ""){
	?>
	<SCRIPT LANGUAGE="JavaScript">
		alert('<?php echo"".$message."";?>');
	</SCRIPT>
	<?php
}

if ($_SESSION["login"] && $message == "") {

	$requiredUserLevel = array('U');
	$login=$_SESSION["login"];
	$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select status,joindate,bankname,bankaccno,bankaccname,bankgrup,email,playerpt,usertype,min_depo,userpass,reflink_count,min_wdraw,save_deposit from u6048user_id where userid = '".$_SESSION["login"]."'"),SQLSRV_FETCH_ASSOC);
	
	$sqlc = sqlsrv_query($sqlconn,"select TXH from u6048user_coin where userid = '".$login."'");
	$conx = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select conversion from a83adm_configgame where gamecode='TXH'"),SQLSRV_FETCH_ASSOC);
	
	
	$datc = sqlsrv_fetch_array($sqlc);
	$chip = $datc["TXH"];
	$saveDeposit = $sqlu["save_deposit"];
	$conv = $conx["conversion"];
	
	if ($saveDeposit > 0){
		$LPoint = $saveDeposit*$conv;
		$curDeposit = 0;
		sqlsrv_query($sqlconn,"update u6048user_id set save_deposit='".$curDeposit."' where userid='".$login."'");
		$curPoint = $chip+$LPoint;
		sqlsrv_query($sqlconn,"update u6048user_coin set TXH='".$curPoint."' where Userid='".$login."'");
		sqlsrv_query($sqlconn,"insert into t6413txh_transaction (TDate, Periode, RoomId, TableNo, UserId, GameType, Status, Bet, v_bet, Card, Prize, Win, Lose, Cnt, Chip, PTShare, SShare, MShare, AShare, Autotake, DSMaster, DMaster, DAgent, DPlayer, Agent, Master, Smaster) values (GETDATE(), '0', '0', '0', '".$login."', 'TXH', 'Transfer In', '0', '".$LPoint."', '-', '-', '0', '0', '1', '".$curPoint."', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '')");
		sqlsrv_query($sqlconn,"insert into t6413txh_lastorder (Userid,bdate,info,status,amount,gametype,total) values ('".$login."',GETDATE(), '-', 'Transfer IN', '".$LPoint."', 'TXH', '".$curPoint."')");
		$sql = sqlsrv_query($sqlconn,"select id from t6413txh_lastorder where userid = '".$login."' order by id desc",$params,$options);
		if (Sqlsrv_num_rows($sql) > 3) {
			$tempRow = sqlsrv_fetch_array($sql,SQLSRV_FETCH_ASSOC);
		
			sqlsrv_query($sqlconn,"delete from t6413txh_lastorder where userid = '".$login."' and id < '".$tempRow["id"]."'");
		}
		sqlsrv_query($sqlconn,"insert into ".$db2.".dbo.j2365join_balance_old (Userid,bdate,info,status,amount,gametype,total) values ('".$login."',GETDATE(), 'TXH Transfer in (".$curPoint.")', 'Transfer', '".$saveDeposit."', 'TXH', '0')");
		sqlsrv_query($sqlconn,"insert into j2365join_lastorder (Userid,bdate,info,status,amount,gametype,total) values ('".$login."',GETDATE(), 'TXH Transfer in (".$curPoint.")', 'Transfer', '".$saveDeposit."', 'TXH', '0')");
		$sql = sqlsrv_query($sqlconn,"select id from j2365join_lastorder where userid = '".$login."' order by id desc",$params,$options);
		if (Sqlsrv_num_rows($sql) > 3) {
			$tempRow = sqlsrv_fetch_array($sql);
		
			sqlsrv_query($sqlconn,"delete from j2365join_lastorder where userid = '".$login."' and id < '".$tempRow["id"]."'");
		}
		$chip = $curPoint;
	} 
	if ($_POST['entered_login'] && $_POST['entered_password']) {
		header("location:lobby_lobby.php");
		die();
	}

	$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select status,joindate,bankname,bankaccno,bankaccname,bankgrup,email,playerpt,usertype,min_depo,userpass,reflink_count,min_wdraw,save_deposit, xdeposit,userprefix from u6048user_id where userid = '".$_SESSION["login"]."'"),SQLSRV_FETCH_ASSOC);
	$status = $sqlu["status"];

	if ($status == 1){
		$_GET["action"] = "logout";
	}

	$data = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select TXH from u6048user_coin where userid='".$login."'"), SQLSRV_FETCH_ASSOC);

	$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select status,bankname, bankaccno, bankaccname, bankgrup,playerpt,userpass,email,joindate,save_deposit from u6048user_id where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
	$bankname = $sqlu["bankname"];
	$bankaccno = $sqlu["bankaccno"];
	$bankaccname = $sqlu["bankaccname"];
	$bankgrup = $sqlu["bankgrup"];
	$playerpt	= $sqlu["playerpt"];
	$pEmail = $sqlu["email"];
	$p = $sqlu["userpass"];
	$joindate = $sqlu["joindate"];
	$saveDeposit = $sqlu["save_deposit"];
	$conv = 1;
	$sql3 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select conversion from a83adm_configgame where gamecode='TXH'"), SQLSRV_FETCH_ASSOC);
	$conv = $sql3["conversion"];
	$sql2	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select id,mes from u6048user_transfer where receiver = '".$login."'"), SQLSRV_FETCH_ASSOC);
	$depositmes = $sql2["mes"];
	$depositid	= $sql2["id"];
	$sql2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select TXH from u6048user_coin where userid = '".$login."'"), SQLSRV_FETCH_ASSOC);
	$point = $sql2["TXH"];
	
	$balanceProblem = 0;
	$transpoint = 0;
	$sql2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select top 1 total from t6413txh_lastorder where userid = '".$login."' order by Id desc"), SQLSRV_FETCH_ASSOC);
	$transpoint = @$sql2["total"];
	
	if ( $point < -1000 ){
		$balanceProblem = 1;
	}else{
		if ($transpoint > 0) { 
			$balanceProblem = 1;
			if ($point != $transpoint) {
				if ($point < $transpoint){
					sqlsrv_query($sqlconn, "insert into t6413txh_lastorder (Userid,bdate,info,status,amount,gametype,total) values ('".$login."',GETDATE(), '-', 'balance problem', '".$transpoint."', 'TXH', '".$point."')");
					$sql = sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid = '".$login."' order by id desc",$params,$options);
					if (sqlsrv_num_rows($sql) > 3) {
						$data = sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
						sqlsrv_query($sqlconn, "delete from t6413txh_lastorder where userid = '".$login."' and id < '".$data["id"]."'");
					}
				}else if ($point > $transpoint){
					sqlsrv_query($sqlconn, "update u6048user_coin set txh='".$transpoint."'where userid='".$login."'");
					sqlsrv_query($sqlconn, "insert into t6413txh_lastorder (Userid,bdate,info,status,amount,gametype,total) values ('".$login."',GETDATE(), '-', 'balance problem', '".$point."', 'TXH', '".$transpoint."')");
					$sql = sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid = '".$login."' order by id desc",$params,$options);
					if (sqlsrv_num_rows($sql) > 3) {
						$data = sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
						$data = sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
						sqlsrv_query($sqlconn, "delete from t6413txh_lastorder where userid = '".$login."' and id < '".$data["id"]."'");
					}
				}
			}
			$balanceProblem = 0;
		}else if (!$transpoint && $point > 0){
			$balanceProblem = 1;
		}
	}
	
	$record = $depositmes;
	$uang = explode(",",$record);
	sqlsrv_query($sqlconn, "delete from u6048user_transfer where id = '".$depositid."'");
			
	if ($uang[2] != null){
		$dataStatus = "";
		$uangx = $uang[2]*$conv;
		$point = $point+$uangx;
		if( $uang[0] == "1" ){
			$dataStatus = "Deposit";
			$kata="Deposit baru : $uangx";
		}else if ($uang[0] == "2"){
			$dataStatus = "Correction";
			$kata = "Deposit correction : $uangx";
		}else if ($uang[0] == "3"){
			$dataStatus = "Correction";
			$kata = "Deposit correction : $uangx";
		}else if ($uang[0] == "4"){
			$dataStatus = "Withdraw Reject";
			$kata = "Withdraw rejected, ".number_format($uangx)." Refunded";
		}else if ($uang[0] == "5"){
			$dataStatus = "Withdraw";
			$kata = "Withdraw, amount ".number_format($uangx)."";
		}else if ($uang[0] == "6"){
			$dataStatus = "Referral";
			$kata = "Referral bonus, amount ".number_format($uangx)."";
		}else if ($uang[0] == "7"){
			$dataStatus = "Referral";
			$kata = "Bonus Commision, amount ".number_format($uangx)."";
		}else if ($uang[0] == "11"){
			$dataStatus = "Refund";
			$kata = "Refund ".number_format($uangx).", Periode ".number_format($uang[3])." at room ".number_format($uang[4])."";
		}
		$pointz = str_replace(",",".",number_format($point));
		sqlsrv_query($sqlconn, "update u6048user_coin set TXH = '".$point."' where userid = '".$login."'");
		sqlsrv_query($sqlconn ,"insert into t6413txh_transaction (TDate, Periode, RoomId, TableNo, UserId, GameType, Status, Bet, v_bet, Card, Prize, Win, Lose, Cnt, Chip, PTShare, SShare, MShare, AShare, Autotake, DSMaster, DMaster, DAgent, DPlayer, Agent, Master, Smaster) values (GETDATE(), '0', '0', '0', '".$login."', 'TXH', '".$dataStatus."', '0', '".$uangx."', '-', '-', '0', '0', '1', '".$point."', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '')");
		sqlsrv_query($sqlconn, "insert into t6413txh_lastorder (Userid,bdate,info,status,amount,gametype,total) values ('".$login."',GETDATE(), '-', '".$dataStatus."', '".$uangx."', 'TXH', '".$point."')");
		$sql 	= sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid = '".$login."' order by id desc",$params,$options);
		
		if (sqlsrv_num_rows($sql) > 3) {
			$data = sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
			$data = sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
			sqlsrv_query($sqlconn, "delete from t6413txh_lastorder where userid = '".$login."' and id < '".$data["id"]."'");
		}	
	}
	$sql1	= sqlsrv_num_rows(sqlsrv_query($sqlconn, "select receiver from u6048user_transfer where receiver = '".$login."'",$params,$options));
	if ($sql1 == 0){
		sqlsrv_query($sqlconn, "update u6048user_id set deposit_pending = '0' where userid = '".$login."'");
	}
	$dataUserId = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userpass from u6048user_id where userid='".$login."'"), SQLSRV_FETCH_ASSOC);
	$upass = $dataUserId["userpass"];
	if ($kata){
		echo "<script>alert('$kata');</script>";
	}
	
	
	//TOTAL ONLINE PLAYER
	$sqlC = sqlsrv_query($sqlconn,"select id from u6048user_active where usertype='U'",$params,$options);
	$totalUserActive = Sqlsrv_num_rows($sqlC);
	//GLOBAL JACKPOIT
	$sqljack1 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select globaljackpot as jack from t6413txh_gjackpot"),SQLSRV_FETCH_ASSOC);
    $ttljack1x = $sqljack1["jack"];
	//AVATAR
	$myDir = substr($login,0,1);
	$img_avatar = $path."/avatar/".$myDir."/".$login.".jpg?".date("is");	
	if (!file_exists($img_avatar)){
		//$img_avatar = "lobby/img/avatar.png";
	}	
}

//RUNNINGTEXT
if ($_SESSION["login"]) {
	$q = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "SELECT menu_text,footer_text,yahoo_id,skype_id,bbm_id,wechat_id,phone_id,whatsapp_id,facebook_id,twitter_id,bank_text,img_main,referral_text,line_id from u6048user_agencyruntext WHERE agent = '".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
	$running_txt = $q["menu_text"];
	$footer_txt = $q["footer_text"];
	
	$q2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select txh from u6048user_coin where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
	$coin = $q2["txh"];
} else {
	$q = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "SELECT depan_text,footer_text,yahoo_id,skype_id,bbm_id,wechat_id,phone_id,whatsapp_id,facebook_id,twitter_id,bank_text,img_main,referral_text,line_id from u6048user_agencyruntext WHERE agent = '".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
	$running_txt = $q["depan_text"];
	$footer_txt = $q["footer_text"];
}
$q_maintenance=sqlsrv_num_rows(sqlsrv_query($sqlconn,"select maint from a83adm_config where maint='1'",$params,$options));
if ($q_maintenance > 0){
	$q = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "SELECT text from g846runningtext where game = 'maint'"), SQLSRV_FETCH_ASSOC);
	$running_txt = $q["text"];
}
if($running_txt=="") $running_txt = "....";
require_once 'lobby/lib/Mobile_Detect.php';
$detect = new Mobile_Detect;
$deviceType = ($detect->isMobile() ? ($detect->isTablet() ? 'tablet' : 'phone') : 'computer');

if($deviceType != 'computer')
{
	if($detect->isAndroidOS())
	{
		echo 'Please Download APK (Android APP)!';
		// redirect to *.apk download page
	}
	else
	if($detect->isiOS())
	{
		echo 'Please Download IPA (IOS APP)!';
		// redirect to *.ipa download page
	}
	else
	{
		echo 'Please change your phone, just IOS or Android allowed.';
		// redirect to wherever
	}
	
	exit();
}
$_SESSION["refresher"] = 0;

//INCLUDE MULTI LANGGUAGE
$cookie_name = "language";
if(isset($_COOKIE[$cookie_name])) {
	$lang = $_COOKIE[$cookie_name];
}else{
	$lang = "en";	
}
include("lang_".$lang.".php");
?>

<!DOCTYPE html>
<html>
<head>
	<title>IDN Poker Lobby</title>
	<meta name="viewport" content="width=device-width, minimum-scale=1.0,  maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="lobby/css/jquery.scrollbar.css">
	<link rel="stylesheet" type="text/css" href="lobby/css/style.css">
    <script src="assets/js/jquery-form.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="assets/js/jquery.form.2.93.js"></script>
    <script src="assets/js/jquery-ui-1.8.16.custom/js/jquery-ui-1.8.16.custom.min.js"></script>
    <script>	
	var selectedGame = "TXH";
	  var selectedRoom = "";
	  var selectedTable = "";
	  
	function clickTable(gameCode, roomname, timer, searcher){
		table_loader.init();
		$("#play-table").load('lobby/table.php?code='+selectedGame+'&roomname='+roomname+'&search='+searcher+'&timer='+timer);
		clickRow(selectedGame, "");
	}
	
	function clickRow(gameCode, tableid){
		//alert(gameCode+' - '+tableid);
		//table_loader.init();
		$("#participant-jackpot").load('lobby/sit.php?code='+selectedGame+'&tableid='+tableid);
	}
	
	function searchTable(gameCode, roomid, timer){
		var searchText =  document.getElementById("searchText").value; 
		searchText = searchText.replace(" ", "SPACE"); 
		clickTable(gameCode, roomid, timer, searchText);
	}
	
	setInterval(function () {
		//window.location.reload();
		$("#refresherBox").load('lobby/refresher.php');
		$('#theRefresh').click();
	}, 60000);
	
	
    $(document).ready(function(){
	  
	  
	 
	<?php
	list($widthLogo, $heightLogo) = getimagesize($path."/assets/img/".$link_img."/imgAll.png");	
	
	$gamezx_code = array();
	$gamezx_name = array();
	
	$gamezx_total = 0;
	$sqlGame = sqlsrv_query($sqlconn, "SELECT gamecode, gamename FROM a83adm_configgame WHERE status='1' ORDER BY gamename DESC",$params,$options);
	$total_game = sqlsrv_num_rows($sqlGame);
	for ($d=0;$d<$total_game;$d++){
		$gamez = sqlsrv_fetch_array($sqlGame,SQLSRV_FETCH_ASSOC);
		if($d==0) $class=" class='active'";
		else $class="";
		$gamezx_code[$d] = $gamez["gamecode"];
		switch($gamezx_code[$d]){
			case "TXH" : $gamezx_name[$d]=P_TEXASPOKER; break;
			case "DMM" : $gamezx_name[$d]=P_DOMINO; break;
			case "EBN" : $gamezx_name[$d]=P_CEME; break;
			case "BJK" : $gamezx_name[$d]="Blackjack"; break;
		}
		$gamezx_total = $d+1;
		
		?>
		$("#game-<?php echo $gamezx_code[$d];?>").click(function(){
			//alert('<?php echo $gamezx_name[$d];?>');
			table_loader.init();
			selectedGame = '<?php echo $gamezx_code[$d];?>';
			selectedRoom = "";
			selectedTable = "";
			$("#mid-menu").load('lobby/room.php?code='+selectedGame);
			$("#play-table").load('lobby/table.php?code='+selectedGame);
			clickRow(selectedGame, "");
		});
		<?php
	}
	?>
	});
    </script>
    <style>
	.avatar-medium{
		float: left;
		width: 60px;	
		height: 60px;
		margin-right: 10px;
		background: url(avatar/default_<?php echo $link_img;?>.jpg) no-repeat;
		background-size: 60px;
	}
	.avatar-medium-user{
		float: left;
		width: 60px;
		height: 60px;
		background-size: 60px;
	}
	#logoUniv{
		width: 100%;
		height: 90px;
		display: block;
		margin: 15px 0;
		background: url(assets/img/<?php echo $link_img;?>/imgAll.png) 0px 0px no-repeat;
		clear:both;
		cursor:pointer;
	}
	</style>
	<!--[if IE]><script src="js/html5.js"></script><![endif]-->
</head>
<body onLoad="setLogoSize()">
	<div id="wrapper">
		<div id="content" class="clearfix" style="z-index: 1; position: relative;">
			<div id="side-left">
				<div class="clearfix">
					<div id="user-area">
						<div id="user-avatar">
                        	<img onerror="handleIEError()" id="theAvatarX" src="<?php echo $img_avatar;?>" width="60">
                        	
                        </div>
						<div id="user-info">
							<div id="user-name"><?php echo $login;?></div>
							<div id="user-coin">
								<img src="lobby/img/icon-coin.png"><?php echo number_format($chip);?><br>
							</div>
						</div>
					</div>
					<div id="top-menu">
						<div class="clearfix">
							<ul id="small-menu" class="list-inline">
								<li>
									<a href="game-avatar_lobby.php" title="<?php echo P_EDI." ".P_PRF;?>" class="icon setting popup"></a>
								</li>
								<li>
									<a href="winlose_lobby.php" title="<?php echo P_HISTORY;?>" class="icon time popup"></a>
								</li>
								<li>
									<a href="jackpot_lobby.php" title="<?php echo P_JACKPOT;?>" class="icon win popup"></a>
								</li>
								<li>
									<a href="contact_lobby.php" title="<?php echo P_HELP;?>" class="icon ask popup"></a>
								</li>
								<li class="home">
									<a href="lobby.php" title="<?php echo P_HOME;?>" class="icon home"></a>
								</li>
							</ul>
							<div id="online-info">
								Online <?php echo P_PLAYER;?>: <span><?php echo $totalUserActive;?></span>
							</div>
						</div>
						<div id="latest-news">
							<div id="post-news">
								<!--<div class="marquee"><?php echo $running_txt;?></div>-->
								<marquee style='font-family:Arial;width:100%;'><?php echo $running_txt;?></marquee>
							</div>
						</div>
					</div>
				</div>

				<div id="big-menu">
					<ul class="list-inline">
                    	<?php
						for ($d=0;$d<$gamezx_total;$d++){
							if($gamezx_code[$d]!="BTM"){
								if($d==0) $class=" class='active'";
								else $class="";
								?>
								<li<?php echo $class;?>>
									<a href="" class="game-<?php echo $gamezx_code[$d];?> clicked" id="game-<?php echo $gamezx_code[$d];?>"><?php echo $gamezx_name[$d];?></a>
								</li>
							<?php
							}
                        }
                        ?>
					</ul>
				</div>

				<div id="mid-menu" class="clearfix">
					<?php include('lobby/room.php');?>
				</div>

				<div id="play-table">
					<?php include ('lobby/table.php'); ?>
				</div>

			</div>
			<div id="side-right">
				<div id="logo">
					<!--<a href="index.php"><img src="assets/img/logo.png"></a>-->
                    <!--<div class="logo"><center><div id="theWrapperLogo" style="width:300px;"><div id="logoUniv" href="index.php" onClick="refresher();"></div></div></center></div>-->
					<div class="logo"><center><div id="theWrapperLogo" style="width:300px;"><div id="logoUniv" href="index.php" onClick="refresher();"></div></div></center></div>
				</div>

				<div id="global-jackpot">
					<h1>Global <?php echo P_JACKPOT;?></h1>
					<div id="jackpot-value"><?php echo number_format($ttljack1x);?></div>
				</div>

				<div id="participant-jackpot">
					<?php include ('lobby/sit.php');?>
				</div>
			</div>
		</div>
	</div>
    <div id="refresherBox"></div>
    <script>
	function setLogoSize(){		
		var img = new Image();
		var theHeight = 0;
		var theWidth = 0;
		img.onload = function() {
			
			theHeight = this.height;
			theWidth = this.width;
			
			var e1 = document.getElementById("logoUniv");
        	e1.style.height = (theHeight-35)+"px";
			
			var e2 = document.getElementById("theWrapperLogo");
			e2.style.width = theWidth+"px";
			
		}
		//alert('<?php echo $path."/assets/img/".$link_img."/imgAll.png"; ?>');
		img.src = '<?php echo "assets/img/".$link_img."/imgAll.png"; ?>';
		/*
		var img = new Image();
		var theHeight = 0;
		var theWidth = 0;
		img.onload = function() {
			theHeight = this.height;
			theWidth = this.width;
			
			var e1 = document.getElementById("logoUniv");
        	e1.style.height = (theHeight-35)+"px";
			
			var e2 = document.getElementById("theWrapperLogo");
			e2.style.width = theWidth+"px";
		}
		img.src = '<?php echo $path."/assets/img/".$link_img."/imgAll.png"; ?>';
		*/
	}
	function handleIEError() {
		var _img = document.getElementById('theAvatarX');
		var newImg = new Image;
		newImg.onload = function() {
			_img.src = this.src;
		}
		newImg.src = 'lobby/img/avatar.jpg';
		
	}
	function refresher(){
		window.location.href='index.php';
	}
	table_loader.init();
	</script>
	<script type="text/javascript" src="lobby/js/jquery.min.js"></script>
	<script type="text/javascript" src="lobby/js/jquery.scrollbar.min.js"></script>
	<script type="text/javascript" src="lobby/js/jquery.marquee.min.js"></script>
	<script type="text/javascript" src="lobby/js/jquery.popupWindow.js"></script>
	<!--<script type="text/javascript" src="lobby/js/jquery.custom.js"></script>-->
</body>
</html>