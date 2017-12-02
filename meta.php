<?php
$_SESSION['login'] = "";
if(isset($_GET['action']) && $_GET["action"]=="logout"){
	session_start();
	$_SESSION = array();
	if(isset($_COOKIE[session_name()])) {
		setcookie(session_name(), '', time()-(60*60*24*30), '/');
	}
	session_destroy();
}
$DalamGame = "";
session_start();
$login = $_SESSION["login"];
include_once("config.php");
if (!$login && !$_POST["entered_login"]){
	if (!isset($freePage)){include_once($cfgProgDir."secure.php");}
}else{
	include_once($cfgProgDir."secure.php");
}
if ($message != ""){
	?>
	<SCRIPT LANGUAGE="JavaScript">
		alert('<?php echo"".$message."";?>');
	</SCRIPT>
	<?php
}

if ($_SESSION["login"] && $message == "") {
	$requiredUserLevel = array('U');
	$login=$_SESSION["login"];
	$cdFrLuck ='';
	if($subwebid=='9002') {$cd='RP'; $cdFrLuck = 'RM';}
	if($subwebid=='9001') {$cd='KP'; $cdFrLuck = 'KP';}
	if($subwebid=='172') {$cd='DA'; $cdFrLuck = 'DM';}
	if($subwebid=='42') {$cd='PKR'; $cdFrLuck = '';}
	if ($_POST['entered_login'] && $_POST['entered_password']) {
		header("location:rules.php");
		die();
	}

	if ($status_block == 1){
		$_GET["action"] = "logout";
	}

	$dir = substr($login,0,1);
	$img = "Avatar/".$dir."/".$login.".jpg";
	
	if (!file_exists($img)){
		$img = "Avatar/default_avatar.jpg";
	}

	if ($kata){
		echo "<script>alert('$kata');</script>";
	}
}
?>
<!DOCTYPE html>
<!--[if lt IE 7]>
<html class="no-js lt-ie9 lt-ie8 lt-ie7">
<![endif]-->
<!--[if IE 7]>
<html class="no-js lt-ie9 lt-ie8">
<![endif]-->
<!--[if IE 8]>
<html class="no-js lt-ie9">
<![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->
    <head>
    	<meta charset="utf-8">
    	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<script>
		var j_register = "";
		var j_deposit  = "";
		var j_withdraw = "";
		</script>
		<?php
		if ($infoweb['script_text'] !="" && $page !="changeAvatar"){
			echo $infoweb['script_text'];
		}
			
		?>
        <meta name="viewport" content="width=device-width,initial-scale=1">

        <!-- Favicon -->
	    <link rel="shortcut icon" href="assets/img/<?php echo $link_img;?>/favicon.ico" />
        <link rel="apple-touch-icon-precomposed" href="assets/img/<?php echo $link_img;?>/apple-touch-icon-precomposed.png">

        <!-- Stylesheet -->
        <link rel="stylesheet" href="assets/css/normalize.css">
    	<link rel="stylesheet" href="assets/css/main.css">
        <link rel="stylesheet" href="assets/css/<?php echo $link_img;?>.css?id=<?PHP echo time();?>">

        <!-- Jquery -->
        <!--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="assets/js/jquery-1.10.2.min.js"><\/script>')</script>-->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/jquery-form.js"></script>
		<script src="assets/js/jquery.form.2.93.js"></script>
		
        <!--JQUERYUI-->
		<link rel="stylesheet" href="assets/js/jquery-ui-1.8.16.custom/css/smoothness/jquery-ui-1.8.16.custom.css" />
		<script src="assets/js/jquery-ui-1.8.16.custom/js/jquery-ui-1.8.16.custom.min.js"></script>

        <!-- Modernizr -->
    	<script src="assets/js/modernizr-2.6.2.min.js"></script>

        <!-- Superfish -->
        <link rel="stylesheet" href="assets/js/superfish/superfish.css" />
        <link rel="stylesheet" href="assets/js/superfish/superfish-navbar.css" />
        <script src="assets/js/superfish/superfish.js"></script>

        <!-- Liscroller -->
        <link rel="stylesheet" href="assets/js/liScroller/li-scroller.css" />
        <script src="assets/js/liScroller/jquery.li-scroller.1.0.js"></script>

        <!-- Plugins -->
        <script src="assets/js/plugins.js"></script>
        <script src="assets/js/jquery_cycle_all_pack.js"></script>

		<!--NYROMODAL-->
		<link rel="stylesheet" href="assets/js/nyroModal-1.6.2/nyroModal.full.css" />
		<script src="assets/js/nyroModal-1.6.2/jquery.nyroModal-1.6.2.pack.js"></script>

        <!--NIVO SLIDER-->
		<link rel="stylesheet" href="assets/js/nivoSlider/nivo-slider.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="assets/js/nivoSlider/themes/default/default.css" type="text/css" media="screen" />
		<script src="assets/js/nivoSlider/jquery.nivo.slider.pack.js"></script>

        <!--QUICKACCESS-->
		<link rel="stylesheet" type="text/css" href="assets/js/quickAccess/quickAccess.css" />
		<script language="JavaScript" type="text/javascript" src="assets/js/quickAccess/quickAccess.min.js"></script>

        <script language="JavaScript" type="text/javascript">
			jQuery(document).ready(function(){
            	jQuery("body").append("<div id='uialert' class='uialert'></div>");
				jQuery(".popup").nyroModal({
					bgColor: "#000000",
					modal: false
				});
				jQuery('.popup_ads').nyroModal();
				jQuery("#popup_ads").click();

                //jQuery('#slider').nivoSlider();
                setTimeout(function(){
            		jQuery("#slider").nivoSlider({
            			effect: "random",
            			pauseTime: 5000,
            			controlNav: true,
            			captionOpacity: 1,
                        directionNav:true,
            			directionNavHide: false
            		});
            	}, 2000);

                jQuery('.tabs .tab-links a').on('click', function(e)  {
                    var currentAttrValue = jQuery(this).attr('href');

                    // Show/Hide Tabs

                    //Default Animation
                    //jQuery('.tabs ' + currentAttrValue).show().siblings().hide();

                    //Fade Animation
                    //jQuery('.tabs ' + currentAttrValue).fadeIn(400).siblings().hide();

                    //Slide1 Animation
                    //jQuery('.tabs ' + currentAttrValue).siblings().slideUp(400);
                    //jQuery('.tabs ' + currentAttrValue).delay(400).slideDown(400);

                    //Slide2 Animation
                    jQuery('.tabs ' + currentAttrValue).slideDown(400).siblings().slideUp(400);

                    // Change/remove current tab to active
                    jQuery(this).parent('li').addClass('active').siblings().removeClass('active');

                    e.preventDefault();
                });
            });

            /*CUSTOM POPUP*/
            uialert=function(msg, onclose) {
            	jQuery("#uialert").html(msg).css({
            		"left":"50%",
            		"top":"40%",
                    "z-index":"10000",
            		"marginLeft": "-"+Math.floor((jQuery("#uialert").width()/2)+20)+"px",
            		"marginTop": "-"+Math.floor(jQuery("#uialert").height()/2)+"px"
            	}).fadeIn();
            	setTimeout(
            		function(){
            			jQuery('#uialert').fadeOut();
            			if(onclose!=null){ onclose(); }
            		}, 3000
            	);
            }

            /*TABLE FIX*/
            fixtable=function(table, cellpadding){
            	var bgcolor="#f5f5f5";
            	var cellpad=cellpadding || 7;
            	jQuery(table).attr({
            		"cellpadding": cellpad,
            		"cellspacing": "0",
            		"border": "0",
            		"bgcolor": "#cacaca"
            	});
            	jQuery(table+" thead tr:first").addClass("ui-widget-header");
            	jQuery(table+" tfoot tr:first").addClass("ui-widget-header");
            	jQuery(table+" tbody tr:even").css({
            		"background-color": bgcolor
            	});
            	jQuery(table+" tbody tr:odd").css({
            		"background-color": "#ffffff"
            	});
            }

            /*AJAX URL & FORM*/
            setform=function(form,target,loader,fn){
            	jQuery("#"+form).ajaxForm({
            		target:"#"+target,
            		beforeSubmit:function(){
            			jQuery("#"+target).html("");
            			jQuery("#"+loader).html(loader_img);
            		},
            		success:function(r){
            			jQuery("#"+loader).html("");
            			init();
            			if(fn!=null){fn(r);}
            		}
            	});
            }
            request=function(url,obj,loader,fn){
            	if(!loader){loader=obj;}
            	if(!obj){obj="contentbox";}
            	jQuery("#"+loader).html(loader_img);
            	jQuery.get(url,function(res){
            		jQuery("#"+loader).html("");
            		jQuery("#"+obj).html(res);
            		init();
            		if(fn!=null){fn();}
            	});
            }

            /*LIMIT CHARS*/
            limitchars=function(textid, limit, infodiv){
            	var text=jQuery("#"+textid).val();
            	var textlength=text.length;
            	if(textlength>limit){
            		jQuery("#"+infodiv).html("0");
            		jQuery("#"+textid).val(text.substr(0,limit));
            		return false;
            	}else{
            		jQuery("#"+infodiv).html(limit-textlength);
            		return true;
            	}
            }
            countchars=function(textid, infodiv){
            	var text=jQuery("#"+textid).val();
            	var textlength=text.length;
            	jQuery("#"+infodiv).html(textlength+" / "+parseInt(((textlength/160))+1)+" sms");
            }

            /*DIALOGS*/
            opendialog=function(param){
            	var loader=param.loader;
            	var width=param.width || "auto";
            	var temp_date=new Date();
            	var temp_id="dialog_"+jQuery.trim((((1+Math.random())*0x10000)|0).toString(16).substring(1));
            	jQuery("body").append("<div class='dialog' id='"+temp_id+"'></div>");
            	jQuery("#"+loader).html(loader_img);
            	if(param.url!=null){
            		jQuery.get(param.url, function(data){
            			jQuery("#"+temp_id).append(data).dialog({
            				title: param.title || jQuery("#"+temp_id+" h1.title").html(),
            				open: function(){
            					jQuery("#"+loader).html("");
            					jQuery("#"+temp_id+" h1.title").hide();
            					if(param.open!=null){ param.open(); }
            				},
            				close: function(){
            					jQuery(this).empty().remove();
            					if(param.close!=null){ param.close(); }
            				},
            		   		modal: false,
            				minHeight: 25,
            				minWidth: 25,
            				resizable: false,
            				autoResize: true,
            				width: width
            			}).append("<div style='display:none;' id='temp_id'>"+temp_id+"</div>");
            		});
            	}else{
            		jQuery("#"+temp_id).append(param.content).dialog({
            			title: param.title || jQuery("#"+temp_id+" div.title").html(),
            			open: function(){
            				jQuery("#"+loader).html("");
            				if(param.open!=null){ param.open(); }
            			},
            			close: function(){
            				jQuery(this).empty().remove();
            				if(param.close!=null){ param.close(); }
            			},
            			modal: true,
            			minHeight: 25,
            			minWidth: 25,
            			resizable: false,
            			autoResize: true,
            			buttons: {
            				"Ok": function(){
            					jQuery(this).dialog("close");
            				}
            			},
            			width: width
            		});
            	}
            }
            closedialog=function(obj){
            	/*
            	if(obj==null){obj="dummy";}
            	jQuery("#"+obj).animate({opacity:1.0},1500,function(){
            		jQuery.nyroModalRemove();
            	});
            	*/
            	//jQuery.nyroModalRemove();
            }
		</script>
		
		<?php
		if ($page == "memo"){
		?>
			<!--JQUERY-->
			<script language="JavaScript" type="text/javascript" src="assets/js/jquery-1.5.2.min.js"></script>

			<!--FORM-->
			<script language="JavaScript" type="text/javascript" src="assets/js/jquery.form.2.93.js"></script>

            <!--NYROMODAL-->
			<link rel="stylesheet" type="text/css" href="assets/js/nyroModal-1.6.2/nyroModal.full.css" />
			<script language="JavaScript" type="text/javascript" src="assets/js/nyroModal-1.6.2/jquery.nyroModal-1.6.2.pack.js"></script>

            <!--TIPSY-->
			<link rel="stylesheet" type="text/css" href="assets/js/jquery.tipsy/tipsy.css" />
			<script language="JavaScript" type="text/javascript" src="assets/js/jquery.tipsy/jquery.tipsy.js"></script>
			<script language="JavaScript" type="text/javascript" src="assets/js/js.js"></script>

			<script language="JavaScript" type="text/javascript">
				var loader_img="<img src='js/loading.gif' style='vertical-align:middle' />";
			</script>
			<script language="JavaScript" type="text/javascript">
				jQuery(document).ready(function(){
					jQuery(".defaultvalue").defaultValue();
				})
			</script>
		<?php
		}
		?>
<SCRIPT LANGUAGE="Javascript"><!--
// ***********************************************
// AUTHOR: WWW.CGISCRIPT.NET, LLC
// URL: http://www.cgiscript.net
// Use the script, just leave this message intact.
// Download your FREE CGI/Perl Scripts today!
// ( http://www.cgiscript.net/scripts.htm )
// ***********************************************
var isNS = (navigator.appName == "Netscape") ? 1 : 0;
var EnableRightClick = 0;
if(isNS) 
document.captureEvents(Event.MOUSEDOWN||Event.MOUSEUP);
function mischandler(){
  if(EnableRightClick==1){ return true; }
  else {return false; }
}
function mousehandler(e){
  if(EnableRightClick==1){ return true; }
  var myevent = (isNS) ? e : event;
  var eventbutton = (isNS) ? myevent.which : myevent.button;
  if((eventbutton==2)||(eventbutton==3)) return false;
}
function keyhandler(e) {
  var myevent = (isNS) ? e : window.event;
  if (myevent.keyCode==96)
    EnableRightClick = 1;
  return;
}
document.oncontextmenu = mischandler;
document.onkeypress = keyhandler;
document.onmousedown = mousehandler;
document.onmouseup = mousehandler;
//-->
</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=0,width=800,height=500,left = 100,top = 134');");
}

