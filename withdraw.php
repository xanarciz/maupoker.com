<?php
$freePage=true;
include("meta.php");
include("header.php");

if (!$_SESSION["login"]){
	$flag = 'withdraw';
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
    "minutes"   => 1,
    "act"   	=> 2
);
$transaction = sendAPI($url_Api."/transaction",$reqAPILastOrder,'JSON','02e97eddc9524a1e');

if ($transaction->msg != 'OK'){
    $errorReport = "<div class='error-report'>".$transaction->msg."</div>";
    $err = 1;
}

if($status_bank == 0) {
    $_SESSION['urlPrev'] = 'withdraw.php';
    echo "<script>window.location = 'bank-setting.php'</script>";
    die();
}

$defaultOpen = 0;

	if ($_POST["submit"]) {
		$name		= $login;
		//$amount		= substr(str_replace('.','',$_POST["amount"]),4);
		$amount		= $_POST["amount"];
		$pass		= $_POST["pass"];
		$capt		= $_POST["captcha"];
		$bankacc	= $bankaccname;
		$rek		= $bankaccno;
		$error = 0;
		
		
		if($capt == ''){
			$errorReport = ("<strong>Withdraw gagal!</strong> Captcha harus diisi");
		}else if(!checkCaptcha('CAPTCHAString', $capt)){
			$errorReport = ("<strong>Withdraw gagal!</strong> Captcha tidak sama");
		}else{
		
			$reqAPIRegister = array(
				"auth"       => $authapi,
				"webid"      => $subwebid,
				"act"		 => 2,
				"agent"		 => $agentwlable,
				"userid"     => strtoupper($name),
				"amount"     => $amount,
				"bankaccname"=> $bankaccname,
				"bankaccno"  => $bankaccno,
				"bankname" 	 => $bankname,
				"banktuj" 	 => "",
				"rektuj" 	 => "",
				"firstdepo"  => "",
				"password"   => $pass,
                "minutes"    => 1,
				"device"	 => $device
			);

			$response = sendAPI($url_Api."/cashier",$reqAPIRegister,'JSON','02e97eddc9524a1e');
			if($response->status == 200){
                $success_withdraw = "<div class='error-report'>Withdraw Berhasil.<br> Permintaan withdraw anda akan di proses dalam 1x24 jam .</div>";
                echo"<BR>";
                echo "<script src=\"https://d3qycynbsy5rsn.cloudfront.net/OptiRealApi-1.1.0.js\" type=\"text/javascript\"></script>";
                echo "<script>
                        $(document).ready(function(){
                            OptiRealApi.reportEvent(9, null, '" . $login . "', \"7ae87a05e42bd455d041884a1f62da6a30bc2ff5a20dc47e8b12620cf82066bc\");
                        });
		             </script>";
			}else{
				$errorReport =	("<strong>Withdraw gagal!</strong> " . $response->msg);
			}
		}
		
	}
?>

<script language="JavaScript" type="text/javascript">
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
	});

</script>

