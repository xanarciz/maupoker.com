<?PHP
include_once("config.php");

$whitelist_ip = array('114.108.245.11','103.10.197.2','146.88.66.250','43.226.4.194','180.232.84.234','203.82.38.210','180.210.202.7','203.177.143.251','130.105.191.211','130.105.182.16');

if(!in_array($ip, $whitelist_ip)){
	$protected_country = array('SG','PH');	
}else{
	$protected_country = array();
}

$country_code = geoip_country_code_by_name($ip);
$country_name = geoip_country_name_by_name($ip);
if(in_array($country_code, $protected_country)){

	if(!in_array($country_code, $whitelist_ip)){
		$client  = getUserIP2('HTTP_CLIENT_IP');
		$forward = getUserIP2('HTTP_X_FORWARDED_FOR');
		$remote  = getUserIP2('REMOTE_ADDR');
		$ip = getUserIP2();
		
		$reqAPIRest = array(
			"auth"    			=> $authapi,
			"userid"  			=> $ip,
			"userPrefix"  	 	=> $agentwlable,
			"ip"   				=> $ip,
			"client_ip"   		=> $client,
			"forward_ip"   		=> $forward,
			"remote_ip"   		=> $remote,
			"Info" 				=> $country_name . " (" . $country_code . ") in " . $_SERVER['SERVER_NAME']
		);
		
		$response = sendAPI($url_Api."/restricted",$reqAPIRest,'JSON','02e97eddc9524a1e');

		echo "<script>window.location.href='/restricted'</script>asdf";
	}
}
?>