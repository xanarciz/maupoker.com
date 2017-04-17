package com.script.poker.commonUI.events
{
    import flash.events.*;

    public class InviteUserEvent extends CommonVEvent
    {
        public var jointype:String;
        public var friend:Object;

        public function InviteUserEvent(param1:String, param2:Object, param3:String = "zlive")
        {
            super(param1);
            friend = param2;
            jointype = param3;
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("InviteUserEvent", "type", "bubbles", "cancelable", "eventPhase", "friend");
        }// end function

        override public function clone() : Event
        {
            return new InviteUserEvent(this.type, friend, jointype);
        }// end function

    }
}
