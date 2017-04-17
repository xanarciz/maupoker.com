// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.events.view
{
	import flash.events.*;
	import flash.net.*;
	import com.script.poker.table.events.*;
	public class TVERefreshJoinUserPressed extends com.script.poker.table.events.TVEvent
	{
		public var nAction:String;
		public function TVERefreshJoinUserPressed(p__1:String, p__2:String)
		{
			super(p__1);
			nAction = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new TVERefreshJoinUserPressed(this.type));
		}
		override public function toString():String
		{
			return(formatToString("TVESitPressed", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}