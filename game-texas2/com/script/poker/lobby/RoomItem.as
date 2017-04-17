// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby
{
	public class RoomItem
	{
		
		private var _prizes:String;
		public var gid:Number = 0;
		public var roomName:String;
		public var users:Number = 0;
		public var maxUsers:Number = 0;
		public var smallBlind:Number = 0;
		public var _status:String;
		public var gameType:String;
		public var id:Number = 0;
		public var lastPot:Number = 0;
		public var prizes:Array;
		public var maxBuyin:Number = 0;
		public var maxPlayers:Number = 0;
		public var tableType:String;
		public var playersList:Array;
		public var players:Number = 0;
		public var entryFee:Number = 0
		public var bigBlind:Number = 0;
		public var no:Number = 0;
		public var tabowner:String;
		public var tid:Number = 0;
		public var buyinCost:Number = 0;
		public var status:Boolean;
		public var hostFee:Number = 0;
		public var tableCost:Array;
		public var jackpot:Number = 0;
		public var pubId:Number = 0;
		public function RoomItem(p__1:Array)
		{
			var l__2:Array = ["roomName", "id", "users", "maxUsers", "players", "smallBlind", "bigBlind", "gameType", "entryFee", "hostFee", "maxBuyin", "maxPlayers", "jackpot", "_prizes", "_status", "tableType", "gid", "lastPot", "no", "tabowner", "pubId"];
			var l__3:Array = ["id", "users", "maxUsers", "players", "smallBlind", "bigBlind", "entryFee", "hostFee", "maxBuyin", "maxPlayers", "jackpot", "lastPot", "no", "_status", "pubId"];
			var l__4:*;
			l__4 = 0;
			while(l__4 < l__2.length){
				this[l__2[l__4]] = p__1[l__4];
				l__4++;
			}
			for (l__4 in l__3){
				this[l__3[l__4]] = parseFloat(this[l__3[l__4]]);
			}
			
			this.prizes = this._prizes.split("/");
			for (l__4 in this.prizes){
				this.prizes[l__4] = this.prizes[l__4];
			}
			if ((!(this._status == null) && !(this._status == "")) && (this._status.length > 0)){
				this.status = (this._status == "0") ? false : true;
			}
		}
		public function refresh(p__1:Array)
		{
			var l__3:* = undefined;
			this.playersList = new Array();
			var l__2:*;
			while(l__2 < (p__1.length)){
				l__3 = new Object(); 
				l__3.chips = p__1[(l__2 + 1)];
				l__3.name = p__1[l__2];
				this.playersList.push(l__3);
				l__2 = (l__2 + 2);
			}
		}
	}
}