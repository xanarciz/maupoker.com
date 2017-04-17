<?php
$freePage = 1;
include("meta_lobby.php");
?>
<body>
<link rel="stylesheet" type="text/css" href="lobby/css/style.css">

                <div class="container">
                    <div class="wrap">
                        <div class="full">
                            <div style="background:url(lobby/img/lobby_inside_header.png) no-repeat;width:980px;height:50px;margin-left:10px;border:none;">
                                <center><h1 class="participant-h" style="font-family:Helvetica,Roboto,Arial,sans-serif;font-size:33px;color:#b3b3b3;padding-top:7px;">Jackpot</h1></center>
                            </div>

                            <div class="body-wrap text-justify">
                                <div class="tabs" style="">
                                    <ul class="tab-links" style="text-align:center;margin-top:20px;margin-bottom:7px;margin-left:30px;">
                                        <li style="text-align:center;" class="active"><a href="#tab1">TEXAS POKER JACKPOT</a></li>
                                        <li style="text-align:center;"><a href="#tab2" style="padding-left:45px;padding-right:60px;">DOMINO JACKPOT</a></li>
                                        <li style="text-align:center;"><a href="#tab3" style="padding-left:60px;padding-right:60px;">CEME JACKPOT</a></li>
                                    </ul>

                                    <div class="tab-content" style="background:#313131;">
                                        <div id="tab1" class="tab active">
                                            <div class="clear space_20"></div>
                                            <center style="margin-bottom:15px;">
                                            <a href="#txh-jackpot" class="jackpot_button">JACKPOT SYSTEM</a>
                                            <a href="#txh-winner" class="jackpot_button">JACKPOT WINNER</a>
                                            </center>
                                            <div class="clear space_20"></div>

                                            <div id="txh-jackpot" style="font-family:Arial;font-size:14px;">
                                                <p><b style="font-family:Arial;">Texas Poker Multi Jackpot System</b></p>
    											<p><h4 style="font-family:Arial;">Kini Telah hadir Jackpot SUPER ROYAL FLUSH</h4></p> 
												<p><h4 style="font-family:Arial;">Kini Telah hadir Jackpot 2000 (khusus table VIP keatas).</h4></p>
                                                <p>
                            					    Ikutilah global jackpot yang tersedia di system kami, dengan system jackpot terbaru dan pertama di indonesia, anda dapat membeli jackpot dengan harga 100 rupiah saja dan menangkan hadiahnya hingga puluhan juta rupiah.
                            					</p>
                                                <p>Jackpot bukanlah suatu keharusan untuk dibeli, namun kami memberikan suatu fitur tambahan untuk member tercinta dari <?php echo"".DOMAIN_NAME."";?>.</p>
                                            <p>Terdapat tiga pilihan harga jackpot yang bisa anda beli yaitu :100,500,1000 dan 2000(khusus table VIP Keatas) rupiah.</p>
                            					<p>Hadiah dari Multi jackpot system <?php echo"".DOMAIN_NAME."";?></p>
                            					<ol>
    												<li>full house   x 10 harga jackpot yang anda beli.
    													<ul	>(contoh:anda membeli 1000 maka:1000 X10 = 10.000)</ul>
    												</li>
    												<li>four of kind   x 250 harga jackpot yang anda beli
    													<ul	>(contoh:anda membeli 1000 maka:1000 X250 = 250.000)</ul>
    												</li>
    												<li>Straight flush  x 1200
    													<ul	>(contoh:anda membeli 1000 maka:1000 X1200 = 1.200.000)</ul>
    												</li>
    												<li>Royal flush   x  10000	harga jackpot yang anda beli
    													<ul	>(contoh:anda membeli 1000 maka:1000 X10000 = 10.000.000)</ul>
    												</li>
    												<li>SUPER ROYAL FLUSH   x  30000	harga jackpot yang anda beli
    													<ul	>(contoh:anda membeli 1000 maka:1000 X30000 = 30.000.000)</ul>
    												</li>
    											</ol>
                            					<p>Kondisi kartu</p>
                            					<ol>
                            					    <li>full house adalah kondisi kartu dimana kartu anda dan kartu tengah dengan total 7 kartu bisa mendapatkan nilai 5 kartu dengan kombinasi 1 tris(three of kind) dan 1 pair, contoh 3 kartu 10 dan 2 kartu 5</li>
                            					    <li>Four of kind adalah kondisi kartu dimana kartu anda dan kartu tengah dengan total 7 kartu bisa mendapatkan nilai 5 kartu dengan kombinasi 4 kartu yang sama jumlah dan 1 kartu apapun juga contoh anda mendapatkan 4 buah kartu angka 3 dan 1 kartu apapun.</li>
                            					    <li>Staright flush adalah kondisi kartu dimana kartu anda dan kartu tengah dengan total 7 kartu bisa mendapatkan nilai 5 kartu dengan kombinasi seri / staright dengan kembang yang sama contoh : urutan kartu dari angka 5, 6, 7, 8 , 9 10 dengan kembang yg sama misalnya as hati</li>
                            					    <li>Royal flush adalah kondisi kartu dimana kartu anda dan kartu tengah dengan total 7 kartu bisa mendapatkan nilai 5 kartu dengan kombinasi seri / staright dengan kembang yang sama tetapi kartu tersebut haruslah dimulai dari 10. contoh 10, Queen, Jack, King dan aces dengan kembang yang sama</li>
    												<li>Super Royal flush adalah kondisi kartu dimana Kedua kartu anda digabung dengan 3 kartu pertama meja haruslah royal flush. contoh kartu anda 10,Queen kembang sama dan 3 kartu pertama meja adalah Jack, King dan aces dengan kembang yang sama</li>
    											</ol>
                            					<p>Demikian adalah penjelasan dari Multi Jackpot <?php echo"".DOMAIN_NAME."";?> terima kasih dan selamat bermain salam hoki dari kami</p>
                                            </div>

                                            <div class="clear space_20"></div>

                                            <div id="txh-winner" style="font-family:Arial;font-size:14px;font-weight:bold;">
                                                <p><b>Texas Poker Jackpot Winner</b></p>
                                                <?php
    											$q = sqlsrv_query($sqlconn,"SELECT top 5 * from t6413txh_globaljackpothis where ket='Super Royal Flush' order by TDate desc",$params,$options);
    											echo "<center><table width=470 style=margin-top:20px;font-family:Arial><tr style='font-family:Arial'><td colspan=6 align=center style=font-weight:bold;font-family:Arial;>TOP SUPER ROYAL FLUSH</td></tr><tr style=height:30px;font-family:Arial;><td width=30 style='border-bottom:1px solid #fff;font-family:Arial;'>No.</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Tanggal</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Nama</td><td width=150 style='border-bottom:1px solid #fff;font-family:Arial;'>Price</td><td style='border-bottom:1px solid #fff;font-family:Arial;'>Win</td></tr>";
    											for ($i=0;$i<sqlsrv_num_rows($q); $i++){
    												$r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
    												echo "<tr><td style='font-family:Arial;'>".($i+1)."</td><td style='font-family:Arial;'>".date_format($r["TDate"],"d/m H:i")."</td><td style='font-family:Arial'>".strtoupper($r["Userid"])."</td><td style='font-family:Arial;'>".strtoupper($r["Ket"])."</td><td style='font-family:Arial;'>".number_format($r["Jackpot"])."</td></tr>";
    											}
                            					$q = sqlsrv_query($sqlconn,"SELECT top 5 * from t6413txh_globaljackpothis where ket='Royal Flush' order by TDate desc",$params,$options);
                            					echo "<center><table width=470 style=margin-top:20px;><tr><td colspan=6 align=center style=font-weight:bold;font-family:Arial;>TOP ROYAL FLUSH</td></tr><tr style=height:30px;font-family:Arial;><td width=30 style='border-bottom:1px solid #fff;font-family:Arial;'>No.</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Tanggal</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Nama</td><td width=150 style='border-bottom:1px solid #fff;font-family:Arial;'>Price</td><td style='border-bottom:1px solid #fff;font-family:Arial;'>Win</td></tr>";
                            					for ($i=0;$i<sqlsrv_num_rows($q); $i++){
                            						$r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
                            						echo "<tr><td style='font-family:Arial;'>".($i+1)."</td><td style='font-family:Arial;'>".date_format($r["TDate"],"d/m H:i")."</td><td style='font-family:Arial'>".strtoupper($r["Userid"])."</td><td style='font-family:Arial;'>".strtoupper($r["Ket"])."</td><td style='font-family:Arial;'>".number_format($r["Jackpot"])."</td></tr>";
                            					}
                            					$q = sqlsrv_query($sqlconn,"SELECT top 5 * from t6413txh_globaljackpothis where ket='Straight Flush' order by TDate desc",$params,$options);
                            					echo "<center><table width=470 style=margin-top:20px;><tr><td colspan=6 align=center style=font-weight:bold;font-family:Arial;>TOP STRAIGHT FLUSH</td></tr><tr style=height:30px;><td width=30 style='border-bottom:1px solid #fff;font-family:Arial;'>No.</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Tanggal</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Nama</td><td width=150 style='border-bottom:1px solid #fff;font-family:Arial;'>Price</td><td style='border-bottom:1px solid #fff;font-family:Arial;'>Win</td></tr>";
                            					for ($i=0;$i<sqlsrv_num_rows($q); $i++){
                            						$r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
                            						echo "<tr><td>".($i+1)."</td><td>".date_format($r["TDate"],"d/m H:i")."</td><td style='font-family:Arial'>".strtoupper($r["Userid"])."</td><td style='font-family:Arial;'>".strtoupper($r["Ket"])."</td><td style='font-family:Arial;'>".number_format($r["Jackpot"])."</td></tr>";
                            					}

                            					echo "</table>";
                            					$q = sqlsrv_query($sqlconn,"SELECT top 50 * from t6413txh_globaljackpothis order by TDate desc",$params,$options);
                            					echo "<center><table width=470 style=margin-top:20px;><tr><td colspan=6 align=center style=font-weight:bold;font-family:Arial>LATEST JACKPOT</td></tr><tr style=height:30px;><td width=30 style='border-bottom:1px solid #fff;font-family:Arial;'>No.</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Tanggal</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial'>Nama</td><td width=150 style='border-bottom:1px solid #fff;font-family:Arial;'>Price</td><td style='border-bottom:1px solid #fff;font-family:Arial;'>Win</td></tr>";
                            					for ($i=0;$i<sqlsrv_num_rows($q); $i++){
                            						$r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
                            						echo "<tr><td style='font-family:Arial;'>".($i+1)."</td><td style='font-family:Arial;'>".date_format($r["TDate"],"d/m H:i")."</td><td style='font-family:Arial'>".strtoupper($r["Userid"])."</td><td style='font-family:Arial;'>".strtoupper($r["Ket"])."</td><td style='font-family:Arial;'>".number_format($r["Jackpot"])."</td></tr>";
                            					}
                            					?>
                                                </table></center>
                                            </div>
                                        </div>

                                        <div id="tab2" class="tab">
                                            <div class="clear space_20"></div>
                                            <center style="margin-bottom:15px;">
                                            <a href="#dmm-jackpot" class="jackpot_button">JACKPOT SYSTEM</a>
                                            <a href="#dmm-winner" class="jackpot_button">JACKPOT WINNER</a>
                                            </center>
                                            <div class="clear space_20"></div>

                                            <div id="dmm-jackpot" style="font-family:Arial;font-size:14px;">
                                                <p><b>Domino Multi Jackpot System</b></p>
                                                <p>
                            					    Ikutilah global jackpot yang tersedia di system kami, dengan system jackpot terbaru dan pertama di indonesia, anda dapat membeli jackpot dengan harga 100 rupiah saja dan menangkan hadiahnya hingga puluhan juta rupiah.
                            					</p>
                                                <p>Jackpot bukanlah suatu keharusan untuk dibeli, namun kami memberikan suatu fitur tambahan untuk member tercinta dari <?php echo"".DOMAIN_NAME."";?>.</p>
    								            <p>Terdapat tiga pilihan harga jackpot yang bisa anda beli yaitu :100,500 dan 1000 rupiah.</p>
    								            <p>Hadiah dari Multi jackpot system <?php echo"".DOMAIN_NAME."";?></p>
                            					<ol>
                									<li>Murni Kecil   x 50 harga jackpot yang anda beli.
                										<ul	>(contoh:anda membeli 1000 maka:1000 X 50 = 50.000)</ul>
                									</li>
                									<li>Murni Besar   x 50 harga jackpot yang anda beli
                										<ul	>(contoh:anda membeli 1000 maka:1000 X 50 = 50.000)</ul>
                									</li>
                									<li>BALAK  x 100 harga jackpot yang anda beli
                										<ul	>(contoh:anda membeli 1000 maka:1000 X 100 = 100.000)</ul>
                									</li>
                									<li>ENAM DEWA x 6666	harga jackpot yang anda beli
                										<ul	>(contoh:anda membeli 1000 maka:1000 X 6666 = 6.666.000)</ul>
                									</li>
                								</ol>
                            					<p>Demikian adalah penjelasan dari Multi Jackpot <?php echo"".DOMAIN_NAME."";?> terima kasih dan selamat bermain salam hoki dari kami</p>
                                            </div>

                                            <div class="clear space_20"></div>

                                            <div id="dmm-winner" style="font-family:Helvetica, sans-serif;font-size:14px;font-weight:bold;">
                                                <p><b>Domino Jackpot Winner</b></p>
                                                <?php
                								$q = sqlsrv_query($sqlconn,"SELECT top 5 * from d338dmm_jackpothis where ket='murni_enam' order by TDate desc",$params,$options);
                								echo "<center><table width=470 style=margin-top:20px;><tr><td colspan=6 align=center style=font-weight:bold;font-family:Arial;>TOP ENAM DEWA</td></tr><tr style=height:30px;><td width=30 style='border-bottom:1px solid #fff;font-family:Arial;'>No.</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Tanggal</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Nama</td><td width=150 style='border-bottom:1px solid #fff;font-family:Arial;'>Price</td><td style='border-bottom:1px solid #fff;font-family:Arial;'>Win</td></tr>";
                								for ($i=0;$i<sqlsrv_num_rows($q); $i++){
                									$r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
                									echo "<tr><td style='font-family:Arial;'>".($i+1)."</td><td style='font-family:Arial;'>".date_format($r["TDate"],"d/m H:i")."</td><td style='font-family:Arial;'>".strtoupper($r["Userid"])."</td><td style='font-family:Arial;'>".str_replace("_"," ",strtoupper($r["Ket"]))."</td><td style='font-family:Arial;'>".number_format($r["Jackpot"])."</td></tr>";
                								}
                								$q = sqlsrv_query($sqlconn,"SELECT top 5 * from d338dmm_jackpothis where ket='balak' order by TDate desc",$params,$options);
                								echo "<center><table width=470 style=margin-top:20px;><tr><td colspan=6 align=center style=font-weight:bold;font-family:Arial;>TOP BALAK</td></tr><tr style=height:30px;><td width=30 style='border-bottom:1px solid #fff;font-family:Arial;'>No.</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Tanggal</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Nama</td><td width=150 style='border-bottom:1px solid #fff;font-family:Arial;'>Price</td><td style='border-bottom:1px solid #fff;font-family:Arial;'>Win</td></tr>";
                								for ($i=0;$i<sqlsrv_num_rows($q); $i++){
                									$r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
                									echo "<tr><td syle='font-family:Arial;'>".($i+1)."</td><td style='font-family:Arial;'>".date_format($r["TDate"],"d/m H:i")."</td><td style='font-family:Arial;'>".strtoupper($r["Userid"])."</td><td style='font-family:Arial;'>".str_replace("_"," ",strtoupper($r["Ket"]))."</td><td style='font-family:Arial;'>".number_format($r["Jackpot"])."</td></tr>";
                								}

                								echo "</table>";
                								$q = sqlsrv_query($sqlconn,"SELECT top 50 * from d338dmm_jackpothis order by TDate desc",$params,$options);
                								echo "<center><table width=470 style=margin-top:20px;><tr><td colspan=6 align=center style=font-weight:bold;font-family:Arial;>LATEST JACKPOT</td></tr><tr style=height:30px;font-family:Arial;><td width=30 style='border-bottom:1px solid #fff;font-family:Arial;'>No.</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Tanggal</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Nama</td><td width=150 style='border-bottom:1px solid #fff;font-family:Arial;'>Price</td><td style='border-bottom:1px solid #fff;font-family:Arial;'>Win</td></tr>";
                								for ($i=0;$i<sqlsrv_num_rows($q); $i++){
                									$r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
                									echo "<tr><td style='font-family:Arial;'>".($i+1)."</td><td style='font-family:Arial;'>".date_format($r["TDate"],"d/m H:i")."</td><td style='font-family:Arial;'>".strtoupper($r["Userid"])."</td><td style='font-family:Arial;'>".str_replace("_"," ",strtoupper($r["Ket"]))."</td><td style='font-family:Arial;'>".number_format($r["Jackpot"])."</td></tr>";
                								}
                								?>
                								</table></center>
                                            </div>
                                        </div>
                                        <div id="tab3" class="tab">
                                            <div class="clear space_20"></div>
                                            <center style="margin-bottom:15px;">
                                            <a href="#ebn-jackpot" class="jackpot_button">JACKPOT SYSTEM</a>
                                            <a href="#ebn-winner" class="jackpot_button">JACKPOT WINNER</a>
                                            </center>
                                            <div class="clear space_20"></div>

                                            <div id="ebn-jackpot" style="font-family:Arial;font-size:14px;">
                                                <p><b>Ceme Multi Jackpot System</b></p>
                                             
                                                <p>Jackpot dilihat dari gabungan kartu pemain dengan kartu bandar. Bandar harus membeli jackpot sebanyak jumlah player yang sedang duduk. Sebagai contoh bila terdapat 3 pemain duduk bermain, dan bandar memutuskan untuk membeli jackpot Rp 1.000, maka pada periode tersebut bandar akan membeli jackpot sebanyak 3xRp1.000 = Rp3.000.</p>
                                                <p>Jackpot bukanlah suatu keharusan untuk dibeli, namun kami memberikan suatu fitur tambahan untuk member tercinta dari <?php echo"".DOMAIN_NAME."";?>.</p>
    								            <p>Terdapat tiga pilihan harga jackpot yang bisa anda beli yaitu :100,500 dan 1000 rupiah.</p>
    								            <p>Hadiah dari Multi jackpot system <?php echo"".DOMAIN_NAME."";?></p>
                            					<ol>
                									<li>Murni Kecil   x 50 harga jackpot yang anda beli.
                										<ul	>(contoh:anda membeli 1000 maka:1000 X 50 = 50.000)</ul>
                									</li>
                									<li>Murni Besar   x 50 harga jackpot yang anda beli
                										<ul	>(contoh:anda membeli 1000 maka:1000 X 50 = 50.000)</ul>
                									</li>
                									<li>BALAK  x 100 harga jackpot yang anda beli
                										<ul	>(contoh:anda membeli 1000 maka:1000 X 100 = 100.000)</ul>
                									</li>
                									<li>ENAM DEWA x 6666	harga jackpot yang anda beli
                										<ul	>(contoh:anda membeli 1000 maka:1000 X 6666 = 6.666.000)</ul>
                									</li>
                								</ol>
                            					<p>Demikian adalah penjelasan dari Multi Jackpot <?php echo"".DOMAIN_NAME."";?> terima kasih dan selamat bermain salam hoki dari kami</p>
                                            </div>

                                            <div class="clear space_20"></div>

                                            <div id="ebn-winner" style="font-family:Helvetica, sans-serif;font-size:14px;font-weight:bold;">
                                                <p><b>Ceme Jackpot Winner</b></p>
                                                <?php
                								$q = sqlsrv_query($sqlconn,"SELECT top 5 * from e303ebn_jackpothis where ket='murni_enam' order by TDate desc",$params,$options);
                								echo "<center><table width=470 style=margin-top:20px;><tr><td colspan=6 align=center style=font-weight:bold;font-family:Arial;>TOP ENAM DEWA</td></tr><tr style=height:30px;><td width=30 style='border-bottom:1px solid #fff;font-family:Arial;'>No.</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Tanggal</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Nama</td><td width=150 style='border-bottom:1px solid #fff;font-family:Arial;'>Price</td><td style='border-bottom:1px solid #fff;font-family:Arial;'>Win</td></tr>";
                								for ($i=0;$i<sqlsrv_num_rows($q); $i++){
                									$r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
                									echo "<tr><td style='font-family:Arial;'>".($i+1)."</td><td style='font-family:Arial;'>".date_format($r["TDate"],"d/m H:i")."</td><td style='font-family:Arial;'>".$r["Userid"]."</td><td style='font-family:Arial;'>".str_replace("_"," ",strtoupper($r["Ket"]))."</td><td style='font-family:Arial;'>".number_format($r["Jackpot"])."</td></tr>";
                								}
                								$q = sqlsrv_query($sqlconn,"SELECT top 5 * from e303ebn_jackpothis where ket='balak' order by TDate desc",$params,$options);
                								echo "<center><table width=470 style=margin-top:20px;><tr><td colspan=6 align=center style=font-weight:bold;font-family:Arial;>TOP BALAK</td></tr><tr style=height:30px;><td width=30 style='border-bottom:1px solid #fff;font-family:Arial;'>No.</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Tanggal</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Nama</td><td width=150 style='border-bottom:1px solid #fff;font-family:Arial;'>Price</td><td style='border-bottom:1px solid #fff;font-family:Arial;'>Win</td></tr>";
                								for ($i=0;$i<sqlsrv_num_rows($q); $i++){
                									$r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
                									echo "<tr><td style='font-family:Arial;'>".($i+1)."</td><td style='font-family:Arial;'>".date_format($r["TDate"],"d/m H:i")."</td><td style='font-family:Arial;'>".strtoupper($r["Userid"])."</td><td style='font-family:Arial;'>".str_replace("_"," ",strtoupper($r["Ket"]))."</td><td style='font-family:Arial;'>".number_format($r["Jackpot"])."</td></tr>";
                								}

                								echo "</table>";
                								$q = sqlsrv_query($sqlconn,"SELECT top 50 * from e303ebn_jackpothis order by TDate desc",$params,$options);
                								echo "<center><table width=470 style=margin-top:20px;><tr><td colspan=6 align=center style=font-weight:bold;font-family:Arial;>LATEST JACKPOT</td></tr><tr style=height:30px;><td width=30 style='border-bottom:1px solid #fff;font-family:Arial;'>No.</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Tanggal</td><td width=140 style='border-bottom:1px solid #fff;font-family:Arial;'>Nama</td><td width=150 style='border-bottom:1px solid #fff;font-family:Arial;'>Price</td><td style='border-bottom:1px solid #fff;font-family:Arial;'>Win</td></tr>";
                								for ($i=0;$i<sqlsrv_num_rows($q); $i++){
                									$r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
                									echo "<tr><td style='font-family:Arial;'>".($i+1)."</td><td style='font-family:Arial;'>".date_format($r["TDate"],"d/m H:i")."</td><td style='font-family:Arial;'>".strtoupper($r["Userid"])."</td><td style='font-family:Arial;'>".str_replace("_"," ",strtoupper($r["Ket"]))."</td><td style='font-family:Arial;'>".number_format($r["Jackpot"])."</td></tr>";
                								}
                								?>
                								</table></center>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    <div class="clear space_30"></div>
                </div>
            </div>
</body>
</html>