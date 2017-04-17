// This file was recovered by IMPERATOR FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.poker.table.asset
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	public class CardNumber extends flash.display.MovieClip
	{
		public var cnK:flash.display.MovieClip;
		public var cnQ:flash.display.MovieClip;
		public var cn10:flash.display.MovieClip;
		public var cn2:flash.display.MovieClip;
		public var cn3:flash.display.MovieClip;
		public var cn4:flash.display.MovieClip;
		public var cn5:flash.display.MovieClip;
		public var cn6:flash.display.MovieClip;
		public var cn7:flash.display.MovieClip;
		public var cn8:flash.display.MovieClip;
		public var cn9:flash.display.MovieClip;
		public var cnA:flash.display.MovieClip;
		public var cnJ:flash.display.MovieClip;
		public function CardNumber()
		{
			hideAll();
		}
		public function hideAll()
		{
			cn2.visible = false;
			cn3.visible = false;
			cn4.visible = false;
			cn5.visible = false;
			cn6.visible = false;
			cn7.visible = false;
			cn8.visible = false;
			cn9.visible = false;
			cn10.visible = false;
			cnJ.visible = false;
			cnQ.visible = false;
			cnK.visible = false;
			cnA.visible = false;
		}
		public function showNumber(p__1:String)
		{
			hideAll();
			var l__2:flash.display.MovieClip = MovieClip(this[("cn" + p__1)]);
			l__2.visible = true;
		}
	}
}