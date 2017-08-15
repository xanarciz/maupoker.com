<!DOCTYPE HTML>

<html lang="en">
<head>


<?php
if($page == 'home'){
	$_SESSION['login'] = "";
}

if($_GET["action"]=="logout"){
	session_start();
	$_SESSION = array();
	if(isset($_COOKIE[session_name()])) {
		setcookie(session_name(), '', time()-(60*60*24*30), '/');
	}
	session_destroy();
}


include_once ("config.php");
include_once($cfgProgDir."secure.php");

if ($message != ""){
	?>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		alert('<?php echo"".$message."";?>');
	//-->
	</SCRIPT>
	<?php
}
if ($_SESSION["login"] && $message == "") {
	$requiredUserLevel = array('U');
	$login=$_SESSION["login"];
	$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select status,joindate,bankname,bankaccno,bankaccname,bankgrup,email,playerpt,usertype,min_depo,userpass,reflink_count,min_wdraw,save_deposit from u6048user_id where userid = '".$_SESSION["login"]."'"),SQLSRV_FETCH_ASSOC);
	$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select status,joindate,bankname,bankaccno,bankaccname,bankgrup,email,playerpt,usertype,min_depo,userpass,reflink_count,min_wdraw,save_deposit,authcode from u6048user_id where userid = '".$_SESSION["login"]."'"),SQLSRV_FETCH_ASSOC);

	$sqlc = sqlsrv_query($sqlconn,"select TXH from u6048user_coin where userid = '".$login."'");
	$conx = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select conversion from a83adm_configgame where gamecode='TXH'"),SQLSRV_FETCH_ASSOC);
	$cdFrLuck ='';
	if($subwebid=='9002' || $subwebid=='9001' || $subwebid=='172' || $subwebid=='42'){
		if($subwebid=='9002') {$cd='RP'; $cdFrLuck = 'RM';}
		if($subwebid=='9001') {$cd='KP'; $cdFrLuck = 'KP';}
		if($subwebid=='172') {$cd='DA'; $cdFrLuck = 'DM';}
		if($subwebid=='42') {$cd='PKR'; $cdFrLuck = '';}
		$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select id,status,joindate,bankname,bankaccno,bankaccname,bankgrup,email,playerpt,usertype,min_depo,userpass,reflink_count,min_wdraw,save_deposit,authcode,xdeposit from u6048user_id where userid = '".$_SESSION["login"]."'"),SQLSRV_FETCH_ASSOC);
		$sqlc = sqlsrv_query($sqlconn,"select TXH from u6048user_coin where userid = '".$login."'");
		$conx = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select conversion from a83adm_configgame where gamecode='TXH'"),SQLSRV_FETCH_ASSOC);
		$user_authcode = $sqlu["authcode"];
		if (!$user_authcode){
			$user_authcode = substr(md5( $sqlu["id"].",".strtoupper($login).$cd ),0,25 );
			sqlsrv_query($sqlconn,"update u6048user_id set authcode='".$user_authcode."' where (authcode is null or authcode = '') and userid = '".$login."' and subwebid = '".$subwebid."'");
			sqlsrv_query($sqlconn,"update g846game_id set authcode='".$user_authcode."' where (authcode is null or authcode = '') and userid = '".$login."' and subwebid = '".$subwebid."'");
		}
	}else{
		$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select status,joindate,bankname,bankaccno,bankaccname,bankgrup,email,playerpt,usertype,min_depo,userpass,reflink_count,min_wdraw,save_deposit from u6048user_id where userid = '".$_SESSION["login"]."'"),SQLSRV_FETCH_ASSOC);
		$sqlc = sqlsrv_query($sqlconn,"select TXH from u6048user_coin where userid = '".$login."'");
		$conx = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select conversion from a83adm_configgame where gamecode='TXH'"),SQLSRV_FETCH_ASSOC);
	}

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
		header("location:login.php");
		die();
	}



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
	$sql2	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select id,mes,poin from u6048user_transfer where receiver = '".$login."'"), SQLSRV_FETCH_ASSOC);
	$depositmes = $sql2["mes"];
	$depositid	= $sql2["id"];
	$sql2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select TXH,poin from u6048user_coin where userid = '".$login."'"), SQLSRV_FETCH_ASSOC);
	$point = $sql2["TXH"];
	$coin = $point;
	$poin = $sql2["poin"];

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
			$kata="deposit baru : $uangx";
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
//		echo "insert into t6413txh_lastorder (Userid,bdate,info,status,amount,gametype,total) values ('".$login."',GETDATE(), '-', '".$dataStatus."', '".$uangx."', 'TXH', '".$point."')";
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

}

