<?php

$auth_user = "agent";
if ($register == 2)$auth_user = "master";
if ($_SESSION["login"]) {
	$q = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "SELECT menu_text,footer_text,yahoo_id,skype_id,bbm_id,wechat_id,phone_id,whatsapp_id,facebook_id,twitter_id,bank_text,img_main,referral_text from u6048user_agencyruntext WHERE $auth_user = '".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
	$running_txt = $q["menu_text"];
	$footer_txt = $q["footer_text"];
	
	$q2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select txh from u6048user_coin where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
	$coin = $q2["txh"];
} else {
	$q = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "SELECT depan_text,footer_text,yahoo_id,skype_id,bbm_id,wechat_id,phone_id,whatsapp_id,facebook_id,twitter_id,bank_text,img_main,referral_text from u6048user_agencyruntext WHERE $auth_user = '".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
	$running_txt = $q["depan_text"];
	$footer_txt = $q["footer_text"];
}
$yahoo_id = $q["yahoo_id"];
$skype_id = $q["skype_id"];
$bbm_id = $q["bbm_id"];
$wechat_id = $q["wechat_id"];
$phone_id = $q["phone_id"];
$whatsapp_id = $q["whatsapp_id"];
$facebook_id = $q["facebook_id"];
$twitter_id = $q["twitter_id"];
$img_main = explode(";",$q["img_main"]);
$referral_text = $q["referral_text"];

$data_bank=explode(";",$q["bank_text"]);
$status_aktif=$data_bank[0];
$status_bank=explode(",",$data_bank[1]);
$bank_list=["BCA","MANDIRI","BRI","BNI","DANAMON"];

$q_maintenance=sqlsrv_num_rows(sqlsrv_query($sqlconn,"select maint from a83adm_config where maint='1'",$params,$options));
if ($q_maintenance > 0){
	$q = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "SELECT text from g846runningtext where game = 'maint'"), SQLSRV_FETCH_ASSOC);
	$running_txt = $q["text"];
}

	$data = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select TXH from u6048user_coin where userid='".$login."'"), SQLSRV_FETCH_ASSOC);
	$memo =sqlsrv_num_rows(sqlsrv_query($sqlconn,"select mread from j2365join_memo  where mread='0' and mto='".$login."'",$params,$options));
	if($memo > 0){
		$add="(".$memo.")";
	}else{
		$add="";
	}
	
?>


