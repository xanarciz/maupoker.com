// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.events
{
	import flash.events.*;
	public class RUEvent extends flash.events.Event
	{
		public var sZid:String;
		public var reason:String;
		public static const CANCEL:String = "CANCEL";
		public static const REPORTUSER:String = "REPORTUSER";
		public function RUEvent(p__1:String, p__2:String = "", p__3:String = "")
		{
			super(p__1);
			sZid = p__2;
			reason = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new com.script.poker.popups.modules.events.RUEvent(this.type, this.sZid, this.reason));
		}
		override public function toString():String
		{
			return(formatToString("RUEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}