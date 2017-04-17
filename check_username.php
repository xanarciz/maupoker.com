<?php
include_once("config.php");
$userid=$_POST["username"];

if($_GET["pattern"]==1 || $_GET["pattern"]==2){
	$pattern = $_GET["pattern"];
	
	if($pattern==1) $q=@sqlsrv_num_rows(sqlsrv_query($sqlconn,"select loginid from u6048user_id where loginid = '".$userid."'",$params,$options));
	else $q=@sqlsrv_num_rows(sqlsrv_query($sqlconn,"select userid from u6048user_id where userid = '".$userid."'",$params,$options));
	//$q1=@sqlsrv_num_rows(sqlsrv_query($sqlconn,"select userid from u6048user_data where userid = '".$userid."'",$params,$options));
	$q2=@sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from j2365join_onlinex where userid = '".$userid."'", $params,$options));
	//if ($q==0 && $q1==0 && $q2==0){
	if ($q==0 && $q2==0){
		echo 0;
	}else{
		echo 1;
	}
}
?>
