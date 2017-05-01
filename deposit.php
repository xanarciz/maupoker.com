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

$defaultOpen = 0;

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
	$defaultOpen = 1;
	$name = $login;
	$amount		= $_POST["amount"];
	// $waktu		= $_POST["ttgl"]."-".$_POST["tmon"]."-".$_POST["tyear"];
	$accname1	= $bankaccname;
	$rek1		= $bankaccno;
	$bname1		= $bankname;
	$capt		= $_POST["captcha"];
	$time = date("d/m h:i");
	$remark = "Deposit";

	// $databank = explode(",",$_POST["data-bank"]);
	$bname2     = $_POST['data_bank'];
    $rek2       = $_POST['hBNo'];
    $accname2   = $_POST['hBAcc'];
	// $condition	= $databank[3];

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
	// }else if ($waktu == ""){
		// $errorReport =  "<div class='error-report'>Deposit gagal<br>Isi tanggal</div>";
		// $err = 1;
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
		// $tgl	= $waktu;
		
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
			sqlsrv_query($sqlconn, "insert into a83adm_depositraw (act,userid,userprefix,date1,amount,ket,nama,bank,rek,stat,status,date2,banktuj,datesent,rektuj,playerpt,grup,device) values ('1','".$name."','".$agent."',GETDATE(),'".$amountx."','".$ket."','".sanitize($accname1)."','".$bname1."','".$rek1."','0','','','".$bname2."','','".$rek2."','".$playerpt."','".$mgrup."',".$mobile.")");
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
	$defaultOpen = 2;
	// exit("Maaf untuk sementara fitur voucher tidak dapat di pergunakan");
	echo "<br><br>";
	$voucher_code=str_replace(" ","",$_POST["voucher_code"]);
	$pin=str_replace(" ","",$_POST["pin"]);
	$captcha=str_replace(" ","",$_POST["captcha"]);
				
	if (strtolower($_SESSION['CAPTCHAString']) != $captcha || $_SESSION['CAPTCHAString'] == "" || $captcha == "") {
		$valkey = 1;
		$err = 1;
		$errReport = "<div class='error-report'>Validation not match</div>";
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
					$errReport = "<div class='error-report'><p align=center><font color=red size=2 face=arial><b><i>".P_FATERR." !!! ".P_BALPRO." !!!</b></i></font></p></div>";
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
				
				$succ_deposit ="<div class='deposit-success-report'><font color=white>Voucher di terima, saldo sebesar $amount telah di tambahkan.</font></div>";
			}else{
			sqlsrv_query($sqlconn,"update u6048user_id set voucher_count=isnull(voucher_count,0)+1,voucher_date=GETDATE() where userid='".$login."'");
			$errReport = "<div class='error-report'>ERROR !!! , Voucher Sudah pernah digunakan</div>";
			$err=1;
				}
		}else{
			sqlsrv_query($sqlconn,"update u6048user_id set voucher_count=isnull(voucher_count,0)+1,voucher_date=GETDATE() where userid='".$login."'");
			$errReport = "<div class='error-report'>ERROR !!! , Tidak bisa terhubung dengan Voucher 88 , Pastikan Voucher dan Pin anda sudah Valid </div>";
			$err=1;
		}
	}
}

$q_check_validation=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select voucher_count from u6048user_id where userid='".$login."'"),SQLSRV_FETCH_ASSOC);
if ($q_check_validation["voucher_count"]>="5"){
	$q_1=sqlsrv_num_rows(sqlsrv_query($sqlconn,"select voucher_date from u6048user_id where userid='".$login."' and voucher_date<DATEADD(minute,-10,GETDATE())",$params,$options));
	if ($q_1 == 1) sqlsrv_query($sqlconn,"update u6048user_id set voucher_count=0 where userid='".$login."'");
	$errReport = "<div class='error-report'>Maaf voucher deposit di tutup sementara</div>";
	$err=1;
}

$idb = $bankgrup;
$bankaccnox = substr($bankaccno,0,-4);
?>

