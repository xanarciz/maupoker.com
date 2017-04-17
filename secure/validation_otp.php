<?php
if ($_POST["logout"]){
	session_destroy();
	echo "<script>window.location='../index.php'</script>"; 
}

include('myaes.php');

$url = "http://103.249.162.143:2804/auth/"; // IDN player OTP
	
$user_data = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select email,flag from u6048user_id where userid = '".$user_login."'"),SQLSRV_FETCH_ASSOC);
$email = $user_data['email'];
$flag = $user_data['flag'];
if((!$_GET['input'] && $_SESSION["send"] != 1) or $_GET['send']== 1){
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	$response = "<request>
					<secret_key>9db780b3b2d6332039fb85eea</secret_key>
					<id>1</id>
					<player>$user_login</player>
					<domain>$nonWWW</domain>
					<sendto>$email</sendto>
					<agent>$agentwlable</agent>
				</request>";
				
	$pkey = '2fb4f029ebf33b9a';
	$myaes = new myaes();
	$myaes->setPrivate($pkey);
	$response = $myaes->getEnc($response);

	curl_setopt($ch, CURLOPT_POSTFIELDS,"" . $response);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
	$data = curl_exec($ch);
	curl_close($ch);
	$array_data = simplexml_load_string($data);
	// $status = $array_data["status"];
	if($array_data->status==0){
		$error = "<div class='error-report'>".$array_data->message."</div>";
	}else{
		header("location:index.php");
	}
	$_SESSION["send"] = 1;
}

if($_POST['skip']){
	sqlsrv_query($sqlconn,"update u6048user_id set flag='1' where userid='".$login."'");
	header("location:index.php");
}

if($_POST['submit']){
    $code = $_POST['code'];
    $capt = $_POST['captcha1'];
	$email = $_POST['email'];
	if($_GET['input']){
		if($email=='' || $capt==''){
			$error = "<div class='error-report'>".P_PLEASEFILLALLFIELD.".</div>";
		}
	}else{
		if($code=='' || $capt==''){
			$error = "<div class='error-report'>".P_PLEASEFILLALLFIELD.".</div>";
		}
	}

    if ($capt != $_SESSION['CAPTCHAString']){
        $error =  "<div class='error-report'>".P_VALIDATIONWRONG.".</div>";
    }else{
		if($_GET['input']){
			
			sqlsrv_query($sqlconn,"update u6048user_id set email = '".$email."' where userid = '".$user_login."'");
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, $url);
			$response = "<request>
							<secret_key>9db780b3b2d6332039fb85eea</secret_key>
							<id>1</id>
							<player>$user_login</player>
							<domain>$nonWWW</domain>
							<sendto>$email</sendto>
							<agent>$agentwlable</agent>
						</request>";
						
			$pkey = '2fb4f029ebf33b9a';
			$myaes = new myaes();
			$myaes->setPrivate($pkey);
			$response = $myaes->getEnc($response);

			curl_setopt($ch, CURLOPT_POSTFIELDS,"" . $response);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
			$data = curl_exec($ch);
			curl_close($ch);
			$array_data = simplexml_load_string($data);
			// $status = $array_data["status"];
			if($array_data->status==0){
				$error = "<div class='error-report'>".$array_data->message."</div>";
			}else{
				header("location:index.php");
			}
			
			echo "<script>alert('Berhasil Mengganti Email'); window.location='../index.php';</script>";
		}else{
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, $url);
			$response = "<request>
							<secret_key>9db780b3b2d6332039fb85eea</secret_key>
							<id>2</id>
							<player>$user_login</player>
							<code>$code</code>
							<agent>$agentwlable</agent>
						</request>";
						
			$pkey = '2fb4f029ebf33b9a';
			$myaes = new myaes();
			$myaes->setPrivate($pkey);
			$response = $myaes->getEnc($response);

			curl_setopt($ch, CURLOPT_POSTFIELDS,"" . $response);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
			$data = curl_exec($ch);
			curl_close($ch);
			$array_data = json_decode(json_encode(simplexml_load_string($data)), true);
			// $status = $array_data["status"];
			if($array_data['status']==0){
				$error = "<div class='error-report'>".$array_data['message']."</div>";
			}else{
				sqlsrv_query($sqlconn,"update u6048user_id set flag='1' where userid='".$login."'");
				echo "<script>alert('".P_SUC."');";
				header("location:index.php");
			}
			
		}
	}
}

