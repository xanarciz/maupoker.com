<div class="footer">
  <div class="custom-navbar ui-navbar">
    <ul class="ui-grid-c">
      <li class="ui-block-a">
        <a href="index.php" class="ui-nodisc-icon ui-link ui-btn ui-icon-custom ui-btn-icon-top">
          <i class="fa fa-home fa-3x"></i>
          <br/> HOME
        </a>
      </li>

      <?PHP
        if($_SESSION["login"]){
      ?>

      <li class="ui-block-b">
        <a href="deposit.php" class="ui-nodisc-icon ui-link ui-btn ui-icon-custom ui-btn-icon-top">
          <i class="fa fa-deposit-square fa-3x"></i>
          <br/> DEPOSIT
        </a>
      </li>

      <?PHP
        }else{
      ?>

      <li class="ui-block-b">
        <a href="daftar.php" class="ui-nodisc-icon ui-link ui-btn ui-icon-custom ui-btn-icon-top">
          <i class="fa fa-pencil-square fa-3x"></i>
          <br/> DAFTAR
        </a>
      </li>

      <?PHP
        }
      ?>

      <li class="ui-block-b">
        <a href="promosi.php" class="ui-nodisc-icon ui-link ui-btn ui-icon-custom ui-btn-icon-top">
          <i class="fa fa-gift fa-3x"></i>
          <br/> PROMOSI
        </a>
      </li>
      <li class="ui-block-c">
        <a href="#" class="ui-nodisc-icon ui-link ui-btn ui-icon-custom ui-btn-icon-top" onclick="window.open('https://chat1c.livechatinc.com/licence/<?php echo $lisence;?>/open_chat.cgi?lang=en&amp;groups=0&amp;'+'dc='+escape(document.cookie+';l='+document.location+';r='+document.referer+';s='+typeof lc_session),'Czat_4225581','width=530,height=520,resizable=yes,scrollbars=no,status=1');return false;">
          <i class="fa fa-comments fa-3x"></i>
          <br/> LIVE CHAT
        </a>
      </li>
    </ul>
  </div>
</div>

<?php
    if(!$_SESSION["login"]){
        include "loginmodal.php";
    }

    if ($balanceProblem){
        echo "<script>uialert('Masalah balance<br> Hubungi operator anda');</script>";
    }
?>

</div> <!-- END OF ALL ELEMENT -->
</div> <!-- END OF CONTENT -->
</body>
</html>