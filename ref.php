<?php
require("config.php");
$ref = strtoupper($_GET["ref"]);

$q = sqlsrv_query($sqlconn, "select reflink_count,userid from u6048user_id where loginid = '".$ref."' and subwebid='".$subwebid."'",$params,$options);
if (sqlsrv_num_rows($q) > 0){
	$aku = sqlsrv_fetch_array($q, SQLSRV_FETCH_ASSOC);
	//$refuserid = $aku["userid"];
	$tot = $aku["reflink_count"] + 1;
	sqlsrv_query($sqlconn, "update u6048user_id set reflink_count ='".$tot."' where userid ='".$refuserid."'"); 

	setcookie ("ref", $ref, time() + 2529000);
}
?>

<HTML>
<BODY>
	<SCRIPT language='javascript'>
	self.document.location='http://<?php echo $DomainName?>/';
	</SCRIPT>
</BODY>
</HTML>