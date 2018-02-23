<?php
include("lang_en.php");
$key = isset($_SESSION["sess_key"]);
$urlBack = $_SERVER['SERVER_NAME'];

if ($_SESSION["login"]) {
    $running_txt = $infoweb["running_txt_lgn"];
    $footer_txt = $infoweb["footer_text"];
} else {
    $running_txt = $infoweb["running_txt_blgn"];
    $footer_txt = $infoweb["footer_text"];

    //check restricted area
    include "geoiploc.php";
}

$img_main = explode(";",$infoweb["img_main"]);
$referral_text = $infoweb["referral_text"];

foreach ($infoweb['contact_agent'] as $contact => $value){
    ${$contact.'_id'} = $value;
}

if(isset($countmemo) > 0){
    $add="(".$countmemo.")";
}else{
    $add="";
}

if(!isset($sessid)){$sessid = '';}
$sid = $sessid;
// echo "<script>console.log('".$sid."');</script>";
$param = $_SESSION['login'].",".$sid;
//end
?>

<body>

    <style type="text/css">
	
		.light a.quickAccess-varia_wechat{
			background: url(assets/js/quickAccess/icons/light_icons/varia_1.png) no-repeat center 2px;
		}
		.light a.quickAccess-varia_bbm{
			background: url(assets/js/quickAccess/icons/light_icons/varia_2.png) no-repeat center 2px;
		}
		.light a.quickAccess-varia_yahoo{
			background: url(assets/js/quickAccess/icons/light_icons/varia_3.png) no-repeat center 2px;
		}
		.light a.quickAccess-varia_skype{
			background: url(assets/js/quickAccess/icons/light_icons/varia_4.png) no-repeat center 2px;
		}
		.light a.quickAccess-varia_phone{
			background: url(assets/js/quickAccess/icons/light_icons/varia_5.png) no-repeat center 2px;
		}
		.light a.quickAccess-varia_whatsapp{
			background: url(assets/js/quickAccess/icons/light_icons/varia_6.png) no-repeat center 2px;
		}
		.light a.quickAccess-varia_facebook{
			background: url(assets/js/quickAccess/icons/light_icons/varia_7.png) no-repeat center 2px;
		}
		.light a.quickAccess-varia_twitter{
			background: url(assets/js/quickAccess/icons/light_icons/varia_8.png) no-repeat center 2px;
		}
		.light a.quickAccess-varia_line{
			background: url(assets/js/quickAccess/icons/light_icons/varia_9.png) no-repeat center 2px;
		}
	
	
        .spin {
            font-size: 16px;
            font-family: 'big_noodle_titlingx';
            margin-left: -170px;
            margin-top: -78px;
            background: red;
            color: #fff;
            position: relative;
            width: 22px;
            height: 22px;
            border-radius: 10px;
            animation: changecolor 1s infinite;
            -moz-animation: changecolor 1s infinite; 
            -webkit-animation: changecolor 1s infinite;
            -ms-animation: changecolor 1s infinite; 
            -o-animation: changecolor 1s infinite; 
        }
        @keyframes changecolor
        {
            0%   {color: white;}
            25%  {color: green;}
            50%  {color: blue;}
            100% {color: yellow;}
        }
        /* Mozilla Browser */
        @-moz-keyframes changecolor 
        {
            0%   {color: white;}
            25%  {color: green;}
            50%  {color: blue;}
            100% {color: yellow;}
        }
        /* WebKit browser Safari and Chrome */
        @-webkit-keyframes changecolor 
        {
            0%   {color: white;}
            25%  {color: green;}
            50%  {color: blue;}
            100% {color: yellow;}
        }
        /* IE 9,10*/
        @-ms-keyframes changecolor 
        {
            0%   {color: white;}
            25%  {color: green;}
            50%  {color: blue;}
            100% {color: yellow;}
        }
        /* Opera Browser*/
        @-o-keyframes changecolor 
        {
            0%   {color: white;}
            25%  {color: green;}
            50%  {color: blue;}
            100% {color: yellow;}
        }
    </style>

    <!--[if lt IE 7]>
        <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->
    <!-- Content -->

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
                <div class='logo'><a href="index.php"></a></div>
                <?php
                if (!$_SESSION["login"]){
                ?>
                    <form class="login-form" role="form" method="POST" id="frmlgn">
                        <div class="form-group">
                            <input type="text" placeholder="Username" id="membername" name="entered_login" class="form-control-login" tabindex="1">
                        </div>
                        <div class="form-group">
                            <input type="password" placeholder="Password" id="j_plain_password" name="entered_password" class="form-control-login" tabindex="2">
                        </div>
                        <!-- <div class="form-group">
                            <input type="text" placeholder="Validation" id="membervalidation" name="entered_val" class="form-control-login" maxlength="5" tabindex="3">
                        </div>
                        <div class="form-group">
                            <img src="captcha/captcha-login.php?.png" alt="VALIDATION" title="VALIDATION" class="form-captcha"/>
                        </div> -->
                        <div style=position:absolute;top:0px;padding-left:223px;>
                            <a href="#" onclick="window.open('http://form.6mbr.com/?webname=<?php echo $nonWWW; ?>&lang=id','kritik_saran', 'width=600, height=1000');">
                                <img src="assets/images/feedback.png" width=115px;>
                            </a>
                        </div>

                        <button type="submit" class="btn btn-login" tabindex="4">LOGIN</button>
                    </form>
                    <?php if ($register==1){ ?><div class="forget-password" style="margin-top: 85px;margin-right: -351px;"><a href="forget-password.php">Forget password?</a></div> <?php } ?>
                <?php
                }else{
                   
                ?>
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
                                        <div style="margin-top:-8px;"><span class="user-text"><?php echo P_WELCOME;?>,</span></div>
                                        <div class="clear"></div>
                                        <span class="user-name"><?php echo $user_login;?></span>
                                        <div style="margin-top:-8px;"><span class="" style=font-size:12px>( Nickname : <?php echo $login;?> )</span></div>
                                        <div class="clear"></div>
                                        <span class="user-chips">CHIPS: <?php echo number_format($coin);?></span>
                                    </div>

                                    <div class="clear"></div>
                                </div>
                            </div>
                        </div>
                <?php
                }
                ?>
            </div>
        </div>

        <div id="nav">
            <div class="container">
                <ul class="sf-menu">
                    <?php
                    //active new lobby (true = redirect to new lobby, false = redirect to old lobby)
                    // include("myaes.php");
					/* $pkey = '02e97eddc9524a1e';
					$myaes = new myaes();
					$myaes->setPrivate($pkey);
					$pin = $_SESSION["pin"];
					$valuex = $login.','.$_SESSION["sessid"].','.$pin.',id,'.$protocol.','.$urlBack;
					$encvalue = $myaes->getEnc($valuex);
					
					$url_lobby = $url_lobby.'/lobby.php?vp='.rawurlencode($encvalue);
 */
                    if ($register == 1){
                        if ($login){
                        ?>
                            <li><a class="main2" href="lobby.php"><?php echo P_LOBBY;?></a></li>
                            <li><a class="main2" href="profile.php"><?php echo P_PRF;?></a></li>
                            <li><a class="main2" href="deposit.php"><?php echo P_DEP;?></a></li>
                            <li><a class="main2" href="withdraw.php"><?php echo P_WIT;?></a></li>
                            <li><a class="main2" href="referral.php"><?php echo P_AREFCOM;?></a></li>
                            <li><a class="main2" href="memo.php">&nbsp;<?php echo P_MEM;?>&nbsp;<sup><b><?php echo $add;?></b></sup></a></li>
                            <li><a class="main1 android" href="mobile.php"><?php echo P_MOBILE;?>&nbsp;&nbsp;&nbsp;</a></li>
                            <li><a class="main2" href="logout.php"><?php echo P_LOGOUT;?></a></li>
                        <?php }else{ ?>
                            <li><a class="main1" href="index.php"><?php echo P_HOME;?></a></li>
                            <li><a class="main1 register" href="register.php"><?php echo P_REGISTER;?></a></li>
                            <li><a class="main1" href="javascript:uialert('<?php echo P_PLEASELOGINFORDEPOSIT; ?> !');"><?php echo P_DEP?></a></li>
                            <li><a class="main1" href="javascript:uialert('<?php echo P_PLEASELOGINFORWITHDRAW; ?> !');"><?php echo P_WIT?></a></li>
                            <li><a class="main1" href="referral.php"><?php echo P_AREFCOM ?></a></li>
                            <li><a class="main1" href="jackpot.php"><?php echo P_JACKPOT?></a></li>
                            <li><a class="main1 android" href="mobile.php"><?php echo P_MOBILE;?></a></li>
                            <li><a class="main1" href="contact.php"><?php echo P_HELP ?></a></li>
                        <?php }
                    }else if ($register== 0){
                        if ($login){
                        ?>
                            <li><a class="main2" href="lobby.php"><?php echo P_LOBBY;?></a></li>
                            <li><a class="main4" href="profile.php"><?php echo P_PRF;?></a></li>
                            <li><a class="main4" href="deposit.php"><?php echo P_DEP;?></a></li>
                            <li><a class="main4" href="withdraw.php"><?php echo P_WIT;?></a></li>
                            </li>
                            <li><a class="main4" href="memo.php">&nbsp;<?php echo P_MEM;?>&nbsp;</a></li>
                            <li><a class="main4 android" href="mobile.php"><?php echo P_MOBILE;?>&nbsp;&nbsp;&nbsp;</a></li>
                            <li><a class="main4" href="logout.php"><?php echo P_LOGOUT;?></a></li>
                        <?php }else{ ?>
                            <li><a class="main3" href="index.php"><?php echo P_HOME;?></a></li>
                            <li><a class="main3" href="deposit.php"><?php echo P_DEP; ?></a></li>
                            <li><a class="main3" href="withdraw.php"><?php echo P_WIT; ?></a></li>
                            <li><a class="main3" href="jackpot.php"><?php echo P_JACKPOT?></a></li>
                            <li><a class="main3 android" href="mobile.php"><?php echo P_MOBILE?>&nbsp;&nbsp;&nbsp;</a></li>
                            <li><a class="main1" href="promotion.php">PROMOSI</a></li>
                            <li><a class="main3" href="contact.php"><?php echo P_HELP?></a></li>
                        <?php }
                    }else if ($register== 2){
                        if ($login){
                        ?>
                            <li><a class="main2" href="<?php echo $url_lobby;?>"><?php echo P_LOBBY;?></a></li>
                            <li><a class="main4" href="profile.php"><?php echo P_PRF;?></a></li>
                            <li><a class="main4" href="memo.php">&nbsp;<?php echo P_MEM;?>&nbsp;</a></li>
                            <li><a class="main4 android" href="mobile.php"><?php echo P_MOBILE?>&nbsp;&nbsp;&nbsp;</a></li>
                            <li><a class="main4" href="logout.php"><?php echo P_LOGOUT;?></a></li>
                        <?php }else{ ?>
                            <li><a class="main3" href="index.php"><?php echo P_HOME;?></a></li>
                            <!-- <li><a class="main3" href="how-to-play.php">Cara Bermain</a></li> -->
                            <li><a class="main3" href="jackpot.php"><?php echo P_JACKPOT?></a></li>
                            <li><a class="main3 android" href="mobile.php"><?php echo P_MOBILE?>&nbsp;&nbsp;&nbsp;</a></li>
                            <li><a class="main1" href="promotion.php">PROMOSI</a></li>
                            <li><a class="main3" href="contact.php"><?php echo P_HELP?></a></li>
                        <?php }
                    }else if ($register== 4){
                        if ($login){
                        ?>
                            <li><a class="main2" href="<?php echo $url_lobby;?>"><?php echo P_LOBBY;?></a></li>
                            <li><a class="main4" href="profile.php">Profil</a></li>
                            <!-- <li><a class="main4" href="how-to-play.php">Cara Bermain</a></li> -->
                            <li><a class="main4" href="deposit.php">Deposit</a></li>
                            <li><a class="main4" href="withdraw.php">Withdraw</a></li>
                            </li>
                            <li><a class="main4" href="memo.php">&nbsp;Memo&nbsp;</a></li>
                            <li><a class="main4 android" href="Mobile.php">Mobile&nbsp;&nbsp;</a></li>
                            <li><a class="main4" href="logout.php">Keluar</a></li>
                        <?php }else{ ?>
                            <li><a class="main1" href="index.php">Home</a></li>
                            <li><a class="main1" href="register.php">Register</a></li>
                            <li><a class="main1" href="deposit.php">Deposit</a></li>
                            <li><a class="main1" href="withdraw.php">Withdraw</a></li>
                            <li><a class="main1" href="jackpot.php">Jackpot</a></li>
                            <li><a class="main1 android" href="Mobile.php">Mobile&nbsp;&nbsp;</a></li>
                            <li><a class="main1" href="promotion.php">PROMOSI</a></li>
                            <li><a class="main1" href="contact.php">Bantuan</a></li>
                        <?php }
                    }
                    ?>
                </ul>
            </div>
        </div>

        <div id="news">
            <div class="container">
                <span><?php echo P_LASTESTINFO;?> :</span>
                <div class="scrollnews">
                <marquee>
                    <ul id="liscroll">
                        <li><a href="javascript:void(0);"><span><?php echo date("d/m/Y"); ?></span>&nbsp;<?php echo $running_txt;?></a></li>
                    </ul>
                </marquee>
                </div>
            </div>
        </div>
