// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.script.poker.table.asset.InviteEnv;
	import com.script.poker.table.asset.InviteInbox;
	import caurina.transitions.*;
	public class InviteController
	{
		public var inbox:com.script.poker.table.asset.InviteInbox;
		public var inbX:int = 380;
		public var aCoords:Array;
		private var mt:com.script.poker.table.TableView;
		public var hitter:flash.display.MovieClip;
		private var cont:flash.display.MovieClip;
		public var inbY:int = 480;
		public var inbCount:int;
		public var envCont:flash.display.Sprite;
		public function InviteController(p__1:com.script.poker.table.TableView, p__2:flash.display.MovieClip)
		{
			mt = p__1;
			aCoords = mt.aChickletCoorData;
			cont = p__2;
			initInviteInbox();
		}
		private function hitterActive(p__1:Boolean):void
		{
			inbox.count.text = inbCount.toString();
			inbox.visible = p__1;
			hitter.visible = p__1;
			hitter.mouseEnabled = p__1;
		}
		private function initInviteInbox():void
		{
			inbCount = mt.getPendingInviteCount();
			inbox = new InviteInbox(inbCount);
			inbX = 325;
			inbY = 510;
			inbox.x = inbX;
			inbox.y = inbY;
			inbox.visible = false;
			cont.addChild(inbox);
			envCont = new Sprite();
			cont.addChild(envCont);
			hitter = new MovieClip();
			hitter.graphics.beginFill(16711680, 0);
			hitter.graphics.drawRect((0 - inbox.width) / 2, (0 - inbox.height) / 2, inbox.width, inbox.height);
			hitter.graphics.endFill();
			hitter.x = inbox.x;
			hitter.y = inbox.y;
			hitter.useHandCursor = true;
			hitter.buttonMode = true;
			cont.addChild(hitter);
			hitter.addEventListener(MouseEvent.ROLL_OVER, envOver);
			hitter.addEventListener(MouseEvent.ROLL_OUT, envOut);
			hitter.addEventListener(MouseEvent.CLICK, invitePopup);
			checkInbox();
		}
		public function checkInbox():void
		{
			inbCount = mt.getPendingInviteCount();
			inbox.count.text = inbCount.toString();
			if (inbCount > 0){
				hitterActive(true);
			}
			if (inbCount < 1){
				hitterActive(false);
			}
		}
		private function envOver(p__1:flash.events.MouseEvent):void
		{
			Tweener.addTween(inbox, {scaleX:1.25, scaleY:1.25, time:0.25, transition:"easeOutBack"});
		}
		private function envOut(p__1:flash.events.MouseEvent):void
		{
			Tweener.addTween(inbox, {scaleX:1, scaleY:1, time:0.2, transition:"easeOutSine"});
		}
		private function invitePopup(p__1:flash.events.MouseEvent):void
		{
			mt.onInvitePressed();
		}
		public function updateInboxCount(p__1:int):void
		{
			inbCount = p__1;
			inbox.count.text = inbCount.toString();
			if (inbCount > 0){
				hitterActive(true);
			}
			if (inbCount < 1){
				hitterActive(false);
			}
		}
		public function sendBI(fromSit:int, toSit:int, bToYou:Boolean):void
		{
			var toX:int;
			var toY:int;
			var env:com.script.poker.table.asset.InviteEnv;
			var handleEnv = undefined;
			var killEnv = undefined;
			handleEnv = function():void
			{
				if (!bToYou){
					Tweener.addTween(env, {alpha:0, time:0.2, transition:"easeInSine"});
					Tweener.addTween(env, {scaleX:0.5, scaleY:0.5, time:0.2, transition:"easeInSine", onComplete:killEnv, onCompleteParams:[env]});
				} else if (bToYou){
					Tweener.addTween(env, {x:inbX, y:inbY, time:1, transition:"easeInOutSine"});
					Tweener.addTween(env, {alpha:0, time:0.2, delay:1, transition:"easeInSine"});
					Tweener.addTween(env, {scaleX:0.5, scaleY:0.5, time:0.2, delay:1, transition:"easeInSine", onComplete:killEnv, onCompleteParams:[env]});
				}
			};
			killEnv = function(p__1:com.script.poker.table.asset.InviteEnv):void
			{
				checkInbox();
				envCont.removeChild(p__1);
				p__1 = null;
			};
			
			var fromX:int = aCoords[fromSit][0];
			var fromY:int = aCoords[fromSit][1];
			toX = aCoords[toSit][0];
			toY = aCoords[toSit][1];
			env = new InviteEnv();
			env.scaleX = env.scaleY = env.alpha = 0.5;
			env.x = fromX;
			env.y = fromY;
			env.mouseEnabled = false;
			envCont.addChild(env);
			Tweener.addTween(env, {x:toX, y:toY, time:1.5, transition:"easeInOutSine", onComplete:handleEnv});
			Tweener.addTween(env, {alpha:1, time:0.2, transition:"easeInSine"});
			Tweener.addTween(env, {scaleX:1.25, scaleY:1.25, time:0.2, transition:"easeInSine"});
		}
		public function clearInvites():void
		{
			cont.removeChild(hitter);
			hitter = null;
			cont.removeChild(inbox);
			inbox = null;
			cont.removeChild(envCont);
			envCont = null;
		}
	}
}