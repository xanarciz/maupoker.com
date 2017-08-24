<?php
include("config.php");
include("config.inc.php");
?>
<html>
	<link rel="shortcut icon" href="assets/img/<?php echo $link_img;?>/favicon.ico" />
	<link rel="apple-touch-icon-precomposed" href="assets/img/<?php echo $link_img;?>/apple-touch-icon-precomposed.png">

	<!-- Stylesheet -->
	<link rel="stylesheet" href="assets/css/normalize.css">
	<link rel="stylesheet" href="assets/css/main.css">
	<link rel="stylesheet" href="assets/css/<?php echo $link_img;?>.css">
	<body>
	<center><div class="logo-rules"><a href="#"></a></div></center>
	<div class="center">
		<?php
		if (isset($_GET["tekan"]))
			$tekan = $_GET["tekan"];

		if($tekan == "Setuju"){
			echo "<script>document.location='menu.php'</script>";
		}

		if($tekan == "Tidak Setuju"){
			echo "<script>document.location='logout.php'</script>";
		}
		$term = str_replace("\r\n","<br>",$infoweb["rules_text"]);
		//die($term);
		?>
		<center>
			<div class="content-rules">
                <div class="full">
                    <div class="head-wrap">
                        <h1 class="mar_left_30">General Rules</h1>
                    </div>

                    <div class="body-wrap">
						<!--<script language="javascript" type="text/javascript" src="http://www.indoads.xyz/mangga.php?id=95&ref_id=416"></script>-->
						<h3 class="mar_left_30" align="left" style="margin-top:10px;">News</h3>
						<style>
						.newss {background:#777777;display:block;margin-bottom:5px;padding:10px;border-radius:4px;}
						.newss:hover {background:#999999;}
						</style>
						<div id="feed" align="justify" style="width:800px;height:auto;padding-right:15px;margin-bottom:30px;">
							<script type="text/javascript" src="https://www.google.com/jsapi"></script>
							<script type="text/javascript">

							    google.load("feeds", "1");

							    function initialize() {
							      var feed = new google.feeds.Feed("http://abcdeh.com/category/update/feed");
							      feed.load(function(result) {
							        if (!result.error) {
							          var container = document.getElementById("feed");
							          var html = '';

							          for (var i = 0; i < 3; i++) {
							            var entry = result.feed.entries[i];
							            html += '<a href="' +entry.link+ '" target="blank">';
							            html +=	'<div class="newss">';
							            html +=	'<span style="font-size:20px;font-weight:bold;">' + entry.title + '</span>';
							            html +=	'<span style="float:right;font-style:italic;">' + entry.publishedDate + '</span><br />';
							            html +=	'<span style="color:white;">' + entry.contentSnippet + '<span style="color:yellow;font-style:italic;">Info lengkap</span>';
							            html +=	'</div>'
							            html +=	'</a>';
							          }
							          container.innerHTML = html;
							        }
							      });
							    }
							    google.setOnLoadCallback(initialize);

						    </script>
						</div>
						<h3 class="mar_left_30" align="left">General Rules</h3>
						<table align=center cellpadding=3 cellspacing=2 width="800">
							<tr>
								<td width=100%>
									<table border=0 width=100% align=center cellpadding=0 cellspacing=0>
										<form method=get>
										<tr><td colspan=2 bgcolor="" border=1>
										<div align="justify" style="max-height:350px;overflow-y:auto;padding-right:15px;"><font face=tahoma size=2><?php echo $term; ?></font></div></td>
										</tr>
											<tr>
												<td colspan=2 bgcolor="">&nbsp;</td>
											</tr>
											<tr>
												<td width=50% align=center><input class="btn btn-write" type=submit name=tekan value="Setuju"></td>
												<td align=center><input class="btn btn-login" type=submit name=tekan value="Tidak Setuju"></td>
											</tr>
										</form>
									</table>
								</td>
							</tr>
						</table>
					</div>
                </div>
			</div>
		</center>
	</div>
	<!-- <body background="images/bg3.gif"> -->
	</body>
</html>