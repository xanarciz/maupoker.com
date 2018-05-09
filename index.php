<?php
require_once 'mobile_detect.php';
$detect = new Mobile_Detect;
$check_mobile = $detect->isMobile();
//var_dump($check_mobile);
$check_tablet = $detect->isTablet();
//var_dump($check_tablet);
if($check_mobile==1 || $check_tablet==1){	
	header("location:m");
	exit();
}
include("meta.php");
include("header.php");

if ($_SESSION["login"]){
	echo "<script>window.location='deposit.php'</script>";
}
		if ($infoweb['banner_text']!=""){
			?>
			<div id='advertise' style='display:none;'><img src='<?php echo $infoweb['banner_text']; ?>'></div>
			<a href="#advertise" class="popup_ads" id="popup_ads"></a>
			<?php
		}
		?>
            <div id="content">
                <div class="image-wrapper">
                    
					<?php
                    $img_main = explode(';', $infoweb['img_main']);
					if ($img_main[0]!="" || $img_main[1]!="" || $img_main[2]!=""){
					?>
                        <div class="slider-wrapper theme-default">
                            <div id="slider" class="nivoSlider">
                                <?php if ($img_main[0]!="") ?> <img src="<?php echo $img_main[0]?>" height="487px" />
                                <?php if ($img_main[1]!="") ?> <img src="<?php echo $img_main[1]?>" height="487px" />
                                <?php if ($img_main[2]!="") ?> <img src="<?php echo $img_main[2]?>" height="487px" />
                            </div>
                        </div>
					<?php
					}else{
					?>
					    <div id="big-image"></div>
					<?php
					}
					?>
                </div>

                <div id="middle">
                    <div class="reg-btn">
    				    <?php if (!$login && $register != 2){?>
    					    <a href="register.php">
    					        <span>DAFTAR DISINI</span>
    					    </a>
    					<?php }else if (!$login && $register != 1){?>
    					    <a href="how-to-play.php">
    						    <span>CARA BERMAIN!</span>
    					    </a>
    					<?php }else{ ?>
    					    <a href="txh/txh.php">
    						    <span>MULAI MAIN!</span>
    					    </a>
    					<?php }?>
                    </div>
                    <div class="jackwin-btn">
					    <a href="jackpot.php">
							<span>JACKPOT WINNER</span>
						</a>
                    </div>

                    <div class="jackpot">
                        <div class="jackpot-img"></div>
                        <span>
        					<?php echo number_format($infoweb['globalJack']); ?>
    					</span>
                    </div>
                </div>

                <div class="container">

                    <div class="clear"></div>

                    <div class="panel">
                        <div id="winner">
                            <div class="box">
								<?php
								$jpwinner = sendAPI($url_Api."/jpwinner",'','JSON','02e97eddc9524a1e');
								$lastRF = $jpwinner->data;
								$jackuser = $lastRF->userid;
								$jackpot = $lastRF->Jackpot;
								$jackdate = $lastRF->TDate;
								$jackKet = $lastRF->Ket;
								$jackpotpay = $lastRF->Jackpot;
								
								$dir = substr($jackuser,0,1);
								$img_avatar = $path."/Avatar/".$dir."/".$jackuser.".jpg";
								$img_default = "/Avatar/default.jpg";
								
								?>
                                <div class="title">PEMENANG ROYALFLUSH TERAKHIR</div>
                                <hr />
                                <div class="clear space_10"></div>

                                <div class="avatar-default">
									<div class="avatar" style="background: url(<?php echo $img_avatar?>) no-repeat;background-size:123px 123px;"></div>
								</div>

                                <div class="jackpot-info">
                                    <span class="winner-name"><?php echo strtoupper($jackuser);?></span>
                                    <div class="clear space_5"></div>
                                    <span class="win-icon"></span><span class="winner-card"><?php echo $jackKet;?></span>
                                    <div class="clear space_5"></div>
                                    <span class="money-icon"></span><span class="winner-amount">IDR <?php echo number_format($jackpot);?></span>
                                    <div class="clear space_5"></div>
                                    <span class="winner-date"><?php echo date('d/m h:i:s', strtotime($jackdate))?></span>
                                </div>

                                <div class="clear space_25"></div>

                                <div class="congrats">Congratulation!</div>

                                <div class="clear space_25"></div>
                            </div>
                        </div>
                        <div id="latest">
							<a href="http://wlpromo.info/" target="_blank">
								<img src="https://wlpromo.info/banner.gif" style="width:325px;">
							</a>
                        </div>

                        <div id="member-online">
                            <div class="box">
                                <div class="title-user"><span class="online-icon"></span><span class="online-text">Pengumuman</span></div>

                                <div class="clear"></div>

                                <div class="user">
                                    <div class="space_10"></div>
									<?php
                                    foreach ($infoweb['newsAgent'] as $id => $contain){
                                        $id = str_replace('id_', '', $id);
                                        echo "<div class='news-list'><span>" . date('d/m/y', strtotime($contain["waktu"])) . "</span><br /><a href=news.php?id=". $id .">".$contain["title"]."</a></div>";
                                    }
									?>
                                    
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="clear space_30"></div>
                </div>
            </div>
<?php
include("footer.php");
?>