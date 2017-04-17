<?php
$freePage = 1;
include("meta.php");
include("header.php");
?>
<div id="content">
    <div class="container">

        <div class="clear space_30"></div>

        <div class="wrap">
            <div class="full">
			
			    <div class="head-wrap">
                    <h1>Point Reward</h1>
                </div>
                <div class="body-wrap text-justify">
                	<?php  $webserver=explode('.',$_SERVER[HTTP_HOST])[0]; ?>
					<p><?php echo $_SERVER[HTTP_HOST]; ?> sebagai penyelenggara website Domino online mengadakan program poin system untuk semua Player. </p>
					<p><br>
						<span style="font-weight: bold;margin: 5px 0px;">Apa itu Point Reward <?php echo $webserver;?> ?</span><br>
						Point Reward <?php echo $webserver;?> adalah sebuah tanda terimakasih kami kepada anda pemain setia <?php echo $webserver;?>. Point Reward <?php echo $webserver; ?> bekerjasama dengan www.koin88.com. Point Reward yang anda miliki bisa di tukarkan dengan item-item menarik yang ada di koin88 ataupun pulsa. Bagaimana mendapatkan Poin ? Setiap hari anda bermain di <?php echo $webserver;?> akan mendapatkan Poin.
					</p>
					<img src="assets/img/bannerkoin88.jpg" width="100%" style="margin: 5px 0px;">
					<p>
						<span style="font-weight: bold;margin: 5px 0px;">AKTIVASI GAME</span><br>

						Cara melakukan AKTIVASI / CONNECT dari Game ke Koin88
						Silahkan login kedalam Game Koin88.com
						Silahkan Login di <?php echo $_SERVER[HTTP_HOST]; ?>
						Di <?php echo $_SERVER[HTTP_HOST]; ?> klik tombol AKTIVASI
					</p>
					<p>
						Anda akan diarahkan ke koin88.com.<br>
						Aktivasi berhasil
					</p>
					<p><br>
						<span style="font-weight: bold;margin: 5px 0px;">GRAB POIN</span><br>
						GRAB adalah fitur untuk menarik Poin Game anda ke Koin.
						Minimal GRAB adalah 5.000 Poin
						Bagaimana cara melakukan GRAB ?
						Login ke koin88, klik akun anda di pojok kanan atas, pilih KONEKSI GAME, dan GRAB
					</p>
                </div>
            </div>
        </div>

        <div class="clear space_30"></div>
		
    </div>
</div>


<?php
include("footer.php");
?>