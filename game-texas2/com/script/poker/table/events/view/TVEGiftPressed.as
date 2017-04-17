package com.script.poker.table.events.view
{
    import com.script.poker.table.events.*;
    import flash.events.*;

    public class TVEGiftPressed extends TVEvent
    {
        public var sit:int;

        public function TVEGiftPressed(param1:String, param2:int)
        {
            super(param1);
            sit = param2;
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("TVEGiftPressed", "type", "bubbles", "cancelable", "eventPhase");
        }// end function

        override public function clone() : Event
        {
            return new TVEGiftPressed(this.type, sit);
        }// end function

    }
}
