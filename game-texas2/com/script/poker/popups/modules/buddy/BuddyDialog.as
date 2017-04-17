// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.buddy
{
	import flash.events.*;
	import caurina.transitions.*;
	import com.script.poker.popups.modules.events.*;
	import flash.display.*;
	import com.script.poker.table.asset.*;
	public class BuddyDialog extends flash.display.Sprite
	{
		public var btnAccept:*;
		public var pageUp:com.script.poker.popups.modules.buddy.PageButton;
		public var btnDeny:*;
		public var aInviteList:Array = new Array();
		public var onList:Number = 0;
		public var btnDeny2:*;
		public var btnDeny3:*;
		public var btnAccept2:*;
		public var btnAccept3:*;
		public var listMask:flash.display.Sprite;
		public var pipe:*;
		public const MIN_BUDDY_INVITES_TO_ALLOW_SCROLL:Number = 4;
		public var pageDown:com.script.poker.popups.modules.buddy.PageButton;
		public var hasPreflight:Boolean = true;
		public var idSelected:int;
		public var btnArray:Array = new Array();
		public var listCont:flash.display.Sprite;
		public var listUnits:Number = 0;
		public var btnIgnoreAll:*;
		public var btnDenyAll:*;
		public var btnAcceptAll:*;
		public var btnDone:*;
		public function BuddyDialog()
		{
			listCont = new flash.display.Sprite();
			listCont.x = 10;
			listCont.y = 80;
			addChild(listCont);
			listMask = new flash.display.Sprite();
			listMask.graphics.beginFill(16711680, 1);
			listMask.graphics.drawRect(0, 0, 215, 210);
			listMask.graphics.endFill();
			addChild(listMask);
			listMask.x = 5;
			listMask.y = 75;
			listCont.mask = listMask;
			makePageButtons();
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.myriad;
			btnAccept = new com.script.poker.table.asset.PokerButton(l__2, "medium", "Accept", null, 65, 3);
			btnDeny = new com.script.poker.table.asset.PokerButton(l__2, "medium", "Deny", null, 65, 3);
			btnAccept2 = new com.script.poker.table.asset.PokerButton(l__2, "medium", "Accept", null, 65, 3);
			btnDeny2 = new com.script.poker.table.asset.PokerButton(l__2, "medium", "Deny", null, 65, 3);
			btnAccept3 = new com.script.poker.table.asset.PokerButton(l__2, "medium", "Accept", null, 65, 3);
			btnDeny3 = new com.script.poker.table.asset.PokerButton(l__2, "medium", "Deny", null, 65, 3);
			btnAcceptAll = new com.script.poker.table.asset.PokerButton(l__2, "medium", "Accept All", null, 65, 3);
			btnDenyAll = new com.script.poker.table.asset.PokerButton(l__2, "medium", "Deny All", null, 65, 3);
			btnIgnoreAll = new com.script.poker.table.asset.PokerButton(l__2, "medium", "Ignore All", null, 65, 3);
			btnDone = new com.script.poker.table.asset.PokerButton(l__2, "large", "Done", null, 60, 3);
			btnAccept.x = btnAccept2.x = btnAccept3.x = btnAcceptAll.x = 225;
			btnDeny.x = btnDeny2.x = btnDeny3.x = btnDenyAll.x = 300;
			btnIgnoreAll.x = 220;
			btnAcceptAll.y = btnDenyAll.y = 45;
			btnIgnoreAll.y = 320;
			btnAccept.y = btnDeny.y = 100;
			btnAccept2.y = btnDeny2.y = 170;
			btnAccept3.y = btnDeny3.y = 240;
			btnAccept.pos = btnDeny.pos = 0;
			btnAccept2.pos = btnDeny2.pos = 1;
			btnAccept3.pos = btnDeny3.pos = 2;
			btnAccept.setActivity(true);
			btnDeny.setActivity(true);
			btnAccept2.setActivity(true);
			btnDeny2.setActivity(true);
			btnAccept3.setActivity(true);
			btnDeny3.setActivity(true);
			btnDone.x = 300;
			btnDone.y = 315;
			addChild(btnAccept);
			btnArray.AS3::push(btnAccept);
			addChild(btnDeny);
			btnArray.AS3::push(btnDeny);
			addChild(btnAccept2);
			btnArray.AS3::push(btnAccept2);
			addChild(btnDeny2);
			btnArray.AS3::push(btnDeny2);
			addChild(btnAccept3);
			btnArray.AS3::push(btnAccept3);
			addChild(btnDeny3);
			btnArray.AS3::push(btnDeny3);
			addChild(btnAcceptAll);
			addChild(btnDenyAll);
			addChild(btnDone);
			addChild(btnIgnoreAll);
			initListeners();
		}
		private function initListeners():void
		{
			btnAccept.addEventListener(flash.events.MouseEvent.CLICK, onAccept);
			btnAccept2.addEventListener(flash.events.MouseEvent.CLICK, onAccept);
			btnAccept3.addEventListener(flash.events.MouseEvent.CLICK, onAccept);
			btnDeny.addEventListener(flash.events.MouseEvent.CLICK, onDeny);
			btnDeny2.addEventListener(flash.events.MouseEvent.CLICK, onDeny);
			btnDeny3.addEventListener(flash.events.MouseEvent.CLICK, onDeny);
			btnAcceptAll.addEventListener(flash.events.MouseEvent.CLICK, onBuddyAcceptAll);
			btnDenyAll.addEventListener(flash.events.MouseEvent.CLICK, onBuddyDenyAll);
			btnIgnoreAll.addEventListener(flash.events.MouseEvent.CLICK, onBuddyIgnore);
			btnDone.addEventListener(flash.events.MouseEvent.CLICK, onBuddyDone);
		}
		private function removeListeners():void
		{
			btnAccept.removeEventListener(flash.events.MouseEvent.CLICK, onAccept);
			btnDeny.removeEventListener(flash.events.MouseEvent.CLICK, onDeny);
			btnDenyAll.removeEventListener(flash.events.MouseEvent.CLICK, onBuddyDenyAll);
			btnDone.removeEventListener(flash.events.MouseEvent.CLICK, onBuddyDone);
			btnIgnoreAll.removeEventListener(flash.events.MouseEvent.CLICK, onBuddyIgnore);
		}
		private function onAccept(p__1:flash.events.MouseEvent):void
		{
			var l__2:Number = 0;
			var l__3:Number = 0;
			var l__4:Number = 0;
			if (p__1.currentTarget.bActive){
				l__2 = onList * 3;
				l__3 = p__1.currentTarget.pos;
				l__4 = (l__2 + l__3);
				aInviteList[l__4].setApproval("approve");
			}
		}
		private function onDeny(p__1:flash.events.MouseEvent):void
		{
			var l__2:Number = 0;
			var l__3:Number = 0;
			var l__4:Number = 0;
			if (p__1.currentTarget.bActive){
				l__2 = onList * 3;
				l__3 = p__1.currentTarget.pos;
				l__4 = (l__2 + l__3);
				aInviteList[l__4].setApproval("deny");
			}
		}
		private function onIgnore(p__1:flash.events.MouseEvent):void
		{
			var l__2:Number = 0;
			var l__3:Number = 0;
			var l__4:Number = 0;
			if (p__1.currentTarget.bActive){
				l__2 = onList * 3;
				l__3 = p__1.currentTarget.pos;
				l__4 = (l__2 + l__3);
				aInviteList[l__4].setApproval("ignore");
			}
		}
		private function onBuddyAcceptAll(p__1:flash.events.MouseEvent):void
		{
			var l__4:* = undefined;
			var l__5:Object;
			var l__2:Array = new Array();
			var l__3:Array = new Array();
			for (l__4 in aInviteList){
				if (aInviteList[l__4] is com.script.poker.popups.modules.buddy.InviteListItem){
					l__5 = new Object();
					l__5.zid = aInviteList[l__4].zid;
					l__5.name = aInviteList[l__4].username;
					l__2.AS3::push(l__5);
				}
			}
			dispatchEvent(new com.script.poker.popups.modules.events.BDEvent(com.script.poker.popups.modules.events.BDEvent.BUDDY_ACCEPTALL, l__2, l__3));
		}
		private function onBuddyDenyAll(p__1:flash.events.MouseEvent):void
		{
			var l__4:* = undefined;
			var l__2:Array = new Array();
			var l__3:Array = new Array();
			for (l__4 in aInviteList){
				if (aInviteList[l__4] is com.script.poker.popups.modules.buddy.InviteListItem){
					l__3.AS3::push(aInviteList[l__4].zid);
				}
			}
			dispatchEvent(new com.script.poker.popups.modules.events.BDEvent(com.script.poker.popups.modules.events.BDEvent.BUDDY_DENYALL, l__2, l__3));
		}
		private function onBuddyDone(p__1:flash.events.MouseEvent):void
		{
			var l__4:* = undefined;
			var l__5:Object;
			var l__2:Array = new Array();
			var l__3:Array = new Array();
			for (l__4 in aInviteList){
				if (aInviteList[l__4] is com.script.poker.popups.modules.buddy.InviteListItem){
					if (aInviteList[l__4].approved == "approve"){
						l__5 = new Object();
						l__5.zid = aInviteList[l__4].zid;
						l__5.name = aInviteList[l__4].username;
						l__2.AS3::push(l__5);
					}
					if (aInviteList[l__4].approved == "deny"){
						l__3.AS3::push(aInviteList[l__4].zid);
					}
				}
			}
			dispatchEvent(new com.script.poker.popups.modules.events.BDEvent(com.script.poker.popups.modules.events.BDEvent.BUDDY_DONE, l__2, l__3));
		}
		public function onBuddyIgnore(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.BDEvent(com.script.poker.popups.modules.events.BDEvent.BUDDY_IGNOREALL));
		}
		public function checkApprovalButtons():void
		{
			var l__2:Number = 0;
			var l__3:Number = 0;
			var l__1:int;
			while(l__1 < 3){
				l__2 = onList * 3;
				l__3 = (l__2 + l__1);
				if (aInviteList[l__3] is com.script.poker.popups.modules.buddy.InviteListItem){
					setApprovalButtons(l__1, true);
				} else {
					setApprovalButtons(l__1, false);
				}
				l__1++;
			}
		}
		public function setApprovalButtons(p__1:int, p__2:Boolean):void
		{
			var l__3:* = undefined;
			for (l__3 in btnArray){
				if ((p__1) == btnArray[l__3].pos){
					if (!(p__2)){
						btnArray[l__3].alpha = 0.5;
						btnArray[l__3].mouseEnabled = false;
						btnArray[l__3].mouseChildren = false;
					} else if (p__2){
						btnArray[l__3].alpha = 1;
						btnArray[l__3].mouseEnabled = true;
						btnArray[l__3].mouseChildren = true;
					}
				}
			}
		}
		public function populate(p__1:Array):void
		{
			var l__5:* = undefined;
			var l__6:int;
			var l__7:* = undefined;
			var l__8:* = undefined;
			var l__9:flash.display.Sprite;
			var l__2:int;
			while(listCont.numChildren > 0){
				l__7 = listCont.getChildAt(l__2);
				listCont.removeChild(l__7);
				l__7 = null;
			}
			aInviteList = [];
			var l__3:Array = p__1;
			var l__4:int;
			if ((l__3.length % 3) != 0){
				l__4 = (3 - (l__3.length % 3));
			}
			listUnits = (l__3.length < MIN_BUDDY_INVITES_TO_ALLOW_SCROLL) ? 0 : Math.ceil(l__3.length / 3);
			onList = 0;
			for (l__5 in l__3){
				
				l__8 = new com.script.poker.popups.modules.buddy.InviteListItem(l__5, l__3[l__5].sZid, l__3[l__5].nShoutId, l__3[l__5].sPicUrl, l__3[l__5].sName);
				l__8.y = l__5 * 70;
				listCont.addChild(l__8);
				aInviteList.AS3::push(l__8);
			}
			l__6 = 0;
			while(l__6 < l__4){
				l__9 = new flash.display.Sprite();
				l__9.graphics.beginFill(13421772, 1);
				l__9.graphics.drawRect(0, 0, 205, 60);
				l__9.graphics.endFill();
				l__9.y = aInviteList.length * 70;
				listCont.addChild(l__9);
				aInviteList.AS3::push(l__9);
				l__6++;
			}
			setPageButtons();
			checkApprovalButtons();
		}
		public function makePageButtons():void
		{
			pageUp = new com.script.poker.popups.modules.buddy.PageButton(true);
			pageDown = new com.script.poker.popups.modules.buddy.PageButton(false);
			addChild(pageUp);
			addChild(pageDown);
			pageUp.addEventListener(flash.events.MouseEvent.CLICK, pageButtonClick);
			pageDown.addEventListener(flash.events.MouseEvent.CLICK, pageButtonClick);
			pageUp.y = 60;
			pageDown.y = 300;
			pageUp.x = 110;
			pageDown.x = 110;
		}
		public function setPageButtons():void
		{
			if (listUnits == 0){
				pageUp.setActive(false);
				pageDown.setActive(false);
			} else if (onList == 0){
				pageUp.setActive(false);
				pageDown.setActive(true);
			} else if (!(onList == 0) && ((onList + 1) == listUnits)){
				pageUp.setActive(true);
				pageDown.setActive(false);
			} else {
				pageUp.setActive(true);
				pageDown.setActive(true);
			}
		}
		public function pageButtonClick(p__1:flash.events.MouseEvent):void
		{
			if (p__1.currentTarget.isActive){
				if (p__1.currentTarget.up){
					onList--;
					caurina.transitions.Tweener.addTween(listCont, {y:(listCont.y + 210), time:0.5, transition:"easeInOutSine"});
				} else if (!(p__1.currentTarget.up)){
					onList++;
					caurina.transitions.Tweener.addTween(listCont, {y:(listCont.y - 210), time:0.5, transition:"easeInOutSine"});
				}
				setPageButtons();
				checkApprovalButtons();
			}
		}
		public function phonyData():void
		{
			var l__1:Array = new Array();
			var l__2:* = new Object();
			l__2.sZid = "7:3152645";
			l__2.sShoutId = "89562314";
			l__2.sPicUrl = "dummy/chris.jpg";
			l__2.sName = "Christopher Delbuck";
			l__1.AS3::push(l__2);
			var l__3:* = new Object();
			l__3.sZid = "2:9451236";
			l__3.sShoutId = "10254135";
			l__3.sPicUrl = "dummy/chris.jpg";
			l__3.sName = "Matt Rooney";
			l__1.AS3::push(l__3);
			var l__4:* = new Object();
			l__4.sZid = "1:9456236";
			l__4.sShoutId = "4564135";
			l__4.sPicUrl = "dummy/chris.jpg";
			l__4.sName = "Marcus Turcotte";
			l__1.AS3::push(l__4);
			var l__5:* = new Object();
			l__5.sZid = "1:9456236";
			l__5.sShoutId = "4564135";
			l__5.sPicUrl = "dummy/chris.jpg";
			l__5.sName = "James Young";
			l__1.AS3::push(l__5);
			l__2 = null;
			l__3 = null;
			l__4 = null;
			l__5 = null;
			l__2 = new Object();
			l__2.sZid = "7:3152645";
			l__2.sShoutId = "89562314";
			l__2.sPicUrl = "dummy/chris.jpg";
			l__2.sName = "Christopher Delbuck";
			l__1.AS3::push(l__2);
			l__3 = new Object();
			l__3.sZid = "2:9451236";
			l__3.sShoutId = "10254135";
			l__3.sPicUrl = "dummy/chris.jpg";
			l__3.sName = "Matt Rooney";
			l__1.AS3::push(l__3);
			l__4 = new Object();
			l__4.sZid = "1:9456236";
			l__4.sShoutId = "4564135";
			l__4.sPicUrl = "dummy/chris.jpg";
			l__4.sName = "Marcus Turcotte Te";
			l__1.AS3::push(l__4);
			l__5 = new Object();
			l__5.sZid = "1:9456236";
			l__5.sShoutId = "4564135";
			l__5.sPicUrl = "dummy/chris.jpg";
			l__5.sName = "Marcus Turcotte Te";
			l__1.AS3::push(l__5);
			populate(l__1);
		}
	}
}