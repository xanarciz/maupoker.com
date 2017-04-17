<?php
$page='withdraw';
session_start();
$login = $_SESSION["login"];

if (!$login){
	include("_meta.php");
} else {
	include("_metax.php");
	$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userpass , bankname, bankaccno, bankaccname from u6048user_id where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
	$bankname = $sqlu["bankname"];
	$bankaccno = $sqlu["bankaccno"];
	$bankaccname = $sqlu["bankaccname"];
	if($bankaccno == null && $bankname == null && $bankaccname == null) {
		echo "<script>window.location = 'bank-setting.php'</script>";
		$_SESSION['urlPrev'] = 'withdraw.php';
		die();
	}

}
include("_header.php");

 //    if (!$_SESSION["login"]){
	// 	echo "<script>window.location = 'index.php'</script>";
	// 	die();
	// }

$sql3	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select curr,userprefix from u6048user_data where userid = '".$login."'"), SQLSRV_FETCH_ASSOC);
$curr	= $sql3["curr"];
$agent	= $sql3["userprefix"]; 
$sql5	= "select min_wdraw from u6048user_id where userid='".$agent."'";
$query5	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, $sql5), SQLSRV_FETCH_ASSOC);
$minwit	= $query5["min_wdraw"];

if($bankaccno == null && $bankname == null && $bankaccname == null) {
	echo "<script>window.location = 'bank-setting.php'</script>";
	$_SESSION['urlPrev'] = 'withdraw.php';
	die();
}
	
$query = sqlsrv_query($sqlconn,"select sqltable from a83adm_configgame");

