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
                                <h1>Pengumuman</h1>
                            </div>

                            <div class="body-wrap text-left">
                                <?php
								$id=$_GET["id"];
								if ($id){
									$q=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select title,berita,waktu from a83adm_newsinfo where subwebid='".$subwebid."' and id='".$id."'"),SQLSRV_FETCH_ASSOC);
									echo "<div class='right pt10'><strong>".date_format($q["waktu"],"d/m/y")."</strong></div>";
									echo "<div><h3>".$q["title"]."</h3></div>";
									echo "<div>".str_replace("\r\n","<br>",$q["berita"])."</div>";
								}
								?>
                            </div>
                        </div>
                    </div>

                    <div class="clear space_30"></div>
                </div>
            </div>
<?php
include("footer.php");
?>