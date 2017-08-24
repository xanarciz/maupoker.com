<?php
include("meta.php");
include("header.php");
include("function/jcd-umum.php");
$noRek = "1";
if (!$register)exit("<script>location.href='index.php'</script>");
$ref = strtoupper($_COOKIE["ref"]);
if (!$ref)$ref="";

if($_POST["submit"]){
	$cekr = $infoweb["open_reg"];
	if($cekr == "0"){echo "<div class='error-report'>Registration Tempolary Closed</div>";
		die();
	}

	$uname = $_POST["UName"];
	$unameid = $_POST["UNameid"];
	$pass = $_POST["Pass"];
	$cpass = $_POST["CPass"];
	$email = $_POST["Email"];
	$phone = $_POST["Phone"];
	
    if($_POST['captcha1'] == ''){
        $errorReport = ("<strong>Pendaftaran gagal!</strong> Captcha harus diisi");
    }else if($_POST['captcha1'] != $_SESSION['CAPTCHAString']){
        $errorReport = ("<strong>Pendaftaran gagal!</strong> Captcha tidak sama");
    }else{
        $reqAPIRegister = array(
            "auth"    => $authapi,
            "webid"   => $subwebid,
            "regType" => 2,
            "input"	  => array(
                "agent"		=> $agentwlable,
                "username"  => strtoupper($uname),
                "nickname"  => strtoupper($unameid),
                "password"  => $pass,
                "cpassword" => $cpass,
                "email" 	=> $email,
                "phone" 	=> $phone,
                "ref_text"  => strtoupper($user_login),
                "device"	=> $device
            )
        );

        $response = sendAPI($url_Api."/register",$reqAPIRegister,'JSON','02e97eddc9524a1e');
        if($response->status == 200){
            $successRegister = "<center>
                <a href='http://".$DomainName."'>$DomainName</a> - Pendaftaran Sukses<br>Username = <b>$uname</b><br>
                Silakan Login di <a href='http://".$DomainName."'>$DomainName</a><br>
                Anda bisa melakukan deposit di website <a href='http://".$DomainName."'>$DomainName</a> atau melalui agent anda.<br>
                Terima Kasih
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
                            <div class="head-wrap">
                                <h1>Daftar Referral Baru</h1>
                            </div>
                            <div class="body-wrap">
                                <a class="btn btn-login" href="referral.php?date=<?php echo"".$userpass."";?>&userid=<?php echo"".$login."";?>&st=5&j=1&batas=5&ref=getdate()" style="float:left;">Data</a>&nbsp;
                                <a class="btn btn-login" href="referral-daftar.php?date=<?php echo"".$userpass."";?>&userid=<?php echo"".$login."";?>&type=star" style="float:left;margin-left: 5px;">Daftar</a>
                                <div style="height:20px;"></div>
                                <form class="form-horizontal" role="form" method="POST">
									<style> .validx {	position:absolute;right:-25px;margin-top:3px; } </style>
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
										<label class="col-lg-1 control-label">Username</label>
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
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Link Referral</label>
                                        <div class="col-lg-2" style="text-align:left">
											<?php echo "<b>http://".$DomainName."/ref.php?ref=$user_login</b>"; ?>
                                        </div>
                                    </div>
									<div class="form-group-full">
										
										<label class="col-lg-1 control-label">saham referral</label>
										<div class="col-lg-3 text-justify" >
											<b><?php echo $saham_share;?></b>
										</div>
									</DIV>
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
include("footer.php");
?>