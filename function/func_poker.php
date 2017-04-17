<?php
//$pokerhands = array ("nonpaying hand", "jacks or better", "two pair", "three of a kind", "straight", "flush", "full house", "four of a kind", "straight flush", "royal flush");
//$cardrank = array ("Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", 
//        "Queen", "King", "Ace");
//$cardsuit = array ("clubs", "diamonds", "hearts", "spades");
//$pay = array (0, 1, 2, 3, 4, 6, 9, 25, 50, 800);
//$kartu = array (13, 16, 30, 26, 11);
//cekkartu($kartu);
function cekkartu($kartu){
	$pokerhands = Array ("nonpaying hand", "jacks or better", "two pair", "three of a kind", "straight", "flush", "full house", "four of a kind", "straight flush", "royal flush");
		$cardarr = Array("c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "c9", "c10", "cj", "cq", "ck", "d1", "d2", "d3", "d4", "d5", "d6", "d7", 
        "d8", "d9", "d10", "dj", "dq", "dk", "h1", "h2", "h3", "h4", "h5", "h6", "h7", "h8", "h9", "h10", "hj", "hq", "hk", "s1", "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "s10", "sj", 
        "sq", "sk");
	//$phand[1] = 0;
	$phand[0] = 0;
	$flush = 0;
	$straight = 0;
	for($i=0;$i<10;$i++){
		$car[$i] = $cardarr[$kartu[$i]];
		$suit[$i] = substr($car[$i], 0,1);
		$rank[$i] = substr($car[$i], 1,2);
		if ($rank[$i] == "1") {
			$ranks[$i] =  14;
			$ranky[$i] =  14;
		}
		else if($rank[$i] == "j") {
			$ranks[$i] =  11;
			$ranky[$i] =  11;
		}
		else if($rank[$i] == "q") {
			$ranks[$i] =  12;
			$ranky[$i] =  12;
		}
		else if($rank[$i] == "k") {
			$ranks[$i] =  13;
			$ranky[$i] =  13;
		}
		else {
			$ranks[$i] =  $rank[$i]*1;
			$ranky[$i] =  $rank[$i]*1;
		}
	}
	rsort($ranks);
	for($j=0;$j<5;$j++){
		$x = $j+1;
		$xrank = $ranks[$j]-1;
		if ($suit[$j] == $suit[0]) {
			$isflush++;
			//$res = 5;
		}
		//echo "$xrank dan $ranks[$x] dan $ranks[$j]<BR>";
		if ($xrank == $ranks[$x]) {
			$isstraight++;
		}
		$kind[$rank[$j]] = $kind[$rank[$j]]+1;
		if ($kind[$rank[$j]] == 4) {
			$iskind = 4;
		}
		else if ($kind[$rank[$j]] == 3) {
			$iskind = 3;
		}
		else if ($kind[$rank[$j]] == 2) {
			$iskind = 2;
		}
		//$iskind = $kind[$rank[$j]];
		/*
		if ($kind[$rank[$j]] == 3) {
			$kinds[$rank[$j]] = 3;
			if ($kindy == $rank[$j]) {
				$kindy = 0;
			}
			$kindx = $rank[$j];
			echo "$kindy ex $kindx kindyx $rank[$j]<BR>";
		}else if ($kind[$rank[$j]] == 2){
			$kinda[$rank[$j]] = 2;
			$kindy = $rank[$j];
			echo "$kindy kindy<BR>";
		}
		*/
		if ($kind[$rank[$j]] == 2) {
			if ($pairx != $rank[$j]) {
				$pairx = $ranky[$j];
				$pair++;
			}
		}
		//echo "".$kind[$rank[$j]]." dan $rank[$j] kind<BR>";
		//if ($rank[$j])
	}
	//echo "$isflush dan $isstraight <BR>";
	//echo "$kinds[$kindx] dan $pairx full <BR>";
	if ($isflush == 5 && $isstraight == 4) {
		//$phand[1] = 1;
		//echo "$ranks[0]";
		if ($ranks[0] == 14) {
			$royalflush = 1;
			$phand[0] = 1;
		}
		else {
			$straightflush = 1;
			$phand[0] = 2;
		}
	}else if ($iskind == 4) {
		$fourofakind = 1;
		$phand[0] = 3;
	}else if ($pair == 2 &&  $iskind == 3) {
		$fullhouse = 1;
		$phand[0] = 4;
	}
	//else if ($kinds[$kindx] == 3 &&  $kinda[$kindy] == 2) {
	//	$fullhouse = 1;
	//}
	else if ($isflush == 5) {
		//$phand[1] = 1;
		$flush = 1;
		$phand[0] = 5;
	}else if ($isstraight == 4) {
		//$phand[1] = 1;
		$straight = 1;
		$phand[0] = 6;
	}else if ($iskind == 3) {
		$threeofakind = 1;
		$phand[0] = 7;
	}else if ($pair == 2) {
		$twopair = 1;
		$phand[0] = 8;
	}else if ($pair == 1) {
		if ($pairx >= 11) {
			$onepair = 1;
			$phand[0] = 9;
		}else {
			$none = 1;
		}
	}else{
		$none = 1;
		//echo "habis";
	}
	//echo "$royalflush royal<BR>";
	//echo "$straightflush sflush<BR>";
	//echo "$fourofakind fourkind<BR>";
	//echo "$fullhouse fhouse<BR>";
	//echo "$flush flush<BR>";
	//echo "$straight straight<BR>";
	//echo "$threeofakind threekind<BR>";
	//echo "$twopair two<BR>";
	//echo "$onepair pair<BR>";
	//echo "$none none<BR>";
/*
	$flush = isflush($totaljoker,$kartusort,$hand);
	$straight = isstraight($totaljoker,$kartusort,$hand);
	$straightflush = isstraightflush($totaljoker,$kartusort,$hand,$flush,$strait);
	$royalflush = isroyalflush($straightflush);

	$fourkind = isfourofakind($totaljoker,$kartusort,$hand);
	$twopair = istwopairall($totaljoker,$kartusort,$hand);
	$threekind = isthreeofakind($totaljoker,$kartusort,$hand);

$kartututupgb4 = isthreeofakindyy($totaljoker,$kartusort,$hand);
$kartututupgball = istwopairallyy($totaljoker,$kartusort,$hand);

$fullhouse = isfullhouse($totaljoker,$kartusort,$hand,$kartututupgb4,$kartututupgball,$twopair,$threekind);

$acepair = isacepair($totaljoker,$kartusort,$hand);
*/
	//$phand[2] = $ranky;
	return $phand;
}
/*
function isflush($totaljoker,$kartusort,$hand) {
	$retval = -1;
	$suit = -1;
	for ($j = 0; $j<4; $j++) {
		$counter = 0;
		$awal = 0;
		for ($i = 13; $i>0; $i--) {
			if ($hand[$i][$j] == 1 && $awal<5) {
				$kartutemp[$awal] = $i+($j*13);
				$awal++;
			}
			$counter = $counter+$hand[$i][$j];
		}
		if ($counter>=5-$totaljoker) {
			$selisih = ($counter+$totaljoker)-5;
			$awal -= $selisih;
			$suit = $j;
			$j = 4;
			$mulai = 0;
			for ($putar = 0; $putar<=6 && $mulai<2; $putar++) {
				$ada = 0;
				for ($gol = 0; $gol<5; $gol++) {
					if ($kartusort[$putar]>=52) {
						$ada = 1;
					}
					if ($kartutemp[$gol] == $kartusort[$putar]) {
						$ada = 1;
					}
				}
				if ($ada == 0) {
					$kartututupgb6[$mulai] = $kartusort[$putar];
					$mulai++;
				}
			}
		}
	}
	$retval = $suit;
	return $retval;
}

function isstraight($totaljoker,$kartusort,$hand) {
	$retval = -1;
	for ($i = 13; $i>=4; $i--) {
		$counter = 0;
		$tempjoker = $totaljoker;
		$awal = 0;
		for ($j = 0; $j<5; $j++) {
			$cardfound = false;
			for ($k = 0; $k<4 && !$cardfound; $k++) {
				if ($hand[$i-$j][$k] == 1) {
					$kartutemp[$awal] = ($i-$j)+($k*13);
					$awal++;
					$cardfound = true;
				}
			}
			if (!$cardfound && $tempjoker>0) {
				$cardfound = true;
				$tempjoker--;
			}
			if ($cardfound) {
				$counter++;
			}
		}//echo "temp".$kartutemp[$awal].",";
		//echo "<br>".$kartusort[0].",".$kartusort[1].",".$kartusort[2].",".$kartusort[3].",".$kartusort[4].",".$kartusort[5].",".$kartusort[6];
		if ($counter == 5) {
			$retval = $i;
			$i = 0;
			$mulai = 0;
			for ($putar = 0; $putar<=6 && $mulai<2; $putar++) {
				$ada = 0;
				for ($gol = 0; $gol<$awal; $gol++) {
					if ($kartusort[$putar]>=52) {
						$ada = 1;
					}
					if ($kartutemp[$gol] == $kartusort[$putar]) {
						$ada = 1;
					}
				}
				if ($ada == 0) {
					$kartututupgb5[$mulai] = $kartusort[$putar];
					//echo "herman".$kartututupgb5[$mulai].",";
					$mulai++;
				}
			}
		}
	}
	return $retval;
}

function isstraightflush($totaljoker,$kartusort,$hand,$flush,$strait) {
	$retval = -1;
	if ($flush == -1) {

		return -1;

	}
	if ($strait == -1) {
		return -1;
	}
	for ($j = 0; $j<4; $j++) {
		for ($i = 13; $i>0; $i--) {
			$counter = 0;
			$tempjoker = $totaljoker;
			$awal = 0;
			for ($k = 0; $k<5; $k++) {
				if (($hand[$i-$k][$j] == 1) || ($tempjoker>0)) {
					if ($hand[$i-$k][$j] != 1) {
						$tempjoker--;
					}
					if ($hand[$i-$k][$j] == 1 && $counter<4) {
						$kartutemp[$awal] = ($i-$k)+($j*13);
						$awal++;
				}
					$counter++;
				} else {
					$counter = 0;
					$k = 6;
				}
			}
			if ($counter == 5) {
			 $retval = $i;
				$i = -1;
				$j = 5;
				$mulai = 0;
				for ($putar = 0; $putar<=6 && $mulai<2; $putar++) {
					$ada = 0;
					for ($gol = 0; $gol<$awal; $gol++) {
						if ($kartusort[$putar]>=52) {
							$ada = 1;
						}
						if ($kartutemp[$gol] == $kartusort[$putar]) {
							$ada = 1;
						}
					}
					if ($ada == 0) {
						$kartututupgb9[$mulai] = $kartusort[$putar];
						
						$mulai++;
					}
				}
			}
		}
	}
	return $retval;
	
}

function isroyalflush($straightflush) {
	if ($straightflush == 13) {
		for ($mulai = 0; $mulai<2; $mulai++) {
			$kartututupgb11[$mulai] = $kartututupgb9[$mulai];
		}
		return 13;
	} else {
		return -1;
	}
}

function isfourofakind($totaljoker,$kartusort,$hand) {
	$retval = -1;
	$counter = 0;
	$tempjok = $totaljoker;
	$awal = 0;
	for ($i = 13; $i>=0; $i--) {
		$awal = 0;
		for ($j = 0; $j<4 && $counter<4; $j++) {
			if ($hand[$i][$j] == 1) {
				$kartutemp[$awal] = $i+($j*13);
				$awal++;
			}
			$counter = $counter+$hand[$i][$j];
		}
		if ($counter != 0 && $counter<4) {
			$selisih = 4-$counter;
			if ($selisih<=$tempjok) {
				$tempjok -= $selisih;
				$tempjokhouse = $tempjok;
				$counter = 4;
			}
		}
		if ($counter>=4) {
			$retval = $i;
			$i = 0;
			$mulai = 0;
			for ($putar = 0; $putar<=6 && $mulai<2; $putar++) {
				$ada = 0;
				for ($gol = 0; $gol<$awal; $gol++) {
					if ($kartusort[$putar]>=52) {
						$ada = 1;
					}
					if ($kartutemp[$gol] == $kartusort[$putar]) {
						$ada = 1;
					}
				}
				if ($ada == 0) {
					$kartututupgb8[$mulai] = $kartusort[$putar];
					$mulai++;
				}
			}
		}
		$counter = 0;
	}
	return $retval;
}


function istwopair($totaljoker,$kartusort,$hand) {
	$retval = -1;
	$retvalnew= Array();
	$pairsfound = 0;
	$tempjok = $totaljoker;
	$counter = 0;
	$awal = 0;
	$tempawal = $awal;

	for ($i = 13; $i>8; $i--) {
		for ($j=0; $j<4; $j++) {
			if ($hand[$i][$j] == 1) {
				$kartutemp[$awal] = $i+($j*13);

				$awal++;

				
			}
			
			$counter = $counter+$hand[$i][$j];
		}
		if ($counter != 0 && $counter<2 && $tempjok != 0) {
			$selisih = 2-$counter;
			if ($tempjok>=$selisih) {
				$counter = 2;
				$tempjok = $tempjok-$selisih;
			}
		}
		if ($counter>=2) {
			$retvalnew[$pairsfound] = $i;
			$pairsfound++;
		
			 if ($pairsfound == 2) {
				$i = 0;
			 
			} else if ($counter == 4) {
				$retvalnew[$pairsfound] = $i;
				$pairsfound = 2;
				$i = 0;
			}
			$tempawal = $awal;
		} else {
			$awal = $tempawal;
		}
		$counter = 0;
	}

	if($pairsfound == 1){

		for ($i = 8; $i>0; $i--) {
			for ($j=0; $j<4; $j++) {
				if ($hand[$i][$j] == 1) {
					$kartutemp[$awal] = $i+($j*13);

					$awal++;
				}
				$counter = $counter+$hand[$i][$j];
			}
			if ($counter != 0 && $counter<2 && $tempjok != 0) {
				$selisih = 2-$counter;
				if ($tempjok>=$selisih) {
					$counter = 2;
					$tempjok = $tempjok-$selisih;
				}
			}
			if ($counter>=2) {
				$retvalnew[$pairsfound] = $i;
				$pairsfound++;
			
				 if ($pairsfound == 2) {
					$i = 0;
				 
				} else if ($counter == 4) {
					$retvalnew[$pairsfound] = $i;
					$pairsfound = 2;
					$i = 0;
				}
				$tempawal = $awal;
			} else {
				$awal = $tempawal;
			}
			$counter = 0;
		}
	}
	if ($pairsfound>=2) {
		$retval = 1;
		$mulai = 0;
		for ($putar = 0; $putar<=6 && $mulai<2; $putar++) {
			$ada = 0;
			for ($gol = 0; $gol<$awal; $gol++) {
				if ($kartusort[$putar]>=52) {
					$ada = 1;
				}
				if ($kartutemp[$gol] == $kartusort[$putar]) {
					$ada = 1;
				}
			}
			if ($ada == 0) {
				$kartututupgb3[$mulai] = $kartusort[$putar];
				$mulai++;
			}
		}
	}
	
	return $retval;
}

function istwopairall($totaljoker,$kartusort,$hand) {
	$retval = -1;
	$pairsfound = 0;
	$tempjok = $tempjokhouse;
	$counter = 0;
	$awal = 0;
	$tempawal = $awal;
	$twopairall[0] = -1;
	$twopairall[1] = -1;
	for ($i = 12; $i>=0; $i--) {
			for ($j=0; $j<4; $j++) {
			if ($hand[$i][$j] == 1) {
				$kartutemp[$awal] = $i+($j*13);
				$awal++;
			}
			$counter = $counter+$hand[$i][$j];
		}
		if ($counter != 0 && $counter<2 && $tempjok != 0) {
			$selisih = 2-$counter;
			if ($tempjok>=$selisih) {
				$counter = 2;
				$tempjok = $tempjok-$selisih;
			}
		}
		if ($counter>=2) {
			$twopairall[$pairsfound] = $i;
			$pairsfound++;
			if ($pairsfound == 2) {
				$i = 0;
			} else if ($counter == 4) {
				$twopairall[$pairsfound] = $i;
				$pairsfound = 2;
				$i = 0;
			}
			$tempawal = $awal;
		} else {
			$awal = $tempawal;
		}
		$counter = 0;
	}
	if ($pairsfound>=2) {
		$retval = 1;
	}
	if ($pairsfound>=2) {
		$mulai = 0;
		for ($putar = 0; $putar<=6 && $mulai<2; $putar++) {

			$ada = 0;
			for ($gol = 0; $gol<$awal; $gol++) {
				if ($kartusort[$putar]>=52) {
					$ada = 1;
				}
				if ($kartutemp[$gol] == $kartusort[$putar]) {
					$ada = 1;
				}
			}
			if ($ada == 0) {
				$kartututupgball[$mulai] = $kartusort[$putar];
				$mulai++;
			}
		}
	}

	return $retval;
}

function isthreeofakind($totaljoker,$kartusort,$hand) {
	$retval = -1;
	$counter = 0;
	$tempjok = $totaljoker;
	$awal = 0;
	for ($i = 13; $i>=0; $i--) {
		$awal = 0;
		for ($j = 0; $j<4 && $counter<3; $j++) {
			if ($hand[$i][$j] == 1) {
				$kartutemp[$awal] = $i+($j*13);
				if ($i == 13)$kartutemp[$awal] -=13;
				$awal++;
			}
			$counter = $counter+$hand[$i][$j];
		}
		if ($counter != 0 && $counter<3) {
			$selisih = 3-$counter;
			if ($selisih<=$tempjok) {
				$tempjok -= $selisih;
				$tempjokhouse = $tempjok;
				$counter = 3;
			}
		}
		if ($counter>=3) {
			$retval = $i;
			$i = 0;
			$mulai = 0;
			for ($putar = 0; $putar<=6 && $mulai<2; $putar++) {
				$ada = 0;
				for ($gol = 0; $gol<5; $gol++) {
					if ($kartusort[$putar]>=52) {
						$ada = 1;
					}
					if ($kartutemp[$gol] == $kartusort[$putar]) {
						$ada = 1;
					}
				}
				if ($ada == 0) {
					$kartututupgb4[$mulai] = $kartusort[$putar];
					$mulai++;
					}
			}
		}
		$counter = 0;
	}

	return $retval;
}

function isfullhouse($totaljoker,$kartusort,$hand,$kartututupgb4,$kartututupgball,$twopairall,$threeofakind) {

	$fullhousex[0] = -1;
	$fullhousex[1] = -1;
	$fullhousex[0] = $threeofakind;
	if ($fullhousex[0] == -1) {
		return -1;
	}

	$kartututupgb7[0] = $kartututupgb4[0];
	$kartututupgb7[1] = $kartututupgb4[1];
	//echo $kartututupgb4[0];
	if ($twopairall == -1) {
		$fullhousex[0] = -1;
		return -1;
	}
	if ($twopairall != $fullhousex[0]) {
		if (($kartututupgball[0]%13 != $fullhousex[0]) && ($kartututupgball[1]%13 != $fullhousex[0])) {
			$kartututupgb7[0] = $kartututupgball[0];
			$kartututupgb7[1] = $kartututupgball[1];
		

		}
		$fullhousex[1] = $twopairall;
	} else if ($twopairall != $fullhousex[0]) {
		if (($kartututupgball[0]%13 != $fullhousex[0]) && ($kartututupgball[1]%13 != $fullhousex[0])) {
			$kartututupgb7[0] = $kartututupgball[0];
			$kartututupgb7[1] = $kartututupgball[1];
	
		}
		$fullhousex[1] = $twopairall;
	} else {
		$fullhousex[1] = -1;
	}
	//echo $kartututupgb7[0].",".$kartututupgb7[1]."gb";
		return $fullhousex[1];
}

function isacepair($totaljoker,$kartusort,$hand) {
	$retval = -1;
	for ($k=0; $k<4; $k++) {
		$m = $k+10;
		
		$counter = $totaljoker;
		$awal = 0;
		for ($j = 0; $j<4 && $counter<2; $j++) {
			echo "$counter co<BR>";
				if ($hand[$m][$j] == 1) {
				$kartutemp[$awal] = $j*$m;
				$awal++;
			}
			$counter = $counter+$hand[$m][$j];
		}
		if ($counter>=2) {
			$retval = $m;
			$i = 0;
			$mulai = 0;
			for ($putar = 0; $putar<=6 && $mulai<2; $putar++) {
				$ada = 0;
				for ($go = 0; $go<$awal; $go++) {
					if ($kartusort[$putar]>=52) {
						$ada = 1;
					}
					if ($kartutemp[$go] == $kartusort[$putar]) {
						$ada = 1;
					}
				}
				if ($ada == 0) {
					$kartututupgb2[$mulai] = $kartusort[$putar];
					$mulai++;
				}
			}
		}
	}
	return $retval;
}

//================================================================================================================

function isthreeofakindyy($totaljoker,$kartusort,$hand) {
	$retval = -1;
	$counter = 0;
	$tempjok = $totaljoker;
	$awal = 0;
	for ($i = 13; $i>=0; $i--) {
		$awal = 0;
		for ($j = 0; $j<4 && $counter<3; $j++) {
			if ($hand[$i][$j] == 1) {
				$kartutemp[$awal] = $i+($j*13);
				if ($i == 13)$kartutemp[$awal] -=13;
				$awal++;
			}
			$counter = $counter+$hand[$i][$j];
		}
		if ($counter != 0 && $counter<3) {
			$selisih = 3-$counter;
			if ($selisih<=$tempjok) {
				$tempjok -= $selisih;
				$tempjokhouse = $tempjok;
				$counter = 3;
			}
		}
		if ($counter>=3) {
			$retval = $i;
			$i = 0;
			$mulai = 0;
			$hit = 5;
			$hitkartu = ($hit - $totaljoker);
			for ($putar = 0; $putar<=6 && $mulai<2; $putar++) {
				$ada = 0;
				for ($gol = 0; $gol<$hitkartu; $gol++) {
					if ($kartusort[$putar]>=52) {
						$ada = 1;
					}
					if ($kartutemp[$gol] == $kartusort[$putar]) {
						$ada = 1;
					}
				}
				if ($ada == 0) {
					$kartututupgb4[$mulai] = $kartusort[$putar];
					$mulai++;
					}
			}
		}
		$counter = 0;
	}
	//echo "<br>";
	//echo $kartututupgb4[0].",".$kartututupgb4[1];
	return $kartututupgb4;
}

function istwopairallyy($totaljoker,$kartusort,$hand) {
	$retval = -1;
	$pairsfound = 0;
	$tempjok = $tempjokhouse;
	$counter = 0;
	$awal = 0;
	$tempawal = $awal;
	$twopairall[0] = -1;
	$twopairall[1] = -1;
	for ($i = 12; $i>=0; $i--) {
			for ($j=0; $j<4; $j++) {
			if ($hand[$i][$j] == 1) {
				$kartutemp[$awal] = $i+($j*13);
				$awal++;
			}
			$counter = $counter+$hand[$i][$j];
		}
		if ($counter != 0 && $counter<2 && $tempjok != 0) {
			$selisih = 2-$counter;
			if ($tempjok>=$selisih) {
				$counter = 2;
				$tempjok = $tempjok-$selisih;
			}
		}
		if ($counter>=2) {
			$twopairall[$pairsfound] = $i;
			$pairsfound++;
			if ($pairsfound == 2) {
				$i = 0;
			} else if ($counter == 4) {
				$twopairall[$pairsfound] = $i;
				$pairsfound = 2;
				$i = 0;
			}
			$tempawal = $awal;
		} else {
			$awal = $tempawal;
		}
		$counter = 0;
	}
	if ($pairsfound>=2) {
		$retval = 1;
	}
	if ($pairsfound>=2) {
		$mulai = 0;
		$hit = 5;
			$hitkartu = ($hit - $totaljoker);
			for ($putar = 0; $putar<=6 && $mulai<2; $putar++) {
				$ada = 0;
				for ($gol = 0; $gol<$hitkartu; $gol++) {
				if ($kartusort[$putar]>=52) {
					$ada = 1;
				}
				if ($kartutemp[$gol] == $kartusort[$putar]) {
					$ada = 1;
				}
			}
			if ($ada == 0) {
				$kartututupgball[$mulai] = $kartusort[$putar];
				$mulai++;
			}
		}
	}
	return $kartututupgball;
}

*/

function hitkartu($kartu, $hold){
	for ($i=0; $i<5; $i++){
		if ($hold[$i] == 0){
			$kart[$i] = mt_rand(0,51);
				for ($j=0; $j<5; $j++){
					if ($kart[$i] == $kartu[$j]){
						return hitkartu($kartu,$hold);
					}
				}
		}else{
			$kart[$i] = $kartu[$i];
		}
	}
	return $kart;
}

?>