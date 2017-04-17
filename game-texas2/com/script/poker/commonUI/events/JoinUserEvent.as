// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.commonUI.events
{
	import flash.events.Event;
	public class JoinUserEvent extends com.script.poker.commonUI.events.CommonVEvent
	{
		public var friend:Object;
		public function JoinUserEvent(p__1:String, p__2:Object)
		{
			super(p__1);
			friend = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new JoinUserEvent(this.type, friend));
		}
		override public function toString():String
		{
			return(formatToString("JoinUserEvent", "type", "bubbles", "cancelable", "eventPhase", "friend"));
		}
	}
}