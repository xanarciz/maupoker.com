<?php
include("lang_en.php");
$key = $_SESSION["sess_key"];
$urlBack = $_SERVER['SERVER_NAME'];
if ($_SESSION["login"]) {
	$q = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "SELECT menu_text,footer_text,yahoo_id,skype_id,bbm_id,wechat_id,phone_id,whatsapp_id,facebook_id,twitter_id,bank_text,img_main,referral_text,line_id from u6048user_agencyruntext WHERE agent = '".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
	$running_txt = $q["menu_text"];
	$footer_txt = $q["footer_text"];

	$q2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select txh from u6048user_coin where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
	$coin = $q2["txh"];
} else {
	$q = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "SELECT depan_text,footer_text,yahoo_id,skype_id,bbm_id,wechat_id,phone_id,whatsapp_id,facebook_id,twitter_id,bank_text,img_main,referral_text,line_id from u6048user_agencyruntext WHERE agent = '".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
	$running_txt = $q["depan_text"];
	$footer_txt = $q["footer_text"];
	
	//check restricted area
	include "geoiploc.php";
}
$yahoo_id = $q["yahoo_id"];
$skype_id = $q["skype_id"];
$bbm_id = $q["bbm_id"];
$wechat_id = $q["wechat_id"];
$phone_id = $q["phone_id"];
$line_id = $q["line_id"];
$whatsapp_id = $q["whatsapp_id"];
$facebook_id = $q["facebook_id"];
$twitter_id = $q["twitter_id"];

$img_main = explode(";",$q["img_main"]);
$referral_text = $q["referral_text"];

$data_bank=explode(";",$q["bank_text"]);
$status_aktif=$data_bank[0];
$status_bank=explode(",",$data_bank[1]);
$bank_list=["BCA","MANDIRI","BRI","BNI","DANAMON","CIMB","OCBC"];

$q_maintenance=sqlsrv_num_rows(sqlsrv_query($sqlconn,"select maint from a83adm_config where maint='1'",$params,$options));
if ($q_maintenance > 0){
	$q = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "SELECT text from g846runningtext where game = 'maint'"), SQLSRV_FETCH_ASSOC);
	$running_txt = $q["text"];
}

	$data = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select TXH from u6048user_coin where userid='".$login."'"), SQLSRV_FETCH_ASSOC);
	$memo =sqlsrv_num_rows(sqlsrv_query($sqlconn_db2,"select mread from j2365join_memo  where mread='0' and mto='".$login."' and mfrom='".$agentwlable."'",$params,$options));
	if($memo > 0){
		$add="(".$memo.")";
	}else{
		$add="";
	}

include 'dewafortune/dewafortune.php';

$tiket = getTicket();

$q = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"SELECT sessid FROM u6048user_active WHERE userid='".$_SESSION['login']."'"),SQLSRV_FETCH_ASSOC);
$sid = $q["sessid"];
$param = $_SESSION['login'].",".$sid;
//end


$key = $_SESSION["sess_key"];
$q_game = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select txh_status,dmm_status,ebn_status,bjk_status,cap_status,lpk_status,btm_status from u6048user_playeragent where userid = '".$agentwlable."'"),SQLSRV_FETCH_ASSOC);


$urlBack = $_SERVER['SERVER_NAME'];

