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
		
		$userx=sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userid,xdeposit from u6048user_id where xdeposit>=0 and userid='".$login."' order by xdeposit desc"), SQLSRV_FETCH_NUMERIC);
		$q_grup=sqlsrv_query($sqlconn, "select distinct(grup),xdeposit from a83adm_grupbank where subweb='".$subwebid."' order by xdeposit asc", $param, $option);
		$index_group = 0;
		while($r_grup=sqlsrv_fetch_array($q_grup,SQLSRV_FETCH_ASSOC)){
			
			
			if ($r_grup["grup"] == 0)$r_grup["grup"]=1;
			
			if ($userx[1] == 0)$userx[1]=1;
			
			
			if($userx[1] > $index_group && $userx[1] <= $r_grup["xdeposit"]){
				sqlsrv_query($sqlconn, "update u6048user_id set bankgrup='".$r_grup["grup"]."' where userid='".$login."'");
			}
			$index_group = $r_grup["xdeposit"];
		}
		//$r_grup["grup"] = $r_grup["grup"]-1;
		
		echo "<script>window.location='../rules.php'</script>"; 
	}else{
		if ( ($logx+1) >= 5 ){
			sqlsrv_query($sqlconn,"update u6048user_id set logx='5',lastlogin=GETDATE(),status='1' where userid ='".$login."'");
			sqlsrv_query($sqlconn,"insert into g846log_internal (userid,username,waktu,ket) values ('".$login."','".$_SERVER['REMOTE_ADDR']."',GETDATE(),'Validation Pin Fail')");
			
			include_once("config_db2.php");
			// log Login (yang baru kalau data sudah stabil log lama dihapus) / Dewadev insert ke 56 Live ke 142
			$queryLogLogin = "INSERT INTO j2365join_playerlog (userid,userprefix,action,ip,client_ip,forward_ip,remote_ip,Info,CreatedDate) 
			VALUES ('$login','" . $agentwlable . "','Block','" . getUserIP2() ."','" . getUserIP2('HTTP_CLIENT_IP') . "','" . getUserIP2('HTTP_X_FORWARDED_FOR') . "','" . getUserIP2('REMOTE_ADDR') . "', 'Wrong PIN 5 time. From " . $_SERVER['SERVER_NAME'] . "', GETDATE())";
			
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
}else{
	//TXHLASTORDER
	sqlsrv_query($sqlconn, "if exists (select userid from t6413txh_lastorder where userid = '".$login."')
		begin
		select '1' as hasil
		end
		else
			begin
		INSERT INTO t6413txh_lastorder (userid, bdate, info, status, amount, total) SELECT userid, GETDATE(), 'new-add','new-add', TXH, TXH FROM u6048user_coin WHERE (userid = '".$login."')
		end",$params,$options);
	//END TXHLASTORDER

	//GAMEID AND GAMEDATA
	$userid_gamex = sqlsrv_query($sqlconn, "if exists (select userid from g846game_id where userid = '".$login."')
		begin
		select '1' as hasil
		end
		else
			begin
		INSERT INTO g846game_id SELECT * FROM u6048user_id where userid='".$login."'
		INSERT INTO g846game_data SELECT * FROM u6048user_data where userid='".$login."'
		end",$params,$options);

	$userid_gamex2 = sqlsrv_query($sqlconn, "SELECT playerpt,userprefix from g846game_id where userid='".$login."'",$params,$options);
	$userid_game2 =  sqlsrv_fetch_array($userid_gamex2,SQLSRV_FETCH_ASSOC);
	if($userid_game2["playerpt"] == 0){

		sqlsrv_query($sqlconn, "if exists (select userid from g846game_id where userid='".$userid_game2["userprefix"]."')
			begin
			select '1' as hasil
			end
			else
				begin
			INSERT INTO g846game_id SELECT * FROM u6048user_id where userid='".$userid_game2["userprefix"]."'
			INSERT INTO g846game_data SELECT * FROM u6048user_data where userid='".$userid_game2["userprefix"]."'
			end",$params,$options);
		
		sqlsrv_query($sqlconn, "if exists (select userid from g846game_id where userid='".substr($userid_game2["userprefix"],0,3)."')
			begin
			select '1' as hasil
			end
			else
				begin
			INSERT INTO g846game_id SELECT * FROM u6048user_id where userid='".substr($userid_game2["userprefix"],0,3)."'
			INSERT INTO g846game_data SELECT * FROM u6048user_data where userid='".substr($userid_game2["userprefix"],0,3)."'
			end",$params,$options);
		
		sqlsrv_query($sqlconn, "if exists (select userid from g846game_id where userid='".substr($userid_game2["userprefix"],0,1)."')
			begin
			select '1' as hasil
			end
			else
				begin
			INSERT INTO g846game_id SELECT * FROM u6048user_id where userid='".substr($userid_game2["userprefix"],0,1)."'
			INSERT INTO g846game_data SELECT * FROM u6048user_data where userid='".substr($userid_game2["userprefix"],0,1)."'
			end",$params,$options);
		
	}
	//END GAMEID AND GAMEDATA
}

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
	<link rel="stylesheet" href="assets/css/validation.css?id=<?PHP echo time(); ?>">
	<link href="assets/js/jquery.keypad/jquery.keypad.css" rel="stylesheet">
	<link rel="stylesheet" href="assets/css/font-awesome.min.css">
	
	<script src="assets/js/jquery_min.js"></script>
	<script src="assets/js/jquery.keypad/jquery.plugin.js"></script>
	<script src="assets/js/jquery.keypad/jquery.keypad.js"></script>
</head>

<body>
	<div class="container">
		<div class="sub-container">
			<center>
				<div class="main">
					<div class="logo" style="margin: -100px 0 50px 0;"><a href="index.php" style=""><img src="../assets/img/<?php echo $link_img;?>/logo.png"></a></div>
					<div class="header">
						<h1 class="title">Selamat datang, <?php echo $login;?></h1>
					</div>
					<div class="content">
						<div class="sub-content">
							<table width="600">
								<tr>
									<td colspan=2 align="center">
										
										<?php 
											if ($pin_pembuka){ 
												$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select id,status,bankname, bankaccno, bankaccname, bankgrup,playerpt,userpass,email,joindate,save_deposit from u6048user_id where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
												$bankname = $sqlu["bankname"];
												$bankaccno = $sqlu["bankaccno"];
												$bankaccname = $sqlu["bankaccname"];

												if($bankaccno != null && $bankname != null && $bankaccname != null) {
										?>
													<style>													
														.valpin, .openpin{
															display: none;
														}
													</style>
													
													<div class="valbank">
														<h1>VALIDASI KEAMANAN</h1>
														<p style="font-size:13px;">Bertujuan untuk meningkatkan keamanan dan kenyamanan bisnis Anda.</p>
														<div class="user-box">
															<p>Harap <b>periksa data pribadi</b> terlebih dahulu sebelum memasukan PIN :</p>
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
																	<input type="text" class="frm-input" value="<?PHP echo substr($bankaccno, 0, 8)."XXXX"; ?>" readonly>
																</div>
																
																<div class="row"></div>
															</div>
														</div>
													</div>
													
										<?PHP } ?>
										
											<div class="valpin">
												<h1>VALIDASI KEAMANAN</h1>
												<p style="font-size:13px;">Bertujuan untuk meningkatkan keamanan dan kenyamanan bisnis Anda.</p>
												<div class="newval-box">
													<div>
														<img src="../assets/img/<?php echo $link_img;?>/inputpinlimit.png">
														<p>User ID akan di blokir, <br> jika mengalami <br> kesalahan 5X.</p>
													</div>
													<div>
														<img src="../assets/img/<?php echo $link_img;?>/csval.png">
														<p>Jika Anda lupa PIN, <br> silahkan klik hubungi <br> operator kami. </p>
													</div>
													<div>
														<img src="../assets/img/<?php echo $link_img;?>/randompin.png" style="margin-left: 20px;">
														<p>Tombol dibuat secara acak, <br> mohon perhatikan angka <br> yang Anda input.</p>
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
											<p>Sistem ini untuk meningkatkan <b>KEAMANAN</b> dan <b>KENYAMANAN</b> bermain anda.</p>

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
									<input type="password" name="pin" id="pin" class="pin" maxlength="6" autocomplete="off" valign="bottom" autofocus> &nbsp;&nbsp;&nbsp; 
									<input type="submit" name="input_pin" value="Submit" class="btn-red">
									<input type="submit" name="logout" value="Logout" class="btn-gray">
								</form>
								<p>Lupa PIN? Hubungi Operator kami.</p>
							</div>
							
						<?PHP }else{ ?>
						
							<h4>Masukan PIN BARU Anda (Hanya Berlaku 1x)</h4>
							<form method="post">
								<table>
									<tr>
										<td><p><input type="password" name="pin" id="pin" class="pin" maxlength="6" autocomplete="off" valign="bottom" autofocus>&nbsp;&nbsp;
										<input type="submit" name="submit_data" value="Submit" class="btn-red"></p>
										</td>
									</tr>
								</table>
							</form>
						<?PHP } ?>
					</div>
				</div>
			</div>
		</center>
	</div>
</div>
</body>
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