// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.fl.containers.layoutClasses
{
	import fl.core.UIComponent;
	import fl.core.InvalidationType;
	import fl.controls.*;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import com.yahoo.astra.layout.modes.ILayoutMode;
	import com.yahoo.astra.layout.events.LayoutEvent;
	import fl.events.*;
	import flash.utils.*;
	import com.yahoo.astra.layout.ILayoutContainer;
	import com.yahoo.astra.layout.LayoutManager;
	import com.yahoo.astra.layout.LayoutContainer;
	import com.yahoo.astra.utils.*;
	import com.yahoo.astra.fl.utils.*;
	import fl.containers.BaseScrollPane;
	public class BaseLayoutPane extends fl.containers.BaseScrollPane
	{
		protected var debugCanvas:flash.display.Sprite;
		private var _uiConfigured:Boolean = false;
		private var _layoutMode:com.yahoo.astra.layout.modes.ILayoutMode;
		private var _debugMode:Boolean = false;
		private var _autoSize:Boolean = false;
		protected var explicitWidth:Number = NaN;
		protected var layoutContainer:com.yahoo.astra.layout.ILayoutContainer;
		protected var explicitHeight:Number = NaN;
		private static var defaultStyles:Object = {skin:Shape, focusRectSkin:null, focusRectPadding:null, contentPadding:0};
		protected static const INVALIDATION_TYPE_DEBUG_MODE:String = "debugModeInvalid";
		protected static const INVALIDATION_TYPE_LAYOUT:String = "layoutInvalid";
		initializeLayoutEvents();
		public function BaseLayoutPane(p__1:com.yahoo.astra.layout.modes.ILayoutMode = null)
		{
			this.layoutMode = p__1;
		}
		public function get layoutMode():com.yahoo.astra.layout.modes.ILayoutMode
		{
			return(this._layoutMode);
		}
		public function set layoutMode(p__1:com.yahoo.astra.layout.modes.ILayoutMode):void
		{
			this._layoutMode = p__1;
			this.invalidate(INVALIDATION_TYPE_LAYOUT);
		}
		override public function set width(p__1:Number):void
		{
			this.setSize(p__1, this.explicitHeight);
		}
		override public function set height(p__1:Number):void
		{
			this.setSize(this.explicitWidth, p__1);
		}
		override public function get horizontalPageScrollSize():Number
		{
			return(((this._horizontalPageScrollSize == 0) && (!isNaN(this.availableWidth))) ? this.availableWidth : this._horizontalPageScrollSize);
		}
		override public function get verticalPageScrollSize():Number
		{
			return(((this._verticalPageScrollSize == 0) && (!isNaN(this.availableHeight))) ? this.availableHeight : this._verticalPageScrollSize);
		}
		override public function get numChildren():int
		{
			if (!this._uiConfigured){
				return(super.numChildren);
			}
			var l__1:flash.display.DisplayObjectContainer = DisplayObjectContainer(this.layoutContainer);
			return(l__1.numChildren);
		}
		public function get autoSize():Boolean
		{
			return(this._autoSize);
		}
		public function set autoSize(p__1:Boolean):void
		{
			this._autoSize = p__1;
			this.invalidate(InvalidationType.SIZE);
		}
		public function get debugMode():Boolean
		{
			return(this._debugMode);
		}
		public function set debugMode(p__1:Boolean):void
		{
			this._debugMode = p__1;
			this.invalidate(INVALIDATION_TYPE_DEBUG_MODE);
		}
		override public function addChild(p__1:flash.display.DisplayObject):flash.display.DisplayObject
		{
			if (!this._uiConfigured){
				return(super.addChild(p__1));
			}
			var l__2:flash.display.DisplayObjectContainer = DisplayObjectContainer(this.layoutContainer);
			p__1 = l__2.addChild(p__1);
			this.invalidate(INVALIDATION_TYPE_LAYOUT);
			return(p__1);
		}
		override public function addChildAt(p__1:flash.display.DisplayObject, p__2:int):flash.display.DisplayObject
		{
			if (!this._uiConfigured){
				return(super.addChildAt(p__1, p__2));
			}
			var l__3:flash.display.DisplayObjectContainer = DisplayObjectContainer(this.layoutContainer);
			p__1 = l__3.addChildAt(p__1, p__2);
			this.invalidate(INVALIDATION_TYPE_LAYOUT);
			return(p__1);
		}
		override public function removeChild(p__1:flash.display.DisplayObject):flash.display.DisplayObject
		{
			if (!this._uiConfigured){
				return(super.removeChild(p__1));
			}
			var l__2:flash.display.DisplayObjectContainer = DisplayObjectContainer(this.layoutContainer);
			p__1 = l__2.removeChild(p__1);
			this.invalidate(INVALIDATION_TYPE_LAYOUT);
			return(p__1);
		}
		override public function removeChildAt(p__1:int):flash.display.DisplayObject
		{
			if (!this._uiConfigured){
				return(super.removeChildAt(p__1));
			}
			var l__2:flash.display.DisplayObjectContainer = DisplayObjectContainer(this.layoutContainer);
			var l__3:flash.display.DisplayObject = l__2.removeChildAt(p__1);
			this.invalidate(INVALIDATION_TYPE_LAYOUT);
			return(l__3);
		}
		override public function setChildIndex(p__1:flash.display.DisplayObject, p__2:int):void
		{
			if (!this._uiConfigured){
				super.setChildIndex(p__1, p__2);
				return;
			}
			var l__3:flash.display.DisplayObjectContainer = DisplayObjectContainer(this.layoutContainer);
			l__3.setChildIndex(p__1, p__2);
			this.invalidate(INVALIDATION_TYPE_LAYOUT);
		}
		override public function getChildAt(p__1:int):flash.display.DisplayObject
		{
			if (!this._uiConfigured){
				return(super.getChildAt(p__1));
			}
			var l__2:flash.display.DisplayObjectContainer = DisplayObjectContainer(this.layoutContainer);
			return(l__2.getChildAt(p__1));
		}
		override public function getChildByName(p__1:String):flash.display.DisplayObject
		{
			if (!this._uiConfigured){
				return(super.getChildByName(p__1));
			}
			var l__2:flash.display.DisplayObjectContainer = DisplayObjectContainer(this.layoutContainer);
			return(l__2.getChildByName(p__1));
		}
		override public function setSize(p__1:Number, p__2:Number):void
		{
			this.explicitWidth = p__1;
			this.explicitHeight = p__2;
			if (isNaN(p__1)){
				p__1 = this._width;
			}
			if (isNaN(p__2)){
				p__2 = this._height;
			}
			super.setSize(p__1, p__2);
		}
		override protected function configUI():void
		{
			var l__1:flash.display.DisplayObject;
			var l__2:flash.display.DisplayObject;
			if (this.numChildren > 0){
				l__1 = this.getChildAt(0);
			}
			super.configUI();
			if (!l__1){
				this.setSize(NaN, NaN);
			}
			if (!this.layoutContainer){
				this.layoutContainer = new LayoutContainer();
				LayoutContainer(this.layoutContainer).autoMask = false;
				this.layoutContainer.addEventListener(LayoutEvent.LAYOUT_CHANGE, layoutChangeHandler);
				l__2 = DisplayObject(this.layoutContainer);
				l__2.scrollRect = contentScrollRect;
				l__2.visible = false;
				this.addChild(l__2);
			}
			if (!this.debugCanvas){
				this.debugCanvas = new Sprite();
				this.addChild(this.debugCanvas);
			}
			this._horizontalScrollPolicy = ScrollPolicy.AUTO;
			this._verticalScrollPolicy = ScrollPolicy.AUTO;
			this._uiConfigured = true;
		}
		override protected function draw():void
		{
			var l__1:Number = 0;
			var l__2:Number = 0;
			var l__3:flash.display.DisplayObjectContainer;
			var l__4:int;
			var l__5:* = undefined;
			var l__6:* = undefined;
			var l__7:* = undefined;
			var l__8:* = undefined;
			DisplayObject(this.layoutContainer).visible = true;
			this.redrawUIComponentChildren();
			if (this.isInvalid(InvalidationType.SIZE, INVALIDATION_TYPE_LAYOUT)){
				l__1 = this.width;
				l__2 = this.height;
				l__3 = DisplayObjectContainer(this.layoutContainer);
				this.layoutContainer.layoutMode = this.layoutMode;
				if (this.autoSize || isNaN(this.explicitWidth)){
					l__3.width = NaN;
				} else {
					l__3.width = this.explicitWidth;
				}
				if (this.autoSize || isNaN(this.explicitHeight)){
					l__3.height = NaN;
				} else {
					l__3.height = this.explicitHeight;
				}
				this.layoutContainer.validateLayout();
				this.setContentSize(Math.floor(this.layoutContainer.contentWidth), Math.floor(this.layoutContainer.contentHeight));
				this.calculateAvailableSize();
				l__4 = 0;
				do {
					l__5 = this.availableWidth;
					l__6 = this.availableHeight;
					l__3.width = this.availableWidth;
					l__3.height = this.availableHeight;
					this.layoutContainer.validateLayout();
					if (isNaN(this.explicitWidth) || this.autoSize){
						l__7 = this.layoutContainer.contentWidth;
						if (this.vScrollBar){
							l__7 = (l__7 + ScrollBar.WIDTH);
						}
						this._width = Math.round(l__7);
					}
					if (isNaN(this.explicitHeight) || this.autoSize){
						l__8 = this.layoutContainer.contentHeight;
						if (this.hScrollBar){
							l__8 = (l__8 + ScrollBar.WIDTH);
						}
						this._height = Math.round(l__8);
					}
					this.setContentSize(Math.floor(this.layoutContainer.contentWidth), Math.floor(this.layoutContainer.contentHeight));
					this.calculateAvailableSize();
					l__4++;
				} while (((!NumberUtil.fuzzyEquals(l__5, this.availableWidth, 10)) || (!NumberUtil.fuzzyEquals(l__6, this.availableHeight))) && (l__4 < 10))
				this.redrawUIComponentChildren();
				this.graphics.clear();
				if ((this.width > 0) && (this.height > 0)){
					this.graphics.beginFill(16711935, 0);
					this.graphics.drawRect(0, 0, this.width, this.height);
					this.graphics.endFill();
				}
				if ((!NumberUtil.fuzzyEquals(l__1, this.width)) || (!NumberUtil.fuzzyEquals(l__2, this.height))){
					this.dispatchEvent(new ComponentEvent(ComponentEvent.RESIZE));
				}
			}
			if (this.debugMode && this.isInvalid(INVALIDATION_TYPE_DEBUG_MODE, InvalidationType.SIZE, INVALIDATION_TYPE_LAYOUT)){
				this.debugCanvas.graphics.clear();
				this.debugCanvas.graphics.lineStyle(1, 16711935);
				this.debugCanvas.graphics.drawRect(0, 0, this.width, this.height);
			}
			this.debugCanvas.visible = this.debugMode;
			super.draw();
		}
		override protected function drawLayout():void
		{
			super.drawLayout();
			var l__1:flash.display.DisplayObject = DisplayObject(this.layoutContainer);
			this.contentScrollRect = l__1.scrollRect;
			this.contentScrollRect.width = this.availableWidth;
			this.contentScrollRect.height = this.availableHeight;
			l__1.cacheAsBitmap = useBitmapScrolling;
			l__1.scrollRect = this.contentScrollRect;
		}
		override protected function drawBackground():void
		{
			var l__1:flash.display.DisplayObject = this.background;
			this.background = UIComponentUtil.getDisplayObjectInstance(this, this.getStyleValue("skin"));
			this.background.width = this.width;
			this.background.height = this.height;
			super.addChildAt(this.background, 0);
			if (!(l__1 == null) && !(l__1 == background)){
				super.removeChild(l__1);
			}
		}
		protected function redrawUIComponentChildren():void
		{
			var l__3:fl.core.UIComponent;
			var l__1:flash.display.DisplayObjectContainer = DisplayObjectContainer(this.layoutContainer);
			var l__2:int;
			while(l__2 < l__1.numChildren){
				l__3 = (l__1.getChildAt(l__2) as UIComponent);
				if (l__3){
					l__3.drawNow();
				}
				l__2++;
			}
		}
		override protected function setVerticalScrollPosition(p__1:Number, p__2:Boolean = false):void
		{
			var l__3:flash.display.DisplayObject = DisplayObject(this.layoutContainer);
			var l__4:flash.geom.Rectangle = l__3.scrollRect;
			l__4.y = p__1;
			l__3.scrollRect = l__4;
		}
		override protected function setHorizontalScrollPosition(p__1:Number, p__2:Boolean = false):void
		{
			var l__3:flash.display.DisplayObject = DisplayObject(this.layoutContainer);
			var l__4:flash.geom.Rectangle = l__3.scrollRect;
			l__4.x = p__1;
			l__3.scrollRect = l__4;
		}
		override protected function calculateAvailableSize():void
		{
			super.calculateAvailableSize();
			if (isNaN(this.explicitWidth) || this.autoSize){
				this.availableWidth = this.layoutContainer.contentWidth;
				this.hScrollBar = false;
			}
			if (isNaN(this.explicitHeight) || this.autoSize){
				this.availableHeight = this.layoutContainer.contentHeight;
				this.vScrollBar = false;
			}
		}
		protected function layoutChangeHandler(p__1:com.yahoo.astra.layout.events.LayoutEvent):void
		{
			this.invalidate(INVALIDATION_TYPE_LAYOUT);
		}
		public static function getStyleDefinition():Object
		{
			return(mergeStyles(defaultStyles, BaseScrollPane.getStyleDefinition()));
		}
		private static function initializeLayoutEvents():void
		{
			var uiLoader:Class;
			LayoutManager.registerInvalidatingEvents(UIComponent, [ComponentEvent.MOVE, ComponentEvent.RESIZE]);
			try {
				uiLoader = (getDefinitionByName("fl.containers.UILoader") as Class);
				if (uiLoader){
					LayoutManager.registerInvalidatingEvents(uiLoader, [Event.COMPLETE]);
				}
			} catch (error:Error) {
			}
		}
	}
}