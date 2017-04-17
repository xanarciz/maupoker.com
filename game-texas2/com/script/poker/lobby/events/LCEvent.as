// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby.events
{
	import flash.events.*;
	public class LCEvent extends flash.events.Event
	{
		public static const VIEW_INIT:String = "VIEW_INIT";
		public static const eType:String = "lobbyControl";
		public static const HIDE_FRIEND_SELECTOR:String = "HIDE_FRIEND_SELECTOR";
		public static const SHOW_FRIEND_SELECTOR:String = "SHOW_FRIEND_SELECTOR";
		public static const FIND_SEAT:String = "FIND_SEAT";
		public static const CONNECT_TO_NEW_SERVER:String = "RECONNECT_TO_SERVER";
		public static const JOIN_TABLE:String = "JOIN_TABLE";
		public static const RECORD_STAT:String = "RECORD_STAT";
		public static const PRIVATE_TABLE_CLICK:String = "PRIVATE_TABLE_CLICK";
		public function LCEvent(p__1:String)
		{
			super(p__1);
		}
		override public function clone():flash.events.Event
		{
			return(new LCEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("LCEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}