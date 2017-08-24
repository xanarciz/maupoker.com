<?php
include_once("../config.php");
$id = $_GET['id'];
$data_memo = $infoweb['newsAgent'][$id];
?>

<!-- ui-dialog -->
	<div class="row">
		<div class="col-lg-3"><?php echo str_replace('id_', '', $id); ?></div>
		<div class="col-lg-1">:</div>
		<div class="col-lg-8">OPERATOR</div>
	</div>
	<div class="row">
		<div class="col-lg-3">SUBJECT</div>
		<div class="col-lg-1">:</div>
		<div class="col-lg-8"><?php echo $data_memo["title"]; ?></div>
	</div>
	<div class="row">
		<div class="col-lg-3">MESSAGE</div>
		<div class="col-lg-1">:</div>
		<div class="col-lg-8"><?php echo $data_memo["berita"];?></div>
	</div>