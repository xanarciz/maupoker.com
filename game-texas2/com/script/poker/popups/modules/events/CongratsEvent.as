// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.events
{
	import flash.events.*;
	public class CongratsEvent extends flash.events.Event
	{
		public var nWinnings:Number;
		public var nPlace:Number;
		public static const FEED_PUBLISH:String = "FEED_PUBLISH";
		public function CongratsEvent(p__1:String, p__2:Number, p__3:Number)
		{
			super(p__1);
			nPlace = p__2;
			nWinnings = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new CongratsEvent(this.type, nPlace, nWinnings));
		}
		override public function toString():String
		{
			return(formatToString("CongratsEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}