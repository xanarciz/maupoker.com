<?php
include("meta.php");
include("header.php");
$q_game = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select txh_status,dmm_status from u6048user_playeragent where userid = '".$agentwlable."'"),SQLSRV_FETCH_ASSOC);

function generate_card_view_txh($card){
	$kartuarr = Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "j", "q", "k", "1");
	$suitarr = Array("d","h","s","c");
	$kart = explode(",",$card);
	
	$a = 1; 
	$result ="";
	while($a < count($kart)){
		$kartu = $kartuarr[$kart[$a]];
		$a = $a+1;
		$suit = $suitarr[$kart[$a]];
		$a++;
		if ($kartu == ""){
			//$gif = "back";
		}else {
			$gif = $suit.$kartu;
			$result .="<img src='images/card-txh/".$gif.".png'>&nbsp;";
		}
		
	}
	return $result;
}
function generate_card_view_dmm($card){
	$cardArray = Array(0,1,2,3,4,5,6,2,3,4,5,6,7,4,5,6,7,8,6,7,8,9,8,9,10,10,11,12,"X");
	$myCard = explode (";",$card);
	$result = "";
	if ($myCard[0])$result .= "<img src='images/card-dmm/".$myCard[0].".png'>";
	if ($myCard[1])$result .= "<img src='images/card-dmm/".$myCard[1].".png'>";
	if ($myCard[2])$result .= "<img src='images/card-dmm/".$myCard[2].".png'>";
	if ($myCard[3])$result .= "<img src='images/card-dmm/".$myCard[3].".png'>";
	
	return $result;
}

function generate_card_view_ebn($card){
	$cardArray = Array(0,1,2,3,4,5,6,2,3,4,5,6,7,4,5,6,7,8,6,7,8,9,8,9,10,10,11,12,"X");
	$myCard = explode (";",$card);
	$result = "";
	if ($myCard[0])$result .= "<img src='images/card-dmm/".$myCard[0].".png'>";
	if ($myCard[1])$result .= "<img src='images/card-dmm/".$myCard[1].".png'>";
	
	return $result;
}

?>

            <div id="content">
                <div class="container">

                    <div class="clear space_30"></div>

                    <div class="wrap">
                        <div class="full">
                            <div class="head-wrap">
                                <h1>History</h1>
                            </div>

                            <div class="body-wrap">
                                <div class="space_20"></div>
								<h4>10 Transaksi terakhir hari ini</h4>
								<?php
								
								$q = sqlsrv_query($sqlconn, 
								"SELECT * FROM (
									SELECT TOP 20 * FROM (
										SELECT TOP 20 * from (
											select Status, Win, Bet, Lose, v_bet, Card, Prize, TableNo, TDate, Periode, RoomId, Fee, Chip,gametype,userid from ".$db2.".dbo.t6413txh_transaction_old".(date("d") * 1)." WHERE UserId='".$login."'
											union all
											select Status, Win, Bet, Lose, v_bet, Card, Prize, TableNo, TDate, Periode, RoomId, Fee, Chip,gametype,userid from ".$db2.".dbo.d338dmm_transaction_old".(date("d") * 1)." WHERE UserId='".$login."'
											union all
											select Status, Win, Bet, Lose, v_bet, Card, Prize, TableNo, TDate, Periode, RoomId, Fee, Chip,gametype,userid from ".$db2.".dbo.e303ebn_transaction_old".(date("d") * 1)." WHERE UserId='".$login."'
										) as a order by TDate Desc
									) AS foo order by TDate asc
								) AS t ORDER BY t.TDate desc",$params,$options);
								if (sqlsrv_num_rows($q) > 0){
									echo "<table id='table-history' width=600><thead><tr><td width=35><h4>No.</h4></td><td width=120><h4>Time</h4></td><td><h4>Player Card</h4></td><td><h4>Winner Card</h4></td></tr><thead><tbody>";
									$no = 0;
									while ($r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC)){
										
										if ($periode != $r["Periode"]){
											$no++;
											$periode = $r["Periode"];
											$tableno = $r["TableNo"];
											$card = $r["Card"];
											$game = $r["gametype"];
											$date = $r["TDate"];
											if ($game=="TXH"){
												$q_txh = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select top 1 card from ".$db2.".dbo.t6413txh_transaction_old".(date("d") * 1)." where periode = '".$periode."' and tableno='".$tableno."' and status = 'Win' order by win desc"), SQLSRV_FETCH_ASSOC);
												echo "<tr><td><h4>$no</h4></td><td><h4>".date_format($date,"h:i:s")."</h4></td><td>".generate_card_view_txh($card)."</td><td>". generate_card_view_txh($q_txh["card"])."</td></tr>";
											}else if ($game == "DMM"){
												$q_txh = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select top 1 card from ".$db2.".dbo.d338dmm_transaction_old".(date("d") * 1)." where periode = '".$periode."' and tableno='".$tableno."' and status = 'Win' order by win desc"), SQLSRV_FETCH_ASSOC);
												echo "<tr><td><h4>$no</h4></td><td><h4>".date_format($date,"h:i:s")."</h4></td><td>".generate_card_view_dmm($card)."</td><td>". generate_card_view_dmm($q_txh["card"])."</td></tr>";
											}else if ($game == "EBN"){
												$q_txh = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select top 1 card from ".$db2.".dbo.e303ebn_transaction_old".(date("d") * 1)." where periode = '".$periode."' and tableno='".$tableno."' and status = 'Win' order by win desc"), SQLSRV_FETCH_ASSOC);
												echo "<tr><td><h4>$no</h4></td><td><h4>".date_format($date,"h:i:s")."</h4></td><td>".generate_card_view_ebn($card)."</td><td>". generate_card_view_ebn($q_txh["card"])."</td></tr>";
											}
										}
									}
									echo "</tbody></table>";
								}else{
									echo "Tidak ada transaksi";
								}
								?>
								
                            </div>
                        </div>
                    </div>

                    <div class="clear space_30"></div>
                    <div class="clear space_30"></div>
                </div>
            </div>

            <?php
			include("footer.php");
			?>