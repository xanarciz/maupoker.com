<?php
$page='notifikasi';

include("_metax.php");
include("_header.php");

if(strtoupper($link_img) == "IO"){ $warna = "blue"; }elseif($link_img == "PTKP"){ $warna = "blue"; }else{ $warna = "purple";}

?>

<div class="content">
	<div class="lpadding-15 tpadding-5">
		<label class="<?PHP echo $warna; ?> fs-13 tmargin-10">NOTIFIKASI</label>
	</div>
	<div id="notifikasi" style="max-height:auto; padding-bottom:50px;">
		<div class="padding">

			<div class="row tpadding-1 bpadding-50" style="height: 450px; overflow: scroll;">					
				<table class="table" cellspacing="0" cellpadding="0" border="0">
					<thead>
						<tr>
							<th>#</th>
							<th>Subjek</th>
							<th>Tanggal</th>
						</tr>
					</thead>
					<tbody>
                    <?php
                    ///MEMO-INBOX
                    $i = 1;
                    foreach ($infoweb['newsAgent'] as $id => $notif){
                        $date = date('d/m H:i', strtotime($notif["waktu"]))
                        ?>
                        <tr class="notif" onclick="set_id('<?php echo $id; ?>')">
                            <td style="color:black;"><?php echo $i++; ?></td>
                            <td style="color:black;text-align:left;"><?php echo $notif["title"];?></td>
                            <td style="color:black;"><?php echo $date;?></td>
                        </tr>
                        <?php
                    }
                    ?>
					</tbody>
				</table>
				<input type="hidden" id="id_memo">
			</div>

		</div>
	</div>

</div>
<div id="notif-dialog" title="Notification" data-inset="false" >
	
</div>
<script>
	function set_id(id) {
		 $("#notif-dialog").load("notifmodal.php?id="+id);
	}
</script>

<?php include("_footer.php"); ?>