//-->
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
<!--
var checkflag = "false";
function check(field) {
	if (checkflag == "false") {
		for (i = 0; i < field.length; i++) {
			if ((field[i].getAttribute('id')=='1')){
			field[i].checked = true;
			//document.getElementById('barisku_'+i).style.backgroundColor = '#99FF99';
			}
		}
		tes=document.getElementById('max').value;
		for (x = 0; x < tes; x++) {
			document.getElementById('barisku_'+x).style.backgroundColor = '#99FF99';
		}
		
		checkflag = "true";
		return; 
	}
	else {
		for (i = 0; i < field.length; i++) {
			if ((field[i].getAttribute('id')=='1')){
			field[i].checked = false; 
			}
		}
		tes=document.getElementById('max').value;
		for (x = 0; x < tes; x++) {
			if(x%2==0)	document.getElementById('barisku_'+x).style.backgroundColor = '#dcdcdc';
			else document.getElementById('barisku_'+x).style.backgroundColor = '#ededed';
		}
		checkflag = "false";
		return;
		}
}
//-->
function got_todfx(parameter){ var idspx = document.getElementById('usrid').innerHTML; window.open('https://dewafortune.com/auth/special_entrance.php?user='+idspx+'&acc_token=9a7e8111d09b65e038de0444e96b5a8c&c='+parameter, 'formpopup', 'width=1280,height=700,directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no'); };
</SCRIPT>

    </head>
	