<!DOCTYPE HTML>

<html lang="en">
<head>


<?php
if($page == 'home'){
	$_SESSION['login'] = "";
}

if($_GET["action"]=="logout"){
	$_SESSION = array();
	if(isset($_COOKIE[session_name()])) {
		setcookie(session_name(), '', time()-(60*60*24*30), '/');
	}
	session_destroy();
}


$frontSec = '../';
include_once ("../config.php");
include_once($cfgSecDir."secure.php");

if ($message != ""){
	?>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		alert('<?php echo"".$message."";?>');
	//-->
	</SCRIPT>
	<?php
}
if ($_SESSION["login"] && $message == "") {
	$requiredUserLevel = array('U');
	$login=$_SESSION["login"];
	if($subwebid=='9002') {$cd='RP'; $cdFrLuck = 'RM';}
	if($subwebid=='9001') {$cd='KP'; $cdFrLuck = 'KP';}
	if($subwebid=='172') {$cd='DA'; $cdFrLuck = 'DM';}
	if($subwebid=='42') {$cd='PKR'; $cdFrLuck = '';}
	if ($_POST['entered_login'] && $_POST['entered_password']) {
		header("location:login.php");
		die();
	}

	if ($status == 1){
		$_GET["action"] = "logout";
	}
}

?>


<link href="css/<?PHP echo $link_img;?>/style.css?id=<?PHP echo time(); ?>" rel="stylesheet" type="text/css">
<link href="css/<?PHP echo $link_img;?>/framework.css?id=<?PHP echo time(); ?>" rel="stylesheet" type="text/css">
<link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">	
<link href="css/animate.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="assets/owl-carousel/owl.carousel.css" />
<link href="assets/jquery-ui-1.9.2.custom/css/custom-theme/<?PHP echo $link_img;?>/jquery-ui-1.9.2.custom.css" rel="stylesheet">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

<!-- Favicon -->
<link rel="shortcut icon" href="img/<?PHP echo $link_img;?>/favicon.ico" />
<link rel="apple-touch-icon-precomposed" href="img/apple-touch-icon-precomposed.png">


<!-- JQUERY -->
<script type="text/javascript" src="js/jquery.js"></script>
<script src="assets/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
<!-- SLIDER -->
<script type="text/javascript" src="assets/owl-carousel/owl.carousel.min.js"></script>
<!-- SIDEBAR -->
<script type="text/javascript" src="js/snap.js"></script>
<!-- MOBILE UI -->
<script type="text/javascript" src="js/framework.js"></script>
<!-- CUSTOM JS -->
<script type="text/javascript" src="js/custom.js"></script>
<!-- SMART BANNER JS -->
<script type="text/javascript" src="js/smart-banner.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>

<script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-36423566-1']);
    _gaq.push(['_trackPageview']);

    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl'  : 'http://www')  + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();

</script>

<script language="JavaScript" type="text/javascript">
//<!--
function removecomma(a) {
var res = '';
for (i=0;i<a.length;i++) {
if (a.substr(i,1) == ".") { }
else { res += a.substr(i,1) }
}
return res;
}

function Comma(number) {
number = '' + number;
if (number.length > 3) {
var mod = number.length % 3;
var output = (mod > 0 ? (number.substring(0,mod)) : '');
for (i=0 ; i < Math.floor(number.length / 3); i++) {
if ((mod == 0) && (i == 0))
output += number.substring(mod+ 3 * i, mod + 3 * i + 3);
else
output+= '.' + number.substring(mod + 3 * i, mod + 3 * i + 3);
}
return (output);
}
else return number;
}

function clickBank(a){

	var fom =  document.fdeposit;       /*nama form */
	var s = fom.tBName;
	//var ada = eval("fom.data");
	//var pilih = eval("fom.pilih");


	var tmp = s.selectedIndex;
	var hb = eval("fom.hBNo"+tmp);
	var hc =  eval("fom.hBAcc"+tmp);
	var hbx = eval("fom.hBNo");
	var hcx =  eval("fom.hBAcc");
	//var tb = eval("fom.tBNo");

	var tb = document.getElementById("tBNo");
	var tc = document.getElementById("tBAcc");

	//alert(document.getElementById("tBNo"))

		tb.innerHTML = hb.value;
		tc.innerHTML = hc.value;
		hbx.value = hb.value;
		hcx.value = hc.value;
	//tb.value = hb.value;
	//fom.tBAcc.value = hc.value;

}

