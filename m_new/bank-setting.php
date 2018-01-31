<?php
$page='deposit';
session_start();
$login = $_SESSION["login"];
$url_back = isset($_SESSION['urlPrev']) ? $_SESSION['urlPrev'] : 'deposit.php';

if (!$login){
    include("_meta.php");
	echo "<script>window.location = 'index.php'</script>";
	die();
} else {
    include("_metax.php");
}

include("_header.php");
function currx($val) {
    if (!strpos($val,".")) return number_format($val, 0,'.', ',');
    else return number_format($val, 1,'.', ',');
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
    $captcha = $_POST['captcha1'];

    if($captcha == ''){
        $errorReport = ("<strong>Pendaftaran gagal!</strong> Captcha harus diisi");
    }else if(! checkCaptcha('CAPTCHAString',$captcha)){
        $errorReport = ("<strong>Pendaftaran gagal!</strong> Captcha tidak sama");
    }else {
        $reqAPISetBank = array(
            "auth"        => $authapi,
            "webid"       => $subwebid,
            "regType"     => 3,
            "input"       => array(
                "agent"   => $agentwlable,
                "nickname"=> strtoupper($login),
                "bankname"=> $bname,
                "baname"  => $baname,
                "bano"    => $bano,
            )
        );
        $response = sendAPI($url_Api . "/register", $reqAPISetBank, 'JSON', '02e97eddc9524a1e');

        if ($response->status == 200) {
            unset($_SESSION['urlPrev']);
            echo "<script>window.location = '" . $url_back . "';</script>";
            die();
        } else {
            $errorReport = "<div class='error-report'>" . $response->msg . "</div>";
        }
    }
}

?>
    <div class="content-2">

        <div class="row">
            <div class="lpadding-15 tpadding-5">
                <label class="red fs-13 tmargin-10">FORM PENDAFTARAN AKUN BANK</label>
            </div>
            <hr class="margin-0 tmargin-2 bmargin-3">
            <?php
            if ($errorReport){
                echo "<div class='padding-15' align='center' id='the_alert' style='color: #fff;background-color: #c0392b;'>".$errorReport."</div>";
            }else{
                echo "<div class='padding-15' align='center' id='the_alert' style='display: none; color: #fff;'></div>";
            }
            ?>
            <div class='padding-15' align='center' id='the_alert' style='color: #fffff2;background: #dbb847;border-color: #faebcc;'>PENDAFTARAN AKUN BANK HANYA BERLAKU SATU KALI (1x)!</div>
        </div>

        <form method="post" id="form_reg">
            <div class="tpadding-10 lpadding-15 rpadding-15 row">
                <div class="row">
                    <label class="tmargin-10 black">Nama Rekening</label>
                    <input class="form-control bg-light-gray place-red" id="the_baname" type="text" maxlength="25" name="BAName" value="<?php echo $_POST["BAName"]; ?>" placeholder="*Nama sesuai buku tabungan Anda" maxlength="50"  required/>
                </div>
                <div class="row">
                    <label class="tmargin-10 black">Nama Bank</label>
                    <select class="form-control bg-light-gray" name="BName" id="the_bname">
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
                <div class="row">
                    <label class="tmargin-10 black">Nomor Rekening</label>
                    <input class="form-control bg-light-gray" id="the_bano" type="text" name="BAno" id="BAno" value="<?php echo $_POST["BAno"];?>" maxlength="30" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" onblur="this.value=this.value.replace(/[^0-9]/g,'');" onKeypress="if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }" required/>
                </div>
                <div class="row">
                    <label class="tmargin-10 black">Validasi</label>
                    <div class="col-lg-7">
                        <input id="the_cap" class="form-control bg-light-gray" type="text" name="captcha1" maxlength="5" required/>
                    </div>

                    <div class="col-lg-5 tpadding-3 lpadding-5">
                        <img src='../../captcha/captcha.php?.png' alt='CAPTCHA' width='100%' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">
                    </div>
                </div>
                <div class="row tmargin-10 bmargin-15">
                    <input class="btn btn-blue bmargin-50" value="DAFTAR" type="submit" name="submit"/>
                </div>
            </div>
        </form>
    </div>
<?php include ("_footer.php");?>