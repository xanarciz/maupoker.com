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
			$check_userid = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select userid from u6048user_id where loginid = '".$referral_text."' and userprefix='".$agentwlable."'",$params,$options));
			if ($check_userid > 0)$ref=$referral_text;
			else $ref_error="#error_name";
		}
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
	$jumuserxx = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from j2365join_onlinex where userid = '".$uname."'", $params,$options));
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

		if(filter_var($client, FILTER_VALIDATE_IP)){ $ip = $client;	}
		elseif(filter_var($forward, FILTER_VALIDATE_IP)){ $ip = $forward; }
		else{ $ip = $remote; }
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

	if ($capt != $_SESSION['CAPTCHAString']){
		$errorReport =  "<div class='error-report'>Validasi anda salah.(#1001)</div>";
	}else if($pv !== true){ 
		$errorReport =  "<div class='error-report'>".$pv." (#1002)</div>"; 
	}else if($te > 0){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal! (#1003)</div>";
	}else if($jumuser > 0 || $jumuserx > 0 || $jumuserxx > 0 || $jumuserxxx > 0){
		if($jumuserx > 0) $errorReport = "<div class='error-report'>Pendaftaran gagal.<br>Nickname telah terdaftar. (#1004)</div>";
		else $errorReport = "<div class='error-report'>Pendaftaran gagal.<br>Username telah terdaftar. (#1004)</div>";
	}else if ($ckuser == 2) {
		$errorReport = "<div class='error-report'>Ilegal karakter di Nomor Rekening.<br> Error nomor rekening (#1005)</div>";
	}else if(strlen($uname) > 10 || strlen($unameid) > 10){
		$errorReport = "<div class='error-report'>Pendafataran gagal.<br>Max. Login ID dan Nickname 10 huruf (#1006)</div>";
	}else if(strlen($uname) < 3 || strlen($unameid) < 3){
		$errorReport = "<div class='error-report'>Pendafataran gagal.<br>Min. Login ID dan Nickname 3 huruf (#1007)</div>";
	}else if (!preg_match("/[A-Z]/",substr($uname,0,1))){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Karakter pertama dari Login ID harus A-Z. (#1008)</div>";
	}else if (!preg_match("/[A-Z]/",substr($unameid,0,1))){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Karakter pertama dari Nickname harus A-Z. (#1008)</div>";
	}else if(!filter_var($email, FILTER_VALIDATE_EMAIL)){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Harap cek Email. (#1009)</div>";
	}else if(($fname == "") || ($uname == "") || ($unameid == "") || ($pass == "") || ($cpass == "") || ($email == "") || ($phone == "") || ($baname == "") || ($bano == "")){
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
	}else if ($bname_error == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br> cek Nama bank (#1014)</div>";
	}else if ($ceke == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun BCA harus memiliki 10 digit nomor (#1100)</div>";
	}else if ($ceke == 2) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun MANDIRI harus memiliki 13 digit nomor (#1101)</div>";
	}else if ($ceke == 3) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun BNI harus memiliki 9 atau 10 digit nomor (#1102)</div>";
	}else if ($ceke == 4) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun BRI harus memiliki 15 digit nomor (#1103)</div>";
	}else if ($cekb == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Pendaftaran Bank gagal (#1015)</div>";
	}else if ($ref_error == "#error_name") {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Referral anda salah (#1016)</div>";
	}else if ($cekw == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal. (#1017)</div>";
	}else if($cekemail>=1){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Email sudah pernah terdaftar (#1018)</div>";
	}else if ($noRek == '1' && $cekBankNo >= 1){
		$errorReport = "<div class='error-report'>Maaf! akun bank ini sudah pernah di daftarkan (#1019)</div>";
	} else {
		$uname = strtoupper(str_replace(" ","",$uname));
		$unameid = strtoupper(str_replace(" ","",$unameid));
		
		$gamsql = sqlsrv_query($sqlconn, "select gamecode, playerpt_dwin, playerpt_dlose from a83adm_configgame where status = '1' and status_agencygame='1'");
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
		else
			begin
				insert into u6048user_id (userid, loginid, $cfgDbPasswordfield,userprefix,referral_agent,usertype,username,playerpt,telp,email,bankname,bankaccname,bankaccno,deposit_type,save_deposit,joindate,status,bankgrup,subwebid,flag) values ('".$unameid."', '".$uname."','".hash("sha256",md5($pass).'8080')."','".$cref."','".$ref."','U','".$fname."','0','".$phone."','".$email."','".$bname."','".$baname."','".$bano5."','1','0',GETDATE(),'0','1','".$subwebid."','1')
			end"
		),SQLSRV_FETCH_ASSOC);
		if ($t["hasil"]=="1"){
			exit("Failed to register 2.");	
		}
	
		sqlsrv_query ($sqlconn, "insert into u6048user_coin (userid) values ('".$unameid."')");
		sqlsrv_query ($sqlconn, "insert into t6413txh_lastorder (userid,total,status) values ('".$unameid."', '0', 'REGISTER')");
		while ( $gamdata = sqlsrv_fetch_array($gamsql,SQLSRV_FETCH_ASSOC) ){	
			$gt = $gamdata["gamecode"];
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
			$commfield .= ",".strtolower($gt)."_refcomm";
			$commfieldx .= ",".strtolower($gt)."_ptcomm";
			$datacomm = strtolower($gt)."_refcomm";
			$datacommx = strtolower($gt)."_ptcomm";
			$value = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select * from a83adm_config"),SQLSRV_FETCH_ASSOC);
			$commvalue .= ",'".$value["$datacomm"]."'";
			$commvaluex .= ",'".$value["$datacommx"]."'";
		}

		$q_config=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select saham_referral_agent from t6413txh_config"),SQLSRV_FETCH_ASSOC);
		$q_config2=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select saham_referral_agent from d338dmm_config"),SQLSRV_FETCH_ASSOC);
		$q_config3=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select saham_referral_agent from e303ebn_config"),SQLSRV_FETCH_ASSOC);
		$q_config4=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select saham_referral_agent from b365bjk_config"),SQLSRV_FETCH_ASSOC);
		
		$data_ref_share = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select txh_aref_share,dmm_aref_share,ebn_aref_share,bjk_aref_share from u6048user_data where userid = '".$ref."'"));
		$txh_aref_share = $data_ref_share["txh_aref_share"];
		$dmm_aref_share = $data_ref_share["dmm_aref_share"];
		$ebn_aref_share = $data_ref_share["ebn_aref_share"];
		$bjk_aref_share = $data_ref_share["bjk_aref_share"];
		if (!$ref){
			sqlsrv_query($sqlconn, "insert into u6048user_data (userid,usertype,referral_agent,txh_aref_share,dmm_aref_share,ebn_aref_share,bjk_aref_share,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$ref."','".$q_config["saham_referral_agent"]."','".$q_config2["saham_referral_agent"]."','".$q_config3["saham_referral_agent"]."','".$q_config4["saham_referral_agent"]."','".$agentwlable."','IDR','1','0','0'".$sqldatavalue.")");
		}else{	
			if($txh_aref_share == ""){
				sqlsrv_query($sqlconn, "insert into u6048user_data (userid,usertype,referral_agent,txh_aref_share,dmm_aref_share,ebn_aref_share,bjk_aref_share,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$ref."','".$q_config["saham_referral_agent"]."','".$q_config2["saham_referral_agent"]."','".$q_config3["saham_referral_agent"]."','".$q_config4["saham_referral_agent"]."','".$agentwlable."','IDR','1','0','0'".$sqldatavalue.")");
			}else{
				sqlsrv_query($sqlconn, "insert into u6048user_data (userid,usertype,referral_agent,txh_aref_share,dmm_aref_share,ebn_aref_share,bjk_aref_share,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$unameid."','U','".$ref."','".$txh_aref_share."','".$dmm_aref_share."','".$ebn_aref_share."','".$bjk_aref_share."','".$agentwlable."','IDR','1','0','0'".$sqldatavalue.")");
			}
		}
		
		sqlsrv_query($sqlconn, "insert into u6048user_dataref (userid,referral_agent,userprefix".$commfield."".$commfieldx.") values ('".$unameid."','".$ref."','".$agentwlable."'".$commvalue."".$commvaluex.")");
		if (sqlsrv_num_rows($gamsqlku) == 0){
			sqlsrv_query($sqlconn,"insert into log_error (error) values('".$unameid."-".hash("sha256",md5($pass).'8080')."-".$cref."-".$ref."-U-".$fname."-0-".$phone."-".$email."-".$bname."-".$baname."-".$bano5."-1-0-0-".$sex."-".$subwebid."')");
		}
		$successRegister = "<centeR><a href='http://".$DomainName."'>$DomainName</a> - Pendaftaran Sukses<br>Username = <b>$uname</b><br>Silakan Login di <a href='http://".$DomainName."'>$DomainName</a><br>Anda bisa melakukan deposit di website <a href='http://".$DomainName."'>$DomainName</a> atau melalui agent anda.<br>Terima Kasih  (#1021)</center>";
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
                                        <label class="col-lg-1 control-label">Login ID</label>
                                        <div class="col-lg-2">
                                            <input type="text" name="UName" id="user_name" placeholder="Username Account Anda" maxlength=8 value="<?php echo $uname; ?>" data-required="true" class="form-control">
                                            <div class="clear space_5"></div>
											<div>
                                                <span id="username_availability_result"></span>
                                                <div class="clear space_5"></div>
                                                <input type='button' id='check_username_availability' class="btn btn-login" value='Cek Ketersediaan'>
											</div>
										</div>
                                    </div>
									
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nickname</label>
                                        <div class="col-lg-2">
                                            <input type="text" name="UNameid" id="user_nameid" placeholder="Tampilan anda dalam game" maxlength=10 value="<?php echo strtoupper($unameid); ?>" data-required="true" class="form-control">
											<div class="clear space_5"></div>
											<div>
                                                <span id="nickname_availability_result"></span>
                                                <div class="clear space_5"></div>
                                                <input type='button' id='check_nickname_availability' class="btn btn-login" value='Cek Ketersediaan'>
											</div>
										</div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Password</label>
                                        <div class="col-lg-2">
                                            <input type="password" name="Pass" placeholder="Password Account Anda" class="form-control">
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Konfirmasi Password</label>
                                        <div class="col-lg-2">
                                            <input type="password" name="CPass" placeholder="Konfirmasi Password Account Anda" class="form-control">
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nama Lengkap</label>
                                        <div class="col-lg-2">
                                            <input type="text" name="FName" placeholder="Nama Lengkap Anda" value="<?php echo $fname; ?>" data-required="true" class="form-control">
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Email</label>
                                        <div class="col-lg-2">
                                            <input type="text" name="Email" placeholder="email_anda@example.com" value="<?php echo $email; ?>" class="form-control" data-required="true" data-type="email">
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">No Telepon</label>
                                        <div class="col-lg-2">
                                            <input type="text" name="Phone" placeholder="Nomor Telepon Anda" value="<?php echo $phone; ?>" data-required="true" class="form-control">
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nama Bank</label>
                                        <div class="col-lg-2">
                                            <select name='BName' class="form-control">
                                                <?php 
												$select = "";
												if($_POST["BName"] == $bankdata["bank"]) $select = "selected";
												$banksql		= sqlsrv_query($sqlconn, "select distinct(bank) as bank from a83adm_configbank where code = '".$cref."' and (curr = 'IDR')",$params,$options); 

												while($bankdata = sqlsrv_fetch_array($banksql,SQLSRV_FETCH_ASSOC)){
													$select = "";
													echo $_POST["BName"]."aaaa<br>";
													echo $bankdata["bank"];
													if($_POST["BName"] == $bankdata["bank"]) $select = "selected";
													$options.= "<option value='".$bankdata["bank"]."' ".$select.">".$bankdata["bank"]."</option>";
												}
												echo $options;
												?>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nama Rekening Bank</label>
                                        <div class="col-lg-2">
                                            <input type="text" name="BAName" value="<?php echo $baname; ?>" placeholder="Nama Lengkap Anda Sesuai Buku tabungan" data-required="true" class="form-control">
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nomor Rekening Bank</label>
                                        <div class="col-lg-2">
                                            <input type="text" name="BAno" value="<?php echo $bano; ?>" placeholder="Nomor Rekening Bank Anda" data-required="true" class="form-control">
                                        </div>
                                    </div>
									<?php

									$q_check_real_referral = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select userid from u6048user_id where userid = '".$ref."' and subwebid='".$subwebid."'"),SQLSRV_FETCH_ASSOC);
									if ($q_check_real_referral["userid"]){
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
											<input type="text" name="ref_text" value="" placeholder="Nama Referral" data-required="true" class="form-control">
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
                                            <input type="text" name="captcha1" placeholder="Validation" data-required="true" class="form-control">
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
	$(document).ready(function() {  
		//the min chars for username  
		var min_chars = 3;  

		//result texts  
		var characters_error = 'Minimal 3 huruf';  
		var checking_html = 'Checking...';  

		//when button is clicked  
		$('#check_username_availability').click(function(){  
			//run the character number check  
			if($('#user_name').val().length < min_chars){  
				//if it's bellow the minimum show characters_error text '  
				$('#username_availability_result').html(characters_error);  
			}else{  
				//else show the cheking_text and run the function to check  
				$('#username_availability_result').html(checking_html);  
				check_availability(1);  
			}  
		}); 
		$('#check_nickname_availability').click(function(){  
			//run the character number check  
			if($('#user_nameid').val().length < min_chars){  
				//if it's bellow the minimum show characters_error text '  
				$('#nickname_availability_result').html(characters_error);  
			}else{  
				//else show the cheking_text and run the function to check  
				$('#unickname_availability_result').html(checking_html);  
				check_availability(2);  
			}  
		}); 		

	});  
	  
	//function to check username availability  
	function check_availability(pattern){  
		//get the username  
		if(pattern==1){
			var username = $('#user_name').val();  

			//use ajax to run the check  
			$.post("check_username.php?pattern="+pattern, { username: username },  
				function(result){  
					//if the result is 1 
					if(result == 0){  
						//show that the username is available  
						$('#username_availability_result').html(username + ' is Available');  
					}else{  
						//show that the username is NOT available  
						$('#username_availability_result').html(username + ' is not Available');  
					}  
				}
			);  
		}
		else{
			var username = $('#user_nameid').val();  
			//use ajax to run the check  
			$.post("check_username.php?pattern="+pattern, { username: username },  
				function(result){  
					//if the result is 1 
					if(result == 0){  
						//show that the username is available  
						$('#nickname_availability_result').html(username + ' is Available');  
					}else{  
						//show that the username is NOT available  
						$('#nickname_availability_result').html(username + ' is not Available');  
					}  
				}
			); 
		}
	}  

	</script>
<?php
include("footer.php");
?>