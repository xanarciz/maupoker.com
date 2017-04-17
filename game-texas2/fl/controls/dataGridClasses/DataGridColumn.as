// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls.dataGridClasses
{
	import fl.core.*;
	import fl.controls.*;
	public class DataGridColumn
	{
		public var owner:fl.controls.DataGrid;
		private var _headerText:String;
		public var editorDataField:String = "text";
		public var sortable:Boolean = true;
		private var forceImport:fl.controls.dataGridClasses.DataGridCellEditor;
		private var _headerRenderer:Object;
		public var sortOptions:uint = 0;
		private var _cellRenderer:Object;
		private var _columnName:String;
		public var resizable:Boolean = true;
		private var _sortCompareFunction:Function;
		private var _visible:Boolean = true;
		public var sortDescending:Boolean = false;
		private var _imeMode:String;
		private var _width:Number = 100;
		public var editable:Boolean = true;
		public var explicitWidth:Number;
		private var _minWidth:Number = 20;
		private var _labelFunction:Function;
		public var itemEditor:Object = "fl.controls.dataGridClasses.DataGridCellEditor";
		public var colNum:Number;
		public var dataField:String;
		public function DataGridColumn(p__1:String = null)
		{
			if (p__1){
				dataField = p__1;
				headerText = p__1;
			}
		}
		public function get cellRenderer():Object
		{
			return(_cellRenderer);
		}
		public function set cellRenderer(p__1:Object):void
		{
			_cellRenderer = p__1;
			if (owner){
				owner.invalidate(fl.core.InvalidationType.DATA);
			}
		}
		public function get headerRenderer():Object
		{
			return(_headerRenderer);
		}
		public function set headerRenderer(p__1:Object):void
		{
			_headerRenderer = p__1;
			if (owner){
				owner.invalidate(fl.core.InvalidationType.DATA);
			}
		}
		public function get headerText():String
		{
			return((_headerText != null) ? _headerText : dataField);
		}
		public function set headerText(p__1:String):void
		{
			_headerText = p__1;
			if (owner){
				owner.invalidate(fl.core.InvalidationType.DATA);
			}
		}
		public function get imeMode():String
		{
			return(_imeMode);
		}
		public function set imeMode(p__1:String):void
		{
			_imeMode = p__1;
		}
		public function get labelFunction():Function
		{
			return(_labelFunction);
		}
		public function set labelFunction(p__1:Function):void
		{
			if (_labelFunction == (p__1)){
				return;
			}
			_labelFunction = p__1;
			if (owner){
				owner.invalidate(fl.core.InvalidationType.DATA);
			}
		}
		public function get minWidth():Number
		{
			return(_minWidth);
		}
		public function set minWidth(p__1:Number):void
		{
			_minWidth = p__1;
			if (_width < (p__1)){
				_width = p__1;
			}
			if (owner){
				owner.invalidate(fl.core.InvalidationType.SIZE);
			}
		}
		public function get sortCompareFunction():Function
		{
			return(_sortCompareFunction);
		}
		public function set sortCompareFunction(p__1:Function):void
		{
			_sortCompareFunction = p__1;
		}
		public function get visible():Boolean
		{
			return(_visible);
		}
		public function set visible(p__1:Boolean):void
		{
			if (_visible != (p__1)){
				_visible = p__1;
				if (owner){
					owner.invalidate(fl.core.InvalidationType.SIZE);
				}
			}
		}
		public function get width():Number
		{
			return(_width);
		}
		public function set width(p__1:Number):void
		{
			var l__2:Boolean;
			explicitWidth = p__1;
			if (owner != null){
				l__2 = resizable;
				resizable = false;
				owner.resizeColumn(colNum, p__1);
				resizable = l__2;
			} else {
				_width = p__1;
			}
		}
		public function setWidth(p__1:Number):void
		{
			_width = p__1;
		}
		public function itemToLabel(data:Object):String
		{
			if (!data){
				return(" ");
			}
			if (labelFunction != null){
				return(labelFunction(data));
			}
			if (owner.labelFunction != null){
				return(owner.labelFunction(data, this));
			}
			if (((typeof data) == "object") || ((typeof data) == "xml")){
				try {
					data = data[dataField];
				} catch (e:Error) {
					data = null;
				}
			}
			if (data is String){
				return(String(data));
			}
			try {
				return(data.toString());
			} catch (e:Error) {
			}
			return(" ");
		}
		public function toString():String
		{
			return("[object DataGridColumn]");
		}
	}
}