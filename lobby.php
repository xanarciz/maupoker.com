<?php
include("meta.php");
include("header.php");

$urlBack = $_SERVER['SERVER_NAME'];


//CURR SESSION
if(isset($_GET["currx"])!=""){
	$_SESSION["currx"] = $_GET["currx"];
	$currx = $_GET["currx"];
}elseif(isset($_SESSION["currx"])!=""){
	$currx = $_SESSION["currx"];
}else{
	$_SESSION["currx"] = "IDR";
	$currx = "IDR";
}

$getCode = "LPK";


//ROOM SESSION
if(isset($_GET["roomname"])!=""){
	$_SESSION["roomname"] = $_GET["roomname"];
	$getRoomname = $_GET["roomname"];
}elseif(isset($_SESSION["roomname"])!=""){
	$getRoomname = $_SESSION["roomname"];
}else{
	$_SESSION["roomname"] = "smallest";
	$getRoomname = "smallest";
}


//TIMER SESSION
if(isset($_GET["timer"])!=""){
	$_SESSION["timer"] = $_GET["timer"];
	$timer = $_GET["timer"];
}elseif(isset($_SESSION["timer"])!=""){
	$timer = $_SESSION["timer"];
}else{
	$_SESSION["timer"] = 20;
	$timer = 20;
}



//SEARCH QUERY
$isiSearch = "";
if(isset($_GET["search"])!=""){
	$_GET["search"] = str_replace("SPACE"," ",$_GET["search"]);
	$isiSearch = $_GET["search"];
	// $searcher = " AND a.TableRank LIKE '%".$_GET["search"]."%'";
}
else{
	$isiSearch = "";
	// $searcher = "";
}

// include("myaes.php");

function myCurl($req)
{
	$url = "http://103.249.162.133/core-test/";
	
	//setting the curl parameters.
	$ch = curl_init();

	curl_setopt($ch, CURLOPT_URL, $url);
	// Following line is compulsary to add as it is:
	// $response = $req;
	
	$pkey = '2fb4f029ebf33b9a';
	$myaes = new myaes();
	$myaes->setPrivate($pkey);
	$response = $myaes->getEnc($req);

	curl_setopt($ch, CURLOPT_HTTPHEADER, array("Authorization: ".$myaes->getHeaderPK(), 'Content-Type: text/plain; charset=utf-8'));
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	
	curl_setopt($ch, CURLOPT_POSTFIELDS,"" . $response);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
	$data = curl_exec($ch);
	curl_close($ch);

	//convert the XML result into array
	$array_data = simplexml_load_string($data);
	return $array_data;
}


// <lang>".$lang."</lang>
$req18 = "<request>
			<secret_key>88888111118888811111</secret_key>
			<id>181</id>
			<userid>".$login."</userid>
			<key>".$key."</key>
			<curr>".$currx."</curr>
			<getCode>".$getCode."</getCode>
			<getroomname>".$getRoomname."</getroomname>
			<timer>".$timer."</timer>
			<searcher>".$isiSearch."</searcher>
		</request>";
$table001 = myCurl($req18);



