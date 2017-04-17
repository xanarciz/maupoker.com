// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.draw
{
	import com.script.poker.table.GiftItem;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	public class AutoTriangle extends flash.display.Sprite
	{
		public function AutoTriangle():void
		{
		}
		public static function make(p__1:uint, p__2:int = 6):flash.display.Sprite
		{
			var l__3:flash.display.Sprite = new Sprite();
			l__3.graphics.beginFill(p__1, 1);
			l__3.graphics.lineTo(p__2, (p__2) / 2);
			l__3.graphics.lineTo(0, p__2);
			l__3.graphics.lineTo(0, 0);
			l__3.graphics.endFill();
			return(l__3);
		}
	}
}