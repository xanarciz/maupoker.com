// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.chips
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import caurina.transitions.*;
	public class ChipFlury extends flash.display.Sprite
	{
		public var cont:flash.display.Sprite;
		public var theLabel:com.script.poker.table.asset.chips.ChipLabel;
		public var numChips:Number = 0;
		private var stackCount:int;
		private var chip:com.script.poker.table.asset.chips.Chip;
		private var doneCount:int;
		private var labelGone:Boolean = false;
		private var chipArray:Array;
		public function ChipFlury(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Number, p__6:Boolean = true, p__7:Number = 0, p__8:Number = 0.15, p__9:String = "")
		{
			delay = NaN;
			inNum = p__1;
			endX = p__2;
			endY = p__3;
			startX = p__4;
			startY = p__5;
			showLabel = p__6;
			addDelay = p__7;
			fluryFade = p__8;
			addMsg = p__9;
			cont = new Sprite();
			addChild(cont);
			if (showLabel){
				theLabel = new ChipLabel(inNum, false, 52224, "", 16777215);
				theLabel.x = endX;
				theLabel.y = endY;
				theLabel.scaleX = theLabel.scaleY = 1;
				theLabel.alpha = 0;
				addChild(theLabel);
				delay = addDelay;
				Tweener.addTween(theLabel, {alpha:1, time:0.33, delay:delay, transition:"linear"});
				Tweener.addTween(theLabel, {y:(theLabel.y + 34), time:2, delay:delay, transition:"easeOutSine"});
				Tweener.addTween(theLabel, {alpha:0, time:0.25, delay:(5 + delay), transition:"linear", onComplete:function()
				{
					labelGone = true;
					killFlury();
				}});
			}
			init(inNum, endX, endY, startX, startY, addDelay, fluryFade);
		}
		public function init(inNum:Number, endX:Number, endY:Number, startX:Number, startY:Number, addDelay:Number, fluryFade:Number)
		{
			var rot:Number = 0;
			var hit:Number = 0;
			var i:Number = 0;
			var flyChip = function(inChip:flash.display.DisplayObject)
			{
				var killThis = undefined;
				killThis = function()
				{
					doneCount++;
					killFlury();
				};
				stackCount++;
				cont.addChild(inChip);
				inChip.alpha = 0;
				inChip.x = startX;
				inChip.y = startY;
				var toX:Number = Math.round(endX + (10 - (Math.random() * 20)));
				var toY:Number = Math.round(endY + (10 - (Math.random() * 20)));
				var delay:Number = ((stackCount - 1) / 25 + addDelay);
				Tweener.addTween(inChip, {x:toX, y:toY, time:0.5, delay:delay, transition:"easeInSine"});
				Tweener.addTween(inChip, {alpha:1, time:0.15, delay:delay, transition:"easeInSine"});
				Tweener.addTween(inChip, {alpha:0, time:fluryFade, delay:(delay + 0.6), transition:"easeOutSine", onComplete:killThis});
			};
			numChips = 0;
			stackCount = 0;
			doneCount = 0;
			chipArray = new Array();
			var theChipValues:Array = ChipCalc.denominations;
			var chipQuan:Array = ChipCalc.quantity(inNum);
			var k:Number = 0;
			while(k < chipQuan.length){
				numChips = (numChips + chipQuan[k]);
				k++;
			}
			var j:Number = 0;
			while(j < chipQuan.length){
				rot = Math.floor(Math.random() * 60);
				hit = (chipQuan.length - (j + 1));
				i = 0;
				while(i < chipQuan[hit]){
					chip = new Chip(ChipGfx, ChipDecor, theChipValues[hit], rot);
					chipArray.push(chip);
					i++;
				}
				j++;
			}
			var m:Number = 0;
			while(m < chipArray.length){
				flyChip(chipArray[m]);
				m++;
			}
		}
		public function killFlury()
		{
			if ((doneCount == numChips) && (labelGone == true)){
				if (this.parent != null){
					this.parent.removeChild(this);
				}
			}
		}
	}
}