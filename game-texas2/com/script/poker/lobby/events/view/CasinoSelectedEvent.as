// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby.events.view
{
	import flash.events.*;
	import com.script.poker.lobby.events.*;
	public class CasinoSelectedEvent extends com.script.poker.lobby.events.LVEvent
	{
		public var nServerId:int;
		public var nIp:String;
		public var nName:String;
		public function CasinoSelectedEvent(p__1:String, p__2:String, p__3:String, p__4:*)
		{
			super(p__1);
			nIp = p__2;
			nName = p__3;
			nServerId = p__4;
		}
		override public function clone():flash.events.Event
		{
			return(new CasinoSelectedEvent(inType, nIp, nName, nServerId));
		}
		override public function toString():String
		{
			return(formatToString("CasinoSelectedEvent", "type", "bubbles", "cancelable", "eventPhase", "nIp", "nName", "nServerId"));
		}
	}
}