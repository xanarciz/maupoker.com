// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby.asset
{
	import flash.display.InteractiveObject;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import com.script.text.TextBox;
	import com.script.draw.Box;
	import flash.filters.*;
	public class DrawFrame extends flash.display.Sprite
	{
		public var closer:GenericCloseButton;
		private var round:int = 9;
		public var cont:com.script.draw.Box;
		public var bgCont:flash.display.Sprite;
		public var titleBox:com.script.text.TextBox;
		public function DrawFrame(p__1:int, p__2:int, p__3:Boolean = true, p__4:Boolean = true):void
		{
			bgCont = new Sprite();
			var l__5:Object = new Object();
			l__5.colors = [6908265, 0];
			l__5.alphas = [1, 1];
			l__5.ratios = [0, 200];
			var l__6:com.script.draw.Box = new Box((p__1 + 12), 20, l__5, false, true, round);
			l__6.x = -6;
			l__6.y = -20;
			bgCont.addChild(l__6);
			var l__7:com.script.draw.Box = new Box((p__1 + 12), (p__2 + 16), 0, false, true, round);
			l__7.x = -6;
			l__7.y = -10;
			bgCont.addChildAt(l__7, 0);
			addChild(bgCont);
			var l__8:Array = [new DropShadowFilter(0, 0, 0, 1, 1.1, 1.1, 10, 3)];
			bgCont.filters = l__8;
			if (p__3){
				cont = new Box(p__1, p__2, 16777215, false);
				addChild(cont);
			}
			if (p__4){
				closer = new GenericCloseButton();
				closer.x = (p__1 - 11);
				closer.y = -18;
				closer.buttonMode = true;
				closer.useHandCursor = true;
				addChild(closer);
			}
		}
		public function renderZLiveTitle(p__1:String):void
		{
			titleBox = new TextBox(myriadTF, p__1, 12, 16777215, "left");
			titleBox.x = 16;
			titleBox.y = -9;
			addChild(titleBox);
		}
		public function renderTitle(p__1:String):void
		{
			titleBox = new TextBox(myriadTF, p__1, 12, 16777215, "left");
			titleBox.x = 0;
			titleBox.y = -9;
			addChild(titleBox);
		}
	}
}