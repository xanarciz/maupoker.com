// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.events
{
	import flash.events.*;
	public class ScrollEvent extends flash.events.Event
	{
		private var _position:Number;
		private var _direction:String;
		private var _delta:Number;
		public static const SCROLL:String = "scroll";
		public function ScrollEvent(p__1:String, p__2:Number, p__3:Number)
		{
			super(fl.events.ScrollEvent.SCROLL, false, false);
			_direction = p__1;
			_delta = p__2;
			_position = p__3;
		}
		public function get direction():String
		{
			return(_direction);
		}
		public function get delta():Number
		{
			return(_delta);
		}
		public function get position():Number
		{
			return(_position);
		}
		override public function toString():String
		{
			return(formatToString("ScrollEvent", "type", "bubbles", "cancelable", "direction", "delta", "position"));
		}
		override public function clone():flash.events.Event
		{
			return(new fl.events.ScrollEvent(_direction, _delta, _position));
		}
	}
}