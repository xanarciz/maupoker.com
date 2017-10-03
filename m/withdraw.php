<?php
$page='withdraw';
session_start();
$login = $_SESSION["login"];

if (!$login){
	include("_meta.php");
} else {
	include("_metax.php");
	if($status_bank == 0) {
		echo "<script>window.location = 'bank-setting.php'</script>";
		$_SESSION['urlPrev'] = 'withdraw.php';
		die();
	}

}
include("_header.php");

if($login) {
    $reqAPILastOrder = array(
        "auth"   => $authapi,
        "userid" => $login,
        "agent"  => $agentwlable,
        "curr"   => $curr,
        "bankgroup" => $bankgroup,
        "minutes"=> 1
    );
    $transaction = sendAPI($url_Api . "/transaction", $reqAPILastOrder, 'JSON', '02e97eddc9524a1e');
    $minwit = $transaction->min_wdraw;
    $maxwit = $transaction->max_wdraw;

    $error = 0;
    if ($transaction->msg != 'OK') {
        $errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>" . $transaction->msg . "</p></div>";
        $error = 1;
    }

    if ($q_maintenance == "1") {
         $success_withdraw = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Connection Time out.</p></div>";
        $error = 1;
    }
    if ($status_block == 2 || $status_block == 3) {
        $success_withdraw = "
            <div class='static-notification-red tap-dismiss-notification'>
                <p class='center-text uppercase'>Account anda masi dalam proses validasi.<br>Anda hanya bisa mengakses menu MEMO.</p>
            </div>";
        $error = 1;
    } else if ($status_block == 4) {
        $success_withdraw = "
            <div class='static-notification-red tap-dismiss-notification'>
                <p class='center-text uppercase'>Account anda Bermasalah.<br> Harap hubungi customer support kami.</p>
            </div>";
        $error = 1;
    } else if ($status_block == 5) {
        $success_withdraw = "
            <div class='static-notification-red tap-dismiss-notification'>
                <p class='center-text uppercase'>Account anda masih dalam proses lupa password<br>sementara anda hanya bisa mengakses menu MEMO</p>
            </div>";
        $error = 1;
    }

    if ($error == 0) {
        if ($_POST["submit"]) {
            $name = $login;
            $amount = str_replace('.', '', $_POST["amount"]);
            $pass = $_POST["pass"];
            $error = 0;

            $reqAPIRegister = array(
                "auth"  => $authapi,
                "webid" => $subwebid,
                "act"   => 2,
                "agent" => $agentwlable,
                "userid"=> strtoupper($name),
                "amount"=> $amount,
                "bankaccname" => $bankaccname,
                "bankaccno"=> $bankaccno,
                "bankname" => $bankname,
                "banktuj"  => "",
                "rektuj"   => "",
                "firstdepo"=> "",
                "password" => $pass,
                "minutes"  => 1,
                "device"  => $device,
            );

            $response = sendAPI($url_Api . "/cashier", $reqAPIRegister, 'JSON', '02e97eddc9524a1e');
            if ($response->status == 200) {
                $success_withdraw = "
                    <div class='big-notification green-notification'>
                        <h3 class='uppercase'>Withdraw Berhasil</h3>
                        <a href='#' class='close-big-notification'>x</a>
                        <p>Permintaan withdraw anda akan di proses dalam 1x24 jam.</p>
                    </div>";
            } else {
                $error = 1;
                $errorReport = ("<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'><strong>Withdraw gagal!</strong> " . $response->msg . "</p></div>");
            }
        }
    }
}
?>

