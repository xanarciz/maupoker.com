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
			<div class="contacts">
				<div class="listcp">
			         <?php
            foreach ($infoweb['contact_agent'] as $contact => $value) {
                if($value != ''){
                    switch ($contact){
                        case 'yahoo': $href = 'ymsgr:sendIM?'.$value; break;
                        case 'skype': $href = 'skype:'.$value; break;
                        case 'facebook': $href = 'https://www.facebook.com/'.$value; break;
                        case 'twitter': $href = 'https://twitter.com/'.$value; break;
                        default: $href = 'javascript:void(0);'; break;
                    }

                ?>
                    <div class='listcp-black'>
                    	<div class="icon"><img src="assets/images/contact-icon/<?php echo $contact; ?>-icon.png"></div>
                    	<div class="value"><a href="<?php echo $href; ?>">
                    		<?php echo $value; ?>
						</a></div>
                    </div>

                <?php
                }
            }
            ?>
            		<div class='listcp-black'>
            			<a href="contact.php" align="left">
                    	<div class="icon"><img src="assets/images/contact-icon/more-icon.png"></div>
                    	<div class="value">More...</div>
                    	</a>
                    </div>
			    </div>
			</div>
			<div class="contacts2">
				<div class="container" style="width: auto;">
					<?php
					    if($infoweb['bank_Active'] == 1){
					    ?>
					         <div class="listbank">
					            
					                <?php
					                foreach ($infoweb['bankList'] as $bank){
					                    $statusBnk = $bank['statAgent'] == 1 ? 'online' : 'offline';
					                    echo "
					                            <div class='listbank-black'>
					                                <div class='" . $statusBnk . "'></div>
					                                <div class='".strtolower($bank['bank'])."'></div>
					                            </div>
					                          ";
					                }
					                ?>
					            
					        </div>
					    <?php
					    }
					  	
				    ?> 
				</div>
			</div>
			<div class="container">				
				<div class="disclaimer">
					<ul class="license-icon">
                <li><a href="http://idnplay.com/certificate/BMM_EN.html" target="blank"><img src="assets/images/license/bmm-logo.png" width="98px" height="16px" alt="BMM Certified"></a></li>
                <li><a href="http://pagcor.ph" target="blank"><img src="assets/images/license/pagcorlogo.png" alt="PAGCOR"></a></li>
            </ul>
					<?php echo $footer_txt; ?>
				</div>

				<div class="copyright">
					<span>
						</br> &copy; Copyright <?php echo date("Y")." ". $dmn[1].".".$dmn[2]?> - All right reserved.
					</span>
				</div>
			</div>
		</div>
		
        </div>

    </body>
</html>