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
}else{
	$id_memo = $_GET["id"];
	if ($id_memo > 2){
		$id_memo = 2;
	}
}

if ($_GET["delete"]){
	if ($_GET["delete"] > 0){
		sqlsrv_query($sqlconn_db2, "delete from j2365join_memo where (mfrom = '".$login."' or mto = '".$login."') and id = '".$_GET["delete"]."'");	
	}
}
?>
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
                                    <a class="btn btn-write popup" href="memo-compose.php">Tulis Memo</a>
                                </div>

                                <div class="clear space_20"></div>

                                <table id="table-memo">
                                    <thead>
                        				<tr>
                        					<th>#</th>
          									<th>Dari</th>
          									<th>Subjek</th>
          									<th>Tanggal</th>
          									<th>Status</th>
          									<th></th>
                        				</tr>
                        			</thead>

                                    <tbody>
                                        <?php
											$no = 1;
											if ($id_memo == 1){
												//MEMO-INBOX
												$data_memo = sqlsrv_query($sqlconn_db2, "select id,mfrom,msubject,mdate,mread,mto from j2365join_memo where mto = '".$login."' and mfrom = '".$agentwlable."' order by id desc",$params,$options);
												if (@sqlsrv_num_rows($data_memo) > 0){
													echo "Content";
													while($fetch_data_memo = sqlsrv_fetch_array($data_memo, SQLSRV_FETCH_ASSOC)){
													if ($fetch_data_memo["mread"] == 0){
														$read = "<font color=red>Belum dibaca</font>";
													}else{
														$read = "Baca";
													}
													?>
														<tr>
															<td align="center"><?php echo $no; ?></td>
															<td><?php echo "Operator";?></td>
															<td><?php echo $fetch_data_memo["msubject"];?></td>
															<td><?php echo date_format($fetch_data_memo["mdate"],"d/m H:i");?></td>
															<td><?php echo $read;?></td>
															<td align="center">
																<a class="table" rel="withdraw"></a>
																<a class="id" rel="4"></a>
																[<a href="memo-read.php?id=<?php echo $fetch_data_memo["id"]; ?>" class="popup" ><font color=white>Baca</font></a>]
																[<a href="memo-reply.php?id=<?php echo $fetch_data_memo["id"]; ?>" class="popup"><font color=white>Balas</font></a>]
																[<a href="javascript:delete_record('<?php echo $fetch_data_memo["id"]; ?>','<?php echo $id_memo;?>');" ><font color=white>Hapus</font></a>]
															</td>
														</tr>
													<?php 
														$no++;
													}
												}
											}else{
												//MEMO-OUTBOX
												$data_memo = sqlsrv_query($sqlconn_db2, "select id,mfrom,msubject,mdate,mread,mto from j2365join_memo where mfrom = '".$login."' and mto = '".$agentwlable."' order by id desc",$params,$options);
												if (sqlsrv_num_rows($data_memo) > 0){
													while($fetch_data_memo = sqlsrv_fetch_array($data_memo, SQLSRV_FETCH_ASSOC)){
														if ($fetch_data_memo["mread"] == 0){
															$read = "<font color=red>Belum dibaca</font>";
														}else{
															$read = "baca";
														}
													?>
														<tr>
															<td align="center"><?php echo $no; ?></td>
															<td><?php echo $login;?></td>
															<td><?php echo $fetch_data_memo["msubject"];?></td>
															<td><?php echo date_format($fetch_data_memo["mdate"],"d/m/Y H:i:s");?></td>
															<td><?php echo $read;?></td>
															<td align="center">
																<a class="table" rel="withdraw"></a>
																<a class="id" rel="4"></a>
																[<a href="memo-read.php?id=<?php echo $fetch_data_memo["id"]; ?>" class="popup"><font color=white>Baca</font></a>]
																[<a href="memo-reply.php?id=<?php echo $fetch_data_memo["id"]; ?>" class="popup"><font color=white>Balas</font></a>]
																<!-- [<a href="memo-reply.php?id=<?php echo $fetch_data_memo["id"]; ?>" class="popup"><font color=white>Balas</font></a>] -->
																[<a href="javascript:delete_record('<?php echo $fetch_data_memo["id"]; ?>','<?php echo $id_memo;?>');" ><font color=white>Hapus</font></a>]
															</td>
														</tr>
													<?php 
														$no++;
													}
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
            </div>
			<script language="JavaScript" type="text/javascript">
				jQuery(document).ready(function(){
					jQuery(".popup").nyroModal();
					fixtable("#table", null, "#000000", "#111111", "#333333");
					getfilter();
					jQuery(".toggleCheck").bind("click", function(){
						var current=jQuery(this);
						var table=current.parent().children("a.table").attr("rel");
						var id=current.parent().children("a.id").attr("rel");
						if(confirm("Are you sure want to perform this action? Click 'OK' to continue.")){
							jQuery.get(''+"/"+table+"/"+id+"/"+current.attr("rel"), function(r){
								jQuery("#statusCheck"+id).html(r);
							})
						}
					});
					jQuery("#table th, #table tfoot tr td").css({
						"background":"#444444",
						"color":"#ffffff"
					});
					jQuery("#table").css({
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
			</script>
<?php
include("footer.php");
?>