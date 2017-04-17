// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.script.poker.table.asset.chips.*;
	public class ChipController
	{
		public var aPots:Array = new Array();
		public var mainPotX:int = 390;
		private var aChipCoorData:Array = [[220, 224], [220, 174], [292, 114], [470, 114], [544, 174], [544, 224], [490, 270], [380, 270], [273, 270]];
		public var aChickletCoorData:Array;
		public var chipStackObjects:Array = new Array();
		public var totalPotAmt:Number = 0;
		public var totalPotCount:int;
		private var mt:com.script.poker.table.TableView;
		

		private var aPotCoords:Array = [[380, 232], [295, 232], [465, 232], [332, 153], [434, 153], [344, 250], [424, 250], [380, 141]];
		//private var aPotCoords:Array = [[380, 165], [332, 176], [434, 176], [332, 176], [434, 176], [344, 285], [424, 285], [380, 165]];
		
		
		private var cont:flash.display.MovieClip;
		public var mainPotY:int = 272;
		public function ChipController(p__1:com.script.poker.table.TableView = null)
		{
			mt = p__1;
			aChickletCoorData = mt.aChickletCoorData;
			cont = mt.chipCont;
			cont.x = cont.y = 0;
		}
		public function clearChips():void
		{
			clearAllUserChips();
			clearAllPots();
		}
		public function leaveTable():void
		{
			var l__2:com.script.poker.table.asset.chips.ChipStack;
			var l__1:int;
			while(cont.numChildren > 0){
				if (cont.getChildAt(0) is ChipStack){
					l__2 = ChipStack(cont.getChildAt(0));
					cont.removeChildAt(l__1);
					l__2 = null;
				} else {
					cont.removeChildAt(l__1);
				}
			}
			mainPot = null;
			chipStackObjects = [];
		}
		public function clearAllUserChips():void
		{
			var l__1:* = undefined;
			var l__2:com.script.poker.table.asset.chips.ChipStack;
			for (l__1 in chipStackObjects){
				l__2 = ChipStack(chipStackObjects[l__1].theStack);
				cont.removeChild(l__2);
				l__2 = null;
			}
			chipStackObjects.length = 0;
		}
		public function clearAllPots():void
		{
			var l__1:* = undefined;
			var l__2:com.script.poker.table.asset.chips.ChipStack;
			for (l__1 in aPots){
				l__2 = ChipStack(aPots[l__1].chips);
				cont.removeChild(l__2);
				l__2 = null;
			}
			aPots.length = 0;
		}
		public function makeChipsFromPlayer(p__1:int, p__2:Number, p__3:String = "pile"):void
		{
			var l__4:com.script.poker.table.asset.chips.ChipStack = new ChipStack(p__2, p__3, aChipCoorData[p__1][0], aChipCoorData[p__1][1], aChickletCoorData[p__1][0], aChickletCoorData[p__1][1], false);
			l__4.mouseEnabled = false;
			l__4.mouseChildren = false;
			var l__5:Object = new Object();
			l__5.theStack = l__4;
			l__5.theSit = p__1;
			chipStackObjects.push(l__5);
			cont.addChildAt(l__4, 0);
			
		}
		public function updateChipsFromPlayer(p__1:int, p__2:Number, p__3:String):void
		{
			var l__5:* = undefined;
			var l__6:Number = 0;
			var l__7:com.script.poker.table.asset.chips.ChipFlury;
			var l__4:Boolean;
			for (l__5 in chipStackObjects){
				l__6 = 0;
				l__7 = null;
				if ((p__1) == chipStackObjects[l__5].theSit){
					if ((p__3) == "raise"){
						l__6 = (p__2 - chipStackObjects[l__5].theStack.stackVal);
						l__7 = new ChipFlury(l__6, aChipCoorData[p__1][0], aChipCoorData[p__1][1], aChickletCoorData[p__1][0], aChickletCoorData[p__1][1], false, 0, 0.1);
						cont.addChild(l__7);
						chipStackObjects[l__5].theStack.updateChips(p__2, 0.33);
					} else if ((((p__3) == "check") || ((p__3) == "allin")) || ((p__3) == "call")){
						if ((p__2) > 0){
							l__6 = (p__2 - chipStackObjects[l__5].theStack.stackVal);
							l__7 = new ChipFlury(l__6, aChipCoorData[p__1][0], aChipCoorData[p__1][1], aChickletCoorData[p__1][0], aChickletCoorData[p__1][1], false, 0, 0.1);
							cont.addChild(l__7);
							chipStackObjects[l__5].theStack.updateChips(p__2, 0.2);
						}
					}
					l__4 = true;
				}
			}
			if (!l__4){
				makeChipsFromPlayer(p__1, p__2);
			}
		}
		public function pushChipStacksToPot():void
		{
			var l__1:* = undefined;
			mt.statusCleanup();
			for (l__1 in chipStackObjects){
				chipStackObjects[l__1].theStack.chipsToPot(mainPotX, mainPotY, 1);
			}
			chipStackObjects.length = 0;
		}
		public function makePot(p__1:int, p__2:Number, p__3:Boolean, p__4:Boolean = false):void
		{
			var l__6:Object;
			var l__7:* = undefined;
			var l__8:String;
			var l__9:com.script.poker.table.asset.chips.ChipStack;
			if ((p__1) == 0){
				pushChipStacksToPot();
			}
			var l__5:Boolean;
			for (l__7 in aPots){
				if (aPots[l__7].id == (p__1)){
					l__5 = true;
					l__6 = aPots[l__7];
				}
			}
			if (l__5){
				if (l__6.amt != (p__2)){
					l__6.chips.updateChips(p__2, 1.5);
					l__6.amt = p__2;
				}
			} else if (!l__5){
				l__8 = "stackUp";
				if (p__4){
					l__8 = "instant";
				}
				l__9 = new ChipStack(p__2, l__8, aPotCoords[p__1][0], aPotCoords[p__1][1], 0, 0, true, 25, 5, 1.5, p__4);
				l__9.mouseEnabled = false;
				l__9.mouseChildren = false;
				cont.addChild(l__9);
				l__6 = new Object();
				l__6.id = p__1;
				l__6.amt = p__2;
				l__6.chips = l__9;
				aPots.push(l__6);
			}
		}
		public function clearPot():void
		{
			mainPot.dissolveChips();
		}
		public function payoutChips(p__1:int, p__2:int, p__3:Number, p__4:Number = 0):void
		{
			var l__5:Number = 0;
			var l__6:com.script.poker.table.asset.chips.ChipFlury;
			if ((p__3) == -1){
				l__5 = aPots[p__2].amt;
			} else {
				l__5 = p__3;
			}
			if (l__5 > 0){
				l__6 = new ChipFlury(l__5, aChickletCoorData[p__1][0], aChickletCoorData[p__1][1] - 20, aPotCoords[p__2][0], aPotCoords[p__2][1], true, p__4);
				l__6.mouseEnabled = false;
				l__6.mouseChildren = false;
				cont.addChild(l__6);
				dissolvePot(p__2);
			}
			if ((p__2) == 0){
				clearChips();
			}
		}
		public function dissolvePot(p__1:int):void
		{
			var l__2:* = undefined;
			var l__3:com.script.poker.table.asset.chips.ChipStack;
			for (l__2 in aPots){
				if ((p__1) == aPots[l__2].id){
					l__3 = ChipStack(aPots[l__2].chips);
					l__3.dissolveChips();
					aPots.splice(l__2, 1);
				}
			}
		}
		public function sendChips(p__1:Number, p__2:int, p__3:int):void
		{
			var l__4:com.script.poker.table.asset.chips.ChipGift = new ChipGift(p__1, aChickletCoorData[p__3][0], aChickletCoorData[p__3][1], aChickletCoorData[p__2][0], aChickletCoorData[p__2][1]);
			cont.addChild(l__4);
		}
	}
}