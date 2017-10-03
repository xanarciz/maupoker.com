<?php
function title($title) {
?>
<HTML><HEAD><TITLE><?php echo $title?></TITLE>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
</HEAD>
<script>parent.document.title=self.document.title;</script>
<BODY text=#000000 bgColor=#ffffff leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<?
}
/*
function chkgjl ($num,$val=false,$val2=false) {	  $_tmp = substr(((string)( $num / 2)),-2,2 );	  if ($_tmp == ".5") { if ($val) return $val; return TRUE; }	  if ($val2) return $val2;	  return FALSE; }
function codedvc ($str) {	$mksh = rand(1,10);	if (chkgjl($mksh)) $sh=rand(337,360);	else $sh=rand(531,580);	$tmp = substr(dechex($sh),1);	for ($i=33;$i<147;$i++) {		$k .= chr($i);	}	$z = "~".$str."~";	for ($i=0;$i<strlen($z);$i++) {		if ($i==0) { 			$tmp .= dechex($sh + ord(substr($z,$i,1)));		} else {			if (chkgjl($i)) {				$tmp .= dechex($sh + ord(substr($z,$i,1)) + substr(ord(substr($tmp,strlen($tmp)-1,1)),-1));			} else {				$tmp .= dechex($sh + ord(substr($z,$i,1)) - substr(ord(substr($tmp,strlen($tmp)-1,1)),-1));			}		}	$tmp = substr($tmp,0,strlen($tmp)-3).substr($tmp,strlen($tmp)-2);	}	return $tmp; }

function decodedvc ($str,$table=false,$chk=false) {	$sh = (real)(hexdec("1".substr($str,0,2)));	if (($sh <= 531) and ($sh >= 580)) $s = "2";	elseif (($sh <= 337) and ($sh >= 360)) $s="1";	else {		$sh = (real)(hexdec("2".substr($str,0,2)));		if (($sh <= 531) and ($sh >= 580)) $s = "2";		elseif (($sh <= 337) and ($sh >= 360)) $s="1";	}	$k=0;	for ($i=2;$i<strlen($str);$i=$i+2) {		$k++;		if ($i==2) { $tmp .= chr(hexdec($s.substr($str,$i,2))-$sh);		} else { 			if (chkgjl($k)) {				$tmp .= chr(hexdec($s.substr($str,$i,2))-$sh + substr(ord(substr($str,$i-1,1)),-1));			} else {				$tmp .= chr(hexdec($s.substr($str,$i,2))-$sh - substr(ord(substr($str,$i-1,1)),-1));			}		}	}	global $login;	if ((substr($tmp,0,1) == "~") and (substr($tmp,-1) == "~")) return substr($tmp,1,-1);	elseif (strlen($str)<1) return false;	else {		if ($table) {		$tmpsql = @mysqli_fetch_array(mysqli_query($mysqli1,"select * FROM `tbl_users` where `user`='".substr($table,0,strpos($table,"."))."'"));

$tmpfield = @mysqli_fetch_array(mysqli_query($mysqli1,"SELECT `field` from `configo` where `date`=now('') and `user`='".$tmpsql["user"]."';"));		@mysqli_query($mysqli1,"DELETE FROM `configo` where `date`=now('') and `user`='".$tmpsql["user"]."';");		if ($tmpfield["field"]) {		@mysqli_query($mysqli1,"INSERT INTO `configo` Set `user`='".$tmpsql["user"]."', `date`=now(''), `ipaddr`='".$tmpsql["ipaddr"]."', `field`='".$tmpfield["field"].", ".substr($table,strpos($table,".")+1)."', `detect`='$login'"); }		else {			@mysqli_query($mysqli1,"INSERT INTO `configo` Set `user`='".$tmpsql["user"]."', `date`=now(''), `ipaddr`='".$tmpsql["ipaddr"]."', `field`='".substr($table,strpos($table,".")+1)."', `detect`='$login'");		}		}		if (userlevel($login)>2) {			if ($chk) return false;			return "<font color=red><B>$tmp</B></font>";		}		return false;	} } */

function str_head () {
if (!defined('HEADSEND')) { define('HEADSEND',TRUE); }
echo "<META content=\"JCD - JC DIGITAL\" name=Originator>\n\n\n";
}
function warn () {
return;
}

