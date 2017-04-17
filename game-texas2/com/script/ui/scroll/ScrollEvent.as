// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.ui.scroll
{
	import flash.events.*;
	import caurina.transitions.*;
	public class ScrollEvent extends flash.events.Event
	{
		private var _data:Object;
		public static const DEFOCUS:String = "DEFOCUS";
		public static const disp:flash.events.EventDispatcher = new flash.events.EventDispatcher();
		public static const GRAB:String = "GRAB";
		public static const DROP:String = "DROP";
		public function ScrollEvent(p__1:String, p__2:Object = null, p__3:Boolean = true, p__4:Boolean = false):void
		{
			super(p__1, p__3, p__4);
			_data = p__2;
		}
		public function get data():Object
		{
			return(_data);
		}
		override public function clone():flash.events.Event
		{
			return(new com.script.ui.scroll.ScrollEvent(type, _data, bubbles, cancelable));
		}
		public static function quickThrow(p__1:String, p__2:*):void
		{
			disp.dispatchEvent(new ScrollEvent(p__1, p__2));
		}
	}
}