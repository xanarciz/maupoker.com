package com.script.poker.nav.topnav
{
    import com.script.draw.*;
    import flash.display.*;

    public class Seperator extends Sprite
    {

        public function Seperator() : void
        {
            var _loc_1:* = new ComplexBox(1, 30, 657930, {type:"rect"});
            _loc_1.y = -15;
            _loc_1.x = -1;
            _loc_1.alpha = 1;
            addChild(_loc_1);
            var _loc_2:* = new ComplexBox(1, 30, 3620416, {type:"rect"});
            _loc_2.y = -15;
            _loc_2.x = 0;
            _loc_2.alpha = 1;
            addChild(_loc_2);
            return;
        }// end function

    }
}
