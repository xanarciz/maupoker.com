<?php
	require_once("meta.php");
	if (!$_SESSION["login"]){
		echo "<script>window.location = 'index.php'</script>";
		die();
	}
	
	if (!$_SESSION["login"]){
		echo "<script>window.location = 'index.php'</script>";
		die();
	}
	if (!$_GET["id"]){
		die();
	}
	$id = $_GET["id"];
	if ($id > 0){
		$data_memo_old = sqlsrv_fetch_array(sqlsrv_query($sqlconn_db2, "select mbody,msubject from j2365join_memo where id = '".$id."'"), SQLSRV_FETCH_ASSOC);
	}

?>

        <!--CONTENT-->
        <div class="box">
            <div style="width:620px;min-height:620px;">
            	<div id="memo" style="float:left;width:620px;">
            		<div class="sidebar-box" align="left">
                    	<div style="font-family:Britannic bold,Britannic;"><font size=4 style="color:#fff;">COMPOSE MEMO</font></div>
                    	<div class="line"></div>
    					<?php
    					if ($error == 1){
    						echo "<font color=red>".$errorReport."</font>";
    					}
    					?>
    					<center><div class="res" id="res_memo"></div></center>
    					<form method="post" action="memo-send-reply.php" id="form_memo" style="color:#fff;">
    						<input type=hidden name="id" value="<?php echo $id;?>">
                    		<input type="hidden" name="admin" value="<?php if(isset($param)) echo $param; ?>" />
                    		<table cellpadding="0" cellspacing="0" border="0" style="font-family:tahoma;font-size:12px;">
    							<tr>
                    		        <td width="100">From</td>
                    				<td width="10">:</td>
                    				<td><?php echo $login;?></td>
                    		    </tr><tr><td height="5"></td></tr>
                    		    <tr>
                    		        <td width="100">Subject</td>
                    				<td width="10">:</td>
                    				<td><?php echo $data_memo_old["msubject"]; ?></td>
                    		    </tr><tr><td height="5"></td></tr>
                    		    <tr valign="top">
                    		        <td style="padding-top:5px;">Message</td>
                    				<td style="padding-top:5px;">:</td>
                    				<td>
                    					<textarea style="width:400px;height:150px;color:#000;" name="descr"></textarea>
                    				</td>
                    		    </tr><tr><td height="5"></td></tr>
    							<tr valign="top">
                    		        <td >Quote</td>
                    				<td >:</td>
                    				<td>
                    					<?php
    									$memo = explode("##quote##",$data_memo_old["mbody"]);
    									echo $memo[0];
    									echo "<br>".$memo[1];
    								?>
                    				</td>
                    		    </tr><tr><td height="5"></td></tr>
                    		</table>

                    		<div style="height:5px;"></div><div style="height:10px;border-top:1px dotted #555555;"></div>
                    		<div align="center">

                    			<div style="height:10px;"></div>
                    			<button type="submit" name="submit" value="SUBMITS" class="btn btn-submit">Submit</button>
                    		</div>
                    	</form>

                    	<script language="JavaScript" type="text/javascript">
                    		jQuery(document).ready(function(){
                    			setform("form_memo", "res_memo");
                    		})
                    	</script>
                    </div>
            	</div>
            </div>
        </div>