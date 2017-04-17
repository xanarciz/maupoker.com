// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.commonUI.events
{
	import flash.events.*;
	public class CommonVEvent extends flash.events.Event
	{
		 public static const JOIN_USER:String = "JOIN_USER";
        public static const INVITE_USER:String = "INVITE_USER";
        public static const ZLIVE_INVITE:String = "ZLIVE_INVITE";
        public static const VIEW_INIT:String = "VIEW_INIT";
        public static const SEE_MORE_USERS:String = "SEE_MORE_USERS";
        public static const CHAT_FRIENDS:String = "CHAT_FRIENDS";
        public static const CLOSE_NOTIF:String = "CLOSE_NOTIF";
        public static const CLOSE_INVITE:String = "CLOSE_INVITE";
        public static const ZLIVE_POST:String = "ZLIVE_POST";
        public static const ZLIVE_HIDE:String = "ZLIVE_HIDE";
		public function CommonVEvent(p__1:String)
		{
			super(p__1);
		}
		override public function clone():flash.events.Event
		{
			return(new CommonVEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("CommonVEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}