<?php
$page='akun';
include("_metax.php");
include("_header.php");

// get history
$reqAPITransHist = array(
    "auth"     => $authapi,
    "userid" 	=> $login,
    "type"		=> 5,
);

$respTransHis = sendAPI($url_Api."/history",$reqAPITransHist,'JSON','02e97eddc9524a1e');
$iplist = getUserIP2().','.getUserIP2('HTTP_CLIENT_IP').','.getUserIP2('HTTP_X_FORWARDED_FOR').','.getUserIP2('REMOTE_ADDR');

if($_POST["ubahpass"]){
	$uname  = $login;
	$old	= $_POST["old"];
	$new1	= $_POST["new1"];
	$new2	= $_POST["new2"];
    $rek    = $_POST['rek'];
    $capt	= $_POST["capt"];

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
            'bano'      => $rek,
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

if(strtoupper($link_img) == "IO"){ $warna = "bg-blue-panel"; }elseif($link_img == "PTKP"){ $warna = "bg-red-panel"; }else{ $warna = "bg-purple";}
?>

<div class="content" data-page="account">
	<!-- <div class="top-banner bg-light-gray" style="background:#6f6f6f">
		<h1>BANNER 640X100</h1>
	</div> -->
	<div style="height: 2px;"></div>
	<div class="row">	
		<a href="#" class="fs-normal deploy-toggle-1 toggle-design <?PHP echo $warna; ?>">
			<div class="row">
				<div class="col-lg-1 tpadding-5">
					<i class="fa fa-vip-white fa-2x white"></i>
				</div>
				<div class="col-lg-11 tpadding-5 fs-13 white">
					AKUN SAYA
				</div>
			</div>
		</a>
		<div class="toggle-content akun-saya" style="display: block; background-color: #26272c !important;">
			<div class="row  rpadding-15 lpadding-20 tpadding-10 bpadding-10">
				<div class="col-lg-1 tpadding-5">
					<i class="fa fa-user-white fa-2x"></i>
				</div>
				<div class="col-lg-11 tpadding-5 fs-13 light-gray">
					<?php echo $_SESSION["login"]; ?>
				</div>
			</div>

			<div class="row  rpadding-15 lpadding-20 tpadding-10 bpadding-10">
				<div class="col-lg-1 tpadding-5">
					<i class="fa fa-8balls-white fa-2x"></i>
				</div>
				<div class="col-lg-11 tpadding-5 fs-13 yellow">
					IDR <?php echo number_format($coin); ?>
				</div>
			</div>
			
			<div class="row  rpadding-15 lpadding-20 tpadding-10 bpadding-10">
				<div class="col-lg-1 tpadding-5">
					<i class="fa fa-code white" style="font-size:15px;"></i>
				</div>
				<div class="col-lg-11 tpadding-5 fs-13 yellow">
					<?php echo $authcode; ?>
				</div>
			</div>

			<div class="row  rpadding-15 lpadding-20 tpadding-10">
				<div class="col-lg-1 tpadding-5">
					<i class="fa fa-seal-white fa-2x white"></i>
				</div>
				<div class="col-lg-11 tpadding-5 fs-13 light-gray bmargin-5">
					<div class="col-lg-4">
						<?php echo number_format($poin); ?>
					</div>
					<div class="col-lg-6" style="margin-top:-5px">
						<a class="btn btn-mini btn-orange center tpadding-3 tmargin-2" href="https://www.koin88.com/do-game-connect?id=1009&userid=<?php echo $user_login ?>&authcode=<?php echo $authcode;?>">Aktivasi</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div style="height: 2px;"></div>

	<div class="row">
		<a href="#" class="fs-normal deploy-toggle-1 toggle-design <?PHP echo $warna; ?>">
			<div class="row">
				<div class="col-lg-1 tpadding-5">
					<i class="fa fa-cog-b fa-2x white"></i>
				</div>
				<div class="col-lg-11 tpadding-5 fs-13 white">
					UBAH PASSWORD
				</div>
			</div>
		</a>
		<div class="toggle-content ubah-password" style="display: none;">
			<div class="row  rpadding-15 lpadding-20 tpadding-10 bpadding-10">
				<form method='POST'>
					<?php 
					if ($errorReport){
						?>
						<div class="alert alert-danger padding-15" align="center" style="background-color: #c0392b; color: #fff;">
							<?php
							echo $errorReport;
							?>
						</div>
						<?php
					}
					if ($successRegister){
						?>
						<div class="alert alert-success padding-15" align="center" style="background-color: #27ae60; color: #fff;">
							<?php
							echo $successRegister;
							?>
						</div>
						<?php
					}
					?>

					<label class="black">Password Lama</label>
					<div class="row bpadding-5">
						<input class="form-control bg-light-gray" type="password" id="old" name="old" />
					</div>

					<label class="black">Password Baru</label>
					<div class="row bpadding-5">
						<input class="form-control bg-light-gray" type="password" id="new1" name="new1" />
					</div>

					<label class="black">Konfirmasi Password Baru</label>
					<div class="row bpadding-5">
						<input class="form-control bg-light-gray" type="password" id="new2" name="new2" />
					</div>

					<label class="black">4 digit di belakang rekening
						<?php echo $bankaccnodis; ?> &nbsp;
					</label>
					<div class="row bpadding-5">
						<input class="form-control bg-light-gray" type="password" id="rek" name="rek" maxlength="4" onkeypress='if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }' />
					</div>

					<label class="black">Validasi</label>
					<div class="row bpadding-5">
						<div class="col-lg-7 tmargin-5">
							<input class="form-control bg-light-gray" type="text" id="capt" name="capt" maxlength="5" />				
						</div>
						<div class="col-lg-5 tpadding-7 lpadding-5">
							<img src='../captcha/captcha.php?.png' alt='CAPTCHA' width='100%' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">				
						</div>
					</div>

					<div class="row padding-15">
						<input class="btn btn-green fs-normal" type="submit" value="UBAH" name="ubahpass" />
					</div>
				</form>		
			</div>
		</div>
	</div>
	<div style="height: 2px;"></div>

	<div class="row">
		<a href="#" class="fs-normal deploy-toggle-1 toggle-design <?PHP echo $warna; ?>">
			<div class="row">
				<div class="col-lg-1 tpadding-5">
					<i class="fa fa-deposit" style="color: #fff !important;"></i>
				</div>
				<div class="col-lg-11 tpadding-5 fs-13 white">
					HISTORY DEPOSIT
				</div>
			</div>
		</a>
		<div class="toggle-content history-deposit" style="display: none;">
			<div class="row bpadding-10" style="max-height: 300px; overflow: scroll;">
				<table class="table" cellspacing="0" cellpadding="0" border="0" id="table-lobby">
					<thead>
						<tr>
							<th>#</th>
							<th>Rekening Bank</th>
							<th>Jumlah Deposit</th>
							<th>Tanggal Deposit </th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
                    <?php
                    $no=1;
                    if (count($respTransHis->dpp) > 0){
                        $fetch_depositPending = $respTransHis->dpp[0];
                        $date = strtotime($fetch_depositPending->date1);
                        $rekNo = substr(str_replace('-', '', $fetch_depositPending->rek), 0,-4) . 'xxxx';
                        $rekDis = bank_format($rekNo, $fetch_depositPending->bank);
                        echo "
                            <tr>
                                <td align='center' height='23'>".$no++."</td>
                                <td>".$rekDis." -- ".$fetch_depositPending->bank."</td>
                                <td>IDR ".number_format($fetch_depositPending->amount)."</td>
                                <td>".date("d/m  H:i", $date)."</td>
                                <td align='center'>Proccess</td>
                            </tr>";
                    }

                    foreach ($respTransHis->dph as $depositHist){
                        $date = strtotime($depositHist->date2);
                        $rekNo = substr(str_replace('-', '', $depositHist->rek), 0,-4) . 'xxxx';
                        $rekDis = bank_format($rekNo, $depositHist->bank);
                        echo "
                                <tr>
                                    <td align='center' height='23'>".$no++."</td>
                                    <td>".$rekDis." -- ".$depositHist->bank."</td>
                                    <td>IDR ".number_format($depositHist->amount)."</td>
                                    <td>".date("d/m  H:i", $date)."</td>
                                    <td align='center'>" . $depositHist->status . "</td>
                                </tr>";
                    }
                    ?>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4" align="right" style="color:black;"><b>Jumlah:</b></td>
							<td style="color:black;"><span><b><?php echo count($respTransHis->dph) ?></b></span></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
	<div style="height: 2px;"></div>

	<div class="row">
		<a href="#" class="fs-normal deploy-toggle-1 toggle-design <?PHP echo $warna; ?>">
			<div class="row">
				<div class="col-lg-1 tpadding-5">
					<i class="fa fa-withdraw-white fa-2x"></i>
				</div>
				<div class="col-lg-11 tpadding-5 fs-13 white">
					HISTORY WITHDRAW
				</div>
			</div>
		</a>
		<div class="toggle-content history-withdraw" style="display: none;">
			<div class="row bpadding-10" style="max-height: 300px; overflow: scroll;">
				<table class="table" cellspacing="0" cellpadding="0" border="0" id="table-lobby">
					<thead>
						<tr>
							<th>#</th>
							<th>Rekening Bank</th>
							<th>Jumlah Deposit</th>
							<th>Tanggal Deposit </th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
                    <?php
                    $no = 1;

                    foreach ($respTransHis->wdp as $fetch_withdrawPending){
                        $date = strtotime($fetch_withdrawPending->date1);
                        $rekNo = substr(str_replace('-', '', $fetch_withdrawPending->rek), 0,-4) . 'xxxx';
                        $rekDis = bank_format($rekNo, $fetch_withdrawPending->bank);
                        echo "
                                <tr>
                                    <td align='center' height='23'>".$no++."</td>
                                    <td>".$rekDis." -- ".$fetch_withdrawPending->bank."</td>
                                    <td>IDR ".number_format($fetch_withdrawPending->amount)."</td>
                                    <td>".date("d/m  H:i", $date)."</td>
                                    <td align='center'>Proccess</td>
                                </tr>";
                    }

                    foreach ($respTransHis->wdh as $withdrawHist){
                        $date = strtotime($withdrawHist->date2);
                        $rekNo = substr(str_replace('-', '', $withdrawHist->rek), 0,-4) . 'xxxx';
                        $rekDis = bank_format($rekNo, $withdrawHist->bank);
                        echo "
                                <tr>
                                    <td align='center' height='23'>".$no++."</td>
                                    <td>".$rekDis." -- ".$withdrawHist->bank."</td>
                                    <td>IDR ".number_format($withdrawHist->amount)."</td>
                                    <td>".date("d/m  H:i", $date)."</td>
                                    <td align='center'>" . $withdrawHist->status . "</td>
                                </tr>";
                    }
                    ?>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4" align="right" style="color:black;"><b>Jumlah:</b></td>
							<td style="color:black;"><span><b><?php echo count($respTransHis->wdh) ?></b></span></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
	<div style="height: 2px;"></div>

	<div class="row">
		<a href="#" class="fs-normal deploy-toggle-1 toggle-design <?PHP echo $warna; ?>">
			<div class="row">
				<div class="col-lg-1 tpadding-5">
					<i class="fa fa-document-white fa-2x"></i>
				</div>
				<div class="col-lg-11 tpadding-5 fs-13 white">
					HISTORY PERMAINAN
				</div>
			</div>
		</a>
		<div class="toggle-content history-permainan" style="display: none;">
			<div class="row bpadding-10" style="max-height: 300px; overflow: scroll;">
				<table class="table" cellspacing="0" cellpadding="0" border="0">
					<thead>
						<tr>
							<td>Tanggal</td>
							<td>Deposit</td>
							<td>Withdraw</td>
							<td>Winlose</td>
						</tr>
					</thead>

					<tbody>
                    <?php
                    $totalDepo = $totalWD = $totalWinLose = 0;
                    foreach($respTransHis->gmh as $report){
                        $totalDepo += $report->deposit;
                        $totalWD += $report->withdraw;
                        $totalWinLose += $report->winlose;
                        ?>

                        <tr>
                            <td><?php echo $report->date1;?></td>
                            <td><?php echo number_format($report->deposit);?></td>
                            <td><?php echo number_format($report->withdraw);?></td>
                            <td style='color:<?php $report->color;?>'><?php echo number_format($report->winlose);?></td>
                        </tr>

                        <?php
                    }
                    ?>
					</tbody>

					<tfoot>
						<tr>
							<td style="color:black;"><b>Total:</b></td>
							<td style="color:black;"><b><?php echo $transDays->totaldepo;?></b></td>
							<td style="color:black;"><b><?php echo $transDays->totalwd;?></b></td>
							<td style='color:black;'><b><?php echo $transDays->totalwinlose;?></b></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>

</div>

<script type="text/javascript">
	$('.deploy-toggle-1').click(function(){

		if( $(".deploy-toggle-1").siblings().css('display', 'none') ){
			$("[style='display:block;']").css('display', 'block');
		}

	});
</script>

<?PHP include '_footer.php'; ?>