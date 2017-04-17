package com.script.text
{
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;

    public class GlowTextBox extends Sprite
    {
        private var _text:String = "";
        private var textField:TextField;
        private var font:String;
        private var fontSize:int;
        private var fontColor:uint;
        private var _glowColor:uint;

        public function GlowTextBox(param1:String, param2:String = "Main", param3:int = 11, param4:uint = 16777215, param5:uint = 16711680, param6:int = -20) : void
        {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this.font = param2;
            this.fontColor = param4;
            this.fontSize = param3;
            this.glowColor = param5;
            this.rotation = param6;
            this.text = param1;
            return;
        }// end function

        public function set text(param1:String) : void
        {
            this._text = param1;
            if (this.textField == null)
            {
                this.textField = new TextField();
                this.textField.autoSize = "left";
                this.textField.embedFonts = this.font == "Arial" || this.font == "Arial Bold" ? (false) : (true);
                this.textField.multiline = false;
                this.textField.selectable = false;
                this.textField.wordWrap = false;
                this.textField.y = -this.textField.height / 2;
                addChild(this.textField);
            }
            this.textField.htmlText = "<font face=\"" + this.font + "\" color=\"#" + this.fontColor.toString(16).toUpperCase() + "\" size=\"" + this.fontSize + "\">" + param1 + "</font>";
            return;
        }// end function

        public function get glowColor() : uint
        {
            return this._glowColor;
        }// end function

        public function set glowColor(param1:uint) : void
        {
            this._glowColor = param1;
            this.filters = [new GlowFilter(this._glowColor, 1, 2, 2, 10, BitmapFilterQuality.HIGH)];
            return;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

    }
}
