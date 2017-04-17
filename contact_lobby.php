<?php
$freePage = 1;
include("meta_lobby.php");
?>
<body>
<link rel="stylesheet" type="text/css" href="lobby/css/style.css">

                <div class="container">

                  

                    <div class="wrap">
                        <div class="full">
                            <div style="background:url(lobby/img/lobby_inside_header.png) no-repeat;width:980px;height:50px;margin-left:10px;border:none;">
                                <center><h1 class="participant-h" style="font-family:Helvetica,Roboto,Arial,sans-serif;font-size:33px;color:#b3b3b3;padding-top:7px;"><?php echo P_HELP;?></h1></center>
                            </div>
                            

                            <div class="body-wrap text-justify">
                                <div class="tabs">	
                                    <ul class="tab-links" style="margin-left:185px;margin-bottom:6px;">
                                        <li class="active"><a href="#tab1" style="padding-left:75px;padding-right:75px;"><?php echo strtoupper(P_CONTACTUS);?></a></li>
                                        <li><a href="#tab2" style="padding-left:75px;padding-right:75px;"><?php echo strtoupper(P_HOWTOPLAY);?></a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="tab1" class="tab active">
                                            <div style='font-family:Arial;font-size:14px;'><?php echo P_HAVECOMMENTAR; ?></div>
											<div class="space_20"></div>
											<table>
											<?php
											if($yahoo_id)echo "<tr><td width=80><img src='assets/js/quickAccess/icons/light_icons/varia_3.png'></td><td><h4>$yahoo_id</h4></td></tr>";
											if($skype_id)echo "<tr><td><img src='assets/js/quickAccess/icons/light_icons/varia_4.png'></td><td><h4>$skype_id</h4></td></tr>";
											if($bbm_id)echo "<tr><td><img src='assets/js/quickAccess/icons/light_icons/varia_2.png'></td><td><h4>$bbm_id</h4></td></tr>";
											if($wechat_id)echo "<tr><td><img src='assets/js/quickAccess/icons/light_icons/varia_1.png'></td><td><h4>$wechat_id</h4></td></tr>";
											if($phone_id)echo "<tr><td><img src='assets/js/quickAccess/icons/light_icons/varia_5.png'></td><td><h4>$phone_id</h4></td></tr>";
											if($whatsapp_id)echo "<tr><td><img src='assets/js/quickAccess/icons/light_icons/varia_6.png'></td><td><h4>$whatsapp_id</h4></td></tr>";
											if($facebook_id)echo "<tr><td><img src='assets/js/quickAccess/icons/light_icons/varia_7.png'></td><td><h4>$facebook_id</h4></td></tr>";
											if($twitter_id)echo "<tr><td><img src='assets/js/quickAccess/icons/light_icons/varia_8.png'></td><td><h4>$twitter_id</h4></td></tr>";
											/*$q_howtoplay=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select howtoplay_text from u6048user_agencyruntext where agent='".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
											echo str_replace("/r/n","<br>",$q_howtoplay["howtoplay_text"]);*/
											?>
											</table>
                                        </div>

                                        <div id="tab2" class="tab">
												<?php
												$q_howtoplay=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select howtoplay_text from u6048user_agencyruntext where agent='".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
												echo str_replace("\r\n","<br>",$q_howtoplay["howtoplay_text"]);
												?>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                 

                    <div class="clear space_30"></div>
                </div>
            </div>
	</body>
</html>