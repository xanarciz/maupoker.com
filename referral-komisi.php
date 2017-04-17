<?php
//$freePage = 1;
include("meta.php");
include("header.php");
if (!$register)exit("<script>location.href='index.php'</script>");

$_GET = sanitize($_GET);
$_POST = sanitize($_POST);
$user = $_GET["userid"];
$date = $_GET["date"];
if($user == "" || $date == "")die("Access Denied");
if($sqlu["userpass"] != $date)die("Access Denied");
$sub = $_GET["st"];
$j = $_GET["j"];
$batas = $_GET["batas"];
$type = $_GET["type"];
$valdate1 = str_replace("-","/",$_POST["date1"]);
$valdate2 = str_replace("-","/",$_POST["date2"]);

function sqlsdate($val){

	$year = substr($val,-12,4);
	$bln = substr($val,0,3);
	$date = substr($val,4,2);

	if ($bln=="Jan") { $month="01"; }
	if ($bln=="Feb") { $month="02"; }
	if ($bln=="Mar") { $month="03"; }
	if ($bln=="Apr") { $month="04"; }
	if ($bln=="May") { $month="05"; }
	if ($bln=="Jun") { $month="06"; }
	if ($bln=="Jul") { $month="07"; }
	if ($bln=="Aug") { $month="08"; }
	if ($bln=="Sep") { $month="09"; }
	if ($bln=="Oct") { $month="10"; }
	if ($bln=="Nov") { $month="11"; }
	if ($bln=="Dec") { $month="12"; }

	return "$month/$date/$year";
}

function currex($val) {
   if (!strpos($val,".")) return number_format($val, 0,'.', ',');
   else return number_format($val, 1,'.', ',');
}

?>
<script LANGUAGE="JavaScript">
function validate (fom) {
	if (fom.user.value.length<1) {
		fom.user.focus();
		alert("Please fill user.");
		return false;
	}
	return true;
}

</script>

<link rel="stylesheet" type="text/css" media="all" href="../skins/aqua/theme.css" title="Aqua" />
<link rel="alternate stylesheet" type="text/css" media="all" href="../calendar-blue.css" title="winter" />
<link rel="alternate stylesheet" type="text/css" media="all" href="../calendar-blue2.css" title="blue" />
<link rel="alternate stylesheet" type="text/css" media="all" href="../calendar-brown.css" title="summer" />
<link rel="alternate stylesheet" type="text/css" media="all" href="../calendar-green.css" title="green" />
<link rel="alternate stylesheet" type="text/css" media="all" href="../calendar-win2k-1.css" title="win2k-1" />
<link rel="alternate stylesheet" type="text/css" media="all" href="../calendar-win2k-2.css" title="win2k-2" />
<link rel="alternate stylesheet" type="text/css" media="all" href="../calendar-win2k-cold-1.css" title="win2k-cold-1" />
<link rel="alternate stylesheet" type="text/css" media="all" href="../calendar-win2k-cold-2.css" title="win2k-cold-2" />
<link rel="alternate stylesheet" type="text/css" media="all" href="../calendar-system.css" title="system" />

<script type="text/javascript" src="../calendar/calendar.js"></script>
<script type="text/javascript" src="../lang/calendar-en.js"></script>
<script type="text/javascript">
var oldLink = null;
function setActiveStyleSheet(link, title) {
  var i, a, main;
  for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
    if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title")) {
      a.disabled = true;
      if(a.getAttribute("title") == title) a.disabled = false;
    }
  }
  if (oldLink) oldLink.style.fontWeight = 'normal';
  oldLink = link;
  link.style.fontWeight = 'bold';
  return false;
}

function selected(cal, date) {
  cal.sel.value = date;
  if (cal.dateClicked && (cal.sel.id == "sel1" || cal.sel.id == "sel3"))
    cal.callCloseHandler();
}

function closeHandler(cal) {
  cal.hide();
  _dynarch_popupCalendar = null;
}


