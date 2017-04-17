// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.events
{
	import flash.events.*;
	public class BBCardEvent extends flash.events.Event
	{
		public var sZid:String;
		public var bMuteUser:Boolean;
		public var playerName:String;
		public var bShowVip:Boolean;
		public static const FEED_CHECK:String = "FEED_CHECK";
		public static const DONE:String = "DONE";
		public static const ABUSE:String = "ABUSE";
		public static const ADD_BUDDY:String = "ADD_BUDDY";
		public static const PROFILE:String = "PROFILE";
		public static const GIFT_MENU:String = "GIFT_MENU";
		public static const MUTE_USER:String = "MUTE_USER";
		public static const GIFT_CHIPS:String = "GIFT_CHIPS";
		public static const SHOW_GIFT:String = "SHOW_GIFT";
		public static const SHOW_ITEMS:String = "SHOW_ITEMS";
		public static const SHOW_VIP:String = "SHOW_VIP";
		public function BBCardEvent(p__1:String, p__2:String, p__3:Boolean = false, p__4:Boolean = false, p__5:String = "")
		{
			super(p__1);
			sZid = p__2;
			bMuteUser = p__3;
			bShowVip = p__4;
			this.playerName = p__5;
		}
		override public function clone():flash.events.Event
		{
			return(new BBCardEvent(this.type, this.sZid));
		}
		override public function toString():String
		{
			return(formatToString("BBCardEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}