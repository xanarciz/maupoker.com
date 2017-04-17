// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import caurina.transitions.*;
	import caurina.transitions.properties.*;
	import com.script.poker.PokerUser;
	import com.script.poker.table.asset.Pot;
	import com.script.poker.table.asset.Chicklet;
	import com.script.poker.table.asset.PokerButton;
	import com.script.poker.table.asset.CardData;
	import com.script.poker.table.asset.Clock;
	import com.script.poker.table.asset.Card;
	import com.script.poker.table.asset.BettingControls;
	import com.script.poker.table.asset.GlobalJackpotControl;
	import com.script.poker.table.asset.MuteIcon;
	import com.script.poker.table.asset.TableInfo;
	import com.script.poker.table.asset.ZLStatus;
	import com.script.poker.table.events.view.*;
	import flash.net.URLRequest;
	import com.script.draw.*;
	import com.script.format.*;
	import flash.utils.Timer;
	import com.script.poker.table.events.*;
	import com.script.poker.table.asset.chat.*;
	public class TableView extends flash.display.MovieClip
	{
		
		
					
		public var btnCont:flash.display.MovieClip;
					
		
		//public var aChickletCoorData:Array = [[148, 443], [156, 272], [267, 154], [495, 154], [603, 272], [618, 443], [763, 543], [572, 543], [381, 543]];
		public var aChickletCoorData:Array = [[147.95, 289.55], [149, 179.2], [264.75, 102.65], [498.7, 102.6], [623.75, 179.5], [621, 289.55], [509, 355], [381, 355], [254, 355]];
		public var clockCoordsdata:Array  = [[222, 420], [222, 249], [398, 131], [742, 131], [932, 249], [932, 420], [761, 520], [569, 520], [379, 520]];
		public var dummyCards:flash.display.MovieClip;
		public var joinButton:com.script.poker.table.asset.PokerButton;
		public var reportButton:com.script.poker.table.asset.PokerButton;
		public var chatCont:flash.display.MovieClip;
		public var muterButton:com.script.poker.table.asset.PokerButton;
		public var clock:com.script.poker.table.asset.Clock;
		public var rollover_points:uint = 3104264;
		public var dealer_ph0:flash.display.MovieClip;
		public var dealer_ph1:flash.display.MovieClip;
		public var dealer_ph2:flash.display.MovieClip;
		public var dealer_ph3:flash.display.MovieClip;
		public var dealer_ph5:flash.display.MovieClip;
		public var dealer_ph6:flash.display.MovieClip;
		public var dealer_ph7:flash.display.MovieClip;
		public var dealer_ph8:flash.display.MovieClip;
		public var dealer_ph4:flash.display.MovieClip;
		public var giftOffX:int = 30;
		public var giftOffY:int = -3;
		public var emoOffX:int = 35;
		public var emoOffY:int = -35;
		private var dealTimer:flash.utils.Timer;
		private var congratTimer:flash.utils.Timer;
		private var congratTimer2:flash.utils.Timer;
		private var reportTimer:flash.utils.Timer;
		public var provCont:flash.display.MovieClip;
		public var comcard0:com.script.poker.table.asset.Card;
		public var comcard1:com.script.poker.table.asset.Card;
		public var comcard2:com.script.poker.table.asset.Card;
		public var comcard3:com.script.poker.table.asset.Card;
		public var comcard4:com.script.poker.table.asset.Card;
		public var handCont:flash.display.MovieClip;
		public var betControls:com.script.poker.table.asset.BettingControls;
		public var viewer_vip:uint = 15229;
		public var handButton:com.script.poker.table.asset.PokerButton;
		public var giftCont:flash.display.MovieClip;
		public var emoCont:flash.display.MovieClip;
		public var standButton:com.script.poker.table.asset.PokerButton;
		public var bgAttempts:int = 0;
		public var newcard00:com.script.poker.table.asset.Card;
		public var newcard01:com.script.poker.table.asset.Card;
		public var joinCtrl:com.script.poker.table.JoinUserController;
		public var invCont:flash.display.MovieClip;
		public var nUserSit:int;
		public var leaveButton:com.script.poker.table.asset.PokerButton;
		public var bgLoad:flash.display.Loader;
		public var newcard10:com.script.poker.table.asset.Card;
		public var newcard11:com.script.poker.table.asset.Card;
		private var chipCtrl:com.script.poker.table.ChipController;
		public var mcPopupNextHand:flash.display.MovieClip;
		public var dealerPuck:flash.display.MovieClip;
		public var newcard20:com.script.poker.table.asset.Card;
		public var newcard21:com.script.poker.table.asset.Card;
		private var bPass2:Boolean;
		public var newcard30:com.script.poker.table.asset.Card;
		public var newcard31:com.script.poker.table.asset.Card;
		public var bgCont:flash.display.MovieClip;
		public var dp0:com.script.poker.table.asset.Chicklet;
		public var dp1:com.script.poker.table.asset.Chicklet;
		public var dp2:com.script.poker.table.asset.Chicklet;
		public var dp3:com.script.poker.table.asset.Chicklet;
		public var dp4:com.script.poker.table.asset.Chicklet;
		public var dp5:com.script.poker.table.asset.Chicklet;
		public var dp6:com.script.poker.table.asset.Chicklet;
		public var dp7:com.script.poker.table.asset.Chicklet;
		public var dp8:com.script.poker.table.asset.Chicklet;
		public var newcard41:com.script.poker.table.asset.Card;
		public var newcard40:com.script.poker.table.asset.Card;
		public var bgMaxAttempts:int = 3;
		public var newcard50:com.script.poker.table.asset.Card;
		public var newcard51:com.script.poker.table.asset.Card;
		public var viewer_weekly:uint = 8786177;
		public var newcard60:com.script.poker.table.asset.Card;
		public var newcard61:com.script.poker.table.asset.Card;
		public var provCtrl:com.script.poker.table.ProvController;
		public var muter:com.script.poker.table.asset.MuteIcon;
		public var handCtrl:com.script.poker.table.HandController;
		public var joinCont:flash.display.MovieClip;
		public var statusCtrl:com.script.poker.table.StatusController;
		public var ptModel:com.script.poker.table.TableModel;
		public var newcard70:com.script.poker.table.asset.Card;
		public var newcard71:com.script.poker.table.asset.Card;
		private var chickletCtrl:com.script.poker.table.ChickletController;
		private var cardCtrl:com.script.poker.table.CardController;
		public var tableInfo:com.script.poker.table.asset.TableInfo;
		public var chipCont:flash.display.MovieClip;
		public var statCont:flash.display.MovieClip;
		public var newcard80:com.script.poker.table.asset.Card;
		public var newcard81:com.script.poker.table.asset.Card;
		public var rollover_weekly:uint = 15725;
		public var viewer_points:uint = 8786177;
		public var rollover_vip:uint = 6881792;
		public var giftCtrl:com.script.poker.table.GiftController;
		public var emoCtrl:com.script.poker.table.EmoController;
		private var chatCtrl:com.script.poker.table.ChatController;
		
		

		public var aGiftCoorData:Array = [[(155 + giftOffX), (320 + giftOffY)], [(155 + giftOffX), (209 + giftOffY)], [(270 + giftOffX), (134 + giftOffY)], [(500 - giftOffX), (134 + giftOffY)], [(632 - giftOffX), (208 + giftOffY)], [(632 - giftOffX), (317 + giftOffY)], [(510 - giftOffX), (385 + giftOffY)], [(390 - giftOffX), (385 + giftOffY)], [(261 + giftOffX), (385 + giftOffY)]];
		//public var aEmoCoorData:Array = [[159, 249], [159 , 200], [(265 + emoOffX), (126 + emoOffY)], [(126 - emoOffX), (126 + emoOffY)], [(601 - emoOffX), (193 + emoOffY)], [(616 - emoOffX), (331 + emoOffY)], [(507 - emoOffX), (388 + emoOffY)], [(379 - emoOffX),388], [269,388]];
		public var aEmoCoorData:Array = [[(165 + emoOffX), (320 + emoOffY)], [(165 + emoOffX), (209 + emoOffY)], [(285 + emoOffX), (134 + emoOffY)], [(500 -emoOffX), (134 + emoOffY)], [(632 - emoOffX), (208 + emoOffY)], [(632 - emoOffX), (317 + emoOffY)], [(525 - emoOffX), (385 + emoOffY)], [(390 - emoOffX), (385 + emoOffY)], [(261 + emoOffX), (385 + emoOffY)]];;
		public var mcJackpot:flash.display.MovieClip;
		public var mcJackpotGlobal:flash.display.MovieClip;
		//global jackpot
		public var mcJackpotB:flash.display.MovieClip;
		public var mcSJackpotB:flash.display.MovieClip;
		public var cbj:com.script.poker.table.asset.CheckBoxJackpot;
		public var gjControls:com.script.poker.table.asset.GlobalJackpotControl;
	
		
		public var mcCongrat:flash.display.MovieClip;
		public var mcCongratGJackpot:flash.display.MovieClip;
		public var mcPaylist:flash.display.MovieClip;
		public var langs = new Object();
		public var chatIcon;
		public var emoIcon;	
		public var handIcon;	
		public var muteIcon;
		public var SoundmuteIcon;
		public var Strict;	
		public var tolobby_btn;	
		public var standup_btn;	
		private var err = 0;
		
		public var invCtrl:com.script.poker.table.InviteController;
		public function TableView()
		{
		}
		public function TriggerJackpot(p__1:String,p__2:String):void
		{
			
			if(p__1 != p__2){
				
				caurina.transitions. Tweener.addTween(mcJackpotGlobal, {_Glow_alpha:10, _Glow_color:55295, _Glow_blurX:25, _Glow_blurY:25, _Glow_quality:2, time:0.5, transition:"easeOutSine"});
				caurina.transitions. Tweener.addTween(mcJackpotGlobal, {_Glow_alpha:0, _Glow_color:55295, _Glow_blurX:0, _Glow_blurY:0, time:0.6,delay:0.8, transition:"easeOutSine"});
			}

		}
		public function initView(p__1:com.script.poker.table.TableModel):void
		{
			mcCongrat.visible = false;
			mcCongratGJackpot.visible = false;
			
			
			tolobby_btn.visible = false;
			standup_btn.visible = false;
			mcSJackpotB.visible = false;
			mcPaylist.visible = false;
			ptModel = p__1;
			langs = ptModel.langs;
			tolobby_btn.txt.text=langs.l_tolobby.toUpperCase();
			standup_btn.txt.text=langs.l_standup.toUpperCase();
			trace("haha");
			chatIcon.txt.text =langs.l_send;
			
			mcCongratGJackpot.gratz_gjackpot_txt.text=langs.l_congratulation_gjackpot;
			mcCongratGJackpot.win_gjackpot_txt.text=langs.l_win_gjackpot;
			//mcJackpotB.beli_jp_txt.text=langs.l_buy_jp_next;
			
			bgAttempts = 0;
			setBG();
			cardCtrl = new CardController(this);
			chickletCtrl = new ChickletController(this);
			chipCtrl = new ChipController(this);
			chatCtrl = new ChatController(this, chatCont);
			chatCtrl.inputter.inputField.text =langs.l_typetochat;
			chatCtrl.addEventListener(TVEvent.CHAT_NAME_PRESSED, onChatNamePressed);			
			mcCongrat.addEventListener(MouseEvent.CLICK, onCongratClick);
			mcCongratGJackpot.addEventListener(MouseEvent.CLICK, onCongratGJackpotClick);
			mcJackpot.addEventListener(MouseEvent.MOUSE_OVER, onJackpotOver);
			mcJackpot.addEventListener(MouseEvent.MOUSE_OUT, onJackpotOut);
			mcJackpotGlobal.addEventListener(MouseEvent.MOUSE_OVER, onJackpotOver);
			mcJackpotGlobal.addEventListener(MouseEvent.MOUSE_OUT, onJackpotOut);
			emoIcon.addEventListener(MouseEvent.CLICK, onEmoPressed);
			handIcon.addEventListener(MouseEvent.CLICK, onHandPressed);
			chatIcon.addEventListener(MouseEvent.CLICK, onChatIconPressed);
			muteIcon.addEventListener(MouseEvent.CLICK, onMutePressed);
			SoundmuteIcon.addEventListener(MouseEvent.CLICK, onSoundMutePressed);

			provCtrl = new ProvController(this, provCont);
			invCtrl = new InviteController(this, invCont);
			giftCtrl = new GiftController(this, giftCont);
			emoCtrl = new EmoController(this, emoCont);
			statusCtrl = new StatusController(this, statCont);
			//mcJackpot.JackpotTf:flash.display.MovieClip;
			
			betControls.calltext = langs.l_call
			betControls.cektext = langs.l_cek
			betControls.allintext = langs.l_allin
			betControls.foldtext = langs.l_fold
			betControls.raisetext = langs.l_raise
			betControls.callanytext = langs.l_callany
			betControls.cekfoldtext = langs.l_fold2
			
			joinCtrl = new JoinUserController(this, joinCont);
			handCtrl = new HandController(this, handCont);
			initButtons();
			initUIListeners();
			initChicklets();
			initBetControls();
			initClock();
			initGJackpotControls();
			cardCtrl.initCards();
			setDealer(ptModel.nDealerSit);
			disableMouseAbility();
			checkForChips();
			checkMaxSeats();
			checkViewerSeated();
			setMuteButton();
			setTableInfo();
			updatePopupNextHand();
			updateBuyJackpot();
		}
		private function initUserInfo():void
		{
		}
		public function onHideFS():void
		{
			if (joinButton != null){
				joinButton.setSelectscriptLive(true);
			}
		}
		public function onShowFS():void
		{
			if (joinButton != null){
				joinButton.setSelectscriptLive(false);
			}
		}
		private function setTableButtons():void
		{
		}
		public function sendStatHit(p__1:String):void
		{
		}
		public function setBG(p__1:flash.events.ErrorEvent = null):void
		{
			var l__2:String;
			var l__3:flash.net.URLRequest;
			bgAttempts++;
			if (bgAttempts < bgMaxAttempts){
				l__2 = ptModel.sTableUrl;
				l__3 = new URLRequest(l__2);
				bgLoad = new Loader();
				bgLoad.contentLoaderInfo.addEventListener(Event.COMPLETE, addBG);
				bgLoad.contentLoaderInfo.addEventListener(ErrorEvent.ERROR, setBG);
				bgLoad.load(l__3);
			}
		}
		public function addBG(p__1:flash.events.Event):void
		{
			bgCont.addChild(bgLoad);
			var p__3 = bgLoad.content as Bitmap;
			p__3.smoothing = true;
		}
		public function clearBG():void
		{
			var l__2:flash.display.Loader;
			var l__1:int;
			while(bgCont.numChildren > 0){
				l__2 = bgCont.getChildAt(0);
				bgCont.removeChildAt(0);
				l__2 = null;
			}
		}
		private function initClock():void
		{
			clock.initClock(this);
		}
		private function initBetControls():void
		{
			betControls.visible = false;
		}
		private function initGJackpotControls():void
		{
			mcJackpotB.visible = false;
			gjControls.visible = false;
			
		}
	
		public function onBJackpotPressed():void
		{
		;
			var l__5:* = gjControls.whichChecked;
			
		
		
			if(!(l__5 == null)){
				trace(l__5.action+"masuk kemana");
				switch(l__5.action){
					
					case "BJackpot1":
					{
						
						dispatchEvent(new TVEvent(TVEvent.BJACKPOT1_PRESSED));
						break;
						
						//dispatchEvent(new TVEvent(TVEvent.BJACKPOT3_UNPRESSED));
					}
						case "BJackpot2":
					{
						dispatchEvent(new TVEvent(TVEvent.BJACKPOT2_PRESSED));
						break;
						
						//dispatchEvent(new TVEvent(TVEvent.BJACKPOT3_UNPRESSED));
					}
					case "BJackpot3":
					{
						dispatchEvent(new TVEvent(TVEvent.BJACKPOT3_PRESSED));
						break;
						
						//dispatchEvent(new TVEvent(TVEvent.BJACKPOT3_UNPRESSED));
					}
				}
			}else{
				dispatchEvent(new TVEvent(TVEvent.BJACKPOT_UNPRESSED));
				
			}
			
		}
		private function initButtons():void
		{
			var l__1:Object = new Object();
			l__1.gfx = AutoTriangle.make(1118481);
			l__1.theX = 59;
			l__1.theY = 5;
			leaveButton = new PokerButton(myriadTF, "medium", langs.l_tolobby, l__1, 70, 3);
			//btnCont.addChild(leaveButton);
			tolobby_btn.visible = true;
			leaveButton.x = 682;
			leaveButton.y = 5;
			var l__2:Object = new Object();
			l__2.gfx = AutoTriangle.make(1118481);
			l__2.gfx.rotation = -90;
			l__2.theX = 59;
			l__2.theY = 11;
			standButton = new PokerButton(myriadTF, "medium", langs.l_standup, l__2, 70, 3);
			//btnCont.addChild(standButton);
			standup_btn.visible=false;
			standButton.visible = false;
			
			standButton.x = 682;
			standButton.y = 30;
			
			var l__7:Object = new Object();
			l__7.gfx = AutoTriangle.make(1118481);
			l__7.gfx.rotation = -90;
			l__7.theX = 59;
			l__7.theY = 17;
			changeButton = new PokerButton(myriadTF, "medium", langs.l_change, l__7, 100, 3);
			btnCont.addChild(changeButton);
			changeButton.visible = false;
			changeButton.x = 652;
			changeButton.y = 55;
			checkRoomOwner()
			
			muter = new MuteIcon();
			var l__3:flash.display.Sprite = new Sprite();
			l__3.addChild(muter);
			var l__4:Object = new Object();
			l__4.gfx = l__3;
			l__4.theX = 7;
			l__4.theY = 5;
			muterButton = new PokerButton(myriadTF, "large", "", l__4, 30);
			muterButton.x = 250;
			muterButton.y = 800;
			btnCont.addChild(muterButton);
			var l__5:com.script.poker.table.asset.ZLStatus = new ZLStatus();
			l__5.stop();
			var l__6:Object = new Object();
			l__6.gfx = l__5;
			l__6.theX = 2;
			l__6.theY = 5;
			joinButton = new PokerButton(myriadTF, "large", (("Online (" + ptModel.nZoomFriends) + ")"), l__6, 117, 13, -1, -1);
			joinButton.x = 395;
			joinButton.y = 500;
			joinButton.visible = false;
			//joinButton.setZLStatus(ptModel.nZoomFriends);
			btnCont.addChild(joinButton);
			
			reportButton = new PokerButton(myriadTF, "large", "Report Error", null, 117, 13, -1, -1);
			reportButton.x = 395;
			reportButton.y = 500;
			btnCont.addChild(reportButton);
			reportButton.visible = false;			
		}
		public function clearButtons()
		{
			//btnCont.removeChild(leaveButton);
			//btnCont.removeChild(standButton);
			btnCont.removeChild(changeButton);
			//btnCont.removeChild(muterButton);
			btnCont.removeChild(joinButton);
			btnCont.removeChild(reportButton);
			standup_btn.visible = false;
			tolobby_btn.visible = false;
			//leaveButton = null;
			//standButton = null;
			//muterButton = null;
			joinButton = null;
			reportButton = null;
			
			
			
		}
		private function initUIListeners():void
		{
			
			var l__1:com.script.poker.table.asset.Chicklet;
			/*leaveButton.addEventListener(MouseEvent.CLICK, onLeaveTablePressed);
			standButton.addEventListener(MouseEvent.CLICK, onStandPressed);*/
			tolobby_btn.addEventListener(MouseEvent.CLICK, onLeaveTablePressed);
			standup_btn.addEventListener(MouseEvent.CLICK, onStandPressed);
			//changeButton.addEventListener(MouseEvent.CLICK, onEditPressed);
			standup_btn.addEventListener(MouseEvent.CLICK, onStandPressed);
			changeButton.addEventListener(MouseEvent.CLICK, onEditPressed);
			muterButton.addEventListener(MouseEvent.CLICK, onSoundMutePressed);
			joinButton.addEventListener(MouseEvent.CLICK, onJoinPressed);
			reportButton.addEventListener(MouseEvent.CLICK, onReportPressed);
			var l__2:int;
			
			while(l__2 < 9){
				l__1 = Chicklet(this[("dp" + l__2)]);
				l__1.addEventListener(MouseEvent.ROLL_OVER, onChickletMouseOver);
				l__1.addEventListener(MouseEvent.ROLL_OUT, onChickletMouseOut);
				l__1.hitter.addEventListener(MouseEvent.MOUSE_DOWN, onChickletMouseDown);
				l__2++;
			}
		}
		private function initChicklets()
		{
			var l__1:com.script.poker.table.asset.Chicklet;
			var l__2:com.script.poker.PokerUser;
			var l__7:Boolean;
			var l__3:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			var l__4:String = ptModel.room.gameType;
			var l__5:String = ptModel.room.tableType;
			var l__6:int;
			
			while(l__6 < 9){
				this[("dp" + l__6)].playerSit.txt.text =langs.l_sit.toUpperCase();
				l__1 = Chicklet(this[("dp" + l__6)]);
				l__1.initChicklet(l__6, this, ptModel.sDispMode);
				l__2 = ptModel.getUserBySit(l__6);
				if (l__2 != null){
					l__7 = false;
					if (l__2 == l__3){
						l__7 = true;
					}
					
					l__1.setPlayerInfo(l__2.sPicURL, l__2.sUserName.split(" ")[0], l__2.nAchievementRank, l__2.nChips, l__2.bIsVip, l__7, l__2.zid);
					l__1.showInfo();
					checkPhoneUser(l__6);
				}
				l__6++;
			}
			if ((ptModel.room.gameType == "Tournament") && !(ptModel.sTourneyMode == "reg")){
				chickletCtrl.clearAvailableSits();
			}
		}
		private function checkMaxSeats():void
		{
			var l__1:Number = ptModel.room.maxPlayers;
			var l__2:int;
			while(l__2 < 9){
				tChicklet = Chicklet(this[("dp" + l__2)]);
				if(l__1 == 9){

					dp0.x=224.65;
					dp0.y=423;
					dp1.x=224.2;
					dp1.y=252;
					dp2.x=400.35;
					dp2.y=134;
					dp3.x=744.65
					dp3.y=134
					dp4.x=934.75
					dp4.y=252
					dp5.x=932.8
					dp5.y=423
					dp6.x=763.65
					dp6.y=523
					dp7.x=571.95
					dp7.y=523
					dp8.x=381.35
					dp8.y=523
					
				}if(l__1 == 6){
					aChickletCoorData:Array = [[148, 318], [156, 183], [267, 113], [495, 113], [603, 183], [618, 318], [509, 375], [381, 377], [254, 375]];
					dp0.x=224.65;
					dp0.y=443;
					dp1.x=224.2;
					dp1.y=302;
					dp2.x=400.35;
					dp2.y=154;
					dp3.x=400.35
					dp3.y=154
					dp4.x=744.65
					dp4.y=156
					dp5.x=934.75
					dp5.y=306
					dp6.x=763.65
					dp6.y=543
					dp7.x=571.95
					dp7.y=543
					dp8.x=381.35
					dp8.y=543
					
					
				}if(l__1 == 4){
					
					
					
				}if(l__1 == 2){
					
					
					
				}
				if (l__2 < l__1){
					tChicklet.visible = true;
				} else {
					tChicklet.visible = false;
				}
				l__2++;
			}
		}
		private function checkViewerSeated():void
		{
		
			var l__3:* = undefined;
			var l__1:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			var l__2:Array = ptModel.aUsers;
			standButton.visible = false;
			standup_btn.visible = false;
			
			for (l__3 in l__2){
				
				if (l__1 == l__2[l__3]){
					if ((ptModel.nTourneyId > -1) || (ptModel.room.gameType == "Tournament")){
						standButton.visible = false;
						standup_btn.visible = false;
					} else {
						standButton.visible = true;
						standup_btn.visible = true;
					}
					chickletCtrl.clearAvailableSits();
				}
			}
		}
		private function checkRoomOwner():void
		{
			
			var l__3:* = undefined;
			//var l__1:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			//var l__2:Array = ptModel.aUsers;
			changeButton.visible = false;
			
			if (ptModel.nOwner == ptModel.viewer.zid) {
				changeButton.visible = true;
			}
			else {
				changeButton.visible = false;
			}
			
		}
		public function disableMouseAbility():void
		{
			clock.mouseEnabled = false;
			clock.mouseChildren = false;
			dealerPuck.mouseEnabled = false;
			dealerPuck.mouseChildren = false;
		}
		public function onCallPressed():void
		{
			dispatchEvent(new TVEvent(TVEvent.CALL_PRESSED));
		}
		public function onFoldPressed():void
		{
			dispatchEvent(new TVEvent(TVEvent.FOLD_PRESSED));
		}
		public function onRaisePressed():void
		{
			dispatchEvent(new TVERaisePressed(TVEvent.RAISE_PRESSED, betControls.slider.betAmount));
		}
		public function onMutePressed(p__1:flash.events.MouseEvent):void
		{
			if(chatCtrl.mutex==0){
				chatCtrl.mutex=1;
				dispatchEvent(new TVEvent(TVEvent.MUTE_PRESSED));
			}else{
				chatCtrl.killMuteList();
				
			}
		}
		public function onHandPressed(p__1:flash.events.MouseEvent):void
		{
			handCtrl.bHandStrengthPressed = !handCtrl.bHandStrengthPressed;
			//handCtrl.handIcon.toggler(bHandStrengthPressed);
			handCtrl.toggleList(handCtrl.bHandStrengthPressed);
		}
		public function onEmoPressed(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new TVEEmoListPressed(TVEvent.EMO_PRESSED, nUserSit));
		}
		public function onChatIconPressed(p__1:flash.events.MouseEvent):void
		{
			chatCtrl.inputter.sendContents();
		}
		public function onGiftPressed(param1:int):void
		{
			dispatchEvent(new TVEGiftPressed(TVEvent.GIFT_PRESSED, param1));
		}
		public function cleanupTable():void
		{
			killTimer();
			clearBG();
			clearButtons();
			chickletCtrl.resetChicklets();
			chatCtrl.leaveTable();
			joinCtrl.leaveTable();
			chipCtrl.leaveTable();
			cardCtrl.clearCards();
			giftCtrl.clearGifts();
			emoCtrl.clearEmo();
			invCtrl.clearInvites();
			handCtrl.cleanUp();
			clock.stopCount();
		}
		private function onLeaveTablePressed(p__1:flash.events.MouseEvent):void
		{
			cleanupTable();
			dispatchEvent(new TVEvent(TVEvent.LEAVE_TABLE));
		}
		public function onLeaveTourney():void
		{
			cleanupTable();
			dispatchEvent(new TVEvent(TVEvent.LEAVE_TABLE));
		}
		public function onLeaveShootout():void
		{
			cleanupTable();
			dispatchEvent(new TVEvent(TVEvent.LEAVE_TABLE));
		}
		private function onStandPressed(p__1:flash.events.MouseEvent):void
		{
			var l__1:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			var l__2 = Chicklet(this[("dp" + l__1.nSit)]);
			var l__3 = Number(l__1.nTotalPoints)+Number(l__2.chipsTF.text)
			tableInfo.casinoTf.text = (StringUtility.StringToMoney(l__3));
			dispatchEvent(new TVEvent(TVEvent.STAND_UP));
		}
		private function onEditPressed(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new TVEvent(TVEvent.EDIT_TABLE));
		}
		var soundxxx=1;
		public function onSoundMutePressed(p__1:flash.events.MouseEvent):void
		{
			
			ptModel.bTableSoundMute = !ptModel.bTableSoundMute;
			muter.toggler(ptModel.bTableSoundMute);
			if(soundxxx==1){
				Strict.visible=false;
				soundxxx=0;
			}else{
				Strict.visible=true;
				soundxxx=1;
			}
			dispatchEvent(new TVEMuteSound(TVEvent.TOGGLE_MUTE_SOUND, ptModel.bTableSoundMute));
		}
		public function setMuteButton():void
		{
			muter.toggler(ptModel.bTableSoundMute);
			dispatchEvent(new TVEMuteSound(TVEvent.TOGGLE_MUTE_SOUND, ptModel.bTableSoundMute));
		}
		public function onJoinPressed(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new TVEvent(TVEvent.FRIEND_NET_PRESSED));
		}
		public function onReportPressed(p__1:flash.events.MouseEvent):void
		{
			reportButton.visible = false;
			dispatchEvent(new TVEvent(TVEvent.REPORT_PRESSED));
			if (!(reportTimer == null) && reportTimer.running){
				reportTimer.removeEventListener(TimerEvent.TIMER, onReportTimer);
				reportTimer.reset();
			} else {
				reportTimer = new Timer(60000);
			}
				
			reportTimer.addEventListener(TimerEvent.TIMER, onReportTimer);
			reportTimer.start();
		}
		private function onReportTimer(p__1:flash.events.TimerEvent):void
		{
			reportTimer.removeEventListener(TimerEvent.TIMER, onReportTimer);
			reportTimer.stop();
			//reportButton.visible = true;
		}
		public function playerSat(p__1:int):void
		{
			var l__2:com.script.poker.table.asset.Chicklet;
			var l__3:com.script.poker.PokerUser = ptModel.getUserBySit(p__1);
			var l__4:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			l__2 = Chicklet(this[("dp" + p__1)]);
			var l__5:Boolean;
			if (l__3 == l__4){
				l__5 = true;
			}
			chickletCtrl.playerSat(l__2, l__3, l__5);
			//checkPhoneUser(p__1);
			if (l__5){
				//if ((ptModel.nTourneyId > -1) || (ptModel.room.gameType == "Tournament")){
				//	standButton.visible = false;
				//} else {
					standButton.visible = true;
					standup_btn.visible = true;
				//}
				chickletCtrl.clearAvailableSits();
			}
			chickletCtrl.setVIP(l__3.nSit, l__3.bIsVip);
		}
		public function stopAllClock(){
			for (var a=0; a<9; a++) {
			chickletCtrl.stopClock(a);
			}
			
			//betControls.visible = false;
		}
		
		public function playerLeft(p__1:int):void
		{
			var l__2:com.script.poker.PokerUser = ptModel.getUserBySit(p__1);
			var l__3:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			var l__4:Array = ptModel.aUsers;
			var l__5:Boolean;
			if (l__3 != null){
				l__5 = true;
			}
			statusCtrl.killBubbleBySit(p__1);
			chickletCtrl.setColor(p__1, "clear");
			chickletCtrl.stopClock(p__1);
			chickletCtrl.resetSitAction(p__1);
			chickletCtrl.setSeating(p__1, false);
			giftCtrl.clearGiftFromSit(p__1);
			emoCtrl.clearEmoFromSit(p__1);
			if (l__2 == l__3){
				betControls.visible = false;
				if (standButton != null || standButton != undefined) {
					standButton.visible = false;
					standup_btn.visible = false;
				}
				handCtrl.hideMe(true);
				chickletCtrl.showAvailableSits();
			} else if (!l__5){
				standButton.visible = false;
				standup_btn.visible = false;
				handCtrl.hideMe(true);
				chickletCtrl.showAvailableSits();
			} else if (l__5){
				chickletCtrl.showLeave(p__1);
			}
			cardCtrl.clearPlayerCards(p__1);
			cardCtrl.foldDummyCard(p__1);
		}
		public function setDealer(p__1:int):void
		{
			statusCleanup();
			if ((p__1) == -1){
				dealerPuck.visible = false;
			} else {
				dealerPuck.visible = true;
				dealerPuck.movePuck(this[("dealer_ph" + p__1)].x, this[("dealer_ph" + p__1)].y);
			}
		}
		public function postBlind(p__1:int):void
		{
			
			var l__2:com.script.poker.PokerUser = ptModel.getUserBySit(p__1);
			chickletCtrl.updateChips(p__1, l__2.nChips);
			if(l__2.nCurBet > 0){
				chipCtrl.makeChipsFromPlayer(p__1, l__2.nCurBet);
			}
			
		}
		public function postStatusBuyJackpot(p__1:int,p__2:int,p__3:int):void
		{
			
			if(p__2 == 1){
				mcSJackpotB.jackpotTf.htmlText = langs.l_buy_jackpot_now.toUpperCase()+" "+"<b>"+p__3+"</b>";
				mcSJackpotB.visible = true;
				
				
				updateBuyJackpotOff();
			}else{
				mcSJackpotB.visible = false;
				updateBuyJackpot();
			}
			
		}
		public function dealHoleCards(p__1:int):void
		{
			cardCtrl.initCards();
			nUserSit = p__1;
			bPass2 = false;
			if (!(dealTimer == null) && dealTimer.running){
				dealTimer.removeEventListener(TimerEvent.TIMER, onDealCard);
				dealTimer.reset();
				
			} else {
				dealTimer = new Timer(100);
			}
			dealTimer.addEventListener(TimerEvent.TIMER, onDealCard);
			dealTimer.start();
		}
		private function onDealCard(p__1:flash.events.TimerEvent):void
		{
			if (cardCtrl.nDealCount >= ptModel.aUsersInHand.length){
				if (!bPass2){
					cardCtrl.nDealCount = 0;
				}
				bPass2 = true;
			}
			
			if ((cardCtrl.nDealCount >= ptModel.aUsersInHand.length) && bPass2){
				dealTimer.removeEventListener(TimerEvent.TIMER, onDealCard);
				dealTimer.stop();
			} else {
				dispatchEvent(new TVEPlaySound(TVEvent.PLAY_SOUND_ONCE, "playSound_Deal", null));
				dispatchEvent(new TVEvent(TVEvent.DEAL_CARD));
				if (ptModel.aDealOrder[cardCtrl.nDealCount] != undefined && ptModel.aDealOrder[cardCtrl.nDealCount] != null && ptModel.aDealOrder[cardCtrl.nDealCount] != ""){
					if (ptModel.aDealOrder[cardCtrl.nDealCount].nSit == nUserSit){
						err++;
						if(err > 3){
							dealTimer.removeEventListener(TimerEvent.TIMER, onDealCard);
							err = 0;
						}
						if (!bPass2){
							
							cardCtrl.dealCard(nUserSit, bPass2, ptModel.holeCard1.sCard, ptModel.holeCard1.nSuit);
						} else {
							cardCtrl.dealCard(nUserSit, bPass2, ptModel.holeCard2.sCard, ptModel.holeCard2.nSuit);
							err = 0;
						}
					} else {
							
						cardCtrl.dealCard(ptModel.aDealOrder[cardCtrl.nDealCount].nSit, bPass2, "-1", -1);
					}
				}else {
					cardCtrl.dealCard(-1, bPass2, "-1", -1);
					playerLeft(cardCtrl.nDealCount);
					ptModel.removeUser(cardCtrl.nDealCount);
				}
				
			}
			
		}
		public function dealFlop():void
		{
			resetSitActions();
			cardCtrl.dealFlop(ptModel.flopCard1.sCard, ptModel.flopCard1.nSuit, ptModel.flopCard2.sCard, ptModel.flopCard2.nSuit, ptModel.flopCard3.sCard, ptModel.flopCard3.nSuit, false);
		}
		public function dealStreet():void
		{
			
			resetSitActions();
			cardCtrl.dealComCard(ptModel.streetCard.sCard, ptModel.streetCard.nSuit, 3, false);
		}
		public function dealRiver():void
		{
			resetSitActions();
			cardCtrl.dealComCard(ptModel.riverCard.sCard, ptModel.riverCard.nSuit, 4, false);
		}
		public function resetSitActions():void
		{
			var l__1:int;
			while(l__1 < 9){
				chickletCtrl.resetSitAction(l__1);
				l__1++;
			}
		}
		
		public function clearTable():void
		{
			resetSitActions();
			cardCtrl.clearCards();
			chipCtrl.clearChips();
			handCtrl.hideMe(true);
			mcSJackpotB.visible = false;
		}
		public function showBetControls(p__1:String):void
		{
			switch(p__1){
				case "pre":
				{
					break;
				}
				case "call":
				{
					break;
				}
				case "checkraise":
				{
					break;
				}
				case "callraise":
				{
					break;
				}
			}
		}
		public function showViewerBet():void
		{
			
			var l__4:* = undefined;
			var l__1:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			var l__2:Array = ptModel.aUsersInHand;
			var l__3:Boolean;
			for (l__4 in l__2){
				if (l__1 == l__2[l__4]){
					l__3 = true;
				}
			}
			if (l__1 != null){
			if (l__1.reSit == "1"){
				l__3 = true;
			}
			}
			betControls.visible = l__3;
			if (l__3){
				updatePopupNextHand();
			}
			handCtrl.hideMe(!l__3);
		}
		public function handleBetting(p__1:int):void
		{
			var l__6:Number = 0;
			var l__2:com.script.poker.PokerUser = ptModel.getUserBySit(p__1);
			var l__3:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			var l__4:Boolean;
			var l__5:* = betControls.prebetControls.whichChecked;
			if (l__2 != l__3){
				l__4 = true;
			}	
			if ((l__2 == l__3) && (l__3.sStatusText == "allin")){
				betControls.visible = false;
			}
			if (((l__2 == l__3) && (l__3.nChips > 0)) && !(l__5 == null)){
				l__4 = true;
				l__6 = ptModel.nCallAmt;
				switch(l__5.action){
					case "Check":
					{
						if (l__6 > 0){
							l__4 = false;
						} else {
							onCallPressed();
						}
						break;
					}
					case "Fold":
					{
						onFoldPressed();
						break;
					}
					case "Call Any":
					{
						onCallPressed();
						break;
					}
					case "Check/Fold":
					{
						if (l__6 > 0){
							onFoldPressed();
						} else {
							onCallPressed();
						}
						break;
					}
				}
				betControls.prebetControls.swapCheck();
			}
			betControls.showPreBet(l__4);
		}
		private function onChickletMouseOver(p__1:flash.events.MouseEvent):void
		{
			var l__3:com.script.poker.PokerUser;
			var l__2:com.script.poker.table.asset.Chicklet = Chicklet(p__1.target);
			var l__4:int = l__2.thisID;
			l__3 = ptModel.getUserBySit(l__4);
			provCtrl.showProv(l__3);
		}
		private function onChickletMouseOut(p__1:flash.events.MouseEvent):void
		{
			provCtrl.hideProv();
		}
		private function onChickletMouseDown(p__1:flash.events.MouseEvent):void
		{
			
			var l__2:com.script.poker.table.asset.Chicklet = Chicklet(p__1.target.parent);
			dispatchEvent(new TVESitPressed(TVEvent.SIT_PRESSED, l__2.thisID));
		}
		public function startPlayerTurn(p__1:int, p__2:Number, p__3:Number):void
		{
			statusCtrl.killBubbleBySit(p__1);
			chickletCtrl.showTurn(p__1);
			chickletCtrl.startClock(p__2, p__1, p__3);
		}
		public function resetChicklets():void
		{
			
			var l__1:int;
			while(l__1 < 9){
				chickletCtrl.setAlpha(l__1, 1);
				l__1++;
			}
		}
		public function playerFolded(p__1:int):void
		{
			var l__2:com.script.poker.PokerUser = ptModel.getUserBySit(p__1);
			var l__3:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			if (l__2 == l__3){
				betControls.visible = false;
				handCtrl.hideMe(true);
				cardCtrl.dimPlayerCards(p__1);
			} else if (l__2 != l__3){
				cardCtrl.foldPlayerCards(p__1);
			}
			cardCtrl.foldDummyCard(p__1);
			statusCtrl.setPlayerAction(p__1, "fold");
			chickletCtrl.stopClock(p__1);
			
		}
		public function updatePlayerAction(p__1:int):void
		{
			var l__2:com.script.poker.PokerUser = ptModel.getUserBySit(p__1);
			trace(l__2.nChips+"cek user1");
			chickletCtrl.updateChips(p__1, l__2.nChips);
			statusCtrl.setPlayerAction(p__1, l__2.sStatusText, l__2.nCurBet);
			chickletCtrl.stopClock(p__1);
			if (!(l__2.sStatusText == "fold") && (l__2.nCurBet > 0)){
				updateUserChips(p__1, l__2.nChips, l__2.nCurBet, l__2.sStatusText);
			}
			if (l__2.sStatusText == "fold"){
				playerFolded(p__1);
			}
		}
		public function setRaiseOption():void
		{
			betControls.showRaiseOption(ptModel.nMinBet, ptModel.nMaxBet, ptModel.nCallAmt, ptModel.nBigblind);
		}
		public function setCallOption():void
		{
			betControls.showCallOption(ptModel.nCallAmt);
		}
		public function showWinner(p__1:int, p__2:int, p__3:Boolean):void
		{
			if (p__3){
				statusCleanup();
			}
			var l__4:com.script.poker.PokerUser = ptModel.getUserBySit(p__1);
			var l__5:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			winningCleanup();
			chickletCtrl.updateChips(p__1, l__4.nChips);
			statusCtrl.setPlayerAction(p__1, "hand", l__4.nCurBet, l__4.sWinningHand);
			if (l__5 == null){
				cardCtrl.showWinningHand(p__1, l__4.holecard1.sCard, l__4.holecard1.nSuit, l__4.holecard2.sCard, l__4.holecard2.nSuit);
			} else if (l__5.nSit != (p__1)){
				cardCtrl.showWinningHand(p__1, l__4.holecard1.sCard, l__4.holecard1.nSuit, l__4.holecard2.sCard, l__4.holecard2.nSuit);
			}
			var l__6:Number = (l__4.nChips - l__4.nOldChips);
			chipCtrl.payoutChips(p__1, p__2, l__6);
		}
		public function showWinningCards(p__1:Object):void
		{
			cardCtrl.showWinningCards(p__1.sit, p__1.card1, p__1.card2, p__1.flop1, p__1.flop2, p__1.flop3, p__1.street, p__1.river);
		}
		public function showDefaultWinner(p__1:int, p__2:Array):void
		{
			
			var l__3:Array = p__2;
			var l__4:com.script.poker.PokerUser = ptModel.getUserBySit(p__1);
			statusCleanup();
			winningCleanup();
			chickletCtrl.updateChips(p__1, l__4.nChips);
			statusCtrl.setPlayerAction(p__1, l__4.sStatusText, l__4.nCurBet);
			var l__5:Number = (l__4.nChips - l__4.nOldChips);
			chipCtrl.payoutChips(p__1, 0, l__5);
		}
		public function statusCleanup():void
		{
			var l__1:int;
			while(l__1 < 9){
				statusCtrl.killBubbleBySit(l__1);
				l__1++;
			}
			
		}
		public function winningCleanup():void
		{
			betControls.visible = false;
			chickletCtrl.stopTurn();
			clock.stopCount();
		}
		public function showHoleCards(p__1:int):void
		{
			var l__2:com.script.poker.PokerUser = ptModel.getUserBySit(p__1);
			var l__3:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			if (l__3 == null){
				cardCtrl.showWinningHand(p__1, l__2.holecard1.sCard, l__2.holecard1.nSuit, l__2.holecard2.sCard, l__2.holecard2.nSuit);
			} else if (l__3.nSit != (p__1)){
				cardCtrl.showWinningHand(p__1, l__2.holecard1.sCard, l__2.holecard1.nSuit, l__2.holecard2.sCard, l__2.holecard2.nSuit);
			}
		}
		public function updateUserChips(p__1:int, p__2:Number, p__3:Number, p__4:String):void
		{
			
			chipCtrl.updateChipsFromPlayer(p__1, p__3, p__4);
			chickletCtrl.updateChips(p__1, p__2);
		}
		public function makePot(p__1:int, p__2:Boolean):void
		{
			var l__3:com.script.poker.table.asset.Pot = ptModel.getPotById(p__1);
			
			chipCtrl.makePot(l__3.nPotId, l__3.nAmt, p__2);
		}
		public function clearBets():void
		{
			chipCtrl.clearAllUserChips();
		}
		public function updateUserTotal(p__1:int):void
		{
			var l__2:com.script.poker.PokerUser = ptModel.getUserBySit(p__1);
			trace(p__1);
			trace(l__2.nChips+"masuk melalui sini");
			chickletCtrl.updateChips(p__1, l__2.nChips);
			
			if (l__2.zid == ptModel.viewer.zid) {
			tableInfo.casinoTf.text = (StringUtility.StringToMoney(l__2.nTotalPoints));
			}
			if(l__2.gJackpot > 0){
				mcJackpotGlobal.jackpotTf.text = StringUtility.StringToMoney(l__2.gJackpot);
			}
			mcJackpot.jackpotTf.text = StringUtility.StringToMoney(l__2.tJackpot)
			
		}
		public function newChatMessage(p__1:String, p__2:String, p__3:String = ""):void
		{
			var l__5:com.script.poker.PokerUser;
			if (ptModel.getUserByZid(p__3) != null){
				l__5 = ptModel.getUserByZid(p__3);
			}
			var l__4:Number = -1;
			if (l__5 != null){
				l__4 = l__5.nSit;
			}
			if ((p__3) == ptModel.viewer.zid){
				l__4 = 9;
			}
			chatCtrl.addChatMessage(p__3, p__1, p__2, l__4);
		}
		public function newDealerMessage(p__1:String, p__2:String = "")
		{
			chatCtrl.addDealerMessage(p__1, p__2);
		}
		public function sendChat(p__1:String)
		{
			dispatchEvent(new TVESendChat(TVEvent.SEND_CHAT, p__1));
		}
		public function showMuteList():void
		{
			chatCtrl.muteListUp();
		}
		public function showWaitList():void
		{
			chatCtrl.waitListUp();
		}
		public function updateBlockList(p__1:String, p__2:String):void
		{
			dispatchEvent(new TVEMuteMod(TVEvent.MUTE_MOD, p__1, p__2));
		}
		public function onChatNamePressed(p__1:com.script.poker.table.events.view.TVEChatNamePressed):void
		{
			dispatchEvent((p__1).clone());
		}
		public function replayHoles(p__1:int):void
		{
			var l__2:com.script.poker.table.asset.CardData = ptModel.holeCard1;
			var l__3:com.script.poker.table.asset.CardData = ptModel.holeCard2;
			cardCtrl.replayDeal(p__1, l__2.sCard, l__2.nSuit, l__3.sCard, l__3.nSuit);
		}
		public function replayComCard(p__1:int):void
		{
			var l__2:com.script.poker.table.asset.CardData;
			if ((p__1) == 0){
				l__2 = ptModel.flopCard1;
			}
			if ((p__1) == 1){
				l__2 = ptModel.flopCard2;
			}
			if ((p__1) == 2){
				l__2 = ptModel.flopCard3;
			}
			if ((p__1) == 3){
				l__2 = ptModel.streetCard;
			}
			if ((p__1) == 4){
				l__2 = ptModel.riverCard;
			}
			cardCtrl.dealComCard(l__2.sCard, l__2.nSuit, p__1, true);
		}
		public function replayPot(p__1:int, p__2:Boolean):void
		{
			var l__3:com.script.poker.table.asset.Pot = ptModel.getPotById(p__1);
			chipCtrl.makePot(l__3.nPotId, l__3.nAmt, p__2, true);
		}
		public function killTimer():void
		{
			if (dealTimer != null){
				dealTimer.stop();
				dealTimer.removeEventListener(TimerEvent.TIMER, onDealCard);
				dealTimer = null;
			}
		}
		public function replayUserCards(p__1:int):void
		{
			
			cardCtrl.showPlayerCards(p__1);
		}
		public function checkForChips():void
		{
			var l__2:com.script.poker.PokerUser;
			var l__1:int;
			while(l__1 < 9){
				l__2 = ptModel.getUserBySit(l__1);
				if (l__2 != null){
					if (l__2.nCurBet > 0){
						chipCtrl.makeChipsFromPlayer(l__1, l__2.nCurBet, "instant");
					}
				}
				l__1++;
			}
		}
		public function incomingBI(p__1:String):void
		{
			var l__2:com.script.poker.PokerUser = ptModel.getUserByZid(p__1);
			var l__3:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			invCtrl.sendBI(l__2.nSit, l__3.nSit, true);
		}
		public function outgoingBI(p__1:String):void
		{
			var l__2:com.script.poker.PokerUser = ptModel.getUserByZid(p__1);
			var l__3:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			invCtrl.sendBI(l__3.nSit, l__2.nSit, false);
		}
		public function getPendingInviteCount():int
		{
			return(ptModel.aBuddyInvites.length);
		}
		public function onInvitePressed():void
		{
			dispatchEvent(new TVEvent(TVEvent.INVITE_PRESSED));
		}
		public function updateInbox():void
		{
			invCtrl.checkInbox();
		}
		public function sendGift(p__1:int, p__2:int, p__3:int, p__4:Number):void
		{
			giftCtrl.sendGift(p__1, p__2, p__3, p__4);
		}
		public function sendGift2(p__1:int, p__2:int, p__3:*):void
		{
			giftCtrl.sendGift2(p__1, p__2, p__3);
		}
		public function sendEmo(p__1:int, p__2:int, p__3:*, p__4:String):void
		{
			var l__1 = ""+p__3;
			var l__2 = l__1.substr(0,1)
			
			if (l__2 == "1") {
				
			emoCtrl.sendEmo2(p__1, p__2, p__3);
			}
			else if (l__2 == "2") {
				emoCtrl.sendEmo(p__1, p__2, p__3, p__4);
			}
		}
		public function sendChips(p__1:Number, p__2:int, p__3:int):void
		{
			chipCtrl.sendChips(p__1, p__2, p__3);
		}
		public function updateUserGift(p__1:int, p__2:int, p__3:Number):void
		{
			
			giftCtrl.placeGift(p__1, p__2, p__3);
		}
		public function updateUserGift2(p__1:Number, p__2:int, p__3:Number):void
		{
			giftCtrl.placeGift2(p__1, p__2, p__3);
		}
		public function checkPhoneUser(p__1:int):void
		{
			var l__2:com.script.poker.PokerUser = ptModel.getUserBySit(p__1);
			if (l__2.sClientType == "iPhone"){
				giftCtrl.setPhoneIcon(p__1);
			}
		}
		public function iPhonePromo():void
		{
			dispatchEvent(new TVEvent(TVEvent.IPHONE_PRESSED));
		}
		public function showCongrat(p__1:String, p__2:Number):void
		{
			mcCongrat.visible = true;
			mcCongrat.usertf.text = p__1;
			mcCongrat.jacktf.text = StringUtility.StringToMoney(p__2);
			if (!(congratTimer == null) && congratTimer.running){
				congratTimer.removeEventListener(TimerEvent.TIMER, onCongratTimer);
				congratTimer.reset();
			} else {
				congratTimer = new Timer(5000);
			}
				
			congratTimer.addEventListener(TimerEvent.TIMER, onCongratTimer);
			congratTimer.start();
			
		}
		public function showCongratGJackpot(p__1:String, p__2:Number):void
		{
			
			mcCongratGJackpot.visible = true;
			mcCongratGJackpot.usertf.htmlText = "<center><b>"+p__1+"</b></center>";
			//mcCongratGJackpot.jacktf.text = StringUtility.StringToMoney(p__2);
			if (!(congratTimer2 == null) && congratTimer2.running){
				congratTimer2.removeEventListener(TimerEvent.TIMER, onCongratTimer2);
				congratTimer2.reset();
			} else {
				congratTimer2 = new Timer(5000);
			}
				
			congratTimer2.addEventListener(TimerEvent.TIMER, onCongratTimer2);
			congratTimer2.start();
			
		}
		private function onCongratTimer(p__1:flash.events.TimerEvent):void
		{
			congratTimer.removeEventListener(TimerEvent.TIMER, onCongratTimer);
			congratTimer.stop();
			mcCongrat.usertf.text = "";
			mcCongrat.jacktf.text = "";
			mcCongrat.visible = false;
		}
		private function onCongratTimer2(p__1:flash.events.TimerEvent):void
		{
			congratTimer2.removeEventListener(TimerEvent.TIMER, onCongratTimer2);
			congratTimer2.stop();
			mcCongratGJackpot.usertf.text = "";
			mcCongratGJackpot.visible = false;
		}
		private function onCongratClick(p__1:flash.events.MouseEvent):void
		{
			mcCongrat.usertf.text = "";
			mcCongrat.jacktf.text = "";
			mcCongrat.visible = false;
		}
		private function onCongratGJackpotClick(p__1:flash.events.MouseEvent):void
		{
			mcCongratGJackpot.usertf.text = "";
			mcCongratGJackpot.jacktf.text = "";
			mcCongratGJackpot.visible = false;
		}
		private function onJackpotOver(p__1:flash.events.MouseEvent):void
		{
			mcPaylist.visible = true;
			mcPaylist.jp_txt.text=langs.l_jppayout;
		}
		private function onJackpotOut(p__1:flash.events.MouseEvent):void
		{
			mcPaylist.visible = false;
		}
		public function showUserVIP(p__1:String):void
		{
			var l__2:com.script.poker.PokerUser = ptModel.getUserByZid(p__1);
			chickletCtrl.setVIP(l__2.nSit, l__2.bIsVip);
			
		}
		public function setTableInfo():void
		{
			var l__1:* = "Poker Server";
			if (ptModel.sServerName != null){
				l__1 = ptModel.sServerName;
			}
			//tableInfo.casinoTf.text = (l__1 + ":");
			var l__2:String = ptModel.room.roomName;
			tableInfo.txtblind.text = langs.l_blind+":";
			tableInfo.txtchips.text = langs.l_chip+":";
			provCont.txtmodal.text = langs.l_chip+":";
			tableInfo.tableTf.text = l__2;
			var l__3:String = ((("" + StringUtility.StringToMoney(ptModel.room.smallBlind, true, 3, false)) + " / ") + StringUtility.StringToMoney(ptModel.room.bigBlind, true, 3, false));
			if ((ptModel.room.gameType == "Tournament") && (ptModel.nTourneyId == -1)){
				l__3 = " ";
			}

			tableInfo.blindsTf.text = l__3;
		}
		public function updateBlinds():void
		{
			var l__1:String = ((("" + StringUtility.StringToMoney(ptModel.room.smallBlind, true, 3, false)) + " / ") + StringUtility.StringToMoney(ptModel.room.bigBlind, true, 3, false));
			tableInfo.blindsTf.text = l__1;
		}
		public function playRemindSound(p__1:*):void
		{
			dispatchEvent(new TVEPlaySound(TVEvent.PLAY_SOUND_ONCE, "PlayRemindSound", p__1));
		}
		public function playHurrySound(p__1:*):void
		{
			dispatchEvent(new TVEPlaySound(TVEvent.PLAY_SOUND_ONCE, "playHurrySound", p__1));
		}
		public function requestRefreshJoinUser(p__1:String):void
		{
			dispatchEvent(new TVERefreshJoinUserPressed(TVEvent.REFRESH_JOIN_USER_PRESSED, p__1));
		}
		public function refreshJoinUser(p__1:String):void
		{
			joinCtrl.updateJoinUserList(p__1);
			
			if ((p__1) == "friends"){
				joinButton.theText.updateText(("Online (" + ptModel.aJoinFriends.length) + ")");
				//joinButton.theText.updateText(("Live (" + ptModel.aJoinFriends.length) + ")");
			}
			joinButton.setZLStatus(ptModel.aJoinFriends.length);
		}
		public function requestJoinUser(p__1:String, p__2:Number, p__3:Number):void
		{
			dispatchEvent(new TVEJoinUserPressed(TVEvent.JOIN_USER_PRESSED, p__1, p__2, p__3));
		}
		public function launchVipPopup():void
		{
			dispatchEvent(new TVEvent(TVEvent.VIP_BADGE_PRESSED));
		}
		public function betSliderPressed():void
		{
			dispatchEvent(new TVEvent(TVEvent.BET_SLIDER_PRESSED));
		}
		public function betPlusPressed():void
		{
			dispatchEvent(new TVEvent(TVEvent.BET_PLUS_PRESSED));
		}
		public function betMinusPressed():void
		{
			dispatchEvent(new TVEvent(TVEvent.BET_MINUS_PRESSED));
		}
		public function betInputPressed():void
		{
			dispatchEvent(new TVEvent(TVEvent.BET_INPUT_PRESSED));
		}
		public function killClock():void
		{
			
			clock.resetClock();
		}
		public function updateHandStrength(p__1:String, p__2:String):void
		{
			handCtrl.setHandStrength(int(p__1), p__2);
		}
		public function updatePopupNextHand(p__1:Boolean = false, p__2:String = ""):void
		{
			mcPopupNextHand.visible = p__1;
			mcPopupNextHand.tfMessage.text = p__2;
		}
		public function updateBuyJackpot(p__1:Boolean = false, p__2:String = ""):void
		{
		
			var l__1:com.script.poker.PokerUser = ptModel.getUserByZid(ptModel.viewer.zid);
			if(l__1!= null){
				var l__5:* = gjControls.whichChecked;
				
				if(!(l__5 == null)){
					if(p__1 == false){
						l__5.checked = false;
						gjControls.whichChecked = null;
						l__5.iconMC.offState.visible = true;
						l__5.iconMC.onState.visible = false;
					}
				}
					//l__2.checked = false;
				
				/*if(!(p__1 == true))
				{
					
				}*/
				
				mcJackpotB.visible = p__1;
				gjControls.visible = p__1;
			
			}
			
		}
		public function updateBuyJackpotOff(p__1:Boolean = false, p__2:String = ""):void
		{
			
			mcJackpotB.visible = false;
			gjControls.visible = false;
			
			
			
		}
	}
}