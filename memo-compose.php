<?php
	$page = "memo";
	require_once("meta.php");
	if (!$_SESSION["login"]){
		echo "<script>window.location = 'index.php'</script>";
		die();
	}
?>

		
        <!--CONTENT-->
        <div class="box">
            <div style="width:620px;min-height:430px;">
            	<div id="memo" style="float:left;width:600px;">
            		<div class="sidebar-box" align="left">
                    	<div style="font-family:Britannic bold,Britannic;"><font size=4 style="color:#fff;">COMPOSE MEMO</font></div>
                    	<div class="line"></div>
    					<?php
    					if ($error == 1){
    						echo "<font color=red>".$errorReport."</font>";
    					}
    					?>
    					<center><div class="res" id="res_memo"></div></center>
    					<form method="post" action="memo-send-message.php" id="form_memo" style="color:#003642;">
                    		<input type="hidden" name="admin" value="<?php if(isset($param)) echo $param; ?>" />
                    		<table cellpadding="0" cellspacing="0" border="0" style="color:#fff;">
    							<tr>
                    		        <td width="100">From</td>
                    				<td width="10">:</td>
                    				<td><?php echo $login;?></td>
                    		    </tr><tr><td height="5"></td></tr>
                    		    <tr>
                    		        <td width="100">Subject</td>
                    				<td width="10">:</td>
                    				<td><input type="text" class="textbox" style="width:400px;text-transform:uppercase;color:#000;" name="title" value="" /></td>
                    		    </tr><tr><td height="5"></td></tr>
                    		    <tr valign="top">
                    		        <td style="padding-top:5px;">Message</td>
                    				<td style="padding-top:5px;">:</td>
                    				<td>
                    					<textarea style="width:400px;height:200px;color:#000;" name="descr"></textarea>
                    				</td>
                    		    </tr><tr><td height="5"></td></tr>
                    		</table>

                    		<div style="height:5px;"></div><div><hr></div>
                    		<div align="center">

                    			<div style="height:10px;"></div>
    							<button type="submit" name="submit" value="SUBMITS" class="btn btn-submit">Submit</button>

                    		</div>
							<script language="JavaScript" type="text/javascript">
								jQuery(document).ready(function(){
									setform("form_memo", "res_memo");
								})
							</script>
                    	</form>
                    </div>
            	</div>
            </div>
        </div>