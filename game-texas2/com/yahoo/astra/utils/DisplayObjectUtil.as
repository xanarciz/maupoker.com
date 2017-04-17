// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.utils
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	public class DisplayObjectUtil
	{
		public function DisplayObjectUtil()
		{
		}
		public static function localToLocal(p__1:flash.geom.Point, p__2:flash.display.DisplayObject, p__3:flash.display.DisplayObject):flash.geom.Point
		{
			p__1 = p__2.localToGlobal(p__1);
			return(p__3.globalToLocal(p__1));
		}
		public static function align(p__1:flash.display.DisplayObject, p__2:flash.geom.Rectangle, p__3:String = null, p__4:String = null):void
		{
			var l__5:Number = (p__2.width - p__1.width);
			switch(p__3){
				case "left":
				{
					p__1.x = p__2.x;
					break;
				}
				case "center":
				{
					p__1.x = (p__2.x + (l__5 / 2));
					break;
				}
				case "right":
				{
					p__1.x = (p__2.x + l__5);
					break;
				}
			}
			var l__6:Number = (p__2.height - p__1.height);
			switch(p__4){
				case "top":
				{
					p__1.y = p__2.y;
					break;
				}
				case "middle":
				{
					p__1.y = (p__2.y + (l__6 / 2));
					break;
				}
				case "bottom":
				{
					p__1.y = (p__2.y + l__6);
					break;
				}
			}
		}
		public static function resizeAndMaintainAspectRatio(p__1:flash.display.DisplayObject, p__2:Number, p__3:Number, p__4:Number = NaN):void
		{
			var l__5:Number = (!isNaN(p__4)) ? p__4 : (p__1.width / p__1.height);
			var l__6:Number = p__2 / p__3;
			if (l__5 < l__6){
				p__1.width = Math.floor(p__3 * l__5);
				p__1.height = p__3;
			} else {
				p__1.width = p__2;
				p__1.height = Math.floor(p__2 / l__5);
			}
		}
	}
}