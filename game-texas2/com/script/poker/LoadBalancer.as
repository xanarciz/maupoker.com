// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker
{
	import flash.events.*;
	import com.script.events.*;
	import com.script.io.*;
	public class LoadBalancer extends flash.events.EventDispatcher
	{
		public var idList:Array;
		public var serverTypeList:Array;
		private var pgData:com.script.poker.PokerGlobalData;
		private var maxUsersList:Array;
		private var shootoutList:Array;
		private var serverLangList:Array;
		private var curStatusList:Array;
		public var aServerList:Array;
		private var nameList:Array;
		public var aPrevServerId:Array;
		private var ipList:Array;
		public var curUsersList:Array;
		public var aConnFailList:Array;
		public static const onServerChosen:String = "onServerChosen";
		public static const serverListParsed:String = "serverListParsed";
		public function LoadBalancer(p__1:com.script.poker.PokerGlobalData)
		{
			pgData = p__1;
			nameList = new Array();
			ipList = new Array();
			maxUsersList = new Array();
			curUsersList = new Array();
			curStatusList = new Array();
			serverTypeList = new Array();
			serverLangList = new Array();
			idList = new Array();
			aServerList = new Array();
			aPrevServerId = new Array();
			aConnFailList = new Array();
		}
		private function init()
		{
			nameList = new Array();
			ipList = new Array();
			maxUsersList = new Array();
			curUsersList = new Array();
			curStatusList = new Array();
			serverTypeList = new Array();
			serverLangList = new Array();
			idList = new Array();
			aServerList = new Array();
			shootoutList = new Array();
		}
		public function chooseBestServer():void
		{
			getServerList();
		}
		public function getServerList():void
		{
			init();
			//var l__1:com.script.io.LoadUrlVars = new LoadUrlVars();
			//l__1.addEventListener(URLEvent.onLoaded, onServerStatus);
			//l__1.loadURL(pgData.sServerStatusURL, {uid:pgData.zid, nocache:(new Date()).getTime()});
		}
		private function onServerStatus(p__1:com.script.events.URLEvent):void
		{
			var l__2:com.script.io.LoadUrlVars = LoadUrlVars(p__1.target);
			l__2.removeEventListener(URLEvent.onLoaded, onServerStatus);
			if (p__1.bSuccess){
				parseServerList(p__1.data);
				if (!pgData.bUserDisconnect){
					findBestServer();
				}
			} else {
				dispatchEvent(new LBEvent(LBEvent.serverStatusError));
			}
		}
		private function parseServerList(p__1:String):void
		{
		
			var l__6:* = undefined;
			var l__7:* = undefined;
			var l__8:* = undefined;
			var l__2:* = p__1.split("\n");
			var l__3:*;
			while(l__3 < (l__2.length - 1)){
				if (l__2[l__3].substring(0, 1) != "#"){
					l__6 = l__2[l__3].split(",");
					l__7 = 0;
					while(l__7 < l__6.length){
						l__8 = l__6[l__7].split("=");
						if (l__8[0] == "ip"){
							ipList.push(l__8[1]);
						} else if (l__8[0] == "name"){
							nameList.push(l__8[1]);
						} else if (l__8[0] == "maxUsers"){
							maxUsersList.push(int(l__8[1]));
						} else if (l__8[0] == "uCount"){
							curUsersList.push(int(l__8[1]));
						} else if (l__8[0] == "status"){
							curStatusList.push(l__8[1]);
						} else if (l__8[0] == "id"){
							idList.push(l__8[1]);
						} else if (l__8[0] == "type"){
							serverTypeList.push(l__8[1]);
						} else if (l__8[0] == "langPref"){
							serverLangList.push(l__8[1].toLowerCase());
						} else {
							dispatchEvent(new LBEvent(LBEvent.serverListError));
						}
						l__7++;
					}
				}
				l__3++;
			}
			var l__4:Number = 0;
			aServerList = new Array();
			var l__5:*;
			while(l__5 < ipList.length){
				if (pgData.isVip){
					if (((curStatusList[l__5] == "OK") || (curStatusList[l__5] == "Preferred")) && ((((serverTypeList[l__5] == "normal") || (serverTypeList[l__5] == "sitngo")) || (serverTypeList[l__5] == "vip")) || (serverTypeList[l__5].indexOf("special") == 0))){
						aServerList.push({label:nameList[l__5], data:ipList[l__5], id:idList[l__5], users:curUsersList[l__5]});
					}
				} else if (((curStatusList[l__5] == "OK") || (curStatusList[l__5] == "Preferred")) && (((serverTypeList[l__5] == "normal") || (serverTypeList[l__5] == "sitngo")) || (serverTypeList[l__5].indexOf("special") == 0))){
					aServerList.push({label:nameList[l__5], data:ipList[l__5], id:idList[l__5], users:curUsersList[l__5]});
				}
				l__4 = (l__4 + Number(curUsersList[l__5]));
				l__5++;
			}
			pgData.usersOnline = l__4;
			dispatchEvent(new LBEvent(LBEvent.onParseServerList));
		}
		private function findBestServer():void
		{
			var l__3:* = undefined;
			var l__10:String;
			var l__11:int;
			var l__12:* = undefined;
			var l__13:* = undefined;
			var l__14:int;
			var l__1:* = 100;
			var l__2:* = -1;
			var l__4:Array = new Array();
			var l__5:Array = new Array();
			var l__6:Array = new Array();
			var l__7:Array = new Array();
			shootoutList = new Array();
			var l__8:*;
			while(l__8 < ipList.length){
				if (pgData.tourneyId > -1){
					if ((curStatusList[l__8] == "OK") && (serverTypeList[l__8] == "tourney")){
						l__3 = (curUsersList[l__8] / maxUsersList[l__8]) * 100;
						if (((l__3 <= 100) && (l__3 <= l__1)) && (!checkConnFail(idList[l__8]))){
							l__1 = l__3;
							l__2 = l__8;
						}
					}
				} else if (pgData.dispMode == "vip"){
					if ((curStatusList[l__8] == "OK") && (serverTypeList[l__8] == "vip")){
						l__3 = (curUsersList[l__8] / maxUsersList[l__8]) * 100;
						if (((l__3 <= 100) && (l__3 <= l__1)) && (!checkConnFail(idList[l__8]))){
							l__1 = l__3;
							l__2 = l__8;
						}
					}
				} else if (pgData.dispMode == "tournament"){
					if ((curStatusList[l__8] == "OK") && (serverTypeList[l__8] == "sitngo")){
						l__3 = (curUsersList[l__8] / maxUsersList[l__8]) * 100;
						if (((l__3 <= 100) && (l__3 <= l__1)) && (!checkConnFail(idList[l__8]))){
							l__1 = l__3;
							l__2 = l__8;
						}
					}
				} else if ((pgData.dispMode == "shootout") || (pgData.shootoutId > -1)){
					l__10 = serverTypeList[l__8];
					if ((curStatusList[l__8] == "OK") && !(l__10.indexOf("shootout") == -1)){
						l__11 = int(l__10.split("shootout")[1]);
						if (shootoutList[l__11] != undefined){
							shootoutList[l__11].push(l__8);
						} else {
							shootoutList[l__11] = new Array();
							shootoutList[l__11].push(l__8);
						}
					}
				} else if (curStatusList[l__8] == "Preferred"){
					l__4.push(l__8);
				} else if (!(pgData.server_type == null) && (serverTypeList[l__8] == pgData.server_type)){
					l__5.push(l__8);
				} else if ((curStatusList[l__8] == "OK") && (serverTypeList[l__8] == "normal")){
					if (serverLangList[l__8] == pgData.lang){
						l__7.push(l__8);
					} else if (serverLangList[l__8] == "en"){
						l__6.push(l__8);
					}
				}
				l__8++;
			}
			var l__9:Number = 0;
			if (l__4.length > 0){
				l__2 = l__4[0];
			} else if (l__5.length > 0){
				l__9 = 0;
				while(l__9 < l__5.length){
					l__8 = l__5[l__9];
					l__3 = (curUsersList[l__8] / maxUsersList[l__8]) * 100;
					if (((l__3 <= 100) && (l__3 <= l__1)) && (!checkConnFail(idList[l__8]))){
						l__1 = l__3;
						l__2 = l__8;
					}
					l__9++;
				}
			} else if (l__7.length > 0){
				l__9 = 0;
				while(l__9 < l__7.length){
					l__8 = l__7[l__9];
					l__3 = (curUsersList[l__8] / maxUsersList[l__8]) * 100;
					if (((l__3 <= 100) && (l__3 <= l__1)) && (!checkConnFail(idList[l__8]))){
						l__1 = l__3;
						l__2 = l__8;
					}
					l__9++;
				}
				if ((l__2 == -1) && (l__6.length > 0)){
					l__9 = 0;
					while(l__9 < l__6.length){
						l__8 = l__6[l__9];
						l__3 = (curUsersList[l__8] / maxUsersList[l__8]) * 100;
						if (((l__3 <= 100) && (l__3 <= l__1)) && (!checkConnFail(idList[l__8]))){
							l__1 = l__3;
							l__2 = l__8;
						}
						l__9++;
					}
				}
			} else if (l__6.length > 0){
				l__9 = 0;
				while(l__9 < l__6.length){
					l__8 = l__6[l__9];
					l__3 = (curUsersList[l__8] / maxUsersList[l__8]) * 100;
					if (((l__3 <= 100) && (l__3 <= l__1)) && (!checkConnFail(idList[l__8]))){
						l__1 = l__3;
						l__2 = l__8;
					}
					l__9++;
				}
			}
			if ((pgData.joiningContact == true) || (pgData.joinPrevServ == true)){
				pgData.joinPrevServ = false;
				l__12 = false;
				l__14 = 0;
				while(l__14 < idList.length){
					if (idList[l__14] == pgData.newServerId){
						l__13 = l__14;
						l__12 = true;
						break;
					}
					l__14++;
				}
				if (l__12 == false){
					pgData.joiningContact = false;
					findBestServer();
					return;
				}
				pgData.serverName = nameList[l__13];
				pgData.ip = ipList[l__13];
				pgData.serverId = idList[l__13];
				pgData.sZone = getZone(serverTypeList[l__13]);
				dispatchEvent(new LBEvent(LBEvent.onServerChosen));
			} else if ((pgData.dispMode == "shootout") || (pgData.shootoutId > -1)){
				l__13 = findShootoutServer();
				if (l__13 != -1){
					pgData.serverName = nameList[l__13];
					pgData.ip = ipList[l__13];
					pgData.serverId = idList[l__13];
					pgData.sZone = getZone("shootout");
					dispatchEvent(new LBEvent(LBEvent.onServerChosen));
				} else {
					dispatchEvent(new LBEvent(LBEvent.findServerError));
				}
			} else if (l__2 != -1){
				pgData.serverName = nameList[l__2];
				pgData.ip = ipList[l__2];
				pgData.serverId = idList[l__2];
				pgData.sZone = getZone(serverTypeList[l__2]);
				dispatchEvent(new LBEvent(LBEvent.onServerChosen));
			} else {
				dispatchEvent(new LBEvent(LBEvent.findServerError));
			}
		}
		private function findShootoutServer():int
		{
			var l__2:Array;
			var l__3:int;
			var l__6:* = undefined;
			var l__7:int;
			var l__1:Number = pgData.soRound;
			var l__4:* = 100;
			var l__5:* = -1;
			if (shootoutList[l__1] != undefined){
				l__2 = shootoutList[l__1];
				l__7 = 0;
				while(l__7 < l__2.length){
					l__3 = l__2[l__7];
					l__6 = (curUsersList[l__3] / maxUsersList[l__3]) * 100;
					if (((l__6 <= 100) && (l__6 <= l__4)) && (!checkConnFail(idList[l__3]))){
						l__4 = l__6;
						l__5 = l__3;
					}
					l__7++;
				}
				if (l__5 != -1){
					return(l__5);
				}
			}
			var l__8:* = (l__1 + 1);
			while(l__8 < shootoutList.length){
				if (shootoutList[l__8] != undefined){
					l__2 = shootoutList[l__8];
					l__7 = 0;
					while(l__7 < l__2.length){
						l__3 = l__2[l__7];
						l__6 = (curUsersList[l__3] / maxUsersList[l__3]) * 100;
						if (((l__6 <= 100) && (l__6 <= l__4)) && (!checkConnFail(idList[l__3]))){
							l__4 = l__6;
							l__5 = l__3;
						}
						l__7++;
					}
					if (l__5 != -1){
						return(l__5);
					}
				}
				l__8++;
			}
			l__8 = l__1 - 1;
			while(l__8 >= 0){
				if (shootoutList[l__8] != undefined){
					l__2 = shootoutList[l__8];
					l__7 = 0;
					while(l__7 < l__2.length){
						l__3 = l__2[l__7];
						l__6 = (curUsersList[l__3] / maxUsersList[l__3]) * 100;
						if (((l__6 <= 100) && (l__6 <= l__4)) && (!checkConnFail(idList[l__3]))){
							l__4 = l__6;
							l__5 = l__3;
						}
						l__7++;
					}
					if (l__5 != -1){
						return(l__5);
					}
				}
				l__8--;
			}
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
		public function getZone(p__1:String):String
		{
			switch(p__1){
				case "vip":
				{
					return("PokerVIP");
				}
				case "normal":
				{
					return("TexasHoldemUp");
				}
				case "tourney":
				{
					return("PokerTourney");
				}
				case "sitngo":
				{
					return("PokerSitNGo");
				}
				case "shootout":
				{
					return("PokerShootout");
				}
				default:
				{
					if (p__1.indexOf("special") == 0){
						return("TexasSpecial");
					}
					return("TexasHoldemUp");
				}
			}
		}
		public function addPrevServerId(p__1:Number):void
		{
			var l__2:Number = getServerArrayIndexWithServerId(p__1);
			if (l__2 < 0){
				return;
			}
			var l__3:String = serverTypeList[l__2];
			var l__4:Object = getPrevServerId(l__3);
			if (l__4 == null){
				l__4 = new Object();
				l__4.serverType = l__3;
				l__4.id = p__1;
				aPrevServerId.push(l__4);
			} else {
				updatePrevServerId(l__3, p__1);
			}
		}
		public function updatePrevServerId(p__1:String, p__2:Number):void
		{
			var l__4:Object;
			var l__3:int;
			while(l__3 < aPrevServerId.length){
				l__4 = aPrevServerId[l__3];
				if (l__4.serverType == p__1){
					l__4.id = p__2;
					aPrevServerId[l__3] = l__4;
					return;
				}
				l__3++;
			}
		}
		public function getPrevServerId(p__1:String):Object
		{
			var l__3:Object;
			var l__2:int;
			while(l__2 < aPrevServerId.length){
				l__3 = aPrevServerId[l__2];
				if (l__3.serverType == p__1){
					return(l__3);
				}
				l__2++;
			}
			return(null);
		}
		public function getServerArrayIndexWithServerId(p__1:Number):Number
		{
			var l__2:Number = 0;
			while(l__2 < idList.length){
				if (idList[l__2] == p__1){
					return(l__2);
				}
				l__2++;
			}
			return(-1);
		}
		public function getPrevServerOfType(p__1:String):Number
		{
			var l__2:Object = getPrevServerId(p__1);
			if (l__2 != null){
				return(l__2.id);
			}
			return(-1);
		}
		public function addConnFail(p__1:Number):void
		{
			var l__2:int;
			while(l__2 < aConnFailList.length){
				if (aConnFailList[l__2] == p__1){
					return;
				}
				l__2++;
			}
			aConnFailList.push(p__1);
		}
		public function clearConnFail():void
		{
			aConnFailList = new Array();
		}
		public function checkConnFail(p__1:Number):Boolean
		{
			var l__2:int;
			while(l__2 < aConnFailList.length){
				if (aConnFailList[l__2] == p__1){
					return(true);
				}
				l__2++;
			}
			return(false);
		}
	}
}