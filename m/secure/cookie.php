<?php

function ipx($a){
	$d = 0.0;
	$b = explode(".", $a,4);
	for ($i = 0; $i < 4; $i++) {
		$d *= 256.0;
		$d += $b[$i];
	};
	return $d;
}


function getIP() {
  // check for shared internet/ISP IP
  if (!empty($_SERVER['HTTP_CLIENT_IP']) && validate_ip($_SERVER['HTTP_CLIENT_IP']))
   return $_SERVER['HTTP_CLIENT_IP'];

  // check for IPs passing through proxies
  if (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
   // check if multiple ips exist in var
    $iplist = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
    foreach ($iplist as $ip) {
     if (validate_ip($ip))
      return $ip;
    }
   
  }
  if (!empty($_SERVER['HTTP_X_FORWARDED']) && validate_ip($_SERVER['HTTP_X_FORWARDED']))
   return $_SERVER['HTTP_X_FORWARDED'];
  if (!empty($_SERVER['HTTP_X_CLUSTER_CLIENT_IP']) && validate_ip($_SERVER['HTTP_X_CLUSTER_CLIENT_IP']))
   return $_SERVER['HTTP_X_CLUSTER_CLIENT_IP'];
  if (!empty($_SERVER['HTTP_FORWARDED_FOR']) && validate_ip($_SERVER['HTTP_FORWARDED_FOR']))
   return $_SERVER['HTTP_FORWARDED_FOR'];
  if (!empty($_SERVER['HTTP_FORWARDED']) && validate_ip($_SERVER['HTTP_FORWARDED']))
   return $_SERVER['HTTP_FORWARDED'];

  // return unreliable ip since all else failed
  return $_SERVER['REMOTE_ADDR'];
 }

 /**
  * Ensures an ip address is both a valid IP and does not fall within
  * a private network range.
  *
  * @access public
  * @param string $ip
  */
function validate_ip($ip) {
     if (filter_var($ip, FILTER_VALIDATE_IP, 
                         FILTER_FLAG_IPV4 | 
                         FILTER_FLAG_IPV6 |
                         FILTER_FLAG_NO_PRIV_RANGE | 
                         FILTER_FLAG_NO_RES_RANGE) === false)
         return false;
     self::$ip = $ip;
     return true;
 }

header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); // always modified
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0"); // HTTP/1.1
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache"); // HTTP/1.0

$_SERVER["HTTP_X_FORWARDED_FOR"];
/*if (!preg_match("/MSIE/i",$_SERVER['HTTP_USER_AGENT']) && !preg_match("/Firefox/i",$_SERVER['HTTP_USER_AGENT'])) {
echo "<center><BR><BR><BR><table width=500 border=1 bordercolor=black cellspacing=0 cellpadding=0 style='border-width:1px;border-collapse:collapse;' bgcolor=black><tr><td width=100% align=center><BR><font color=yellow size=2 face=arial><B><I>You Have To Use Internet Explorer or Mozilla Firefox <BR>".$SITENAME."<BR>&nbsp;</i></b></td></tr></table></center>";
die();
} */

$ipus = ipx($_SERVER['REMOTE_ADDR']);
//$ip_bytes = explode(".", $ipus);
//$longnum = ($ip_bytes[0] << 24) | ($ip_bytes[1] << 16) |
//           ($ip_bytes[2] << 8) | $ip_bytes[3];
//$ipus = $longnum;
//echo "$ipus";
//$selcountry = "SELECT top 1 c.country, i.country FROM ip2nationCountries c, ip2nation i WHERE  i.ip = '$ipus' AND c.code = i.country ORDER BY i.ip DESC";

$selcountry = "SELECT top 1 country FROM ip2nation WHERE ip < '".$ipus."' ORDER BY ip DESC";


list($country) = sqlsrv_fetch_array(sqlsrv_query($sqlconn, $selcountry), SQLSRV_FETCH_ASSOC);


$sql_reg = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select country from a83adm_config"), SQLSRV_FETCH_ASSOC);
$ctr = explode(",",$sql_reg["country"]);
$cnt = count($ctr);
//echo "$cnt nih dan $sql_reg";
for ($c=0; $c<$cnt; $c++) {
	//echo "$countryCode dan $ctr[$c] ";
	//die();
	if ($countryCode == $ctr[$c]) {
		
		echo "<script>window.location='main8940.php'</script>"; 
		//echo "<center><BR><BR><BR><BR><BR><BR><BR><BR><table width=500 border=1 bordercolor=black cellspacing=0 cellpadding=0 style='border-width:1px;border-collapse:collapse;' bgcolor=black><tr><td width=100% align=center><BR><font color=yellow size=2 face=arial><B><I>You Cannot Acces This Site<BR>Your IP is $ipus,&nbsp; Country $countryName&nbsp;</i></b></td></tr></table></center>";
		die();

	}
}

/*$entered_login = sanitizex($entered_login);
$entered_password = sanitizex($entered_password);
*/

