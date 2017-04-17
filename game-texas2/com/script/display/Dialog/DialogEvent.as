// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.display.Dialog
{
	import flash.events.*;
	import flash.geom.*;
	public class DialogEvent extends flash.events.Event
	{
		private var _data:Object;
		public static const CLOSE:String = "CLOSE";
		public static const DISABLE:String = "DISABLE";
		public static const disp:flash.events.EventDispatcher = new flash.events.EventDispatcher();
		public static const PRIORITIZE:String = "PRIORITIZE";
		public static const ACTIVE:String = "ACTIVE";
		public static const RELEASE:String = "RELEASE";
		public static const OPEN:String = "OPEN";
		public static const ISOLATE:String = "ISOLATE";
		public static const CLOSED:String = "CLOSED";
		public static const ALONE:String = "ALONE";
		public function DialogEvent(p__1:String, p__2:Object = null, p__3:Boolean = true, p__4:Boolean = false):void
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
			return(new com.script.display.Dialog.DialogEvent(type, _data, bubbles, cancelable));
		}
		public static function quickThrow(p__1:String, p__2:*):void
		{
			disp.dispatchEvent(new DialogEvent(p__1, p__2));
		}
	}
}