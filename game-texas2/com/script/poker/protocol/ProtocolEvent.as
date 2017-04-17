// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.protocol
{
	import flash.events.*;
	public class ProtocolEvent extends flash.events.Event
	{
		public var msg:Object;
		public static const onMessage:* = "onMessage";
		public function ProtocolEvent(p__1:String, p__2:Object)
		{
			super(p__1);
			this.msg = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new ProtocolEvent(this.type, this.msg));
		}
		override public function toString():String
		{
			return(formatToString("ProtocolEvent", "type", "bubbles", "cancelable", "eventPhase", "msg"));
		}
	}
}