package com.script.display.custom
{
    import com.script.text.*;
    import flash.display.*;

    public class IconAndText extends MovieClip
    {
        public var textSizes:Array;
        public var iconClip:MovieClip;
        public var textSize:int;
        public var theText:HtmlTextBox;

        public function IconAndText(param1:MovieClip, param2:String, param3:int)
        {
            textSizes = [11, 12, 14];
            iconClip = param1;
            addChild(iconClip);
            textSize = param3;
            theText = new HtmlTextBox("Main", param2, textSizes[textSize], 0);
            theText.x = iconClip.width + 2;
            theText.y = iconClip.height / 2 + 2;
            addChild(theText);
            return;
        }// end function

        private function repositionText() : void
        {
            theText.x = iconClip.width + 2;
            theText.y = iconClip.height / 2 + 2;
            return;
        }// end function

        public function updateText(param1:String) : void
        {
            theText.updateText(param1);
            return;
        }// end function

        public function setIcon(param1:MovieClip) : void
        {
            removeChild(iconClip);
            iconClip = param1;
            addChild(iconClip);
            repositionText();
            return;
        }// end function

    }
}
