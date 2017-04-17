// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.events
{
	import flash.events.*;
	public class DataChangeEvent extends flash.events.Event
	{
		protected var _items:Array;
		protected var _endIndex:uint;
		protected var _changeType:String;
		protected var _startIndex:uint;
		public static const PRE_DATA_CHANGE:String = "preDataChange";
		public static const DATA_CHANGE:String = "dataChange";
		public function DataChangeEvent(p__1:String, p__2:String, p__3:Array, p__4:int = -1, p__5:int = -1):void
		{
			super(p__1);
			_changeType = p__2;
			_startIndex = p__4;
			_items = p__3;
			_endIndex = (p__5 == -1) ? _startIndex : p__5;
		}
		public function get changeType():String
		{
			return(_changeType);
		}
		public function get items():Array
		{
			return(_items);
		}
		public function get startIndex():uint
		{
			return(_startIndex);
		}
		public function get endIndex():uint
		{
			return(_endIndex);
		}
		override public function toString():String
		{
			return(formatToString("DataChangeEvent", "type", "changeType", "startIndex", "endIndex", "bubbles", "cancelable"));
		}
		override public function clone():flash.events.Event
		{
			return(new fl.events.DataChangeEvent(type, _changeType, _items, _startIndex, _endIndex));
		}
	}
}