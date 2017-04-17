// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.io
{
	import flash.events.EventDispatcher;
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import flash.events.Event;
	import flash.system.*;
	public class SmartfoxConnectionManager extends flash.events.EventDispatcher
	{
		public var port:int;
		public var smartfox:SmartFoxClient;
		public var host:String;
		public var _key:String;
		
		public static const CONNECTED:String = "connected";
		public static const CONNECT_FAILED:String = "connectfail";
		public function SmartfoxConnectionManager(p__1:String,p__2:int)
		{
			host = p__1;
			port = p__2;			
			_key = "";
			//smartfox = new SmartFoxClient(true);
			smartfox = new SmartFoxClient(true);
			smartfox.addEventListener(SFSEvent.onConnection, onConnectHandler);
			smartfox.addEventListener(SFSEvent.onRandomKey, onRandomKeyHandler)
			
			//smartfox.addEventListener(SFSEvent.onConnectionLost, onConnectionLost);
			
			
		}
		private function onConnectionLost(evt:SFSEvent):void{
			//constat = "Connection Lost"
			//concolor = "0xFF0000"
			debugTrace("Connection lost!");
		}
		public function addConnectionHandler():void
		{
			smartfox.addEventListener(SFSEvent.onConnection, onConnectHandler);
		}
		public function get isConnected():Boolean
		{
			return(this.smartfox.isConnected);
		}
		public function connect():void
		{
			//Security.loadPolicyFile(("xmlsocket://" + host) + ":843");
			//smartfox.loadConfig();
			smartfox.connect(host, port)
		}
		public function disconnect():void
		{
			smartfox.disconnect();
		}
		public function setHost(p__1:String):void
		{
			host = p__1;
		}
		public function setPort(p__1:int):void
		{
			port = p__1;
		}
		public function assignSFClient(p__1):void
		{
			smartfox = SmartFoxClient(p__1);
			smartfox.addEventListener(SFSEvent.onConnection, onConnectHandler);
		}
		
		public function onConnectHandler(p__1:SFSEvent):void
		{			
			
			if (p__1.params.success){
				smartfox.getRandomKey();
				p__1.stopPropagation();
				//dispatchEvent(new Event(SmartfoxConnectionManager.CONNECTED));
			} else {
				
				smartfox.removeEventListener(SFSEvent.onConnection, onConnectHandler);
				smartfox.addEventListener(SFSEvent.onConnection, onConnectHandler443);
				setPort(443);
				connect();
				
			}
		}
		
		public function onConnectHandler443(p__1:SFSEvent):void
		{			
			if (p__1.params.success){
				smartfox.getRandomKey();
				p__1.stopPropagation();
				//dispatchEvent(new Event(SmartfoxConnectionManager.CONNECTED));
				smartfox.removeEventListener(SFSEvent.onConnection, onConnectHandler443);
				smartfox.addEventListener(SFSEvent.onConnection, onConnectHandler);
			} else {
				dispatchEvent(new Event(SmartfoxConnectionManager.CONNECT_FAILED));
			}			
		}
		
		public function onRandomKeyHandler(p__1:SFSEvent):void{
			//sfs.login(sfs.defaultZone, login, pass);
			//trace("Random key received from server: " + p__1.params.key)
		
			_key = p__1.params.key;
			
			dispatchEvent(new Event(SmartfoxConnectionManager.CONNECTED));
			//param._key = key;
		}
		
	}
}