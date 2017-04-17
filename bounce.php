
<?php
$ckname = 'aff';
if (!isset($_REQUEST['promo'])) {
		setcookie($ckname, '',time()-300, '/', $_SERVER['SERVER_NAME']);
        // echo 'Required parameters token and path were not found. '.$_COOKIE['aff'].' not promo <br>';
        // exit;
		header('Location: http://'.$_SERVER['SERVER_NAME'].'/register.php');
}else{
	// setcookie($ckname, '',time()-300, '/', 'shenpoker.com');
	setcookie($ckname, $_REQUEST['promo'], time()+600, '/', $_SERVER['SERVER_NAME']);
	header('Location: http://'.$_SERVER['SERVER_NAME'].'/register.php');
	// echo $_COOKIE['aff'].' cookie <br>';
	// echo $_REQUEST['promo'].' enter parameter';
}

// echo  date('d-m-y h:i:s',time()+7200);
?>