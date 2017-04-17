// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.Event;
	public class ShootoutCongratsPopupEvent extends com.script.poker.events.PopupEvent
	{
		public var place:Number;
		public var win:Number;
		public function ShootoutCongratsPopupEvent(p__1:String, p__2:Number, p__3:Number)
		{
			super(p__1);
			place = p__2;
			win = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new ShootoutCongratsPopupEvent(this.type, this.place, this.win));
		}
		override public function toString():String
		{
			return(formatToString("ShootoutCongratsPopupEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}