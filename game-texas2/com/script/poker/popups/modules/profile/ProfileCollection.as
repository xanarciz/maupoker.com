package com.script.poker.popups.modules.profile
{
    import com.script.draw.tooltip.*;
    import com.script.format.*;
    import com.script.poker.popups.modules.events.*;
    import com.script.text.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;

    public class ProfileCollection extends MovieClip
    {
        private var tooltip:Tooltip;
        private var tooltipParent:DisplayObjectContainer;
        public var claimButton:MovieClip;
        public var unlockedAfterCollectionID:Number;
        public var id:Number;
        private var _locked:Boolean;
        public var lockMovieClip:MovieClip;
        private var labelTextField:ExternalFontTextField;
        private var items:Array;
        private var imageLoader:Loader;
        public var star:MovieClip;
        private var rewardTextField:ExternalFontTextField;
        private var _giftURL:String;
        private var lockTextField:ExternalFontTextField;
        private var _label:String;
        private var mysteryGiftTextField:ExternalFontTextField;

        public function ProfileCollection()
        {
            claimButton.addEventListener(MouseEvent.CLICK, onClaimButtonClick, false, 0, true);
            claimButton.addEventListener(MouseEvent.MOUSE_OVER, onClaimButtonMouseOver, false, 0, true);
            claimButton.addEventListener(MouseEvent.MOUSE_OUT, onClaimButtonMouseOut, false, 0, true);
            claimButton.buttonMode = true;
            claimButton.mouseChildren = false;
            lockMovieClip.visible = false;
            return;
        }// end function

        public function getItem(param1:Number) : ProfileCollectionItem
        {
            var _loc_3:ProfileCollectionItem = null;
            var _loc_2:ProfileCollectionItem = null;
            for each (_loc_3 in items)
            {
                
                if (_loc_3.id == param1)
                {
                    _loc_2 = _loc_3;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function setLocked(param1:Boolean, param2:String = "") : void
        {
            var _loc_3:ProfileCollectionItem = null;
            _locked = param1;
            if (_locked)
            {
                lockMovieClip.visible = true;
                if (lockTextField == null)
                {
                    lockTextField = new ExternalFontTextField(param2, "Main", 14, 3355443, "center");
                    lockTextField.width = 582;
                    lockTextField.height = 20;
                    lockTextField.x = 0;
                    lockTextField.y = 75;
                    lockTextField.selectable = false;
                    lockMovieClip.addChild(lockTextField);
                }
                else
                {
                    lockTextField.text = param2;
                }
                setChildIndex(lockMovieClip, (numChildren - 1));
            }
            else
            {
                lockMovieClip.visible = false;
            }
            for each (_loc_3 in items)
            {
                
                _loc_3.locked = _locked;
            }
            return;
        }// end function

        public function init(param1:Number, param2:String, param3:Object, param4:Array, param5:Number = 0)
        {
            var _loc_10:ProfileCollectionItem = null;
            this.id = param1;
            this.label = param2;
            this.items = param4;
            this.unlockedAfterCollectionID = !isNaN(param5) ? (param5) : (0);
            setReward(param3);
            var _loc_6:int = 0;
            var _loc_7:int = 140;
            var _loc_8:int = 6;
            var _loc_9:int = 82;
            for each (_loc_10 in param4)
            {
                
                addChild(_loc_10);
                _loc_10.x = _loc_7 + _loc_6 * _loc_9 + _loc_8 * _loc_6;
                _loc_10.y = 7;
                _loc_6++;
            }
            refresh();
            return;
        }// end function

        private function onClaimButtonClick(event:MouseEvent) : void
        {
            if (claimButton.currentLabel != "disabled")
            {
                dispatchEvent(new ProfileEvent(ProfileEvent.CLAIM_COLLECTION, {collectionId:id}));
            }
            return;
        }// end function

        public function get giftURL() : String
        {
            return _giftURL;
        }// end function

        public function setItemSharedFrom(param1:Number, param2:String, param3:String) : void
        {
            var _loc_4:* = getItem(param1);
            if (getItem(param1) != null)
            {
                _loc_4.setSharedFrom(param2, param3);
            }
            return;
        }// end function

        private function onClaimButtonMouseOver(event:MouseEvent) : void
        {
            if (claimButton.currentLabel != "disabled")
            {
                claimButton.gotoAndStop("rollover");
            }
            var _loc_2:Number = 210;
            var _loc_3:* = claimButton.x + claimButton.width / 2 - _loc_2 / 2;
            showTooltip("Exchange one complete set to claim reward.", _loc_2, _loc_3, 82);
            return;
        }// end function

        public function setReward(param1:Object) : void
        {
            var _loc_2:* = new Array();
            if (param1.hasOwnProperty("points") && Number(param1["points"]) > 0)
            {
                _loc_2.push(AsDollars.giveMe(param1["points"]));
            }
            if (param1.hasOwnProperty("xp") && Number(param1["xp"]) > 0)
            {
                _loc_2.push("+" + param1["xp"] + "XP");
            }
            var _loc_3:* = _loc_2.join("\n");
            if (rewardTextField == null)
            {
                rewardTextField = new ExternalFontTextField(_loc_3, "Main", 14, 0, "center");
                rewardTextField.width = 70;
                rewardTextField.height = 40;
                rewardTextField.x = star.x + Math.round(star.width / 2 - rewardTextField.width / 2);
                rewardTextField.y = star.y + Math.round(star.height / 2 - rewardTextField.height / 2) + 4;
                rewardTextField.multiline = true;
                rewardTextField.selectable = false;
                addChild(rewardTextField);
            }
            else
            {
                rewardTextField.text = _loc_3;
            }
            if (param1.hasOwnProperty("giftURL"))
            {
                giftURL = param1.hasOwnProperty("giftURL") && param1["giftURL"] != null ? (param1["giftURL"]) : (null);
            }
            return;
        }// end function

        private function onImageLoaderIOError(event:IOErrorEvent) : void
        {
            return;
        }// end function

        private function onClaimButtonMouseOut(event:MouseEvent) : void
        {
            if (claimButton.currentLabel != "disabled")
            {
                claimButton.gotoAndStop("default");
            }
            hideTooltip();
            return;
        }// end function

        public function set giftURL(param1:String) : void
        {
            var _loc_2:LoaderContext = null;
            _giftURL = param1;
            if (_giftURL)
            {
                _loc_2 = new LoaderContext(true);
                if (imageLoader == null)
                {
                    imageLoader = new Loader();
                    imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaderComplete, false, 0, true);
                    imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onImageLoaderIOError, false, 0, true);
                    imageLoader.x = 10;
                    imageLoader.y = 42;
                    addChild(imageLoader);
                    imageLoader.load(new URLRequest(_giftURL), _loc_2);
                }
                else
                {
                    imageLoader.load(new URLRequest(_giftURL), _loc_2);
                }
            }
            else if (imageLoader != null)
            {
                imageLoader.unload();
            }
            return;
        }// end function

        private function onImageLoaderComplete(event:Event) : void
        {
            imageLoader.content.width = 60;
            imageLoader.content.height = 60;
            refresh();
            return;
        }// end function

        private function showTooltip(param1:String, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc_5:Point = null;
            hideTooltip();
            if (stage != null)
            {
                tooltipParent = stage;
                tooltip = new Tooltip(param2, param1);
                _loc_5 = tooltipParent.globalToLocal(localToGlobal(new Point(param3, param4)));
                tooltip.x = _loc_5.x;
                tooltip.y = _loc_5.y;
                tooltipParent.addChild(tooltip);
            }
            return;
        }// end function

        private function refresh() : void
        {
            var _loc_2:ProfileCollectionItem = null;
            var _loc_1:Boolean = true;
            for each (_loc_2 in items)
            {
                
                if (_loc_2.count <= 0)
                {
                    _loc_1 = false;
                    break;
                }
            }
            if (_loc_1)
            {
                claimButton.buttonMode = true;
                claimButton.gotoAndStop("default");
                if (imageLoader != null)
                {
                    imageLoader.transform.colorTransform = new ColorTransform();
                }
                if (mysteryGiftTextField != null)
                {
                    mysteryGiftTextField.visible = false;
                }
            }
            else
            {
                claimButton.buttonMode = false;
                claimButton.gotoAndStop("disabled");
                if (imageLoader != null && imageLoader.content != null)
                {
                    imageLoader.transform.colorTransform = new ColorTransform(0.05, 0.05, 0.05, 1, 153, 153, 153, 0);
                    if (mysteryGiftTextField == null)
                    {
                        mysteryGiftTextField = new ExternalFontTextField("Mystery\nGift", "Main", 13, 0, "center");
                        mysteryGiftTextField.width = 70;
                        mysteryGiftTextField.height = 42;
                        mysteryGiftTextField.x = imageLoader.x + Math.round(imageLoader.content.width / 2 - mysteryGiftTextField.width / 2);
                        mysteryGiftTextField.y = imageLoader.y + Math.round(imageLoader.content.height / 2 - mysteryGiftTextField.height / 2) + 4;
                        mysteryGiftTextField.multiline = true;
                        mysteryGiftTextField.selectable = false;
                        mysteryGiftTextField.wordWrap = true;
                        addChild(mysteryGiftTextField);
                    }
                    else
                    {
                        mysteryGiftTextField.visible = true;
                    }
                }
            }
            if (lockMovieClip.visible)
            {
                setChildIndex(lockMovieClip, (numChildren - 1));
            }
            return;
        }// end function

        public function containsItem(param1:Number) : Boolean
        {
            var _loc_3:ProfileCollectionItem = null;
            var _loc_2:Boolean = false;
            for each (_loc_3 in items)
            {
                
                if (_loc_3.id == param1)
                {
                    _loc_2 = true;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function set label(param1:String) : void
        {
            _label = param1 == null ? ("") : (param1);
            if (labelTextField == null)
            {
                labelTextField = new ExternalFontTextField(_label, "Main", 14, 0);
                labelTextField.width = 400;
                labelTextField.height = 20;
                labelTextField.x = 10;
                labelTextField.y = 4;
                labelTextField.selectable = false;
                addChild(labelTextField);
            }
            else
            {
                labelTextField.text = _label;
            }
            return;
        }// end function

        private function hideTooltip() : void
        {
            if (tooltip != null && tooltipParent != null && tooltipParent.contains(tooltip))
            {
                tooltip.visible = false;
                tooltipParent.removeChild(tooltip);
                tooltip = null;
            }
            return;
        }// end function

        public function get label() : String
        {
            return _label;
        }// end function

        public function setItemCount(param1:Number, param2:int, param3:Boolean = false) : void
        {
            var _loc_4:* = getItem(param1);
            if (getItem(param1) != null)
            {
                _loc_4.count = param2;
                _loc_4.found = param3;
            }
            refresh();
            return;
        }// end function

    }
}
