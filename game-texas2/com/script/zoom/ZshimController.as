// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.zoom
{
	import com.script.poker.UserPresence;
	import flash.net.Socket;
	import flash.events.*;
	import flash.system.*;
	import flash.utils.ByteArray;
	import com.script.zoom.messages.*;
	public class ZshimController extends flash.events.EventDispatcher
	{
		private var port:Number = -1;
		private var inBuffer:String = "";
		private var connected:Boolean = false;
		private var user:com.script.poker.UserPresence = null;
		private var doReconnect:Boolean = false;
		private var password:String = "";
		private var host:String = "";
		private var commandBuffer:Array = new Array();
		private var msgQ:Array = new Array();
		private var socket:flash.net.Socket = null;
		public static const ZOOM_CLEAR:String = "zoom_clear";
		public static const ZOOM_ADD_NETWORK:String = "zoom_add_network";
		public static const ZOOM_ADD_FRIEND:String = "zoom_add_friend";
		private static var mSingletonInst:com.script.zoom.ZshimController = null;
		public static const ZOOM_REMOVE_FRIEND:String = "zoom_remove_friend";
		public static const ZOOM_UPDATE:String = "zoom_update";
		public static const ZOOM_TABLE_INVITATION:String = "zoom_table_invitation";
		public static const ZOOM_REMOVE_NETWORK:String = "zoom_remove_network";
		public function ZshimController(p__1:ZshimController_SingletonLockingClass)
		{
			if (mSingletonInst || (p__1 == null)){
				throw new Error("ZshimController class cannot be instantiated");
			}
			mSingletonInst = this;
		}
		private function bind(p__1:String, p__2:int, p__3:String, p__4:com.script.poker.UserPresence):void
		{
			if ((!(host == p__1) || !(port == p__2)) || !(p__3 == p__3)){
				doReconnect = true;
				host = p__1;
				port = p__2;
				password = p__3;
			}
			if (user == null){
				user = p__4;
			} else {
				updateGameInfo(p__4.nServerId, p__4.nRoomId, p__4.sRoomDesc, p__4.tableStakes);
			}
		}
		public function isConnected():Boolean
		{
			return(this.connected);
		}
		public function sendTableInvitation(p__1:String):void
		{
			if (p__1){
				this.sendMsg(("1 ochat private " + p__1) + " tableInvitation");
			}
		}
		public function updateGameInfo(p__1:Number, p__2:Number, p__3:String, p__4:String = ""):void
		{
			if (((user.nServerId == p__1) && (user.nRoomId == p__2)) && (user.tableStakes == p__4)){
				return;
			}
			user.nServerId = p__1;
			user.nRoomId = p__2;
			user.sRoomDesc = p__3;
			user.tableStakes = p__4;
			var l__5:String = user.nServerId;
			l__5 = (l__5 + (" " + user.nRoomId));
			l__5 = (l__5 + (" " + user.sRoomDesc));
			if (p__4 != ""){
				l__5 = (l__5 + (" " + p__4));
			} else {
			}
			sendMsg((("1 update " + user.sZid) + " both gameInfo:") + encodeURIComponent(l__5));
		}
		private function getSessionCommand():String
		{
			var l__2:Array;
			var l__1:Array = new Array("3", "session");
			l__1.push(user.sZid);
			l__1.push(user.nGameId);
			l__1.push(user.sFriendIds ? user.sFriendIds : "n/a");
			l__1.push(user.sNetworkIds ? user.sNetworkIds : "n/a");
			l__1.push("n/a");
			l__1.push("name:" + encodeURIComponent(((user.sFirstName ? user.sFirstName : "n/a") + " ") + (user.sLastName ? user.sLastName : "n/a")));
			if (user.sPicURL){
				l__1.push("image:" + encodeURIComponent(user.sPicURL));
			}
			l__1.push("gameInfo:" + encodeURIComponent((((((user.nServerId + " ") + user.nRoomId) + " ") + user.sRoomDesc) + " ") + user.tableStakes));
			if (password){
				l__2 = password.split(":");
				if (l__2.length == 2){
					l__1.push("SKEY:" + l__2[0]);
					l__1.push("timestamp:" + l__2[1]);
				}
			}
			return(l__1.join(" "));
		}
		public function connect():void
		{
			/*if ((host == null) || (port == -1)){
				return;
			}
			if (doReconnect && !(socket == null)){
				socket.close();
			}
			doReconnect = false;
			if ((socket == null) || (!socket.connected)){
				Security.loadPolicyFile(("xmlsocket://" + host) + ":843");
				msgQ.splice(0, 0, getSessionCommand());*/
				try {
					socket = new Socket(host, port);
					socket.addEventListener(IOErrorEvent.IO_ERROR, onSocketIOError);
					socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSocketSecurityError);
					socket.addEventListener(Event.CONNECT, onSocketConnect);
					socket.addEventListener(Event.CLOSE, onSocketClose);
					socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
				} catch (error:Error) {
				}
			//}
		}
		public function disconnect():void
		{
			sendMsg("quit");
		}
		private function sendMsg(p__1:String):void
		{
			msgQ.push(p__1);
			if (connected){
				processMsg();
			}
		}
		private function consolidateCommands():void
		{
			var l__3:String;
			var l__5:Array;
			var l__1:Boolean;
			var l__2:* = "";
			var l__4:Array = new Array();
			while(msgQ.length > 0){
				l__3 = msgQ.shift();
				l__5 = l__3.split(" ");
				if ((l__5.length > 1) && (l__5[1] == "session")){
					l__1 = true;
				} else if ((l__5.length > 1) && (l__5[1] == "update")){
					l__2 = l__3;
				} else {
					l__4.push(l__3);
				}
			}
			if (l__1){
				l__4.splice(0, 0, getSessionCommand());
			} else if (l__2.length > 0){
				l__4.splice(0, 0, l__2);
			}
			msgQ.splice(0, msgQ.length, l__4);
		}
		private function processMsg():void
		{
			var l__1:String;
			consolidateCommands();
			while(msgQ.length > 0){
				l__1 = msgQ.shift();
				socket.writeUTFBytes(l__1);
				socket.writeByte(0);
				socket.flush();
			}
		}
		private function onSocketSecurityError(p__1:flash.events.SecurityErrorEvent):void
		{
		}
		private function onSocketIOError(p__1:flash.events.IOErrorEvent):void
		{
		}
		private function onSocketConnect(p__1:flash.events.Event):void
		{
			connected = true;
			processMsg();
		}
		private function onSocketClose(p__1:flash.events.Event):void
		{
			connected = false;
			dispatchEvent(new ZshimEvent(ZshimController.ZOOM_CLEAR, null));
		}
		private function printUser(p__1:com.script.poker.UserPresence):void
		{
		}
		private function getUserPresence(p__1:String, p__2:Number, p__3:String, p__4:String, p__5:String, p__6:String):com.script.poker.UserPresence
		{
			var l__15:* = undefined;
			var l__7:Number = -1;
			var l__8:Number = -1;
			var l__9:* = "Lobbyza";
			var l__10:Array = decodeURIComponent(p__3).split(" ");
			var l__11:* = "";
			if (l__10.length >= 3){
				if (p__3.indexOf(":", 0) != -1){
					l__15 = l__10[0].split(":");
					l__7 = (l__10[0] == "n/a") ? -1 : l__15[1];
				} else {
					l__7 = (l__10[0] == "n/a") ? -1 : l__10[0];
				}
				l__8 = (l__10[1] == "n/a") ? -1 : l__10[1];
				l__9 = (l__10[2] == "n/a") ? "Texas room" : l__10[2];
				if (l__10[3] != null){
					l__11 = l__10[3];
				} else {
				}
			}
			var l__12:Array = decodeURIComponent(p__4).split(" ");
			var l__13:String = p__4;
			var l__14:* = "";
			if (l__12.length >= 2){
				l__13 = (l__12[0] == "n/a") ? "" : l__12[0];
				l__14 = (l__12[1] == "n/a") ? "" : l__12[1];
			}
			return(new UserPresence(p__1, p__2, l__7, l__8, l__9, l__13, l__14, "", p__5, "", p__6, l__11));
		}
		private function onSocketData(p__1:flash.events.ProgressEvent):void
		{
			var l__2:flash.utils.ByteArray = new ByteArray();
			socket.readBytes(l__2, 0, socket.bytesAvailable);
			var l__3 = 0;
			while(l__3 < l__2.length){
				if (l__2[l__3] != 0){
					inBuffer = (inBuffer + String.fromCharCode(l__2[l__3]));
				} else {
					commandBuffer.push(inBuffer);
					inBuffer = "";
				}
				l__3++;
			}
			processCommand();
		}
		private function processCommand():void
		{
			var l__1:String;
			var l__2:Array;
			var l__3:String;
			var l__4:com.script.poker.UserPresence;
			var l__5:Array;
			var l__6:* = undefined;
			var l__7:Array;
			var l__8:String;
			var l__9:Array;
			var l__10:* = undefined;
			var l__11:Array;
			var l__12:com.script.poker.UserPresence;
			var l__13:Array;
			var l__14:String;
			var l__15:String;
			while(commandBuffer.length > 0){
				l__1 = commandBuffer.shift();
				l__2 = l__1.split(" ");
				l__3 = l__2[0];
				switch(l__3){
					case "pres":
					{
						if (l__2[3] == "on"){
							l__4 = getUserPresence(l__2[1], l__2[2], l__2[6], l__2[4], l__2[5], "");
							dispatchEvent(new ZshimEvent(ZshimController.ZOOM_ADD_FRIEND, l__4));
						} else {
							l__4 = getUserPresence(l__2[1], user.nGameId, "", "", "", "");
							dispatchEvent(new ZshimEvent(ZshimController.ZOOM_REMOVE_FRIEND, l__4));
						}
						break;
					}
					case "groupIdList":
					{
						l__5 = l__2[2].split(":::");
						l__6 = 0;
						while(l__6 < l__5.length){
							l__7 = l__5[l__6].split("::");
							l__8 = l__7[0];
							l__9 = l__7[1].split(",");
							l__10 = 0;
							while(l__10 < l__9.length){
								l__11 = l__9[l__10].split("&");
								l__12 = getUserPresence(l__11[0], user.nGameId, l__11[3], l__11[1], l__11[2], l__8);
								if (user.sZid != l__12.sZid){
									dispatchEvent(new ZshimEvent(ZshimController.ZOOM_ADD_NETWORK, l__12));
								}
								l__10++;
							}
							l__6++;
						}
						break;
					}
					case "presLogon":
					{
						l__13 = decodeURIComponent(l__2[3]).split("&");
						l__12 = getUserPresence(l__2[1], user.nGameId, l__13[2], l__13[0], l__13[1], l__2[2]);
						dispatchEvent(new ZshimEvent(ZshimController.ZOOM_ADD_NETWORK, l__12));
						break;
					}
					case "presLogoff":
					{
						dispatchEvent(new ZshimEvent(ZshimController.ZOOM_REMOVE_NETWORK, getUserPresence(l__2[1], user.nGameId, "", "", "", "")));
						break;
					}
					case "updateNotify":
					{
						dispatchEvent(new ZshimEvent(ZshimController.ZOOM_UPDATE, getUserPresence(l__2[1], user.nGameId, l__2[2], "", "", "")));
						break;
					}
					case "ichat":
					{
						l__14 = String(l__2[3]);
						switch(l__14){
							case "tableInvitation":
							{
								l__15 = String(l__2[2]);
								dispatchEvent(new ZshimEvent(ZshimController.ZOOM_TABLE_INVITATION), new ZoomTableInvitationMessage(l__15));
								break;
							}
						}
						break;
					}
				}
			}
		}
		public static function getInstance(p__1:String, p__2:int, p__3:String, p__4:com.script.poker.UserPresence):com.script.zoom.ZshimController
		{
			var l__5:com.script.zoom.ZshimController;
			if (p__4 == null){
				throw new Error("ZshimController.getInstance: invalid UserPresence");
			}
			if (!mSingletonInst){
				l__5 = new ZshimController(new ZshimController_SingletonLockingClass());
			}
			mSingletonInst.bind(p__1, p__2, p__3, p__4);
			return(mSingletonInst);
		}
	}
}

	import com.script.zoom.*;
	import com.script.poker.UserPresence;
	import flash.net.Socket;
	import flash.events.*;
	import flash.system.*;
	import flash.utils.ByteArray;
	import com.script.zoom.messages.*;

class ZshimController_SingletonLockingClass
{
	function ZshimController_SingletonLockingClass()
	{
	}
}
