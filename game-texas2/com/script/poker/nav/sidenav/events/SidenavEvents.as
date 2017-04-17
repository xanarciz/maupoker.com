package com.script.poker.nav.sidenav.events
{
    import flash.events.*;

    public class SidenavEvents extends Event
    {
        private var _data:Object;
        public static const REQUEST_PANEL:String = "REQUEST_PANEL";
        public static const PANEL_SELECTED:String = "PANEL_SELECTED";
        public static const disp:EventDispatcher = new EventDispatcher();
        public static const CLOSE_PANEL:String = "CLOSE_PANEL";

        public function SidenavEvents(param1:String, param2:Object = null, param3:Boolean = true, param4:Boolean = false)
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
            return new SidenavEvents(type, _data, bubbles, cancelable);
        }// end function

        public static function quickThrow(param1:String, param2)
        {
            disp.dispatchEvent(new SidenavEvents(param1, param2));
            return;
        }// end function

    }
}
