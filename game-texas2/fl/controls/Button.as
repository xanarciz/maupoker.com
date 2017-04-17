// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls
{
	import fl.core.*;
	import flash.display.*;
	import flash.events.*;
	import fl.managers.*;
	public class Button extends fl.controls.LabelButton implements IFocusManagerComponent
	{
		protected var emphasizedBorder:flash.display.DisplayObject;
		protected var _emphasized:Boolean = false;
		public static var createAccessibilityImplementation:Function;
		private static var defaultStyles:Object = {emphasizedSkin:"Button_emphasizedSkin", emphasizedPadding:2};
		public function Button()
		{
		}
		public function get emphasized():Boolean
		{
			return(_emphasized);
		}
		public function set emphasized(p__1:Boolean):void
		{
			_emphasized = p__1;
			invalidate(fl.core.InvalidationType.STYLES);
		}
		override protected function draw():void
		{
			if (isInvalid(fl.core.InvalidationType.STYLES) || isInvalid(fl.core.InvalidationType.SIZE)){
				drawEmphasized();
			}
			super.draw();
			if (emphasizedBorder != null){
				setChildIndex(emphasizedBorder, numChildren - 1);
			}
		}
		protected function drawEmphasized():void
		{
			var l__1:Object;
			var l__2:Number;
			if (emphasizedBorder != null){
				removeChild(emphasizedBorder);
			}
			emphasizedBorder = null;
			if (!_emphasized){
				return;
			}
			l__1 = getStyleValue("emphasizedSkin");
			if (l__1 != null){
				emphasizedBorder = getDisplayObjectInstance(l__1);
			}
			if (emphasizedBorder != null){
				addChildAt(emphasizedBorder, 0);
				l__2 = Number(getStyleValue("emphasizedPadding"));
				emphasizedBorder.x = emphasizedBorder.y = -l__2;
				emphasizedBorder.width = (width + (l__2 * 2));
				emphasizedBorder.height = (height + (l__2 * 2));
			}
		}
		override public function drawFocus(p__1:Boolean):void
		{
			var l__2:Number;
			var l__3:* = undefined;
			super.drawFocus(p__1);
			if (p__1){
				l__2 = Number(getStyleValue("emphasizedPadding"));
				if ((l__2 < 0) || (!_emphasized)){
					l__2 = 0;
				}
				l__3 = getStyleValue("focusRectPadding");
				l__3 = (l__3 == null) ? 2 : l__3;
				l__3 = (l__3 + l__2);
				uiFocusRect.x = -l__3;
				uiFocusRect.y = -l__3;
				uiFocusRect.width = (width + (l__3 * 2));
				uiFocusRect.height = (height + (l__3 * 2));
			}
		}
		override protected function initializeAccessibility():void
		{
			if (fl.controls.Button.createAccessibilityImplementation != null){
				fl.controls.Button.createAccessibilityImplementation(this);
			}
		}
		public static function getStyleDefinition():Object
		{
			return(fl.core.UIComponent.mergeStyles(fl.controls.LabelButton.getStyleDefinition(), defaultStyles));
		}
	}
}