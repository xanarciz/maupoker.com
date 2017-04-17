<?php
$_SESSION['login'] = "";
if($_GET["action"]=="logout"){
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
	if (!$freePage){include_once($cfgProgDir."secure.php");}
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
	if ($_POST['entered_login'] && $_POST['entered_password']) {
		header("location:rules.php");
		die();
	}

	$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select status,joindate,bankname,bankaccno,bankaccname,bankgrup,email,playerpt,usertype,min_depo,userpass,reflink_count,min_wdraw,save_deposit, xdeposit,userprefix from u6048user_id where userid = '".$_SESSION["login"]."'"),SQLSRV_FETCH_ASSOC);
	$status = $sqlu["status"];

	if ($status == 1){
		$_GET["action"] = "logout";
	}

	$data = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select TXH from u6048user_coin where userid='".$login."'"), SQLSRV_FETCH_ASSOC);
	$dir = substr($login,0,1);
	$img = "Avatar/".$dir."/".$login.".jpg";
	
	if (!file_exists($img)){
		$img = "Avatar/default_avatar.jpg";
	}

	$sqlu = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select status,bankname, bankaccno, bankaccname, bankgrup,playerpt,userpass,email,joindate,save_deposit from u6048user_id where userid ='".$login."'"), SQLSRV_FETCH_ASSOC);
	$bankname = $sqlu["bankname"];
	$bankaccno = $sqlu["bankaccno"];
	$bankaccname = $sqlu["bankaccname"];
	$bankgrup = $sqlu["bankgrup"];
	$playerpt	= $sqlu["playerpt"];
	$pEmail = $sqlu["email"];
	$p = $sqlu["userpass"];
	$joindate = $sqlu["joindate"];
	$saveDeposit = $sqlu["save_deposit"];
	$conv = 1;
	$sql3 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select conversion from a83adm_configgame where gamecode='TXH'"), SQLSRV_FETCH_ASSOC);
	$conv = $sql3["conversion"];
	$sql2	= sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select id,mes from u6048user_transfer where receiver = '".$login."'"), SQLSRV_FETCH_ASSOC);
	$depositmes = $sql2["mes"];
	$depositid	= $sql2["id"];
	$sql2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select TXH from u6048user_coin where userid = '".$login."'"), SQLSRV_FETCH_ASSOC);
	$point = $sql2["TXH"];
	
	$balanceProblem = 0;
	$transpoint = 0;
	$sql2 = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select top 1 total from t6413txh_lastorder where userid = '".$login."' order by Id desc"), SQLSRV_FETCH_ASSOC);
	$transpoint = @$sql2["total"];
	
	if ( $point < -1000 ){
		$balanceProblem = 1;
	}else{
		if ($transpoint > 0) { 
			$balanceProblem = 1;
			if ($point != $transpoint) {
				if ($point < $transpoint){
					sqlsrv_query($sqlconn, "insert into t6413txh_lastorder (Userid,bdate,info,status,amount,gametype,total) values ('".$login."',GETDATE(), '-', 'balance problem', '".$transpoint."', 'TXH', '".$point."')");
					$sql = sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid = '".$login."' order by id desc",$params,$options);
					if (sqlsrv_num_rows($sql) > 3) {
						$data = sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
						sqlsrv_query($sqlconn, "delete from t6413txh_lastorder where userid = '".$login."' and id < '".$data["id"]."'");
					}
				}else if ($point > $transpoint){
					sqlsrv_query($sqlconn, "update u6048user_coin set txh='".$transpoint."'where userid='".$login."'");
					sqlsrv_query($sqlconn, "insert into t6413txh_lastorder (Userid,bdate,info,status,amount,gametype,total) values ('".$login."',GETDATE(), '-', 'balance problem', '".$point."', 'TXH', '".$transpoint."')");
					$sql = sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid = '".$login."' order by id desc",$params,$options);
					if (sqlsrv_num_rows($sql) > 3) {
						$data = sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
						$data = sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
						sqlsrv_query($sqlconn, "delete from t6413txh_lastorder where userid = '".$login."' and id < '".$data["id"]."'");
					}
				}
			}
			$balanceProblem = 0;
		}else if (!$transpoint && $point > 0){
			$balanceProblem = 1;
		}
	}
	
	$record = $depositmes;
	$uang = explode(",",$record);
	sqlsrv_query($sqlconn, "delete from u6048user_transfer where id = '".$depositid."'");
			
	if ($uang[2] != null){
		$dataStatus = "";
		$uangx = $uang[2]*$conv;
		$point = $point+$uangx;
		if( $uang[0] == "1" ){
			$dataStatus = "Deposit";
			$kata="Deposit baru : $uangx";
		}else if ($uang[0] == "2"){
			$dataStatus = "Correction";
			$kata = "Deposit correction : $uangx";
		}else if ($uang[0] == "3"){
			$dataStatus = "Correction";
			$kata = "Deposit correction : $uangx";
		}else if ($uang[0] == "4"){
			$dataStatus = "Withdraw Reject";
			$kata = "Withdraw rejected, ".number_format($uangx)." Refunded";
		}else if ($uang[0] == "5"){
			$dataStatus = "Withdraw";
			$kata = "Withdraw, amount ".number_format($uangx)."";
		}else if ($uang[0] == "6"){
			$dataStatus = "Referral";
			$kata = "Referral bonus, amount ".number_format($uangx)."";
		}else if ($uang[0] == "7"){
			$dataStatus = "Referral";
			$kata = "Bonus Commision, amount ".number_format($uangx)."";
		}else if ($uang[0] == "11"){
			$dataStatus = "Refund";
			$kata = "Refund ".number_format($uangx).", Periode ".number_format($uang[3])." at room ".number_format($uang[4])."";
		}
		$pointz = str_replace(",",".",number_format($point));
		sqlsrv_query($sqlconn, "update u6048user_coin set TXH = '".$point."' where userid = '".$login."'");
		sqlsrv_query($sqlconn ,"insert into t6413txh_transaction (TDate, Periode, RoomId, TableNo, UserId, GameType, Status, Bet, v_bet, Card, Prize, Win, Lose, Cnt, Chip, PTShare, SShare, MShare, AShare, Autotake, DSMaster, DMaster, DAgent, DPlayer, Agent, Master, Smaster) values (GETDATE(), '0', '0', '0', '".$login."', 'TXH', '".$dataStatus."', '0', '".$uangx."', '-', '-', '0', '0', '1', '".$point."', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '')");
		sqlsrv_query($sqlconn, "insert into t6413txh_lastorder (Userid,bdate,info,status,amount,gametype,total) values ('".$login."',GETDATE(), '-', '".$dataStatus."', '".$uangx."', 'TXH', '".$point."')");
		$sql 	= sqlsrv_query($sqlconn, "select id from t6413txh_lastorder where userid = '".$login."' order by id desc",$params,$options);
		
		if (sqlsrv_num_rows($sql) > 3) {
			$data = sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
			$data = sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
			sqlsrv_query($sqlconn, "delete from t6413txh_lastorder where userid = '".$login."' and id < '".$data["id"]."'");
		}	
	}
	$sql1	= sqlsrv_num_rows(sqlsrv_query($sqlconn, "select receiver from u6048user_transfer where receiver = '".$login."'",$params,$options));
	if ($sql1 == 0){
		sqlsrv_query($sqlconn, "update u6048user_id set deposit_pending = '0' where userid = '".$login."'");
	}
	$dataUserId = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userpass from u6048user_id where userid='".$login."'"), SQLSRV_FETCH_ASSOC);
	$upass = $dataUserId["userpass"];
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

    	<?php //include_once ("function/seo/seo_title_".$link_img.".php");?>
		<?php
		//echo "select script_text from u6048user_agencyruntext where agent='".$agentwlable."'";
		$q_script=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select script_text,banner_text from u6048user_agencyruntext   where agent='".$agentwlable."'"),SQLSRV_FETCH_NUMERIC);
		//echo "data : ".$q_script[0]."hihihi";
		if ($q_script[0]!="" && $page !="changeAvatar"){
			echo $q_script[0];
		}
		?>
        <meta name="viewport" content="width=device-width,initial-scale=1">

        <!-- Favicon -->
	    <link rel="shortcut icon" href="assets/img/<?php echo $link_img;?>/favicon.ico" />
        <link rel="apple-touch-icon-precomposed" href="assets/img/<?php echo $link_img;?>/apple-touch-icon-precomposed.png">

        <!-- Stylesheet -->
        <link rel="stylesheet" href="assets/css/normalize.css">
    	<link rel="stylesheet" href="assets/css/main.css">
        <link rel="stylesheet" href="assets/css/<?php echo $link_img;?>.css">

        <!-- Jquery -->
        <!--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="assets/js/jquery-1.10.2.min.js"><\/script>')</script> -->
        <script src="assets/js/jquery-form.js"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
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

        <script language="JavaScript" type="text/javascript">
			jQuery(document).ready(function(){
            	jQuery("body").append("<div id='uialert' class='uialert'></div>");
				jQuery(".popup").nyroModal({
					bgColor: "#000000",
					modal: false
				});
				jQuery('.popup_ads').nyroModal();
				jQuery("#popup_ads").click();

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
    </head>
	