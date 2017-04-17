// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.Timer;
	import flash.geom.Rectangle;
	public class GiftItemInst extends flash.display.MovieClip
	{
		private var mnLoadingAttempts:* = 0;
		private var mbIsLoaded:* = false;
		private var mChildSwf:com.script.poker.table.GiftItemInstSwf = null;
		public var msImageUrl:String = null;
		private var mChildSpinner:* = null;
		private var mChildImage:flash.display.Loader = null;
		public var moGift:com.script.poker.table.GiftItem = null;
		private var mDelayCreateTimer:flash.utils.Timer = null;
		public var mnUniqueID:* = Math.ceil(Math.random() * 16777215);
		public var nSit = 0;
		private static const knMaxLoadingAttempts:* = 5;
		private static const knDelayCreateTime:* = 1000;
		public function GiftItemInst(p__1:String, p__2:com.script.poker.table.GiftItem)
		{
			if (((p__1) == null) || ((p__2) == null)){
				return;
			}
			msImageUrl = p__1;
			moGift = p__2;
			AddSpinner();
			CreateGiftMovieClip(p__1, p__2);
		}
		public function IsPossibleToCreateGiftNow(p__1:String, p__2:com.script.poker.table.GiftItem):Boolean
		{
			if (!((p__2.msClassDef) == null) && !((p__2.msClassDef) == "")){
				if (!GiftLibrary.GetInst().GetIsSwfGiftAssetsLoaded()){
					return(false);
				}
			}
			if (!((p__1) == null) && !((p__1) == "")){
				if (!GiftLibrary.GetInst().HasLoadedAllGiftInfo()){
					return(false);
				}
			}
			return(true);
		}
		public function CreateGiftMovieClip(p__1:String, p__2:com.script.poker.table.GiftItem)
		{
			var l__4:com.script.poker.table.GiftItemInstSwf;
			var l__5:flash.display.Loader;
			if (!IsPossibleToCreateGiftNow(p__1, p__2)){
				DelayCreatingGift(p__1, p__2);
				return;
			}
			var l__3:Class;
			if (!((p__2.msClassDef) == null) && !((p__2.msClassDef) == "")){
				l__3 = GiftLibrary.GetInst().GetClassDefinition(p__2);
			}
			if (l__3 != null){
				l__4 = CreateGiftMovieClip_Swf(l__3, p__1);
				this.addChild(l__4);
				this.mChildSwf = l__4;
				this.mChildImage = null;
			} else if (!((p__1) == null) && !((p__1) == "")){
				l__5 = null;
				l__5 = CreateGiftMovieClip_Image(p__1);
				this.addChild(l__5);
				this.mChildSwf = null;
				this.mChildImage = l__5;
			} else {
				this.mChildSwf = null;
				this.mChildImage = null;
			}
		}
		public function Release()
		{
			var l__1:com.script.poker.table.GiftItemInstSwf;
			if (this.mChildSwf != null){
				l__1 = (this.mChildSwf as GiftItemInstSwf);
				if (l__1){
					l__1.Release();
				}
			}
			this.mChildSwf = null;
			this.mChildImage = null;
		}
		public function Sleep()
		{
			var l__1:com.script.poker.table.GiftItemInstSwf;
			if (this.mChildSwf != null){
				l__1 = (this.mChildSwf as GiftItemInstSwf);
				if (l__1){
					l__1.Sleep();
				}
			}
		}
		public function Wake()
		{
			var l__1:com.script.poker.table.GiftItemInstSwf;
			x = 0;
			y = 0;
			if (this.mChildSwf != null){
				l__1 = (this.mChildSwf as GiftItemInstSwf);
				if (l__1){
					l__1.Wake();
				}
			}
		}
		private function AddSpinner()
		{
			mChildSpinner = new LoadAnim_Circle1();
			mChildSpinner.scaleX = 0.5;
			mChildSpinner.scaleY = 0.5;
			mChildSpinner.y = (mChildSpinner.y - 20);
			this.addChild(mChildSpinner);
		}
		private function RemoveSpinner()
		{
			if (mChildSpinner){
				if (this.contains(mChildSpinner)){
					this.removeChild(mChildSpinner);
				}
				mChildSpinner = null;
			}
		}
		public function DelayCreatingGift(p__1:String, p__2:com.script.poker.table.GiftItem)
		{
			this.mChildSwf = null;
			this.mChildImage = null;
			if (mDelayCreateTimer == null){
				mDelayCreateTimer = new Timer(knDelayCreateTime);
				mDelayCreateTimer.addEventListener(TimerEvent.TIMER, CarryOutCreatingDelayGift);
			}
			mDelayCreateTimer.start();
		}
		public function CarryOutCreatingDelayGift(p__1:flash.events.TimerEvent)
		{
			if (!IsPossibleToCreateGiftNow(msImageUrl, moGift)){
				return;
			}
			mDelayCreateTimer.stop();
			mDelayCreateTimer.removeEventListener(TimerEvent.TIMER, CarryOutCreatingDelayGift);
			mDelayCreateTimer = null;
			CreateGiftMovieClip(msImageUrl, moGift);
		}
		public function CreateGiftMovieClip_Swf(p__1:Class, p__2:String):com.script.poker.table.GiftItemInstSwf
		{
			if (!GiftLibrary.GetInst().GetIsSwfGiftAssetsLoaded()){
				return(null);
			}
			var l__3:flash.display.MovieClip = ((new p__1()) as MovieClip);
			var l__4:com.script.poker.table.GiftItemInstSwf = new GiftItemInstSwf(l__3, true);
			mbIsLoaded = true;
			RemoveSpinner();
			return(l__4);
			
		}
		function CreateGiftMovieClip_Image(p__1:*):flash.display.Loader
		{
			if (!GiftLibrary.GetInst().HasLoadedAllGiftInfo()){
				return(null);
			}
			return(LoadImage(p__1));
		}
		function LoadImage(p__1:String):flash.display.Loader
		{
			var l__2:flash.net.URLRequest = new URLRequest(p__1);
			var l__3:flash.system.LoaderContext = new LoaderContext();
			l__3.checkPolicyFile = true;
			var l__4:* = new Loader();
			l__4.contentLoaderInfo.addEventListener(Event.COMPLETE, OnComplete_Image);
			l__4.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, OnErrorHandler_Image);
			l__4.load(l__2, l__3);
			return(l__4);
		}
		function OnComplete_Image(p__1:flash.events.Event):void
		{
			var l__2:flash.display.LoaderInfo = ((p__1.currentTarget) as LoaderInfo);
			var l__3:flash.geom.Rectangle = l__2.content.getBounds(stage);
			if ((l__3.x < 0) || (l__3.y < 0)){
			} else {
				l__2.content.x = l__3.width * -0.5;
				l__2.content.y = l__3.height * -0.85;
			}
			RemoveSpinner();
			mbIsLoaded = true;
		}
		private function OnErrorHandler_Image(p__1:flash.events.IOErrorEvent):void
		{
			var l__2:flash.display.LoaderInfo = ((p__1.currentTarget) as LoaderInfo);
			if (mnLoadingAttempts > knMaxLoadingAttempts){
				return;
			}
			mnLoadingAttempts++;
			if (this.contains(mChildImage)){
				this.removeChild(mChildImage);
			}
			var l__3:flash.display.Loader = CreateGiftMovieClip_Image(msImageUrl);
			this.addChild(l__3);
			this.mChildSwf = null;
			this.mChildImage = l__3;
		}
	}
}