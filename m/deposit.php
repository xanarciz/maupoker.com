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
    "act"   => 1,
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

if (isset($_POST["submit"]) && $err == 0) {
    $name = $login;

    $amount = str_replace('.', '', $_POST["amount"]);
    $accname1 = $bankaccname;
    $rek1 = $bankaccno;
    $bname1 = $bankname;
    $capt = $_POST["captcha1"];
    $remark = "Deposit";
	$noresi 	= isset($_POST["noresi"]) ? $_POST["noresi"] : '';

    $databank = explode(",", $_POST["data-bank"]);
    $bname2 = isset($databank[0]) ? $databank[0] : '';
    $rek2 = isset($databank[1]) ? $databank[1] : '';
    $accname2 = isset($databank[2]) ? $databank[2] : '';
    $condition = isset($databank[3]) ? $databank[3] : '';

    $err = 0;
    /* if ($capt == '') {
        $err = 1;
        $errorReport = ("<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Captcha harus diisi</p></div>");
    } else if (!checkCaptcha('CAPTCHAString', $capt)) {
        $err = 1;
        $errorReport = ("<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'> Captcha tidak sama </p></div>");
    } else { */

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
    /* } */
}

if (isset($_POST["subform"])) {
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

?>

        <div class="content">

            <div class="container main no-bottom">

                <div class="wrapper">

                    <div class="container no-bottom">
                    	<h3>Permintaan Deposit</h3>
                    </div>

                    <div class="decoration"></div>

                    <div class="res" id="res_dps" align="center">
                        <?php
                        if(!isset($success_deposit)){$success_deposit = '';}
                        if ($success_deposit){
    						echo $success_deposit;
    					}else{
    						
    						if ($err == 1){
    						   	echo $errorReport;
    						}
    					?>
                    </div>

                    <form method="post" >

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">User ID</label>
                            </div>
                            <div class="formInput">
                                <span class="formText"><?php echo $_SESSION["login"]; ?></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Bank</label>
                            </div>
                            <div class="formInput">
                                <span class="formText">
                                    <?php echo $bankname;?>
    								<input type="hidden" name="bank" value="<?php echo $bankname;?>" />
                                </span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nama Rekening</label>
                            </div>
                            <div class="formInput">
                                <span class="formText">
                                    <?php echo $bankaccname; ?>
    								<input type="hidden" name="bank_accname" value="<?php echo $bankaccname; ?>" />
                                </span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nomor Rekening</label>
                            </div>
                            <div class="formInput">
                                <span class="formText">
                                    <?php
                                    if($bankname=="BCA"){
        								echo substr($bankaccno,0,8)."xxxx";
        							}else{
        								echo substr($bankaccno,0,8)."xxx-xxxx";
        							}
      							    ;?>
                                    <input type="hidden" name="bank_accnumber" value="<?php echo $bankaccno;?>" />
                                </span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Jumlah Deposit</label>
                            </div>
                            <div class="formInput">
                                
                                <input type="tel" class="contactField" name="ui_amount" id="ui_amount" value="<?php echo @$amount?>" required onkeyup="this.value=this.value.replace(/[^0-9.,]/g,'');" onblur="this.value=this.value.replace(/[^0-9.,]/g,'');" onKeypress="if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }" />
								<input type="hidden" name="amount" id="amount" value="<?php echo @$amount?>">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Tanggal</label>
                            </div>
                            <div class="formInput">
                                <?php
  								$date = date("d");
  								$month = date("M");
  								$year = date("Y");
  								?>
  								<div class="dateField"><select name='ttgl' class="contactField contactOption">
  								<?php
  								for ($d=1; $d<32; $d++){
  									$select = "";
  									if ($d == $date){
  										$select ="selected";
  									}
  									echo "<option value='".$d."' ".$select.">".$d."</option>";
  								}
  								?>
  								</select></div>

                                <div class="dateField"><select name='tmon' class="contactField contactOption">
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
  								</select></div>

                                <div class="dateField2"><select name='tyear' class="contactField contactOption">
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
  								</select></div>
                            </div>
                        </div>

                        <div class="thumb-clear"></div>

                        <h4 class="orange">Silahkan pilih rekening yang akan di transfer:</h4>

                        <div class="decoration"></div>

						<div class="row margin0">
							<div class="col-lg-12">
								<select class="button-icons button-extra-big button-blues triggerBtn" name="data-bank" id="data-bank" required>
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
										echo $BankAccNo;
									?>
								</select>
							</div>
						</div>

						<div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nama Rekening</label>
                            </div>
                            <div class="formInput">
                                <span class="formText" style="padding-top: 0px;">
                                   <label class="black fs-13 fs-normal bmargin-5 tmargin-10" id="nare">  </label>
                                </span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">No. Rekening</label>
                            </div>
                            <div class="formInput">
                                <span class="formText" style="padding-top: 0px; display: inline-flex;">
                                   <label class="black fs-13 fs-normal bmargin-5 tmargin-10" id="nore">  </label>
								<label style="display: none;" id="finalcopy"></label>
								<input class="btn btn-medium btn-gray bmargin-5 text-center" id="copy-to" type="button" value="Copy" style="margin-left: 15px;width: 46px;background-color: #7D7D7D;color: white;" />
                                </span>
                            </div>
                        </div>
							
                        <div class="decoration"></div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Validasi</label>
                            </div>
                            <div class="formInput">
                                <input class="contactField" type="text" name="captcha1" maxlength="5" />
                                <div style="height:10px;"></div>
                                <img src='../../captcha/captcha.php?.png' alt='CAPTCHA' width='120' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">
                            </div>
                        </div>

                        <!--<input id="mobile" type="hidden" name="mobile" value="mobile"  />-->

                        <div class="formSubmitButtonErrorsWrap">
                            <input type="submit" name=submit class="buttonWrap button button-reds contactSubmitButton" value="KIRIM" />
                        </div>

                        <script language="JavaScript" type="text/javascript">
    						/*jQuery(document).ready(function(){
    							setform("form_dps", "res_dps");
    							jQuery("#amount").focus().priceFormat();
    						})*/
							$(".triggerBtn").click(function () {
                                $(this).closest('div').find('.inputField').prop("checked", true);
                            });
    					</script>

                    </form>

                    <?php } ?>

                </div>

            </div>
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

        <?php include ("_footer.php");?>