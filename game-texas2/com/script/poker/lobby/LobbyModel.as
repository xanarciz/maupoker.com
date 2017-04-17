// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby
{
	import fl.data.DataProvider;
	import com.script.poker.UserPresence;
	import com.script.poker.popups.modules.events.DSGEvent;
	import com.script.format.*;
	public class LobbyModel
	{
		public var sn_id:int;
		public var useZoomForFriends:Boolean = false;
		public var serverName:String;
		public var aGameRooms:Array;
		public var useZoomForNetwork:Boolean = false;
		public var pic_url:String;
		public var serverId:int;
		public var roomId:int;
		public var sZid:String;
		public var currentSortDataField:String = "";
		public var aRoomsById:Array;
		public var playerName:String;
		public var lobbyGridData:fl.data.DataProvider;
		public var currentSortDescending:Boolean = true;
		public var friend_roomId:int;
		public var bShowGetPoints:Boolean = false;
		public var nSelectedBuddy:int;
		public var idList:Array;
		public var friendsObj:Array;
		public var fb_sig_user:Number = 0;
		public var playersOnline:Number = 0;
		public var playerRank:String;
		public var nSelectedNetworkUser:int;
		public var sSelServerName:String;
		public var nSelectedTable:int;
		public var friend_serverId:int;
		public var totalChips:Number = 0;
		public var totalDeposit:Number = 0;
		public var networkUserGridData:fl.data.DataProvider;
		public var friendGridData:fl.data.DataProvider;
		public var sSelServerIp:String;
		public var friendsList:Array;
		public var sSelServerId:String;
		public var bVip:Boolean;
		public var seatedPlayersGridData:fl.data.DataProvider;
		public var serverTypeList:Array;
		public var sSelServerType:String;
		public var casinoNameList:Array;
		public var sLobbyMode:String;
		public var networkObj:Array;
		public var userIds:Array;
		public var aFriends:Array;
		public var newServerIP:String;
		public var BshowFriendList:Boolean;
		public var casinoListData:fl.data.DataProvider;
		public var casinoListData2:Array;
		public var chatStat:int;
		public var chatPop:String;
		public var langs = new Object;
		public var roomid = new Object;
		public var vipName:String;
		public var gameInfo:String;
		
		public function LobbyModel():void
		{
			serverTypeList = new Array();
			idList = new Array();
			friendGridData = new DataProvider();
		}
		public function setServerTypeList(p__1:Array, p__2:Array):void
		{
			serverTypeList = p__1;
			idList = p__2;
		}
		public function getServerType(p__1:String):String
		{
			var l__2:*;
			while(l__2 < idList.length){
				if (idList[l__2] == p__1){
					return(serverTypeList[l__2]);
				}
				l__2++;
			}
			return("");
		}
		public function updateRoomList(p__1:Array):void
		{
			var l__2:Array = p__1;
			aRoomsById = new Array();
			lobbyGridData = new DataProvider();
			var l__3:int;
			while(l__3 < l__2.length){
				aRoomsById[int(l__2[l__3].id)] = l__2[l__3];
				//if ((l__2[l__3].gameType.toLowerCase() == sLobbyMode) && (l__2[l__3].tableType == "Public")){
				if ((l__2[l__3].gameType.toLowerCase() == sLobbyMode)  && (l__2[l__3].tableType == "Public")){
					
					if (sLobbyMode == "challenge"){
						
						lobbyGridData.addItem(new DataGridRoomItem(l__2[l__3], true));
					}
					/*if (sLobbyMode == "private"){
						
						lobbyGridData.addItem(new DataGridRoomItem(l__2[l__3], true));
					}*/
					if (sLobbyMode == "tournament"){
						lobbyGridData.addItem(new DataGridRoomItem(l__2[l__3], false));
					}
				} else if ((sLobbyMode == "private") && (l__2[l__3].tableType == "Private")){
					lobbyGridData.addItem(new DataGridRoomItem(l__2[l__3], true));
				}else if ((sLobbyMode == "vip") && (l__2[l__3].tableType == "VIP")){
					lobbyGridData.addItem(new DataGridRoomItem(l__2[l__3], true));
				} else if ((sLobbyMode == "fast") && (l__2[l__3].tableType == "Fast")){
					lobbyGridData.addItem(new DataGridRoomItem(l__2[l__3], true));
				} //else if (sLobbyMode == "vip"){
				//	lobbyGridData.addItem(new DataGridRoomItem(l__2[l__3], true));
				//}
				l__3++;
			}
			if (currentSortDataField != ""){
				sortTables(currentSortDataField, currentSortDescending);
			} else {
				sortTables("Players", true);
			}
		}
		public function updatePlayerList(p__1:Object):void
		{	
			
			var l__4:String;
			var l__5:String;
			var l__6:String;
			var l__2:Array = p__1.aPlayerList;
			seatedPlayersGridData = new DataProvider();
			var l__3:int;
			while(l__3 < l__2.length){
				l__4 = StringUtility.StringToMoney(l__2[l__3]["chips"]);
				l__5 = l__2[l__3]["pic_url"];
				if ((l__2[l__3]["pic_url"] == null) || (l__2[l__3]["pic_url"] == "")){
					l__5 = "../Avatar/default.jpg";
				}
				if (l__2[l__3]["fullName"].length > 16){
					l__6 = (l__2[l__3]["fullName"].slice(0, 16) + "...");
				} else {
					l__6 = l__2[l__3]["fullName"];
				}
				l__6 = (((l__6 + "\n") + "") + l__4);
				seatedPlayersGridData.addItem({label:l__6, source:unescape(l__5)});
				l__3++;
			}
			seatedPlayersGridData.sortOn("label");
		}
		public function sortTables(p__1:String, p__2:Boolean = false):void
		{
			var l__3:Boolean;
			var l__4:uint;
			var l__5:uint;
			var l__6:uint;
			currentSortDataField = p__1;
			currentSortDescending = p__2;
			if (!(lobbyGridData == null) && (lobbyGridData.length > 0)){
				l__3 = lobbyGridData.getItemAt(0).hasOwnProperty("Fee") ? true : false;
				l__4 = p__2 ? Array.DESCENDING : 0;
				l__6 = (Array.DESCENDING | Array.NUMERIC);
				switch(p__1){
					case "NO":
					{
						l__5 = (l__4 | Array.NUMERIC);
						lobbyGridData.sortOn(["NO"], [l__5]);
						break;
					}
					case "Room":
					{
						l__5 = l__4;
						lobbyGridData.sortOn(["Room"], [l__5]);
						break;
					}
					case "Players":
					{
						l__5 = (l__4 | Array.NUMERIC);
						if (l__3){
							lobbyGridData.sortOn(["sitPlayers", "maxPlayers", "entryFee", "hostFee", "Max", "Min", "NO"], [l__5, l__5, l__6, l__6, l__6, l__6, Array.NUMERIC]);
						} else {
							lobbyGridData.sortOn(["sitPlayers", "maxPlayers", "bigBlind", "smallBlind", "Max", "Min", "NO"], [l__5, l__5, l__6, l__6, l__6, l__6, Array.NUMERIC]);
						}
						break;
					}
					case "Fee":
					{
						l__5 = (l__4 | Array.NUMERIC);
						lobbyGridData.sortOn(["entryFee", "hostFee", "sitPlayers", "maxPlayers", "NO"], [l__5, l__5, l__6, l__6, Array.NUMERIC]);
						break;
					}
					case "Stakes":
					{
						l__5 = (l__4 | Array.NUMERIC);
						lobbyGridData.sortOn(["bigBlind", "smallBlind", "sitPlayers", "maxPlayers", "Max", "Min", "NO"], [l__5, l__5, l__6, l__6, l__6, l__6, Array.NUMERIC]);
						break;
					}
					case "Min":
					{
						l__5 = (l__4 | Array.NUMERIC);
						if (l__3){
							lobbyGridData.sortOn(["Min", "Max", "sitPlayers", "maxPlayers", "entryFee", "hostFee", "NO"], [l__5, l__5, l__6, l__6, l__6, l__6, Array.NUMERIC]);
						} else {
							lobbyGridData.sortOn(["Min", "Max", "sitPlayers", "maxPlayers", "bigBlind", "smallBlind", "NO"], [l__5, l__5, l__6, l__6, l__6, l__6, Array.NUMERIC]);
						}
						break;
					}
					case "Max":
					{
						l__5 = (l__4 | Array.NUMERIC);
						if (l__3){
							lobbyGridData.sortOn(["Max", "Min", "sitPlayers", "maxPlayers", "entryFee", "hostFee", "NO"], [l__5, l__5, l__6, l__6, l__6, l__6, Array.NUMERIC]);
						} else {
							lobbyGridData.sortOn(["Max", "Min", "sitPlayers", "maxPlayers", "bigBlind", "smallBlind", "NO"], [l__5, l__5, l__6, l__6, l__6, l__6, Array.NUMERIC]);
						}
						break;
					}
					case "Status":
					{
						l__5 = l__4;
						lobbyGridData.sortOn(["Status", "sitPlayers", "maxPlayers", "entryFee", "hostFee", "Max", "Min", "NO"], [l__5, l__6, l__6, l__6, l__6, l__6, l__6, Array.NUMERIC]);
						break;
					}
					case "Jackpot":
					{
						l__5 = l__4;
						lobbyGridData.sortOn(["Jackpot", "sitPlayers", "maxPlayers", "entryFee", "hostFee", "Max", "Min", "NO"], [l__5, l__6, l__6, l__6, l__6, l__6, l__6, Array.NUMERIC]);
						break;
					}
				}
			}
		}
		public function zoomUpdateFriends(p__1:Array):void
		{
			var l__3:com.script.poker.UserPresence;
			var l__4:String;
			var l__5:String;
			friendGridData = new DataProvider();
			friendsObj = new Array();
			userIds = new Array();
			var l__2:Number = 0;
			while(l__2 < p__1.length){
				l__3 = p__1[l__2];
				l__4 = getServerType(l__3.nServerId);
				switch(l__4){
					case "normal":
					{
						l__4 = "Points";
						break;
					}
					case "vip":
					{
						l__4 = "Vip";
						break;
					}
					case "sitngo":
					{
						l__4 = "SitNGo";
						break;
					}
					case "shootout":
					{
						l__4 = "ShootOut";
						break;
					}
				}
				if ((l__3.sPicURL == null) || (l__3.sPicURL == "")){
					l__3.sPicURL = "../Avatar/default.jpg";
				}
				if (l__3.nRoomId == -1){
					l__4 = "Texas room";
				}
				userIds.push(l__3.sZid);
				if ((((l__3.sFirstName + " ") + l__3.sLastName).length) > 14){
					l__5 = (((l__3.sFirstName + " ") + l__3.sLastName).slice(0, 14) + "...");
				} else {
					l__5 = ((l__3.sFirstName + " ") + l__3.sLastName);
				}
				
				friendsObj.push({uid:l__3.sZid, game_id:l__3.nGameId, server_id:l__3.nServerId, room_id:l__3.nRoomId, first_name:l__3.sFirstName, last_name:l__3.sLastName, relationship:l__3.sRelationship, playStatus:l__4, label:l__5, source:unescape(l__3.sPicURL)});
				friendGridData.addItem({label:l__5, source:unescape(l__3.sPicURL), playStatus:l__4});
				l__2++;
			}
			friendGridData.sortOn(["playStatus", "label"], [Array.DESCENDING, Array.CASEINSENSITIVE]);
			friendsObj.sortOn(["playStatus", "label"], [Array.DESCENDING, Array.CASEINSENSITIVE]);
		}
		public function updateCasinoList(p__1:Object):void
		{ 
		
			casinoListData = new DataProvider();
			var l__2:int = 0;;
			while(l__2 < p__1.id.length){
				casinoListData.addItem({label:p__1.name[l__2], data:p__1.ip[l__2], id:p__1.id[l__2]});
				l__2++;
			}
			/*while(l__2 < p__1.length){
				casinoListData.addItem({label:p__1[l__2].label, data:p__1[l__2].data, id:p__1[l__2].id});
				l__2++;
			}*/
		}
		public function updateCasinoList2(p__1:Object):void
		{ 
		
			casinoListData2 = new Array();
			var l__2:int = 0;;
			while(l__2 < p__1.id.length){
				casinoListData2[l__2] = {label:p__1.name[l__2], data:p__1.ip[l__2], id:p__1.id[l__2]};
				l__2++;
			}
			/*while(l__2 < p__1.length){
				casinoListData.addItem({label:p__1[l__2].label, data:p__1[l__2].data, id:p__1[l__2].id});
				l__2++;
			}*/
		}
		/*public function zoomUpdateNetworks(p__1:Array):void
		{
			var l__3:com.script.poker.UserPresence;
			var l__4:String;
			networkUserGridData = new DataProvider();
			networkObj = new Array();
			userIds = new Array();
			var l__2:Number = 0;
			while(l__2 < p__1.length){
				l__3 = p__1[l__2];
				userIds.push(l__3.sZid);
				networkObj.push({uid:l__3.sZid, game_id:l__3.nGameId, server_id:l__3.nServerId, room_id:l__3.nRoomId, first_name:l__3.sFirstName, last_name:l__3.sLastName, relationship:l__3.sRelationship});
				l__4 = (((((((l__3.sFirstName + " ") + l__3.sLastName) + " (") + l__3.sRoomDesc) + ", ") + l__3.sRelationship) + ")");
				networkUserGridData.addItem({friend:l__4});
				l__2++;
			}
		}*/
	}
}