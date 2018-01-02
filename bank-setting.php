<?php
include("meta.php");
include("header.php");
$url_back = isset($_SESSION['urlPrev']) ? $_SESSION['urlPrev'] : 'deposit.php';

function currx($val) {
    if (!strpos($val,".")) return number_format($val, 0,'.', ',');
    else return number_format($val, 1,'.', ',');
}
if (!$_SESSION["login"]){
    echo "<script>window.location = 'index.php'</script>";
    die();
}

if($status_bank == 1) {
    unset($_SESSION['urlPrev']);
    echo "<script>window.location = '" . $url_back . "'</script>";
    die();
}
if($_POST['submit']){
    $bname	= $_POST["BName"];
    $baname = str_replace("''","*",$_POST["BAName"]);
    $bano	= $_POST["BAno"];
   
   if($_POST['captcha1'] == ''){
       $errorReport = ("<strong>Pendaftaran gagal!</strong> Captcha harus diisi");
   }else if($_POST['captcha1'] != $_SESSION['CAPTCHAString']){
       $errorReport = ("<strong>Pendaftaran gagal!</strong> Captcha tidak sama");
   }else{
	   $reqAPISetBank = array(
			"auth"    => $authapi,
			"webid"   => $subwebid,
			"regType" => 3,
			"input"	  => array(
				"agent"		=> $agentwlable,
				"nickname"  => strtoupper($login), 
				"bankname"  => $bname, 
				"baname" 	=> $baname, 
				"bano" 		=> $bano,
			)
       );
       $response = sendAPI($url_Api."/register",$reqAPISetBank,'JSON','02e97eddc9524a1e');

       if($response->status == 200){
			unset($_SESSION['urlPrev']);
			echo "<script>window.location = '".$url_back."';</script>";
			die();
       }else{
			$errorReport = "<div class='error-report'>".$response->msg."</div>";
       }
   }
}

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
                        document.write("<iframe src="+j_register+" width=800 height=700></iframe>");
                    </script>
                <?php
                }else{
                echo"<script>
								document.getElementById('menu-register').href=j_register;
								document.getElementById('menu-deposit').href=j_deposit;
								document.getElementById('menu-withdraw').href=j_withdraw;
							</script>";

                ?>
                    <div class="head-wrap">
                        <h1>Pendaftaran Akun Bank</h1>
                    </div>
                    <div class="body-wrap">
                        <style> .validx {	position:absolute;right:-25px;margin-top:3px; } </style>
                        <form class="form-horizontal" role="form" method="POST">
                            <div class="alert alert-warning" style="background: #fcf8e3; color: #8a6d3b;border-color: #faebcc;">
                                Pendaftaran Akun Bank hanya Berlaku Satu Kali (1x)!
                            </div>
                            <?php
                            if ($errorReport){
                                ?>
                                <div class="alert alert-danger" id="the_alert">
                                    <?php
                                    echo $errorReport;
                                    ?>
                                </div>
                                <?php
                            }
                            elseif ($successRegister){
                                ?>
                                <div class="alert alert-success" id="the_alert">
                                    <?php
                                    echo $successRegister;
                                    ?>
                                </div>
                                <?php
                            }
                            else{
                                ?>
                                <div class="alert alert-danger" id="the_alert" style="display:none;">
                                </div>
                                <?php
                            }
                            ?>

                            <div class="form-group-full">
                                <label class="col-lg-1 control-label">Nama Rekening Bank</label>
                                <div class="col-lg-2">
                                    <div id="ceklis8" class="validx"></div>
                                    <input type="text" name="BAName" id="the_baname" value="<?php echo $baname; ?>" placeholder="Nama Lengkap Anda Sesuai Buku tabungan" data-required="true" class="form-control" maxlength="50" >
                                </div>
                            </div>

                            <div class="form-group-full">
                                <label class="col-lg-1 control-label">Nama Bank</label>
                                <div class="col-lg-2">
                                   <select name='BName' id="the_bname" class="form-control">
										<?php
                                        foreach($infoweb['bankList'] as $bankdata){
                                            $select = "";
                                            if($_POST["BName"] == $bankdata['bank']) $select = "selected";
                                            $options.= "<option value='".$bankdata['bank']."' ".$select.">".$bankdata['bankname']."</option>";
                                        }
                                        echo $options;
										?>
									</select>
                                </div>
                            </div>

                            <div class="form-group-full">
                                <label class="col-lg-1 control-label">Nomor Rekening Bank</label>
                                <div class="col-lg-2">
                                    <div id="ceklis9" class="validx"></div>
                                    <input type="text" name="BAno" id="the_bano" value="<?php echo $bano; ?>" placeholder="Nomor Rekening Bank Anda" data-required="true" class="form-control" maxlength="30" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" onblur="this.value=this.value.replace(/[^0-9]/g,'');" onKeypress="if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }">
                                </div>
                            </div>
                            <div class="form-group-full">
                                <label class="col-lg-1 control-label">Captcha</label>
                                <div class="col-lg-3">
                                    <img src='captcha/captcha.php?.png?a=1' alt='CAPTCHA' class="form-captcha"/>
                                </div>
                            </div>

                            <div class="form-group-full">
                                <label class="col-lg-1 control-label"></label>
                                <div class="col-lg-3">
                                    <div id="ceklis11" class="validx"></div>
                                    <input type="text" name="captcha1" id="the_cap" placeholder="Validation" data-required="true" class="form-control">
                                </div>
                            </div>

                            <div class="line m-t-large"></div>
                            <div class="space_10"></div>

                            <div class="form-group-full">
                                <button type="submit" name="submit" value="SUBMITS" class="btn btn-submit">Submit</button>
                            </div>
                        </form>
                    </div>
                    <?php
                }
                ?>
            </div>
        </div>
        <div class="clear space_30"></div>
    </div>
</div>
<?php
include("footer.php");
?>