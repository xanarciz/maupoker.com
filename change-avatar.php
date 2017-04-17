<?php
$freePage = 1;
$page = "changeAvatar";
include("meta.php");

if (!$_GET["log"]){
echo $_GET["domain"];
	exit( "<script>top.location.href='http://".$_GET["domain"]."/game-avatar.php';</script>");
	die();
}

$angka= "onKeypress=\"if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }\"";
$pass = $p;
if (!$login){
	$login = $_GET["log"];
	$pass = $_GET["key"];
	$subwebid = $_GET["subweb"];
}

$sql = sqlsrv_fetch_array(sqlsrv_query($sqlconn, "select userpass from u6048user_id where userid='".$login."' and subwebid='".$subwebid."'"), SQLSRV_FETCH_ASSOC);
$passx = $sql["userpass"];
if ($pass != $passx){
	die();
}

$dir = substr($login,0,1);
$select = $_POST["select"];
$upload=$_POST["upload"];
if ($upload) {

	$uploadfile = $uploaddir . basename($_FILES['userfile']['name']);
	$maxfilesize = 1024*100;
	$zz = 0;
	if (($_FILES['userfile']['type'] != "image/gif") && ($_FILES['userfile']['type'] != "image/jpg") && ($_FILES['userfile']['type'] != "image/png") && ($_FILES['userfile']['type'] != "image/jpeg") && ($_FILES['userfile']['type'] != "image/pgif") && ($_FILES['userfile']['type'] != "image/pjpg") && ($_FILES['userfile']['type'] != "image/ppng") && ($_FILES['userfile']['type'] != "image/pjpeg")) {
		$report =  "<CENTER><B><FONT SIZE='5' COLOR='#FF0000'> ".$_FILES['userfile']['type']." Gagal,Hanya tipe Image </FONT></B></CENTER>";
	}else if ($_FILES['userfile']['size'] <= $maxfilesize){
		if (move_uploaded_file($_FILES['userfile']['tmp_name'], $img)) {
			$report = "<center>Sukses ganti avatar!</center>";
			//exit( "<script>top.location.href='http://".$_GET["domain"]."/game-avatar.php';</script>");
		}
	}else{
		$report = "<CENTER>Gagal,Ukuran File terlalu besar.</CENTER>";
	}
}

if ($select) {

	$PicId = $_POST["picid"];
	$tempPath = "Avatar/public/idn/".$PicId.".jpg";
	$movePath = "Avatar/".$dir."/".$login.".jpg";
	
	if (copy($tempPath, $movePath)) {		
		$report = "<center>Sukses ganti avatar!</center>";
		//exit( "<script>top.location.href='http://".$_GET["domain"]."/game-avatar.php';</script>");		
	}else {
		$report = "</center>Gagal!</center>";
	}
}

?>
            <div id="content">
                <div class="container">
                    <div class="wrap">
                        <div class="full">
                            <div class="body-wrap">
								<?php 
								if ($errorReport){
								?>
								
									<div class="alert alert-danger">
										<?php
										echo $errorReport;
										?>
									</div>
								<?php
								}else if ($report){
								?>
									<div class="alert alert-success">
										<?php
										echo $report;
										
										?>
									</div>
								<?php
								}
								?>
								<!-- UPLOAD PRIVATE PICTURE -->
								<form enctype="multipart/form-data" method="POST">
									<input type="hidden" name="login" value="<?php echo "".$login."";?>" />
									<input type="hidden" name="key" value="<?php echo "".$pass."";?>"/>
									<input name="userfile" type="file"  class="btn btn-submit" />
									<br/>
									<span style="font-size:12px;">Ukuran disarankan</span> <span style="">100 x 100 pixel</span>
									<div style="height:10px;"></div>
									<input type="submit" name="upload" value="Upload" class="btn btn-submit"/><BR><BR>
								</form>
							    <!-- UPLOAD PRIVATE PICTURE-->
                                <form enctype="multipart/form-data" method="POST">
									<table width=100% border=0 cellpadding=2 cellspacing=0>
										
										<tr>
											<?php
											$sql = sqlsrv_query($sqlconn, "select dir from j2365join_avatar order by id",$params,$options);
											$jum = sqlsrv_num_rows($sql);
											$tr = 1;
											for($a=0; $a<$jum; $a++) {
												$dataPic = sqlsrv_fetch_array($sql, SQLSRV_FETCH_ASSOC);
												
												echo "<td><input type='radio' name=picid value='".$dataPic["dir"]."'></td>";
												echo "<td><img src='Avatar/public/idn/".$dataPic["dir"].".jpg' width=50 height=50></td>";
												if ($tr == 5) {
													echo "</tr><tr><td>&nbsp;</td></tr><tr>";
													$tr = 0;
												}
												$tr++;
												
											}
											?>
										</tr>
										<tr><td colspan=10 align=center>
											<input type="hidden" name="user" value="<?php echo "".$login."";?>" />
											<input type="hidden" name="login" value="<?php echo "".$login."";?>" />
											<input type="hidden" name="key" value="<?php echo "".$passx."";?>" />
											<input type="hidden" name="type" value="<?php echo "".$type."";?>" />
											<button type="submit" value=kirim name=select class="btn btn-submit">Pilih</button>
										</td>
										</tr>
									</table>
								</form>
                            </div>
                        </div>
                    </div>

                    <div class="clear space_30"></div>
                </div>
            </div>
    </body>
</html>