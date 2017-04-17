// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls.listClasses
{
	import fl.core.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	public class CellRenderer extends fl.controls.LabelButton implements ICellRenderer
	{
		protected var _data:Object;
		protected var _listData:fl.controls.listClasses.ListData;
		private static var defaultStyles:Object = {upSkin:"CellRenderer_upSkin", downSkin:"CellRenderer_downSkin", overSkin:"CellRenderer_overSkin", disabledSkin:"CellRenderer_disabledSkin", selectedDisabledSkin:"CellRenderer_selectedDisabledSkin", selectedUpSkin:"CellRenderer_selectedUpSkin", selectedDownSkin:"CellRenderer_selectedDownSkin", selectedOverSkin:"CellRenderer_selectedOverSkin", textFormat:null, disabledTextFormat:null, embedFonts:null, textPadding:5};
		public function CellRenderer():void
		{
			toggle = true;
			focusEnabled = false;
		}
		override public function setSize(p__1:Number, p__2:Number):void
		{
			super.setSize(p__1, p__2);
		}
		public function get listData():fl.controls.listClasses.ListData
		{
			return(_listData);
		}
		public function set listData(p__1:fl.controls.listClasses.ListData):void
		{
			_listData = p__1;
			label = _listData.label;
			setStyle("icon", _listData.icon);
		}
		public function get data():Object
		{
			return(_data);
		}
		public function set data(p__1:Object):void
		{
			_data = p__1;
		}
		override public function get selected():Boolean
		{
			return(super.selected);
		}
		override public function set selected(p__1:Boolean):void
		{
			super.selected = p__1;
		}
		override protected function toggleSelected(p__1:flash.events.MouseEvent):void
		{
		}
		override protected function drawLayout():void
		{
			var l__1:Number;
			var l__2:Number;
			var l__3:Number;
			l__1 = Number(getStyleValue("textPadding"));
			l__2 = 0;
			if (icon != null){
				icon.x = l__1;
				icon.y = Math.round((height - icon.height) >> 1);
				l__2 = (icon.width + l__1);
			}
			if (label.length > 0){
				textField.visible = true;
				l__3 = Math.max(0, ((width - l__2) - (l__1 * 2)));
				textField.width = l__3;
				textField.height = (textField.textHeight + 4);
				textField.x = (l__2 + l__1);
				textField.y = Math.round((height - textField.height) >> 1);
			} else {
				textField.visible = false;
			}
			background.width = width;
			background.height = height;
		}
		public static function getStyleDefinition():Object
		{
			return(defaultStyles);
		}
	}
}