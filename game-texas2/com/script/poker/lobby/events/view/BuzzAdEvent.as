// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby.events.view
{
	import flash.events.*;
	import com.script.poker.lobby.events.*;
	public class BuzzAdEvent extends com.script.poker.lobby.events.LVEvent
	{
		public var sTarget:String;
		public var sLink:String;
		public function BuzzAdEvent(p__1:String, p__2:String, p__3:String)
		{
			super(p__1);
			sLink = p__2;
			sTarget = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new BuzzAdEvent(this.type, sLink, sTarget));
		}
		override public function toString():String
		{
			return(formatToString("BuzzAdEvent", "type", "bubbles", "cancelable", "eventPhase", "nId"));
		}
	}
}