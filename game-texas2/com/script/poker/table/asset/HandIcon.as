// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import flash.display.*;
	import flash.events.*;
	public class HandIcon extends flash.display.MovieClip
	{
		public var handGfx:flash.display.MovieClip;
		public function HandIcon()
		{
			handGfx.gotoAndStop(1);
		}
		public function toggler(p__1:Boolean)
		{
			if (p__1){
				handGfx.gotoAndStop(2);
			} else if (!(p__1)){
				handGfx.gotoAndStop(1);
			}
		}
	}
}