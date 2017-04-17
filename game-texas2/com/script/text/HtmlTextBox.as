package com.script.text
{
    import flash.display.*;
    import flash.text.*;

    public class HtmlTextBox extends MovieClip
    {
        public var thisColor:uint;
        public var _color:uint;
        public var thisAuto:Boolean;
        public var thisJust:String;
        public var tf:TextField;
        public var thisMulti:Boolean;
        public var thisFont:String;
        public var thisSize:int;

        public function HtmlTextBox(param1:String, param2:String, param3:int, param4:uint, param5:String = "left", param6:Boolean = true, param7:Boolean = false, param8:Boolean = false, param9:int = -1) : void
        {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            thisFont = param1;
            thisColor = param4;
            thisSize = param3;
            thisJust = param5;
            thisAuto = param6;
            thisMulti = param7;
            tf = new TextField();
            tf.multiline = thisMulti;
            if (thisMulti)
            {
                tf.wordWrap = thisMulti;
            }
            tf.selectable = param8;
            tf.embedFonts = thisFont == "Arial" || thisFont == "Arial Bold" ? (false) : (true);
            if (param9 > -1)
            {
                tf.width = param9;
            }
            addChild(tf);
            updateText(param2);
            return;
        }// end function

        public function setWidth(param1:int) : void
        {
            tf.width = param1;
            return;
        }// end function

        public function updateHtmlText(param1:String) : void
        {
            tf.htmlText = param1;
            updateJust();
            return;
        }// end function

        public function updateJust(param1:String = null) : void
        {
            thisJust = param1;
            if (thisAuto && thisJust != null)
            {
                tf.autoSize = thisJust;
                if (thisJust == "center")
                {
                    tf.x = Math.round(-tf.width / 2);
                }
                if (thisJust == "right")
                {
                    tf.x = -tf.width;
                }
            }
            if (!thisMulti)
            {
                tf.y = Math.round(-tf.height / 2) - 1;
            }
            return;
        }// end function

        public function updateText(param1:String, param2:int = -1) : void
        {
            if (param2 > -1)
            {
                thisSize = param2;
            }
            var _loc_3:* = "<font face=\"" + thisFont + "\" color=\"#" + thisColor.toString(16).toUpperCase() + "\" size=\"" + thisSize + "\">" + param1 + "</font>";
            tf.htmlText = _loc_3;
            if (thisAuto)
            {
                tf.autoSize = thisJust;
                if (thisJust == "center" && !thisMulti)
                {
                    tf.x = Math.round(-tf.width / 2);
                }
                if (thisJust == "right")
                {
                    tf.x = -tf.width;
                }
            }
            if (!thisMulti)
            {
                tf.y = Math.round(-tf.height / 2) - 1;
            }
            return;
        }// end function

        public static function getHtmlString(param1:Array) : String
        {
            var _loc_4:* = undefined;
            var _loc_5:Object = null;
            var _loc_2:* = param1.concat();
            var _loc_3:String = "";
            for (_loc_4 in _loc_2)
            {
                
                _loc_5 = _loc_2[_loc_4];
                _loc_3 = _loc_3 + ("<font face=\"" + _loc_2[_loc_4].font + "\" size=\"" + _loc_2[_loc_4].size.toString() + "\" color=\"#" + _loc_2[_loc_4].color.toString(16) + "\">" + _loc_2[_loc_4].text + "</font>");
            }
            return _loc_3;
        }// end function

    }
}
