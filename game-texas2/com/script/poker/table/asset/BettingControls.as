// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import com.script.poker.table.TableView;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import caurina.transitions.*;
	import flash.text.TextFormat;
	import caurina.transitions.properties.*;
	public class BettingControls extends flash.display.MovieClip
	{
		public var slider:com.script.poker.table.asset.SliderControl;
		public var raiseButton:com.script.poker.table.asset.PokerButton;
		public var callButton:com.script.poker.table.asset.PokerButton;
		public var raiseBG:flash.display.MovieClip;
		public var foldButton:com.script.poker.table.asset.PokerButton;
		public var raiseHit:flash.display.MovieClip;
		public var tv:com.script.poker.table.TableView = TableView(this.parent);
		public var foldHit:flash.display.MovieClip;
		public var callHit:flash.display.MovieClip;
		public var flasher:flash.display.MovieClip;
		public var prebetControls:com.script.poker.table.asset.PrebetControl;
		public var betButtons:flash.display.MovieClip;
		public static const ON_FOLD:String = "ON_FOLD";
		public static const ON_RAISE:String = "ON_RAISE";
		public static const ON_CALL:String = "ON_CALL";
		private var runButton = "0";
		public var calltext;
		public var callanytext;
		public var cekfoldtext;
		public var cektext;
		public var allintext;
		public var foldtext;
		public var raisetext;
		public function BettingControls()
		{
			
			
			betButtons.initBetButtons();
			
			slider = betButtons.slider;
			slider.raiseAction = onRaiseButton;
			flasher.mouseEnabled = false;
			flasher.mouseChildren = false;
			callButton = betButtons.callButton;
			foldButton = betButtons.foldButton;
			raiseButton = betButtons.raiseButton;
			
			raiseBG = betButtons.raiseBG;
			initButtonListeners();
			
			
		}
		public function showRaiseOption(p__1:Number, p__2:Number, p__3:Number, p__4:Number):void
		{
		
			if ((p__3) > 0){
				setCallButton("call", p__3);
			} else {
				setCallButton("check", p__3);
			}
			slider.init(p__1, p__2, p__4, p__3);
			slider.visible = true;
			raiseButton.visible = true;
			raiseButton.setActivity(true);
			raiseBG.visible = true;
			
		}
		public function showCallOption(p__1:Number):void
		{
		
			setCallButton("call", p__1);
			slider.visible = false;
			raiseButton.visible = false;
			raiseBG.visible = false;
		}
		public function showPreBet(p__1:Boolean):void
		{
			
			prebetControls.calltext = callanytext;
			prebetControls.cekfoldtext = cekfoldtext;
			prebetControls.cektext = cektext;
			prebetControls.foldtext = foldtext;
			prebetControls.changeText();
			//callButton.changeText(calltext.toUpperCase());
			foldButton.changeText(foldtext.toUpperCase());
			raiseButton.changeText(raisetext.toUpperCase());
			
			if (p__1){
				betButtons.mouseEnabled = false;
				betButtons.visible = false;
				prebetControls.visible = true;
				prebetControls.mouseEnabled = true;
			} else if (!(p__1)){
				prebetControls.mouseEnabled = false;
				prebetControls.visible = false;
				betButtons.visible = true;
				betButtons.mouseEnabled = true;
				triggerFlash();
			}
		}
		public function triggerFlash():void
		{
			flasher.alpha = 0;
			Tweener.addTween(flasher, {alpha:1, _Blur_blurX:25, _Blur_blurY:25, _Blur_quality:2, time:0.5, transition:"easeOutSine"});
			Tweener.addTween(flasher, {alpha:0, _Blur_blurX:0, _Blur_blurY:0, time:0.4, delay:0.8, transition:"easeOutSine"});
		}
		public function setCallButton(p__1:String, p__2:Number)
		{
		
			if ((((p__1) == "Call") || ((p__1) == "CALL")) || ((p__1) == "call")){
				callButton.changeText(calltext.toUpperCase());
				betButtons.valTxt.visible = true;
			} else if ((((p__1) == "Check") || ((p__1) == "CHECK")) || ((p__1) == "check")){
				betButtons.valTxt.visible = false;
				callButton.changeText(cektext.toUpperCase());
			}
			var l__3:String = FormatCurrency.giveMeDollars(p__2);
			betButtons.valTxt.text = l__3;
			var l__4:flash.text.TextFormat = new TextFormat();
			if (l__3.length > 8){
				l__4.size = 9;
				betButtons.valTxt.y = 23;
				betButtons.valTxt.x = 59;
			} else if ((l__3.length > 4) && (l__3.length <= 8)){
				l__4.size = 11;
				betButtons.valTxt.y = 22;
				betButtons.valTxt.x = 61;
			} else if (l__3.length <= 4){
				l__4.size = 12;
				betButtons.valTxt.y = 21;
				betButtons.valTxt.x = 63;
			}
			
			betButtons.valTxt.setTextFormat(l__4);
			runButton = "0";
		}
		private function initButtonListeners():void
		{
			
			callButton.addEventListener(MouseEvent.CLICK, onCallButton);
			foldButton.addEventListener(MouseEvent.CLICK, onFoldButton);
			raiseButton.addEventListener(MouseEvent.CLICK, onRaiseButton);
		}
		public function onCallButton(p__1:flash.events.MouseEvent):void
		{
			if (runButton == "0") {
			runButton = "1";
			tv.onCallPressed();
			}
		}
		public function onFoldButton(p__1:flash.events.MouseEvent):void
		{
			if (runButton == "0") {
			runButton = "1";
			tv.onFoldPressed();
			}
		}
		public function onRaiseButton(p__1:flash.events.MouseEvent = null):void
		{
			if (runButton == "0") {
			runButton = "1";
			slider.killBIFocus();
			tv.onRaisePressed();
			}
		}
	}
	//var l__1:* = FilterShortcuts.init();
	//return(l__1);
}