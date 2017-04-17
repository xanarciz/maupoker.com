<?php
//$DalamGame = "../";
$page ="memo";
include("config.php");
include_once("config_db2.php");
include($cfgProgDir."secure.php");

if (!$_SESSION["login"]){
	exit ("Please login first");
}
if ($_POST["submit"]){
	if ( !$_POST["id"] ){
		exit ("Please login first");
	}
	$id = $_POST["id"];
	if ($id > 0){
		$data_memo_old = sqlsrv_fetch_array(sqlsrv_query($sqlconn_db2, "select mbody,msubject from j2365join_memo where id = '".$id."' and mfrom = '".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
	}

	$body = $_POST["descr"];
	if (!$body){
		exit ("<font color=red>Please fill meessage!</font>");
	}else{
		$jum = sqlsrv_num_rows(sqlsrv_query($sqlconn_db2, "select id from j2365join_memo where mfrom = '".$login."' and mdate > dateadd(minute,-2,GETDATE()) and mto = '".$agentwlable."'",$params,$options));
		if ($jum > 0) {
			exit ("Send memo failed, try again 5 minutes later.");
		}else {
			$nama = "";
			$sql1	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select memo from a83adm_config") , SQLSRV_FETCH_ASSOC);
			$userx3	= $sql1["memo"]. "";
			$userx	="*,".$userx3.",*";
			
			$userx2 = sqlsrv_query($sqlconn,"select userprefix,playerpt from u6048user_id where userid = '".$login."'");
			$userxx=sqlsrv_fetch_array($userx2,SQLSRV_FETCH_ASSOC);
			if($userxx["playerpt"]==0){
				$userx= $userxx["userprefix"];
			}
			sqlsrv_query($sqlconn_db2, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$userx."','".$login."','','".$data_memo_old["msubject"]."','".$data_memo_old["mbody"].'##quote##'.$body."','0',GETDATE())");
			exit ("Send Memo Successful!!!");
		}
	}
}
?>