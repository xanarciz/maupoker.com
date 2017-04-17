// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.events
{
	import flash.events.*;
	public class VIPEvent extends flash.events.Event
	{
		public static const VIP_EARN_PASS:String = "VIP_EARN_PASS";
		public static const VIP_BUY_CHIPS:String = "VIP_BUY_CHIPS";
		public static const VIP_CASH_IN:String = "VIP_CASH_IN";
		public function VIPEvent(p__1:String)
		{
			super(p__1);
		}
		override public function clone():flash.events.Event
		{
			return(new com.script.poker.popups.modules.events.VIPEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("VIPEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}