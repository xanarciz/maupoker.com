<style type="text/css">
  .slider-img1{
      content: url('img/<?PHP echo $link_img; ?>/slider/slider1-potrait.jpg');
      display: block;
      width: 100%;
      min-height: 159px;
  }

  .slider-img2{
      content: url('img/<?PHP echo $link_img; ?>/slider/slider2-potrait.jpg');
      display: block;
      width: 100%;
      min-height: 159px;
  }


  .slider-img3{
      content: url('img/<?PHP echo $link_img; ?>/slider/slider3-potrait.jpg');
      display: block;
      width: 100%;
      min-height: 159px;
  }

  /* iPhone 5 */
  @media only screen 
    and (min-device-width: 320px) 
    and (max-device-width: 568px)
    and (orientation: landscape) {

      .slider-img1{
          content: url('img/<?PHP echo $link_img; ?>/slider/slider1-landscape.jpg');
          display: block;
          width: 100%;
          height: auto;
      }

      .slider-img2{
          content: url('img/<?PHP echo $link_img; ?>/slider/slider2-landscape.jpg');
          display: block;
          width: 100%;
          height: auto;
      }

      .slider-img3{
          content: url('img/<?PHP echo $link_img; ?>/slider/slider3-landscape.jpg');
          display: block;
          width: 100%;
          height: auto;
      }
  }

  /* iPhone 6 */
  @media only screen 
    and (min-device-width: 375px) 
    and (max-device-width: 667px) 
    and (orientation: landscape) { 

      .slider-img1{
          content: url('img/<?PHP echo $link_img; ?>/slider/slider1-landscape.jpg');
          display: block;
          width: 100%;
          height: auto;
      }

      .slider-img2{
          content: url('img/<?PHP echo $link_img; ?>/slider/slider2-landscape.jpg');
          display: block;
          width: 100%;
          height: auto;
      }

      .slider-img3{
          content: url('img/<?PHP echo $link_img; ?>/slider/slider3-landscape.jpg');
          display: block;
          width: 100%;
          height: auto;
      }
  }

  /* iPhone 6+ */
  @media only screen 
    and (min-device-width: 414px) 
    and (max-device-width: 736px) 
    and (orientation: landscape) { 

      .slider-img1{
          content: url('img/<?PHP echo $link_img; ?>/slider/slider1-landscape.jpg');
          display: block;
          width: 100%;
          height: auto;
      }

      .slider-img2{
          content: url('img/<?PHP echo $link_img; ?>/slider/slider2-landscape.jpg');
          display: block;
          width: 100%;
          height: auto;
      }

      .slider-img3{
          content: url('img/<?PHP echo $link_img; ?>/slider/slider3-landscape.jpg');
          display: block;
          width: 100%;
          height: auto;
      }
  }

  /* iPad */
  @media only screen 
    and (min-device-width: 768px) 
    and (max-device-width: 1024px) {

      .slider-img1{
          content: url('img/<?PHP echo $link_img; ?>/slider/slider1-landscape.jpg');
          display: block;
          width: 100%;
          height: auto;
      }

      .slider-img2{
          content: url('img/<?PHP echo $link_img; ?>/slider/slider2-landscape.jpg');
          display: block;
          width: 100%;
          height: auto;
      }

      .slider-img3{
          content: url('img/<?PHP echo $link_img; ?>/slider/slider3-landscape.jpg');
          display: block;
          width: 100%;
          height: auto;
      }
  }
</style>
<!--
<script type="text/javascript" src="http://analytic.dewacrm.com/themes/visit.js" data-game='12'></script>
-->
<?PHP
if ($_SESSION["login"]) {
    $q = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "SELECT img_main from u6048user_agencyruntext WHERE agent = '".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
    $running_txt = $q["menu_text"];
    $footer_txt = $q["footer_text"];

    $q2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select txh from u6048user_coin where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
    $coin = $q2["txh"];
} else {
    $q = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "SELECT img_main from u6048user_agencyruntext WHERE agent = '".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
    $running_txt = $q["depan_text"];
    $footer_txt = $q["footer_text"];
}

$q_script=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select script_text from u6048user_agencyruntext where agent='".$agentwlable."'"),SQLSRV_FETCH_ASSOC);
$txt_script = explode("__lc.license = ",$q_script["script_text"]);
$lisence = substr($txt_script[1],0,7);

