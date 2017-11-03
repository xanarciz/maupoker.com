<?php
$page='deposit'; 
session_start();
$login = $_SESSION["login"];

if (!$login){
	include("_meta.php");
} else {
	include("_metax.php");
	if($status_bank == 0) {
		echo "<script>window.location = 'bank-setting.php'</script>";
		$_SESSION['urlPrev'] = 'deposit.php';
		die();
	}
}

include("_header.php");

$reqAPILastOrder = array(
    "auth"   => $authapi,
    "userid" => $login,
    "agent"  => $agentwlable,
    "curr"   => $curr,
    "bankgroup" => $bankgroup,
    "minutes"=> 1
);
$transaction = sendAPI($url_Api . "/transaction", $reqAPILastOrder, 'JSON', '02e97eddc9524a1e');

$err = 0;
if ($transaction->msg != 'OK') {
    $success_deposit = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>" . $transaction->msg . "</p></div>";
    $err = 1;
}

if ($q_maintenance == "1") {
    $success_withdraw = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Connection Time out.</p></div>";
    $err = 1;
}

if ($status_block == 2 || $status_block == 3) {
    $success_deposit = "
        <div class='static-notification-red tap-dismiss-notification'>
            <p class='center-text uppercase'>Account anda masi dalam proses validasi.<br>Anda hanya bisa mengakses menu MEMO.</p>
        </div>";
    $err = 1;
} else if ($status_block == 4) {
    $success_deposit = "
        <div class='static-notification-red tap-dismiss-notification'>
            <p class='center-text uppercase'>Account anda Bermasalah.<br> Harap hubungi kami.</p>
        </div>";
    $err = 1;
} else if ($status_block == 5) {
    $success_deposit = "
        <div class='static-notification-red tap-dismiss-notification'>
             <p class='center-text uppercase'>Account anda masih dalam proses lupa password<br>sementara anda hanya bisa mengakses menu MEMO</p>
         </div>";
    $err = 1;
}

$defaultOpen = 0;
if ($xdeposit > 0) {
    $firstdepo = 1;
    $maxdepo = $transaction->minmaxDepo->max_depo;
} else {
    $firstdepo = 0;
    $maxdepo = $transaction->first_max_depo;
}

if ($_POST["submit"] && $err == 0) {
    $name = $login;

    $amount = str_replace('.', '', $_POST["amount"]);
    $accname1 = $bankaccname;
    $rek1 = $bankaccno;
    $bname1 = $bankname;
    $capt = $_POST["captcha1"];
    $remark = "Deposit";
	$noresi 	= $_POST["noresi"];

    $databank = explode(",", $_POST["data-bank"]);
    $bname2 = $databank[0];
    $rek2 = $databank[1];
    $accname2 = $databank[2];
    $condition = $databank[3];

    $err = 0;
    if ($capt == '') {
        $err = 1;
        $errorReport = ("<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Captcha harus diisi</p></div>");
    } else if (!checkCaptcha('CAPTCHAString', $capt)) {
        $err = 1;
        $errorReport = ("<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'> Captcha tidak sama </p></div>");
    } else {

        $reqAPIRegister = array(
            "auth" => $authapi,
            "webid" => $subwebid,
            "act" => 1,
            "agent" => $agentwlable,
            "userid" => strtoupper($name),
            "amount" => $amount,
            "bankgroup" => $bankgroup,
            "bankaccname" => $bankaccname,
            "bankaccno" => $bankaccno,
            "bankname" => $bankname,
            "banktuj" => $bname2,
            "rektuj" => $rek2,
            "firstdepo" => $xdeposit,
			"noresi" => $noresi,
            "minutes" => 1,
            "device" => $device
        );

        $response = sendAPI($url_Api . "/cashier", $reqAPIRegister, 'JSON', '02e97eddc9524a1e');
        if ($response->status == 200) {
            $err = 0;
            $errorReport = '';
            $success_deposit = "
                <div class='deposit-success-report' style='color:#000;'>Deposit $amount sukses. <br><br>
                    <font style='font-size:12px;'>Rekening Tujuan : </font>
                    <table style='font-size:14px;' align=center>
                        <tr>
                            <td align=left style=font-size:12px;>Bank</td><td>:</td><td align=left>" . strtoupper($bname2) . "</td>
                        </tr>
                        <tr>
                            <td align=left style=font-size:12px;>Nomor Rekening</td><td>:</td><td align=left>" . strtoupper($rek2) . "</td>
                        </tr>
                        <tr>
                            <td align=left style=font-size:12px;>Nama Rekening</td><td>:</td><td align=left>" . strtoupper($accname2) . "</td>
                        </tr>
                    </table>
            
                    Deposit anda paling maximal akan di proses dalam 24 jam
                </div>";
        } else {
            $err = 1;
            $errorReport = ("<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'> <strong>Deposit gagal!</strong> " . $response->msg . "</p></div>");
        }
    }
}

