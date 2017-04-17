// This file was recovered by IMPERATOR �FLA v4 programmed by R. Schmahl
// for more information, please visit www.AVE-IMPERATOR.com
package com.script.display
{
	import flash.events.*;
	import flash.display.*;
	public class Toggle extends flash.display.Sprite
	{
		private var back:*;
		private var hotspot:*;
		private var _value:Boolean = false;
		private var over:*;
		private var disabled:*;
		public function Toggle(p__1:*, p__2:*, p__3:* = null, p__4:* = null)
		{
			back = new p__1();
			over = new p__2();
			over.visible = false;
			addChild(back);
			addChild(over);
			if (p__3){
				disabled = new p__3();
				disabled.visible = false;
				addChild(disabled);
			}
			if (p__4){
				hotspot = new p__4();
				hotspot.alpha = 0;
				addChild(hotspot);
			}
			enable();
		}
		public function disable()
		{
			if (disabled){
				disabled.visible = true;
			}
			buttonMode = false;
			mouseChildren = false;
			removeEventListener(flash.events.MouseEvent.CLICK, onClick);
		}
		public function enable()
		{
			if (disabled){
				disabled.visible = false;
			}
			buttonMode = true;
			mouseChildren = true;
			addEventListener(flash.events.MouseEvent.CLICK, onClick);
		}
		private function onClick(p__1:flash.events.MouseEvent)
		{
			if (_value){
				_value = false;
				over.visible = false;
			} else {
				_value = true;
				over.visible = true;
			}
		}
		public function get value()
		{
			return(_value);
		}
		public function set value(p__1:Boolean)
		{
			_value = !(p__1);
			onClick(null);
		}
	}
}