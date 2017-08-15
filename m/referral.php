<?php
$page='referral';
session_start();
$login = $_SESSION["login"];

if (!$login){
    include("_meta.php");
} else {
    include("_metax.php");
	// include("../function/jcd-umum.php");
}
include("_header.php");

// if (!$login)exit("<script>location.href='index.php'</script>");

function currx($val) {
   if (!strpos($val,".")) return number_format($val, 0,'.', ',');
   else return number_format($val, 1,'.', ',');
}

function pass_validation($user , $pass){
	$ps = strtolower($pass);
	$us = strtolower($user);
	$pass_rejected_db = ["Abc123","ABc123","Asd123","ASd123"]; 
	if (strpos($pass,$user) == false) {
		$contain = true;
	}else{
		$contain = false;
	}
	if($pass == $user || $ps == $us || $contain == false || substr($pass,0,3) == substr($user,0,3)){
		Return ("Password tidak boleh mengandung USERID");
		
		
	}elseif (in_array($pass, $pass_rejected_db)) {
		
		Return ("Password di tolak, silahkan pilih password yang lain");
		
	}elseif (preg_match("(^(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*_]).+$)",$pass) == false){
		
		Return ("Password harus kombinasi huruf angka dan simbol (ex : Ex@mple123)");
		
	}else{
		
		return true;
		
	}
	
}

if ( $login ){
	$_GET = sanitize($_GET);
	$_POST = sanitize($_POST);
	/*$user = $_GET["userid"];
	$date = $_GET["date"];*/
	//if($user == "" || $date == "")die(" <font color=white>Access Denied</font>");
	$userpass = $upass;
	//if($userpass != $date)die("<font color=white>Access Denied</font>");

	$sub = $_GET["st"];
	if(!$sub)$sub=5;
	$j = $_GET["j"];
	if(!$j)$j=1;
	$batas = $_GET["batas"];
	$sql = sqlsrv_query($sqlconn, "select userid from u6048user_id where referral_agent = '".$login."'",$params,$options);
	$row = sqlsrv_num_rows($sql);
	$time = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select paycom_date from a83adm_config"), SQLSRV_FETCH_ASSOC);
	$subtotal = 0;
	$commision = 0;
	$subcomm = 0;
	$grandcomm = 0;
}

$cref=$agentwlable;
$noRek	= "1";
$pt = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select playerpt_status from a83adm_config"),SQLSRV_FETCH_ASSOC);
$buka = $pt["playerpt_status"];
if($buka == 0) die("Cannot Open this page.");

