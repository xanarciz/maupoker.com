// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.ui.scroller
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	public class ScrollSystem extends flash.display.MovieClip
	{
		public var thisH:int;
		public var thisW:int;
		public var fakeStage:flash.display.Sprite;
		public var parents:flash.display.DisplayObject;
		public var barH:com.script.ui.scroller.ScrBarH;
		public var masker:flash.display.Sprite;
		public var contents:flash.display.DisplayObject;
		public var hasScrolledH:Boolean = false;
		public var barV:com.script.ui.scroller.ScrBarV;
		public var unitLine:int;
		public var barSkin:Object;
		public var unitPage:int;
		public var sPadX:int;
		public var sPadY:int;
		public var hasScrolledV:Boolean = false;
		public function ScrollSystem(p__1:flash.display.DisplayObject, p__2:flash.display.DisplayObject, p__3:int, p__4:int, p__5:Object, p__6:int = 0, p__7:int = 0, p__8:Boolean = true, p__9:Boolean = true, p__10:int = 10, p__11:int = 40)
		{
			parents = p__1;
			contents = p__2;
			thisW = p__3;
			thisH = p__4;
			sPadX = p__6;
			sPadY = p__7;
			unitLine = p__10;
			unitPage = p__11;
			barSkin = p__5;
			fakeStage = new Sprite();
			fakeStage.graphics.beginFill(16711680, 0);
			fakeStage.graphics.drawRect(-1000, -1000, 2000, 2000);
			fakeStage.graphics.endFill();
			if (parents.stage != null){
				parents.stage.addEventListener(Event.MOUSE_LEAVE, killFakeStageV);
			}
			initMaskContent();
			initScrollBars(p__8, p__9);
			initBarListeners(p__8, p__9);
		}
		public function initMaskContent():void
		{
			masker = new Sprite();
			masker.graphics.beginFill(0, 1);
			masker.graphics.drawRect(0, 0, thisW, thisH);
			masker.graphics.endFill();
			addChild(masker);
			addChild(contents);
			contents.mask = masker;
		}
		public function initScrollBars(p__1:Boolean, p__2:Boolean):void
		{
			if (p__1){
				barV = new ScrBarV(thisH, barSkin.trackV.width, barSkin.arrowUp, barSkin.arrowDown, barSkin.handleV, barSkin.trackV);
				barV.x = (thisW + sPadX);
				addChild(barV);
			}
			if (p__2){
				barH = new ScrBarH(barSkin.trackH.height, thisW, barSkin.arrowLeft, barSkin.arrowRight, barSkin.handleH, barSkin.trackH);
				barH.y = (thisH + sPadY);
				addChild(barH);
			}
			checkContentSize();
		}
		public function updater(p__1:Boolean = true, p__2:Boolean = true):void
		{
			if (p__1){
				if (contents.height > thisH){
					contents.y = (thisH - contents.height);
				}
				if (barV != null){
					barV.updateHandle(1);
				}
			}
			if (p__2){
				if (contents.width > thisW){
					contents.x = (thisW - contents.width);
				}
				if (barH != null){
					barH.updateHandle(1);
				}
			}
			checkContentSize();
		}
		public function checkContentSize():void
		{
			if (barV != null){
				barV.setActivity(false);
			}
			if (barH != null){
				barH.setActivity(false);
			}
			if ((contents.height > thisH) && !(barV == null)){
				barV.setActivity(true);
			}
			if ((contents.width > thisW) && !(barH == null)){
				barH.setActivity(true);
			}
		}
		public function initBarListeners(p__1:Boolean, p__2:Boolean):void
		{
			if (p__1){
				barV.arrowUp.addEventListener(MouseEvent.CLICK, vArrowUp);
				barV.arrowDown.addEventListener(MouseEvent.CLICK, vArrowDown);
				barV.track.addEventListener(MouseEvent.CLICK, vTrack);
				barV.handle.addEventListener(MouseEvent.MOUSE_DOWN, vHandle);
				barV.useHandCursor = false;
			}
			if (p__2){
				barH.arrowLeft.addEventListener(MouseEvent.CLICK, hArrowUp);
				barH.arrowRight.addEventListener(MouseEvent.CLICK, hArrowDown);
				barH.track.addEventListener(MouseEvent.CLICK, hTrack);
				barH.handle.addEventListener(MouseEvent.MOUSE_DOWN, hHandle);
				barH.useHandCursor = false;
			}
		}
		public function updateSize(p__1:int, p__2:int):void
		{
		}
		public function moveRequestV(p__1:int):void
		{
			var l__2:int;
			if (!hasScrolledV){
				hasScrolledV = true;
			}
			if (contents.height <= thisH){
				l__2 = 0;
			}
			if (contents.height > thisH){
				l__2 = (thisH - contents.height);
			}
			var l__3:int;
			var l__4:int = (contents.y + p__1);
			if (l__4 > l__3){
				l__4 = l__3;
			}
			if (l__4 < l__2){
				l__4 = l__2;
			}
			contents.y = l__4;
			var l__5:Number = Math.abs(contents.y) / Math.abs(l__2);
			barV.updateHandle(l__5);
		}
		public function vArrowUp(p__1:flash.events.MouseEvent):void
		{
			if (barV.isActive){
				moveRequestV(unitLine);
			}
		}
		public function vArrowDown(p__1:flash.events.MouseEvent):void
		{
			if (barV.isActive){
				moveRequestV(0 - unitLine);
			}
		}
		public function vTrack(p__1:flash.events.MouseEvent):void
		{
			if (barV.isActive){
				if (barV.mouseY < barV.handle.y){
					moveRequestV(unitPage);
				}
				if (barV.mouseY > (barV.handle.y + barV.handle.height)){
					moveRequestV(0 - unitPage);
				}
			}
		}
		public function vHandle(p__1:flash.events.MouseEvent):void
		{
			if (barV.isActive){
				if (!hasScrolledV){
					hasScrolledV = true;
				}
				parents.addChild(fakeStage);
				fakeStage.addEventListener(MouseEvent.MOUSE_MOVE, vSlideHandle);
				fakeStage.addEventListener(MouseEvent.MOUSE_UP, killFakeStageV);
				fakeStage.useHandCursor = false;
			}
		}
		public function mouseLeaveStage(p__1:flash.events.Event):void
		{
		}
		public function killFakeStageV(p__1:flash.events.Event):void
		{
			fakeStage.removeEventListener(MouseEvent.MOUSE_MOVE, vSlideHandle);
			fakeStage.removeEventListener(MouseEvent.MOUSE_UP, killFakeStageV);
			if (fakeStage.parent != null){
				parents.removeChild(fakeStage);
			} else {
			}
		}
		public function vSlideHandle(p__1:flash.events.MouseEvent):void
		{
			var l__2:int = barV.mouseY;
			if (l__2 < barV.arrowUp.height){
				l__2 = barV.arrowUp.height;
			}
			if (l__2 > ((barV.height - barV.arrowDown.height) - barV.handle.height)){
				l__2 = ((barV.height - barV.arrowDown.height) - barV.handle.height);
			}
			barV.handle.y = l__2;
			var l__3:Number = getVertHandlePlace();
			vSlideContent(l__3);
		}
		public function getVertHandlePlace():Number
		{
			var l__1:Number = ((barV.handle.y - barV.arrowUp.height)) / (((((barV.height - barV.arrowUp.height) - barV.arrowDown.height) - barV.handle.height)));
			return(l__1);
		}
		public function vSlideContent(p__1:Number):void
		{
			var l__2:Number = (thisH - contents.height);
			var l__3:Number = Math.round(l__2 * (p__1));
			contents.y = l__3;
		}
		public function moveRequestH(p__1:int):void
		{
			var l__2:int;
			if (!hasScrolledH){
				hasScrolledH = true;
			}
			if (contents.width <= thisW){
				l__2 = 0;
			}
			if (contents.width > thisW){
				l__2 = (thisW - contents.width);
			}
			var l__3:int;
			var l__4:int = (contents.x + p__1);
			if (l__4 > l__3){
				l__4 = l__3;
			}
			if (l__4 < l__2){
				l__4 = l__2;
			}
			contents.x = l__4;
			var l__5:Number = Math.abs(contents.x) / Math.abs(l__2);
			barH.updateHandle(l__5);
		}
		public function hArrowUp(p__1:flash.events.MouseEvent):void
		{
			if (barH.isActive){
				moveRequestH(unitLine);
			}
		}
		public function hArrowDown(p__1:flash.events.MouseEvent):void
		{
			if (barH.isActive){
				moveRequestH(0 - unitLine);
			}
		}
		public function hTrack(p__1:flash.events.MouseEvent):void
		{
			if (barH.isActive){
				if (barH.mouseX < barH.handle.x){
					moveRequestH(unitPage);
				}
				if (barH.mouseX > (barH.handle.x + barH.handle.width)){
					moveRequestH(0 - unitPage);
				}
			}
		}
		public function hHandle(p__1:flash.events.MouseEvent):void
		{
			if (barH.isActive){
				if (!hasScrolledH){
					hasScrolledH = true;
				}
				parents.addChild(fakeStage);
				fakeStage.addEventListener(MouseEvent.MOUSE_MOVE, hSlideHandle);
				fakeStage.addEventListener(MouseEvent.MOUSE_UP, killFakeStageH);
				fakeStage.useHandCursor = false;
			}
		}
		public function killFakeStageH(p__1:flash.events.MouseEvent):void
		{
			fakeStage.removeEventListener(MouseEvent.MOUSE_MOVE, hSlideHandle);
			fakeStage.removeEventListener(MouseEvent.MOUSE_UP, killFakeStageH);
			parents.removeChild(fakeStage);
		}
		public function hSlideHandle(p__1:flash.events.MouseEvent):void
		{
			var l__2:int = barH.mouseX;
			if (l__2 < barH.arrowLeft.width){
				l__2 = barH.arrowLeft.width;
			}
			if (l__2 > ((barH.width - barH.arrowRight.width) - barH.handle.width)){
				l__2 = ((barH.width - barH.arrowRight.width) - barH.handle.width);
			}
			barH.handle.x = l__2;
			var l__3:Number = getHorzHandlePlace();
			hSlideContent(l__3);
		}
		public function getHorzHandlePlace():Number
		{
			var l__1:Number = ((barH.handle.x - barH.arrowLeft.width)) / (((((barH.width - barH.arrowLeft.width) - barH.arrowRight.width) - barH.handle.width)));
			return(l__1);
		}
		public function hSlideContent(p__1:Number):void
		{
			var l__2:Number = (thisW - contents.width);
			var l__3:Number = Math.round(l__2 * (p__1));
			contents.x = l__3;
		}
	}
}