<?php
//include('config.inc.php');


/****** Installation ******/

//$cfgProgDir = "";

  // location of phpSecurePages calculated from the root of the server

  // Example: if you installed phpSecurePages on http://www.mydomain.com/phpSecurePages/

  // the value would be $cfgProgDir = '/phpSecurePages/'

$cfgIndexpage = '/index.php';

  // page to go to, if login is cancelled

  // Example: if your main page is http://www.mydomain.com/index.php

  // the value would be $cfgIndexpage = '/index.php'

$admEmail = 'info@ujian.inn';

  // E-mail adres of the site administrator

  // (This is being showed to the users on an error, so you can be notified by the users)

$noDetailedMessages = false;

  // Show detailed error messages (false) or give one single message for all errors (true).

  // If set to 'false', the error messages shown to the user describe what went wrong.

  // This is more user-friendly, but less secure, because it could allow someone to probe

  // the system for existing users.

$languageFile = 'lng_english.php';        // Choose the language file

$bgImage = 'bg_lock.gif';                 // Choose the background image

$bgRotate = true;                         // Rotate the background image from list

                                          // (This overrides the $bgImage setting)





/****** Lists ******/

// List of backgrounds to rotate through

$backgrounds[] = 'bg_lock.gif';

$backgrounds[] = 'bg_gun.gif';



if(!isset($Server)){$Server = '';}
if(!isset($DbUserName)){$DbUserName = '';}
if(!isset($DbPassword)){$DbPassword = '';}
if(!isset($DatabaseName)){$DatabaseName = '';}

/****** Database ******/

$useDatabase = true;                     // choose between using a database or data as input



/* this data is necessary if a database is used */

$cfgServerHost = $Server;             // MySQL hostname

$cfgServerPort = '3306';                      // MySQL port - leave blank for default port

//global $DbName, $DbUserName, $DbPassword,$sqlconn;
$cfgServerUser = $DbUserName;                  // MySQL user

$cfgServerPassword = $DbPassword;                  // MySQL password



$cfgDbDatabase = $DatabaseName;        // MySQL database name containing phpSecurePages table

$cfgDbTableUsers = 'u6048user_id';         // MySQL table name containing phpSecurePages user fields

$cfgDbLoginfield = 'userid';                // MySQL field name containing login word

$cfgDbPasswordfield = 'userpass';         // MySQL field name containing password

$cfgDbUserLevelfield = 'usertype';       // MySQL field name containing user level

$cfgDbSessfield = 'sessid';		
$cfgDbStatfield = 'status';	

  // Choose a number which represents the category of this users authorization level.

  // Leave empty if authorization levels are not used.

  // See readme.txt for more info.

$cfgDbUserIDfield = 'user_id';        // MySQL field name containing user identification

  // enter a distinct ID if you want to be able to identify the current user

  // Leave empty if no ID is necessary.

  // See readme.txt for more info.





/****** Database - PHP3 ******/

/* information below is only necessary for servers with PHP3 */

$cfgDbTableSessions = 'phpSP_sessions';

  // MySQL table name containing phpSecurePages sessions fields

$cfgDbTableSessionVars = 'phpSP_sessionVars';

  // MySQL table name containing phpSecurePages session variables fields





/****** Data ******/

$useData = false;                          // choose between using a database or data as input



/* this data is necessary if no database is used */

$cfgLogin[1] = '';                        // login word

$cfgPassword[1] = '';                     // password

$cfgUserLevel[1] = '';                    // user level

  // Choose a number which represents the category of this users authorization level.

  // Leave empty if authorization levels are not used.

  // See readme.txt for more info.

$cfgUserID[1] = '';                       // user identification

  // enter a distinct ID if you want to be able to identify the current user

  // Leave empty if no ID is necessary.

  // See readme.txt for more info.



$cfgLogin[2] = '';

$cfgPassword[2] = '';

$cfgUserLevel[2] = '';

$cfgUserID[2] = '';



$cfgLogin[3] = '';

$cfgPassword[3] = '';

$cfgUserLevel[3] = '';

$cfgUserID[3] = '';





/**************************************************************/

/*             End of phpSecurePages Configuration            */

/**************************************************************/





// getting other login variables

$cfgHtmlDir = "http://" . getenv("HTTP_HOST") . $cfgProgDir;
//$cfgProgDir = getenv("DOCUMENT_ROOT") . $cfgProgDir;

if (isset($message)) $messageOld = $message;

$message = false;




// Create a constant that can be checked inside the files to be included.
// This gives an indication if secure.php has been loaded correctly.
define("LOADED_PROPERLY", true);


//include($cfgProgDir."lng_english.php");
//include($cfgProgDir."session.php");


// include functions and variables

function admEmail() {

	// create administrators email link

	global $admEmail;

	return("<A HREF='mailto:$admEmail'>$admEmail</A>");

}

include($cfgSecDir."lng_english.php");
include($cfgSecDir."session.php");





// choose between login or logout

if (isset($logout)) {
	// logout
	
	include($cfgSecDir."logout.php");
} else {

		// loading login check
	require($cfgSecDir."checklogin.php");
}

?>