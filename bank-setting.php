<?php
include("meta.php");
include("header.php");
$url_back = $_SESSION['urlPrev'];

function currx($val) {
    if (!strpos($val,".")) return number_format($val, 0,'.', ',');
    else return number_format($val, 1,'.', ',');
}
if (!$_SESSION["login"]){
    echo "<script>window.location = 'index.php'</script>";
    die();
}

$sql3 = sqlsrv_num_rows(sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid='".$login."' and bdate > dateadd(minute,-1,GETDATE())",$params,$options));
if ($sql3 > 0){
    $success_deposit = "<div class='error-report'>Cannot deposit.<br>Don't enter the game and try again 1 minutes later </div>";
    $err = 1;
}
$sql1 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select amount from a83adm_depositraw where userid='".$login."' and stat='0' AND act='1'"), SQLSRV_FETCH_ASSOC);
if ($sql1["amount"] > 0){
    $success_deposit =  "<div class='error-report' >Tidak Dapat melakukan deposit,<br> anda masih memiliki 1 deposit yang sedang di proses</div>";
    $err = 1;
}

//$sqlbank = mssql_fetch_array(mssql_query("select bankname, bankaccno, bankaccname, bankgrup from u6048user_id where userid ='".$login."'"));
$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select bankname, bankaccno, bankaccname, bankgrup,playerpt,xdeposit from u6048user_id where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
$bankname = $sqlu["bankname"];
$bankaccno = $sqlu["bankaccno"];
$bankaccname = $sqlu["bankaccname"];
$bankgrup = $sqlu["bankgrup"];
$playerpt	= $sqlu["playerpt"];
$xdepo = $sqlu["xdeposit"];

if($bankaccno != null && $bankname != null && $bankaccname != null) {
    echo "<script>window.location = 'index.php'</script>";
    die();
}

$sqlg = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select val from a83adm_config3 where name = 'xdeposit_pertama'"),SQLSRV_FETCH_ASSOC);

$xfirst = $sqlg["val"];
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
$firstdepo = 1;

if ($xdepo > $xfirst) {
    $firstdepo = 0;
}
$firstdepo = 0;
$sqlmaxdepo = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select first_max_depo, max_depo from a83adm_config2"), SQLSRV_FETCH_ASSOC);
$maxdepo = $sqlmaxdepo["first_max_depo"];
$maxdepo2 = $sqlmaxdepo["max_depo"];
$q1	= sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select max_depo from u6048user_id where userid='".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
$maxdepo2 = $q1["max_depo"];


if($_POST['submit']){
    $bname	= $_POST["BName"];
    $baname = str_replace("''","*",$_POST["BAName"]);
    $bano	= $_POST["BAno"];
    $bano1	= $_POST["BAno1"];
    $bano2	= $_POST["BAno2"];

    $bano4 = $bano;
    $bano = str_replace("-","",$bano);
    if( strtoupper($_POST["BName"])=='MANDIRI'){
        $cx1=substr($bano,0,3);
        $cx2=substr($bano,3,3);
        $cx3=substr($bano,6,3);
        $cx4=substr($bano,9,4);
        $banox=$cx1."-".$cx2."-".$cx3."-".$cx4;
    }else if (strtoupper($_POST["BName"])=='BCA' || strtoupper($_POST["BName"])=='BNI'){
        $cx1=substr($bano,0,3);
        $cx2=substr($bano,3,3);
        $cx3=substr($bano,6,4);
        $banox=$cx1."-".$cx2."-".$cx3;
    }else if (strtoupper($_POST["BName"])=='BRI'){
        $cx1=substr($bano,0,3);
        $cx2=substr($bano,3,3);
        $cx3=substr($bano,6,3);
        $cx4=substr($bano,9,3);
        $cx5=substr($bano,12,3);
        $banox=$cx1."-".$cx2."-".$cx3."-".$cx4."-".$cx5;
    }else if (strtoupper($_POST["BName"])=='DANAMON'){
        $cx1=substr($bano,0,3);
        $cx2=substr($bano,3,3);
        $cx3=substr($bano,6,3);
        $cx4=substr($bano,9,3);
        $banox=$cx1."-".$cx2."-".$cx3."-".$cx4;
    }else if (strtoupper($_POST["BName"])=='CIMB'){
        $cx1=substr($bano,0,3);
        $cx2=substr($bano,3,3);
        $cx3=substr($bano,6,3);
        $cx4=substr($bano,9,13);
        $banox=$cx1."-".$cx2."-".$cx3."-".$cx4;
    }

    $bano5 = $banox;
    $cekrekno = sqlsrv_query($sqlconn, "select no_rek,bank from a83adm_nobankrek where no_rek LIKE '".$bano."%'",$params,$options);
    for ($c=0; $c<sqlsrv_num_rows($cekrekno); $c++){
        $cekd = sqlsrv_fetch_array($cekrekno,SQLSRV_FETCH_ASSOC);
        $cekn = preg_match("/".$cekd["no_rek"]."/", $bano, $match, PREG_OFFSET_CAPTURE);
        $cekm = preg_match("/".strtoupper($cekd["bank"])."/", strtoupper($bname), $match, PREG_OFFSET_CAPTURE);

        if ($cekm > 0 && $cekn > 0){
            $cekb = 1;
            break;
        }
    }
    $tes=strtolower($bname);
    if(strlen($tes) > 0){
        if($tes=="bca"){
            if(strlen($bano) != 10) {
                $ceke=1;
            }
        }else if($tes=="bni"){
            if(strlen($bano) < 9){
                $ceke=3;
            }
            if(strlen($bano) > 10){
                $ceke=3;
            }
        }else if($tes=="mandiri"){
            if( strlen($bano) != 13 ) {
                $ceke=2;
            }
        }else if($tes=="bri"){
            if(strlen($bano) != 15) {
                $ceke=4;
            }
        }
    }

    foreach (count_chars($bano, 1) as $i => $val) {
        if($i > 47 && $i < 58) {  }
        else {
            $ckuser = 2;
        }
    }

    if ( !preg_match('/[^A-Za-z0-9 ]/', $bname) ){
        //safe
    }else{
        $bname_error = 1;
    }

    $blocking_bank = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select * from a83adm_nobankrek where no_rek = '".$banox."' or no_rek = '".$bano4."'",$params,$options));
    $cekBankNo	= sqlsrv_num_rows(sqlsrv_query($sqlconn, "select bankaccno from u6048user_id where bankaccno = '".$bano5."' and userprefix='".$agentwlable."'",$params,$options));

    if ($ckuser == 2) {
        $errorReport = "<div class='error-report'>Ilegal karakter di Nomor Rekening.<br> Error nomor rekening (#1005)</div>";
    }else if(($baname == "") || ($bano == "")) {
        $errorReport =("<div class='error-report'>Pendaftaran Bank Gagal.<br>Tidak boleh ada yang kosong.(#1010)</div>");
    }else if ($bname_error == 1) {
        $errorReport = "<div class='error-report'>Pendaftaran Bank Gagal.<br> cek Nama bank (#1014)</div>";
    }else if ($ceke == 1) {
        $errorReport = "<div class='error-report'>Pendaftaran Bank Gagal.<br>Akun BCA harus memiliki 10 digit nomor (#1100)</div>";
    }else if ($ceke == 2) {
        $errorReport = "<div class='error-report'>Pendaftaran Bank Gagal.<br>Akun MANDIRI harus memiliki 13 digit nomor (#1101)</div>";
    }else if ($ceke == 3) {
        $errorReport = "<div class='error-report'>Pendaftaran Bank Gagal.<br>Akun BNI harus memiliki 9 atau 10 digit nomor (#1102)</div>";
    }else if ($ceke == 4) {
        $errorReport = "<div class='error-report'>Pendaftaran Bank Gagal.<br>Akun BRI harus memiliki 15 digit nomor (#1103)</div>";
    }else if ($cekb == 1) {
        $errorReport = "<div class='error-report'>Pendaftaran Bank Gagal.<br>Pendaftaran Bank gagal (#1015)</div>";
    }else if ($cekBankNo > 0){
        $errorReport = "<div class='error-report'>Maaf! akun bank ini sudah pernah di daftarkan (#1019)</div>";
    }else if($blocking_bank > 0){
        $errorReport =  "<div class='error-report'>Bank telah ter blokir (#1022)</div>";
    } else {
        $sqlg = sqlsrv_query($sqlconn,"UPDATE u6048user_id SET username= '".$baname."', bankname = '".$bname."' , bankaccno = '".$bano5."', bankaccname = '".$baname."' where userid = '".$login."'");

        if($sqlq === false){
            $debug = false;
            if( ($errors = sqlsrv_errors() ) != null) {
                if($debug){
                    $errorReport = "<div class='error-report'>ERROR SQLSTT-#'.$errors[0]['SQLSTATE'].'_'.$errors[0]['code'].'<br>Pendaftaran Bank gagal<br>Detail: '.$errors[0]['message'].'</div>";
                }else{
                    $errorReport = "<div class='error-report'>ERROR SQLSTT-#'.$errors[0]['SQLSTATE'].'_'.$errors[0]['code'].'<br>Pendaftaran Bank gagal</div>";
                }
            }
        }else {
            unset($_SESSION['urlPrev']);
            echo "<script>window.location = '".$url_back."';</script>";
            die();
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
                                    <input type="text" name="BAName" id="the_baname" value="<?php echo $baname; ?>" placeholder="Nama Lengkap Anda Sesuai Buku tabungan" data-required="true" class="form-control" maxlength="50" onkeyup="this.value=this.value.replace(/[^a-zA-Z ,.']/g,'');" onblur="this.value=this.value.replace(/[^a-zA-Z ,.']/g,'');">
                                </div>
                            </div>

                            <div class="form-group-full">
                                <label class="col-lg-1 control-label">Nama Bank</label>
                                <div class="col-lg-2">
                                    <select name='BName' id="the_bname" class="form-control">
                                        <?php
                                        $select = "";
                                        if($_POST["BName"] == $bankdata["bank"]) $select = "selected";
                                        $banksql		= sqlsrv_query($sqlconn, "select distinct(bank) as bank from a83adm_configbank where code = '".$agentwlable."' and (curr = 'IDR')",$params,$options);

                                        while($bankdata = sqlsrv_fetch_array($banksql,SQLSRV_FETCH_ASSOC)){
                                            $select = "";
                                            echo $_POST["BName"]."aaaa<br>";
                                            echo $bankdata["bank"];
                                            if($_POST["BName"] == $bankdata["bank"]) $select = "selected";
                                            $options.= "<option value='".$bankdata["bank"]."' ".$select.">".$bankdata["bank"]."</option>";
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