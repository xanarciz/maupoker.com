// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.events
{
	import flash.events.Event;
	public class EmoBuyEvent extends com.script.poker.popups.modules.events.EmoEvent
	{
		public var nEmoId:int;
		public var bBuyForTable:Boolean = false;
		public var nEmoCat:int;
		public var nEmoStr:String;
		public var bSelect:* = false;
		public function EmoBuyEvent(p__1:String, p__2:String, p__3:int, p__4:int, p__5:Boolean, p__6:Boolean, p__7:String)
		{
			super(p__1, p__2);
			nEmoCat = p__3;
			nEmoId = p__4;
			bBuyForTable = p__5;
			bSelect = p__6;
			nEmoStr = p__7;
		}
		override public function clone():flash.events.Event
		{
			return(new EmoBuyEvent(this.type, this.sZid, this.nEmoCat, this.nEmoId, this.bBuyForTable, this.bSelect));
		}
		override public function toString():String
		{
			return(formatToString("EmoBuyEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}