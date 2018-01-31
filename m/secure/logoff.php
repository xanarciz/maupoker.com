<?PHP 
require("config.inc.php");

$logout = true; 
include($cfgProgDir . "secure.php");
include("secure.php");
 ?>

<HTML><HEAD>
<TITLE>Index</TITLE>
</HEAD>

<BODY>
<FONT Face ="verdana" SIZE="2" COLOR="#FF0000">You was logout from <?=$SITENAME?>!</FONT>

<FONT SIZE="2" Face="verdana">Login Again? <a href="index.php">Just click here</a></FONT>
</BODY></HTML>
