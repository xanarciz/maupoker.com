package com.script.poker
{
	
	import flash.display.MovieClip;
	import flash.net.SharedObject;
	public class tes extends flash.display.MovieClip
	{
		
		var Cookies = SharedObject.getLocal("flashCookies", "/");
			var datalogin = Cookies.data.txt;
			var sessionid = Cookies.data.session;
		
	}
	
	
	}