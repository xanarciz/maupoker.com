<?php
$freePage = 1;
include("meta.php");
include("header.php");
?>
			<div id="content">
                <div class="container">

                    <div class="clear space_30"></div>

                    <div class="wrap">
                        <div class="full">
                            <div class="head-wrap">
                                <h1>Jackpot</h1>
                            </div>

                            <div class="body-wrap text-justify">
                                <div class="tabs">
                                    <ul class="tab-links">
                                        <li class="active"><a href="#tab1">Texas Poker Jackpot</a></li>
                                        <li><a href="#tab2">Domino Jackpot</a></li>
                                        <li><a href="#tab3">Ceme Jackpot</a></li>
                                    </ul>

                                    <div class="tab-content">
                                        <div id="tab1" class="tab active">
                                            <div class="clear space_20"></div>
                                            <a href="#txh-jackpot" class="btn btn-login">Jackpot System</a>
                                            <a href="#txh-winner" class="btn btn-login">Jackpot Winner</a>
                                            <div class="clear space_20"></div>

                                            <div id="txh-jackpot">
                                                <p><b>Texas Poker Multi Jackpot System</b></p>
    											<p><h4>Kini Telah hadir Jackpot SUPER ROYAL FLUSH</h4></p> 
												<p><h4>Kini Telah hadir Jackpot 2000 (khusus table VIP keatas).</h4></p>
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

                                            <div id="txh-winner">
                                                <p><b>Texas Poker Jackpot Winner</b></p>
                                                <?php
    											echo "<center>
                                                        <table width='470' style='margin-top:20px;color:#fff;'>
                                                            <thead>
                                                                <tr><td colspan='6' align='center' style='font-weight:bold;color: #fff;'>TOP SUPER ROYAL FLUSH</td></tr>
                                                                <tr style='height:30px;'>
                                                                <td width='30' style='border-bottom:1px solid #fff;color: #fff;'>No.</td>
                                                                <td width='140' style='border-bottom:1px solid #fff;color: #fff;'>Tanggal</td>
                                                                <td width='140' style='border-bottom:1px solid #fff;color: #fff;'>Nama</td>
                                                                <td width='150' style='border-bottom:1px solid #fff;color: #fff;'>Price</td>
                                                                <td style='border-bottom:1px solid #fff;color: #fff;'>Win</td>
                                                            </tr>
                                                            </thead>
                                                            <tbody>";

    											$i = 1;
    											$SRFwinner = getFirst($infoweb['latestWinner']['POKER']['SRF'], 5);
    											foreach ($SRFwinner as $srfWinner){
                                                    echo    "<tr>
                                                                <td style='color: #fff;'>".($i++)."</td>
                                                                <td style='color: #fff;'>".date("d/m H:i", strtotime($srfWinner["TDate"]))."</td>
                                                                <td style='color: #fff;'>".$srfWinner["Userid"]."</td>
                                                                <td style='color: #fff;'>".$srfWinner["Ket"]."</td>
                                                                <td style='color: #fff;text-align: right;'>".number_format($srfWinner["Jackpot"])."</td>
                                                             </tr>";
                                                }

                                                echo    "</tbody>
                                                      </table>
                                                      <table width='470' style='margin-top:20px;'>
                                                            <thead>
                                                                <tr><td colspan='6' align='center' style='font-weight:bold;color: #fff;'>TOP ROYAL FLUSH</td></tr>
                                                                <tr style='height:30px;'>
                                                                    <td width='30' style='border-bottom:1px solid #fff;color: #fff;'>No.</td>
                                                                    <td width='140' style='border-bottom:1px solid #fff;color: #fff;'>Tanggal</td>
                                                                    <td width='140' style='border-bottom:1px solid #fff;color: #fff;'>Nama</td>
                                                                    <td width='150' style='border-bottom:1px solid #fff;color: #fff;'>Price</td>
                                                                    <td style='border-bottom:1px solid #fff;color: #fff;'>Win</td>
                                                                </tr>
                                                            </thead>
                                                            <tbody>";
                                                $i = 1;
                                                $RFwinner = getFirst($infoweb['latestWinner']['POKER']['RF'], 5);
                                                foreach ($RFwinner as $rfWinner){
                                                    echo    "<tr>
                                                                <td style='color: #fff;'>".($i++)."</td>
                                                                <td style='color: #fff;'>".date("d/m H:i", strtotime($rfWinner["TDate"]))."</td>
                                                                <td style='color: #fff;'>".$rfWinner["Userid"]."</td>
                                                                <td style='color: #fff;'>".$rfWinner["Ket"]."</td>
                                                                <td style='color: #fff;text-align: right;'>".number_format($rfWinner["Jackpot"])."</td>
                                                             </tr>";
                                                }

                                                echo    "</tbody>
                                                      </table>
                                                      <table width=470 style=margin-top:20px;>
                                                            <thead>
                                                                <tr><td colspan=6 align=center style='font-weight:bold;color: #fff;'>TOP STRAIGHT FLUSH</td></tr>
                                                                <tr style=height:30px;>
                                                                    <td width=30 style='border-bottom:1px solid #fff;color: #fff;'>No.</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Tanggal</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Nama</td>
                                                                    <td width=150 style='border-bottom:1px solid #fff;color: #fff;'>Price</td>
                                                                    <td style='border-bottom:1px solid #fff;color: #fff;'>Win</td>
                                                                </tr>
                                                            </thead>
                                                            <tbody>";
                                                $i = 1;
                                                $SFwinner = getFirst($infoweb['latestWinner']['POKER']['SF'], 5);
                                                foreach ($SFwinner as $sfWinner){
                                                    echo    "<tr>
                                                                <td style='color: #fff;'>".($i++)."</td>
                                                                <td style='color: #fff;'>".date("d/m H:i", strtotime($sfWinner["TDate"]))."</td>
                                                                <td style='color: #fff;'>".$sfWinner["Userid"]."</td>
                                                                <td style='color: #fff;'>".$sfWinner["Ket"]."</td>
                                                                <td style='color: #fff;text-align: right;'>".number_format($sfWinner["Jackpot"])."</td>
                                                             </tr>";
                                                }

                                                echo   "</tbody>
                                                      </table>
                                                      <table width=470 style=margin-top:20px;>
                                                            <thead>
                                                                <tr><td colspan=6 align=center style='font-weight:bold;color: #fff;'>LATEST JACKPOT</td></tr>
                                                                <tr style=height:30px;>
                                                                    <td width=30 style='border-bottom:1px solid #fff;color: #fff;'>No.</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Tanggal</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Nama</td>
                                                                    <td width=150 style='border-bottom:1px solid #fff;color: #fff;'>Price</td>
                                                                    <td style='border-bottom:1px solid #fff;color: #fff;'>Win</td>
                                                                </tr>
                                                            </thead>
                                                            <tbody>";
                                                $i = 1;
                                                $T15winner = $infoweb['latestWinner']['POKER']['T15'];
                                                foreach ($T15winner as $t15Winner){
                                                    echo    "<tr>
                                                                <td style='color: #fff;'>".($i++)."</td>
                                                                <td style='color: #fff;'>".date("d/m H:i", strtotime($t15Winner["TDate"]))."</td>
                                                                <td style='color: #fff;'>".$t15Winner["Userid"]."</td>
                                                                <td style='color: #fff;'>".$t15Winner["Ket"]."</td>
                                                                <td style='color: #fff;text-align: right;'>".number_format($t15Winner["Jackpot"])."</td>
                                                             </tr>";
                                                }
                            					?>
                                                        </tbody>
                                                    </table>
                                                </center>
                                            </div>
                                        </div>

                                        <div id="tab2" class="tab">
                                            <div class="clear space_20"></div>
                                            <a href="#dmm-jackpot" class="btn btn-login">Jackpot System</a>
                                            <a href="#dmm-winner" class="btn btn-login">Jackpot Winner</a>
                                            <div class="clear space_20"></div>

                                            <div id="dmm-jackpot">
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

                                            <div id="dmm-winner">
                                                <p><b>Domino Jackpot Winner</b></p>
                                                <?php
                                                echo "<center>
                                                        <table width=470 style=margin-top:20px;>
                                                            <thead>
                                                                <tr><td colspan=6 align=center style='font-weight:bold;color: #fff;'>TOP ENAM DEWA</td></tr>
                                                                <tr style=height:30px;>
                                                                    <td width=30 style='border-bottom:1px solid #fff;color: #fff;'>No.</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Tanggal</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Nama</td>
                                                                    <td width=150 style='border-bottom:1px solid #fff;color: #fff;'>Price</td>
                                                                    <td style='border-bottom:1px solid #fff;color: #fff;'>Win</td>
                                                                </tr>
                                                            </thead>
                                                            <tbody>";

                                                $i = 1;
                                                $DMEwinner = getFirst($infoweb['latestWinner']['DOMINO']['ME'], 5);
                                                foreach ($DMEwinner as $dmeWinner){
                                                    echo    "<tr>
                                                                <td style='color: #fff;'>".($i++)."</td>
                                                                <td style='color: #fff;'>".date("d/m H:i", strtotime($dmeWinner["TDate"]))."</td>
                                                                <td style='color: #fff;'>".$dmeWinner["Userid"]."</td>
                                                                <td style='color: #fff;'>".$dmeWinner["Ket"]."</td>
                                                                <td style='color: #fff;text-align: right;'>".number_format($dmeWinner["Jackpot"])."</td>
                                                             </tr>";
                                                }

                                                echo   "</tbody>
                                                      </table>
                                                      <table width=470 style=margin-top:20px;>
                                                          <thead>
                                                                <tr><td colspan=6 align=center style='font-weight:bold;color: #fff;'>TOP BALAK</td></tr>
                                                                <tr style=height:30px;>
                                                                    <td width=30 style='border-bottom:1px solid #fff;color: #fff;'>No.</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Tanggal</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Nama</td>
                                                                    <td width=150 style='border-bottom:1px solid #fff;color: #fff;'>Price</td>
                                                                    <td style='border-bottom:1px solid #fff;color: #fff;'>Win</td>
                                                                </tr>";

                                                $i = 1;
                                                $DBLwinner = getFirst($infoweb['latestWinner']['DOMINO']['BL'], 5);
                                                foreach ($DBLwinner as $dblWinner){
                                                    echo    "<tr>
                                                                <td style='color: #fff;'>".($i++)."</td>
                                                                <td style='color: #fff;'>".date("d/m H:i", strtotime($dblWinner["TDate"]))."</td>
                                                                <td style='color: #fff;'>".$dblWinner["Userid"]."</td>
                                                                <td style='color: #fff;'>".$dblWinner["Ket"]."</td>
                                                                <td style='color: #fff;text-align: right;'>".number_format($dblWinner["Jackpot"])."</td>
                                                             </tr>";
                                                }

                                                echo    "</tbody>
                                                      </table>
                                                      <table width=470 style=margin-top:20px;xmlns=\"http://www.w3.org/1999/html\">
                                                            <thead>
                                                                <tr><td colspan=6 align=center style='font-weight:bold;color: #fff;'>LATEST JACKPOT</td></tr>
                                                                <tr style=height:30px;>
                                                                    <td width=30 style='border-bottom:1px solid #fff;color: #fff;'>No.</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Tanggal</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Nama</td>
                                                                    <td width=150 style='border-bottom:1px solid #fff;color: #fff;'>Price</td>
                                                                    <td style='border-bottom:1px solid #fff;color: #fff;'>Win</td>
                                                                </tr>
                                                            </thead>
                                                            <tbody>";

                                                $i = 1;
                                                $DT15winner = $infoweb['latestWinner']['DOMINO']['T15'];
                                                foreach ($DT15winner as $dt15Winner){
                                                    echo    "<tr>
                                                                <td style='color: #fff;'>".($i++)."</td>
                                                                <td style='color: #fff;'>".date("d/m H:i", strtotime($dt15Winner["TDate"]))."</td>
                                                                <td style='color: #fff;'>".$dt15Winner["Userid"]."</td>
                                                                <td style='color: #fff;'>".$dt15Winner["Ket"]."</td>
                                                                <td style='color: #fff;text-align: right;'>".number_format($dt15Winner["Jackpot"])."</td>
                                                             </tr>";
                                                }
                								?>
                                                        </tbody>
                								    </table>
                                                </center>
                                            </div>
                                        </div>
                                        <div id="tab3" class="tab">
                                            <div class="clear space_20"></div>
                                            <a href="#dmm-jackpot" class="btn btn-login">Jackpot System</a>
                                            <a href="#dmm-winner" class="btn btn-login">Jackpot Winner</a>
                                            <div class="clear space_20"></div>

                                            <div id="dmm-jackpot">
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
                									<li>BALAK  x 200 harga jackpot yang anda beli
                										<ul	>(contoh:anda membeli 1000 maka:1000 X 200 = 200.000)</ul>
                									</li>
                									<li>ENAM DEWA x 6666	harga jackpot yang anda beli
                										<ul	>(contoh:anda membeli 1000 maka:1000 X 6666 = 6.666.000)</ul>
                									</li>
                								</ol>
                            					<p>Demikian adalah penjelasan dari Multi Jackpot <?php echo"".DOMAIN_NAME."";?> terima kasih dan selamat bermain salam hoki dari kami</p>
                                            </div>

                                            <div class="clear space_20"></div>

                                            <div id="dmm-winner">
                                                <p><b>Ceme Jackpot Winner</b></p>
                                                <?php
                                                echo "<center>
                                                        <table width=470 style=margin-top:20px;>
                                                            <thead>
                                                                <tr><td colspan=6 align=center style='font-weight:bold;color: #fff;'>TOP ENAM DEWA</td></tr>
                                                                <tr style=height:30px;>
                                                                    <td width=30 style='border-bottom:1px solid #fff;color: #fff;'>No.</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Tanggal</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Nama</td>
                                                                    <td width=150 style='border-bottom:1px solid #fff;color: #fff;'>Price</td>
                                                                    <td style='border-bottom:1px solid #fff;color: #fff;'>Win</td>
                                                                </tr>
                                                            </thead>
                                                            <tbody>";

                                                $i = 1;
                                                $CMEwinner = getFirst($infoweb['latestWinner']['CEME']['ME'], 5);
                                                foreach ($CMEwinner as $cmeWinner){
                                                    echo    "<tr>
                                                                <td style='color: #fff;'>".($i++)."</td>
                                                                <td style='color: #fff;'>".date("d/m H:i", strtotime($cmeWinner["TDate"]))."</td>
                                                                <td style='color: #fff;'>".$cmeWinner["Userid"]."</td>
                                                                <td style='color: #fff;'>".$cmeWinner["Ket"]."</td>
                                                                <td style='color: #fff;text-align: right;'>".number_format($cmeWinner["Jackpot"])."</td>
                                                             </tr>";
                                                }

                                                echo   "</tbody>
                                                      </table>
                                                      <table width=470 style=margin-top:20px;>
                                                          <thead>
                                                                <tr><td colspan=6 align=center style='font-weight:bold;color: #fff;'>TOP BALAK</td></tr>
                                                                <tr style=height:30px;>
                                                                    <td width=30 style='border-bottom:1px solid #fff;color: #fff;'>No.</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Tanggal</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Nama</td>
                                                                    <td width=150 style='border-bottom:1px solid #fff;color: #fff;'>Price</td>
                                                                    <td style='border-bottom:1px solid #fff;color: #fff;'>Win</td>
                                                                </tr>
                                                          </thead>
                                                          <tbody>";

                                                $i = 1;
                                                $CBLwinner = getFirst($infoweb['latestWinner']['CEME']['BL'], 5);
                                                foreach ($CBLwinner as $cblWinner){
                                                    echo    "<tr>
                                                                <td style='color: #fff;'>".($i++)."</td>
                                                                <td style='color: #fff;'>".date("d/m H:i", strtotime($cblWinner["TDate"]))."</td>
                                                                <td style='color: #fff;'>".$cblWinner["Userid"]."</td>
                                                                <td style='color: #fff;'>".$cblWinner["Ket"]."</td>
                                                                <td style='color: #fff;text-align: right;'>".number_format($cblWinner["Jackpot"])."</td>
                                                             </tr>";
                                                }

                                                echo    "</tbody>
                                                      </table>
                                                      <table width=470 style=margin-top:20px;xmlns=\"http://www.w3.org/1999/html\">
                                                          <thead>
                                                                <tr><td colspan=6 align=center style='font-weight:bold;color: #fff;'>LATEST JACKPOT</td></tr>
                                                                <tr style=height:30px;>
                                                                    <td width=30 style='border-bottom:1px solid #fff;color: #fff;'>No.</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Tanggal</td>
                                                                    <td width=140 style='border-bottom:1px solid #fff;color: #fff;'>Nama</td>
                                                                    <td width=150 style='border-bottom:1px solid #fff;color: #fff;'>Price</td>
                                                                    <td style='border-bottom:1px solid #fff;color: #fff;'>Win</td>
                                                               </tr>
                                                          </thead>
                                                          <tbody>";

                                                $i = 1;
                                                $CT15winner = $infoweb['latestWinner']['CEME']['T15'];
                                                foreach ($CT15winner as $ct15Winner){
                                                    echo    "<tr>
                                                                <td style='color: #fff;'>".($i++)."</td>
                                                                <td style='color: #fff;'>".date("d/m H:i", strtotime($ct15Winner["TDate"]))."</td>
                                                                <td style='color: #fff;'>".$ct15Winner["Userid"]."</td>
                                                                <td style='color: #fff;'>".$ct15Winner["Ket"]."</td>
                                                                <td style='color: #fff;text-align: right;'>".number_format($ct15Winner["Jackpot"])."</td>
                                                             </tr>";
                                                }
                								?>
                                                        </tbody>
                								    </table>
                                                </center>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="clear space_30"></div>
                </div>
            </div>
<?php
include("footer.php");
?>