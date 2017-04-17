package com.script.poker
{
	import com.script.poker.lobby.RoomItem;
	import com.script.poker.lobby.LobbyController;
	import com.script.poker.table.TableController;
	import com.script.poker.table.GiftLibrary;
	import com.script.poker.table.EmoLibrary;
	import com.script.poker.popups.PopupController;
	import com.script.User;
	import ws.tink.core.Library;
	import flash.net.URLRequest;
	import flash.net.LocalConnection;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.EventDispatcher;
	import it.gotoandplay.smartfoxserver.*;
	import com.script.poker.events.*;
	import com.script.poker.lobby.events.LCEvent;
	import com.script.poker.protocol.ProtocolEvent;
	import com.script.poker.protocol.SSuperLogin;
	import com.script.poker.protocol.SCreateBucketRoom;
	import com.script.poker.protocol.SCreateRoom;
	import com.script.poker.protocol.SChangePass;
	import com.script.poker.protocol.SSuperJoinRoom;
	import com.script.poker.protocol.SJoinRoom;
	import com.script.poker.protocol.RRoomPass;
	import com.script.poker.protocol.SSit;
	import com.script.poker.protocol.SReport;
	import com.script.poker.protocol.SShowGift;
	import com.script.poker.protocol.SShowGift3;
	import com.script.poker.protocol.SShowEmo;
	import com.script.poker.protocol.SIgnoreBuddy;
	import com.script.poker.protocol.SReportUser;
	import com.script.poker.protocol.RSetMod;
	import com.script.poker.protocol.RDisplayRoom;
	import com.script.poker.protocol.SBuyGift2;
	import com.script.poker.protocol.RAdminMessage;
	import com.script.poker.protocol.SAddPoints;
	import com.script.poker.protocol.SBuyGift;
	import com.script.poker.protocol.SBuyEmo;
	import com.script.poker.protocol.RJoinRoom;
	import com.script.poker.protocol.RRoomPicked;
	import com.script.poker.protocol.ROutOfChips;
	import com.script.poker.protocol.RJoinRoomError;
	import com.script.poker.protocol.RGiftTooExpensive;
	import com.script.poker.protocol.RCreateRoomRes;
	import com.script.poker.protocol.SHideVIP;
	import com.script.poker.protocol.RUserShootoutState;
	import com.script.poker.protocol.SQueryGifts;
	import com.script.poker.protocol.RGiftInfo2;
	import com.script.poker.protocol.REmoInfo;
	import com.script.poker.protocol.RShootoutConfig;
	import com.script.poker.protocol.SQueryGifts2;
	import com.script.poker.protocol.RLogin;
	import com.script.poker.protocol.RLogData;
	import com.script.poker.protocol.RShowMessage;
	import com.script.poker.protocol.SAddBuddy;
	import com.script.poker.protocol.SSendInvite;
	import com.script.poker.protocol.RInviteSend;
	import com.script.poker.protocol.RDisplayRoomList;
	import com.script.poker.protocol.SStandUp;
	import com.script.poker.protocol.SGetRoomPass;
	import com.script.poker.protocol.SIgnoreAllBuddy;
	import com.script.poker.protocol.SAlertPublished;
	import com.script.poker.protocol.RGiftPrices2;
	import com.script.poker.protocol.REmoPrices;
	import com.script.poker.protocol.SAcceptBuddy;
	import com.script.poker.protocol.SGiftChips;
	import com.script.poker.protocol.SReplayState;
	import com.script.poker.protocol.RLogKO;
	import com.script.poker.protocol.SGetGiftInfo2;
	import com.script.poker.protocol.SGetGiftPrices2;
	import com.script.poker.protocol.SGetEmoInfo;
	import com.script.poker.protocol.SGetEmoPrices;
	import com.script.poker.protocol.SPickRoom;
	import com.script.poker.protocol.SGetUserShootoutState;
	import com.script.poker.protocol.REventInfo;
	import com.script.zoom.*;
	import com.script.poker.shootout.ShootoutConfig;
	import com.script.poker.shootout.ShootoutUser;
	import com.script.poker.commonUI.events.*;
	import com.script.poker.table.events.TCEvent;
	import com.script.poker.nav.*;
	import flash.system.*;
	import ws.tink.events.LibraryEvent; 
	import com.script.poker.lobby.events.controller.JoinTableEvent;
	import flash.utils.Timer;
	import com.script.utils.FlashCookie;
	import com.script.zoom.messages.ZoomTableInvitationMessage;
	import com.adobe.crypto.*;
	import com.script.format.*;
	import com.script.poker.commonUI.CommonUIController;
	import com.gskinner.utils.SWFBridgeAS3;
	import com.script.io.LoadUrlVars;
	import com.script.io.SmartfoxConnectionManager;
	import flash.external.*;
	
	import flash.media.SoundMixer;
	public class PokerController extends flash.display.MovieClip
	{
		public var viewer:com.script.User;
		public var main:Object;
		public var ldr:flash.display.Loader;
		public var zoomControl:com.script.zoom.ZshimController = null;
		public var pStats:com.script.poker.PokerStatsManager;
		private var popupControl:com.script.poker.popups.PopupController;
		public var zoomModel:com.script.zoom.ZshimModel;
		public var loadBalancer:com.script.poker.LoadBalancer;
		private var lcmConnect:Object;
		public var pokerSoundManager:com.script.poker.PokerSoundManager;
		public var soUser:com.script.poker.shootout.ShootoutUser = null;
		private var bInTableRoom:Boolean = false;
		private var bDisplayPopups:Boolean = false;
		public var bInLobbyRoom:Boolean = false;
		private var lobbyControl:com.script.poker.lobby.LobbyController;
		private var bTableInitialized:Boolean = false;
		private var bDisplayTable:Boolean = false;
		private var tableControl:com.script.poker.table.TableController;
		private var pcmConnect:com.script.poker.PokerConnectionManager;
		public var bDisplayLobby:Boolean = false;
		private var library:ws.tink.core.Library;
		public var soConfig:com.script.poker.shootout.ShootoutConfig = null;
		public var mainDisplay:flash.display.MovieClip;
		public var timerUserPresence:flash.utils.Timer;
		public var runTextPresence:flash.utils.Timer;
		public var timerChatPresence:flash.utils.Timer;
		public var lcBridge:com.gskinner.utils.SWFBridgeAS3;
		private var rejoinStakesUpdate:flash.utils.Timer;
		private var commonControl:com.script.poker.commonUI.CommonUIController;
		private var nRetries:int;
		public static var pgData:com.script.poker.PokerGlobalData;
		public static var aStatsHash:Array = null;
		public var loadBalance:com.script.poker.LoadBalancer;
		public var navControl:com.script.poker.nav.NavController;
		public var addload = false;
		public var spr=0;
		public var ryl=0;
		public var str =0;
		public var fourk =0;
		//public var mc_run:flash.display.MovieClip;
		public function PokerController()
		{
			
			//Security.allowDomain("facebook.poker.script.com");
			//Security.allowDomain("apps.facebook.com");
			//forTest();
			if (aStatsHash == null){
				aStatsHash = new Array();
			}	
		}
		public function forTest() {
			
				return true;
		}
		
		//public function init(inMain:flash.display.MovieClip, inPGData:Object):void
		//public function init(inMain:flash.display.MovieClip, inFlashVars:Object, inPopupLib:ws.tink.core.Library, inLoginLib:ws.tink.core.Library, inLobbyLib:ws.tink.core.Library, inTableLib:ws.tink.core.Library, inConfigLib:ws.tink.core.Library, inLoginConnect:Object, inPGData:Object, inMain0:Object):void
		public function init(inMain:flash.display.MovieClip, inFlashVars:Object, inPopupLib:ws.tink.core.Library, inLoginLib:ws.tink.core.Library, inLobbyLib:ws.tink.core.Library, inTableLib:ws.tink.core.Library, inConfigLib:ws.tink.core.Library):void
		{
			//var inFlashVars:Object=new Object();
			main = Object(inMain);
			//lcmConnect = inLoginConnect;
			pgData = new PokerGlobalData();
			nRetries = pgData.nRetries;
			
			pgData.langs = main.langs
			
			//loadBalancer = LoadBalancer(inLoadBalance);
			pgData.assignFlashVars(inFlashVars);
			pgData.lbPopup = inPopupLib;
			pgData.lbLobby = inLobbyLib;
			pgData.lbTable = inTableLib;
			pgData.lbConfig = inConfigLib;
			//pgData.xmlPopups = main.popupXML;
			pgData.xmlSounds = main.soundXML;
			//pgData.xmlStats = main.statsXML;
			pgData.stdTableBG = main.stdTableBG;
			pgData.arrTableBG = main.arrTableBG;
			pgData.vipTableBG = main.vipTableBG;
			pgData.tnyTableBG = main.tnyTableBG;
			pgData.so1TableBG = main.so1TableBG;
			pgData.so2TableBG = main.so2TableBG;
			pgData.so3TableBG = main.so3TableBG;
			//pStats = new PokerStatsManager(pgData.xmlStats);
			//npStats.startPokerStatsManager(pgData);
			viewer = new User(pgData.zid);
			//viewer = "1134";
			
			pgData.viewer = viewer;
			popupControl = new PopupController();
			lobbyControl = new LobbyController();
			tableControl = new TableController();
			commonControl = new CommonUIController();
			//popupControl.upper.text="aaa";
			//soConfig = new ShootoutConfig();
			//soUser = new ShootoutUser();
			/*try {
				lcBridge = new SWFBridgeAS3(inFlashVars.connection_id, inMain);
			} catch (evt:Error) {
				trace ("eror")
			}*/
			lobbyControl.plModel.langs = pgData.langs;
			lobbyControl.plModel.roomid = main.oFlashVars.roomid;
			
			pcmConnect = new PokerConnectionManager(pgData.sfhost,pgData.sfport,pgData.langs);
			//loadBalance = new LoadBalancer(pgData);
			pcmConnect.connect();
			
			pcmConnect.initProtocolListeners();
			pcmConnect.addEventListener(SmartfoxConnectionManager.CONNECTED, onConnectionHandler);
			pcmConnect.addEventListener(ProtocolEvent.onMessage, onProtocolMessage);
			//pcmConnect.loginHandler("logOK");
			//var l__6 = new Object();
			//l__6.type = "ScekxLogin";
			//pcmConnect.sendMessage(l__6);
			pgData.rejoinRoom = -1;
			//pcmConnect.onExtensionHandler(lcmConnect.sfeLogin);
			//pcmConnect.onRoomListUpdate(lcmConnect.sfeRoomList);
			//pcmConnect.onJoinRoomHandler(lcmConnect.sfeJoinRoom);
			//if (lcmConnect.sfeSetMod != null){
				//pcmConnect.onExtensionHandler(lcmConnect.sfeSetMod);
			//}
			
			checkLobbyAssets();
			checkPopupAssets();
			checkTableAssets();
			checkConfigLoaded();
			handleUserPresence();
			checkAllAssets();
			
		}
		public function initFBJS(p__1:flash.net.LocalConnection, p__2:String, p__3:flash.net.LocalConnection, p__4:String):void
		{
			pgData.connectionIn = p__1;
			pgData.connectionNameIn = p__2;
			pgData.connectionOut = p__3;
			pgData.connectionNameOut = p__4;
			pgData.connectionIn.client = this;
			
		}
		private function checkLobbyAssets():void
		{
			if (main.bLobbyAssetsLoaded){
				bDisplayLobby = true;
			} else {
				pgData.lbLobby.addEventListener(LibraryEvent.LOAD_COMPLETE, onLobbyLoaded);
			}
		}
		private function checkPopupAssets():void
		{
			if (main.bPopupAssetsLoaded){
				bDisplayPopups = true;
			} else {
				pgData.lbPopup.addEventListener(LibraryEvent.LOAD_COMPLETE, onPopupLoaded);
			}
		}
		private function onLobbyLoaded(p__1:ws.tink.events.LibraryEvent):void
		{
			pgData.lbLobby.removeEventListener(LibraryEvent.LOAD_COMPLETE, onLobbyLoaded);
			main.bLobbyAssetsLoaded = true;
			bDisplayLobby = true;
			checkAllAssets();
		}
		
		private function onPopupLoaded(p__1:ws.tink.events.LibraryEvent):void
		{
			pgData.lbPopup.removeEventListener(LibraryEvent.LOAD_COMPLETE, onPopupLoaded);
			main.bPopupAssetsLoaded = true;
			bDisplayPopups = true;
			checkAllAssets();
		}
		
		private function checkTableAssets()
		{
			if (main.bTableAssetsLoaded){
				bDisplayTable = true;
			} else {
				pgData.lbTable.addEventListener(LibraryEvent.LOAD_COMPLETE, onTableLoaded);
			}
		}
		private function onTableLoaded(p__1:ws.tink.events.LibraryEvent):void
		{
			pgData.lbTable.removeEventListener(LibraryEvent.LOAD_COMPLETE, onTableLoaded);
			main.bTableAssetsLoaded = true;
			bDisplayTable = true;
			checkAllAssets();
		}
		
		private function checkAllAssets():void
		{
			var l__1:String;
			var l__2:com.script.io.LoadUrlVars;
			if ((main.bPopupAssetsLoaded && main.bLobbyAssetsLoaded) && main.bTableAssetsLoaded){
				if (pgData.trace_stats == 1){
					l__1 = pgData.GetSignedTrackingUrl(("o:AS3:SWF:Assets:AllLoaded_" + nRetries) + ":2009-02-05");
					l__2 = new LoadUrlVars();
					l__2.loadURL(l__1, {}, "POST");
				}
				initPopups();
				initCommonUI();
				initLobby();
				
			}
		}
		private function checkConfigLoaded():void
		{
			main.bConfigLoaded = true;
			initConfig();
			
			/*
			if (main.bConfigLoaded){
				initConfig();
			} else {
				pgData.lbConfig.addEventListener(LibraryEvent.LOAD_COMPLETE, onConfigLoaded);
			}
			*/
		}
		private function onConfigLoaded(p__1:ws.tink.events.LibraryEvent):void
		{
			main.bConfigLoaded = true;
			initConfig();
		}
		public function regPopup(p__1:Object) {
			//var l__1 = p__1;
			//var l__2 = p__2;
			//var l__1:Object = new Object();
			//l__1.type = p__1;
			//l__1.nsit = p__2;
			popupControl.regonPopup(p__1);
		}
		public function regErrorPopup(p__1:Object) {
			//var l__1 = p__1;
			//var l__2 = p__2;
			//var l__1:Object = new Object();
			//l__1.type = p__1;
			//l__1.nsit = p__2;
			popupControl.regonErrorPopup(p__1);
		}
		private function initPopups():void
		{
			popupControl.startPopupController(main, pgData, this, lobbyControl, tableControl);
			
		}
		private function initLobby():void
		{
			trace("wtd");
			lobbyControl.addEventListener(LCEvent.VIEW_INIT, onLobbyInit);
			lobbyControl.addEventListener(LCEvent.JOIN_TABLE, onJoinTable);
			lobbyControl.addEventListener(LCEvent.CONNECT_TO_NEW_SERVER, onServerChosen);
			lobbyControl.addEventListener(LCEvent.FIND_SEAT, onFindSeat);
			lobbyControl.addEventListener(LCEvent.SHOW_FRIEND_SELECTOR, onShowFriendSelectorLobby);
			lobbyControl.addEventListener(LCEvent.HIDE_FRIEND_SELECTOR, onHideFriendSelectorLobby);
			lobbyControl.addEventListener(LCEvent.PRIVATE_TABLE_CLICK, onPrivateTableClick);
			lobbyControl.startLobbyController(main, pgData, pcmConnect, this, bInLobbyRoom, lcmConnect);
			//main.removeSpinner();
			//main.addLoading();
			addload = true;
			pokerSoundManager = new PokerSoundManager(pgData.xmlSounds);
			
		}
		private function initCommonUI():void
		{			
			commonControl.startCommonUIController(main, pgData, pcmConnect, this);
			commonControl.addEventListener(CommonCEvent.HIDE_FRIEND_SELECTOR, tableControlHideZLive);
			commonControl.addEventListener(CommonCEvent.SHOW_FRIEND_SELECTOR, tableControlShowZLive);
			dispatchEvent(new PCEvent(PCEvent.INIT_COMMON_UI));
		}
		private function tableControlHideZLive(p__1:flash.events.Event)
		{
			tableControl.onHideFriendSelectorTC();
		}
		private function tableControlShowZLive(p__1:flash.events.Event)
		{
			tableControl.onShowFriendSelectorTC();
		}
		private function initTable():void
		{
			if (bTableInitialized == false){
				initGifts();
				tableControl.addEventListener(TCEvent.VIEW_INIT, onTableInit);
				tableControl.addEventListener(TCEvent.LEAVE_TABLE, onLeaveTable);
				tableControl.addEventListener(TCEvent.STAND_UP, onStandUp);
				tableControl.startTableController(main, pgData, pcmConnect, this, bInTableRoom);
				tableControl.addEventListener(TCEvent.PLAY_SOUND_ONCE, onPlaySoundOnce);
				tableControl.addEventListener(TCEvent.STOP_SOUND, onStopSound);
				tableControl.addEventListener(TCEvent.TOGGLE_MUTE_SOUND, onToggleMuteSoundPressed);
				tableControl.addEventListener(TCEvent.FRIEND_NET_PRESSED, onFreindNetworkPressed);
				bTableInitialized = true;
			} else {
				tableControl.enableProtocol();
			}
		}
		private function initBuddyInvites():void
		{
			pgData.aBuddyInvites = new Array();
		}
		private function initGifts():void
		{
		}
		private function getGiftInfo2(p__1:Number):void
		{
			if (GiftLibrary.GetInst().HasLoadedAllGiftInfo()){
				return;
			}
			pcmConnect.sendMessage(new SGetGiftInfo2("SGetGiftInfo2", p__1));
		}
		private function getEmoInfo(p__1:Number):void 
		{
			if (EmoLibrary.GetInst().HasLoadedAllEmoInfo()){
				return;
			}
			pcmConnect.onEmoInfo(main.emoXML, main.animXML)
			//pcmConnect.sendMessage(new SGetGiftInfo2("SGetGiftInfo2", p__1));
			
			
		}
		private function getGiftPrices():void
		{
			
		}
		public function getGiftPrices2(p__1:Number, p__2:String):void
		{
			
			pcmConnect.sendMessage(new SGetGiftPrices2("SGetGiftPrices2", p__1, p__2));
		}
		public function getEmoPrices(p__1:Number, p__2:String):void
		{
			pcmConnect.onEmoPrices(p__1)
			
		}
		public function findGame():void
		{
			pgData.bAutoFindSeat = false;
			if (!(pgData.dispMode == "tournament") && !(pgData.dispMode == "shootout")){
				pgData.bAutoSitMe = true;
				pcmConnect.sendMessage(new SPickRoom("SPickRoom"));
			} else {
				pgData.bAutoFindSeat = true;
				lobbyControl.plModel.sLobbyMode = "challenge";
				pgData.dispMode = "challenge";
				pgData.bVipNav = true;
				pgData.joinPrevServ = true;
				pgData.newServerId = loadBalancer.getPrevServerOfType("normal");
				pcmConnect.disconnect();	
			}
		}
		public function joinTableCheck(p__1:int):void
		{
			var l__5:com.script.poker.protocol.SJoinRoom;
			var l__3:com.script.poker.protocol.SSuperJoinRoom;
			var l__4:com.script.poker.protocol.SGetRoomPass;
			var l__2:com.script.poker.lobby.RoomItem = pgData.getRoomById(p__1);
			if (l__2 == null){
				dispatchEvent(new ErrorPopupEvent("onErrorPopup", "Hold\'em Message", "Please select a table."));
				return;
			}
			pgData.gameRoomId = p__1;
			if ((pgData.dispMode == "shootout") && (pgData.rejoinRoom > -1)){
				l__3 = new SSuperJoinRoom(p__1, "", pgData.jt);
				lobbyControl.hideLobby();
				dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL, "Joining table.", ""));
				pcmConnect.sendMessage(l__3);
				return;
			}

			if (p__1 != -1){
				if ((pgData.dispMode == "shootout") && (l__2 == null)){
					l__3 = new SSuperJoinRoom(p__1, "", pgData.jt);
					lobbyControl.hideLobby();
					dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL, "Joining table.", ""));
					pcmConnect.sendMessage(l__3);
				} else if ((l__2.tableType == "Private") && pgData.iAmMod){
					l__4 = new SGetRoomPass("SGetRoomPass", p__1);
					pcmConnect.sendMessage(l__4);
				} else if (l__2.tableType == "Private"){
					
					pgData.nPrivateRoomId = p__1;
					
					if (l__2.tabowner == "" || l__2.tabowner == "null"){
						var popObj = new Object();
						popObj.type = "onCreateTable"
						popObj.tid = p__1
						popObj.tname = l__2.roomName
						popObj.tsmall = l__2.roomName
						popObj.tbig = l__2.bigBlind
						popObj.tsmall = l__2.smallBlind
						regPopup(popObj);
					}else {
						
						var popObj = new Object();
						popObj.type = "onEnterPassword"
						regPopup(popObj);
					}
					
					
					//dispatchEvent(new PopupEvent("onEnterPassword"));
				} else {
					//l__5 = new SJoinRoom(p__1)
					pgData.gamePubId = l__2.pubId
					
					//pcmConnect.sendMessage(l__5);
					l__3 = new SSuperJoinRoom(p__1, "", pgData.jt);
					dispatchEvent(new PCEvent(PCEvent.HIDE_FRIEND_SELECTOR))
					lobbyControl.hideLobby();
					
					//dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL, ("Joining table: " + l__2.roomName), ""));
					pcmConnect.sendMessage(l__3);
					
					
				}
			}
		}
		public function tableJoin(p__1:Object):void
		{
			
			tableControl.tableJoin(p__1);
		}
		public function hideInterstitial():void
		{
			popupControl.hideInterstitial();
		}
		public function createPrivateRoom(p__1:String, p__2:String, p__3:Number, p__4:Number, p__5:Number, p__6:Number, p__7:Number):void
		{
			var l__6:com.script.poker.protocol.SCreateRoom = new SCreateRoom("SCreateRoom", p__1, p__2, p__3, p__4, p__5, p__6, p__7);
			pcmConnect.sendMessage(l__6);
		}
		public function updatePrivateRoom(p__1:String, p__2:Number, p__3:Number, p__4:String):void
		{
			var l__6:com.script.poker.protocol.SCreateRoom = new SCreateRoom("SUpdateTable", p__1, "0", 0, 0, 0, p__2, p__3);
			pcmConnect.sendMessage(l__6);
			
		}
		public function submitPassword(p__1:String)
		{
			var l__2:com.script.poker.protocol.SSuperJoinRoom = new SSuperJoinRoom(pgData.nPrivateRoomId, p__1);
			pcmConnect.sendMessage(l__2);
		}
		
		public function submitChangePassword(p__1:Object)
		{
			//var l__2:com.script.poker.protocol.SSuperJoinRoom = new SSuperJoinRoom(pgData.nPrivateRoomId, p__1);
			var l__2:com.script.poker.protocol.SChangePass = new SChangePass("SChangePass", p__1.old, p__1.news, p__1.news2);
			pcmConnect.sendMessage(l__2);
		}
		private function initConfig():void
		{
			//pgData.assignConfig(main.configXML);
		}
		public function chooseVipPopup():void
		{
			//dispatchEvent((new VIPPopupEvent("showVipPromo", bDisplayLobby, pgData.sn_id, pgData.vipDays, pgData.vipStatusMsg, pgData.isVip)) as PopupEvent);
		}
		public function JSCall_OnDailyBonus(p__1:String)
		{
			if ((pgData.sn_id == pgData.SN_FACEBOOK) && (pgData.jsCallType == "fbbridge")){
				pgData.callFBJS(p__1);
			} else if (pgData.jsCallType == "none"){
			} else {
				ExternalInterface.call(p__1);
			}
		}
		private function chooseEntryPopup():void
		{
			if (pgData.hide_daily_bonus > 0){
				return;
			}
			if (pgData.firstTimePlaying == 1){
				dispatchEvent(new PopupEvent("showWelcomeMessage"));
				pgData.firstTimePlaying = 0;
			} else if (pgData.tourneyId > -1){
			} else if (((pgData.sn_id == 1) && (pgData.newbie == 0)) && (pgData.bonus > 0)){
				dispatchEvent(new PopupEvent("showDailyBonus"));
			} else if (pgData.bonus > 0){
				dispatchEvent(new PopupEvent("showOutOfChips"));
			}
		}
		
		public function claimTourneyToken():void
		{
			var l__1:com.script.io.LoadUrlVars = new LoadUrlVars();
			//l__1.navigateURL(((unescape("http%3A%2F%2Fprofile.myspace.com%2FModules%2FApplications%2FPages%2FCanvas.aspx%3FappId%3D102102%26appParams%3D%7B%22zy_path%22%3A%22tourney_invite.osv.php%253Fjoin_tid%253D") + pgData.nWeeklyTourneyId) + "%22%7D"), "_top");
		}
		public function claimTourneySeat():void
		{
			var l__1:com.script.io.LoadUrlVars = new LoadUrlVars();
			//l__1.navigateURL(((unescape("http%3A%2F%2Fprofile.myspace.com%2FModules%2FApplications%2FPages%2FCanvas.aspx%3FappId%3D102102%26appParams%3D%7B%22zy_path%22%3A%22tourney_invite.osv.php%253Fjoin_tid%253D") + pgData.nWeeklyTourneyId) + "%2526src%253Dban%22%7D"), "_top");
		}
		public function playWeeklyTourney():void
		{
			var l__1:com.script.io.LoadUrlVars = new LoadUrlVars();
			//l__1.navigateURL(((unescape("http%3A%2F%2Fprofile.myspace.com%2FModules%2FApplications%2FPages%2FCanvas.aspx%3FappId%3D102102%26appParams%3D%7B%22zy_path%22%3A%22tourney_invite.osv.php%253Ftid%253D") + pgData.nWeeklyTourneyId) + "%2526playifnotokens%253D1%22%7D"), "_top");
		}
		private function onLobbyInit(evt:com.script.poker.lobby.events.LCEvent)
		{
			var sStat:String;
			var statHit:com.script.io.LoadUrlVars;
			var tCookie:com.script.utils.FlashCookie;
			lobbyControl.displayLobby();
			dispatchEvent(new PCEvent(PCEvent.DISPLAY_COMMON_UI));
			chooseEntryPopup();
			//loadBalancer.clearConnFail();
			//houseentry();
			
			if (pgData.trace_stats == 1){
				sStat = pgData.GetSignedTrackingUrl(("o:AS3:SWF:LobbyRendered:AllLoaded_" + nRetries) + ":2009-04-10");
				statHit = new LoadUrlVars();
				statHit.loadURL(sStat, {}, "POST");
			}
			try {
				tCookie = new FlashCookie("PokerRetry");
			} catch (err:Error) {
				return;
			}
			
			/*var l__12 = zoomGetFriendsList()
			var l__11 = l__12.split(",")
			for (var a=0; a<l__11.length; a++) {
				var l__10:com.script.poker.UserPresence = new UserPresence(l__11[a], 1, pgData.serverId, 12, "Playing", "ace", 1, "n/a", pgData.pic_url, zoomGetFriendsList(), zoomGetNetworkList());
				zoomModel.updatePlayer(l__10, "friends");
			}*/
			var l__5:com.script.poker.UserPresence = new UserPresence(viewer.zid, 1, pgData.serverId, pgData.rejoinRoom, "", "", "", "n/a", pgData.pic_url, zoomGetFriendsList(), zoomGetNetworkList());
			
			zoomModel.updatePlayer(l__5, "friends");
			//onZoomAddFriend(l__5)
			
			tCookie.ClearAllValues();
		}
		public function testing(){
			var l__5:com.script.poker.UserPresence = new UserPresence(viewer.zid, 1, pgData.serverId, pgData.rejoinRoom, "", "", "", "n/a", pgData.pic_url, zoomGetFriendsList(), zoomGetNetworkList());
			
			//zoomModel.updatePlayer(l__5, "friends");
			onZoomAddFriend(l__5)
		}
		private function onTableInit(p__1:com.script.poker.table.events.TCEvent):void
		{
			tableControl.displayTable();
		}
		public function onJoinTable(p__1:com.script.poker.lobby.events.controller.JoinTableEvent)
		{
			//pStats.rec("lobby", "onJoinTable");
			var l__2:String = pgData.GetSignedTrackingUrl("o:Lobby:TableListJoin:2009-03-20");
			if (l__2 != ""){
				record(l__2);
			}
			joinTableCheck(p__1.nId);
			pgData.joiningContact = false;
		}
		private function onLeaveTable(p__1:com.script.poker.table.events.TCEvent):void
		{
			var l__2:com.script.poker.protocol.SSuperJoinRoom;
			popupControl.removeBuyin();
			if (pgData.dispMode == "shootout"){
				pgData.joinShootoutLobby = true;
				lobbyControl.setShootoutMode();
				pcmConnect.sendMessage(new SGetUserShootoutState("SGetUserShootoutState"));
			} else {
				l__2 = new SSuperJoinRoom(pgData.lobbyRoomId, "", pgData.jt);
				dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL, "Joining Lobby...", ""));

				pcmConnect.sendMessage(l__2);
			}
			
		}
		public function onToLobby() {
			
			pgData.joiningShootout = false;
			pgData.EnsurePHPPopupsAreClosed();
			
			
			l__2 = new SSuperJoinRoom(pgData.lobbyRoomId, "", pgData.jt);
			dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL, "Joining Lobby...", ""));
			pcmConnect.sendMessage(l__2);
		}
		private function onStandUp(p__1:com.script.poker.table.events.TCEvent):void
		{	
			popupControl.removeBuyin();
			var l__2:com.script.poker.protocol.SStandUp = new SStandUp("SStandUp",pgData.jt);
			pcmConnect.sendMessage(l__2);
		}
		private function onFreindNetworkPressed(p__1:com.script.poker.table.events.TCEvent):void
		{
			pgData.ZLiveToggle = -pgData.ZLiveToggle;
			if (pgData.ZLiveToggle > 0){
				dispatchEvent(new PCEvent(PCEvent.SHOW_FRIEND_SELECTOR));
			} else {
				dispatchEvent(new PCEvent(PCEvent.HIDE_FRIEND_SELECTOR));
			}
			
		}
		public function onReportAccept(p__1:Number, p__2:String, p__3:Number):void
		{	
			var l__3:com.script.poker.protocol.SReport = new SReport("SReport", p__1, p__2, p__3);
			pcmConnect.sendMessage(l__3);
		}
		public function onBuyInAccept(p__1:Number, p__2:int):void
		{	
			var l__3:com.script.poker.protocol.SSit = new SSit("SSit", p__1, p__2);
			pcmConnect.sendMessage(l__3);
		}
		public function onTransAccept(p__1:Number):void
		{	
			var l__3:com.script.poker.protocol.SAddPoints = new SAddPoints("SAddPoints", p__1);
			pcmConnect.sendMessage(l__3);
		}
		public function onAddBuddy(p__1:String):void
		{
			var l__2:com.script.poker.protocol.SAddBuddy = new SAddBuddy("SAddBuddy", p__1);
			pcmConnect.sendMessage(l__2);
		}
		public function onGiftChips(p__1:Number, p__2:String):void
		{
			var l__3:com.script.poker.protocol.SGiftChips = new SGiftChips("SGiftChips", p__1, p__2);
			pcmConnect.sendMessage(l__3);
		}
		public function onBuyGift(p__1:Number, p__2:Number, p__3:String):void
		{
			pStats.rec("table", "onBuyGift");
			var l__4:com.script.poker.protocol.SBuyGift = new SBuyGift("SBuyGift", p__1, p__2, p__3);
			pcmConnect.sendMessage(l__4);
		}
		public function onBuyGift2(p__1:Number, p__2:Number, p__3:String, p__4:Number):void
		{
			//pStats.rec("table", "onBuyGift");
			var l__4:com.script.poker.protocol.SBuyGift2 = new SBuyGift2("SBuyGift2", p__1, p__2, p__3, p__4);
			pcmConnect.sendMessage(l__4);
		}
		public function onBuyEmo(p__1:Number, p__2:Number, p__3:String, p__4:Number, p__5:String):void
		{
			//pStats.rec("table", "onBuyEmo");
			
			var l__1 = ""+p__2;
			var l__2 = l__1.substr(0,1)
			
			if (l__2 == "2") {
			tableControl.ptView.sendChat("*Send "+p__5+"*");
			}
			var l__4:com.script.poker.protocol.SBuyEmo = new SBuyEmo("SBuyEmo", p__1, p__2, p__3, p__4, p__5);
			pcmConnect.sendMessage(l__4);
		}
		public function onAcceptBuddy(p__1:String, p__2:String):void
		{
			var l__3:com.script.poker.protocol.SAcceptBuddy = new SAcceptBuddy("SAcceptBuddy", p__1, p__2);
			pcmConnect.sendMessage(l__3);			
		}
		public function onIgnoreBuddy(p__1:String):void
		{
			var l__2:com.script.poker.protocol.SIgnoreBuddy = new SIgnoreBuddy("SIgnoreBuddy", p__1);
			pcmConnect.sendMessage(l__2);
		}
		public function onIgnoreAllBuddy():void
		{
			var l__1:com.script.poker.protocol.SIgnoreAllBuddy = new SIgnoreAllBuddy("SIgnoreAllBuddy");
			pcmConnect.sendMessage(l__1);
		}
		public function onShowGift(p__1:Number):void
		{	
			var l__2:com.script.poker.protocol.SShowGift = new SShowGift("SShowGift", p__1);
			pcmConnect.sendMessage(l__2);
		}	
		public function onShowGift3(param1:Number) : void
        {
            var _loc_2:com.script.poker.protocol.SShowGift3 = new SShowGift3("SShowGift3", param1, false);
            pcmConnect.sendMessage(_loc_2);
            return;
        }
		public function onQueryGifts(p__1:int):void
		{	
			var l__2:com.script.poker.protocol.SQueryGifts = new SQueryGifts("SQueryGifts", p__1);
			pcmConnect.sendMessage(l__2);
		}	
		public function onQueryGifts2(p__1:int):void
		{
			var l__2:com.script.poker.protocol.SQueryGifts2 = new SQueryGifts2("SQueryGifts2", p__1);
			pcmConnect.sendMessage(l__2);
		}
		public function onShowEmo(p__1:Number):void
		{	
			var l__2:com.script.poker.protocol.SShowEmo = new SShowEmo("SShowEmo", p__1);
			pcmConnect.sendMessage(l__2);
		}	
		public function onShowVip(p__1:Boolean):void
		{
			var l__2:com.script.poker.protocol.SHideVIP = new SHideVIP("SHideVIP", p__1 ? 0 : 1);
			pcmConnect.sendMessage(l__2);
		}
		public function onAbuse(p__1:String, p__2:String, p__3:String):void
		{
			var l__4:com.script.poker.protocol.SReportUser = new SReportUser("SReportUser", p__1, p__2, p__3);
			pcmConnect.sendMessage(l__4);
		}
		public function onPrivateTableClick(p__1:com.script.poker.lobby.events.LCEvent):void
		{
			//dispatchEvent(new ErrorPopupEvent("onErrorPopup", "Hold\'em Message", "Private rooms are temporarily not available while we work on adding additional security features."));
		}
		private function getRoomList():void
		{	
			pcmConnect.getRoomList();
		}
		private function autoJoin():void
		{
			pcmConnect.autoJoin();
		}
		private function getLobbyRooms():void
		{
			pcmConnect.getLobbyRooms();
		}
		private function loadLobby(p__1:String):void
		{
			ldr = new Loader();
			var l__2:flash.net.URLRequest = new URLRequest(p__1);
			ldr.contentLoaderInfo.addEventListener(Event.INIT, onLobbyLoaded);
			ldr.load(l__2);
		}
		public function reconnectToServer():void
		{
			//loadBalancer.addEventListener(LoadBalancer.onServerChosen, onServerChosen);
			//loadBalancer.chooseBestServer();
		}
		public function connectToServer():void
		{
			var l__1:Array = pgData.ip.split(":");
			
			if (l__1.length > 1){
				pgData.port = int(int(l__1[1]));
				pcmConnect.setHost(l__1[0]);
				pcmConnect.setPort(pgData.port);
				
			} else {
				pcmConnect.setHost(pgData.ip);
			}
			pcmConnect.connect();
			addload = true
			main.addLoading();
			//dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL, (("Connecting to \'" + pgData.serverName) + "\'"), ""));
		}
		public function cleanupAndReconnect():void
		{
			if (!bInLobbyRoom){
				tableControl.cleanupTable();
			}
			pgData.joinPrevServ = true;
			pgData.newServerId = pgData.serverId;
			reconnectToServer();
		}
		private function onServerChosen(p__1:flash.events.Event):void
		{
			//loadBalancer.removeEventListener(LoadBalancer.onServerChosen, onServerChosen);
			var l__2:Array = pgData.ip.split(":");
			if (l__2.length > 1){
				pgData.port = int(int(l__2[1]));
				pcmConnect.setHost(l__2[0]);
				pcmConnect.setPort(pgData.port);
			} else {
				pcmConnect.setHost(pgData.ip);
			}
			pcmConnect.connect();
			dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL, (("Connecting to \'" + pgData.serverName) + "\'"), ""));
		}
		public function onFindSeat(p__1:com.script.poker.lobby.events.LCEvent):void
		{
			findGame();
			TrackingHit("TableJoinFindMeASeat", 5, 14, 2010, -1, "Table Other TableJoinFindMeASeat o:LiveJoin:2009-05-14", null, 1);
		}
		public function record(p__1:String):void
		{			
			var l__2:com.script.io.LoadUrlVars;
			if (pgData.trace_stats == 1){
				l__2 = new LoadUrlVars();
				l__2.loadURL(p__1, {}, "POST");
			}
		}
		private function onConnectionHandler(p__1:flash.events.Event):void
		{
			var l__2:String = pgData.zid;
			//if (int(pgData.tourneyId) > -1){
				//l__2 = (l__2 + (":" + pgData.tourneyId));
			//}
			//var l__3:com.script.poker.protocol.SSuperLogin = new SSuperLogin(l__2, pgData.pic_url, pgData.nRank, pgData.sNetwork, pgData.pic_lrg_url, pgData.sn_id, pgData.prof_url, pgData.tourneyState, pgData.protoVersion, 0, String("flash"), 1, 1, 1, pgData.sPass, pgData.sZone, pgData.nHideGifts);
			var l__3:com.script.poker.protocol.SSuperLogin = new SSuperLogin(pgData.zid, pgData.pic_url, Number(pgData.nRank), "", "", "", "", "", "", 0, String("flash"), 1, 1, 1, pgData.sPass, pgData.sZone, "");
			
			pcmConnect.login(l__3);
		}
		private function onProtocolMessage(p__1:com.script.poker.protocol.ProtocolEvent):void
		{
			
			var l__2:Object = p__1.msg;
			switch(l__2.type){
				case "RLogin":
				{
					handleLogin(l__2);
					break;
				}
				case "RLogData":
				{
					handleData(l__2);
					break;
				}
				case "RRoomListUpdate":
				{
					handleRoomListUpdate(l__2);
					break;
				}
				case "RJoinRoom":
				{
					handleJoinRoom(l__2);
					break;
				}
				case "RJoinRoomError":
				{
					handleJoinRoomError(l__2);
					break;
				}
				case "RConnectionLost":
				{
					handleConnectionLost(l__2);
					break;
				}
				case "RGiftInfo2":
				{
					updateGiftInfo2(l__2);
					break;
				}
				case "RGiftTooExpensive":
				{
					updateGiftTooExpensive(l__2);
					break;
				}
				case "RGiftPrices":
				{
					updateGiftPrices(l__2);
					break;
				}
				case "RGiftPrices2":
				{
					updateGiftPrices2(l__2);
					break;
				}
				case "RUserGifts2":
                {
                    onUserGifts2(l__2);
                    break;
                }
				case "REmoInfo":
				{
					updateEmoInfo(l__2);
					break;
				}
				case "REmoPrices":
				{
					updateEmoPrices(l__2);
					break;
				}
				case "RSetMod":
				{
					updateSetMod(l__2);
					break;
				}
				case "RRoomPass":
				{
					handleRoomPass(l__2);
					break;
				}
				case "RRoomPicked":
				{
					handleRoomPicked(l__2);
					break;
				}
				case "RCreateRoomRes":
				{
					handleCreateRoomRes(l__2);
					break;
				}
				case "RDisplayRoomList":
				{
					handleDisplayRoomList(l__2);
					break;
				}
				case "ROutOfChips":
				{
					onOutOfChips(l__2);
					break;
				}
				case "RShowMessage":
				{
					onShowMessage(l__2);
					break;
				}
				case "RAdminMessage":
				{
					onAdminMessage(l__2);
					break;
				}
				case "RLogKO":
				{
					onLogKO(l__2);
					break;
				}
				case "RShootoutConfig":
				{
					onShootoutConfig(l__2);
					break;
				}
				case "RDisplayRoom":
				{
					onDisplayRoom(l__2);
					break;
				}
				case "RUserShootoutState":
				{
					onUserShootoutState(l__2);
					break;
				}
				case "RNewBuddy":
				{
					onNewBuddy(l__2);
					break;
				}
				case "RInviteSend":
				{
					onZoomTableInvitation(l__2);
					break;
				}
				case "REventInfo":
				{
					updateEventInfo(l__2);
					break;
				}
			}
		}
		private function handleLogin(p__1:Object):void
		{
			
			var l__2:com.script.poker.protocol.RLogin = RLogin(p__1);
			
			if (l__2.bSuccess){
				pgData.playLevel = l__2.playLevel;
				pgData.name = l__2.name;
				pgData.isVip = l__2.isVip;
				pgData.points = l__2.points;
				pgData.deposit = l__2.deposit;
				pgData.chipConvert = l__2.chipConvert;
				pgData.vipStatusMsg = l__2.vipStatusMsg;
				pgData.rejoinRoom = l__2.rejoinRoom;
				pgData.bonus = l__2.bonus;
				pgData.vipDays = l__2.vipDays;
				pgData.hideVip = l__2.hideVip;
				pgData.usersOnline = l__2.usersOnline;
				pgData.usersText = l__2.usersText;
				pgData.jt = l__2.jt;
				pgData.badWords = l__2.badWords;
				pgData.vipName = l__2.vipName;
				pgData.serverName = l__2.curServer;
				pgData.chatStat = l__2.chatStat;
				pgData.chatPop = l__2.chatPop;
				pgData.gameInfo = l__2.gameInfo;
				
				if (pgData.usersText != null) {
					if((pgData.usersText.indexOf("ROYAL FLUSH")>0) ||(pgData.usersText.indexOf("STRAIGHT FLUSH")>0) ||(pgData.usersText.indexOf("FOUR OF A KIND")>0)){
						var textkartu = [];
						textkartu = pgData.usersText.split("*");
						if(textkartu[2] == "SUPER ROYAL FLUSH"){
							var jptext= pgData.langs.l_superroyalflush+" "+textkartu[3];
						}if(textkartu[2] == "ROYAL FLUSH"){
							var jptext= pgData.langs.l_royalflush+" "+textkartu[3];
						}if(textkartu[2] == "STRAIGHT FLUSH"){
							var jptext= pgData.langs.l_straightflush+" "+textkartu[3];
						}if(textkartu[2] == "FOUR OF A KIND"){
							var jptext= pgData.langs.l_fourofakind+" "+textkartu[3];
						}
						main.mc_run.run_txt.text =pgData.langs.l_jackpot.toUpperCase()+":"+textkartu[3]+" "+jptext;
						main.mc_run.run_txt.width = main.mc_run.run_txt.text.length*20
						main.mc_run.x = 1000
					}else{
						main.mc_run.run_txt.text = pgData.usersText;
						main.mc_run.run_txt.width = main.mc_run.run_txt.text.length*20
						main.mc_run.x = 1000
						
					}
				}
				var l__3 = 0;
				var l__5 = new Array();
				pgData.aFriendZids = new Array();
				while (l__3 < l__2.flist.length) {
					var l__4 = new Object();
					l__4.zid = l__2.flist[l__3];
					l__4.zname = l__2.flist[l__3+1];
					l__4.ztabid = l__2.flist[l__3+2];
					l__4.zserver = l__2.flist[l__3+3];
					l__5.push(l__4)
					pgData.aFriendZids.push(l__4.zid)
					l__3 = l__3+4
				}
				onInitZoom(l__5);
				
				//zoomControl.connect();
			} else {
			}
		}
		private function handleData(p__1:Object):void
		{
			//testing();
			var l__2:com.script.poker.protocol.RLogData = RLogData(p__1);
				
				pgData.playLevel = l__2.playLevel;
				pgData.name = l__2.name;
				
				
				
				
				pgData.isVip = l__2.isVip;
				pgData.points = l__2.points;
				pgData.deposit = l__2.deposit;
				pgData.vipStatusMsg = l__2.vipStatusMsg;
				pgData.rejoinRoom = l__2.rejoinRoom;
				pgData.bonus = l__2.bonus;
				pgData.vipDays = l__2.vipDays;
				pgData.hideVip = l__2.hideVip;
				pgData.usersOnline = l__2.usersOnline;
				pgData.usersText = l__2.usersText;
				var dd = new Date();
				if (pgData.usersText != null) {
				
					if(pgData.usersText.indexOf("SUPER ROYAL FLUSH")>0){
						if(spr == 0){
							tableControl.ptView.sendEmo("0", "0", "205","Dollar");
							pokerSoundManager.Sound_Super();
							spr++;
						}
						
					}else if(pgData.usersText.indexOf("ROYAL FLUSH")>0){
						if(ryl == 0){
							pokerSoundManager.Sound_Royal();
							ryl++;
						}
						
					}else if(pgData.usersText.indexOf("STRAIGHT FLUSH")>0){
						if(str == 0){
							//pokerSoundManager.Sound_Str();
							str++;
						}
					}else if(pgData.usersText.indexOf("FOUR OF A KIND")>0){
						if(fourk == 0){
							//pokerSoundManager.Sound_Fourk();
							fourk++;
						}
					}else{
						ryl =0;
						str =0;
						fourk =0;
						spr = 0;
					}
					
					if((pgData.usersText.indexOf("ROYAL FLUSH")>0) ||(pgData.usersText.indexOf("STRAIGHT FLUSH")>0) ||(pgData.usersText.indexOf("FOUR OF A KIND")>0)){
						var textkartu = [];
						textkartu = pgData.usersText.split("*");
						if(textkartu[2] == "SUPER ROYAL FLUSH"){
							var jptext= pgData.langs.l_superroyalflush+" "+textkartu[3];
						}if(textkartu[2] == "ROYAL FLUSH"){
							var jptext= pgData.langs.l_royalflush+" "+textkartu[3];
						}if(textkartu[2] == "STRAIGHT FLUSH"){
							var jptext= pgData.langs.l_straightflush+" "+textkartu[3];
						}if(textkartu[2] == "FOUR OF A KIND"){
							var jptext= pgData.langs.l_fourofakind+" "+textkartu[3] ;
						}
						main.mc_run.run_txt.text =pgData.langs.l_jackpot.toUpperCase()+":"+textkartu[3]+" "+jptext;
						main.mc_run.run_txt.width = main.mc_run.run_txt.text.length*20
						main.mc_run.x = 1000
						
					}else{
						main.mc_run.run_txt.text = pgData.usersText;
						main.mc_run.run_txt.width = main.mc_run.run_txt.text.length*20
						main.mc_run.x = 1000
						
					}
					
				}
				onZoomClear();
				var l__3 = 0;
				var l__5 = new Array();
				var l__6 = 0;
				pgData.aFriendZids = new Array()
				while (l__3 < l__2.flist.length) {
					var l__4 = new Object();
					l__4.zid = l__2.flist[l__3];
					l__4.zname = l__2.flist[l__3+1];
					l__4.ztabid = l__2.flist[l__3+2];
					l__4.zserver = l__2.flist[l__3+3];
					var dir = l__4.zid.slice(0,1);
					l__4.picurl = pgData.pathz+"/Avatar/"+dir+"/"+l__4.zid+".jpg?d="+dd;
					//l__5.push(l__4)
					pgData.aFriendZids.push(l__4.zid)
					l__3 = l__3+4
					l__6++;
					
					var l__11 = l__4.zname.split(" ");
					var l__12 = l__4.zid
					if (l__11[1] == null) {
						l__11[1] = "";
					}
					
									
					var l__10:com.script.poker.UserPresence = new UserPresence(l__12, 1, l__4.zserver, l__4.ztabid, "Lobby", l__11[0], l__11[1], "n/a", l__4.picurl, "", "", l__4.zserver);
					onZoomAddFriend(l__10);
					
					//zoomModel.updatePlayer(l__10, "friends");
				}
				
				//zoomControl.connect();
		}
		private function onNewBuddy(p__1:Object):void
		{			
			//testing();
			var l__2 = p__1.name
			var l__3 = p__1.name.split(" ");
			if (l__3[1] == null){
				l__3[1] = "";
			}
			var dir = l__2.slice(0,1);
			var l__4 = pgData.pathz+"/Avatar/"+dir+"/"+l__2+".jpg";
		
			var l__1:com.script.poker.UserPresence = new UserPresence(p__1.zid, 1, pgData.serverId, 0, "Lobby", l__3[0], l__3[1], "n/a", l__4, "", "");
			onZoomAddFriend(l__1);
			
		}
		private function handleRoomListUpdate(p__1:Object):void
		{
			if (pgData.firstRoomList){
				pgData.firstRoomList = false;
			}
			else {
				return;
			}
			//getLobbyRooms();
			//autoJoin();
			//joinroom("newroom", pass);
			//var l__1 = {};
			l__1 = "Texas room";
			l__2 = new SJoinRoom(l__1)
			
			pcmConnect.sendMessage(l__2);
			
			//getLobbyRooms();
			
		}
		private function onDisplayRoom(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RDisplayRoom = RDisplayRoom(p__1);
			if (pgData.getRoomById(l__2.rooms[0].id) == null){
				pgData.aGameRooms.push(l__2.rooms[0]);
			}
		}
		private function handleJoinRoom(p__1:Object):void
		{
			
			var l__4:com.script.poker.protocol.SReplayState;
			var l__5:String;
			var l__2:com.script.poker.protocol.RJoinRoom = RJoinRoom(p__1);
			//var l__3:String = loadBalancer.getServerType(pgData.serverId);
			//updateLobbyTabs(l__3);
			updateLobbyTabs("normal");
			//pcmConnect.loginHandler("logOK");
			var l__8 = new Object();
			if (pgData.gameRoomId == 0) {
				l__8.type = "ScekxLogin";
				l__8.pathz = pgData.pathz;
				pcmConnect.sendMessage(l__8);
			}
			else {
				
				l__8.type = "ScekxLogin2";
				pcmConnect.sendMessage(l__8);
			}
			
			if (l__2.roomName == "Texas room" || l__2.roomName == "Private"){
				pgData.lobbyRoomId = l__2.roomId;
				bInLobbyRoom = true;
				dispatchEvent(new PCEvent(PCEvent.LOBBY_JOINED));
				dispatchEvent(new PCEvent(PCEvent.SHOW_FRIEND_SELECTOR));
				initTable();
				//pcmConnect.getLobbyRooms2();
				//getLobbyRooms();// ditutup karena google chrome tidak jalan!pindah 
				
			} else {
				
				getGiftPrices2(-1, viewer.zid);
				getEmoPrices(-1, viewer.zid);
				bInLobbyRoom = false;
				
				pgData.gameRoomId = l__2.roomNo;
				pgData.gameRoomNo = l__2.roomId;
				if (pgData.tourneyId > -1){
					pgData.gameRoomName = "Weekly Tourney";
				} else {
					pgData.gameRoomName = l__2.roomName;
				}
				
				initTable();
				//popupControl.hideInterstitial();
				
				l__4 = new SReplayState("SReplayState");
				pcmConnect.sendMessage(l__4);
				//pStats.rec("table", "displayTable");
				
				l__5 = pgData.GetSignedTrackingUrl("o:Table:DisplayTable:2009-03-20");
				if (l__5 != ""){
					record(l__5);
				} 
				
				dispatchEvent(new PCEvent(PCEvent.TABLE_JOINED));
				
			}
			if (pgData.joiningContact && !(pgData.nNewRoomId == -1)){
			}
			//initBuddyInvites();
			//onUpdateUserPresence(null);
			
			//zoomUpdateUser();
			//testing();
			
		}
		private function handleJoinRoomError(p__1:Object):void
		{
			/*var l__2:com.script.poker.protocol.RJoinRoomError = RJoinRoomError(p__1);
			var l__3:String = pgData.config["joinroomerror"]["title"];
			var l__4:String = StringUtility.FormatString(pgData.config["joinroomerror"]["message"], {sText:"%message%", nVar:l__2.sMessage});
			dispatchEvent(new ErrorPopupEvent("onErrorPopup", l__3, l__4));
			*/
			var l__1:Object = new Object();
			l__1.type = "onErrorPopup";
			l__1.upper = pgData.langs.l_errorjoinroom;
			l__1.mess = pgData.langs.l_messerrorjoinroom;
			
			popupControl.regonErrorPopup(l__1);
			//pControl.regPopup("onErrorPop", 0);
			lobbyControl.showLobby();
		}
		private function handleDisplayRoomList(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RDisplayRoomList = RDisplayRoomList(p__1);
			if (addload == true) {				
				
				getGiftInfo2(-1);
				getEmoInfo(-1)
				main.removeSpinner();
				addload = false;				
				
			}
			
		}
		private function updateSetMod(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RSetMod = RSetMod(p__1);
			pgData.iAmMod = p__1.isMod;
		}
		private function handleRoomPicked(p__1:Object):void
		{
			var l__3:com.script.poker.protocol.SCreateBucketRoom;
			var l__2:com.script.poker.protocol.RRoomPicked = RRoomPicked(p__1);
			if (l__2.roomId == -1){
				l__3 = new SCreateBucketRoom("SCreateBucketRoom", l__2.bucket);
				pcmConnect.sendMessage(l__3);
			} else {
				joinTableCheck(l__2.roomId);
			}
		}
		private function handleCreateRoomRes(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RCreateRoomRes = RCreateRoomRes(p__1);
			pgData.aGameRooms.push(p__1.rooms[0]);
			var l__3:com.script.poker.protocol.SSuperJoinRoom = new SSuperJoinRoom(l__2.roomId, l__2.password);
			pcmConnect.sendMessage(l__3);
			//pgData.bAutoSitMe = true;
		}
		private function handleRoomPass(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RRoomPass = RRoomPass(p__1);
			var l__3:com.script.poker.protocol.SSuperJoinRoom = new SSuperJoinRoom(l__2.roomId, l__2.password);
			pcmConnect.sendMessage(l__3);
		}
		private function updateEventInfo(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.REventInfo = REventInfo(p__1);
			var popObj = new Object();
			popObj.type = "showTopEvent"
			popObj.userList = l__2.eventUserList;
			popObj.poinList = l__2.eventPoinList;
			popObj._poin = l__2.eventPoin;
			popObj._start = l__2.eventStart;
			popObj._stop = l__2.eventStop;
			popObj._rule = l__2.eventRule;
			popObj._stat = l__2.eventStat;
			regPopup(popObj);
			
		}
		private function updateGiftInfo2(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RGiftInfo2 = RGiftInfo2(p__1);
			var l__3:Object = l__2.oJSON;
			var l__4:com.script.poker.table.GiftLibrary = GiftLibrary.GetInst();
			l__4.AddGiftInfoList(l__3[0]);
		}
		private function updateGiftTooExpensive(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RGiftTooExpensive = RGiftTooExpensive(p__1);
			pgData.points = l__2.uMyCurrentChipTotal;
			JSCallToPopBuyChip(l__2.uCostOfGift, l__2.uMyCurrentChipTotal);
		}
		private function updateEmoInfo(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.REmoInfo = REmoInfo(p__1);
			var l__3:Object = l__2.oJSON;
			var l__4:com.script.poker.table.EmoLibrary = EmoLibrary.GetInst();
			l__4.AddEmoInfoList(l__3);
		}
		public function JSCallToPopBuyChip(p__1:Number, p__2:Number)
		{
			var l__4:String;
			var l__5:String;
			var l__3:* = "popBuyChip";
			var l__2 = "getChipCount";
			if (pgData.buychips_popup && !(pgData.buychips_popup == "")){
				l__3 = pgData.buychips_popup;
			}
			if ((pgData.sn_id == pgData.SN_FACEBOOK) && (pgData.jsCallType == "fbbridge")){
				pgData.callFBJS(l__3, p__1, p__2);
			} else if (pgData.jsCallType == "none"){
				l__4 = pgData.config["gifttooexpensive"]["title"];
				l__5 = pgData.config["gifttooexpensive"]["message"];
				dispatchEvent(new ErrorPopupEvent("onErrorPopup", l__4, l__5));
			} else {
				ExternalInterface.call(l__3, p__1, p__2);
			}
		}
		private function updateGiftPrices(p__1:Object):void
		{
		}
		private function updateGiftPrices2(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RGiftPrices2 = RGiftPrices2(p__1);
			GiftLibrary.GetInst().AddGiftPriceList(l__2.giftType, l__2.giftArray);
			GiftLibrary.GetInst().AddCategoryList(l__2.catArray);
			popupControl.refreshDrinksTab();
			
		}
		private function onUserGifts2(param1:Object) : void
        {
			this.popupControl.updateProfileItems(param1.gifts);
            return;
        }
		private function updateEmoPrices(p__1:Object):void
		{		
			var l__2:com.script.poker.protocol.REmoPrices = REmoPrices(p__1);
			EmoLibrary.GetInst().AddEmoPriceList(l__2.emoType, l__2.emoArray);
			EmoLibrary.GetInst().AddCategoryList(l__2.catArray);
			popupControl.refreshEmoTab();
			
		}
		private function handleConnectionLost(p__1:Object):void
		{
			if ((pgData.bUserDisconnect || pgData.joiningContact) || pgData.bVipNav){
				if (pgData.dispMode == "shootout"){
					pgData.bVipNav = false;
				}
				if (pgData.bUserDisconnect && (!pgData.joiningContact)){
					//lobbyControl.showServerSelection();
				} else {
					reconnectToServer();
				}
			} else {
				handleDisconnectPopup();
			}
		}
		private function handleDisconnectPopup():void
		{
			
			pgData.isJoinFriend = false;
			pgData.isJoinFriendSit = false;
			//if (pgData.connectToZoom == 1){
				//zoomControl.disconnect();
			//}
			//dispatchEvent(new ErrorPopupEvent("onDisconnection", "Disconnection", "You were unexpectedly disconnected from the server."));
			var l__1:Object = new Object();
			l__1.type = "onErrorPopup";
			l__1.upper = pgData.langs.l_dc;
			l__1.mess = pgData.langs.l_messdc;
			l__1.goto = "menu";
			
			
			popupControl.regonErrorPopup(l__1);
		}
		private function handleUserPresence():void
		{
			var l__1:Object = new Object();
			//l__1.uid = viewer.zid;
			l__1.uid = "1134";
			pgData.name = "King Ace";
			var l__2:Array = pgData.name.split(" ");
			l__1.first = l__2[0];
			l__1.last = l__2[1];
			l__1.sig = pgData.sPass;
			
			var l__3:* = "";
			var l__4:Array = new Array();
			var l__5:Array = new Array();
			var l__6:Array = new Array();
			if (pgData.sn_id == pgData.SN_FACEBOOK){
				l__4 = pgData.nnames.split(",");
				l__5 = pgData.nids.split(",");
				l__6 = pgData.nsecrets.split(",");
			}
			var l__7:*;
			while(l__7 < l__4.length){
				l__3 = (l__3 + ((((l__5[l__7] + ",") + l__4[l__7]) + ",") + l__6[l__7]));
				if (l__7 < (l__4.length - 1)){
					l__3 = (l__3 + "|");
				}
				l__7++;
			}
			l__1.networks = l__3;
			//var l__8:com.script.io.LoadUrlVars = new LoadUrlVars();
			//l__8.loadURL((pgData.presence_url + "login_user.php"), l__1, "POST");
			if (timerUserPresence == null){
				//timerUserPresence = new Timer(pgData.userPresenceTimerDelay * 1000);
				timerUserPresence = new Timer(60 * 1000);
				timerUserPresence.addEventListener(TimerEvent.TIMER, onUpdateUserPresence);
				timerUserPresence.start();
			}
			if (runTextPresence == null){
				runTextPresence = new Timer(50);
				
				runTextPresence.addEventListener(TimerEvent.TIMER, onRunTextPresence);
				runTextPresence.start();
				//main.mc_run.run_txt.text = ""
				//main.mc_run.run_txt.width = main.mc_run.run_txt.text.length*10
			}
			/*if (timerChatPresence == null){
				timerChatPresence = new Timer(20 * 1000);
				timerChatPresence.addEventListener(TimerEvent.TIMER, onUpdateChatPresence);
				timerChatPresence.start();
			}*/
			
		}
		private function onUpdateUserPresence(p__1:flash.events.TimerEvent):void
		{
			var l__2:Object;
			//var l__3:com.script.io.LoadUrlVars;
			
			var l__8 = new Object();
			
			l__8.type = "ScekxLogin2";
			pcmConnect.sendMessage(l__8);
			
			/*if (pcmConnect.isConnected){
				l__2 = new Object();
				l__2.uid = viewer.zid;
				l__2.server = pgData.serverId;
				l__2.room = bInLobbyRoom ? -1 : pgData.gameRoomId;
				l__3 = new LoadUrlVars();
				l__3.loadURL((pgData.presence_url + "update_user.php"), l__2, "POST");
			}*/
		}
		private function onRunTextPresence(p__1:flash.events.TimerEvent):void
		{
			var l__2:Object;
			//var l__3:com.script.io.LoadUrlVars;
			main.mc_run.x = main.mc_run.x-2.5
			var panjang = main.mc_run.run_txt.text.length*20;
			if (main.mc_run.x < (130+(panjang*-1))) {
				main.mc_run.x = 1000
			}
				
				
				
				
			/*if (pcmConnect.isConnected){
				l__2 = new Object();
				l__2.uid = viewer.zid;
				l__2.server = pgData.serverId;
				l__2.room = bInLobbyRoom ? -1 : pgData.gameRoomId;
				l__3 = new LoadUrlVars();
				l__3.loadURL((pgData.presence_url + "update_user.php"), l__2, "POST");
			}*/
		}
		private function onUpdateChatPresence(p__1:flash.events.TimerEvent):void
		{
			var l__2:Object;			
			var l__8 = new Object();
			l__8.type = "SCekChat";
			pcmConnect.sendMessage(l__8);			
		}
		public function onPlaySoundOnce(p__1:com.script.poker.table.events.TCEvent):void
		{
			pokerSoundManager.playSound(p__1.handler);
		}
		public function onPlaySoundSequence(p__1:com.script.poker.table.events.TCEvent):void
		{
			pokerSoundManager.playSoundSequence(p__1.handler);
		}
		
		private function onOutOfChips(p__1:Object):void
		{
			
			var l__3:String;
			var l__4:String;
			var l__2:com.script.poker.protocol.ROutOfChips = ROutOfChips(p__1);
			
		}
		private function onShowMessage(p__1:Object):void
		{
			//var l__2:com.script.poker.protocol.RShowMessage = RShowMessage(p__1);
			//var l__3:String = pgData.config["showmsg"]["title"];
			//var l__4:String = StringUtility.FormatString(pgData.config["showmsg"]["message"], {sText:"%message%", nVar:l__2.message});
			//dispatchEvent(new ErrorPopupEvent("onErrorPopup", l__3, l__4));
			var l__1:Object = new Object();
			l__1.type = "onErrorPopup";
			l__1.upper = "Error";
			l__1.mess = p__1.message;
			l__1.goto = p__1.con;
			if (addload == true) { 
				main.removeLoading();
				main.removeSpinner();
				addload = false;
			}
			popupControl.regonErrorPopup(l__1);

		}
		private function onAdminMessage(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RAdminMessage = RAdminMessage(p__1);
			dispatchEvent(new ErrorPopupEvent("onErrorPopup", "Hold\'em Message", l__2.message));
		}
		private function onLogKO(p__1:Object):void
		{
			
			var l__2:com.script.poker.protocol.RLogKO = RLogKO(p__1);
			if (!l__2.success){
				if (l__2.cancelable){
					dispatchEvent(new ErrorPopupEvent("onErrorPopup", "Failed to Connect", l__2.message));
				} else {
					dispatchEvent(new ErrorPopupEvent("onErrorPopupNotCancelable", "Failed to Connect", "You were unable to connect to the server. Please refresh your page and try again."));
				}
			}
		}
		public function onRecordStat(p__1:com.script.poker.lobby.events.LCEvent):void
		{
			
		}
		private function onShowFriendSelectorLobby(p__1:com.script.poker.lobby.events.LCEvent):void
		{
			dispatchEvent(new PCEvent(PCEvent.SHOW_FRIEND_SELECTOR));
		}
		private function onHideFriendSelectorLobby(p__1:com.script.poker.lobby.events.LCEvent):void
		{
			dispatchEvent(new PCEvent(PCEvent.HIDE_FRIEND_SELECTOR));
		}
		public function onStopSound(p__1:com.script.poker.table.events.TCEvent):void
		{
			pokerSoundManager.stopSound();
		}
		public function onToggleMuteSoundPressed(p__1:com.script.poker.table.events.TCEvent):void
		{
			pokerSoundManager.muteSound(Boolean(p__1.bMute));
		}
		public function getMoreChips():void
		{
			var l__1:com.script.poker.protocol.SAddPoints = new SAddPoints("SAddPoints");
			pcmConnect.sendMessage(l__1);
		}
		public function getLessChips():void
		{
			
			//var l__3:com.script.poker.protocol.SAddPoints = new SAddPoints("SClearPoints");
			var l__1 = {}
			l__1.type = "SClearPoints";
			pcmConnect.sendMessage(l__1);
			
			
			//var l__1:com.script.poker.protocol.SAddPoints = new SAddPoints("SAddPoints");
			//pcmConnect.sendMessage("SRemovePoints");
		}
		public function updateLobbyTabs(p__1:String):void
		{
			if (p__1 == "sitngo"){
				pgData.dispMode = "tournament";
				lobbyControl.plModel.sLobbyMode = "tournament";
			} else if (p__1 == "shootout"){
				pgData.dispMode = "shootout";
				lobbyControl.plModel.sLobbyMode = "shootout";
			} else if (p__1 == "vip"){
				pgData.dispMode = "vip";
				lobbyControl.plModel.sLobbyMode = "vip";
			} else if (p__1 == "normal"){
				if (pgData.dispMode != "private"){
					pgData.dispMode = "challenge";
					lobbyControl.plModel.sLobbyMode = "challenge";
				}
			}
		}
		public function feedUpdates(p__1:Number, p__2:Number):void
		{
			var l__4:com.script.io.LoadUrlVars;
			var l__5:Object;
			if (pgData.sn_id != pgData.SN_FACEBOOK){
				return;
			}
			/*var l__3:Number = p__1 / p__2;
			if ((l__3 >= 2) && (p__1 >= 100)){
				l__4 = new LoadUrlVars();
				l__5 = new Object();
				l__5.points = p__1;
				l__5.level = (Math.floor(l__3) - 2);
				l__5.fb_sig_time = main.oFlashVars.fb_sig_time;
				l__5.fb_sig_user = main.oFlashVars.fb_sig_user;
				l__5.fb_sig_profile_update_time = main.oFlashVars.fb_sig_profile_update_time;
				l__5.fb_sig_session_key = main.oFlashVars.fb_sig_session_key;
				l__5.fb_sig_expires = main.oFlashVars.fb_sig_expires;
				l__5.fb_sig_added = main.oFlashVars.fb_sig_added;
				l__5.fb_sig_api_key = main.oFlashVars.fb_sig_api_key;
				l__5.fb_sig = main.oFlashVars.fb_sig;
			}*/
		}
		
		public function onShoutResponse(p__1:String)
		{
			var l__2:com.script.poker.protocol.SAlertPublished = new SAlertPublished(p__1);
			pcmConnect.sendMessage(l__2);
		}
		public function onInitZoom(p__1:Array):void
		{	
			var l__1:Array = pgData.name.split(" ");
			var l__2:* = "";			
			var l__3:* = "";
			var l__4:* = "Texas room";
			if (!(l__1[0] == null) && !(l__1[0] == undefined)){
				l__2 = l__1[0];
			}
			if (!(l__1[1] == null) && !(l__1[1] == undefined)){
				l__3 = l__1[1];
			}
			if (pgData.rejoinRoom != -1){
				l__4 = "Playing";
			}
			var l__5:com.script.poker.UserPresence = new UserPresence(viewer.zid, 1, pgData.serverId, pgData.rejoinRoom, l__4, l__2, l__3, "n/a", pgData.pic_url, zoomGetFriendsList(), zoomGetNetworkList());
			
			//if (zoomControl == null){
				zoomModel = new ZshimModel();
				//zoomControl = ZshimController.getInstance(pgData.zoomhost, pgData.zoomport, pgData.zoomPassword, l__5);
				//onInitZoomListeners();
			//} else {
				//zoomControl.updateGameInfo(pgData.serverId, pgData.rejoinRoom, l__4);
			//}
			
			//var l__12 = zoomGetFriendsList()
			
			var dd = new Date();
			
			for (var a=0; a<p__1.length; a++) {
				
				var l__11 = p__1[a].zname.split(" ");
				var l__12 = p__1[a].zid
				if (l__11[1] == null) {
					l__11[1] = "";
				}
				var dir = l__12.slice(0,1);
				var l__14 = pgData.pathz+"/Avatar/"+dir+"/"+l__12+".jpg?d="+dd;
				
				
				var l__10:com.script.poker.UserPresence = new UserPresence(l__12, 1, p__1[a].zserver, p__1[a].ztabid, "NAMA TABLE", l__11[0], l__11[1], "n/a", l__14, "", "", p__1[a].zserver);
				
				onZoomAddFriend(l__10);
			}
			/*
			pcmConnect.getLobbyRooms2();
			getLobbyRooms()
			getGiftInfo2(-1);
			getEmoInfo(-1)
			*/
			//zoomModel.updatePlayer(l__5, "friends");
			/*sZid = p__1;
			nGameId = p__2;
			nServerId = p__3;
			nRoomId = p__4;
			sRoomDesc = p__5;
			sFirstName = p__6;
			sLastName = p__7;
			sRelationship = p__8;
			sPicURL = p__9;
			sFriendIds = p__10;
			sNetworkIds = p__11;
			tableStakes = p__12;*/
		}
		public function zoomUpdateStakes(p__1:String, p__2:Number)
		{
			pgData.gameRoomStakes = p__1;
			if (zoomControl != null){
				zoomControl.updateGameInfo(pgData.serverId, pgData.gameRoomId, "n/a", pgData.gameRoomStakes);
			} else {
				zoomControl.updateGameInfo(pgData.serverId, pgData.rejoinRoom, "n/a", pgData.gameRoomStakes);
			}
		}
		private function stakeUp(p__1:flash.events.TimerEvent)
		{
		}
		private function onInitZoomListeners():void
		{
			//if (pgData.connectToZoom != 1){
				//return;
			//}
			zoomControl.addEventListener(ZshimController.ZOOM_UPDATE, onZoomUpdate);
			//zoomControl.addEventListener(ZshimController.ZOOM_ADD_FRIEND, onZoomAddFriend);
			zoomControl.addEventListener(ZshimController.ZOOM_REMOVE_FRIEND, onZoomRemoveFriend);
			zoomControl.addEventListener(ZshimController.ZOOM_CLEAR, onZoomClear);
			zoomControl.addEventListener(ZshimController.ZOOM_TABLE_INVITATION, onZoomTableInvitation);
		}
		private function onZoomUpdate(p__1:com.script.zoom.ZshimEvent):void
		{
			var l__2:com.script.poker.UserPresence = (p__1.msg as UserPresence);
			if (l__2 != null){
				l__2.sRoomDesc = getNetworkUserStatus(l__2.nServerId, loadBalancer.getServerType(l__2.nServerId), l__2.nRoomId);
				zoomModel.updatePlayer(l__2, "friends");
				zoomModel.updatePlayer(l__2, "network");
			}
		}
		
		//private function onZoomAddFriend(p__1:com.script.zoom.ZshimEvent):void
		private function onZoomAddFriend(p__1:com.script.poker.UserPresence):void
		{
			var l__3:String;
			pgData.nZoomFriends++;
			//var l__2:com.script.poker.UserPresence = (p__1.msg as UserPresence);
			/*if (l__2 != null){
				l__3 = loadBalancer.getServerType(l__2.nServerId);
				if (!(l__3 == "tourney") && (l__3.length > 0)){
					l__2.sRoomDesc = getNetworkUserStatus(l__2.nServerId, l__3, l__2.nRoomId);
					zoomModel.addPlayer(l__2, "friends");
				}
			}*/
			zoomModel.addPlayer(p__1, "friends");
			
			
		}
		private function onZoomRemoveFriend(p__1:com.script.zoom.ZshimEvent):void
		{
			pgData.nZoomFriends--;
			var l__2:com.script.poker.UserPresence = (p__1.msg as UserPresence);
			if (l__2 != null){
				zoomModel.deletePlayer(l__2, "friends");
			}
		}
		private function onZoomAddNetwork(p__1:com.script.zoom.ZshimEvent):void
		{
			/*var l__3:String;
			var l__2:com.script.poker.UserPresence = (p__1.msg as UserPresence);
			if (l__2 != null){
				l__3 = loadBalancer.getServerType(l__2.nServerId);
				if (!(l__3 == "tourney") && (l__3.length > 0)){
					l__2.sRoomDesc = getNetworkUserStatus(l__2.nServerId, l__3, l__2.nRoomId);
					l__2.sRelationship = getNetworkName(l__2.sNetworkIds);
					zoomModel.addPlayer(l__2, "network");
				}
			}*/
		}
		private function onZoomRemoveNetwork(p__1:com.script.zoom.ZshimEvent):void
		{
			/*var l__2:com.script.poker.UserPresence = (p__1.msg as UserPresence);
			if (l__2 != null){
				zoomModel.deletePlayer(l__2, "network");
			}*/
		}
		public function onZoomTableInvitation(p__1:Object):void
		{
			
			var l__1:Object = new Object();
			l__1.type = "onErrorPopup";
			l__1.upper = "Invitation";
			l__1.mess = "you have been invite to "+p__1.game+" game by "+p__1.uid+" \n "+p__1.msg;
			l__1.goto = "invited";
			l__1.uid = p__1.uid;
			l__1.room_id = p__1.tabid;
			l__1.server_id = 1;
			l__1.game = p__1.game;
			
			popupControl.regonErrorPopup(l__1);
			
		}
		public function onSentInvitePopup(p__1:Object):void {
			
			//var l__2:com.script.zoom.messages.ZoomTableInvitationMessage = (p__1.msg as ZoomTableInvitationMessage);
			var popObj = new Object();
			popObj.type = "onInviteMessages"
			popObj.zid = p__1.msg
			regPopup(popObj);
			
			return;
		}
		public function onSentZoomTableInvitation(p__1:Object):void
		{
			var l__2:com.script.zoom.messages.ZoomTableInvitationMessage = (p__1.zid as ZoomTableInvitationMessage);
			//var l__2 = p__1.msg;
			var l__4:com.script.poker.protocol.SSendInvite = new SSendInvite("SSendInvite", p__1.zid, p__1.msg);
			
			pcmConnect.sendMessage(l__4);
		}
		//private function onZoomClear(p__1:com.script.zoom.ZshimEvent):void
		private function onZoomClear():void
		{
			zoomModel.clearPlayer("friends");
			//zoomModel.clearPlayer("network");
		}
		private function zoomGetFriendsList():String
		{
			if (pgData.aFriendZids.length <= pgData.zoomFriendsLimit){
				return(pgData.aFriendZids.toString());
			}
			return(pgData.aFriendZids.slice(0, pgData.zoomFriendsLimit).toString());
		}
		private function zoomGetNetworkList():String
		{
			/*
			if (pgData.sn_id == pgData.SN_FACEBOOK){
				return(pgData.nids);
			}
			*/
			return("");
		}
		private function zoomUpdateUser():void
		{
			if (pgData.connectToZoom != 1){
				return;
			}
			if (pgData.rejoinRoom != -1){
				return;
			}
			var l__1:Number = -1;
			if (!bInLobbyRoom){
				l__1 = pgData.gameRoomId;
			} else {
				zoomControl.updateGameInfo(pgData.serverId, l__1, "n/a");
			}
		}
		public function getNetworkUserStatus(p__1:Number, p__2:String, p__3:Number):String
		{
			var l__4:* = "";
			/*if (((p__2 == "normal") || (p__2 == "sitngo")) || (p__2 == "shootout")){
				l__4 = getUserStatus(p__1, p__3);
			} else if (p__2 == "vip"){
				if (pgData.isVip == "1"){
					l__4 = getUserStatus(p__1, p__3);
				} else {
					l__4 = "VIP - Can\'t Join";
				}
			} else if (p__2.indexOf("special") == 0){
				if (p__2 == "special43"){
					l__4 = "Mafia Casino";
				} else {
					l__4 = getUserStatus(p__1, p__3);
				}
			}
			if (l__4 == "Playing"){
				if (pgData.sn_id == pgData.SN_FACEBOOK){
					TrackingHit("onlinefriendsplaying", 4, 17, 2010, 1, "online friends playing", "http://nav3.script.com/link/link.php?item=Poker%20FB%20Lobby%20Other%20FriendsOnline%20o%3ALiveJoin%3A2009-04-17&ltsig=c40bb98d613415b425e427cc4e09eb44");
				}
			}
			return(l__4);*/
			return false;
		}
		public function getUserStatus(p__1:Number, p__2:Number):String
		{
			var l__3:* = "";
			if (p__2 == -1){
				l__3 = "Lobby - Can\'t Join";
				if (p__1 == pgData.serverId){
				}
			} else if ((pgData.gameRoomId == p__2) && (pgData.serverId == p__1)){
				if (bInLobbyRoom){
					l__3 = "Playing";
				} else {
					l__3 = "At This Table";
				}
			} else {
				l__3 = "Playing";
			}
			return(l__3);
		}
		public function getNetworkName(inNetworkId:String):String
		{
			var nids:Array;
			var j = undefined;
			var networks_names:Array = pgData.nnames.split(",");
			var networks_ids:Array = pgData.nids.split(",");
			var oNetworkListHash:Object = new Object();
			var i:*;
			while(i < networks_names.length){
				oNetworkListHash[networks_ids[i]] = networks_names[i];
				i++;
			}
			try {
				nids = inNetworkId.split(",");
				j = 0;
				while(j < nids.length){
					if (oNetworkListHash[nids[j]] != undefined){
						return(oNetworkListHash[nids[j]]);   
					}
					j++;
				}
			} catch (error:Error) {
			}
			return("n/a");
		}
		public function TrackingHit(p__1:String, p__2:Number, p__3:Number, p__4:Number, p__5:Number, p__6:String, p__7:String, p__8:Number = 1, p__9:String = "")
		{
			StaticTrackingHit(p__1, p__2, p__3, p__4, p__5, p__6, p__7, p__8, p__9);
		}
		public function getServerType(p__1:String):String
		{
			return(loadBalancer.getServerType(p__1));
		}
		public function countFriendsAtServer(p__1:String):Number
		{
			var l__3:* = undefined;
			var l__4:com.script.poker.UserPresence;
			if (pgData.connectToZoom != 1){
				return(0);
			}
			var l__2:Number = 0;
			if (zoomModel.friendsList != null){
				for (l__3 in zoomModel.friendsList){
					l__4 = zoomModel.friendsList[l__3];
					if (loadBalancer.getServerType(l__4.nServerId) == p__1){
						l__2++;
					}
				}
			}
			return(l__2);
		}
		private function onShootoutConfig(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RShootoutConfig = RShootoutConfig(p__1);
			if (l__2.shootoutObj != null){
				soConfig.updateConfig(Number(l__2.shootoutObj["id"]), Number(l__2.shootoutObj["idVersion"]), String(l__2.shootoutObj["last_modified"]), Number(l__2.shootoutObj["buyin"]), Number(l__2.shootoutObj["rounds"]), Number(l__2.shootoutObj["players"]), l__2.shootoutObj["winner_count"], l__2.shootoutObj["payouts"]);
			}
			if (l__2.userObj != null){
				soUser.updateUser(Boolean(Number(l__2.userObj["playing"]) == 0), String(l__2.userObj["last_played"]), Number(l__2.userObj["round"]), Number(l__2.userObj["won_count"]), Number(l__2.userObj["shootout_id"]), Number(l__2.userObj["buyin"]));
			} else {
				soUser.updateUser(false, "", 1, 0, 0, 0);
			}
			lobbyControl.updateShootoutConfig(soConfig, soUser);
		}
		private function onUserShootoutState(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RUserShootoutState = RUserShootoutState(p__1);
			if (l__2.userObj != null){
				soUser.updateUser(Boolean(Number(l__2.userObj["playing"]) == 0), String(l__2.userObj["last_played"]), Number(l__2.userObj["round"]), Number(l__2.userObj["won_count"]), Number(l__2.userObj["shootout_id"]), Number(l__2.userObj["buyin"]));
				pgData.soRound = soUser.nRound;
			} else {
				soUser.updateUser(false, "", 1, 0, 0, 0);
				pgData.soRound = soUser.nRound;
			}
			var l__3:String = loadBalancer.getServerType(pgData.serverId);
			var l__4:com.script.poker.protocol.SSuperJoinRoom = new SSuperJoinRoom(pgData.lobbyRoomId, "", pgData.jt);
			if (l__3.split("shootout")[1] == pgData.soRound.toString()){
				pgData.joinShootoutLobby = false;
				dispatchEvent(new InterstitialPopupEvent(InterstitialPopupEvent.INTERSITIAL, "Joining Lobby...", ""));
				pcmConnect.sendMessage(l__4);
			} else {
				pgData.bVipNav = true;
				pgData.joinShootoutLobby = false;
				pcmConnect.sendMessage(l__4);
				
				pcmConnect.disconnect();
			}
		}
		public static function StaticTrackingHit(p__1:String, p__2:Number, p__3:Number, p__4:Number, p__5:Number, p__6:String, p__7:String, p__8:Number = 1, p__9:String = "")
		{			
			var l__17:String;
			var l__18:String;
			var l__10:Date = new Date();
			var l__11:Number = l__10.getUTCFullYear();
			var l__12:Number = (l__10.getUTCMonth() + 1);
			var l__13:Number = l__10.getUTCDate();
			var l__14:Boolean;
			var l__15:com.script.io.LoadUrlVars = new LoadUrlVars();
			if ((p__4 > 0) && (p__4 < l__11)){
				l__14 = true;
			}
			if ((p__4 > 0) && (p__4 == l__11)){
				if (p__2 < l__12){
					l__14 = true;
				} else if ((p__2 == l__12) && (p__3 <= l__13)){
					l__14 = true;
				}
			}
			var l__16:Boolean;
			if (p__5 == 1){
				if (aStatsHash[p__1] == undefined){
					l__16 = true;
					aStatsHash[p__1] = 1;
				}
			} else if (p__5 == -1){
				l__16 = true;
			} else if (((pgData.uid + pgData.uAppStartTime) % p__5) == 0){
				l__16 = true;
			}
			if (l__14){
				return;
			}
			if (p__7 != null){
				if (l__16){
					l__15.loadURL(((p__7 + "&inc=") + (((p__5 > 0) ? p__5 : 1) * p__8).toString()), {}, "POST");
				}
			} else {
				l__17 = pgData.getSNTrackingString("0");
				p__6 = ((("Poker " + l__17) + " ") + p__6);
				if (!(p__9 == null) && !(p__9 == "")){
					p__6 = (p__6 + (":" + p__9));
				}
				l__18 = GetSignedTrackingUrl(p__6);
				if (l__18 != null){
					if (l__16){
						l__15.loadURL(((l__18 + "&inc=") + (((p__5 > 0) ? p__5 : 1) * p__8).toString()), {}, "POST");
					}
				}
			}
		}
		public static function GetSignedTrackingUrl(p__1:String):String
		{
			var l__2:* = "SxC1ZN";
			var l__3:String = MD5.hash((p__1 + l__2));
			//var l__4:String = ((("http://nav3.script.com/link/link.php?item=" + escape(p__1)) + "&ltsig=") + escape(l__3));
			return 0;
		}
	}
}