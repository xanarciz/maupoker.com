// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.draw
{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;
	public class Box extends flash.display.Sprite
	{
		public var backing:flash.display.Sprite;
		public function Box(p__1:Number, p__2:Number, p__3:*, p__4:Boolean = true, p__5:Boolean = false, p__6:Number = 0, p__7:Boolean = false, p__8:uint = 0, p__9:Number = 0)
		{
			var l__10:String;
			var l__11:Array;
			var l__12:Array;
			var l__13:Array;
			var l__14:Number = 0;
			var l__15:flash.geom.Matrix;
			backing = new flash.display.Sprite();
			if ((p__7) == true){
				backing.graphics.lineStyle(p__9, p__8, 1, true, flash.display.LineScaleMode.NONE, flash.display.CapsStyle.ROUND, flash.display.JointStyle.ROUND, 15);
			}
			if ((p__3) is uint){
				backing.graphics.beginFill(p__3, 1);
			}
			if ((p__3) == null){
				backing.graphics.beginFill(0, 1);
			}
			if (!((p__3) is uint) && !((p__3) == null)){
				l__10 = flash.display.GradientType.LINEAR;
				l__11 = p__3.colors;
				l__12 = p__3.alphas;
				l__13 = p__3.ratios;
				l__14 = (90 * Math.PI) / 180;
				l__15 = new flash.geom.Matrix();
				l__15.createGradientBox(p__1, p__2, l__14, 0, 0);
				backing.graphics.beginGradientFill(l__10, l__11, l__12, l__13, l__15, flash.display.SpreadMethod.PAD);
			}
			if ((p__5) == true){
				backing.graphics.drawRoundRect(0, 0, p__1, p__2, p__6);
			} else if ((p__5) == false){
				backing.graphics.drawRect(0, 0, p__1, p__2);
			}
			if (p__4){
				backing.x = (0 - ((p__1) / 2));
				backing.y = (0 - ((p__2) / 2));
			}
			addChild(backing);
		}
	}
}