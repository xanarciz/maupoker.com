<?php
$freePage=true;
include("meta.php");
include("header.php");

function currx($val) {
   if (!strpos($val,".")) return number_format($val, 0,'.', ',');
   else return number_format($val, 1,'.', ',');
}

function curlservice($rsp){
	$url 	= "http://idnpgservice.com/api.php";
	$ch 	= curl_init();

	curl_setopt($ch, CURLOPT_URL, $url);
	$response = $rsp;

	curl_setopt($ch, CURLOPT_POSTFIELDS,"" . $response);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
	$data = curl_exec($ch);
	curl_close($ch);

	//convert the XML result into array
	$array_data = json_decode(json_encode(simplexml_load_string($data)), true);
	/*print_r('<pre>');
	print_r($array_data);
	print_r('</pre>');*/

	return $array_data;
}

/* Kode Booking */
$rspKB = "<request>
				<id>1</id>
				<userid>".$login."</userid>
			</request>";
$kdb = curlservice($rspKB);
$KodeBooking = $kdb['ordernumber'];
/* */

if (!$_SESSION["login"]){
	header("location:index.php");
	echo "<script>window.location = 'index.php'</script>";
	exit();
}

$reqAPILastOrder = array(
    "auth"      => $authapi,
    "agent"     => $agentwlable,
    "userid"    => $login,
	"curr"      => $curr,
	"bankgroup" => $bankgroup,
	"minutes"   => 1,
    "act"   	=> 1
);
$transaction = sendAPI($url_Api."/transaction",$reqAPILastOrder,'JSON','02e97eddc9524a1e');

if ($transaction->msg != 'OK'){
    $errorReport = "<div class='error-report'>".$transaction->msg."</div>";
    $err = 1;
}

if($status_bank == 0) {
    $_SESSION['urlPrev'] = 'deposit.php';
    echo "<script>window.location = 'bank-setting.php'</script>";
    die();
}

$defaultOpen = 0;
$maxdepo = $transaction->minmaxDepo->max_depo;

$uname = str_replace("''","*",$_POST["UName"]);
$unameid = str_replace("''","*",$_POST["UNameid"]);
$pass	= $_POST["Pass"];
$cpass	= $_POST["CPass"];
$email	= $_POST["Email"];
$phone	= $_POST["Phone"];
$curr	= $_POST["Curr"];
	