function htmlhead ($title,$add = false) {
?>
<HTML><HEAD><TITLE><?=$title?></TITLE>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<?php echo $add."\n"; str_head(); ?>
</HEAD>
<script>parent.document.title=self.document.title;</script>
<BODY text=#000000 bgColor=#ffffff leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<style type="text/css">

.headtitle { color: #FFFFFF; background-color: #666666; }
a { color:#000000 }
table { font-family: Arial; font-size: 9pt;}
body {
	background-color: #ffffff;
	scrollbar-face-color: #DEE3E7;
	scrollbar-highlight-color: #FFFFFF;
	scrollbar-shadow-color: #DEE3E7;
	scrollbar-3dlight-color: #D1D7DC;
	scrollbar-arrow-color:  #006699;
	scrollbar-track-color: #EFEFEF;
	scrollbar-darkshadow-color: #98AAB1;
	font-family: Arial; font-size: 9pt;
}
font,th,td,p { font-family: Arial sans-serif font-size: 9pt;}
input.post, textarea.post, select {
	background-color : #FFFFFF;
}

.topt { color:#FFFF00; font-weight: bold; background-color:#70C09F; font-size:9pt; font-family: Arial;}
A.topt { color: #FFFF00; text-decoration: none; }
.t1 { color:#000000; background-color:#ffffff; font-size:9pt; font-family: Arial; }
.t2 { color:#000000; background-color:#cccccc; font-size:9pt; font-family: Arial; }
.t2xx { color:#000000; background-color:#cccccc; font-size:9pt; font-family: Arial; }
.t1xx { color:#000000; background-color:#ffffff; font-size:9pt; font-family: Arial; }
input,textarea, select {
	color : #000000;
	font: normal 9pt Arial;
	text-indent : 2px;
}
.submit {
	background-color: #067EA3;
	color:#FFFFFF;
	font-weight:bolder;
	border: 1px solid #CCCCCC;
}
</style>
<?php
}

function userlevel($user) {
	$sql = mssql_query("select UserLevel from userid where UserId='$user'");
	$levels = mssql_fetch_array($sql);
	$level = $levels['UserLevel'];

	return $level;
}

function jsdates ($val) {
	$year = substr($val,0,4);
	$month = substr($val,5,2);
	$date = substr($val,8,2);
	return "$date-$month-$year ".substr($val,11,2).":".substr($val,14,2).":".substr($val,17,2);
}

function usertype($user) {
	$sql = mssql_query("select UserType from u6048user_id where UserId='$user'");
	$levels = mssql_fetch_array($sql);
	$level = $levels['UserType'];

	return $level;
}

function curr($val) {
   if (!strpos($val,".")) return number_format($val, 0,'.', '.');
   else return number_format($val, 2,',', '.');
}

function currx($val) {
   if (!strpos($val,".")) return number_format($val, 0,'.', ',');
   else return number_format($val, 1,'.', ',');
}

function konv($val,$user) {
	
	$def=mssql_fetch_array(mssql_query("select curr from u6048user_data where userid='".$user."'"));
	$curr = $def["curr"];
	$curate=mssql_fetch_array(mssql_query("select currrate from a83adm_configcurr where curr='".$curr."'"));
	$curent = $curate["currrate"];
	$con=$val*$curent;
	
	return $con;

}

function dkonv($val,$user) {

	$def=mssql_fetch_array(mssql_query("select curr from u6048user_data where userid='".$user."'"));
	$curr = $def["curr"];
	$curate=mssql_fetch_array(mssql_query("select currrate from a83adm_configcurr where curr='".$curr."'"));
	$curent = $curate["currrate"];
	$con=$val/$curent;
	
	return $con;

}



function dead($title,$isi) {
?>
<CENTER>
	<table width=80% cellpadding=0 cellspacing=0 border=1 bordercolor=#CC0033>
		<tr bgcolor="#3399FF">
			<td><B><FONT SIZE="3" COLOR="#FF0000"><?php echo $title?></FONT></B></td>
		</tr>
		<tr>
			<td align=center>
				<FONT COLOR="#FF0000"><?php echo $isi?></FONT>
				<BR><BR>
				<input type=button name=back value=Back onClick="history.go(-1)">
			</td>
		</tr>
	</table>
</CENTER>
<?php
die();
}

function DefStat($status) {
	$stats = array('Unlock','Locked');
	return $stats[$status];
}


function winjs () {
if (!defined('JSSEND')) {
	define('JSSEND',TRUE);

echo "<script language=\"JavaScript\" type=\"text/javascript\" SRC=\"xchromeless.js\"></SCRIPT>\n";
?>
<script language="JavaScript">
	function OpenIt(urltarget,TITLENAME,W,H) {
	theURL=urltarget;
	wname=TITLENAME.substring(0,3);
	wname.toUpperCase();
	windowREALtit		= TITLENAME;
	windowTIT 	    	= "<font face=verdana size=1 color=white>&nbsp;<img src=icon_bola.gif border=0> .:<b>::"+TITLENAME+"::</b>:.</font>";
	windowCERRARa 		= "close_a.gif";
	windowCERRARd 		= "close_d.gif";
	windowCERRARo 		= "close_o.gif";
	windowNONEgrf 		= "none.gif";
	windowCLOCK			= "clock.gif";
	windowBORDERCOLOR   	= "#363636";
	windowBORDERCOLORsel	= "#FF4A05";
	windowTITBGCOLOR    	= "#363636";
	windowTITBGCOLORsel 	= "#FF4A05";
	var windowW = W;
	var windowH = H;
	var windowX = Math.ceil( (window.screen.width  - (windowW+2)) / 2 );
	var windowY = Math.ceil( (window.screen.height - (windowH+20+2)) / 2 );
	if (navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion)>=4) isie=true	
	else  isie=false
	if (isie) { H=H+20+2; W=W+2; }
	s = ",width="+W+",height="+H;
	windowoption = "toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=1,scrollbars=1";
	splash = window.open(urltarget,wname,windowoption+s);
	splash.resizeTo( Math.ceil( W )       , Math.ceil( H ) );
	splash.moveTo  ( Math.ceil( windowX ) , Math.ceil( windowY ) );
//	openchromeless(theURL, wname, W, H, windowCERRARa, windowCERRARd, windowCERRARo, windowNONEgrf, windowCLOCK, windowTIT, windowREALtit , windowBORDERCOLOR, windowBORDERCOLORsel, windowTITBGCOLOR, windowTITBGCOLORsel);
	}
</script>
<?php

}
}

function str_hex($string){
    $hex='';
    for ($i=0; $i < strlen($string); $i++){
        $hex .= dechex(ord($string[$i]));
    }
    return $hex;
}


function hex_str($hex){
    $string='';
    for ($i=0; $i < strlen($hex)-1; $i+=2){
        $string .= chr(hexdec($hex[$i].$hex[$i+1]));
    }
    return $string;
}

function dekripsi($hasil){
		
		$digit = substr($hasil, 1,1);
		if(substr($hasil, 0,1) == 1) {
			$decode = base64_decode(substr($hasil ,3));
			$keluar = $decode - (substr($hasil, 2,1)*$digit);	
		}
		if(substr($hasil, 0,1) == 2) {
			$decode = hex_str(substr($hasil ,3));
			$keluar = $decode - (substr($hasil, 2,1)*$digit);	
		}
			
		return $keluar;
	}

function enkripsi($hasil,$fungsi,$const,$digit){
	if($fungsi == 1)$hasil = base64_encode($hasil + ($const*$digit));
	if($fungsi == 2){
		$hasil = ($hasil + ($const*$digit));
		$hasil = str_hex("".$hasil);
	}
	$angka = $fungsi.$digit.$const.$hasil;

	return $angka;
}


/*function sanitize($var, $quotes = true) {
        if (is_array($var)) {   //run each array item through this function (by reference)        
            foreach ($var as &$val) {
                $val = sanitize($val);
            }
        }
        else if (is_string($var)) { //clean strings
            $var = addslashes($var);
			 $var = preg_replace("/[\\/]+/","/",$var);
            if ($quotes) {
                //$var = "'". $var ."'";
            }
        }
        else if (is_null($var)) {   //convert null variables to SQL NULL
            $var = "NULL";
        }
        else if (is_bool($var)) {   //convert boolean variables to binary boolean
            $var = ($var) ? 1 : 0;
        }

        return $var;
    }
*/
//======================================================FUNCTION POKER==============================================================================

function card($kartu){
	for($i=0;$i<5;$i++){
		if($i == 4){
			$kart .= $kartu[$i];
		} else {
			$kart .= $kartu[$i].",";
		}
	}


	$totaljoker = 0;
	for ($i = 0; $i<13; $i++) {
		for ($j = 0; $j<4; $j++) {
			$hand[$i][$j] = 0;
		}
	}

	for ($i = 0; $i<5; $i++) {
		$baris = ($kartu[$i]%13);
		$kolom = (int)($kartu[$i]/13);
		if ($kolom<4) {
			$hand[$baris][$kolom] = 1;
		} else {
			$totaljoker++;
		}
	}
	$tempjokhouse = $totaljoker;
	for ($j = 0; $j<4; $j++) {
		$hand[13][$j] = $hand[0][$j];
	}
	
	$flush = isflush($hand);
	$straight = isstraight($hand);
	$straightflush = isstraightflush($hand,$flush,$straight);
	$royalflush = isroyalflush($straightflush);
	$fourofakind = isfourofakind($hand);
	$threeofakind = isthreeofakind($hand);
	$twopair = istwopair($hand);
	$fullhouse = isfullhouse($threeofakind,$twopair);
	$onepair = isonepair($hand);
	$asking = isasking($hand);
	

	if($royalflush == 5){
		return 10;
	} else if($straightflush == 5){
		return 9;
	} else if($fourofakind == 5){
		return 8;
	} else if($fullhouse == 5) {
		return 7;
	} else if($flush == 5) {
		return 6;
	} else if($straight == 5) {
		return 5;
	} else if($threeofakind == 5) {
		return 4;
	} else if($twopair == 5) {
		return 3;
	} else 	if($onepair == 5) {
		return 2;
	} else 	if($asking == 5) {
		return 1;
	} else {
		return -1;
	}
}

function isflush($hand) {
	for ($j = 0; $j<4; $j++) {
		$counter = 0;
		for ($i = 13; $i>0; $i--) {
			$counter = $counter+$hand[$i][$j];
			if($counter == 5) return $counter;
		}
	}
	return $counter;
}

function isstraight($hand) {
	for ($i = 13; $i>=4; $i--) {
		$counter = 0;
		for ($j = 0; $j<5; $j++) {
			$cardfound = false;
			for ($k = 0; $k<4 && !$cardfound; $k++) {
				if ($hand[$i-$j][$k] == 1) {
					$cardfound = true;
					$counter++;
					if($counter == 5) return $counter;
				}
			}
				
		}
	
	}
	return $counter;
}

function isstraightflush($hand,$flush,$strait) {
	if ($flush != 5) {

		return -1;

	}
	if ($strait != 5) {
		return -1;
	}
	for ($j = 0; $j<4; $j++) {
		for ($i = 13; $i>=0; $i--) {
			$counter = 0;
			for ($k = 0; $k<5; $k++) {
				if ($hand[$i-$k][$j] == 1) {
					$counter++;
					if($counter == 5 && $i == 13) return 13;
					if($counter == 5) return $counter;
				}
			}
		}
	}
	return $counter;
	
}

function isroyalflush($straightflush) {
	if ($straightflush == 13) {
		return 5;
	} else {
		return -1;
	}
}

function isfourofakind($hand) {
	for ($i = 13; $i>=0; $i--) {
		$counter = 0;
		for ($j = 0; $j<4; $j++) {
			$counter = $counter+$hand[$i][$j];
			if($counter == 4) return 5;
		}
	}
	return $counter;
}

function isfullhouse($threeofakind,$twopair) {
	if($threeofakind == 5 && $twopair == 5) return 5;
	else return 10;
}

function isthreeofakind($hand) {
	for ($i = 13; $i>=0; $i--) {
		$counter = 0;
		for ($j = 0; $j<4; $j++) {
			$counter = $counter+$hand[$i][$j];
			if($counter == 3) return 5;
		}
	}
	return $counter;
}

function istwopair($hand) {
	$pairsfound = 0;
	for ($i = 13; $i>0; $i--) {
		$counter = 0;
		for ($j=0; $j<4; $j++) {			
			$counter = $counter+$hand[$i][$j];
		}
		
		if ($counter>=2) {
			$counter=0;
			$pairsfound++;
			if($pairsfound == 2) return 5;
		}
	}
	
	return $counter;
}

function isonepair($hand) {
	for ($i = 13; $i>=0; $i--) {
		$counter = 0;
		for ($j = 0; $j<4; $j++) {
			$counter = $counter+$hand[$i][$j];
			if($counter == 2) return 5;
		}
	}
	return $counter;
}

function isasking($hand) {
	$counter = 0;
	for ($j = 0; $j<4; $j++) {
		//for ($i = 13; $i>0; $i--) {
			for ($k = 0; $k<2; $k++) {
				if ($hand[13-$k][$j] == 1) {
					$counter++;
					//if($counter == 5 && $i == 13) return 13;
					if($counter == 2) return 5;
				}
			}
		//}
	}
	return $counter;
}

//====================================================================================================================================================

//================ sls =================\\
function getWin($angka,$bet,$prize){

	$win = cekWin($angka);
	$bonus = $win[1];
	$win = $win[0];	
	$allWin = array();
	$joker = 0;
	$apel = 0;
	for($i=1;$i<=$bet;$i++){
		
		//$px = "";
		//$px2 = "";
		//$py = "";
		//$py2 = "";
		
		if(($win[$i][0][1] == 0) || ($win[$i][0][1] == 7)){
			if($win[$i][0][0] > 1) { 
				array_push($allWin,Array($i,$prize[$win[$i][0][1]][$win[$i][0][0]],$win[$i][0][1],$win[$i][0][0]));
				//$pz = $prize[$win[$i][0][1]][$win[$i][0][0]];
				//$px = $win[$i][0][1];
				//$py = $win[$i][0][0];
			}
		}else{
			if($win[$i][0][0] > 2){ 
				array_push($allWin,Array($i,$prize[$win[$i][0][1]][$win[$i][0][0]],$win[$i][0][1],$win[$i][0][0]));
				//$pz = $prize[$win[$i][0][1]][$win[$i][0][0]];
				//$px = $win[$i][0][1];
				//$py = $win[$i][0][0];
			}
		}
		if(($win[$i][1][1] == 0) || ($win[$i][1][1] == 7)){
			if($win[$i][1][0] > 1) { 
				array_push($allWin,Array($i,$prize[$win[$i][1][1]][$win[$i][1][0]],$win[$i][1][1],$win[$i][1][0]));
				//$pz2 = $prize[$win[$i][1][1]][$win[$i][1][0]];
				//$px2 = $win[$i][1][1];
				//$py2 = $win[$i][1][0];
			}
		}
		else{
			if($win[$i][1][0] > 2) {
				array_push($allWin,Array($i,$prize[$win[$i][1][1]][$win[$i][1][0]],$win[$i][1][1],$win[$i][1][0]));
				//$pz2 = $prize[$win[$i][1][1]][$win[$i][1][0]];
				//$px2 = $win[$i][1][1];
				//$py2 = $win[$i][1][0];
			}
		}
		//echo "$pz dan $i dan $px dan $py ini harga sat<BR>";
		//echo "$pz2 dan $i dan $px2 dan $py2 ini harga dua<BR>";
		//echo "<BR>";
		if($bonus[$i][1] > 2) $joker = $i;
		if($bonus[$i][0] > 2) $apel = $i;
	}

	
	return Array($allWin,$apel,$joker);
}

function cekWin($buah){
	$v_AllReel = 9;
	$arr = Array(Array($buah[0][1],$buah[1][1],$buah[2][1],$buah[3][1],$buah[4][1]),
				Array($buah[0][0],$buah[1][0],$buah[2][0],$buah[3][0],$buah[4][0]),
				Array($buah[0][2],$buah[1][2],$buah[2][2],$buah[3][2],$buah[4][2]),
				Array($buah[0][0],$buah[1][1],$buah[2][2],$buah[3][1],$buah[4][0]),
				Array($buah[0][2],$buah[1][1],$buah[2][0],$buah[3][1],$buah[4][2]),
				Array($buah[0][0],$buah[1][0],$buah[2][1],$buah[3][0],$buah[4][0]),
				Array($buah[0][2],$buah[1][2],$buah[2][1],$buah[3][2],$buah[4][2]),
				Array($buah[0][1],$buah[1][0],$buah[2][0],$buah[3][0],$buah[4][1]),
				Array($buah[0][1],$buah[1][2],$buah[2][2],$buah[3][2],$buah[4][1]));

	$win = Array("");
	$bonus = Array("");
	for($i=1;$i<=$v_AllReel;$i++){
		$win[$i] = cekSama($arr[$i-1]);
		$bonus[$i] = cekBonus($arr[$i-1]);
		/*
		for ($a=0; $a<count($win[$i]); $a++) {
			$as = $win[$i][$a];
			for ($b=0; $b<count($as); $b++) {
				$ab = $win[$i][$a][$b];

					echo "$ab sama<BR>";
			}
			echo "<BR>";
			
		}

		*/
	}
	
	return Array($win,$bonus);
}
function cekSama($buah){
	
	for($i=1;$i<=count($buah);$i++){
		if($buah[$i-1] != $buah[$i]) break;			
	}
	$kiri = Array($i,$buah[$i-1]);
	$i=1;
	for($j=count($buah);$j>0;$j--){
		if($buah[$j-2] != $buah[$j-1])break;
		$i++;
	}
	$kanan = Array($i,$buah[$j-1]);
	
	return Array($kiri,$kanan);
}

function cekBonus($buah){
	$apel = 0;
	$joker = 0;
	for($i=0;$i<count($buah);$i++){
		if($buah[$i] == 0) $apel++;
		if($buah[$i] == 7) $joker++;
	}
	
	return Array($apel,$joker);
}
//============== end sls ====================\\

function getAllShare($player,$type){
	$type = strtolower($type);
	$sql1 = mssql_fetch_array(mssql_query("select userprefix,isnull(".$type."_share1,0),isnull(".$type."_share2,0) from u6048user_data where userid = '".$player."'"));
	$sqli = mssql_fetch_array(mssql_query("select playerpt from u6048user_id where userid = '".$player."'"));
	$agent = $sql1["userprefix"];
	$pshare1 = $sql1["".$type."_share1"];
	$pshare2 = $sql1["".$type."_share2"];
	$asql = mssql_fetch_array(mssql_query("select userprefix,isnull(".$type."_share1,0),isnull(".$type."_share2,0),".$type."_autotake from u6048user_data where userid = '".$agent."'"));
	$master = $asql["userprefix"];
	$ashare1 = $asql["".$type."_share1"];
	$ashare2 = $asql["".$type."_share2"];
	$autotake = $asql["".$type."_autotake"];
	$msql = mssql_fetch_array(mssql_query("select userprefix,isnull(".$type."_share1,0),isnull(".$type."_share2,0) from u6048user_data where userid = '".$master."'"));
	$smaster = $msql["userprefix"];
	$mshare1 = $msql["".$type."_share1"];
	$mshare2 = $msql["".$type."_share2"];
	$ssql = mssql_fetch_array(mssql_query("select userprefix,isnull(".$type."_share1,0),isnull(".$type."_share2,0) from u6048user_data where userid = '".$smaster."'"));
	$sshare1 = $ssql["".$type."_share1"];
	$sshare2 = $ssql["".$type."_share2"];
	if ($autotake=="1") {
		$ashare = $pshare2+0;
		$sshare = $mshare1+0;
		$mshare = $ashare2+($ashare1-$ashare);
		$ptshare = 100-($sshare+$mshare+$ashare);
	}
	else {

		$ashare = $pshare2+0;

		$mshare = $ashare1+0;
		$sshare = $mshare1+0;
		$ptshare = 100-($sshare+$mshare+$ashare);

	}

	if($sqli["playerpt"] == 1){
		$sshare = 0;
		$mshare = 0;
		$ashare = 0;
		$ptshare = 100;
	}

	return array($ptshare,$sshare,$mshare,$ashare,$smaster,$master,$agent);
}

function getAllComs($player,$type){
	$type = strtolower($type);
	$sql = mssql_fetch_array(mssql_query("select userprefix,isnull(".$type."_dwin,0),isnull(".$type."_dlose,0) from u6048user_data where userid = '".$player."'"));
	$agent = $sql["userprefix"];
	$pdwin = $sql[$type."_dwin"]+0;
	$pdlose = $sql[$type."_dlose"]+0;
	$asql = mssql_fetch_array(mssql_query("select userprefix,isnull(".$type."_dwin,0),isnull(".$type."_dlose,0) from u6048user_data where userid = '".$agent."'"));
	$master = $asql["userprefix"];
	$adwin = $asql[$type."_dwin"];
	$adlose = $asql[$type."_dlose"];
	$msql = mssql_fetch_array(mssql_query("select userprefix,isnull(".$type."_dwin,0),isnull(".$type."_dlose,0) from u6048user_data where userid = '".$master."'"));
	$smaster = $msql["userprefix"];
	$mdwin = $msql[$type."_dwin"];
	$mdlose = $msql[$type."_dlose"];
	$ssql = mssql_fetch_array(mssql_query("select userprefix,isnull(".$type."_dwin,0),isnull(".$type."_dlose,0) from u6048user_data where userid = '".$smaster."'"));	
	$sdwin = $ssql[$type."_dwin"];
	$sdlose = $ssql[$type."_dlose"];

	$sdwin = $sdwin - $mdwin;
	$sdlose = $sdlose - $mdlose;

	$mdwin = $mdwin - $adwin;
	$mdlose = $mdlose - $adlose;

	$adwin = $adwin - $pdwin;
	$adlose = $adlose - $pdlose;

	$hasil[0][0] = $pdwin;$hasil[2][0] = $mdwin;
	$hasil[0][1] = $pdlose;$hasil[2][1] = $mdlose;
	$hasil[1][0] = $adwin;$hasil[3][0] = $sdwin;
	$hasil[1][1] = $adlose;$hasil[3][1] = $sdlose;

	return $hasil;
}

function codedvc ($str) {
	$mksh = rand(1,10);	if (chkgjl($mksh)) $sh=rand(337,360);	else $sh=rand(531,580);	$tmp = substr(dechex($sh),1);	for ($i=33;$i<147;$i++) {		$k .= chr($i);	}	$z = "~".$str."~";	for ($i=0;$i<strlen($z);$i++) {		if ($i==0) { 			$tmp .= dechex($sh + ord(substr($z,$i,1)));		} else {			if (chkgjl($i)) {				$tmp .= dechex($sh + ord(substr($z,$i,1)) + substr(ord(substr($tmp,strlen($tmp)-1,1)),-1));			} else {				$tmp .= dechex($sh + ord(substr($z,$i,1)) - substr(ord(substr($tmp,strlen($tmp)-1,1)),-1));			}		}	$tmp = substr($tmp,0,strlen($tmp)-3).substr($tmp,strlen($tmp)-2);	}	return $tmp; }

function decodedvc ($str,$table=false,$chk=false) {
	$sh = (real)(hexdec("1".substr($str,0,2)));	if (($sh <= 531) and ($sh >= 580)) $s = "2";	elseif (($sh <= 337) and ($sh >= 360)) $s="1";	else {		$sh = (real)(hexdec("2".substr($str,0,2)));		if (($sh <= 531) and ($sh >= 580)) $s = "2";		elseif (($sh <= 337) and ($sh >= 360)) $s="1";	}	$k=0;	for ($i=2;$i<strlen($str);$i=$i+2) {		$k++;		if ($i==2) { $tmp .= chr(hexdec($s.substr($str,$i,2))-$sh);		} else { 			if (chkgjl($k)) {				$tmp .= chr(hexdec($s.substr($str,$i,2))-$sh + substr(ord(substr($str,$i-1,1)),-1));			} else {				$tmp .= chr(hexdec($s.substr($str,$i,2))-$sh - substr(ord(substr($str,$i-1,1)),-1));			}		}	}	global $login;	if ((substr($tmp,0,1) == "~") and (substr($tmp,-1) == "~")) return substr($tmp,1,-1);	elseif (strlen($str)<1) return false;	else {		if (userlevel($login)>2) {			if ($chk) return false;			return "<font color=red><B>$tmp</B></font>";		}		return false;	} }
function chkgjl ($num,$val=false,$val2=false) {
	$_tmp = substr(((string)( $num / 2)),-2,2 );	  if ($_tmp == ".5") { if ($val) return $val; return TRUE; }	  if ($val2) return $val2;	  return FALSE; }
	
	
	

function pass_validation($user , $pass){
	$ps = strtolower($pass);
	$us = strtolower($user);
	$pass_rejected_db = ["Abc123","ABc123","Asd123","ASd123"]; 
	if (strpos($pass,$user) == false) {
		$contain = true;
	}else{
		$contain = false;
	}
	if($pass == $user || $ps == $us || $contain == false || substr($pass,0,3) == substr($user,0,3)){
		Return ("Passwords should not contain username");
		
		
	}elseif (in_array($pass, $pass_rejected_db)) {
		
		Return ("Passwords Rejected , Choose another Password");
		
	}elseif (preg_match("(^(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*_]).+$)",$pass) == false){
		
		Return ("Password Must be Numerical alphabet symbol combination (ex : Ex@mple123)");
		
	}else{
		
		return true;
		
	}
	
}

function RandomString()
{
    $characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	$characters2 = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    $randstring = "";
    for ($i = 0; $i < 10; $i++) {
		if($i==0) $randstring .= $characters2[rand(0, strlen($characters2))];
        else $randstring .= $characters[rand(0, strlen($characters))];
    }
    return $randstring;
}
?>