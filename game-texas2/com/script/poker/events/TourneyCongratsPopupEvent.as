// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.Event;
	public class TourneyCongratsPopupEvent extends com.script.poker.events.PopupEvent
	{
		public var place:Number;
		public var win:Number;
		public function TourneyCongratsPopupEvent(p__1:String, p__2:Number, p__3:Number)
		{
			super(p__1);
			place = p__2;
			win = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new TourneyCongratsPopupEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("TourneyCongratsPopupEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}