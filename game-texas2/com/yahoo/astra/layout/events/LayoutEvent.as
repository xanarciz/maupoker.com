// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.layout.events
{
	import flash.events.*;
	public class LayoutEvent extends flash.events.Event
	{
		public static const LAYOUT_CHANGE:String = "layoutChange";
		public function LayoutEvent(p__1:String, p__2:Boolean = false, p__3:Boolean = false)
		{
			super(p__1, p__2, p__3);
		}
		override public function clone():flash.events.Event
		{
			return(new LayoutEvent(this.type, this.bubbles, this.cancelable));
		}
	}
}