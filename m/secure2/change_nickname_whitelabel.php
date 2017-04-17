<?php
include("../config.php");
$url ="http://".$_SERVER["HTTP_HOST"].$_SERVER["PHP_SELF"];
$success = 0;



$t1 = "WELCOME"; // welcome
$t2 = "Rubah game ID (Nickname)"; // change game id (nickname)
$t3 = "ini hanya berlaku 1 kali saja"; // This is only valid one time only
$t4 = "Login ID hanya digunakan untuk login"; // Login id is only used for login
$t5 = "Game ID ( Nickname) adalah tampilan player di dalam game"; // Game id (nickname) is a player in the game display
$t6 = "Login ID"; // login id
$t7 = "game id ( nickname )"; // game id ( nickname )
$t8 = "masukan game id (nickname) baru dan tekan tombol ganti"; // input game id ( nickname ) and press  the button change
$t9 = "Ganti"; // change
$t10 = "Congratulations GAME ID ( NICKNAME ) you have changed"; // Congratulations GAME ID ( NICKNAME ) you have changed
$t11 = "Game ID ( Nickname) adalah tampilan player di dalam game"; // Game id (nickname) is a player in the game display
$t12 = "GAME ID  ( NICKNAME ) SUDAH DIGUNAKAN PLAYER LAIN. HARAP MENGGUNAKAN GAME ID  ( NICKNAME ) LAIN"; // GAME ID ( NICKNAME ) ALREADY EXIST. PLEASE USE ANOTHER ID ( NICKNAME )
$t13 = "GAME ID  ( NICKNAME ) HARUS 3 SAMPAI 10 KARAKTER"; // GAME ID  ( NICKNAME ) MUST BE 3 TO 10 CHARACTER


if(isset($_GET['thai'])){
	$t1 = "WELCOME"; // welcome
	$t2 = " เปลี่ยนเกมส์ไอดี (ชื่อเล่น)"; // change game id (nickname)
	$t3 = "สามารถใช้ ไอดีในการล็อกอินเข้าสู่ระบยเท่านั้น"; // This is only valid one time only
	$t4 = "ล็กอินไอดีสามารถใช้ไอดีในการล็อกอินเข้าสู่ระบบเท่านั้น"; // Login id is only used for login
	$t5 = "เกมส์ไอดี (ชื่อเล่น) คือแสดงชื่อผู้เล่นในเกมส์"; // Game id (nickname) is a player in the game display
	$t6 = "ชื่อเข้าสู่ระบบ"; // login id
	$t7 = "รหัสเกม (ชื่อเล่น)"; // game id ( nickname )
	$t8 = "กดปุ่มเพื่อเปลี่ยนแปลงอินพุทไอดี"; // the button change
	$t9 = "เปลี่ยนแปลง"; // change
	$t10 = "ขอแสดงความยินดี  เกมส์ไอดี (ชื่อเล่น) ได้ทำการเปลี่ยนแล้ว"; // Congratulations GAME ID ( NICKNAME ) you have changed
	$t11 = "ขอแสดงความยินดี  เกมส์ไอดี (ชื่อเล่น) ได้ทำการเปลี่ยนแล้ว"; // Game id (nickname) is a player in the game display
	$t12 = "GAME ID ( NICKNAME ) ALREADY EXIST. PLEASE USE ANOTHER ID ( NICKNAME ) game"; // GAME ID ( NICKNAME ) ALREADY EXIST. PLEASE USE ANOTHER ID ( NICKNAME )
	$t13 = "GAME ID  ( NICKNAME ) MUST BE 3 TO 10 CHARACTER"; // GAME ID  ( NICKNAME ) MUST BE 3 TO 10 CHARACTER
	$set = "thai=1";
}

