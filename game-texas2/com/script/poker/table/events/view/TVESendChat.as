// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.events.view
{
	import flash.events.*;
	import com.script.poker.table.events.*;
	public class TVESendChat extends com.script.poker.table.events.TVEvent
	{
		public var sMessage:String;
		public function TVESendChat(p__1:String, p__2:String)
		{
			super(p__1);
			sMessage = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new TVESendChat(this.type));
		}
		override public function toString():String
		{
			return(formatToString("TVESendChat", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}