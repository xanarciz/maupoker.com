<?PHP
include("../config.php");
	$status = 0;
	$result = array();
	//$request = $this->input->post(NULL, TRUE);

	if(isset($_POST['sessid']) && !empty($_POST['sessid']))
	{
        $reqAPIActive = array(
            "auth" 	 => $authapi,
            "type"   => 2,
            "sessid" => $sess,
        );

        $responseActive = sendAPI($url_Api."/checkUserActive",$reqAPIActive,'JSON','02e97eddc9524a1e');
        $status = 0;
        if($responseActive->status == 200){
            $status = 1;
        }
	}
	$result['status'] = $status;
	echo json_encode($result);

?>