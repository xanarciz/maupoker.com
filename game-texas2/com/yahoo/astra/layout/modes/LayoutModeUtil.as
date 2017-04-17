// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.layout.modes
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	public class LayoutModeUtil
	{
		public function LayoutModeUtil()
		{
		}
		public static function calculateChildBounds(p__1:Array):flash.geom.Rectangle
		{
			var l__8:flash.display.DisplayObject;
			var l__9:Number = 0;
			var l__10:Number = 0;
			var l__2:Number = 0;
			var l__3:Number = 0;
			var l__4:Number = 0;
			var l__5:Number = 0;
			var l__6:int = p__1.length;
			var l__7:int;
			while(l__7 < l__6){
				l__8 = DisplayObject(p__1[l__7]);
				l__9 = (l__8.x + l__8.width);
				l__10 = (l__8.y + l__8.height);
				l__2 = Math.min(l__2, l__8.x);
				l__4 = Math.min(l__4, l__8.y);
				l__3 = Math.max(l__3, l__9);
				l__5 = Math.max(l__5, l__10);
				l__7++;
			}
			return(new Rectangle(l__2, l__4, (l__3 - l__2), (l__5 - l__4)));
		}
	}
}