while($row = sqlsrv_fetch_array($query,SQLSRV_FETCH_ASSOC)){		
	$sql1 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select Sit from ".$row['sqltable']."_usersit where Userid='".$login."'",$params,$options));
	
	if ($sql1 > 0){
		 $errorReport = " Failed Withdraw. Please logout the game first!";
		 $err = 1;
	}
	
}

	
	$sql1 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select inEBN, inBJK, inCAP, inWAR, inSAM from u6048user_coin where Userid='".$login."' AND (inEBN>0 OR inBJK>0 OR inCAP>0 OR inWAR>0 OR inSAM>0)",$params,$options));
	if ($sql1 > 0){
		 $success_withdraw = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Withdraw gagal.<br>Mohon Keluar Dari Game</p></div>";
		 $err = 1;
	}
	$sql3 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid='".$login."' and bdate > dateadd(minute,-1,GETDATE())",$params,$options));
	if ($sql3 > 0){
		 $success_withdraw = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Withdraw gagal.<br>Jangan Masuk ke game dan coba 5 Menit Kemudian</p></div>";
		 $err = 1;
	}
	if ($sqlu["status"] == 2 || $sqlu["status"] == 3){
		$success_withdraw =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Account anda masi dalam proses validasi.<br>Anda hanya bisa mengakses menu MEMO.</p></div>";
		 $err = 1;

	}else if ($sqlu["status"] == 4){

		$success_withdraw =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Account anda Bermasalah.<br> Harap hubungi customer support kami.</p></div>";
		$err = 1;

	}else if ($sqlu["status"] == 5){
		$success_withdraw =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Account anda masih dalam proses lupa password<br>sementara anda hanya bisa mengakses menu MEMO</p></div>";
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
			$amount		= str_replace('.','',$_POST["amount"]);
			$pass		= hash("sha256",md5($_POST["pass"]).'8080');

			$bankaccname = $sqlu["bankaccname"];
			$bankacc	= $bankaccname;
			$rek		= $bankaccno;
			$error = 0;
			$sqlm = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select maint from a83adm_config"), SQLSRV_FETCH_ASSOC);
			$maintenance = $sqlm["maint"];

			if ($maintenance == "1") {
				 $errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Connection Time out.</p></div>";
				 $err = 1;
				 die();
			}

			if ($amount == "" || $amount <= 0){
				$error	= 1;
				$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Withdraw failed.<br>Isi Jumlah Withdraw.</p></div>";
			}else if ($pass	== ""){
				$error	= 1;
				$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Withdraw failed.<br>Isi password.</p></div>";
			}

			if ($amount > 0){
			}else{
				$error	= 1;
				$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Gagal Withdraw.<br>isi Jumlah Withdraw.</p></div>";
			}

			$p = $sqlu["userpass"];
			

			if ($p != $pass){
				$error	= 1;
				$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Gagal Withdraw.<br>Password Salah.</p></div>";
			}

			$sql3	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select curr,userprefix from u6048user_data where userid = '".$name."'"), SQLSRV_FETCH_ASSOC);
			$curr	= $sql3["curr"];
			$agent	= $sql3["userprefix"];
			$balance	= $chip;

			$balancebaru	= $balance - $amount;

			if ($balancebaru < 0){
				$error	= 1;
				$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Gagal Withdraw.<br>Chip tidak cukup.</p></div>";
			}

			$email=$sqlu["email"];
			$playerpt=$sqlu["playerpt"];

			if ($playerpt == "1"){
				$sql5	= "select min_wdraw from a83adm_config";
			}else{
				$sql5	= "select min_wdraw,email from u6048user_id where userid='".$agent."'";
			}
			$query5	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, $sql5), SQLSRV_FETCH_ASSOC);
			$minwit	= $query5["min_wdraw"];

			if ($amount < $minwit){
				$error	= 1;
				$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Gagal Withdraw.<br>Minimum withdraw adalah ".$minwit."</p></div>";
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
			sqlsrv_query($sqlconn, "insert into a83adm_depositraw (act,userid,date1,amount,ket,nama,bank,rek,stat,status,playerpt, userprefix,device) values ('2','".$name."',GETDATE(),'".$withd."','".$ket."','".$bankacc."','".$bankname."','".$rek."','0','','".$playerpt."','".$agent."',1)");
			$totalbaru	= $balancebaru;

			sqlsrv_query($sqlconn, "insert into t6413txh_transaction (TDate, Periode, RoomId, TableNo, UserId, GameType, Status, Bet, v_bet, Card, Prize, Win, Lose, Cnt, Chip, PTShare, SShare, MShare, AShare, Autotake, DSMaster, DMaster, DAgent, DPlayer, Agent, Master, Smaster) values (GETDATE(), '0', '0', '0', '".$name."', 'TXH', 'Withdraw', '0', '".$withd."', '-', '-', '0', '0', '1', '".$totalbaru."', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '')");

			$sql8	= sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid='".$name."'",$params,$options);
			if (sqlsrv_num_rows($sql8) > 2){
				$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
				$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
				$idx = $tempRow["id"];
				sqlsrv_query($sqlconn, "delete from t6413txh_lastorder where id='".$idx."'");
			}


			sqlsrv_query($sqlconn, "insert into t6413txh_lastorder (userid,bdate,info,status,amount,total,gametype) values ('".$name."',GETDATE(),'-','Withdraw','".$amount."','".$totalbaru."','TXH')");
			sqlsrv_query($sqlconn, "insert into j2365join_lastorder (userid,bdate,info,status,amount,total,gametype) values ('".$name."',GETDATE(),'-','Withdraw','0','0','TXH')");

			$sql8	= sqlsrv_query($sqlconn, "select id from j2365join_lastorder where userid='".$name."'",$params,$options);
			if (sqlsrv_num_rows($sql8) > 2){
				$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
				$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
				$idx = $tempRow["id"];
				sqlsrv_query($sqlconn, "delete from j2365join_lastorder where id='".$idx."'");
			}


			sqlsrv_query($sqlconn, "update u6048user_coin set TXH = '".$balancebaru."' where userid = '".$name."'");

			//$success_withdraw = "<div class='error-report'>Withdraw Berhasil.<br> Permintaan withdraw anda akan di proses dalam 1x24 jam .</div><div class='clear extra_spaces'></div>";
            $success_withdraw = "<div class='big-notification green-notification'>
                                <h3 class='uppercase'>Withdraw Berhasil</h3>
                                <a href='#' class='close-big-notification'>x</a>
                                <p>Permintaan withdraw anda akan di proses dalam 1x24 jam.</p>
                            </div>";

			}
			echo"<BR>";

		}
	}
