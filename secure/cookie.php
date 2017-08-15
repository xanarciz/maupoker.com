<?php

function ipx($a){
	$d = 0.0;
	$b = explode(".", $a,4);
	for ($i = 0; $i < 4; $i++) {
		$d *= 256.0;
		$d += $b[$i];
	};
	return $d;
}

header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); // always modified
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0"); // HTTP/1.1
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache"); // HTTP/1.0

$_SERVER["HTTP_X_FORWARDED_FOR"];
$ipus = ipx($_SERVER['REMOTE_ADDR']);
$selcountry = "SELECT top 1 country FROM ip2nation WHERE ip < '".$ipus."' ORDER BY ip DESC";
list($country) = sqlsrv_fetch_array(sqlsrv_query($sqlconn, $selcountry), SQLSRV_FETCH_ASSOC);
$sql_reg = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select country from a83adm_config"), SQLSRV_FETCH_ASSOC);
$ctr = explode(",",$sql_reg["country"]);
$cnt = count($ctr);
for ($c=0; $c<$cnt; $c++) {
	if ($countryCode == $ctr[$c]) {
		echo "<script>window.location='main8940.php'</script>"; 
		die();
	}
}
function getUserIP(){
	$client  = @$_SERVER['HTTP_CLIENT_IP'];
	$forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
	$remote  = $_SERVER['REMOTE_ADDR'];
	$forward = isset(explode(",",$forward)[1]) ? explode(",",$forward)[1] : explode(",",$forward)[0];

	if(filter_var($client, FILTER_VALIDATE_IP)){
		$ip = $client;
	}elseif(filter_var($forward, FILTER_VALIDATE_IP)){
		$ip = $forward;
	}else{
		$ip = $remote;
	}

	return $ip;
}


