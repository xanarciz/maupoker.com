<?php 

$banner_id = $_GET["bi"];
$game_code = strtoupper($_GET["gc"]);
$ref_id = $_GET["ri"];

setcookie("bi", $banner_id, time() + (86400 * 30), "/"); // 86400 = 1 day
setcookie("gc", $game_code, time() + (86400 * 30), "/"); // 86400 = 1 day
setcookie("ri", $ref_id, time() + (86400 * 30), "/"); // 86400 = 1 day

header('Location: index.php');