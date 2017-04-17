<?php
$freePage=true;
include("meta.php");
include("header.php");

if (!$_SESSION["login"]){
	$flag = 'withdraw';
	include('ketdpwd.php');
	include('footer.php');
	die();
}

$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select bankname, bankaccno, bankaccname from u6048user_id where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
$bankname = $sqlu["bankname"];
$bankaccno = $sqlu["bankaccno"];
$bankaccname = $sqlu["bankaccname"];

if($bankaccno == null && $bankname == null && $bankaccname == null) {
	echo "<script>window.location = 'bank-setting.php'</script>";
	$_SESSION['urlPrev'] = 'withdraw.php';
	die();
}
	
function currx($val) {
if (!strpos($val,".")) return number_format($val, 0,'.', ',');
else return number_format($val, 1,'.', ',');
}
$sql1 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select amount from a83adm_depositraw where stat='0' AND act='2'",$params,$options));
/*$sqlc = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select withdraw_ctrl, withdraw_text from a83adm_config2"), SQLSRV_FETCH_ASSOC);
if ($sql1 >= $sqlc["withdraw_ctrl"]){
	 $success_withdraw = "<div class='error-report'>$sqlc[withdraw_text]</div>";
	 $err = 1;
}*/
$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userpass, bankname, bankaccno, bankaccname, bankgrup,playerpt,xdeposit from u6048user_id where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
$query = sqlsrv_query($sqlconn,"select sqltable from a83adm_configgame");

while($row = sqlsrv_fetch_array($query,SQLSRV_FETCH_ASSOC)){		
	$sql1 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select Sit from ".$row['sqltable']."_usersit where Userid='".$login."'",$params,$options));
	
	if ($sql1 > 0){
		 $errorReport = " Failed Withdraw. Please logout the game first!";
		 $err = 1;
	}
	
}

	
	$sql1 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select inEBN, inBJK, inCAP, inWAR, inSAM from u6048user_coin where Userid='".$login."' AND (inEBN>0 OR inBJK>0 OR inCAP>0 OR inWAR>0 OR inSAM>0 OR inBTM>0)",$params,$options));
	if ($sql1 > 0){
		 $success_withdraw = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Withdraw gagal.<br>Mohon Keluar Dari Game</p></div>";
		 $err = 1;
	}
	

$sql3 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid='".$login."' and bdate > dateadd(minute,-1,GETDATE())",$params,$options));	
if ($sql3 > 0){
	 $success_withdraw = "<div class='error-report'>Cannot withdraw.<br>Don't enter the game and try again 5 minutes later </div>";
	 $err = 1;
}

