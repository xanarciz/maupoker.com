<style>
#table-lobby{ border: 1px solid #333333; }
#table-lobby thead tr th{ border-bottom:1px solid #333333; }
</style>
<SCRIPT LANGUAGE="JavaScript">

var newwin;

function launchwin(winurl,winname,winfeatures)
{
	newwin = window.open(winurl,winname,winfeatures);
}

</SCRIPT>

<?php
include("meta.php");
include("header.php");
if (!$register)exit("<script>location.href='index.php'</script>");

$angka="onKeypress=\"if (event.keyCode < 48 || event.keyCode > 57 || event.keyCode == 13) { if (event.keyCode == 42 || event.keyCode == 13) event.returnValue=true; else event.returnValue = false; }\"";

$_GET = sanitize($_GET);
$_POST = sanitize($_POST);
$type = $_GET["type"];
$tgl = $_GET["tgl"];
$agent = $_GET["agent"];
$dat = $_GET["date"];
//if($agent == "" || $dat == "")die("Access Denied");

//$dt = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select joindate from u6048user_id where userid = '".$agent."'"));
//echo $dt["joindate"];
//if($sqlu["userpass"] != $date)die("Access Denied");
$date = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select paycom_date from a83adm_config"),SQLSRV_FETCH_ASSOC);

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
                        					<th>Nama Game</th>
                        					<!-- <th>Turn Over</th> -->
                        					<th>Komisi</th>
                        				</tr>
                        			</thead>
                        			<tbody>
                        			<?php
                        			$sql = sqlsrv_query($sqlconn,"select distinct(gametype) from j2365join_transaction where pdate = '".$tgl."' and playerpt = '1' and agent = '".$agent."'");
                        			$i = 1;
                        			while($data = sqlsrv_fetch_array($sql,SQLSRV_FETCH_ASSOC)){
                        				$gam = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select gamename from a83adm_configgame where gamecode = '".$data["gametype"]."'"),SQLSRV_FETCH_ASSOC);
                        				$datay = sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select isnull(sum(tover),0) as ttl, isnull(sum(playerpt_comm),0) as ttlx from j2365join_transaction where pdate = '".$tgl."' and playerpt = '1' and agent = '".$agent."' and gametype = '".$data["gametype"]."'"),SQLSRV_FETCH_ASSOC);
                        			?>
                        				<tr class="cufon cufon-normal">
                        					<td><span><?php echo"".$i."";?></span></td>
                        			        <td><a href="Javascript:launchwin('referral-komisidetx.php?date=<?php echo"".$dat."";?>&type=<?php echo"".$data["gametype"]."";?>&tgl=<?php echo"".$tgl."";?>&agent=<?php echo"".$agent."";?>','pl_det','height=500,width=730,scrollbars=1')" style="text-decoration:none;color:white;"><?php echo"".$gam["gamename"]."";?>></a></td>
                        			        <!-- <td><span><?php echo"".currx($datay["ttl"])."";?></span></td> -->
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