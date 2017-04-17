// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.FocusEvent;
	import flash.events.EventDispatcher;
	import caurina.transitions.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	public class SliderControl extends flash.display.MovieClip
	{
		public var hitter:flash.display.MovieClip;
		public var betSkirt:flash.display.Sprite;
		public var adjMinus:flash.display.MovieClip;
		public var slideMinX:Number = 14;
		public var theSlideX:Number = 0;
		public var blindValue:Number = 0;
		public var betHitter:flash.display.MovieClip;
		public var handle:flash.display.MovieClip;
		public var bSliderHit:Boolean = false;
		public var callValue:Number = 0;
		public var rangeValue:Number = 0;
		public var betInput:flash.text.TextField;
		public var minValue:Number = 0;
		public var slideMaxX:Number = 210;
		public var betAmount:Number = 0;
		public var raiseAction:Function;
		public var adjPlus:flash.display.MovieClip;
		public var maxValue:Number = 0;
		public var betDisplay:flash.text.TextField;
		public var gfx:flash.display.MovieClip;
		public function SliderControl()
		{
			hitter.alpha = 0;
			betInput.visible = false;
			hitter.buttonMode = true;
			hitter.useHandCursor = true;
			adjMinus.buttonMode = true;
			adjMinus.useHandCursor = true;
			adjPlus.buttonMode = true;
			adjPlus.useHandCursor = true;
		}
		public function init(p__1:Number, p__2:Number, p__3:Number, p__4:Number)
		{
			
			maxValue = p__2;
			minValue = p__1;
			rangeValue = (p__2 - p__1);
			callValue = p__4;
			blindValue = p__3;
			initSliderListeners(true);
			initBettingInput(true);
			initAdjButtons(true);
			updateText(p__1);
		}
		public function adjustFill()
		{
			var l__1:* = this.mouseX;
			var l__2:* = handle.x;
			if (l__1 < slideMinX){
				l__1 = slideMinX;
			} else if (l__1 > slideMaxX){
				l__1 = slideMaxX;
			}
			var l__3:* = l__1 / 100;
			var l__4:* = Math.abs((l__1 - l__2)) / 350;
			Tweener.addTween(handle, {x:l__1, time:l__4, transition:"easeOutSine", onStart:updatePosition, onUpdate:updatePosition, onComplete:updatePosition});
		}
		public function initSliderListeners(p__1:Boolean):void
		{
			if (p__1){
			
				hitter.addEventListener(MouseEvent.MOUSE_DOWN, onHitterPressed);
				hitter.addEventListener(MouseEvent.MOUSE_UP, onHitterReleased);
			} else if (!(p__1)){
			
				hitter.removeEventListener(MouseEvent.MOUSE_DOWN, onHitterPressed);
				hitter.removeEventListener(MouseEvent.MOUSE_UP, onHitterReleased);
			}
		}
		public function onHitterPressed(p__1:flash.events.MouseEvent):void
		{
		
			bSliderHit = true;
			hitter.addEventListener(Event.ENTER_FRAME, onHitterFrame);
			betSkirt = new Sprite();
			betSkirt.graphics.beginFill(16711680, 0);
			betSkirt.graphics.drawRect(-760, -530, 1520, 1060);
			betSkirt.graphics.endFill();
			betSkirt.mouseEnabled = true;
			addChild(betSkirt);
			betSkirt.addEventListener(MouseEvent.MOUSE_UP, onHitterReleased);
		}
		public function onHitterReleased(p__1:flash.events.MouseEvent = null):void
		{
		
			bSliderHit = false;
			hitter.removeEventListener(Event.ENTER_FRAME, onHitterFrame);
			if (betSkirt != null){
				betSkirt.removeEventListener(MouseEvent.MOUSE_UP, onHitterReleased);
				removeChild(betSkirt);
				betSkirt = null;
			}
		}
		public function onHitterFrame(p__1:flash.events.Event):void
		{
			adjustFill();
		}
		public function updatePosition()
		{
			var l__1:Number = handle.x;
			var l__2:Number = Math.round((l__1 - slideMinX)) / (((slideMaxX - slideMinX)));
			var l__3:Number = Math.round((l__2 * rangeValue + minValue));
			betAmount = l__3;
			var l__4:String = FormatCurrency.giveMeDollars(l__3);
			updateBetDisplay(l__4);
			updateBetInput(betAmount);
		}
		public function updateText(p__1:Number)
		{
			var l__2:Number = 0;
			var l__3:Number = 0;
			var l__4:String;
			var l__5:Number = 0;
			var l__6:Number = 0;
			if ((p__1) < minValue){
				l__2 = minValue;
			} else if ((p__1) > maxValue){
				l__2 = maxValue;
			} else {
				l__2 = p__1;
			}
			
			if (maxValue != minValue){
			
				l__5 = (l__2 - minValue) / rangeValue;
				handle.x = (Math.round(l__5 * (slideMaxX - slideMinX)) + slideMinX);
				l__6 = Math.round(l__5 * rangeValue);
				l__3 = (l__6 + minValue);
				if ((l__3 < 0) || isNaN(l__3)){
					l__3 = 0;
				}
				betAmount = l__3;
				l__4 = FormatCurrency.giveMeDollars(l__3);
				updateBetDisplay(l__4);
				updateBetInput(betAmount);
			} else {
			
				initSliderListeners(false);
				initBettingInput(false);
				initAdjButtons(false);
				handle.x = slideMaxX;
				l__3 = maxValue;
				betAmount = l__3;
				l__4 = FormatCurrency.giveMeDollars(l__3);
				updateBetDisplay(l__4);
				updateBetInput(betAmount);
			}
		}
		public function updateBetInput(p__1:Number):void
		{
			betInput.text = (p__1).toString();
			betInput.setSelection(0, betInput.length);
		}
		public function updateBetDisplay(p__1:String)
		{
			var l__2:String = p__1;
			betDisplay.text = l__2;
			var l__3:flash.text.TextFormat = new TextFormat();
			if (l__2.length > 12){
				l__3.size = 10;
				betDisplay.y = -27;
			} else if (l__2.length < 12){
				l__3.size = 12;
				betDisplay.y = -27;
			}
			betDisplay.setTextFormat(l__3);
		}
		public function initBettingInput(p__1:Boolean):void
		{
			betInput.restrict = "0-9";
			
			if (p__1){
			
				betHitter.addEventListener(MouseEvent.MOUSE_UP, onBetHitterRelease);
				betInput.addEventListener(FocusEvent.FOCUS_IN, setBIFocus);
				betInput.addEventListener(FocusEvent.FOCUS_OUT, killBIFocus);
			} else if (!(p__1)){
			
				betHitter.removeEventListener(MouseEvent.MOUSE_UP, onBetHitterRelease);
				betInput.removeEventListener(FocusEvent.FOCUS_IN, setBIFocus);
				betInput.removeEventListener(FocusEvent.FOCUS_OUT, killBIFocus);
			}
		}
		public function onBetHitterRelease(p__1:flash.events.MouseEvent):void
		{
			betHitter.visible = false;
			betDisplay.visible = false;
			betInput.restrict = "0-9";
			betInput.visible = true;
			betInput.stage.focus = betInput;
		}
		function setBIFocus(evt:flash.events.FocusEvent):void
		{
			
			var clickOut = undefined;
			var isEntered = undefined;
			clickOut = function()
			{
				
				processInput(false);
			};
			isEntered = function(p__1:flash.events.KeyboardEvent)
			{
			
				if ((p__1.keyCode) == 13){
				
					processInput(true);
				}
			};
			var processInput = function(p__1:Boolean)
			{
			
				betInput.removeEventListener(KeyboardEvent.KEY_DOWN, isEntered);
				
				if (betSkirt != null){
				
					betSkirt.removeEventListener(MouseEvent.CLICK, clickOut);
					removeChild(betSkirt);
					betSkirt = null;
				}
				var l__2:Number = Number(betInput.text);
				if (l__2 > maxValue){
					l__2 = maxValue;
				} else if (l__2 < minValue){
					l__2 = minValue;
				}
				
				killBIFocus();
				if (p__1){
				
					raiseAction();
				}
			};
			if (betSkirt != null){
				
					betSkirt.removeEventListener(MouseEvent.CLICK, clickOut);
					removeChild(betSkirt);
					betSkirt = null;
				}
			betSkirt = new Sprite();
			betSkirt.graphics.beginFill(16711680, 0);
			betSkirt.graphics.drawRect(-760, -530, 1520, 1060);
			betSkirt.graphics.endFill();
			addChild(betSkirt);
			if ((betAmount < 0) || isNaN(betAmount)){
				betAmount = 0;
			}
			betInput.text = Number(betAmount).toString();
			betInput.setSelection(0, betInput.length);
			betInput.addEventListener(KeyboardEvent.KEY_DOWN, isEntered);
			betSkirt.addEventListener(MouseEvent.CLICK, clickOut);
		}
		public function killBIFocus(p__1:flash.events.FocusEvent = null):void
		{
		
			betHitter.visible = true;
			betDisplay.visible = true;
			betInput.setSelection(0, betInput.length);
			betInput.visible = false;
			var l__2:String = FormatCurrency.giveMeDollars(betInput.text);
			var l__3:Number = Number(betInput.text);
			betAmount = l__3;
			var l__4:String = FormatCurrency.giveMeDollars(betAmount);
			updateText(betAmount);
		}
		function manualAdjust(p__1:String)
		{
			if ((p__1).toString() == "plus"){
				betAmount = (betAmount + blindValue);
				updateText(betAmount);
			} else if ((p__1).toString() == "minus"){
				betAmount = (betAmount - blindValue);
				updateText(betAmount);
			}
		}
		public function initAdjButtons(p__1:Boolean):void
		{
			if (p__1){
				adjMinus.addEventListener(MouseEvent.CLICK, onAdjMinusDown);
				adjPlus.addEventListener(MouseEvent.CLICK, onAdjPlusDown);
			} else if (!(p__1)){
				adjMinus.removeEventListener(MouseEvent.CLICK, onAdjMinusDown);
				adjPlus.removeEventListener(MouseEvent.CLICK, onAdjPlusDown);
			}
		}
		public function onAdjMinusDown(p__1:flash.events.MouseEvent):void
		{
			manualAdjust("minus");
		}
		public function onAdjPlusDown(p__1:flash.events.MouseEvent):void
		{
			manualAdjust("plus");
		}
		public function returnMinReq():Boolean
		{
			var l__1:Boolean;
			if (betAmount < minValue){
				l__1 = false;
			} else {
				l__1 = true;
			}
			return(l__1);
		}
		public function setToMin():void
		{
			betAmount = minValue;
			var l__1:String = FormatCurrency.giveMeDollars(betAmount);
			updateBetDisplay(l__1);
			updateBetInput(betAmount);
		}
	}
}