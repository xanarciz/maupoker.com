// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.*;
	public class SFLoginEvent extends flash.events.Event
	{
		public var message:String;
		public static const SF_LOGIN_FAILED:String = "SF_LOGIN_FAILED";
		public function SFLoginEvent(p__1:String, p__2:String)
		{
			super(p__1);
			message = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new SFLoginEvent(this.type, this.message));
		}
		override public function toString():String
		{
			return(formatToString("SFLoginEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}