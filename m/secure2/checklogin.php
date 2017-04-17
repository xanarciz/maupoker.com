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
	}	}
	else { $bgImage = $backgrounds[$r]; }
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
			}	}
			return(false);
	}	}
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
		if($i > 47 && $i < 58) {
		}
		else if($i > 64 && $i < 91) {
		}
		else if($i > 96 && $i < 123) {
		}
		else if ($i == 45 || $i == 95) {  }
		else {
		die ('<center><font color=red><b>Error:  Cek Username!</b></font>&nbsp;</center>');
		}
	}
}

$entered_login = strtoupper($_POST['entered_login']);
$entered_password = $_POST['entered_password'];
$entered_val=strtolower($_POST['entered_val']);
$partdomain = $_SESSION['part_domain'];
$partlogin = $_SESSION['part_login'];
$partuid = $_SESSION['part_uid'];
$captcha_x = $_SESSION['CAPTCHAString'];  
$flag =""; 
if (!$entered_login && !$entered_password) {
	// use data from session
	session_start();
	//echo "$_SESSION[login] test";
	$login = $_SESSION['login'];
	$user_login = $_SESSION['user_login'];
	$password = $_SESSION['password'];
	$captcha_x = $_SESSION['CAPTCHAString'];
	$captcha = $_SESSION['captcha'];

/*	$login = sanitizex($login);
	$password = sanitizex($password);
*/
}
else 
{
	// use entered data
	session_start();
	// encrypt entered login & password
	$login = $entered_login;	
	$password = hash("sha256",md5($entered_password).'8080');
	$captcha = $entered_val;
// session hack to make sessions on old php4 versions work
	
	// session 
	$_SESSION['user_login'] = $login;
	$_SESSION['login'] = $login;
	$_SESSION['password'] = $password;
	$_SESSION['captcha'] = $captcha;


	$loginx = $_SESSION['login'];
	$passwordx = $_SESSION['password'];
	$partdomainx = $_SESSION['part_domain'];
	$partloginx = $_SESSION['part_login'];
	$partuidx = $_SESSION['part_uid'];
	$captchax = $_SESSION['CAPTCHAString'];
	$captcha_login = $_SESSION['CAPTCHAStringLogin'];
	
	session_destroy();
	session_start();

	$_SESSION['login'] = $loginx;
	$_SESSION['user_login'] = $loginx;
	$_SESSION['password'] = $passwordx;
	$_SESSION['part_domain'] = $partdomainx;
	$_SESSION['part_login'] = $partloginx;
	$_SESSION['part_uid'] = $partuidx;
	$_SESSION['CAPTCHAString'] = $captchax;
	$_SESSION['CAPTCHAStringLogin'] = $captcha_login;
	$_SESSION['captcha'] = $captcha;

	$login = $_SESSION['login'];
	$user_login = $_SESSION['user_login'];
	
	$password = $_SESSION['password'];
	$partdomain = $_SESSION['part_domain'];
	$partlogin = $_SESSION['part_login'];
	$partuid = $_SESSION['part_uid'];

	/*$login = sanitizex($login);
	$password = sanitizex($password);
*/
	unset($loginx);
	unset($passwordx);
	unset($partdomainx);
	unset($partuidx);
	unset($partloginx);
	unset($captchax);
	unset($captcha_login);



}

if ($partuid == "NULL" || $partdomain == "NULL") {
	$partuid = "";
	$partdomain = "";
	$partlogin = "";
}


