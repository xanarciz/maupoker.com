// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.buddy
{
	import flash.events.*;
	import caurina.transitions.*;
	import flash.net.*;
	import caurina.transitions.properties.*;
	import flash.display.*;
	import com.script.draw.*;
	import com.script.display.*;
	import flash.filters.*;
	public class InviteListItem extends flash.display.Sprite
	{
		public var statusIcon:StatusIcon;
		public var bg1:flash.display.Sprite;
		public var bg2:com.script.draw.Box;
		public var bg3:com.script.draw.Box;
		public var bg4:com.script.draw.Box;
		public var blank:BlankPlayer;
		public var zid:String;
		public var username:String;
		public var picurl:String;
		private var picSize:Number = 50;
		public var ldrPic:com.script.display.SafeImageLoader;
		public var shoutid:String;
		public var approved:String = "";
		public var listid:int;
		public var isSelected:Boolean = false;
		public function InviteListItem(p__1:int, p__2:String, p__3:String, p__4:String, p__5:String):void
		{
			listid = p__1;
			zid = p__2;
			shoutid = p__3;
			picurl = p__4;
			username = p__5;
			initListItem();
			initMouseEvents();
			this.mouseChildren = false;
		}
		public function initListItem():void
		{
			bg1 = new flash.display.Sprite();
			bg1.graphics.beginFill(16777215, 1);
			bg1.graphics.drawRect(0, 0, 205, 60);
			bg1.graphics.endFill();
			var l__1:flash.filters.DropShadowFilter = new flash.filters.DropShadowFilter(1, 90, 0, 0.75, 5, 5, 1, 3);
			var l__2:Array = new Array();
			l__2.AS3::push(l__1);
			bg1.filters = l__2;
			addChild(bg1);
			var l__3:Object = new Object();
			l__3.colors = [4144959, 789516];
			l__3.alpha = [1, 1];
			l__3.ratios = [0, 255];
			bg2 = new com.script.draw.Box(205, 60, l__3, false);
			addChild(bg2);
			var l__4:Object = new Object();
			l__4.colors = [8806, 3106];
			l__4.alpha = [1, 1];
			l__4.ratios = [0, 255];
			bg3 = new com.script.draw.Box(205, 60, l__4, false);
			bg3.alpha = 1; 
			addChild(bg3);
			var l__5:Object = new Object();
			l__5.colors = [21862, 7202];
			l__5.alpha = [1, 1];
			l__5.ratios = [0, 255];
			bg4 = new com.script.draw.Box(205, 60, l__5, false);
			bg4.alpha = 1;
			addChild(bg4);
			blank = new BlankPlayer();
			blank.x = blank.y = 5;
			addChild(blank);
			makeUserPic();
			var l__6:NameLine = new NameLine();
			l__6.tf.text = username;
			l__6.x = 57;
			l__6.y = 23;
			addChild(l__6);
			statusIcon = new StatusIcon();
			statusIcon.accept.visible = false;
			statusIcon.deny.visible = false;
			statusIcon.ignore.visible = false;
			addChild(statusIcon);
			statusIcon.x = 183;
			statusIcon.y = 4;
		}
		private function makeUserPic():void
		{
			var l__1:flash.net.URLRequest;
			var l__2:flash.display.Sprite;
			if (picurl != ""){
				l__1 = new flash.net.URLRequest(picurl);
				ldrPic = new com.script.display.SafeImageLoader("../Avatar/default.jpg");
				ldrPic.alpha = 0;
				ldrPic.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onPicLoadComplete);
				ldrPic.load(l__1);
				l__2 = new flash.display.Sprite();
				l__2.graphics.beginFill(0, 1);
				l__2.graphics.drawRect(5, 5, 50, 50);
				l__2.graphics.endFill();
				addChild(l__2);
				ldrPic.mask = l__2;
			}
		}
		private function onPicLoadComplete(p__1:flash.events.Event):void
		{
			var l__3:Number = 0;
			addChildAt(ldrPic, 5);
			var l__2:Number = ldrPic.width / ldrPic.height;
			if (l__2 > 1){
				l__3 = picSize / ldrPic.height;
				ldrPic.width = l__3 * ldrPic.width;
				ldrPic.height = l__3 * ldrPic.height;
			} else if (l__2 < 1){
				l__3 = picSize / ldrPic.width;
				ldrPic.width = l__3 * ldrPic.width;
				ldrPic.height = l__3 * ldrPic.height;
			} else {
				l__3 = picSize / ldrPic.width;
				ldrPic.width = l__3 * ldrPic.width;
				ldrPic.height = l__3 * ldrPic.height;
			}
			ldrPic.x = ((0 - (ldrPic.width >> 1)) + (picSize / 2));
			ldrPic.y = ((0 - (ldrPic.height >> 1)) + (picSize / 2));
			ldrPic.x = (ldrPic.x + 5);
			ldrPic.y = (ldrPic.y + 5);
			ldrPic.alpha = 1;
		}
		public function initMouseEvents():void
		{
		}
		public function thisOver(p__1:flash.events.MouseEvent):void
		{
			if (!isSelected){
				caurina.transitions.Tweener.addTween(bg3, {alpha:1, time:0.2, transition:"easeOutSine"});
			}
		}
		public function thisOut(p__1:flash.events.MouseEvent):void
		{
			if (!isSelected){
				caurina.transitions.Tweener.addTween(bg3, {alpha:0, time:0.2, transition:"easeOutSine"});
			}
		}
		public function makeSelected(p__1:Boolean):void
		{
			isSelected = p__1;
			bg3.alpha = 0;
			if (p__1){
				setApproval("");
				this.buttonMode = false;
				caurina.transitions.Tweener.addTween(bg4, {alpha:1, time:0.2, transition:"easeOutSine"});
			}
			if (!(p__1)){
				this.buttonMode = true;
				caurina.transitions.Tweener.addTween(bg4, {alpha:0, time:0.2, transition:"easeOutSine"});
			}
		}
		public function setApproval(p__1:String):void
		{
			switch(p__1){
				case "":
				{
					approved = "";
					statusIcon.accept.visible = false;
					statusIcon.deny.visible = false;
					statusIcon.ignore.visible = false;
					break;
				}
				case "approve":
				{
					approved = "approve";
					statusIcon.accept.visible = true;
					statusIcon.deny.visible = false;
					statusIcon.ignore.visible = false;
					break;
				}
				case "deny":
				{
					approved = "deny";
					statusIcon.accept.visible = false;
					statusIcon.deny.visible = true;
					statusIcon.ignore.visible = false;
					break;
				}
				case "ignore":
				{
					approved = "ignore";
					statusIcon.accept.visible = false;
					statusIcon.deny.visible = false;
					statusIcon.ignore.visible = true;
					break;
				}
			}
		}
	}
	//var l__1:* = caurina.transitions.properties.ColorShortcuts.init();
	//return(l__1);
}