<?php
session_start();
$login = $_SESSION['login'];
if (!$login) $freePage = 1;
else exit("<script>location.href='index.php'</script>");

include("meta.php");
include("header.php");
include("function/jcd-umum.php");
if (!$register)exit("<script>location.href='index.php'</script>");

$cref	= $agentwlable;
$noRek	= "1";
$pt = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select playerpt_status from a83adm_config"),SQLSRV_FETCH_ASSOC);
$buka = $pt["playerpt_status"];
if($buka == 0) die("Cannot Open this page.");

$curr = $_POST["Curr"];
$ref = strtoupper($_COOKIE["ref"]);
if (!$ref)$ref="";

/* 
if(!isset($_COOKIE['aff']) and $ref == ""){
	exit("<script>location.href='http://record.idnpartners.com/_FZ2-uOae1BC1P1nXXCgyomNd7ZgqdRLk'</script>");
} */
if($_POST["submit"]){
	$cekr = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select registration from a83adm_config2"),SQLSRV_FETCH_ASSOC);
	$cekr = $cekr["registration"];
	if($cekr == "0"){
		exit("<div class='error-report'>Registration Tempolary Closed(#1022)</div>");
	}
	$fname = $_POST["FName"];
	$uname = str_replace("''","*",$_POST["UName"]);
	$unameid = str_replace("''","*",$_POST["UNameid"]);
	$pass	= $_POST["Pass"];
	$cpass	= $_POST["CPass"];
	$email	= $_POST["Email"];
	$phone	= $_POST["Phone"];
	$bname	= $_POST["BName"];
	$baname = str_replace("''","*",$_POST["BAName"]);
	$bano	= $_POST["BAno"];
	$bano1	= $_POST["BAno1"];
	$bano2	= $_POST["BAno2"];
	$curr	= $_POST["Curr"];
	
	//GENERATE RANDOM USERID
	/*do{
		$unameid = RandomString();
		$isexist = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select userid from u6048user_id where userid = '".$unameid."'",$params,$options));
	}while($isexist>0);
	*/
	//PASSWORD ALPHA NUMERIC	
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
	
	$uname = strtoupper($uname);
	$unameid = strtoupper($unameid);

	$capt = $_POST["captcha1"];
	if (strpos($fname,"<") or strpos($fname,">")){
		$cekw = 1;
	}else if (strpos($phone,"<") or strpos($phone,">")){
		$cekw = 1;
	}else if (strpos($email,"<") or strpos($email,">")){
		$cekw = 1;
	}else if (strpos($baname,"<") or strpos($baname,">")){
		$cekw = 1;
	}else if (strpos($pass,"<") or strpos($pass,">")){
		$cekw = 1;
	}else if (strpos($cpass,"<") or strpos($cpass,">")){
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
	}else if (strtoupper($_POST["BName"])=='CIMB'){
		$cx1=substr($bano,0,3);
		$cx2=substr($bano,3,2);
		$cx3=substr($bano,5,5);
		$cx4=substr($bano,10,13);
		$banox=$cx1."-".$cx2."-".$cx3."-".$cx4;
	}

	$bano5 = $banox;
	$cekrekno = sqlsrv_query($sqlconn, "select no_rek,bank from a83adm_nobankrek where no_rek LIKE '".$bano."%'",$params,$options);
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
	if(strlen($tes) > 0){
		if($tes=="bca"){
			if(strlen($bano) != 10) {
				$ceke=1;
			}
		}else if($tes=="bni"){
			if(strlen($bano) < 9){
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
			$ckuser = 1;
		}
	}
	foreach (count_chars($unameid, 1) as $i => $val) {
		if($i > 47 && $i < 58) {  }
		else if($i > 64 && $i < 91) {  }
		else if($i > 96 && $i < 123) {  }
		else if($i == 95){}
		else {
			$ckuser = 3;
		}
	}
	foreach (count_chars($bano, 1) as $i => $val) {
		if($i > 47 && $i < 58) {  }
		else {
			$ckuser = 2;
		}
	}
	
	if ( !preg_match('/[^A-Za-z0-9 ]/', $bname) ){
		//safe
	}else{
		$bname_error = 1;
	}

	function getUserIP(){
		$client  = @$_SERVER['HTTP_CLIENT_IP'];
	$forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
	$remote  = $_SERVER['REMOTE_ADDR'];
	$forward = isset(explode(",",$forward)[1]) ? explode(",",$forward)[1] : explode(",",$forward)[0];

	if(filter_var($client, FILTER_VALIDATE_IP)){
		$ip = $client;
	}elseif(filter_var($forward, FILTER_VALIDATE_IP)){
		$ip = $forward;
	}else{
		$ip = $remote;
	}

	return $ip;
	}
	$ip = getUserIP();
/*
	//SECURE IDENTITY
	$url = "http://103.249.162.143:2804/";
	//secure email
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	$response = "<request>
					<secret_key></secret_key>
					<id>1</id>
					<string>$email</string>
				</request>";
	curl_setopt($ch, CURLOPT_POSTFIELDS,"" . $response);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
	$data = curl_exec($ch);
	curl_close($ch);
	$array_data_email = json_decode(json_encode(simplexml_load_string($data)), true);
	$secure_email = $array_data_email["result"];
	
	//secure phone
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	$response = "<request>
					<secret_key></secret_key>
					<id>1</id>
					<string>$phone</string>
				</request>";
	curl_setopt($ch, CURLOPT_POSTFIELDS,"" . $response);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
	$data = curl_exec($ch);
	curl_close($ch);
	$array_data_phone = json_decode(json_encode(simplexml_load_string($data)), true);
	$secure_phone = $array_data_phone["result"];
	//END SECURE IDENTITY
	*/
	$cekemail	= sqlsrv_num_rows(sqlsrv_query($sqlconn, "select email from u6048user_id where email = '".$email."' and userprefix='".$cref."'",$params,$options));
	$cekBankNo	= sqlsrv_num_rows(sqlsrv_query($sqlconn, "select bankaccno from u6048user_id where bankaccno = '".$bano5."' and userprefix='".$cref."'",$params,$options));
	$te = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select ip from a83adm_ipblok where ip = '".$ip."'",$params,$options));
	
	
	/*
	check blocking bank
	*/
	$blocking_bank = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select * from a83adm_nobankrek where no_rek = '".$banox."' or no_rek = '".$bano4."'",$params,$options));
	
	

	if ($capt != $_SESSION['CAPTCHAString']){
		$errorReport =  "<div class='error-report'>Validasi anda salah.(#1001)</div>";
	}else if($pv !== true){ 
		$errorReport =  "<div class='error-report'>".$pv." (#1002)</div>"; 
	}else if($te > 0){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal! (#1003)</div>";
	}else if($jumuser > 0 || $jumuserx > 0 || $jumuserxx > 0 || $jumuserxxx > 0){
		if($jumuserx > 0) $errorReport = "<div class='error-report'>Pendaftaran gagal.<br>Nickname telah terdaftar. (#1004)</div>";
		else $errorReport = "<div class='error-report'>Pendaftaran gagal.<br>Username telah terdaftar. (#1004)</div>";
//	}else if ($ckuser == 2) {
//		$errorReport = "<div class='error-report'>Ilegal karakter di Nomor Rekening.<br> Error nomor rekening (#1005)</div>";
	}else if(strlen($uname) > 10 || strlen($unameid) > 10){
		$errorReport = "<div class='error-report'>Pendafataran gagal.<br>Max. Login ID dan Nickname 10 huruf (#1006)</div>";
	}else if(strlen($uname) < 3 || strlen($unameid) < 3){
		$errorReport = "<div class='error-report'>Pendafataran gagal.<br>Min. Login ID dan Nickname 3 huruf (#1007)</div>";
	}else if (!preg_match("/[A-Z]/",substr($uname,0,1))){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Karakter pertama dari Login ID harus A-Z. (#1008)</div>";
	}else if(!filter_var($email, FILTER_VALIDATE_EMAIL)){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Harap cek Email. (#1009)</div>";
	}else if(($uname == "") || ($unameid == "") || ($pass == "") || ($cpass == "") || ($email == "") || ($phone == "")){
		$errorReport =("<div class='error-report'>Pendaftaran Gagal.<br>Tidak boleh ada yang kosong.(#1010)</div>");
	}/*else if( ($secure_email == "") || ($secure_phone == "") ){
		$errorReport =("<div class='error-report'>Pendaftaran Gagal.<br>Tidak boleh ada yang kosong.(#1024)</div>");
	}*/else if ($pass != $cpass){
		$errorReport =	("<div class='error-report'>Pendaftaran Gagal.<br>Password dan konfirmasi password tidak sesuai. (#1011)</div>");
	}else if ($ckuser == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Username harus terdiri dari huruf atau huruf angka (#1012)</div>";
	}else if ($ckuser == 3) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Nickname harus terdiri dari huruf atau huruf angka (#1012)</div>";
	}else if (strlen($pass) < 5) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br> Password minimum 5 Digit (#1013)</div>";
//	}else if ($bname_error == 1) {
//		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br> cek Nama bank (#1014)</div>";
//	}else if ($ceke == 1) {
//		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun BCA harus memiliki 10 digit nomor (#1100)</div>";
//	}else if ($ceke == 2) {
//		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun MANDIRI harus memiliki 13 digit nomor (#1101)</div>";
//	}else if ($ceke == 3) {
//		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun BNI harus memiliki 9 atau 10 digit nomor (#1102)</div>";
//	}else if ($ceke == 4) {
//		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun BRI harus memiliki 15 digit nomor (#1103)</div>";
//	}else if ($cekb == 1) {
//		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Pendaftaran Bank gagal (#1015)</div>";
	}else if ($ref_error == "#error_name") {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Referral anda salah (#1016)</div>";
	}else if ($cekw == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal. (#1017)</div>";
	}else if($cekemail>=1){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Email sudah pernah terdaftar (#1018)</div>";
//	}else if ($cekBankNo >= 1){
//		$errorReport = "<div class='error-report'>Maaf! akun bank ini sudah pernah di daftarkan (#1019)</div>";
//	}else if($blocking_bank > 0){
//		$errorReport =  "<div class='error-report'>Bank telah ter blokir (#1022)</div>";
	} else {
		$uname = strtoupper(str_replace(" ","",$uname));
		$unameid = strtoupper(str_replace(" ","",$unameid));
		
		$gamsql = sqlsrv_query($sqlconn, "select gamecode,sqltable, playerpt_dwin, playerpt_dlose from a83adm_configgame where status = '1' and status_agencygame='1'");
		$comsql = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select comms from a83adm_config"),SQLSRV_FETCH_ASSOC);
		$cek=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select * from u6048user_data where userid='$cref'"),SQLSRV_FETCH_ASSOC);
		if($cek["userid"] ==""){
			die("<center>Registration Failed! please contact us (#1020)</center>.");
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
		sqlsrv_query ($sqlconn, "insert into t6413txh_lastorder (userid,total,status) values ('".$unameid."', '0', 'REGISTER')");
		while ( $gamdata = sqlsrv_fetch_array($gamsql,SQLSRV_FETCH_ASSOC) ){	
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
					exit ("<center><font color=red face=arial size=2><b>".P_COM." ".P_ERR.", ".P_COM." ".$gamdata["gamename"]." ".P_EXCLIM."</b></font>&nbsp; (#1023)</center>");
				}
				if(($dwin[$gamety] == "") || $dlose[$gamety] == "") die("<center><font color=red face=arial size=2><b>".P_EMPFOR.", ".P_PLECHEAGA."!</b></font>&nbsp;</center>");
				$sqldatafield .= ", ".strtolower($gt)."_dwin, ".strtolower($gt)."_dlose";
				$sqldatavalue .= ", '".$cek[strtolower($gt)."_dwin"]."', '".$cek[strtolower($gt)."_dlose"]."'";
			}
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

		if (!$ref){			
			sqlsrv_query($sqlconn, "insert into u6048user_data (userid,usertype,referral_agent ".$sqldatafieldaref." ,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$ref_userid."' ".$sqldatafieldconfigquery." , '".$agentwlable."','IDR','1','0','0'".$sqldatavalue.")");
			$query_data = "insert into u6048user_data (userid,usertype,referral_agent ".$sqldatafieldaref." ,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$ref_userid."' ".$sqldatafieldconfigquery." , '".$agentwlable."','IDR','1','0','0'".$sqldatavalue.")";
				// AFFILIATE TEST DATA
			/* $id_data = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select id from u6048user_id where userid = '".$unameid."'"),SQLSRV_FETCH_ASSOC);
			if(!$ref_userid){
				sqlsrv_query($sqlconn, "insert into j2365join_affiliate (id, userid, token, TDate, country) values 
				('".$id_data['id']."','".$unameid."','".$_COOKIE["aff"]."',GETDATE(),'CN')");
			} */
			//END AFFILIATE
			
		}else{	
			if($txh_aref_share == ""){				
				sqlsrv_query($sqlconn, "insert into u6048user_data (userid,usertype,referral_agent ".$sqldatafieldaref." ,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$ref_userid."' ".$sqldatafieldconfigquery." ,'".$agentwlable."','IDR','1','0','0'".$sqldatavalue.")");
				$query_data = "insert into u6048user_data (userid,usertype,referral_agent ".$sqldatafieldaref." ,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$ref_userid."' ".$sqldatafieldconfigquery." ,'".$agentwlable."','IDR','1','0','0'".$sqldatavalue.")";
			}else{
				sqlsrv_query($sqlconn, "insert into u6048user_data (userid,usertype,referral_agent ".$sqldatafieldaref." ,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$ref_userid."',".$refuser."'".$agentwlable."','IDR','1','0','0'".$sqldatavalue.")");
				$query_data = "insert into u6048user_data (userid,usertype,referral_agent ".$sqldatafieldaref." ,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$ref_userid."',".$refuser."'".$agentwlable."','IDR','1','0','0'".$sqldatavalue.")";
			}
		}

		$banner_id = $_COOKIE["bi"];
		$ref_id = $_COOKIE["ri"];
		$gc = $_COOKIE["gc"];
		$ch = curl_init();

		curl_setopt($ch, CURLOPT_URL,"http://indoads.xyz/register.php");
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_POSTFIELDS,
						http_build_query(array(
							'banner_id' => $banner_id,
							'ref_id' => $ref_id,
							'gc' => $gc,
							)));

		// in real life you should use something like:
		// curl_setopt($ch, CURLOPT_POSTFIELDS, 
		//          http_build_query(array('postvar1' => 'value1')));

		// receive server response ...
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

		$server_output = curl_exec ($ch);

		curl_close ($ch);

		$userdata_check = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select userid from u6048user_data where userid = '".$unameid."' ",$params,$options));
		
		//log error query
		
		$userdata_check = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select userid from u6048user_data where userid = '".$unameid."' ",$params,$options));
		
		$query_data = str_replace("'", '"', $query_data);
		if($userdata_check <= 0){
			sqlsrv_query($sqlconn,"insert into log_errorquery ( userid, query_error, server, device) values  ('".$unameid."', '".$query_data."',0,'desktop')");
		}
		
		sqlsrv_query($sqlconn, "insert into u6048user_dataref (userid,referral_agent,userprefix".$commfield."".$commfieldx.") values ('".$unameid."','".$ref_userid."','".$agentwlable."'".$commvalue."".$commvaluex.")");
		if (sqlsrv_num_rows($gamsqlku) == 0){
			sqlsrv_query($sqlconn,"insert into log_error (error) values('".$unameid."-".hash("sha256",md5($pass).'8080')."-".$cref."-".$ref_userid."-U-".$fname."-0-".$phone."-".$email."-".$bname."-".$baname."-".$bano5."-1-0-0-".$sex."-".$subwebid."')");
		}
		
		// insert to venus_db
		require_once 'mobile_detect.php';
		$detect = new Mobile_Detect;
		$check_mobile = $detect->isMobile();
		$check_tablet = $detect->isTablet();
		$mobile = 2;
		if($check_mobile == 1 || $check_tablet == 1){
			$mobile = 1;
		}
		
		sqlsrv_query ($sqlconn, "insert into venus_db.dbo.userid (userid, webid, device, joindate) values ('".$unameid."', (SELECT webid FROM venus_db.dbo.website where domainname like '%,".$nonWWW."%'),".$mobile.",GETDATE())");
		
		$successRegister = "<centeR><a href='http://".$DomainName."'>$DomainName</a> - Pendaftaran Sukses<br>Username = <b>$uname</b><br>Anda bisa melakukan deposit di website <a href='http://".$DomainName."'>$DomainName</a>.<br>Selamat bermain dan Terima Kasih  (#1021)<br><br> <font style='font-weight:bold;'>Anda akan terlogin dalam <label id='counter'>5</label>s</font></center>";
		?>
		<script>
		setTimeout(function () {
			window.location.href = "http://<?php echo $DomainName;?>";
		}, 5000)
		</script>
		<?php
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
								document.write("<iframe src="+j_register+" width=800 height=700></iframe>");
							</script>
							<?php
						}else{
							echo"<script>
								document.getElementById('menu-register').href=j_register;
								document.getElementById('menu-deposit').href=j_deposit;
								document.getElementById('menu-withdraw').href=j_withdraw;
							</script>";
						
						?>
						    <div class="head-wrap">
                                <h1>Daftar</h1>
                            </div>
                            <div class="body-wrap">
								<style> .validx {	position:absolute;right:-25px;margin-top:3px; } </style>
                                <form class="form-horizontal" role="form" method="POST">
									<?php 
									if ($errorReport){
									?>
										<div class="alert alert-danger" id="the_alert">
											<?php
											echo $errorReport;
											?>
										</div>
									<?php
									}
									elseif ($successRegister){
									?>
										<div class="alert alert-success" id="the_alert">
											<?php
											echo $successRegister;
											?>
										</div>
									<?php
									}
									else{
									?>
										<div class="alert alert-danger" id="the_alert" style="display:none;">											
										</div>
									<?php	
									}
									?>
                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Login ID</label>
                                        <div class="col-lg-2">
											<div id="ceklis1" class="validx"></div>
                                            <input onBlur="fast_checking('user_name', 'ceklis1', '')" type="text" name="UName" id="user_name" placeholder="Username Account Anda" maxlength=8 value="<?php echo $uname; ?>" data-required="true" class="form-control">                                           
										</div>
                                    </div>
									
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nickname</label>
                                        <div class="col-lg-2">
											<div id="ceklis2" class="validx"></div>
                                            <input onBlur="fast_checking('user_nameid', 'ceklis2', '')" type="text" name="UNameid" id="user_nameid" placeholder="Tampilan anda dalam game" maxlength=10 value="<?php echo strtoupper($unameid); ?>" data-required="true" class="form-control">											
										</div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Password</label>
                                        <div class="col-lg-2">
											<div id="ceklis3" class="validx"></div>
                                            <input onBlur="fast_checking('the_pass', 'ceklis3', '')" type="password" name="Pass" id="the_pass" placeholder="Password Account Anda" class="form-control">
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Konfirmasi Password</label>
                                        <div class="col-lg-2">
											<div id="ceklis4" class="validx"></div>
                                            <input onBlur="fast_checking('the_cpass', 'ceklis4', 'the_pass')" type="password" name="CPass"  id="the_cpass" placeholder="Konfirmasi Password Account Anda" class="form-control">
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Email</label>
                                        <div class="col-lg-2">
											<div id="ceklis6" class="validx"></div>
                                            <input onBlur="fast_checking('the_email', 'ceklis6', '')" type="email" name="Email" id="the_email" placeholder="Email harus valid dan benar, email_anda@example.com" maxlength=40 value="<?php echo $email; ?>" class="form-control" data-required="true" data-type="email">
											<span style="float:left;">Email Harus Aktif</span>
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">No Telepon</label>
                                        <div class="col-lg-2">
											<div id="ceklis7" class="validx"></div>
                                            <input onBlur="fast_checking('the_phone', 'ceklis7', '')" type="text" name="Phone"  id="the_phone" placeholder="Nomor Telepon Anda" maxlength=13  value="<?php echo $phone; ?>" data-required="true" class="form-control">
                                        </div>
                                    </div>

									<?php
									if ($ref){
									?>
										<div class="form-group-full">
											<label class="col-lg-1 control-label">Referral</label>
											<div class="col-lg-2" style="text-align:left">
												<?php echo "<b>".strtoupper($ref)."</b>"; ?>
											</div>
										</div>
									<?php
									}else{
									?>
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Referral</label>
                                        <div class="col-lg-2" style="text-align:left">
											<div id="ceklis10" class="validx"></div>
											<input onBlur="fast_checking('the_ref', 'ceklis10', '')" type="text" name="ref_text" id="the_ref" value="" placeholder="Nama Referral" data-required="true" class="form-control">
											<br>*Ini tidak wajib harus diisi
                                        </div>
                                    </div>
									<?php } ?>
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Captcha</label>
                                        <div class="col-lg-3">
                                           <img src='captcha/captcha.php?.png?a=1' alt='CAPTCHA' class="form-captcha"/>
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label"></label>
                                        <div class="col-lg-3">
											<div id="ceklis11" class="validx"></div>
                                            <input onBlur="fast_checking('the_cap', 'ceklis11', '')" type="text" name="captcha1" id="the_cap" placeholder="Validation" data-required="true" class="form-control">
                                        </div>
                                    </div>

                                    <div class="line m-t-large"></div>
                                    <div class="space_10"></div>

                                    <div class="form-group-full">
                                        <button type="submit" name="submit" value="SUBMITS" class="btn btn-submit">Daftar</button>
                                    </div>
                                </form>
                            </div>
							<?php
						}
					?>
                        </div>
                    </div>
			
                    <div class="clear space_30"></div>
					
                </div>
            </div>
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
		$('#'+id_div2).html("<img src='assets/images/loader.gif' width='30' title='checking...' />"); 
		//alert(id_val2);
		$.post("fast_checking.php", { id_div:id_div, id_val:id_val, id_val2:id_val2},  
			function(result){  
				var inresult = result.split(";");
	
				if(inresult[0] == "0"){  
					//show that the username is available  
					$('#'+id_div2).html("<img src='assets/images/crossred.png' width='30' title='"+inresult[1]+"' />"); 
					$('#the_alert').show(); 
					$('#the_alert').html(""+inresult[1]); 					
				}else{  
					//show that the username is NOT available  
					$('#'+id_div2).html("<img src='assets/images/ceklishijao.png' width='30' title='"+inresult[1]+"' />"); 
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
	        $.post("captcha/captcha-autologin.php", { id_div:""},  
				function(result){ 
					document.getElementById("membername").value = "<?php echo $uname; ?>";
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
<?php
include("footer.php");
?>