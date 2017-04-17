// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.chat
{
	import com.script.poker.table.TableView;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.TextField;
	public class ChatInput extends flash.display.MovieClip
	{
		public var tv:com.script.poker.table.TableView;
		public var inputField:flash.text.TextField;
		public var bFirstClick:Boolean = false;
		public var inputTime:Boolean = false;
		var sendTimer;
		public static var MAX_INPUT_CHARS:* = 50;
		public function ChatInput(p__1:com.script.poker.table.TableView):void
		{
			setInputFocus = undefined;
			clearHint = undefined;
			catchReturn = undefined;
			inTV = p__1;
			setInputFocus = function(p__1:flash.events.MouseEvent):void
			{
				inputField.stage.focus = inputField;
			};
			clearHint = function(p__1:flash.events.FocusEvent):void
			{
				if (!bFirstClick){
					bFirstClick = true;
					inputField.textColor = "#ffffff";
					inputField.text = "";
				}
			};
			catchReturn = function(p__1:flash.events.KeyboardEvent):void
			{
				if ((p__1.charCode) == 13){
					sendContents();
				}
			};
			tv = inTV;
			inputField.multiline = false;
			inputField.maxChars = MAX_INPUT_CHARS;
			inputField.embedFonts = false;
			inputField.addEventListener(MouseEvent.CLICK, setInputFocus);
			inputField.addEventListener(FocusEvent.FOCUS_IN, clearHint);
			inputField.addEventListener(KeyboardEvent.KEY_UP, catchReturn);
		}
		public function sendContents():void
		{
			var l__1:String;
			var l__2:String;
			if (inputTime){
				
				return;
			}else {
				sendTimer = new flash.utils.Timer(2000);
				sendTimer.addEventListener(flash.events.TimerEvent.TIMER, onSendChat);
				sendTimer.start();
				
				
			}
			if (bFirstClick){
				inputTime = true;
				l__1 = inputField.text;
				if (l__1.charCodeAt(l__1.length - 1) == 13){
					l__2 = l__1.substr(0, l__1.length - 1);
				} else {
					l__2 = l__1;
				}
				if (l__2.length > 0){
					tv.sendChat(l__2);
					inputField.text = "";
				}
			}
		}
		
		private function onSendChat(p__1:flash.events.TimerEvent):void
		{
			//var arr = arguments[0]
			sendTimer.stop();
			sendTimer.removeEventListener(flash.events.TimerEvent.TIMER, onSendChat);
			inputTime = false;
		}
	}
}