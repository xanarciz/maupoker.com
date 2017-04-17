// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.io
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import com.script.events.*;
	public class LoadUrlVars extends flash.events.EventDispatcher
	{
		public var data:String;
		public function LoadUrlVars()
		{
		}
		public function loadURL(p__1:String, p__2:Object = null, p__3:String = "GET"):void
		{
			var l__6:flash.net.URLVariables;
			var l__7:String;
			var l__4:flash.net.URLRequest = new URLRequest(p__1);
			if ((p__2) != null){
				l__6 = new URLVariables();
				for (l__7 in p__2){
					l__6[l__7] = p__2[l__7];
				}
				if ((p__3) == "GET"){
					l__4.method = URLRequestMethod.GET;
				} else if ((p__3) == "POST"){
					l__4.method = URLRequestMethod.POST;
				}
				l__4.data = l__6;
			}
			var l__5:flash.net.URLLoader = new URLLoader();
			l__5.addEventListener(Event.COMPLETE, onUrlLoaded);
			l__5.addEventListener(IOErrorEvent.IO_ERROR, onUrlError);
			l__5.load(l__4);
		}
		private function onUrlLoaded(p__1:flash.events.Event):void
		{
			var l__2:* = p__1.target;
			data = l__2.data;
			dispatchEvent(new URLEvent(URLEvent.onLoaded, true, l__2.data));
		}
		private function onUrlError(p__1:flash.events.IOErrorEvent):void
		{
			dispatchEvent(new URLEvent(URLEvent.onLoaded, false));
		}
		public function navigateURL(p__1:String, p__2:String):void
		{
			navigateToURL(new URLRequest(p__1), p__2);
		}
	}
}