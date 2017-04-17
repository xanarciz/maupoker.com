// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby.events.controller
{
	import flash.events.*;
	import com.script.poker.lobby.events.*;
	public class LCEStats extends com.script.poker.lobby.events.LCEvent
	{
		public var sHandler:String;
		public var sEvent:String;
		public function LCEStats(p__1:String, p__2:String, p__3:String)
		{
			super(p__1);
			sHandler = p__2;
			sEvent = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new LCEStats(this.type));
		}
		override public function toString():String
		{
			return(formatToString("LCEStats", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}