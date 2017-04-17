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

$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select bankname, bankaccno, bankaccname from u6048user_id where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
$bankname = $sqlu["bankname"];
$bankaccno = $sqlu["bankaccno"];
$bankaccname = $sqlu["bankaccname"];

if($bankaccno == null && $bankname == null && $bankaccname == null) {
	echo "<script>window.location = 'bank-setting.php'</script>";
	$_SESSION['urlPrev'] = 'withdraw.php';
	die();
}
	
function currx($val) {
if (!strpos($val,".")) return number_format($val, 0,'.', ',');
else return number_format($val, 1,'.', ',');
}
$sql1 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select amount from a83adm_depositraw where stat='0' AND act='2'",$params,$options));
/*$sqlc = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select withdraw_ctrl, withdraw_text from a83adm_config2"), SQLSRV_FETCH_ASSOC);
if ($sql1 >= $sqlc["withdraw_ctrl"]){
	 $success_withdraw = "<div class='error-report'>$sqlc[withdraw_text]</div>";
	 $err = 1;
}*/
$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userpass, bankname, bankaccno, bankaccname, bankgrup,playerpt,xdeposit from u6048user_id where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
$query = sqlsrv_query($sqlconn,"select sqltable from a83adm_configgame");

while($row = sqlsrv_fetch_array($query,SQLSRV_FETCH_ASSOC)){		
	$sql1 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select Sit from ".$row['sqltable']."_usersit where Userid='".$login."'",$params,$options));
	
	if ($sql1 > 0){
		 $errorReport = " Failed Withdraw. Please logout the game first!";
		 $err = 1;
	}
	
}

	
	$sql1 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select inEBN, inBJK, inCAP, inWAR, inSAM from u6048user_coin where Userid='".$login."' AND (inEBN>0 OR inBJK>0 OR inCAP>0 OR inWAR>0 OR inSAM>0 OR inBTM>0)",$params,$options));
	if ($sql1 > 0){
		 $success_withdraw = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Withdraw gagal.<br>Mohon Keluar Dari Game</p></div>";
		 $err = 1;
	}
	

$sql3 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid='".$login."' and bdate > dateadd(minute,-1,GETDATE())",$params,$options));	
if ($sql3 > 0){
	 $success_withdraw = "<div class='error-report'>Cannot withdraw.<br>Don't enter the game and try again 5 minutes later </div>";
	 $err = 1;
}

