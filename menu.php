<?PHP 
include("config.php");
echo "<br><br><FONT SIZE=3 COLOR=red><center>Connecting to server. Please wait.....</FONT></center>";
session_start();
$login = $_SESSION["login"];
$jBal = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select top 1 total from j2365join_lastorder where userid='".$login."' order by bdate desc"), SQLSRV_FETCH_ASSOC);
$sDeposit = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select save_deposit from u6048user_id where userid='".$login."'"), SQLSRV_FETCH_ASSOC);
$jRunbet = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from j2365join_runbet where userid = '".$login."'",$params,$options));
$hari=mktime (date("H"),date("i"),date("s"),date("m"),date("d"),date("Y"));
$valdate1 = date("m/d/Y",$hari);

$user=sqlsrv_query($sqlconn, "select userid,xdeposit from u6048user_id where xdeposit>0 and userid='".$login."' order by xdeposit desc");
while($userx = sqlsrv_fetch_array($user, SQLSRV_FETCH_NUMERIC)){
	$grup=sqlsrv_query($sqlconn, "select grup,xdeposit from a83adm_grupbank where xdeposit>0 order by xdeposit asc");
	while($grupx=sqlsrv_fetch_array($grup, SQLSRV_FETCH_NUMERIC)){
		if($userx[1]>=$grupx[1]){
			//$jdepo=sqlsrv_query($sqlconn, "update u6048user_id set bankgrup='".$grupx[0]."' where userid='".$login."'");
		}
	}
}

if ($jRunbet == 0){
	if ($jBal["total"] == null || $jBal["total"] == ""){
	if ($sDeposit["save_deposit"] > 0){
		sqlsrv_query($sqlconn, "update u6048user_id set save_deposit = '0' where userid = '".$login."'");
		}
	}elseif ($jBal["total"] != null || $jBal["total"] != ""){
		 $bal = $jBal["total"];
		 $deposit = $sDeposit["save_deposit"];
		if ($bal < $deposit){
			sqlsrv_query($sqlconn, "insert into ".$db2.".dbo.j2365join_balance_old (userid,tableid,bdate,info,status,amount,total,periode,gametype) values ('".$login."','Menu',GETDATE(),'Adjust Balance Problem', '-','0','$bal','-','-')");
			sqlsrv_query($sqlconn, "update u6048user_id set save_deposit = '".$bal."' where userid = '".$login."'");
			$jLast = sqlsrv_query($sqlconn, "select * from j2365join_lastorder where userid = '".$login."' order by id desc",$params,$options);
			$jum = sqlsrv_num_rows($jLast);
			for ($i=0; $i<$jum; $i++){
				$array = sqlsrv_fetch_array($jLast, SQLSRV_FETCH_ASSOC);
				if ($i>1){
					sqlsrv_query($sqlconn, "delete from j2365join_lastorder where id = '".$array["id"]."'");
				}
			}
			sqlsrv_query($sqlconn, "insert into j2365join_lastorder (userid,tableid,bdate,info,status,amount,total,periode,gametype) values ('".$login."','Menu',GETDATE(),'Adjust Balance Problem', '-','0','$bal','-','-')");
		}else if ($bal > $deposit){
			sqlsrv_query($sqlconn, "insert into ".$db2.".dbo.j2365join_balance_old (userid,tableid,bdate,info,status,amount,total,periode,gametype) values ('".$login."','Menu',GETDATE(),'Adjust Balance Problem', '-','0','$deposit','-','-')");
			$jLast = sqlsrv_query($sqlconn, "select * from j2365join_lastorder where userid = '".$login."' order by id desc",$params,$options);
			$jum = sqlsrv_num_rows($jLast);
			for ($i=0; $i<$jum; $i++){
				$array = sqlsrv_fetch_array($jLast, SQLSRV_FETCH_ASSOC);
				if ($i>1){
					sqlsrv_query($sqlconn, "delete from j2365join_lastorder where id = '".$array["id"]."'");
				}
			}
			sqlsrv_query($sqlconn, "insert into j2365join_lastorder (userid,tableid,bdate,info,status,amount,total,periode,gametype) values ('".$login."','Menu',GETDATE(),'Adjust Balance Problem', '-','0','$deposit','-','-')");
		}
	}
	$sql = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select periode from u6048user_data where userid = '".$login."'"),SQLSRV_FETCH_ASSOC);
	if ($sql["periode"] >= 20000 ){
		sqlsrv_query($sqlconn, "update u6048user_data set periode = '1' where userid = '".$login."'");
	}
}
sqlsrv_query($sqlconn, "update u6048user_id set lastlogin=GETDATE() where userid='".$login."'");
if($ToMenu == 0){
	echo "<script>  window.location='deposit.php' </script>";
} else {
	echo "<script>  window.location='logout.php'</script>";
}
?>