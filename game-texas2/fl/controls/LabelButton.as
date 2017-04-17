// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls
{
	import fl.core.*;
	import flash.display.*;
	import flash.events.*;
	import fl.managers.*;
	import fl.events.*;
	import flash.text.*;
	import flash.ui.*;
	public class LabelButton extends fl.controls.BaseButton implements IFocusManagerComponent
	{
		protected var _labelPlacement:String = "right";
		protected var _toggle:Boolean = false;
		protected var icon:flash.display.DisplayObject;
		protected var oldMouseState:String;
		protected var mode:String = "center";
		public var textField:flash.text.TextField;
		protected var _label:String = "Label";
		public static var createAccessibilityImplementation:Function;
		private static var defaultStyles:Object = {icon:null, upIcon:null, downIcon:null, overIcon:null, disabledIcon:null, selectedDisabledIcon:null, selectedUpIcon:null, selectedDownIcon:null, selectedOverIcon:null, textFormat:null, disabledTextFormat:null, textPadding:5, embedFonts:false};
		public function LabelButton()
		{
		}
		public function get label():String
		{
			return(_label);
		}
		public function set label(p__1:String):void
		{
			_label = p__1;
			if (textField.text != _label){
				textField.text = _label;
				dispatchEvent(new fl.events.ComponentEvent(fl.events.ComponentEvent.LABEL_CHANGE));
			}
			invalidate(fl.core.InvalidationType.SIZE);
			invalidate(fl.core.InvalidationType.STYLES);
		}
		public function get labelPlacement():String
		{
			return(_labelPlacement);
		}
		public function set labelPlacement(p__1:String):void
		{
			_labelPlacement = p__1;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		public function get toggle():Boolean
		{
			return(_toggle);
		}
		public function set toggle(p__1:Boolean):void
		{
			if ((!p__1) && super.selected){
				selected = false;
			}
			_toggle = p__1;
			if (_toggle){
				addEventListener(flash.events.MouseEvent.CLICK, toggleSelected, false, 0, true);
			} else {
				removeEventListener(flash.events.MouseEvent.CLICK, toggleSelected);
			}
			invalidate(fl.core.InvalidationType.STATE);
		}
		protected function toggleSelected(p__1:flash.events.MouseEvent):void
		{
			selected = !selected;
			dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE, true));
		}
		override public function get selected():Boolean
		{
			return(_toggle ? _selected : false);
		}
		override public function set selected(p__1:Boolean):void
		{
			_selected = p__1;
			if (_toggle){
				invalidate(fl.core.InvalidationType.STATE);
			}
		}
		override protected function configUI():void
		{
			super.configUI();
			textField = new flash.text.TextField();
			textField.type = flash.text.TextFieldType.DYNAMIC;
			textField.selectable = false;
			addChild(textField);
		}
		override protected function draw():void
		{
			if (textField.text != _label){
				label = _label;
			}
			if (isInvalid(fl.core.InvalidationType.STYLES, fl.core.InvalidationType.STATE)){
				drawBackground();
				drawIcon();
				drawTextFormat();
				invalidate(fl.core.InvalidationType.SIZE, false);
			}
			if (isInvalid(fl.core.InvalidationType.SIZE)){
				drawLayout();
			}
			if (isInvalid(fl.core.InvalidationType.SIZE, fl.core.InvalidationType.STYLES)){
				if (isFocused && focusManager.showFocusIndicator){
					drawFocus(true);
				}
			}
			validate();
		}
		protected function drawIcon():void
		{
			var l__1:flash.display.DisplayObject;
			var l__2:String;
			var l__3:Object;
			l__1 = icon;
			l__2 = enabled ? mouseState : "disabled";
			if (selected){
				l__2 = (("selected" + l__2.AS3::substr(0, 1).AS3::toUpperCase()) + l__2.AS3::substr(1));
			}
			l__2 = (l__2 + "Icon");
			l__3 = getStyleValue(l__2);
			if (l__3 == null){
				l__3 = getStyleValue("icon");
			}
			if (l__3 != null){
				icon = getDisplayObjectInstance(l__3);
			}
			if (icon != null){
				addChildAt(icon, 1);
			}
			if (!(l__1 == null) && !(l__1 == icon)){
				removeChild(l__1);
			}
		}
		protected function drawTextFormat():void
		{
			var l__1:Object;
			var l__2:flash.text.TextFormat;
			var l__3:flash.text.TextFormat;
			l__1 = fl.core.UIComponent.getStyleDefinition();
			l__2 = enabled ? (l__1.defaultTextFormat as flash.text.TextFormat) : (l__1.defaultDisabledTextFormat as flash.text.TextFormat);
			textField.setTextFormat(l__2);
			l__3 = (getStyleValue(enabled ? "textFormat" : "disabledTextFormat") as flash.text.TextFormat);
			if (l__3 != null){
				textField.setTextFormat(l__3);
			} else {
				l__3 = l__2;
			}
			textField.defaultTextFormat = l__3;
			setEmbedFont();
		}
		protected function setEmbedFont()
		{
			var l__1:Object;
			l__1 = getStyleValue("embedFonts");
			if (l__1 != null){
				textField.embedFonts = l__1;
			}
		}
		override protected function drawLayout():void
		{
			var l__1:Number;
			var l__2:String;
			var l__3:Number;
			var l__4:Number;
			var l__5:Number;
			var l__6:Number;
			var l__7:Number;
			var l__8:Number;
			l__1 = Number(getStyleValue("textPadding"));
			l__2 = ((icon == null) && (mode == "center")) ? fl.controls.ButtonLabelPlacement.TOP : _labelPlacement;
			textField.height = (textField.textHeight + 4);
			l__3 = (textField.textWidth + 4);
			l__4 = (textField.textHeight + 4);
			l__5 = (icon == null) ? 0 : (icon.width + l__1);
			l__6 = (icon == null) ? 0 : (icon.height + l__1);
			textField.visible = label.length > 0;
			if (icon != null){
				icon.x = Math.round((width - icon.width) / 2);
				icon.y = Math.round((height - icon.height) / 2);
			}
			if (textField.visible == false){
				textField.width = 0;
				textField.height = 0;
			} else if ((l__2 == fl.controls.ButtonLabelPlacement.BOTTOM) || (l__2 == fl.controls.ButtonLabelPlacement.TOP)){
				l__7 = Math.max(0, Math.min(l__3, (width - (2 * l__1))));
				if ((height - 2) > l__4){
					l__8 = l__4;
				} else {
					l__8 = (height - 2);
				}
				textField.width = l__3 = l__7;
				textField.height = l__4 = l__8;
				textField.x = Math.round((width - l__3) / 2);
				textField.y = Math.round(((height - textField.height) - l__6) / 2 + ((l__2 == fl.controls.ButtonLabelPlacement.BOTTOM) ? l__6 : 0));
				if (icon != null){
					icon.y = Math.round((l__2 == fl.controls.ButtonLabelPlacement.BOTTOM) ? (textField.y - l__6) : ((textField.y + textField.height) + l__1));
				}
			} else {
				l__7 = Math.max(0, Math.min(l__3, ((width - l__5) - (2 * l__1))));
				textField.width = l__3 = l__7;
				textField.x = Math.round(((width - l__3) - l__5) / 2 + ((l__2 != fl.controls.ButtonLabelPlacement.LEFT) ? l__5 : 0));
				textField.y = Math.round((height - textField.height) / 2);
				if (icon != null){
					icon.x = Math.round((l__2 != fl.controls.ButtonLabelPlacement.LEFT) ? (textField.x - l__5) : ((textField.x + l__3) + l__1));
				}
			}
			super.drawLayout();
		}
		override protected function keyDownHandler(p__1:flash.events.KeyboardEvent):void
		{
			if (!enabled){
				return;
			}
			if (p__1.keyCode == flash.ui.Keyboard.SPACE){
				if (oldMouseState == null){
					oldMouseState = mouseState;
				}
				setMouseState("down");
				startPress();
			}
		}
		override protected function keyUpHandler(p__1:flash.events.KeyboardEvent):void
		{
			if (!enabled){
				return;
			}
			if (p__1.keyCode == flash.ui.Keyboard.SPACE){
				setMouseState(oldMouseState);
				oldMouseState = null;
				endPress();
				dispatchEvent(new flash.events.MouseEvent(flash.events.MouseEvent.CLICK));
			}
		}
		override protected function initializeAccessibility():void
		{
			if (fl.controls.LabelButton.createAccessibilityImplementation != null){
				fl.controls.LabelButton.createAccessibilityImplementation(this);
			}
		}
		public static function getStyleDefinition():Object
		{
			return(mergeStyles(defaultStyles, fl.controls.BaseButton.getStyleDefinition()));
		}
	}
}