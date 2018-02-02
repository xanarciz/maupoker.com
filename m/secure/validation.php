<?php
if (isset($_POST["logout"])){
	session_destroy();
	echo "<script>window.location='../index.php'</script>"; 
}
$pin_pembuka=$pin;
$iplist = getUserIP2().','.getUserIP2('HTTP_CLIENT_IP').','.getUserIP2('HTTP_X_FORWARDED_FOR').','.getUserIP2('REMOTE_ADDR');

if (isset($_POST["input_pin"])){
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
}else if (isset($_POST["submit_data"])){
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
	<title>WELCOME</title>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0"/>
<meta name="apple-mobile-web-app-capable" content="yes"/>
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-title" content="Mobile Poker">

<link rel="stylesheet" href="../assets/css/<?php echo $link_img;?>.css">
<link href="js/jquery.keypad/jquery.keypad.css" rel="stylesheet">
<script src="../assets/js/jquery_min.js"></script>
<script src="js/jquery.keypad/jquery.plugin.js"></script>
<script src="js/jquery.keypad/jquery.keypad.js"></script>

<style>

</style>
<body onload="autoFocusx()">
	<center>
	<div class="logo" style=" width: 336px;  height: 84px;   display: block;   margin: 15px 0;   background: url(../../img/<?php echo $link_img;?>/imgAll.png) 0px 0px no-repeat;"><a href="index.php" style=""></a></div>
	<br><br>
	<div class="head-wrap">
		<table cellpadding=5 width="100%" cellspacing=0>
			<tr>
				<td  style="border-bottom:1px #fff solid;" valign=top>
					<h1 style="">SELAMAT DATANG</h1>
					<div style="font-family:verdana;font-size:25px;"><?php echo $login;?></div>
					<br>
				</td>
			</tr>
			<tr>
				<td colspan=2 style=padding-top:25px;>
					<?php if ($pin_pembuka){?>
						<h1 style="font-size:24px">VALIDASI KEAMANAN</h1>
						<div style="font-family:verdana;font-size:16px;text-align:justify;">Untuk meningkatkan <b>KEAMANAN</b> dan <b>KENYAMANAN</b> bisnis anda. </div>
						<br>
						<div style="font-family:verdana;font-size:16px;padding-bottom:7px;"><b>*JIKA 5X SALAH, USERID ANDA AKAN DIBLOKIR</b></div>
						<div style="font-family:verdana;font-size:16px;padding-bottom:7px;"><b>*JIKA ANDA LUPA PIN, HARAP LOGOUT DAN HUBUNGI KAMI</b></div>
						<div style="font-family:verdana;font-size:16px;padding-bottom:7px;"><b>*TOMBOL DIBAWAH ADALAH ACAK, HARAP PERHATIKAN ANGKA YANG ANDA INPUT</b></div>
						
						<br>
						<?php
						if(!isset($error)){$error = '';}
						if ($error){
							echo "<div style='font-family:verdana;color:#aa0000;font-size:16px;padding-bottom:7px;'><b>$error</b	></div>";
						}
						?>
						
						<div style="" align=center>
							<div style="font-family:verdana;font-size:16px;padding-bottom:7px;">Masukan <B style="">6 DIGIT PIN</B> anda</div>
							<form method=post>
								<p><input type=password name="pin" id="pin" style="width:80px;color:#000;font-size:20;height:34" maxlength=6 autocomplete=off valign=bottom> &nbsp;&nbsp;&nbsp; <input type=submit name=input_pin value="Submit" class="btn btn-login"> <input type=submit name=logout value="Logout" class="btn btn-login"></p>
							</form>
						</div>
					<?php }else{?>
						<h1 style="font-size:24px">MASUKAN 6 DIGIT PIN BARU ANDA</h1>
						<div style="font-family:verdana;font-size:16px;text-align:justify;">Sistem ini untuk meningkatkan <b>KEAMANAN</b> dan <b>KENYAMANAN</b> bermain anda.</div>
						<br><br>
						<?php
						if ($error){
							echo "<div style='font-family:verdana;color:#aa0000;font-size:16px;padding-bottom:7px;'><b>$error</b></div>";
						}
						?>
						<div style="font-family:verdana;font-size:16px;padding-bottom:7px;"><b>*TOMBOL DIBAWAH ADALAH ACAK, HARAP PERHATIKAN ANGKA YANG ANDA INPUT</b></div>
						<div style="font-family:verdana;font-size:16px;padding-bottom:7px;"><b>*PIN INI AKAN DIGUNAKAN SETIAP ANDA MASUK KEDALAM GAME</b></div>
						<div style="font-family:verdana;font-size:16px;padding-bottom:7px;">Masukan <B style="">PIN BARU</B> anda (Hanya Berlaku 1 x)</div>
						<form method=post>
							<table>
								<tr>
									<td><p><input type=password name="pin" id="pin" style="width:80px;color:#000;font-size:20;height:34" maxlength=6 autocomplete=off valign=bottom >&nbsp;&nbsp;<input type=submit name=submit_data value="Submit" class="btn btn-login"></p>
									</td>
								</tr>
							</table>
						</form>
					<?php
					}
					?>
				</td>
			</tr>
		</table>
	</div>
	</center>
</body>
<script type="text/javascript">

$(function () {
	$('#pin').keypad({showOn: 'both', randomiseNumeric: true});
});

</script>
<?php
exit();
?>