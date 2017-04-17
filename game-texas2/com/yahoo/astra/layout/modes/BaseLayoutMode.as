// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.yahoo.astra.layout.modes
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import com.yahoo.astra.layout.events.*;
	public class BaseLayoutMode extends flash.events.EventDispatcher implements IAdvancedLayoutMode
	{
		protected var clients:Array = [];
		private var _paddingBottom:Number = 0;
		private var _paddingTop:Number = 0;
		private var _paddingRight:Number = 0;
		private var _paddingLeft:Number = 0;
		protected var configurations:Array = [];
		public function BaseLayoutMode()
		{
		}
		public function get paddingLeft():Number
		{
			return(this._paddingLeft);
		}
		public function set paddingLeft(p__1:Number):void
		{
			if (this._paddingLeft != p__1){
				this._paddingLeft = p__1;
				this.dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_CHANGE));
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
				this.dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_CHANGE));
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
				this.dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_CHANGE));
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
				this.dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_CHANGE));
			}
		}
		public function addClient(p__1:flash.display.DisplayObject, p__2:Object = null):void
		{
			var l__4:String;
			var l__5:int;
			if (!p__1){
				throw new ArgumentError(("Target must be a DisplayObject. Received " + p__1) + ".");
			}
			p__2 = p__2 ? p__2 : {};
			var l__3:Object = this.newConfiguration();
			for (l__4 in p__2){
				l__3[l__4] = p__2[l__4];
			}
			l__5 = this.clients.indexOf(p__1);
			if (l__5 < 0){
				l__5 = this.clients.length;
				this.clients[l__5] = p__1;
			}
			this.configurations[l__5] = l__3;
			this.dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_CHANGE));
		}
		public function removeClient(p__1:flash.display.DisplayObject):void
		{
			var l__2:int = this.clients.indexOf(p__1);
			if (l__2 < 0){
				throw new ArgumentError("Cannot call removeClient() with a DisplayObject that is not a client.");
			}
			this.clients.splice(l__2, 1);
			this.configurations.splice(l__2, 1);
			this.dispatchEvent(new LayoutEvent(LayoutEvent.LAYOUT_CHANGE));
		}
		public function hasClient(p__1:flash.display.DisplayObject):Boolean
		{
			return(this.clients.indexOf(p__1) >= 0);
		}
		public function layoutObjects(p__1:Array, p__2:flash.geom.Rectangle):flash.geom.Rectangle
		{
			throw new Error("Method BaseLayoutMode.layoutChildren() must be overridden!");
		}
		protected function configureChildren(p__1:Array):Array
		{
			var l__5:flash.display.DisplayObject;
			var l__6:int;
			var l__7:Object;
			var l__2:Array = [];
			var l__3:int = p__1.length;
			var l__4:int;
			while(l__4 < l__3){
				l__5 = DisplayObject(p__1[l__4]);
				l__6 = this.clients.indexOf(l__5);
				if (l__6 < 0){
					l__6 = this.clients.length;
					this.clients.push(l__5);
					this.configurations.push(this.newConfiguration());
				}
				l__7 = this.configurations[l__6];
				if (l__7.includeInLayout){
					l__2.push(l__5);
				}
				l__4++;
			}
			return(l__2);
		}
		protected function newConfiguration():Object
		{
			return({includeInLayout:true});
		}
	}
}