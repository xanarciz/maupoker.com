// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import com.script.User;
	import com.script.poker.lobby.RoomItem;
	import com.script.poker.PokerUser;
	import com.script.poker.table.asset.Pot;
	import com.script.poker.table.asset.CardData;
	public class TableModel
	{
		public var aGiftItems:Array;
		public var sBlinds:String;
		public var viewer:com.script.User;
		public var aRankNames:Array;
		public var aUsers:Array;
		public var nDealerSit:int;
		public var flopCard1:com.script.poker.table.asset.CardData;
		public var flopCard2:com.script.poker.table.asset.CardData;
		public var flopCard3:com.script.poker.table.asset.CardData;
		public var nTourneyId:int;
		public var holeCard1:com.script.poker.table.asset.CardData;
		public var holeCard2:com.script.poker.table.asset.CardData;
		public var riverCard:com.script.poker.table.asset.CardData;
		public var nCurrentTurn:int;
		public var aUsersInHand:Array;
		public var nCallAmt:Number = 0;
		public var sServerName:String;
		public var sTableUrl:String;
		public var aJoinNetworks:Array;
		public var aBlockedUsers:Array = new Array();
		public var aIndexUsers:Array;
		public var sTourneyMode:String;
		public var nMaxBet:Number = 0;
		public var bTableSoundMute:Boolean;
		public var nMinBuyIn:Number = 0;
		public var aUsersInRoom:Array;
		public var aUsersWaiting:Array;
		public var streetCard:com.script.poker.table.asset.CardData;
		public var nSmallblind:Number = 0;
		public var aPots:Array;
		public var nMaxBuyIn:Number = 0;
		public var room:com.script.poker.lobby.RoomItem;
		public var aDealOrder:Array;
		public var nBigblind:Number = 0;
		public var aBuddyInvites:Array;
		public var aJoinFriends:Array;
		public var nMinBet:Number = 0;
		public var nZoomFriends:Number = 0;
		public var sDispMode:String;
		public var nHandId:int;
		public var nOwner:String;
		public var nBuyFee:Number = 0;
		public var langs;
		public function TableModel(p__1:Array, p__2:com.script.User, p__3:com.script.poker.lobby.RoomItem, p__4:Array, p__5:Array, p__6:Array, p__7:String, p__8:String, p__9:int, p__10:String, p__11:String = "")
		{
			var l__12:* = undefined;
			aUsers = (p__1).concat();
			aUsersInHand = (p__1).concat();
			aRankNames = p__4;
			aBuddyInvites = p__5;
			aGiftItems = p__6;
			aPots = new Array();
			viewer = p__2;
			room = p__3;
			sServerName = p__7;
			sTableUrl = p__8;
			nTourneyId = p__9;
			sTourneyMode = p__10;
			sDispMode = p__11;			
			for (l__12 in aUsers){
			}
			aJoinFriends = new Array();
			aJoinNetworks = new Array();
			parseRoomItem();
		}
		private function parseRoomItem():void
		{
			nBigblind = room.bigBlind;
			nSmallblind = room.smallBlind;
			nMaxBuyIn = room.maxBuyin;
			nMinBuyIn = nBigblind * 20;
			sBlinds = formatBlinds(nSmallblind, nBigblind);
			nOwner = room.tabowner;
			nBuyFee = room.entryFee;
		}
		public function updateBlinds(p__1:Number, p__2:Number):void
		{
			nBigblind = p__2;
			nSmallblind = p__1;
			room.bigBlind = p__2;
			room.smallBlind = p__1;
			sBlinds = formatBlinds(nSmallblind, nBigblind);
		}
		public function formatBlinds(p__1:Number, p__2:Number):String
		{
			return((formatBlind(p__1) + "/") + formatBlind(p__2));
		}
		private function formatBlind(p__1:Number):String
		{
			var l__2:Number = 0;
			var l__3:String;
			if ((p__1) < 1000){
				return((p__1).toString());
			}
			if (((p__1) >= 1000) && ((p__1) < 1000000)){
				if (((p__1) % 1000) == 0){
					l__2 = (p__1) / 1000;
					return(l__2.toString() + "K");
				}
				l__2 = (p__1) / 1000;
				l__3 = l__2.toString();
				l__3 = l__3.substr(0, 30);
				return(l__3 + "K");
			} else if (((p__1) >= 1000000) && ((p__1) < 1000000000)){
				if (((p__1) % 1000000) == 0){
					l__2 = (p__1) / 1000000;
					return(l__2.toString() + "M");
				}
				l__2 = (p__1) / 1000000;
				l__3 = l__2.toString();
				l__3 = l__3.substr(0, 30);
				return(l__3 + "M");
			}
		}
		public function resetModel():void
		{
			aUsersInHand = aUsers.concat();
			aPots = new Array();
			handsPlayed = 0;
			holeCard1 = null;
			holeCard2 = null;
			flopCard1 = null;
			flopCard2 = null;
			flopCard3 = null;
			streetCard = null;
			riverCard = null;
			nMinBet = 0;
			nMaxBet = 0;
			nCallAmt = 0;
		}
		private function setUsersInHand(p__1:int):void
		{
			var l__2:com.script.poker.PokerUser;
			var l__3:int;
			aDealOrder = new Array();
			aIndexUsers = new Array();
			l__3 = 0;
			while(l__3 < aUsersInHand.length){
				l__2 = aUsersInHand[l__3];
				aIndexUsers[l__2.nSit] = l__2;
				l__3++;
			}
			l__3 = p__1;
			while(l__3 < 9){
				if (aIndexUsers[l__3] != null){
					aDealOrder.push(aIndexUsers[l__3]);					
				}
				l__3++;
			}
			l__3 = 0;
			while(l__3 < (p__1)){
				if (aIndexUsers[l__3] != null){
					aDealOrder.push(aIndexUsers[l__3]);					
				}
				l__3++;
			}
		}
		public function addUser(p__1:com.script.poker.PokerUser):void
		{
			aUsers.push(p__1);
		}
		public function removeUser(p__1:int):void
		{
			var l__2:com.script.poker.PokerUser;
			var l__3:int;
			l__3 = 0;
			while(l__3 < aUsers.length){
				l__2 = PokerUser(aUsers[l__3]);
				if (l__2.nSit == (p__1)){
					aUsers.splice(l__3, 1);
				}
				l__3++;
			}	
		}		
		public function getUserBySit(p__1:int, p__2:Boolean = false):com.script.poker.PokerUser
		{
			var l__3:com.script.poker.PokerUser;
			var l__4:int;
			if (p__2){
				l__4 = 0;
				while(l__4 < aUsersInHand.length){
					l__3 = PokerUser(aUsersInHand[l__4]);
					if (l__3.nSit == (p__1)){
						return(l__3);
					}
					l__4++;
				}
			} else {
				l__4 = 0;
				while(l__4 < aUsers.length){
					l__3 = PokerUser(aUsers[l__4]);
					if (l__3.nSit == (p__1)){
						return(l__3);
					}
					l__4++;
				}
			}
			return(null);
		}
		public function getUserByZid(p__1:String, p__2:Boolean = false):com.script.poker.PokerUser
		{
			var l__3:com.script.poker.PokerUser;
			var l__4:int;
			if (p__2){
				l__4 = 0;
				while(l__4 < aUsersInHand.length){
					l__3 = PokerUser(aUsersInHand[l__4]);
					if (l__3.zid == (p__1)){
						return(l__3);
					}
					l__4++;
				}
			} else {
				l__4 = 0;
				
				while(l__4 < aUsers.length){
					l__3 = PokerUser(aUsers[l__4]);
					if (l__3.zid == (p__1)){
						return(l__3);
					}
					l__4++;
				}
			}
			return(null);
		}
		public function checkUserInRoom(p__1:String):Boolean
		{
			var l__2:int;
			while(l__2 < aUsersInRoom.length){
				if (aUsersInRoom[l__2].zid == (p__1)){
					return(true);
				}
				l__2++;
			}
			return(false);
		}
		public function getPotById(p__1:int):com.script.poker.table.asset.Pot
		{
			var l__2:com.script.poker.table.asset.Pot;
			var l__3:int;
			l__3 = 0;
			while(l__3 < aPots.length){
				l__2 = Pot(aPots[l__3]);
				if (l__2.nPotId == (p__1)){
					return(l__2);
				}
				l__3++;
			}
			return(null);
		}
		public function updateBlind(p__1:int, p__2:Number, p__3:Number):void
		{
			var l__5:Number = 0;
			var l__4:com.script.poker.PokerUser = getUserBySit(p__1);
			if (l__4 != null){
				
				l__4.nBlind = p__2;
				l__4.nCurBet = p__2;
				l__5 = l__4.nChips;
				l__4.nOldChips = l__5;
				l__4.nChips = p__3;
			}
		}
		public function setupNewHand(p__1:int, p__2:String, p__3:Number, p__4:String, p__5:Number, p__6:int = -1):void
		{
			if ((p__6) != -1){
				setUsersInHand(p__6);
			}
			holeCard1 = new CardData(p__2, p__3);
			holeCard2 = new CardData(p__4, p__5);
		}
		public function clearHoleCards():void
		{
			holeCard1 = null;
			holeCard2 = null;
		}
		public function setFlopCards(p__1:String, p__2:Number, p__3:String, p__4:Number, p__5:String, p__6:Number):void
		{
			flopCard1 = new CardData(p__1, p__2);
			flopCard2 = new CardData(p__3, p__4);
			flopCard3 = new CardData(p__5, p__6);
		}
		public function setStreetCard(p__1:String, p__2:Number):void
		{
			streetCard = new CardData(p__1, p__2);
		}
		public function setRiverCard(p__1:String, p__2:Number):void
		{
			riverCard = new CardData(p__1, p__2);
		}
		public function setPot(p__1:int, p__2:Number):void
		{
			var l__3:com.script.poker.table.asset.Pot = getPotById(p__1);
			if (l__3 != null){
				l__3.nAmt = p__2;
			} else {
				l__3 = new Pot(p__1, p__2);
				aPots.push(l__3);
			}
		}
		public function setPlayerStatus(p__1:int, p__2:String):void
		{
			var l__3:com.script.poker.PokerUser = getUserBySit(p__1);
			if (l__3 == null) {
				return;
			}
			l__3.sStatusText = p__2;
		}
		public function setHoleCards(p__1:int, p__2:String, p__3:Number, p__4:String, p__5:Number):void
		{
			var l__6:com.script.poker.PokerUser = getUserBySit(p__1);
			l__6.holecard1 = new CardData(p__2, p__3);
			l__6.holecard2 = new CardData(p__4, p__5);
		}
		public function updateWinner(p__1:int, p__2:Number, p__3:String, p__4:Number, p__5:String, p__6:Number, p__7:Array, p__8:String):void
		{
			var l__9:com.script.poker.PokerUser = getUserBySit(p__1);
			var l__10:Number = l__9.nChips;
			l__9.nOldChips = l__10;
			l__9.nChips = p__2;
			l__9.holecard1 = new CardData(p__3, p__4);
			l__9.holecard2 = new CardData(p__5, p__6);
			l__9.aHandString = p__7;
			l__9.sStatusText = "winner";
			l__9.sWinningHand = p__8;
		}
		public function updateDefaultWinner(p__1:int, p__2:Number, p__3:Array):void
		{
			var l__4:com.script.poker.PokerUser = getUserBySit(p__1);
			l__4.nOldChips = l__4.nChips;
			l__4.nChips = p__2;
			l__4.sStatusText = "winner";
			l__4.aPotsWon = p__3;
		}
		public function updatePlayerAction(p__1:int, p__2:Number, p__3:Number, p__4:String):void
		{
			var l__5:com.script.poker.PokerUser = getUserBySit(p__1);
			var l__6:Number = l__5.nChips;
			l__5.nOldChips = l__6;
			l__5.nChips = p__2;
			l__5.nCurBet = p__3;
			l__5.sStatusText = p__4;
			
		}
		public function muteToggle(p__1:String, p__2:String):void
		{
			if ((p__2) == "add"){
				addMuteZid(p__1);
			} else if ((p__2) == "remove"){
				removeMuteZid(p__1);
			}
		}
		public function addMuteZid(p__1:String):void
		{
			var l__2:* = undefined;
			for (l__2 in aBlockedUsers){
				if ((p__1) == aBlockedUsers[l__2]){
					return;
				}
			}
			aBlockedUsers.push(p__1);
		}
		public function removeMuteZid(p__1:String):void
		{
			var l__2:* = undefined;
			for (l__2 in aBlockedUsers){
				if ((p__1) == aBlockedUsers[l__2]){
					aBlockedUsers.splice(l__2, 1);
				}
			}
		}
		public function isUserMuted(p__1:String):Boolean
		{
			var l__2:* = undefined;
			for (l__2 in aBlockedUsers){
				if ((p__1) == aBlockedUsers[l__2]){
					return(true);
				}
			}
			return(false);
		}
		public function updateUsersInRoom(p__1:Array):void
		{
			aUsersInRoom = p__1;
		}
		public function updateUsersWaiting(p__1:Array):void
		{
			aUsersWaiting = p__1;
		}
		public function updateUserTotal(p__1:int, p__2:Number, p__3:Number):void
		{
			var l__4:com.script.poker.PokerUser = getUserBySit(p__1);
			var l__5:Number = l__4.nChips;
			l__4.nOldChips = l__5;
			l__4.nChips = p__2;
			l__4.nTotalPoints = p__3;
		}
		public function getRankName(p__1:Number):String
		{
			return(aRankNames[p__1]);
		}
		public function getTotalPlayers():Number
		{
			return(aUsers.length);
		}
		public function getPlayerChips(p__1:String):Number
		{
			var l__2:com.script.poker.PokerUser = getUserByZid(p__1);
			return(l__2.nChips);
		}
		public function getPlayerTotalChips(p__1:String):Number
		{
			var l__2:com.script.poker.PokerUser = getUserByZid(p__1);
			return(l__2.nTotalPoints);
		}
	}
}