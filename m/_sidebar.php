<?php include_once("../config_db2.php");?>

<style type="text/css">
  .fa-withdraw{
    background: url('img/<?PHP echo $link_img;?>/icons/widraw.png') no-repeat;
    height: 16px;
    width:16px;
  }
  .fa-withdraw-white{
    background: url('img/<?PHP echo $link_img;?>/icons/withdraw-white.png') no-repeat;
    height: 16px;
    width:16px;

  }
  .fa-jackpot{
    background: url('img/<?PHP echo $link_img;?>/icons/jackpot.png') no-repeat;
    height: 16px;
    width:16px;
  }
  .fa-vip{
    background: url('img/<?PHP echo $link_img;?>/icons/vip.png') no-repeat;
    height: 16px;
    width:16px;
  }
  .fa-vip-white{
    background: url('img/<?PHP echo $link_img;?>/icons/vip-white.png') no-repeat;
    height: 16px;
    width:16px;
  }
  .fa-seal{
    background: url('img/<?PHP echo $link_img;?>/icons/seal.png') no-repeat;
    height: 16px;
    width:16px;
  }
  .fa-seal-white{
      background: url('img/<?PHP echo $link_img;?>/icons/seal-white.png') no-repeat;
      height: 16px;
      width:16px;
  }
  .fa-8balls{
    background: url('img/<?PHP echo $link_img;?>/icons/8balls.png') no-repeat;
    height: 16px;
    width:16px;
  }
  .fa-8balls-white{
      background: url('img/<?PHP echo $link_img;?>/icons/8balls-white.png') no-repeat;
      height: 16px;
      width:16px;
  }
  .fa-user2{
    background: url('img/<?PHP echo $link_img;?>/icons/user_icon2.png') no-repeat;
    height: 16px;
    width:16px;
  }
  .fa-user-white{
    background: url('img/<?PHP echo $link_img;?>/icons/user-white.png') no-repeat;
    height: 16px;
    width:16px;
  }
  .fa-refferal{
    background: url('img/<?PHP echo $link_img;?>/icons/refferal.png') no-repeat;
    height: 16px;
    width:16px;
  }
  .fa-document-b{
      background: url('img/<?PHP echo $link_img;?>/icons/document.png') no-repeat;
      height: 16px;
      width:16px;
  }
  .fa-document-white{
      background: url('img/<?PHP echo $link_img;?>/icons/document-white.png') no-repeat;
      height: 16px;
      width:16px;
  }
  .fa-history-b{
      background: url('img/<?PHP echo $link_img;?>/icons/history.png') no-repeat;
      height: 16px;
      width:16px;
  }
  .fa-cog-b{
      background: url('img/<?PHP echo $link_img;?>/icons/cog-white.png') no-repeat;
      height: 16px;
      width:16px;
  }
  .fa-arrow-back{
      background: url('img/<?PHP echo $link_img;?>/icons/arrow-back.png') no-repeat;
      height: 16px;
      width:16px;
  }

  /*MODAL*/
  .user-form{
      background: url("img/<?PHP echo $link_img;?>/icons/user_icon.png") no-repeat scroll 7px 7px #dddddd;
      padding-left:35px;
  }

  .password-form{
      background: url("img/<?PHP echo $link_img;?>/icons/lock_icon.png") no-repeat scroll 7px 7px #dddddd;
      padding-left:35px;
  }

  .validation-form{
      background: url("img/<?PHP echo $link_img;?>/icons/validation_icon.png") no-repeat scroll 7px 7px #dddddd;
      padding-left:35px;
  }
</style>

