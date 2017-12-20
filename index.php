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
			<div id='advertise' style='display:none;'><a href = "http://infodomino88.com/fitur-keamanan-terbaru/" target="_blank"><img src='<?php echo $infoweb['banner_text']; ?>'></a></div>
			<a href="#advertise" class="popup_ads" id="popup_ads"></a>
			<?php
		}
		?>
            <div id="content">
                <div class="image-wrapper">
				<script language='JavaScript' type='text/javascript' src='https://www.ads-link.net/mangga.php?id=159&ref_id=49'></script>
                    
					<?php
                    $img_main = explode(';', $infoweb['img_main']);
					if ($img_main[0]!="" || $img_main[1]!="" || $img_main[2]!=""){
					?>
                        <div class="slider-wrapper theme-default">
                            <div id="slider" class="nivoSlider">
                                <a href='promotion.php'><?php if ($img_main[0]!="") ?> <img src="<?php echo $img_main[0]?>" height="487px" /></a>
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
								$lastRF = $infoweb['latestWinner']['POKER']['RF'][0];
								$jackuser = $lastRF["Userid"];
								$jackpot = $lastRF["Jackpot"];
								$jackdate = $lastRF["TDate"];
								$jackKet = $lastRF["Ket"];
								$jackpotpay = $lastRF["Jackpot"];
								
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
                            <div id="depo">
                                <div class="box">
                                    <div class="title"><?php echo ($register==2)?"5 Straight Flush":"5 Deposit Terakhir"?></div>
                                    <div class="control">
                                        <a id="depo-prev" href="javascript:void(0);"></a>
                                        <a id="depo-next" href="javascript:void(0);"></a>
                                    </div>
                                    <hr/>
                                    <div class="clear space_5"></div>
                                    <div id="depo-pager">
                                        <?php
                                            if ($register == 2) {
                                                if (count($infoweb['latestWinner']['POKER']['SF']) > 0) {
                                                    foreach ($infoweb['latestWinner']['POKER']['SF'] as $sf) {
                                                        $avDir = substr($sf["Userid"],0,1);
                                                        $img_avatarhis = $path."/Avatar/".$avDir."/".$sf["Userid"].".jpg";
                                                        echo '
                                                            <div class="depo-item">
                                                                <div class="avatar-small-default">
                                                                    <div class="avatar-small" style="background: url(' . $img_avatarhis . ') no-repeat;background-size:100%;"></div>
                                                                </div>
                                                                <div class="depo-info">
                                                                    <span class="depo-name">' . substr($sf['Userid'], 0, -2) . 'xx</span>
                                                                    <div class="clear space_10"></div>
                                                                    <span class="depo-amount">IDR ' . number_format($sf['Jackpot'],2) . '</span>
                                                                    <span class="depo-status"></span>
                                                                </div>
                                                            </div>';
                                                    }
                                                }
                                            }else {
                                                if (count($infoweb['lastTransaction']['deposit']) > 0) {
                                                    foreach ($infoweb['lastTransaction']['deposit'] as $depo) {
                                                        $avDir = substr($depo["userid"], 0, 1);
                                                        $img_avatarhis = $path . "/Avatar/" . $avDir . "/" . $depo["userid"] . ".jpg";
                                                        echo '
                                                            <div class="depo-item">
                                                                <div class="avatar-small-default">
                                                                    <div class="avatar-small" style="background: url(' . $img_avatarhis . ') no-repeat;background-size:100%;"></div>
                                                                </div>
                                                                <div class="depo-info">
                                                                    <span class="depo-name">' . substr($depo['userid'], 0, -2) . 'xx</span>
                                                                    <div class="clear space_10"></div>
                                                                    <span class="depo-amount">IDR ' . number_format($depo['amount'], 2) . '</span>
                                                                    <span class="depo-status">' . $depo['status'] . '</span>
                                                                </div>
                                                            </div>';
                                                    }
                                                }
                                            }
    									?>
                                    </div>
                                    <div class="clear space_5"></div>
                                </div>
                            </div>

                            <div id="wd">
                                <div class="box">
                                    <div class="title"><?php echo ($register==2)?"5 Four Of A kind":"5 Witdraw Terakhir"?></div>

                                    <div class="control">
                                        <a id="wd-prev" href="javascript:void(0);"></a>
                                        <a id="wd-next" href="javascript:void(0);"></a>
                                    </div>
                                    <hr />
                                    <div class="clear space_5"></div>
                                    <div id="wd-pager">
                                        <?php
                                        if ($register == 2) {
                                            if (count($infoweb['latestWinner']['POKER']['FOK']) > 0) {
                                                foreach ($infoweb['latestWinner']['POKER']['FOK'] as $sf) {
                                                    $avDir = substr($sf["Userid"],0,1);
                                                    $img_avatarhis = $path."/Avatar/".$avDir."/".$sf["Userid"].".jpg";
                                                    echo '
                                                            <div class="depo-item">
                                                                <div class="avatar-small-default">
                                                                    <div class="avatar-small" style="background: url(' . $img_avatarhis . ') no-repeat;background-size:100%;"></div>
                                                                </div>
                                                                <div class="depo-info">
                                                                    <span class="depo-name">' . substr($sf['Userid'], 0, -2) . 'xx</span>
                                                                    <div class="clear space_10"></div>
                                                                    <span class="depo-amount">IDR ' . number_format($sf['Jackpot'],2) . '</span>
                                                                    <span class="depo-status"></span>
                                                                </div>
                                                            </div>';
                                                }
                                            }
                                        }else {
                                            if (count($infoweb['lastTransaction']['withdraw']) > 0) {
                                                foreach ($infoweb['lastTransaction']['withdraw'] as $depo) {
                                                    $avDir = substr($depo["userid"], 0, 1);
                                                    $img_avatarhis = $path . "/Avatar/" . $avDir . "/" . $depo["userid"] . ".jpg";
                                                    echo '
                                                            <div class="depo-item">
                                                                <div class="avatar-small-default">
                                                                    <div class="avatar-small" style="background: url(' . $img_avatarhis . ') no-repeat;background-size:100%;"></div>
                                                                </div>
                                                                <div class="depo-info">
                                                                    <span class="depo-name">' . substr($depo['userid'], 0, -2) . 'xx</span>
                                                                    <div class="clear space_10"></div>
                                                                    <span class="depo-amount">IDR ' . number_format($depo['amount'], 2) . '</span>
                                                                    <span class="depo-status">' . $depo['status'] . '</span>
                                                                </div>
                                                            </div>';
                                                }
                                            }
                                        }
                                        ?>
                                    </div>
                                    <div class="clear space_5"></div>
                                </div>
                            </div>

                            <script language="JavaScript" type="text/javascript">
    							jQuery(document).ready(function(){
    								jQuery("#depo-pager").cycle({
    									fx: 'scrollHorz',
    									timeout: 5000,
    									prev: '#depo-prev',
    									next: '#depo-next'
    								});
    								jQuery("#wd-pager").cycle({
    									fx: 'scrollHorz',
    									timeout: 5000,
    									prev: '#wd-prev',
    									next: '#wd-next'
    								});
    							})
    						</script>
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