<?php
include("meta.php");
include("header.php");
$key = $_SESSION["sess_key"];
$q_game = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select txh_status,dmm_status,ebn_status,bjk_status from u6048user_playeragent where userid = '".$agentwlable."'"),SQLSRV_FETCH_ASSOC);

$salt ='heilhitler';
$urlBack = $_SERVER['SERVER_NAME'];
?>

            <div id="content">
                <div class="container">

                    <div class="clear space_30"></div>

                    <div class="wrap">
                        <div class="full">
                            <div class="head-wrap">
                                <h1>Lobby</h1>

                                <div class="btn-top" style="padding-top:15px;">
									<?php	
									if($q_game["txh_status"] == 1){
									?>
                                    <a href="<?php echo $url_lobby."/lobby.php?user=$login&urlBack=$urlBack&key=$key";?>"><button type="submit" class="btn btn-submit">Poker!</button></a>
									<?php
									}
									?>
                                    <span style="padding:0 5px;"></span>
									<?php if ($q_game["dmm_status"] == 1){
									?>
                                    <a href="<?php echo $url_lobby."/lobby.php?user=$login&urlBack=$urlBack&key=$key";?>"><button type="submit" class="btn btn-submit">Domino!</button></a>
									<?php
									}
									?>
									<span style="padding:0 5px;"></span>
									<?php if ($q_game["ebn_status"] == 1){
									?>
                                    <a href="<?php echo $url_lobby."/lobby.php?user=$login&urlBack=$urlBack&key=$key";?>"><button type="submit" class="btn btn-submit">Ceme!</button></a>
									<?php
									}
									?>
                                    <span style="padding:0 5px;"></span>
									<?php if ($q_game["bjk_status"] == 1){
									?>
                                    <a href="<?php echo $url_lobby."/lobby.php?user=$login&urlBack=$urlBack&key=$key";?>"><button type="submit" class="btn btn-submit">Blackjack!</button></a>
									<?php
									}
									?>
									
                                </div>
                            </div>

                            <div class="body-wrap">
                                <div class="space_20"></div>

                                <div align="center">
									<?php	
									
									if($q_game["txh_status"] == 1){
									?>
                                    <div class="left" style="margin-left:5px;float:left;">
                                        <a href="<?php echo $url_lobby."/lobby.php?user=$login&urlBack=$urlBack&key=$key";?>"><img src="assets/images/icon-game-poker.png" width=220/></a>
                                        <div class="space_20"></div>
                                        <a href="<?php echo $url_lobby."/lobby.php?user=$login&urlBack=$urlBack&key=$key";?>"><button type="submit" class="btn btn-submit">Poker!</button></a>
                                    </div>
									<?php
									}
									?>
                           
									<?php if ($q_game["dmm_status"] == 1){
									?>
                                    <div class="left" style="margin-left:20px;float:left;">
                                        <a href="<?php echo $url_lobby."/lobby.php?user=$login&urlBack=$urlBack&key=$key";?>"><img src="assets/images/icon-game-domino.png" width=220/></a>
                                        <div class="space_20"></div>
                                        <a href="<?php echo $url_lobby."/lobby.php?user=$login&urlBack=$urlBack&key=$key";?>"><button type="submit" class="btn btn-submit">Domino!</button></a>
                                    </div>
									<?php
									}
									?>
									
									<?php if ($q_game["ebn_status"] == 1){
									?>
                                    <div class="left" style="margin-left:20px;float:left;">
                                        <a href="<?php echo $url_lobby."/lobby.php?user=$login&urlBack=$urlBack&key=$key";?>"><img src="assets/images/icon-game-ceme2.png" width=220/></a>
                                        <div class="space_20"></div>
                                        <a href="<?php echo $url_lobby."/lobby.php?user=$login&urlBack=$urlBack&key=$key";?>"><button type="submit" class="btn btn-submit">Ceme!</button></a>
                                    </div>
									<?php
									}
									?>
                                    
									<?php if ($q_game["bjk_status"] == 1){
									?>
                                    <div class="left" style="margin-left:20px;float:left;">
                                        <a href="<?php echo $url_lobby."/lobby.php?user=$login&urlBack=$urlBack&key=$key";?>"><img src="assets/images/icon-game-blackjack.png" width=220/></a>
                                        <div class="space_20"></div>
                                        <a href="<?php echo $url_lobby."/lobby.php?user=$login&urlBack=$urlBack&key=$key";?>"><button type="submit" class="btn btn-submit">Blackjack!</button></a>
                                    </div>
									<?php
									}
									?>
									<!-- <div style="margin-top:10px;width:100%;float:left;float:left;">
										<a href="<?php echo $url_lobby."/lobby.php?user=$login&urlBack=$urlBack&key=$key";?>" target="_lobby"><img src="assets/images/BUTTON-LOBBY-BARU2.png"></a>
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

            <?php
			include("footer.php");
			?>