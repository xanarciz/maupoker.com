// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.events.view
{
	import flash.events.*;
	import com.script.poker.table.events.*;
	public class TVEJoinUserPressed extends com.script.poker.table.events.TVEvent
	{
		public var sZid:String;
		public var nRoomId:Number;
		public var nServerId:Number;
		public function TVEJoinUserPressed(p__1:String, p__2:String, p__3:Number, p__4:Number)
		{
			super(p__1);
			sZid = p__2;
			nServerId = p__3;
			nRoomId = p__4;
		}
		override public function clone():flash.events.Event
		{
			return(new TVEJoinUserPressed(this.type));
		}
		override public function toString():String
		{
			return(formatToString("TVESitPressed", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}