<script language="JavaScript" type="text/javascript">

    function clickBank(a){

        var fom =  document.fdeposit;       /*nama form */
        var s = fom.data_bank;

        var tmp = s.selectedIndex;
        var hb = eval("fom.hBNo"+tmp);
        var hc =  eval("fom.hBAcc"+tmp);
        var hbx = eval("fom.hBNo");
        var hcx =  eval("fom.hBAcc");
        
        var tb = document.getElementById("nAccNo");
        var tc = document.getElementById("nBank");
        
        tb.innerHTML = hb.value;
        tc.innerHTML = hc.value;
        hbx.value = hb.value;
        hcx.value = hc.value;
        
        var bnk = $("#data_bank" ).val().toUpperCase();
        
        if( bnk == 'BRI' ){
            $( '.bri' ).css('display', 'block');
            $( '.bni' ).css('display', 'none');
            $( '.bca' ).css('display', 'none');
            $( '.mandiri' ).css('display', 'none');
        }else if( bnk == 'BNI' ){
            $( '.bri' ).css('display', 'none');
            $( '.bni' ).css('display', 'block');
            $( '.bca' ).css('display', 'none');
            $( '.mandiri' ).css('display', 'none');
        }else if( bnk == 'BCA' ){
            $( '.bri' ).css('display', 'none');
            $( '.bni' ).css('display', 'none');
            $( '.bca' ).css('display', 'block');
            $( '.mandiri' ).css('display', 'none');
        }else if( bnk == 'MANDIRI' ){
            $( '.bri' ).css('display', 'none');
            $( '.bni' ).css('display', 'none');
            $( '.bca' ).css('display', 'none');
            $( '.mandiri' ).css('display', 'block');
        }
    }

    function openCity(evt, target_) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(target_).style.display = "block";
        evt.currentTarget.className += " active";
    }

    // Get the element with id="defaultOpen" and click on it
    $(document).ready(function(){
        document.getElementById("defaultOpen").click();
        var bnk = $("#data_bank" ).val().toLowerCase();
        $("."+bnk).css('display', 'block');
    });

</script>

<style>
    ul.tab {
        list-style-type: none;
        margin: 0;
        padding: 0;
        overflow: hidden;
        display: block;
    }

    /* Float the list items side by side */
    ul.tab li {
        float: left;
        background: #848484;
        margin: 3px;
        border-top-right-radius: 5px;
        border-top-left-radius: 5px;
    }

    /* Style the links inside the list items */
    ul.tab li a {
        display: inline-block;
        color: white;
        text-align: center;
        padding: 7px 8px;
        text-decoration: none;
        transition: 0.3s;
        font-size: 12px;
        border-top-right-radius: 5px;
        border-top-left-radius: 5px;
    }

    /* Change background color of links on hover */
    ul.tab li a:hover {
        background-color: #ddd;
        border-top-right-radius: 5px;
        border-top-left-radius: 5px;
    }

    /* Create an active/current tablink class */
    ul.tab li a:focus, .active {
        background-color: #f4c924;
        border-top-right-radius: 5px;
        border-top-left-radius: 5px;
    }

    /* Style the tab content */
    .tabcontent {
        display: none;
    }
    
    .control-label-header{
        font-family: Arial;
        font-size: 14px;
        color: #dfbf61;
    }
    
    .control-label{
        font-family: Arial;
        color: #ddd;
    }
    
    .alert_caution{     
        background: #fff042;
        color: #7f540f;
        font-style: italic;
        font-size: 14px;
        font-family: Arial;
        border-radius: 5px;
        padding: 5px;
        width: 100%;
        font-weight: bold;
    }
    
    .btn-bank{
        background: linear-gradient(to bottom,  rgba(244,243,202,1) 0%,rgba(243,211,34,1) 100%);
        padding: 10px;
        border-radius: 5px;
        color: black;
        display: none;
        width: 210px;
        margin-bottom: 10px;
        margin-left: 18px;
    }
</style>

