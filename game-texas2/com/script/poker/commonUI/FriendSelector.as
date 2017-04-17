// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.commonUI
{
	import fl.data.DataProvider;
	import fl.controls.TileList;
	import fl.controls.ScrollPolicy;
	import fl.controls.ScrollBarDirection;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.EventDispatcher;
	import com.script.poker.commonUI.events.*;
	import fl.events.*;
	import flash.utils.Timer;
	import com.script.poker.lobby.asset.*;
	import com.script.poker.friends.asset.*;
	import com.script.poker.commonUI.asset.*;
	import com.script.poker.table.asset.chat.*;
	import com.script.poker.controls.listClasses.*;
	import com.yahoo.astra.fl.containers.VBoxPane;
	import com.script.ui.scroller.ScrollSystem;
	public class FriendSelector extends flash.display.MovieClip
	{
		private var offlineInviteSent:Boolean = false;
		private var friendsOnlineList:fl.controls.TileList;
		private var playingNowList:fl.controls.TileList;
		private var scrolling:Boolean;
		private var loadMorePN:com.script.poker.friends.asset.ListActionItem;
		private var friendsOfflineDP:fl.data.DataProvider;
		private var PNContainer:com.yahoo.astra.fl.containers.VBoxPane;
		private var noONFfriendBox:com.script.poker.friends.asset.ListActionItem;
		private var ad:com.script.poker.commonUI.asset.adMC;
		private var vContainer:com.yahoo.astra.fl.containers.VBoxPane;
		private var noPNfriendBox:com.script.poker.friends.asset.ListActionItem;
		private var dfFriends:com.script.poker.lobby.asset.DrawFrame;
		private var dpTestTimer:flash.utils.Timer;
		private var scroller:com.script.ui.scroller.ScrollSystem;
		private var friendsOfflineHeader:com.script.poker.lobby.asset.CollapseHeader;
		private var inviteSent:com.script.poker.friends.asset.ListActionItem;
		//private var logo:com.script.poker.commonUI.asset.theMutt;
		private var tellAllFriends:com.script.poker.friends.asset.ListActionItem;
		private var overLimit:Boolean = false;
		private var closeButton:flash.display.MovieClip;
		private var friendsOfflineList:fl.controls.TileList;
		private var offlineInvite:com.script.poker.friends.asset.ListActionItem;
		private var playingNowDP:fl.data.DataProvider;
		private var playingNowLimit:Number = 100;
		private var friendsOnlineDP:fl.data.DataProvider;
		private var loadMoreFO:com.script.poker.friends.asset.ListActionItem;
		private var listCont:flash.display.Sprite;
		private var OFFContainer:com.yahoo.astra.fl.containers.VBoxPane;
		private var playingNowHeader:com.script.poker.lobby.asset.CollapseHeader;
		private var ONFContainer:com.yahoo.astra.fl.containers.VBoxPane;
		private var friendsOnlineHeader:com.script.poker.lobby.asset.CollapseHeader;
		private var tellAllFriendsSent:Boolean = false;
		public function FriendSelector()
		{
			scrolling = false;
			closeButton = new CloseButton();
			createDPs();
			dfFriends = new DrawFrame(242, 359, false, false);
			dfFriends.renderZLiveTitle("Friend");
			addChild(dfFriends);
			//logo = new theMutt();
			//dfFriends.addChild(logo);
			//logo.y = -16;
			//logo.x = 1;
			//logo.mouseEnabled = false;
			ad = new adMC();
			dfFriends.addChild(closeButton);
			closeButton.x = 230;
			closeButton.y = -16;
			closeButton.buttonMode = true;
			closeButton.useHandCursor = true;
			closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			listCont = new Sprite();
			createActionItems();
			createHeaders();
			createLists();
			createContainers();
			containerConfigInit();
			this.cacheAsBitmap = true;
		}
		public function init():void
		{
			scrollerConfigure();
		}
		private function onCloseClick(p__1:flash.events.MouseEvent)
		{
			dispatchEvent(new CommonVEvent(CommonVEvent.ZLIVE_HIDE));
		}
		public function hideClose(p__1:Boolean)
		{
			if (p__1){
				closeButton.visible = false;
			} else {
				closeButton.visible = true;
			}
		}
		private function createActionItems():void
		{
			loadMorePN = new ListActionItem(2);
			loadMoreFO = new ListActionItem(3);
			noPNfriendBox = new ListActionItem(0);
			noONFfriendBox = new ListActionItem(1);
			tellAllFriends = new ListActionItem(4);
			offlineInvite = new ListActionItem(5);
			inviteSent = new ListActionItem(6);
			loadMorePN.addEventListener(MouseEvent.CLICK, loadMorePNClicked);
			loadMoreFO.addEventListener(MouseEvent.CLICK, loadMoreFOClicked);
			tellAllFriends.addEventListener(MouseEvent.CLICK, tellAllClick);
			offlineInvite.addEventListener(MouseEvent.CLICK, offlineInviteClick);
		}
		public function updatePNusers(p__1:fl.data.DataProvider)
		{
			var l__3:Object;
			var l__4:* = undefined;
			var l__5:Object;
			var l__6:* = undefined;
			var l__7:* = undefined;
			var l__2:Boolean;
			l__6 = 0;
			while(l__6 < p__1.length){
				l__3 = p__1.getItemAt(l__6);
				modelzid = l__3["uid"];
				l__2 = false;
				l__7 = 0;
				while(l__7 < playingNowDP.length){
					l__5 = playingNowDP.getItemAt(l__7);
					l__4 = l__5["uid"];
					if (l__4 == modelzid){
						l__2 = true;
						playingNowDP.replaceItemAt(p__1.getItemAt(l__6), l__7);
					}
					l__7++;
				}
				if (l__2 == false){
					playingNowDP.addItem(l__3);
				}
				l__6++;
			}
			l__2 = false;
			l__6 = 0;
			while(l__6 < playingNowDP.length){
				l__3 = playingNowDP.getItemAt(l__6);
				modelzid = l__3["uid"];
				l__2 = false;
				l__7 = 0;
				while(l__7 < p__1.length){
					l__5 = p__1.getItemAt(l__7);
					l__4 = l__5["uid"];
					if (l__4 == modelzid){
						l__2 = true;
					}
					l__7++;
				}
				if (l__2 == true){
				} else {
					playingNowDP.removeItem(l__3);
				}
				l__6++;
			}
			if (playingNowDP.length > 0){
				playingNowDP.sortOn(["playStatus", "label"], [Array.CASEINSENSITIVE, Array.CASEINSENSITIVE]);
			} else {
			}
			overLimit = false;
			DPChange();
		}
		public function updateFONusers(p__1:Number)
		{
			friendsOnlineHeader.setQty(p__1);
		}
		public function updateFOFFusers(p__1:Number)
		{
			friendsOfflineHeader.setQty(p__1);
		}
		private function testscriptLive(p__1:flash.events.TimerEvent)
		{
			if (Math.random() > 0.7){
				playingNowDP.addItem({label:"Chris Delbuck", source:"../Avatar/default.jpg", playStatus:"join", tableStakes:"100/200", tableType:"private", uid:"303030303", game_id:"303808", server_id:"007", room_id:"666", first_name:"Chris", last_name:"DelBuck", relationship:"", evtObj:this});
			} else if (playingNowDP.length > 0){
				playingNowDP.removeItem(playingNowDP.getItemAt(0));
			} else {
			}
		}
		private function createDPs():void
		{
			friendsOnlineDP = new DataProvider();
			friendsOfflineDP = new DataProvider();
			playingNowDP = new DataProvider();
		}
		private function createHeaders():void
		{
			playingNowHeader = new CollapseHeader("Playing Now", 0);
			playingNowHeader.name = "playingNowHeader";
			playingNowHeader.x = 0;
			friendsOnlineHeader = new CollapseHeader("Online Friends", 0);
			friendsOnlineHeader.name = "friendsOnlineHeader";
			friendsOnlineHeader.x = 0;
			friendsOnlineHeader.disableHeader(true);
			friendsOnlineHeader.setQty(0);
			friendsOfflineHeader = new CollapseHeader("Offline Friends", -1);
			friendsOfflineHeader.name = "friendsOfflineHeader";
			friendsOfflineHeader.x = 0;
			friendsOfflineHeader.disableHeader(true);
		}
		private function createLists():void
		{
			playingNowList = new TileList();
			playingNowList.setStyle("cellRenderer", FriendSelectorCell);
			playingNowList.rowHeight = 59;
			playingNowList.dataProvider = playingNowDP;
			playingNowList.verticalScrollPolicy = ScrollPolicy.OFF;
			playingNowList.columnWidth = 220;
			playingNowList.columnCount = 1;
			playingNowList.rowCount = 0;
			playingNowList.setSize(playingNowList.columnWidth, 0);
			friendsOnlineList = new TileList();
			friendsOnlineList.name = "friendsOnlineList";
			friendsOnlineList.setStyle("cellRenderer", FriendSelectorCell);
			friendsOnlineList.rowHeight = 59;
			friendsOnlineList.dataProvider = friendsOnlineDP;
			friendsOnlineList.direction = ScrollBarDirection.VERTICAL;
			friendsOnlineList.columnWidth = 220;
			friendsOnlineList.columnCount = 1;
			friendsOnlineList.rowCount = 0;
			friendsOnlineList.setSize(friendsOnlineList.columnWidth, 0);
			friendsOfflineList = new TileList();
			friendsOfflineList.setStyle("cellRenderer", FriendSelectorCell);
			friendsOfflineList.rowHeight = 59;
			friendsOfflineList.dataProvider = friendsOfflineDP;
			friendsOfflineList.direction = ScrollBarDirection.VERTICAL;
			friendsOfflineList.columnWidth = 220;
			friendsOfflineList.columnCount = 1;
			friendsOfflineList.rowCount = 0;
			friendsOfflineList.setSize(friendsOnlineList.columnWidth, 0);
		}
		private function scrollerConfigure():void
		{
			var l__1:Object = new Object();
			l__1.arrowUp = new ChatArrowUp();
			l__1.arrowDown = new ChatArrowDown();
			l__1.handleV = new ChatHandleV();
			l__1.trackV = new ChatTrackV();
			l__1.arrowLeft = new ChatArrowLeft();
			l__1.arrowRight = new ChatArrowRight();
			l__1.handleH = new ChatHandleH();
			l__1.trackH = new ChatTrackH();
			scroller = new ScrollSystem(this, vContainer, 220, 355, l__1, 10, 0, true, false, 10, 60);
			scroller.x = 2;
			scroller.y = 3;
			addChild(scroller);
			scroller.useHandCursor = false;
			scroller.buttonMode = false;
			this.addEventListener(MouseEvent.MOUSE_DOWN, vHandle);
			this.addEventListener(MouseEvent.MOUSE_UP, vHandleUp);
		}
		public function vHandle(p__1:flash.events.Event)
		{
			scrolling = true;
		}
		public function vHandleUp(p__1:flash.events.Event)
		{
			scrolling = false;
			DPChange();
		}
		public function scrollToTop():void
		{
			scroller.moveRequestV(800);
		}
		private function containerConfigInit():void
		{
			PNContainer.configuration = [{target:playingNowHeader}, {target:playingNowList}, {target:noPNfriendBox}];
			//ONFContainer.configuration = [{target:friendsOnlineHeader}, {target:tellAllFriends}];
			//OFFContainer.configuration = [{target:friendsOfflineHeader}, {target:offlineInvite}];
			//vContainer.configuration = [{target:ONFContainer}, {target:OFFContainer}, {target:ad}];
		}
		public function showPlayingNow():void
		{
			vContainer.configuration = [{target:PNContainer}, {target:ONFContainer}, {target:OFFContainer}, {target:ad}];
		}
		private function createContainers():void
		{
			vContainer = new VBoxPane();
			PNContainer = new VBoxPane();
			ONFContainer = new VBoxPane();
			OFFContainer = new VBoxPane();
			vContainer.setSize(300, 500);
			vContainer.setSize(NaN, NaN);
			PNContainer.setSize(300, 500);
			ONFContainer.setSize(300, 500);
			OFFContainer.setSize(300, 500);
			PNContainer.setSize(NaN, NaN);
			ONFContainer.setSize(NaN, NaN);
			OFFContainer.setSize(NaN, NaN);
		}
		public function updateDP(p__1:fl.data.DataProvider, p__2:String):void
		{
		}
		private function tellAllClick(p__1:flash.events.MouseEvent)
		{
			dispatchEvent(new CommonVEvent(CommonVEvent.ZLIVE_POST));
		}
		private function loadMoreFOClicked(p__1:flash.events.MouseEvent)
		{
		}
		private function loadMorePNClicked(p__1:flash.events.MouseEvent)
		{
			playingNowLimit = (playingNowLimit + 1);
			dispatchEvent(new CommonVEvent(CommonVEvent.SEE_MORE_USERS));
		}
		private function offlineInviteClick(p__1:flash.events.MouseEvent)
		{
			dispatchEvent(new CommonVEvent(CommonVEvent.ZLIVE_INVITE));
		}
		private function DPChange()
		{
			var l__1:Number = 0;
			var l__2:Array;
			var l__3:* = undefined;
			if (!scrolling){
				if (overLimit == false){
					playingNowList.setSize(playingNowList.columnWidth, playingNowDP.length * playingNowList.rowHeight);
					if (playingNowDP.length == 0){
						if (playingNowHeader.hasEventListener(MouseEvent.CLICK)){
							playingNowHeader.removeEventListener(MouseEvent.CLICK, handleCol);
						} else {
						}
						l__1 = -1;
						l__2 = PNContainer.configuration.concat();
						l__3 = 0;
						while(l__3 < l__2.length){
							if (l__2[l__3].target == noPNfriendBox){
								l__1 = l__3;
							} else {
							}
							l__3++;
						}
						if (l__1 == -1){
							l__2.splice(l__2.length, 0, {target:noPNfriendBox});
							PNContainer.configuration = l__2.concat();
						}
					} else {
						playingNowHeader.addEventListener(MouseEvent.CLICK, handleCol);
						l__1 = -1;
						l__2 = PNContainer.configuration.concat();
						l__3 = 0;
						while(l__3 < l__2.length){
							if (l__2[l__3].target == noPNfriendBox){
								l__1 = l__3;
							} else {
							}
							l__3++;
						}
						if (l__1 != -1){
							l__2.splice(l__1, 1);
							PNContainer.configuration = l__2.concat();
						}
					}
				} else {
					playingNowList.setSize(playingNowList.columnWidth, playingNowDP.length * playingNowList.rowHeight);
					PNContainer.configuration = [{target:playingNowHeader}, {target:playingNowList}, {target:loadMorePN}];
				}
				playingNowHeader.setQty(playingNowDP.length);
			}
		}
		private function handleCol(p__1:flash.events.MouseEvent):void
		{
			var l__3:* = undefined;
			var l__4:* = undefined;
			scroller.updater(false, false);
			var l__2:com.script.poker.lobby.asset.CollapseHeader = (p__1.currentTarget as CollapseHeader);
			switch(l__2.name){
				case "playingNowHeader":
				{
					l__2.headerPressed = true;
					if (l__2.bActive){
						l__2.expand();
					}
					if (!l__2.bExpanded){
						PNContainer.configuration = [{target:playingNowHeader}];
					} else {
						l__3 = -1;
						newArray = PNContainer.configuration.concat();
						l__4 = 0;
						while(l__4 < newArray.length){
							if (newArray[l__4].target == playingNowList){
								l__3 = l__4;
							} else {
							}
							l__4++;
						}
						if (l__3 == -1){
							newArray.splice(l__3, 1, {target:playingNowList});
							PNContainer.configuration = newArray.concat();
						}
						PNContainer.configuration = [{target:playingNowHeader}, {target:playingNowList}];
					}
					break;
				}
				case "friendsOnlineHeader":
				{
					if (l__2.bActive){
						l__2.expand();
					}
					if (!l__2.bExpanded){
						ONFContainer.configuration = [{target:friendsOnlineHeader}];
					} else if (tellAllFriendsSent){
						ONFContainer.configuration = [{target:friendsOnlineHeader}, {target:friendsOnlineList}, {target:loadMoreFO}];
					} else {
						ONFContainer.configuration = [{target:friendsOnlineHeader}, {target:tellAllFriends}];
					}
					break;
				}
				case "friendsOfflineHeader":
				{
					if (l__2.bActive){
						l__2.expand();
					}
					if (!l__2.bExpanded){
						OFFContainer.configuration = [{target:friendsOfflineHeader}];
					} else if (offlineInviteSent){
						OFFContainer.configuration = [{target:friendsOfflineHeader}, {target:friendsOfflineList}];
					} else {
						OFFContainer.configuration = [{target:friendsOfflineHeader}, {target:offlineInvite}];
					}
					break;
				}
			}
			scroller.updater(false, false);
		}
		private function PreDPChange(p__1:fl.events.DataChangeEvent)
		{
		}
	}
}