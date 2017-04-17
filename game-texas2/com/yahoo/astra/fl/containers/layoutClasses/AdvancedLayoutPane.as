// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.fl.containers.layoutClasses
{
	import fl.core.UIComponent;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import com.yahoo.astra.layout.modes.ILayoutMode;
	import com.yahoo.astra.layout.modes.IAdvancedLayoutMode;
	import com.yahoo.astra.layout.modes.BaseLayoutMode;
	import fl.containers.BaseScrollPane;
	public class AdvancedLayoutPane extends com.yahoo.astra.fl.containers.layoutClasses.BaseLayoutPane
	{
		protected var layoutModeChanged:Boolean = false;
		private var _paddingBottom:Number = 0;
		protected var configurationChanged:Boolean = false;
		private var _paddingTop:Number = 0;
		private var _paddingRight:Number = 0;
		private var _configuration:Array;
		private var _paddingLeft:Number = 0;
		public function AdvancedLayoutPane(p__1:com.yahoo.astra.layout.modes.ILayoutMode = null, p__2:Array = null)
		{
			super(p__1);
			this.configuration = p__2;
		}
		public function get paddingLeft():Number
		{
			return(this._paddingLeft);
		}
		public function set paddingLeft(p__1:Number):void
		{
			if (this._paddingLeft != p__1){
				this._paddingLeft = p__1;
				this.invalidate(INVALIDATION_TYPE_LAYOUT);
			}
		}
		public function get paddingRight():Number
		{
			return(this._paddingRight);
		}
		public function set paddingRight(p__1:Number):void
		{
			if (this._paddingRight != p__1){
				this._paddingRight = p__1;
				this.invalidate(INVALIDATION_TYPE_LAYOUT);
			}
		}
		public function get paddingTop():Number
		{
			return(this._paddingTop);
		}
		public function set paddingTop(p__1:Number):void
		{
			if (this._paddingTop != p__1){
				this._paddingTop = p__1;
				this.invalidate(INVALIDATION_TYPE_LAYOUT);
			}
		}
		public function get paddingBottom():Number
		{
			return(this._paddingBottom);
		}
		public function set paddingBottom(p__1:Number):void
		{
			if (this._paddingBottom != p__1){
				this._paddingBottom = p__1;
				this.invalidate(INVALIDATION_TYPE_LAYOUT);
			}
		}
		public function get configuration():Array
		{
			return(this._configuration);
		}
		public function set configuration(p__1:Array):void
		{
			var l__2:int;
			var l__3:int;
			var l__4:Object;
			var l__5:flash.display.DisplayObject;
			var l__6:com.yahoo.astra.layout.modes.IAdvancedLayoutMode;
			var l__7:int;
			if (this._configuration && (this._configuration.length > 0)){
				l__2 = this._configuration.length;
				l__3 = 0;
				while(l__3 < l__2){
					l__4 = this._configuration[l__3];
					l__5 = (l__4.target as DisplayObject);
					if (!l__5){
					} else {
						this.removeChild(l__5);
						if (this.layoutMode is IAdvancedLayoutMode){
							l__6 = IAdvancedLayoutMode(this.layoutMode);
							if (l__6.hasClient(l__5)){
								l__6.removeClient(l__5);
							}
						}
					}
					l__3++;
				}
			}
			this._configuration = p__1;
			if (this._configuration && (this._configuration.length > 0)){
				l__7 = this._configuration.length;
				l__3 = 0;
				while(l__3 < l__7){
					l__4 = this._configuration[l__3];
					l__5 = (l__4.target as DisplayObject);
					if ((!l__5) || this.contains(l__5)){
					} else {
						this.addChild(l__5);
					}
					l__3++;
				}
			}
			this.configurationChanged = true;
			this.invalidate(INVALIDATION_TYPE_LAYOUT);
		}
		override public function set layoutMode(p__1:com.yahoo.astra.layout.modes.ILayoutMode):void
		{
			super.layoutMode = p__1;
			this.layoutModeChanged = true;
		}
		override protected function draw():void
		{
			var l__1:com.yahoo.astra.layout.modes.BaseLayoutMode;
			var l__2:int;
			var l__3:int;
			var l__4:Object;
			var l__5:flash.display.DisplayObject;
			if (this.layoutMode is BaseLayoutMode){
				l__1 = BaseLayoutMode(this.layoutMode);
				if (((this.layoutModeChanged || this.configurationChanged) && this._configuration) && (this._configuration.length > 0)){
					l__2 = this._configuration.length;
					l__3 = 0;
					while(l__3 < l__2){
						l__4 = this._configuration[l__3];
						l__5 = (l__4.target as DisplayObject);
						l__1.addClient(l__5, l__4);
						l__3++;
					}
				}
				l__1.paddingTop = this.paddingTop;
				l__1.paddingRight = this.paddingRight;
				l__1.paddingBottom = this.paddingBottom;
				l__1.paddingLeft = this.paddingLeft;
			}
			super.draw();
			this.layoutModeChanged = false;
			this.configurationChanged = false;
		}
	}
}