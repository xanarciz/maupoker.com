// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.table.events.view.TVEPlaySound;
	public class RBuyIn
	{
		public var points:Number;
		public var type:String;
		public var sit:Number;
		public function RBuyIn(p__1:String, p__2:Number, p__3:Number)
		{
			type = p__1;
			sit = p__2;
			points = p__3;
		}
	}
}