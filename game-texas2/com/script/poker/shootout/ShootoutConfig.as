// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.shootout
{
	public class ShootoutConfig
	{
		public var nId:Number = 0;
		public var nPlayers:Number = 9;
		public var aPayouts:Array = new Array();
		public var nIdVersion:Number = 0;
		public var sLastModified:String = "";
		public var nRounds:Number = 3;
		public var aWinnersCount:Array = new Array();
		public var nBuyin:Number = 500;
		public function ShootoutConfig()
		{
		}
		public function updateConfig(p__1:Number, p__2:Number, p__3:String, p__4:Number, p__5:Number, p__6:Number, p__7:Array, p__8:Array)
		{
			nId = p__1;
			nIdVersion = p__2;
			sLastModified = p__3;
			nBuyin = p__4;
			nRounds = p__5;
			nPlayers = p__6;
			aWinnersCount = p__7;
			aPayouts = p__8;
		}
	}
}