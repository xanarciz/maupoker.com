<?php

if ($_POST["logout"]){
	session_destroy();
	echo "<script>window.location='../index.php'</script>"; 
}

$pin_pembuka=$pin;
$iplist = getUserIP2().','.getUserIP2('HTTP_CLIENT_IP').','.getUserIP2('HTTP_X_FORWARDED_FOR').','.getUserIP2('REMOTE_ADDR');

if ($_POST["input_pin"]){
    // validasi pin
    $reqAPIPin = array(
        "auth"   	=> $authapi,
        "domain" 	=> $nonWWW,
        "ip"		=> $iplist,
        "device"	=> $device,
        "type"		=> 6,
        "userid"	=> $login,
        "pin"       => $_POST["pin"],
		"webid"     => $subwebid,
    );

    $respPin = sendAPI($url_Api."/account",$reqAPIPin,'JSON','02e97eddc9524a1e');

    if($respPin->status == 200){
        $_SESSION["pin"] = $pin_pembuka;
        if($vip ==2) { echo "<script>document.location='../invitation.php'</script>"; }
        else { echo "<script>window.location='../index.php'</script>"; }
    }else{
        if($respPin->actstat == 6){
            echo "<script>window.location='../logout.php'</script>";
        }else{
            $error = $respPin->msg;
        }
    }
}else if ($_POST["submit_data"]){
    $question=$_POST["question"];
    $pin=$_POST["pin"];

    // update pin
    $reqAPIPin = array(
        "auth"   	=> $authapi,
        "domain" 	=> $nonWWW,
        "ip"		=> $iplist,
        "device"	=> 2,
        "type"		=> 5,
        "userid"	=> $login,
        "pin"       => $_POST["pin"],
    );
    $respPin = sendAPI($url_Api."/account",$reqAPIPin,'JSON','02e97eddc9524a1e');
    // print_r($respPin);exit();

    if($respPin->status == 500){
        // $error="Pin harus 6 digit angka.";
        $error = $respPin->msg;
    }else{
        echo "<script>
		alert('Sukses untuk setting data pribadi anda');
		window.location='../index.php';</script>";
    }
}

?>


<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

	<!-- Favicon -->
	<link rel="shortcut icon" href="img/favicon.ico">
	<link rel="apple-touch-icon-precomposed" href="img/apple-touch-icon-precomposed.png">

	<title>WELCOME</title>
	<link rel="stylesheet" href="css/validation.css?id=<?PHP echo time(); ?>">
	<link href="../../assets/js/jquery.keypad/jquery.keypad.css" rel="stylesheet">
	<link rel="stylesheet" href="../../assets/css/font-awesome.min.css">
	
	<script src="../../assets/js/jquery_min.js"></script>
	<script src="../../assets/js/jquery.keypad/jquery.plugin.js"></script>
	<script src="../../assets/js/jquery.keypad/jquery.keypad.js"></script>
</head>

