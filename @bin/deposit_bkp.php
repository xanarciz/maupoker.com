<?php
include("meta.php");
include("header.php");

function currx($val) {
   if (!strpos($val,".")) return number_format($val, 0,'.', ',');
   else return number_format($val, 1,'.', ',');
}
if (!$_SESSION["login"]){
	echo "<script>window.location = 'index.php'</script>";
	die();
}

$sql3 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid='".$login."' and bdate > dateadd(minute,-1,GETDATE())",$params,$options));	
if ($sql3 > 0){
	$success_deposit = "<div class='error-report'>Cannot deposit.<br>Don't enter the game and try again 1 minutes later </div>";
	 $err = 1;
}
$sql1 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select amount from a83adm_depositraw where userid='".$login."' and stat='0' AND act='1'"), SQLSRV_FETCH_ASSOC);
if ($sql1["amount"] > 0){
	 $success_deposit =  "<div class='error-report' >Tidak Dapat melakukan deposit,<br> anda masih memiliki 1 deposit yang sedang di proses</div>";
	 $err = 1;
}

//$sqlbank = mssql_fetch_array(mssql_query("select bankname, bankaccno, bankaccname, bankgrup from u6048user_id where userid ='".$login."'"));
$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select bankname, bankaccno, bankaccname, bankgrup,playerpt,xdeposit from u6048user_id where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
$bankname = $sqlu["bankname"];
$bankaccno = $sqlu["bankaccno"];
$bankaccname = $sqlu["bankaccname"];
$bankgrup = $sqlu["bankgrup"];
$playerpt	= $sqlu["playerpt"];
$xdepo = $sqlu["xdeposit"];
$sqlg = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select val from a83adm_config3 where name = 'xdeposit_pertama'"),SQLSRV_FETCH_ASSOC);

$xfirst = $sqlg["val"];
	$firstdepo = 1;

$sqlcektrans = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from a83adm_moneyhistory where userid = '".$login."'",$params,$options));
if ($sqlcektrans > 0) {
	$firstdepo = 0;
}else {
	$sqlcektrans2 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select userid from a83adm_deposit where userid = '".$login."'"));
	if ($sqlcektrans2 > 0) {
		$firstdepo = 0;
	}
}
$firstdepo = 1;