function depAmount(a){
	var fom =  document.fdeposit;       /*nama form */
	var amt = eval("fom.amount");
	var am = document.getElementById("amnt");
	var val = amt.value;
	am.innerHTML = 'IDR '+Comma(val	);
}
//-->
</script>

<script type="text/javascript">
    $(document).ready(function() {
        $(".dropdown img.flag").addClass("flagvisibility");

        $(".dropdown dt a").click(function() {
            $(".dropdown dd ul").toggle();
        });

        $(".dropdown dd ul li a").click(function() {
            var text = $(this).html();
            $(".dropdown dt a span").html(text);
            $(".dropdown dd ul").hide();
        });

        function getSelectedValue(id) {
            return $("#" + id).find("dt a span.value").html();
        }

        $(document).bind('click', function(e) {
            var $clicked = $(e.target);
            if (! $clicked.parents().hasClass("dropdown"))
                $(".dropdown dd ul").hide();
        });

        $("#flagSwitcher").click(function() {
            $(".dropdown img.flag").toggleClass("flagvisibility");
        });

    });
</script>

<?php
if ($login){
	if ($kata){
		echo "<script>alert('$kata');</script>";
	}
}
$dir = substr($login,0,1);
$img = "../../Avatar/".$dir."/".$login.".jpg";

if (!file_exists($img)){
	$img = "../../Avatar/default.jpg";
}
$dt = date("Y m d H:i:s");

// if(!$login){
// 	include_once("../geoiploc.php");
// 	$block_list = array('PH','SG');
// 	$white_list = array('203.160.173.203','146.88.66.250','180.232.84.234','180.232.84.235');

// 	if(in_array($code, $block_list)){
// 		if(!in_array($ip, $white_list)){
// 		    echo "<script>window.location= '../restrict.php' ; </script>";
// 		    exit("Page not found");
// 		}
// 	}
// }
?>
<title> Domino88 mobile | website taruhan judi online pecinta domino INDONESIA </title>
<meta name="description" content="Domino88 tempat bermain judi online, pecinta judi online dan merupakan website paling trend di kalangan masyarakat indonesia ">
<meta name=""keywords" content="domino88, domino88 versi mobile, download aplikasi domino88, game online mobile domino88, domino88 versi hadphone, judi mobile domino88">
<meta name="copyright" content="www.logindm88.com">
<meta name="geo.placename" content="Jakarta">
<meta name="geo.region" content="ID-JK">
<meta name="geo.country" content="ID">
<meta name="language" content="ID">
<meta name="tgn.nation" content="Indonesia">
<meta name="rating" content="general">
<meta name="distribution" content="global">
<meta name="author" content="www.logindm88.com/">
<meta name="publisher" content="www.logindm88.com">
<meta name="copyright" content="copyright@ 2017 www.logindm88.com">
<meta content="Jhon poker" name="DC.Creator">
<meta content="domino88, domino88 versi mobile, download aplikasi domino88, game online mobile domino88, domino88 versi hadphone, judi mobile domino88" lang="ind" name="DC.Title">
<meta content="domino88, domino88 versi mobile, download aplikasi domino88, game online mobile domino88, domino88 versi hadphone, judi mobile domino88" lang="ind" name="DC.Subject">
<meta content="domino88, domino88 versi mobile, download aplikasi domino88, game online mobile domino88, domino88 versi hadphone, judi mobile domino88" lang="en" name="DC.Description">
<meta content="2017-06-06" name="DC.Date.LastModified" scheme="ISO 31-1">
<meta content="http://logindm88.com" name="DC.Identifier">
<meta content="domino88 | domino88 versi mobile | download aplikasi domino88 | game online mobile domino88 | domino88 versi hadphone | judi mobile domino88" name="DC.Publisher">
<meta content="ind" name="DC.Language" scheme="ISO639-2">
<meta content="http://logindm88.com" name="DC.Relation.IsPartOf">
<meta content="http://logindm88.com" name="DC.Rights">
</head>