$curr = $_POST["Curr"];
$ref = strtoupper($_COOKIE["ref"]);
if (!$ref)$ref="";
if($_POST["submit"]){
?>
	<script>
		$(document).ready(function () {
			$('.ui-tabs-active').removeClass('ui-tabs-active ui-state-active ui-state-hover');
			$('.tab-ref').tabs({active: 1});
		});
	</script>
<?php

	$cekr = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select registration from a83adm_config2"),SQLSRV_FETCH_ASSOC);
	$cekr = $cekr["registration"];
	if($cekr == "0"){echo "<div class='error-report'>Registration Tempolary Closed</div>";
		die();
	}
	$fname = $_POST["FName"];
	$uname = str_replace("''","*",$_POST["UName"]);
	$unameid = str_replace("''","*",$_POST["UNameid"]);
	$pass = $_POST["Pass"];
	$cpass = $_POST["CPass"];
	$email = $_POST["Email"];
	$phone = $_POST["Phone"];
	$bname = $_POST["BName"];
	$baname = str_replace("''","*",$_POST["BAName"]);
	$bano = $_POST["BAno"];
	$bano1 = $_POST["BAno1"];
	$bano2 = $_POST["BAno2"];
	$curr = $_POST["Curr"];
	$pv = pass_validation($uname , $pass);
	/* if (!$ref){
		$referral_text = $_POST["ref_text"];
		if ($referral_text){
			$check_userid = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select userid from u6048user_id where loginid = '".$referral_text."' and userprefix='".$agentwlable."'"),SQLSRV_FETCH_ASSOC);
			if ($check_userid["userid"])$login=$check_userid["userid"];
			else $ref_error="#error_name";
		}
	}else{
		$check_userid = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select userid from u6048user_id where loginid = '".$ref."' and userprefix='".$agentwlable."'"),SQLSRV_FETCH_ASSOC);
		$login=$check_userid["userid"];
	} */
	//GENERATE RANDOM USERID
	/*
	do{
		$unameid = RandomString();
		$isexist = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select userid from u6048user_id where userid = '".$unameid."'",$params,$options));
	}while($isexist>0);
	$unameid = strtoupper($unameid);
	*/
	$uname = strtoupper($uname);
	$unameid = strtoupper($unameid);
	
	$capt = $_POST["captcha1"];
	
	if (strpos($fname,"<") or strpos($fname,">")){
		$cekw = 1;
	}
	else if (strpos($phone,"<") or strpos($phone,">")){
		$cekw = 1;
	}
	else if (strpos($email,"<") or strpos($email,">")){
		$cekw = 1;
	}
	else if (strpos($baname,"<") or strpos($baname,">")){
		$cekw = 1;
	}
	else if (strpos($pass,"<") or strpos($pass,">")){
		$cekw = 1;
	}
	else if (strpos($cpass,"<") or strpos($cpass,">")){
		$cekw = 1;
	}

	$bano4 = $bano;
	$bano = str_replace("-","",$bano);
	if( strtoupper($_POST["BName"])=='MANDIRI'){
		$cx1=substr($bano,0,3);
		$cx2=substr($bano,3,3);
		$cx3=substr($bano,6,3);
		$cx4=substr($bano,9,4);
		$banox=$cx1."-".$cx2."-".$cx3."-".$cx4;
	}else if (strtoupper($_POST["BName"])=='BCA' || strtoupper($_POST["BName"])=='BNI'){
		$cx1=substr($bano,0,3);
		$cx2=substr($bano,3,3);
		$cx3=substr($bano,6,4);
		$banox=$cx1."-".$cx2."-".$cx3;
	}else if (strtoupper($_POST["BName"])=='BRI'){
		$cx1=substr($bano,0,3);
		$cx2=substr($bano,3,3);
		$cx3=substr($bano,6,3);
		$cx4=substr($bano,9,3);
		$cx5=substr($bano,12,3);
		$banox=$cx1."-".$cx2."-".$cx3."-".$cx4."-".$cx5;
	}else if (strtoupper($_POST["BName"])=='DANAMON'){
		$cx1=substr($bano,0,3);
		$cx2=substr($bano,3,3);
		$cx3=substr($bano,6,3);
		$cx4=substr($bano,9,3);
		
		$banox=$cx1."-".$cx2."-".$cx3."-".$cx4;
	}

	$bano5=$banox;
	$cekrekno = sqlsrv_query($sqlconn, "select no_rek,bank from a83adm_nobankrek where no_rek LIKE '".$bano4."%'",$params,$options);
	for ($c=0; $c<sqlsrv_num_rows($cekrekno); $c++){
		$cekd = sqlsrv_fetch_array($cekrekno,SQLSRV_FETCH_ASSOC);
		$cekn = preg_match("/".$cekd["no_rek"]."/", $bano, $match, PREG_OFFSET_CAPTURE);
		$cekm = preg_match("/".strtoupper($cekd["bank"])."/", strtoupper($bname), $match, PREG_OFFSET_CAPTURE);

		if ($cekm > 0 && $cekn > 0){
			$cekb = 1;
			break;
		}
	}
	$tes=strtolower($bname);
	//echo $tes;

	if(strlen($tes) > 0){
		if($tes=="bca"){
			if(strlen($bano) != 10) {
				$ceke=1;
			}
		}else if($tes=="bni"){
			if(strlen($bano) < 9) {
			$ceke=3;
				
			}
			if(strlen($bano) > 10){ 
				$ceke=3;
			}
		}else if($tes=="mandiri"){
			if( strlen($bano) != 13 ) {
				$ceke=2;
			}
		}else if($tes=="bri"){
			if(strlen($bano) != 15) {
				$ceke=4;
			}
		}
	}

	$jumuser = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from u6048user_id where loginid = '".$uname."'",$params,$options));
	$jumuserx = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from u6048user_id where userid = '".$unameid."'", $params,$options));
	$jumuserxx = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from j2365join_onlinex where userid = '".$unameid."'", $params,$options));
	$jumuserxxx = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from u6048user_data where userid = '".$unameid."'", $params,$options));
	
	foreach (count_chars($uname, 1) as $i => $val) {
		if($i > 47 && $i < 58) {  }
		else if($i > 64 && $i < 91) {  }
		else if($i > 96 && $i < 123) {  }
		else if($i == 95){}
		else {
			//die ('<center><font color=red><b>Error:  Cek Username!</b></font>&nbsp;</center>');
			$ckuser = 1;
		}
	}
	foreach (count_chars($unameid, 1) as $i => $val) {
		if($i > 47 && $i < 58) {  }
		else if($i > 64 && $i < 91) {  }
		else if($i > 96 && $i < 123) {  }
		else if($i == 95){}
		else {
			//die ('<center><font color=red><b>Error:  Cek Username!</b></font>&nbsp;</center>');
			$ckuser = 3;
		}
	}
	foreach (count_chars($bano, 1) as $i => $val) {
		if($i > 47 && $i < 58) {  }

		else {
			//die ('<center><font color=red><b>Error:  Cek Username!</b></font>&nbsp;</center>');
			$ckuser = 2;
		}
	}
	if ( !preg_match('/[^A-Za-z0-9 ]/', $bname) ){
		//safe
	}else{
		$bname_error = 1;
	}

	$gettgl = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select top 1 convert(varchar, joindate,20) as tgl from u6048user_id order by joindate desc"),SQLSRV_FETCH_ASSOC);
	$hari=mktime (date("H"),date("i"),date("s")-5,date("m"),date("d"),date("Y"));
	$sekarang=date("Y-m-d H:i:s",$hari);

	$tglx = $gettgl["tgl"];

	$ip = $_SERVER['REMOTE_ADDR'];
	
	$rejpas = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select pass from a83adm_rejectpass where pass='".strtoupper($pass)."'",$params,$options));
	$cekrej = sqlsrv_query($sqlconn, "select userid from a83adm_rejectuserid",$params,$options);
	for ($j=0; $j<sqlsrv_num_rows($cekrej); $j++){
		$cekj = sqlsrv_fetch_array($cekrej,SQLSRV_FETCH_ASSOC);
		$cekid = preg_match("/\b".$cekj["userid"]."/", strtoupper($uname), $match, PREG_OFFSET_CAPTURE);
		if ($cekid > 0){
			$rejid = 1;
			break;
		}	
	}
	
	$cekemail	= sqlsrv_num_rows(sqlsrv_query($sqlconn, "select email from u6048user_id where email = '".$email."' and userprefix='".$cref."'",$params,$options));
	$cekBankNo	= sqlsrv_num_rows(sqlsrv_query($sqlconn, "select bankaccno from u6048user_id where bankaccno = '".$bano5."' and userprefix='".$cref."'",$params,$options));
	$te = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select ip from a83adm_ipblok where ip = '".$ip."'",$params,$options));
	
	
	/*
	check blocking bank
	*/
	$blocking_bank = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select * from a83adm_nobankrek where no_rek = '".$banox."' or no_rek = '".$bano4."'",$params,$options));
	
	
	if (!checkCaptcha('CAPTCHAString', $capt)){
		$errorReport =  "<div class='error-report'>Validasi Anda salah.</div>";
	}else if($pv !== true){ 
		$errorReport =  "<div class='error-report'>".$pv."</div>"; 
	}else if($te > 0){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal!</div>";
	}else if($jumuser > 0 || $jumuserx > 0 || $jumuserxx > 0 || $jumuserxxx > 0){
		if( $jumuserx > 0) $errorReport = "<div class='error-report'>Pendaftaran gagal.<br>Nickname telah terdaftar.</div>";
		else $errorReport = "<div class='error-report'>Pendaftaran gagal.<br>Username telah terdaftar.</div>";
//	}else if ($ckuser == 2) {
//		$errorReport = "<div class='error-report'>Ilegal karakter di Nomor Rekening.<br> Error nomor rekening</div>";
	}else if(strlen($uname) > 10 || strlen($unameid) > 10){
		$errorReport = "<div class='error-report'>Pendafataran gagal.<br>Max. Login ID dan Nickname  8 huruf</div>";
	}else if(strlen($uname) < 3 || strlen($unameid) < 3){
		$errorReport = "<div class='error-report'>Pendafataran gagal.<br>Min. Login ID dan Nickname  3 huruf</div>";
	}else if (!preg_match("/[A-Z]/",substr($uname,0,1))){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Karakter pertama dari Username harus A-Z.</div>";
	}/*else if (!preg_match("/[A-Z]/",substr($unameid,0,1))){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Karakter pertama dari Nickname harus A-Z.</div>";
	}*/else if(!filter_var($email, FILTER_VALIDATE_EMAIL)){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Harap cek Email.</div>";
	}else if(($uname == "") || ($unameid == "") || ($pass == "") || ($cpass == "") || ($email == "") || ($phone == "")){
		$errorReport =("<div class='error-report'>Pendaftaran Gagal.<br>Tidak boleh ada yang kosong.</div>");
	}else if ($pass != $cpass){
		$errorReport =	("<div class='error-report'>Pendaftaran Gagal.<br>Password tidak sesuai.</div>");
	}else if ($ckuser == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br> Username salah</div>";
	}else if ($ckuser == 3) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br> Nickname salah</div>";
	}else if (strlen($pass) < 5) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br> Password mininum 5 Digit</div>";
