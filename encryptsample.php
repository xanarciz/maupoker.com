<?php
function encrypt($plain, $key, $hmacSalt = null) {
	//self::_checkKey($key, 'encrypt()');
	if ($hmacSalt === null) {
		$hmacSalt = self::$salt;
	}

	$key = substr(hash('sha256', $key . $hmacSalt), 0, 32); # Generate the encryption and hmac key

	$algorithm = MCRYPT_RIJNDAEL_128; # Encryption algorithm
	$mode = MCRYPT_MODE_CBC; # Encryption mode

	$ivSize = mcrypt_get_iv_size($algorithm, $mode); # Returns the size of the IV belonging to a specific cipher/mode combination
	$iv = mcrypt_create_iv($ivSize, MCRYPT_DEV_URANDOM); # Creates an initialization vector (IV) from a random source
	$ciphertext = $iv . mcrypt_encrypt($algorithm, $key, $plain, $mode, $iv); # Encrypts plaintext with given parameters
	$hmac = hash_hmac('sha256', $ciphertext, $key); # Generate a keyed hash value using the HMAC method
	return $hmac . $ciphertext;
}
function decrypt($cipher, $key, $hmacSalt = null) {
	//self::_checkKey($key, 'decrypt()');
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

$encrypted = encrypt("DanielKusnadi", "agh12sduq0skd7e0qkmc7vn637d5f6fg", "asdf1312");
$decrypted = decrypt($encrypted, "agh12sduq0skd7e0qkmc7vn637d5f6fg", "asdf1312");
echo "ENCRYPTED CODE IS = ".$encrypted;
echo "<br><br>";
echo "DECRYPTED CODE IS = ".$decrypted;
?>