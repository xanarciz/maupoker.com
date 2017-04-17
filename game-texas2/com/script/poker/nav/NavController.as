package com.script.poker.nav
{
    import com.script.*;
    import com.script.poker.*;
    import com.script.poker.events.*;
    import com.script.poker.nav.events.*;
    import com.script.poker.nav.sidenav.events.*;
    import com.script.poker.nav.topnav.events.*;
    import com.script.poker.popups.modules.profile.*;
    import com.script.poker.protocol.*;
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;

    public class NavController extends EventDispatcher
    {
        private var viewer:User;
        private var pcmConnect:PokerConnectionManager;
        private var pgData:PokerGlobalData;
        private var navModel:NavModel;
        private var pControl:PokerController;
        private var bPokerGramsClicked:Boolean = false;
        public var bIsInLobby:Boolean = false;
        private var navView:Object;
        private var bSideNavRequestedGiftShop:Boolean = false;
        private var json:Object;
        private var bXpInfoInit:Boolean = false;
        private var mainDisp:MovieClip;
        /*public static var STATHIT_NC_SIDENAVCLICKPROFILE:PokerStatHit = new PokerStatHit("", 0, 0, 0, PokerStatsManager.TRACKHIT_THROTTLED, "Canvas Other Click o:SideNav:Profile:2010-01-27");
        public static var STATHIT_NC_SIDENAVCLICKEARNCHIPS:PokerStatHit = new PokerStatHit("", 0, 0, 0, PokerStatsManager.TRACKHIT_THROTTLED, "Canvas Other Click o:SideNav:EarnChips:2010-01-27");
        public static var STATHIT_NC_SIDENAVCLICKGIFTSHOP:PokerStatHit = new PokerStatHit("", 0, 0, 0, PokerStatsManager.TRACKHIT_THROTTLED, "Canvas Other Click o:SideNav:GiftShop:2010-01-27");
        public static var STATHIT_NC_SIDENAVCLICKCHALLENGES:PokerStatHit = new PokerStatHit("", 0, 0, 0, PokerStatsManager.TRACKHIT_THROTTLED, "Canvas Other Click o:SideNav:Challenges:2010-01-27");
        public static var STATHIT_NC_SIDENAVCLICKGETCHIPS:PokerStatHit = new PokerStatHit("", 0, 0, 0, PokerStatsManager.TRACKHIT_THROTTLED, "Canvas Other Click o:SideNav:GetChips:2010-01-27");
        public static var STATHIT_NC_SIDENAVCLICKBUDDIES:PokerStatHit = new PokerStatHit("", 0, 0, 0, PokerStatsManager.TRACKHIT_THROTTLED, "Canvas Other Click o:SideNav:Buddies:2010-01-27");
*/
        public function NavController()
        {
            navModel = new NavModel();
            return;
        }// end function

        public function displayNav() : void
        {
            mainDisp.mainView.addChildAt(navView as DisplayObject, mainDisp.mainView.numChildren);
            showSideNavInLobbyMode();
            updateChips();
            return;
        }// end function

        private function onAchievementsClicked(event:NVEvent) : void
        {
            navView.dispatchEvent(new SidenavEvents(SidenavEvents.PANEL_SELECTED, {panel:"profile"}));
            navView.dispatchEvent(new TopnavEvent(TopnavEvent.NEW_ACHIEVEMENTS_NOTIFICATION_RESET));
            dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
            var _loc_2:Object = {zid:pgData.zid, playerName:pgData.name};
            this.dispatchEvent(new ProfilePopupEvent("showProfile", _loc_2, ProfilePanelTab.ACHIEVEMENTS));
            return;
        }// end function

        private function onPokerGramsClicked(event:NVEvent) : void
        {
            if (pgData.sn_id == pgData.SN_FACEBOOK)
            {
                if (bPokerGramsClicked)
                {
                    pgData.callFBJS("hide_pokerNotifs");
                }
                else
                {
                    pgData.callFBJS("show_pokerNotifs");
                }
            }
            else if (pgData.jsCallType == "none")
            {
            }
            else if (ExternalInterface.available)
            {
                if (bPokerGramsClicked)
                {
                    ExternalInterface.call("hide_pokerNotifs");
                }
                else
                {
                    ExternalInterface.call("show_pokerNotifs");
                }
            }
            bPokerGramsClicked = bPokerGramsClicked ? (false) : (true);
            dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
            return;
        }// end function

        public function setSidebarItemsSelected(param1:String = "") : void
        {
            navView.dispatchEvent(new SidenavEvents(SidenavEvents.PANEL_SELECTED, {panel:param1}));
            return;
        }// end function

        public function setSidebarItemsDeselected(param1:String = "") : void
        {
            if (navView)
            {
                if (param1 == "pokergrams")
                {
                    bPokerGramsClicked = false;
                    navView.setPokergramsDeselected();
                }
                else
                {
                    navView.setSidebarItemsDeselected(param1);
                }
            }
            return;
        }// end function

        public function onShowChallengesClicked(event:NVEvent) : void
        {
            this.showChallengesPanel(0);
            PokerStatsManager.DoHitForStat(STATHIT_NC_SIDENAVCLICKCHALLENGES);
            return;
        }// end function

        private function onShowGetChips(event:NVEvent) : void
        {
            showGetChipsPanel("left");
            PokerStatsManager.DoHitForStat(STATHIT_NC_SIDENAVCLICKGETCHIPS);
            return;
        }// end function

        private function initListeners() : void
        {
            navView.addEventListener(NVEvent.USER_PIC_CLICKED, onShowUserProfile);
            navView.addEventListener(NVEvent.SHOW_GIFT_SHOP, onShowGiftShop);
            navView.addEventListener(NVEvent.HIDE_GIFT_SHOP, onSideNavHideGiftShop);
            navView.addEventListener(NVEvent.SHOW_USER_PROFILE, onShowUserProfile);
            navView.addEventListener(NVEvent.HIDE_USER_PROFILE, onSideNavHideUserProfile);
            navView.addEventListener(NVEvent.SHOW_GET_CHIPS, onShowGetChips);
            navView.addEventListener(NVEvent.HIDE_GET_CHIPS, onSideNavHideGetChips);
            navView.addEventListener(NVEvent.SHOW_EARN_CHIPS, onShowEarnChips);
            navView.addEventListener(NVEvent.HIDE_EARN_CHIPS, onSideNavHideEarnChips);
            navView.addEventListener(NVEvent.GET_CHIPS_CLICKED, onGetChipsClicked);
            navView.addEventListener(NVEvent.POKERGRAMS_CLICKED, onPokerGramsClicked);
            navView.addEventListener(NVEvent.ACHIEVEMENTS_CLICKED, onAchievementsClicked);
            navView.addEventListener(NVEvent.SHOW_BUDDIES, onShowBuddies);
            navView.addEventListener(NVEvent.HIDE_BUDDIES, onSideNavHideBuddies);
            navView.addEventListener(NVEvent.SHOW_CHALLENGES, onShowChallengesClicked);
            navView.addEventListener(NVEvent.HIDE_CHALLENGES, onSideNavHideChallenges);
            return;
        }// end function

        private function onShowEarnChips(event:NVEvent) : void
        {
            this.openJSPopup("earnchips", {loc:"left"});
            dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
            PokerStatsManager.DoHitForStat(STATHIT_NC_SIDENAVCLICKEARNCHIPS);
            return;
        }// end function

        private function onSideNavHideBuddies(event:NVEvent) : void
        {
            dispatchEvent(new NCEvent(NCEvent.CLOSE_PHP_POPUPS));
            return;
        }// end function

        public function showGetChipsPanel(param1:String) : void
        {
            navView.dispatchEvent(new SidenavEvents(SidenavEvents.PANEL_SELECTED, {panel:"getchips"}));
            this.openJSPopup("getchips", {loc:param1});
            dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
            return;
        }// end function

        private function onGoldUpdate(param1:Object) : void
        {
            var _loc_2:* = RGoldUpdate(param1);
            pgData.casinoGold = _loc_2.amt;
            updateCasinoGold();
            return;
        }// end function

        public function updateSidenavItemCount(param1:String, param2:int) : void
        {
            if (navView != null)
            {
                navView.updateSidenavItemCount(param1, param2);
            }
            return;
        }// end function

        public function updateWaitingChallengesCount(param1:int) : void
        {
            updateSidenavItemCount("Challenge", param1);
            return;
        }// end function

        public function showSideNav() : void
        {
            if (navView)
            {
                navView.showSideNav();
            }
            return;
        }// end function

        private function onSideNavHideChallenges(event:NVEvent) : void
        {
            dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
            return;
        }// end function

        private function onSideNavHideEarnChips(event:NVEvent) : void
        {
            dispatchEvent(new NCEvent(NCEvent.CLOSE_PHP_POPUPS));
            return;
        }// end function

        public function updateCasinoGold() : void
        {
            navModel.nCasinoGold = pgData.casinoGold;
            navView.updateCasinoGold(pgData.casinoGold);
            return;
        }// end function

        public function onGetChipsClicked(event:NVEvent) : void
        {
            showGetChipsPanel("top");
            return;
        }// end function

        public function showBuddies() : void
        {
            navView.sideNav.setSidebarItemsSelected("buddies");
            onShowBuddies(null);
            return;
        }// end function

        public function displayGiftShop() : void
        {
            bSideNavRequestedGiftShop = true;
            this.pControl.closeAllPopups();
            pControl.getGiftPrices3(-1, pgData.zid, bIsInLobby);
            setSidebarItemsSelected("giftshop");
            updateSidenavItemCount("Gift Shop", 0);
            return;
        }// end function

        public function hideSideNav() : void
        {
            if (navView)
            {
                navView.hideSideNav();
            }
            return;
        }// end function

        public function updateNewCollectionItemCount(param1:int) : void
        {
            updateSidenavItemCount("Profile", param1);
            return;
        }// end function

        private function onGetUserInfo(param1:Object) : void
        {
            var _loc_2:Number = NaN;
            if (param1 is RGetUserInfo)
            {
                pgData.xpLevel = param1.level;
                pgData.currentXP = param1.xp;
                pgData.xpToNextLevel = param1.xpLevelEnd;
                initNavView();
                initListeners();
                navView.updateXPInformation(param1.xp, 0, param1.level, pgData.getXPLevelName(Number(param1.level)), param1.xpLevelEnd);
                _loc_2 = param1.nextGiftUnlock < param1.nextAchievementUnlock ? (param1.nextGiftUnlock) : (param1.nextAchievementUnlock);
                navView.updateNextUnlockLevel(_loc_2);
                updateCasinoGold();
                pControl.postNavLoad_loadLobby();
                ;
            }
            return;
        }// end function

        private function onSideNavHideUserProfile(event:NVEvent) : void
        {
            dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
            return;
        }// end function

        private function onSideNavHideGiftShop(event:NVEvent) : void
        {
            dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
            return;
        }// end function

        private function initNavView() : void
        {
            var _loc_1:* = pgData.lbNav.getLoaderByType("com.script.poker.nav.NavView");
            navView = Object(_loc_1.content);
            var _loc_2:int = -1;
            if (pgData.newBuyerTestPromoFG == "18703" || pgData.newBuyerTestPromoFG == "18704" || pgData.newBuyerTestPromoFG == "18705" || pgData.newBuyerTestPromoFG == "18709")
            {
                _loc_2 = 3;
            }
            else if (pgData.newBuyerTestPromoFG == "18706")
            {
                _loc_2 = 2;
            }
            else if (pgData.newBuyerTestPromoFG == "18707")
            {
                _loc_2 = 1;
            }
            if (pgData.endOfMonthPromo == 1)
            {
                _loc_2 = 4;
            }
            navView.initNavView(navModel.sPicURL, navModel.nChips, navModel.nAchievements, navModel.nAchievementsTotal, navModel.nPokergrams, navModel.nBuddiesAlerts, navModel.aLevelRanks, pgData.pgBuyAndSend, pgData.getChipsSale, _loc_2);
            if (pgData.approvedChips > 0)
            {
                navView.approvedChips = pgData.approvedChips;
            }
            if (pgData.canceledChips > 0)
            {
                navView.canceledChips = pgData.canceledChips;
            }
            if (pgData.pendingChips > 0)
            {
                navView.pendingChips = pgData.pendingChips;
            }
            if (pgData.pendingDuration > 0)
            {
                navView.pendingDuration = pgData.pendingDuration;
            }
            if (pgData.show_getchips_tooltip == "1")
            {
                navView.showGetChipsTooltip = true;
            }
            dispatchEvent(new NCEvent(NCEvent.VIEW_INIT));
            return;
        }// end function

        public function showChallengesPanel(param1:int) : void
        {
            if (pgData.bDidGetInitialChallengeState)
            {
                setSidebarItemsSelected("challenge");
            }
            dispatchEvent(new ChallengesPopupEvent("showChallenges", param1));
            return;
        }// end function

        public function onGetGoldClicked(event:NVEvent) : void
        {
            showGetGoldPanel("top");
            return;
        }// end function

        private function onShowUserProfile(event:NVEvent) : void
        {
            var _loc_2:Object = {zid:pgData.zid, playerName:pgData.name};
            var _loc_3:* = pgData.newCollectionItemCount > 0 ? (ProfilePanelTab.COLLECTIONS) : (ProfilePanelTab.OVERVIEW);
            this.dispatchEvent(new ProfilePopupEvent("showProfile", _loc_2, _loc_3));
            PokerStatsManager.DoHitForStat(STATHIT_NC_SIDENAVCLICKPROFILE);
            return;
        }// end function

        private function onShowBuddies(event:NVEvent) : void
        {
            this.openJSPopup("buddies", {zid:pgData.zid});
            dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
            PokerStatsManager.DoHitForStat(STATHIT_NC_SIDENAVCLICKBUDDIES);
            return;
        }// end function

        private function onRAlert(param1:Object) : void
        {
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            var _loc_2:* = RAlert(param1);
            var _loc_3:* = _loc_2.oJSON;
            if (_loc_3["levelUppedXP"] != undefined)
            {
                _loc_4 = _loc_3["levelUppedXP"]["giftIdsUnlocked"];
                _loc_5 = _loc_3["levelUppedXP"]["achieveUnlocks"];
                if (_loc_4 != null)
                {
                    if (_loc_4 is Array)
                    {
                        updateSidenavItemCount("Gift Shop", int(_loc_4.length));
                    }
                }
                if (_loc_5 != null)
                {
                    if (_loc_5 is Array)
                    {
                        navView.setUnlockedAchievementCount(_loc_4.length);
                    }
                }
            }
            return;
        }// end function

        public function openJSPopup(param1:String, param2:Object) : void
        {
            var _loc_3:* = param1 != "buddies";
            if (pgData.useLaunchPopups && _loc_3)
            {
                if (ExternalInterface.available)
                {
                    pgData.callFBJS("closeNav");
                    ExternalInterface.call("ZY.App.launch.openPopup", param1, param2);
                }
            }
            else
            {
                ExternalInterface.call("ZY.App.launch.closePopup");
                if (pgData.fbConnect == "1")
                {
                    ExternalInterface.call("openNav", param1, param2);
                }
                else
                {
                    pgData.callFBJS("openNav", param1, param2);
                }
            }
            return;
        }// end function

        public function startNavController(param1:MovieClip, param2:PokerGlobalData, param3:PokerController, param4:PokerConnectionManager) : void
        {
            mainDisp = param1;
            pgData = param2;
            pControl = param3;
            pcmConnect = param4;
            viewer = pgData.viewer;
            initNavModel();
            pcmConnect.sendMessage(new SGetUserInfo("SGetUserInfo", "casino_gold", "xp"));
            pcmConnect.addEventListener("onMessage", onProtocolMessage);
            return;
        }// end function

        public function updateChips() : void
        {
            if (pgData.dispMode == "challenge" || pgData.dispMode == "vip")
            {
                navModel.nChips = pgData.points;
                navView.updateChips(navModel.nChips);
            }
            return;
        }// end function

        public function showSideNavInTableMode() : void
        {
            if (navView)
            {
                navView.showSideNavInTableMode();
                navView.showSideNav();
            }
            bIsInLobby = false;
            return;
        }// end function

        private function onSideNavHideGetChips(event:NVEvent) : void
        {
            dispatchEvent(new NCEvent(NCEvent.CLOSE_PHP_POPUPS));
            return;
        }// end function

        private function onShowGiftShop(event:NVEvent) : void
        {
            displayGiftShop();
            PokerStatsManager.DoHitForStat(STATHIT_NC_SIDENAVCLICKGIFTSHOP);
            return;
        }// end function

        public function showGetGoldPanel(param1:String) : void
        {
            this.onShowGetChips(null);
            return;
        }// end function

        private function onUserLevelledUp(param1:Object) : void
        {
            var _loc_2:Number = NaN;
            if (param1 is RUserLevelledUp)
            {
                if (param1.zid == pgData.viewer.zid)
                {
                    _loc_2 = param1.nextGiftUnlock < param1.nextAchievementUnlock ? (param1.nextGiftUnlock) : (param1.nextAchievementUnlock);
                    if (navView != null)
                    {
                        navView.updateNextUnlockLevel(_loc_2);
                    }
                }
            }
            return;
        }// end function

        private function onXPEarned(param1:Object) : void
        {
            if (param1 is RXPEarned)
            {
                pgData.xpLevel = param1.level;
                pgData.currentXP = param1.xpTotal;
                pgData.xpToNextLevel = param1.xpToNextLevel;
                navView.updateXPInformation(param1.xpTotal, param1.xpDelta, param1.level, pgData.getXPLevelName(Number(param1.level)), param1.xpToNextLevel);
                ;
            }
            return;
        }// end function

        private function onProtocolMessage(event:ProtocolEvent) : void
        {
            var _loc_3:RAchieved = null;
            var _loc_2:* = event.msg;
            switch(_loc_2.type)
            {
                case "RAchieved":
                {
                    _loc_3 = RAchieved(event.msg);
                    if (_loc_3.sZid == pgData.viewer.zid)
                    {
                        var _loc_4:* = navModel;
                        var _loc_5:* = navModel.nAchievements + 1;
                        _loc_4.nAchievements = _loc_5;
                        navView.updateAchievements(navModel.nAchievements);
                    }
                    break;
                }
                case "RGiftPrices2":
                {
                    if (bSideNavRequestedGiftShop)
                    {
                        dispatchEvent(new GiftPopupEvent("showDrinkMenu", -1, [], pgData.zid) as PopupEvent);
                    }
                    bSideNavRequestedGiftShop = false;
                    break;
                }
                case "RGiftPrices3":
                {
                    if (bSideNavRequestedGiftShop)
                    {
                        this.pControl.closeAllPopups();
                        dispatchEvent(new GiftPopupEvent("showDrinkMenu", -1, [], pgData.zid) as PopupEvent);
                    }
                    bSideNavRequestedGiftShop = false;
                    break;
                }
                case "RUpdateChips":
                {
                    break;
                }
                default:
                {
                    break;
                }
                case "RGetUserInfo":
                {
                    onXPEarned(_loc_2);
                    break;
                }
                case "RAlert":
                {
                    if (!bXpInfoInit)
                    {
                        onGetUserInfo(_loc_2);
                    }
                    bXpInfoInit = true;
                    break;
                }
                case "RUserLevelledUp":
                {
                    onRAlert(_loc_2);
                    break;
                }
                case "RGoldUpdate":
                {
                    onUserLevelledUp(_loc_2);
                    break;
                }
                case "":
                {
                    onGoldUpdate(_loc_2);
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function getChips() : Number
        {
            return navModel.nChips;
        }// end function

        public function showSideNavInLobbyMode() : void
        {
            if (navView)
            {
                navView.showSideNavInLobbyMode();
                navView.showSideNav();
            }
            bIsInLobby = true;
            return;
        }// end function

        public function showChipsGoldTooltip() : void
        {
            navView.showCasinoGoldTip(5000);
            return;
        }// end function

        private function initNavModel() : void
        {
            navModel.nChips = pgData.points;
            navModel.aLevelRanks = pgData.aLevelRanks;
            navModel.nAchievements = pgData.nAchievementNumber;
            navModel.nAchievementsTotal = pgData.nAchievementCount;
            navModel.nPokergrams = pgData.nPokergrams;
            navModel.nBuddiesAlerts = 0;
            navModel.sPicURL = pgData.pic_url;
            return;
        }// end function

    }
}
