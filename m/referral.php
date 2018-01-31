<?php
$page='referral';
session_start();
$login = $_SESSION["login"];

if (!$login){
    include("_meta.php");
} else {
    include("_metax.php");
	// include("../function/jcd-umum.php");
}
include("_header.php");

function currx($val) {
   if (!strpos($val,".")) return number_format($val, 0,'.', ',');
   else return number_format($val, 1,'.', ',');
}

if ( $login ){
    //get Referral data
    $reqAPIReferralData = array(
        "auth"  => $authapi,
        "agent" => $agentwlable,
        "userid"=> $login,
        "type"  => 1,
    );

    $respReferralData = sendAPI($url_Api . "/referral", $reqAPIReferralData, 'JSON', '02e97eddc9524a1e');
    $dataReferral = $respReferralData->data;
}

$cref=$agentwlable;
$noRek	= "1";
if($infoweb['pt_status'] == 0) die("Cannot Open this page.");

$curr = $_POST["Curr"];
$ref = strtoupper($_COOKIE["ref"]);
if (!$ref)$ref="";
if($_POST["submit"]){
?>
	<script>
		$(document).ready(function () {
			$('.ui-tabs-active').removeClass('ui-tabs-active ui-state-active ui-state-hover');
			$('.tab-ref').tabs({active: 1});
		});
	</script>
<?php

	if($infoweb['open_reg'] == "0"){echo "<div class='error-report'>Registration Tempolary Closed</div>";
		die();
	}

	$uname = str_replace("''","*",$_POST["UName"]);
	$unameid = str_replace("''","*",$_POST["UNameid"]);
	$pass = $_POST["Pass"];
	$cpass = $_POST["CPass"];
	$email = $_POST["Email"];
	$phone = $_POST["Phone"];
	$curr = $_POST["Curr"];

    if($_POST['captcha1'] == ''){
        $errorReport = ("<div class='error-report'><strong>Pendaftaran gagal!</strong> Captcha harus diisi</div>");
    }else if($_POST['captcha1'] != $_SESSION['CAPTCHAString']){
        $errorReport = ("<div class='error-report'><strong>Pendaftaran gagal!</strong> Captcha tidak sama</div>");
    }else {
        $reqAPIRegister = array(
            "auth"  => $authapi,
            "webid" => $subwebid,
            "regType" => 2,
            "input" => array(
                "agent" => $agentwlable,
                "username" => strtoupper($uname),
                "nickname" => strtoupper($unameid),
                "password" => $pass,
                "cpassword" => $cpass,
                "email" => $email,
                "phone" => $phone,
                "ref_text" => strtoupper($user_login),
                "device" => $device,
            )
        );

        $response = sendAPI($url_Api . "/register", $reqAPIRegister, 'JSON', '02e97eddc9524a1e');
        if ($response->status == 200) {
            $successRegister = "<centeR>
                    <a href='http://" . $DomainName . "'>$DomainName</a> - Pendaftaran Sukses<br>Username = <b>$uname</b><br>
                    Silakan Login di <a href='http://" . $DomainName . "'>$DomainName</a><br>
                    Anda bisa melakukan deposit di website <a href='http://" . $DomainName . "'>$DomainName</a> atau melalui agent Anda.<br>
                    Terima Kasih
                    </center>";
        } else {
            $errorReport = ("<div class='error-report'><strong>Pendaftaran gagal!</strong> " . $response->msg . "</div>");
        }
    }
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
									<div class="formSubmitButtonErrorsWrap">
										<a class="button-reds" style="float:left;border-radius:5px;margin:5px;" href="referral.php?date=<?php echo"".$userpass."";?>&userid=<?php echo"".$login."";?>&st=5&j=1&batas=5&ref=getdate()">Data</a>
										<a class="button-reds" style="float:left;border-radius:5px;margin:5px;" href="referral-daftar.php">Daftar</a>
									
									</div>
									<div style="height:20px;"></div>

									<table width="100%" cellpadding="0" cellspacing="0" border="0">
										<tr valign="top">
											<td width="540">
												<div>

												<table class="table_list" cellspacing="0" cellpadding="0" border="0">
							<thead>
								<tr>
									<th>No</th>
									<th>User ID</th>
									<th>Tgl Daftar</th>
									<th>Turnover <br/>Sementara</th>
									<th>Komisi <br/> Sementara</th>
								</tr>
							</thead>
							<tbody>
                                <?php
                                $no = $dataReferral->from;
                                $subtotal = $subcomm = 0;
                                foreach ($dataReferral->data as $ref) {
                                    $dateJoin = strtotime($ref->joindate);
                                    $date = date('d/m/Y', $dateJoin);
                                    $subtotal += $ref->ttl;
                                    $subcomm += $ref->cmm;
                                    ?>
                                    <tr>
                                        <td style="color:black;"><?php echo $no;?></td>
                                        <td style="color:black;"><?php echo $ref->player;?></td>
                                        <td style="color:black;"><?php echo $date;?></td>
                                        <td style="color:black;"><?php echo currx($ref->ttl);?></td>
                                        <td style="color:black;"><?php echo currx($ref->cmm);?></td>
                                    </tr>
                                    <?php
                                }
                                ?>
							</tbody>
							<tfoot>
                                <tr>
                                    <td colspan="3" align="right" style="color:black;"><b>SubTotal</b></td>
                                    <td style="color:black;"><span><b><?php echo"".currx($subtotal)."";?></b></span></td>
                                    <td style="color:black;"><span><b><?php echo"".currx($subcomm)."";?></b></span></td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="right" style="color:black;"><b>Grand Total</b></td>
                                    <td style="color:black;"><b><?php echo"".currx($respReferralData->grandTot->ttl)."";?></b></td>
                                    <td style="color:black;"><span><b><?php echo"".currx($respReferralData->grandTot->cmm)."";?></b></span></td>
                                </tr>
							</tfoot>
						</table>

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
include("_footer.php");
?>