if ($_POST["subform"]) {
    $voucher_code = str_replace(" ", "", $_POST["voucher_code"]);
    $pin = str_replace(" ", "", $_POST["pin"]);
    $captcha = str_replace(" ", "", $_POST["captcha"]);

    $err = 0;
    if ($voucher_count >= 5) {
        $errorReportvouc = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Maaf voucher deposit di tutup sementara</p></div>";
        $err = 1;
    } else {
        if ($captcha == '') {
            $errvouc = 1;
            $errorReportvouc = ("<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'><strong>Deposit gagal!</strong> Captcha harus diisi</p></div>");
        } else if (!checkCaptcha('CAPTCHAString', $captcha)) {
            $errvouc = 1;
            $errorReportvouc = ("<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'><strong>Deposit gagal!</strong> Captcha tidak sama </p></div>");
        } else {

            $reqAPIRegister = array(
                "auth"    => $authapi,
                "webid"   => $subwebid,
                "act"     => 3,
                "app_id"  => '610727387664706',
                "app_scr" => 'hUfxqqtupO4wlM1lkyfkMBP1ff0KclwS',
                "agent"   => $agentwlable,
                "userid"  => strtoupper($login),
                "loginid" => strtoupper($user_login),
                "voucCode"=> $voucher_code,
                "voucPin" => $pin,
                "ip"      => getUserIP2(),
                "minutes" => 1,
            );

            $response = sendAPI($url_Api . "/cashier", $reqAPIRegister, 'JSON', '02e97eddc9524a1e');
            if ($response->status == 200) {
                $success_deposit = $response->msg . '<br>' . 'Voucher di terima, saldo sebesar ' . $response->amount . ' telah di tambahkan';
            } else {
                $errvouc = 1;
                $errorReportvouc = ("<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'><strong>Deposit gagal!</strong> " . $response->msg .'</p></div>');
            }
        }
    }
}


if ($voucher_count >= "5") {
    $errorReportvouc = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Maaf voucher deposit di tutup sementara</p></div>";
    $errvouc = 1;
}
?>

