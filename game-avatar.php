	<?php
include("meta.php");
include("header.php");

$string = $login.",".$userpass.",".$subwebid.",".$_SERVER["SERVER_NAME"];
$encrypt = urlencode( base64_encode( $string ) );
?>
<div id="content">
    <div class="container">
        <div class="clear space_30"></div>
        <div class="wrap">
            <div class="full">
                <div class="head-wrap">
                    <h1>Ganti Avatar</h1>
                </div>
                <div class="body-wrap">
                    <iframe src="<?php echo"".$path."";?>/wl/change-avatar.php?id=<?php echo"".$encrypt."";?>" class="iframe-change-avatar" scrolling="no"></iframe>
                </div>
            </div>
        </div>
        <div class="clear space_30"></div>
    </div>
</div>

<?php include("footer.php");?>