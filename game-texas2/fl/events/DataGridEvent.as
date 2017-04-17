// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.events
{
	import flash.events.*;
	import fl.controls.dataGridClasses.*;
	public class DataGridEvent extends fl.events.ListEvent
	{
		protected var _reason:String;
		protected var _dataField:String;
		protected var _itemRenderer:Object;
		public static const ITEM_EDIT_BEGIN:String = "itemEditBegin";
		public static const ITEM_EDIT_END:String = "itemEditEnd";
		public static const ITEM_EDIT_BEGINNING:String = "itemEditBeginning";
		public static const HEADER_RELEASE:String = "headerRelease";
		public static const ITEM_FOCUS_IN:String = "itemFocusIn";
		public static const ITEM_FOCUS_OUT:String = "itemFocusOut";
		public static const COLUMN_STRETCH:String = "columnStretch";
		public function DataGridEvent(p__1:String, p__2:Boolean = false, p__3:Boolean = false, p__4:int = -1, p__5:int = -1, p__6:Object = null, p__7:String = null, p__8:String = null)
		{
			super(p__1, p__2, p__3, p__4, p__5);
			_itemRenderer = p__6;
			_dataField = p__7;
			_reason = p__8;
		}
		public function get itemRenderer():Object
		{
			return(_itemRenderer);
		}
		public function get dataField():String
		{
			return(_dataField);
		}
		public function set dataField(p__1:String):void
		{
			_dataField = p__1;
		}
		public function get reason():String
		{
			return(_reason);
		}
		override public function toString():String
		{
			return(formatToString("DataGridEvent", "type", "bubbles", "cancelable", "columnIndex", "rowIndex", "itemRenderer", "dataField", "reason"));
		}
		override public function clone():flash.events.Event
		{
			return(new fl.events.DataGridEvent(type, bubbles, cancelable, columnIndex, int(rowIndex), _itemRenderer, _dataField, _reason));
		}
	}
}