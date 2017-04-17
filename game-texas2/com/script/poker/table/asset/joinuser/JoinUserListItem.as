// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.joinuser
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import com.script.text.*;
	public class JoinUserListItem extends flash.display.Sprite
	{
		public var sZid:String;
		public var bSelected:Boolean;
		public var backing:flash.display.Sprite;
		public var sName:String;
		public function JoinUserListItem(p__1:int, p__2:int, p__3:String, p__4:String, p__5:String, p__6:String, p__7:Boolean):void
		{
			sZid = p__6;
			sName = p__3;
			backing = new Sprite();
			backing.graphics.beginFill(65280, 0.5);
			backing.graphics.drawRect(0, 0, p__1, p__2);
			backing.graphics.endFill();
			backing.alpha = 0;
			addChild(backing);
			var l__8:Array = new Array();
			var l__9:Object = new Object();
			l__9.theText = p__3;
			l__9.theSize = 10;
			l__9.theColor = 0;
			l__8.push(l__9);
			var l__10:* = "";
			if (p__7){
				l__10 = p__5;
			}
			var l__11:* = new Object();
			if (p__7){
				l__11.theText = ((((" (" + p__4) + ", ") + l__10) + ")");
			} else {
				l__11.theText = ((" (" + p__4) + ")");
			}
			l__11.theSize = 10;
			l__11.theColor = 6710886;
			l__8.push(l__11);
			var l__12:com.script.text.TextBoxComplex = new TextBoxComplex(VerdanaTF, l__8, "left", p__1, 11, false);
			l__12.x = 3;
			l__12.y = 9;
			l__12.mouseEnabled = false;
			l__12.mouseChildren = false;
			addChild(l__12);
			selector(false);
		}
		public function selector(p__1:Boolean):void
		{
			bSelected = p__1;
			backing.buttonMode = !bSelected;
			backing.useHandCursor = !bSelected;
			if (bSelected){
				backing.alpha = 1;
			}
			if (!bSelected){
				backing.alpha = 0;
			}
		}
	}
}