<?php

	class MyAES{
		private $pID;
		private $PublicKey;
		private $PrivateKey;
		public function __construct(){
			$this->PublicKey	= 'AKSDPAOQWEI1203S';
			// $this->PublicKey	= 'H1GH3RLV78789TOP';
		}

		public function getHeaderPK(){
			return $this->PublicKey.$this->fnEncrypt($this->pID, $this->PrivateKey, $this->PublicKey);
		}

		public function setpID($value){
			$this->pID=$value;
		}
		public function setPrivate($value){
			$this->PrivateKey=$value;
		}

		public function getPublic(){
			return $this->PublicKey;
		}

		public function getEnc($value){
			return $this->fnEncrypt($value, $this->PrivateKey, $this->PrivateKey);
		}
		public function getDec($value){
			return $this->fnDecrypt($value, $this->PrivateKey, $this->PrivateKey);
		}

		public function fnEncrypt($sValue, $sSecretKey, $siv){
			$size=mcrypt_get_block_size('rijndael-128', 'cbc');
			$sValue=$this->pkcs5_pad($sValue, $size);
			//if($sSecretKey)
			return rtrim(base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $sSecretKey, $sValue, MCRYPT_MODE_CBC, $siv)), "\0");
		}
		public function fnDecrypt($sValue, $sSecretKey, $siv){
			$size=mcrypt_get_block_size('rijndael-128', 'cbc');
			//if($sSecretKey)
			return $this->pkcs5_unpad(rtrim(mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $sSecretKey, base64_decode($sValue), MCRYPT_MODE_CBC, $siv), "\0"));
		}

		function pkcs5_pad($text, $blocksize){
			$pad=$blocksize-(strlen($text) % $blocksize);
			return $text.str_repeat(chr($pad), $pad);
		}
		function pkcs5_unpad($text){
			$pad=ord($text{strlen($text)-1});
			if($pad > strlen($text)) return false;
			if(strspn($text, chr($pad), strlen($text) - $pad) != $pad) return false;
			return substr($text, 0, -1 * $pad);
		}

	}
?>