package com.script.poker.commonUI
{
    import com.script.poker.*;
    import fl.data.*;
    import flash.utils.*;

    public class CommonUIModel extends Object
    {
        private var offlineZids:Array;
        private var outstandingInvites:Array;
        private var friendsInviteDP:DataProvider;
        public var nOffline:int = 0;
        private var onlineFeed:Array;
        private var friendsOfflineDP:DataProvider;
        private var inviteIssued:Dictionary;
        public var inLobby:Boolean = true;
        public var isTwoAtTable:Boolean = false;
        private var playingNowDP:DataProvider;
        public var idList:Array;
        private var friendsOnlineDP:DataProvider;
        public var nOnline:int = 0;
        private var playingNowZids:Object;
        public var serverTypeList:Array;
        private var joinIssued:Dictionary;
        private var onlineZids:Array;

        public function CommonUIModel()
        {
            joinIssued = new Dictionary(true);
            inviteIssued = new Dictionary(true);
            friendsOnlineDP = new DataProvider();
            friendsOfflineDP = new DataProvider();
            playingNowDP = new DataProvider();
            friendsInviteDP = new DataProvider();
            outstandingInvites = new Array();
            playingNowZids = new Object();
            onlineFeed = new Array();
            return;
        }// end function

        public function getSameTableIds(param1:Number) : Array
        {
            var _loc_3:int = 0;
            var _loc_4:Object = null;
            var _loc_2:* = new Array();
            _loc_3 = 0;
            while (_loc_3 < friendsInviteDP.length)
            {
                
                _loc_4 = friendsInviteDP.getItemAt(_loc_3);
                if (_loc_4["room_id"] == param1)
                {
                    _loc_2.push(_loc_4);
                }
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < playingNowDP.length)
            {
                
                _loc_4 = playingNowDP.getItemAt(_loc_3);
                if (_loc_4["room_id"] == param1)
                {
                    _loc_2.push(_loc_4);
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function addInvite(param1:Object) : void
        {
            outstandingInvites.push(param1);
            checkInvites();
            return;
        }// end function

        public function updateFOffline(param1:Array) : void
        {
            nOffline = param1.length;
            return;
        }// end function

        public function removeSameTables() : void
        {
		
            var _loc_1:int = 0;
            var _loc_2:Object = null;
            _loc_1 = 0;
            while (_loc_1 < playingNowDP.length)
            {
                
                _loc_2 = playingNowDP.getItemAt(_loc_1);
                switch(_loc_2["tableType"])
                {
                    case "Points":
                    {
                        _loc_2["playStatus"] = "join";
                        _loc_2["serverType"] = "Points";
                        break;
                    }
                    case "Vip":
                    {
                        _loc_2["playStatus"] = "join";
                        _loc_2["serverType"] = "Vip";
                        break;
                    }
                    case "SitNGo":
                    {
                        _loc_2["playStatus"] = "join";
                        _loc_2["serverType"] = "SitNGo";
                        _loc_2["tableStakes"] = "SitNGo";
                        break;
                    }
                    case "ShootOut":
                    {
                        _loc_2["playStatus"] = "shootout";
                        _loc_2["serverType"] = "ShootOut";
                        _loc_2["tableStakes"] = "ShootOut";
                        break;
                    }
                    case "Showdown":
                    {
                        _loc_2["playStatus"] = "showdown";
                        _loc_2["serverType"] = "Showdown";
                        _loc_2["tableStakes"] = "Showdown";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
				
                if (_loc_2["playStatus"] == "lobbyinvite")
                {
                    _loc_2["playStatus"] = "lobby";
                }
				/*if (_loc_2["playStatus"] == "otherinvite")
                {
                    _loc_2["playStatus"] = "other";
                }*/
				
                playingNowDP.replaceItemAt(_loc_2, _loc_1);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < friendsInviteDP.length)
            {
                
                _loc_2 = friendsInviteDP.getItemAt(_loc_1);
                switch(_loc_2["tableType"])
                {
                    case "Points":
                    {
                        _loc_2["playStatus"] = "join";
                        _loc_2["serverType"] = "Points";
                        break;
                    }
                    case "Vip":
                    {
                        _loc_2["playStatus"] = "join";
                        _loc_2["serverType"] = "Vip";
                        break;
                    }
                    case "SitNGo":
                    {
                        _loc_2["playStatus"] = "join";
                        _loc_2["serverType"] = "SitNGo";
                        _loc_2["tableStakes"] = "SitNGo";
                        break;
                    }
                    case "ShootOut":
                    {
                        _loc_2["playStatus"] = "shootout";
                        _loc_2["serverType"] = "ShootOut";
                        _loc_2["tableStakes"] = "ShootOut";
                        break;
                    }
                    case "Showdown":
                    {
                        _loc_2["playStatus"] = "showdown";
                        _loc_2["serverType"] = "Showdown";
                        _loc_2["tableStakes"] = "Showdown";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (_loc_2["playStatus"] == "lobbyinvite")
                {
                    _loc_2["playStatus"] = "lobby";
                }
				/*if (_loc_2["playStatus"] == "otherinvite")
                {
                    _loc_2["playStatus"] = "other";
                }*/
                friendsInviteDP.replaceItemAt(_loc_2, _loc_1);
                _loc_1++;
            }
            return;
        }// end function

        private function getServerType(param1:String) : String
        {
            var _loc_2:int = 0;
            while (_loc_2 < idList.length)
            {
                
                if (idList[_loc_2] == param1)
                {
                    return serverTypeList[_loc_2];
                }
                _loc_2++;
            }
            return "";
        }// end function

        public function checkOutstandingInvite(param1:String) : Boolean
        {
            var _loc_2:Boolean = false;
            var _loc_3:int = 0;
            while (_loc_3 < outstandingInvites.length)
            {
                
                if (param1 == outstandingInvites[_loc_3]["uid"])
                {
                    _loc_2 = true;
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function getTableBuddyCount(param1) : Number
        {
            var _loc_3:int = 0;
            var _loc_4:Object = null;
            var _loc_2:Number = 0;
            _loc_3 = 0;
            while (_loc_3 < friendsInviteDP.length)
            {
                
                _loc_4 = friendsInviteDP.getItemAt(_loc_3);
                if (_loc_4["room_id"] == param1)
                {
                    _loc_2 = _loc_2 + 1;
                }
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < playingNowDP.length)
            {
                
                _loc_4 = playingNowDP.getItemAt(_loc_3);
                if (_loc_4["room_id"] == param1)
                {
                    _loc_2 = _loc_2 + 1;
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function removeInvite(param1:Object) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < outstandingInvites.length)
            {
                
                if (param1["uid"] == outstandingInvites[_loc_2]["uid"])
                {
                    outstandingInvites.splice(_loc_2, 1);
                    playingNowDP.addItem(param1);
                    break;
                }
                _loc_2++;
            }
            checkInvites();
            return;
        }// end function

        public function removeInviteIssued(param1:String) : void
        {
            inviteIssued[param1] = false;
            checkInvited();
            return;
        }// end function

        public function getOnlineUser(param1:String) : Object
        {
            var _loc_2:Object = null;
            var _loc_4:Object = null;
            var _loc_3:int = 0;
            while (_loc_3 < playingNowDP.length)
            {
                
                _loc_4 = playingNowDP.getItemAt(_loc_3);
                if (_loc_4["uid"] == param1)
                {
                    _loc_2 = _loc_4;
                    break;
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function updateFOnline(param1:Array = null) : void
        {
            var _loc_2:int = 0;
            if (param1 == null)
            {
                param1 = onlineFeed.concat();
            }
            else
            {
                onlineFeed = param1.concat();
            }
            if (param1.length > 0)
            {
                _loc_2 = param1.length - 1;
                while (_loc_2 > -1)
                {
                    
                    if (playingNowZids != null)
                    {
                        if (playingNowZids.hasOwnProperty("1:" + param1[_loc_2].uid))
                        {
                            param1.splice(_loc_2, 1);
                        }
                    }
                    _loc_2 = _loc_2 - 1;
                }
            }
            onlineZids = param1.concat();
            nOnline = onlineZids.length;
            return;
        }// end function

        public function get pNowDP() : DataProvider
        {
            return playingNowDP;
        }// end function

        private function checkInvited() : void
        {			
            var _loc_1:int = 0;
            var _loc_2:Object = null;
            var _loc_3:Boolean = false;
            _loc_1 = 0;
		//_loc_2["invited"] = true;
			
            while (_loc_1 < friendsInviteDP.length)
            {
                
                _loc_2 = friendsInviteDP.getItemAt(_loc_1);
                if (inviteIssued[_loc_2["uid"]] == true)
                {
                    _loc_3 = true;
                }
                else
                {
                    _loc_3 = false;
                }
                if (_loc_3 == true)
                {
                    _loc_2["invited"] = true;
                    friendsInviteDP.replaceItemAt(_loc_2, _loc_1);
                }
                _loc_1++;
            }
            _loc_1 = 0;
			
            while (_loc_1 < playingNowDP.length)
            {
                
                _loc_2 = playingNowDP.getItemAt(_loc_1);
                if (inviteIssued[_loc_2["uid"]] != true)
                {
                    _loc_3 = false;
                }
                else
                {
                    _loc_3 = true;
                }
                if (_loc_3)
                {
                    _loc_2["invited"] = true;
                    playingNowDP.replaceItemAt(_loc_2, _loc_1);
                }
                _loc_1++;
            }
            return;
        }// end function

        public function addInviteIssued(param1:String) : void
        {
            inviteIssued[param1] = true;
            checkInvited();
            return;
        }// end function

        public function setServerTypeList(param1:Array, param2:Array) : void
        {
            serverTypeList = param1;
            idList = param2;
            return;
        }// end function

        public function checkSameTable(param1, param2, param3) : Array
        {
            var _loc_5:int = 0;
            var _loc_6:Object = null;
            var _loc_4:* = new Array();
            _loc_5 = 0;

            while (_loc_5 < friendsInviteDP.length)
            {
                
                _loc_6 = friendsInviteDP.getItemAt(_loc_5);
                if (_loc_6["room_id"] == param1)
                {
                    if (joinIssued[_loc_6["uid"]] != true)
                    {
                        _loc_4.push(_loc_6);
                        joinIssued[_loc_6["uid"]] = true;
                    }
                    removeInviteIssued(_loc_6["uid"]);
                    _loc_6["playStatus"] = "table";
                }
                if (_loc_6["playStatus"] == "join")
                {
                    joinIssued[_loc_6["uid"]] = false;
                    if (param3.split("shootout")[0] == "" || _loc_6["uid"].split("1:")[0] != "")
                    {
                        _loc_6["playStatus"] = "join";
                    }
                    else
                    {
                        _loc_6["playStatus"] = "liveinvite";
                    }
                }
                if (_loc_6["playStatus"] == "lobby")
                {
                    if (param3.split("shootout")[0] == "" || _loc_6["uid"].split("1:")[0] != "")
                    {
                        _loc_6["playStatus"] = "lobby";
                    }
                    else
                    {
                        _loc_6["playStatus"] = "lobbyinvite";
                    }
                }
				if (_loc_6["playStatus"] == "other")
                {
                   
                        _loc_6["playStatus"] = "otherinvite";
                   
                }
                friendsInviteDP.replaceItemAt(_loc_6, _loc_5);
                _loc_5++;
            }
	
		_loc_5 = 0;
            while (_loc_5 < playingNowDP.length)
            {
                _loc_6 = playingNowDP.getItemAt(_loc_5);
				removeInviteIssued(_loc_6["uid"]);
                if (_loc_6["room_id"] == param1)
                {
                    if (joinIssued[_loc_6["uid"]] != true)
                    {
                        _loc_4.push(_loc_6);
                        joinIssued[_loc_6["uid"]] = true;
                    }
                    
                    _loc_6["playStatus"] = "table";
                }
                if (_loc_6["playStatus"] == "join")
                {
                    
                        joinIssued[_loc_6["uid"]] = false;
                        _loc_6["playStatus"] = "liveinvite";
                    
                }
                if (_loc_6["playStatus"] == "lobby")
                {
                        joinIssued[_loc_6["uid"]] = false;
                        _loc_6["playStatus"] = "lobbyinvite";
                    
                }
				 if (_loc_6["playStatus"] == "other")
                {
                        joinIssued[_loc_6["uid"]] = false;
                        _loc_6["playStatus"] = "otherinvite";
                    
                }
                playingNowDP.replaceItemAt(_loc_6, _loc_5);
                _loc_5++;
            }
			
            _loc_5 = 0;
            while (_loc_5 < friendsInviteDP.length)
            {
                
                _loc_6 = friendsInviteDP.getItemAt(_loc_5);
                if (_loc_6["room_id"] == param1)
                {
                    removeInvite(_loc_6);
                }
                _loc_5++;
            }
            return _loc_4;
        }// end function

        private function checkInvites() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:Object = null;
            var _loc_4:Object = null;
            var _loc_6:Boolean = false;
            friendsInviteDP = new DataProvider();
            _loc_1 = 0;
            while (_loc_1 < playingNowDP.length)
            {
                
                _loc_3 = playingNowDP.getItemAt(_loc_1);
                _loc_2 = 0;
                while (_loc_2 < outstandingInvites.length)
                {
                    
                    _loc_4 = outstandingInvites[_loc_2];
                    if (_loc_3["uid"] == _loc_4["uid"])
                    {
                        playingNowDP.removeItem(_loc_3);
                        friendsInviteDP.addItem(_loc_3);
                    }
                    _loc_2++;
                }
                _loc_1++;
            }
            var _loc_5:* = new Array();
            _loc_2 = 0;
            while (_loc_2 < outstandingInvites.length)
            {
                
                _loc_4 = outstandingInvites[_loc_2];
                if (playingNowZids[_loc_4["uid"]] != 1)
                {
                    _loc_5.push(outstandingInvites[_loc_2]);
                }
                _loc_2++;
            }
            _loc_1 = 0;
            while (_loc_1 < _loc_5.length)
            {
                
                _loc_2 = 0;
                while (_loc_2 < outstandingInvites.length)
                {
                    
                    if (_loc_5[_loc_1]["uid"] == outstandingInvites[_loc_2]["uid"])
                    {
                        outstandingInvites.splice(_loc_2, 1);
                    }
                    _loc_2++;
                }
                _loc_1++;
            }
            _loc_2 = 0;
            while (_loc_2 < outstandingInvites.length)
            {
                
                _loc_4 = outstandingInvites[_loc_2];
                _loc_6 = false;
                _loc_1 = 0;
                while (_loc_1 < friendsInviteDP.length)
                {
                    
                    _loc_3 = friendsInviteDP.getItemAt(_loc_1);
                    if (_loc_3["uid"] == _loc_4["uid"])
                    {
                        _loc_6 = true;
                    }
                    _loc_1++;
                }
                if (!_loc_6)
                {
                    friendsInviteDP.addItem(_loc_4);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function get fInvDP() : DataProvider
        {
            return friendsInviteDP;
        }// end function

        public function zoomUpdateFriends(param1:Array, param2, param3) : void
        {
            var _loc_5:String = null;
            var _loc_7:UserPresence = null;
            var _loc_8:String = null;
            var _loc_9:String = null;
            var _loc_10:String = null;
            var _loc_11:Boolean = false;
            playingNowDP = new DataProvider();
            var _loc_4:* = new Object();
            playingNowZids = new Object();
            var _loc_6:int = 0;
			
            while (_loc_6 < param1.length)
            {
                
                _loc_7 = param1[_loc_6];
                playingNowZids[_loc_7.sZid] = 1;
                if (!isTwoAtTable)
                {
                    _loc_5 = _loc_7.nServerId.toString() + "_" + _loc_7.nRoomId.toString();
                    if (!_loc_4.hasOwnProperty(_loc_5))
                    {
                        _loc_4[_loc_5] = 1;
                    }
                    else
                    {
                        isTwoAtTable = true;
                    }
                }
               /* _loc_8 = getServerType(String(_loc_7.nServerId));
                if (_loc_8.split("shootout")[0] == "")
                {
                    _loc_8 = "shootout";
                    ;
                }*/
				_loc_8 = "normal"
                _loc_9 = "";
				if (_loc_7.nRoomId == -2) {
					//_loc_8 = "other"
				}
				
                switch(_loc_8)
                {
                    case "normal":
                    {
                        _loc_9 = "join";
                        _loc_8 = "Points";
                        break;
                    }
                    case "vip":
                    {
                        _loc_9 = "join";
                        _loc_8 = "Vip";
                        _loc_7.tableStakes = "VIP";
                        break;
                    }
                    case "sitngo":
                    {
                        _loc_9 = "join";
                        _loc_8 = "SitNGo";
                        _loc_7.tableStakes = "SitNGo";
                        break;
                    }
                    case "shootout":
                    {
                        _loc_9 = "shootout";
                        _loc_8 = "ShootOut";
                        _loc_7.tableStakes = "ShootOut";
                        break;
                    }
                    case "showdown":
                    {
                        _loc_9 = "showdown";
                        _loc_8 = "Showdown";
                        _loc_7.tableStakes = "Showdown";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }

                if (_loc_7.sPicURL == null || _loc_7.sPicURL == "")
                {
                    _loc_7.sPicURL = "../Avatar/default.jpg";
                }
		
				
                if (_loc_7.nRoomId == -1)
                {
                    _loc_8 = "Lobby";
                    _loc_9 = "lobby";
                }
				else if (_loc_7.nRoomId == -2) {
					_loc_8 = _loc_7.nServerId;
					_loc_9 = "otherinvite";
					 _loc_7.tableStakes = _loc_7.nServerId;
                    //_loc_9 = _loc_7.nServerId;
				}
                if ((_loc_7.sFirstName + " " + _loc_7.sLastName).length > 14)
                {
                    _loc_10 = (_loc_7.sFirstName + " " + _loc_7.sLastName).slice(0, 14) + "...";
                }
                else
                {
                    _loc_10 = _loc_7.sFirstName + " " + _loc_7.sLastName;
                }
                if (inviteIssued[_loc_7.sZid] != true)
                {
                    _loc_11 = false;
                }
                else
                {
                    _loc_11 = true;
                }
		
                playingNowDP.addItem({invited:_loc_11, label:_loc_10, source:unescape(_loc_7.sPicURL), playStatus:_loc_9, tableStakes:_loc_7.tableStakes, tableType:_loc_8, uid:_loc_7.sZid, game_id:_loc_7.nGameId, server_id:_loc_7.nServerId, room_id:_loc_7.nRoomId, first_name:_loc_7.sFirstName, last_name:_loc_7.sLastName, relationship:_loc_7.sRelationship});
                _loc_6++;
            }
            checkInvites();
            return;
        }// end function

        public function resetJoins() : void
        {
            joinIssued = new Dictionary(true);
            return;
        }// end function

        private function checkOnline(param1:String) : Boolean
        {
            var _loc_2:int = 0;
            while (_loc_2 < onlineZids.length)
            {
                
                if (param1 == onlineZids[_loc_2].uid)
                {
                    return true;
                }
                _loc_2++;
            }
            return false;
        }// end function

    }
}
