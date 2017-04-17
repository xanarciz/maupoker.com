// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.lobby
{
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.net.*;
	import com.script.poker.lobby.events.view.*;
	import com.script.poker.lobby.events.*;
	public class BuzzSlide extends flash.display.MovieClip
	{
		public var buzzSlideContainer:flash.display.MovieClip;
		public var buzzSlideIndex:Number = -1;
		public var buzzImageLoader:flash.display.Loader;
		public var buzzSlideInfo:Object;
		public function BuzzSlide(p__1:Number, p__2:Object, p__3:flash.display.MovieClip)
		{
			buzzSlideContainer = p__3;
			buzzSlideInfo = p__2;
			buzzSlideIndex = p__1;
			buzzImageLoader = new Loader();
			buzzImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBuzzImageLoadComplete);
			buzzImageLoader.alpha = 0;
			if ((p__1) == 0){
				buzzImageLoader.alpha = 1;
			}
			buzzImageLoader.load(new URLRequest(buzzSlideInfo.sImageUrl));
		}
		private function onBuzzImageLoadComplete(p__1:flash.events.Event):void
		{
			buzzImageLoader.addEventListener(MouseEvent.MOUSE_UP, onBuzzSlideClick);
			buzzImageLoader.name = ("buzzSlide" + buzzSlideIndex);
			buzzSlideContainer.buttonMode = true;
			buzzSlideContainer.addChild(buzzImageLoader);
		}
		private function onBuzzSlideClick(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new BuzzAdEvent(LVEvent.BUZZ_AD_CLICK, buzzSlideInfo.sLinkUrl, buzzSlideInfo.sUrlTarget));
		}
	}
}