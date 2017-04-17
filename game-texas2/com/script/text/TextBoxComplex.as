// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.text
{
	import flash.display.*;
	import flash.events.EventDispatcher;
	import flash.text.*;
	public class TextBoxComplex extends flash.display.Sprite
	{
		public var thisCol:uint;
		public var tah:*;
		public var thisTS:Number = 0;
		public function TextBoxComplex(p__1:Class, p__2:Array, p__3:String, p__4:Number, p__5:Number, p__6:Boolean = true, p__7:String = null, p__8:Number = 10)
		{
			var l__12:* = undefined;
			var l__13:Object;
			var l__14:int;
			var l__15:flash.text.TextFormat;
			tah = new p__1();
			var l__9:flash.text.TextField = tah.theTF;
			var l__10:int;
			l__9.width = p__4;
			l__9.height = p__5;
			var l__11:flash.text.TextFormat = new TextFormat();
			if ((p__7) == null){
				l__9.text = "";
				for (l__12 in p__2){
					l__13 = p__2[l__12];
					l__9.appendText(l__13.theText);
					l__14 = l__13.theText.length;
					l__15 = l__9.getTextFormat(0);
					l__11.align = l__15.align;
					l__11.font = l__13.theFont;
					l__11.color = l__13.theColor;
					l__11.size = l__13.theSize;
					l__11.leading = l__13.theLead;
					l__9.setTextFormat(l__11, l__10, (l__10 + l__14));
					l__10 = l__9.text.length;
				}
			} else {
				l__9.htmlText = p__7;
				l__11.size = p__8;
				l__9.setTextFormat(l__11, 0, l__9.length);
			}
			if (p__6){
				l__9.autoSize = p__3;
			}
			if ((p__3) == "center"){
				l__9.x = (0 - p__4) / 2;
			}
			if ((p__3) == "left"){
				l__9.x = 0;
			}
			if ((p__3) == "right"){
				l__9.x = (0 - p__4);
			}
			addChild(tah);
		}
	}
}