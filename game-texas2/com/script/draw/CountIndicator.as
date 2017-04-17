package com.script.draw
{
    import caurina.transitions.*;
    import com.script.text.*;
    import flash.display.*;
    import flash.filters.*;

    public class CountIndicator extends MovieClip
    {
        public var bg:Sprite;
        public var hPad:int = 4;
        public var thisColor:uint;
        public var tf:HtmlTextBox;
        public var vPad:int = -2;

        public function CountIndicator(param1:int)
        {
            tf = new HtmlTextBox("MainCondensed", param1.toString(), 12, 16777215, "center");
            positionTf();
            tf.filters = [new DropShadowFilter(1, 90, 0, 1, 3, 3, 1, 3)];
            var _loc_2:* = new Object();
            _loc_2.colors = [16711680, 11141120];
            _loc_2.alphas = [1, 1];
            _loc_2.ratios = [0, 255];
            _loc_2.rotation = 90;
            var _loc_3:Number = 16;
            var _loc_4:Number = 16;
            bg = new Sprite();
            bg.graphics.beginFill(6296334, 1);
            bg.graphics.drawCircle(_loc_3 / 2, _loc_4 / 2, (_loc_3 + _loc_4) / 4);
            bg.graphics.endFill();
            bg.graphics.beginFill(11413539, 1);
            bg.graphics.moveTo(1.5, _loc_4 / 3.5);
            bg.graphics.curveTo(3, 1, _loc_3 / 2, 0.5);
            bg.graphics.curveTo(_loc_3 - 3, 0.5, _loc_3 - 1.5, _loc_4 / 3.5);
            bg.graphics.curveTo(_loc_3 - 0.5, _loc_4 / 1.7, _loc_3 / 2, _loc_4 / 1.7);
            bg.graphics.curveTo(0.5, _loc_4 / 1.7, 1.5, _loc_4 / 3.5);
            bg.graphics.endFill();
            bg.x = -_loc_3 / 2;
            bg.y = -_loc_4 / 2;
            addChild(bg);
            addChild(tf);
            return;
        }// end function

        public function startBlink() : void
        {
            Tweener.addTween(bg, {_Glow_alpha:1, _Glow_color:thisColor, _Glow_blurX:5, _Glow_blurY:5, _Glow_quality:3, time:0.25, transition:"easeOutSine"});
            Tweener.addTween(bg, {_Glow_alpha:0, _Glow_blurX:0, _Glow_blurY:0, delay:0.3, time:0.25, transition:"easeOutSine", onComplete:startBlink});
            return;
        }// end function

        public function updateCount(param1:int) : void
        {
            tf.updateText(param1.toString());
            positionTf();
            return;
        }// end function

        private function positionTf() : void
        {
            tf.y = 0;
            return;
        }// end function

    }
}
