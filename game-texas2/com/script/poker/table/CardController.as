// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.display.MovieClip;
	import com.script.poker.PokerUser;
	import com.script.poker.table.asset.Card;
	import com.script.poker.table.asset.CardArt;
	import caurina.transitions.*;
	public class CardController
	{
		private var aFixedCards:Array;
		private var aVisibleCards:Array;
		private var bFirstInit:Boolean = true;
		private var oDefaultPos:Object;
		private var mt:com.script.poker.table.TableView;
		public var dummyCards:Array = new Array();
		public var masterCoords:Array;
		public var nDealCount:int = 0;
		private var aChickletCoorData:Array;
		public var dummyRots:Array = [50, 120, 170, -170, -120, -50,-5, 0, 5];
		private var aSuitMap:Array;
		public var dummySpots:Array = [[200, 261], [200, 189], [281, 150], [486, 148], [567.45, 191.7], [577.45, 265.25], [496, 298], [380.25, 298], [264, 298]];
		private var nDepth:Number = 0;
		private var aAnimCards:Array;
		public var dummyCont:flash.display.MovieClip;
		public function CardController(p__1:com.script.poker.table.TableView)
		{	
			mt = p__1;
			dummyCont = mt.dummyCards;
			aChickletCoorData = mt.aChickletCoorData;
			aFixedCards = new Array("newcard00", "newcard01", "newcard10", "newcard11", "newcard20", "newcard21", "newcard30", "newcard31", "newcard40", "newcard41", "newcard50", "newcard51", "newcard60", "newcard61", "newcard70", "newcard71", "newcard80", "newcard81", "comcard0", "comcard1", "comcard2", "comcard3", "comcard4");
			masterCoords = [{x:131.6, y:438.2}, {x:169.15, y:438.2}, {x:131.6, y:267.65}, {x:169.15, y:267.65}, {x:307.75, y:150.35}, {x:345.3, y:150.35}, {x:798.75, y:150}, {x:836.2, y:150}, {x:964, y:277.7}, {x:1001, y:277.7}, {x:964, y:439.2}, {x:1001.85, y:439.2}, {x:819.7, y:540}, {x:857.2, y:540}, {x:627, y:540}, {x:664.55, y:540}, {x:287.75, y:540}, {x:325.3, y:540}, {x:450, y:353}, {x:510, y:353}, {x:570, y:353}, {x:630, y:353}, {x:690.6, y:353}];
			aSuitMap = new Array("diamond", "heart", "spade", "club");
			aAnimCards = new Array();
			aVisibleCards = new Array();
		}
		
		public function initCards():void
		{
			var l__1:com.script.poker.table.asset.Card;
			var l__2:Number = 0;
			l__2 = 0;
			while(l__2 < aFixedCards.length){
				l__1 = mt[aFixedCards[l__2]];
				l__1.visible = false;
				l__1.mouseEnabled = false;
				l__1.mouseChildren = false;
				
				if (!bFirstInit){
					l__1.x = masterCoords[l__2].x;
					l__1.y = masterCoords[l__2].y;
				}
				l__1.showBack();
				l__1.rotation = 0;
				l__1.alpha = 0;
				l__1.isFlip = false;
				l__2++;
			}
			bFirstInit = false;
			nDealCount = 0;
		}
		private function getSuit(p__1:Number):String
		{
			return(aSuitMap[p__1]);
		}
		private function getCardNum(p__1:String):String
		{
			if ((p__1) == "11"){
				return("J");
			}
			if ((p__1) == "12"){
				return("Q");
			}
			if ((p__1) == "13"){
				return("K");
			}
			if ((p__1) == "14"){
				return("A");
			}
			return(p__1);
		}
		public function clearCards():void
		{
			var l__2:* = undefined;
			var l__1:int = (((mt.ptModel.nDealerSit + 1)) % 9);
			for (l__2 in aFixedCards){
				mt[aFixedCards[l__2]].visible = false;
				mt[aFixedCards[l__2]].rotation = 0;
				mt[aFixedCards[l__2]].alpha = 0;
				mt[aFixedCards[l__2]].x = masterCoords[l__2].x;
				mt[aFixedCards[l__2]].y = masterCoords[l__2].y;
				mt[aFixedCards[l__2]].showBack();
			}
			aVisibleCards = [];
			nDepth = 0;
			clearDummyCards();
		}
		public function showPlayerCards(p__1:int):void
		{
			var l__2:com.script.poker.PokerUser = mt.ptModel.getUserBySit(p__1);
			var l__3:com.script.poker.PokerUser = mt.ptModel.getUserByZid(mt.ptModel.viewer.zid);
			dealDummyCard(p__1, false);
			var l__4:* = (("newcard" + p__1) + "0");
			var l__5:* = (("newcard" + p__1) + "1");
			mt[l__4].showBack();
			mt[l__5].showBack();
			mt[l__4].alpha = 1;
			mt[l__5].alpha = 1;
			if (l__3 == l__2){
				mt[l__4].visible = true;
				mt[l__5].visible = true;
			} else {
				mt[l__4].visible = false;
				mt[l__5].visible = false;
			}
			mt[l__4].addShadow();
			mt[l__5].addShadow();
			var l__6:Number = 0.75;
			mt[l__4].scaleX = mt[l__4].scaleY = l__6;
			mt[l__5].scaleX = mt[l__5].scaleY = l__6;
			addVisibleCards(l__4);
			addVisibleCards(l__5);
		}
		public function clearPlayerCards(p__1:int):void
		{
			var l__2:* = (("newcard" + p__1) + "0");
			var l__3:* = (("newcard" + p__1) + "1");
			mt[l__2].visible = false;
			mt[l__2].alpha = 1;
			mt[l__2].x = masterCoords[(p__1) * 2].x;
			mt[l__2].y = masterCoords[(p__1) * 2].y;
			mt[l__2].showBack();
			mt[l__3].visible = false;
			mt[l__3].alpha = 1;
			mt[l__3].x = masterCoords[((p__1) * 2 + 1)].x;
			mt[l__3].y = masterCoords[((p__1) * 2 + 1)].y;
			mt[l__3].showBack();
		}
		public function getPlayerCardSuit(p__1:int, p__2:Number):String
		{
			return(mt[((("newcard" + p__1) + "") + p__2)].thisSuit);
		}
		public function getPlayerCardNumber(p__1:int, p__2:Number):String
		{
			return(mt[((("newcard" + p__1) + "") + p__2)].thisNumber);
		}
		public function clearCommCards(p__1:Number):void
		{
			mt[("comcard" + p__1)].visible = false;
		}
		public function getCommCardSuit(p__1:Number):String
		{
			return(mt[("comcard" + p__1)].thisSuit);
		}
		public function getCommCardNumber(p__1:Number):String
		{
			return(mt[("comcard" + p__1)].thisNumber);
		}
		public function dealCard(p__1:int, p__2:Boolean, p__3:String, p__4:Number):void
		{
			if (p__1 == -1){
				nDepth++;
				nDealCount++;
				return;
			}
			var l__7:Number = 0;
			var l__5:com.script.poker.PokerUser = mt.ptModel.getUserBySit(p__1);
			var l__6:com.script.poker.PokerUser = mt.ptModel.getUserByZid(mt.ptModel.viewer.zid);
			if (p__2){
				l__7 = 1;
			} else {
				l__7 = 0;
				dealDummyCard(p__1, true);
			}
			var l__8:* = ((("newcard" + p__1) + "") + l__7);
			mt[l__8].showBack();
			if ((p__4) > -1){
				mt[l__8].init(getSuit(p__4), getCardNum(p__3));
				mt[l__8].addShadow();
				mt[l__8].flipCard();
			}
			var l__9:Number = 0.75;
			var l__10:int;
			//mt[l__8].scaleX = mt[l__8].scaleY = l__9;
			mt[l__8].alpha = 1;
			mt[l__8].visible = false;
			if (l__6 == l__5){
				mt[l__8].visible = true;
			}
			addVisibleCards(l__8);
			nDepth++;
			nDealCount++;
		}
		public function replayDeal(p__1:int, p__2:String, p__3:Number, p__4:String, p__5:Number):void
		{
			var l__6:com.script.poker.PokerUser = mt.ptModel.getUserBySit(p__1);
			var l__7:com.script.poker.PokerUser = mt.ptModel.getUserByZid(mt.ptModel.viewer.zid);
			dealDummyCard(p__1, false);
			var l__8:* = (("newcard" + p__1) + "0");
			var l__9:* = (("newcard" + p__1) + "1");
			
			mt[l__8].init(getSuit(p__3), getCardNum(p__2));
			mt[l__9].init(getSuit(p__5), getCardNum(p__4));
			mt[l__8].showFace();
			mt[l__9].showFace();
			mt[l__8].scaleX = mt[l__8].scaleY = 0.75;
			mt[l__9].scaleX = mt[l__9].scaleY = 0.75;
			mt[l__9].rotation = 0;
			mt[l__8].addShadow();
			mt[l__9].addShadow();
			mt[l__8].alpha = 1;
			mt[l__9].alpha = 1;
			if (l__7 == l__6){
				mt[l__8].visible = true;
				mt[l__9].visible = true;
				if (l__7.sStatusText == "fold"){
					dimPlayerCards(p__1);
				}
			} else {
				mt[l__8].visible = false;
				mt[l__9].visible = false;
			}
			addVisibleCards(l__8);
			addVisibleCards(l__9);
		}
		public function dealFlop(p__1:String, p__2:Number, p__3:String, p__4:Number, p__5:String, p__6:Number, p__7:Boolean):void
		{
			var l__9:String;
			var l__8:Number = 0.25;
			var l__10:Object = {card0:p__1, suit0:p__2, card1:p__3, suit1:p__4, card2:p__5, suit2:p__6};
			var l__11:Number = 0;
			while(l__11 < 3){
				l__9 = ("comcard" + l__11);
				mt[l__9].init(getSuit(l__10[("suit" + l__11)]), getCardNum(l__10[("card" + l__11)]));
				if (!(p__7)){
					mt[l__9].x = 380;
					mt[l__9].y = 75;
					mt[l__9].showBack();
					mt[l__9].flopCard(masterCoords[(l__11 + 18)].x, masterCoords[(l__11 + 18)].y, l__8 * l__11);
				} else {
					mt[l__9].showFace();
					mt[l__9].flopCard(masterCoords[(l__11 + 18)].x, masterCoords[(l__11 + 18)].y, 0, true);
				}
				mt[l__9].visible = true;
				addVisibleCards(l__9);
				l__11++;
			}
		}
		public function dealComCard(p__1:String, p__2:Number, p__3:Number, p__4:Boolean = false):void
		{
			var l__5:String = ("comcard" + (p__3).toString());
			mt[l__5].init(getSuit(p__2), getCardNum(p__1));
			if (!(p__4)){
			
				mt[l__5].x = 380;
				mt[l__5].y = 75;
				mt[l__5].showBack();
				mt[l__5].moveCard(masterCoords[(p__3 + 18)].x, masterCoords[(p__3 + 18)].y, false, l__5, 0);
				mt[l__5].flipCard();
			} else {
			
				mt[l__5].showFace();
				mt[l__5].x = masterCoords[(p__3 + 18)].x;
				mt[l__5].y = masterCoords[(p__3 + 18)].y;
				mt[l__5].flopCard(masterCoords[(p__3 + 18)].x, masterCoords[(p__3 + 18)].y, 0, true);
			}
			mt[l__5].visible = true;
			addVisibleCards(l__5);
		}
		public function showWinningHand(p__1:int, p__2:String, p__3:Number, p__4:String, p__5:Number):void
		{
			var l__6:* = (("newcard" + p__1) + "0");
			var l__7:* = (("newcard" + p__1) + "1");
			mt[l__6].init(getSuit(p__3), getCardNum(p__2));
			mt[l__7].init(getSuit(p__5), getCardNum(p__4));
			if (!mt[l__6].isUp){
				mt[l__6].visible = true;
				mt[l__7].visible = true;
				mt[l__6].flipCard();
				mt[l__7].flipCard();
				addVisibleCards(l__6);
				addVisibleCards(l__7);
			}
		}
		public function showWinningCards(p__1:int, p__2:Boolean, p__3:Boolean, p__4:Boolean, p__5:Boolean, p__6:Boolean, p__7:Boolean, p__8:Boolean):void
		{
			var l__9:* = undefined;
			var l__10:String;
			var l__11:String;
			var l__12:String;
			var l__13:String;
			var l__14:String;
			var l__15:String;
			var l__16:String;
			for (l__9 in aFixedCards){
				mt[aFixedCards[l__9]].x = masterCoords[l__9].x;
				mt[aFixedCards[l__9]].y = masterCoords[l__9].y;
				mt[aFixedCards[l__9]].alpha = 0.5;
			}
			l__10 = (("newcard" + p__1) + "0");
			l__11 = (("newcard" + p__1) + "1");
			l__12 = "comcard0";
			l__13 = "comcard1";
			l__14 = "comcard2";
			l__15 = "comcard3";
			l__16 = "comcard4";
			if (p__2){
				highlightCard(l__10);
			}
			if (p__3){
				highlightCard(l__11);
			}
			if (p__4){
				highlightCard(l__12);
			}
			if (p__5){
				highlightCard(l__13);
			}
			if (p__6){
				highlightCard(l__14);
			}
			if (p__7){
				highlightCard(l__15);
			}
			if (p__8){
				highlightCard(l__16);
			}
		}
		public function highlightCard(p__1:String):void
		{
			mt[p__1].addShadow();
			mt[p__1].visible = true;
			Tweener.addTween(mt[p__1], {alpha:1, y:(mt[p__1].y - 10), time:0.33, transition:"easeOutSine"});
		}
		public function foldPlayerCards(p__1:int):void
		{
			var l__2:* = (("newcard" + p__1) + "0");
			var l__3:* = (("newcard" + p__1) + "1");
			mt[l__2].foldCard();
			mt[l__3].foldCard();
		}
		public function dimPlayerCards(p__1:int):void
		{
			var l__2:* = (("newcard" + p__1) + "0");
			var l__3:* = (("newcard" + p__1) + "1");
			mt[l__2].alpha = 0.5;
			mt[l__3].alpha = 0.5;
		}
		public function addVisibleCards(p__1:String):void
		{
			var l__2:* = undefined;
			if (aVisibleCards.length > 0){
				l__2 = 0;
				while(l__2 < aVisibleCards.length){
					if ((p__1) == aVisibleCards[l__2]){
						return;
					}
					l__2++;
				}
				aVisibleCards.push(p__1);
			} else {
				aVisibleCards.push(p__1);
			}
		}
		public function dealDummyCard(p__1:int, p__2:Boolean):void
		{
			var l__3:com.script.poker.table.asset.CardArt = new CardArt();
			l__3.scaleX = l__3.scaleY = 0.4;
			l__3.x = 380;
			l__3.y = 75;
			l__3.alpha = 0;
			l__3.rotation = 90;
			dummyCont.addChild(l__3);
			var l__4:Object = new Object();
			l__4.card = l__3;
			l__4.sit = p__1;
			dummyCards.push(l__4);
			if (p__2){
				Tweener.addTween(l__3, {x:dummySpots[p__1][0], y:dummySpots[p__1][1], alpha:1, rotation:dummyRots[p__1], time:0.33, transition:"easeOutSine"});
			} else {
				l__3.x = dummySpots[p__1][0];
				l__3.y = dummySpots[p__1][1];
				l__3.alpha = 1;
				l__3.rotation = dummyRots[p__1];
			}
		}
		public function foldDummyCard(p__1:int):void
		{
			var l__2:* = undefined;
			var l__3:int;
			for (l__2 in dummyCards){
				if ((p__1) == dummyCards[l__2].sit){
					l__3 = Math.round(180 - (Math.random() * 360));
					Tweener.addTween(dummyCards[l__2].card, {x:380, y:75, alpha:0, rotation:l__3, time:0.33, transition:"easeOutSine", onComplete:killDummy, onCompleteParams:[p__1]});
				}
			}
		}
		public function killDummy(p__1:int):void
		{
			var l__2:* = undefined;
			dummyCards.sortOn("sit");
			for (l__2 in dummyCards){
				if ((p__1) == dummyCards[l__2].sit){
					dummyCont.removeChild(dummyCards[l__2].card);
					dummyCards[l__2].card = null;
					dummyCards.splice(l__2, 1);
				}
			}
		}
		public function clearDummyCards():void
		{
			var l__2:com.script.poker.table.asset.CardArt;
			dummyCards = [];
			var l__1:int;
			while(dummyCont.numChildren > 0){
				l__2 = dummyCont.getChildAt(0);
				dummyCont.removeChild(l__2);
				l__2 = null;
			}
		}
	}
}