// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls.dataGridClasses
{
	import fl.core.*;
	import fl.controls.*;
	import flash.display.*;
	import flash.events.*;
	public class HeaderRenderer extends fl.controls.LabelButton
	{
		public var _column:uint;
		private static var defaultStyles:Object = {upSkin:"HeaderRenderer_upSkin", downSkin:"HeaderRenderer_downSkin", overSkin:"HeaderRenderer_overSkin", disabledSkin:"HeaderRenderer_disabledSkin", selectedDisabledSkin:"HeaderRenderer_selectedDisabledSkin", selectedUpSkin:"HeaderRenderer_selectedUpSkin", selectedDownSkin:"HeaderRenderer_selectedDownSkin", selectedOverSkin:"HeaderRenderer_selectedOverSkin", textFormat:null, disabledTextFormat:null, textPadding:5};
		public function HeaderRenderer():void
		{
			focusEnabled = false;
		}
		public function get column():uint
		{
			return(_column);
		}
		public function set column(p__1:uint):void
		{
			_column = p__1;
		}
		override protected function drawLayout():void
		{
			var l__1:Number = Number(getStyleValue("textPadding"));
			textField.height = (textField.textHeight + 4);
			textField.visible = label.length > 0;
			var l__2:Number = (textField.textWidth + 4);
			var l__3:Number = (textField.textHeight + 4);
			var l__4:Number = (icon == null) ? 0 : ((icon.width + 4));
			var l__5:Number = Math.max(0, Math.min(l__2, ((width - (2 * l__1)) - l__4)));
			if (icon != null){
				icon.x = (((width - l__1) - icon.width) - 2);
				icon.y = Math.round((height - icon.height) / 2);
			}
			textField.width = l__5;
			textField.x = l__1;
			textField.y = Math.round((height - textField.height) / 2);
			background.width = width;
			background.height = height;
		}
		public static function getStyleDefinition():Object
		{
			return(defaultStyles);
		}
	}
}