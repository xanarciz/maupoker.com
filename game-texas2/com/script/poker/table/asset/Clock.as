package com.script.poker.table.asset
{
    import caurina.transitions.*;
    import com.script.poker.table.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Clock extends MovieClip
    {
        public var ring_red:MovieClip;
        public var initialTimeLeft:Number;
        public var bRemindSound:Boolean;
       
        public var ring_green_right:MovieClip;
        public var timer:Timer;
        public var timerMask:MovieClip;
        public var ring_yellow:MovieClip;
        public var bHurrySound:Boolean;
        public var mt:TableView;
        public var degreesPerSecond:Number;
        public var colors:MovieClip;
        public var ring_green_left:MovieClip;
        public var timeLeft:Number;
        public var isCounting:Boolean = false;
        public var curSit:Number = 0;

        public function Clock()
        {
			
           
            return;
        }// end function

        public function startCount(param1:Number, param2:int, param3:Number = 0)
        {
            resetClock();
            this.width = 40;
            this.height = 40;
            Tweener.addTween(this, {scaleX:1.1, scaleY:1.1, time:0.2, transition:"easeOutQuad"});
            this.visible = true;
            this.ring_green_right.visible = true;
            this.ring_green_left.visible = true;
            this.ring_yellow.visible = false;
            this.ring_red.visible = false;
            this.ring_green_right.mask = timerMask;
            isCounting = true;
            bRemindSound = false;
            bHurrySound = false;
            var _loc_4:Number = 2;
            timeLeft = param1 - param3 - _loc_4;
            timerMask.rotation = 0;
            this.initialTimeLeft = timeLeft;
            var _loc_5:* = param2;
            curSit = _loc_5;
            this.x = clockCoords[_loc_5][0];
            this.y = clockCoords[_loc_5][1];
            if (timeLeft > 0)
            {
                Tweener.addTween(timerMask, {rotation:360, time:timeLeft, transition:"linear", onUpdate:setMask});
                timer = new Timer(1000, timeLeft);
                timer.addEventListener(TimerEvent.TIMER, countDown);
                timer.start();
            }
            return;
        }// end function

        private function countDown(event:TimerEvent) : void
        {
            if (timeLeft == 12)
            {
                mt.playRemindSound(curSit);
            }
            if (timeLeft == 4)
            {
                mt.playHurrySound(curSit);
            }
            var _loc_3:* = timeLeft - 1;
            timeLeft = _loc_3;
            return;
        }// end function

        public function initClock(param1:TableView) : void
        {
            mt = param1;
			clockCoords = mt.clockCoordsdata;

            this.ring_green_left.visible = false;
            this.ring_green_right.visible = false;
            this.ring_yellow.visible = false;
            this.ring_red.visible = false;
            this.ring_green_right.mask = null;
            this.ring_red.mask = null;
            this.ring_yellow.mask = null;
            return;
        }// end function

        public function stopCount()
        {
            Tweener.addTween(this, {width:40, height:40, time:0.2, transition:"easeInQuad"});
            Tweener.removeTweens(timerMask);
            timerMask.rotation = 0;
            this.ring_green_left.visible = false;
            this.ring_green_right.visible = false;
            this.ring_yellow.visible = false;
            this.ring_red.visible = false;
            this.ring_green_right.mask = null;
            this.ring_red.mask = null;
            this.ring_yellow.mask = null;
            this.visible = false;
            return;
        }// end function

        private function setMask() : void
        {
            if (timerMask.rotation == 0)
            {
                ring_red.visible = false;
            }
            if (timerMask.rotation >= -90 && timerMask.rotation < 0)
            {
                ring_red.mask = timerMask;
                ring_yellow.visible = false;
                ring_yellow.mask = null;
                ring_red.visible = true;
                ring_green_left.visible = false;
                ring_green_right.visible = false;
                ring_green_right.mask = null;
            }
            if (timerMask.rotation >= -180 && timerMask.rotation < -90)
            {
                ring_yellow.mask = timerMask;
                ring_yellow.visible = true;
                ring_green_left.visible = false;
                ring_green_right.visible = false;
                ring_green_right.mask = null;
                ring_red.visible = false;
            }
            return;
        }// end function

        public function resetClock()
        {
            var _loc_1:int = 0;
            timeLeft = 0;
            this.initialTimeLeft = _loc_1;
            if (timer != null)
            {
                timer.stop();
                timer = null;
                timeLeft = 0;
                Tweener.removeTweens(timerMask);
                timerMask.rotation = 0;
                this.ring_green_left.visible = false;
                this.ring_green_right.visible = false;
                this.ring_yellow.visible = false;
                this.ring_red.visible = false;
                this.ring_green_right.mask = null;
                this.ring_red.mask = null;
                this.ring_yellow.mask = null;
            }
            return;
        }// end function

    }
}
