<link href="../assets/mobile-style/<?php echo $link_img;?>/style.css" rel="stylesheet" type="text/css">
<body>
<!--
<div id="preloader">
	<div id="status">
    	<p class="center-text">
			Loading the content...
            <em>Loading depends on your connection speed!</em>
        </p>
    </div>
</div>
-->
<div class="all-elements">

    <?php include("_sidebar.php");?>

    <div id="content" class="page-content" data-snap-ignore="true">

    	<div class="page-header">
        	<a href="#" class="deploy-sidebar"></a>
            <div class="header-logo" style="background: url(../assets/img/<?php echo $link_img;?>/imgAll.png) 0px -25px no-repeat; background-size:auto 90px; background-position:top; "></div>
            <?php if (!$_SESSION["login"]){ ?>
            <a href="#login_panel" class="deploy-login cboxElement"></a>
            <?php }else{ ?>
            <a href="../logout.php" class="deploy-logout"></a>
            <?php } ?>
        </div>

        <?php if (!$_SESSION["login"]){ ?>
        <div class="login_box">
            <div id="login_panel">
        	    <div class="container no-bottom">
                	<h3>Log In</h3>
                </div>

                <div class="decoration"></div>

                <form method="post" action="index.php">

                    <div class="form-group">
                        <input id="username" class="contactField" type="text" name="entered_login" value="Username" placeholder="Username" onblur="if(this.value == '') { this.value='Username'}" onfocus="if (this.value == 'Username') {this.value=''}" required />
                    </div>

                    <div class="form-group">
                        <input id="j_plain_password" class="contactField" type="password" name="entered_password" value="Password" placeholder="Password" onblur="if(this.value == '') { this.value='Password'}" onfocus="if (this.value == 'Password') {this.value=''}" required />
                    </div>

                    <div class="form-group">
                        <input id="membervalidation" class="contactField" type="text" name="entered_val" placeholder="Validation" value="Validation" autocomplete="off" maxlength="5" onClick="this.value=''" onBlur="if(this.value == '') { this.value='Validation'}" onFocus="if (this.value == 'Validation') {this.value=''}" required />
                        <div style="height:10px;"></div>
                        <img src="../captcha/captcha-login.php?.png" alt="Validation Code" title="Validation Code" width="120" height="30" style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px;"/>
						<input type="hidden" name=mobile value='1'>
				  </div>

                    <!--<input id="mobile" type="hidden" name="mobile" value="mobile"  />-->

                    <div class="formSubmitButtonErrorsWrap">
                        <input type="submit" name="submit" class="buttonWrap button button-reds contactSubmitButton" value="LOG IN" value="1" />
                    </div>

                    <div class="decoration"></div>
					<?php
					$forget_password = array("XCCAA" , "XRBAA" , "XNKAA", "XNDAA", "XURAA", "AXHQAA", "AXCGAA","XNIAA","AXNGAA","XJZAA","XJGAA","AXLXAA","AXMVAA","AXNWAA");
					if (!in_array($agentwlable , $forget_password)){
					?>
                    <a class="forgot_pass" href="forget-password.php">Lupa Password?</a>
					<?php
					}
					?>
            	    <a class="new_register" href="daftar.php">Daftar Baru</a>

                </form>

        	</div>
        </div>
        <?php } ?>

        <div class="page-header-clear"></div>
