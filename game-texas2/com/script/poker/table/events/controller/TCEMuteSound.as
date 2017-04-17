// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.events.controller
{
	import flash.events.*;
	import com.script.poker.table.events.*;
	public class TCEMuteSound extends com.script.poker.table.events.TCEvent
	{
		public var bMute:Boolean;
		public function TCEMuteSound(p__1:String, p__2:Boolean)
		{
			super(p__1);
			bMute = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new TCEMuteSound(this.type, bMute));
		}
		override public function toString():String
		{
			return(formatToString("TCEMuteSound", "type", "bubbles", "cancelable", "eventPhase", "bMute"));
		}
	}
}