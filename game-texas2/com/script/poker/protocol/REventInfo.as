// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	public class REventInfo
	{
		public var type:String;
		public var eventRule:String;
		public var eventStart:String;
		public var eventStop:String;
		public var eventPoin:String;
		public var eventPoinList:Array;
		public var eventUserList:Array;
		public var eventStat:String;
		
		public function REventInfo(p__1:String, p__2:Array, p__3:Array, p__4:String, p__5:String, p__6:String, p__7:String, p__8:String)
		{
			type = p__1;
			eventUserList = p__2;
			eventPoinList = p__3;
			eventPoin = p__4;
			eventStart = p__5;
			eventStop = p__6;
			eventRule = p__7;
			eventStat = p__8;
		}
	}
}