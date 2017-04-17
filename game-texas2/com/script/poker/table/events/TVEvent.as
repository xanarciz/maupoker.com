// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.events
{
	import flash.display.*;
	import flash.events.*;
	public class TVEvent extends flash.events.Event
	{
		public static const BJACKPOT1_PRESSED:String = "BJACKPOT1_PRESSED";
		public static const BJACKPOT2_PRESSED:String = "BJACKPOT2_PRESSED";
		public static const BJACKPOT3_PRESSED:String = "BJACKPOT3_PRESSED";
		public static const BJACKPOT_UNPRESSED:String = "BJACKPOT_UNPRESSED";	
		public static const SIT_PRESSED:String = "SIT_PRESSED";
		public static const DEAL_CARD:String = "DEAL_CARD";
		public static const STAND_UP:String = "STAND_UP";
		public static const LEAVE_TABLE:String = "LEAVE_TABLE";
		public static const JOIN_USER_PRESSED:String = "JOIN_USER_PRESSED";
		public static const FOLD_PRESSED:String = "FOLD_PRESSED";
		public static const eType:String = "tableView";
		public static const RAISE_PRESSED:String = "RAISE_PRESSED";
		public static const INVITE_PRESSED:String = "INVITE_PRESSED";
		public static const PLAY_SOUND_ONCE:String = "PLAY_SOUND_ONCE";
		public static const TOGGLE_MUTE_SOUND:String = "TOGGLE_MUTE_SOUND";
		public static const MUTE_PRESSED:String = "MUTE_PRESSED";
		public static const EMO_PRESSED:String = "EMO_PRESSED";
		public static const GIFT_PRESSED:String = "GIFT_PRESSED";
		public static const BET_MINUS_PRESSED:String = "BET_MINUS_PRESSED";
		public static const BET_INPUT_PRESSED:String = "BET_INPUT_PRESSED";
		public static const CALL_PRESSED:String = "CALL_PRESSED";
		public static const HAND_STRENGTH_PRESSED:String = "HAND_STRENGTH_PRESSED";
		public static const VIP_BADGE_PRESSED:String = "VIP_BADGE_PRESSED";
		public static const BET_PLUS_PRESSED:String = "BET_PLUS_PRESSED";
		public static const REFRESH_JOIN_USER_PRESSED:String = "REFRESH_JOIN_USER_PRESSED";
		public static const CHAT_NAME_PRESSED:String = "CHAT_NAME_PRESSED";
		public static const FRIEND_NET_PRESSED:String = "FRIEND_NET_PRESSED";
		public static const REPORT_PRESSED:String = "FRIEND_NET_PRESSED";
		public static const SEND_CHAT:String = "SEND_CHAT";
		public static const BET_SLIDER_PRESSED:String = "BET_SLIDER_PRESSED";
		public static const IPHONE_PRESSED:String = "IPHONE_PRESSED";
		public static const MUTE_MOD:String = "MUTE_MOD";
		public static const EDIT_TABLE:String = "EDIT_TABLE";
		public function TVEvent(p__1:String)
		{
			super(p__1);
			
		}
		override public function clone():flash.events.Event
		{
			return(new TVEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("TVEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}