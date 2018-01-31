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

function currx($val) {
   if (!strpos($val,".")) return number_format($val, 0,'.', ',');
   else return number_format($val, 1,'.', ',');
}

if ( $login ){
    //get Referral data
    $reqAPIReferralData = array(
        "auth"  => $authapi,
        "agent" => $agentwlable,
        "userid"=> $login,
        "type"  => 1,
    );

    $respReferralData = sendAPI($url_Api . "/referral", $reqAPIReferralData, 'JSON', '02e97eddc9524a1e');
    $dataReferral = $respReferralData->data;
}

$cref=$agentwlable;
$noRek	= "1";
if($infoweb['pt_status'] == 0) die("Cannot Open this page.");

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

	if($infoweb['open_reg'] == "0"){echo "<div class='error-report'>Registration Tempolary Closed</div>";
		die();
	}

	$uname = str_replace("''","*",$_POST["UName"]);
	$unameid = str_replace("''","*",$_POST["UNameid"]);
	$pass		= $_POST["Pass"];
	$cpass		= $_POST["CPass"];
	$fullname	= $_POST["BAName"];
	$email		= $_POST["Email"];
	$phone		= $_POST["Phone"];
	$bankname	= $_POST["BName"];
	$baname		= $_POST["BAName"];
	$bano		= $_POST["BAno"];
	$curr		= $_POST["Curr"];

    if($_POST['captcha1'] == ''){
        $errorReport = ("<div class='error-report'><strong>Pendaftaran gagal!</strong> Captcha harus diisi</div>");
    }else if($_POST['captcha1'] != $_SESSION['CAPTCHAString']){
        $errorReport = ("<div class='error-report'><strong>Pendaftaran gagal!</strong> Captcha tidak sama</div>");
    }else {
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
                "ref_text" => strtoupper($user_login),
				"device"	=> $device
            )
        );

        $response = sendAPI($url_Api . "/register", $reqAPIRegister, 'JSON', '02e97eddc9524a1e');
        if ($response->status == 200) {
            $successRegister = "<centeR>
                    <a href='http://" . $DomainName . "'>$DomainName</a> - Pendaftaran Sukses<br>Username = <b>$uname</b><br>
                    Silakan Login di <a href='http://" . $DomainName . "'>$DomainName</a><br>
                    Anda bisa melakukan deposit di website <a href='http://" . $DomainName . "'>$DomainName</a> atau melalui agent Anda.<br>
                    Terima Kasih
                    </center>";
        } else {
            $errorReport = ("<div class='error-report'><strong>Pendaftaran gagal!</strong> " . $response->msg . "</div>");
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
              				if ($errorReport){								
              					echo "<div class='big-notification red-notification' id='the_alert'>".$errorReport."</div>";
              				}
							else{
								echo "<div class='big-notification red-notification' id='the_alert' style='display:none;'></div>";
							}
              			?>
          			</div>

                    <form method="post" id="form_reg" style="margin-top: 14px;">

                        <?php if (!$successRegister){ ?>
                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Login ID</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('user_name', 'ceklis1', '')" id="user_name" type="text" class="contactField" name="UName" maxlength="8" value="<?php echo $_POST["UName"]; ?>" />
                            </div>
                        </div>
						
						<div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nickname</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('user_nameid', 'ceklis2', '')" id="user_nameid" type="text" class="contactField" name="UNameid" maxlength="10" value="<?php echo strtoupper($unameid); ?>" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Password</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_pass', 'ceklis3', '')" id="the_pass" type="password" class="contactField" name="Pass" value="<?php echo $_POST["Pass"]; ?>" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Ulangi Password</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_cpass', 'ceklis4', 'the_pass')" id="the_cpass" type="password" class="contactField" name="CPass" value="<?php echo $_POST["CPass"]; ?>" />
                            </div>
                        </div>

                        <div class="decoration"></div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nama</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_fname', 'ceklis5', '')" id="the_fname" type="text" type="text" class="contactField" name="FName" value="<?php echo $_POST["FName"]; ?>" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Alamat Email</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_email', 'ceklis6', '')" id="the_email" type="text" class="contactField" maxlength="40"  name="Email" value="<?php echo $_POST["Email"]; ?>" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">No. Telp / HP</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_phone', 'ceklis7', '')" id="the_phone" type="text" class="contactField" maxlength="13" name="Phone" value="<?php echo $_POST["Phone"]; ?>" />
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
                                <input onBlur="fast_checking('the_baname', 'ceklis8', '')" id="the_baname" type="text" class="contactField" maxlength="25" name="BAName" value="<?php echo $_POST["BAName"]; ?>" />
                                <div style="height:5px;"></div>
                                <span class="note">* Nama lengkap anda sesuai dibuku tabungan</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nomor Rekening</label>
                            </div>
                            <div class="formInput">
                                <input onBlur="fast_checking('the_bano', 'ceklis9', 'the_bname')" id="the_bano" type="text" class="contactField" name="BAno" id="BAno" value="<?php echo $_POST["BAno"];?>" />
                            </div>
                        </div>

							<div class="formLabel">
                                <label class="field-title formTextarea">Referral</label>
                            </div>
							<div class="formInput">
                                <?php echo "<b>http://".$DomainName."/ref.php?ref=$user_login</b>"; ?>
							</div>
						</div>
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

        <?php include ("_footer.php");?>