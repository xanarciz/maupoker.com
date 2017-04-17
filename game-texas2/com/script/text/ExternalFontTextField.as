package com.script.text
{
    import flash.text.*;

    public class ExternalFontTextField extends TextField
    {
        private var fontFace:String = "Main";
        private var fontSize:int = 11;
        private var fontColor:uint = 0;
        private var fontAlign:String = "left";
        private var _text:String = "";

        public function ExternalFontTextField(param1:String, param2:String = "Main", param3:int = 11, param4:uint = 0, param5:String = "left")
        {
            this.embedFonts = this.fontFace == "Arial" || this.fontFace == "Arial Bold" ? (false) : (true);
            this.fontFace = param2;
            this.fontAlign = param5;
            this.fontColor = param4;
            this.fontSize = param3;
            this.text = param1;
            return;
        }// end function

        override public function get text() : String
        {
            return this._text;
        }// end function

        private function refreshText() : void
        {
            this.htmlText = "<p align=\"" + this.fontAlign + "\"><font face=\"" + this.fontFace + "\" color=\"#" + this.fontColor.toString(16).toUpperCase() + "\" size=\"" + this.fontSize + "\">" + this._text + "</font></p>";
            return;
        }// end function

        override public function set text(param1:String) : void
        {
            this._text = param1;
            refreshText();
            return;
        }// end function

    }
}
