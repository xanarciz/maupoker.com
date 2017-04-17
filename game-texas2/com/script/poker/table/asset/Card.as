// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import caurina.transitions.*;
	import caurina.transitions.properties.*;
	public class Card extends flash.display.MovieClip
	{
		public var thisNumber:String;
		public var thisSuit:String;
		public var face:flash.display.MovieClip;
		public var isUp:Boolean;
		public var back:flash.display.MovieClip;
		public var isFlip:Boolean = false;
		public function Card()
		{
			showBack();
		}
		public function showFace()
		{
			isUp = true;
			face.scaleX = 1;
			back.scaleX = 0;
		}
		public function showBack()
		{
			isUp = false;
			face.scaleX = 0;
			back.scaleX = 1;
		}
		public function init(p__1:String, p__2:String)
		{
			thisSuit = p__1;
			thisNumber = p__2;
			face.bigSuit.visible = true;
			face.smallSuit.showSuit(thisSuit);
			face.bigSuit.showSuit(thisSuit);
			face.cardNumber.showNumber(thisNumber);
			if ((thisSuit == "heart") || (thisSuit == "diamond")){
				Tweener.addTween(face.cardNumber, {_color:10230801, time:0});
			} else if ((thisSuit == "spade") || (thisSuit == "club")){
				Tweener.addTween(face.cardNumber, {_color:0, time:0});
			}
		}
		public function flipCard()
		{
			if (isUp && (!isFlip)){
				Tweener.addTween(face, {scaleX:0, time:0.2, transition:"easeInSine", onStart:flipStarted});
				Tweener.addTween(back, {scaleX:1, time:0.2, delay:0.2, transition:"easeOutSine", onComplete:onCardBack});
			} else if ((!isUp) && (!isFlip)){
				Tweener.addTween(back, {scaleX:0, time:0.2, transition:"easeInSine", onStart:flipStarted});
				Tweener.addTween(face, {scaleX:1, time:0.2, delay:0.2, transition:"easeOutSine", onComplete:onCardFace});
			}
		}
		private function flipStarted():void
		{
			isFlip = true;
		}
		private function onCardBack():void
		{
			isUp = false;
			isFlip = false;
		}
		private function onCardFace():void
		{
			isUp = true;
			isFlip = false;
		}
		public function moveCard(p__1:Number, p__2:Number, p__3:Boolean, p__4:String, p__5:Number)
		{
			this.alpha = 0;
			this.rotation = 0;
			this.visible = true;
			var l__6:Number = Math.random() * 360;
			var l__7:Number = getD(this.x, this.y, p__1, p__2);
			var l__8:Number = l__7 / 500;
			Tweener.removeTweens(this, "_DropShadow_alpha", "_DropShadow_angle", "_DropShadow_blurX", "_DropShadow_blurY", "_DropShadow_color", "_DropShadow_distance", "_DropShadow_quality");
			Tweener.addTween(this, {_DropShadow_alpha:2, _DropShadow_angle:45, _DropShadow_blurX:20, _DropShadow_blurY:20, _DropShadow_color:0, _DropShadow_distance:10, _DropShadow_quality:3});
			Tweener.removeTweens(this, "x", "y", "alpha", "rotation");
			Tweener.addTween(this, {alpha:1, time:l__8 / 3, transition:"linear"});
			Tweener.addTween(this, {x:p__1, rotation:l__6, time:l__8, transition:"easeOutSine", onComplete:fixUpPostDeal, onCompleteParams:[p__5]});
			Tweener.addTween(this, {_DropShadow_alpha:0.75, _DropShadow_blurX:6, _DropShadow_blurY:6, _DropShadow_distance:0, _DropShadow_quality:3, time:l__8, transition:"easeOutSine"});
			if (p__3){
				Tweener.addTween(this, {y:p__2, time:l__8, transition:"easeOutSine", onComplete:destroyMe, onCompleteParams:[p__4]});
			} else {
				Tweener.addTween(this, {y:p__2, time:l__8, transition:"easeOutSine"});
			}
		}
		private function fixUpPostDeal(p__1:*):void
		{
			Tweener.addTween(this, {rotation:p__1, time:0.15, transition:"easeOutSine"});
		}
		public function flopCard(p__1:Number, p__2:Number, p__3:Number, p__4:Boolean = false)
		{
			var l__5:Number = (0 - (Math.random() * 14));
			Tweener.removeTweens(this, "x", "y", "alpha", "_DropShadow_alpha", "_DropShadow_angle", "_DropShadow_blurX", "_DropShadow_blurY", "_DropShadow_color", "_DropShadow_distance", "_DropShadow_quality");
			this.visible = true;
			if (!(p__4)){
				this.alpha = 0;
				Tweener.addTween(this, {alpha:1, delay:p__3, time:0.2, transition:"easeOutSine"});
				Tweener.addTween(this, {x:p__1, delay:p__3, rotation:l__5, time:0.5, transition:"easeOutSine", onStart:onFlopCardStart, onComplete:fixRot});
				Tweener.addTween(this, {y:p__2, delay:p__3, time:0.5, transition:"easeOutSine"});
			} else {
				this.alpha = 1;
				this.x = p__1;
				this.y = p__2;
				this.rotation = 0;
			}
			addShadow();
		}
		public function addShadow():void
		{
			Tweener.addTween(this, {_DropShadow_alpha:0.75, _DropShadow_blurX:6, _DropShadow_blurY:6, _DropShadow_distance:0, _DropShadow_quality:3});
		}
		private function onFlopCardStart():void
		{
			flipCard();
		}
		private function fixRot():void
		{
			Tweener.addTween(this, {rotation:0, time:0.1, transition:"easeInOutSine"});
		}
		public function clearCard(p__1:int, p__2:int):void
		{
			this.visible = false;
			this.rotation = 0;
			this.alpha = 0;
			this.x = p__1;
			this.y = p__2;
			showBack();
		}
		public function foldCard():void
		{
			showBack();
			this.alpha = 0;
		}
		private function onCardFolded():void
		{
			this.visible = false;
			this.alpha = 0;
			this.rotation = 0;
			this.alpha = 1;
			showBack();
		}
		public function destroyMe(p__1:String)
		{
		}
		public function getD(p__1:Number, p__2:Number, p__3:Number, p__4:Number):Number
		{
			var l__5:Number = Math.abs((p__1 - p__3));
			var l__6:Number = Math.abs((p__2 - p__4));
			var l__7:Number = Math.sqrt((l__5 * l__5 + (l__6 * l__6)));
			return(l__7);
		}
	}
	ColorShortcuts.init();
	//var l__1:* = FilterShortcuts.init();
	//return(l__1);
}