if (!$err){
	$firstdepo = 1;
	$sqlcektrans = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from a83adm_moneyhistory where userid = '".$login."'",$params,$options));
	if ($sqlcektrans > 0) {
		$firstdepo = 0;
	}else {
		$sqlcektrans2 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from a83adm_deposit where userid = '".$login."'"));
		if ($sqlcektrans2 > 0) {
			$firstdepo = 0;
		}
	}
	
	$sqlmaxdepo = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select first_max_depo, max_depo from a83adm_config2"), SQLSRV_FETCH_ASSOC);
	$maxdepo = $sqlmaxdepo["first_max_depo"];
	$maxdepo2 = $sqlmaxdepo["max_depo"];
	
	$dataUang = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select TXH from u6048user_coin where userid = '".$login."'"), SQLSRV_FETCH_ASSOC);
	$chip = $dataUang["TXH"];
	if ($_POST["submit"]) {
		$name		= $login;
		//$amount		= substr(str_replace('.','',$_POST["amount"]),4);
		$amount		= $_POST["amount"];
		$pass		= hash("sha256",md5($_POST["pass"]).'8080');
		$capt		= $_POST["captcha"];
		$bankaccname = $sqlu["bankaccname"];
		$bankacc	= $bankaccname;
		$rek		= $bankaccno;
		$error = 0;
		$sqlm = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select maint from a83adm_config"), SQLSRV_FETCH_ASSOC);
		$maintenance = $sqlm["maint"];
		if ($maintenance == "1") {
			 $errorReport = "<div class='error-report'>Connection Time out.</div>";
			 $err = 1;
			 die();
		}
		if ($capt != $_SESSION['CAPTCHAString']){
			$errorReport =  "<div class='error-report'>Validasi anda salah.</div>";
			$err = 1;
		}
		if ($amount == "" || $amount <= 0){
			$error	= 1;
			$errorReport =  "<div class='error-report'>Withdraw failed.<br>Please fill amount.</div>";
		}else if ($pass	== ""){
			$error	= 1;
			$errorReport =  "<div class='error-report'>Withdraw failed.<br>isi password.</div>";
		}
	
		if ($amount > 0){
		}else{
			$error	= 1;
			$errorReport =  "<div class='error-report'>Gagal Withdraw.<br>isi amount.</div>";
		}

		$p = $sqlu["userpass"];
	
		if ($p != $pass){
			$error	= 1;
			$errorReport =  "<div class='error-report'>Gagal Withdraw.<br>Password Salah.</div>";
		}
	
		$sql3	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select curr,userprefix from u6048user_data where userid = '".$name."'"), SQLSRV_FETCH_ASSOC);
		$curr	= $sql3["curr"];
		$agent	= $sql3["userprefix"];
		$balance	= $chip;
		
		$balancebaru	= $balance - $amount;
	
		if ($balancebaru < 0){
			$error	= 1;
			$errorReport =  "<div class='error-report'>Gagal Withdraw.<br>Balance not enough.</div>";
		}
		$email=$sqlu["email"];
		$playerpt=$sqlu["playerpt"];
		
		if ($playerpt == "1"){
			$sql5	= "select min_wdraw from a83adm_config";
		}else{
			$sql5	= "select min_wdraw,max_wdraw,email from u6048user_id where userid='".$agent."'";
		}
		$query5	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, $sql5), SQLSRV_FETCH_ASSOC);
		$minwit	= $query5["min_wdraw"];
		$maxwit	= $query5["max_wdraw"];

		if ($amount < $minwit){
			$error	= 1;
			$errorReport =  "<div class='error-report'>Gagal Withdraw.<br>Minimum withdraw adalah ".currx($minwit)."</div>";
		}
			if ($amount > $maxwit){
			$error	= 1;
			$errorReport =  "<div class='error-report'>Gagal Withdraw.<br>Maksimal withdraw adalah ".currx($maxwit)."</div>";
		}
		if ($error == 0) {
		$ket	= "To : ".$bankacc." - ".$rek."(".$bankname." )<hr>";
		$tp 	= "";
		$axx	= 0;
		for($i=0; $i<2; $i++){
			$temp	= substr($rek, $axx, 4);
			if ($tp == ""){
				$tp	= $temp;
			}else{
				$tp	= $tp ."-".$temp;
			}
			$axx	= 4;
		}
		$panj	= strlen($rek);
		$temt	= substr($rek, 8,$panj);
		$rot	= $tp."-".$temt;
		
		$sekarang	= Date("d M Y");
		
		$to1 = "== WITHDRAW, SLIP untuk Agent ==";
		$to1 .= "<BR> (Memo ini dikirim otomatis, berkaitan dengan penarikan dana.)";
		$to1 .= "<BR> Tanggal : ".$sekarang ;
		$to1 .= "<BR> Username : ".$name;
		$to1 .= "<BR> E-mail : ".$email ;
		$to1 .= "<BR> Jumlah : ".$amount." ";
		$to1 .= "<BR> Bank : ".$bankname ;
		$to1 .= "<BR> Nama rekening : ".$bankacc ;
		$to1 .= "<BR> No. rekening : ".$rot ;
		$to1 .= "<BR> ";
		
		$subject = "#--WITHDRAW--# ".$amount;
		if ($playerpt == 1){
			$sql_1	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select bmemo from a83adm_config"), SQLSRV_FETCH_ASSOC);
			$userx	= $sql_1["bmemo"]."";
			$nama	= explode(",",$userx);
			sqlsrv_query($sqlconn, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('*,".$userx.",*','".$name."','','".$subject."','".$to1."','0',GETDATE())");
		}else
			sqlsrv_query($sqlconn, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$agent."','".$name."','','".$subject."','".$to1."','0',GETDATE())");

		$to2 = "== WITHDRAW, SLIP untuk member ==";
		$to2 .= "<BR> (Memo ini dikirim otomatis, berkaitan dengan penarikan dana.)";
		$to2 .= "<BR> Tanggal : ".$sekarang ;
		$to2 .= "<BR> Username : ".$name." ";
		$to2 .= "<BR> E-mail : ".$email ;
		$to2 .= "<BR> Jumlah : " .$amount." ";
		$to2 .= "<BR> Bank : ".$bankname;
		$to2 .= "<BR> Nama rekening : ".$bankacc ;
		$to2 .= "<BR> No. rekening : ".$rot;
		$to2 .= "<BR> ";
		$to2 .= "Permintaan penarikan dana sudah diterima.";

		sqlsrv_query($sqlconn, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$name."','billing','','#--WITHDRAW--#','".$to2."','0',GETDATE())");
		$amountx = $amount;
		$withd	= $amountx * -1;

			$fuser = substr($login, 0,1);
			$sql2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select val from a83adm_config3 where name='wdgrupconfig'",$params,$options),SQLSRV_FETCH_NUMERIC);
			$_group = explode("#", $sql2[0]);
			for ($_g=0; $_g<count($_group); $_g++){
				if (ereg(",".$fuser.",",$_group[$_g])) {
					$mgrup = ($_g + 1);
					break;
				}
			}
			
		require_once 'mobile_detect.php';
		$detect = new Mobile_Detect;
		$check_mobile = $detect->isMobile();
		$check_tablet = $detect->isTablet();
		$mobile = 2;
		if($check_mobile == 1 || $check_tablet == 1){
			$mobile = 1;
		}
			
		sqlsrv_query($sqlconn, "insert into a83adm_depositraw (act,userid,date1,amount,ket,nama,bank,rek,stat,status,playerpt, userprefix, device) values ('2','".$name."',GETDATE(),'".$withd."','".$ket."','".$bankacc."','".$bankname."','".$rek."','0','','".$playerpt."','".$agent."',".$mobile.")");
		$totalbaru	= $balancebaru;
		
		sqlsrv_query($sqlconn, "insert into ".$db2.".dbo.t6413txh_transaction_old".date("j")." (TDate, Periode, RoomId, TableNo, UserId, GameType, Status, Bet, v_bet, Card, Prize, Win, Lose, Cnt, Chip, PTShare, SShare, MShare, AShare, Autotake, DSMaster, DMaster, DAgent, DPlayer, Agent, Master, Smaster) values (GETDATE(), '0', '0', '0', '".$name."', 'TXH', 'Withdraw', '0', '".$withd."', '-', '-', '0', '0', '1', '".$totalbaru."', '0', '0', '0', '0', '0', '0', '0', '0', '0', '".$agentwlable."', '".$masterwlable."', '')");
		
		$sql8	= sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid='".$name."'",$params,$options);
		if (sqlsrv_num_rows($sql8) > 2){
			$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
			$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
			$idx = $tempRow["id"];
			sqlsrv_query($sqlconn, "delete from t6413txh_lastorder where id='".$idx."'");
		}
		
		
		sqlsrv_query($sqlconn, "insert into t6413txh_lastorder (userid,bdate,info,status,amount,total,gametype) values ('".$name."',GETDATE(),'-','Withdraw2','".$amount."','".$totalbaru."','TXH')");
		sqlsrv_query($sqlconn, "insert into j2365join_lastorder (userid,bdate,info,status,amount,total,gametype) values ('".$name."',GETDATE(),'-','Withdraw','0','0','TXH')");

		$sql8	= sqlsrv_query($sqlconn, "select id from j2365join_lastorder where userid='".$name."'",$params,$options);
		if (sqlsrv_num_rows($sql8) > 2){
			$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
			$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
			$idx = $tempRow["id"];
			sqlsrv_query($sqlconn, "delete from j2365join_lastorder where id='".$idx."'");
		}
		
		
		sqlsrv_query($sqlconn, "update u6048user_coin set TXH = '".$balancebaru."' where userid = '".$name."'");
		
		$success_withdraw = "<div class='error-report'>Withdraw Berhasil.<br> Permintaan withdraw anda akan di proses dalam 1x24 jam .</div>";

		}
		echo"<BR>";
		
	}
}
?>
			<div id="content">
                <div class="container">
					
                    <div class="clear space_30"></div>

                    <div class="wrap">
                        <div class="full">
							<?php
								if ($register == 4){
								?>
								<script>
									document.write("<iframe src="+j_withdraw+" width=800 height=700></iframe>");
								</script>
							<?php
							}else{
							?>
							<div class="head-wrap">
                                <h1>Withdraw</h1>
                            </div>

                            <div class="body-wrap">
                                <form class="form-horizontal" role="form" method="post">
                                   <?php 
									if ($errorReport){
									?>
										<div class="alert alert-danger">
											<?php
											echo $errorReport;
											?>
										</div>
									<?php
									}else if ($success_withdraw){
									?>
										<div class="alert alert-success">
											<?php
											echo $success_withdraw;
											?>
										</div>
									<?php
									}
									?>

									<?php
										$conf_depo = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select max_depo , min_depo , min_wdraw , max_wdraw FROM u6048user_id WHERE userid = '".$agentwlable."'"),SQLSRV_FETCH_ASSOC);
									?>
									
									<center><font size="3" color="#FF0000">MAX WITHDRAW <?php echo number_format ($conf_depo['max_wdraw']); ?></font></center>
									<center><font size="3" color="#FF0000">MIN WITHDRAW <?php echo number_format ($conf_depo['min_wdraw']); ?></font></center>

                                    <div class="space_20"></div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">User ID</label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7 normal"><?php echo $user_login." ( ".$login." )";?></div>
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Password</label>
                                        <div class="col-lg-2">
                                            <input type="password" name="pass" id="pass" placeholder="Password Account Anda" class="form-control">
                                        </div>
                                    </div>
									
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Bank</label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7 normal"><?php echo $bankname;?></div>
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nomor Rekening</label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7 normal"><?php echo substr($bankaccno,0,4)."xxxx";?></div>
                                        </div>
                                    </div>
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Jumlah</label>
                                        <div class="col-lg-2">
                                            <input type="text" name="amount" placeholder="Jumlah Withdraw" data-required="true" class="form-control">
                                        </div>
                                    </div>

                                    <div class="space_20"></div>

                                    <!-- <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Note</label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7">
                                                <p>Untuk kenyamanan anda dapat melakukan konfirmasi ulang <br /> kepada operator kami melalui fasilitas chatting</p>
                                                <div class="space_10"></div>
                                                <p class="attention">Jika anda gagal melakukan withdraw, silakan coba 1-2 menit lagi <br /> (sementara jangan duduk dalam meja permainan)</p>
                                            </div>
                                        </div>
                                    </div> -->

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Saldo terakhir</label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7 normal"><?php echo floor($coin);?></div>
                                        </div>
                                    </div>

									<div class="space_20"></div>
									
									 <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Validasi</label>
                                        <div class="col-lg-3">
                                            <img src='captcha/captcha.php?.png?a=1' alt='CAPTCHA' class="form-captcha"/>	
                                        </div>
                                    </div>
                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label"></label>
                                        <div class="col-lg-3">
                                            <input type="text" name="captcha" placeholder="Validation" data-required="true" class="form-control">
                                        </div>
                                    </div>
                                    <div class="line m-t-large"></div>
                                    <div class="space_10"></div>
									

                                    <div class="form-group-full">
                                        <button type="submit" name="submit" value="submit" class="btn btn-submit">Kirim</button>
                                    </div>
                                </form>
                            </div>
							<?php } ?>
                        </div>
                    </div>
                    <div class="clear space_30"></div>
                </div>
            </div>
<?php
include("footer.php");
?>