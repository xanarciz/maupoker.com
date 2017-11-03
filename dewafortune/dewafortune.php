<?PHP
function getTicket()
{
	$Coupon = 0;
	$userid = $_SESSION["login"];
	$acc_token = "9a7e8111d09b65e038de0444e96b5a8c";
	$input_xml = "
	<request>
		<userid>".$userid."</userid>
		<acc_token>".$acc_token."</acc_token>
	</request>
	";


	$curl = curl_init();

	curl_setopt_array($curl, array(
		CURLOPT_URL => "https://dewafortune.com/auth/coupon_checker.php",
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_ENCODING => "",
		CURLOPT_MAXREDIRS => 10,
		CURLOPT_TIMEOUT => 5,
		CURLOPT_SSL_VERIFYHOST => 0,
		CURLOPT_SSL_VERIFYPEER => 0,
		CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		CURLOPT_CUSTOMREQUEST => "POST",
		CURLOPT_POSTFIELDS => $input_xml,
		CURLOPT_HTTPHEADER => array(
			"cache-control: no-cache",
			"content-type: text/xml"
			),
		));

	$response = curl_exec($curl);
	$err = curl_error($curl);

	curl_close($curl);

	// if ($err) {
	// 	echo "cURL Error #:" . $err;
	// } else {
	// 	echo $response;
	// }

	$res = json_decode(($response), true);
	$Coupon = $res['Coupon'];

	return $Coupon;

}

function val_access()
{
	if($_GET['data'])
	{
		$param = rawurldecode(base64_decode($_GET['p']));
		$resparam = explode(",", $param);
		$data = rawurlencode(base64_encode("https://dewafortune.com/auth/login_defor.php?userid=".$resparam[0]."&sessid=".$resparam[1]."&access_token=9a7e8111d09b65e038de0444e96b5a8c"));
		$codeAccess = $_GET['data'];
		// echo $resparam[0], $resparam[1];
		// echo "<script>document.location.href='dewifortune.php?data=".$data."&codeAccess=".$codeAccess."'</script>";
		header("location:http://".$_SERVER[HTTP_HOST]."/dewafortune/dewifortune.php?data=".$data."&codeAccess=".$codeAccess."");
	}

}

function popup_direct()
{
	echo "<script>window.location.href='".rawurldecode(base64_decode($_GET['codeAccess']))."'</script>";
}

if(function_exists($_GET['f'])) {
   $_GET['f']();
}
?>