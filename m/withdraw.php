<?php
$page='withdraw';
session_start();
$login = $_SESSION["login"];

if (!$_SESSION["login"]){
		echo "<script>window.location = 'index.php'</script>";
		die();
	}

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
        "auth"   	=> $authapi,
		"act"   	=> 1,
        "userid" 	=> $login,
        "agent"  	=> $agentwlable,
        "curr"   	=> $curr,
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

        <div class="content">

            <div class="container main no-bottom">

                <div class="wrapper">

                    <div class="container no-bottom">
                    	<h3>Permintaan Withdraw</h3>
                    </div>

                    <div class="decoration"></div>


                    <div class="res" id="res_wd" align="center">
                        <?php
    					if ($success_withdraw){
    						echo $success_withdraw;
    					}else{
    						if ($error == 1){
    							echo $errorReport;
								exit();
    						}
    					?>
                    </div>

                    <form method="post">

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">User ID</label>
                            </div>
                            <div class="formInput">
                                <span class="formText"><?php echo $login?></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Chips</label>
                            </div>
                            <div class="formInput">
                                <span class="formText">
                                    IDR <?php echo number_format($coin);?>
    								<input type="hidden" name="chips" value="" />
                                </span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Jumlah Withdraw</label>
                            </div>
                            <div class="formInput">
                                <input type="tel" class="contactField" name="ui_amount" id="ui_amount" onkeyup="this.value=this.value.replace(/[^0-9.,]/g,'');" onblur="this.value=this.value.replace(/[^0-9.,]/g,'');" onKeypress="if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }" />
				<input type="hidden" name="amount" id="amount"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Password</label>
                            </div>
                            <div class="formInput">
                                <input type="password" name="pass" id="pass" class="contactField" />
                            </div>
                        </div>

                        <div class="thumb-clear"></div>

                        <h4 class="orange">Dana akan dikirim ke:</h4>

                        <div class="decoration"></div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Bank</label>
                            </div>
                            <div class="formInput">
                                <span class="formText"><?php echo $bankname;?></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nama Rekening</label>
                            </div>
                            <div class="formInput">
                                <span class="formText"><?php echo $bankaccname;?></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="formLabel">
                                <label class="field-title formTextarea" for="formTextarea">Nomor Rekening</label>
                            </div>
                            <div class="formInput">
                                <span class="formText"><?php echo $bankaccno;?></span>
                            </div>
                        </div>

                        <div class="formSubmitButtonErrorsWrap">
                            <input type="submit" name=submit class="buttonWrap button button-reds contactSubmitButton" value="KIRIM" />
                        </div>

                    </form>

                    <script language="JavaScript" type="text/javascript">
    					jQuery(document).ready(function(){
    						setform("form_wd", "res_wd");
    						jQuery("#amount").focus().priceFormat();
    					})
    				</script>

    				<?php
    				}
    				?>

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
</script>

        <?php include ("_footer.php");?>