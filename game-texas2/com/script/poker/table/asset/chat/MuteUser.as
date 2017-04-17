// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.chat
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import caurina.transitions.*;
	import caurina.transitions.properties.*;
	import com.script.text.TextBox;
	public class MuteUser extends flash.display.MovieClip
	{
		public var zid:String;
		public var bg:flash.display.Sprite;
		public var blocked:Boolean;
		public var cBubble:com.script.poker.table.asset.chat.ChatIcon;
		public var userName:String;
		public var nameText:com.script.text.TextBox;
		public function MuteUser(p__1:String, p__2:String, p__3:Boolean):void
		{
			thisROv = undefined;
			thisROu = undefined;
			inName = p__1;
			inZid = p__2;
			inBlock = p__3;
			thisROv = function(p__1:flash.events.MouseEvent):void
			{
				Tweener.addTween(bg, {alpha:1, time:0.25, transition:"easeOutSine"});
			};
			thisROu = function(p__1:flash.events.MouseEvent):void
			{
				Tweener.addTween(bg, {alpha:0, time:0.2, transition:"easeOutSine"});
			};
			userName = inName;
			zid = inZid;
			blocked = inBlock;
			bgColor = 13369344;
			if (inBlock){
				bgColor = 52224;
			}
			bg = new Sprite();
			bg.graphics.beginFill(4473924, 1);
			bg.graphics.drawRect(0, 0, 120, 20);
			bg.graphics.endFill();
			bg.alpha = 0;
			addChild(bg);
			cBubble = new ChatIcon();
			cBubble.x = 4;
			cBubble.y = 3;
			cBubble.alpha = 1;
			cBubble.ciX.alpha = 0;
			addChild(cBubble);
			if (inBlock){
				cBubble.ciX.alpha = 1;
			}
			if (userName.length > 14){
				userName = (userName.substr(0, 11) + "...");
			}
			nameText = new TextBox(myriadTF, userName, 11, 16777215, "left", 95, false);
			nameText.x = 20;
			nameText.y = 11;
			addChild(nameText);
			this.addEventListener(MouseEvent.ROLL_OVER, thisROv);
			this.addEventListener(MouseEvent.ROLL_OUT, thisROu);
		}
		public function swapCheck():void
		{
			var l__1:Number = 0;
			if (blocked){
				l__1 = 0;
			}
			if (!blocked){
				l__1 = 1;
			}
			Tweener.addTween(cBubble.ciX, {alpha:l__1, time:0.15, transition:"easeOutSine"});
			blocked = !blocked;
		}
	}
	//var l__1:* = ColorShortcuts.init();
	//return(l__1);
}