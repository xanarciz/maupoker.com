package com.script.poker.protocol
{

    public class SShowGift3 extends Object
    {
        public var gift:Number;
        public var type:String;
        public var fromLobby:Boolean;

        public function SShowGift3(param1:String, param2:Number, param3:Boolean = false)
        {
            this.type = param1;
            this.gift = param2;
            this.fromLobby = param3;
            return;
			
        }// end function

    }
}
