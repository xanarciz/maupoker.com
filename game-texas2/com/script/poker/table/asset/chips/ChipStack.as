// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.chips
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import caurina.transitions.*;
	public class ChipStack extends flash.display.Sprite
	{
		public var cont:flash.display.Sprite;
		public var theLabel:com.script.poker.table.asset.chips.ChipLabel;
		public var stack:flash.display.Sprite;
		public var numStacks:Number = 0;
		public var bPot:Boolean;
		private var actChipsArray:Array;
		private var doneCount:int = 0;
		public var col1:flash.display.Sprite;
		public var col4:flash.display.Sprite;
		public var col5:flash.display.Sprite;
		public var col2:flash.display.Sprite;
		public var col3:flash.display.Sprite;
		public var numChips:Number = 0;
		private var chip:com.script.poker.table.asset.chips.Chip;
		public var stackY:Number = 0;
		public var addStr:String;
		public var stackX:Number = 0;
		private var stackCount:Number = 0;
		public var skipChips:Number = 0;
		private var allChipsArray:Array;
		public var stackVal:Number = 0;
		private var pileCount:Number = 0;
		public function ChipStack(p__1:Number, p__2:String, p__3:Number, p__4:Number, p__5:Number = 0, p__6:Number = 0, p__7:Boolean = false, p__8:Number = 15, p__9:Number = 5, p__10:Number = 0, p__11:Boolean = false)
		{
			bPot = p__7;
			stackX = p__3;
			stackY = p__4;
			stackVal = p__1;
			stack = new Sprite();
			addChild(stack);
			cont = new Sprite();
			stack.addChild(cont);
			stack.x = stackX;
			stack.y = stackY;
			addStr = "";
			var l__12:uint = 65280;
			var l__13:uint;
			if (p__7){
				l__12 = 0;
				l__13 = 16777215;
			}
			theLabel = new ChipLabel(p__1, bPot, l__12, addStr, l__13);
			theLabel.x = 0;
			theLabel.y = 28;
			theLabel.alpha = 0;
			stack.addChild(theLabel);
			init(p__1, p__2, p__3, p__4, p__5, p__6, p__8, p__9, p__10, p__11);
		}
		public function init(inNum:Number, style:String, endX:Number, endY:Number, startX:Number, startY:Number, chipLimit:Number, stackH:Number, addDelay:Number, inNum0:Boolean)
		{
			var inPileCount:Number = 0;
			var inPile = undefined;
			var rot:Number = 0;
			var hit:Number = 0;
			var i:Number = 0;
			var stackChip = function(p__1:flash.display.DisplayObject, p__2:String)
			{
				var l__3:Object;
				var l__4:Number = 0;
				var l__5:Number = 0;
				var l__6:Number = 0;
				var l__7:Number = 0;
				var l__8:Number = 0;
				var l__9:int;
				if ((stackCount == 1) && !((p__2) == "pile")){
					Tweener.addTween(theLabel, {alpha:1, time:0.2, delay:addDelay, transition:"easeInOutSine"});
					/*if (bPot && (!inReplay)){
						theLabel.countUp(inNum, addStr);
					} else if (bPot && inReplay){
						theLabel.updater(inNum, addStr);
					}*/
					theLabel.countUp(inNum, addStr);//
				}
				if (stackCount <= chipLimit){
					switch(Math.ceil(stackCount / stackH)){
						case 1:
						{
							l__3 = col1;
							break;
						}
						case 2:
						{
							l__3 = col2;
							break;
						}
						case 3:
						{
							l__3 = col3;
							break;
						}
						case 4:
						{
							l__3 = col4;
							break;
						}
						case 5:
						{
							l__3 = col5;
							break;
						}
					}
					l__9 = 3;
					if ((p__2) == "stackDown"){
						cont.addChild(p__1);
						l__4 = ((0 - (((stackCount - 1) % stackH) * l__9)) + l__3.y);
						l__5 = (0 + l__3.x);
						p__1.y = ((l__4 - 25) + l__3.y);
						p__1.x = l__3.x;
						p__1.alpha = 0;
						l__6 = (((stackCount - 1) % stackH) / 25 + addDelay);
						l__8 = 0.25;
						Tweener.addTween(p__1, {alpha:1, x:l__5, y:l__4, time:l__8, delay:l__6, transition:"easeIn"});
					} else if ((p__2) == "stackUp"){
						cont.addChild(p__1);
						l__4 = ((0 - (((stackCount - 1) % stackH) * l__9)) + l__3.y);
						p__1.y = (l__4 + 5);
						p__1.x = l__3.x;
						p__1.alpha = 0;
						l__6 = (((stackCount - 1) % stackH) / 20 + addDelay);
						Tweener.addTween(p__1, {y:l__4, alpha:1, time:0.2, delay:l__6, transition:"easeOutSine"});
					} else if ((p__2) == "instant"){
						theLabel.alpha = 1;
						cont.addChild(p__1);
						l__4 = ((0 - (((stackCount - 1) % stackH) * l__9)) + l__3.y);
						p__1.y = l__4;
						p__1.x = l__3.x;
						p__1.alpha = 1;
					} else if ((p__2) == "pile"){
						l__5 = l__3.x;
						l__4 = (l__3.y + Math.round(0 - (((stackCount - 1) % stackH) * l__9)));
						l__6 = ((stackCount - 1) % stackH) / 20;
						l__7 = (Math.ceil(stackCount / stackH) / 7 + addDelay);
						l__6 = (l__6 + l__7);
						l__8 = 0.2;
						Tweener.addTween(p__1, {alpha:1, x:l__5, y:l__4, time:l__8, delay:l__6, transition:"easeIn"});
					}
					stackCount++;
				}
			};
			var pileChip = function(p__1:flash.display.DisplayObject)
			{
				var l__2:Number = 0;
				var l__3:Number = 0;
				var l__5:Number = 0;
				var l__6:Number = 0;
				if (pileCount == 0){
					Tweener.addTween(theLabel, {alpha:1, time:0.15, transition:"easeInOutSine"});
					if (bPot){
						theLabel.countUp();
					}
				}
				cont.addChild(p__1);
				p__1.alpha = 0;
				p__1.x = (startX - stackX);
				p__1.y = (startY - stackY);
				if (numChips == 1){
					l__2 = 0;
					l__3 = 11;
				} else {
					l__5 = ((Math.random() * 360) * Math.PI) / 180;
					l__6 = Math.random() * 20;
					l__2 = Math.round(Math.cos(l__5) * l__6);
					l__3 = Math.round(Math.sin(l__5) * l__6);
				}
				var l__4:Number = Math.ceil(pileCount / stackH) * 0.1;
				Tweener.addTween(p__1, {alpha:1, x:l__2, y:l__3, time:0.2, delay:pileCount / 100, transition:"easeOutSine", onComplete:inPile});
				pileCount++;
			};
			inPile = function()
			{
				inPileCount++;
				if (inPileCount == (numChips - skipChips)){
					sortChips();
				}
			};
			var sortChips = function()
			{
				var l__1:* = undefined;
				for (l__1 in actChipsArray){
					stackChip(actChipsArray[l__1], "pile");
				}
			};
			numChips = 0;
			numStacks = 0;
			skipChips = 0;
			stackCount = 1;
			pileCount = 0;
			if (allChipsArray == null){
				allChipsArray = new Array();
			}
			if (actChipsArray == null){
				actChipsArray = new Array();
			}
			if (allChipsArray.length > 0){
				allChipsArray.length = 0;
			}
			if (actChipsArray.length > 0){
				actChipsArray.length = 0;
			}
			var theChipValues:Array = ChipCalc.denominations;
			var chipQuan:Array = ChipCalc.quantity(inNum);
			var k:Number = 0;
			while(k < chipQuan.length){
				numChips = (numChips + chipQuan[k]);
				k++;
			}
			skipChips = (numChips - chipLimit);
			if (skipChips < 0){
				skipChips = 0;
			}
			numStacks = Math.ceil((numChips - skipChips) / stackH);
			
			if (numStacks < 5){
				switch(numStacks){
					case 1:
					{
						col1 = new Sprite();
						col1.y = 11;
						cont.addChild(col1);
						break;
					}
					case 2:
					{
						col1 = new Sprite();
						col1.x = -8;
						col1.y = 12;
						cont.addChild(col1);
						col2 = new Sprite();
						col2.x = 8;
						col2.y = 12;
						cont.addChild(col2);
						break;
					}
					case 3:
					{
						col1 = new Sprite();
						col1.x = -16;
						col1.y = 12;
						cont.addChild(col1);
						col2 = new Sprite();
						col2.x = 0;
						col2.y = 12;
						cont.addChild(col2);
						col3 = new Sprite();
						col3.x = 16;
						col3.y = 12;
						cont.addChild(col3);
						break;
					}
					case 4:
					{
						col1 = new Sprite();
						col1.x = -12;
						col1.y = -2;
						cont.addChild(col1);
						col2 = new Sprite();
						col2.x = 4;
						col2.y = -2;
						cont.addChild(col2);
						col3 = new Sprite();
						col3.x = -4;
						col3.y = 12;
						cont.addChild(col3);
						col4 = new Sprite();
						col4.x = 12;
						col4.y = 12;
						cont.addChild(col4);
						break;
					}
				}
			} else {
				col1 = new Sprite();
				col1.x = -8;
				col1.y = -2;
				cont.addChild(col1);
				col2 = new Sprite();
				col2.x = 8;
				col2.y = -2;
				cont.addChild(col2);
				col3 = new Sprite();
				col3.x = -16;
				col3.y = 12;
				cont.addChild(col3);
				col4 = new Sprite();
				col4.x = 0;
				col4.y = 12;
				cont.addChild(col4);
				col5 = new Sprite();
				col5.x = 16;
				col5.y = 12;
				cont.addChild(col5);
			}
			var j:Number = 0;
			while(j < chipQuan.length){
				rot = Math.floor(Math.random() * 60);
				hit = (chipQuan.length - (j + 1));
				i = 0;
				while(i < chipQuan[hit]){
					chip = new Chip(ChipGfx, ChipDecor, theChipValues[hit], (rot + (i * -7)));
					allChipsArray.push(chip);
					i++;
				}
				j++;
			}
			var m:Number = 0;
			while(m < (allChipsArray.length - skipChips)){
				if (((style == "stackDown") || (style == "stackUp")) || (style == "instant")){
					stackChip(allChipsArray[(m + skipChips)], style);
				} else if (style == "pile"){
					pileChip(allChipsArray[(m + skipChips)]);
				}
				actChipsArray.push(allChipsArray[(m + skipChips)]);
				m++;
			}
			inPileCount = 0;
		}
		
		public function chipsToPot(p__1:Number, p__2:Number, p__3:Number = 0)
		{
			var l__4:Number = p__1;
			var l__5:Number = p__2;
			theLabel.visible = false;
			Tweener.addTween(stack, {x:l__4, y:l__5, time:1, alpha:0, delay:p__3, transition:"easeOutSine", onComplete:dissolveChips});
		}
		public function dissolveChips()
		{
			var l__1:* = undefined;
			var l__2:flash.display.DisplayObject;
			var l__3:Number = 0;
			var l__4:Number = 0;
			for (l__1 in actChipsArray){
				l__2 = actChipsArray[l__1];
				l__3 = (4 - (l__1 % 5)) / 20;
				l__4 = Math.floor(l__1 / 5) / 20;
				l__3 = (l__3 + l__4);
				Tweener.addTween(l__2, {alpha:0, time:0.15, delay:l__3, onComplete:done});
			}
		}
		public function done()
		{
			doneCount++;
			if (doneCount == (numChips - skipChips)){
				Tweener.addTween(stack, {alpha:0, time:0.2, onComplete:killParent});
			}
		}
		public function killParent():void
		{
			if (this.parent != null){
				this.parent.removeChild(this);
			}
		}
		public function updateChips(inNum:Number, addDelay:Number = 0, inAddStr:String = "")
		{
			var updateCount:int;
			var updateTarget:int;
			var i:int;
			var targ:flash.display.DisplayObject;
			var delay:Number = 0;
			var delayOff:Number = 0;
			addStr = inAddStr;
			if (inNum != stackVal){
				stackVal = inNum;
				updateCount = 0;
				updateTarget = actChipsArray.length;
				if (inNum == 0){
				} else {
					var updateSeq = function():void
					{
						updateCount++;
						if (updateCount == updateTarget){
							if (bPot){
								init(inNum, "stackUp", stackX, stackY, 0, 0, 25, 5, 0, false);
							}
							if (!bPot){
								init(inNum, "stackUp", stackX, stackY, 0, 0, 15, 5, 0, false);
							}
							theLabel.updater(inNum, addStr);
						}
					};
					for (i in actChipsArray){
						targ = actChipsArray[i];
						delay = ((4 - (i % 5)) / 20 + addDelay);
						delayOff = Math.floor(i / 5) / 20;
						delay = (delay + delayOff);
						Tweener.addTween(targ, {alpha:0, time:0.15, delay:delay, onComplete:killChips, onCompleteParams:[targ]});
						Tweener.addTween(targ, {time:0.15, delay:(delay + 0.25), onComplete:updateSeq});
					}
				}
			}
		}
		public function killChips(p__1:flash.display.DisplayObject)
		{
			cont.removeChild(p__1);
		}
	}
}