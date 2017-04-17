// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.shootout.ShootoutConfig;
	public class RBoughtGift2
	{
		public var type:String;
		public var giftId:Number;
		public var giftType:Number;
		public var toSit:Number;
		public var senderSit:Number;
		public var fromChips:Number;
		public var totalChips:Number;
		public function RBoughtGift2(p__1:String, p__2:Number, p__3:Number, p__4:Number, p__5:Number, p__6:Number)
		{
			type = p__1;
			senderSit = p__2;
			giftId = p__3;
			fromChips = p__4;
			toSit = p__5;
			totalChips = p__6;
		}
	}
}