if ($xdepo > $xfirst) {
	$firstdepo = 0;
}
$firstdepo = 0;
$sqlmaxdepo = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select first_max_depo, max_depo from a83adm_config2"), SQLSRV_FETCH_ASSOC);
$maxdepo = $sqlmaxdepo["first_max_depo"];
$maxdepo2 = $sqlmaxdepo["max_depo"];
$q1	= sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select max_depo from u6048user_id where userid='".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
$maxdepo2 = $q1["max_depo"];
if ($_POST["submit"] && !$err) {

	$name = $login;
	$amount		= $_POST["amount"];
	$waktu		= $_POST["ttgl"]."-".$_POST["tmon"]."-".$_POST["tyear"];
	$accname1	= $bankaccname;
	$rek1		= $bankaccno;
	$bname1		= $bankname;
	$capt		= $_POST["captcha"];
	$time = date("d/m h:i");
	$remark = "Deposit";

	$databank = explode(",",$_POST["data-bank"]);
	$bname2		= $databank[0];
	$rek2		= $databank[1];
	$accname2	= $databank[2];
	$condition	= $databank[3];

	if ($remark == "Others")
		$remark = "Others";
	else
		$remark = "Deposit";
		
	$err = 0;
	
	$sqlm = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select maint from a83adm_config"), SQLSRV_FETCH_ASSOC);
	$maintenance = $sqlm["maint"];
	
	if ($maintenance == "1") {
		 $errorReport =  "<div class='error-report'>Connection Timeout.</div>";
		 $err = 1;
		 die();
	}

	if ($capt != $_SESSION['CAPTCHAString']){
		$errorReport =  "<div class='error-report'>Validasi anda salah.</div>";
		$err = 1;
	}else if ($amount == "" || $amount <= 0){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Isi Jumlah.</div>";
		$err = 1;
	}else if ($waktu == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Isi tanggal</div>";
		$err = 1;
	}else if ($time == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Isi waktu pengiriman</div>";
		$err = 1;
	}else if ($accname1 == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Isi nama account/div>";
		$err = 1;
	}else if ($rek1 == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Isi nomor rekening</div>";
		$err = 1;
	}else if ($bname1 == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Isi nama bank</div>";
		$err = 1;
	}else if ($bname2 == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Harap memilih bank tujuan</div>";
		$err = 1;
	}else if ($remark == ""){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>pilih keterangan.</div>";
		$err = 1;
	}else if ($firstdepo == 1){
		/*if ($amount > $maxdepo){
			$errorReport =  "<div class='error-report'>Deposit gagal<br>Maksimum Deposit adalah ".currx($maxdepo).".</div>";
			$err = 1;
		}*/
	}else if ($amount > $maxdepo2){
		$errorReport =  "<div class='error-report'>Deposit gagal<br>Maksimum adalah ".currx($maxdepo2).".</div>";
		$err = 1;
	}

	if ($amount > 0){
	}else{
		$errorReport =  "<div class='error-report'>Deposit gagal<br>isi jumlah deposit.</div>";
		$err = 1;
	}

	if ($err == 0) {
		$ket	= "From : ".$accname1." - ".$rek1." ( ".$bname1." ) <br>";
		//$ket = $remark;
		$tgl	= $waktu;
		
		$email=$sqlu["email"];
		$playerpt=$sqlu["playerpt"];
		if ($sqlu["status"] == 2){
			$errorReport =  "<div class='error-report'>Deposit gagal<br></div>";
			$err = 1;
		}

		$sql3	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select curr,userprefix from u6048user_data where userid = '".$name."'"), SQLSRV_FETCH_ASSOC);
		$curr=$sql3["curr"];
		$agent=$sql3["userprefix"];
		$playerpt=$sqlu["playerpt"];
		$kalikan = 1;
		
		if ($playerpt == "1"){
			$sql5	= "select min_wdraw from a83adm_config";
		}else{
			$sql5	= "select min_depo,max_depo,email from u6048user_id where userid='".$agent."'";
		}
		
		$sql6 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, $sql5), SQLSRV_FETCH_ASSOC);
		$mindep = $sql6["min_depo"];
		$maxdep = $sql6["max_depo"];
		
		if ($amount < $mindep) {
			$errorReport =  "<div class='error-report'>Deposit gagal<br> Minimal deposit = ".currx($mindep)."</div>";
			$err = 1;
		}
			if ($amount > $maxdep) {
			$errorReport =  "<div class='error-report'>Deposit gagal<br> Maksimal deposit = ".currx($maxdep)."</div>";
			$err = 1;
		}
		
		if ($err == 0) {
			$rek	= $rek1;
			$tp 	= '';
			$axx	= 0;
			$temp;
			for($i=0; $i<2; $i++){
				$temp	=  substr($rek, $axx, 4);
				if ($tp == ""){
					$tp	= $temp;
				}else{
					$tp	= $tp."-".$temp;
				}
				$axx = 4;
			}
			
			$panj	= strlen($rek);
			$temt	= substr($rek, 8, $panj);
			$rot	= $tp."-".$temt;
			
			$myDate1	= Date("d m y");
			$sekarang	= $myDate1;
			if ($playerpt == 1){
				$prefx = "ADMIN";
			}
			
			$mgrup = 0;
			$amountx = $amount;
			sqlsrv_query($sqlconn, "insert into a83adm_depositraw (act,userid,userprefix,date1,amount,ket,nama,bank,rek,stat,status,date2,banktuj,datesent,rektuj,playerpt,grup) values ('1','".$name."','".$agent."',GETDATE(),'".$amountx."','".$ket."','".sanitize($accname1)."','".$bname1."','".$rek1."','0','','','".$bname2."','".$tgl."','".$rek2."','".$playerpt."','".$mgrup."')");
			$success_deposit = "<div class='deposit-success-report'><strong>Deposit $amountx sukses.</strong><br><br>
				
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
		}
	}
	echo"<BR>";
}
$idb = $bankgrup;
$bankaccnox = substr($bankaccno,0,-4);
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
                                <p class="attention">HARAP SELALU MELIHAT REKENING AKTIF DI BANK TUJUAN SEBELUM TRANSFER DANA</p>

                                <div class="space_10"></div>

                                <form class="form-horizontal" role="form" method="POST">
                                    <label class="col-lg-1 control-label-header">Pengirim</label>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nama bank</label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7 normal">
											<?php echo strtoupper($bankname);?>
											<input type="hidden" name="bank" value="<?php echo $bankname;?>"
											</div>
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nama Rekening Bank</label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7 normal"><?php echo substr(strtoupper($bankaccname),0,4)."xxxx";?></div>
                                        </div>
                                    </div>

                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Nomor Rekening Bank</label>
                                        <div class="col-lg-2">
                                            <div class="text-left bold pt7 normal">
											<?php echo substr(strtoupper($bankaccno),0,8)."xxxx"; ?>
											<input type="hidden" name="bank_accno" value="<?php echo $bankaccno; ?>" />
											</div>
                                        </div>
                                    </div>
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Jumlah</label>
                                        <div class="col-lg-2">
                                            <input type="text" name="amount" placeholder="Jumlah Deposit" data-required="true" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Tanggal Kirim</label>
                                        <div class="col-lg-3">
										<?php
										$date = date("d");
										$month = date("M");
										$year = date("Y");
										?>
										<select name='ttgl'  class="form-control-small">
										<?php
										for ($d=1; $d<32; $d++){
											$select = "";
											if ($d == $date){
												$select ="selected";
											}
											echo "<option value='".$d."' ".$select.">".$d."</option>";
										}
										?>
										</select>&nbsp;<select name='tmon'  class="form-control-small">
										<?php
										$armon = Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
										for ($m=0; $m<12; $m++){
											$select = "";
											if ($armon[$m] == $month){
												$select ="selected";
											}
											echo "<option value='".$armon[$m]."' ".$select.">".$armon[$m]."</option>";

										}
										?>
										</select>&nbsp;<select name='tyear'  class="form-control-small">
										<?php
										$yearx = $year-1;
										for ($m=0; $m<3; $m++){
											$select = "";
											if ($yearx == $year){
												$select ="selected";
											}
											echo "<option value='".$yearx."' ".$select.">".$yearx."</option>";
											
											$yearx = $yearx+1;
										}
										?>
										</select>
                                        </div>
                                    </div>
                                    <div class="space_10"></div>
                                    <label class="col-lg-1 control-label-header">Tujuan</label>
									<div class="col-bank">
									<table>
									<?php
										if ($playerpt == 1){
											$sql2	= sqlsrv_query($sqlconn, "select bank, bankaccno, bankaccname,status from a83adm_configbank where (code = 'Company' or code = 'COMPANY' or code = 'company') and (curr = 'IDR') and idx='".$idb."' order by status asc, id asc",$params,$options);
										}else if ($playerpt	== 0){
											$q		= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userprefix from u6048user_data where userid = '".$login."'"), SQLSRV_FETCH_ASSOC);
											$userx		= $q["userprefix"];
											$sql2		= sqlsrv_query($sqlconn, "select bank, bankaccno, bankaccname,status from a83adm_configbank where code = '".$userx."' and idx ='".$idb."' and (curr = 'IDR')",$params,$options); 
										}
										$sql2test = "select bank, bankaccno, bankaccname,status from a83adm_configbank where code = '".$userx."' and idx ='".$idb."' and (curr = 'IDR')";
