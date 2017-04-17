// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.fl.containers
{
	import fl.core.UIComponent;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import com.yahoo.astra.layout.modes.*;
	import fl.containers.BaseScrollPane;
	import com.yahoo.astra.fl.containers.layoutClasses.*;
	public class BoxPane extends com.yahoo.astra.fl.containers.layoutClasses.AdvancedLayoutPane
	{
		private var _direction:String = "horizontal";
		private var _verticalGap:Number = 0;
		private var _horizontalAlign:String = "left";
		private var _verticalAlign:String = "top";
		private var _horizontalGap:Number = 0;
		public function BoxPane(p__1:Array = null)
		{
			super(new BoxLayout(), p__1);
		}
		public function get direction():String
		{
			return(this._direction);
		}
		public function set direction(p__1:String):void
		{
			this._direction = p__1;
			this.invalidate(INVALIDATION_TYPE_LAYOUT);
		}
		public function get verticalGap():Number
		{
			return(this._verticalGap);
		}
		public function set verticalGap(p__1:Number):void
		{
			this._verticalGap = p__1;
			this.invalidate(INVALIDATION_TYPE_LAYOUT);
		}
		public function get horizontalGap():Number
		{
			return(this._horizontalGap);
		}
		public function set horizontalGap(p__1:Number):void
		{
			this._horizontalGap = p__1;
			this.invalidate(INVALIDATION_TYPE_LAYOUT);
		}
		public function get verticalAlign():String
		{
			return(this._verticalAlign);
		}
		public function set verticalAlign(p__1:String):void
		{
			this._verticalAlign = p__1;
			this.invalidate(INVALIDATION_TYPE_LAYOUT);
		}
		public function get horizontalAlign():String
		{
			return(this._horizontalAlign);
		}
		public function set horizontalAlign(p__1:String):void
		{
			this._horizontalAlign = p__1;
			this.invalidate(INVALIDATION_TYPE_LAYOUT);
		}
		override protected function draw():void
		{
			var l__1:com.yahoo.astra.layout.modes.BoxLayout = (this.layoutMode as BoxLayout);
			if (l__1){
				l__1.direction = this.direction;
				l__1.horizontalAlign = this.horizontalAlign;
				l__1.verticalAlign = this.verticalAlign;
				l__1.horizontalGap = this.horizontalGap;
				l__1.verticalGap = this.verticalGap;
			}
			super.draw();
		}
	}
}