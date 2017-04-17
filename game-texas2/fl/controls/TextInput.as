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
	public class TextInput extends fl.core.UIComponent implements IFocusManagerComponent
	{
		public var textField:flash.text.TextField;
		protected var _html:Boolean = false;
		protected var background:flash.display.DisplayObject;
		protected var _savedHTML:String;
		protected var _editable:Boolean = true;
		public static var createAccessibilityImplementation:Function;
		private static var defaultStyles:Object = {upSkin:"TextInput_upSkin", disabledSkin:"TextInput_disabledSkin", focusRectSkin:null, focusRectPadding:null, textFormat:null, disabledTextFormat:null, textPadding:0, embedFonts:false};
		public function TextInput()
		{
		}
		public function get text():String
		{
			return(textField.text);
		}
		public function set text(p__1:String):void
		{
			textField.text = p__1;
			_html = false;
			invalidate(fl.core.InvalidationType.DATA);
			invalidate(fl.core.InvalidationType.STYLES);
		}
		override public function get enabled():Boolean
		{
			return(super.enabled);
		}
		override public function set enabled(p__1:Boolean):void
		{
			super.enabled = p__1;
			updateTextFieldType();
		}
		public function get imeMode():String
		{
			return(_imeMode);
		}
		public function set imeMode(p__1:String):void
		{
			_imeMode = p__1;
		}
		public function get alwaysShowSelection():Boolean
		{
			return(textField.alwaysShowSelection);
		}
		public function set alwaysShowSelection(p__1:Boolean):void
		{
			textField.alwaysShowSelection = p__1;
		}
		override public function drawFocus(p__1:Boolean):void
		{
			if (focusTarget != null){
				focusTarget.drawFocus(p__1);
				return;
			}
			super.drawFocus(p__1);
		}
		public function get editable():Boolean
		{
			return(_editable);
		}
		public function set editable(p__1:Boolean):void
		{
			_editable = p__1;
			updateTextFieldType();
		}
		public function get horizontalScrollPosition():int
		{
			return(textField.scrollH);
		}
		public function set horizontalScrollPosition(p__1:int):void
		{
			textField.scrollH = p__1;
		}
		public function get maxHorizontalScrollPosition():int
		{
			return(textField.maxScrollH);
		}
		public function get length():int
		{
			return(textField.length);
		}
		public function get maxChars():int
		{
			return(textField.maxChars);
		}
		public function set maxChars(p__1:int):void
		{
			textField.maxChars = p__1;
		}
		public function get displayAsPassword():Boolean
		{
			return(textField.displayAsPassword);
		}
		public function set displayAsPassword(p__1:Boolean):void
		{
			textField.displayAsPassword = p__1;
		}
		public function get restrict():String
		{
			return(textField.restrict);
		}
		public function set restrict(p__1:String):void
		{
			if (componentInspectorSetting && ((p__1) == "")){
				p__1 = null;
			}
			textField.restrict = p__1;
		}
		public function get selectionBeginIndex():int
		{
			return(textField.selectionBeginIndex);
		}
		public function get selectionEndIndex():int
		{
			return(textField.selectionEndIndex);
		}
		public function get condenseWhite():Boolean
		{
			return(textField.condenseWhite);
		}
		public function set condenseWhite(p__1:Boolean):void
		{
			textField.condenseWhite = p__1;
		}
		public function get htmlText():String
		{
			return(textField.htmlText);
		}
		public function set htmlText(p__1:String):void
		{
			if ((p__1) == ""){
				text = "";
				return;
			}
			_html = true;
			_savedHTML = p__1;
			textField.htmlText = p__1;
			invalidate(fl.core.InvalidationType.DATA);
			invalidate(fl.core.InvalidationType.STYLES);
		}
		public function get textHeight():Number
		{
			return(textField.textHeight);
		}
		public function get textWidth():Number
		{
			return(textField.textWidth);
		}
		public function setSelection(p__1:int, p__2:int):void
		{
			textField.setSelection(p__1, p__2);
		}
		public function getLineMetrics(p__1:int):flash.text.TextLineMetrics
		{
			return(textField.getLineMetrics(p__1));
		}
		public function appendText(p__1:String):void
		{
			textField.appendText(p__1);
		}
		protected function updateTextFieldType():void
		{
			textField.type = (enabled && editable) ? flash.text.TextFieldType.INPUT : flash.text.TextFieldType.DYNAMIC;
			textField.selectable = enabled;
		}
		protected function handleKeyDown(p__1:flash.events.KeyboardEvent):void
		{
			if ((p__1.keyCode) == flash.ui.Keyboard.ENTER){
				dispatchEvent(new fl.events.ComponentEvent(fl.events.ComponentEvent.ENTER, true));
			}
		}
		protected function handleChange(p__1:flash.events.Event):void
		{
			(p__1).stopPropagation();
			dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE, true));
		}
		protected function handleTextInput(p__1:flash.events.TextEvent):void
		{
			(p__1).stopPropagation();
			dispatchEvent(new flash.events.TextEvent(flash.events.TextEvent.TEXT_INPUT, true, false, p__1.text));
		}
		protected function setEmbedFont()
		{
			var l__1:Object = getStyleValue("embedFonts");
			if (l__1 != null){
				textField.embedFonts = l__1;
			}
		}
		override protected function draw():void
		{
			var l__1:Object;
			if (isInvalid(fl.core.InvalidationType.STYLES, fl.core.InvalidationType.STATE)){
				drawTextFormat();
				drawBackground();
				l__1 = getStyleValue("embedFonts");
				if ((l__1) != null){
					textField.embedFonts = l__1;
				}
				invalidate(fl.core.InvalidationType.SIZE, false);
			}
			if (isInvalid(fl.core.InvalidationType.SIZE)){
				drawLayout();
			}
			super.draw();
		}
		protected function drawBackground():void
		{
			var l__1:flash.display.DisplayObject = background;
			var l__2:String = enabled ? "upSkin" : "disabledSkin";
			background = getDisplayObjectInstance(getStyleValue(l__2));
			if (background == null){
				return;
			}
			addChildAt(background, 0);
			if ((!(l__1 == null) && !(l__1 == background)) && contains(l__1)){
				removeChild(l__1);
			}
		}
		protected function drawTextFormat():void
		{
			var l__1:Object = fl.core.UIComponent.getStyleDefinition();
			var l__2:flash.text.TextFormat = enabled ? ((l__1.defaultTextFormat as flash.text.TextFormat)) : ((l__1.defaultDisabledTextFormat as flash.text.TextFormat));
			textField.setTextFormat(l__2);
			var l__3:flash.text.TextFormat = (getStyleValue(enabled ? "textFormat" : "disabledTextFormat") as flash.text.TextFormat);
			if (l__3 != null){
				textField.setTextFormat(l__3);
			} else {
				l__3 = l__2;
			}
			textField.defaultTextFormat = l__3;
			setEmbedFont();
			if (_html){
				textField.htmlText = _savedHTML;
			}
		}
		protected function drawLayout():void
		{
			var l__1:Number = Number(getStyleValue("textPadding"));
			if (background != null){
				background.width = width;
				background.height = height;
			}
			textField.width = (width - (2 * l__1));
			textField.height = (height - (2 * l__1));
			textField.x = textField.y = l__1;
		}
		override protected function configUI():void
		{
			super.configUI();
			tabChildren = true;
			textField = new flash.text.TextField();
			addChild(textField);
			updateTextFieldType();
			textField.addEventListener(flash.events.TextEvent.TEXT_INPUT, handleTextInput, false, 0, true);
			textField.addEventListener(flash.events.Event.CHANGE, handleChange, false, 0, true);
			textField.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, handleKeyDown, false, 0, true);
		}
		override public function setFocus():void
		{
			stage.focus = textField;
		}
		override protected function isOurFocus(p__1:flash.display.DisplayObject):Boolean
		{
			return(((p__1) == textField) || super.isOurFocus(p__1));
		}
		override protected function focusInHandler(p__1:flash.events.FocusEvent):void
		{
			if ((p__1.target) == this){
				stage.focus = textField;
			}
			var l__2:fl.managers.IFocusManager = focusManager;
			if (editable && l__2){
				l__2.showFocusIndicator = true;
				if (textField.selectable && (textField.selectionBeginIndex == textField.selectionBeginIndex)){
					setSelection(0, textField.length);
				}
			}
			super.focusInHandler(p__1);
			if (editable){
				setIMEMode(true);
			}
		}
		override protected function focusOutHandler(p__1:flash.events.FocusEvent):void
		{
			super.focusOutHandler(p__1);
			if (editable){
				setIMEMode(false);
			}
		}
		public static function getStyleDefinition():Object
		{
			return(defaultStyles);
		}
	}
}