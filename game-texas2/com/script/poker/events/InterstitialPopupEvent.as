// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.events
{
	import flash.events.Event;
	public class InterstitialPopupEvent extends com.script.poker.events.PopupEvent
	{
		public var sBody:String;
		public var sTitle:String;
		public static const INTERSITIAL:String = "showInterstitial";
		public function InterstitialPopupEvent(p__1:String, p__2:String, p__3:String)
		{			
			super(p__1);
			sTitle = p__2;
			sBody = p__3;
		}
		override public function clone():flash.events.Event
		{
			return(new InterstitialPopupEvent(this.type, sTitle, sBody));
		}
		override public function toString():String
		{
			return(formatToString("InterstitialPopupEvent", "type", "bubbles", "cancelable", "eventPhase"));
		}
	}
}