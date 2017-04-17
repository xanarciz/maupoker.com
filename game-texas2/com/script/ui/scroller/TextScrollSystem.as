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
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.text.TextField;
	public class TextScrollSystem extends flash.display.MovieClip
	{
		public var thisH:int;
		public var thisW:int;
		public var fakeStage:flash.display.Sprite;
		public var parents:flash.display.DisplayObject;
		public var barH:com.script.ui.scroller.ScrBarH;
		public var masker:flash.display.Sprite;
		public var contents:flash.text.TextField;
		public var barV:com.script.ui.scroller.ScrBarV;
		public var unitLine:int;
		public var barSkin:Object;
		public var unitPage:int;
		public var sPadX:int;
		public var sPadY:int;
		public var bMouseDown:Boolean = false;
		public function TextScrollSystem(p__1:flash.display.DisplayObject, p__2:flash.text.TextField, p__3:int, p__4:int, p__5:Object, p__6:int = 0, p__7:int = 0, p__8:Boolean = true, p__9:Boolean = true, p__10:int = 10, p__11:int = 1)
		{
			parents = p__1;
			contents = p__2;
			thisW = p__3;
			thisH = p__4;
			sPadX = p__6;
			sPadY = p__7;
			unitLine = p__11;
			unitPage = p__10;
			barSkin = p__5;
			fakeStage = new Sprite();
			fakeStage.graphics.beginFill(16711680, 0);
			fakeStage.graphics.drawRect(-1000, -1000, 2000, 2000);
			fakeStage.graphics.endFill();
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
				barV.updateHandle(1);
				addChild(barV);
			}
			if (p__2){
				barH = new ScrBarH(barSkin.trackH.height, thisW, barSkin.arrowLeft, barSkin.arrowRight, barSkin.handleH, barSkin.trackH);
				barH.y = (thisH + sPadY);
				addChild(barH);
			}
			checkContentSize();
		}
		public function updater(p__1:Boolean = false, p__2:Boolean = false):void
		{
			if (p__1){
				if (contents.maxScrollV > 1){
					contents.scrollV = contents.maxScrollV;
				}
			}
			if (p__2){
				if (contents.maxScrollH > 1){
					contents.scrollV = contents.maxScrollV;
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
			if ((contents.maxScrollV > 1) && !(barV == null)){
				barV.setActivity(true);
			}
			if ((contents.maxScrollH > 1) && !(barH == null)){
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
			}
			if (p__2){
				barH.arrowLeft.addEventListener(MouseEvent.CLICK, hArrowUp);
				barH.arrowRight.addEventListener(MouseEvent.CLICK, hArrowDown);
				barH.track.addEventListener(MouseEvent.CLICK, hTrack);
				barH.handle.addEventListener(MouseEvent.MOUSE_DOWN, hHandle);
			}
		}
		public function moveRequestV(p__1:int):void
		{
			var l__2:* = 1;
			var l__3:int = contents.maxScrollV;
			var l__4:int = (contents.scrollV + p__1);
			if (l__4 > l__3){
				l__4 = l__3;
			}
			if (l__4 < l__2){
				l__4 = l__2;
			}
			bMouseDown = true;
			contents.scrollV = l__4;
			var l__5:Number = Math.abs(contents.scrollV - 1) / Math.abs(contents.maxScrollV - 1);
			barV.updateHandle(l__5);
			bMouseDown = false;
		}
		public function vArrowUp(p__1:flash.events.MouseEvent):void
		{
			if (barV.isActive){
				moveRequestV(0 - unitLine);
			}
		}
		public function vArrowDown(p__1:flash.events.MouseEvent):void
		{
			if (barV.isActive){
				moveRequestV(unitLine);
			}
		}
		public function vTrack(p__1:flash.events.MouseEvent):void
		{
			if (barV.isActive){
				if (barV.mouseY < barV.handle.y){
					moveRequestV(0 - unitPage);
				}
				if (barV.mouseY > (barV.handle.y + barV.handle.height)){
					moveRequestV(unitPage);
				}
			}
		}
		public function vHandle(p__1:flash.events.MouseEvent):void
		{
			if (barV.isActive){
				bMouseDown = true;
				parents.addChild(fakeStage);
				fakeStage.addEventListener(MouseEvent.MOUSE_MOVE, vSlideHandle);
				fakeStage.addEventListener(MouseEvent.MOUSE_UP, killFakeStageV);
				fakeStage.addEventListener(Event.MOUSE_LEAVE, killFakeStageV);
			}
		}
		public function vHandleUp(p__1:flash.events.MouseEvent):void
		{
			bMouseDown = false;
		}
		public function killFakeStageV(p__1:*):void
		{
			bMouseDown = false;
			fakeStage.removeEventListener(MouseEvent.MOUSE_MOVE, vSlideHandle);
			fakeStage.removeEventListener(MouseEvent.MOUSE_UP, killFakeStageV);
			parents.removeChild(fakeStage);
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
			var l__3:Number;
			var l__2:Number = contents.maxScrollV - 1;
			if (l__2 < 1){
				l__3 = Math.round(p__1);
			} else {
				l__3 = Math.round(l__2 * (p__1));
			}
			contents.scrollV = (l__3 + 1);
		}
		public function vAdjustHandle(p__1:Boolean):void
		{
			var l__2:Number;
			if (p__1){
				barV.updateHandle(1);
			} else if (!(p__1)){
				l__2 = Math.abs(contents.scrollV - 1) / Math.abs(contents.maxScrollV - 1);
				barV.updateHandle(l__2);
			}
		}
	}
}