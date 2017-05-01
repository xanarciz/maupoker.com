<?php
$page='deposit'; 
session_start();
$login = $_SESSION["login"];

if (!$login){
	include("_meta.php");
} else {
	include("_metax.php");
	$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select bankname, bankaccno, bankaccname from u6048user_id where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
	$bankname = $sqlu["bankname"];
	$bankaccno = $sqlu["bankaccno"];
	$bankaccname = $sqlu["bankaccname"];
	if($bankaccno == null && $bankname == null && $bankaccname == null) {
		echo "<script>window.location = 'bank-setting.php'</script>";
		$_SESSION['urlPrev'] = 'deposit.php';
		die();
	}
}

include("_header.php");

function get_client_ip() {
    $ipaddress = '';
    if (getenv('HTTP_CLIENT_IP'))
        $ipaddress = getenv('HTTP_CLIENT_IP');
    else if(getenv('HTTP_X_FORWARDED_FOR'))
        $ipaddress = getenv('HTTP_X_FORWARDED_FOR');
    else if(getenv('HTTP_X_FORWARDED'))
        $ipaddress = getenv('HTTP_X_FORWARDED');
    else if(getenv('HTTP_FORWARDED_FOR'))
        $ipaddress = getenv('HTTP_FORWARDED_FOR');
    else if(getenv('HTTP_FORWARDED'))
       $ipaddress = getenv('HTTP_FORWARDED');
    else if(getenv('REMOTE_ADDR'))
        $ipaddress = getenv('REMOTE_ADDR');
    else
        $ipaddress = 'UNKNOWN';
    return $ipaddress;
}
// if (!$_SESSION["login"]){
// 		echo "<script>window.location = 'index.php'</script>";
// 		die();
// 	}

