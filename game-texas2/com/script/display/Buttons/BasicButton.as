// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.display.Buttons
{
	import flash.events.*;
	import flash.display.*;
	public class BasicButton extends flash.display.MovieClip
	{
		public var pipe:*;
		public var display:String;
		public var active:*;
		public var overAction:Function;
		public var outAction:Function;
		public var pad:*;
		public var field:*;
		public function BasicButton()
		{
			buttonMode = true;
			gotoAndStop(1);
			enable();
		}
		public function set text(p__1:*)
		{
			if (field){
				field.text = p__1;
			}
		}
		public function onOver(p__1:*)
		{
			gotoAndStop("over");
		}
		public function onOut(p__1:*)
		{
			gotoAndStop("standby");
		}
		public function onPressed(p__1:flash.events.MouseEvent):void
		{
			dispatchEvent(new flash.events.Event("PRESSED"));
		}
		public function stick()
		{
			pad.removeEventListener(flash.events.MouseEvent.MOUSE_OUT, onOut);
		}
		public function unstick()
		{
			pad.addEventListener(flash.events.MouseEvent.MOUSE_OUT, onOut);
		}
		public function disable()
		{
			gotoAndStop("disabled");
			pad.removeEventListener(flash.events.MouseEvent.MOUSE_OVER, onOver);
			pad.removeEventListener(flash.events.MouseEvent.MOUSE_OUT, onOut);
			pad.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, onPressed);
		}
		public function enable()
		{
			gotoAndStop("standby");
			pad.addEventListener(flash.events.MouseEvent.MOUSE_OVER, onOver);
			pad.addEventListener(flash.events.MouseEvent.MOUSE_OUT, onOut);
			pad.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, onPressed);
		}
		public function highlight()
		{
			if (active){
				filters = active;
			}
		}
		public function dehighlight()
		{
			filters = null;
		}
	}
}