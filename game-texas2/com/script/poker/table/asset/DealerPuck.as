// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import caurina.transitions.*;
	import caurina.transitions.properties.*;
	public class DealerPuck extends flash.display.MovieClip
	{
		public function DealerPuck():void
		{
			Tweener.addTween(this, {_DropShadow_alpha:1, _DropShadow_blurX:5, _DropShadow_blurY:5, _DropShadow_color:0, _Glow_strength:1, time:0.01});
		}
		public function movePuck(toX:int, toY:int):void
		{
			var hitEnd = undefined;
			hitEnd = function():void
			{
				Tweener.addTween(this, {_Glow_alpha:0, _Glow_blurX:0, _Glow_blurY:0, _Glow_color:16777215, _Glow_strength:0, time:0, transition:"linear"});
				Tweener.addTween(this, {_Glow_alpha:0.85, _Glow_blurX:4, _Glow_blurY:4, _Glow_color:16777215, _Glow_strength:2, _Glow_inner:true, time:0.25, transition:"linear"});
				Tweener.addTween(this, {_Glow_alpha:0, _Glow_blurX:0, _Glow_blurY:0, _Glow_color:16777215, _Glow_strength:0, time:0.25, delay:0.25, transition:"linear"});
			};
			Tweener.addTween(this, {scaleX:1.33, scaleY:1.33, time:0.2, transition:"easeOutSine"});
			Tweener.addTween(this, {x:toX, y:toY, time:0.5, transition:"easeInOutSine"});
			Tweener.addTween(this, {scaleX:1, scaleY:1, time:0.2, delay:0.3, transition:"easeOutSine", onComplete:hitEnd});
		}
	}
	//var l__1:* = FilterShortcuts.init();
	//return(l__1);
}