if ($_POST["submit"] && !$err) {
	$defaultOpen = 1;
	$name       = $login;
	$amount		= $_POST["amount"];
	$accname1	= $bankaccname;
	$rek1		= $bankaccno;
	$bname1		= $bankname;
	$capt		= $_POST["captcha"];
	$time       = date("d/m h:i");
	$remark     = "Deposit";
	$noresi 	= $_POST["noresi"];

	$bname2		= $_POST['data_bank'];
	$rek2 		= str_replace('-','', $_POST['hBNo']);
	$accname2	= $_POST['hBAcc'];

	$err = 0;
			
	$reqAPIRegister = array(
		"auth"       => $authapi,
		"webid"      => $subwebid,
		"act"		 => 1,
		"agent"		 => $agentwlable,
		"userid"     => strtoupper($name),
		"amount"     => $amount,
        "bankgroup"  => $bankgroup,
		"bankaccname"=> $bankaccname,
		"bankaccno"  => $bankaccno,
		"bankname" 	 => $bankname,
		"banktuj" 	 => $bname2,
		"rektuj" 	 => $rek2,
		"firstdepo"  => $xdeposit,
		"noresi" 	 => $noresi,
        "minutes"    => 1,
		"device"	 => $device
	);

	$response = sendAPI($url_Api."/cashier",$reqAPIRegister,'JSON','02e97eddc9524a1e');
	if($response->status == 200){
		$success_deposit = "<div class='deposit-success-report'><strong style='margin:auto;'>Deposit $amountx sukses.</strong><br><br>
							<table style=font-family:tahoma;font-size:14px; align=center>
								<tr><td colspan=3 align=center>Rekening Tujuan</td></tr>
								<tr>
									<td align=left style=font-family:tahoma;font-size:12px;>Bank</td><td>:</td><td align=left><span>".strtoupper($bname2)."</span></td>
								</tr>
								<tr>
									<td align=left style=font-family:tahoma;font-size:12px;>Nomor Rekening</td><td>:</td><td align=left><span>".strtoupper($rek2)."</span></td>
								</tr>
								<tr>
									<td align=left style=font-family:tahoma;font-size:12px;>Nama Rekening</td><td>:</td><td align=left><span>".strtoupper($accname2)."</span></td>
								</tr>
							</table>
							<span>Deposit anda paling maximal akan di proses dalam 24 jam</span></div>
							<br>";
        echo "<script src=\"https://d3qycynbsy5rsn.cloudfront.net/OptiRealApi-1.1.0.js\" type=\"text/javascript\"></script>";
        echo "<script>
				$(document).ready(function(){
					OptiRealApi.reportEvent(7, null, '" . $login . "', \"7ae87a05e42bd455d041884a1f62da6a30bc2ff5a20dc47e8b12620cf82066bc\");
				});
			</script>";
	}else{
		$errorReport =	("<strong>Deposit gagal!</strong> " . $response->msg);
	}
	echo"<BR>";
}

if ($_POST["submit-uc"] && !$err) {
	$defaultOpen = 2;
	$name       = $login;
	$amount		= $_POST["amountuc"];
	$accname1	= $bankaccname;
	$rek1		= $bankaccno;
	$bname1		= $bankname;
	$capt		= $_POST["captcha"];
	$time       = date("d/m h:i");
	$order_number = $KodeBooking;
	$noresi     = "UangCepat <br> Order Number : ".$order_number;

	$bname2		= "uangcepat";
	$rek2 		= "00";
	$accname2	= "-";

	$err = 0;
			
	$reqAPIRegister = array(
		"auth"       => $authapi,
		"webid"      => $subwebid,
		"act"		 => 1,
		"agent"		 => $agentwlable,
		"userid"     => strtoupper($name),
		"amount"     => $amount,
        "bankgroup"  => $bankgroup,
		"bankaccname"=> $bankaccname,
		"bankaccno"  => $bankaccno,
		"bankname" 	 => $bankname,
		"banktuj" 	 => $bname2,
		"rektuj" 	 => $rek2,
		"firstdepo"  => $xdeposit,
		"noresi" 	 => $noresi,
        "minutes"    => 1,
		"device"	 => $device
	);

	$response = sendAPI($url_Api."/cashier",$reqAPIRegister,'JSON','02e97eddc9524a1e');
	if($response->status == 200){
		/** Verify uangcepat **/
		$merchant 	= 'DEWA';
		$merchanttrxref	= $order_number;
		$merchantkey	= 'C92909FA3A5A4FCAA1E5F8AAD28ADD06';
		$form_url 	= "https://api.ipei88.com/home/process"; // live
		$fronturl 	= "http://".$_SERVER['SERVER_NAME']."/deposit.php";
		$failedurl 	= "http://".$_SERVER['SERVER_NAME']."/deposit.php";
		$backurl 	= "http://idnpgservice.com/ucservices/";
		$amountz 	= number_format($amount, 2, '.', '');
		$currency 	= 'IDR';
		$banks 		= $_POST["data-bank"];
		$datetime 	= date("Y-m-d H:i:sA");
		$datetime2 	= date("YmdHis");
		$encrypt 	= $merchant.$name.$amountz.$currency.$datetime2.$merchantkey;
		$key 		= md5($encrypt);
		$t 			= explode(" ",microtime());
		$newTime 	= date("Y-m-d H:i:s",$t[1]).substr((string)$t[0],1,4);
		$provider 	= 'UangCepat';
		$data1 		= 'customer: '.$name.' reference: '.$merchanttrxref.' - '.$merchant.' - '.$banks.' - '.$amountz.' - '.$currency.' - '.$datetime2.' - '.$securcode.' - '.$clientip;
		$err		= 3;
			/* Log Bank */
			$rspLog = "<request>
						<id>2</id>
						<provider>".$login."</provider>
						<data>".$data1."</data>
					</request>";
			curlservice($rspLog);
			/* */
		/** End Verify uangcepat **/

        echo "<script src=\"https://d3qycynbsy5rsn.cloudfront.net/OptiRealApi-1.1.0.js\" type=\"text/javascript\"></script>";
        echo "<script>
				$(document).ready(function(){
					OptiRealApi.reportEvent(7, null, '" . $login . "', \"7ae87a05e42bd455d041884a1f62da6a30bc2ff5a20dc47e8b12620cf82066bc\");
				});
			</script>";
	}else{
		$errorReport =	("<strong>Deposit gagal!</strong> " . $response->msg);
	}
	echo"<BR>";
}

/* Cancel Order */
$rspCheckOrder = "<request>
				<id>3</id>
				<userid>".$login."</userid>
				<banktuj>uangcepat</banktuj>
				<order></order>
			</request>";
$checkord = curlservice($rspCheckOrder);
$CheckOrder = $checkord["status"];

if($CheckOrder == 2 && $err != 3){
	$defaultOpen = 2;
	$err = 4;
	if($_POST["order"]){
		$rspCancelOrder = "<request>
				<id>3</id>
				<userid>".$login."</userid>
				<banktuj>uangcepat</banktuj>
				<order>2</order>
			</request>";
		$cnclord = curlservice($rspCancelOrder);
		if($cnclord["status"] == "3"){
			echo "<script>window.location='index.php'</script>";
		}
	}
}

if($CheckOrder == 4){
	$errorReport = "<div class='error-report'>Your Account Has Been Blocked to Deposit With UangCepat. Please Contact Our Customer Service.</div>";
	$err = 1;
}
/* */

if(isset($_POST['subform'])){
	$defaultOpen = 3;
}
?>

<script language="JavaScript" type="text/javascript">

	function clickBank(a){

		var fom =  document.fdeposit;       /*nama form */
		var s = fom.data_bank;

		// var tmp = s.selectedIndex;
		var tmp = a.value;
		var hb = $("#hBinf"+tmp);
		var hbx = eval("fom.hBNo");
		var hcx =  eval("fom.hBAcc");
		
		var tb = document.getElementById("nAccNo");
		var tc = document.getElementById("nBank");
		tb.innerHTML = hb.val().split('#')[1];
		tc.innerHTML = hb.val().split('#')[0];
        hbx.value = hb.val().split('#')[1];
        hcx.value = hb.val().split('#')[0];
		var bnkl = hb.val().split('#')[2];


		
		$('.btn-bank').attr("class", "btn-bank " + tmp.toLowerCase());
		$('.btn-bank img').attr("src", "m/img/banks/" + tmp.toLowerCase() + " - blue.png");

		if(tmp != '<?php echo $bankname ?>') $('.newterm').show();
		else $('.newterm').hide();
		if(tmp == "BRI" || tmp == "CIMB"){
			$('.nores').show();
		}else{
			$('.nores').hide();
		}
	}

	function openCity(evt, target_) {
		var i, tabcontent, tablinks;
		tabcontent = document.getElementsByClassName("tabcontent");
		for (i = 0; i < tabcontent.length; i++) {
			tabcontent[i].style.display = "none";
		}
		tablinks = document.getElementsByClassName("tablinks");
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className.replace(" active", "");
		}
		document.getElementById(target_).style.display = "block";
		evt.currentTarget.className += " active";
	}

	// Get the element with id="defaultOpen" and click on it
	$(document).ready(function(){
		document.getElementById("defaultOpen").click();
		var bnk = $("#data_bank" ).val().toLowerCase();
		if(bnk == "BRI" || bnk == "CIMB"){
			$('.nores').show();
		}else{
			$('.nores').hide();
		}
		$("."+bnk).css('display', 'block');
	});

</script>

<style>
    ul.tab {
        list-style-type: none;
        margin: 0;
        padding: 0;
        overflow: hidden;
        display: block;
    }

    /* Float the list items side by side */
    ul.tab li {
        float: left;
        background: #848484;
        margin: 3px;
        border-top-right-radius: 5px;
        border-top-left-radius: 5px;
    }

    /* Style the links inside the list items */
    ul.tab li a {
        display: inline-block;
        color: white;
        text-align: center;
        padding: 7px 8px;
        text-decoration: none;
        transition: 0.3s;
        font-size: 12px;
        border-top-right-radius: 5px;
        border-top-left-radius: 5px;
    }

    /* Change background color of links on hover */
    ul.tab li a:hover {
        background-color: #ddd;
        border-top-right-radius: 5px;
        border-top-left-radius: 5px;
    }

    /* Create an active/current tablink class */
    ul.tab li a:focus, .active {
        background-color: #f4c924;
        border-top-right-radius: 5px;
        border-top-left-radius: 5px;
    }

    /* Style the tab content */
    .tabcontent {
        display: none;
    }
    
    .control-label-header{
        font-family: Arial;
        font-size: 14px;
        color: #dfbf61;
    }
    
    .control-label{
        font-family: Arial;
        color: #ddd;
    }
    
    .alert_caution{     
        background: #fff042;
        color: #7f540f;
        font-style: italic;
        font-size: 14px;
        font-family: Arial;
        border-radius: 5px;
        padding: 5px;
        width: 100%;
        font-weight: bold;
    }
    
    .btn-bank{
        background: linear-gradient(to bottom,  rgba(244,243,202,1) 0%,rgba(243,211,34,1) 100%);
        padding: 10px;
        border-radius: 5px;
        color: black;
        display: none;
        width: 210px;
        margin-bottom: 10px;
        margin-left: 18px;
    }
	#table td{
		color:#000;
	}