<body>

        <!--[if lt IE 7]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
        <!-- Content -->

        <div id="contact-panel" class="quickAccess_holder left light">
    		<ul>
    			<?php if ($yahoo_id){?>
					<li><a href="ymsgr:sendIM?<?php  echo $yahoo_id; ?>" class="quickAccess-varia_3"><?php echo $yahoo_id; ?></a></li>
				<?php }
				if ($bbm_id){
				?>
					<li><a href="javascript:void(0);" class="quickAccess-varia_2"><?php echo $bbm_id; ?></a></li>
    			<?php
				}
				if ($skype_id){
				?>
    			<li><a href="skype:<?php echo $skype_id;?>?call" class="quickAccess-varia_4"><?php echo $skype_id;?></a></li>
				<?php
				}
				if ($wechat_id){
				?>
					<li><a href="javascript:void(0);" class="quickAccess-varia_1"><?php echo $wechat_id; ?></a></li>
				<?php
				}
				if ($whatsapp_id){
				?>
                <li><a href="javascript:void(0);" class="quickAccess-varia_6"><?php echo $whatsapp_id; ?></a></li>
				<?php
				}
				if ($phone_id){
				?>
				<li><a href="javascript:void(0);" class="quickAccess-varia_5"><?php echo $phone_id; ?></a></li>
				<?php
				}
				if ($facebook_id){
				?>
    			<li><a href="https://www.facebook.com/<?php echo $facebook_id; ?>" target="blank" class="quickAccess-varia_7"><?php echo $facebook_id; ?></a></li>
				<?php
				}
				if ($twitter_id){
				?>
    			<li><a href="https://twitter.com/<?php echo $twitter_id; ?>" target="blank" class="quickAccess-varia_8"><?php echo $twitter_id; ?></a></li>
				<?php
				}
				?>
    		</ul>
    	</div>
        <script type="text/javascript">
        	jQuery(document).ready(function() {
        		var qaccess = jQuery('#contact-panel').quickAccess({
                  screenPosition: 'left',
                  width: '215px',
                  css: {position: 'fixed'},
                  itemCss: {
                      'backgroundColor': '#404040',
                      /*'borderWidth': 1,
                      'borderColor': '#3a3a3a',
                      'borderStyle': 'solid'*/
                  },
                  margin: '2px',
                  radius: {
                      borderTopLeftRadius: '0px',
                      borderTopRightRadius: '12px',
                      borderBottomLeftRadius: '0px',
                      borderBottomRightRadius: '12px'
                  }
              });

        	});
        </script>
		<?php 
		if($status_aktif == 1){
			
		?>
        <div class="bank-panel right">
            <ul>                
                <?php 
				function showBankStatus($bankName,$status_bank){
					$bank_list=["BCA","MANDIRI","BRI","BNI","DANAMON"];
					for ($i=0; $i<5; $i++){
						if (strtoupper($bankName) == $bank_list[$i]){
							if ($status_bank[$i]==0){
								return "<li>
									<div class='panel-black'>
										<div class='offline'></div>
										<div class='".strtolower($bank_list[$i])."'></div>
									</div>
								</li>";
							}else{
								return "<li>
									<div class='panel-black'>
										<div class='online'></div>
										<div class='".strtolower($bank_list[$i])."'></div>
									</div>
								</li>";
							}
							break;
						}
					}
					
				}
				$qBank=sqlsrv_query($sqlconn, "select bank from a83adm_configbank where code = '".$agentwlable."' and idx !='0' and (curr = 'IDR')",$params,$options); 
				for ($k=0; $k<sqlsrv_num_rows($qBank); $k++){
					$arrBank=sqlsrv_fetch_array($qBank,SQLSRV_FETCH_ASSOC);
					echo $result=showBankStatus($arrBank["bank"],$status_bank); 
				}
				?>

            </ul>
        </div>
		<?php
		
		}
		?>
        <div align="center">
            <div id="header">
                <link rel="stylesheet" type="text/css" href="assets/js/vkeyboard/jquery.keypad.big.css">
        		<script language="JavaScript" src="assets/js/vkeyboard/jquery.keypadlogin.js"></script>
        		<script language="JavaScript" src="assets/js/vkeyboard/jquery.keypad-id.js"></script>
                <script language="JavaScript" type="text/javascript">
				window.history.forward(1);
				$(function() {
				var bigQwertyLayout = 
					['!@#$%^&*()_=' + $.keypad.HALF_SPACE + $.keypad.SPACE + $.keypad.CLOSE,$.keypad.HALF_SPACE + '`~[]{}<>\\|/' + $.keypad.SPACE + '789','qwertyuiop\'"' + $.keypad.HALF_SPACE + '456', 
						$.keypad.HALF_SPACE + 'asdfghjkl;:' + $.keypad.SPACE + '123', $.keypad.SPACE + 'zxcvbnm,.?' + $.keypad.SPACE + $.keypad.HALF_SPACE + '-0+', 
						$.keypad.SHIFT + $.keypad.SPACE + $.keypad.SPACE_BAR + $.keypad.SPACE + $.keypad.BACK + $.keypad.CLEAR
					];
				  $.keypad.setDefaults($.keypad.regional['']);
				  $('#j_plain_password').keypad($.extend({keypadClass: 'l10n'},{
					showOn: 'focus',
					buttonImageOnly: false,
					buttonImage: 'assets/js/vkeyboard/keyboard.png', 
					layout: bigQwertyLayout,
					closeText: 'Close',
					backText: 'Backspace',
					shiftText: 'Caps Lock',
					keypadOnly: false, 
					showAnim: 'slideDown'}));  
				});
				</script>

                <div class="container">
                    <div class="logo"><a href="index.php"></a></div>
					<?php if (!$_SESSION["login"]){?>
                    <form class="login-form" role="form" method="POST">
                        <div class="form-group">
                            <input type="text" placeholder="Username" id="username" name="entered_login" class="form-control-login" tabindex="1">
                        </div>
                        <div class="form-group">
                            <input type="password" placeholder="Password" id="j_plain_password" name="entered_password" class="form-control-login" tabindex="2">
                        </div>
                        <div class="form-group">
                            <input type="text" placeholder="Validation" id="membervalidation" name="entered_val" class="form-control-login" maxlength="5" tabindex="3">
                        </div>
						<div class="form-group">
                            <img src="captcha/captcha-login.php?.png" alt="VALIDATION" title="VALIDATION" class="form-captcha"/>
                        </div>
						
                        <button type="submit" class="btn btn-login" tabindex="4">Log in</button>
                    </form>
					<?php }else{?>
					<div class="user-panel">
                        <div class="box box2">
                            <div class="box-inner">
                                <div class="avatar-medium">
									<?php
									$myDir = substr($login,0,1);
									$img_avatar = $path."/avatar/".$myDir."/".$login.".jpg?".date("is");
									?>
									<div class="avatar-medium-user" style="background: url(<?php echo $img_avatar;?>) no-repeat;background-size:63px;"></div>
								</div>

                                <div class="user-info">
                                    <span class="user-text">Selamat Datang,</span>
                                    <div class="clear space_3"></div>
                                    <span class="user-name"><?php echo $login;?></span>
                                    <div class="clear"></div>
                                    <span class="user-chips">CHIPS: <?php echo number_format($coin);?></span>
                                </div>

                                <div class="clear"></div>
                            </div>
                        </div>
                    </div>
					<?php } ?>
                </div>
            </div>

            <div id="nav">
                <div class="container">
                    <ul class="sf-menu">
						<?php 
						if ($register == 1){
							if ($login){
							?>
							<li><a class="main2" href="lobby.php">Lobby</a></li>
							<li><a class="main2" href="profile.php">Profil</a></li>
							<!-- <li><a class="main2" href="how-to-play.php">Cara Bermain</a></li> -->
							<li><a class="main2" href="deposit.php">Deposit</a></li>
							<li><a class="main2" href="withdraw.php">Withdraw</a></li>
							<li><a class="main2" href="referral.php">Referral</a>
							  <!--  <ul>
									<li class="main2"><a href="referral-komisi.php?date=<?php echo"".$sqlu["userpass"]."";?>&userid=<?php echo"".$login."";?>&st=20&j=1&batas=20&ref=getdate()">Komisi Referral</a></li>
									<li class="main2"><a href="referral-data.php?date=<?php echo"".$sqlu["userpass"]."";?>&userid=<?php echo"".$_SESSION["login"]."";?>&st=20&j=1&batas=20&ref=getdate()">Data Referral</a></li>
									<li class="main2 sf-bottom"><a href="referral-daftar.php?date=<?php echo"".$sqlu["userpass"]."";?>&userid=<?php echo"".$login."";?>&type=star">Daftar Referral</a></li>
								</ul> -->
							</li>
							<li><a class="main2" href="memo.php">&nbsp;Memo&nbsp;<sup><b><?php echo $add;?></b></sup></a></li>
							<li><a class="main1 android" href="android.php">Android&nbsp;&nbsp;</a></li>
							<li><a class="main2" href="logout.php">Keluar</a></li>
							<?php }else{ ?>
							<li><a class="main1" href="index.php">Home</a></li>
							<li><a class="main1" href="register.php">Daftar</a></li>
							<!-- <li><a class="main1" href="how-to-play.php">Cara Bermain</a></li> -->
							<li><a class="main1" href="javascript:uialert('Harap login untuk melakukan DEPOSIT!');">Deposit</a></li>
							<li><a class="main1" href="javascript:uialert('Harap login untuk melakukan WITHDRAW!');">Withdraw</a></li>
							<li><a class="main1" href="referral.php">Referral</a></li>
							<li><a class="main1" href="jackpot.php">Jackpot</a></li>
                            <li><a class="main1 android" href="android.php">Android&nbsp;&nbsp;</a></li>
							<li><a class="main1" href="contact.php">Bantuan</a></li>
							<?php } 
						}else if ($register== 0){
							if ($login){
							?>
							<li><a class="main4" href="lobby.php">Lobby</a></li>
							<li><a class="main4" href="profile.php">Profil</a></li>
							<!-- <li><a class="main4" href="how-to-play.php">Cara Bermain</a></li> -->
							<li><a class="main4" href="deposit.php">Deposit</a></li>
							<li><a class="main4" href="withdraw.php">Withdraw</a></li>
                           <!-- <li><a class="main4" href="referral.php">Referral</a>-->
							  <!--  <ul>
									<li class="main2"><a href="referral-komisi.php?date=<?php echo"".$sqlu["userpass"]."";?>&userid=<?php echo"".$login."";?>&st=20&j=1&batas=20&ref=getdate()">Komisi Referral</a></li>
									<li class="main2"><a href="referral-data.php?date=<?php echo"".$sqlu["userpass"]."";?>&userid=<?php echo"".$_SESSION["login"]."";?>&st=20&j=1&batas=20&ref=getdate()">Data Referral</a></li>
									<li class="main2 sf-bottom"><a href="referral-daftar.php?date=<?php echo"".$sqlu["userpass"]."";?>&userid=<?php echo"".$login."";?>&type=star">Daftar Referral</a></li>
								</ul> -->
							</li>
							<li><a class="main4" href="memo.php">&nbsp;Memo&nbsp;</a></li>
                            <li><a class="main4 android" href="android.php">Android&nbsp;&nbsp;</a></li>
							<li><a class="main4" href="logout.php">Keluar</a></li>
							<?php }else{ ?>
							<li><a class="main3" href="index.php">Home</a></li>
							<!-- <li><a class="main3" href="how-to-play.php">Cara Bermain</a></li> -->
							<li><a class="main3" href="javascript:uialert('Harap login untuk melakukan DEPOSIT!');">Deposit</a></li>
							<li><a class="main3" href="javascript:uialert('Harap login untuk melakukan WITHDRAW!');">Withdraw</a></li>
							<li><a class="main3" href="jackpot.php">Jackpot</a></li>
                            <li><a class="main3 android" href="android.php">Android&nbsp;&nbsp;</a></li>
							<li><a class="main3" href="contact.php">Bantuan</a></li>
							<?php } 
						}else if ($register== 2){
							if ($login){
							?>
							<li><a class="main4" href="lobby.php">Lobby</a></li>
							<li><a class="main4" href="profile.php">Profil</a></li>
							<!-- <li><a class="main4" href="how-to-play.php">Cara Bermain</a></li> -->

                           <!-- <li><a class="main4" href="referral.php">Referral</a>-->
							  <!--  <ul>
									<li class="main2"><a href="referral-komisi.php?date=<?php echo"".$sqlu["userpass"]."";?>&userid=<?php echo"".$login."";?>&st=20&j=1&batas=20&ref=getdate()">Komisi Referral</a></li>
									<li class="main2"><a href="referral-data.php?date=<?php echo"".$sqlu["userpass"]."";?>&userid=<?php echo"".$_SESSION["login"]."";?>&st=20&j=1&batas=20&ref=getdate()">Data Referral</a></li>
									<li class="main2 sf-bottom"><a href="referral-daftar.php?date=<?php echo"".$sqlu["userpass"]."";?>&userid=<?php echo"".$login."";?>&type=star">Daftar Referral</a></li>
								</ul> -->
							</li>
							<li><a class="main4" href="memo.php">&nbsp;Memo&nbsp;</a></li>
                            <li><a class="main4 android" href="android.php">Android&nbsp;&nbsp;</a></li>
							<li><a class="main4" href="logout.php">Keluar</a></li>
							<?php }else{ ?>
							<li><a class="main3" href="index.php">Home</a></li>
							<!-- <li><a class="main3" href="how-to-play.php">Cara Bermain</a></li> -->
							<li><a class="main3" href="jackpot.php">Jackpot</a></li>
                            <li><a class="main3 android" href="android.php">Android&nbsp;&nbsp;</a></li>
							<li><a class="main3" href="contact.php">Bantuan</a></li>
							<?php } 
						}
						?>
  					</ul>
                </div>
            </div>

            <div id="news">
                <div class="container">
                    <span>Info Terkini :</span>
                    <div class="scrollnews">
					<marquee>
                        <ul id="liscroll">
                            <li><a href="javascript:void(0);"><span><?php echo date("d/m/Y"); ?></span>&nbsp;<?php echo $running_txt;?></a></li>
                        </ul>
					</marquee>
                    </div>
                </div>
            </div>
            <script language="JavaScript" type="text/javascript">
               /* jQuery(document).ready(function(){
    				jQuery("#liscroll").liScroll();
    			})*/
            </script>
