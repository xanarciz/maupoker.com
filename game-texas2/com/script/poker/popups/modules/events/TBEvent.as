// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.events
{
	import flash.events.*;
	public class TBEvent extends flash.events.Event
	{
		public var buyIn:Number;
		public var sit:int;
		public var transfer:Number;
		public static const BUYIN_ACCEPT:String = "BUYIN_ACCEPT";
		public static const BUYIN_CANCEL:String = "BUYIN_CANCEL";
		public static const TRANS_ACCEPT:String = "TRANS_ACCEPT";
		public static const TRANS_CANCEL:String = "TRANS_CANCEL";
		public function TBEvent(p__1:String, p__2:int = -1, p__3:Number = 0)
		{
			super(p__1);
			sit = p__2;
			buyIn = p__3;
			transfer = p__3;

		}
		override public function clone():flash.events.Event
		{
			return(new TBEvent(this.type, this.sit, this.amt));
		}
		override public function toString():String
		{
			return(formatToString("TBEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}