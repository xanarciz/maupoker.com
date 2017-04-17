// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.events
{
	import flash.events.*;
	public class ShootoutCongratsEvent extends flash.events.Event
	{
		public var nWinnings:Number;
		public var nRound:Number;
		public var nPlace:Number;
		public var nTotalRounds:Number;
		public static const SHOOTOUT_FEED_PUBLISH:String = "SHOOTOUT_FEED_PUBLISH";
		public function ShootoutCongratsEvent(p__1:String, p__2:Number, p__3:Number, p__4:Number, p__5:Number)
		{
			super(p__1);
			nRound = p__2;
			nTotalRounds = p__3;
			nWinnings = p__4;
			nPlace = p__5;
		}
		override public function clone():flash.events.Event
		{
			return(new com.script.poker.popups.modules.events.ShootoutCongratsEvent(this.type, nRound, nTotalRounds, nWinnings, nPlace));
		}
		override public function toString():String
		{
			return(formatToString("ShootoutCongratsEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}