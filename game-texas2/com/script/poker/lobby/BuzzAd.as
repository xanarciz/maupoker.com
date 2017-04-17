// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby
{
	import flash.display.*;
	import flash.events.*;
	import caurina.transitions.*;
	import com.adobe.serialization.json.*;
	import com.script.poker.lobby.events.view.*;
	import flash.utils.*;
	import com.script.poker.lobby.events.*;
	import com.script.events.*;
	import com.script.io.*;
	public class BuzzAd extends flash.display.MovieClip
	{
		private var delayTimer:flash.utils.Timer;
		private var secFadeSlide:Number = 0;
		private var totalAd:Number = 1;
		public var FadeTime:Number = 0;
		public var mcContainer:flash.display.MovieClip;
		private var secSlideOnScreen:Number = 0;
		public var btnNext:flash.display.SimpleButton;
		public var btnPrev:flash.display.SimpleButton;
		private var buzzJSON:Object;
		private var currentAd:Number = 0;
		private var loadTimer:flash.utils.Timer;
		public function BuzzAd(p__1:String)
		{
			initListeners();
			retrieveBuzzAd(p__1);
		}
		private function onLoadTimer(p__1:flash.events.TimerEvent):void
		{
			if (mcContainer.numChildren >= totalAd){
				requestQueue();
				loadTimer.stop();
				loadTimer.removeEventListener(TimerEvent.TIMER, onLoadTimer);
				loadTimer = null;
			}
		}
		private function initListeners()
		{
			btnPrev.addEventListener(MouseEvent.MOUSE_UP, onBuzzBtnPrev);
			btnNext.addEventListener(MouseEvent.MOUSE_UP, onBuzzBtnNext);
		}
		private function retrieveBuzzAd(p__1:String):void
		{
			var l__2:com.script.io.LoadUrlVars = new LoadUrlVars();
			l__2.addEventListener(URLEvent.onLoaded, onBuzzAdLoaded);
			l__2.loadURL(p__1, {}, "POST");
		}
		private function onBuzzAdLoaded(evt:flash.events.Event):void
		{
			var i:int;
			var buzzImage:com.script.poker.lobby.BuzzSlide;
			if (evt.target != null){
				loadTimer = new Timer(5000, 3);
				loadTimer.addEventListener(TimerEvent.TIMER, onLoadTimer);
				loadTimer.start();
				try {
					buzzJSON = JSON.decode(unescape(evt.target.data));
					FadeTime = Number(buzzJSON["uSecFadeSlide"]);
					currentAd = 0;
					totalAd = buzzJSON["aAds"].length;
					if (totalAd <= 1){
						btnPrev.visible = false;
						btnNext.visible = false;
					}
					i = 0;
					while(i < buzzJSON["aAds"].length){
						buzzImage = new BuzzSlide(i, buzzJSON["aAds"][i], mcContainer);
						buzzImage.addEventListener(LVEvent.BUZZ_AD_CLICK, onBuzzAdClicked);
						i++;
					}
				} catch (err:Error) {
				}
			}
		}
		private function onBuzzBtnPrev(p__1:flash.events.MouseEvent):void
		{
			if (delayTimer != null){
				delayTimer.reset();
				delayTimer.stop();
				delayTimer = null;
			}
			incrementAdNumber(false);
			fadeQueue();
		}
		private function onBuzzBtnNext(p__1:flash.events.MouseEvent):void
		{
			if (delayTimer != null){
				delayTimer.reset();
				delayTimer.stop();
				delayTimer = null;
			}
			incrementAdNumber(true);
			fadeQueue();
		}
		private function getDelayTime(p__1:int):Number
		{
			var l__2:Number = Number(((!(buzzJSON["aAds"][p__1].uSecOnScreen == undefined) && !(buzzJSON["aAds"][p__1].uSecOnScreen == null)) && (buzzJSON["aAds"][p__1].uSecOnScreen > 0)) ? buzzJSON["aAds"][p__1].uSecOnScreen : buzzJSON["uSecSlideOnScreen"]);
			return(l__2);
		}
		private function incrementAdNumber(p__1:Boolean):void
		{
			if (p__1){
				currentAd++;
				currentAd = (currentAd % totalAd);
			}
			if (!(p__1)){
				currentAd--;
				if (currentAd < 0){
					currentAd = totalAd - 1;
				}
			}
		}
		private function requestQueue():void
		{
			var l__1:Number = getDelayTime(currentAd);
			if (delayTimer != null){
				delayTimer.reset();
				delayTimer.stop();
				delayTimer = null;
			}
			delayTimer = new Timer(l__1 * 1000, 0);
			delayTimer.addEventListener(TimerEvent.TIMER, fadeQueue);
			delayTimer.start();
		}
		private function fadeQueue(p__1:flash.events.TimerEvent = null)
		{
			if ((p__1) != null){
				incrementAdNumber(true);
			}
			mcContainer.getChildByName("buzzSlide" + currentAd).alpha = 0;
			mcContainer.setChildIndex(mcContainer.getChildByName("buzzSlide" + currentAd), mcContainer.numChildren - 1);
			Tweener.addTween(mcContainer.getChildByName("buzzSlide" + currentAd), {alpha:1, time:FadeTime, onComplete:requestQueue});
		}
		private function onBuzzAdClicked(p__1:com.script.poker.lobby.events.view.BuzzAdEvent):void
		{
			dispatchEvent(new BuzzAdEvent(LVEvent.BUZZ_AD_CLICK, buzzJSON["aAds"][currentAd].sLinkUrl, buzzJSON["aAds"][currentAd].sUrlTarget));
		}
	}
}