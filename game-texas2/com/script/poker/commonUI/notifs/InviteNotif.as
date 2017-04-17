package com.script.poker.commonUI.notifs
{
    import com.script.display.*;
    import com.script.poker.commonUI.asset.*;
    import com.script.poker.commonUI.events.*;
    import com.script.text.*;
    import flash.events.*;
    import flash.net.*;

    public class InviteNotif extends BaseNotif
    {
        private var blindinfo:HtmlTextBox;
        public var pObj:Object;
        private var nameField:HtmlTextBox;
        public var ldrPic:SafeImageLoader;
        private var joinbtn:NotifJoinButton;
        private var invitebtn:NotifInviteTableButton;
        private var line2:HtmlTextBox;

        public function InviteNotif(param1:Object, param2:Boolean)
        {
			
            this.pObj = param1;
			
            joinbtn = new NotifJoinButton();
			
            addChild(joinbtn);
            joinbtn.x = 3;
            joinbtn.y = 55;
            joinbtn.addEventListener(MouseEvent.CLICK, onJoinPressed);
            joinbtn.useHandCursor = true;
            joinbtn.buttonMode = true;
            invitebtn = new NotifInviteTableButton();
            addChild(invitebtn);
            invitebtn.x = 71;
            invitebtn.y = 55;
            invitebtn.addEventListener(MouseEvent.CLICK, onInvitePressed);
            invitebtn.useHandCursor = true;
            invitebtn.buttonMode = true;
            invitebtn.visible = !param2;
            ldrPic = new SafeImageLoader("../Avatar/default.jpg");
            ldrPic.contentLoaderInfo.addEventListener(Event.COMPLETE, onPicLoadComplete);
            ldrPic.mouseEnabled = false;
            var _loc_3:* = new URLRequest(pObj["source"]);
            ldrPic.load(_loc_3);
           /* if (pObj["label"].length > 16)
            {
                pObj["label"] = pObj["label"].slice(0, 16) + "...";
                ;
            }*/
            nameField = new HtmlTextBox("Main", pObj["label"], 14, 0, "left");
            addChild(nameField);
            nameField.x = 55;
            nameField.y = -2;
            line2 = new HtmlTextBox("Main", "invites you to a table!", 12, 0, "left");
            addChild(line2);
            line2.x = 55;
            line2.y = 17;
            blindinfo = new HtmlTextBox("Main", "Blinds: " + pObj["tableStakes"], 11, 0, "left");
            blindinfo.x = 55;
            blindinfo.y = 35;
            addChild(blindinfo);
            return;
        }// end function

        private function onInvitePressed(event:MouseEvent) : void
        {
            dispatchEvent(new InviteUserEvent(CommonVEvent.INVITE_USER, pObj, "notif"));
            dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_NOTIF, this));
            return;
        }// end function

        public function get zid() : String
        {
            return pObj["uid"];
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

        public function hideInvite() : void
        {
            invitebtn.visible = false;
            return;
        }// end function

        override public function cleanUp(event:Event) : void
        {
            super.cleanUp(event);
            joinbtn.removeEventListener(MouseEvent.CLICK, onJoinPressed);
            invitebtn.removeEventListener(MouseEvent.CLICK, onInvitePressed);
            return;
        }// end function

        public function showInvite() : void
        {
            invitebtn.visible = true;
            return;
			
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

    }
}
