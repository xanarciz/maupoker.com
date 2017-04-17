// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker
{
	import com.script.poker.lobby.RoomItem;
	import com.script.poker.table.BuddyInvite;
	import com.script.poker.table.GiftLibrary;
	import com.script.User;
	import ws.tink.core.Library;
	import com.adobe.serialization.json.*;
	import flash.net.LocalConnection;
	import com.script.utils.FlashCookie;
	import com.adobe.crypto.*;
	import com.script.io.LoadUrlVars;
	import flash.external.*;
	public class PokerGlobalData
	{
		
		public var uid:int;
		public var zid:String;
		public var sn_id:int;
		public var tourney_url:String
		public var buzz_url:String;
		public var connectionNameOut:String;
		public var lbLobby:ws.tink.core.Library;
		public var aSnNames:Array = new Array("none", "Facebook", "Orkut", "Meebo", "HI5", "Friendster", "Bebo", "MySpace", "script", "Yahoo", "Tagged");
		public var opt_LobbyTourney_HideRunningTables:Boolean;
		public var vip_buy_url:String;
		public var tableSkinSWF:String;
		public var viewer:com.script.User;
		public var vipDays:int;
		public var pic_lrg_url:String;
		public var bonus:Number = 0;
		public var bLobbyAssetsLoaded:Boolean = false;
		public var useZoomForFriends:Number = 1;
		public var nConnectionId:Number = 0;
		public var buyPromo:int;
		public var presence_url:String;
		public var gameRoomName:String;
		public var SN_FACEBOOK:* = 1;
		public var joinPrevServ:Boolean = false;
		public var lang:String = "en";
		public var vip_host_url:String;
		public var sNetwork:String;
		public var SN_DEFAULT:* = 0;
		public var uAppStartTime:Number = 0;
		public const kJS_SITNGOWINFEED:* = "wontourney";
		public var shootoutId:int = -1;
		public var bRoomListInit:Boolean = false;
		public var iAmMod:Boolean = false;
		public var nNewRoomId:int = -1;
		public var opt_Lobby_HideEmptyTables:Boolean;
		public const kJS_BASEBALLCARDFEED_GAVECHIPS:* = "gavechips";
		public var nHideGifts:int;
		public var restricted:int;
		public var rejoinRoom:int;
		public var xmlPopups:XML;
		public var opt_Sound:Boolean;
		public var so2TableBG:String;
		public var dispMode:String = "challenge";
		public var tourneyState:int;
		public const kJS_BASEBALLCARDFEED_BUYINDVDRINK:* = "buygiftdrink";
		public var fb_sig_api_key:*;
		public var bAutoSitMe:* = false;
		public var serverName:String;
		public var tourneyResultsPlace:Number = 0;
		public var lbConfig:ws.tink.core.Library;
		public var tourneyResultsWinnings:Number = 0;
		public var GIVE_CHIPS_TIME:int = 120000;
		public var connectToZoom:Number = 1;
		public var isJoinFriendSit:Boolean = false;
		public const kJS_BASEBALLCARDFEED_BUYTABLEGIFTS:* = "buytablegifts";
		public var usersOnline:Number = 0;
		public var usersText:String = "";
		public var promoTableBG:String;
		public var gameRoomStakes:String = "";
		public var joiningContact:Boolean = false;
		public var SN_ORKUT:* = 2;
		public var opt_Lobby_HideFullTables:Boolean;
		public var flashCookie:com.script.utils.FlashCookie = null;
		public var tnyTableBG:String;
		public var bonusFrame:int = -1;
		public var xmlSounds:XML;
		public var messageXML:String;
		public var name:String;
		public var isVip:Boolean;
		public var gameInfo:String;
		public var aAppIds:Array;
		public var port:int = 9339;
		public var xmlMessages:XML;
		public var bTableSoundMute:Boolean = false;
		public var tourney_invite:String;
		public var vipStatusMsg:int;
		public var connectionIn:flash.net.LocalConnection;
		public var xmlAssets:XML;
		public var zoomFriendsLimit:Number = 500;
		public var soRound:Number = 1;
		public var playLevel:int;
		public var server_type:String = null;
		public var pokerControlSWF:String;
		public var sZone:String;
		public var fg:String;
		public var aGameRooms:Array;
		public var bVipNav:* = false;
		public var lobbySWF:String;
		public const kJS_BASEBALLCARDFEED_BUYINDVGIFT:* = "buygift";
		public var xmlStats:XML;
		public var SN_FRIENDSTER:* = 5;
		public var opt_LobbyTourney_HideEmptyTables:Boolean;
		public var lobbyRoomId:int;
		public var zoomport:Number = 9333;
		public var SN_MYSPACE:* = 7;
		public var useZoomForNetwork:Number = 1;
		public var lbPopup:ws.tink.core.Library;
		public var firstTimePlayer:int;
		public var points:Number = 0;
		public var deposit:Number = 0;
		public var iphone_url:String = "";
		public var firstRoomList:Boolean = true;
		public var tourney_seats_available:String;
		public var nPrivateRoomId:int = -1;
		public var inTournament:int = -1;
		public var vipPromo:int;
		public var nZoomFriends:Number = 0;
		public var stdTableBG:String;
		public var arrTableBG:Array;
		public var nRetries:int = -2;
		public var bFbShootoutFeed:* = false;
		private var validUrls:Array = new Array(".bebo.com", ".facebook.com", ".fbcdn.net", ".hi5.com", ".myspacecdn.com", ".tagstat.com", ".yahoofs.com", ".yimg.com", "img.avatars.yahoo.com", "iphone.script.com", "proxy.poker.script.com", "statics.poker.static.script.com");
		public var activeRoom:com.script.poker.lobby.RoomItem;
		public var hide_daily_bonus:int = 0;
		public var aFriendZids:Array;
		public var tourneyId:int;
		public var lobbySkinSWF:String;
		public var prevServerId:String;
		public var aRankNames:Array = new Array("", "Rookie", "Playa", "Poker Pro", "Big Dog", "Shark", "PRO 100K", "PRO 250K", "PRO 500K", "PRO 1M", "PRO 5M", "PRO 10M", "PRO 20M", "PRO 50M");
		public var bFbFeedOptin:* = false;
		public var jsCallType:String;
		public var sPass:String;
		public var trace_stats:int = 0;
		public var sServerStatusURL:String;
		public var retryCookie:com.script.utils.FlashCookie = null;
		public var bFbFeedAllow:* = true;
		public var ip:String = "";
		public var on_daily_bonus_js:String = null;
		public var vip_chips_url:String;
		public var nWeeklyTourneyId:int;
		public var oTourneySeatsAvailable:Object;
		public var isJoinFriend:Boolean = false;
		public var pic_url:String;
		public var SN_BEBO:* = 6;
		public var curr_tourney:String;
		public var sRootURL:String;
		public var SN_YAHOO:* = 9;
		public var joinShootoutLobby:Boolean = false;
		public var SN_script:* = 8;
		public var config:Object;
		public var so3TableBG:String;
		public var ZLiveToggle:Number = -1;
		public var newbie:int;
		public var joiningShootout:Boolean = false;
		public var SN_HI5:* = 4;
		public var hideVip:Boolean;
		public var xmlGifts:XML;
		public var newServerId:String;
		public var tourneyPurseShort:Number = 0;
		public var prof_url:String = "";
		public var nids:String;
		public var zoomPassword:String = "";
		public var nsecrets:String;
		public var so1TableBG:String;
		public var nnames:String;
		public var connectionNameIn:String;
		public var joinFriendId:String = "";
		public var nAchievementRank:int;
		public var bAutoFindSeat:Boolean = false;
		public var vipTableBG:String;
		public var main:Object;
		public var nRank:int;
		public var connectionOut:flash.net.LocalConnection;
		public var serverId:String;
		public var userPresenceTimerDelay:int = 300;
		public var findVipSeat:Boolean = false;
		public var oTourneyInvite:Object;
		public var buychips_popup:String = null;
		public var bUserDisconnect:Boolean = false;
		public var firstTimePlaying:int;
		public var oGiftLib:com.script.poker.table.GiftLibrary = null;
		public var protoVersion:int = 8;
		public var oCurrTourney:Object;
		public var bonusButtonHandler:*;
		public var SN_TAGGED:* = 10;
		public var report_url:String;
		public var SN_MEEBO:* = 3;
		public var isWSOP:Boolean = false;
		public var friendCnt:int = 0;
		public var aBuddyInvites:Array;
		public var sHideGifts:String;
		public var gameRoomId:int;
		public var gamePubId:int;
		public var gameRoomNo:int;
		public var jsConfig:String;
		public var tourneyPurse:Number = 0;
		public const kJS_BASEBALLCARDFEED_BUYTABLEDRINKS:* = "buytabledrinks";
		public var zoomhost:String = "";
		public var lbTable:ws.tink.core.Library;
		public var tableCost:Array;
		public var buyinCost:Number = 0;
		public var shownGiftID:int = -1;
		public var chipConvert:Number = 1;
		public var badWords:String = "";
		public var jt:String = "";
		public var sfhost:String = "";
		public var sfport:String = "";
		public var sfzone:String = "";
		public var sfserv:String = "";
		public var pathz:String = "";
		public var chatStat:int = 0;
		public var chatPop:String = "";
		public var langs;
		public var vipName:String="";
		public function PokerGlobalData()
		{
			aBuddyInvites = new Array();
			//oGiftLib = GiftLibrary.GetInst();
			var l__1:* = new Date();
			uAppStartTime = l__1.time;
		}
		public function assignFlashVars(inFlashVars:Object):void
		{
			
			var sKey:String;
			var sValue:String;
			var rawUserPresenceTimerDelay:Number = 0;
			var tHideGifts:Array;
			var giftkey = undefined;
			var sStat:String;
			var statHit:com.script.io.LoadUrlVars;
			var oFlashVars:Object = inFlashVars;
			
			for (sKey in oFlashVars){
				sValue = String(oFlashVars[sKey]);
			}
			
			sfhost = inFlashVars.ip;
			sfport = inFlashVars.connPort;
			sfzone = inFlashVars.zone;
			sfserv = inFlashVars.serv;
			pathz = inFlashVars.pathz;
			
			
			zid = inFlashVars.uid;
			//zid = "111:222:333:444"
			
			//uid = zid.split(":")[1];
			uid = inFlashVars.uid;
			
			sn_id = int(inFlashVars.sn_id);
			
			if (inFlashVars.buychips_popup && !(inFlashVars.buychips_popup == "")){
				buychips_popup = String(inFlashVars.buychips_popup);
			}
			
			sNetwork = inFlashVars.network;
			nRank = int(inFlashVars.rank);
			
			//nAchievementRank = int(inFlashVars.achievement_rank);
			//aFriendZids = inFlashVars.friendlist.split(",");
			
			sPass = inFlashVars.pw;
			sZone = inFlashVars.zone;
			
			nConnectionId = inFlashVars.connection_id;
			sRootURL = inFlashVars.root_url;
			
			sServerStatusURL = inFlashVars.server_status_path;
			presence_url = inFlashVars.presence_url;
			
			
			if (inFlashVars.hasOwnProperty("updateTime")){
				rawUserPresenceTimerDelay = Number(inFlashVars["updateTime"]);
				if ((!isNaN(rawUserPresenceTimerDelay)) && (rawUserPresenceTimerDelay >= 30)){
					userPresenceTimerDelay = rawUserPresenceTimerDelay;
				}
			}
			
			//
			var dd = new Date();
			report_url = inFlashVars.report_url;
			var direc = zid.slice(0,1)
			//pic_url = "";
			pic_url = "../Avatar/"+direc+"/"+zid+".jpg?d="+dd;
			//pic_url = (inFlashVars.hasOwnProperty("pic_url") && checkValidPicUrl(inFlashVars["pic_url"])) ? inFlashVars["pic_url"] : "";
			pic_lrg_url = (inFlashVars.hasOwnProperty("pic_lrg_url") && checkValidPicUrl(inFlashVars["pic_lrg_url"])) ? inFlashVars["pic_lrg_url"] : "";
			if (inFlashVars.hasOwnProperty("prof_url")){
				prof_url = inFlashVars["prof_url"];
				//pic_url = inFlashVars["prof_url"];
			}
			
			vip_chips_url = inFlashVars.vip_chips_url;
			vip_buy_url = inFlashVars.vip_buy_url;
			vip_host_url = inFlashVars.vip_host_url;
			tourney_url = inFlashVars.tourney_url;
			newbie = int(inFlashVars.newbie);
			firstTimePlayer = int(inFlashVars.firstTimePlayer);
			firstTimePlaying = int(inFlashVars.firstTimePlaying);
			vipPromo = int(inFlashVars.vipPromo);
			tourneyPurse = Number(inFlashVars.tourneyPurse);
			tourneyId = -1; //int(inFlashVars.tourneyId);
			tourneyPurseShort = Number(inFlashVars.tourneyPurseShort);
			tourneyState = int(inFlashVars.tourneyState);
			if (inFlashVars.shootoutId != null){
				shootoutId = int(inFlashVars.shootoutId);
			}
			
			if (!(inFlashVars.on_daily_bonus_js == null) && !(inFlashVars.on_daily_bonus_js == "")){
				on_daily_bonus_js = inFlashVars.on_daily_bonus_js;
			}
			
			if (inFlashVars.hide_daily_bonus != null){
				hide_daily_bonus = int(inFlashVars.hide_daily_bonus);
			}
			
			if (!(inFlashVars.promoTableBG == null) && !(inFlashVars.promoTableBG == "")){
				promoTableBG = inFlashVars.promoTableBG;
			}
			buzz_url = inFlashVars.buzz_url;
			jsCallType = inFlashVars.jsCallType;
			jsConfig = inFlashVars.jsConfig;
			zoomhost = inFlashVars.zoomhost;
			zoomport = inFlashVars.zoomport;
			if (inFlashVars.hasOwnProperty("zpw")){
				zoomPassword = inFlashVars["zpw"];
			}
			if (inFlashVars.connectToZoom != null){
				connectToZoom = inFlashVars.connectToZoom;
			}
			if (inFlashVars.useZoomForNetwork != null){
				useZoomForNetwork = inFlashVars.useZoomForNetwork;
			}
			if (inFlashVars.useZoomForFriends != null){
				useZoomForFriends = inFlashVars.useZoomForFriends;
			}
			if (inFlashVars.zoomFriendsLimit != null){
				zoomFriendsLimit = inFlashVars.zoomFriendsLimit;
			}
			if (inFlashVars.ip != null){
				ip = inFlashVars.ip;
			}
			if (inFlashVars.connPort != null){
				port = int(inFlashVars.connPort);
			}
			if (inFlashVars.langPref != null){
				lang = String(inFlashVars.langPref);
			}
			
			sHideGifts = inFlashVars.hideGifts;
			nHideGifts = 0;
			if (!(sHideGifts == null) && !(sHideGifts == "")){
				tHideGifts = sHideGifts.split(",");
				for (giftkey in tHideGifts){
					if (tHideGifts[giftkey] != 0){
						nHideGifts = 1;
						break;
					}
				}
			}
			if (inFlashVars.hasOwnProperty("friendCnt")){
				friendCnt = inFlashVars.friendCnt;
			}
			
			lobbySkinSWF = inFlashVars.lobbySkinSWF;
			pokerControlSWF = inFlashVars.pokerSWF;
			tableSkinSWF = inFlashVars.tableSkinSWF;
			iphone_url = inFlashVars.iphone_url;
			if (!(inFlashVars.trace_stats == null) && !(inFlashVars.trace_stats == "")){
				trace_stats = int(inFlashVars.trace_stats);
			}
			if (inFlashVars.isWSOP != null){
				if (inFlashVars.isWSOP == "1"){
					isWSOP = true;
				}
			}
			
			if (inFlashVars.fg != null){
				fg = inFlashVars.fg;
			}
			if (sn_id == SN_FACEBOOK){
				nnames = inFlashVars.nnames;
				nids = inFlashVars.nids;
				nsecrets = inFlashVars.nsecrets;
				buyPromo = int(inFlashVars.buyPromo);
				fb_sig_api_key = inFlashVars.fb_sig_api_key;
			}
			if (sn_id == SN_MYSPACE){
				
				inTournament = int(inFlashVars.inTournament);
				curr_tourney = inFlashVars.curr_tourney;
				tourney_invite = inFlashVars.tourney_invite;
				tourney_seats_available = inFlashVars.tourney_seats_available;
				bonusFrame = int(inFlashVars.bonusFrame);
				bonusButtonHandler = inFlashVars.bonusButtonHandler;
				restricted = int(inFlashVars.restricted);
				if (curr_tourney != null){
					try {
						oCurrTourney = JSON.decode(unescape(curr_tourney));
					} catch (ex:*) {
					}
				}
				if (tourney_invite != null){
					try {
						oTourneyInvite = JSON.decode(unescape(tourney_invite));
					} catch (ex:*) {
					}
				}
				if (tourney_seats_available != null){
					try {
						oTourneySeatsAvailable = JSON.decode(unescape(tourney_seats_available));
					} catch (ex:*) {
					}
				}
			}
			try {
				flashCookie = new FlashCookie("MM_poker");
				retryCookie = new FlashCookie("PokerRetry");
				nRetries = retryCookie.GetValue("nRetry", -1);
			} catch (err:Error) {
				if (trace_stats == 1){
					sStat = GetSignedTrackingUrl(("o:AS3:SWF:FlashCookie:" + escape(err.name)) + ":2009-04-10");
					if (sStat != ""){
						statHit = new LoadUrlVars();
						statHit.loadURL(sStat, {}, "POST");
					}
				}
			}
		}
		public function assignConfig(p__1:XML):void
		{
			var l__3:XML;
			var l__4:String;
			var l__5:XMLList;
			var l__6:XML;
			var l__7:String;
			var l__8:XMLList;
			var l__9:XML;
			var l__10:XMLList;
			var l__11:XML;
			var l__12:String;
			var l__13:String;
			config = new Object();
			var l__2:XMLList = p__1.children();
			for each (l__3 in l__2){
				l__4 = l__3.name().toString();
				config[l__4] = new Object();
				l__5 = l__3.attributes();
				for each (l__6 in l__5){
					l__7 = l__6.name().toString();
					config[l__4][l__7] = l__6.toString();
				}
				if (l__3.children().length() > 0){
					l__8 = l__3.children();
					for each (l__9 in l__8){
						l__12 = l__9.name().toString();
						config[l__4][l__12] = new Object();
					}
					l__10 = l__9.attributes();
					for each (l__11 in l__10){
						l__13 = l__11.name().toString();
						config[l__4][l__12][l__13] = l__11.toString();
					}
				}
			}
		}
		
		public function getRoomById(p__1:int):com.script.poker.lobby.RoomItem
		{
			var l__2:com.script.poker.lobby.RoomItem;
			var l__3:int;
			while(l__3 < aGameRooms.length){
				//trace ("gamelength "+aGameRooms.length);
				//trace (l__3+" gamerom "+aGameRooms[l__3]);
				l__2 = RoomItem(aGameRooms[l__3]);
				//trace ("itemroom"+l__2.id);
				//trace ("itemroom"+l__2.tabowner);
				//trace ("itemroom"+p__1);
				if (int(l__2.id) == p__1){
					return(l__2);
				}
				//trace ("ga return");
				l__3++;
			}
			return(null);
		}
		
		public function getGiftById(p__1:int):Object
		{
			return(GiftLibrary.GetInst().GetGift(p__1.toString()) as Object);
		}
		public function getGiftByTypeAndNumber(p__1:int, p__2:int):Object
		{
			return(null);
		}
		public function addBuddyInvite(p__1:com.script.poker.table.BuddyInvite):void
		{
			var l__2:int;
			while(l__2 < aBuddyInvites.length){
				if (aBuddyInvites[l__2].sZid == p__1.sZid){
					return;
				}
				l__2++;
			}
			aBuddyInvites.push(p__1);
		}
		public function isBuddyInvited(p__1:String):Boolean
		{
			var l__2:int;
			while(l__2 < aBuddyInvites.length){
				if (aBuddyInvites[l__2].sZid == p__1){
					return(true);
				}
				l__2++;
			}
			return(false);
		}
		public function removeBuddyInvite(p__1:String):void
		{
			var l__2:int;
			while(l__2 < aBuddyInvites.length){
				if (aBuddyInvites[l__2].sZid == p__1){
					aBuddyInvites.splice(l__2, 1);
					return;
				}
				l__2++;
			}
		}
		public function removeAllBuddyInvites():void
		{
			aBuddyInvites.splice(0);
		}
		public function getSnName(p__1:Number):String
		{
			if ((p__1 >= 0) && (p__1 < aSnNames.length)){
				return(aSnNames[p__1]);
			}
			return("");
		}
		public function callFBJS(p__1:String, p__2):void
		{
			if (connectionNameOut){
				connectionOut.send(connectionNameOut, "callFBJS", p__1, p__2);
			}
		}
		public function JSCall_BaseballCardFeed(p__1:String, p__2:Number, p__3:String, p__4:String):void
		{
			var l__5:String = p__1;
			var l__6:Number = p__2;
			var l__7:String = p__3;
			var l__8:String = p__4;
			if (this.sn_id != this.SN_FACEBOOK){
				return;
			}
			if (jsCallType == "fbbridge"){
				callFBJS("flash_alert", l__5, l__6, l__7, l__8);
			} else if (jsCallType == "none"){
			} else if (ExternalInterface.available){
				ExternalInterface.call("flash_alert", l__5, l__6, l__7, l__8);
			}
		}
		public function JSCall_SitNGoWinFeed(p__1:String, p__2:String, p__3:String, p__4:String):void
		{
			var l__5:String = p__1;
			var l__6:String = p__2;
			var l__7:String = p__3;
			var l__8:String = p__4;
			if (this.sn_id != this.SN_FACEBOOK){
				return;
			}
			
			if (jsCallType == "fbbridge"){
				callFBJS("flash_alert", l__5, l__6, l__7, l__8);
			} else if (jsCallType == "none"){
			} else if (ExternalInterface.available){
				ExternalInterface.call("flash_alert", l__5, l__6, l__7, l__8);
			}
		}
		public function JSCall_ShootoutWinFeed(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Number = 0):void
		{			
			var l__6:Number = p__1;
			var l__7:Number = p__2;
			var l__8:Number = p__3;
			var l__9:Number = p__4;
			var l__10:Number = p__5;
			if (this.sn_id != this.SN_FACEBOOK){
				return;
			}
			if (jsCallType == "fbbridge"){
				callFBJS("shootout_alert", l__6, l__7, l__8, l__9, l__10);
			} else if (jsCallType == "none"){
			} else if (ExternalInterface.available){
				ExternalInterface.call("shootout_alert", l__6, l__7, l__8, l__9, l__10);
			}
		}
		public function JSCall_SignUpWSOP(p__1:Boolean, p__2:*, p__3:*, p__4:*, p__5:*):void
		{
			var l__6:Number = 0;
			if (p__1){
				l__6 = 1;
			}
			if (this.sn_id != this.SN_FACEBOOK){
				return;
			}
			if (jsCallType == "fbbridge"){
				if (l__6 == 0){
					callFBJS("toggleWSOPEntry", l__6);
				}
				if (l__6 == 1){
					callFBJS("toggleWSOPEntry", l__6, p__2, p__3, p__4, p__5);
				}
			} else if (jsCallType == "none"){
			} else if (ExternalInterface.available){
				if (l__6 == 0){
					ExternalInterface.call("toggleWSOPEntry", l__6);
				}
				if (l__6 == 1){
					ExternalInterface.call("toggleWSOPEntry", l__6, p__2, p__3, p__4, p__5);
				}
			}
		}
		public function GetSignedTrackingUrl(p__1:String):String
		{
			var l__2:String;
			if ((this.fg == null) || (this.fg == "")){
				return("");
			}
			if (this.sn_id == 1){
				l__2 = "FB";
			} else if (this.sn_id == 7){
				l__2 = "MS";
			} else {
				return("");
			}
			
			p__1 = ((((("Poker_FG " + l__2) + " Flash:AS3 Other Unknown ") + p__1) + " fg:") + this.fg);
			var l__3:* = "SxC1ZN";
			var l__4:String = MD5.hash((p__1 + l__3));
			var l__5:String = ((("http://nav3.script.com/link/link.php?item=" + escape(p__1)) + "&ltsig=") + escape(l__4));
			return(l__5);
		}
		public function getSNTrackingString(p__1:int):String
		{
			switch(p__1){
				case SN_BEBO:
				{
					return("BE");
				}
				case SN_FACEBOOK:
				{
					return("FB");
				}
				case SN_FRIENDSTER:
				{
					return("FR");
				}
				case SN_HI5:
				{
					return("H5");
				}
				case SN_MEEBO:
				{
					return("ME");
				}
				case SN_MYSPACE:
				{
					return("MS");
				}
				case SN_ORKUT:
				{
					return("OT");
				}
				case SN_TAGGED:
				{
					return("TG");
				}
				case SN_DEFAULT:
				{
					return("");
				}
			}
		}
		public function EnsurePHPPopupsAreClosed():void
		{
			if (jsCallType == "fbbridge"){
				callFBJS("close_all");
			} else if (jsCallType == "none"){
			} else if (ExternalInterface.available){
				ExternalInterface.call("close_all");
			}
		}
		public function EnablePHPPopups():void
		{
			if (jsCallType == "fbbridge"){
				callFBJS("enable_popups");
			} else if (jsCallType == "none"){
			} else if (ExternalInterface.available){
				ExternalInterface.call("enable_popups");
			}
			
		}
		public function DisablePHPPopups():void
		{
			if (jsCallType == "fbbridge"){
				callFBJS("disable_popups");
			} else if (jsCallType == "none"){
			} else if (ExternalInterface.available){
				ExternalInterface.call("disable_popups");
			}
		}
		private function checkValidPicUrl(p__1:String):Boolean
		{
			var l__4:String;
			var l__5:Boolean;
			var l__6:String;
			var l__2:RegExp = /^http:\/\/([\w\.-]+)(\/[^\?]+)$/i;
			var l__3:Object = l__2.exec(p__1);
			if (l__3 != null){
				l__4 = l__3[1];
				l__5 = false;
				for each (l__6 in validUrls){
					if (l__4.substring(l__4.length - l__6.length) == l__6){
						l__5 = true;
						break;
					}
				}
				return(l__5 ? true : false);
			} else {
				return(false);
			}
		}
	}
}