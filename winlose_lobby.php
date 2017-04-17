<?php
$freePage = 1;
include("meta_lobby.php");


//INCLUDE MULTI LANGGUAGE
$lang="id";
include("lang_".$lang.".php");

$games = array();
$games["TXH"] = "Texas Poker";
$games["DMM"] = "Domino Q-Kick";
$games["EBN"] = "Bandar Ceme";
$games["BJK"] = "Blackjack";

$login = $_SESSION["login"];
?>
<script>
	function seeDepoWd(act, dateSee){
		displayLoading(1);
		$("#theCardX").load('lobby/ebn_cardpreview.php');
		$("#theView").load('lobby/viewDepoWd.php?act='+act+'&dateSee='+dateSee);
	}
	function seeTrans(dt, q){
		displayLoading(1);
		$("#theCardX").load('lobby/ebn_cardpreview.php');
		$("#theView").load('lobby/viewTrans.php?dt='+dt+'&q='+q);
	}
	function seeCard(card, prize){	
		//alert('lobby/txh_cardpreview.php?card='+card+'&prize='+prize);
		$("#theCardX").load('lobby/txh_cardpreview.php?card='+card+'&prize='+prize);
		window.location.href="#theCardX";
	}
	function seeCard2(per, rid, tab, dr){	
		//alert('lobby/dmm_cardpreview.php?per='+per+'&rid='+rid+'&tab='+tab+'&dr='+dr);
		$("#theCardX").load('lobby/dmm_cardpreview.php?per='+per+'&rid='+rid+'&tab='+tab+'&dr='+dr);
		window.location.href="#theCardX";
	}
	function seeCard3(per, rid, tab, dr){	
		//alert('lobby/ebn_cardpreview.php?per='+per+'&rid='+rid+'&tab='+tab+'&dr='+dr);
		$("#theCardX").load('lobby/ebn_cardpreview.php?per='+per+'&rid='+rid+'&tab='+tab+'&dr='+dr);
		window.location.href="#theCardX";
	}
	function seeCard4(per, rid, tab, dr){	
		//alert('lobby/ebn_cardpreview.php?per='+per+'&rid='+rid+'&tab='+tab+'&dr='+dr);
		$("#theCardX").load('lobby/bjk_cardpreview.php?per='+per+'&rid='+rid+'&tab='+tab+'&dr='+dr);
		window.location.href="#theCardX";
	}
	function displayLoading(avail){
		var myElements = document.getElementById("loading");
		var myElements2 = document.getElementById("theView");
		if(avail==1){
			myElements.style.display = "inline";
			myElements2.style.display = "none";
		}
		else{
			myElements.style.display = "none";
			myElements2.style.display = "inline";
		}
	}