$passenter = base64_encode(md5($password));
if ($partuid != "" || $partdomain != "") {
	$part = sqlsrv_num_rows(sqlsrv_query($sqlconn, "SELECT Id from p3378partner_userid WHERE UserId='".$partuid."' and WebId='".$partdomain."'",$params, $options));
	
	if ($part > 0) {
		$passenter = $password;
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

// use phpSecurePages with Database
if ($useDatabase == true) {
	if (!$captcha){
			//echo "sini woii";die();
		$message = $strNoVal;
		session_destroy();
		include($cfgProgDir . "interface.php");
		exit;
	}
	if (strtolower($_SESSION['CAPTCHAStringLogin']) != $captcha) {
		//echo "error captcha...!!";
		$message = $strValFalse;
		session_destroy();
		include($cfgProgDir . "interface.php");
		exit;
	}
	//===check login whitelable!!!
	if($subwebid > 0){
		$userAgent = sqlsrv_query($sqlconn, "SELECT userprefix  FROM u6048user_id WHERE loginid = '$user_login' and usertype = 'U' and subwebid = '".$subwebid."'",$params,$options);
		$userAgent2 = sqlsrv_fetch_array($userAgent, SQLSRV_FETCH_ASSOC);
		$totalAgent = sqlsrv_num_rows($userAgent);
		if($totalAgent == 0){
			$message = $strUserNotExist;
			include($cfgProgDir . "interface.php");
			exit;
		}else{
			$userMaster = sqlsrv_query($sqlconn, "SELECT userprefix  FROM u6048user_id WHERE userid = '".$userAgent2["userprefix"]."' and usertype = 'A' and userprefix='".$masterwlable."' ",$params,$options);
			$userMaster2 = sqlsrv_fetch_array($userMaster, SQLSRV_FETCH_ASSOC);
			$totalMaster = sqlsrv_num_rows($userMaster);
			if($totalMaster == 0){
				$message = $strUserNotExist;
				include($cfgProgDir . "interface.php");
				exit;
			}
		}
	}
	
	//==== end checking login whitelable!!!
	$userQuery = sqlsrv_query($sqlconn, "SELECT $cfgDbLoginfield, $cfgDbPasswordfield, $cfgDbUserLevelfield,$cfgDbStatfield,flag FROM $cfgDbTableUsers WHERE loginid = '$user_login' and usertype = 'U' and subwebid = '".$subwebid."'",$params,$options)
	//$userQuery = mysql($cfgDbDatabase, "SELECT * FROM $cfgDbTableUsers WHERE $cfgDbLoginfield = '$login'")
	or die($strNoDatabase);
	// check user and password
	if (sqlsrv_num_rows($userQuery) != 0) {
		// user exist --> continue
		$userArray = sqlsrv_fetch_array($userQuery, SQLSRV_FETCH_ASSOC);
		$login = $userArray[$cfgDbLoginfield];
		$entered_login = $login;
		$flag = $userArray["flag"];
		$_SESSION["login"] = $login;
	} else {
		// user not present in database
		$message = $strUserNotExist;
//		include($cfgProgDir . "logout.php");
		include($cfgProgDir . "interface.php");
		exit;
	}
	if (!$userArray[$cfgDbPasswordfield]) {
		//die("MAMPOS3");
		// password not present in database for this user
		$message = $strPwNotFound;
		//die("wkkwkw5");
		include($cfgProgDir . "interface.php");
		exit;
	}
	//die($userArray["$cfgDbPasswordfield"]."<br>".$password);
		if ($userArray["$cfgDbPasswordfield"] != $password) {
		//die("MAMPOS4");
		// password is wrong
		$message = $strPwFalse;
		//include($cfgProgDir . "logout.php");
		session_destroy();
		include($cfgProgDir . "interface.php");
		exit;
	}

	if ($userArray[$cfgDbStatfield] == 1) {
		// password not present in database for this user
		$message = $strUserNotAllowed;
		session_destroy();
		include($cfgProgDir . "interface.php");
		exit;
	}
	if ( isset($userArray["$cfgDbUserLevelfield"]) && !empty($cfgDbUserLevelfield) ) {
		$userLevel = stripslashes($userArray["$cfgDbUserLevelfield"]);
	}
	if ( ( $requiredUserLevel && !empty($requiredUserLevel[0]) ) || $minUserLevel ) {
		// check for required user level and minimum user level
		if ( !isset($userArray["$cfgDbUserLevelfield"]) ) {
			// check if column (as entered in the configuration file) exist in database
			$message = $strNoUserLevelColumn;
			include($cfgProgDir . "interface.php");
			exit;
		}

		if ( empty($cfgDbUserLevelfield) || ( !in_array_php3($userLevel, $requiredUserLevel) && ( !isset($minUserLevel) || empty($minUserLevel) || $userLevel < $minUserLevel ) ) ) {
			// this user does not have the required user level
			$message = $strUserNotAllowed;
			include($cfgProgDir . "interface.php");
			exit;
		}	

	}
	if ( isset($userArray["$cfgDbUserIDfield"]) && !empty($cfgDbUserIDfield) ) {
		$ID = stripslashes($userArray["$cfgDbUserIDfield"]);
	}	

//Start working//
if ($_POST['entered_login'] && $_POST['entered_password']){
	sqlsrv_query($sqlconn,"delete from u6048user_active where userid='".$login."'");
}

include($cfgProgDir . "cookie.php");


}

	

// use phpSecurePages with Data

elseif ($useData == true && $useDatabase != true) {

	$numLogin = count($cfgLogin);
	$userFound = false;
	// check all the data input

	for ($i = 1; $i <= $numLogin; $i++) {
		if ($cfgLogin[$i] != '' && $cfgLogin[$i] == $login) {
			// user found --> check password
			if ($cfgPassword[$i] == '' || $cfgPassword[$i] != $password) {
				// password is wrong
				$message = $strPwFalse;
				include($cfgProgDir . "logout.php");
				//die("wkkwkw9");
				include($cfgProgDir . "interface.php");
				exit;
			}
			$userFound = true;
			$userNr = $i;
	}	}
	if ($userFound == false) {
		// user is wrong
		$message = $strUserNotExist;
		include($cfgProgDir . "logout.php");
		//die("wkkwkw10");
		include($cfgProgDir . "interface.php");
		exit;
	}
	$userLevel = $cfgUserLevel[$userNr];
	if ( ( $requiredUserLevel && !empty($requiredUserLevel[0]) ) || $minUserLevel ) {
		// check for required user level and minimum user level
		if ( !in_array_php3($userLevel, $requiredUserLevel) && ( !isset($minUserLevel) || empty($minUserLevel) || $userLevel < $minUserLevel ) ) {
			// this user does not have the required user level
			$message = $strUserNotAllowed;
			die("wkkwkw11");
			include($cfgProgDir . "interface.php");
			exit;
	}	}	
	$ID = $cfgUserID[$userNr];
}
// neither of the two data inputs was chosen
else
{
	die("wkkwkw12");
	$message = $strNoDataMethod;
	include($cfgProgDir . "interface.php");
	exit;
}

// restore values
if ($dbOld) $db = $dbOld;
if ($messageOld) $message = $messageOld;
//mysqli_query($mysqlcon,"UPDATE `useronline` SET `action`='".substr($_SERVER["PHP_SELF"],0,250)."' WHERE `sess`='$PHPSESSID' ");

?>
