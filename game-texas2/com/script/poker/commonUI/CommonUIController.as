// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.commonUI
{
	import com.script.poker.PokerGlobalData;
	import com.script.poker.PokerController;
	import com.script.poker.PokerConnectionManager;
	import flash.display.*;
	import flash.events.*;
	import com.script.poker.events.*;
	import com.script.zoom.*;
	import com.script.poker.commonUI.events.*;
	import flash.utils.Timer;
	import flash.external.*;
	public class CommonUIController extends flash.events.EventDispatcher
	{
		private var pgData:com.script.poker.PokerGlobalData;
		private var notifs:Notifications;
		private var isFirstZoomUpdate:Boolean = true;
		private var pControl:com.script.poker.PokerController;
		public var uiView:flash.display.DisplayObject;
		private var bOnDisplayList:Boolean = false;
		private var prevSelId:Number = 0;
		private var pcmConnect:com.script.poker.PokerConnectionManager;
		public var uiModel:com.script.poker.commonUI.CommonUIModel;
		private var friendsTimer:flash.utils.Timer;
		private var mainDisp:flash.display.MovieClip;
		public function CommonUIController()
		{
			uiModel = new CommonUIModel();
			notifs = new Notifications();
		}
		public function onZLiveInvite(p__1:com.script.poker.commonUI.events.CommonVEvent):void
		{
			if (pgData.jsCallType == "fbbridge"){
				pgData.callFBJS("openZLiveInvite", "");
			} else if (ExternalInterface.available){
				ExternalInterface.call("openZLiveInvite", "");
			}
		}
		public function onZLivePost(p__1:com.script.poker.commonUI.events.CommonVEvent):void
		{
			if (pgData.jsCallType == "fbbridge"){
				pgData.callFBJS("postZLivePlay", "");
			} else if (ExternalInterface.available){
				ExternalInterface.call("postZLivePlay", "");
			}
		}
		private function initFriendsOnline():void
		{
			setFriendsTimer();
		}
		public function setFriendsTimer():void
		{
		}
		public function stopFriendsTimer():void
		{
		}
		public function getFriendsOnline(p__1:flash.events.TimerEvent):void
		{
		}
		public function updateOnlineFriends(p__1:*):void
		{
			var l__3:* = undefined;
			var l__2:* = new Array();
			if (p__1){
				if (p__1.length){
					for (l__3 in p__1){
						l__2.push(p__1[l__3]);
					}
				}
			}
			if (l__2.length){
				uiModel.updateFOnline(l__2);
				uiView.updateOnline(uiModel.nOnline);
			}
		}
		public function updateOfflineFriends(p__1:*):void
		{
			if (p__1.length){
				uiModel.updateFOffline(p__1);
				uiView.updateOffline(uiModel.nOffline);
			}
		}
		public function startCommonUIController(p__1:Object, p__2:com.script.poker.PokerGlobalData, p__3:com.script.poker.PokerConnectionManager, p__4:com.script.poker.PokerController):void
		{
			mainDisp = MovieClip(p__1);
			pgData = p__2;
			pcmConnect = p__3;
			pControl = p__4;
			addEventListeners();
			//uiModel.setServerTypeList(pControl.loadBalancer.serverTypeList, pControl.loadBalancer.idList);
		}
		private function initView(p__1:com.script.poker.events.PCEvent):void
		{
			uiView = ((new CommonUIView(this)) as DisplayObject);
			mainDisp.addChildAt(uiView, mainDisp.numChildren - 1);
			uiView.y = 40;
			uiView.visible = false;
			uiView.addEventListener(CommonVEvent.JOIN_USER, onJoinUserClicked, true);
			uiView.addEventListener(CommonVEvent.INVITE_USER, onInviteUserClicked, true);
			dispatchEvent(new CommonCEvent(CommonCEvent.VIEW_INIT));
			uiView.addEventListener(CommonVEvent.ZLIVE_INVITE, onZLiveInvite, true);
			uiView.addEventListener(CommonVEvent.ZLIVE_POST, onZLivePost, true);
			uiView.addEventListener(CommonVEvent.ZLIVE_HIDE, onZLiveHide, true);
			uiView.addEventListener(CommonVEvent.SEE_MORE_USERS, onSeeMorePlayingNow, true);
			//if (pgData.sn_id == pgData.SN_FACEBOOK){
				initFriendsOnline();
				uiView.showPlayingNow();
			//}
		}
		private function addEventListeners():void
		{
			pControl.addEventListener(PCEvent.INIT_COMMON_UI, initView);
			pControl.addEventListener(PCEvent.DISPLAY_COMMON_UI, onDisplayUI);
			pControl.addEventListener(PCEvent.HIDE_COMMON_UI, onHideUI);
			pControl.addEventListener(PCEvent.HIDE_FRIEND_SELECTOR, onHideFriendSelector);
			pControl.addEventListener(PCEvent.SHOW_FRIEND_SELECTOR, onShowFriendSelector);
			pControl.addEventListener(PCEvent.LOBBY_JOINED, onLobbyJoined);
			pControl.addEventListener(PCEvent.TABLE_JOINED, onTableJoined);
		}
		private function onLobbyJoined(p__1:com.script.poker.events.PCEvent):void
		{
			uiModel.inLobby = true;
			uiView.ZLiveHideClose(true);
			uiModel.removeSameTables();
			uiView.updatePlayingNowDP(uiModel.pNowDP);
			uiView.ZLiveScrollToTop();
			dispatchEvent(new CommonCEvent(CommonCEvent.SHOW_FRIEND_SELECTOR));
		}
		private function onTableJoined(p__1:com.script.poker.events.PCEvent):void
		{
			uiModel.resetJoins();
			uiModel.inLobby = false;
			
			uiView.ZLiveHideClose(false);
			dispatchEvent(new CommonCEvent(CommonCEvent.HIDE_FRIEND_SELECTOR));
			
			uiModel.checkSameTable(pgData.gameRoomId, pgData.rejoinRoom, pgData.serverId);
			uiView.updatePlayingNowDP(uiModel.pNowDP);
			pgData.ZLiveToggle = -1;
		}
		public function showInviteNotif(param1:Object)
		//public function showInviteNotif(param1:String)
        {
            //var _loc_2:* = uiModel.getOnlineUser(param1);
			
           // if (_loc_2 != null)
            //{
				//param1.source =
				
                notifs.addInviteNotif(param1);
                //pgData.EnsurePHPPopupsAreClosed();
            //}
            return;
        }
		private function onInviteUserClicked(event:InviteUserEvent) : void
        {
            var _loc_3:String = null;
            if (event.jointype == "notif")
            {
            }
            var _loc_2:* = event.hasOwnProperty("friend") ? (event["friend"]) : (null);
           			
			if (_loc_2 != null)
            {
				
                if (_loc_2.room_id != "null")
                {
					
                    //_loc_3 = pControl.loadBalancer.getServerType(_loc_2.server_id);
                    //pControl.zoomControl.sendTableInvitation(_loc_2.uid);
					p__1 = new Object();
					p__1.msg = _loc_2.uid;
					//pControl.onSentZoomTableInvitation(p__1)
					pControl.onSentInvitePopup(p__1)
					
                    uiModel.addInviteIssued(_loc_2.uid);
					
                }
            }
            return;
        }
		private function onDisplayUI(p__1:com.script.poker.events.PCEvent):void
		{
			
			//uiView.visible = true;
			uiView.updateOnline(0);
			uiView.updateOffline(0);
			initZoomModelListeners();
		}
		private function onHideUI(p__1:com.script.poker.events.PCEvent):void
		{
			uiView.visible = false;
		}
		private function dispatchJoinedNotifs(param1:Array)
        {
            /*var _loc_2:Object = null;
            if (pgData.showJoinNotifs == true)
            {
                for each (_loc_2 in param1)
                {
                    
                    notifs.addJoinedNotif(_loc_2);
                }
            }
            if (param1.length > 0)
            {
               //pControl.glowZLiveButton();
                //;
            }*/
           // pgData.EnsurePHPPopupsAreClosed();
            return;
        }
		private function onZLiveHide(p__1:com.script.poker.commonUI.events.CommonVEvent):void
		{
			dispatchEvent(new CommonCEvent(CommonCEvent.HIDE_FRIEND_SELECTOR));
			pgData.ZLiveToggle = -pgData.ZLiveToggle;
		}
		private function onHideFriendSelector(p__1:com.script.poker.events.PCEvent):void
		{
			dispatchEvent(new CommonCEvent(CommonCEvent.HIDE_FRIEND_SELECTOR));
		}
		private function onShowFriendSelector(p__1:com.script.poker.events.PCEvent):void
		{
			dispatchEvent(new CommonCEvent(CommonCEvent.SHOW_FRIEND_SELECTOR));
		}
		private function onSeeMorePlayingNow(p__1:com.script.poker.commonUI.events.CommonVEvent):void
		{
			pControl.TrackingHit("FriendsSeeMore", 5, 14, 2010, -1, "Table Other FriendsSeeMore o:LiveJoin:2009-05-14", null, 1);
		}
		private function updateView()
		{
		}
		private function initZoomModelListeners():void
		{
			pControl.zoomModel.addEventListener(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED, onZoomModelFriendsUpdate);
		}
		private function removeZoomModelListeners():void
		{
			pControl.zoomModel.removeEventListener(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED, onZoomModelFriendsUpdate);
		}
		private function onZoomModelFriendsUpdate(p__1:com.script.zoom.ZshimModelEvent):void
		{
			var l__4:Number = 0;
			var l__2:Array = p__1.playerList;
			var l__3:int = l__2.length;
			if (pgData.rejoinRoom != -1){
				l__4 = pgData.rejoinRoom;
			} else {
				l__4 = pgData.gameRoomId;
			}
			uiModel.zoomUpdateFriends(l__2, l__4, pgData.serverId);
			if (uiModel.inLobby == false){
				var _loc_6 = uiModel.checkSameTable(pgData.gameRoomId, pgData.rejoinRoom, pgData.serverId);
				 dispatchJoinedNotifs(_loc_6);
			} else {
				uiModel.removeSameTables();
			}
			uiModel.updateFOnline();
			uiView.updatePlayingNowDP(uiModel.pNowDP);
			uiView.updateOnline(uiModel.nOnline);
			uiView.updateOffline(uiModel.nOffline);
			if (isFirstZoomUpdate){
				isFirstZoomUpdate = false;
				pControl.TrackingHit("FriendsPlayingNow", 5, 14, 2010, 100, (("Table Other FriendsPlayingNow o:LiveJoin:" + l__3) + ":2009-05-14"), null, 1);
				if (uiModel.isTwoAtTable){
					pControl.TrackingHit("FriendsAggregated", 5, 14, 2010, 100, "Table Other FriendsAggregated o:LiveJoin:2009-05-14", null, 1);
				}
			}
		}
		private function onJoinUserClicked(p__1:com.script.poker.commonUI.events.JoinUserEvent):void
		{
			var l__3:String;
			var l__4:String;
			var l__5:String;
			pgData.isJoinFriend = false;
			pgData.isJoinFriendSit = false;
			//pControl.TrackingHit("TableJoinFriendSelector", 5, 14, 2010, 100, "Table Other TableJoinFriendSelector o:LiveJoin:2009-05-14", null, 1);
			var l__2:Object = p__1.hasOwnProperty("friend") ? p__1["friend"] : null;
			
			if (l__2 != null){
				if (!(l__2.server_id == null) && !(l__2.server_id == "null")){
					//l__3 = pControl.loadBalancer.getServerType(l__2.server_id);
					l__3 = "normal"
					if (l__2.room_id > -1){
						pgData.isJoinFriend = true;
						pgData.joinFriendId = l__2.uid;
						//pControl.TrackingHit("joinFriendAtTable", 5, 14, 2010, 100, "Lobby Other FriendsJoinUser o:LiveJoin:2009-05-14", null, 1);
						l__4 = "";
						l__5 = "";
						switch(l__3){
							case "normal":
							{
								l__4 = "Lobby Other FriendsJoinUserPoints o:LiveJoin:2009-05-14";
								l__5 = "FriendsJoinUserPoints";
								break;
							}
							case "sitngo":
							{
								l__4 = "Lobby Other FriendsJoinUserSitNGo o:LiveJoin:2009-05-14";
								l__5 = "FriendsJoinUserSitNGo";
								break;
							}
							case "tourney":
							{
								l__4 = "Lobby Other FriendsJoinUserWeeklyTourney o:LiveJoin:2009-05-14";
								l__5 = "FriendsJoinUserWeeklyTourney";
								break;
							}
							case "vip":
							{
								l__4 = "Lobby Other FriendsJoinUserVIP o:LiveJoin:2009-05-14";
								l__5 = "FriendsJoinUserVIP";
								break;
							}
							default:
							{
								break;
							}
						}
						if (l__4 != ""){
							//pControl.TrackingHit(l__5, 5, 14, 2010, 100, l__4, null, 1);
						}
					}
					if (uiModel.inLobby == false){
						pControl.tableJoin(l__2);
					} else {
						//l__3 = pControl.loadBalancer.getServerType(l__2.server_id);
						l__3 = "normal";
						if ((!pgData.isVip) && (l__3 == "vip")){
							//pControl.chooseVipPopup();
						} else {
							pControl.updateLobbyTabs(l__3);
							pgData.nNewRoomId = l__2.room_id;
							pgData.newServerId = l__2.server_id;
							pgData.joiningContact = true;
							pControl.joinTableCheck(l__2.room_id)
							
							/*if (l__3.split("shootout")[0] == ""){
								pgData.joiningShootout = true;
							} else {
								pgData.joiningShootout = false;
							}*/
							//pcmConnect.disconnect();
						}
					}
				}
			}
		}
	}
}