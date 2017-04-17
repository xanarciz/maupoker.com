// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.layout.modes
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import com.yahoo.astra.layout.events.*;
	import com.yahoo.astra.utils.*;
	public class BoxLayout extends com.yahoo.astra.layout.modes.BaseLayoutMode implements IAdvancedLayoutMode
	{
		private var _direction:String = "horizontal";
		private var _verticalGap:Number = 0;
		private var _horizontalAlign:String = "left";
		protected var maxChildWidth:Number = 0;
		private var _horizontalGap:Number = 0;
		protected var maxChildHeight:Number = 0;
		private var _verticalAlign:String = "top";
		private static const DEFAULT_MAX_HEIGHT:Number = 10000;
		private static const DEFAULT_MAX_WIDTH:Number = 10000;
		public function BoxLayout()
		{
		}
		public function get direction():String
		{
			return(this._direction);
		}
		public function set direction(p__1:String):void
		{
			this._direction = p__1;
			this.dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_CHANGE));
		}
		public function get verticalGap():Number
		{
			return(this._verticalGap);
		}
		public function set verticalGap(p__1:Number):void
		{
			this._verticalGap = p__1;
			this.dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_CHANGE));
		}
		public function get horizontalGap():Number
		{
			return(this._horizontalGap);
		}
		public function set horizontalGap(p__1:Number):void
		{
			this._horizontalGap = p__1;
			this.dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_CHANGE));
		}
		public function get verticalAlign():String
		{
			return(this._verticalAlign);
		}
		public function set verticalAlign(p__1:String):void
		{
			this._verticalAlign = p__1;
			this.dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_CHANGE));
		}
		public function get horizontalAlign():String
		{
			return(this._horizontalAlign);
		}
		public function set horizontalAlign(p__1:String):void
		{
			this._horizontalAlign = p__1;
			this.dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_CHANGE));
		}
		override public function layoutObjects(p__1:Array, p__2:flash.geom.Rectangle):flash.geom.Rectangle
		{
			var l__8:flash.display.DisplayObject;
			var l__3:Array = this.configureChildren(p__1);
			var l__4:Number = ((p__2.width - this.paddingLeft) - this.paddingRight);
			if ((l__4 == Infinity) || (l__4 > 9000)){
				l__4 = DEFAULT_MAX_WIDTH;
			}
			var l__5:Number = ((p__2.height - this.paddingTop) - this.paddingBottom);
			if ((l__5 == Infinity) || (l__5 > 9000)){
				l__5 = DEFAULT_MAX_HEIGHT;
			}
			if (this.direction == "vertical"){
				l__5 = (l__5 - (this.verticalGap * (l__3.length - 1)));
				PercentageSizeUtil.flexChildHeightsProportionally(this.clients, this.configurations, l__4, l__5);
			} else {
				l__4 = (l__4 - (this.horizontalGap * (l__3.length - 1)));
				PercentageSizeUtil.flexChildWidthsProportionally(this.clients, this.configurations, l__4, l__5);
			}
			this.maxChildWidth = 0;
			this.maxChildHeight = 0;
			var l__6:int = l__3.length;
			var l__7:int;
			while(l__7 < l__6){
				l__8 = DisplayObject(l__3[l__7]);
				this.maxChildWidth = Math.max(this.maxChildWidth, l__8.width);
				this.maxChildHeight = Math.max(this.maxChildHeight, l__8.height);
				l__7++;
			}
			if (this.direction == "vertical"){
				this.layoutChildrenVertically(l__3, p__2);
			} else {
				this.layoutChildrenHorizontally(l__3, p__2);
			}
			p__2 = LayoutModeUtil.calculateChildBounds(l__3);
			p__2.width = (p__2.width + this.paddingRight);
			p__2.height = (p__2.height + this.paddingBottom);
			return(p__2);
		}
		protected function layoutChildrenVertically(p__1:Array, p__2:flash.geom.Rectangle):void
		{
			var l__9:flash.display.DisplayObject;
			var l__10:Number = 0;
			var l__11:Number = 0;
			var l__3:Number = p__2.width;
			if (l__3 == Number.POSITIVE_INFINITY){
				l__3 = this.maxChildWidth;
			}
			l__3 = (l__3 - (this.paddingLeft + this.paddingRight));
			var l__4:Number = (p__2.x + this.paddingLeft);
			var l__5:Number = (p__2.y + this.paddingTop);
			var l__6:int = p__1.length;
			var l__7:int;
			while(l__7 < l__6){
				l__9 = DisplayObject(p__1[l__7]);
				l__9.x = l__4;
				l__9.y = l__5;
				DisplayObjectUtil.align(l__9, new Rectangle(l__9.x, l__9.y, l__3, l__9.height), this.horizontalAlign, null);
				l__5 = (l__5 + (l__9.height + this.verticalGap));
				l__7++;
			}
			var l__8:Number = (((l__5 - this.verticalGap) - p__2.y) + this.paddingBottom);
			if (l__8 < p__2.height){
				l__10 = (p__2.height - l__8) / 2;
				l__11 = ((p__2.height - l__8) - p__2.y);
				l__11 = (l__11 == Infinity) ? DEFAULT_MAX_HEIGHT : l__11;
				l__7 = 0;
				while(l__7 < l__6){
					l__9 = DisplayObject(p__1[l__7]);
					switch(this.verticalAlign){
						case "middle":
						{
							l__9.y = (l__9.y + l__10);
							break;
						}
						case "bottom":
						{
							l__9.y = (l__9.y + l__11);
							break;
						}
					}
					l__7++;
				}
			}
		}
		protected function layoutChildrenHorizontally(p__1:Array, p__2:flash.geom.Rectangle):void
		{
			var l__9:flash.display.DisplayObject;
			var l__10:Number = 0;
			var l__11:Number = 0;
			var l__3:Number = p__2.height;
			if (l__3 == Number.POSITIVE_INFINITY){
				l__3 = this.maxChildHeight;
			}
			l__3 = (l__3 - (this.paddingBottom + this.paddingTop));
			var l__4:Number = (p__2.x + this.paddingLeft);
			var l__5:Number = (p__2.y + this.paddingTop);
			var l__6:int = p__1.length;
			var l__7:int;
			while(l__7 < l__6){
				l__9 = DisplayObject(p__1[l__7]);
				l__9.x = l__4;
				l__9.y = l__5;
				DisplayObjectUtil.align(l__9, new Rectangle(l__9.x, l__9.y, l__9.width, l__3), null, this.verticalAlign);
				l__4 = (l__4 + (l__9.width + this.horizontalGap));
				l__7++;
			}
			var l__8:Number = (((l__4 - this.horizontalGap) - p__2.x) + this.paddingRight);
			if (l__8 < p__2.width){
				l__10 = (p__2.width - l__8) / 2;
				l__11 = (p__2.width - l__8);
				l__11 = (l__11 == Infinity) ? DEFAULT_MAX_WIDTH : l__11;
				l__7 = 0;
				while(l__7 < l__6){
					l__9 = DisplayObject(p__1[l__7]);
					switch(this.horizontalAlign){
						case "center":
						{
							l__9.x = (l__9.x + l__10);
							break;
						}
						case "right":
						{
							l__9.x = (l__9.x + l__11);
							break;
						}
					}
					l__7++;
				}
			}
		}
		override protected function newConfiguration():Object
		{
			return({includeInLayout:true, minWidth:0, maxWidth:10000, minHeight:0, maxHeight:10000, percentWidth:NaN, percentHeight:NaN});
		}
	}
}