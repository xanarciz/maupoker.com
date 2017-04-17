// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.text.TextField;
	import com.script.poker.table.asset.icons.*;
	public class BetButtons extends flash.display.MovieClip
	{
		public var slider:flash.display.MovieClip;
		public var raiseButton:com.script.poker.table.asset.PokerButton;
		public var valTxt:flash.text.TextField;
		public var callButton:com.script.poker.table.asset.PokerButton;
		public var raiseBG:flash.display.MovieClip;
		public var foldButton:com.script.poker.table.asset.PokerButton;
		public function BetButtons():void
		{
		}
		public function initBetButtons():void
		{
			valTxt.selectable = false;
			valTxt.mouseEnabled = false;
			var l__1:com.script.poker.table.asset.icons.CheckBtnGfx = new CheckBtnGfx();
			var l__2:flash.display.Sprite = new Sprite();
			l__2.addChild(l__1);
			l__2.width = 15;
			l__2.height = 14;
			var l__3:Object = new Object();
			l__3.gfx = l__2;
			l__3.theX = 6;
			l__3.theY = 7;
			var l__4:com.script.poker.table.asset.icons.FoldBtnGfx = new FoldBtnGfx();
			var l__5:flash.display.Sprite = new Sprite();
			l__5.addChild(l__4);
			l__5.width = 15;
			l__5.height = 14;
			l__5.y = -20;
			var l__6:Object = new Object();
			l__6.gfx = l__5;
			l__6.theX = 6;
			l__6.theY = 6;
			var l__7:com.script.poker.table.asset.icons.RaiseBtnGfx = new RaiseBtnGfx();
			var l__8:flash.display.Sprite = new Sprite();
			l__8.addChild(l__7);
			l__8.width = 15;
			l__8.height = 14;
			l__8.y = -20;
			var l__9:Object = new Object();
			l__9.gfx = l__8;
			l__9.theX = 6;
			l__9.theY = 6;
			callButton = new PokerButton(averinTF, "medium", "CHECK", l__3, 116, 20);
			foldButton = new PokerButton(averinTF, "medium", "FOLD", l__6, 116, 20);
			callButton.x = 3;
			foldButton.x = 124;
			callButton.y = 20;
			foldButton.y = 20;
			raiseButton = new PokerButton(averinTF, "medium", "RAISE:", l__9, 116, 20);
			raiseButton.x = 3;
			raiseButton.y = 45;
			addChildAt(callButton, 2);
			addChildAt(foldButton, 2);
			addChildAt(raiseButton, 2);
		}
	}
}