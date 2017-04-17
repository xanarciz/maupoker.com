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
                                <h1>Poker Versi Android</h1>
                            </div>

                            <div class="body-wrap text-justify">
                                <div class="tabs">
                                    <ul class="tab-links">
                                        <li class="active"><a href="#tab1">Poker Android</a></li>
                                        <!-- <li><a href="#tab2">Panduan Instalasi</a></li> -->
                                    </ul>

                                    <?php
                  					    $filen = "poker.apk";
										//$filen = "";
                  					    $fsize = round((filesize($filen) / 1024000), 2);
                  					?>

                                    <div class="tab-content">
                                        <div id="tab1" class="tab active">
                                            <div align="center">
                                                <a href="http://www.txpkr.com"><img src="assets/images/android-image.jpg" /></a>
                                            </div>

                                            <div style="height:20px;"></div>

                                            <h4>Petunjuk Instalasi</h4>
                                            <div style="height:5px;"></div>
                            				<ol>
                            					<li>Download file <a href="http://www.txpkr.com/"><?php echo"".$filen."";?>(Size <?php echo"".$filen."";?>)</a></li>
                            					<li>Setelah selesai download (hasil download harus sama ukuran dengan info filenya), lalu buka Folder My File &gt; All File &gt; Download dan jalankan file <?php echo"".$filen."";?>.
                                                    <br />
                                                    NB: Jika anda tidak bisa melakukan installasi, masuk ke Setting &gt; Security , dan aktifkan Unknown Sources.
                                                </li>
                            					<li>Setelah instalasi, Anda langsung dapat memainkan game poker ini.</li>
                            					<li>Untuk tampilan terbaik, disarankan menggunakan layar berukuran minimal 4 inci.</li>
                            				</ol>
                                        </div>

                                        <!-- <div id="tab2" class="tab">
                                            <h4>Panduan Install Game Poker Versi Android</h4>
                                            <div style="height:5px;"></div>
                            				<ol>
                            					<li>Install Adobe Air
                                                    <div style="margin-left:20px;">
                                                        1a. Buka Play Store
                                                        <br />
                                                        <img src="assets/images/playstore.png" alt="play store" />

                                                        <div style="height:10px;"></div>

                                                        1b. Cari Adobe Air dan tap
                                                        <br />
                                                        Jika muncul gambar seperti dibawah ini berarti Adobe Air sudah terinstall dan lanjutkan proses 2
                                                        <br />
                                                        <img src="assets/images/adobeair3.jpg" alt="adobe air Poker Android" />
                                                        <br />
                                                        akan tetapi jika muncul seperti dibawah ini lanjutkan proses 1c
                                                        <br />
                                                        <img src="assets/images/adobeair.jpg" alt="adobe air Poker Android" />

                                                        <div style="height:10px;"></div>

                                                        1c. Tap Install kemudian tap Accept
                                                        <br />
                                                        <img src="assets/images/adobeair1.jpg" alt="adobe air Poker Android" />

                                                        <div style="height:10px;"></div>

                                                        1d. Tunggu Adobe Air didownload dan diinstall
                                                        <br />
                                                        <img src="assets/images/adobeair2.jpg" alt="adobe air Poker Android" />

                                                        <div style="height:10px;"></div>

                                                        1e. Ketika Sudah selesai maka akan muncul gambar seperti dibawah ini
                                                        <br />
                                                        <img src="assets/images/adobeair3.jpg" alt="adobe air Poker Android" />
                                                    </div>
                                                </li>

                                                <li>Setting Security Agar dapat menginstall Poker Android
                                                    <div style="margin-left:20px;">
                                                        2a. Masuk ke Setting kemudian pilih Security
                                                        <br />
                                                        <img src="assets/images/security-android-setting.png" alt="install Poker Android" />

                                                        <div style="height:10px;"></div>

                                                        2b. Centang Unknown Source seperti dibawah ini
                                                        <br />
                                                        <img src="assets/images/unknown-sources.png" alt="install Poker Android" />
                                                    </div>
                                                </li>

                                                <li>Install Poker Android
                                                    <div style="margin-left:20px;">
                                                        3a. Download Poker Android dengan tap gambar dibawah ini
                                                        <br />
                                                        <a href="<?php echo "".$filen."";?>"><img src="assets/images/android-image.jpg" alt="install Poker Android" width="900px" /></a>

                                                        <div style="height:10px;"></div>

                                                        3b. Muncul notification download diatasnya seperti gambar dibawah ini
                                                        <br />
                                                        <img src="assets/images/downloadandroid11.jpg" alt="install Poker Android" />

                                                        <div style="height:10px;"></div>

                                                        3c. Jika kita tab maka akan muncul proses download seperti gambar dibawah ini
                                                        <br />
                                                        <img src="assets/images/downloadandroid2.jpg" width="927px" alt="install Poker Android" />

                                                        <div style="height:10px;"></div>

                                                        3d. Tunggu sehingga download complete seperti gambar dibawah ini
                                                        <br />
                                                        <img src="assets/images/downloadandroid3.jpg" width="927px" alt="install Poker Android" />

                                                        <div style="height:10px;"></div>

                                                        3e. Setelah download Poker Android versi android buka file manager
                                                        <br />
                                                        <img src="assets/images/filemanager.jpg" alt="install Poker Android" />

                                                        <div style="height:10px;"></div>

                                                        3f. Masuk ke folder download
                                                        <br />
                                                        <img src="assets/images/filemanager1.jpg" alt="install Poker Android" />

                                                        <div style="height:10px;"></div>

                                                        3g. Maka akan ada file <?php echo "".$filen."";?>
                                                        <br />
                                                        <img src="assets/images/filemanager2.jpg" alt="install Poker Android" />

                                                        <div style="height:10px;"></div>

                                                        3h.Install Poker Android dengan tap file <?php echo "".$filen."";?>

                                                        <div style="height:10px;"></div>

                                                        3i. Kemudian tap Install
                                                        <br />
                                                        <img src="assets/images/installandroid1.jpg" alt="install Poker Android" height='500' />

                                                        <div style="height:10px;"></div>

                                                        3j. Ketika Installasi sukses maka akan seperti gambar dibawah ini
                                                        <br />
                                                        <img src="assets/images/installandroid2.jpg" alt="install Poker Android" height='500' />

                                                        <div style="height:10px;"></div>

                                                        3k. Ketika dibuka akan muncul seperti gambar dibawah ini berarti Poker Android berhasil diinstall
                                                        <br />
                                                        <img src="assets/images/installandroid3.jpg" alt="install Poker Android" />

                                                        <div style="height:10px;"></div>

                                                        Selamat anda bisa bermain Game Poker di android anda!

                                                    </div>
                                                </li>
                            				</ol>
                                        </div> -->
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