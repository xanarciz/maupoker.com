package com.script.poker.popups.modules.profile
{
    import com.script.draw.tooltip.*;
    import com.script.poker.popups.modules.events.*;
    import com.script.text.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;

    public class ProfileCollectionItem extends MovieClip
    {
        private var _sharedFromName:String;
        private var _found:Boolean;
        private var tooltip:Tooltip;
        private var _count:int;
        public var id:Number;
        private var tooltipParent:DisplayObjectContainer;
        private var _locked:Boolean;
        public var background:MovieClip;
        private var _url:String;
        private var labelTextField:ExternalFontTextField;
        public var tradeButton:MovieClip;
        private var _sharedOnly:Boolean;
        private var imageLoader:Loader;
        public var wishlistButton:MovieClip;
        public var shader:MovieClip;
        public var imageContainer:MovieClip;
        private var _sharedFromZid:String;
        private var _label:String;
        private var glowAnimation:MovieClip;
        private var countTextField:ExternalFontTextField;

        public function ProfileCollectionItem()
        {
            imageContainer.mouseEnabled = true;
            imageContainer.mouseChildren = false;
            imageContainer.addEventListener(MouseEvent.MOUSE_OVER, onImageContainerMouseOver, false, 0, true);
            imageContainer.addEventListener(MouseEvent.MOUSE_OUT, onImageContainerMouseOut, false, 0, true);
            shader.mouseEnabled = false;
            wishlistButton.addEventListener(MouseEvent.CLICK, onWishlistButtonClick, false, 0, true);
            wishlistButton.addEventListener(MouseEvent.MOUSE_OVER, onWishlistButtonMouseOver, false, 0, true);
            wishlistButton.addEventListener(MouseEvent.MOUSE_OUT, onWishlistButtonMouseOut, false, 0, true);
            wishlistButton.buttonMode = true;
            wishlistButton.mouseChildren = false;
            tradeButton.addEventListener(MouseEvent.CLICK, onTradeButtonClick, false, 0, true);
            tradeButton.addEventListener(MouseEvent.MOUSE_OVER, onTradeButtonMouseOver, false, 0, true);
            tradeButton.addEventListener(MouseEvent.MOUSE_OUT, onTradeButtonMouseOut, false, 0, true);
            tradeButton.buttonMode = true;
            tradeButton.mouseChildren = false;
            return;
        }// end function

        public function get found() : Boolean
        {
            return _found;
        }// end function

        public function set found(param1:Boolean) : void
        {
            _found = param1;
            refresh();
            return;
        }// end function

        private function onTradeButtonMouseOver(event:MouseEvent) : void
        {
            if (tradeButton.currentLabel != "disabled")
            {
                tradeButton.gotoAndStop("rollover");
            }
            var _loc_2:Number = 75;
            var _loc_3:* = background.width / 2 - _loc_2 / 2;
            showTooltip("Send to friend.", _loc_2, _loc_3, 70);
            return;
        }// end function

        public function get count() : int
        {
            return _count;
        }// end function

        public function get locked() : Boolean
        {
            return _locked;
        }// end function

        private function onWishlistButtonClick(event:MouseEvent) : void
        {
            if (wishlistButton.currentLabel != "disabled")
            {
                dispatchEvent(new ProfileEvent(ProfileEvent.WISHLIST_COLLECTION_ITEM, {itemId:id}));
            }
            return;
        }// end function

        public function set locked(param1:Boolean) : void
        {
            _locked = param1;
            refresh();
            return;
        }// end function

        public function init(param1:Number, param2:String, param3:String, param4:Boolean = false, param5:int = 0)
        {
            this.id = param1;
            this.label = param2;
            this.url = param3;
            this.sharedOnly = param4;
            this.count = param5;
            return;
        }// end function

        public function set count(param1:int) : void
        {
            _count = param1;
            if (countTextField == null)
            {
                countTextField = new ExternalFontTextField(String(_count), "MainSemi", 12, 0, "right");
                countTextField.width = 20;
                countTextField.height = 18;
                countTextField.x = imageContainer.width - countTextField.width;
                countTextField.y = imageContainer.height - countTextField.height;
                countTextField.selectable = false;
                imageContainer.addChild(countTextField);
            }
            else
            {
                countTextField.text = String(_count);
            }
            refresh();
            return;
        }// end function

        private function onWishlistButtonMouseOut(event:MouseEvent) : void
        {
            if (wishlistButton.currentLabel != "disabled")
            {
                wishlistButton.gotoAndStop("default");
            }
            hideTooltip();
            return;
        }// end function

        private function onWishlistButtonMouseOver(event:MouseEvent) : void
        {
            if (wishlistButton.currentLabel != "disabled")
            {
                wishlistButton.gotoAndStop("rollover");
            }
            var _loc_2:Number = 65;
            var _loc_3:* = background.width / 2 - _loc_2 / 2;
            showTooltip("Ask for item.", _loc_2, _loc_3, 70);
            return;
        }// end function

        public function get sharedOnly() : Boolean
        {
            return _sharedOnly;
        }// end function

        public function setSharedFrom(param1:String, param2:String) : void
        {
            _sharedFromZid = param1;
            _sharedFromName = param2 == null ? ("") : (param2);
            return;
        }// end function

        private function onImageLoaderIOError(event:IOErrorEvent) : void
        {
            return;
        }// end function

        private function onImageContainerMouseOut(event:MouseEvent) : void
        {
            hideTooltip();
            return;
        }// end function

        private function onImageLoaderComplete(event:Event) : void
        {
            imageLoader.x = Math.round(imageContainer.width / 2 - imageLoader.content.width / 2);
            imageLoader.y = Math.round(imageContainer.height / 2 - imageLoader.content.height / 2);
            imageContainer.addChild(imageLoader);
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
            if (_count > 0)
            {
                shader.visible = false;
                tradeButton.buttonMode = true;
                tradeButton.gotoAndStop("default");
            }
            else
            {
                shader.visible = locked ? (false) : (true);
                tradeButton.buttonMode = false;
                tradeButton.gotoAndStop("disabled");
            }
            if (locked)
            {
                wishlistButton.buttonMode = false;
                wishlistButton.gotoAndStop("disabled");
                if (imageLoader != null)
                {
                    imageLoader.transform.colorTransform = new ColorTransform(0.05, 0.05, 0.05, 1, 153, 153, 153, 0);
                }
            }
            else
            {
                wishlistButton.buttonMode = true;
                wishlistButton.gotoAndStop("default");
                if (imageLoader != null)
                {
                    imageLoader.transform.colorTransform = new ColorTransform();
                }
            }
            if (found && !locked)
            {
                if (glowAnimation == null)
                {
                    glowAnimation = new CollectionItemGlowYellow();
                    glowAnimation.x = imageContainer.x;
                    glowAnimation.y = imageContainer.y;
                    addChildAt(glowAnimation, getChildIndex(imageContainer));
                }
            }
            else if (glowAnimation != null && contains(glowAnimation))
            {
                glowAnimation.visible = false;
                removeChild(glowAnimation);
                glowAnimation = null;
            }
            if (sharedOnly)
            {
                background.gotoAndStop("sharedOnly");
            }
            else
            {
                background.gotoAndStop("default");
            }
            return;
        }// end function

        public function set url(param1:String) : void
        {
            var _loc_2:LoaderContext = null;
            _url = param1;
            if (_url)
            {
                _loc_2 = new LoaderContext(true);
                if (imageLoader == null)
                {
                    imageLoader = new Loader();
                    imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaderComplete, false, 0, true);
                    imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onImageLoaderIOError, false, 0, true);
                    imageLoader.load(new URLRequest(_url), _loc_2);
                }
                else
                {
                    imageLoader.load(new URLRequest(_url), _loc_2);
                }
            }
            else if (imageLoader != null)
            {
                imageLoader.unload();
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

        public function set sharedOnly(param1:Boolean) : void
        {
            _sharedOnly = param1;
            refresh();
            return;
        }// end function

        public function set label(param1:String) : void
        {
            _label = param1 == null ? ("") : (param1);
            if (labelTextField == null)
            {
                labelTextField = new ExternalFontTextField(_label, "MainSemi", 11, 16777215, "center");
                labelTextField.width = background.width;
                labelTextField.height = 16;
                labelTextField.x = 0;
                labelTextField.y = 72;
                labelTextField.selectable = false;
                addChild(labelTextField);
            }
            else
            {
                labelTextField.text = _label;
            }
            return;
        }// end function

        public function get url() : String
        {
            return _url;
        }// end function

        private function onTradeButtonClick(event:MouseEvent) : void
        {
            if (tradeButton.currentLabel != "disabled")
            {
                dispatchEvent(new ProfileEvent(ProfileEvent.TRADE_COLLECTION_ITEM, {itemId:id}));
            }
            return;
        }// end function

        public function get label() : String
        {
            return _label;
        }// end function

        private function onTradeButtonMouseOut(event:MouseEvent) : void
        {
            if (tradeButton.currentLabel != "disabled")
            {
                tradeButton.gotoAndStop("default");
            }
            hideTooltip();
            return;
        }// end function

        private function onImageContainerMouseOver(event:MouseEvent) : void
        {
            var _loc_3:Number = NaN;
            var _loc_2:String = "";
            if (found)
            {
                _loc_2 = _loc_2 + (_sharedFromName ? ("Recently received from " + _sharedFromName + ".") : ("Recently found."));
                _loc_2 = _loc_2 + "\n\n";
            }
            if (sharedOnly)
            {
                _loc_2 = _loc_2 + "Special - found in Facebook newsfeeds your friends share.";
                _loc_3 = 155;
            }
            else
            {
                _loc_2 = _loc_2 + "Found by winning hands.";
                _loc_3 = 120;
            }
            var _loc_4:* = background.width / 2 - _loc_3 / 2;
            showTooltip(_loc_2, _loc_3, _loc_4, 98);
            return;
        }// end function

    }
}
