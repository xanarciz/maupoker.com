package com.script.poker.commonUI.notifs
{
    import com.script.display.*;
    import com.script.poker.commonUI.events.*;
    import com.script.text.*;
    import flash.events.*;
    import flash.net.*;

    public class JoinedTableNotif extends BaseNotif
    {
        public var pObj:Object;
        private var namefield:HtmlTextBox;
        public var ldrPic:SafeImageLoader;
        private var line2:HtmlTextBox;

        public function JoinedTableNotif(param1:Object)
        {
            this.pObj = param1;
            ldrPic = new SafeImageLoader("../Avatar/default.jpg");
            ldrPic.contentLoaderInfo.addEventListener(Event.COMPLETE, onPicLoadComplete);
            ldrPic.mouseEnabled = false;
            var _loc_2:* = new URLRequest(pObj["source"]);
            ldrPic.load(_loc_2);
            if (pObj["label"].length > 16)
            {
                pObj["label"] = pObj["label"].slice(0, 16) + "...";
                ;
            }
            namefield = new HtmlTextBox("Main", pObj["label"], 14, 0, "left");
            addChild(namefield);
            namefield.x = 55;
            namefield.y = -2;
            line2 = new HtmlTextBox("Main", "joined your table!", 12, 0, "left");
            addChild(line2);
            line2.x = 55;
            line2.y = 17;
            return;
        }// end function

        override public function cleanUp(event:Event) : void
        {
            super.cleanUp(event);
            return;
        }// end function

        private function onPicLoadComplete(event:Event) : void
        {
            var _loc_2:Number = 50;
            var _loc_3:Number = 50;
            ldrPic.height = _loc_3;
            ldrPic.width = _loc_2;
            ldrPic.x = 2;
            ldrPic.y = -10;
            addChild(ldrPic);
            ldrPic.contentLoaderInfo.removeEventListener(Event.COMPLETE, onPicLoadComplete);
            return;
        }// end function

        public function get zid() : String
        {
            return pObj["uid"];
        }// end function

        public function init() : void
        {
            return;
        }// end function

        private function onJoinPressed(event:MouseEvent) : void
        {
            dispatchEvent(new JoinUserEvent(CommonVEvent.JOIN_USER, pObj, "notif"));
            dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_NOTIF, this));
            return;
        }// end function

        private function onInvitePressed(event:MouseEvent) : void
        {
            dispatchEvent(new InviteUserEvent(CommonVEvent.INVITE_USER, pObj, "notif"));
            return;
        }// end function

    }
}
