<?php
session_start();
include("config.php");

$id_div = $_POST["id_div"];
$id_val = $_POST["id_val"];
$id_val2 = $_POST["id_val2"];

if($id_div){
	switch($id_div){
	
		case "user_name" : 
			$uname = strtoupper($id_val);
			
			if($uname==""){
				$result = "0;Tidak boleh ada yang kosong";
				echo $result;
				die();
			}
			
			foreach (count_chars($uname, 1) as $i => $val) {
				if($i > 47 && $i < 58) {  }
				else if($i > 64 && $i < 91) {  }
				else if($i > 96 && $i < 123) {  }
				else if($i == 95){}
				else {
					$result = "0;Username harus terdiri dari huruf atau huruf angka";
					echo $result;
					die();
				}
			}
			
			if(strlen($uname) > 10){
				$result = "0;Max. Login ID 10 huruf";
				echo $result;
				die();
			}
			
			if(strlen($uname) < 3){
				$result = "0;Min. Login ID 3 huruf";
				echo $result;
				die();
			}
			
			if (!preg_match("/[A-Z]/",substr($uname,0,1))){
				$result = "0;Karakter pertama dari Login ID harus A-Z.";
				echo $result;
				die();
			}
			
			$q=@sqlsrv_num_rows(sqlsrv_query($sqlconn,"select loginid from u6048user_id where loginid = '".$uname."'",$params,$options));
			if($q>0){
				$result = "0;Loginid sudah digunakan";
				echo $result;	
				die();
			}
			
			$result = "1;Valid";
			echo $result;	
			die();
		break;
		
		case "user_nameid" :
			$unameid = strtoupper($id_val);
			
			if($unameid==""){
				$result = "0;Tidak boleh ada yang kosong";
				echo $result;
				die();
			}
			
			foreach (count_chars($unameid, 1) as $i => $val) {
				if($i > 47 && $i < 58) {  }
				else if($i > 64 && $i < 91) {  }
				else if($i > 96 && $i < 123) {  }
				else if($i == 95){}
				else {
					$result = "0;Username harus terdiri dari huruf atau huruf angka";
					echo $result;
					die();
				}
			}
			
			if(strlen($unameid) > 10){
				$result = "0;Max. Login ID 10 huruf";
				echo $result;
				die();
			}
			
			if(strlen($unameid) < 3){
				$result = "0;Min. Login ID 3 huruf";
				echo $result;
				die();
			}
			
			if (!preg_match("/[A-Z]/",substr($unameid,0,1))){
				$result = "0;Karakter pertama dari User ID harus A-Z.";
				echo $result;
				die();
			}
			
			$q=@sqlsrv_num_rows(sqlsrv_query($sqlconn,"select userid from u6048user_id where userid = '".$unameid."'",$params,$options));
			if($q>0){
				$result = "0;Userid sudah digunakan";
				echo $result;	
				die();
			}
			
			$result = "1;Valid";
			echo $result;	
			die();
		break; 
		
		case "the_pass" :
			$pass = $_POST["id_val"];
		
			if (strpos($pass,"<") or strpos($pass,">")){
				$result = "0;Illegal Password";
				echo $result;
				die();
			}
			
			if($pass==""){
				$result = "0;Tidak boleh ada yang kosong";
				echo $result;
				die();
			}
			
			if (strlen($pass) < 5) {
			 	$result = "0;Password minimum 5 Digit";
				echo $result;
				die();
			}
			
			$ps = strtolower($pass);
			$pass_rejected_db = ["Abc@123","ABc@123","Asd@123","ASd@123"]; 
			if (in_array($pass, $pass_rejected_db)) {				
				$result = "0;Password di tolak, harap mengunakan password yang lain";
				echo $result;
				die();
			}elseif (preg_match("(^(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*_]).+$)",$pass) == false){
				$result = "0;Password wajib mengunakan kombinasi huruf angka dan simbol (@#$%^*_), (contoh : Ex@mple123)";
				echo $result;
				die();
			}
						
			$result = "1;Valid";
			echo $result;	
			die();
		break;
		
		case "the_cpass" :
			$cpass = $_POST["id_val"];
			
			if (strpos($cpass,"<") or strpos($cpass,">")){
				$result = "0;Illegal Password";
				echo $result;
				die();
			}
			
			if($cpass==""){
				$result = "0;Tidak boleh ada yang kosong";
				echo $result;
				die();
			}
			
			if ($id_val2 != $cpass){
				$result = "0;Password dan konfirmasi password tidak sesuai";
				echo $result;
				die();
			}
			
			$result = "1;Valid";
			echo $result;	
			die();
		break;	
		
		case "the_fname";
			$fname = $_POST["id_val"];
			
			if (strpos($fname,"<") or strpos($fname,">")){
				$result = "0;Illegal Name";
				echo $result;
				die();
			}
			
			if($fname==""){
				$result = "0;Tidak boleh ada yang kosong";
				echo $result;
				die();
			}
			
			$result = "1;Valid";
			echo $result;	
			die();
		break;	
		
		case "the_email";
			$email = $_POST["id_val"];
			
			if (strpos($email,"<") or strpos($email,">")){
				$result = "0;Illegal Email";
				echo $result;
				die();
			}
			
			if($email==""){
				$result = "0;Tidak boleh ada yang kosong";
				echo $result;
				die();
			}
			
			$cref	= $agentwlable;
			$cekemail = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select email from u6048user_id where email = '".$email."' and userprefix='".$cref."'",$params,$options));
			if($cekemail>=1){
				$result = "0;Email sudah pernah terdaftar";
				echo $result;
				die();
			}

			if(!filter_var($email, FILTER_VALIDATE_EMAIL)){
				$result = "0;Harap cek Email";
				echo $result;
				die();
			}
			
			$result = "1;Valid";
			echo $result;	
			die();
		break;
		
		case "the_phone";
			$phone = $_POST["id_val"];
			
			if (strpos($phone,"<") or strpos($phone,">")){
				$result = "0;Illegal Phone";
				echo $result;
				die();
			}
			
			if($phone==""){
				$result = "0;Tidak boleh ada yang kosong";
				echo $result;
				die();
			}
			
			$result = "1;Valid";
			echo $result;	
			die();
		break;
		
		case "the_baname";
			$baname = $_POST["id_val"];
			
			if (strpos($baname,"<") or strpos($baname,">")){
				$result = "0;Illegal Bankname";
				echo $result;
				die();
			}
			
			if($baname==""){
				$result = "0;Tidak boleh ada yang kosong";
				echo $result;
				die();
			}
			
			$result = "1;Valid";
			echo $result;	
			die();
		break;
		
		case "the_bano";
			$bano = $_POST["id_val"];
			$BName = $_POST["id_val2"];

			$cref	= $agentwlable;
			
			$bano4 = $bano;
			$bano = str_replace("-","",$bano);
			$banox2 = str_replace("-","",$bano);
			
			if( strtoupper($BName)=='MANDIRI'){
				$cx1=substr($bano,0,3);
				$cx2=substr($bano,3,3);
				$cx3=substr($bano,6,3);
				$cx4=substr($bano,9,4);
				$banox=$cx1."-".$cx2."-".$cx3."-".$cx4;
			}else if (strtoupper($BName)=='BCA' || strtoupper($BName)=='BNI'){
				$cx1=substr($bano,0,3);
				$cx2=substr($bano,3,3);
				$cx3=substr($bano,6,4);
				$banox=$cx1."-".$cx2."-".$cx3;
			}else if (strtoupper($BName)=='BRI'){
				$cx1=substr($bano,0,3);
				$cx2=substr($bano,3,3);
				$cx3=substr($bano,6,3);
				$cx4=substr($bano,9,3);
				$cx5=substr($bano,12,3);
				$banox=$cx1."-".$cx2."-".$cx3."-".$cx4."-".$cx5;
			}else if (strtoupper($BName)=='DANAMON'){
				$cx1=substr($bano,0,3);
				$cx2=substr($bano,3,3);
				$cx3=substr($bano,6,3);
				$cx4=substr($bano,9,3);
				$banox=$cx1."-".$cx2."-".$cx3."-".$cx4;
			}else if (strtoupper($BName)=='CIMB'){
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
						
			if ($cekb == 1) {
				$result = "0;Pendaftaran Bank gagal";
				echo $result;
				die();
			}
			
			if (!preg_match('/^[0-9]{1,}$/', str_replace("-","",$_POST["id_val"]))) {
				$result = "0;Harus mengandung angka saja";
				echo $result;
				die();
			}
			
			$tes=strtolower($BName);
			if(strlen($tes) > 0){
				if($tes=="bca"){
					if(strlen($banox2) != 10) {
						$ceke=1;
					}
				}else if($tes=="bni"){
					if(strlen($banox2) < 9){
						$ceke=3;
					}
					if(strlen($banox2) > 10){ 
						$ceke=3;
					}
				}else if($tes=="mandiri"){
					if( strlen($banox2) != 13 ) {
						$ceke=2;
					}
				}else if($tes=="bri"){
					if(strlen($banox2) != 15) {
						$ceke=4;
					}
				}
			}
			
			if ($ceke == 1) {
				$result = "0;Akun BCA harus memiliki 10 digit nomor";
				echo $result;
				die();
			}else if ($ceke == 2) {
				$result = "0;Akun MANDIRI harus memiliki 13 digit nomor";
				echo $result;
				die();
			}else if ($ceke == 3) {
				$result = "0;Akun BNI harus memiliki 9 atau 10 digit nomor";
				echo $result;
				die();
			}else if ($ceke == 4) {
				$result = "0;Akun BRI harus memiliki 15 digit nomor";
				echo $result;
				die();
			}
			
			foreach (count_chars($bano, 1) as $i => $val) {
				if($i > 47 && $i < 58) {  }
				else {
					$ckuser = 2;
					$result = "0;Ilegal karakter di Nomor Rekening";
					echo $result;
					die();
				}
			}
			
			$cekBankNo	= sqlsrv_num_rows(sqlsrv_query($sqlconn, "select bankaccno from u6048user_id where bankaccno = '".$bano5."' and userprefix='".$cref."'",$params,$options));
			if ($cekBankNo >= 1){
				$result = "0;Akun bank ini sudah pernah di daftarkan";
				echo $result;
				die();
			}
			
			$blocking_bank = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select * from a83adm_nobankrek where no_rek = '".$banox."' or no_rek = '".$bano4."'",$params,$options));
			if($blocking_bank > 0){
				$result = "0;Bank telah ter blokir";
				echo $result;
				die();
			}
			
			$result = "1;Valid";
			echo $result;	
			die();			
		
		break;
		
		case "the_ref" :
			$referral_text = $_POST["id_val"];
			if ($referral_text){
				$check_userid = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select userid from u6048user_id where loginid = '".$referral_text."' and userprefix='".$agentwlable."'"),SQLSRV_FETCH_ASSOC);
				if ($check_userid["userid"])$ref_userid=$check_userid["userid"];
				else{
					$result = "0;Referral tersebut tidak ada";
					echo $result;
					die();
				}
			}
			
			$result = "1;Valid";
			echo $result;	
			die();	
		break;
	
		case "the_cap" :
			$capt = $_POST["id_val"];
			
			if($capt==""){
				$result = "0;Tidak boleh ada yang kosong";
				echo $result;
				die();
			}
			
			if ($capt != $_SESSION['CAPTCHAString']){
				$result = "0;Validasi anda salah";
				echo $result;
				die();
			}
			
			$result = "1;Valid";
			echo $result;	
			die();
		break;
	}
}
?>