<?php
include("meta_lobby.php");

$q=sqlsrv_fetch_array(sqlsrv_query($sqlconn,"select userpass from u6048user_id where loginid='".$login."'"),SQLSRV_FETCH_ASSOC);
$passx = $q["userpass"];

$salt ='heilhitler';
function simple_encrypt($text){
	return trim(base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, $salt, $text, MCRYPT_MODE_ECB, mcrypt_create_iv(mcrypt_get_iv_size(MCRYPT_RIJNDAEL_256, MCRYPT_MODE_ECB), MCRYPT_RAND))));
}

$login = simple_encrypt($login);
//$key = simple_encrypt($key);
$subwebid = simple_encrypt($subwebid);
?>	
		<body>
			<link rel="stylesheet" type="text/css" href="lobby/css/style.css">
         
                <div class="container" style="background:#262626;border:none;">
                    <div class="wrap" style="background:#262626;border:none;">
                        <div class="full" style="background:#262626;border:none;">
                            <div style="background:url(lobby/img/lobby_inside_header.png) no-repeat;width:980px;height:50px;margin-left:10px;border:none;">
                                <center><h1 class="participant-h" style="font-family:Helvetica,Roboto,Arial,sans-serif;font-size:33px;color:#b3b3b3;padding-top:7px;">CHANGE AVATAR</h1></center>
                            </div>
							<div class="body-wrap" style="background:#262626;border:none;">
								<iframe src="<?php echo $path;?>/wl/change-avatar_lobby.php?log=<?php echo"".$login."";?>&key=<?php echo"".$passx.""; ?>&subweb=<?php echo"".$subwebid.""; ?>&domain=<?php echo"".$_SERVER['SERVER_NAME'].""; ?>" class="iframe-change-avatar" scrolling="no" style='height:700px;padding-bottom:75px;'></iframe>
                            </div>
                        </div>
                    </div>
        
                </div>
  
			</body>
            </html>
          