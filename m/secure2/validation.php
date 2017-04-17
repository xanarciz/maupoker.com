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
		$q_grup=sqlsrv_query($sqlconn, "select grup,xdeposit from a83adm_grupbank where xdeposit<'".$userx[1]."' and subweb='".$subwebid."' order by xdeposit desc");
		$r_grup=sqlsrv_fetch_array($q_grup,SQLSRV_FETCH_ASSOC);
		if ($r_grup["xdeposit"] == 0)$r_grup["xdeposit"]=1;
		sqlsrv_query($sqlconn, "update u6048user_id set bankgrup='".$r_grup["xdeposit"]."' where userid='".$login."'");
		
		echo "<script>window.location='../rules.php'</script>"; 
	}else{
		if ( ($logx+1) >= 5 ){
			sqlsrv_query($sqlconn,"update u6048user_id set logx='5',lastlogin=GETDATE(),status='1' where userid ='".$login."'");
			sqlsrv_query($sqlconn,"insert into g846log_internal (userid,username,waktu,ket) values ('".$login."','".$_SERVER['REMOTE_ADDR']."',GETDATE(),'Validation Pin Fail')");
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
		window.location='../rules.php';</script>"; 
	}
}
//exit("baca".$_POST["submit_data"]);

if ($logx > 0){
	$error="Anda melakukan kesalahan ".$logx." x";
}
if($logx >= 5){
	session_destroy();
	echo "<script>window.location='../index.php'</script>"; 
}
?>

<html>
<head>
	<title>WELCOME</title>
</head>
<link rel="stylesheet" href="assets/css/<?php echo $link_img;?>.css">
<link href="assets/js/jquery.keypad/jquery.keypad.css" rel="stylesheet">
<script src="assets/js/jquery_min.js"></script>
<script src="assets/js/jquery.keypad/jquery.plugin.js"></script>
<script src="assets/js/jquery.keypad/jquery.keypad.js"></script>

<style>

</style>
<body >
	<center>
	<div class="logo" style=" width: 336px;  height: 84px;   display: block;   margin: 15px 0;   background: url(../img/<?php echo $link_img;?>/imgAll.png) 0px 0px no-repeat;"><a href="index.php" style=""></a></div>
	<br><br>
	<div class="head-wrap">
		<table cellpadding=5 width="600" cellspacing=0>
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
						if ($error){
							echo "<div style='font-family:verdana;color:#aa0000;font-size:16px;padding-bottom:7px;'><b>$error</b	></div>";
						}
						?>
						
						<div style="" align=center>
							<div style="font-family:verdana;font-size:16px;padding-bottom:7px;">Masukan <B style="">6 DIGIT PIN</B> anda</div>
							<form method=post>
								<p><input type=password name="pin" id="pin" style="width:80px;color:#000;font-size:20;height:34" maxlength=6 autocomplete=off valign=bottom autofocus> &nbsp;&nbsp;&nbsp; <input type=submit name=input_pin value="Submit" class="btn btn-login"> <input type=submit name=logout value="Logout" class="btn btn-login"></p>
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
									<td><p><input type=password name="pin" id="pin" style="width:80px;color:#000;font-size:20;height:34" maxlength=6 autocomplete=off valign=bottom autofocus>&nbsp;&nbsp;<input type=submit name=submit_data value="Submit" class="btn btn-login"></p>
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