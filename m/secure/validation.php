<?php

if ($_POST["logout"]){
	session_destroy();
	echo "<script>window.location='../index.php'</script>"; 
}
$table_userid = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select validation,logx,hp from u6048user_id where userid='".$login."'"),SQLSRV_FETCH_ASSOC);
$logx=$table_userid["logx"];
$validation=$table_userid["validation"];
$pin_pembuka=$table_userid["hp"];

if ($_POST["input_pin"]){
	if ($pin_pembuka == $_POST["pin"]){
		$_SESSION["pin"]=$pin_pembuka;
		sqlsrv_query($sqlconn,"update u6048user_id set logx=0 where userid='".$login."'");
		
		$userx=sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userid,xdeposit from u6048user_id where xdeposit>0 and userid='".$login."' order by xdeposit desc"), SQLSRV_FETCH_NUMERIC);
		$q_grup=sqlsrv_query($sqlconn, "select distinct(grup),xdeposit from a83adm_grupbank where subweb='".$subwebid."' order by xdeposit asc", $param, $option);
		while($r_grup=sqlsrv_fetch_array($q_grup,SQLSRV_FETCH_ASSOC)){
			if ($r_grup["grup"] == 0)$r_grup["grup"]=1;
			if($userx[1] >= $r_grup["xdeposit"]){
				sqlsrv_query($sqlconn, "update u6048user_id set bankgrup='".$r_grup["grup"]."' where userid='".$login."'");
				
				
			}
			
		}
		//$r_grup["grup"] = $r_grup["grup"]-1;
		
		echo "<script>window.location='../index.php'</script>"; 
	}else{
		if ( ($logx+1) >= 5 ){
			sqlsrv_query($sqlconn,"update u6048user_id set logx='5',lastlogin=GETDATE(),status='1' where userid ='".$login."'");
			sqlsrv_query($sqlconn,"insert into g846log_internal (userid,username,waktu,ket) values ('".$login."','".$_SERVER['REMOTE_ADDR']."',GETDATE(),'Validation Pin Fail')");
			
			include_once("../config_db2.php");
			// log Login (yang baru kalau data sudah stabil log lama dihapus) / Dewadev insert ke 56 Live ke 142
			$queryLogLogin = "INSERT INTO j2365join_playerlog (userid,userprefix,action,ip,client_ip,forward_ip,remote_ip,Info,CreatedDate) 
				 		      VALUES ('$login','" . $agentwlable . "','Block','" . getUserIP2() ."','" . getUserIP2('HTTP_CLIENT_IP') . "','" . getUserIP2('HTTP_X_FORWARDED_FOR') . "','" . getUserIP2('REMOTE_ADDR') . "', 'Wrong PIN 5 time. From " . $_SERVER['SERVER_NAME'] . " (Mobile Version)', GETDATE())";
							  
			sqlsrv_query($sqlconn_db2,$queryLogLogin);
			
			session_destroy();
		}else{
			sqlsrv_query($sqlconn,"update u6048user_id set logx=(logx+1) where userid='".$login."'");
			$logx++;
		}
	}
	
}else if ($_POST["submit_data"]){
	$question=$_POST["question"];
	$pin=$_POST["pin"];
	if (strlen($pin) != 6){
		$error="Pin harus 6 digit angka.";
	}else{
		
		sqlsrv_query($sqlconn,"update u6048user_id set hp='".$pin."',logx='0' where userid='".$login."'");
		echo "<script>
		alert('Sukses untuk setting data pribadi anda');
		window.location='../index.php';</script>"; 
	}
}


if ($logx > 0){
	$error="Anda melakukan kesalahan ".$logx." x";
}
if($logx >= 5){
	session_destroy();
	echo "<script>window.location='../index.php'</script>"; 
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

