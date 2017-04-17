// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby
{
	
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
    import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	 
	import fl.data.*;
	import com.script.User;
	import com.script.poker.*;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.*;
	import com.script.poker.events.*;
	import com.script.poker.lobby.events.*;
	import com.script.poker.lobby.events.view.*;
	import com.script.poker.protocol.*;
	import com.script.zoom.*;
	import com.script.poker.shootout.ShootoutConfig;
	import com.script.poker.shootout.ShootoutUser;
	import com.script.events.*;
	import com.script.poker.lobby.events.controller.*;
	import com.script.format.*;
	import com.script.io.*;
	import flash.external.*;
	public class LobbyController extends flash.events.EventDispatcher
	{
		private var bViewLoaded:Boolean;
		private var viewer:com.script.User;
		private var loadBalancer:com.script.poker.LoadBalancer;
		private var lcmConnect:com.script.poker.LoginConnectionManager;
		private var pgData:com.script.poker.PokerGlobalData;
		private var bJoinUserInit:Boolean = false;
		private var bRoomListLoaded:Boolean;
		public var plModel:com.script.poker.lobby.LobbyModel;
		private var friendRoomId:int;
		private var selectedFriendSource:String;
		private var prevSelId:Number = 0;
		private var pcmConnect:com.script.poker.PokerConnectionManager;
		public var plView:Object;
		private var pControl:com.script.poker.PokerController;
		private var bViewInit:Boolean = false;
		public var ldr:flash.display.Loader;
		private var mainDisp:flash.display.MovieClip;
		public function LobbyController()
		{
			plModel = new LobbyModel();
		}
		public function startLobbyController(p__1:flash.display.MovieClip, p__2:com.script.poker.PokerGlobalData, p__3:com.script.poker.PokerConnectionManager, p__4:com.script.poker.PokerController, p__5:Boolean, p__6:com.script.poker.LoginConnectionManager):void
		{
			mainDisp = p__1;
			pgData = p__2;
			pControl = p__4;
			pcmConnect = p__3;
			pcmConnect.addEventListener("onMessage", onProtocolMessage);
			// initLobbyView();
			lcmConnect = p__6;
			if (p__5){
			} else {
				pControl.addEventListener(PCEvent.LOBBY_JOINED, onLobbyJoined);
			}
			
			//pcmConnect.onExtensionHandler(lcmConnect.sfeDisplayRoomList);
			
			if (pgData.tourneyId > -1){
				plView.friendInfo.visible = false;
			}
			/*if (pgData.isWSOP == false){
				plView.mcLobby.shootout_mc.wsopBox.visible = false;
			}
			
			if (pgData.connectToZoom == 1){
				if (plView.friendInfo.friendsOn.visible){
					plView.friendInfo.refresh.visible = !(pgData.useZoomForFriends == 1);
				} else {
					plView.friendInfo.refresh.visible = !(pgData.useZoomForNetwork == 1);
				}
				//plModel.setServerTypeList(pControl.loadBalancer.serverTypeList, pControl.loadBalancer.idList);
			}
			*/
			 
		}
		private function onLobbyJoined(p__1:com.script.poker.events.PCEvent)
		{
		}
		private function initLobbyModel():void
		{
		
			var l__1:* = undefined;
			plModel.useZoomForFriends = pgData.useZoomForFriends == 1;
			/*if (pgData.connectToZoom == 1){
				plModel.useZoomForFriends = pgData.useZoomForFriends == 1;
				//plModel.useZoomForNetwork = pgData.useZoomForNetwork == 1;
			}*/
			plModel.gameInfo = pgData.gameInfo;
			plModel.bVip = pgData.isVip;
			plModel.vipName = pgData.vipName;
			plModel.playerName = pgData.name;
			plModel.playerRank = pgData.aRankNames[pgData.nAchievementRank];
			plModel.playersOnline = pgData.usersOnline;
			plModel.totalChips = pgData.points;
			plModel.totalDeposit = pgData.deposit;
			plModel.aFriends = pgData.aFriendZids;
			if (plModel.sLobbyMode == null){
				plModel.sLobbyMode = pgData.dispMode;
			}
			plModel.serverName = pgData.serverName;
			if (pgData.points < 40){
				plModel.bShowGetPoints = true;
			}
			plModel.bShowGetPoints = true;
			plModel.sn_id = pgData.sn_id;
			plModel.friendsList = pgData.aFriendZids;
			plModel.fb_sig_user = pgData.uid;
			plModel.pic_url = pgData.pic_url;
			plModel.sZid = pgData.zid;
			
			/*if (pgData.useZoomForFriends != 1){
				l__1 = null;
				loadFriendList(l__1);
			}*/
			plModel.chatStat = pgData.chatStat;
			plModel.chatPop = pgData.chatPop;
			
			if (pgData.bUserDisconnect){
				pgData.bUserDisconnect = false;
				plView.setLobbyButtons(true);
				//plView.userInfo.server.text = ("Casino : " + pgData.serverName);
				plView.loadNewServerLobby(); 
			}
		}
		private function setLobbyFilters():void
		{
			plView.hideEmptyTables.selected = pgData.flashCookie.GetValue("bHideEmptyTables", false);
			plView.hideRunningTables.selected = pgData.flashCookie.GetValue("bHideRunningTables", true);
			plView.hideFullTables.selected = pgData.flashCookie.GetValue("bHideFullTables", false);
		}
		private function loadFriendList(p__1:flash.events.Event):void
		{
			if (pgData.connectToZoom == 1){
				//if (pgData.useZoomForFriends == 1){
					plModel.zoomUpdateFriends(pControl.zoomModel.friendsList);
					plView.friendInfo.budList.dataProvider = plModel.friendGridData;
					plView.friendInfo.friendsOn.visible = true;
					//plView.friendInfo.networksOn.visible = false;
					plView.friendInfo.refresh.visible = !(pgData.useZoomForFriends == 1);
					//plModel.setServerTypeList(pControl.loadBalancer.serverTypeList, pControl.loadBalancer.idList);
					plView.hideJoinButton(true);
				/*} else {
					loadFriends();
				}*/
			} else {
				loadFriends();
			}
		}
		private function loadFriends():void
		{
			var l__1:com.script.io.LoadUrlVars = new LoadUrlVars();
			var l__2:Object = new Object();
			l__2.friend_ids = plModel.friendsList.toString();
			l__1.addEventListener(URLEvent.onLoaded, onFriendsOnlineLoaded);
			//l__1.loadURL((pgData.presence_url + "get_friends_presence.php"), l__2, "POST");
		}
		private function loadNetworkList(p__1:flash.events.Event):void
		{
			if (pgData.connectToZoom == 1){
				if (pgData.useZoomForNetwork == 1){
					plModel.zoomUpdateNetworks(pControl.zoomModel.networkList);
					toggleNetworkButtons();
				} else {
					loadNetwork();
				}
			} else {
				loadNetwork();
			}
		}
		private function loadNetwork():void
		{
			var l__1:com.script.io.LoadUrlVars = new LoadUrlVars();
			var l__2:Object = new Object();
			l__2.uid = ("1:" + plModel.fb_sig_user);
			l__1.addEventListener(URLEvent.onLoaded, onNetworkUsersOnlineLoaded);
			l__1.loadURL((pgData.presence_url + "get_networks_presence.php"), l__2, "POST");
		}
		private function onFriendsOnlineLoaded(p__1:flash.events.Event):void
		{
			var l__2:Array;
			if (p__1.target != null){
				if (pControl.loadBalancer != null){
					plModel.setServerTypeList(pControl.loadBalancer.serverTypeList, pControl.loadBalancer.idList);
				}
				l__2 = new Array();
				l__2 = onUpdateUserPresence(p__1.target);
				plModel.zoomUpdateFriends(l__2);
				plView.hideJoinButton(true);
				plView.friendInfo.budList.dataProvider = plModel.friendGridData;
			}
			plView.friendInfo.friendsOn.visible = true;
			plView.friendInfo.networksOn.visible = false;
			if (pgData.connectToZoom == 1){
				plView.friendInfo.refresh.visible = !(pgData.useZoomForFriends == 1);
			}
		}
		private function onNetworkUsersOnlineLoaded(p__1:flash.events.Event):void
		{
			var l__2:Array;
			if (p__1.target != null){
				if (pControl.loadBalancer != null){
					plModel.setServerTypeList(pControl.loadBalancer.serverTypeList, pControl.loadBalancer.idList);
				}
				l__2 = new Array();
				l__2 = onUpdateUserPresence(p__1.target);
				plModel.zoomUpdateNetworks(l__2);
			}
			toggleNetworkButtons();
		}
		private function toggleNetworkButtons():void
		{
			if (!bJoinUserInit){
				if ((plModel.friendGridData == null) || (plModel.friendGridData.length == 0)){
					plView.friendInfo.budList.dataProvider = plModel.networkUserGridData;
					if (plModel.sn_id != pgData.SN_FACEBOOK){
						plView.friendInfo.networksOn.visible = false;
						plView.friendInfo.friendsOn.visible = true;
						if (pgData.connectToZoom == 1){
							plView.friendInfo.refresh.visible = !(pgData.useZoomForFriends == 1);
						}
					} else {
						plView.friendInfo.friendsOn.visible = false;
						plView.friendInfo.networksOn.visible = true;
						if (pgData.connectToZoom == 1){
							plView.friendInfo.refresh.visible = !(pgData.useZoomForNetwork == 1);
						}
					}
				} else {
					plView.friendInfo.budList.dataProvider = plModel.friendGridData;
					if (plModel.sn_id != pgData.SN_FACEBOOK){
						plView.friendInfo.networksOn.visible = false;
						plView.friendInfo.friendsOn.visible = true;
						if (pgData.connectToZoom == 1){
							plView.friendInfo.refresh.visible = !(pgData.useZoomForFriends == 1);
						}
					} else {
						plView.friendInfo.networksOn.visible = false;
						plView.friendInfo.friendsOn.visible = true;
						if (pgData.connectToZoom == 1){
							plView.friendInfo.refresh.visible = !(pgData.useZoomForFriends == 1);
						}
					}
				}
				bJoinUserInit = true;
			} else {
				plView.friendInfo.budList.dataProvider = plModel.networkUserGridData;
				if (plModel.sn_id != pgData.SN_FACEBOOK){
					plView.friendInfo.networksOn.visible = false;
					plView.friendInfo.friendsOn.visible = true;
					if (pgData.connectToZoom == 1){
						plView.friendInfo.refresh.visible = !(pgData.useZoomForFriends == 1);
					}
				} else {
					plView.friendInfo.networksOn.visible = true;
					plView.friendInfo.friendsOn.visible = false;
					if (pgData.connectToZoom == 1){
						plView.friendInfo.refresh.visible = !(pgData.useZoomForNetwork == 1);
					}
				}
			}
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
					if (l__6 != pgData.zid){
						if (!isNaN(l__8)){
							l__3.push(new UserPresence(l__6, l__7, l__8, l__9, l__14, l__10, l__11, l__12, "", "", ""));
						}
					}
				}
				l__4++;
			}
			return(l__3);
		}		
		private function initLobbyView():void
		{
			
			var l__1:flash.display.Loader = pgData.lbLobby.getLoaderByType("com.script.poker.lobby.LobbyView");
			
			plView = Object(l__1.content);
			plView.initView(plModel);
			if (!(pgData.buzz_url == null) && !(pgData.buzz_url == "")){
				plView.initBuzzAd(pgData.buzz_url);
			}
			
			initViewListeners();
			if (pgData.flashCookie != null){
				setLobbyFilters();
			}
			if (pgData.useZoomForFriends != 1){
				l__1 = null;
				loadFriendList(l__1);
			}
			plView.friendInfo.visible = false;
			dispatchEvent(new LCEvent(LCEvent.VIEW_INIT));
		}
		public function displayLobby():void
		{
			mainDisp.addChildAt(plView, 0);
			pControl.bInLobbyRoom = true;
			if (!pControl.bInLobbyRoom){
				//hideLobby();
			}
			dispatchEvent(new LCEStats(LCEvent.RECORD_STAT, "lobby", "displayLobby"));
		}
		public function hideLobby():void
		{
			if (plView != null){
				plView.visible = false;
			}
		}
		public function showLobby():void
		{
			
			plView.visible = true;
			plView.resetSelection();
		}
		private function getLobbyRooms():void
		{
			pcmConnect.getLobbyRooms();
		}
		private function initViewListeners():void
		{
			plView.addEventListener(LVEvent.onFastTabClick, onFastTabClick);
			plView.addEventListener(LVEvent.onPointsTabClick, onPointsTabClick);
			plView.addEventListener(LVEvent.onPrivateTabClick, onPrivateTabClick);
			plView.addEventListener(LVEvent.onTourneyTabClick, onTourneyTabClick);
			plView.addEventListener(LVEvent.onVipTabClick, onVipTabClick);
			plView.addEventListener(LVEvent.TABLE_SELECTED, onTableSelected);
			plView.addEventListener(SortTablesEvent.SORT_TABLES, onSortTables);
			plView.addEventListener(LVEvent.JOIN_ROOM, onJoinRoomClicked);
			plView.addEventListener(LVEvent.REFRESH_NETWORK, loadNetworkList);
			plView.addEventListener(LVEvent.REFRESH_FRIEND, loadFriendList);
			plView.addEventListener(LVEvent.JOIN_USER, onJoinUserClicked);
			plView.addEventListener(LVEvent.ON_SELECT_FRIEND, onFriendSelected);
			plView.addEventListener(LVEvent.CREATE_TABLE, onCreateTableClicked);
			plView.addEventListener(LVEvent.TRANS_CHIPS, onTransferChipsClicked);
			plView.addEventListener(LVEvent.CHANGE_CASINO, onChangeCasinoClicked);
			plView.addEventListener(LVEvent.FIND_SEAT, onFindSeatClicked);
			plView.addEventListener(LVEvent.REFRESH_LIST, onRefreshListClicked);
			//plView.addEventListener(LVEvent.CONNECT_TO_NEW_CASINO, onCasinoConnectClicked);
			plView.addEventListener(LVEvent.SHOOTOUT_CLICK, onShootoutClicked);
			plView.addEventListener(LVEvent.SITNGO_CLICK, onSitNGoClicked);
			plView.addEventListener(LVEvent.BUYIN_CLICK, onBuyInClicked);
			plView.addEventListener(LVEvent.SHOOTOUT_HOWTOPLAY_CLICK, onHowToPlayClicked);
			plView.addEventListener(LVEvent.SHOOTOUT_LEARNMORE_CLICK, onLearnMoreClicked);
			plView.addEventListener(LVEvent.FULL_TABLES, filterLobbyGrid);
			plView.addEventListener(LVEvent.RUNNING_TABLES, filterLobbyGrid);
			plView.addEventListener(LVEvent.onMainMenuClick, onMainMenuClick);
			plView.addEventListener(LVEvent.onEventClick, onEventClick);
			plView.addEventListener(LVEvent.onChatClick, onChatClick);
			plView.addEventListener(LVEvent.EMPTY_TABLES, filterLobbyGrid);
			plView.addEventListener(LVEvent.CASINO_SELECTED, pickNewCasino);
			plView.addEventListener(LVEvent.REFRESH_LOBBY_ROOMS, refreshLobbyRooms);
			plView.addEventListener(LVEvent.RECORD_STAT, onRecordLobbyViewStat);
			plView.addEventListener(LVEvent.ON_IPHONE_AD_CLICK, onIphoneAdClicked);
			plView.addEventListener(LVEvent.GET_MORE_CHIPS, onGetMoreChipsClicked);
			plView.addEventListener(LVEvent.GET_LESS_CHIPS, onGetLessChipsClicked);
			if (!(pgData.buzz_url == null) && !(pgData.buzz_url == "")){
				plView.buzzAd.addEventListener(LVEvent.BUZZ_AD_CLICK, onBuzzAdClicked);
			}
		}

		private function onFriendSelected(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			var l__2:Object;
			if (plModel.BshowFriendList == true){
				l__2 = plModel.friendGridData.getItemAt(plView.friendInfo.budList.selectedIndex);
				if (l__2 != null){
					if (l__2.playStatus == "Lobby"){
						plView.hideJoinButton(true);
					} else {
						plView.hideJoinButton(false);
					}
				}
			} else {
				plView.hideJoinButton(false);
			}
		}
		private function onMainMenuClick(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			plView.removeEventListener(LVEvent.onMainMenuClick, onMainMenuClick);
			//var l__2:Object;
			//pcmConnect.sendMessage(new SToMainMenu("SToMainMenu"));
			var URLout:URLRequest = new URLRequest("../index.php");
			navigateToURL(URLout,"_self");
			
		}
		private function onEventClick(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			//plView.removeEventListener(LVEvent.onEventClick, onEventClick);
			var l__2:Object;
			pcmConnect.sendMessage(new SEventList("SEventList"));
			
		}
		private function onChatClick(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			viewPopup("../chat/index.php?user="+pgData.zid+"&join="+pgData.jt);
		}
		public function refreshLobbyRooms(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			var l__2:* = undefined;
			plModel.nSelectedTable = -1;
			filterLobbyGrid(l__2);
		}
		private function filterLobbyGrid(p__1:flash.events.Event):void
		{
			
			var l__5:Number = 0;
			var l__6:Number = 0;
			plView.resetSelection();
			var l__2:fl.data.DataProvider = new DataProvider();
			var l__3:int;
			var l__4:Array;
			if ((((plModel.sLobbyMode == "challenge") || (plModel.sLobbyMode == "private")) || (plModel.sLobbyMode == "vip")) || (plModel.sLobbyMode == "fast")){
				l__5 = 0;
				l__6 = 0;
				l__3 = 0;
				
				while(l__3 < plModel.lobbyGridData.length){
					l__4 = plModel.lobbyGridData.getItemAt(l__3).Players.split(" / ");
					l__5 = l__4[0];
					l__6 = l__4[1];
					if (plView.hideEmptyTables.selected && plView.hideFullTables.selected){
						if ((l__5 > 0) && (l__5 < l__6)){
							l__2.addItem(plModel.lobbyGridData.getItemAt(l__3));
						}
					} else if (plView.hideFullTables.selected){
						if (l__5 < l__6){
							l__2.addItem(plModel.lobbyGridData.getItemAt(l__3));
						}
					} else if (plView.hideEmptyTables.selected){
						if (l__5 > 0){
							l__2.addItem(plModel.lobbyGridData.getItemAt(l__3));
						}
					} else {
						l__2.addItem(plModel.lobbyGridData.getItemAt(l__3));
					}
					l__3++;
				}
				plView.lobbyGrid.dataProvider = l__2;
				plView.autoSelectRoom();
			} else if (plModel.sLobbyMode == "tournament"){
				l__3 = 0;
				while(l__3 < plModel.lobbyGridData.length){
					l__4 = plModel.lobbyGridData.getItemAt(l__3).Players.split("/");
					l__5 = l__4[0];
					l__6 = l__4[1];
					if (plView.hideEmptyTables.selected && plView.hideRunningTables.selected){
						if ((l__5 > 0) && !(plModel.lobbyGridData.getItemAt(l__3).Status == "Running")){
							l__2.addItem(plModel.lobbyGridData.getItemAt(l__3));
						}
					} else if (plView.hideRunningTables.selected){
						if (plModel.lobbyGridData.getItemAt(l__3).Status != "Running"){
							l__2.addItem(plModel.lobbyGridData.getItemAt(l__3));
						}
					} else if (plView.hideEmptyTables.selected){
						if (l__5 > 0){
							l__2.addItem(plModel.lobbyGridData.getItemAt(l__3));
						}
					} else {
						l__2.addItem(plModel.lobbyGridData.getItemAt(l__3));
					}
					l__3++;
				}
				plView.lobbyGrid.dataProvider = l__2;
				plView.autoSelectRoom();
			}
			if (pgData.flashCookie != null){
				pgData.flashCookie.SetValue("bHideEmptyTables", plView.hideEmptyTables.selected);
				if (plModel.sLobbyMode == "tournament"){
					pgData.flashCookie.SetValue("bHideRunningTables", plView.hideRunningTables.selected);
				} else if (plModel.sLobbyMode == "shootout"){
				} else {
					pgData.flashCookie.SetValue("bHideFullTables", plView.hideFullTables.selected);
				}
			}
		}
		private function onSortTables(p__1:com.script.poker.lobby.events.view.SortTablesEvent):void
		{
			plModel.sortTables(p__1.dataField, p__1.sortDescending);
			filterLobbyGrid(null);
		}
		private function onTableSelected(p__1:com.script.poker.lobby.events.view.TableSelectedEvent):void
		{
			
			plModel.nSelectedTable = p__1.nId;
			if (plModel.nSelectedTable != 0){
				pcmConnect.sendMessage(new SGetRoomInfo2("SGetRoomInfo2", plModel.nSelectedTable));
			}			
		}
				private function onFastTabClick(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			dispatchEvent(new LCEvent(LCEvent.PRIVATE_TABLE_CLICK));
			pControl.TrackingHit("LobbyClickFastTab", 6, 1, 2010, 100, "Lobby Other Click o:FastTab:2009-06-01", null, 1);
			var l__2:* = undefined;
				plModel.sLobbyMode = "fast";
				pgData.dispMode = "fast";
				plModel.updateRoomList(pgData.aGameRooms);
				plView.lobbyGrid.dataProvider = new DataProvider(plModel.lobbyGridData);
				filterLobbyGrid(l__2);
				plView.setPointsGames();
				
				plModel.seatedPlayersGridData = new DataProvider();
				
		}
		private function onPrivateTabClick(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			dispatchEvent(new LCEvent(LCEvent.PRIVATE_TABLE_CLICK));
			pControl.TrackingHit("LobbyClickPrivateTab", 6, 1, 2010, 100, "Lobby Other Click o:PrivateTab:2009-06-01", null, 1);
			var l__2:* = undefined;
			plModel.sLobbyMode = "private";
				pgData.dispMode = "private";
				plModel.updateRoomList(pgData.aGameRooms);
				plView.lobbyGrid.dataProvider = new DataProvider(plModel.lobbyGridData);
				plView.setPrivateGames();
				filterLobbyGrid(l__2);
				
				plModel.seatedPlayersGridData = new DataProvider();
				
		}
		private function onPointsTabClick(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			var l__2:* = undefined;
			pControl.TrackingHit("LobbyClickPointsTab", 6, 1, 2010, 100, "Lobby Other Click o:PointsTab:2009-06-01", null, 1);
			plModel.nSelectedTable = -1;
			if (((pgData.dispMode == "vipz") || (pgData.dispMode == "tournament")) || (pgData.dispMode == "shootout")){
				plModel.sLobbyMode = "challenge";
				pgData.dispMode = "challenge";
				pgData.bVipNav = true;
				pgData.joinPrevServ = true;
				pControl.loadBalancer.addPrevServerId(pgData.serverId);
				pgData.newServerId = pControl.loadBalancer.getPrevServerOfType("normal");
				pcmConnect.disconnect();
			} else {				
				plModel.sLobbyMode = "challenge";
				pgData.dispMode = "challenge";
				plModel.updateRoomList(pgData.aGameRooms);
				plView.lobbyGrid.dataProvider = new DataProvider(plModel.lobbyGridData);
				plView.setPointsGames();
				filterLobbyGrid(l__2);
			}
			plModel.seatedPlayersGridData = new DataProvider();
		}
		private function onVipTabClick(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			var l__2:* = undefined;
			plModel.nSelectedTable = -1;
			pControl.TrackingHit("LobbyClickVIPTab", 6, 1, 2010, 100, "Lobby Other Click o:VIPTab:2009-06-01", null, 1);
				plModel.sLobbyMode = "vip";
				pgData.dispMode = "vip";
				plModel.updateRoomList(pgData.aGameRooms);
				plView.lobbyGrid.dataProvider = new DataProvider(plModel.lobbyGridData);
				plView.setPointsGames();
				filterLobbyGrid(l__2);
				plModel.seatedPlayersGridData = new DataProvider();
		}
		
		public function onGoToStandardLobby():void
		{
			if (pgData.server_type == "vip"){
				plModel.sLobbyMode = "challenge";
				pgData.dispMode = "challenge";
				pgData.bVipNav = true;
				pgData.joinPrevServ = true;
				pControl.loadBalancer.addPrevServerId(pgData.serverId);
				pgData.newServerId = pControl.loadBalancer.getPrevServerOfType("normal");
				pcmConnect.disconnect();
			}
		}
		public function onGoToVipLobby():void
		{
			if (pgData.server_type == "vip"){
				pControl.findGame();
			} else {
				pgData.tourneyId = -1;
				plModel.sLobbyMode = "vip";
				pgData.dispMode = "vip";
				pgData.bVipNav = true;
				pgData.findVipSeat = true;
				pControl.loadBalancer.addPrevServerId(pgData.serverId);
				pgData.newServerId = pControl.loadBalancer.getPrevServerOfType("vip");
				pgData.joiningContact = false;
				pcmConnect.disconnect();
			}
		}
		private function onJoinVip(p__1:com.script.poker.LBEvent):void
		{
			plModel.seatedPlayersGridData = new DataProvider();
			pControl.loadBalancer.removeEventListener(LBEvent.onServerChosen, onJoinVip);
			pgData.bUserDisconnect = true;
			pcmConnect.disconnect();
			dispatchEvent(new LCEvent(LCEvent.CONNECT_TO_NEW_SERVER));
		}
		private function onTourneyTabClick(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			if ((pgData.dispMode == "tournament") || (pgData.dispMode == "shootout")){
				return;
			}
			plModel.nSelectedTable = -1;
			plModel.sLobbyMode = "shootout";
			pgData.dispMode = "shootout";
			plView.setDefaultSubtab("shootout");
			pgData.bVipNav = true;
			pControl.loadBalancer.addPrevServerId(pgData.serverId);
			pcmConnect.sendMessage(new SGetUserShootoutState("SGetUserShootoutState"));
		}
		public function setShootoutMode():void
		{
			plModel.nSelectedTable = -1;
			plModel.sLobbyMode = "shootout";
			pgData.dispMode = "shootout";
			plView.setDefaultSubtab("shootout");
			pgData.bVipNav = true;
			pControl.loadBalancer.addPrevServerId(pgData.serverId);
		}
		private function onJoinRoomClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			if (plModel.nSelectedTable != 0){
				pControl.TrackingHit("TableJoinTableSelector", 5, 14, 2010, 100, "Table Other TableJoinTableSelector o:LiveJoin:2009-05-14", null, 1);
				//removeZoomModelListeners();
				dispatchEvent(new JoinTableEvent(LCEvent.JOIN_TABLE, plModel.nSelectedTable));
				plModel.nSelectedTable = -1;
				plView.resetSelection();
			}
		}
		private function joinUserRoom(p__1:int):void
		{
			dispatchEvent(new JoinTableEvent(LCEvent.JOIN_TABLE, int(p__1)));
		}
		private function onJoinUserClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			var l__2:int;
			var l__3:* = "";
			var l__4:* = "";
			if (plModel.BshowFriendList == true){
				if (!(plModel.friendsObj[plView.friendInfo.budList.selectedIndex].server_id == null) && !(plModel.friendsObj[plView.friendInfo.budList.selectedIndex].server_id == "null")){
					if (pgData.sn_id == pgData.SN_FACEBOOK){
						pControl.TrackingHit("joinuserfriendslobby", 5, 22, 2010, -1, "Poker FB Lobby Other FriendsJoinUser o:LiveJoin:2009-05-22", null);
					}
					l__2 = plModel.friendsObj[plView.friendInfo.budList.selectedIndex].server_id;
					l__3 = pControl.loadBalancer.getServerType(l__2);
					if (plModel.friendsObj[plView.friendInfo.budList.selectedIndex].room_id > -1){
						pControl.pStats.rec("lobby", "onJoinUserClicked");
						l__4 = pgData.GetSignedTrackingUrl("o:Lobby:FNOnlineJoinUserClicks:2009-03-20");
						if (l__4 != ""){
							pControl.record(l__4);
						}
					}
					if ((!pgData.isVip) && (l__3 == "vip")){
						pControl.chooseVipPopup();
					} else {
						pControl.updateLobbyTabs(l__3);
						friendRoomId = plModel.friendsObj[plView.friendInfo.budList.selectedIndex].room_id;
						pgData.nNewRoomId = plModel.friendsObj[plView.friendInfo.budList.selectedIndex].room_id;
						pgData.newServerId = plModel.friendsObj[plView.friendInfo.budList.selectedIndex].server_id;
						pgData.joiningContact = true;
						pgData.joiningShootout = true;
						pcmConnect.disconnect();
					}
				}
			} else if (!(plModel.networkObj[plView.friendInfo.networkList.selectedIndex].server_id == null) && !(plModel.networkObj[plView.friendInfo.networkList.selectedIndex].server_id == "null")){
				l__2 = plModel.networkObj[plView.friendInfo.networkList.selectedIndex].server_id;
				l__3 = pControl.loadBalancer.getServerType(l__2);
				if (plModel.networkObj[plView.friendInfo.networkList.selectedIndex].room_id > -1){
					pControl.pStats.rec("lobby", "onJoinUserClicked");
					l__4 = pgData.GetSignedTrackingUrl("o:Lobby:FNOnlineJoinUserClicks:2009-03-20");
					if (l__4 != ""){
						pControl.record(l__4);
					}
				}
				if ((!pgData.isVip) && (l__3 == "vip")){
					pControl.chooseVipPopup();
				} else {
					pControl.updateLobbyTabs(l__3);
					friendRoomId = plModel.networkObj[plView.friendInfo.networkList.selectedIndex].room_id;
					pgData.nNewRoomId = plModel.networkObj[plView.friendInfo.networkList.selectedIndex].room_id;
					pgData.newServerId = plModel.networkObj[plView.friendInfo.networkList.selectedIndex].server_id;
					pgData.joiningContact = true;
					pgData.joiningShootout = true;
					pcmConnect.disconnect();
				}
			}
		}
		private function joinUserTable(p__1:com.script.poker.lobby.events.LCEvent):void
		{
			removeEventListener(PCEvent.LOBBY_JOINED, joinUserTable);
			pControl.loadBalancer.removeEventListener(LCEvent.CONNECT_TO_NEW_SERVER, joinUserTable);
			plModel.nSelectedTable = friendRoomId;
			joinUserRoom(friendRoomId);
		}
		private function onFollowUser(p__1:com.script.poker.LBEvent):void
		{
			pControl.loadBalancer.removeEventListener(LBEvent.onServerChosen, onFollowUser);
			pgData.bUserDisconnect = true;
			pcmConnect.disconnect();
			dispatchEvent(new LCEvent(LCEvent.CONNECT_TO_NEW_SERVER));
		}
		private function onRoomInfo(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			
		}
		private function onProtocolMessage(p__1:com.script.poker.protocol.ProtocolEvent):void
		{
			var l__2:Object = p__1.msg;
			switch(l__2.type){
				case "RLogin":
				{
					break;
				}
				case "RRoomListUpdate":
				{
					break;
				}
				case "RJoinRoom":
				{
					break;
				}
				case "RDisplayRoomList":
				{
					handleDisplayRoomList(l__2);
					break;
				}
				case "RRoomInfo":
				{
					handleRoomInfo(l__2);
					break;
				}
				case "RRoomInfo2":
				{
					handleRoomInfo2(l__2);
					break;
				}
				case "RRoomPicked":
				{
					break;
				}
				case "RTM":
				{
					handleRTM(l__2);
					break;
				}
				case "RPointsUpdate":
				{
					onPointsUpdate(l__2);
					break;
				}
				case "RGameAlreadyStarted":
				{
					onGameAlreadyStarted(l__2);
					break;
				}
				case "RAlreadyPlayingShootout":
				{
					onAlreadyPlayingShootout(l__2);
					break;
				}
				case "RWrongRound":
				{
					onWrongRound(l__2);
					break;
				}
				case "RWrongBuyIn":
				{
					onWrongBuyin(l__2);
					break;
				}
				case "RSitNotReserved":
				{
					onSitNotReserved(l__2);
					break;
				}
				case "RShootoutConfigChanged":
				{
					onShootoutConfigChanged(l__2);
					break;
				}
				case "RServerList":
				{
					//serverListHandler(l__2);
					serverListHandler2(l__2);
					break;
				}
				case "RGetChat":
				{
					getChatHandler(l__2);
					break;
				}
				
			}
		}
		private function handleDisplayRoomList(inMsg:Object):void
		{
			var e = undefined;
			var pLoader:com.script.io.LoadUrlVars;
			var fgLoaded:String;
			var statHit:com.script.io.LoadUrlVars;
			var statHit2:com.script.io.LoadUrlVars;
			initZoomModelListeners();
			var tMsg:com.script.poker.protocol.RDisplayRoomList = RDisplayRoomList(inMsg);
			if (pgData.bRoomListInit && (pgData.tourneyId > -1)){
				//pLoader = new LoadUrlVars();
				//pLoader.navigateURL(pgData.tourney_url, "_top");
				return;
			}
			
			pgData.tableCost = tMsg.cost;
			
			if (!pgData.bRoomListInit){
				if (pgData.trace_stats == 1){
				}
				if (pgData.sn_id == 7){
					statHit = new LoadUrlVars();
					//statHit.loadURL("http://nav3.script.com/link/link.php?item=Poker%20MS%20Global%20Other%20Unknown%20o%3AAS3%3ASWF%3ALoadComplete&ltsig=7dd3d170270b75f44e309aea968fe871", {}, "POST");
				}
				fgLoaded = pgData.GetSignedTrackingUrl("o:SWF:LoadComplete:2009-02-11");
				if (fgLoaded != ""){
					statHit2 = new LoadUrlVars();
					statHit2.loadURL(fgLoaded);
				}
			}
			
			pgData.bRoomListInit = true;
			pgData.aGameRooms = tMsg.rooms.concat();
			if ((pgData.bUserDisconnect || pgData.bVipNav) || pgData.joiningContact){
			
				plModel.updateRoomList(pgData.aGameRooms);
				initLobbyModel();
				if (pgData.bVipNav){
					plModel.updateRoomList(pgData.aGameRooms);
					plView.setLobbyDisplay();
					pgData.bVipNav = false;
				}
				if (pgData.joiningContact){
					if (pgData.nNewRoomId != -1){
						dispatchEvent(new JoinTableEvent(LCEvent.JOIN_TABLE, pgData.nNewRoomId));
					} else {
						plModel.updateRoomList(pgData.aGameRooms);
						plView.loadNewServerLobby();
					}
				} else {
					pgData.isJoinFriend = false;
					pgData.isJoinFriendSit = false;
				}
			}
			if (((!pgData.bUserDisconnect) && (!pgData.bVipNav)) && (!pgData.joiningContact)){
				if (!bViewInit){
				
					initLobbyModel();
					plModel.updateRoomList(pgData.aGameRooms);
					initLobbyView();
					bViewInit = true;
				} else {
					plView.lobbyGrid.dataProvider = new DataProvider();
					plModel.updateRoomList(pgData.aGameRooms);
					plView.lobbyGrid.dataProvider = new DataProvider(plModel.lobbyGridData);
					plView.loadNewServerLobby();
				}
			}
			if (pgData.joiningContact){
				pgData.joiningShootout = false;
				if (pControl.loadBalancer.getServerType(pgData.serverId) == "shootout"){
					pgData.joiningShootout = true;
				}
			}
			pgData.bUserDisconnect = false;
			pgData.joiningContact = false;
			if (!pgData.joinShootoutLobby){
				showLobby();
			}
			pgData.joinShootoutLobby = false;
			filterLobbyGrid(e);
			plModel.serverName = pgData.serverName;
			plModel.playersOnline = pgData.usersOnline;
			plModel.totalChips = pgData.points;
			plModel.totalDeposit = pgData.deposit;
			plView.refreshUserInfo();
			try {
				pControl.hideInterstitial();
			} catch (err:TypeError) {
			}
			//onZoomUpdate();
			/*if ((pgData.dispMode == "shootout") || (pgData.shootoutId > -1)){
				pcmConnect.sendMessage(new SGetShootoutConfig("SGetShootoutConfig"));
			}*/
			if (!pgData.joiningContact){
				if (pgData.rejoinRoom != -1){
					dispatchEvent(new JoinTableEvent(LCEvent.JOIN_TABLE, pgData.rejoinRoom));
				} else if (pgData.firstTimePlayer == 1){
					pgData.firstTimePlayer = 0;
					dispatchEvent(new LCEvent(LCEvent.FIND_SEAT));
				}
			}
			pControl.joinTableCheck(plModel.roomid);
		}
		private function handleRoomInfo(p__1:Object):void
		{
		}
		private function handleRoomInfo2(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RRoomInfo2 = RRoomInfo2(p__1);
			plModel.updatePlayerList(l__2);
			plView.updateSeatedPlayersDataGrid();
		}
		private function onCreateTableClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			var popObj = new Object();
			popObj.type = "onCreateTable"
			pControl.regPopup(popObj);
			//pControl.regPopup("onCreateTable", 0);
			//dispatchEvent(new PopupEvent("onCreateTable"));
		}
		private function onTransferChipsClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			var popObj = new Object();
			popObj.type = "onTransferChips"
			pControl.regPopup(popObj);
			
			//pControl.regPopup("onTransferChips", 0);
			//dispatchEvent(new PopupEvent("onCreateTable"));
		}
		
		private function onChangeCasinoClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			//pgData.EnsurePHPPopupsAreClosed();
			pgData.bUserDisconnect = true;
			//pcmConnect.disconnect();
			showServerSelection();
			plView.hideAll();
			plView.showCasinoList();
			//dispatchEvent(new LCEvent(LCEvent.HIDE_FRIEND_SELECTOR));
		}
		public function showServerSelection():void
		{
			//pControl.loadBalancer.addEventListener(LBEvent.onParseServerList, serverListParsed);
			//pControl.loadBalancer.getServerList();
			var l__2:Object;
			pcmConnect.sendMessage(new SServerList("SServerList"));
		}
		//private function serverListParsed(p__1:com.script.poker.LBEvent)
		private function serverListHandler(p__1:Object)
		{
			pcmConnect.disconnect();
			pgData.firstRoomList = true;
			pgData.gameRoomId = 0;
			if (!pgData.joiningContact){
				plModel.updateCasinoList(p__1);
				plView.updateCasinoList();
			}
			pgData.bUserDisconnect = false;
			plModel.playersOnline = pgData.usersOnline;
			plView.refreshUserInfo();
		}
		private function serverListHandler2(p__1:Object)
		{
			//var l__2:com.script.poker.protocol.RServerList = RServerList(p__1);
			
			//plModel.updateCasinoList2(p__1);
			//plView.addCasinoList(p__1);
			//plView.refreshUserInfo();
		}
		private function getChatHandler(p__1:Object)
		{
			plModel.chatPop = p__1.pop;
			pgData.chatPop = p__1.pop;
			
			
				if (plModel.chatPop > 0) {
					plView.logochat_btn.gotoAndStop(1);
				}else {
					plView.logochat_btn.gotoAndStop(2);
				}
			if (p__1.resp > 0) {
				viewPopup("../chat/index.php?user="+pgData.zid+"&join="+pgData.jt);
			}
		}
		public function viewPopup(pop) {
			var address:String = pop;
			var jscommand:String = "window.open('"+address+"','PopUpWindow','height=500,width=520,toolbar=no,scrollbars=no,resizable=yes');";
			var url:URLRequest = new URLRequest("javascript:" + jscommand + " void(0);");
			navigateToURL(url,"_self");
		}
		private function onFindSeatClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			//removeZoomModelListeners();
			dispatchEvent(new LCEvent(LCEvent.FIND_SEAT));
		}
		private function handleRoomPicked(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RRoomPicked = RRoomPicked(p__1);
			plModel.nSelectedTable = l__2.roomId;
			dispatchEvent(new JoinTableEvent(LCEvent.JOIN_TABLE, plModel.nSelectedTable));
		}
		private function onRefreshListClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			pcmConnect.getLobbyRooms();
		}
		public function gotoShootoutServer():void
		{
			pcmConnect.disconnect();
		}
		private function onShootoutClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			if (pgData.dispMode == "shootout"){
				return;
			}
			if (pgData.sn_id == pgData.SN_FACEBOOK){
				pControl.TrackingHit("LobbyClickShootoutTab", 6, 1, 2010, 100, "Poker FB Lobby Click TournamentsShootoutTab o:LobbyUI:2009-06-01", null, 1);
			}
			plModel.nSelectedTable = -1;
			plModel.sLobbyMode = "shootout";
			pgData.dispMode = "shootout";
			pgData.bVipNav = true;
			pControl.loadBalancer.addPrevServerId(pgData.serverId);
			pcmConnect.sendMessage(new SGetUserShootoutState("SGetUserShootoutState"));
		}
		private function onSitNGoClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			if (pgData.dispMode == "tournament"){
				return;
			}
			if (pgData.sn_id == pgData.SN_FACEBOOK){
				pControl.TrackingHit("LobbyClickSitNGoTab", 6, 1, 2010, 100, "Poker FB Lobby Click TournamentsSitNGoTab o:LobbyUI:2009-06-01", null, 1);
			}
			plModel.nSelectedTable = -1;
			plModel.sLobbyMode = "tournament";
			pgData.dispMode = "tournament";
			pgData.bVipNav = true;
			pgData.joinPrevServ = true;
			pControl.loadBalancer.addPrevServerId(pgData.serverId);
			pgData.newServerId = pControl.loadBalancer.getPrevServerOfType("sitngo");
			pcmConnect.disconnect();
		}
		private function onBuyInClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			if (pgData.dispMode != "shootout"){
				return;
			}
			if (pgData.sn_id == pgData.SN_FACEBOOK){
				pControl.TrackingHit("LobbyClickShootoutBuyinTab", 6, 1, 2010, 100, "Poker FB Lobby Click TournamentsShootoutPlayButton o:LobbyUI:2009-06-01", null, 1);
			}
			autositShootout();
			
		}
		private function autositShootout():void
		{
			var l__1:String;
			var l__2:String;
			pgData.joiningShootout = false;
			if (pgData.points < pControl.soConfig.nBuyin){
				l__1 = pgData.config["servererror"]["title"];
				l__2 = pgData.config["servererror"]["message2"];
				dispatchEvent(new ErrorPopupEvent("onErrorPopup", "Buy-in Error", "You don\'t have enough chips to play the game."));
			} else {
				pcmConnect.sendMessage(new SPickRoomShootout("SPickRoomShootout", pControl.soConfig.nId, pControl.soConfig.nIdVersion));
			}
		}
		private function onHowToPlayClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			dispatchEvent(new PopupEvent("showShootoutHowToPlay"));
		}
		private function onLearnMoreClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			dispatchEvent(new PopupEvent("showShootoutLearnMore"));
		}
		private function onCasinoConnectClicked():void
		{
			var l__2:String;
			var l__3:String;
			var l__4:String;
			
			//if (plView.casinoInfo.casinoList.selectedItem != null){
				pgData.serverName = plModel.sSelServerName;
				pgData.ip = plModel.sSelServerIp;
				//l__2 = pControl.loadBalancer.getServerType(pgData.serverId);
				l__2 = plModel.sSelServerType
				/*if (l__2 == "normal"){
					pControl.loadBalancer.addPrevServerId(pgData.serverId);
				}*/
				pgData.serverId = plModel.sSelServerId;
				pgData.server_type = plModel.sSelServerType;
				//pgData.sZone = pControl.loadBalancer.getZone(pgData.server_type);
				if (pgData.server_type == "vip"){
					pgData.bVipNav = true;
					pgData.dispMode = "vip";
					plModel.sLobbyMode = "vip";
				} else if (pgData.server_type == "sitngo"){
					pgData.dispMode = "tournament";
					plModel.sLobbyMode = "tournament";
				} else if (pgData.server_type == "shootout"){
					pgData.dispMode = "shootout";
					plModel.sLobbyMode = "shootout";
				} else {
					pgData.dispMode = "challenge";
					plModel.sLobbyMode = "challenge";
				}
				pControl.connectToServer();
			/*} else {
				l__3 = pgData.config["servererror"]["title"];
				l__4 = pgData.config["servererror"]["message2"];
				dispatchEvent(new ErrorPopupEvent("onErrorPopup", l__3, l__4));
			}*/
		}
		
		public function onReconnection(p__1:flash.events.Event):void
		{
		}
		private function pickNewCasino(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			/*plModel.sSelServerIp = plModel.casinoListData2[p__1.nServerId].data;
			plModel.sSelServerName = p__1.nName;
			
			plModel.sSelServerId = p__1.nServerId;
			plModel.sSelServerType = p__1.nName;*/
			//plModel.sSelServerType = pControl.loadBalancer.getServerType(plModel.sSelServerId);
			/*var popObj = new Object();
			popObj.type = "onChangeCasino";
			pControl.regPopup(popObj);*/
			
			var l__1:Object = new Object();
			l__1.type = "onErrorPopup";
			l__1.upper = "Alert";
			l__1.mess = plModel.langs.l_moveto+" : "+p__1.nName+" ?";
			l__1.sName = p__1.nName
			l__1.sData = plModel.casinoListData2[(p__1.nServerId-1)].data
			l__1.sId = p__1.nServerId;
			l__1.goto = "server";
			pControl.regPopup(l__1);
			
		}
		public function pickNewCasino2(p__1:Object):void
		{
			plModel.sSelServerIp = p__1.sData;
			plModel.sSelServerName = p__1.sName;
			
			plModel.sSelServerId = p__1.sId;
			plModel.sSelServerType = p__1.sName;
			
			pgData.bUserDisconnect = true;
			pcmConnect.disconnect();			
			//plView.hideAll();			
			pgData.firstRoomList = true;
			pgData.gameRoomId = 0;
			pgData.bUserDisconnect = false;
			plModel.playersOnline = pgData.usersOnline;
			
			
			onCasinoConnectClicked();
			
			
		}
		public function privateTable():void
		{
			
			var l__1:Object = {name:"j", pwd:"j", smallBlind:10, bigBlind:100, maxBuyin:1000, maxPlayers:5};
			pcmConnect.sendMessage(new SCreatePrivateRoom("SCreatePrivateRoom", "j", "j", 10, 100, 1000, 5));
		}
		private function handleRTM(p__1:Object):void
		{			
			var l__2:com.script.poker.protocol.RTM = RTM(p__1);
			var l__3:String = pgData.config["tm"]["title"];
			var l__4:String = StringUtility.FormatString(pgData.config["tm"]["message"], {sText:"%chips%", nVar:l__2.chips});
			dispatchEvent(new ErrorPopupEvent("onErrorPopup", l__3, l__4));
		}
		private function onRecordLobbyViewStat(p__1:com.script.poker.lobby.events.LVEvent):void
		{
		}
		private function onIphoneAdClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			var l__2:com.script.io.LoadUrlVars = new LoadUrlVars();
			l__2.navigateURL(pgData.iphone_url, "_blank");
		}
		private function onGetMoreChipsClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			var popObj = new Object();
			popObj.type = "onTransferChips";
			pControl.regPopup(popObj);
			
			//pControl.regPopup("onTransferChips", 0);
			//pControl.getMoreChips();
		}
		private function onGetLessChipsClicked(p__1:com.script.poker.lobby.events.LVEvent):void
		{
			//pControl.regPopup("onTransferChips", 0);
			pControl.getLessChips();
		}
		private function onBuzzAdClicked(p__1:com.script.poker.lobby.events.view.BuzzAdEvent):void
		{
			var l__2:String;
			var l__3:com.script.io.LoadUrlVars;
			switch(p__1.sTarget){
				case "javascript":
				{
					if ((pgData.sn_id == pgData.SN_FACEBOOK) && (pgData.jsCallType == "fbbridge")){
						pgData.callFBJS(p__1.sLink);
					} else if (pgData.jsCallType == "none"){
					} else if (ExternalInterface.available){
						ExternalInterface.call(p__1.sLink);
					}
					break;
				}
				default:
				{
					l__2 = "_blank";
					if (p__1.sTarget == "same"){
						l__2 = "_top";
					}
					l__3 = new LoadUrlVars();
					l__3.navigateURL(p__1.sLink, l__2);
				}
			}
		}
		private function onPointsUpdate(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RPointsUpdate = RPointsUpdate(p__1);
			pControl.feedUpdates(l__2.points, pgData.points);
			pgData.points = l__2.points;
			pgData.deposit = l__2.deposit;
			plModel.totalChips = pgData.points;
			plModel.totalDeposit = pgData.deposit;
			plView.refreshUserInfo();


		}
		private function initZoomModelListeners():void
		{
			/*if (pgData.connectToZoom != 1){
				return;
			}*/
			trace(ZshimModel+"hrhr");
			trace(pControl+"hehehe");
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
			var l__3:* = undefined;
			if (pgData.useZoomForFriends != 1){
				return;
			}
			var l__2:Array = p__1.playerList;
			prevSelId = plView.friendInfo.budList.selectedIndex;
			if (prevSelId > -1){
				selectedFriendSource = plModel.friendsObj[prevSelId].source;
			}
			plModel.zoomUpdateFriends(l__2);
			if (plView.friendInfo.friendsOn.visible){
				plView.friendInfo.budList.dataProvider = plModel.friendGridData;
				plView.friendInfo.networksOn.visible = false;
				if (prevSelId > -1){
					l__3 = 0;
					while(l__3 < plModel.friendsObj.length){
						if (selectedFriendSource == plModel.friendsObj[l__3].source){
							if (plModel.friendsObj[l__3].playStatus == "Lobby"){
								plView.friendInfo.budList.selectedIndex = -1;
								plView.hideJoinButton(true);
							} else {
								plView.friendInfo.budList.selectedIndex = l__3;
								plView.hideJoinButton(false);
							}
						}
						l__3++;
					}
				} else {
					plView.hideJoinButton(true);
				}
				plView.friendInfo.refresh.visible = !(pgData.useZoomForFriends == 1);
			}
		}
		private function onZoomModelNetworkUpdate(p__1:com.script.zoom.ZshimModelEvent):void
		{
			if (pgData.useZoomForNetwork != 1){
				return;
			}
			var l__2:Array = p__1.playerList;
			plModel.zoomUpdateNetworks(l__2);
			if (!plView.friendInfo.friendsOn.visible){
				plView.friendInfo.budList.dataProvider = plModel.networkUserGridData;
				plView.friendInfo.networksOn.visible = true;
				plView.friendInfo.refresh.visible = !(pgData.useZoomForNetwork == 1);
			}
		}
		private function onZoomUpdate():void
		{
			var l__1:Array;
			var l__2:Number = 0;
			var l__3:com.script.poker.UserPresence;
			var l__4:Array;
			var l__5:Number = 0;
			var l__6:com.script.poker.UserPresence;
			if (pgData.connectToZoom != 1){
				return;
			}
			if (pgData.useZoomForFriends == 1){
				l__1 = new Array();
				l__2 = 0;
				while(l__2 < pControl.zoomModel.friendsList.length){
					l__3 = pControl.zoomModel.friendsList[l__2];
					l__3.sRoomDesc = pControl.getNetworkUserStatus(l__3.nServerId, pControl.loadBalancer.getServerType(l__3.nServerId), l__3.nRoomId);
					l__1.push(l__3);
					l__2++;
				}
				plModel.zoomUpdateFriends(l__1);
				plView.hideJoinButton(true);
				if (plView.friendInfo.friendsOn.visible){
					plView.friendInfo.budList.dataProvider = plModel.friendGridData;
					plView.friendInfo.networksOn.visible = false;
					plView.friendInfo.refresh.visible = !(pgData.useZoomForFriends == 1);
				}
			}
			if (pgData.useZoomForNetwork == 1){
				l__4 = new Array();
				l__5 = 0;
				while(l__5 < pControl.zoomModel.networkList.length){
					l__6 = pControl.zoomModel.networkList[l__5];
					l__6.sRoomDesc = pControl.getNetworkUserStatus(l__6.nServerId, pControl.loadBalancer.getServerType(l__6.nServerId), l__6.nRoomId);
					l__6.sRelationship = pControl.getNetworkName(l__6.sNetworkIds);
					l__4.push(l__6);
					l__5++;
				}
				plModel.zoomUpdateNetworks(l__4);
				if (!plView.friendInfo.friendsOn.visible){
					plView.friendInfo.budList.dataProvider = plModel.networkUserGridData;
					plView.friendInfo.networksOn.visible = true;
					plView.friendInfo.refresh.visible = !(pgData.useZoomForNetwork == 1);
				}
			}
		}
		private function onGameAlreadyStarted(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RGameAlreadyStarted = RGameAlreadyStarted(p__1);
			dispatchEvent(new ErrorPopupEvent("onErrorPopup", "Seating Error", "We were unable to sit you at an appropriate Shootout table. Please try again."));
		}
		private function onAlreadyPlayingShootout(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RAlreadyPlayingShootout = RAlreadyPlayingShootout(p__1);
			dispatchEvent(new ErrorPopupEvent("onErrorPopup", "Already Playing", "You are already playing at a Shootout table at the moment. One at a time, please!"));
		}
		private function onWrongRound(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RWrongRound = RWrongRound(p__1);
			var l__3:* = (((("You cannot sit at this table because it is a Shootout Round " + l__2.nRoomRound) + " table. You are currently qualified for Round ") + l__2.nUserRound) + ".");
			dispatchEvent(new ErrorPopupEvent("onErrorPopup", "Incorrect Round", l__3));
		}
		private function onWrongBuyin(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RWrongBuyin = RWrongBuyin(p__1);
			dispatchEvent(new ErrorPopupEvent("onErrorPopup", "Buy-in Amount Changed", "This Buy-in amount is no longer valid. Please reload the Shootouts lobby and try again."));
		}
		private function onSitNotReserved(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RSitNotReserved = RSitNotReserved(p__1);
			dispatchEvent(new ErrorPopupEvent("onErrorPopup", "Can\'t Join", "Our apologies, someone rudely sat in the seat we were reserving for you. Please try again."));
		}
		private function onShootoutConfigChanged(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RShootoutConfigChanged = RShootoutConfigChanged(p__1);
			pcmConnect.sendMessage(new SGetShootoutConfig("SGetShootoutConfig"));
		}
		public function updateShootoutConfig(p__1:com.script.poker.shootout.ShootoutConfig, p__2:com.script.poker.shootout.ShootoutUser):void
		{
			plView.updateShootoutConfig(p__1, p__2);
			if (pgData.shootoutId > -1){
				plModel.sLobbyMode = "shootout";
				pgData.dispMode = "shootout";
				pgData.shootoutId = -1;
				pcmConnect.sendMessage(new SGetUserShootoutState("SGetUserShootoutState"));
			}
		}
		public function updateShootoutUser(p__1:com.script.poker.shootout.ShootoutUser):void
		{
			pgData.shootoutRound = p__1.nRound;
			if (pgData.dispMode == "shootout"){
				return;
			}
			plModel.nSelectedTable = -1;
			plModel.sLobbyMode = "shootout";
			pgData.dispMode = "shootout";
			pgData.bVipNav = true;
			pgData.joinPrevServ = false;
			pControl.loadBalancer.addPrevServerId(pgData.serverId);
			pcmConnect.disconnect();
		}
	}
}