//	}else if ($bname_error == 1) {
//		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br> cek Bank Name</div>";
//	}else if ($ceke == 1) {
//		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun BCA harus memiliki 10 digit nomor </div>";
//	}else if ($ceke == 2) {
//		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun MANDIRI harus memiliki 13 digit nomor </div>";
//	}else if ($ceke == 3) {
//		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun BNI harus memiliki 9 atau 10 digit nomor </div>";
//	}else if ($ceke == 4) {
//		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun BRI harus memiliki 15 digit nomor </div>";
//	}else if ($cekb == 1) {
//		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Pendaftaran Bank gagal </div>";
	}else if ($rejid == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Username sudah terdaftar </div>";
	}else if ($ref_error == "#error_name") {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Referral Anda salah</div>";
	}else if ($cekw == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.</div>";
	}else if($cekemail>=1){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Email sudah pernah terdaftar</div>";
	/*}else if ($sekarang < $tglx) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal</div>";*/
	}else if ($rejpas > 0) { 
		$errorReport = "<div class='error-report'>User Error, tidak dapat menggunakan password ini!</div>";
//	}else if ($noRek == '1' && $cekBankNo >= 1){
//		$errorReport = "<div class='error-report'>Maaf! akun bank ini sudah pernah di daftarkan</div>";
//	} else if($blocking_bank > 0){
//		$errorReport =  "<div class='error-report'>Bank telah ter blokir (#1022)</div>";
	} else {
		$uname = str_replace(" ","",$uname);
		$uname = strtoupper($uname);
		$unameid = str_replace(" ","",$unameid);
		$unameid = strtoupper($unameid);
		
		$depdua = base64_encode(md5("0"));
		//$bano = $bano4."-".$bano1."-".$bano2;
		
		$gamsql = sqlsrv_query($sqlconn, "select gamecode,sqltable, playerpt_dwin, playerpt_dlose from a83adm_configgame where status = '1' and status_agencygame='1'");
		$a = 0;
		$b=0;
		$c=0;
		$comsql = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select comms from a83adm_config"),SQLSRV_FETCH_ASSOC);
		$cek=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select * from u6048user_data where userid='$cref'"),SQLSRV_FETCH_ASSOC);
		if($cek["userid"] ==""){
			die("<center>Registration Failed! please contact us</center>.");
		}
		$check_user = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userid from u6048user_id where loginid = '".$uname."'"),SQLSRV_FETCH_ASSOC);
		if ($check_user){
			exit("Failed to register.");			
		}
		
		//INSERT FILTER
		$t = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"
		if exists (select userid from u6048user_id where loginid = '".$uname."')
			begin
				select '1' as hasil
			end
		else if exists (select userid from u6048user_data where userid = '".$unameid."')
			begin
				select '1' as hasil
			end
		else
			begin
				insert into u6048user_id (userid, loginid, $cfgDbPasswordfield,userprefix,referral_agent,telp,email,usertype,playerpt,deposit_type,save_deposit,joindate,status,bankgrup,subwebid,flag) values ('".$unameid."', '".$uname."','".hash("sha256",md5($pass).'8080')."','".$cref."','".$login."','".$phone."','".$email."','U','0','1','0',GETDATE(),'0','1','".$subwebid."','1')
			end"
		),SQLSRV_FETCH_ASSOC);
		if ($t["hasil"]=="1"){
			exit("Failed to register 2.");	
		}
		sqlsrv_query ($sqlconn, "insert into u6048user_coin (userid) values ('".$unameid."')");
	
		sqlsrv_query ($sqlconn, "insert into t6413txh_lastorder (userid) values ('".$unameid."')");
		while ($gamdata = sqlsrv_fetch_array($gamsql,SQLSRV_FETCH_ASSOC)){	
			$gt = $gamdata["gamecode"];
			$gs = $gamdata["sqltable"];
			$sqldatafieldaref .= ", ".strtolower($gt)."_aref_share ";
			$sqldatafieldconfig .= ", ".strtolower($gt)."_config ";
			$sqldatafieldconfigquery .= ", (select saham_referral_agent from ".strtolower($gs)."_config)";
			$sqldatafield .= ", ".strtolower($gt)."_share1, ".strtolower($gt)."_share2, ".strtolower($gt)."_autotake ";
			$sqldatavalue .= ", '".$cek[strtolower($gt)."_share1"]."', '".$cek[strtolower($gt)."_share2"]."', '0'";

			if($comsql["comms"]==1 && $data["comms"]==1){
				$dwin[$gamety] = $_POST[$gamety."dwin"];
				$dlose[$gamety] = $_POST[$gamety."dlose"];
				if(($dwin[$gamety] > $cek[$gamety."_dwin"]) || ($dlose[$gamety] > $cek[$gamety."_dlose"]) || ($dwin[$gamety] < 0) || ($dlose[$gamety] < 0)){
					echo "<center><font color=red face=arial size=2><b>".P_COM." ".P_ERR.", ".P_COM." ".$gamdata["gamename"]." ".P_EXCLIM."</b></font>&nbsp;</center>";
					die();	
				}

				if(($dwin[$gamety] == "") || $dlose[$gamety] == "") die("<center><font color=red face=arial size=2><b>".P_EMPFOR.", ".P_PLECHEAGA."!</b></font>&nbsp;</center>");

				$sqldatafield .= ", ".strtolower($gt)."_dwin, ".strtolower($gt)."_dlose";

				$sqldatavalue .= ", '".$cek[strtolower($gt)."_dwin"]."', '".$cek[strtolower($gt)."_dlose"]."'";
			}
		
			//$sharefield .= ",".strtolower($gt)."_share1,".strtolower($gt)."_share2,".strtolower($gt)."_autotake,".strtolower($gt)."_dwin,".strtolower($gt)."_dlose";
			//$sharevalue .= ",'".$cek[strtolower($gt)."_share1"]."','".$cek[strtolower($gt)."_share2"]."','".$cek[strtolower($gt)."_autotake"]."','".$cek[strtolower($gt)."_dwin"]."','".$cek[strtolower($gt)."_dlose"]."'";
			$sqldatafield .= ", ".strtolower($gt)."_dwin";
			$sqldatavalue .= ", '".$cek[strtolower($gt)."_dwin"]."'";
			$commfield .= ",".strtolower($gt)."_refcomm";
			$commfieldx .= ",".strtolower($gt)."_ptcomm";
			$datacomm = strtolower($gt)."_refcomm";
			$datacommx = strtolower($gt)."_ptcomm";
			$value = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select * from a83adm_config"),SQLSRV_FETCH_ASSOC);
			$commvalue .= ",'".$value["$datacomm"]."'";
			$commvaluex .= ",'".$value["$datacommx"]."'";
			$refus=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select userid ".$sqldatafieldaref." from u6048user_data where userid = '".$login."'"),SQLSRV_FETCH_ASSOC);
			$refuser .= $refus[strtolower($gt)."_aref_share"].",";
		}
		
		$gamsqlku = sqlsrv_query($sqlconn, "select userprefix from u6048user_id where userid = '".$unameid."'",$params,$options);
		$gamdataref = sqlsrv_fetch_array($gamsqlku,SQLSRV_FETCH_NUMERIC);
		if (sqlsrv_num_rows($gamsqlku) == 0) die("<center>Registrasi gagal, harap periksa kembali semua data Anda </center>.");
		
			
		//sqlsrv_query($sqlconn, "insert into u6048user_data (userid,usertype,referral_agent,txh_aref_share,dmm_aref_share,ebn_aref_share,bjk_aref_share,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$login."','".$txh_aref_share."','".$dmm_aref_share."','".$ebn_aref_share."','".$bjk_aref_share."','".$gamdataref[0]."','IDR','1','0','0'".$sqldatavalue.")");
		
		sqlsrv_query($sqlconn, "insert into u6048user_data (userid,usertype,referral_agent ".$sqldatafieldaref." ,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$login."',".$refuser."'".$agentwlable."','IDR','1','0','0'".$sqldatavalue.")");
		
		sqlsrv_query ($sqlconn, "insert into venus_db.dbo.userid (userid, webid, device, joindate) values ('".$unameid."', (SELECT webid FROM venus_db.dbo.website where agent = '".$agentwlable."'),1,GETDATE())");
		
		$successRegister = "<centeR><a href='http://".$DomainName."'>$DomainName</a> - Pendaftaran Sukses<br>Username = <b>$uname</b><br>Silakan Login di <a href='http://".$DomainName."'>$DomainName</a><br>Anda bisa melakukan deposit di website <a href='http://".$DomainName."'>$DomainName</a> atau melalui agent Anda.<br>Terima Kasih</center>";
		?>
		<script>
		
		setTimeout(function () {
		window.location.href = "http://<?php echo $DomainName;?>"; //will redirect to your blog page (an ex: blog.html)
		}, 5000)
		</script>
		<?php
	}
}

