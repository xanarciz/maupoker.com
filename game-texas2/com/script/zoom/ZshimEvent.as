// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.zoom
{
	import flash.events.*;
	public class ZshimEvent extends flash.events.Event
	{
		public var msg:Object;
		public function ZshimEvent(p__1:String, p__2:Object = null)
		{
			super(p__1);
			this.msg = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new ZshimEvent(this.type, this.msg));
		}
		override public function toString():String
		{
			return(formatToString("ZshimEvent", "type", "bubbles", "cancelable", "eventPhase", "msg"));
		}
	}
}