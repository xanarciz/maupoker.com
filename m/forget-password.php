
<?php
include("_meta.php");
include("_header.php");

$forget_password = array("XCCAA" , "XRBAA" , "XNKAA", "XNDAA", "XURAA", "AXHQAA", "AXCGAA","XNIAA","AXNGAA","XJZAA","XJGAA","AXLXAA","AXMVAA","AXNWAA","XACAA");
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

			if(@$_POST["submit"]){

				$uname	= strtoupper($_POST["UName"]);
				$bname	= $_POST["BName"];
				$baname	= $_POST["BAName"];
				$bano	= $_POST["BAno"] . $_POST["BAno1"] . $_POST["BAno2"];
				$hp		= $_POST["hp1"];
				$captcha= $_POST["captcha1"];

				$iplist = getUserIP2().','.getUserIP2('HTTP_CLIENT_IP').','.getUserIP2('HTTP_X_FORWARDED_FOR').','.getUserIP2('REMOTE_ADDR');

				if($captcha == ''){
					$errorReport = ("<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Captcha harap diisi.</p></div>");
				}else if(! checkCaptcha('CAPTCHAString',$captcha)){
					$errorReport = ("<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Captcha tidak sesuai.</p></div>");
				}else{
					$reqAPIAccount =
						array(
							"auth"      => $authapi,
							"webid" 	=> $subwebid,
							"agent" 	=> $agentwlable,
							"domain" 	=> $nonWWW,
							"ip"		=> $iplist,
							"device"	=> $device,
							"type"		=> 3,
							"loginid"	=> $uname,
							"bankname"	=> $bname,
							"baname"	=> $baname,
							"bano"		=> $bano,
							"phone"		=> $hp,
						);
					
					$response = sendAPI($url_Api."/account", $reqAPIAccount, 'JSON', '02e97eddc9524a1e');
					if($response->status == 200){
						$errorReport = "<div class='static-notification-green tap-dismiss-notification'>
							   <p class='center-text uppercase'>Password telah diubah menjadi <B>".$response->newPassword."</B><br>Silakan Login kembali dengan Password tersebut(Perhatikan Huruf Besar)
							   </p>
							 </div>";
					}else{
						$errorReport =	"<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>$response->msg</p></div>";
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
							// bank list
							foreach($infoweb['bankList'] as $bankdata){
								$select = "";
								if($_POST["BName"] == $bankdata['bank']) $select = "selected";
								$options.= "<option value='".$bankdata['bank']."' ".$select.">".$bankdata['bank']."</option>";
							}
							echo $options;
							// End bank list
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

		</div>

	</div>
</div>

<?php include ("_footer.php");?>