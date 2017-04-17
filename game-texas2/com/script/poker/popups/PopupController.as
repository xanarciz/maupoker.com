// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups
{
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
    import flash.net.URLRequestMethod;
	 import flash.net.navigateToURL;


	import com.script.poker.lobby.RoomItem;
	import com.script.poker.lobby.LobbyController;
	import com.script.poker.table.TableController;
	import com.script.poker.table.GiftItem;
	import com.script.poker.table.GiftLibrary;
	import com.script.poker.table.EmoItem;
	import com.script.poker.table.EmoLibrary;
	import com.script.poker.PokerUser;
	import com.script.poker.PokerGlobalData;
	import com.script.poker.PokerController;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.EventDispatcher;
	import fl.controls.RadioButtonGroup;
	import com.script.poker.events.PopupEvent;
	import com.script.poker.events.InterstitialPopupEvent;
	import com.script.poker.events.MSTourneyPopupEvent;
	import com.script.poker.events.ErrorPopupEvent;
	import com.script.poker.events.MyspacePopupEvent;
	import com.script.poker.events.VIPPopupEvent;
	import com.script.poker.events.GiftPopupEvent;
	import com.script.poker.events.EmoPopupEvent;
	import com.script.poker.events.TBPopupEvent;
	import com.script.poker.events.UserPopupEvent;
	import com.script.poker.events.TourneyBuyInPopupEvent;
	import com.script.poker.events.TourneyCongratsPopupEvent;
	import com.script.poker.events.ShootoutCongratsPopupEvent;
	
	import com.script.poker.popups.modules.events.TBEvent;
	import com.script.poker.popups.modules.events.CongratsEvent;
	import com.script.poker.popups.modules.events.ShootoutCongratsEvent;
	import com.script.poker.popups.modules.events.BBCardEvent;
	import com.script.poker.popups.modules.events.ProfileEvent;
	import com.script.poker.popups.modules.events.BBCGiftEvent;
	import com.script.poker.popups.modules.events.RUEvent;
	import com.script.poker.popups.modules.events.DSGBuyEvent;
	import com.script.poker.popups.modules.events.DSGEvent;
	import com.script.poker.popups.modules.events.EmoBuyEvent;
	import com.script.poker.popups.modules.events.EmoEvent;
	import com.script.poker.popups.modules.events.BDEvent;
	import com.script.poker.popups.modules.events.TPEvent;
	import com.script.poker.popups.modules.events.VIPEvent;
	import com.script.poker.popups.events.PPVEvent;
	import com.script.display.Dialog.DialogEvent;
	import flash.utils.Timer;
	import com.script.format.*;
	import com.script.io.LoadUrlVars;
	import flash.external.*;
	
	public class PopupController extends flash.events.EventDispatcher
	{
		private var ppModel:com.script.poker.popups.PopupModel;
		private var bBBCardInitialized:Boolean = false;
		private var bDailyBonusInitialized:Boolean = false;
		private var bShootoutCongratsInitialized:Boolean = false;
		private var bTourneyBuyInInitialized:Boolean = false;
		private var bTableBuyInInitialized:Boolean = false;
		private var bTransferChipsInitialized:Boolean = false;
		private var xmlPopups:XML;
		private var pgData:com.script.poker.PokerGlobalData;
		private var bBuddyDialogInitialized:Boolean = false;
		private var tControl:com.script.poker.table.TableController;
		private var lControl:com.script.poker.lobby.LobbyController;
		private var bTourneyCongratsInitialized:Boolean = false;
		private var bDrinkMenuInitialized:Boolean = false;
		private var bEmoMenuInitialized:Boolean = false;
		private var ppView:Object;
		private var pptcView:Object;
		private var ppctView:Object;
		private var ppsiView:Object;
		private var pptrView:Object;
		private var ppepView:Object;
		private var ppcpView:Object;
		private var ppemView:Object;
		private var ppgfView:Object;
		private var pppfView:Object;
		private var ppbbView:Object;
		private var ppbdView:Object;
		private var ppreView:Object;
		private var ppeiView:Object;
		private var onGoto:String;
		private var ErrorObj:Object;
		private var pControl:com.script.poker.PokerController;
		private var bReportUserInitialized:Boolean = false;
		private var mainDisp:flash.display.MovieClip;
		private var _profileLock:Boolean = false;
		private var moveX;
		private var moveY;
		public var langs;
		
		public function PopupController()
		{		
     
		}
		public function startPopupController(p__1:flash.display.MovieClip, p__2:com.script.poker.PokerGlobalData, p__3:com.script.poker.PokerController, p__4:com.script.poker.lobby.LobbyController, p__5:com.script.poker.table.TableController):void
		{
			mainDisp = p__1;
			pgData = p__2; 
			pControl = p__3;
			lControl = p__4;
			tControl = p__5;
			xmlPopups = pgData.xmlPopups;
			ppModel = new PopupModel();
			langs = pgData.langs;
			initPopupView();
			initPopupModel();
			
		}
		 public function updateProfileItems(param1:Array) : void
        {
           // var _loc_2:* = getPopupByID(Popup.PROFILE);
            //if (_loc_2 != null && _loc_2.module != null)
            //{
				    pppfView.showItems(param1);
            //}
            return;
        }
		private function initPopupModel():void
		{
			
			ppView.hydrate(pptcView);
			ppView.hydrate(ppctView);
			ppView.hydrate(ppsiView);
			ppView.hydrate(pptrView);
			ppView.hydrate(ppepView);
			ppView.hydrate(ppcpView);
			ppView.hydrate(ppemView);
			ppView.hydrate(ppgfView);
			ppView.hydrate(pppfView);
			ppView.hydrate(ppbbView);
			ppView.hydrate(ppbdView);
			ppView.hydrate(ppreView);
			ppView.hydrate(ppeiView);
		
		
			/*
			var l__2:com.script.poker.popups.Popup;
			var l__3:XML;
			var l__4:int;
			var l__1:XMLList = xmlPopups.child("popup");
			for each (l__3 in l__1){
				if (!(l__3.@id == 18) || (pgData.firstTimePlaying == 1)){
					l__2 = new Popup(l__3);
					l__2.aControllers = l__3.child("event").attribute("controller").toString().split(",");
					l__2.sEventName = l__3.child("event").toString();
					l__2.sType = l__3.@type;
					if ((l__3.child("content").child("module").length() > 0) && (l__2.sType == "flash")){
						l__2.bHasModule = true;
						l__2.moduleType = l__3.content.module.@type;
						l__2.sModuleClass = l__3.content.module.@sClass;
						l__2.moduleRef = pgData.lbPopup.getLoaderByType(l__2.sModuleClass).content;
						l__2.popupRef = Object(ppView.hydrate(l__3, l__2.moduleRef));
					} else if (l__2.sType == "flash"){
						l__2.popupRef = Object(ppView.hydrate(l__3));
					}
					ppModel.addPopup(l__2);
					l__4 = 0;
					while(l__4 < l__2.aControllers.length){
						registerEvent(l__2.aControllers[l__4], l__2.sEventName);
						l__4++;
					}
				}
			}
			*/
			registerEvent("table", "com.script.poker.events.PopupEvent");
			registerEvent("lobby", "com.script.poker.events.PopupEvent");
			registerEvent("poker", "com.script.poker.events.PopupEvent");
		}
		private function initPopupView():void
		{
			trace("init pop")
			var l__1:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.PopupView");
			ppView = Object(l__1.content);
			mainDisp.addChildAt(ppView, mainDisp.numChildren);
			var l__2:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.modules.TableCashier");
			pptcView = Object(l__2.content);
			mainDisp.addChildAt(pptcView, mainDisp.numChildren);
			pptcView.langs = langs;
			trace("init pop 1")
			pptcView.visible = false;
			var l__3:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.modules.CreateTable");
			ppctView = Object(l__3.content);
			mainDisp.addChildAt(ppctView, mainDisp.numChildren);
			ppctView.langs = langs;
			ppctView.visible = false;
			trace("init pop 2") 
			var l__4:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.modules.SingleInputGenericPanel");
			ppsiView = Object(l__4.content);
			mainDisp.addChildAt(ppsiView, mainDisp.numChildren);
			ppsiView.visible = false;
			trace("init pop 3")
			var l__5:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.modules.TransferChips");
			pptrView = Object(l__5.content);
			mainDisp.addChildAt(pptrView, mainDisp.numChildren);
			pptrView.visible = false;
			trace("init pop 4")
			var l__6:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.modules.ErrorPop");
			ppepView = Object(l__6.content);
			mainDisp.addChildAt(ppepView, mainDisp.numChildren);
			ppepView.visible = false;
			trace("init pop 5")
			var l__7:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.modules.ChangePass");
			ppcpView = Object(l__7.content);			
			mainDisp.addChildAt(ppcpView, mainDisp.numChildren);
			ppcpView.langs = langs;
			ppcpView.visible = false;
			trace("init pop 6")
			var l__8:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.modules.EmoPanel.EmoPanel");
			ppemView = Object(l__8.content);			
			//mainDisp.addChildAt(ppemView, mainDisp.numChildren);			
			ppView.addChild(ppemView)
			ppemView.langs = langs;
			ppemView.visible = false;
			trace("init pop 7")
			var l__9:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.modules.DSGPanel.DSGPanel");
			ppgfView = Object(l__9.content);
			trace(l__9.content+"ball");
			//mainDisp.addChildAt(ppgfView, mainDisp.numChildren);
			ppView.addChild(ppgfView)
			ppgfView.langs = langs;
			ppgfView.visible = false;
			trace("init pop 8")
			var l__10:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.modules.BaseballCard");
			ppbbView = Object(l__10.content);
			mainDisp.addChildAt(ppbbView, mainDisp.numChildren);
			ppbbView.langs = langs;
			ppbbView.visible = false;
			trace("init pop 9")
			var l__11:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.modules.ProfilePanel");
			pppfView = Object(l__11.content);
			//mainDisp.addChildAt(pppfView, mainDisp.numChildren);
			
			ppView.addChild(pppfView)
			pppfView.langs = langs;
			pppfView.visible = false;
			trace("init pop 10")
			var l__12:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.modules.buddy.BuddyDialog");
			ppbdView = Object(l__12.content);
			mainDisp.addChildAt(ppbdView, mainDisp.numChildren);
			ppbdView.visible = false;
			trace("init pop 11")
			var l__13:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.modules.ReportErrorPanel");
			ppreView = Object(l__13.content);
			mainDisp.addChildAt(ppreView, mainDisp.numChildren);			
			ppreView.visible = false;
			trace("init pop 12")
			var l__14:flash.display.Loader = pgData.lbPopup.getLoaderByType("com.script.poker.popups.modules.EventPanel");
			ppeiView = Object(l__14.content);
			mainDisp.addChildAt(ppeiView, mainDisp.numChildren);
			ppeiView.visible = false;
			trace("init pop 13")
		}
		private function parseEvents():void
		{
			var l__2:Array;
			var l__3:String;
			var l__4:XML;
			var l__5:int;
			var l__1:XMLList = xmlPopups.child("popup");
			for each (l__4 in l__1){
				l__2 = l__4.child("event").attribute("controller").toString().split(",");
				l__3 = l__4.child("event").toString();
				l__5 = 0;
				while(l__5 < l__2.length){
					registerEvent(l__2[l__5], l__3);
					l__5++;
				}
			}
		}
		private function getPopupType(p__1:String):String
		{
			var l__2:XMLList = xmlPopups.child("popup");
		}
		public function regonPopup(p__1:Object):void {
			
			/*
			var l__1:Object = new Object();
			l__1.type = p__1;
			l__1.nSit = p__2;
			*/
			onPopupEvent(p__1);
		}
		public function regonErrorPopup(p__1:Object):void {
			
			/*var l__1:Object = new Object();
			l__1.type = p__1;
			l__1.nSit = p__2;*/
			onPopupEvent(p__1);
		}
		private function registerEvent(p__1:String, p__2:String):void
		{
			switch(p__1){
				case "table":
				{
					trace("popup duit");
					tControl.addEventListener(p__2, onPopupEvent);
					break;
				}
				case "lobby":
				{
					lControl.addEventListener(p__2, onPopupEvent);
					break;
				}
				case "poker":
				{
					trace("popup duit2");
					pControl.addEventListener(p__2, onPopupEvent);
					break;
				}
			}
		}
		//========================================
		private function updateTransferChips(p__1:Object):void
		{
			var l__3:com.script.poker.events.TBPopupEvent;
			
			//var l__4:Number = tControl.ptModel.nMinBuyIn;
			//var l__5:Number = (pgData.points < tControl.ptModel.room.maxBuyin) ? pgData.points : tControl.ptModel.room.maxBuyin;
			//var l__6:Number = tControl.ptModel.room.bigBlind * 100;
			//if (tControl.ptModel.nMinBuyIn > l__5){
				//l__5 = tControl.ptModel.room.maxBuyin;
			//}
			//l__6 = (l__6 > l__5) ? (tControl.ptModel.room.bigBlind * 15) : l__6;
			//l__6 = (l__6 > l__5) ? l__5 : l__6;
			p__1.minimum = 0;
			 
			//p__1.maximum = l__5;
			p__1.transfer = pgData.points;
			p__1.balance = pgData.deposit;
			//p__1.sit = l__3.sit;
			p__1.warning = "";
			
			pptrView.minimum =0;
			pptrView.transfer = pgData.points;
			pptrView.balance = pgData.deposit;
			pptrView.convert = pgData.chipConvert;
			pptrView.warning = "";
			if (!bTransferChipsInitialized){
				initTransferChips(p__1);
			}
			//p__1.popupRef.show(true);
			pptrView.visible = true;
			pptrView.x = 100;
			pptrView.y = 100;
			pptrView.setFieldFocus();
			//p__1.moduleRef.setFieldFocus();
			//dispatchEvent(new fieldview())
		}
		private function initTransferChips(p__1:Object):void
		{
			pptrView.addEventListener(TBEvent.TRANS_ACCEPT, onTransAccept);
			pptrView.addEventListener(TBEvent.TRANS_CANCEL, onTransCancel);
			//pptrView.addEventListener(PPVEvent.TRANS_ACCEPT, onTransAccept);
			//pptrView.addEventListener(PPVEvent.TRANS_CANCEL, onTransCancel);
			bTransferChipsInitialized = true;
		}
		private function onTransAccept(p__1:com.script.poker.popups.modules.events.TBEvent):void
		{	
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showTableBuyIn");
			pptrView.visible = false;
			//l__2.popupRef.hide();
			pControl.onTransAccept(p__1.transfer); 
		}
		private function onTransCancel(p__1:com.script.poker.popups.modules.events.TBEvent):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showTableBuyIn");
			pptrView.visible = false;
			//l__2.popupRef.hide();
		}
		//========================================
		private function showErrorPopup(p__1:Object):void
		{
			var l__3:com.script.poker.events.TBPopupEvent;
			
			//var l__4:Number = tControl.ptModel.nMinBuyIn;
			//var l__5:Number = (pgData.points < tControl.ptModel.room.maxBuyin) ? pgData.points : tControl.ptModel.room.maxBuyin;
			//var l__6:Number = tControl.ptModel.room.bigBlind * 100;
			//if (tControl.ptModel.nMinBuyIn > l__5){
				//l__5 = tControl.ptModel.room.maxBuyin;
			//}
			
			//l__6 = (l__6 > l__5) ? (tControl.ptModel.room.bigBlind * 15) : l__6;
			//l__6 = (l__6 > l__5) ? l__5 : l__6;
			
			//p__1.minimum = 0;
			 
			
			//p__1.maximum = l__5;
			//p__1.transfer = pgData.points;
			//p__1.balance = pgData.deposit;
			
			//p__1.sit = l__3.sit;
			
			//p__1.warning = "";
			ppepView.titles = p__1.upper;
			ppepView.mess = p__1.mess;
			onGoto = p__1.goto;
			ErrorObj = p__1;
			//pptrView.minimum =0;
			//pptrView.transfer = pgData.points;
			//pptrView.balance = pgData.deposit;
			//pptrView.warning = "";
			
			initErrorPop(p__1);
			//if (!bTransferChipsInitialized){
				//initTransferChips(p__1);
			//}
			//p__1.popupRef.show(true);
			ppepView.visible = true;
			ppepView.x = 0;
			ppepView.y = 0;
			if (p__1.goto == "invited" || p__1.goto == "server") {
				ppepView.btnSubmitCancel.visible = true;				
			}
			else {
				ppepView.btnSubmitCancel.visible = false;
			}
			//ppepView.setFieldFocus();
			//p__1.moduleRef.setFieldFocus();
			//dispatchEvent(new fieldview())
		}
		private function initErrorPop(p__1:Object):void
		{
			ppepView.addEventListener(PPVEvent.ENTER_ERROR, onErrorOk);
			ppepView.addEventListener(PPVEvent.CANCEL_ERROR, onErrorCancel);
			//pptrView.addEventListener(PPVEvent.TRANS_CANCEL, onTransCancel);
			//bTransferChipsInitialized = true;
			
		}
		private function onErrorOk(p__1:com.script.poker.popups.events.PPVEvent):void
		{	
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showTableBuyIn");
			ppepView.removeEventListener(PPVEvent.ENTER_ERROR, onErrorOk);
			ppepView.visible = false;
			if (onGoto == "menu") {
				var URLmenu:URLRequest = new URLRequest("/menu.php");
				navigateToURL(URLmenu,"_self");
				
			}
			if (onGoto == "logout") {
				var URLmenu:URLRequest = new URLRequest("/menu.php");
				navigateToURL(URLmenu,"_self");
				
			}
			if (onGoto == "lobby") {
				//var URLmenu:URLRequest = new URLRequest("/menu.php");
				//navigateToURL(URLmenu,"_self");
				pControl.onToLobby()
			}
			if (onGoto == "server") {
				//var URLmenu:URLRequest = new URLRequest("/menu.php");
				//navigateToURL(URLmenu,"_self");
				lControl.pickNewCasino2(ErrorObj)
			}
			if (onGoto == "invited") {
				if(ErrorObj.game == "TXH") {
					
					pgData.isJoinFriend = false;
					pgData.isJoinFriendSit = false;
				
					if(pControl.bInLobbyRoom == true) {
						pControl.updateLobbyTabs("normal");
						pgData.nNewRoomId = ErrorObj.room_id;
						pgData.newServerId = 1;
						pgData.joiningContact = true;
						pControl.joinTableCheck(ErrorObj.room_id)
						
					}
					else {
						pControl.tableJoin(ErrorObj);
					}
				}
				else {
					var URLgame:URLRequest = new URLRequest("/"+ErrorObj.game+"/"+ErrorObj.game+".php");
					navigateToURL(URLgame,"_self");
					
				}
				
			}
			
			//l__2.popupRef.hide();
		}
		private function onErrorCancel(p__1:com.script.poker.popups.events.PPVEvent):void
		{	
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showTableBuyIn");
			ppepView.removeEventListener(PPVEvent.CANCEL_ERROR, onErrorCancel);
			ppepView.visible = false;
			/*
			if (onGoto == "menu") {
				var URLmenu:URLRequest = new URLRequest("/menu.php");
				navigateToURL(URLmenu,"_self");
				
			}
			if (onGoto == "lobby") {
				//var URLmenu:URLRequest = new URLRequest("/menu.php");
				//navigateToURL(URLmenu,"_self");
				pControl.onToLobby()
			}*/
			
			//l__2.popupRef.hide();
		}
		//=====================================
		private function showReportError(p__1:Object):void
		{
			var l__3:com.script.poker.events.TBPopupEvent;
			
			initReportErr(p__1);
			ppreView.visible = true;
			ppreView.x = 140;
			ppreView.y = 100;
			
		}
		private function initReportErr(p__1:Object):void
		{
			
			ppreView.addEventListener(PPVEvent.ENTER_REPORT, onReportOk);
			ppreView.addEventListener(PPVEvent.CANCEL_REPORT, onReportCancel);
			
			
		}
		private function onReportOk(p__1:com.script.poker.popups.events.PPVEvent):void
		{	
			ppreView.removeEventListener(PPVEvent.ENTER_REPORT, onReportOk);
			ppreView.visible = false;
			pControl.onReportAccept(ppreView.rep_p.text, ppreView.rep_ket.text, pgData.gameRoomId);
			
			
		}
		private function onReportCancel(p__1:com.script.poker.popups.events.PPVEvent):void
		{	
			ppreView.removeEventListener(PPVEvent.CANCEL_REPORT, onReportCancel);
			ppreView.visible = false;
			
		}
		
		//=====================================
		//=====================================
		private function updateTableBuyIn(p__1:Object):void
		{
			//var l__3:com.script.poker.events.TBPopupEvent;
			
			var l__4:Number = tControl.ptModel.nMinBuyIn;
			var l__5:Number = (pgData.points < tControl.ptModel.room.maxBuyin) ? pgData.points : tControl.ptModel.room.maxBuyin;
			var l__6:Number = tControl.ptModel.room.bigBlind * 100;
			if (tControl.ptModel.nMinBuyIn > l__5){
				l__5 = tControl.ptModel.room.maxBuyin;
			}
			l__6 = (l__6 > l__5) ? (tControl.ptModel.room.bigBlind * 25) : l__6;
			l__6 = (l__6 > l__5) ? l__5 : l__6;
			p__1.minimum = l__4;
			 
			p__1.maximum = l__5;
			p__1.buyin = l__6;
			p__1.buyfee = tControl.ptModel.nBuyFee;
			p__1.balance = pgData.points;
			//p__1.sit = l__3.sit;
			//p__1.sit = 5;
			p__1.warning = "";
			
			pptcView.minimum =l__4;
			pptcView.maximum = l__5;
			pptcView.buyin = l__6;
			pptcView.sit = p__1.nSit;
			pptcView.balance = pgData.points;
			pptcView.buyfee = p__1.buyfee;
			pptcView.warning = "";
			
			if (!bTableBuyInInitialized){
				initTableBuyIn(p__1);
			}
			//p__1.popupRef.show(true);
			pptcView.visible = true;
			pptcView.x = 100;
			pptcView.y = 100;
			pptcView.setFieldFocus();
			
			//p__1.moduleRef.setFieldFocus();
			//dispatchEvent(new fieldview())
		}
		private function initTableBuyIn(p__1:Object):void
		{
			pptcView.addEventListener(TBEvent.BUYIN_ACCEPT, onBuyInAccept);
			pptcView.addEventListener(TBEvent.BUYIN_CANCEL, onBuyInCancel);
			bTableBuyInInitialized = true;
		}
		private function onBuyInAccept(p__1:com.script.poker.popups.modules.events.TBEvent):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showTableBuyIn");
			pptcView.visible = false;
			//l__2.popupRef.hide();
			pControl.onBuyInAccept(p__1.buyIn, p__1.sit);
		}
		public function removeBuyin(){
			pptcView.visible = false;
			pptrView.visible = false;
			ppbbView.visible = false;
			ppbdView.visible = false
			
			if (ppctView.visible == true) {
				ppctView.removeEventListener(PPVEvent.PRIVATE_TABLE_NO, onPrivateTableCancel);
				ppctView.reset();
				ppctView.visible = false;
			}
			if (ppsiView.visible == true) { 
				ppsiView.removeEventListener(PPVEvent.ENTER_PASS, onEnterPass);
				ppsiView.visible = false;
			}
			if(ppemView.visible = true){
				initEmoRemove(ppemView)
				ppemView.visible = false;
			}
			if(ppgfView.visible = true){
				initEmoRemove(ppemView)
				ppgfView.visible = false;
			}
			if(pppfView.visible = true){
				initEmoRemove(pppfView)
           		pppfView.visible = false;
			}
			
			
			
		}
		private function onBuyInCancel(p__1:com.script.poker.popups.modules.events.TBEvent):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showTableBuyIn");
			pptcView.visible = false;
			//l__2.popupRef.hide();
		}
		private function updateTournamentBuyIn(p__1:com.script.poker.popups.Popup, p__2:com.script.poker.events.PopupEvent):void
		{	
			var l__3:com.script.poker.events.TourneyBuyInPopupEvent = TourneyBuyInPopupEvent(p__2);
			p__1.moduleRef.tableName = tControl.ptModel.room.roomName;
			p__1.moduleRef.players = tControl.ptModel.room.maxPlayers;
			p__1.moduleRef.blindInterval = tControl.ptModel.room.smallBlind;
			p__1.moduleRef.prizes = tControl.ptModel.room.prizes;
			p__1.moduleRef.tournamentFee = tControl.ptModel.room.entryFee;
			p__1.moduleRef.hostFee = tControl.ptModel.room.hostFee;
			p__1.moduleRef.balance = pgData.points;
			p__1.moduleRef.sit = l__3.sit;
			if (!bTourneyBuyInInitialized){
				initTourneyBuyIn(p__1);
			}
			p__1.popupRef.show(true);
		}
		private function initTourneyBuyIn(p__1:com.script.poker.popups.Popup):void
		{
			p__1.popupRef.addEventListener("TOURNEY_BUYIN", onTourneyBuyInAccept);
			bTourneyBuyInInitialized = true;
		}
		private function onTourneyBuyInAccept(p__1:com.script.poker.popups.events.PPVEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showTournamentBuyIn");
			var l__3:int = l__2.moduleRef.sit;
			var l__4:int = l__2.moduleRef.total;
			if (pgData.points >= l__4){
				pControl.onBuyInAccept(l__4, l__3);
				l__2.popupRef.hide();
			}
		}
		private function updateTournamentCongrats(p__1:com.script.poker.popups.Popup, p__2:com.script.poker.events.PopupEvent):void
		{
			var l__3:com.script.poker.events.TourneyCongratsPopupEvent = TourneyCongratsPopupEvent(p__2);
			p__1.moduleRef.setPlace(l__3.place);
			p__1.moduleRef.setWinnings(l__3.win);
			p__1.moduleRef.renderText();
			pgData.tourneyResultsPlace = l__3.place;
			pgData.tourneyResultsWinnings = l__3.win;
			if (pgData.sn_id == pgData.SN_FACEBOOK){
				p__1.moduleRef.bFacebook = true;
			}
			p__1.moduleRef.showFeedButton();
			if (!bTourneyCongratsInitialized){
				initTourneyCongrats(p__1);
			}
			pgData.DisablePHPPopups();
			pgData.EnsurePHPPopupsAreClosed();
			p__1.popupRef.show(true);
		}
		private function initTourneyCongrats(p__1:com.script.poker.popups.Popup):void
		{
			p__1.popupRef.addEventListener(PPVEvent.TOURNEY_CONGRATS_CLOSE, onTourneyCongrats);
			p__1.moduleRef.addEventListener(CongratsEvent.FEED_PUBLISH, onFeedPublish);
			bTourneyCongratsInitialized = true;
		}
		private function onTourneyCongrats(p__1:com.script.poker.popups.events.PPVEvent):void
		{
			tControl.ptView.onLeaveTourney();
			onCloseCongrats();
		}
		private function onFeedPublish(p__1:com.script.poker.popups.modules.events.CongratsEvent):void
		{
			var l__4:String;
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showTournamentCongrats");
			if (l__2 != null){
				l__2.popupRef.hide();
			}
			pgData.EnablePHPPopups();
			var l__3:Number = p__1.nPlace;
			switch(l__3){
				case 1:
				{
					l__4 = "1st";
					break;
				}
				case 2:
				{
					l__4 = "2nd";
					break;
				}
				case 3:
				{
					l__4 = "3rd";
					break;
				}
			}
			var l__5:String = StringUtility.StringToMoney(p__1.nWinnings);
			pgData.JSCall_SitNGoWinFeed(pgData.kJS_SITNGOWINFEED, l__4, l__5, "1");
		}
		private function onCloseCongrats():void
		{
			pgData.EnablePHPPopups();
			var l__1:Number = pgData.tourneyResultsPlace;
			var l__2:* = "0";
			if (l__1 == 1){
				l__2 = "1st";
			}
			if (l__1 == 2){
				l__2 = "2nd";
			}
			if (l__1 == 3){
				l__2 = "3rd";
			}
			var l__3:String = StringUtility.StringToMoney(pgData.tourneyResultsWinnings);
			pgData.JSCall_SitNGoWinFeed(pgData.kJS_SITNGOWINFEED, l__2, l__3, "0");
		}
		private function updateShootoutCongrats(p__1:com.script.poker.popups.Popup, p__2:com.script.poker.events.PopupEvent):void
		{
			var l__3:com.script.poker.events.ShootoutCongratsPopupEvent = ShootoutCongratsPopupEvent(p__2);
			if (pgData.sn_id == pgData.SN_FACEBOOK){
				p__1.moduleRef.bFacebook = true;
			}
			if (pgData.isWSOP == false){
				p__1.moduleRef.wsopBadge.visible = false;
			}
			if (!bShootoutCongratsInitialized){
				initShootoutCongrats(p__1);
			}
			p__1.moduleRef.showCongrats(pControl.soUser.nRound, pControl.soConfig.nBuyin, l__3.place, l__3.win, pControl.soConfig.aPayouts, pControl.soConfig.nRounds);
			pgData.DisablePHPPopups();
			pgData.EnsurePHPPopupsAreClosed();
			p__1.popupRef.show(true);
		}
		private function initShootoutCongrats(p__1:com.script.poker.popups.Popup):void
		{
			p__1.moduleRef.btnBackToLobby.addEventListener(MouseEvent.CLICK, onShootoutCongratsBackToLobby);
			p__1.moduleRef.btnSignUpWSOP.addEventListener(MouseEvent.CLICK, onShootoutCongratsSignWSOP);
			p__1.moduleRef.addEventListener(ShootoutCongratsEvent.SHOOTOUT_FEED_PUBLISH, onShootoutFeedPublish);
			bShootoutCongratsInitialized = true;
		}
		private function killShootoutCongratsListeners(p__1:com.script.poker.popups.Popup):void
		{
			p__1.popupRef.removeEventListener(MouseEvent.CLICK, onShootoutCongratsBackToLobby);
			p__1.popupRef.removeEventListener(MouseEvent.CLICK, onShootoutCongratsSignWSOP);
			p__1.popupRef.removeEventListener(MouseEvent.CLICK, onShootoutCongratsSaveForLater);
		}
		private function onShootoutCongratsBackToLobby(p__1:flash.events.MouseEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showShootoutCongrats");
			if (l__2 != null){
				killShootoutCongratsListeners(l__2);
				l__2.popupRef.hide();
			}
			tControl.ptView.onLeaveShootout();
		}
		private function onShootoutCongratsSignWSOP(p__1:flash.events.MouseEvent):void
		{
		
			var l__3:Number = 0;
			var l__4:Number = 0;
			var l__5:Number = 0;
			var l__6:Number = 0;
			var l__7:Boolean;
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showShootoutCongrats");
			if (l__2 != null){
				killShootoutCongratsListeners(l__2);
				l__3 = l__2.moduleRef.thisRound;
				l__4 = l__2.moduleRef.thisTotalRounds;
				l__5 = l__2.moduleRef.thisChips;
				l__6 = l__2.moduleRef.thisPlace;
				l__7 = l__2.moduleRef.bFeed;
				pgData.JSCall_SignUpWSOP(l__7, l__3, l__4, l__5, l__6);
				l__2.popupRef.hide();
			}
			tControl.ptView.onLeaveShootout();
		}
		private function onShootoutCongratsSaveForLater(p__1:flash.events.MouseEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showShootoutCongrats");
			if (l__2 != null){
				killShootoutCongratsListeners(l__2);
				l__2.popupRef.hide();
			}
			tControl.ptView.onLeaveShootout();
		}
		private function onShootoutFeedPublish(p__1:com.script.poker.popups.modules.events.ShootoutCongratsEvent):void
		{
			pgData.EnablePHPPopups();
			pgData.JSCall_ShootoutWinFeed(p__1.nRound, p__1.nTotalRounds, p__1.nWinnings, p__1.nPlace, 1);
		}
		private function updateBaseballCard(p__1:Object):void
		{
			
			var l__4:com.script.poker.PokerUser = p__1.pokus[0];
			
			//var l__3:com.script.poker.events.UserPopupEvent = UserPopupEvent(p__2);
			//var l__4:com.script.poker.PokerUser = l__3.aUsers[0];
			//var l__4 = p__2
			/*p__1.moduleRef.username = l__4.sUserName;
			p__1.moduleRef.level = pgData.aRankNames[l__4.nAchievementRank];
			p__1.moduleRef.rank = l__4.nAchievementRank;
			p__1.moduleRef.network = l__4.sNetwork;
			p__1.moduleRef.vip = l__4.bIsVip;
			p__1.moduleRef.sZid = l__4.zid;
			p__1.moduleRef.icon = l__4.sPicLrgURL;
			p__1.moduleRef.chips = StringUtility.StringToMoney(l__4.nTotalPoints);
			p__1.moduleRef.isOwner = tControl.isMe(l__4.zid);
			p__1.moduleRef.vip = pgData.isVip;
			p__1.moduleRef.vipChecked = l__4.bIsVip;
			p__1.moduleRef.muteChecked = tControl.ptModel.isUserMuted(l__4.zid);
			p__1.moduleRef.maxGiftSend = tControl.getMaxGiftSend();
			p__1.popupRef.titleText = StringUtility.FormatString(pgData.config["baseballcard"]["title"], {sText:"%userName%", nVar:l__4.sUserName});
			*/
			
			ppbbView.btnAddBuddy.visible = Boolean(p__1.popev);
			ppbbView.username = l__4.sUserName;
			trace("taro nama "+l__4.bIsVip)
			//ppbbView.level = pgData.aRankNames[l__4.nAchievementRank];
			//ppbbView.rank = l__4.nAchievementRank;
			//ppbbView.network = l__4.sNetwork;
			ppbbView.vip = l__4.bIsVip;
			ppbbView.sZid = l__4.zid;
			ppbbView.icon = l__4.sPicLrgURL;
			ppbbView.chips = StringUtility.StringToMoney(l__4.nTotalPoints);
			
			ppbbView.isOwner = tControl.isMe(l__4.zid);
			//p__1.moduleRef.vip = pgData.isVip;
			//p__1.moduleRef.vipChecked = l__4.bIsVip;
			//p__1.moduleRef.muteChecked = tControl.ptModel.isUserMuted(l__4.zid);
			//p__1.moduleRef.maxGiftSend = tControl.getMaxGiftSend();
			//p__1.popupRef.titleText = StringUtility.FormatString(pgData.config["baseballcard"]["title"], {sText:"%userName%", nVar:l__4.sUserName});
			if (!bBBCardInitialized){
				initBBCard(ppbbView);
			}
			var l__5:Number = l__4.zid.substr(0, l__4.zid.indexOf(":", 0));
			//ppbbView.btnProfile.changeText(pgData.getSnName(l__5) + " Profile");
			//ppbbView.btnProfile.visible = true;
			//ppbbView.btnShowGift.visible = true;
			
			ppbbView.btnBuyItems.visible = true;
			
			//ppbbView.btnAddBuddy.visible = Boolean(l__3.bAddBuddy);
			//ppbbView.btnGiveChips.visible = true;
			//ppbbView.amtBox.visible = true;
			//ppbbView.btnAbuse.visible = true;
			ppbbView.feedCheck.visible = false;
			ppbbView.amtBox.visible = false;
			ppbbView.btnAbuse.visible = false;
			
			if ((l__5 == pgData.SN_FACEBOOK) && pgData.bFbFeedAllow){
				//ppbbView.feedCheck.visible = true;
				//ppbbView.showCheck();
				//pgData.bFbFeedOptin = true;
			} else {
				//ppbbView.feedCheck.visible = false;
			}
			if ((pgData.dispMode == "shootout") || (pgData.dispMode == "tournament")){
				if (tControl.isMe(l__4.zid)){
					//ppbbView.btnAbuse.visible = false;
				}
			}
			if ((pgData.tourneyId > -1) || (tControl.ptModel.room.gameType == "Tournament")){
				//ppbbView.btnShowGift.visible = false;
				ppbbView.btnItems.visible = false;
				ppbbView.btnBuyItems.visible = false;
				//ppbbView.btnGiveChips.visible = false;
				//ppbbView.feedCheck.visible = false;
				//ppbbView.amtBox.visible = false;
			} else if (tControl.isSeated()){
				if (tControl.isMe(l__4.zid)){
					//ppbbView.btnGiveChips.visible = false;
					//ppbbView.feedCheck.visible = false;
					//ppbbView.amtBox.visible = false;
					//ppbbView.btnAbuse.visible = false;
					ppbbView.btnItems.visible = true;
				}
				
				if (!tControl.bGiveChips){
					//ppbbView.btnGiveChips.visible = false;
					//ppbbView.feedCheck.visible = false;
					//ppbbView.amtBox.visible = false;
				}
			} else {
				ppbbView.btnBuyItems.visible = false;
				//ppbbView.btnGiveChips.visible = false;
				//ppbbView.feedCheck.visible = false;
				//ppbbView.amtBox.visible = false;
			}
			if (ppbbView.btnBuyItems.visible){
				pControl.getGiftPrices2(-1, l__4.zid);
			}
			if (!tControl.isMe(l__4.zid)){
					//ppbbView.btnGiveChips.visible = false;
					//ppbbView.feedCheck.visible = false;
					//ppbbView.amtBox.visible = false;
					//ppbbView.btnAbuse.visible = false;
					ppbbView.btnItems.visible = false;
				}
				
			ppbbView.visible = true;
			//p__1.popupRef.show(true);
		}
		private function initBBCard(p__1:Object):void
		{
			ppbbView.addEventListener(BBCardEvent.ABUSE, onAbuse);
			ppbbView.addEventListener(BBCardEvent.ADD_BUDDY, onAddBuddy);
			ppbbView.addEventListener(BBCardEvent.GIFT_CHIPS, onGiftChips);
			ppbbView.addEventListener(BBCardEvent.GIFT_MENU, onGiftMenu);
			ppbbView.addEventListener(BBCardEvent.SHOW_GIFT, onShowGift);
			ppbbView.addEventListener(BBCardEvent.PROFILE, onProfile);
			ppbbView.addEventListener(BBCardEvent.SHOW_VIP, onShowVip);
			ppbbView.addEventListener(BBCardEvent.SHOW_ITEMS, onShowItems);
			ppbbView.addEventListener(BBCardEvent.MUTE_USER, onMuteUser);
			ppbbView.addEventListener(BBCardEvent.DONE, onDone);
			ppbbView.addEventListener(BBCardEvent.FEED_CHECK, onFeedCheck);
			bBBCardInitialized = true;
		}
		private function onAbuse(p__1:com.script.poker.popups.modules.events.BBCardEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showBaseballCard");
			l__2.popupRef.hide();
			showReportUser(p__1.sZid);
		}
		private function onAddBuddy(p__1:com.script.poker.popups.modules.events.BBCardEvent):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showBaseballCard");
			//l__2.popupRef.hide();
			ppbbView.visible = false;
			pControl.onAddBuddy(p__1.sZid);
			tControl.onAddBuddy(p__1.sZid);
		}
		private function onGiftChips(p__1:com.script.poker.popups.modules.events.BBCGiftEvent):void
		{
			/*var l__3:com.script.poker.lobby.RoomItem;
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showBaseballCard");
			l__2.popupRef.hide();
			if (tControl.checkValidGift(p__1.nAmt)){
				pControl.onGiftChips(p__1.nAmt, p__1.sZid);
				tControl.startGiveChipsTimer();
				l__3 = pgData.getRoomById(pgData.gameRoomId);
				if (l__3.tableType == "Private"){
					if (pgData.sn_id == pgData.SN_FACEBOOK){
						pControl.TrackingHit("chipsentprivate", 4, 17, 2010, 1, "chip sent private", "http://nav3.script.com/link/link.php?item=Poker%20FB%20Table%20Other%20Sent%3ALiveChip%20o%3A%20privatetable%3A2009-04-17&ltsig=ce0be049b780cd35403d9703f8cd8a38");
					}
				} else if (pgData.dispMode == "challenge"){
					if (pgData.sn_id == pgData.SN_FACEBOOK){
						pControl.TrackingHit("chipsentchallenge", 4, 17, 2010, 1, "chip sent challenge", "http://nav3.script.com/link/link.php?item=Poker%20FB%20Table%20Other%20Sent%3ALiveChip%20o%3A%20pointstable%3A2009-04-17&ltsig=cb637197174396a4a604396d81ffb656");
					}
				}
			}*/
		}
		private function onShowItems(p__1:com.script.poker.popups.modules.events.BBCardEvent) : void
        {
            /*var _loc_2:* = getPopupByID(Popup.BASEBALL_CARD);
            if (_loc_2 != null)
            {
                _loc_2.container.hide();
            }*/
			
			ppbbView.visible = false;
            var _loc_3:Object = {zid:p__1.sZid, playerName:p__1.playerName};
            //showProfile(_loc_3, ProfilePanelTab.ITEMS);
			showProfile(_loc_3, 0);
			
            this.pControl.onQueryGifts2(-1);
            return;
        }
		private function onShowGift(p__1:com.script.poker.popups.modules.events.BBCardEvent):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showBaseballCard");
			//l__2.popupRef.hide();
			ppbbView.visible = false;
			var l__3:com.script.poker.PokerUser = tControl.ptModel.getUserByZid(p__1.sZid);
			pControl.onQueryGifts2(l__3.nSit);
		}		
		private function onGiftMenu(p__1:com.script.poker.popups.modules.events.BBCardEvent):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showBaseballCard");
			//l__2.popupRef.hide();
			ppbbView.visible = false;
			showDrinkMenu(p__1.sZid);
		}
		public function onGiftMenux(p__1:Object):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showBaseballCard");
			//l__2.popupRef.hide();
			ppbbView.visible = false;
			showDrinkMenu(p__1.sZid);
		}
		public function onEmoMenu(p__1:Object):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showBaseballCard");
			//l__2.popupRef.hide();
			showEmoMenu(p__1.sZid);
		}
		
		private function showProfile(param1:Object, param2:int = 0, param3:Array = null) : void
        {
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_8:Boolean = false;
            var _loc_9:Boolean = false;
            var _loc_10:Number = NaN;
            var _loc_11:Boolean = false;
            //arguments = getPopupByID(Popup.PROFILE, true, arguments.callee, arguments);
            
			if (pppfView != null)
            {
				
                this._profileLock = true;
                if (param1 == null || !param1["zid"])
                {
                    _loc_6 = pgData.zid;
                    _loc_7 = pgData.name;
                }
                else
                {
                    _loc_6 = param1["zid"];
                    _loc_7 = param1["playerName"];
                }
                _loc_8 = tControl.isMe(_loc_6);
                //_loc_9 = pgData.isFriend(_loc_6);
                _loc_10 = Number((_loc_6 as String).split(":")[0]);
                //_loc_11 = _loc_10 != pgData.SN_FACEBOOK ? (true) : (false);
                if (param3 == null)
                {
                    param3 = [];
                }
                if (!_loc_8)
                {
                    param3.push(1);
                }
                /*if (!pControl.connected)
                {
                    param3.push(ProfilePanelTab.COLLECTIONS);
                }*/
                pppfView.initialize(param3);
                /*if (_loc_8)
                {
                    pppfView.setNewCollectionItemCount(pgData.newCollectionItemCount);
                }
                else
                {
                    pppfView.setNewCollectionItemCount(0);
                }*/
                pppfView.rootURL = pgData.sRootURL;
                pppfView.zid = _loc_6;
                pppfView.playerName = _loc_7;
                pppfView.isOwnProfile = _loc_8;
                pppfView.isFriend = _loc_9;
                //pppfView.isNonFacebook = _loc_11;
                pppfView.pic = pgData.pic_lrg_url;
                pppfView.shownGiftID = pgData.shownGiftID;
                //pppfView.fbSig = pgData.getFBSig();
                //pppfView.hasViewedOwnCollectionsTab = false;
                //pppfView.firstTimeCollections = pgData.firstTimeCollections;
                //pppfView.container.addEventListener(PPVEvent.CLOSE, onProfileClose);
                //arguments.module.addEventListener(ProfileEvent.SEND_CHIPS_CLICK, this.onProfileSendChipsClick);
                pppfView.addEventListener(ProfileEvent.CASINO_SHOP_CLICK, this.onProfileCasinoShopClick);
                //arguments.module.addEventListener(ProfileEvent.CLAIM_COLLECTION, this.onProfileClaimCollection);
                pppfView.addEventListener(ProfileEvent.DISPLAY_TAB, this.onProfileDisplayTab);
                pppfView.addEventListener(ProfileEvent.ITEM_SELECTED, this.onProfileItemSelected);
                pppfView.addEventListener(ProfileEvent.ITEM_CANCELED, this.onProfileItemCanceled);
                //arguments.module.addEventListener(ProfileEvent.SKIP, this.onProfileSkip);
                //arguments.module.addEventListener(ProfileEvent.TRADE_COLLECTION_ITEM, this.onProfileTradeCollectionItem);
                //arguments.module.addEventListener(ProfileEvent.WISHLIST_COLLECTION_ITEM, this.onProfileWishlistCollectionItem);
                /*if (param2 == ProfilePanelTab.OVERVIEW && (Security.sandboxType == Security.LOCAL_WITH_FILE || Security.sandboxType == Security.LOCAL_TRUSTED))
                {
                    param2 = ProfilePanelTab.ACHIEVEMENTS;
                }*/
				ppView.x=0;
				ppView.y=0;
                pppfView.displayTabFromIndex(param2);
                pppfView.x = 66;
                pppfView.y = 20;
				pppfView.visible = true;
				
				initEmoMove(pppfView)
				
                //arguments.container.show(true);
                /*if (_loc_8)
                {
                    pControl.navControl.setSidebarItemsSelected("Profile");
                }
                else
                {
                    pControl.navControl.setSidebarItemsDeselected("Profile");
                }*/
            }
            return;
        }
		
		private function onProfile(p__1:com.script.poker.popups.modules.events.BBCardEvent):void
		{
			var l__3:String;
			var l__4:com.script.io.LoadUrlVars;
			var l__2:String = p__1.sZid;
			if (l__2){
				l__3 = tControl.getProfileURL(l__2);
				if (l__3){
					l__4 = new LoadUrlVars();
					l__4.navigateURL(l__3, "_blank");
				}
			}
		}
		private function onProfileItemSelected(event:com.script.poker.popups.modules.events.ProfileEvent) : void
        {
            /*var _loc_2:* = getPopupByID(Popup.PROFILE);
            if (_loc_2 != null)
            {
                _loc_2.container.hide();
            }*/
			initEmoRemove(pppfView)
			pppfView.visible = false;
            pControl.onShowGift3(event.params["itemSelectedGiftId"]);
            return;
        }// end function
		 private function onProfileCasinoShopClick(event:com.script.poker.popups.modules.events.ProfileEvent) : void
        {
           /* var _loc_2:* = getPopupByID(Popup.PROFILE);
            if (_loc_2 != null)
            {
                _loc_2.container.hide();
            }*/
			initEmoRemove(pppfView)
			pppfView.visible = false;
			showDrinkMenu(pgData.zid);
           // this.nControl.displayGiftShop();
            //PokerStatsManager.DoHitForStat(STATHIT_PUC_GIFTSHOPICONCLICKPROFILE);
            return;
        }
		private function onProfileItemCanceled(event:com.script.poker.popups.modules.events.ProfileEvent) : void
        {
			initEmoRemove(pppfView)
            pppfView.visible = false;
            return;
        }// end function
		private function onProfileDisplayTab(event:com.script.poker.popups.modules.events.ProfileEvent) : void
        {
            var _loc_3:String = null;
            //var _loc_2:* = getPopupByID(Popup.PROFILE);
			var _loc_2:* = pppfView;
            if (_loc_2 != null)
            {
                if (event.params != null && event.params.hasOwnProperty("tab"))
                {
                    switch(event.params["tab"])
                    {
                        case 2:
                        {
                            break;
                        }
                        case 3:
                        {
                            _loc_3 = _loc_2.module.isFriend ? (_loc_2.module.zid) : ("");
                            this.pControl.getCollectionsInfo(_loc_3);
                            if (_loc_2.module.isOwnProfile)
                            {
                                _loc_2.module.hasViewedOwnCollectionsTab = true;
                            }
                            PokerStatsManager.DoHitForStat(STATHIT_PUC_PROFILEIMPRESSION_COLLECTIONTAB);
                            break;
                        }
                        case 1:
                        {
							
                            //this.pControl.onQueryGifts2(-1);
                            break;
                        }
                        case 0:
                        {
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    /*if (_loc_2.module.isOwnProfile && _loc_2.module.hasViewedOwnCollectionsTab && event.params["tab"] != 3)
                    {
                        _loc_2.module.hasViewedOwnCollectionsTab = false;
                        pControl.resetNewCollectionItemCount();
                    }*/
                }
            }
            return;
        }// end function

		private function onShowVip(p__1:com.script.poker.popups.modules.events.BBCardEvent):void
		{
			pControl.onShowVip(p__1.bShowVip);
		}
		private function onMuteUser(p__1:com.script.poker.popups.modules.events.BBCardEvent):void
		{
			if (p__1.bMuteUser){
				tControl.ptModel.muteToggle(p__1.sZid, "add");
			} else {
				tControl.ptModel.muteToggle(p__1.sZid, "remove");
			}
		}
		private function onDone(p__1:com.script.poker.popups.modules.events.BBCardEvent):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showBaseballCard");
			//l__2.popupRef.hide();
			ppbbView.visible = false;
			
			return;
		}
		private function onFeedCheck(p__1:com.script.poker.popups.modules.events.BBCardEvent):void
		{
			pgData.bFbFeedOptin = !pgData.bFbFeedOptin;
		}
		private function showReportUser(p__1:String):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showReportUser");
			var l__3:com.script.poker.PokerUser = tControl.ptModel.getUserByZid(p__1);
			l__2.popupRef.titleText = StringUtility.FormatString(pgData.config["reportuser"]["title"], {sText:"%userName%", nVar:l__3.sUserName});
			if (!bReportUserInitialized){
				initReportUser(l__2);
			}
			l__2.moduleRef.sZid = p__1;
			l__2.popupRef.show(true);
			l__2.moduleRef.setFieldFocus();
		}
		private function initReportUser(p__1:com.script.poker.popups.Popup):void
		{
			p__1.moduleRef.addEventListener(RUEvent.REPORTUSER, onReportUser);
			p__1.moduleRef.addEventListener(RUEvent.CANCEL, onReportUserCancel);
			bReportUserInitialized = true;
		}
		private function onReportUser(p__1:com.script.poker.popups.modules.events.RUEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showReportUser");
			l__2.popupRef.hide();
			pControl.onAbuse(pgData.zid, p__1.sZid, pgData.name);
			var l__3:com.script.poker.PokerUser = tControl.ptModel.getUserByZid(p__1.sZid);
			var l__4:Object = new Object();
			l__4.uid_reporter = pgData.zid;
			l__4.uid_abuser = p__1.sZid;
			l__4.room_id = pgData.gameRoomId;
			l__4.hand_id = tControl.ptModel.nHandId;
			l__4.reason = p__1.reason;
			var l__5:com.script.io.LoadUrlVars = new LoadUrlVars();
			l__5.loadURL(pgData.report_url, l__4, "POST");
		}
		private function onReportUserCancel(p__1:com.script.poker.popups.modules.events.RUEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showReportUser");
			l__2.popupRef.hide();
		}
		private function showDrinkMenu(p__1:String):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showDrinkMenu");
			var l__3:com.script.poker.PokerUser = tControl.ptModel.getUserByZid(p__1);
			//l__2.moduleRef.sZid = l__3.zid;
			//l__2.moduleRef.sViewerZid = tControl.ptModel.viewer.zid;
			//l__2.moduleRef.bIsOwner = tControl.isMe(l__3.zid);
			//l__2.moduleRef.icon = l__3.sPicLrgURL;
			ppgfView.sZid = l__3.zid;
			ppgfView.sViewerZid = tControl.ptModel.viewer.zid;
			ppgfView.bIsOwner = tControl.isMe(l__3.zid);
			ppgfView.icon = l__3.sPicLrgURL;
			
			var l__4:Array = GiftLibrary.GetInst().GetCategoryOrder();
			ppgfView.populate(l__4, tControl.getPlayerChips(true), tControl.ptModel.aUsers);
			//l__2.popupRef.titleText = StringUtility.FormatString(pgData.config["dsgpanel"]["purchase_title"], {sText:"%userName%", nVar:l__3.sUserName});
			/*if ((pgData.sn_id == pgData.SN_FACEBOOK) && pgData.bFbFeedAllow){
				l__2.moduleRef.feedCheck.visible = true;
				l__2.moduleRef.showCheck();
				pgData.bFbFeedOptin = true;
			} else {
				l__2.moduleRef.feedCheck.visible = false;
			}*/
			
			if (!bDrinkMenuInitialized){
				initDrinkMenu(ppgfView);
			}
			initEmoMove(ppgfView)
			ppView.x=0;
			ppView.y=0;
			ppgfView.visible = true;
			//l__2.popupRef.show(true);
		}
		private function showEmoMenu(p__1:String):void
		{			
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showDrinkMenu");
			var l__3:com.script.poker.PokerUser = tControl.ptModel.getUserByZid(p__1);
			
			ppemView.sZid = l__3.zid;
			ppemView.sViewerZid = tControl.ptModel.viewer.zid;
			ppemView.bIsOwner = tControl.isMe(l__3.zid);
			//ppemView.icon = l__3.sPicLrgURL;
			
			//l__2.moduleRef.sZid = l__3.zid;
			//l__2.moduleRef.sViewerZid = tControl.ptModel.viewer.zid;
			//l__2.moduleRef.bIsOwner = tControl.isMe(l__3.zid);
			//l__2.moduleRef.icon = l__3.sPicLrgURL;
			var l__4:Array = EmoLibrary.GetInst().GetCategoryOrder();
			ppemView.populate(l__4, tControl.getPlayerChips(true), tControl.ptModel.aUsers);
			//ppemView.titleText = StringUtility.FormatString("Emoticons", {sText:"%userName%", nVar:l__3.sUserName});
			
			//l__2.moduleRef.populate(l__4, tControl.getPlayerChips(true), tControl.ptModel.aUsers);
			//l__2.popupRef.titleText = StringUtility.FormatString(pgData.config["dsgpanel"]["purchase_title"], {sText:"%userName%", nVar:l__3.sUserName});
			
				//ppemView.feedCheck.visible = false;
			
			if (!bEmoMenuInitialized){
				initEmoMenu(ppemView);
			}
			initEmoMove(ppemView)
			ppView.x=0;
			ppView.y=0;
			ppemView.visible = true;
			//l__2.popupRef.show(true);
		}
		public function refreshEmoTab():void
		{
			ppemView.populate_current_tab();
			//var l__1:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showDrinkMenu");
			//if (l__1 != null){
				//l__1.moduleRef.populate_current_tab();
			//}
		}
		public function refreshDrinksTab():void
		{
			ppgfView.populate_current_tab();
			//var l__1:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showDrinkMenu");
			//if (l__1 != null){
				//l__1.moduleRef.populate_current_tab();
			//}
		}
		
		private function initEmoMenu(p__1):void
		{
			p__1.addEventListener(EmoEvent.BUYEMO, onBuyEmo);
			//p__1.moduleRef.addEventListener(DSGEvent.BUYFORTABLE, onBuyForTable);
			p__1.addEventListener(EmoEvent.CANCEL, onCancelEmo);
			p__1.addEventListener(EmoEvent.DISPLAY_SELECTED, onDisplayEmoSelected);
			p__1.addEventListener(EmoEvent.REFRESH_CATEGORY, onRefreshEmoCategory);
			p__1.addEventListener(EmoEvent.DISPLAY_NONE, onDisplayEmoNone);
			p__1.addEventListener(EmoEvent.DSG_UPDATE, onEmoUpdate);
			
			//p__1.moduleRef.addEventListener(EmoEvent.FEED_CHECK, onDrinkFeedCheck);
			bEmoMenuInitialized = true;
		}
		private function initEmoMove(p__1):void
		{
			
			mainDisp.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, onEmoDrag);
			mainDisp.addEventListener(flash.events.MouseEvent.MOUSE_UP, onEmoStop);
			
		}
		private function initEmoRemove(p__1):void
		{
			
			mainDisp.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, onEmoDrag);
			mainDisp.removeEventListener(flash.events.MouseEvent.MOUSE_UP, onEmoStop);
			
			
		}
		
		private function initDrinkMenu(p__1):void
		{
			p__1.addEventListener(DSGEvent.BUYGIFT, onBuyGift);
			p__1.addEventListener(DSGEvent.BUYFORTABLE, onBuyForTable);
			p__1.addEventListener(DSGEvent.CANCEL, onCancelGift);
			p__1.addEventListener(DSGEvent.DISPLAY_SELECTED, onDisplaySelected);
			p__1.addEventListener(DSGEvent.REFRESH_CATEGORY, onRefreshCategory);
			p__1.addEventListener(DSGEvent.DISPLAY_NONE, onDisplayNone);
			p__1.addEventListener(DSGEvent.DSG_UPDATE, onDrinkUpdate);
			p__1.addEventListener(DSGEvent.FEED_CHECK, onDrinkFeedCheck);
			bDrinkMenuInitialized = true;
		}
		private function onBuyGift(p__1:com.script.poker.popups.modules.events.DSGBuyEvent):void
		{
			/*var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showDrinkMenu");
			if (l__2 != null){
				l__2.popupRef.hide();
			}
			tControl.onBuyDrinksPressed();
			pControl.onBuyGift2(p__1.nGiftCat, p__1.nGiftId, p__1.sZid);
			fireFBFeedGiftSingle(p__1.nGiftCat, p__1.nGiftId, p__1.sZid);
			var l__3:com.script.poker.lobby.RoomItem = pgData.getRoomById(pgData.gameRoomId);
			if (l__3.tableType == "Private"){
				if (pgData.sn_id == pgData.SN_FACEBOOK){
					pControl.TrackingHit("giftsentprivate", 4, 17, 2010, 1, "gift sent private", "http://nav3.script.com/link/link.php?item=Poker%20FB%20Table%20Other%20Sent%3ALiveGift%20o%3A%20privatetable%3A2009-04-17&ltsig=7c991d05a54f8f4647c57ec42d1cdcc7");
				}
			} else if (pgData.dispMode == "challenge"){
				if (pgData.sn_id == pgData.SN_FACEBOOK){
					pControl.TrackingHit("giftsentchallenge", 4, 17, 2010, 1, "gift sent challenge", "http://nav3.script.com/link/link.php?item=Poker%20FB%20Table%20Other%20Sent%3ALiveGift%20o%3A%20pointstable%3A2009-04-17&ltsig=9a3f45c4fd2f3ad3af68c922f9be5a6a");
				}
			}*/
			initEmoRemove(ppgfView)
			ppgfView.visible = false;
			tControl.onBuyDrinksPressed();
			var l__3:com.script.poker.PokerUser = tControl.ptModel.getUserByZid(p__1.sZid);
			pControl.onBuyGift2(p__1.nGiftCat, p__1.nGiftId, p__1.sZid, l__3.nSit);
			//pControl.onBuyEmo(p__1.nEmoCat, p__1.nEmoId, p__1.sZid, l__3.nSit, p__1.nEmoStr);
			
		}
		private function onBuyForTable(p__1:com.script.poker.popups.modules.events.DSGBuyEvent):void
		{
			initEmoRemove(ppgfView)
			ppgfView.visible = false;
			tControl.onBuyDrinksPressed(true);
			pControl.onBuyGift2(p__1.nGiftCat, p__1.nGiftId, "all", 0);
			/*var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showDrinkMenu");
			if (l__2 != null){
				l__2.popupRef.hide();
			}
			tControl.onBuyDrinksPressed(true);
			pControl.onBuyGift2(p__1.nGiftCat, p__1.nGiftId, "all");
			fireFBFeedGiftTable(p__1.nGiftCat, p__1.nGiftId);
			var l__3:com.script.poker.lobby.RoomItem = pgData.getRoomById(pgData.gameRoomId);
			if (l__3.tableType == "Private"){
				if (pgData.sn_id == pgData.SN_FACEBOOK){
					pControl.TrackingHit("giftsentprivate", 4, 17, 2010, 1, "gift sent private", "http://nav3.script.com/link/link.php?item=Poker%20FB%20Table%20Other%20Sent%3ALiveGift%20o%3A%20privatetable%3A2009-04-17&ltsig=7c991d05a54f8f4647c57ec42d1cdcc7");
				}
			} else if (pgData.dispMode == "challenge"){
				if (pgData.sn_id == pgData.SN_FACEBOOK){
					pControl.TrackingHit("giftsentchallenge", 4, 17, 2010, 1, "gift sent challenge", "http://nav3.script.com/link/link.php?item=Poker%20FB%20Table%20Other%20Sent%3ALiveGift%20o%3A%20pointstable%3A2009-04-17&ltsig=9a3f45c4fd2f3ad3af68c922f9be5a6a");
				}
			}*/
		}
		private function fireFBFeedGiftSingle(inGiftCat:Number, inGiftId:Number, inZid:String):void
		{
			var passGiftCat:Number = 0;
			var passZid:String;
			var oneLine:String;
			var feedPause:flash.utils.Timer;
			passGiftCat = inGiftCat;
			passZid = inZid;
			if (pgData.bFbFeedAllow && !(passZid == pgData.zid)){
				var spawnFeed = function(p__1:flash.events.TimerEvent):void
				{
					feedPause.stop();
					feedPause = null;
					if (passGiftCat == 1){
						pgData.JSCall_BaseballCardFeed(pgData.kJS_BASEBALLCARDFEED_BUYINDVDRINK, inGiftId, passZid, oneLine);
					}
					if (passGiftCat > 1){
						pgData.JSCall_BaseballCardFeed(pgData.kJS_BASEBALLCARDFEED_BUYINDVGIFT, inGiftId, passZid, oneLine);
					}
				};
				pgData.bFbFeedAllow = false;
				oneLine = "0";
				if (pgData.bFbFeedOptin){
					oneLine = "1";
				}
				feedPause = new Timer(1500, 0);
				feedPause.addEventListener(TimerEvent.TIMER, spawnFeed);
				feedPause.start();
			}
		}
		private function fireFBFeedGiftTable(inGiftCat:Number, inGiftId:Number):void
		{
			var passGiftCat:Number = 0;
			var oneLine:String;
			var feedPause:flash.utils.Timer;
			passGiftCat = inGiftCat;
			if (pgData.bFbFeedAllow){
				var spawnFeed = function(p__1:flash.events.TimerEvent):void
				{
					feedPause.stop();
					feedPause = null;
					if (passGiftCat == 1){
						pgData.JSCall_BaseballCardFeed(pgData.kJS_BASEBALLCARDFEED_BUYTABLEDRINKS, inGiftId, "", oneLine);
					}
					if (passGiftCat > 1){
						pgData.JSCall_BaseballCardFeed(pgData.kJS_BASEBALLCARDFEED_BUYTABLEGIFTS, inGiftId, "", oneLine);
					}
				};
				pgData.bFbFeedAllow = false;
				oneLine = "0";
				if (pgData.bFbFeedOptin){
					oneLine = "1";
				}
				feedPause = new Timer(1500, 0);
				feedPause.addEventListener(TimerEvent.TIMER, spawnFeed);
				feedPause.start();
			}
		}
		private function onDisplaySelected(p__1:com.script.poker.popups.modules.events.DSGBuyEvent):void
		{
			
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showDrinkMenu");
			if (l__2 != null){
				l__2.popupRef.hide();
			}
			pControl.onShowGift(p__1.nGiftId);
		}
		private function onRefreshCategory(p__1:com.script.poker.popups.modules.events.DSGEvent):void
		{
			pControl.getGiftPrices2(p__1.nCatIndex, p__1.sZid);
		}
		private function onDisplayNone(p__1:com.script.poker.popups.modules.events.DSGBuyEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showDrinkMenu");
			if (l__2 != null){
				l__2.popupRef.hide();
			}
			pControl.onShowGift(-1);
		}
		private function onDrinkUpdate(p__1:com.script.poker.popups.modules.events.DSGEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showDrinkMenu");
			if (l__2 != null){
				l__2.moduleRef.pokerUsers = tControl.ptModel.aUsers;
			}
		}
		private function onCancelGift(p__1:com.script.poker.popups.modules.events.DSGEvent):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showDrinkMenu");
			//if (l__2 != null){
				//l__2.popupRef.hide();
			//}
			initEmoRemove(ppgfView)
			ppgfView.visible = false;
		}
		private function onDrinkFeedCheck(p__1:com.script.poker.popups.modules.events.DSGEvent):void
		{
			pgData.bFbFeedOptin = !pgData.bFbFeedOptin;
		}
		private function onCloseGift(p__1:com.script.display.Dialog.DialogEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showDrinkMenu");
			if (l__2 != null){
				if (l__2.moduleRef == p__1.data.module){
					l__2.moduleRef.clear_all_tabs();
				}
			}
			DialogEvent.disp.removeEventListener(DialogEvent.CLOSED, onCloseGift);
		}
		private function updateDrinkMenu(p__1:com.script.poker.popups.Popup, p__2:com.script.poker.events.PopupEvent):void
		{
		}
		private function updateDrinkMenu2(p__1:com.script.poker.popups.Popup, p__2:com.script.poker.events.PopupEvent):void
		{
			var l__10:Object;
			var l__11:com.script.poker.table.GiftItem;
			var l__3:com.script.poker.events.GiftPopupEvent = GiftPopupEvent(p__2);
			var l__4:com.script.poker.PokerUser = tControl.ptModel.getUserBySit(l__3.sit);
			p__1.moduleRef.sZid = l__4.zid;
			p__1.moduleRef.bIsOwner = tControl.isMe(l__4.zid);
			p__1.moduleRef.icon = l__4.sPicLrgURL;
			var l__5:int = l__3.sit;
			var l__6:Array = l__3.gifts;
			var l__7:Array = new Array();
			var l__8:Array = new Array();
			var l__9:int;
			while(l__9 < l__6.length){
				l__10 = l__6[l__9];
				l__11 = GiftLibrary.GetInst().GetGift(l__10.giftId);
				if (l__11 != null){
					if (tControl.isViewerAllowedToSeeGiftId(l__10.giftId)){
						l__7.push(l__11.mnId);
						l__8.push(l__10.name);
					}
				}
				l__9++;
			}
			if (tControl.isMe(l__4.zid)){
				
				p__1.popupRef.titleText = pgData.config["dsgpanel"]["select_title"];
				p__1.moduleRef.populate(l__7, 0, tControl.ptModel.aUsers, l__8, DSGEvent.PANELMODE_SELECT);
			} else {
				p__1.popupRef.titleText = StringUtility.FormatString(pgData.config["dsgpanel"]["display_title"], {sText:"%userName%", nVar:l__4.sUserName.substr(0, l__4.sUserName.indexOf(" ", 0))});
				p__1.moduleRef.populate(l__7, 0, tControl.ptModel.aUsers, l__8, DSGEvent.PANELMODE_DISPLAY);
			}
			p__1.moduleRef.feedCheck.visible = false;
			if (!bDrinkMenuInitialized){
				initDrinkMenu(p__1);
			}
			DialogEvent.disp.addEventListener(DialogEvent.CLOSED, onCloseGift);
			p__1.popupRef.show(true);
		}
		
		private function onBuyEmo(p__1:com.script.poker.popups.modules.events.EmoBuyEvent):void
		{
			/*var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showDrinkMenu");
			if (l__2 != null){
				l__2.popupRef.hide();
			}*/
			initEmoRemove(ppemView)
			ppemView.visible = false;
			tControl.onBuyEmoPressed();
			var l__3:com.script.poker.PokerUser = tControl.ptModel.getUserByZid(p__1.sZid);
			
			pControl.onBuyEmo(p__1.nEmoCat, p__1.nEmoId, p__1.sZid, l__3.nSit, p__1.nEmoStr);
			//fireFBFeedGiftSingle(p__1.nGiftCat, p__1.nGiftId, p__1.sZid);
			//var l__3:com.script.poker.lobby.RoomItem = pgData.getRoomById(pgData.gameRoomId);
			/*if (l__3.tableType == "Private"){
				if (pgData.sn_id == pgData.SN_FACEBOOK){
					pControl.TrackingHit("giftsentprivate", 4, 17, 2010, 1, "gift sent private", "http://nav3.script.com/link/link.php?item=Poker%20FB%20Table%20Other%20Sent%3ALiveGift%20o%3A%20privatetable%3A2009-04-17&ltsig=7c991d05a54f8f4647c57ec42d1cdcc7");
				}
			} else if (pgData.dispMode == "challenge"){
				if (pgData.sn_id == pgData.SN_FACEBOOK){
					pControl.TrackingHit("giftsentchallenge", 4, 17, 2010, 1, "gift sent challenge", "http://nav3.script.com/link/link.php?item=Poker%20FB%20Table%20Other%20Sent%3ALiveGift%20o%3A%20pointstable%3A2009-04-17&ltsig=9a3f45c4fd2f3ad3af68c922f9be5a6a");
				}
			}*/
		}
		
		private function onDisplayEmoSelected(p__1:com.script.poker.popups.modules.events.EmoBuyEvent):void
		{
			
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showEmoMenu");
			if (l__2 != null){
				l__2.popupRef.hide();
			}
			pControl.onShowEmo(p__1.nEmoId);
		}
		private function onRefreshEmoCategory(p__1:com.script.poker.popups.modules.events.EmoEvent):void
		{
			pControl.getEmoPrices(p__1.nCatIndex, p__1.sZid);
		}
		private function onDisplayEmoNone(p__1:com.script.poker.popups.modules.events.EmoBuyEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showEmoMenu");
			if (l__2 != null){
				l__2.popupRef.hide();
			}
			pControl.onShowEmo(-1);
		}
		private function onEmoDrag(p__1:flash.events.MouseEvent):void
		{
			moveX = p__1.stageX - ppView.x
			moveY = p__1.stageY - ppView.y 
			
			mainDisp.addEventListener(MouseEvent.MOUSE_MOVE, onEmoMove)
			
		}
		private function onEmoMove(p__1:flash.events.MouseEvent):void
		{
			ppView.x = p__1.stageX - moveX;
    		ppView.y = p__1.stageY - moveY;
			
		}
		private function onEmoStop(p__1:flash.events.MouseEvent):void
		{
			//mainDisp.removeEventListener(MouseEvent.MOUSE_DOWN, onEmoDrag)
			mainDisp.removeEventListener(MouseEvent.MOUSE_MOVE, onEmoMove)
			//mainDisp.removeEventListener(MouseEvent.MOUSE_UP, onEmoStop)
			
		}
		private function onEmoUpdate(p__1:com.script.poker.popups.modules.events.EmoEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showEmoMenu");
			if (l__2 != null){
				l__2.moduleRef.pokerUsers = tControl.ptModel.aUsers;
			}
		}
		private function onCancelEmo(p__1:com.script.poker.popups.modules.events.EmoEvent):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showEmoMenu");
			//if (l__2 != null){
				//l__2.popupRef.hide();
			//}
			initEmoRemove(ppemView)
			ppemView.visible = false;
			
		}
		private function onCloseEmo(p__1:com.script.display.Dialog.DialogEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showEmoMenu");
			if (l__2 != null){
				if (l__2.moduleRef == p__1.data.module){
					l__2.moduleRef.clear_all_tabs();
				}
			}
			DialogEvent.disp.removeEventListener(DialogEvent.CLOSED, onCloseGift);
		}
		private function updateEmoMenu(p__1:Object):void
		{
		
			var l__10:Object;
			var l__11:com.script.poker.table.EmoItem;
			//var l__3:com.script.poker.events.EmoPopupEvent = EmoPopupEvent(p__1);
			var l__4:com.script.poker.PokerUser = tControl.ptModel.getUserBySit(p__1.sit);
			//p__1.moduleRef.sZid = l__4.zid;
			//p__1.moduleRef.bIsOwner = tControl.isMe(l__4.zid);
			ppemView.sZid = l__4.zid;
			ppemView.bIsOwner = tControl.isMe(l__4.zid);
			//p__1.moduleRef.icon = l__4.sPicLrgURL;
			var l__5:int = p__1.sit;
			var l__6:Array = p__1.emoticons;
			var l__7:Array = new Array();
			var l__8:Array = new Array();
			var l__9:int;
			while(l__9 < l__6.length){
				l__10 = l__6[l__9];
				l__11 = EmoLibrary.GetInst().GetEmo(l__10.emoId);
				if (l__11 != null){
					if (tControl.isViewerAllowedToSeeEmoId(l__10.emoId)){
						l__7.push(l__11.mnId);
						l__8.push(l__10.name);
					}
				}
				l__9++;
			}
			if (tControl.isMe(l__4.zid)){
				
				ppemView.titleText = pgData.config["dsgpanel"]["select_title"];
				ppemView.populate(l__7, 0, tControl.ptModel.aUsers, l__8, DSGEvent.PANELMODE_SELECT);
			} else {
				ppemView.titleText = StringUtility.FormatString(pgData.config["dsgpanel"]["display_title"], {sText:"%userName%", nVar:l__4.sUserName.substr(0, l__4.sUserName.indexOf(" ", 0))});
				ppemView.populate(l__7, 0, tControl.ptModel.aUsers, l__8, DSGEvent.PANELMODE_DISPLAY);
			}
			ppemView.feedCheck.visible = false;
			
			/*if (!bDrinkMenuInitialized){
				initDrinkMenu(p__1);
			}*/
			DialogEvent.disp.addEventListener(DialogEvent.CLOSED, onCloseGift);
			//p__1.popupRef.show(true);
			ppemView.visible = true;
		}
		private function updateBuddyDialog(p__1:Object):void
		{
			//p__1.moduleRef.populate(pgData.aBuddyInvites);
			ppbdView.populate(pgData.aBuddyInvites);
			if (!bBuddyDialogInitialized){ 
				initBuddyDialog(ppbdView);
			}
			//p__1.popupRef.show(true);
			ppbdView.visible = true;
		}
		private function initBuddyDialog(p__1:Object):void
		{
			ppbdView.addEventListener(BDEvent.BUDDY_ACCEPTALL, onBuddyAcceptAll);
			ppbdView.addEventListener(BDEvent.BUDDY_DENYALL, onBuddyDenyAll);
			ppbdView.addEventListener(BDEvent.BUDDY_IGNOREALL, onBuddyIgnoreAll);
			ppbdView.addEventListener(BDEvent.BUDDY_DONE, onBuddyDone);
			bBuddyDialogInitialized = true;
		}
		private function onBuddyAcceptAll(p__1:com.script.poker.popups.modules.events.BDEvent):void
		{
			var l__5:Object;
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showBuddyDialog");
			//l__2.popupRef.hide();
			ppbdView.visible = false
			var l__3:Array = p__1.aApproved;
			var l__4:int;
			while(l__4 < l__3.length){
				l__5 = Object(l__3[l__4]);
				pControl.onAcceptBuddy(l__5.zid, l__5.name);
				pgData.removeBuddyInvite(l__5.zid);
				l__4++;
			}
			tControl.updateInbox();
		}
		private function onBuddyDenyAll(p__1:com.script.poker.popups.modules.events.BDEvent):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showBuddyDialog");
			//l__2.popupRef.hide();
			ppbdView.visible = false
			var l__3:Array = p__1.aDenied;
			var l__4:int;
			while(l__4 < l__3.length){
				pControl.onIgnoreBuddy(l__3[l__4]);
				pgData.removeBuddyInvite(l__3[l__4]);
				l__4++;
			}
			tControl.updateInbox();
		}
		private function onBuddyIgnoreAll(p__1:com.script.poker.popups.modules.events.BDEvent):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showBuddyDialog");
			//l__2.popupRef.hide();
			ppbdView.visible = false
			pControl.onIgnoreAllBuddy();
			pgData.removeAllBuddyInvites();
			tControl.updateInbox();
		}
		private function onBuddyDone(p__1:com.script.poker.popups.modules.events.BDEvent):void
		{
			var l__6:Object;
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showBuddyDialog");
			//l__2.popupRef.hide();
			ppbdView.visible = false;
			var l__3:Array = p__1.aApproved;
			var l__4:Array = p__1.aDenied;
			var l__5:int;
			l__5 = 0;
			while(l__5 < l__3.length){
				l__6 = Object(l__3[l__5]);
				pControl.onAcceptBuddy(l__6.zid, l__6.name);
				pgData.removeBuddyInvite(l__6.zid);
				l__5++;
			}
			l__5 = 0;
			while(l__5 < l__4.length){
				pControl.onIgnoreBuddy(l__4[l__5]);
				pgData.removeBuddyInvite(l__4[l__5]);
				l__5++;
			}
			tControl.updateInbox();
		}
		private function showTourneyPopup(p__1:com.script.poker.popups.Popup, p__2:com.script.poker.events.PopupEvent):void
		{
			var l__3:com.script.poker.events.MSTourneyPopupEvent = MSTourneyPopupEvent(p__2);
			p__1.moduleRef.bonus = l__3.nBonus;
			p__1.moduleRef.when = l__3.sWhen;
			p__1.moduleRef.username = l__3.sInviteName;
			p__1.moduleRef.url = l__3.sTokenUrl;
			switch(l__3.sFrame){
				case MSTourneyPopupEvent.CLAIM_SEAT:
				{
					p__1.moduleRef.frame = MSTourneyPopupEvent.CLAIM_SEAT;
					p__1.moduleRef.setMode("ClaimSeat");
					break;
				}
				case MSTourneyPopupEvent.CLAIM_TOKEN:
				{
					p__1.moduleRef.frame = MSTourneyPopupEvent.CLAIM_TOKEN;
					p__1.moduleRef.setMode("ClaimToken");
					break;
				}
				case MSTourneyPopupEvent.PLAY_NOW:
				{
					p__1.moduleRef.frame = MSTourneyPopupEvent.PLAY_NOW;
					p__1.moduleRef.setMode("PlayNow");
					break;
				}
			}
			p__1.moduleRef.addEventListener(TPEvent.CLAIM_SEAT, onClaimPlay);
			p__1.moduleRef.addEventListener(TPEvent.CLAIM_TOKEN, onClaimPlay);
			p__1.moduleRef.addEventListener(TPEvent.PLAY_WEEKLY_TOURNAMENT, onClaimPlay);
			p__1.popupRef.show(true);
		}
		private function onClaimPlay(p__1:com.script.poker.popups.modules.events.TPEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showTourneyPopup");
			l__2.popupRef.removeEventListener(TPEvent.CLAIM_SEAT, onClaimPlay);
			l__2.popupRef.removeEventListener(TPEvent.CLAIM_TOKEN, onClaimPlay);
			l__2.popupRef.removeEventListener(TPEvent.PLAY_WEEKLY_TOURNAMENT, onClaimPlay);
			l__2.popupRef.hide();
			switch(p__1.frame){
				case MSTourneyPopupEvent.CLAIM_SEAT:
				{
					pControl.claimTourneySeat();
					break;
				}
				case MSTourneyPopupEvent.CLAIM_TOKEN:
				{
					pControl.claimTourneyToken();
					break;
				}
				case MSTourneyPopupEvent.PLAY_NOW:
				{
					pControl.playWeeklyTourney();
					break;
				}
			}
		}
		private function updateCreateTable(p__1):void
		{
			var l__2:Array = pgData.name.split(" ");
			/*
			p__1.moduleRef.tablename = (l__2[0] + "\'s Table");
			p__1.moduleRef.max = 9;
			p__1.moduleRef.small = 1;
			p__1.moduleRef.large = 2;
			p__1.popupRef.addEventListener("PRIVATE_TABLE_YES", onPrivateTableSubmit);
			p__1.popupRef.show(true);
			p__1.moduleRef.setPassFocus();
			*/
			ppctView.tablename = (l__2[0] + " Table");
			ppctView.max = 9;
			ppctView.small = 1;
			ppctView.large = 2;
			ppctView.costMsg = pgData.tableCost;
			//ppctView.addEventListener("PRIVATE_TABLE_YES", onPrivateTableSubmit);
			//dispatchEvent(new TBEvent(TBEvent.PRIVATE_TABLE_YES, _sit, Number(field.text)));
			//p__1.popupRef.show(true);
			ppctView.addEventListener(PPVEvent.PRIVATE_TABLE_YES, onPrivateTableSubmit);
			ppctView.addEventListener(PPVEvent.PRIVATE_TABLE_NO, onPrivateTableCancel);
			//ppctView.selCost.addEventListener(Event.CHANGE, showCost);
			
			ppctView.setPassFocus();
			ppctView.visible = true;
			ppctView.x = 100;
			ppctView.y = 100;
			
		}
		/*private function showCost(e:Event):void {
			var componentClass:Class = e.target.selectedItem.data as Class;
			var styles:Object = componentClass["getStyleDefinition"].call(this);
			var styleData:DataProvider = new DataProvider();
			for(var i:* in styles) {
				styleData.addItem( { StyleName:i, DefaultValue:styles[i] } );
			}
			styleData.sortOn("StyleName");
			dg.dataProvider = styleData;
		}*/
		private function onPrivateTableSubmit(p__1:com.script.poker.popups.events.PPVEvent):void
		{
			var l__4:String;
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("onCreateTable");
			var l__3:* = true;
			var l__5:String = ppctView.tablename;
			var l__6:String = ppctView.tablepassword;
			var l__7:Number = (ppctView.small != "") ? Number(ppctView.small) : 0;
			var l__8:Number = (ppctView.large != "") ? Number(ppctView.large) : 0;
			var l__9:Number = (ppctView.max != "") ? Number(ppctView.max) : 0;
			var l__10 = RadioButtonGroup.getGroup("costGroup");
			var l__11 =Number(l__10.selection.value);
			var l__12 = pgData.tableCost;
			var l__13 = l__12[l__11].cost
			
			//pgData.points
			if (l__5 == ""){
				l__3 = false;
				l__4 = langs.l_errroomname;
				ppctView.setNameFocus();
			}
			if (Number(l__13) > Number(pgData.points)){
				l__3 = false;
				l__4 = langs.l_errchip;
				
			}
			if (l__6 == ""){
				l__3 = false;
				l__4 = lang.l_wrongpassword;
				ppctView.setPassFocus();
			}
			if (((l__7 <= 0) && (l__8 <= 0)) || (l__8 < l__7)){
				l__3 = false;
				l__4 = lang.l_errblind;
				ppctView.setSmallFocus();
			}
			if ((l__9 < 2) || (l__9 > 9)){
				l__3 = false;
				l__4 = lang.l_playeramount29;
				ppctView.setMaxFocus();
				ppctView.max = 9;
			}
			if (l__8 > 999999999){
				l__3 = false;
				l__4 = lang.l_errmaxblind;
				ppctView.setSmallFocus();
			}
			if (l__3){
				
				ppctView.removeEventListener(PPVEvent.PRIVATE_TABLE_YES, onPrivateTableSubmit);
				ppctView.reset();
				pControl.createPrivateRoom(l__5, l__6, l__7, l__8, l__9, l__11);
				//ppctView.hide();
				ppctView.visible = false;
			} else {
				
				ppctView.errMsg = l__4;
			}
		}
		private function onPrivateTableCancel(p__1:com.script.poker.popups.events.PPVEvent):void
		{
			ppctView.removeEventListener(PPVEvent.PRIVATE_TABLE_NO, onPrivateTableCancel);
			ppctView.reset();
			ppctView.visible = false;
		}
		private function showInviteMessages(p__1):void
		{
			//ppsiView.addEventListener("ENTER_PASS", onEnterPass);
			ppsiView.addEventListener(PPVEvent.ENTER_PASS, onInviteMes);
			//ppsiView.addEventListener(PPVEvent.CANCEL_PASS, onCancelPass);
			ppsiView.password = false;
			ppsiView.reset();
			ppsiView.body = langs.l_insertmes;
			//p__1.popupRef.show(true);
			ppsiView.x = 100;
			ppsiView.y = 100;
			ppsiView.visible = true
			ppsiView.setFieldFocus();
			ppsiView.zid = p__1.zid
			/*p__1.popupRef.addEventListener("ENTER_PASS", onEnterPass);
			p__1.moduleRef.password = true;
			p__1.moduleRef.reset();
			p__1.moduleRef.body = "Please enter the table password.";
			p__1.popupRef.show(true);
			p__1.moduleRef.setFieldFocus();*/
		}
		
		private function onInviteMes(p__1:com.script.poker.popups.events.PPVEvent):void
		{
			var l__3:String;
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("onEnterPassword");
			var l__4:String = ppsiView.value;
			
				ppsiView.removeEventListener(PPVEvent.ENTER_PASS, onInviteMes);
				//pControl.submitPassword(l__4);
				var p__2:Object = new Object();
				p__2.msg = ppsiView.value;
				p__2.zid = ppsiView.zid;
				pControl.onSentZoomTableInvitation(p__2)
				ppsiView.visible = false;
				//p__1.target.hide();
			
		}
		
		private function showPasswordEntry(p__1):void
		{
			//ppsiView.addEventListener("ENTER_PASS", onEnterPass);
			ppsiView.addEventListener(PPVEvent.ENTER_PASS, onEnterPass);
			ppsiView.addEventListener(PPVEvent.CANCEL_PASS, onCancelPass);
			ppsiView.password = true;
			ppsiView.reset();
			ppsiView.body = langs.l_tablepass;
			//p__1.popupRef.show(true);
			ppsiView.x = 100;
			ppsiView.y = 100;
			ppsiView.visible = true
			ppsiView.setFieldFocus();
			
			/*p__1.popupRef.addEventListener("ENTER_PASS", onEnterPass);
			p__1.moduleRef.password = true;
			p__1.moduleRef.reset();
			p__1.moduleRef.body = "Please enter the table password.";
			p__1.popupRef.show(true);
			p__1.moduleRef.setFieldFocus();*/
		}
		private function onEnterPass(p__1:com.script.poker.popups.events.PPVEvent):void
		{
			var l__3:String;
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("onEnterPassword");
			var l__4:String = ppsiView.value;
			if (l__4 == ""){
				ppsiView.caption = langs.l_wrongpassword;
			} else {
				ppsiView.removeEventListener(PPVEvent.ENTER_PASS, onEnterPass);
				pControl.submitPassword(l__4);
				ppsiView.visible = false;
				//p__1.target.hide();
			}
		}
		private function onCancelPass(p__1:com.script.poker.popups.events.PPVEvent):void
		{
				ppsiView.removeEventListener(PPVEvent.ENTER_PASS, onEnterPass);
				ppsiView.visible = false;
				
		}
		private function updateEditTable(p__1):void
		{
			//ppsiView.addEventListener("ENTER_PASS", onEnterPass);
			ppcpView.addEventListener(PPVEvent.ENTER_CHANGEPASS, onEnterChangePass);
			ppcpView.password = true;
			ppcpView.reset();
			ppsiView.body = langs.l_edittablepass;
			//p__1.popupRef.show(true);
			ppcpView.x = 100;
			ppcpView.y = 100;
			ppcpView.visible = true
			ppcpView.setFieldFocus();
			
			/*p__1.popupRef.addEventListener("ENTER_PASS", onEnterPass);
			p__1.moduleRef.password = true;
			p__1.moduleRef.reset();
			p__1.moduleRef.body = "Please enter the table password.";
			p__1.popupRef.show(true);
			p__1.moduleRef.setFieldFocus();*/
		}
		private function onEnterChangePass(p__1:com.script.poker.popups.events.PPVEvent):void
		{
			var l__3:String;
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("onEnterChangePassword");
			var l__4:Object = ppcpView.value;
			if (l__4.old == "" || l__4.news == ""){
				ppcpView.caption = langs.l_wrongpassword;
			}else if (l__4.news !=  l__4.news2){
				ppcpView.caption = langs.l_passnotmatch;
			} else {
				ppcpView.removeEventListener(PPVEvent.ENTER_PASS, onEnterChangePass);
				pControl.submitChangePassword(l__4);
				ppcpView.visible = false;
				//p__1.target.hide();
			}
		}
		private function showWelcomeMessage(p__1:com.script.poker.popups.Popup):void
		{
			p__1.popupRef.show(true);
		}
		private function showTermsOfServiceReminder(p__1:com.script.poker.popups.Popup, p__2:com.script.poker.events.PopupEvent):void
		{
			var l__3:com.script.poker.events.ErrorPopupEvent = ErrorPopupEvent(p__2);
			p__1.popupRef.addEventListener("CONFIRM", onConfirmReconnect);
			p__1.popupRef.titleText = l__3.sTitle;
			p__1.popupRef.bodyText = l__3.sMsg;
			p__1.popupRef.show(true);
		}
		private function showOutOfChips(p__1:com.script.poker.popups.Popup):void
		{
			p__1.moduleRef.chips = 1000;
			p__1.popupRef.show(true);
		}
		private function showDailyBonus(p__1:com.script.poker.popups.Popup):void
		{
			p__1.moduleRef.chips = pgData.bonus;
			if (!bDailyBonusInitialized){
				initDailyBonus(p__1);
			}
			p__1.popupRef.show(true);
		}
		private function initDailyBonus(p__1:com.script.poker.popups.Popup):void
		{
			p__1.popupRef.addEventListener("JOIN_TOURNEY", onJoinTourney);
			bDailyBonusInitialized = true;
		}
		private function onJoinTourney(p__1:com.script.poker.popups.events.PPVEvent):void
		{
			/*var l__2:* = "http://nav3.script.com/link/link.php?item=Poker%20FB%20Flash%20Other%20Click%20o%3AJoinWeeklyTourney%3A2009-04-07&ltsig=4d04034f8c8190fe2355725a514b2a9c&url=http%3A%2F%2Fapps.facebook.com%2Ftexas_holdem%2Ftourney.php";
			var l__3:com.script.io.LoadUrlVars = new LoadUrlVars();
			l__3.navigateURL(l__2, "_blank");*/
		}
		/*private function showErrorPopup(p__1:com.script.poker.popups.Popup, p__2:com.script.poker.events.PopupEvent):void
		{
			var l__3:com.script.poker.events.ErrorPopupEvent = ErrorPopupEvent(p__2);
			p__1.popupRef.titleText = l__3.sTitle;
			p__1.popupRef.bodyText = l__3.sMsg;
			p__1.popupRef.show(true);
		}*/
		private function showErrorPopupNotCancelable(p__1:com.script.poker.popups.Popup, p__2:com.script.poker.events.PopupEvent):void
		{
			var l__3:com.script.poker.events.ErrorPopupEvent = ErrorPopupEvent(p__2);
			p__1.popupRef.titleText = l__3.sTitle;
			p__1.popupRef.bodyText = l__3.sMsg;
			p__1.popupRef.show(true);
		}
		private function showDisconnectPopup(p__1:com.script.poker.popups.Popup, p__2:com.script.poker.events.PopupEvent):void
		{
			var l__3:com.script.poker.events.ErrorPopupEvent = ErrorPopupEvent(p__2);
			p__1.popupRef.addEventListener("CONFIRM", onConfirmReconnect);
			p__1.popupRef.titleText = l__3.sTitle;
			p__1.popupRef.bodyText = l__3.sMsg;
			p__1.popupRef.show(true);
		}
		private function onConfirmReconnect(p__1:com.script.poker.popups.events.PPVEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("onDisconnection");
			l__2.popupRef.removeEventListener("CONFIRM", onConfirmReconnect);
			pControl.cleanupAndReconnect();
		}
		private function showIntersitial(p__1:com.script.poker.popups.Popup, p__2:com.script.poker.events.PopupEvent):void
		{
			var l__3:com.script.poker.events.InterstitialPopupEvent = InterstitialPopupEvent(p__2);
			p__1.popupRef.titleText = l__3.sTitle;
			p__1.popupRef.bodyText = l__3.sBody;
			p__1.popupRef.show(true);
		}
		public function hideInterstitial():void
		{
			var l__1:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showInterstitial");
			l__1.popupRef.hide();
		}
		private function showVipPromo(p__1:com.script.poker.popups.Popup, p__2:com.script.poker.events.PopupEvent):void
		{
			var l__3:com.script.poker.events.VIPPopupEvent = VIPPopupEvent(p__2);
			p__1.moduleRef.snid = l__3.snid;
			p__1.moduleRef.days = l__3.days;
			p__1.moduleRef.vipStatusMsg = l__3.vipStatusMsg;
			p__1.moduleRef.isVip = l__3.isVip;
			p__1.moduleRef.isDisplayLobby = l__3.isDisplayLobby;
			p__1.moduleRef.addEventListener(VIPEvent.VIP_BUY_CHIPS, onVipBuyChips);
			p__1.moduleRef.addEventListener(VIPEvent.VIP_CASH_IN, onVipCashIn);
			p__1.moduleRef.addEventListener(VIPEvent.VIP_EARN_PASS, onVipEarnPass);
			p__1.popupRef.show(true);
		}
		private function onVipEarnPass(p__1:com.script.poker.popups.modules.events.VIPEvent):void
		{
			var l__2:com.script.io.LoadUrlVars = new LoadUrlVars();
			l__2.navigateURL(pgData.vip_host_url, "_blank");
		}
		private function onVipCashIn(p__1:com.script.poker.popups.modules.events.VIPEvent):void
		{
			var l__2:com.script.io.LoadUrlVars = new LoadUrlVars();
			l__2.navigateURL(pgData.vip_chips_url, "_blank");
		}
		private function onVipBuyChips(p__1:com.script.poker.popups.modules.events.VIPEvent):void
		{
			var l__2:com.script.io.LoadUrlVars = new LoadUrlVars();
			l__2.navigateURL(pgData.vip_buy_url, "_blank");
		}
		private function onResetVipPopup():void
		{
			var l__1:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showVipPromo");
			l__1.popupRef.removeEventListener(VIPEvent.VIP_BUY_CHIPS, onVipBuyChips);
			l__1.popupRef.removeEventListener(VIPEvent.VIP_CASH_IN, onVipCashIn);
			l__1.popupRef.removeEventListener(VIPEvent.VIP_EARN_PASS, onVipEarnPass);
			l__1.popupRef.hide();
		}
		private function showMySpaceAd(p__1:com.script.poker.popups.Popup, p__2:com.script.poker.events.PopupEvent):void
		{
			var l__3:com.script.poker.events.MyspacePopupEvent = MyspacePopupEvent(p__2);
			p__1.moduleRef.setState(l__3.frame, pgData.bonus);
			p__1.popupRef.addEventListener("MYSPACEAD_SENDCHIPS", onMySpaceAdSendChips);
			p__1.popupRef.show(true);
		}
		private function onMySpaceAdSendChips(p__1:com.script.poker.popups.events.PPVEvent):void
		{
			/*var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showMySpaceAd");
			l__2.popupRef.removeEventListener("MYSPACEAD_SENDCHIPS", onMySpaceAdSendChips);
			if (ExternalInterface.available){
				ExternalInterface.call(pgData.bonusButtonHandler);
			}*/
		}
		private function showIphonePromo(p__1:com.script.poker.popups.Popup):void
		{
			/*p__1.popupRef.addEventListener("IPHONE_INSTALL_NOW", onIphoneInstallNow);
			p__1.popupRef.show(true);*/
		}
		private function onIphoneInstallNow(p__1:com.script.poker.popups.events.PPVEvent):void
		{
			/*var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showIphonePromo");
			l__2.popupRef.removeEventListener("IPHONE_INSTALL_NOW", onIphoneInstallNow);
			var l__3:com.script.io.LoadUrlVars = new LoadUrlVars();
			l__3.navigateURL(pgData.iphone_url, "_blank");*/
		}
		private function showShootoutHowToPlay(p__1:com.script.poker.popups.Popup):void
		{
			p__1.moduleRef.btnBackToLobby.addEventListener(MouseEvent.CLICK, onHowBackToLobby);
			if (pgData.isWSOP == false){
				p__1.moduleRef.wsopBadge.visible = false;
			}
			p__1.popupRef.show(true);
		}
		private function onHowBackToLobby(p__1:flash.events.MouseEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showShootoutHowToPlay");
			l__2.popupRef.removeEventListener(MouseEvent.CLICK, onHowBackToLobby);
			l__2.popupRef.hide();
		}
		private function onSeeTerms(p__1:flash.events.MouseEvent):void
		{
			//var l__2:com.script.io.LoadUrlVars = new LoadUrlVars();
			//l__2.navigateURL("http://www.script.com/wsop/", "_blank");
		}
		private function showShootoutLearnMore(p__1:com.script.poker.popups.Popup):void
		{
			p__1.moduleRef.btnBackToLobby.addEventListener(MouseEvent.MOUSE_UP, onLearnBackToLobby);
			p__1.moduleRef.termsConds.addEventListener(MouseEvent.CLICK, onSeeTerms);
			p__1.moduleRef.termsConds.buttonMode = true;
			p__1.moduleRef.termsConds.useHandCursor = true;
			p__1.popupRef.show(true);
		}
		private function onLearnBackToLobby(p__1:flash.events.MouseEvent):void
		{
			var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent("showShootoutLearnMore");
			l__2.popupRef.removeEventListener(MouseEvent.MOUSE_UP, onLearnBackToLobby);
			l__2.popupRef.removeEventListener(MouseEvent.CLICK, onSeeTerms);
			l__2.popupRef.hide();
		}
		private function onShootoutFeedCheck(p__1:com.script.poker.popups.modules.events.BBCardEvent):void
		{
			pgData.bFbShootoutFeed = !pgData.bFbShootoutFeed;
		}
		private function showTopEvent(p__1):void
		{
			ppeiView.eventstart = p__1._start;
			ppeiView.eventstop = p__1._stop;
			ppeiView.eventpoin = p__1._poin;
			ppeiView.eventrule = p__1._rule;
			
			if (p__1._stat == 1){
				ppeiView.txtpaused.visible = false;
			}else{
				ppeiView.txtpaused.visible = true;
			}
			
			ppeiView.setTopWinner(p__1.userList, p__1.poinList);
			
			ppeiView.x = 220
			ppeiView.y = 96
			ppeiView.visible = true;
		}
		//private function onPopupEvent(p__1:com.script.poker.events.PopupEvent):void
		private function onPopupEvent(p__1:Object):void
		{
			//var l__2:com.script.poker.popups.Popup = ppModel.getPopupByEvent(p__1.type);
			switch(p__1.type){
				case "showVipPromo":
				{
					showVipPromo(l__2, p__1);
					break;
				}
				case "showMySpaceAd":
				{
					showMySpaceAd(l__2, p__1);
					break;
				}
				case "onDisconnection":
				{
					showDisconnectPopup(l__2, p__1);
					break;
				}
				case "onErrorPopup":
				{
					showErrorPopup(p__1);
					break;
				}
				case "onErrorPopupNotCancelable":
				{
					showErrorPopupNotCancelable(l__2, p__1);
					break;
				}
				case "showWelcomeMessage":
				{
					showWelcomeMessage(l__2);
					break;
				}
				case "showOutOfChips":
				{
					showOutOfChips(l__2);
					break;
				}
				case "showDailyBonus":
				{
					showDailyBonus(l__2);
					break;
				}
				case "onInviteMessages":
				{
					showInviteMessages(p__1);
					break;
				}
				case "onEnterPassword":
				{
					showPasswordEntry(p__1);
					break;
				}
				case "onCreateTable":
				{
					updateCreateTable(p__1);
					break;
				}
				case "onTransferChips":
				{
					updateTransferChips(p__1);
					break;
				}
				case "onErrorPop":
				{
					updateErrorPop(p__1);
					break;
				}
				case "showTableBuyIn":
				{
				
					updateTableBuyIn(p__1);
					break;
				}
				case "showEditTable":
				{
				
					updateEditTable(p__1);
					break;
				}
				case "showTermsOfServiceReminder":
				{
					showTermsOfServiceReminder(l__2, p__1);
					break;
				}
				case "showTournamentBuyIn":
				{
					updateTournamentBuyIn(l__2, p__1);
					break;
				}
				case "showTournamentCongrats":
				{
					updateTournamentCongrats(l__2, p__1);
					break;
				}
				case "showShootoutCongrats":
				{
					updateShootoutCongrats(l__2, p__1);
					break;
				}
				case "showBaseballCard":
				{
					//updateBaseballCard(l__2, p__1);
					updateBaseballCard(p__1);
					break;
				}
				case "showEmoMenu":
				{
					//updateEmoMenu(p__1);
					onEmoMenu(p__1);
					break;
				}
				case "showGiftMenu":
				{
					//updateEmoMenu(p__1);
					onGiftMenux(p__1);
					break;
				}
				case "showDrinkMenu":
				{
					updateDrinkMenu2(l__2, p__1);
					break;
				}
				case "showBuddyDialog":
				{
					updateBuddyDialog(p__1);
					break;
				}
				case "showTourneyPopup":
				{
					showTourneyPopup(l__2, p__1);
					break;
				}
				case "showInterstitial":
				{
					showIntersitial(l__2, p__1);
					break;
				}
				case "showIphonePromo":
				{
					showIphonePromo(l__2);
					break;
				}
				case "showShootoutHowToPlay":
				{
					showShootoutHowToPlay(l__2);
					break;
				}
				case "showShootoutLearnMore":
				{
					showShootoutLearnMore(l__2);
					break;
				}
				case "showReport":
				{
				
					showReportError(p__1);
					break;
				}
				case "showTopEvent":
				{
				
					showTopEvent(p__1);
					break;
				}
				default:
				{
					l__2.popupRef.show(true);
				}
			}
		}
	}
}