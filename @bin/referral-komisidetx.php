<style>
#table-lobby{ border: 1px solid #333333; }
#table-lobby thead tr th{ border-bottom:1px solid #333333; }
</style>

<?php
$freePage = 1;
include("meta.php");
include("header.php");
if (!$register)exit("<script>location.href='index.php'</script>");

$angka="onKeypress=\"if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }\"";

$_GET = sanitize($_GET);
$_POST = sanitize($_POST);
$type = $_GET["type"];
$tgl = $_GET["tgl"];
$agent = $_GET["agent"];
$date = $_GET["date"];
if($agent == "" || $date == "")die("Access Denied");

//$dt = mssql_fetch_array(mssql_query("select userpass from u6048user_id where userid = '".$agent."'"));
//echo $dt["joindate"];
if($sqlu["userpass"] != $date)die("Access Denied");
$date = mssql_fetch_array(mssql_query("select paycom_date from a83adm_config"));
$gam = mssql_fetch_array(mssql_query("select gamename from a83adm_configgame where gamecode = '".$type."'"));
?>
			<div id="content">
                <div class="container">

                    <div class="clear space_30"></div>

                    <div class="wrap">
                        <div class="full">
                            <div class="head-wrap">
                                <h1>Referral</h1>
                            </div>

                            <div class="body-wrap text-justify">
                                <h1>USERID : <?php echo"".$agent."";?></h1>
                        		<h2>Date : <?php echo"".$tgl."";?></h2>

                        		<table width="100%" cellpadding="10" cellspacing="1" border="1" class="border" id="table-lobby">
                        			<thead>
                        				<tr class="cufon cufon-normal" style="font-size:18px;">
                        					<th>No</th>
                        					<th>Downline Aktif</th>
                        					<!-- <th>Turn Over</th> -->
                        					<th>Komisi</th>
                        				</tr>
                        			</thead>
                        			<tbody>
                        			<?php
                        			$sql = mssql_query("select player, tover from j2365join_transaction where pdate = '".$tgl."' and gametype = '".$type."' and playerpt = '1' and agent = '".$agent."'");
                        			$i = 1;
                        			while($data = mssql_fetch_array($sql)){
                        				$datay = mssql_fetch_array(mssql_query("select isnull(sum(tover),0) as ttl, isnull(sum(playerpt_comm),0) as ttlx from j2365join_transaction where pdate = '".$tgl."' and gametype ='".$type."' and playerpt = '1' and agent = '".$agent."' and player = '".$data["player"]."'"));
                        			?>
                        				<tr class="cufon cufon-normal">
                        					<td><span><?php echo"".$i."";?></span></td>
                        			        <td><span><?php echo"".$data["player"]."";?></span></td>
                        			       <!--  <td><span><?php echo"".currx($datay["ttl"])."";?></span></td> -->
                        			        <td><span><?php echo"".currx($datay["ttlx"])."";?></span></td>
                        			    </tr>
                        			<?php
                        				$sub += $datay["ttl"];
                        				$totx += $datay["ttlx"];
                        				$i++;
                        			}
                        			?>
                        			<tr class="cufon cufon-normal" style="font-size:18px;">
                        			        <td colspan=1 align=right><span>Total</span></td>
                        			        <td><span><?php echo"".currx($sub)."";?></span></td>
                        			        <td><span><?php echo"".currx($totx)."";?></span></td>
                        			</tr>

                        			</tbody>
                        		</table>

                        		<div style="height:20px;"></div>

                        		<div align="center">
                            		<?php
                                        echo"<input type=button value=Refresh onclick=\"hilang();\" id=\"xxx\">";
                                    ?>
                        		</div>
                            </div>
                        </div>
                    </div>

                    <div class="clear space_30"></div>
                </div>
            </div>
<?php
include("footer.php");
?>