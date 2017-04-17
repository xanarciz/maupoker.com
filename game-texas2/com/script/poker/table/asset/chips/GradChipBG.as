// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.chips
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	public class GradChipBG extends flash.display.Sprite
	{
		public var backing:flash.display.Sprite;
		public function GradChipBG(p__1:Number, p__2:Object, p__3:Number)
		{
			backing = new Sprite();
			var l__4:String = GradientType.LINEAR;
			var l__5:Array = p__2.colors;
			var l__6:Array = p__2.alphas;
			var l__7:Array = p__2.ratios;
			var l__8:Number = ((p__3) * Math.PI) / 180;
			var l__9:flash.geom.Matrix = new Matrix();
			l__9.createGradientBox(p__1, p__1, l__8, 0, 0);
			backing.graphics.beginGradientFill(l__4, l__5, l__6, l__7, l__9, SpreadMethod.PAD);
			backing.graphics.drawEllipse(0, 0, p__1, p__1);
			backing.x = backing.y = (0 - ((p__1) / 2));
			addChild(backing);
		}
	}
}