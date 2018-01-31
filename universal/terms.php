<?php
function getBaseUrl() {
    $currentPath = $_SERVER['PHP_SELF'];
    $pathInfo = pathinfo($currentPath);
    $hostName = $_SERVER['HTTP_HOST'];
    $protocol = strtolower(substr($_SERVER["SERVER_PROTOCOL"],0,5))=='https'?'https':'http';
    return $protocol.'://'.$hostName.$pathInfo['dirname']."/";
}
?>

	<iframe src="https://docs.google.com/gview?url=<?php echo getBaseUrl(); ?>universal/terms-id.pdf&embedded=true" style="width:100%; height:100%;" frameborder="0"></iframe>