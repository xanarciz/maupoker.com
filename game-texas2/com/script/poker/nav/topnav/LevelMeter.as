package com.script.poker.nav.topnav
{
    import caurina.transitions.*;
    import com.script.draw.*;
    import com.script.draw.tooltip.*;
    import com.script.text.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class LevelMeter extends MovieClip
    {
        public var tooltip:Sprite;
        public var xpBarTooltip:Tooltip;
        public var TOOLTIP_TEXT:String = "Earn experience by playing hands, winning pots and placing in tournaments. Unlock new gifts and achievements as you level up.";
        public var currentLevel:int = -1;
        public var nextUnlock:Number;
        public var xpToolTipText:HtmlTextBox;
        public var xpLeveler:XPLevelInformation;
        public var xpLevelUpAnimation:XPLevelUpAnimation;
        public var xpBarBar:Sprite;
        public var xpNewLevelAnimationTextX:Number = 16.5;
        public var xpNewLevelAnimationTextY:Number = 11.7;
        public var xpNewLevelText:HtmlTextBox;
        public var levelNumText:HtmlTextBox;
        public var currentXP:Number;
        public var oldXPLevelEnd:Number = 0;
        public var deltaXP:Number;
        public var cont:Sprite;
        public var xpTitle:String;
        public var bg:ComplexBox;
        public var xpNewLevelTextBackDrop:HtmlTextBox;
        public var xpBarColors:Object;
        public var xpLevelEnd:Number;
        public var levelText:HtmlTextBox;
        public var xpBarOverlay:Sprite;
        public var userLeveled:Boolean = false;
        public var oldXP:Number = 0;
        public var xpNewLevelAnimationBackdropTextX:Number;
        public var xpNewLevelAnimationBackdropTextY:Number;
        public var levelHit:ComplexBox;
        public var pokerNameText:HtmlTextBox;
        public var currentPercentage:Number = 0.01;
        public var xpTotalText:HtmlTextBox;
        public var xpBar:Sprite;

        public function LevelMeter()
        {
            cont = new Sprite();
            xpNewLevelAnimationBackdropTextX = xpNewLevelAnimationTextX + 0.5;
            xpNewLevelAnimationBackdropTextY = xpNewLevelAnimationTextY + 0.5;
            xpBarColors = {first:5215760, second:4764162, last:5492736};
            addChild(cont);
            xpLeveler = new XPLevelInformation();
            initAssets();
            cont.addChild(xpLeveler);
            levelHit = new ComplexBox(xpLeveler.width, xpLeveler.height, 0, {type:"rect"});
            levelHit.x = 0;
            levelHit.y = 0;
            levelHit.alpha = 0;
            addChild(levelHit);
            levelHit.addEventListener(MouseEvent.MOUSE_OVER, showToolTip);
            levelHit.addEventListener(MouseEvent.MOUSE_OUT, hideToolTip);
            return;
        }// end function

        public function setXPInformation(param1:Number, param2:Number, param3:Number, param4:String, param5:Number) : void
        {
            oldXP = currentXP;
            oldXPLevelEnd = xpLevelEnd;
            if (isNaN(param1))
            {
                param1 = 0;
            }
            if (isNaN(param2))
            {
                param2 = 0;
            }
            if (isNaN(param3))
            {
                param3 = 0;
            }
            if (isNaN(param5))
            {
                param5 = 0;
            }
            if (param3 > currentLevel && currentLevel != -1)
            {
                userLeveled = true;
            }
            currentXP = param1;
            deltaXP = param2;
            currentLevel = param3;
            xpTitle = param4;
            xpLevelEnd = param5;
            updateXPUI();
            if (userLeveled)
            {
                handleNewLevel(param3, param4);
            }
            resetFlags();
            return;
        }// end function

        private function performTitleChange(param1:String) : void
        {
            var animationHandler:Function;
            var newTitle:* = param1;
            animationHandler = function (event:Event) : void
            {
                if (xpLeveler.pokerNameClip.currentLabel == "changeTitle")
                {
                    pokerNameText.updateText(newTitle);
                    xpLeveler.pokerNameClip.removeEventListener(Event.ENTER_FRAME, animationHandler);
                }
                return;
            }// end function
            ;
            xpLeveler.pokerNameClip.addEventListener(Event.ENTER_FRAME, animationHandler);
            xpLeveler.pokerNameClip.gotoAndPlay("startAnimation");
            return;
        }// end function

        private function handleNewLevel(param1:Number, param2:String) : void
        {
            var _loc_3:Number = NaN;
            performTitleChange(param2);
            xpNewLevelText.updateText(String(param1));
            xpNewLevelTextBackDrop.updateText(String(param1));
            if (param1 < 10)
            {
                _loc_3 = 1.3;
                xpNewLevelTextBackDrop.x = xpNewLevelAnimationBackdropTextX + _loc_3;
                xpNewLevelText.x = xpNewLevelAnimationTextX + _loc_3;
            }
            xpLevelUpAnimation.visible = true;
            xpLevelUpAnimation.addEventListener(Event.ENTER_FRAME, onXPLevelUpAnimationEnterFrame);
            xpLevelUpAnimation.gotoAndPlay("play");
            return;
        }// end function

        private function showToolTip(event:Event) : void
        {
            if (xpBarTooltip == null)
            {
                xpBarTooltip = new Tooltip(210, getTooltipArr(), "Experience", "ul");
                xpBarTooltip.x = -10;
                xpBarTooltip.y = 23;
                xpLeveler.xpBarClip.addChild(xpBarTooltip);
                xpBarTooltip.visible = false;
                updateTooltipText();
            }
            xpBarTooltip.visible = true;
            return;
        }// end function

        public function updateNextUnlockLevel(param1:Number) : void
        {
            if (isNaN(param1))
            {
                param1 = 0;
            }
            nextUnlock = param1;
            updateTooltipText();
            return;
        }// end function

        private function onXPLevelUpAnimationEnterFrame(event:Event) : void
        {
            if (xpLevelUpAnimation.currentFrame == 1)
            {
                xpLevelUpAnimation.removeEventListener(Event.ENTER_FRAME, onXPLevelUpAnimationEnterFrame);
                xpLevelUpAnimation.visible = false;
            }
            return;
        }// end function

        private function hideToolTip(event:Event) : void
        {
            if (xpBarTooltip == null)
            {
                return;
            }
            xpBarTooltip.visible = false;
            return;
        }// end function

        private function initAssets() : void
        {
            var s:*;
            var e:*;
            var tick:Function;
            tick = function (event:Event) : void
            {
                setXPInformation(s, 5, 15, "Stud", e);
                var _loc_3:* = s + 1;
                s = _loc_3;
                if (s > e)
                {
                    e = e * 2;
                    s = 0;
                }
                return;
            }// end function
            ;
            var containerWidth:* = xpLeveler.xpBarClip.width;
            var containerHeight:* = xpLeveler.xpBarClip.height;
            xpBar = new Sprite();
            xpBar.x = 0;
            xpBar.y = 1;
            xpBar.scaleX = 0;
            xpLeveler.xpBarClip.addChild(xpBar);
            xpBarBar = new Sprite();
            xpBarBar.graphics.beginFill(xpBarColors.first, 1);
            xpBarBar.graphics.drawRect(0, 0, containerWidth, containerHeight);
            xpBarBar.graphics.endFill();
            xpBar.addChild(xpBarBar);
            xpBarOverlay = new Sprite();
            xpBarOverlay.graphics.beginFill(16777215, 0.3);
            xpBarOverlay.graphics.drawRect(0, 0, containerWidth, containerHeight);
            xpBarOverlay.graphics.endFill();
            xpBar.addChild(xpBarOverlay);
            xpTotalText = new HtmlTextBox("MainCondensed", "", 13, 16777215, "right", true, false, false, 195);
            xpTotalText.x = 240;
            xpTotalText.y = 15;
            xpLeveler.addChild(xpTotalText);
            levelNumText = new HtmlTextBox("MainCondensed", "", 24, 16777215, "center");
            levelNumText.x = 20;
            levelNumText.y = 24;
            xpLeveler.addChild(levelNumText);
            pokerNameText = new HtmlTextBox("MainCondensed", "", 14, 16777215, "left");
            pokerNameText.x = 0;
            pokerNameText.y = 10;
            xpLeveler.pokerNameClip.pokerName.addChild(pokerNameText);
            xpLevelUpAnimation = new XPLevelUpAnimation();
            xpLevelUpAnimation.x = -250;
            cont.addChild(xpLevelUpAnimation);
            xpNewLevelTextBackDrop = new HtmlTextBox("MainCondensed", "5", 13, 0, "center");
            xpNewLevelTextBackDrop.x = xpNewLevelAnimationBackdropTextX;
            xpNewLevelTextBackDrop.y = xpNewLevelAnimationBackdropTextY;
            xpLevelUpAnimation.levelNum.addChild(xpNewLevelTextBackDrop);
            xpNewLevelText = new HtmlTextBox("MainCondensed", "5", 13, 16706236, "center");
            xpNewLevelText.x = xpNewLevelAnimationTextX;
            xpNewLevelText.y = xpNewLevelAnimationTextY;
            xpLevelUpAnimation.levelNum.addChild(xpNewLevelText);
            xpLevelUpAnimation.visible = false;
            var x:*;
            s;
            e;
            var t:* = new Timer(2000);
            t.addEventListener("timer", tick);
            return;
        }// end function

        private function updateTooltipText() : void
        {
            if (xpBarTooltip != null)
            {
                xpBarTooltip.updateHtmlText(getTooltipArr());
            }
            return;
        }// end function

        private function getTooltipArr() : Array
        {
            var _loc_1:Array = [{text:TOOLTIP_TEXT, font:"MainLight", color:0, size:11}];
            if (nextUnlock > 0)
            {
                _loc_1.push({text:"\n\nNext unlock at level " + nextUnlock, font:"MainLight", color:4275419, size:12});
            }
            return _loc_1;
        }// end function

        private function changeXPBarColor(param1:uint) : void
        {
            xpBarBar.graphics.beginFill(param1, 1);
            xpBarBar.graphics.drawRect(0, 0, xpBarBar.width, xpBarBar.height);
            xpBarBar.graphics.endFill();
            return;
        }// end function

        public function updateXPUI() : void
        {
            var partialPercentage:Number;
            var time:Number;
            levelNumText.updateText(String(currentLevel));
            pokerNameText.updateText(xpTitle);
            var xpTotalValue:* = xpLevelEnd > 0 ? (currentXP + " / " + xpLevelEnd) : ("MAX");
            xpTotalText.updateText(xpTotalValue);
            partialPercentage = xpLevelEnd > 0 ? (currentXP / xpLevelEnd) : (1);
            if (partialPercentage > 1)
            {
                partialPercentage;
            }
            if (partialPercentage < 0.33)
            {
                if (!userLeveled)
                {
                    changeXPBarColor(xpBarColors.first);
                }
            }
            else if (partialPercentage > 0.66)
            {
                changeXPBarColor(xpBarColors.last);
            }
            else
            {
                changeXPBarColor(xpBarColors.second);
            }
            var oldPercentage:* = oldXPLevelEnd == 0 ? (0) : (oldXP / oldXPLevelEnd);
            if (userLeveled)
            {
                var finishUp:* = function () : void
            {
                time = partialPercentage * 2;
                Tweener.addTween(xpBar, {scaleX:partialPercentage, time:time, transition:"easeOutSine"});
                return;
            }// end function
            ;
                time = (1 - oldPercentage) * 2;
                Tweener.addTween(xpBar, {scaleX:1, time:time, transition:"easeInSine", onComplete:finishUp});
            }
            else
            {
                time = partialPercentage * 2;
                Tweener.addTween(xpBar, {scaleX:partialPercentage, time:time, transition:"easeInOutSine"});
            }
            return;
        }// end function

        private function resetFlags() : void
        {
            userLeveled = false;
            return;
        }// end function

    }
}