if (!$err){
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
	
	$sqlmaxdepo = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select first_max_depo, max_depo from a83adm_config2"), SQLSRV_FETCH_ASSOC);
	$maxdepo = $sqlmaxdepo["first_max_depo"];
	$maxdepo2 = $sqlmaxdepo["max_depo"];
	
	$dataUang = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select TXH from u6048user_coin where userid = '".$login."'"), SQLSRV_FETCH_ASSOC);
	$chip = $dataUang["TXH"];
	if ($_POST["submit"]) {
		$name		= $login;
		//$amount		= substr(str_replace('.','',$_POST["amount"]),4);
		$amount		= $_POST["amount"];
		$pass		= hash("sha256",md5($_POST["pass"]).'8080');
		$capt		= $_POST["captcha"];
		$bankaccname = $sqlu["bankaccname"];
		$bankacc	= $bankaccname;
		$rek		= $bankaccno;
		$error = 0;
		$sqlm = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select maint from a83adm_config"), SQLSRV_FETCH_ASSOC);
		$maintenance = $sqlm["maint"];
		if ($maintenance == "1") {
			 $errorReport = "<div class='error-report'>Connection Time out.</div>";
			 $err = 1;
			 die();
		}
		if ($capt != $_SESSION['CAPTCHAString']){
			$errorReport =  "<div class='error-report'>Validasi anda salah.</div>";
			$err = 1;
		}
		if ($amount == "" || $amount <= 0){
			$error	= 1;
			$errorReport =  "<div class='error-report'>Withdraw failed.<br>Please fill amount.</div>";
		}else if ($pass	== ""){
			$error	= 1;
			$errorReport =  "<div class='error-report'>Withdraw failed.<br>isi password.</div>";
		}
	
		if ($amount > 0){
		}else{
			$error	= 1;
			$errorReport =  "<div class='error-report'>Gagal Withdraw.<br>isi amount.</div>";
		}

		$p = $sqlu["userpass"];
	
		if ($p != $pass){
			$error	= 1;
			$errorReport =  "<div class='error-report'>Gagal Withdraw.<br>Password Salah.</div>";
		}
	
		$sql3	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select curr,userprefix from u6048user_data where userid = '".$name."'"), SQLSRV_FETCH_ASSOC);
		$curr	= $sql3["curr"];
		$agent	= $sql3["userprefix"];
		$balance	= $chip;
		
		$balancebaru	= $balance - $amount;
	
		if ($balancebaru < 0){
			$error	= 1;
			$errorReport =  "<div class='error-report'>Gagal Withdraw.<br>Balance not enough.</div>";
		}
		$email=$sqlu["email"];
		$playerpt=$sqlu["playerpt"];
		
		if ($playerpt == "1"){
			$sql5	= "select min_wdraw from a83adm_config";
		}else{
			$sql5	= "select min_wdraw,max_wdraw,email from u6048user_id where userid='".$agent."'";
		}
		$query5	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, $sql5), SQLSRV_FETCH_ASSOC);
		$minwit	= $query5["min_wdraw"];
		$maxwit	= $query5["max_wdraw"];

		if ($amount < $minwit){
			$error	= 1;
			$errorReport =  "<div class='error-report'>Gagal Withdraw.<br>Minimum withdraw adalah ".currx($minwit)."</div>";
		}
			if ($amount > $maxwit){
			$error	= 1;
			$errorReport =  "<div class='error-report'>Gagal Withdraw.<br>Maksimal withdraw adalah ".currx($maxwit)."</div>";
		}
		if ($error == 0) {
		$ket	= "To : ".$bankacc." - ".$rek."(".$bankname." )<hr>";
		$tp 	= "";
		$axx	= 0;
		for($i=0; $i<2; $i++){
			$temp	= substr($rek, $axx, 4);
			if ($tp == ""){
				$tp	= $temp;
			}else{
				$tp	= $tp ."-".$temp;
			}
			$axx	= 4;
		}
		$panj	= strlen($rek);
		$temt	= substr($rek, 8,$panj);
		$rot	= $tp."-".$temt;
		
		$sekarang	= Date("d M Y");
		
		$to1 = "== WITHDRAW, SLIP untuk Agent ==";
		$to1 .= "<BR> (Memo ini dikirim otomatis, berkaitan dengan penarikan dana.)";
		$to1 .= "<BR> Tanggal : ".$sekarang ;
		$to1 .= "<BR> Username : ".$name;
		$to1 .= "<BR> E-mail : ".$email ;
		$to1 .= "<BR> Jumlah : ".$amount." ";
		$to1 .= "<BR> Bank : ".$bankname ;
		$to1 .= "<BR> Nama rekening : ".$bankacc ;
		$to1 .= "<BR> No. rekening : ".$rot ;
		$to1 .= "<BR> ";
		
		$subject = "#--WITHDRAW--# ".$amount;
		if ($playerpt == 1){
			$sql_1	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select bmemo from a83adm_config"), SQLSRV_FETCH_ASSOC);
			$userx	= $sql_1["bmemo"]."";
			$nama	= explode(",",$userx);
			sqlsrv_query($sqlconn, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('*,".$userx.",*','".$name."','','".$subject."','".$to1."','0',GETDATE())");
		}else
			sqlsrv_query($sqlconn, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$agent."','".$name."','','".$subject."','".$to1."','0',GETDATE())");

		$to2 = "== WITHDRAW, SLIP untuk member ==";
		$to2 .= "<BR> (Memo ini dikirim otomatis, berkaitan dengan penarikan dana.)";
		$to2 .= "<BR> Tanggal : ".$sekarang ;
		$to2 .= "<BR> Username : ".$name." ";
		$to2 .= "<BR> E-mail : ".$email ;
		$to2 .= "<BR> Jumlah : " .$amount." ";
		$to2 .= "<BR> Bank : ".$bankname;
		$to2 .= "<BR> Nama rekening : ".$bankacc ;
		$to2 .= "<BR> No. rekening : ".$rot;
		$to2 .= "<BR> ";
		$to2 .= "Permintaan penarikan dana sudah diterima.";

		sqlsrv_query($sqlconn, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$name."','billing','','#--WITHDRAW--#','".$to2."','0',GETDATE())");
		$amountx = $amount;
		$withd	= $amountx * -1;

			$fuser = substr($login, 0,1);
			$sql2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select val from a83adm_config3 where name='wdgrupconfig'",$params,$options),SQLSRV_FETCH_NUMERIC);
			$_group = explode("#", $sql2[0]);
			for ($_g=0; $_g<count($_group); $_g++){
				if (ereg(",".$fuser.",",$_group[$_g])) {
					$mgrup = ($_g + 1);
					break;
				}
			}
			
		require_once 'mobile_detect.php';
		$detect = new Mobile_Detect;
		$check_mobile = $detect->isMobile();
		$check_tablet = $detect->isTablet();
		$mobile = 2;
		if($check_mobile == 1 || $check_tablet == 1){
			$mobile = 1;
		}
			
		sqlsrv_query($sqlconn, "insert into a83adm_depositraw (act,userid,date1,amount,ket,nama,bank,rek,stat,status,playerpt, userprefix, device) values ('2','".$name."',GETDATE(),'".$withd."','".$ket."','".$bankacc."','".$bankname."','".$rek."','0','','".$playerpt."','".$agent."',".$mobile.")");
		$totalbaru	= $balancebaru;
		
		sqlsrv_query($sqlconn, "insert into ".$db2.".dbo.t6413txh_transaction_old".date("j")." (TDate, Periode, RoomId, TableNo, UserId, GameType, Status, Bet, v_bet, Card, Prize, Win, Lose, Cnt, Chip, PTShare, SShare, MShare, AShare, Autotake, DSMaster, DMaster, DAgent, DPlayer, Agent, Master, Smaster) values (GETDATE(), '0', '0', '0', '".$name."', 'TXH', 'Withdraw', '0', '".$withd."', '-', '-', '0', '0', '1', '".$totalbaru."', '0', '0', '0', '0', '0', '0', '0', '0', '0', '".$agentwlable."', '".$masterwlable."', '')");
		
		$sql8	= sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid='".$name."'",$params,$options);
		if (sqlsrv_num_rows($sql8) > 2){
			$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
			$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
			$idx = $tempRow["id"];
			sqlsrv_query($sqlconn, "delete from t6413txh_lastorder where id='".$idx."'");
		}
		
		
		sqlsrv_query($sqlconn, "insert into t6413txh_lastorder (userid,bdate,info,status,amount,total,gametype) values ('".$name."',GETDATE(),'-','Withdraw2','".$amount."','".$totalbaru."','TXH')");
		sqlsrv_query($sqlconn, "insert into j2365join_lastorder (userid,bdate,info,status,amount,total,gametype) values ('".$name."',GETDATE(),'-','Withdraw','0','0','TXH')");

		$sql8	= sqlsrv_query($sqlconn, "select id from j2365join_lastorder where userid='".$name."'",$params,$options);
		if (sqlsrv_num_rows($sql8) > 2){
			$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
			$tempRow = sqlsrv_fetch_array($sql8, SQLSRV_FETCH_ASSOC);
			$idx = $tempRow["id"];
			sqlsrv_query($sqlconn, "delete from j2365join_lastorder where id='".$idx."'");
		}
		
		
		sqlsrv_query($sqlconn, "update u6048user_coin set TXH = '".$balancebaru."' where userid = '".$name."'");
		
		$success_withdraw = "<div class='error-report'>Withdraw Berhasil.<br> Permintaan withdraw anda akan di proses dalam 1x24 jam .</div>";

		}
		echo"<BR>";
		
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

							$conf_depo = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select max_depo , min_depo , min_wdraw , max_wdraw FROM u6048user_id WHERE userid = '".$agentwlable."'"),SQLSRV_FETCH_ASSOC);
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
									<input type="text" name="ui_amount" id="ui_amount" placeholder="Jumlah Withdraw" data-required="true" class="form-control" style="width:96%;"> <br>&nbsp;&nbsp;&nbsp;
									<font color="#dfbf61" size="2" style="font-style:italic;">*Minimal withdraw Rp <?php echo number_format($conf_depo['min_wdraw'], 0, '.', '.'); ?>, Maksimal withdraw Rp <?php echo number_format ($conf_depo['max_wdraw'], 0, '.', '.'); ?></font>
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
										$record_depositraw = sqlsrv_query($sqlconn, "select amount,date1, bank, rek from a83adm_depositraw where userid = '".$login."' and act = '2'",$params,$options);
										if (@sqlsrv_num_rows($record_depositraw) > 0){
											while($fetch_data_depositraw = sqlsrv_fetch_array($record_depositraw, SQLSRV_FETCH_ASSOC)){
												echo "
												<tr>
												<td align='center' height='23'>".$no."</td>
												<td>";
												if($fetch_data_depositraw["rek"]!='' && $fetch_data_depositraw["bank"]!==''){
													echo $fetch_data_depositraw["rek"]."-- ".$fetch_data_depositraw["bank"];
												}
												else{
													echo "-";
												}
												echo "</td>
												<td>IDR ".number_format($fetch_data_depositraw["amount"])."</td>
												<td>".date_format($fetch_data_depositraw["date1"], "d/m H:i")."</td>
												<td align='center'>PROCCESS</td>
												</tr>";
												$no++;
											}
										}

										$record_deposit = sqlsrv_query($sqlconn, "select amount,date2,bank,rek,status from a83adm_deposit where userid = '".$login."' and (act = '2' or act = '3') and stat != 0 order by id desc",$params,$options);
											if (@sqlsrv_num_rows($record_deposit) > 0){
												while($fetch_data_deposit = sqlsrv_fetch_array($record_deposit, SQLSRV_FETCH_ASSOC)){
													echo "
													<tr>
													<td align='center' height='23'>".$no."</td>
													<td>";
													if($fetch_data_deposit["rek"]!='' && $fetch_data_deposit["bank"]!==''){
														echo $fetch_data_deposit["rek"]." -- ".$fetch_data_deposit["bank"];
													}else{
														echo "-";
													}
													echo "</td>
													<td>IDR ".number_format($fetch_data_deposit["amount"])."</td>
													<td>".date_format($fetch_data_deposit["date2"], "d/m H:i")."</td>
													<td align='center'>".strtoupper($fetch_data_deposit["status"])."</td>
													</tr>";

													$no ++;
												}
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