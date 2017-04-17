<?php
$Server_db2 = "103.249.162.142";
$DbUserName_db2 = "super_dewa";
$DbUserPass_db2 = "adm!@#123";
$DbName_db2 = "cas2_db";
global $sqlconn_db2;
$connectionInfo_db2 = array( "UID"=>$DbUserName_db2,
                         "PWD"=>$DbUserPass_db2,
						 "CharacterSet" => "UTF-8",
                         "Database"=>$DbName_db2);
$sqlconn_db2 = sqlsrv_connect( $Server_db2, $connectionInfo_db2);
if(!$sqlconn_db2){
	echo "<center><table border=1 bgcolor=#FFFF00><tr><td><CENTER><B>Information</B></CENTER></td></tr><tr><td>Error Connected to server...<br><br>(<I>Sorry for inconvinience case</I>)</td></tr></table></center>";
	die();
}
?>
