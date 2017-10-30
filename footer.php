		<script language="JavaScript" type="text/javascript">
			function PopupCenter(url, title, w, h) {
				// Fixes dual-screen position                         Most browsers      Firefox
				var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
				var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;

				var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
				var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

				var left = ((width / 2) - (w / 2)) + dualScreenLeft;
				var top = ((height / 2) - (h / 2)) + dualScreenTop;
				var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

				// Puts focus on the newWindow
				if (window.focus) {
					newWindow.focus();
				}
			}
		</script>
		
		<div id="footer">
			<div class="container">
				<div class="disclaimer">
					<?php echo $footer_txt; ?>
				</div>

				<div class="copyright">
					<span>
						<a href="#" onclick="PopupCenter('terms.php','xtf','1000','800');" title="Terms & Conditions" style="margin-right: 6px; color: #69c6e6; text-decoration:none;">Terms & Conditions</a> 
						<a href="link_alternatif.php" style="margin-right: 6px; color: #69c6e6; text-decoration:none;">Link Alternatif</a>
						<a href="video-promotion.php" style="margin-right: 6px; color: #69c6e6; text-decoration:none;">Video Tutorial</a>
						</br> &copy; Copyright <?php echo date("Y")." ". $dmn[1].".".$dmn[2]?> - All right reserved.
					</span>
				</div>
			</div>
		</div>
		
        </div>
		 <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/widget.css">
        <div id="fb-root"></div>
        <!--<div class="audio-container">
          <div class="radio-widget">
            <div class="audio-title" onclick="playToggle()"><span>Dewa.FM</span></div>
            <div class="audio-control">
              <label class="switch">
                <input id="chkChannel" type="checkbox" class="switch-input" checked>
                <span class="switch-label" data-on="128kb" data-off="32kb"></span>
                <span class="switch-handle"></span>
              </label>
              <a id="audioPlayToggle" class="play-btn" onclick="playToggle()">
                <span class="fa-stack fa-lg">
                  <i class="fa fa-circle fa-stack-2x"></i>
                  <i class="fa fa-play fa-stack-1x"></i>
                </span>
              </a>
              <a class="popup" href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Fdewa.fm%2F&amp;src=sdkpreparse">
                <img src="assets/img/facebook.png" />
              </a>
              <a class="tweet share-btn popup" href="javascript:void(0);" data-url="https://dewa.fm" data-via="radio_dewafm" data-text="Lagi dengerin lagu di Radio kita semua" data-hashtags="dewafm">
                <img src="assets/img/twitter.png" />
              </a>
            </div>
          </div>
          <audio id="mediaplayer" preload="none" src="http://180.210.204.202:8090/;stream.mp3">Your browser does not support this player.</audio>
        </div>-->
        <script src="assets/js/widget.js"></script>

    </body>
</html>