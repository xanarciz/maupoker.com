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
                                <h1>Bantuan</h1>
                            </div>

                            <div class="body-wrap text-justify">
                                <div class="tabs">
                                    <ul class="tab-links">
                                        <li class="active"><a href="#tab1">Hubungi kami</a></li>
                                    </ul>

                                    <div class="tab-content">
                                        <div id="tab1" class="tab active">
                                            <div>Apabila Anda memiliki komentar/pertanyaan, silahkan hubungi kami melalui bantuan yang tersedia.</div>
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
											if($line_id)echo "<tr><td><img src='assets/js/quickAccess/icons/light_icons/varia_9.png'></td><td><h4>$line_id</h4></td></tr>";
											?>
											</table>
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