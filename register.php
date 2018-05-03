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
if($infoweb['pt_status'] == 0) die("Cannot Open this page.");

$curr = $_POST["Curr"];
$ref = strtoupper($_COOKIE["ref"]);
if (!$ref)$ref="";
if($ref == ''){
	$ref = $_POST['ref_text'];
}
if(isset($_POST["submit"])){
	$uname 		= str_replace("''","*",$_POST["UName"]);
	$unameid 	= str_replace("''","*",$_POST["UNameid"]);
	$pass		= isset($_POST["Pass"]) ? $_POST["Pass"] :'';
	$cpass		= isset($_POST["CPass"]) ? $_POST["CPass"] :'';
	$fullname	= isset($_POST["BAName"]) ? $_POST["BAName"] :'';
	$email		= isset($_POST["Email"]) ? $_POST["Email"] :'';
	$phone		= isset($_POST["Phone"]) ? $_POST["Phone"] :'';
	$bankname	= isset($_POST["BName"]) ? $_POST["BName"] :'';
	$baname		= isset($_POST["BAName"]) ? $_POST["BAName"] :'';
	$bano		= isset($_POST["BAno"]) ? $_POST["BAno"] :'';
	$curr		= isset($_POST["Curr"]) ? $_POST["Curr"] :'';

	//PASSWORD ALPHA NUMERIC	
	if($_POST['captcha1'] == ''){
		$errorReport = ("<strong>Pendaftaran gagal!</strong> Captcha harus diisi");
	}else if(!checkCaptcha('CAPTCHAString', $_POST['captcha1'])){
		$errorReport = ("<strong>Pendaftaran gagal!</strong> Captcha tidak sama");
	}else{
		$reqAPIRegister = array(
            "auth"    => $authapi,
			"webid"   => $subwebid,
			"regType" => 1,
			"input"	  => array(
				"agent"		=> $agentwlable,
				"username"  => strtoupper($uname),
				"nickname"  => strtoupper($unameid), 
				"password"  => $pass, 
				"cpassword" => $cpass, 
				"fullname"  => $fullname, 
				"email" 	=> $email, 
				"phone" 	=> $phone, 
				"bankname" 	=> $bankname, 
				"baname" 	=> $baname, 
				"bano" 		=> $bano, 
				"ref_text"  => strtoupper($ref),
				"device"	=> $device
			)
		);
		
		$response = sendAPI($url_Api."/register",$reqAPIRegister,'JSON','02e97eddc9524a1e');
		if($response->status == 200){
			$successRegister = "<centeR>
				<a href='http://".$DomainName."'>$DomainName</a> - Pendaftaran Sukses<br>
				Username = <b>$uname</b><br>
				Anda bisa melakukan deposit di website <a href='http://".$DomainName."'>$DomainName</a> atau melalui agent anda.<br>
				Terima Kasih  (#1021)<br><br> 
				<font style='font-weight:bold;'>Anda akan terlogin dalam <label id='counter'>5</label>s</font>
				</center>";
		}else{
			$errorReport =	("<strong>Pendaftaran gagal!</strong> " . $response->msg);
		}
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
							// echo"<script>
							// 	document.getElementById('menu-register').href='j_register';
							// 	document.getElementById('menu-deposit').href='j_deposit';
							// 	document.getElementById('menu-withdraw').href='j_withdraw';
							// </script>";
						
						?>
						    <div class="head-wrap">
                                <h1>Daftar</h1>
                            </div>
                            <div class="body-wrap">
								<style> .validx {	position:absolute;right:-25px;margin-top:3px; } </style>
                                <form class="form-horizontal" role="form" method="POST">
									<?php 
									if(!isset($errorReport)){$errorReport = '';}
									if(!isset($successRegister)){$successRegister = '';}
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
                                        <label class="col-lg-1 control-label">Username</label>
                                        <div class="col-lg-2">
											<div id="ceklis1" class="validx"></div>
                                            <input onBlur="fast_checking('user_name', 'ceklis1', '')" type="text" name="UName" id="user_name" placeholder="Username Account Anda" maxlength=10 value="<?php if(!isset($uname)){$uname = '';} echo $uname; ?>" data-required="true" class="form-control">                                           
										</div>
                                    </div>
									
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nickname</label>
                                        <div class="col-lg-2">
											<div id="ceklis2" class="validx"></div>
                                            <input onBlur="fast_checking('user_nameid', 'ceklis2', '')" type="text" name="UNameid" id="user_nameid" placeholder="Tampilan anda dalam game" maxlength=10 value="<?php if(!isset($unameid)){$unameid = '';} echo strtoupper($unameid); ?>" data-required="true" class="form-control">											
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
                                            <input onBlur="fast_checking('the_email', 'ceklis6', '')" type="email" name="Email" id="the_email" placeholder="Email harus valid dan benar, email_anda@example.com" maxlength=40 value="<?php if(!isset($email)){$email = '';} echo $email; ?>" class="form-control" data-required="true" data-type="email">
											<span style="float:left;">Email Harus Aktif</span>
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">No Telepon</label>
                                        <div class="col-lg-2">
											<div id="ceklis7" class="validx"></div>
                                            <input onBlur="fast_checking('the_phone', 'ceklis7', '')" type="text" name="Phone"  id="the_phone" placeholder="Nomor Telepon Anda" maxlength=13  value="<?php if(!isset($phone)){$phone = '';} echo $phone; ?>" data-required="true" class="form-control">
                                        </div>
                                    </div>
									<div class="form-group-full">
										<label class="col-lg-1 control-label">Nama Rekening Bank</label>
										<div class="col-lg-2">
											<div id="ceklis8" class="validx"></div>
											<input onblur="fast_checking('the_baname', 'ceklis8', 'the_bname')" type="text" name="BAName" id="the_baname" value="<?php echo $baname; ?>" placeholder="Nama Lengkap Anda Sesuai Buku tabungan" data-required="true" class="form-control" maxlength="50" >
										</div>
									</div>

									<div class="form-group-full">
										<label class="col-lg-1 control-label">Nama Bank</label>
										<div class="col-lg-2">
										   <select name='BName' id="the_bname" class="form-control">
												<?php
												foreach($infoweb['bankList'] as $bankdata){
													$select = "";
													if($_POST["BName"] == $bankdata['bank']) $select = "selected";
													$options.= "<option value='".$bankdata['bank']."' ".$select.">".$bankdata['bankname']."</option>";
												}
												echo $options;
												?>
											</select>
										</div>
									</div>

									<div class="form-group-full">
										<label class="col-lg-1 control-label">Nomor Rekening Bank</label>
										<div class="col-lg-2">
											<div id="ceklis9" class="validx"></div>
											<input onblur="fast_checking('the_bano', 'ceklis9', 'the_bname')" type="text" name="BAno" id="the_bano" value="<?php if(!isset($bano)){$bano = '';} echo $bano; ?>" placeholder="Nomor Rekening Bank Anda" data-required="true" class="form-control" maxlength="30" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" onblur="this.value=this.value.replace(/[^0-9]/g,'');" onKeypress="if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }">
										</div>
									</div>

									<?php
									if ($ref != ''){
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
					// document.getElementById("membervalidation").value = result;
					// document.getElementById("frmlgn").submit();
					document.getElementById("the_click").click();

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