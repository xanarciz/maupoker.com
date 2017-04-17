// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	public class RWinners
	{
		public var type:String;
		public var pot:Number;
		public var winningHands:Array;
		public var winningHand:String;
		public var curJackpot:Number;
		public var curGJackpot:Number;
		public var loseJackpot:String;
		public function RWinners(p__1:String, p__2:Number, p__3:String, p__4:Array, p__5:Number, p__6:Number, p__7:String)
		{
			type = p__1;
			pot = p__2;
			winningHand = p__3;
			winningHands = p__4;
			curJackpot = p__5;
			curGJackpot = p__6;
			
			loseJackpot = p__7;
			trace(loseJackpot+"aaaaaaaaaaaa");
		}
	}
}