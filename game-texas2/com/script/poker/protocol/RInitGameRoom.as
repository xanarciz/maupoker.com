// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.table.events.view.TVERefreshJoinUserPressed;
	public class RInitGameRoom
	{
		public var type:String;
		public var aUsers:Array;
		public var jackpot:Number;
		public var payRate:Array;
		public function RInitGameRoom(p__1:String, p__2:Array, p__3:Number, p__4:Array)
		{
			type = p__1;
			aUsers = p__2;
			jackpot = p__3;
			payRate = p__4;
		}
	}
}