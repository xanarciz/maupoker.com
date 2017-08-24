<?php
include("config.php");
include($cfgProgDir."secure.php");

// preparing response
$res['status'] = 500;
$res['_tok'] = '';

if(! isset($_SESSION['login']) || $_SESSION['login'] == '') {
    $res['response'] = "<div class='alert alert-danger' style='margin-left: 0px;'>Login First</div>";
    exit (json_encode($res));
}


// validation is login
if (!$_SESSION["login"]){
    $res['response'] = "<div class='alert alert-danger' style='margin-left: 0px;'>Please login first</div>";
    exit (json_encode($res));
}

if (checkCaptcha('scrTok', $_POST['_tok'])){
    // create new auth token
    $_SESSION['scrTok'] = base64_encode(md5(session_id(). str_shuffle('memo'.time())));

    // preparing response
    $res['_tok'] = $_SESSION['scrTok'];

    // validation
    $subject = $_POST["title"];
	$body = $_POST["descr"];
	
	$subject = str_replace("http://", "", $subject);
	$subject = str_replace("<", "(", $subject);
	$subject = str_replace(">", ")", $subject);
	$body = str_replace("http://", "", $body);
	$body = str_replace("<", "(", $body);
	$body = str_replace(">", ")", $body);


	if (!$subject){
        $res['response'] = "<div class='alert alert-danger' style='margin-left: 0px;'>Please fill subject!</div>";
		exit (json_encode($res));
	}else if (!$body){
        $res['response'] = "<div class='alert alert-danger' style='margin-left: 0px;'>Please fill meessage!</div>";
        exit (json_encode($res));
	}else{
        // submit process
		$reqAPIMemoSend = array(
		    "auth"      => $authapi,
            "userid" 	=> $login,
			"mto" 		=> $agentwlable,
			"mfrom" 	=> $login,
			"subject" 	=> $subject,
			"content" 	=> $body,
			"type"		=> 1,
		);

		$respMemoSend = sendAPI($url_Api."/memo",$reqAPIMemoSend,'JSON','02e97eddc9524a1e');
		
		// print_r($respMemoSend);exit();
		
		// error response
		if( $respMemoSend->status != 200 ){
            $res['response'] = "<div class='alert alert-danger' style='margin-left: 0px;'>" . $respMemoSend->msg . "</div>";
            exit (json_encode($res));
		}

		// success response
        $res['status'] = 200;
        $res['response'] = "<div class='alert alert-success' style='margin-left: 0px;'>" . $respMemoSend->msg . "</div>";
        exit (json_encode($res));
	}
}

$res['response'] = "<div class='alert alert-danger' style='margin-left: 0px;'>Authentication Failed</div>";
exit (json_encode($res));

?>