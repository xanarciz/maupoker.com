// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.lobby.events.controller.JoinTableEvent;
	public class RRaiseOption
	{
		public var type:String;
		public var chipsCall:Number;
		public var maxVal:Number;
		public var minVal:Number;
		public function RRaiseOption(p__1:String, p__2:Number, p__3:Number, p__4:Number)
		{
			type = p__1;
			chipsCall = p__2;
			minVal = p__3;
			maxVal = p__4;
		}
	}
}