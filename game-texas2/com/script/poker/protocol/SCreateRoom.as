// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	public class SCreateRoom
	{
		public var sPass:String;
		public var type:String;
		public var nBigBlind:Number;
		public var sName:String;
		public var nMaxPlayers:Number;
		public var nMaxBuyIn:Number;
		public var nSmallBlind:Number;
		public var nCost:Number;
		public function SCreateRoom(p__1:String, p__2:String, p__3:String, p__4:Number, p__5:Number, p__6:Number, p__7:Number)
		{
			type = p__1;
			sName = p__2;
			sPass = p__3;
			nSmallBlind = p__4;
			nBigBlind = p__5;
			nMaxPlayers = p__6;
			nMaxBuyIn = nSmallBlind * 400;
			nCost = p__7;
		}
	}
}