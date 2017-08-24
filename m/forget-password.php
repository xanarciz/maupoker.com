<?php
include("_meta.php");
include("_header.php");

?>

<div class="content">

    <label class="ntf fs-13 padding-15 bpadding-0 tpadding-8">LUPA PASSWORD</label>
    <hr class="margin-0 tmargin-2 bmargin-3 bg-brown-panel">

    <?php
    $user="onKeypress=\"if ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 65 && event.keyCode <= 90) || (event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 45 || event.keyCode == 46 || event.keyCode == 95) {event.returnValue = true; } else {event.returnValue = false;}\"";
    $angka="onKeypress=\"if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }\"";

    if(@$_POST["submit"]){

        $uname	= strtoupper($_POST["UName"]);
        $bname	= $_POST["BName"];
        $baname	= $_POST["BAName"];
        $bano	= $_POST["BAno"] . $_POST["BAno1"] . $_POST["BAno2"];
        $hp		= $_POST["hp1"];
        $captcha= $_POST["captcha1"];

        $iplist = getUserIP2().','.getUserIP2('HTTP_CLIENT_IP').','.getUserIP2('HTTP_X_FORWARDED_FOR').','.getUserIP2('REMOTE_ADDR');

        if($captcha == ''){
            $errorReport = ("<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Captcha harap diisi.</p></div>");
        }else if(! checkCaptcha('CAPTCHAString',$captcha)){
            $errorReport = ("<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Captcha tidak sesuai.</p></div>");
        }else{
            $reqAPIAccount =
                array(
                    "auth"      => $authapi,
                    "webid" 	=> $subwebid,
                    "agent" 	=> $agentwlable,
                    "domain" 	=> $nonWWW,
                    "ip"		=> $iplist,
                    "device"	=> $device,
                    "type"		=> 3,
                    "loginid"	=> $uname,
                    "bankname"	=> $bname,
                    "baname"	=> $baname,
                    "bano"		=> $bano,
                    "phone"		=> $hp,
                );
            
            $response = sendAPI($url_Api."/account", $reqAPIAccount, 'JSON', '02e97eddc9524a1e');
            if($response->status == 200){
                $errorReport = "<div class='static-notification-green tap-dismiss-notification'>
                       <p class='center-text uppercase'>Password telah diubah menjadi <B>".$response->newPassword."</B><br>Silakan Login kembali dengan Password tersebut(Perhatikan Huruf Besar)
                       </p>
                     </div>";
            }else{
                $errorReport =	"<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>$response->msg</p></div>";
            }
        }
    }
    ?>
    <div class="row fs-16 fs-bold red" align="center">
        <?php
            if ($errorReport){
                echo $errorReport;
            }
        ?>
    </div>

    <form method="post">
        <div class="row padding-15 tpadding-5 bpadding-2">
            <label class="black lmargin-7">Username</label>
            <input class="form-control" type="text" name="UName" value="<?php echo @$_POST["nama1"];?>" required />
        </div>
        <div class="row padding-15 tpadding-5 bpadding-2">
            <label class="black lmargin-7">Nama Bank</label>
            <select name="BName" class="form-control" required>
                <?php
                // bank list
                foreach($infoweb['bankList'] as $bankdata){
                    $select = "";
                    if($_POST["BName"] == $bankdata['bank']) $select = "selected";
                    $options.= "<option value='".$bankdata['bank']."' ".$select.">".$bankdata['bank']."</option>";
                }
                echo $options;
                // End bank list
                ?>
            </select>
        </div>
        <div class="row padding-15 tpadding-5 bpadding-2">
            <label class="black lmargin-7">Nama Rekening</label>
            <input class="form-control" type="text" name="BAName" value="<?php echo @$_POST["BAName"];?>" required />
        </div>
        <div class="row padding-15 tpadding-5 bpadding-2">
            <label class="black lmargin-7">Nomor Rekening</label>
            <div class="col-lg-3 rpadding-3"><input class="form-control" type="text" name="BAno" maxlength="3" value="<?php echo @$_POST["BAno"];?>" <?php echo $angka?> required /></div>
            <div class="col-lg-3 rpadding-3"><input class="form-control" type="text" name="BAno1" maxlength="3" value="<?php echo @$_POST["BAno1"];?>" <?php echo $angka?> required /></div>
            <div class="col-lg-6"><input class="form-control" type="text" name="BAno2" maxlength="10" value="<?php echo @$_POST["BAno2"];?>" <?php echo $angka?> required /></div>
        </div>
        <div class="row padding-15 tpadding-5 bpadding-2">
            <label class="black lmargin-7">No. Telp / HP</label>
            <input class="form-control" type="text" name="hp1" value="<?php echo @$_POST["hp1"];?>" <?php echo $angka?> required />
        </div>
        <div class="row padding-15 tpadding-5 bpadding-2">
            <label class="black lmargin-7">Validasi</label>
            <div class="col-lg-7">
                <input class="form-control bg-light-gray" type="text" name="captcha1" maxlength="5" placeholder="Validasi" required />
            </div>
        
            <div class="col-lg-5 tpadding-3 lpadding-5">
                <img src='../../captcha/captcha.php?.png' alt='CAPTCHA' width='100%' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">
            </div>
        </div>
        <div class="row padding-15">
            <input class="btn btn-blue fs-normal"  value="KIRIM" type="submit" name="submit" />
        </div>
    </form>

</div>

<?php include ("_footer.php");?>