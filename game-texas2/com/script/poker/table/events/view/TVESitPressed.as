// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.events.view
{
	import flash.events.*;
	import com.script.poker.table.events.*;
	public class TVESitPressed extends com.script.poker.table.events.TVEvent
	{
		public var nSit:int;
		public function TVESitPressed(p__1:String, p__2:int)
		{
			super(p__1);
			nSit = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new TVESitPressed(this.type));
		}
		override public function toString():String
		{
			return(formatToString("TVESitPressed", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}