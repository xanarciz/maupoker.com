// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.*;
	import com.script.utils.*;
	public class PCEvent extends flash.events.Event
	{
		public static const HIDE_FRIEND_SELECTOR:String = "HIDE_FRIEND_SELECTOR";
		public static const SHOW_FRIEND_SELECTOR:String = "SHOW_FRIEND_SELECTOR";
		public static const DISPLAY_COMMON_UI:String = "DISPLAY_COMMON_UI";
		public static const HIDE_COMMON_UI:String = "HIDE_COMMON_UI";
		public static const LOBBY_JOINED:String = "LOBBY_JOINED";
		public static const INIT_COMMON_UI:String = "INIT_COMMON_UI";
		public static const TABLE_JOINED:String = "TABLE_JOINED";
		public function PCEvent(p__1:String)
		{
			super(p__1);
		}
		override public function clone():flash.events.Event
		{
			return(new PCEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("PCEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}