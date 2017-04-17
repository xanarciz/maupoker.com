package com.script.poker.nav.topnav.events
{
    import flash.events.*;

    public class TopnavEvent extends Event
    {
        private var _data:Object;
        public static const disp:EventDispatcher = new EventDispatcher();
        public static const NEW_ACHIEVEMENTS_NOTIFICATION_RESET:String = "NEW_ACHIEVEMENTS_NOTIFICATION_RESET";

        public function TopnavEvent(param1:String, param2:Object = null, param3:Boolean = true, param4:Boolean = false)
        {
            super(param1, param3, param4);
            _data = param2;
            return;
        }// end function

        public function get data() : Object
        {
            return _data;
        }// end function

        override public function clone() : Event
        {
            return new TopnavEvent(type, _data, bubbles, cancelable);
        }// end function

        public static function quickThrow(param1:String, param2)
        {
            disp.dispatchEvent(new TopnavEvent(param1, param2));
            return;
        }// end function

    }
}