if (($entered_login) && ($entered_password)) {
	
	$ip = $_SERVER['REMOTE_ADDR'];
	//$ip = getIP();
//	$ip = "1.2.3.4";
	//$host = gethostbyaddr($ip);
//	$host = "abc";

if (isset($_COOKIE["livecasinouser"])) $cooks = $_COOKIE["livecasinouser"];
else $cooks="";

	$sql = sqlsrv_query($sqlconn,"select usertype,userprefix,flag from u6048user_id where userid='$entered_login'");
	$levels = sqlsrv_fetch_array($sql,SQLSRV_FETCH_ASSOC);
	$level = $levels['usertype'];
	$agen = $levels['userprefix'];
	$flag = $levels['flag'];

	$sql2 = sqlsrv_query($sqlconn,"select userprefix from u6048user_id where userid='$agen'");
	$level2 = sqlsrv_fetch_array($sql2,SQLSRV_FETCH_ASSOC);
	$master = $level2['userprefix'];

	$onlyuser = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select onlyuserlogin from a83adm_config where onlyuserlogin <> ''"));
	$te = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select ip from a83adm_ipblok where ip = '".$ip."'",$params,$options));


		if($onlyuser["onlyuserlogin"]){
			if(substr($entered_login,0,strlen($onlyuser["onlyuserlogin"])) != $onlyuser["onlyuserlogin"]){
				session_unset();
				session_destroy();
				include($cfgProgDir . "/interface.php");
				die();
			}
		} else if($te > 0){
			session_unset();
			session_destroy();
			include($cfgProgDir . "/interface.php");
			die();
		}

		$cekstatus	= sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select maint from a83adm_config"));
		if ($cekstatus["maint"] == "1"){
			session_unset();
			session_destroy();
			$message = "Sedang MAINTENENCE,Silakan kembali nanti.";
			include($cfgProgDir . "/interface.php");
			die();
		}

	

	$sql = sqlsrv_query($sqlconn,"select usertype,userprefix,flag from u6048user_id where userid = '$entered_login'");
	$levels = sqlsrv_fetch_array($sql,SQLSRV_FETCH_ASSOC);
	$level = $levels['usertype'];
	$agent = $levels["userprefix"];
	$flag = $levels["flag"];
	
	$sql2 = sqlsrv_query($sqlconn,"select userprefix from u6048user_id where userid = '$agent'");
	$masters = sqlsrv_fetch_array($sql2,SQLSRV_FETCH_ASSOC);

	$master = $masters["userprefix"];

	$sessid=base64_encode(md5(session_id()));
	//$sessid = sanitizex($sessid);

	$sql_securex = sqlsrv_query($sqlconn,"SELECT id, gametype from u6048user_active WHERE userid='$entered_login' order by gametime asc",$params,$options);

	if ((!@sqlsrv_num_rows($sql_securex)) and ($entered_login)) {
		//$hostname = gethostbyaddr($_SERVER['REMOTE_ADDR']);
		$partdomain = $_SESSION['part_domain'];
		$sessid = base64_encode(md5(session_id()));
		//$sessid = $this->sanitize($sessid);
		
		$sqlx = "insert into u6048user_active (entertime,gametime,gametype,tableid,userid,usertype,msg,IP,".SESS_FIELD.",master,agent,webid,www) values(GETDATE(),GETDATE(),'-','-','$entered_login','$level','','".$ip."','".$sessid."','$master','$agent','$partdomain','".$www."')";

		//echo "a ".$key." a";
		sqlsrv_query($sqlconn,$sqlx);
		
		// Log Login yang Lama (masa peralihan ke log login yang baru)
		include_once("../config_db2.php");
		$sqly = "insert into log_loginlog (gametype,crttime,userid,userprefix,ip,lastuser,status,www) values('-',GETDATE(),'$entered_login','$agen','$ip','$cooks','user login','".$www."')";	
		sqlsrv_query($sqlconn_db2,$sqly);
		
		// Log Login (yang baru kalau data sudah stabil log lama dihapus)
		$queryLogLogin = "INSERT INTO j2365join_playerlog (userid,userprefix,action,ip,client_ip,forward_ip,remote_ip,Info,CreatedDate) 
				 		  VALUES ('$entered_login','$agen','Login','" . getUserIP2() . "','" . getUserIP2('HTTP_CLIENT_IP') . "','" . getUserIP2('HTTP_X_FORWARDED_FOR') . "','" . getUserIP2('REMOTE_ADDR') . "', 'Login from " . $_SERVER['SERVER_NAME'] . " (Mobile Version)', GETDATE())";
		sqlsrv_query($sqlconn_db2,$queryLogLogin);

		sqlsrv_query($sqlconn,"update u6048user_id set lastlogin = GETDATE() where userid = '".$entered_login."'");
				
	}
	else {

		$act = sqlsrv_fetch_array($sql_securex,SQLSRV_FETCH_ASSOC);
		$gametype = $act[""];
		if ($gametype == "-") {

			$typex = "-";
		}
		else {
			$typex = $gametype; 
		}
					
		$sessid=base64_encode(md5(session_id()));
		//$sessid = $this->sanitize($sessid);
		
		$sqlz = "update u6048user_active set gametime=GETDATE(), gametype='".$typex."', tableid='-', ".SESS_FIELD."='".$sessid."', ip = '".$ip."', www = '".$www."' where userid='$entered_login'";
		
		
		sqlsrv_query($sqlconn,$sqlz);
				
	}	


	$waktucookiex=time()+(60*60*24*31*12);
	setcookie("livecasinouser",$entered_login,$waktucookiex);

	
}
if (!$_SESSION["pin"] || $_SESSION["pin"]==""){

	include($cfgProgDir . "/validation.php");
	
	exit();
}
//CHANGE NICKNAME
if ($flag == 0){
	include($cfgProgDir . "/change_nickname.php");
	
	exit();
}

$sessid=base64_encode(md5(session_id()));
$pgp = sqlsrv_query($sqlconn,"SELECT id from u6048user_active where userid='$login' and $cfgDbSessfield='".$sessid."'",$params,$options);
			
	//echo sqlsrv_num_rows($pgp);
	if (!@sqlsrv_num_rows($pgp)) {
		//echo "ga keluar?";

		$message = "WARNING! There are some user: \"$login\" online now<script>var timeID = setTimeout(\"top.location = './';\", 5000)</script>";
		session_unset();
		session_destroy();
		//include($cfgProgDir . "/interface.php");
		echo "<script>  window.location='".$DalamGame.$loginurl."' </script>";
		
	}

?>