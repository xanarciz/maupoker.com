// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import com.script.poker.table.asset.PokerButton;
	import caurina.transitions.*;
	import com.script.poker.table.events.view.TVEChatNamePressed;
	import com.script.draw.*;
	import com.script.poker.table.asset.joinuser.*;
	import com.script.format.*;
	import com.script.poker.table.events.*;
	import com.script.poker.table.asset.chat.*;
	import com.script.text.TextBox;
	public class ChatController extends flash.events.EventDispatcher
	{
		public var mt:com.script.poker.table.TableView;
		public var network:String;
		public var dcY:int = 356;
		public var mcX:int = 539;
		public var mcY:int = 356;
		public var dealerChat:com.script.poker.table.asset.chat.DealerChatWindow;
		public var networksButton:com.script.poker.table.asset.PokerButton;
		public var sendButton:com.script.poker.table.asset.PokerButton;
		public var inputter:com.script.poker.table.asset.chat.ChatInput;
		public var muteListButton:com.script.poker.table.asset.PokerButton;
		public var emoListButton:com.script.poker.table.asset.PokerButton;
		public var chatButton:com.script.poker.table.asset.PokerButton;
		public var tabButtons:Array = new Array();
		public var muteListCont:flash.display.Sprite;
		public var waitListCont:flash.display.Sprite;
		public var mainChat:com.script.poker.table.asset.chat.PlayerChatWindow;
		public var friendsButton:com.script.poker.table.asset.PokerButton;
		public var dcX:int = 10;
		public var mutex:int=0;
		private var langs;
		
		public function ChatController(p__1:com.script.poker.table.TableView, p__2:flash.display.MovieClip)
		{
			mt = p__1;
			cont = p__2;
			langs = mt.langs;
			initChats();
			initInput();
			initButtons();
		}
		public function initChats():void
		{
			var l__1:* = 147;
			var l__2:Boolean;
			dealerChat = new DealerChatWindow(mt, langs.l_dealchat, 215, l__1, l__2);
			dealerChat.x = dcX;
			dealerChat.y = dcY;
			dealerChat.addEventListener(TVEvent.CHAT_NAME_PRESSED, onChatNamePressed);
			cont.addChild(dealerChat);
			mainChat = new PlayerChatWindow(mt, langs.l_chat, 215, 120);
			mainChat.x = mcX;
			mainChat.y = mcY;
			mainChat.addEventListener(TVEvent.CHAT_NAME_PRESSED, onChatNamePressed);
			cont.addChild(mainChat);
		}
		public function initButtons():void
		{
			muteListButton = new PokerButton(myriadTF, "small", langs.l_mute, null, 38, 2);
			//cont.addChild(muteListButton);
			muteListButton.x = (mcX + 193);
			muteListButton.y = (mcY + 3);
			muteListButton.addEventListener(MouseEvent.CLICK, muteListPress);
			
			emoListButton = new PokerButton(myriadTF, "small", langs.l_emoticon, null, 60, 2);
			//cont.addChild(emoListButton);
			emoListButton.x = (mcX + 110);
			emoListButton.y = (mcY + 3);
			emoListButton.addEventListener(MouseEvent.CLICK, emoListPress);
		}
		public function initInput():void
		{
			var sendInput = undefined;
			sendInput = function(p__1:flash.events.MouseEvent):void
			{
				
				
				inputter.sendContents();
			};
			inputter = new ChatInput(mt);
			cont.addChild(inputter);
			inputter.x = (mcX-130);
			inputter.y = (mcY + 263);
			var sendGfxObj:Object = new Object();
			sendGfxObj.gfx = AutoTriangle.make(3355443);
			sendGfxObj.theX = 40;
			sendGfxObj.theY = 5;
			sendButton = new PokerButton(myriadTF, "medium", langs.l_send, sendGfxObj, 50, 2);
			//cont.addChild(sendButton);
			sendButton.x = (mcX + 181);
			sendButton.y = (mcY + 21);
			sendButton.addEventListener(MouseEvent.CLICK, sendInput);
		}
		
		public function addChatMessage(p__1:String, p__2:String, p__3:String, p__4:Number)
		{
			var l__7:* = undefined;
			var l__8:String;
			var l__5:Array = mt.ptModel.aBlockedUsers;
			var l__6:Boolean;
			for (l__7 in l__5){
				if ((p__2) == l__5[l__7]){
					l__6 = true;
				}
			}
			switch(p__4){
				case 0:
				{
					l__8 = "800000";
					break;
				}
				case 1:
				{
					l__8 = "006400";
					break;
				}
				case 2:
				{
					l__8 = "000080";
					break;
				}
				case 3:
				{
					l__8 = "8A2BE2";
					break;
				}
				case 4:
				{
					l__8 = "0000FF";
					break;
				}
				case 5:
				{
					l__8 = "32CD32";
					break;
				}
				case 6:
				{
					l__8 = "D2691E";
					break;
				}
				case 7:
				{
					l__8 = "C71858";
					break;
				}
				case 8:
				{
					l__8 = "6390BA";
					break;
				}
				case 9:
				{
					l__8 = "6F6F6F";
					break;
				}
				case -1:
				{
					l__8 = "333333";
					break;
				}
			}
			if (!l__6){
				mainChat.addChatMessage(p__1, p__2, p__3, l__8);
			}
		}
		public function addDealerMessage(p__1:String, p__2:String)
		{
			var l__3:uint;
			if ((p__2) == "win"){
				l__3 = 16763904;
			}
			p__1 = StringUtility.addFontTag(p__1, "Verdana");
			dealerChat.addDealerMessage(p__1, l__3);
		}
		public function leaveTable():void
		{
			var l__2:flash.display.DisplayObject;
			var l__1:int;
			while(cont.numChildren > 0){
				l__2 = cont.getChildAt(0);
				cont.removeChild(l__2);
				l__2 = null;
			}
		}
		public function muteListPress(p__1:flash.events.MouseEvent = null):void
		{
			mt.onMutePressed();
		}
		public function emoListPress(p__1:flash.events.MouseEvent = null):void
		{
			//dispatchEvent(new TVEChatNamePressed(TVEvent.EMO_PRESSED));
			mt.onEmoPressed();
			
		}
		public function muteListUp(p__1:flash.events.MouseEvent = null):void
		{
			var l__5:* = undefined;
			var l__6:flash.display.Sprite;
			var l__7:flash.display.Sprite;
			var l__8:com.script.text.TextBox;
			var l__9:flash.display.Sprite;
			var l__10:Boolean;
			var l__11:* = undefined;
			var l__12:com.script.poker.table.asset.chat.MuteUser;
			muteListCont = new Sprite();
			var l__2:flash.display.Sprite = new Sprite();
			muteListCont.addChild(l__2);
			var l__3:Array = mt.ptModel.aUsersInRoom;
			var l__4:Array = mt.ptModel.aBlockedUsers;
			if (l__3.length > 0){
				for (l__5 in l__3){
					l__10 = false;
					for (l__11 in l__4){
						if (l__3[l__5].zid == l__4[l__11]){
							l__10 = true;
						}
					}
					l__12 = new MuteUser(l__3[l__5].name, l__3[l__5].zid, l__10);
					l__12.y = l__5 * 20;
					l__12.buttonMode = true;
					l__12.useHandCursor = true;
					l__12.addEventListener(MouseEvent.CLICK, swapBlock);
					l__2.addChild(l__12);
				}
				l__2.y = ((0 - l__2.height) - 15);
				l__2.x = -20;
				l__6 = new Sprite();
				l__6.graphics.beginFill(0, 1);
				l__6.graphics.drawRect(l__2.x, l__2.y, l__2.width, l__2.height);
				l__6.graphics.endFill();
				muteListCont.addChild(l__6);
				l__2.mask = l__6;
				l__7 = new Sprite();
				l__7.graphics.beginFill(0, 1);
				l__7.graphics.drawRoundRect(l__2.x, (l__2.y - 20), l__2.width, (l__2.height + 20), 11);
				l__7.graphics.endFill();
				l__7.alpha = 1;
				muteListCont.addChildAt(l__7, 0);
				l__8 = new TextBox(myriadTF, langs.l_userlist, 13, 16777215, "left");
				muteListCont.addChildAt(l__8, 1);
				l__8.y = ((0 - l__2.height) - 24);
				l__8.x = -16;
				l__9 = new Sprite();
				l__9.graphics.beginFill(16711680, 0);
				l__9.graphics.drawRect((l__2.x - 25), (l__2.y - 25), (l__2.width + 50), (l__2.height + 50));
				l__9.graphics.endFill();
				muteListCont.addChildAt(l__9, 0);
				l__9.addEventListener(MouseEvent.CLICK, closeBySkirt);
				muteListCont.x = (mcX + 235);
				muteListCont.y = (mcY + 13);
				muteListCont.alpha = 0;
				muteListCont.scaleX = muteListCont.scaleY = 0;
				cont.addChild(muteListCont);
				Tweener.addTween(muteListCont, {alpha:1, time:0, transition:"easeOutSine"});
				Tweener.addTween(muteListCont, {scaleX:1, scaleY:1, x:(mcX + 135), time:0, transition:"easeOutBack"});
				muteListCont.addEventListener(MouseEvent.ROLL_OUT, killMuteList);
			}
		}
		public function waitListUp(p__1:flash.events.MouseEvent = null):void
		{
			if (waitListCont != null){
				//if (cont.waitListCont != undefined || cont.waitListCont != null){
				cont.removeChild(waitListCont);
				waitListCont = null;
				//}
			}
			
			var l__5:* = undefined;
			var l__6:flash.display.Sprite;
			var l__7:flash.display.Sprite;
			var l__8:com.script.text.TextBox;
			var l__9:flash.display.Sprite;
			var l__10:Boolean;
			var l__11:* = undefined;
			var l__12:com.script.poker.table.asset.chat.WaitUser;
			waitListCont = new Sprite();
			var l__2:flash.display.Sprite = new Sprite();
			waitListCont.addChild(l__2);
			var l__3:Array = mt.ptModel.aUsersWaiting;
			//var l__4:Array = mt.ptModel.aBlockedUsers;
			if (l__3.length > 0){
				for (l__5 in l__3){
					l__10 = false;
					l__12 = new WaitUser(l__3[l__5].name, l__3[l__5].zid, l__10);
					l__12.y = l__5 * 20;
					//l__12.buttonMode = true;
					//l__12.useHandCursor = true;
					//l__12.addEventListener(MouseEvent.CLICK, swapBlock);
					l__2.addChild(l__12);
				}
				l__2.y = 80;
				l__2.x = 40;
				l__6 = new Sprite();
				l__6.graphics.beginFill(0, 1);
				l__6.graphics.drawRect(l__2.x, l__2.y, l__2.width, l__2.height);
				l__6.graphics.endFill();
				//l__7.alpha = 0;
				waitListCont.addChild(l__6);
				l__2.mask = l__6;
				/*l__7 = new Sprite();
				l__7.graphics.beginFill(0, 1);
				l__7.graphics.drawRoundRect(l__2.x, (l__2.y - 20), l__2.width, (l__2.height + 20), 11);
				l__7.graphics.endFill();
				l__7.alpha = 1;
				waitListCont.addChildAt(l__7, 0);*/
				//l__8 = new TextBox(myriadTF, "Waiting List:", 13, 14329120, "left");
				//waitListCont.addChildAt(l__8, 1);
				//l__8.y = 70;
				//l__8.x = 20;
				/*l__9 = new Sprite();
				l__9.graphics.beginFill(16711680, 0);
				l__9.graphics.drawRect((l__2.x - 25), (l__2.y - 25), (l__2.width + 50), (l__2.height + 50));
				l__9.graphics.endFill();
				muteListCont.addChildAt(l__9, 0);
				l__9.addEventListener(MouseEvent.CLICK, closeBySkirt);*/
				waitListCont.x = 750;
				waitListCont.y = 0;
				waitListCont.alpha = 0;
				waitListCont.scaleX = waitListCont.scaleY = 0;
				cont.addChild(waitListCont);
				Tweener.addTween(waitListCont, {alpha:1, time:0, transition:"easeOutSine"});
				Tweener.addTween(waitListCont, {scaleX:1, scaleY:1, x:(mcX + 135), time:0, transition:"easeOutBack"});
				//muteListCont.addEventListener(MouseEvent.ROLL_OUT, killMuteList);
			}
		}
		public function emoListUp(p__1:flash.events.MouseEvent = null):void
		{
			var l__5:* = undefined;
			var l__6:flash.display.Sprite;
			var l__7:flash.display.Sprite;
			var l__8:com.script.text.TextBox;
			var l__9:flash.display.Sprite;
			var l__10:Boolean;
			var l__11:* = undefined;
			var l__12:com.script.poker.table.asset.chat.MuteUser;
			muteListCont = new Sprite();
			var l__2:flash.display.Sprite = new Sprite();
			muteListCont.addChild(l__2);
			var l__3:Array = mt.ptModel.aUsersInRoom;
			var l__4:Array = mt.ptModel.aBlockedUsers;
			if (l__3.length > 0){
				for (l__5 in l__3){
					l__10 = false;
					for (l__11 in l__4){
						if (l__3[l__5].zid == l__4[l__11]){
							l__10 = true;
						}
					}
					l__12 = new MuteUser(l__3[l__5].name, l__3[l__5].zid, l__10);
					l__12.y = l__5 * 20;
					l__12.buttonMode = true;
					l__12.useHandCursor = true;
					l__12.addEventListener(MouseEvent.CLICK, swapBlock);
					l__2.addChild(l__12);
				}
				l__2.y = ((0 - l__2.height) - 15);
				l__2.x = -20;
				l__6 = new Sprite();
				l__6.graphics.beginFill(0, 1);
				l__6.graphics.drawRect(l__2.x, l__2.y, l__2.width, l__2.height);
				l__6.graphics.endFill();
				muteListCont.addChild(l__6);
				l__2.mask = l__6;
				l__7 = new Sprite();
				l__7.graphics.beginFill(0, 1);
				l__7.graphics.drawRoundRect(l__2.x, (l__2.y - 20), l__2.width, (l__2.height + 20), 11);
				l__7.graphics.endFill();
				l__7.alpha = 1;
				muteListCont.addChildAt(l__7, 0);
				l__8 = new TextBox(myriadTF, "Mute User\'s Chat", 13, 16777215, "left");
				muteListCont.addChildAt(l__8, 1);
				l__8.y = ((0 - l__2.height) - 24);
				l__8.x = -16;
				l__9 = new Sprite();
				l__9.graphics.beginFill(16711680, 0);
				l__9.graphics.drawRect((l__2.x - 25), (l__2.y - 25), (l__2.width + 50), (l__2.height + 50));
				l__9.graphics.endFill();
				muteListCont.addChildAt(l__9, 0);
				l__9.addEventListener(MouseEvent.CLICK, closeBySkirt);
				muteListCont.x = (mcX + 235);
				muteListCont.y = (mcY + 13);
				muteListCont.alpha = 0;
				muteListCont.scaleX = muteListCont.scaleY = 0;
				cont.addChild(muteListCont);
				Tweener.addTween(muteListCont, {alpha:1, time:0, transition:"easeOutSine"});
				Tweener.addTween(muteListCont, {scaleX:1, scaleY:1, x:(mcX + 135), time:0, transition:"easeOutBack"});
				//muteListCont.addEventListener(MouseEvent.ROLL_OUT, killMuteList);
			}
		}
		public function closeBySkirt(p__1:flash.events.MouseEvent)
		{
			killMuteList();
		}
		public function killMuteList(evt:flash.events.MouseEvent = null, delay:Number = 0):void
		{
			Tweener.addTween(muteListCont, {alpha:0, scaleX:0, scaleY:0, x:(mcX + 235), time:0, delay:delay, transition:"easeOutSine", onComplete:function()
			{
				cont.removeChild(muteListCont);
				muteListCont = null;
				mutex=0;
			}});
		}
		public function swapBlock(p__1:flash.events.MouseEvent):void
		{
			var l__2:* = p__1.currentTarget;
			var l__3:Boolean = l__2.blocked;
			var l__4:String = l__2.zid;
			if (l__3){
				removeFromBlockList(l__4);
			} else if (!l__3){
				addToBlockList(l__4);
			}
			l__2.swapCheck();
		}
		public function addToBlockList(p__1:String):void
		{
			mt.updateBlockList(p__1, "add");
		}
		public function removeFromBlockList(p__1:String):void
		{
			mt.updateBlockList(p__1, "remove");
		}
		public function toggleTabs(p__1:flash.events.MouseEvent):void
		{
			var l__3:* = undefined;
			var l__2:com.script.poker.table.asset.PokerButton = p__1.currentTarget;
			hideAllTabContent();
			for (l__3 in tabButtons){
				tabButtons[l__3].setActivity(true);
				if (l__2.thisName == tabButtons[l__3].thisName){
					tabButtons[l__3].setActivity(false);
					if (l__2.thisName == "chat"){
						showChatTab();
					}
					if (l__2.thisName == "friends"){
						showFriendsTab();
					}
					if (l__2.thisName == "networks"){
						showNetworksTab();
					}
				}
			}
		}
		public function onChatNamePressed(p__1:com.script.poker.table.events.view.TVEChatNamePressed)
		{
			dispatchEvent((p__1).clone());
		}
	}
}