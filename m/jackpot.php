<?php
$page='jackpot';
session_start();
$login = $_SESSION["login"];

if (!$login){
    include("_meta.php");
} else {
    include("_metax.php");
}
include("_header.php");
?>

<div class="content-2">
	<div class="lpadding-15 tpadding-5">
		<label class="ntf fs-13 tmargin-10">JACKPOT</label>
	</div>
	<hr class="margin-0 tmargin-2 bmargin-3 bg-brown-panel">

	<div id="referral">
		<div class="padding">
			<ul>
				<li><a href="#tabs-1">JACKPOT SYSTEM</a></li>
				<li><a href="#tabs-2">JACKPOT WINNER</a></li>
			</ul>
			<div id="tabs-1">

				<div class="padding-15">
					<p class="dark-gray">
						Texas Poker Multi Jackpot System
					</p>
					<p class="dark-gray">
						Ikutilah global jackpot yang tersedia di system kami, dengan system jackpot terbaru dan pertama di indonesia, Anda dapat membeli jackpot dengan harga 100 rupiah saja dan menangkan hadiahnya hingga puluhan juta rupiah.
					</p>
					<p class="dark-gray">
						Jackpot bukanlah suatu keharusan untuk dibeli, namun kami memberikan suatu fitur tambahan untuk member tercinta dari <?PHP echo $domain; ?>.
					</p>
					<p class="dark-gray">
						Terdapat tiga pilihan harga jackpot yang bisa Anda beli yaitu :100,500,1000 dan 2000(khusus table VIP Keatas) rupiah.
					</p>
					<p class="dark-gray">
						Hadiah dari Multi jackpot system <?PHP echo $domain; ?>
					</p>
					<p class="dark-gray fs-11">
						&emsp; full house x 10 harga jackpot yang Anda beli.<br/>
						&emsp; (contoh:Anda membeli 1000 maka:1000 X10 = 10.000)<br/>

						&emsp;four of kind x 250 harga jackpot yang Anda beli<br/>
						&emsp; (contoh:Anda membeli 1000 maka:1000 X250 = 250.000)<br/>
						&emsp;Straight flush x 1200<br/>

						&emsp;(contoh:Anda membeli 1000 maka:1000 X1200 = 1.200.000)<br/>
						&emsp;Royal flush x 10000 harga jackpot yang Anda beli<br/>

						&emsp;(contoh:Anda membeli 1000 maka:1000 X10000 = 10.000.000)<br/>
						&emsp;SUPER ROYAL FLUSH x 30000 harga jackpot yang Anda beli<br/>
						&emsp;(contoh:Anda membeli 1000 maka:1000 X30000 = <br/>&emsp; 30.000.000)<br/>
					</p>
					<p class="dark-gray">
						Kondisi kartu
					</p>
					<p class="dark-gray">
					* full house adalah kondisi kartu dimana kartu Anda dan kartu tengah dengan total 7 kartu bisa mendapatkan nilai 5 kartu dengan kombinasi 1 tris(three of kind) dan 1 pair, contoh 3 kartu 10 dan 2 kartu 5<br /> * Four of kind adalah kondisi kartu dimana kartu Anda dan kartu tengah dengan total 7 kartu bisa mendapatkan nilai 5 kartu dengan kombinasi 4 kartu yang sama jumlah dan 1 kartu apapun juga contoh Anda mendapatkan 4 buah kartu angka 3 dan 1 kartu apapun.<br /> * Staright flush adalah kondisi kartu dimana kartu Anda dan kartu tengah dengan total 7 kartu bisa mendapatkan nilai 5 kartu dengan kombinasi seri / staright dengan kembang yang sama contoh : urutan kartu dari angka 5, 6, 7, 8 , 9 10 dengan kembang yg sama misalnya as hati<br /> * Royal flush adalah kondisi kartu dimana kartu Anda dan kartu tengah dengan total 7 kartu bisa mendapatkan nilai 5 kartu dengan kombinasi seri / staright dengan kembang yang sama tetapi kartu tersebut haruslah dimulai dari 10. contoh 10, Queen, Jack, King dan aces dengan kembang yang sama<br /> * Super Royal flush adalah kondisi kartu dimana Kedua kartu Anda digabung dengan 3 kartu pertama meja haruslah royal flush. contoh kartu Anda 10,Queen kembang sama dan 3 kartu pertama meja adalah Jack, King dan aces dengan kembang yang sama</p>

					<p class="dark-gray bmargin-50">
						Demikian adalah penjelasan dari Multi Jackpot <?PHP echo $domain; ?> terima kasih dan selamat bermain salam hoki dari kami

					</p>
				</div>


			</div>

			<!-- WINNER -->
			<div id="tabs-2" align="center">
				<div class="bmargin-50">
				<?php
				
                        echo "<h1 class='".$warna."' style='padding-top: 15px;'>Texas Poker Jackpot Winner</h1>";
                        $q = sqlsrv_query($sqlconn,"SELECT top 5 TDate,Userid, Jackpot,Ket from t6413txh_globaljackpothis where ket='Super Royal Flush' order by TDate desc",$params,$options);
                            echo "<center>
                                    <table class='table'>
                                        <thead>
                                        	<tr><td colspan=6 align=center style=font-weight:bold;>TOP SUPER ROYAL FLUSH</td></tr>
	                                        <tr>
	                                            <td>No.</td>
	                                            <td>Tanggal</td>
	                                            <td>Nama</td>
	                                            <td>Price</td>
	                                            <td>Win</td>
	                                        </tr>
	                                    </thead>";
                        for ($i=0;$i<sqlsrv_num_rows($q); $i++){
                            $r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
                            echo "<tr>
	                                    <td>".($i+1)."</td>
	                                    <td>".date_format($r["TDate"],"d/m H:i")."</td>
	                                    <td>".$r["Userid"]."</td>
	                                    <td>".$r["Ket"]."</td>
	                                    <td align='right'>".number_format($r["Jackpot"])."</td>
	                                </tr>";
                        }
                        echo "</table></center>";

                        $q = sqlsrv_query($sqlconn,"SELECT top 5 TDate,Userid, Jackpot,Ket from t6413txh_globaljackpothis where ket='Royal Flush' order by TDate desc",$params,$options);
                        echo "<center>
                                <table class='table' style='padding-top: 10px;'>
                                	<thead>
	                                	<tr><td colspan=6 align=center style=font-weight:bold;>TOP ROYAL FLUSH</td></tr>
	                                    <tr>
	                                        <td>No.</td>
	                                        <td>Tanggal</td>
	                                        <td>Nama</td>
	                                        <td>Price</td>
	                                        <td>Win</td>
	                                    </tr>
	                            	</thead>";
                        for ($i=0;$i<sqlsrv_num_rows($q); $i++){
                            $r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
                            echo "<tr>
                                    <td>".($i+1)."</td>
                                    <td>".date_format($r["TDate"],"d/m H:i")."</td>
                                    <td>".$r["Userid"]."</td>
                                    <td>".$r["Ket"]."</td>
                                    <td align='right'>".number_format($r["Jackpot"])."</td>
                                </tr>";
                        }
                        echo "</tabel></center>";

                        $q = sqlsrv_query($sqlconn,"SELECT top 5 TDate,Userid, Jackpot,Ket from t6413txh_globaljackpothis where ket='Straight Flush' order by TDate desc",$params,$options);
                        echo "<center>
                                <table class='table' style='padding-top: 10px;'>
                                	<thead>
	                                	<tr><td colspan=6 align=center style=font-weight:bold;>TOP STRAIGHT FLUSH</td></tr>
	                                    <tr>
	                                        <td>No.</td>
	                                        <td>Tanggal</td>
	                                        <td>Nama</td>
	                                        <td>Price</td>
	                                        <td>Win</td>
	                                    </tr>
	                                </thead>";
                        for ($i=0;$i<sqlsrv_num_rows($q); $i++){
                            $r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
                            echo "<tr>
                                    <td>".($i+1)."</td>
                                    <td>".date_format($r["TDate"],"d/m H:i")."</td>
                                    <td>".$r["Userid"]."</td><td>".$r["Ket"]."</td>
                                    <td align='right'>".number_format($r["Jackpot"])."</td>
                                </tr>";
                        }

                        echo "</table></center>";
                        $q = sqlsrv_query($sqlconn,"SELECT top 50 TDate,Userid, Jackpot,Ket from t6413txh_globaljackpothis order by TDate desc",$params,$options);
                        echo "<center>
                                <table class='table' style='padding-top: 10px;'>
                                	<thead>
	                                	<tr><td colspan=6 align=center style=font-weight:bold;>LATEST JACKPOT</td></tr>
	                                    <tr>
	                                        <td>No.</td>
	                                        <td>Tanggal</td>
	                                        <td>Nama</td>
	                                        <td>Price</td>
	                                        <td>Win</td>
	                                    </tr>
	                                </thead>";
                        for ($i=0;$i<sqlsrv_num_rows($q); $i++){
                            $r=sqlsrv_fetch_array($q,SQLSRV_FETCH_ASSOC);
                            echo "<tr>
                                    <td>".($i+1)."</td>
                                    <td>".date_format($r["TDate"],"d/m H:i")."</td>
                                    <td>".$r["Userid"]."</td>
                                    <td>".$r["Ket"]."</td>
                                    <td align='right'>".number_format($r["Jackpot"])."</td>
                                </tr>";
                        }
                        echo "</table></center>";
				?>
			</div>
			</div>
			<!-- WINNER -->

		</div>

	</div>
