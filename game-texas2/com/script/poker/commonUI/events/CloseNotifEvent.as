package com.script.poker.commonUI.events
{
    import com.script.poker.commonUI.notifs.*;
    import flash.events.*;

    public class CloseNotifEvent extends CommonVEvent
    {
        public var notif:BaseNotif;

        public function CloseNotifEvent(param1:String, param2:BaseNotif)
        {
            super(param1);
            notif = param2;
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("CloseNotifEvent", "type", "bubbles", "cancelable", "eventPhase", "notif");
        }// end function

        override public function clone() : Event
        {
            return new CloseNotifEvent(this.type, notif);
        }// end function

    }
}
