<?php 
//#########################

/**
 * Display pretty debug message
 *
 * @param $data
 */
function showDebug($data, $type = 'php'){
    switch ($type){
        case 'php':
            echo "<pre>";
            print_r($data);
            echo "</pre>";
            die();
            break;
        case 'console':
            echo "<script>console.log('".json_encode($data)."');</script>";
            break;
    }
}

/**
 * Clear all ilegal symbol
 *
 * @param $data
 * @param null $values2
 * @return array|mixed
 */
function sanitize($data, $values2 = null) {
	if ( !isset($data) or empty($data)) return $data;
	if ( is_numeric($data) ) return $data;
	
	$data = str_replace("'", "''", $data);
	$operators = [
        ' like ', 'like binary', 'not like', ' between ', ' ilike ',
        '&', '|', '^', '<<', '>>','<','>',
        ' rlike ', ' regexp ', ' not regexp ',
        '~', '~*', '!~', '!~*', ' similar to ',
        'not similar to', 'not ilike', '~~*', '!~~*',';',
        'select ','update ','delete ','insert ',' alter ','create ',
        ' join ',' where ',' union ',' order ',' having ', ' exec ',' declare ',
        ' char ', '(',')'
    ];
    $regexIlegalChar = [
        '/%0[0-8bcef]/',            // url encoded 00-08, 11, 12, 14, 15
        '/%1[0-9a-f]/',             // url encoded 16-31
        '/[\x00-\x08]/',            // hexa 00-08
        '/\x0b/',                   // hexa 11
        '/\x0c/',                   // hexa 12
        '/[\x0e-\x1f]/',            // hexa 14-31
		'/%3[A-CEF]/',
		'/%2[0-9A]/',
		'/[<>":;?()]/'
    ];
	if(is_array($data)){
		$res = array();
		foreach ($data as $key => $value){
			$res[$key] = str_ireplace($operators, '', $value);
			$res[$key] = preg_replace($regexIlegalChar, '', $res[$key]);
		}
	}else{
		$res = str_ireplace($operators,'',$data);
		$res = preg_replace($regexIlegalChar,'',$res);
	}

	$result = $res;

	if(! is_null($values2)){
		$values2 = sanitize($values2);

		$result = array($data, $values2);
	}
	return $result;
}

/**
 * Convert array to XML
 * | if array no have key, array will create default key in int data type
 * | -| example : array([0] => ... , [1] => ..., ...)
 * |
 * | if array key is default, then xml will create the same key for array
 * | with the previous key
 * | - example :
 * |   from : array ( [example] => array ( [0] => exp1, [1] => exp2 ) )
 * |   to : <example>exp1</example> <example>exp2</example>
 * |
 * | and if array not a default and array key is numeric then the xml
 * | will add a prefix 'id_' and follow the array key
 * | -| example :
 * |    from : array ( [example] => array ( [12044] => exp1, [65054] => exp2 ) )
 * |    to : <example> <id_12044>exp1</id_12044> <id_65054>exp2</id_65054> </example>
 *
 * @param $array
 * @param $xml_user_info
 * @param null $old_key
 * @param int $arrayType
 */
function array_to_xml($array, &$xml_user_info, $old_key = null, $arrayType = 1) {
    foreach($array as $key => $value) {
        if(is_array($value)) {
            if(!is_numeric($key)){

                // if next array have key : 0, then array type is default and
                // xml not create child, else array type is not default and create new child
                if(array_key_exists('0', $value)){ $subnode = $xml_user_info; $arrayType = 0; }
                else { $subnode = $xml_user_info->addChild("$key"); $arrayType = 1; }

                array_to_xml($value, $subnode, $key, $arrayType);
            }else{

                // if array type is not default, create new child with prefix 'id_'
                // else create child with previous key
                if($arrayType == 1) $subnode = $xml_user_info->addChild("id_$key");
                else $subnode = $xml_user_info->addChild("$old_key");

                array_to_xml($value, $subnode, $old_key, $arrayType);
            }
        }else {
            $xml_user_info->addChild("$key",htmlspecialchars("$value"));
        }
    }
}

function deviceDetect(){
    // check Mobile device
    require_once '../mobile_detect.php';
    $detect = new Mobile_Detect;
    $check_mobile = $detect->isMobile();
    $check_tablet = $detect->isTablet();

}

/**
 * Get IP of user to access this page
 *
 * @param null $type
 * @return null
 */
