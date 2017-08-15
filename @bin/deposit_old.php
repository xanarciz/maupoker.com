<?php
$freePage=true;
include("meta.php");
include("header.php");
include("config_db2.php");

require_once 'mobile_detect.php';
$detect = new Mobile_Detect;
$check_mobile = $detect->isMobile();
$check_tablet = $detect->isTablet();
$mobile = 2;
if($check_mobile == 1 || $check_tablet == 1){
	$mobile = 1;
	header("location:m");
	exit();
}


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

function currx($val) {
   if (!strpos($val,".")) return number_format($val, 0,'.', ',');
   else return number_format($val, 1,'.', ',');
}
if (!$_SESSION["login"]){
	$flag = 'deposit';
	include('ketdpwd.php');
	include('footer.php');
	die();
}

$sql3 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid='".$login."' and bdate > dateadd(minute,-1,GETDATE())",$params,$options));	
if ($sql3 > 0){
	$success_deposit = "<div class='error-report'>Cannot deposit.<br>Don't enter the game and try again 1 minutes later </div>";
	 $err = 1;
}
$sql1 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select amount from a83adm_depositraw where userid='".$login."' and stat='0' AND act='1'"), SQLSRV_FETCH_ASSOC);
if ($sql1["amount"] > 0){
	 $success_deposit =  "<div class='error-report' >Tidak Dapat melakukan deposit,<br> anda masih memiliki 1 deposit yang sedang di proses</div>";
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

if($bankaccno == null && $bankname == null && $bankaccname == null) {
	echo "<script>window.location = 'bank-setting.php'</script>";
	$_SESSION['urlPrev'] = 'deposit.php';
	die();
}

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
$firstdepo = 0;
$sqlmaxdepo = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select first_max_depo, max_depo from a83adm_config2"), SQLSRV_FETCH_ASSOC);
$maxdepo = $sqlmaxdepo["first_max_depo"];
$maxdepo2 = $sqlmaxdepo["max_depo"];
$q1	= sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select max_depo from u6048user_id where userid='".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
$maxdepo2 = $q1["max_depo"];
if ($_POST["submit"] && !$err) {

	$name = $login;
	$amount		= $_POST["amount"];
	$waktu		= $_POST["ttgl"]."-".$_POST["tmon"]."-".$_POST["tyear"];
	$accname1	= $bankaccname;
	$rek1		= $bankaccno;
	$bname1		= $bankname;
	$capt		= $_POST["captcha"];
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
		 $errorReport =  "<div class='error-report'>Connection Timeout.</div>";
		 $err = 1;
		 die();
	}

	if ($capt != $_SESSION['CAPTCHAString']){
		$errorReport =  "<div class='error-report'>Validasi anda salah.</div>";
		$err = 1;
	}else if ($amount == "" || $amount <= 0){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Isi Jumlah.</div>";
		$err = 1;
	}else if ($waktu == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Isi tanggal</div>";
		$err = 1;
	}else if ($time == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Isi waktu pengiriman</div>";
		$err = 1;
	}else if ($accname1 == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Isi nama account/div>";
		$err = 1;
	}else if ($rek1 == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Isi nomor rekening</div>";
		$err = 1;
	}else if ($bname1 == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Isi nama bank</div>";
		$err = 1;
	}else if ($bname2 == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Harap memilih bank tujuan</div>";
		$err = 1;
	}else if ($remark == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>pilih keterangan.</div>";
		$err = 1;
	}else if ($firstdepo == 1){
		/*if ($amount > $maxdepo){
			$errorReport =  "<div class='error-report'>Deposit gagal<br>Maksimum Deposit adalah ".currx($maxdepo).".</div>";
			$err = 1;
		}*/
	}else if ($amount > $maxdepo2){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Maksimum adalah ".currx($maxdepo2).".</div>";
		$err = 1;
	}

	if ($amount > 0){
	}else{
		$errorReport =  "<div class='error-report'>Deposit gagal<br>isi jumlah deposit.</div>";
		$err = 1;
	}

	if ($err == 0) {
		$ket	= "From : ".$accname1." - ".$rek1." ( ".$bname1." ) <br>";
		//$ket = $remark;
		$tgl	= $waktu;
		
		$email=$sqlu["email"];
		$playerpt=$sqlu["playerpt"];
		if ($sqlu["status"] == 2){
			$errorReport =  "<div class='error-report'>Deposit gagal<br></div>";
			$err = 1;
		}

		$sql3	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select curr,userprefix from u6048user_data where userid = '".$name."'"), SQLSRV_FETCH_ASSOC);
		$curr=$sql3["curr"];
		$agent=$sql3["userprefix"];
		$playerpt=$sqlu["playerpt"];
		$kalikan = 1;
		
		if ($playerpt == "1"){
			$sql5	= "select min_wdraw from a83adm_config";
		}else{
			$sql5	= "select min_depo,max_depo,email from u6048user_id where userid='".$agent."'";
		}
		
		$sql6 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, $sql5), SQLSRV_FETCH_ASSOC);
		$mindep = $sql6["min_depo"];
		$maxdep = $sql6["max_depo"];
		
		if ($amount < $mindep) {
			$errorReport =  "<div class='error-report'>Deposit gagal<br> Minimal deposit = ".currx($mindep)."</div>";
			$err = 1;
		}
			if ($amount > $maxdep) {
			$errorReport =  "<div class='error-report'>Deposit gagal<br> Maksimal deposit = ".currx($maxdep)."</div>";
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
			
			$mgrup = 0;
			$amountx = $amount;
			sqlsrv_query($sqlconn, "insert into a83adm_depositraw (act,userid,userprefix,date1,amount,ket,nama,bank,rek,stat,status,date2,banktuj,datesent,rektuj,playerpt,grup,device) values ('1','".$name."','".$agent."',GETDATE(),'".$amountx."','".$ket."','".sanitize($accname1)."','".$bname1."','".$rek1."','0','','','".$bname2."','".$tgl."','".$rek2."','".$playerpt."','".$mgrup."',".$mobile.")");
			$success_deposit = "<div class='deposit-success-report'><strong>Deposit $amountx sukses.</strong><br><br>
				
				<table style=font-family:tahoma;font-size:14px; align=center>
					<tr><td colspan=3 align=center>Rekening Tujuan</td></tr>
					<tr>
						<td align=left style=font-family:tahoma;font-size:12px;>Bank</td><td>:</td><td align=left><span>".strtoupper($bname2)."</span></td>
					</tr>
					<tr>
						<td align=left style=font-family:tahoma;font-size:12px;>Nomor Rekening</td><td>:</td><td align=left><span>".strtoupper($rek2)."</span></td>
					</tr>
					<tr>
						<td align=left style=font-family:tahoma;font-size:12px;>Nama Rekening</td><td>:</td><td align=left><span>".strtoupper($accname2)."</span></td>
					</tr>
				</table>
				<span>Deposit anda paling maximal akan di proses dalam 24 jam</span></div>";
		}
	}
	echo"<BR>";
}
if ($_POST["subform"] && $err != 1){
	// exit("Maaf untuk sementara fitur voucher tidak dapat di pergunakan");
	echo "<br><br>";
	$voucher_code=str_replace(" ","",$_POST["voucher_code"]);
	$pin=str_replace(" ","",$_POST["pin"]);
	$captcha=str_replace(" ","",$_POST["captcha"]);
				
	if (strtolower($_SESSION['CAPTCHAString']) != $captcha || $_SESSION['CAPTCHAString'] == "" || $captcha == "") {
		$valkey = 1;
		$err = 1;
		$errorReport = "<div class='error-report'>Validation not match</div>";
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
					$errorReport = "<div class='error-report'><p align=center><font color=red size=2 face=arial><b><i>".P_FATERR." !!! ".P_BALPRO." !!!</b></i></font></p></div>";
					$err= 1;
				}
			}
				$cek_vouc =sqlsrv_query($sqlconn,"select count(ket) as total from a83adm_deposit where ket = 'Voucher ".$voucher_code."' ",$params,$options);
				$cek_v = sqlsrv_fetch_array($cek_vouc,SQLSRV_FETCH_ASSOC);
				$cv = $cek_v['total'];
		
				if($cv == 0){	
				$tobj ="DENGAN HORMAT<br><br>";
				$tobj.="Slip Voucher Deposit";
				$tobj.="<br>Tanggal : ".Date("d/m/y h:i");	
				$tobj.="<br>Userid : $login";	
				$tobj.="<br>Amount : $amount";	
				$tobj.="<br>Selamat Account anda telah diisi dengan voucher senilai ".$amount."";	
				$gantix=str_replace("'", "''",$tobj);
				
				memo($login,"ADMIN","Voucher Deposit", $gantix);
				
				$idxsql = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select save_deposit,playerpt from u6048user_id where userid = '".$login."'"),SQLSRV_FETCH_ASSOC);
				$balbaru = $idxsql["save_deposit"] + $amount;
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
				sqlsrv_query($sqlconn,"insert into cas2_db.dbo.t6413txh_transaction_old".(date("d")*1)." (TDate, Periode, RoomId, TableNo, UserId, GameType, Status, Bet, v_bet, Card, Prize, Win, Lose, Cnt, Chip, PTShare, SShare, MShare, AShare, Autotake, DSMaster, DMaster, DAgent, DPlayer, Agent, Master, Smaster) values (GETDATE(), '0', '0', '0', '".$login."', 'TXH', 'Voucher', '0', '".$amount."', '-', '-', '0', '0', '1', $balance_voucher , '0', '0', '0', '0', '0', '0', '0', '0', '0', '".$agentwlable."', '', '')");

				$cek_trans = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select user from a83adm_moneyhistory where userid='".$login."' and bulan='".date("m")."' and tahun='".date("Y")."'",$params,$options));
				if ($cek_trans > 0) sqlsrv_query($sqlconn,"update a83adm_moneyhistory set deposit=(deposit + '".$amount."') where userid='".$login."' and bulan='".date("m")."' and tahun='".date("Y")."'");
				else sqlsrv_query($sqlconn,"insert into a83adm_moneyhistory (userid, deposit, bulan, tahun) values ('".$login."', '".$amount."', '".date("m")."', '".date("Y")."')");
				
				$success_deposit ="<div class='deposit-success-report'><font color=white>Voucher di terima, saldo sebesar $amount telah di tambahkan.</font></div>";
			}else{
			sqlsrv_query($sqlconn,"update u6048user_id set voucher_count=isnull(voucher_count,0)+1,voucher_date=GETDATE() where userid='".$login."'");
			$errorReport = "<div class='error-report'>ERROR !!! , Voucher Sudah pernah digunakan</div>";
			$err=1;
				}
		}else{
			sqlsrv_query($sqlconn,"update u6048user_id set voucher_count=isnull(voucher_count,0)+1,voucher_date=GETDATE() where userid='".$login."'");
			$errorReport = "<div class='error-report'>ERROR !!! , Tidak bisa terhubung dengan Voucher 88 , Pastikan Voucher dan Pin anda sudah Valid </div>";
			$err=1;
		}
	}
}

