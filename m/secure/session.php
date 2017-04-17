<?php
/* ------ MySQL session ------
a MySQL based session management and variable registration system for PHP3
joshua macadam, 2000
josh@onestop.net

NOTE:
  To enable automatic session_start_php3, seek to the end of this file and
  follow the instructions. (line 294)
*/

if (phpversion() < 4) {
	// phpversion = 3

	define("MAX_UNAUTH_IDLE", 1440);  // How long may an unauthorized user be idle
												// (just to clean up out session table!)
	define("MAX_AUTH_IDLE", 720);     // If you are logged in, how long for?

	if ( empty($cfgServerPort) ) {
		mssql_connect($cfgServerHost, $cfgServerUser, $cfgServerPassword)
		or die($strNoConnection);
	} else {
		mssql_connect($cfgServerHost . ":" . $cfgServerPort, $cfgServerUser, $cfgServerPassword)
		or die($strNoConnection);
	}

	if ($db) $dbOld = $db;
	$db = $cfgDbDatabase;
	$tableSessions = $cfgDbTableSessions;
	$tableSessionVars = $cfgDbTableSessionVars;
	$cookieName = "php3SessionID";
	$cookieName = sanitizex($cookieName);
	$php3SessionID = $$cookieName;



/*function sanitizex($var, $quotes = true) {
        if (is_array($var)) {   //run each array item through this function (by reference)        
            foreach ($var as &$val) {
                $val = sanitizex($val);
            }
        }
        else if (is_string($var)) { //clean strings
            $var = addslashes($var);
			 $var = preg_replace("/[\\/]+/","/",$var);
            if ($quotes) {
                //$var = "'". $var ."'";
            }
        }
        else if (is_null($var)) {   //convert null variables to SQL NULL
            $var = "NULL";
        }
        else if (is_bool($var)) {   //convert boolean variables to binary boolean
            $var = ($var) ? 1 : 0;
        }

        return $var;
    }
*/
	function session_destroy_php3() {
		global $mysqli2,$db, $tableSessions, $tableSessionVars, $php3SessionID, $strNoDatabase, $cookieName;
		// $debug=1;
	$tableSessions = sanitizex($tableSessions);
	$php3SessionID = sanitizex($php3SessionID);
	$tableSessionVars = sanitizex($tableSessionVars);
	$cookieName = sanitizex($cookieName);
		// delete variables associated with the sessions we're about to DELETE
		$Query = "DELETE FROM $tableSessionVars WHERE session='$php3SessionID'";
		mssql_query($Query) or die($strNoDatabase);
		//mysql($db, $Query) or die($strNoDatabase);
		if($debug) printf("Query=%s .<br>", $Query);

		// kill ID
		$Query = "DELETE FROM $tableSessions WHERE id='$php3SessionID'";
		mssql_query($Query) or die($strNoDatabase);
		//mysql($db, $Query) or die($strNoDatabase);
		if($debug) printf("Query=%s .<br>", $Query);

		// remove cookie
	   setcookie($cookieName, "", time()-1);
		
		// no pageloads from cache or memory
		header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");             		// Date in the past
		header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");		// always modified
		header("Cache-Control: no-cache, must-revalidate");           		// HTTP/1.1
		header("Pragma: no-cache");                                   		// HTTP/1.0
	}


	function session_killold() {
	 global $mysqli2, $db, $tableSessions, $tableSessionVars, $strNoDatabase;
	$tableSessions = sanitizex($tableSessions);
	$tableSessionVars = sanitizex($tableSessionVars);

	 // $debug=1;

	// figure out who all we're about to delete for being too old!
	 $Query = "SELECT vars.id FROM $tableSessions as sess, $tableSessionVars as vars
	           WHERE sess.id=vars.session AND LastAction < '";
	 $Query .= date("Y-m-d H:i:s", time()-MAX_UNAUTH_IDLE);
	 $Query .= "'";
	 $result=mssql_query($Query) or die($strNoDatabase);
	 //$result=mysql($db, $Query) or die($strNoDatabase);
	 //echo mysqli_error();

	  if($debug) printf("Query=%s .<br>",$Query);

	// delete variables associated with the sessions we're about to DELETE
	  while( $res = mssql_fetch_row($result) ) {
	    $Query = "DELETE FROM $tableSessionVars WHERE id=$res[0]";
	    mssql_query($Query) or die($strNoDatabase);
		//mysql($db, $Query) or die($strNoDatabase);
	  }

	// kill IDs after 12 hours for the sake of resources!
	 $Query = "DELETE FROM $tableSessions WHERE LastAction < '";
	 $Query .= date("Y-m-d H:i:s", time()-MAX_UNAUTH_IDLE);
	 $Query .= "'";
	 mssql_query($Query) or die($strNoDatabase);
	 //mysql($db, $Query) or die($strNoDatabase);

	 if($debug) printf("Query=%s .<br>", $Query);

	// log users out if idle for 5 minutes
	// time problems resolved but
	// was noting ocassionally: 5 increments per second?

	 $Query = "UPDATE $tableSessions SET userID=NULL WHERE LastAction < '";
	 $Query .= date("Y-m-d H:i:s", time()-MAX_AUTH_IDLE);
	 $Query .= "'";
	 mssql_query($Query) or die($strNoDatabase);
	 //mysql($db, $Query) or die($strNoDatabase);

	 if($debug) printf("Query=%s .<br>", $Query);
	 if($debug) printf("Current Time=%s .<br>", date("Y-m-d H:i:s"));
	}


	function session_touch($sess) {
	  global $mysqli2,$db, $tableSessions, $strNoDatabase;
	$tableSessions = sanitizex($tableSessions);
	$sess = sanitizex($sess);
	  // $debug=1;

	  $Query="UPDATE $tableSessions SET LastAction=now() WHERE id='$sess'";
	  mssql_query($Query) or die($strNoDatabase);
	  //mysql($db, $Query) or die($strNoDatabase);

	  // if($debug) printf("Query=%s .<br>", $Query);
	}


	function session_valid_session($sess) {
	  global $mysqli2,$db, $tableSessions, $strNoDatabase;
	$tableSessions = sanitizex($tableSessions);
	$sess = sanitizex($sess);
	  // $debug=1;

	  session_killold();

	  if($debug) printf("VALID: Recieved session=%s .<br>", $sess);
	  if(!$sess) return 0;

	  $Query = "SELECT * FROM $tableSessions WHERE id='$sess'";
	  if($debug) printf("Query=%s .(validsess)<br>", $Query);

	  $result = mssql_query($Query) or die($strNoDatabase);
	  //$result = mysql($db, $Query) or die($strNoDatabase);
	  $status = mssql_fetch_row($result);
	  return $status;
	}


	function session_get_var($varname) {
	  global $mysqli2,$php3SessionID, $db, $tableSessionVars, $strNoDatabase;
	$tableSessions = sanitizex($tableSessions);
	$php3SessionID = sanitizex($php3SessionID);
	$tableSessionVars = sanitizex($tableSessionVars);
	$varname = sanitizex($varname);
	  $debug=1;

	  $Query = "SELECT * FROM $tableSessionVars WHERE session='$php3SessionID' AND name='$varname'";
	  if($debug) printf("Query=%s .(reg var)<br>", $Query);
	  $result = mssql_query($Query) or die($strNoDatabase);
	  //$result = mysql($db, $Query) or die($strNoDatabase);
	  if(!$result) return 0;
	  $obj = mssql_fetch_object($result);

	  if(!$obj->intval) return $obj->strval;
	  else return $obj->intval;
	}


	function session_isession_registered($varname) {
	  global $mysqli2,$php3SessionID, $db, $tableSessionVars, $strNoDatabase;
	$php3SessionID = sanitizex($php3SessionID);
	$tableSessionVars = sanitizex($tableSessionVars);
	$varname = sanitizex($varname);
	  // $debug=1;

	  $Query = "SELECT * FROM $tableSessionVars WHERE session='$php3SessionID' AND name='$varname'";
	  if($debug) printf("Query=%s .(is regged)<br>", $Query);
	  $result = mssql_query($Query) or die($strNoDatabase);
	  //$result = mysql($db, $Query) or die($strNoDatabase);
	  $rows = mssql_num_rows($result);
	  return $rows;
	}


	function session_register_php3($varname, $type, $value) {
	  global $mysqli2,$php3SessionID, $db, $tableSessionVars, $strNoDatabase;
	$php3SessionID = sanitizex($php3SessionID);
	$tableSessionVars = sanitizex($tableSessionVars);
	$varname = sanitizex($varname);
	  // $debug=1;

	  $Query = "SELECT name FROM $tableSessionVars WHERE session='$php3SessionID' and name='$varname'";
	  if($debug) printf("Query=%s .(is regged)<br>",$Query);
	  $result = mssql_query($Query) or die($strNoDatabase);
	  //$result = mysql($db, $Query) or die($strNoDatabase);
	  $rows = mssql_num_rows($result);

	  switch($type) {
	    case "INT":
	      $intval = $value;
	      $strval = "NULL";
	    break;
	    case "STRING":
	      $intval = "NULL";
	      $strval = $value;
	    break;
	  }

	  if($rows) $Query = "UPDATE $tableSessionVars SET intval=$intval, strval='$strval'
	                      WHERE session='$php3SessionID' AND name='$varname'";
	  else      $Query = "INSERT INTO $tableSessionVars (name, session, intval, strval)
	                      VALUES ('$varname', '$php3SessionID', $intval, '$strval')";

	     $result = mssql_query($Query) or die($strNoDatabase);
		 //$result = mysql($db, $Query);
	     if($debug) printf("Query=%s .(set var)<br>", $Query);
	}


	// lookey lookey! persistant DATA!!!!!
	function session_loadvars($php3SessionID) {
	  global $mysqli2,$db, $tableSessionVars, $strNoDatabase;
	$tableSessionVars = sanitizex($tableSessionVars);
	$php3SessionID = sanitizex($php3SessionID);
	$Query = "SELECT * FROM $tableSessionVars WHERE session='$php3SessionID'";
	  $result = mssql_query($Query) or die($strNoDatabase);
	  //$result = mysql($db, $Query) or die($strNoDatabase);
	  // echo "q = $Query";
	  if($result) {
	    while($data = mssql_fetch_object($result)) {
	      // echo "load=$data->name<br>";
	      if($data->intval)
	        $GLOBALS[$data->name] = $data->intval;
	      else $GLOBALS[$data->name] = $data->strval;
	}  }  }


	function session_start_php3() {
	  // $debug=1;
	  global $mysqli2,$php3SessionID, $auctionref;
	$php3SessionID = sanitizex($php3SessionID);
	$auctionref = sanitizex($auctionref);
	  if($debug) printf("Recieved session=%s<br>", $php3SessionID);

	  if(!session_valid_session($php3SessionID)) {
	    $php3SessionID = session_begin_session($auctionref);
	  } else {
	    session_loadvars($php3SessionID);
	  }
	  session_touch($php3SessionID);
	}


	function session_login($userID) {
	  // $debug=1;
	  global $mysqli2,$php3SessionID, $db, $tableSessions, $strNoDatabase;
	$php3SessionID = sanitizex($php3SessionID);
	$tableSessions = sanitizex($tableSessions);
	$userID = sanitizex($userID);
	  session_start_php3();

	  $Query = "UPDATE $tableSessions SET userID = '$userID' WHERE id='$php3SessionID'";
	  mssql_query($Query) or die($strNoDatabase);
	  //mysql($db, $Query) or die($strNoDatabase);

	  if($debug) printf("Query=%s .(session_login)<br>", $Query);
	}


	function session_gencode() {
	  global $mysqli2;
	  $php3SessionID_code_length=13;
	  session_killold();

	  srand(time());
	  $Puddle = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	  for($index = 0; $index < $php3SessionID_code_length; $index++) {
	    $sid .= substr($Puddle, (rand()%(strlen($Puddle))), 1);
	  }

	  // If by some miracle this id exists, return 0. It will not pass
	  // when it is checked next.
	  if(session_valid_session($sid)) $sid = "INVALID";
	  return $sid;
	}


	function session_begin_session() {
	global $mysqli2,$REMOTE_ADDR, $db, $tableSessions, $strNoDatabase, $cookieName;

	// !!!Displaying anything before outputing setcookie will cause the
	// header generation (and thus the cookie bake) to fail!!!
	  // $debug=1;

	  $sesscode = session_gencode();
	  if($debug) printf("Codemade=%s<br>", $sesscode);

	  $Query = "INSERT INTO $tableSessions (id, LastAction, ip)
	            VALUES ('$sesscode', now(), '$REMOTE_ADDR')";
	  if($debug) printf("Query=%s .<br>", $Query);
	  mssql_query($Query) or die($strNoDatabase);
	  //mysql($db, $Query) or die($strNoDatabase);

	  setcookie($cookieName, $sesscode);

	  // no pageloads from cache or memory
	  header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");             		// Date in the past
	  header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");		// always modified
	  header("Cache-Control: no-cache, must-revalidate");           		// HTTP/1.1
	  header("Pragma: no-cache");                                   		// HTTP/1.0

	  return $sesscode;
	}


	function session_return_var($variable) {
	  global $mysqli2,$php3SessionID, $db, $tableSessions, $strNoDatabase;
	$php3SessionID = sanitizex($php3SessionID);
	$variable = sanitizex($variable);
	$Query = "SELECT $variable FROM $tableSessions WHERE id='$php3SessionID'";
	  if($debug) printf("Query=%s .<br>", $Query);
	  $result = mssql_query($Query) or die($strNoDatabase);
	  //$result = mysql($db, $Query) or die($strNoDatabase);
	  $status = mssql_fetch_row($result);
	  return $status[0];
	}


	// Checks to see if user is logged in and if so returns userID
	// -----------------------------------------------------------
	function session_logged_in() {
	  global $mysqli2,$php3SessionID, $db, $tableSessions, $strNoDatabase;
	$php3SessionID = sanitizex($php3SessionID);
	  session_killold();
	  session_start_php3();

	  $Query = "SELECT userID FROM $tableSessions WHERE id='$php3SessionID'";
	  $result = mssql_query($Query) or die($strNoDatabase);
	  //$result = mysql($db, $Query) or die($strNoDatabase);
	  $status = mssql_fetch_row($result);
	  return $status[0];
	}

	// AUTOMATIC SESSION DEMAND. If you do not wish to have to call session_start_php3
	// in every script, uncomment the following line:
	// session_start_php3();

} // (phpversion() < 4
?>