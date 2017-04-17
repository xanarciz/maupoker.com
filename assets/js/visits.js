function session(){
  var today = new Date();
    // If no data onlocal storage
    // Add data to local storage
    // Then show popup
    if(localStorage.getItem('visitors') == ''){
      show(today);


    }
    // If there is data on local storage
    // Set timer
    // compare if the popup time is greater or equal to local time
    // If yes add new data to local storage
    else{
      var next_show = localStorage.getItem('visitors');
      // console.log('next session - '+next_show + "\n" +'this session - '+ today);
      if (today >= next_show) {
        localStorage.removeItem("visitors");
        show(today);
      }
    }
  }

  function show(today)
  {
    var me = document.querySelector('script[data-game]');
    if(me){
      var id = me.getAttribute('data-game');
      // var url = 'http://analytic.dewacrm.com/api/visitors?id='+id+'&referrer='+window.refererr;
        // IE8 & 9 only Cross domain JSON GET request
    if ('XDomainRequest' in window && window.XDomainRequest !== null) {
		var host_name = window.location.hostname;
		var ver;
		if (isIE ()  ==  9) {
			ver = 9;
		}
		else if (isIE () == 8) {
			ver = 8;
		}
		else{
			ver = 7;
		}
		//console.log(navigator.userAgent.toLowerCase());
        var url = 'http://ip-api.com/json';
        var xdr = new XDomainRequest(); // Use Microsoft XDR
        var country, timezone;
        xdr.open('GET', url);
        xdr.onload = function () {
            var dom  = new ActiveXObject('Microsoft.XMLDOM');
            if(xdr.responseText != ''){
              var res = JSON.parse(xdr.responseText);
              if(res.status == 'success'){
              country = res.country;
              timezone = res.timezone;
              }
            }
            dom.async = false;
        };
        xdr.onerror = function(e) {
            _result = false;  
        };
        xdr.send();

        var locale = this.clientInformation.browserLanguage;
        var url = 'http://analytic.dewacrm.com/api/visitors?id='+id+'&referrer='+document.referrer+'&locale='+locale+'&country='+country+'&timezone='+timezone+'&host_name='+host_name+'&ver='+ver;
        //console.log(url);
		var xdr = new XDomainRequest(); // Use Microsoft XDR
        xdr.open('GET', url);
        xdr.onload = function () {
            var dom  = new ActiveXObject('Microsoft.XMLDOM');
             //console.log(xdr.responseText);
              if(xdr.responseText == '1'){
                 var next_show = new Date();
                  next_show.setHours(today.getHours() + 4);
                  localStorage.setItem("visitors", next_show);
              }
            dom.async = false;
        };
        xdr.onerror = function(e) {
            _result = false;

        };
        xdr.send();
    }

    // IE7 and lower can't do cross domain
    else if (navigator.userAgent.indexOf('MSIE') != -1 &&
        parseInt(navigator.userAgent.match(/MSIE ([\d.]+)/)[1], 10) < 8) {
        return false;
    }
    else{
      var url = 'http://ip-api.com/json';
      var x = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
	  var browser;
	  if(window.navigator.userAgent.indexOf("OPR") > -1 || window.navigator.userAgent.indexOf("Opera") > -1) 
	  {
		browser = 'Opera';
      }
      else if((navigator.userAgent.indexOf("MSIE") != -1 ) || (!!document.documentMode == true )) //IF IE > 10
      {
		browser = 'IE';
      }  
      var country, timezone;  
         x.onreadystatechange = function() 
         {
            if(x.responseText != ''){
                var res = JSON.parse(x.responseText);
                if(res.status == 'success'){
                country = res.country;
                timezone = res.timezone;
              }
            }
          }
          x.open("GET", url, false);
          x.send();
      var url = 'http://analytic.dewacrm.com/api/visitors?id='+id+'&referrer='+document.referrer+'&locale='+navigator.language+'&country='+country+'&timezone='+timezone+'&browser='+browser;
      var xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
      xmlhttp.onreadystatechange = function() 
      {
         //console.log(xmlhttp.responseText);
          if(xmlhttp.responseText == '1'){
                 var next_show = new Date();
                  next_show.setHours(today.getHours() + 4);
                  localStorage.setItem("visitors", next_show);
              }
          }
          xmlhttp.open("GET", url, true);
          xmlhttp.send();
        }
    }
    else{
        return false;
    }
  }


function isIE () {
  var myNav = navigator.userAgent.toLowerCase();
  return (myNav.indexOf('msie') != -1) ? parseInt(myNav.split('msie')[1]) : false;
}

window.onload = function() {
  session();
 };

