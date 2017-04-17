// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.chips
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import com.script.format.*;
	import flash.utils.Timer;
	import com.script.text.TextBox;
	public class ChipLabel extends flash.display.Sprite
	{
		public var bg:flash.display.Sprite;
		public var dumAmt:com.script.text.TextBox;
		public var theCol:uint;
		public var theTotal:Number = 0;
		public var theAmt:com.script.text.TextBox;
		public var oldTotal:Number = 0;
		public var addToEnd:String;
		public function ChipLabel(p__1:Number, p__2:Boolean = false, p__3:uint = 0, p__4:String = "", p__5:uint = 16777215)
		{
			var l__6:String = p__4;
			var l__7:String = (("" + StringUtility.StringToMoney(p__1, false)) + l__6);
			theAmt = new TextBox(myriadTF, l__7, 11, p__5, "center", 80, true);
			dumAmt = new TextBox(myriadTF, l__7, 11, p__5, "center", 80, true);
			theCol = p__3;
			if (!(p__2)){
				theTotal = p__1;
				addChild(theAmt);
				makeBacking();
			} else if (p__2){
				addChild(theAmt);
				makeBacking();
				updater(p__1, l__6);
			}
		}
		public function makeBacking()
		{
			if (bg != null){
				removeChild(bg);
			}
			//var l__1:Number = Math.round((dumAmt.width + 6));
			var l__1:Number = Math.round(80);
			bg = new Sprite();
			bg.graphics.beginFill(theCol, 1);
			bg.graphics.drawRoundRect((0 - l__1) / 2, -7.5, l__1, 13, 13);
			bg.graphics.endFill();
			bg.alpha = 0.8;
			bg.y = 0;
			addChildAt(bg, 0);
		}
		public function countUp(inAmt:Number, addStr:String)
		{
			var oldVal:Number = 0;
			var theDif:Number = 0;
			var iter:int;
			var timer:flash.utils.Timer;
			var inc = undefined;
			inc = function()
			{
				var l__1:Number = timer.currentCount;
				var l__2:Number = ((iter + 1) - l__1);
				var l__3:Number = Math.ceil(theDif / l__2);
				var l__4:String = (("" + StringUtility.StringToMoney((l__3 + oldVal), false)) + addToEnd);
				theAmt.updateText(l__4);
				if (l__1 == iter){
					timer.stop();
				}
			};
			var newVal:Number = inAmt;
			oldVal = theTotal;
			theDif = (newVal - oldVal);
			theTotal = newVal;
			iter = 1;
			if (theDif >= 0){
				iter = 1;
			}
			if (theDif > 10){
				iter = 2;
			}
			if (theDif > 100){
				iter = 4;
			}
			if (theDif > 1000){
				iter = 6;
			}
			if (theDif > 10000){
				iter = 8;
			}
			if (theDif > 100000){
				iter = 10;
			}
			if (theDif > 1000000){
				iter = 12;
			}
			if (theDif > 10000000){
				iter = 14;
			}
			if (theDif > 100000000){
				iter = 16;
			}
			if (theDif > 1000000000){
				iter = 18;
			}
			if (theDif > 10000000000){
				iter = 20;
			}
			if (theDif > 100000000000){
				iter = 22;
			}
			if (theDif > 1000000000000){
				iter = 24;
			}
			timer = new Timer(50, iter);
			timer.addEventListener(TimerEvent.TIMER, inc);
			timer.start();
			addToEnd = addStr;
		}
		public function updater(p__1:Number, p__2:String = "")
		{
			var l__3:String = (("" + StringUtility.StringToMoney(p__1, false)) + p__2);
			dumAmt.updateText(l__3);
			makeBacking();
			countUp(p__1, p__2);
		}
	}
}