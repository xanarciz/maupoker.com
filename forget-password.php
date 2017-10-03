<?php
session_start();
$login = $_SESSION['login'];
if (!$login) $freePage = 1;
else exit("<script>location.href='index.php'</script>");
include("meta.php");
include("header.php");
include("function/jcd-umum.php");


if (!$register)exit("<script>location.href='index.php'</script>");

$cref=$agentwlable;
$noRek	= "1";
if($infoweb['pt_status'] == 0) die("Cannot Open this page.");


if(@$_POST["submit"]){
	
	$uname	= strtoupper($_POST["UName"]);
	$bname	= $_POST["BName"];
	$baname	= $_POST["BAName"];
	$bano	= $_POST["BAno"];
	$hp		= $_POST["hp1"];
	$captcha= $_POST["captcha1"];
	
	$iplist = getUserIP2().','.getUserIP2('HTTP_CLIENT_IP').','.getUserIP2('HTTP_X_FORWARDED_FOR').','.getUserIP2('REMOTE_ADDR');
	
	if($captcha == ''){
        $errorReport = ("<center><b><font color=red style='font-size:14px'>Captcha harap diisi.</font></b></center>");
    }else if(! checkCaptcha('CAPTCHAString',$captcha)){
        $errorReport = ("<center><b><font color=red style='font-size:14px'>Captcha tidak sesuai.</font></b></center>");
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

        $response = sendAPI($url_Api."/account",$reqAPIAccount,'JSON','02e97eddc9524a1e');
        if($response->status == 200){
            $successRegister = "<div class='error-report'>Password telah diubah menjadi <B>".$response->newPassword."</B><br>Silakan Login kembali dengan Password tersebut(Perhatikan Huruf Besar)</div>";
        }else{
            $errorReport =	("<div class='error-report'>$response->msg</div>");
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
					<h1>Forget Password</h1>
				</div>

				<div class="body-wrap">
					<div class="res" id="res_reg" align="center">
					
					</div>
				<script language="JavaScript" type="text/javascript">
					jQuery(document).ready(function(){
					setform("form_memo", "res_memo");
					})
				</script>

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
								<input type="text" name="UName" id="user_name" placeholder="Username Account Anda" maxlength=10 value="<?php echo $uname; ?>" data-required="true" class="form-control">
								
							</div>
						</div>

						<div class="form-group-full">
							<label class="col-lg-1 control-label">Nama Bank</label>
							<div class="col-lg-2">
							<?php
							
							?>
								<select name='BName' class="form-control">
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

						<div class="form-group-full">
							<label class="col-lg-1 control-label">Nama Rekening</label>
							<div class="col-lg-2">
								<input type="text" name="BAName" placeholder="Nama Rekening Anda" class="form-control">
							</div>
						</div>

						<div class="form-group-full">
							<label class="col-lg-1 control-label">Nomor Rekening</label>
							<div class="col-lg-2">
								<input type="text" name='BAno' placeholder="Nomor Rekening Anda" class="form-control"/>
								
							</div>
						</div>

						<div class="form-group-full">
							<label class="col-lg-1 control-label">Nomor HP</label>
							<div class="col-lg-2">
								<input type="text" name="hp1" placeholder="Nomor HP" value="<?php echo $email; ?>" class="form-control" data-required="true" data-type="email">
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
							<button type="submit" name="submit" value="SUBMITS" class="btn btn-submit">Submit</button>
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