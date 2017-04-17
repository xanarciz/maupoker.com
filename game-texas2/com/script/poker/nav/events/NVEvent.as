package com.script.poker.nav.events
{
    import flash.events.*;

    public class NVEvent extends Event
    {
        public static const GOLD_ROLLOUT:String = "GOLD_ROLLOUT";
        public static const SHOW_BUDDIES:String = "SHOW_BUDDIES";
        public static const SHOW_GET_CHIPS:String = "SHOW_GET_CHIPS";
        public static const HIDE_BUDDIES:String = "HIDE_BUDDIES";
        public static const HIDE_GET_CHIPS:String = "HIDE_GET_CHIPS";
        public static const CHIPS_ROLLOVER:String = "CHIPS_ROLLOVER";
        public static const SHOW_CHALLENGES:String = "SHOW_CHALLENGES";
        public static const GET_CHIPS_CLICKED:String = "GET_CHIPS_CLICKED";
        public static const HIDE_CHALLENGES:String = "HIDE_CHALLENGES";
        public static const SHOW_USER_PROFILE:String = "SHOW_USER_PROFILE";
        public static const CHIPS_ROLLOUT:String = "CHIPS_ROLLOUT";
        public static const GOLD_ROLLOVER:String = "GOLD_ROLLOVER";
        public static const SHOW_GIFT_SHOP:String = "SHOW_GIFT_SHOP";
        public static const HIDE_GIFT_SHOP:String = "HIDE_GIFT_SHOP";
        public static const SHOW_EARN_CHIPS:String = "SHOW_EARN_CHIPS";
        public static const ACHIEVEMENTS_CLICKED:String = "ACHIEVEMENTS_CLICKED";
        public static const HIDE_USER_PROFILE:String = "HIDE_USER_PROFILE";
        public static const POKERGRAMS_CLICKED:String = "POKERGRAMS_CLICKED";
        public static const HIDE_EARN_CHIPS:String = "HIDE_EARN_CHIPS";
        public static const USER_PIC_CLICKED:String = "USER_PIC_CLICKED";
        public static const eType:String = "navView";

        public function NVEvent(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("NVEvent", "type", "bubbles", "cancelable", "eventPhase");
        }// end function

        override public function clone() : Event
        {
            return new NVEvent(this.type);
        }// end function

    }
}
