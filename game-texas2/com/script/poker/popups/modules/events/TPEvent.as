// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.events
{
	import flash.events.*;
	public class TPEvent extends flash.events.Event
	{
		public var frame:String;
		public static const CLAIM_TOKEN:String = "CLAIM_TOKEN";
		public static const CLAIM_SEAT:String = "CLAIM_SEAT";
		public static const PLAY_WEEKLY_TOURNAMENT:String = "PLAY_WEEKLY_TOURNAMENT";
		public function TPEvent(p__1:String, p__2:String)
		{
			super(p__1);
			frame = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new TPEvent(this.type, this.frame));
		}
		override public function toString():String
		{
			return(formatToString("TPEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}