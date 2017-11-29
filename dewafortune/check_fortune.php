<?PHP
include("../config.php");
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL);
$dataPOST = trim(file_get_contents('php://input'));
$xmlData = json_decode($dataPOST);

	$status = 0;
	$result = array();
	//$request = $this->input->post(NULL, TRUE);
 $reqAPIActive = array(
            "auth" 	 => $authapi,
            "type"   => 2,
            "sessid" => $xmlData->sessid,
        );
	if(isset($xmlData->sessid) && !empty($xmlData->sessid))
	{
        $reqAPIActive = array(
            "auth" 	 => $authapi,
            "type"   => 2,
            "sessid" => $xmlData->sessid,
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