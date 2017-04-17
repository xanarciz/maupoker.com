package com.script.draw.tooltip
{
    import com.script.draw.*;
    import com.script.text.*;
    import flash.display.*;
    import flash.filters.*;

    public class Tooltip extends MovieClip
    {
        private var theWidth:int;
        public var theText:HtmlTextBox;
        public var theBg:ComplexBox;
        public var theTitle:HtmlTextBox;

        public function Tooltip(param1:int, param2, param3:String = null, param4:String = "ul") : void
		
        {
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_5:String = "";
            this.mouseEnabled = false;
            this.mouseChildren = false;
            if (param2 is String)
            {
                _loc_5 = param2;
            }
            theText = new HtmlTextBox("MainLight", _loc_5, 11, 0, "left", true, true, false, param1);
            theText.y = -5;
            if (param3 != null)
            {
                theText.y = 14;
                theTitle = new HtmlTextBox("Main", param3, 12, 0, "left");
                theTitle.y = 6;
                addChild(theTitle);
            }
            if (param2 is Array)
            {
                _loc_7 = HtmlTextBox.getHtmlString(param2);
                theText.updateHtmlText(_loc_7);
            }
            addChild(theText);
            theBg = new ComplexBox(param1 + 20, theText.y + theText.height + 16, 16777215, {type:"roundrect", corners:9});
            var _loc_8:int = -10;
            theBg.y = -10;
            theBg.x = _loc_8;
            theBg.mouseEnabled = false;
            theBg.alpha = 0.9;
            theBg.backing.graphics.beginFill(16777215);
            if (param4 == "ul")
            {
                theBg.backing.graphics.moveTo(15, -8);
                theBg.backing.graphics.lineTo(10, 0);
                theBg.backing.graphics.lineTo(20, 0);
                theBg.backing.graphics.lineTo(15, -8);
            }
            if (param4 == "ur")
            {
                theBg.backing.graphics.moveTo(param1 - 15, -8);
                theBg.backing.graphics.lineTo(param1 - 10, 0);
                theBg.backing.graphics.lineTo(param1 - 0, 0);
                theBg.backing.graphics.lineTo(param1 - 15, -8);
            }
            if (param4 == "ll")
            {
                theBg.backing.graphics.moveTo(10, theBg.height);
                theBg.backing.graphics.lineTo(5, theBg.height - 10);
                theBg.backing.graphics.lineTo(15, theBg.height - 10);
                theBg.backing.graphics.lineTo(10, theBg.height);
            }
            if (param4 == "lr")
            {
                theBg.backing.graphics.moveTo(param1 - 10, theBg.height);
                theBg.backing.graphics.lineTo(param1 - 5, theBg.height - 10);
                theBg.backing.graphics.lineTo(param1 + 5, theBg.height - 10);
                theBg.backing.graphics.lineTo(param1 - 10, theBg.height);
            }
            theBg.backing.graphics.endFill();
            theBg.filters = [new GlowFilter(0, 0.75, 9, 9, 1, 3)];
            addChildAt(theBg, 0);
            theWidth = param1;
            updateDimensions();
            return;
        }// end function

        public function updateHtmlText(param1:Array) : void
        {
            if (theText != null)
            {
                theText.updateHtmlText(HtmlTextBox.getHtmlString(param1));
                updateDimensions();
            }
            return;
        }// end function

        private function updateDimensions() : void
        {
            if (theBg != null)
            {
                removeChildAt(0);
            }
            theBg = new ComplexBox(theWidth + 20, theText.y + theText.height + 16, 16777215, {type:"roundrect", corners:9});
            var _loc_1:int = -10;
            theBg.y = -10;
            theBg.x = _loc_1;
            theBg.filters = [new DropShadowFilter(0.75, 90, 0, 1, 5, 5, 0.75, 3)];
            addChildAt(theBg, 0);
            return;
        }// end function

    }
}
