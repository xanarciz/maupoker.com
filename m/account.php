<?php
$page='akun';
include("_metax.php");
include("_header.php");
include("../myaes.php");


$req4 = "<request>
			<secret_key>88888111118888811111</secret_key>
			<id>4</id>
			<curr>IDR</curr>
		</request>";
$q_curr = myCurl($req4);
$r_curr = $q_curr->currate;
function myCurl($req)
{
	$url = "http://103.249.162.133/corexx/";
	
	//setting the curl parameters.
	$ch = curl_init();

	curl_setopt($ch, CURLOPT_URL, $url);
	// Following line is compulsary to add as it is:
	// $response = $req;
	
	$pkey = '2fb4f029ebf33b9a';
	$myaes = new myaes();
	$myaes->setPrivate($pkey);
	$response = $myaes->getEnc($req);

	curl_setopt($ch, CURLOPT_HTTPHEADER, array("Authorization: ".$myaes->getHeaderPK(), 'Content-Type: text/plain; charset=utf-8'));
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	
	curl_setopt($ch, CURLOPT_POSTFIELDS,"" . $response);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
	$data = curl_exec($ch);
	curl_close($ch);

	//convert the XML result into array
	$array_data = simplexml_load_string($data);
	return $array_data;
}

if($link_img == "io"){ $warna = "bg-blue-panel"; }elseif($link_img == "PTKP"){ $warna = "bg-red-panel"; }else{ $warna = "bg-purple";}
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
					<?php 
					$userAgent = sqlsrv_query($sqlconn, "SELECT userprefix,authcode  FROM u6048user_id WHERE loginid = '$user_login' and usertype = 'U' and subwebid = '".$subwebid."'",$params,$options);
					$userAgent2 = sqlsrv_fetch_array($userAgent, SQLSRV_FETCH_ASSOC);
					$my_authcode = $userAgent2["authcode"];
					echo $my_authcode; ?>
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
						<a class="btn btn-mini btn-orange center tpadding-3 tmargin-2" href="https://www.koin88.com/do-game-connect?id=1006&userid=<?php echo $user_login ?>&authcode=<?php echo $user_authcode;?>">Aktivasi</a>
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
						<input class="form-control bg-light-gray" type="password" id="old" name="old" />
					</div>

					<label class="black">4 digit di belakang rekening
						<?php $bankaccno = str_replace('-', '', $bankaccno); echo substr(strtoupper($bankaccno),0,strlen($bankaccno)-4)."xxxx"; ?> &nbsp;
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
				<center>
			        <?php
				        $page = $_GET['page']?$_GET['page']:1;
				        $count = sqlsrv_num_rows(sqlsrv_query($sqlconn, "SELECT amount FROM a83adm_deposit WHERE  userid = '".$login."' AND act = '".$id."'",$params,$options));
				        $batas = 15;     //jumlah data yg muncul setiap page
				        $maxtampil = 10; //jumlah list number page yg akan ditampilkan
				        $jumptampil = 5; //pergeseran number page dari number page x 
				        $link = "his-depo.php";
				        $begin = $batas*($page-1);
				        $end = $batas*$page;
				        $next = $page+1;
				        $prev = $page-1;
				        $pages = ceil($count/$batas);

				        if($pages==0) $pages=1;
				        $querydpwd = "SELECT amount,date2,bank,rek,status
				                      FROM (SELECT amount,date2,bank,rek,status, ROW_NUMBER() OVER (ORDER BY ID DESC) AS RowNum
				                            FROM a83adm_deposit where userid ='$login'  and (act='1' or act='3') and stat!=0
				                           ) AS MyDerivedTable
				                      WHERE MyDerivedTable.RowNum > $begin AND MyDerivedTable.RowNum<= $end";
				        $data = sqlsrv_query($sqlconn,$querydpwd ,$params,$options);

				        if($page-($maxtampil-1) > 0) {if($page>($pages-$jumptampil))$bnum=$pages-($maxtampil-1); else $bnum=$page-$jumptampil;}
				        else $bnum=1; 

				        if($page+($maxtampil-1) <= $pages) {if($page<$jumptampil) $enum=$maxtampil; else $enum=$page+($jumptampil-1);}
				        else $enum=$pages;

				        if($page>$jumptampil && $enum!=$pages) {$bnum += 1;$enum += 1;}

				        // echo "<style>
				        //     .pagenumber ul {list-style-type: none; margin:5px}
				        //     .pagenumber li {
				        //       display: inline;
				        //       padding:7px 10px;
				        //       background:#6d6d6d;
				        //       border:1px solid #7f7f7f;
				        //     }
				        //     .pagenumber li a{
				        //       color:#ffffff; text-decoration:none;
				        //     }
				        //     .pagenumber li a:hover{
				        //       color:#2cb0bb;
				        //     }
				        //     .pagenumber li:hover{
				        //       background:none;
				        //       border:0;
				        //     }
				        //   </style>";

				        // echo "<div class='pagenumber' align=center style='font-size:13px;font-family:tahoma,arial,verdana;font-weight:bold;margin-bottom:10px;'><ul>";

				        // if($page>1) {
				        //   echo ("<li><a href='$link?page=1'>First</a></li>");
				        //   echo ("<li><a href='$link?page=$prev'>&lt</a></li>");
				        // }

				        // if($bnum-1 !=0) echo "<li style='background:none;border:0;'><span style='color:gray;'>..</span></li>";
				        
				        // for($x=$bnum;$x<=$enum;$x++){
				        //   if($page == $x) echo "<li style='background:none;border:0;'><span style='color:gray;'>$x</span></li>";
				        //   else echo "<li><a href='$link?page=$x'>$x</a></li>";
				        // }
				        // if($enum<$pages) echo "<li style='background:none;border:0;'><span style='color:gray;'>..</span></li>";


				        // if($page!=$pages){
				        //   echo ("<li><a href='$link?page=$next'>&gt</a></li>");
				        //   echo ("<li><a href='$link?page=$pages'>Last</a></li>");
				        // }
				        // echo "</ul></div>";
			        ?>
				</center>

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
							$record_depositraw = sqlsrv_query($sqlconn, "select amount,date1, bank, rek from a83adm_depositraw where userid = '".$login."' and act = '1'",$params,$options);
							if (@sqlsrv_num_rows($record_depositraw) > 0){
								$fetch_data_depositraw = sqlsrv_fetch_array($record_depositraw, SQLSRV_FETCH_ASSOC);
								echo "
								<tr>
									<td>".$no."</td>
									<td>";
										if($fetch_data_depositraw["rek"]!='' && $fetch_data_depositraw["bank"]!==''){
											echo substr($fetch_data_depositraw["rek"],0,8)."XXXX"."-- ".$fetch_data_depositraw["bank"];
										}
										else{
											echo "-";
										}
										echo "</td>
										<td>IDR ".number_format($fetch_data_depositraw["amount"])."</td>
										<td>".date_format($fetch_data_depositraw["date1"], "d/m  H:i")."</td>
										<td align='center'>PROCCESS</td>
									</tr>";
									$no++;
							}

							while($fetch_data_deposit = sqlsrv_fetch_array($data, SQLSRV_FETCH_ASSOC)){
								$fetch_data_deposit["status"] != "REJECT" ? $clr = "green" : $clr = "red";

								echo "
								<tr>
									<td>".$no."</td>
									<td>";
										if($fetch_data_deposit["rek"]!='' && $fetch_data_deposit["bank"]!==''){
											echo substr($fetch_data_deposit["rek"],0,8)."XXXX"." -- ".$fetch_data_deposit["bank"];
										}else{
											echo "-";
										}
										echo "</td>
										<td>IDR ".number_format($fetch_data_deposit["amount"])."</td>
										<td>".date_format($fetch_data_deposit["date2"], "d/m H:i")."</td>
										<td style='color:".$clr."'>".strtoupper($fetch_data_deposit["status"])."</td>
									</tr>";

								$no ++;
							}
							?>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4" align="right" style="color:black;"><b>Jumlah:</b></td>
							<td style="color:black;"><span><b><?php echo sqlsrv_num_rows($data) ?></b></span></td>
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
				<center>
					<?php
						$page = $_GET['page']?$_GET['page']:1;
						$count = sqlsrv_num_rows(sqlsrv_query($sqlconn, "SELECT amount FROM a83adm_deposit WHERE  userid = '".$login."' AND act = '1'",$params,$options));
						$batas = 15;     //jumlah data yg muncul setiap page
						$maxtampil = 10; //jumlah list number page yg akan ditampilkan
						$jumptampil = 5; //pergeseran number page dari number page x 
						$link = "his-depo.php";
						$begin = $batas*($page-1);
						$end = $batas*$page;
						$next = $page+1;
						$prev = $page-1;
						$pages = ceil($count/$batas);
						if($pages==0) $pages=1;
						$querydpwd = "SELECT amount,date2,bank,rek,status
						              FROM (SELECT amount,date2,bank,rek,status, ROW_NUMBER() OVER (ORDER BY ID DESC) AS RowNum
						                    FROM a83adm_deposit where userid ='$login'  and (act='2' or act='3') and stat!=0
						                   ) AS MyDerivedTable
						              WHERE MyDerivedTable.RowNum > $begin AND MyDerivedTable.RowNum<= $end";
						$data = sqlsrv_query($sqlconn,$querydpwd ,$params,$options);

						if($page-($maxtampil-1) > 0) {if($page>($pages-$jumptampil))$bnum=$pages-($maxtampil-1); else $bnum=$page-$jumptampil;}
						else $bnum=1; 
						if($page+($maxtampil-1) <= $pages) {if($page<$jumptampil) $enum=$maxtampil; else $enum=$page+($jumptampil-1);}
						else $enum=$pages;

						// if($page>$jumptampil && $enum!=$pages) {$bnum += 1;$enum += 1;}
						// echo "<style>
						//     .pagenumber ul {list-style-type: none; margin:5px}
						//     .pagenumber li {
						//       display: inline;
						//       padding:7px 10px;
						//       background:#6d6d6d;
						//       border:1px solid #7f7f7f;
						//     }
						//     .pagenumber li a{
						//       color:#ffffff; text-decoration:none;
						//     }
						//     .pagenumber li a:hover{
						//       color:#2cb0bb;
						//     }
						//     .pagenumber li:hover{
						//       background:none;
						//       border:0;
						//     }
						//   </style>";
						// echo "<div class='pagenumber' align=center style='font-size:13px;font-family:tahoma,arial,verdana;font-weight:bold;margin-bottom:10px;'><ul>";

						// if($page>1) {
						//   echo ("<li><a href='$link?page=1'>First</a></li>");
						//   echo ("<li><a href='$link?page=$prev'>&lt</a></li>");
						// }
						// if($bnum-1 !=0) echo "<li style='background:none;border:0;'><span style='color:gray;'>..</span></li>";
						// for($x=$bnum;$x<=$enum;$x++){
						//   if($page == $x) echo "<li style='background:none;border:0;'><span style='color:gray;'>$x</span></li>";
						//   else echo "<li><a href='$link?page=$x'>$x</a></li>";
						// }
						// if($enum<$pages) echo "<li style='background:none;border:0;'><span style='color:gray;'>..</span></li>";


						// if($page!=$pages){
						//   echo ("<li><a href='$link?page=$next'>&gt</a></li>");
						//   echo ("<li><a href='$link?page=$pages'>Last</a></li>");
						// }
						// echo "</ul></div>";
					?>
				</center>
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
						$record_depositraw = sqlsrv_query($sqlconn, "select amount,date1, bank, rek from a83adm_depositraw where userid = '".$login."' and act = '2'",$params,$options);
						if (@sqlsrv_num_rows($record_depositraw) > 0){
							$fetch_data_depositraw = sqlsrv_fetch_array($record_depositraw, SQLSRV_FETCH_ASSOC);
							echo "
							<tr>
								<td align='center' height='23'>".$no."</td>
								<td>";
									if($fetch_data_depositraw["rek"]!='' && $fetch_data_depositraw["bank"]!==''){
										echo substr($fetch_data_depositraw["rek"],0,8)."XXXX"."-- ".$fetch_data_depositraw["bank"];
									}
									else{
										echo "-";
									}
									echo "</td>
									<td>IDR ".number_format($fetch_data_depositraw["amount"])."</td>
									<td>".date_format($fetch_data_depositraw["date1"], "d/m  H:i")."</td>
									<td align='center'>PROCCESS</td>
								</tr>";
								$no++;
							}
							while($fetch_data_deposit = sqlsrv_fetch_array($data, SQLSRV_FETCH_ASSOC)){
								echo "
								<tr>
									<td align='center' height='23'>".$no."</td>
									<td>";
										if($fetch_data_deposit["rek"]!='' && $fetch_data_deposit["bank"]!==''){
											echo substr($fetch_data_deposit["rek"],0,8)."XXXX"." -- ".$fetch_data_deposit["bank"];
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
						?>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4" align="right" style="color:black;"><b>Jumlah:</b></td>
							<td style="color:black;"><span><b><?php echo sqlsrv_num_rows($data) ?></b></span></td>
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
							$req13 = "<request>
							<secret_key>88888111118888811111</secret_key>
							<id>13</id>
							<userid>".$login."</userid>
							<curr_rate>".$r_curr."</curr_rate>
						</request>";
							$transDays = myCurl($req13);

							foreach($transDays->transaction as $report)
							{
						?>

						<tr>
							<td><?php echo $report->date;?></td>
							<td><?php echo $report->deposit;?></td>
							<td><?php echo $report->withdraw;?></td>
							<td style='color:<?php $report->color;?>'><?php echo $report->winlose;?></td>
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