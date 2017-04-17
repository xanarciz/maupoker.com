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
                                <h1>Cara Bermain</h1>
                            </div>

                            <div class="body-wrap text-justify">
                                <?php
								$q_howtoplay=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select howtoplay_text from u6048user_agencyruntext where agent='".$agentwlable."'"), SQLSRV_FETCH_ASSOC);
								echo str_replace("\r\n","<br>",$q_howtoplay["howtoplay_text"]);
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