// if ($login=="LIVEGOO"){
// EXIT($sql2test);
// }
										
										$jumbank = sqlsrv_num_rows($sql2);
										//$check = "checked";
										$check = "";
										for($i=0; $i<$jumbank; $i++){
											$tempRow		= sqlsrv_fetch_array($sql2, SQLSRV_FETCH_ASSOC);
											$hbno[$i] = $tempRow["bankaccno"];
											$hbacc[$i] = $tempRow["bankaccname"];
											$status = $tempRow["status"];
											
											echo "	<tr>
													<td>
														<input type=radio $check name=data-bank value='".strtoupper($tempRow["bank"]).",".strtoupper($hbno[$i]).",".strtoupper($hbacc[$i]).",".$status."'>
													</td>
													<td>
														&nbsp;<span><img src='assets/img/$link_img/".strtolower($tempRow["bank"]).".png' width=104></span>
													</td>
													<td>
														<strong><span>".strtoupper($hbno[$i])."</span></strong>
													</td>
													<td>
														<strong><span>".strtoupper($hbacc[$i])."</span></strong>
													</td>
													</tr>";
											$check = "";
										}
									?>
									</table>
									</div>
									<div class="space_20"></div>
									
									 <div class="form-group-full">
                                        <label class="col-lg-1 control-label">Validasi</label>
                                        <div class="col-lg-3">
                                            <img src='captcha/captcha.php?.png?a=1' alt='CAPTCHA' class="form-captcha"/>	
                                        </div>
                                    </div>
                                    <div class="form-group-full">
                                        <label class="col-lg-1 control-label"></label>
                                        <div class="col-lg-3">
                                            <input type="text" name="captcha" placeholder="Validation" data-required="true" class="form-control">
                                        </div>
                                    </div>
  
                                    <div class="line m-t-large"></div>
                                    <div class="space_10"></div>

                                    <p class="attention">*Kami tidak menerima transfer tunai dan deposit dari rekening atas nama org lain, terima kasih.</p>

                                    <div class="space_10"></div>

                                    <div class="form-group-full">
                                        <button type="submit" value=kirim name=submit class="btn btn-submit">Kirim</button>
                                    </div>
                                </form>
                            </div>
                        </div>
						<?php } ?>
                    </div>
				
                    <div class="clear space_30"></div>
                </div>
            </div>
<?php
include("footer.php");
?>