<body>
	<div class="container">
		<div class="sub-container">
			<center>
				<div class="main">
					<div class="logo" style="margin: 20px 0;"><img src="../../assets/img/io/logo.png" width="175px"></div>
					<div class="header">
						<h1 class="title" style="color:#fff;">Selamat datang, <?php echo $login;?></h1>
					</div>
					<div class="content">
						<div class="sub-content">
							<table >
								<tr>
									<td colspan=2 align="center">
										
										<?php 
											if ($pin_pembuka){ 
												if($status_bank == '1') {
										?>
													<style>													
														.valpin, .openpin{
															display: none;
														}
													</style>
													
													<div class="valbank">
														<h1>VALIDASI KEAMANAN</h1>
														<p style="font-size:13px;color:#fff;">Bertujuan untuk meningkatkan keamanan dan kenyamanan bisnis Anda.</p>
														<div class="user-box">
															<p style="color:#000">Harap <b>periksa data pribadi</b> terlebih dahulu sebelum memasukan PIN :</p>
															<div class="user-detail">
																<div class="row"></div>
																
																<div class="row">
																	<label class="lbl">User name </label> 
																	<input type="text" class="frm-input" value="<?PHP echo $user_login; ?>" readonly>
																</div>
																<div class="row">
																	<label class="lbl">Nick name </label> 
																	<input type="text" class="frm-input" value="<?PHP echo $login; ?>" readonly>
																</div>
																<div class="row">
																	<label class="lbl">Bank Account </label> 
																	<input type="text" class="frm-input" value="<?PHP echo $bankaccnodis; ?>" readonly>
																</div>
																
																<div class="row"></div>
															</div>
														</div>
													</div>
													
										<?PHP } ?>
										
											<div class="valpin">
												<h1>VALIDASI KEAMANAN</h1>
												<p style="font-size:13px;color:#fff!important;">Bertujuan untuk meningkatkan keamanan dan kenyamanan bisnis Anda.</p>
												<div class="newval-box">
													<div>
														<img src="../../assets/img/io/inputpinlimit.png">
														<p>User ID akan di blokir, jika mengalami kesalahan 5X.</p>
													</div>
													<div>
														<img src="../../assets/img/io/csval.png">
														<p>Jika Anda lupa PIN, silahkan klik hubungi operator kami. </p>
													</div>
													<div>
														<img src="../../assets/img/io/randompin.png" style="margin-left: 20px;">
														<p>Tombol dibuat secara acak, mohon perhatikan angka yang Anda input.</p>
													</div>
												</div>
											</div>
										
											<?php
												if ($error){
													echo "<div class='error'><b>$error</b></div>";
												}
											?>

										<?php }else{ ?>

											<h1>MASUKAN 6 DIGIT PIN BARU ANDA</h1>
											<p class="white">Sistem ini untuk meningkatkan <b>KEAMANAN</b> dan <b>KENYAMANAN</b> bermain anda.</p>

											<?php
												if ($error){
													echo "<div class='error'><b>$error</b></div>";
												}
											?>

											
											<ul>
												<li><b>TOMBOL DIBAWAH ADALAH ACAK, HARAP PERHATIKAN ANGKA YANG ANDA INPUT</b></li>
												<li><b>PIN INI AKAN DIGUNAKAN SETIAP ANDA MASUK KEDALAM GAME</b></li>
											</ul>
											
										<?php } ?>
									
								</td>
							</tr>
						</table>
					</div>
					
					<div class="pin-container">
						<?php if ($pin_pembuka){ 
								if($bankaccno != null && $bankname != null && $bankaccname != null) {
						?>
								
									<div class="btnbank">
										<div class="caution"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i> CEK & PASTIKAN DATA ANDA BENAR! <i class="fa fa-exclamation-triangle" aria-hidden="true"></i></div>
										<form method="post">
											<div class="row">
												<button name="next" class="btn-red next">Lanjutkan</button> &nbsp;
												<input type="submit" name="logout" value="Salah" class="btn-gray btn-wrong"><i class="fa fa-minus-circle wrong" aria-hidden="true"></i>
											</div>
											<!-- <div class="note">
												<i class="fa fa-caret-left" aria-hidden="true"></i> 
												<p>Klik jIka data tidak sesuai, <br> dan Anda akan di arahkan <br> ke Operator kami.</p>
											</div> -->
										</form>
									</div>
								
						<?PHP 	} ?>
							
							<div class="openpin">
								<h4>Masukan 6 DIGIT PIN Anda</h4>
								<form method="post">
									<div class="row"><input type="password" name="pin" id="pin" class="pin" maxlength="6" autocomplete="off" valign="bottom" autofocus></div>
									<div class="row"><input type="submit" name="input_pin" value="Submit" class="btn-red">
									<input type="submit" name="logout" value="Logout" class="btn-gray"></div>
								</form>
								<p style="color:#fff!important;">Lupa PIN? Hubungi Operator kami.</p>
							</div>
							
						<?PHP }else{ ?>
						
							<h4>Masukan PIN BARU Anda (Hanya Berlaku 1x)</h4>
							<form method="post">
								<input type="password" name="pin" id="pin" class="pin" maxlength="6" autocomplete="off" valign="bottom" autofocus>&nbsp;&nbsp;
								<input type="submit" name="submit_data" value="Submit" class="btn-red"></p>
							</form>
						<?PHP } ?>
					</div>
				</div>
			</div>
		</center>
	</div>
</div>

<script type="text/javascript">

	$(function () {
		$('#pin').keypad({showOn: 'both', randomiseNumeric: true});
	});
	
	$('.next').click(function(e){
		e.preventDefault();
		
		$('.valbank').css('display', 'none');
		$('.btnbank').css('display', 'none');
		
		$('.valpin').css('display', 'block');
		$('.openpin').css('display', 'block');
	});
</script>

<?php exit(); ?>
</body>
</html>