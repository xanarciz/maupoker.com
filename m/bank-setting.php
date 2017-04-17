<?php
$page='deposit';
session_start();
$login = $_SESSION["login"];
$url_back = $_SESSION['urlPrev'];

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
        $cx2=substr($bano,3,2);
        $cx3=substr($bano,5,5);
        $cx4=substr($bano,10,13);
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
        $errorReport = "Ilegal karakter di Nomor Rekening.<br> Error nomor rekening (#1005)";
    }else if(($baname == "") || ($bano == "")) {
        $errorReport =("Pendaftaran Bank Gagal.<br>Tidak boleh ada yang kosong.(#1010)");
    }else if ($bname_error == 1) {
        $errorReport = "Pendaftaran Bank Gagal.<br> cek Nama bank (#1014)";
    }else if ($ceke == 1) {
        $errorReport = "Pendaftaran Bank Gagal.<br>Akun BCA harus memiliki 10 digit nomor (#1100)";
    }else if ($ceke == 2) {
        $errorReport = "Pendaftaran Bank Gagal.<br>Akun MANDIRI harus memiliki 13 digit nomor (#1101)";
    }else if ($ceke == 3) {
        $errorReport = "Pendaftaran Bank Gagal.<br>Akun BNI harus memiliki 9 atau 10 digit nomor (#1102)";
    }else if ($ceke == 4) {
        $errorReport = "Pendaftaran Bank Gagal.<br>Akun BRI harus memiliki 15 digit nomor (#1103)";
    }else if ($cekb == 1) {
        $errorReport = "Pendaftaran Bank Gagal.<br>Pendaftaran Bank gagal (#1015)";
    }else if ($cekBankNo > 0){
        $errorReport = "Maaf! akun bank ini sudah pernah di daftarkan (#1019)";
    }else if($blocking_bank > 0){
        $errorReport =  "Bank telah ter blokir (#1022)";
    } else {
        $sqlg = sqlsrv_query($sqlconn,"UPDATE u6048user_id SET username= '".$baname."', bankname = '".$bname."' , bankaccno = '".$bano5."', bankaccname = '".$baname."' where userid = '".$login."'");

        if($sqlq === false){
            $debug = false;
            if( ($errors = sqlsrv_errors() ) != null) {
                if($debug){
                    $errorReport = "ERROR SQLSTT-#'.$errors[0]['SQLSTATE'].'_'.$errors[0]['code'].'<br>Pendaftaran Bank gagal<br>Detail: '.$errors[0]['message'].'";
                }else{
                    $errorReport = "ERROR SQLSTT-#'.$errors[0]['SQLSTATE'].'_'.$errors[0]['code'].'<br>Pendaftaran Bank gagal";
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
    <div class="content-2">

        <div class="row">
            <div class="lpadding-15 tpadding-5">
                <label class="ntf fs-13 tmargin-10">FORM PENDAFTARAN AKUN BANK</label>
            </div>
            <hr class="margin-0 tmargin-2 bmargin-3">
            <?php
            if ($errorReport){
                echo "<div class='padding-15' align='center' id='the_alert' style='color: #fff;background-color: #c0392b;'>".$errorReport."</div>";
            }else{
                echo "<div class='padding-15' align='center' id='the_alert' style='display: none; color: #fff;'></div>";
            }
            ?>
            <div class='padding-15' align='center' id='the_alert' style='color: #8a6d3b;background: #fcf8e3;border-color: #faebcc;'>PENDAFTARAN AKUN BANK HANYA BERLAKU SATU KALI (1x)!</div>
        </div>

        <form method="post" id="form_reg">
            <div class="row padding-15 tpadding-3 bpadding-2">
                <div class="col-lg-5 tmargin-5">
                    <label class="black ">Nama Rekening</label>
                </div>
                <div class="col-lg-7">
                    <input class="form-control bg-light-gray place-red" id="the_baname" type="text" maxlength="25" name="BAName" value="<?php echo $_POST["BAName"]; ?>" placeholder="*Nama sesuai buku tabungan Anda" />
                </div>
            </div>
            <div class="row padding-15 tpadding-3 bpadding-2">
                <div class="col-lg-5 tmargin-5">
                    <label class="black">Nama Bank</label>
                </div>
                <div class="col-lg-7">
                    <select class="form-control bg-light-gray" name="BName" id="the_bname">
                        <?php
                        $select = "";
                        if($_POST["BName"] == $bankdata["bank"]) $select = "selected";
                        $banksql		= sqlsrv_query($sqlconn, "select distinct(bank) as bank from a83adm_configbank where code = '".$agentwlable."' and (curr = 'IDR')",$params,$options);

                        while($bankdata = sqlsrv_fetch_array($banksql,SQLSRV_FETCH_ASSOC)){
                            $select = "";

                            if($_POST["BName"] == $bankdata["bank"]) $select = "selected";
                            echo "<option value='".$bankdata["bank"]."' ".$select.">".$bankdata["bank"]."</option>";
                        }
                        //                    echo $options;
                        ?>
                    </select>
                </div>
            </div>

            <div class="row padding-15 tpadding-3 bpadding-2">
                <div class="col-lg-5 tmargin-5">
                    <label class="black">Nomor Rekening</label>
                </div>
                <div class="col-lg-7">
                    <input class="form-control bg-light-gray" id="the_bano" type="text" name="BAno" id="BAno" value="<?php echo $_POST["BAno"];?>" />
                </div>
            </div>

            <div class="row padding-15 tpadding-3 bpadding-2">
                <div class="col-lg-5 tmargin-5">
                    <label class="black">Validasi</label>
                </div>
                <div class="col-lg-7">
                    <input class="form-control bg-light-gray" id="the_cap" type="text" name="captcha1" maxlength="5" />
                </div>
            </div>

            <div class="row padding-15 tpadding-3 bpadding-2">
                <div class="col-lg-5 tmargin-5">

                </div>
                <div class="col-lg-7">
                    <img src='../captcha/captcha.php?.png' alt='CAPTCHA' width='120' height=30 style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;">
                </div>
            </div>

            <div class="row padding-15 bmargin-50">
                <input class="btn btn-green fs-normal" value="DAFTAR" type="submit" name="submit" />
            </div>
        </form>
    </div>
<?php include ("_footer.php");?>