package com.script.poker.nav
{
    import caurina.transitions.*;
    import com.script.draw.tooltip.*;
    import com.script.format.*;
    import com.script.poker.nav.events.*;
    import com.script.poker.nav.sidenav.*;
    import com.script.poker.nav.sidenav.events.*;
    import com.script.poker.nav.topnav.*;
    import com.script.poker.nav.topnav.events.*;
    import com.script.text.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class NavView extends MovieClip
    {
        public var tooltipTimer:Timer;
        private const SIDENAV_TABLEMODE_POSITION_Y:Number = 212;
        private var _pendingDuration:Number = 36;
        private var processingChipsContainer:Sprite;
        public var topNav:TopNav;
        private var _canceledChips:Number = 0;
        public var sideNavData:Array;
        public var buddiesAlerts:int = 0;
        private var processingChipsText:HtmlTextBox;
        private var processingChipsToolTipTitle:String;
        private var _pendingChips:Number = 0;
        private var _approvedChips:Number = 0;
        private var processingChipsToolTipText:Array;
        public var removeThis:String;
        public var sideNav:Sidenav;
        public var casinoGoldTip:Tooltip;
        private var processingChipsToolTip:Tooltip;
        public var chipsTip:Tooltip;
        private const SIDENAV_LOBBYMODE_POSITION_Y:Number = 212;

        public function NavView() : void
        {
            sideNavData = [{title:"Challenge", gfx:ChallengesIcon, alerts:0}, {title:"Gift Shop", gfx:GiftShopIcon, alerts:0}, {title:"Profile", gfx:ProfileIcon, alerts:0}, {title:"Buddies", gfx:BuddiesIcon, alerts:0}, {title:"Get Chips", gfx:GetChipsIcon, alerts:0}, {title:"Earn Chips", gfx:EarnChipsIcon, alerts:0}];
            return;
        }// end function

        private function onTooltipTimer(event:TimerEvent) : void
        {
            tooltipTimer.stop();
            tooltipTimer.reset();
            hideCasinoGoldTip();
            return;
        }// end function

        private function onPokerGramsClicked(event:NVEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        public function setSidebarItemsDeselected(param1:String = "") : void
        {
            sideNav.setSidebarItemsDeselected(param1);
            return;
        }// end function

        private function onChipsRollout(event:NVEvent) : void
        {
            hideChipsTip();
            return;
        }// end function

        public function showChipsTip() : void
        {
            setChildIndex(chipsTip, (numChildren - 1));
            Tweener.addTween(chipsTip, {alpha:1, time:0.33, transition:"easeInSine"});
            return;
        }// end function

        public function updateAchievements(param1:int) : void
        {
            topNav.updateAchievements(param1);
            return;
        }// end function

        public function get showGetChipsTooltip() : Boolean
        {
            return topNav.showGetChipsTooltip;
        }// end function

        private function onGetChipsClicked(event:NVEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function setSidebarItemsSelected(param1:SidenavEvents) : void
        {
            sideNav.setSidebarItemsSelected(param1.data.panel);
            return;
        }// end function

        public function get canceledChips() : Number
        {
            return _canceledChips;
        }// end function

        public function set pendingChips(param1:Number) : void
        {
            _pendingChips = param1;
            updateProcessingChips();
            return;
        }// end function

        public function set canceledChips(param1:Number) : void
        {
            _canceledChips = param1;
            updateProcessingChips();
            return;
        }// end function

        public function onProcessingChipsContainerMouseOut(event:MouseEvent) : void
        {
            Tweener.addTween(processingChipsToolTip, {alpha:0, time:0.2, transition:"easeInSine"});
            return;
        }// end function

        public function set pendingDuration(param1:Number) : void
        {
            _pendingDuration = param1;
            updateProcessingChips();
            return;
        }// end function

        private function onAchievementsClicked(event:NVEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        public function initListeners() : void
        {
            topNav.addEventListener(NVEvent.USER_PIC_CLICKED, onUserPicClicked);
            topNav.addEventListener(NVEvent.GET_CHIPS_CLICKED, onGetChipsClicked);
            topNav.addEventListener(NVEvent.GOLD_ROLLOVER, onGoldRollover);
            topNav.addEventListener(NVEvent.GOLD_ROLLOUT, onGoldRollout);
            topNav.addEventListener(NVEvent.CHIPS_ROLLOVER, onChipsRollover);
            topNav.addEventListener(NVEvent.CHIPS_ROLLOUT, onChipsRollout);
            topNav.addEventListener(NVEvent.POKERGRAMS_CLICKED, onPokerGramsClicked);
            topNav.addEventListener(NVEvent.ACHIEVEMENTS_CLICKED, onAchievementsClicked);
            SidenavEvents.disp.addEventListener(SidenavEvents.REQUEST_PANEL, onSideNavRequestPanel);
            SidenavEvents.disp.addEventListener(SidenavEvents.CLOSE_PANEL, onSideNavClosePanel);
            addEventListener(SidenavEvents.PANEL_SELECTED, setSidebarItemsSelected);
            addEventListener(TopnavEvent.NEW_ACHIEVEMENTS_NOTIFICATION_RESET, onAchievementsNotificationReset);
            return;
        }// end function

        public function setPokergramsDeselected() : void
        {
            topNav.pokerGramsBtn.gotoAndStop(1);
            return;
        }// end function

        public function set showGetChipsTooltip(param1:Boolean) : void
        {
            topNav.showGetChipsTooltip = param1;
            return;
        }// end function

        public function updateNextUnlockLevel(param1:Number) : void
        {
            topNav.updateNextUnlockLevel(param1);
            return;
        }// end function

        public function updateCasinoGold(param1:Number) : void
        {
            topNav.updateCasinoGold(param1);
            return;
        }// end function

        private function onUserPicClicked(event:NVEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        public function get approvedChips() : Number
        {
            return _approvedChips;
        }// end function

        public function getSideNavItemByName(param1:String) : SidenavItem
        {
            return sideNav.getSideItem(param1);
        }// end function

        public function setUnlockedAchievementCount(param1:Number) : void
        {
            topNav.setUnlockedAchievementCount(param1);
            return;
        }// end function

        public function initNavView(param1:String, param2:Number, param3:int, param4:int, param5:int, param6:int, param7:Array, param8:int = 0, param9:Boolean = false, param10:int = -1) : void
        {
            topNav = new TopNav();
            topNav.y = 0;
            topNav.initTopNav(param1, param2, param3, param4, param5, param7, param8, param10);
            addChild(topNav);
            buddiesAlerts = param6;
            sideNav = new Sidenav();
            sideNav.y = SIDENAV_LOBBYMODE_POSITION_Y;
            sideNav.initSideNav(sideNavData, param9, param10);
            addChild(sideNav);
            var _loc_11:Array = [{text:"Premium items in the gift shop can only be purchased with Casino Gold.  Casino Gold can also be used to buy-back into weekly tournaments." + "\r\rPurchase additional Casino Gold by clicking on ", color:0, font:"MainLight", size:11}, {text:"Get Chips & Gold", color:0, font:"Main", size:11}];
            casinoGoldTip = new Tooltip(325, _loc_11, "Casino Gold", "ul");
            casinoGoldTip.x = 167;
            casinoGoldTip.y = 55;
            addChild(casinoGoldTip);
            casinoGoldTip.visible = false;
            casinoGoldTip.alpha = 0;
            casinoGoldTip.mouseEnabled = false;
            casinoGoldTip.mouseChildren = false;
            var _loc_12:Array = [{text:"Chips can be used for playing poker + purchasing basic items in the gift shop." + "\r\rPurchase/earn additional chips by clicking on ", color:0, font:"MainLight", size:11}, {text:"Get Chips & Gold", color:0, font:"Main", size:11}];
            chipsTip = new Tooltip(300, _loc_12, "Chips", "ul");
            chipsTip.x = 22;
            chipsTip.y = 55;
            addChild(chipsTip);
            chipsTip.alpha = 0;
            chipsTip.mouseEnabled = false;
            chipsTip.mouseChildren = false;
            initListeners();
            return;
        }// end function

        public function hideSideNav() : void
        {
            Tweener.addTween(sideNav, {x:-(sideNav.width + 4), time:0.5, transition:"easeInExpo"});
            return;
        }// end function

        public function updateSidenavItemCount(param1:String, param2:int) : void
        {
            var _loc_4:int = 0;
            var _loc_3:* = getSideNavItemByName(param1);
            if (_loc_3 != null)
            {
                _loc_3.updateAlert(param2);
                _loc_4 = 0;
                while (_loc_4 < _loc_3.numChildren)
                {
                    
                    if (_loc_3.getChildAt(_loc_4).name == "starburst")
                    {
                        _loc_3.getChildAt(_loc_4).visible = param2 == 0 ? (true) : (false);
                    }
                    _loc_4++;
                }
            }
            return;
        }// end function

        private function onSideNavClosePanel(param1:SidenavEvents) : void
        {
            var _loc_3:String = null;
            var _loc_2:* = sideNavData[parseInt(String(param1.data))];
            if (_loc_2 != null)
            {
                _loc_3 = String(_loc_2.title);
                switch(_loc_3)
                {
                    case "Gift Shop":
                    {
                        dispatchEvent(new NVEvent(NVEvent.HIDE_GIFT_SHOP));
                        break;
                    }
                    case "Profile":
                    {
                        dispatchEvent(new NVEvent(NVEvent.HIDE_USER_PROFILE));
                        break;
                    }
                    case "Buddies":
                    {
                        dispatchEvent(new NVEvent(NVEvent.HIDE_BUDDIES));
                        break;
                    }
                    case "Get Chips":
                    {
                        dispatchEvent(new NVEvent(NVEvent.HIDE_GET_CHIPS));
                        break;
                    }
                    case "Earn Chips":
                    {
                        dispatchEvent(new NVEvent(NVEvent.HIDE_EARN_CHIPS));
                        break;
                    }
                    case "Challenge":
                    {
                        dispatchEvent(new NVEvent(NVEvent.HIDE_CHALLENGES));
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function onAchievementsNotificationReset(event:TopnavEvent) : void
        {
            topNav.hideUnlockedAchievementCount();
            return;
        }// end function

        public function hideCasinoGoldTip() : void
        {
            Tweener.addTween(casinoGoldTip, {alpha:0, time:0.2, transition:"easeInSine"});
            return;
        }// end function

        public function showSideNav() : void
        {
            Tweener.addTween(sideNav, {x:0, time:0.5, transition:"easeOutExpo"});
            return;
        }// end function

        public function get pendingDuration() : Number
        {
            return _pendingDuration;
        }// end function

        public function get pendingChips() : Number
        {
            return _pendingChips;
        }// end function

        private function onSideNavRequestPanel(param1:SidenavEvents) : void
        {
            var _loc_3:String = null;
            var _loc_2:* = sideNavData[parseInt(String(param1.data))];
            if (_loc_2 != null)
            {
                _loc_3 = String(_loc_2.title);
                switch(_loc_3)
                {
                    case "Gift Shop":
                    {
                        dispatchEvent(new NVEvent(NVEvent.SHOW_GIFT_SHOP));
                        break;
                    }
                    case "Profile":
                    {
                        dispatchEvent(new NVEvent(NVEvent.SHOW_USER_PROFILE));
                        break;
                    }
                    case "Buddies":
                    {
                        dispatchEvent(new NVEvent(NVEvent.SHOW_BUDDIES));
                        break;
                    }
                    case "Get Chips":
                    {
                        dispatchEvent(new NVEvent(NVEvent.SHOW_GET_CHIPS));
                        break;
                    }
                    case "Earn Chips":
                    {
                        dispatchEvent(new NVEvent(NVEvent.SHOW_EARN_CHIPS));
                        break;
                    }
                    case "Challenge":
                    {
                        dispatchEvent(new NVEvent(NVEvent.SHOW_CHALLENGES));
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function hideChipsTip() : void
        {
            Tweener.addTween(chipsTip, {alpha:0, time:0.2, transition:"easeInSine"});
            return;
        }// end function

        private function onGoldRollover(event:NVEvent) : void
        {
            showCasinoGoldTip();
            return;
        }// end function

        private function onGoldRollout(event:NVEvent) : void
        {
            hideCasinoGoldTip();
            return;
        }// end function

        private function updateProcessingChips() : void
        {
            var _loc_2:uint = 0;
            var _loc_3:String = null;
            var _loc_1:Boolean = false;
            if (_approvedChips > 0)
            {
                _loc_1 = true;
                _loc_2 = 65280;
                _loc_3 = "$" + StringUtility.StringToMoney(_approvedChips) + " Deposited";
                processingChipsToolTipTitle = "Poker deposited your chips!";
                processingChipsToolTipText = [{text:"Thanks for your patience. We apologize for the delay!\nGood luck at the tables!", color:0, font:"MainLight", size:11}];
            }
            else if (_canceledChips > 0)
            {
                _loc_1 = true;
                _loc_2 = 16711680;
                _loc_3 = "$" + StringUtility.StringToMoney(_canceledChips) + " Cancelled";
                processingChipsToolTipTitle = "Your chip purchase was cancelled.";
                processingChipsToolTipText = [{text:"We were unable to process your transaction and cannot grant chips.\n\nYour credit card has NOT BEEN CHARGED. Please contact your credit card company if you have any questions.", color:0, font:"MainLight", size:11}];
            }
            else if (_pendingChips > 0)
            {
                _loc_1 = true;
                _loc_2 = 3394611;
                _loc_3 = "$" + StringUtility.StringToMoney(_pendingChips) + " Processing";
                processingChipsToolTipTitle = "Thank you for your chip purchase!";
                processingChipsToolTipText = [{text:"We apologize for the delay, but Poker needs to wait for your payment to clear. This may take up to " + _pendingDuration + " hours.\n\nWe are holding your chips in a safe place until that time!", color:0, font:"MainLight", size:11}];
            }
            if (_loc_1)
            {
                if (processingChipsText != null)
                {
                    processingChipsContainer.removeChild(processingChipsText);
                    processingChipsText = null;
                }
                processingChipsText = new HtmlTextBox("Main", _loc_3, 11, _loc_2, "left");
                processingChipsText.x = 5;
                processingChipsText.y = 10;
                if (processingChipsContainer == null)
                {
                    processingChipsContainer = new Sprite();
                    processingChipsContainer.graphics.beginFill(1118481, 0.75);
                    processingChipsContainer.graphics.lineStyle(1, 0, 0.75, true);
                    processingChipsContainer.graphics.drawRoundRect(0, 0, processingChipsText.width + 10, 18, 10, 10);
                    processingChipsContainer.x = 40;
                    processingChipsContainer.y = 30;
                    addChild(processingChipsContainer);
                    processingChipsContainer.addEventListener(MouseEvent.MOUSE_OVER, onProcessingChipsContainerMouseOver);
                    processingChipsContainer.addEventListener(MouseEvent.MOUSE_OUT, onProcessingChipsContainerMouseOut);
                }
                processingChipsContainer.addChild(processingChipsText);
            }
            else if (processingChipsContainer != null)
            {
                processingChipsContainer.removeEventListener(MouseEvent.MOUSE_OVER, onProcessingChipsContainerMouseOver);
                processingChipsContainer.removeEventListener(MouseEvent.MOUSE_OUT, onProcessingChipsContainerMouseOut);
                removeChild(processingChipsContainer);
                processingChipsContainer = null;
                processingChipsText = null;
            }
            return;
        }// end function

        public function showSideNavInTableMode() : void
        {
            return;
        }// end function

        public function set approvedChips(param1:Number) : void
        {
            _approvedChips = param1;
            updateProcessingChips();
            return;
        }// end function

        public function showCasinoGoldTip(param1:int = 0) : void
        {
            setChildIndex(casinoGoldTip, (numChildren - 1));
            if (casinoGoldTip.alpha != 1)
            {
                casinoGoldTip.visible = true;
                Tweener.addTween(casinoGoldTip, {alpha:1, time:0.33, transition:"easeInSine"});
            }
            if (param1 == 0)
            {
                if (tooltipTimer != null)
                {
                    tooltipTimer.stop();
                }
            }
            else
            {
                if (tooltipTimer == null)
                {
                    tooltipTimer = new Timer(param1, 1);
                    tooltipTimer.addEventListener(TimerEvent.TIMER, onTooltipTimer);
                }
                else
                {
                    tooltipTimer.reset();
                    tooltipTimer.delay = param1;
                }
                tooltipTimer.start();
            }
            return;
        }// end function

        public function updateXPInformation(param1:Number, param2:Number, param3:Number, param4:String, param5:Number) : void
        {
            topNav.updateXPInformation(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function showSideNavInLobbyMode() : void
        {
            return;
        }// end function

        public function onProcessingChipsContainerMouseOver(event:MouseEvent) : void
        {
            if (processingChipsToolTip != null)
            {
                removeChild(processingChipsToolTip);
                processingChipsToolTip = null;
            }
            processingChipsToolTip = new Tooltip(300, processingChipsToolTipText, processingChipsToolTipTitle, "ul");
            processingChipsToolTip.alpha = 0;
            processingChipsToolTip.mouseChildren = false;
            processingChipsToolTip.mouseEnabled = false;
            processingChipsToolTip.x = 22;
            processingChipsToolTip.y = 65;
            addChild(processingChipsToolTip);
            Tweener.addTween(processingChipsToolTip, {alpha:1, time:0.33, transition:"easeInSine"});
            return;
        }// end function

        public function updateChips(param1:Number) : void
        {
            topNav.updateChips(param1);
            return;
        }// end function

        private function onChipsRollover(event:NVEvent) : void
        {
            showChipsTip();
            return;
        }// end function

    }
}