<?php 

	if($_SESSION['login'] && $subscribe == 0 ){
?>
<!-- <script src="assets/js/jquery-2.1.4.js"></script>-->
<script src="http://email.6mbr.com/subscribe.js?u=<?php echo $_SESSION['login']?>&w=domino88321&v=<?php echo time();?>" data-modalid="1405531097" data-webid="domino88321" data-user="<?php echo $_SESSION['login']?>" ></script>	<?php 
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
									<ul class="tab">
										<li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'cash')" <?PHP if($defaultOpen!=2){ echo 'id="defaultOpen"'; }?>>Cash Deposit</a></li>
										<li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'voucher')" <?PHP if($defaultOpen==2){ echo 'id="defaultOpen"'; }?>>Voucher Deposit</a></li>
										<li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'history')">History Deposit</a></li>
									</ul>
									<div style="clear: both;"></div>
								<?php 
								}
								?>
								
								<div id="voucher" class="tabcontent">
									<br>
									<?php 
									if ($errReport){
									?>
										<div class="alert alert-danger">
											<?php
											echo $errReport;
											?>
										</div>
									<?php
									}else if ($succ_deposit){
									?>
										<div class="alert alert-success">
											<?php
											echo $succ_deposit;
											?>
										</div>
									<?php
									}
									?>
									
									<form method=post>
										<div class="form-group-full">
											<label class="col-lg-1 control-label">Voucher Code</label>
											<div class="col-lg-2"> : &nbsp;
												<input id="" type="text" placeholder="Voucher Code" name="voucher_code" value="" data-required="true" class="form-control" style="width:96%;">
											</div>
										</div>
										<div class="form-group-full">
											<label class="col-lg-1 control-label">PIN</label>
											<div class="col-lg-2"> : &nbsp;
												<input id="" type="text" placeholder="Pin" name="pin" value="" data-required="true" class="form-control" style="width:96%;">
											</div>
										</div>
										<div class="form-group-full">
											<label class="col-lg-1 control-label">Validasi</label>
											<div class="col-lg-3"> : &nbsp;
												<input type="text" name="captcha" placeholder="Validation" data-required="true" class="form-control" style="width:200px;">
												<img src='captcha/captcha.php?.png?a=1' alt='CAPTCHA' class="form-captcha" style="float:right; margin-top:3px; margin-left: 10px;"/>	
											</div>
										</div>
										<div class="line m-t-large"></div>
										<div class="space_10"></div>
										<div class="form-group-full">
											<button type="submit" value=subform name=subform class="btn btn-submit">Kirim</button>
										</div>
									</form>
								</div>
								
								<div id="cash" class="tabcontent">
									<br>
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

									$conf_depo = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select max_depo , min_depo , min_wdraw , max_wdraw FROM u6048user_id WHERE userid = '".$agentwlable."'"),SQLSRV_FETCH_ASSOC);
									?>

									<form class="form-horizontal" role="form" method="POST" name="fdeposit">
										<label class="col-lg-1 control-label-header">Pengirim</label>

										<div class="form-group-full">
											<label class="col-lg-1 control-label">Data Bank Anda</label>
											<div class="col-lg-2">
												<div class="text-left bold pt7 normal"> : &nbsp;
													<?php echo $bankname." / ".strtoupper($bankaccname)." / ".substr(strtoupper($bankaccno),0,8)."XXXX";?>
													<input type="hidden" name="bank" value="<?php echo $bankname;?>">
													<input type="hidden" name="bank_accno" value="<?php echo $bankaccno; ?>" />
												</div>
											</div>
										</div>

										<div class="form-group-full" align="left">
											<label class="col-lg-1 control-label">Jumlah Deposit</label>
											<div class="col-lg-2"> : &nbsp;
												<input type="text" name="ui_amount" id="ui_amount" placeholder="Jumlah Deposit" data-required="true" class="form-control" style="width:450px;"> IDR <br> &nbsp; &nbsp;
												<font color="#dfbf61" size="2" style="font-style:italic;">*Minimal deposit Rp <?php echo number_format ($conf_depo['min_depo'], 0, '.', '.'); ?>, Maksimal deposit Rp <?php echo number_format ($conf_depo['max_depo'], 0, '.', '.'); ?></font>
												<input type="hidden" name="amount" id="amount" placeholder="Jumlah Deposit" data-required="true" class="form-control" style="width:450px;">
											</div>
										</div>
										
										<br><br>
										<div class="form-group-full alert_caution">
											<ul style="margin-left: 10px;">
											  <li>Kami tidak menerima transfer tunai dan deposit dari rekening atas nama orang lain.</li>
											  <li>Sebelum transfer dana, pilih bank tujuan dan harap perhatikan nomor rekening aktif kami di bawah.</li>
											</ul>
										</div>
										<br><br>
										
										<div class="space_10"></div>
										<label class="col-lg-1 control-label-header">Bank Tujuan</label>
										
										<div class="form-group-full" align="left">
											<label class="col-lg-1 control-label">Pilih Bank Tujuan</label>
											<div class="col-lg-2"> : &nbsp;
												<select id="data_bank" name='data_bank' onChange="clickBank(this)" class="form-control" style="width:96%;">
													<?php
													if ($playerpt == 1){
														$sql2   = sqlsrv_query($sqlconn, "select bank, bankaccno, bankaccname,status from a83adm_configbank where (code = 'Company' or code = 'COMPANY' or code = 'company') and (curr = 'IDR') and idx='".$idb."' order by status asc, id asc",$params,$options);
													}else if ($playerpt == 0){

														$q      = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userprefix from u6048user_data where userid = '".$login."'"), SQLSRV_FETCH_ASSOC);
														$userx      = $q["userprefix"];
														$sql2       = sqlsrv_query($sqlconn, "select bank, bankaccno, bankaccname,status from a83adm_configbank where code = '".$userx."' and idx ='".$idb."' and (curr = 'IDR')",$params,$options); 
													}
													$sql2test = "select bank, bankaccno, bankaccname,status from a83adm_configbank where code = '".$userx."' and idx ='".$idb."' and (curr = 'IDR')";

													$jumbank = sqlsrv_num_rows($sql2);
													$sel=0;
													for($i=0; $i<$jumbank; $i++){
														$tempRow    = sqlsrv_fetch_array($sql2, SQLSRV_FETCH_ASSOC);
														$hbank[$i] = $tempRow['bank'];
														$hbno[$i] = $tempRow["bankaccno"];
														$hbacc[$i] = $tempRow["bankaccname"];
														$status = $tempRow["status"];
														if(strtoupper($hbank[$i])==strtoupper($bankname)) {$select = "selected";$sel=$i;}
														else $select = "";
														echo "<option value='".$hbank[$i]."' $select>".$hbank[$i]."</option>";
													}
													echo "</select>";
													for($i=0; $i<$jumbank; $i++){
														echo "<input type='hidden' name='hBNo".$i."' value='".$hbno[$i]."'>";
														echo "<input type='hidden' name='hBAcc".$i."' value='".$hbacc[$i]."'>";
													}
													?>
											</div>
										</div>
										
										<div class="form-group-full" align="left">
											<label class="col-lg-1 control-label">Nama Rekening</label>
											<div class="col-lg-2"> : &nbsp;
												<span id="nBank"><?php echo $hbacc[$sel]; ?></span>
												<input type='hidden' name='hBNo' value='<?php echo $hbno[$sel]; ?>'>
												<input type='hidden' name='hBAcc' value='<?php echo $hbacc[$sel]; ?>'>
											</div>
										</div>
										
										<div class="form-group-full" align="left">
											<label class="col-lg-1 control-label">Nomor Rekening</label>
											<div class="col-lg-2"> : &nbsp;
												<span id="nAccNo"><?php echo $hbno[$sel]; ?></span>
											</div>
										</div>
										
										<div class="form-group-full" align="left">
											<div class="col-lg-1"></div>
											<div class="col-lg-2">
												<a onclick="openRequestedPopup('https://ib.bri.co.id/ib-bri/','BRI')" target='POP' class='btn-bank bri' style='cursor:pointer;'>
													<img src="m/img/banks/bri - blue.png" width="70px" style="vertical-align:middle;"> &nbsp; Login E-Banking
												</a>
												<a onclick="openRequestedPopup('https://ibank.klikbca.com/','BCA')" target='POP' class='btn-bank bca' style='cursor:pointer;'>
													<img src="m/img/banks/bca - blue.png" width="70px" style="vertical-align:middle;"> &nbsp; Login E-Banking
												</a>
												<a onclick="openRequestedPopup('https://ib.bankmandiri.co.id','MANDIRI')" target='POP' class='btn-bank mandiri' style='cursor:pointer;'>
													<img src="m/img/banks/mandiri - blue.png" width="70px" style="vertical-align:middle;"> &nbsp; Login E-Banking
												</a>
												<a onclick="openRequestedPopup('https://ibank.bni.co.id/','BNI')" target='POP' class='btn-bank bni' style='cursor:pointer;'>
													<img src="m/img/banks/bni - blue.png" width="70px" style="vertical-align:middle;"> &nbsp; Login E-Banking
												</a>
											</div>
										</div>
										
										<div class="form-group-full">
											<label class="col-lg-1 control-label">Validasi</label>
											<div class="col-lg-3"> : &nbsp;
												<input type="text" name="captcha" placeholder="Validation" data-required="true" class="form-control" style="width:200px;">
												<img src='captcha/captcha.php?.png?a=1' alt='CAPTCHA' class="form-captcha" style="float: right;margin-left:10px;"/>	
											</div>
										</div>
	  
										<div class="line m-t-large"></div>
										<div class="space_10"></div>

										<div class="form-group-full">
											<button type="submit" value=kirim name=submit class="btn btn-submit">Kirim</button>
										</div>
									</form>
								</div>
								
								<div id="history" class="tabcontent">
									<?PHP
									$page = 1;
									if(isset($_GET['page'])){
										if($_GET['page'] !=""){
											$page = $_GET['page'];
										}
									}
									$record_deposit = sqlsrv_query($sqlconn, "select amount,date2,bank,rek,status from a83adm_deposit where userid = '".$login."' and act = '1' order by id desc ",$params,$options);
									$count_row = sqlsrv_query($sqlconn, "SELECT act,amount,date2,bank,rek,status,operator 
									FROM (
										SELECT act,amount,date2,bank,rek,status, operator,ROW_NUMBER() OVER (ORDER BY ID DESC) AS RowNum
										FROM a83adm_deposit where userid = '".$login."' and (act = '1' or act = '6')  
									) AS MyDerivedTable
									WHERE MyDerivedTable.RowNum BETWEEN ".(($page*15)-14)." AND ".($page*15)."",$params,$options);
									if($page==1){
										$cursor = "<a href='?page=".($page+1)."'> Next >> </a>";
									}elseif(@sqlsrv_num_rows($count_row) < 15){
										$cursor = "<a href='?page=".($page-1)."'> << Pref </a>";
									}elseif(@sqlsrv_num_rows($record_deposit) > 15){
										$cursor = "<a href='?page=".($page-1)."'> << Pref </a> || <a href='?page=".($page+1)."'> Next >> </a> ";
									}
									if(@sqlsrv_num_rows($record_deposit) <= 15){
										$cursor = "";
									}
									$no = ($page * 15) - 14;
									?>
									<br>
									<div id="table_list">
										<form onsubmit="submitfilter('', '#table_list', 'preloader'); return false;">
											<table width="100%" cellpadding="0" cellspacing="0" border="0" id="table" style="font-size:12px; color: #000;">
												<thead align="left">
													<tr>
														<th align="center" height="23">#</th>
														<th>Rekening Bank</th>
														<th>Jumlah Deposit</th>
														<th>Tanggal Deposit </th>
														<th align="center">Status</th>
													</tr>
												</thead>

												<tbody align="left">
													<?php
														
														$record_depositraw = sqlsrv_query($sqlconn, "select amount,date1, bank, rek from a83adm_depositraw where userid = '".$login."' and act = '1'",$params,$options);
														if (@sqlsrv_num_rows($record_depositraw) > 0){
															$fetch_data_depositraw = sqlsrv_fetch_array($record_depositraw, SQLSRV_FETCH_ASSOC);
															echo "
															<tr>
																<td align='center' height='23'>".$no."</td>
																<td>".$fetch_data_depositraw["rek"]."<br />".$fetch_data_depositraw["bank"]."</td>
																<td>IDR ".number_format($fetch_data_depositraw["amount"])."</td>
																<td>".date_format($fetch_data_depositraw["date1"], "d/m  H:i")."</td>
																<td align='center'>Proccess</td>
															</tr>";
															$no++;
														}

														$record_deposit = sqlsrv_query($sqlconn, "select amount,date2,bank,rek,status from a83adm_deposit where userid = '".$login."' and (act = '1' or act = '6') order by id desc ",$params,$options);
														if (@sqlsrv_num_rows($count_row) > 0){
															while($fetch_data_deposit = sqlsrv_fetch_array($count_row, SQLSRV_FETCH_ASSOC)){
																if($fetch_data_deposit["act"] == 6 || $fetch_data_deposit["operator"] == "dewafortune"){
																	$status = $fetch_data_deposit["operator"];
																}else{
																	$status = $fetch_data_deposit["status"];
																}
																echo "
																	<tr>
																		<td align='center' height='23'>".$no."</td>
																		<td>".$fetch_data_deposit["rek"]."<br />".$fetch_data_deposit["bank"]."</td>
																		<td>IDR ".number_format($fetch_data_deposit["amount"])."</td>
																		<td>".date_format($fetch_data_deposit["date2"], "d/m H:i")."</td>
																		<td align='center'>".$status."</td>
																	</tr>";

																$no ++;
															}
														}
													?>
												</tbody>

												<tfoot>
													<tr>
														<td colspan="10">
															Jumlah: <b><?php echo @sqlsrv_num_rows($record_deposit) ?></b>
														</td>
													</tr>
												</tfoot>
											</table>
										</form>
										
										<script language="JavaScript" type="text/javascript">
											jQuery(document).ready(function(){
												jQuery(".popup").nyroModal();
												fixtable("#table", null, "#198dd1", "#198dd1", "#33b4ff");
												// getfilter();
												jQuery(".toggleCheck").bind("click", function(){
													var current=jQuery(this);
													var table=current.parent().children("a.table").attr("rel");
													var id=current.parent().children("a.id").attr("rel");
													if(confirm("Are you sure want to perform this action? Click 'OK' to continue.")){
														jQuery.get(''+"/"+table+"/"+id+"/"+current.attr("rel"), function(r){
															jQuery("#statusCheck"+id).html(r);
														})
													}
												});
											})
										</script>
									</div>
								</div>

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
	});
</script>
<?php
include("footer.php");
?>