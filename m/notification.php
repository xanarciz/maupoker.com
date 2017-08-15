<?php
$page='notifikasi';

include("../config_db2.php");
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
					$data_memo = sqlsrv_query($sqlconn, "select * from a83adm_newsinfo where subwebid = '".$subwebid."' order by waktu desc",$params,$options);
					if (@sqlsrv_num_rows($data_memo) > 0){
						$no = 1;
						while($fetch_data_memo = sqlsrv_fetch_array($data_memo, SQLSRV_FETCH_ASSOC)){
						if ($cread == 0){
							$read = "<font color=red>Unread</font>";
						}else{
							$cread = "Read";
						}
						?>
						<tr class="notif" onclick="set_id('<?php echo $fetch_data_memo["id"]; ?>')">
							<td style="color:black;"><?php echo $no; ?></td>
							<td style="color:black;text-align:left;"><?php echo $fetch_data_memo["title"];?></td>
							<td style="color:black;"><?php echo date_format($fetch_data_memo["waktu"],"d/m H:i");?></td>
						</tr>
						<?php 
							$no++;
						}
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