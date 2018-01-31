
<?php
$page='download';

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
?>

        <div class="content">

            <div class="container main no-bottom">

                <div class="wrapper">

                    <div class="container no-bottom">
                    	<h3>Download Aplikasi Mobile Poker</h3>
                    </div>

                    <div class="decoration"></div>

                    <p>Download aplikasi iOS dan Android untuk bermain <b>Poker</b>.</p>

                    <div class="portfolio-item-full-width">
                        <?php
							$filen = "Poker.apk";
							$fsize = 13;
						?>
                        

                    </div>
					<a target="blank" href="itms-services://?action=download-manifest&url=https://www.gameiosapk.com/iphone/manifest.plist">
						<img class="responsive-image" src="img/images/ios.jpg" alt="img">
					</a>
					<a href="https://www.gameiosapk.com/android.php">
						<img class="responsive-image" src="img/images/android-new.jpg" alt="img">
					</a>
					<!--
					
                    <p>Atau download aplikasi Android versi lama untuk bermain <b>Domino</b> dan <b>Ceme</b>.</p>

					<a href="http://cdnappkita.xyz/">
						<img class="responsive-image" src="img/images/android.jpg" alt="img">
					</a>
					-->
                    <script type="text/javascript">
                        /*
                        $(document).ready(function){
                            $('a#download-android').click(
                                function(event){
                                    event.preventDefault();
                                    $(this).removeClass('colorbox cboxElement');
                                    return false;
                                }
                            )
                        };
                        */

                        /*
                        $(document).ready(function() {
                            $("a", "#download-android").click(
                              function(event) {
                                event.preventDefault();
                                var elementURL = $(this).attr("href");
                                $.colorbox({iframe: true, href: elementURL, innerWidth: 645, innerHeight: 509});
                            });
                        });
                        */
      				</script>

                </div>

            </div>
        </div>

        <?php include ("_footer.php");?>