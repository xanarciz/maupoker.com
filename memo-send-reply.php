<?php
$page ="memo";
include("config.php");
include($cfgSecDir."secure.php");

// preparing result
$res['status'] = 500;
$res['_tok'] = '';

if(! isset($_SESSION['login']) || $_SESSION['login'] == '') {
    $res['response'] = "<div class='alert alert-danger' style='margin-left: 0px;'>Login First</div>";
    exit (json_encode($res));
}

if (!$_SESSION["login"]){
    $res['response'] = "<div class='alert alert-danger' style='margin-left: 0px;'>Please login first</div>";
    exit(json_encode($res));
}


if (checkCaptcha('scrTok', $_POST['_tok'])){
    // create new auth token
    $_SESSION['scrTok'] = base64_encode(md5(session_id(). str_shuffle('memo'.time())));

    // preparing result
    $res['_tok'] = $_SESSION['scrTok'];

    $id = $_POST["memtok"];
    $body = $_POST["descr"];

    // validation
	if ( !$_POST["memtok"] ){
        $res['response'] = "<div class='alert alert-danger' style='margin-left: 0px;'>Reply Memo Failed</div>";
        exit(json_encode($res));
	}
	if (!$body){
        $res['response'] = "<div class='alert alert-danger' style='margin-left: 0px;'>Please fill meessage!</div>";
        exit(json_encode($res));
	}else{
	    // subnmit process
		$reqAPIMemoSend = array(
		    "auth"      => $authapi,
			"agent" 	=> $agentwlable,
			"userid" 	=> $login,
			"id" 		=> $id,
			"content" 	=> $body,
			"type"		=> 6,
		);

		$respMemoSend = sendAPI($url_Api."/memo",$reqAPIMemoSend,'JSON','02e97eddc9524a1e');
		// error reply
		if( $respMemoSend->status != 200 ){
            $res['response'] = "<div class='alert alert-danger' style='margin-left: 0px;'>$respMemoSend->msg</div>";
            exit(json_encode($res));
		}

		// success reply
        $res['status'] = 200;
        $res['response'] = "<div class='alert alert-success' style='margin-left: 0px;'>$respMemoSend->msg</div>";
        exit(json_encode($res));
	}
}

$res['response'] = "<div class='alert alert-danger' style='margin-left: 0px;'>Authentication Failed</div>";
exit(json_encode($res));
?>