?>

<html>
<head>
	<title><?php echo  P_WELCOME;?></title>
</head>
<link rel="stylesheet" href="assets/css/<?php echo $link_img;?>.css">
<link href="assets/js/jquery.keypad/jquery.keypad.css" rel="stylesheet">
<script src="assets/js/jquery_min.js"></script>
<script src="assets/js/jquery.keypad/jquery.plugin.js"></script>
<script src="assets/js/jquery.keypad/jquery.keypad.js"></script>

<style>

</style>
<body >
	<div style="width:550px;margin: auto;">
    <nav class="navbar navbar-default navbar-fixed-top topheader">
            <div class="logo" style=" width: 336px;  height: 84px;   display: block;   margin: 15px 0;   background: url(../img/<?php echo $link_img;?>/imgAll.png) 0px 0px no-repeat;background-position: center; "><a href="index.php" style=""></a></div>
    </nav>

      
       <div style="margin-top:50px">
			<div class="title-page" align="Center">
					<h1><?php echo  P_WELCOME." ";?><span style="font-family:verdana;font-size:25px;color:#F2B61C"><b><?php echo $user_login;?></b></span></h1>
					<h1><?php echo "Validation Email";?></h1><hr>
			</div>
            
       		
				
       		<form method="post">
                <p>Kami akan mengirimkan kode verifikasi ke email anda untuk menunjukan bahwa anda adalah user yang benar .</p>
                <p>Harap Pastikan Email Anda Valid
                <?php 
				
				if($_GET['input']){
					echo ", Silahkan Masukan Email Yang Valid </p>";
					
				}else{
					echo ", Silahkan cek Email Anda </p>";
				}
				
				
				
                if($error){
                    echo "<div class=\"alert alert-danger\" style='width:300px;'>".$error."</div>";
                }
                ?>
				<div style="margin-bottom:10px;">
				<?php 
					if($_GET['input']){
						echo "Email Anda Sebelumnya : <b>".$email."</b>";
						?>
						<input type="text" name="email" id="code" style="width:300px;color:#000;font-size:20;height:34;margin-bottom: 10px;text-align: center;margin-top:10px;" data-required="true" autocomplete="off" valign="bottom" placeholder="Email Baru Anda">
						<?php
					}else{
						echo "Email Anda : <b>".$email."</b>";
					}
						
						
				if(!isset($_GET['input'])){
				?>
				<a href="?input=1" style="text-decoration: underline;">Ganti</a>
				
				<div style="width:400px;margin-top:10px;">
					<input type="text" name="code" id="code" style="width:300px;color:#000;font-size:20;height:34;margin-bottom: 10px;text-align: center;" data-required="true" autocomplete="off" valign="bottom" placeholder="Email Validation Code">
					
				</div>
				<?php
				}
				?>
				</div>
				
				<div style="width:302px">
					<input type="text" name="captcha1" style="width:100px;color:#000;font-size:20;height:34;margin-bottom: 10px;float:left;" data-required="true" maxlength="5" placeholder="Captcha">
					<img src='captcha/captcha.php?.png?a=1' alt='CAPTCHA' style="height:34;margin-bottom: 10px;margin-left:3px;"/>
				</div>
				<div>
					<button class="btn btn-default btn-submit" style="font-size:20px;" type="submit" name="submit" value="submit">SUBMIT</button>
					<?php if($flag == 2){
					?>
					<button class="btn btn-default btn-submit" style="font-size:20px;" type="submit" name="skip" value="submit">SKIP</button>
					<?php } ?>
					<button class="btn btn-default btn-reset" style="font-size:20px;" type"submit" name="logout" value="logout" ><?php echo P_LOGOUT; ?></button>
				</div>
       		</form>
			<div style="margin-top:10px;">
				<?php
					if(!isset($_GET['input'])){
				?>
					<p style="color:#FF3B3B;"><b>*Jika Anda belum mendapatkan email code Verifikasi , silahkan klik </b><a href="?send=1" style="text-decoration: underline;">Kirim Ulang</a></p>
				<?php
					}
				?>
			</div>
        </div>
    </div>
	
</body>
<?php
exit();
?> 