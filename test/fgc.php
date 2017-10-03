<?php

ini_set('display_errors', 1);
error_reporting(E_ALL ^ E_NOTICE);

echo file_get_contents('http://www.detik.com');
/*
function get_content($URL){
      $ch = curl_init();
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
      curl_setopt($ch, CURLOPT_URL, $URL);
      $data = curl_exec($ch);
      curl_close($ch);
      return $data;
}

echo get_content('http://www.detik.com');
*/


