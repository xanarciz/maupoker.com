// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.events.view
{
	import com.script.poker.table.*;
	import flash.events.*;
	import com.script.poker.table.events.*;
	public class TVEPlaySound extends com.script.poker.table.events.TVEvent
	{
		public var nSit:int;
		public var sEvent:String;
		public function TVEPlaySound(p__1:String, p__2:String, p__3:int)
		{
			super(p__1);
			sEvent = p__2;
			nSit = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new TVEPlaySound(this.type));
		}
		override public function toString():String
		{
			return(formatToString("TVEPlaySound", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}