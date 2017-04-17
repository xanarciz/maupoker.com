// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.text
{
	import flash.events.*;
	import flash.display.*;
	import flash.text.*;
	public class TextBox extends flash.display.Sprite
	{
		public var thisCol:uint;
		public var tf:Object;
		public var tah:*;
		public var thisTS:Number = 0;
		public function TextBox(p__1:Class, p__2:String, p__3:Number, p__4:uint, p__5:String, p__6:Number = 200, p__7:Boolean = true)
		{
			tah = new p__1();
			thisTS = p__3;
			thisCol = p__4;
			tf = tah.theTF;
			tf.text = p__2;
			tf.width = p__6;
			if ((p__5) == "center"){
				tf.x = (0 - p__6) / 2;
			}
			if ((p__5) == "left"){
				tf.x = 0;
			}
			if ((p__5) == "right"){
				tf.x = (0 - p__6);
			}
			var l__8:flash.text.TextFormat = new flash.text.TextFormat();
			l__8.align = p__5;
			l__8.color = p__4;
			l__8.size = p__3;
			if (p__7){
				tf.autoSize = p__5;
			}
			tf.setTextFormat(l__8);
			addChild(tah);
		}
		public function updateText(p__1:String)
		{
			var l__2:Object = tah.theTF;
			l__2.text = p__1;
			var l__3:flash.text.TextFormat = new flash.text.TextFormat();
			l__3.size = thisTS;
			l__3.color = thisCol;
			l__2.setTextFormat(l__3);
		}
	}
}