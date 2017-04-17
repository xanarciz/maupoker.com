// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.commonUI.events
{
	import flash.events.*;
	public class CommonCEvent extends flash.events.Event
	{
		public static const VIEW_INIT:String = "VIEW_INIT";
		public static const eType:String = "lobbyControl";
		public static const HIDE_FRIEND_SELECTOR:String = "HIDE_FRIEND_SELECTOR";
		public static const SHOW_FRIEND_SELECTOR:String = "SHOW_FRIEND_SELECTOR";
		public static const C_JOIN_USER:String = "C_JOIN_USER";
		public function CommonCEvent(p__1:String)
		{
			super(p__1);
		}
		override public function clone():flash.events.Event
		{
			return(new CommonCEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("CommonCEvents", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}