<style>
	ul.tabs {
		list-style-type: none;
		margin: 0;
		padding: 0;
		overflow: hidden;
	}

	/* Float the list items side by side */
	ul.tabs li {
		float: left;
		background: #848484;
		margin: 3px;
		border-top-right-radius: 5px;
		border-top-left-radius: 5px;
	}

	/* Style the links inside the list items */
	ul.tabs li a {
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
	ul.tabs li a:hover {
		background-color: #ddd;
		border-top-right-radius: 5px;
		border-top-left-radius: 5px;
	}

	/* Create an active/current tablink class */
	ul.tabs li a:focus, .active {
		background-color: #13adb0;
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
		font-weight: normal;
		text-transform: none;
	}
	
	.control-label{
		font-family: Arial;
		color: #ddd;
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
						document.write("<iframe src="+j_withdraw+" width=800 height=700></iframe>");
					</script>
				<?php
				}else{
				?>
				<div class="head-wrap">
					<h1>Withdraw</h1>
				</div>

				<div class="body-wrap">
					<ul class="tabs">
						<li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'wdcontainer')" id="defaultOpen">Permintaan Withdraw</a></li>
						<li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'history')">History Withdraw</a></li>
					</ul>
					
					<div id="wdcontainer" class="tabcontent">
						<form class="form-horizontal" role="form" method="post">
						   <?php 
							if ($errorReport){
							?>
								<div class="alert alert-danger">
									<?php
									echo $errorReport;
									?>
								</div>
							<?php
							}else if ($success_withdraw){
							?>
								<div class="alert alert-success">
									<?php
									echo $success_withdraw;
									?>
								</div>
							<?php
							}
							?>

							<div class="form-group-full">
								<label class="col-lg-1 control-label">Saldo Terakhir Anda</label>
								<div class="col-lg-2">
									<div class="text-left bold pt7 normal"> : &nbsp;
									IDR <?php echo number_format(floor($coin), 0, '.', '.');?></div>
								</div>
							</div>

							<div class="form-group-full">
								<label class="col-lg-1 control-label">Password</label>
								<div class="col-lg-2"> : &nbsp;
									<input type="password" name="pass" id="pass" placeholder="Password Account Anda" class="form-control" style="width:96%;">
								</div>
							</div>
							
							<div class="form-group-full" align="left">
								<label class="col-lg-1 control-label">Jumlah Withdraw</label>
								<div class="col-lg-2"> : &nbsp;
									<input type="text" name="ui_amount" id="ui_amount" placeholder="Jumlah Withdraw" data-required="true" class="form-control" style="width:96%;" onkeyup="this.value=this.value.replace(/[^0-9.,]/g,'');" onblur="this.value=this.value.replace(/[^0-9.,]/g,'');" onKeypress="if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }"> <br>&nbsp;&nbsp;&nbsp;
									<font color="#dfbf61" size="2" style="font-style:italic;">
												*Minimal withdraw Rp <?php echo number_format ($transaction->minmaxDepo->min_wdraw, 0, '.', '.'); ?>, Maksimal withdraw Rp <?php echo number_format ($transaction->minmaxDepo->max_wdraw, 0, '.', '.'); ?></font>
									<input type="hidden" name="amount" id="amount" placeholder="Jumlah Withdraw" data-required="true" class="form-control" style="width:96%;">
								</div>
							</div>
							
							<br>
							<div class="form-group-full">
								<label class="col-lg-3 control-label-header" style="font-size: 14px;">Dana akan dikirim ke rekening yang terdaftar di bawah ini:</label>
							</div>

							<div class="form-group-full">
								<label class="col-lg-1 control-label">Data Bank Anda</label>
								<div class="col-lg-2">
									<div class="text-left bold pt7 normal"> : &nbsp; <?php echo $bankname." / ".strtoupper($bankaccname)." / ".substr(strtoupper($bankaccno),0,8)."XXXX";?></div>
								</div>
							</div>

							<div class="form-group-full">
								<label class="col-lg-1 control-label">Validasi</label>
								<div class="col-lg-3"> : &nbsp;
									<input type="text" name="captcha" placeholder="Validation" data-required="true" class="form-control" style="width: 200px;">
									<img src='captcha/captcha.php?.png?a=1' alt='CAPTCHA' class="form-captcha" style="float: right; margin-left: 10px;"/>   
								</div>
							</div>
							<div class="line m-t-large"></div>
							<div class="space_10"></div>
							

							<div class="form-group-full">
								<button type="submit" name="submit" value="submit" class="btn btn-submit">Kirim</button>
							</div>
						</form>
					</div>
					
					<div id="history" class="tabcontent">
						<br>
						<div id="table_list">
						<?php
						// get history
						$reqAPITransHist = array(
							"auth"      => $authapi,
							"userid" 	=> $login,
							"type"		=> 2,
						);

						$respTransHis = sendAPI($url_Api."/history",$reqAPITransHist,'JSON','02e97eddc9524a1e');

						$errorReport2 = '';
						if($respTransHis->status != 200){
							echo "<div class='alert alert-danger' style='margin-left: 0px;'>" . $respTransHis->msg . "</div>";
						}
						?>
							<form onsubmit="submitfilter('', '#table_list', 'preloader'); return false;">
								<table width="100%" cellpadding="0" cellspacing="0" border="0" id="table" style="font-size:12px;">
									<thead align="left">
										<tr>
											<th align="center" height="23">#</th>
											<th>Rekening Bank</th>
											<th>Jumlah Withdraw</th>
											<th>Tanggal Withdraw</th>
											<th align="center">Status</th>
										</tr>
									</thead>

									<tbody align="left">
										<?php
										$no = 1;

										foreach ($respTransHis->wdp as $fetch_withdrawPending){
											$date = strtotime($fetch_withdrawPending->date1);
											$rekNo = substr(str_replace('-', '', $fetch_withdrawPending->rek), 0,-4) . 'xxxx';
											$rekDis = bank_format($rekNo, $fetch_withdrawPending->bank);
											echo "
												<tr>
													<td align='center' height='23'>".$no++."</td>
													<td>".$rekDis."<br />".$fetch_withdrawPending->bank."</td>
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
													<td>".$rekDis."<br />".$withdrawHist->bank."</td>
													<td>IDR ".number_format($withdrawHist->amount)."</td>
													<td>".date("d/m  H:i", $date)."</td>
													<td align='center'>" . $withdrawHist->status . "</td>
												</tr>";
										}
										?>
									</tbody>

									<tfoot>
										<tr>
											<td colspan="10">
												Jumlah: <b><?php echo ($no - 1)?></b>
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
				<?php } ?>
			</div>
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
</script>
			
<?php
include("footer.php");
?>