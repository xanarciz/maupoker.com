package com.script.poker.nav.topnav
{
    import caurina.transitions.*;
    import com.script.draw.*;
    import com.script.draw.tooltip.*;
    import com.script.format.*;
    import com.script.poker.nav.events.*;
    import com.script.text.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;

    public class TopNav extends Sprite
    {
        public var casinoGoldField:HtmlTextBox;
        public var TOOLTIP_TEXT:String = "Earn experience by playing hands, winning pots and placing in tournaments. Unlock new gifts and achievements as you level up";
        public var goldHit:ComplexBox;
        public var showGetChipsTooltip:Boolean = true;
        public var bgCont:Sprite;
        public var iconTotalChips:MovieClip;
        public var getChipsTooltipText:String = "Get Chips and Gold with $, euro, £, AUD, CAD, kr, RM and more!";
        public var leveler:LevelMeter;
        public var thisCasinoGold:Number = 0;
        public var bgOverlay:Sprite;
        public var achieve:AchAnimation;
        public var pgCount:CountIndicator;
        public const SEPARATOR_FOUR:int = 3;
        public var cashGlow:CashGlow;
        public var chipsHit:ComplexBox;
        private var getChipsEffectTimer:Timer;
        public const SEPARATOR_THREE:int = 2;
        public var xpBarTooltip:Tooltip;
        public var achieveHitMask:Sprite;
        public var chipsField:HtmlTextBox;
        public var thisChips:Number;
        public var getChipsBtn:GetChipsButton;
        public const SEPARATOR_TWO:int = 1;
        public var achievementCountIcon:CountIndicator;
        public var dollar:HtmlTextBox;
        public var userPic:UserImageSmall;
        public const SEPARATOR_ONE:int = 0;
        public var thisImageUrl:String;
        public var separatorSpots:Array;
        public var achievementTooltip:Tooltip;
        public const TOPNAV_WIDTH:Number = 760;
        public var pokerGramsBtn:PokerGrams;
        public var getChipsTooltip:Tooltip;
        public var aLevelRanks:Array;
        public var unlockedAchievementIcon:UnlockedAchievementIcon;
        private var pgBuyAndSend:int;
        public var getChipsGold:ShineButton;
        public var goldIcon:MovieClip;

        public function TopNav() : void
        {
            separatorSpots = [new Point(-2, 20), new Point(385, 20), new Point(500, 20)];
            bgOverlay = new Sprite();
            bgOverlay.graphics.beginFill(0, 1);
            bgOverlay.graphics.drawRect(0, 0, 760, 40);
            bgOverlay.graphics.endFill();
            addChild(bgOverlay);
            bgCont = new Sprite();
            addChild(bgCont);
            var _loc_1:* = new Object();
            _loc_1.colors = [4476240, 2501935, 2236962, 1381653, 0, 1644825];
            _loc_1.alphas = [1, 1, 1, 1, 1, 1];
            _loc_1.ratios = [0, 2, 86, 86, 175, 255];
            var _loc_2:* = new Box(760, 40, _loc_1, false);
            bgCont.addChild(_loc_2);
            var _loc_3:* = new TopNavPattern(0, 0);
            var _loc_4:* = new Sprite();
            new Sprite().alpha = 0.33;
            _loc_4.graphics.beginBitmapFill(_loc_3);
            _loc_4.graphics.drawRect(0, 0, 760, 12);
            _loc_4.graphics.endFill();
            _loc_4.x = 0;
            _loc_4.y = 28;
            bgCont.addChild(_loc_4);
            var _loc_5:* = new ComplexBox(752, 40, 0, {type:"complex", ul:2, ur:2, ll:0, lr:0});
            new ComplexBox(752, 40, 0, {type:"complex", ul:2, ur:2, ll:0, lr:0}).x = 4;
            addChild(_loc_5);
            bgCont.mask = _loc_5;
            return;
        }// end function

        private function onChipsRollover(event:MouseEvent) : void
        {
            dispatchEvent(new NVEvent(NVEvent.CHIPS_ROLLOVER));
            return;
        }// end function

        private function onAchievementsClicked(event:MouseEvent) : void
        {
            dispatchEvent(new NVEvent(NVEvent.ACHIEVEMENTS_CLICKED));
            return;
        }// end function

        private function drawPokergrams(param1:int) : void
        {
            if (!pokerGramsBtn)
            {
                pokerGramsBtn = new PokerGrams();
                pokerGramsBtn.y = 7;
                pokerGramsBtn.x = separatorSpots[SEPARATOR_FOUR].x + (TOPNAV_WIDTH - separatorSpots[SEPARATOR_FOUR].x - pokerGramsBtn.width) / 2 + 10;
                pokerGramsBtn.filters = [new GlowFilter(0, 0.75, 5, 5, 1.25, 3)];
                pokerGramsBtn.buttonMode = true;
                addChild(pokerGramsBtn);
            }
            if (!pgCount)
            {
                pgCount = new CountIndicator(param1);
            }
            if (param1)
            {
                addChild(pgCount);
            }
            pgCount.x = pokerGramsBtn.x + 29;
            pgCount.y = pokerGramsBtn.y + 13;
            return;
        }// end function

        private function onPokerGramsClicked(event:MouseEvent) : void
        {
            var evt:* = event;
            try
            {
                removeChild(pgCount);
            }
            catch (e:Error)
            {
            }
            if ((pokerGramsBtn.currentFrame - 1))
            {
                pokerGramsBtn.gotoAndStop(1);
            }
            else
            {
                pokerGramsBtn.gotoAndStop(2);
            }
            dispatchEvent(new NVEvent(NVEvent.POKERGRAMS_CLICKED));
            return;
        }// end function

        private function initListeners() : void
        {
            achieveHitMask.addEventListener(MouseEvent.CLICK, onAchievementsClicked);
            achieveHitMask.addEventListener(MouseEvent.MOUSE_OVER, showAchievementTooltip);
            achieveHitMask.addEventListener(MouseEvent.MOUSE_OUT, hideAchievementTooltip);
            getChipsGold.addEventListener(MouseEvent.CLICK, onGetChipsClicked);
            getChipsGold.addEventListener(MouseEvent.MOUSE_OVER, onGetChipsOver);
            getChipsGold.addEventListener(MouseEvent.MOUSE_OUT, onGetChipsOut);
            goldHit.addEventListener(MouseEvent.ROLL_OVER, onGoldRollover);
            goldHit.addEventListener(MouseEvent.ROLL_OUT, onGoldRollout);
            chipsHit.addEventListener(MouseEvent.ROLL_OVER, onChipsRollover);
            chipsHit.addEventListener(MouseEvent.ROLL_OUT, onChipsRollout);
            return;
        }// end function

        private function onGetChipsClicked(event:MouseEvent) : void
        {
            dispatchEvent(new NVEvent(NVEvent.GET_CHIPS_CLICKED));
            return;
        }// end function

        private function onUserPicClicked(event:MouseEvent) : void
        {
            dispatchEvent(new NVEvent(NVEvent.USER_PIC_CLICKED));
            return;
        }// end function

        private function onGetChipsOut(event:MouseEvent) : void
        {
            getChipsTooltip.visible = false;
            return;
        }// end function

        private function drawLeveler(param1:Number) : void
        {
            leveler = new LevelMeter();
            leveler.x = separatorSpots[SEPARATOR_THREE].x + (TOPNAV_WIDTH - separatorSpots[SEPARATOR_THREE].x - leveler.xpLeveler.width) / 2 - 10;
            leveler.y = 0;
            addChild(leveler);
            return;
        }// end function

        private function drawGetChipsGold(param1:String = "") : void
        {
            if (pgBuyAndSend == 1 && param1 == "")
            {
                getChipsGold = new ShineButton(115, 22, "Get Chips & Gold!", 13, "gold", true);
            }
            else if (pgBuyAndSend != 1 && param1 == "")
            {
                getChipsGold = new ShineButton(90, 22, "Get Chips", 13, "gold", true);
            }
            else if (param1 != "")
            {
                getChipsGold = new ShineButton(115, 22, param1, 13, "gold", true);
            }
            getChipsGold.y = 20;
            getChipsGold.x = 307;
            addChild(getChipsGold);
            return;
        }// end function

        private function drawCasinoGold(param1:Number) : void
        {
            goldIcon = new GoldIcon();
            goldIcon.x = 160;
            goldIcon.y = 8;
            addChild(goldIcon);
            var _loc_2:* = StringUtility.StringToMoney(param1);
            casinoGoldField = new HtmlTextBox("MainSemi", _loc_2, 14, 16777215);
            casinoGoldField.x = 190;
            casinoGoldField.y = 21;
            addChild(casinoGoldField);
            goldHit = new ComplexBox(80, goldIcon.height, 0, {type:"rect"});
            goldHit.x = 160;
            goldHit.y = goldIcon.y;
            goldHit.alpha = 0;
            addChild(goldHit);
            if (pgBuyAndSend == 0)
            {
                goldIcon.visible = false;
                casinoGoldField.visible = false;
                goldHit.visible = false;
            }
            return;
        }// end function

        public function updateChips(param1:Number) : void
        {
            chipsField.updateText(StringUtility.StringToMoney(param1));
            if (param1 > thisChips)
            {
                cashGlow.width = chipsField.width * 2;
                cashGlow.x = chipsField.x + chipsField.width / 2;
                Tweener.addTween(cashGlow, {alpha:0.75, time:0.4, transition:"easeInSine"});
                Tweener.addTween(dollar, {_color:16777215, time:0.4, transition:"easeInSine"});
                Tweener.addTween(dollar, {_Glow_alpha:1, _Glow_color:10092288, _Glow_blurX:13, _Glow_blurY:13, _Glow_quality:3, _Glow_strength:5, time:0.4, transition:"easeInSine"});
                Tweener.addTween(cashGlow, {alpha:0, delay:0.6, time:0.4, transition:"easeOutSine"});
                Tweener.addTween(dollar, {_color:13421772, delay:0.6, time:0.4, transition:"easeOutSine"});
                Tweener.addTween(dollar, {_Glow_alpha:0, _Glow_blurX:0, _Glow_blurY:0, _Glow_strength:0, delay:0.6, time:0.4, transition:"easeOutSine"});
            }
            thisChips = param1;
            return;
        }// end function

        private function drawUserImage(param1:String) : void
        {
            userPic = new UserImageSmall(param1);
            userPic.x = 22;
            userPic.y = 20;
            addChild(userPic);
            return;
        }// end function

        private function onGetChipsEffectTimerFire(event:TimerEvent) : void
        {
            return;
        }// end function

        public function hideUnlockedAchievementCount() : void
        {
            if (achievementCountIcon == null)
            {
                return;
            }
            achievementCountIcon.visible = false;
            return;
        }// end function

        private function onChipsRollout(event:MouseEvent) : void
        {
            dispatchEvent(new NVEvent(NVEvent.CHIPS_ROLLOUT));
            return;
        }// end function

        public function updateAchievements(param1:int) : void
        {
            achieve.newCount = param1;
            achieve.gotoAndPlay(11);
            achieve.highlight.play();
            achieve.sparkle.play();
            return;
        }// end function

        private function drawAchievements(param1:int, param2:int) : void
        {
            var _loc_3:Number = 106;
            if (!achieve)
            {
                achieve = new AchAnimation();
                achieve.gotoAndStop(11);
                achieve.y = 11;
                achieve.buttonMode = true;
                addChild(achieve);
            }
            if (!achieveHitMask)
            {
                achieveHitMask = new Sprite();
                achieveHitMask.graphics.beginFill(16711680, 0);
                achieveHitMask.graphics.drawRect(0, 0, separatorSpots[SEPARATOR_THREE].x - separatorSpots[SEPARATOR_TWO].x, 40);
                achieveHitMask.graphics.endFill();
                achieveHitMask.x = separatorSpots[SEPARATOR_TWO].x;
                achieveHitMask.buttonMode = true;
                addChild(achieveHitMask);
            }
            updateAchievements(param1);
            achieve.maxCount.text = "/ " + param2.toString();
            var _loc_4:* = achieve.width;
            var _loc_5:* = separatorSpots[SEPARATOR_THREE].x - separatorSpots[SEPARATOR_TWO].x;
            var _loc_6:* = separatorSpots[SEPARATOR_TWO].x + (_loc_5 - _loc_4) / 2;
            achieve.x = _loc_6;
            return;
        }// end function

        private function onUserPicRollOut(event:MouseEvent) : void
        {
            if (Tweener.isTweening(userPic))
            {
                Tweener.removeTweens(userPic);
            }
            Tweener.addTween(userPic, {scaleX:1, scaleY:1, time:0.5, transition:"easeOutBounce"});
            return;
        }// end function

        private function drawSeperators() : void
        {
            var _loc_1:String = null;
            var _loc_2:Seperator = null;
            for (_loc_1 in separatorSpots)
            {
                
                _loc_2 = new Seperator();
                _loc_2.mouseEnabled = false;
                _loc_2.x = separatorSpots[_loc_1].x;
                _loc_2.y = separatorSpots[_loc_1].y;
                bgCont.addChild(_loc_2);
            }
            return;
        }// end function

        public function updateCasinoGold(param1:Number) : void
        {
            thisCasinoGold = param1;
            casinoGoldField.updateText(StringUtility.StringToMoney(thisCasinoGold));
            return;
        }// end function

        public function setUnlockedAchievementCount(param1:Number) : void
        {
            if (param1 > 0)
            {
                if (achievementCountIcon == null)
                {
                    achievementCountIcon = new CountIndicator(param1);
                    achievementCountIcon.x = 22;
                    achievementCountIcon.y = 9;
                    achieve.addChild(achievementCountIcon);
                }
                achievementCountIcon.visible = true;
                achievementCountIcon.updateCount(param1);
            }
            return;
        }// end function

        private function showAchievementTooltip(event:MouseEvent)
        {
            if (achievementTooltip == null)
            {
                achievementTooltip = new Tooltip(75, [{text:"Achievements", font:"CalibriBold", color:0, size:12}]);
                achievementTooltip.x = separatorSpots[SEPARATOR_TWO].x + 50;
                achievementTooltip.y = 45;
                addChild(achievementTooltip);
                achievementTooltip.visible = false;
            }
            achievementTooltip.visible = true;
            return;
        }// end function

        private function hideAchievementTooltip(event:MouseEvent)
        {
            achievementTooltip.visible = false;
            return;
        }// end function

        public function initTopNav(param1:String, param2:Number, param3:int, param4:int, param5:int, param6:Array, param7:int = 0, param8:int = -1) : void
        {
            thisChips = param2;
            thisImageUrl = param1;
            aLevelRanks = param6;
            pgBuyAndSend = param7;
            drawSeperators();
            drawChips(thisChips);
            drawLeveler(thisChips);
            drawCasinoGold(thisCasinoGold);
            drawGetChipsGold(param8 == 4 ? ("Chip & Gold Sale!") : (""));
            drawLeveler(thisChips);
            drawAchievements(param3, param4);
            initListeners();
            return;
        }// end function

        private function drawChips(param1:Number) : void
        {
            dollar = new HtmlTextBox("MainSemi", "$", 14, 16777215);
            dollar.x = 44;
            dollar.y = 21;
            addChild(dollar);
            cashGlow = new CashGlow();
            cashGlow.alpha = 0;
            addChild(cashGlow);
            var _loc_2:* = StringUtility.StringToMoney(param1);
            chipsField = new HtmlTextBox("MainSemi", _loc_2, 14, 16777215);
            var _loc_3:int = 54;
            cashGlow.x = 54;
            chipsField.x = _loc_3;
            chipsField.y = 21;
            cashGlow.width = chipsField.width;
            addChild(chipsField);
            iconTotalChips = new IconTotalChips();
            iconTotalChips.x = 15;
            iconTotalChips.y = 8;
            iconTotalChips.useHandCursor = true;
            addChild(iconTotalChips);
            chipsHit = new ComplexBox(130, iconTotalChips.height, 0, {type:"rect"});
            chipsHit.x = 15;
            chipsHit.y = iconTotalChips.y;
            chipsHit.alpha = 0;
            addChild(chipsHit);
            return;
        }// end function

        public function updateNextUnlockLevel(param1:Number)
        {
            leveler.updateNextUnlockLevel(param1);
            return;
        }// end function

        private function onGoldRollover(event:MouseEvent) : void
        {
            dispatchEvent(new NVEvent(NVEvent.GOLD_ROLLOVER));
            return;
        }// end function

        private function onGoldRollout(event:MouseEvent) : void
        {
            dispatchEvent(new NVEvent(NVEvent.GOLD_ROLLOUT));
            return;
        }// end function

        public function updateXPInformation(param1:Number, param2:Number, param3:Number, param4:String, param5:Number) : void
        {
            leveler.setXPInformation(param1, param2, param3, param4, param5);
            return;
        }// end function

        private function onGetChipsOver(event:MouseEvent) : void
        {
            var _loc_2:Number = NaN;
            if (getChipsTooltip == null)
            {
                _loc_2 = 200;
                getChipsTooltip = new Tooltip(_loc_2, [{text:getChipsTooltipText, font:"CalibriBold", color:0, size:12}]);
                getChipsTooltip.x = separatorSpots[SEPARATOR_TWO].x - _loc_2 / 2;
                getChipsTooltip.y = 45;
                getChipsTooltip.visible = false;
                addChild(getChipsTooltip);
            }
            if (showGetChipsTooltip)
            {
                getChipsTooltip.visible = true;
            }
            return;
        }// end function

        private function onUserPicRollOver(event:MouseEvent) : void
        {
            if (Tweener.isTweening(userPic))
            {
                Tweener.removeTweens(userPic);
            }
            Tweener.addTween(userPic, {scaleX:1.2, scaleY:1.2, time:0.5, transition:"easeOutBounce"});
            return;
        }// end function

    }
}
