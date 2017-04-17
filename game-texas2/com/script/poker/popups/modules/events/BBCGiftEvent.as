// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.events
{
	import flash.events.Event;
	public class BBCGiftEvent extends com.script.poker.popups.modules.events.BBCardEvent
	{
		public var nAmt:Number;
		public function BBCGiftEvent(p__1:String, p__2:String, p__3:Number)
		{
			super(p__1, p__2);
			nAmt = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new BBCGiftEvent(this.type, sZid, nAmt));
		}
		override public function toString():String
		{
			return(formatToString("BBCGiftEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}