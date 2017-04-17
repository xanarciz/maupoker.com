// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.ui.scroller
{
	import flash.display.*;
	import flash.events.*;
	public class ScrBarV extends flash.display.MovieClip
	{
		public var thisH:int;
		public var thisW:int;
		public var handle:flash.display.DisplayObject;
		public var arrowUp:flash.display.DisplayObject;
		public var track:flash.display.DisplayObject;
		public var trackH:int;
		public var isActive:Boolean;
		public var arrowDown:flash.display.DisplayObject;
		public function ScrBarV(p__1:int, p__2:int, p__3:flash.display.DisplayObject, p__4:flash.display.DisplayObject, p__5:flash.display.DisplayObject, p__6:flash.display.DisplayObject)
		{
			thisH = p__1;
			thisW = p__2;
			arrowUp = p__3;
			arrowDown = p__4;
			handle = p__5;
			track = p__6;
			initGfx();
			initHandCursor();
		}
		public function initGfx():void
		{
			addChild(arrowUp);
			addChild(arrowDown);
			arrowDown.y = thisH;
			addChild(track);
			track.height = ((thisH - arrowUp.height) - arrowDown.height);
			track.y = arrowUp.height;
			addChild(handle);
			handle.y = arrowUp.height;
			trackH = ((thisH - arrowUp.height) - arrowDown.height);
		}
		public function initHandCursor():void
		{
			var l__2:flash.display.DisplayObject;
			var l__1:int;
			while(l__1 < this.numChildren){
				l__2 = this.getChildAt(l__1);
				l__2.buttonMode = false;
				this.useHandCursor = false;
				l__1++;
			}
		}
		public function updateHandle(p__1:Number):void
		{
			handle.y = (Math.round((trackH - handle.height) * (p__1)) + arrowUp.height);
		}
		public function setActivity(p__1:Boolean):void
		{
			isActive = p__1;
			handle.visible = isActive;
			if (isActive){
				this.alpha = 1;
			}
			if (!isActive){
				this.alpha = 0.5;
			}
		}
	}
}