<div class="content-2" data-id="deposit" id="page">
	<div class="lpadding-15 tpadding-5">
		<label class="ntf fs-13"><?PHP if($_SESSION["login"]) echo "FORM "; ?>DEPOSIT</label>
	</div>
	<?php
		if($_SESSION["login"]){
			if ($success_deposit){
				echo $success_deposit;
			}else{
	?>

	<hr class="margin-0 tmargin-2 bmargin-3 bg-brown-panel">

	<div id="referral">
		<div class="padding">
			<ul>
				<li><a href="#tabs-1" onclick="tabs_1()">Cash Deposit</a></li>
				<li><a href="#tabs-2" onclick="tabs_2()">Voucher Deposit</a></li>
			</ul>

			<div id="tabs-1">
                <div class="tpadding-10 lpadding-15 rpadding-15 row">
                    <?php
                    if ($err == 1){
                        echo $errorReport;
                    }
                    ?>
                    <form method="post" id="fcash" name="fcash">

						<div class="row margin0">
							<div class="col-lg-5">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10">BANK</label>
							</div>
							<div class="col-lg-1">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
							</div>
							<div class="col-lg-6">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> <?php echo $bankname;?> </label>
								<input type="hidden" name="bank" value="<?php echo $bankname;?>" />
							</div>
						</div>
						<div class="row margin0">
							<div class="col-lg-5">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10">NAMA REKENING</label>
							</div>
							<div class="col-lg-1">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
							</div>
							<div class="col-lg-6">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> <?php echo $bankaccname; ?> </label>
								<input type="hidden" name="bank_accname" value="<?php echo $bankaccname; ?>" />
							</div>
						</div>
						<div class="row margin0">
							<div class="col-lg-5">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10">NOMOR REKENING</label>
							</div>
							<div class="col-lg-1">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
							</div>
							<div class="col-lg-6">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> 
								<?php echo $bankaccnodis; ?>
								</label>
								<input type="hidden" name="bank_accnumber" value="<?php echo $bankaccno;?>" />
							</div>
						</div>

						<label class="black fs-13 pull-left tmargin-10">Jumlah Deposit</label>
						<div class="row">
							<div class="col-lg-11">
								<input type="tel" class="form-control bg-light-gray" name="ui_amount" id="ui_amount" value="<?php echo @$amount?>" placeholder="Masukan jumlah deposit" required onkeyup="this.value=this.value.replace(/[^0-9.,]/g,'');" onblur="this.value=this.value.replace(/[^0-9.,]/g,'');" onKeypress="if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }" />
								<input type="hidden" name="amount" id="amount" value="<?php echo @$amount?>">
							</div>
							<div class="col-lg-1 text-left">
								<label class="black tmargin-10 lmargin-5">IDR</label>
							</div>
						</div>
						<label class="black fs-13 fs-normal">Pilihan Bank</label>
						<div class="row margin0">
							<div class="col-lg-12">
								<select class="form-control bg-light-gray" name="data-bank" id="data-bank" required>
									<option value="" selected> Pilih Bank </option>
									<?PHP
                                    foreach ($transaction->list_bank as $bankDetails){
                                        $sel = '';
                                        if(strtoupper($bankname) == strtoupper($bankDetails->BankId)) {
                                            $sel = "selected";
                                            $bankSelected = $bankDetails->BankId;
                                            $bankLink = $bankDetails->BankLink;
                                        }
                                        echo '<option value="'.strtoupper($bankDetails->BankId).",".$bankDetails->BankAccNo.",".$bankDetails->BankAccName.'" '.$sel.' dt-link="'.$bankDetails->BankLink.'">'.strtoupper($bankDetails->BankName).'</option>';
										}
									?>
								</select>
							</div>
						</div>
						
						

						<label class="black fs-13 pull-left tmargin-10 nores">Nomor Resi</label>
						<div class="row nores">
							<div class="col-lg-13">
								<input type="text" name="noresi" class="form-control bg-light-gray" >
							</div>
						</div>
						<label class="black fs-13 fs-normal nores" style="display: none;">*Isi 5 digit terakhir nomor kartu atm anda.</label>
						<label class="black fs-13 fs-normal nores" style="display: none;">Khusus bagi yang transfer menggunakan mesin atm.</label>

						<label class="black fs-13 fs-normal tmargin-10 bank-detail" style="display: none;">Silakan deposit ke:</label>
						<div class="row margin0 bank-detail" style="display: none;">
							<div class="col-lg-4">
								<label class="black fs-13 fs-normal tmargin-10">Nama Bank</label>
							</div>
							<div class="col-lg-1 ">
								<label class="black fs-13 fs-normal tmargin-10"> : </label>
							</div>
							<div class="col-lg-7">
								<label class="black fs-13 fs-normal tmargin-10" id="bkil">  </label>
							</div>
						</div>

						<div class="row margin0 bank-detail" style="display: none;">
							<div class="col-lg-4">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10">Nama Rekening</label>
							</div>
							<div class="col-lg-1">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
							</div>
							<div class="col-lg-7">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10" id="nare">  </label>
							</div>
						</div>

						<div class="row margin0 bank-detail" style="display: none;">
							<div class="col-lg-4">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10">Nomor Rekening</label>
							</div>
							<div class="col-lg-1">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
							</div>
							<div class="col-lg-5">
								<label class="black fs-13 fs-normal bmargin-5 tmargin-10" id="nore">  </label>
								<label style="display: none;" id="finalcopy"></label>
							</div>
							<div class="col-lg-2">
								<input class="btn btn-medium btn-gray bmargin-5 text-center" id="copy-to" type="button" value="Copy" />
							</div>
						</div>

                        <div class="row margin0 tpadding-5">
                            <div class="col-lg-12 dropdown">
                                <a href="<?php echo $bankLink; ?>" target="_blank" class="dropbtn fs-14 elogin" id="btn-<?php echo strtolower($bankSelected);?>" style="display: none; height: 50px;">
                                    <div class="col-lg-3 col-lg-offset-2 dimg">
                                        <img src="img/banks/<?php echo strtolower($bankSelected); ?> - blue.png" class="bank pull-left" style="height:25px;!important" ">
                                    </div>
                                    <div class="col-lg-3">
                                        <p class="margin-0 tmargin-3">Login E-Bank</p>
                                    </div>
                                </a>
                            </div>
                        </div>

						<div class="row"><label class="black fs-13 pull-left tmargin-10">Validasi</label></div>
						<div class="row">
							<div class="col-lg-7">
								<input class="form-control bg-light-gray" type="text" name="captcha1" maxlength="5" placeholder="Validasi" required />
							</div>
						
							<div class="col-lg-5 tpadding-3 lpadding-5">
								<img src='../../captcha/captcha.php?.png' alt='CAPTCHA' width='100%' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">
							</div>
						</div>

						<div class="row">
							<input class="btn btn-gray tmargin-10 bmargin-5" value="BATAL" type="button" onclick="location.href='index.php'" />
						</div>
						<div class="row">
							<input class="btn btn-blue tmargin-5 bmargin-10" value="KONFIRMASI" type="submit" name="submit" />
						</div>
						<ol class="black">
							<li class="margin-0">Minimal Deposit = 10.000,00 IDR .</li>
							<li class="margin-0"> Harap perhatikan rekening deposit kami yang sedang aktif sebelum melakukan pengiriman deposit, sehingga deposit anda dapat di proses secepatnya ke dalam dompet utama anda. </li>
							<li class="margin-0">Deposit Menggunakan account bank selain yang di daftarkan tidak di perbolehkan. </li>
							<li class="margin-0">etelah melakukan proses pengiriman dan mengisi form secara benar maka deposit anda akan di proses dalam kurun waktu 5 menit. </li>
							<li class="margin-0">Silahkan hubungin customer service kami via live chat untuk konfirmasi status deposit anda.</li>
						</ol>

					    <div class="toggle-1 bmargin-15" style="z-index: 9998; background: #d7d7d7; border-radius: 5px;">
					        <a href="#" class="deploy-toggle-1 toggle-design bg-brown-panel br-5">
					            <label class="ntf fs-13">
						            Jadwal Bank Offline
									<img src="img/<?PHP echo $link_img;?>/icons/br_down.png" class="pull-right btn-down"/>
									<img src="img/<?PHP echo $link_img;?>/icons/br_up.png" class="pull-right btn-up" style="display: none;" />
								</label>
					        </a>
					        <div class="toggle-content bank-offline-content br-5" style="display: none; background: #d7d7d7 !important;">

								<div class="row padding-10">
									<div class="row">
										<div class="col-lg-3">
											<img class="img-fluid tmargin-10" src="img/banks/bca.png">
										</div>
										<div class="col-lg-9 lpadding-10">
											<p class="fs-11" style="border:none; color: #000 !important;">
												Senin-Jumat	: 21.00 - 00.30 WIB <br/>
												Sabtu			: 18.00 - 20.00 WIB<br/>
												Minggu			: 00.00 - 06.00 WIB<br/>
											</p>
										</div>	
									</div>

									<div class="row tpadding-15">
										<div class="col-lg-3">
											<img class="img-fluid tmargin-10" src="img/banks/mandiri.png">
										</div>
										<div class="col-lg-9 lpadding-10">
											<p class="fs-11" style="border:none; color: #000 !important;">
												Senin - Jumat	: 23.00 - 04.00 WIB<br/>
												Sabtu - Minggu	: 22.00 - 06.00 WIB
											</p>
										</div>	
									</div>

									<div class="row tpadding-15">
										<div class="col-lg-3">
											<img class="img-fluid tmargin-10" src="img/banks/bni.png">
										</div>
										<div class="col-lg-9 lpadding-10">
											<p class="fs-11 tmargin-10" style="border:none; color: #000 !important;">
												Senin - Minggu	: 00:00 - 02: 30 WIB
											</p>
										</div>	
									</div>

									<div class="row tpadding-15">
										<div class="col-lg-3">
											<img class="img-fluid tmargin-10" src="img/banks/bri.png">
										</div>
										<div class="col-lg-9 lpadding-10">
											<p class="fs-11 tmargin-7" style="border:none; color: #000 !important;">
												Senin - Minggu	: 21:00 - 05:30 WIB
											</p>
										</div>	
									</div>
										<div class="row tpadding-15">
										<div class="col-lg-3">
											<img class="img-fluid tmargin-10" src="img/banks/cimb.png">
										</div>
										<div class="col-lg-9 lpadding-10">
											<p class="fs-11 tmargin-7" style="border:none; color: #000 !important;">
												Tidak Ada Offline
											</p>
										</div>	
									</div>
								</div>

					        </div>
					    </div>

						<div style="padding-bottom: 50px;"></div>

					</form>
				</div>
			</div>

			<div class="tabs-2" id="tabs-2-content" style="display: none;">
				<div class="tpadding-10 lpadding-15 rpadding-15 row">
                    <?php
                    if ($errvouc == 1){
                        echo $errorReportvouc;
                    }
                    ?>
                    <form method="post" id="fvoucher" name="fvoucher">
						<label class="black fs-13 pull-left tmargin-10">Voucher Code</label>
						<div class="row">
							<div class="col-lg-12">
								<input class="form-control bg-light-gray" name="voucher_code" id="amount" value="" placeholder="Voucher Code" required maxlength="20" onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');" onblur="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');" />
							</div>
						</div>

						<label class="black fs-13 pull-left tmargin-10">Voucher PIN</label>
						<div class="row">
							<div class="col-lg-12">
								<input class="form-control bg-light-gray" name="pin" id="amount" value="" placeholder="Voucher Pin" required onkeyup="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');" onblur="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');" />
							</div>
						</div>

						<div class="row"><label class="black fs-13 pull-left tmargin-10">Validasi</label></div>
						<div class="row">
							<div class="col-lg-7">
								<input class="form-control bg-light-gray" type="text" name="captcha" maxlength="5" placeholder="Validasi" required />
							</div>
						
							<div class="col-lg-5 tpadding-3 lpadding-5">
								<img src='../captcha/captcha.php?.png' alt='CAPTCHA' width='100%' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">
							</div>
						</div>
						<div class="row">
							<input class="btn btn-gray tmargin-10 bmargin-5" value="BATAL" type="button" onclick="location.href='index.php'" />
						</div>
						<div class="row">
							<input class="btn btn-blue tmargin-5 bmargin-10" value="KONFIRMASI" type="submit" name="subform" />
						</div>
					</form>
				</div>
			</div>

		</div>
	</div>

	<?PHP 
			}
		}else{
	?>

	<div class="padding-10">
		<div class="alert alert-warning text-left bmargin-10">
			<div class="row">
				<div class="col-lg-1 bpadding-10">
					<i class="fa fa-info-circle fa-2x rmargin-10"></i>
				</div>
				<div class="col-lg-11 lpadding-5">
					<p class="fs-bold"> Silahkan LOGIN terlebih dahulu untuk melakukan deposit</p>
					</div>
				</div>

				<hr class="margin-0 bmargin-5">
				<ol>
					<li class="margin-0">Deposit hanya akan di proses dari rekening yang terdaftar.</li>
					<li class="margin-0">Minimum Deposit Rp10.000</li>
					<li class="margin-0">Setelah melakukan pengisian form deposit dengan benar, maka Deposit akan di proses secepetnya .</li>
				</ol>
			</div>
			<label class="ntf fs-13">
				Metode Deposit Bank:
			</label>
			<div class="row tmargin-5 rpadding-5 bmargin-10">
				<div class="col-lg-3 rpadding-10">
					<img class="img-fluid" src="img/banks/bca.png">
				</div>
				<div class="col-lg-3 rpadding-10">
					<img class="img-fluid" src="img/banks/mandiri.png">
				</div>
				<div class="col-lg-3 rpadding-10">
					<img class="img-fluid" src="img/banks/bni.png">
				</div>
				<div class="col-lg-3 rpadding-10">
					<img class="img-fluid" src="img/banks/bri.png">
				</div>
			</div>
			<div class="row tmargin-5 lpadding-5 bmargin-10">
				<div class="col-lg-3">
					<img class="img-fluid" src="img/banks/cimb.png">
				</div>
			</div>
			<label class="ntf fs-13">
				Metode Deposit Alternatif:
			</label>
			<div class="row tmargin-5 bmargin-15">
				<div class="col-lg-5">
					<img class="img-fluid" src="img/banks/v88.png"/>
				</div>
			</div>

			<div class="row bg-brown-panel padding-10 br-5">
				<label class="ntf fs-13">
					Jadwal Bank Offline
				</label>
				<div class="row tmargin-10">
					<div class="col-lg-3">
						<img class="img-fluid tmargin-10" src="img/banks/bca.png">
					</div>
					<div class="col-lg-9 lpadding-10">
						<p class="dark-gray fs-11" style="border:none;">
							Senin - Jumat	: 21:00 - 00:30 WIB <br/>
							Sabtu			: Tidak ada Offline<br/>
							Minggu			: 00:00 - 06:00 WIB<br/>
						</p>
					</div>	
				</div>

				<div class="row">
					<div class="col-lg-3">
						<img class="img-fluid tmargin-10" src="img/banks/mandiri.png">
					</div>
					<div class="col-lg-9 lpadding-10 tmargin-10">
						<p class="dark-gray fs-11" style="border:none;">
							Senin - Minggu	: 23:00 - 05:00 WIB<br/>
						</p>
					</div>	
				</div>

				<div class="row tmargin-10">
					<div class="col-lg-3">
						<img class="img-fluid tmargin-10" src="img/banks/bni.png">
					</div>
					<div class="col-lg-9 lpadding-10 tmargin-10">
						<p class="dark-gray fs-11" style="border:none;">
							Senin - Minggu	: 00:00 - 02:30 WIB<br/>
						</p>
					</div>	
				</div>

				<div class="row tmargin-10">
					<div class="col-lg-3">
						<img class="img-fluid tmargin-10" src="img/banks/bri.png">
					</div>
					<div class="col-lg-9 lpadding-10 tmargin-10">
						<p class="dark-gray fs-11" style="border:none;">
							Senin - Minggu	: 21:00 - 05:30 WIB
						</p>
					</div>	
				</div>
				<div class="row tmargin-10">
					<div class="col-lg-3">
						<img class="img-fluid tmargin-10" src="img/banks/cimb.png">
					</div>
					<div class="col-lg-9 lpadding-10 tmargin-10">
						<p class="dark-gray fs-11" style="border:none;">
							Tidak Ada Offline
						</p>
					</div>	
				</div>
			</div>

			<div style="padding-bottom: 75px;"></div>

		</div>

	<?PHP
		}
	?>
	