//ENCRYPTION DECRYPTION CLASS FUNCTION
class Security {
    # Private key
    public static $salt = 'heilhitler'; 
    # Encrypt a value using AES-256.
    public static function encrypt($plain, $key, $hmacSalt = null) {
        self::_checkKey($key, 'encrypt()');
        if ($hmacSalt === null) {
            $hmacSalt = self::$salt;
        }
        $key = substr(hash('sha256', $key . $hmacSalt), 0, 32); # Generate the encryption and hmac key
        $algorithm = MCRYPT_RIJNDAEL_128; # encryption algorithm
        $mode = MCRYPT_MODE_CBC; # encryption mode
        $ivSize = mcrypt_get_iv_size($algorithm, $mode); # Returns the size of the IV belonging to a specific cipher/mode combination
        $iv = mcrypt_create_iv($ivSize, MCRYPT_DEV_URANDOM); # Creates an initialization vector (IV) from a random source
        $ciphertext = $iv . mcrypt_encrypt($algorithm, $key, $plain, $mode, $iv); # Encrypts plaintext with given parameters
        $hmac = hash_hmac('sha256', $ciphertext, $key); # Generate a keyed hash value using the HMAC method
        return $hmac . $ciphertext;
    }
    # Check key
    protected static function _checkKey($key, $method) {
        if (strlen($key) < 32) {
            echo "Invalid public key $key, key must be at least 256 bits (32 bytes) long."; die();
        }
    }
    # Decrypt a value using AES-256.
    public static function decrypt($cipher, $key, $hmacSalt = null) {
        self::_checkKey($key, 'decrypt()');
        if (empty($cipher)) {
            echo 'The data to decrypt cannot be empty.'; die();
        }
        if ($hmacSalt === null) {
            $hmacSalt = self::$salt;
        }
        $key = substr(hash('sha256', $key . $hmacSalt), 0, 32); # Generate the encryption and hmac key.
        # Split out hmac for comparison
        $macSize = 64;
        $hmac = substr($cipher, 0, $macSize);
        $cipher = substr($cipher, $macSize);
        $compareHmac = hash_hmac('sha256', $cipher, $key);
        if ($hmac !== $compareHmac) {
            return false;
        }
        $algorithm = MCRYPT_RIJNDAEL_128; # encryption algorithm
        $mode = MCRYPT_MODE_CBC; # encryption mode
        $ivSize = mcrypt_get_iv_size($algorithm, $mode); # Returns the size of the IV belonging to a specific cipher/mode combination
        $iv = substr($cipher, 0, $ivSize);
        $cipher = substr($cipher, $ivSize);
        $plain = mcrypt_decrypt($algorithm, $key, $cipher, $mode, $iv);
        return rtrim($plain, "\0");
    }
    # Get Random String - Usefull for public key
    public function genRandString($length = 0) {
        $charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        $str = '';
        $count = strlen($charset);
        while ($length-- > 0) {
            $str .= $charset[mt_rand(0, $count-1)];
        }
    return $str;
    }
}
$security = new Security();
$string = $login; 
$publicKey = $security->genRandString(32);
$encryptedData = $security->encrypt($string, $publicKey);
$encodedData = rawurlencode($encryptedData);

?>

