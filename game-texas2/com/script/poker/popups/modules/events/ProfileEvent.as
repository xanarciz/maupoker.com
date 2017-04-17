package com.script.poker.popups.modules.events
{
    import flash.events.*;

    public class ProfileEvent extends Event
    {
        public var params:Object = null;
        public static const TRADE_COLLECTION_ITEM:String = "TRADE_COLLECTION_ITEM";
        public static const CLAIM_COLLECTION:String = "CLAIM_COLLECTION";
        public static const ITEM_CANCELED:String = "ITEM_CANCELED";
        public static const ITEM_SELECTED:String = "ITEM_SELECTED";
        public static const CASINO_SHOP_CLICK:String = "CASINO_SHOP_CLICK";
        public static const DISPLAY_TAB:String = "DISPLAY_TAB";
        public static const SEND_CHIPS_CLICK:String = "SEND_CHIPS_CLICK";
        public static const WISHLIST_COLLECTION_ITEM:String = "WISHLIST_COLLECTION_ITEM";
        public static const SKIP:String = "SKIP";

        public function ProfileEvent(param1:String, param2:Object = null)
        {
            super(param1, true);
            this.params = param2;
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("ProfileEvent", "type", "bubbles", "cancelable", "eventPhase");
        }// end function

        override public function clone() : Event
        {
            return new ProfileEvent(this.type, this.params);
        }// end function

    }
}