</style>


<div id="content">
    <div class="container">
        <div class="clear space_30"></div>

        <div class="wrap">
            <div class="full">
			<?php
			if ($register == 4){
			?>
				<script>
					document.write("<iframe src="+j_deposit+" width=800 height=700></iframe>");
				</script>
			<?php
			}else{
			?>
                <div class="head-wrap">
                    <h1>Deposit</h1>
                </div>

                <div class="body-wrap">
					<ul class="tab">
						<li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'cash')" <?PHP if($defaultOpen<=1){ echo 'id="defaultOpen"'; } ?> >Cash Deposit</a></li>
						<?php
							if($agentwlable == "XKPAA"){
								?>
								<li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'uangcepat')" <?PHP if($defaultOpen==2){ echo 'id="defaultOpen"'; } ?> >Uang Cepat</a></li>
								<?php
							}
						?>
						<li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'history')">History Deposit</a></li>
					</ul>
					<div style="clear: both;"></div>
					
					<div id="cash" class="tabcontent">
						<br>
						<?php 
						if ($errorReport){
							echo '<div class="alert alert-danger">'.$errorReport.'</div>';
						}else if ($success_deposit){
							echo '<div class="alert alert-success">'.$success_deposit.'</div>';
						}
						?>

						<form class="form-horizontal" role="form" method="POST" name="fdeposit">
							<label class="col-lg-1 control-label-header">Pengirim</label>

							<div class="form-group-full">
								<label class="col-lg-1 control-label">Data Bank Anda</label>
								<div class="col-lg-2">
									<div class="text-left bold pt7 normal"> : &nbsp;&nbsp;
										<?php echo $bankname." / ".strtoupper($bankaccname)." / ".$bankaccnodis;?>
										<input type="hidden" name="bank" value="<?php echo $bankname;?>">
										<input type="hidden" name="bank" value="<?php echo $bankname;?>">
									</div>
								</div>
							</div>

							<div class="form-group-full" align="left">
								<label class="col-lg-1 control-label">Jumlah Deposit</label>
								<div class="col-lg-2"> : &nbsp;
									<input type="text" name="ui_amount" id="ui_amount" placeholder="Jumlah Deposit" data-required="true" class="form-control" style="width:450px;" onkeyup="this.value=this.value.replace(/[^0-9.,]/g,'');" onblur="this.value=this.value.replace(/[^0-9.,]/g,'');" onKeypress="if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }"> IDR <br> &nbsp; &nbsp;
									
									<input type="hidden" name="amount" id="amount" placeholder="Jumlah Deposit" data-required="true" class="form-control" style="width:450px;">
								</div>
							</div>
							
							<br><br>
							<div class="form-group-full alert_caution">
								<ul style="margin-left: 10px;">
								  <li>Kami tidak menerima transfer tunai dan deposit dari rekening atas nama orang lain.</li>
								  <li>Sebelum transfer dana, pilih bank tujuan dan harap perhatikan nomor rekening aktif kami di bawah.</li>
								</ul>
							</div>
							<br><br>
							
							<div class="space_10"></div>
							<label class="col-lg-1 control-label-header">Bank Tujuan</label>
							
							<div class="form-group-full" align="left">
								<label class="col-lg-1 control-label">Pilih Bank Tujuan</label>
								<div class="col-lg-2"> : &nbsp;
									<select id="data_bank" name='data_bank' onChange="clickBank(this)" class="form-control" style="width:96%;">
												<?php
												$BankName = $bankNameInp =  '';
												foreach($transaction->list_bank as $bank){
													$select = "";
													$bankCurr = isset($bname1) ? $bname1 : $bankname; 
													if(strtoupper($bank->BankId) == strtoupper($bankCurr)) {
														$select = "selected";
														$bankNoSel = $bank->BankAccNo;
														$bankNameSel = $bank->BankAccName;
														$bankLinkSel = $bank->BankLink;
														$bankIdSel = $bank->BankId;
													}
													echo "<option value='".$bank->BankId."' $select>".$bank->BankName."</option>";
													$bankInp .= "<input type='hidden' name='hBinf".$bank->BankId."' id='hBinf".$bank->BankId."' value='".$bank->BankAccName."#".$bank->BankAccNo."#".$bank->BankLink."'>";
											
												}
												echo "</select>";
												echo $bankInp;
												?>
								</div>
							</div>
							
							<div class="form-group-full newterm" align="left" style="display: none;">
								<label class="col-lg-1 control-label"></label>
								<div class="col-lg-2">&nbsp;
									<font size="2" style="font-style: italic; color: red; margin-left: 15px;">*Transfer antar bank diwajibkan untuk menggunakan nominal unik</font>
								</div>
							</div>
							<br>
							
							<div class="form-group-full" align="left">
								<label class="col-lg-1 control-label">Nama Rekening</label>
								<div class="col-lg-2"> : &nbsp;
									<span id="nBank"><?php echo $bankNameSel; ?></span>
									<input type='hidden' name='hBNo' value='<?php echo $bankNoSel; ?>'>
									<input type='hidden' name='hBAcc' value='<?php echo $bankNameSel; ?>'>
								</div>
							</div>
							
							<div class="form-group-full" align="left">
								<label class="col-lg-1 control-label">Nomor Rekening</label>
								<div class="col-lg-2"> : &nbsp;
									<span id="nAccNo"><?php echo $bankNoSel; ?></span>
								</div>
							</div>
																			
							<div class="form-group-full nores" align="left">
								<label class="col-lg-1 control-label">No. Record / No. Kartu ATM</label>
								<div class="col-lg-2"> : &nbsp;
									<input type="text" name="noresi" class="form-control" style="width:96%;">
								</div>
							</div>
							<div class="form-group-full nores" align="left">
								<label class="col-lg-1 control-label"></label>
								<div class="col-lg-2">&nbsp;
									<font size="2" style="font-style: italic; color: red; margin-left: 10px;">*Isi 5 digit terakhir nomor kartu atm anda.</font><br>
									<font size="2" style="font-style: italic; color: red; margin-left: 20px;">Khusus bagi yang transfer menggunakan mesin atm.</font>
								</div>
							</div>
							
							
							<div class="form-group-full">
								<label class="col-lg-1 control-label">Validasi</label>
								<div class="col-lg-3"> : &nbsp;
									<input type="text" name="captcha" placeholder="Validation" data-required="true" class="form-control" style="width:200px;">
									<img src='captcha/captcha.php?.png?a=1' alt='CAPTCHA' class="form-captcha" style="float: right;margin-left:10px;"/>	
								</div>
							</div>

							<div class="line m-t-large"></div>
							<div class="space_10"></div>

							<div class="form-group-full">
								<button type="submit" value=kirim name=submit class="btn btn-submit">Kirim</button>
							</div>
						</form>
					</div>

					<div id="uangcepat" class="tabcontent">
						<br>
						<?php 
						if ($errorReport){
							echo '<div class="alert alert-danger">'.$errorReport.'</div>';
						}else if ($success_deposit){
							echo '<div class="alert alert-success">'.$success_deposit.'</div>';
						}

						/* New Deposit */
						if($err == 4){
							$api_depo = $checkord["data"];
						?>
							<form method="POST" action='<?php echo $form_url;?>' class="validate">
								<div class='col-lg-11 center'>			  
								  <table class="table center">
									<tbody class="left">
									  <tr>
										<td colspan="3"><b># <?php echo $api_depo["ket"];?></b></td>
									  </tr>
									  <tr>
										<td>Username</td>
										<td style="padding: 0 10px;">:</td>
										<td><?php echo "<b>".$user_login."</b> ( ".$login." )";?></td>
									  </tr>
									  <tr>
										<td>Bank Tujuan</td>
										<td style="padding: 0 10px;">:</td>
										<td><?php echo "<b>".$api_depo["bank"]."</b>"; ?></td>
									  </tr>
									  <tr>
										<td>Jumlah Deposit</td>
										<td style="padding: 0 10px;">:</td>
										<td><?php echo "<b>".number_format($api_depo["amount"])."</b>"; ?></td>
									  </tr>
									</tbody>
								  </table>
								</div>
							</form>

						<?PHP
						/* Verify UangCepat */
						}else if($err == 3){
						?>
							<form method="POST" action='<?php echo $form_url;?>' class="validate">
								<div class="form-group-full">
									<label class="col-lg-1 control-label">Bank Tujuan</label>
									<div class="col-lg-2">
										<div class="text-left bold pt7 normal">
											<?php echo strtoupper($banks);?>
										</div>
									</div>
								</div>
								<div class="form-group-full">
									<label class="col-lg-1 control-label">Jumlah Deposit</label>
									<div class="col-lg-2">
										<div class="text-left bold pt7 normal">
											<?php echo number_format($amountz);?>
										</div>
									</div>
								</div>
								<div class="form-group-full">
									<label class="col-lg-1 control-label">Currency</label>
									<div class="col-lg-2">
										<div class="text-left bold pt7 normal">
											<?php echo $currency;?>
										</div>
									</div>
								</div>
								
								<input type='hidden' name='Merchant' value='<?php echo $merchant;?>'>
								<input type='hidden' name='MerchantTrxRef' value='<?php echo $merchanttrxref;?>'>
								<input type='hidden' name='Currency' value='<?php echo $currency;?>'>
								<input type='hidden' name='Customer' value='<?php echo $name;?>'>
								<input type='hidden' name='Key' value='<?php echo $key;?>'>
								<input type='hidden' name='Amount' value='<?php echo $amountz;?>'>
								<input type='hidden' name='Note' value=''>
								<input type='hidden' name='Datetime' value='<?php echo $datetime;?>'>
								<input type='hidden' name='SuccessURI' value='<?php echo $fronturl;?>'>
								<input type='hidden' name='FailedURI' value='<?php echo $failedurl;?>'>
								<input type='hidden' name='BackURI' value='<?php echo $backurl;?>'>
								<input type='hidden' name='Bank' value='<?php echo $banks;?>'>
								
								<div class="form-group-full">
									<button type="submit" value=Verify name="verify" class="btn btn-submit">Verify</button>
								</div>
							</form>

						<?PHP
						/* Deposit UangCepat */
						}else{
						?>

							<form class="form-horizontal" role="form" method="POST" name="fdeposit">
								<label class="col-lg-1 control-label-header">Pengirim</label>

								<div class="form-group-full">
									<label class="col-lg-1 control-label">Data Bank Anda</label>
									<div class="col-lg-2">
										<div class="text-left bold pt7 normal"> : &nbsp;&nbsp;
											<?php echo $bankname." / ".strtoupper($bankaccname)." / ".$bankaccnodis;?>
											<input type="hidden" name="bank" value="<?php echo $bankname;?>">
											<input type="hidden" name="bank" value="<?php echo $bankname;?>">
										</div>
									</div>
								</div>

								<div class="form-group-full" align="left">
									<label class="col-lg-1 control-label">Jumlah Deposit</label>
									<div class="col-lg-2"> : &nbsp;
										<input type="text" name="ui_amountuc" id="ui_amountuc" placeholder="Jumlah Deposit" data-required="true" class="form-control" style="width:450px;" onkeyup="this.value=this.value.replace(/[^0-9.,]/g,'');" onblur="this.value=this.value.replace(/[^0-9.,]/g,'');" onKeypress="if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }"> IDR <br> &nbsp; &nbsp;
										<font color="#dfbf61" size="2" style="font-style:italic;">*Minimal deposit Rp <?php echo number_format ($transaction->minmaxDepo->min_depo, 0, '.', '.'); ?>, Maksimal deposit Rp <?php echo number_format ($maxdepo, 0, '.', '.'); ?></font>
										<input type="hidden" name="amountuc" id="amountuc" placeholder="Jumlah Deposit" data-required="true" class="form-control" style="width:450px;">
									</div>
								</div>
								
								<br><br>
								<div class="form-group-full alert_caution">
									<ul style="margin-left: 10px;">
									  <li>Kami tidak menerima transfer tunai dan deposit dari rekening atas nama orang lain.</li>
									  <li>Sebelum transfer dana, pilih bank tujuan dan harap perhatikan nomor rekening aktif kami di bawah.</li>
									</ul>
								</div>
								<br><br>
								
								<div class="space_10"></div>
								<label class="col-lg-1 control-label-header">Bank Tujuan</label>
								
								<div class="form-group-full" align="left">
									<label class="col-lg-1 control-label">Pilih Bank Tujuan</label>
									<div class="col-lg-2"> : &nbsp;
										<select name="data-bank" data-required="true" class="form-control" style="width:96%;">
											<option value="bri">Bank Rakyat Indonesia (BRI)</option>
											<option value="bca">Bank Central Asia (BCA)</option>
											<option value="mdr">Bank Mandiri</option>
											<option value="mdrol">Bank Mandiri Kupu-Kupu</option>
											<option value="bni">Bank Negara Indonesia (BNI)</option>
											<option value="bninew">Bank Negara Indonesia M-Secure</option>
										</select>
									</div>
								</div>
								
								<div class="form-group-full newterm" align="left" style="display: none;">
									<label class="col-lg-1 control-label"></label>
									<div class="col-lg-2">&nbsp;
										<font size="2" style="font-style: italic; color: red; margin-left: 15px;">*Transfer antar bank diwajibkan untuk menggunakan nominal unik</font>
									</div>
								</div>
								
								<div class="form-group-full">
									<label class="col-lg-1 control-label">Validasi</label>
									<div class="col-lg-3"> : &nbsp;
										<input type="text" name="captcha" placeholder="Validation" data-required="true" class="form-control" style="width:200px;">
										<img src='captcha/captcha.php?.png?a=1&type=ucep' alt='CAPTCHA' class="form-captcha" style="float: right;margin-left:10px;"/>	
									</div>
								</div>

								<div class="line m-t-large"></div>
								<div class="space_10"></div>

								<div class="form-group-full">
									<button type="submit" value=kirim name="submit-uc" class="btn btn-submit">Kirim</button>
								</div>
							</form>
						<?PHP
						}
						?>
					</div>
									
					
					<div id="history" class="tabcontent">
						 <?php
                                    // get history
                                    $reqAPITransHist = array(
                                        "auth"      => $authapi,
                                        "userid" 	=> $login,
                                        "type"		=> 1,
                                    );

                                    $respTransHis = sendAPI($url_Api."/history",$reqAPITransHist,'JSON','02e97eddc9524a1e');

                                    $errorReport2 = '';
                                    if($respTransHis->status != 200){
                                        echo "<div class='alert alert-danger' style='margin-left: 0px;'>" . $respTransHis->msg . "</div>";
                                    }
                                    ?>
						<br>
						<div id="table_list">
							<form onsubmit="submitfilter('', '#table_list', 'preloader'); return false;">
								<table width="100%" cellpadding="0" cellspacing="0" border="0" id="table" style="font-size:12px;">
                                        <thead align="left">
                                            <tr>
                                                <th align="center" height="23">#</th>
                                                <th>Rekening Bank</th>
                                                <th>Jumlah Deposit</th>
                                                <th>Tanggal Deposit </th>
                                                <th align="center">Status</th>
                                            </tr>
                                        </thead>
                                        <tbody align="left">
                                        <?php
                                            $no = 1;
                                            if (count($respTransHis->dpp) > 0){
                                                $fetch_depositPending = $respTransHis->dpp[0];
                                                $date = strtotime($fetch_depositPending->date1);
                                                $rekNo = substr(str_replace('-', '', $fetch_depositPending->rek), 0,-4) . 'xxxx';
                                                $rekDis = bank_format($rekNo, $fetch_depositPending->bank);
                                                echo "<tr>
                                                        <td align='center' height='23'>".$no++."</td>
                                                        <td>".$rekDis."<br />".$fetch_depositPending->bank."</td>
                                                        <td>IDR ".number_format($fetch_depositPending->amount)."</td>
                                                        <td>".date("d/m  H:i", $date)."</td>
                                                        <td align='center'>Proccess</td>
                                                     </tr>";
                                            }

                                            foreach ($respTransHis->dph as $depositHist){
                                                $date = strtotime($depositHist->date2);
                                                $rekNo = substr(str_replace('-', '', $depositHist->rek), 0,-4) . 'xxxx';
                                                $rekDis = bank_format($rekNo, $depositHist->bank);
                                                echo "<tr>
                                                        <td align='center' height='23'>".$no++."</td>
                                                        <td>".$rekDis."<br />".$depositHist->bank."</td>
                                                        <td>IDR ".number_format($depositHist->amount)."</td>
                                                        <td>".date("d/m  H:i", $date)."</td>
                                                        <td align='center'>" . $depositHist->status . "</td>
                                                     </tr>";
                                            }
                                        ?>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="10">
                                                    Jumlah: <b><?php echo count($respTransHis->dph) ?></b>
                                                </td>
                                            </tr>
                                        </tfoot>
                                    </table>
							</form>
							
							<script language="JavaScript" type="text/javascript">
								jQuery(document).ready(function(){
									jQuery(".popup").nyroModal();
									fixtable("#table", null, "#198dd1", "#198dd1", "#33b4ff");
									// getfilter();
									jQuery(".toggleCheck").bind("click", function(){
										var current=jQuery(this);
										var table=current.parent().children("a.table").attr("rel");
										var id=current.parent().children("a.id").attr("rel");
										if(confirm("Are you sure want to perform this action? Click 'OK' to continue.")){
											jQuery.get(''+"/"+table+"/"+id+"/"+current.attr("rel"), function(r){
												jQuery("#statusCheck"+id).html(r);
											})
										}
									});
								})
							</script>
						</div>
					</div>

				</div>
            </div>
			<?php 
			} 
			?>
        </div>
	
        <div class="clear space_30"></div>
    </div>
