// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com

package com.script.poker
{
	import com.script.poker.lobby.*;
	import it.gotoandplay.smartfoxserver.data.*;
	import com.adobe.serialization.json.*;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import com.script.poker.protocol.*;
	import com.script.io.SmartfoxConnectionManager;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
    import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	
	
	public class PokerConnectionManager extends com.script.io.SmartfoxConnectionManager
	{
			//public var _key = "";
			//private var smileJpg = new Array("emotion/Laugh.jpg","emotion/Think.jpg","emotion/Thumb.jpg","emotion/ThumbDown.jpg","emotion/Confuse.jpg","emotion/Angry.jpg","emotion/Sad.jpg","emotion/Thanks.jpg","emotion/Wave.jpg","emotion/Win.jpg")
			//private var smiley = new Array("emotion/Laugh.swf","emotion/Think.swf","emotion/Thumb.swf","emotion/ThumbDown.swf","emotion/Confuse.swf","emotion/Angry.swf","emotion/Sad.swf","emotion/Thanks.swf","emotion/Wave.swf","emotion/Win.swf")
				private var smileText = new Array("Laugh", "Love", "Poor", "Pain", "Confuse", "Scare", "Thanks", "Coboy", "Shy", "Cool", "Fight", "Shock", "Sleepy", "Wacky", "Angry")


			//private var smileText = new Array("Laugh", "Think", "Great", "Loser", "Confuse", "Angry", "Thanks", "Wave", "Win", "Cry", "Fight", "Shock", "Kiss", "Wacky", "WhiteFlag")
			private var animJpg = new Array("animation/Snow.gif","animation/Paper.gif");
			private var anim = new Array("animation/Snow.swf","animation/Paper.swf","animation/Dancer.swf")
			private var animText = new Array("Snow","Paper","Clown","Dancer","Dancer2")
			private var emoLeng = new Array(0,15,5)
			private var langs;
			
		public function PokerConnectionManager(p__1:String = "1",p__2:String = "1",p__3:Object = "1"):void
		{
			super(p__1,p__2);
			langs = p__3;
		}
		public function initProtocolListeners():void
		{
			smartfox.addEventListener(SFSEvent.onExtensionResponse, onExtensionHandler);
			smartfox.addEventListener(SFSEvent.onJoinRoom, onJoinRoomHandler);
			smartfox.addEventListener(SFSEvent.onRoomListUpdate, onRoomListUpdate);
			smartfox.addEventListener(SFSEvent.onPublicMessage, onPublicMessage);
			smartfox.addEventListener(SFSEvent.onConnectionLost, onConnectionLost);
			smartfox.addEventListener(SFSEvent.onJoinRoomError, onJoinRoomError);
			smartfox.addEventListener(SFSEvent.onAdminMessage, onAdminMessage);
			smartfox.addEventListener(SFSEvent.onLogin, onSFLogin);
			
			this.addEventListener(SmartfoxConnectionManager.CONNECT_FAILED, onConnectionFailed);
		}
		
		public function login(p__1:com.script.poker.protocol.SSuperLogin):void
		{
			smartfox.login(p__1.zone, p__1.userId, p__1.pass);
		}
		
		public function getRoomList():void
		{
			smartfox.getRoomList();
		}
		public function autoJoin():void
		{
			smartfox.autoJoin();
		}
		public function joinRoom(p__1:com.script.poker.protocol.SJoinRoom):void
		{
			if (p__1.sPassword != ""){
				smartfox.joinRoom(p__1.nRoomId, p__1.sPassword);
			} else {
				smartfox.joinRoom(p__1.nRoomId);
			}
		}
		//public function getUsersInRoom(p__1:com.script.poker.protocol.SGetUsersInRoom):void
		public function onUsersInRoom(p__1:Object):void
		{
			var l__5:com.script.poker.protocol.RGetUsersInRoom;
			var l__6:Object;
			//var l__2:* = smartfox.getRoom(p__1.roomId);
			//var l__3:* = l__2.getUserList();
			var l__3:* = p__1[2];
			var l__4:Array = new Array();
			for (i in l__3){
				//if (!(p__1.userId == l__3[i].getName()) && (!l__3[i].isModerator())){
					l__6 = new Object();
					//l__6.zid = l__3[i].getName();
					//l__6.name = l__3[i].getVariable("fullname");
					l__6.zid = l__3[i];
					l__6.name = l__3[i];
					l__4.push(l__6);
				//}
			}
			l__5 = new RGetUsersInRoom("RGetUsersInRoom", l__4);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__5));
		}
		public function onUsersWaiting(p__1:Object):void
		{
			var l__5:com.script.poker.protocol.RGetUsersWaiting;
			var l__6:Object;
			//var l__2:* = smartfox.getRoom(p__1.roomId);
			//var l__3:* = l__2.getUserList();
			var l__3:* = p__1[2];
			var l__4:Array = new Array();
			for (i in l__3){
				//if (!(p__1.userId == l__3[i].getName()) && (!l__3[i].isModerator())){
					l__6 = new Object();
					//l__6.zid = l__3[i].getName();
					//l__6.name = l__3[i].getVariable("fullname");
					l__6.zid = l__3[i];
					l__6.name = l__3[i];
					l__4.push(l__6);
				//}
			}
			
			l__5 = new RGetUsersWaiting("RGetUsersWaiting", l__4);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__5));
		}
		public function sendMessage(p__1:Object):void
		{
			var l__2:* = undefined;
			
			switch(p__1.type){
				case "SJoinRoom":
				{
					l__2 = SJoinRoom(p__1);
					joinRoom(l__2);     
					break;
				}
				case "SSuperJoinRoom":
				{
					l__2 = SSuperJoinRoom(p__1);
					var  getroom = smartfox.getRoomByName("TXH"+l__2.nRoomId)
					if (getroom == null) {
						getRoomList();
					}
					sendXtMessage("txh_ext", "superJoin", {autoRoom:1, roomId:l__2.nRoomId, pass:l__2.sPassword, jt:l__2.jt, key:_key},"xml");
					break;
				}
				case "SStandUp":
				{
					l__2 = SStandUp(p__1);
					sendXtMessage("txh_ext", "standUp", {key:_key, jt:l__2.jt}, "xml");
					break;
				}
				case "SAction":
				{
					l__2 = SAction(p__1);
					sendXtMessage("txh_ext", "act", {_cmd:"act", chips:l__2.chips, action:l__2.action, jt:l__2.jt, key:_key}, "xml");
					break;
				}
				case "SBJackpot":
				{
					l__2 = SBJackpot(p__1);
					
					sendXtMessage("txh_ext", "bjackpot", {_cmd:"bjackpot", action:l__2.action, stats:l__2.stats, price:l__2.price,key:_key}, "xml");
					break;
				}
				case "SCekPoints":
				{
					l__2 = SCekPoints(p__1);
					
					sendXtMessage("txh_ext", "cekpoints", {_cmd:"cekpoints",key:_key}, "xml");
					break;
				}
				case "SAddPoints":
				{
					l__2 = SAddPoints(p__1);
					sendXtMessage("txh_ext", "addPoints", {point:p__1.point, key:_key}, "xml");
					break;
				}
				case "SClearPoints":
				{
					//l__2 = SAddPoints(p__1);
					sendXtMessage("txh_ext", "clearPoints", {cmd:p__1.type, key:_key}, "xml");
					break;
				}
				case "SGetRoomInfo":
				{
					l__2 = SGetRoomInfo(p__1);
					sendXtMessage("texasLogin", "getRoomInfo", {id:l__2.roomId, key:_key}, "xml");
					break;
				}
				case "SGetRoomInfo2":
				{
					
					l__2 = SGetRoomInfo2(p__1);
					sendXtMessage("txh_ext", "getRoomInfo2", {id:l__2.roomId, key:_key}, "xml");
					break;
				}
				case "SGetUsersInRoom":
				{
					l__2 = SGetUsersInRoom(p__1);
					//getUsersInRoom(l__2);
					sendXtMessage("txh_ext", "getUsersInRoom", {userid:l__2.userId, roomid:l__2.roomId, key:_key}, "xml");
					break;
				}
				case "SGetUsersWaiting":
				{
					l__2 = SGetUsersWaiting(p__1);
					//getUsersInRoom(l__2);
					sendXtMessage("txh_ext", "getUsersWaiting", {userid:l__2.userId, roomid:l__2.roomId, key:_key}, "xml");
					break;
				}
				case "SGetRoomPass":
				{
					l__2 = SGetRoomPass(p__1);
					sendXtMessage("texasLogin", "getRoomPass", {rid:l__2.roomId, key:_key}, "xml");
					break;
				}
				case "SCreateRoom":
				{
					l__2 = SCreateRoom(p__1);
					sendXtMessage("txh_ext", "createRoom", {name:l__2.sName, pwd:l__2.sPass, smallBlind:l__2.nSmallBlind, bigBlind:l__2.nBigBlind, maxBuyin:l__2.nMaxBuyIn, maxPlayers:l__2.nMaxPlayers, Cost:l__2.nCost, key:_key}, "xml");
					break;
				}
				case "SChangePass":
				{
					l__2 = SChangePass(p__1);
					sendXtMessage("txh_ext", "editRoom", {oldP:l__2.oldPass, newP:l__2.newPass, newP2:l__2.newPass2, key:_key}, "xml");
					break;
				}
				case "SCreateGroupRoom":
				{
					l__2 = SCreateGroupRoom(p__1);
					sendXtMessage("roomCreator", "createGroupRoom", {name:l__2.roomName, pwd:l__2.password, smallBlind:l__2.smallBlind, bigBlind:l__2.bigBlind, maxBuyin:l__2.maxBuyin, maxPlayers:l__2.maxPlayers, gid:l__2.gid}, "xml");
					break;
				}
				case "SCreateNetworkRoom":
				{
					l__2 = SCreateNetworkRoom(p__1);
					sendXtMessage("roomCreator", "createNetworkRoom", {name:l__2.roomName, pwd:l__2.password, smallBlind:l__2.smallBlind, bigBlind:l__2.bigBlind, maxBuyin:l__2.maxBuyin, maxPlayers:l__2.maxPlayers, gid:l__2.gid}, "xml");
					break;
				}
				case "SPickRoom":
				{
					l__2 = SPickRoom(p__1);
					//sendXtMessage("texasLogin", "pickRoom", {_cmd:"pickRoom"}, "xml");
					sendXtMessage("txh_ext", "pickRoom", {_cmd:"pickRoom", key:_key}, "xml");
					break;
				}
				case "SPickRoomShootout":
				{
					l__2 = SPickRoomShootout(p__1);
					sendXtMessage("texasLogin", "pickRoom", {_cmd:"pickRoom", id:l__2.id, idVersion:l__2.idVersion, key:_key}, "xml");
					break;
				}
				case "SCreateBucketRoom":
				{
					l__2 = SCreateBucketRoom(p__1);
					sendXtMessage("roomCreator", "createBucketRoom", {bucket:l__2.bucket}, "xml");
					break;
				}
				case "SSetUserProps":
				{
					l__2 = SSetUserProps(p__1);
					sendXtMessage("texasLogin", "setUserProps", {pic_url:l__2.pic_url, rank:l__2.rank, network:l__2.network, pic_lrg_url:l__2.pic_lrg_url, sn_id:l__2.sn_id, profile_url:l__2.prof_url, tourneyState:l__2.tourneyState, protoVersion:l__2.protoVersion, capabilities:l__2.capabilities, clientType:l__2.clientType, firstTimePlayer:l__2.firstTimePlaying}, "xml");
					break;
				}
				case "SReplayState":
				{
					l__2 = SReplayState(p__1);
					sendXtMessage("txh_ext", "replayState", {key:_key}, "xml");
					break;
				}
				case "SDisplayRoomList":
				{
					l__2 = SDisplayRoomList(p__1);
					sendXtMessage("texasLogin", "displayRoomList", {key:_key}, "xml");
					break;
				}
				case "SKick":
				{/**/
					l__2 = SKick(p__1);
					sendXtMessage("$dmn", "kick", {id:l__2.id, msg:l__2.msg}, "xml");
					break;
				}
				/*case "SStandUp":
				{
					l__2 = SStandUp(p__1);
					sendXtMessage("gameRoom", "standUp", {}, "xml");
					break;
				}*/
				case "SRegList":
				{
					l__2 = SRegList(p__1);
					sendXtMessage("tournament", "reglist", {}, "str");
					break;
				}
				case "SPayoutStruct":
				{
					l__2 = SPayoutStruct(p__1);
					sendXtMessage("tournament", "payoutStruct", {}, "str");
					break;
				}
				case "SRoomList":
				{
					l__2 = SRoomList(p__1);
					sendXtMessage("tournament", "roomlist", {}, "str");
					break;
				}
				case "SClientData":
				{
					l__2 = SClientData(p__1);
					sendXtMessage("tournament", "clientdata", {intro:"intro"}, "str");
					break;
				}
				case "SGiftChips":
				{
					l__2 = SGiftChips(p__1);
					sendXtMessage("gameRoom", "giftChips", {amt:l__2.giftAmt, toFbid:l__2.fbid}, "xml");
					break;
				}
				case "SSit":
				{
					l__2 = SSit(p__1);
					sendXtMessage("txh_ext", "sit", {_cmd:"sit", buyIn:l__2.buyIn, sitNo:Number(l__2.sitId), key:_key}, "xml");
					break;
				}
				
				case "SBuyGift":
				{
					l__2 = SBuyGift(p__1);
					sendXtMessage("gameRoom", "buyGift", {_cmd:"buyGift", type:l__2.giftType, number:l__2.giftId, toZid:l__2.zid}, "xml");
					break;
				}
				case "SBuyGift2":
				{
					l__2 = SBuyGift2(p__1);
					sendXtMessage("txh_ext", "buyGift2", {_cmd:"buyGift2", categoryId:l__2.giftType, giftId:l__2.giftId, toZid:l__2.zid, toSit:l__2.sit, key:_key}, "xml");
					break;
				}
				case "SQueryGifts":
				{
					l__2 = SQueryGifts(p__1);
					sendXtMessage("gameRoom", "queryGifts", {_cmd:"queryGifts", sit:l__2.sit}, "xml");
					break;
				}
				case "SQueryGifts2":
				{
					l__2 = SQueryGifts2(p__1);
					sendXtMessage("txh_ext", "queryGifts2", {_cmd:"queryGifts2", sit:l__2.sit, key:_key}, "xml");
					break;
				}
				case "SShowGift":
				{
					l__2 = SShowGift(p__1);
					sendXtMessage("gameRoom", "showGift", {_cmd:"showGift", gift:l__2.gift}, "xml");
					break;
				}
				case "SGetGiftInfo2":
				{
					/**/l__2 = SGetGiftInfo2(p__1);
					//if (l__2.giftId == -1){
						sendXtMessage("txh_ext", "getGiftInfo2", {_cmd:"getGiftInfo2", giftId:l__2.giftId, key:_key}, "xml");
						//sendXtMessage("texasLogin", "getGiftInfo2", {_cmd:"getGiftInfo2", giftId:l__2.giftId}, "xml");
					//} else {
						//sendXtMessage("gameRoom", "getGiftInfo2", {_cmd:"getGiftInfo2", giftId:l__2.giftId}, "xml");
					//}
					break;
				}
				case "SGetGiftPrices":
				{
					l__2 = SGetGiftPrices(p__1);
					sendXtMessage("gameRoom", "getGiftPrices", {_cmd:"getGiftPrices", type:l__2.giftType}, "xml");
					break;
				}
				case "SGetGiftPrices2":
				{
					l__2 = SGetGiftPrices2(p__1);
					sendXtMessage("txh_ext", "getGiftPrices2", {_cmd:"getGiftPrices2", category:l__2.giftType, toZid:l__2.toZid, key:_key}, "xml");
					break;
				}
				 case "SShowGift3":
                {
                    l__2 = SShowGift3(p__1);
                   /* if (_loc_2.fromLobby)
                    {
                        sendXtMessage("texasLogin", "showGift3", {_cmd:"showGift3", gift:_loc_2.gift}, "xml");
                    }
                    else
                    {*/
                        sendXtMessage("txh_ext", "showGift3", {_cmd:"showGift3", gift:l__2.gift, key:_key}, "xml");
                   // }
                    break;
                }
				case "SGetCardOptions":
				{
					l__2 = SGetCardOptions(p__1);
					sendXtMessage("txh_ext", "getCardOptions", {_cmd:"getCardOptions", zid:l__2.zid, key:_key}, "xml");
					break;
				}
				case "SBuyEmo":
				{
					l__2 = SBuyEmo(p__1);
					/*var t__1 = new Object();
					t__1.fromSit = l__2.sit;
					t__1.giftId = l__2.emoId;
					t__1.fromChips = "0";
					t__1.toSit =l__2.sit;
					*/
					//onBoughtEmo(t__1)
					
					sendXtMessage("txh_ext", "buyEmo", {_cmd:"buyEmo", number:l__2.emoId, tosit:l__2.sit, fromsit:l__2.sit, str:l__2.emoStr, key:_key}, "xml");
					break;
				}
				case "SSendInvite":
				{
					l__2 = SSendInvite(p__1);
					sendXtMessage("txh_ext", "sendInvite", {_cmd:"sendInvite", zid:l__2.zid, msg:l__2.msg, key:_key}, "xml");
					break;
				}
				case "SAddBuddy":
				{
					l__2 = SAddBuddy(p__1);
					sendXtMessage("txh_ext", "addBuddy", {_cmd:"addBuddy", zid:l__2.zid, key:_key}, "xml");
					break;
				}
				case "SAcceptBuddy":
				{
					l__2 = SAcceptBuddy(p__1);
					sendXtMessage("txh_ext", "acceptBuddy", {_cmd:"acceptBuddy", zid:l__2.zid, name:l__2.name, key:_key}, "xml");
					break;
				}
				case "SIgnoreBuddy":
				{
					l__2 = SIgnoreBuddy(p__1);
					sendXtMessage("txh_ext", "ignoreBuddy", {_cmd:"ignoreBuddy", zid:l__2.zid, key:_key}, "xml");
					break;
				}
				case "SIgnoreAllBuddy":
				{
					l__2 = SIgnoreAllBuddy(p__1);
					sendXtMessage("txh_ext", "ignoreAllBuddy", {_cmd:"ignoreAllBuddy", key:_key}, "xml");
					break;
				}
				case "SHideVIP":
				{
					l__2 = SHideVIP(p__1);
					sendXtMessage("gameRoom", "hideVIP", {_cmd:"hideVIP", hide:l__2.hide}, "xml");
					break;
				}
				case "SSendChat":
				{
					l__2 = SSendChat(p__1);
					smartfox.sendPublicMessage(l__2.sMsg);
					break;
				}
				case "SReportUser":
				{
					l__2 = SReportUser(p__1);
					sendXtMessage("gameRoom", "reportUser", {_cmd:"reportUser", uid_reporter:l__2.reporterZid, uid_abuser:l__2.abuserZid, userName:l__2.reporterName}, "xml");
					break;
				}
				case "SReport":
				{
					l__2 = SReport(p__1);
					sendXtMessage("txh_ext", "reportError", {_cmd:"reportError", periode:l__2.periode, mes:l__2.mes, rid:l__2.rid, key:_key}, "xml");
					break;
				}
				case "SAlertPublished":
				{
					l__2 = SAlertPublished(p__1);
					sendXtMessage("gameRoom", "alertPublished", {_cmd:"alertPublished", alertName:l__2.alertName}, "xml");
					break;
				}
				case "SGetShootoutConfig":
				{
					l__2 = SGetShootoutConfig(p__1);
					sendXtMessage("texasLogin", "getShootoutConfig", {_cmd:"getShootoutConfig"}, "xml");
					break;
				}
				case "SGetUserShootoutState":
				{
					l__2 = SGetUserShootoutState(p__1);
					sendXtMessage("texasLogin", "getUserShootoutState", {_cmd:"getUserShootoutState"}, "xml");
					break;
				}
				case "SToMainMenu":
				{
					l__2 = SToMainMenu(p__1);
					sendXtMessage("txh_ext", "toMainMenu", {_cmd:"toMainMenu", key:_key}, "xml");
					break;
				}
				case "SEventList":
				{
					l__2 = SEventList(p__1);
					sendXtMessage("txh_ext", "getTopEvent", {_cmd:"getTopEvent", key:_key}, "xml");
					break;
				}
				case "ScekxLogin":
				{
					sendXtMessage("txh_ext", "cekUserLogin", {_cmd:"cekUserLogin",paths:p__1.pathz,test:"ada", key:_key}, "xml");
					break;
				}
				case "ScekxLogin2":
				{
					sendXtMessage("txh_ext", "cekUserData", {_cmd:"cekUserData", key:_key}, "xml");
					break;
				}
				case "SGlobalJackotMoney":
				{	
						
					sendXtMessage("txh_ext", "cekGlobalJackpotMoney", {_cmd:"cekGlobalJackpotMoney", key:_key}, "xml");
					break;
				}
				case "SServerList":
				{
					sendXtMessage("txh_ext", "getServerList", {_cmd:"getServerList", key:_key}, "xml");
					break;
				}
				case "SCekChat":
				{
					sendXtMessage("txh_ext", "cekChat", {_cmd:"cekChat", key:_key}, "xml");
					break;
				}
			}
		}
		public function sendXtMessage(p__1:String, p__2:String, p__3:Object, p__4:String):void
		{
			smartfox.sendXtMessage(p__1, p__2, p__3);
		}
		public function getLobbyRooms():void
		{
			
			var param = new Object();
			param.key = _key
			//smartfox.sendXtMessage("texasLogin", "displayRoomList", {}, "xml");
			smartfox.sendXtMessage("txh_ext", "displayRoomList", param);
			
			
			//smartfox.sendXtMessage("txh_ext", "getServerList", param);
			
			
		}
		public function getLobbyRooms2():void
		{
			
				var l__12 = new Array();
				var l__13 = new Array();
				var l__14:com.script.poker.protocol.RDisplayRoomList = new RDisplayRoomList("RDisplayRoomList", l__12, l__13);
				dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__14));
		}
		public function onConnectionLost(p__1:SFSEvent):void
		{
			var l__2:com.script.poker.protocol.RConnectionLost = new RConnectionLost("RConnectionLost");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		public function onJoinRoomHandler(p__1:SFSEvent):void
		{
			
			var l__2:it.gotoandplay.smartfoxserver.data.Room = Room(p__1.params.room);
			var l__3:com.script.poker.protocol.RJoinRoom = new RJoinRoom();
			l__3.type = "RJoinRoom";
			l__3.roomName = l__2.getName();
			l__3.roomId = l__2.getId();
			var l__4 = l__3.roomName
			l__4 = l__4.split("H");
			var l__5 = l__4[1];			
			l__3.roomNo = l__5;
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__3));
			
		}
		private function onJoinRoomError(p__1:SFSEvent):void
		{
			var l__2:com.script.poker.protocol.RJoinRoomError = new RJoinRoomError("RJoinRoomError", p__1.params.error);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onAdminMessage(p__1:SFSEvent):void
		{
			var l__2:com.script.poker.protocol.RAdminMessage = new RAdminMessage("RAdminMessage", p__1.params.message);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		public function onRoomListUpdate(p__1:SFSEvent):void
		{
			var l__2:com.script.poker.protocol.RRoomListUpdate = new RRoomListUpdate();
			l__2.type = "RRoomListUpdate";
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		public function onPublicMessage(p__1:SFSEvent):void
		{
			var l__2:it.gotoandplay.smartfoxserver.data.User = User(p__1.params.sender);
			var l__3:String = l__2.getName();
			var l__4:String = l__2.getVariable("fullname");
			var l__5:String = p__1.params.message;
			var l__6:com.script.poker.protocol.RReceiveChat = new RReceiveChat("RReceiveChat", l__3, l__5, l__4);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__6));
		}
		public function trace_onExtensionHandler(p__1:SFSEvent):void
		{			
			var l__3:String;
			var l__2:Object = p__1.params.dataObj;
			for (l__3 in l__2){
			}
		}
		public function onExtensionHandler(p__1:SFSEvent):void
		{
			var l__2:Object = p__1.params.dataObj;
			switch(l__2._cmd){
				case "logOK":
				{
					//loginHandler(l__2);
					return;
				}
				case "cekLog":
				{
					loginHandler(l__2);
					return;
				}
				case "logData":
				{
					dataHandler(l__2);
					return;
				}
				case "logKO":
				{
					//loginHandler(l__2);
					return;
				}
				case "displayRoomList":
				{
					roomListHandler(l__2);
					return;
				}
				case "displayRoom":
				{
					roomHandler(l__2);
					return;
				}
			}
			switch(l__2[0]){
				case "roomPicked":
				{
					onRoomPicked(l__2);
					return;
				}
				case "buyIn":
				{
					onBuyIn(l__2);
					return;
				}
				case "pointsUpdate":
				{
					onPointsUpdate(l__2);
					return;
				}
				case "GlobalJackpotUpdate":
				{
					onGlobalJackpotUpdate(l__2);
					return;
				}
				case "tm":
				{
					onTM(l__2);
					return;
				}
				case "roomInfo":
				{
					onRoomInfo(l__2);
					return;
				}
				case "roomInfo2":
				{
					onRoomInfo2(l__2);
					return;
				}
				case "usersInRoom":
				{
					onUsersInRoom(l__2);
					return;
				}
				case "usersWaiting":
				{
					onUsersWaiting(l__2);
					return;
				}
				case "sitStructure":
				{
					onInitGameRoom(l__2);
					return;
				}
				case "initTourney":
				{
					onInitTourney(l__2);
					return;
				}
				case "createRoomRes":
				{
					onCreateRoomRes(l__2);
					return;
				}
				case "nopc":
				{
					onNOPC(l__2);
					return;
				}
				case "setmod":
				{
					onSetMod(l__2);
					return;
				}
				case "eventInfo":
				{
					onEventInfo(l__2);
					return;
				}
				case "gotoLobby":
				{
					onGoToLobby(l__2);
					return;
				}
				case "sitJoined":
				{
					onSitJoined(l__2);
					return;
				}
				case "sitTaken":
				{
					onSitTaken(l__2);
					return;
				}
				case "postBlind":
				{

					onPostBlind(l__2);
					return;
				}
				case "postBuyJackpot":
				{
					onPostBuyJackpot(l__2);
					return;
				}
				case "dealHoles":
				{
					onDealHoles(l__2);
					return;
				}
				case "raiseOption":
				{
					onRaiseOption(l__2);
					return;
				}
				case "callOption":
				{
					onCallOption(l__2);
					return;
				}
				case "markTurn":
				{
					onMarkTurn(l__2);
					return;
				}
				case "fold":
				{
					onFold(l__2);
					return;
				}
				case "call":
				{
					onCall(l__2);
					return;
				}
				case "allin":
				{
					onAllin(l__2);
					return;
				}
				case "flop":
				{
					onFlop(l__2);
					return;
				}
				case "street":
				{
					onStreet(l__2);
					return;
				}
				case "river":
				{
					onRiver(l__2);
					return;
				}
				case "makePot":
				{
					onMakePot(l__2);
					return;
				}
				case "sendGiftChips":
				{
					onSendGiftChips(l__2);
					return;
				}
				case "updateChips":
				{
					onUpdateChips(l__2);
					return;
				}
				case "refillPoints":
				{
					onRefillPoints(l__2);
					return;
				}
				case "outOfChips":
				{
					onOutOfChips(l__2);
					return;
				}
				case "winners":
				{
					onWinners(l__2);
					return;
				}
				case "userLost":
				{

					onUserLost(l__2);
					return;
				}
				case "allinwar":
				{
					onAllinWar(l__2);
					return;
				}
				case "clear":
				{
					onClear(l__2);
					return;
				}
				case "defaultWinner":
				{
					onDefaultWinners(l__2);
					return;
				}
				case "showJackpot":
				{
					onShowJackpot(l__2);
					return;
				}
				case "raise":
				{
					onRaise(l__2);
					return;
				}
				case "turnChanged":
				{
					onTurnChanged(l__2);
					return;
				}
				case "tover":
				{
					onTourneyOver(l__2);
					return;
				}
				case "bC":
				{
					onBlindChange(l__2);
					return;
				}
				case "buyinError":
				{
					onBuyinError(l__2);
					return;
				}			
				case "boughtGift":
				{
					onBoughtGift(l__2);
					return;
				}
				case "boughtGift2":
				{
					onBoughtGift2(l__2);
					return;
				}
				case "userGifts":
				{
					onUserGifts(l__2);
					return;
				}
				case "userGifts2":
				{
					onUserGifts2(l__2);
					return;
				}
				case "showedGift":
				{
					onGiftShown(l__2);
					return;
				}
				case "showedGift2":
				{
					onGiftShown2(l__2);
					return;
				}
				case "giftPrices":
				{
					onGiftPrices(l__2);
					return;
				}
				case "giftPrices2":
				{
					onGiftPrices2(l__2);
					return;
				}
				case "giftInfo2":
				{
					onGiftInfo2(l__2);
					return;
				}
				case "buyGiftTooExpensive":
				{
					onBuyGiftTooExpensive(l__2);
					return;
				}
				case "boughtEmo":
				{
					onBoughtEmo(l__2);
					return;
				}
				case "showMsg":
				{
					onShowMessage(l__2);
					
					return;
				}
				case "toMenu":
				{
					onToMenu(l__2);
					return;
				}
				case "roomPass":
				{
					onRoomPass(l__2);
					return;
				}
				case "replayCards":
				{
					onReplayCards(l__2);
					return;
				}
				case "replayHoles":
				{
					onReplayHoles(l__2);
					return;
				}
				case "replayPots":
				{
					onReplayPots(l__2);
					return;
				}
				case "replayPlayers":
				{
					onReplayPlayers(l__2);
					return;
				}
				case "inviteSend":
				{
					onInviteSend(l__2);
					return;
				}
				case "buddyRequest":
				{
					onBuddyRequest(l__2);
					return;
				}
				case "newBuddy":
				{
					onNewBuddy(l__2);
					return;
				}
				case "cardOptions":
				{
					onCardOptions(l__2);
					return;
				}
				case "getServer":
				{
					//serverListHandler(l__2);
					serverListHandler2(l__2);
					return;
				}
				case "getChat":
				{
					getChatHandler(l__2);
					return;
				}
				case "userVIP":
				{
					onUserVip(l__2);
					return;
				}
				case "userLevelUp":
				{
					onUserLevelUp(l__2);
					return;
				}
				case "achieved":
				{
					onAchieved(l__2);
					return;
				}
				case "alert":
				{
					
					onAlert(l__2);
					return;
				}
				case "shootoutConfig":
				{
					onShootoutConfig(l__2);
					return;
				}
				case "userShootoutState":
				{
					onUserShootoutState(l__2);
					return;
				}
				case "gameAlreadyStarted":
				{
					onGameAlreadyStarted(l__2);
					return;
				}
				case "alreadyPlayingShootout":
				{
					onAlreadyPlayingShootout(l__2);
					return;
				}
				case "sitPermissionRefused":
				{
					onSitPermissionRefused(l__2);
					return;
				}
				case "wrongRound":
				{
					onWrongRound(l__2);
					return;
				}
				case "wrongBuyin":
				{
					onWrongBuyin(l__2);
					return;
				}
				case "sitNotReserved":
				{
					onSitNotReserved(l__2);
					return;
				}
				case "shootoutBuyinChanged":
				{
					onShootoutBuyinChanged(l__2);
					return;
				}
				case "shootoutConfigChanged":
				{
					onShootoutConfigChanged(l__2);
					return;
				}
				case "playerBounced":
				{
					onPlayerBounced(l__2);
					return;
				}
				case "roundChanged":
				{
					onRoundChanged(l__2);
					return;
				}
				
			}
		}
		private function loginHandler(p__1:Object):void
		{
			var l__2:* = undefined;
			var l__3:String = p__1._cmd;
			
			
			switch(l__3){
				case "cekLog":
				{
					if (p__1.points == undefined) {
						return;
					}
					//l__2 = new RLogin();
					
					var l__2:com.script.poker.protocol.RLogin = new RLogin();
					l__2.type = "RLogin";
					l__2.bSuccess = true;
					l__2.name = p__1.name;
					l__2.playLevel = int(p__1.playLevel);
					l__2.points = Number(p__1.points);
					l__2.jt = p__1._jt;
					l__2.chipConvert = Number(p__1.chipConvert);
					l__2.deposit = Number(p__1.deposit);
					l__2.zid = p__1.email;
					l__2.usersText = p__1.runText;
					l__2.usersOnline = Number(p__1.usersOnline);
					l__2.rejoinRoom = int(p__1.rejoinRoom);
					l__2.flist = p__1.flist;
					l__2.badWords = p__1.badwords;
					l__2.curServer = p__1.curServer;
					l__2.chatStat = p__1.chatstat;
					l__2.chatPop = p__1.chatpop;
					l__2.gameInfo = p__1.gameinfo;
					
					//l__2.isVip = p__1.uservip;
					
					//l__2.type = "RRoomListUpdate";
					dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
					
					var l__3 = 0;
					var hasil;
					var id;
					var syarat:Object	= new Object();
					var kata_deposit;
					var uangpengirim;
					var userpengirim;
					var l__4 = new Object();
					
					if (p__1._depositPending > 0) {
						for (l__3=0; l__3<p__1._total; l__3++) {
							hasil	= p__1["_depositMsg"+l__3].split(",");
							id		= p__1["_id"+l__3];
							
							hasil[2] = Number(hasil[2])*p__1.chipConvert
							
							if (hasil[0] == "1"){
								uangpengirim = hasil[2];
								//mc_terima.gotoAndStop(2);
								kata_deposit = langs.l_newadddeposit+" "+hasil[2];
								//tandaTerima	= "+";
							}else if (hasil[0] == "2"){
								//mc_terima.gotoAndStop(3);
								userpengirim = hasil[1];
								uangpengirim = hasil[2];
								kata_deposit = langs.l_transferfrom+" "+userpengirim+" "+langs.l_amount+""+uangpengirim;
							}else if (hasil[0] == "3"){
								uangpengirim = hasil[2];
								//mc_terima.gotoAndStop(2);
								kata_deposit = langs.l_depositcorrection+" "+hasil[2];
								
								//tandaTerima	= "+";
							}else if (hasil[0] == "4"){
								uangpengirim = hasil[2].substr(1);
								//mc_terima.gotoAndStop(2);
								kata_deposit = langs.l_withdrawreject+", "+langs.l_amount+" "+uangpengirim;
								//tandaTerima	= "+";
							}else if (hasil[0] == "5"){
								uangpengirim = hasil[2];
								//mc_terima.gotoAndStop(2);
								kata_deposit = langs.l_withdraw+", "+langs.l_amount+" "+hasil[2]+"";
							}
							else if (hasil[0] == "6"){
								uangpengirim = hasil[2];
								//mc_terima.gotoAndStop(2);
								kata_deposit = langs.l_addbonusreferral+" "+hasil[2]+"";
							}
							else if (hasil[0] == "11"){
								uangpengirim = hasil[2];
								//mc_terima.gotoAndStop(2);
								kata_deposit = langs.l_refundchip+" "+hasil[2]+" "+langs.l_forperiode+" "+hasil[3]+" "+langs.l_intable+" "+hasil[4]+"";
							}
							l__4[0] = "showMsg"
							l__4[1] = "RShowMsg";
							l__4[2] = kata_deposit;
							l__4[3] = "";
							onShowMessage(l__4)
							
						}
						
						
						
					}
						
					l__2.isVip = (p__1.uservip == "1") ? true : false;
					l__2.vipName = p__1.vipname;
					//l__2.hideVip = (p__1.hideVip == "1") ? true : false;
					//l__2.vipDays = int(p__1.vipDays);
					//l__2.vipStatusMsg = int(p__1.vipStatusMsg);
					//l__2.bonus = Number(p__1.bonus);
					break;
				}
				case "logKO":
				{
					l__2 = new RLogKO("RLogKO", false, p__1.err, false);
					dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
					break;
				}
			}
			if (l__2 != null){
				dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
			}
			
			getLobbyRooms();//ditambah karena google tidak bisa load lobby diawal masuk game!
			
		}
		private function dataHandler(p__1:Object):void
		{
			var l__2:* = undefined;
			var l__3:String = p__1._cmd;
			
			
					if (p__1.points == undefined) {
						return;
					}
					//l__2 = new RLogin();
					var l__2:com.script.poker.protocol.RLogData = new RLogData();
					l__2.type = "RLogData";
					l__2.bSuccess = true;
					l__2.name = p__1.name;
					l__2.playLevel = int(p__1.playLevel);
					l__2.points = Number(p__1.points);
					l__2.deposit = Number(p__1.deposit);
					l__2.zid = p__1.email;
					l__2.usersText = p__1.runText;
					l__2.usersOnline = Number(p__1.usersOnline);
					l__2.rejoinRoom = int(p__1.rejoinRoom);
					l__2.flist = p__1.flist;
					
					
					//l__2.type = "RRoomListUpdate";
					dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
					var l__3 = 0;
					var hasil;
					var id;
					var syarat:Object	= new Object();
					var kata_deposit;
					var uangpengirim;
					var userpengirim;
					var l__4 = new Object();
					
					if (p__1._depositPending > 0) {
						for (l__3=0; l__3<p__1._total; l__3++) {
							hasil	= p__1["_depositMsg"+l__3].split(",");
							id		= p__1["_id"+l__3];
							
							hasil[2] = Number(hasil[2])*p__1.chipConvert
							
							if (hasil[0] == "1"){
								uangpengirim = hasil[2];
								//mc_terima.gotoAndStop(2);
								kata_deposit = langs.l_newadddeposit+" "+hasil[2];
								//tandaTerima	= "+";
							}else if (hasil[0] == "2"){
								//mc_terima.gotoAndStop(3);
								userpengirim = hasil[1];
								uangpengirim = hasil[2];
								kata_deposit = langs.l_transferfrom+" "+userpengirim+" "+langs.l_amount+""+uangpengirim;
							}else if (hasil[0] == "3"){
								uangpengirim = hasil[2];
								//mc_terima.gotoAndStop(2);
								kata_deposit = langs.l_depositcorrection+" "+hasil[2];
								
								//tandaTerima	= "+";
							}else if (hasil[0] == "4"){
								uangpengirim = hasil[2].substr(1);
								//mc_terima.gotoAndStop(2);
								kata_deposit = langs.l_withdrawreject+", "+langs.l_amount+" "+uangpengirim;
								//tandaTerima	= "+";
							}else if (hasil[0] == "5"){
								uangpengirim = hasil[2];
								//mc_terima.gotoAndStop(2);
								kata_deposit = langs.l_withdraw+", "+langs.l_amount+" "+hasil[2]+"";
							}
							else if (hasil[0] == "6"){
								uangpengirim = hasil[2];
								//mc_terima.gotoAndStop(2);
								kata_deposit = langs.l_addbonusreferral+" "+hasil[2]+"";
							}
							else if (hasil[0] == "11"){
								uangpengirim = hasil[2];
								//mc_terima.gotoAndStop(2);
								kata_deposit = langs.l_refundchip+" "+hasil[2]+" "+langs.l_forchip+" "+hasil[3]+" "+langs.l_intable+" "+hasil[4]+"";
							}
							l__4[0] = "showMsg"
							l__4[1] = "RShowMsg";
							l__4[2] = kata_deposit;
							l__4[3] = "";
							onShowMessage(l__4)
							
						}
						
						
						
					
						
					}
					
		}
		private function roomListHandler(p__1:Object):void
		{
			var l__2:Array = new Array();
			var l__3:int;
			while(l__3 < p__1.rooms.length){
				l__2.push(new RoomItem(p__1.rooms[l__3].split(",")));
				l__3++;
			}

			var l__6:Array = new Array();
			var l__5:int = 0;
			
			while(l__5 < p__1.cost.length){

				var l__7:Object = new Object();
				l__7.ket = p__1.cost[l__5].ket
				l__7.hari = p__1.cost[l__5].hari
				l__7.cost = p__1.cost[l__5].cost
				l__6.push(l__7);
				l__5++;
			}
			
			
			var l__4:com.script.poker.protocol.RDisplayRoomList = new RDisplayRoomList("RDisplayRoomList", l__2, l__6);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
			
			var param = new Object();
			param.key = _key			
			
			//smartfox.sendXtMessage("txh_ext", "getServerList", param);
		}
		private function serverListHandler(p__1:Object):void
		{
			var l__2:Array = new Array();
			var l__3:int;
						
			var l__4:com.script.poker.protocol.RServerList = new RServerList("RServerList", p__1[1], p__1[2], p__1[3], p__1[4], p__1[5]);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function getChatHandler(p__1:Object):void
		{
			var l__2:Array = new Array();
			var l__3:int;
						
			var l__4:com.script.poker.protocol.RGetChat = new RGetChat("RGetChat", p__1._stat, p__1._pop);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function serverListHandler2(p__1:Object):void
		{
			var l__2:Array = new Array();
			var l__3:int;

			var l__4:com.script.poker.protocol.RServerList = new RServerList("RServerList", p__1[1], p__1[2], p__1[3], p__1[4], p__1[5]);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function roomHandler(p__1:Object):void
		{
			
			var l__2:Array = new Array();
			var l__3:int;
			while(l__3 < p__1.rooms.length){
				l__2.push(new RoomItem(p__1.rooms[l__3].split(",")));
				l__3++;
			}
			
			var l__4:com.script.poker.protocol.RDisplayRoom = new RDisplayRoom("RDisplayRoom", l__2);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function onRoomPicked(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RRoomPicked = new RRoomPicked("RRoomPicked", int(p__1[2]), int(p__1[3]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onBuyIn(p__1:Object):void
		{
			
			var l__2:com.script.poker.protocol.RBuyIn = new RBuyIn("RBuyIn", Number(p__1[2]), Number(p__1[3]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onPointsUpdate(p__1:Object):void
		{
			
			var l__2:com.script.poker.protocol.RPointsUpdate = new RPointsUpdate("RPointsUpdate", Number(p__1[2]), Number(p__1[3]), Number(p__1[4]), Number(p__1[5]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
			//var l__3:com.script.poker = new RProduct("updatelist");
		}
		private function onGlobalJackpotUpdate(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RGlobalJackpotUpdate = new RGlobalJackpotUpdate("RGlobalJackpotUpdate", Number(p__1[2]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
			//var l__3:com.script.poker = new RProduct("updatelist");
		}
		private function onTM(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RTM = new RTM("RTM", Number(p__1[2]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onEventInfo(p__1:Object):void
		{
			var l__3:com.script.poker.protocol.REventInfo = new REventInfo("REventInfo", p__1._userList, p__1._poinList, p__1._mypoin, p__1._start, p__1._stop, p__1._rules, p__1._stat);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__3));
		}
		private function onRoomInfo(p__1:Object):void
		{
			p__1.splice(0, 3);
			var l__2:Array = p__1.concat();
			var l__3:com.script.poker.protocol.RRoomInfo = new RRoomInfo("RRoomInfo", l__2);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__3));
		}
		private function onRoomInfo2(inObj:Object):void
		{
			var oJSON:Object;
			var tList:Array;
			var msg:com.script.poker.protocol.RRoomInfo2;
			/*try {
				oJSON = JSON.decode(inObj[2]);
			} catch (ex:*) {
			}*/
			oJSON = inObj[2];
			
			if (oJSON != null){
				if (oJSON.players != null){
					tList = oJSON.players;
					msg = new RRoomInfo2("RRoomInfo2", tList);
					dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, msg));
				}
			}
		}
		private function onInitGameRoom(p__2:Object):void
		{
			
			var p__1 = p__2[1];
			var l__4:com.script.poker.PokerUser;
			var l__2:Array = new Array();
			var l__3:* = 2;
			while(l__3 < p__1.length){
				l__4 = new PokerUser(int(p__1[l__3]), p__1[(l__3 + 1)], Number(p__1[(l__3 + 2)]), p__1[(l__3 + 3)], p__1[(l__3 + 4)], Number(p__1[(l__3 + 5)]), int(p__1[(l__3 + 6)]), p__1[(l__3 + 7)], Number(p__1[(l__3 + 8)]).toString(), p__1[(l__3 + 9)], int(p__1[(l__3 + 10)]), p__1[(l__3 + 11)], p__1[(l__3 + 12)], int(p__1[(l__3 + 13)]), p__1[(l__3 + 14)], Number(p__1[(l__3 + 15)]), int(p__1[(l__3 + 16)]), int(p__1[(l__3 + 17)]), int(p__1[(l__3 + 18)]), int(p__1[(l__3 + 19)]), p__1[(l__3 + 20)], int(p__1[(l__3 + 21)]), int(p__1[(l__3 + 22)]));
				l__2.push(l__4);
				l__3 = (l__3 + 23);
			}
			
			var l__5:com.script.poker.protocol.RInitGameRoom = new RInitGameRoom("RInitGameRoom", l__2, p__2[3], p__2[4]);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__5));
		}
		/*private function onInitTourney(p__1:Object):void
		{
			
			var l__4:com.script.poker.PokerUser;
			var l__2:Array = new Array();
			var l__3:* = 3;
			while(l__3 < p__1.length){
				l__4 = new PokerUser(int(p__1[l__3]), p__1[(l__3 + 1)], Number(p__1[(l__3 + 2)]), p__1[(l__3 + 3)], p__1[(l__3 + 4)], Number(p__1[(l__3 + 5)]), int(p__1[(l__3 + 6)]), p__1[(l__3 + 7)], Number(p__1[(l__3 + 8)]).toString(), p__1[(l__3 + 9)], int(p__1[(l__3 + 10)]), p__1[(l__3 + 11)], p__1[(l__3 + 12)], int(p__1[(l__3 + 13)]), p__1[(l__3 + 14)], Number(p__1[(l__3 + 15)]), int(p__1[(l__3 + 16)]), int(p__1[(l__3 + 17)]), int(p__1[(l__3 + 18)]), int(p__1[(l__3 + 19)]), p__1[(l__3 + 20)], int(p__1[(l__3 + 21)]), int(p__1[(l__3 + 22)]));
				l__2.push(l__4);
				l__3 = (l__3 + 23);
			}
			var l__5:com.script.poker.protocol.RInitTourney = new RInitTourney("RInitTourney", l__2, String(p__1[2]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__5));
		}*/
		private function onCreateRoomRes(p__1:Object):void
		{
			
			var l__3:com.script.poker.protocol.RCreateRoomRes;
			var l__2:Array = new Array();
			if (p__1[1] != -1){
				l__2.push(new RoomItem(p__1[2].split(",")));
				l__3 = new RCreateRoomRes("RCreateRoomRes", int(p__1[1]), l__2, String(p__1[3]));
				dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__3));
			}
			
		}
		private function onNOPC(p__1:Object):void	
		{
			
			var l__2:com.script.poker.protocol.RNOPC = new RNOPC("RNOPC", Number(p__1[1]), Number(p__1[2]), Number(p__1[3]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onSetMod(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RSetMod = new RSetMod("RSetMod", Number(p__1[2]) > 0);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onLastPot(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RLastPot = new RLastPot("RLastPot");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onGoToLobby(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RGoToLobby = new RGoToLobby("RGoToLobby");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		
		private function onSitJoined(p__1:Object):void
		{		
			
			var l__2:com.script.poker.PokerUser = new PokerUser(int(p__1[5]), p__1[2], Number(p__1[4]), p__1[6], p__1[7], Number(p__1[8]), int(p__1[9]), p__1[10], Number(p__1[11]).toString(), p__1[12], int(p__1[13]), p__1[14], p__1[15], Number(p__1[16]), "joining", 0, int(p__1[17]), int(p__1[18]), int(p__1[19]), int(p__1[20]), p__1[21], int(p__1[22]), int(p__1[23]), Number(p__1[24]), p__1[26], String(p__1[27]), p__1[28]);
			var l__3:com.script.poker.protocol.RSitJoined = new RSitJoined("RSitJoined", l__2);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__3));
		}
		private function onSitTaken(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RSitTaken = new RSitTaken("RSitTaken");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onPostBlind(p__1:Object):void
		{
			
			var l__2:com.script.poker.protocol.RPostBlind = new RPostBlind("RPostBlind", int(p__1[2]), Number(p__1[3]), Number(p__1[4]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onPostBuyJackpot(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RPostBuyJackpot = new RPostBuyJackpot("RPostBuyJackpot", int(p__1[2]), Number(p__1[3]), Number(p__1[4]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onDealHoles(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RDealHoles = new RDealHoles("RDealHoles", int(p__1[2]), String(p__1[3]), Number(p__1[4]), String(p__1[5]), Number(p__1[6]), int(p__1[7]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onRaiseOption(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RRaiseOption = new RRaiseOption("RRaiseOption", Number(p__1[2]), Number(p__1[3]), Number(p__1[4]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onCallOption(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RCallOption = new RCallOption("RCallOption", Number(p__1[2]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onMarkTurn(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RMarkTurn = new RMarkTurn("RMarkTurn", Number(p__1[2]), Number(p__1[3]), Number(p__1[4]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onFold(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RFold = new RFold("RFold", int(p__1[2]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onCall(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RCall = new RCall("RCall", int(p__1[2]), Number(p__1[3]), Number(p__1[4]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onAllin(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RAllin = new RAllin("RAllin", int(p__1[2]), Number(p__1[3]), Number(p__1[4]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onAllinWar(p__1:Object):void
		{
			var l__5:Object;
			var l__2:Array = new Array();
			var l__3:* = 2;
			var l__1 = p__1[2];
			while(l__3 < l__1.length){
				l__5 = new Object();
				l__5.sit = int(l__1[l__3]);
				l__5.card1 = String(l__1[(l__3 + 1)]);
				l__5.tip1 = Number(l__1[(l__3 + 2)]);
				l__5.card2 = String(l__1[(l__3 + 3)]);
				l__5.tip2 = Number(l__1[(l__3 + 4)]);
				l__2.push(l__5);
				l__3 = (l__3 + 5);
			}
			var l__4:com.script.poker.protocol.RAllinWar = new RAllinWar("RAllinWar", l__2);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function onFlop(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RFlop = new RFlop("RFlop", String(p__1[2]), Number(p__1[3]), String(p__1[4]), Number(p__1[5]), String(p__1[6]), Number(p__1[7]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onStreet(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RStreet = new RStreet("RStreet", String(p__1[2]), Number(p__1[3]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onRiver(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RRiver = new RRiver("RRiver", String(p__1[2]), Number(p__1[3]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onMakePot(p__1:Object):void
		{
			var l__2:Array = new Array();
			var l__3:* = 3;
			while(l__3 < (int(p__1[2]) + 3)){
				l__2.push(Number(p__1[l__3]));
				l__3++;
			}
			var l__4:com.script.poker.protocol.RMakePot = new RMakePot("RMakePot", int(p__1[2]), l__2);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
			
		}
		private function onSendGiftChips(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RSendGiftChips = new RSendGiftChips("RSendGiftChips", Number(p__1[2]), Number(p__1[3]), Number(p__1[4]), Number(p__1[5]), Number(p__1[6]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onUpdateChips(p__1:Object):void
		{
			var l__5:Object;
			var l__2:Array = new Array();
			var l__3:* = 2;
			while(l__3 < p__1.length){
				l__5 = new Object();
				l__5.sit = int(p__1[l__3]);
				l__5.chips = Number(p__1[(l__3 + 1)]);
				l__5.total = Number(p__1[(l__3 + 2)]);
				l__2.push(l__5);
				l__3 = (l__3 + 3);
			}
			
			var l__4:com.script.poker.protocol.RUpdateChips = new RUpdateChips("RUpdateChips", l__2);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function onRefillPoints(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RRefillPoints = new RRefillPoints("RRefillPoints", int(p__1[2]), int(p__1[3]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onOutOfChips(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.ROutOfChips = new ROutOfChips("ROutOfChips");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}	
		private function onWinners(p__1:Object):void 
		{			
			var l__5:Object;
			var l__2:Array = new Array();
			var l__3:* = 4;
			var p__2:Array = p__1[2];
			var p__6 = p__1[5];
			while(l__3 < p__2.length){
				l__5 = new Object();
				l__5.sit = int(p__2[l__3]);
				l__5.chips = Number(p__2[(l__3 + 1)]);
				l__5.card1 = String(p__2[(l__3 + 2)]);
				l__5.tip1 = Number(p__2[(l__3 + 3)]);
				l__5.card2 = String(p__2[(l__3 + 4)]);
				l__5.tip2 = Number(p__2[(l__3 + 5)]);
				l__5.handString = p__2[(l__3 + 6)].split(":");
				l__5.fee = Number(p__2[(l__3 + 7)]);
				l__5.jackpot = Number(p__2[(l__3 + 8)]);
				l__5.gjackpot = Number(p__2[(l__3 + 9)]);
				
				
				l__2.push(l__5);
				l__3 = (l__3 + 10);
			}
			
			var l__4:com.script.poker.protocol.RWinners = new RWinners("RWinners", Number(p__2[2]), String(p__2[3]), l__2, Number(p__1[3]), Number(p__1[4]), p__6);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function onUserLost(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RUserLost = new RUserLost("RUserLost", int(p__1[2]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
			/*if (int(p__1[3]) == 1) {
				var URLmenu:URLRequest = new URLRequest("/menu.php");
				navigateToURL(URLmenu,"_self");
			}*/
		}
		private function onClear(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RClear = new RClear("RClear");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onDefaultWinners(p__1:Object):void
		{
			var l__2:Array = new Array();
			var l__3:* = 5;
			while(l__3 < p__1.length){
				l__2.push(Number(p__1[l__3]));
				l__3++;
			}
			var l__4:com.script.poker.protocol.RDefaultWinners = new RDefaultWinners("RDefaultWinners", int(p__1[2]), Number(p__1[3]), l__2, Number(p__1[4]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function onShowJackpot(p__1:Object):void
		{
			var l__2:Array = new Array();
			var l__3:* = 5;
			
			//var l__4:com.script.poker.protocol.RShowJackpot = new RDefaultWinners("RShowJackpot", String(p__1[2]), Number(p__1[3]), l__2, Number(p__1[4]));
			//dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function onRaise(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RRaise = new RRaise("RRaise", int(p__1[2]), Number(p__1[3]), Number(p__1[4]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onTurnChanged(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RTurnChanged = new RTurnChanged("RTurnChanged", int(p__1[2]), int(p__1[3]), int(p__1[4]), Number(p__1[5]), String(p__1[6]), Number(p__1[7]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onTourneyOver(p__1:Object):void
		{
			var l__2:Number = 0;
			var l__3:Number = 0;
			l__2 = Number(p__1[2]);
			if (!(p__1[3] == null) && !(p__1[3] == "nothing.")){
				l__3 = Number(p__1[3]);
			} else {
				l__3 = 0;
			}
			var l__4:com.script.poker.protocol.RTourneyOver = new RTourneyOver("RTourneyOver", l__2, l__3);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function onBlindChange(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RBlindChange = new RBlindChange("RBlindChange", Number(p__1[2]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onBuyinError(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RBuyinError = new RBuyinError("RBuyinError", Number(p__1[2]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onBoughtGift(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RBoughtGift = new RBoughtGift("RBoughtGift", Number(p__1[2]), Number(p__1[3]), Number(p__1[4]), Number(p__1[5]), Number(p__1[6]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onBoughtGift2(inObj:Object):void
		{
			/*var oJSON:Object;
			try {
				oJSON = JSON.decode(unescape(inObj[2]));
			} catch (ex:*) {
			}*/
			var oJSON:Object;
			oJSON = inObj;
			
			var msg:com.script.poker.protocol.RBoughtGift2 = new RBoughtGift2("RBoughtGift2", oJSON.fromSit, oJSON.giftId, oJSON.fromChips, oJSON.toSit, oJSON.totalChips);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, msg));
		}
		
		private function onBoughtEmo(inObj:Object):void
		{
			var oJSON:Object;
			oJSON = inObj;
			
			var msg:com.script.poker.protocol.RBoughtEmo = new RBoughtEmo("RBoughtEmo", oJSON.fromSit, oJSON.giftId, oJSON.fromChips, oJSON.toSit, oJSON.emoStr);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, msg));
		}
		
		private function onUserGifts(p__1:Object):void
		{
			var l__5:Object;
			var l__2:Array = new Array();
			var l__3:* = 3;
			while(l__3 < p__1.length){
				l__5 = new Object();
				l__5.type = Number(p__1[l__3]);
				l__5.number = Number(p__1[(l__3 + 1)]);
				l__5.name = String(p__1[(l__3 + 2)]);
				l__2.push(l__5);
				l__3 = (l__3 + 3);
			}
			var l__4:com.script.poker.protocol.RUserGifts = new RUserGifts("RUserGifts", Number(p__1[2]), l__2);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function onUserGifts2(inObj:Object):void
		{
			var oJSON:Object = new Object();
			oJSON.sit = inObj[2]
			var sObj = inObj[3]
			var aGifts:Array = new Array();
			var gift:Object;
			/*var gift:Object;
			try {
				oJSON = JSON.decode(unescape(inObj[2]));
			} catch (ex:*) {
			}
			var aGifts:Array = new Array();
			var i:int;*/
			var i:int = 0;
			while(i < sObj.length){
				gift = new Object();
				gift.giftId = sObj[i];
				gift.name = sObj[i+1];
				aGifts.push(gift);
				i = i + 2;
			}
			var msg:com.script.poker.protocol.RUserGifts2 = new RUserGifts2("RUserGifts2", oJSON.sit, aGifts);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, msg));
			
		}
		private function onGiftShown(p__1:Object):void
		{			
			var l__2:com.script.poker.protocol.RGiftShown = new RGiftShown("RGiftShown", Number(p__1[2]), Number(p__1[3]), Number(p__1[4]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onGiftShown2(inObj:Object):void
		{
			/*var oJSON:Object;
			try {
				oJSON = JSON.decode(unescape(inObj[3]));
			} catch (ex:*) {
			}*/
			var msg:com.script.poker.protocol.RGiftShown2 = new RGiftShown2("RGiftShown2", Number(inObj[2]), Number(inObj[3]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, msg));
		}
		private function onGiftPrices(p__1:Object):void
		{
			var l__2:Array = new Array();
			var l__3:* = 3;
			while(l__3 < p__1.length){
				if (p__1[l__3] != undefined){
					l__2.push(Number(p__1[l__3]));
				}
				l__3++;
			}
			var l__4:com.script.poker.protocol.RGiftPrices = new RGiftPrices("RGiftPrices", Number(p__1[2]), l__2);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function onGiftPrices2(inObj:Object):void
		{
			
			var oJSON:Object =new Object();
			oJSON.categoryId = inObj[2];
			oJSON.gifts = new Array();
			oJSON.categories = new Array();
			var category = new Array("Drink", "Snack", "Entertaiment")
			var b=0;
			var sObj = inObj[4]
			for(var a=0; a<3; a++) {
				b = a+1
				/*oJSON.gifts[a] = new Object();
				oJSON.gifts[a].id = b
				oJSON.gifts[a].price = ""
				oJSON.gifts[a].greyOut = 0;*/
				oJSON.categories[a] = new Object();
				oJSON.categories[a].id = b 
				oJSON.categories[a].name = category[a];
				
			}
			var l__3 = 0;
			var l__4 = 0
			while(l__3 < sObj.length) {
				oJSON.gifts[l__4] = new Object();
				oJSON.gifts[l__4].id = Number(sObj[l__3])
				oJSON.gifts[l__4].price = sObj[l__3+1]
				oJSON.gifts[l__4].greyOut = Number(sObj[l__3+2]);
								
				l__3 = (l__3 + 3);
				l__4 ++;
				
			}
			
			var msg:com.script.poker.protocol.RGiftPrices2 = new RGiftPrices2("RGiftPrices2", oJSON.categoryId, oJSON.gifts, oJSON.categories);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, msg));
		}
		
		private function onEmoShown(p__1:Object):void
		{			
			var l__2:com.script.poker.protocol.REmoShown = new REmoShown("REmoShown", Number(p__1[2]), Number(p__1[3]), Number(p__1[4]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		
		public function onEmoPrices(p__1:Number):void	
		{
			if (p__1 == -1) {
				p__1 = 1;
			}
			var oJSON:Object =new Object();
			oJSON.categoryId = p__1;
			oJSON.gifts = new Array();
			oJSON.categories = new Array();
			//var category = new Array("Emotion", "Room");
			var category = new Array("Emotion")
			var b=0;
			
			for(var a=0; a<1; a++) {
				b = a+1
				/*oJSON.gifts[a] = new Object();
				oJSON.gifts[a].id = b
				oJSON.gifts[a].price = ""
				oJSON.gifts[a].greyOut = 0;*/
				oJSON.categories[a] = new Object();
				oJSON.categories[a].id = b 
				oJSON.categories[a].name = category[a];
				
			}
			for(var c=0; c<emoLeng[p__1]; c++) {
				
				b = c+1
				oJSON.gifts[c] = new Object();
				oJSON.gifts[c].id = Number(p__1+"0"+b)
				oJSON.gifts[c].price = ""
				oJSON.gifts[c].greyOut = 0;
								
				
				
			}
			var msg:com.script.poker.protocol.REmoPrices = new REmoPrices("REmoPrices", oJSON.categoryId, oJSON.gifts, oJSON.categories);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, msg));
		}
		
		private function onGiftInfo2(inObj:Object):void
		{
			/*var oJSON:Object;
			try {
				oJSON = JSON.decode(unescape(inObj[2]));
			} catch (ex:*) {
			}*/
			var oJSON:Object =new Object();
			
			oJSON[0] = new Array();
			var sObj:Object = inObj[2];
			
			var l__3 = 0;
			while(l__3 < sObj.length) {
				
				jsObj = new Object();
				jsObj.id = Number(sObj[l__3]);
				jsObj.picLargeUrl = "gift/"+sObj[l__3+1];
				jsObj.picMediumUrl = "gift/"+sObj[l__3+2];
				jsObj.picSmallUrl = "gift/"+sObj[l__3+3];
				jsObj.picAs3Url = sObj[l__3+4];
				jsObj.as3Classname = sObj[l__3+5];
				jsObj.name = sObj[l__3+6];
				jsObj.actionText = sObj[l__3+7];
				jsObj.clientData = sObj[l__3+8];
				
				oJSON[0].push(jsObj);
				l__3 = (l__3 + 9);
			}
			
			
			//oJSON[0] = inObj[2]; 
			var msg:com.script.poker.protocol.RGiftInfo2 = new RGiftInfo2("RGiftInfo2", oJSON);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, msg));
		}
		public function onEmoInfo(p__1, p__2):void
		{	
			
			var oJSON:Object =new Object();
			
			oJSON[0] = new Array();
			
			var jsObj;
			var a=0;
			var b=0;
			var l__2;
			var emoList = p__1.children();
			var animList = p__2.children();
			for (l__2 in emoList){
				b = a+1;
				jsObj = new Object();
				jsObj.id = Number("10"+b);
				jsObj.picLargeUrl = "../images/txh/emo/np/"+emoList[l__2].attribute("handler")+".swf";
				jsObj.picMediumUrl = "../images/txh/emo/np/"+emoList[l__2].attribute("handler")+".jpg";
				jsObj.picSmallUrl = "../images/txh/emo/np/"+emoList[l__2].attribute("handler")+".swf";
				jsObj.picAs3Url = "";
				jsObj.as3Classname = "";
				jsObj.name = emoList[l__2].attribute("handler");
				jsObj.actionText = "ActionText"+a;
				jsObj.clientData = "clientData"+a;
				oJSON[0].push(jsObj);
				a++;
			}
			
			var l__5;
			var c=0;
			for (l__5 in animList){
				jsObj = new Object();
				b = c+1;
				jsObj.id = Number("20"+b);
				jsObj.picLargeUrl = "../images/txh/anim/np/"+animList[l__5].attribute("handler")+".swf";
				jsObj.picMediumUrl = "../images/txh/anim/np/"+animList[l__5].attribute("handler")+".jpg";
				jsObj.picSmallUrl = "../images/txh/anim/np/"+animList[l__5].attribute("handler")+".swf";
				jsObj.picAs3Url = "";
				jsObj.as3Classname = "";
				jsObj.name = animList[l__5].attribute("handler");
				jsObj.actionText = "ActionText"+c;
				jsObj.clientData = "clientData"+c;
				oJSON[0].push(jsObj);
				
				c++;
			}
			var msg:com.script.poker.protocol.REmoInfo = new REmoInfo("REmoInfo", oJSON);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, msg));
			
		}
		function onBuyGiftTooExpensive(p__1:Object):void
		{
			var l__2:Number = Number(parseInt(p__1[2]));
			var l__3:Number = Number(parseInt(p__1[3]));
			var l__4:com.script.poker.protocol.RGiftTooExpensive = new RGiftTooExpensive("RGiftTooExpensive", l__2, l__3);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		function DEBUG_traceJSONObject(p__1:*, p__2:String)
		{
			var l__3:* = undefined;
			if (p__2 == null){
				p__2 = "";
			}
			for (l__3 in p__1){
				DEBUG_traceJSONObject(p__1[l__3], (((p__2 + "[") + l__3) + "]"));
			}
		}
		private function onShowEvents(p__1:Object):void
		{
			var l__5:* = undefined;
			var l__2:Array = new Array();
			var l__3:* = 2;
			while(l__3 < p__1.length){
				l__5 = new Object();
				l__5.eType = Number(p__1[l__3]);
				l__5.fZid = String(p__1[(l__3 + 1)]);
				l__5.fName = String(p__1[(l__3 + 2)]);
				l__5.tZid = String(p__1[(l__3 + 3)]);
				l__5.tName = String(p__1[(l__3 + 4)]);
				l__5.gType = Number(p__1[(l__3 + 5)]);
				l__5.gNum = Number(p__1[(l__3 + 6)]);
				l__2.push(l__5);
				l__3 = (l__3 + 7);
			}
			var l__4:com.script.poker.protocol.RShowEvents = new RShowEvents("RShowEvents", l__2);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		
		private function onShowMessage(p__1:Object):void
		{	
			var alert_error ="";
			if(p__1[2] == "balance_problem"){
				alert_error = langs.l_balance_problem;
		  	}
			else if(p__1[2] == "game_maintenence"){
				alert_error = langs.l_game_maintenence;
		  	}
			else if(p__1[2] == "userid_used"){
				alert_error = langs.l_userid_used;
		  	}
			else if(p__1[2] == "room_closed"){
				alert_error = langs.l_room_closed;
		  	}
			else if(p__1[2] == "game_closed"){
				alert_error = langs.l_game_closed;
		  	}
			else if(p__1[2] == "less_buyin"){
				alert_error = langs.l_less_buyin;
		  	}
			else if(p__1[2] == "no_enough_balance"){
				alert_error = langs.l_no_enough_balance;
		  	}
			else if(p__1[2] == "sit_taken"){
				alert_error = langs.l_sit_taken;
		  	}
			else if(p__1[2] == "already_sit"){
				alert_error = langs.l_already_sit;
		  	}
			else if(p__1[2] == "no_enough_chip"){
				alert_error = langs.l_no_enough_chip;
		  	}
			else if(p__1[2] == "internal_error"){
				alert_error = langs.l_internal_error;
		  	}
			else if(Number(p__1[2]) > 0){
				alert_error =langs. l_fail_jp1+" "+p__1[2]+" "+langs. l_fail_jp2;
		  	}else{
				alert_error =p__1[2];
			}
			var l__2:com.script.poker.protocol.RShowMessage = new RShowMessage("RShowMessage", String(alert_error), String(p__1[3]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
			return;
		}
		private function onToMenu(p__1:Object):void
		{
			var URLmenu:URLRequest = new URLRequest("/menu.php");
			navigateToURL(URLmenu,"_self");
			return;
		}
		private function onRoomPass(p__1:Object):void
		{	
			var l__2:com.script.poker.protocol.RRoomPass = new RRoomPass("RRoomPass", Number(p__1[2]), String(p__1[3]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onReplayCards(p__1:Object):void
		{
			var l__5:Object;
			var l__2:Array = new Array();
			var l__3:* = 2;
			var l__6 = p__1[2];
			while(l__3 < l__6.length){
				l__5 = new Object();
				l__5.card = Number(l__6[l__3]);
				l__5.suit = Number(l__6[Number(l__3) + 1]);
				l__2.push(l__5);
				l__3 = (l__3 + 2);
				
			}
			var l__4:com.script.poker.protocol.RReplayCards = new RReplayCards("RReplayCards", l__2);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function onReplayHoles(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RReplayHoles = new RReplayHoles("RReplayHoles", Number(p__1[2]), Number(p__1[3]), Number(p__1[4]), Number(p__1[5]), Number(p__1[6]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onReplayPots(p__1:Object):void
		{
			var l__2:Array = new Array();
			var l__3:* = 3;
			while(l__3 < (Number(p__1[2]) + 3)){
				l__2.push(Number(p__1[l__3]));
				l__3++;
			}
			var l__4:com.script.poker.protocol.RReplayPots = new RReplayPots("RReplayPots", Number(p__1[2]), l__2);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function onReplayPlayers(p__1:Object):void
		{
			
			var l__2:Array = new Array();
			var l__3:* = 2;
			
			while(l__3 < p__1[1].length){
				l__2.push(Number(p__1[l__3]));
				l__3++;
			}			
			
			
			var l__4:com.script.poker.protocol.RReplayPlayers = new RReplayPlayers("RReplayPlayers", l__2);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__4));
		}
		private function onInviteSend(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RInviteSend = new RInviteSend("RInviteSend", String(p__1[2]), String(p__1[3]), String(p__1[4]), int(p__1[5]), int(p__1[6]), int(p__1[7]), String(p__1[8]), String(p__1[9]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onBuddyRequest(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RBuddyRequest = new RBuddyRequest("RBuddyRequest", int(p__1[2]), String(p__1[3]), String(p__1[4]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onNewBuddy(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RNewBuddy = new RNewBuddy("RNewBuddy", String(p__1[2]), String(p__1[3]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onCardOptions(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RCardOptions = new RCardOptions("RCardOptions", String(p__1[2]), String(p__1[3]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onUserVip(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RUserVip = new RUserVip("RUserVip", String(p__1[2]), Number(p__1[3]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onUserLevelUp(p__1:Object):void
		{
			
			var l__2:com.script.poker.protocol.RUserLevelUp = new RUserLevelUp("RUserLevelUp", Number(p__1[2]), Number(p__1[3]), Number(p__1[4]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onAchieved(inObj:Object):void
		{
			var oJSON:Object;
			var msg:com.script.poker.protocol.RAchieved;
			try {
				oJSON = JSON.decode(unescape(inObj[2]));
			} catch (ex:*) {
			}
			for (i in oJSON){
			}
			msg = new RAchieved("RAchieved", oJSON);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, msg));
		}
		private function onAlert(inObj:Object):void
		{
			var oJSON:Object;
			try {
				oJSON = JSON.decode(unescape(inObj[2]));
			} catch (ex:*) {
			}
			var msg:com.script.poker.protocol.RAlert = new RAlert("RAlert", unescape(inObj[2]), oJSON);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, msg));
		}
		
		private function onShootoutConfig(inObj:Object):void
		{
			var oJSON:Object;
			var shootoutObj:Object;
			try {
				oJSON = JSON.decode(unescape(inObj[2]));
			} catch (ex:*) {
			}
			for (i in oJSON){
			}
			shootoutObj = null;
			if (oJSON["shootout"] != undefined){
				shootoutObj = oJSON["shootout"];
			}
			var userObj:Object;
			if (oJSON["user"] != undefined){
				userObj = oJSON["user"];
			}
			var msg:com.script.poker.protocol.RShootoutConfig = new RShootoutConfig("RShootoutConfig", shootoutObj, userObj);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, msg));
		}
		private function onUserShootoutState(inObj:Object):void
		{
			var oJSON:Object;
			var userObj:Object;
			try {
				oJSON = JSON.decode(unescape(inObj[2]));
			} catch (ex:*) {
			}
			for (i in oJSON){
			}
			userObj = null;
			if (oJSON["user"] != undefined){
				userObj = oJSON["user"];
				
			}
			var msg:com.script.poker.protocol.RUserShootoutState = new RUserShootoutState("RUserShootoutState", userObj);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, msg));
		}
		private function onSFLogin(p__1:SFSEvent):void
		{
			var l__2:com.script.poker.protocol.RLogKO = new RLogKO("RLogKO", p__1.params.success, p__1.params.error, false);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onConnectionFailed(p__1:flash.events.Event):void
		{
			var l__2:com.script.poker.protocol.RLogKO = new RLogKO("RLogKO", false, "There is a problem connecting to the server. Please refresh your page and try again!", false);
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onGameAlreadyStarted(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RGameAlreadyStarted = new RGameAlreadyStarted("RGameAlreadyStarted");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onAlreadyPlayingShootout(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RAlreadyPlayingShootout = new RAlreadyPlayingShootout("RAlreadyPlayingShootout");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onSitPermissionRefused(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RSitPermissionRefused = new RSitPermissionRefused("RSitPermissionRefused");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onWrongRound(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RWrongRound = new RWrongRound("RWrongRound");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onWrongBuyin(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RWrongBuyin = new RWrongBuyin("RWrongBuyin");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onSitNotReserved(p__1:Object):void
		{			
			var l__2:com.script.poker.protocol.RSitNotReserved = new RSitNotReserved("RSitNotReserved");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onShootoutBuyinChanged(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RShootoutBuyinChanged = new RShootoutBuyinChanged("RShootoutBuyinChanged", Number(p__1[2]), Number(p__1[3]), Number(p__1[4]));
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onShootoutConfigChanged(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RShootoutConfigChanged = new RShootoutConfigChanged("RShootoutConfigChanged");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onPlayerBounced(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RPlayerBounced = new RPlayerBounced("RPlayerBounced");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
		private function onRoundChanged(p__1:Object):void
		{
			var l__2:com.script.poker.protocol.RRoundChanged = new RRoundChanged("RRoundChanged");
			dispatchEvent(new ProtocolEvent(ProtocolEvent.onMessage, l__2));
		}
	}
}
