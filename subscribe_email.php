<?php
function curl($url = '', $postdata = ''){

          $ch = curl_init();
          curl_setopt($ch, CURLOPT_URL, $url);

       
          curl_setopt($ch, CURLOPT_POSTFIELDS, $postdata);
          curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
          curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
          $curl_data = curl_exec($ch);

          curl_close($ch);
       
          return json_decode($curl_data);
}

function subscribe(){

	include("config.php");
	$url = 'http://email.6mbr.com/api/subscribe';
	$data = array(
				'api_key' => 'ASDFCAZ123FCRFFGVHGVUSVAH',
				'web_id'=> 'domino88321',
				'popup_id' => '1405531097',
				'userid' => $_SESSION['login'],
				'email' => $_POST['email'],
				);
	$response = curl($url, $data);
	if($response->status != 'error'){
		$sql = sqlsrv_query($sqlconn,"update u6048user_id set email='".$_POST['email']."' where userid ='".$_SESSION['login']."' ");
		sqlsrv_query($sqlconn,"insert into g846log_player (userid, username, ket, waktu) values ('".$_SESSION['login']."', '-', 'Update Email to ".$_POST['email']."', GETDATE())");
	}
	$result = array(
			'message' => $response->message,
			'status'=> $response->status
			);
	return $result;

}

session_start();
$result = subscribe();

echo json_encode($result);

 ?>