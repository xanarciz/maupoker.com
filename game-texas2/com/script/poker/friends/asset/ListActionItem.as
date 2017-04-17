// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.friends.asset
{
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import com.script.text.*;
	import com.script.draw.*;
	import com.script.poker.commonUI.asset.*;
	import flash.filters.*;
	public class ListActionItem extends flash.display.Sprite
	{
		public var button2:com.script.draw.Box;
		public var bg:com.script.draw.Box;
		public var icons:com.script.poker.commonUI.asset.LAIcons;
		private var inviteButton:com.script.poker.commonUI.asset.PlayerCTA;
		public var butShad:flash.filters.DropShadowFilter = new DropShadowFilter(0, 0, 576767, 1, 5, 5, 1, 3);
		public var tY:int = 43;
		public var additional:* = "";
		public var tX:int = 220;
		private var text2:com.script.text.TextBox;
		public var butGlow:flash.filters.GlowFilter = new GlowFilter(0, 0.6, 1.6, 1.6, 2, 3, true);
		public var routines:Array = [emptyPoker, emptyFacebook, loadMorePoker, loadMoreFacebook, tellAll, inviteAction, inviteDone];
		private var text1:com.script.text.TextBox;
		private var notfiyButton:com.script.poker.commonUI.asset.PlayerCTA;
		public var button:com.script.draw.Box;
		public static const embedTheFonts:Boolean = true;
		public function ListActionItem(p__1:int, p__2:* = null)
		{
			var l__5:flash.display.DisplayObject;
			if (p__2 != null){
				additional = p__2;
			}
			text1 = new TextBox(myriadTF, "", 12, 0, "left");
			text2 = new TextBox(myriadTF, "", 10, 3355443, "left");
			text3 = new TextBox(myriadTF, "", 11, 0, "left");
			text4 = new TextBox(myriadTF, "", 11, 0, "left");
			icons = new LAIcons();
			icons.x = 6;
			icons.y = 9;
			icons.mouseEnabled = false;
			icons.mouseChildren = false;
			var l__3:int;
			while(l__3 < icons.numChildren){
				l__5 = icons.getChildAt(l__3);
				l__5.visible = false;
				l__3++;
			}
			var l__4:Function = routines[p__1];
			l__4();
		}
		public function drawYellowBG():void
		{
			var l__1:Object = new Object();
			l__1.colors = [16777215, 16777164, 16777164, 11776893];
			l__1.alphas = [1, 1, 1, 1];
			l__1.ratios = [1, 1, 245, 245];
			bg = new Box(tX, tY, l__1, false);
			addChild(bg);
		}
		public function drawGrayBG():void
		{
			var l__1:Object = new Object();
			l__1.colors = [16777215, 14540253, 14540253, 10066329];
			l__1.alphas = [1, 1, 1, 1];
			l__1.ratios = [1, 1, 245, 245];
			bg = new Box(tX, tY, l__1, false);
			addChild(bg);
		}
		public function drawButton():void
		{
			var l__1:Object = new Object();
			l__1.colors = [16777215, 13421772];
			l__1.alphas = [1, 1];
			l__1.ratios = [0, 245];
			button = new Box(210, 33, l__1, false, true, 11);
			button.x = button.y = 5;
			button.buttonMode = true;
			button2 = new Box(210, 33, l__1, false, true, 11);
			button2.x = button2.y = 5;
			button2.buttonMode = true;
			addChild(button2);
			addChild(button);
			button2.visible = false;
		}
		public function butOver(p__1:flash.events.MouseEvent):void
		{
			button2.visible = true;
		}
		public function butOut(p__1:flash.events.MouseEvent):void
		{
			button2.visible = false;
		}
		public function drawOneField(p__1:String, p__2:String):void
		{
			text3.updateText(p__1);
			text3.x = 40;
			text3.y = 16;
			addChild(text3);
			text4.updateText(p__2);
			text4.x = 40;
			text4.y = 26;
			addChild(text4);
		}
		public function drawTwoFields(p__1:String, p__2:String, p__3:String = "000000"):void
		{
			text1.x = 38;
			text1.y = 17;
			text1.updateText(p__1);
			addChild(text1);
			text2.updateText(p__2);
			text2.x = 38;
			text2.y = 31;
			addChild(text2);
		}
		public function emptyPoker():void
		{
			drawYellowBG();
			icons.getChildByName("laQuestion").visible = true;
			icons.alpha = 0.33;
			addChild(icons);
			drawOneField("If you had buddies Playing Poker now,", "they would appear here.");
		}
		public function emptyFacebook():void
		{
			drawYellowBG();
			icons.getChildByName("laQuestion").visible = true;
			icons.alpha = 0.33;
			addChild(icons);
			drawOneField("If you had buddies that are online in Facebook,", "they would appear here.");
		}
		public function loadMorePoker():void
		{
			drawGrayBG();
			drawButton();
			icons.getChildByName("laGreenLoad").visible = true;
			addChild(icons);
			drawTwoFields("Load More Buddies...", (additional.toString() + " Total Friends Playing Poker Now"), "009900");
		}
		public function loadMoreFacebook():void
		{
			drawGrayBG();
			drawButton();
			icons.getChildByName("laBlueLoad").visible = true;
			addChild(icons);
			drawTwoFields("Load More Buddies...", (additional.toString() + " Total Friends Playing Poker Now"), "003399");
		}
		public function tellAll():void
		{
			drawGrayBG();
			icons.getChildByName("laBlue").visible = true;
			addChild(icons);
			drawTwoFields("Tell your friends...", "that you\'re playing now!", "003399");
			notifyButton = new PlayerCTA();
			notifyButton.ctaNotify.visible = true;
			notifyButton.ctaCards.visible = false;
			notifyButton.ctaInvite.visible = false;
			notifyButton.ctaJoin.visible = false;
			notifyButton.buttonMode = true;
			notifyButton.useHandCursor = true;
			notifyButton.x = 185;
			notifyButton.y = 20;
			addChild(notifyButton);
		}
		private function onButClick(p__1:flash.events.MouseEvent)
		{
			dispatchEvent(p__1.clone());
		}
		public function inviteAction():void                                                       
		{
			drawGrayBG();
			icons.getChildByName("laEnvelope").visible = true;
			icons.alpha = 0.6;
			addChild(icons);
			drawTwoFields("Invite friends to Poker.", "Play with more Friends!");
			inviteButton = new PlayerCTA();
			inviteButton.ctaInvite.visible = true;
			inviteButton.ctaCards.visible = false;
			inviteButton.ctaNotify.visible = false;
			inviteButton.ctaJoin.visible = false;
			inviteButton.buttonMode = true;
			inviteButton.useHandCursor = true;
			inviteButton.x = 185;
			inviteButton.y = 20;
			addChild(inviteButton);
		}
		public function inviteDone():void
		{
			drawGrayBG();
			icons.getChildByName("laEnvelope").visible = true;
			icons.alpha = 0.6;
			addChild(icons);
			drawTwoFields("No more invites left today.", "Send more tomorrow!", "666666");
		}
	}
}