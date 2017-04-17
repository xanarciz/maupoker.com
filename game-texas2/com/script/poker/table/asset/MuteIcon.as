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
	public class MuteIcon extends flash.display.MovieClip
	{
		public var muteGfx:flash.display.MovieClip;
		public function MuteIcon()
		{
		}
		public function toggler(p__1:Boolean)
		{
			if (p__1){
				Tweener.addTween(muteGfx, {_color:16711680, time:0.01});
			} else if (!(p__1)){
				Tweener.addTween(muteGfx, {_color:1118481, time:0.01});
			}
		}
	}
	//var l__1:* = ColorShortcuts.init();
	//return(l__1);
}