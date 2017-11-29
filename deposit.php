<?php
$freePage=true;
include("meta.php");
include("header.php");
function currx($val) {
   if (!strpos($val,".")) return number_format($val, 0,'.', ',');
   else return number_format($val, 1,'.', ',');
}
if (!$_SESSION["login"]){
	$flag = 'deposit';
	include('ketdpwd.php');
	include('footer.php');
die();
}

$reqAPILastOrder = array(
    "auth"      => $authapi,
    "agent"     => $agentwlable,
    "userid"    => $login,
	"curr"      => $curr,
	"bankgroup" => $bankgroup,
	"minutes"   => 1
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
if ($xdeposit > 0) {
	$firstdepo = 1;
	$maxdepo = $transaction->minmaxDepo->max_depo;
}else{
	$firstdepo = 0;
	$maxdepo = $transaction->first_max_depo;
}

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
	$rek2 = str_replace('-','', $_POST['hBNo']);
	$accname2	= $_POST['hBAcc'];

	$err = 0;
	/* if($capt == ''){
		$errorReport = ("<strong>Deposit gagal!</strong> Captcha harus diisi");
	}else if(!checkCaptcha('CAPTCHAString', $capt)){
		$errorReport = ("<strong>Deposit gagal!</strong> Captcha tidak sama");
	}else{ */
			
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
				<span>Deposit anda paling maximal akan di proses dalam 24 jam</span></div>";
            echo"<br>";
            echo "<script src=\"https://d3qycynbsy5rsn.cloudfront.net/OptiRealApi-1.1.0.js\" type=\"text/javascript\"></script>";
            echo "<script>
					$(document).ready(function(){
						OptiRealApi.reportEvent(7, null, '" . $login . "', \"7ae87a05e42bd455d041884a1f62da6a30bc2ff5a20dc47e8b12620cf82066bc\");
					});
				</script>";
		}else{
			$errorReport =	("<strong>Deposit gagal!</strong> " . $response->msg);
		}
	/* 
	} */
	echo"<BR>";
}

