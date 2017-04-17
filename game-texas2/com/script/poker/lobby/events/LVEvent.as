// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby.events
{
	import flash.events.*;
	public class LVEvent extends flash.events.Event
	{
		public static const FIND_SEAT:String = "findSeat";
		public static const RECORD_STAT:String = "RECORD_STAT";
		public static const RUNNING_TABLES:String = "runningTables";
		public static const ROOMINFO:String = "roomInfo";
		public static const REFRESH_NETWORK:String = "refreshNetwork";
		public static const REFRESH_LOBBY_ROOMS:String = "refreshLobbyRooms";
		public static const TABLE_SELECTED:String = "tableSelected";
		public static const FULL_TABLES:String = "fullTables";
		public static const lobbyView:String = "lobbyView";
		public static const FRIEND_SELECTED:String = "friendSelected";
		public static const SHOOTOUT_HOWTOPLAY_CLICK:String = "SHOOTOUT_HOWTOPLAY_CLICK";
		public static const SITNGO_CLICK:String = "SITNGO_CLICK";
		public static const CONNECT_TO_NEW_CASINO:String = "connectToNewCasino";
		public static const CASINO_SELECTED:String = "casinoSelected";
		public static const CREATE_TABLE:String = "createTable";
		public static const TRANS_CHIPS:String = "transferChips";
		public static const onHelpButtonClick:String = "onHelpButtonClick";
		public static const onMainMenuClick:String = "onMainMenuClick";
		public static const onEventClick:String = "onEventClick";
		public static const onChatClick:String = "onChatClick";
		public static const REFRESH_FRIEND:String = "refreshFriend";
		public static const REFRESH_LOBBY:String = "refreshLobby";
		public static const BUYIN_CLICK:String = "BUYIN_CLICK";
		public static const onPointsTabClick:String = "onPointsTabClick";
		public static const EMPTY_TABLES:String = "emptyTables";
		public static const SHOOTOUT_LEARNMORE_CLICK:String = "SHOOTOUT_LEARNMORE_CLICK";
		public static const REFRESH_LIST:String = "refreshList";
		public static const onPrivateTabClick:String = "onPrivateTabClick";
		public static const onFastTabClick:String = "onFastTabClick";
		public static const BUZZ_AD_CLICK:String = "BUZZ_AD_CLICK";
		public static const JOIN_USER:String = "joinUser";
		public static const ON_IPHONE_AD_CLICK:String = "ON_IPHONE_AD_CLICK";
		public static const JOIN_ROOM:String = "joinRoom";
		public static const onVipTabClick:String = "onVipTabClick";
		public static const onViewInit:String = "onViewInit";
		public static const GET_MORE_CHIPS:String = "GET_MORE_CHIPS";
		public static const GET_LESS_CHIPS:String = "GET_LESS_CHIPS";
		public static const ON_SELECT_FRIEND:String = "onSelectFriend";
		public static const PICK_NEW_CASINO:String = "pickNewCasino";
		public static const CHANGE_CASINO:String = "changeCasino";
		public static const SHOOTOUT_CLICK:String = "SHOOTOUT_CLICK";
		public static const onTourneyTabClick:String = "onTourneyTabClick";
		public function LVEvent(p__1:String)
		{
			trace (" msk LV EVENT "+p__1)
			super(p__1);
		}
		override public function clone():flash.events.Event
		{
			return(new LVEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("ProtocolEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}