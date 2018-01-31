
<?php
$page='home';

include("_metax.php");
include("_header.php");

session_start();

if (!$_SESSION["login"]){
    echo "<script>window.location = 'index.php'</script>";
    die();
}


$txt_script = explode("__lc.license = ",$infoweb['script_text']);
$lisence = substr($txt_script[1],0,7);
?>

        <div class="content">

            <div class="container main no-bottom">

                <div class="wrapper">

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
                        <a href="deposit.php" class="button-icons button-extra-big button-blues">
                            <div class="icon-deposit"></div>
                            <div class="menu">DEPOSIT</div>
                        </a>
                        <a href="withdraw.php" class="button-icons button-extra-big button-blues">
                            <div class="icon-withdraw"></div>
                            <div class="menu">WITHDRAW</div>
                        </a>
                        <a href="referral.php" class="button-icons button-extra-big button-blues">
                            <div class="icon-ref"></div>
                            <div class="menu">REFERRAL</div>
                        </a>
                        <a href="games.php" class="button-icons button-extra-big button-blues">
                            <div class="icon-games"></div>
                            <div class="menu">JENIS PERMAINAN</div>
                        </a>
                        <a href="#" class="button-icons button-extra-big button-blues" rel="nofollow" onclick="window.open('https://chat1c.livechatinc.com/licence/<?php echo $lisence;?>/open_chat.cgi?lang=en&amp;groups=0&amp;'+'dc='+escape(document.cookie+';l='+document.location+';r='+document.referer+';s='+typeof lc_session),'Czat_4225581','width=530,height=520,resizable=yes,scrollbars=no,status=1');return false;">
                            <div class="icon-chat"></div>
                            <div class="menu">LIVE CHAT</div>
                        </a>
                    </div>

                </div>

            </div>
        </div>

        <?php include ("_footer.php");?>