?>


<link href="css/<?PHP echo $link_img;?>/style.css?id=<?PHP echo time(); ?>" rel="stylesheet" type="text/css">
<link href="css/<?PHP echo $link_img;?>/framework.css?id=<?PHP echo time(); ?>" rel="stylesheet" type="text/css">
<link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">	
<link href="css/animate.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="assets/owl-carousel/owl.carousel.css" />
<link href="assets/jquery-ui-1.9.2.custom/css/custom-theme/<?PHP echo $link_img;?>/jquery-ui-1.9.2.custom.css" rel="stylesheet">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

<!-- Favicon -->
<link rel="shortcut icon" href="img/<?PHP echo $link_img;?>/favicon.ico" />
<link rel="apple-touch-icon-precomposed" href="img/apple-touch-icon-precomposed.png">


<!-- JQUERY -->
<script type="text/javascript" src="js/jquery.js"></script>
<script src="assets/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
<!-- SLIDER -->
<script type="text/javascript" src="assets/owl-carousel/owl.carousel.min.js"></script>
<!-- SIDEBAR -->
<script type="text/javascript" src="js/snap.js"></script>
<!-- MOBILE UI -->
<script type="text/javascript" src="js/framework.js"></script>
<!-- CUSTOM JS -->
<script type="text/javascript" src="js/custom.js"></script>
<!-- SMART BANNER JS -->
<script type="text/javascript" src="js/smart-banner.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>

<script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-36423566-1']);
    _gaq.push(['_trackPageview']);

    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl'  : 'http://www')  + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();

</script>

<script language="JavaScript" type="text/javascript">
//<!--
function removecomma(a) {
var res = '';
for (i=0;i<a.length;i++) {
if (a.substr(i,1) == ".") { }
else { res += a.substr(i,1) }
}
return res;
}

function Comma(number) {
number = '' + number;
if (number.length > 3) {
var mod = number.length % 3;
var output = (mod > 0 ? (number.substring(0,mod)) : '');
for (i=0 ; i < Math.floor(number.length / 3); i++) {
if ((mod == 0) && (i == 0))
output += number.substring(mod+ 3 * i, mod + 3 * i + 3);
else
output+= '.' + number.substring(mod + 3 * i, mod + 3 * i + 3);
}
return (output);
}
else return number;
}

function clickBank(a){

	var fom =  document.fdeposit;       /*nama form */
	var s = fom.tBName;
	//var ada = eval("fom.data");
	//var pilih = eval("fom.pilih");


	var tmp = s.selectedIndex;
	var hb = eval("fom.hBNo"+tmp);
	var hc =  eval("fom.hBAcc"+tmp);
	var hbx = eval("fom.hBNo");
	var hcx =  eval("fom.hBAcc");
	//var tb = eval("fom.tBNo");

	var tb = document.getElementById("tBNo");
	var tc = document.getElementById("tBAcc");

	//alert(document.getElementById("tBNo"))

		tb.innerHTML = hb.value;
		tc.innerHTML = hc.value;
		hbx.value = hb.value;
		hcx.value = hc.value;
	//tb.value = hb.value;
	//fom.tBAcc.value = hc.value;

}

