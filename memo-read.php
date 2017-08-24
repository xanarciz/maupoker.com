<?php
include_once("config.php");
require_once($cfgProgDir."secure.php");

if(! isset($_SESSION['login']) || $_SESSION['login'] == ''){
    echo "<script>window.location = 'index.php'</script>";
    die();
}

if (!$_GET["id"]){
    die();
}
$type = $_GET['typ'];

if($type == 1){
    $mfrom = 'Operator';
    $mto = $login;
}else{
    $mfrom = $login;
    $mto = 'Operator';
}

$id = $_GET["id"];
if ($id > 0){
    $reqAPIMemoRead = array(
        "auth"      => $authapi,
        "userid" 	=> $login,
        "id" 		=> $id,
        "type"		=> 2,
    );
    $respMemoRead = sendAPI($url_Api."/memo",$reqAPIMemoRead,'JSON','02e97eddc9524a1e');
    if($respMemoRead->status != 200){
        $error = 1;
        $errorReport = "<div class='alert alert-danger' style='margin-left: 0px;'>" . $respMemoRead->msg . "</div>";
    }
    $respMemoRead->resp->mbody 		= str_Replace("<script","<scrpt",$respMemoRead->resp->mbody);
    $respMemoRead->resp->msubject 	= str_Replace("<script","<scrpt",$respMemoRead->resp->msubject);
    $memo = explode("##quote##",$respMemoRead->resp->mbody);
    $bodyMemo = implode('&#13;&#10;', $memo);
}

?>

        <!--CONTENT-->
		<script type="text/javascript" src="assets/js/jquery.min.js"></script>
		<div class="modal-header">
			<span class="close">&times;</span>
			<h2>Baca Memo</h2>
		</div>
		<div class="modal-body">
        <div class="box">
            <div style="width:620px;min-height:400px;font-family:Britannic bold,Britannic;">
            	<div id="memo" style="float:left;width:620px;">
            		<div class="sidebar-box" align="left">
                    	<div style="font-family:Britannic bold,Britannic;"><font size=4 style="color:#fff;">Memo</font></div>
                    	<div class="line"></div>
						<?php 
						if($id ){
						?>
						<center><div class="res" id="res_memo"><?php echo $errorReport?></div></center>
						<input type="hidden" name="memtok" value="<?php echo $id?>" />
    					<!--input type="hidden" name="admin" value="<?php if(isset($param)) echo $param; ?>" /-->
    					<table cellpadding="0" cellspacing="0" border="0" style="font-family:tahoma;font-size:12px;color:#fff;">
    						<tr>
    							<td width="100">From</td>
    							<td width="10">:</td>
    							<td><?php echo $mfrom;?></td>
    						</tr>
							<tr><td height="5"></td></tr>
							<tr>
    							<td width="100">To</td>
    							<td width="10">:</td>
    							<td><?php echo $mto;?></td>
    						</tr>
							<tr><td height="5"></td></tr>
    						<tr>
    							<td width="100">Subject</td>
    							<td width="10">:</td>
    							<td><?php echo $respMemoRead->resp->msubject;?></td>
    						</tr><tr><td height="5"></td></tr>
    						<tr valign="top">
    							<td >Message</td>
    							<td >:</td>
    							<td>
    								<?php
    									echo $bodyMemo;
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
		</div>
		<script language="JavaScript" type="text/javascript">
            jQuery(document).ready(function(){
                setform("form_memo", "res_memo");
            })
			
			$('.close').click(function () {
				var modal = $(this).parent().parent().parent();
				modal.css('display', 'none');
				$('#Modal .modal-content').html('');
			});
		</script>
	