$img_main = explode(";",$q["img_main"]);
if($link_img == "io"){ 
    $android = "https://www.gameiosapk.com/android.php";
    $ios = "itms-services://?action=download-manifest&url=https://www.gameiosapk.com/iphone/manifest.plist"; 
	$name = 'Domino88';
}elseif($link_img == "PTKP"){ 
    $android = "https://www.gameiosapk.com/m-kartupoker/android.php";
    $ios = "itms-services://?action=download-manifest&url=https://www.gameiosapk.com/m-kartupoker/iphone/manifest.plist"; 
	$name = 'Kartu Poker';
}else{ 
    $android = "https://www.gameiosapk.com/m-remipoker/android.php";
    $ios = "itms-services://?action=download-manifest&url=https://www.gameiosapk.com/m-remipoker/iphone/manifest.plist"; 
	$name = 'RemiPoker';
}
?>

<body>
    <div class="all-elements">
	  <!-- APP CONTAINER -->
      <div class="app-container"></div>
	
      <!-- SIDE BAR -->
      <div id="sidebar" class="page-sidebar">
        <div class="page-sidebar-scroll">

          <?php include "_sidebar.php"; ?>

        </div>
      </div>
      <!-- END SIDE BAR -->

      <div id="content" class="page-content" data-snap-ignore="true">
        <div class="page-header">
          <a href="javascript:void(0);" class="deploy-sidebar"><i class="fa fa-bars fa-2x"></i></a>
          <img class="header-logo" src="img/<?PHP echo $link_img;?>/logo.png">
            <?php if ($_SESSION["login"]){ ?>
            
            <div class="col-lg-4 pull-right <?PHP if($link_img == "io"){ echo "bg-lighter-blue"; }elseif($link_img == "PTKP"){ echo "bg-black"; }else{ echo "bg-purple";} ?> padding-3 ui-corner-all lpadding-5 tmargin-5 tpadding-5" >
                <p class="white padding-0 margin-0"><?php echo $_SESSION["login"]; ?></p>
                <p class="green padding-0 margin-0">IDR <?php echo number_format($coin); ?></p>
            </div>

            <?PHP }else{ ?>

            <div class="col-lg-6 pull-right">
                <div class="col-lg-5" style="padding-left:10px;padding-right:0px">
                    <input class="btn btn-blue login" value="Login" type="button" />
                </div>
                <div class="col-lg-5">
                    <input class="btn btn-green" value="Daftar" type="button" onclick="location.href='daftar.php'" />
                </div>
            </div>

            <?PHP } ?>

        </div>

        <div class="page-header-clear"></div>
        <input type="hidden" id="_sdbr_" value="0">

        <script type="text/javascript">
          $( ".deploy-sidebar" ).click(function() {
            var x = $('#_sdbr_').val();

            if( x == 0 ){
              $('.all-elements').css('overflow', 'hidden');
              $('#_sdbr_').val('1');
            }else{
              $('.all-elements').css('overflow', '');
              $('#_sdbr_').val('0');
            }
          });

          var snapper = new Snap({
            element: document.getElementById('content'),
          });

          snapper.settings({   
            dragger: true,
            transitionSpeed: .4,
            easing: 'ease-out',
            tapToClose: true,
            disable: 'right'
          });

          $( ".login" ).click(function(){

            snapper.close();
            $('html, body').css({
                'overflow': 'auto',
                'height': 'auto'
            });
            $(this).find('i').addClass('fa-bars');
            $(this).find('i').removeClass('fa-arrow-back');

            $('.all-elements').css('overflow', '');
            $('#_sdbr_').val('0');

          });
		  
		  $(document).ready(function () {
            if(smartBanner.isSupportDevice() && $.cookie('hideSmartBanner') !== 'true'){
              $('.app-container').slideDown('slow');
              $('.app-container').css('overflow', '');
            }
            smartBanner.init({
              appIcon: 'img/<?php echo $link_img;?>/app-logo.png?id=4713',
              downloadAndroid: '<?php echo $android; ?>',
              downloadIOS: '<?php echo $ios; ?>',
              slogan: 'Download <?php echo $name;?> Mobile',
              title: '<?php echo $name;?>'
            });
          });
        </script>