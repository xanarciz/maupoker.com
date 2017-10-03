<?php
$page = "memo";
include("meta.php");
include("header.php");
//exit("memo temporary unavailable");
if (!$_SESSION["login"]){
	echo "<script>window.location = 'index.php'</script>";
	die();
}
if (!$_GET["id"]){
	$id_memo = 1;
	$type = 4;
}else{
	$id_memo = $_GET["id"];
	if ($id_memo > 2){
		$id_memo = 2;
	}
	
	if($id_memo == 1) { $type = 4; $statRep = 'rep';}
	if($id_memo == 2) { $type = 5; $statRep = 'fwd';}
}

if(!$_GET['page']) $page = 1;
else $page = $_GET['page'];

if ($_GET["delete"]){
	if ($_GET["delete"] > 0){
		$reqAPIMemoDel = array(
            'auth'      => $authapi,
			"userid" 	=> $login,
			"id" 		=> $_GET["delete"],
			"type"		=> 3,
		);
		$respMemoDel = sendAPI($url_Api."/memo",$reqAPIMemoDel,'JSON','02e97eddc9524a1e');
		if( $respMemoDel->status == 200 ){
            echo "<script>window.location = 'memo.php?id=" . $id_memo . "'</script>";
		}
        echo "<script>alert('Delete Failed, " . $respMemoDel->msg . "');</script>";
	}
}

// get inbox/outbox
$reqAPIMemoinout = array(
    "auth"      => $authapi,
    "agent" 	=> $agentwlable,
    "userid" 	=> $login,
    "type"		=> $type,
);

$respMemoinout = sendAPI($url_Api."/memo?page=".$page,$reqAPIMemoinout,'JSON','02e97eddc9524a1e');
$total_page = $respMemoinout->resp->last_page;

?>
<link rel="stylesheet" href="assets/css/popmodal.css?id=<?PHP echo time(); ?>" type="text/css" />
<style>
	#table-memo tbody td{ color: #ffffff !important; }
	#unread{ color: #f00; }
</style>
            <div id="content">
                <div class="container">

                    <div class="clear space_30"></div>

                    <div class="wrap">
                        <div class="full">
                            <div class="head-wrap">
                                <?php if ($id_memo == 1){
                                    echo '<h1>Memo - Inbox</h1>';
                                }else{
                                    echo '<h1>Memo - Outbox</h1>';
                                }
								?>
                            </div>

                            <div class="body-wrap">
                                <div class="left">
                                    <a class="btn btn-login" href="?id=1">Kotak Masuk</a>
                                    <a class="btn btn-login" href="?id=2">Kotak Keluar</a>
                                </div>

                                <div class="right">
                                    <a class="btn btn-write compose popup2" id="compose">Tulis Memo</a>
                                </div>

                                <div class="clear space_20"></div>
                                <?php
                                    getPaging($total_page, $page, 'memo.php?id='.$id_memo, array('showMore' => true));
                                ?>

                                <table id="table-memo">
                                    <thead>
										<tr>
											<th>#</th>
											<?php
											if ($id_memo == 1) echo '<th>Dari</th>';
											if ($id_memo == 2) echo '<th>Kepada</th>';
											?>
											<th>Subjek</th>
											<th>Tanggal</th>
											<th>Status</th>
											<th></th>
										</tr>
									</thead>

                                    <tbody>
										<?php
											$i = $respMemoinout->resp->from;
											if( $respMemoinout->resp->total > 0 ){
												foreach($respMemoinout->resp->data AS $memo){
													if ($memo->mread == 0){
														$read = '<span id="unread">Belum dibaca</span>';
													}else{
														$read = '<span id="read">baca</span>';
													}
													?>
													<tr>
														<td align="center"><?php echo $i++; ?></td>
														<td><?php echo 'Operator'; ?></td>
														<td><?php echo $memo->msubject.' <br>';?></td>
														<td><?php echo date('d/m/Y H:i:s', strtotime($memo->mdate)); ?></td>
														<td><?php echo $read; ?></td>
														<td align="center">
															<a class="table" rel="withdraw"></a>
															<a class="id" rel="4"></a>
															[<a href="#" id="read-<?php echo $memo->id; ?>" class="popup2"><font color=white>Baca</font></a>]
															[<a href="#" id="rep-<?php echo $memo->id; ?>" class="popup2"><font color=white>Balas</font></a>]
															[<a href="javascript:delete_record('<?php echo $memo->id; ?>','<?php echo $id_memo;?>');" ><font color=white>Hapus</font></a>]
														</td>
													</tr>
													<?php
												}
											}
										?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="clear space_30"></div>
                </div>
				<!-- The Modal -->
				<div id="Modal" class="modal">
					<!-- Modal content -->
					<div class="modal-content memo"></div>
				</div>
            </div>
			<script language="JavaScript" type="text/javascript">
				$(document).ready(function(){
					$(".toggleCheck").bind("click", function(){
						var current=$(this);
						var table=current.parent().children("a.table").attr("rel");
						var id=current.parent().children("a.id").attr("rel");
						if(confirm("Are you sure want to perform this action? Click 'OK' to continue.")){
							$.get(''+"/"+table+"/"+id+"/"+current.attr("rel"), function(r){
								$("#statusCheck"+id).html(r);
							})
						}
					});
					$("#table th, #table tfoot tr td").css({
						"background":"#444444",
						"color":"#ffffff"
					});
					$("#table").css({
						"border":"1px solid #444444"
					});
				})
				
				function delete_record(idmemo, idbox){
					if (!idmemo){
						return false;
					}else if (!idbox){
						return false;
					}else{
						var validasi = confirm("Are you sure, to delete this memo?");
						if (validasi){
							window.location = "memo.php?id="+idbox+"&delete="+idmemo;
						}
					}
				}
				
				var modal = document.getElementById('Modal');
				function openModal() {
					modal.style.display = "block";
				}
				$('.popup2').click(function () {
					var id = $(this).attr('id');
					var span = document.getElementsByClassName("close")[0];
					if(id == 'compose')
						$('#Modal .modal-content').load('memo-form.php?typ=com', function () { openModal(); });
					if(id.substring(0, 3) == 'rep') {
						var memid = id.split('-')[1];
						$('#Modal .modal-content').load('memo-form.php?typ=<?php echo $statRep; ?>&id='+memid, function () { openModal() });
					}
					if(id.substring(0, 4) == 'read') {
						var memid = id.split('-')[1];
						$('#Modal .modal-content').load('memo-read.php?typ=<?php echo $id_memo;?>&id='+memid, function () { openModal() });
					}
				});
				window.onclick = function(event) {
					if (event.target == modal) {
						modal.style.display = "none";
					}
				}
				
			</script>
<?php
include("footer.php");
?>