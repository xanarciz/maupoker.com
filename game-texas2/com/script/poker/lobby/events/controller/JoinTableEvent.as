// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby.events.controller
{
	import flash.events.*;
	import com.script.poker.lobby.events.*;
	public class JoinTableEvent extends com.script.poker.lobby.events.LCEvent
	{
		public var nId:int;
		public function JoinTableEvent(p__1:String, p__2:int)
		{
			super(p__1);
			nId = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new JoinTableEvent(this.type, nId));
		}
		override public function toString():String
		{
			return(formatToString("JoinTableEvent", "type", "bubbles", "cancelable", "eventPhase", "nId"));
		}
	}
}