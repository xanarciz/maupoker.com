<?php
$page='download';
session_start();
$login = $_SESSION["login"];

if (!$login){
    include("_meta.php");
} else {
    include("_metax.php");
}

include("_header.php");

$info = @$_GET["id"];
if (!$info){
    $info = 1;
}

$android = "https://www.gameiosapk.com/android.php";
$ios = "itms-services://?action=download-manifest&url=https://www.gameiosapk.com/iphone/manifest.plist"; 
$linkpanduan_a = "http://infodomino88.com/bermain-di-smartphone/"; 
$linkpanduan_i = "http://infodomino88.com/bermain-di-apple-ios/"; 
?>

<div class="content" style="height:auto;padding-bottom:50px;">
    <div class="lpadding-15 tpadding-5">
        <label class="ntf fs-13 tmargin-10">DOWNLOAD APLIKASI MOBILE POKER</label>
    </div>
    <hr class="margin-0 tmargin-2 bmargin-3 bg-brown-panel">

    <div class="row bpadding-10">
        <div class="col-lg-12">
            <div class="row padding-10">
                <p>Download terlebih dahulu aplikasi untuk Android atau iOS untuk main melalui smartphonemu.</p>
                <div class="col-lg-6 br-20 text-center tpadding-15 rmargin-4p" style="width:49%; background-color: #000;">
                    <img class="center-block bmargin-10" src="img/<?PHP echo $link_img;?>/icons/android_lg.png" style="width: 50%;" />
                    <h3>ANDROID</h3>
                    <div class="row">
                        <button class="btn btn-blue" style="border-bottom-left-radius: 20px; border-bottom-right-radius: 20px;">
                        <a href="<?PHP echo $android; ?>">
                            <fa class="fa fa-download rmargin-5"></fa>DOWNLOAD
                        </a>
                        </button>
                    </div>
                </div>
                <div class="col-lg-6 br-20 text-center tpadding-15" style="width:49%; background-color: #000;">
                    <img class="center-block bmargin-10" src="img/<?PHP echo $link_img;?>/icons/apple_lg.png" style="width: 50%;" />
                    <h3>iOS</h3>
                    <div class="row">
                        <button class="btn btn-blue" style="border-bottom-left-radius: 20px; border-bottom-right-radius: 20px;">
                            <a href="<?PHP echo $ios; ?>">
                                <fa class="fa fa-download rmargin-5"></fa>DOWNLOAD
                            </a>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row lpadding-20 <?PHP if(strtoupper($link_img) == "IO"){ echo "bg-blue-panel"; }elseif($link_img == "PTKP"){ echo "bg-red-panel"; }else{ echo "bg-purple";} ?> tpadding-10 bpadding-10">
        <a href="<?php echo $linkpanduan_a; ?>" target="_blank">
            <div class="col-lg-1">
                <i class="fa fa-android fa-2x <?PHP if(strtoupper($link_img) == "IO"){ echo "white"; }elseif($link_img == "PTKP"){ echo "white"; }else{ echo "gold";} ?>"></i>
            </div>
            <div class="col-lg-11 tpadding-7 lpadding-5 fs-13 <?PHP if(strtoupper($link_img) == "IO"){ echo "white"; }elseif($link_img == "PTKP"){ echo "white"; }else{ echo "gold";} ?>">
                Panduan Instalasi Android
            </div>
        </a>
    </div>

    <div class="row tmargin-5 lpadding-20 <?PHP if(strtoupper($link_img) == "IO"){ echo "bg-blue-panel"; }elseif($link_img == "PTKP"){ echo "bg-red-panel"; }else{ echo "bg-purple";} ?> tpadding-10 bpadding-10">
        <a href="<?php echo $linkpanduan_i; ?>" target="_blank">         
            <div class="col-lg-1">
                <i class="fa fa-apple fa-2x <?PHP if(strtoupper($link_img) == "IO"){ echo "white"; }elseif($link_img == "PTKP"){ echo "white"; }else{ echo "gold";} ?>"></i>
            </div>
            <div class="col-lg-11 tpadding-7 lpadding-5 fs-13 <?PHP if(strtoupper($link_img) == "IO"){ echo "white"; }elseif($link_img == "PTKP"){ echo "white"; }else{ echo "gold";} ?>">
                Panduan Instalasi iOS
            </div>
        </a>
    </div>

</div>

<?php include ("_footer.php");?>