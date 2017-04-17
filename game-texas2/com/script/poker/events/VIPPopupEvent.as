// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.Event;
	public class VIPPopupEvent extends com.script.poker.events.PopupEvent
	{
		public var isVip:Boolean;
		public var vipStatusMsg:Number = 0;
		public var snid:Number = 0;
		public var days:Number = 0;
		public var isDisplayLobby:Boolean;
		public function VIPPopupEvent(p__1:String, p__2:Boolean, p__3:Number, p__4:Number, p__5:Number, p__6:Boolean)
		{
			super(p__1);
			isDisplayLobby = p__2;
			snid = p__3;
			days = p__4;
			vipStatusMsg = p__5;
			isVip = p__6;
		}
		override public function clone():flash.events.Event
		{
			return(new VIPPopupEvent(this.type, this.isDisplayLobby, this.snid, this.days, this.vipStatusMsg, this.isVip));
		}
		override public function toString():String
		{
			return(formatToString("VIPPopupEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}