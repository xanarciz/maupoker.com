// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.DSGPanel
{
	import flash.events.*;
	import flash.display.*;
	import flash.filters.*;
	import com.script.poker.table.*;
	import ws.tink.events.*;
	import flash.utils.*;
	import com.script.poker.popups.modules.events.*;
	import com.script.poker.table.asset.*;
	import flash.net.*;
	public class DSGPanel extends flash.display.MovieClip
	{
		trace("hahaha");
		public var sZid:String;
		public var cancelBtn:*;
		private var tabSet:Array;
		private var aGiftItems:Array;
		public var feedCheck:flash.display.MovieClip;
		private var sPanelMode:String = "buy";
		private var mImageList:Array = null;
		public var pipe:*;
		private var holder:flash.display.Sprite;
		public var wtBtn:*;
		private var buyTimerActive:Boolean = false;
		private var xJump:Number = 80;
		private var yJump:Number = 100;
		private var aPokerUsers:Array;
		public var bShowNone:Boolean = false;
		private var curIcon:flash.display.Loader;
		private var mItemList:Array = null;
		public var nTotalPlayers:Number = 0;
		private var buyTimer:flash.utils.Timer;
		public var bIsOwner:Boolean;
		public var nChips:Number = 0;
		public var nCurrentTab:Number = 0;
		private var mOffTableChipsNote:OffTableChipsNote = null;
		public var sViewerZid:String;
		public var buyBtn:*;
		private var _selected:* = null;
		public var langs;
		public function DSGPanel()
		{
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.myriad;
			holder = new flash.display.Sprite();
			addChild(holder);
			holder.filters = new Array(makeDrop());
			wtBtn = new com.script.poker.table.asset.PokerButton(l__2, "large", langs.l_buyevery, null, 125, 5, 36, -2);
			buyBtn = new com.script.poker.table.asset.PokerButton(l__2, "large", langs.l_buy, null, 125, 5);
			cancelBtn = new com.script.poker.table.asset.PokerButton(l__2, "large", langs.l_cancel, null, 125, 5);
			wtBtn.x = 20;
			wtBtn.y = 360;
			buyBtn.x = 160;
			buyBtn.y = 360;
			cancelBtn.x = 300;
			cancelBtn.y = 360;
			addChild(wtBtn);
			addChild(buyBtn);
			addChild(cancelBtn);
			feedCheck.onState.visible = true;
			feedCheck.offState.visible = false;
			feedCheck.buttonMode = true;
			feedCheck.useHandCursor = true;
			feedCheck.visible = false;
			var l__3:int = getChildIndex(feedCheck);
			var l__4:* = getChildAt(this.numChildren - 1);
			var l__5:int = getChildIndex(l__4);
			this.swapChildrenAt(l__3, l__5);
		}
		private function initListeners():void
		{
			wtBtn.addEventListener(flash.events.MouseEvent.CLICK, onBuyForTable);
			buyBtn.addEventListener(flash.events.MouseEvent.CLICK, onBuy);
			cancelBtn.addEventListener(flash.events.MouseEvent.CLICK, onCancel);
			feedCheck.addEventListener(flash.events.MouseEvent.CLICK, onFeedCheck);
		}
		private function removeListeners():void 
		{
			wtBtn.removeEventListener(flash.events.MouseEvent.CLICK, onBuyForTable);
			buyBtn.removeEventListener(flash.events.MouseEvent.CLICK, onBuy);
			cancelBtn.removeEventListener(flash.events.MouseEvent.CLICK, onCancel);
			feedCheck.removeEventListener(flash.events.MouseEvent.CLICK, onFeedCheck);
		}
		private function onBuy(p__1:flash.events.MouseEvent):void
		{
			if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_BUY){
				startBuyTimer();
				dispatchEvent(new com.script.poker.popups.modules.events.DSGBuyEvent(com.script.poker.popups.modules.events.DSGEvent.BUYGIFT, sZid, GetCurrentTabCategoryId(), _selected, false, false));
			} else if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_SELECT){
				dispatchEvent(new com.script.poker.popups.modules.events.DSGBuyEvent(com.script.poker.popups.modules.events.DSGEvent.DISPLAY_NONE, "", GetCurrentTabCategoryId(), -1, false, false));
			} else if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_DISPLAY){
			}
		}
		private function onBuyForTable(p__1:flash.events.MouseEvent):void
		{
			if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_BUY){
				startBuyTimer();
				dispatchEvent(new com.script.poker.popups.modules.events.DSGBuyEvent(com.script.poker.popups.modules.events.DSGEvent.BUYFORTABLE, sZid, GetCurrentTabCategoryId(), _selected, true, false));
			} else if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_SELECT){
				dispatchEvent(new com.script.poker.popups.modules.events.DSGBuyEvent(com.script.poker.popups.modules.events.DSGEvent.DISPLAY_SELECTED, "", GetCurrentTabCategoryId(), _selected, true, false));
			} else if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_DISPLAY){
			}
		}
		public function onCancel(p__1:flash.events.MouseEvent):void
		{
			stopBuyTimer(false);
			clear_all_tabs();
			dispatchEvent(new com.script.poker.popups.modules.events.DSGEvent(com.script.poker.popups.modules.events.DSGEvent.CANCEL, sZid));
		}
		private function onFeedCheck(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.DSGEvent(com.script.poker.popups.modules.events.DSGEvent.FEED_CHECK, ""));
			swapFeedCheck();
		}
		public function set icon(p__1:String):void
		{
			if (curIcon && contains(curIcon)){
				removeChild(curIcon);
			}
			if ((p__1) != ""){
				curIcon = new flash.display.Loader();
				curIcon.x = 435;
				curIcon.y = 15;
				curIcon.scaleX = 1;
				curIcon.scaleX = 1;
				curIcon.contentLoaderInfo.addEventListener(flash.events.Event.INIT, sizeIcon);
				curIcon.load(new flash.net.URLRequest(p__1));
				curIcon.filters = new Array(makeDrop());
				curIcon.visible = false
				addChild(curIcon);
			}
		}
		private function sizeIcon(p__1:*):void
		{
			var l__2:Number = 120;
			var l__3:Number = 170;
			curIcon.width = l__2;
			curIcon.scaleY = curIcon.scaleX;
			if (curIcon.height > l__3){
				curIcon.height = l__3;
				curIcon.scaleX = curIcon.scaleY;
			}
			if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_BUY){
				if (mOffTableChipsNote == null){
					mOffTableChipsNote = new OffTableChipsNote();
					addChild(mOffTableChipsNote);
				}
				mOffTableChipsNote.x = (curIcon.x + (l__2 * 0.5));
				mOffTableChipsNote.y = (curIcon.y + curIcon.height);
				mOffTableChipsNote.visible = false;
			}
		}
		public function GetCurrentTabCategoryId():Number
		{
			if (nCurrentTab >= 0){
				return(tabSet[nCurrentTab].tabTop.GiftCatID);
			}
			return(-1);
		}
		public function populate_current_tab()
		{
			var l__1:* = nCurrentTab;
			if (tabSet == null){
				return;
			}
			if ((l__1 < 0) && (l__1 >= (tabSet.length - 1))){
				return;
			}
			populate_tab_withGiftCategory(tabSet[l__1].tabTop.ID, tabSet[l__1].tabTop.GiftCatID, tabSet[l__1].tabTop.inSenderName, tabSet[l__1].tabTop.panelmode);
		}
		public function clear_all_tabs()
		{
			if (mItemList == null){
				return;
			}
			var l__1 = 0 ;
			while(l__1 < mItemList.length){
				clear_tab(l__1);
				l__1++;
			}
		}
		public function clear_tab(p__1:Number)
		{
			var l__3:* = undefined;
			var l__4:* = undefined;
			var l__2:* = p__1;
			if (mImageList && !(mImageList[l__2] == null)){
				while(mImageList[l__2].length > 0){
					l__3 = mImageList[l__2].pop();
					com.script.poker.table.GiftLibrary.GetInst().ReleaseGiftMovieClip(l__3);
				}
			}
			if (mItemList && !(mItemList[l__2] == null)){
				while(mItemList[l__2].length > 0){
					l__4 = mItemList[l__2].pop();
					if (((l__4 && tabSet) && tabSet[l__2]) && tabSet[l__2].contains(l__4)){
						tabSet[l__2].removeChild(l__4);
					}
				}
			}
		}
		public function populate_tab_withGiftCategory(p__1:Number, p__2:String, p__3:Array = null, p__4:String = "buy")
		{
			trace("wow1");
			var l__13:com.script.poker.table.GiftItem;
			var l__14:singleItem;
			var l__15:Number = 0;
			var l__5:* = p__1;
			var l__6:Number = 0;
			var l__7:com.script.poker.table.GiftCategory = com.script.poker.table.GiftLibrary.GetInst().GetGiftCategory(p__2);
			if (l__7 == null){
				return;
			}
			var l__8:* = l__7.maGiftsInCat ? l__7.maGiftsInCat.length : 0;
			var l__9:*;
			clear_tab(p__1);
			mImageList[l__5] = new Array();
			mItemList[l__5] = new Array();
			var l__10:flash.display.MovieClip;
			var l__11:* = true;
			if (l__8 == 0){
				tabSet[l__5].altcontent.text = "These gifts are not available to underage users on Facebook. Sorry!";
			} else {
				tabSet[l__5].altcontent.text = "";
			}
			var l__12 = 0;
			while(l__12 < l__8){
				l__13 = com.script.poker.table.GiftLibrary.GetInst().GetGift(l__7.maGiftsInCat[l__12]);
				l__14 = new singleItem();
				l__15 = 0;
				l__10 = null;
				l__15 = l__6;
				l__14.ID = (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_BUY) ? l__13.mnId : l__6;
				l__14.x = (50 + (xJump * (l__15 % 5)));
				l__14.y = (65 + (yJump * Math.floor(l__15 / 5)));
				mItemList[l__5].push(l__14);
				if (l__13.mbGreyOut){
					l__14.alpha = 0.5;
					l__14.disable();
					l__14.info.htmlText = (((("<font color=\'#CCCCCC\'><b>" + l__13.msName) + "</b><br>") + l__13.mnPrice) + "</font>");
				} else {
					l__14.addEventListener(flash.events.MouseEvent.CLICK, highlight);
					l__14.addEventListener(flash.events.MouseEvent.MOUSE_OVER, over);
					l__14.addEventListener(flash.events.MouseEvent.MOUSE_OUT, out);
					l__14.info.htmlText = ((("<b>" + l__13.msName) + "</b><br>") + l__13.mnPrice);
				}
				if (bIsOwner){
					if (l__11){
						l__10 = com.script.poker.table.GiftLibrary.GetInst().CreateGiftMovieClip(1, Number(l__13.mnId));
						if (l__10){
							l__14.pic.addChild(l__10);
							mImageList[l__5].push(l__10);
						}
						tabSet[l__5].addChild(l__14);
					} else {
						tabSet[l__5].altcontent.text = "These gifts are no longer available to underage users on Facebook. Sorry!";
					}
				} else if (l__11){
					l__10 = com.script.poker.table.GiftLibrary.GetInst().CreateGiftMovieClip(1, Number(l__13.mnId));
					if (l__10){
						l__14.pic.addChild(l__10);
						mImageList[l__5].push(l__10);
					}
					tabSet[l__5].addChild(l__14);
				} else {
					tabSet[l__5].altcontent.text = "This user has elected not to receive these gifts.";
				}
				l__6++;
				l__12++;
			}
		}
		public function populate_tab_withSpecificGifts(p__1:Number, p__2:Array, p__3:Array = null, p__4:String = "buy")
		{
			trace("wow2");
			var l__12:com.script.poker.table.GiftItem;
			var l__13:* = undefined;
			var l__14:Number = 0;
			var l__15:String;
			var l__5:* = p__1;
			var l__6:Number = 0;
			var l__7:* = (p__2) ? (p__2.length) : 0;
			var l__8:* = 0;
			clear_tab(p__1);
			mImageList[l__5] = new Array();
			mItemList[l__5] = new Array();
			var l__9:flash.display.MovieClip;
			var l__10:* = true;
			bShowNone = l__7 > 0;
			var l__11 = 0;
			while(l__11 < l__7){
				l__12 = com.script.poker.table.GiftLibrary.GetInst().GetGift(p__2[l__11]);
				l__10 = isGiftIdAllowed(l__12.mnId);
				if (!l__10){
				} else {
					l__13 = new singleItem();
					l__14 = 0;
					l__9 = null;
					l__14 = l__6;
					l__13.ID = (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_BUY) ? l__12.mnId : l__6;
					l__13.x = (50 + (xJump * (l__14 % 5)));
					l__13.y = (65 + (yJump * Math.floor(l__14 / 5)));
					mItemList[l__5].push(l__13);
					if ((sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_SELECT) || (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_DISPLAY)){
						l__15 = p__3[l__6];
						if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_SELECT){
							l__13.addEventListener(flash.events.MouseEvent.CLICK, highlight);
							l__13.addEventListener(flash.events.MouseEvent.MOUSE_OVER, over);
							l__13.addEventListener(flash.events.MouseEvent.MOUSE_OUT, out);
						} else {
							l__13.disable();
						}
						l__13.info.htmlText = (((("<b>" + l__12.msName) + "</b><br><font color=\'#009900\'><b>") + l__15) + "</b></font>");
						l__9 = com.script.poker.table.GiftLibrary.GetInst().CreateGiftMovieClip(l__8, l__12.mnId);
						if (l__9){
							l__13.pic.addChild(l__9);
							mImageList[l__5].push(l__9);
						}
						tabSet[l__5].addChild(l__13);
					} else {
						l__13.disable();
						l__13.info.htmlText = (((("<font color=\'#CCCCCC\'><b>" + l__12.msName) + "</b><br>") + l__12.mnPrice) + "</font>");
						l__9 = com.script.poker.table.GiftLibrary.GetInst().CreateGiftMovieClip(l__8, l__12.mnId);
						if (l__9){
							l__13.pic.addChild(l__9);
							mImageList[l__5].push(l__9);
						}
						tabSet[l__5].addChild(l__13);
					}
					l__6++;
				}
				l__11++;
			}
		}
		public function populate_buy(p__1:Array, p__2:Number, p__3:Array, p__4:Array = null, p__5:String = "buy")
		{
			var l__6:* = undefined;
			var l__7:Number = 0;
			var l__8:com.script.poker.table.GiftCategory;
			nCurrentTab = 0;
			sPanelMode = p__5;
			initListeners();
			setupButtons();
			deselect();
			nChips = p__2;
			aPokerUsers = p__3;
			bShowNone = false;
			for each (l__6 in tabSet){
				if (holder.contains(l__6)){
					holder.removeChild(l__6);
				}
			}
			tabSet = new Array();
			mImageList = new Array();
			mItemList = new Array();
			l__7 = 0;
			while(l__7 < (p__1.length)){
				tabSet[l__7] = new TabItem();
				l__8 = com.script.poker.table.GiftLibrary.GetInst().GetGiftCategory(p__1[l__7]);
				tabSet[l__7].tabTop.tabhead.text = l__8.msName;
				if ((p__1.length) == 1){
					tabSet[l__7].tabTop.tabhead.text = "Items";
				}
				tabSet[l__7].setTabSpot(l__7);
				tabSet[l__7].x = 8;
				tabSet[l__7].y = 33;
				tabSet[l__7].tabTop.ID = l__7;
				tabSet[l__7].tabTop.GiftCatID = p__1[l__7];
				tabSet[l__7].tabTop.inSenderName = p__4;
				tabSet[l__7].tabTop.panelmode = p__5;
				tabSet[l__7].tabTop.addEventListener(flash.events.MouseEvent.CLICK, riseUp);
				holder.addChild(tabSet[l__7]);
				bShowNone = l__8.maGiftsInCat.length > 0;
				if ((sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_DISPLAY) || (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_SELECT)){
					if (l__8.maGiftsInCat.length == 0){
						tabSet[l__7].altcontent.text = "Today\'s gift is empty!";
					}
				}
				populate_tab_withGiftCategory(l__7, p__1[l__7]);
				l__7++;
			}
			if (tabSet.length > 0){
				prettyStack(tabSet[0]);
			}
		}
		public function populate_select_or_display(p__1:Array, p__2:Number, p__3:Array, p__4:Array = null, p__5:String = "buy")
		{
			var l__6:* = undefined;
			nCurrentTab = 0;
			sPanelMode = p__5;
			if (mOffTableChipsNote){
				mOffTableChipsNote.visible = false;
			}
			initListeners();
			setupButtons();
			deselect();
			nChips = p__2;
			aPokerUsers = p__3;
			bShowNone = false;
			for each (l__6 in tabSet){
				if (holder.contains(l__6)){
					holder.removeChild(l__6);
				}
			}
			tabSet = new Array();
			mImageList = new Array();
			mItemList = new Array();
			if ((p__1) == null){
				p__1 = new Array();
			}
			var l__7:Number = 0;
			tabSet[l__7] = new TabItem();
			tabSet[l__7].tabTop.tabhead.text = "Items";
			tabSet[l__7].setTabSpot(l__7);
			tabSet[l__7].x = 8;
			tabSet[l__7].y = 33;
			tabSet[l__7].tabTop.ID = l__7;
			tabSet[l__7].tabTop.GiftCatID = -1;
			tabSet[l__7].tabTop.inSenderName = p__4;
			tabSet[l__7].tabTop.panelmode = p__5;
			tabSet[l__7].tabTop.addEventListener(flash.events.MouseEvent.CLICK, riseUp);
			holder.addChild(tabSet[l__7]);
			bShowNone = (p__1.length) > 0;
			tabSet[l__7].altcontent.text = "";
			populate_tab_withSpecificGifts(l__7, p__1, p__4, p__5);
			if ((sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_DISPLAY) || (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_SELECT)){
				if ((p__1.length) == 0){
					tabSet[l__7].altcontent.text = "Today\'s gift is empty!";
				}
			}
			if (tabSet.length > 0){
				prettyStack(tabSet[0]);
			}
			this.enableButtons();
			this.disableButtons();
		}
		public function populate(p__1:Array, p__2:Number, p__3:Array, p__4:Array = null, p__5:String = "buy")
		{
			if ((p__5) == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_BUY){
				populate_buy(p__1, p__2, p__3, p__4, p__5);
			} else {
				populate_select_or_display(p__1, p__2, p__3, p__4, p__5);
			}
		}
		public function riseUp(p__1:*):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.DSGEvent(com.script.poker.popups.modules.events.DSGEvent.DSG_UPDATE, sZid));
			nCurrentTab = p__1.target.ID;
			dispatchEvent(new com.script.poker.popups.modules.events.DSGEvent(com.script.poker.popups.modules.events.DSGEvent.REFRESH_CATEGORY, sZid, p__1.target.GiftCatID));
			prettyStack(p__1.target.parent);
			deselect();
			stopBuyTimer(false);
		}
		private function prettyStack(p__1:*):void
		{
			var l__2:* = undefined;
			for (l__2 in tabSet){
				holder.setChildIndex(tabSet[l__2], (holder.numChildren - 1 - l__2));
				tabSet[l__2].inactive();
			}
			holder.setChildIndex(p__1, holder.numChildren - 1);
			(p__1).active();
		}
		private function highlight(p__1:*):void
		{
			var l__2:* = undefined;
			if (mItemList && (mItemList.length > 0)){
				for each (l__2 in mItemList[nCurrentTab]){
					l__2.out();
				}
			}
			if ((p__1.target.ID) != selected){
				selected = p__1.target.ID;
				(p__1.target).over();
			} else {
				selected = null;
			}
		}
		private function over(p__1:*):void
		{
			out(null);
			(p__1.target).rollin();
		}
		private function out(p__1:*):void
		{
			var l__2:* = undefined;
			if (mItemList && (mItemList.length > 0)){
				for each (l__2 in mItemList[nCurrentTab]){
					l__2.rollout();
				}
			}
		}
		private function makeDrop(p__1:Boolean = false):flash.filters.DropShadowFilter
		{
			var l__2:Number = 0;
			var l__3:Number = 90;
			var l__4:Number = 0.5;
			var l__5:Number = 6;
			var l__6:Number = 6;
			var l__7:Number = 1;
			var l__8:Number = 1;
			p__1 = p__1;
			var l__9:Boolean;
			var l__10:Number = flash.filters.BitmapFilterQuality.HIGH;
			return(new flash.filters.DropShadowFilter(l__7, l__3, l__2, l__4, l__5, l__6, l__8, l__10, p__1, l__9));
		}
		private function deselect():void
		{
			var l__1:* = undefined;
			if (mItemList && (mItemList.length > 0)){
				for each (l__1 in mItemList[nCurrentTab]){
					l__1.out();
				}
			}
			selected = null;
		}
		public function set selected(p__1:*):void
		{
			var l__2:com.script.poker.table.GiftItem;
			var l__3:Number = 0;
			var l__4:Boolean;
			disableButtons();
			_selected = p__1;
			if ((p__1) != null){
				if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_BUY){
					l__2 = com.script.poker.table.GiftLibrary.GetInst().GetGift(p__1);
					nTotalPlayers = getAllowedPlayers(p__1);
					l__3 = l__2.mnPrice * nTotalPlayers;
					l__4 = true;
					enableButtons(l__4, l__3);
				} else if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_SELECT){
					enableButtons();
				}
			}
		}
		public function get selected()
		{
			return(_selected);
		}
		private function setupButtons():void
		{
			wtBtn.visible = (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_DISPLAY) ? false : true;
			buyBtn.visible = (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_DISPLAY) ? false : true;
			if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_BUY){
				wtBtn.changeText(langs.l_buyevery);
				buyBtn.changeText(langs.l_buy);
			} else if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_SELECT){
				wtBtn.changeText("Display\nSelected");
				buyBtn.changeText("Display None");
			}
			wtBtn.setActivity(true);
			buyBtn.setActivity(true);
		}
		private function disableButtons():void
		{
			if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_BUY){
				wtBtn.changeText(langs.l_buyevery);
				wtBtn.setActivity(false);
				buyBtn.changeText(langs.l_buy);
				buyBtn.setActivity(false);
				buyBtn.removeEventListener(flash.events.MouseEvent.CLICK, onBuy);
				wtBtn.removeEventListener(flash.events.MouseEvent.CLICK, onBuyForTable);
			} else if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_SELECT){
				wtBtn.changeText("Display\nSelected");
				wtBtn.setActivity(false);
				wtBtn.removeEventListener(flash.events.MouseEvent.CLICK, onBuyForTable);
				buyBtn.changeText("Display None");
				if (!bShowNone){
					buyBtn.setActivity(false);
					buyBtn.removeEventListener(flash.events.MouseEvent.CLICK, onBuy);
				}
			} else if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_DISPLAY){
			}
		}
		private function enableButtons(p__1:Boolean = false, p__2:Number = 0):void
		{
			if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_BUY){
				if (p__1){
					wtBtn.changeText((langs.l_buyevery+"\n(" + p__2) + ")");
					wtBtn.setActivity(!buyTimerActive);
					if (!buyTimerActive){
						wtBtn.addEventListener(flash.events.MouseEvent.CLICK, onBuyForTable);
					}
				}
				buyBtn.setActivity(!buyTimerActive);
				if (!buyTimerActive){
					buyBtn.addEventListener(flash.events.MouseEvent.CLICK, onBuy);
				}
			} else if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_SELECT){
				wtBtn.setActivity(true);
				wtBtn.addEventListener(flash.events.MouseEvent.CLICK, onBuyForTable);
				buyBtn.setActivity(true);
				buyBtn.addEventListener(flash.events.MouseEvent.CLICK, onBuy);
			} else if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_DISPLAY){
			}
		}
		public function getPokerUser():Object
		{
			var l__1:* = undefined;
			var l__2:Object;
			for (l__1 in aPokerUsers){
				l__2 = aPokerUsers[l__1];
				if (l__2.zid == sZid){
					return(l__2);
				}
			}
			return(null);
		}
		public function isGiftIdAllowed(p__1:Number):Boolean
		{
			var l__3:* = undefined;
			var l__2:com.script.poker.table.GiftItem = com.script.poker.table.GiftLibrary.GetInst().GetGift(p__1);
			if (l__2 == null){
				return(true);
			}
			if (!l__2.mbUserFilter){
				return(true);
			}
			var l__4:Object;
			for (l__3 in aPokerUsers){
				l__4 = aPokerUsers[l__3];
				if (l__4.zid == sViewerZid){
					if (l__4.nHideGifts != 0){
						return(false);
					}
				}
			}
			for (l__3 in aPokerUsers){
				l__4 = aPokerUsers[l__3];
				if (l__4.zid == sZid){
					if (l__4.nHideGifts == 0){
						return(true);
					}
				}
			}
			return(false);
		}
		public function getAllowedPlayers(p__1:Number):Number
		{
			var l__4:* = undefined;
			var l__5:Object;
			if ((p__1) < 0){
				return(aPokerUsers.length);
			}
			var l__2:com.script.poker.table.GiftItem = com.script.poker.table.GiftLibrary.GetInst().GetGift(p__1);
			if ((l__2 == null) || ((!l__2.mbGreyOut) && (!l__2.mbUserFilter))){
				return(aPokerUsers.length);
			}
			var l__3:Number = 0;
			for (l__4 in aPokerUsers){
				l__5 = aPokerUsers[l__4];
				if (l__5.nHideGifts == 0){
					l__3++;
				}
			}
			return(l__3);
		}
		public function getGiftById(p__1:int):Object
		{
			return(com.script.poker.table.GiftLibrary.GetInst().GetGift((p__1).AS3::toString()) as Object);
		}
		public function set pokerUsers(p__1:Array):void
		{
			aPokerUsers = p__1;
			nTotalPlayers = getAllowedPlayers(nCurrentTab);
		}
		private function startBuyTimer():void
		{
			if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_BUY){
				if (buyTimer == null){
					buyTimer = new flash.utils.Timer(8000);
					buyTimer.addEventListener(flash.events.TimerEvent.TIMER, onBuyDrink);
					buyTimer.start();
				}
				wtBtn.setActivity(false);
				buyBtn.setActivity(false);
				buyTimerActive = true;
			}
		}
		private function stopBuyTimer(p__1:Boolean):void
		{
			if (sPanelMode == com.script.poker.popups.modules.events.DSGEvent.PANELMODE_BUY){
				if (buyTimer != null){
					buyTimer.stop();
					buyTimer.removeEventListener(flash.events.TimerEvent.TIMER, onBuyDrink);
					buyTimer = null;
				}
				wtBtn.setActivity(p__1);
				buyBtn.setActivity(p__1);
				wtBtn.addEventListener(flash.events.MouseEvent.CLICK, onBuyForTable);
				buyBtn.addEventListener(flash.events.MouseEvent.CLICK, onBuy);
				buyTimerActive = false;
			}
		}
		private function onBuyDrink(p__1:flash.events.TimerEvent):void
		{
			stopBuyTimer(true);
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