$q_check_validation=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select voucher_count from u6048user_id where userid='".$login."'"),SQLSRV_FETCH_ASSOC);
if ($q_check_validation["voucher_count"]>="5"){
	$q_1=sqlsrv_num_rows(sqlsrv_query($sqlconn,"select voucher_date from u6048user_id where userid='".$login."' and voucher_date<DATEADD(minute,-10,GETDATE())",$params,$options));
	if ($q_1 == 1) sqlsrv_query($sqlconn,"update u6048user_id set voucher_count=0 where userid='".$login."'");
	$errorReport = "<div class='error-report'>Maaf voucher deposit di tutup sementara</div>";
	$err=1;
}

$idb = $bankgrup;
$bankaccnox = substr($bankaccno,0,-4);
?>


<?php 

	if($_SESSION['login'] && $subscribe == 0 ){
?>
<script src="http://code.jquery.com/jquery-2.1.4.js"></script>
<script src="http://email.6mbr.com/subscribe.js?u=<?php echo $_SESSION['login']?>&w=domino88321&v=<?php echo time();?>" data-modalid="1405531097" data-webid="domino88321" data-user="<?php echo $_SESSION['login']?>" ></script>	
<?php 
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
								document.write("<iframe src="+j_deposit+" width=800 height=700></iframe>");
							</script>
						<?php
						}else{
						?>
                            <div class="head-wrap">
                                <h1>Deposit</h1>
                            </div>

                            <div class="body-wrap">
                        	<?php 
                        	if($subwebid=='9002' || $subwebid=='9001' || $subwebid=='172' || $subwebid=='42'){
                        	?>
                             	<a class="btn btn-login" style="float: left;margin:10px 5px 20px 5px;" href="deposit.php?id=1">Cash Deposit</a>
							 	<a class="btn btn-login" style="float: left;margin:10px 5px 20px 5px;" href="deposit.php?id=2">Voucher Deposit</a>
							 	<div style="clear: both;"></div>
						 	<?php 
						 	}
						 	?>
							<?php 
							if ($errorReport){
							?>
								<div class="alert alert-danger">
									<?php
									echo $errorReport;
									?>
								</div>
							<?php
							}else if ($success_deposit){
							?>
								<div class="alert alert-success">
									<?php
									echo $success_deposit;
									?>
								</div>
							<?php
							}

							if($_GET["id"] == 2 && ($subwebid=='9002' || $subwebid=='9001' || $subwebid=='172' || $subwebid=='42')){
							?>
								<p class="attention">MASUKAN CODE VOUCHER ANDA</p>
                                <div class="space_10"></div>

                        		<form method=post>
                        			<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Voucher Code</label>
                                        <div class="col-lg-2">
                                        	<input id="amount" type="text" placeholder="Voucher Code" name="voucher_code" value="" data-required="true" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Voucher Pin</label>
                                        <div class="col-lg-2">
                                        	<input id="amount" type="text" placeholder="Pin" name="pin" value="" data-required="true" class="form-control">
                                        </div>
                                    </div>
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
                                        <button type="submit" value=subform name=subform class="btn btn-submit">Kirim</button>
                                    </div>
								</form>
                            <?php 
                        	}else{
                        	?>
                        		<p class="attention">HARAP SELALU MELIHAT REKENING AKTIF DI BANK TUJUAN SEBELUM TRANSFER DANA</p>

								<?php
									$conf_depo = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select max_depo , min_depo , min_wdraw , max_wdraw FROM u6048user_id WHERE userid = '".$agentwlable."'"),SQLSRV_FETCH_ASSOC);
								?>
								
								<center><font size="3" color="#FF0000">MAX DEPOSIT <?php echo number_format ($conf_depo['max_depo']); ?></font></center>
								<center><font size="3" color="#FF0000">MIN DEPOSIT <?php echo number_format ($conf_depo['min_depo']); ?></font></center>
								
                                <div class="space_10"></div>

                                <form class="form-horizontal" role="form" method="POST">
                                    <label class="col-lg-1 control-label-header">Pengirim</label>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nama bank</label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7 normal">
												<?php echo strtoupper($bankname);?>
												<input type="hidden" name="bank" value="<?php echo $bankname;?>"
												</div>
	                                        </div>
                                    	</div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nama Rekening Bank</label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7 normal"><?php echo substr(strtoupper($bankaccname),0,4)."xxxx";?></div>
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nomor Rekening Bank</label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7 normal">
											<?php echo substr(strtoupper($bankaccno),0,8)."xxxx"; ?>
											<input type="hidden" name="bank_accno" value="<?php echo $bankaccno; ?>" />
											</div>
                                        </div>
                                    </div>
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Jumlah</label>
                                        <div class="col-lg-2">
                                            <input type="text" name="amount" placeholder="Jumlah Deposit" data-required="true" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Tanggal Kirim</label>
                                        <div class="col-lg-3">
										<?php
										$date = date("d");
										$month = date("M");
										$year = date("Y");
										?>
										<select name='ttgl'  class="form-control-small">
										<?php
										for ($d=1; $d<32; $d++){
											$select = "";
											if ($d == $date){
												$select ="selected";
											}
											echo "<option value='".$d."' ".$select.">".$d."</option>";
										}
										?>
										</select>&nbsp;<select name='tmon'  class="form-control-small">
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
										</select>&nbsp;<select name='tyear'  class="form-control-small">
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
                                    </div>
                                    <div class="space_10"></div>
                                    <label class="col-lg-1 control-label-header">Tujuan</label>
									<div class="col-bank">
										<table>
										<?php
											if ($playerpt == 1){
												$sql2	= sqlsrv_query($sqlconn, "select bank, bankaccno, bankaccname,status from a83adm_configbank where (code = 'Company' or code = 'COMPANY' or code = 'company') and (curr = 'IDR') and idx='".$idb."' order by status asc, id asc",$params,$options);
											}else if ($playerpt	== 0){
												$q		= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userprefix from u6048user_data where userid = '".$login."'"), SQLSRV_FETCH_ASSOC);
												$userx		= $q["userprefix"];
												$sql2		= sqlsrv_query($sqlconn, "select bank, bankaccno, bankaccname,status from a83adm_configbank where code = '".$userx."' and idx ='".$idb."' and (curr = 'IDR')",$params,$options); 
											}
											$sql2test = "select bank, bankaccno, bankaccname,status from a83adm_configbank where code = '".$userx."' and idx ='".$idb."' and (curr = 'IDR')";
	// if ($login=="LIVEGOO"){
	// EXIT($sql2test);
	// }
											
											$jumbank = sqlsrv_num_rows($sql2);
											//$check = "checked";
											$check = "";
											for($i=0; $i<$jumbank; $i++){
												$tempRow		= sqlsrv_fetch_array($sql2, SQLSRV_FETCH_ASSOC);
												$hbno[$i] = $tempRow["bankaccno"];
												$hbacc[$i] = $tempRow["bankaccname"];
												$status = $tempRow["status"];
												
												echo "	<tr>
														<td>
															<input type=radio $check name=data-bank value='".strtoupper($tempRow["bank"]).",".strtoupper($hbno[$i]).",".strtoupper($hbacc[$i]).",".$status."' style='border: 0px;vertical-align: middle;margin: 0px;padding: 0px;line-height: 1.2em;width: 20px;height: 20px;'>
														</td>
														<td>
															&nbsp;<span><img src='assets/img/$link_img/".strtolower($tempRow["bank"]).".png' width=104></span>
														</td>
														<td>
															<strong><span>".strtoupper($hbno[$i])."</span></strong>
														</td>
														<td>
															<strong><span>".strtoupper($hbacc[$i])."</span></strong>
														</td>
														</tr>";
													
													if(strtoupper($tempRow["bank"]) == "BRI"){
														echo "	<tr>
																<td>
																	&nbsp;
																</td>
																<td style='padding:10px;'>
																	<a onclick=openRequestedPopup('https://ib.bri.co.id/ib-bri/','BRI') target='POP' class='btn btn-login' style='cursor:pointer;font-size: 21px;'>Login BRI</a>
																</td>
																<td>
																	&nbsp;
																</td>
																<td>
																	&nbsp;
																</td>
															</tr>";
													}
															
													if(strtoupper($tempRow["bank"]) == "BCA"){
														echo "	<tr>
																<td>
																	&nbsp;
																</td>
																<td style='padding:10px;'>
																	<a onclick=openRequestedPopup('https://ibank.klikbca.com/','BCA') target='POP' class='btn btn-login' style='cursor:pointer;font-size: 21px;'>Login BCA</a>
																</td>
																<td>
																	&nbsp;
																</td>
																<td>
																	&nbsp;
																</td>
															</tr>";
													}
															
													if(strtoupper($tempRow["bank"]) == "MANDIRI"){
														echo "	<tr>
																<td>
																	&nbsp;
																</td>
																<td style='padding:10px;'>
																	<a onclick=openRequestedPopup('https://ib.bankmandiri.co.id','MANDIRI') target='POP' class='btn btn-login' style='cursor:pointer;font-size: 21px;'>Login MANDIRI</a>
																</td>
																<td>
																	&nbsp;
																</td>
																<td>
																	&nbsp;
																</td>
															</tr>";
													}
															
													if(strtoupper($tempRow["bank"]) == "BNI"){
														echo "	<tr>
																<td>
																	&nbsp;
																</td>
																<td style='padding:10px;'>
																	<a onclick=openRequestedPopup('https://ibank.bni.co.id/','BNI') target='POP' class='btn btn-login' style='cursor:pointer    ;font-size: 21px;'>Login BNI</a>
																</td>
																<td>
																	&nbsp;
																</td>
																<td>
																	&nbsp;
																</td>
															</tr>";
													}
												$check = "";
											}
										?>
										</table>
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

                                    <p class="attention">*Kami tidak menerima transfer tunai dan deposit dari rekening atas nama org lain, terima kasih.</p>

                                    <div class="space_10"></div>

                                    <div class="form-group-full">
                                        <button type="submit" value=kirim name=submit class="btn btn-submit">Kirim</button>
                                    </div>
                                </form>
                        	<?php
                        	}
                            ?>
	                        </div>
	                    </div>
						<?php 
						} 
						?>
                    </div>
				
                    <div class="clear space_30"></div>
                </div>
            </div>
	
<script>
	
function openRequestedPopup(link, title) {
	var windowObjectReference;
	var strWindowFeatures ="toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=1,scrollbars=1";
	var w = 830;
	var h = 830;
	var windowX = Math.ceil( (window.screen.width  - (w)) / 2 );
	var windowY = Math.ceil( (window.screen.height - (h)) / 2 );
	splash = windowObjectReference = window.open(link, title, strWindowFeatures);
	splash.resizeTo( Math.ceil( w )       , Math.ceil( h ) );
	splash.moveTo  ( Math.ceil( windowX ) , Math.ceil( windowY ) );
}
</script>
<?php
include("footer.php");
?>