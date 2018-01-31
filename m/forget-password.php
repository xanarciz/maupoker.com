
<?php
include("_meta.php");
include("_header.php");

$forget_password = array("XCCAA" , "XRBAA" , "XNKAA", "XNDAA", "XURAA", "AXHQAA", "AXCGAA","XNIAA","AXNGAA","XJZAA","XJGAA","AXLXAA","AXMVAA","AXNWAA");
if (in_array($agentwlable , $forget_password)){exit("<script>location.href='index.php'</script>");}
?>

        <div class="content">

            <div class="container main no-bottom">

                <div class="wrapper">

                    <div class="container no-bottom">
                    	<h3>Lupa Password</h3>
                    </div>

                    <div class="decoration"></div>

                    <?php
                    $user="onKeypress=\"if ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 65 && event.keyCode <= 90) || (event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 45 || event.keyCode == 46 || event.keyCode == 95) {event.returnValue = true; } else {event.returnValue = false;}\"";
                    $angka="onKeypress=\"if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }\"";

                    $sqlf = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select val from a83adm_config3 where name = 'forget_pass'"),SQLSRV_FETCH_ASSOC);

                    if ($sqlf["val"] == 0){

                    	if(@$_POST["submit"]){
                    		$captcha	= @$_POST["captcha1"];
                    		$nama	= @$_POST["nama1"];
                    		$id		= @$_POST["id1"];
                    		$hp		= @$_POST["hp1"];
                    		$rek	= @$_POST["rek1"];
                    		$comment= @$_POST["comment1"];

                    	if ($nama == ""){
                    		$errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Harap isi UserID</p></div>";
                    	}else if ($hp == ""){
                    		$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Harap isi nomor handphone</p></div>";
                    	}else if ($id == ""){
                    		$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Harap isi email</p></div>";
                    	}else if ($rek == ""){
                    		$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Harap isi nomor rekening</p></div>";
                    	}else if ($comment == "" || $comment == " " ){
                    		$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Harap isi Pesan</p></div>";
                    	}else if ($captcha != $_SESSION['CAPTCHAString']){
                    		$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Validasi anda salah</p></div>";
                    	}else{
                    		$to = "Company";
                    		$subject = "### Memo forget password (web) ###";
                    		$body = "No Rek = ".$rek."<br>"."Email = ".$id."<br>"."Phone = ".$hp."<br>"."Comment = ".$comment;
                    		$sqlx = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select memo from a83adm_config") , SQLSRV_FETCH_ASSOC);
                    		$user = explode(",",$sqlx["memo"]);
                    		for($i=0;$i<count($user)-1;$i++){
                    			$us = $user[$i];
                    			$sql = sqlsrv_query($sqlconn_db2, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$us."','##public(".$nama.")','','".$subject."','".$body."','0',GETDATE())");
                    		}

                    		$sql1 = sqlsrv_query($sqlconn_db2, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$name."','".$to."','','".$subject."','".$body."','2',GETDATE())");
                    		 sqlsrv_query($sqlconn,"insert into g846log_player (userid, username, ket, waktu) values ('".$uname."', '-', 'Reset Password', GETDATE())");
                    		$errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Permohonan lupa password telah di kirim!</p></div>";
                    	}
                    }
                    ?>

                    <div class="res" id="res_reg" align="center">
                        <?php
            				if ($errorReport){
            					echo $errorReport;
            				}
            			?>
                    </div>

                    <form method=post>
                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Login ID</label>
                            </div>
                            <div class="formInput">
                                <input type="text" name="nama1" class="contactField" value="<?php echo @$_POST["nama1"];?>" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nomor Rekening</label>
                            </div>
                            <div class="formInput">
                                <input type="text" name="rek1" class="contactField" value="<?php echo @$_POST["rek1"];?>" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">No. Telp / HP</label>
                            </div>
                            <div class="formInput">
                                <input type="text" name="hp1" class="contactField" value="<?php echo @$_POST["hp1"];?>" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Email</label>
                            </div>
                            <div class="formInput">
                                <input type="text" name="id1" class="contactField" value="<?php echo @$_POST["id1"];?>" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Pesan</label>
                            </div>
                            <div class="formInput">
                                <textarea name="comment1"><?php echo @$_POST["comment1"];?></textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Validasi</label>
                            </div>
                            <div class="formInput">
                                <input class="contactField" type="text" name="captcha1" maxlength="5" />
                                <div style="height:10px;"></div>
                                <img src='../../captcha/captcha.php?.png' alt='CAPTCHA' width='120' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">
                            </div>
                        </div>

                        <!--<input id="mobile" type="hidden" name="mobile" value="mobile"  />-->

                        <div class="formSubmitButtonErrorsWrap">
                            <input type="submit" name="submit" class="buttonWrap button button-reds contactSubmitButton" value="KIRIM" />
                        </div>
                    </form>

                    <?php
                    }else{
                    	if(@$_POST["submit"]){

                    		$uname = $_POST["UName"];
                    		$email = $_POST["Email"];
                    		$bname = $_POST["BName"];
                    		$baname = $_POST["BAName"];
                    		$bano = $_POST["BAno"];
                    		$bano1 = $_POST["BAno1"];
                    		$bano2 = $_POST["BAno2"];
                    		$captcha	= $_POST["captcha1"];
                    		$comment= $_POST["comment1"];
                    		$hp		= $_POST["hp1"];
                    		$uname = strtoupper($uname);

                    		$errb = 0;

                    		if (strpos($hp,"<") or strpos($hp,">")){
                    			$errb = 1;
                    		}
                    		if (strpos($baname,"<") or strpos($baname,">")){
                    			$errb = 2;
                    		}

                    		$bano4 = $bano;

                    		$banox = $bano4."-".$bano1."-".$bano2;

                    		$sqlb = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select userid, status, email, bankname, bankaccname, bankaccno,telp from u6048user_id where loginid = '".$uname."' and subwebid='".$subwebid."'"),SQLSRV_FETCH_ASSOC);


                    		if(strtoupper($hp) != strtoupper($sqlb["telp"])){
                    			$errb = 3;
                    		}else if (strtoupper($bname) != strtoupper($sqlb["bankname"])){
                    			$errb = 4;
                    		}else if (strtoupper($baname) != strtoupper($sqlb["bankaccname"])){
                    			$errb = 5;
                    		}else if (str_replace("-","",$banox) != str_replace("-","",$sqlb["bankaccno"])){
                    			$errb = 6;

                    		}

                    		if ($sqlf["val"] == 1) {
								//include_once("../config_db2.php");
                    			$loginlog = sqlsrv_num_rows(sqlsrv_query($sqlconn_db2,"select userid from log_loginlog where userid = '".$sqlb["userid"]."' and crttime >  dateadd(day, -1, GETDATE())",$params,$options));
                    		}else {
                    			$loginlog = 0;
                    		}
                    		if ($sqlb["bankaccno"] == ""){

                    			$errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Data yang anda isi salah!</p></div>";
                    		}
                    		else if ($sqlb["status"] != "0"){
                    			$errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Username anda masih dalam proses!</p></div>";
                    		}
                    		else if ($captcha != $_SESSION['CAPTCHAString']){
                    			$errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Captcha harap diisi.</p></div>";
                    		}
                    		else if($errb > 0)echo "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Data yang anda isi salah!</p></div>";
                    		else if ($loginlog > 0){

                    			sqlsrv_query($sqlconn,"delete from u6048user_active where userid = '".$sqlb["userid"]."'");
                    			$errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Anda hanya bisa menggunakan lupa password apabila anda sudah tidak login lebih dari 24 jam!</p></div>";
                    		}
                    		else {


                    			if ($sqlf["val"] == 1) {

                    				$alpha = Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","W","X","Y","Z");
                    				$j = 0;
                    				for ($i = 0; $i < 4; $i++) {

                    					$n = rand(0, count($alpha)-1);
                    					$newpass[$j] = $alpha[$n];

                    					$j++;
                    				}
                    				$num = Array("0","1","2","3","4","5","6","7","8","9");
                    				for ($i = 0; $i < 2; $i++) {
                    					$n = rand(0, count($num)-1);
                    					$newpass[$j] = $num[$n];
                    					$j++;
                    				}

                    				shuffle($newpass);

                    				$passn = $newpass[0].$newpass[1].$newpass[2].$newpass[3].$newpass[4].$newpass[5];

                    				sqlsrv_query($sqlconn,"update u6048user_id set status='0', userpass='".hash("sha256",md5($passn).'8080')."' where userid = '".$sqlb["userid"]."'");
									sqlsrv_query($sqlconn,"update g846game_id set status='0', userpass='".hash("sha256",md5($passn).'8080')."' where userid = '".$sqlb["userid"]."'");
									// Log Login yang Lama (masa peralihan ke log login yang baru)
									sqlsrv_query($sqlconn,"insert into g846log_player (userid, username, ket, waktu) values ('".$sqlb["userid"]."', '-', 'Reset Password', GETDATE())");
									sqlsrv_query($sqlconn,"insert into a83adm_forgetpass (date1,userid,stat) values (GETDATE(),'".$sqlb["userid"]."','0')");
									// Log Login (yang baru kalau data sudah stabil log lama dihapus) / Dewadev insert ke 56 Live ke 142
									$queryLogLogin = "INSERT INTO j2365join_playerlog (userid,userprefix,action,ip,client_ip,forward_ip,remote_ip,Info,CreatedDate) VALUES ('" . $sqlb["userid"] . "','" . $agentwlable . "','Forget Password','" . getUserIP2() . "','" . getUserIP2('HTTP_CLIENT_IP') . "','" . getUserIP2('HTTP_X_FORWARDED_FOR') . "','" . getUserIP2('REMOTE_ADDR') . "', 'Request Reset Password From " . $_SERVER['SERVER_NAME'] . " (Mobile Version)', GETDATE())";
									sqlsrv_query($sqlconn_db2,$queryLogLogin);
									$errorReport= "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Password telah diubah menjadi <span style='font-weight:bold;'>".$passn."</span> <br>Silakan Login kembali dengan Password tersebut(Perhatikan Huruf Besar)</p></div>";
                    			}else {
                    				$to = "Company";
                    				$subject = "### Memo halaman depan ###";
                    				$body = "Bank = ".$bname."<br>"."Bank Name = ".$baname."<br>"."No Rek = ".$banox."<br>"."Email = ".$email."<br>"."Comment = ".$comment;
                    				$sqlx = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select memo from a83adm_config"));
                    				$user = explode(",",$sqlx["memo"]);
                    				for($i=0;$i<count($user)-1;$i++){
                    					$us = $user[$i];
                    					$sql = sqlsrv_query($sqlconn_db2,"insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$us."','##public(".$sqlb["userid"].")','','".$subject."','".$body."','0',GETDATE())");
                    				}

                    				$sql1 = sqlsrv_query($sqlconn_db2,"insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$sqlb["userid"]."','".$to."','','".$subject."','".$body."','2',GETDATE())");

                    				$errorReport = "<div class='static-notification-green tap-dismiss-notification'><p class='center-text uppercase'>Permintaan anda sudah di kirim!</p></div>";

                    			}
                    		}
                    	}
                    ?>

                    <div class="res" id="res_reg" align="center">
                        <?php
            				if ($errorReport){
            					echo $errorReport;
            				}
            			?>
                    </div>

                    <form method=post>
                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Login ID</label>
                            </div>
                            <div class="formInput">
                                <input type="text" name="UName" class="contactField" value='<?php echo $_POST["nama1"] ?>' <?php echo $user?> />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nama Bank</label>
                            </div>
                            <div class="formInput">
                                <select name="BName" class="contactField contactOption">
                                    <?php
        							 $banksql = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select val from a83adm_config3 where name='registrasi_bank'"),SQLSRV_FETCH_NUMERIC);
        							 $_bank = explode(",",$banksql[0]);
          							 for ($__a=0; $__a<count($_bank); $__a++){
          								$select = "";
          								if($_POST["BName"] == $_bank[$__a]) $select = "selected";
          								if (str_replace(" ","", $_bank[$__a]))echo "<option value='".strtoupper($_bank[$__a])."' ".$select.">".strtoupper($_bank[$__a])."</option>";
          							 }
        							 ?>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nama Rekening</label>
                            </div>
                            <div class="formInput">
                                <input type="text" name="BAName" class="contactField" value='<?php echo $_POST["BAName"] ?>' />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nomor Rekening</label>
                            </div>
                            <div class="formInput">
                                <div class="bankField"><input type="text" name="BAno" class="contactField" maxlength="3" value='<?php echo $_POST["BAno"] ?>' <?php echo $angka?> /></div>
                                <div class="bankField"><input type="text" name="BAno1" class="contactField" maxlength="3" value='<?php echo $_POST["BAno1"] ?>' <?php echo $angka?> /></div>
                                <div class="bankField2"><input type="text" name="BAno2" class="contactField" maxlength="10" value='<?php echo $_POST["BAno2"];?>' <?php echo $angka?> /></div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">No. Telp / HP</label>
                            </div>
                            <div class="formInput">
                                <input type="text" name="hp1" class="contactField" value="<?php echo $_POST["hp1"];?>" <?php echo $angka?> />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Validasi</label>
                            </div>
                            <div class="formInput">
                                <input class="contactField" type="text" name="captcha1" maxlength="5" />
                                <div style="height:10px;"></div>
                                <img src='../../captcha/captcha.php?.png' alt='CAPTCHA' width='120' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">
                            </div>
                        </div>

                        <!--<input id="mobile" type="hidden" name="mobile" value="mobile"  />-->

                        <div class="formSubmitButtonErrorsWrap">
                            <input type="submit" name="submit" class="buttonWrap button button-reds contactSubmitButton" value="KIRIM" />
                        </div>
                    </form>

                    <?php
                        }
                    ?>
                </div>

            </div>
        </div>

        <?php include ("_footer.php");?>