function getUserIP2($type = null){
	if($type == null) {
		$client = @$_SERVER['HTTP_CLIENT_IP'];
		$forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
		$remote = $_SERVER['REMOTE_ADDR'];
		$forward = isset(explode(',', $forward)[1]) ? explode(',', $forward)[1] : explode(',', $forward)[0];

		if (filter_var($client, FILTER_VALIDATE_IP)) $ip = $client;
		elseif (filter_var($forward, FILTER_VALIDATE_IP)) $ip = $forward;
		else $ip = $remote;
	}else{
		$ipType = @$_SERVER[$type];
		$ip = isset(explode(',', $ipType)[1]) ? explode(',', $ipType)[1] : explode(',', $ipType)[0];

		if (!filter_var($ip, FILTER_VALIDATE_IP)) $ip = null;
	}
	return $ip;
}

/**
 * Send API to another website
 *
 * @param $url
 * @param array $data
 * @param null $pkey
 * @param array $option
 * @param bool $arrayBuilder
 * @return mixed
 */
function sendAPI($url, $data=array(), $dataType = 'XML', $pkey = null, $option = array()){
	switch ($dataType) {
		case 'http_query' :
			$respon = http_build_query($data);
			break;
		case 'XML' :
			$xml = new SimpleXMLElement("<request/>");
            array_to_xml($data, $xml);
			$respon = $xml->asXML();
			break;
		case 'JSON' :
			$respon = json_encode($data);
			break;
	}

    try {
        $curl = curl_init();
        if ($pkey) {
            $myaes = new Myaes();
            $myaes->setPrivate($pkey);
            $response = $myaes->getEnc($respon);
            curl_setopt($curl, CURLOPT_HTTPHEADER, array(
                "Authorization: " . $myaes->getHeaderPK(),
                "Content-Type: text/plain; charset=utf-8"
            ));
        } else {
            $response = $respon;
        }

        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_POSTFIELDS, "" . $response);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 300);

        $optionArray = ['CURLOPT_URL', 'CURLOPT_POSTFIELDS', 'CURLOPT_RETURNTRANSFER'];
        foreach ($option as $key => $value) {
            if (!in_array($key, $optionArray)) {
                if ($key == 'CURLOPT_HTTP_VERSION') {
                    curl_setopt($curl, constant($key), constant($value));
                } else {
                    curl_setopt($curl, constant($key), $value);
                }
            }
        }

        $data = curl_exec($curl);
        curl_close($curl);

        if (isJson($data)) {
            $array_data = json_decode($data);
        } else {
            $array_data = json_decode(json_encode(simplexml_load_string($data)), true);
        }
    }catch (Exception $e){
        $array_data = null;
    }
    return $array_data;
}

/**
 * Check string is object of json
 *
 * @param $string
 * @return bool
 */
function isJson($string) {
	json_decode($string);
	return (json_last_error() == JSON_ERROR_NONE);
}

/**
 * Check Captcha is correct or not
 *
 * @param $captchaName
 * @param $captchaValue
 * @return bool
 */
function checkCaptcha($captchaName, $captchaValue){
    $captchaSession = $_SESSION[$captchaName];
    unset($_SESSION[$captchaName]);

    if($captchaValue == "" || $captchaValue == NULL || $captchaSession == "" || $captchaSession == NULL){ return false; }
    if($captchaSession == $captchaValue){ return true; }

    return false;
}

/**
 * Get N-first list of array
 *
 * @param array $array
 * @param int $length
 * @return array
 */
function getFirst($array,$length = 1)
{
    return array_slice($array, 0,$length, true);
}

/**
 * Passing data to all pages.
 * Param get from API (Memcached)
 *
 * @param $data
 * @return mixed
 */
function variableMasterProc($data){
    $keyArray = [
        'winJack', 'contact_agent', 'bankList',
        'webinfo', 'newsAgent', 'games',
        'latestWinner', 'lastTransaction',
        'promo',
    ];
    foreach ($data as $key => $value) {
        if (in_array($key, $keyArray)) continue;
        if (is_array($value)) {
            $data[$key] = implode("", $value);
        }
    }
    foreach ($data['contact_agent'] as $key => $value) {
        if (is_array($value)) {
            $data['contact_agent'][$key] = implode("", $value);
        }
    }
    return $data;
}

/**
 * Get formating of bank account number
 *
 * @param $bankno
 * @param null $bankname
 * @return string
 */
