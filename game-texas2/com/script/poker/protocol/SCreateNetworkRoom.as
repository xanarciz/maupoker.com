// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	public class SCreateNetworkRoom
	{
		public var type:String;
		public var password:String;
		public var roomName:String;
		public var gid:Number;
		public var smallBlind:Number;
		public var maxBuyin:Number;
		public var maxPlayers:Number;
		public var bigBlind:Number;
		public function SCreateNetworkRoom(p__1:String, p__2:String, p__3:String, p__4:Number, p__5:Number, p__6:Number, p__7:Number, p__8:Number)
		{
			type = p__1;
			roomName = p__2;
			password = p__3;
			smallBlind = p__4;
			bigBlind = p__5;
			maxBuyin = p__6;
			maxPlayers = p__7;
			gid = p__8;
		}
	}
}