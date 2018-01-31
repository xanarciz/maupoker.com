<?php
require("config.php");
$ref = strtoupper($_GET["ref"]);

$reqAPIRef = array(
    "auth"    => $authapi,
    "webid"   => $subwebid,
    "loginid" => $ref
);
$page = "";
if (!$_COOKIE["ref"])$page="ref.php?ref=".$ref;
$response = sendAPI($url_Api."/ref",$reqAPIRef,'JSON','02e97eddc9524a1e');
if($response->status == 200){
	setcookie ("ref", $ref, time() + 2529000);
}
?>

<HTML>
<BODY>
	<SCRIPT language='javascript'>
	self.document.location='http://<?php echo $DomainName."/"; ?>'
	</SCRIPT>
</BODY>
</HTML>