﻿// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.events.view
{
	import flash.events.*;
	import com.script.poker.table.events.*;
	public class TVEChatNamePressed extends com.script.poker.table.events.TVEvent
	{
		public var zid:String;
		public function TVEChatNamePressed(p__1:String, p__2:String)
		{
			super(p__1);
			zid = p__2;
		}
		override public function clone():flash.events.Event
		{
			return(new TVEChatNamePressed(this.type, zid));
		}
		override public function toString():String
		{
			return(formatToString("TVEChatNamePressed", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}