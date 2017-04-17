// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.EventDispatcher;
	import flash.display.*;
	import com.script.poker.protocol.*;
	import com.script.poker.events.*;
	import com.script.io.*;
	public class LoginController extends flash.display.MovieClip
	{	
	
		
		public var pgData:com.script.poker.PokerGlobalData;
		public var oMain:Object;
		public var oFlashVars:Object;
		public var nPort:int;
		public var nRetryLimitSF:int = 3;
		public var loadBalance:com.script.poker.LoadBalancer;
		public var nRetryLB:int = 0;
		public var nRetrySF:int = 0;
		public var lcmConnect:com.script.poker.LoginConnectionManager;
		private var nRetryLimitLB:int = 2;
		private var nRetries:int;
		public var sHost:String;
		trace ("host control")
		trace ("msk ke login controller");
		public function LoginController()
		{
			
		}
		public function initLogin(p__1:Object, p__2:Object, p__3:String, p__4:int):void
		{
			
			oMain = p__1;
			sHost = p__3;
			nPort = p__4;
			oFlashVars = p__2;
			pgData = new PokerGlobalData();
			
			for (var v in oFlashVars) {
				trace (v+" var");
				trace (oFlashVars.v);
			}
			trace ("zzz"+p__1+","+p__2+","+p__3+","+p__4);
			trace ("initloginzzz "+oFlashVars);
			trace ("data"+pgData);
			pgData.assignFlashVars(oFlashVars);
			trace ("init 1")
			nRetries = pgData.nRetries;
			trace ("init 2")
			trace ("1 = "+sHost);
			trace ("2 = "+nPort);
			trace ("3 = "+pgData.trace_stats);
			trace ("4 = "+pgData);
			lcmConnect = new LoginConnectionManager(pgData);
			trace ("init 3"); 
			loadBalance = new LoadBalancer(pgData);
			trace ("hampir init")
			initListeners();
			trace ("lewat init")
			//if (!(oMain.debugMode == null) && (oMain.debugMode == true)){
				lcmConnect.connect();
				pgData.serverName = "Debug";
			//} else {
			//	trace ("kena sini")
			//	loadBalance.chooseBestServer();
			//}
		}
		private function initListeners():void
		{	
			trace ("kesini ga");
			lcmConnect.addEventListener(SmartfoxConnectionManager.CONNECTED, onConnectionHandler);
			lcmConnect.addEventListener(SmartfoxConnectionManager.CONNECT_FAILED, onConnectFailed);
			lcmConnect.addEventListener(LoginConnectionManager.LOGIN_FAILED, onLoginFailed);
			lcmConnect.addEventListener(LoginConnectionManager.LOBBYJOIN_COMPLETE, onLobbyJoinComplete);
			lcmConnect.addEventListener(SFLoginEvent.SF_LOGIN_FAILED, onSFLoginFailed);
			loadBalance.addEventListener(LBEvent.onServerChosen, onServerChosen);
			loadBalance.addEventListener(LBEvent.serverStatusError, onLoadBalanceError);
			loadBalance.addEventListener(LBEvent.serverListError, onLoadBalanceError);
			loadBalance.addEventListener(LBEvent.findServerError, onLoadBalanceError);
		}	
		public function removeListeners():void
		{	
			lcmConnect.removeEventListener(SmartfoxConnectionManager.CONNECTED, onConnectionHandler);
			lcmConnect.removeEventListener(SmartfoxConnectionManager.CONNECT_FAILED, onConnectFailed);
			lcmConnect.removeEventListener(LoginConnectionManager.LOGIN_FAILED, onLoginFailed);
			lcmConnect.removeEventListener(LoginConnectionManager.LOBBYJOIN_COMPLETE, onLobbyJoinComplete);
			lcmConnect.removeEventListener(SFLoginEvent.SF_LOGIN_FAILED, onSFLoginFailed);
			loadBalance.removeEventListener(LBEvent.onServerChosen, onServerChosen);
			loadBalance.removeEventListener(LBEvent.serverStatusError, onLoadBalanceError);
			loadBalance.removeEventListener(LBEvent.serverListError, onLoadBalanceError);
			loadBalance.removeEventListener(LBEvent.findServerError, onLoadBalanceError);
		}
		private function onServerChosen(p__1:flash.events.Event):void
		{
			var l__3:String;
			nRetryLB = 0;
			
			var l__2:Array = pgData.ip.split(":");
			if (l__2.length > 1){
				lcmConnect.setHost(l__2[0]);
				lcmConnect.setPort(int(l__2[1]));
			} else {
				lcmConnect.setHost(pgData.ip);
				lcmConnect.setPort(pgData.port);
			}
			lcmConnect.connect();
			oMain.setConnectionText(("Connecting to " + pgData.serverName) + "...");
			if (pgData.trace_stats == 1){
				l__3 = pgData.GetSignedTrackingUrl(("o:AS3:SWF:ConnectBegin_" + nRetries) + ":2009-02-09");
				if (l__3 != ""){
					record(l__3);
				}
			}
		}	
		private function onLoadBalanceError(p__1:flash.events.Event):void
		{	
			
			var l__2:String;
			if ((pgData.trace_stats == 1) && (nRetryLB == 0)){
				l__2 = pgData.GetSignedTrackingUrl(((("o:AS3:SWF:LBError:" + p__1.type) + "_") + nRetries) + ":2009-04-20");
				if (l__2 != ""){
					record(l__2);
				}
			}
			if (nRetryLB < nRetryLimitLB){
				loadBalance.chooseBestServer();
			} else {
				oMain.loadBalanceError(p__1.type);
			}
			nRetryLB++;
		}
		private function onConnectFailed(p__1:flash.events.Event):void
		{
			
			var l__2:String;
			trace ("loop ga");
			if ((pgData.trace_stats == 1) && (nRetrySF == 0)){
				l__2 = pgData.GetSignedTrackingUrl(("o:AS3:SWF:ConnFail_" + nRetries) + ":2009-02-09");
				if (l__2 != ""){
					record(l__2);
				}
			}
			trace ("lewat loop");
			
			
			/*loadBalance.Failed to Loaddir
			if (nRetrySF < nRetryLimitSF){
				oMain.setConnectionText("Retrying connection...");
				loadBalance.addConnFail(pgData.serverId);
				loadBalance.chooseBestServer();
			} else {
				oMain.setConnectionText("Connection failed...");
				oMain.connectionFailed();
			}
			nRetrySF++;*/
		}
		private function onConnectionHandler(p__1:flash.events.Event):void
		{
			oMain.setConnectionText(("Connected successfully to " + pgData.serverName) + ".");
			var l__2:* = "";
			if (lcmConnect.port == 9339){
				if (pgData.trace_stats == 1){
					l__2 = pgData.GetSignedTrackingUrl(("o:AS3:SWF:Connected:9339_" + nRetries) + ":2009-02-09");
					if (l__2 != ""){
						record(l__2);
					}
				}
			} else if (lcmConnect.port == 443){
				if (pgData.trace_stats == 1){
					l__2 = pgData.GetSignedTrackingUrl(("o:AS3:SWF:Connected:443_" + nRetries) + ":2009-02-09");
					if (l__2 != ""){
						record(l__2);
					}
				}
			}
			var l__3:String = oFlashVars.uid;
			if (int(oFlashVars.tourneyId) > -1){
				l__3 = (l__3 + (":" + oFlashVars.tourneyId));
			}
			trace("flash split")
			var l__4:* = Number(oFlashVars.uid.split(":")[0]);
			
			trace (l__3+" dan "+pgData.pic_url+" dan "+pgData.nRank+" dan "+pgData.sNetwork+" dan "+pgData.pic_lrg_url+" dan "+l__4+" dan "+pgData.prof_url+" dan "+pgData.tourneyState+" dan "+pgData.protoVersion+" dan "+pgData.sPass+" dan "+pgData.sZone+" dan "+pgData.nHideGifts)
			//var l__5:com.script.poker.protocol.SSuperLogin = new SSuperLogin(l__3, pgData.pic_url, Number(pgData.nRank), pgData.sNetwork, pgData.pic_lrg_url, l__4, pgData.prof_url, pgData.tourneyState, pgData.protoVersion, 0, String("flash"), 1, 1, 1, pgData.sPass, pgData.sZone, pgData.nHideGifts);
			var l__5:com.script.poker.protocol.SSuperLogin = new SSuperLogin(oFlashVars.uid, pgData.pic_url, Number(pgData.nRank), "", "", "", "", "", "", 0, String("flash"), 1, 1, 1, "", "", "");
			lcmConnect.login(l__5);
		}
		private function onLoginFailed(p__1:flash.events.Event):void
		{
			oMain.loginFailed();
			trace ("failed to login")
		}
		private function onSFLoginFailed(p__1:com.script.poker.events.SFLoginEvent):void
		{
			
			oMain.loginSFFailed(p__1.message);
			
		}
		private function onLobbyJoinComplete(p__1:flash.events.Event):void
		{
			oMain.bLobbyJoinComplete = true;
			if (oMain.bLobbyAssetsLoaded){
				oMain.startPokerController();
			}
		}
		private function record(p__1:String):void
		{
			var l__2:com.script.io.LoadUrlVars;
			if (pgData.trace_stats == 1){
				l__2 = new LoadUrlVars();
				l__2.loadURL(p__1, {}, "POST");
			}
		}
	}
}