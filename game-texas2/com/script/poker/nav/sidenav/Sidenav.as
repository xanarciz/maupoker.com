package com.script.poker.nav.sidenav
{
    import caurina.transitions.*;
    import com.script.draw.*;
    import com.script.poker.nav.sidenav.events.*;
    import com.script.text.*;
    import flash.display.*;
    import flash.events.*;

    public class Sidenav extends Sprite
    {
        public var siCont:Sprite;
        public var snCont:Sprite;
        public var navItems:Array;

        public function Sidenav() : void
        {
            navItems = [];
            snCont = new Sprite();
            siCont = new Sprite();
            addChild(snCont);
            snCont.addChild(siCont);
            return;
        }// end function

        public function getSideItem(param1:String) : SidenavItem
        {
            var _loc_2:int = 0;
            while (_loc_2 < navItems.length)
            {
                
                if (navItems[_loc_2].thisTitle == param1)
                {
                    return navItems[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

        public function setSidebarItemsDeselected(param1:String = "") : void
        {
            var _loc_2:String = null;
            if (param1 != "")
            {
                for (_loc_2 in navItems)
                {
                    
                    if (navItems[_loc_2].thisTitle.toLowerCase().split(" ").join("") == param1.toLowerCase().split(" ").join(""))
                    {
                        navItems[_loc_2].makeSelected(false);
                    }
                }
            }
            else
            {
                for (_loc_2 in navItems)
                {
                    
                    navItems[_loc_2].makeSelected(false);
                }
            }
            return;
        }// end function

        private function siOver(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as SidenavItem;
            _loc_2.rollOver();
            return;
        }// end function

        public function onClosePressed(param1:SidenavEvents) : void
        {
            var _loc_2:String = null;
            for (_loc_2 in navItems)
            {
                
                navItems[_loc_2].makeSelected(false);
            }
            return;
        }// end function

        private function snOver(event:MouseEvent) : void
        {
            var _loc_3:String = null;
            var _loc_4:SidenavItem = null;
            var _loc_2:Number = 0.15;
            Tweener.addTween(snCont, {scaleX:1, scaleY:1, time:_loc_2, transition:"easeOutSine"});
            for (_loc_3 in navItems)
            {
                
                _loc_4 = navItems[_loc_3] as SidenavItem;
                Tweener.removeTweens(_loc_4.icon, "scaleX", "scaleY", "y");
                Tweener.removeTweens(_loc_4.tf, "alpha");
                Tweener.addTween(_loc_4.icon, {scaleX:1, scaleY:1, y:_loc_4.storeIconY, time:_loc_2, transition:"easeOutSine"});
                Tweener.addTween(_loc_4.tf, {alpha:0.5, time:_loc_2, transition:"easeOutSine"});
            }
            return;
        }// end function

        public function getIsSidebarItemSelected(param1:String = "") : Boolean
        {
            var _loc_2:String = null;
            for (_loc_2 in navItems)
            {
                
                if (navItems[_loc_2].thisTitle.toLowerCase() == param1.toLowerCase() && navItems[_loc_2].isSelected)
                {
                    return true;
                }
            }
            return false;
        }// end function

        private function siClick(event:MouseEvent) : void
        {
            var _loc_3:String = null;
            var _loc_2:* = event.currentTarget as SidenavItem;
            for (_loc_3 in navItems)
            {
                
                if (_loc_2 == navItems[_loc_3])
                {
                    if (navItems[_loc_3].isSelected)
                    {
                        navItems[_loc_3].makeSelected(false);
                        SidenavEvents.quickThrow(SidenavEvents.CLOSE_PANEL, _loc_2.nid);
                    }
                    else
                    {
                        _loc_2.rollOver();
                        navItems[_loc_3].makeSelected(true);
                        SidenavEvents.quickThrow(SidenavEvents.REQUEST_PANEL, _loc_2.nid);
                    }
                    continue;
                }
                navItems[_loc_3].makeSelected(false);
            }
            return;
        }// end function

        private function snOut(event:MouseEvent) : void
        {
            var _loc_3:String = null;
            var _loc_4:SidenavItem = null;
            var _loc_2:Number = 0.15;
            Tweener.addTween(snCont, {scaleX:0.66, scaleY:0.66, time:_loc_2, transition:"easeOutSine"});
            for (_loc_3 in navItems)
            {
                
                _loc_4 = navItems[_loc_3] as SidenavItem;
                Tweener.removeTweens(_loc_4.icon, "scaleX", "scaleY", "y");
                Tweener.removeTweens(_loc_4.tf, "alpha");
                Tweener.addTween(_loc_4.icon, {scaleX:1.25, scaleY:1.25, y:_loc_4.storeIconY + 5, time:_loc_2, transition:"easeOutSine"});
                Tweener.addTween(_loc_4.tf, {alpha:0, time:_loc_2, transition:"easeOutSine"});
            }
            return;
        }// end function

        private function initListeners() : void
        {
            SidenavEvents.disp.addEventListener(SidenavEvents.CLOSE_PANEL, onClosePressed);
            return;
        }// end function

        private function siOut(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as SidenavItem;
            _loc_2.rollOut();
            return;
        }// end function

        public function setSidebarItemsSelected(param1:String = "") : void
        {
            var _loc_2:String = null;
            for (_loc_2 in navItems)
            {
                
                if (navItems[_loc_2].thisTitle.toLowerCase().toLowerCase().split(" ").join("") == param1.toLowerCase())
                {
                    navItems[_loc_2].rollOver();
                    navItems[_loc_2].makeSelected(true);
                    continue;
                }
                navItems[_loc_2].makeSelected(false);
            }
            return;
        }// end function

        public function initSideNav(param1:Array, param2:Boolean = false, param3:int = -1) : void
        {
            var _loc_5:Boolean = false;
            var _loc_6:Boolean = false;
            var _loc_8:String = null;
            var _loc_9:Box = null;
            var _loc_10:SidenavItem = null;
            var _loc_11:MovieClip = null;
            var _loc_12:GlowTextBox = null;
            var _loc_4:* = param1.concat();
            var _loc_7:int = 1;
            for (_loc_8 in _loc_4)
            {
                
                _loc_5 = false;
                _loc_6 = false;
                if (Number(_loc_8) == 0)
                {
                    _loc_5 = true;
                }
                if (Number(_loc_8) == (_loc_4.length - 1))
                {
                    _loc_6 = true;
                }
                _loc_10 = new SidenavItem(int(_loc_8), _loc_4[_loc_8].title, _loc_4[_loc_8].gfx, _loc_4[_loc_8].alerts, _loc_5, _loc_6);
                new SidenavItem(int(_loc_8), _loc_4[_loc_8].title, _loc_4[_loc_8].gfx, _loc_4[_loc_8].alerts, _loc_5, _loc_6).y = (_loc_10.h + _loc_7) * int(_loc_8);
                _loc_10.mouseChildren = false;
                _loc_10.buttonMode = true;
                _loc_10.useHandCursor = true;
                _loc_10.addEventListener(MouseEvent.ROLL_OVER, siOver);
                _loc_10.addEventListener(MouseEvent.ROLL_OUT, siOut);
                _loc_10.addEventListener(MouseEvent.CLICK, siClick);
                navItems.push(_loc_10);
                siCont.addChild(_loc_10);
                if (param3 != -1 && _loc_4[_loc_8].title == "Get Chips")
                {
                    _loc_11 = new SideNavChipSaleAnimations();
                    _loc_11.x = 31;
                    _loc_11.y = 1;
                    _loc_11.name = "chipSaleAnimation";
                    _loc_11.gotoAndStop(param3);
                    _loc_10.addChild(_loc_11);
                }
                if (param2 && _loc_4[_loc_8].title == "Get Chips")
                {
                    _loc_12 = new GlowTextBox("SALE!");
                    _loc_12.x = 38;
                    _loc_12.y = 25;
                    _loc_12.name = "starburst";
                    _loc_10.addChild(_loc_12);
                }
            }
            siCont.y = Math.round(-siCont.height / 2);
            _loc_9 = new Box(snCont.width, snCont.height, 16711680, false);
            _loc_9.y = siCont.y;
            _loc_9.alpha = 0;
            initListeners();
            return;
        }// end function

    }
}
