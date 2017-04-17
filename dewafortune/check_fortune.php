<?PHP
include("../config.php");
	$status = 0;
	$result = array();
	//$request = $this->input->post(NULL, TRUE);

	if(isset($_POST['sessid']) && !empty($_POST['sessid']))
	{
		$q = sqlsrv_query($sqlconn,"SELECT sessid FROM u6048user_active WHERE sessid = '".$_POST['sessid']."'",$params, $options);
		$r = sqlsrv_num_rows($q);
		if($r > 0)
			$status = 1;
	}
	$result['status'] = $status;
	echo json_encode($result);

?>