// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class EmoItemInstSwf extends flash.display.MovieClip
	{
		var mAnimTimer_Play:flash.utils.Timer = null;
		var mmcEmo:flash.display.MovieClip = null;
		var mAnimTimer_Replay:flash.utils.Timer = null;
		public function EmoItemInstSwf(p__1:flash.display.MovieClip, p__2:Boolean)
		{
			if ((p__1) == null){
				return;
			}
			mmcEmo = p__1;
			addChild(mmcEmo);
			if (p__2){
				CreateAnimateTimer();
			}
		}
		public function Release()
		{
			ReleaseAnimateTimer();
			if (mmcEmo == null){
				return;
			}
			if (contains(mmcEmo)){
				removeChild(mmcEmo);
			}
			mmcEmo = null;
		}
		public function Sleep()
		{
			ReleaseAnimateTimer();
		}
		public function Wake()
		{
			CreateAnimateTimer();
		}
		private function ReleaseAnimateTimer()
		{
			if (mAnimTimer_Play){
				mAnimTimer_Play.stop();
				mAnimTimer_Play.removeEventListener(TimerEvent.TIMER, StopClip);
				mAnimTimer_Play = null;
			}
			if (mAnimTimer_Replay){
				mAnimTimer_Replay.stop();
				mAnimTimer_Replay.removeEventListener(TimerEvent.TIMER, StopClip);
				mAnimTimer_Replay = null;
			}
		}
		private function CreateAnimateTimer()
		{
			ReleaseAnimateTimer();
			var l__1:Number = (Math.round(Math.random() * 4000) + 4000);
			mAnimTimer_Play = new Timer(l__1, 1);
			mAnimTimer_Play.addEventListener(TimerEvent.TIMER, StopClip);
			mAnimTimer_Play.start();
			var l__2:Number = (Math.round(Math.random() * 15000) + 10000);
			mAnimTimer_Replay = new Timer(l__2, 1);
			mAnimTimer_Replay.addEventListener(TimerEvent.TIMER, ReplayClip);
		}
		function StopClip(p__1:flash.events.TimerEvent):void
		{
			if (mmcEmo && mmcEmo.clip){
				mmcEmo.clip.stop();
			}
			if (mAnimTimer_Replay){
				mAnimTimer_Replay.reset();
				mAnimTimer_Replay.delay = (Math.round(Math.random() * 15000) + 10000);
				mAnimTimer_Replay.start();
			}
		}
		function ReplayClip(p__1:flash.events.TimerEvent):void
		{
			if (mmcEmo && mmcEmo.clip){
				mmcEmo.clip.play();
			}
			if (mAnimTimer_Play){
				mAnimTimer_Play.reset();
				mAnimTimer_Play.delay = (Math.round(Math.random() * 15000) + 10000);
				mAnimTimer_Play.start();
			}
		}
	}
}