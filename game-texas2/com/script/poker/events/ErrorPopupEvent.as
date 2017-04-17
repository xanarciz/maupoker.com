// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.Event;
	public class ErrorPopupEvent extends com.script.poker.events.PopupEvent
	{
		public var sMsg:String;
		public var sTitle:String;
		public function ErrorPopupEvent(p__1:String, p__2:String, p__3:String)
		{
			super(p__1);
			sTitle = p__2;
			sMsg = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new ErrorPopupEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("ErrorPopupEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}