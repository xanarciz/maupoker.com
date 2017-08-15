<?php
include("meta.php");
include("header.php");
include("function/jcd-umum.php");
include_once("config_db2.php");

if ($_POST["reset_pin"]){
	sqlsrv_query($sqlconn,"update u6048user_id set hp='' where userid = '".$login."'");
	
	// log Login (yang baru kalau data sudah stabil log lama dihapus)
	$queryLogLogin = "INSERT INTO j2365join_playerlog (userid,userprefix,action,ip,client_ip,forward_ip,remote_ip,Info,CreatedDate) 
					  VALUES ('$login','" . $agentwlable . "','Reset PIN','" . getUserIP2() ."','" . getUserIP2('HTTP_CLIENT_IP') . "','" . getUserIP2('HTTP_X_FORWARDED_FOR') . "','" . getUserIP2('REMOTE_ADDR') . "', 'Reset PIN From " . $_SERVER['SERVER_NAME'] . "', GETDATE())";
	sqlsrv_query($sqlconn_db2,$queryLogLogin);
	
	$_SESSION["pin"]="";
	exit ("<script>window.location='../index.php'</script>");
	
}
$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userpass, bankname, bankaccno, bankaccname, bankgrup,playerpt,xdeposit from u6048user_id where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
if($_POST["submit"]){
	$uname = $login;
	$old	= hash("sha256",md5($_POST["old"]).'8080');
	$new1	= $_POST["new1"];
	$new2	= $_POST["new2"];
	$capt	= $_POST["captcha"];
	$sql1 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select pass from a83adm_rejectpass where pass='".strtoupper($new1)."'",$params,$options));
	if ($sql1 > 0){
		$error	= 4;
	}
	$oldp;
	$oldp	= $sqlu["userpass"];
	$old2	= $old;
	$pv = pass_validation($uname , $new1);
	
	$rejpas = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select pass from a83adm_rejectpass where pass='".strtoupper($pass)."'",$params,$options));
	if (!checkCaptcha('CAPTCHAString', $capt)){
		$errorReport =  "<div class='error-report'>Validasi anda salah.</div>";
		$err = 1;
	}else if (!$_POST["old"]){
		$errorReport =  "<div class='error-report'>Silakan isi password lama anda.</div>";
	}else if (!$new1){
		$errorReport =  "<div class='error-report'>Silakan isi password baru anda.</div>";
	}else if (!$new2){
		$errorReport =  "<div class='error-report'>Silakan konfirmasi password anda.</div>";
	}else if ($oldp != $old2){
		$errorReport =  "<div class='error-report'>Password salah</div>";
	}else if ($new1 != $new2){
		$errorReport =  "<div class='error-report'>Password baru tidak cocok.</div>";
	}else if($pv !== true){ 
		$errorReport =  "<div class='error-report'>".$pv."</div>"; 
	}else if (strlen($new1) < 5) {
		$errorReport = "<div class='error-report'>Pendaftaran Gagal.<br> Password mininum 5 Digit</div>";
	}else if ($rejpas > 0) { 
		$errorReport = "<div class='error-report'>User Error, tidak dapat menggunakan password ini!</div>";
	}else{
		sqlsrv_query($sqlconn, "update u6048user_id set userpass ='".hash("sha256",md5($new1).'8080')."' where userid='".$login."'");
		sqlsrv_query($sqlconn, "update g846game_id set userpass ='".hash("sha256",md5($new1).'8080')."' where userid='".$login."'");
		
		// Log Login yang Lama (masa peralihan ke log login yang baru)
		sqlsrv_query($sqlconn, "insert into j2365join_history (crttime,crtby,crtto,history) values (GETDATE(),'".$login."','".$login."','Change Password')");
		sqlsrv_query($sqlconn,"insert into g846log_player (userid, username, ket, waktu) values ('".$login."', '-', 'Reset Password', GETDATE())");
		
		// log Login (yang baru kalau data sudah stabil log lama dihapus)
		$queryLogLogin = "INSERT INTO j2365join_playerlog (userid,userprefix,action,ip,client_ip,forward_ip,remote_ip,Info,CreatedDate) 
				 		  VALUES ('$login','" . $agentwlable . "','Change Password','" . getUserIP2() ."','" . getUserIP2('HTTP_CLIENT_IP') . "','" . getUserIP2('HTTP_X_FORWARDED_FOR') . "','" . getUserIP2('REMOTE_ADDR') . "', 'Change Password From " . $_SERVER['SERVER_NAME'] . "', GETDATE())";
		sqlsrv_query($sqlconn_db2,$queryLogLogin);
		?>
		<script>
			alert("Sukses ganti password,Silakan Login kembali.");
		</script>
		<?php
		echo "<script>document.location='../logout.php'</script>";
	}
}
// if($login == "AQUILAD8"){
	// echo $nonWWW;
// }

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