<?php
$page='vip';
$login = $_SESSION["login"];

if (!$login){
    include("_meta.php");
} else {
    include("_metax.php");
}

include("_header.php");
?>

<div class="content-2">
    <div class="lpadding-15 tpadding-5">
        <label class="ntf fs-13 tmargin-10">VIP MEMBER</label>
    </div>
    <hr class="margin-0 tmargin-2 bmargin-3 bg-brown-panel">

    <div class="row tpadding-10">
        <img src="img/<?PHP echo $link_img;?>/slider/vip-banner.jpg" class="img-vip">

        <div class="row padding-10">
            <p class="black">DewaVip menawarkan Anda sebuah pengalaman gaming dengan layanan Super Exclusive seperti Anda mempunyai asisten pribadi. Program khusus ini hanya ada di DewaVip yang telah kami rancang khusus untuk para pemain dengan limit tinggi. Dengan bergabungnya Anda sebagai member DewaVip maka Anda berhak mendapatkan segala bentuk program dan keistimewaan yang akan menyempurnakan sistem pelayanan Super Exclusive kami.</p>
        
            <p class="black">
                Keistimewaan yang akan Anda dapatkan jika menjadi member DewaVip:
                <ul class="ntf lpadding-10">
                    <li><p class="black">Proses Deposit dan Penarikan yang diprioritaskan.</p></li>
                    <li><p class="black">Melayani Deposit dan Penarikan Member Dari Sms, Website , atau dapat langsung berbicara dengan Costumer Service kami.</p></li>
                    <li><p class="black">Perpindahan Chip Antar game di dalam network Dewavip.</p></li>
                    <li><p class="black">Mendapatkan Promosi yang Excluvise dari Dewavip.</p></li>
                    <li><p class="black">Hadiah/Kejutan Untuk Member.</p></li>
                    <li><p class="black">Layanan Team Khusus Member VIP dalam 24 jam.</p></li>
                    <li><p class="black">Undangan untuk Acara Spesial dari Dewavip.</p></li>
                </ul>
            </p>

            <p class="black">Nikmati dimensi baru dalam dunia game online. Dengan berbagai keistimewaan dan penawaran exclusive, Anda akan menemukan Ruang Khusus VIP, Anda Pantas Ada Disini.</p><br><br><br>
        </div>
    </div>

</div>

<?php include ("_footer.php");?>