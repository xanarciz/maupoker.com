// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import fl.managers.IFocusManager;
	public class RTurnChanged
	{
		public var type:String;
		public var sit:int;
		public var handId:int;
		public var periode:int;
		public var jackpot:Number;
		public var bjackpot:String;
		public var globaljackpot:Number;
		public function RTurnChanged(p__1:String, p__2:int, p__3:int, p__4:int, p__5:Number, p__6:String, p__7:Number)
		{
			type = p__1;
			sit = p__2;
			handId = p__3;
			periode = p__4;
			jackpot = p__5;
			
			bjackpot = p__6;
			trace(bjackpot+"bacang");
			globaljackpot = p__7;
		}
	}
}