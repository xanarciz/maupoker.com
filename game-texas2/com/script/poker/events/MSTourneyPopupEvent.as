// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.Event;
	public class MSTourneyPopupEvent extends com.script.poker.events.PopupEvent
	{
		public var sFrame:String;
		public var sInviteName:String;
		public var sTokenUrl:String;
		public var sWhen:String;
		public var nBonus:Number;
		public static const CLAIM_TOKEN:String = "showClaimToken";
		public static const CLAIM_SEAT:String = "showClaimSeat";
		public static const PLAY_NOW:String = "showPlayNow";
		public function MSTourneyPopupEvent(p__1:String, p__2:String, p__3:Number, p__4:String, p__5:String, p__6:String = "")
		{
			super(p__1);
			sFrame = p__2;
			nBonus = p__3;
			sTokenUrl = p__5;
			if (p__4 != ""){
				sWhen = p__4;
			}
			if (p__6 != ""){
				sInviteName = p__6;
			}
		}
		override public function clone():flash.events.Event
		{
			return(new MSTourneyPopupEvent(this.type, this.sFrame, this.nBonus, this.sWhen, this.sTokenUrl, this.sInviteName));
		}
		override public function toString():String
		{
			return(formatToString("MSTourneyPopupEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}