// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.DSGPanel
{
	import flash.events.*;
	import caurina.transitions.*;
	import flash.display.*;
	public class DSGItem extends flash.display.MovieClip
	{
		public var bg:*;
		public var overlay:*;
		public var ID:*;
		public function DSGItem()
		{
			mouseChildren = false;
			overlay.alpha = 0;
			stop();
			overlay.scaleX = 0;
			overlay.scaleY = 0;
			bg.alpha = 0.25;
			buttonMode = true;
		}
		public function disable()
		{
			bg.visible = false;
			buttonMode = false;
		}
		public function over()
		{
			caurina.transitions.Tweener.addTween(overlay, {alpha:1, scaleX:1.1, scaleY:1.1, time:0.5});
		}
		public function out()
		{
			caurina.transitions.Tweener.addTween(overlay, {alpha:0, scaleX:0, scaleY:0, time:0.5});
		}
		public function rollin()
		{
			caurina.transitions.Tweener.addTween(bg, {alpha:0.75, time:0.5});
		}
		public function rollout()
		{
			caurina.transitions.Tweener.addTween(bg, {alpha:0.25, time:0.5});
		}
	}
}