// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import flash.events.*;
	import flash.display.*;
	import com.script.draw.*;
	import com.script.text.*;
	import flash.filters.*;
	public class PokerButton extends flash.display.Sprite
	{
		public var bg:com.script.draw.Box;
		public var bActive:Boolean = true;
		public var thisName:String;
		public var theText:com.script.text.TextBox;
		public var pos:*;
		public var addGfx:*;
		public var buttonHeights:Array = [12, 20, 24];
		public var bSelected:Boolean = false;
		public var gray:com.script.draw.Box;
		public var textSizes:Array = [11, 13, 13];
		public var textYoff:Array = [8, 11, 11];
		public var sizeID:int;
		public var hitter:flash.display.Sprite;
		public var cont:flash.display.MovieClip;
		public var strokes:Array = [1.5, 1.5, 2];
		public var corners:Array = [7, 10, 0];
		public var textColors:Array = [0,4210752, 0];

		public function PokerButton(p__1:*, p__2:String, p__3:String, p__4:Object = null, p__5:Number = -1, p__6:Number = 0, p__7:Number = -1, p__8:Number = 0)
		{
			var l__15:* = undefined;
			cont = new flash.display.MovieClip();
			addChild(cont);
			var l__9:flash.display.Sprite = new flash.display.Sprite();
			l__9.mouseChildren = false;
			l__9.mouseEnabled = false;
			cont.addChild(l__9);
			if ((p__2) == "small"){
				sizeID = 0;
			} else if ((p__2) == "medium"){
				sizeID = 1;
			} else if ((p__2) == "large"){
				sizeID = 2;
			}
			if ((p__3) != ""){
				
				theText = new com.script.text.TextBox(p__1, p__3, textSizes[sizeID], textColors[sizeID], "left", 200, true);
				theText.x = p__6;
				theText.y = (textYoff[sizeID] + p__8);
				l__9.addChild(theText);
			}
			if ((p__4) != null){
				addGfx = p__4.gfx;
				l__9.addChild(addGfx);
				addGfx.x = p__4.theX;
				addGfx.y = p__4.theY;
			}
			var l__10:Number = (l__9.width + 10);
			var l__11:Number = buttonHeights[sizeID];
			if ((p__5) > -1){
				l__10 = p__5;
			}
			if ((p__7) > -1){
				l__11 = p__7;
			}
			var l__12:Object = new Object();
			if ((p__2) == "small"){
				l__12.colors = [ 10724259,  10724259,13290186, 13290186];
				l__12.alphas = [1, 1, 1, 1];
				l__12.ratios = [0, 127, 128, 225];
				bg = new com.script.draw.Box(l__10, l__11, l__12, false, true, corners[sizeID]);
				var l__13:Array = [new flash.filters.GlowFilter(13290186, 1, strokes[sizeID], strokes[sizeID], 2, 4, false)];
				bg.filters = l__13;
			} else if ((p__2) == "medium"){
				l__12.colors = [ 10724259,  10724259,13290186, 13290186];
				l__12.alphas = [1, 1, 1, 1];
				l__12.ratios = [0, 127, 128, 225];
				bg = new com.script.draw.Box(l__10, l__11, l__12, false, true, corners[sizeID]);
				var l__13:Array = [new flash.filters.GlowFilter(13290186, 1, strokes[sizeID], strokes[sizeID], 2, 4, false)];
				bg.filters = l__13;
			} else if ((p__2) == "large"){
				l__12.colors = [ 14079702,    12631227,  6184542];
				l__12.alphas = [1, 1, 1];
				l__12.ratios = [0, 127, 225];
				bg = new com.script.draw.Box(l__10, l__11, l__12, false, true, corners[sizeID]);
				var l__13:Array = [new flash.filters.GlowFilter(13290186, 1, strokes[sizeID], strokes[sizeID], 2, 4, false)];
				bg.filters = l__13;
			}
			
			cont.addChildAt(bg, 0);
			var l__14:Object = new Object();
			l__14.colors = [11184810, 11184810];
			l__14.alphas = [1, 1];
			l__14.ratios = [0, 225];
			gray = new com.script.draw.Box((l__10 + 2), (l__11 + 2), l__14, false, true, (corners[sizeID] + 1));
			gray.x = gray.y = -1;
			gray.alpha = 0.66;
			cont.addChild(gray);
			hitter = new flash.display.MovieClip();
			hitter.graphics.beginFill(16777215, 0);
			hitter.graphics.drawRect(0, 0, l__10, l__11);
			hitter.graphics.endFill();
			cont.addChild(hitter);
			setActivity(true);
		}
		public function setActivity(p__1:Boolean):void
		{
			bActive = p__1;
			hitter.buttonMode = bActive;
			hitter.useHandCursor = bActive;
			if (bActive){
				gray.visible = false;
			}
			if (!bActive){
				gray.visible = true;
			}
		}
		public function changeText(p__1:String):void
		{
			theText.updateText(p__1);
		}
		public function setSelectscriptLive(p__1:Boolean):void
		{
			var l__2:Array;
			var l__3:Array;
			if (!(p__1)){
				bg.filters = [];
				l__2 = [new flash.filters.GlowFilter(0, 0.4, 13, 13, 2, 3, true), new flash.filters.GlowFilter(1118481, 1, strokes[sizeID], strokes[sizeID], 2, 4, false)];
				bg.filters = l__2;
			}
			if (p__1){
				bg.filters = [];
				l__3 = [new flash.filters.GlowFilter(1118481, 1, strokes[sizeID], strokes[sizeID], 2, 4, false)];
				bg.filters = l__3;
			}
			bSelected = !bSelected;
		}
		public function setZLStatus(p__1:int):void
		{
			if ((p__1) > 0){
				addGfx.gotoAndStop(2);
			} else if ((p__1) == 0){
				addGfx.gotoAndStop(1);
			}
		}
	}
}