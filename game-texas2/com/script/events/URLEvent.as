// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.events
{
	import flash.events.*;
	public class URLEvent extends flash.events.Event
	{
		public var bSuccess:Boolean;
		public var data:String;
		public static const onLoaded:* = "onLoaded";
		public function URLEvent(p__1:String, p__2:Boolean, p__3:String = "")
		{
			super(p__1);
			this.bSuccess = p__2;
			this.data = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new URLEvent(this.type, this.bSuccess, this.data));
		}
		override public function toString():String
		{
			return(formatToString("URLEvent", "type", "bubbles", "cancelable", "eventPhase", "data", "bSuccess"));
		}
	}
}