$sql1 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select amount from a83adm_depositraw where userid='".$login."' and stat='0' AND act='1'"), SQLSRV_FETCH_ASSOC);
if ($sql1["amount"] > 0){
		 $success_deposit =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Tidak Dapat melakukan deposit,<br> anda masih memiliki 1 deposit yang sedang di proses</p></div>"; //<div style='height:680px;'></div>
		 $err = 1;
		}

		if ($sqlu["status"] == 2 || $sqlu["status"] == 3){
			$success_deposit =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Account anda masi dalam proses validasi.<br>Anda hanya bisa mengakses menu MEMO.</p></div>";
			$err = 1;

		}else if ($sqlu["status"] == 4){

			$success_deposit =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Account anda Bermasalah.<br> Harap hubungi kami.</p></div>";
			$err = 1;

		}else if ($sqlu["status"] == 5){
			$success_deposit =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Account anda masih dalam proses lupa password<br>sementara anda hanya bisa mengakses menu MEMO</p></div>";
			$err = 1;
		}

	//$sqlbank = mssql_fetch_array(mssql_query("select bankname, bankaccno, bankaccname, bankgrup from u6048user_id where userid ='".$login."'"));
		$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select bankname, bankaccno, bankaccname, bankgrup,playerpt,xdeposit from u6048user_id where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
		$bankname = $sqlu["bankname"];
		$bankaccno = $sqlu["bankaccno"];
		$bankaccname = $sqlu["bankaccname"];
		$bankgrup = $sqlu["bankgrup"];
		$playerpt	= $sqlu["playerpt"];
		$xdepo = $sqlu["xdeposit"];
		
		$sqlg = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select val from a83adm_config3 where name = 'xdeposit_pertama'"),SQLSRV_FETCH_ASSOC);

		$xfirst = $sqlg["val"];
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
		$firstdepo = 1;

		if ($xdepo > $xfirst) {
			$firstdepo = 0;
		}
		$sqlmaxdepo = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select first_max_depo, max_depo from a83adm_config2"), SQLSRV_FETCH_ASSOC);
		$maxdepo = $sqlmaxdepo["first_max_depo"];
		$maxdepo2 = $sqlmaxdepo["max_depo"];

		if ($_POST["submit"] && !$err) {
			$name = $login;

			$amount		= str_replace('.','',$_POST["amount"]);
			$waktu		= $_POST["ttgl"]."-".$_POST["tmon"]."-".$_POST["tyear"];
		//$time		= $_POST["tjam"];
			$accname1	= $bankaccname;
			$rek1		= $bankaccno;
			$bname1		= $bankname;
		/*$accname2	= $_POST["hBAcc"];
		$rek2		= $_POST["hBNo"];
		$bname2		= $_POST["tBName"];*/
		//$remark		= $_POST["remark"];
		$capt		= $_POST["captcha1"];
		$time = date("d/m h:i");
		$remark = "Deposit";

		$databank = explode(",",$_POST["data-bank"]);
		$bname2		= $databank[0];
		$rek2		= $databank[1];
		$accname2	= $databank[2];
		$condition	= $databank[3];


		if ($remark == "Others")
			$remark = "Others";
		else
			$remark = "Deposit";

		$err = 0;

		$sqlm = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select maint from a83adm_config"), SQLSRV_FETCH_ASSOC);
		$maintenance = $sqlm["maint"];

		if ($maintenance == "1") {
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Connection Timeout.</p></div>";
			$err = 1;
			die();
		}
		if ($capt != $_SESSION['CAPTCHAString']){
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Validasi anda salah.</p></div>";
			$err = 1;
		}else if ($amount == "" || $amount <= 0){
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal<br>Isi jumlah deposit.</p></div>";
			$err = 1;
		}/*else if ($waktu == ""){
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal<br>Isi tanggal deposit.</p></div>";
			$err = 1;
		}*/else if ($time == ""){
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal<br>Isi waktu pengiriman deposit.</p></div>";
			$err = 1;
		}else if ($accname1 == ""){
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal<br>Isi nama account</p></div>";
			$err = 1;
		}else if ($rek1 == ""){
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal<br>Isi nomor rekening</p></div>";
			$err = 1;
		}else if ($bname1 == ""){
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal<br>Isi nama bank</p></div>";
			$err = 1;
		}else if ($accname2 == ""){
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal<br>Harap memilih bank tujuan</p></div>";
			$err = 1;
		}else if ($rek2 == ""){
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal<br>Harap memilih bank tujuan</p></div>";
			$err = 1;
		}else if ($bname2 == ""){
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal<br>Harap memilih bank tujuan</p></div>";
			$err = 1;
		}else if ($remark == ""){
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal<br>pilih keterangan.</p></div>";
			$err = 1;
		}else if ($amount > $maxdepo2){
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal<br>Maksimum adalah $maxdepo2.</p></div>";
			$err = 1;
		}

		if ($amount > 0){
		}else{
			$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal<br>isi jumlah deposit.</p></div>";
			$err = 1;
		}

		if ($err == 0) {
			$ket	= "From : ".$accname1." - ".$rek1." ( ".$bname1." ) <br>";
			//$ket = $remark;
			$tgl	= $waktu;

			$email=$sqlu["email"];
			$playerpt=$sqlu["playerpt"];
			if ($sqlu["status"] == 2){
				$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal.</p></div>";
				$err = 1;
			}

			$sql3	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select curr,userprefix from u6048user_data where userid = '".$name."'"), SQLSRV_FETCH_ASSOC);
			$curr=$sql3["curr"];
			$agent=$sql3["userprefix"];
			$kalikan = 1;
			
			if ($playerpt == "1"){
				$sql5	= "select min_wdraw from a83adm_config";
			}else{
				$sql5	= "select min_depo,max_depo,email from u6048user_id where userid='".$agent."'";
			}
			
			$sql6	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, $sql5), SQLSRV_FETCH_ASSOC);

			$mindep = $sql6["min_depo"];
			if ($amount < $mindep) {
				$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Deposit gagal<br> Minimal deposit = $mindep.</p></div>";
				$err = 1;
			}

			if ($err == 0) {
				$rek	= $rek1;
				$tp 	= '';
				$axx	= 0;
				$temp;
				for($i=0; $i<2; $i++){
					$temp	=  substr($rek, $axx, 4);
					if ($tp == ""){
						$tp	= $temp;
					}else{
						$tp	= $tp."-".$temp;
					}
					$axx = 4;
				}

				$panj	= strlen($rek);
				$temt	= substr($rek, 8, $panj);
				$rot	= $tp."-".$temt;

				$myDate1	= Date("d m y");
				$sekarang	= $myDate1;
				if ($playerpt == 1){
					$prefx = "ADMIN";
				}


				/*$to1 = "== DEPOSIT, SLIP untuk ".$prefx." ==<br>";
				$to1 .= "(Memo ini dikirim otomatis, berkaitan dengan permintaan deposit.)<br>";
				$to1 .= "Tanggal : ".$sekarang." <br>";
				$to1 .= "User id : ".$name." <br>";
				$to1 .= "E-mail : ".$email." <br>";
				$to1 .= "Jumlah Coin : ".$amount." <br>";
				$to1 .= "Tanggal bayar : ".$tgl." <br>";
				$to1 .= "Dari rekening : ".sanitize($accname1)." ".$bname1." ".$rek1."<br>";
				$to1 .= "Ke rekening : ".$accname2." ".$bname2." ".$rek2."<br>";
				$to1 .= "Keperluan : ".$remark."<br>";

				$subject	= "#--PERMINTAAN DEPOSIT--#";
				if ($playerpt == "1"){
					$sql7	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select bmemo from a83adm_config"), SQLSRV_FETCH_ASSOC);
					$bmemo	= $sql7["bmemo"];
					$bill =  explode(",", $bmemo);
					sqlsrv_query($sqlconn, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('*,".$bmemo.",*','".$name."','','".$subject."','".$to1."','0',GETDATE())");
				}else{
					sqlsrv_query($sqlconn, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$agent."','".$name."','','".$subject."','".$to1."','0',GETDATE())");
				}

				$to2 = "(Memo ini dikirim otomatis, berkaitan dengan permintaan deposit.)";
				$to2 .= "<br> == DEPOSIT, SLIP untuk member ==";
				$to2 .= "<br> Tanggal : ".$sekarang ;
				$to2 .= "<br> User Id : ".$name;
				$to2 .= "<br> E-mail : ".$email ;
				$to2 .= "<br> Jumlah : ".$amount." ";
				$to2 .= "<br> Tanggal bayar : ".$tgl;
				$to2 .= "<br> Dari rekening : ".sanitize($accname1)." ".$bname1." ".$rek1;
				$to2 .= "<br> Ke rekening : ".$accname2." ".$bname2." ".$rek2;
				$to2 .= "<br> Keperluan : ".$remark;
				$subject2	= '#--DEPOSIT--#';*/
				$mgrup = 0;
				$amountx = $amount;
				sqlsrv_query($sqlconn, "insert into a83adm_depositraw (act,userid,userprefix,date1,amount,ket,nama,bank,rek,stat,status,date2,banktuj,datesent,rektuj,playerpt,grup,device) values ('1','".$name."','".$agent."',GETDATE(),'".$amountx."','".$ket."','".sanitize($accname1)."','".$bname1."','".$rek1."','0','','','".$bname2."',GETDATE(),'".$rek2."','".$playerpt."','".$mgrup."',1)");
				//echo "insert into a83adm_depositraw (act,userid,userprefix,date1,amount,ket,nama,bank,rek,stat,status,date2,banktuj,datesent,rektuj,playerpt) values ('1','".$name."','".$agent."',GETDATE(),'".$amountx."','".$ket."','".sanitize($accname1)."','".$bname1."','".$rek1."','0','','','".$bname2."','".$tgl."','".$rek2."','".$playerpt."')";
				$success_deposit = "<div class='deposit-success-report'>Deposit $amountx sukses. <br><br>
				<font style='font-size:12px;'>Rekening Tujuan : </font>
				<table style=font-size:14px;color:white; align=center>
					<tr>
						<td align=left style=font-size:12px;>Bank</td><td>:</td><td align=left>".strtoupper($bname2)."</td>
					</tr>
					<tr>
						<td align=left style=font-size:12px;>Nomor Rekening</td><td>:</td><td align=left>".strtoupper($rek2)."</td>
					</tr>
					<tr>
						<td align=left style=font-size:12px;>Nama Rekening</td><td>:</td><td align=left>".strtoupper($accname2)."</td>
					</tr>
				</table>

				Deposit anda paling maximal akan di proses dalam 24 jam</div>";
			}
		}
		echo"<BR>";
	}
	if ($_POST["subform"]){
		echo "<br><br>";
		$voucher_code=str_replace(" ","",$_POST["voucher_code"]);
		$pin=str_replace(" ","",$_POST["pin"]);
		$captcha=str_replace(" ","",$_POST["captcha"]);

		if (strtolower($_SESSION['CAPTCHAString']) != $captcha || $_SESSION['CAPTCHAString'] == "" || $captcha == "") {
			$valkey = 1;
			$err = 1;
			$errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Validation not match</p></div>";
		}else{
			
			$ip_address = get_client_ip();
			sqlsrv_query($sqlconn_db2,"insert into a443api_voucher88_log (tdate,subwebid,remark) values (GETDATE(),'".$subwebid."','".$login.",".$voucher_code.",".$pin."') ");
			$url = "http://vock88.com/VOU_GRB_WBOZPVN80D3NR3TKPSID";
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, $url);
			$response=http_build_query(array(
				'app_id' 	=> "610727387664706",
				'app_secret'=> "hUfxqqtupO4wlM1lkyfkMBP1ff0KclwS",
				'code' 		=> $voucher_code,
				'pin' 		=> $pin,
				'username'	=> $user_login,
				'use_ipaddress' => $ip_address
				));
			curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
			curl_setopt($ch, CURLOPT_POSTFIELDS,"" . $response);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
			$data_curl = curl_exec($ch);
			curl_close($ch);
			$obj = json_decode($data_curl);
			$validate_code = $obj->{'status'};
			sqlsrv_query($sqlconn_db2,"insert into a443api_voucher88_log (tdate,subwebid,remark) values (GETDATE(),'".$subwebid."','".$login.",".$voucher_code.",".$pin."(".$validate_code.")') ");
			if($validate_code && $validate_code != ''){
				function memo($to,$from,$subject,$body,$read = 0) {
					sqlsrv_query($sqlconn_db2,"insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".addslashes($to)."','".$from."','','".addslashes($subject)."','".$body."','".$read."',GETDATE())");
				}
				$amount = json_decode( $obj->{"value"} );
				$code = $voucher_code;
				$cek=sqlsrv_query($sqlconn,"select top 1 total from j2365join_lastorder where userid='".$login."' order by id desc",$params,$options);
				$cekRows2 = sqlsrv_num_rows($cek);
				if ($cekRows2 > 0){
					$bsql = @sqlsrv_fetch_array($cek,SQLSRV_FETCH_ASSOC);
					$user_id = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select save_deposit from u6048user_id where userid = '".$login."'"),SQLSRV_FETCH_ASSOC);
					$selisih=($bsql["total"] - $user_id["save_deposit"]);
					$abso=abs($selisih);
					if(($bsql["total"] != $user_id["save_deposit"])and($abso>500)){
						$errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'><font color=red size=2 face=arial><b><i>".P_FATERR." !!! ".P_BALPRO." !!!</b></i></font></p></div>";
						$err= 1;
					}
				}
				if($err != 1){		
					$tobj ="DENGAN HORMAT<br><br>";
					$tobj.="Slip Voucher Deposit";
					$tobj.="<br>Tanggal : ".Date("d/m/y h:i");	
					$tobj.="<br>Userid : $login";	
					$tobj.="<br>Amount : $amount";	
					$tobj.="<br>Selamat Account anda telah diisi dengan voucher senilai ".$amount."";	
					$gantix=str_replace("'", "''",$tobj);
					
					memo($login,"ADMIN","Voucher Deposit", $gantix);
					
					$idxsql = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select save_deposit,playerpt from u6048user_id where userid = '".$login."'"),SQLSRV_FETCH_ASSOC);
					$balbaru = $idxsql["save_deposit"] + $dbq["amount"];
					$playerpt = $idxsql["playerpt"];
					$totalbaru = $balbaru;


					sqlsrv_query($sqlconn,"update u6048user_data set credit = '".number_format($totalbaru, 0,'.', '')."' where userid = '".$login."'");
					sqlsrv_query($sqlconn,"update u6048user_id set deposit_pending = '1',xdeposit=(xdeposit+1) where userid = '".$login."'");
					//sqlsrv_query($sqlconn,"insert into u6048user_transfer (receiver,mes,date) values ('".$login."','12, ,".$amount."',GETDATE())");
					$balance_voucher = $coin + $amount;

					sqlsrv_query($sqlconn,"update u6048user_coin set txh='".$balance_voucher."' where userid='".$login."'");
					sqlsrv_query($sqlconn,"insert into t6413txh_lastorder (Userid,bdate,info,status,amount,gametype,total) values ('".$login."',GETDATE(), '-', 'VOUCHER', '".$amount."', 'TXH', '".$balance_voucher."')");
					sqlsrv_query($sqlconn,"insert into j2365join_adminlog (UserId,Tgl,Aksi,Ket) values ('$login',GETDATE(),'Accept Voucher','$login')");
					sqlsrv_query($sqlconn,"insert into a83adm_deposit (act,playerpt,userid,userprefix,date1,amount,ket,nama,bank,rek,stat,status,date2,banktuj,datesent,rektuj,operator) values ('1','1','".$login."','".$agentwlable."',GETDATE(),'".$amount."','Voucher $code','','','',1,1,GETDATE(),'',GETDATE(),'','voucher')");
					sqlsrv_query($sqlconn,"insert into cas2_db.dbo.t6413txh_transaction_old".(date("d")*1)." (TDate, Periode, RoomId, TableNo, UserId, GameType, Status, Bet, v_bet, Card, Prize, Win, Lose, Cnt, Chip, PTShare, SShare, MShare, AShare, Autotake, DSMaster, DMaster, DAgent, DPlayer, Agent, Master, Smaster) values (GETDATE(), '0', '0', '0', '".$login."', 'TXH', 'Voucher', '0', '".$amount."', '-', '-', '0', '0', '1', $balance_voucher , '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '')");
					
					$cek_trans = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select user from a83adm_moneyhistory where userid='".$login."' and bulan='".date("m")."' and tahun='".date("Y")."'",$params,$options));
					if ($cek_trans > 0) sqlsrv_query($sqlconn,"update a83adm_moneyhistory set deposit=(deposit + '".$dbq["amount"]."') where userid='".$login."' and bulan='".date("m")."' and tahun='".date("Y")."'");
					else sqlsrv_query($sqlconn,"insert into a83adm_moneyhistory (userid, deposit, bulan, tahun) values ('".$login."', '".$dbq["amount"]."', '".date("m")."', '".date("Y")."')");
					
					$success_deposit ="<div class='deposit-success-report'><font color=white>Voucher di terima, saldo sebesar $amount telah di tambahkan.</font></div>";
				}
			}else{
				sqlsrv_query($sqlconn,"update u6048user_id set voucher_count=isnull(voucher_count,0)+1,voucher_date=GETDATE() where userid='".$login."'");
				$errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Voucher not valid</p></div>";
				$err=1;
			}
		}
	}

	$q_check_validation=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select voucher_count from u6048user_id where userid='".$login."'"),SQLSRV_FETCH_ASSOC);
	if ($q_check_validation["voucher_count"]>="5"){
		$q_1=sqlsrv_num_rows(sqlsrv_query($sqlconn,"select voucher_date from u6048user_id where userid='".$login."' and voucher_date<DATEADD(minute,-10,GETDATE())",$params,$options));
		if ($q_1 == 1) sqlsrv_query($sqlconn,"update u6048user_id set voucher_count=0 where userid='".$login."'");
		$errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Maaf voucher deposit di tutup sementara</p></div>";
		$err=1;
	}

	$idb = $bankgrup;
	$bankaccnox = substr($bankaccno,0,-4);
	?>