function bank_format($bankno, $bankname = null)
{
    $norek = str_replace('-', '', $bankno);
    if(strtoupper($bankname) == 'MANDIRI'){
        $set1 = substr($norek, 0, 3);
        $set2 = substr($norek, 3, 3);
        $set3 = substr($norek, 6, 3);
        $set4 = substr($norek, 9, 4);
        $norewsset = $set1."-".$set2."-".$set3."-".$set4;
    }else if(strtoupper($bankname) == 'BCA' || strtoupper($bankname) == 'BNI'){
        $set1=substr($norek,0,3);
        $set2=substr($norek,3,3);
        $set3=substr($norek,6,4);
        $norewsset=$set1."-".$set2."-".$set3;
    }else if(strtoupper($bankname) == 'BRI'){
        $set1=substr($norek,0,3);
        $set2=substr($norek,3,3);
        $set3=substr($norek,6,3);
        $set4=substr($norek,9,3);
        $set5=substr($norek,12,3);
        $norewsset=$set1."-".$set2."-".$set3."-".$set4."-".$set5;
    }else if(strtoupper($bankname) == 'DANAMON'){
        $set1 = substr($norek, 0, 3);
        $set2 = substr($norek, 3, 3);
        $set3 = substr($norek, 6, 3);
        $set4 = substr($norek, 9, 3);
        $norewsset = $set1."-".$set2."-".$set3."-".$set4;
    }
    else if(strtoupper($bankname) == 'CIMB'){
        $set1 = substr($norek, 0, 3);
        $set2 = substr($norek, 3, 2);
        $set3 = substr($norek, 5, 5);
        $set4 = substr($norek, 10, 2);
        $set5 = substr($norek, 12, 1);
        $norewsset = $set1."-".$set2."-".$set3."-".$set4."-".$set5;
    }else{
        $norewsset = '';
        for($i = 0; $i < strlen($norek); $i++){
            if(($i+1)%3 == 0) $norewsset .= $norek[$i].'-';
            else $norewsset .= $norek[$i];
        }
        if($norewsset[strlen($norewsset)-1] == '-'){
            $norewsset = substr($norewsset, 0, strlen($norewsset)-1);
        }
    }

    return $norewsset;
}

/**
 * Get Paging Button
 *
 * @param int $totalPage
 * @param int $currPage
 * @param $link
 * @param array $options
 */
function getPaging($totalPage = 1, $currPage = 1, $link, $options = array()){
    if(parse_url($link, PHP_URL_QUERY) != ''){
        $link = $link.'&page=';
    }else{
        $link = $link.'?page=';
    }

    // Default Options
    $options['firstLast'] = isset($options['firstLast']) ? $options['firstLast'] : false;
    $options['showMore']  = isset($options['showMore']) ? $options['showMore'] : false;
    $options['lenShow']   = isset($options['lenShow']) ? $options['lenShow'] : 5;


    if($totalPage <= 1) {echo ""; return;}

    $prevBtn = "<li><a href='".$link.($currPage-1)."' rel='prev'>&laquo;</a></li>";
    if($currPage <= 1) {
        $prevBtn = "<li class='disabled'><span>&laquo;</span></li>";
        $currPage = 1;
    }

    $nextBtn = "<li><a href='".$link.($currPage+1)."' rel='next'>&raquo;</a></li>";
    if($currPage >= $totalPage){
        $nextBtn = "<li class='disabled'><span>&raquo;</span></li>";
        $currPage = $totalPage;
    }

    $minBegin = $minEnd   = (int)($options['lenShow'] / 2);
    if($options['lenShow'] % 2 == 0){
        $minBegin = (int)($options['lenShow'] / 2) - 1;
    }

    $beginShow = ($currPage - $minBegin) > 0 ? ($currPage - $minBegin) : 1;
    $endShow = ($currPage + $minEnd) < $totalPage ? ($currPage + $minEnd) : $totalPage;

    //length N number from endShow
    $lenNum = ($endShow - $beginShow) + 1;
    $newEndShow = ($endShow + ($options['lenShow'] - $lenNum));
    $endShow = $lenNum < $options['lenShow'] ? ( $newEndShow < $totalPage ? $newEndShow : $totalPage) : $endShow;

    //length N number from beginShow
    $lenNum = ($endShow - $beginShow) + 1;
    $newBeginShow = ($beginShow - ($options['lenShow'] - $lenNum));
    $beginShow = $lenNum < $options['lenShow'] ? ( $newBeginShow > 1 ? $newBeginShow : 1) : $beginShow;

    echo "<ul class='pagination'>";
    if($options['firstLast']) echo "<li><a href='" . $link . "1' rel='first'>First</a></li>";
    echo $prevBtn;
    for($st = $beginShow; $st <= $endShow; $st++){
        if($options['showMore']) {
            if ($st == $beginShow && $endShow != 1) {
                if ($beginShow != 1) {
                    echo "<span class='more'>...</span>";
                }
            }
        }
        if($currPage != $st) {
            echo "<li><a href='" . $link . $st . "'>" . $st . "</a></li>";
        }else{
            echo "<li class='active'><span>" . $st . "</span></li>";
        }
        if($options['showMore']) {
            if ($st == $endShow && $endShow != $totalPage) {
                if ($endShow != $totalPage) {
                    echo "<span class='more'>...</span>";
                }
            }
        }
    }
    echo $nextBtn;
    if($options['firstLast']) echo "<li><a href='" . $link . $totalPage . "' rel='last'>Last</a></li>";
    echo "</ul>";
}
?>