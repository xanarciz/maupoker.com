// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.script.poker.table.asset.PokerButton;
	import com.script.poker.table.asset.HandIcon;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import com.script.draw.Box;
	public class HandController
	{
		public var mt:com.script.poker.table.TableView;
		public var cont:flash.display.MovieClip;
		private var handButton:com.script.poker.table.asset.PokerButton;
		public var handIcon:com.script.poker.table.asset.HandIcon;
		public var currentLevel:int = -1;
		public var bHandStrengthPressed:Boolean = false;
		public var hsText:flash.text.TextField;
		private var high:com.script.draw.Box;
		private var handList:flash.display.Sprite;
		public var hsBg:flash.display.Sprite;
		public var handListText:Array = ["High Card", "One Pair", "Two Pair", "Three of a Kind", "Straight", "Flush", "Full House", "Four of a Kind", "Straight Flush", "Royal Flush"];
		
		public var fontSize:int;
		public function HandController(p__1:com.script.poker.table.TableView, p__2:flash.display.MovieClip)
		{
			mt = p__1;
			cont = p__2;
			hsText = new TextField();
			hsBg = new Sprite();
			initHandStrength();
			 
		}
		public function initHandStrength():void
		{
			makeButton();
			makeHandList();
			hideMe(false);
			fontSize = 12;
			hsText.width = 220;
			hsText.height = 24;
			hsText.x = 292;
			hsText.y = 507;
			hsBg.graphics.beginFill(6184542, 1);
			hsBg.graphics.drawRect(0, 0, 220, 24);
			hsBg.graphics.endFill();
			hsBg.graphics.beginFill(10000536, 1);
			hsBg.graphics.drawRect(1, 1, 218, 22);
			hsBg.graphics.endFill();
			hsBg.x = 290;
			hsBg.y = 464;
			hsText.visible = false;
			//cont.addChild(hsBg);
			cont.addChild(hsText);
		}
		private function makeButton():void
		{
			handIcon = new HandIcon();
			var l__1:flash.display.Sprite = new Sprite();
			l__1.addChild(handIcon);
			var l__2:Object = new Object();
			l__2.gfx = l__1;
			l__2.theX = 6;
			l__2.theY = 5;
			handButton = new PokerButton(myriadTF, "large", "", l__2, 30);
			handButton.x = 250;
			handButton.y = 464;
			//handButton.addEventListener(MouseEvent.CLICK, onHandPressed);
			//cont.addChild(handButton);
		}
		private function onHandPressed(p__1:flash.events.MouseEvent):void
		{
			bHandStrengthPressed = !bHandStrengthPressed;
			handIcon.toggler(bHandStrengthPressed);
			toggleList(bHandStrengthPressed);
		}
		private function makeHandList():void
		{
			var l__1:* = undefined;
			var l__2:Object;
			var l__3:com.script.draw.Box;
			var l__4:Object;
			var l__5:flash.filters.DropShadowFilter;
			var l__6:Array;
			var l__7:flash.text.TextField;
			handList = new Sprite();
			for (l__1 in handListText){
				l__7 = new TextField();
				l__7.width = 80;
				l__7.height = 16;
				l__7.multiline = false;
				l__7.selectable = false;
				if(l__1 == 0){
					handListText[l__1] = mt.langs.l_highcard;
				}if(l__1 == 1){
					handListText[l__1] = mt.langs.l_onepair;
				}if(l__1 == 2){
					handListText[l__1] = mt.langs.l_twopair;
				}if(l__1 == 3){
					handListText[l__1] = mt.langs.l_threeofakind;
				}if(l__1 == 4){
					handListText[l__1] = mt.langs.l_straight;
				}if(l__1 == 5){
					handListText[l__1] = mt.langs.l_flush;
				}if(l__1 == 6){
					handListText[l__1] = mt.langs.l_fullhouse;
				}if(l__1 == 7){
					handListText[l__1] = mt.langs.l_fourofakind;
				}if(l__1 == 8){
					handListText[l__1] = mt.langs.l_straightflush;
				}if(l__1 == 9){
					handListText[l__1] = mt.langs.l_royalflush;
				}
				l__7.htmlText = (("<font face=\"Myriad Pro\" size=\"10\" color=\"#ffffff\">" + handListText[l__1]) + "</font>");
				l__7.y = (handListText.length - 1 - l__1) * 13;
				handList.addChild(l__7);
			}
			handList.x = 180;
			handList.y = 390;
			l__2 = new Object();
			
			l__2.colors = [3158064,0];
			l__2.alphas = [1,1];
			l__2.ratios = [0,200];
			l__3 = new Box(90, (handListText.length * 13 + 5), l__2, false, false, 0, true, 0, 1);
			l__3.x = -5;
			l__3.y = -1;
			l__4 = new Object();
			l__4.colors = [16494651];
			l__4.alphas = [1];
			l__4.ratios = [0];
			high = new Box(89, 12, l__4, false);
			high.x = -4;
			setHighlight();
			handList.addChildAt(high, 0);
			l__5 = new DropShadowFilter(1, 90, 0, 0.75, 5, 5, 1, 3);
			l__6 = [l__5];
			l__3.filters = l__6;
			handList.addChildAt(l__3, 0);
			handList.visible = false;
			cont.addChild(handList);
		}
		public function hideMe(p__1:Boolean):void
		{
			if (p__1){
				currentLevel = -1;
			}
			setHighlight();
			if (hsText != null){
				hsText.visible = !(p__1);
			}
		}
		public function toggleList(p__1:Boolean):void
		{
			handList.visible = p__1;
		}
		public function setHighlight():void
		{
			if (high != null){
				if (currentLevel == -1){
					high.visible = false;
				} else if (currentLevel > -1){
					high.visible = true;
				}
				high.y = ((handListText.length - 1 - currentLevel) * 13 + 1);
			}
		}
		public function setHandStrength(p__1:int, p__2:String):void
		{
			currentLevel = p__1;
			setHighlight();
			if (hsText != null){
				hsText.htmlText = (((("<font face=\"Verdana Bold\" size=\"" + fontSize) + "\" color=\"#ffffff\">"+mt.langs.l_hand+":") + p__2) + "</font>");
			}
			hideMe(false);
		}
		public function cleanUp():void
		{
			/*if (hsBg != null){
				cont.removeChild(hsBg);
				hsBg = null;
			}*/
			if (hsText != null){
				cont.removeChild(hsText);
				hsText = null;
			}
			if (handList != null){
				cont.removeChild(handList);
				handList = null;
			}
			/*if (handButton != null){
				//cont.removeChild(handButton);
				//handButton = null;
			}*/
		}
	}
}