   <?php
  	$txt_script = explode("__lc.license = ",$infoweb["script_text"]);
  	$lisence = substr($txt_script[1],0,7);
	if (strpos($q_script["script_text"],"tawk.to") ){
		$tawk = explode("<!--tawk-->",$infoweb["script_text"]);
		echo $tawk[1];
	}
	if (strpos($infoweb["script_text"],"zopim") ){
		$tawk = explode("<!--zopim-->",$infoweb["script_text"]);
		echo $tawk[1];
	}
	if (strpos($infoweb["script_text"],"livechat") ){
		$tawk = explode("<!--livechat-->",$infoweb["script_text"]);
		echo $tawk[1];
	}
  ?>
   <div id="sidebar" class="page-sidebar">

        <div class="page-sidebar-scroll">

        	<div class="sidebar-shortcuts">
                <a href="#" class="shortcut-close"></a>
            </div>

            <?php if ($_SESSION["login"]){ ?>

            <div class="navigation-item">
                <div style="height:10px;"></div>
                <span>Welcome,</span>
                <div class="nav-items user-icon"><?php echo $_SESSION["login"]; ?></div>
            </div>

            <div class="navigation-item">
                <div class="nav-items chips-icon"><span class="orange">IDR <?php echo number_format($coin); ?></span></div>
            </div>

            <div class="sidebar-decoration"></div>

            <div class="navigation-item">
                <a href="index.php" class="nav-item home-icon">HOME<em <?php if($page=="home"){ ?>class="selected-item"<?php } ?>class="unselected-item"></em></a>
            </div>

            <div class="sidebar-decoration"></div>

            <div class="navigation-item">
                <a href="download.php" class="nav-item download-icon">DOWNLOAD APLIKASI<em <?php if($page=="download"){ ?>class="selected-item"<?php } ?>class="unselected-item"></em></a>
            </div>

            <div class="sidebar-decoration"></div>

            <div class="navigation-item">
                <a href="deposit.php" class="nav-item deposit-icon">DEPOSIT<em <?php if($page=="deposit"){ ?>class="selected-item"<?php } ?>class="unselected-item"></em></a>
            </div>

            <div class="sidebar-decoration"></div>

            <div class="navigation-item">
                <a href="withdraw.php" class="nav-item withdraw-icon">WITHDRAW<em <?php if($page=="withdraw"){ ?>class="selected-item"<?php } ?>class="unselected-item"></em></a>
            </div>

            <div class="sidebar-decoration"></div>

            <div class="navigation-item">
                <a href="referral.php" class="nav-item ref-icon">REFERRAL<em <?php if($page=="referral"){ ?>class="selected-item"<?php } ?>class="unselected-item"></em></a>
            </div>

            <div class="sidebar-decoration"></div>

            <div class="navigation-item">
                <a href="games.php" class="nav-item games-icon">JENIS PERMAINAN<em <?php if($page=="games"){ ?>class="selected-item"<?php } ?>class="unselected-item"></em></a>
            </div>

            <div class="sidebar-decoration"></div>
			<?php 
			if ($lisence){
			?>
            <div class="navigation-item">
                <a href="#" class="nav-item livechat-icon" rel="nofollow" onclick="window.open('https://chat1c.livechatinc.com/licence/<?php echo $lisence;?>/open_chat.cgi?lang=en&amp;groups=0&amp;'+'dc='+escape(document.cookie+';l='+document.location+';r='+document.referer+';s='+typeof lc_session),'Czat_4225581','width=530,height=520,resizable=yes,scrollbars=no,status=1');return false;">LIVE CHAT<em class="unselected-item"></em></a>
            </div>
			<?php
			}
			?>
            <div class="sidebar-decoration"></div>

            <div class="navigation-item">
                <a href="../logout.php" class="nav-item logout-icon">LOG OUT</a>
            </div>

            <?php }else{ ?>

            <div class="navigation-item">
                <a href="index.php" class="nav-item home-icon">HOME<em <?php if($page=="home"){ ?>class="selected-item"<?php } ?>class="unselected-item"></em></a>
            </div>

            <div class="sidebar-decoration"></div>

            <div class="navigation-item">
                <a href="download.php" class="nav-item download-icon">DOWNLOAD APLIKASI<em <?php if($page=="download"){ ?>class="selected-item"<?php } ?>class="unselected-item"></em></a>
            </div>

            <div class="sidebar-decoration"></div>
			<?php if($register == 1){ ?>
            <div class="navigation-item">
                <a href="daftar.php" class="nav-item register-icon">DAFTAR<em <?php if($page=="daftar"){ ?>class="selected-item"<?php } ?>class="unselected-item"></em></a>
            </div>

            <div class="sidebar-decoration"></div>
			<?php } ?>
            <div class="navigation-item">
                <a href="games.php" class="nav-item games-icon">JENIS PERMAINAN<em <?php if($page=="games"){ ?>class="selected-item"<?php } ?>class="unselected-item"></em></a>
            </div>

            <div class="sidebar-decoration"></div>
			<?php
			if ($lisence){
			?>
            <div class="navigation-item">
                <a href="#" class="nav-item livechat-icon" rel="nofollow" onclick="window.open('https://chat1c.livechatinc.com/licence/<?php echo $lisence;?>/open_chat.cgi?lang=en&amp;groups=0&amp;'+'dc='+escape(document.cookie+';l='+document.location+';r='+document.referer+';s='+typeof lc_session),'Czat_4225581','width=530,height=520,resizable=yes,scrollbars=no,status=1');return false;">LIVE CHAT<em class="unselected-item"></em></a>
            </div>
			<?php
			}
			?>
            <?php } ?>

            <div class="sidebar-breadcrumb">&copy; 2015 <?php echo $_SERVER["SERVER_NAME"]?>. All Rights Reserved | 18+</div>

        </div>
    </div>

    <!--
    <div id="sidebar-right" class="page-sidebar-right">

        <div class="page-sidebar-scroll-right">

        	<div class="sidebar-shortcuts">
                <a href="#" class="shortcut-close"></a>
            </div>

            <div class="navigation-item">
                <div class="nav-items user-icon"><?php echo $_SESSION["login"]; ?></div>
            </div>

            <div class="sidebar-decoration"></div>

            <div class="navigation-item">
                <div class="nav-items chips-icon"><span class="orange">IDR <?php echo number_format($data["TXH"])?></span></div>
            </div>

            <div class="sidebar-decoration"></div>

            <div class="navigation-item">
                <a href="../../logoff.php" class="nav-item logout-icon">LOG OUT</a>
            </div>

            <div class="sidebar-decoration"></div>

        </div>

    </div>
    -->