<?php
$freePage = 1;
include("meta.php");
include("header.php");
if (!$register)exit("<script>location.href='index.php'</script>");
$login="kendi99";
function currx($val) {
   if (!strpos($val,".")) return number_format($val, 0,'.', ',');
   else return number_format($val, 1,'.', ',');
}

if ( $login ){
	$_GET = sanitize($_GET);
	$_POST = sanitize($_POST);
	/*$user = $_GET["userid"];
	$date = $_GET["date"];*/
	//if($user == "" || $date == "")die(" <font color=white>Access Denied</font>");
	$userpass = $upass;
	//if($userpass != $date)die("<font color=white>Access Denied</font>");

	$sub = $_GET["st"];
	if(!$sub)$sub=5;
	$j = $_GET["j"];
	if(!$j)$j=1;
	$batas = $_GET["batas"];
	$sql = sqlsrv_query($sqlconn, "select userid from u6048user_id where referral_agent = '".$login."'",$params,$options);
	$row = sqlsrv_num_rows($sql);
	$time = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select paycom_date from a83adm_config"), SQLSRV_FETCH_ASSOC);
	$subtotal = 0;
	$commision = 0;
	$subcomm = 0;
	$grandcomm = 0;
}
?>
			<div id="content">
                <div class="container">

                    <div class="clear space_30"></div>

                    <div class="wrap">
                        <div class="full">
                            <div class="head-wrap">
                                <h1>Referral</h1>
                            </div>

                            <div class="body-wrap text-justify">
                                <form method="post" id="form_reg">
									<div class="res" id="res_reg"></div>
									<?php
									if (!$login){
									?>
                                        <!--
										<p style="text-align:justify">System referral adalah salah satu strategy promosi marketing kami untuk mengundang kalian semua agar ikut serta dalam program ini dan mendapatkan keuntungan, referral system dari nagapoker.com tidak dipungut biaya apapun, hanya dengan modal online saja, kalian akan mendapatkan penghasilan lebih.</p>
										<p style="text-align:justify">Tugas anda disini adalah hanya mendaftarkan orang-orang yang ingin bermain poker online di nagapoker.com, setelah itu anda hanya tinggal mengecek keuntungan anda yang dapat dilihat secara online kapanpun dan dimanapun.</p>
										<p style="text-align:justify">System referral kami tidak mengharuskan anda untuk memiliki teman-teman yang suka bermain poker online agar mendapatkan keuntungan lebih tapi hanya dengan modal giat dan aktif maka uang puluhan juta setiap minggunya adalah sesuatu yang bukan mimpi lagi, anda sebagai member cukuplah dengan menyebarkan link2x referral yang anda dapatkan setelah register di nagapoker.com maka uang akan bekerja untuk anda.</p>
                                        -->
										<?php
										if ($referral_text){
											echo $referral_text;
										}else{
										?>
                                        <div align="center">
                                            <img src="assets/images/referral-image.jpg" />
                                        </div>

                                        <div style="height:20px;"></div>

                                        <div align="justify">
                                            <h4>Tips Promosi</h4>
                                            <div style="height:5px;"></div>
                            				<ol>
                            					<li>Anda bisa menyebarkan link referral anda ke FORUM</li>
                            					<li>Bisa juga dengan mentweet link referral anda di TWITTER</li>
                            					<li>Melakukan posting komentar di FACEBOOK</li>
                            					<li>Memasang link referral anda anda di BLOG</li>
                            					<li>Menyebarkan link referral kesemua contact EMAIL</li>
                            				</ol>

                                            <div style="height:20px;"></div>

                                            <h4>Cara Melihat Komisi dan Total Refferal Anda</h4>
                                            <div style="height:5px;"></div>
                                    		<ol>
                                    		    <li>Login ke <?php echo"".DOMAIN_NAME."";?></li>
                                    		    <li>Klik referral untuk melihat total referral anda</li>
                                    		    <li>Klik KOMISI untuk melihat total KOMISI anda</li>
                                    		    <li>Cara penarikan referral dapat dilakukan setiap hari Kamis dengan melakukan withdraw.</li>
                                    		</ol>
                                        </div>
										<?php
										}
										?>
									<?php
									} else {
										$batas = 5;
									?>

									<table width="100%" cellpadding="0" cellspacing="0" border="0">
										<tr valign="top">
											<td width="540">
												<a class="btn btn-login" href="referral.php?date=<?php echo"".$userpass."";?>&userid=<?php echo"".$login."";?>&st=5&j=1&batas=5&ref=getdate()">Data</a>&nbsp;
												<a class="btn btn-login" href="referral-komisi.php?date=<?php echo"".$userpass."";?>&userid=<?php echo"".$login."";?>&st=5&j=1&batas=5&ref=getdate()">Komisi</a>&nbsp;
												<a class="btn btn-login" href="referral-daftar.php?date=<?php echo"".$userpass."";?>&userid=<?php echo"".$login."";?>&type=star">Daftar</a>
												<div style="height:20px;"></div>

												<div>
													<div id="table_list">
														<form onsubmit="submitfilter('', '#table_list', 'preloader'); return false;">

														<div style="margin-bottom:2px;">

														<?php
														
															if ($j > 5){
																echo "<a href=?userid=".$_GET["userid"]."&date=".$_GET["date"]."&st=".($sub - 5)."&j=".($j - 5)."> << Back </a>";
															}else{
																echo "<font color=grey style='font-size:12px'><< Back</font>";
															}
															echo "<font size=1>&nbsp;&nbsp;|&nbsp;</font>";
															if ($row > $sub){
																echo "<a href=?userid=".$_GET["userid"]."&date=".$_GET["date"]."&st=".($sub + 5)."&j=".($j + 5)."> Next >> </a> ";
															}else{
																echo "<font color=grey style='font-size:12px'> Next >></font>";
															}

														?>

														</div>
															<table width="100%" cellpadding="0" cellspacing="0" border="0" id="table" style="font-size:12px;color:#000;">
																<thead align="left">
																	<tr>
																		<th align="center" height="23">#</th>
																		<th>User</th>
																		<th>Tgl. Daftar</th>
																		<th>Turn Over</th>
																		<th>Komisi</th>
																	</tr>
																</thead>
																<tbody align="left">
																<?php

																$grand = 0;
																for ($i=1; $i<=$row; $i++){
																	$array=sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
																	$data1[$i] = $array["userid"];
																	$tover[$i] = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select isnull(sum(tover),0)as ttl, isnull(sum(aref_comm),0)as cmm from ".$db2.".dbo.j2365join_transaction_old where player = '".$data1[$i]."' and pdate >= '".date_format($time["paycom_date"],"Y-m-d")."'"), SQLSRV_FETCH_ASSOC);
																	$grand += $tover[$i]["ttl"];
																	$commison[$i] = $tover[$i]["cmm"];
																	$grandcomm += $commison[$i];
																}

																for ($k=$j; $k<=$sub;  $k++){
																	$user_id = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select joindate, save_deposit from u6048user_id where userid = '".$data1[$k]."'"), SQLSRV_FETCH_ASSOC);
																	$tover[$k] = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select isnull(sum(tover),0)as ttl from ".$db2.".dbo.j2365join_transaction_old where player = '".$data1[$k]."' and pdate >= '".date_format($time["paycom_date"],"Y-m-d")."'"), SQLSRV_FETCH_ASSOC);
																	if ($user_id["joindate"]== null)break;
																	$subtotal += $tover[$k]["ttl"];
																	$subcomm += $commison[$k];
																?>
																	<tr style="color:#000">
																		<td height="23" style="color:#000"><span><?php echo"".$k."";?></span></td>
																		<td style="color:#000"><span><?php echo"".$data1[$k]."";?></span></td>
																		<td style="color:#000"><span><?php echo"".date_format($user_id["joindate"], "d/m/Y")."";?></span></td>
																		<td style="color:#000"><span><?php echo"".currx($tover[$k]["ttl"])."";?></span></td>
																		<td style="color:#000"><span><?php echo"".currx($commison[$k])."";?></span></td>
																	</tr>
																<?php
																}
																?>
																</tbody>
																<tfoot>
																	<tr>
																		<td colspan=3 align=right height="23" style="color:#000"><b>SubTotal</b></td>
																		<td style="color:#000"><span><b><?php echo"".currx($subtotal)."";?></b></span></td>
																		<td style="color:#000"><span><b><?php echo"".currx($subcomm)."";?></b></span></td>
																	</tr>
																	<tr>
																		<td colspan=3 align=right style="color:#000"><b>Grand Total</b></td>
																		<td style="color:#000"><b><?php echo"".currx($grand)."";?></b></td>
																		<td style="color:#000"><span><b><?php echo"".currx($grandcomm)."";?></b></span></td>
																	</tr>
																</tfoot>
															</table>
														</form>

														<div style="height:10px;"></div>

														<script language="JavaScript" type="text/javascript">
															jQuery(document).ready(function(){
																jQuery(".popup").nyroModal();
																fixtable("#table", null, "#198dd1", "#198dd1", "#33b4ff");
																getfilter();
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
																jQuery("#table th, #table tfoot tr td").css({
																	"background":"#00283d",
																	"color":"#000000"
																});
																jQuery("#table").css({
																	"border":"1px solid #198dd1"
																});
															})
														</script>
													</div>
												</div>
											</td>
										</tr>
									</table>
									<?php
										}
									?>
								</form>
                            </div>
                        </div>
                    </div>
                    <div class="clear space_30"></div>
                </div>
            </div>
<?php
include("footer.php");
?>