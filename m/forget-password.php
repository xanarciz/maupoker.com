<?php
include("_meta.php");
include("_header.php");
include_once("../config_db2.php");

?>

<div class="content">
    <!-- <div class="top-banner bg-light-gray" style="background:#6f6f6f">
        <h1 class="fs-light tmargin-5">BANNER 640X100</h1>
    </div> -->

    <label class="ntf fs-13 padding-15 bpadding-0 tpadding-8">LUPA PASSWORD</label>
    <hr class="margin-0 tmargin-2 bmargin-3 bg-brown-panel">

    <?php
    $user="onKeypress=\"if ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 65 && event.keyCode <= 90) || (event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 45 || event.keyCode == 46 || event.keyCode == 95) {event.returnValue = true; } else {event.returnValue = false;}\"";
    $angka="onKeypress=\"if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }\"";

    $sqlf = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select val from a83adm_config3 where name = 'forget_pass'"),SQLSRV_FETCH_ASSOC);

    if ($sqlf["val"] == 0){

        if(@$_POST["submit"]){
            $captcha    = @$_POST["captcha1"];
            $nama   = @$_POST["nama1"];
            $id     = @$_POST["id1"];
            $hp     = @$_POST["hp1"];
            $rek    = @$_POST["rek1"];
            $comment= @$_POST["comment1"];

            if ($nama == ""){
                $errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Harap isi UserID</p></div>";
            }else if ($hp == ""){
                $errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Harap isi nomor handphone</p></div>";
            }else if ($id == ""){
                $errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Harap isi email</p></div>";
            }else if ($rek == ""){
                $errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Harap isi nomor rekening</p></div>";
            }else if ($comment == "" || $comment == " " ){
                $errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Harap isi Pesan</p></div>";
            }else if ($captcha != $_SESSION['CAPTCHAString']){
                $errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Validasi anda salah</p></div>";
            }else{
                $to = "Company";
                $subject = "### Memo forget password (web) ###";
                $body = "No Rek = ".$rek."<br>"."Email = ".$id."<br>"."Phone = ".$hp."<br>"."Comment = ".$comment;
                $sqlx = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select memo from a83adm_config") , SQLSRV_FETCH_ASSOC);
                $user = explode(",",$sqlx["memo"]);
                for($i=0;$i<count($user)-1;$i++){
                    $us = $user[$i];
                    $sql = sqlsrv_query($sqlconn, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$us."','##public(".$nama.")','','".$subject."','".$body."','0',GETDATE())");
                }

                $sql1 = sqlsrv_query($sqlconn, "insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$name."','".$to."','','".$subject."','".$body."','2',GETDATE())");
                sqlsrv_query($sqlconn,"insert into g846log_player (userid, username, ket, waktu) values ('".$uname."', '-', 'Reset Password', GETDATE())");
                $errorReport =  "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Permohonan lupa password telah di kirim!</p></div>";
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
            <label class="black lmargin-7">Login ID</label>
            <input class="form-control" type="text" name="nama1" value="<?php echo @$_POST["nama1"];?>" required />
        </div>
        <div class="row padding-15 tpadding-5 bpadding-2">
            <label class="black lmargin-7">Nomor Rekening</label>
            <input class="form-control" type="text" name="rek1" value="<?php echo @$_POST["rek1"];?>" required />
        </div>
        <div class="row padding-15 tpadding-5 bpadding-2">
            <label class="black lmargin-7">No. Telp / HP</label>
            <input class="form-control" type="text" name="hp1" value="<?php echo @$_POST["hp1"];?>" required />
        </div>
        <div class="row padding-15 tpadding-5 bpadding-2">
            <label class="black lmargin-7">Email</label>
            <input class="form-control" type="email" name="id1" value="<?php echo @$_POST["id1"];?>" required />
        </div>
        <div class="row padding-15 tpadding-5 bpadding-2">
            <label class="black lmargin-7">Pesan</label>
            <textarea class="form-control" name="comment1">
                <?php echo @$_POST["comment1"];?>
            </textarea>
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

    <?php
    }else{
        if(@$_POST["submit"]){

            $uname = $_POST["UName"];
            $email = $_POST["Email"];
            $bname = $_POST["BName"];
            $baname = $_POST["BAName"];
            $bano = $_POST["BAno"];
            $bano1 = $_POST["BAno1"];
            $bano2 = $_POST["BAno2"];
            $captcha    = $_POST["captcha1"];
            $comment= $_POST["comment1"];
            $hp     = $_POST["hp1"];
            $uname = strtoupper($uname);

            $errb = 0;

            if (strpos($hp,"<") or strpos($hp,">")){
                $errb = 1;
            }
            if (strpos($baname,"<") or strpos($baname,">")){
                $errb = 2;
            }

            $bano4 = $bano;

            $banox = $bano4."-".$bano1."-".$bano2;

            $sqlb = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select userid, status, email, bankname, bankaccname, bankaccno,telp from u6048user_id where loginid = '".$uname."' and subwebid='".$subwebid."'"),SQLSRV_FETCH_ASSOC);


            if(strtoupper($hp) != strtoupper($sqlb["telp"])){
                $errb = 3;
            }else if (strtoupper($bname) != strtoupper($sqlb["bankname"])){
                $errb = 4;
            }else if (strtoupper($baname) != strtoupper($sqlb["bankaccname"])){
                $errb = 5;
            }else if (str_replace("-","",$banox) != str_replace("-","",$sqlb["bankaccno"])){
                $errb = 6;

            }

            if ($sqlf["val"] == 1) {

                $loginlog = sqlsrv_num_rows(sqlsrv_query($sqlconn_db2,"select userid from log_loginlog where userid = '".$sqlb["userid"]."' and crttime >  dateadd(day, -1, GETDATE())",$params,$options));
            }else {
                $loginlog = 0;
            }
            if ($sqlb["bankaccno"] == ""){

                $errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Data yang anda isi salah!</p></div>";
            }
            else if ($sqlb["status"] != "0"){
                $errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Username anda masih dalam proses!</p></div>";
            }
            else if ($captcha != $_SESSION['CAPTCHAString']){
                $errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Captcha harap diisi.</p></div>";
            }
            else if($errb > 0)echo "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Data yang anda isi salah!</p></div>";
            else if ($loginlog > 0){

                sqlsrv_query($sqlconn,"delete from u6048user_active where userid = '".$sqlb["userid"]."'");
                $errorReport = "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Anda hanya bisa menggunakan lupa password apabila anda sudah tidak login lebih dari 24 jam!</p></div>";
            }
            else {


                if ($sqlf["val"] == 1) {

                    $alpha = Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","W","X","Y","Z");
                    $j = 0;
                    for ($i = 0; $i < 4; $i++) {

                        $n = rand(0, count($alpha)-1);
                        $newpass[$j] = $alpha[$n];

                        $j++;
                    }
                    $num = Array("0","1","2","3","4","5","6","7","8","9");
                    for ($i = 0; $i < 2; $i++) {
                        $n = rand(0, count($num)-1);
                        $newpass[$j] = $num[$n];
                        $j++;
                    }

                    shuffle($newpass);

                    $passn = $newpass[0].$newpass[1].$newpass[2].$newpass[3].$newpass[4].$newpass[5];

                    sqlsrv_query($sqlconn,"insert into g846log_player (userid, username, ket, waktu) values ('".$sqlb["userid"]."', '-', 'Reset Password', GETDATE())");
                    sqlsrv_query($sqlconn,"update u6048user_id set status='0', userpass='".hash("sha256",md5($passn).'8080')."' where userid = '".$sqlb["userid"]."'");
                    sqlsrv_query($sqlconn,"update g846game_id set status='0', userpass='".hash("sha256",md5($passn).'8080')."' where userid = '".$sqlb["userid"]."'");
                    sqlsrv_query($sqlconn,"insert into a83adm_forgetpass (date1,userid,stat) values (GETDATE(),'".$sqlb["userid"]."','0')");


                    $errorReport= "<div class='static-notification-red tap-dismiss-notification'><p class='center-text uppercase'>Password telah diubah menjadi <span style='font-weight:bold;'>".$passn."</span> <br>Silakan Login kembali dengan Password tersebut(Perhatikan Huruf Besar)</p></div>";

                }else {
                    $to = "Company";
                    $subject = "### Memo halaman depan ###";
                    $body = "Bank = ".$bname."<br>"."Bank Name = ".$baname."<br>"."No Rek = ".$banox."<br>"."Email = ".$email."<br>"."Comment = ".$comment;
                    $sqlx = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select memo from a83adm_config"));
                    $user = explode(",",$sqlx["memo"]);
                    for($i=0;$i<count($user)-1;$i++){
                        $us = $user[$i];
                        $sql = sqlsrv_query($sqlconn,"insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$us."','##public(".$sqlb["userid"].")','','".$subject."','".$body."','0',GETDATE())");
                    }

                    $sql1 = sqlsrv_query($sqlconn,"insert into j2365join_memo (mto,mfrom,status,msubject,mbody,mread,mdate) values ('".$sqlb["userid"]."','".$to."','','".$subject."','".$body."','2',GETDATE())");

                    $errorReport = "<div class='static-notification-green tap-dismiss-notification'><p class='center-text uppercase'>Permintaan anda sudah di kirim!</p></div>";

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
            <label class="black lmargin-7">Login ID</label>
            <input class="form-control" type="text" name="UName" value="<?php echo @$_POST["nama1"];?>" required />
        </div>
        <div class="row padding-15 tpadding-5 bpadding-2">
            <label class="black lmargin-7">Nama Bank</label>
            <select name="BName" class="form-control" required>
                <?php
                    $banksql = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select val from a83adm_config3 where name='registrasi_bank'"),SQLSRV_FETCH_NUMERIC);
                    $_bank = explode(",",$banksql[0]);
                    for ($__a=0; $__a<count($_bank); $__a++){
                        $select = "";
                        if($_POST["BName"] == $_bank[$__a]) $select = "selected";
                        if (str_replace(" ","", $_bank[$__a]))echo "<option value='".strtoupper($_bank[$__a])."' ".$select.">".strtoupper($_bank[$__a])."</option>";
                    }
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

<?PHP
    }
?>

</div>

<?php include ("_footer.php");?>