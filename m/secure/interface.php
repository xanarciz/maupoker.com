<?php 
if(isset($game)!=''){
$game="";
echo "<script>  self.document.location='../index.php' </script>";
}
if(!isset($DalamGame)){$DalamGame = '';}
include($DalamGame.$loginurl);
?>
