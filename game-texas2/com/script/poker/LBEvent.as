// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker
{
	import ws.tink.core.*;
	import flash.events.*;
	public class LBEvent extends flash.events.Event
	{
		public static const serverStatusError:String = "serverStatusError";
		public static const onServerChosen:* = "onServerChosen";
		public static const onParseServerList:* = "onParseServerList";
		public static const serverListError:String = "serverListError";
		public static const findServerError:String = "findServerError";
		public function LBEvent(p__1:String)
		{
			super(p__1);
		}
		override public function clone():flash.events.Event
		{
			return(new LBEvent(this.type));
		}
		override public function toString():String
		{
			return(formatToString("LBEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}