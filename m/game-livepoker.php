<?php
$page='live-poker';
session_start();
$login = $_SESSION["login"];

if (!$login){
  include("_meta.php");
} else {
  include("_metax.php");
}

include("_header.php");

?>

  <div class="content bmargin-50">
    <div class="img-fluid-game live-poker"></div>
    <div style="position:relative">
      <div class="row tpadding-320"></div>
      <div class="row tpadding-0"></div>

      <div class="row padding-15 game-btn">
        <div class="gbtn-1">
      		<a href="download.php">
                <input class="btn btn-blue" value="DOWNLOAD" type="button" />
      		</a>
        </div>
        <div class="gbtn-2">
          <?PHP
            if(!$login){
              echo '<input class="btn btn-green" value="DAFTAR" type="button" onclick="location.href=\'daftar.php\'" />';
            }else{
              echo '<input class="btn btn-green" value="DEPOSIT" type="button" onclick="location.href=\'deposit.php\'" />';
            }
          ?>
        </div>
      </div>

    </div>
  </div>

  <?php include ("_footer.php"); ?>