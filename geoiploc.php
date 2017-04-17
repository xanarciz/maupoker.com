<?PHP
function getUserIPx(){
	$client  = @$_SERVER['HTTP_CLIENT_IP'];
	$forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
	$remote  = $_SERVER['REMOTE_ADDR'];

	if(filter_var($client, FILTER_VALIDATE_IP)){
		$ip = $client;
	}elseif(filter_var($forward, FILTER_VALIDATE_IP)){
		$ip = $forward;
	}else{
		$ip = $remote;
	}

	return $ip;
}

$ip = getUserIPx();
$whitelist_ip = array('122.49.219.114','114.108.245.11','103.10.197.2','146.88.66.250','43.226.4.194','180.232.84.234','203.82.38.210','180.210.202.7','203.177.143.251');

if(!in_array($ip, $whitelist_ip)){
	$protected_country = array('SG','PH');	
}else{
	$protected_country = array();
}

$country_code = geoip_country_code_by_name($ip);

if(in_array($country_code, $protected_country)){
	if(!in_array($country_code, $whitelist_ip)){
		echo "<script>window.location.href='/restricted'</script>";
	}
}
?>