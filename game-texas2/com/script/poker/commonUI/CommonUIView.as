// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.commonUI
{
	import fl.data.DataProvider;
	import flash.display.*;
	import flash.events.EventDispatcher;
	import com.script.poker.commonUI.events.*;
	public class CommonUIView extends flash.display.MovieClip
	{
		private var fSelector:com.script.poker.commonUI.FriendSelector;
		private var commonControl:Object;
		public function CommonUIView(p__1:Object)
		{
			commonControl = p__1;
			fSelector = new FriendSelector();
			fSelector.x = 506;
			fSelector.y = 100;
			addChild(fSelector);
			fSelector.hideClose(true);
			addEventListeners();
		}
		public function showPlayingNow()
		{
			fSelector.showPlayingNow();
		}
		public function ZLiveHideClose(p__1:Boolean)
		{
			if (p__1){
				fSelector.hideClose(true);
			} else {
				fSelector.hideClose(false);
			}
		}
		public function ZLiveScrollToTop():void
		{
			if (fSelector){
				fSelector.scrollToTop();
			}
		}
		private function addEventListeners():void
		{
			commonControl.addEventListener(CommonCEvent.HIDE_FRIEND_SELECTOR, onHideFriendSelector);
			commonControl.addEventListener(CommonCEvent.SHOW_FRIEND_SELECTOR, onShowFriendSelector);
			commonControl.addEventListener(CommonCEvent.VIEW_INIT, onViewInit);
		}
		public function updatePlayingNowDP(p__1:fl.data.DataProvider):void
		{
			fSelector.updatePNusers(p__1);
		}
		public function updateOnline(p__1:int):void
		{
			fSelector.updateFONusers(p__1);
		}
		public function updateOffline(p__1:int):void
		{
			fSelector.updateFOFFusers(-1);
		}
		private function onViewInit(p__1:com.script.poker.commonUI.events.CommonCEvent):void
		{
			fSelector.init();
		}
		private function onHideFriendSelector(p__1:com.script.poker.commonUI.events.CommonCEvent):void
		{
			fSelector.visible = false;
		}
		private function onShowFriendSelector(p__1:com.script.poker.commonUI.events.CommonCEvent):void
		{
			//fSelector.visible = true;
		}
	}
}