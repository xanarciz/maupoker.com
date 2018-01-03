<?php
$url = "https://www.domino88.asia/validation_authcode/index.php";
//setting the curl parameters.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
// Following line is compulsary to add as it is:
$response = "<request>
				<authcode>f64071461a68450a53e16552f</authcode>
				<userid>QQDM88A</userid>
				<get_authcode>true</get_authcode>
			</request>";

curl_setopt($ch, CURLOPT_POSTFIELDS,"" . $response);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
echo $data = curl_exec($ch);
curl_close($ch);


?>