if(isset($_POST['subform'])){
	$defaultOpen = 2;
}
?>
<script language="JavaScript" type="text/javascript">

	function clickBank(a){

		var fom =  document.fdeposit;       /*nama form */
		var s = fom.data_bank;

		// var tmp = s.selectedIndex;
		var tmp = a.value;
		var hb = eval("fom.hBinf"+tmp);
		var hbx = eval("fom.hBNo");
		var hcx =  eval("fom.hBAcc");
		
		var tb = document.getElementById("nAccNo");
		var tc = document.getElementById("nBank");
		
		tb.innerHTML = hb.value.split('#')[1];
		tc.innerHTML = hb.value.split('#')[0];
        hbx.value = hb.value.split('#')[1];
        hcx.value = hb.value.split('#')[0];
		var bnkl = hb.value.split('#')[2];


		$('.btn-bank').attr("onclick", "openRequestedPopup('" + bnkl + "','" + tmp + "')");
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

<?php 

	if($_SESSION['login'] && $subscribe == 0 ){
?>
<!-- <script src="assets/js/jquery-2.1.4.js"></script>-->
<script src="https://email.6mbr.com/subscribe.js?u=<?php echo $_SESSION['login']?>&w=domino88321&v=<?php echo time();?>" data-modalid="1405531097" data-webid="domino88321" data-user="<?php echo $_SESSION['login']?>" ></script>	<?php 
	}
?>
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
								<?php 
								if($subwebid=='9002' || $subwebid=='9001' || $subwebid=='172' || $subwebid=='42'){
								?>
									<ul class="tab">
										<li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'cash')" <?PHP if($defaultOpen!=2){ echo 'id="defaultOpen"'; }?>>Cash Deposit</a></li>
										<li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'voucher')" <?PHP if($defaultOpen==2){ echo 'id="defaultOpen"'; }?>>Voucher Deposit</a></li>
										<li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'history')">History Deposit</a></li>
									</ul>
									<div style="clear: both;"></div>
								<?php 
								}
								?>
								
								<div id="voucher" class="tabcontent">
									<br>
									<?php
										$submit_voucher=$_POST["subform"];
										if ($submit_voucher && $err != 1){
											$defaultOpen = 2;
											$voucher_code=str_replace(" ","",$_POST["voucher_code"]);
											$pin=str_replace(" ","",$_POST["pin"]);
											$captcha=str_replace(" ","",$_POST["captcha"]);

                                            if ($q_maintenance > 0) {
                                                $errReport = "<div style='font-family:tahoma,verdana,arial;font-size:15px;color:red;font-weight:bold' align=center>Connection Time out.</div>";
                                                $err = 1;
                                                echo "<div class='alert alert-danger text-center'><p><i class='fa fa-times-circle fa-2x'></i></p><p>".$errReport.".</p></div>";
                                                die();
                                            }

                                            if ($voucher_count >= 5){
                                                $errorReportvou = "Maaf voucher deposit di tutup sementara";
                                                $err = 1;
                                            }else {
                                                $err = 0;
                                                if ($captcha == '') {
                                                    $errorReportvou = ("Captcha harus diisi");
                                                } else if (!checkCaptcha('vou', $captcha)) {
                                                    $errorReportvou = ("Captcha tidak sama");
                                                } else {

                                                    $reqAPIRegister = array(
                                                        "auth"     => $authapi,
                                                        "webid"    => $subwebid,
                                                        "act"      => 3,
                                                        "app_id"   => '610727387664706',
                                                        "app_scr"  => 'hUfxqqtupO4wlM1lkyfkMBP1ff0KclwS',
                                                        "agent"    => $agentwlable,
                                                        "userid"   => strtoupper($login),
                                                        "loginid"  => strtoupper($user_login),
                                                        "voucCode" => $voucher_code,
                                                        "voucPin"  => $pin,
                                                        "ip"       => getUserIP2(),
                                                        "minutes"  => 1,
                                                    );

                                                    $response = sendAPI($url_Api . "/cashier", $reqAPIRegister, 'JSON', '02e97eddc9524a1e');
                                                    if ($response->status == 200) {
                                                        $success_vou = $response->msg . '<br>' . 'Voucher di terima, saldo sebesar ' . $response->amount . ' telah di tambahkan';
                                                    } else {
                                                        $errorReportvou = ("<strong>Voucher Deposit Failed!</strong> " . $response->msg);
                                                    }
                                                }
                                            }
										}

										if ($voucher_count >= 5){
                                            $errorReportvou = "Maaf voucher deposit di tutup sementara";
                                            $err = 1;
										}

										if ($errorReportvou){
											echo "<div class='alert alert-danger text-center'><p>".$errorReportvou.".</p></div>";
										}
										if ($success_vou){
											echo "<div class='alert alert-success text-center'><p>".$success_vou.".</p></div>";
										}
										
										?>	
									
									<form method=post>
										<div class="form-group-full">
											<label class="col-lg-1 control-label">Voucher Code</label>
											<div class="col-lg-2"> : &nbsp;
												<input id="" type="text" placeholder="Voucher Code" name="voucher_code" value="" data-required="true" class="form-control" style="width:96%;" maxlength="20" onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');" onblur="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');">
											</div>
										</div>
										<div class="form-group-full">
											<label class="col-lg-1 control-label">PIN</label>
											<div class="col-lg-2"> : &nbsp;
												<input id="" type="text" placeholder="Pin" name="pin" value="" data-required="true" class="form-control" style="width:96%;" maxlength="10" onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');" onblur="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');">
											</div>
										</div>
										<div class="form-group-full">
											<label class="col-lg-1 control-label">Validasi</label>
											<div class="col-lg-3"> : &nbsp;
												<input type="text" name="captcha" placeholder="Validation" data-required="true" class="form-control" style="width:200px;">
												<img src='captcha/captcha.php?.png?a=1&type=vou' alt='CAPTCHA' class="form-captcha" style="float:right; margin-top:3px; margin-left: 10px;"/>	
											</div>
										</div>
										<div class="line m-t-large"></div>
										<div class="space_10"></div>
										<div class="form-group-full">
											<button type="submit" value=subform name=subform class="btn btn-submit">Kirim</button>
										</div>
									</form>
								</div>
								<table style="float: right; margin-top: -45px">
									<tr><td><a href="http://www.voucher88.asia/business/benefits/reseller" target="_blank"><img src="images/V88_300x100.gif"></a></td></tr>
								</table>
								
								<div id="cash" class="tabcontent">
									<br>
									<?php 
									if ($errorReport){
									?>
										<div class="alert alert-danger">
											<?php
											echo $errorReport;
											?>
										</div>
									<?php
									}else if ($success_deposit){
									?>
										<div class="alert alert-success">
											<?php
											echo $success_deposit;
											?>
										</div>
									<?php
									}
									?>

									<form class="form-horizontal" role="form" method="POST" name="fdeposit">
										<label class="col-lg-1 control-label-header">Pengirim</label>

										<div class="form-group-full">
											<label class="col-lg-1 control-label">Data Bank Anda</label>
											<div class="col-lg-2">
												<div class="text-left bold pt7 normal"> : &nbsp;
												 &nbsp;
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
												<font color="#dfbf61" size="2" style="font-style:italic;">*Minimal deposit Rp <?php echo number_format ($transaction->minmaxDepo->min_depo, 0, '.', '.'); ?>, Maksimal deposit Rp <?php echo number_format ($maxdepo, 0, '.', '.'); ?></font>
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
																if($bank->BankId == $bankCurr) {
																	$select = "selected";
																	$bankNoSel = $bank->BankAccNo;
																	$bankNameSel = $bank->BankAccName;
																	$bankLinkSel = $bank->BankLink;
																	$bankIdSel = $bank->BankId;
																}
																echo "<option value='".$bank->BankId."' $select>".$bank->BankName."</option>";
																$bankInp .= "<input type='hidden' name='hBinf".$bank->BankId."' value='".$bank->BankAccName."#".$bank->BankAccNo."#".$bank->BankLink."'>";
														
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
											<label class="col-lg-1 control-label">No. Resi / No. Kartu ATM</label>
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
										
										<div class="form-group-full" align="left">
											<div class="col-lg-1"></div>
													<div class="col-lg-2">
														<a onclick="openRequestedPopup('<?php echo $bankLinkSel ."','". $bankIdSel?>')" target='POP' class='btn-bank <?php echo strtolower($bankIdSel)?>' style='cursor:pointer;'>
															<img src="m/img/banks/<?php echo strtolower($bankIdSel) ?> - blue.png" width="70px" style="vertical-align:middle;"> &nbsp; Login E-Banking
														</a>
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
	
function openRequestedPopup(link, title) {
	var windowObjectReference;
	var strWindowFeatures ="toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=1,scrollbars=1";
	var w = 830;
	var h = 830;
	var windowX = Math.ceil( (window.screen.width  - (w)) / 2 );
	var windowY = Math.ceil( (window.screen.height - (h)) / 2 );
	splash = windowObjectReference = window.open(link, title, strWindowFeatures);
	splash.resizeTo( Math.ceil( w )       , Math.ceil( h ) );
	splash.moveTo  ( Math.ceil( windowX ) , Math.ceil( windowY ) );
}

// document.getElementById("cpt").innerHTML = document.getElementById("cpc").innerHTML;

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