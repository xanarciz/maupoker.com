// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.events.controller
{
	import flash.events.*;
	import com.script.poker.table.events.*;
	public class PokerSoundEvent extends com.script.poker.table.events.TCEvent
	{
		public var handler:String;
		public function PokerSoundEvent(p__1:String, p__2:String)
		{
			super(p__1);
			handler = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new PokerSoundEvent(this.type, handler));
		}
		override public function toString():String
		{
			return(formatToString("PokerSoundEvent", "type", "bubbles", "cancelable", "eventPhase", "handler"));
		}
	}
}