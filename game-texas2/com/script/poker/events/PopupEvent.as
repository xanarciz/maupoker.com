// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.*;
	public class PopupEvent extends flash.events.Event
	{
		public static const POPUP:String = "POPUP";
		public function PopupEvent(p__1:String)
		{
			super(p__1);
			
		}
		override public function clone():flash.events.Event
		{
			return(new PopupEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("PopupEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}