<?PHP
if (phpversion() >= 4) {
	// phpversion = 4
	// session hack to make sessions on old php4 versions work
	session_start();
	$partdomain = isset($_SESSION['part_domain']) ? $_SESSION['part_domain'] :'';
	$partuid = isset($_SESSION['part_uid']) ? $_SESSION['part_uid'] :'';
	$olog = isset($_SESSION['login']) ? $_SESSION['login'] :'';
	
	$exitlink = "../index.php";

// $HTTP_SESSION_VARS
	if (phpversion() > 4.0) {
		unset($_SESSION['login']);
		unset($_SESSION['password']);
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
	
	if(isset($respout->status) == 200 && isset($responseweb->resp->status) == 00)
	{
		$message = isset($responseweb->resp->msg) ? $responseweb->resp->msg : '';
	}
	$sessionPath = session_get_cookie_params(); 
}

echo "<script>  self.document.location='$exitlink' </script>";
die();
?>