<?php
$page='promosi';
session_start();
$login = $_SESSION["login"];

if (!$login){
    include("_meta.php");
} else {
    include("_metax.php");
}
include("_header.php");
?>

<div class="content" data-page="promo">
	<div class="lpadding-15 tpadding-5">
		<label class="ntf fs-13 tmargin-10">PROMOSI</label>
	</div>

	<!-- REWARDS -->
	<div class="row padding-10">
		<div class="col-lg-12">
			<div class="row">
				<img class="img-fluid" src="img/<?PHP echo $link_img;?>/slider/rewards.png" style=" border-top-left-radius: 5px; border-top-right-radius: 5px;" />
			</div>
			<div class="row">
	            <button class="deploy-toggle-1 toggle-design btn btn-gray" style="color: #fff; width: 50%; float: left; border-top-left-radius: 0px; border-top-right-radius: 0px; border-bottom-right-radius: 0px;">MORE INFO</button>
	            <button class="btn btn-blue" style="width: 50%; float: left; border-top-left-radius: 0px; border-top-right-radius: 0px; border-bottom-left-radius: 0px;" onclick="window.open('http://koin88.com', '_blank')">JOIN NOW</button>
		        <div class="toggle-content koin88-content" style="display: none; float: left; width: 100%">
		            <div class="row padding-10 bg-dark-gray" align="left">
		                <ul class="light-gray">
		                	<li>Point Reward adalah sebuah tanda terimakasih kami kepada anda pemain setia Poker. Point Reward bekerjasama dengan www.koin88.com. Point Reward yang anda miliki bisa di tukarkan dengan item-item menarik yang ada di koin88 ataupun pulsa.</li>
		                	<li>Bagaimana mendapatkan Poin? <br>Setiap hari anda bermain di Poker88 akan mendapatkan Poin.</li>
		                	<li>Panduan lebih lengkap silakan klik tombol di atas “JOIN NOW”.</li>
		                </ul>
		            </div>
		        </div>
			</div>
		</div>
	</div>

	<!-- SPINS -->
	<div class="row padding-10">
		<div class="col-lg-12">
			<div class="row">
				<img class="img-fluid" src="img/<?PHP echo $link_img;?>/slider/luckyspin.png" style=" border-top-left-radius: 5px; border-top-right-radius: 5px;" />
			</div>
			<div class="row">
	            <button class="deploy-toggle-1 toggle-design btn btn-gray" style="color: #fff; width: 50%; float: left; border-top-left-radius: 0px; border-top-right-radius: 0px; border-bottom-right-radius: 0px;">MORE INFO</button>
	            <button class="btn btn-blue" style="width: 50%; float: left; border-top-left-radius: 0px; border-top-right-radius: 0px; border-bottom-left-radius: 0px;" onclick="window.open('https://dewafortune.com', '_blank')">JOIN NOW</button>
		        <div class="toggle-content fortune-content" style="display: none; float: left; width: 100%">
		            <div class="row padding-10 bg-dark-gray" align="left">
						<p class="light-gray">
							Program Lucky Spin Every Day adalah program Bonus hoki-hokian yang diberikan pada pecinta games setia untuk menguji keberuntungan Anda. Lucky spin ini bisa diikutsertakan bagi para member yang telah setia bermain setiap harinya dengan minimal angka aktifitas Anda bermain. Coba beruntungan Anda dengan klik tombol “JOIN NOW”.<br><br><br>
						</p>
		            </div>
		        </div>
			</div>
		</div>
	</div>
</div>

<?PHP include '_footer.php'; ?>