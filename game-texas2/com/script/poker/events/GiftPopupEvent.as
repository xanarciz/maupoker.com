// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.Event;
	public class GiftPopupEvent extends com.script.poker.events.PopupEvent
	{
		public var sit:int;
		public var gifts:Array;
		public function GiftPopupEvent(p__1:String, p__2:int, p__3:Array)
		{
			super(p__1);
			sit = p__2;
			gifts = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new GiftPopupEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("GiftPopupEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}