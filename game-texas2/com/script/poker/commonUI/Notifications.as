package com.script.poker.commonUI
{
    import caurina.transitions.*;
    import com.script.poker.commonUI.events.*;
    import com.script.poker.commonUI.notifs.*;
    import flash.display.*;

    public class Notifications extends MovieClip
    {
        private var pgData:Object;
        private var displaynotifs:Array;
        private var invitenotifs:Array;
        private var inLobby:Boolean = true;
        private var joinednotifs:Array;

        public function Notifications()
        {
            invitenotifs = new Array();
            joinednotifs = new Array();
            displaynotifs = new Array();
            return;
        }// end function

        private function removeInviteNotif(param1:InviteNotif) : void
        {
            var _loc_3:InviteNotif = null;
            var _loc_2:* = param1;
            for each (_loc_3 in invitenotifs)
            {
                
                if (_loc_3 == _loc_2)
                {
                    invitenotifs.splice(invitenotifs.indexOf(_loc_3), 1);
                    _loc_3.removeEventListener(CommonVEvent.CLOSE_NOTIF, inviteClosed);
                    dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_INVITE, param1));
                    fadeOutNotif(_loc_3);
                }
            }
            redrawNotifs();
            return;
        }// end function

        public function addInviteNotif(param1:Object) : void
        {
            var _loc_3:InviteNotif = null;
            var _loc_4:InviteNotif = null;
            var _loc_2:Boolean = false;
			
           /* for each (_loc_3 in invitenotifs)
            {
                
                if (pgData != null)
                {
                    if (param1["room_id"] == _loc_3.pObj["room_id"] && param1["server_id"] == _loc_3.pObj["server_id"])
                    {
                        _loc_2 = true;
                    }
                }
                if (_loc_3.zid == param1["uid"])
                {
                    _loc_2 = true;
                    continue;
                }
            }*/
            _loc_2 = false;
            if (!_loc_2)
            {
				
                _loc_4 = new InviteNotif(param1, inLobby);
                _loc_4.addEventListener(CommonVEvent.CLOSE_NOTIF, inviteClosed);
				
                invitenotifs.push(_loc_4);
                addChild(_loc_4);
                redrawNotifs();
            }
            return;
        }// end function

        private function redrawNotifs() : void
        {
            displaynotifs = new Array();
            var _loc_1:* = 0;
			
            while (_loc_1 < invitenotifs.length)
            {
                if (_loc_1 < 3)
                {
			
			displaynotifs[_loc_1] = invitenotifs[_loc_1];
                    if (invitenotifs[_loc_1].alpha == 0)
                    {
		
                        Tweener.addTween(invitenotifs[_loc_1], {alpha:1, time:0.25, delay:0.5, transition:"easeOutSine"});
                        Tweener.addTween(invitenotifs[_loc_1], {alpha:0, time:0.25, delay:10, transition:"easeOutSine", onComplete:removeInviteNotif, onCompleteParams:[invitenotifs[_loc_1]]});
                    }
                }
                _loc_1 = _loc_1 + 1;
            }
            var _loc_2:* = 0;
            var _loc_3:* = displaynotifs.length;

            while (displaynotifs.length < 3 && _loc_2 < joinednotifs.length)
            {
                
                if (joinednotifs[_loc_2] != null)
                {
                    displaynotifs[_loc_3 + _loc_2] = joinednotifs[_loc_2];
                    if (joinednotifs[_loc_2].alpha == 0)
                    {
                        Tweener.addTween(joinednotifs[_loc_2], {alpha:1, time:0.25, delay:0.5, transition:"easeOutSine"});
                        Tweener.addTween(joinednotifs[_loc_2], {alpha:0, time:0.25, delay:10, transition:"easeOutSine", onComplete:removeJoinNotif, onCompleteParams:[joinednotifs[_loc_2]]});
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
	
            if (displaynotifs[0] != null)
            {
                Tweener.addTween(displaynotifs[0], {y:400, time:0.25, delay:0.1, transition:"easeOutSine"});
                ;
            }
            if (displaynotifs[1] != null)
            {
                Tweener.addTween(displaynotifs[1], {y:370, time:0.25, delay:0.1, transition:"easeOutSine"});
                ;
            }
            if (displaynotifs[2] != null)
            {
                Tweener.addTween(displaynotifs[2], {y:340, time:0.25, delay:0.1, transition:"easeOutSine"});
                ;
            }
            return;
        }// end function
		
        public function addJoinedNotif(param1:Object) : void
        {
            var _loc_3:JoinedTableNotif = null;
            var _loc_4:JoinedTableNotif = null;
            var _loc_2:Boolean = false;
            for each (_loc_3 in joinednotifs)
            {
                
                if (_loc_3.zid == param1["uid"])
                {
                    _loc_2 = true;
                    continue;
                }
            }
            _loc_2 = false;
            if (!_loc_2)
            {
                _loc_4 = new JoinedTableNotif(param1);
                _loc_4.addEventListener(CommonVEvent.CLOSE_NOTIF, joinedClosed);
                joinednotifs.push(_loc_4);
                addChild(_loc_4);
                redrawNotifs();
            }
            return;
        }// end function

        public function init(param1) : void
        {
            this.pgData = param1;
            return;
        }// end function

        public function updateNotifButtons(param1:String) : void
        {
            var _loc_2:InviteNotif = null;
            switch(param1)
            {
                case "lobby":
                {
                    inLobby = true;
                    for each (_loc_2 in invitenotifs)
                    {
                        
                        _loc_2.hideInvite();
                    }
                    break;
                }
                case "table":
                {
                    inLobby = false;
                    for each (_loc_2 in invitenotifs)
                    {
                        
                        _loc_2.showInvite();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function inviteClosed(event:CloseNotifEvent)
        {
            var _loc_2:InviteNotif = null;
            for each (_loc_2 in invitenotifs)
            {
                
                if (_loc_2 == event.notif)
                {
                    invitenotifs.splice(invitenotifs.indexOf(_loc_2), 1);
                    fadeOutNotif(_loc_2);
                }
            }
            dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_INVITE, event.notif));
            redrawNotifs();
            return;
        }// end function

        private function removeJoinNotif(param1:JoinedTableNotif) : void
        {
            var _loc_3:JoinedTableNotif = null;
            var _loc_2:* = param1;
            for each (_loc_3 in joinednotifs)
            {
                
                if (_loc_3 == _loc_2)
                {
                    joinednotifs.splice(joinednotifs.indexOf(_loc_3), 1);
                    _loc_3.removeEventListener(CommonVEvent.CLOSE_NOTIF, joinedClosed);
                    fadeOutNotif(_loc_3);
                }
            }
            redrawNotifs();
            return;
        }// end function

        private function joinedClosed(event:CloseNotifEvent)
        {
            var _loc_2:JoinedTableNotif = null;
            for each (_loc_2 in joinednotifs)
            {
                
                if (_loc_2 == event.notif)
                {
                    joinednotifs.splice(joinednotifs.indexOf(_loc_2), 1);
                    fadeOutNotif(_loc_2);
                }
            }
            redrawNotifs();
            return;
        }// end function

        private function fadeOutNotif(param1:BaseNotif) : void
        {
            var target:* = param1;
            Tweener.addTween(target, {alpha:0, time:0.25, transition:"easeOutSine", onComplete:function ()
            {
                this.parent.removeChild(this);
                Tweener.removeTweens(this);
                return;
            }// end function
            });
            return;
        }// end function

    }
}
