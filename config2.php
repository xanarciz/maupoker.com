<?php
exit();
session_start();
$login = $_SESSION['login'];
if (!$login) $freePage = 1;
include("meta.php");
include("header.php");
include("function/jcd-umum.php");

//$login_enc=base64_decode($_COOKIE["ref_b"]);
//$decode=decodedvc($login_enc);
$cref=$agentwlable;
$noRek	= "1";
$pt = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select playerpt_status from a83adm_config"),SQLSRV_FETCH_ASSOC);
$buka = $pt["playerpt_status"];
if($buka == 0) die("Cannot Open this page.");

$curr = $_POST["Curr"];

if($_POST["submit"]){
	$cekr = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select registration from a83adm_config2"),SQLSRV_FETCH_ASSOC);
	$cekr = $cekr["registration"];
	if($cekr == "0"){echo "<div class='error-report'>Registration Tempolary Closed</div>";
		die();
	}
	$fname = $_POST["FName"];
	$uname = $_POST["UName"];
	$pass = $_POST["Pass"];
	$cpass = $_POST["CPass"];
	$email = $_POST["Email"];
	$phone = $_POST["Phone"];
	$bname = $_POST["BName"];
	$baname = $_POST["BAName"];
	$bano = $_POST["BAno"];
	$bano1 = $_POST["BAno1"];
	$bano2 = $_POST["BAno2"];
	$curr = $_POST["Curr"];
	$prefix = $_POST["pref"];
	$sex = $_POST["Sex"];
	$uname = strtoupper($uname);
	$cek1 = ctype_alnum($pass);
	$cek2 = ctype_alnum($pass);
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
			if(strlen($bano) != 10) {
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

	$jumuser = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from u6048user_id where userid = '".$uname."'",$params,$options));
	$jumuserx = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from u6048user_data where userid = '".$uname."'", $params,$options));
	$jumuserxx = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from j2365join_onlinex where userid = '".$uname."'", $params,$options));
	
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

	if ($capt != $_SESSION['CAPTCHAString']){
		$errorReport =  "<div class='error-report'>Validasi anda salah.</div>";
	}else if($te > 0){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal!</div>";
	}else if($jumuser > 0 || $jumuserx > 0 || $jumuserxx > 0){
		$errorReport = "<div class='error-report'>Pendaftaran gagal.<br>Username telah terdaftar.</div>";
	}else if ($ckuser == 2) {
		$errorReport = "<div class='error-report'>Ilegal karakter di Nomor Rekening.<br> Error nomor rekening</div>";
	}else if(strlen($uname) > 8){
		$errorReport = "<div class='error-report'>Pendafataran gagal.<br>Max. Username  8 huruf</div>";
	}else if(strlen($uname) < 3){
		$errorReport = "<div class='error-report'>Pendafataran gagal.<br>Min. Username  3 huruf</div>";
	}
	else if (!preg_match("/[A-Z]/",substr($uname,0,1))){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Karakter pertama dari Username harus A-Z.</div>";
	}else if(!filter_var($email, FILTER_VALIDATE_EMAIL)){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Harap cek Email.</div>";
	}else if(($fname == "") || ($uname == "") || ($pass == "") || ($cpass == "") || ($email == "") || ($phone == "") || ($baname == "") || ($bano == "")){
		$errorReport =("<div class='error-report'>Pendaftaran Gagal.<br>Tidak boleh ada yang kosong.</div>");
	}else if ($pass != $cpass){
		$errorReport =	("<div class='error-report'>Pendaftaran Gagal.<br>Password tidak sesuai.</div>");
	}else if ($ckuser == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br> Username salah</div>";
	}else if (strlen($pass) < 5) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br> Password mininum 5 Digit</div>";
	}else if ($bname_error == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br> cek Bank Name</div>";
	}else if ($ceke == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun BCA harus memiliki 10 digit nomor </div>";
	}else if ($ceke == 2) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun MANDIRI harus memiliki 13 digit nomor </div>";
	}else if ($ceke == 3) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun BNI harus memiliki 10 digit nomor </div>";
	}else if ($ceke == 4) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Akun BRI harus memiliki 15 digit nomor </div>";
	}else if ($cekb == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Pendaftaran Bank gagal </div>";
	}else if ($rejid == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Username sudah terdaftar </div>";
	}else if ($cekw == 1) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.</div>";
	}else if ($cek1 == "" || $cek2 == "") {
		$errorReport = "<div class='error-report'>Register Failed.<br> Password harus ada huruf dan angka</div>";
	}else if($cekemail>=1){
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br>Email sudah pernah terdaftar</div>";
	}else if ($sekarang < $tglx) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal</div>";
	}else if ($rejpas > 0) { 
		$errorReport = "<div class='error-report'>User Error, tidak dapat menggunakan password ini!</div>";
	}else if ($noRek == '1' && $cekBankNo >= 1){
		$errorReport = "<div class='error-report'>Maaf! akun bank ini sudah pernah di daftarkan</div>";
	} else {
		$uname = str_replace(" ","",$uname);
		$uname = strtoupper($uname);
		
		$depdua = base64_encode(md5("0"));
		//$bano = $bano4."-".$bano1."-".$bano2;
		mssql_query("insert into test2 (a,b,c) values ('BJ test config2',GETDATE(),'".$uname."')");
		sqlsrv_query($sqlconn, "insert into u6048user_id (userid,$cfgDbPasswordfield,userprefix,usertype,username,playerpt,telp,email,bankname,bankaccname,bankaccno,deposit_type,save_deposit,joindate,status, sex,subwebid) values ('".$uname."','".hash("sha256",md5($pass).'8080')."','".$cref."','U','".$fname."','0','".$phone."','".$email."','".$bname."','".$baname."','".$bano5."','1','0',GETDATE(),'0','".$sex."','".$subwebid."')");
		sqlsrv_query ($sqlconn, "insert into u6048user_coin (userid) values ('".$uname."')");
		$gamsql = sqlsrv_query($sqlconn, "select gamecode, playerpt_dwin, playerpt_dlose from a83adm_configgame where status = '1' and status_agencygame='1'");
		$a = 0;
		$b=0;
		$c=0;
		$comsql = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select comms from a83adm_config"),SQLSRV_FETCH_ASSOC);
		$cek=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select * from u6048user_data where userid='$cref'"),SQLSRV_FETCH_ASSOC);
		if($cek["userid"] ==""){
			die("<center>Registration Failed.please Contact Your Agent</center>.");
		}
		while ($gamdata = sqlsrv_fetch_array($gamsql,SQLSRV_FETCH_ASSOC)){	
			$gt = $gamdata["gamecode"];
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
			$commfield .= ",".strtolower($gt)."_refcomm";
			$commfieldx .= ",".strtolower($gt)."_ptcomm";
			$datacomm = strtolower($gt)."_refcomm";
			$datacommx = strtolower($gt)."_ptcomm";
			$value = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select * from a83adm_config"),SQLSRV_FETCH_ASSOC);
			$commvalue .= ",'".$value["$datacomm"]."'";
			$commvaluex .= ",'".$value["$datacommx"]."'";
		}
		
		$gamsqlku = sqlsrv_query($sqlconn, "select userprefix from u6048user_id where userid = '".$uname."'");
		$gamdataref = sqlsrv_fetch_array($gamsqlku,SQLSRV_FETCH_NUMERIC);
		sqlsrv_query($sqlconn, "insert into u6048user_data (userid,usertype,userprefix,curr,periode,balance,credit".$sqldatafield.") values ('".$uname."','U','".$gamdataref[0]."','IDR','1','0','0'".$sqldatavalue.")");
		sqlsrv_query($sqlconn, "insert into u6048user_dataref (userid,userprefix".$commfield."".$commfieldx.") values ('".$uname."','".$gamdataref[0]."'".$commvalue."".$commvaluex.")");
		sqlsrv_query($sqlconn, "insert into u6048user_coin (userid) values ('".$uname."')");
		
		$successRegister = "<centeR><a href='http://".$DomainName."'>$DomainName</a> - Pendaftaran Sukses<br>Username = <b>$uname</b><br>Silakan Login di <a href='http://".$DomainName."'>$DomainName</a><br>Anda bisa melakukan deposit di website <a href='http://".$DomainName."'>$DomainName</a> atau melalui agent anda.<br>Terima Kasih</center>";
		
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

			<div id="content">
                <div class="container">
                    <div class="clear space_30"></div>
                    <div class="wrap">
                        <div class="full">
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
                                        <label class="col-lg-1 control-label">Username</label>
                                        <div class="col-lg-2">
                                            <input type="text" name="UName" id="user_name" placeholder="Username Account Anda" maxlength=8 value="<?php echo $uname; ?>" data-required="true" class="form-control">
                                            <div class="clear space_5"></div>
											<div>
                                                <span id="username_availability_result"></span>
                                                <div class="clear space_5"></div>
                                                <input type='button' id='check_username_availability' class="btn btn-login" value='Check Availability'>
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
                                            <input type="number" name="Phone" placeholder="Nomor Telepon Anda" value="<?php echo $email; ?>" data-required="true" class="form-control">
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nama Bankaaa</label>
                                        <div class="col-lg-2">
										                                                <?php 
											echo "select bank, bankaccno, bankaccname,status from a83adm_configbank where code = '".$cref."' and (curr = 'IDR')";
											?>
                                            <select name='BName' class="form-control">
                                                <?php 
											echo "select bank, bankaccno, bankaccname,status from a83adm_configbank where code = '".$cref."' and (curr = 'IDR')";

												$select = "";
												if($_POST["BName"] == $bankdata["bank"]) $select = "selected";
												$banksql		= sqlsrv_query($sqlconn, "select bank, bankaccno, bankaccname,status from a83adm_configbank where code = '".$cref."' and (curr = 'IDR')",$params,$options); 

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
                                            <input type="number" name="BAno" value="<?php echo $bano; ?>" placeholder="Nomor Rekening Bank Anda" data-required="true" class="form-control">
                                        </div>
                                    </div>
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
                check_availability();  
            }  
        });  
  
  });  
  
//function to check username availability  
function check_availability(){  
	//get the username  
	var username = $('#user_name').val();  

	//use ajax to run the check  
	$.post("check_username.php", { username: username },  
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

</script>
<?php
include("footer.php");
?>