function depAmount(a){
	var fom =  document.fdeposit;       /*nama form */
	var amt = eval("fom.amount");
	var am = document.getElementById("amnt");
	var val = amt.value;
	am.innerHTML = 'IDR '+Comma(val	);
}
//-->
</script>

<script type="text/javascript">
    $(document).ready(function() {
        $(".dropdown img.flag").addClass("flagvisibility");

        $(".dropdown dt a").click(function() {
            $(".dropdown dd ul").toggle();
        });

        $(".dropdown dd ul li a").click(function() {
            var text = $(this).html();
            $(".dropdown dt a span").html(text);
            $(".dropdown dd ul").hide();
        });

        function getSelectedValue(id) {
            return $("#" + id).find("dt a span.value").html();
        }

        $(document).bind('click', function(e) {
            var $clicked = $(e.target);
            if (! $clicked.parents().hasClass("dropdown"))
                $(".dropdown dd ul").hide();
        });

        $("#flagSwitcher").click(function() {
            $(".dropdown img.flag").toggleClass("flagvisibility");
        });

    });
</script>

<?php
if ($login){
	if ($kata){
		echo "<script>alert('$kata');</script>";
	}
}
$dir = substr($login,0,1);
$img = "../../Avatar/".$dir."/".$login.".jpg";

if (!file_exists($img)){
	$img = "../../Avatar/default.jpg";
}
$dt = date("Y m d H:i:s");

// if(!$login){
// 	include_once("../geoiploc.php");
// 	$block_list = array('PH','SG');
// 	$white_list = array('203.160.173.203','146.88.66.250','180.232.84.234','180.232.84.235');

// 	if(in_array($code, $block_list)){
// 		if(!in_array($ip, $white_list)){
// 		    echo "<script>window.location= '../restrict.php' ; </script>";
// 		    exit("Page not found");
// 		}
// 	}
// }
?>
<title> Domino88 mobile | website taruhan judi online pecinta domino INDONESIA </title>
<meta name="description" content="Domino88 tempat bermain judi online, pecinta judi online dan merupakan website paling trend di kalangan masyarakat indonesia ">
<meta name=""keywords" content="domino88, domino88 versi mobile, download aplikasi domino88, game online mobile domino88, domino88 versi hadphone, judi mobile domino88">
<meta name="copyright" content="www.logindm88.com">
<meta name="geo.placename" content="Jakarta">
<meta name="geo.region" content="ID-JK">
<meta name="geo.country" content="ID">
<meta name="language" content="ID">
<meta name="tgn.nation" content="Indonesia">
<meta name="rating" content="general">
<meta name="distribution" content="global">
<meta name="author" content="www.logindm88.com/">
<meta name="publisher" content="www.logindm88.com">
<meta name="copyright" content="copyright@ 2017 www.logindm88.com">
<meta content="Jhon poker" name="DC.Creator">
<meta content="domino88, domino88 versi mobile, download aplikasi domino88, game online mobile domino88, domino88 versi hadphone, judi mobile domino88" lang="ind" name="DC.Title">
<meta content="domino88, domino88 versi mobile, download aplikasi domino88, game online mobile domino88, domino88 versi hadphone, judi mobile domino88" lang="ind" name="DC.Subject">
<meta content="domino88, domino88 versi mobile, download aplikasi domino88, game online mobile domino88, domino88 versi hadphone, judi mobile domino88" lang="en" name="DC.Description">
<meta content="2017-06-06" name="DC.Date.LastModified" scheme="ISO 31-1">
<meta content="http://logindm88.com" name="DC.Identifier">
<meta content="domino88 | domino88 versi mobile | download aplikasi domino88 | game online mobile domino88 | domino88 versi hadphone | judi mobile domino88" name="DC.Publisher">
<meta content="ind" name="DC.Language" scheme="ISO639-2">
<meta content="http://logindm88.com" name="DC.Relation.IsPartOf">
<meta content="http://logindm88.com" name="DC.Rights">
</head>