package com.script.poker.popups.modules.profile
{
    import com.script.text.*;
    import flash.display.*;

    public class ProfileCollectionFriend extends MovieClip
    {
        private var items:Array;
        public var unlockedAfterCollectionID:Number;
        public var id:Number;
        private var lockTextField:ExternalFontTextField;
        private var _locked:Boolean;
        private var _label:String;
        private var labelTextField:ExternalFontTextField;
        public var lockMovieClip:MovieClip;

        public function ProfileCollectionFriend()
        {
            lockMovieClip.visible = false;
            return;
        }// end function

        public function setItemWishlist(param1:Number, param2:Boolean) : void
        {
            var _loc_3:* = getItem(param1);
            if (_loc_3 != null)
            {
                _loc_3.wishlist = param2;
            }
            return;
        }// end function

        public function getItem(param1:Number) : ProfileCollectionItemFriend
        {
            var _loc_3:ProfileCollectionItemFriend = null;
            var _loc_2:ProfileCollectionItemFriend = null;
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
            var _loc_3:ProfileCollectionItemFriend = null;
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

        public function init(param1:Number, param2:String, param3:Array, param4:Number = 0)
        {
            var _loc_9:ProfileCollectionItemFriend = null;
            this.id = param1;
            this.label = param2;
            this.items = param3;
            this.unlockedAfterCollectionID = !isNaN(param4) ? (param4) : (0);
            var _loc_5:int = 0;
            var _loc_6:int = 6;
            var _loc_7:int = 6;
            var _loc_8:int = 108;
            for each (_loc_9 in param3)
            {
                
                addChild(_loc_9);
                _loc_9.x = _loc_6 + _loc_5 * _loc_8 + _loc_7 * _loc_5;
                _loc_9.y = 7;
                _loc_5++;
            }
            refresh();
            return;
        }// end function

        public function setItemOwnCount(param1:Number, param2:int) : void
        {
            var _loc_3:* = getItem(param1);
            if (_loc_3 != null)
            {
                _loc_3.ownCount = param2;
            }
            return;
        }// end function

        public function containsItem(param1:Number) : Boolean
        {
            var _loc_3:ProfileCollectionItemFriend = null;
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

        public function get label() : String
        {
            return _label;
        }// end function

        public function setItemCount(param1:Number, param2:int) : void
        {
            var _loc_3:* = getItem(param1);
            if (_loc_3 != null)
            {
                _loc_3.count = param2;
            }
            return;
        }// end function

        private function refresh() : void
        {
            if (lockMovieClip.visible)
            {
                setChildIndex(lockMovieClip, (numChildren - 1));
            }
            return;
        }// end function

    }
}
