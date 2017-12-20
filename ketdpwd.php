<div id="content">
    <div class="container">
        <div class="clear space_30"></div>
        <div class="wrap">
            <div class="full">
                <div class="head-wrap"><h1>Ketentuan <?php echo $flag;?></h1></div>
                <div class="body-wrap" style="text-align: justify;">
                    <div class="ket-content">
                        <?php
                        if($flag == 'deposit') {
                            ?>
                            <p> Kami tidak pernah mengirimkan REKENING DEPOSIT  melalui SMS, EMAIL ataupun di WEBSITE INI.
                                Deposit adalah mengirim uang ke rekening kami yang tersedia untuk ditukarkan menjadi CHIPS permainan. Bagaimana cara melakukan DEPOSIT ?</p>
                            <ul style="list-style-type:circle;margin-left: 20px;">
                                <li>Deposit hanya dapat diproses selama BANK ONLINE</li>
                                <li>Jika BANK SEDANG OFFLINE atau BANK SEDANG GANGGUAN semua proses deposit tidak dapat diproses untuk sementara waktu sampai BANK KEMBALI NORMAL</li>
                                <li>Harap perhatikan rekening deposit kami yang sedang aktif sebelum melakukan pengiriman deposit, sehingga deposit anda dapat di proses secepatnya ke dalam dompet utama anda.</li>
                                <li>Jika anda ingin lancar dalam proses DEPOSIT harap mengirim dana dalam angka unik di setiap deposit. Contoh : Rp. 500.879, Rp 50.247, Rp. 84.987 dan sebagainya. Ini berguna untuk kami melihat secara cepat deposit anda</li>
                                <li>Jika deposit anda telah diproses tapi chip anda belum bertambah harap menghubungi Customer Service kami melalui LIVECHAT.</li>
                            </ul>
                            <?php
                        }else{
                            ?>
                            <p>Penarikan adalah proses penukaran chips koin di UANG kan kembali ke rekening anda yang terdaftar atas nama id pertama kali pendaftaran. Cara melakukan penarikan adalah : </p>
                            <ul style="list-style-type:circle;margin-left: 20px;">
                                <li>Withdraw adalah penarikan chips balance anda ke account bank anda</li>
                                <li>Withdraw hanya dapat diproses selama BANK ONLINE</li>
                                <li>Jika BANK SEDANG OFFLINE atau BANK SEDANG GANGGUAN proses withdraw tidak dapat diproses atau dipending sampai BANK KEMBALI NORMAL</li>
                                <li>Pengiriman withdraw diproses pada rekening yang pertama kali anda daftarkan, selain daripada itu kami tidak proses withdraw ke rekening yang berbeda</li>
                                <li>Jika terdapat kendala perihal withdraw silakan anda menghubungi Customer Service kami pada menu LiveChat</li>
                            </ul>
                            <?php
                        }
                        ?>
                    </div>
                    <div class="bnk-off">
                        <h4>Jadwal Bank Offline</h4>
                        <div class="row">
                            <div class="ico-bank">
                                <img src="assets/img/bank/bca-icon.png" style="vertical-align: middle;">
                                <button onclick=openRequestedPopup('https://ibank.klikbca.com/','BCA') target='POP' class="btn btn-submit">Login BCA</button>
                            </div>
                            <div class="sched">
                                <p>
                                    Senin-Jumat : 21.00 WIB - 00.30 WIB<br>
                                    Sabtu : Tidak ada offline<br>
                                    Minngu : 00.00 WIB - 05.00 WIB<br>
                                </p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="ico-bank">
                                <img src="assets/img/bank/bni-icon.png"  style="vertical-align: middle;">
                                <button onclick=openRequestedPopup('https://ibank.bni.co.id/','BNI') target='POP' class="btn btn-submit">Login BNI</button>
                            </div>
                            <div class="sched">
                                <p>
                                    Senin-Minggu : 01.30 WIB - 03.30 WIB
                                </p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="ico-bank">
                                <img src="assets/img/bank/mandiri-icon.png"  style="vertical-align: middle;">
                                <button onclick=openRequestedPopup('https://ib.bankmandiri.co.id','MANDIRI') target='POP' class="btn btn-submit">Login MANDIRI</button>
                            </div>
                            <div class="sched">
                                <p>
                                    Senin- Minggu : 23.00 WIB - 05.00 WIB
                                </p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="ico-bank">
                                <img src="assets/img/bank/bri-icon.png" style="vertical-align: middle;">
                                <button onclick=openRequestedPopup('https://ib.bri.co.id/ib-bri/','BRI') target='POP' class="btn btn-submit">Login BRI</button>
                            </div>
                            <div class="sched">
                                <p>
                                    Senin-Minggu :  22.00 WIB - 05.00 WIB
                                </p>
                            </div>
                        </div>
						<div class="row">
                            <div class="ico-bank">
                                <img src="assets/img/bank/cimb-icon.png" style="vertical-align: middle;">
                                <button onclick=openRequestedPopup('https://www.cimbclicks.co.id/ib-cimbniaga/Login.html','CIMB') target='POP' class="btn btn-submit">Login CIMB</button>
                            </div>
                            <div class="sched">
                                <p>
                                   Tidak Ada Offline
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="clear space_20"></div>


                </div>
            </div>
        </div>
    </div>
</div>
<div class="clear space_30"></div>

<script>

    function openRequestedPopup(link, title) {
        var windowObjectReference;
        var strWindowFeatures = "toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=1,scrollbars=1";
        var w = 830;
        var h = 830;
        var windowX = Math.ceil((window.screen.width - (w)) / 2);
        var windowY = Math.ceil((window.screen.height - (h)) / 2);
        splash = windowObjectReference = window.open(link, title, strWindowFeatures);
        splash.resizeTo(Math.ceil(w), Math.ceil(h));
        splash.moveTo(Math.ceil(windowX), Math.ceil(windowY));
    }
</script>