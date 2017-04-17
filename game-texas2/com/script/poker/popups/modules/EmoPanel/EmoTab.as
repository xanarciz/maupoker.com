// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.popups.modules.EmoPanel
{
	import flash.events.*;
	import flash.display.*;
	import com.script.poker.table.*;
	public class EmoTab extends flash.display.MovieClip
	{
		public var tabTop:*;
		public function EmoTab()
		{
		}
		public function setTabSpot(p__1:Number)
		{
			tabTop.x = (p__1) * 103;
			tabTop.mouseChildren = false;
			tabTop.buttonMode = true;
		}
		public function inactive()
		{
			tabTop.gotoAndStop(2);
		}
		public function active()
		{
			tabTop.gotoAndStop(1);
		}
	}
}