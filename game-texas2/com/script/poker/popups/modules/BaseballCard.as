// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules
{
	import flash.events.*;
	import flash.net.*;
	import com.script.poker.popups.modules.events.*;
	import flash.display.*;
	import flash.text.*;
	import com.script.poker.table.asset.*;         
	import com.script.display.*;
	public class BaseballCard extends flash.display.Sprite
	{
		public var sZid:String;
		public var vipCheckbox:*;
		public var maxGiftSend:Number = 0;
		public var feedCheck:flash.display.MovieClip;
		public var btnItems:flash.display.MovieClip;
		public var btnBuyItems:flash.display.MovieClip;
		
		public var btnDone:flash.display.MovieClip;
		private var _rank:Number = 0;
		private var _lev:String = "n/a";
		public var btnGiveChips:*;
		public var btnAddBuddy:*;
		private var _chips:String = "n/a";
		public var btnProfile:*;
		public var pipe:* = true;
		private var _owner:Boolean = false;
		public var vipMarker:flash.display.MovieClip;
		public var btnShowGift:*;
		public var btnAbuse:*;
		
		public var usernameField:flash.text.TextField;
		//public var btnBuyItems:*;
		private var curIcon:*;
		public var hasPreflight:* = true;
		public var mcRank:flash.display.MovieClip;
		public var amtBox:AmountBox;
		private var _name:String = "n/a";
		public var vipCheck:*;
		private var _vip:Boolean = false;
		public var muteCheck:*;
		private var _network:String = "n/a";
		public var MidButton:*;
		public var muteCheckbox:*;
		//public var btnDone:*;
		public var langs;
		public function BaseballCard()
		{
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.myriad;
			var l__3:* = p__1.font1;
			var l__4:* = new l__3();
			usernameField = l__4.field;
			usernameField.x = 45.35;
			usernameField.y = 130;
			usernameField.width = 200;
			usernameField.height = 50;
			usernameField.embedFonts = false;
			addChild(usernameField);
			usernameField.visible = true
			vipMarker.visible = false;
			btnBuyItems.visible = false;
			btnItems.txt.text =  langs.l_inventory;
			btnBuyItems.txt.text = langs.l_buygift;
			btnItems.buttonMode = true;
			btnBuyItems.buttonMode = true;
			//btnProfile = new com.script.poker.table.asset.PokerButton(l__2, "medium", "View Profile", null, 100, 3);
			btnAbuse = new com.script.poker.table.asset.PokerButton(l__2, "medium", langs.l_reportabuse, null, 100, 3);
			//btnBuyItems = new com.script.poker.table.asset.PokerButton(l__2, "large", langs.l_buygift, null, 100, 3);
			//btnShowGift = new com.script.poker.table.asset.PokerButton(l__2, "medium", "Today\'s Gifts", null, 100, 3);
			//btnItems = new com.script.poker.table.asset.PokerButton(l__2, "large", langs.l_inventory, null, 100, 3);
			//btnGiveChips = new com.script.poker.table.asset.PokerButton(l__2, "medium", "Give Chips", null, 100, 3);
			btnAddBuddy = new com.script.poker.table.asset.PokerButton(l__2, "medium", langs.l_addbuddy, null, 100, 3);
			//btnDone = new com.script.poker.table.asset.PokerButton(l__2, "large", langs.l_done, null, 73, 5);
			//btnProfile.x = 173;
			//btnShowGift.x = 173;
			muteCheck.txt.text = langs.l_hideuserchat;
			btnAbuse.x = 10;
			//btnBuyItems.x = 173;
			//btnItems.x = 173;
			//btnGiveChips.x = 173;
			btnAddBuddy.x = 173;
			//btnDone.x = 200;
			//btnProfile.y = 10;
			btnAbuse.y = 250;
			//btnBuyItems.y = 62;
			//btnGiveChips.y = 123;
			//btnShowGift.y = 36;
			//btnItems.y = 36;
			btnAddBuddy.y = 88;
			//btnDone.y = 250;
			amtBox = new AmountBox();
			amtBox.x = 173;
			amtBox.y = 147;
			muteCheckbox = new com.script.display.Toggle(CkBack, CkOver, CkDisabled);
			vipCheckbox = new com.script.display.Toggle(CkBack, CkOver, CkDisabled);
			vipCheckbox.width = 14;
			vipCheckbox.height = 14;
			vipCheckbox.x = -vipCheckbox.width;
			muteCheckbox.width = 14;
			muteCheckbox.height = 14;
			vipCheck.addChild(vipCheckbox);
			muteCheck.addChild(muteCheckbox);
			//addChild(btnProfile);
			addChild(btnAbuse);
			//addChild(btnBuyItems);
			//addChild(btnGiveChips);
			//addChild(btnAddBuddy);
			//addChild(btnDone);
			addChild(amtBox);
			//addChild(btnShowGift);
			//addChild(btnItems);
			initListeners();
			feedCheck.onState.visible = true;
			feedCheck.offState.visible = false;
			feedCheck.buttonMode = true;
			feedCheck.useHandCursor = true;
			var l__5:int = getChildIndex(feedCheck);
			var l__6:* = getChildAt(this.numChildren - 1);
			var l__7:int = getChildIndex(l__6);
			this.swapChildrenAt(l__5, l__7);
			checkVip();
			checkMute();
			amtBox.field.restrict = "0-9";
			mcRank.visible = false;
		}
		private function initListeners():void
		{
			//btnProfile.addEventListener(flash.events.MouseEvent.CLICK, onProfile);
			btnAbuse.addEventListener(flash.events.MouseEvent.CLICK, onAbuse);
			btnBuyItems.addEventListener(flash.events.MouseEvent.CLICK, onGiftMenu);
			//btnGiveChips.addEventListener(flash.events.MouseEvent.CLICK, onChipGift);
			//btnAddBuddy.addEventListener(flash.events.MouseEvent.CLICK, onBuddy);
			btnDone.addEventListener(flash.events.MouseEvent.CLICK, onDone);
			//btnShowGift.addEventListener(flash.events.MouseEvent.CLICK, onStuff);
			btnItems.addEventListener(flash.events.MouseEvent.CLICK, onItems);
			vipCheckbox.addEventListener(flash.events.MouseEvent.CLICK, onShowVip);
			muteCheckbox.addEventListener(flash.events.MouseEvent.CLICK, onMuteUser);
			feedCheck.addEventListener(flash.events.MouseEvent.CLICK, onFeedCheck);
			amtBox.addEventListener(flash.events.FocusEvent.FOCUS_IN, onFieldFocus);
		}
		private function removeListeners():void
		{
			//btnProfile.removeEventListener(flash.events.MouseEvent.CLICK, onProfile);
			btnAbuse.removeEventListener(flash.events.MouseEvent.CLICK, onAbuse);
			btnBuyItems.removeEventListener(flash.events.MouseEvent.CLICK, onGiftMenu);
			//btnGiveChips.removeEventListener(flash.events.MouseEvent.CLICK, onChipGift);
			//btnAddBuddy.removeEventListener(flash.events.MouseEvent.CLICK, onBuddy);
			btnDone.removeEventListener(flash.events.MouseEvent.CLICK, onDone);
		//	btnShowGift.removeEventListener(flash.events.MouseEvent.CLICK, onStuff);
			btnItems.removeEventListener(flash.events.MouseEvent.CLICK, onItems);
			vipCheckbox.removeEventListener(flash.events.MouseEvent.CLICK, onShowVip);
			muteCheckbox.removeEventListener(flash.events.MouseEvent.CLICK, onMuteUser);
			feedCheck.removeEventListener(flash.events.MouseEvent.CLICK, onFeedCheck);
			amtBox.removeEventListener(flash.events.FocusEvent.FOCUS_IN, onFieldFocus);
		}
		private function onFieldFocus(evt:flash.events.FocusEvent)
		{
			var catchReturn:Function;
			catchReturn = function(p__1:flash.events.KeyboardEvent):void
			{
				if (getGiftAmt() < 0){
					amtBox.field.text = "0";
				}
				if (getGiftAmt() > maxGiftSend){
					amtBox.field.text = maxGiftSend.AS3::toString();
				} else if ((p__1.charCode) == 13){
					sendChips();
				}
			};
			amtBox.addEventListener(flash.events.KeyboardEvent.KEY_UP, catchReturn);
		}
		private function onProfile(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.BBCardEvent(com.script.poker.popups.modules.events.BBCardEvent.PROFILE, sZid));
		}
		private function onAbuse(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.BBCardEvent(com.script.poker.popups.modules.events.BBCardEvent.ABUSE, sZid));
		}
		private function onGiftMenu(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.BBCardEvent(com.script.poker.popups.modules.events.BBCardEvent.GIFT_MENU, sZid));
		}
		private function onItems(event:MouseEvent) : void
        {
            dispatchEvent(new com.script.poker.popups.modules.events.BBCardEvent(com.script.poker.popups.modules.events.BBCardEvent.SHOW_ITEMS, sZid, false, false, this._name));
            return;
        }
		private function onChipGift(p__1:flash.events.MouseEvent):void
		{
			sendChips();
		}
		private function onBuddy(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.BBCardEvent(com.script.poker.popups.modules.events.BBCardEvent.ADD_BUDDY, sZid));
		}
		private function onDone(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.BBCardEvent(com.script.poker.popups.modules.events.BBCardEvent.DONE, sZid));
		}
		private function onStuff(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.BBCardEvent(com.script.poker.popups.modules.events.BBCardEvent.SHOW_GIFT, sZid));
		}
		private function onShowVip(p__1:flash.events.MouseEvent):void
		{
			vipMarker.visible = vipChecked;
			dispatchEvent(new com.script.poker.popups.modules.events.BBCardEvent(com.script.poker.popups.modules.events.BBCardEvent.SHOW_VIP, sZid, false, vipChecked));
		}
		private function onMuteUser(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.BBCardEvent(com.script.poker.popups.modules.events.BBCardEvent.MUTE_USER, sZid, muteChecked, false));
		}
		private function onFeedCheck(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.BBCardEvent(com.script.poker.popups.modules.events.BBCardEvent.FEED_CHECK, sZid));
			swapFeedCheck();
		}
		private function getGiftAmt():Number
		{
			var l__1:Number = Number(amtBox.field.text);
			if (isNaN(l__1)){
				return(-1);
			}
			return(l__1);
		}
		public function set username(p__1:String)
		{
			_name = p__1;
			populateStrings();
			if (pipe){
			}
		}
		public function set level(p__1:String)
		{
			_lev = p__1;
			populateStrings();
		}
		public function set rank(p__1:Number)
		{
			_rank = p__1;
			if (_rank > 0){
				//mcRank.visible = true;
				mcRank.visible = false;
				//mcRank.gotoAndStop(_rank);
			} else {
				mcRank.visible = false;
			}
		}
		public function set network(p__1:String)
		{
			_network = p__1;
			populateStrings();
		}
		public function set vip(p__1:Boolean)
		{
			_vip = p__1;
			vipMarker.visible = p__1;
			vipChecked = p__1;
			checkVip();
			checkMute();
		}
		public function set icon(ico:String):void
		{
			if (curIcon){
				removeChild(curIcon);
			}
			var tmp = new flash.display.Sprite();
			curIcon = new com.script.display.SafeImageLoader();
			curIcon.x = 100;
			curIcon.y = 36;
			curIcon.scaleX = 500;
			curIcon.scaleY =500;
			
			
			try {
				curIcon.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onCurIconComplete);
				curIcon.load(new flash.net.URLRequest(ico));
				addChild(curIcon);
			} catch (err:Error) {
			}
		}
		public function set chips(p__1:*)
		{
			_chips = String(p__1);
			populateStrings();
		}
		public function set isOwner(p__1:Boolean)
		{
			_owner = p__1;
			//checkVip();
			checkMute();
		}
		private function populateStrings()
		{
			var l__1:String = _network;
			if (_network.length > 10){
				l__1 = (_network.AS3::substring(0, 10) + "...");
			}
			//var l__2:* = (((((("<b>Chips:</b> " + _chips) + "<br><b>Network:</b> ") + l__1) + "<br><b>Level:</b> ") + _lev) + "");
			
			var l__2:* = ((("<b>"+langs.l_name+": " + _name) +"</b><br><b>"+langs.l_chip+": " + _chips)+ "</b>");
			
			usernameField.htmlText = l__2;
		}
		private function onCurIconComplete(p__1:flash.events.Event)
		{
			curIcon.height = 90;
			
			curIcon.scaleX = curIcon.scaleY;
			if (curIcon.width > 85){
				curIcon.width = 85;
				curIcon.scaleY = curIcon.scaleX;
			}if (curIcon.width < 85){
				curIcon.width = 85;
				curIcon.scaleY = curIcon.scaleX;
			}
			
		}
		private function checkMute()
		{
			if (_owner){
				muteCheck.visible = false;
			} else {
				muteCheck.visible = true;
			}
		}
		private function checkVip()
		{
			if (_owner && _vip){
				vipCheck.visible = true;
			} else {
				vipCheck.visible = false;
			}
		}
		public function get vipChecked()
		{
			return(vipCheckbox.value);
		}
		public function set vipChecked(p__1:Boolean)
		{
			vipCheckbox.value = p__1;
			vipMarker.visible = p__1;
		}
		public function get muteChecked()
		{
			return(muteCheckbox.value);
		}
		public function set muteChecked(p__1:Boolean)
		{
			muteCheckbox.value = p__1;
		}
		private function sendChips():void
		{
			var l__1:Number = getGiftAmt();
			if (l__1 > 0){
				amtBox.field.text = "";
				dispatchEvent(new com.script.poker.popups.modules.events.BBCGiftEvent(com.script.poker.popups.modules.events.BBCardEvent.GIFT_CHIPS, sZid, l__1));
			}
		}
		public function swapFeedCheck():void
		{
			feedCheck.onState.visible = !feedCheck.onState.visible;
			feedCheck.offState.visible = !feedCheck.offState.visible;
		}
		public function showCheck():void
		{
			feedCheck.onState.visible = true;
			feedCheck.offState.visible = false;
		}
	}
}