// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.table.GiftItem;
	public class RDealHoles
	{
		public var type:String;
		public var sit:int;
		public var card1:String;
		public var tip1:Number;
		public var card2:String;
		public var small:int;
		public var tip2:Number;
		public function RDealHoles(p__1:String, p__2:int, p__3:String, p__4:Number, p__5:String, p__6:Number, p__7:int)
		{
			type = p__1;
			sit = p__2;
			card1 = p__3;
			tip1 = p__4;
			card2 = p__5;
			tip2 = p__6;
			small = p__7;
		}
	}
}