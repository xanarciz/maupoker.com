<?php
session_start();
$page='daftar';
include("_meta.php");
include("_header.php");
include("../function/jcd-umum.php");

if ($login){
    exit("<script> window.location = 'login.php'</script>");
}
$cref=$agentwlable;
$noRek	= "1";
if($infoweb['pt_status'] == 0) die("Cannot Open this page.");

$curr = $_POST["Curr"];
$ref = strtoupper($_COOKIE["ref"]);
if (!$ref)$ref="";
if($_POST["submit"]){
    if($infoweb['open_reg'] == "0"){echo "<div class='error-report'>Registration Tempolary Closed</div>";
        die();
    }
	$uname = str_replace("''","*",$_POST["UName"]);
	$unameid = str_replace("''","*",$_POST["UNameid"]);
	$pass = $_POST["Pass"];
	$cpass = $_POST["CPass"];
	$email = $_POST["Email"];
	$phone = $_POST["Phone"];
	$curr = $_POST["Curr"];

    if($_POST['captcha1'] == ''){
        $errorReport = ("<div class='error-report'><strong>Pendaftaran gagal!</strong> Captcha harus diisi</div>");
    }else if(! checkCaptcha('CAPTCHAString', $_POST['captcha1'])){
        $errorReport = ("<div class='error-report'><strong>Pendaftaran gagal!</strong> Captcha tidak sama</div>");
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
                "ref_text"  => strtoupper($ref),
                "device"	=> $device
            )
        );

        $response = sendAPI($url_Api."/register",$reqAPIRegister,'JSON','02e97eddc9524a1e');
        if($response->status == 200){
            $successRegister = "<centeR>
                            <a href='http://".$DomainName."'>$DomainName</a> - Pendaftaran Sukses<br>Username = <b>$uname</b><br>
                            Anda bisa melakukan deposit di website <a href='http://".$DomainName."'>$DomainName</a>.<br>
                            Selamat bermain dan Terima Kasih  (#1021)<br><br>
                            <font style='font-weight:bold;'>Anda akan terlogin dalam <label id='counter'>5</label>s</font>
                       </center>";
        }else{
            $errorReport =	("<div class='error-report'><strong>Pendaftaran gagal!</strong> " . $response->msg . "</div>");
        }
    }
}
?>
<style>
    #user_name, #user_nameid {text-transform: uppercase}
</style>
<div class="content-2">

	<div class="row">		
		<div class="lpadding-15 tpadding-5">
	        <label class="ntf fs-13 tmargin-10">FORM PENDAFTARAN</label>
	    </div>
	    <hr class="margin-0 tmargin-2 bmargin-3">

		<?php
			if ($errorReport){
				echo "<div class='padding-15' align='center' id='the_alert' style='background-color:#c0392b; color: #fff;'>".$errorReport."</div>";
			}else{
				echo "<div class='padding-15' align='center' id='the_alert' style='display: none; color: #fff;background-color:#c0392b;'></div>";
			}
		?>
	</div>

	<form method="post" id="form_reg">

		<?php if (!$successRegister){ ?>

		<div class="row padding-15 tpadding-3 bpadding-2" id="freg">
			<div class="col-lg-5 tmargin-5">
				<label class="black">Username</label>
			</div>
			<div class="col-lg-7">				
				<input class="form-control bg-light-gray" onBlur="fast_checking('user_name', 'ceklis1', '')" id="user_name" type="text" name="UName" maxlength="10" value="<?php echo $uname; ?>"   />
			</div>
		</div>

		<div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				<label class="black">Nickname</label>
			</div>
			<div class="col-lg-7">
				<input class="form-control bg-light-gray" onBlur="fast_checking('user_nameid', 'ceklis2', '')" id="user_nameid" type="text" name="UNameid" maxlength="10" value="<?php echo strtoupper($unameid); ?>" />
			</div>				
		</div>

		<div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				<label class="black">Password</label>
			</div>
			<div class="col-lg-7">
				<input class="form-control bg-light-gray" onBlur="fast_checking('the_pass', 'ceklis3', '')" id="the_pass" type="password" name="Pass" value="<?php echo $_POST["Pass"]; ?>" placeholder="Contoh : Ex@mpl3" />
			</div>
		</div>

		<div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				<label class="black">Ulangi Password</label>
			</div>
			<div class="col-lg-7">
				<input class="form-control bg-light-gray" type="password" onBlur="fast_checking('the_cpass', 'ceklis4', 'the_pass')" id="the_cpass" type="password" name="CPass" value="<?php echo $_POST["CPass"]; ?>" placeholder="Pastikan Password Sama"/>
			</div>
		</div>

		<div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				<label class="black">Alamat Email</label>
			</div>
			<div class="col-lg-7">				
				<input class="form-control bg-light-gray" onBlur="fast_checking('the_email', 'ceklis6', '')" id="the_email" type="email" name="Email" value="<?php echo $_POST["Email"]; ?>" />
			</div>
		</div>

		 <div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				<label class="black">No. Telp / HP</label>
			</div>
			<div class="col-lg-7">				
				<input class="form-control bg-light-gray" onBlur="fast_checking('the_phone', 'ceklis7', '')" id="the_phone" type="text" maxlength="15" name="Phone" value="<?php echo $_POST["Phone"]; ?>" />
			</div>
		</div>

		<div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				<label class="black">Validasi</label>
			</div>
			<div class="col-lg-7">
				<input class="form-control bg-light-gray" onBlur="fast_checking('the_cap', 'ceklis11', '')" id="the_cap" type="text" name="captcha1" maxlength="5" />				
			</div>
		</div>

		<div class="row padding-15 tpadding-3 bpadding-2">
			<div class="col-lg-5 tmargin-5">
				
			</div>
			<div class="col-lg-7">
				<img src='../captcha/captcha.php?.png' alt='CAPTCHA' width='120' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">				
			</div>
		</div>

		<div class="row padding-15 bmargin-50">
			<input class="btn btn-green fs-normal" value="DAFTAR" type="submit" name="submit" />
		</div>

		<?php
			}else{
				echo "<div class='row normal-green'>
				<label class='normal-green fs-13 padding-15 bpadding-0 tpadding-8'>PENDAFTARAN SUKSES</label>
				<p>".$successRegister."</p>
				</div>";
			}
		?> 

	</form>
</div>

<style type="text/css">
	.place-red::-webkit-input-placeholder {
	   color: #dc5b6b;
	   font-style: italic;
	   font-size: 10px;
	}

	.place-red:-moz-placeholder { /* Firefox 18- */
	   color: #dc5b6b;  
	   font-style: italic;
	   font-size: 10px;
	}

	.place-red::-moz-placeholder {  /* Firefox 19+ */
	   color: #dc5b6b;  
	   font-style: italic;
	   font-size: 10px;
	}

	.place-red:-ms-input-placeholder {  
	   color: #dc5b6b;  
	   font-style: italic;
	   font-size: 10px;
	}
</style>

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