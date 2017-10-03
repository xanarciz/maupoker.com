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

<div class="content" data-page="promo" style="min-height: 100vh; height: auto !important; ">
	<div class="lpadding-15 tpadding-5">
		<label class="ntf fs-13 tmargin-10">PROMOSI</label>
	</div>

	<!-- TOURANMENT -->
    <?php
    $i = 1;
    foreach ($infoweb['promo'] as $dataallgam){
	?>
	<div class="row promo padding-10">
		<div class="col-lg-12">
			<div class="row">
				<img class="img-fluid" src="<?php echo $dataallgam["img"]?>" style=" border-top-left-radius: 5px; border-top-right-radius: 5px;" />
			</div>
			<div class="row">
	            <button class="deploy-toggle-1 toggle-design btn btn-gray" style="color: #fff; width: 50%; float: left; border-top-left-radius: 0px; border-top-right-radius: 0px; border-bottom-right-radius: 0px;">MORE INFO</button>
				<?PHP if($login){ ?>
				<button class="btn btn-blue" style="width: 50%; float: left; border-top-left-radius: 0px; border-top-right-radius: 0px; border-bottom-left-radius: 0px;" onclick="window.location.href = 'download.php'">PLAY NOW</button>
				<?PHP }else{ ?>
				<button class="btn btn-blue" style="width: 50%; float: left; border-top-left-radius: 0px; border-top-right-radius: 0px; border-bottom-left-radius: 0px;" onclick="window.location.href = 'daftar.php'">JOIN NOW</button>
				<?PHP } ?>
		        <div class="toggle-content koin88-content" style="display: none; float: left; width: 100%">
		            <div class="row padding-10 bg-dark-gray" align="left">
		               <?php echo $dataallgam["berita"];?>
		            </div>
		        </div>
			</div>
		</div>
	</div>
	<?php
		}
	?>
</div>

<?PHP include '_footer.php'; ?>