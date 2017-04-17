// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker
{
	import flash.display.*;
	import com.script.*;
	import com.script.poker.table.asset.*;
	public class PokerUser extends com.script.User
	{
		public var nGiftId:int;
		public var sPicLrgURL:String = "";
		public var nBlind:Number = 0;
		public var sUserName:String;
		public var nSit:int;
		public var sOwner:int;
		public var sStatusText:String;
		public var aHandString:Array;
		public var sWinningHand:String;
		public var nAchievementRank:int;
		public var nRank:int;
		public var sNetwork:String;
		public var nCurBet:Number = 0;
		public var nCapabilities:int;
		public var nOldChips:Number = 0;
		public var nFirstTime:int;
		public var bIsVip:Boolean;
		public var aPotsWon:Array;
		public var sPicURL:String = "";
		public var sProfileURL:String;
		public var nProtoVersion:int;
		public var nChips:Number = 0;
		public var holecard1:com.script.poker.table.asset.CardData;
		public var nPlayLevel:int;
		public var holecard2:com.script.poker.table.asset.CardData;
		public var nHideGifts:int;
		public var sClientType:String;
		public var nTotalPoints:Number = 0;
		public var sTourneyState:String;
		public var tJackpot:String;
		public var reSit:String;
		public var gJackpot:String;
		public var bJackpot:String;
		
		//public var jt:String;
		public function PokerUser(p__1:int, p__2:String, p__3:Number, p__4:String, p__5:String, p__6:Number, p__7:int, p__8:String, p__9:String, p__10:String, p__11:int, p__12:String, p__13:String, p__14:int, p__15:String, p__16:Number, p__17:int, p__18:int, p__19:int, p__20:int, p__21:String, p__22:int = 0, p__23:int = 0, p__24:Number = 0, p__25:String = "0", p__26:String = "0", p__27:Number = 0)
		{	
			
			super(p__5);
			nSit = p__1;
			sUserName = p__2;
			nChips = p__3;
			trace(nChips+"----"+sUserName);
			if ((p__4) != null){
				sPicURL = p__4;
			}
			nTotalPoints = p__6;
			nRank = p__7;
			sNetwork = p__8;
			sTourneyState = p__9;
			if ((p__10) != null){
				sPicLrgURL = p__10;
			}
			nAchievementRank = p__11;
			sProfileURL = p__13;
			nGiftId = p__14;
			nGiftType = -1;
			nGiftNum = -1;
			sStatusText = p__15;
			nCurBet = p__16;
			if ((p__17) == 1){
				bIsVip = true;
			} else {
				bIsVip = false;
			}
			nPlayLevel = p__18;
			nProtoVersion = p__19;
			nCapabilities = p__20;
			sClientType = p__21;
			nFirstTime = p__22;
			nHideGifts = p__23;
			tJackpot = p__24;
			reSit = p__25;
			bJackpot = p__26;
			
			
			gJackpot = p__27;
			
		}
	}
}