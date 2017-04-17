// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.layout.modes
{
	import flash.display.DisplayObject;
	public class PercentageSizeUtil
	{
		public function PercentageSizeUtil()
		{
		}
		public static function flexChildWidthsProportionally(p__1:Array, p__2:Array, p__3:Number, p__4:Number):Number
		{
			var l__10:flash.display.DisplayObject;
			var l__11:Object;
			var l__12:Number = 0;
			var l__13:Number = 0;
			var l__14:Number = 0;
			var l__15:ChildInfo;
			var l__5:Number = p__3;
			var l__6:Number = 0;
			var l__7:Array = [];
			var l__8:int = p__1.length;
			var l__9:int;
			while(l__9 < l__8){
				l__10 = DisplayObject(p__1[l__9]);
				l__11 = p__2[l__9];
				if (!l__11.includeInLayout){
				} else {
					l__12 = l__11.percentWidth;
					l__13 = l__11.percentHeight;
					l__14 = NaN;
					if (!isNaN(l__13)){
						l__14 = Math.max(l__11.minHeight, Math.min(l__11.maxHeight, (l__13 >= 100) ? p__4 : ((p__4 * l__13) / 100)));
					}
					if (!isNaN(l__12)){
						l__6 = (l__6 + l__12);
						l__15 = new ChildInfo();
						l__15.percent = l__12;
						l__15.min = l__11.minWidth;
						l__15.max = l__11.maxWidth;
						l__15.opposite = l__14;
						l__15.child = l__10;
						l__7.push(l__15);
					} else {
						if ((l__10.scaleX == 1) && (l__10.scaleY == 1)){
							if (!isNaN(l__14)){
								l__10.height = Math.floor(l__14);
							}
						} else if (!isNaN(l__14)){
							l__10.height = l__14;
						}
						l__5 = (l__5 - l__10.width);
					}
				}
				l__9++;
			}
			if (l__6){
				l__5 = flexChildrenProportionally(p__3, l__5, l__6, l__7);
				l__8 = l__7.length;
				l__9 = 0;
				while(l__9 < l__8){
					l__15 = ChildInfo(l__7[l__9]);
					l__10 = l__15.child;
					if ((l__10.scaleX == 1) && (l__10.scaleY == 1)){
						l__10.width = Math.floor(l__15.size);
						if (!isNaN(l__15.opposite)){
							l__10.height = Math.floor(l__15.opposite);
						}
					} else {
						l__10.width = l__15.size;
						if (!isNaN(l__15.opposite)){
							l__10.height = l__15.opposite;
						}
					}
					l__9++;
				}
				distributeExtraWidth(p__1, p__2, p__3);
			}
			return(l__5);
		}
		public static function flexChildHeightsProportionally(p__1:Array, p__2:Array, p__3:Number, p__4:Number):Number
		{
			var l__10:flash.display.DisplayObject;
			var l__11:Object;
			var l__12:Number = 0;
			var l__13:Number = 0;
			var l__14:Number = 0;
			var l__15:ChildInfo;
			var l__5:Number = p__4;
			var l__6:Number = 0;
			var l__7:Array = [];
			var l__8:int = p__1.length;
			var l__9:int;
			while(l__9 < l__8){
				l__10 = DisplayObject(p__1[l__9]);
				l__11 = p__2[l__9];
				if (!l__11.includeInLayout){
				} else {
					l__12 = l__11.percentWidth;
					l__13 = l__11.percentHeight;
					l__14 = NaN;
					if (!isNaN(l__12)){
						l__14 = Math.max(l__11.minWidth, Math.min(l__11.maxWidth, (l__12 >= 100) ? p__3 : ((p__3 * l__12) / 100)));
					}
					if (!isNaN(l__13)){
						l__6 = (l__6 + l__13);
						l__15 = new ChildInfo();
						l__15.percent = l__13;
						l__15.min = l__11.minHeight;
						l__15.max = l__11.maxHeight;
						l__15.opposite = l__14;
						l__15.child = l__10;
						l__7.push(l__15);
					} else {
						if ((l__10.scaleX == 1) && (l__10.scaleY == 1)){
							if (!isNaN(l__14)){
								l__10.width = Math.floor(l__14);
							}
						} else if (!isNaN(l__14)){
							l__10.width = l__14;
						}
						l__5 = (l__5 - l__10.height);
					}
				}
				l__9++;
			}
			if (l__6){
				l__5 = flexChildrenProportionally(p__4, l__5, l__6, l__7);
				l__8 = l__7.length;
				l__9 = 0;
				while(l__9 < l__8){
					l__15 = ChildInfo(l__7[l__9]);
					l__10 = l__15.child;
					if ((l__10.scaleX == 1) && (l__10.scaleY == 1)){
						if (!isNaN(l__15.opposite)){
							l__10.width = Math.floor(l__15.opposite);
						}
						l__10.height = Math.floor(l__15.size);
					} else {
						if (!isNaN(l__15.opposite)){
							l__10.width = l__15.opposite;
						}
						l__10.height = l__15.size;
					}
					l__9++;
				}
				distributeExtraHeight(p__1, p__2, p__4);
			}
			return(l__5);
		}
		public static function flexChildrenProportionally(p__1:Number, p__2:Number, p__3:Number, p__4:Array):Number
		{
			var l__6:Number = 0;
			var l__7:Boolean;
			var l__9:* = undefined;
			var l__10:* = undefined;
			var l__11:* = undefined;
			var l__12:* = undefined;
			var l__13:* = undefined;
			var l__14:* = undefined;
			var l__5:int = p__4.length;
			var l__8:Number = (p__2 - ((p__1 * p__3) / 100));
			if (l__8 > 0){
				p__2 = (p__2 - l__8);
			}
			do {
				l__6 = 0;
				l__7 = true;
				l__9 = p__2 / p__3;
				l__10 = 0;
				while(l__10 < l__5){
					l__11 = ChildInfo(p__4[l__10]);
					l__12 = l__11.percent * l__9;
					if (l__12 < l__11.min){
						l__13 = l__11.min;
						l__11.size = l__13;
						p__4[l__10] = p__4[--l__5];
						p__4[l__5] = l__11;
						p__3 = (p__3 - l__11.percent);
						p__2 = (p__2 - l__13);
						l__7 = false;
						break;
					} else if (l__12 > l__11.max){
						l__14 = l__11.max;
						l__11.size = l__14;
						p__4[l__10] = p__4[--l__5];
						p__4[l__5] = l__11;
						p__3 = (p__3 - l__11.percent);
						p__2 = (p__2 - l__14);
						l__7 = false;
						break;
					} else {
						l__11.size = l__12;
						l__6 = (l__6 + l__12);
					}
					l__10++;
				}
			} while (!l__7)
			return(Math.max(0, Math.floor(p__2 - l__6)));
		}
		public static function distributeExtraHeight(p__1:Array, p__2:Array, p__3:Number):void
		{
			var l__5:Number = 0;
			var l__8:Number = 0;
			var l__9:Number = 0;
			var l__13:flash.display.DisplayObject;
			var l__14:Object;
			var l__4:Boolean;
			var l__6:Number = p__3;
			var l__7:Number = 0;
			var l__10:int = p__1.length;
			var l__11:int;
			while(l__11 < l__10){
				l__13 = DisplayObject(p__1[l__11]);
				l__14 = p__2[l__11];
				if (!l__14.includeInLayout){
				} else {
					l__8 = l__13.height;
					l__5 = l__14.percentHeight;
					l__7 = (l__7 + l__8);
					if (!isNaN(l__5)){
						l__9 = Math.ceil((l__5 / 100) * p__3);
						if (l__9 > l__8){
							l__4 = true;
						}
					}
				}
				l__11++;
			}
			if (!l__4){
				return;
			}
			l__6 = (l__6 - l__7);
			var l__12:* = true;
			while(l__12 && (l__6 > 0)){
				l__12 = false;
				l__11 = 0;
				while(l__11 < l__10){
					l__13 = DisplayObject(p__1[l__11]);
					l__14 = p__2[l__11];
					l__8 = l__13.height;
					l__5 = l__14.percentHeight;
					if (((!isNaN(l__5)) && l__14.includeInLayout) && (l__8 < l__14.maxHeight)){
						l__9 = Math.ceil((l__5 / 100) * p__3);
						if (l__9 > l__8){
							l__13.height = (l__8 + 1);
							l__6--;
							l__12 = true;
							if (l__6 == 0){
								return;
							}
						}
					}
					l__11++;
				}
			}
		}
		public static function distributeExtraWidth(p__1:Array, p__2:Array, p__3:Number):void
		{
			var l__6:Number = 0;
			var l__9:Number = 0;
			var l__10:Number = 0;
			var l__13:flash.display.DisplayObject;
			var l__14:Object;
			var l__4:int = p__1.length;
			var l__5:Boolean;
			var l__7:Number = p__3;
			var l__8:Number = 0;
			var l__11:int;
			while(l__11 < l__4){
				l__13 = DisplayObject(p__1[l__11]);
				l__14 = p__2[l__11];
				if (!l__14.includeInLayout){
				} else {
					l__9 = l__13.width;
					l__6 = l__14.percentWidth;
					l__8 = (l__8 + l__9);
					if (!isNaN(l__6)){
						l__10 = Math.ceil((l__6 / 100) * p__3);
						if (l__10 > l__9){
							l__5 = true;
						}
					}
				}
				l__11++;
			}
			if (!l__5){
				return;
			}
			l__7 = (l__7 - l__8);
			var l__12:* = true;
			while(l__12 && (l__7 > 0)){
				l__12 = false;
				l__11 = 0;
				while(l__11 < l__4){
					l__13 = DisplayObject(p__1[l__11]);
					l__14 = p__2[l__11];
					l__9 = l__13.width;
					l__6 = l__14.percentWidth;
					if (((!isNaN(l__6)) && l__14.includeInLayout) && (l__9 < l__14.maxWidth)){
						l__10 = Math.ceil((l__6 / 100) * p__3);
						if (l__10 > l__9){
							l__13.width = (l__9 + 1);
							l__7--;
							l__12 = true;
							if (l__7 == 0){
								return;
							}
						}
					}
					l__11++;
				}
			}
		}
	}
}

	import com.yahoo.astra.layout.modes.*;
	import flash.display.DisplayObject;

class ChildInfo
{
	public var size:Number = 0;
	public var percent:Number = 0;
	public var opposite:Number = 0;
	public var max:Number = 0;
	public var min:Number = 0;
	public var child:flash.display.DisplayObject;
	function ChildInfo()
	{
	}
}
