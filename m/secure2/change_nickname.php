<?php
if ($_POST["logout"]){
	session_destroy();
	echo "<script>window.location='../index.php'</script>"; 
}

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

<html>
<head>
	<title>WELCOME</title>
</head>
<link rel="stylesheet" href="<?php echo assets; ?>/css/style.css">
<link href="assets/js/jquery.keypad/jquery.keypad.css" rel="stylesheet">
<script src="assets/js/jquery_min.js"></script>
<script src="assets/js/jquery.keypad/jquery.plugin.js"></script>
<script src="assets/js/jquery.keypad/jquery.keypad.js"></script>

<style>

</style>
<body >
<div id="main_container">
<div id="shadow">
	
	<center style="padding-top:10px;">
	
	<iframe src="secure/change_nickname_whitelabel.php?public=<?php echo $publicKey;?>&data=<?php echo $encodedData;?>&login=<?php echo $user_login;?>&sb=<?php echo $subwebid;?>&key=<?php echo $password;?>" width="750" height="550"></iframe>
	<div style="width:100%;margin-top:30px;"><a href="index.php" class="btn button_red" style="font-size:25px;padding-left:17px; padding-right:17px;">NEXT</a></div>
	</div>
	
</div>
</div>
</div>
</body>
<?php
exit();
?>