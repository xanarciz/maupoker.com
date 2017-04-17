// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.events
{
	import flash.events.*;
	import com.script.display.Dialog.*;
	public class PPVEvent extends flash.events.Event
	{
		public static const CLOSE:String = "CLOSE";
		public static const SEND_CHIPS_TO_FRIENDS:String = "SEND_CHIPS_TO_FRIENDS";
		public static const CLAIM_TOKEN:String = "CLAIM_TOKEN";
		public static const eType:String = "popupView";
		public static const CLAIM_SEAT:String = "CLAIM_SEAT";
		public static const INVITE_MORE:String = "INVITE_MORE";
		public static const BUY_PACKAGE:String = "BUY_PACKAGE";
		public static const JOIN_TOURNEY:String = "JOIN_TOURNEY";
		public static const EARN_PASS:String = "EARN_PASS";
		public static const PRIVATE_TABLE_YES:String = "PRIVATE_TABLE_YES";
		public static const PRIVATE_TABLE_NO:String = "PRIVATE_TABLE_NO";
		public static const SHOOTOUT_CONGRATS_CLOSE:String = "SHOOTOUT_CONGRATS_CLOSE";
		public static const JOIN_TOURNAMENT:String = "JOIN_TOURNAMENT";
		public static const CONFIRM:String = "CONFIRM";
		public static const PLAY_WEEKLY_TOURNAMENT:String = "PLAY_WEEKLY_TOURNAMENT";
		public static const MYSPACEAD_SENDCHIPS:String = "MYSPACEAD_SENDCHIPS";
		public static const IPHONE_INSTALL_NOW:String = "IPHONE_INSTALL_NOW";
		public static const TOURNEY_CONGRATS_CLOSE:String = "TOURNEY_CONGRATS_CLOSE";
		public static const CASH_1MIL:String = "CASH_1MIL";
		public static const GET_BONUS:String = "GET_BONUS";
		public static const ENTER_PASS:String = "ENTER_PASS";
		public static const CANCEL_PASS:String = "CANCEL_PASS";
		public static const ENTER_CHANGEPASS:String = "ENTER_CHANGEPASS";
		public static const ENTER_ERROR:String = "ENTER_ERROR";		
		public static const CANCEL_ERROR:String = "CANCEL_ERROR";		
		public static const ENTER_REPORT:String = "ENTER_REPORT";		
		public static const CANCEL_REPORT:String = "CANCEL_REPORT";	
		public static const TOURNEY_BUYIN:String = "TOURNEY_BUYIN";
		

		public function PPVEvent(p__1:String)
		{
			super(p__1);
		}
		override public function clone():flash.events.Event
		{
			return(new com.script.poker.popups.events.PPVEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("PPVEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}