</div>

<?PHP 
	if($link_img == "io"){ 
		$color1 = "#e6fdff";
		$color2 = "#2eb9ca";
	}elseif($link_img == "PTKP"){ 
		$color1 = "#f1f1f1";
		$color2 = "#992027";
	}else{ 
		$color1 = "#f1f1f1";
		$color2 = "#402573";
	} 
?>
<style type="text/css">
	#referral{
		border:none !important;
		padding: 0px !important;
	}
	#referral .ui-widget-header{
		border:none;
		background:<?PHP echo $color1;?>;
		border-radius: 0px;
	}
	.ui-tabs .ui-tabs-nav li {
		width:45%;
		margin-left:.5%;
		margin-right:.5%;
		text-align: center;
	}
	.ui-tabs .ui-tabs-nav li:first-child{
		margin-left:4%;
	}
	.ui-tabs .ui-tabs-nav li:last-child{
		margin-right:4%;
	}
	.ui-tabs .ui-tabs-nav li a {
		display: inline-block;
		float: none;
		padding: 6px;
		text-decoration: none;
		width: 100%;
		font-weight: normal;

	}
	.ui-tabs .ui-tabs-nav{
		padding: 0px;

	}
	.ui-corner-all, .ui-corner-top, .ui-corner-right, .ui-corner-tr{
		border:none;
	}
	.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default{
		background: #35353f;
		border:#35353f;

	}
	.ui-tabs .ui-tabs-nav li.ui-tabs-active{
		background: <?PHP echo $color2;?>;
		color:#fff;
	}
	.ui-tabs .ui-tabs-nav li.ui-tabs-active > a{
		color:#fff;
	}
	.ui-tabs .ui-tabs-panel{
		background: <?PHP echo $color1;?>;
		padding: 0px;
	}
</style>

<?PHP include '_footer.php'; ?>