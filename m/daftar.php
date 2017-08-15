<?php
$page='daftar';
include("_meta.php");
include("_header.php");
include("../function/jcd-umum.php");

if ($login){
    exit("<script> window.location = 'login.php'</script>");
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
	if (!$ref){
		$referral_text = $_POST["ref_text"];
		if ($referral_text){
			$check_userid = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select userid from u6048user_id where loginid = '".$referral_text."' and userprefix='".$agentwlable."'"),SQLSRV_FETCH_ASSOC);
			if ($check_userid["userid"])$ref_userid=$check_userid["userid"];
			else $ref_error="#error_name";
		}
	}else{
		$check_userid = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select userid from u6048user_id where loginid = '".$ref."' and userprefix='".$agentwlable."'"),SQLSRV_FETCH_ASSOC);
		$ref_userid=$check_userid["userid"];
	}
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

	if (!checkCaptcha('CAPTCHAString', $capt)){
		$errorReport =  "Validasi anda salah.";
	}else if($pv !== true){ 
		$errorReport =  "".$pv."";
	}else if($te > 0){
		$errorReport = "Pendaftaran Gagal!";
	}else if($jumuser > 0 || $jumuserx > 0 || $jumuserxx > 0 || $jumuserxxx > 0){
		if( $jumuserx > 0) $errorReport = "Pendaftaran gagal.<br>Nickname telah terdaftar.";
		else $errorReport = "Pendaftaran gagal.<br>Username telah terdaftar.";
//	}else if ($ckuser == 2) {
//		$errorReport = "Ilegal karakter di Nomor Rekening.<br> Error nomor rekening";
	}else if(strlen($uname) > 10 || strlen($unameid) > 10){
		$errorReport = "Pendafataran gagal.<br>Max. Login ID dan Nickname  8 huruf";
	}else if(strlen($uname) < 3 || strlen($unameid) < 3){
		$errorReport = "Pendafataran gagal.<br>Min. Login ID dan Nickname  3 huruf";
	}else if (!preg_match("/[A-Z]/",substr($uname,0,1))){
		$errorReport = "Pendaftaran Gagal.<br>Karakter pertama dari Username harus A-Z.";
	}/*else if (!preg_match("/[A-Z]/",substr($unameid,0,1))){
		$errorReport = "Pendaftaran Gagal.<br>Karakter pertama dari Nickname harus A-Z.";
	}*/else if(!filter_var($email, FILTER_VALIDATE_EMAIL)){
		$errorReport = "Pendaftaran Gagal.<br>Harap cek Email.";
	}else if(($uname == "") || ($unameid == "") || ($pass == "") || ($cpass == "") || ($email == "") || ($phone == "")){
		$errorReport =("Pendaftaran Gagal.<br>Tidak boleh ada yang kosong.");
	}else if ($pass != $cpass){
		$errorReport =	("Pendaftaran Gagal.<br>Password tidak sesuai.");
	}else if ($ckuser == 1) {
		$errorReport = "Pendaftaran Gagal.<br> Username salah";
	}else if ($ckuser == 3) {
		$errorReport = "Pendaftaran Gagal.<br> Nickname salah";
	}else if (strlen($pass) < 5) {
		$errorReport = "Pendaftaran Gagal.<br> Password mininum 5 Digit";
//	}else if ($bname_error == 1) {
//		$errorReport = "Pendaftaran Gagal.<br> cek Bank Name";
//	}else if ($ceke == 1) {
//		$errorReport = "Pendaftaran Gagal.<br>Akun BCA harus memiliki 10 digit nomor ";
//	}else if ($ceke == 2) {
//		$errorReport = "Pendaftaran Gagal.<br>Akun MANDIRI harus memiliki 13 digit nomor ";
//	}else if ($ceke == 3) {
//		$errorReport = "Pendaftaran Gagal.<br>Akun BNI harus memiliki 9 atau 10 digit nomor ";
//	}else if ($ceke == 4) {
//		$errorReport = "Pendaftaran Gagal.<br>Akun BRI harus memiliki 15 digit nomor ";
//	}else if ($cekb == 1) {
//		$errorReport = "Pendaftaran Gagal.<br>Pendaftaran Bank gagal ";
	}else if ($rejid == 1) {
		$errorReport = "Pendaftaran Gagal.<br>Username sudah terdaftar ";
	}else if ($ref_error == "#error_name") {
		$errorReport = "Pendaftaran Gagal.<br>Referral anda salah";
	}else if ($cekw == 1) {
		$errorReport = "Pendaftaran Gagal.";
	}else if($cekemail>=1){
		$errorReport = "Pendaftaran Gagal.<br>Email sudah pernah terdaftar";
	/*}else if ($sekarang < $tglx) {
		$errorReport = "Pendaftaran Gagal";*/
	}else if ($rejpas > 0) { 
		$errorReport = "User Error, tidak dapat menggunakan password ini!";
//	}else if ($noRek == '1' && $cekBankNo >= 1){
//		$errorReport = "Maaf! akun bank ini sudah pernah di daftarkan";
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
				insert into u6048user_id (userid, loginid, $cfgDbPasswordfield,userprefix,referral_agent,telp,email,usertype,playerpt,deposit_type,save_deposit,joindate,status,bankgrup,subwebid,flag) values ('".$unameid."', '".$uname."','".hash("sha256",md5($pass).'8080')."','".$cref."','".$ref_userid."','".$phone."','".$email."','U','0','1','0',GETDATE(),'0','1','".$subwebid."','1')
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
			$refus=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select userid ".$sqldatafieldaref." from u6048user_data where userid = '".$ref_userid."'"),SQLSRV_FETCH_ASSOC);
			$refuser .= $refus[strtolower($gt)."_aref_share"].",";
		}
		
		$gamsqlku = sqlsrv_query($sqlconn, "select userprefix from u6048user_id where userid = '".$unameid."'",$params,$options);
		$gamdataref = sqlsrv_fetch_array($gamsqlku,SQLSRV_FETCH_NUMERIC);
		//     if (sqlsrv_num_rows($gamsqlku) == 0) die("<center>Registrasi gagal, harap periksa kembali semua data anda</center>.");
		if (!$ref){			
			
			sqlsrv_query($sqlconn, "insert into u6048user_data (userid,usertype,referral_agent ".$sqldatafieldaref." ,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$ref_userid."' ".$sqldatafieldconfigquery." , '".$agentwlable."','IDR','1','0','0'".$sqldatavalue.")");
			
		}else{	
			if($txh_aref_share == ""){
				sqlsrv_query($sqlconn, "insert into u6048user_data (userid,usertype,referral_agent ".$sqldatafieldaref." ,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$ref_userid."' ".$sqldatafieldconfigquery." ,'".$agentwlable."','IDR','1','0','0'".$sqldatavalue.")");
			}else{
				sqlsrv_query($sqlconn, "insert into u6048user_data (userid,usertype,referral_agent ".$sqldatafieldaref." ,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$ref_userid."',".$refuser."'".$agentwlable."','IDR','1','0','0'".$sqldatavalue.")");
			}
		}
		
		if (sqlsrv_num_rows($gamsqlku) == 0){
			sqlsrv_query($sqlconn,"insert into log_error (error) values('".$uname."-".hash("sha256",md5($pass).'8080')."-".$cref."-".$ref_userid."-U-".$fname."-0-".$phone."-".$email."-".$bname."-".$baname."-".$bano5."-1-0-0-".$sex."-".$subwebid."')");
		}
		
		sqlsrv_query ($sqlconn, "INSERT INTO venus_db.dbo.userid (id, userid,webid,device, joindate) 
								 SELECT id, userid, webid, 1 as device, GETDATE() as joindate 
								 FROM u6048user_id a join venus_db.dbo.website b ON a.userprefix = b.agent COLLATE Latin1_General_CI_AS 
								 WHERE userid = '".$unameid."'");
		
		$successRegister = "<centeR><a href='http://".$DomainName."'>$DomainName</a> - Pendaftaran Sukses<br>Username = <b>$uname</b><br>Anda bisa melakukan deposit di website <a href='http://".$DomainName."'>$DomainName</a>.<br>Selamat bermain dan Terima Kasih  (#1021)<br><br> <font style='font-weight:bold;'>Anda akan terlogin dalam <label id='counter'>5</label>s</font></center>";
		
		
		?>
		<script>
		
		setTimeout(function () {
		window.location.href = "http://<?php echo $DomainName;?>"; //will redirect to your blog page (an ex: blog.html)
		}, 5000)
		</script>
		<?php
	}
}
?>

<div class="content-2">

	<div class="row">		
		<div class="lpadding-15 tpadding-5">
	        <label class="ntf fs-13 tmargin-10">FORM PENDAFTARAN</label>
	    </div>
	    <hr class="margin-0 tmargin-2 bmargin-3">

		<?php
			if ($errorReport){
				echo "<div class='padding-15' align='center' id='the_alert' style='color: #000;background-color:#c0392b;'>".$errorReport."</div>";
			}else{
				echo "<div class='padding-15' align='center' id='the_alert' style='display: none; color: #000;background-color:#c0392b;'></div>";
			}
		?>
	</div>

	<form method="post" id="form_reg">

		<?php if (!$successRegister){ ?>

		<div class="row padding-15 tpadding-3 bpadding-2" id="freg">
			<div class="col-lg-5 tmargin-5">
				<label class="black">Login ID</label>
			</div>
			<div class="col-lg-7">				
				<input class="form-control bg-light-gray" onBlur="fast_checking('user_name', 'ceklis1', '')" id="user_name" type="text" name="UName" maxlength="8" value="<?php echo $_POST["UName"]; ?>"   />
			</div>
		</div>

		<div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				<label class="black">Nickname</label>
			</div>
			<div class="col-lg-7">
				<input class="form-control bg-light-gray" onBlur="fast_checking('user_nameid', 'ceklis2', '')" id="user_nameid" type="text" name="UNameid" maxlength="10" value="<?php echo strtoupper($unameid); ?>" />
			</div>				
		</div>

		<div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				<label class="black">Password</label>
			</div>
			<div class="col-lg-7">
				<input class="form-control bg-light-gray" onBlur="fast_checking('the_pass', 'ceklis3', '')" id="the_pass" type="password" name="Pass" value="<?php echo $_POST["Pass"]; ?>" placeholder="Contoh : Ex@mpl3" />
			</div>
		</div>

		<div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				<label class="black">Ulangi Password</label>
			</div>
			<div class="col-lg-7">
				<input class="form-control bg-light-gray" type="password" onBlur="fast_checking('the_cpass', 'ceklis4', 'the_pass')" id="the_cpass" type="password" name="CPass" value="<?php echo $_POST["CPass"]; ?>" placeholder="Pastikan Password Sama"/>
			</div>
		</div>

		<div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				<label class="black">Alamat Email</label>
			</div>
			<div class="col-lg-7">				
				<input class="form-control bg-light-gray" onBlur="fast_checking('the_email', 'ceklis6', '')" id="the_email" type="email" name="Email" value="<?php echo $_POST["Email"]; ?>" />
			</div>
		</div>

		 <div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				<label class="black">No. Telp / HP</label>
			</div>
			<div class="col-lg-7">				
				<input class="form-control bg-light-gray" onBlur="fast_checking('the_phone', 'ceklis7', '')" id="the_phone" type="text" maxlength="15" name="Phone" value="<?php echo $_POST["Phone"]; ?>" />
			</div>
		</div>

		<div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				<label class="black">Validasi</label>
			</div>
			<div class="col-lg-7">
				<input class="form-control bg-light-gray" onBlur="fast_checking('the_cap', 'ceklis11', '')" id="the_cap" type="text" name="captcha1" maxlength="5" />				
			</div>
		</div>

		<div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				
			</div>
			<div class="col-lg-7">
				<img src='../captcha/captcha.php?.png' alt='CAPTCHA' width='120' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">				
			</div>
		</div>

		<div class="row padding-15 bmargin-50">
			<input class="btn btn-green fs-normal" value="DAFTAR" type="submit" name="submit" />
		</div>

		<?php
			}else{
				echo "<div class='row normal-green'>
				<label class='normal-green fs-13 padding-15 bpadding-0 tpadding-8'>PENDAFTARAN SUKSES</label>
				<p>".$successRegister."</p>
				</div>";
			}
		?> 

	</form>
</div>

<style type="text/css">
	.place-red::-webkit-input-placeholder {
	   color: #dc5b6b;
	   font-style: italic;
	   font-size: 10px;
	}

	.place-red:-moz-placeholder { /* Firefox 18- */
	   color: #dc5b6b;  
	   font-style: italic;
	   font-size: 10px;
	}

	.place-red::-moz-placeholder {  /* Firefox 19+ */
	   color: #dc5b6b;  
	   font-style: italic;
	   font-size: 10px;
	}

	.place-red:-ms-input-placeholder {  
	   color: #dc5b6b;  
	   font-style: italic;
	   font-size: 10px;
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
<?php 
if($successRegister){
?>
<script>
function countdown() {
	var i = document.getElementById('counter');
	if(parseInt(i.innerHTML)>0){i.innerHTML = parseInt(i.innerHTML)-1;}
	if (parseInt(i.innerHTML)==0) {
		$.post("captcha-autologin.php", { id_div:""},  
			function(result){ 
				document.getElementById("username").value = "<?php echo $uname; ?>";
				document.getElementById("j_plain_password").value = "<?php echo $pass; ?>";
				document.getElementById("membervalidation").value = result;
				document.getElementById("frmlgn").submit();
			}
		);  
	}
}
setInterval(function(){ countdown(); },1000);

	// setTimeout(function () {		
		
	// }, 5000);
</script>
<?php }?>

<?php include ("_footer.php");?>