<?php
ini_set('display_errors', 1);
error_reporting(E_ALL ^ E_NOTICE);
?><html>
<head>
<title>What is my IP address and Country</title>
</head>
<body>
<?
if (getenv(HTTP_X_FORWARDED_FOR)) {
$pipaddress = getenv(HTTP_X_FORWARDED_FOR);
$ipaddress = getenv(REMOTE_ADDR);
echo "Your Proxy IP address is : ".$pipaddress. " (via $ipaddress) " ;
} else {
$ipaddress = getenv(REMOTE_ADDR);
echo "My IP address is : $ipaddress";
}
$country = getenv(GEOIP_COUNTRY_CODE);
echo "<br />My Country : $country";
?>
</body>
</html>
