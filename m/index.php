<?php
$page='home';
include("_metax.php");
include("_header.php");
$img_main = explode(';', $infoweb['img_main']);
if(!isset($sid)){$sid = '';}
$param = $_SESSION['login'].",".$sid;

?>

        <div class="content">

            <div class="container main no-bottom">

                <?php
                if ($_SESSION["login"]){
                	echo "<script>window.location = 'login.php'</script>";
                	
                }
                ?>

                <div class="wrapper">

                	<div class="slider-container">
                        <?php
    					if ($img_main[0]!="" || $img_main[1]!="" || $img_main[2]!=""){
    					?>
                        <div class="homepage-slider" data-snap-ignore="true">
                            <div>
                                <?php if ($img_main[0]!="") ?><img src="<?php echo $img_main[0]?>" class="responsive-image">
                            </div>
                            <div>
                                <?php if ($img_main[1]!="") ?><img src="<?php echo $img_main[1]?>" class="responsive-image">
                            </div>
                            <div>
                                <?php if ($img_main[2]!="") ?><img src="<?php echo $img_main[2]?>" class="responsive-image">
                            </div>
                        </div>
                        <?php
    					}else{
							?>
							<img src="../assets/img/<?php echo $link_img;?>/big-image.jpg" style="width:100%;">
							<?php
						}
    					?>
                        <div class="homepage-slider-controls">
                            <a href="#" class="next-home"></a>
                            <a href="#" class="prev-home"></a>
                        </div>
                    </div>

                  
                    <div class="jackpot">
                        <div class="jackpot-text">GLOBAL JACKPOT</div>
                        <div class="decorations"></div>
                        <div class="jackpot-global"><?php echo number_format($infoweb['globalJack']); ?></div>
                    </div>

                    <div class="button-group">
                        <a href="download.php" class="button-icons button-extra-big button-blues">
                            <div class="icon-download"></div>
                            <div class="menu">DOWNLOAD APLIKASI</div>
                        </a>
						<?php if ($register == 1){ ?>
                        <a href="daftar.php" class="button-icons button-extra-big button-blues">
                            <div class="icon-reg"></div>
                            <div class="menu">DAFTAR</div>
                        </a>
						<?php } ?>
                        <a href="games.php" class="button-icons button-extra-big button-blues">
                            <div class="icon-games"></div>
                            <div class="menu">JENIS PERMAINAN</div>
                        </a>
						<?php
						if ($lisence){
						?>
                        <a href="#" class="button-icons button-extra-big button-blues" rel="nofollow" onclick="window.open('https://chat1c.livechatinc.com/licence/<?php echo $lisence;?>/open_chat.cgi?lang=en&amp;groups=0&amp;'+'dc='+escape(document.cookie+';l='+document.location+';r='+document.referer+';s='+typeof lc_session),'Czat_4225581','width=530,height=520,resizable=yes,scrollbars=no,status=1');return false;">
                            <div class="icon-chat"></div>
                            <div class="menu">LIVE CHAT</div>
                        </a>
						<?php
						}
						?>
                    </div>

                </div>

            </div>
        </div>

        <?php include ("_footer.php");?>