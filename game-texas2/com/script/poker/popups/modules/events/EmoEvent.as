// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.events
{
	import flash.events.*;
	public class EmoEvent extends flash.events.Event
	{
		public var sZid:String = null;
		public var nCatIndex:Number = -1;
		public static const REFRESH_CATEGORY:String = "REFRESH_CATEGORY";
		public static const PANELMODE_BUY:* = "buy";
		public static const FEED_CHECK:String = "FEED_CHECK";
		public static const DONE:String = "DONE";
		public static const BUYFORTABLE:String = "BUYFORTABLE";
		public static const DISPLAY_NONE:String = "DISPLAY_NONE";
		public static const DSG_UPDATE:String = "DSG_UPDATE";
		public static const DISPLAY_SELECTED:String = "DISPLAY_SELECTED";
		public static const PANELMODE_DISPLAY:* = "display";
		public static const CANCEL:String = "CANCEL";
		public static const PANELMODE_SELECT:* = "select";
		public static const BUYEMO:String = "BUYEMO";
		public function EmoEvent(p__1:String, p__2:String, p__3:Number = -1)
		{
			super(p__1);
			sZid = p__2;
			nCatIndex = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new EmoEvent(this.type, this.sZid));
		}
		override public function toString():String
		{
			return(formatToString("EmoEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}