// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com 
package com.script.poker
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import com.script.poker.events.*;
	import com.script.poker.protocol.SSuperLogin;
	import com.script.io.LoadUrlVars;
	import com.script.io.SmartfoxConnectionManager;
	public class LoginConnectionManager extends com.script.io.SmartfoxConnectionManager
	{	
		
		public var pgData:com.script.poker.PokerGlobalData;
		public var sfeSetMod:SFSEvent;
		public var sfeLogin:SFSEvent;
		public var nTraceStats:int;
		public var sfeDisplayRoomList:SFSEvent;
		public var sfeRoomList:SFSEvent;
		public var sfeJoinRoom:SFSEvent;
		private var nRetries:int;		
		public static const LOBBYJOIN_COMPLETE:* = "LOBBYJOIN_COMPLETE";
		public static const LOGIN_FAILED:* = "LOGIN_FAILED";
		
		public function LoginConnectionManager(p__4:com.script.poker.PokerGlobalData)
		{
			
			super(true);
			//nTraceStats = p__3;
			pgData = p__4;
			nRetries = pgData.nRetries;
			initProtocolListeners();
			
		}
		private function initProtocolListeners():void
		{
			smartfox.addEventListener(SFSEvent.onExtensionResponse, onExtensionHandler);
			smartfox.addEventListener(SFSEvent.onJoinRoom, onJoinRoomHandler);
			smartfox.addEventListener(SFSEvent.onRoomListUpdate, onRoomListUpdate);
			smartfox.addEventListener(SFSEvent.onLogin, onSFLogin);
		}
		private function removeListeners():void
		{
			smartfox.removeEventListener(SFSEvent.onExtensionResponse, onExtensionHandler);
			smartfox.removeEventListener(SFSEvent.onJoinRoom, onJoinRoomHandler);
			smartfox.removeEventListener(SFSEvent.onRoomListUpdate, onRoomListUpdate);
			smartfox.removeEventListener(SFSEvent.onConnection, onConnectHandler);
			smartfox.removeEventListener(SFSEvent.onLogin, onSFLogin);
		}
		private function checkProgress():void
		{
			if (((!(sfeDisplayRoomList == null) && !(sfeJoinRoom == null)) && !(sfeLogin == null)) && !(sfeRoomList == null)){
				removeListeners();
				dispatchEvent(new Event(LOBBYJOIN_COMPLETE));
			}
		}
		public function login(p__1:com.script.poker.protocol.SSuperLogin):void
		{
			//smartfox.login(p__1.zone, p__1.props_JSON_ESC, p__1.pass);
			smartfox.login(smartfox.defaultZone, p__1.userId, "");
		}
		public function getRoomList():void
		{
			smartfox.getRoomList();
		}
		public function autoJoin():void
		{
			smartfox.autoJoin();
		}
		public function sendXtMessage(p__1:String, p__2:String, p__3:Object, p__4:String):void
		{
			smartfox.sendXtMessage(p__1, p__2, p__3, p__4);
		}
		public function getLobbyRooms():void
		{
			smartfox.sendXtMessage("texasLogin", "displayRoomList", {}, "xml");
		}
		private function onJoinRoomHandler(p__1:SFSEvent):void
		{
		
			var l__2:String;
			if (pgData.trace_stats == 1){
				l__2 = pgData.GetSignedTrackingUrl(("o:AS3:SWF:LCM:RoomJoined_" + nRetries) + ":2009-02-06");
				if (l__2 != ""){
					record(l__2);
				}
			}
			sfeJoinRoom = p__1;
			checkProgress();
		}
		private function onRoomListUpdate(p__1:SFSEvent):void
		{
			var l__2:String;
			if (pgData.trace_stats == 1){
				l__2 = pgData.GetSignedTrackingUrl(("o:AS3:SWF:LCM:RoomListUpdate_" + nRetries) + ":2009-02-06");
				if (l__2 != ""){
					record(l__2);
				}
			}
			sfeRoomList = p__1;
			checkProgress();
		}
		private function onSetMod(p__1:SFSEvent):void
		{
			sfeSetMod = p__1;
		}
		private function onExtensionHandler(p__1:SFSEvent):void
		{
			trace ("onexhand")
			var l__3:String;
			var l__2:Object = p__1.params.dataObj;
			switch(l__2._cmd){
				case "logOK":
				{
					loginHandler(l__2, p__1);
					return;
				}
				case "logKO":
				{
					loginHandler(l__2, p__1);
					return;
				}
				case "displayRoomList":
				{
					if (pgData.trace_stats == 1){
						l__3 = pgData.GetSignedTrackingUrl(("o:AS3:SWF:LCM:DisplayRoomList_" + nRetries) + ":2009-02-06");
						if (l__3 != ""){
							record(l__3);
						}
					}
					sfeDisplayRoomList = p__1;
					checkProgress();
					return;
				}
				case "contest":
				{
					return;
				}
				case "getBestPlayers":
				{
					return;
				}
			}
			switch(l__2[0]){
				case "setmod":
				{
					onSetMod(p__1);
					return;
				}
			}
		}
		private function loginHandler(p__1:Object, p__2:SFSEvent):void
		{
			trace ("loghandler")
			var l__3:String = p__1._cmd;
			var l__4:* = "";
			if (l__3 == "logOK"){				
				if (pgData.trace_stats == 1){
					l__4 = pgData.GetSignedTrackingUrl(("o:AS3:SWF:LCM:LoginSuccess_" + nRetries) + ":2009-02-06");
					if (l__4 != ""){
						record(l__4);
					}
				}
				sfeLogin = p__2;
				checkProgress();
			} else if (l__3 == "logKO"){
				if (pgData.trace_stats == 1){
					l__4 = pgData.GetSignedTrackingUrl(("o:AS3:SWF:LCM:LoginFailure_" + nRetries) + ":2009-02-06");
					if (l__4 != ""){
						record(l__4);
					}
				}
				dispatchEvent(new Event(LOGIN_FAILED));
			}
		}
		private function record(p__1:String):void
		{
			var l__2:com.script.io.LoadUrlVars;
			if (nTraceStats == 1){
				l__2 = new LoadUrlVars();
				l__2.loadURL(p__1, {}, "POST");
			}
		}
		private function onSFLogin(p__1:SFSEvent):void
		{
			trace ("di sf login")
			if (p__1.params.success){
				dispatchEvent(new Event("login"));
			} else {
				dispatchEvent(new SFLoginEvent(SFLoginEvent.SF_LOGIN_FAILED, p__1.params.error));
			}
		}
	}
}