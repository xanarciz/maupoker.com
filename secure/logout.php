<?PHP
if (phpversion() >= 4) {
	// phpversion = 4
	// session hack to make sessions on old php4 versions work
	session_start();
	$partdomain = $_SESSION['part_domain'];
	$partuid = $_SESSION['part_uid'];
	$olog = $_SESSION['login'];
	
	$exitlink = "../index.php";

	if (phpversion() > 4.0) {
		unset($HTTP_SESSION_VARS['login']);
		unset($HTTP_SESSION_VARS['password']);
	} else {
		$_SESSION["login"] = "";
		$_SESSION["password"] = "";
	}
	session_destroy();
	$reqAPIlogout = array(
		"auth"      => $authapi,
		"webid"     => $subwebid,
		"agent"     => $agentwlable,
		"userid"	=> $olog,
		"type" 		=> "2"
	);

	$respout = sendAPI($url_Api."/loginlogout",$reqAPIlogout,'JSON','02e97eddc9524a1e');

	// print_r($respout);exit($olog);
	
	if($respout->status == 200 && $responseweb->resp->status == 00)
	{
		$message = $responseweb->resp->msg;
	}
	$sessionPath = session_get_cookie_params(); 
}

echo "<script>  self.document.location='$exitlink' </script>";
die();
?>