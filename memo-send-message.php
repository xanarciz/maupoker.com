<?php
//$DalamGame = "../";
include("config.php");
include_once("config_db2.php");
include($cfgProgDir."secure.php");

if (!$_SESSION["login"]){
	exit ("Please login first");
}
if ($_POST["submit"]){
	$subject = $_POST["title"];
	$body = $_POST["descr"];
	
	$subject = str_replace("http://", "", $subject);
	$subject = str_replace("<", "(", $subject);
	$subject = str_replace(">", ")", $subject);
	$body = str_replace("http://", "", $body);
	$body = str_replace("<", "(", $body);
	$body = str_replace(">", ")", $body);
	if (!$subject){
		exit ("<font color=red>Please fill subject!</font>");
	}else if (!$body){
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
			$fuser = substr($login, 0,1);

				$sql2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select val from a83adm_config3 where name='memogrupconfig'",$params,$options),SQLSRV_FETCH_NUMERIC);
					$_group = explode("#", $sql2[0]);
					for ($_g=0; $_g<count($_group); $_g++){
						if (ereg(",".$fuser.",",$_group[$_g])) {
							$mgrup = ($_g + 1);
							break;
						}
					}
					$userx2 = sqlsrv_query($sqlconn,"select userprefix,playerpt from u6048user_id where userid = '".$login."'");
					$userxx=sqlsrv_fetch_array($userx2,SQLSRV_FETCH_ASSOC);
					if($userxx["playerpt"]==0){
						$userx= $userxx["userprefix"];
					}
			sqlsrv_query($sqlconn_db2, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate,grup) values ('".$userx."','".$login."','','".$subject."','".$body."','0',GETDATE(),'".$mgrup."')");
			exit ("Send Memo Successful!!!");
		}
	}
}
?>