﻿// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	public class RBoughtGift
	{
		public var type:String;
		public var giftType:Number;
		public var toSit:Number;
		public var senderSit:Number;
		public var fromChips:Number;
		public var giftNo:Number;
		public function RBoughtGift(p__1:String, p__2:Number, p__3:Number, p__4:Number, p__5:Number, p__6:Number)
		{
			type = p__1;
			senderSit = p__2;
			giftType = p__3;
			giftNo = p__4;
			fromChips = p__5;
			toSit = p__6;
		}
	}
}