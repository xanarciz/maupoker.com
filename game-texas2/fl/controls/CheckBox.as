// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls
{
	import fl.core.*;
	import flash.display.*;
	import flash.events.*;
	public class CheckBox extends fl.controls.LabelButton
	{
		public static var createAccessibilityImplementation:Function;
		private static var defaultStyles:Object = {icon:null, upIcon:"CheckBox_upIcon", downIcon:"CheckBox_downIcon", overIcon:"CheckBox_overIcon", disabledIcon:"CheckBox_disabledIcon", selectedDisabledIcon:"CheckBox_selectedDisabledIcon", focusRectSkin:null, focusRectPadding:null, selectedUpIcon:"CheckBox_selectedUpIcon", selectedDownIcon:"CheckBox_selectedDownIcon", selectedOverIcon:"CheckBox_selectedOverIcon", textFormat:null, disabledTextFormat:null, embedFonts:null, textPadding:5};
		public function CheckBox()
		{
		}
		override public function get toggle():Boolean
		{
			return(true);
		}
		override public function set toggle(p__1:Boolean):void
		{
			throw new Error("Warning: You cannot change a CheckBox\'s toggle.");
		}
		override public function get autoRepeat():Boolean
		{
			return(false);
		}
		override public function set autoRepeat(p__1:Boolean):void
		{
		}
		override protected function drawLayout():void
		{
			super.drawLayout();
			var l__1:Number = Number(getStyleValue("textPadding"));
			switch(_labelPlacement){
				case fl.controls.ButtonLabelPlacement.RIGHT:
				{
					icon.x = l__1;
					textField.x = (icon.x + (icon.width + l__1));
					background.width = ((textField.x + textField.width) + l__1);
					background.height = (Math.max(textField.height, icon.height) + (l__1 * 2));
					break;
				}
				case fl.controls.ButtonLabelPlacement.LEFT:
				{
					icon.x = ((width - icon.width) - l__1);
					textField.x = (((width - icon.width) - (l__1 * 2)) - textField.width);
					background.width = ((textField.width + icon.width) + (l__1 * 3));
					background.height = (Math.max(textField.height, icon.height) + (l__1 * 2));
					break;
				}
				case fl.controls.ButtonLabelPlacement.TOP:
				{
				}
				case fl.controls.ButtonLabelPlacement.BOTTOM:
				{
					background.width = (Math.max(textField.width, icon.width) + (l__1 * 2));
					background.height = ((textField.height + icon.height) + (l__1 * 3));
					break;
				}
			}
			background.x = Math.min((icon.x - l__1), (textField.x - l__1));
			background.y = Math.min((icon.y - l__1), (textField.y - l__1));
		}
		override protected function drawBackground():void
		{
		}
		override public function drawFocus(p__1:Boolean):void
		{
			var l__2:Number;
			super.drawFocus(p__1);
			if (p__1){
				l__2 = Number(getStyleValue("focusRectPadding"));
				uiFocusRect.x = (background.x - l__2);
				uiFocusRect.y = (background.y - l__2);
				uiFocusRect.width = (background.width + ((l__2 << 1)));
				uiFocusRect.height = (background.height + ((l__2 << 1)));
			}
		}
		override protected function initializeAccessibility():void
		{
			if (fl.controls.CheckBox.createAccessibilityImplementation != null){
				fl.controls.CheckBox.createAccessibilityImplementation(this);
			}
		}
		override protected function configUI():void
		{
			super.configUI();
			super.toggle = true;
			var l__1:flash.display.Shape = new flash.display.Shape();
			var l__2:flash.display.Graphics = l__1.graphics;
			l__2.beginFill(0, 0);
			l__2.drawRect(0, 0, 100, 100);
			l__2.endFill();
			background = (l__1 as flash.display.DisplayObject);
			addChildAt(background, 0);
		}
		public static function getStyleDefinition():Object
		{
			return(defaultStyles);
		}
	}
}