package com.script.draw
{
    import flash.display.*;
    import flash.geom.*;

    public class ComplexBox extends Sprite
    {
        public var backing:Sprite;

        public function ComplexBox(param1:Number, param2:Number, param3, param4:Object, param5:Boolean = false, param6:Object = null)
        {
            backing = new Sprite();
            updateGraphics(param1, param2, param3, param4, param5, param6);
            addChild(backing);
            return;
        }// end function

        public function updateGraphics(param1:Number, param2:Number, param3, param4:Object, param5:Boolean = false, param6:Object = null) : void
        {
            var _loc_7:String = null;
            var _loc_8:Array = null;
            var _loc_9:Array = null;
            var _loc_10:Array = null;
            var _loc_11:Number = NaN;
            var _loc_12:Number = NaN;
            var _loc_13:Matrix = null;
            backing.graphics.clear();
            if (param6 != null)
            {
                backing.graphics.lineStyle(param6.size, param6.color, 1, true, LineScaleMode.NONE, CapsStyle.ROUND, JointStyle.ROUND, 15);
            }
            if (param3 is uint)
            {
                backing.graphics.beginFill(param3, 1);
            }
            if (param3 == null)
            {
                backing.graphics.beginFill(0, 1);
            }
            if (!(param3 is uint) && param3 != null)
            {
                _loc_7 = GradientType.LINEAR;
                if (param3.gradient == "radial")
                {
                    _loc_7 = GradientType.RADIAL;
                }
                _loc_8 = param3.colors;
                _loc_9 = param3.alphas;
                _loc_10 = param3.ratios;
                _loc_11 = param3.rotation;
                _loc_12 = _loc_11 * Math.PI / 180;
                _loc_13 = new Matrix();
                _loc_13.createGradientBox(param1, param2, _loc_12, 0, 0);
                backing.graphics.beginGradientFill(_loc_7, _loc_8, _loc_9, _loc_10, _loc_13, SpreadMethod.PAD);
            }
            switch(param4.type.toLowerCase())
            {
                case "rect":
                {
                    backing.graphics.drawRect(0, 0, param1, param2);
                    break;
                }
                case "roundrect":
                {
                    backing.graphics.drawRoundRect(0, 0, param1, param2, param4.corners);
                    break;
                }
                case "complex":
                {
                    backing.graphics.drawRoundRectComplex(0, 0, param1, param2, param4.ul, param4.ur, param4.ll, param4.lr);
                    break;
                }
                case "ellipse":
                {
                    backing.graphics.drawEllipse(0, 0, param1, param2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (param5)
            {
                backing.x = -param1 / 2;
                backing.y = -param2 / 2;
            }
            return;
        }// end function

        public static function getGradientFill(param1:Object) : Graphics
        {
            var _loc_2:* = new Sprite();
            var _loc_3:* = GradientType.LINEAR;
            var _loc_4:* = param1.colors;
            var _loc_5:* = param1.alphas;
            var _loc_6:* = param1.ratios;
            var _loc_7:* = param1.rotation;
            var _loc_8:* = param1.rotation * Math.PI / 180;
            var _loc_9:* = new Matrix();
            new Matrix().createGradientBox(param1.width, param1.height, _loc_8, 0, 0);
            return _loc_2.graphics;
        }// end function

    }
}
