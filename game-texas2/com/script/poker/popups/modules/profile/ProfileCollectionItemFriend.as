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

    public class ProfileCollectionItemFriend extends MovieClip
    {
        private var tooltip:Tooltip;
        private var _ownCount:int;
        private var tooltipParent:DisplayObjectContainer;
        private var _count:int;
        public var id:Number;
        private var _wishlist:Boolean;
        private var _locked:Boolean;
        private var ownCountTextField:ExternalFontTextField;
        public var background:MovieClip;
        private var _url:String;
        public var tradeButton:MovieClip;
        private var labelTextField:ExternalFontTextField;
        private var imageLoader:Loader;
        private var _sharedOnly:Boolean;
        public var shader:MovieClip;
        public var imageContainer:MovieClip;
        private var _label:String;
        private var glowAnimation:MovieClip;
        private var countTextField:ExternalFontTextField;

        public function ProfileCollectionItemFriend()
        {
            imageContainer.mouseEnabled = true;
            imageContainer.mouseChildren = false;
            imageContainer.addEventListener(MouseEvent.MOUSE_OVER, onImageContainerMouseOver, false, 0, true);
            imageContainer.addEventListener(MouseEvent.MOUSE_OUT, onImageContainerMouseOut, false, 0, true);
            shader.mouseEnabled = false;
            tradeButton.addEventListener(MouseEvent.CLICK, onTradeButtonClick, false, 0, true);
            tradeButton.addEventListener(MouseEvent.MOUSE_OVER, onTradeButtonMouseOver, false, 0, true);
            tradeButton.addEventListener(MouseEvent.MOUSE_OUT, onTradeButtonMouseOut, false, 0, true);
            tradeButton.buttonMode = true;
            tradeButton.mouseChildren = false;
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

        public function get locked() : Boolean
        {
            return _locked;
        }// end function

        public function get count() : int
        {
            return _count;
        }// end function

        public function set wishlist(param1:Boolean) : void
        {
            _wishlist = param1;
            refresh();
            return;
        }// end function

        public function set locked(param1:Boolean) : void
        {
            _locked = param1;
            refresh();
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

        public function init(param1:Number, param2:String, param3:String, param4:Boolean = false, param5:int = 0, param6:int = 0)
        {
            this.id = param1;
            this.label = param2;
            this.url = param3;
            this.sharedOnly = param4;
            this.count = param5;
            this.ownCount = param6;
            return;
        }// end function

        public function get sharedOnly() : Boolean
        {
            return _sharedOnly;
        }// end function

        private function onImageContainerMouseOut(event:MouseEvent) : void
        {
            hideTooltip();
            return;
        }// end function

        public function get ownCount() : int
        {
            return _ownCount;
        }// end function

        private function onImageLoaderIOError(event:IOErrorEvent) : void
        {
            return;
        }// end function

        public function get wishlist() : Boolean
        {
            return _wishlist;
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

        private function onImageLoaderComplete(event:Event) : void
        {
            imageLoader.x = Math.round(imageContainer.width / 2 - imageLoader.content.width / 2);
            imageLoader.y = Math.round(imageContainer.height / 2 - imageLoader.content.height / 2);
            imageContainer.addChild(imageLoader);
            return;
        }// end function

        public function set ownCount(param1:int) : void
        {
            _ownCount = param1;
            var _loc_2:* = "You own: " + _ownCount;
            if (ownCountTextField == null)
            {
                ownCountTextField = new ExternalFontTextField(_loc_2, "MainSemi", 12, 16777215);
                ownCountTextField.width = 70;
                ownCountTextField.height = 18;
                ownCountTextField.x = 6;
                ownCountTextField.y = background.height - ownCountTextField.height - 6;
                ownCountTextField.selectable = false;
                addChild(ownCountTextField);
            }
            else
            {
                ownCountTextField.text = _loc_2;
            }
            refresh();
            return;
        }// end function

        private function refresh() : void
        {
            if (_count > 0)
            {
                shader.visible = false;
            }
            else
            {
                shader.visible = locked ? (false) : (true);
            }
            if (_ownCount > 0)
            {
                tradeButton.buttonMode = true;
                tradeButton.gotoAndStop("default");
            }
            else
            {
                tradeButton.buttonMode = false;
                tradeButton.gotoAndStop("disabled");
            }
            if (locked)
            {
                if (imageLoader != null)
                {
                    imageLoader.transform.colorTransform = new ColorTransform(0.05, 0.05, 0.05, 1, 153, 153, 153, 0);
                }
            }
            else if (imageLoader != null)
            {
                imageLoader.transform.colorTransform = new ColorTransform();
            }
            if (wishlist && !locked)
            {
                if (glowAnimation == null)
                {
                    glowAnimation = new CollectionItemGlowGreen();
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

        private function onTradeButtonMouseOut(event:MouseEvent) : void
        {
            if (tradeButton.currentLabel != "disabled")
            {
                tradeButton.gotoAndStop("default");
            }
            hideTooltip();
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
                dispatchEvent(new ProfileEvent(ProfileEvent.TRADE_COLLECTION_ITEM, {itemId:id, wishlist:wishlist}));
            }
            return;
        }// end function

        public function get label() : String
        {
            return _label;
        }// end function

        private function onImageContainerMouseOver(event:MouseEvent) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            if (wishlist)
            {
                _loc_2 = 150;
                _loc_3 = background.width / 2 - _loc_2 / 2;
                showTooltip("Collectible needed - your friend has recently asked for this item.", _loc_2, _loc_3, 98);
            }
            return;
        }// end function

    }
}
