<?PHP
// loading functions and libraries
function random($max) {
	// create random number between 0 and $max
	srand( (double)microtime() * 1000000 );
	$r = round(rand(0, $max));
	if ($r != 0) $r = $r - 1;
	return $r;
}

function rotateBg() {
	// rotate background login interface
	global $backgrounds, $bgImage, $i;
	$c = count($backgrounds);
	if ($c == 0) return;
	$r = random($c);
	if ($backgrounds[$r] == '' && $i < 10) {
		$i++;
		rotateBg();
	} elseif ($i >= 10) {
		if (!$bgImage || $bgImage == '') {
			$bgImage = 'bg_lock.gif';
		} else {
			$bgImage = $bgImage;
		}
	} else { $bgImage = $backgrounds[$r]; }
	return $bgImage;
}

function in_array_php3($needle, $haystack) {
	// check if the value of $needle exist in array $haystack
	// works for both php3 and php4
	if ($needle && $haystack) {
		if (phpversion() >= 4) {
			// phpversion = 4
			return(in_array($needle, $haystack));
		} else {
			// phpversion = 3
			for ($i = 0; $i <= count($haystack); $i++) {
				if ($haystack[$i] == $needle) {
					return(true);
				}
			}
			return(false);
		}
	}
	else return(false);
}


if ($noDetailedMessages == true) {
	$strUserNotExist = $strUserNotAllowed = $strPwNotFound = $strPwFalse = $strNoPassword = $strNoAccess;
}
if ($bgRotate == true) {
	$i = 0;
	$bgImage = rotateBg();
}

if(substr($entered_login,0,1) != "*"){
	foreach (count_chars($entered_login, 1) as $i => $val) {
		if($i > 47 && $i < 58) {}
		else if($i > 64 && $i < 91) {}
		else if($i > 96 && $i < 123) {}
		else if ($i == 45 || $i == 95) {  }
		else { die ('<center><font color=red><b>Error:  Cek Username!</b></font>&nbsp;</center>'); }
	}
}


$entered_login 	  = strtoupper($_POST['entered_login']);
$entered_password = $_POST['entered_password'];
$entered_val	  = strtolower($_POST['entered_val']);
$partdomain 	  = $_SESSION['part_domain'];
$partlogin 		  = $_SESSION['part_login'];
$partuid 		  = $_SESSION['part_uid'];
$captcha_x 		  = $_SESSION['CAPTCHAString'];
$flag 			  = "";

if (!$entered_login && !$entered_password) {
	// use data from session
	//echo "$_SESSION[login] test";
    session_start();
	$login 		= $_SESSION['login'];
	$user_login = $_SESSION['user_login'];
	$password 	= $_SESSION['password'];
	$sessid 	= $_SESSION['sessid'];
	// $captcha_x = $_SESSION['CAPTCHAString'];
	// $captcha = $_SESSION['captcha'];

/*	$login = sanitizex($login);
	$password = sanitizex($password);
*/
}
else 
{
	// use entered data
	// encrypt entered login & password
    session_start();
	$login = $entered_login;	
	$password = hash("sha256",md5($entered_password).'8080');
	$captcha = $entered_val;
// session hack to make sessions on old php4 versions work
	
	if (!$captcha){
		//echo "sini woii";die();
		
		$message = $strNoVal;
		session_destroy();
		include($cfgProgDir . "interface.php");
		exit;
	}
	if (!checkCaptcha('CAPTCHAStringLogin',$captcha)) {
		//echo "error captcha...!!"
		$message = $strValFalse;
		session_destroy();
		include($cfgProgDir . "interface.php");
		exit;
	}

    if (isset($_COOKIE["livecasinouser"])) $cooks = $_COOKIE["livecasinouser"];
    else $cooks="";

	$sessid = base64_encode(md5(session_id().time()));
	
	$reqAPILogin = array(
		"auth"		=> $authapi,
		"webid"		=> $subwebid,
        "domain"	=> $nonWWW,
        "loginid"	=> $entered_login,
        "password"	=> $entered_password,
        "ipclient" 	=> getUserIP2('HTTP_CLIENT_IP'),
        "ipforward" => getUserIP2('HTTP_X_FORWARDED_FOR'),
        "ipremote" 	=> getUserIP2('REMOTE_ADDR'),
		"type" 		=> "1",
		"ip"		=> getUserIP2(),
		"www"		=> 1,
		"device"	=> $device,
		"sessid"	=> $sessid,
        "lastuser"  => $cooks
	);
	
	$responseweb = sendAPI($url_Api."/loginlogout",$reqAPILogin,'JSON','');
	if($responseweb->status == '200' && $responseweb->resp->status == '00')
	{
		// session 
		$_SESSION['user_login'] = strtoupper($responseweb->resp->loginid);
		$_SESSION['login'] = strtoupper($responseweb->resp->userid);
		$_SESSION['password'] = $password;
		$_SESSION['sessid'] = $responseweb->resp->session;
		$_SESSION['captcha'] = $captcha;
		
		$login 		= $_SESSION['login'];
		$password 	= $_SESSION['password'];
		$user_login = $_SESSION['user_login'];
		$sessid 	= $_SESSION['sessid'];
        $_SESSION['optLogin'] = str_shuffle(time());

        $waktucookiex=time()+(60*60*24*31*12);
        setcookie("livecasinouser",$entered_login,$waktucookiex);
	}else{
		
		if(isset($responseweb->resp)){
			$message = $responseweb->resp->msg;
		}else{
			$message = $responseweb->debugMsg;
		}
		include($cfgProgDir . "interface.php");
		exit;
	}
}

if (!$login) {
	// no login available
	include($cfgProgDir . "interface.php");
	exit;
} elseif (!$password) {
	// no password available
	$message = $strNoPassword;
	include($cfgProgDir . "interface.php");
	exit;
}

include($cfgSecDir . "cookie.php");

?>