function showCalendar(id, format, showsTime, showsOtherMonths) {
  var el = document.getElementById(id);
  if (_dynarch_popupCalendar != null) {
    _dynarch_popupCalendar.hide();
  } else {
    var cal = new Calendar(1, null, selected, closeHandler);
    if (typeof showsTime == "string") {
      cal.showsTime = true;
      cal.time24 = (showsTime == "24");
    }

    if (showsOtherMonths) {
      cal.showsOtherMonths = true;
    }
    _dynarch_popupCalendar = cal;
	cal.setRange(1900, 2070);
    cal.create();
  }

  _dynarch_popupCalendar.setDateFormat(format);
  _dynarch_popupCalendar.parseDate(el.value);
  _dynarch_popupCalendar.sel = el;
  _dynarch_popupCalendar.showAtElement(el, "Br");
  return false;
}

var MINUTE = 60 * 1000;
var HOUR = 60 * MINUTE;
var DAY = 24 * HOUR;
var WEEK = 7 * DAY;

function isDisabled(date) {
  var today = new Date();
  return (Math.abs(date.getTime() - today.getTime()) / DAY) > 10;
}

function flatSelected(cal, date) {
  var el = document.getElementById("preview");
  el.innerHTML = date;
}

function showFlatCalendar() {
  var parent = document.getElementById("display");
  var cal = new Calendar(0, null, flatSelected);
  cal.weekNumbers = false;
  cal.setDisabledHandler(isDisabled);
  cal.setDateFormat("%A, %B %e");
  cal.create(parent);
  cal.show();
}
</script>

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
			<div id="content">
                <div class="container">

                    <div class="clear space_30"></div>

                    <div class="wrap">
                        <div class="full">
                            <div class="head-wrap">
                                <h1>Komisi Referral</h1>
                            </div>

                            <div class="body-wrap text-justify">
                                <?php
                                if($_POST["submit"]){

                                $_GET = sanitize($_GET);
                                //$user = $_GET["userid"];
								$user=$login;
                                $sub = $_GET["st"];
                                $j = $_GET["j"];
                                $batas = $_GET["batas"];
                                $type = $_GET["type"];

                                //echo $valdate1.";".$valdate2;
                                function sqlsddate($val){

                                	$year = substr($val,-12,4);
                                	$bln = substr($val,0,3);
                                	$date = substr($val,4,2);

                                		if ($bln=="Jan") { $month="01"; }
                                		if ($bln=="Feb") { $month="02"; }
                                		if ($bln=="Mar") { $month="03"; }
                                		if ($bln=="Apr") { $month="04"; }
                                		if ($bln=="May") { $month="05"; }
                                		if ($bln=="Jun") { $month="06"; }
                                		if ($bln=="Jul") { $month="07"; }
                                		if ($bln=="Aug") { $month="08"; }
                                		if ($bln=="Sep") { $month="09"; }
                                		if ($bln=="Oct") { $month="10"; }
                                		if ($bln=="Nov") { $month="11"; }
                                		if ($bln=="Dec") { $month="12"; }

                                	return "$month/$date/$year";
                                }

                                ?>

                                <table width="80%" cellpadding="10" cellspacing="1" border="0" id="table" >
                        			<thead>
                        				<tr class="form-text">
                        					<th>Date</th>
                        					<!-- <th>Turn Over</th> -->
                        					<th>Komisi</th>
                        					<!-- <th>Komisi PT</th> -->
                        				</tr>
                        			</thead>
                        			<tbody align="left">
										<?php
										$sql = sqlsrv_query($sqlconn, "select isnull(sum(tover),0) as ttl, isnull(sum(aref_comm),0) as ttlx, isnull(sum(playerpt_komisi),0) as ttlz,pdate from ".$db2.".dbo.j2365join_transaction_old where pdate >= '".$valdate1."' and pdate <= '".$valdate2."' and (areferral = '".$user."' or player='".$user."') group by pdate order by pdate");
										while($datay = sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC)){
											$tgl = date_format($datay["pdate"],"d-m-Y");
											// $datay = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select isnull(sum(tover),0) as ttl, isnull(sum(aref_comm),0) as ttlx, isnull(sum(playerpt_komisi),0) as ttlz from ".$db2.".dbo.j2365join_transaction_old where pdate = '".date_format($data["pdate"],"Y-m-d")."' and (areferral = '".$user."')"), SQLSRV_FETCH_ASSOC);
											// $dataz = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select isnull(sum(playerpt_komisi),0) as ttlz from ".$db2.".dbo.j2365join_transaction_old where pdate = '".date_format($data["pdate"],"Y-m-d")."' and (player = '".$user."')"), SQLSRV_FETCH_ASSOC);

											$subx += $datay["ttl"];
											$totx += $datay["ttlx"];
											//$totz += $dataz["ttlz"];
										?>
										<tr>
											<!-- <td height="23"><a href="referral-komisidet.php?date=<?php echo"".$date."";?>&tgl=<?php echo"".$tgl."";?>&agent=<?php echo"".$user."";?>" style="text-decoration:none;color:white;"><?php echo"".date_format($datay["pdate"],"M/d/Y")."";?></a></td> -->
											<td height="23"><?php echo"".date_format($datay["pdate"],"d M Y")."";?></td>
											<td><span><?php echo"".currex($datay["ttlx"])."";?></span></td>
										</tr>
										<?php
										}
										?>
									</tbody>

									<tfoot>
										<tr>
											<td height="23" style="color:#000"><span>Grand Total</span></td>
											<!--<td><span><?php echo"".currex($subx)."";?></span></td>-->
											<td style="color:#000"><span><?php echo"".currex($totx)."";?></span></td>
											<!-- <td><span><?php echo"".currex($totz)."";?></span></td> -->
										</tr>
									</tfoot>
                        		</table>

                                <?php } else {?>

                                <form method=post action='referral-komisi.php?date=<?php echo $date;?>&userid=<?php echo $user;?>&st=<?php echo $sub;?>&j=<?php echo $j;?>&batas=<?php echo $batas;?>'>
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Tanggal awal :</label>
                                        <div class="col-lg-2">
                                            <input type="text" name="date1" id=valdate1 placeholder="Tanggal awal" value="<?php echo date("m/d/Y");?>" data-required="true" class="form-control"  onclick=\"return showCalendar('valdate2', '%m-%d-%Y', '24', true);\">
                                        </div>
                                    </div>
									<div class="form-group-full">
                                        <label class="col-lg-1 control-label">Tanggal akhir :</label>
                                        <div class="col-lg-2">
                                            <input type="text" name="date2" id=valdate2 placeholder="Tanggal akhir" value="<?php echo date("m/d/Y");?>" data-required="true" class="form-control"  onclick=\"return showCalendar('valdate2', '%m-%d-%Y', '24', true);\">
                                        </div>
                                    </div>
									<div class="form-group-full">
										<label class="col-lg-1 control-label">&nbsp;</label>
                                        <div class="col-lg-2">
                                            <input type=submit name=submit value=Cari  class="btn btn-submit">
                                        </div>
                                    </div>
                        		</form>

                                <?php } ?>
                            </div>
                        </div>
                    </div>

                    <div class="clear space_30"></div>
                </div>
            </div>
			<script>
			$(function() {
				$( "#valdate1" ).datepicker();
				$( "#valdate2" ).datepicker();
				jQuery(".popup").nyroModal();
					fixtable("#table", null, "#198dd1", "#198dd1", "#33b4ff");
					getfilter();
					jQuery(".toggleCheck").bind("click", function(){
						var current=jQuery(this);
						var table=current.parent().children("a.table").attr("rel");
						var id=current.parent().children("a.id").attr("rel");
						if(confirm("Are you sure want to perform this action? Click 'OK' to continue.")){
							jQuery.get(''+"/"+table+"/"+id+"/"+current.attr("rel"), function(r){
								jQuery("#statusCheck"+id).html(r);
							})
						}
					});
					jQuery("#table th, #table tfoot tr td").css({
						"background":"#00283d",
						"color":"#000000"
					});
					jQuery("#table").css({
						"border":"1px solid #198dd1"
					});
			});
			
			</script>
<?php
include("footer.php");
?>