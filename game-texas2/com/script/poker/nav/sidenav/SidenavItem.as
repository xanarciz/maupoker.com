package com.script.poker.nav.sidenav
{
    import caurina.transitions.*;
    import com.script.draw.*;
    import com.script.text.*;
    import flash.display.*;

    public class SidenavItem extends Sprite
    {
        public var bg:ComplexBox;
        public var bgHigh:ComplexBox;
        public var nid:int;
        public var cont:MovieClip;
        public var nNotifs:int;
        public var thisTitle:String;
        public var alert:CountIndicator;
        public var storeIconY:int;
        public var thisColor:uint;
        public var isNotif:Boolean = false;
        public var h:int = 50;
        public var isSelected:Boolean = false;
        public var colors:Array;
        public var tf:HtmlTextBox;
        public var w:int = 50;
        public var icon:MovieClip;

        public function SidenavItem(param1:int, param2:String, param3:Class, param4:int = 0, param5:Boolean = false, param6:Boolean = false) : void
        {
            cont = new MovieClip();
            nNotifs = Math.ceil(Math.random() * 10);
            colors = [8796665, 16750848, 26367, 65280, 16711884, 8796665];
            addChild(cont);
            thisColor = 14531328;
            thisTitle = param2;
            nid = param1;
            makeBg(param5, param6);
            makeText(true);
            makeGfx(param3);
            if (param4 > 0)
            {
                makeAlert(param4);
            }
            return;
        }// end function

        public function makeSelected(param1:Boolean) : void
        {
            isSelected = param1;
            if (isSelected)
            {
                isNotif = false;
                rollOver(0.1);
                Tweener.addTween(MovieClip(icon), {_Glow_alpha:0.6, _Glow_color:16777215, _Glow_blurX:8, _Glow_blurY:8, _Glow_quality:3, time:0.1, transition:"easeOutSine"});
            }
            else
            {
                rollOut(0.1);
                Tweener.addTween(MovieClip(icon), {_Glow_alpha:0, _Glow_blurX:0, _Glow_blurY:0, time:0.1, transition:"easeOutSine"});
            }
            return;
        }// end function

        public function makeBg(param1:Boolean, param2:Boolean) : void
        {
            var _loc_10:MovieClip = null;
            var _loc_3:int = 1;
            var _loc_4:int = 1;
            if (param1)
            {
                _loc_3 = 5;
            }
            if (param2)
            {
                _loc_4 = 5;
            }
            var _loc_5:* = new Object();
            new Object().colors = [2105376, 657930];
            _loc_5.alphas = [1, 1];
            _loc_5.ratios = [0, 7];
            _loc_5.rotation = 90;
            bg = new ComplexBox(w, h, _loc_5, {type:"rect"});
            cont.addChild(bg);
            var _loc_6:* = new SideNavPattern(0, 0);
            var _loc_7:* = new Sprite();
            new Sprite().blendMode = "multiply";
            _loc_7.alpha = 0.2;
            _loc_7.graphics.beginBitmapFill(_loc_6);
            _loc_7.graphics.drawRect(0, 0, w, h);
            _loc_7.graphics.endFill();
            cont.addChild(_loc_7);
            if (param1)
            {
                _loc_10 = new snTopHighlight() as MovieClip;
                _loc_10.blendMode = "screen";
                _loc_10.alpha = 0.1;
                cont.addChild(_loc_10);
            }
            var _loc_8:* = new Object();
            new Object().colors = [26316, 0];
            _loc_8.alphas = [1, 1];
            _loc_8.ratios = [0, 200];
            _loc_8.rotation = 0;
            _loc_8.gradient = "radial";
            bgHigh = new ComplexBox(w, h, _loc_8, {type:"ellipse"});
            bgHigh.blendMode = "screen";
            bgHigh.alpha = 0;
            cont.addChild(bgHigh);
            var _loc_9:* = new ComplexBox(w, h, 16777215, {type:"complex", ul:0, ur:_loc_3, ll:0, lr:_loc_4});
            addChild(_loc_9);
            cont.mask = _loc_9;
            Tweener.addTween(cont, {time:0.01, _DropShadow_alpha:1, _DropShadow_angle:90, _DropShadow_distance:0, _DropShadow_blurX:1.25, _DropShadow_blurY:1.25, _DropShadow_color:0, _DropShadow_quality:3, _DropShadow_strength:10});
            return;
        }// end function

        private function makeAlert(param1:int) : void
        {
            alert = new CountIndicator(param1);
            alert.x = w - 8;
            alert.y = 8;
            cont.addChild(alert);
            return;
        }// end function

        public function hideAlert() : void
        {
            if (alert != null)
            {
                alert.visible = false;
            }
            return;
        }// end function

        public function rollOut(param1:Number = 0.2) : void
        {
            if (!isSelected)
            {
                Tweener.removeTweens(icon, "alpha");
                Tweener.addTween(icon, {alpha:0.5, time:param1, transition:"easeOutSine"});
                if (!isNotif)
                {
                    Tweener.addTween(tf, {alpha:0.5, time:param1, transition:"easeOutSine"});
                }
            }
            return;
        }// end function

        public function rollOver(param1:Number = 0.2) : void
        {
            if (!isSelected)
            {
                Tweener.removeTweens(icon, "alpha");
                Tweener.removeTweens(tf, "alpha");
                Tweener.addTween(icon, {alpha:1, time:param1, transition:"easeOutSine"});
                Tweener.addTween(tf, {alpha:1, time:param1, transition:"easeOutSine"});
            }
            return;
        }// end function

        public function updateAlert(param1:int) : void
        {
            if (param1 < 1)
            {
                this.hideAlert();
                return;
            }
            if (alert == null)
            {
                makeAlert(param1);
            }
            else
            {
                alert.updateCount(param1);
            }
            alert.visible = true;
            return;
        }// end function

        private function makeGfx(param1:Class) : void
        {
            var _loc_2:Class = null;
            if (param1 != null)
            {
                _loc_2 = param1 as Class;
                icon = new _loc_2 as MovieClip;
                icon.x = Math.round(w / 2) + 1;
                icon.y = Math.round(h / 2) - 5;
                storeIconY = icon.y;
                icon.alpha = 0.5;
                cont.addChild(icon);
            }
            return;
        }// end function

        private function makeText(param1:Boolean = false) : void
        {
            var _loc_2:* = thisTitle;
            var _loc_3:uint = 16777215;
            var _loc_4:int = 10;
            tf = new HtmlTextBox("Main", _loc_2, _loc_4, _loc_3, "center");
            tf.alpha = 0.5;
            tf.x = Math.round(w / 2) + 1;
            tf.y = Math.round(h - tf.height) + 8;
            if (param1)
            {
                cont.addChild(tf);
            }
            return;
        }// end function

    }
}
