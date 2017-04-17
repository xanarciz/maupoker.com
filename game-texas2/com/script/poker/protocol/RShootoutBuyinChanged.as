// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.table.events.view.TVESendChat;
	public class RShootoutBuyinChanged
	{
		public var type:String;
		public var nOldBuyIn:Number;
		public var nRefund:Number;
		public var nNewBuyIn:Number;
		public function RShootoutBuyinChanged(p__1:String, p__2:Number, p__3:Number, p__4:Number)
		{
			type = p__1;
			nRefund = p__2;
			nNewBuyIn = p__3;
			nOldBuyIn = p__4;
		}
	}
}