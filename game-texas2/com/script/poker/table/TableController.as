// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import com.script.poker.lobby.RoomItem;
	import com.script.User; 
	import com.script.poker.PokerUser;
	import com.script.poker.PokerGlobalData;
	import com.script.poker.PokerController;
	import com.script.poker.PokerConnectionManager;
	import com.script.poker.UserPresence;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.EventDispatcher;
	import com.script.poker.events.*;
	import com.script.poker.protocol.*;
	import com.script.zoom.*;
	import com.script.poker.table.events.TVEvent;
	import com.script.poker.table.events.TCEvent;
	import com.script.poker.table.events.view.TVESitPressed;
	import com.script.poker.table.events.view.TVERaisePressed;
	import com.script.poker.table.events.view.TVESendChat;
	import com.script.poker.table.events.view.TVEChatNamePressed;
	import com.script.poker.table.events.view.TVEMuteMod;
	import com.script.poker.table.events.view.TVEPlaySound;
	import com.script.poker.table.events.view.TVEGiftPressed;
	import com.script.poker.table.events.view.TVEJoinUserPressed;
	import com.script.poker.table.events.view.TVERefreshJoinUserPressed;
	import com.script.events.*;	
	import flash.utils.Timer;
	import com.script.format.*;
	import com.script.io.LoadUrlVars;
	import com.script.poker.table.events.controller.*;
	import flash.external.*;
	public class TableController extends flash.events.EventDispatcher
	{
		private var viewer:com.script.User;
		private var isMutePressed:Boolean = false;
		private var isEmoPressed:Boolean = false;
		private var isGiftPressed:Boolean = false;
		private var pgData:com.script.poker.PokerGlobalData;
		public var bStandUp:Boolean;
		public var ptModel:com.script.poker.table.TableModel;
		private var isCheckSpectator:Boolean = false;
		private var pcmConnect:com.script.poker.PokerConnectionManager;
		public var ptView:Object;
		private var pControl:com.script.poker.PokerController;
		private var giveChipsTimer:flash.utils.Timer;
		private var nChatCount:int = 0;
		public var bGiveChips:Boolean;
		private var mainDisp:flash.display.MovieClip;
		public var tJackpot:Number = 0;
		public var bJackpot:Number = 0;
		public var hargajp1:Number = 0;
		public var hargajp2:Number = 0;
		public var hargajp3:Number = 0;
		public var payRate:Array;
			
		private var langs;
		
		public function TableController()
		{			
		
		}  
		public function startTableController(p__1:flash.display.MovieClip, p__2:com.script.poker.PokerGlobalData, p__3:com.script.poker.PokerConnectionManager, p__4:com.script.poker.PokerController, p__5:Boolean):void
		{			
			mainDisp = p__1;
			pgData = p__2;
			pControl = p__4;
			viewer = pgData.viewer;
			pcmConnect = p__3;
			pcmConnect.addEventListener("onMessage", onProtocolMessage);
			bGiveChips = true;
			bStandUp = false;
			langs  = mainDisp.langs;
		}
		
		public function enableProtocol():void
		{
			pcmConnect.addEventListener("onMessage", onProtocolMessage);
		}
		public function disableProtocol():void
		{
			pcmConnect.removeEventListener("onMessage", onProtocolMessage);
		}
		private function getPopupXML(p__1:String):XML
		{
			var l__3:String;
			var l__4:XML;
			var l__2:XMLList = pgData.xmlPopups.child("popup");
			for each (l__4 in l__2){
				if (l__4.child("event").toString() == p__1){
					return(l__4);
				}
			}
		}
 		public function autoSit():void
		{
			
			var l__2:Number = 0;
			var l__4:com.script.poker.protocol.SSit;
			if (pgData.joiningShootout){
				pgData.joiningShootout = false;
				return;
			}
			var l__1:Number = 0;
			if (pgData.dispMode == "shootout"){
				l__1 = pControl.soConfig.nBuyin;
				l__2 = pControl.soUser.nRound;
				l__3 = new SSitShootout("SSitShootout", l__1, -1, l__2);
				pcmConnect.sendMessage(l__3);
				
			} else {
				l__1 = Math.round(pgData.points / 3);
				if (((ptModel.nBigblind * 10) > l__1) && (ptModel.nMaxBuyIn <= pgData.points)){
					l__1 = ptModel.nBigblind * 10;
				} else if (ptModel.nMaxBuyIn < l__1){
					l__1 = ptModel.nMaxBuyIn;
				} else if (((ptModel.nBigblind * 10) > l__1) && (ptModel.nMaxBuyIn > pgData.points)){
					l__1 = ptModel.nBigblind * 10;
				}
				l__4 = new SSit("SSit", l__1, -1);
				pcmConnect.sendMessage(l__4);
			}
		}
		private function initTableModel(p__1:Array, p__2:String = ""):void
		{
			var l__4:String;
			var l__3:com.script.poker.lobby.RoomItem = pgData.getRoomById(pgData.gameRoomId);
			var l__5 = pgData.gamePubId;
			if (Number(l__5) > 100){
				l__5 = pgData.arrTableBG.length -1;
			}
			if (pgData.tourneyId > -1){
				if (!(pgData.promoTableBG == null) && !(pgData.promoTableBG == "")){
					l__4 = pgData.promoTableBG;
				} else {
					l__4 = pgData.tnyTableBG;
				}
			} else if (pgData.dispMode == "vip"){
				l__4 = pgData.vipTableBG;
			} else if (pgData.dispMode == "shootout"){
				switch(pControl.soUser.nRound){
					case 1:
					{
						l__4 = pgData.so1TableBG;
						break;
					}
					case 2:
					{
						l__4 = pgData.so2TableBG;
						break;
					}
					case 3:
					{
						l__4 = pgData.so3TableBG;
						break;
					}
					default:
					{
						l__4 = pgData.stdTableBG;
					}
				}
			} else {
				if (pgData.arrTableBG == null || pgData.arrTableBG == "") {
					l__4 = pgData.stdTableBG;
				}
				else {
					//l__4 = pgData.arrTableBG[pgData.gamePubId];
					l__4 = pgData.arrTableBG[l__5];
				}
			}
			
			pgData.activeRoom = l__3;
			ptModel = new TableModel(p__1, pgData.viewer, l__3, pgData.aRankNames, pgData.aBuddyInvites, null, pgData.serverName, l__4, pgData.tourneyId, p__2, pgData.dispMode);
			ptModel.bTableSoundMute = pgData.bTableSoundMute;
			ptModel.langs = pgData.langs;
			//pControl.zoomUpdateStakes(ptModel.formatBlinds(ptModel.nSmallblind, ptModel.nBigblind), pgData.gameRoomId);
		}
		private function initTableView():void
		{	
			var l__1:Class = pgData.lbTable.getDefinition("com.script.poker.table.TableView");
			if (ptView == null){
				ptView = ((new l__1()) as Object);
			}
			ptView.name = "tabview";
			ptModel.nZoomFriends = pgData.nZoomFriends;
			ptView.initView(ptModel);
			initGifts();
			//initEmo();
			displayTable();
			//var l__4:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			//tableInfo.casinoTf.text = ("" + StringUtility.StringToMoney(l__4.nTotalPoints));
			ptView.tableInfo.casinoTf.text = (StringUtility.StringToMoney(pgData.points));
	
			ptView.mcJackpot.jackpotTf.text = StringUtility.StringToMoney(tJackpot)
			ptView.mcJackpotB.jackpotTf1.text = StringUtility.StringToMoney(bJackpot)
			ptView.mcJackpotB.jackpotTf2.text = StringUtility.StringToMoney(bJackpot)
			ptView.mcJackpotB.jackpotTf3.text = StringUtility.StringToMoney(bJackpot)
			ptView.mcPaylist.full_rate.text = (payRate[0]+" X");
			ptView.mcPaylist.four_rate.text = (payRate[1]+" X");
			ptView.mcPaylist.sflush_rate.text = (payRate[2]+" X");
			ptView.mcPaylist.royal_rate.text = (payRate[3]+" X");
			ptView.mcPaylist.sroyal_rate.text = (payRate[4]+" X");
			ptView.mcPaylist.full_txt.text = langs.l_fullhouse;
			ptView.mcPaylist.four_txt.text = langs.l_fourofakind
			ptView.mcPaylist.sflush_txt.text = langs.l_straightflush;
			ptView.mcPaylist.royal_txt.text = langs.l_royalflush;
			ptView.mcPaylist.sroyal_txt.text = langs.l_superroyalflush;
			ptView.mcPaylist.jp_txt.text = langs.l_jppayout;
			
			//ptView.tableInfo.bg_periodetxt.visible =false;
			
			if (Number(payRate[0]) <= 0){
				ptView.mcPaylist.full_rate.visible = false;
				ptView.mcPaylist.full_txt.visible = false;
			}
			if (Number(payRate[1]) <= 0){
				ptView.mcPaylist.four_rate.visible = false;
				ptView.mcPaylist.four_txt.visible = false;
			}
			if (Number(payRate[2]) <= 0){
				ptView.mcPaylist.sflush_rate.visible = false;
				ptView.mcPaylist.sflush_txt.visible = false;
			}
			if (Number(payRate[3]) <= 0){
				ptView.mcPaylist.royal_rate.visible = false;
				ptView.mcPaylist.royal_txt.visible = false;
			}
			if (Number(payRate[4]) <= 0){
				ptView.mcPaylist.sroyal_rate.visible = false;
				ptView.mcPaylist.sroyal_txt.visible = false;
			}
			if (pgData.tourneyId > -1){
				ptView.joinButton.visible = false;
			}
			if (pgData.connectToZoom == 1){
				ptView.joinCtrl.joinFriends.refreshButton.visible = !(pgData.useZoomForFriends == 1);
				if (ptView.joinCtrl.joinNetworks){
					ptView.joinCtrl.joinNetworks.refreshButton.visible = !(pgData.useZoomForNetwork == 1);
				}
				
				//onZoomUpdate();
			}
			pgData.joiningContact = false;
		}
		
		private function initGifts():void
		{
			var l__2:com.script.poker.PokerUser;
			var l__1:int = 0;
			while(l__1 < 9){
				l__2 = ptModel.getUserBySit(l__1);
				if (l__2 != null){
					ptView.updateUserGift2(this.pgData.nHideGifts, l__2.nSit, l__2.nGiftId);
				}
				l__1++;
			}
		}
		private function initEmo():void
		{
			var l__2:com.script.poker.PokerUser;
			var l__1:int;
			while(l__1 < 9){
				l__2 = ptModel.getUserBySit(l__1);
				if (l__2 != null){
					ptView.updateUserGift2(this.pgData.nHideGifts, l__2.nSit, l__2.nGiftId);
				}
				l__1++;
			}
		}
		private function initControllerListeners():void
		{
			this.addEventListener(TCEvent.USERSWAITING_UPDATED, onCheckWaitList);
			this.addEventListener(TCEvent.USERSINROOM_UPDATED, onCheckMuteList);
			this.addEventListener(TCEvent.USERSINROOM_UPDATED, onCheckJoinFriend);
		}
		public function onHideFriendSelectorTC():void
		{
			if (ptView != null){
				ptView.onHideFS();
			}
		}
		public function onShowFriendSelectorTC():void
		{
			if (ptView != null){
				ptView.onShowFS();
			}
		}
		
		private function initViewListeners():void
		{
			ptView.addEventListener(TVEvent.LEAVE_TABLE, onLeaveTable);
			ptView.addEventListener(TVEvent.STAND_UP, onStandUp);
			ptView.addEventListener(TVEvent.BJACKPOT1_PRESSED, onBJackpotPressed1);
			ptView.addEventListener(TVEvent.BJACKPOT2_PRESSED, onBJackpotPressed2);
			ptView.addEventListener(TVEvent.BJACKPOT3_PRESSED, onBJackpotPressed3);
			ptView.addEventListener(TVEvent.BJACKPOT_UNPRESSED, onBJackpotUnPressed);
			
			ptView.addEventListener(TVEvent.EDIT_TABLE, onEditTable);
			ptView.addEventListener(TVEvent.SIT_PRESSED, onSitPressed);
			ptView.addEventListener(TVEvent.CALL_PRESSED, onCallPressed);
			ptView.addEventListener(TVEvent.FOLD_PRESSED, onFoldPressed);
			ptView.addEventListener(TVEvent.RAISE_PRESSED, onRaisePressed);
			ptView.addEventListener(TVEvent.MUTE_PRESSED, onMutePressed);
			ptView.addEventListener(TVEvent.EMO_PRESSED, onEmoPressed);
			ptView.addEventListener(TVEvent.GIFT_PRESSED, onGiftPressed);
			ptView.addEventListener(TVEvent.SEND_CHAT, onSendChat);
			ptView.addEventListener(TVEvent.CHAT_NAME_PRESSED, onChatNamePressed);
			ptView.addEventListener(TVEvent.MUTE_MOD, onMuteMod);
			ptView.addEventListener(TVEvent.INVITE_PRESSED, onInvitePressed);
			ptView.addEventListener(TVEvent.TOGGLE_MUTE_SOUND, onToggleMuteSoundPressed);
			ptView.addEventListener(TVEvent.IPHONE_PRESSED, onIphonePressed);
			ptView.addEventListener(TVEvent.REFRESH_JOIN_USER_PRESSED, onRefreshJoinUserPressed);
			ptView.addEventListener(TVEvent.JOIN_USER_PRESSED, onJoinUserPressed);
			ptView.addEventListener(TVEvent.VIP_BADGE_PRESSED, onVipBadgePressed);
			ptView.addEventListener(TVEvent.FRIEND_NET_PRESSED, onFriendNetworkPressed);
			ptView.addEventListener(TVEvent.REPORT_PRESSED, onReportPressed);
			ptView.addEventListener(TVEvent.PLAY_SOUND_ONCE, onPlaySoundOnce);
			initZoomModelListeners();
			
		}
		
		private function removeViewListeners():void
		{
			ptView.removeEventListener(TVEvent.LEAVE_TABLE, onLeaveTable);
			ptView.removeEventListener(TVEvent.STAND_UP, onStandUp);
			ptView.removeEventListener(TVEvent.BJACKPOT1_PRESSED, onBJackpotPressed1);
			ptView.removeEventListener(TVEvent.BJACKPOT2_PRESSED, onBJackpotPressed2);
			ptView.removeEventListener(TVEvent.BJACKPOT3_PRESSED, onBJackpotPressed3);
			ptView.removeEventListener(TVEvent.BJACKPOT_UNPRESSED, onBJackpotUnPressed);
		
			ptView.removeEventListener(TVEvent.EDIT_TABLE, onEditTable);
			ptView.removeEventListener(TVEvent.SIT_PRESSED, onSitPressed);
			ptView.removeEventListener(TVEvent.CALL_PRESSED, onCallPressed);
			ptView.removeEventListener(TVEvent.FOLD_PRESSED, onFoldPressed);
			ptView.removeEventListener(TVEvent.RAISE_PRESSED, onRaisePressed);
			ptView.removeEventListener(TVEvent.MUTE_PRESSED, onMutePressed);
			ptView.removeEventListener(TVEvent.EMO_PRESSED, onEmoPressed);
			ptView.removeEventListener(TVEvent.GIFT_PRESSED, onGiftPressed);
			ptView.removeEventListener(TVEvent.SEND_CHAT, onSendChat);
			ptView.removeEventListener(TVEvent.CHAT_NAME_PRESSED, onChatNamePressed);
			ptView.removeEventListener(TVEvent.MUTE_MOD, onMuteMod);
			ptView.removeEventListener(TVEvent.INVITE_PRESSED, onInvitePressed);
			ptView.removeEventListener(TVEvent.TOGGLE_MUTE_SOUND, onToggleMuteSoundPressed);
			ptView.removeEventListener(TVEvent.IPHONE_PRESSED, onIphonePressed);
			ptView.removeEventListener(TVEvent.REFRESH_JOIN_USER_PRESSED, onRefreshJoinUserPressed);
			ptView.removeEventListener(TVEvent.JOIN_USER_PRESSED, onJoinUserPressed);
			ptView.removeEventListener(TVEvent.VIP_BADGE_PRESSED, onVipBadgePressed);
			ptView.removeEventListener(TVEvent.FRIEND_NET_PRESSED, onFriendNetworkPressed);
			ptView.removeEventListener(TVEvent.REPORT_PRESSED, onReportPressed);
			ptView.removeEventListener(TVEvent.PLAY_SOUND_ONCE, onPlaySoundOnce);
			removeZoomModelListeners();
		}
		public function displayTable():void
		{
			var l__1:int = mainDisp.numChildren;
			if (l__1 > 0){
				if (l__1 == 2){
					mainDisp.addChildAt(ptView, 0);
				} else {
					mainDisp.addChildAt(ptView, 1);
					
				}
			} else {
				mainDisp.addChild(ptView);
			}
			//ptView.y = 55;
		}
		public function cleanupTable():void
		{
			stopGiveChipsTimer();
			mainDisp.removeChild(ptView);
			ptView.cleanupTable();
			removeViewListeners();
			//disableProtocol();
		}
		private function onLeaveTable(p__1:com.script.poker.table.events.TVEvent)
		{
			pgData.joiningShootout = false;
			pgData.EnsurePHPPopupsAreClosed();
			stopGiveChipsTimer();	
			mainDisp.removeChild(ptView);
			removeViewListeners();
			//disableProtocol();
			//clearJoinFriendFlags();
			/*if (pgData.sn_id == pgData.SN_FACEBOOK){
				pgData.bFbFeedAllow = true;
			}*/
			dispatchEvent(new TCEvent(TCEvent.STOP_SOUND));
			dispatchEvent(new TCEvent(TCEvent.LEAVE_TABLE));
		}
		private function onStandUp(p__1:com.script.poker.table.events.TVEvent)
		{
			//pControl.pStats.rec("table", "onStandUp");
			ptView.betControls.prebetControls.swapCheck(null);
			ptModel.clearHoleCards();
			runPossibleHands();
			
			var l__2:String = pgData.GetSignedTrackingUrl("o:Table:StandClicks:2009-03-20");
			if (l__2 != ""){
				record(l__2);
			}
			bStandUp = true;
			dispatchEvent(new TCEvent(TCEvent.STOP_SOUND));
			dispatchEvent(new TCEvent(TCEvent.STAND_UP));
			
		}
		private function onEditTable(p__1:com.script.poker.table.events.TVEvent)
		{
			
			//pControl.pStats.rec("table", "onStandUp");
			
			//ptView.betControls.prebetControls.swapCheck(null);
			
			//ptModel.clearHoleCards();
			var l__4 = 0
			//runPossibleHands();
			
			var popObj = new Object();
			popObj.type = "showEditTable"
			popObj.nSit = l__4;
			pControl.regPopup(popObj);
			//pControl.regPopup("showEditTable", l__4);
			//dispatchEvent(new TCEvent(TCEvent.STOP_SOUND));
			//dispatchEvent(new TCEvent(TCEvent.STAND_UP));
			
		}
		var clicksit;
		var thissit;
		private function onSitPressed(p__1:com.script.poker.table.events.view.TVESitPressed):void
		{
			l__2x = new SCekPoints("SCekPoints");
			pcmConnect.sendMessage(l__2x);
			var l__2:int;
			var l__3:Boolean;
			var l__5:String;
			var l__6:com.script.poker.PokerUser;
			var l__7:String;
			var l__4:int = p__1.nSit;
			var l__2x:com.script.poker.protocol.SCekPoints;
			
			if (ptModel.getUserBySit(l__4) != null){
			
				l__5 = pgData.GetSignedTrackingUrl("o:Table:SitPressedAvatar:2009-03-17");
				if (l__5 != ""){
					record(l__5);
				}
				
				l__6 = ptModel.getUserBySit(l__4);
				getCardOptions(l__6.zid);
			} else if (ptModel.getUserByZid(viewer.zid) == null){
				
				//pControl.pStats.rec("table", "onSitPressed");
				

				l__7 = pgData.GetSignedTrackingUrl("o:Table:SitPressed:2009-03-20");
				
				if (l__7 != ""){
					record(l__7);
				}
				
				if (pgData.dispMode != "shootout"){
					
					//if (ptModel.room.gameType == "Challenge"){
					clicksit = 1;
					thissit = l__4;
					

					//pControl.regPopup("showTableBuyIn", l__4);
					//dispatchEvent((new TBPopupEvent("showTableBuyIn", l__4)) as PopupEvent);
					//showTableBuyIn.visible = true;
					//} else if (ptModel.room.gameType == "Tournament"){
						//if (ptModel.sTourneyMode == "reg"){
						//	dispatchEvent((new TourneyBuyInPopupEvent("showTournamentBuyIn", l__4)) as PopupEvent);
						//}
					//}
				}
			}
		}
		
			
		
		private function onCallPressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			var l__4 = ptModel.getUserByZid(ptModel.viewer.zid);
			
			var l__2:com.script.poker.protocol.SAction;
			dispatchEvent(new TCEvent(TCEvent.STOP_SOUND));
			//if (ptModel.nCurrentTurn != ptModel.getUserByZid(ptModel.viewer.zid)){
			if (ptModel.nCurrentTurn == l__4.nSit){
				
				ptModel.nCurrentTurn = "-1"
				l__2 = new SAction("SAction", ptModel.nCallAmt, "c", pgData.jt);
				pcmConnect.sendMessage(l__2);
			}
		}
		private function onBJackpotPressed1(p__1:com.script.poker.table.events.TVEvent):void
		{
			trace("here");
			var l__2:com.script.poker.protocol.SBJackpot;
			l__2 = new SBJackpot("SBJackpot","b",1,hargajp1);
			pcmConnect.sendMessage(l__2);
		}
		
		
		private function onBJackpotPressed2(p__1:com.script.poker.table.events.TVEvent):void
		{
			
			
			var l__2:com.script.poker.protocol.SBJackpot;
			l__2 = new SBJackpot("SBJackpot","b",1,hargajp2);
			pcmConnect.sendMessage(l__2);
		}
		
		private function onBJackpotPressed3(p__1:com.script.poker.table.events.TVEvent):void
		{
			
		
			var l__2:com.script.poker.protocol.SBJackpot;
			l__2 = new SBJackpot("SBJackpot","b",1,hargajp3);
			pcmConnect.sendMessage(l__2);
		}
		
		
		private function onBJackpotUnPressed(p__1:com.script.poker.table.events.TVEvent):void
		{	
		
			var l__2:com.script.poker.protocol.SBJackpot;
			l__2 = new SBJackpot("SBJackpot","b",0,0);
			pcmConnect.sendMessage(l__2);
		}
		private function onFoldPressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			var l__4 = ptModel.getUserByZid(ptModel.viewer.zid);
			
			var l__2:com.script.poker.protocol.SAction;
			dispatchEvent(new TCEvent(TCEvent.STOP_SOUND));
			//if (ptModel.nCurrentTurn != ptModel.getUserByZid(ptModel.viewer.zid)){
			if (ptModel.nCurrentTurn == l__4.nSit){
				ptModel.nCurrentTurn = "-1"
				l__2 = new SAction("SAction", -1, "f", pgData.jt);
				pcmConnect.sendMessage(l__2);
			}
			dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, p__1.type));
		}
		private function onRaisePressed(p__1:com.script.poker.table.events.view.TVERaisePressed):void
		{
			var l__4 = ptModel.getUserByZid(ptModel.viewer.zid);
			var l__2:com.script.poker.protocol.SAction;
			dispatchEvent(new TCEvent(TCEvent.STOP_SOUND));
			//if (ptModel.nCurrentTurn != ptModel.getUserByZid(ptModel.viewer.zid)){
			if (ptModel.nCurrentTurn == l__4.nSit){
				ptModel.nCurrentTurn = "-1"
				l__2 = new SAction("SAction", p__1.nAmt, "r", pgData.jt);
				pcmConnect.sendMessage(l__2);
			}
		}
		private function onFriendNetworkPressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			dispatchEvent(new TCEvent(TCEvent.FRIEND_NET_PRESSED));
		}
		private function onReportPressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			var popObj = new Object();
			popObj.type = "showReport"
			//popObj.nSit = 2;
			pControl.regPopup(popObj);
		}
		private function onMutePressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			isMutePressed = true;
			var l__2:com.script.poker.protocol.SGetUsersInRoom = new SGetUsersInRoom("SGetUsersInRoom", pgData.zid, pgData.gameRoomId);
			pcmConnect.sendMessage(l__2);
		}
		private function onEmoPressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			isEmoPressed = true;
			var l__4:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			
			if (l__4 != null) {

			var popObj = new Object();
			popObj.type = "showEmoMenu";
			popObj.sit = l__4.nSit;
			popObj.sZid = ptModel.viewer.zid
			//popObj.emoticons = 

			pControl.regPopup(popObj);

			//pControl.regPopup("showEmoMenu", l__4.nSit);
			}
			//dispatchEvent((new UserPopupEvent("showEmoList", [l__2], false)) as PopupEvent);
			
			//var l__2:com.script.poker.protocol.SGetUsersInRoom = new SGetUsersInRoom("SGetUsersInRoom", pgData.zid, pgData.gameRoomId);
			//pcmConnect.sendMessage(l__2);
		}	
		private function onGiftPressed(p__1:com.script.poker.table.events.view.TVEGiftPressed):void
		{
			isGiftPressed = true;
			var l__4:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			var l__3:com.script.poker.PokerUser = ptModel.getUserBySit(p__1.sit);
			if (l__4 != null) {
			var popObj = new Object();
			popObj.type = "showGiftMenu";
			popObj.sit = p__1.sit;
			popObj.sZid = l__3.zid
			//popObj.toSit = l__4.nSit;
			//popObj.sToZid = ptModel.viewer.zid
			//popObj.emoticons = 

			pControl.regPopup(popObj);

			//pControl.regPopup("showEmoMenu", l__4.nSit);
			}
			//dispatchEvent((new UserPopupEvent("showEmoList", [l__2], false)) as PopupEvent);
			
			//var l__2:com.script.poker.protocol.SGetUsersInRoom = new SGetUsersInRoom("SGetUsersInRoom", pgData.zid, pgData.gameRoomId);
			//pcmConnect.sendMessage(l__2);
		}	
		private function onSendChat(p__1:com.script.poker.table.events.view.TVESendChat):void
		{
			var l__4:String;
			var l__5 = pgData.badWords.toLowerCase();
			var l__15 = p__1.sMessage.toLowerCase();
			//if ()
						
			var l__6 = l__5.split(",");
			var l__9 = 0;
			for (var l__7=0; l__7<l__6.length; l__7++){
				var l__8 = l__15.indexOf(l__6[l__7]);
				if (l__8 >= 0){
					l__9 = 1;
					break;
				}
			}
			if (l__9 == 1) {
				var l__10 = new Object();
				l__10.type = "RReceiveChat";
				l__10.sZid = pgData.zid;
				l__10.sMessage = "*** "+langs.l_badwords+" ***";
				l__10.sUserName = pgData.zid;
				var l__11:com.script.poker.protocol.RReceiveChat = new RReceiveChat("RReceiveChat", l__10.sZid, l__10.sMessage, l__10.sUserName);
				onReceiveChat(l__11);
				
				return;
			}
			
			var l__2:com.script.poker.protocol.SSendChat = new SSendChat("SSendChat", p__1.sMessage);
			pcmConnect.sendMessage(l__2); 
			nChatCount++;
			if (nChatCount == 1){
				l__4 = pgData.GetSignedTrackingUrl("o:Table:FirstChat:2009-02-13");
				if (l__4 != ""){
					record(l__4);
				}
			}
			var l__3:String = pgData.GetSignedTrackingUrl("o:Table:TotalChat:2009-02-13");
			if (l__3 != ""){
				record(l__3);
			}
			
		}
		private function onChatNamePressed(p__1:com.script.poker.table.events.view.TVEChatNamePressed):void
		{
			/*var l__2:com.script.poker.PokerUser = ptModel.getUserByZid(p__1.zid);
			if (l__2 != null){
				dispatchEvent((new UserPopupEvent("showBaseballCard", [l__2], false)) as PopupEvent);
			}*/
		}
		private function wrapChatZidLink(p__1:String, p__2:String):String
		{
			return(((("<a href=\'event:" + p__1) + "\'>") + p__2) + "</a>");
		}
		private function onProtocolMessage(p__1:com.script.poker.protocol.ProtocolEvent):void
		{
			var l__2:Object = p__1.msg;
			switch(l__2.type){
				case "RDealHoles":
				{
					onDealHoles(l__2);
					break;
				}
				case "RInitGameRoom":
				{
					onGameRoomInit(l__2);
					break;
				}
				case "RInitTourney":
				{
					onTourneyInit(l__2);
					break;
				}
				case "RJoinRoom":
				{
					onJoinRoom(l__2);
					break;
				}
				case "RJoinRoomError":
				{
					onJoinRoomError(l__2);
					break;
				}
				
				case "RSitJoined":
				{
					
					onSitJoined(l__2);
					break;
				}
				case "RSitTaken":
				{
					onSitTaken(l__2);
					break;
				}
				case "RUserLost":
				{
					onUserLost(l__2);
					break;
				}
				case "RTurnChanged":
				{
					onTurnChanged(l__2);
					break;
				}
				case "RPostBlind":
				{
					onPostBlind(l__2);
					break;
				}
				case "RPostBuyJackpot":
				{
					onPostBuyJackpot(l__2);
					
					break;
				}
				case "RGlobalJackpotUpdate":
				{
					
					onGlobalJackpotUpdate(l__2);
					break;
				}
				case "RMarkTurn":
				{
					onMarkTurn(l__2);
					break;
				}
				case "RReplayHoles":
				{
					onReplayHoles(l__2);
					break;
				}
				case "RFold":
				{
					onFold(l__2);
					break;
				}
				case "RTourneyOver":
				{
					onTourneyOver(l__2);
					break;
				}
				case "RCall":
				{
					onCall(l__2);
					break;
				}
				case "RAllin":
				{
					onAllin(l__2);
					break;
				}
				case "RRaise":
				{
					onRaise(l__2);
					break;
				}
				case "RRaiseOption":
				{
					onRaiseOption(l__2);
					break;
				}
				case "RCallOption":
				{
					onCallOption(l__2);
					break;
				}
				case "RReplayCards":
				{
					onReplayCards(l__2);
					break;
				}
				case "RFlop":
				{
					onFlop(l__2);
					break;
				}
				case "RStreet":
				{
					onStreet(l__2);
					break;
				}
				case "RRiver":
				{
					onRiver(l__2);
					break;
				}
				case "RClear":
				{
					onClear(l__2);
					break;
				}
				case "RWinners":
				{
					onWinners(l__2);
					break;
				}
				case "RDefaultWinners":
				{
					onDefaultWinners(l__2);
					break;
				}
				case "RAllinWar":
				{
					onAllinWar(l__2);
					break;
				}
				case "RReplayPots":
				{
					onReplayPots(l__2);
					break;
				}
				case "RReplayPlayers":
				{
					onReplayPlayers(l__2);
					return;
				}
				case "RMakePot":
				{
					onMakePot(l__2);
					break;
				}
				case "RReceiveChat":
				{
					onReceiveChat(l__2);
					break;
				}
				case "RGetUsersInRoom":
				{
					onGetUsersInRoom(l__2);
					break;
				}
				case "RGetUsersWaiting":
				{
					onGetUsersWaiting(l__2);
					break;
				}
				case "RUpdateChips":
				{    
					onUpdateChips(l__2);
					break;
				}
				case "RBoughtGift":
				{
					onBoughtGift(l__2);
					break;
				}
				case "RBoughtGift2":
				{
					onBoughtGift2(l__2);
					break;
				}
				case "RUserGifts":
				{
					onUserGifts(l__2);
					break;
				}
				case "RUserGifts2":
				{
					onUserGifts2(l__2);
					break;
				}
				case "RGiftShown":
				{
					onGiftShown(l__2);
					break;
				}
				case "RGiftShown2":
				{
					onGiftShown2(l__2);
					break;
				}
				case "RBoughtEmo":
				{
					onBoughtEmo(l__2);
					break;
				}
				case "RBuddyRequest":
				{
					onBuddyRequest(l__2);
					break;
				}
				case "RNewBuddy":
				{
					onNewBuddy(l__2);
					break;
				}
				case "RCardOptions":
				{
					onCardOptions(l__2);
					break;
				}
				case "RSendGiftChips":
				{
					onSendGiftChips(l__2);
					break;
				}
				case "RBuyinError":
				{
					onBuyinError(l__2);
					break;
				}
				case "RUserVip":
				{
					onUserVip(l__2);
					break;
				}
				case "RRefillPoints":
				{
					onRefillPoints(l__2);
					break;
				}
				case "RGoToLobby":
				{
					onGoToLobby(l__2);
					break;
				}
				case "RBuyIn":
				{
					onBuyIn(l__2);
					break;
				}
				case "RBlindChange":
				{
					onBlindChange(l__2);
					break;
				}
				case "RPointsUpdate":
				{
					onPointsUpdate(l__2);
					break;
				}
				case "RAchieved":
				{
					onAchieved(l__2);
					break;
				}
				case "RAlert":
				{
					onRAlert(l__2);
					break;
				}
				case "RShootoutBuyinChanged":
				{
					onShootoutBuyinChanged(l__2);
					break;
				}
				case "RShootoutConfigChanged":
				{
					onShootoutConfigChanged(l__2);
					break;
				}
				case "RPlayerBounced":
				{
					onPlayerBounced(l__2);
					break;
				}
				case "RRoundChanged":
				{
					onRoundChanged(l__2);
					break;
				}
				case "RSitPermissionRefused":
				{
					onSitPermissionRefused(l__2);
					break;
				}
			}
		}
		private function onGameRoomInit(p__1:Object):void
		{
			var l__3:String;
			var l__4:Boolean;
			var l__5:String;
			var l__6:String;
			var l__2:com.script.poker.protocol.RInitGameRoom = RInitGameRoom(p__1);
			tJackpot = l__2.jackpot;
			payRate = l__2.payRate;
			initTableModel(l__2.aUsers);
			initTableView();
			initViewListeners();
			initControllerListeners();
			
			if (pgData.rejoinRoom != -1){
				pgData.rejoinRoom = -1;
				if (isSeated()){
					displayPopupNextHand();
				}
			} else {
				l__3 = "hasTermsOfServiceReminderExecutedV2";
				l__4 = Boolean(pgData.flashCookie.GetValue(l__3, false));
				if (!l__4){
					pgData.flashCookie.SetValue(l__3, true);
					dispatchEvent(new ErrorPopupEvent("showTermsOfServiceReminder", "REMINDER OF script\'S TERMS OF SERVICE", "Buying chips from a third party will result in your chip stack being reset to zero.\n\nSelling chips will result in a permanent account ban and legal prosecution.\n\nTransferring chips by purposely losing hands is also prohibited.  Those caught doing so may be banned or zeroed out.\n\nThis is just a reminder to all users that we are actively monitoring our service to provide better service for everyone."));
				}
			}
			if (pgData.bAutoSitMe){
				pgData.bAutoSitMe = false;
				autoSit();
			}
			
			if (pgData.isJoinFriend){
				if (ptModel.aUsers.length == ptModel.room.maxUsers){
					pControl.TrackingHit("FriendsTableFull", 5, 14, 2010, 100, "Table Other FriendsTableFull o:LiveJoin:2009-05-14", null, 1);
				}
				checkFriendStatus();
			}
			if ((pgData.tourneyId > -1) && (pgData.bonus > 0)){
				//l__5 = "Hold\'em Message";
				//l__6 = "** Tip: Never share your password with anyone.\n\nCome back everyday to get 100 tournament chips!";
				//dispatchEvent(new ErrorPopupEvent("onErrorPopup", l__5, l__6));
			}
			
		}
		private function checkFriendStatus():void
		{
			var l__1:com.script.poker.protocol.SGetUsersInRoom;
			if (ptModel.getUserByZid(pgData.joinFriendId) != null){
				pControl.TrackingHit("FriendsTableSuccessTargetSitting", 5, 14, 2010, 100, "Table Other FriendsTableSuccessTargetSitting o:LiveJoin:2009-05-14", null, 1);
				pControl.TrackingHit("FriendsTableSuccess", 5, 14, 2010, 100, "Table Other FriendsTableSuccess o:LiveJoin:2009-05-14", null, 1);
			} else {
				isCheckSpectator = true;
				l__1 = new SGetUsersInRoom("SGetUsersInRoom", pgData.zid, pgData.gameRoomId);
				pcmConnect.sendMessage(l__1);
			}
		}
		private function clearJoinFriendFlags():void
		{
			pgData.isJoinFriend = false;
			pgData.isJoinFriendSit = false;
		}
		private function onTourneyInit(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RInitTourney = RInitTourney(p__1);
			initTableModel(l__2.aUsers, l__2.tourneyMode);
			initTableView();
			initViewListeners();
			initControllerListeners();
			if ((pgData.dispMode == "shootout") && (pgData.rejoinRoom == -1)){
				autoSit();
			} else if (pgData.bAutoSitMe){
				pgData.bAutoSitMe = false;
				autoSit();
			}
			if (pgData.rejoinRoom != -1){
				pgData.rejoinRoom = -1;
				if (isSeated()){
					displayPopupNextHand();
				}
			}
		}
		private function displayPopupNextHand():void
		{
			
			if (((pgData.dispMode == "tournament") || (pgData.dispMode == "shootout")) || (ptModel.aUsers.length == 1)){
				ptView.updatePopupNextHand(true, langs.l_waitother);
			} else {
				ptView.updatePopupNextHand(true, langs.l_waitnext);
			}			
		}
		
		private function onSitJoined(p__1:Object):void
		{
			var l__4:String;
			var l__5:int;
		
			var l__2:com.script.poker.protocol.RSitJoined = RSitJoined(p__1);
			var l__3:com.script.poker.PokerUser = l__2.user;
			ptModel.addUser(l__2.user);
			ptView.playerSat(l__3.nSit);
			
			var hargajp =l__3.bJackpot.split("*");
			hargajp1= hargajp[0];
			hargajp2= hargajp[1];
			hargajp3= hargajp[2];

			ptView.mcJackpotB.jackpotTf1.text = StringUtility.StringToMoney(hargajp1)
			ptView.mcJackpotB.jackpotTf2.text = StringUtility.StringToMoney(hargajp2)

			ptView.mcJackpotB.jackpotTf3.text = StringUtility.StringToMoney(hargajp3)
			
			ptView.updateUserGift2(this.pgData.nHideGifts, l__3.nSit, l__3.nGiftId);
			if (l__3.zid != viewer.zid){
				l__5 = l__3.nSit;
			} else {
				ptView.updateBuyJackpot(true, null);
				l__5 = -1;
			}
			//l__4 = StringUtility.formatHtmlString(pgData.config["dealer"]["join_table"], {sText:"%userName%", nVar:wrapChatZidLink(l__3.zid, l__3.sUserName), nSit:l__5});
			var l__6:uint = StringUtility.getUserColor(l__5);
			l__4 = ((("<font face=\"Verdana\" color=\"#ffffff\"><font face=\"Verdana Bold\" color=\"#" + l__6.toString(16)) + "\">") + wrapChatZidLink(l__3.zid, l__3.sUserName)) + "</font> "+langs.l_sitontable+"."+ "</font> ";
			
			ptView.newDealerMessage(l__4);
			
			if ((l__3.zid == viewer.zid) && isSeated()){
				//displayPopupNextHand();
				if (l__3.reSit != "1"){
					displayPopupNextHand();
				}else {
					
					ptView.showViewerBet();
				}
			}
			
			if (pgData.isJoinFriend && (!pgData.isJoinFriendSit)){
				
				if (l__3.zid == viewer.zid){
					pgData.isJoinFriendSit = true;
					pControl.TrackingHit("FriendsJoinUserAndSit", 5, 14, 2010, 100, "Table Other FriendsJoinUserAndSit o:LiveJoin:2009-05-14", null, 1);
				}
			}
			
			ptView.updateUserTotal(l__3.nSit);
		}		
		private function onSitTaken(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RSitTaken = RSitTaken(p__1);
			var l__3:String = pgData.config["sittaken"]["title"];
			var l__4:String = pgData.config["sittaken"]["message"];
			dispatchEvent(new ErrorPopupEvent("onErrorPopup", l__3, l__4));
		}
		private function onUserLost(p__1:Object):void		
		{
			
			var l__2:com.script.poker.protocol.RUserLost = RUserLost(p__1);
			var l__3:com.script.poker.PokerUser = ptModel.getUserBySit(l__2.sit);
			if (l__3 == null) {
				return;
			}
			l__3.sStatusText = "";
			if (l__3.zid == viewer.zid){
				//clearJoinFriendFlags();
				ptView.updateBuyJackpot();
				ptModel.clearHoleCards();
				runPossibleHands();
				//pgData.aBuddyInvites = new Array();
			} else {
				//pgData.removeBuddyInvite(l__3.zid);
			}
			//ptView.updateUserGift(l__2.sit, -1, -1);
			ptView.playerLeft(l__2.sit);
			ptModel.removeUser(l__2.sit);
			//updateInbox();
			if (isMe(l__3.zid)){
				if (ptModel.room.gameType == "Challenge"){
					if ((pgData.tourneyId == -1) && (pgData.points >= ptModel.nBigblind)){
						if (!bStandUp){
							if (ptModel.getUserBySit(l__2.sit) == null){
								dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "onUserLost"));
								dispatchEvent((new TBPopupEvent("showTableBuyIn", l__2.sit)) as PopupEvent);
							}	
						}
					}
				}
				ptView.updatePopupNextHand();
				
			}
			
			bStandUp = false;
			if ((ptModel.aUsers.length == 1) && isSeated(viewer.zid)){
				ptView.updatePopupNextHand(true, langs.l_waitother);
			}
			
		}
		private function onTurnChanged(p__1:Object):void

		{	
			ptView.clearTable();
			var l__2:com.script.poker.protocol.RTurnChanged = RTurnChanged(p__1);
			ptModel.resetModel();
			ptModel.nHandId = l__2.handId;
			ptModel.nDealerSit = l__2.sit;
			
			ptView.tableInfo.periodeTf.text = "P : "+l__2.periode;
			//ptView.tableInfo.bg_periodetxt.visible = true;
			ptView.setDealer(l__2.sit);
			bJackpot = l__2.bjackpot;
			tJackpot = l__2.jackpot;
			
			
			
			
			//ptView.TriggerJackpot(StringUtility.StringToMoney(l__2.globaljackpot),ptView.mcJackpotGlobal.jackpotTf.text);
			//ptView.mcJackpotGlobal.jackpotTf.text = StringUtility.StringToMoney(l__2.globaljackpot)
			
			ptView.mcSJackpotB.visible = false;
			ptView.resetChicklets();
			ptView.showViewerBet();
			ptView.onBJackpotPressed();
			//ptView.updateBuyJackpot();
			ptView.updateBuyJackpotOff();
			
			
			dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "onShuffle"));
		}
		private function onPostBlind(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RPostBlind = RPostBlind(p__1);
			ptModel.updateBlind(l__2.sit, l__2.bet, l__2.chips);
			ptView.postBlind(l__2.sit);
			ptView.updateBuyJackpot(true,null);
		}
		private function onPostBuyJackpot(p__1:Object):void
		{
			
			var l__2:com.script.poker.protocol.RPostBuyJackpot = RPostBuyJackpot(p__1);
			ptView.postStatusBuyJackpot(l__2.sit,l__2.bjackpot,l__2.hjackpot);
			
		}
		private function onDealHoles(p__1:Object):void
		{
			var l__4:com.script.io.LoadUrlVars;
			if (pgData.isJoinFriend && pgData.isJoinFriendSit){
				clearJoinFriendFlags();
				pControl.TrackingHit("FriendsJoinUserAndSitandPlay", 5, 14, 2010, 100, "Table Other FriendsJoinUserAndSitandPlay o:LiveJoin:2009-05-14", null, 1);
			}
			var l__2:com.script.poker.protocol.RDealHoles = RDealHoles(p__1);
			ptModel.setupNewHand(l__2.sit, l__2.card1, l__2.tip1, l__2.card2, l__2.tip2, l__2.small);
			ptView.dealHoleCards(l__2.sit);
			runPossibleHands();
			var l__3:String = pgData.GetSignedTrackingUrl("o:Table:HandPlayed:2009-02-11");
			if (l__3 != ""){
				l__4 = new LoadUrlVars();
				l__4.loadURL(l__3);
			}
			
			ptView.updatePopupNextHand();
			
		}
		private function onMarkTurn(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RMarkTurn = RMarkTurn(p__1);
			ptModel.nCurrentTurn = l__2.sit;
			ptView.startPlayerTurn(l__2.sit, l__2.time, l__2.elapsed);
			ptView.handleBetting(l__2.sit);
		}
		private function onReplayHoles(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RReplayHoles = RReplayHoles(p__1);
			ptModel.setupNewHand(l__2.sit, l__2.card1, l__2.suit1, l__2.card2, l__2.suit2);
			ptView.replayHoles(l__2.sit);
			ptView.betControls.visible = true;
			ptView.updatePopupNextHand();
		}
		private function onFold(p__1:Object):void
		{
			var l__4:String;
			var l__5:int;
			var l__2:com.script.poker.protocol.RFold = RFold(p__1);
			if (l__2.sit == undefined) {
				return;
			}
			ptModel.setPlayerStatus(l__2.sit, "fold");
			ptView.playerFolded(l__2.sit);
			var l__3:com.script.poker.PokerUser = ptModel.getUserBySit(l__2.sit);
			if (l__3.zid != viewer.zid){
				l__5 = l__3.nSit;
			} else {
				ptModel.clearHoleCards();
				runPossibleHands();
				l__5 = -1;
			}
			var l__6:uint = StringUtility.getUserColor(l__5);
			l__4 = ((("<font face=\"Verdana\" color=\"#ffffff\"><font face=\"Verdana Bold\" color=\"#" + l__6.toString(16)) + "\">") + wrapChatZidLink(l__3.zid, l__3.sUserName)) + "</font> "+langs.l_fold+""+"</font>";
			
			//l__4 = StringUtility.formatHtmlString(pgData.config["dealer"]["folded"], {sText:"%userName%", nVar:wrapChatZidLink(l__3.zid, l__3.sUserName), nSit:l__5});
			dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "FOLD_PRESSED"));
			ptView.newDealerMessage(l__4);
		}
		private function onTourneyOver(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RTourneyOver = RTourneyOver(p__1);
			var l__3:Number = 0;
			if (pgData.dispMode == "shootout"){
				dispatchEvent((new ShootoutCongratsPopupEvent("showShootoutCongrats", l__2.place, l__2.win)) as PopupEvent);
			} else if (pgData.dispMode == "tournament"){
				dispatchEvent((new TourneyCongratsPopupEvent("showTournamentCongrats", l__2.place, l__2.win)) as PopupEvent);
			}
		}
		private function onCall(p__1:Object):void
		{	
			var l__5:int;
			var l__2:com.script.poker.protocol.RCall = RCall(p__1);
			var l__3:* = "";
			var l__4:com.script.poker.PokerUser = ptModel.getUserBySit(l__2.sit);
			if (l__4.zid != viewer.zid){
				l__5 = l__4.nSit;
			} else {
				l__5 = -1;
			}
			var l__6:uint = StringUtility.getUserColor(l__5);
			if (l__2.bet > 0){
				ptModel.updatePlayerAction(l__2.sit, l__2.chips, l__2.bet, "call");
				
				l__3 = ((("<font face=\"Verdana\" color=\"#ffffff\"><font face=\"Verdana Bold\" color=\"#" + l__6.toString(16)) + "\">") + wrapChatZidLink(l__4.zid, l__4.sUserName)) + "</font> "+langs.l_call+" "+l__2.bet+"</font>";
			
				//l__3 = StringUtility.formatHtmlString("Call for "+l__2.bet, {sText:"%userName%", nVar:wrapChatZidLink(l__4.zid, l__4.sUserName), nSit:l__5}, {sText:"%bet%", nVar:l__2.bet});
				ptView.newDealerMessage(l__3);
				dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "sndCall"));
			} else {
				ptModel.updatePlayerAction(l__2.sit, l__2.chips, l__2.bet, "check");
				l__3 = ((("<font face=\"Verdana\" color=\"#ffffff\"><font face=\"Verdana Bold\" color=\"#" + l__6.toString(16)) + "\">") + wrapChatZidLink(l__4.zid, l__4.sUserName)) + "</font> "+langs.l_cek+""+"</font>";
				//l__3 = StringUtility.formatHtmlString("Checked", {sText:"%userName%", nVar:wrapChatZidLink(l__4.zid, l__4.sUserName), nSit:l__5});
				ptView.newDealerMessage(l__3);
				dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "sndCheck"));
			}
			ptView.updatePlayerAction(l__2.sit);
		}
		private function onAllin(p__1:Object):void
		{
			var l__4:int;
			var l__2:com.script.poker.protocol.RAllin = RAllin(p__1);
			ptModel.updatePlayerAction(l__2.sit, l__2.chips, l__2.bet, "allin");
			ptView.updatePlayerAction(l__2.sit);
			var l__3:com.script.poker.PokerUser = ptModel.getUserBySit(l__2.sit);
			if (l__3.zid != viewer.zid){ 
				l__4 = l__3.nSit;
			} else {
				l__4 = -1;
			}
			var l__6:uint = StringUtility.getUserColor(l__4);
			var l__5:String = ((("<font face=\"Verdana\" color=\"#ffffff\"><font face=\"Verdana Bold\" color=\"#" + l__6.toString(16)) + "\">") + wrapChatZidLink(l__3.zid, l__3.sUserName)) + "</font> "+langs.l_allin+" "+"</font>";
			
			//var l__5:String = StringUtility.formatHtmlString("AllIn", {sText:"%userName%", nVar:wrapChatZidLink(l__3.zid, l__3.sUserName), nSit:l__4});
			ptView.newDealerMessage(l__5);
			if (l__2.bet > ptModel.nMinBuyIn){
				dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "sndWinChips"));
			} else {
				dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "sndRaise"));
			}
		}
		private function onRaise(p__1:Object):void
		{
			var l__4:int;
			var l__2:com.script.poker.protocol.RRaise = RRaise(p__1);
			ptModel.updatePlayerAction(l__2.sit, l__2.chips, l__2.bet, "raise");
			ptView.updatePlayerAction(l__2.sit);
			var l__3:com.script.poker.PokerUser = ptModel.getUserBySit(l__2.sit);
			if (l__3.zid != viewer.zid){
				l__4 = l__3.nSit;
			} else {
				l__4 = -1;
			}
			var l__6:uint = StringUtility.getUserColor(l__4);
			var l__5:String = ((("<font face=\"Verdana\" color=\"#ffffff\"><font face=\"Verdana Bold\" color=\"#" + l__6.toString(16)) + "\">") + wrapChatZidLink(l__3.zid, l__3.sUserName)) + "</font> "+langs.l_raised+" "+l__2.bet+"</font>";
			
			//var l__5:String = StringUtility.formatHtmlString("Raised", {sText:"%userName%", nVar:wrapChatZidLink(l__3.zid, l__3.sUserName), nSit:l__4}, {sText:"%raiseAmount%", nVar:l__2.bet});
			ptView.newDealerMessage(l__5);
			dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "sndRaise"));
		}
		private function onRaiseOption(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RRaiseOption = RRaiseOption(p__1);
			ptModel.nMinBet = l__2.minVal;
			ptModel.nMaxBet = l__2.maxVal;
			ptModel.nCallAmt = l__2.chipsCall;
			ptView.setRaiseOption();
			dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "sndTurnStart"));
		}
		private function onCallOption(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RCallOption = RCallOption(p__1);
			ptModel.nCallAmt = l__2.chipsCall;
			
			ptView.setCallOption();
			dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_SEQUENCE, "playSound_YourTurn"));
		}
		private function onReplayCards(p__1:Object):void
		{			
			
			var l__4:* = undefined;
			var l__5:Object;
			
			var l__2:com.script.poker.protocol.RReplayCards = RReplayCards(p__1);
			var l__3:Array = l__2.commCards;
			
			
			ptModel.setFlopCards(l__3[0].card, l__3[0].suit, l__3[1].card, l__3[1].suit, l__3[2].card, l__3[2].suit);
			if (l__3.length > 3){
				ptModel.setStreetCard(l__3[3].card, l__3[3].suit);
			}
			if (l__3.length > 4){
				ptModel.setRiverCard(l__3[4].card, l__3[4].suit);
			}
			for (l__4 in l__3){
				l__5 = l__3[l__4];
				ptView.replayComCard(l__4);
			}
			runPossibleHands();
		}
		private function onFlop(p__1:Object):void
		{
			
			var l__2:com.script.poker.protocol.RFlop = RFlop(p__1);
			ptModel.setFlopCards(l__2.card1, l__2.tip1, l__2.card2, l__2.tip2, l__2.card3, l__2.tip3);
			ptView.dealFlop();
			runPossibleHands();
			dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "soundCardFlip"));
		}
		private function onStreet(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RStreet = RStreet(p__1);
			ptModel.setStreetCard(l__2.card1, l__2.tip1);
			ptView.dealStreet();
			runPossibleHands();
			dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "soundCardFlip"));
		}
		private function onRiver(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RRiver = RRiver(p__1);
			ptModel.setRiverCard(l__2.card1, l__2.tip1);
			ptView.dealRiver();
			runPossibleHands();
			dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "soundCardFlip"));
		}
		private function onClear(p__1:Object):void
		{
			ptView.clearTable();
		}
		private function onWinners(p__1:Object):void
		{
			var l__7:* = undefined;
			var l__8:String;
			var l__9:Object;
			var l__2:com.script.poker.protocol.RWinners = RWinners(p__1);
			var l__3:String = l__2.winningHand;
			var l__4:Array = l__2.winningHands;
			var l__5:* = -1;
			var l__6:Boolean;
			var l__13:com.script.poker.PokerUser;
			ptView.killClock();
			
			var l__11 = 1;
			var l__12 = "";
			var l__12x = "";
			var l__20x ="";
			for (l__7 in l__4){
				l__5 = l__4[l__7].sit;
				ptModel.updateWinner(l__4[l__7].sit, l__4[l__7].chips, l__4[l__7].card1, l__4[l__7].tip1, l__4[l__7].card2, l__4[l__7].tip2, l__4[l__7].handString, getBubbleMessage(l__3, l__5));
				l__6 = (l__7 == 0) ? true : false;
				ptView.showWinner(l__4[l__7].sit, (l__2.pot - 3), l__6);
				
				l__9 = getWinningHands(l__4[l__7].sit, l__4[l__7].card1, l__4[l__7].tip1, l__4[l__7].card2, l__4[l__7].tip2, l__4[l__7].handString[1]);
				
				ptView.showWinningCards(l__9);
			
				
				l__8 = getBubbleMessage(l__3, l__5, true);
				
				if (l__8 == "false") {
					
				}
				else if (l__8.length > 0){
					ptView.newDealerMessage("<font face=\"Verdana\" color=\"#ffffff\">"+l__8+"<font>");
					if (l__4[0].fee > 0) {
					ptView.newDealerMessage("<font face=\"Verdana\" color=\"#ffffff\">"+langs.l_fee+" ("+StringUtility.StringToMoney(l__4[0].fee)+")"+"</font>", "");
					}
					
					var userjack:com.script.poker.PokerUser;
					userjack = ptModel.getUserBySit(l__5);
					if (l__4[0].jackpot > 0) {
						
						ptView.newDealerMessage("<font face=\"Verdana\" color=\"#ffffff\">"+userjack.sUserName+" "+langs.l_win+" "+langs.l_jackpot+" ("+l__4[0].jackpot+")"+"</font>", "");
						l__12 = l__12+"  "+userjack.sUserName
						
						if (l__11 == l__4.length){
							ptView.showCongrat(l__12,l__4[0].jackpot);
							ptView.mcJackpot.jackpotTf.text = StringUtility.StringToMoney(l__2.curJackpot)

						}
						if (userjack.sUserName == viewer.zid){
							var newchip =Number(userjack.nTotalPoints)+Number(l__4[0].jackpot);
							userjack.nTotalPoints = newchip;
							ptView.tableInfo.casinoTf.text = ( StringUtility.StringToMoney(newchip));
						}
					}
					
					if (l__4[l__7].gjackpot > 0) {
						var usergjack:com.script.poker.PokerUser;
						usergjack = ptModel.getUserBySit(l__5);
						
						ptView.newDealerMessage("<font face=\"Verdana\" color=\"#ffffff\">"+usergjack.sUserName+" "+langs.l_win+" "+langs.l_globaljackpot+" ("+StringUtility.StringToMoney(l__4[l__7].gjackpot)+")"+"</font>", "");
						l__12x = l__12x+""+usergjack.sUserName+":"+l__4[l__7].gjackpot+"<br>";
						
						if (l__11 == l__4.length){
							
							//ptView.showCongratGJackpot(l__12x,l__4[0].gjackpot);
							//ptView.TriggerJackpot(StringUtility.StringToMoney(l__2.curGJackpot),ptView.mcJackpotGlobal.jackpotTf.text);
							//ptView.mcJackpotGlobal.jackpotTf.text = StringUtility.StringToMoney(l__2.curGJackpot);
							
						}
						
						if (usergjack.sUserName == viewer.zid){
							
							var newchipg =Number(usergjack.nTotalPoints)+Number(l__4[l__7].gjackpot);
							usergjack.nTotalPoints = newchipg;
							
							ptView.tableInfo.casinoTf.text = (StringUtility.StringToMoney(newchipg));
						}
					}
				}
				l__11++;
			}
			if (!(l__2.loseJackpot == null) && (l__2.loseJackpot!="undefined")){
			
			var losejack =l__2.loseJackpot.split(",");
			var l__90:Number = 0;

				while(l__90 < losejack.length){
					l__12x = l__12x+losejack[l__90];
					var losejack2 =losejack[l__90].split(":");
					var losejack2u = losejack2[0];
					var losejack2p = losejack2[1];
					if(losejack2p >0){
						ptView.newDealerMessage("<font face=\"Verdana\" color=\"#ffffff\">"+losejack2u+" "+langs.l_win+" "+langs.l_globaljackpot+" ("+StringUtility.StringToMoney(losejack2p)+")"+"</font>", "");
						
						if (losejack2u == viewer.zid){
							
							var chipplayer=Number(ptModel.getPlayerTotalChips(viewer.zid));
						
							
							var textusercoin=Number(losejack2p)+chipplayer;
							ptView.tableInfo.casinoTf.text = (StringUtility.StringToMoney(textusercoin));
							
						}
					
					}
					
					l__90++;
					
				}
			}
			if(l__12x!=""){
				
				ptView.showCongratGJackpot(l__12x,0);
				
			}
			ptView.TriggerJackpot(StringUtility.StringToMoney(l__2.curGJackpot),ptView.mcJackpotGlobal.jackpotTf.text);
			ptView.mcJackpotGlobal.jackpotTf.text = StringUtility.StringToMoney(l__2.curGJackpot);
			if ((l__2.pot - 3) == 0){
				ptView.newDealerMessage("<font face=\"Verdana\" color=\"#ffffff\">"+"________________________"+"</font>", "");
				ptView.newDealerMessage(" ", "");
			}
			dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "sndWinChips"));
		}
		public function getBubbleMessage(p__1:String, p__2:int, p__3:Boolean = false):String
		{
			var l__13:com.script.poker.PokerUser;
			var l__14:int;
			var l__15:String;
			var l__16:String;
			var l__17:String;
			var l__18:String;
			var l__19:String;
			var l__20:String;
			var l__21:String;
			var l__22:String;
			var l__23:String;
			var l__24:String;
			var l__25:String;
			var l__4:Number = p__1.substr(0, 1);
			var l__5:* = "";
			var l__6:String;
			var l__7:String;
			var l__8:String;
			var l__9:String;
			var l__10:String;
			var l__11:String;
			var l__12:String;
			l__13 = ptModel.getUserBySit(p__2);
			
			if (p__2 > -1){
				//l__13 = ptModel.getUserBySit(p__2);
				if (l__13.zid != viewer.zid){
					l__14 == p__2;
				} else {
					l__14 = -1;
				}
				
				var l__27:Number = (l__13.nChips - l__13.nOldChips);
				
			}
			if (l__27 == 0) {
				return false;
			}
			
			var l__26:uint = StringUtility.getUserColor(l__14);
			switch(l__4){
				case 0:
				{
					l__15 = p__1.substr(1, 2);
					l__16 = StringUtility.getCardVal(l__15);
					l__5 = (langs.l_highcard+" " + l__16);
					if (p__3){

						l__5 = ((("<font face=\"Verdana Bold\" color=\"#" + l__26.toString(16)) + "\">") + l__13.sUserName) + "</font> "+langs.l_winpot+" ("+StringUtility.StringToMoney(l__27)+") "+langs.l_with+" "+langs.l_highcard+" "+l__16+".";
			
						//l__5 = StringUtility.formatHtmlString("Win with High Card", {sText:"%userName%", nVar:l__13.sUserName, nSit:l__14}, {sText:"%high%", nVar:l__16});
					}
					break;
				}
				case 1:
				{
					l__10 = p__1.substr(1, 2);
					l__6 = p__1.substr(5, 2);
					l__11 = StringUtility.getCardVal(l__10);
					l__9 = StringUtility.getCardVal(l__6);
					//l__5 = (("Pair of " + l__11) + "\'s");
					l__5 = ((langs.l_pairof+" " + l__11) + "\'s");
					if (p__3){
					
						l__5 = ((("<font face=\"Verdana Bold\" color=\"#" + l__26.toString(16)) + "\">") + l__13.sUserName) + "</font> "+langs.l_winpot+" ("+StringUtility.StringToMoney(l__27)+") "+langs.l_with+" "+langs.l_onepair+" "+langs.l_of+" "+l__11+" "+langs.l_with+" "+l__9+" "+langs.l_kicker+".";
						//l__5 = StringUtility.formatHtmlString("One Pair", {sText:"%userName%", nVar:l__13.sUserName, nSit:l__14}, {sText:"%pair%", nVar:l__11}, {sText:"%kicker%", nVar:l__9});
					}
					break;
				}
				case 2:
				{
					l__17 = p__1.substr(1, 2);
					l__18 = p__1.substr(5, 2);
					l__6 = p__1.substr(9, 2);
					l__19 = StringUtility.getCardVal(l__17);
					l__20 = StringUtility.getCardVal(l__18);
					l__9 = StringUtility.getCardVal(l__6);
					l__5 = ((((l__19 + "\'s") + " & ") + l__20) + "\'s");
					if (p__3){
						l__5 = ((("<font face=\"Verdana Bold\" color=\"#" + l__26.toString(16)) + "\">") + l__13.sUserName) + "</font> "+langs.l_winpot+" ("+StringUtility.StringToMoney(l__27)+") "+langs.l_with+" "+langs.l_twopair+" "+langs.l_of+" "+l__19+" "+langs.l_and+" "+l__20+" "+langs.l_with+" "+l__9+" "+langs.l_kicker+".";
						//l__5 = StringUtility.formatHtmlString("Two Pairs", {sText:"%userName%", nVar:l__13.sUserName, nSit:l__14}, {sText:"%pair1%", nVar:l__19}, {sText:"%pair2%", nVar:l__20}, {sText:"%kicker%", nVar:l__9});
					}
					break;
				}
				case 3:
				{
				
					l__21 = p__1.substr(1, 2);
					l__6 = p__1.substr(7, 2);
					l__12 = StringUtility.getCardVal(l__21);
					l__9 = StringUtility.getCardVal(l__6);
					//l__5 = (("Three " + l__12) + "\'s");
					l__5 = ((langs.l_three+" " + l__12) + "\'s");
					if (p__3){
						l__5 = ((("<font face=\"Verdana Bold\" color=\"#" + l__26.toString(16)) + "\">") + l__13.sUserName) + "</font> "+langs.l_winpot+" ("+StringUtility.StringToMoney(l__27)+") "+langs.l_with+" "+langs.l_threeofakind+" "+langs.l_of+" "+l__12+" "+langs.l_with+" "+l__9+" "+langs.l_kicker+".";
						
						//l__5 = StringUtility.formatHtmlString("Three Of A Kind", {sText:"%userName%", nVar:l__13.sUserName, nSit:l__14}, {sText:"%kid%", nVar:l__12}, {sText:"%kicker%", nVar:l__9});
					}
					break;
				}
				case 4:
				{
					
					l__22 = p__1.substr(1, 2);
					l__23 = StringUtility.getCardVal(l__22);
					l__5 = (langs.l_straightto+" " + l__23);
					if (p__3){
						l__5 = ((("<font face=\"Verdana Bold\" color=\"#" + l__26.toString(16)) + "\">") + l__13.sUserName) + "</font> "+langs.l_winpot+" ("+StringUtility.StringToMoney(l__27)+") "+langs.l_with+" "+langs.l_straight+" "+l__23+".";
						
						//l__5 = StringUtility.formatHtmlString("Straight", {sText:"%userName%", nVar:l__13.sUserName, nSit:l__14}, {sText:"%straight%", nVar:l__23});
					}
					break;
				}
				case 5:
				{
					l__7 = p__1.substr(1, 2);
					l__8 = StringUtility.getCardVal(l__7);
					l__5 = (langs.l_flushto+" " + l__8);
					if (p__3){
						l__5 = ((("<font face=\"Verdana Bold\" color=\"#" + l__26.toString(16)) + "\">") + l__13.sUserName) + "</font> "+langs.l_winpot+" ("+StringUtility.StringToMoney(l__27)+") "+langs.l_with+" "+langs.l_flush+" "+l__8+".";
						
						//l__5 = StringUtility.formatHtmlString("Flush", {sText:"%userName%", nVar:l__13.sUserName, nSit:l__14}, {sText:"%flush%", nVar:l__8});
					}
					break;
				}
				case 6:
				{
					l__6 = p__1.substr(1, 2);
					l__12 = StringUtility.getCardVal(l__6);
					l__10 = p__1.substr(7, 2);
					l__11 = StringUtility.getCardVal(l__10);
					l__5 = (((l__12 + "\'s"+langs.l_over) + l__11) + "\'s");
					if (p__3){
						l__5 = ((("<font face=\"Verdana Bold\" color=\"#" + l__26.toString(16)) + "\">") + l__13.sUserName) + "</font> "+langs.l_winpot+" ("+StringUtility.StringToMoney(l__27)+") "+langs.l_with+" "+langs.l_fullhouse+" "+langs.l_of+" "+l__12+" "+langs.l_and+" "+l__11+"";
						
						//l__5 = StringUtility.formatHtmlString("Full House", {sText:"%userName%", nVar:l__13.sUserName, nSit:l__14}, {sText:"%kid%", nVar:l__12}, {sText:"%pair%", nVar:l__11});
					}
					break;
				}
				case 7:
				{
					l__24 = p__1.substr(1, 2);
					l__25 = StringUtility.getCardVal(l__24);
					l__6 = p__1.substr(9, 2);
					l__9 = StringUtility.getCardVal(l__6);
					l__5 = ((langs.l_four+" " + l__25) + "\'s");
					if (p__3){
						l__5 = ((("<font face=\"Verdana Bold\" color=\"#" + l__26.toString(16)) + "\">") + l__13.sUserName) + "</font> "+langs.l_winpot+" ("+StringUtility.StringToMoney(l__27)+") "+langs.l_with+" "+langs.l_fourofakind+" "+langs.l_of+" "+l__25+" "+langs.l_with+" "+l__9+" "+langs.l_kicker+".";
						
						//l__5 = StringUtility.formatHtmlString("Four Of A Kind", {sText:"%userName%", nVar:l__13.sUserName, nSit:l__14}, {sText:"%careu%", nVar:l__25}, {sText:"%kicker%", nVar:l__9});
					}
					break;
				}
				case 8:
				{
					l__7 = p__1.substr(1, 2);
					l__8 = StringUtility.getCardVal(l__7);
					l__5 = (langs.l_strflush+" " + l__8);
					if (p__3){
						l__5 = ((("<font face=\"Verdana Bold\" color=\"#" + l__26.toString(16)) + "\">") + l__13.sUserName) + "</font> "+langs.l_winpot+" ("+StringUtility.StringToMoney(l__27)+") "+langs.l_with+" "+langs.l_straightflush+" "+l__8+".";
						
						//l__5 = StringUtility.formatHtmlString("Straight Flush", {sText:"%userName%", nVar:l__13.sUserName, nSit:l__14}, {sText:"%flush%", nVar:l__8});
					}
					break;
				}
				case 9:
				{
					l__7 = p__1.substr(1, 2);
					l__8 = StringUtility.getCardVal(l__7);
					l__5 = langs.l_royalflush;
					if (p__3){
						l__5 = ((("<font face=\"Verdana Bold\" color=\"#" + l__26.toString(16)) + "\">") + l__13.sUserName) + "</font> "+langs.l_winpot+" ("+StringUtility.StringToMoney(l__27)+") "+langs.l_with+" "+langs.l_royalflush+".";
						
						//l__5 = StringUtility.formatHtmlString("Royal Flush", {sText:"%userName%", nVar:l__13.sUserName, nSit:l__14});
					}
					break;
				}
			}
			return(l__5);
		}
		public function getWinningHands(p__1:int, p__2:String, p__3:Number, p__4:String, p__5:Number, p__6:String):Object
		{
			var l__9:* = undefined;
			var l__7:Array = p__6.split(" ");
			var l__8:Object = new Object();
			
			for (l__9 in l__7){
			
				if (l__7[l__9] == ""){
					l__7.splice(l__9, 1);
				}
			}
			l__8.sit = p__1;
			l__8.card1 = getPlayerWinningHands(Number(p__2), Number(p__3), l__7);
			l__8.card2 = getPlayerWinningHands(Number(p__4), Number(p__5), l__7);
			l__8.flop1 = getPlayerWinningHands(Number(ptModel.flopCard1.sCard), Number(ptModel.flopCard1.nSuit), l__7);
			l__8.flop2 = getPlayerWinningHands(Number(ptModel.flopCard2.sCard), Number(ptModel.flopCard2.nSuit), l__7);
			l__8.flop3 = getPlayerWinningHands(Number(ptModel.flopCard3.sCard), Number(ptModel.flopCard3.nSuit), l__7);
			l__8.street = getPlayerWinningHands(Number(ptModel.streetCard.sCard), Number(ptModel.streetCard.nSuit), l__7);
			l__8.river = getPlayerWinningHands(Number(ptModel.riverCard.sCard), Number(ptModel.riverCard.nSuit), l__7);
			return(l__8);
		}
		private function getPlayerWinningHands(p__1:*, p__2:*, p__3:*):Boolean
		{
			var l__5:Array;
			var l__4:Number = 0;
			while(l__4 < p__3.length){
				l__5 = p__3[l__4].split("");
				if ((p__1 == StringUtility.getCardVal2(l__5[0])) && (p__2 == StringUtility.getCardSuit(l__5[1]))){
					//if ((p__1 == l__5[0]) && (p__2 == l__5[1])){
					return(true);
				}
				l__4++;
			}
			return(false);
		}
		private function onDefaultWinners(p__1:Object):void
		{
			var l__4:int;
			var l__2:com.script.poker.protocol.RDefaultWinners = RDefaultWinners(p__1);
			ptModel.updateDefaultWinner(l__2.sit, l__2.chips, l__2.pots);
			ptView.showDefaultWinner(l__2.sit, l__2.pots);
			ptView.killClock();
			var l__3:com.script.poker.PokerUser = ptModel.getUserBySit(l__2.sit);
			if (l__3.zid != viewer.zid){
				l__4 = l__3.nSit;
			} else {
				l__4 = -1;
			}
			var l__5:uint = StringUtility.getUserColor(l__4);
			ptView.newDealerMessage(((("<font face=\"Verdana\" color=\"#ffffff\"><font face=\"Verdana Bold\" color=\"#" + l__5.toString(16)) + "\">") + wrapChatZidLink(l__3.zid, l__3.sUserName)) + "</font> "+langs.l_win+"."+"</font>");
			if (l__2.fee > 0) {
			ptView.newDealerMessage("<font face=\"Verdana\" color=\"#ffffff\">"+""+langs.l_fee+" ("+StringUtility.StringToMoney(l__2.fee)+")"+"</font>", "");
			}
			ptView.newDealerMessage("<font face=\"Verdana\" color=\"#ffffff\">"+"________________________"+"</font>", "");
			ptView.newDealerMessage(" ", "");
			ptView.clearBets();
			
		}
		
		private function onAllinWar(p__1:Object):void
		{
			
			var l__2:com.script.poker.protocol.RAllinWar = RAllinWar(p__1);
			var l__3:Array = l__2.hands;
			var l__4:int;
			while(l__4 < l__3.length){
				ptModel.setHoleCards(l__3[l__4].sit, l__3[l__4].card1, l__3[l__4].tip1, l__3[l__4].card2, l__3[l__4].tip2);
				ptView.showHoleCards(l__3[l__4].sit);
				l__4++;
			}
		}
		
		private function onReplayPots(p__1:Object):void
		{
			var l__4:* = undefined;
			var l__5:Boolean;
			var l__2:com.script.poker.protocol.RReplayPots = RReplayPots(p__1);
			var l__3:Array = l__2.pots;
			for (l__4 in l__3){
				l__5 = false;
				if (l__4 == (l__3.length - 1)){
					l__5 = true;
				}
				ptModel.setPot(l__4, l__3[l__4]);
				ptView.replayPot(l__4, l__5);
			}
			runPossibleHands();
		}
		private function onReplayPlayers(p__1:Object):void
		{
			var l__4:* = undefined;
			var l__2:com.script.poker.protocol.RReplayPlayers = RReplayPlayers(p__1);
			var l__3:Array = l__2.sits;
			for (l__4 in l__3){
				ptView.replayUserCards(l__3[l__4]);
				
			}
		}
		private function onMakePot(p__1:Object):void
		{
			var l__4:* = undefined;
			var l__5:Boolean;
			var l__2:com.script.poker.protocol.RMakePot = RMakePot(p__1);
			var l__3:Array = l__2.pots;
			//ptView.killClock();
			//for (var a=0; a<9; a++) {
			ptView.stopAllClock();
			//}
			for (l__4 in l__3){
				l__5 = false;
				if (l__4 == (l__3.length - 1)){
					l__5 = true;
				}
				ptModel.setPot(l__4, l__3[l__4]);
				ptView.makePot(l__4, l__5);
			}
		}
		private function onReceiveChat(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RReceiveChat = RReceiveChat(p__1);
			
			var l__5 = pgData.badWords.toLowerCase();
			var l__10 = l__2.sMessage.toLowerCase();
			//if ()
			var l__6 = l__5.split(",");
			var l__9 = 0;
			for (var l__7=0; l__7<l__6.length; l__7++){
				var l__8 = l__10.indexOf(l__6[l__7]);
				if (l__8 >= 0){
					l__9 = 1;
					break;
				}
			}
			if (l__9 == 1) {				
				return;
			}
			
			ptView.newChatMessage(l__2.sUserName, l__2.sMessage, l__2.sZid);
		}
		private function onGetUsersInRoom(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RGetUsersInRoom = RGetUsersInRoom(p__1);
			ptModel.updateUsersInRoom(l__2.userList);
			dispatchEvent(new TCEvent(TCEvent.USERSINROOM_UPDATED));
		}
		private function onGetUsersWaiting(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RGetUsersWaiting = RGetUsersWaiting(p__1);
			ptModel.updateUsersWaiting(l__2.userList);
			dispatchEvent(new TCEvent(TCEvent.USERSWAITING_UPDATED));
		}
		private function onCheckMuteList(p__1:com.script.poker.table.events.TCEvent):void
		{
			if (isMutePressed){
				isMutePressed = false;
				ptView.showMuteList();
			}
		}
		private function onCheckWaitList(p__1:com.script.poker.table.events.TCEvent):void
		{
			ptView.showWaitList();
			
		}
		private function popupSpecJoin():void
		{
			if (pgData.jsCallType == "fbbridge"){
				pgData.callFBJS("ZY.App.f.showFriendNotPlaying", "");
			} else if (ExternalInterface.available){
				ExternalInterface.call("ZY.App.f.showFriendNotPlaying", "");
			}
		}
		private function popupFriendJoinGone():void
		{
			if (pgData.jsCallType == "fbbridge"){
				pgData.callFBJS("ZY.App.f.showFriendNotAtTable", "");
			} else if (ExternalInterface.available){
				ExternalInterface.call("ZY.App.f.showFriendNotAtTable", "");
			}
		}
		private function onCheckJoinFriend(p__1:com.script.poker.table.events.TCEvent):void
		{
			if (isCheckSpectator){
				isCheckSpectator = false;
				if (ptModel.checkUserInRoom(pgData.joinFriendId)){
					pControl.TrackingHit("FriendsTableSuccessTargetWatching", 5, 14, 2010, 100, "Table Other FriendsTableSuccessTargetWatching o:LiveJoin:2009-05-14", null, 1);
					pControl.TrackingHit("FriendsTableSuccess", 5, 14, 2010, 100, "Table Other FriendsTableSuccess o:LiveJoin:2009-05-14", null, 1);
					popupSpecJoin();
				} else {
					pControl.TrackingHit("FriendsTableNotSuccess", 5, 14, 2010, 100, "Table Other FriendsTableNotSuccess o:LiveJoin:2009-05-14", null, 1);
					popupFriendJoinGone();
				}
			}
		}
		private function onUpdateChips(msg:Object):void
		{
			var i = undefined;
			var obj:Object;
			var tUser:com.script.poker.PokerUser;
			var tMsg:com.script.poker.protocol.RUpdateChips = RUpdateChips(msg);
			var playerChips:Array = tMsg.playerChips;
			for (i in playerChips){
				obj = playerChips[i];
				ptModel.updateUserTotal(obj.sit, obj.chips, obj.total);
				ptView.updateUserTotal(obj.sit);
				tUser = ptModel.getUserBySit(obj.sit);
				if (isSeated() && isMe(tUser.zid)){
					pgData.points = obj.total;
				}
				try {
					pControl.lcBridge.send("onLadderUpdate", ptModel.getUserBySit(obj.sit).zid, ptModel.getUserBySit(obj.sit).nTotalPoints, ptModel.getUserBySit(obj.sit).nAchievementRank, false);
				} catch (e:Error) {
				}
			}
			try {
				pControl.lcBridge.send("onLadderUpdate", "", -1, -1, true);
			} catch (e:Error) {
			}
		}
		private function onBoughtGift(p__1:Object):void
		{
		}
		private function onBoughtGift2(msg:Object):void
		{
			var tMsg:com.script.poker.protocol.RBoughtGift2 = RBoughtGift2(msg);
			var tUserSender:com.script.poker.PokerUser = ptModel.getUserBySit(tMsg.senderSit);
			tUserSender.nChips = tMsg.fromChips;
			tUserSender.nTotalPoints = tMsg.totalChips;
			var tUserTo:com.script.poker.PokerUser = ptModel.getUserBySit(tMsg.toSit);
			ptView.updateUserTotal(tMsg.senderSit);
			if (isMe(tUserSender.zid)) {
				
				ptView.tableInfo.casinoTf.text = ( StringUtility.StringToMoney(tMsg.totalChips));
			}
			//ptView.tableInfo.casinoTf.text = StringUtility.StringToMoney(tMsg.fromChips)
			try {				
				pControl.lcBridge.send("onLadderUpdate", ptModel.getUserBySit(tMsg.senderSit).zid, ptModel.getUserBySit(tMsg.senderSit).nTotalPoints, ptModel.getUserBySit(tMsg.senderSit).nAchievementRank, false);
			} catch (e:Error) {
			}
			try {
				pControl.lcBridge.send("onLadderUpdate", "", -1, -1, true);
			} catch (e:Error) {
			}
			if (!isViewerAllowedToSeeGiftId(tMsg.giftId)){
				return;
			}
			var oGift:com.script.poker.table.GiftItem = GiftLibrary.GetInst().GetGift(tMsg.giftId);
			if (oGift == null){
				return;
			}
			ptView.sendGift2(tMsg.senderSit, tMsg.toSit, tMsg.giftId);
			var dealerMsg:String = "";
			/*if (isMe(tUserTo.zid)){
				if (tMsg.senderSit == tUserTo.nSit){
					dealerMsg = StringUtility.FormatString(pgData.config["dealer"]["gift_to_self"], {sText:"%gift%", nVar:oGift.msActionText});
				} else {
					dealerMsg = StringUtility.formatHtmlString(pgData.config["dealer"]["gift_from_other"], {sText:"%sender%", nVar:wrapChatZidLink(tUserSender.zid, tUserSender.sUserName), nSit:tMsg.senderSit}, {sText:"%gift%", nVar:oGift.msActionText});
				}
			} else if (tMsg.senderSit != tMsg.toSit){
				if (isMe(tUserSender.zid)){
					dealerMsg = StringUtility.formatHtmlString(pgData.config["dealer"]["gift_to_other"], {sText:"%receiver%", nVar:wrapChatZidLink(tUserTo.zid, tUserTo.sUserName), nSit:tMsg.toSit}, {sText:"%gift%", nVar:oGift.msActionText});
				} else {
					dealerMsg = StringUtility.formatHtmlString(pgData.config["dealer"]["other_gift_to_other"], {sText:"%sender%", nVar:wrapChatZidLink(tUserSender.zid, tUserSender.sUserName), nSit:tMsg.senderSit}, {sText:"%receiver%", nVar:wrapChatZidLink(tUserTo.zid, tUserTo.sUserName), nSit:tMsg.toSit}, {sText:"%gift%", nVar:oGift.msActionText});
				}
			} else {
				dealerMsg = StringUtility.formatHtmlString(pgData.config["dealer"]["other_gift_to_self"], {sText:"%sender%", nVar:wrapChatZidLink(tUserSender.zid, tUserSender.sUserName), nSit:tMsg.senderSit}, {sText:"%gift%", nVar:oGift.msActionText});
			}*/
			//ptView.newDealerMessage(dealerMsg);
			
			
		}
		private function onUserGifts(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RUserGifts = RUserGifts(p__1);
			dispatchEvent((new GiftPopupEvent("showDrinkMenu", l__2.sit, l__2.gifts)) as PopupEvent);
		}
		private function onUserGifts2(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RUserGifts2 = RUserGifts2(p__1);
			dispatchEvent((new GiftPopupEvent("showDrinkMenu", l__2.sit, l__2.gifts)) as PopupEvent);
		}
		private function onGiftShown(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RGiftShown = RGiftShown(p__1);
			var l__3:com.script.poker.PokerUser = ptModel.getUserBySit(l__2.sit);
			l__3.nGiftNum = l__2.giftNo;
			l__3.nGiftType = l__2.giftType;
			if (isGiftAllowed(l__2.giftType)){
				ptView.updateUserGift(l__2.sit, l__2.giftType, l__2.giftNo);
			} else {
				ptView.updateUserGift(l__2.sit, -1, -1);
			}
		}
		private function onGiftShown2(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RGiftShown2 = RGiftShown2(p__1);
			var l__3:com.script.poker.PokerUser = ptModel.getUserBySit(l__2.sit);
			l__3.nGiftId = l__2.giftId;
			ptView.updateUserGift2(this.pgData.nHideGifts, l__2.sit, l__2.giftId);
		}
		
		private function onBoughtEmo(msg:Object):void
		{
			var tMsg:com.script.poker.protocol.RBoughtEmo = RBoughtEmo(msg);
			var tUserSender:com.script.poker.PokerUser = ptModel.getUserBySit(tMsg.senderSit);
			//tUserSender.nChips = tMsg.fromChips;
			var tUserTo:com.script.poker.PokerUser = ptModel.getUserBySit(tMsg.toSit);
			ptView.updateUserTotal(tMsg.senderSit);
			trace("lewat samapai sin2i");
			try {
				
				pControl.lcBridge.send("onLadderUpdate", ptModel.getUserBySit(tMsg.senderSit).zid, ptModel.getUserBySit(tMsg.senderSit).nTotalPoints, ptModel.getUserBySit(tMsg.senderSit).nAchievementRank, false);
			} catch (e:Error) {
			}
			try {
				pControl.lcBridge.send("onLadderUpdate", "", -1, -1, true);
			} catch (e:Error) {
			}
			if (!isViewerAllowedToSeeGiftId(tMsg.emoId)){
				return;
			}
			var oEmo:com.script.poker.table.EmoItem = EmoLibrary.GetInst().GetEmo(tMsg.emoId);
			if (oEmo == null){
				return;
			}
			trace("lewat samapai sini");
			ptView.sendEmo(tMsg.senderSit, tMsg.toSit, tMsg.emoId, tMsg.emoStr);
			var dealerMsg:String = "";
			/*if (isMe(tUserTo.zid)){
				if (tMsg.senderSit == tUserTo.nSit){
					dealerMsg = StringUtility.FormatString(pgData.config["dealer"]["gift_to_self"], {sText:"%gift%", nVar:oGift.msActionText});
				} else {
					dealerMsg = StringUtility.formatHtmlString(pgData.config["dealer"]["gift_from_other"], {sText:"%sender%", nVar:wrapChatZidLink(tUserSender.zid, tUserSender.sUserName), nSit:tMsg.senderSit}, {sText:"%gift%", nVar:oGift.msActionText});
				}
			} else if (tMsg.senderSit != tMsg.toSit){
				if (isMe(tUserSender.zid)){
					dealerMsg = StringUtility.formatHtmlString(pgData.config["dealer"]["gift_to_other"], {sText:"%receiver%", nVar:wrapChatZidLink(tUserTo.zid, tUserTo.sUserName), nSit:tMsg.toSit}, {sText:"%gift%", nVar:oGift.msActionText});
				} else {
					dealerMsg = StringUtility.formatHtmlString(pgData.config["dealer"]["other_gift_to_other"], {sText:"%sender%", nVar:wrapChatZidLink(tUserSender.zid, tUserSender.sUserName), nSit:tMsg.senderSit}, {sText:"%receiver%", nVar:wrapChatZidLink(tUserTo.zid, tUserTo.sUserName), nSit:tMsg.toSit}, {sText:"%gift%", nVar:oGift.msActionText});
				}
			} else {
				dealerMsg = StringUtility.formatHtmlString(pgData.config["dealer"]["other_gift_to_self"], {sText:"%sender%", nVar:wrapChatZidLink(tUserSender.zid, tUserSender.sUserName), nSit:tMsg.senderSit}, {sText:"%gift%", nVar:oGift.msActionText});
			}*/
			//ptView.newDealerMessage(dealerMsg);
		}
		
		private function onBuddyRequest(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RBuddyRequest = RBuddyRequest(p__1);
			ptView.incomingBI(l__2.zid);
			var l__3:com.script.poker.PokerUser = ptModel.getUserByZid(l__2.zid);
			var l__4:com.script.poker.table.BuddyInvite = new BuddyInvite(l__2.shoutId, l__2.zid, l__2.name, l__3.sPicURL);
			pgData.addBuddyInvite(l__4);
			updateInbox();
		}
		private function onNewBuddy(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RNewBuddy = RNewBuddy(p__1);
			//var l__3:String = StringUtility.FormatString(pgData.config["dealer"]["poker_buddy"], {sText:"%userName%", nVar:wrapChatZidLink(l__2.zid, l__2.name)});
			
			var l__3:String = StringUtility.FormatString("%userName% is now your Friend", {sText:"%userName%", nVar:wrapChatZidLink(l__2.zid, l__2.name)});
			//var l__3:String = = ((("<font face=\"Verdana\" color=\"#ffffff\"><font face=\"Verdana Bold\" color=\"#" + l__6.toString(16)) + "\">") + wrapChatZidLink(l__3.zid, l__3.name)) + "</font> folded</font>";
			
			ptView.newDealerMessage(l__3);
		}
		public function onAddBuddy(p__1:String):void
		{
			ptView.outgoingBI(p__1);
		}
		private function onCardOptions(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RCardOptions = RCardOptions(p__1);
			var l__3:String = l__2.zid;
			var l__4:String = l__2.msgType;
			var l__5:Boolean = false;
			if (l__4 == "addBuddy"){
				if ((((!isMe(l__3)) && isSeated(l__3)) && isSeated()) && (!isFriend(l__3))){
					l__5 = true;
				}
			}
			var l__6:com.script.poker.PokerUser = ptModel.getUserByZid(l__3);
			var l__7:Array = new Array();
			l__7.push(l__6);
			
			var popObj = new Object();
			popObj.type = "showBaseballCard"
			popObj.pokus = l__7;
			popObj.popev = l__5;
			pControl.regPopup(popObj);
			
			//dispatchEvent((new UserPopupEvent("showBaseballCard", l__7, l__5)) as PopupEvent);
		}
		private function isFriend(p__1:String):Boolean
		{
			var l__2:int;
			while(l__2 < pgData.aFriendZids.length){
				
				if (pgData.aFriendZids[l__2] == p__1){
					return(true);
				}
				l__2++;
			}
			return(false);
		}
		private function onMuteMod(p__1:com.script.poker.table.events.view.TVEMuteMod):void
		{
			ptModel.muteToggle(p__1.zid, p__1.action);
		}
		private function onInvitePressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			if (isSeated()){
				//dispatchEvent(new PopupEvent("showBuddyDialog"));
				var popObj = new Object();
				popObj.type = "showBuddyDialog"
				popObj.nSit = 0;
				pControl.regPopup(popObj);
			}
		}
		private function onJoinRoom(p__1:Object):void
		{			
			trace ("nothing happen")
		}
		private function onJoinRoomError(p__1:Object):void
		{			
		var l__1:Object = new Object();
			l__1.type = "onErrorPopup";
			l__1.upper = "Error Join Room";
			l__1.mess = langs.l_roomfailed;
			
			//popupControl.regonErrorPopup(l__1);
			pControl.regErrorPopup(l__1);
		}
		private function onSendGiftChips(msg:Object):void
		{
			var tSit:int;
			var tSit2:int;
			var tMsg:com.script.poker.protocol.RSendGiftChips = RSendGiftChips(msg);
			var fromName:String = ptModel.getUserBySit(tMsg.fromSit).sUserName;
			var toName:String = ptModel.getUserBySit(tMsg.toSit).sUserName;
			var amt:Number = tMsg.amount;
			var tUser:com.script.poker.PokerUser = ptModel.getUserBySit(tMsg.fromSit);
			tUser.nChips = tMsg.fromChips;
			ptView.updateUserTotal(tMsg.fromSit);
			var tUser2 = ptModel.getUserBySit(tMsg.toSit);
			tUser2.nChips = tMsg.toChips;
			ptView.updateUserTotal(tMsg.toSit);
			ptView.sendChips(amt, tMsg.fromSit, tMsg.toSit);
			var tViewer:com.script.poker.PokerUser = ptModel.getUserByZid(viewer.zid);
			if ((tUser == tViewer) && (pgData.sn_id == 1)){
				//fireFBFeedChipGift(tUser2.zid);
			}
			if (tUser.zid != viewer.zid){
				tSit = tUser.nSit;
			} else {
				tSit = -1;
			}
			if (tUser2.zid != viewer.zid){
				tSit2 = tUser2.nSit;
			} else {
				tSit2 = -1;
			}
			var dealerMsg:String = StringUtility.FormatString(pgData.config["dealer"]["give_chips"], {sText:"%fromUserName%", nVar:wrapChatZidLink(ptModel.getUserBySit(tMsg.fromSit).zid, fromName), nSit:tSit}, {sText:"%toUserName%", nVar:wrapChatZidLink(ptModel.getUserBySit(tMsg.toSit).zid, toName), nSit:tSit2}, {sText:"%amt%", nVar:amt});
			ptView.newDealerMessage(dealerMsg);
			if (tSit != -1){
				try {
					pControl.lcBridge.send("onLadderUpdate", ptModel.getUserBySit(tSit).zid, ptModel.getUserBySit(tSit).nTotalPoints, ptModel.getUserBySit(tSit).nAchievementRank, false);
				} catch (e:Error) {
				}
			}
			if (tSit2 != -1){
				try {
					pControl.lcBridge.send("onLadderUpdate", ptModel.getUserBySit(tSit2).zid, ptModel.getUserBySit(tSit2).nTotalPoints, ptModel.getUserBySit(tSit2).nAchievementRank, false);
				} catch (e:Error) {
				}
			}
			try {
				pControl.lcBridge.send("onLadderUpdate", "", -1, -1, true);
			} catch (e:Error) {
			}
		}
		private function fireFBFeedChipGift(inZid:String):void
		{
			var passZid:String;
			var oneLine:String;
			var feedPause:flash.utils.Timer;
			passZid = inZid;
			if (pgData.bFbFeedAllow){
				var spawnFeed = function(p__1:flash.events.TimerEvent):void
				{
					feedPause.stop();
					feedPause = null;
					pgData.JSCall_BaseballCardFeed(pgData.kJS_BASEBALLCARDFEED_GAVECHIPS, -1, passZid, oneLine);
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
		public function onBuyinError(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RBuyinError = RBuyinError(p__1);
			var l__3:String = pgData.config["buyinerror"]["title"];
			var l__4:String = StringUtility.StringToMoney(l__2.chips.toString());
			var l__5:String = StringUtility.FormatString(pgData.config["buyinerror"]["message"], {sText:"%chips%", nVar:l__4});
			dispatchEvent(new ErrorPopupEvent("onErrorPopup", l__3, l__5));
		}
		public function onUserVip(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RUserVip = RUserVip(p__1);
			var l__3:com.script.poker.PokerUser = ptModel.getUserByZid(l__2.zid);
			l__3.bIsVip = (l__2.hideFlag == 0) ? false : true;
			ptView.showUserVIP(l__2.zid);
		}
		public function getMaxGiftSend()
		{
			var l__1:Number = 1000;
			if (l__1 <= (ptModel.nBigblind * 20)){
			} else {
				l__1 = ptModel.nBigblind * 20;
			}
			return(l__1);
		}
		public function checkValidGift(p__1:Number):Boolean
		{
			if ((((p__1 > 0) && (p__1 <= 1000)) && (p__1 <= ((ptModel.nBigblind * 20)))) && (ptModel.getPlayerTotalChips(viewer.zid) > p__1)){
				return(true);
			}
			return(false);
		}
		public function startGiveChipsTimer():void
		{
			if (giveChipsTimer == null){
				giveChipsTimer = new Timer(pgData.GIVE_CHIPS_TIME);
				giveChipsTimer.addEventListener(TimerEvent.TIMER, onGiveChips);
				giveChipsTimer.start();
			}
			bGiveChips = false;
		}
		public function stopGiveChipsTimer():void
		{
			if (giveChipsTimer != null){
				giveChipsTimer.stop();
				giveChipsTimer.removeEventListener(TimerEvent.TIMER, onGiveChips);
				giveChipsTimer = null;
			} 
			bGiveChips = true;
		}/*  */
		private function onGiveChips(p__1:flash.events.TimerEvent):void
		{
			bGiveChips = true;
		}
		public function getProfileURL(p__1:String):String
		{
			var l__2:* = "";
			if (ptModel.getUserByZid(p__1) != null){
				l__2 = ptModel.getUserByZid(p__1).sProfileURL;
			}
			return(l__2);
		}
		public function isMe(p__1:String):Boolean
		{
			if (p__1 == viewer.zid){
				return(true);
			}
			return(false);
		}
		public function isSeated(p__1:String = ""):Boolean
		{
			var l__2:String = (p__1.length == 0) ? viewer.zid : p__1;
			if (ptModel.getUserByZid(l__2) != null){
				return(true);
			}
			return(false);
		}
		public function getCardOptions(p__1:String):void
		{
			var l__2:com.script.poker.protocol.SGetCardOptions = new SGetCardOptions("SGetCardOptions", p__1);
			pcmConnect.sendMessage(l__2);
		}
		public function getPlayerChips(p__1:Boolean = false):Number
		{
			if (p__1){
				return(ptModel.getPlayerTotalChips(viewer.zid));
			}
			return(ptModel.getPlayerChips(viewer.zid));
		}
		public function updateInbox():void
		{
			ptModel.aBuddyInvites = pgData.aBuddyInvites;
			ptView.updateInbox();
		}
		private function dealCardSound(p__1:com.script.poker.table.events.TVEvent):void
		{
			dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, "playSound_Deal"));
		}
		public function isViewerAllowedToSeeGiftId(p__1:Number):Boolean
		{
			if (pgData.nHideGifts == 0){
				return(true);
			}
			var l__2:com.script.poker.table.GiftItem = GiftLibrary.GetInst().GetGift(p__1);
			if (l__2 == null){
				return(true);
			}
			if (l__2.mbUserFilter){
				return(false);
			}
			return(true);
		}
		private function onRefillPoints(p__1:Object):void
		{
			
			var l__2:com.script.poker.protocol.RRefillPoints = RRefillPoints(p__1);
			var l__3:String = pgData.config["refillpoints"]["title"];
			var l__4:String = StringUtility.FormatString(pgData.config["refillpoints"]["message"], {sText:"%chips%", nVar:l__2.refillPoints});
			if (l__2.remaining >= 1){
				l__4 = StringUtility.FormatString(pgData.config["refillpoints"]["message1"], {sText:"%remaining%", nVar:l__2.remaining});
			} else {
				l__4 = pgData.config["refillpoints"]["message2"];
			}
			dispatchEvent(new ErrorPopupEvent("onErrorPopup", l__3, l__4));
		}
		public function onPlaySoundOnce(p__1:com.script.poker.table.events.view.TVEPlaySound):void
		{
			if ((p__1.sEvent == "PlayRemindSound") || (p__1.sEvent == "playHurrySound")){
				
				if (isSeated() && (int(p__1.nSit) == int(ptModel.getUserByZid(viewer.zid).nSit))){
					
					dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, p__1.sEvent));
				}
			}
			if (p__1.sEvent == "playSound_Deal"){
				dispatchEvent(new PokerSoundEvent(TCEvent.PLAY_SOUND_ONCE, p__1.sEvent));
			}
		}
		public function onToggleMuteSoundPressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			pgData.bTableSoundMute = Boolean(p__1.bMute);
			dispatchEvent(new TCEMuteSound(TCEvent.TOGGLE_MUTE_SOUND, Boolean(p__1.bMute)));
		}
		public function onIphonePressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			dispatchEvent(new PopupEvent("showIphonePromo"));
		}
		public function onVipBadgePressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			pControl.chooseVipPopup();
		}
		public function onGoToLobby(p__1:Object):void
		{
			
			var l__2:com.script.poker.protocol.RGoToLobby = RGoToLobby(p__1);
			stopGiveChipsTimer();
			
			
			if (mainDisp.getChildByName("tabview") != null) {
				ptView.updateBuyJackpot();
				mainDisp.removeChild(ptView);
				
			}
			
			if (ptView != "null" && ptView != null){
			removeViewListeners();
			}
			
			disableProtocol();
			dispatchEvent(new TCEvent(TCEvent.STOP_SOUND));
			//dispatchEvent(new TCEvent(TCEvent.LEAVE_TABLE));
		}
		public function onBuyIn(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RBuyIn = RBuyIn(p__1);
			tourneySit(l__2.sit, l__2.points);
		}
		public function tourneySit(p__1:int, p__2:Number):void
		{			
			var l__3:com.script.poker.protocol.SSit = new SSit("SSit", p__2, p__1);
			pcmConnect.sendMessage(l__3);
		}
		public function tableJoin(p__1:Object):void
		{			
			ptView.requestJoinUser(p__1["uid"], p__1["server_id"], p__1["room_id"]);
		}
		public function onJoinUserPressed(p__1:com.script.poker.table.events.view.TVEJoinUserPressed):void
		{
			//var l__2:String = pControl.loadBalancer.getServerType(p__1.nServerId);
			
			if (pgData.gameRoomId == p__1.nRoomId){
				dispatchEvent(new ErrorPopupEvent("onErrorPopup", "Hold\'em Message", "Your friend is currently at this table!"));
			} else {
				//pControl.updateLobbyTabs(l__2);
				pControl.updateLobbyTabs("normal");
				ptView.cleanupTable();
				stopGiveChipsTimer();
				mainDisp.removeChild(ptView);
				removeViewListeners();
				//disableProtocol();
				pgData.nNewRoomId = p__1.nRoomId;
				pgData.newServerId = p__1.nServerId;
				pgData.joiningContact = true;
				pgData.joiningShootout = false;
				dispatchEvent(new TCEvent(TCEvent.STOP_SOUND));
				dispatchEvent(new TCEvent(TCEvent.LEAVE_TABLE));
				//pcmConnect.disconnect();
				
			
			}
		}
		public function onRefreshJoinUserPressed(p__1:com.script.poker.table.events.view.TVERefreshJoinUserPressed):void
		{
			var l__2:Number = 0;
			var l__3:Number = 0;
			if (p__1.nAction == "friends"){
				if (pgData.connectToZoom != 1){
					onLoadUserPresenceFriends();
				} else if (pgData.useZoomForFriends == 1){
					ptModel.aJoinFriends.splice(0);
					l__2 = 0;
					while(l__2 < pControl.zoomModel.friendsList.length){
						ptModel.aJoinFriends.push(pControl.zoomModel.friendsList[l__2]);
						l__2++;
					}
					ptView.refreshJoinUser("friends");
				} else {
					onLoadUserPresenceFriends();
				}
			} else if (p__1.nAction == "networks"){
				if (pgData.connectToZoom != 1){
					onLoadUserPresenceNetwork();
				} else if (pgData.useZoomForNetwork == 1){
					ptModel.aJoinNetworks.splice(0);
					l__3 = 0;
					while(l__3 < pControl.zoomModel.networkList.length){
						ptModel.aJoinNetworks.push(pControl.zoomModel.networkList[l__3]);
						l__3++;
					}
					ptView.refreshJoinUser("networks");
				} else {
					onLoadUserPresenceNetwork();
				}
			}
		}
		public function onLoadUserPresenceFriends():void
		{
			var l__1:Object = new Object();
			l__1.friend_ids = pgData.aFriendZids.toString();
			var l__2:com.script.io.LoadUrlVars = new LoadUrlVars();
			l__2.addEventListener(URLEvent.onLoaded, onUserPresenceFriendsLoaded);
			l__2.loadURL((pgData.presence_url + "get_friends_presence.php"), l__1, "POST");
		}
		public function onLoadUserPresenceNetwork():void
		{
			var l__1:Object = new Object();
			l__1.uid = viewer.zid;
			var l__2:com.script.io.LoadUrlVars = new LoadUrlVars();
			l__2.addEventListener(URLEvent.onLoaded, onUserPresenceNetworkLoaded);
			l__2.loadURL((pgData.presence_url + "get_networks_presence.php"), l__1, "POST");
		}
		public function onUserPresenceFriendsLoaded(p__1:flash.events.Event):void
		{
			var l__2:Array = new Array();
			if (p__1.target != null){
				l__2 = onUpdateUserPresence(p__1.target);
			}
			ptModel.aJoinFriends.splice(0);
			ptModel.aJoinFriends = l__2;
			ptView.refreshJoinUser("friends");
		}
		public function onUserPresenceNetworkLoaded(p__1:flash.events.Event):void
		{
			var l__2:Array = new Array();
			if (p__1.target != null){
				l__2 = onUpdateUserPresence(p__1.target);
			}
			ptModel.aJoinNetworks.splice(0);
			ptModel.aJoinNetworks = l__2;
			ptView.refreshJoinUser("networks");
		}
		public function onUpdateUserPresence(p__1:Object):Array
		{
			var l__5:Array;
			var l__6:String;
			var l__7:Number = 0;
			var l__8:Number = 0;
			var l__9:Number = 0;
			var l__10:String;
			var l__11:String;
			var l__12:String;
			var l__13:String;
			var l__14:String;
			var l__2:Array = p__1.data.toString().split("\n");
			var l__3:Array = new Array();
			var l__4:int;
			while(l__4 < (l__2.length - 1)){
				l__5 = l__2[l__4].split("|");
				l__6 = l__5[0];
				l__7 = l__5[1];
				l__8 = l__5[2];
				l__9 = l__5[3];
				l__10 = l__5[4];
				l__11 = l__5[5];
				l__12 = l__5[6];
				l__13 = pControl.loadBalancer.getServerType(l__8);
				if (!(l__13 == "tourney") && (l__13.length > 0)){
					l__14 = pControl.getNetworkUserStatus(l__8, l__13, l__9);
					if (l__10 == "undefined"){
						l__10 = "";
					}
					if (l__11 == "undefined"){
						l__11 = "";
					}
					if (l__6 != viewer.zid){
						if (!isNaN(l__8)){
							l__3.push(new UserPresence(l__6, l__7, l__8, l__9, l__14, l__10, l__11, l__12, "", "", ""));
						}
					}
				}
				l__4++;
			}
			return(l__3);
		}
		
		private function record(p__1:String):void
		{
			var l__2:com.script.io.LoadUrlVars;
			if (pgData.trace_stats == 1){
				l__2 = new LoadUrlVars();
				l__2.loadURL(p__1, {}, "POST");
			}
		}
		private function onBlindChange(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RBlindChange = RBlindChange(p__1);
			ptModel.updateBlinds(l__2.blind / 2, l__2.blind);
			ptView.updateBlinds();
			//pControl.zoomUpdateStakes(ptModel.formatBlinds(l__2.blind / 2, l__2.blind), pgData.gameRoomId);
		}
		private function onPointsUpdate(p__1:Object):void
		{			
			var l__2:com.script.poker.protocol.RPointsUpdate = RPointsUpdate(p__1);
			pgData.points = l__2.points;
			pgData.deposit = l__2.deposit;
			if(ptView!="null" && ptView!=null){
				if (!isNaN(l__2.sitn)){
					var l__3:com.script.poker.PokerUser = ptModel.getUserBySit(l__2.sitn);
					l__3.nTotalPoints = l__2.currentpoints;
					ptView.tableInfo.casinoTf.text = ( StringUtility.StringToMoney(l__3.nTotalPoints));
					
				}else{
					ptView.tableInfo.casinoTf.text = ( StringUtility.StringToMoney(pgData.points));
					if(clicksit == 1){
						var popObj = new Object();
						popObj.type = "showTableBuyIn"
						popObj.nSit = thissit;
						pControl.regPopup(popObj);
						clicksit=0;
					}
				}
				
			}
		}
		private function onGlobalJackpotUpdate(p__1:Object):void
		{			
			var l__2:com.script.poker.protocol.RGlobalJackpotUpdate = RGlobalJackpotUpdate(p__1);
			ptView.TriggerJackpot(StringUtility.StringToMoney(l__2.gjackpot),ptView.mcJackpotGlobal.jackpotTf.text);
			ptView.mcJackpotGlobal.jackpotTf.text= StringUtility.StringToMoney(l__2.gjackpot);
			
		}
		private function onBetSliderPressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			var l__2:String = pgData.GetSignedTrackingUrl("o:Table:BetSlider:2009-03-17");
			if (l__2 != ""){
				record(l__2);
			}
		}
		private function onBetPlusPressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			var l__2:String = pgData.GetSignedTrackingUrl("o:Table:BetPlus:2009-03-17");
			if (l__2 != ""){
				record(l__2);
			}
		}
		private function onBetMinusPressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			var l__2:String = pgData.GetSignedTrackingUrl("o:Table:BetMinus:2009-03-17");
			if (l__2 != ""){
				record(l__2);
			}
		}
		private function onBetInputPressed(p__1:com.script.poker.table.events.TVEvent):void
		{
			var l__2:String = pgData.GetSignedTrackingUrl("o:Table:BetInput:2009-03-17");
			if (l__2 != ""){
				record(l__2);
			}
		}
		public function onBuyDrinksPressed(p__1:Boolean = false):void
		{
			var l__2:String = pgData.GetSignedTrackingUrl("o:Table:BuyDrink:2009-03-17");
			if (p__1){
				l__2 = pgData.GetSignedTrackingUrl("o:Table:BuyDrinksTable:2009-03-17");
			}
			if (l__2 != ""){
				record(l__2);
			}
		}
		public function onBuyEmoPressed(p__1:Boolean = false):void
		{
			var l__2:String = pgData.GetSignedTrackingUrl("o:Table:BuyEmo:2009-03-17");
			if (p__1){
				l__2 = pgData.GetSignedTrackingUrl("o:Table:BuyEmoTable:2009-03-17");
			}
			if (l__2 != ""){
				record(l__2);
			}
		}
		private function onAchieved(p__1:Object):void
		{
			var l__4:int;
			var l__5:String;
			var l__6:uint;
			var l__2:com.script.poker.protocol.RAchieved = RAchieved(p__1);
			var l__3:com.script.poker.PokerUser = ptModel.getUserBySit(l__2.nSit);
			if (!(l__3 == null) && (l__3.zid == l__2.sZid)){
				l__4 = l__2.nSit;
				l__3.nTotalPoints = l__2.nPoints;
				if (l__2.sZid == viewer.zid){
					l__4 = -1;
					if (pgData.jsCallType == "fbbridge"){
						pgData.callFBJS("open_shout", l__2.nAchievmentId);
					} else if (ExternalInterface.available){
						ExternalInterface.call("open_shout", l__2.nAchievmentId);
					}
				}
				l__5 = StringUtility.formatHtmlString(pgData.config["dealer"]["achievement_earned"], {sText:"%userName%", nVar:wrapChatZidLink(l__3.zid, l__3.sUserName), nSit:l__4}, {sText:"%achievment%", nVar:l__2.sAchievmentName}, {sText:"%award%", nVar:l__2.nRewardBonus});
				if (l__2.nRewardBonus == 0){
					l__5 = l__5.substr(0, (l__5.length - 17));
				}
				l__6 = StringUtility.getUserColor(l__4);
				l__5 = StringUtility.addFontTag(l__5, "Verdana", l__6);
				ptView.newDealerMessage(l__5);
			}
		}
		private function onRAlert(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RAlert = RAlert(p__1);
			if (pgData.jsCallType == "fbbridge"){
				pgData.callFBJS("open_alert", l__2.oJSON);
			} else if (ExternalInterface.available){
				ExternalInterface.call("open_alert", l__2.oJSON);
			}
		}
		private function initZoomModelListeners():void
		{
			/*if (pgData.connectToZoom != 1){
				return;
			}*/
			
			pControl.zoomModel.addEventListener(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED, onZoomModelFriendsUpdate);
		}
		private function removeZoomModelListeners():void
		{
			if (pgData.connectToZoom != 1){
				return;
			}
			pControl.zoomModel.removeEventListener(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED, onZoomModelFriendsUpdate);
		}
		private function onZoomModelFriendsUpdate(p__1:com.script.zoom.ZshimModelEvent):void
		{
			
			if (pgData.useZoomForFriends != 1){
				return;
			}
			
			ptModel.aJoinFriends.splice(0);
			var l__2:Number = 0;
			while(l__2 < p__1.playerList.length){
				ptModel.aJoinFriends.push(p__1.playerList[l__2]);
				l__2++;
			}
			ptView.refreshJoinUser("friends");
		}
		private function onZoomModelNetworkUpdate(p__1:com.script.zoom.ZshimModelEvent):void
		{
			if (pgData.useZoomForNetwork != 1){
				return;
			}
			ptModel.aJoinNetworks.splice(0);
			var l__2:Number = 0;
			while(l__2 < p__1.playerList.length){
				ptModel.aJoinNetworks.push(p__1.playerList[l__2]);
				l__2++;
			}
			ptView.refreshJoinUser("networks");
		}
		private function onZoomUpdate():void
		{
			var l__1:Number = 0;
			var l__2:com.script.poker.UserPresence;
			var l__3:Number = 0;
			var l__4:com.script.poker.UserPresence;
			if (pgData.connectToZoom != 1){
				return;
			}
			if (pgData.useZoomForFriends == 1){
				ptModel.aJoinFriends.splice(0);
				l__1 = 0;
				while(l__1 < pControl.zoomModel.friendsList.length){
					l__2 = pControl.zoomModel.friendsList[l__1];
					l__2.sRoomDesc = pControl.getNetworkUserStatus(l__2.nServerId, pControl.loadBalancer.getServerType(l__2.nServerId), l__2.nRoomId);
					ptModel.aJoinFriends.push(l__2);
					l__1++;
				}
				ptView.refreshJoinUser("friends");
			}
			if (pgData.useZoomForNetwork == 1){
				ptModel.aJoinNetworks.splice(0);
				l__3 = 0;
				while(l__3 < pControl.zoomModel.networkList.length){
					l__4 = pControl.zoomModel.networkList[l__3];
					l__4.sRoomDesc = pControl.getNetworkUserStatus(l__4.nServerId, pControl.loadBalancer.getServerType(l__4.nServerId), l__4.nRoomId);
					l__4.sRelationship = pControl.getNetworkName(l__4.sNetworkIds);
					ptModel.aJoinNetworks.push(l__4);
					l__3++;
				}
				ptView.refreshJoinUser("networks");
			}
		}
		private function isFriendPlaying():Boolean
		{
			var l__1:int;
			if (pgData.aFriendZids.length > 0){
				l__1 = 0;
				while(l__1 < pgData.aFriendZids.length){
					if (ptModel.getUserByZid(pgData.aFriendZids[l__1]) != null){
						return(true);
					}
					l__1++;
				}
			}
			return(false);
		}
		private function isFriendPlayingCount():Number
		{
			var l__2:int;
			var l__1:Number = 0;
			if (pgData.aFriendZids.length > 0){
				l__2 = 0;
				while(l__2 < pgData.aFriendZids.length){
					if (ptModel.getUserByZid(pgData.aFriendZids[l__2]) != null){
						l__1++;
					}
					l__2++;
				}
			}
			return(l__1);
		}
		private function runPossibleHands():void
		{
			var l__3:String;
			var l__4:Array;
			var l__5:* = undefined;
			var l__6:Object;
			var l__1:Array = [ptModel.holeCard1, ptModel.holeCard2, ptModel.flopCard1, ptModel.flopCard2, ptModel.flopCard3, ptModel.streetCard, ptModel.riverCard];
			var l__2:* = "";
			if (!(ptModel.holeCard1 == null) && !(ptModel.holeCard2 == null)){
				if (!(ptModel.holeCard1.nSuit == -1) && !(ptModel.holeCard2.nSuit == -1)){
					l__4 = new Array();
					for (l__5 in l__1){
						if (l__1[l__5] != null){
							l__6 = new Object();
							l__6.suit = Number(l__1[l__5].nSuit);
							l__6.rank = Number(l__1[l__5].sCard);
							l__6.used = 0;
							l__4.push(l__6);
						}
					}
					l__3 = PossibleHands.run(l__4);
					l__2 = getBubbleMessage(l__3, -1);
					ptView.updateHandStrength(l__3.substr(0, 1), l__2);
				}
			} else {
				ptView.handCtrl.hideMe(true);
			}
		}
		private function onShootoutBuyinChanged(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RShootoutBuyinChanged = RShootoutBuyinChanged(p__1);
			var l__3:* = (((("The Buy-in amounts for this Shootout tournament have changed from " + l__2.nOldBuyIn) + " to ") + l__2.nNewBuyIn) + "! Don\'t worry, we have exempted you from the higher amount or refunded your initial Buy-in.");
			dispatchEvent(new ErrorPopupEvent("onErrorPopup", "Buy-ins Changed", l__3));
		}
		private function onShootoutConfigChanged(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RShootoutConfigChanged = RShootoutConfigChanged(p__1);
			onLeaveTable(null);
		}
		private function onPlayerBounced(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RPlayerBounced = RPlayerBounced(p__1);
			onLeaveTable(null);
		}
		private function onRoundChanged(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RRoundChanged = RRoundChanged(p__1);
			onLeaveTable(null);
		}
		private function onSitPermissionRefused(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RSitPermissionRefused = RSitPermissionRefused(p__1);
			dispatchEvent(new ErrorPopupEvent("onErrorPopup", "Can\'t Sit", "This tournament has already started. Feel free to observe the game!"));
		}
	}
}