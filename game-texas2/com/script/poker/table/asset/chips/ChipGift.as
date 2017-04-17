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
	public class ChipGift extends flash.display.Sprite
	{
		public var cont:flash.display.Sprite;
		public var theLabel:com.script.poker.table.asset.chips.ChipLabel;
		public var numChips:Number = 0;
		private var stackCount:int;
		private var chip:com.script.poker.table.asset.chips.Chip;
		private var doneCount:int;
		private var labelGone:Boolean = false;
		public function ChipGift(p__1:Number, p__2:Number, p__3:Number, p__4:Number, p__5:Number, p__6:Number = 0, p__7:Number = 0.15)
		{
			inNum = p__1;
			endX = p__2;
			endY = p__3;
			startX = p__4;
			startY = p__5;
			addDelay = p__6;
			giftFade = p__7;
			cont = new Sprite();
			addChild(cont);
			theLabel = new ChipLabel(inNum, false, 52224);
			theLabel.x = endX;
			theLabel.y = endY;
			theLabel.scaleX = theLabel.scaleY = 1.5;
			theLabel.alpha = 0;
			addChild(theLabel);
			delay = addDelay;
			Tweener.addTween(theLabel, {alpha:1, time:0.33, delay:(delay + 0.35), transition:"linear"});
			Tweener.addTween(theLabel, {y:(theLabel.y - 20), time:2, delay:(delay + 0.35), transition:"easeOutSine"});
			Tweener.addTween(theLabel, {alpha:0, time:0.25, delay:(4 + delay), transition:"linear", onComplete:function()
			{
				killGift();
			}});
			chips = new ChipStack(inNum, "instant", 0, 0);
			chips.x = startX;
			chips.y = startY;
			cont.addChild(chips);
			Tweener.addTween(chips, {x:endX, y:endY, time:1, transition:"easeOutSine"});
			Tweener.addTween(chips, {alpha:0, delay:1, time:0.33, transition:"linear"});
		}
		public function killGift()
		{
			removeChild(cont);
		}
	}
}