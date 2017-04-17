// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.Event;
	public class UserPopupEvent extends com.script.poker.events.PopupEvent
	{
		public var aUsers:Array;
		public var bAddBuddy:Boolean;
		public function UserPopupEvent(p__1:String, p__2:Array, p__3:Boolean)
		{
			super(p__1);
			aUsers = p__2;
			bAddBuddy = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new UserPopupEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("UserPopupEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}