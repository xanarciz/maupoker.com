// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import ws.tink.managers.LibraryManager;
	public class SBuyEmo
	{
		public var zid:String;
		public var sit:Number
		public var type:String;
		public var emoId:Number;
		public var emoType:Number;
		public var emoStr:String;
		public function SBuyEmo(p__1:String, p__2:Number, p__3:Number, p__4:String, p__5:Number, p__6:String)
		{
			type = p__1;
			emoType = p__2;
			emoId = p__3;
			zid = p__4;
			sit = p__5;
			emoStr = p__6;
		}
	}
}