</script>
<body style="font-family:Arial;font-size:14px;">
<link rel="stylesheet" type="text/css" href="lobby/css/style.css">

                <div class="container">
                    <div class="wrap">
                        <div class="full">
                            <div style="background:url(lobby/img/lobby_inside_header.png) no-repeat;width:980px;height:50px;margin-left:10px;border:none;">
                                <center><h1 class="participant-h" style="font-family:Helvetica,Roboto,Arial,sans-serif;font-size:33px;color:#b3b3b3;padding-top:7px;"><?php echo P_TRANSACTIONFOR." ".$login;?></h1></center>
                            </div>
                            
                            <div class="body-wrap text-justify" style="font-size:16px;" cellpadding="10">
                            	 <center>
								 <table width="600" border="1" align="center">
								 <tr align="center" style="background:#595552">
									<tD style='font-family:Arial;font-weight:bold;font-size:16px;height:25px;'><?php echo P_DAT;?></td>
									<tD style='font-family:Arial;font-weight:bold;font-size:16px;'><?php echo P_DEP;?></td>
									<tD style='font-family:Arial;font-weight:bold;font-size:16px;'><?php echo P_WIT;?></td>
									<tD style='font-family:Arial;font-weight:bold;font-size:16px;'><?php echo P_WINLOSE;?></td>
								</tr>
								 <?php
								$limitDay=14;
								$dateToday = date("Y-m-d");
								$lastDate = date("Y-m-d",strtotime(' -14 day'));
								$lastDate2 = $lastDate." 00:00:00";
								$theDeposit = array();
								$theWithdraw = array();
								$theWinlose = array();
								$theDateT = array();
								
								for($x=0;$x<$limitDay;$x++){
									$theDeposit[date("Y-m-d",strtotime(' -'.$x.' day'))] = 0;
									$theWithdraw[date("Y-m-d",strtotime(' -'.$x.' day'))] = 0;
									$theWinlose[date("Y-m-d",strtotime(' -'.$x.' day'))] = 0;
									$theDateT[date("Y-m-d",strtotime(' -'.$x.' day'))] = date("Y-m-d",strtotime(' -'.$x.' day'));
								}
	
								$sqlDepowd = "SELECT amount, act, date1 FROM a83adm_deposit WHERE userid='".$login."' AND date1>'".$lastDate2."' AND (status='ACCEPT' OR status='MANUAL')";																
								$q_1=sqlsrv_query($sqlconn,$sqlDepowd);
								while ($data = sqlsrv_fetch_array($q_1, SQLSRV_FETCH_ASSOC)){
									$daterx = date_format($data['date1'], 'Y-m-d');
									$daterx = substr($daterx,0,10);
									if($data["act"]==1) $theDeposit[$daterx] += $data["amount"];
									elseif($data["act"]==2) $theWithdraw[$daterx] += $data["amount"];
								}
								
								$sqlWinlose = "SELECT pdate, SUM(txhresult) as totalTXH, SUM(dmmresult) as totalDMM, SUM(ebnresult) as totalEBN, SUM(bjkresult) as totalBJK from ".$db2.".dbo.j2365join_transaction_old WHERE player='".$login ."' AND pdate>='".$lastDate2."' GROUP BY pdate";																
								$q_1=sqlsrv_query($sqlconn,$sqlWinlose);
								while ($data = sqlsrv_fetch_array($q_1, SQLSRV_FETCH_ASSOC)){
									$daterx = date_format($data['pdate'], 'Y-m-d');
									$daterx = substr($daterx,0,10);
									$theWinlose[$daterx] = ($data["totalTXH"]+$data["totalDMM"]+$data["totalEBN"]+$data["totalBJK"]);
								}
								$totalDepositx=0; $totalWithdrawx=0; $totalWinlosex=0;
								for($x=0;$x<$limitDay;$x++){
									$nowDate = date("Y-m-d",strtotime(' -'.$x.' day'));
									$totalDepositx += $theDeposit[$nowDate];
									$totalWithdrawx += $theWithdraw[$nowDate];
									$totalWinlosex += $theWinlose[$nowDate];
									 if($winLose[$nowDate]<0) $coloring="#fe727f"; else $coloring="#72febe";
									 
									?>
									 <tr align="center" style="padding-top:10px;background:black;border:1px solid #595552;">
										<tD style='font-family:Arial;font-weight:bold;font-size:16px;'><?php echo $theDateT[$nowDate];?></td>
										<tD style='font-family:Arial;font-weight:bold;font-size:16px;'><a onClick="seeDepoWd(1, '<?php echo $theDateT[$nowDate];?>')" style='font-size:16px;cursor:pointer;'><?php echo number_format($theDeposit[$nowDate]);?></a></td>
										<tD style='font-family:Arial;font-weight:bold;font-size:16px;'><a onClick="seeDepoWd(2, '<?php echo $theDateT[$nowDate];?>')" style='font-size:16px;cursor:pointer;'><?php echo number_format($theWithdraw[$nowDate]);?></a></td>
										<tD style='font-family:Arial;font-weight:bold;font-size:16px;color:<?php echo $coloring;?>'><a onClick="seeTrans(<?php echo $x;?>, 0)" style='font-size:16px;cursor:pointer'><?php echo number_format($theWinlose[$nowDate]);?></a></td>
									 </tr>
									<?php
								}
								?>  
								<tr align="center" style="padding-top:10px;background:black;border:1px solid #595552;">
									<tD style='font-family:Arial;font-weight:bold;font-size:16px;color:white;'><?php echo P_TOT;?>:</td>
									<tD style='font-family:Arial;font-weight:bold;font-size:16px;color:white;'><?php echo number_format($totalDepositx);?></td>
									<tD style='font-family:Arial;font-weight:bold;font-size:16px;color:white;'><?php echo number_format($totalWithdrawx);?></td>
									<tD style='font-family:Arial;font-weight:bold;font-size:16px;color:white;'><?php echo number_format($totalWinlosex);?></td>
								</tr>
								</table>
								<div style="margin-top:30px;"></div>
								<div id="loading" style="display:none;"><span style="font-weight:bold;">LOADING...</span></div>
								<div id="theView"></div>
								<div style="margin-top:20px;"></div>
								<div id="theCardX"></div>
								</center>
                            </div>
                            
                        </div>
                 		

                    <div class="clear space_30"></div>
                </div>
            </div>
	</body>
</html>