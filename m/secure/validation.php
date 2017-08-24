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

<!DOCTYPE HTML>
<html lang="en">
<head>

<title></title>

<link href="css/<?PHP echo $link_img;?>/style.css" rel="stylesheet" type="text/css">
<link href="css/<?PHP echo $link_img;?>/framework.css" rel="stylesheet" type="text/css">
<link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="css/animate.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="assets/owl-carousel/owl.carousel.css" />
<link href="assets/jquery-ui-1.9.2.custom/css/custom-theme/<?PHP echo $link_img;?>/jquery-ui-1.9.2.custom.css" rel="stylesheet">

<link href="./js/jquery.keypad/jquery.keypad.css" rel="stylesheet">
<script src="./js/jquery_min2.js"></script>
<script src="./js/jquery.keypad/jquery.plugin.js"></script>
<script src="./js/jquery.keypad/jquery.keypad.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<body>

<div class="all-elements">

  <div id="content" class="page-content">

   	 <div class="content">
	   	 <div class="row" align="center">
		   	 <div class="col-lg-12 tmargin-10 bmargin-30">
		   	 	 <img class="img-fluid" src="img/<?PHP echo $link_img;?>/logo.png" style="width: 40%" />
		   	 </div>
	   	 </div>
   	 <div class="clear-fixed"></div>

   	 <?PHP 
   	 	if ($pin_pembuka){
   	 ?>

   	 <div class="container-fluid">
   		 <label class="black">Selamat datang, <b><?php echo $login;?></b></label>
   	 	<div class="alert alert-warning text-center">
   	 		<i class="fa fa-exclamation-triangle fa-2x"></i>
   	 		<br/>
   	 		<p>Berhati-hati dengan website penipuan
			yang mengatasnamakan Kami
			silahkan periksa keaslian domain Anda
			disini</p>
   	 	</div>
   	 </div>
   	 <div class="container-fluid validate">
   	 	<label class="<?PHP if(strtoupper($link_img) == "IO"){ echo "gold"; }elseif($link_img == "PTKP"){ echo "blue"; }else{ echo "purple";} ?>"><b>VALIDASI KEAMANAN</b></label>
   	 	<p class="black">
   	 		Sistem ini untuk meningkatkan <b>KEAMANAN</b> dan <b>KENYAMANAN</b> bermain anda.
			<ul class="black">
				<li><p class="black">Jika salah 5x, user ID Anda akan di blokir.</p></li>
				<li><p class="black">Jika Anda lupa PIN, harap logout dan hubungi kami</p></li>
				<li><p class="black">Tombol di bawah adalah acak, harap perhatikan angka yang Anda input</p></li>
			</ul>

			<?PHP
				if ($error){
					echo "<div class='red' style='font-size:16px;padding-bottom:7px;'><b>$error</b></div>";
				}
			?>

			<p class="text-center black">Masukan 6 DIGIT PIN</p>
			<div class="row">
			  <form method="post">
				<div class="col-lg-6">
					<input class="form-control" type="password" name="pin" id="pin" maxlength="6" autocomplete="off" autofocus readonly>
				</div>
				<div class="col-lg-6">
					<div class="col-lg-6 padding-2">
						<input class="btn btn-blue text-center" value="Submit" type="submit" name="input_pin" id="input_pin" />
					</div>
					<div class="col-lg-6 padding-2">
						<input class="btn btn-blue text-center" value="Logout" type="submit" name="logout" id="logout" />
					</div>
				</div>
			  </form>
			</div>
   	 	</p>
   	 </div>

   	 <?PHP
   	 	}else{
   	 ?>

   	 <div class="container-fluid">
   		 <label class="black">Selamat datang, <b><?php echo $login;?></b></label>
   	 </div>
   	 <div class="container-fluid validate">
   	 	<label class="black">MASUKAN 6 DIGIT PIN BARU ANDA</label>
   	 	<p class="black">
   	 		Sistem ini untuk meningkatkan <b>KEAMANAN</b> dan <b>KENYAMANAN</b> bermain anda.
			<ul class="black">
				<li><p class="black">TOMBOL DIBAWAH ADALAH ACAK, HARAP PERHATIKAN ANGKA YANG ANDA INPUT</p></li>
				<li><p class="black">PIN INI AKAN DIGUNAKAN SETIAP ANDA MASUK KEDALAM GAME</p></li>
				<li><p class="black">Masukan <b>PIN BARU</b> anda (Hanya Berlaku 1 x)</p></li>
			</ul>

			<?PHP
				if ($error){
					echo "<div class='red' style='font-size:16px;padding-bottom:7px;'><b>$error</b></div>";
				}
			?>

			<p class="text-center black">Masukan 6 DIGIT PIN</p>
			<div class="row">
			  <form method="post">
				<div class="col-lg-6">
					<input class="form-control" type="password" name="pin" id="pin" maxlength="6" autocomplete="off" autofocus readonly>
				</div>
				<div class="col-lg-6">
					<input class="btn btn-blue text-center" value="Submit" type="submit" name="submit_data" id="submit_data" />
				</div>
			  </form>
			</div>
   	 	</p>
   	 </div>

   	 <?PHP
   	 	}
   	 ?>

	</div>
  </div>
</div>

<script type="text/javascript">

	$(function () {
		$('#pin').keypad({showOn: 'both', randomiseNumeric: true});
	});

</script>
<?php exit(); ?>

</body>
</html>

