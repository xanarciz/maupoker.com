// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.chat
{
	import com.script.poker.table.TableView;
	import com.script.poker.table.GiftController;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.events.EventDispatcher;
	import flash.filters.GlowFilter;
	import caurina.transitions.*;
	import com.script.poker.table.events.view.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import com.script.draw.Box;
	import com.script.poker.table.events.*;
	import com.script.text.*;
	import com.script.ui.scroller.TextScrollSystem;
	public class DealerChatWindow extends flash.display.Sprite
	{
		public var mt:com.script.poker.table.TableView;
		public var thisH:int;
		public var thisW:int;
		public var scroller:com.script.ui.scroller.TextScrollSystem;
		public var chatX:int = 0;
		public var chatY:int = 18;
		public var textFormat:flash.text.TextFormat;
		public var bDragText:Boolean = false;
		public var textArea:flash.text.TextField;
		public var chatBG:flash.display.Sprite;
		public var chatPad:flash.display.Sprite;
		public var fakeStage:flash.display.Sprite;
		public var windowBG:com.script.poker.table.asset.chat.ChatWindow;
		public var chatCont:flash.display.Sprite;
		public var textAreaMsgs:Array;
		protected var MAX_MESSAGES:int = 200;
		public function DealerChatWindow(p__1:com.script.poker.table.TableView, p__2:String, p__3:int, p__4:int, p__5:Boolean):void
		{
			var l__12:Object;
			mt = p__1;
			thisW = p__3;
			thisH = p__4;
			var l__6:Object = new Object();
			l__6.colors = [5592405, 0];
			l__6.alphas = [1, 1];
			l__6.ratios = [0, 200];
			/**var l__7:com.script.draw.Box = new Box(thisW, chatY, l__6, false, false);
			if (p__5){
				l__7.y = -22;
			}
			addChild(l__7);*/
			var l__8:flash.filters.GlowFilter = new GlowFilter(0, 1, 9, 9, 2, 3, true);
			var l__9:Array = [l__8];
			/*l__7.filters = l__9;
			var l__10:com.script.text.TextBox = new TextBox(myriadTF, p__2, 14, 16777215, "left", 200);
			l__10.x = 4;
			l__10.y = 9;
			if (p__5){
				l__10.y = -13;
			}
			addChild(l__10);*/
			var l__11:Object = new Object();
			l__11.colors = [16777215, 16777215];
			l__11.alphas = [1, 1];
			l__11.ratios = [0, 255];
			chatBG = new Box(thisW - 1, (thisH - chatY), l__11, false, false, 0, true, 0, 1);
			chatBG.x = chatX;
			chatBG.y = (chatY + 23);
			chatBG.alpha = 0;
			addChild(chatBG);
			fakeStage = new Sprite();
			fakeStage.graphics.beginFill(16711680, 0);
			fakeStage.graphics.drawRect(-1000, -1000, 2000, 2000);
			fakeStage.graphics.endFill();
			l__12 = new Object();
			l__12.arrowUp = new ChatArrowUp();
			l__12.arrowDown = new ChatArrowDown();
			l__12.handleV = new ChatHandleV();
			l__12.trackV = new ChatTrackV();
			textAreaMsgs = new Array();
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
			scroller = new TextScrollSystem(mt, textArea, (thisW - 20), (thisH - chatY), l__12, 9, 0, true, false);
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
		public function addDealerMessage(p__1:String, p__2:uint = 16777215):void
		{
			textAreaMsgs.push(p__1);
			if (textAreaMsgs.length > MAX_MESSAGES){
				textAreaMsgs.shift();
			}
			textArea.htmlText = textAreaMsgs.join("<br/>");
			textArea.setTextFormat(textFormat);
		}
		public function showMsg(p__1:flash.display.DisplayObject):void
		{
			Tweener.addTween(p__1, {alpha:1, time:0.25, delay:0.25, transition:"easeInOutSine"});
		}
		public function displayBaseballCard(p__1:flash.events.TextEvent):void
		{
			dispatchEvent(new TVEChatNamePressed(TVEvent.CHAT_NAME_PRESSED, p__1.text));
		}
	}
}