</div>

<script type="text/javascript">
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
	})

    $( "#data-bank" ).change(function() {
        var isi = $(this).val();
        var res = isi.split(",");
        var bnlink = $(this).find('option:selected').attr('dt-link');
		$('.nores').hide();

        if( res[0] ){
            $(".bank-detail").css('display', 'block');
            $(".elogin").css('display', 'block');
            if(res[0] == 'CIMB') $('.dimg').attr('class', 'col-lg-5 col-lg-offset-2 dimg');
            else $('.dimg').attr('class', 'col-lg-3 col-lg-offset-2 dimg');
            $('.elogin').attr('href', bnlink);
            $('.elogin').attr('id', 'btn-' + res[0].toLowerCase());
            $('.elogin img').attr('src', 'img/banks/'+ res[0].toLowerCase()+' - blue.png');
			if(res[0] == "BRI" || res[0] == "CIMB"){
				$('.nores').show();
			}
        }else{
            $(".bank-detail").css('display', 'none');
            $(".elogin").css('display', 'none');
        }

        $( "#bkil" ).html( res[0] );
        $( "#nare" ).html( res[2] );
        $( "#nore" ).html( res[1] );
    });

	$( ".deploy-toggle-1" ).click(function() {
		if ( $('.toggle-content').css('display') != 'block' ) {
			$('.btn-up').css('display', 'block');
			$('.btn-down').css('display', 'none');
		}else{
			$('.btn-up').css('display', 'none');
			$('.btn-down').css('display', 'block');		
		}
	});

	function tabs_1(){
		document.getElementById('tabs-2-content').style.display = 'none';
	}

	function tabs_2(){
		document.getElementById('tabs-2-content').style.display = 'block';
	}

	document.getElementById("copy-to").addEventListener("click", function() {
		var _targetcopy = document.getElementById("nore").innerHTML;
		var _rescopy = _targetcopy.split("-");
		var _finalres = "";

		for(var a=0; a < _rescopy.length; a++){
			_finalres += _rescopy[a];
		}

		document.getElementById("finalcopy").innerHTML = _finalres;

	    copyToClipboard(document.getElementById("finalcopy"));
	});

	function copyToClipboard(elem) {
		  // create hidden text element, if it doesn't already exist
	    var targetId = "_hiddenCopyText_";
	    var isInput = elem.tagName === "INPUT" || elem.tagName === "TEXTAREA";
	    var origSelectionStart, origSelectionEnd;
	    if (isInput) {
	        // can just use the original source element for the selection and copy
	        target = elem;
	        origSelectionStart = elem.selectionStart;
	        origSelectionEnd = elem.selectionEnd;
	    } else {
	        // must use a temporary form element for the selection and copy
	        target = document.getElementById(targetId);
	        if (!target) {
	            var target = document.createElement("textarea");
	            target.style.position = "absolute";
	            target.style.left = "-9999px";
	            target.style.top = "0";
	            target.id = targetId;
	            document.body.appendChild(target);
	        }
	        target.textContent = elem.textContent;
	    }
	    // select the content
	    var currentFocus = document.activeElement;
	    target.focus();
	    target.setSelectionRange(0, target.value.length);
	    
	    // copy the selection
	    var succeed;
	    try {
	    	  succeed = document.execCommand("copy");
	    } catch(e) {
	        succeed = false;
	    }
	    // restore original focus
	    if (currentFocus && typeof currentFocus.focus === "function") {
	        currentFocus.focus();
	    }
	    
	    if (isInput) {
	        // restore prior selection
	        elem.setSelectionRange(origSelectionStart, origSelectionEnd);
	    } else {
	        // clear temporary content
	        target.textContent = "";
	    }
	    return succeed;
	}
	
	
	
	$( document ).ready(function() {
        var isi = $("#data-bank" ).val();
        var res = isi.split(",");
        var bnlink = $(this).find('option:selected').attr('dt-link');
		$('.nores').hide();

        if( res[0] ){
            $(".bank-detail").css('display', 'block');
            $(".elogin").css('display', 'block');
            if(res[0] == 'CIMB') $('.dimg').attr('class', 'col-lg-5 col-lg-offset-2 dimg');
            else $('.dimg').attr('class', 'col-lg-3 col-lg-offset-2 dimg');
            $('.elogin').attr('href', bnlink);
            $('.elogin').attr('id', 'btn-' + res[0].toLowerCase());
            $('.elogin img').attr('src', 'img/banks/'+ res[0].toLowerCase()+' - blue.png');
			if(res[0] == "BRI" || res[0] == "CIMB"){
				$('.nores').show();
			}
        }else{
            $(".bank-detail").css('display', 'none');
            $(".elogin").css('display', 'none');
        }

        $( "#bkil" ).html( res[0] );
        $( "#nare" ).html( res[2] );
        $( "#nore" ).html( res[1] );
	});