?>

            <div id="content">
                <div class="container">

                    <div class="clear space_30"></div>

                    <div class="wrap">
                        <div class="full">
                            <div class="head-wrap">
                                <h1>Lobby</h1>
								 <span style="padding:0 5px;"></span>
								<!-- <div style='width:100%;margin-bottom:5px;'><a href='<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&game=txh&key=$key&lang=id";?>'><img src="images/BUTTON-LOBBY-BARU2.png" width="605"></a></div> -->
								<Br><br>
                                
                            </div>

                            <div class="body-wrap" style="min-height:530px !important;">
                                <div class="space_20"></div>

                                <div align="center">
								<?php
								
								//READ HTTPS OR HTTP URL
								$protocol = "";
								if(!empty($_SERVER['HTTP_X_FORWARDED_PROTO'])){
									//READ CLOUDFARE'S PROTOCOL
									$protocol .= $_SERVER['HTTP_X_FORWARDED_PROTO'].'://';
								}
								else{
									//READ SERVER PROTOCOLS
									$protocol .= (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS']=="on") ? "https://" : "http://";
								}
								$lobby_dom = ($protocol=="http://")? str_replace("http://","",strtolower($url_lobby)) : "lobby6.lobbyplay.com";
								$url_lobby = $protocol.$lobby_dom;
								$pkey = '02e97eddc9524a1e';
								$myaes = new myaes();
								$myaes->setPrivate($pkey);
								$valuex = $login.','.$_SESSION["sessid"].','.$pin.',id,'.$protocol.','.$urlBack;
								$linktxh = $url_lobby.'/lobby.php?vp='.rawurlencode($myaes->getEnc($valuex.',TXH'));
								$linkdmm = $url_lobby.'/lobby.php?vp='.rawurlencode($myaes->getEnc($valuex.',DMM'));
								$linkebn = $url_lobby.'/lobby.php?vp='.rawurlencode($myaes->getEnc($valuex.',EBN'));
								$linkbjk = $url_lobby.'/lobby.php?vp='.rawurlencode($myaes->getEnc($valuex.',BJK'));
								$linkcap = $url_lobby.'/lobby.php?vp='.rawurlencode($myaes->getEnc($valuex.',CAP'));
								$linklpk = $url_lobby.'/lobby.php?vp='.rawurlencode($myaes->getEnc($valuex.',LPK'));
								$linkbtm = $url_lobby.'/lobby.php?vp='.rawurlencode($myaes->getEnc($valuex.',BTM'));
								$linkspt = $url_lobby.'/lobby.php?vp='.rawurlencode($myaes->getEnc($valuex.',SPT'));
								//$url_lobby = 'http://www.lobbyplay.com/lobby.php?lang=id&user='.$login.'&key='.$key.'&urlBack='.$urlBack;
								// $url_lobby = 'http://lobby5.lobbyplay.com/lobby.php?lang=id&user='.$login.'&key='.$key.'&urlBack='.$urlBack;
								?>

								<div style="display: inline-block;width: 100%;">

									<center>
									<?php 
										if($infoweb["TXH"] == 1){
									?>
                                    <div class="left" style="margin-left:60px;padding: 5px;">
										 <a href="<?php echo $linktxh;?>"><img src="assets/images/icon-game/poker.png" width="130px"/></a>
                                        <div class="space_20"></div>
										<a href="<?php echo $linktxh;?>"><button type="submit" class="btn btn-submit">Poker!</button></a>
                                    </div>
									<?php
									}
									?>
									<?php if ($infoweb["DMM"] == 1){
									?>
                                    <div class="left" style="margin-left:30px;padding: 5px;">
                                        <a href="<?php echo $linkdmm;?>"><img src="assets/images/icon-game/domino.png" width="130px"/></a>
                                        <div class="space_20"></div>
                                        <a href="<?php echo $linkdmm;?>"><button type="submit" class="btn btn-submit">Domino!</button></a>
                                    </div>
									<?php
									}
									?>
									<?php if ($infoweb["EBN"] == 1){
									?>
                                    <div class="left" style="margin-left:30px;padding: 5px;">
                                        <a href="<?php echo $linkebn;?>"><img src="assets/images/icon-game/ceme.png" width="130px"/></a>
                                        <div class="space_20"></div>
                                        <a href="<?php echo $linkebn;?>"><button type="submit" class="btn btn-submit">Ceme!</button></a>
                                    </div>
									<?php
									}
									?>
                                    
									<?php if ($infoweb["BJK"] == 1){
									?>
                                    <div class="left" style="margin-left:0px;padding: 5px;">
                                        <a href="<?php echo $linkbjk;?>"><img src="assets/images/icon-game/blackjack.png" width="130px"/></a>
                                        <div class="space_20"></div>
                                        <a href="<?php echo $linkbjk;?>"><button type="submit" class="btn btn-submit">Blackjack!</button></a>
                                    </div>
									<?php
									}
									?>
									<?php if ($infoweb["CAP"] == 1){
									?>
                                    <div class="left" style="margin-left:30px;padding: 5px;">
                                        <a href="<?php echo $linkcap;?>"><img src="assets/images/icon-game/capsa.png" width="130px"/></a>
                                        <div class="space_20"></div>
                                       <a href="<?php echo $linkcap;?>"><button type="submit" class="btn btn-submit">Capsa!</button></a>
                                    </div>
									<?php
									}
									?>
									</center>
								</div>

								<div style="display: inline-block;width: 100%;margin-top: 20px;">
									<center>
									<?php if ($infoweb["LPK"] == 1){
									?>
                                    <div class="left" style="margin-left:60px;padding: 5px;">
                                        <a href="<?php echo $linklpk;?>"><img src="assets/images/icon-game/live-poker.jpg" style="border-radius: 30px;" width="130px"/></a>
                                        <div class="space_20"></div>
                                        <a href="<?php echo $linklpk;?>"><button type="submit" class="btn btn-submit">Live Poker!</button></a>
                                    </div>
									<?php
									}
									?>
									<?php if ($infoweb["BTM"] == 1){
									?>
                                    <div class="left" style="margin-left:30px;padding: 5px;">
                                        <a href="<?php echo $linkbtm;?>"><img src="assets/images/icon-game/keliling.jpg" style="border-radius: 30px;" width="130px"/></a>
                                        <div class="space_20"></div>
										<a href="<?php echo $linkbtm;?>"><button type="submit" class="btn btn-submit">Ceme Keliling!</button></a>
                                    </div>
									<?php
									}
									?>
									<?php if ($infoweb["SPT"] == 1){
									?>
                                    <div class="left" style="margin-left:30px;padding: 5px;">
                                        <a href="<?php echo $linkspt;?>"><img src="assets/images/icon-game/super-ten.jpg" style="border-radius: 30px;" width="130px"/></a>
                                        <div class="space_20"></div>
										<a href="<?php echo $linkspt;?>"><button type="submit" class="btn btn-submit">Super Ten!</button></a>
                                    </div>
									<?php
									}
									if($login == 'QQKIOS'){
										// print_r( $infoweb);
									}
									?>
									</center>
								</div>
									
									<!-- <div style="margin-top:10px;width:100%;float:left;float:left;">
										<a href="<?php echo $url_lobby."/lobby.php?public={$publicKey}&data={$encodedData}&urlBack=$urlBack&key=$key&lang=id";?>" target="_lobby"><img src="assets/images/BUTTON-LOBBY-BARU2.png"></a>
									</div> -->
                                    
                                    <!--HISTORY-->
                                    <!--
                                    <div style="clear:both;"></div>
                                    <a href="history.php"><button type="submit" class="btn btn-submit">History</button></a>
									<span style="padding:0 5px;"></span>
                                    -->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="clear space_30"></div>
                    <div class="clear space_30"></div>
                </div>
            </div>

			<script>
				function OpenRoom(urltarget,TITLENAME,W,H,chip, minbuy) {
					if(chip < minbuy){
						alert("<?php echo P_NOTENO." ".P_CHIP;?>");
					}else{
					theURL=urltarget;
					wname=TITLENAME;
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
					var windowX = Math.ceil( (window.screen.width  - (windowW)) / 2 );
					var windowY = Math.ceil( (window.screen.height - (windowH)) / 2 );
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
				}
			</script>
            <?php
			include("footer.php");
			?>