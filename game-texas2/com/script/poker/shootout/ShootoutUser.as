// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.shootout
{
	public class ShootoutUser
	{
		public var nBuyin:Number = 0;
		public var nRound:Number = 1;
		public var bPlaying:Boolean = false;
		public var nWonCount:Number = 0;
		public var sLastPlayed:String = "";
		public var nShootoutId:Number = 0;
		public function ShootoutUser()
		{
		}
		public function updateUser(p__1:Boolean, p__2:String, p__3:Number, p__4:Number, p__5:Number, p__6:Number)
		{
			bPlaying = p__1;
			sLastPlayed = p__2;
			nRound = p__3;
			nWonCount = p__4;
			nShootoutId = p__5;
			nBuyin = p__6;
		}
	}
}