</script>

<?PHP 
	if(strtoupper($link_img) == "IO"){ 
		$color1 = "#e6fdff";
		$color2 = "#2eb9ca";
	}elseif($link_img == "PTKP"){ 
		$color1 = "#f1f1f1";
		$color2 = "#992027";
	}else{ 
		$color1 = "#f1f1f1";
		$color2 = "#402573";
	} 
?>
<style type="text/css">
	#referral{
		border:none !important;
		padding: 0px !important;
	}
	#referral .ui-widget-header{
		border:none;
		background:<?PHP echo $color1;?>;
		border-radius: 0px;
	}
	.ui-tabs .ui-tabs-nav li {
		width:45%;
		margin-left:.5%;
		margin-right:.5%;
		text-align: center;
	}
	.ui-tabs .ui-tabs-nav li:first-child{
		margin-left:4%;
	}
	.ui-tabs .ui-tabs-nav li:last-child{
		margin-right:4%;
	}
	.ui-tabs .ui-tabs-nav li a {
		display: inline-block;
		float: none;
		padding: 6px;
		text-decoration: none;
		width: 100%;
		font-weight: normal;

	}
	.ui-tabs .ui-tabs-nav{
		padding: 0px;

	}
	.ui-corner-all, .ui-corner-top, .ui-corner-right, .ui-corner-tr{
		border:none;
	}
	.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default{
		background: #35353f;
		border:#35353f;

	}
	.ui-tabs .ui-tabs-nav li.ui-tabs-active{
		background: <?PHP echo $color2;?>;
		color:#fff;
	}
	.ui-tabs .ui-tabs-nav li.ui-tabs-active > a{
		color:#fff;
	}
	.ui-tabs .ui-tabs-panel{
		background: <?PHP echo $color1;?>;
		padding: 0px;
	}
</style>

<?php include ("_footer.php");?>