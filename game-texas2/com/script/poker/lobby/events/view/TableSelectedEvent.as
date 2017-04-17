// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby.events.view
{
	import flash.events.*;
	import com.script.poker.lobby.events.*;
	public class TableSelectedEvent extends com.script.poker.lobby.events.LVEvent
	{
		public var nId:int;
		public function TableSelectedEvent(p__1:String, p__2:int)
		{
			super(p__1);
			nId = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new TableSelectedEvent(this.type, nId));
		}
		override public function toString():String
		{
			return(formatToString("TableSelectedEvent", "type", "bubbles", "cancelable", "eventPhase", "nId"));
		}
	}
}