<?php
    $q_script=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select script_text from u6048user_agencyruntext where agent='".$agentwlable."'"),SQLSRV_FETCH_ASSOC);
    $txt_script = explode("__lc.license = ",$q_script["script_text"]);
    $lisence = substr($txt_script[1],0,7);

    //after login
    if ($_SESSION["login"]){ ?>

  <div class="bg-dark-gray tpadding-5 lpadding-5 player-info rpadding-10 bpadding-5">
    <div class="row padding-0 tmargin-3 bmargin-3 bg-darker-gray light-gray fs-14">
      <div class="col-lg-5 padding-0 margin-0">
        <i class="fa fa-user2 icon-16"></i> <?php echo $_SESSION["login"]; ?>
      </div>
      <div class="col-lg-6 green padding-0 margin-0 fs-14">
        <i class="fa fa-8balls icon-16"></i> <?php echo number_format($coin); ?>
      </div>
    </div>
    <div class="row padding-0 tmargin-3 bmargin-3 bg-darker-gray light-gray fs-14">
      <div class="col-lg-6 padding-0 margin-0">
        <i class="fa fa-seal icon-16"></i> <?php echo number_format($poin); ?>
      </div>
      <div class="col-lg-5 padding-0 margin-0">
        <?php 
            $q = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select top 1 userid from j2365join_poinhistory where userid = '".$login."'",$params,$options));
            if ($q > 1){
        ?>
            <input class="btn btn-mini pull-left btn-orange" value="Reedem Poin" type="button" onclick="window.location.href='https://www.koin88.com/do-game-connect?id=1006&userid=<?php echo $user_login ?>&authcode=<?php echo $user_authcode;?>" style="border-radius: 5px;" />

        <?php
            }else{
        ?>
            <a target="_blank" class="btn btn-mini btn-orange center tpadding-3" href="https://www.koin88.com/do-game-connect?id=1006&userid=<?php echo $user_login ?>&authcode=<?php echo $user_authcode;?>" style="vertical-align: middle;">Aktivasi</a>

        <?php
            }
        ?>

      </div>
    </div>
  </div>

  <div class="navigation-item <?php if($page=='home'){ ?> active <?php } ?>">
    <a class="nav-item" href="index.php"><i class="fa fa-home"></i> HOME<em <?php if($page=="home"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <div class="navigation-item <?php if($page=='akun'){ ?> active <?php } ?>">
    <a class="nav-item" href="account.php"><i class="fa fa-user" ></i> AKUN SAYA<em <?php if($page=="akun"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <div class="navigation-item <?php if($page=='notifikasi'){ ?> active <?php } ?>">
    <a class="nav-item" href="notification.php"><i class="fa fa-bell" ></i> NOTIFIKASI 
      <!-- if conditional here: when notification > 0 -->
	  <?php 
		$data_memo = sqlsrv_query($sqlconn, "select id from a83adm_newsinfo where waktu >= '".date('Y-m-d', strtotime("-1 week"))."' and subwebid = '".$subwebid."'",$params,$options);
		$fetch_data_memo = sqlsrv_num_rows($data_memo);
		if ($fetch_data_memo > 0){
			?>
			<b class="pull-right" style="margin-right: 50px;margin-top: 10px;background: red;height: 22px;width: 22px;border-radius: 10px;"></b>
			<b class="pull-right white" style="width: 19px;margin-right: -20px;text-align:center;"> <?php echo $fetch_data_memo; ?> </b>
			<?php
		}
	  ?>
      <!-- end if here -->
    <em <?php if($page=="notifikasi"){ ?>class="selected-item notif"<?php } ?> class="unselected-item notif"></em></a>
  </div>

  <div class="navigation-item <?php if($page=='deposit'){ ?> active <?php } ?>">
    <a class="nav-item" href="deposit.php"><i class="fa fa-deposit" ></i> DEPOSIT<em <?php if($page=="deposit"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <div class="navigation-item <?php if($page=='withdraw'){ ?> active <?php } ?>">
    <a class="nav-item" href="withdraw.php"><i class="fa fa-withdraw"></i> WITHDRAW<em <?php if($page=="withdraw"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <div class="navigation-item <?php if($page=='promosi'){ ?> active <?php } ?>">
    <a class="nav-item" href="promosi.php"><i class="fa fa-gift"></i> PROMOSI<em <?php if($page=="promosi"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <div class="navigation-item <?php if($page=='referral'){ ?> active <?php } ?>">
    <a class="nav-item" href="referral.php"><i class="fa fa-refferal" ></i> REFERRAL <em <?php if($page=="referral"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <div class="navigation-item <?php if($page=='jackpot'){ ?> active <?php } ?>">
    <a class="nav-item " href="jackpot.php"><i class="fa fa-jackpot" ></i> JACKPOT<em <?php if($page=="jackpot"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <!-- <div class="navigation-item <?php if($page=='vip'){ ?> active <?php } ?>">
    <a class="nav-item" href="vip.php"><i class="fa fa-vip"></i> VIP MEMBER<em <?php if($page=="vip"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div> -->

  <div class="navigation-item <?php if($page=='download'){ ?> active <?php } ?>">
    <a class="nav-item" href="download.php"> <i class="fa fa-download"></i> DOWNLOAD APLIKASI<em <?php if($page=="download"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <div class="row tmargin-0 tpadding-0">
    <div class="col-lg-6">
      <input class="btn btn-red" value="Logout" type="button" onclick="location.href='../logout.php'" />
    </div>
    <div class="col-lg-6">
      <input class="btn btn-green" value="DEPOSIT" type="button" onclick="location.href='deposit.php'" />
    </div>
  </div>

  <?PHP
  //before login
    }else{
  ?>

  <div class="navigation-item <?php if($page=='home'){ ?> active <?php } ?>">
    <a class="nav-item" href="index.php"><i class="fa fa-home"></i> HOME<em <?php if($page=="home"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <div class="navigation-item <?php if($page=='deposit'){ ?> active <?php } ?>">
    <a class="nav-item" href="deposit.php"><i class="fa fa-deposit" ></i> DEPOSIT<em <?php if($page=="deposit"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <div class="navigation-item <?php if($page=='withdraw'){ ?> active <?php } ?>">
    <a class="nav-item" href="withdraw.php"><i class="fa fa-withdraw"></i> WITHDRAW<em <?php if($page=="withdraw"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <div class="navigation-item <?php if($page=='promosi'){ ?> active <?php } ?>">
    <a class="nav-item" href="promosi.php"><i class="fa fa-gift"></i> PROMOSI<em <?php if($page=="promosi"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <div class="navigation-item <?php if($page=='referral'){ ?> active <?php } ?>">
    <a class="nav-item" href="referral.php"><i class="fa fa-refferal" ></i> REFERRAL <em <?php if($page=="referral"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <div class="navigation-item <?php if($page=='jackpot'){ ?> active <?php } ?>">
    <a class="nav-item " href="jackpot.php"><i class="fa fa-jackpot" ></i> JACKPOT<em <?php if($page=="jackpot"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <!-- <div class="navigation-item <?php if($page=='vip'){ ?> active <?php } ?>">
    <a class="nav-item" href="vip.php"><i class="fa fa-vip"></i> VIP MEMBER<em <?php if($page=="vip"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div> -->

  <div class="navigation-item <?php if($page=='download'){ ?> active <?php } ?>">
    <a class="nav-item" href="download.php"> <i class="fa fa-download"></i> DOWNLOAD APLIKASI<em <?php if($page=="download"){ ?>class="selected-item"<?php } ?> class="unselected-item"></em></a>
  </div>

  <div class="row tmargin-0 tpadding-0">
    <div class="col-lg-6">
      <input class="btn btn-blue login" value="Login"  type="button" />
    </div>
    <div class="col-lg-6">
      <input class="btn btn-green" value="Daftar" type="button" onclick="location.href='daftar.php'" />
    </div>
  </div>

<?PHP 
    }
?>

  <div class="copyright">
    <p>&copy; 2016 <?PHP echo $domain; ?>. All Rights Reserved | 18+</p>
    <a href="">Versi Desktop</a>
  </div>