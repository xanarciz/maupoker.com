// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls.dataGridClasses
{
	import fl.controls.listClasses.*;
	import fl.core.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	public class DataGridCellEditor extends fl.controls.TextInput implements ICellRenderer
	{
		protected var _listData:fl.controls.listClasses.ListData;
		protected var _data:Object;
		private static var defaultStyles:Object = {textPadding:1, textFormat:null, upSkin:"DataGridCellEditor_skin"};
		public function DataGridCellEditor():void
		{
		}
		public function get listData():fl.controls.listClasses.ListData
		{
			return(_listData);
		}
		public function set listData(p__1:fl.controls.listClasses.ListData):void
		{
			_listData = p__1;
			text = _listData.label;
		}
		public function get data():Object
		{
			return(_data);
		}
		public function set data(p__1:Object):void
		{
			_data = p__1;
		}
		public function get selected():Boolean
		{
			return(false);
		}
		public function set selected(p__1:Boolean):void
		{
		}
		public function setMouseState(p__1:String):void
		{
		}
		public static function getStyleDefinition():Object
		{
			return(defaultStyles);
		}
	}
}