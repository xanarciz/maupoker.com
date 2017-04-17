package com.script.poker.popups.modules.profile
{
    import com.script.draw.tooltip.*;
    import com.script.poker.popups.modules.events.*;
    import fl.containers.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class ProfileCollectionsView extends MovieClip
    {
        public var tradeButtonInfo:MovieClip;
        private var howItWorksToolTipText:String = "Collectibles can be found when you win hands (if you are lucky).  Find all 5 from a collection and win the reward!\n\nSome collectibles are Special and can be found in your friends\' feeds - so keep a lookout!";
        public var skipButton:MovieClip;
        public var buddyInfo:MovieClip;
        private var collections:Array;
        private var hasExecutedFirstTimeCollections:Boolean = false;
        public var wishlistButtonInfo:MovieClip;
        public var howItWorks:MovieClip;
        private var isFriend:Boolean = false;
        private var howItWorksToolTipTimer:Timer;
        private var collectionsContainer:Sprite;
        public var collectionsScrollPane:ScrollPane;
        public var firstTimeCollections:Boolean = false;
        private var howItWorksToolTip:Tooltip;

        public function ProfileCollectionsView(param1:Boolean = false)
        {
            howItWorks.addEventListener(MouseEvent.MOUSE_OVER, onHowItWorksMouseOver);
            howItWorks.addEventListener(MouseEvent.MOUSE_OUT, onHowItWorksMouseOut);
            skipButton.buttonMode = true;
            skipButton.addEventListener(MouseEvent.CLICK, onSkipButtonClick);
            skipButton.addEventListener(MouseEvent.MOUSE_OVER, onSkipButtonMouseOver);
            skipButton.addEventListener(MouseEvent.MOUSE_OUT, onSkipButtonMouseOut);
            this.collectionsContainer = new Sprite();
            this.firstTimeCollections = param1;
            return;
        }// end function

        public function setNewCollectionItemCount(param1:Number) : void
        {
            return;
        }// end function

        private function onHowItWorksToolTipTimerComplete(event:TimerEvent) : void
        {
            hidehowItWorksToolTip();
            return;
        }// end function

        private function onSkipButtonClick(event:MouseEvent) : void
        {
            dispatchEvent(new ProfileEvent(ProfileEvent.SKIP));
            return;
        }// end function

        private function onSkipButtonMouseOver(event:MouseEvent) : void
        {
            skipButton.gotoAndStop("rollover");
            return;
        }// end function

        public function incrementCollectionItemCount(param1:Number) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Object = null;
            if (this.collections != null)
            {
                for each (_loc_2 in this.collections)
                {
                    
                    _loc_3 = _loc_2.getItem(param1);
                    if (_loc_3 != null)
                    {
                        _loc_2.setItemCount(param1, (_loc_3.count + 1), true);
                    }
                }
            }
            return;
        }// end function

        public function setCollections(param1:Array, param2:Object, param3:Object = null) : void
        {
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            var _loc_7:Array = null;
            var _loc_8:Object = null;
            var _loc_9:Object = null;
            var _loc_10:Object = null;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:Array = null;
            var _loc_14:Object = null;
            var _loc_15:Boolean = false;
            var _loc_16:Object = null;
            var _loc_17:Array = null;
            var _loc_18:Boolean = false;
            var _loc_19:Boolean = false;
            var _loc_20:String = null;
            var _loc_21:Object = null;
            var _loc_4:* = param3 != null ? (true) : (false);
            if (param3 != null ? (true) : (false))
            {
                buddyInfo.visible = true;
                howItWorks.visible = false;
                wishlistButtonInfo.visible = false;
            }
            else
            {
                buddyInfo.visible = false;
                howItWorks.visible = true;
                wishlistButtonInfo.visible = true;
            }
            if (this.collectionsContainer == null)
            {
                this.collectionsContainer = new Sprite();
            }
            else
            {
                while (this.collectionsContainer.numChildren > 0)
                {
                    
                    this.collectionsContainer.removeChildAt(0);
                }
            }
            if (firstTimeCollections && !hasExecutedFirstTimeCollections)
            {
                showhowItWorksToolTip(10000);
                hasExecutedFirstTimeCollections = true;
            }
            this.collections = new Array();
            for each (_loc_6 in param1)
            {
                
                if (_loc_6["enabled"])
                {
                    _loc_13 = new Array();
                    for each (_loc_14 in _loc_6.items)
                    {
                        
                        if (_loc_14["enabled"])
                        {
                            _loc_15 = Number(_loc_14["shareOnlySeconds"]) > 0 ? (true) : (false);
                            if (_loc_4)
                            {
                                _loc_16 = new ProfileCollectionItemFriend();
                                _loc_16.init(Number(_loc_14["id"]), _loc_14["name"], _loc_14["flashUrl"], _loc_15);
                            }
                            else
                            {
                                _loc_16 = new ProfileCollectionItem();
                                _loc_16.init(Number(_loc_14["id"]), _loc_14["name"], _loc_14["flashUrl"], _loc_15);
                            }
                            _loc_13.push(_loc_16);
                        }
                    }
                    if (_loc_4)
                    {
                        _loc_5 = new ProfileCollectionFriend();
                        _loc_5.init(Number(_loc_6["id"]), _loc_6["name"], _loc_13, Number(_loc_6["unlockedAfter"]));
                    }
                    else
                    {
                        _loc_5 = new ProfileCollection();
                        _loc_5.init(Number(_loc_6["id"]), _loc_6["name"], _loc_6["filledReward"], _loc_13, Number(_loc_6["unlockedAfter"]));
                    }
                    this.collections.push(_loc_5);
                }
            }
            _loc_7 = new Array();
            if (_loc_4)
            {
                _loc_8 = param3 != null && param3.hasOwnProperty("inventory") ? (param3["inventory"]) : (null);
                if (_loc_8 != null && _loc_8.hasOwnProperty("collection") && _loc_8["collection"] != null)
                {
                    for each (_loc_9 in _loc_8["collection"])
                    {
                        
                        if (_loc_9.hasOwnProperty("loot") && _loc_9["loot"] != null)
                        {
                            for each (_loc_5 in this.collections)
                            {
                                
                                if (_loc_9.hasOwnProperty("id") && _loc_5.id == _loc_9["id"])
                                {
                                    for each (_loc_10 in _loc_9["loot"])
                                    {
                                        
                                        if (_loc_10.hasOwnProperty("id") && _loc_10.hasOwnProperty("cnt"))
                                        {
                                            _loc_5.setItemCount(Number(_loc_10["id"]), int(_loc_10["cnt"]));
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                _loc_17 = param3 != null && param3.hasOwnProperty("wishlist") ? (param3["wishlist"]) : (null);
                if (_loc_17 != null)
                {
                    for each (_loc_10 in _loc_17)
                    {
                        
                        if (_loc_10.hasOwnProperty("lootId") && _loc_10.hasOwnProperty("collectionId"))
                        {
                            for each (_loc_5 in this.collections)
                            {
                                
                                if (_loc_5.id == Number(_loc_10["collectionId"]))
                                {
                                    _loc_5.setItemWishlist(Number(_loc_10["lootId"]), true);
                                }
                            }
                        }
                    }
                }
                _loc_8 = param2 != null && param2.hasOwnProperty("inventory") ? (param2["inventory"]) : (null);
                if (_loc_8 != null && _loc_8.hasOwnProperty("collection") && _loc_8["collection"] != null)
                {
                    for each (_loc_9 in _loc_8["collection"])
                    {
                        
                        if (_loc_9.hasOwnProperty("loot") && _loc_9["loot"] != null)
                        {
                            for each (_loc_5 in this.collections)
                            {
                                
                                if (_loc_9.hasOwnProperty("id") && _loc_5.id == _loc_9["id"])
                                {
                                    if (Number(_loc_9["timeLastClaimed"]) > 0)
                                    {
                                        _loc_7.push(_loc_5.id);
                                    }
                                    for each (_loc_10 in _loc_9["loot"])
                                    {
                                        
                                        if (_loc_10.hasOwnProperty("id") && _loc_10.hasOwnProperty("cnt"))
                                        {
                                            _loc_5.setItemOwnCount(Number(_loc_10["id"]), int(_loc_10["cnt"]));
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                _loc_8 = param2 != null && param2.hasOwnProperty("inventory") ? (param2["inventory"]) : (null);
                if (_loc_8 != null && _loc_8.hasOwnProperty("collection") && _loc_8["collection"] != null)
                {
                    for each (_loc_9 in _loc_8["collection"])
                    {
                        
                        if (_loc_9.hasOwnProperty("loot") && _loc_9["loot"] != null)
                        {
                            for each (_loc_5 in this.collections)
                            {
                                
                                if (_loc_9.hasOwnProperty("id") && _loc_5.id == _loc_9["id"])
                                {
                                    if (Number(_loc_9["timeLastClaimed"]) > 0)
                                    {
                                        _loc_7.push(_loc_5.id);
                                    }
                                    for each (_loc_10 in _loc_9["loot"])
                                    {
                                        
                                        if (_loc_10.hasOwnProperty("id") && _loc_10.hasOwnProperty("cnt"))
                                        {
                                            _loc_18 = _loc_10.hasOwnProperty("newCnt") && Number(_loc_10["newCnt"]) > 0 ? (true) : (false);
                                            _loc_5.setItemCount(Number(_loc_10["id"]), int(_loc_10["cnt"]), _loc_18);
                                        }
                                        if (_loc_10.hasOwnProperty("howReceived") && _loc_10["howReceived"] != null)
                                        {
                                            if (_loc_10["howReceived"].hasOwnProperty("type") && _loc_10["howReceived"]["type"] != "wonHand")
                                            {
                                                if (_loc_10["howReceived"].hasOwnProperty("senderZid") && _loc_10["howReceived"].hasOwnProperty("senderFirstName"))
                                                {
                                                    _loc_5.setItemSharedFrom(Number(_loc_10["id"]), _loc_10["howReceived"]["senderZid"], _loc_10["howReceived"]["senderFirstName"]);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            for each (_loc_5 in this.collections)
            {
                
                _loc_19 = _loc_5.unlockedAfterCollectionID > 0 && _loc_7.indexOf(_loc_5.unlockedAfterCollectionID) < 0 ? (true) : (false);
                if (_loc_19)
                {
                    _loc_20 = "";
                    for each (_loc_21 in this.collections)
                    {
                        
                        if (_loc_5.unlockedAfterCollectionID == _loc_21.id)
                        {
                            _loc_20 = _loc_21.label;
                            break;
                        }
                    }
                    _loc_5.setLocked(true, "Complete the " + _loc_20 + " collection to unlock.");
                }
            }
            _loc_11 = 0;
            _loc_12 = 6;
            for each (_loc_5 in this.collections)
            {
                
                this.collectionsContainer.addChild(_loc_5 as DisplayObject);
                _loc_5.x = _loc_12;
                _loc_5.y = _loc_11 * 142 + _loc_12 * (_loc_11 + 1);
                _loc_11++;
            }
            this.collectionsContainer.graphics.clear();
            this.collectionsContainer.graphics.beginFill(16711680, 0);
            this.collectionsContainer.graphics.drawRect(0, 0, 10, this.collectionsContainer.height + 40);
            this.collectionsScrollPane.source = this.collectionsContainer;
            if (stage != null)
            {
                this.collectionsScrollPane.verticalScrollPosition = 0;
            }
            return;
        }// end function

        private function onHowItWorksMouseOver(event:MouseEvent) : void
        {
            showhowItWorksToolTip();
            return;
        }// end function

        private function showhowItWorksToolTip(param1:Number = 0) : void
        {
            var _loc_2:String = null;
            if (howItWorksToolTip == null)
            {
                _loc_2 = howItWorksToolTipText;
                howItWorksToolTip = new Tooltip(_loc_2.length < 100 ? (220) : (320), _loc_2, "How It Works", null);
                howItWorksToolTip.x = 40;
                howItWorksToolTip.y = 40;
                addChild(howItWorksToolTip);
            }
            if (param1 > 0)
            {
                if (howItWorksToolTipTimer == null)
                {
                    howItWorksToolTipTimer = new Timer(param1, 1);
                    howItWorksToolTipTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onHowItWorksToolTipTimerComplete);
                }
                else
                {
                    howItWorksToolTipTimer.reset();
                    howItWorksToolTipTimer.delay = param1;
                }
                howItWorksToolTipTimer.start();
            }
            return;
        }// end function

        private function onSkipButtonMouseOut(event:MouseEvent) : void
        {
            skipButton.gotoAndStop("default");
            return;
        }// end function

        private function onHowItWorksMouseOut(event:MouseEvent) : void
        {
            hidehowItWorksToolTip();
            return;
        }// end function

        private function hidehowItWorksToolTip() : void
        {
            if (howItWorksToolTip != null && contains(howItWorksToolTip))
            {
                howItWorksToolTip.visible = false;
                removeChild(howItWorksToolTip);
                howItWorksToolTip = null;
            }
            if (howItWorksToolTipTimer != null)
            {
                howItWorksToolTipTimer.stop();
                howItWorksToolTipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onHowItWorksToolTipTimerComplete);
                howItWorksToolTipTimer = null;
            }
            return;
        }// end function

    }
}
