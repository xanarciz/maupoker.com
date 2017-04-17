// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby{
	import fl.controls.listClasses.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	import fl.data.*;
	import fl.managers.*;
	import flash.net.*;
	import com.script.poker.lobby.events.view.*;
	import fl.events.*;
	import com.script.poker.shootout.ShootoutConfig;
	import com.script.poker.shootout.ShootoutUser;
	import flash.text.*;
	import fl.controls.dataGridClasses.*;
	import com.script.format.*;
	import com.script.poker.lobby.events.*;
	import com.script.poker.lobby.asset.*;
	import com.script.poker.controls.listClasses.*;
	import com.script.display.*;
	import com.script.poker.lobby.skins.*;
	public class LobbyView extends flash.display.MovieClip {
		public var mcPrivateTabOff:flash.display.MovieClip;
		public var mcFastTabOn:flash.display.MovieClip;
		public var mcPointsTabOff:flash.display.MovieClip;
		public var mcPic:flash.display.MovieClip;
		public var tlSeatedPlayers:fl.controls.TileList;
		public var userInfo:flash.display.MovieClip;
		public var mcTournTabOn:flash.display.MovieClip;
		public var dfBuzzBox:com.script.poker.lobby.asset.DrawFrame;
		public var mcVipTabOff:flash.display.MovieClip;
		public var createRoom_btn:flash.display.MovieClip;
		public var casinoList:flash.display.MovieClip;
		public var lobbyGrid:fl.controls.DataGrid;
		public var casinoInfo:flash.display.MovieClip;
		public var mcPrivateTabOn:flash.display.MovieClip;
		public var dfSeatedPlayers:com.script.poker.lobby.asset.DrawFrame;
		public var clickedRoomId:int;
		public var buzzAd:com.script.poker.lobby.BuzzAd;
		public var friendInfo:flash.display.MovieClip;
		public var hideEmptyTables:fl.controls.CheckBox;
		//public var logoVip:flash.display.MovieClip;
		private var plModel:com.script.poker.lobby.LobbyModel;
		public var greenBackground:flash.display.MovieClip;
		public var redBackground:flash.display.MovieClip;
		public var lbtext:flash.text.TextField;
		//public var logo:flash.display.MovieClip;
		public var iphoneAd:flash.display.MovieClip;
		public var hideFullTables:fl.controls.CheckBox;
		public var mcPointsTabOn:flash.display.MovieClip;
		public var getHelp_btn:flash.display.SimpleButton;
		public var mainmenu_btn;
		public var event_btn;
		public var logochat_btn:flash.display.MovieClip;
		public var mcLobby:flash.display.MovieClip;
		public var mcTournTabOff:flash.display.MovieClip;
		public var hideRunningTables:fl.controls.CheckBox;
		public var buGetHelpL:flash.display.SimpleButton;
		public var btnFindSeat:flash.display.MovieClip;
		public var mcVipTabOn:flash.display.MovieClip;
		public var lobbyChrome:flash.display.MovieClip;
		public var langs = new Object();
		
		public function LobbyView() {
			/*__setProp_lobbyGrid_Scene1_LobbyMain_0();
			__setProp_hideFullTables_Scene1_checkboxes_0();
			__setProp_hideEmptyTables_Scene1_checkboxes_0();
			__setProp_hideRunningTables_Scene1_checkboxesrunning_0();*/
		}
		public function initView(p__1:com.script.poker.lobby.LobbyModel):void {
			plModel = p__1;
			
			langs = plModel.langs;
			
			__setProp_lobbyGrid_Scene1_LobbyMain_0();
			__setProp_hideFullTables_Scene1_checkboxes_0();
			__setProp_hideEmptyTables_Scene1_checkboxes_0();
			__setProp_hideRunningTables_Scene1_checkboxesrunning_0();
			
			initLobbyUI();
			initUserInfo();
			loadPointGames();
			initSeatedPlayersGrid();
			initSeatedPlayers();
			setLobbyButtons(true);
			initUIListeners();
			initFriendInfo();
			casinoInfo.visible = false;
			//friendInfo.joinUser.alpha = 0.5;
			//friendInfo.joinUser.mouseEnabled = false;
			//friendInfo.joinUser.enabled = false;
			friendInfo.visible = false;
			
		}
		private function initSeatedPlayers():void {
			dfSeatedPlayers = new DrawFrame(240, 120, true, false);
			dfSeatedPlayers.renderTitle("AT THIS TABLE");
			dfSeatedPlayers.x = 14;
			dfSeatedPlayers.y = 396;
			addChild(dfSeatedPlayers);
			var l__1:flash.text.TextFormat = new TextFormat();
			l__1.font = "Arial";
			l__1.color = 16777215;
			l__1.size = 11;
			var l__2:flash.text.TextField = new TextField();
			l__2.htmlText = "Table: Big Guns";
			l__2.x = 140;
			l__2.y = -20;
			l__2.setTextFormat(l__1);
			l__2.autoSize = "right";
			l__2.name = "tableName";
			dfSeatedPlayers.addChild(l__2);
			dfSeatedPlayers.addChild(tlSeatedPlayers);
		}
		private function initSeatedPlayersGrid():void {
			tlSeatedPlayers = new TileList();
			tlSeatedPlayers.setStyle("cellRenderer", SeatedPlayersImageCell);
			tlSeatedPlayers.setStyle("contentPadding", 0);
			tlSeatedPlayers.setStyle("skin", CustomCellBg);
			tlSeatedPlayers.columnWidth = 72;
			tlSeatedPlayers.rowHeight = 90;
			tlSeatedPlayers.columnCount = 4;
			tlSeatedPlayers.width = 240;
			tlSeatedPlayers.height = 120;
			tlSeatedPlayers.direction = ScrollBarDirection.VERTICAL;
		}
		private function initLobbyUI():void {
			hideFullTables.label = langs.l_hidefulltable;
			hideRunningTables.label = langs.l_hideruntable;
			hideEmptyTables.label = langs.l_hideemptytable;
			hideFullTables.labelPlacement = "left";
			hideRunningTables.labelPlacement = "left";
			hideEmptyTables.labelPlacement = "left";
			hideFullTables.height = 20;
			hideRunningTables.height = 20;
			hideEmptyTables.height = 20;
			
			//mcLobby.mcTournTabOff.useHandCursor = true;
			//mcLobby.mcTournTabOff.buttonMode = true;
			mcLobby.mcFastTabOff.useHandCursor = true;
			mcLobby.mcFastTabOff.buttonMode = true;
			mcLobby.mcPrivateTabOff.useHandCursor = true;
			mcLobby.mcPrivateTabOff.buttonMode = true;
			mcLobby.mcPointsTabOff.useHandCursor = true;
			mcLobby.mcPointsTabOff.buttonMode = true;
			mcLobby.mcVipTabOff.useHandCursor = true;
			mcLobby.mcVipTabOff.buttonMode = true;
			mcLobby.joinRoom_btn.buttonMode = true;
			mcLobby.joinRoom_btn.useHandCursor = true;
			mcLobby.createRoom_btn.buttonMode = true;
			mcLobby.createRoom_btn.useHandCursor = true;
			mcLobby.refresh_btn.buttonMode = true;
			mcLobby.refresh_btn.useHandCursor = true;
			/*mcLobby.getMorePoints_btn.buttonMode = true;
			mcLobby.getMorePoints_btn.useHandCursor = true;
			mcLobby.getLessPoints_btn.buttonMode = true;
			mcLobby.getLessPoints_btn.useHandCursor = true;*/
			//mcLobby.shootout_btn.buttonMode = true;
			//mcLobby.shootout_btn.useHandCursor = true;
			//mcLobby.shootout_btn.mouseChildren = false;
			//mcLobby.sitngo_btn.buttonMode = true;
			//mcLobby.sitngo_btn.useHandCursor = true;
			//mcLobby.sitngo_btn.mouseChildren = false;
			
			//mcLobby.buyin_btn.buttonMode = true;
			//mcLobby.buyin_btn.useHandCursor = true;
			//mcLobby.buyin_btn.mouseChildren = false;
			//mcLobby.buyin_btn.gotoAndStop(1);
			//mcLobby.learnmore_btn.buttonMode = true;
			//mcLobby.learnmore_btn.useHandCursor = true;
			mcLobby.mcPointsTabOn.txt.text = langs.l_public.toUpperCase();
			mcLobby.mcPrivateTabOn.txt.text = langs.l_private.toUpperCase();
			mcLobby.mcFastTabOn.txt.text = langs.l_fast.toUpperCase();
			mcLobby.mcVipTabOn.txt.text = plModel.vipName.toUpperCase();
			mcLobby.mcFastTabOff.txt.text = langs.l_fast.toUpperCase();
			mcLobby.mcPointsTabOff.txt.text = langs.l_public.toUpperCase();
			mcLobby.mcPrivateTabOff.txt.text = langs.l_private.toUpperCase();
			mcLobby.mcVipTabOff.txt.text = plModel.vipName.toUpperCase();
			mcLobby.joinRoom_btn.txt.text = langs.l_enter+" "+langs.l_room;
			mcLobby.refresh_btn.txt.text = langs.l_refresh+" "+langs.l_room;
			mainmenu_btn.txt.text = langs.l_mainmenu;
			userInfo.changeCasino1_btn.visible = false;
			userInfo.changeCasino2_btn.visible = false;
			userInfo.changeCasino3_btn.visible = false;
			userInfo.changeCasino4_btn.visible = false;
			userInfo.changeCasino5_btn.visible = false;
			userInfo.s_txt1.visible = false;
			userInfo.s_txt2.visible = false;
			userInfo.s_txt3.visible = false;
			userInfo.s_txt4.visible = false;
			userInfo.s_txt5.visible = false;
			userInfo.s_txt1.mouseEnabled = false
			userInfo.s_txt2.mouseEnabled = false
			userInfo.s_txt3.mouseEnabled = false
			userInfo.s_txt4.mouseEnabled = false
			userInfo.s_txt5.mouseEnabled = false
			mcLobby.mcPointsTabOff.txt.mouseEnabled = false
			mcLobby.mcPrivateTabOff.txt.mouseEnabled = false
			mcLobby.mcVipTabOff.txt.mouseEnabled = false
			
			if (Number(plModel.chatStat) == 1){
				if (plModel.chatPop > 0) {
					logochat_btn.gotoAndStop(1);
				}else {
					logochat_btn.gotoAndStop(2);
				}
			}else {
				logochat_btn.visible = false;
			}
			
			initLobbyDataGridUI();
			
		}
		private function initLobbyDataGridUI():void {
			
			var l__1:flash.text.TextFormat = new TextFormat();
			lobbyGrid.setStyle("headerUpSkin", "lobbyGridHeader_upSkin");
			lobbyGrid.headerHeight = 28;
			l__1.size = 18;
			l__1.color = 0;
			l__1.bold = true;
			l__1.font = "Arial";
			var l__2:* = new TextFormat();
			l__2.color = 0;
			l__2.size = 18;
			l__2.font = "Arial";
			StyleManager.setStyle("highlightTextFormat", l__2);
			var l__3:flash.text.TextFormat = new TextFormat();
			l__3.color = 0;
			l__3.size = 18;
			l__3.font = "Arial";
			StyleManager.setStyle("defaultTextFormat", l__3);
			lobbyGrid.setStyle("headerTextFormat", l__1);
			lobbyGrid.setStyle("cellRenderer", LobbyGridCell);
			lobbyGrid.setRendererStyle("textFormat", l__3);
		}
		public function refreshLobby():void {
			dispatchEvent(new LVEvent(LVEvent.REFRESH_LOBBY_ROOMS));
		}
		public function loadPointGames():void {
			
			var l__0:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("NO");
			l__0.headerText = "No";
			l__0.width = 35;
			var l__1:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("ID");
			l__1.headerText = "ID";
			l__1.width = 35;
			var l__2:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("Room");
			l__2.headerText = langs.l_room;
			l__2.width = 110;
			var l__5:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("Min");
			l__5.headerText = langs.l_minbuy;
			l__5.width = 80;
			var l__6:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("Max");
			l__6.headerText = langs.l_minmaxbuy;
			l__6.width = 90;
			var l__3:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("Stakes");
			l__3.headerText = langs.l_blind;
			l__3.width = 80;
			var l__4:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("Players");
			l__4.headerText = langs.l_player;
			l__4.width = 66;
			var l__8:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("Jackpot");
			l__8.headerText = langs.l_jackpot;
			l__8.width = 70;			
			/*var l__7:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("Status");
			l__7.headerText = langs.l_status;
			l__7.width = 70;*/
			lobbyGrid.removeAllColumns();
			
			lobbyGrid.addColumn(l__0);
			lobbyGrid.addColumn(l__1);
			lobbyGrid.addColumn(l__2);
			lobbyGrid.addColumn(l__5);
			lobbyGrid.addColumn(l__6);
			lobbyGrid.addColumn(l__3);
			lobbyGrid.addColumn(l__4);
			//lobbyGrid.addColumn(l__8);
			//lobbyGrid.addColumn(l__7);
			

			lobbyGrid.getColumnAt(1).visible = false;

		}
		public function loadTourney():void {

			var l__1:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("ID");
			l__1.headerText = "ID";
			l__1.width = 35;
			var l__2:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("Room");
			l__2.headerText = langs.l_room;
			l__2.width = 140;
			var l__3:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("Fee");
			l__3.headerText = langs.l_fee;
			l__3.width = 100;
			var l__4:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("Players");
			l__4.headerText = langs.l_player;
			l__4.width = 70;
			var l__5:fl.controls.dataGridClasses.DataGridColumn = new DataGridColumn("Status");
			l__5.headerText = langs.l_status;
			l__5.width = 70;
			lobbyGrid.removeAllColumns();
			lobbyGrid.addColumn(l__1);
			lobbyGrid.addColumn(l__2);
			lobbyGrid.addColumn(l__3);
			lobbyGrid.addColumn(l__4);
			lobbyGrid.addColumn(l__5);
		}
		public function loadPrivate():void {
			loadPointGames();
		}
		public function autoSelectRoom():void {
			if (lobbyGrid.length > 2) {
				lobbyGrid.selectedIndex = 1;
				lobbyGrid.dispatchEvent(new Event(Event.CHANGE, false, false));
			}
		}
		private function initUserInfo():void {
			
			userInfo.welcome.text = (langs.l_welcome+", " + plModel.playerName.split(" ")[0]);
			//userInfo.welcome.text = ("Welcome, King Ace");
			//userInfo.rank.text = plModel.playerRank;
			//userInfo.rank.text = "Newbie";
			userInfo.online_txt.text = langs.l_playeronline;
			
			
			userInfo.points.text = langs.l_chips+":"+AsDollars.giveMe(plModel.totalChips);
			trace(langs.l_chips+"haha12345");
			userInfo.balance.text = AsDollars.giveMe(plModel.totalDeposit);
			userInfo.server.text = (langs.l_location+" : " + plModel.serverName);
			//userInfo.server.text = ("Casino: Royal Flush");
			userInfo.online.text = StringUtility.StringToMoney(plModel.playersOnline);
			casinoInfo.playersOnline.text = (langs.l_onlinenow+" : " + StringUtility.StringToMoney(plModel.playersOnline));
			
			userInfo.mcVip.visible = plModel.bVip;
			userInfo.game_info.text = plModel.gameInfo;
			//userInfo.mcVip.visible = false;
			var l__1:com.script.display.SafeImageLoader = new SafeImageLoader("../Avatar/default.jpg");
			l__1.contentLoaderInfo.addEventListener(Event.COMPLETE, onUserPicComplete);
			l__1.load(new URLRequest(plModel.pic_url));
			
		}
		public function refreshUserInfo():void {
			
			//userInfo.welcome.text = ("Welcome, " + plModel.playerName.split(" ")[0]);
			//userInfo.rank.text = plModel.playerRank;
			userInfo.points.text = langs.l_chips+":"+AsDollars.giveMe(plModel.totalChips);
			trace(langs.l_chips+"haha12345");
			userInfo.balance.text = AsDollars.giveMe(plModel.totalDeposit);
			userInfo.server.text = (langs.l_location+" : " + plModel.serverName);
			userInfo.online.text = StringUtility.StringToMoney(plModel.playersOnline);
			casinoInfo.playersOnline.text = (langs.l_onlinenow+" : " + StringUtility.StringToMoney(plModel.playersOnline));
			
			userInfo.mcVip.visible = plModel.bVip;
			//userInfo.mcVip.visible = false;
		}
		private function onUserPicComplete(p__1:flash.events.Event):void {
			var l__5:* = undefined;
			var l__2:Number = 55;
			var l__3:Number = 55;
			var l__4:com.script.display.SafeImageLoader = ((p__1.target.loader) as SafeImageLoader);
			if ((l__4.width > l__2) || (l__4.height > l__3)) {
				l__5 = 1 / Math.max(l__4.height / l__3, l__4.width / l__2);
				l__4.scaleX *= (l__5);
				l__4.scaleY *= (l__5);
			}
			userInfo.mcPic.addChild(l__4);
		}
		private function initUIListeners():void {
			mcLobby.mcPrivateTabOff.addEventListener(MouseEvent.MOUSE_UP, onMcPrivateTabOff);
			//mcLobby.mcTournTabOff.addEventListener(MouseEvent.MOUSE_UP, onMcTournTabOff);
			mcLobby.mcFastTabOff.addEventListener(MouseEvent.MOUSE_UP, onMcFastTabOff);
			mcLobby.mcPointsTabOff.addEventListener(MouseEvent.MOUSE_UP, onMcPointsTabOff);
			mcLobby.mcVipTabOff.addEventListener(MouseEvent.MOUSE_UP, onMcVipTabOff);
			mcLobby.joinRoom_btn.addEventListener(MouseEvent.MOUSE_UP, onJoinRoom);
			mcLobby.getMorePoints_btn.addEventListener(MouseEvent.MOUSE_UP, onGetMorePointsClick);
			mcLobby.getLessPoints_btn.addEventListener(MouseEvent.MOUSE_UP, onGetLessPointsClick);
			mcLobby.createRoom_btn.addEventListener(MouseEvent.MOUSE_UP, onCreateRoomClick);
			mcLobby.refresh_btn.addEventListener(MouseEvent.MOUSE_UP, onRefresh_btn);
			//mcLobby.learnmore_btn.addEventListener(MouseEvent.MOUSE_UP, onLearnMoreClick);
			lobbyGrid.addEventListener(DataGridEvent.HEADER_RELEASE, onLobbyGridHeaderRelease);
			lobbyGrid.addEventListener(Event.CHANGE, onRoomSelected);
			lobbyGrid.addEventListener(ListEvent.ITEM_ROLL_OVER, onRoomRollOver);
			lobbyGrid.addEventListener(ListEvent.ITEM_ROLL_OUT, onRoomRollOut);
			lobbyGrid.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, onJoinRoomDblClk);
			
			/*friendInfo.friendsOff.addEventListener(MouseEvent.MOUSE_UP, onFriendsClick);
			friendInfo.networksOff.addEventListener(MouseEvent.MOUSE_UP, onNetworksClick);
			friendInfo.refresh.addEventListener(MouseEvent.MOUSE_UP, onRefreshClick);
			friendInfo.joinUser.addEventListener(MouseEvent.MOUSE_UP, onJoinUserClick);
			friendInfo.budList.addEventListener(Event.CHANGE, onFriendSelect);
			friendInfo.networkList.addEventListener(Event.CHANGE, onFriendSelect);*/
			friendInfo.joinUser.addEventListener(MouseEvent.MOUSE_UP, onJoinUserClick);
			btnFindSeat.addEventListener(MouseEvent.MOUSE_UP, onBtnFindSeat);
			//userInfo.changeCasino_btn.visible = true;
			//userInfo.changeCasino_btn.addEventListener(MouseEvent.MOUSE_UP, onChangeCasinoClick);
			userInfo.changeCasino1_btn.addEventListener(MouseEvent.MOUSE_UP, onChangeCasinoClick1);
			userInfo.changeCasino2_btn.addEventListener(MouseEvent.MOUSE_UP, onChangeCasinoClick2);
			userInfo.changeCasino3_btn.addEventListener(MouseEvent.MOUSE_UP, onChangeCasinoClick3);
			userInfo.changeCasino4_btn.addEventListener(MouseEvent.MOUSE_UP, onChangeCasinoClick4);
			userInfo.changeCasino5_btn.addEventListener(MouseEvent.MOUSE_UP, onChangeCasinoClick5);
			mainmenu_btn.addEventListener(MouseEvent.MOUSE_UP, onMainMenuClick);
			event_btn.addEventListener(MouseEvent.MOUSE_UP, onEventClick);
			getHelp_btn.addEventListener(MouseEvent.MOUSE_UP, onGetHelpClick);
			casinoInfo.buConnectServ.addEventListener(MouseEvent.MOUSE_UP, onBuConnectServClick);
			hideFullTables.addEventListener(Event.CHANGE, toggleHideFullTables);
			hideRunningTables.addEventListener(Event.CHANGE, toggleHideRunningTables);
			hideEmptyTables.addEventListener(Event.CHANGE, toggleHidEmptyTables);
			
			logochat_btn.addEventListener(MouseEvent.MOUSE_UP, onChatClick);
			
			casinoInfo.casinoList.addEventListener(Event.CHANGE, pickNewCasino);
		}
		private function onRoomRollOver(p__1:fl.events.ListEvent):void {
			var l__2:int;
			var l__3:fl.controls.listClasses.CellRenderer;
			if ((p__1.index) > -1) {
				l__2 = 0;
				while (l__2 < lobbyGrid.getColumnCount()) {
					l__3 = (lobbyGrid.getCellRendererAt(p__1.index, l__2) as CellRenderer);
					if (l__3 != null) {
						l__3.setStyle("textFormat", StyleManager.getStyle("highlightTextFormat"));
					}
					l__2++;
				}
			}
		}
		private function onRoomRollOut(p__1:fl.events.ListEvent):void {
			var l__2:int;
			var l__3:fl.controls.listClasses.CellRenderer;
			if ((p__1.index) > -1) {
				l__2 = 0;
				while (l__2 < lobbyGrid.getColumnCount()) {
					l__3 = (lobbyGrid.getCellRendererAt(p__1.index, l__2) as CellRenderer);
					if (l__3 != null) {
						l__3.setStyle("textFormat", StyleManager.getStyle("defaultTextFormat"));
					}
					l__2++;
				}
			}
		}
		private function toggleHideFullTables(p__1:flash.events.Event):void {
			dispatchEvent(new LVEvent(LVEvent.FULL_TABLES));
		}
		private function toggleHideRunningTables(p__1:flash.events.Event):void {
			dispatchEvent(new LVEvent(LVEvent.RUNNING_TABLES));
		}
		private function toggleHidEmptyTables(p__1:flash.events.Event):void {
			dispatchEvent(new LVEvent(LVEvent.EMPTY_TABLES));
		}
		private function onLobbyGridHeaderRelease(p__1:fl.events.DataGridEvent):void {
			p__1.preventDefault();
			var l__2:String = ((((p__1.target) as DataGrid)).getColumnAt(p__1.columnIndex) as DataGridColumn).dataField;
			var l__3:Boolean = (plModel.currentSortDataField == l__2) ? (!plModel.currentSortDescending) : (((l__2 == "No") || (l__2 == "Room")) ? false : true);
			dispatchEvent(new SortTablesEvent(SortTablesEvent.SORT_TABLES, l__2, l__3));
		}
		private function onRoomSelected(p__1:flash.events.Event):void {
			var l__2:fl.controls.DataGrid = DataGrid(p__1.target);
			dispatchEvent(new TableSelectedEvent(LVEvent.TABLE_SELECTED, l__2.selectedItem.ID));
			clickedRoomId = l__2.selectedItem.ID;
			showTableInfo(clickedRoomId);
		}
		private function onJoinRoomDblClk(p__1:fl.events.ListEvent):void {
			dispatchEvent(new LVEvent(LVEvent.JOIN_ROOM));
		}
		private function onJoinRoom(p__1:*):void {
			dispatchEvent(new LVEvent(LVEvent.JOIN_ROOM));
		}
		public function setLobbyButtons(p__1:Boolean) {
			
			greenBackground.visible = true;
			userInfo.visible = true;
			
			btnFindSeat.visible = false;
			//btnFindSeat.visible = true;
			getHelp_btn.visible = true;
			mcLobby.visible = true;
			dfSeatedPlayers.visible = false;
			lobbyGrid.visible = true;
			hideEmptyTables.visible = true;
			mainmenu_btn.visible = true;
			event_btn.visible = true;
			
			casinoInfo.visible = false;
			//logo.visible = true;
			//logoVip.visible = false;
			
			lobbyGrid.visible = true;
			lobbyGrid.y = 225;
			lobbyGrid.height = 502;
			lobbyGrid.width = 1097;
			
			
			

			if (dfBuzzBox != null) {
				dfBuzzBox.visible = true;
				iphoneAd.visible = false;
			}
			
			/*if (plModel.bShowGetPoints) {
				mcLobby.getMorePoints_btn.visible = true;
				mcLobby.getLessPoints_btn.visible = true;
			} else {
				mcLobby.getMorePoints_btn.visible = false;
				mcLobby.getLessPoints_btn.visible = false;
			}*/
			mcLobby.getMorePoints_btn.visible = false;
				mcLobby.getLessPoints_btn.visible = false;
			if (p__1) {
				dfSeatedPlayers.visible = false;
			}
			if (plModel.sLobbyMode == "challenge") {
				//mcLobby.mcTournTabOn.visible = false;
				mcLobby.mcPrivateTabOn.visible = false;
				mcLobby.mcFastTabOn.visible = false;
				mcLobby.mcPointsTabOn.visible = true;
				mcLobby.mcVipTabOn.visible = false;
				//mcLobby.mcTournTabOff.enabled = true;
				mcLobby.mcPrivateTabOff.enabled = true;
				mcLobby.mcPointsTabOff.enabled = false;
				mcLobby.mcPointsTabOff.visible = false;
				mcLobby.mcFastTabOff.enabled = true;
				mcLobby.mcFastTabOff.visible = true;
				mcLobby.mcVipTabOff.enabled = true;
				//mcLobby.mcVipTabOn.enabled = false;
				mcLobby.createRoom_btn.visible = false;
				mcLobby.createRoom_btn.enabled = false;
				mcLobby.refresh_btn.visible = true;
				mcLobby.joinRoom_btn.visible = true;
				hideFullTables.visible = true;
				hideRunningTables.visible = false;
			} else if (plModel.sLobbyMode == "private") {
				//mcLobby.mcTournTabOn.visible = false;
				mcLobby.mcPrivateTabOn.visible = true;
				mcLobby.mcFastTabOn.visible = false;
				mcLobby.mcPointsTabOn.visible = false;
				mcLobby.mcVipTabOn.visible = false;
				//mcLobby.mcTournTabOff.enabled = true;
				mcLobby.mcPrivateTabOff.enabled = false;
				mcLobby.mcFastTabOff.enabled = true;
				mcLobby.mcPointsTabOff.enabled = true;
				mcLobby.mcVipTabOff.enabled = true;
				mcLobby.createRoom_btn.visible = true;
				mcLobby.createRoom_btn.enabled = true;
				mcLobby.refresh_btn.visible = true;
				mcLobby.joinRoom_btn.visible = true;
				hideFullTables.visible = false;
				hideRunningTables.visible = false;
				hideEmptyTables.visible = false;
			}else if (plModel.sLobbyMode == "vip") {
				//mcLobby.mcTournTabOn.visible = false;
				mcLobby.mcPrivateTabOn.visible = false;
				mcLobby.mcPointsTabOn.visible = false;
				mcLobby.mcFastTabOn.visible = false;
				mcLobby.mcVipTabOn.visible = true;
				mcLobby.createRoom_btn.visible = false;
				mcLobby.createRoom_btn.enabled = false;
				//mcLobby.mcTournTabOff.enabled = true;
				
				mcLobby.mcPrivateTabOff.enabled = true;
				mcLobby.mcPointsTabOff.enabled = true;
				mcLobby.mcVipTabOff.enabled = false;
				mcLobby.mcFastTabOff.enabled = true;
				//mcLobby.createRoom_btn.visible = true;
				//mcLobby.createRoom_btn.enabled = true;
				mcLobby.refresh_btn.visible = true;
				mcLobby.joinRoom_btn.visible = true;
				hideFullTables.visible = false;
				hideRunningTables.visible = false;
				hideEmptyTables.visible = false;
			}else if (plModel.sLobbyMode == "fast") {
				//mcLobby.mcTournTabOn.visible = false;
				mcLobby.mcPrivateTabOn.visible = false;
				mcLobby.mcPointsTabOn.visible = false;
				mcLobby.mcFastTabOn.visible = true;
				mcLobby.mcVipTabOn.visible = false;
				mcLobby.createRoom_btn.visible = false;
				mcLobby.createRoom_btn.enabled = false;
				//mcLobby.mcTournTabOff.enabled = true;
				
				mcLobby.mcPrivateTabOff.enabled = true;
				mcLobby.mcPointsTabOff.enabled = true;
				mcLobby.mcPointsTabOff.visible = true;
				mcLobby.mcVipTabOff.enabled = true;
				mcLobby.mcFastTabOff.enabled = false;
				mcLobby.mcFastTabOff.visible = false;
				//mcLobby.createRoom_btn.visible = true;
				//mcLobby.createRoom_btn.enabled = true;
				mcLobby.refresh_btn.visible = true;
				mcLobby.joinRoom_btn.visible = true;
				hideFullTables.visible = true;
				hideRunningTables.visible = false;
				hideEmptyTables.visible = true;
			}
			/*else if (plModel.sLobbyMode == "tournament"){
			mcLobby.mcTournTabOn.visible = true;
			mcLobby.mcPrivateTabOn.visible = false;
			mcLobby.mcPointsTabOn.visible = false;
			mcLobby.mcVipTabOn.visible = false;
			mcLobby.mcTournTabOff.enabled = false;
			mcLobby.mcPrivateTabOff.enabled = true;
			mcLobby.mcPointsTabOff.enabled = true;
			mcLobby.mcVipTabOff.enabled = true;
			mcLobby.createRoom_btn.visible = false;
			mcLobby.createRoom_btn.enabled = false;
			mcLobby.refresh_btn.visible = true;
			mcLobby.joinRoom_btn.visible = true;
			hideFullTables.visible = false;
			hideRunningTables.visible = true;
			lobbyGrid.y = 156;
			lobbyGrid.height = 182;
			mcLobby.shootout_btn.visible = true;
			mcLobby.sitngo_btn.visible = true;
			setSubTab(mcLobby.shootout_btn, false);
			setSubTab(mcLobby.sitngo_btn, true);
			} else if (plModel.sLobbyMode == "shootout"){
			mcLobby.mcTournTabOn.visible = true;
			mcLobby.mcPrivateTabOn.visible = false;
			mcLobby.mcPointsTabOn.visible = false;
			mcLobby.mcVipTabOn.visible = false;
			mcLobby.mcTournTabOff.enabled = false;
			mcLobby.mcPrivateTabOff.enabled = true;
			mcLobby.mcPointsTabOff.enabled = true;
			mcLobby.mcVipTabOff.enabled = true;
			mcLobby.createRoom_btn.visible = false;
			mcLobby.createRoom_btn.enabled = false;
			mcLobby.refresh_btn.visible = false;
			mcLobby.joinRoom_btn.visible = false;
			hideFullTables.visible = false;
			hideRunningTables.visible = false;
			hideEmptyTables.visible = false;
			lobbyGrid.visible = false;
			mcLobby.shootout_btn.visible = true;
			mcLobby.sitngo_btn.visible = true;
			setSubTab(mcLobby.shootout_btn, true);
			setSubTab(mcLobby.sitngo_btn, false);
			} else if (plModel.sLobbyMode == "vip"){
			//logoVip.visible = false;
			mcLobby.mcPointsTabOn.visible = false;
			mcLobby.mcTournTabOn.visible = false;
			mcLobby.mcVipTabOn.visible = true;
			mcLobby.mcPrivateTabOn.visible = false;
			mcLobby.mcTournTabOff.enabled = true;
			mcLobby.mcPrivateTabOff.enabled = true;
			mcLobby.mcPointsTabOff.enabled = true;
			mcLobby.mcVipTabOff.enabled = false;
			mcLobby.refresh_btn.visible = true;
			mcLobby.joinRoom_btn.visible = true;
			mcLobby.createRoom_btn.visible = false;
			lobbyGrid.enabled = true;
			//logo.visible = false;
			//logoVip.visible = true;
			hideFullTables.visible = true;
			hideRunningTables.visible = false;
			}
			*/
			if(plModel.bVip == false) {
				mcLobby.mcVipTabOn.visible = false;
				mcLobby.mcVipTabOff.visible = false;
			}
		}
		public function addCasinoList(p__1:Object):void {
			var l__2:int = 0;
			var l__3 = 0;
			while(l__2 < p__1.id.length){
				l__3 = l__2+1;
				userInfo["s_txt"+l__3].text = p__1.name[l__2]+" ("+p__1.onuser[l__2]+")";
				userInfo["changeCasino"+l__3+"_btn"].visible = true;
				userInfo["s_txt"+l__3].visible = true;
				l__2++;
			}
			
		}
		private function onMcTournTabOff(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.onTourneyTabClick));
		}
		private function onMcPrivateTabOff(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.onPrivateTabClick));
		}
		private function onMcFastTabOff(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.onFastTabClick));
		}
		private function onMcPointsTabOff(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.onPointsTabClick));
		}
		public function setLobbyDisplay():void {
			switch (plModel.sLobbyMode) {
				case "vip" :
					{
						setVIP();
						break;

					};
				case "challenge" :
					{
						setPointsGames();
						break;

					};
				case "private" :
					{
						setPrivateGames();
						break;

					};
				case "fast" :
					{	
						setPointsGames();
						break;

					};
				case "tournament" :
					{
						setTourneyGames();
						break;

					};
				case "shootout" :
					{
						setShootoutGames();
						break;

				}
			}
		};
		public function setVIP():void {
			resetSelection();
			//userInfo.server.text = ("Casino: " + plModel.serverName);
			loadPointGames();
			setLobbyButtons(false);
			dfSeatedPlayers.visible = false;
		}
		public function setPointsGames():void {
			resetSelection();
			//userInfo.server.text = ("Casino: " + plModel.serverName);
			loadPointGames();
			setLobbyButtons(false);
			dfSeatedPlayers.visible = false;
		}
		public function setPrivateGames():void {
			resetSelection();
			//userInfo.server.text = ("Casino: " + plModel.serverName);
			loadPrivate();
			setLobbyButtons(false);
			dfSeatedPlayers.visible = false;
		}
		public function setTourneyGames():void {

			resetSelection();
			//userInfo.server.text = ("Casino: " + plModel.serverName);
			loadTourney();
			setLobbyButtons(false);
			dfSeatedPlayers.visible = false;
		}
		public function setShootoutGames():void {
			resetSelection();
			//userInfo.server.text = ("Casino: " + plModel.serverName);
			setLobbyButtons(false);
			dfSeatedPlayers.visible = false;
		}
		public function resetSelection():void {
			plModel.nSelectedTable = -1;
			lobbyGrid.selectedIndex = -1;
		}
		private function onMcVipTabOff(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.onVipTabClick));
		}
		private function onRefresh_btn(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.REFRESH_LIST));
		}
		public function showTableInfo(p__1:int):void {
			var l__3:flash.text.TextFormat;
			var l__4:flash.text.TextField;
			dfSeatedPlayers.visible = false;
			seatedPlayersGridData = new DataProvider();
			var l__2:com.script.poker.lobby.RoomItem = RoomItem(plModel.aRoomsById[p__1]);
			if (dfSeatedPlayers.getChildByName("tableName") != null) {
				l__3 = new TextFormat();
				l__3.font = "Arial";
				l__3.color = 16777215;
				l__3.size = 11;
				l__4 = TextField(dfSeatedPlayers.getChildByName("tableName"));
				l__4.htmlText = (langs.l_table+" : " + l__2.roomName);
				l__4.setTextFormat(l__3);
			}
		}
		private function onSeatedPlayersClick(p__1:flash.events.MouseEvent):void {
			plModel.seatedPlayersGridData = new DataProvider();
			if (plModel.seatedPlayersGridData.length < 1) {
			} else {
				onSeatedPlayersClick(new Event());
			}
		}
		public function updateSeatedPlayersDataGrid():void {
			tlSeatedPlayers.dataProvider = new DataProvider();
			tlSeatedPlayers.dataProvider = plModel.seatedPlayersGridData;
		}
		private function initFriendInfo():void {
			plModel.BshowFriendList = true;
			//friendInfo.networkList.headerHeight = 0;
			//friendInfo.networkList.columns = ["friend"];
			friendInfo.networksOn.visible = false;
			//if (plModel.sn_id != 1){
			friendInfo.networksOff.visible = false;
			friendInfo.friendsOn.visible = true;
			//}
			
			friendInfo.budList.dataProvider = plModel.friendGridData;
			friendInfo.budList.setStyle("cellRenderer", MyFriendsImageCell);
			friendInfo.budList.setStyle("contentPadding", 0);
			friendInfo.budList.setStyle("skin", CustomCellBg);
			friendInfo.budList.columnWidth = 72;
			friendInfo.budList.rowHeight = 97;
			friendInfo.budList.columnCount = 4;
			friendInfo.budList.width = 240;
			friendInfo.budList.direction = ScrollBarDirection.VERTICAL;

		}
		private function onFriendsClick(p__1:flash.events.MouseEvent):void {
			plModel.BshowFriendList = true;
			friendInfo.networksOn.visible = false;
			friendInfo.friendsOn.visible = true;
			if (plModel.friendGridData != null) {
				//friendInfo.networkList.removeAllColumns();
				//friendInfo.networkList.visible = false;
				//friendInfo.networkList.removeAllColumns();
				friendInfo.budList.visible = true;
				friendInfo.budList.dataProvider = plModel.friendGridData;
			}
			friendInfo.refresh.visible = !plModel.useZoomForFriends;
		}
		private function onNetworksClick(p__1:flash.events.MouseEvent):void {
			plModel.BshowFriendList = false;
			friendInfo.networksOn.visible = true;
			friendInfo.friendsOn.visible = false;
			friendInfo.refresh.visible = !plModel.useZoomForNetwork;
			if (plModel.useZoomForNetwork) {
				if (plModel.networkUserGridData != null) {
					friendInfo.budList.visible = false;
					//friendInfo.networkList.visible = true;
					//friendInfo.networkList.removeAllColumns();
					//friendInfo.networkList.dataProvider = plModel.networkUserGridData;
				}
			} else {
				dispatchEvent(new LVEvent(LVEvent.REFRESH_NETWORK));
			}
		}
		private function onRefreshClick(p__1:flash.events.MouseEvent):void {
			if (plModel.BshowFriendList == false) {
				dispatchEvent(new LVEvent(LVEvent.REFRESH_NETWORK));
			} else {
				dispatchEvent(new LVEvent(LVEvent.REFRESH_FRIEND));
			}
		}
		private function onJoinUserClick(p__1:flash.events.MouseEvent):void {
			if (plModel.BshowFriendList == true) {
				if (friendInfo.budList.selectedIndex > -1) {
					dispatchEvent(new LVEvent(LVEvent.JOIN_USER));
				} else {
				}
			} else if (friendInfo.networkList.selectedIndex > -1) {
				dispatchEvent(new LVEvent(LVEvent.JOIN_USER));
			} else {
			}
		}
		public function updateNetworkDataGrid():void {
			friendInfo.budList.removeAllColumns();
			friendInfo.budList.dataProvider = plModel.networkUserGridData;
		}
		public function onCreateRoomClick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.CREATE_TABLE));
		}
		public function onChangeCasinoClick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.CHANGE_CASINO));
		}
		public function onChangeCasinoClick1(p__1:flash.events.MouseEvent):void {
			//dispatchEvent(new LVEvent(LVEvent.CHANGE_CASINO));
			var l__1 = userInfo.s_txt1.text;
			var l__2 = l__1.split("(");
			var l__3 = l__2[1].substr(0,-1);
			if (l__3 == "Full"){
				return;
			}
			dispatchEvent(new CasinoSelectedEvent(LVEvent.CASINO_SELECTED, 1, userInfo.s_txt1.text, 1));
		}
		public function onChangeCasinoClick2(p__1:flash.events.MouseEvent):void {
			//dispatchEvent(new LVEvent(LVEvent.CHANGE_CASINO));
			var l__1 = userInfo.s_txt2.text;
			var l__2 = l__1.split("(");
			var l__3 = l__2[1].substr(0,-1);
			if (l__3 == "Full"){
				return;
			}
			dispatchEvent(new CasinoSelectedEvent(LVEvent.CASINO_SELECTED, 2, userInfo.s_txt2.text, 2));
		}
		public function onChangeCasinoClick3(p__1:flash.events.MouseEvent):void {
			//dispatchEvent(new LVEvent(LVEvent.CHANGE_CASINO));
			var l__1 = userInfo.s_txt3.text;
			var l__2 = l__1.split("(");
			var l__3 = l__2[1].substr(0,-1);
			if (l__3 == "Full"){
				return;
			}
			dispatchEvent(new CasinoSelectedEvent(LVEvent.CASINO_SELECTED, 3, userInfo.s_txt3.text, 3));
		}
		public function onChangeCasinoClick4(p__1:flash.events.MouseEvent):void {
			//dispatchEvent(new LVEvent(LVEvent.CHANGE_CASINO));
			var l__1 = userInfo.s_txt4.text;
			var l__2 = l__1.split("(");
			var l__3 = l__2[1].substr(0,-1);
			if (l__3 == "Full"){
				return;
			}
			dispatchEvent(new CasinoSelectedEvent(LVEvent.CASINO_SELECTED, 4, userInfo.s_txt4.text, 4));
		}
		public function onChangeCasinoClick5(p__1:flash.events.MouseEvent):void {
			//dispatchEvent(new LVEvent(LVEvent.CHANGE_CASINO));
			var l__1 = userInfo.s_txt5.text;
			var l__2 = l__1.split("(");
			var l__3 = l__2[1].substr(0,-1);
			if (l__3 == "Full"){
				return;
			}
			dispatchEvent(new CasinoSelectedEvent(LVEvent.CASINO_SELECTED, 5, userInfo.s_txt4.text, 5));
		}
		public function onBtnFindSeat(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.FIND_SEAT));
		}
		public function onGetHelpClick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.onHelpButtonClick));
			//var l__2:flash.net.URLRequest = new URLRequest("http://facebook.poker.script.com/poker/help.php?from_game=0&appskip=1");
			//navigateToURL(l__2, "_blank");
		}
		public function onMainMenuClick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.onMainMenuClick));
			//var l__2:flash.net.URLRequest = new URLRequest("/menu.php?game=txh");
			//navigateToURL(l__2,"_self");
		}
		public function onEventClick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.onEventClick));
			//var l__2:flash.net.URLRequest = new URLRequest("/menu.php?game=txh");
			//navigateToURL(l__2,"_self");
		}
		public function onChatClick(p__1:flash.events.MouseEvent):void {
			if (plModel.chatPop > 0) {
				dispatchEvent(new LVEvent(LVEvent.onChatClick));
			}			
		}
		public function hideJoinButton(p__1:Boolean):void {
			if (p__1) {
				friendInfo.joinUser.alpha = 0.5;
				friendInfo.joinUser.mouseEnabled = false;
				friendInfo.joinUser.enabled = false;
			} else {
				friendInfo.joinUser.alpha = 1;
				friendInfo.joinUser.mouseEnabled = true;
				friendInfo.joinUser.enabled = true;
			}
		}
		public function hideAll():void {
			userInfo.visible = false;
			//btnFindSeat.visible = false;
			//getHelp_btn.visible = false;
			mcLobby.visible = false;
			//dfSeatedPlayers.visible = false;
			//friendInfo.visible = false;
			lobbyGrid.visible = false;
			hideFullTables.visible = false;
			hideRunningTables.visible = false;
			hideEmptyTables.visible = false;
			mainmenu_btn.visible = false;
			event_btn.visible = false;
			//iphoneAd.visible = false;
			if (dfBuzzBox != null) {
				dfBuzzBox.visible = false;
			}
		}
		public function showCasinoList():void {
			casinoInfo.visible = true;
		}
		public function onBuConnectServClick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.CONNECT_TO_NEW_CASINO));
		}
		public function updateCasinoList():void {
			casinoInfo.casinoList.dataProvider = plModel.casinoListData;
		}
		public function pickNewCasino(p__1:flash.events.Event):void {
			dispatchEvent(new CasinoSelectedEvent(LVEvent.CASINO_SELECTED, p__1.target.selectedItem.data, p__1.target.selectedItem.label, p__1.target.selectedItem.id));
		}
		public function loadNewServerLobby():void {
			if (plModel.sLobbyMode == "tournament") {
				loadTourney();
			} else {
				loadPointGames();
			}
			setLobbyButtons(true);
			dispatchEvent(new LVEvent(LVEvent.REFRESH_LOBBY_ROOMS));
		}
		public function onFriendSelect(p__1:flash.events.Event):void {
			dispatchEvent(new LVEvent(LVEvent.ON_SELECT_FRIEND));
		}
		public function onIphoneAdCLick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.ON_IPHONE_AD_CLICK));
		}
		public function onGetMorePointsClick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.GET_MORE_CHIPS));
		}
		public function onGetLessPointsClick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.GET_LESS_CHIPS));
		}
		public function onShootoutClick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.SHOOTOUT_CLICK));
		}
		public function onSitNGoClick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.SITNGO_CLICK));
		}
		public function setSubTab(p__1:flash.display.MovieClip, p__2:Boolean):void {
			var l__3:flash.display.MovieClip = p__1;
			var l__4:flash.text.TextFormat = new TextFormat();
			if (p__2) {
				l__3.bg.gotoAndStop(1);
				l__4.color = 16777215;
				l__3.theText.setTextFormat(l__4);
			} else {
				l__3.bg.gotoAndStop(2);
				l__4.color = 0;
				l__3.theText.setTextFormat(l__4);
			}

		}
		public function setDefaultSubtab(p__1:String):void {
			if ((p__1).toLowerCase() == "shootout") {
				setSubTab(mcLobby.shootout_btn, true);
				setSubTab(mcLobby.sitngo_btn, false);
			}
			if ((p__1).toLowerCase() == "sitngo") {
				setSubTab(mcLobby.shootout_btn, false);
				setSubTab(mcLobby.sitngo_btn, true);
			}
		}
		public function onBuyInClick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.BUYIN_CLICK));
		}
		public function onHowToPlayClick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.SHOOTOUT_HOWTOPLAY_CLICK));
		}
		public function onLearnMoreClick(p__1:flash.events.MouseEvent):void {
			dispatchEvent(new LVEvent(LVEvent.SHOOTOUT_LEARNMORE_CLICK));
		}
		public function initBuzzAd(p__1:String):void {
			iphoneAd.visible = false;
			dfBuzzBox = new DrawFrame(210, 120, true, false);
			dfBuzzBox.renderTitle("");
			dfBuzzBox.x = 274;
			dfBuzzBox.y = 396;
			addChild(dfBuzzBox);
			buzzAd = new BuzzAd(p__1);
			dfBuzzBox.addChild(buzzAd);
		}
		public function updateShootoutConfig(p__1:com.script.poker.shootout.ShootoutConfig, p__2:com.script.poker.shootout.ShootoutUser):void {
			mcLobby.shootout_mc.visible = true;
			mcLobby.buyin_btn.visible = true;
			mcLobby.howtoplay_btn.visible = true;
			mcLobby.learnmore_btn.visible = true;
			var l__3:Number = p__1.aPayouts[(p__1.nRounds) - 1][0];
			mcLobby.shootout_mc.tfWinChips.text = (("WIN " + StringUtility.StringToMoney(l__3)) + " CHIPS");
			mcLobby.buyin_btn.tfButton.text = ("Play Round " + p__2.nRound);
			mcLobby.shootout_mc.mcRound2.mcStarLock.visible = true;
			mcLobby.shootout_mc.mcRound3.mcStarLock.visible = true;
			switch (p__2.nRound) {
				case 1 :
					{
						mcLobby.shootout_mc.mcRound1.tfPlace.text = "";
						mcLobby.shootout_mc.mcRound1.tfBuyIn.text = (("BUY IN FOR\n" + p__1.nBuyin) + "\nCHIPS");
						mcLobby.shootout_mc.mcRound1.gotoAndStop(2);
						mcLobby.shootout_mc.mcRound2.tfPlace.text = "";
						mcLobby.shootout_mc.mcRound2.tfEligible.text = "";
						mcLobby.shootout_mc.mcRound2.gotoAndStop(1);
						mcLobby.shootout_mc.mcRound2.mcStarLock.visible = true;
						mcLobby.shootout_mc.mcRound3.tfEligible.text = "";
						mcLobby.shootout_mc.mcRound3.gotoAndStop(1);
						mcLobby.shootout_mc.mcRound3.mcStarLock.visible = true;
						break;

					};
				case 2 :
					{

						mcLobby.shootout_mc.mcRound1.tfPlace.text = "1ST\nPLACE";
						mcLobby.shootout_mc.mcRound1.tfBuyIn.text = "";
						mcLobby.shootout_mc.mcRound1.gotoAndStop(1);
						mcLobby.shootout_mc.mcRound2.tfPlace.text = "";
						mcLobby.shootout_mc.mcRound2.tfEligible.text = "YOU ARE\nELIGIBLE\nTO ENTER";
						mcLobby.shootout_mc.mcRound2.gotoAndStop(2);
						mcLobby.shootout_mc.mcRound2.mcStarLock.visible = false;
						mcLobby.shootout_mc.mcRound3.tfEligible.text = "";
						mcLobby.shootout_mc.mcRound3.gotoAndStop(1);
						mcLobby.shootout_mc.mcRound3.mcStarLock.visible = true;
						break;

					};
				case 3 :
					{
						mcLobby.shootout_mc.mcRound1.tfPlace.text = "1ST\nPLACE";
						mcLobby.shootout_mc.mcRound1.tfBuyIn.text = "";
						mcLobby.shootout_mc.mcRound1.gotoAndStop(1);
						mcLobby.shootout_mc.mcRound2.tfPlace.text = "1ST\nPLACE";
						mcLobby.shootout_mc.mcRound2.tfEligible.text = "";
						mcLobby.shootout_mc.mcRound2.gotoAndStop(1);
						mcLobby.shootout_mc.mcRound2.mcStarLock.visible = false;
						mcLobby.shootout_mc.mcRound3.tfEligible.text = "YOU ARE\nELIGIBLE\nTO ENTER";
						mcLobby.shootout_mc.mcRound3.gotoAndStop(2);
						mcLobby.shootout_mc.mcRound3.mcStarLock.visible = false;
						break;

				}
			}
		};
		function __setProp_lobbyGrid_Scene1_LobbyMain_0() {
			try {
				lobbyGrid["componentInspectorSetting"] = true;
			} catch (e:Error) {
			}
			lobbyGrid.allowMultipleSelection = false;
			lobbyGrid.editable = false;
			lobbyGrid.headerHeight = 36;
			lobbyGrid.horizontalLineScrollSize = 4;
			lobbyGrid.horizontalPageScrollSize = 0;
			lobbyGrid.horizontalScrollPolicy = "off";
			lobbyGrid.resizableColumns = false;
			lobbyGrid.rowHeight = 32;
			lobbyGrid.showHeaders = true;
			lobbyGrid.sortableColumns = true;
			lobbyGrid.verticalLineScrollSize = 4;
			lobbyGrid.verticalPageScrollSize = 0;
			lobbyGrid.verticalScrollPolicy = "on";
			try {
				lobbyGrid["componentInspectorSetting"] = false;
			} catch (e:Error) {
			}
		}
		function __setProp_hideFullTables_Scene1_checkboxes_0() {
			try {
				hideFullTables["componentInspectorSetting"] = true;
			} catch (e:Error) {
			}
			hideFullTables.enabled = true;
			hideFullTables.label = langs.l_hidefulltable;;
			hideFullTables.labelPlacement = "right";
			hideFullTables.selected = false;
			hideFullTables.visible = true;
			
			var myTf:TextFormat = new TextFormat(); 
			myTf.color = 16777215;
			hideFullTables.setSize(220, 22); 
			myTf.size = 17; 
			hideFullTables.setStyle("textFormat", myTf);
			
			try {
				hideFullTables["componentInspectorSetting"] = false;
			} catch (e:Error) {
			}
		}
		function __setProp_hideEmptyTables_Scene1_checkboxes_0() {
			try {
				hideEmptyTables["componentInspectorSetting"] = true;
			} catch (e:Error) {
			}
			hideEmptyTables.enabled = true;
			hideEmptyTables.label = langs.l_hideemptytable;
			hideEmptyTables.labelPlacement = "right";
			hideEmptyTables.selected = true;
			hideEmptyTables.visible = true;
			
			var myTf:TextFormat = new TextFormat(); 
			myTf.color = 16777215;
			hideEmptyTables.setSize(220, 22); 
			myTf.size = 17; 
			hideEmptyTables.setStyle("textFormat", myTf);
			
			try {
				hideEmptyTables["componentInspectorSetting"] = false;
			} catch (e:Error) {
			}
		}
		function __setProp_hideRunningTables_Scene1_checkboxesrunning_0() {
			try {
				hideRunningTables["componentInspectorSetting"] = true;
			} catch (e:Error) {
			}
			hideRunningTables.enabled = true;
			hideRunningTables.label = langs.l_hideruntable;
			hideRunningTables.labelPlacement = "right";
			hideRunningTables.selected = true;
			hideRunningTables.visible = true;
			
			var myTf:TextFormat = new TextFormat(); 
			hideRunningTables.setSize(180, 22); 
			myTf.size = 15; 
			myTf.color = 16777215;
			hideRunningTables.setStyle("textFormat", myTf);
			
			try {
				hideRunningTables["componentInspectorSetting"] = false;
			} catch (e:Error) {
			}
		}
	}
}