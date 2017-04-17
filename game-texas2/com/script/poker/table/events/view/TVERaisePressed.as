// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.events.view
{
	import flash.events.*;
	import com.script.poker.table.events.*;
	public class TVERaisePressed extends com.script.poker.table.events.TVEvent
	{
		public var nAmt:Number;
		public function TVERaisePressed(p__1:String, p__2:int)
		{
			super(p__1);
			nAmt = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new TVERaisePressed(this.type));
		}
		override public function toString():String
		{
			return(formatToString("TVERaisePressed", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}