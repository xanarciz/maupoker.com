// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.gskinner.utils
{
	import flash.net.LocalConnection;
	import flash.events.EventDispatcher;
	public class SWFBridgeAS3 extends flash.events.EventDispatcher
	{
		private var myID:String;
		private var host:Boolean = true;
		private var _connected:Boolean = false;
		private var baseID:String;
		private var clientObj:Object;
		private var lc:flash.net.LocalConnection;
		private var extID:String;
		public function SWFBridgeAS3(p_id:String, p_clientObj:Object)
		{
			baseID = p_id.split(":").join("");
			lc = new LocalConnection();
			lc.client = this;
			clientObj = p_clientObj;
			try {
				lc.connect(baseID + "_host");
			} catch (e:ArgumentError) {
				host = false;
			}
			myID = (baseID + (host ? "_host" : "_guest"));
			extID = (baseID + (host ? "_guest" : "_host"));
			if (!host){
				lc.connect(myID);
				lc.send(extID, "com_gskinner_utils_SWFBridge_init");
			}
		}
		public function send(p__1:String, ... p__2):void
		{
			if (!_connected){
				throw new ArgumentError("Send failed because the object is not connected.");
			}
			p__2.unshift(p__1);
			p__2.unshift("com_gskinner_utils_SWFBridge_receive");
			p__2.unshift(extID);
			lc.send.apply(lc, p__2);
		}
		public function close():void
		{
			try {
				lc.close();
			} catch (e:*) {
			}
			lc = null;
			clientObj = null;
			if (!_connected){
				throw new ArgumentError("Close failed because the object is not connected.");
			}
			_connected = false;
		}
		public function get id():String
		{
			return(baseID);
		}
		public function get connected():Boolean
		{
			return(_connected);
		}
		public function com_gskinner_utils_SWFBridge_receive(p_method:String, ... p_args):void
		{
			try {
				clientObj[p_method].apply(clientObj, p_args);
			} catch (e:*) {
			}
		}
		public function com_gskinner_utils_SWFBridge_init():void
		{
			if (host){
				lc.send(extID, "com_gskinner_utils_SWFBridge_init");
			}
			_connected = true;
			dispatchEvent(new Event(Event.CONNECT));
		}
	}
}