if (($entered_login) && ($entered_password)) {
	$ip = getUserIP();

	if (isset($_COOKIE["livecasinouser"])) $cooks = $_COOKIE["livecasinouser"];
	else $cooks="";

	$sql = sqlsrv_query($sqlconn,"select usertype,userprefix,flag from u6048user_id where userid='$entered_login'");
	$levels = sqlsrv_fetch_array($sql,SQLSRV_FETCH_ASSOC);
	$level = $levels['usertype'];
	$agen = $levels['userprefix'];
	$flag = $levels['flag'];
	$sql2 = sqlsrv_query($sqlconn,"select userprefix from u6048user_id where userid='$agen'");
	$level2 = sqlsrv_fetch_array($sql2,SQLSRV_FETCH_ASSOC);
	$master = $level2['userprefix'];

	$onlyuser = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select onlyuserlogin from a83adm_config where onlyuserlogin <> ''"));
	$te = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select ip from a83adm_ipblok where ip = '".$ip."'",$params,$options));


		if($onlyuser["onlyuserlogin"]){
			if(substr($entered_login,0,strlen($onlyuser["onlyuserlogin"])) != $onlyuser["onlyuserlogin"]){
				session_unset();
				session_destroy();
				include($cfgProgDir . "/interface.php");
				die();
			}
		} else if($te > 0){
			session_unset();
			session_destroy();
			include($cfgProgDir . "/interface.php");
			die();
		}

		$cekstatus	= sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select maint from a83adm_config"));
		if ($cekstatus["maint"] == "1"){
			session_unset();
			session_destroy();
			$message = "Sedang MAINTENENCE,Silakan kembali nanti.";
			include($cfgProgDir . "/interface.php");
			die();
		}

	

	$sql = sqlsrv_query($sqlconn,"select usertype,userprefix,playerpt,referral_agent from u6048user_id where userid = '$entered_login'");
	$levels = sqlsrv_fetch_array($sql,SQLSRV_FETCH_ASSOC);
	$level = $levels['usertype'];
	$agent = $levels["userprefix"];
	$theplayerpt = $levels["playerpt"];
	$thereferral_agent = $levels["referral_agent"];
	
	$sql2 = sqlsrv_query($sqlconn,"select userprefix,usertype from u6048user_id where userid = '$agent'");
	$masters = sqlsrv_fetch_array($sql2,SQLSRV_FETCH_ASSOC);
	$master = $masters["userprefix"];
	$level_agent = $masters['usertype'];
	
	$sql3 = sqlsrv_query($sqlconn,"select userprefix from u6048user_id where userid = '$master'");
	$smasters = sqlsrv_fetch_array($sql3,SQLSRV_FETCH_ASSOC);
	$smaster = $smasters["userprefix"];
	
	//MOVE ALL USER_DATA TO USER_ACTIVE
	$sqldatauser = sqlsrv_query($sqlconn,"SELECT  curr, txh_share1, txh_share2, txh_aref_share, dmm_share1, dmm_share2, dmm_aref_share, ebn_share1, ebn_share2, ebn_aref_share, bjk_share1, bjk_share2, bjk_aref_share FROM u6048user_data WHERE userid = '$entered_login'");
	$datauser = sqlsrv_fetch_array($sqldatauser,SQLSRV_FETCH_ASSOC);
	$curruser = $datauser["curr"];
	$txhshare = $datauser["txh_share1"].";".$datauser["txh_share2"].";".$datauser["txh_aref_share"];
	$dmmshare = $datauser["dmm_share1"].";".$datauser["dmm_share2"].";".$datauser["dmm_aref_share"];
	$ebnshare = $datauser["ebn_share1"].";".$datauser["ebn_share2"].";".$datauser["ebn_aref_share"];
	$bjkshare = $datauser["bjk_share1"].";".$datauser["bjk_share2"].";".$datauser["bjk_aref_share"];
	$sqldataagent = sqlsrv_query($sqlconn,"SELECT  curr, txh_share1, txh_share2, txh_aref_share, dmm_share1, dmm_share2, dmm_aref_share, ebn_share1, ebn_share2, ebn_aref_share, bjk_share1, bjk_share2, bjk_aref_share FROM u6048user_data WHERE userid = '$agent'");
	$dataagent = sqlsrv_fetch_array($sqldataagent,SQLSRV_FETCH_ASSOC);
	$agent_txhshare = $dataagent["txh_share1"].";".$dataagent["txh_share2"].";".$dataagent["txh_aref_share"];
	$agent_dmmshare = $dataagent["dmm_share1"].";".$dataagent["dmm_share2"].";".$dataagent["dmm_aref_share"];
	$agent_ebnshare = $dataagent["ebn_share1"].";".$dataagent["ebn_share2"].";".$dataagent["ebn_aref_share"];
	$agent_bjkshare = $dataagent["bjk_share1"].";".$dataagent["bjk_share2"].";".$dataagent["bjk_aref_share"];
	$sqldatamaster = sqlsrv_query($sqlconn,"SELECT  curr, txh_share1, txh_share2, txh_aref_share, dmm_share1, dmm_share2, dmm_aref_share, ebn_share1, ebn_share2, ebn_aref_share, bjk_share1, bjk_share2, bjk_aref_share FROM u6048user_data WHERE userid = '$master'");
	$datamaster = sqlsrv_fetch_array($sqldatamaster,SQLSRV_FETCH_ASSOC);
	$master_txhshare = $datamaster["txh_share1"].";".$datamaster["txh_share2"].";".$datamaster["txh_aref_share"];
	$master_dmmshare = $datamaster["dmm_share1"].";".$datamaster["dmm_share2"].";".$datamaster["dmm_aref_share"];
	$master_ebnshare = $datamaster["ebn_share1"].";".$datamaster["ebn_share2"].";".$datamaster["ebn_aref_share"];
	$master_bjkshare = $datamaster["bjk_share1"].";".$datamaster["bjk_share2"].";".$datamaster["bjk_aref_share"];
	$sqldatasmaster = sqlsrv_query($sqlconn,"SELECT  curr, txh_share1, txh_share2, txh_aref_share, dmm_share1, dmm_share2, dmm_aref_share, ebn_share1, ebn_share2, ebn_aref_share, bjk_share1, bjk_share2, bjk_aref_share FROM u6048user_data WHERE userid = '$smaster'");
	$datasmaster = sqlsrv_fetch_array($sqldatasmaster,SQLSRV_FETCH_ASSOC);
	$smaster_txhshare = $datasmaster["txh_share1"].";".$datasmaster["txh_share2"].";".$datasmaster["txh_aref_share"];
	$smaster_dmmshare = $datasmaster["dmm_share1"].";".$datasmaster["dmm_share2"].";".$datasmaster["dmm_aref_share"];
	$smaster_ebnshare = $datasmaster["ebn_share1"].";".$datasmaster["ebn_share2"].";".$datasmaster["ebn_aref_share"];
	$smaster_bjkshare = $datasmaster["bjk_share1"].";".$datasmaster["bjk_share2"].";".$datasmaster["bjk_aref_share"];
	
	$sessid=base64_encode(md5(session_id()));
	$_SESSION["sess_key"]=$sessid;
	//$sessid = sanitizex($sessid);	
	$sql_securex = sqlsrv_query($sqlconn,"SELECT id, gametype from u6048user_active WHERE userid='$entered_login' order by gametime asc",$params,$options);

	if ((!@sqlsrv_num_rows($sql_securex)) and ($entered_login)) {
		$partdomain = $_SESSION['part_domain'];
		$sessid = base64_encode(md5(session_id()));
		sqlsrv_query($sqlconn,"delete from u6048user_active where userid ='".$entered_login."'");
		$sqlx = "insert into u6048user_active (entertime,gametime,gametype,tableid,userid,usertype,agent_usertype,playerpt,msg,IP,".SESS_FIELD.",smaster,master,agent,webid,www,curr,txh_share,dmm_share,ebn_share,bjk_share,agent_txh_share,agent_dmm_share,agent_ebn_share,agent_bjk_share,master_txh_share,master_dmm_share,master_ebn_share,master_bjk_share,smaster_txh_share,smaster_dmm_share,smaster_ebn_share,smaster_bjk_share,referral_agent) values(GETDATE(),GETDATE(),'-','-','$entered_login','$level','$level_agent','$theplayerpt','','".$ip."','".$sessid."','$smaster','$master','$agent','$partdomain','".$www."','".$curruser."','".$txhshare."','".$dmmshare."','".$ebnshare."','".$bjkshare."','".$agent_txhshare."','".$agent_dmmshare."','".$agent_ebnshare."','".$agent_bjkshare."','".$master_txhshare."','".$master_dmmshare."','".$master_ebnshare."','".$master_bjkshare."','".$smaster_txhshare."','".$smaster_dmmshare."','".$smaster_ebnshare."','".$smaster_bjkshare."','".$thereferral_agent."')";
		sqlsrv_query($sqlconn,$sqlx);
		
		// Log Login yang Lama (masa peralihan ke log login yang baru)
		include_once("config_db2.php");
		$sqly = "insert into log_loginlog (gametype,crttime,userid,userprefix,ip,lastuser,status,www) values('-',GETDATE(),'$entered_login','$agen','$ip','$cooks','user login','".$www."')";	
		sqlsrv_query($sqlconn_db2,$sqly);
		
		// Log Login (yang baru kalau data sudah stabil log lama dihapus)
		$queryLogLogin = "INSERT INTO j2365join_playerlog (userid,userprefix,action,ip,client_ip,forward_ip,remote_ip,Info,CreatedDate) 
				 		  VALUES ('$entered_login','$agen','Login','" . getUserIP2() . "','" . getUserIP2('HTTP_CLIENT_IP') . "','" . getUserIP2('HTTP_X_FORWARDED_FOR') . "','" . getUserIP2('REMOTE_ADDR') . "', 'Login from " . $_SERVER['SERVER_NAME'] . "', GETDATE())";
		sqlsrv_query($sqlconn_db2,$queryLogLogin);
		
		sqlsrv_query($sqlconn,"update u6048user_id set lastlogin = GETDATE() where userid = '".$entered_login."'");
	} else {
		$act = sqlsrv_fetch_array($sql_securex,SQLSRV_FETCH_ASSOC);
		$gametype = $act[""];
		if ($gametype == "-") {
			$typex = "-";
		} else {
			$typex = $gametype; 
		}
		$sessid=base64_encode(md5(session_id()));
		$sqlz = "update u6048user_active set gametime=GETDATE(), gametype='".$typex."', tableid='-', ".SESS_FIELD."='".$sessid."', ip = '".$ip."', www = '".$www."' where userid='$entered_login'";
		sqlsrv_query($sqlconn,$sqlz);
	}	


	$waktucookiex=time()+(60*60*24*31*12);
	setcookie("livecasinouser",$entered_login,$waktucookiex);

	
}

