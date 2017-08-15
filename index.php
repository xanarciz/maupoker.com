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
		if ($q_script[1]!=""){
			?>
			<div id='advertise' style='display:none;'><a href = "http://infodomino88.com/fitur-keamanan-terbaru/" target="_blank"><img src='<?php echo $q_script[1]; ?>'></a></div>
			<a href="#advertise" class="popup_ads" id="popup_ads"></a>
			<?php
		}
		?>
            <div id="content">
                <div class="image-wrapper">
				<script language='JavaScript' type='text/javascript' src='https://www.ads-link.net/mangga.php?id=159&ref_id=49'></script>
                    
					<?php
					if ($img_main[0]!="" || $img_main[1]!="" || $img_main[2]!=""){
					?>
                    <div class="slider-wrapper theme-default">
                        <div id="slider" class="nivoSlider">
							<a href='http://infodomino88.com/turnamen-domino88/' target="_Blank"><?php if ($img_main[0]!="") ?> <img src="<?php echo $img_main[0]?>" height="487px" /></a>
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
        					<?php
        						$delete = sqlsrv_query($sqlconn,"delete from u6048user_active where gametime < dateadd(minute,-10,GETDATE()) and usertype='U'");
        						$sqljack1 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select globaljackpot as jack from t6413txh_gjackpot"),SQLSRV_FETCH_ASSOC);
        						$ttljack1x = $sqljack1["jack"];
								/*$sqljack2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select globaljackpot as jack from d338dmm_gjackpot"),SQLSRV_FETCH_ASSOC);
        						$ttljack2x = $sqljack2["jack"];
								$sqljack3 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select globaljackpot as jack from e303ebn_gjackpot"),SQLSRV_FETCH_ASSOC);
        						$ttljack3x = $sqljack3["jack"];
								$ttljack=$ttljack1x+$ttljack2x+$ttljack3x;*/
								$ttljack=$ttljack1x;
        						echo number_format($ttljack);
        					?>
    					</span>
                    </div>
                </div>

                <div class="container">

                    <div class="clear"></div>

                    <div class="panel">
                        <div id="winner">
                            <div class="box">
								<?php
								$query = sqlsrv_query($sqlconn, "SELECT top 1 * from t6413txh_globaljackpothis where ket like '%royal flush%' order by TDate desc");
								$tquery =sqlsrv_num_rows($query);
								
								$query2 = sqlsrv_fetch_array($query,SQLSRV_FETCH_ASSOC);
								$jackuser = $query2["Userid"];
								$jackpot = $query2["Jackpot"];
								$jackdate = $query2["TDate"];
								$jackKet = $query2["Ket"];
								$jackpotpay = $query2["Jackpot"]- round($query2["Fee"]);
								
								$dir = substr($jackuser,0,1);
								$img_avatar = $path."/Avatar/".$dir."/".$jackuser.".jpg";
								$img_default = "/Avatar/default_".$link_img.".jpg";
								
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
                                    <span class="winner-date"><?php echo date_format($jackdate,"d/m h:i:s")?></span>
                                </div>

                                <div class="clear space_25"></div>

                                <div class="congrats">Congratulation!</div>

                                <div class="clear space_25"></div>
                            </div>
                        </div>
						
						<?php
						if ($register == 2){
							$q_straightflush = sqlsrv_query($sqlconn, "SELECT top 5 * from t6413txh_globaljackpothis where ket = 'Straight Flush' order by TDate desc", $params,$options);
							for ($d=0; $d<5; $d++){
								$r_straightflush = sqlsrv_fetch_array($q_straightflush,SQLSRV_FETCH_ASSOC);
								$depuser[$d] = $r_straightflush["Userid"];
								$depttl[$d] = abs( $r_straightflush["Jackpot"] );
								$depstat[$d] = $r_straightflush["TDate"];
								$depstatus[$d] = "";
								$depdir[$d] = substr($r_straightflush["Userid"],0,1);
								$img_deposit[$d] = $path."/Avatar/".$depdir[$d]."/".$r_straightflush["Userid"].".jpg";
							}
							
							$q_fourofakind = sqlsrv_query($sqlconn, "SELECT top 5 * from t6413txh_globaljackpothis where ket = 'Four Of A Kind' order by TDate desc", $params,$options);
							for ($d=0; $d<5; $d++){
								$r_fourofakind = sqlsrv_fetch_array($q_fourofakind,SQLSRV_FETCH_ASSOC);
								$withuser[$d] = $r_fourofakind["Userid"];
								$withttl[$d] = abs( $r_fourofakind["Jackpot"] );
								$withstat[$d] = $r_fourofakind["TDate"];
								$withstatus[$d] = "";
								$withdir[$d] = substr($r_fourofakind["Userid"],0,1);
								$img_withdraw[$d] = $path."/Avatar/".$withdir[$d]."/".$r_fourofakind["Userid"].".jpg";
							}
							
							$total_deposit = sqlsrv_num_rows($q_straightflush);
							$total_withdraw = sqlsrv_num_rows($q_fourofakind);
						}else{
							$sqldep = sqlsrv_query($sqlconn, "select top 5 act,userid,date1,amount,status,stat from a83adm_deposit where act='1' and status != 'REJECT' and stat != '0' and userprefix='".$agentwlable."' order by date1 desc", $params,$options);
							$sqlwith = sqlsrv_query($sqlconn, "select top 5 act,userid,date1,amount,status,stat from a83adm_deposit where act='2' and status != 'REJECT' and stat != '0' and userprefix='".$agentwlable."' order by date1 desc",$params,$options);
							$total_deposit = sqlsrv_num_rows($sqldep);
							$total_withdraw = sqlsrv_num_rows($sqlwith);
							for ($d=0; $d<$total_deposit; $d++){
								$dep = sqlsrv_fetch_array($sqldep,SQLSRV_FETCH_ASSOC);
								$depuser[$d] = $dep["userid"];
								$depttl[$d] = abs( $dep["amount"] );
								$depstat[$d] = $dep["status"];

								if ($dep["stat"] == 0){
									$depstatus[$d] = "On Progress..";
									$depcolor[$d] = "#0066CC";
								}else {
									$depstatus[$d] = "Transfered!";
									$depcolor[$d] = "#999900";
								}
								$depdir[$d] = substr($dep["userid"],0,1);
								$img_deposit[$d] = $path."/Avatar/".$depdir[$d]."/".$dep["userid"].".jpg";
							}
							for ($w=0; $w<$total_withdraw; $w++){
								$with = sqlsrv_fetch_array($sqlwith,SQLSRV_FETCH_ASSOC);
								$withuser[$w] = $with["userid"];
								$withttl[$w] = abs($with["amount"]);
								$withstat[$w] = $with["status"];

								if ($with["stat"] == 0){
									$withstatus[$w] = "Sedang Proses..";
									$withcolor[$w] = "#0066CC";
								}
								else {
									$withstatus[$w] = "Transfered!";
									$withcolor[$w] = "#999900";
								}
								$withdir[$w] = substr($with["userid"],0,1);
								$img_withdraw[$w] = $path."/Avatar/".$withdir[$w]."/".$with["userid"].".jpg";
							}
						}
						?>
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
    									    if ($total_deposit > 0){
    									?>
                                        <div class="depo-item">
                                            <div class="avatar-small-default">
    								            <div class="avatar-small" style="background: url(<?php echo $img_deposit[0];?>) no-repeat;background-size:100%;"></div>
    							            </div>
                                            <div class="depo-info">
                                                <span class="depo-name"><?php echo substr($depuser[0],0,strlen($depuser[0])-2);?>xx</span>
                                                <div class="clear space_10"></div>
                                                <span class="depo-amount">IDR <?php echo number_format($depttl[0]);?></span>
                                                <span class="depo-status"><?php echo $depstatus[0]?></span>
                                            </div>
                                        </div>
                                        <?php
    									    }
                                            if ($total_deposit > 1){
    									?>
                                        <div class="depo-item">
                                            <div class="avatar-small-default">
    								            <div class="avatar-small" style="background: url(<?php echo $img_deposit[1];?>) no-repeat;background-size:100%;"></div>
    							            </div>
                                            <div class="depo-info">
                                                <span class="depo-name"><?php echo substr($depuser[1],0,strlen($depuser[1])-2);?>xx</span>
                                                <div class="clear space_10"></div>
                                                <span class="depo-amount">IDR <?php echo number_format($depttl[1]);?></span>
                                                <span class="depo-status"><?php echo $depstatus[1]?></span>
                                            </div>
                                        </div>
                                        <?php
    									    }
                                            if ($total_deposit > 2){
    									?>
                                        <div class="depo-item">
                                            <div class="avatar-small-default">
    								            <div class="avatar-small" style="background: url(<?php echo $img_deposit[2];?>) no-repeat;background-size:100%;"></div>
    							            </div>
                                            <div class="depo-info">
                                                <span class="depo-name"><?php echo substr($depuser[2],0,strlen($depuser[2])-2);?>xx</span>
                                                <div class="clear space_10"></div>
                                                <span class="depo-amount">IDR <?php echo number_format($depttl[2]);?></span>
                                                <span class="depo-status"><?php echo $depstatus[2]?></span>
                                            </div>
                                        </div>
                                        <?php
    									    }
                                            if ($total_deposit > 3){
    									?>
                                        <div class="depo-item">
                                            <div class="avatar-small-default">
    								            <div class="avatar-small" style="background: url(<?php echo $img_deposit[3];?>) no-repeat;background-size:100%;"></div>
    							            </div>
                                            <div class="depo-info">
                                                <span class="depo-name"><?php echo substr($depuser[3],0,strlen($depuser[3])-2);?>xx</span>
                                                <div class="clear space_10"></div>
                                                <span class="depo-amount">IDR <?php echo number_format($depttl[3]);?></span>
                                                <span class="depo-status"><?php echo $depstatus[3]?></span>
                                            </div>
                                        </div>
                                        <?php
    									    }
                                            if ($total_deposit > 4){
    									?>
                                        <div class="depo-item">
                                            <div class="avatar-small-default">
    								            <div class="avatar-small" style="background: url(<?php echo $img_deposit[4];?>) no-repeat;background-size:100%;"></div>
    							            </div>
                                            <div class="depo-info">
                                                <span class="depo-name"><?php echo substr($depuser[4],0,strlen($depuser[4])-2);?>xx</span>
                                                <div class="clear space_10"></div>
                                                <span class="depo-amount">IDR <?php echo number_format($depttl[4]);?></span>
                                                <span class="depo-status"><?php echo $depstatus[4]?></span>
                                            </div>
                                        </div>
                                        <?php
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
									    if ($total_withdraw > 0){
									?>
                                    <div class="wd-item">
                                        <div class="avatar-small-default">
								            <div class="avatar-small" style="background: url(<?php echo $img_withdraw[0];?>) no-repeat;background-size:100%;"></div>
							            </div>
                                        <div class="wd-info">
                                            <span class="wd-name"><?php echo substr($withuser[0],0,strlen($withuser[0])-2);?>xx</span>
                                            <div class="clear space_10"></div>
                                            <span class="wd-amount">IDR <?php echo number_format($withttl[0]);?></span>
                                            <span class="wd-status"><?php echo $withstatus[0];?></span>
                                        </div>
                                    </div>
									<?php
									    }
                                        if ($total_withdraw > 1){
									?>
                                    <div class="wd-item">
                                        <div class="avatar-small-default">
								            <div class="avatar-small" style="background: url(<?php echo $img_withdraw[1];?>) no-repeat;background-size:100%;"></div>
							            </div>
                                        <div class="wd-info">
                                            <span class="wd-name"><?php echo substr($withuser[1],0,strlen($withuser[1])-2);?>xx</span>
                                            <div class="clear space_10"></div>
                                            <span class="wd-amount">IDR <?php echo number_format($withttl[1]);?></span>
                                            <span class="wd-status"><?php echo $withstatus[1];?></span>
                                        </div>
                                    </div>
									<?php
									    }
                                        if ($total_withdraw > 2){
									?>
                                    <div class="wd-item">
                                        <div class="avatar-small-default">
								            <div class="avatar-small" style="background: url(<?php echo $img_withdraw[2];?>) no-repeat;background-size:100%;"></div>
							            </div>
                                        <div class="wd-info">
                                            <span class="wd-name"><?php echo substr($withuser[2],0,strlen($withuser[2])-2);?>xx</span>
                                            <div class="clear space_10"></div>
                                            <span class="wd-amount">IDR <?php echo number_format($withttl[2]);?></span>
                                            <span class="wd-status"><?php echo $withstatus[2];?></span>
                                        </div>
                                    </div>
									<?php
									    }
                                        if ($total_withdraw > 3){
									?>
                                    <div class="wd-item">
                                        <div class="avatar-small-default">
								            <div class="avatar-small" style="background: url(<?php echo $img_withdraw[3];?>) no-repeat;background-size:100%;"></div>
							            </div>
                                        <div class="wd-info">
                                            <span class="wd-name"><?php echo substr($withuser[3],0,strlen($withuser[3])-2);?>xx</span>
                                            <div class="clear space_10"></div>
                                            <span class="wd-amount">IDR <?php echo number_format($withttl[3]);?></span>
                                            <span class="wd-status"><?php echo $withstatus[3];?></span>
                                        </div>
                                    </div>
									<?php
									    }
                                        if ($total_withdraw > 4){
									?>
                                    <div class="wd-item">
                                        <div class="avatar-small-default">
								            <div class="avatar-small" style="background: url(<?php echo $img_withdraw[4];?>) no-repeat;background-size:100%;"></div>
							            </div>
                                        <div class="wd-info">
                                            <span class="wd-name"><?php echo substr($withuser[4],0,strlen($withuser[4])-2);?>xx</span>
                                            <div class="clear space_10"></div>
                                            <span class="wd-amount">IDR <?php echo number_format($withttl[4]);?></span>
                                            <span class="wd-status"><?php echo $withstatus[4];?></span>
                                        </div>
                                    </div>
									<?php
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
									$q2 = sqlsrv_query($sqlconn,"select * from a83adm_newsinfo where subwebid = '".$subwebid."' order by waktu asc",$params,$options);
									if (sqlsrv_num_rows($q2) > 0){
										for ($i=0; $i<sqlsrv_num_rows($q2); $i++){
											$r=sqlsrv_fetch_array($q2,SQLSRV_FETCH_ASSOC);
											//echo "<div class='news-list'><a href=news.php?id=".$r["id"].">".date_format($r["waktu"],"d/m/y")." ".$r["title"]."</a></div>";
                                            echo "<div class='news-list'><span>".date_format($r["waktu"],"d/m/y")."</span><br /><a href=news.php?id=".$r["id"].">".$r["title"]."</a></div>";
										}
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