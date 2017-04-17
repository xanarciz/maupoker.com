// This file was recovered by IMPERATOR °FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.display.loaders
{
	import flash.events.*;
	import flash.display.*;
	public class Progressor extends flash.display.MovieClip
	{
		public var mcBar:flash.display.MovieClip;
		public function Progressor()
		{
			
			mcBar.scaleX = 0;
		}
		public function updateProgress(p__1:Number):void
		{
			var l__2:Number = Math.round(p__1);
			mcBar.scaleX = l__2;
		}
	}
}