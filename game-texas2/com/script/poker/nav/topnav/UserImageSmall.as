package com.script.poker.nav.topnav
{
    import com.script.display.*;
    import com.script.draw.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;

    public class UserImageSmall extends MovieClip
    {
        public var ldrPic:SafeImageLoader;
        public var thisURL:String;
        public var picHold:Sprite;

        public function UserImageSmall(param1:String)
        {
            picHold = new Sprite();
            var _loc_2:* = new ComplexBox(30, 30, 0, {type:"rect"}, true);
            addChild(picHold);
            picHold.addChild(_loc_2);
            thisURL = param1;
            loadPlayerPic();
            return;
        }// end function

        private function loadPlayerPic() : void
        {
            var _loc_1:URLRequest = null;
            if (ldrPic != null)
            {
                if (picHold.contains(ldrPic))
                {
                    picHold.removeChild(ldrPic);
                }
                ldrPic = null;
            }
            if (thisURL != "")
            {
                _loc_1 = new URLRequest(thisURL);
                ldrPic = new SafeImageLoader("../Avatar/default.jpg");
                ldrPic.visible = false;
                ldrPic.contentLoaderInfo.addEventListener(Event.COMPLETE, onPicLoadComplete);
                ldrPic.load(_loc_1);
            }
            return;
        }// end function

        private function onPicLoadComplete(event:Event) : void
        {
            var _loc_6:Number = NaN;
            var _loc_2:Number = 0;
            var _loc_3:Number = 0;
            var _loc_4:Number = 26;
            var _loc_5:Number = 26;
            if (ldrPic.height > _loc_5 || ldrPic.width > _loc_4)
            {
                _loc_6 = 1 / Math.max(ldrPic.height / _loc_5, ldrPic.width / _loc_4);
                ldrPic.scaleY = ldrPic.scaleY * _loc_6;
                ldrPic.scaleX = ldrPic.scaleX * _loc_6;
            }
            ldrPic.x = -(ldrPic.width >> 1) + _loc_2;
            ldrPic.y = -(ldrPic.height >> 1) + _loc_3;
            ldrPic.visible = true;
            picHold.addChild(ldrPic);
            return;
        }// end function

    }
}
