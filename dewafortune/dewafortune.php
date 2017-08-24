<?PHP
function getTicket()
{
	$Coupon = 0;
	$userid = $_SESSION["login"];
	$acc_token = "9a7e8111d09b65e038de0444e96b5a8c";
    $request = array(
        "userid" => $userid,
        "acc_token" => $acc_token,
    );

    $options = array(
        'CURLOPT_MAXREDIRS'     => 10,
        'CURLOPT_TIMEOUT'       => 30,
        'CURLOPT_HTTP_VERSION'  => 'CURL_HTTP_VERSION_1_1',
        'CURLOPT_CUSTOMREQUEST' => "POST",
    );
    $response = sendAPI('http://dewafortune.com/auth/coupon_checker.php', $request, 'XML', '', $options);
	$res = json_decode(json_encode($response), true);
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
		echo "<script>document.location.href='dewifortune.php?data=".$data."&codeAccess=".$codeAccess."'</script>";
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