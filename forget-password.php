<?php
session_start();
$login = $_SESSION['login'];
if (!$login) $freePage = 1;
else exit("<script>location.href='index.php'</script>");
include("meta.php");
include("header.php");
include("function/jcd-umum.php");
include_once("config_db2.php");
if (!$register)exit("<script>location.href='index.php'</script>");

$cref=$agentwlable;
$noRek	= "1";
$pt = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select playerpt_status from a83adm_config"),SQLSRV_FETCH_ASSOC);
$buka = $pt["playerpt_status"];
if($buka == 0) die("Cannot Open this page.");


if(@$_POST["submit"]){
	
	$uname	= $_POST["UName"];
	$bname	= $_POST["BName"];
	$baname	= $_POST["BAName"];
	$bano	= $_POST["BAno"];
	$hp		= $_POST["hp1"];
	$captcha= $_POST["captcha1"];

	$uname = strtoupper($uname);
	$errb = 0;
	if (strpos($hp,"<") or strpos($hp,">")){
		$errb = 1;
	}
	if (strpos($baname,"<") or strpos($baname,">")){
		$errb = 2;
	}

	$sqlb = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select userid, status, email, bankname, bankaccname, bankaccno,telp from u6048user_id where loginid = '".$uname."' and subwebid='".$subwebid."' and playerpt='0'"),SQLSRV_FETCH_ASSOC);
	if(strtoupper($hp) != strtoupper($sqlb["telp"])){
		$errb = 3;
	}else if (strtoupper($bname) != strtoupper($sqlb["bankname"])){
		$errb = 4;
	}else if (strtoupper($baname) != strtoupper($sqlb["bankaccname"])){
		$errb = 5;
	}else if (str_replace("-","",$bano) != str_replace("-","",$sqlb["bankaccno"])){
		$errb = 6;
	}
	
	$sqlf = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select val from a83adm_config3 where name = 'forget_pass'"),SQLSRV_FETCH_ASSOC);
	if ($sqlf["val"] == 1) {
		$loginlog = sqlsrv_num_rows(sqlsrv_query($sqlconn_db2,"select userid from log_loginlog where userid = '".$sqlb["userid"]."' and crttime >  dateadd(day, -1, GETDATE())",$params,$options));
	}else {
		$loginlog = 0;
	}

	
	if ($sqlb["bankaccno"] == ""){
		$errorReport = "<div class='error-report'>Data yang anda isi salah!</div>";
	}else if ($sqlb["status"] != "0"){
		$errorReport = "<div class='error-report'>Username anda masih dalam proses !</div>";
	}else if (!checkCaptcha('CAPTCHAString', $captcha)){
		$errorReport = "<center><b><font color=red style='font-size:14px'>Captcha harap diisi.</font></b></center>";
	}else if($errb > 0) $errorReport = "<div class='error-report'>Data yang anda isi salah $errb !</div>";
	else if ($loginlog > 0){
		sqlsrv_query($sqlconn,"delete from u6048user_active where userid = '".$sqlb["userid"]."'");
		$errorReport = "<div class='error-report'>Anda hanya bisa menggunakan lupa password apabila anda sudah tidak login lebih dari 24 jam !</div>";
	} else {
		
		if ($sqlf["val"] == 1) {
			$alpha = Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","W","X","Y","Z");
			$j = 0;
			for ($i = 0; $i < 4; $i++) {
				$n = rand(0, count($alpha)-1);
				$newpass[$j] = $alpha[$n];
				$j++;
			}
			$num = Array("0","1","2","3","4","5","6","7","8","9");
			for ($i = 0; $i < 2; $i++) {
				$n = rand(0, count($num)-1);
				$newpass[$j] = $num[$n];
				$j++;
			}
			shuffle($newpass);
			$passn = $newpass[0].$newpass[1].$newpass[2].$newpass[3].$newpass[4].$newpass[5];
		
			sqlsrv_query($sqlconn,"update u6048user_id set status='0', userpass='".hash("sha256",md5($passn).'8080')."' where loginid = '".$uname."' and subwebid='".$subwebid."'");
			sqlsrv_query($sqlconn,"update g846game_id set status='0', userpass='".hash("sha256",md5($passn).'8080')."' where loginid = '".$uname."' and subwebid='".$subwebid."'");

			$amount = auto_withdraw($uname, $bname, $baname, $bano, $agentwlable, $masterwlable, $subwebid, $sqlconn, $params, $options);
			
			 // Log Login yang Lama (masa peralihan ke log login yang baru)
			sqlsrv_query($sqlconn,"insert into g846log_player (userid, username, ket, waktu) values ('".$sqlb["userid"]."', '-', 'Reset Password ".$amount."', GETDATE())");
			sqlsrv_query($sqlconn,"insert into a83adm_forgetpass (date1,userid,stat) values (GETDATE(),'".$sqlb["userid"]."','0')");
			
			// Log Login (yang baru kalau data sudah stabil log lama dihapus)
			$queryLogLogin = "INSERT INTO j2365join_playerlog (userid,userprefix,action,ip,client_ip,forward_ip,remote_ip,Info,CreatedDate) 
				 		  	  VALUES ('" . $sqlb["userid"] . "','" . $agentwlable . "','Forget Password  ".$amount."','" . getUserIP2() . "','" . getUserIP2('HTTP_CLIENT_IP') . "','" . getUserIP2('HTTP_X_FORWARDED_FOR') . "','" . getUserIP2('REMOTE_ADDR') . "', 'Request Reset Password From " . $_SERVER['SERVER_NAME'] . "', GETDATE())";
			sqlsrv_query($sqlconn_db2,$queryLogLogin);
			
			$errorReport= "<div class='error-report'>Password telah diubah menjadi <B>".$passn."</B><br>Silakan Login kembali dengan Password tersebut(Perhatikan Huruf Besar)</div>";
		}else {
			$to = "Company";
			$subject = "### Memo halaman depan ###";
			$body = "Bank = ".$bname."<br>"."Bank Name = ".$baname."<br>"."No Rek = ".$banox."<br>"."Email = ".$email."<br>"."Comment = ".$comment;
			$sqlx = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select memo from a83adm_config"));
			$user = explode(",",$sqlx["memo"]);
			for($i=0;$i<count($user)-1;$i++){
				$us = $user[$i];
				$sql = sqlsrv_query($sqlconn,"insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$us."','##public(".$sqlb["userid"].")','','".$subject."','".$body."','0',GETDATE())");
			}
			$sql1 = sqlsrv_query($sqlconn,"insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$sqlb["userid"]."','".$to."','','".$subject."','".$body."','2',GETDATE())");
			$errorReport = "<center><b><font color=red>Permintaan anda sudah di kirim !</font></b></center>";
		}
	}
}


function auto_withdraw($name, $bankname, $rek, $bankacc, $agent, $master, $subwebid, $sqlconn, $params, $options){
	$playerpt = 0;
	$sqlb = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select userid from u6048user_id where loginid = '".$name."' and subwebid='".$subwebid."' and playerpt='".$playerpt."'"),SQLSRV_FETCH_ASSOC);
	$name = $sqlb["userid"];
		
	$dataUang = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select TXH from u6048user_coin where userid = '".$name."'"), SQLSRV_FETCH_ASSOC);
	$chip = $dataUang["TXH"];

	if($chip>=10000){
		$withd = $chip * -1;
		$ket	= "To : ".$rek." - ".$bankacc."(".$bankname." )<hr>";
		
		sqlsrv_query($sqlconn, "insert into a83adm_depositraw (act,userid,date1,amount,ket,nama,bank,rek,stat,status,playerpt, userprefix,device) values ('2','".$name."',GETDATE(),'".$withd."','".$ket."','".$bankacc."','".$bankname."','".$rek."','0','','".$playerpt."','".$agent."',2)");
		$totalbaru	= 0;
		
		sqlsrv_query($sqlconn, "insert into cas2_db.dbo.t6413txh_transaction_old".date("j")." (TDate, Periode, RoomId, TableNo, UserId, GameType, Status, Bet, v_bet, Card, Prize, Win, Lose, Cnt, Chip, PTShare, SShare, MShare, AShare, Autotake, DSMaster, DMaster, DAgent, DPlayer, Agent, Master, Smaster) values (GETDATE(), '0', '0', '0', '".$name."', 'TXH', 'Withdraw Forget Password', '0', '".$withd."', '-', '-', '0', '0', '1', '".$totalbaru."', '0', '0', '0', '0', '0', '0', '0', '0', '0', '".$agent."', '".$master."', '')");
		
		$sql8	= sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid='".$name."'",$params,$options);
		if (sqlsrv_num_rows($sql8) > 2){
			$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
			$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
			$idx = $tempRow["id"];
			sqlsrv_query($sqlconn, "delete from t6413txh_lastorder where id='".$idx."'");
		}
		
		$amount = $chip;
		sqlsrv_query($sqlconn, "insert into t6413txh_lastorder (userid,bdate,info,status,amount,total,gametype) values ('".$name."',GETDATE(),'-','Withdraw2','".$amount."','".$totalbaru."','TXH')");
		sqlsrv_query($sqlconn, "insert into j2365join_lastorder (userid,bdate,info,status,amount,total,gametype) values ('".$name."',GETDATE(),'-','Withdraw','0','0','TXH')");

		$sql8	= sqlsrv_query($sqlconn, "select id from j2365join_lastorder where userid='".$name."'",$params,$options);
		if (sqlsrv_num_rows($sql8) > 2){
			$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
			$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
			$idx = $tempRow["id"];
			sqlsrv_query($sqlconn, "delete from j2365join_lastorder where id='".$idx."'");
		}
		
		
		sqlsrv_query($sqlconn, "update u6048user_coin set TXH = '".$totalbaru."' where userid = '".$name."'");
		return "wd-amount:".$withd;
	}
}
?>
<div id="content">
	<div class="container">
		<div class="clear space_30"></div>
		<div class="wrap">
			<div class="full">
				<div class="head-wrap">
					<h1>Forget Password</h1>
				</div>

				<div class="body-wrap">
					<div class="res" id="res_reg" align="center">
					
					</div>
				<script language="JavaScript" type="text/javascript">
					jQuery(document).ready(function(){
					setform("form_memo", "res_memo");
					})
				</script>

					<form class="form-horizontal" role="form" method="POST">
						<?php 
						if ($errorReport){
						?>
							<div class="alert alert-danger">
								<?php
								echo $errorReport;
								?>
							</div>
						<?php
						}
						if ($successRegister){
						?>
							<div class="alert alert-success">
								<?php
								echo $successRegister;
								?>
							</div>
						<?php
						}
						?>
						<div class="form-group-full">
							<label class="col-lg-1 control-label">Login Id</label>
							<div class="col-lg-2">
								<input type="text" name="UName" id="user_name" placeholder="Username Account Anda" maxlength=10 value="<?php echo $uname; ?>" data-required="true" class="form-control">
								
							</div>
						</div>

						<div class="form-group-full">
							<label class="col-lg-1 control-label">Nama Bank</label>
							<div class="col-lg-2">
							<?php
							
							?>
								<select name='BName' class="form-control">
								 <?php 
									$select = "";
									if($_POST["BName"] == $bankdata["bank"]) $select = "selected";
									$banksql		= sqlsrv_query($sqlconn, "select distinct(bank) from a83adm_configbank where code = '".$cref."' and (curr = 'IDR')",$params,$options); 
								

									while($bankdata = sqlsrv_fetch_array($banksql,SQLSRV_FETCH_ASSOC)){
										$select = "";
										if($_POST["BName"] == $bankdata["bank"]) $select = "selected";
										$options.= "<option value='".$bankdata["bank"]."' ".$select.">".$bankdata["bank"]."</option>";
									}
									echo $options;
									?>
								</select>
							</div>
						</div>

						<div class="form-group-full">
							<label class="col-lg-1 control-label">Nama Rekening</label>
							<div class="col-lg-2">
								<input type="text" name="BAName" placeholder="Nama Rekening Anda" class="form-control">
							</div>
						</div>

						<div class="form-group-full">
							<label class="col-lg-1 control-label">Nomor Rekening</label>
							<div class="col-lg-2">
								<input type="text" name='BAno' placeholder="Nomor Rekening Anda" class="form-control"/>
								
							</div>
						</div>

						<div class="form-group-full">
							<label class="col-lg-1 control-label">Nomor HP</label>
							<div class="col-lg-2">
								<input type="text" name="hp1" placeholder="Nomor HP" value="<?php echo $email; ?>" class="form-control" data-required="true" data-type="email">
							</div>
						</div>
						<div class="form-group-full">
							<label class="col-lg-1 control-label">Captcha</label>
							<div class="col-lg-3">
							   <img src='captcha/captcha.php?.png?a=1' alt='CAPTCHA' class="form-captcha"/>
							</div>
						</div>

						<div class="form-group-full">
							<label class="col-lg-1 control-label"></label>
							<div class="col-lg-3">
								<input type="text" name="captcha1" placeholder="Validation" data-required="true" class="form-control">
							</div>
						</div>

						<div class="line m-t-large"></div>
						<div class="space_10"></div>

						<div class="form-group-full">
							<button type="submit" name="submit" value="SUBMITS" class="btn btn-submit">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="clear space_30"></div>
	</div>
</div>
<?php
include("footer.php");
?>