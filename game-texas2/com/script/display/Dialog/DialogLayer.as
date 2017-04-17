// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.display.Dialog
{
	import flash.events.*;
	import flash.display.*;
	public class DialogLayer extends flash.display.Sprite
	{
		private var stack:Array;
		private var locked:Boolean = false;
		private var wide:*;
		private var top:*;
		public var hideAction:*;
		public var showAction:*;
		private var bgpanel:*;
		private var high:*;
		public function DialogLayer(p__1:*, p__2:*, p__3:* = null, p__4:* = null, p__5:* = null):void
		{
			stack = new Array();
			wide = p__1;
			high = p__2;
			showAction = p__4;
			hideAction = p__5;
			if (p__3){
				bgpanel = new p__3();
				bgpanel.width = p__1;
				bgpanel.height = p__2;
				bgpanel.visible = false;
				addChild(bgpanel);
			}
			com.script.display.Dialog.DialogEvent.disp.addEventListener(com.script.display.Dialog.DialogEvent.ACTIVE, onActive);
			com.script.display.Dialog.DialogEvent.disp.addEventListener(com.script.display.Dialog.DialogEvent.ISOLATE, onIsolate);
			com.script.display.Dialog.DialogEvent.disp.addEventListener(com.script.display.Dialog.DialogEvent.RELEASE, onReleaser);
			com.script.display.Dialog.DialogEvent.disp.addEventListener(com.script.display.Dialog.DialogEvent.CLOSED, onClosed);
			com.script.display.Dialog.DialogEvent.disp.addEventListener(com.script.display.Dialog.DialogEvent.CLOSE, onClose);
			com.script.display.Dialog.DialogEvent.disp.addEventListener(com.script.display.Dialog.DialogEvent.OPEN, onOpen);
			com.script.display.Dialog.DialogEvent.disp.addEventListener(com.script.display.Dialog.DialogEvent.ALONE, onAlone);
		}
		public function add(p__1:*):void
		{
			stack.AS3::push(p__1);
			p__1.hide(null, true);
			p__1.init();
			addChild(p__1);
			top = p__1;
			p__1.x = (wide / 2 - ((p__1.realWide) / 2));
			p__1.y = (high / 2 - ((p__1.realHigh) / 2));
			
		}
		public function prioritize(p__1:*):void
		{
			if ((!locked) && ((p__1.parent) == this)){
				setChildIndex(p__1, 1);
				top = p__1;
			}
		}
		public function isolate(p__1:*):void
		{
			var l__2:* = undefined;
			release();
			locked = true;
			for each (l__2 in stack){
				if (l__2 != (p__1)){
					l__2.disable();
				}
			}
		}
		public function release():void
		{
			var l__1:* = undefined;
			locked = false;
			for each (l__1 in stack){
				l__1.enable();
			}
		}
		public function alone(p__1:*)
		{
			var l__2:* = undefined;
			for each (l__2 in stack){
				l__2.enable();
				if (l__2 != (p__1)){
					l__2.hide();
				}
			}
		}
		private function anyActive():void
		{
			var l__2:* = undefined;
			var l__1:Boolean;
			for each (l__2 in stack){
				if (l__2.shown == true){
					l__1 = true;
				}
			}
			if (l__1){
				bgpanel.visible = true;
				if (showAction){
					showAction(bgpanel);
				}
			} else if (hideAction){
				hideAction(bgpanel);
			} else {
				bgpanel.visible = false;
			}
		}
		private function isPresent(p__1:*):Boolean
		{
			var l__2:* = undefined;
			for each (l__2 in stack){
				if (l__2 == (p__1)){
					return(true);
				}
			}
			return(false);
		}
		private function onActive(p__1:com.script.display.Dialog.DialogEvent):void
		{
			if (isPresent(p__1.data)){
				prioritize(p__1.data);
			}
		}
		private function onIsolate(p__1:com.script.display.Dialog.DialogEvent):void
		{
			if (isPresent(p__1.data)){
				isolate(p__1.data);
			}
		}
		private function onReleaser(p__1:com.script.display.Dialog.DialogEvent):void
		{
			if (isPresent(p__1.data)){
				release();
			}
		}
		private function onOpen(p__1:com.script.display.Dialog.DialogEvent):void
		{
			if (isPresent(p__1.data)){
				anyActive();
			}
			prioritize(p__1.data);
			if (p__1.data.modal){
				isolate(p__1.data);
			}
		}
		private function onClosed(p__1:com.script.display.Dialog.DialogEvent):void
		{
			if (isPresent(p__1.data)){
				anyActive();
			}
			release();
		}
		private function onClose(p__1:com.script.display.Dialog.DialogEvent):void
		{
			(p__1.data).hide();
		}
		private function onAlone(p__1:com.script.display.Dialog.DialogEvent):void
		{
			alone(p__1.data);
		}
	}
}