// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.script.poker.table.events.view.TVEChatNamePressed;
	public class RAlert
	{
		public var type:String;
		public var oJSON:Object;
		public var sJSON:String;
		public function RAlert(p__1:String, p__2:String, p__3:Object)
		{
			type = p__1;
			sJSON = p__2;
			oJSON = p__3;
		}
	}
}