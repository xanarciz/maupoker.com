// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.joinuser
{
	import com.script.poker.table.TableView;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import com.script.poker.table.asset.PokerButton;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import com.script.draw.Box;
	import com.script.poker.table.asset.chat.*;
	import com.script.text.*;
	import com.script.ui.scroller.ScrollSystem;
	public class JoinUserPanel extends flash.display.Sprite
	{
		public var mt:com.script.poker.table.TableView;
		public var sSelectedSid:String;
		public var sSelectedTid:String;
		public var joinButton:com.script.poker.table.asset.PokerButton;
		public var userList:Array;
		public var closerButton:com.script.poker.table.asset.PokerButton;
		public var sSelectedZid:String;
		public var itemH:int = 14;
		public var aDummyFriends:Array;
		public var sName:String;
		public var listBG:com.script.draw.Box;
		public var itemW:int;
		public var aDummyNetworks:Array;
		public var refreshButton:com.script.poker.table.asset.PokerButton;
		public var panelPad:flash.display.Sprite;
		public var thisH:int;
		public var hitSpot:flash.display.MovieClip;
		public var userData:Array;
		public var thisW:int;
		public var scroller:com.script.ui.scroller.ScrollSystem;
		public var bFirstLoad:Boolean = true;
		public var listCont:flash.display.Sprite;
		public function JoinUserPanel(p__1:com.script.poker.table.TableView, p__2:String, p__3:String, p__4:int, p__5:int, p__6:String):void
		{
			var l__7:* = undefined;
			mt = p__1;
			sName = p__2;
			thisW = p__4;
			thisH = p__5;
			itemW = p__4;
			if ((p__6) == "left"){
				l__7 = new PanelLeft();
			}
			if ((p__6) == "right"){
				l__7 = new PanelRight();
			}
			var l__8:flash.filters.DropShadowFilter = new DropShadowFilter(1, 90, 0, 0.66, 7, 7, 1, 3);
			var l__9:Array = new Array(l__8);
			l__7.filters = l__9;
			addChild(l__7);
			var l__10:com.script.text.TextBox = new TextBox(myriadTF, p__3, 12, 1118481, "center", 100, true);
			if ((p__6) == "left"){
				l__10.x = 48;
			}
			if ((p__6) == "right"){
				l__10.x = 150;
			}
			l__10.y = 9;
			addChild(l__10);
			hitSpot = new MovieClip();
			hitSpot.graphics.beginFill(0, 0);
			hitSpot.graphics.drawRect(0, 0, 100, 17);
			hitSpot.graphics.endFill();
			if ((p__6) == "left"){
				hitSpot.x = 0;
			}
			if ((p__6) == "right"){
				hitSpot.x = 105;
			}
			hitSpot.useHandCursor = true;
			hitSpot.buttonMode = true;
			addChild(hitSpot);
			listBG = new Box(p__4, p__5, 16777215, false, false, 0, true, 6710886, 1);
			listBG.x = 6;
			listBG.y = 22;
			addChild(listBG);
			listCont = new Sprite();
			var l__11:Object = new Object();
			l__11.arrowUp = new ChatArrowUp();
			l__11.arrowDown = new ChatArrowDown();
			l__11.handleV = new ChatHandleV();
			l__11.trackV = new ChatTrackV();
			l__11.arrowLeft = new ChatArrowLeft();
			l__11.arrowRight = new ChatArrowRight();
			l__11.handleH = new ChatHandleH();
			l__11.trackH = new ChatTrackH();
			scroller = new ScrollSystem(mt, listCont, (p__4 - 18), (p__5 - 2), l__11, 7, 0, true, false, 10, 60);
			scroller.x = 7;
			scroller.y = 23;
			addChild(scroller);
			initButtons();
		}
		public function initButtons():void
		{
			var l__1:* = 148;
			refreshButton = new PokerButton(myriadTF, "small", "REFRESH", null, 60, 5);
			refreshButton.x = 10;
			refreshButton.y = l__1;
			addChild(refreshButton);
			refreshButton.addEventListener(MouseEvent.CLICK, refreshAction);
			joinButton = new PokerButton(myriadTF, "small", "JOIN USER", null, 60, 2);
			joinButton.x = 85;
			joinButton.y = l__1;
			addChild(joinButton);
			joinButton.setActivity(false);
			joinButton.addEventListener(MouseEvent.CLICK, joinAction);
			closerButton = new PokerButton(myriadTF, "small", "CLOSE", null, 60, 11);
			closerButton.x = 160;
			closerButton.y = l__1;
			addChild(closerButton);
			closerButton.addEventListener(MouseEvent.CLICK, closeAction);
		}
		public function refreshAction(p__1:flash.events.MouseEvent):void
		{
			mt.requestRefreshJoinUser(sName);
		}
		public function joinAction(p__1:flash.events.MouseEvent):void
		{
			var l__2:* = undefined;
			if (joinButton.bActive){
				for (l__2 in userData){
					if (sSelectedZid == userData[l__2].sZid){
						mt.requestJoinUser(userData[l__2].sZid, userData[l__2].nServerId, userData[l__2].nRoomId);
					}
				}
			}
		}
		public function closeAction(p__1:flash.events.MouseEvent):void
		{
			mt.joinCtrl.closePanels();
		}
		public function populate():void
		{
			var l__3:* = undefined;
			var l__4:com.script.poker.table.asset.joinuser.JoinUserListItem;
			var l__5:* = undefined;
			var l__1:int;
			while(listCont.numChildren > 0){
				l__4 = listCont.getChildAt(0);
				listCont.removeChild(l__4);
				l__4 = null;
			}
			userList = [];
			if (sName == "friends"){
				userData = mt.ptModel.aJoinFriends;
			}
			if (sName == "networks"){
				userData = mt.ptModel.aJoinNetworks;
			}
			var l__2:Boolean;
			if (sName == "networks"){
				l__2 = true;
			}
			for (l__3 in userData){
				l__5 = new JoinUserListItem(itemW, itemH, ((userData[l__3].sFirstName + " ") + userData[l__3].sLastName), userData[l__3].sRoomDesc, userData[l__3].sRelationship, userData[l__3].sZid, l__2);
				l__5.y = l__3 * (itemH + 2);
				listCont.addChild(l__5);
				scroller.updater(false, false);
				userList.push(l__5);
				l__5.addEventListener(MouseEvent.CLICK, selectListItem);
			}
		}
		public function selectListItem(p__1:flash.events.MouseEvent):void
		{
			var l__2:* = undefined;
			for (l__2 in userList){
				if ((p__1.currentTarget) != userList[l__2]){
					userList[l__2].selector(false);
				} else {
					joinButton.setActivity(true);
					userList[l__2].selector(true);
					sSelectedZid = userList[l__2].sZid;
				}
			}
		}
	}
}