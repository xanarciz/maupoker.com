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
	public class EmoItemInst extends flash.display.MovieClip
	{
		private var mnLoadingAttempts:* = 0;
		private var mbIsLoaded:* = false;
		private var mChildSwf:com.script.poker.table.EmoItemInstSwf = null;
		public var msImageUrl:String = null;
		private var mChildSpinner:* = null;
		private var mChildImage:flash.display.Loader = null;
		public var moEmo:com.script.poker.table.EmoItem = null;
		private var mDelayCreateTimer:flash.utils.Timer = null;
		public var mnUniqueID:* = Math.ceil(Math.random() * 16777215);
		private static const knMaxLoadingAttempts:* = 5;
		private static const knDelayCreateTime:* = 1000;
		public function EmoItemInst(p__1:String, p__2:com.script.poker.table.EmoItem)
		{
			if (((p__1) == null) || ((p__2) == null)){
				return;
			}
			msImageUrl = p__1;
			moEmo = p__2;
			AddSpinner();
			CreateEmoMovieClip(p__1, p__2);
		}
		public function IsPossibleToCreateEmoNow(p__1:String, p__2:com.script.poker.table.EmoItem):Boolean
		{
			if (!((p__2.msClassDef) == null) && !((p__2.msClassDef) == "")){
				if (!EmoLibrary.GetInst().GetIsSwfEmoAssetsLoaded()){
					return(false);
				}
			}
			if (!((p__1) == null) && !((p__1) == "")){
				if (!EmoLibrary.GetInst().HasLoadedAllEmoInfo()){
					return(false);
				}
			}
			return(true);
		}
		public function CreateEmoMovieClip(p__1:String, p__2:com.script.poker.table.EmoItem)
		{
			var l__4:com.script.poker.table.EmoItemInstSwf;
			var l__5:flash.display.Loader;
			if (!IsPossibleToCreateEmoNow(p__1, p__2)){
				DelayCreatingEmo(p__1, p__2);
				return;
			}
			var l__3:Class;
			if (!((p__2.msClassDef) == null) && !((p__2.msClassDef) == "")){
				l__3 = EmoLibrary.GetInst().GetClassDefinition(p__2);
			}
			if (l__3 != null){
				l__4 = CreateEmoMovieClip_Swf(l__3, p__1);
				this.addChild(l__4);
				this.mChildSwf = l__4;
				this.mChildImage = null;
			} else if (!((p__1) == null) && !((p__1) == "")){
				l__5 = null;
				l__5 = CreateEmoMovieClip_Image(p__1);
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
			var l__1:com.script.poker.table.EmoItemInstSwf;
			if (this.mChildSwf != null){
				l__1 = (this.mChildSwf as EmoItemInstSwf);
				if (l__1){
					l__1.Release();
				}
			}
			this.mChildSwf = null;
			this.mChildImage = null;
		}
		public function Sleep()
		{
			var l__1:com.script.poker.table.EmoItemInstSwf;
			if (this.mChildSwf != null){
				l__1 = (this.mChildSwf as EmoItemInstSwf);
				if (l__1){
					l__1.Sleep();
				}
			}
		}
		public function Wake()
		{
			var l__1:com.script.poker.table.EmoItemInstSwf;
			x = 0;
			y = 0;
			if (this.mChildSwf != null){
				l__1 = (this.mChildSwf as EmoItemInstSwf);
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
		public function DelayCreatingEmo(p__1:String, p__2:com.script.poker.table.EmoItem)
		{
			this.mChildSwf = null;
			this.mChildImage = null;
			if (mDelayCreateTimer == null){
				mDelayCreateTimer = new Timer(knDelayCreateTime);
				mDelayCreateTimer.addEventListener(TimerEvent.TIMER, CarryOutCreatingDelayEmo);
			}
			mDelayCreateTimer.start();
		}
		public function CarryOutCreatingDelayEmo(p__1:flash.events.TimerEvent)
		{
			if (!IsPossibleToCreateEmoNow(msImageUrl, moEmo)){
				return;
			}
			mDelayCreateTimer.stop();
			mDelayCreateTimer.removeEventListener(TimerEvent.TIMER, CarryOutCreatingDelayEmo);
			mDelayCreateTimer = null;
			CreateEmoMovieClip(msImageUrl, moEmo);
		}
		public function CreateEmoMovieClip_Swf(p__1:Class, p__2:String):com.script.poker.table.EmoItemInstSwf
		{
			if (!EmoLibrary.GetInst().GetIsSwfEmoAssetsLoaded()){
				return(null);
			}
			var l__3:flash.display.MovieClip = ((new p__1()) as MovieClip);
			var l__4:com.script.poker.table.EmoItemInstSwf = new EmoItemInstSwf(l__3, true);
			mbIsLoaded = true;
			RemoveSpinner();
			return(l__4);
		}
		function CreateEmoMovieClip_Image(p__1:*):flash.display.Loader
		{
			if (!EmoLibrary.GetInst().HasLoadedAllEmoInfo()){
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
			var l__3:flash.display.Loader = CreateEmoMovieClip_Image(msImageUrl);
			this.addChild(l__3);
			this.mChildSwf = null;
			this.mChildImage = l__3;
		}
	}
}