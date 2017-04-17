// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.display.Dialog
{
	import flash.events.*;
	import flash.geom.*;
	import flash.display.*;
	import flash.text.*;
	public class DialogBox extends flash.display.Sprite
	{
		private var buttonIndex:Array;
		private var origh:*;
		public var locked:Boolean = false;
		private var titleItem:*;
		public var shown:Boolean = false;
		public var wide:Number = 0;
		private var bodyItem:*;
		private var origw:*;
		public var cancelable:Boolean = true;
		private var buttonOffset:Number = 0;
		public var high:Number = 0;
		public var module:*;
		public var modal:Boolean = false;
		private var content:flash.display.Sprite;
		public var type:Number = 0;
		private var skin:com.script.display.Dialog.DialogSkin;
		public static const COMPLEX:Number = 1;
		public static const SIMPLE:Number = 0;
		public static const AUTOSIZE:Number = -1;
		public function DialogBox(p__1:*, p__2:* = -1, p__3:* = -1)
		{
			wide = p__2;
			high = p__3;
			skin = p__1;
			origw = p__2;
			origh = p__3;
			var l__4:* = skin.titleItem;
			var l__5:* = skin.bodyItem;
			titleItem = new l__4();
			bodyItem = new l__5();
			bodyItem.field.wordWrap = true;
			addEventListener(flash.events.MouseEvent.CLICK, onFocus);
		}
		public function init()
		{
			
			var l__19:* = undefined;
			var l__20:* = undefined;
			
			content = new flash.display.Sprite();
			var l__1:* = skin.TopLeftCorner.resource;
			var l__2:* = skin.TopRightCorner.resource;
			var l__3:* = skin.BottomLeftCorner.resource;
			var l__4:* = skin.BottomRightCorner.resource;
			var l__5:* = skin.LeftBand.resource;
			var l__6:* = skin.RightBand.resource;
			var l__7:* = skin.TopBand.resource;
			var l__8:* = skin.BottomBand.resource;
			var l__9:* = skin.closeButton;
			var l__10:* = new l__5();
			var l__11:* = new l__6();
			var l__12:* = new l__7();
			var l__13:* = new l__8();
			titleItem.y = (-(l__12.height / 2) - (titleItem.height / 2));
			titleItem.field.width = wide;
			if (!(type == com.script.display.Dialog.DialogBox.COMPLEX) && (module == null)){
				bodyItem.y = skin.defaultPadding;
				bodyItem.x = skin.defaultPadding;
				content.addChild(bodyItem);
				high = (high + buttonOffset);
			} else if (module){
				wide = origw;
				high = origh;
				content.addChild(module);
				if (high == com.script.display.Dialog.DialogBox.AUTOSIZE){
					high = module.height;
				}
				if (wide == com.script.display.Dialog.DialogBox.AUTOSIZE){
					wide = module.width;
				}
				if (high < (buttonOffset + skin.defaultPadding)){
					high = (buttonOffset + skin.defaultPadding);
				}
				l__19 = new flash.geom.Rectangle(0, 0, wide, high);
				content.scrollRect = l__19;
			}
			if (cancelable){
				l__20 = new l__9();
				l__20.x = (wide - skin.closeOffset.x);
				l__20.y = -skin.closeOffset.y;
				l__20.addEventListener(flash.events.MouseEvent.CLICK, hide);
			}
			if (!skin.bgBitmap){
				content.graphics.beginFill(skin.bgColor, skin.bgOpacity);
			} else {
				content.graphics.beginBitmapFill(skin.bgBitmap);
			}
			var l__14 = 0;
			if ((Math.round(high) % 2) === 1){
				l__14 = 1;
			}
			
			
			content.graphics.drawRect(0, -(l__14 / 4), wide, (Math.round(high) + (l__14 / 2)));
			var l__15:* = new l__1();
			l__15.x = -l__10.width;
			l__15.y = -l__15.height;
			var l__16:* = new l__2();
			l__16.x = ((wide - l__16.width) + l__11.width);
			l__16.y = -l__16.height;
			var l__17:* = new l__3();
			l__17.x = -l__17.width;
			l__17.y = high;
			var l__18:* = new l__4();
			l__18.x = wide;
			l__18.y = high;
			l__10.x = -l__10.width;
			l__11.x = wide;
			l__12.y = -l__12.height;
			l__13.y = high;
			l__12.x = (l__15.width - l__10.width);
			if (skin.LeftBand.skintype == com.script.display.Dialog.DialogSkin.STRETCH){
				l__10.height = high;
			} else {
				l__10.graphics.beginBitmapFill(makeTileable(l__10));
				l__10.graphics.drawRect(0, 0, l__10.width, high);
			}
			if (skin.RightBand.skintype == com.script.display.Dialog.DialogSkin.STRETCH){
				l__11.height = high;
			} else {
				l__11.graphics.beginBitmapFill(makeTileable(l__11));
				l__11.graphics.drawRect(0, 0, l__11.width, high);
			}
			if (skin.TopBand.skintype == com.script.display.Dialog.DialogSkin.STRETCH){
				l__12.width = (((wide - l__12.x) - l__16.width) + l__11.width);
			} else {
				l__12.graphics.beginBitmapFill(makeTileable(l__12));
				l__12.graphics.drawRect(0, 0, wide, l__12.height);
			}
			if (skin.BottomBand.skintype == com.script.display.Dialog.DialogSkin.STRETCH){
				l__13.width = wide;
			} else {
				l__13.graphics.beginBitmapFill(makeTileable(l__13));
				l__13.graphics.drawRect(0, 0, l__13.width, high);
			}
			filters = skin.filterlist;
			content.filters = skin.contentFilterList;
			addChild(content);
			addChild(l__10);
			addChild(l__11);
			addChild(l__12);
			addChild(l__13);
			addChild(l__15);
			addChild(l__16);
			addChild(l__17);
			addChild(l__18);
			addChild(titleItem);
			if (cancelable){
				addChild(l__20);
			}
			layoutButtons();
		}
		private function makeTileable(p__1:*):flash.display.BitmapData
		{
			var l__2:* = new flash.display.BitmapData(p__1.width, p__1.height);
			l__2.draw(p__1);
			return(l__2);
		}
		private function layoutButtons():void
		{
			var l__2:* = undefined;
			var l__1:Number = 0;
			for (l__2 in buttonIndex){
				switch(buttonIndex[l__2].action){
					case com.script.display.Dialog.DialogButton.CLOSE:
					{
						buttonIndex[l__2].button.addEventListener(flash.events.MouseEvent.CLICK, hide);
						break;
					}
					case com.script.display.Dialog.DialogButton.DISABLE:
					{
						buttonIndex[l__2].button.addEventListener(flash.events.MouseEvent.CLICK, disable);
						break;
					}
					default:
					{
						break;
					}
				}
				if (buttonIndex[l__2].offset == null){
					buttonIndex[l__2].button.x = (((wide - l__1) - skin.defaultPadding) - buttonIndex[l__2].button.width);
					buttonIndex[l__2].button.y = ((high - skin.defaultPadding) - buttonIndex[l__2].button.height);
					l__1 = (l__1 + (buttonIndex[l__2].button.width + skin.buttonPadding));
				} else {
					buttonIndex[l__2].button.x = (wide - buttonIndex[l__2].offset.x);
					buttonIndex[l__2].button.y = (high - buttonIndex[l__2].offset.y);
				}
				addChild(buttonIndex[l__2].button);
			}
		}
		private function onFocus(p__1:*):void
		{
			com.script.display.Dialog.DialogEvent.quickThrow(com.script.display.Dialog.DialogEvent.ACTIVE, this);
		}
		private function onClose(p__1:*):void
		{
			com.script.display.Dialog.DialogEvent.quickThrow(com.script.display.Dialog.DialogEvent.CLOSE, this);
		}
		public function set titleText(p__1:String)
		{
			titleItem.field.text = p__1;
		}
		public function get titleText()
		{
			return(titleItem.field.htmlText);
		}
		public function set bodyText(p__1:String)
		{
			if (wide == com.script.display.Dialog.DialogBox.AUTOSIZE){
				wide = skin.defaultwidth;
			}
			bodyItem.field.width = (wide - (skin.defaultPadding * 2));
			bodyItem.field.text = p__1;
			if (high == com.script.display.Dialog.DialogBox.AUTOSIZE){
				bodyItem.field.autoSize = flash.text.TextFieldAutoSize.LEFT;
				high = (bodyItem.field.textHeight + (skin.defaultPadding * 2));
			} else {
				bodyItem.field.height = (high - skin.defaultPadding);
			}
		}
		public function addButton(p__1:*):void
		{
			if (!buttonIndex){
				buttonIndex = new Array();
			}
			p__1.owner = this;
			buttonIndex.AS3::push(p__1);
			buttonOffset = (p__1.button.height + skin.defaultPadding);
		}
		public function disable(p__1:* = null):void
		{
			mouseChildren = false;
			alpha = 0.5;
		}
		public function enable(p__1:* = null):void
		{
			mouseChildren = true;
			alpha = 1;
		}
		public function show(p__1:* = false):void
		{
			visible = true;
			shown = true;
			com.script.display.Dialog.DialogEvent.quickThrow(com.script.display.Dialog.DialogEvent.OPEN, this);
			if (p__1){
				com.script.display.Dialog.DialogEvent.quickThrow(com.script.display.Dialog.DialogEvent.ALONE, this);
			}
			if (skin.showEffect != null){
				skin.showEffect(this);
			}
		}
		public function hide(p__1:* = null, p__2:* = false):void
		{
			if (!(skin.showEffect == null) && !(p__2)){
				skin.hideEffect(this);
			} else {
				visible = false;
			}
			shown = false;
			com.script.display.Dialog.DialogEvent.quickThrow(com.script.display.Dialog.DialogEvent.CLOSED, this);
			
		}
		public function isolate():void
		{
			com.script.display.Dialog.DialogEvent.quickThrow(com.script.display.Dialog.DialogEvent.ISOLATE, this);
		}
		public function release():void
		{
			com.script.display.Dialog.DialogEvent.quickThrow(com.script.display.Dialog.DialogEvent.RELEASE, this);
		}
		public function get realWide()
		{
			if (wide > 0){
				return(wide);
			}
			return(width);
		}
		public function get realHigh()
		{
			if (high > 0){
				return(high);
			}
			return(height);
		}
	}
}