// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import com.yahoo.astra.layout.events.LayoutEvent;
	public class RReceiveChat
	{
		public var type:String;
		public var sZid:String;
		public var sMessage:String;
		public var sUserName:String;
		public function RReceiveChat(p__1:String, p__2:String, p__3:String, p__4:String)
		{
			type = p__1;
			sZid = p__2;
			sMessage = p__3;
			sUserName = p__4;
		}
	}
}