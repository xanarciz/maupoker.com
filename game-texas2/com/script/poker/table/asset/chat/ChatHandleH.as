// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset.chat
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import caurina.transitions.*;
	public class ChatHandleH extends flash.display.Sprite
	{
		public function ChatHandleH():void
		{
			cont = null;
			onROv = undefined;
			onROu = undefined;
			onROv = function(p__1:flash.events.MouseEvent)
			{
				Tweener.addTween(cont, {alpha:1, time:0.25, transition:"easeOutSine"});
			};
			onROu = function(p__1:flash.events.MouseEvent)
			{
				Tweener.addTween(cont, {alpha:0.5, time:0.25, transition:"easeOutSine"});
			};
			cont = new Sprite();
			cont.graphics.beginFill(3355443, 1);
			cont.graphics.drawRect(0, -4, 16, 8);
			cont.alpha = 0.5;
			addChild(cont);
			cont.addEventListener(MouseEvent.ROLL_OVER, onROv);
			cont.addEventListener(MouseEvent.ROLL_OUT, onROu);
		}
	}
}