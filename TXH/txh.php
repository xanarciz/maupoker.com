<?php
$DalamGame = "../";
$requiredUserLevel = array('U');
//include("../koneksi_login.php");
include($cfgProgDir."secure.php");
//==========================================TEXAS CHIP=======================================

$tBal = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select top 1 total from t6413txh_lastorder where userid = '".$login."' order by Id desc"), SQLSRV_FETCH_ASSOC);
$tChip = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select TXH from u6048user_coin where userid = '".$login."'"), SQLSRV_FETCH_ASSOC);
if ($tBal["total"] != null || $tBal["total"] != ""){
	$balt = $tBal["total"];
	$chip = $tChip["TXH"];
	if ($balt < $chip){
		sqlsrv_query($sqlconn, "insert into t6413txh_lastorder (userid,tableid,bdate,info,status,amount,total,periode,gametype) values ('".$login."','Menu',GETDATE(),'Adjust Balance Problem', '-','0','".$balt."','-','-')");
		sqlsrv_query($sqlconn, "update u6048user_coin set TXH = '".$balt."' where userid = '".$login."'");
	}else if ($balt > $chip){
		sqlsrv_query($sqlconn, "insert into t6413txh_lastorder (userid,tableid,bdate,info,status,amount,total,periode,gametype) values ('".$login."','Menu',GETDATE(),'Adjust Balance Problem', '-','0','$chip','-','-')");
	}
}

$file = "../game-texas2/txh.php";
header("location: $file");
?>