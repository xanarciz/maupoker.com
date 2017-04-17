<?PHP
if (phpversion() >= 4) {
	// phpversion = 4
	session_start();
	// session hack to make sessions on old php4 versions work
	$partdomain = $_SESSION['part_domain'];
	$partuid = $_SESSION['part_uid'];
	$olog = $_SESSION['login'];
	$ss = @sqlsrv_num_rows(sqlsrv_query($sqlconn, "SELECT Id from p3378partner_userid WHERE UserId='".$olog."'",$params,$options));
	if ($ss > 0) {
		$exitlink = "../partner/user_interface.php";
	} else {
		$exitlink = "../index.php";
	
		if (phpversion() > 4.0) {
			unset($HTTP_SESSION_VARS['login']);
			unset($HTTP_SESSION_VARS['password']);
		} else {
			$_SESSION["login"] = "";
			$_SESSION["password"] = "";
		}
		session_destroy();
		sqlsrv_query($sqlconn,"delete from u6048user_active where userid ='".$olog."'");
	}
	$sessionPath = session_get_cookie_params(); 
}

echo "<script>  self.document.location='$exitlink' </script>";
die();
?>