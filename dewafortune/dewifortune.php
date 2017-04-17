<!DOCTYPE html>
<html>
<head>
	<title>Dewafortune</title>
	<style type="text/css">
		*{ margin: 0; padding: 0; }
		iframe{ position: absolute; width: 100%; height: 100%; border: none; }
	</style>
</head>
<body>
	<iframe src="dewafortune.php?f=popup_direct&codeAccess=<?PHP echo $_REQUEST['codeAccess'];?>"></iframe>
	<script type="text/javascript">
		$(function(){
			if(window.opener==null){
				top.window.location.href = '';
			}

			
			<?php if(!$_GET['codeAccess']): ?>
				parent.window.close();
			<?php endif; ?>
		});
	</script>
</body>
</html>