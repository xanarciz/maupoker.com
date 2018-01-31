<?php
$freePage = 1;
include("meta.php");
include("header.php");
?>
			<div id="content">
                <div class="container">

                    <div class="clear space_30"></div>

                    <div class="wrap" style="height: 100%; overflow-y: scroll;">
                        <div class="full">
                            <div class="head-wrap">
                                <h1>Pengumuman</h1>
                            </div>

                            <div class="body-wrap text-left">
                                <?php
								$id=$_GET["id"];
								if ($id){
                                    if(isset($infoweb['newsAgent']['id_'.$id])) {
                                        $q = $infoweb['newsAgent']['id_' . $id];
                                        echo "<div class='right pt10'><strong>" . date('d/m/y', strtotime($q["waktu"])) . "</strong></div>";
                                        echo "<div><h3>" . $q["title"] . "</h3></div>";
                                        echo "<div>" . str_replace("\r\n", "<br>", $q["berita"]) . "</div>";
                                    }else{
                                        echo "<div><h3>404 Not Found</h3></div>";
                                    }
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

<style type="text/css">
.wrap::-webkit-scrollbar {
    width: 10px;
}
 
.wrap::-webkit-scrollbar-track {
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
    border-radius: 10px;
}
 
.wrap::-webkit-scrollbar-thumb {
    border-radius: 10px;
    background-color: white;
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
}
</style>