<div class="content-2" data-id="withdraw" id="page">
	<div class="lpadding-15 tpadding-5">
		<label class="fs-13 tmargin-10 ntf"><?PHP if($_SESSION["login"]) echo "FORM "; ?>WITHDRAW</label>
	</div>

	<?php
		if($_SESSION["login"]){
			if ($success_withdraw){
				echo $success_withdraw;
			}else{
				if ($error == 1){
					echo $errorReport;
				}
	?>

	<hr class="margin-0 bg-brown-panel" style="margin: 0px -15px 0px -15px;" />
	<form method="post" class="padding-10">

		<div class="row margin0">
			<div class="col-lg-4">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10">USER ID</label>
			</div>
			<div class="col-lg-1">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
			</div>
			<div class="col-lg-7">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> <?php echo $login; ?> </label>
			</div>
		</div>
		<div class="row margin0">
			<div class="col-lg-4">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10">CHIPS</label>
			</div>
			<div class="col-lg-1">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
			</div>
			<div class="col-lg-7">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> IDR <?php echo number_format($coin);?> </label>
			</div>
		</div>

		<label class="black fs-13 pull-left tmargin-10">Jumlah Penarikan</label>
		<div class="row">
			<div class="col-lg-11">
				<input type="tel" class="form-control bg-light-gray" name="ui_amount" id="ui_amount" placeholder="Masukan jumlah penarikan dana" onkeyup="this.value=this.value.replace(/[^0-9.,]/g,'');" onblur="this.value=this.value.replace(/[^0-9.,]/g,'');" onKeypress="if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }" />
				<input type="hidden" name="amount" id="amount"/>
			</div>
			<div class="col-lg-1 text-left">
				<label class="black tmargin-10 lmargin-5">IDR</label>
			</div>
		</div>
		<div class="row">
			<label class="black fs-13 fs-normal  tmargin-10">Password</label>
			<input class="form-control bg-light-gray" type="password" name="pass" id="pass" placeholder="Masukan Password Login Anda" />
		</div>

		<div class="row margin0">
			<label class="black fs-13 text-left tmargin-10">Dana akan di kirim ke:</label>
			<div class="col-lg-4">
				<label class="black fs-13 fs-normal tmargin-10">Nama Bank</label>
			</div>
			<div class="col-lg-1 ">
				<label class="black fs-13 fs-normal tmargin-10"> : </label>
			</div>
			<div class="col-lg-7">
				<label class="black fs-13 fs-normal tmargin-10"> <?php echo $bankname;?> </label>
			</div>
		</div>

		<div class="row margin0">
			<div class="col-lg-4">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10">Nama Rekening</label>
			</div>
			<div class="col-lg-1">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
			</div>
			<div class="col-lg-7">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> <?php echo $bankaccname;?> </label>
			</div>
		</div>

		<div class="row margin0">
			<div class="col-lg-4">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10">Nomor Rekening</label>
			</div>
			<div class="col-lg-1">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10"> : </label>
			</div>
			<div class="col-lg-7">
				<label class="black fs-13 fs-normal bmargin-5 tmargin-10">
					<?php echo $bankaccnodis; ?>
				</label>
			</div>
			
		</div>

		<div class="row">
			<input class="btn btn-gray tmargin-10 bmargin-5" value="BATAL" type="button" onclick="location.href='index.php'" />
		</div>
		<div class="row">
			<input class="btn btn-blue tmargin-5 bmargin-10" value="KONFIRMASI" type="submit" name="submit" />
		</div>
		<ol class="black">
			<li class="margin-0">Minimal Tarik Dana = <?php echo $minwit; ?>,00 IDR .</li>
			<li class="margin-0">Penarikan dana hanya akan di proses ke rekening yang pertama kali di daftarkan. </li>
			<li class="margin-0">Setelah proses pengisian form Penarikan dana selesai maka pengiriman dana akan di proses secepatnya ke dalam rekening terdaftar anda. </li>
			<li class="margin-0">etelah melakukan proses pengiriman dan mengisi form secara benar maka Withdraw anda akan di proses dalam kurun waktu 5 menit. </li>
			<li class="margin-0">Silahkan hubungin customer service kami via live chat untuk konfirmasi status penarikan dana anda. </li>
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

	</form>


	<script language="JavaScript" type="text/javascript">
		$( ".deploy-toggle-1" ).click(function() {
			if ( $('.toggle-content').css('display') != 'block' ) {
				$('.btn-up').css('display', 'block');
				$('.btn-down').css('display', 'none');
			}else{
				$('.btn-up').css('display', 'none');
				$('.btn-down').css('display', 'block');		
			}
		});
	</script>

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
					<p class="fs-bold"> Silahkan LOGIN terlebih dahulu
						untuk melalukan withdraw</p>
				</div>

				<hr class="margin-0 bmargin-5">
				<ol>
					<li class="margin-0">Penarikan Dana hanya akan di proses ke rekening yang pertama Anda daftarkan.</li>
					<li class="margin-0">Minimum penarikan dana Rp<?php echo $minwit; ?></li>
					<li class="margin-0">Setelah melakukan pengisian form withdraw dengan benar, maka penarikan dana akan di proses secepetnya ke rekening terdaftar Anda.</li>
				</ol>
			</div>
		</div>

		<label class="ntf fs-13">
			Metode Withdraw Bank:
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

		<!--
		<label class="ntf fs-13">
			Metode Withdraw Alternatif:
		</label>
		<div class="row tmargin-5 bmargin-15">
			<div class="col-lg-5">
				<img class="img-fluid" src="img/banks/v88.png"/>
			</div>
		</div>
		-->

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


	<?PHP
		}
	?>
		<div style="padding-bottom: 75px;"></div>
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
</script>

<?php include ("_footer.php"); ?>