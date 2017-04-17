// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls.listClasses
{
	import fl.core.*;
	public class ListData
	{
		protected var _index:uint;
		protected var _owner:fl.core.UIComponent;
		protected var _label:String;
		protected var _icon:Object = null;
		protected var _row:uint;
		protected var _column:uint;
		public function ListData(p__1:String, p__2:Object, p__3:fl.core.UIComponent, p__4:uint, p__5:uint, p__6:uint = 0)
		{
			_label = p__1;
			_icon = p__2;
			_owner = p__3;
			_index = p__4;
			_row = p__5;
			_column = p__6;
		}
		public function get label():String
		{
			return(_label);
		}
		public function get icon():Object
		{
			return(_icon);
		}
		public function get owner():fl.core.UIComponent
		{
			return(_owner);
		}
		public function get index():uint
		{
			return(_index);
		}
		public function get row():uint
		{
			return(_row);
		}
		public function get column():uint
		{
			return(_column);
		}
	}
}