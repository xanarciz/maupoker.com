<?php
	require_once("_meta.php");
	require_once("_header.php");
	if (!$_SESSION["login"]){
		echo "<script>window.location = 'index.php'</script>";
		die();
	}
?>

        <!--CONTENT-->
        <div style="height:10px;"></div>
        <div id="memo" style="width:980px;">
        	<div style="float:left;width:650px;">
        		<div class="sidebar-box" align="left">
                	<h2>Memo</h2>
                	<div class="line"></div>
					<form action="#" method="post" id="form_memo" style="color:#fff;">
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
                				<td><input type="text" class="textbox" style="width:400px;text-transform:uppercase;color:#000;" name="title" value="" /></td>
                		    </tr><tr><td height="5"></td></tr>
                		    <tr valign="top">
                		        <td style="padding-top:5px;">Description</td>
                				<td style="padding-top:5px;">:</td>
                				<td>
                					<textarea style="width:400px;height:200px;color:#000;" name="descr"></textarea>
                				</td>
                		    </tr><tr><td height="5"></td></tr>
                		</table>
                		<div style="height:5px;"></div><div style="height:10px;border-top:1px dotted #555555;"></div>
                		<div align="center">
                			<div class="res" id="res_memo"></div>
                			<div style="height:10px;"></div>
							<input type="image" src="assets/img/<?php echo $link_img;?>/submit.jpg" name="submit" value="Submit!" />
                			
                		</div>
                	</form>
                	<script language="JavaScript" type="text/javascript">
                		jQuery(document).ready(function(){
                			setform("form_memo", "res_memo");
                		})
                	</script>
                </div>
        	</div>
            <div style="float:right;width:280px;">
                <!--LOGIN PANEL-->
      			<?php include("side-bar-profil.php");?>
      			<!--LIVE CHAT-->
        	</div>
        </div>
        <div style="clear:both;height:10px;"></div>
        <!--CONTENT-->

       <?php include("_footer.php");?>