?>

<div class="content-2" data-id="withdraw" id="page">
	<div class="lpadding-15 tpadding-5">
		<label class="fs-13 tmargin-10 ntf"><?PHP if($_SESSION["login"]) echo "FORM "; ?>WITHDRAW</label>
	</div>

	<?php
		if($_SESSION["login"]){

			$dataUang = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select txh from u6048user_coin where userid = '".$login."'"), SQLSRV_FETCH_ASSOC);

			if ($success_withdraw){
				echo $success_withdraw;
			}else{
				if ($error == 1){
					echo $errorReport;
				}
	?>

	<hr class="margin-0 bg-brown-panel" style="margin: 0px -15px 0px -15px;" />
	<form method="post" class="padding-10">

		<div class="row margin0">
			<div class="col-lg-4">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10">USER ID</label>
			</div>
			<div class="col-lg-1">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
			</div>
			<div class="col-lg-7">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> <?php echo $login; ?> </label>
			</div>
		</div>
		<div class="row margin0">
			<div class="col-lg-4">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10">CHIPS</label>
			</div>
			<div class="col-lg-1">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
			</div>
			<div class="col-lg-7">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> IDR <?php echo number_format($dataUang["txh"]);?> </label>
			</div>
		</div>

		<label class="black fs-13 pull-left tmargin-10">Jumlah Penarikan</label>
		<div class="row">
			<div class="col-lg-11">
				<input class="form-control bg-light-gray" name="ui_amount" id="ui_amount" placeholder="Masukan jumlah penarikan dana" />
				<input type="hidden" name="amount" id="amount"/>
			</div>
			<div class="col-lg-1 text-left">
				<label class="black tmargin-10 lmargin-5">IDR</label>
			</div>
		</div>
		<div class="row">
			<label class="black fs-13 fs-normal  tmargin-10">Password</label>
			<input class="form-control bg-light-gray" type="password" name="pass" id="pass" placeholder="Masukan Password Login Anda" />
		</div>

		<div class="row margin0">
			<label class="black fs-13 text-left tmargin-10">Dana akan di kirim ke:</label>
			<div class="col-lg-4">
				<label class="black fs-13 fs-normal tmargin-10">Nama Bank</label>
			</div>
			<div class="col-lg-1 ">
				<label class="black fs-13 fs-normal tmargin-10"> : </label>
			</div>
			<div class="col-lg-7">
				<label class="black fs-13 fs-normal tmargin-10"> <?php echo $bankname;?> </label>
			</div>
		</div>

		<div class="row margin0">
			<div class="col-lg-4">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10">Nama Rekening</label>
			</div>
			<div class="col-lg-1">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
			</div>
			<div class="col-lg-7">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> <?php echo $bankaccname;?> </label>
			</div>
		</div>

		<div class="row margin0">
			<div class="col-lg-4">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10">Nomor Rekening</label>
			</div>
			<div class="col-lg-1">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
			</div>
			<div class="col-lg-7">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10">
					<?php
						if($bankname == "BCA"){
							echo substr($bankaccno,0,8)."xxxx";
						}else{
							echo substr($bankaccno,0,8)."xxx-xxxx";
						}
					?>
				</label>
			</div>
			
		</div>

		<div class="row">
			<input class="btn btn-gray tmargin-10 bmargin-5" value="BATAL" type="button" onclick="location.href='index.php'" />
		</div>
		<div class="row">
			<input class="btn btn-blue tmargin-5 bmargin-10" value="KONFIRMASI" type="submit" name="submit" />
		</div>
		<ol class="black">
			<li class="margin-0">Minimal Tarik Dana = <?php echo $minwit; ?>,00 IDR .</li>
			<li class="margin-0">Penarikan dana hanya akan di proses ke rekening yang pertama kali di daftarkan. </li>
			<li class="margin-0">Setelah proses pengisian form Penarikan dana selesai maka pengiriman dana akan di proses secepatnya ke dalam rekening terdaftar anda. </li>
			<li class="margin-0">etelah melakukan proses pengiriman dan mengisi form secara benar maka Withdraw anda akan di proses dalam kurun waktu 5 menit. </li>
			<li class="margin-0">Silahkan hubungin customer service kami via live chat untuk konfirmasi status penarikan dana anda. </li>
		</ol>

	    <div class="toggle-1 bmargin-15" style="z-index: 9998; background: #d7d7d7; border-radius: 5px;">
	        <a href="#" class="deploy-toggle-1 toggle-design bg-brown-panel br-5">
	            <label class="ntf fs-13">
		            Jadwal Bank Offline
					<img src="img/<?PHP echo $link_img;?>/icons/br_down.png" class="pull-right btn-down"/>
					<img src="img/<?PHP echo $link_img;?>/icons/br_up.png" class="pull-right btn-up" style="display: none;" />
				</label>
	        </a>
	        <div class="toggle-content bank-offline-content br-5" style="display: none; background: #d7d7d7 !important;">

				<div class="row padding-10">
					<div class="row">
						<div class="col-lg-3 tpadding-10">
							<img class="img-fluid tmargin-10" src="img/banks/bca.png">
						</div>
						<div class="col-lg-9 lpadding-10">
							<p class="fs-11" style="border:none; color: #000 !important;">
								Senin-Jumat	: 21.00 - 00.30 WIB <br/>
								Sabtu			: 18.00 - 20.00 WIB<br/>
								Minggu			: 00.00 - 06.00 WIB<br/>
							</p>
						</div>	
					</div>

					<div class="row">
						<div class="col-lg-3 tpadding-15">
							<img class="img-fluid tmargin-10" src="img/banks/mandiri.png">
						</div>
						<div class="col-lg-9 lpadding-10">
							<p class="fs-11" style="border:none; color: #000 !important;">
								Senin - Jumat	: 23.00 - 04.00 WIB<br/>
								Sabtu - Minggu	: 22.00 - 06.00 WIB
							</p>
						</div>	
					</div>

					<div class="row">
						<div class="col-lg-3">
							<img class="img-fluid tmargin-10" src="img/banks/bni.png">
						</div>
						<div class="col-lg-9 lpadding-10">
							<p class="fs-11" style="border:none; color: #000 !important;">
								Senin - Minggu	: 00:00 - 02:30  WIB
							</p>
						</div>	
					</div>

					<div class="row">
						<div class="col-lg-3">
							<img class="img-fluid tmargin-10" src="img/banks/bri.png">
						</div>
						<div class="col-lg-9 lpadding-10">
							<p class="fs-11" style="border:none; color: #000 !important;">
								Senin - Minggu	: 21:00 - 05:30 WIB
							</p>
						</div>	
					</div>
				</div>

	        </div>
	    </div>

	</form>


	<script language="JavaScript" type="text/javascript">
		jQuery(document).ready(function(){
			setform("form_wd", "res_wd");
			jQuery("#amount").focus().priceFormat();
		})

		$( ".deploy-toggle-1" ).click(function() {
			if ( $('.toggle-content').css('display') != 'block' ) {
				$('.btn-up').css('display', 'block');
				$('.btn-down').css('display', 'none');
			}else{
				$('.btn-up').css('display', 'none');
				$('.btn-down').css('display', 'block');		
			}
		});
	</script>

	<?PHP
			}
		}else{
	?>

	<div class="padding-10">
		<div class="alert alert-warning text-left bmargin-10">
			<div class="row">
				<div class="col-lg-1 bpadding-10">
					<i class="fa fa-info-circle fa-2x rmargin-10"></i>
				</div>
				<div class="col-lg-11 lpadding-5">
					<p class="fs-bold"> Silahkan LOGIN terlebih dahulu
						untuk melalukan withdraw</p>
				</div>

				<hr class="margin-0 bmargin-5">
				<ol>
					<li class="margin-0">Penarikan Dana hanya akan di proses ke rekening yang pertama Anda daftarkan.</li>
					<li class="margin-0">Minimum penarikan dana Rp<?php echo $minwit; ?></li>
					<li class="margin-0">Setelah melakukan pengisian form withdraw dengan benar, maka penarikan dana akan di proses secepetnya ke rekening terdaftar Anda.</li>
				</ol>
			</div>
		</div>

		<label class="ntf fs-13">
			Metode Withdraw Bank:
		</label>
		<div class="row tmargin-5 rpadding-5 bmargin-10">
			<div class="col-lg-3 rpadding-10">
				<img class="img-fluid" src="img/banks/bca.png">
			</div>
			<div class="col-lg-3 rpadding-10">
				<img class="img-fluid" src="img/banks/mandiri.png">
			</div>
			<div class="col-lg-3 rpadding-10">
				<img class="img-fluid" src="img/banks/bni.png">
			</div>
			<div class="col-lg-3 rpadding-10">
				<img class="img-fluid" src="img/banks/bri.png">
			</div>
		</div>
		<!--
		<label class="ntf fs-13">
			Metode Withdraw Alternatif:
		</label>
		<div class="row tmargin-5 bmargin-15">
			<div class="col-lg-5">
				<img class="img-fluid" src="img/banks/v88.png"/>
			</div>
		</div>
		-->

		<div class="row bg-brown-panel padding-10 br-5">
			<label class="ntf fs-13">
				Jadwal Bank Offline
			</label>
			<div class="row tmargin-10">
				<div class="col-lg-3">
					<img class="img-fluid tmargin-10" src="img/banks/bca.png">
				</div>
				<div class="col-lg-9 lpadding-10">
					<p class="dark-gray fs-11" style="border:none;">
						Senin - Jumat	: 21:00 - 00:30 WIB <br/>
						Sabtu			: Tidak ada Offline<br/>
						Minggu			: 00:00 - 06:00 WIB<br/>
					</p>
				</div>	
			</div>

			<div class="row">
				<div class="col-lg-3">
					<img class="img-fluid tmargin-10" src="img/banks/mandiri.png">
				</div>
				<div class="col-lg-9 lpadding-10 tmargin-10">
					<p class="dark-gray fs-11" style="border:none;">
						Senin - Minggu	: 23:00 - 05:00 WIB<br/>
					</p>
				</div>	
			</div>

			<div class="row tmargin-10">
				<div class="col-lg-3">
					<img class="img-fluid tmargin-10" src="img/banks/bni.png">
				</div>
				<div class="col-lg-9 lpadding-10 tmargin-10">
					<p class="dark-gray fs-11" style="border:none;">
						Senin - Minggu	: 00:00 - 02:30 WIB<br/>
					</p>
				</div>	
			</div>

			<div class="row tmargin-10">
				<div class="col-lg-3">
					<img class="img-fluid tmargin-10" src="img/banks/bri.png">
				</div>
				<div class="col-lg-9 lpadding-10 tmargin-10">
					<p class="dark-gray fs-11" style="border:none;">
						Senin - Minggu	: 21:00 - 05:30 WIB
					</p>
				</div>	
			</div>
		</div>


	<?PHP
		}
	?>
		<div style="padding-bottom: 75px;"></div>
</div>

<script type="text/javascript">
	function numberWithCommas(x) {
	  return x.toString().replace(/\B(?=(?:\d{3})+(?!\d))/g, ",");
	}

	$('#ui_amount').keyup(function() {
	  var isi = $(this).val();
	  var res = isi.split(",");
	  var finalres = "";
	  
	  for(var a=0; a<res.length; a++){
	  	finalres += res[a];
	  }

	  $(this).val(numberWithCommas(finalres))
		$('#amount').val(finalres);
	})
</script>

<?php include ("_footer.php"); ?>