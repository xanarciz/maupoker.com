// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.table.GiftItemInstSwf;
	public class RSendGiftChips
	{
		public var type:String;
		public var toSit:Number;
		public var fromChips:Number;
		public var toChips:Number;
		public var fromSit:Number;
		public var amount:int;
		public function RSendGiftChips(p__1:String, p__2:int, p__3:Number, p__4:Number, p__5:Number, p__6:Number)
		{
			type = p__1;
			amount = p__2;
			fromSit = p__3;
			fromChips = p__4;
			toSit = p__5;
			toChips = p__6;
		}
	}
}