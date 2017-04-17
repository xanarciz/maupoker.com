package com.script.poker.commonUI.notifs
{
    import com.script.poker.commonUI.asset.*;
    import com.script.poker.commonUI.events.*;
    import com.script.poker.lobby.asset.*;
    import flash.display.*;
    import flash.events.*;

    public class BaseNotif extends MovieClip
    {
        private var bg:NotifBG;
        private var closeButton:CloseButton;
        private var frame:DrawFrame;

        public function BaseNotif()
        {
            this.alpha = 0;
            closeButton = new CloseButton();
            frame = new DrawFrame(219, 85, false, false);
            frame.addEventListener(MouseEvent.CLICK, onFrameClick);
            addChild(frame);
            bg = new NotifBG();
            bg.height = 102;
            frame.addChild(bg);
            bg.y = -15;
            bg.x = -2;
            bg.addEventListener(MouseEvent.CLICK, onFrameClick);
            frame.addChild(closeButton);
            closeButton.x = 200;
            closeButton.y = -10;
            closeButton.width = 16;
            closeButton.height = 16;
            closeButton.buttonMode = true;
            closeButton.useHandCursor = true;
            closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
            addChild(closeButton);
            this.addEventListener(Event.REMOVED_FROM_STAGE, cleanUp);
            return;
        }// end function

        private function onFrameClick(event:MouseEvent) : void
        {
            var _loc_2:* = this.parent;
            _loc_2.swapChildren(this, _loc_2.getChildAt((_loc_2.numChildren - 1)));
            return;
        }// end function

        public function cleanUp(event:Event) : void
        {
            closeButton.removeEventListener(MouseEvent.CLICK, onCloseClick);
            bg.removeEventListener(MouseEvent.CLICK, onFrameClick);
            this.removeEventListener(Event.REMOVED_FROM_STAGE, cleanUp);
            return;
        }// end function

        private function onCloseClick(event:MouseEvent)
        {
            dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_NOTIF, this));
            return;
        }// end function

    }
}
