// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.Event;
	public class EmoPopupEvent extends com.script.poker.events.PopupEvent
	{
		public var sit:int;
		public var emoticons:Array;
		public function EmoPopupEvent(p__1:String, p__2:int, p__3:Array)
		{
			super(p__1);
			sit = p__2;
			emoticons = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new EmoPopupEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("EmoPopupEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}