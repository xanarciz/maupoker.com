
<?php
$freePage=1;
$page='games';
session_start();
$login = $_SESSION["login"];

if (!$login){
    include("_meta.php");
} else {
    include("_metax.php");
}

include("_header.php");
?>

        <div class="content">

            <div class="container main no-bottom">

                <div class="wrapper">

                    <div class="container no-bottom">
                    	<h3>Jenis Permainan</h3>
                    </div>

                    <div class="decoration"></div>

                    <p>Untuk dapat bermain dalam versi mobile, silakan download aplikasi <a href="download.php">Mobile Poker</a> di Smartphone anda!</p>

                    <div class="portfolio-item-thumb one-half">
                        <img class="responsive-image" src="img/images/poker.png" alt="Poker">
                    </div>
                    <div class="portfolio-item-thumb one-half last-column">
                        <img class="responsive-image" src="img/images/q-kick.png" alt="Q-Kick">
                    </div>
                    <div class="portfolio-item-thumb one-half">
                        <img class="responsive-image" src="img/images/ceme.png" alt="Ceme">
                    </div>
                    
                    <div class="portfolio-item-thumb one-half last-column">
                        <img class="responsive-image" src="img/images/capsasusun.png" alt="img">
                    </div>
                    
                </div>

            </div>
        </div>

        <?php include ("_footer.php");?>