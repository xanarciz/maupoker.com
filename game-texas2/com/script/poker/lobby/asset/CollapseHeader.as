// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby.asset
{
	import flash.display.InteractiveObject;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import caurina.transitions.*;
	import com.script.text.TextBox;
	import com.script.draw.Box;
	import com.script.draw.AutoTriangle;
	public class CollapseHeader extends flash.display.Sprite
	{
		public var sTitle:String;
		private var disabled:Boolean = false;
		public var nQty:int;
		public var tb:com.script.text.TextBox;
		public var bActive:Boolean = true;
		public var headerPressed:Boolean = false;
		public var bExpanded:Boolean = true;
		public var triCont:flash.display.Sprite;
		public function CollapseHeader(p__1:String, p__2:int)
		{
			sTitle = p__1;
			nQty = p__2;
			this.mouseChildren = false;
			this.buttonMode = true;
			var l__3:Object = new Object();
			l__3.colors = [8290982, 5527657, 5527657, 5527657];
			l__3.alphas = [1, 1, 1, 1];
			l__3.ratios = [10, 10, 225, 225];
			var l__4:com.script.draw.Box = new Box(220, 17, l__3, false);
			addChild(l__4);
			l__3.colors = [5527657, 5527657, 5527657, 5527657];
			l__3.alphas = [1, 1, 1, 1];
			l__3.ratios = [10, 10, 225, 225];
			var l__5:com.script.draw.Box = new Box(220, 3, l__3, false);
			addChild(l__5);
			l__5.y = 17;
			var l__6:* = 8;
			triCont = new Sprite();
			triCont.x = triCont.y = 8;
			triCont.y = 9;
			addChild(triCont);
			var l__7:flash.display.Sprite = AutoTriangle.make(16777215, l__6);
			l__7.x = l__7.y = (0 - l__6) / 2;
			triCont.addChild(l__7);
			triCont.rotation = 90;
			if (nQty > -1){
				tb = new TextBox(myriadTF, (((sTitle + " (") + nQty.toString()) + ")"), 12, 16777215, "left", 200, true);
			} else {
				tb = new TextBox(myriadTF, sTitle, 12, 16777215, "left", 200, true);
			}
			tb.x = 16;
			tb.y = 10;
			tb.scaleY = tb.scaleX = 0.9;
			addChild(tb);
			setQty(nQty);
		}
		public function disableHeader(p__1:Boolean)
		{
			if (this.bExpanded){
				this.expand();
			} else {
			}
			if (p__1){
				disabled = true;
				bActive = false;
				tb.alpha = triCont.alpha = 0.66;
				this.buttonMode = false;
				triCont.rotation = 0;
				triCont.alpha = 0;
				triCont.visible = false;
				bExpanded = false;
				tb.updateText(sTitle);
			} else {
				disabled = false;
				bActive = true;
				tb.alpha = triCont.alpha = 1;
				this.buttonMode = true;
			}
		}
		public function setQty(p__1:int)
		{
			nQty = p__1;
			if (!disabled){
				if (nQty == -1){
					bActive = false;
					tb.alpha = triCont.alpha = 0.66;
					this.buttonMode = false;
					triCont.rotation = 0;
					bExpanded = false;
					tb.updateText(sTitle);
				} else {
					tb.x = 16;
					if (headerPressed && (!bExpanded)){
						bActive = true;
						tb.alpha = triCont.alpha = 1;
						bExpanded = false;
						this.buttonMode = true;
						tb.updateText(((sTitle + " (") + nQty.toString()) + ")");
					} else {
						bActive = true;
						tb.alpha = triCont.alpha = 1;
						triCont.rotation = 90;
						this.buttonMode = true;
						bExpanded = true;
						tb.updateText(((sTitle + " (") + nQty.toString()) + ")");
					}
				}
			} else {
				tb.x = 3;
				if (nQty > 0){
					tb.updateText(((sTitle + " (") + nQty.toString()) + ")");
				} else {
					tb.updateText(sTitle);
				}
			}
		}
		public function expand():void
		{
			if (bExpanded){
				Tweener.addTween(triCont, {rotation:0, time:0.15, transition:"easeOutSine"});
			} else {
				Tweener.addTween(triCont, {rotation:90, time:0.15, transition:"easeOutSine"});
			}
			bExpanded = !bExpanded;
		}
	}
}