if(isset($_GET['eng'])){
	$t1 = "WELCOME"; // welcome
	$t2 = "change game id (nickname)"; // change game id (nickname)
	$t3 = "This is only valid one time only"; // This is only valid one time only
	$t4 = "Login id is only used for login"; // Login id is only used for login
	$t5 = "Game id (nickname) is a player in the game display"; // Game id (nickname) is a player in the game display
	$t6 = "login id"; // login id
	$t7 = "game id ( nickname )"; // game id ( nickname )
	$t8 = "input game id ( nickname ) and press  the button change"; // the button change
	$t9 = "change"; // change
	$t10 = "Congratulations GAME ID ( NICKNAME ) you have changed"; // Congratulations GAME ID ( NICKNAME ) you have changed
	$t11 = "Game id (nickname) is a player in the game display"; // Game id (nickname) is a player in the game display
	$t12 = "GAME ID ( NICKNAME ) ALREADY EXIST. PLEASE USE ANOTHER ID ( NICKNAME ) game"; // GAME ID ( NICKNAME ) ALREADY EXIST. PLEASE USE ANOTHER ID ( NICKNAME )
	$t13 = "GAME ID  ( NICKNAME ) MUST BE 3 TO 10 CHARACTER"; // GAME ID  ( NICKNAME ) MUST BE 3 TO 10 CHARACTER
	$set = "eng=1";
}
if(isset($_GET['viet'])){
	$t1 = " Chào mừng "; // welcome
	$t2 = "Thay đổi tên đăng nhập ( nickname) "; // change game id (nickname)
	$t3 = " Điều này chỉ có giá trị cho 1 lần duy nhất "; // This is only valid one time only
	$t4 = " Đăng nhập id chỉ được sử dụng để đăng nhập "; // Login id is only used for login
	$t5 = "Game id (nickname) là một người chơi trong màn chơi "; // Game id (nickname) is a player in the game display
	$t6 = "id đăng nhập"; // login id
	$t7 = "game id ( nickname )"; // game id ( nickname )
	$t8 = "Vào game id ( nickname ) và nhấn nút thay đổi"; // the button change
	$t9 = "thay đổi"; // change
	$t10 = "Chúc mừng GAME ID ( NICKNAME ) đã được thay đổi"; // Congratulations GAME ID ( NICKNAME ) you have changed
	$t11 = "Game id (nickname) là 1 người chơi trong màn chơi"; // Game id (nickname) is a player in the game display
	$t12 = " Tên đăng nhập đã tồn tại. Vui lòng chọn 1 tên đăng nhập khác"; // GAME ID ( NICKNAME ) ALREADY EXIST. PLEASE USE ANOTHER ID ( NICKNAME )
	$t13 = "Tên đăng nhập phải có từ 3 đến 10 kí tự"; // GAME ID  ( NICKNAME ) MUST BE 3 TO 10 CHARACTER
	$set = "viet=1";
}
if(isset($_GET['cn'])){
	$t1 = "欢迎"; // welcome
	$t2 = "更改游戏帳號(称号)"; // change game id (nickname)
	$t3 = "你只有一次修改的机会"; // This is only valid one time only
	$t4 = "登录帳號仅用于登录"; // Login id is only used for login
	$t5 = "游戏帳號 (称号) 是玩家在游戏中的称号"; // Game id (nickname) is a player in the game display
	$t6 = "登录账号"; // login id
	$t7 = "游戏名称 ( nickname )"; // game id ( nickname )
	$t8 = "输入游戏帳號（称号）然后按下确定"; // the button change
	$t9 = "修改"; // change
	$t10 = "你已成功修改游戏帳號 (称号 ) "; // Congratulations GAME ID ( NICKNAME ) you have changed
	$t11 = "游戏帳號 (称号) 是玩家在游戏中的称号"; // Game id (nickname) is a player in the game display
	$t12 = "游戏帐号（称号）已经存在。请使用其他ID（称号）"; // GAME ID ( NICKNAME ) ALREADY EXIST. PLEASE USE ANOTHER ID ( NICKNAME )
	$t13 = "游戏帐号（称号）必须是3到10个字符"; // GAME ID  ( NICKNAME ) MUST BE 3 TO 10 CHARACTER
	$set = "cn=1";
}

