package com.script.poker.popups.modules
{
    import com.adobe.serialization.json.*;
    import com.script.display.*;
    import com.script.draw.*;
    import com.script.draw.tooltip.*;
    import com.script.format.*;
    import com.script.poker.popups.modules.events.*;
    import com.script.poker.popups.modules.profile.*;
    import com.script.poker.table.*;
    import com.script.poker.table.asset.*;
    import com.script.text.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;

    public class ProfilePanel extends MovieClip
    {
        private var _achievements:Object;
        private var _itemsView:MovieClip;
        private var _profileGiftDisplayIndex:Object = 0;
        private var _achievementTabs:Array;
        private var _tProfileGiftsLoaders:Array;
        public var userData:Object;
        private var _hasInitializedOnce:Boolean;
        private var _achievementsScrollPaneContent:MovieClip;
        public var tabIndexDisplayed:int;
        private const RECENTGIFT_HORIZONTAL_PLACEMENT:Number = 432;
        private var _displayedView:MovieClip;
        public var nameLabel:TextField;
        private var _selectedItem:ProfilePanelGiftItem;
        private var _itemsCurrentPage:int;
        private var _profileView:MovieClip;
        public var isNonFacebook:Boolean = false;
        private var _profileAchievementDisplayIndex:Object = 0;
        public var zid:String = "";
        public var buttonViewAll:PokerButton;
        public var isOwnProfile:Boolean = false;
        private var _userItems:Array;
        private var _loadingView:MovieClip;
        public var rootURL:String = "";
        private var _achievementsView:MovieClip;
        private var _tempGifts:Array;
        private var _selectedTabIndex:int = 0;
        private var _tabs:Array;
        public var hasViewedOwnCollectionsTab:Boolean = false;
        public var buttonSendGift:PokerButton;
        public var isFriend:Boolean = false;
        private var _displayedUserItems:Array;
        public var fbSig:String = "";
        public var pic:String = "";
        private var _itemsUserImage:DisplayObject;
        private var _displayedItemChickletGift:MovieClip;
        private var _collectionsView:ProfileCollectionsView;
        private var _itemsPerRow:int = 5;
        public var contentArea:MovieClip;
        private var _playerName:String = "";
        private var _itemsRowsPerPage:int = 3;
        private var achievementToolTip:Tooltip;
        public var firstTimeCollections:Boolean = false;
        public var shownGiftID:int = -1;
        private var _collectionTabCounter:CountIndicator;
        public var buttonSendChips:PokerButton;
        public var isTourneyTable:Boolean = false;
		public var langs;
		public var txt1;
		public var txt2;

        public function ProfilePanel()
        {
            _tabs = new Array();
            _achievementTabs = new Array();
            _userItems = new Array();
            _displayedUserItems = new Array();
            _tempGifts = new Array();
            return;
        }// end function
		public function preflight(param1:*)
        {
			
			
			
		}
        public function setNewCollectionItemCount(param1:Number) : void
        {
            var _loc_2:Object = null;
            if (param1 > 0)
            {
                if (_collectionTabCounter == null)
                {
                    _collectionTabCounter = new CountIndicator(param1);
                    _collectionTabCounter.x = 92;
                    _collectionTabCounter.y = 14;
                    _loc_2 = _tabs[ProfilePanelTab.COLLECTIONS];
                    if (_loc_2 != null)
                    {
                        (_loc_2.tab as MovieClip).addChild(_collectionTabCounter);
                    }
                }
                else
                {
                    _collectionTabCounter.updateCount(param1);
                    _collectionTabCounter.visible = true;
                }
            }
            else if (_collectionTabCounter != null)
            {
                _collectionTabCounter.visible = false;
            }
            if (this._collectionsView != null)
            {
                this._collectionsView.setNewCollectionItemCount(param1);
            }
            return;
        }// end function

        private function _displayGiftOnItemsChicklet(param1:int) : void
        {
            if (this._displayedItemChickletGift != null)
            {
                if (this._displayedItemChickletGift.parent)
                {
                    this._itemsView.removeChild(this._displayedItemChickletGift);
                    _releaseGiftFromMemoryPool(this._displayedItemChickletGift);
                }
            }
            if (param1 != -1)
            {
                this._itemsView.emptyChickletButton.visible = false;
                this._displayedItemChickletGift = GiftLibrary.GetInst().CreateGiftMovieClip(0, String(param1));
                if (this._displayedItemChickletGift)
                {
                    this._addGiftToMemoryPool(this._displayedItemChickletGift);
                    this._displayedItemChickletGift.buttonMode = true;
                    this._displayedItemChickletGift.mouseChildren = false;
                    this._displayedItemChickletGift.x = this._itemsUserImage.x;
                    this._displayedItemChickletGift.y = this._itemsUserImage.y + this._itemsUserImage.height / 2 + 20;
                    this._displayedItemChickletGift.addEventListener(MouseEvent.CLICK, this._itemsChickletGiftClickHandler);
                    this._itemsView.addChild(this._displayedItemChickletGift);
                }
            }
            else
            {
                this._itemsView.emptyChickletButton.visible = true;
                this._displayedItemChickletGift = null;
            }
            return;
        }// end function

        private function _itemRollOutHandler(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as ProfilePanelGiftItem;
            _loc_2.rollout();
            return;
        }// end function

        public function get playerName() : String
        {
            return this._playerName;
        }// end function

        private function _achievementLoadedHandler(event:Event) : void
        {
            var data:Object;
            var maxAchievements:int;
            var k:int;
            var achievementData:Object;
            var button:MovieClip;
            var trophyTypeText:String;
            var e:* = event;
            var achievementTabNames:Array;
            var achievementsFinished:Object;
            this._achievements = {1:[], 2:[], 3:[]};
            var loader:* = URLLoader(e.target);
            try
            {
                achievementData = JSON.decode(loader.data);
            }
            catch (e2:Error)
            {
                return;
            }
            this.playerName = achievementData.name;
            if (!this._achievementsView)
            {
                this._achievementsView = new AchievementsView();
                this._achievementsView.x = 5;
                this._achievementsView.y = 85;
                this._achievementsView.comingSoonText.visible = false;
            }
            var _loc_3:int = 0;
            var _loc_4:* = achievementData.achs;
            while (_loc_4 in _loc_3)
            {
                
                data = _loc_4[_loc_3];
                if (data.earned == "1")
                {
                    var _loc_5:* = achievementsFinished;
                    var _loc_6:* = data.ach_level;
                    var _loc_7:* = achievementsFinished[data.ach_level] + 1;
                    _loc_5[_loc_6] = _loc_7;
                }
                this._achievements[data.ach_level].push(data);
            }
            maxAchievements;
            k;
            while (k < 5)
            {
                
                button = new AchievementTab();
                button.buttonMode = true;
                button.mouseChildren = false;
                button.trophyType = k;
                button.y = 15;
                button.x = button.width * (k - 1) + 2 * (k - 1) + 8;
                button.gotoAndStop(2);
                button.trophy.gotoAndStop(1);
                button.addEventListener(MouseEvent.CLICK, this._achievementTabClickHandler);
                trophyTypeText = achievementTabNames[(k - 1)];
                if (k == 4)
                {
                    button.label.text = trophyTypeText;
                }
                else
                {
                    button.label.text = trophyTypeText + "(" + achievementsFinished[k] + "/" + this._achievements[k].length + ")";
                }
                this._achievementsView.addChild(button);
                this._achievementTabs.push(button);
                if (k < 4)
                {
                    if (this._achievements[k].length > maxAchievements)
                    {
                        maxAchievements = this._achievements[k].length;
                    }
                }
                k = (k + 1);
            }
            this._achievementsScrollPaneContent = new AchievementsContent();
            this._achievementsScrollPaneContent.contentArea.height = Math.ceil(maxAchievements / 5) * 150;
            this._achievementsView.achievementsScrollPane.source = this._achievementsScrollPaneContent;
            this._selectAchievementTab(ProfilePanelTab.ACHIEVEMENTS);
            this._setDisplayedTabView(this._achievementsView);
            return;
        }// end function
		 public function set playerName(param1:String) : void
        {
            this._playerName = param1;
            //this.contentArea.nameLabel.text = this.playerName;
			this.contentArea.nameLabel.text = "";
            return;
        }// end function

        private function _highlightTab(param1:int) : void
        {
			var _loc_3:Object = null;
            var _loc_4:MovieClip = null;
            this._selectedTabIndex = param1;
            var _loc_2:int = 0;
            for each (_loc_3 in this._tabs)
            {
                
                _loc_4 = MovieClip(_loc_3.tab);
                if (_loc_4.parent)
                {
                    if (_loc_2 == param1)
                    {
                        _loc_4.gotoAndStop(1);
                        this.contentArea.setChildIndex(_loc_4, (this.contentArea.numChildren - 1));
                    }
                    else
                    {
                        _loc_4.gotoAndStop(2);
                        this.contentArea.setChildIndex(_loc_4, 0);
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        private function _saveChangesButtonHandler(event:MouseEvent) : void
        {
            if (this._selectedItem != null)
            {
                this.dispatchEvent(new ProfileEvent(ProfileEvent.ITEM_SELECTED, {itemSelectedGiftId:(this._selectedItem as MovieClip).giftID}));
            }
            return;
        }// end function
		
		private function _profileLoadedHandler(event:Event) : void
        {
            var color:String;
            var str:String;
            var bestHandTF:HtmlTextBox;
            var loaderContext:LoaderContext;
            var recenteAchievements:Object;
            var i:int;
            var data:Object;
            var req:URLRequest;
            var type:String;
            var achievementImage:Loader;
            var giftImage:Loader;
            var e:* = event;
            var loader:* = URLLoader(e.target);
            try
            {
                this.userData = JSON.decode(loader.data);
            }
            catch (e:Error)
            {
                return;
            }
            if (this._profileView)
            {
                this.contentArea.removeChild(this._profileView);
            }
			this._profileView = new OverviewView();
            this._profileView.x = 5;
            this._profileView.y = 85;
            this.contentArea.addChild(this._profileView);
            var rankLabelTF:* = new HtmlTextBox("Arial Bold", userData.rank, 11, 0);
            rankLabelTF.x = 14;
            rankLabelTF.y = 240;
            var chipsLabelTF:* = new HtmlTextBox("Arial Bold", AsDollars.giveMe(userData.points), 11, 0);
            chipsLabelTF.x = 14;
            chipsLabelTF.y = 281;
            var buddiesLabelTF:* = new HtmlTextBox("Arial Bold", userData.buddies, 11, 0);
            buddiesLabelTF.x = 13;
            buddiesLabelTF.y = 322;
            var sinceLabelTF:* = new HtmlTextBox("Arial Bold", userData.install, 11, 0, "right");
            sinceLabelTF.x = 404;
            sinceLabelTF.y = 65;
            var networkLabelTF:* = new HtmlTextBox("Arial Bold", userData.network ? (userData.network) : ("None"), 11, 0, "right");
            networkLabelTF.x = 404;
            networkLabelTF.y = 87;
            var biggestLabelTF:* = new HtmlTextBox("Arial Bold", AsDollars.giveMe(userData.stats.biggest_pot), 11, 0, "right");
            biggestLabelTF.x = 404;
            biggestLabelTF.y = 110;
            var handsPlayedLabelTF:* = new HtmlTextBox("Arial Bold", userData.stats.hands_played, 11, 0, "right");
            handsPlayedLabelTF.x = 404;
            handsPlayedLabelTF.y = 157;
            var handsWonLabelTF:* = new HtmlTextBox("Arial Bold", userData.stats.hands_won, 11, 0, "right");
            handsWonLabelTF.x = 404;
            handsWonLabelTF.y = 180;
            var shootOutRoundsWonLabelTF:* = new HtmlTextBox("Arial Bold", userData.stats.shootouts_won_pct, 11, 0, "right");
            shootOutRoundsWonLabelTF.x = 404;
            shootOutRoundsWonLabelTF.y = 202;
            var sitNGoWonLabelTF:* = new HtmlTextBox("Arial Bold", userData.stats.sitngos_won_pct, 11, 0, "right");
            sitNGoWonLabelTF.x = 404;
            sitNGoWonLabelTF.y = 224;
            var levelLabelTF:* = new HtmlTextBox("Arial Bold", userData.xp, 11, 0);
            levelLabelTF.x = 15;
            levelLabelTF.y = 182;
            this.playerName = this.userData.name;
            var colors:Object;
            var cardGlyphs:Object;
            var availableTypes:Array;
            var bestHand:* = new Array();
            var _loc_3:int = 0;
            var _loc_4:* = this.userData.stats.best_hand[1];
			while (_loc_3 in _loc_4)
            {
                
                str = _loc_4[_loc_3];
                var _loc_5:int = 0;
                var _loc_6:* = availableTypes;
                while (_loc_6 in _loc_5)
                {
                    
                    type = _loc_6[_loc_5];
                    if (str.indexOf(type) > -1)
                    {
                        color = colors[type];
                    }
                    str = str.split(type).join(cardGlyphs[type]);
                }
                str = "<font color=\"" + color + "\">" + str + "</font>";
                bestHand.push(str);
            }
            bestHandTF = new HtmlTextBox("Arial Bold", userData.stats.best_hand[0] + " " + bestHand.join(" "), 11, 0, "right");
            bestHandTF.x = 404;
            bestHandTF.y = 133;
            _profileView.addChild(rankLabelTF);
            _profileView.addChild(chipsLabelTF);
            _profileView.addChild(buddiesLabelTF);
            _profileView.addChild(sinceLabelTF);
            _profileView.addChild(networkLabelTF);
            _profileView.addChild(biggestLabelTF);
            _profileView.addChild(handsPlayedLabelTF);
            _profileView.addChild(handsWonLabelTF);
            _profileView.addChild(shootOutRoundsWonLabelTF);
            _profileView.addChild(sitNGoWonLabelTF);
            _profileView.addChild(levelLabelTF);
            _profileView.addChild(bestHandTF);
            loaderContext = new LoaderContext();
            loaderContext.checkPolicyFile = true;
            recenteAchievements = this.userData.stats.recent_achieves;
            i;
            _loc_3 = 0;
            _loc_4 = recenteAchievements;
           while (_loc_4 in _loc_3)
            {
                
                data = _loc_4[_loc_3];
                if (i == 3)
                {
                    break;
                }
                achievementImage = new Loader();
                req = new URLRequest(data.profile_url);
                achievementImage.visible = false;
                achievementImage.contentLoaderInfo.addEventListener(Event.COMPLETE, this._achievementImageOnComplete);
                achievementImage.load(req, loaderContext);
                i = (i + 1);
            }
            this._profileView.noAchievementsText.visible = i == 0 ? (true) : (false);
            this._tProfileGiftsLoaders = new Array();
            var recentGifts:* = this.userData.stats.recent_gifts;
            i;
            _loc_3 = 0;
            _loc_4 = recentGifts;
            while (_loc_4 in _loc_3)
            {
                
                data = _loc_4[_loc_3];
                if (i == 3)
                {
                    break;
                }
                giftImage = new Loader();
                req = new URLRequest(data.pic_large_url);
                giftImage.visible = false;
                giftImage.contentLoaderInfo.addEventListener(Event.COMPLETE, this._giftImageOnCompleteHandler);
                giftImage.load(req, loaderContext);
                i = (i + 1);
                this._tProfileGiftsLoaders.push(giftImage);
            }
            this._profileView.noGiftsText.visible = i == 0 ? (true) : (false);
            var image:* = new SafeImageLoader();
            image.visible = false;
            image.contentLoaderInfo.addEventListener(Event.COMPLETE, this._profileImageCompleteHandler);
            image.load(new URLRequest(this.userData.profile_pic), loaderContext);
            this.buttonViewAll = new PokerButton(null, "medium", langs.l_viewall, null, 70, 10);
            this.buttonViewAll.x = 520;
            this.buttonViewAll.y = 121;
            this.buttonViewAll.addEventListener(MouseEvent.CLICK, this._viewAllButtonClickHandler);
            this._profileView.addChild(this.buttonViewAll);
            if (this.isFriend)
            {
                this.buttonSendGift = new PokerButton(null, "medium", langs.l_sendgift, null, 70, 8);
                this.buttonSendGift.x = 432;
                this.buttonSendGift.y = 250;
                this.buttonSendGift.addEventListener(MouseEvent.CLICK, this._sendGiftsClickHandler);
                this._profileView.addChild(this.buttonSendGift);
                this.buttonSendChips = new PokerButton(null, "medium", langs.l_sendchip, null, 70, 4);
                this.buttonSendChips.x = 520;
                this.buttonSendChips.y = 250;
                this.buttonSendChips.addEventListener(MouseEvent.CLICK, this._sendChipsClickHandler);
                this._profileView.addChild(this.buttonSendChips);
            }
            this._setDisplayedTabView(this._profileView);
            return;
			
        }// end function
		
		private function _paginatedButtonMouseRollOutHandler(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as MovieClip;
            if (_loc_2.buttonMode && _loc_2.currentFrame != 1)
            {
                _loc_2.gotoAndStop(1);
            }
            return;
        }// end function

        private function _releaseGiftFromMemoryPool(param1:MovieClip) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this._tempGifts.length)
            {
                
                if (this._tempGifts[_loc_2] == param1)
                {
                    this._tempGifts.splice(_loc_2, 1);
                    GiftLibrary.GetInst().ReleaseGiftMovieClip(param1);
                    return;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function displayOverviewTab() : void
        {
            this._highlightTab(ProfilePanelTab.OVERVIEW);
            this._displayLoadingView();
            this._profileAchievementDisplayIndex = 0;
            this._profileGiftDisplayIndex = 0;
            var _loc_1:* = this.rootURL + "inc/ajax/profile_popup.php?zid=" + this.zid + fbSig;
            var _loc_2:* = new URLRequest(_loc_1);
            var _loc_3:* = new URLLoader();
            _loc_3.addEventListener(Event.COMPLETE, this._profileLoadedHandler);
            _loc_3.addEventListener(IOErrorEvent.IO_ERROR, this._profileErrorHandler);
            _loc_3.load(_loc_2);
            this.dispatchEvent(new ProfileEvent(ProfileEvent.DISPLAY_TAB, {tab:ProfilePanelTab.OVERVIEW}));
            return;
        }// end function
		
		public function displayCollectionsTab() : void
        {
            var _loc_1:String = null;
            var _loc_2:ExternalFontTextField = null;
            var _loc_3:MovieClip = null;
            this._highlightTab(ProfilePanelTab.COLLECTIONS);
            if ((isOwnProfile || isFriend) && !isNonFacebook)
            {
                this._displayLoadingView();
                this.dispatchEvent(new ProfileEvent(ProfileEvent.DISPLAY_TAB, {tab:ProfilePanelTab.COLLECTIONS}));
            }
            else
            {
                _loc_1 = "You can only see/trade collectibles with Facebook friends.\n" + playerName + " is not your Facebook friend.";
                _loc_2 = new ExternalFontTextField(_loc_1, "Main", 18, 0, "center");
                _loc_2.width = 610;
                _loc_2.height = 60;
                _loc_2.x = 0;
                _loc_2.y = 230;
                _loc_2.selectable = false;
                _loc_3 = new MovieClip();
                _loc_3.addChild(_loc_2);
                this._setDisplayedTabView(_loc_3);
            }
            return;
        }// end function

        private function _achievementTabClickHandler(event:MouseEvent) : void
        {
            this._selectAchievementTab(event.currentTarget.trophyType);
            return;
        }// end function

        public function showAchievementTab(param1:int) : void
        {
            var data:Object;
            var image:Loader;
            var achievementImageURL:String;
            var cell:MovieClip;
            var tab:* = param1;
            do
            {
                
                try
                {
                    this._achievementsScrollPaneContent.removeChildAt(0);
                }
                catch (e:Error)
                {
                }
            }while (this._achievementsScrollPaneContent.numChildren > 0)
            var i:int;
            var columns:int;
            if (tab < 4)
            {
                (this._achievements[tab] as Array).sortOn(["locked", "unlock_level"]);
            }
            var _loc_3:int = 0;
            var _loc_4:* = this._achievements[tab];
            while (_loc_4 in _loc_3)
            {
                
                data = _loc_4[_loc_3];
                image = new Loader();
                image.x = 5;
                image.y = 0;
                if (data.unlock_level > 1 && data.locked == 1)
                {
                    achievementImageURL = this.rootURL + "img/level" + data.unlock_level + "_locked.png";
                }
                else
                {
                    achievementImageURL = data.profile_url;
                    if (data.earned != "1")
                    {
                        image.alpha = 0.25;
                    }
                }
                image.load(new URLRequest(achievementImageURL));
                cell = new AchievementCell();
                cell.addChild(image);
                cell.x = i % columns * 100 + i % columns * 12;
                cell.y = Math.floor(i / columns) * 150 + 10;
                cell.label.text = data.name;
                cell.description = data.player_text;
                cell.addEventListener(MouseEvent.MOUSE_OVER, handleAchievementToolTip);
                cell.addEventListener(MouseEvent.MOUSE_OUT, handleAchievementToolTip);
                this._achievementsScrollPaneContent.addChild(cell);
                i = (i + 1);
            }
            this._achievementsView.comingSoonText.visible = tab == 4 ? (true) : (false);
            return;
        }// end function
		
		private function _displayItemsInTab(param1:int) : void
        {
            var item:Object;
            var totalRows:int;
            var totalPages:int;
            var giftData:GiftItem;
            var itemClip:ProfilePanelGiftItem;
            var noImage:MovieClip;
            var giftImage:MovieClip;
            var page:* = param1;
			//var page:* = 1;
            do
            {
               
                try
                {
                    this._itemsView.itemsArea.removeChildAt(0);
                }
                catch (e:Error)
                {
                }
            }while (this._itemsView.itemsArea.numChildren > 0)
            var displayedItems:* = new Array();
            this._itemsCurrentPage = page;
            var startIndex:* = (page - 1) * (this._itemsPerRow * this._itemsRowsPerPage);
            var endIndex:* = startIndex + this._itemsPerRow * this._itemsRowsPerPage;
            var i:* = startIndex;
			while (i < endIndex)
            {
                
                if (i < this._userItems.length)
                {
					displayedItems.push(this._userItems[i]);
                }
                else
                {
                    break;
                }
                i = (i + 1);
            }
            var itemWidth:Number = 65;
            var itemHeight:Number = 106;
            i = 0;
            this._displayedUserItems = displayedItems;
            var _loc_3:int = 0;
            var _loc_4:* = this._displayedUserItems;
			/*while (_loc_3 in _loc_4)
            {
				 
				
			}*/
			
            for (_loc_3 = 0; _loc_3<_loc_4.length; _loc_3++)
            {
				item = _loc_4[_loc_3];
				giftData = GiftLibrary.GetInst().GetGift(String(item.giftId));
                itemClip = new ProfilePanelGiftItem();
				  /*if (item.giftId == -1) {
					  itemClip.x = 40;
                    itemClip.y = 65;
				  }
				  else {*/
                itemClip.x = i % this._itemsPerRow * itemWidth + i % this._itemsPerRow * 8 + 40;				
                itemClip.y = Math.floor(i / this._itemsPerRow) * (itemHeight + 15) + 65;
				 /* }*/
				itemClip.addEventListener(MouseEvent.ROLL_OVER, this._itemRollOverHandler);
                itemClip.addEventListener(MouseEvent.ROLL_OUT, this._itemRollOutHandler);
                itemClip.addEventListener(MouseEvent.CLICK, this._itemClickHandler);
                if (item.giftId == -1)
                {
					    itemClip.initDisplay(false, false, false);
                    itemClip.info.htmlText = "<b>Display<br />None</b>";
                    itemClip.info.y = itemClip.info.y - 45;
                    noImage = new DisplayNoneItem();
                    noImage.x = -20;
                    noImage.y = -10;
					
					itemClip.addChild(noImage);
                    itemClip.giftID = -1;
                }
                else
                {
					giftImage = GiftLibrary.GetInst().CreateGiftMovieClip(0, String(giftData.mnId));
                    this._addGiftToMemoryPool(giftImage);
                    itemClip.pic.addChild(giftImage);
					//itemClip.initDisplay(giftData.isPremium, false, giftData.isPermanent);
				    itemClip.initDisplay(false, false, false);
                    itemClip.giftID = giftData.mnId;
					itemClip.info.htmlText = "<b>" + giftData.msName + "<br /><font color=\"#10AB05\">" + item.name + "</font></b>";
                	
				}
                this._itemsView.itemsArea.addChild(itemClip);
                i = (i + 1);
            }
            totalRows = Math.floor((this._displayedUserItems.length - 1) / this._itemsPerRow);
            totalPages = Math.ceil(this._userItems.length / (this._itemsPerRow * this._itemsRowsPerPage));
            totalPages = totalPages == 0 ? (1) : (totalPages);
            if (this._itemsCurrentPage == 1)
            {
                this._setPaginatedButtonState(this._itemsView.buttonLeft, false);
            }
            else
            {
                this._setPaginatedButtonState(this._itemsView.buttonLeft, true);
            }
            if (this._itemsCurrentPage == totalPages)
            {
                this._setPaginatedButtonState(this._itemsView.buttonRight, false);
            }
            else
            {
                this._setPaginatedButtonState(this._itemsView.buttonRight, true);
            }
            var image:* = new SafeImageLoader();
            image.contentLoaderInfo.addEventListener(Event.COMPLETE, this._itemsImageCompleteHandler);
            var loaderContext:* = new LoaderContext();
            loaderContext.checkPolicyFile = true;
            image.load(new URLRequest(this.pic), loaderContext);
            this._itemsView.paginationLabel.text = this._itemsCurrentPage + " of " + totalPages;
            this._redrawPaginatedItemsButtons(totalPages, this._itemsCurrentPage);
            return;
        }// end function

        private function _hideLoadingView() : void
        {
            this._loadingView.visible = false;
            return;
        }// end function
		
		private function _sendChipsClickHandler(event:MouseEvent) : void
        {
            this.dispatchEvent(new ProfileEvent(ProfileEvent.SEND_CHIPS_CLICK));
            return;
        }// end function

        private function _viewAllButtonClickHandler(event:MouseEvent) : void
        {
            this.displayAchievementsTab();
            return;
        }// end function

        private function _makeDrop(param1:Boolean = false) : DropShadowFilter
        {
            var _loc_2:Number = 0;
            var _loc_3:Number = 90;
            var _loc_4:Number = 0.5;
            var _loc_5:Number = 6;
            var _loc_6:Number = 6;
            var _loc_7:Number = 1;
            var _loc_8:Number = 1;
            param1 = param1;
            var _loc_9:Boolean = false;
            var _loc_10:* = BitmapFilterQuality.HIGH;
            return new DropShadowFilter(_loc_7, _loc_3, _loc_2, _loc_4, _loc_5, _loc_6, _loc_8, _loc_10, param1, _loc_9);
        }// end function

        private function handleAchievementToolTip(event:MouseEvent) : void
        {
            var toolTipPosition:Point;
            var boundingRect:Rectangle;
            var evt:* = event;
            var displayString:* = evt.currentTarget.description;
            if (evt.type == MouseEvent.MOUSE_OVER)
            {
                toolTipPosition = new Point(_achievementsView.x + _achievementsView.achievementsScrollPane.x + evt.currentTarget.x, _achievementsView.y + _achievementsView.achievementsScrollPane.y + evt.currentTarget.y * 1.2 - _achievementsView.achievementsScrollPane.verticalScrollPosition);
                achievementToolTip = new Tooltip(displayString.length < 100 ? (220) : (320), displayString, evt.currentTarget.label.text, null);
                achievementToolTip.name = "achievementToolTip";
                boundingRect = new Rectangle(_achievementsView.achievementsScrollPane.x, _achievementsView.achievementsScrollPane.y + 80, _achievementsView.achievementsScrollPane.width, _achievementsView.achievementsScrollPane.height);
                if (toolTipPosition.x < 40)
                {
                    toolTipPosition.x = 40;
                }
                else if (toolTipPosition.x + achievementToolTip.width > boundingRect.width)
                {
                    toolTipPosition.x = boundingRect.width - achievementToolTip.width;
                }
                if (toolTipPosition.y < _achievementsView.y + 60)
                {
                    toolTipPosition.y = _achievementsView.y + 60;
                }
                else if (toolTipPosition.y + achievementToolTip.height > boundingRect.y + boundingRect.height)
                {
                    toolTipPosition.y = boundingRect.y + boundingRect.height - achievementToolTip.height;
                }
                achievementToolTip.x = toolTipPosition.x;
                achievementToolTip.y = toolTipPosition.y;
                addChild(achievementToolTip);
            }
            else if (evt.type == MouseEvent.MOUSE_OUT)
            {
                try
                {
                    if (getChildByName("achievementToolTip"))
                    {
                        removeChild(achievementToolTip);
                    }
                    achievementToolTip = null;
                }
                catch (e:Error)
                {
                }
                _achievementsView.achievementsScrollPane.validateNow();
            }
            return;
        }// end function

        private function _itemsImageCompleteHandler(event:Event) : void
        {
            var _loc_2:* = event.currentTarget.content as DisplayObject;
            _loc_2.width = 100;
            _loc_2.scaleY = _loc_2.scaleX;
            if (_loc_2.height > 125)
            {
                _loc_2.height = 125;
                _loc_2.scaleX = _loc_2.scaleY;
            }
            _loc_2.x = 470;
            _loc_2.y = 30;
            _loc_2.filters = new Array(this._makeDrop());
            this._itemsView.addChildAt(_loc_2, this._itemsView.getChildIndex(this._itemsView.emptyChickletButton));
            this._itemsUserImage = _loc_2;
            this._displayGiftOnItemsChicklet(this.shownGiftID);
            return;
        }// end function

        public function displayTabFromIndex(param1:int) : void
        {
			switch(param1)
            {
                case ProfilePanelTab.OVERVIEW:
                {
                    this.displayOverviewTab();
                    break;
                }
                case ProfilePanelTab.ITEMS:
                {
                    this.displayItemsTab();
                    break;
                }
                case ProfilePanelTab.ACHIEVEMENTS:
                {
                    this.displayAchievementsTab();
                    break;
                }
                case ProfilePanelTab.COLLECTIONS:
                {
                    this.displayCollectionsTab();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function
		
		private function _addAchievementToProfile(param1:DisplayObject) : void
        {
            var _loc_2:int = 50;
            param1.width = 50;
            param1.height = _loc_2;
            param1.x = this._profileAchievementDisplayIndex * 50 + 432 + this._profileAchievementDisplayIndex * 5;
            param1.y = 60;
            this._profileView.addChild(param1);
            _loc_2 = this;
            var _loc_3:* = this._profileAchievementDisplayIndex + 1;
            this._profileAchievementDisplayIndex = _loc_3;
            return;
        }// end function
		
		private function _achievementImageOnComplete(event:Event) : void
        {
            var _loc_2:* = event.currentTarget.content as DisplayObject;
            this._addAchievementToProfile(_loc_2);
            return;
        }// end function

        private function _setDisplayedTabView(param1:MovieClip) : void
        {
            if (this._displayedView)
            {
                this._displayedView.visible = false;
            }
			this.contentArea.addChild(param1);
            this._displayedView = param1;
            param1.visible = true;
            this.contentArea.setChildIndex(param1, (this.contentArea.numChildren - 1));
            if (param1 != this._itemsView)
            {
                this._releaseGiftMemoryPool();
            }
            return;
        }// end function

        private function _displayLoadingView() : void
        {
            if (!this._loadingView)
            {
                this._loadingView = new LoadingView();
                this._loadingView.x = 5;
                this._loadingView.y = 85;
                this.contentArea.addChild(this._loadingView);
            }
            this._setDisplayedTabView(this._loadingView);
            return;
        }// end function

        private function _profileImageCompleteHandler(event:Event) : void
        {
            var _loc_2:* = event.currentTarget.content as DisplayObject;
            this._resizeProfileImage(_loc_2);
            _loc_2.filters = new Array(this._makeDrop());
            var _loc_3:* = new MovieClip();
            _loc_3.x = 13;
            _loc_3.y = 30;
            _loc_3.buttonMode = true;
            _loc_3.addEventListener(MouseEvent.CLICK, this._profileImageMouseClickHandler);
            _loc_3.addChild(_loc_2);
            this._profileView.addChild(_loc_3);
            return;
        }// end function

        private function _itemsChickletGiftClickHandler(event:MouseEvent) : void
        {
            this.dispatchEvent(new ProfileEvent(ProfileEvent.CASINO_SHOP_CLICK));
            return;
        }// end function

        private function _paginatedButtonLeftClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as MovieClip;
            if (_loc_2.buttonMode)
            {
                this._displayItemsInTab((this._itemsCurrentPage - 1));
            }
            return;
        }// end function

        private function _tabClickHandler(event:MouseEvent) : void
        {
            if (this._displayedView != this._loadingView && this._selectedTabIndex != event.currentTarget.tabIndex)
            {
                this.displayTabFromIndex(event.currentTarget.tabIndex);
            }
            return;
        }// end function

        public function initialize(param1:Array = null) : void
        {
            var _loc_2:Object = null;
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_6:MovieClip = null;
            if (!this._hasInitializedOnce)
            {
                this._hasInitializedOnce = true;
                //_loc_4 = ["Overview", "Items", "Achievements", "Collections"];
				_loc_4 = ["Items"];
                _loc_5 = 0;
                while (_loc_5 < _loc_4.length)
                {
                    
                    _loc_2 = new Object();
                    _loc_2.tab = new Tab();
                    _loc_2.tab.tabIndex = _loc_5;
                    _loc_2.tab.label.text = _loc_4[_loc_5];
                    _loc_2.tab.buttonMode = true;
                    _loc_2.tab.mouseChildren = false;
                    (_loc_2.tab as MovieClip).addEventListener(MouseEvent.CLICK, this._tabClickHandler);
                    this._tabs.push(_loc_2);
                    _loc_5++;
                }
            }
            for each (_loc_2 in this._tabs)
            {
                
                if (_loc_2.tab.parent)
                {
                    _loc_2.tab.parent.removeChild(_loc_2.tab);
                }
            }
            if (param1 == null)
            {
                param1 = [];
            }
            var _loc_3:int = 0;
            for each (_loc_2 in this._tabs)
            {
                
                if (param1.indexOf(_loc_2.tab.tabIndex) == -1)
                {
                    _loc_6 = MovieClip(_loc_2.tab);
                    _loc_6.x = (_loc_2.tab.width - 9) * _loc_3 + 40;
                    _loc_6.y = 55;
                    this.contentArea.addChild(_loc_6);
                    _loc_3++;
                }
            }
            return;
        }// end function

        private function _paginatedButtonRightClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as MovieClip;
			if (_loc_2.buttonMode)
            {
				this._displayItemsInTab((this._itemsCurrentPage + 1));
            }
            return;
        }// end function

        private function _redrawPaginatedItemsButtons(param1:int, param2:int) : void
        {
            var _loc_3:int = 1;
            while (_loc_3 <= param1)
            {
                
                _loc_3++;
            }
            return;
        }// end function

        private function _resizeProfileImage(param1:DisplayObject, param2:Boolean = false) : void
        {
            if (param2)
            {
                param1.scaleX = 1;
                param1.scaleY = 1;
            }
            else
            {
                param1.width = 100;
                param1.scaleY = param1.scaleX;
                if (param1.height > 125)
                {
                    param1.height = 125;
                    param1.scaleX = param1.scaleY;
                }
            }
            return;
        }// end function
		
		public function displayItemsTab() : void
        {
            this._displayedItemChickletGift = null;
            this.dispatchEvent(new ProfileEvent(ProfileEvent.DISPLAY_TAB, {tab:ProfilePanelTab.ITEMS}));
            this._highlightTab(ProfilePanelTab.ITEMS);
            this._displayLoadingView();
            return;
        }// end function

        private function _profileErrorHandler(event:IOErrorEvent) : void
        {
            return;
        }// end function

        private function _setPaginatedButtonState(param1:MovieClip, param2:Boolean) : void
        {
            if (param2)
            {
                param1.gotoAndStop(1);
                param1.buttonMode = true;
            }
            else
            {
                param1.gotoAndStop(3);
                param1.buttonMode = false;
            }
            return;
        }// end function

        public function displayAchievementsTab() : void
        {
            this._highlightTab(ProfilePanelTab.ACHIEVEMENTS);
            this._displayLoadingView();
            var _loc_1:* = this.rootURL + "inc/ajax/ach_popup.php?zid=" + this.zid;
            var _loc_2:* = new URLRequest(_loc_1);
            var _loc_3:* = new URLLoader();
            _loc_3.addEventListener(Event.COMPLETE, this._achievementLoadedHandler);
            _loc_3.addEventListener(IOErrorEvent.IO_ERROR, this._achievementErrorHandler);
            _loc_3.load(_loc_2);
            this.dispatchEvent(new ProfileEvent(ProfileEvent.DISPLAY_TAB, {tab:ProfilePanelTab.ACHIEVEMENTS}));
            return;
        }// end function

        private function _achievementErrorHandler(event:Event) : void
        {
            return;
        }// end function

        private function _itemClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as ProfilePanelGiftItem;
            _loc_2.over();
            if (this._selectedItem)
            {
                if (this._selectedItem != _loc_2)
                {
                    this._selectedItem.out();
                }
            }
            this._selectedItem = _loc_2;
            this._displayGiftOnItemsChicklet((this._selectedItem as MovieClip).giftID);
            return;
        }// end function

        public function showItems(param1:Array) : void
        {
			var _loc_2:Object = null;
            var _loc_5:GiftItem = null;
            this._userItems = new Array();
            for each (_loc_2 in param1)
            {
                _loc_5 = GiftLibrary.GetInst().GetGift(String(_loc_2.giftId));
				if (_loc_5)
                {
                    this._userItems.push(_loc_2);
                }
            }
            if (this._userItems.length > 0)
            {
                this._userItems.unshift({giftId:-1});
            }
			this._itemsView = new ItemsView();
            this._itemsView.x = 5;
            this._itemsView.y = 85;
            this._itemsView.buttonLeft.addEventListener(MouseEvent.ROLL_OVER, this._paginatedButtonMouseRollOverHandler);
            this._itemsView.buttonLeft.addEventListener(MouseEvent.ROLL_OUT, this._paginatedButtonMouseRollOutHandler);
            this._itemsView.buttonLeft.addEventListener(MouseEvent.CLICK, this._paginatedButtonLeftClickHandler);
            this._itemsView.buttonRight.addEventListener(MouseEvent.ROLL_OVER, this._paginatedButtonMouseRollOverHandler);
            this._itemsView.buttonRight.addEventListener(MouseEvent.ROLL_OUT, this._paginatedButtonMouseRollOutHandler);
            this._itemsView.buttonRight.addEventListener(MouseEvent.CLICK, this._paginatedButtonRightClickHandler);
            this._setPaginatedButtonState(this._itemsView.buttonLeft, true);
            this._setPaginatedButtonState(this._itemsView.buttonRight, true);
            this._itemsView.casinoShopText.casinoShopLink.buttonMode = true;
            this._itemsView.casinoShopText.addEventListener(MouseEvent.CLICK, this._casinoShopClickHandler);
            this._itemsView.casinoShopText.txt1.text = langs.l_goto;
			this._itemsView.casinoShopText.txt2.text = langs.l_buymoregift;
			this._itemsView.casinoShopText.casinoShopLink.txt.text = langs.l_buygift;
			var _loc_3:* = new PokerButton(myriadTF, "large", langs.l_savechange, null, 134, 18, 38, 7);
			//var _loc_3:* = new com.script.poker.table.asset.PokerButton("main", "large", "Save Changes", null, 134, 18, 38, 7);
            _loc_3.x = 450;
            _loc_3.y = 256;
			_loc_3.addEventListener(MouseEvent.CLICK, this._saveChangesButtonHandler);
            this._itemsView.addChild(_loc_3);
            //var _loc_4:* = new PokerButton(null, "large", "Cancel", null, 134, 40, 38, 7);
			var _loc_4:* = new PokerButton(myriadTF, "large", langs.l_cancel, null, 134, 40, 38, 7);	
            _loc_4.x = 450;
            _loc_4.y = 300;
            _loc_4.addEventListener(MouseEvent.CLICK, this._cancelChangesButtonHandler);
            this._itemsView.addChild(_loc_4);
            this._itemsView.emptyChickletButton.buttonMode = true;
            this._itemsView.emptyChickletButton.mouseChildren = true;
            (this._itemsView.emptyChickletButton as MovieClip).addEventListener(MouseEvent.CLICK, this._itemsEmptyChickletClickHandler);
            //this._displayItemsInTab(ProfilePanelTab.ITEMS);
			this._displayItemsInTab(1);
			this._setDisplayedTabView(this._itemsView);
            return;
        }// end function
		
        private function _giftImageOnCompleteHandler(event:Event) : void
        {
            var _loc_2:* = event.currentTarget.content as DisplayObject;
            var _loc_4:int = 50;
            _loc_2.width = 50;
            _loc_2.height = _loc_4;
            var _loc_3:* = this._tProfileGiftsLoaders.indexOf(event.currentTarget.loader);
            _loc_2.x = _loc_3 * (_loc_2.width + 4) + RECENTGIFT_HORIZONTAL_PLACEMENT;
            _loc_2.y = 180;
            this._profileView.addChild(_loc_2);
            //_loc_4:String = this;
            var _loc_5:* = this._profileGiftDisplayIndex + 1;
            this._profileGiftDisplayIndex = _loc_5;
            return;
        }// end function
		
        private function _itemRollOverHandler(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as ProfilePanelGiftItem;
            _loc_2.rollin();
            return;
        }// end function

        public function incrementCollectionItemCount(param1:Number) : void
        {
            if (this._collectionsView != null)
            {
                this._collectionsView.incrementCollectionItemCount(param1);
            }
            return;
        }// end function

        public function setCollections(param1:Array, param2:Object, param3:Object = null) : void
        {
            if (!this._collectionsView)
            {
                this._collectionsView = new ProfileCollectionsView(firstTimeCollections);
                this._collectionsView.x = 5;
                this._collectionsView.y = 85;
            }
            this._collectionsView.setCollections(param1, param2, param3);
            if (this._selectedTabIndex == ProfilePanelTab.COLLECTIONS)
            {
                this._setDisplayedTabView(this._collectionsView);
            }
            return;
        }// end function

        private function _profileImageMouseClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as MovieClip;
            var _loc_3:* = _loc_2.getChildAt(0);
            var _loc_4:* = _loc_3.scaleX == 1 && _loc_3.scaleY == 1 ? (false) : (true);
            this._resizeProfileImage(_loc_3, _loc_4);
            return;
        }// end function

        private function _sendGiftsClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = this.userData.giftshop_url + "?uid=" + this.zid;
            navigateToURL(new URLRequest(_loc_2), "_blank");
            return;
        }// end function

        private function _selectAchievementTab(param1:int) : void
        {
            var _loc_2:MovieClip = null;
            var _loc_3:* = undefined;
            for each (_loc_2 in this._achievementTabs)
            {
                
                _loc_3 = new TextFormat();
                if (_loc_2.trophyType == param1)
                {
                    _loc_3.color = 16777215;
                    _loc_2.trophy.gotoAndStop((_loc_2.trophyType + 1));
                    _loc_2.gotoAndStop(1);
                }
                else
                {
                    _loc_3.color = 0;
                    _loc_2.trophy.gotoAndStop(1);
                    _loc_2.gotoAndStop(2);
                }
                _loc_2.label.setTextFormat(_loc_3);
            }
            this.showAchievementTab(param1);
            return;
        }// end function

        private function _casinoShopClickHandler(event:MouseEvent) : void
        {
            this.dispatchEvent(new ProfileEvent(ProfileEvent.CASINO_SHOP_CLICK));
            return;
        }// end function

        private function _addGiftToMemoryPool(param1:MovieClip) : void
        {
            this._tempGifts.push(param1);
            return;
        }// end function

        private function _paginatedButtonMouseRollOverHandler(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as MovieClip;
            if (_loc_2.buttonMode && _loc_2.currentFrame != 2)
            {
                _loc_2.gotoAndStop(2);
            }
            return;
        }// end function

        private function _cancelChangesButtonHandler(event:MouseEvent) : void
        {
            this.dispatchEvent(new ProfileEvent(ProfileEvent.ITEM_CANCELED));
            return;
        }// end function

        private function _releaseGiftMemoryPool() : void
        {
            var _loc_1:MovieClip = null;
            for each (_loc_1 in this._tempGifts)
            {
                
                GiftLibrary.GetInst().ReleaseGiftMovieClip(_loc_1);
            }
            this._tempGifts = null;
            this._tempGifts = new Array();
            return;
        }// end function

        private function _itemsEmptyChickletClickHandler(event:MouseEvent) : void
        {
            this.dispatchEvent(new ProfileEvent(ProfileEvent.CASINO_SHOP_CLICK));
            return;
        }// end function
        
		



    }
}
