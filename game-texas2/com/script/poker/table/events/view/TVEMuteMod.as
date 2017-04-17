// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.events.view
{
	import com.script.poker.table.*;
	import flash.events.*;
	import com.script.poker.table.events.*;
	public class TVEMuteMod extends com.script.poker.table.events.TVEvent
	{
		public var zid:String;
		public var action:String;
		public function TVEMuteMod(p__1:String, p__2:String, p__3:String)
		{
			super(p__1);
			zid = p__2;
			action = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new TVESendChat(this.type));
		}
		override public function toString():String
		{
			return(formatToString("TVEMuteMod", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}