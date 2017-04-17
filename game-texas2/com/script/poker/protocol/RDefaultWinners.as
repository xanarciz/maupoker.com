// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import fl.events.DataChangeEvent;
	public class RDefaultWinners
	{
		public var type:String;
		public var sit:int;
		public var chips:Number;
		public var fee:Number;
		public var pots:Array;
		public function RDefaultWinners(p__1:String, p__2:int, p__3:Number, p__4:Array, p__5:Number)
		{
			type = p__1;
			sit = p__2;
			chips = p__3;
			pots = p__4;
			fee = p__5;
		}
	}
}