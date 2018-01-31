<?php

if ($_POST["logout"]){
	echo "<script>window.location='../logout.php'</script>";
}
$pin_pembukax 	= $pin;
$iplist 		= getUserIP2().','.getUserIP2('HTTP_CLIENT_IP').','.getUserIP2('HTTP_X_FORWARDED_FOR').','.getUserIP2('REMOTE_ADDR');

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
			$_SESSION["pin"] = $pin_pembukax;
			exit( "<script>window.location='../rules.php'</script>"); 
		}else{
			if($respPin->actstat == 6){
                exit("<script>window.location='../logout.php'</script>");
            }else{
				$error = $respPin->msg;
			}
		}
	 
}else if ($_POST["submit_data"]){
	$question=$_POST["question"];
	$pin=$_POST["pin"];
	
	// update pin
	$reqAPIPin = array(
		"auth"  	=> $authapi,
		"domain" 	=> $nonWWW,
		"ip"		=> $iplist,
		"device"	=> 2,
		"type"		=> 5,
		"userid"	=> $login,
		"pin"       => $_POST["pin"],
	);
	$respPin = sendAPI($url_Api."/account",$reqAPIPin,'JSON','02e97eddc9524a1e');

	
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
	<title>WELCOME</title>
</head>
<link rel="stylesheet" href="assets/css/<?php echo $link_img;?>.css?id=<?php echo time(); ?>">
<link rel="stylesheet" href="universal/keypad-new.css?id=<?php echo time(); ?>">
<link href="universal/jquery.keypad/jquery.keypad.css?id=<?php echo time(); ?>" rel="stylesheet">
<script src="assets/js/jquery_min.js"></script>
<script src="universal/jquery.keypad/jquery.plugin.js"></script>
<script src="universal/jquery.keypad/jquery.keypad.js?id=<?php echo time(); ?>"></script>
<body>

	<?php
	$agent = $_SERVER['HTTP_USER_AGENT'];
	if (strlen(strstr($agent, 'Firefox')) > 0) {
	?>
		<style>
			.pin{
				width: 350px !important;
				font-size: 20px !important;
				letter-spacing: 42px !important;
			}
		</style>
	<?PHP
	}
	?>

	<center>
		<div class="logo" style=" width: 336px;  height: 84px;   display: block;   margin: 15px 0;   background: url(../img/<?php echo $link_img;?>/imgAll.png) 0px 0px no-repeat;"><a href="index.php" style=""></a></div>
		<br><br>
		<div class="head-wrap">
			<div class="welcome-pin">Selamat Datang, <?php echo $login;?></div>
			<form method="post">
				<div class="pincontainer">
					<div class="pincontainer-left">
						<table cellpadding=5 width="600" cellspacing=0>
							<tr>
								<td colspan=2 style=padding-top:25px;>
									<?php if ($pin_pembukax){?>
										<h1>VALIDASI KEAMANAN</h1>
										<p>Untuk masuk ke halaman permainan, masukan 6-digit PIN anda menggunakan <br> tombol nomor di samping, demi kemanan akun ID anda.</p>
										<?php
										if ($error){
											echo "<div style='font-family:verdana;color:#aa0000;font-size:16px;padding-bottom:7px;'><b>$error</b	></div>";
										}
										?>
										<div class="pin-container">
											<input type="password" name="pin" id="pin" class="pin" maxlength="6" autocomplete="off" valign="bottom" autofocus>
											<div class="btn-delete">&nbsp;X</div>
										</div>
										<ul>
											<li>Jika 5x salah memasukan PIN, user ID anda akan terblokir</li>
											<li>Jika anda lupa PIN, harap logout dan silahkan menghubungi kami</li>
											<li>Tombol nomor disamping adalah acak, harap perhatikan angka yang di input </li>
											<li>Dengan menekan tombol Submit, Anda telah membaca dan setuju dengan</li>
											<a href="#" id="term">Syarat & Ketentuan</a>
										</ul>
									<?php }else{?>
									<h1>MASUKAN 6 DIGIT PIN BARU ANDA</h1>
									<h4>Sistem ini untuk meningkatkan <b>KEAMANAN</b> dan <b>KENYAMANAN</b> bermain anda.</h4>
									<br>
									<div class="pin-container">
										<input type="password" name="pin" id="pin" class="pin" maxlength="6" autocomplete="off" valign="bottom" autofocus>
										<div class="btn-delete">&nbsp;X</div>
									</div>

									<br><br>

									<?php
										if ($error){
											echo "<div style='font-family:verdana;color:#aa0000;font-size:16px;padding-bottom:7px;'><b>$error</b></div>";
										}
										?>

									<ul>
										<li>TOMBOL DIBAWAH ADALAH ACAK, HARAP PERHATIKAN ANGKA YANG ANDA INPUT</li>
										<li>PIN INI AKAN DIGUNAKAN SETIAP ANDA MASUK KEDALAM GAME</li>
										<li>Masukan <B style="">PIN BARU</B> anda (Hanya Berlaku 1 x)</li>
									</ul>

									<?php
										}
									?>
								</td>
							</tr>
						</table>
					</div>
					<div class="pincontainer-right"></div>
				</div>
				<div class="pincontainer-bottom">
					<?php if ($pin_pembukax){?>
						<input type="submit" name="input_pin" value="Submit" class="keypad-key btn-login">
						<input type="submit" name="logout" value="Logout" class="keypad-key btn-logout">
					<?PHP }else{ ?>
						<input type="submit" name="submit_data" value="Submit" class="keypad-key btn-login">
					<?PHP } ?>
				</div>
			</form>
		</div>
	</center>
	<!-- The Modal -->
	<div id="myModal" class="modal">
		<div class='modal-header'><div class="close">&times;</div></div>
	  <!-- Modal content -->
	  <div class="modal-content">
		<p><?PHP include('universal/terms.php'); ?></p>
	  </div>

	</div>
</body>

<script type="text/javascript">
	$('.btn-delete').click(function(){
		$('.pin').val(
			function(index, value){
				return value.substr(0, value.length - 1);
		})
	});
	$(function () {
		$('#pin').keypad({showOn: 'both', randomiseNumeric: true});
		$(document).on('click', '.keypad-key', function(){
			$('#pin').val().length == $('#pin').attr('maxlength') ? $('#pin').blur() : $('#pin').focus();
		});
	});
	var modal = document.getElementById('myModal');
	var btn = document.getElementById("term");
	var span = document.getElementsByClassName("close")[0];

	btn.onclick = function() {
		modal.style.display = "block";
	}

	span.onclick = function() {
		modal.style.display = "none";
	}

	window.onclick = function(event) {
		if (event.target == modal) {
			modal.style.display = "none";
		}
	}
</script>

<?php exit(); ?>