<div class="content-2" data-id="deposit" id="page">
	<div class="lpadding-15 tpadding-5">
		<label class="ntf fs-13"><?PHP if($_SESSION["login"]) echo "FORM "; ?>DEPOSIT</label>
	</div>
	<?php
		if($_SESSION["login"]){
			if ($success_deposit){
				echo $success_deposit;
			}else{
				if ($err == 1){
					echo $errorReport;
				}
	?>

	<hr class="margin-0 tmargin-2 bmargin-3 bg-brown-panel">

	<div id="referral">
		<div class="padding">
			<ul>
				<li><a href="#tabs-1" onclick="tabs_1()">Cash Deposit</a></li>
				<li><a href="#tabs-2" onclick="tabs_2()">Voucher Deposit</a></li>
			</ul>

			<div id="tabs-1">
				<div class="tpadding-10 lpadding-15 rpadding-15 row">
					<form method="post" id="fcash" name="fcash">

						<div class="row margin0">
							<div class="col-lg-5">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10">BANK</label>
							</div>
							<div class="col-lg-1">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
							</div>
							<div class="col-lg-6">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> <?php echo $bankname;?> </label>
								<input type="hidden" name="bank" value="<?php echo $bankname;?>" />
							</div>
						</div>
						<div class="row margin0">
							<div class="col-lg-5">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10">NAMA REKENING</label>
							</div>
							<div class="col-lg-1">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
							</div>
							<div class="col-lg-6">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> <?php echo $bankaccname; ?> </label>
								<input type="hidden" name="bank_accname" value="<?php echo $bankaccname; ?>" />
							</div>
						</div>
						<div class="row margin0">
							<div class="col-lg-5">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10">NOMOR REKENING</label>
							</div>
							<div class="col-lg-1">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
							</div>
							<div class="col-lg-6">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> 
								<?php
									if($bankname == "BCA"){
										echo substr($bankaccno,0,8)."xxxx";
									}else{
										echo substr($bankaccno,0,8)."xxx-xxxx";
									}
								?>
								</label>
								<input type="hidden" name="bank_accnumber" value="<?php echo $bankaccno;?>" />
							</div>
						</div>

						<label class="black fs-13 pull-left tmargin-10">Jumlah Deposit</label>
						<div class="row">
							<div class="col-lg-11">
								<input type="text" class="form-control bg-light-gray" name="ui_amount" id="ui_amount" value="<?php echo @$amount?>" placeholder="Masukan jumlah deposit" required />
								<input type="hidden" name="amount" id="amount" value="<?php echo @$amount?>">
							</div>
							<div class="col-lg-1 text-left">
								<label class="black tmargin-10 lmargin-5">IDR</label>
							</div>
						</div>

						<!-- <label class="light-gray fs-13 fs-normal  tmargin-10">Tanggal</label>
						<div class="row margin-0">
							<div class="col-lg-3">
								<select name='ttgl' class="form-control bg-light-gray" required>
									<?php
										$date = date("d");
										$month = date("M");
										$year = date("Y");

										for ($d=1; $d<32; $d++){
											$select = "";
											if ($d == $date){
												$select ="selected";
											}
										echo "<option value='".$d."' ".$select.">".$d."</option>";
										}
									?>
								</select>
							</div>
							<div class="col-lg-4">
								<select name='tmon' class="form-control bg-light-gray" required>
									<?php
										$armon = Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
										for ($m=0; $m<12; $m++){
											$select = "";
											if ($armon[$m] == $month){
												$select ="selected";
											}
											echo "<option value='".$armon[$m]."' ".$select.">".$armon[$m]."</option>";

										}
									?>
								</select>
							</div>
							<div class="col-lg-5">
								<select name='tyear' class="form-control bg-light-gray" required>
									<?php
										$yearx = $year-1;
										for ($m=0; $m<3; $m++){
											$select = "";
											if ($yearx == $year){
												$select ="selected";
											}
											echo "<option value='".$yearx."' ".$select.">".$yearx."</option>";

											$yearx = $yearx+1;
										}
									?>
								</select>
							</div>
						</div> -->

						<?php
							if ($playerpt == 1){
								$sql2	= sqlsrv_query($sqlconn, "select bank, bankaccno, bankaccname,status from a83adm_configbank where (code = 'Company' or code = 'COMPANY' or code = 'company') and (curr = 'IDR') and idx='".$idb."' order by status asc, id asc",$params,$options);
							}else if ($playerpt	== 0){
								$q		= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userprefix from u6048user_data where userid = '".$login."'"), SQLSRV_FETCH_ASSOC);
								$userx		= $q["userprefix"];
								$sql2		= sqlsrv_query($sqlconn, "select bank, bankaccno, bankaccname,status from a83adm_configbank where code = '".$userx."' and idx ='".$idb."' and (curr = 'IDR')",$params,$options); 
							}

							$jumbank = sqlsrv_num_rows($sql2);
							$check = "checked";
						?>

						<label class="black fs-13 fs-normal">Pilihan Bank</label>
						<div class="row margin0">
							<div class="col-lg-12">
								<select class="form-control bg-light-gray" name="data-bank" id="data-bank" required>
									<option value="" selected> Pilih Bank </option>
									<?PHP
										for($i=0; $i<$jumbank; $i++){
											$tempRow = sqlsrv_fetch_array($sql2, SQLSRV_FETCH_ASSOC);
											$hbno[$i] = $tempRow["bankaccno"];
											$hbacc[$i] = $tempRow["bankaccname"];
											$status = $tempRow["status"];

											if ($i == ($jumbank - 1)){
												$line_color = "";
											}else{
												$line_color = "border-bottom:1px solid #16edfe";
											}

											if(strtoupper($hbno[$i]) == "OFFLINE"){
												$clas = "disabled";
												$ket = "OFFLINE";
											}else{
												$clas = "";
												$ket = "";
											}
											
											if(strtoupper($bankname) == strtoupper($tempRow["bank"])){
												$sel = "selected";
											}else{
												$sel = "";
											}

											echo '<option value="'.strtoupper($tempRow["bank"]).",".strtoupper($hbno[$i]).",".strtoupper($hbacc[$i]).",".$status.'" '.$clas.' '.$sel.'>'.strtoupper($tempRow["bank"]).' '.$ket.'</option>';
										}
									?>
								</select>
							</div>
						</div>

						<label class="black fs-13 fs-normal tmargin-10 bank-detail" style="display: none;">Silakan deposit ke:</label>
						<div class="row margin0 bank-detail" style="display: none;">
							<div class="col-lg-4">
								<label class="black fs-13 fs-normal tmargin-10">Nama Bank</label>
							</div>
							<div class="col-lg-1 ">
								<label class="black fs-13 fs-normal tmargin-10"> : </label>
							</div>
							<div class="col-lg-7">
								<label class="black fs-13 fs-normal tmargin-10" id="bkil">  </label>
							</div>
						</div>

						<div class="row margin0 bank-detail" style="display: none;">
							<div class="col-lg-4">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10">Nama Rekening</label>
							</div>
							<div class="col-lg-1">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
							</div>
							<div class="col-lg-7">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10" id="nare">  </label>
							</div>
						</div>

						<div class="row margin0 bank-detail" style="display: none;">
							<div class="col-lg-4">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10">Nomor Rekening</label>
							</div>
							<div class="col-lg-1">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
							</div>
							<div class="col-lg-5">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10" id="nore">  </label>
								<label style="display: none;" id="finalcopy"></label>
							</div>
							<div class="col-lg-2">
								<input class="btn btn-medium btn-gray bmargin-5 text-center" id="copy-to" type="button" value="Copy" />
							</div>
						</div>

						<div class="row margin0 tpadding-5">
							<div class="col-lg-12 dropdown">
								<a href="https://ib.bri.co.id/ib-bri/" target="_blank" class="dropbtn fs-14" id="btn-bri" style="display: none; height: 50px;">
									<div class="col-lg-3 col-lg-offset-2">
										<img src="img/banks/bri - blue.png" class="bank pull-left" style="height:25px;!important">
									</div>
									<div class="col-lg-3">
										<p class="margin-0 tmargin-3">Login E-Bank</p>
									</div>
								</a>

								<a href="https://ibank.bni.co.id/MBAWeb/FMB" target="_blank" class="dropbtn fs-14" id="btn-bni" style="display: none; height: 50px;">
									<div class="col-lg-3 col-lg-offset-2">
										<img src="img/banks/bni - blue.png" class="bank pull-left" style="height:25px;!important">
									</div>
									<div class="col-lg-3">
										<p class="margin-0 tmargin-3">Login E-Bank</p>
									</div>
								</a>

								<a href="https://ib.bankmandiri.co.id" target="_blank" class="dropbtn fs-14" id="btn-mandiri" style="display: none; height: 50px;">
									<div class="col-lg-3 col-lg-offset-2">
										<img src="img/banks/mandiri - blue.png" class="bank pull-left" style="height:25px;!important">
									</div>
									<div class="col-lg-3">
										<p class="margin-0 tmargin-3">Login E-Bank</p>
									</div>
								</a>

								<a href="https://ibank.klikbca.com/" target="_blank" class="dropbtn fs-14" id="btn-bca" style="display: none; height: 50px;">
									<div class="col-lg-3 col-lg-offset-2">
										<img src="img/banks/bca - blue.png" class="bank pull-left" style="height:25px;!important">
									</div>
									<div class="col-lg-3">
										<p class="margin-0 tmargin-3">Login E-Bank</p>
									</div>
								</a>
							</div>
						</div>

						<div class="row"><label class="black fs-13 pull-left tmargin-10">Validasi</label></div>
						<div class="row">
							<div class="col-lg-7">
								<input class="form-control bg-light-gray" type="text" name="captcha1" maxlength="5" placeholder="Validasi" required />
							</div>
						
							<div class="col-lg-5 tpadding-3 lpadding-5">
								<img src='../../captcha/captcha.php?.png' alt='CAPTCHA' width='100%' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">
							</div>
						</div>

						<div class="row">
							<input class="btn btn-gray tmargin-10 bmargin-5" value="BATAL" type="button" onclick="location.href='index.php'" />
						</div>
						<div class="row">
							<input class="btn btn-blue tmargin-5 bmargin-10" value="KONFIRMASI" type="submit" name="submit" />
						</div>
						<ol class="black">
							<li class="margin-0">Minimal Deposit = 10.000,00 IDR .</li>
							<li class="margin-0"> Harap perhatikan rekening deposit kami yang sedang aktif sebelum melakukan pengiriman deposit, sehingga deposit anda dapat di proses secepatnya ke dalam dompet utama anda. </li>
							<li class="margin-0">Deposit Menggunakan account bank selain yang di daftarkan tidak di perbolehkan. </li>
							<li class="margin-0">etelah melakukan proses pengiriman dan mengisi form secara benar maka deposit anda akan di proses dalam kurun waktu 5 menit. </li>
							<li class="margin-0">Silahkan hubungin customer service kami via live chat untuk konfirmasi status deposit anda.</li>
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
												Senin - Minggu	: 00:00 - 02: 30 WIB
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

						<div style="padding-bottom: 50px;"></div>

					</form>
				</div>
			</div>

			<div class="tabs-2" id="tabs-2-content" style="display: none;">
				<div class="tpadding-10 lpadding-15 rpadding-15 row">
					<form method="post" id="fvoucher" name="fvoucher">
						<label class="black fs-13 pull-left tmargin-10">Voucher Code</label>
						<div class="row">
							<div class="col-lg-12">
								<input class="form-control bg-light-gray" name="voucher_code" id="amount" value="" placeholder="Voucher Code" required />
							</div>
						</div>

						<label class="black fs-13 pull-left tmargin-10">Voucher PIN</label>
						<div class="row">
							<div class="col-lg-12">
								<input class="form-control bg-light-gray" name="pin" id="amount" value="" placeholder="Voucher Pin" required />
							</div>
						</div>

						<div class="row"><label class="black fs-13 pull-left tmargin-10">Validasi</label></div>
						<div class="row">
							<div class="col-lg-7">
								<input class="form-control bg-light-gray" type="text" name="captcha" maxlength="5" placeholder="Validasi" required />
							</div>
						
							<div class="col-lg-5 tpadding-3 lpadding-5">
								<img src='../../captcha/captcha.php?.png' alt='CAPTCHA' width='100%' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">
							</div>
						</div>
						<div class="row">
							<input class="btn btn-gray tmargin-10 bmargin-5" value="BATAL" type="button" onclick="location.href='index.php'" />
						</div>
						<div class="row">
							<input class="btn btn-blue tmargin-5 bmargin-10" value="KONFIRMASI" type="submit" name="subform" />
						</div>
					</form>
				</div>
			</div>

		</div>
	</div>

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
					<p class="fs-bold"> Silahkan LOGIN terlebih dahulu untuk melakukan deposit</p>
					</div>
				</div>

				<hr class="margin-0 bmargin-5">
				<ol>
					<li class="margin-0">Deposit hanya akan di proses dari rekening yang terdaftar.</li>
					<li class="margin-0">Minimum Deposit Rp10.000</li>
					<li class="margin-0">Setelah melakukan pengisian form deposit dengan benar, maka Deposit akan di proses secepetnya .</li>
				</ol>
			</div>
			<label class="ntf fs-13">
				Metode Deposit Bank:
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
			<label class="ntf fs-13">
				Metode Deposit Alternatif:
			</label>
			<div class="row tmargin-5 bmargin-15">
				<div class="col-lg-5">
					<img class="img-fluid" src="img/banks/v88.png"/>
				</div>
			</div>

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

			<div style="padding-bottom: 75px;"></div>

		</div>

	<?PHP
		}
	?>
	
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

	$( "#data-bank" ).change(function() {
		var isi = $(this).val();
		var res = isi.split(",");

		if( res[0] ){
			$(".bank-detail").css('display', 'block');

			if( res[0] == 'BRI' ){
				$( '#btn-bri' ).css('display', 'block');
				$( '#btn-bni' ).css('display', 'none');
				$( '#btn-mandiri' ).css('display', 'none');
				$( '#btn-bca' ).css('display', 'none');
			}else if( res[0] == 'BNI' ){
				$( '#btn-bri' ).css('display', 'none');
				$( '#btn-bni' ).css('display', 'block');
				$( '#btn-mandiri' ).css('display', 'none');
				$( '#btn-bca' ).css('display', 'none');
			}else if( res[0] == 'MANDIRI' ){
				$( '#btn-bri' ).css('display', 'none');
				$( '#btn-bni' ).css('display', 'none');
				$( '#btn-mandiri' ).css('display', 'block');
				$( '#btn-bca' ).css('display', 'none');
			}else if( res[0] == 'BCA' ){
				$( '#btn-bri' ).css('display', 'none');
				$( '#btn-bni' ).css('display', 'none');
				$( '#btn-mandiri' ).css('display', 'none');
				$( '#btn-bca' ).css('display', 'block');
			}

		}else{
			$(".bank-detail").css('display', 'none');
			$( '#btn-bri' ).css('display', 'none');
			$( '#btn-bni' ).css('display', 'none');
			$( '#btn-mandiri' ).css('display', 'none');
			$( '#btn-bca' ).css('display', 'none');
		}

  		$( "#bkil" ).html( res[0] );
  		$( "#nare" ).html( res[2] );
  		$( "#nore" ).html( res[1] );
	});

	$( ".deploy-toggle-1" ).click(function() {
		if ( $('.toggle-content').css('display') != 'block' ) {
			$('.btn-up').css('display', 'block');
			$('.btn-down').css('display', 'none');
		}else{
			$('.btn-up').css('display', 'none');
			$('.btn-down').css('display', 'block');		
		}
	});

	function tabs_1(){
		document.getElementById('tabs-2-content').style.display = 'none';
	}

	function tabs_2(){
		document.getElementById('tabs-2-content').style.display = 'block';
	}

	document.getElementById("copy-to").addEventListener("click", function() {
		var _targetcopy = document.getElementById("nore").innerHTML;
		var _rescopy = _targetcopy.split("-");
		var _finalres = "";

		for(var a=0; a < _rescopy.length; a++){
			_finalres += _rescopy[a];
		}

		document.getElementById("finalcopy").innerHTML = _finalres;

	    copyToClipboard(document.getElementById("finalcopy"));
	});

	function copyToClipboard(elem) {
		  // create hidden text element, if it doesn't already exist
	    var targetId = "_hiddenCopyText_";
	    var isInput = elem.tagName === "INPUT" || elem.tagName === "TEXTAREA";
	    var origSelectionStart, origSelectionEnd;
	    if (isInput) {
	        // can just use the original source element for the selection and copy
	        target = elem;
	        origSelectionStart = elem.selectionStart;
	        origSelectionEnd = elem.selectionEnd;
	    } else {
	        // must use a temporary form element for the selection and copy
	        target = document.getElementById(targetId);
	        if (!target) {
	            var target = document.createElement("textarea");
	            target.style.position = "absolute";
	            target.style.left = "-9999px";
	            target.style.top = "0";
	            target.id = targetId;
	            document.body.appendChild(target);
	        }
	        target.textContent = elem.textContent;
	    }
	    // select the content
	    var currentFocus = document.activeElement;
	    target.focus();
	    target.setSelectionRange(0, target.value.length);
	    
	    // copy the selection
	    var succeed;
	    try {
	    	  succeed = document.execCommand("copy");
	    } catch(e) {
	        succeed = false;
	    }
	    // restore original focus
	    if (currentFocus && typeof currentFocus.focus === "function") {
	        currentFocus.focus();
	    }
	    
	    if (isInput) {
	        // restore prior selection
	        elem.setSelectionRange(origSelectionStart, origSelectionEnd);
	    } else {
	        // clear temporary content
	        target.textContent = "";
	    }
	    return succeed;
	}
	
	
	
	$( document ).ready(function() {
		
		var isi = $("#data-bank" ).val();
		var res = isi.split(",");

		if( res[0] ){
			$(".bank-detail").css('display', 'block');

			if( res[0] == 'BRI' ){
				$( '#btn-bri' ).css('display', 'block');
				$( '#btn-bni' ).css('display', 'none');
				$( '#btn-mandiri' ).css('display', 'none');
				$( '#btn-bca' ).css('display', 'none');
			}else if( res[0] == 'BNI' ){
				$( '#btn-bri' ).css('display', 'none');
				$( '#btn-bni' ).css('display', 'block');
				$( '#btn-mandiri' ).css('display', 'none');
				$( '#btn-bca' ).css('display', 'none');
			}else if( res[0] == 'MANDIRI' ){
				$( '#btn-bri' ).css('display', 'none');
				$( '#btn-bni' ).css('display', 'none');
				$( '#btn-mandiri' ).css('display', 'block');
				$( '#btn-bca' ).css('display', 'none');
			}else if( res[0] == 'BCA' ){
				$( '#btn-bri' ).css('display', 'none');
				$( '#btn-bni' ).css('display', 'none');
				$( '#btn-mandiri' ).css('display', 'none');
				$( '#btn-bca' ).css('display', 'block');
			}

		}else{
			$(".bank-detail").css('display', 'none');
			$( '#btn-bri' ).css('display', 'none');
			$( '#btn-bni' ).css('display', 'none');
			$( '#btn-mandiri' ).css('display', 'none');
			$( '#btn-bca' ).css('display', 'none');
		}

  		$( "#bkil" ).html( res[0] );
  		$( "#nare" ).html( res[2] );
  		$( "#nore" ).html( res[1] );
	});
</script>

<?PHP 
	if($link_img == "io"){ 
		$color1 = "#e6fdff";
		$color2 = "#2eb9ca";
	}elseif($link_img == "PTKP"){ 
		$color1 = "#f1f1f1";
		$color2 = "#992027";
	}else{ 
		$color1 = "#f1f1f1";
		$color2 = "#402573";
	} 
?>
<style type="text/css">
	#referral{
		border:none !important;
		padding: 0px !important;
	}
	#referral .ui-widget-header{
		border:none;
		background:<?PHP echo $color1;?>;
		border-radius: 0px;
	}
	.ui-tabs .ui-tabs-nav li {
		width:45%;
		margin-left:.5%;
		margin-right:.5%;
		text-align: center;
	}
	.ui-tabs .ui-tabs-nav li:first-child{
		margin-left:4%;
	}
	.ui-tabs .ui-tabs-nav li:last-child{
		margin-right:4%;
	}
	.ui-tabs .ui-tabs-nav li a {
		display: inline-block;
		float: none;
		padding: 6px;
		text-decoration: none;
		width: 100%;
		font-weight: normal;

	}
	.ui-tabs .ui-tabs-nav{
		padding: 0px;

	}
	.ui-corner-all, .ui-corner-top, .ui-corner-right, .ui-corner-tr{
		border:none;
	}
	.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default{
		background: #35353f;
		border:#35353f;

	}
	.ui-tabs .ui-tabs-nav li.ui-tabs-active{
		background: <?PHP echo $color2;?>;
		color:#fff;
	}
	.ui-tabs .ui-tabs-nav li.ui-tabs-active > a{
		color:#fff;
	}
	.ui-tabs .ui-tabs-panel{
		background: <?PHP echo $color1;?>;
		padding: 0px;
	}
</style>

<?php include ("_footer.php");?>