if (($flag == 3 or $flag == 2 )and strpos($nonWWW, "kartupoker") === FALSE and strpos($nonWWW, "loginkp") === FALSE){
	include($cfgProgDir . "/validation_otp.php");
	
	exit();
}

//CHANGE NICKNAME
if ($flag == 0){
	include($cfgProgDir . "/change_nickname.php");
	
	exit();
}
//PIN CHECK
if (!$_SESSION["pin"] || $_SESSION["pin"]==""){

	include($cfgProgDir . "/validation.php");
	
	exit();
}



$sessid=base64_encode(md5(session_id()));

$pgp = sqlsrv_query($sqlconn,"SELECT id from u6048user_active where userid='$login' and $cfgDbSessfield='".$sessid."'",$params,$options);
	//echo sqlsrv_num_rows($pgp);
	if (!@sqlsrv_num_rows($pgp)) {
		//echo "ga keluar?";

		$message = "WARNING! There are some user: \"$login\" online now<script>var timeID = setTimeout(\"top.location = './';\", 5000)</script>";
		session_unset();
		session_destroy();
		//include($cfgProgDir . "/interface.php");
		echo "<script>  window.location='".$DalamGame.$loginurl."' </script>";
		
	}
	if(!$_COOKIE['_sbr'] && $_SESSION['login']){
		$subscribe = 0;
		setcookie("_sbr", $_SESSION['login'], time()+(3600 * 24));
	}elseif($_COOKIE['_sbr'] != $_SESSION['login']){
		unset($_COOKIE['_sbr']);
		setcookie('_sbr', null, -1, '/');
		$subscribe = 0;
	}else{
		$subscribe = 1;
	}

?>