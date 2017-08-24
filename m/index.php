<?php
$page='home';
include("_metax.php");
include("_header.php");

$android = "https://www.gameiosapk.com/android.php";
$ios = "itms-services://?action=download-manifest&url=https://www.gameiosapk.com/iphone/manifest.plist"; 
$linkpanduan_a = "http://infodomino88.com/bermain-di-smartphone/"; 
$linkpanduan_i = "http://infodomino88.com/bermain-di-apple-ios/"; 

include '../dewafortune/dewafortune.php';

$tiket = getTicket();

$param = $login.",".$sessid;
?>

<style type="text/css">
  .spin {
    font-size: 14px;
    margin-left: 215px;
    background: red;
    width: 22px;
    height: 22px;
    border-radius: 10px;
    z-index: 9999;
      animation: changecolor 1s infinite;
    -moz-animation: changecolor 1s infinite; 
    -webkit-animation: changecolor 1s infinite;
    -ms-animation: changecolor 1s infinite; 
    -o-animation: changecolor 1s infinite; 
  }
  @keyframes changecolor
  {
    0%   {color: white;}
    25%  {color: #dbb847;}
    50%  {color: blue;}
    100% {color: yellow;}
  }
  /* Mozilla Browser */
  @-moz-keyframes changecolor 
  {
    0%   {color: white;}
    25%  {color: #dbb847;}
    50%  {color: blue;}
    100% {color: yellow;}
  }
  /* WebKit browser Safari and Chrome */
  @-webkit-keyframes changecolor 
  {
    0%   {color: white;}
    25%  {color: #dbb847;}
    50%  {color: blue;}
    100% {color: yellow;}
  }
  /* IE 9,10*/
  @-ms-keyframes changecolor 
  {
    0%   {color: white;}
    25%  {color: #dbb847;}
    50%  {color: blue;}
    100% {color: yellow;}
  }
  /* Opera Browser*/
  @-o-keyframes changecolor 
  {
    0%   {color: white;}
    25%  {color: #dbb847;}
    50%  {color: blue;}
    100% {color: yellow;}
  }
</style>

<div class="content">

  <!-- BANNER -->
<!--   <div class="top-banner">
    <h1>BANNER 640X100</h1>
  </div>
 -->  <!-- END BANNER -->

  <!-- SLIDER -->
  <div class="row">
      <div class="slider">
        <div id="owl-demo" class="owl-carousel owl-theme">
          <a href='http://infodomino88.com/turnamen-domino88/' target="_blank"><div class="item"><div class="slider-img1"></div></div></a>
          <div class="item"><div class="slider-img2"></div></div>
          <div class="item"><div class="slider-img3"></div></div>
        </div>
      </div>
  </div>
  <!-- END SLIDER -->

  <!-- JACKPOT -->
  <div class="clear-both"></div>
  <div class="jackpot">
    <div class="row">
      <div class="col-lg-3">
        <div class="double-border">
          <h1>Global</h1>
          <h1>Jackpot</h1>
        </div>
      </div>
      <div class="col-lg-9">
        <h1><?php echo number_format($infoweb['globalJack']); ?></h1>
      </div>
    </div>
  </div>
  <!-- END JACKPOT -->

  <!-- SPIN -->
  <?PHP if($_SESSION["login"]){ ?>
  <div class="toggle-1 tpadding-5 bpadding-5" align="center" style="<?PHP if($tiket <= 0){ echo 'padding-top: 25px;'; }?>">
    <a href="https://dewafortune.com/auth/login_defor.php?userid=<?php echo $_SESSION['login'];?>&sessid=<?php echo $sid;?>&access_token=9a7e8111d09b65e038de0444e96b5a8c" target="_blank">
        <?PHP if($tiket > 0){ ?>
        <div class="spin tpadding-3" align="center"><?PHP echo $tiket;?></div>
        <?PHP } ?>
      <img src="img/lucky-spin.png" style="width: 65%; margin-top: -15px;">
    </a>
  </div>
  <?PHP } ?>
  <!-- END SPIN -->

  <!-- GAMES -->
  <div class="toggle-1">
	<div style="width: 150px;position: relative;float: left;z-index: 1;">
    <a href="#" class="toggle-design" style="padding-bottom: 0px !important;width:135px;"><i class="fa fa-gamepad fa-2x"></i> Our Games</a>
	</div>
	<div style="width: 150px;position: relative;float: right;z-index: 1;">
	<?php if ($subwebid == "9001"){?>
    <a href="kartupoker://open" class="toggle-design" style="padding-bottom: 0px !important;"><img src="img/button playnow.gif" style="height:30px;"></a>
	<?php } ?>
	</div>
    <div class="toggle-content">
      <div class="horizontal-list-wrapper games-list" align="center">
        <ul class="horizontal-list index-list">
          <li>
            <a href="game-poker.php" class="bg-none">
              <img src="img/<?PHP echo $link_img;?>/games/poker.png">
              <h1>POKER</h1>
            </a>
          </li>
          <li>
            <a href="game-livepoker.php" class="bg-none">
              <img src="img/<?PHP echo $link_img;?>/games/livepoker.png">
              <h1>LIVE POKER</h1>
            </a>
          </li>
          <li>
            <a href="game-ceme.php" class="bg-none">
              <img src="img/<?PHP echo $link_img;?>/games/ceme.png">
              <h1>CEME</h1>
            </a>
          </li>
          <li>
            <a href="game-ceme-keliling.php" class="bg-none">
              <img src="img/<?PHP echo $link_img;?>/games/cemekeliling.png">
              <h1>CEME KELILING</h1>
            </a>
          </li>
          <li>
            <a href="game-domino-qiukick.php" class="bg-none">
              <img src="img/<?PHP echo $link_img;?>/games/domino.png">
              <h1>DOMINO</h1>
            </a>
          </li>
          <li>
            <a href="game-capsasuson.php" class="bg-none">
              <img src="img/<?PHP echo $link_img;?>/games/capsa.png">
              <h1>CAPSA</h1>
            </a>
          </li>
          <li>
            <a href="game-blackjack.php" class="bg-none">
              <img src="img/<?PHP echo $link_img;?>/games/blackjack.png" style="padding-top: 15px;">
              <h1>BLACKJACK</h1>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <!-- END GAMES -->

  <hr class="margin-0 padding-0 bmargin-5 bg-light-gray">

  <!-- DOWNLOAD -->
  <?php
    $filen = "Poker.apk";
    $fsize = 13;
  ?>
  <div class="toggle-1 bmargin-50">
    <a href="#" class="toggle-design" style="padding-bottom: 0px !important;"><i class="fa fa-download fa-2x"></i> Download Aplikasi</a>
    <div class="toggle-content">
      <div class="horizontal-list-wrapper">
        <ul class="horizontal-list index-list download-apps">
          <li style="width: 50%; margin: 0px;">
            <a href="<?php echo $android; ?>">
                <img src="img/<?PHP echo $link_img;?>/icons/android.png">
            </a>
          </li>
          <li style="width: 50%; margin: 0px;">
            <a href="<?php echo $ios; ?>">
                <img src="img/<?PHP echo $link_img;?>/icons/applelogo.png">
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <!-- END DOWNLOAD -->

</div>

<script type="text/javascript">

  $(document).ready(function() {
    var owl = $('.owl-carousel');
    owl.owlCarousel({
      items : 1,
      itemsCustom : false,
      itemsDesktop : [1199, 1],
      itemsDesktopSmall : [979, 1],
      itemsTablet : [768, 1],
      itemsTabletSmall : false,
      itemsMobile : [479, 1],
      singleItem : false,
      itemsScaleUp : false,

      slideSpeed : 200,
      paginationSpeed : 800,
      rewindSpeed : 1000,

      loop  : true,
      autoPlay : true,
      stopOnHover : false,

      mouseDrag : true,
      touchDrag : true
    });
    
  });

</script>

<?php include ("_footer.php");?>