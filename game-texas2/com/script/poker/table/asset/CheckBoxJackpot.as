// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import com.script.poker.table.*;
	import flash.display.*;
	import flash.events.EventDispatcher;
	public class CheckBoxJackpot extends flash.display.MovieClip
	{
		public var action:String;
		public var btn:com.script.poker.table.asset.PokerButton;
		public var checked:Boolean = false;
		public var iconMC:flash.display.MovieClip;
		public function CheckBoxJackpot()
		{
			iconMC.onState.visible = false;
			iconMC.offState.visible = true;
			iconMC.enabled = false;
		}
		public function init(p__1:String)
		{
			action = p__1;
			/*btn = new PokerButton(badaboom, "large", action.toUpperCase(), null, 115, 20);
			btn.y = 0;
			btn.x = 0;*/
			//addChildAt(btn, 0);
		}
		public function makeActive()
		{
			checked = true;
			iconMC.offState.visible = false;
			iconMC.onState.visible = true;
		}
		public function makeInactive()
		{
			checked = false;
			iconMC.offState.visible = true;
			iconMC.onState.visible = false;
		}
	}
}