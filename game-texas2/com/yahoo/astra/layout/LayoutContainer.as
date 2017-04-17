// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.layout
{
	import flash.display.InteractiveObject;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import com.yahoo.astra.layout.modes.ILayoutMode;
	import com.yahoo.astra.layout.modes.BoxLayout;
	import com.yahoo.astra.layout.events.LayoutEvent;
	import com.yahoo.astra.utils.*;
	public class LayoutContainer extends flash.display.Sprite implements ILayoutContainer
	{
		protected var _contentHeight:Number = 0;
		private var _layoutMode:com.yahoo.astra.layout.modes.ILayoutMode = new BoxLayout();
		protected var isValidating:Boolean = false;
		private var _autoMask:Boolean = true;
		protected var _contentWidth:Number = 0;
		protected var explicitWidth:Number = NaN;
		protected var invalid:Boolean = false;
		protected var explicitHeight:Number = NaN;
		public static var isRendering:Boolean = false;
		public function LayoutContainer(p__1:com.yahoo.astra.layout.modes.ILayoutMode = null)
		{
			this.scrollRect = new Rectangle();
			this.layoutMode = p__1;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		public function get contentWidth():Number
		{
			return(this._contentWidth);
		}
		public function get contentHeight():Number
		{
			return(this._contentHeight);
		}
		override public function get width():Number
		{
			if (!isNaN(this.explicitWidth)){
				return(this.explicitWidth);
			}
			return(this.contentWidth);
		}
		override public function set width(p__1:Number):void
		{
			if (this.explicitWidth != p__1){
				this.explicitWidth = p__1;
				this.invalidateLayout();
			}
		}
		override public function get height():Number
		{
			if (!isNaN(this.explicitHeight)){
				return(this.explicitHeight);
			}
			return(this.contentHeight);
		}
		override public function set height(p__1:Number):void
		{
			if (this.explicitHeight != p__1){
				this.explicitHeight = p__1;
				this.invalidateLayout();
			}
		}
		public function get layoutMode():com.yahoo.astra.layout.modes.ILayoutMode
		{
			return(this._layoutMode);
		}
		public function set layoutMode(p__1:com.yahoo.astra.layout.modes.ILayoutMode):void
		{
			if (this._layoutMode){
				this._layoutMode.removeEventListener(LayoutEvent.LAYOUT_CHANGE, layoutModeChangeHandler);
			}
			this._layoutMode = p__1;
			if (this._layoutMode){
				this._layoutMode.addEventListener(LayoutEvent.LAYOUT_CHANGE, layoutModeChangeHandler, false, 0, true);
			}
			this.invalidateLayout();
		}
		public function get autoMask():Boolean
		{
			return(this._autoMask);
		}
		public function set autoMask(p__1:Boolean):void
		{
			this._autoMask = p__1;
			if (this._autoMask){
				this.scrollRect = new Rectangle(0, 0, this.width, this.height);
			} else {
				this.scrollRect = null;
			}
		}
		override public function addChild(p__1:flash.display.DisplayObject):flash.display.DisplayObject
		{
			p__1 = super.addChild(p__1);
			if (p__1){
				LayoutManager.registerContainerChild(p__1);
				this.invalidateLayout();
			}
			return(p__1);
		}
		override public function addChildAt(p__1:flash.display.DisplayObject, p__2:int):flash.display.DisplayObject
		{
			p__1 = super.addChildAt(p__1, p__2);
			if (p__1){
				LayoutManager.registerContainerChild(p__1);
				this.invalidateLayout();
			}
			return(p__1);
		}
		override public function removeChild(p__1:flash.display.DisplayObject):flash.display.DisplayObject
		{
			p__1 = super.removeChild(p__1);
			if (p__1){
				LayoutManager.unregisterContainerChild(p__1);
				this.invalidateLayout();
			}
			return(p__1);
		}
		override public function removeChildAt(p__1:int):flash.display.DisplayObject
		{
			var l__2:flash.display.DisplayObject = super.removeChildAt(p__1);
			if (l__2){
				LayoutManager.unregisterContainerChild(l__2);
				this.invalidateLayout();
			}
			return(l__2);
		}
		public function invalidateLayout():void
		{
			if (this.isValidating){
				return;
			}
			if (isRendering){
				this.validateLayout();
			}
			if ((!this.invalid) && this.stage){
				this.invalid = true;
				this.stage.addEventListener(Event.ENTER_FRAME, renderHandler);
			}
		}
		public function validateLayout():void
		{
			this.isValidating = true;
			this.layout();
			this.isValidating = false;
			this.invalid = false;
		}
		protected function layout():void
		{
			var l__4:Array;
			var l__5:int;
			var l__6:int;
			var l__7:flash.geom.Rectangle;
			var l__1:Number = this.contentWidth;
			var l__2:Number = this.contentHeight;
			this._contentWidth = Number.POSITIVE_INFINITY;
			this._contentHeight = Number.POSITIVE_INFINITY;
			var l__3:flash.geom.Rectangle = new Rectangle();
			if (this.layoutMode){
				l__4 = [];
				l__5 = this.numChildren;
				l__6 = 0;
				while(l__6 < l__5){
					l__4.push(this.getChildAt(l__6));
					l__6++;
				}
				l__3 = this.layoutMode.layoutObjects(l__4, new Rectangle(0, 0, this.width, this.height));
			}
			this._contentWidth = (l__3.x + l__3.width);
			this._contentHeight = (l__3.y + l__3.height);
			if (this.autoMask){
				l__7 = this.scrollRect;
				l__7.width = this.width;
				l__7.height = this.height;
				this.scrollRect = l__7;
			}
			if ((!NumberUtil.fuzzyEquals(this.contentWidth, l__1)) || (!NumberUtil.fuzzyEquals(this.contentHeight, l__2))){
				this.dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_CHANGE));
			}
		}
		private function addedToStageHandler(p__1:flash.events.Event):void
		{
			this.invalidateLayout();
		}
		private function layoutModeChangeHandler(p__1:com.yahoo.astra.layout.events.LayoutEvent):void
		{
			this.invalidateLayout();
		}
		private function renderHandler(p__1:flash.events.Event):void
		{
			isRendering = true;
			p__1.target.removeEventListener(Event.ENTER_FRAME, renderHandler);
			this.validateLayout();
			isRendering = false;
		}
	}
}