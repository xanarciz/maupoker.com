<!DOCTYPE HTML>

<html lang="en">
<head>
<?php
if($page == 'home'){
	$_SESSION['login'] = "";
}

if(isset($_GET["action"])=="logout"){
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
	if (isset($_POST['entered_login']) && isset($_POST['entered_password'])) {
		header("location:login.php");
		die();
	}

	if (isset($status) == 1){
		$_GET["action"] = "logout";
	}
}

?>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0"/>
<meta name="apple-mobile-web-app-capable" content="yes"/>
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-title" content="Mobile Poker">

<link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/img/<?php echo $link_img;?>/apple-touch-icon-precomposed.png">
<link rel="apple-touch-startup-image" href="img/splash/splash-screen.png" media="screen and (max-device-width: 320px)" />
<link rel="apple-touch-startup-image" href="img/splash/splash-screen_2x.png" media="(max-device-width: 480px) and (-webkit-min-device-pixel-ratio: 2)" />
<link rel="apple-touch-startup-image" sizes="640x1096" href="img/splash/splash-screen_3x.png" />
<link rel="apple-touch-startup-image" sizes="1024x748" href="img/splash/splash-screen-ipad-landscape.png" media="screen and (min-device-width : 481px) and (max-device-width : 1024px) and (orientation : landscape)" />
<link rel="apple-touch-startup-image" sizes="768x1004" href="img/splash/splash-screen-ipad-portrait.png" media="screen and (min-device-width : 481px) and (max-device-width : 1024px) and (orientation : portrait)" />
<link rel="apple-touch-startup-image" sizes="1536x2008" href="img/splash/splash-screen-ipad-portrait-retina.png" media="(device-width: 768px) and (orientation: portrait) and (-webkit-device-pixel-ratio: 2)"/>
<link rel="apple-touch-startup-image" sizes="1496x2048" href="img/splash/splash-screen-ipad-landscape-retina.png" media="(device-width: 768px) and (orientation: landscape)	and (-webkit-device-pixel-ratio: 2)"/>

<title>Mobile Poker</title>

<link rel="shortcut icon" href="../assets/img/<?php echo $link_img;?>/favicon.ico" />

<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/framework.css" rel="stylesheet" type="text/css">
<link href="css/owl.carousel.css" rel="stylesheet" type="text/css">
<link href="css/owl.theme.css" rel="stylesheet" type="text/css">
<link href="css/swipebox.css" rel="stylesheet" type="text/css">
<link href="css/colorbox.css" rel="stylesheet" type="text/css">
<link href="css/li-scroller.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jqueryui.js"></script>
<script type="text/javascript" src="js/owl.carousel.min.js"></script>
<script type="text/javascript" src="js/jquery.swipebox.js"></script>
<script type="text/javascript" src="js/jquery.colorbox.js"></script>
<script type="text/javascript" src="js/snap.js"></script>
<script type="text/javascript" src="js/contact.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<script type="text/javascript" src="js/framework.launcher.js"></script>
<script type="text/javascript" src="js/jquery.form.2.93.js"></script>
<script type="text/javascript" src="js/jquery.maskedinput-1.3.min.js"></script>
<script type="text/javascript" src="js/framework.launcher.js"></script>

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
if(!isset($kata)){$kata = '';}
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
?>

</head>