// if($_SESSION["login"]){
// 	$clas = "content-2";
// }else{
// 	$clas = "content";
// }
?>

<div class="content">
	<div class="lpadding-15 tpadding-5">
		<label class="ntf fs-13 tmargin-10">REFERRAL</label>
	</div>
	<hr class="margin-0 tmargin-2 bmargin-3 bg-brown-panel">

	<?PHP
		if($_SESSION["login"]){
	?>

	<div id="referral" style="max-height:auto; padding-bottom:50px;">
		<div class="padding tab-ref">
			<ul>
				<!-- <li><a href="#tabs-1">KOMISI</a></li> -->
				<li><a href="#tabs-2">DATA REF</a></li>
				<li><a href="#tabs-3">DAFTAR REF</a></li>
			</ul>

			<!-- <div id="tabs-1" style="min-height: 100vh;">
				<div class="tpadding-10 lpadding-15 rpadding-15 row">
					<div class="col-lg-6 rpadding-5">
						<label class="light-gray fs-13">Date Start</label>
						<input class="form-control bg-light-gray" type="date" name="date1" id="valdate2">
					</div>
					<div class="col-lg-6 lpadding-5 rpadding-5">
						<label class="light-gray fs-13">Date End</label>
						<input class="form-control bg-light-gray" type="date" name="date2" id="valdate2">
					</div>
				</div>
				<div class="tpadding-10 lpadding-15 rpadding-15 row">
					<input class="btn btn-blue tmargin-15" value="CARI" type="button" style="height:40px;" />
				</div>
			</div> -->

			<div id="tabs-2">
				<form onsubmit="submitfilter('', '#table_list', 'preloader'); return false;">
					<div class="row tpadding-1 bpadding-50" style="height: 450px; overflow: scroll;">					
						<table class="table" cellspacing="0" cellpadding="0" border="0">
							<thead>
								<tr>
									<th>No</th>
									<th>User ID</th>
									<th>Tgl Daftar</th>
									<th>Turnover <br/>Sementara</th>
									<th>Komisi <br/> Sementara</th>
								</tr>
							</thead>
							<tbody>
								<?php

								$grand = 0;
								for ($i=1; $i<=$row; $i++){
									$array=sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
									$data1[$i] = $array["userid"];
									$tover[$i] = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select isnull(sum(tover),0)as ttl, isnull(sum(aref_comm),0)as cmm from ".$db2.".dbo.j2365join_transaction_old where player = '".$data1[$i]."' and pdate >= '".date_format($time["paycom_date"],"Y-m-d")."'"), SQLSRV_FETCH_ASSOC);

									$grand += $tover[$i]["ttl"];
									$commison[$i] = $tover[$i]["cmm"];
									$grandcomm += $commison[$i];
								}

								for ($k=$j; $k<=$sub;  $k++){
									$user_id = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select joindate, save_deposit from u6048user_id where userid = '".$data1[$k]."'"), SQLSRV_FETCH_ASSOC);
									$tover[$k] = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select isnull(sum(tover),0)as ttl from ".$db2.".dbo.j2365join_transaction_old where player = '".$data1[$k]."' and pdate >= '".date_format($time["paycom_date"],"Y-m-d")."'"), SQLSRV_FETCH_ASSOC);
									if ($user_id["joindate"]== null)break;
									$subtotal += $tover[$k]["ttl"];
									$subcomm += $commison[$k];
								?>
								
									<tr>
										<td style="color:black;"><?php echo"".$k."";?></td>
										<td style="color:black;"><?php echo"".$data1[$k]."";?></td>
										<td style="color:black;"><?php echo"".date_format($user_id["joindate"], "d/m/Y")."";?></td>
										<td style="color:black;"><?php echo"".currx($tover[$k]["ttl"])."";?></td>
										<td style="color:black;"><?php echo"".currx($commison[$k])."";?></td>
									</tr>

								<?php
								}
								?>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="3" align="right" style="color:black;"><b>SubTotal</b></td>
									<td style="color:black;"><span><b><?php echo"".currx($subtotal)."";?></b></span></td>
									<td style="color:black;"><span><b><?php echo"".currx($subcomm)."";?></b></span></td>
								</tr>
								<tr>
									<td colspan="3" align="right" style="color:black;"><b>Grand Total</b></td>
									<td style="color:black;"><b><?php echo"".currx($grand)."";?></b></td>
									<td style="color:black;"><span><b><?php echo"".currx($grandcomm)."";?></b></span></td>
								</tr>
							</tfoot>
						</table>
					</div>

				</form>

				<script language="JavaScript" type="text/javascript">
					jQuery(document).ready(function(){
						jQuery(".popup").nyroModal();
						fixtable("#table", null, "#198dd1", "#198dd1", "#33b4ff");
						getfilter();
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
						jQuery("#table th, #table tfoot tr td").css({
							"background":"#00283d",
							"color":"#000000"
						});
						jQuery("#table").css({
							"border":"1px solid #198dd1"
						});
					})
				</script>
			</div>

			<div id="tabs-3">

	        	<?php
      				if ($errorReport){								
      					echo "<div class='padding-15' align='center' id='the_alert' style='color: #fff;background-color:#c0392b;'>".$errorReport."</div>";
      				}else{
						echo "<div class='padding-15' align='center' id='the_alert' style='display:none; color: #fff;background-color:#c0392b;'></div>";
					}
      			?>

				<form method="post" id="res_reg">
					<?PHP
						if(!$successRegister){
					?>
					<div class="tpadding-10 lpadding-15 rpadding-15 row">
						<div class="row">
							<label class="tmargin-10 black">Username</label>
							<input class="form-control bg-light-gray" onBlur="fast_checking('user_name', 'ceklis1', '')" id="user_name" name="UName" maxlength="8" value="<?php echo $_POST["UName"]; ?>" />
						</div>
						<div class="row">
							<label class="tmargin-10 black">Nickname</label>
							<input class="form-control bg-light-gray" onBlur="fast_checking('user_nameid', 'ceklis2', '')" id="user_nameid" name="UNameid" maxlength="10" value="<?php echo strtoupper($unameid); ?>" />
						</div>
						<div class="row">
							<label class="tmargin-10 black">Password</label>
							<input class="form-control bg-light-gray" onBlur="fast_checking('the_pass', 'ceklis3', '')" id="the_pass" type="password" name="Pass" value="<?php echo $_POST["Pass"]; ?>" />
						</div>
						<div class="row">
							<label class="tmargin-10 black">Konfirmasi Password</label>
							<input class="form-control bg-light-gray" onBlur="fast_checking('the_cpass', 'ceklis4', 'the_pass')" id="the_cpass" type="password" name="CPass" value="<?php echo $_POST["CPass"]; ?>" />
						</div>
						<div class="row">
							<label class="tmargin-10 black">Alamat Email</label>
							<input class="form-control bg-light-gray" onBlur="fast_checking('the_email', 'ceklis6', '')" id="the_email" type="email" maxlength="40"  name="Email" value="<?php echo $_POST["Email"]; ?>" />
						</div>
						<div class="row">
							<label class="tmargin-10 black">No Telp/HP</label>
							<input class="form-control bg-light-gray" onBlur="fast_checking('the_phone', 'ceklis7', '')" id="the_phone" type="text" maxlength="13" name="Phone" value="<?php echo $_POST["Phone"]; ?>" />
						</div>
						<div class="row">
							<label class="tmargin-10 black">Link Referral</label>
							<span>
								<?php echo "<b>http://".$DomainName."/ref.php?ref=$user_login</b>"; ?>
							</span>
						</div>
						<div class="row">
							<label class="tmargin-10 black">Validasi</label>
							<div class="col-lg-7">
								<input onBlur="fast_checking('the_cap', 'ceklis11', '')" id="the_cap" class="form-control bg-light-gray" type="text" name="captcha1" maxlength="5" />
							</div>
						
							<div class="col-lg-5 tpadding-3 lpadding-5">
								<img src='../../captcha/captcha.php?.png' alt='CAPTCHA' width='100%' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">
							</div>
						</div>
						<div class="row tmargin-10 bmargin-15">
							<input class="btn btn-blue bmargin-50" value="DAFTAR" type="submit" name="submit"/>
						</div>
					</div>
					<?PHP
						}else{
					?>

		        	<div class="row">
			        	<?php 
			        		echo "<div class='row normal-green'>
								<label class='normal-green fs-13 padding-15 bpadding-0 tpadding-8'>PENDAFTARAN SUKSES</label>
								<p>".$successRegister."</p>
								</div>";
			        	?>
	      			</div>

					<?PHP
						}
					?>
				</form>
			</div>
		</div>
	</div>

	<?PHP
		}else{
	?>

 	<div class="row padding-10">
 		<p class="dark-gray">
   	 		Program Referral adalah peluang usaha bisnis online tanpa modal, dengan BONUS setiap minggunya. Caranya :
			<ul class="blue lpadding-10">
				<li><p class="dark-gray">Daftarkan diri Anda jika belum memiliki Akun ID.</p></li>
				<li><p class="dark-gray">Dapatkan link referral Anda pada menu “REFERRAL”.</p></li>
				<li><p class="dark-gray">Share link referral Anda melalui media yang Anda punya seperti : Facebook, Twitter, Path, Blog, Google+, Email, Forum, Sms, BBM dllnya.</p></li>
				<li><p class="dark-gray">Cek aktifitas, Bonus Komisi Anda yang berjalan dan setiap minggunya dapatkan KOMISInya.</p></li>
			</ul>
		</p>
 		<p class="dark-gray">
			<h3>DAPATKAN KOMISI REFFERAL 10%.</h3>
			Setiap teman, member yang anda ajak bermain akan mendapatkan komisi sebesar 10% dari rollingan setiap minggunya. Tunggu apalagi ajak, sebar, promosikan dan dapatkan komisi UANG TUNAI-nya. Tanpa Kerja Keras!
		</p>
 	</div>

	<?PHP
		}
	?>

<?PHP 
	if(strtoupper($link_img) == "IO"){ 
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

	<script>
	function fast_checking(id_div, id_div2, id_div3){
		//use ajax to run the check
		var id_val = $('#'+id_div).val(); 
		
		if(id_div3!=""){ 
			var id_val2 = $('#'+id_div3).val();  
		}
		else{
			var id_val2 = "";
		}

		$('#the_alert').html("<img src='assets/loading/loading.gif' width='20' height='20' title='checking...' />");
		$('#the_alert').css('background-color', '');
		$('#the_alert').show(); 
		
		$.post("../../../fast_checking.php", { id_div:id_div, id_val:id_val, id_val2:id_val2},  
			function(result){  
				var inresult = result.split(";");

				if(inresult[0] == "0"){  
					$('#the_alert').css('background-color', '#c0392b');
					$('#the_alert').show();
					$('#the_alert').html(""+inresult[1]); 
					// $(document).scrollTo('#the_alert');
				}else{  
					$('#the_alert').hide();					
				}
			}
		);  
	}
	</script>

</div>

<?php include("_footer.php"); ?>