</div>
	
<script>
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(?:\d{3})+(?!\d))/g, ",");
	}

	$('#ui_amount').keyup(function() {
	  var isi = $(this).val();
	  var res = isi.split(",");
	  var finalres = "";
	  
	  for(var a=0; a<res.length; a++){
	  	finalres += res[a];
	  }

	  $(this).val(numberWithCommas(finalres))
		$('#amount').val(finalres);
	});

	$('#ui_amountuc').keyup(function() {
	  var isi = $(this).val();
	  var res = isi.split(",");
	  var finalres = "";
	  
	  for(var a=0; a<res.length; a++){
	  	finalres += res[a];
	  }

	  $(this).val(numberWithCommas(finalres))
		$('#amountuc').val(finalres);
	});
</script>

<?php
if(isset($_SESSION['optLogin'])){
	echo "<script src=\"https://d3qycynbsy5rsn.cloudfront.net/OptiRealApi-1.1.0.js\" type=\"text/javascript\"></script>";
	echo "<script>
			 $(document).ready(function(){
				 OptiRealApi.reportEvent(1, null, '" . $sqlu["id"] . "', \"7ae87a05e42bd455d041884a1f62da6a30bc2ff5a20dc47e8b12620cf82066bc\");
			 });
		 </script>";
	unset($_SESSION['optLogin']);
}

include("footer.php");
?>