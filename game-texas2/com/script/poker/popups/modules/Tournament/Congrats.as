// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.Tournament
{
	import flash.events.*;
	import com.script.format.*;
	import com.script.poker.popups.modules.events.*;
	import com.script.poker.table.asset.*;
	import flash.display.*;
	import flash.text.*;
	public class Congrats extends flash.display.MovieClip
	{
		private var _winnings:String = "no";
		private var _place:String = "0th";
		private var thisPlace:Number;
		public var bFacebook:Boolean = false;
		private var thisWinnings:Number;
		public var text:String;
		public var pipe:* = true;
		public var feedButton:com.script.poker.table.asset.PokerButton;
		public var field:flash.text.TextField;
		public var fieldx:*;
		public function Congrats()
		{
		}
		public function preflight(p__1:*)
		{
			var l__2:* = p__1.font1;
			var l__3:* = new l__2();
			fieldx = l__3.field;
			fieldx.width = 285;
			fieldx.height = 130;
			fieldx.y = 15;
			var l__4:* = p__1.myriad;
			feedButton = new com.script.poker.table.asset.PokerButton(l__4, "large", "Tell your Friends!", null, -1, 5);
			feedButton.x = 90;
			feedButton.y = 164;
			feedButton.visible = false;
			addChild(feedButton);
			addChild(fieldx);
			setPlace(1);
			initListeners();
		}
		private function initListeners():void
		{
			feedButton.addEventListener(flash.events.MouseEvent.CLICK, onFeedButton);
		}
		private function removeListeners():void
		{
			feedButton.removeEventListener(flash.events.MouseEvent.CLICK, onFeedButton);
		}
		private function onFeedButton(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new com.script.poker.popups.modules.events.CongratsEvent(com.script.poker.popups.modules.events.CongratsEvent.FEED_PUBLISH, thisPlace, thisWinnings));
		}
		public function setPlace(p__1:Number)
		{
			thisPlace = p__1;
			_place = com.script.format.StringUtility.GetOrdinal(p__1);
		}
		public function setWinnings(p__1:Number)
		{
			thisWinnings = p__1;
			_winnings = String(p__1);
		}
		public function renderText()
		{
			fieldx.htmlText = (((("<font size=\'25\' color=\'#009900\'><b>Congratulations!</b></font><br><br><font size=\'15\'>You finished in <b>" + _place) + "</b> place.<br>You won <b>") + _winnings) + "</b> chips.</font>");
			var l__1:* = new flash.text.TextFormat();
			l__1.align = "center";
			fieldx.setTextFormat(l__1);
		}
		public function showFeedButton()
		{
			feedButton.visible = false;
			if (bFacebook && (thisPlace < 4)){
				feedButton.visible = true;
			}
		}
	}
}