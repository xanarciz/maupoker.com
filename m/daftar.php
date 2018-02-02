<?php
session_start();
$page='daftar';
include("_meta.php");
include("_header.php");
include("../function/jcd-umum.php");
if($register != 1) {
    exit("<script> window.location = 'login.php'</script>");
}
if ($login){
    exit("<script> window.location = 'login.php'</script>");
}
$cref=$agentwlable;
$noRek	= "1";
if($infoweb['pt_status'] == 0) die("Cannot Open this page.");

$curr = isset($_POST["Curr"]) ? $_POST["Curr"] : '';
$ref = strtoupper(isset($_COOKIE["ref"]) ? $_COOKIE["ref"] : '');
if (!$ref)$ref="";
if($ref == ''){
	$ref = isset($_POST['ref_text']);
}
if(isset($_POST["submit"])){
	if($infoweb['open_reg'] == "0"){echo "<div class='error-report'>Registration Tempolary Closed</div>";
        die();
    }
	$fname = isset($_POST["FName"]) ? $_POST["FName"] : '';
	$uname = str_replace("''","*",(isset($_POST["UName"]) ? $_POST["UName"] : ''));
	$unameid = str_replace("''","*",(isset($_POST["UNameid"]) ? $_POST["UNameid"] : ''));
	$pass = isset($_POST["Pass"]) ? $_POST["Pass"] : '';
	$cpass = isset($_POST["CPass"]) ? $_POST["CPass"] : '';
	$email = isset($_POST["Email"]) ? $_POST["Email"] : '';
	$phone = isset($_POST["Phone"]) ? $_POST["Phone"] : '';
	$bname = isset($_POST["BName"]) ? $_POST["BName"] : '';
	$fullname	= str_replace("''","*",(isset($_POST["BAName"]) ? $_POST["BAName"] : ''));
	$baname = str_replace("''","*",(isset($_POST["BAName"]) ? $_POST["BAName"] : ''));
	$bano = isset($_POST["BAno"]) ? $_POST["BAno"] : '';
	$bano1 = isset($_POST["BAno1"]) ? $_POST["BAno1"] : '';
	$bano2 = isset($_POST["BAno2"]) ? $_POST["BAno2"] : '';
	$curr = isset($_POST["Curr"]) ? $_POST["Curr"] : '';
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
				"bankname" 	=> $bname, 
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

        <div class="content">

            <div class="container main no-bottom">

                <div class="wrapper">

                	<style type="text/css">
                		.big-notification {
						    position: fixed;
						    z-index: 9999;
						    width: 100%;
						    top: 70px;
						    margin-left: -10px;
						}
                	</style>

                    <div class="container no-bottom">
                    	<h3>Form Pendaftaran</h3>
                    </div>

                    <div class="decoration"></div>

                    <div class="res" id="res_reg" align="center">
              			<?php
                            if(!isset($errorReport)){$errorReport = '';}
              				if ($errorReport){								
              					echo "<div class='big-notification red-notification' id='the_alert'>".$errorReport."</div>";
              				}
							else{
								echo "<div class='big-notification red-notification' id='the_alert' style='display:none;'></div>";
							}
              			?>
          			</div>

                    <form method="post" id="form_reg" style="margin-top: 14px;">
                        <?php 
                        if(!isset($successRegister)){$successRegister = '';}
                        if (!$successRegister){ ?>
                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Login ID</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('user_name', 'ceklis1', '')" id="user_name" type="text" class="contactField" name="UName" maxlength="8" value="<?php if (isset($_POST["UName"])) { echo $_POST["UName"];} ?>" />
                            </div>
                        </div>
						
						<div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nickname</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('user_nameid', 'ceklis2', '')" id="user_nameid" type="text" class="contactField" name="UNameid" maxlength="10" value="<?php if(!isset($unameid)){$unameid = '';} echo strtoupper($unameid); ?>" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Password</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_pass', 'ceklis3', '')" id="the_pass" type="password" class="contactField" name="Pass" value="<?php if (isset($_POST["Pass"])) {echo $_POST["Pass"];} ?>" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Ulangi Password</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_cpass', 'ceklis4', 'the_pass')" id="the_cpass" type="password" class="contactField" name="CPass" value="<?php if (isset($_POST["CPass"])) {echo $_POST["CPass"];} ?>" />
                            </div>
                        </div>

                        <div class="decoration"></div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nama</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_fname', 'ceklis5', '')" id="the_fname" type="text" type="text" class="contactField" name="FName" value="<?php if (isset($_POST["FName"])) {echo $_POST["FName"];} ?>" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Alamat Email</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_email', 'ceklis6', '')" id="the_email" type="text" class="contactField" maxlength="40"  name="Email" value="<?php if (isset($_POST["Email"])) {echo $_POST["Email"];} ?>" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">No. Telp / HP</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_phone', 'ceklis7', '')" id="the_phone" type="text" class="contactField" maxlength="13" name="Phone" value="<?php if (isset($_POST["Phone"])) {echo $_POST["Phone"];} ?>" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nama Bank</label>
                            </div>
                            <div class="formInput">
                                <select name="BName" class="contactField contactOption" id="the_bname">
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

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nama Rekening</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_baname', 'ceklis8', 'the_bname')" id="the_baname" type="text" class="contactField" maxlength="25" name="BAName" value="<?php echo $_POST["BAName"]; ?>" />
                                <div style="height:5px;"></div>
                                <span class="note">* Nama lengkap anda sesuai dibuku tabungan</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nomor Rekening</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_bano', 'ceklis9', 'the_bname')" id="the_bano" type="text" class="contactField" name="BAno" id="BAno" value="<?php if (isset($_POST["BAno"])) {echo $_POST["BAno"];} ?>" />
                            </div>
                        </div>

						<?php
							if ($ref != ''){
						?>
							<div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Link Referral</label>
                            </div>
                            <div class="formInput">
                                <span class="formText">
                                <?php echo "<b>".strtoupper($ref)."</b>"; ?>
                                </span>
                            </div>
                        </div>
							<?php
							}else{
							?>
							<div class="formLabel">
                                <label class="field-title formTextarea">Referral</label>
                            </div>
							<div class="formInput">
                                <input class="contactField" onBlur="fast_checking('the_ref', 'ceklis10', '')" id="the_ref" type="text" name="ref_text"  value="" />
								<br>*Ini tidak wajib harus diisi
							</div>
						</div>
						<?php } ?>
                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Validasi</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_cap', 'ceklis11', '')" id="the_cap" class="contactField" type="text" name="captcha1" maxlength="5" />
                                <div style="height:10px;"></div>
                                <img src='../../captcha/captcha.php?.png' alt='CAPTCHA' width='120' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">
                            </div>
                        </div>

                        <!--<input id="mobile" type="hidden" name="mobile" value="mobile"  />-->

                        <div class="formSubmitButtonErrorsWrap">
                            <input type="submit" name="submit" class="buttonWrap button button-reds contactSubmitButton" value="DAFTAR" />
                        </div>

                        <?php
            			}else{
            				//echo "<h2>".$successRegister."</h2>";
                            echo "<div class='big-notification green-notification'>
                                <h3 class='uppercase'>Pendaftaran Sukses</h3>
                                <a href='#' class='close-big-notification'>x</a>
                                <p>".$successRegister."</p>
                            </div>";
            			}
            			?>


                    </form>

                </div>

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

	$('#the_alert').html("<img src='assets/loading/loading.gif' width='20' height='20' title='checking...' />");
	$('#the_alert').css('background-color', '');
	$('#the_alert').show(); 
	
	$.post("../fast_checking.php", { id_div:id_div, id_val:id_val, id_val2:id_val2},
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