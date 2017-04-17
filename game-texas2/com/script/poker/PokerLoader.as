
// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker
{
	import ws.tink.managers.*;
	import ws.tink.core.Library;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.events.StatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.display.Loader;
    import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.system.Security;
	import ws.tink.events.LibraryEvent;
	import com.script.utils.FlashCookie;
	import flash.net.LocalConnection;
	import flash.net.URLLoader;
	import com.adobe.crypto.*;
	import com.script.io.LoadUrlVars;
	import com.script.poker.table.asset.PokerButton;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import com.script.display.loaders.Progressor;
	import flash.utils.Timer;
	import flash.external.*;
	import flash.net.SharedObject;
	import com.greensock.*;
	
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.easing.*;
	public class PokerLoader extends flash.display.MovieClip
	{
		//private var progressText:flash.text.TextField;
		private var tulis2:flash.text.TextField;
		public var catchAllMC:flash.display.MovieClip;
		private var connectionNameOut:String;
		public var oPokerController:Object;
		public var assetXML:XML;
		public var nAssetCount:int;
		public var bTableAssetsLoaded:Boolean = false;
		public var btnReload:flash.display.MovieClip;
		public var mc_run:flash.display.MovieClip;
		//private var spinner:flash.display.MovieClip;
		public var bLobbyAssetsLoaded:Boolean = false;
		private var nLbTotal:uint = 0;
		public var nRetries:int = -2;
		private var nTbTotal:uint = 0;
		public var pokerEmail:String = "";
		private var connectText:flash.text.TextField;
		public var so3TableBG:String = "../images/txh/table_idn.jpg";
		public var bLobbyJoinComplete:Boolean = false;
		public var pbManifest:ws.tink.core.Library;
		public var aTableManifest:Array;
		public var aLobbyManifest:Array;	
		public var aXMLManifest:Array;
		public var timeOut:flash.utils.Timer;
		public var lbLoginControl:ws.tink.core.Library;
		public var tnyTableBG:String = "../images/txh/table_idn.jpg";
		public var so2TableBG:String = "../images/txh/table_idn.jpg";
		public var bConfigLoaded:Boolean = false;
		public var fCookie:com.script.utils.FlashCookie;
		private var nPkLoaded:uint = 0;
		public var oLoginController:Object;
		public var configXML:XML;
		public var so1TableBG:String = "../images/txh/table_idn.jpg";
		public var aPopManifest:Array;
		public var soundXML:XML;
		public var emoXML:XML;
		public var animXML:XML;
		public var oFlashVars:Object;
		private var connectionNameIn:String;
		private var connectionOut:flash.net.LocalConnection;
		public var debugMode:Boolean = false;
		public var bPokerControllerLoaded:Boolean = false;
		public var nTotalAssets:int;
		
		public var bSFLoginFailed:Boolean = false;
		private var nTbLoaded:uint = 0;
		public var errorBox:DialogText;
		private var nLbLoaded:uint = 0;
		private var connectionIn:flash.net.LocalConnection;
		public var cfgManifest:ws.tink.core.Library;
		public var fbjsTimeout:flash.utils.Timer;
		//public var vipTableBG:String = "http://statics.poker.static.script.com/poker/images/as3tables/tableVIP0001.jpg";
		public var vipTableBG:String = "../images/txh/table_idn.jpg"
		private var nPpLoaded:uint = 0;
		private var nPkTotal:uint = 0;
		public var tbManifest:ws.tink.core.Library;
		public var lbPokerControl:ws.tink.core.Library;
		public var aXwarsID:Array;
		public var lbManifest:ws.tink.core.Library;	
		public var popupXML:XML;
		public var aXappIDs:Array;
		public var outputText:flash.text.TextField;
		private var nPpTotal:uint = 0;
		public var btnTryAgain:com.script.poker.table.asset.PokerButton;
		//private var mcProgress:com.script.display.loaders.Progressor;
		public var bPopupAssetsLoaded:Boolean = false;
		public var mcLoading:flash.display.MovieClip;
		public var mcBack:flash.display.MovieClip;
		//public var preload1:flash.display.MovieClip;
		public var mcLoader;
		//public var stdTableBG:String = "http://statics.poker.static.script.com/poker/images/as3tables/tableStandard0001.jpg";
		public var stdTableBG:String = "../images/txh/table_idn.jpg";
		public var arrTableBG:Array;
		public var statsXML:XML;
		private var ldr:flash.display.Loader;
		public static var pgData:com.script.poker.PokerGlobalData;
		
		public var localDomainLC:LocalConnection = new LocalConnection();
		public var myDomainName = localDomainLC.domain;
		var xml:XMLLoader = new XMLLoader("http://"+myDomainName+"/function/satu.xml", {onComplete:xmlComplete, onSecurityError:security});
		//var xml:XMLLoader = new XMLLoader("http://www.cas2.inn/function/satu.xml", {onComplete:xmlComplete, onSecurityError:security});
		
		private var b_Total:int;
		private var b_Loaded:int;
		private var c_Total:int;
		private var c_Loaded:Number = 0;
		private var c_LoadFrame:Number = 0;
		public var bgmc;
		public var text;
		public var getlang:bahasa
		public var langs = new Object();
		
		public function xmlComplete(e:LoaderEvent):void{
			loadStat = null;
			sStat = null;
			try {
				handleFlashVars();
			} catch (err:Error) {
				trace ("error")
			}
			if (!(oFlashVars.trace_stats == null) && (oFlashVars.trace_stats == "1")){
				loadStat = GetSignedTrackingUrl("o:AS3:Loader:Loaded");
				if (loadStat != ""){
					record(loadStat);
				}
			}
			
			handleCookie();
			outputText = new TextField();
			today = new Date();
			outputText.x = 20;
			outputText.y = 100;
			outputText.background = true;
			outputText.autoSize = TextFieldAutoSize.LEFT;
			outputText.text = ("WHAT TIME IS IT?" + "\n\n");
			/*spinner = new Spinner();
			spinner.x = 380;
			spinner.y = 265;
			addChild(spinner);*/
			errorBox = new DialogText();
			/*mcProgress = new Progressor();
			mcProgress.x = 550;
			mcProgress.y = 355;
			mcProgress.width = 154;
			mcProgress.height = 30;
			addChild(mcProgress);*/
			//progressText = new TextField();
			//progressText.width = 224;
			//progressText.x = 438;
			//progressText.y = 315;
			//addChild(progressText);
			
			/*tulis2 = new TextField();
			tulis2.width = 124;
			tulis2.x = 0;
			tulis2.y = 523;
			addChild(tulis2);
			*/
			
			connectText = new TextField();
			connectText.width = 264;
			connectText.x = 248;
			connectText.y = 370;
			addChild(connectText);
			format = new TextFormat();
			format.font = "Trajan pro";
			format.color = 0xFFCC00;
			format.size = 14;
			format.align = "center";
			format.bold = true;
			/*progressText.defaultTextFormat = format;
			progressText.text = "initializing...";
			connectText.defaultTextFormat = format;*/
			
			
			//showTimeout();
			
			loadConfigXML();
			/*try {
				
				initConfig();
			} catch (err:Error) {
				if (!(oFlashVars.trace_stats == null) && (oFlashVars.trace_stats == "1")){
					sStat = GetSignedTrackingUrl("o:AS3:XML:LoadError");
					if (sStat != ""){
						record(sStat);
					}
				}
				
				loadConfigXML();
				
				progressText.text = "loading config...";
				return;
			}*/
		}
		public function security(e:LoaderEvent):void{
			trace("error");
		}
		public function PokerLoader()
		{
			xml.load();
			
		}
		
		
		public function handleCookie():void
		{ 	
			
			var Cookies = SharedObject.getLocal("flashCookies", "/");
			//var datalogin = Cookies.data.txt;
			//var datapass = Cookies.data.pass;
			var sessionid = Cookies.data.session;
			
				
				//oFlashVars.pathz = "http://www.cas2.inn";
		
				/*datalogin = "AYUN";
				datapass = "NzdjMTIzOTRlZjdkNGYyM2E4ZmEwN2Q4NzMwOWFmZDk=";
				oFlashVars.ip = "192.168.0.2";
				oFlashVars.connPort = "1500";
				oFlashVars.zone = "naga_poker";
				oFlashVars.serv = 1;
				oFlashVars.pathz = "http://www.cas2.inn";
				
				
		*/
		
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
			var arrsmart;
			arrsmart = paramObj.sfsdata;
				
			datalogin = paramObj.user;
			datapass = paramObj.key;
			
			if (datalogin == undefined || datalogin == null) {
				//datalogin = "SEON8";
				//datapass = "7f87e88a5747cdcecb663df7dec4e4a5c41943cd5bfbaf80a52ff9e5fbbc9431";
			}
				/*oFlashVars.ip = "103.249.162.118";
				oFlashVars.connPort = "9339";
				oFlashVars.zone = "naga_poker";
				oFlashVars.serv = 1;
				oFlashVars.pathz = "http://www.cas2.inn";
				oFlashVars.langs = "CHT";
				oFlashVars.roomid = "1";*/

			oFlashVars.uid = datalogin;
			oFlashVars.pw = datapass;
			oFlashVars.friendlist = ""
			oFlashVars.useZoomForFriends = 1;
			
			
			
			
				
				
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
			var arrsmart;
				arrsmart = paramObj.sfsdata;
			
			if (arrsmart != undefined && arrsmart != null) {
				arrsmart = arrsmart.split(",");
				oFlashVars.ip = arrsmart[0];
				oFlashVars.connPort = arrsmart[1];
				oFlashVars.zone = arrsmart[2];
				oFlashVars.serv = arrsmart[3];
				oFlashVars.pathz = paramObj.paths;
				oFlashVars.langs = arrsmart[4];
				oFlashVars.roomid =paramObj.roomid;
				
			}
			
			
			getlang = new bahasa(oFlashVars.langs,langs);
			
			Security.loadPolicyFile("xmlsocket://"+oFlashVars.ip+":"+oFlashVars.connPort+"")
			var sStat:String;
			try {
				fCookie = new FlashCookie("PokerRetry");
			} catch (err:Error) {
				sStat = GetSignedTrackingUrl(("o:AS3:LoadRetry_" + nRetries) + ":2009-05-04");
				if (sStat != ""){
					record(sStat);
				}
				return;
			}
			
			
			nRetries = fCookie.GetValue("nRetry", -1);
			nRetries++;
			fCookie.SetValue("nRetry", nRetries);
			sStat = GetSignedTrackingUrl(("o:AS3:LoadRetry_" + nRetries) + ":2009-05-04");
			if (sStat != ""){l
				record(sStat);
			}
			
		}
		
		
		public function removeSpinner():void
		{
			removeChild(mcLoader);
			
			mcLoader = null;
			outputText.appendText("\n removed loader assets top1");
			//spinner.stop();
			//removeChild(spinner);
			//spinner = null;
			//removeChild(progressText);
			//progressText = null;
			//removeChild(mcProgress);
			//mcProgress = null;
			
			removeChild(connectText);
			connectText = null;
			try {
				hideTimeout();
			} catch (err:Error) {
			}
			outputText.appendText("removed loader assets bottom");
		}
		public function addLoading():void
		{
			mcLoading = new mc_loading();
			mcLoading.x = 368.1;
			mcLoading.y = 0;
			mcLoading.width = 1150;
			mcLoading.height = 826;
			addChildAt(mcLoading,2);
			//addChildAt(mcBack,1);
		}
		public function removeLoading():void
		{
			if (mcLoading) {
			removeChild(mcLoading);
			//removeChild(mcBack);
			}
			
		}
		public function stopSpinner():void
		{
			/*spinner.stop();
			spinner.zclip.stop();
			spinner.shadow.stop();*/
		}
		
		public function setConnectionText(p__1:String):void
		{
			connectText.text = p__1;
		}
		private function handleFlashVars():void
		{
			//oFlashVars = Object(LoaderInfo(this.root.loaderInfo).parameters);
			oFlashVars = new Object();
			//oFlashVars.uid = "King Ace";
			oFlashVars.rank = "Newbie";
		}
		
		private function initConfig():void
		{
			//if (oFlashVars.jsCallType != "none"){
					//initNonFBBridge();
			//}
			getConfig();
			bConfigLoaded = true;
			parseConfig();
			loadPokerController();
			//loadLoginController();
		}
		
		private function initNonFBBridge():void
		{
			ExternalInterface.addCallback("ShoutResponse", ShoutResponse);
			
		}
		
		public function ShoutResponse(p__1:String)
		{
			oPokerController.onShoutResponse(p__1);
		}
		private function getConfig():void
		{
			var l__1:String;
			var l__2:String;
			var l__3:String;
			var l__4:String;
			var l__5:String;
			
			
			if (ExternalInterface.available){
				//outputText.appendText("\n External called for configXML " + oFlashVars.jsConfig);
				//l__1 = ExternalInterface.call(oFlashVars.jsConfig, "message");
				//if (l__1 != null){
					//configXML = new XML(unescape(l__1));
					outputText.appendText("\n External Interface response: sucess");
					soundXML = new XML("sound/sound.xml");
					emoXML = new XML("../images/txh/emo/np/emo.xml");
					animXML = new XML("../images/txh/np/anim.xml");
				//} else {				  	
					//throw new Error("message xml not loaded");
				//}
				/*
				l__2 = ExternalInterface.call(oFlashVars.jsConfig, "gifts");
				if (l__2 != null){
				} else {
					throw new Error("gifts xml not loaded");
				}
				l__3 = ExternalInterface.call(oFlashVars.jsConfig, "stats");
				if (l__3 != null){
					statsXML = new XML(unescape(l__3));
				} else {
					throw new Error("stats xml not loaded");
				}
				l__4 = ExternalInterface.call(oFlashVars.jsConfig, "sounds");
				if (l__4 != null){
					soundXML = new XML(unescape(l__4));
				} else {
					throw new Error("sound xml not loaded");
				}
				l__5 = ExternalInterface.call(oFlashVars.jsConfig, "popup");
				if (l__5 != null){
					popupXML = new XML(unescape(l__5));
				} else {
					throw new Error("popup xml not loaded");
				}
				
				*/
			} else {
				outputText.appendText("\n External interface is not available for this container.");
				throw new Error("external interface is not available");
			}
		}
		public function getConfigFBML():void
		{	
			
			connectionOut = new LocalConnection();
			connectionOut.addEventListener(StatusEvent.STATUS, onLCStatus);
			connectionOut.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			connectionNameOut = LoaderInfo(this.root.loaderInfo).parameters.fb_local_connection;
			callFBJS(oFlashVars.jsConfig, "message", "fbMessageXml");
		}
		public function callFBJS(p__1:String, ... p__2):void
		{
			outputText.appendText((("\n FBJS bridge call out: " + p__1) + " ") + connectionNameOut);
			if (connectionNameOut){
				connectionOut.send(connectionNameOut, "callFBJS", p__1, p__2);
				outputText.appendText("\n FBJS call made: " + p__2);
			}
			if (fbjsTimeout == null){
				fbjsTimeout = new Timer(5000, 1);
				fbjsTimeout.addEventListener(TimerEvent.TIMER, onFBJSTimeout);
				fbjsTimeout.start();
			}
		}
		private function onFBJSTimeout(p__1:flash.events.TimerEvent):void
		{
			
			var l__2:String;
			stopFBJSTimer();
			loadConfigXML();
			if (!(oFlashVars.trace_stats == null) && (oFlashVars.trace_stats == "1")){
				l__2 = GetSignedTrackingUrl(("o:AS3:SWF:FBBridge:No_Response_" + nRetries) + ":2009-04-13");
				if (l__2 != ""){
					record(l__2);
				}
			}
		}
		private function stopFBJSTimer():void
		{
			if (fbjsTimeout != null){
				fbjsTimeout.removeEventListener(TimerEvent.TIMER, onFBJSTimeout);
				fbjsTimeout.stop();
				fbjsTimeout = null;
			}
		}
		public function onLCStatus(p__1:flash.events.StatusEvent):void
		{
			outputText.appendText((("\n code: " + p__1.code) + " level: ") + p__1.level);
			switch(p__1.level){
				case "status":
				{
					break;
				}
				case "error":
				{
					removeLCListeners();
					loadConfigXML();
					break;
				}
			}
		}
		public function onSecurityError(p__1:flash.events.SecurityErrorEvent):void
		{	
			showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>Security Error.<br>") + " </p>");
			outputText.appendText("\n security error: " + p__1.text);
		}
		private function removeLCListeners():void
		{
			connectionOut.removeEventListener(StatusEvent.STATUS, onLCStatus);
			connectionOut.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		public function onConfigXML(p__1:String):void
		{
		}		
		private function fbCheckConfig():void
		{
			if (((!(configXML == null) && !(statsXML == null)) && !(soundXML == null)) && !(popupXML == null)){
				removeLCListeners();
				bConfigLoaded = true;
				parseConfig();
				loadLoginController();
			}
		}
		public function asMethod(p__1:String):void
		{
			
			outputText.appendText("\n FBJS bridge in: " + unescape(p__1));
		}
		public function fbMessageXml(p__1:String):void
		{
			stopFBJSTimer();
			if ((p__1) != null){
				configXML = new XML(unescape(p__1));
				callFBJS(oFlashVars.jsConfig, "stats", "fbStatsXml");
			} else {
				logException("message xml not loaded");
				removeLCListeners();
				loadConfigXML();
				 
				//progressText.text = "loading config...";
				
			}
		}
		public function fbStatsXml(p__1:String):void
		{ 
			stopFBJSTimer();
			if ((p__1) != null){
				statsXML = new XML(unescape(p__1));
				callFBJS(oFlashVars.jsConfig, "sounds", "fbSoundXml");
			} else {
				logException("stats xml not loaded");
				removeLCListeners();
				loadConfigXML();
				
				//progressText.text = "loading config...";
			}
			
		}
		
		public function fbSoundXml(p__1:String):void
		{
			stopFBJSTimer();
			if ((p__1) != null){
				soundXML = new XML(unescape(p__1));
				callFBJS(oFlashVars.jsConfig, "popup", "fbPopupXml");
			} else {
				logException("sound xml not loaded");
				removeLCListeners();				
				loadConfigXML();
				//progressText.text = "loading config...";
				
			}
		}
		public function fbPopupXml(p__1:String):void
		{
			stopFBJSTimer();
			if ((p__1) != null){
				popupXML = new XML(unescape(p__1));
				fbCheckConfig();
			} else {
				logException("popup xml not loaded");
				removeLCListeners();
				loadConfigXML();
				
				//progressText.text = "loading config...";
			}
		}
		private function logException(p__1:String):void
		{
		}
		private function loadLoginController():void
		{ 	
			lbLoginControl = LibraryManager.libraryManager.createLibrary("loginControl");
			
			lbLoginControl.addEventListener(LibraryEvent.LOAD_COMPLETE, onLoginControllerLoaded);
			lbLoginControl.addEventListener(ProgressEvent.PROGRESS, onLoginControlProgress);
			lbLoginControl.addEventListener(LibraryEvent.LOAD_ERROR, onLoadErrorLogin);
			
			lbLoginControl.loadSWFS_sequential(new Array("LoginController.swf"));
			
		}
		private function onLoginControllerLoaded(p__1:ws.tink.events.LibraryEvent):void
		{
			var l__2:flash.display.Loader = lbLoginControl.getLoader("com.script.poker.LoginController");
			/*oLoginController = Object(l__2.content);
			if (oFlashVars.connPort == null){
				oFlashVars.connPort = 9339;
			}
			oFlashVars.ip = "192";
			oLoginController.initLogin(Object(this), oFlashVars, oFlashVars.ip, oFlashVars.connPort);
			*/loadPokerController();
		}
		public function loadBalanceError(p__1:String):void
		{
			
			switch(p__1){
				case LBEvent.serverStatusError:
				{
					showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>Error Loading Casino List.<br><br>The Casino list may be temporarily unavailable.<br>") + " </p>");
					break;
				}
				case LBEvent.serverListError:
				{	
					showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>Error Parsing Casino List.<br><br>The Casino list may be temporarily unavailable.<br>") + " </p>");
					break;
				}
				case LBEvent.findServerError:
				{
					showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>No valid Casino available.<br>") + " </p>");
					break;
				}
			}
		}
		private function loadPokerController():void
		{				
			lbPokerControl = LibraryManager.libraryManager.createLibrary("pokerControl");
			lbPokerControl.addEventListener(LibraryEvent.LOAD_COMPLETE, onPokerControllerLoaded);
			lbPokerControl.addEventListener(ProgressEvent.PROGRESS, onPokerControlProgress);
			lbPokerControl.addEventListener(LibraryEvent.FILE_COMPLETE, updateProgressIndicator);
			lbPokerControl.addEventListener(LibraryEvent.LOAD_ERROR, onLoadErrorPoker);
			
			startProgressIndicator();
			lbPokerControl.loadSWFS_sequential(new Array("PokerController.swf"));
				
		}
		private function onPokerControllerLoaded(p__1:ws.tink.events.LibraryEvent):void
		{
			
			var l__2:flash.display.Loader = lbPokerControl.getLoader("com.script.poker.PokerController");
			oPokerController = Object(l__2.content);
			
			abPokerControllerLoaded = true;
			loadPopupManifest();
			
		}
		private function onTimeOut(p__1:flash.events.TimerEvent):void
		{
			
			if (timeOut != null){
				timeOut.removeEventListener(TimerEvent.TIMER, onTimeOut);
				timeOut.stop();
				timeOut = null;
			}
			//showTimeout();
			
		}
		private function showTimeout():void
		{
			catchAllMC = new MovieClip();
			btnReload = new RetryButton();
			btnReload.buttonMode = true;
			btnReload.mouseEnabled = true;
			btnReload.addEventListener(MouseEvent.MOUSE_UP, onReloadGame);
			catchAllMC.addChild(btnReload);
			var l__1:flash.text.TextFormat = new TextFormat();
			l__1.font = "_sans";
			l__1.color = 16777215;
			l__1.size = 11;
			l__1.align = "center";
			var l__2:flash.text.TextField = new TextField();
			l__2.y = 55;
			l__2.width = 196;
			l__2.height = 40;
			l__2.multiline = true;
			l__2.wordWrap = true;
			l__2.text = "Note: if this button does not work please refresh your browser.";
			l__2.setTextFormat(l__1);
			catchAllMC.addChild(l__2);
			catchAllMC.x = 544;
			catchAllMC.y = 430;
			addChild(catchAllMC);
		}
		private function hideTimeout():void
		{			
			if (timeOut != null){
				timeOut.removeEventListener(TimerEvent.TIMER, onTimeOut);
				timeOut.stop();
				timeOut = null;
			}
			removeChild(catchAllMC);
		}
		private function onReloadGame(p__1:flash.events.MouseEvent):void
		{
			var l__2:String;
			var l__3:com.script.io.LoadUrlVars;
			btnReload.enabled = false;
			btnReload.mouseEnabled = false;
			btnReload.buttonMode = false;
			if (!(oFlashVars.trace_stats == null) && (oFlashVars.trace_stats == "1")){
				l__2 = GetSignedTrackingUrl(("o:AS3:SWF:RetryPressed_" + nRetries) + ":2009-05-01");
				if (l__2 != ""){
					record(l__2);
				}
			}
			if (oFlashVars.jsCallType == "fbbridge"){
				callFBJS("document.setLocation", oFlashVars.refresh_url);
			} else if (oFlashVars.jsCallType == "none"){
			} else {
				l__3 = new LoadUrlVars();
				if (oFlashVars.refresh_url != null){
					l__3.navigateURL(oFlashVars.refresh_url, "_top");
				}

			}
		}
		
		private function loadPopupManifest():void
		{						
			pbManifest = LibraryManager.libraryManager.createLibrary("popupManifest");
			pbManifest.addEventListener(LibraryEvent.LOAD_COMPLETE, onPopupManifestLoaded);
			pbManifest.addEventListener(ProgressEvent.PROGRESS, onPopupManifestProgress);
			pbManifest.addEventListener(LibraryEvent.FILE_COMPLETE, updateProgressIndicator);
			pbManifest.addEventListener(LibraryEvent.LOAD_ERROR, onLoadErrorPopup);
			pbManifest.loadSWFS_sequential(aPopManifest);
			//bPopupAssetsLoaded = true;
			//loadTableManifest();
		}
		
		private function loadTableManifest():void
		{
			
			//trace ("loadtablemanifest");
			tbManifest = LibraryManager.libraryManager.createLibrary("tableManifest");
			tbManifest.addEventListener(LibraryEvent.LOAD_COMPLETE, onTableManifestLoaded);
			tbManifest.addEventListener(ProgressEvent.PROGRESS, onTableManifestProgress);
			tbManifest.addEventListener(LibraryEvent.FILE_COMPLETE, updateProgressIndicator);
			tbManifest.addEventListener(LibraryEvent.LOAD_ERROR, onLoadErrorTable);
			tbManifest.loadSWFS_sequential(aTableManifest);
			//tbManifest.loadSWFS_sequential("tableView.swf");
		}
		private function loadLobbyManifest():void
		{
			//trace ("lobby manifest");
			lbManifest = LibraryManager.libraryManager.createLibrary("lobbyManifest");
			lbManifest.addEventListener(LibraryEvent.LOAD_COMPLETE, onLobbyManifestLoaded);
			lbManifest.addEventListener(ProgressEvent.PROGRESS, onLobbyManifestProgress);
			lbManifest.addEventListener(LibraryEvent.FILE_COMPLETE, updateProgressIndicator);
			lbManifest.addEventListener(LibraryEvent.LOAD_ERROR, onLoadErrorLobby);
			lbManifest.loadSWFS_sequential(new Array("lobbyView.swf"));
			
		}
		private function loadConfigXML():void
		{	
			//bConfigLoaded = true;
			//parseConfig();
			//onXMLManifestLoaded();
			createXMLManifest();
			cfgManifest = LibraryManager.libraryManager.createLibrary("cfgManifest");
			cfgManifest.addEventListener(LibraryEvent.LOAD_COMPLETE, onXMLManifestLoaded);
			cfgManifest.addEventListener(LibraryEvent.LOAD_ERROR, onLoadErrorXML);
			cfgManifest.loadXMLS_sequential(aXMLManifest);
			
		}
		private function onPopupManifestLoaded(p__1:ws.tink.events.LibraryEvent):void
		{
			bPopupAssetsLoaded = true;
			loadTableManifest();
		}
		private function onTableManifestLoaded(p__1:ws.tink.events.LibraryEvent):void
		{
			bTableAssetsLoaded = true;
			loadLobbyManifest();
		}
		private function onLobbyManifestLoaded(p__1:ws.tink.events.LibraryEvent):void
		{
			bLobbyAssetsLoaded = true;
			//progressText.text = "Loading Complete sukses.";
			
			bLobbyAssetsLoaded = true;
			bLobbyJoinComplete = true;
			if (bLobbyJoinComplete && bLobbyAssetsLoaded){
				startPokerController();
			}
			
		}
		//IF(OR(AND(C5<>"",D5=0,E5=0),AND(C5<>"",D5>0,E5=0)),VLOOKUP(C5,AKUN,2,0),IF(AND(C5<>"",D5=0,E5>0),CONCATENATE("          "),""))
		private function onXMLManifestLoaded(p__1:ws.tink.events.LibraryEvent):void
		//private function onXMLManifestLoaded():void
		{				

			//var l__2:flash.net.URLLoader = cfgManifest.getXML(aXMLManifest[2]);
			//configXML = new XML(l__2.data);
			//var l__3:flash.net.URLLoader;
			//l__3 = cfgManifest.getXML(aXMLManifest[3]);
			//popupXML = new XML(l__3.data);
			//l__3 = cfgManifest.getXML(aXMLManifest[1]);
			//statsXML = new XML(l__3.data);
			var l__3 = cfgManifest.getXML(aXMLManifest[0]);
			soundXML = new XML(l__3.data);
			
			var l__4 = cfgManifest.getXML(aXMLManifest[1]);
			emoXML = new XML(l__4.data);
			
			var l__5 = cfgManifest.getXML(aXMLManifest[2]);
			animXML = new XML(l__5.data);
			
			bConfigLoaded = true;
			parseConfig();
			loadPokerController();
			
			//loadLoginController();
		}
		private function onLoginControlProgress(p__1:flash.events.ProgressEvent):void
		{
			showProgress(p__1.bytesLoaded, p__1.bytesTotal);
		}
		private function onPokerControlProgress(p__1:flash.events.ProgressEvent):void
		{
			nPkLoaded = p__1.bytesLoaded;
			nPkTotal = p__1.bytesTotal;
			showProgress(p__1.bytesLoaded, p__1.bytesTotal);
		}
		private function onPopupManifestProgress(p__1:flash.events.ProgressEvent):void
		{
			
			//nPploaded = p__1.
			nPpLoaded = p__1.bytesLoaded;
			nPpTotal = p__1.bytesTotal;
			showProgress(p__1.bytesLoaded, p__1.bytesTotal);
		}
		private function onTableManifestProgress(p__1:flash.events.ProgressEvent):void
		{
			
			nTbLoaded = p__1.bytesLoaded;
			nTbTotal = p__1.bytesTotal;
			showProgress(p__1.bytesLoaded, p__1.bytesTotal);
			
		}
		private function onLobbyManifestProgress(p__1:flash.events.ProgressEvent):void
		{
			nLbLoaded = p__1.bytesLoaded;
			nLbTotal = p__1.bytesTotal;
			showProgress(p__1.bytesLoaded, p__1.bytesTotal);
		}
		private function showProgress(p__1:uint, p__2:uint):void
		{ 
			var l__3:Number = 0;
			if (((p__1) > 0) && ((p__2) > 0)){
				l__3 = ((p__1) / (p__2));
				//mcProgress.updateProgress(l__3);
			} else {
				//mcProgress.updateProgress(0);
			}
			showAggregateProgress(p__1, p__2)
		}
		private function showAggregateProgress(p__1:uint, p__2:uint):void
		{
			
			
			var l__6 = 100/nTotalAssets;
			var l__1 = (p__1 / p__2)*l__6
						
			c_LoadFrame = c_Loaded + l__1
			
			var l__2 = Math.floor(c_LoadFrame);
			//mcLoader.mcProgress.gotoAndStop(l__2);
			if (Number(l__2) > 100){
				mcLoader.txt.text = "100%";
				mcLoader.loading_depan1.text=langs.l_loadingfinish1;
				mcLoader.loading_depan2.text=langs.l_pleasewaitfront2;
			}else {
				
				
				mcLoader.txt.text =l__2+"%";
				mcLoader.loading_depan1.text=langs.l_pleasewaitfront1;
				mcLoader.loading_depan2.text="";
				mcLoader.preload1.gotoAndStop(+l__2);
			}
			//mcLoader.txt2.text = langs.l_loading;
			if (p__1 >= p__2){
				c_Loaded = c_Loaded+l__1
			}
		}
		private function startProgressIndicator():void
		{
			//nTotalAssets = ((aTableManifest.length + aPopManifest.length) + 2);
			nTotalAssets = ((aTableManifest.length + aPopManifest.length) + 1);
			nAssetCount = 1;	
			/*mcBack = new mc_bg();
			mcBack.x = 360;
			mcBack.y = 330.95;
			mcBack.width = 1154.3;
			mcBack.height = 825.2;
			addChildAt(mcBack,1);
			mcBack.loading_finish1.text=langs.l_loadingfinish1;
			mcBack.loading_finish2.htmlText=langs.l_refreshweb1;*/
			//progressText.text = ((("Loading " + nAssetCount) + " of ") + nTotalAssets);
			//mcProgress.updateProgress(0);
			
		}
		private function updateProgressIndicator(p__1:ws.tink.events.LibraryEvent):void
		{
			
			nAssetCount++;
			if (nAssetCount <= nTotalAssets){
				//progressText.text = ((("Loading " + nAssetCount) + " of ") + nTotalAssets);
			}
			
		}
		private function onLoadErrorLogin(p__1:ws.tink.events.LibraryEvent):void
		{
			assetErrorStat("LoginController");
			showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>Login Controller Failed.<br>") + " </p>");
		}
		private function onLoadErrorPoker(p__1:ws.tink.events.LibraryEvent):void
		{			
			assetErrorStat("PokerController");
			showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>Poker Controller Failed.<br>") + "</p>");
		}
		private function onLoadErrorPopup(p__1:ws.tink.events.LibraryEvent):void
		{
			assetErrorStat("Popups");
			showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>Popup Controller Failed.<br>") + "</p>");
		}
		private function onLoadErrorTable(p__1:ws.tink.events.LibraryEvent):void
		{
			assetErrorStat("Table");
			showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>Table Controller Failed.<br>") + " </p>");
		}
		private function onLoadErrorLobby(p__1:ws.tink.events.LibraryEvent):void
		{
			assetErrorStat("Lobby");
			showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>Lobby Controller Failed.<br>") + "</p>");
		}
		private function onLoadErrorXML(p__1:ws.tink.events.LibraryEvent):void
		{
			assetErrorStat("XML");
			showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>Lobby Controller Failed XML.<br>") + " </p>");
		}
		private function assetErrorStat(p__1:String):void
		{
			var l__2:String;
			if (!(oFlashVars.trace_stats == null) && (oFlashVars.trace_stats == "1")){
				l__2 = GetSignedTrackingUrl(((("o:AS3:SWF:LoadFail:" + p__1) + "_") + nRetries) + ":2009-04-15");
				if (l__2 != ""){
					record(l__2);
				}
			}
		}

		private function parseConfig():void
		{
			createLobbyManifest();
			createTableManifest();
			createPopupManifest();
		}
		private function loadAssets():void
		{
			loadPopupManifest();
			loadTableManifest();
			loadLobbyManifest();
		}
		private function createLobbyManifest():void
		{
			aLobbyManifest = new Array();
		}
		private function createTableManifest():void
		{	
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
			var arrTable;
			var loadTable;
				//arrTable = "tablenp,table02,table03,table04,table05"
				arrTable = paramObj.arrTable;
				loadTable = paramObj.loadTable;
				
				//arrTableBG
			//tulis2.text = arrTable;
			arrTableBG = new Array();
			aTableManifest = new Array();
			aTableManifest.push("tableView.swf");
			if (arrTable != undefined && arrTable != null) {
				arrTable = arrTable.split(",");
				loadTable = loadTable.split(",");
			so1TableBG = "../images/txh/"+loadTable[0]+".jpg"
			so2TableBG = "../images/txh/"+loadTable[0]+".jpg"
			so3TableBG = "../images/txh/"+loadTable[0]+".jpg"
			}
			
			/*
			if (oFlashVars.isWSOP == "1"){
				so1TableBG = "http://statics.poker.static.script.com/poker/img/as3tables/shootoutRound10001.jpg";
				so2TableBG = "http://statics.poker.static.script.com/poker/img/as3tables/shootoutRound20001.jpg";
				so3TableBG = "http://statics.poker.static.script.com/poker/img/as3tables/shootoutRound30001.jpg";
			}
			*/
			oFlashVars.tourneyId = -1;
			if (int(oFlashVars.tourneyId) > -1){
				if (!(oFlashVars.promoTableBG == null) && !(oFlashVars.promoTableBG == "")){
					aTableManifest.push(oFlashVars.promoTableBG);
				} else {
					aTableManifest.push(tnyTableBG);
				} 
			} else {
				aTableManifest.push(stdTableBG);
				aTableManifest.push(vipTableBG);
				aTableManifest.push(so1TableBG);
				aTableManifest.push(so2TableBG);
				aTableManifest.push(so3TableBG);
				if (arrTable != undefined && arrTable != null) {
					
				for (var t=0; t<arrTable.length; t++) {
					arrTableBG[t] = "../images/txh/"+loadTable[arrTable[t]]+".jpg"
					//aTableManifest.push("../images/txh/"+arrTable[t]+".jpg");
					
				}
				for (var l=0; l<loadTable.length; l++) {
					aTableManifest.push("../images/txh/"+loadTable[l]+".jpg");
					
				}
				}
			} 
		}
		private function createPopupManifest():void
		{
			//var l__1;
			
			//var l__1:XMLList = popupXML.child("popup");
			aPopManifest = new Array();
			aPopManifest.push("popupView.swf");	
			aPopManifest.push("TableCashier.swf");
			aPopManifest.push("CreateTable.swf");
			aPopManifest.push("SingleInputGenericPanel.swf");
			aPopManifest.push("TransferChips.swf");
			aPopManifest.push("ErrorPop.swf");
			aPopManifest.push("ChangePass.swf");
			aPopManifest.push("EmoPanel.swf");
			aPopManifest.push("DSGPanel.swf");
			aPopManifest.push("ProfilePanel.swf");
			aPopManifest.push("BaseballCard.swf");
			aPopManifest.push("BuddyDialog.swf");
			aPopManifest.push("ReportError.swf");
			aPopManifest.push("EventPanel.swf");
			
		}
		private function createXMLManifest():void
		{
			//var l__1:String = oFlashVars.httpPopup;
			aXMLManifest = new Array();
			aXMLManifest.push("sound/sound.xml");
			aXMLManifest.push("../images/txh/emo/np/emo.xml");
			aXMLManifest.push("../images/txh/anim/np/anim.xml");
		}
		
		private function getPopupModules(p__1:XMLList):Array
		{
			
		/*
			var l__3:String;
			var l__4:XML;
			var l__2:Array = new Array();
			for each (l__4 in p__1){
				l__3 = l__4.child("content").child("module").attribute("src");
				if (l__3 != ""){
					if (l__2.indexOf(oFlashVars.basePath + l__3) == -1){
						l__2.push(oFlashVars.basePath + l__3);
					}
				}
			}
			return(l__2);
			
			*/
		}
		
		private function getGiftAssets(p__1:XMLList):Array
		{
			var l__3:String;
			var l__4:XML;
			var l__2:Array = new Array();
			for each (l__4 in p__1){
				l__3 = ("./" + l__4.@url);
				if (l__3 != ""){
					l__2.push(oFlashVars.basePath + l__3);
				}
			}
			return(l__2);
		}
		public function connectionFailed():void
		{
			showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>You could not connect to the server.<br><br>The server may be down for maintenance.<br> Your firewall may be blocking access to port 9339.<br>") + " </p>");
		}
		public function loginFailed():void
		{
			showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>Login Failed (#0001).<br>") + " </p>");
		}
		
		public function loginSFFailed(p__1:String = ""):void
		{
			if (!((p__1) == "") && ((p__1.length) > 0)){
				showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>" + p__1 + "<br>") +"</p>");
			} else {
				showError(("<p align=\'center\'><b>Texas Hold\'em Message</b><br><br>Login Failed (#0002).<br>") + " </p>");
			}
			bSFLoginFailed = true;
		}
		
		public function showError(inErr:String):void
		{
			if (bSFLoginFailed){
				return;
			}
			try {
				hideTimeout();
				removeChild(errorBox);
				removeChild(btnTryAgain);
				
			} catch (err:Error) {
			}
			errorBox.field.htmlText = inErr;
			addChild(errorBox);
			
			if (oFlashVars.jsCallType == "none"){
				errorBox.field.htmlText = (errorBox.field.htmlText + "<br><br>Please Refresh the page to try again.");
			} else {
				
				btnTryAgain = new PokerButton(myriadTF, "large", "Try Again", null, 100, 3);
				btnTryAgain.x = (380 - (btnTryAgain.width >> 1));
				btnTryAgain.y = 345;
				addChild(btnTryAgain);
				btnTryAgain.addEventListener(MouseEvent.MOUSE_UP, onTryAgain);
			}
		}
		
		public function onTryAgain(p__1:flash.events.MouseEvent):void
		{
			
			var l__2:String;
			//
			var l__z:Object = new Object();
			var l__3:com.script.io.LoadUrlVars;
			if (!(oFlashVars.trace_stats == null) && (oFlashVars.trace_stats == "1")){
				l__2 = GetSignedTrackingUrl(("o:AS3:SWF:TryAgainPressed_" + nRetries) + ":2009-04-15");
				if (l__2 != ""){
					record(l__2);
				}
			}
			if (oFlashVars.jsCallType == "fbbridge"){
				callFBJS("document.setLocation", oFlashVars.refresh_url);
			} else if (oFlashVars.jsCallType == "none"){
			} else {
				
				l__3 = new LoadUrlVars();
				if (oFlashVars.refresh_url != null){
					l__3.navigateURL(oFlashVars.refresh_url, "_top");
				}
			}
		}
		
		public function startPokerController():void
		{
			var sStat:String;
			if (timeOut != null){
				timeOut.removeEventListener(TimerEvent.TIMER, onTimeOut);
				timeOut.stop();
				timeOut = null;
				
			}
			try {
				removeChild(errorBox);
				removeChild(btnTryAgain);
				
			} catch (err:Error) {
				trace ("Broken")
			}
			try {
				//oPokerController.forTest();
				//oPokerController.init(this, oFlashVars, pbManifest, lbLoginControl, lbManifest, tbManifest, cfgManifest, oLoginController.lcmConnect, oLoginController.pgData, oLoginController.loadBalance);
				trace("masa ga")
				oPokerController.init(this, oFlashVars, pbManifest, lbLoginControl, lbManifest, tbManifest, cfgManifest);
				trace("sek cong")
			} catch (err:Error) {
				//record("http://facebook.poker.script.com/poker/error_logger_AS3SWF_error_pc_" + escape((err.name + ":") + err.message));
				if (!(oFlashVars.trace_stats == null) && (oFlashVars.trace_stats == "1")){
					//sStat = GetSignedTrackingUrl(((("o:AS3:SWF:PokerController:" + escape(err.name)) + "_") + nRetries) + ":2009-04-10");
					if (sStat != ""){
						record(sStat);
					}
				}
				return;
			}
			
			
			//oLoginController.removeListeners();
			if (oFlashVars.sn_id == "7"){
				//if (ExternalInterface.available){
					//ExternalInterface.call("ZY.App.f.SWFLoaded");
				//}
			}
		}
		public function record(p__1:String):void
		{
			var l__3:com.script.io.LoadUrlVars;
			var l__2:String = LoaderInfo(this.root.loaderInfo).parameters.trace_stats;
			if (l__2 == "1"){
				l__3 = new LoadUrlVars();
				l__3.loadURL(p__1, {}, "POST");
			}
		}
		public function GetSignedTrackingUrl(p__1:String):String
		{
			var l__2:String;
			if ((oFlashVars.fg == null) || (oFlashVars.fg == "")){
				return("");
			}
			if (oFlashVars.sn_id == "1"){
				l__2 = "FB";
			} else {
				return("");
			}
			p__1 = ((((("Poker_FG " + l__2) + " Flash:AS3 Other Unknown ") + p__1) + " fg:") + oFlashVars.fg);
			var l__3:* = "SxC1ZN";
			var l__4:String = MD5.hash((p__1 + l__3));
			//var l__5:String = ((("http://nav3.script.com/link/link.php?item=" + escape(p__1)) + "&ltsig=") + escape(l__4));
			return 0;
		}
	}
}
