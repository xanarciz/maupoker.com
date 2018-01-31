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

<div class="content">
	<div class="lpadding-15 tpadding-5">
		<label class="ntf fs-13 tmargin-10">REFERRAL</label>
	</div>
	<hr class="margin-0 tmargin-2 bmargin-3 bg-brown-panel">

	<?PHP
		if($_SESSION["login"]){
	?>

	<div id="referral" style="max-height:auto; padding-bottom:50px;">
		<div class="padding tab-ref">
			<ul>
				<li><a href="#tabs-2">DATA REF</a></li>
				<li><a href="#tabs-3">DAFTAR REF</a></li>
			</ul>

			<div id="tabs-2">
				<form onsubmit="submitfilter('', '#table_list', 'preloader'); return false;">
					<div class="row tpadding-1 bpadding-50" style="height: 450px; overflow: scroll;">					
						<table class="table" cellspacing="0" cellpadding="0" border="0">
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

				</form>

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

			<div id="tabs-3">

	        	<?php
      				if ($errorReport){								
      					echo "<div class='padding-15' align='center' id='the_alert' style='color: #fff;background-color:#c0392b;'>".$errorReport."</div>";
      				}else{
						echo "<div class='padding-15' align='center' id='the_alert' style='display:none; color: #fff;background-color:#c0392b;'></div>";
					}
      			?>

				<form method="post" id="res_reg">
					<?PHP
						if(!$successRegister){
					?>
					<div class="tpadding-10 lpadding-15 rpadding-15 row">
						<div class="row">
							<label class="tmargin-10 black">Username</label>
							<input class="form-control bg-light-gray" onBlur="fast_checking('user_name', 'ceklis1', '')" id="user_name" name="UName" maxlength="8" value="<?php echo $_POST["UName"]; ?>" />
						</div>
						<div class="row">
							<label class="tmargin-10 black">Nickname</label>
							<input class="form-control bg-light-gray" onBlur="fast_checking('user_nameid', 'ceklis2', '')" id="user_nameid" name="UNameid" maxlength="10" value="<?php echo strtoupper($unameid); ?>" />
						</div>
						<div class="row">
							<label class="tmargin-10 black">Password</label>
							<input class="form-control bg-light-gray" onBlur="fast_checking('the_pass', 'ceklis3', '')" id="the_pass" type="password" name="Pass" value="<?php echo $_POST["Pass"]; ?>" />
						</div>
						<div class="row">
							<label class="tmargin-10 black">Konfirmasi Password</label>
							<input class="form-control bg-light-gray" onBlur="fast_checking('the_cpass', 'ceklis4', 'the_pass')" id="the_cpass" type="password" name="CPass" value="<?php echo $_POST["CPass"]; ?>" />
						</div>
						<div class="row">
							<label class="tmargin-10 black">Alamat Email</label>
							<input class="form-control bg-light-gray" onBlur="fast_checking('the_email', 'ceklis6', '')" id="the_email" type="email" maxlength="40"  name="Email" value="<?php echo $_POST["Email"]; ?>" />
						</div>
						<div class="row">
							<label class="tmargin-10 black">No Telp/HP</label>
							<input class="form-control bg-light-gray" onBlur="fast_checking('the_phone', 'ceklis7', '')" id="the_phone" type="text" maxlength="13" name="Phone" value="<?php echo $_POST["Phone"]; ?>" />
						</div>
						<div class="row">
							<label class="tmargin-10 black">Link Referral</label>
							<span>
								<?php echo "<b>http://".$DomainName."/ref.php?ref=$user_login</b>"; ?>
							</span>
						</div>
						<div class="row">
							<label class="tmargin-10 black">Validasi</label>
							<div class="col-lg-7">
								<input onBlur="fast_checking('the_cap', 'ceklis11', '')" id="the_cap" class="form-control bg-light-gray" type="text" name="captcha1" maxlength="5" />
							</div>
						
							<div class="col-lg-5 tpadding-3 lpadding-5">
								<img src='../../captcha/captcha.php?.png' alt='CAPTCHA' width='100%' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">
							</div>
						</div>
						<div class="row tmargin-10 bmargin-15">
							<input class="btn btn-blue bmargin-50" value="DAFTAR" type="submit" name="submit"/>
						</div>
					</div>
					<?PHP
						}else{
					?>

		        	<div class="row">
			        	<?php 
			        		echo "<div class='row normal-green'>
								<label class='normal-green fs-13 padding-15 bpadding-0 tpadding-8'>PENDAFTARAN SUKSES</label>
								<p>".$successRegister."</p>
								</div>";
			        	?>
	      			</div>

					<?PHP
						}
					?>
				</form>
			</div>
		</div>
	</div>

	<?PHP
		}else{
	?>

 	<div class="row padding-10">
 		<p class="dark-gray">
   	 		Program Referral adalah peluang usaha bisnis online tanpa modal, dengan BONUS setiap minggunya. Caranya :
			<ul class="blue lpadding-10">
				<li><p class="dark-gray">Daftarkan diri Anda jika belum memiliki Akun ID.</p></li>
				<li><p class="dark-gray">Dapatkan link referral Anda pada menu “REFERRAL”.</p></li>
				<li><p class="dark-gray">Share link referral Anda melalui media yang Anda punya seperti : Facebook, Twitter, Path, Blog, Google+, Email, Forum, Sms, BBM dllnya.</p></li>
				<li><p class="dark-gray">Cek aktifitas, Bonus Komisi Anda yang berjalan dan setiap minggunya dapatkan KOMISInya.</p></li>
			</ul>
		</p>
 		<p class="dark-gray">
			<h3>DAPATKAN KOMISI REFFERAL 10%.</h3>
			Setiap teman, member yang anda ajak bermain akan mendapatkan komisi sebesar 10% dari rollingan setiap minggunya. Tunggu apalagi ajak, sebar, promosikan dan dapatkan komisi UANG TUNAI-nya. Tanpa Kerja Keras!
		</p>
 	</div>

	<?PHP
		}
	?>

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

	<script>
	function fast_checking(id_div, id_div2, id_div3){
		//use ajax to run the check
		var id_val = $('#'+id_div).val(); 
		
		if(id_div3!=""){ 
			var id_val2 = $('#'+id_div3).val();  
		}
		else{
			var id_val2 = "";
		}

		$('#the_alert').html("<img src='assets/loading/loading.gif' width='20' height='20' title='checking...' />");
		$('#the_alert').css('background-color', '');
		$('#the_alert').show(); 
		
		$.post("../fast_checking.php", { id_div:id_div, id_val:id_val, id_val2:id_val2},
			function(result){  
				var inresult = result.split(";");

				if(inresult[0] == "0"){  
					$('#the_alert').css('background-color', '#c0392b');
					$('#the_alert').show();
					$('#the_alert').html(""+inresult[1]); 
					// $(document).scrollTo('#the_alert');
				}else{  
					$('#the_alert').hide();					
				}
			}
		);  
	}
	</script>

</div>

<?php include("_footer.php"); ?>