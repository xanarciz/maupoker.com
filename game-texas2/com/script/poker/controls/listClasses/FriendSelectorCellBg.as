// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.controls.listClasses
{
	import flash.display.*;
	import flash.events.EventDispatcher;
	import com.script.draw.*;
	public class FriendSelectorCellBg extends flash.display.Sprite
	{
		public function FriendSelectorCellBg()
		{
			var l__1:Object = new Object();
			l__1.colors = [16777215, 13421772, 6710886];
			l__1.alphas = [1, 1, 1];
			l__1.ratios = [0, 248, 248];
			var l__2:com.script.draw.Box = new Box(220, 59, l__1, false);
			addChild(l__2);
			this.mouseEnabled = false;
			this.useHandCursor = false;
			this.mouseChildren = false;
		}
	}
}