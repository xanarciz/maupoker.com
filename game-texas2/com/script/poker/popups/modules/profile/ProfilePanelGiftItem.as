package com.script.poker.popups.modules.profile
{
    import caurina.transitions.*;
    import com.script.display.custom.*;
    import flash.display.*;
    import flash.text.*;

    public class ProfilePanelGiftItem extends MovieClip
    {
        public var bg:MovieClip;
        public var goldIconText:IconAndText;
        public var pic:MovieClip;
        public var giftID:Number;
        public var premiumBadge:MovieClip;
        public var overlay:MovieClip;
        public var permanentBadge:MovieClip;
        public var premium:Boolean;
        public var rollState:MovieClip;
        public var permanentItem:MovieClip;
        public var ID:Number;
        public var gold:TextField;
        public var info:TextField;
        public var selectState:MovieClip;
        public var goldIcon:MovieClip;
        public var permanent:Boolean;

        public function ProfilePanelGiftItem()
        {
            return;
        }// end function

        public function updateAmount(param1:String) : void
        {
            goldIconText.updateText(param1);
            goldIconText.x = -goldIconText.width / 2;
            return;
        }// end function

        public function out() : void
        {
            Tweener.addTween(selectState, {alpha:0, time:0.5});
            return;
        }// end function

        public function initDisplay(param1, param2, param3)
        {
            var _loc_4:MovieClip = null;
            buttonMode = true;
            mouseChildren = false;
            premium = param1;
            permanent = param3;
            overlay.alpha = 0;
            overlay.scaleX = 0;
            overlay.scaleY = 0;
            rollState.alpha = 0;
            selectState.alpha = 0;
            _loc_4 = param1 ? (new GoldChip()) : (new CasinoChip());
            _loc_4.width = 14;
            _loc_4.height = 14;
            goldIconText = new IconAndText(_loc_4, "", 1);
            goldIconText.x = -30;
            goldIconText.y = 24;
            addChild(goldIconText);
            goldIconText.visible = false;
            goldIcon.visible = false;
            permanentBadge.visible = false;
            premiumBadge.visible = false;
            permanentItem.visible = false;
            gold.htmlText = "";
            if (!param1)
            {
                bg.standardBackground.visible = false;
                rollState.standardRollOver.visible = false;
                selectState.selectStandard.visible = false;
            }
            else
            {
                bg.premiumBackground.visible = false;
                rollState.premiumRollOver.visible = false;
                selectState.selectPremium.visible = false;
                permanentBadge.visible = true;
            }
            if (param2)
            {
                goldIconText.visible = true;
            }
            return;
        }// end function

        public function setImage(param1:MovieClip) : void
        {
            pic.addChild(param1);
            return;
        }// end function

        public function rollin() : void
        {
            Tweener.addTween(rollState, {alpha:1, time:0.5});
            if (permanent)
            {
                permanentItem.visible = true;
            }
            return;
        }// end function

        public function over() : void
        {
            Tweener.addTween(selectState, {alpha:1, time:0.5});
            return;
        }// end function

        public function disable() : void
        {
            bg.visible = false;
            buttonMode = false;
            return;
        }// end function

        public function rollout() : void
        {
            Tweener.addTween(rollState, {alpha:0, time:0.5});
            if (permanent)
            {
                permanentItem.visible = false;
            }
            return;
        }// end function

        public function changeCurrencyIcon(param1:String) : void
        {
            var _loc_2:MovieClip = null;
            if (param1 == "gold")
            {
                _loc_2 = new GoldChip();
                _loc_2.width = 14;
                _loc_2.height = 14;
                goldIconText.setIcon(_loc_2);
            }
            else if (param1 == "cash")
            {
                _loc_2 = new CasinoChip();
                _loc_2.width = 14;
                _loc_2.height = 14;
                goldIconText.setIcon(_loc_2);
            }
            return;
        }// end function

    }
}
