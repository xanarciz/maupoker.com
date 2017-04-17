// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.events
{
	import flash.events.*;
	public class TCEvent extends flash.events.Event
	{
		public static const PLAY_SOUND_SEQUENCE:String = "PLAY_SOUND_SEQUENCE";
		public static const STAND_UP:String = "STAND_UP";
		public static const LEAVE_TABLE:String = "LEAVE_TABLE";
		public static const VIEW_INIT:String = "VIEW_INIT";
		public static const FRIEND_NET_PRESSED:String = "FRIEND_NET_PRESSED";
		public static const REPORT_PRESSED:String = "REPORT_PRESSED";
		public static const STOP_SOUND:String = "STOP_SOUND";
		public static const USERSINROOM_UPDATED:String = "USERSINROOM_UPDATED";
		public static const USERSWAITING_UPDATED:String = "USERSWAITING_UPDATED";
		public static const TOGGLE_MUTE_SOUND:String = "TOGGLE_MUTE_SOUND";
		public static const PLAY_SOUND_ONCE:String = "PLAY_SOUND_ONCE";
		public static const eType:String = "tableControl";
		public function TCEvent(p__1:String)
		{
			super(p__1);
		}
		override public function clone():flash.events.Event
		{
			return(new TCEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("TCEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}