// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.table.events.view.TVEMuteMod;
	public class RTourneyOver
	{
		public var type:String;
		public var place:Number;
		public var win:Number;
		public function RTourneyOver(p__1:String, p__2:Number, p__3:Number)
		{
			type = p__1;
			place = p__2;
			win = p__3;
		}
	}
}