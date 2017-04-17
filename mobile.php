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
                                <h1><?php echo P_POKERANDROIDVERSION;?></h1>
                            </div>

                            <div class="body-wrap text-justify">
                                <div class="tabs">
                                    <ul class="tab-links">
                                        <li class="active"><a href="#tab1"><?php echo P_POKERIOS; ?></a></li>
                                        <!--<?php if($subwebid!="9001" && $subwebid!="9002"){?><li><a href="#tab2"><?php echo P_POKERANDROID; ?></a></li><?php } ?>-->
										<li><a href="#tab3"><?php echo P_POKERANDROID." NEW"; ?></a></li>
                                    </ul>
                                    <?php
                  					    $filen = "poker.apk";
                  					    $fsize = round((filesize($filen) / 1024000), 2);
                  					?>

                                    <div class="tab-content">
                                        <div id="tab1" class="tab active">
                                            <div align="center">
											<?php if($subwebid=="9001"){?>
                                                <a href="itms-services://?action=download-manifest&url=https://www.gameiosapk.com/m-kartupoker/iphone/manifest.plist"><img src="assets/images/ios-image.jpg" /></a>
											<?php }elseif($subwebid=="9002"){ ?>
												<a href="itms-services://?action=download-manifest&url=https://www.gameiosapk.com/m-remipoker/iphone/manifest.plist"><img src="assets/images/ios-image.jpg" /></a>
											<?php }else{?>
												<a href="itms-services://?action=download-manifest&url=https://www.gameiosapk.com/iphone/manifest.plist"><img src="assets/images/ios-image.jpg" /></a>
											<?php }?>
										  </div>
                                        </div>

                                        <!--<div id="tab2" class="tab">
                                            <div align="center">
											<?php if($subwebid=="9001"){?>
                                                <a href="http://www.txpkr.com"><img src="assets/images/android-image.jpg" /></a>
											<?php }elseif($subwebid=="9002"){ ?>
												 <a href="http://www.txpkr.com"><img src="assets/images/android-image.jpg" /></a>
												<?php }else{?>
												<a href="http://cdnappkita.xyz"><img src="assets/images/android-image.jpg" /></a>
												<?php } ?>
                                            </div>

                                            <div style="height:20px;"></div>

                                            <h4><?php echo P_INSTALLATIONINSTRUCTION;?></h4>
                                            <div style="height:5px;"></div>
                            				<ol>
                            					<li><?php echo P_DOWNLOADFILE; ?> <a href="http://www.txpkr.com/"><?php echo"".$filen."";?>(<?php echo P_SIZE;?> 13 MB)</a></li>
                            					<li><?php echo P_AFTERDOWNLOAD; ?> <?php echo"".$filen."";?>.
                                                <br/>NB: <?php echo P_IFCANTDOINSTALL; ?>
                                                </li>
                            					<li><?php echo P_AFTERINSTALL;?></li>
                            					<li><?php echo P_BESTVIEW;?></li>
                            				</ol>
                                        </div>-->
										<div id="tab3" class="tab">
                                            <div align="center">
											<?php if($subwebid=="9001"){?>
                                                <a href="https://www.gameiosapk.com/m-kartupoker/android/KartuPoker.apk"><img src="assets/images/android-image-new.jpg" /></a>
											<?php }elseif($subwebid=="9002"){ ?>
												 <a href="https://www.gameiosapk.com/m-remipoker/android/RemiPoker.apk"><img src="assets/images/android-image-new.jpg" /></a>
											<?php }else{?>
											 <a href="https://www.gameiosapk.com/android/poker.apk"><img src="assets/images/android-image-new.jpg" /></a>
											<?php } ?>
                                            </div>
										
                                            <div style="height:20px;"></div>

                                           <!-- <h4><?php echo P_INSTALLATIONINSTRUCTION;?></h4>
                                            <div style="height:5px;"></div>
                            				<ol>
                            					<li><?php echo P_DOWNLOADFILE; ?> <a href="http://www.txpkr.com/"><?php echo"".$filen."";?>(<?php echo P_SIZE;?>  MB)</a></li>
                            					<li><?php echo P_AFTERDOWNLOAD; ?> <?php echo"".$filen."";?>.
                                                <br/>NB: <?php echo P_IFCANTDOINSTALL; ?>
                                                </li>
                            					<li><?php echo P_AFTERINSTALL;?></li>
                            					<li><?php echo P_BESTVIEW;?></li>
                            				</ol>-->
                                        </div>
                                    </div>
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