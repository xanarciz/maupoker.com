<?php
echo 'Client IP Address: '   . getenv('GEOIP_ADDR');
echo 'Client Country Code: ' . getenv('GEOIP_COUNTRY_CODE');
echo 'Client Country Name: ' . getenv('GEOIP_COUNTRY_NAME');
?>
