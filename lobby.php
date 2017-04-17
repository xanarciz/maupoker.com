<?php
include("meta.php");
include("header.php");
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

//FOR LASTORDER CREATE New
/*
$sqlX = sqlsrv_query($sqlconn,"select id from t6413txh_lastorder where userid = '".$login."'",$params,$options);
if (Sqlsrv_num_rows($sqlX) == 0) {
	$sqlcoin = sqlsrv_query($sqlconn,"select TXH from u6048user_coin where userid = '".$login."'",$params,$options);
	if (Sqlsrv_num_rows($sqlcoin) > 0) {
		$tempRowcoin = sqlsrv_fetch_array($sqlcoin);
		
		sqlsrv_query($sqlconn,"INSERT INTO t6413txh_lastorder (userid,status,info,amount,total) VALUES ('".$login."', 'reset', 'reset', '".$tempRowcoin["TXH"]."', '".$tempRowcoin["TXH"]."')");
	}
}*/
?>

<body>

            <div id="content">
                <div class="container">

                    <div class="clear space_30"></div>

                    <div class="wrap">
                        <div class="full">
                            <div class="head-wrap" style="overflow: hidden;">
                                <h1 style="float: left;">Lobby</h1>
								<!--
								<?php if($cdFrLuck != ''){ ?>
								<div style="float:right">
                                    <a href="http://www.dewafortune.com/login.php?id=<?php echo $cdFrLuck;?>" target="_blank"><img src="assets/img/<?php echo $link_img; ?>/button-spinwheel.gif"></a>
                                </div>
                                <?php } ?>
								 <span style="padding:0 5px;"></span>
								-->
                            </div>
							
                            <div class="body-wrap" style="height:680px;">
								<!--<div><a href="http://infodomino88.com/lobby-baru-domino88/" target="_blank"><img src="assets/images/new_lobby_notice.jpg" width="950"></a></div>-->
                                <div class="space_20"></div>							

                                <div align="center">
									<?php	
									
									if($q_game["txh_status"] == 1){
									?>
                                    <div class="left" style="margin-left:5px;float:left;margin-bottom:20px;">
                                        <!--<a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&game=txh&urlBack=$urlBack&key=$key";?>"><img src="assets/images/icon-game/poker.png" width=170/></a>-->
										 <a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&game=txh&urlBack=$urlBack&key=$key";?>"><img src="assets/images/icon-game/poker.png" style="width:130px"/></a>
                                        <div class="space_20"></div>
                                       <!-- <a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=txh&key=$key";?>"><button type="submit" class="btn btn-submit">Poker!</button></a>-->
										<!-- <a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&game=txh&urlBack=$urlBack&key=$key";?>"><button type="submit" class="btn btn-submit">Poker!</button></a>-->
									
                                    </div>
									<?php
									}
									?>
                           
									<?php if ($q_game["dmm_status"] == 1){
									?>
                                    <div class="left" style="margin-left:20px;float:left;margin-bottom:20px;">
                                        <a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=dmm&key=$key";?>"><img src="assets/images/icon-game/domino.png" style="width:130px"/></a>
                                        <div class="space_20"></div>
                                        <!-- <a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=dmm&key=$key";?>"><button type="submit" class="btn btn-submit">Domino!</button></a>-->
										
                                    </div>
									<?php
									}
									?>
									
									<?php if ($q_game["ebn_status"] == 1){
									?>
                                    <div class="left" style="margin-left:20px;float:left;margin-bottom:20px;">
                                        <a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=ebn&key=$key";?>"><img src="assets/images/icon-game/ceme.png" style="width:130px"/></a>
                                        <div class="space_20"></div>
                                        <!--<a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=ebn&key=$key";?>"><button type="submit" class="btn btn-submit">Ceme!</button></a>-->
										 
                                    </div>
									<?php
									}
									?>
                                    
									<?php if ($q_game["bjk_status"] == 1){
									?>
                                    <div class="left" style="margin-left:20px;float:left;margin-bottom:20px;">
                                        <a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=bjk&key=$key";?>"><img src="assets/images/icon-game/blackjack.png" style="width:130px"/></a>
                                        <div class="space_20"></div>
                                        <!-- <a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=bjk&key=$key";?>"><button type="submit" class="btn btn-submit">Blackjack!</button></a>-->
										
                                    </div>
									<?php
									}
									?>
									<?php if ($q_game["cap_status"] == 1){
									?>
                                    <div class="left" style="margin-left:20px;float:left;margin-bottom:20px;">
                                        <a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=cap&key=$key";?>"><img src="assets/images/icon-game/capsa.png" style="width:130px"/></a>
                                        <div class="space_20"></div>
                                        <!-- <a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=cap&key=$key";?>"><button type="submit" class="btn btn-submit">Capsa!</button></a>-->
										
                                    </div>
									<?php
									}
									?>
									<?php if ($q_game["lpk_status"] == 1){
									?>
                                    <div class="left" style="margin-left:20px;float:left;margin-bottom:20px;">
                                        <a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=lpk&key=$key";?>"><img src="assets/images/icon-game/live-poker.png" style="width:130px"/></a>
                                        <div class="space_20"></div>
                                        <!--<a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=lpk&key=$key";?>"><button type="submit" class="btn btn-submit">Live Poker!</button></a>-->
										
                                    </div>
									<?php
									}
									?>
									<?php if ($q_game["btm_status"] == 1){
									?>
                                    <div class="left" style="margin-left:20px;float:left;margin-bottom:20px;">
                                        <a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=btm&key=$key";?>"><img src="assets/images/icon-game/keliling.png" style="width:130px"/></a>
                                        <div class="space_20"></div>
                                        <!--<a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=btm&key=$key";?>"><button type="submit" class="btn btn-submit">Ceme Keliling</button></a>-->
										
                                    </div>
									<?php
									}
									?>
									<!-- <div style="margin-top:10px;width:100%;float:left;float:left;">
										<a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&key=$key";?>" target="_lobby"><img src="assets/images/BUTTON-LOBBY-BARU2.png"></a>
									</div> -->
                                    
                                    <!--HISTORY-->
                                    <!--
                                    <div style="clear:both;"></div>
                                    <a href="history.php"><button type="submit" class="btn btn-submit">History</button></a>
									<span style="padding:0 5px;"></span>
                                    -->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="clear space_30"></div>
                    <div class="clear space_30"></div>
                </div>
            </div>

            <?php
			include("footer.php");
			?>