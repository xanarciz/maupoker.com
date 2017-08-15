<?php
	require_once("meta.php");
	if (!$_SESSION["login"]){
		echo "<script>window.location = 'index.php'</script>";
		die();
	}
	if (!$_GET["id"]){
		die();
	}
	$id = $_GET["id"];
	if ($id > 0){
		$data_memo = sqlsrv_fetch_array(sqlsrv_query($sqlconn_db2, "select id,mfrom,msubject,mbody from j2365join_memo where id = '".$id ."' and (mfrom = '".$login."' or mto = '".$login."')"), SQLSRV_FETCH_ASSOC);
		$data_memo["mbody"]=str_Replace("<script","<scrpt",$data_memo["mbody"]);
		$data_memo["msubject"]=str_Replace("<script","<scrpt",$data_memo["msubject"]);
		sqlsrv_query($sqlconn_db2, "update j2365join_memo set mread='1' where id = '".$data_memo['id']."'");
	}
?>

        <!--CONTENT-->
        <div class="box">
            <div style="width:620px;min-height:400px;font-family:Britannic bold,Britannic;">
            	<div id="memo" style="float:left;width:620px;">
            		<div class="sidebar-box" align="left">
                    	<div style="font-family:Britannic bold,Britannic;"><font size=4 style="color:#fff;">Memo</font></div>
                    	<div class="line"></div>
						<?php 
						if($data_memo['id'] ){
						?>
    					<input type="hidden" name="admin" value="<?php if(isset($param)) echo $param; ?>" />
    					<table cellpadding="0" cellspacing="0" border="0" style="font-family:tahoma;font-size:12px;color:#fff;">
    						<tr>
    							<td width="100">From</td>
    							<td width="10">:</td>
    							<?php
    								if($data_memo["mfrom"] == $login){
    									$op=$data_memo["mfrom"];
    								}else{
    									$op="Operator";
    								}
    							?>
    							<td><?php echo $op;?></td>
    						</tr><tr><td height="5"></td></tr>
    						<tr>
    							<td width="100">Subject</td>
    							<td width="10">:</td>
    							<td><?php echo $data_memo["msubject"];?></td>
    						</tr><tr><td height="5"></td></tr>
    						<tr valign="top">
    							<td >Message</td>
    							<td >:</td>
    							<td>
    								<?php
    									$memo = explode("##quote##",$data_memo["mbody"]);

    									echo $memo[0];
    									echo "<br>".$memo[1];
    								?>
    							</td>
    						</tr><tr><td height="5"></td></tr>
    					</table>
						<?php 
						}else{
							echo "<h2><center><font color='red'>NO FOUND</font></center></h2>";
						}
						?>
    					<div style="height:5px;"></div><div style="height:10px;border-top:1px dotted #555555;"></div>
            	    </div>
                </div>
            </div>
        </div>
	