<body>

    <style type="text/css">
        .spin {
            font-size: 16px;
            font-family: 'big_noodle_titlingx';
            margin-right: -180px;
            margin-top: -90px;
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
	<!--
<script type="text/javascript" src="assets/js/visits.js" data-game='1'></script>
-->

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
				if ($line_id){
				?>
				<li><a href="javascript:void(0);" class="quickAccess-varia_9"><?php echo $line_id; ?></a></li>
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
		<!--
		
	
<?php	
	// exit(strpos($nonWWW, "kartupoker")." ".$nonWWW."Maintanance");
$qry = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select email from u6048user_id where userid ='".$_SESSION['login']."'"), SQLSRV_FETCH_ASSOC);
function curl($url,  $postdata){

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $postdata);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            $curl_data = json_decode(curl_exec($ch));

            curl_close($ch);

            return $curl_data;

    }
	
function after_login($userid,$email){

	// QUERY IF USER IS VERFIED USER 
	$url = 'http://email.6mbr.com/api/email_check';
	$data = array('api_key' => 'ASDFCAZ123FCRFFGVHGVUSVAH',
			'web_id'=> 'domino88321',
			'popup_id' => '1405531097',
			'userid' => $userid,
			'email' => $email
			);

	$response = curl($url, $data);
	if($response->status == 'success'){
		return 1;
	}
	else{
		return 0;
	}
}
$valid = after_login($_SESSION['login'],$qry['email']);
	if($_SESSION['login'] && $valid == 1 && $subscribe == 0){
?>
<script src="http://code.jquery.com/jquery-2.1.4.js"></script>
<script src="http://email.6mbr.com/assets/general_modal/subscribe_modal.js" data-modalid="1405531097" data-email="<?php echo $qry['email']; ?>"></script>		
<script>
    $(document).on("submit", "#form_subscribe", function(e) {
        e.preventDefault();
        $.ajax({
            type: "post",
            data: $("#form_subscribe").serialize(),
            url: "subscribe_email.php",
            dataType: "json",
            success: function(res) {
                if (res.status == "success") {
                    $(".zxcvzxcv").zxcvzxcv("hide");
                    $(".mask").hide();
                    swal("Thank You", "Successfully Subscribe! Please Check your email!", "success");
                } else {
                    $(".mask").hide();
                    swal("Oops...", res.message, "error");
					$.removeCookie('subscribe', { path: '/' });
                }
            },
            beforeSend: function() {
                $(".mask").show();
            },
            error: function() {
                $(".mask").hide();
                swal("Oops...", "Invalid Email!", "error");
				$.removeCookie('subscribe', { path: '/' });
            }
        });

    });
</script>
<?php 
	}
?>
		
		
		-->
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
		<style>
			.v88{
				float: right;
				width: 170px;
				height: 70px;

				background: url(assets/images/v88.png) 0px 0px no-repeat;
			}
		</style>
        <div class="bank-panel right">
            <ul>                
                <?php 
				function showBankStatus($bankName,$status_bank){
					$bank_list=["BCA","MANDIRI","BRI","BNI","DANAMON","CIMB","OCBC"];
					for ($i=0; $i<6; $i++){
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
				$qBank=sqlsrv_query($sqlconn, "select distinct(bank) from a83adm_configbank where code = '".$agentwlable."' and idx !='0' and (curr = 'IDR')",$params,$options); 
				for ($k=0; $k<sqlsrv_num_rows($qBank); $k++){
					$arrBank=sqlsrv_fetch_array($qBank,SQLSRV_FETCH_ASSOC);
					echo $result=showBankStatus($arrBank["bank"],$status_bank); 
				}
				?>
            </ul>
			<div class=''>
				<div class='v88'></div>
			</div>
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
                        <div class="form-group">
                            <input type="text" placeholder="Validation" id="membervalidation" name="entered_val" class="form-control-login" maxlength="5" tabindex="3">
                        </div>
						<div class="form-group">
                            <img src="captcha/captcha-login.php?.png" alt="VALIDATION" title="VALIDATION" class="form-captcha"/>
                        </div>

                        <button type="submit" class="btn btn-login" tabindex="4">LOGIN</button>
                    </form>
					<?php if ($register==1){ ?><div class="forget-password"><a href="forget-password.php">Forget password?</a></div> <?php } ?>
					<?php 
					}else{
						if($subwebid=='9002' || $subwebid=='9001' || $subwebid=='172' || $subwebid=='42'){
							if($subwebid=='9002') {$k88id='1008'; }
							if($subwebid=='9001') {$k88id='1007'; }
							if($subwebid=='172') {$k88id='1009'; }
							if($subwebid=='42') {$k88id='1010'; }
					?>
						<?php if($cdFrLuck != ''){ ?>
						<div style="position:absolute;margin-left:380px;margin-top:30px;">
							<a href="#"  onclick="window.open('dewafortune/dewafortune.php?f=val_access&p=<?PHP echo rawurlencode(base64_encode($param)); ?>&data=<?php echo rawurlencode(base64_encode("https://dewafortune.com/auth/login_defor.php?userid=".$_SESSION['login']."&sessid=".$sid."&access_token=9a7e8111d09b65e038de0444e96b5a8c"));?>','name','width=1280,height=700')">
								<img src="assets/img/io/button-spinwheel.gif" />
								<?PHP if($tiket != "0"){ ?>
									<p class="spin" align="center"><?PHP echo $tiket;?></p>
								<?PHP } ?>
							</a>
						</div>
						<?php } ?>
						<div class="user-panel" style="max-width: none;min-width:350px; ">
	                        <div class="box box2">
	                            <div class="box-inner">
	                                <div class="avatar-medium">
										<?php
										$myDir = substr($login,0,1);
										$img_avatar = $path."/avatar/".$myDir."/".$login.".jpg?".date("is");
										?>
										<div class="avatar-medium-user" style="background: url(<?php echo $img_avatar;?>) no-repeat;background-size:63px;"></div>
									</div>

	                                <div class="user-info" style="max-width:325px;">
	                                    <div style="margin-top:-8px;"><span class="user-text"><?php echo P_WELCOME;?>,</span></div>
	                                    <div class="clear"></div>
	                                    <span class="user-name"><?php echo $user_login;?></span>
										<div style="margin-top:-8px;"><span class="" style=font-size:12px>( Nickname : <?php echo $login;?> )</span></div>
	                                    <div class="clear"></div>
	                                    <span class="user-chips">CHIPS: <?php echo floor($coin);?></span>
	                                    <span class="user-chips" style="margin-left: 10px;">POIN: <?php echo number_format($poin);?></span>
	                                    <span style="position: absolute;top:10px;margin-left: 170px;">
	                                    	<?php 
											$q = sqlsrv_num_rows(sqlsrv_query($sqlconn,"select top 1 userid from j2365join_poinhistory where userid = '".$login."'",$params,$options));
											if ($q > 1){
											?>
												<a target="_blank" href="https://www.koin88.com/do-game-connect?id=<?php echo $k88id; ?>&userid=<?php echo $user_login ?>&authcode=<?php echo $user_authcode;?>" class="btn btn-login">Redeem Poin</a>
											<?php
											}else{
												?>
													<a target="_blank" href="https://www.koin88.com/do-game-connect?id=<?php echo $k88id; ?>&userid=<?php echo $user_login ?>&authcode=<?php echo $user_authcode;?>" class="btn btn-login">Aktivasi</a>
												<?php
											}
											?>
	                                    </span>
	                                </div>

	                                <div class="clear"></div>
	                            </div>
	                        </div>
	                    </div>
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
					}
					?>
                </div>
            </div>

            <div id="nav">
                <div class="container">
                    <ul class="sf-menu">
						<?php 
						
						//active new lobby (true = redirect to new lobby, false = redirect to old lobby)
						$newLob = true;
						if($newLob){
							$url_lobby = 'http://new.lobbyint.pw/lobby.php?lang=id&user='.$login.'&urlBack='.$urlBack.'&key='.$key;
						}else{
							$url_lobby .= '/lobby.php?public='.$publicKey.'&data='.$encodedData.'&game=txh&urlBack='.$urlBack.'&key='.$key;
						}
						if ($register == 1){
							if ($login){
							?>
								<li><a class="main2" href="<?php echo $url_lobby;?>"><?php echo P_LOBBY;?></a></li>
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
								<li><a class="main1" href="deposit.php"><?php echo P_DEP?></a></li>
								<li><a class="main1" href="withdraw.php"><?php echo P_WIT?></a></li>
								<li><a class="main1" href="referral.php"><?php echo P_AREFCOM ?></a></li>
								<li><a class="main1" href="jackpot.php"><?php echo P_JACKPOT?></a></li>
								<li><a class="main1 android" href="mobile.php"><?php echo P_MOBILE;?></a></li>
								<li>
									<a class="main1" href="point-reward.php">
										<div width="200px" style="margin-top:-5px;">
											<center>
												<p style="font-size:11px;line-height:10px;color:#F15000">POINT</p>
												<p style="line-height:16px;"> REWARD</p>
											</center>
										</div>
									</a>
								</li>
								<li><a class="main1" href="contact.php"><?php echo P_HELP ?></a></li>
							<?php } 
						}else if ($register== 0){
							if ($login){
							?>
								<li><a class="main2" href="<?php echo $url_lobby;?>"><?php echo P_LOBBY;?></a></li>
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
                            <li><a class="main3 android" href="point-reward.php"><?php echo P_MOBILE?>&nbsp;&nbsp;&nbsp;</a></li>
                            <li>
                            	<a class="main1" href="mobile.php">
									<div width="200px" style="margin-top:-5px;">
										<center>
											<p style="font-size:11px;line-height:10px;color:#F15000">POINT</p>
											<p style="line-height:16px;"> REWARD</p>
										</center>
									</div>
								</a>
							</li>
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
								<li>
									<a class="main1" href="point-reward.php">
										<div width="200px" style="margin-top:-5px;">
											<center>
												<p style="font-size:11px;line-height:10px;color:#F15000">POINT</p>
												<p style="line-height:16px;"> REWARD</p>
											</center>
										</div>
									</a>
								</li>
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
								<li>
									<a class="main1" href="point-reward.php">
										<div width="200px" style="margin-top:-5px;">
											<center>
												<p style="font-size:11px;line-height:10px;color:#F15000">POINT</p>
												<p style="line-height:16px;"> REWARD</p>
											</center>
										</div>
									</a>
								</li>
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
            <script language="JavaScript" type="text/javascript">
               /* jQuery(document).ready(function(){
    				jQuery("#liscroll").liScroll();
    			})*/
            </script>
