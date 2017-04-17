package com.script.poker.nav.events
{
    import flash.events.*;

    public class NCEvent extends Event
    {
        public var sZid:String;
        public static const SHOW_GIFT_SHOP:String = "SHOW_GIFT_SHOP";
        public static const VIEW_INIT:String = "VIEW_INIT";
        public static const CLOSE_PHP_POPUPS:String = "CLOSE_PHP_POPUPS";
        public static const SHOW_USER_PROFILE:String = "SHOW_USER_PROFILE";
        public static const CLOSE_FLASH_POPUPS:String = "CLOSE_FLASH_POPUPS";
        public static const eType:String = "navControl";

        public function NCEvent(param1:String, param2:String = "")
        {
            super(param1);
            sZid = param2;
            return;
        }// end function

        override public function clone() : Event
        {
            return new NCEvent(this.type);
        }// end function

        override public function toString() : String
        {
            return formatToString("NCEvent", "type", "bubbles", "cancelable", "eventPhase");
        }// end function

    }
}
