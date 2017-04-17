// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.events
{
	import flash.events.*;
	public class ListEvent extends flash.events.Event
	{
		protected var _index:int;
		protected var _item:Object;
		protected var _columnIndex:int;
		protected var _rowIndex:int;
		public static const ITEM_DOUBLE_CLICK:String = "itemDoubleClick";
		public static const ITEM_ROLL_OUT:String = "itemRollOut";
		public static const ITEM_ROLL_OVER:String = "itemRollOver";
		public static const ITEM_CLICK:String = "itemClick";
		public function ListEvent(p__1:String, p__2:Boolean = false, p__3:Boolean = false, p__4:int = -1, p__5:int = -1, p__6:int = -1, p__7:Object = null)
		{
			super(p__1, p__2, p__3);
			_rowIndex = p__5;
			_columnIndex = p__4;
			_index = p__6;
			_item = p__7;
		}
		public function get rowIndex():Object
		{
			return(_rowIndex);
		}
		public function get columnIndex():int
		{
			return(_columnIndex);
		}
		public function get index():int
		{
			return(_index);
		}
		public function get item():Object
		{
			return(_item);
		}
		override public function toString():String
		{
			return(formatToString("ListEvent", "type", "bubbles", "cancelable", "columnIndex", "rowIndex", "index", "item"));
		}
		override public function clone():flash.events.Event
		{
			return(new fl.events.ListEvent(type, bubbles, cancelable, _columnIndex, _rowIndex));
		}
	}
}