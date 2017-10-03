<?php

$serverName = "103.5.45.122,2433";
$connectionOptions = array(
    "Database" => "cas_db",
    "Uid" => "adm_multiplayer",
    "PWD" => "8gn0st*mi303"
);
//Establishes the connection
$conn = sqlsrv_connect($serverName, $connectionOptions);
if($conn)
    echo "Connected!"
?>