//CREATE IMAGE
function makeimage($filename, $newfilename, $path, $newwidth, $newheight) {
	//SEARCHES IMAGE NAME STRING TO SELECT EXTENSION (EVERYTHING AFTER . )
	$image_type = strstr($filename,  '.');
	//SWITCHES THE IMAGE CREATE FUNCTION BASED ON FILE EXTENSION
	$source = @imagecreatefromjpeg($filename);

	//CREATES THE NAME OF THE SAVED FILE
	$file = $filename;

	//CREATES THE PATH TO THE SAVED FILE
	$fullpath = $path . $file;

	//FINDS SIZE OF THE OLD FILE
	list($width,  $height) = getimagesize($filename);

	//CREATES IMAGE WITH NEW SIZES
	$thumb = imagecreatetruecolor($newwidth,  $newheight);

	//RESIZES OLD IMAGE TO NEW SIZES
	imagecopyresized($thumb,  $source,  0,  0,  0,  0,  $newwidth,  $newheight,  $width,  $height);

	//SAVES IMAGE AND SETS QUALITY || NUMERICAL VALUE = QUALITY ON SCALE OF 1-100
	imagejpeg($thumb,  $fullpath,  60);

	//CREATING FILENAME TO WRITE TO DATABSE
	$filepath = $fullpath;

	//RETURNS FULL FILEPATH OF IMAGE ENDS FUNCTION
	return $filepath;
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
if(isset($_GET['public']) && isset($_GET['data'])) { # If we have received some data 
    $dataArr = explode('&', $_SERVER['QUERY_STRING']); # because php auto decodes $_GET and it's having problem with UTF values
    $limTot = 0;
    foreach($dataArr as $key=>$value) {
    	$limTot++;
    	$aux = explode('=', $value);
        $_GET[$aux[0]] = $aux[1]; # regenerate $_GET with undecoded values
        if($limTot==2) break;
    }
    $key = $_GET['public'];
    $data = rawurldecode($_GET['data']);
    $data = $security->decrypt($data, $key);
    $login = ($data)?  $data : "";
}
else{
	exit("Invalid 1");
}

$user_login = $_GET["login"];
$subwebid = $_GET["sb"];
//GET DATA
$queryGetUser = "select flag from u6048user_id where userid='".$login."' and loginid='".$user_login."' and userpass='".$_GET["key"]."' and subwebid='".$subwebid."'";
// exit($queryGetUser);
$q_exist = sqlsrv_num_rows(sqlsrv_query($sqlconn, $queryGetUser,$params,$options));
if($q_exist==1){
	$q_uid = sqlsrv_fetch_array(sqlsrv_query($sqlconn,$queryGetUser),SQLSRV_FETCH_ASSOC);
	if ($q_uid["flag"] == 0){
		$submit_tidak=$_POST["submit_tidak"]; 
		$submit_ganti=$_POST["submit_ganti"]; 
		


		if ($submit_tidak){
			sqlsrv_query($sqlconn,"update u6048user_id set flag=1 where userid='".$login."'");
			//RESIZE AVATAR
			$dir = substr($login,0,1);
			$movePath = "../Avatar/".$dir."/".$login.".jpg";
			makeimage($movePath, "", "", 100, 100);
			
			$success = 2;
		}else if ($submit_ganti){
			if(strstr($_POST["new_gameid"]," ") || strstr($_POST["new_gameid"],"'")){
				$error = "GAME ID  ( NICKNAME ) TIDAK BOLEH MENGANDUNG SPASI";
			}
			elseif (!ctype_alnum($_POST["new_gameid"]) || !preg_match('/^[a-zA-Z]+[a-zA-Z0-9._]+$/', $_POST["new_gameid"])) {
				$error = "GAME ID  ( NICKNAME ) TIDAK BOOLEH MENGANDUNG ILEGAL KARAKTER";
			} 
			else{
				if($_POST["new_gameid"]!="" && strlen($_POST["new_gameid"])<=10 && strlen($_POST["new_gameid"])>=3){
					$new_gameid = strtoupper($_POST["new_gameid"]);
					$sqlcekuser = sqlsrv_query($sqlconn,"SELECT id FROM u6048user_id WHERE userid = '".$new_gameid."'",$params,$options);
					$sqlcekuser2 = sqlsrv_query($sqlconn,"SELECT userid FROM u6048user_data WHERE userid = '".$new_gameid."'",$params,$options);
					$sqlcekuser3 = sqlsrv_query($sqlconn,"SELECT userid FROM j2365join_onlinex WHERE userid = '".$new_gameid."'",$params,$options);
					if (sqlsrv_num_rows($sqlcekuser)==0 && sqlsrv_num_rows($sqlcekuser2)==0 && sqlsrv_num_rows($sqlcekuser3)==0) {
						//UPDATE ALL DATA
						sqlsrv_query($sqlconn,"update u6048user_data set userid='".$new_gameid."' where userid='".$login."'");
						sqlsrv_query($sqlconn,"update u6048user_data set referral_agent='".$new_gameid."' where referral_agent='".$login."'");
						sqlsrv_query($sqlconn,"update g846game_data set referral_agent='".$new_gameid."' where referral_agent='".$login."'");
						sqlsrv_query($sqlconn,"update u6048user_id set userid='".$new_gameid."', flag=1 where userid='".$login."'");
						sqlsrv_query($sqlconn,"update u6048user_id set userprefix='".$new_gameid."' where userprefix='".$login."'");
						sqlsrv_query($sqlconn,"update u6048user_id set referral_agent='".$new_gameid."' where referral_agent='".$login."'");
						sqlsrv_query($sqlconn,"update g846game_id set referral_agent='".$new_gameid."' where referral_agent='".$login."'");
						sqlsrv_query($sqlconn,"update u6048user_dataref set userid='".$new_gameid."' where userid='".$login."'");
						sqlsrv_query($sqlconn,"update u6048user_dataref set referral_agent='".$new_gameid."' where referral_agent='".$login."'");
						sqlsrv_query($sqlconn,"update u6048user_coin set userid='".$new_gameid."' where userid='".$login."'");
						sqlsrv_query($sqlconn,"update a83adm_deposit set userid='".$new_gameid."' where userid='".$login."'");
						sqlsrv_query($sqlconn,"update a83adm_depositraw set userid='".$new_gameid."' where userid='".$login."'");
						sqlsrv_query($sqlconn,"update a83adm_moneyhistory set userid='".$new_gameid."' where userid='".$login."'");
						sqlsrv_query($sqlconn,"update cas2_db.dbo.j2365join_transaction_old set player='".$new_gameid."' where player='".$login."'");
						sqlsrv_query($sqlconn,"update cas2_db.dbo.j2365join_transaction_old set areferral='".$new_gameid."' where areferral='".$login."'");
						//sqlsrv_query($sqlconn,"update cas2_db.dbo.j2365join_balance_old set userid='".$new_gameid."' where userid='".$login."'");
						sqlsrv_query($sqlconn,"update j2365join_transaction_month set player='".$new_gameid."' where player='".$login."'");
						sqlsrv_query($sqlconn,"update j2365join_transaction_month set areferral='".$new_gameid."' where areferral='".$login."'");
						sqlsrv_query($sqlconn,"update j2365join_transaction set player='".$new_gameid."' where player='".$login."'");
						sqlsrv_query($sqlconn,"update j2365join_transaction set areferral='".$new_gameid."' where areferral='".$login."'");
						sqlsrv_query($sqlconn,"update u6048user_active set userid='".$new_gameid."' where userid='".$login."'");
						sqlsrv_query($sqlconn,"update t6413txh_lastorder set userid='".$new_gameid."' where userid='".$login."'");
						sqlsrv_query($sqlconn,"update u6048user_transfer set receiver='".$new_gameid."' where receiver='".$login."'");
						sqlsrv_query($sqlconn,"update a83adm_forgetpass set userid='".$new_gameid."' where userid='".$login."'");
						sqlsrv_query($sqlconn,"update a83adm_givencoin set userid='".$new_gameid."' where userid='".$login."'");
						sqlsrv_query($sqlconn,"insert into change_userid_log(userid_old,userid_new,tdate,subwebid) values ('".$login."','".$new_gameid."',GETDATE(), '$subwebid')");
						
						//MOVE AVATAR
						$dir = substr($login,0,1);
						$dir2 = substr($new_gameid,0,1);
						$movePath = "../Avatar/".$dir."/".$login.".jpg";
						$movePath2 = "../Avatar/".$dir2."/".$new_gameid.".jpg";
						if($subwebid!=9000 && $subwebid!=9001 && $subwebid!=9002){
							rename($movePath, $movePath2);
							//makeimage($movePath2, "", "", 100, 100);
							unlink($movePath);
						}
						
						$success = 1;
						
						//$_SESSION["login"]=$new_gameid;
					}
					else{
						$error = $t12;
					}
				}
				else{
					$error = $t13;
				}
			}
		}
	}else{
		exit("Cannot change GAME ID  ( NICKNAME )");	
	}
}
else{
	exit("INVALID 2");
}



?>

<html>
<head>
	<title><?php echo  $t1?></title>
</head>
<link rel="stylesheet" href="css/global.css">
<script src="../assets/js/jquery-1.11.0.min.js"></script>

<style>

</style>
<body >
	<center>
		<div style="height:30px;"></div>
		<div class="head-wrap">
			<table cellpadding=5 width="500" cellspacing=0>
				<tr>
					<td  style="border-bottom:1px #fff solid;" valign=top>
						<h1 style=""><?php echo  $t1;?></h1>
						<div style="font-family:verdana;font-size:25px;"><b><?php echo $user_login;?></b></div>
						<br>
					</td>
				</tr>
				<tr>
					<td colspan=2 style=padding-top:25px;>
						<?php if ($success==1){ ?>
						<h2><?php echo $t10;?></h2>
						<h4><?php echo $t4;?></h2>
						<h4><?php echo $t5;?></h2>
						<div>
							<table style="font-size:20px;" cellpadding=5>
								<tr>
									<td><?php echo  $t6;?></td><td width="30" align="center"> : </td><td><?php echo $user_login?></td>
								</tr>
								<tr>
									<td><?php echo  $t7;?></td><td width="30" align="center"> : </td><td><?php echo $new_gameid?></td>
								</tr>
							</table>
						</div>


						<script>//setTimeout(function(){ window.location="../index.php"; }, 5000);</script>
						<?php } else if ($success==2){ ?>
						<h4><?php echo $t4;?></h2>
						<h4><?php echo $t5;?>></h2>
						<div>
							<table style="font-size:20px;" cellpadding=5>
								<tr>
									<td><?php echo $t6;?></td><td width="30" align="center"> : </td><td><?php echo $user_login?></td>
								</tr>
								<tr>
									<td><?php echo $t7;?></td><td width="30" align="center"> : </td><td><?php echo $login?></td>
								</tr>
							</table>
						</div>
						<script>//setTimeout(function(){ window.location="../index.php"; }, 5000);</script>
						<?php } else {?>
						<h2><?php echo $t2;?></h2>
						<h4><?php echo $t3;?> </h4>
						<h4><?php echo $t4;?></h2>
						<h4><?php echo $t5;?></h2>
						<form method="post" action="?public=<?php echo $_GET["public"];?>&data=<?php echo $_GET["data"];?>&key=<?php echo $_GET["key"];?>&login=<?php echo $_GET["login"];?>&sb=<?php echo $_GET["sb"];?>">
						<div style="padding:10px;">
							<table style="font-size:20px;" cellpadding=5>
								<tr>
									<td><?php echo $t6;?></td><td width="30" align="center"> : </td><td><?php echo $user_login?></td>
								</tr>
								<tr>
									<td><?php echo $t7;?></td><td width="30" align="center"> : </td><td><?php echo $login?></td>
								</tr>
							</table>
						</div>
						<!--<div style="padding:5px;"><input type=submit name=submit_tidak value="saya setuju mengunakan GAME ID <?php echo $login;?>" class="btn btn-submit" style="width:660px;" ></div>-->
						</form>
						<form method="post" action="?public=<?php echo $_GET["public"];?>&data=<?php echo $_GET["data"];?>&key=<?php echo $_GET["key"];?>&login=<?php echo $_GET["login"];?>&sb=<?php echo $_GET["sb"]."&".$set;?>">
						<div style="padding:5px 5px 0px 5px;font-size:16px;color:yellow;"><?php echo $t8;?></div>
						<div style="padding:5px 5px 0px 5px;font-size:16px;color:yellow;"><?php echo "Disarankan mengunakan huruf & angka.";?></div>
						<div id='errorMessage' style="color:red"><?php echo $error;?></div>
						<div style=padding:5px>
							<img id="true" style="display: none; height:35px; float:left; padding-right:5px;" src="images/true.png">
							<img id="false" style="display: none; height:35px; float:left; padding-right:5px;" src="images/false.png">
							<input type='text' id='nick' value="<?php echo $_GET['new_gameid'] ?>" name='new_gameid' maxlength='10' style='height:35px;border-radius:5px;color:#000;font-size:16px;padding:2px;' onchange="checkInput(this.value)">&nbsp;
							<input type=submit name=submit_ganti value="<?php echo $t9; ?>" class="btn btn-login" style="margin-top:-2px;">
						</div>
						</form>
						<?php } ?>
					</td>
				</tr>
			</table>
		</div>
	</center>
</body>
<script type="text/javascript">
function checkInput(val){
	$.ajax({
        url: 'check_nickname.php',
        type: 'POST',
        data: {new_gameid: val},
        success: 
        function(output){
        	if(output!='success'){
				document.getElementById('errorMessage').innerHTML = output;
				document.getElementById('true').style.display = 'none';
				document.getElementById('false').style.display = 'block';
				document.getElementById('nick').style.backgroundColor = '#fcf4f2';
				document.getElementById('nick').style.boxShadow = '0 0 5px 0 rgba(234,202,202,0.5)';
				document.getElementById('nick').style.borderColor = '#bf0000';
			}
			else{
				document.getElementById('errorMessage').innerHTML = '';
				document.getElementById('true').style.display = 'block';
				document.getElementById('false').style.display = 'none';
				document.getElementById('nick').style.backgroundColor = '#f9fff6';
				document.getElementById('nick').style.boxShadow = '0 0 5px 0 rgba(217,255,198,0.5)';
				document.getElementById('nick').style.borderColor = '#4aff57';
			}
        }
    });
}

$(function () {
	$('#pin').keypad({showOn: 'both', randomiseNumeric: true});
});
</script>
<?php
exit();
?>

