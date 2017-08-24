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
					<h1>PROMOSI</h1>
				</div>

				<div class="body-wrap text-justify" style="overflow-x: auto;">
				<?php
					$no = 1;
					foreach ($infoweb['promo'] as $promo){
				?>
					<div class="content-promo">
						<img class="img-promo" src="<?php echo $promo["img"]?>">
						<div class="content-btn">
							<button class="deploy-toggle<?PHP echo $no; ?> btn btn-promo btn-login">MORE INFO</button>
							<?PHP if($login){ ?>
								<button class="btn btn-promo btn-login" onclick="location.href='lobby.php'">PLAY NOW</button>
							<?PHP }else{ ?>
								<button class="btn btn-promo btn-login" onclick="location.href='register.php'">JOIN NOW</button>
							<?PHP } ?>
						</div>
						<div class="toggle-content content<?PHP echo $no++; ?>">
							<p>
								<?php echo $promo["berita"];?>
							</p>
						</div>
					</div>
				<?php
					}
				?>
				</div>
			</div>
		</div>

		<div class="clear space_30"></div>
	</div>
</div>

<script>
	$(document).ready(function(){
		
		<?PHP
			for($a=1; $a <= $no; $a++){
		?>
			var i = '<?PHP echo $a?>';
			$(".deploy-toggle<?PHP echo $a?>").click(function(){
				$(".content<?PHP echo $a?>").slideToggle("fast");
			});
		<?PHP
			}
		?>
		
	});
</script>

<?php
include("footer.php");
?>