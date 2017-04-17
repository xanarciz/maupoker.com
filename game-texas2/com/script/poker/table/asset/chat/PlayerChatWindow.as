// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.chat
{
	import com.script.poker.table.TableView;
	import com.script.poker.table.GiftItemInstSwf;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.TextEvent;
	import flash.events.EventDispatcher;
	import flash.filters.GlowFilter;
	import caurina.transitions.*;
	import com.script.poker.table.events.view.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import com.script.draw.Box;
	import flash.utils.Timer;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import com.script.poker.table.events.*;
	import com.script.text.*;
	import com.script.ui.scroller.TextScrollSystem;
	public class PlayerChatWindow extends flash.display.Sprite
	{
		public var mt:com.script.poker.table.TableView;
		public var thisH:int;
		public var thisW:int;
		public var scroller:com.script.ui.scroller.TextScrollSystem;
		public var chatX:int = 0;
		public var chatY:int = 18;
		private var msgsRecord:flash.utils.Dictionary;
		public var textFormat:flash.text.TextFormat;
		protected var textAreaLines:Array;
		public var bDragText:Boolean = false;
		private var msgsTimer:flash.utils.Timer;
		public var textArea:flash.text.TextField;
		public var chatBG:flash.display.Sprite;
		public var chatPad:flash.display.Sprite;
		public var fakeStage:flash.display.Sprite;
		public var windowBG:com.script.poker.table.asset.chat.ChatWindow;
		public var chatCont:flash.display.Sprite;
		private static var MAX_MESSAGES_IN_PERIOD:* = 20;
		protected static var MAX_LINES:int = 200;
		private static var MAX_INPUT_CHARS:int = 100;
		protected static var CHARS_PER_LINE:int = 25;
		private static var MESSAGE_PERIOD:int = 60000;
		private static var MAX_CHARS_IN_PERIOD:* = MAX_INPUT_CHARS * MAX_MESSAGES_IN_PERIOD;
		public function PlayerChatWindow(p__1:com.script.poker.table.TableView, p__2:String, p__3:int, p__4:int):void
		{
			msgsTimer = new Timer(MESSAGE_PERIOD, 1);
			msgsTimer.addEventListener(TimerEvent.TIMER_COMPLETE, resetMessages);
			msgsRecord = new Dictionary();
			resetMessages();
			mt = p__1;
			thisW = p__3;
			thisH = p__4;
			/*var l__5:Object = new Object();
			l__5.colors = [5592405, 0];
			l__5.alphas = [1, 1];
			l__5.ratios = [0, 200];
			var l__6:com.script.draw.Box = new Box(thisW, chatY, l__5, false, false);
			addChild(l__6);
			var l__7:flash.filters.GlowFilter = new GlowFilter(0, 1, 9, 9, 2, 3, true);
			var l__8:Array = [l__7];
			l__6.filters = l__8;
			var l__9:com.script.text.TextBox = new TextBox(myriadTF, p__2, 14, 16777215, "left", 200);
			l__9.x = 4;
			l__9.y = 9;
			addChild(l__9);*/
			var l__10:Object = new Object();
			l__10.colors = [16777215, 16777215];
			l__10.alphas = [1, 1];
			l__10.ratios = [0, 255];
			chatBG = new Box(thisW - 1, ((thisH - chatY) + 1), l__10, false, false, 0, true, 0, 1);
			chatBG.x = chatX;
			chatBG.y = (chatY + 23);
			chatBG.alpha = 0;
			addChild(chatBG);
			fakeStage = new Sprite();
			fakeStage.graphics.beginFill(0, 0);
			fakeStage.graphics.drawRect(-1000, -1000, 2000, 2000);
			fakeStage.graphics.endFill();
			var l__11:Object = new Object();
			l__11.arrowUp = new ChatArrowUp();
			l__11.arrowDown = new ChatArrowDown();
			l__11.handleV = new ChatHandleV();
			l__11.trackV = new ChatTrackV();
			textAreaLines = new Array();
			textArea = new TextField();
			textArea.width = (thisW - 25);
			textArea.height = (thisH - chatY);
			textArea.x = (chatX + 5);
			textArea.y = (chatY - 17);
			textArea.multiline = true;
			textArea.wordWrap = true;
			textArea.selectable = true;
			textArea.antiAliasType = "advanced";
			textArea.addEventListener(TextEvent.LINK, displayBaseballCard);
			textFormat = new TextFormat();
			textFormat.letterSpacing = 0;
			textFormat.kerning = true;
			textFormat.size = 10;
			textArea.defaultTextFormat = textFormat;
			textArea.addEventListener(Event.SCROLL, checkScroll);
			textArea.addEventListener(MouseEvent.MOUSE_DOWN, setMDCheck);
			scroller = new TextScrollSystem(mt, textArea, (thisW - 20), (thisH - chatY), l__11, 9, 0, true, false);
			scroller.x = (chatX - 2);
			scroller.y = (chatY + 27);
			addChild(scroller);
		}
		public function setMDCheck(p__1:flash.events.MouseEvent):void
		{
			bDragText = true;
			mt.addChild(fakeStage);
			fakeStage.addEventListener(MouseEvent.MOUSE_UP, remMDCheck);
			fakeStage.addEventListener(Event.MOUSE_LEAVE, remMDCheck);
		}
		public function remMDCheck(p__1:*):void
		{
			bDragText = false;
			mt.removeChild(fakeStage);
			fakeStage.removeEventListener(MouseEvent.MOUSE_UP, remMDCheck);
			fakeStage.removeEventListener(Event.MOUSE_LEAVE, remMDCheck);
		}
		public function checkScroll(p__1:flash.events.Event, p__2:Boolean = false):void
		{
			var l__3:Boolean;
			var l__4:Number = 0;
			if ((scroller.bMouseDown == false) && (bDragText == false)){
				l__3 = false;
				l__4 = scroller.getVertHandlePlace();
				if (l__4 > 0.95){
					l__3 = true;
				}
				scroller.vAdjustHandle(l__3);
				scroller.updater(l__3);
			}
			if (bDragText){
				scroller.vAdjustHandle(false);
			}
		}
		public function showMsg(p__1:flash.display.DisplayObject):void
		{
			Tweener.addTween(p__1, {alpha:1, time:0.25, delay:0.25, transition:"easeInOutSine"});
		}
		public function addChatMessage(p__1:String, p__2:String, p__3:String, p__4:String):void
		{
			var l__8:String;
			var l__5:* = "";
			var l__6:int = Math.ceil((p__3.length) / CHARS_PER_LINE);
			updateMessageRecord(p__2, p__3.length);
			if (msgsRecord[p__2].mute){
				return;
			}
			var l__7:int;
			while(l__7 < l__6){
				l__8 = (p__3).substr(l__7 * CHARS_PER_LINE, CHARS_PER_LINE);
				l__8 = l__8.replace(/&/g, "&amp;");
				l__8 = l__8.replace(/</g, "&lt;");
				l__8 = l__8.replace(/>/g, "&gt;");
				if (l__7 == 0){
					l__5 = (((((((("<font face=\"Verdana\" color=\"#ffffff\"><font face=\"Verdana Bold\" color=\"#" + p__4) + "\"><a href=\'event:") + p__1) + "\'>") + p__2) + ":</a> </font>") + l__8) + "</font>");
				} else {
					l__5 = (("<font face=\"Verdana\" color=\"#ffffff\">" + l__8) + "</font>");
				}
				if (l__7 == (l__6 - 1)){
					l__5 = (l__5 + "<br/>");
				}
				textAreaLines.push(l__5);
				if (textAreaLines.length > MAX_LINES){
					textAreaLines.shift();
				}
				l__7++;
			}
			textArea.htmlText = textAreaLines.join("");
			textArea.setTextFormat(textFormat);
		}
		private function resetMessages(p__1:flash.events.TimerEvent = null):void
		{
			var l__2:Object;
			msgsInPeriod = 0;
			charsInPeriod = 0;
			for each (l__2 in msgsRecord){
				l__2.msgsInPeriod = 0;
				l__2.charsInPeriod = 0;
			}
			msgsTimer.reset();
			msgsTimer.start();
		}
		private function updateMessageRecord(p__1:String, p__2:int):void
		{
			var l__3:Object;
			if ((msgsRecord[p__1] == undefined) || (msgsRecord[p__1] == null)){
				msgsRecord[p__1] = {name:p__1, msgsInPeriod:1, charsInPeriod:p__2, mute:false, firstStamp:flash.utils.getTimer(), lastStamp:flash.utils.getTimer()};
			} else {
				l__3 = msgsRecord[p__1];
				l__3.msgsInPeriod = (l__3.msgsInPeriod + 1);
				l__3.charsInPeriod = (l__3.charsInPeriod + p__2);
				l__3.lastStamp = flash.utils.getTimer();
				if ((l__3.msgsInPeriod >= MAX_MESSAGES_IN_PERIOD) || (l__3.charsInPeriod >= MAX_CHARS_IN_PERIOD)){
					l__3.mute = true;
				}
			}
		}
		private function displayBaseballCard(p__1:flash.events.TextEvent):void
		{
			dispatchEvent(new TVEChatNamePressed(TVEvent.CHAT_NAME_PRESSED, p__1.text));
		}
	}
}