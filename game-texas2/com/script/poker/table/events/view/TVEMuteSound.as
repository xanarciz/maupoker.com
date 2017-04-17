// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.events.view
{
	import flash.events.*;
	import flash.system.*;
	import com.script.poker.table.events.*;
	public class TVEMuteSound extends com.script.poker.table.events.TVEvent
	{
		public var bMute:Boolean;
		public function TVEMuteSound(p__1:String, p__2:*)
		{
			super(p__1);
			bMute = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new TVEMuteSound(this.type));
		}
		override public function toString():String
		{
			return(formatToString("TVEMuteSound", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}