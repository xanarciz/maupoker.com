// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules
{
	import flash.events.*;
	import flash.display.*;
	import flash.text.*;
	public class OutOfChips extends flash.display.MovieClip
	{
		public var field1:*;
		private var fmt:*;
		public function OutOfChips()
		{
			fmt = new flash.text.TextFormat();
			fmt.align = "center";
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.font1;
			var l__3:* = new l__2();
			field1 = l__3.field;
			field1.x = 191;
			field1.y = 75;
			field1.width = 385;
			field1.height = 150;
			addChild(field1);
		}
		public function set chips(p__1:Number)
		{
			field1.htmlText = (("<font size=\'26\'><b>Come back <font color=\'#309A00\'>EVERY DAY</font><br>to receive your<br> <font color=\'#D72C2C\'>FREE</font> <font color=\'#309A00\'>" + p__1) + "</font> daily<br>chips bonus</b></font>");
			field1.setTextFormat(fmt);
		}
	}
}