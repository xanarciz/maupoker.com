// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import flash.display.*;
	import flash.events.*;
	public class Suit extends flash.display.MovieClip
	{
		public var diamond:flash.display.MovieClip;
		public var spade:flash.display.MovieClip;
		public var club:flash.display.MovieClip;
		public var heart:flash.display.MovieClip;
		public function Suit()
		{
			hideAll();
		}
		public function hideAll():void
		{
			diamond.visible = false;
			club.visible = false;
			heart.visible = false;
			spade.visible = false;
		}
		public function showSuit(p__1:String):void
		{
			hideAll();
			if ((p__1) == "diamond"){
				diamond.visible = true;
			} else if ((p__1) == "club"){
				club.visible = true;
			} else if ((p__1) == "heart"){
				heart.visible = true;
			} else if ((p__1) == "spade"){
				spade.visible = true;
			}
		}
	}
}