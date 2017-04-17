// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.zoom
{
	
	import com.script.poker.UserPresence;
	import flash.events.*;
	public class ZshimModel extends flash.events.EventDispatcher
	{
			trace("astralll");
		public var friendsList:Array = new Array();
		public var networkList:Array = new Array();
		public static var ZOOM_MODEL_NETWORK_UPDATED:String = "zoom_model_network_updated";
		public static var ZOOM_MODEL_FRIENDS_UPDATED:String = "zoom_model_friends_updated";
		public function ZshimModel()
		{
		}
		public function addPlayer(p__1:com.script.poker.UserPresence, p__2:String = "friends"):void
		{
			friendsList.push(p__1);
			fnSortBy("friends");
			dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED, friendsList));
			
		}
		public function deletePlayer(p__1:com.script.poker.UserPresence, p__2:String = "friends"):void
		{
			var l__4:com.script.poker.UserPresence;
			var l__5:com.script.poker.UserPresence;
			var l__3:Number;
			if (p__2 == "friends"){
				l__3 = 0;
				while(l__3 < friendsList.length){
					l__4 = friendsList[l__3];
					if (l__4.sZid == p__1.sZid){
						friendsList.splice(l__3, 1);
						dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED, friendsList));
						break;
					}
					l__3++;
				}
			} else if (p__2 == "network"){
				l__3 = 0;
				while(l__3 < networkList.length){
					l__5 = networkList[l__3];
					if (l__5.sZid == p__1.sZid){
						networkList.splice(l__3, 1);
						dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_NETWORK_UPDATED, networkList));
						break;
					}
					l__3++;
				}
			}
		}
		public function updatePlayer(p__1:com.script.poker.UserPresence, p__2:String = "friends"):void
		{
			var l__4:com.script.poker.UserPresence;
			//var l__5:com.script.poker.UserPresence;
			var l__3:Number;
			if (p__2 == "friends"){
				l__3 = 0;
				while(l__3 < friendsList.length){
					l__4 = friendsList[l__3];
					if (l__4.sZid == p__1.sZid){

						l__4.nServerId = p__1.nServerId;
						l__4.nRoomId = p__1.nRoomId;
						l__4.sRoomDesc = p__1.sRoomDesc;
						l__4.tableStakes = p__1.tableStakes;
						break;
					}
					l__3++;
				}
				dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED, friendsList));
				
			}  
		}
		public function clearPlayer(p__1:String = "friends"):void
		{
			
			if (p__1 == "friends"){
				friendsList.splice(0, friendsList.length);
				dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_FRIENDS_UPDATED, friendsList));
			} else if (p__1 == "network"){
				networkList.splice(0, networkList.length);
				dispatchEvent(new ZshimModelEvent(ZshimModel.ZOOM_MODEL_NETWORK_UPDATED, networkList));
			}
		}
		public function isPlayerExist(p__1:com.script.poker.UserPresence, p__2:Array):Boolean
		{
			var l__3:com.script.poker.UserPresence;
			i = 0;
			while(i < p__2.length){
				l__3 = p__2[i];
				if (l__3.sZid == p__1.sZid){
					return(true);
				}
				i++;
			}
			return(false);
		}
		private function fnSortBy(p__1:String):void
		{
			var l__4:com.script.poker.UserPresence;
			var l__5:com.script.poker.UserPresence;
			var l__6:com.script.poker.UserPresence;
			var l__7:com.script.poker.UserPresence;
			var l__2:int;
			var l__3:int;
			if (p__1 == "friends"){
				l__2 = 0;
				while(l__2 < friendsList.length){
					l__3 = 0;
					while(l__3 < (friendsList.length - 1)){
						l__4 = friendsList[l__3];
						l__5 = friendsList[(l__3 + 1)];
						if (l__4.sFirstName > l__5.sFirstName){
							l__6 = l__5;
							friendsList[(l__3 + 1)] = l__4;
							friendsList[l__3] = l__6;
						}
						l__3++;
					}
					l__2++;
				}
			} else {
				l__2 = 0;
				while(l__2 < networkList.length){
					l__3 = 0;
					while(l__3 < (networkList.length - 1)){
						l__4 = networkList[l__3];
						l__5 = networkList[(l__3 + 1)];
						if (l__4.sFirstName > l__5.sFirstName){
							l__7 = l__5;
							networkList[(l__3 + 1)] = l__4;
							networkList[l__3] = l__7;
						}
						l__3++;
					}
					l__2++;
				}
			}
		}
	}
trace("astrall2");
}