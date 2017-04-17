<?php
$freePage = 1;
if (!$register)exit("<script>location.href='index.php'</script>");
include("meta.php");
include("header.php");

$_GET = sanitize($_GET);
$_POST = sanitize($_POST);
$user = $_GET["userid"];
$date = $_GET["date"];
if($user == "" || $date == "")die("Access Denied");

//$dt = mssql_fetch_array(mssql_query("select userpass from u6048user_id where userid = '".$user."'"));
//echo $dt["joindate"];
if($sqlu["userpass"] != $date)die("Access Denied");

$batasx = 20;
$sub = $_GET["st"];
$j = $_GET["j"];
$batas = $_GET["batas"];
$sql = mssql_query("select userid from u6048user_id where userprefix = '".$user."'");
$row = mssql_num_rows($sql);

$time = mssql_fetch_array(mssql_query("select paycom_date from a83adm_config"));
$subtotal = 0;
$commision = 0;
$subcomm = 0;
$grandcomm = 0;


function sqlfdate ($val) {
	$year = substr($val,-12,4);
	$bln = substr($val,0,3);
	$date = substr($val,4,2);

		if(substr($val,-2,2) == "PM"){
			if(substr($val,-7,2) == 1) $jam = "13";
			if(substr($val,-7,2) == 2) $jam = "14";
			if(substr($val,-7,2) == 3) $jam = "15";
			if(substr($val,-7,2) == 4) $jam = "16";
			if(substr($val,-7,2) == 5) $jam = "17";
			if(substr($val,-7,2) == 6) $jam = "18";
			if(substr($val,-7,2) == 7) $jam = "19";
			if(substr($val,-7,2) == 8) $jam = "20";
			if(substr($val,-7,2) == 9) $jam = "21";
			if(substr($val,-7,2) == 10) $jam = "22";
			if(substr($val,-7,2) == 11) $jam = "23";
			if(substr($val,-7,2) == 12) $jam = "12";
		}
		if(substr($val,-2,2) == "AM"){
			if(substr($val,-7,2) == 1) $jam = "01";
			if(substr($val,-7,2) == 2) $jam = "02";
			if(substr($val,-7,2) == 3) $jam = "03";
			if(substr($val,-7,2) == 4) $jam = "04";
			if(substr($val,-7,2) == 5) $jam = "05";
			if(substr($val,-7,2) == 6) $jam = "06";
			if(substr($val,-7,2) == 7) $jam = "07";
			if(substr($val,-7,2) == 8) $jam = "08";
			if(substr($val,-7,2) == 9) $jam = "09";
			if(substr($val,-7,2) == 10) $jam = "10";
			if(substr($val,-7,2) == 11) $jam = "11";
			if(substr($val,-7,2) == 12) $jam = "00";
		}

	return "$bln $date $year ".$jam.":".substr($val,-4,2)."";
}
?>
<script language="javascript">
function hilang() {
	document.getElementById("xxx").style.visibility = "hidden";
	location = document.location;
}
</script>

			<div id="content">
                <div class="container">

                    <div class="clear space_30"></div>

                    <div class="wrap">
                        <div class="full">
                            <div class="head-wrap">
                                <h1>Data Referral</h1>
                            </div>

                            <div class="body-wrap text-justify">
                                <table align="center">
                        			<tr align="center">
                                    	<?php
                                    	if ($row > $batas){
                                    	?>
                                    	<td>
                                    		<a href='referral-data.php?date=<?php echo"".$sqlu["userpass"]."";?>&userid=<?php echo"".$login."";?>&st=<?php echo ($sub+$batasx);?>&j=<?php echo ($j+$batasx);?>&batas=<?php echo ($batas+$batasx);?>&ref=getdate()'><font color=white>Next</font></a>
                                    	</td>
                                    	<?php
                                    	}
                                    	?>
                                    	<?php
                                    	if ($j>5){
                                    	?>
                                    	<td>
                                    		<a href='referral-data.php?date=<?php echo"".$sqlu["userpass"]."";?>&userid=<?php echo"".$login."";?>&st=<?php echo ($sub-$batasx);?>&j=<?php echo ($j-$batasx);?>&batas=<?php echo ($batas-$batasx);?>&ref=getdate()'><font color=white>Prev</font></a>
                                    	</td>
                                    	<?php
                                    	}
                                    	?>
                                	</tr>
                        		</table>
                        		<table width="100%" cellpadding="10" cellspacing="1" border="1" class="border" id="table-lobby">
                        			<thead>
                        				<tr class="form-text">
                        					<th>No</th>
                        					<th>UserId</th>
                        					<th>Tanggal Daftar</th>
                        					<th>Turn Over Sementara</th>
                        					<th>Komisi Sementara</th>
                        				</tr>
                        			</thead>
                        			<tbody>
                        			<tr><td colspan=5 height=20></td></tr>
                        			<?php
                        			$grand = 0;
                        			for ($i=1; $i<=$row; $i++){
                        				$array=mssql_fetch_array($sql);
                        				$data1[$i] = $array["userid"];
                        				$tover[$i] = mssql_fetch_array(mssql_query("select isnull(sum(tover),0)as ttl, isnull(sum(playerpt_comm),0)as cmm from j2365join_transaction where player = '".$data1[$i]."' and pdate >= '".$time["paycom_date"]."'"));
                        				$grand += $tover[$i]["ttl"];
                        				//$comm = strtolower($type)."_refcomm";
                        				$commison[$i] = $tover[$i]["cmm"];
                        				$grandcomm += $commison[$i];

                        			}

                        			for ($k=$j; $k<=$sub;  $k++){
                        				$user_id = mssql_fetch_array(mssql_query("select joindate, save_deposit from u6048user_id where userid = '".$data1[$k]."'"));
                        				$tover[$k] = mssql_fetch_array(mssql_query("select isnull(sum(tover),0)as ttl from j2365join_transaction where player = '".$data1[$k]."' and pdate >= '".$time["paycom_date"]."'"));
                        				/*$comm = strtolower($type)."_refcomm";
                        				$hasilcom = mssql_fetch_array(mssql_query("select isnull(($comm),0) as ttl from u6048user_dataref where userid = '".$data1[$k]."'"));
                        				$commison[$k] = ($tover[$k]["ttl"]*$hasilcom["ttl"])/100;*/
                        				if ($user_id["joindate"]== null)break;
                        				$subtotal += $tover[$k]["ttl"];
                        				$subcomm += $commison[$k];
                        			?>
                        				<tr  class="form-text">
                        			        <td style="color:white;"><span><?php echo"".$k."";?></span></td>
                        			        <td style="color:white;"><span><?php echo"".$data1[$k]."";?></span></td>
                        			        <td style="color:white;"><span><?php echo"".sqlfdate ($user_id["joindate"])."";?></span></td>
                        			        <td style="color:white;"><span><?php echo"".currx($tover[$k]["ttl"])."";?></span></td>
                        			        <td style="color:white;"><span><?php echo"".currx($commison[$k])."";?></span></td>
                        			    </tr>
                        			<?php
                        			}
                        			?>
                        			<tr  class="form-text">
                        			        <td colspan=3 align=right style="color:white;"><span>SubTotal </span></td>
                        			        <td style="color:white;"><span><?php echo"".currx($subtotal)."";?></span></td>
                        			        <td style="color:white;"><span><?php echo"".currx($subcomm)."";?></span></td>
                        			</tr>
                        			<tr  class="form-text">
                        			        <td colspan=3 align=right style="color:white;"><span>Grand Total</span></td>
                        			        <td style="color:white;"><font color="red"><?php echo"".currx($grand)."";?></font></td>
                        			        <td style="color:white;"><span><?php echo"".currx($grandcomm)."";?></span></td>
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