<!-- ui-dialog -->
<div id="dialog" title="Member Login" data-inset="false" >
	<form method="post" action="index.php" id="frmlgn">
		<label>Username</label>
		<input type="text" class="form-control bg-light-gray user-form" id="username" name="entered_login" value="Username" placeholder="Username" onblur="if(this.value == '') { this.value='Username'}" onfocus="if (this.value == 'Username') {this.value=''}" autocomplete="off" required />

		<label>Password</label>
		<input type="password" class="form-control bg-light-gray password-form" id="j_plain_password" name="entered_password" value="Password" placeholder="Password" onblur="if(this.value == '') { this.value='Password'}" onfocus="if (this.value == 'Password') {this.value=''}" required />

		<label>Validation</label>
		<div class="row margin0">
			<div class="col-lg-6">
				<input type="text" class="form-control bg-light-gray validation-form" id="membervalidation" name="entered_val" value="Validation" placeholder="Validation" autocomplete="off" onClick="this.value=''" onBlur="if(this.value == '') { this.value='Validation'}" onFocus="if (this.value == 'Validation') {this.value=''}" required />				
			</div>
			<div class="col-lg-6">
		        <img src="../captcha/captcha-login.php?.png" alt="Validation Code" title="Validation Code" width="130" height="34" style="-moz-border-radius:4px;-webkit-border-radius:4px;-khtml-border-radius:4px; border-radius:4px; margin-left: 7px;"/>
		        <input type="hidden" name=mobile value='1'>
			</div>
		</div>

		<div class="row tmargin-5">
			<input type="submit" name="sub" class="btn btn-green" value="LOG IN" value="1">
		</div>

		<div class="row tmargin-5" align="center">
			<p class="light-gray">Lupa Akun Anda? <a href="forget-password.php" class="blue">Reset Password</a></p>
		</div>
	</form>
</div>