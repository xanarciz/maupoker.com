// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.Event;
	public class TourneyBuyInPopupEvent extends com.script.poker.events.PopupEvent
	{
		public var sit:int;
		public function TourneyBuyInPopupEvent(p__1:String, p__2:int)
		{
			super(p__1);
			sit = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new TourneyBuyInPopupEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("TourneyBuyInPopupEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}