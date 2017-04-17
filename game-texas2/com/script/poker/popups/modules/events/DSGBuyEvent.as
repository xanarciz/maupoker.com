// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.events
{
	import flash.events.Event;
	public class DSGBuyEvent extends com.script.poker.popups.modules.events.DSGEvent
	{
		public var nGiftId:int;
		public var bBuyForTable:Boolean = false;
		public var nGiftCat:int;
		public var bSelect:* = false;
		public function DSGBuyEvent(p__1:String, p__2:String, p__3:int, p__4:int, p__5:Boolean, p__6:Boolean)
		{
			super(p__1, p__2);
			nGiftCat = p__3;
			nGiftId = p__4;
			bBuyForTable = p__5;
			bSelect = p__6;
		}
		override public function clone():flash.events.Event
		{
			return(new DSGBuyEvent(this.type, this.sZid, this.nGiftCat, this.nGiftId, this.bBuyForTable, this.bSelect));
		}
		override public function toString():String
		{
			return(formatToString("DSGBuyEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}