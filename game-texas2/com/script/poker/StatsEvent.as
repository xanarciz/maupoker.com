// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker
{
	import flash.events.*;
	public class StatsEvent extends flash.events.Event
	{
		public var url:String;
		public static const RECORD:String = "record";
		public function StatsEvent(p__1:String, p__2:String)
		{
			super(p__1);
			url = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new StatsEvent(this.type, url));
		}
		override public function toString():String
		{
			return(formatToString("StatsEvent", "type", "bubbles", "cancelable", "eventPhase", "url"));
		}
	}
}