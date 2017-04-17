// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package fl.controls
{
	import fl.core.*;
	import flash.display.*;
	import flash.events.*;
	import fl.events.*;
	import flash.text.*;
	public class Label extends fl.core.UIComponent
	{
		protected var _savedHTML:String;
		protected var _html:Boolean = false;
		public var textField:flash.text.TextField;
		protected var actualHeight:Number;
		protected var actualWidth:Number;
		protected var defaultLabel:String = "Label";
		private static var defaultStyles:Object = {textFormat:null, embedFonts:false};
		public function Label()
		{
			text = defaultLabel;
			actualWidth = _width;
			actualHeight = _height;
		}
		public function get text():String
		{
			return(textField.text);
		}
		public function set text(p__1:String):void
		{
			if ((p__1) == text){
				return;
			}
			if (componentInspectorSetting && ((p__1) == defaultLabel)){
				return;
			}
			_html = false;
			textField.text = p__1;
			if (textField.autoSize != flash.text.TextFieldAutoSize.NONE){
				invalidate(fl.core.InvalidationType.SIZE);
			}
		}
		public function get htmlText():String
		{
			return(textField.htmlText);
		}
		public function set htmlText(p__1:String):void
		{
			if ((p__1) == htmlText){
				return;
			}
			if (componentInspectorSetting && ((p__1) == "")){
				return;
			}
			_html = true;
			_savedHTML = p__1;
			textField.htmlText = p__1;
			if (textField.autoSize != flash.text.TextFieldAutoSize.NONE){
				invalidate(fl.core.InvalidationType.SIZE);
			}
		}
		public function get condenseWhite():Boolean
		{
			return(textField.condenseWhite);
		}
		public function set condenseWhite(p__1:Boolean):void
		{
			textField.condenseWhite = p__1;
			if (textField.autoSize != flash.text.TextFieldAutoSize.NONE){
				invalidate(fl.core.InvalidationType.SIZE);
			}
		}
		public function get selectable():Boolean
		{
			return(textField.selectable);
		}
		public function set selectable(p__1:Boolean):void
		{
			textField.selectable = p__1;
		}
		public function get wordWrap():Boolean
		{
			return(textField.wordWrap);
		}
		public function set wordWrap(p__1:Boolean):void
		{
			textField.wordWrap = p__1;
			if (textField.autoSize != flash.text.TextFieldAutoSize.NONE){
				invalidate(fl.core.InvalidationType.SIZE);
			}
		}
		public function get autoSize():String
		{
			return(textField.autoSize);
		}
		public function set autoSize(p__1:String):void
		{
			textField.autoSize = p__1;
			invalidate(fl.core.InvalidationType.SIZE);
		}
		override public function get width():Number
		{
			if (!(textField.autoSize == flash.text.TextFieldAutoSize.NONE) && (!wordWrap)){
				return(_width);
			}
			return(actualWidth);
		}
		override public function set width(p__1:Number):void
		{
			actualWidth = p__1;
			super.width = p__1;
		}
		override public function get height():Number
		{
			if (!(textField.autoSize == flash.text.TextFieldAutoSize.NONE) && wordWrap){
				return(_height);
			}
			return(actualHeight);
		}
		override public function setSize(p__1:Number, p__2:Number):void
		{
			actualWidth = p__1;
			actualHeight = p__2;
			super.setSize(p__1, p__2);
		}
		override protected function configUI():void
		{
			super.configUI();
			textField = new flash.text.TextField();
			addChild(textField);
			textField.type = flash.text.TextFieldType.DYNAMIC;
			textField.selectable = false;
			textField.wordWrap = false;
		}
		override protected function draw():void
		{
			var l__1:Object;
			if (isInvalid(fl.core.InvalidationType.STYLES, fl.core.InvalidationType.STATE)){
				drawTextFormat();
				l__1 = getStyleValue("embedFonts");
				if (l__1 != null){
					textField.embedFonts = l__1;
				}
				if (textField.autoSize != flash.text.TextFieldAutoSize.NONE){
					invalidate(fl.core.InvalidationType.SIZE, false);
				}
			}
			if (isInvalid(fl.core.InvalidationType.SIZE)){
				drawLayout();
			}
			super.draw();
		}
		protected function drawTextFormat():void
		{
			var l__2:Object;
			var l__1:flash.text.TextFormat = (getStyleValue("textFormat") as flash.text.TextFormat);
			if (l__1 == null){
				l__2 = fl.core.UIComponent.getStyleDefinition();
				l__1 = enabled ? (l__2.defaultTextFormat as flash.text.TextFormat) : (l__2.defaultDisabledTextFormat as flash.text.TextFormat);
			}
			textField.defaultTextFormat = l__1;
			textField.setTextFormat(l__1);
			if (_html && !(_savedHTML == null)){
				htmlText = _savedHTML;
			}
		}
		protected function drawLayout():void
		{
			var l__2:Number;
			var l__3:Number;
			var l__1:Boolean;
			textField.width = width;
			textField.height = height;
			if (textField.autoSize != flash.text.TextFieldAutoSize.NONE){
				l__2 = textField.width;
				l__3 = textField.height;
				l__1 = !(_width == l__2) || !(_height == l__3);
				_width = l__2;
				_height = l__3;
				switch(textField.autoSize){
					case flash.text.TextFieldAutoSize.CENTER:
					{
						textField.x = (actualWidth / 2 - (textField.width / 2));
						break;
					}
					case flash.text.TextFieldAutoSize.LEFT:
					{
						textField.x = 0;
						break;
					}
					case flash.text.TextFieldAutoSize.RIGHT:
					{
						textField.x = -(textField.width - actualWidth);
						break;
					}
				}
			} else {
				textField.width = actualWidth;
				textField.height = actualHeight;
				textField.x = 0;
			}
			if (l__1){
				dispatchEvent(new fl.events.ComponentEvent(fl.events.ComponentEvent.RESIZE, true));
			}
		}
		public static function getStyleDefinition():Object
		{
			return(defaultStyles);
		}
	}
}