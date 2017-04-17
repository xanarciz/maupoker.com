// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.Event;
	public class MyspacePopupEvent extends com.script.poker.events.PopupEvent
	{
		public var frame:int;
		public function MyspacePopupEvent(p__1:String, p__2:int)
		{
			super(p__1);
			frame = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new MyspacePopupEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("MyspacePopupEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}