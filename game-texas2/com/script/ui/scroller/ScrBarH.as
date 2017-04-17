// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.ui.scroller
{
	import flash.display.*;
	import flash.events.*;
	public class ScrBarH extends flash.display.MovieClip
	{
		public var thisH:int;
		public var thisW:int;
		public var handle:flash.display.DisplayObject;
		public var track:flash.display.DisplayObject;
		public var isActive:Boolean;
		public var trackW:int;
		public var arrowLeft:flash.display.DisplayObject;
		public var arrowRight:flash.display.DisplayObject;
		public var bVert:Boolean;
		public function ScrBarH(p__1:int, p__2:int, p__3:flash.display.DisplayObject, p__4:flash.display.DisplayObject, p__5:flash.display.DisplayObject, p__6:flash.display.DisplayObject)
		{
			thisH = p__1;
			thisW = p__2;
			arrowLeft = p__3;
			arrowRight = p__4;
			handle = p__5;
			track = p__6;
			initGfx();
			initHandCursor();
		}
		public function initGfx():void
		{
			addChild(arrowLeft);
			addChild(arrowRight);
			arrowRight.x = thisW;
			addChild(track);
			track.height = thisH;
			track.width = ((thisW - arrowLeft.width) - arrowRight.width);
			track.x = arrowLeft.width;
			addChild(handle);
			handle.x = arrowLeft.width;
			trackW = ((thisW - arrowLeft.width) - arrowRight.width);
		}
		public function initHandCursor():void
		{
			var l__2:flash.display.DisplayObject;
			var l__1:int;
			while(l__1 < this.numChildren){
				l__2 = this.getChildAt(l__1);
				l__2.buttonMode = true;
				this.useHandCursor = true;
				l__1++;
			}
		}
		public function updateHandle(p__1:Number):void
		{
			handle.x = (Math.round((trackW - handle.width) * (p__1)) + arrowLeft.width);
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