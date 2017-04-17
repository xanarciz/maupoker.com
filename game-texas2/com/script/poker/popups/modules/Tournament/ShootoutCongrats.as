// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.Tournament
{
	import flash.events.*;
	import com.script.format.*;
	import com.script.poker.popups.modules.events.*;
	import flash.display.*;
	import flash.text.*;
	public class ShootoutCongrats extends flash.display.MovieClip
	{
		public var bg:flash.display.MovieClip;
		public var bFacebook:Boolean = false;
		public var tfYouWon:flash.text.TextField;
		public var thisTotalRounds:Number;
		public var thisPlace:Number;
		public var feedCheck:flash.display.MovieClip;
		public var thisRound:Number;
		public var mcRound2:flash.display.MovieClip;
		public var mcRound3:flash.display.MovieClip;
		public var mcWinChips:flash.display.MovieClip;
		public var wsopBadge:flash.display.MovieClip;
		public var bFeed:Boolean = false;
		public var mcRound1:flash.display.MovieClip;
		public var thisChips:Number;
		public var text:String;
		public var pipe:* = true;
		public var btnSignUpWSOP:*;
		public var btnBackToLobby:*;
		public var field:flash.text.TextField;
		public function ShootoutCongrats()
		{
			stop();
			bg.stop();
			mcRound1.stop();
			mcRound2.stop();
			mcRound3.stop();
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.myriad;
			feedCheck.buttonMode = true;
			toggleCheck();
			initListeners();
		}
		private function initListeners():void
		{
			feedCheck.addEventListener(flash.events.MouseEvent.CLICK, toggleCheck);
			btnBackToLobby.addEventListener(flash.events.MouseEvent.CLICK, sendFeedReq);
		}
		private function removeListeners():void
		{
			feedCheck.removeEventListener(flash.events.MouseEvent.CLICK, toggleCheck);
			btnBackToLobby.removeEventListener(flash.events.MouseEvent.CLICK, sendFeedReq);
		}
		private function toggleCheck(p__1:flash.events.MouseEvent = null):void
		{
			bFeed = !bFeed;
			feedCheck.onState.visible = bFeed;
		}
		private function sendFeedReq(p__1:flash.events.MouseEvent = null):void
		{
			var l__2:Boolean = isWinner(thisRound, thisPlace, thisChips);
			if ((l__2 && bFacebook) && bFeed){
				dispatchEvent(new com.script.poker.popups.modules.events.ShootoutCongratsEvent(com.script.poker.popups.modules.events.ShootoutCongratsEvent.SHOOTOUT_FEED_PUBLISH, thisRound, thisTotalRounds, thisChips, thisPlace));
			}
		}
		public function showFeedOption()
		{
			feedCheck.visible = false;
			if (bFacebook && (thisChips > 0)){
				feedCheck.onState.visible = true;
				feedCheck.visible = true;
				bFeed = true;
			}
		}
		public function showCongrats(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Array, p__6:Number)
		{
			mcRound1.visible = true;
			mcRound2.visible = true;
			mcRound3.visible = true;
			thisPlace = p__3;
			thisChips = p__4;
			thisRound = p__1;
			thisTotalRounds = p__6;
			if (isWinner(p__1, p__3, p__4)){
				tfYouWon.text = ("You won " + p__4);
				gotoAndStop(1);
			} else {
				tfYouWon.text = "";
				gotoAndStop(2);
			}
			var l__7:Number = p__5[(p__6) - 1][0];
			mcWinChips.tfWinChips.text = ("" + com.script.format.StringUtility.StringToMoney(l__7));
			mcRound2.mcStarLock.visible = true;
			mcRound3.mcStarLock.visible = true;
			switch(p__1){
				case 1:
				{
					mcRound1.tfPlace.text = (("" + com.script.format.StringUtility.GetOrdinal(p__3)) + "\nPLACE");
					mcRound1.gotoAndStop(2);
					mcRound2.tfPlace.text = "";
					if ((p__3) == 1){
						mcRound1.gotoAndStop(1);
						mcRound2.tfEligible.text = "YOU ARE\nELIGIBLE\nTO ENTER";
						mcRound2.gotoAndStop(2);
						mcRound2.mcStarLock.visible = false;
					} else {
						mcRound1.gotoAndStop(2);
						mcRound2.tfEligible.text = "";
						mcRound2.gotoAndStop(1);
					}
					mcRound3.tfPlace.text = "";
					mcRound3.tfEligible.text = "";
					mcRound3.gotoAndStop(1);
					btnBackToLobby.visible = true;
					btnBackToLobby.x = 207;
					btnSignUpWSOP.visible = false;
					bg.gotoAndStop(p__1);
					break;
				}
				case 2:
				{
					mcRound1.tfPlace.text = "1st\nPLACE";
					mcRound1.gotoAndStop(1);
					mcRound2.tfPlace.text = (("" + com.script.format.StringUtility.GetOrdinal(p__3)) + "\nPLACE");
					mcRound2.tfEligible.text = "";
					mcRound2.gotoAndStop(2);
					mcRound2.mcStarLock.visible = false;
					mcRound3.tfPlace.text = "";
					if ((p__3) == 1){
						mcRound3.tfEligible.text = "YOU ARE\nELIGIBLE\nTO ENTER";
						mcRound3.gotoAndStop(2);
						mcRound3.mcStarLock.visible = false;
						mcRound1.gotoAndStop(1);
						mcRound2.gotoAndStop(1);
					} else {
						mcRound3.tfEligible.text = "";
						mcRound3.gotoAndStop(1);
					}
					btnBackToLobby.visible = true;
					btnBackToLobby.x = 207;
					btnSignUpWSOP.visible = false;
					bg.gotoAndStop(p__1);
					break;
				}
				case 3:
				{
					mcRound2.mcStarLock.visible = false;
					mcRound3.mcStarLock.visible = false;
					if ((p__3) == 1){
						mcWinChips.visible = false;
						mcRound1.visible = false;
						mcRound2.visible = false;
						mcRound3.visible = false;
						bg.gotoAndStop(p__1 + 1);
					} else {
						mcRound1.tfPlace.text = "1st\nPLACE";
						mcRound1.gotoAndStop(1);
						mcRound2.tfPlace.text = "1st\nPLACE";
						mcRound2.tfEligible.text = "";
						mcRound2.gotoAndStop(1);
						mcRound3.tfPlace.text = (("" + com.script.format.StringUtility.GetOrdinal(p__3)) + "\nPLACE");
						mcRound3.tfEligible.text = "";
						mcRound3.gotoAndStop(2);
						bg.gotoAndStop(p__1);
					}
					btnBackToLobby.visible = true;
					btnBackToLobby.x = 207;
					btnSignUpWSOP.visible = false;
					if (thisPlace == 1){
						btnSignUpWSOP.visible = true;
						btnBackToLobby.x = 300;
					}
					break;
				}
			}
			showFeedOption();
		}
		public function isWinner(p__1:Number, p__2:Number, p__3:Number):Boolean
		{
			switch(p__1){
				case 1:
				{
					if ((((p__2) >= 1) && ((p__2) <= 3)) && ((p__3) > 0)){
						return(true);
					}
					break;
				}
				case 2:
				{
					if ((((p__2) >= 1) && ((p__2) <= 3)) && ((p__3) > 0)){
						return(true);
					}
					break;
				}
				case 3:
				{
					if ((((p__2) >= 1) && ((p__2) <= 5)) && ((p__3) > 0)){
						return(true);
					}
					break;
				}
			}
			return(false);
		}
	}
}