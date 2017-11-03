<?php
$page='vip';
session_start();
$login = $_SESSION["login"];

if (!$login){
    include("_meta.php");
} else {
    include("_metax.php");
}

include("_header.php");
?>

<style>

/* Style the tab content */
.tabcontent {
    display: none;
}
.active-tab {
    display: block;
}

.tablinks {
	display: inline-block;
    font-family: 'Aller Regular';
    padding: 7px 8px;
    border-radius: 3px;
    margin: 5px 2px;
    background: #2eb9ca;
    color: #fff;
	width: 85px;
}

.ford88 {
	background: #2eb9ca;
    color: #fff;
}
</style>

<div class="content-2" style="min-height:500px;">

	<div style="margin:auto;text-align:center;">
		<div id="header-text" style="padding: 10px 0;">
			<button class="tablinks" onclick="openCity(event, 'EVENT')"> EVENT</button>
			<button class="tablinks" onclick="openCity(event, 'PROMOSI')">PROMOTION</button>
			<button class="tablinks" onclick="openCity(event, 'HOT')">HOT</button>
			<button class="tablinks" onclick="openCity(event, 'VIP')">VIP</button>
		</div>
	</div>

	<div id="EVENT" class="tabcontent active-tab">
	
	
		<div class="row tmargin-15 rpadding-15 lpadding-20 tpadding-10 bpadding-10 ford88">
			<div class="col-lg-12">
				EVENT
			</div>
		</div>
		<div style="padding:2px;">


			<div style="position:relative;margin-top:0px;">
				<div style="width:100%;height:100%;background: url(assets/img/bg-bottom.jpg) repeat;position:absolute;top:318px;z-index:-1;">
					<div style="width:100%;background: url(assets/img/main-shadow-bottom.png) repeat;position:absolute;z-index:2;height:12px"></div>
				</div>
				<div class="box-shade" style="width:100%; text-align: center;">
						<iframe id="frame" frameborder="0" style="border: none; width: 375px; height: 650px; overflow: auto; display: inline-block; margin: 0 auto;" src="http://dewavip.com/latest/events.html"></iframe>
				</div>
			</div>
		</div>
	</div>
	
	<div id="PROMOSI" class="tabcontent">
	
	
		<div class="row tmargin-15 rpadding-15 lpadding-20 tpadding-10 bpadding-10 ford88">
			<div class="col-lg-12">
				PROMOTION
			</div>
		</div>
		<div style="padding:2px;">


			<div style="position:relative;margin-top:0px;">
				<div style="width:100%;height:100%;background: url(assets/img/bg-bottom.jpg) repeat;position:absolute;top:318px;z-index:-1;">
					<div style="width:100%;background: url(assets/img/main-shadow-bottom.png) repeat;position:absolute;z-index:2;height:12px"></div>
				</div>
				<div class="box-shade" style="width:100%; text-align: center;">
						<iframe id="frame" frameborder="0" style="border: none; width: 375px; height: 8500px; overflow: auto; display: inline-block; margin: 0 auto;" src="http://dewavip.com/latest/news.html"></iframe>
				</div>
			</div>
		</div>
	</div>
	
	<div id="HOT" class="tabcontent">
	
	
		<div class="row tmargin-15 rpadding-15 lpadding-20 tpadding-10 bpadding-10 ford88">
			<div class="col-lg-12">
				HOT
			</div>
		</div>
		<div style="padding:2px;">


			<div style="position:relative;margin-top:0px;">
				<div style="width:100%;height:100%;background: url(assets/img/bg-bottom.jpg) repeat;position:absolute;top:318px;z-index:-1;">
					<div style="width:100%;background: url(assets/img/main-shadow-bottom.png) repeat;position:absolute;z-index:2;height:12px"></div>
				</div>
				<div class="box-shade" style="width:100%; text-align: center;">
						<iframe id="frame" frameborder="0" style="border: none; width: 375px; height: 650px; overflow: auto; display: inline-block; margin: 0 auto;" src="http://event.dewavip.info/hot.php"></iframe>
				</div>
			</div>
		</div>
	</div>
	
	<div id="VIP" class="tabcontent">
		<div class="row tmargin-15 rpadding-15 lpadding-20 tpadding-10 bpadding-10 ford88">
			<div class="col-lg-12">
				VIP MEMBER
			</div>
		</div>

		<div class="row bg-gray-panel">
			<img src="img/slider/vip-banner.jpg" class="img-vip">

			<div class="row padding-10">
				<p class="light-gray">DewaVip menawarkan Anda sebuah pengalaman gaming dengan layanan Super Exclusive seperti Anda mempunyai asisten pribadi. Program khusus ini hanya ada di DewaVip yang telah kami rancang khusus untuk para pemain dengan limit tinggi. Dengan bergabungnya Anda sebagai member DewaVip maka Anda berhak mendapatkan segala bentuk program dan keistimewaan yang akan menyempurnakan sistem pelayanan Super Exclusive kami.</p>
			
				<p class="light-gray">
					Keistimewaan yang akan Anda dapatkan jika menjadi member DewaVip:
					<ul class="yellow lpadding-10">
						<li><span class="light-gray">Proses Deposit dan Penarikan yang diprioritaskan.</span></li>
						<li><span class="light-gray">Melayani Deposit dan Penarikan Member Dari Sms, Website , atau dapat langsung berbicara dengan Costumer Service kami.</span></li>
						<li><span class="light-gray">Perpindahan Chip Antar game di dalam network Dewavip.</span></li>
						<li><span class="light-gray">Mendapatkan Promosi yang Excluvise dari Dewavip.</span></li>
						<li><span class="light-gray">Hadiah/Kejutan Untuk Member.</span></li>
						<li><span class="light-gray">Layanan Team Khusus Member VIP dalam 24 jam.</span></li>
						<li><span class="light-gray">Undangan untuk Acara Spesial dari Dewavip.</span></li>
					</ul>
				</p>

				<p class="light-gray">Nikmati dimensi baru dalam dunia game online. Dengan berbagai keistimewaan dan penawaran exclusive, Anda akan menemukan Ruang Khusus VIP, Anda Pantas Ada Disini.</p><br><br><br>
			</div>
		</div>
	</div>

</div>

<script>
function openCity(evt, idname) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(idname).style.display = "block";
    evt.currentTarget.className += " active";
}
</script>

<?php include ("_footer.php");?>