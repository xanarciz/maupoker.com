<?php

include("../config.php");
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

$new_gameid = strtoupper($_POST["new_gameid"]);
if(strstr($new_gameid," ") || strstr($new_gameid,"'")){
	echo "GAME ID  ( NICKNAME ) TIDAK BOLEH MENGANDUNG SPASI";
}
elseif (!ctype_alnum($new_gameid) || !preg_match('/^[a-zA-Z]+[a-zA-Z0-9._]+$/', $new_gameid)) {
	echo "GAME ID  ( NICKNAME ) TIDAK BOLEH MENGANDUNG ILEGAL KARAKTER ATAU ANGKA SAJA";
}else{
	if($new_gameid!="" && strlen($new_gameid)<=10 && strlen($new_gameid)>=3){
		$sqlcekuser = sqlsrv_query($sqlconn,"SELECT id FROM u6048user_id WHERE userid = '".$new_gameid."'",$params,$options);
		$sqlcekuser2 = sqlsrv_query($sqlconn,"SELECT userid FROM u6048user_data WHERE userid = '".$new_gameid."'",$params,$options);
		$sqlcekuser3 = sqlsrv_query($sqlconn,"SELECT userid FROM j2365join_onlinex WHERE userid = '".$new_gameid."'",$params,$options);
		if (sqlsrv_num_rows($sqlcekuser)==0 && sqlsrv_num_rows($sqlcekuser2)==0 && sqlsrv_num_rows($sqlcekuser3)==0) {
			echo "success";
		}
		else{
		 	echo $t12;
		}
	}
	else{
		echo $t13;
	}
}
?>