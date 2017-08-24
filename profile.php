<?php
include("meta.php");
include("header.php");
include("function/jcd-umum.php");

$iplist = getUserIP2().','.getUserIP2('HTTP_CLIENT_IP').','.getUserIP2('HTTP_X_FORWARDED_FOR').','.getUserIP2('REMOTE_ADDR');

if ($_POST["reset_pin"]){
	$reqAPIResetPin = array(
		"auth" 	    => $authapi,
		"domain" 	=> $nonWWW,
		"ip"		=> $iplist,
		"device"	=> $device,
		"type"		=> 1,
		"userid"	=> $login,
	);
	$respResetPin = sendAPI($url_Api."/account",$reqAPIResetPin,'JSON','02e97eddc9524a1e');
	if($respResetPin->status == 500){
		$error = $respResetPin->msg;
	}else{
		$_SESSION["pin"]="";
		exit ("<script>window.location='../index.php'</script>");
	}
}
if($_POST["submit"]){
	
	$uname = $login;
	$old	= $_POST["old"];
	$new1	= $_POST["new1"];
	$new2	= $_POST["new2"];
    $bano 	= $_POST["bano"];
	$capt	= $_POST["captcha"];
	
	if (! checkCaptcha('CAPTCHAString', $capt)){
		$errorReport =  "<div class='error-report'>Validasi anda salah.</div>";
		$err = 1;
	}elseif ($capt == ''){
		$errorReport =  "<div class='error-report'>Validasi anda salah.</div>";
		$err = 1;
	}else{
		$reqAPIResetPass = array(
			"auth"   	=> $authapi,
			"domain" 	=> $nonWWW,
			"ip"		=> $iplist,
			"device"	=> $device,
			"type"		=> 2,
			"userid"	=> $login,
			"oldpass"	=> $old,
			"npass"		=> $new1,
			"cnpass"	=> $new2,
            'bano'      => $bano,
		);
		$respResetPass = sendAPI($url_Api."/account",$reqAPIResetPass,'JSON','02e97eddc9524a1e');
		if($respResetPass->status == 500){
			$errorReport =  "<div class='error-report'>".$respResetPass->msg."</div>";
		}else{
			?>
			<script>
				alert("Sukses ganti password,Silakan Login kembali.");
			</script>
			<?php
			echo "<script>document.location='../logout.php'</script>";
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
                                <h1>Profil</h1>
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
                                        <label class="col-lg-1 control-label">user ID </label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7 normal">
											<?php echo strtoupper($user_login);?>
											</div>
                                        </div>
                                    </div>
                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">game ID</label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7 normal">
											<?php echo strtoupper($login);?>
											</div>
                                        </div>
                                    </div>
                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Authcode</label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7 normal">
											<?php echo $user_authcode;?>
											</div>
                                        </div>
                                    </div>
                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Gambar Avatar</label>
                                        <div class="col-lg-1">
											<div class="avatar-default">
                                                <?php
            									$myDir = substr($login,0,1);
            									$img_avatar = $path."/avatar/".$myDir."/".$login.".jpg?hi=".date("is");
            									?>
												<div class="avatar" style="background: url(<?php echo $img_avatar?>) no-repeat;background-size:123px 123px;"></div>
											</div>
                                        </div>
                                    </div>
                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label"></label>
										<div class="col-lg-2">
                                            <div class="text-left bold pt7 normal">
                                            <a href="game-avatar.php">Ganti Avatar</a>
											</div>
                                        </div>
                                    </div>
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Password Lama</label>
                                        <div class="col-lg-2">
                                            <input type="password" name="old" placeholder="Old Password" data-required="true" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Password Baru</label>
                                        <div class="col-lg-2">
                                            <input type="password" name="new1" placeholder="New Password" data-required="true" class="form-control">
                                        </div>
                                    </div>
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Konfirmasi Password</label>
                                        <div class="col-lg-2">
                                            <input type="password" name="new2" placeholder="Confirm Password" data-required="true" class="form-control">
                                        </div>
                                    </div>
									
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">No Rekening Bank</label>
                                        <div class="col-lg-3">
                                            <?php
                                                    $bankno = substr(str_replace('-', '', $bankaccnodis), 0, -4);
                                                    $bankdisplay = bank_format($bankno, $bankname);
                                                ?>
                                                <input type="text" class="form-control" value="<?php echo substr($bankdisplay, 0, -1); ?>" disabled style="width: 270px"> -
                                                <input type="password" class="form-control" placeholder="4 Digit" maxlength="4" onKeypress="if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }"  name='bano' style="width: 115px">
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
                                            <input type="text" name="captcha" placeholder="Validation" data-required="true" class="form-control">
                                        </div>
                                    </div>
								    <div class="line m-t-large"></div>
                                    <div class="space_10"></div>
                                    <div class="form-group-full">
                                        <button type="submit" name="submit" value="SUBMITS" class="btn btn-submit">Ganti Password</button>
										<button type="submit" name="reset_pin" value="SUBMITS" class="btn btn-submit">Reset Pin</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="clear space_30"></div>
                </div>
            </div>

       <?php
	   include("footer.php");
	   ?>