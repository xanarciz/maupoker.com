<?php
$url = "http://koin.dewapoker.com/validation_authcode/";
//setting the curl parameters.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
// Following line is compulsary to add as it is:
$response = "<request>
				<authcode>bbcc7dae2110a40e83d5e8a31</authcode>
				<userid>SEON</userid>
				<minimum_grab>1000</minimum_grab>
			</request>";

curl_setopt($ch, CURLOPT_POSTFIELDS,"" . $response);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
echo $data = curl_exec($ch);
curl_close($ch);


?>