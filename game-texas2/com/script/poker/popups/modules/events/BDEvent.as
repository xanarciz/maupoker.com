// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.events
{
	import flash.events.*;
	public class BDEvent extends flash.events.Event
	{
		public var aApproved:Array;
		public var aDenied:Array;
		public static const BUDDY_ACCEPTALL:String = "BUDDY_ACCEPTALL";
		public static const BUDDY_IGNOREALL:String = "BUDDY_IGNOREALL";
		public static const BUDDY_DONE:String = "BUDDY_DONE";
		public static const BUDDY_DENYALL:String = "BUDDY_DENYALL";
		public function BDEvent(p__1:String, p__2:Array = null, p__3:Array = null)
		{
			super(p__1);
			aApproved = p__2;
			aDenied = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new BDEvent(this.type, this.aApproved, this.aDenied));
		}
		override public function toString():String
		{
			return(formatToString("BDEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}