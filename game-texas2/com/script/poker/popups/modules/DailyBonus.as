// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules
{
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	public class DailyBonus extends flash.display.Sprite
	{
		public var field:*;
		public function DailyBonus()
		{
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.font1;
			var l__3:* = new l__2();
			field = l__3.field;
			field.x = 180;
			field.y = 10;
			field.width = 345;
			field.height = 260;
			addChild(field);
		}
		public function set chips(p__1:Number)
		{
			var l__2:* = new flash.text.TextFormat();
			l__2.align = "left";
			field.htmlText = (("<font size=\'14\' color=\'#ffffff\'><font size=\'16\' color=\'#ffffff\'><b>You\'ve received your<br>daily bonus of <font color=\'#ffffff\'>" + String(p__1)) + "</font> chips!</b></font><br><br><font size=\'25\'><b>FREE weekly poker tournament is here!</b></font><br><br>The purse is over <b>100 Million</b> and growing!<br>Start with 1000 chips and come<br>and go as you please!</font>");
			field.setTextFormat(l__2);
		}
	}
}